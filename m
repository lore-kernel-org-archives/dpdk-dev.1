Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F451CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA309410E4;
	Thu, 14 Aug 2025 18:16:03 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id BA191402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:16:02 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so8000985e9.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755188162;
 x=1755792962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXyV3MgGeUIw98wKDu6QHVqt+g3PIhYa9sTcHJySViw=;
 b=Iq2BBN1c8065L5STLLbl8VL3fQIYMWY/JefWaM2xoPQk7ZSeM4Ul5EoFTgzoCq++be
 ONPWf8rkVddRbqAvWcnBVZW0LhjIE+0GHPAYttRZKccEFPYKjsu+tCHMiQo6iOoEhbDb
 +jP0QbA9fZPscfIzRNfU786uolaD11N5g5Jkgg6WzwwsbtqjCN0p6UNEQfSTNzEIH8oe
 jodihuRkKvVKWVJnwn1mq0spZVwvd+I00VF7UoCGqxUttXN3cf/cz7bEc7m757lKbCxO
 2mkurZqWolZ4JBd0/6VCTX/q87z1qJXgPxH/YBNusYBnIp1/KT4FWAdsD9M5gbh5kU2H
 CfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755188162; x=1755792962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXyV3MgGeUIw98wKDu6QHVqt+g3PIhYa9sTcHJySViw=;
 b=pqEpQoTFBRpnup4ex0JfzLPLrKPM8BS10v5up6+8JuZK8RpNTqSdgLkBHPSldQAVta
 4jeydUsXUMRZ51LmoIodWgQULSroY+yIoZmsxkQKg9g+48Ik0yajk+BJmbUR6ElaNHBK
 H6/0o3BStZdNsuLJ7C4wF4a14rJx8m/gviqcJf8g/+X2pKoz2X0MR4nuHiKvHpWDMvaP
 8AKhfKLv/E1hOFZ6Z8ytNgzsQCYJceiErhdEjM4X10z287ohdJ8c/XeyvxMp3OmNlbaS
 TO9ZipXC0rOhR5IAUVyyqyveU99mKAabpBEf9OQjWhgH0BvRmh9aFsSgjvPeAEy6RU6+
 ZsIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIiV2Dyeoe+eEMDPGjrmTO2K+SMnCnkx2M/wGkyh1VJKys5dv33Gp3hb9pairnxhsXv1M=@dpdk.org
X-Gm-Message-State: AOJu0Yxxt4JpqsHMatU97z9yntv6Z7sco4TotZw/xm3jWIoWoeji8xd/
 7jl18TZneWW6gBlLlHFsnz+X3gWmgRRdR8g54ks5sULHD3rI/X5Vo3syNll2rQW4wvU=
X-Gm-Gg: ASbGncsgD62wSaMy4iXw85uvT7jckhC1IUuJpgStYWZjZ1VojzOdJGlPCsatB08L9vb
 B2cINjE+RlaEeE+ERsiJ53/RUMPAOyo2X2FBm4fMC+UVOh3g0ysOhAby7CkPH/8t/x4Gv4AZgYc
 /4NOFD9DNzHEqSjjCgJCwu75w62c3XWccyF4KgChDL4HySSLEgR4qsIbu2A7sBRxtlnSm9UFm3o
 9L0lgv1NKnaO1y4ATvk7pH3uiBEDlIh91Oi5b+Rs/gRRZt7k+cYX8MpzO+6KHaMuv/IuY4dCDMV
 tQMb6lUTqYZJgiNFeGPHSCgJgMBh70482sPsJTngnLS0r9tMR/Xi6mFLr7awrh5m1unrMoIJ3FC
 IIOozL7Dp2wr/j5BLX38P39lX4rWaB6K30suyPhGFDfk0Je8vG2TAEmFMnF+xkoF61Z+WP9UMvh
 0KutkRXIvsTA==
X-Google-Smtp-Source: AGHT+IFtYviG45ewyW24DI3If9QzE7arRaYYl9Xo28l2bbtVaGHXDluR58Rg27nDar7NvRMnXbPHOA==
X-Received: by 2002:a05:600c:4ecf:b0:458:6733:fb43 with SMTP id
 5b1f17b1804b1-45a1beab483mr26008305e9.19.1755188162137; 
 Thu, 14 Aug 2025 09:16:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6bc93fsm26524915e9.2.2025.08.14.09.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:16:01 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:15:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <skori@marvell.com>, "Thomas Monjalon" <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>
Subject: Re: [PATCH v4 1/1] ethdev: add support to provide link type
Message-ID: <20250814091556.6db159d0@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
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

On Thu, 14 Aug 2025 11:04:18 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: skori@marvell.com [mailto:skori@marvell.com]
> > Sent: Thursday, 14 August 2025 10.10
> >=20
> > Adding link type parameter to provide the type
> > of port like twisted pair, fibre etc.
> >=20
> > Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> > to a readable string. =20
>=20
> Please consider if "connector" is a better name than "link type", if this=
 is related to physical interfaces only.
> E.g. is there an "LACP" link type for link aggregates (bonded links)?
>=20
> Also, should a "virtual" link type (or connector) be added for TAP/Virtio=
/VMXNET3/ring and similar non-physical interfaces?
>=20
> More comments inline below.

My preference is that a new feature like this follow what other commands an=
d standards do.
There is Linux ethtool as the most common example.
Also, there is probably something IEEE standard but that is behind stupid p=
aywall.

Ethtool on real NIC.
# ethtool enp87s0
Settings for enp87s0:
	Supported ports: [ TP ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	                        2500baseT/Full
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	                        2500baseT/Full
	Advertised pause frame use: Symmetric
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Speed: 2500Mb/s
	Duplex: Full
	Auto-negotiation: on
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	MDI-X: off (auto)
	Supports Wake-on: pumbg
	Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link
	Link detected: yes

And on virtio
# ethtool enp1s0
Settings for enp1s0:
	Supported ports: [  ]
	Supported link modes:   Not reported
	Supported pause frame use: No
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Unknown! (255)
	Auto-negotiation: off
	Port: Other
	PHYAD: 0
	Transceiver: internal
	Link detected: yes
