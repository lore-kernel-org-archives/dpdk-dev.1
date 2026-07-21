Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82FC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7730040609;
	Tue, 21 Jul 2026 11:56:56 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 3E66B402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:56:55 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A6BFD1400101;
 Tue, 21 Jul 2026 05:56:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 05:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784627814;
 x=1784714214; bh=m3fZDQCFx1ATQnr5qqeInjxKYTTgoe8zgOkw18/ywvA=; b=
 i2yqADTQuGHuMCfnMXnYcN0Ukd7eg3/SYxHMKmnvQnN/Rv1tjno03UzjAqPgkEth
 DD4yW9wzt/PafT+2M44Qr6ISuSVL4yFQ4mP3xGXEf9HRxoKabJRERqO0wRHT/kE3
 +TdDgU1TaIJ3IX+R5MfPM8Nds9cXqjgJJQmdbJjtEMB/7tAcrxSpBJfFYBfS73qc
 SAPIaDJIUaCwwWZtUye7AWfVllKK4xw8fXVHYMFfvrQvGuQ8E0NCuzZrztw26NJO
 LAaGmp2xSjoMxzly01rKOiv+HECPkT9QpHNgvb+Id1q10AMg0H2mFEVEK2n+sI2i
 SEMK5fsV0we1XBHworRsGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784627814; x=
 1784714214; bh=m3fZDQCFx1ATQnr5qqeInjxKYTTgoe8zgOkw18/ywvA=; b=M
 z3tX5l9yUlJaJ01fopTQJVpyuQukhFx6zjGtj/rjzcsd4FCzmz/ooC5cRsLEgNT4
 gg+1i7pE7C2jhH3OuUkdMtzgGjHc6/ipqgHIEa8O2SfKjxjmBga98maNnSYFyUxK
 b47o/E59Lfkawkvt/ONM4xr5RUdjYYFFBlZ/y3eXQH29OuUusegu3cwRyHRWqDeT
 WWKW35VE8BCFya6wAeAmezZlAztbFNpKcbDFvkWufB9civ8rypPR+MJv91BRYkCK
 /jMdWrmeRxn1lT7lrSAHKqdsPfHa9jDFb35OYHmNQU1CfCtwpAQNiGuJBYM2Jvc6
 KN8u2E/rgcIpoTfu0hSDg==
X-ME-Sender: <xms:ZkJfalfM_SCR_V0S8lZ3Nc4u2ssUIyQy0yJ09jrgiHa8ddNt4T-X1w>
 <xme:ZkJfanD_jit0NuB5oLaMZlx4i_XS724TQUUqB6w6M5YvARNuPg3Bkv0WrOexxbVki
 _sAeCklvriGHRzvWBXpLUGrP3ms4Gdr6sZi84fjaFKHCJ2N0YNZ8g>
X-ME-Received: <xmr:ZkJfannC7vLr0TwTzxenU7PsN-Ruux39iD17gviTBK54uXovztTzx9jJBKex2KLRnRNabtbLKzG_ys3x-yrq_2HQiw>
X-ME-Proxy-Cause: dmFkZTFLv4voRjDlIucIXGT/rFNnouOD8e4K0S61XSISbn0PHpSOD18yUIo0zjWghp87H8
 Pj/N7fKRH6l88SoAQ3eiYyDt3bG2s7Nvc50w3B/jZ6sXtttvn7lf8Jbc3q5SK4m8H0UWb0
 WD2tWe5MXZivLg5RZBt3vtjQAfHH7oR8qLuWZT8fGpZYN/UQgxazHdKRIaWnUNszGtGruA
 fMwJ7oZYSHanSHOkmRGBgzdwQrSa3zpuaaZgwk18STIP6uk0ZZmr3ohCSprg8nCsUlf+D8
 SDnTgTB6YIZOPZR6w9u1ViJNuMdc9Q/n0wVjS0YEgFJwf0OgljND9Y/0nWWR45//hnZQt9
 6TkeO7BOtx7+eXvZ4kLANM9P9QC1kj9bhG3idoJ84fOn6PNuiaSC7Q1TCWuGQRPxkrp1EI
 LH2Eklx++fSIq5G6ptFG7Po11g7ZaRLd3XLaK+NwockDqE+GsEE9nCQwFm/r0hdPby+3fC
 AAHPBiFpGj8UDAZjwOX90JgvupYcALmA9EZRVxyQK9eUBY0/nS5Rk/7tr311rtNjiP4UwE
 KmMb1nHYqteTe1ic17C7pN50MbejA3VsjE3MtPGt2zo/9nJbagqwb9SF9+K0BFi8n8Emxs
 MQ9uBrIjM9Ol4LYy0xe1BU6ACZaqTlHAXOBp+MW4+68xjxr6pi0a5plBODdQ
X-ME-Proxy: <xmx:ZkJfaiffx5vKtfSePU-2LcpGKF7jb_IEPqj6oYRYBcYdvq87TJs0nQ>
 <xmx:ZkJfarQI9P4cZvOPgXYg_b47KuWD_w_gYqpM6wZ3C2yIbZWkJ9AVww>
 <xmx:ZkJfapsqNn8xB25j7GBomChrcIdib8V9XJq1Jn9wHcGs5qU69t_TFQ>
 <xmx:ZkJfaseDJPpf5shEM2jsuxMCpY07pK7G_P9b4i49fCbJNgNB5XpopQ>
 <xmx:ZkJfatvsGGkU9HzVDNw2up70efDGbCciIm-d4mKp_tlJrn0IG0KwvmSA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 05:56:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hemant.agrawal@oss.nxp.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: Re: [PATCH v1 1/2] net/dpaa2: revert inner RSS level support
Date: Tue, 21 Jul 2026 11:56:50 +0200
Message-ID: <gMKBpMOZQYuU_7FGO7uhXg@monjalon.net>
In-Reply-To: <20260720133436.869334-2-maxime@leroys.fr>
References: <20260630123857.392884-1-maxime@leroys.fr>
 <20260720133436.869334-2-maxime@leroys.fr>
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

I'm waiting for an urgent reply from the maintainers here.


20/07/2026 15:34, Maxime Leroy:
> This reverts commit 618a06c53d479ae576ff01c7d274b10c60b3d3d5.
> 
> RTE_ETH_RSS_LEVEL_INNERMOST was mapped to the innermost IP instance by
> programming the IP key extracts with hdr_index = HDR_INDEX_LAST. The
> hardware only resolves that index when several IP headers are stacked.
> A non-tunnelled frame carries a single IP header, so the extract
> resolves to nothing, the RSS hash is constant and every such frame is
> steered to a single Rx queue.
> 
> The ethdev API defines INNERMOST by encapsulation level, not by the
> presence of a tunnel: a plain frame's innermost header is its only IP
> header and must be hashed. The dpaa2 hardware cannot honour that and
> keep true inner-only semantics for tunnelled traffic at the same time,
> so the level cannot be implemented correctly as merged.
> 
> Revert it. Hashing the outer plus the inner IP under the PMD default
> level, which spreads both plain and tunnelled traffic, is added in a
> follow-up.
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>




