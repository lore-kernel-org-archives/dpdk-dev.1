Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77389CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 723FB40272;
	Tue, 13 Oct 2026 11:04:24 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 254C7400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:04:23 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9713A7A00D5
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:04:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 05:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791882262;
 x=1791968662; bh=H+ZJ19vtBt6N7IhnildWaBPA2qreroLV3SnOT9pWxGg=; b=
 TiG5qnUBq2val5vyQXbABQjsCoLB2jI05vlfQTpU4Sz9bOFbNvvNmGIFAu8OZ4Em
 CUP1nc8DIU/f8OV8S87y1w7nHb9zSXZwY9yjxKTQ5T//ZZHxNCj3x/DG2YGKKm+Z
 NtZb8SsAa3l4YWO6Tg1sf/WMMPPr2gc38Joj5cRFpehRujRfQr+VsgxVPWtkTCzn
 6VPCCCuXef/nR98Y8mEc7v3kN5jgennlVH/Lp2MEMiZH4pvSPkr1pLNiJGMOd9Uw
 l21TTw2ek4ldP9lGmo/D+aMGiiLURmPSnGY0C248D5N5bjkJWxbjW2La29DarloU
 QeYvo6/ntmnHOf4po97j7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791882262; x=
 1791968662; bh=H+ZJ19vtBt6N7IhnildWaBPA2qreroLV3SnOT9pWxGg=; b=b
 kUfjM8BSOaojK54ffrOumN1uBew92P8Us8mPnXfD1hAN3zRHxNA+GsD3KdfkSbjw
 B2muVh2DiN0LysJiixc7kj199AmKaa41n/f/rK37C1LRBYYwa+yHqyCH6j9Te4Iq
 z1eARcSLGmTOVlow0hMAa0E0O/VITvgJV0OA9vpHKytr/bzf+a821k1hBaOLvvGX
 BBc9Fr0+mkaRNbbPy4AA497uQ89GltY+oEaEEKdEuvgX3LDkeuIL+7RCIXgmXZ53
 G6dMAXLLFmvvPrXz9Meoquq/0Ax38495dqTGn5m/1v6IJDH6DBiEbl+BhcwAllF6
 mvgWnALq4/D+yA9IrIw1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791882262; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:K3TYMGGh4ElSwHYphSLC/EBA+NB2qy1imU2HkEEFXz4CyHz
 q+t8byiVMutfY67z+ZAxcaeeaE63q8oXsL41fJa4eARHu85istuFqwW4XW0CMN1F
 EvsPkibJwuMUR12EFo/VDqaYeRBu1BOGBRqHSLQ4RNoZ/U9lS3ds4T9NZGbt74Kf
 V1fR0l2L+AyT6/LnVzpLnWtUbCTzXKcOrhsndHijVifm/aesC0YC8Ez/OYLvDJ0G
 oFjCVtGd2ywF0iEfn7kukudri8yTIkgJoPW81r3veZ+WsBQVdaJwz0UmUnDmIMjf
 4Fq3gC2+atluH+hEfjO+KIsWglIqUOKT2hYciLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1UrB64L7ovyTj16pSe9Qa5xiFYgwGpk9PVhdD80/mvk=:ZDvh06gKOl8GwpRRubEUVuVlYhOk0/dEsHuhr3+46B0=;
X-ME-Sender: <xms:FvTNalhjSxJyCaapoNTNTWfV0AeAyfVFgyfZv98whPb9jsOFMB44AA>
 <xme:FvTNamVJJSy2DH9uwNVpJ2FHB1CK87vdky1s0UkqorvQfSMoufVntko9v2fTsOaiT
 30LM7hHnlbmnh_eMemRPDevjgL1SxKG_1DJjr4mx1RU0EoqT7lKQgk>
X-ME-Received: <xmr:FvTNan0H7Jk4UKtxmLjYtzJFBT1wrilBhw9cTTT-75nWFQepNY5hvz9Z2ZpUNnakV9wMdlAHR44O0jDTYsVhCm4>
X-ME-Proxy-Cause: dmFkZTGhH271NvZVcE6dwpr35WYIjMTMjiyqz+KVTlbXPkZ2O+xd+7gCYshVLqr1+Qs+FX
 BpQodHt5ifCL3zlJfEaznNE0GUWNNqxSTZkCUFNAefWmwepR+E3OLUSj6uaAPFjGZ77cX9
 T55F8tfV9whRu1UihHRC+zEV0VAy1pKbOs7dbGONx4W4XoHSYNyKQKi+Ehy5hrhdsYwXDJ
 Eo7Vn4o+nI3X8U6tz9HIEQOlV2tgXn7sUFrKDjGTkBOGvUO2CyQEr2ingDs5juP9qO3/5b
 38opwwZoYxRTHbOwKjuJQXIj4NLuaYp2+hGwMTcvmOuLU43CcKsXfrKdY6QFp93vaTtvg1
 HgPlLYHPzat/DGiA5h5bBhDW3qVnZ+aj5av7t3yGpa89g6AKzOqF1Ft+PWBwrO10rdxJP+
 x+sAN5mwSyXN6egUzg2DSX0tETQw0P1l/aIqNhyQhnBqm6Pvv6dHUa4NqgtP38OcLwk3MQ
 K+5aWp2XA0Lq42YhXKnb8ar+hnnINceD0IfCMQ+XTQXaQdLJdMhtO23Y9SC7MausXP2KSI
 SczUo03vincDK3LIG6dUgYg4/ojaDxUdgfQSjsbljLOTYvwDE4O9Erhu2doCgLQC3A7iiq
 2GtoQiaOQV5wOL9XKftJ6YTktHWHdUW7GoyHMocFdP/a+UOsM9Om68TotXIw
X-ME-Proxy: <xmx:FvTNasEdCb5MeEVHZezoO8EIiPZaicvi-Y-6TvppYBhmLLZhO6KiqA>
 <xmx:FvTNalgH0hpIr13Sc1v6hUcsOKP-gy_QmX3iADH9UAxFMJxEcrFKvQ>
 <xmx:FvTNan95AFu-9ohSFl5mKs5kk_jFs1wbQH6rpWusUzh8ZpRMZRsr7A>
 <xmx:FvTNaspSNjnwlshEpJkxKYhig4ur3IoMtY74x-GQr04zhFTv8FoKDg>
 <xmx:FvTNaiK9YBFGx-022Uv3zvr5YGwJoEMg3LD-tjJGjXKDR_P0tFGh_XLb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 05:04:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update for IPSEC MB and ISA-L drivers
Date: Tue, 13 Oct 2026 11:04:19 +0200
Message-ID: <td44LEAOTQ2EAXz1o5C3mA@monjalon.net>
In-Reply-To: <20260929141600.3867376-1-pablo.de.lara.guarch@intel.com>
References: <20260929141600.3867376-1-pablo.de.lara.guarch@intel.com>
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

29/09/2026 16:15, Pablo de Lara:
> Remove myself from IPSEC MB and ISA-L PMD maintainership,
> as I will no longer be working at Intel or directly with DPDK.
> 
> Signed-off-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>

Applied, thanks for all Pablo.


