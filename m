Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22929CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D49834026D;
	Wed, 10 Jun 2026 14:28:20 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id B442140269;
 Wed, 10 Jun 2026 14:28:18 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5B0591400018;
 Wed, 10 Jun 2026 08:28:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 08:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781094498;
 x=1781180898; bh=hejqpBrhGjU7GWT4OPek993ZEGstsudkkaOEhtwGpxk=; b=
 ZiQCgKdNw/mTAqhO4nuXZZDjccEexl0Geq856aiLaAD8115IYe2WTl/XUtbhUqta
 kDycDa8jsA8ZRz95V72s7iTxGKeV5+rWkjVn/MK4r0bSEpqSuFeGqB54pFu0KQPO
 8ojpHEJnz3RAsgP3H7wqfLTRTBHDCDGViqS4ZEmLlaBTTMts37vPfEiwTRJMKg84
 2M/dMGPJCMGarpaDf3aFxEr64e3v7encwq9mam5f7WhB69WqPsaR0+F4CB7wVDio
 x6KcfWh1akF5r3AtCq/wusrQZnKLPjtOWzd9iFUSLXdojknjYzjZJaU/dStdFM4q
 f8NXp2fW/b2sVQq3BgqyRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781094498; x=
 1781180898; bh=hejqpBrhGjU7GWT4OPek993ZEGstsudkkaOEhtwGpxk=; b=B
 3FYidjLUJXaUmY4MhdY153rTjyP4B+0r3LrPbm/5NqaVPH4zm2uzPy406bvxWPux
 FRVXseAH0OYJXUfN8VdfPP6fJfEDHJ9xU6ydZkUnyFu7tcMFEKUwVGq0olQ0qQhC
 pF7K7XVGhFaTsCy78bqeM91DacfZdHe1aC5qbfzdD+gmwaAyLwlKMVW1JMKz6okh
 cBYK7Di6yjEwJllDW0kwcIi8jBqLISsO+XWYa97McnfC2b4lB2K4lcFg6AbFjuBU
 5WlOAzpO16ZgtfBO/S+Uxm6edyZ2MYTUmQqzTV4qTcXA/2jLs/GVHhe0h5R/0OFG
 zmyoKHyR8AzAATjrvpzmA==
X-ME-Sender: <xms:YVgpaokruvIHnprwAUCxOjQCzm_NWwhFRjS_liAz1SiR131QA3Irog>
 <xme:YVgpajTtQ9sjptsyhhWco0lnkj7EpkS3V47TwfB6DUvTOqPjXcFnqvY8RHJLExBWP
 ZogL2dhcM1OG2Lv6mRLQfLMO28tc1RN_LLPJYokNOReYLLDXzFYCg>
X-ME-Received: <xmr:YVgpaqLK464MBgK0CLSBTpbI-Je8AGO2gejREQCfJ6OTFKyYR0X7kqYa95q0LLT9rfiHfUSb-M492kEazZjE3eiA0g>
X-ME-Proxy-Cause: dmFkZTE0EuHJh8RBoXRKn8PLONCdxAt1WwLj5X9hrkTN4vUDRRhG1VfIzpZrsXdto3QnD3
 LbrZBoyzEMNJuerG7JmYm8zCrTDfrs5ACBdELRzdvV+1dnGIhE5+FnAxQmH/gEo5fv8MqV
 GDcI+2S2036vtruwnThzRzZXMDpEwJBHp7qsla7ql1YgUf+BMu76sQ1fNRyiUxEy+V/7KW
 qoSQinvs+S8v2s1Rp3FBS6VOwXE46ShQCb29ypHqOJFONDEOTD9+rpalE+HXRx1Ac/O/x3
 7LZf42IApWly5QhE6G7qKMz/O76JSj6DZIGYTLxirPYnoDRGuYMJDK6bDsP1VBW9Xp1dQK
 QftjtTNE6ftiBP4D6twZITeDHaMFM1hPAUm8rpfX4C1DXy5POttRRINWec2FhZJTeFW9Rf
 D8th67M2ZDO2NZfzNKBou7+olMWzAn4sCn9p5756I+FwYC7nkMjUl7hTVN8b7b2NPBymVj
 5V/AR/sxQXcTl1c5PlRLxOyUiaXyh698HF9KoSLpJwigi8DSk0P1QEekGMUdUafbD1mu/T
 QioPcknLewmoy/ypzIs5sgRQ8cWtr1qYqIi7m/nn//3XLsvAbryzDmT/Ffg2pYtpn3XygI
 MaLGAK8OYxz6tQOg+mhMJT32/x6D5KQ3Fm8FKQc5VZf64A+hKMJTEKxqXuEQ
X-ME-Proxy: <xmx:YVgpapC5j4Pz-eEtgrzi-GALkwK2hSKLYAew3CVRZy42fFZFLv9A8A>
 <xmx:YVgpajD1u7gcYJS6P6jb1465ZYbpzvLSq19EcYDEedtogpvItyDKtQ>
 <xmx:YVgparCvMbRe3fhG4_7TdhJVxCdAOxOkql4RIpKcgQSnoQyKhhNDPg>
 <xmx:YVgpauqqVSh3zvh2_NMy3XOgZmULv748UZ7ZdrsNSKz6oRZNWqqMTw>
 <xmx:YlgpahuCTVSsffazlZr5ZrWcSDfd_OitT87b_qNjXlK26-ltc_0BjXdX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 08:28:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Daniil Iskhakov <dish@amicon.ru>
Cc: stable@dpdk.org, dev@dpdk.org, rrv@amicon.ru, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH v3] cmdline: prevent out-of-bounds read in completion
 buffer
Date: Wed, 10 Jun 2026 14:28:14 +0200
Message-ID: <L9FKH0WQStK2yvI_geheig@monjalon.net>
In-Reply-To: <20260430170111.1557768-1-dish@amicon.ru>
References: <20260427153430.1805689-1-dish@amicon.ru>
 <20260430170111.1557768-1-dish@amicon.ru>
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

30/04/2026 19:01, Daniil Iskhakov:
> tmp_buf is populated by the completion callback and is not guaranteed
> to be NUL-terminated.
> 
> The code already accounts for this when computing tmp_size with
> strnlen(tmp_buf, sizeof(tmp_buf)). However, another loop in the same
> path still walks tmp_buf until a NUL byte is found, without checking
> the buffer limit.
> 
> If the callback writes a full-sized non-NUL-terminated string, the loop
> may read past the end of tmp_buf.
> 
> Fix this by computing a bounded length for each completion choice before
> printing it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>

Applied, thanks.



