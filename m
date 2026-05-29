Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD81ACD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 10:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68DAA4021E;
	Fri, 29 May 2026 12:21:45 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 6C98B400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 12:21:44 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AD2E21400041;
 Fri, 29 May 2026 06:21:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 06:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780050103;
 x=1780136503; bh=aoTY4tI2gh1eKqc42Dji6sUPQxShBARRWf/xaEiAur4=; b=
 Afx2AcC69y/MxQ4OXpDLpg2rJRzZ4xqIV1jJJElBbNBwqdV8ODVX6uEc40RDEndZ
 Ch0Y8yH4xFlgSS9d2cHc2xFJDt81bUtHYcs06Teb5wsThMkFNpZ9mrhCXZ4sY0qx
 VcziZFyfBiD3ahU6BEIqW09LpakvfgrerE755JAwZlBDZuWWL6wQrMZaC3Oem4v2
 IFBIj2VDU5pNVi1e7gOs9lSwI4gfxBwfLAZgNjzof4GKSP+3znvbsqDNzbV5k3JC
 MrpSXX89c/S6tpV1m24a8rXrQlORt5cHALstGxu8C5h6anvGVpWX7bdtVi/rVK/2
 jFHFN+K1zhIO7ErNwmls8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780050103; x=
 1780136503; bh=aoTY4tI2gh1eKqc42Dji6sUPQxShBARRWf/xaEiAur4=; b=X
 GojPaRk9f8diVo6klHfhV3W+HrbTHueVU8NRyxVe4Ks+qj5e3avB48YEfUXXXTfD
 D4q6KdNhd3wfp5Qbyd/CTPm8P0UnA3tnxRYD+Shh3+QVbKiVUzoBt0/wGRfotO9G
 Q9lGw/nQBsteQCWpnUcJ8xK1i2X6gp7kHSFJDAgoCmnMaYoNyJ7J77CeuHrWn4z1
 tFLUfNXiTaDGLDlivQdmSo9c0v27jQs06w3HBNfsx+JDsjBZGFURHR1cdYiWaBpw
 IrnaMc27D9tg1FKgdb2UTRFwwoPf4dmrtYsP+m7l3zvnvhqW2zCfS/KYQIqY88ip
 m6bVYlDp8UC10rS+uveUA==
X-ME-Sender: <xms:t2gZak2Bwi0vyWrqsClL5nwrflKC6JjgC9exFPf4fEgw1WMD64igKw>
 <xme:t2gZarYoo_bkvjki79qD-bynEoR9SPP1IXbZ8OxfCVnntCjmrO-RO9MYeWc8QtrAi
 -rmvDq4xQlqn6Mq0s1_C2MyNjjGzRJvmJnekh3A6gLB6jLwAe0080A>
X-ME-Received: <xmr:t2gZavri0gRhpeGMdBE_aRHGyOPPpJ97_EQQNbqTb06P3UrYYqkUE3xg6dt_085kl8hKLsCXug591afm2Pzu__B5fA>
X-ME-Proxy-Cause: dmFkZTGjAsukvDClYkvRQ5KkkSvZPQiZYBXXGVeQzM78+tz+ZbVgzWP19QakPNetVaWAPI
 Dm5KP4i8xLFST+zyq+ksrKmXrHINGxAf5udilv6UV2+PfN0hvDFu7R/TOXBcG1iWDXI57Z
 N/yk5Xhv0vB2XmVXKaqw9Zr3eOWaeEOeHYTwJvxNsM6qv3utztxJ5XOCoLiiJJ5R/Nxxdn
 uFZIZNKL1tXgxGIrPZuPlTsOiXc0szFCXGhrf8oDHUSzDNVH9yaN6PPlihDeP3XPAGWv65
 PaPI6D8gpipv++9G8QTMCz9eetAAgkeyGOJt9/xMGdozMhbv5ptBxjgR+jkQe8Ii2632Ua
 SbGCbHCD7C/NW2lwbxFMYN/liSTNFvBSGV7k4aSwneX9VTjDY6uS9Vm+OHWFDeOpcNBSUa
 0zqYRQZImXdR1lRW00IQ10O/NfLQWtvqcJ+WWpPWO9N5UM6fVpNoJqUCDPbV4N5d9tLxBQ
 oCa4KEw+9aY54QN1uAJ06yAslWphEszOSdqk7LADRQlT20kl0XBZG3NtHpUdE3VLzY+onF
 0k/x26itPg434tLuYMG7TKkHY0Qx6dBmyb0SCow8AK7WJ27sfImpGIeNv+YP4DTiON3hD3
 0bqCij6NBSm+1JzWKXFWJOqKt7eamYn/HAkXa0nkakC1WSATM9+9kPdRFAkQ
X-ME-Proxy: <xmx:t2gZavrfwmg72_MAonORRe6JxJsX0LG5ylvIOCssbCi5Fti_6q1rag>
 <xmx:t2gZap3v9CpJwgSPm3v48o2j81d8JDHshhQAAiwTcqTVh-NB9_Uo2A>
 <xmx:t2gZauBcJ4zZhgeUblogigDJ6EiF_X4-PeLE88PnJ1UpJtnABuoJ5Q>
 <xmx:t2gZahdJetLSv2FfcjAcqOFALjqSM1pJZf3gXDxh4KMeDtqgzoq83Q>
 <xmx:t2gZarX4tq_-qrfbbK1eApeKWYKQ7uXZooqPHlbLJj3bAXpWvYEqO2C6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 06:21:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] ip_frag: TAILQ and hash fixes
Date: Fri, 29 May 2026 12:21:40 +0200
Message-ID: <XNhDsg6KRwCTvqXGgnwloA@monjalon.net>
In-Reply-To: <20260408161947.285185-1-stephen@networkplumber.org>
References: <20260408161947.285185-1-stephen@networkplumber.org>
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

08/04/2026 18:16, Stephen Hemminger:
> The ip_frag library had a couple of issues found during review.
> The use of TAILQ made assumptions about TAILQ_REMOVE,
> and the hash function usage could be abused by attacker.
> 
> Stephen Hemminger (2):
>   ip_frag: fix unsafe TAILQ usage
>   ip_frag: randomize hash seed

Applied, thanks.



