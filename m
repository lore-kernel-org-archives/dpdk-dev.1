Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142CC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 15:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E234402A7;
	Sun, 12 Jul 2026 17:06:43 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6FDD94013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 17:06:41 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E672614000FD;
 Sun, 12 Jul 2026 11:06:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 11:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783868800;
 x=1783955200; bh=zOETTlnBw5ckd+F0srCGJh3ioDe4X4f98T72fZH0pdI=; b=
 YYxJxR2OsgT/nN8c4ExzlVM5vv0/I0n4uNx+iyJROpq2uQscaCFQ9B5BqIi4bqDt
 yQTo2+jEoGwVfRiw701xDd9Fj/agelrLSHuZhscUX/k2BhKfASw6qoTFBBv5AsVo
 GBMrA2RFcjBl16qMI9OhvIoS4PxBxsVNd1VPGGdsuOvu7fGM31LTb7sS7uYAUYJl
 QRF2G1EJELEdduL9HraEhsKk1j0d3bNuHSiB4ceHbAX2rCrttwAq+5bW6ohwbPSo
 CM1Z71e+GZl+R2PySvLLkmXcYIBexWA4Ofsm7v+aX2QgdxdnqzWfcJaGW5qEWu8O
 3PvbyLx9yoLZ/0SPsyZ4KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783868800; x=
 1783955200; bh=zOETTlnBw5ckd+F0srCGJh3ioDe4X4f98T72fZH0pdI=; b=i
 tzs6q4bnPEI96PD0QlsdBR7Zh5UzK87nY2plXCPvQayG31rvIQAOAki61ZQkv0ko
 ZZugAn3vS4qkpuI126dVVbV9Fu5GEC/K+8mhRjsmLCcsNgDvab302qPn0v2k5Gyj
 glyUut/tfvkeqrowU68fO/4jE4cYgvnjljMeBYHt0QpYzjj78YoDSVjgabsR6waT
 nBlHkSFgppomWUuXY0wXmzk3RvvtgEXf2RYAEuJtNQRv2jSOuoitTNyhycYaZBbo
 u1S68JHXaepd8Emz0gMdCeqncee4fA40kEPZoQNN2qptoAUHG+Hg+r6F2skDmPhq
 HSZS9Cw27J5ejpv7D9Gqg==
X-ME-Sender: <xms:gK1TatRZ6aEVD0xiz3eq56-zdr5ecsg7pTDnKhR7lAlIn1IxP-XWsA>
 <xme:gK1TajGkKgBPUIPYiLaZrKSGYDHeQj7E_7dgT221ePVLve9lM9Awzi07UK6YOx0xd
 uauR45QCfupjj_SGV0gseb_rTDNaIyaOtN0D2WEcv7trYBJ_n-O3A>
X-ME-Received: <xmr:gK1Taln41kvPjEtHKtWIYSZRu3pommupm8qUnw7qdeHLtEx4N5kwdiLQqzB3EYivug3ynhdW9ggWprRPefwg26w>
X-ME-Proxy-Cause: dmFkZTEn2Kn7DrHhSpplbdiNWH977rntdSFRo17sXLCxPo+zSdh/3DutTN4JeTQVWQceoQ
 MRqBAbcPl8fMGz0Gcmtsncbfyj4g8RrqATuRwp0uigdObdUjE6+0XV0YMHzpbeLrl2BwSU
 L+54QIFD4/TBDMVneSCFFSnYm92olp9xXgqA+xB/HjWoR7VGX1WzQX6Lbr9owUMPMTqmt0
 Tw5kP/Q3A5D5dnc7oJHV1H944vL8v5yIW18PqcswO8a2H/2i5GYy4FmlxCwPGuD1N0G1xU
 AH0QrDGvIkuceaedXdo0tIz6m8SV+ZGJtsUaF3af8KQjQGQT6xRsvIij369x9cvqaJItXO
 ABSRwsTT/sd07thrlj2JWC+fLJvvGGtybYHjbwkUdtKqNJAv73/WVS/dpa5Q+9Ij2Loe1V
 XB6lr/iY0LXdXHAjrVqgI55GAsi/mZ7gwlTuGoO7TbEBSvhu40QPoIof/4AdUzkjcF3gsE
 HrJiOPlAxTKWoUNljzR4+7waPRBIjrFf0hTzxp/mT6wAAl/IzpiRU9odd4+gQ1/T+jVTVe
 io/NSunbYjo7vRpWRbeO7+0XAa257prhkB95GWAOtSiu47ppNM9YYs451/cMj00jI3RzgJ
 lePYDCiD7P+vC5Y7258jI9F0b6P4WZsMnlWArVwJr551dsLowWrISVKJHGdQ
X-ME-Proxy: <xmx:gK1Tam1TR2YnwPxemdVRiDt2lzsdHbk9ZBTy0aK3dquOgbSNncZgMg>
 <xmx:gK1TapRpF0TX9wYQJSoupsjLI4VHDf277ebaCZq8ZCOlCJAbCVeySQ>
 <xmx:gK1Tags1Hdtt5AHnKrEGwRCMcoa0zysGSv036mVphhMdS9hfcnoq9g>
 <xmx:gK1Tamb1AeN8X2Bi29jW1H6OsA0ZQ_-3RDaqx8_mVf4Gq3RyIj3HKQ>
 <xmx:gK1Tan48i9DUmp-SlVm6V2enKA5CqwQJkmACi5t9M6NOzaRVQBSJQVv->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 11:06:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/7] Add script for real-time telemetry monitoring
Date: Sun, 12 Jul 2026 17:06:36 +0200
Message-ID: <VfKZhVMfQxCPtdJl0VYxpA@monjalon.net>
In-Reply-To: <20260505100833.2885047-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260505100833.2885047-1-bruce.richardson@intel.com>
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

> Bruce Richardson (7):
>   usertools: add new script to monitor telemetry on terminal
>   usertools/telemetry-watcher: add displaying stats
>   usertools/telemetry-watcher: add delta and timeout opts
>   usertools/telemetry-watcher: add total and one-line opts
>   usertools/telemetry-watcher: add thousands separator
>   usertools/telemetry-watcher: add eth name shortcuts
>   usertools/telemetry-watcher: support reconnection

Applied, thanks.



