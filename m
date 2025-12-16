Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD0D637DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 22:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E422E402C9;
	Tue, 16 Dec 2025 23:35:20 +0100 (CET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 81EBB4029A
 for <dev@dpdk.org>; Tue, 16 Dec 2025 23:35:19 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so3377711a12.0
 for <dev@dpdk.org>; Tue, 16 Dec 2025 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765924518; x=1766529318; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t+IHklVxM0wCWkZ6oaDIxczdfkYhMcyAkk6c02up2Zs=;
 b=BzJB5ik8ej0JYr8cWBJrzM940Jrp1s2gJa0UmxE/zEMpICoGIJ9dCVjGGNLv371HxZ
 PNMvfphMw/rDd2BTTFllcK3LAOiLIvZ4Z41ZRJsZwHv6GkXkvHZ/6a8VC4b2aYzxFI3H
 rDwmcoyGzCGGZAAjWAefqy03XUST1tCt8XUK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765924518; x=1766529318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+IHklVxM0wCWkZ6oaDIxczdfkYhMcyAkk6c02up2Zs=;
 b=cbAKWcpv7XPU6G56/PZ0YxigYVw2psv8f9bUDsokY2vRq5qgu5aKxBfa/A1JnTaOpG
 3WVwdmO9VOBnbUBO8gxrFhhgQWWYvnSuA0sudzMzbsnvg2aldHXm9f+3nvsidgUyP1UB
 2qEPpcwRPKCaK4qvPH75Lsuq9YxR5afZS6tR3V+g0IF3IlDyZDQiuSct9Axo14ujoOQx
 iN+4oxMGc+XFjmiZllIJv50yscnUYQI08CotHwdcUaBwtn1yt6okrmuuzt4GzNLV3lck
 nGUhHPuWnWj2ipFyI3B/db4bcIiW7cV82zNrsSjCKaNGSsvzX9kZSa31kG2QqWEZInCr
 WiSA==
X-Gm-Message-State: AOJu0YxyiZCMcKd5P8AKTh/qv16rnMjZs0GOTfL2yAExboExjiLXUhpU
 TXoWakUuryf1icLcoux6647dslG2m5mxv27LDBwaB19rcGTgRlp/z3miMT7ztg4JLk6RbGmJlsE
 L6dwsIh0K4CLdaZ6rLVS63p8gpFRIvPNskFRAWHU8qQ==
X-Gm-Gg: AY/fxX79ZsTA467Su2GWfM0lksPbDYxI5IjKPz63x+e8RVagPwaihQrEjUFEaEdXnmI
 d5q1somoC518gZxuvK9MMgZmPJVPcPcEnf8pwC+jJdDkLVpDqxe2wfC9ZUiwRrfoiLdvtjjJ+XE
 HXgfPlXwWh3Txv+pllJp3CiK479JshEq6eUM0d6jgp78E77dBF1TSL8V3Vh9LkoH5ZW/2WU2Bpd
 AFgH22adaRbCqH3kHWFq7UnD2VODdspZUEPehpIVlMdL0mQl19sKpi2zMwVCy8FeShTVoZmi9i9
 CEIAPHEzHg==
X-Google-Smtp-Source: AGHT+IFFJwQ3nbhoOOKn7hLf2pvWss5bLkvkQWIGKBgi5xVQFPc3b4li+Nh+CWuaqFcn7cDT89JZr/z+dRPv8uqS/KM=
X-Received: by 2002:a05:693c:8203:b0:2ae:5055:8452 with SMTP id
 5a478bee46e88-2ae50558851mr1778108eec.30.1765924518394; Tue, 16 Dec 2025
 14:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20251206182441.68354-1-anurag.mandal@intel.com>
In-Reply-To: <20251206182441.68354-1-anurag.mandal@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Dec 2025 17:33:31 -0500
X-Gm-Features: AQt7F2ohFjHMpFiRwwHe4vRZWDmN-WKWeffbXAim8g__Q1KmqltQwZUInfkC4pU
Message-ID: <CAJvnSUAPdwJ+Amn21JWw9boM=kS=m0UmcXgKC-7fmQa+4H-zkQ@mail.gmail.com>
Subject: Re: [PATCH] net/i40e: fix QinQ stripping
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009e8f110646195746"
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

--0000000000009e8f110646195746
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

You can ignore this email - I am just sending a recheck request to the CI
system to correct for a false failure.

--0000000000009e8f110646195746
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<br><br>You can=
 ignore this email - I am just sending a recheck request to the CI system t=
o correct for a false failure.</div>

--0000000000009e8f110646195746--
