Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C688FED9E8
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96795402B0;
	Tue, 17 Mar 2026 17:29:44 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 3BBF540270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 17:29:43 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8DBCC7A01B1;
 Tue, 17 Mar 2026 12:29:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 12:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773764982;
 x=1773851382; bh=1dZiXW0j8X59vaOw980r5e+InbaSQuSJT8GU90Ksd5k=; b=
 gRtpTH2KwygEH32s2szY3WS/zC3cZa/5Ju4Pr2P/lnXaM7flCxvUxj+WVha49HsX
 5ODQx2AhuyXbLzo3FVX/K+PwDTnfUgP8r1htM05Y/RviBBJRBkVM8sPFpLwme9XU
 QagJzpW7JdxnqTERYTQ0zy+A21vMV2Gn1PIYkVUbnGFC3Dfp5K8wHjMphjl1euJh
 Nk5rsqzK570vjdJMOdBe69KcUtcNPqxLGq1zyvfDNlYio3fYSwBU+lNuTDD11zkT
 kTz0Q4YRs63WrF20ibmKZX9xvbL6EQIPKWYDvimIQcWx+LaqKvdSA5Er1ivRfFbJ
 qtJTJijypkxOKHwogjN1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773764982; x=
 1773851382; bh=1dZiXW0j8X59vaOw980r5e+InbaSQuSJT8GU90Ksd5k=; b=b
 7q6emz8sw5Z4YTG7jIMZRbaso3a8BnbaBlX7BS+Uynywbuwq3gof3O/V6frRG8mK
 fH9rpZnnCsp0tLk76JTEJER+pAcJYak6YtC9Lg12b0dBGJBXGsuhZd/GNCcSlWgf
 g3wWMNlNYVm2i2Tr3Kig6UKQpuckUBiqyZiu6tcRv9EDlb1GD3R9BmpqyEH2uv19
 crCv6VE/FFibx4/5LuM6m4vtJxqX+TDMa8N6eNSCQy3Olagp7NmcbNQsC1OYZMiU
 E54/JC23gymUg9W4nN1Kh5V8YJ7g/LLT05NTLV9Tj47ILrkZfaubmAibd2WqzoPQ
 vQUgY2b4F3awZPgL1p4Iw==
X-ME-Sender: <xms:doG5aeT7xRd2muGXapQYnKeGlEEbEAEaMnWmdjo33uOw7_oUUpkmCw>
 <xme:doG5aT6ZXPirQQzOrTnBGDf4NTZYn6GCHwjdA9sq-TzqM76Pw7OH0FZ1fWdravD8d
 b6ASua-PhxwxvWadlEBOF7W444VbtRoO0zgxtB-fNCJfhCnzn4Ydjc>
X-ME-Received: <xmr:doG5aTz9FWjnJBs2ckwGCnK9AqD4bqTRryVRT23YZ4NkSF5ezeRxWHTuxbJxJqREm6ikLw1fmF1934qqWrv6Oxf2NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegvmhhmrgdrfhhinhhnsehinhhtvghlrd
 gtohhmpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepghhmuhhthhhukhhrihhshhhnsehmrg
 hrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:doG5aSR7X_HBP-p1nqfK5aXazJTnnjzk6nj-ixqhcnlNswvPNQUPPg>
 <xmx:doG5aSXUY7mLQrAJ1lcy2dv_xyc6YQ2_3bqPGQInO9HiZtOntTyoGA>
 <xmx:doG5acafViEBwMDI7xZWE3aStv1HxqvboS3a9rGa1IllTDv0QJnQ9A>
 <xmx:doG5aQ0hN7HYyCKk0dR7R2o482eW4C58hC6MIgbwHwTTaqWciRbEng>
 <xmx:doG5aZR868ZMkpkldXkUDDqpc63ulDoTZ2kaVV0OLnSysyufbnqdWe2X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:29:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Emma Finn <emma.finn@intel.com>, "kai.ji@intel.com" <kai.ji@intel.com>
Cc: dev@dpdk.org, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: Re: [EXTERNAL] [v2] examples/fips_validation: fix dangling pointer
 for SHA and SHAKE test
Date: Tue, 17 Mar 2026 17:29:40 +0100
Message-ID: <2625653.Sgy9Pd6rRy@thomas>
In-Reply-To: <CO1PR18MB4714C82F9395DB538D891D08CB79A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <20260309101025.958736-1-emma.finn@intel.com>
 <CO1PR18MB4714C82F9395DB538D891D08CB79A@CO1PR18MB4714.namprd18.prod.outlook.com>
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

09/03/2026 11:20, Gowrishankar Muthukrishnan:
> > Set vector pointer to NULL after free to avoid calling rte_free() on the same
> > pointer twice in some cases.
> > 
> > Signed-off-by: Emma Finn <emma.finn@intel.com>
> 
> Acked-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Applied, thanks.


