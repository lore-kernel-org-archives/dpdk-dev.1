Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8537C369B9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 00:03:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89EFF40655;
	Wed, 16 Apr 2025 02:03:51 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 372C340289
 for <dev@dpdk.org>; Wed, 16 Apr 2025 02:03:50 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7376e311086so8102954b3a.3
 for <dev@dpdk.org>; Tue, 15 Apr 2025 17:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744761829;
 x=1745366629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAI3z3EZ0HgFXkFYuvn6Is4g+ZlEkCoEGR8tRStloxI=;
 b=FMLnMniCVDU9jZVpwRBzyE4/T78jmarfresehYTVxI3m8XPCzPoTmWvwzISTlBG35Y
 QIkbNZk7ig/Kh/X0vcePBWw2rWMgXM7P580rEKNjzCZnurYVU8j4n5PUAxKQdoBDqI7Q
 GTj1ztd+sZWpjecnxA6sCkQfgVS5YKhSDnbUJ5dZG4pnT4wl1XYz0GTz+FPzBJgEkrAh
 munDbGrcAFWEuhRKV8z/MuS3wXF+nHsU8kw1n2HDHyqBNEkolltEmrN2TX6dH/zYFtAG
 feVJIKKNxN1+0sr9/MvknjpYxd7qQsHKa0DXuvEhuPZBk2v1irqV3YDQbiDfsp3L5xaH
 kZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744761829; x=1745366629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAI3z3EZ0HgFXkFYuvn6Is4g+ZlEkCoEGR8tRStloxI=;
 b=FUfVZAdJX0i8pFYLsTewsYasWhAanr8Kg++AcTfRdFOl+xNvBI1UHNgXj67fN7ybcx
 ils+zAj4kkXvEfAdXDzwePxYqpLQV4s9Df9jnhIEy+05KmjQfMFjQttHZJ6GA3U+3Uo4
 ur8gg4HrmGzDS/MnFEfy+QJLrg1DEKiDahUFJAQrEVuVowu/Rn3HT7EsRW4IqqgewpQo
 VQb2Rff+4kLnKFqgrAewYUT5JjxC4N82CcpIUeiLhygCVjiau4cA+Te1hK3JV3wvIOpm
 pNMP4moxsM+k7OyPMHEnb/ZS1Fbow6BQz+jJHF8g8OHTjjAiiLuQyvcY4JY7iW1DBF0n
 yk3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAbXXTk7U9dUrPaeP/gmhBbLWDYD1++9TLvNTC9lVJEvaTZgsh958piDmeNP5FgKZ+iv4=@dpdk.org
X-Gm-Message-State: AOJu0YyOTFznYZRhXhfIfN9HdZiv1QMhWri1krkW936U1CPpAxJaajmw
 +ojXNlmSbhC/48E96TrNoLNyp4QcsWjiy+uQPQwfoFaVOO94RFmzZk1aIBchl9Y=
X-Gm-Gg: ASbGncsfU8I/+TP6Xw6t+XIZymjoHWhDtRShWhtKwA9UjwKwJ5dQjRVmPUyjQazBu7/
 kT8RXWuhpF9wfhDJ4Jvs2vvHLlVi+atjBO9XJbJq+heIkGGQA4Z1mlcedqLoIdlVNEhL+TkRgUq
 wSQ5JPJ9fVH/U3Gi2pbIh0wGI8MjzPXrDvYWdGDVDw/F5fMgqFYUR7++8KyMqBzJhk1qnmrfiip
 K0soNZg9mVwtuSWsXE00bV6Nx0UKVQ7io2r6S6xCRGopLtvPrX3TLXTaTI3N+OP9+HZBk0iTPgg
 OBxo3bE3x9nyMyFQg1iccZ8TrpCsxOonDIGa2mKTwUXBRTrmEJKQyFyTxH7DszZFra9TMS4WWlH
 yoIEbdxqnjAi/azQb
X-Google-Smtp-Source: AGHT+IEbzkKrLcP/QjZyCcx9Ty/QImXiRZWQsape9DaU6StO8WrowrWuPBZ5BRgKJXBsRow9kmvzhg==
X-Received: by 2002:a05:6a00:4408:b0:736:5b85:a911 with SMTP id
 d2e1a72fcca58-73c1f8f5afamr2566635b3a.8.1744761829200; 
 Tue, 15 Apr 2025 17:03:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f8345sm9408959b3a.105.2025.04.15.17.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 17:03:49 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:03:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nithin Dabilpuram <nithind1988@gmail.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
Subject: Re: [RFC PATCH 1/4] ethdev: add support to provide link type
Message-ID: <20250415170344.1bef377d@hermes.local>
In-Reply-To: <CAMuDWKQ09WopqXqxhkB7NhHgTi4v=N4xG5z0V84b2xPPZGgWxw@mail.gmail.com>
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
 <20250403174647.1d9e5742@hermes.local>
 <CAMuDWKQ09WopqXqxhkB7NhHgTi4v=N4xG5z0V84b2xPPZGgWxw@mail.gmail.com>
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

On Tue, 15 Apr 2025 12:38:18 +0530
Nithin Dabilpuram <nithind1988@gmail.com> wrote:

> On Fri, Apr 4, 2025 at 6:16=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Thu, 3 Apr 2025 12:38:34 +0530
> > Nithin Dabilpuram <ndabilpuram@marvell.com> wrote:
> > =20
> > >  /**
> > >   * A structure used to retrieve link-level information of an Etherne=
t port.
> > >   */
> > > @@ -341,6 +354,7 @@ struct rte_eth_link {
> > >                       uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[=
HALF/FULL]_DUPLEX */
> > >                       uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[=
AUTONEG/FIXED] */
> > >                       uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[=
DOWN/UP] */
> > > +                     uint16_t link_type    : 5;  /**< RTE_ETH_LINK_T=
YPE_* */
> > >               };
> > >       };
> > >  }; =20
> >
> > Seems like an ABI break, and not sure that all drivers will fill those =
bits with zero now. =20
>=20
> Generally ABI is between APP and all DPDK libraries/PMD and not
> between DPDK libraries and PMD ?

The problem is rte_eth_link is returne by rte_eth_link_get which is exposed
to the application.
