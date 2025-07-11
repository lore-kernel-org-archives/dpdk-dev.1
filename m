Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 15:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD317406B6;
	Fri, 11 Jul 2025 17:04:25 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 120154025D
 for <dev@dpdk.org>; Fri, 11 Jul 2025 17:04:24 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3141b84bf65so2228968a91.1
 for <dev@dpdk.org>; Fri, 11 Jul 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752246263; x=1752851063; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYzoZY3calQiyUY+gIxLyzrC+BaPINtnWY8Rf9g/PkQ=;
 b=TyFVAUwke0QMJV7CZz1t6FvKl1ryG76GXqVK7V6nTyMGHeF9K+iATyCQ8WNm6Y9oax
 432t/+Y19ROjPsd8OXG99Vy5uJx9ZN+ICv1k2XqLH8jtckM0qaY/M8V3QuPlsr6QdYIL
 UjKhp+NZwoy55T85fewmoyC0N9NAsdRZcN15Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246263; x=1752851063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZYzoZY3calQiyUY+gIxLyzrC+BaPINtnWY8Rf9g/PkQ=;
 b=CvcgN3UFX4QXp81iNdgyeSfc1qU3BmU5HS8amIosOgXRY9DsJyF8QfYWpsnPpEn/6r
 KWPdemuCk0GduR8aLePm/XXGFBzCIzIo6ONgEf/3GcWqBBkCMWrilqrMmCyBfBzZrjqK
 O83vhJTLhmJFNQkknqB/8AEDsnIEyQhQEnAxzkFBdW+3Uq10EJdtDAsGDSrMIvux1Mkw
 0nnu13JuTorKqShi19BsEZOcLSX8PX2mmIHhFNbBp3eNnGqAb4AFvn78lx/ojbGZtrMl
 7EOoCJDsjn2gpC/xzbGMhwhSvJRzozS7hcCRad+FBSsGVGnUF0DHfyqy8q4kcdJ+QpU2
 vDgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUecbs3RHowNhGQ3s1SpVIPeXefCDouqGq/AE4wX8XzVtC5xq9ORBClWSgPtj07eGDYx7I=@dpdk.org
X-Gm-Message-State: AOJu0Yw7XVt5rKu4DRUWTq/WBYu+pRfnFqR5ks/xbDbaorfEP0GdOnH8
 WAIwPhObhdHWHU7MRMoxbN1hKzhPX2jQEbSU+lsZFo/5Xxm95uHn2Xtsh9SdLC2+G+NLsElJAFM
 WLWys1iMhi7ZJrYwoMLTN01Ou9tC8qegWJ9w39J2jPw==
X-Gm-Gg: ASbGncsAtH6OODGsPa9z0QK7cxGQWMobwUASUBAH86qMpbpdcoEJevm9UYvr+/seQKE
 a4xJkJo0jN3gMsF1jqMyqfFVEh8haVGwU2aqrYyRxXHtXUjNinnvvkZXru9/WCpH6xCw2jKIxuB
 qxy2KTUMG5pYQhq7z1m8eXoLqFGV5gbDD60I2OmMYSGPhM7R7w1w4WFLME75xKomhR+OiqCUSR/
 7H+XCyNKl31/YeDROnpqxPC7RBqBfXG2Jv9jo4kbea+I2oyxs8=
X-Google-Smtp-Source: AGHT+IEuV0SBrTcEEE4QTJe9VoI7MjZKvT0hl7brGgW79sges7m6UtogNivP5el9SMX2xvhp2OgoyZFRQSRKHZaV27Q=
X-Received: by 2002:a17:90b:1c05:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-31c4ccea7bfmr5793216a91.18.1752246262834; Fri, 11 Jul 2025
 08:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-2-dmarx@iol.unh.edu>
 <20250603172827.458725-2-dmarx@iol.unh.edu>
 <CAJvnSUAGND5nTFHp71_d4ELqY20bcLC8Oc-OAhWz0V1jcpvOhA@mail.gmail.com>
 <3827624.axiByQ7kbq@thomas>
In-Reply-To: <3827624.axiByQ7kbq@thomas>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 11 Jul 2025 10:58:36 -0400
X-Gm-Features: Ac12FXwSJ8BAw_XmRZPsYOrXubJZTMLtKHV8mEUdToZQIkYBdMdYwzmt2SMnUG0
Message-ID: <CAJvnSUBXMdbm8r4RC2s+dCSCYnWudwMiUfGhnvKWpGz_toaokg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rewrite dts rst
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dean Marx <dmarx@iol.unh.edu>, dev@dpdk.org, luca.vizzarro@arm.com, 
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com
Content-Type: multipart/alternative; boundary="0000000000000e5ac90639a8a0f5"
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

--0000000000000e5ac90639a8a0f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:57=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:

> 25/06/2025 06:07, Patrick Robb:
> > Applied to next-dts, thanks Dean.
>
> I'm almost sure it has overriden some doc added recently by Nicholas
> Pratte.
>

Good catch. It removed some sentences explaining usage of tests_config.yaml
(where you can provide testsuites specific config values). Sorry about
that.

Dean is writing a new patch which adds that back in, along with a couple
other parts of the "How to write a testsuite" section which were dropped.


>
> Anyway it is too difficult to understand what is changed in this series,
> because there are too many unrelated changes.
>
> I prefer not pulling this series in the main branch for now.
> Please split the patches with clear explanation of what is changed and wh=
y.
>
> Thanks
>
>
>

--0000000000000e5ac90639a8a0f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 9, =
2025 at 3:57=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjal=
on.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">25/06/2025 06:07, Patrick Robb:<br>
&gt; Applied to next-dts, thanks Dean.<br>
<br>
I&#39;m almost sure it has overriden some doc added recently by Nicholas Pr=
atte.<br></blockquote><div><br></div><div>Good catch. It removed some sente=
nces explaining usage of tests_config.yaml (where you can provide testsuite=
s=C2=A0specific config values). Sorry about that.=C2=A0</div><div><br></div=
><div>Dean is writing a new patch which adds that back in, along with a cou=
ple other parts of the &quot;How to write a testsuite&quot; section which w=
ere dropped.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Anyway it is too difficult to understand what is changed in this series,<br=
>
because there are too many unrelated changes.<br>
<br>
I prefer not pulling this series in the main branch for now.<br>
Please split the patches with clear explanation of what is changed and why.=
<br>
<br>
Thanks<br>
<br>
<br>
</blockquote></div></div>

--0000000000000e5ac90639a8a0f5--
