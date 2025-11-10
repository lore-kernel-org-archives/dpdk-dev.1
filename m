Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB72CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 23:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 435214026D;
	Tue, 11 Nov 2025 00:16:30 +0100 (CET)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45]) by mails.dpdk.org (Postfix) with ESMTP id 2FC004026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 00:16:29 +0100 (CET)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-93514afb23dso2047016241.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762816588;
 x=1763421388; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wy30RnLJx0hf7OrOFeKUfcfoOFFDOXSxE6dGSwOOeeA=;
 b=w6ekjKdJkz174qZGMRbQXdCXe3BPrcIaTH/jmydf9jJPpykhJWES55iUlXmtbs/IMQ
 zy2JI3A2IldepeKKYNCah72cOdDjnpdwDJyU/UrIv75zSeb0vJnAWu3p0+aqVCyL09HM
 JDIp2Ck+MLITW8pRfpFRbQcaBia7QC9W3O/TcqB29L5MlCN5Gt875jE1PA2dUrfoYlSy
 4aauv85pgXynbDwruXWYJMhDIp35AiUtQGtoe2SeDJ0P9bCTqDbah1Qrv1JeI1H22oQS
 H62prvSNZhA8h8CfyrPLk63ncNzEw9Spwk849froPZ3ZSsRq7B4r7a80F0qQyPDnairX
 hfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762816588; x=1763421388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy30RnLJx0hf7OrOFeKUfcfoOFFDOXSxE6dGSwOOeeA=;
 b=ZjtKC4CmV3ULVytMo9sUK327XLfRmCZehLpvPXb5eWyHQBXWx65Yg9fYJ5bi+v2lLL
 n8fOnRd6gxvqxbYNPos5JVgeJdbB88QprzrZGTXc+W/D0QfyheBMrmeSCdRL6TYQr9dA
 QAk4p08DrufOaQG7NkwfANB/fbRNRRBLdWznwjAE/Ef1BByUdZpXjpyo/qJiafqTvDao
 FqL/6TnaSerAjCjC4WxxMIpf8lf9WHI67si1GC4TMmPZKLNKd7yqXsNK9eycbqLeU4wR
 CsEhN25Pzs5NTGmQgRzN5r8qTeiSIlVfu3kF66PdKHWBFCfTLKxA0IbaLQ//LWT6K3Gt
 ntlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh3ZBmBX3PRliLpLjGMfc90fXxpMdn14lv101BPkgyjERXLalyBwoH2i6OfQTHVerK1eo=@dpdk.org
X-Gm-Message-State: AOJu0Yzv+Z6yXgVSK6RlWUuPF3x6K9F1SSP1KK0vUg99DvQNrWEjH4HM
 uRboQ0du+utd+OAm3VpWbnmL1o2Vk2pl80OxqsCHEfZEQeSXitD8IlimhfgkwbszgEUb7iwPe9J
 mVwuoCzMliuNfOIEgel7xJg3AQ77FuhQQjVAmQ0eCIQ==
X-Gm-Gg: ASbGncupGabXsSL5Kw7rHR/COx0Az6bEQwLW0hnfaMs5DFajuYyfjk4BxFQcDFOAZjw
 5wXrblugY6jLrQoiGbWyYxAK+ed7LSDDwjy7I2dezMD2pQpye5Q5II/Vaa3dbswLH3wSHOgLBZV
 tv236j735W4Ag5PBgkBfb1efhgjkwY7S9zmMByYaQN8AsuV6+Idiig1gZBjg/ijWGAk0HE4xIYo
 RhjYDG+24cHUyFsHkiLK9YURKibTKi78e/apCYk1LFVVHZ2bLWfv2L5a73oRMVzK6RCFt1sSgaV
 yBT/iNfY6zSrkQvyx6EOX6xndHFhhVon19PTfOpv
X-Google-Smtp-Source: AGHT+IEjNxvj6de5+Bvz6jsU3uTLfCUE5xfQxdJ5MMk15dNVG38m6CbFujc06GJ2NSvDTJbhO4t82rVsbMpxVGP/gQA=
X-Received: by 2002:a05:6102:26d0:b0:5db:eeb6:812e with SMTP id
 ada2fe7eead31-5ddc46ae8c6mr3642084137.18.1762816588118; Mon, 10 Nov 2025
 15:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <CAEKskBV8Ebeesg8qLZ7JcENWYRgfFeOAOhHRBC-WaaLRhn43Mg@mail.gmail.com>
 <20251110141017.4f2c034b@phoenix> <2780952.dkkaz22YKf@thomas>
In-Reply-To: <2780952.dkkaz22YKf@thomas>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 10 Nov 2025 15:16:18 -0800
X-Gm-Features: AWmQ_bl6pthCSR19PWtZCdBt4B7HD-YIyzZ0tiKpheeXtoGg34crs9u3rn1Yy20
Message-ID: <CAOaVG15WggoCraL=E03w7hBG0eCxqWayt9_G4PqDO1ouk7-Ygg@mail.gmail.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Manish Kurup <manish.kurup@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 dev <dev@dpdk.org>, Kishore Padmanabha <kishore.padmanabha@broadcom.com>, 
 Michael Baucom <michael.baucom@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>, 
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008a0965064345b884"
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

--0000000000008a0965064345b884
Content-Type: text/plain; charset="UTF-8"

Also, it seems the driver is compiling different versions based on compile
flags. This makes it hard to manage in a Linux distribution

On Mon, Nov 10, 2025, 14:30 Thomas Monjalon <thomas@monjalon.net> wrote:

> 10/11/2025 23:10, Stephen Hemminger:
> > This series should have never gone into the broadcom-next tree.
> > One of the roles of maintainer is to make sure local builds with all
> > flavors of compiler work before merging.
>
> To name a few we could also talk about hiding fixes (and backports),
> forgetting the documentation, wrong commit explanations.
> And many more could be said.
> As I said in another email, we should not accept such future series
> until something is seriously changed in bnxt management.
> For now I pull from the bnxt tree as it is what was planned.
>
>
>

--0000000000008a0965064345b884
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Also, it seems the driver is compiling different versions=
 based on compile flags. This makes it hard to manage in a Linux distributi=
on=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 10, 2025, 14:30 Thomas Monjalon &=
lt;<a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">10/11/2025 23:=
10, Stephen Hemminger:<br>
&gt; This series should have never gone into the broadcom-next tree.<br>
&gt; One of the roles of maintainer is to make sure local builds with all<b=
r>
&gt; flavors of compiler work before merging.<br>
<br>
To name a few we could also talk about hiding fixes (and backports),<br>
forgetting the documentation, wrong commit explanations.<br>
And many more could be said.<br>
As I said in another email, we should not accept such future series<br>
until something is seriously changed in bnxt management.<br>
For now I pull from the bnxt tree as it is what was planned.<br>
<br>
<br>
</blockquote></div>

--0000000000008a0965064345b884--
