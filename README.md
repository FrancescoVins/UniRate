# 🚀 UniRate - Deployment Guide

## 📦 What's Included

```
unirate-deploy/
├── index.html                  # Main homepage (auto-redirects to EN/IT)
├── university.html             # Dynamic template (all universities)
├── en/
│   ├── index.html             # English homepage
│   └── reviews.html           # English reviews page
├── it/
│   ├── index.html             # Italian homepage
│   └── reviews.html           # Italian reviews page
├── bocconi.html               # Static page (SEO)
├── harvard.html               # Static page (SEO)
├── luiss.html                 # Static page (SEO)
├── fudan.html                 # Static page (SEO)
└── README.md                  # This file
```

---

## ✅ Features Ready

- ✅ **9,997 universities** in database
- ✅ **Dynamic pages** for all universities
- ✅ **Review system** with 8 rating categories
- ✅ **Automatic ranking** calculation
- ✅ **English + Italian** versions
- ✅ **Global search** across all universities
- ✅ **Mobile responsive**
- ✅ **Connected to Supabase** database

---

## 🚀 Quick Deploy (5 minutes)

### Step 1: Push to GitHub

```bash
# Navigate to the folder
cd /path/to/unirate-deploy

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - UniRate MVP"

# Add your GitHub repository
git remote add origin https://github.com/FrancescoVins/UniRate.git

# Push
git branch -M main
git push -u origin main
```

### Step 2: Deploy on Vercel

1. Go to https://vercel.com/dashboard
2. Click **"Add New Project"**
3. Click **"Import Git Repository"**
4. Select **UniRate** repository
5. Click **"Deploy"**
6. Wait 30 seconds
7. **DONE!** Your site is live at `unirate.vercel.app`

---

## 🌐 How It Works

### Homepage
- Auto-detects browser language
- Redirects to `/en/` or `/it/`
- Search bar searches all 9,997 universities
- Featured universities (Bocconi, Harvard, LUISS, Fudan)

### University Pages
Two types:

**1. Static pages** (SEO optimized):
- `bocconi.html`
- `harvard.html`
- `luiss.html`
- `fudan.html`

**2. Dynamic template** (all other universities):
- `university.html?name=stanford`
- `university.html?name=mit`
- Works for ANY university in database

### Reviews
- Users write reviews (8 categories)
- Saves to Supabase
- Calculates ranking automatically
- Shows on university page immediately

---

## 🔧 Database

**Supabase Project:** gdtgazxqkbqdg1ejmfjh

**Tables:**
1. `universities` - 9,997 rows
   - name, country, state_province, web_pages
   - rating, review_count, cost_level

2. `reviews` - User-generated
   - overall_rating, teaching_quality, course_content
   - career_services, networking, facilities
   - student_life, city_lifestyle
   - review_text, pros, cons

---

## 📊 Next Steps

### Immediate (Week 1):
- [ ] Custom domain (buy unirate.com)
- [ ] Google AdSense setup
- [ ] Share with first users
- [ ] Collect first 50 reviews

### Short-term (Month 1-2):
- [ ] SEO optimization
- [ ] Social media presence
- [ ] Email newsletter
- [ ] Blog section

### Medium-term (Month 3-6):
- [ ] AI University Advisor (Premium €9.99/mo)
- [ ] University advertising platform
- [ ] Spanish, French, German languages

---

## 💰 Monetization

**Phase 1:** Google AdSense (passive)
**Phase 2:** AI Premium features (€9.99/mo)
**Phase 3:** University ads (€299-999/mo)

---

## 🆘 Support

Need help? Just ask Claude! 🤖

```
"How do I add Google AdSense?"
"How do I change the design?"
"How do I add more universities?"
```

---

## 🎉 You're Ready!

1. Push to GitHub
2. Deploy on Vercel  
3. Share with users
4. Start collecting reviews!

**Let's go! 🚀**
