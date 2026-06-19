Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91979CD98F0
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 02:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6897C4028F;
	Fri, 19 Jun 2026 04:03:44 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id A0B654027F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 04:03:43 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso2111832eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781834622;
 x=1782439422; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqGi4UWf3YOzndexT1yR1iMgthTibqmE2bb+jZMmwPY=;
 b=yk1gWsWj6A90cN5MRSqhQL2qDn6svjfukGNAkBUW3+LM4sj9k4ypboEBBVuSlzfxNj
 Ievi4U+vGBP5hj/1yjtEOqcvYefT6OSvryAomAddBFwfYfRMoH2+jxcZeE7s6IariogU
 xvIHqCoR8bkmWncv2sZmJoiJ7J7s3/9lVL8DU4uF6eC8wEFTRxYkaTIw6m5V9srH2fXT
 6ex/paHEqjtSBgyaXcZZQy15nijzmGaK7m0ATe4XBArf9rEe0/BmIrGndQXHwCCh4Qa2
 4YxEBkxgaGahzodoXfC0Hhv8HgEXOPblr1VhT5ptdX0nNsg9gj+CPG+q66V/8/mlJxGy
 CtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781834622; x=1782439422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqGi4UWf3YOzndexT1yR1iMgthTibqmE2bb+jZMmwPY=;
 b=ViuN6wx8piIvpPXWTBL2RWQ4g/fY9XfVB/Iz6nyTx6ZobG5DQW0dvn6XfX/mRkF99l
 O+CcpiByWuKEVnX9RG6wPnPo1UeLu+UtUrvRgh7zGmLjx25jxW0LZcbuTARE+6kxIfLt
 PoWxFeTXq6S76hRgSXTgxXEbofi061jfTmdFuFRUDsSPEVxOWtlTOU6ql/uorWO7qy8Q
 OH9M8airsZJKaq+NgHMGdkcd5dD9kKhwcvaM3TBd6VD1zwTBQsCOfkJUkTi00MH7buSV
 LEIu+9GMzrWL8PGPfWnSTHkp7i2LwfzZ9qB68XXbw507dR6DV1LVaPoxFV41RZ1P7sbg
 pYrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SIlObPAXoCP7NVkQJJY4EXDV9yThBdafqe22yC/3CnNfBRIxsFkVBob8wJV6fhwsS56o=@dpdk.org
X-Gm-Message-State: AOJu0Yy2mBjr9uhbE6h3tZV4zvVaB6dYLvHUzDw1lKzJtMvV3cInvGjM
 u8D9oIxziT4T7yD4ZJoPguS2v48408A0V9Z0upi4JzIpS73ziw4daU06LIHa39VPrB0=
X-Gm-Gg: AfdE7cneXT1pBHhpF8nVXys9PVAtk55qpVvyNRnxAZqpxu/BlH0ayq5edmUAHT9UtZx
 7FtsGI1t8elZb07YHRicqwsSe6SKUWmWaiHy8zUUGCQRGnYW95tX5R+Yj/zYc729TVsZLrRGl2r
 U1hUl93dWEpFS+G2WRxmEPEIGXCkNFeiAEXAcJqfK8R1Dxi9RFoEyZnBdGdQ6lduox6xbQb07tS
 9CI3acfJIARZoN9k3jm//+woBal27tQlomyeyaHuw1PB9cuB6wSIg2st2gGVvuCrd/NPNYmH4+Z
 ru/lNlgYBu3GOwN4VLhWkAt+vt8xw6jpJCK4tLh5ghZN4cuKLsx/9HIhCYIPyUUUlC9/SkCBdqC
 VJw/uzEKj7J8FdRwW4CdHQlYeh/eWcFyXmjXz5MqPBCvipiEQS66P4fqR9EZ0HA6L20a5K+3UYK
 kCftoQMXtdhrp54EDI+SkvoWRYJ5xn4wT9cHrxGVKxEROSopUL/ySwrQ==
X-Received: by 2002:a05:7301:2a0d:b0:2ed:e14:e956 with SMTP id
 5a478bee46e88-30c070a6940mr1278498eec.32.1781834622383; 
 Thu, 18 Jun 2026 19:03:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d40141sm1034425eec.21.2026.06.18.19.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 19:03:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 19:03:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Huisong Li" <lihuisong@huawei.com>, <thomas@monjalon.net>,
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Message-ID: <20260618190339.2fc76616@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
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

On Wed, 17 Jun 2026 13:48:37 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Huisong Li [mailto:lihuisong@huawei.com]
> > Sent: Wednesday, 17 June 2026 12.28
> >=20
> > Add the RTE_LCORE_ prefix to the lcore role enum values in
> > rte_lcore_role_t
> > to follow DPDK naming conventions.
> >=20
> > - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> > - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> > - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> > - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
> >=20
> > Old names are kept as macros aliasing to the new names to preserve
> > backward compatibility.
> >  =20
>=20
> Series-Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20

The problem with this patch it causes build failures now with abi diff.

Example build log...


2 functions with some indirect sub-type change:





=C2=A0[C] 'function rte_lcore_role_t rte_eal_lcore_role(unsigned int)' at e=
al_common_lcore.c:74:1 has some indirect sub-type changes:

=C2=A0return type changed:

=C2=A0type size hasn't changed

=C2=A04 enumerator deletions:

=C2=A0'rte_lcore_role_t::ROLE_RTE' value '0'

=C2=A0'rte_lcore_role_t::ROLE_OFF' value '1'

=C2=A0'rte_lcore_role_t::ROLE_SERVICE' value '2'

=C2=A0'rte_lcore_role_t::ROLE_NON_EAL' value '3'

=C2=A04 enumerator insertions:

=C2=A0'rte_lcore_role_t::RTE_LCORE_ROLE_RTE' value '0'

=C2=A0'rte_lcore_role_t::RTE_LCORE_ROLE_OFF' value '1'

=C2=A0'rte_lcore_role_t::RTE_LCORE_ROLE_SERVICE' value '2'

=C2=A0'rte_lcore_role_t::RTE_LCORE_ROLE_NON_EAL' value '3'





=C2=A0[C] 'function int rte_lcore_has_role(unsigned int, rte_lcore_role_t)'=
 at eal_common_lcore.c:85:1 has some indirect sub-type changes:

=C2=A0parameter 2 of type 'enum rte_lcore_role_t' has sub-type changes:

=C2=A0enum type 'enum rte_lcore_role_t' changed at rte_lcore.h:33:1, as rep=
orted earlier







Error: ABI issue reported for abidiff --suppr /home/runner/work/dpdk/dpdk/d=
evtools/libabigail.abignore --no-added-syms --headers-dir1 reference/usr/lo=
cal/include --headers-dir2 install/usr/local/include reference/usr/local/li=
b/librte_eal.so.26.1 install/usr/local/lib/librte_eal.so.26.2
