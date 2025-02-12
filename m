Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B9C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:03:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9DF24279D;
	Wed, 12 Feb 2025 16:03:33 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 88AD44111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:03:32 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220c8f38febso8336075ad.2
 for <dev@dpdk.org>; Wed, 12 Feb 2025 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739372612;
 x=1739977412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbnngU6XckjzKhSN+7yGevwx1cyyIatdJJZdPrFRIKI=;
 b=p1i3fn20jLwZzO4xGtiJxVHj6ooOoKsSlQWOWk7+RnbN6+o2aT/Tc0hwCtlaXP4eHh
 Pwcb1Z+tGn6UsTWaNMgM3QLaHkNAsf75OKkcxjWSvlyARUL8B4CR1Nw2eFCF0taH1S+r
 B6rcYdJXSUxbDR5DVrpKWkWahhTkTxGuBm6+MsWxxJrZ+hVOZaaOYoZrJaNI5zVn5lRv
 7uFAPtbga11Kq84osP9U+VPggoCnJ0SrGRoJWE/Rz5ONkH4PXvMjh8XI5JgIi7A+65gx
 nhcPG3B8yhPQ81lKKcjmyaqwFdsn3EFxO0iFbm6644uJmAtyAMm64TKTkJMwAlMt+7rH
 irEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372612; x=1739977412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbnngU6XckjzKhSN+7yGevwx1cyyIatdJJZdPrFRIKI=;
 b=Hnx/Mltot9PhKb4boK1wan6nJwLMX1yLWr4YhokF8wppOHzYDAUUbIixiq0AtmV2/m
 oPTXUpr1FzJ/AZKFIF1bPTywl65DdLuAqoDdhsTphFoCLYwqxCqh7uZ/+fqL475MEiDU
 LnHu6WYmfrTXyQfluY/85xnm274EH+cebm7mcFYdxkoVeQp/5tgnGPlCx6qklthNSUSq
 2SoW7ZHf9spcpF+KyiKEkOxewvlCeSdx2JPK0/2k7doKHwTT0Nej9KfJLuaiiJuyh75v
 UTKffa9hjOE0MqEmK+MGTMrC1sTZyZJGkGoOMOwTOnaYMXnglOG+/cX+THLuHwgz1zpi
 3HLQ==
X-Gm-Message-State: AOJu0YwiTvRhqbOcEX9Oko0T99CNcK/nMuBFeFZBYMKNmrpYsfeFZcAx
 1p1tzLqJenZJUOrfEkCQbH3S66v8NtDohYH4P7UIt3RTv8/cOjRM+wTHMLjgUyjyuY63nPonz/w
 7
X-Gm-Gg: ASbGncs1+giEYGGYWmPQXFMF0eLJKBLMaRifZMDKEmAENIM173GI14KlXu2lDqkPdF1
 DTAQm0a+Eha0ER+ByMOQrwr2Y/8BYC7HJ78JsTortZXBOisJZKhSVg+rQbnpYTUWiRJtdFq5Wxa
 fBLU15rr+PK9vd71qsvt/oAw+VCEZgoLONoRzTzAnoduoj/AVGDSMb11waIQYuOZoytp/5Gu9Sp
 zMduQ87NUnByZyq58Af4LXCbVAyHGY5QWvK6d+HlwrMFgiDot4mDLeZWqvIOeGUmzLZHIL0kAkg
 s78Wn+rlnBsHueh7Sm0VXDRXI3/0Pj1/6nnp7PAEys3u3h41eFxjr8I/nypYNtyaeBme
X-Google-Smtp-Source: AGHT+IFKPtiHsSa1OXXe+CbuZbw+rLEJU6Y7NIKEvAe3SG40Pr1290cf2z3efecnW3hE1LfbotVZrA==
X-Received: by 2002:a05:6a00:2d08:b0:730:95f1:53ca with SMTP id
 d2e1a72fcca58-7322c591c13mr4313746b3a.10.1739372611608; 
 Wed, 12 Feb 2025 07:03:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7c24sm11223500b3a.78.2025.02.12.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:03:31 -0800 (PST)
Date: Wed, 12 Feb 2025 07:03:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v5 01/11] eal: introduce new secure memory fill
Message-ID: <20250212070329.7d1b816c@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA26@smartserver.smartshare.dk>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
 <20250211173720.1188517-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA26@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 12 Feb 2025 10:09:27 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Tuesday, 11 February 2025 18.35
> >=20
> > When memset() is used before a release function such as free,
> > the compiler if allowed to optimize the memset away under
> > the as-if rules. This is normally ok, but in certain cases such
> > as passwords or security keys it is problematic.
> >=20
> > Introduce a DPDK wrapper which is equivalent to the C++ memset_s
> > function.  Naming chosen to be similar to kernel. =20
>=20
> It's not like C11 memset_s, which takes one more parameter, and is an opt=
ional part of the C11 standard.
> It's like C23 memset_explicit.
>=20
> Wouldn't it be better to name it after the C standard function, i.e. rte_=
memset_explicit?
>=20
> Or maybe backport memset_explicit from C23, i.e. omit the rte_ prefix, if=
 not using a C23 compiler?
>=20

I prefer parallel Linux kernal API names, lots of drivers share code.
