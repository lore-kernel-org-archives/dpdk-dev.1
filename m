Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18910C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C14494027A;
	Mon, 13 Jul 2026 12:57:02 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id E993B40276;
 Mon, 13 Jul 2026 12:57:01 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 8A193EC018C;
 Mon, 13 Jul 2026 06:57:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 06:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783940220;
 x=1784026620; bh=MfN3vcW+VCjFRt/N9wFX1Py08imZPXr1eqEl3eyC088=; b=
 aKs98BukA/CDVJoUIuQoYitx7XQRN5hexoArCZHM42lnzcabStPdxuuoOCTaNHyR
 vYUKQazP69kIIPPVkHtWm/MMF/ASfPwTUo+dai76Al01GsPkwSYYOC6MuitfelbH
 qEps0HL17uk4Fr0F1bvRb7KY3rWsb9XDbgRB2MevlAPCPvTLp0Yr5fwIZEo1BJpV
 CoGW0lImKakx3+DjpMnA4AnefCdqu8gjq0vF3w2wslxRoBF2+ep8vIGhBHWZ3kk5
 VEYWFN6ghdrGfN8XjvAcDZtANc7Lu5iEdnNeXHW13LvgYSCetitl/zs3Aki54L/k
 Rro2UPpd90dPLH6TdRkMYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783940220; x=
 1784026620; bh=MfN3vcW+VCjFRt/N9wFX1Py08imZPXr1eqEl3eyC088=; b=i
 tuucqMkfCo1ywt04y/8g6xTGXbyk9IG+EnZ8BDCBokKRnb39K8wWR513Ej8jPz0D
 vPQEDYQfddR2cwD2j/ToT9SVkdc6FppZphTYeGPavO+fCGTGdGwnv3fmmDcFw2ra
 1jYMhLWmtJkS5ASycOyh97UuDQnpTIwHBE9RimYZeMJmogDNNfPW0G8Knd2lkykl
 u7APFPpNunGjjqWA1dh0iqk70Ly03iXTutb5Jzz6saJVM56xABp+97F1eqjQNWZB
 AAqop2z6vzzcaVke9SuXessjrHlAaOQPrgV0zliRhl6VKMrOVhyleXqf2/dtTsnV
 9ErDniTYiYgAjbVqTbGjQ==
X-ME-Sender: <xms:fMRUar0h21APftj3IaTjedKgihdXZE1OeptBkMTmYh5T7KXfdx6Cxw>
 <xme:fMRUal_-vUQY2v2owtuLPwRh66Mz3jpN1t3xAII4PE1ec_h0B2JXsvoRrq92LqKD-
 eRKjq42FrGn7g65_CwEaDutzTcsZIM5R98AiorvHgjdIDA2qwXExQ>
X-ME-Received: <xmr:fMRUao7Dzagx0o-rj6BqlDSh0cOwYNK6LtHxWqgrQkKgq0s3n-MtwK-N-qzzosNxhDaZJ7pKlOSpK47m5Q>
X-ME-Proxy-Cause: dmFkZTFnj4q+DUt4h+MMyWtBf+cv9p33dMtsMEQNZv39Owsr1C0CcBxA+9Nt9wade2ia3n
 ezgs7ICf64N+28T5U7nFGj8v0hdfdC52YIftLKNc6FiUevYAgpI1sQn+RbTJHzvF4SCHHM
 WqtZWmRbAOMx4nVqgFsWaYDHFI3FOM95/cGO2XUSNUHpxJZgKP3KR1Lqu15SsvqBeOcNSn
 m8rDneFSYDN3TO5kUkelI8mTg+AKfOQuijrlgcjgvsyDpgd0aSjRnB/YBxdZ8PznBR0ppu
 00FyKG/MXRd6Ipf7bQBuXlvVlnLFNuTb4OvVkzsDBM/In8m0k0CznWce3MBE9YbcKQeabJ
 Vwefy6lZYzqtTJdM8RNBTTGVqmKghYgQzUTr4QGQ5owf/CtiLQZeZukawM2XceEN5al2QG
 tC3GUQFV8TIKmvjNisnqcL8haFxm5py/krF7ctJSt4wM16r9qBaajT+bjTPHYtD2QE7M/X
 49OVyKBCBEF/Mt74O+kKJUDlr8bj7lhFCaQzQEd072mwW0ekMfRJK0yCufJEqCcQVrBRqt
 8DNKGBj68QcnHozI9g9ACSaF5mWuxk4rzcqXvVkb9i+1xmIQJMWSs4d8d0/nze2DS0Nudf
 FB8P/1rWfViJm7LaUzjonR1yy9FNNNr7nCiH7sSHI+xChf0zagDHNR1kirXg
X-ME-Proxy: <xmx:fMRUaltCZ-XKWEd6ArugEa65cT1ex03q9w3HRMN5KBwKqJQ-q5GZzg>
 <xmx:fMRUai08ylAOhSr63nGgFetVjYw692QrzXCrWV2MCo3RR7UU0vLGFQ>
 <xmx:fMRUampKVsrz4xIxIDUlz319MtFkihtwl4Ngp1srsx-Ze4SKy1BD_g>
 <xmx:fMRUaqKB23mwWL4nbSM5ggMLXeoySuCk_oM_7b9W_DT5Z4kTRTMKmg>
 <xmx:fMRUaqlZG1BuDsAhMrIHYtmR-0TDDW9IujQjzjEU7fgKLy5mwHQzZPvk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 06:56:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org, Gavin Hu <gahu@nvidia.com>
Cc: Wei Yan <yanwei.wy@bytedance.com>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH] net/mlx5: avoid wildcard drop flow in priority discovery
Date: Mon, 13 Jul 2026 12:56:56 +0200
Message-ID: <U45A1w0bRsalhnKWfosXqA@monjalon.net>
In-Reply-To: <20260713041856.67144-1-gahu@nvidia.com>
References: <20260713041856.67144-1-gahu@nvidia.com>
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

13/07/2026 06:18, Gavin Hu:
> From: Wei Yan <yanwei.wy@bytedance.com>
> 
> Priority discovery installs temporary drop flows to probe supported flow
> priorities. These flows match a wildcard Ethernet pattern, so they can
> also match real traffic while discovery is running. On shared devices this
> may temporarily drop kernel traffic and cause TCP connection timeouts.
> 
> Constrain the probe flows to match both source and destination MAC
> addresses as ff:ff:ff:ff:ff:ff. This keeps the rule valid for discovery
> while avoiding matches on normal Ethernet traffic.

It does not compile in all conditions.
Please check CI results.


