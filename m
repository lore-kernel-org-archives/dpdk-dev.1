Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D46C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD2240649;
	Mon, 11 Aug 2025 12:28:21 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 7A3E4400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:28:20 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-7074bad055eso25519676d6.3
 for <dev@dpdk.org>; Mon, 11 Aug 2025 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754908100;
 x=1755512900; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eRF0kx238HGt5UKacgLXfIHVYBgq5kjbsSTzEECXPok=;
 b=2FyiUNoQi71VWO+tFhcquh6pKL/p7yMxNWMcbwcrc5/9e0X87NgtEnqTZwcAckXH95
 EU4MbRElU8T3wDagAXN+ndwNiuNIScUTcRn9q15rBPU8l0Gza0rKhMgAbFWeEWxnzURR
 8fDFOTz/uy2HJDvA9UbcCb0yMhfJ/Nvk+P3lCnsxgh5G0UOxfZsYRiJAsJnBrYPf5VQv
 +5utMO9KfVzOePDlO7A+GRwxmOxr6HFg1Wq+lOJnUoKsU0uLH0AjFSRnKqwYFttxcHmA
 N+3wIR/bKnolN7x2kDYCzYG9P3fW21QIKqLhLGdLBP2MEHsEYJD9PrIO8KoGAoCdX+b6
 aBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908100; x=1755512900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRF0kx238HGt5UKacgLXfIHVYBgq5kjbsSTzEECXPok=;
 b=QpnzudV0WxkC8yUx+x8Sr0ayRUzzyLbnExdlO/E1WvTyJ1JQZyEe/SnORHmnen7c3m
 VvYleeON2JGbQxMG22smd5oxUuWT7LNye1ueuDDXibscOTrO65aKiUFokN2IhgA2xbQ4
 uFkf1Klzfex4o0zN3Mx8odRn6eRzN1lhPYbVljS4tLQK7bmbQVyH69K2Zcm4yUT3D+id
 IrPSs2cQhn8+iMmqWcTORnBWMO5EUDSVNxkeT+uNidizAKyWOzxpPX4Vvw5BT8xVpRra
 wWdCdEHWQeYZFBMuTgcwRDZFPckxdDZLops/rLJqj6Z9W1BhGue7CLyjXhuSMnGQs/zi
 Wycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW20AifNJYqkj3NyogAjVooCgsIH8fWBrD7fqZziq17Gz9HBVLeaAGw453UfztB8pByn9U=@dpdk.org
X-Gm-Message-State: AOJu0Yy53uPpCW2AtxfUu1Nze6nHPWSSHELA8/vSMwdTgLm9ZzVZnj6g
 WOEqVxE8tAPalUsu8M1Fk+6lHeL7GTCEPdSLH49PSMXn/uOtnnHuech/0PN9InzPXefpp0AiP8d
 /6Aru3ODDzJ5Q89hsFgTtRHsE9X3IsLo7AMxqOmpUVg==
X-Gm-Gg: ASbGncs0frQ4cSYUJFlSJnVKpi5oZ9VYK9537wkj03h4FSSHrz1YXIyBU7ddj1BoW9h
 t9jlbJxmhxzwM28/Z9d1Q8gv8un9eBQn5R84/GmSUadHjrr3t6KQTcJyfzZOsXgrgj/lgnrLuYP
 qga7QnhBroKYsiEbl9IIuAPNUBk/6WdvF/x78FxR5w5nvhU9vmKs4VhNwkYc5BR+XBr9ASXo0Fq
 Lobf5PKus+TueQ=
X-Google-Smtp-Source: AGHT+IEbGk3cHHvGXNBdFezU09dj2wsp3G9qnNi0XRHWHe+bbD26x1ckiDX/+djnc81Z5AgX9z6TT28gaPv6tC3tqfo=
X-Received: by 2002:a05:6214:2466:b0:6fb:1c3:f527 with SMTP id
 6a1803df08f44-7099a4833a2mr194562116d6.39.1754908099748; Mon, 11 Aug 2025
 03:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250729143420.0fd7b627@hermes.local>
 <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808083204.0174ac6b@hermes.local>
 <PH7PR12MB8596785BCD76C0436A1F34898228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596785BCD76C0436A1F34898228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 15:28:08 +0500
X-Gm-Features: Ac12FXwknR6bIxOADWq7aLltFvoQWOmkRbPhjs956Qk44-eWvNyqKLc-uENO2rg
Message-ID: <CA++2-x75WVrD+x8wZeH7XNsemOZYcKMUBYB9GM-v--6AxVetmQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>, 
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000e63bc0063c146182"
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

--000000000000e63bc0063c146182
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vipin,

These crashes are specific to the testpmd primary and testpmd
secondary application.
Please check
https://patches.dpdk.org/project/dpdk/patch/20250804113322.53650-1-14pwcse1=
224@uetpeshawar.edu.pk/
The details are provided over there.

Regards,
Khadem

On Mon, Aug 11, 2025 at 3:19=E2=80=AFPM Varghese, Vipin <Vipin.Varghese@amd=
.com>
wrote:

> [Public]
>
> Snipped
>
> > > Since somehow the email are split it is difficult to see the indexing
> > >
> > > >
> > > > Caution: This message originated from an External Source. Use prope=
r
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > Hi Stephen,
> > > >
> > > > Many thanks for diving deeper into the issue and sharing the
> insights.
> > > >
> > > > I agree. given that the primary tears down all the devices on exit,
> > > > the secondary is left with dangling pointers and inconsistent state=
.
> > >
> > > Secondary if PMD should not be attempting to cleanup (especially for
> ethdev_ptr
> > shared from primary) I agree to that.
> > > But should not be covered in library or PMD. While cleanup for other
> > > needs to be done properly
> > >
> > >  Without a mechanism to notify or synchronize that teardown,
> > >
> > > You already have health check added in the code for identify if prima=
y
> is still alive
> > or not..
> > > There used to be MP thread spawned which actually piggy back the
> > > communication. Is this broken? Can you please point to git
> >
> > There is no easy way to handle the case where primary crashes; leaving
> > secondary process with pointers to dead data.
>
> Thank you for sharing, but as shared the other threads (this topic has 3)=
,
> the reason for the patch is because once the primary is dead it causes
> secondary to crash (segment fault).
>
> As shared in earlier email at least till 22.11 LTS and 23.03 (as it was m=
y
> last testing with multi-process) I did not encounter these.
>
> @Khadem Ullah can you please share which version of DPDK you are noticing
> this failure?
>


--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--000000000000e63bc0063c146182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Vipin,=C2=A0<br><br><div>These crashes are specific to =
the testpmd primary and testpmd secondary=C2=A0application.=C2=A0</div><div=
>Please check <a href=3D"https://patches.dpdk.org/project/dpdk/patch/202508=
04113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/">https://patches.dpdk.org/=
project/dpdk/patch/20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/</=
a></div><div dir=3D"ltr"><div>The details are provided over there.=C2=A0<br=
><br></div><div>Regards,=C2=A0</div><div>Khadem</div></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 11, =
2025 at 3:19=E2=80=AFPM Varghese, Vipin &lt;<a href=3D"mailto:Vipin.Varghes=
e@amd.com" target=3D"_blank">Vipin.Varghese@amd.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">[Public]<br>
<br>
Snipped<br>
<br>
&gt; &gt; Since somehow the email are split it is difficult to see the inde=
xing<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Caution: This message originated from an External Source. Us=
e proper<br>
&gt; &gt; &gt; caution when opening attachments, clicking links, or respond=
ing.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Many thanks for diving deeper into the issue and sharing the=
 insights.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I agree. given that the primary tears down all the devices o=
n exit,<br>
&gt; &gt; &gt; the secondary is left with dangling pointers and inconsisten=
t state.<br>
&gt; &gt;<br>
&gt; &gt; Secondary if PMD should not be attempting to cleanup (especially =
for ethdev_ptr<br>
&gt; shared from primary) I agree to that.<br>
&gt; &gt; But should not be covered in library or PMD. While cleanup for ot=
her<br>
&gt; &gt; needs to be done properly<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 Without a mechanism to notify or synchronize that teardown,=
<br>
&gt; &gt;<br>
&gt; &gt; You already have health check added in the code for identify if p=
rimay is still alive<br>
&gt; or not..<br>
&gt; &gt; There used to be MP thread spawned which actually piggy back the<=
br>
&gt; &gt; communication. Is this broken? Can you please point to git<br>
&gt;<br>
&gt; There is no easy way to handle the case where primary crashes; leaving=
<br>
&gt; secondary process with pointers to dead data.<br>
<br>
Thank you for sharing, but as shared the other threads (this topic has 3), =
the reason for the patch is because once the primary is dead it causes seco=
ndary to crash (segment fault).<br>
<br>
As shared in earlier email at least till 22.11 LTS and 23.03 (as it was my =
last testing with multi-process) I did not encounter these.<br>
<br>
@Khadem Ullah can you please share which version of DPDK you are noticing t=
his failure?<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--000000000000e63bc0063c146182--
