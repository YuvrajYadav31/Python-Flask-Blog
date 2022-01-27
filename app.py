from flask import Flask, render_template, request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from flask_mail import Mail 
import json
import os
import math
from datetime import datetime

with open('config.json', 'r') as c:
    parameters = json.load(c)["parameters"]

local_server = False 
app = Flask(__name__,template_folder="template")
app.secret_key = 'super-secret-key'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['UPLOAD_FOLDER'] = parameters['upload_location']
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = parameters['gmail-user'],
    MAIL_PASSWORD=  parameters['gmail-password']
)
mail =Mail(app)

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['prod_uri']

db = SQLAlchemy(app)


class Contact(db.Model):
    __tablemame__ = "contacts"
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_no = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

    def __init__(self, name, phone_no, msg, email, date):
        self.name = name
        self.phone_no = phone_no
        self.msg = msg
        self.date = date
        self.email = email


class Posts(db.Model):
    __tablename__ = "posts"
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(200), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    code = db.Column(db.String(1000), nullable=True)
    description = db.Column(db.String(200), nullable=False)
    language = db.Column(db.String(25), nullable=True)

    def __init__(self, title, slug, content, date, tagline, language,code,description):
        self.title = title
        self.slug = slug
        self.content = content
        self.date = date
        self.tagline = tagline
        self.language = language
        self.description = description
        self.code = code

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(parameters['no_of_post']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(parameters['no_of_post']):(page-1)*int(parameters['no_of_post'])+int(parameters['no_of_post'])]
    if page==1:
        prevpage = "#"
        nextpage = "/?page="+ str(page+1)
    elif page==last:
        prevpage = "/?page="+ str(page-1)
        nextpage = "#"
    else:
        prevpage = "/?page="+ str(page-1)
        nextpage = "/?page="+ str(page+1)
    
    flash(u"Welcome to Coding Shinobi. Thanks for visiting!","info")
    return render_template('index.html', parameters=parameters,prevpage=prevpage,nextpage=nextpage,posts=posts)


   


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", parameters=parameters, post=post)

@app.route("/about")
def about():
    return render_template('about.html', parameters=parameters)


@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():

    if ('user' in session and session['user'] == parameters['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', parameters=parameters, posts = posts)

    if request.method=='POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == parameters['admin_user'] and userpass == parameters['admin_password']):
            #set the session variable
            session['user'] = username
            posts = Posts.query.all()
            flash(u"Login Successful! Welcome Admin.","info")
            return render_template('dashboard.html', parameters=parameters, posts = posts)   
        flash(u"Invalid Username/Password!","danger")
    return render_template('login.html', parameters=parameters)


@app.route("/edit/<string:sno>", methods = ['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == parameters['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tagline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            code = request.form.get('code')
            description = request.form.get('description')
            language = request.form.get('language')
            date = datetime.now()

            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content,description=description,code= code,language=language,tagline=tagline, date=date)
                db.session.add(post)
                db.session.commit()
                flash(u"Post Added Successfully!","success")
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tagline
                post.date = date
                post.code = code
                post.description = description
                post.language = language
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', parameters=parameters, post=post, sno=sno)


@app.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == parameters['admin_user']):
        if (request.method == 'POST'):
            f= request.files['File1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename) ))
            flash (u"Uploaded Successfully!","success")
            return redirect("/dashboard")



@app.route("/logout")
def logout():
    session.pop('user')
    flash(u"You have been logged out!","warning")
    return redirect('/dashboard')

@app.route("/delete/<string:sno>", methods = ['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == parameters['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        flash(u"Post deleted successfully!","warning")
    return redirect('/dashboard')



@app.route("/contact", methods = ['GET', 'POST'])
def contact():
            if(request.method=='POST'):
                name = request.form.get('name')
                email = request.form.get('email')
                phone = request.form.get('phone')
                message = request.form.get('message')
                entry = Contact(name=name, phone_no = phone, msg = message, date= datetime.now(),email = email )
                db.session.add(entry)
                db.session.commit()

                try:
                    mail.send_message('New message from ' + name,
                              sender=email,
                              recipients = [parameters['gmail-user']],
                              body = message + "\n" + phone
                              )
                    flash(u"Thanks for submitting your details! We will get back to you soon.")          
                except Exception as e:
                     print("Invalid Credentials")
            return render_template('contact.html', parameters=parameters)

app.run(debug=False)
