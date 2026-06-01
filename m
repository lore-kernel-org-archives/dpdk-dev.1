Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427DCD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 20:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA837402EB;
	Mon,  1 Jun 2026 22:12:21 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 71E7B40150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 22:12:20 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B60137A0106;
 Mon,  1 Jun 2026 16:12:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 16:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780344739;
 x=1780431139; bh=8BxF6XQgL6tZlB575Jq+uQdlgP2vJaejksFI4d7f3Lo=; b=
 Zu3J13XicfnzkEFlmcEW/E+Oy2Ke6+d/GERP4Da6h9Ur0yGXXUj3m9oL4r4iyCq/
 EVvGykXIhWytAOcEbvDqg9Fgyar4g3EN7dAo6LNuDlqF5O5R4YNpCumfOPcHdzCH
 /rr6gYI0PAmOV1Cbt1R3t1SQ/SbO4EilXsqACvpbKUt+Nb2AloUFzUrgnzcEhBHP
 loLW65wKi+tyHgKlrZxppJS5eslFSOE/rdznMFgc6NAVUAZwXSyKl5X5bD7U1Hql
 csxd55QkqrXcUdLp9QKaudGCsG2LbwpTulQ9UBymKFeT03IlZ8SzY8N4K4Pzi4dL
 p9mqOPvrlZV7Snj4Ky/KvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780344739; x=
 1780431139; bh=8BxF6XQgL6tZlB575Jq+uQdlgP2vJaejksFI4d7f3Lo=; b=M
 8BYMUZ/LibHwuoW5Am4oGQnRPXZBOxDqARIrgEWTwHKA7q7gt2/aiyoC2qOZF62d
 jDxIQKafcafwjshA4V4/6vlK8NlsnA9BH1HAe9uHgFemZHCygZgVS/hBq9Be9bQs
 aVOp101mM620iVnZ8Son8HpGP6TLiaz2WBNlSSSSyekyrPZM9PebUSZjarm0DgxM
 B4//ckb53vCyNDhha+ax3FlfiaEXfPIxTllMy1/xOSAO8dsDQpZsoz/F77y9xGLS
 tZT2e7b8/99Sc84DaXJ4/km4uWiW5DGBvZYklO5FUSvu+NsBvEkQniSsX8FZKYor
 O6i8g9Kw0tsBDf1onajmg==
X-ME-Sender: <xms:o-cdas8BoZQEJ3OGjPX3DBavMQjmOI6EVCy6-VQDSEwkyCVtHEmINA>
 <xme:o-cdahCsrN5nQY-O--ZfwuX6ex1j2ezdie5GjEbqJvhWe98lgRH41s48TqtzQfTJ7
 w8ZG1LrOqZueI2OPlfFFmVLvPMxRxP-sAVELV7H9fJ_gxAJPfM>
X-ME-Received: <xmr:o-cdakys2n87XPM6aklENC0mOnI57CLAk2ote92YHIl_e4h3InFZ8NM1Zs4DXBZrBjMqPgU1edug3OcXsyYm8CV0TQ>
X-ME-Proxy-Cause: dmFkZTEtKGRbU/QC+lfkZgTnIPmUuPjYIztHGaDpNx4JmaAzrLHpaEPWcjPppFRjiZTyK+
 dZsZ0ZNOLDtKizdPfoLdYVtu1KA1a72ukaAupLPZe1T3kCMqk84PCQWz3faBKMgGF37NEN
 nBGYqJdwiTFezR7BgX20RI1PowWu69Ff1ZpCauP3K54E2NAzYoT+NLs8UL1vtho0Wc2HsN
 sE30AcERHHm1p7TcsylQMYxU2ESxxXproQEOsAO3ZgaVAQ6EDvF3w7JLNFP+wXYdfIZHon
 4iZfAWI9dtb8aTI4XYIVYq2u7vokGkI5waIzt/K8gbPF1yDzztfjB9vCBj/Fnnas3WcJK7
 6iaV+ILCos2LoOhjflTqoPLzIx4+fFDt9fcQ1ZODXlrW/pjhiJVEshUtO4gc4b6hfDeOQA
 BEJIxDM5X5wF9WBWgXGCh14LSzrceWM0i7ckVF/yH/gwbiUHC8ymaB9mHENXapGa7pKu/6
 BxRijy08f42iUSxTYj7cH68czEdJTpZGXFbkCkAq5wQNn+YaOFtRmH8VI70VSkpSi6nziU
 g08L2t/tP0iAPy5Q7xfMndhnnMxnmobe5qqBTfMPvT2BE6+D58BMyif5JuwizgAetV80NJ
 N4kHi1eQcaZ15nCuYDmE6t2V9E+JXYBLLe4nOVeEHdHQjYXe4emynZ4HNveQ
X-ME-Proxy: <xmx:o-cdauRDi30vq8G-2OBRI_uyUc9i0G_8Kwae-wlNpBkcPQAS4UGSKg>
 <xmx:o-cdaj-2wxWXXuADHi93fOvxShNoenMl4CTSVuqFug67vIdDGTo18w>
 <xmx:o-cdatp7_-UQm-1MjmZ_fTkK-VIrAfzkHOvkTBp74a5MKqRbZQNEEw>
 <xmx:o-cdaokVzJkIKtb0dAyoqqQ-khMjyNmZWlqrYgBezFmadB8QfFrcgw>
 <xmx:o-cdapHWCuRdNlr5qIIh-QYS1XJaQHMrrQH5v4AlMP2nVnt8pmjdl9Ps>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 16:12:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] implement missing APIs on FreeBSD
Date: Mon, 01 Jun 2026 22:12:17 +0200
Message-ID: <CyBAPAuxTMaOXvlKSc2eQA@monjalon.net>
In-Reply-To: <20260525171340.1701509-1-bruce.richardson@intel.com>
References: <20260525171340.1701509-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

25/05/2026 19:13, Bruce Richardson:
> The APIs for converting a virtual address to an IOVA or a physical
> address were implemented only as stubs on FreeBSD, but unfortunately
> they are used by drivers such as "igc", part of e1000, causing the
> drivers to fail on BSD. A workaround would be to change the use of these
> functions with the rte_malloc equivalents (e.g. rte_malloc_virt2iova) -
> which do work on FreeBSD - but a better solution is just to replace the
> stubs with proper implementations in FreeBSD-specific EAL flags.
> 
> Bruce Richardson (2):
>   eal/freebsd: fix memseg addresses in IOVA_AS_VA mode
>   eal/freebsd: implement virtual to IOVA translation fn

Applied, thanks.



