Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4444DC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 11:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CED004027A;
	Sat, 11 Jul 2026 13:06:59 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 979574026F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 13:06:57 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ECC7914000BF;
 Sat, 11 Jul 2026 07:06:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 07:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783768016;
 x=1783854416; bh=fVU/sHuLGhV7vQQs3eo8N1DQBYeL8wl2ed+0/5YNyrI=; b=
 LSwFgcYv5snVsq6Yl1gTjE5PlKzYwNeEkqWiShRWLYkA1COQpWdN35HBJoYU8c1x
 y3+7KZHfl0hcor2CC9NAla1ZFdh19vTT6vTLU6E07bYezHCpKKXUdPKHYykNak0c
 +jltgtwSDgAOM6eWfqk3Lgw6G8t/0y2ULYA/+v9+qz2iihvzdRzNVjCn4YmBFgSI
 S4DEMqI/0NUvDsjJOBUx6iYZ0BXc6TkPPjSRRIWXiUboJLHozkS2MKao6PHGEu/v
 F6JuyrZbHtYSMpWxNEuuR9SO0H97Q6g08xfnyHe7afdCD7g1m5CuaepGzUZwyaW0
 gxYcZ/ohNHm5SC+O7JDl4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783768016; x=
 1783854416; bh=fVU/sHuLGhV7vQQs3eo8N1DQBYeL8wl2ed+0/5YNyrI=; b=F
 8AAklIPe8pUhhpYfSQBGHnnmsjSKtSOLnso063gZQZn6wfapNmEHFEJMprHYrQ2r
 np0Mfbngg9AgK9HbVMVP0YrLHaENzr49Lqcfq8LfiHrxu7lE7g1KloECnTQaR64l
 YIhH2QaWP01S0J23ZOAizEfeXLTzCWBf5RpVoTPcERFdNKs0we70it6h+qtyZRAg
 qGtN0T8bK3+JfTaeweKRkhOeT1KiOtBs7ltqYR0RCWE+g+7qdMaEQf38ZZIG+/ai
 yf19y5TUVN/Pvuz66nn2XzH8Z1b5MgPvkNC6jnkJAO/Y+3oMafAbPgYonkSQpLde
 CAi5xNJ7uGNE0CFKPVUtg==
X-ME-Sender: <xms:0CNSas-ezNWktVEH9gVW1Qlw39lUT-UVwwRmEGptw97u8qZ-9sXmlw>
 <xme:0CNSahCFTImijBUata4LWrONKQ6eJShw9py5fuYvUa4ANNBffLtkJVAvMDm3ZunT3
 i-RR1cAzQLOYZ2t9j8Su85mhwLsqwQiDMbnSAlmL_eF2CyU76F06g>
X-ME-Received: <xmr:0CNSakwR4M4Fa6XI8WwFWuMMW06dUFXUgkIjGX9p9RYn5goZaeICfoLz1Q162BM_kJZpuxSlR71ou5IilA>
X-ME-Proxy-Cause: dmFkZTFSwevWUgIzDde2KOdu9gTVCaHctym46yjGTCaw2pev5WoKAaiPvDKOpRsovTFaAy
 zv8pF6vYuwn5BiR4wG+IFNQUVldaSlhyASX87XiMRn4Lr2VqwIe2Y5cMvmlvze/0/J13/N
 vnhRqjNXOYDd/8ET6bd1K8h6TkNpESmWOo/6dgRqgFHSd8QjIdRPjn2Zy3kadq4S61M3YO
 CGT0nslhBhkDFtdMoZB4lggVGGSTQJr01/h1gcaImelWoWIbhgqJcUpzOeB6v/7yjHAxMt
 9N4hZnmrKiU7RmTbpD+UyUGBa0dyImWSN9V+rzgTBtZUpzObnHsHQmMegP/nTf+McVqStu
 dBcWlmuXYr9GsfaYxqT0mM5aRYvDo7h8q8FiGHqTBs6afXSbweClkT0h+w25F8L8mXSDHk
 ZCyHBpst4nyMc5GpXsHneyQIt1YUOJYT9Q3jyZ2UtwkvNrATKpFDjtaIYrGv4hbhN/565B
 xG9oFzbPUp8EQJJuov+lsIsyhl1BfFQqe8QnrJbds3xcSrEqHST/tlzCupeTSx7IbUb9gE
 9UbFbXaWg4Dr7UjLM2Pa3gOM6Vn+eHNP5FGteXtxhL2jJ3NtmmVt48oADwR7rnkUUWlOKF
 N2LbofxGSTI5A6yNWucMG6gtU5KoLbAshW+p7KfOVBzNu+ZiUSXKkfVAv5Pg
X-ME-Proxy: <xmx:0CNSauRElReYVl3PHtjaNazjPNJMQNBzznfaCd7sgdk6FShqlVjV5g>
 <xmx:0CNSaj8j7JQ5qlGS9gLJAiTvdjoE1GPqsa_4Cr0wviJEYqNo3qBlAw>
 <xmx:0CNSatrkI9jduV1YBw02KKCnFv8Ys_LR3nWl953aRM6MGyy2RxdoCw>
 <xmx:0CNSaonKojU22y0HhFyhh-ULp2FoVOdeVHisXA-Ep-cN2sMEyvJaCA>
 <xmx:0CNSaseYJnMuf37jfaajw85lF3uhBvmSorlZQfhZDu9fps34oKI-L1Wn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 07:06:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] crypto: use timing-safe digest comparison
Date: Sat, 11 Jul 2026 13:06:53 +0200
Message-ID: <i5s0fuGQTJa0g4KR-VL3mg@monjalon.net>
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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

> Stephen Hemminger (6):
>   eal: take experimental flag off of rte_memeq_timingsafe
>   crypto/uadk: use timing-safe digest comparison
>   crypto/ccp: use timing-safe digest comparison
>   crypto/armv8: use timing-safe digest comparison
>   crypto/cnxk: use timing-safe digest comparison
>   crypto/octeontx: use timing-safe RSA signature verification

Applied, thanks.



