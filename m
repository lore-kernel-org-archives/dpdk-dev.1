Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6125C982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6F2C42F03;
	Wed, 16 Sep 2026 17:43:41 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 9B59D4028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:43:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 33BCA1400105;
 Wed, 16 Sep 2026 11:43:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 11:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573420;
 x=1789659820; bh=TbGbCUNKPxUKgbb6e9Y7XBi6pFDtuZmHop9bwLk8wvE=; b=
 dxHDYvFmeFzQpnoFfdMusszMPzwoZWU+w8r+5H3J85I4hiNMN/B8KOS9o6ca2mgN
 yenwicyC0/A2QvZVYnDyB1LcefOQpUOowJ73NNvpkILeFljGcqkpCBdiFpQowYe6
 S0lMwjZ75SDRVd9q303ZqJI89/Dpclwl0WQSZkDjPxgmw9AUJhLoqwWcAZqVI1Na
 bN67lIH4jePPcBFMYl3Ej5QxKs9CltpcjAFs6Uzy+SsGw22oPIlloLpFsFgRr59v
 PGg+Ay2MXfirgaLMAIjB9vd+SbVrp8sn6ZEXL6jKdAVDHka7Wwu4sU15OA/NMvEL
 e72TnRnjTWNiis2rbujHMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573420; x=
 1789659820; bh=TbGbCUNKPxUKgbb6e9Y7XBi6pFDtuZmHop9bwLk8wvE=; b=r
 UfHWmQzgI73twD+/5du96kd6y5HZdnx9HArI4i86JgQAXppL0oPEPjTeTPPHLzaJ
 lxHv6cGL9muHhNQAw8aHmWR4qVpgHn0eK4Qf84ikwWgiX3wdepvh1Nk3wZApvOjo
 nrcsckoF4xrNQS3LX/TbAni1hBE+WtU/VHdKJzO8sciWIxWYtm6zDqm6e/NyoG0i
 cVEpqiULp3SGT6R2y4UC61CjMH5keFSGb6owlHxiuXyFSzL/bJmtZ4n2O/BBMi/u
 A7ZLaH+2Ovu9UehCkABuhKrJ884lOVjxWmAyhN/pQVRg2NuGdnOp48IPjZj3UUNH
 kG6mMYl1rcQq2ITQLuCwA==
X-ME-Sender: <xms:LLmqat438OHvXQv8GRBuQlmB2mMXYp-SSJSGNxLuKxNcX9CyZ5AncA>
 <xme:LLmqanMqzMsPDuuGZiM4MsnMeYA5X87EUwWuizltKcWJ6qz7j73vko9hGdHJTLHcc
 2iO0mDcGNP0oX3C8mle2rl9FQodODvrqb3B-QtK7hqz8TGeYGCR9d0>
X-ME-Received: <xmr:LLmqanNuFB9zZFIYSkSlRhB1UjcSBDsEoxaSTvfNvyN1zGoU1FQXxxYn1hkqia-HRs_KlMRQkHILnRXMZsJ8Oek>
X-ME-Proxy-Cause: dmFkZTFTHNCherEDDpDLnr5Z7BDrvwr1jm9vavNG/AP5MtpJLa6fErcbXPyvT6v/MMEocZ
 WkDdwFC/mzTfy4U9s9v9k1aw/l/RS9rIoHix0tMYiGcSwxm+Nb+XAC6mFfiePAmwQ86TAZ
 8Ej3tFUkvZo4yo8jLSXMBD0BkXFGtdI/oDktr9Xwwd+R6896fe/ES8emXVrEDBW3kUevgp
 FgaDuZ8E9ZyOTIJo4frmwEE3qMigLUyTvIhTTnRx9ZW6yBGgtbZdgEbVCpMfI9ksz69+1k
 lJyBIDOxNoADOu557CcnVTFYvzIBaamFFPBlSKQvyYVG4sA5w12rRxnUJjoYqDyhZjm9at
 5wQTbo79t20jzrljzLjYf+/+sW+L8NKRsQ/CO2rxfh3E8VBWQw9riFG2zqgSX5skrf9pkS
 sYrN0bmDhY2dgRRIIEbN6oMj9uvqIUT/FlkxhRXPFXlZgSuRSpGkVdYBf0TTs6cm465DnE
 a5iAOiveEN7gyPYR2XNFQ2D2EJ1et2TYqX+HAXnHwoEZOcbd1emO1xeYJ4CBe2h/SiVSSI
 bj6jasHwXW7psbU/vjDFdf+K0wVJSBi2fKLcccGvkJRmnV9pMgmCYUhRmV9hqV5qH2DUBn
 7NOvbKaHYdCmZTn0UXkd8GQ13FCoZzzYv3ANiMCJk92eBxemqaIo5n6frFSw
X-ME-Proxy: <xmx:LLmqan_4hfvpPdriv7DGkUgHXW0WoVbtbM04F0xnzc5yaPmQJmYO7g>
 <xmx:LLmqaj7eqeCv21BK9hXg42Z4mxyL7t5IV6IMpd9S_tGJ63isvRsY9w>
 <xmx:LLmqam2dARNAiHfaDxtAjo36KdXvWJiwHLlv5a8e6wsVgYQotZ1zkQ>
 <xmx:LLmqaiBzYht0Dk36Lu56oJfpPmEbdgE-9VRezIdmfagMS9eEP-fJ3g>
 <xmx:LLmqag6TLU8JtvII5WXigP5mm7TFzfnynfycH8iYA2o_pE-qKAqoU_08>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:43:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] MAINTAINERS: remove Apeksha Gupta
Date: Wed, 16 Sep 2026 17:43:38 +0200
Message-ID: <knesfjsvQ3aXY3CQCC78yg@monjalon.net>
In-Reply-To: <20260806163023.693196-1-stephen@networkplumber.org>
References: <20260806163023.693196-1-stephen@networkplumber.org>
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

06/08/2026 18:30, Stephen Hemminger:
> Mail to apeksha.gupta@nxp.com is bouncing now.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



