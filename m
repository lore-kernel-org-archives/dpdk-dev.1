Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F393CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 19:25:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE1A402BA;
	Wed,  3 Jun 2026 21:25:08 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 72DFB402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 21:25:07 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 8ACCC1D00147;
 Wed,  3 Jun 2026 15:25:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 15:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780514706;
 x=1780601106; bh=3rNGe6OMAQG83cDt+J2m2nXYSlveA7UVVYrQfF6eRCE=; b=
 lxPmtUByh0UDtsorXTV3ZWQmgZN7Sv9wDy4XbBwsKk2kRMxjyiKDrWiDH5IF4965
 QUq3MU6QQbaaPhIF2iJofvOy3KeKLvupzboSRBGjw+AnMSeq9I8gwyG+gFdbVOOk
 3nvahErZ/BmvcKbnA2ORA2jeIK3ynPHdJmD1ITp7Zyw44jcVBtERgR4+mDA7o/CU
 AZ4x4zhf8qjhIyHp0WWATE9DvotaOXDHszRmRzcBTIqraaa1liU5AnKee/MTolg4
 TQacVHUq5xbwT8+YEWRak31xBwJVfi9FKCYCWn7jhphz1MgIaacMzd7YIBYBJe9F
 kgaqRjU64urm6p0g0r+FPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780514706; x=
 1780601106; bh=3rNGe6OMAQG83cDt+J2m2nXYSlveA7UVVYrQfF6eRCE=; b=G
 Kr6wMLWU7HxHDxExp2BZClzpoaj1EjWdySyoj5+qYX1PjhEALk2SLdMfO2t6GIkq
 P+CEfpfZWFKSBkVSMp6vbYXiWikNOGTHtpDdSM94JqdnZ+/Q/cQZE0wwloJMeHlf
 3JYC+y/IY+F7y9l/NuoGukliBD9E8wDXYLcL5lFKgl5QeyOHDw0SKLM/Qc75s9tL
 71++6DdkvBJO3+0rJ9GVEH4htKzbr0DZgQ61IbuDI+NAF4bp3tt7BKjNq16G+mnU
 vFyYyZHY3K2BrfQint5sygGQOAgdGPSQySVDDBAN4efp1v/IexQlhRTrsig6FBvg
 9mc4ERRzsfFACytnIqP8A==
X-ME-Sender: <xms:kX8gapZHEvuOqvovCIt0FyqKe62uY1ZLxPx5cgB_S6FT1brmVSwabA>
 <xme:kX8gaksq-QIxUjmeWpK3RgvxGE_-pd0xBhZ9wcisTxmCEHo13e1yDXAhfFwkaYvs9
 lsQCU5B3M2TzKPhQC-7qYH7b-xbgey_3bswuBhpaA1XpqdsGrQ2dQ>
X-ME-Received: <xmr:kX8garEWzwKdG0GheM4qpk-fENANkFoW3cLOt6naKBzw8uV2_S0CMDsQOEmNWFFkd1fGM370M90Ls5ffu5iUgZID8Q>
X-ME-Proxy-Cause: dmFkZTEYOgg5tpJfHN22T97h/4MzdC0/TT1u3crKqg3CKfcAfc3XOIcukBJ6HSZDW/MKg3
 9xQMqYUZbUkBUb2KkVqdzfo3PUBNTBeSQIeFIkoaZYuGic8W+CAue2WN65IiAzEfLekkVC
 rk+ZbFabrhLvzbQ+SQM1xBdcQOsOV79+ILge6mjfIdGypcEc/G6rhUDIieTdf/kfq3rZC8
 evQLCCegvAew+0ZQQoY1YPQtThpkl9FP+l58py5N9oCpm1J4ZP7IZC9zQ8BL7BbNgOrSi6
 D+OotjQhZkEYbFmnPd3Imb0xugMt2KAK934NTQod7GKgcWdz68a5K2vr23gDcZBr4MgMSP
 UKdzWtkArBKsD8Xbo6VMGowOMpgnfAI8+vT7HLNAu7SxTYoKpjFEdRK9QoijZsHp/sUwTb
 pnFYr2QDjxIMQtHIpqiTuduoUGjGHohM/rp4KRuLCFAn7cl7oixo14zIeB6aQTIOIX3sHt
 M+XTXfvdvS5divh9DBn4NsYpMcQ90ziLJzwpz5ChOVDAZXQzGAJdxtFOqSOQLh64OPeU9T
 rZBHFcTRybtt8+XQIMdCJhkStwzWMghkqv8R8fR/3mWOFYt/dyf9BJOGehfLY8tLqqCnfs
 BZAI3TT/R4erpYao8SHSY1C00BIQzuUQofWZYbOIcU89KH4yKHp83DpPPGJw
X-ME-Proxy: <xmx:kX8gavymjVvWVWn7maw2AaRjTFf9ucbbefg-OTL8znXTG1ZG36zyBw>
 <xmx:kX8gaqiJJOzdg6hqcB9lABk2G-23oPjc7fjDBKdOyKafp7omZJYRCg>
 <xmx:kX8gaiwQ5t4zcC-ujsLedd22VKWUCUTRNpJdTzAEUXi9fEmqxaO9tA>
 <xmx:kX8galLmbRWmbWTDCfbjEVIRnEqYWeedY9trz1mXY1UYV1X1SZZtfQ>
 <xmx:kn8garHBU3D5oYbapG-lMBklVoqpmz11O-pc-GtNsdpbsSag6EPRsmU7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 15:25:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Weijun Pan <wpan3636@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] test: cleanup assertion macros
Date: Wed, 03 Jun 2026 21:25:01 +0200
Message-ID: <24JzGgB7T-Kp58ipKmNDgQ@monjalon.net>
In-Reply-To: <20260501163533.2689152-1-stephen@networkplumber.org>
References: <20260429144632.164970-1-stephen@networkplumber.org>
 <20260501163533.2689152-1-stephen@networkplumber.org>
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

> Stephen Hemminger (1):
>   test: use inline helpers in buffer comparison macros
> 
> Weijun Pan (1):
>   test: parenthesize assertion macro parameters

Applied, thanks.



