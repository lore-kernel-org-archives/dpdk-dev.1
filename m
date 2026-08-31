Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF79C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A42402E4;
	Mon, 31 Aug 2026 18:47:10 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 461AA40269
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:47:09 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-39647184c73so81346a91.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788194828;
 x=1788799628; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SZqoeKkSyYd+BIve0GavdHbK3HhsC2GFWp2xh3GR4jo=;
 b=vvAuIuyA70RuTAHa1z8yytdZxUCGsaWcrILdu0odZii1t56/dFhpcH1RjnbKzh9acK
 HTzLiSLbd3cz8A2HZWjUpvJeB8EpdHe2qd5M1g+frQu+CzSsBfOjQo7G9qJ7M+IC1vFg
 4cNiQ97rWAB6/XM2qZTGPUQpxTGAry2ajRMiaHlfmQgW/cz9nc2LprteRbm/nULlNpcQ
 Sr0FvySQksSMgJFnLdPo+TyrlAm388qJoOx5u/WDVo7f3X7PbEFMSEW+NEt44W/f6e5C
 mfbOJJj9VDFILzBLzc9GwLP3T+pxPw7stjMtCD9QwECVefKvY4aNF1FQ8mV8T3mGB260
 wwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194828; x=1788799628;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SZqoeKkSyYd+BIve0GavdHbK3HhsC2GFWp2xh3GR4jo=;
 b=kDGTu92GU133HJPKLDwGnOxGrcAbugekHsU3B6o4FHd7jBpyiYCP/Mve5j28UXOMmw
 xC4Q6WO1d6nvEWu+k1A34RxYbttC/uQKhzDaqgljNrahSzyD1ICaFVodhmD/tsBuwcRj
 qGDA5tFFBuXOEy5mxkHaoB4IHrCXbJhO7vBp65XTBJ+RWj42/Sdxn3uHrk9xaEoelkY2
 c6x724e4Igoz04ErAg/qMEvgfrumklOiUu4pnSFPTbsJtOQTSYr+FuDzqH4lC+RHmoqI
 htB9PN5ep2iKrRWeD6MR9tvJxYVh/sHwC4gCLYsvuR4EmZ6bIxDNGVn+stKmgVRYfxep
 UhMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0DeG+RHw/Jku/C/i7e7RSb25lZEpn3TXXmRG+mKg08EZjaRLeK+YN/Al2d51vC/2CggY=@dpdk.org
X-Gm-Message-State: AFuF++l7j/HIbBgQDlYyQPBBOB/LfVXJWH2jB79bhJmijGBjUp2k43eg
 5kDzQdA2QtYW9myrKXGDROFfIjzn8lxLC3aQBnh1+2MeCqUH02PMXLSnogyDadxtJr8=
X-Gm-Gg: AYBFou3n76wUNyQzQfNd26B/1TtgLGZa3WxasLRFKJWQrq146ldC3Qwf3UZHZgnZPx/
 QeAHxDsmr/ymTGYviRouQtORY4BVSHU4nNqIoBSbdXDfppWhoDSTN5sZi8dLUSgz8vwjvssc+78
 Q3hkC63LYObaUq+Ow2oEo2W/RcKUiD+EWIVe2FmqOI3oBag9IGEzKlRMOVZdrrPGIqKLmoWk6+H
 o03eCctBOADJn4COF6eSzjb8vF3AVXt2GUUt4U1soV2tz6nuU1bAGuhrulD3n6UrsHdmiKjkA6u
 PQfxCGfU10YL+tdLRaska0Knz7iH4UFslFWVq4olr2ARSeAx7so0yPFhwk23A1kvoYvLxBS1fNt
 +XsaZRyNaoKSRMPtCpomDAYvvw4mliuWUskI7t+5zG9ejP4pqG4E3Yt2E5Qs7APGzDmPPf4YtzH
 QC4ch6rb0AUiu68tsO8YsNKcL0eyjvROX4gB+92dYNUCVQZJNAauGBAXngKlFAHN/BViARpNciB
 hQMRO3v6M1ilJ5DzKi3M1CM7PD8VQ3Pnj+gVEsx
X-Received: by 2002:a17:90b:3851:b0:398:9bd3:d6d4 with SMTP id
 98e67ed59e1d1-398da8ca7d8mr6053606a91.14.1788194827973; 
 Mon, 31 Aug 2026 09:47:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396d77f7643sm6249395a91.3.2026.08.31.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:47:07 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:46:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Sunil
 Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman
 Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>,
 <dev@dpdk.org>
Subject: Re: [RFC] ethdev: simplify representor info get API
Message-ID: <20260831094654.2cd73523@phoenix.local>
In-Reply-To: <20260831162905.383162-1-dsosnowski@nvidia.com>
References: <20260831162905.383162-1-dsosnowski@nvidia.com>
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

On Mon, 31 Aug 2026 18:29:05 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> * Background on rte_eth_representor_info_get()
>=20
> rte_eth_representor_info_get() experimental function was added
> to ethdev public API in 21.05 DPDK release [1].

You know the API shouldn't have stayed experimental so long.
There is no good reason for API to stay experimental across multiple LTS re=
leases!

The code would be much simpler if you use sentinel values rather than
carrying around all the XX_valid flag values.

With int fields and -1 (or a named RTE_ETH_REPRESENTOR_UNSPEC),
 the whole comparator collapses to something like:

=EF=BF=BC
static bool field_match(int a, int b)
{
	return a =3D=3D -1 || b =3D=3D -1 || a =3D=3D b;
}

return field_match(info.controller, other->controller) &&
       field_match(info.pf, other->pf) &&
       info.type =3D=3D other->type &&
       (info.type !=3D RTE_ETH_REPRESENTOR_VF || field_match(info.vf, other=
->vf)) &&
