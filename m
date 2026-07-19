Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C1C44512
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 08:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 462814027A;
	Sun, 19 Jul 2026 10:27:07 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6BABB40276
 for <dev@dpdk.org>; Sun, 19 Jul 2026 10:27:04 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5482E7A003E;
 Sun, 19 Jul 2026 04:27:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 19 Jul 2026 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784449623;
 x=1784536023; bh=srzeJUva4pJJqgtFMiGm+h6/KtMwHjzfAWUmKTt0i30=; b=
 mNHE6x+1ONBlSNb0WiPUCWwvse8UXw8aPAxSH3TK5a7Ei9+OPJfsMX9NsWqkwGtx
 245I6U5F8Zrvrzqhpr9fctYNjrpC81+vLYZz7vqlbwKiACdx9Y8C6ZM9D0On5ABF
 DZ6gTKWf0AKHwJHuUNwngTCmecs0TxIMU6re+VXhjYH9urvjvX5fUHN89soSJSPb
 hrrAz8Onew9whc1t4ynZHjBLoNCJ/NuOIRshAEVSjLGtPasHmVIOaEBxmzvv9jZJ
 R15csgFoKMVBgcxcImgFx5B5POhxSdqlnITJ4d9sJX07zx/zU/gasnSGqTRufmJB
 SkTs9xq5WFTBe5xqYyyvrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784449623; x=
 1784536023; bh=srzeJUva4pJJqgtFMiGm+h6/KtMwHjzfAWUmKTt0i30=; b=n
 uHzt5SOXidP6SPRmkdi5VDSFVbalBta7MwcY4erTAQc9vqk3JTljwk7D7UvVfHkz
 mRGkfLow8jb8yXRfVoHRDTV4AjPx1ZSS9UaqwjxlujBZ6wm/R7mqtm5Wj6tkHWD/
 DtUdKKyci5CZui6rupj8TXLkzV78Kw7xqqh/ZMrM0r/rO3AlwzrXgWtTyFtf8Eks
 7TTnJZnEGXV4FKvdiQtL+7e+rivODqHPKDgQJSPgw9kAYVSvtN2k0hL3sJf29FaM
 JuyQbiGUjFctFrA6gVAHsANvx1vjS37kODil+H75vIcsJlUCvoh+/1hJDqSACLxa
 /+nSOzF9Aa2hbpQurB60Q==
X-ME-Sender: <xms:VopcamMTm_MnPeZgdcTIEFU2E66lMXlzBJEdZt-RBeUz7YfSPQ8Cxw>
 <xme:VopcalG0R9Cyfj76z61kag88iuCCHFFDG4E2hHgda0j-RaqGhg0U-kfwhCKdTpLn2
 glzJp2JdSZX_air-MUVmU7dS1iAhj_vQsFE3twY6nX0njjTDMzHkQ>
X-ME-Received: <xmr:VopcalOWBwHU3aDEAWBF-9tfOxXzOXsvci5_by3Tx_Gfz2OCwJfb8Q9n8PMU8CElKaHPc9CvRt5Xp03qkA>
X-ME-Proxy-Cause: dmFkZTGmCd3jWHfRr4rsjMenUkpBoqQQxjF7azT+6LYtE38rGamTE2OPGmGNS0SRRYMlbm
 5Xf6sU7qTwaq11NQql3MXyo0LkXuVTwPHIG/8mJWNidGDdorQ3uxDfV5G6LD7TWFTot536
 FI6AbQg7ilvhV13kThkd0WcxNXN7U+LodNlNyQpY8H6cc+6eCWVgc7V2sTl2zLEFLduGke
 5oifCJQWZ7TIvVUWnbsGMe0g38fM8/urvWe09eQgOs5FxAVp25s8iyJ/ZtRmhHKVjDe+fM
 9ouYYXopPgBpBL/DK8EzJ4BUovfKqZPwXB1VUbXkfYaafauG+pm//iDp/vaOSuUVBi+pfC
 qTOEzeHpfpPiEES2NWC4/NNaWCZlN6tQj0dJj6ZoTXHHXIZkifFbSQRGSkOPSrunryCj9l
 xoj0oV4U42Ihsj6CBhx6LhZMOKFHdiXPnAWRldoP3DJrXlG87JK+1diYuMdsFhSqol0Wwe
 0HLhpuChzDDWrTNzXC9J1yHef+gd2gnUBEhoG/3crbt76K/mUk/i4IrmPJDpsbTxHysrGb
 fJ7yw1nXsAJSs63gOrtk4KBOif4FDuH2kW28DXeRgaE2yRMvo8D0tQ1C0KTh28d6H/AYhO
 fBPq+QeTMJcAoPQ8S6TdOlLpkfnM1kIfAwoyovsI3UX9IXaJdZRiqWk6jnFg
X-ME-Proxy: <xmx:Vopcau9T_DLv5S00_e03jX-bnPM7mua6AxMY70rgaX4Gq-xkeTBQJQ>
 <xmx:VopcapSEFnlQ78D6wiznWAkZ6126tNLNSmPtVstE4mJtez8iF7hBvQ>
 <xmx:Vopcagl5QzOf9ufCDYTdMNaAscr7nT3HwnqZ2w8QCDCC2_YYr5T75g>
 <xmx:VopcapTUBYLPiZtaP6vnR-SqDMrezUpvCANdDx5BxLVGs-2yuLt2tg>
 <xmx:V4pcas-yJigNO6F5qLEEU6FgMd4Ts0Gb6LU2dNGUP2EDEIFQYXw8IMrl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 04:27:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Hailin Xu <hailinx.xu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, manjunathgouda.hosamani@intel.com
Subject: Re: [PATCH v1 1/3] updated i40e latest recommended matching list
Date: Sun, 19 Jul 2026 10:26:58 +0200
Message-ID: <U62IblfaS3WlSqtsrp17ZA@monjalon.net>
In-Reply-To: <20260717091233.12102-1-hailinx.xu@intel.com>
References: <20260717091233.12102-1-hailinx.xu@intel.com>
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

17/07/2026 11:12, Hailin Xu:
> Signed-off-by: Hailin Xu <hailinx.xu@intel.com>

Series applied, thanks.



