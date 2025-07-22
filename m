Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1ACC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBF9F402D8;
	Tue, 22 Jul 2025 18:01:57 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 987024003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:01:56 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6fae04a3795so47772736d6.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753200116;
 x=1753804916; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wORt9mImnXn/wMv5HXX5lrWHxoz1xX8Qt477OBtTa2g=;
 b=qztuXg5BSPcMIvCUfv6m/rpUdgVxlUihIWCGphMwnYeHqS3kJSK98txC/mlJx9TthF
 5Kr2v3tYc/7WEGI5e34DZWi87EpxcbTK7fq+Ahi4Iu+UWHFT4sZsXAxxZcvGW1KuE+p8
 KOoZZAj9Q3zOVKE45mzPSDQKOcP1JTCEMr7NocxM7M170N51pJHOJxpZGNvhQd5ojfHx
 WWLZeEuuHvcpjkVbNhFeL4Hxcw83ATBqPPRjtl5BLHYPLMouRG/6S/UwYbWGtUTZ14yV
 7rwleSY1KU1Xka9SNagOpXtsR/P/H1I6J5uw5nfX7xWDa2+tIHvTacpszw7ooanwxEpn
 3Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200116; x=1753804916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wORt9mImnXn/wMv5HXX5lrWHxoz1xX8Qt477OBtTa2g=;
 b=nU9hSaGwGU5XWfTeTO1XnuC+vBTCWTDXucXXd1GpL/u4mkjz7hshYDh9axyEpfYzeb
 SwR3ZMO4toXb+gDN1pW5iPKyIGepo2HXPjigc/cQYz6z2G/hUthHpxRxIXcE5jbzXuL/
 GZZCa4FgY4GPSjI8583yH/ZVFlvrZ2QPDsMrIrUqhz1NUQrUGn8riHeBincRynCw3wIF
 nrkNsyauk7vE86ArE6zjHKtD5HO9Qj+lfP215VQLlOyL9ptLJBxP65myvywuszksTipl
 3sgp03u69EgEITzUXZix5lNymh8K1HB2F4WrxRSPAf1bQ6FKcr6pXhdqNBXTUuM66RlE
 +XNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnOjZ/VjR3H0IRjMMsbVBLkF/m3F/jgrUjZYbXQPMMUnIjN+UnUU8qzCs+b7NyUDGSlc=@dpdk.org
X-Gm-Message-State: AOJu0YyqgVs9VUxZuqqbh5BGc7jZR6mBsMFgZhTiB5emsX6SFedj3v0y
 wwNjFc2Rahkp1mPy2u/UJDKdKFgWoY271Clz591FC+2m2OO6wxSV7oA1NII4sXG/+ANqf4I1dOR
 Cqvm97cb7Ystn9uSb2J7Hpmrnst3GDcy8HrkaSuLoy71tQWWV1s2oypYcHw==
X-Gm-Gg: ASbGncsZl+la056lBq0d2bAJSKZ8UTbM9Amp2yDbgs0RF1gygsdX6Neu7efuomK0oxK
 OeNU8i93aeu6qmU665jsTsKrSwqip6QcCbcWOfnUIcMZrJc1Lg8tSXUkAY8C3mFl5aa+FTj7+xs
 XE7gKiyxFWPulkfSstlc3y1hcy3oyA20XjmAcsr5yaQMzvlu1+siV4EMrPQMNAzU5kn3DaWnjeC
 HMYJm1gL3Y8jA80TkNx5auRin82pOdQJymRhLxBjw==
X-Google-Smtp-Source: AGHT+IGYBL8rlo8opIjsWVn2vYAiVEZH/xL3Yaam4u60i/QDAQ83xSZBni+DeLyxplUPzPP09s6dcuer0nmhzMQIF+Y=
X-Received: by 2002:a05:6214:5788:b0:6fb:25f:ac8c with SMTP id
 6a1803df08f44-704f4ab51famr389761616d6.31.1753200115680; Tue, 22 Jul 2025
 09:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
In-Reply-To: <20250722084225.7a40e2bc@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 22 Jul 2025 21:01:42 +0500
X-Gm-Features: Ac12FXxzG7qugzFE7IIUOFB3eIwY4a8sF3iXMjVQAY3isUs49HdWdmQwf-cKDNI
Message-ID: <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000001d9ab1063a86b624"
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

--0000000000001d9ab1063a86b624
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the follow up.
Understood. That makes sense. However, I=E2=80=99d like to highlight that
applications should ideally be robust and interactive enough to handle all
edge cases where a segfault or unexpected error might occur. While clear
documentation is certainly important, relying solely on it may not be
sufficient. In my view, potential segfaults should be handled explicitly in
code to ensure stability and to prevent silent failures, especially in
production environments.


On Tue, Jul 22, 2025, 20:42 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue, 22 Jul 2025 19:30:41 +0500
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > Hi Stephen,
> > Can we add only the check that fixes the segfault, or do you mean that =
it
> > should be fixed at the PMD level?
> >
> > Best regards,
> > Khadem
> >
> > On Tue, Jul 22, 2025, 18:39 Stephen Hemminger <
> stephen@networkplumber.org>
> > wrote:
> >
> > > On Tue, 22 Jul 2025 07:54:39 -0400
> > > Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
> > >
> > > > +     if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY &&
> > > > +             (dev =3D=3D NULL || dev->data =3D=3D NULL ||
> > > > +             dev->data->dev_private =3D=3D NULL ||
> > >
> > > dev can't be NULL and checking it here will cause a Coverity warning.
> > >
> > > There are many other ethdev calls that will fail if primary dies.
> > > stats, xstats, rx/tx burst, ...
> > >
> > > I don't think it is good idea to add checks here.
> > >
>
> It needs to be fixed at the documentation level.
> Make sure and document what applications need to do. Rather than adding
> more checks in ethdev.
>

--0000000000001d9ab1063a86b624
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for the follow up.=C2=A0<div dir=3D"auto">Understo=
od. That makes sense. However, I=E2=80=99d like to highlight that applicati=
ons should ideally be robust and interactive enough to handle all edge case=
s where a segfault or unexpected error might occur. While clear documentati=
on is certainly important, relying solely on it may not be sufficient. In m=
y view, potential segfaults should be handled explicitly in code to ensure =
stability and to prevent silent failures, especially in production environm=
ents.</div><div dir=3D"auto"><br></div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 22=
, 2025, 20:42 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Tue, 22 Jul 2025 19:30:41 +0500<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; Hi Stephen,<br>
&gt; Can we add only the check that fixes the segfault, or do you mean that=
 it<br>
&gt; should be fixed at the PMD level?<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Khadem<br>
&gt; <br>
&gt; On Tue, Jul 22, 2025, 18:39 Stephen Hemminger &lt;<a href=3D"mailto:st=
ephen@networkplumber.org" target=3D"_blank" rel=3D"noreferrer">stephen@netw=
orkplumber.org</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, 22 Jul 2025 07:54:39 -0400<br>
&gt; &gt; Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk=
" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&g=
t; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_P=
ROC_SECONDARY &amp;&amp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dev =3D=3D=
 NULL || dev-&gt;data =3D=3D NULL ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;dat=
a-&gt;dev_private =3D=3D NULL ||=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; dev can&#39;t be NULL and checking it here will cause a Coverity =
warning.<br>
&gt; &gt;<br>
&gt; &gt; There are many other ethdev calls that will fail if primary dies.=
<br>
&gt; &gt; stats, xstats, rx/tx burst, ...<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think it is good idea to add checks here.<br>
&gt; &gt;=C2=A0 <br>
<br>
It needs to be fixed at the documentation level.<br>
Make sure and document what applications need to do. Rather than adding<br>
more checks in ethdev.<br>
</blockquote></div>

--0000000000001d9ab1063a86b624--
