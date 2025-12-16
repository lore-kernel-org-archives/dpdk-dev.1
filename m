Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E5ED64060
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 23:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 217674029A;
	Wed, 17 Dec 2025 00:22:09 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id AF63440275
 for <dev@dpdk.org>; Wed, 17 Dec 2025 00:22:07 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso33681595ad.3
 for <dev@dpdk.org>; Tue, 16 Dec 2025 15:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765927327; x=1766532127; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=15+PCjAlyUrR4mn3pYr1Z6UgvcnHdMdALzPp2uAQnCw=;
 b=S66f9XVgr3ac0px3MyngqeREhf1x6GfYYBAL6BbNxmwpqH4yf6NP4XlBOBip9Op2TP
 aFgrr2ThgM8ceswrTivDw1nM7K66Lm8YrUohjB4MkGtZD/dVOSGHGiXkmKaoDliSfyQb
 8A+JtIQpmyDonCLNc/BxbjPm+gMNfeqxVFnp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765927327; x=1766532127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15+PCjAlyUrR4mn3pYr1Z6UgvcnHdMdALzPp2uAQnCw=;
 b=vjarwDfzszhWQtq2c6JFdePb6vExqFNzz8Zx33GshzyDZnFAOq+gvTS7cGN85DCGVe
 38VOqh6ncDM16ApGbrtyjFDMWR6aQipmY7A2hMsnM/7Ch4CSy8l5FQaw4XdpsPpauJo8
 ZEOeHj83HlorwwRG4PrXBWTeWeIvwk5zguwf/NmBob7Wj4B0Mm2zrfLRnFBZut+BJeH1
 s3m6lrIztPzIhLYMSqB/R/QRhITaOsv2RteyX8+Eq3/+JIJFYQaHcAq0/P9djlqyKQWo
 Lf6qJhMS7rBQNm08pA3etdMbHqjQl9mzIxW00X11z6u0J74h9tTPVV+AP/Pd0QXPAd0p
 QnRg==
X-Gm-Message-State: AOJu0YwGoiXpxcEe3UQrnkH608c4SEt6ErINsauP9XL9nlBAmi/RkmaA
 00acRoXXKsPO924KJvTua8sWI9ixO1RE5hH3/Q02rAceMwLDJwTrB5Ca+b6BG2lLpEindhuLu47
 mGvXXWt7uXd+Ejbj1svVzoliCGGh8jAPdUHYcB0/f8I4G1FBwVFb3wzjqDw==
X-Gm-Gg: AY/fxX503Z+Oph4ikOcKTLZcKWHV4neVyyKLNZPAOOuh4O0qUkTVt7pEUfksN1sJZ0Z
 /fSZhETKjHNuPdlCfN7Fi3n6CEmZjuEgbSiQbLuMtzeDoh/sUXqV0AjBExsdodszjSpTitW4Bok
 cwROWx9E6X6P6OxEd2UiBwGMjLQcliMSmrIys1axY95aipvvlOPOFn5RU8mxRTfxZkn1Y0kHzMz
 ucxFYq16SzsduJEFbDp5BpLy5eosnWAQNPTDkqaCzjukIsaIymYWSGmBKQCkKgSahc65gLnzxbL
 HPVEcYPeyinQzWqrYJQx
X-Google-Smtp-Source: AGHT+IExVrACdHhaSIRmJ7q9dKMyoD4OX1VYUodl6rJvRKzl2UCDbGQ5YSreExRsJiHDBS21hYnETWppLT6+ctmWdyg=
X-Received: by 2002:a05:7022:3a05:b0:11b:9386:7ecf with SMTP id
 a92af1059eb24-11f34c4f7c8mr9991360c88.44.1765927326561; Tue, 16 Dec 2025
 15:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Dec 2025 18:20:18 -0500
X-Gm-Features: AQt7F2ouZ_eWybqVojIj8MShyU_t73TDyCd1j2nfV98AA0XMsm0BpDLPZ7J-arU
Message-ID: <CAJvnSUCotBFNK46rNrbTqGDy70DPqz782JQHEHa9wtpLzPFPcw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] lib: fix format overflows
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ffc977064619feb6"
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

--000000000000ffc977064619feb6
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

--000000000000ffc977064619feb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance</div>

--000000000000ffc977064619feb6--
