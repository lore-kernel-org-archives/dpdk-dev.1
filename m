Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F6109C046
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D8F402CE;
	Wed, 25 Mar 2026 17:52:47 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id A34CA4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:52:45 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35bb9070644so34738a91.2
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774457565;
 x=1775062365; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVJSMBWseteafKFsEDWSJDEXvUMI6f0sgoOd1Tuwfg0=;
 b=r1/wjckI1PVLytv9kA26r30qqSm/Zq/596MSJmSZ0M3qH1gj0Q9fl3x1YLZLH7b3+o
 n2eMrLilF7YLgFFUyNIEjr2nQVoeF8V7LJbiMNHoVgMAZj5c61QvGapsIM4FkDex4aJ7
 8R4TOufV3/D2siDGIgYVCVh7+BOhLx4jlYG3BjnqUIKLEe7mlSYhU3W3QP0ZXT6vLuix
 6NjC6sWw6TBEA2jZAdEN1wGxa/mUTGG9Nlijcf+CBwKlwZSwgflWfbEw0zKZo9WSUfmS
 xK4LrGwOTglPQLWPukKYkOmZDPFC9EUFBgOQE5/tvwDp+8BSxgJRLctj0WP38m8wjXIW
 4Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457565; x=1775062365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVJSMBWseteafKFsEDWSJDEXvUMI6f0sgoOd1Tuwfg0=;
 b=apqfzKYxE05vg7Zks0h/zDACG71c149s1hGd5JxGfIaX6WsM8s3OH3KRmorxEJ9xma
 Rd8FWYhjNj8BXWJstiZtbJEnb0BKYL5jBtg7VkGMpdv2wWvGo7rE3scqSdCE3h4DVt8W
 Mmj7mHcCmrqBuIKC7ceKKfZfkvmNtLzSy8NPNLJqEHE9wfeLtawVi0A9yyDHqf8zGd2Q
 2h/MCpzJGsJeLtT2+HDKE167oc6WWxzkGeo5FARoc0CH0TT9OgIQTL/ybhVRt60p0v5D
 +tgfEgZUSubOfqpnmVEqHqLwjTZxQJx0/nONoFO6EQk3xnP/pWiDvcuU9FNhj5IYQ8wv
 dVhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJEKn7zoqk1nUFs8Z5fPfg9fxrIP2CHUUwHIgpjhEdAjNABmvoXHgZBHH8KUsvm0rbjTI=@dpdk.org
X-Gm-Message-State: AOJu0Yy5Cqxt5gGwxDuhhHGd3utG8NAO0tluCbn+u0o10z5JJMrr6JWg
 N5GtcFWu6r1fLaTISA7hNkmeW2gJjOwodMZPk2Zx3B/eK+tJGM6uqznvjPtpnT0HmbU=
X-Gm-Gg: ATEYQzxNen5U/37TkXzpDrNYSy9NHuDcEIy2LagPRNnLM+B7xcNLtsHr9f+SpAjIOVH
 ihfP90Ym7Z3UcgrI154CPCOLULRKja2RDviJJ2VWyH8lbCSyxMwyrOhGkD/u4Tb9kLxcIQL/Wxz
 +Jes53PO530JUYfiQps0jYg/pfXTZe/sqsFOF8xiK0SpvOAWmvj2PNNRvqQOCZI+Ur5KrN5gGK9
 VKJwxAU02QdPAPHWniS6xOp/GtJvFzmZWkbzWcdhhx+QGTgfLiLD7Rxzg21XL9rLlfFYx8qcVbD
 1cWbbMjAgewyoWpWi4A/MCjPWBMt85q5aDE4kXcpJ0LqWftbUN6t6IW30rwhbJy5Mwv26+bEv/S
 JKdBduk00c4GTenv3HpxrQeD4v83eSe9PPc9uDg8f5qklzt/zOLXKTXVq2vxpM+8ESrRic58Uq8
 yef5wYaCVDY6fduMNX6nyoVBx4CC7locpEjXt5Fh+UOHAO6w==
X-Received: by 2002:a17:903:187:b0:2b0:7026:24bf with SMTP id
 d9443c01a7336-2b0b09c5dcemr47706795ad.14.1774457564732; 
 Wed, 25 Mar 2026 09:52:44 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm3799475ad.43.2026.03.25.09.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:52:44 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:52:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <20260325095237.612a3d96@phoenix.local>
In-Reply-To: <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
 <20260325091921.687599ec@phoenix.local>
 <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 25 Mar 2026 16:22:45 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Mar 25, 2026 at 09:19:21AM -0700, Stephen Hemminger wrote:
> > On Wed, 25 Mar 2026 10:36:56 +0100
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > If an application clones packets instead of copying them, it is proba=
bly for performance reasons.
> > > If the drivers start copying those clones, it may defeat the performa=
nce purpose.
> > >=20
> > > <brainstorming>
> > > Maybe segmentation can be used instead of copying the full packet:
> > > Make the "copy" packet of two (or more) segments, where the header is=
 copied into a new mbuf (where the VLAN tag is added), and the remaining pa=
rt of the packet uses an indirect mbuf referring to the "original" packet a=
t the offset after the header.
> > > </brainstorming>
> > >=20
> > > Furthermore...
> > > If drivers start copying packets in the Tx function, the Tx queue sho=
uld have its own mbuf pool to allocate these mbufs from.
> > > Drivers should not steal mbufs from the pools used by the packets bei=
ng transmitted.
> > > E.g. if a segmented packet has a small mbuf for the first few bytes, =
followed by a large mbuf (from another pool) for the remaining bytes.
> > > Or if the "original" mbuf comes from a mempool allocated on different=
 CPU socket, the "copy" would too. =20
> >=20
> >=20
> > The problem with the Tx function is how backpressure gets handled.
> > Not sure that it is documented well enough that if a packet is not sent
> > due to backpressure, the mbuf in the array may still have been replaced=
. =20
>=20
> Most drivers should be able to check for space in a Tx ring, or whatever
> other backpressure mechanism is being used, before modifying a buffer.
>=20
> /Bruce

Not in case of drivers that need syscall to push packets.
