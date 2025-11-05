Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3CCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:46:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50E254067A;
	Wed,  5 Nov 2025 17:46:21 +0100 (CET)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) by mails.dpdk.org (Postfix) with ESMTP id 72E1B4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:46:19 +0100 (CET)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-5dbd2b7a7e3so52016137.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 08:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762361179;
 x=1762965979; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2u/BjV+BOUFia687/KN/frRzTCZN5x9l4PlJP+1gqiU=;
 b=azLStuJ035rErbSsUG0HQMxP8/D4wVOKFPOvngiAYsgWba2u4kUc2H+Z4lrP4ubTN7
 ShIwF9P93eVjoaDjMHs2ALhh9Ram6W4QJWv2+v/764lmmb17QcR91KB9gOwg6tj/bPTy
 NTPXeYnHPGnu6xDeSUziKzk8h1fa4wrjRzw1S0rcxm0b5xAR1isoaCt6dx5yl8u9u26R
 vWpCK7FaZlHq5PHBQdmxMx7wcXp6z3rc41uhob0082RacqIQtYZxdXGU19KYLoOCQCvx
 ByCO2FLKFWp+GQ7ssGRTDN1ognAswjzY+zlMgmN2a5m7MIDWjLS9k8hEMtKMpSvBDXWT
 /kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762361179; x=1762965979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2u/BjV+BOUFia687/KN/frRzTCZN5x9l4PlJP+1gqiU=;
 b=upzMv0DZNjnB0138RG7LZMSdJK/+VWlhqRzCkcr3LTz86+6nozMljq/dwWbwobTwdg
 bwN6SHK4LGbg+cpyyVhZvKBlLR+E26q0PnZEk7qsp6SDwFFoMrr3T4Qk/S4E5H3BdT8v
 2xAtq2vfwGNl2fl8oeRcXNzxvBtzpYeGTsZ6pH4LZ+I/728p3F1jGjkYzSO+pQcivZEz
 viI/9jbbqjxgXKTdGGlFFpr4Vet/PNV8F2+xCYLN9yVNWjv+X8isS8uh71GaaFd0Abaz
 in/5KFwLJ3vooOilxoeC/uVkGiBJhFTJhx0f34dAx70EMs3dHObD/5CIr1N6sm0vG4+J
 jDxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9jURQRkf5ij4Gu8Y5dQabbk637POyg/LzpMSQ/9aA5KY0uosQyoTkogexy7pYyPwei4c=@dpdk.org
X-Gm-Message-State: AOJu0YzeTd9aeXSpM9eERyhjfCk+xhEl2n4syOocP251uFwhNWxwYrFd
 LfsltxR2TGqIS4IPD+3tJ3v+faIMwQLzSMKR1mudd8/sszphH9WrRoepULFqi84G2eRKmqW8O4X
 YaTSEPrI6GsSpjzOBcVnCy/3ZLHa2lToY5ERrRf1MWQ==
X-Gm-Gg: ASbGncujZrfg678HFY2KsoQBnMHh8UGq+z0n8rWdJrpsWb+PmNH6zOS9pgjnADLO1LC
 FG/dKUmbr+awH6LDMWr3dleRlECC6RIcYvxYBkeKeDW5A+ZQI9/MpWPcHi3Wb4s+gLfX2HH1Hut
 1aaEhK3MdDoPwXPl5pRqdoJ43O2OJ5/3MkFSrhB/6ix8fmrDZZWlSYSM20S2ZBDp7aLiUFSfbGg
 TlzjVFnHae3CLwyETpukK6OueaNQiQ+XMjP6BDBJQKQkZK+zvDvSGNuyCu9sik=
X-Google-Smtp-Source: AGHT+IGIZhEnkwccPvSwGFCb3cjrV5ZQPrOWQXfezHXJ7CJQ/YEQ2Bx+WrcMzDQIwPw75HmX0oRattzVBS9+mwV4oCI=
X-Received: by 2002:a05:6102:e11:b0:5db:d7a5:ba18 with SMTP id
 ada2fe7eead31-5dd8923fcc8mr1532851137.44.1762361178498; Wed, 05 Nov 2025
 08:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20251103193038.135022-1-stephen@networkplumber.org>
 <aQkJMHX6NWmZcJEd@bricha3-mobl1.ger.corp.intel.com>
 <2829936.sGnKIMrFRI@thomas>
 <aQt-hNN9Zkdr-BjE@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aQt-hNN9Zkdr-BjE@bricha3-mobl1.ger.corp.intel.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 5 Nov 2025 08:46:07 -0800
X-Gm-Features: AWmQ_blmJlCEvjtDeLDvEthGQKgPbOsU2CuriaKrtQukiOxRP7xDgM4kEshbEgY
Message-ID: <CAOaVG17EcSkRTkXNundxXymFid=m-EMXrYRNnMpO=NpJq6dkvg@mail.gmail.com>
Subject: Re: [PATCH] doc: update FreeBSD python version
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000002b6240642dbb01e"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--00000000000002b6240642dbb01e
Content-Type: text/plain; charset="UTF-8"

I just wanted to be able to cut and paste from documentation to setup test
build VM.

On Wed, Nov 5, 2025, 08:42 Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Wed, Nov 05, 2025 at 04:13:39PM +0100, Thomas Monjalon wrote:
> > 03/11/2025 20:57, Bruce Richardson:
> > > On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote:
> > > > The version python used in current FreeBSD stable release 14.3
> > > > is now 3.11. Update documentation accordingly.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > ---
> > > >  doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst
> b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > index f98292bf41..c8b2964a4b 100644
> > > > --- a/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > +++ b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > @@ -16,16 +16,16 @@ The following FreeBSD packages are required to
> build DPDK:
> > > >  * meson
> > > >  * ninja
> > > >  * pkgconf
> > > > -* py38-pyelftools
> > > > +* py311-pyelftools
> > > >
> > > >  .. note:
> > > >
> > > >    The specific package for pyelftools is dependent on the version
> of python in use,
> > > > -  Python 3.8 being the version at type of writing, hence the
> ``py38`` prefix.
> > > > +  Python 3.11 being the version at type of writing, hence the
> ``py311`` prefix.
> > > >
> > > >  These can be installed using (as root)::
> > > >
> > > > -  pkg install meson pkgconf py38-pyelftools
> > > > +  pkg install meson pkgconf py311-pyelftools
> > > >
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > I always find the python version included in the packages annoying,
> but I
> > > don't think there is anything we can do about this. Thanks for the
> update.
> >
> > Do we really want to update the doc after each upgrade?
> > This version is not the truth, it depends on which FreeBSD version is
> installed.
> >
> Python comes from the ports collection, not the base system, so it's
> independent of the BSD version. Therefore the commands here should work on
> all supported BSD versions.
>
> /Bruce
>

--00000000000002b6240642dbb01e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I just wanted to be able to cut and paste from documentat=
ion to setup test build VM.</div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, 2025, 08:42=
 Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com">bruce.r=
ichardson@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Wed, Nov 05, 2025 at 04:13:39PM +0100, Thomas Monjalon wrote:<br>
&gt; 03/11/2025 20:57, Bruce Richardson:<br>
&gt; &gt; On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote=
:<br>
&gt; &gt; &gt; The version python used in current FreeBSD stable release 14=
.3<br>
&gt; &gt; &gt; is now 3.11. Update documentation accordingly.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:steph=
en@networkplumber.org" target=3D"_blank" rel=3D"noreferrer">stephen@network=
plumber.org</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/gui=
des/freebsd_gsg/build_dpdk.rst<br>
&gt; &gt; &gt; index f98292bf41..c8b2964a4b 100644<br>
&gt; &gt; &gt; --- a/doc/guides/freebsd_gsg/build_dpdk.rst<br>
&gt; &gt; &gt; +++ b/doc/guides/freebsd_gsg/build_dpdk.rst<br>
&gt; &gt; &gt; @@ -16,16 +16,16 @@ The following FreeBSD packages are requi=
red to build DPDK:<br>
&gt; &gt; &gt;=C2=A0 * meson<br>
&gt; &gt; &gt;=C2=A0 * ninja<br>
&gt; &gt; &gt;=C2=A0 * pkgconf<br>
&gt; &gt; &gt; -* py38-pyelftools<br>
&gt; &gt; &gt; +* py311-pyelftools<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 .. note:<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 The specific package for pyelftools is dependen=
t on the version of python in use,<br>
&gt; &gt; &gt; -=C2=A0 Python 3.8 being the version at type of writing, hen=
ce the ``py38`` prefix.<br>
&gt; &gt; &gt; +=C2=A0 Python 3.11 being the version at type of writing, he=
nce the ``py311`` prefix.<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 These can be installed using (as root)::<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; -=C2=A0 pkg install meson pkgconf py38-pyelftools<br>
&gt; &gt; &gt; +=C2=A0 pkg install meson pkgconf py311-pyelftools<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; Acked-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson=
@intel.com" target=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.com=
</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; I always find the python version included in the packages annoyin=
g, but I<br>
&gt; &gt; don&#39;t think there is anything we can do about this. Thanks fo=
r the update.<br>
&gt; <br>
&gt; Do we really want to update the doc after each upgrade?<br>
&gt; This version is not the truth, it depends on which FreeBSD version is =
installed.<br>
&gt; <br>
Python comes from the ports collection, not the base system, so it&#39;s<br=
>
independent of the BSD version. Therefore the commands here should work on<=
br>
all supported BSD versions.<br>
<br>
/Bruce<br>
</blockquote></div>

--00000000000002b6240642dbb01e--
