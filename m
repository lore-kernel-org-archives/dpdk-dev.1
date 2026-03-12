Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F23D106ACDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:48:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2100A402AC;
	Thu, 12 Mar 2026 19:48:55 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 353D140275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:48:54 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so180442766b.2
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773341334; cv=none;
 d=google.com; s=arc-20240605;
 b=LGbqyPsJ9IxeaaTGXWsktuhe3xWijAwm7Mey/8nOUM/C69urRNnpU6Ynz+0juMxZra
 a+2PPSK6ua+lU21UYVkseh8TyPjVAMxmnReHDATFqkiiMw+KTnQ0pKcRyF8bHFxA7qeM
 YREhh3zSuxiEKXH1bklCnybpyTR7QL98OFYCHAPk/3cFXvhk9B2BkyhMBxfmGXxmxOev
 Qztn9oWhqDRlrwo0ZHNfrnwKha7dMF/N4sWj0bHIMti5aKPCm4LwMqxWJVGUfA0hefS3
 p2brkbtBA7XNFPa20SzI73vgj0NreE1RrziRwnHiwGIhG1R6o/yFDMyyibuG31SwfuQp
 6bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vnvKl7hbYfEOQEG+glO+VtastQnECEdRn2T9+JD6+aM=;
 fh=JmUyFF46ov/5obm1JP05q7Yz5ZjgvokKZboQOsoqaLk=;
 b=U7EhmC1Qd7I4fHp5vWWNHWmLckLKTDtEZiLGuFY6kRGlVPuBtnfC9VFwAtpN8YxGID
 Z5mQ8l7OhcfkKJ3ZJJYEq78LXCQwwTx8xd+PPceCmoWzgTxwXAPlyUqcCQJb/sfs5N8s
 zy9P8HHIVwmHkoOF6Cfa464m98NGmDrCnmBWSBt8+3bYAJ+ivrJaxrzZ1ajpR6s/4U4F
 uyKO1z7x8BrjIGYwXLkMWFqWgaWRYQ/SEnukCDC/rAxUsKC71yGlc8Y9x7UgEyO7xUWu
 Jz8dAj1oYxu1kI5UZNFN6eK5a9A1wDudFN2qeGhTt4VAJQWAbyqVd97eFxauA5lkpxLm
 3ZAg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773341334; x=1773946134; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnvKl7hbYfEOQEG+glO+VtastQnECEdRn2T9+JD6+aM=;
 b=Ziod5BFFCE6KylJEkabSJQAUivuSPquC8jP9yhQBaF71pWhzfN4VViU+OX6JyLySqQ
 vTn06db4E5B9XQIIhta6PgP/pb1Hck3Op6rwlQA1vNH3bR7BZ2NerH1vyrZATbl6HK1G
 m64Kglz9tFjjEQ2mwHRRKii4jl1zgo21M765Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341334; x=1773946134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnvKl7hbYfEOQEG+glO+VtastQnECEdRn2T9+JD6+aM=;
 b=EcB+IaEcVS2EslEcUqkkK6ZqnDorhZ2f2NTd3AsZIgip9gUzbng+pKZrOedX3jGVvE
 E/rIPj4q/wp7bCFSoZD2br2FUm+XGwQNRDhjF37CejuxsNxvrdgyXBKEEkeQUnArTxzA
 ZRivOFWkMYOThe+MaJWw0GG4kQaoKhPM8XAeOAJUifBaVH7D7QeCf5MrS7DaYIoYLcUQ
 aIvbmH9yTspFa5qrR1OmoSP35MKQ2Lm/6M/Vry2UjhJTi0BqTveosUfK4aoJ21XpXNTm
 SUmyFmLw/x6RLo5oSm7PV6oTYgvJ3oFlIHINEMSJGIo7nQB52apz6+7xd9EQVqfCAsvp
 2Sag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgVn0KM5l9aDZUYb7kblH1dJiL2nUinh4Z9kAVvJcddOq/aaj+wdMtbfH6tSvvgiKNT10=@dpdk.org
X-Gm-Message-State: AOJu0YzssjFnc2MgLjUlouIN3ktACMZgVyag10JsV1EQsmuo54l4D2C7
 /g66dilHgdA0F2pDD9hNFAL4ZNGHAELJvUCLC+/bXodduEZd1UXMAuToXPipykx72r/cUo/qmCw
 FbOv8Lv6EnTTNnQhZAizq3U7FBEcayDRLxbkdOinzwA==
X-Gm-Gg: ATEYQzx6HkbtZh0T6dflrZ+Xgv4DiOZhvVrF/Em6PSfL6lPHZ8ddZHlL1VCZb5/M0n/
 2ri0zuFzi2ggpQy6OxapbbzBoOVBB0/mXOtCNY87FmVVJL9Tr3ee6T+sNz8Hdp1NImbtxuhMn7V
 feGrUaP/y1ACcxTy9s3A7zd2tqSEZw0AUik8tw7lUSFlcPgI02yB1OYZanoOlXBcRLH4374Dy1J
 sMkTrwgyNSno8KulXtvD1uqEUytz0TYYEYRW2wHwaoNDPaKTqd7NVsTy7hdHicbIo4poSTZD3ze
 KgPC/tGHwdLsfLb7QJf+J8thInjF/yiZYKDTUuby
X-Received: by 2002:a17:907:94d3:b0:b96:edcd:cd04 with SMTP id
 a640c23a62f3a-b976530e917mr27392666b.49.1773341333643; Thu, 12 Mar 2026
 11:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
 <20260306164027.171723-6-abailey@iol.unh.edu> <8652174.T7Z3S40VBb@thomas>
In-Reply-To: <8652174.T7Z3S40VBb@thomas>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 12 Mar 2026 14:48:42 -0400
X-Gm-Features: AaiRm52fqV1VgFL6_Omy9M92Eo35rLdxke9ohLghunk2IIEzy5Q6vAAPFXdXVRA
Message-ID: <CABJ3N2XxFso=mKLObZzy5bPiLDRewNmNU=15WCh2koz=4EdnqA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] dts: add crypto test decorator
To: Thomas Monjalon <thomas@monjalon.net>
Cc: probb@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, 
 kai.ji@intel.com, dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com
Content-Type: multipart/alternative; boundary="00000000000041f118064cd834f4"
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

--00000000000041f118064cd834f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:08=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:

> That's a bit strange to read,
> because a crypto test can be functional or performance.
> I suppose we can re-discuss the classification of the tests.
> If the only need here is about the traffic generator,
> we could make it "raw input" or something like that?
>

I agree that "crypto" is not exactly a true description of the
purpose for this test type. It is probably better for the test type
to explicitly describe it's purpose. maybe NO_GEN/NO_GENERATOR
or NO_TG. It just so happens with this series that crypto tests are the
only cases with this type, which was the cause for the initial name
but should change in the future. Furthermore, we could divide this
into performance and functional versions of this flag.

--00000000000041f118064cd834f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 2:08=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monja=
lon.net">thomas@monjalon.net</a>&gt; wrote:</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
That&#39;s a bit strange to read,<br>
because a crypto test can be functional or performance.<br>
I suppose we can re-discuss the classification of the tests.<br>
If the only need here is about the traffic generator,<br>
we could make it &quot;raw input&quot; or something like that?<br></blockqu=
ote><div><br>I agree that &quot;crypto&quot; is not exactly a true descript=
ion of the <br>purpose for this test type. It is probably better for the te=
st type<br>to explicitly describe it&#39;s purpose. maybe NO_GEN/NO_GENERAT=
OR<br>or NO_TG. It just so happens with this series that crypto tests are t=
he<br>only cases with this type, which was the cause for the initial name<b=
r>but should change in the future. Furthermore, we could divide this<br>int=
o performance and functional versions of this flag.<br><br></div></div></di=
v>

--00000000000041f118064cd834f4--
