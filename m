Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB60CA6015
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 16:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E397B40274;
	Fri,  9 Oct 2026 18:14:09 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id C38774026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 18:14:08 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso14427055ad.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791562448;
 x=1792167248; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uc0Txc5PvvF41XQ64r5W/aWd4OsKdTsNxQjaxTkO9CY=;
 b=J2/KczJW8ZWMNJ47JoZEGFH9hRa4pUQpYJ/gRMQCMBQFw5EDOlKk0PKYFLkdgc+uwX
 Iravid1/XkpbfM/d6erjdbgwReCZTy1e7H22TfF6Pn/5zO9Sak3M83yJdlMrcnorBPFi
 yKVE3yTuEGROvJU9J6A5tC6QcJnteNTf6/PAftTYWIlaOPJZmoxCWzLh2DhmgapCVHcL
 MNT7HjAq3rq7rJsvdvth78Fl29t0tlelvlygP7W1D/ag9/YAOjfnOfY4SACJOatN68aX
 Y43YB3gEW3MP64ZLsE1Ls4MUKJ2et7p/VTwWrWTG1SPXffBnhPyxPdnfTiXr3DlYujl2
 Vf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562448; x=1792167248;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uc0Txc5PvvF41XQ64r5W/aWd4OsKdTsNxQjaxTkO9CY=;
 b=WIc3ESfARYhqEV6LisIe+XpYMARs+UVaSOZAtAQ9Ld0mWbZaueBu4A0sF9TDv8lXRb
 y1Hi+qJU1UN7glmwOfZCA7phLx/UbNmwZ3L0dvQDrS632aYV3Ofzvp2jTcthF4R9gyg2
 5m/nwOXqdTNhvP7Mt7Y8sdXCzStT35NZfK1/FcPvNzQ5/T25W4DnyRX7Rax3ydGtLwFZ
 +h7NqJJs5n1SamcxicOSSInBJDc/iNSPqQ8kNLwylRJzzYy89VpGt2FEpIzxlBJBm8bg
 USuFbB5GgTaeOsqGhQJqmDfx/B/GN1GfG4ikhRxZhBrM2ISeqIzBUXJXC8KeLQttqftB
 nmtQ==
X-Gm-Message-State: AFq9FYJmLWgfrw3IWlRyzJ9SX0pAaeGoeYGTDUH1UDGbyWxnZQvCB6ig
 bWCN2UWS+F0eKBkl+swWqY4vx0djid3JcnjPHDSnwnj+YftzxUJ0Br9lMRPK93cY67Y=
X-Gm-Gg: AYBFou0WPn2Mp6uHWAjp0o9i9VseuwUMBVPTC0sCYIyBX+EZ+9XYjgbo4Yew1MUiq3o
 9BUMaHbLdVismzkp1k/DDt16jDqsZhfMoWo6BK8Np9aHh43O76C5N7KINl0PUtNYzsIkBxiqehb
 5nYN5LV/pC1BZCKxcwWuBw2oeFcyx3Ldj+Hfh3I+rFgYTkPIGbp7xYvxJfCZNAem0bkJQoJRFvw
 l7v5ufbWrqEvOwLnic5EyJmk0V1Sswc/T+lmg5XBAI6k7sJs13c5uHRFZNUU3Jyu/Gau6q+GS5R
 yeogq3L17ZRgXwGdf4LwGaOMiiafrQu2TCZ2M5PS6fqwfGnGg5rhfXzqCuvPeZSLc8AgoaZ9sxO
 O1Z8saPWTFIyae7w/P1ewnOAtyUcF/3RLVcjRkhQPGtaerFVjsaqH3FZVCvFDwksgfvXfbutEo4
 FqaoJVrMXMuo1BCFT/q33QTMGBi50Nka1zcDnY6XMIweysNyfkGVcIvtK0P49WDKQyhiFzpxYe5
 0WbcZRo9NICmjoZIvN05OWNV+qm//tiok5ho6j3
X-Received: by 2002:a17:903:22ce:b0:2e8:3639:1a3e with SMTP id
 d9443c01a7336-2e842ac90afmr20781515ad.40.1791562447730; 
 Fri, 09 Oct 2026 09:14:07 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8dc4sm12359285ad.59.2026.10.09.09.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:14:07 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:14:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Randy Tice (rtice)" <rtice@cisco.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: Re: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
Message-ID: <20261009091405.46b9f3bf@phoenix.local>
In-Reply-To: <PH0PR11MB7616A68AC3EA1349948CAC75A9932@PH0PR11MB7616.namprd11.prod.outlook.com>
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
 <20261006095123.3166b4dd@phoenix.local>
 <PH0PR11MB7616A68AC3EA1349948CAC75A9932@PH0PR11MB7616.namprd11.prod.outlook.com>
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

On Thu, 8 Oct 2026 16:15:26 +0000
"Randy Tice (rtice)" <rtice@cisco.com> wrote:

> I did a brief look at this and still not convinced about the exact use ca=
se.
> What is the problem this is trying to solve and why can't it be done
> by using existing API=E2=80=99s.
>=20
> #RT:
>   Our implementation currently requires an additional 256 bytes of metada=
ta per
>   mbuf. That does not fit in the existing dynamic-field storage, so today=
 we
>   carry a private patch to extend struct rte_mbuf. The goal of this work =
is to
>   replace that private struct change with a supported upstream mechanism.
>=20
>   We did look at using mbuf private data first. It can work when the appl=
ication
>   owns all mbuf pool creation, but it is not sufficient for our case with=
out
>   another global/base reservation mechanism. Some mbuf pools are created =
by
>   drivers or libraries rather than directly by the application; the CNXK =
inline
>   IPsec/OOP meta pool is one example (NIX_INL_META_POOL, created through
>   cnxk_nix_inl_meta_pool_cb()). To make private data work there, we had t=
o add
>   an EAL argument that reserved a base private size for all pktmbufs, inc=
luding
>   PMD-created pools.
>=20
>   Private data also lacks a central layout registry. If multiple modules =
use
>   private data, they must coordinate offsets out of band to avoid overlay=
ing
>   each other. The dynamic-field registry solves that coordination problem=
, but
>   the existing copied dynamic-field area is too small and has copy/clone
>   semantics that are wrong for this metadata.
>=20
>   That is why this version uses a globally configured per-mbuf metadata a=
rea
>   managed by the dynamic-field registry, with explicit metadata fields th=
at are
>   not copied by generic copy/clone/attach paths. This direction came out =
of the
>   prior discussion with you, Morten, and me: avoid a Cisco-private mbuf s=
truct
>   patch, avoid per-pool private-data layout coordination, and keep sizeof=
(struct
>   rte_mbuf) fixed.

You uncovered a design flaw in the CNXK driver and the=20
proposed solution is wider than it needs to be.

All mbufs visible to application must come from mempools controlled by the =
application.
The design of CNXK driver is wrong, it shouldn't be using a private hidden =
pool.
It is ok for drivers to have hidden mempools that are used for non-visible =
things,
an example is the packet capture mempool where the mbufs only go into captu=
re stream.

More long winded AI description:

On Thu, 8 Oct 2026 16:15:26 +0000
"Randy Tice (rtice)" <rtice@cisco.com> wrote:

> We did look at using mbuf private data first. It can work when the
> application owns all mbuf pool creation, but it is not sufficient for
> our case without another global/base reservation mechanism. Some mbuf
> pools are created by drivers or libraries rather than directly by the
> application; the CNXK inline IPsec/OOP meta pool is one example

That is the real bug. A driver should not hand the application mbufs
from a pool the application did not create. The Rx queue API already
takes the pool from the application, and rte_eth_rxconf can carry
more than one (rx_mempools). If cnxk needs a meta pool whose mbufs
reach the application, it should get it from the application, or at
minimum create it with the same priv_size as the Rx queue pool.

Internal pools are fine when the mbufs never cross the API, e.g.
dumpcap or the bonding LACP pool.

With that fixed, the existing private area does what you need. It is
per pool, sized by the application, and is not copied by copy, clone
or attach. Offset coordination inside it is the application's job,
and if a registry is wanted it can be layered on top of priv without
changing the mbuf layout.

So my answer to option 1 vs 2 is neither. I don't want a global
layout knob that puts a load in every inline helper and needs
per-driver range checks, to work around one driver.

What I would take:
 - cnxk: validate wqe_skip/later_skip/first_skip against priv_size
   and headroom. This is a bug today, independent of this series.
 - cnxk: meta pool comes from, or matches, the application pool.
 - ethdev: under RTE_ETHDEV_DEBUG_RX, check that received mbufs
   belong to a pool configured on that queue.

Nithin, Harman: do mbufs from NIX_INL_META_POOL get returned to the
application by rx_burst, or are they only consumed internally?
