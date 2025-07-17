Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0701C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 21:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49D71402B3;
	Thu, 17 Jul 2025 23:03:27 +0200 (CEST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5CC164014F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 23:03:25 +0200 (CEST)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-e8c475ecd5bso1214853276.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752786205; x=1753391005; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5KqQ4QfTrO+GqDRV4r0N0Ny1OmTbZxIWzP/CF7d5MbQ=;
 b=Fc0eMM47jHiwybD880LiJnkhVHFLRIvpaaWcydyoewqz7C3RoDmhgubvoVlOJRgSMN
 WNZxH7e0Htk/6Fdv2RsLO+h4A1gBw61m1csxbk5uySATgUbJBzNC2IufQKgrqgTOaCW/
 d3yFZcPIYAJr0OisfyImuXupwoAUXXqMQGG+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752786205; x=1753391005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5KqQ4QfTrO+GqDRV4r0N0Ny1OmTbZxIWzP/CF7d5MbQ=;
 b=Ms0fMLjYY8O8B9t2DJyNY5ZdJ/75OVgb/X+Oi9e/0hnmPVoeaLOAd1+O9DLldWagUc
 5WfdkrQkqBWyJs9tuusKxAdLvo50ee6hnAI9TEsHLQxM1E6UXsLE2LnQR2zCK/lxj3UY
 8B9arMycgskRuIhAgVIqnNydx7DplpIDx2nESuFfS6ePKuj+zAAu5KJoLX3daKDETHsk
 xCh74VfIXQLEutwDE1unejcao9RUl9YHtJIB8YElfYxS4SnJALJS3rm4JJtitz71eHW7
 dUz3aViwesC/nf/nJvBArsBjxhSgbyCJjPT06Pk6tKGOUiOvuINmKkPOkaJAjuvQcaY6
 I1Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLVeeOKWmLnGsu9lCnBIHKSLmPm4Ze8pwiEdbjSX7aAZnC7Tl7jvABm4YUbSVgFRjMpgI=@dpdk.org
X-Gm-Message-State: AOJu0YyRf6cxmGrjhJx4IjswTmKUgflgQuZnTZfa3kj2J5h85BU3NRRy
 XgmDSl9rt77+mMDXYId18xZSpeguqw8M8bz173Wt/WEZIP8wf3Pkjkf7Z/b8JG8zjIMQ9mjCdGi
 p1DmQq+UyH+evf79wUj9MALx/m3UkcgF5VNb9JaAb6g==
X-Gm-Gg: ASbGncsuDohef0AUFSVerIYT8Afr2Vv0NVXh7ixblwYtbycy9Sf4rWZPSzYTuRfw0nU
 VA+wDG5IsvkhagPBY/IIsZkxv3HtaaGdjicrncasMkaWIR9SIecrePUopfpAG7Pq6k8Drm4KXpM
 xclaxY7758CRD1tRWnIZ7OpP7MGkdIgTdc4B6YLn86GgfKJqc3VmIYK14LQBZttK65MRI5tNPMh
 rvZwX9n9g==
X-Google-Smtp-Source: AGHT+IE+tHtN2SW0gIDxK0BxKZ4R1lOjbvoJ6+mzVSebQP/HXD0RXG73JAb8RmKskgQQRKnvtBs1E6WYJ+ZNox5JBr4=
X-Received: by 2002:a05:690c:3692:b0:719:4cff:16db with SMTP id
 00721157ae682-7194cff3ac6mr18942127b3.25.1752786204389; Thu, 17 Jul 2025
 14:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 17 Jul 2025 17:03:13 -0400
X-Gm-Features: Ac12FXwBqYdpyuHu9sdVDOR7IOT1ODZCbKhKj4RuWQz2aTpdgz_724xXfdKv0v8
Message-ID: <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Dengdui Huang <huangdengdui@huawei.com>,
 Vladimir Medvedkin <medvedkinv@gmail.com>, techboard@dpdk.org, 
 Patrick Robb <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 stephen@networkplumber.org, 
 jasvinder.singh@intel.com, thomas@monjalon.net, aman.deep.singh@intel.com, 
 lihuisong@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
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

I've created a v1 of a QinQ test suite around the set of test cases
discussed earlier (which is not set in stone, and I expect it to
change significantly across many future versions.) The PASS/FAIL
values can be mostly disregarded in the context of this conversation,
but I've added logging to explain which packets are sent, and what
happened upon reception, which I hope will be more informative. After
running on mlx5/i40e drivers, I got the following results:

test_vlan_strip: QinQ strip OFF and VLAN strip ON
test_qinq_strip: QinQ strip ON and VLAN strip ON

i40e:
    test_qinq_strip (sent packet: Single VLAN): FAIL
      reason: VLAN tags found in packet when should have been
stripped: Ether / Dot1Q / 802.1q (0x1c) vlan 1280 / LLC / Raw /
Padding
    test_qinq_strip (sent packet: Stacked VLAN): FAIL
      reason: Expected one VLAN tag but found 2: Ether / Dot1Q / Dot1Q
/ 802.1q (0x1c) vlan 1280 / LLC / Raw / Padding
    test_qinq_strip (sent packet: Single S-VLAN): FAIL
      reason: VLAN tags found in packet when should have been
stripped: Ether / Dot1Q / 802.1q (??) vlan ?? / LLC / Raw / Padding
    test_qinq_strip (sent packet: QinQ): FAIL
      reason: VLAN tags found in packet when should have been
stripped: Ether / Dot1Q / Dot1AD / 802.1q (0x1c) vlan 1280 / LLC / Raw
/ Padding
    test_vlan_strip (sent packet: Single VLAN): PASS
      reason: VLAN tag stripped from packet
    test_vlan_strip (sent packet: Stacked VLAN): PASS
      reason: Received packet had outer VLAN stripped, with inner VLAN intact
    test_vlan_strip (sent packet: Single S-VLAN): PASS
      reason: S-VLAN tag stripped from packet
    test_vlan_strip (sent packet: QinQ): FAIL
      reason: Neither tag stripped

mlx5_core:
    test_qinq_strip: SKIP
      reason: Required capability
'{NicCapability.RX_OFFLOAD_QINQ_STRIP}' not found.
    test_vlan_strip (sent packet: Single VLAN): PASS
      reason: VLAN tags found in packet when should have been
stripped: Ether / 802.1q 24:8a:07:aa:83:ee > 0c:42:a1:54:25:86 (0x1c)
vlan 1280 / LLC / Raw / Padding
    test_vlan_strip (sent packet: Stacked VLAN): PASS
    test_vlan_strip (sent packet: Single S-VLAN): PASS
      reason: S-VLAN tag stripped from packet
    test_vlan_strip (sent packet: QinQ): FAIL
      reason: VLAN tag 0x8100 not found in packet: Ether / Dot1Q /
802.1q (??) vlan ?? / LLC / Raw / Padding

Hopefully this can give a clearer picture of the current QinQ/VLAN
strip behavior. If anyone wants to take a look at the suite I'll link
it here:

https://patchwork.dpdk.org/project/dpdk/patch/20250717205718.108826-2-dmarx@iol.unh.edu/
