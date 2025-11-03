Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67140CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 21:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9CDD402EB;
	Mon,  3 Nov 2025 22:18:33 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1B7AF402BB
 for <dev@dpdk.org>; Mon,  3 Nov 2025 22:18:32 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-295ceaf8dacso12122975ad.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762204711; x=1762809511; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dREsxMYkn9nE8vb9vkTdVhG5RJd4i7prPoWpGTKKmL4=;
 b=imDPnMyHsay15InXZLsYu2DRQqkINf2cuJygeCEQGVXtGhBn6NAwKRIjFUmIXaaZAG
 LVdErGX9poVmDUqy80NeA3V9J2VB51LmhOqAJOR8GZNjS8e5bGHmoVl5iAESY4lPqdUM
 rIsljyIBmnmjQAN8GEBjq+KKUZYlJDwGOrIXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204711; x=1762809511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dREsxMYkn9nE8vb9vkTdVhG5RJd4i7prPoWpGTKKmL4=;
 b=BSXLeEQ1n4szeO9cnY470F8s+XAnybC7s1q/0Nv3CncBOlSZm3O1VUO6tCQDvdZQBT
 s9ojzmo6pSV/Lgc3HXwTY16oV0Sf5Hu6WNU/zUKz2YDJhE0rt2CvwR9awNVmRKb2pOPJ
 6cDBXcND3jcDodndfF8RIBOKDITjVUp43Sl/AlBK+umW1fHAjkiTjtualraEGlkm/ryn
 XcgVKH12cmFBS0XXjk32IZZGDuvGUD9D17c7qx+QPlFgp1Ed7BjTZk4rcyr6P6SovrMl
 qDpGQRfpgBjeafT1Labg9jOKVENTUxM3G+NKTfCRNaGlIvkI3AuG3yJwWBOXlkZmvnQB
 O5NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoJMI72XTx2118UiuoZaloGHcIRD2SqC2G7B4jH08eFMemWHPKe6nCP7rNXfs/6irUkik=@dpdk.org
X-Gm-Message-State: AOJu0YxlIHrdxutY0TKxxqQNw5ZWC1nHFuv0eYN0wKM/nWGAn0uE7fdR
 C9VydbcgtbTY/fqd+zKTCK0o6jKdmkOsyRVFTrbyzHtWLo1OJM0HTWugw4eTpU25mVRPDGbmYPU
 wCWc8I/xpLsUYcZJdqDvWK8SAcj2avw4qZNC99nBXRQ==
X-Gm-Gg: ASbGncs8BkbbUcrase3LUiR/+wwtVab6RHbfoq0AJPcj5HQ77bl5KRA1t87EZy+T6G0
 k8G8cZERjze7S/wEnXwSmGDMYxXB07+/fJMrgA3UCiza+WhnrvkDLIaOnDzg+QDyrDOdvWzJCMc
 +DJQYN7M9KX275xYY0Bi/ArY2u45P5rHD2L8WicqKqDnelPtLuGxGNlwHfvyeLzyZvKk86gqat5
 OBWi1BiOQDw34LG4tCETq4DFyfTGLXDzdbXbHXwxISiVtmyqtzBeBxbyQUnisrboWSIkDgku9t1
 w9HGgzbkUg==
X-Google-Smtp-Source: AGHT+IGSYKeS2NB15TLGVvNoL1mLcB6SZN0u79xUbqZM80hqX4F9KyOyniL+LPDCw/DiZAr8DQ/H1FDJnQZ6wvjPfGI=
X-Received: by 2002:a17:903:2f8f:b0:249:3efa:3c99 with SMTP id
 d9443c01a7336-2951a600e39mr197663865ad.61.1762204711102; Mon, 03 Nov 2025
 13:18:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
 <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
 <CAJvnSUD8pJJeXYQ1adxC0d5mUT9Zm7jODoufrDjePN+7gy3MAA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65526@smartserver.smartshare.dk>
 <CAJvnSUCH2U5DgpkRXJEX1yJmpE1yhM6KHEE9_8Z8xghW52Tg9Q@mail.gmail.com>
In-Reply-To: <CAJvnSUCH2U5DgpkRXJEX1yJmpE1yhM6KHEE9_8Z8xghW52Tg9Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 3 Nov 2025 16:17:26 -0500
X-Gm-Features: AWmQ_blgZfZcgLSehZOhEPfIze1KsuQUFDyGeiHHDV65QLJ1Ss_cGQ1Uhs6hkN0
Message-ID: <CAJvnSUCZbShYJP6Zqyz6veewQoeUhgjbkYQ-Zp2NGy7qK1_d5A@mail.gmail.com>
Subject: Re: Disable SPDK testing again?
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: David Marchand <david.marchand@redhat.com>, bruce.richardson@intel.com, 
 Aaron Conole <aconole@redhat.com>, dpdk-techboard <techboard@dpdk.org>,
 ci@dpdk.org, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000d3bbae0642b74157"
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

--000000000000d3bbae0642b74157
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All set.

On Sun, Nov 2, 2025 at 8:06=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> Okay I'll push this change Monday morning.
>
> On Sat, Nov 1, 2025 at 3:47=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshares=
ystems.com>
> wrote:
>
>> > From: Patrick Robb [mailto:probb@iol.unh.edu]
>> > Sent: Friday, 31 October 2025 16.13
>> >
>> > On Fri, Oct 31, 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsh=
aresystems.com>
>> wrote:
>> >
>> >> If we disable SPDK testing due to this SPDK bug, how will we notice
>> when they fix it, so we can enable SPDK testing again?
>> >
>> >> One option is I can disable SPDK testing for the "per-patch" testing,
>> but leave it enabled for the periodic (once per 48 hours) runs on DPDK
>> main. That way patch submitters aren't left wondering if their patch has
>> broken SPDK, but we will be able to check in later on the DPDK main
>> periodic builds to see if the SPDK side is fixed, at which point we can
>> re-enable SPDK for per-patch testing.
>>
>> Yes, please do.
>>
>>

--000000000000d3bbae0642b74157
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All set.</div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 2, 2025 at 8:06=
=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol=
.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr">Okay I&#39;ll push this change Monday morning.</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
at, Nov 1, 2025 at 3:47=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=3D"mailto=
:mb@smartsharesystems.com" target=3D"_blank">mb@smartsharesystems.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; F=
rom: Patrick Robb [mailto:<a href=3D"mailto:probb@iol.unh.edu" target=3D"_b=
lank">probb@iol.unh.edu</a>] <br>
&gt; Sent: Friday, 31 October 2025 16.13<br>
&gt; <br>
&gt; On Fri, Oct 31, 2025 at 6:02=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=
=3D"mailto:mb@smartsharesystems.com" target=3D"_blank">mb@smartsharesystems=
.com</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; If we disable SPDK testing due to this SPDK bug, how will we notic=
e when they fix it, so we can enable SPDK testing again?<br>
&gt;<br>
&gt;&gt; One option=C2=A0is I can disable SPDK testing for the &quot;per-pa=
tch&quot; testing, but leave it enabled for the periodic (once per 48 hours=
) runs on DPDK main. That way patch submitters aren&#39;t left wondering if=
 their patch has broken SPDK, but we will be able to check in later on the =
DPDK main periodic builds to see if the SPDK side is fixed, at which point =
we can re-enable SPDK for per-patch testing.<br>
<br>
Yes, please do.<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000d3bbae0642b74157--
