Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF298C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 02:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 930C1402DD;
	Wed, 19 Mar 2025 03:59:20 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 12476402C4;
 Wed, 19 Mar 2025 03:59:19 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 6DC8C1140190;
 Tue, 18 Mar 2025 22:59:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 22:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742353158;
 x=1742439558; bh=2qheDSYBUHFDUGZ6xEn7zAJ1Yd2nWBa031C9Iazw0Nc=; b=
 i7zi4JLeEfoNVGBCrxHe2fc3o+9YcgHJ5HD3UXet8seyVxy6gagbE7VltnJawNjU
 nt8bxdAkmX6Iy3yEpOecgsVTQc5hLQuVjY/0Mv8Ju31j9r6ogijyXIMSjfEV3Cf/
 mSTWd0kc/byXD/9zqu41o906kssb9vykhgcZjsHGXzGrDSnuy3W0IHck2hji/s+u
 jNroy7BLxBRWGWpBPrqNFOGEMxq3JEpep5s8gzax5VWGrs/rSjyrEUFaRjwgMVgR
 WwXE6zMHFJTrIJBsEKFHynX18WaylbnF0vTYaDEMOTjn70aLGagr/UMVMyQo1GfR
 OHCJSTd0ryBO4btTJhaing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742353158; x=
 1742439558; bh=2qheDSYBUHFDUGZ6xEn7zAJ1Yd2nWBa031C9Iazw0Nc=; b=o
 myzoWZkQ1XWNMKDEF67RSnQmuDRouqEccyKCP/pdAxWoTqmnR97V1fnp+VB8l3K3
 GSUdsFfZPUJZK6IRafhJ6NZyQdhb6/2u1X7AcSv6KEdEVdDqsr38YpqTIwAv2hfb
 hpyd2jN9lPp2nRfDIJD60lsmt8wpDFCOOL8SNBBN8PX1QE8Za9R+kLnDhDipjSyK
 08+1KrD1ZNvsM4iJe7gXs2wWobAulRs/ObM3ueGbEDg2VSSxn4gIzhgFCtch2jTH
 2qLAU0uhZYnXpadGKAD1WFjgq2APbjg1VYdzjMy+Ky9bqcJJ1cCifDZg6n+WtJR7
 1OKlhI3pjh+PmLfhGIP/w==
X-ME-Sender: <xms:BjPaZz1D7k8lgGYe0-AnMlOOHlHyr5P4fK1xbbNrPxII_jGWIRXLBQ>
 <xme:BjPaZyGLDUNdX_IKBl_Iw9soYcDPLUmmojWucIGy2gYdt3ibZGLGe2Imz7ZRryIIB
 E0GHto6pMhKRf1T7w>
X-ME-Received: <xmr:BjPaZz47kI-x1WEBY-vLaoOEP7N4Jttw1lsLvykfko7qXjagPiN23tAxqSQl65lXuXsNrnM1pAyaV2PTabcTlMQUzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:BjPaZ41Zrlta7hxaJ_Munaqo4_xwtiI2XUKjVMjaUeN81yG_OQoeVw>
 <xmx:BjPaZ2GT8L1rPyY2GPtuDR7kltu6KVP9WQr0Htq6OqHeokt-8HR-wA>
 <xmx:BjPaZ5-CKoCvdorTU3dDdnzJQwHdvqL23Od6IFqtLdtUNoPR29mvLw>
 <xmx:BjPaZzkJpoJ5mGxXi7GNPMkq_c6jlc3Gzm_xAlAor8hukW--jpdMZA>
 <xmx:BjPaZyD9PnS-2UWMq4Wbppp1149xekCK8XVqGc2pheIyebVDbm_fuRBM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 22:59:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] pdump: clear statistics when enabled
Date: Wed, 19 Mar 2025 03:59:16 +0100
Message-ID: <6855455.e8TTKsaY2g@thomas>
In-Reply-To: <20241219235853.854132-1-stephen@networkplumber.org>
References: <20241219235853.854132-1-stephen@networkplumber.org>
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

20/12/2024 00:58, Stephen Hemminger:
> The pdump statistics are used to keep track of the number
> of packets captured, filtered, etc. These need not be cumalative
> and instead should be start counting when capture starts.
> 
> This fixes the issue where multiple invocations of dumpcap
> would include counts from previous invocations.
> 
> Bugzilla ID: 1604
> Fixes: 10f726efe26c ("pdump: support pcapng and filtering")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Sorry this "christmas" patch was forgotten.

Applied, thanks.


