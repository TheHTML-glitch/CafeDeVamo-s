from flask import Flask, render_template_string

app = Flask(__name__)

entrepreneurs = [
    {
        "name": "Aanya Sharma",
        "type": "Young Girl Entrepreneur",
        "story": "Aanya started a handmade jewelry brand at 16. From Instagram to pop-up markets, she scaled her business sustainably and now mentors other young girls."
    },
    {
        "name": "Kabir Mehta",
        "type": "Young Boy Entrepreneur",
        "story": "Kabir launched a mobile app for student scheduling when he was 17. He now partners with schools to boost student productivity."
    },
    {
        "name": "Nidhi Rao",
        "type": "Woman Entrepreneur",
        "story": "Nidhi founded 'GreenBite', a sustainable food packaging startup. Her brand now supplies eco-friendly boxes to top cafes across the UAE."
    },
    {
        "name": "Ravi Malhotra",
        "type": "Man Entrepreneur",
        "story": "Ravi created a tech repair business with home service at just 19. Today, his startup operates in 3 cities with 40+ employees."
    }
]

@app.route('/')
def homepage():
    html = '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Startup Hub</title>
        <style>
            body {
                font-family: monospace;
                background-image: url('https://png.pngtree.com/thumb_back/fh260/background/20210416/pngtree-business-tech-startup-blue-contemporary-image_627598.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
                margin: 0;
                padding: 0;
                color: #fff;
            }
            h1 {
                text-align: center;
                padding: 20px;
                background: rgba(0, 0, 0, 0.6);
                margin: 0;
                font-size: 30px;
            }
            .grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 25px;
                padding: 40px;
                background-color: rgba(0, 0, 0, 0.5);
            }
            .box {
                background: rgba(255, 255, 255, 0.15);
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px #000;
                transition: 0.3s ease;
            }
            .box:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: scale(1.03);
            }
            .type {
                font-weight: bold;
                color: #ffdeba;
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
        <h1>☕ Tech + Coffee + Sustainability + Entrepreneurship 🌱</h1>
        <div class="grid">
            {% for person in entrepreneurs %}
            <div class="box">
                <div class="type">{{ person.type }}</div>
                <h2>{{ person.name }}</h2>
                <p>{{ person.story }}</p>
            </div>
            {% endfor %}
        </div>
    </body>
    </html>
    '''
    return render_template_string(html, entrepreneurs=entrepreneurs)

if __name__ == '__main__':
    app.run(debug=True)
