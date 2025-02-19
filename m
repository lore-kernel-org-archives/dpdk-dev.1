Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82EEC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:10:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB44427A8;
	Wed, 19 Feb 2025 18:10:17 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id AEB9F4028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:10:15 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0e1so1982267a91.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739985015;
 x=1740589815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7xo1K/9WqKHMlO7hX1dlSAINaPZB3pDXVtejOI5fQc=;
 b=HccVmhITFlZ4+nijxF6lnnTLclqOQ2ESbfEBQesdneaFhtf7aRoStwH9fG64v7kR9w
 C7S8zXr5POTJTPK5sfllaPekIJ2hz+oELUzQXOh8/xL4cG/n8Dirfo2F2ALLRQaDepDi
 chkqHXp+yOSTlX6N2buYwksg5vlftRHQZY/XNfsX74DQwWs6gWoi9zxKFO/32eZFfeeW
 CUoLJUAadN8BUdf0IEpltz1rVLmKxEr8UGx1ffcHXt5WicOMfXj08Zf+3JjO2XQfZx2n
 BDJZdopd8Jrqic8Ig+D60H1pMZBNJm6Nn0PdNB1UZnrcetZBavpQRjhYYZ9xcQVl24tl
 WvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739985015; x=1740589815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7xo1K/9WqKHMlO7hX1dlSAINaPZB3pDXVtejOI5fQc=;
 b=mTMn7Pc6G+BE+iHPTTlTGxWCwldiK176iSo55+bQK6A69ZpaH5uSmbG4pJMTZIglC8
 JO2qvEo4CCp2P45kAh1l5m5NQIHqoygNlyDopowL0YVLC30v7K1H8fMv6oRbgtkAqXMh
 3biUewTqEuYNYGCQI/hGMZt6cTrAPGQht7auFSKLC3bWp/AUYklcUlH2HjjxGe+VWkLI
 4BeYdgy0M5Y0fJg3K3gOO888NN61Zas+aXpDObk42G0pYhJ9ZB1mb1CaSM/Nx48TIcdP
 ptLuJF9SawlLt9TvHKJJLu/DrFuGGWMF+XgUGhxfB/h9zmXaouhGsfL1bHS0ib0ituMT
 wWfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxRjTeva3nmwjMK+XLuiLrCqNph9WKjfqtGWUooJ1WfJ/vvnUVGlzjg0Qnkl30u9jnq8=@dpdk.org
X-Gm-Message-State: AOJu0YykDkDaaFWrn+/e1ZWB8S4fj3IQ/d5Hr6MvuwiRyjrm6HeMcQIF
 5aJkDqzCN3dAQliq8lgE1RsgRJI0ZEFf2a5t/EF9+tjMNtOxPr3oAGjXlAl/0eA=
X-Gm-Gg: ASbGncsIDZBh9T8smXmKWdv7P40aaSBckZxytpJBdtPqIrukjwhDO29KtXM8hrmX2av
 xBM33NDvBXnof0ewl4M0P2ngDMxMIf52mY7BzmviLYJAIXM3sv1KpWavaDtCWnVAtTgt9n1JXqV
 YE4nedzphq1t4c5rsRaI9oqWNUfWIuoZT/cLz98xyeZqm3u0qv+6EFaxmhIZhifc85YhABf9P+R
 NKXfURLY6d04KtDuhOSIJD6xno9vt/VQopDRRJ5gGYTsyb7y95nwx5qN9A6WEd0W//vCnL9n0Mi
 kO3Ni+4H2O/8AhARNSl9tVpZlZECunRatC1+FBiGrmV2bfoSs442QDkLO011I02sf2Cj
X-Google-Smtp-Source: AGHT+IFV8tSFaQ1ANy8M/51srzIKMFRzFc49ts3aGKaGjpbabxe9u/8ONG6CmO55jb+AF0VpYEgI3g==
X-Received: by 2002:a17:90b:4cd2:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-2fcb4d80a53mr7194500a91.17.1739985014673; 
 Wed, 19 Feb 2025 09:10:14 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349389sm108079145ad.42.2025.02.19.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 09:10:14 -0800 (PST)
Date: Wed, 19 Feb 2025 09:10:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250219091011.2c49f342@hermes.local>
In-Reply-To: <20250219165002.GA6472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA4C@smartserver.smartshare.dk>
 <20250219165002.GA6472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Wed, 19 Feb 2025 08:50:02 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> On Tue, Feb 18, 2025 at 06:12:04PM +0100, Morten Br=C3=B8rup wrote:
> > > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > > Sent: Tuesday, 18 February 2025 17.32
> > >=20
> > > There's no MSVC equivalent for compiler extension __builtin_constant_=
p.
> > > EAL already had __rte_constant which was used as a first attempt to
> > > workaround __builtin_constant_p when using MSVC. However, there are
> > > pieces of code that would benefit from being able to provide a default
> > > value to be used instead of it being always 0 like how it was done by
> > > __rte_constant.
> > >=20
> > > A new macro is added here allowing such default to be provided by the
> > > caller. =20
> >=20
> > NAK to the new macro.
> >=20
> > Please use the sizeof() hack suggested by Stephen to provide an impleme=
ntation of __rte_constant(e) for MSVC.
> > Here's a link to an example of the hack:
> > https://news.ycombinator.com/item?id=3D16720172 =20
>=20
> Thanks for the link. I tried to use the hack as suggested but turns out i=
t does
> not work with msvc. It results in error C2100: "you cannot dereference an
> operand of type 'void'".
>=20
> I'm open to further suggestions.

Maybe contact the MSVC team? there really ought to be way to do this.
The compiler knows what is constant and what is not since it needs this for=
 static assertions.
