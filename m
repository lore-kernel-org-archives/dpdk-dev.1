Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3CC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27683406B6;
	Thu,  6 Mar 2025 17:30:05 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id B91994069F;
 Thu,  6 Mar 2025 17:30:03 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 4ECA3138283D;
 Thu,  6 Mar 2025 11:30:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 11:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741278603;
 x=1741365003; bh=O9Suu/2ShwVFlTQpx6Yid8kG9VdDHAl7WEwF9mTMNd8=; b=
 EuazWuFxnTKhtZ6SkMsSy0rdTyt+PNMIkHLINjomh1Dalaxi0Q/KCVU5dhW3n+kn
 AhBLoWt6HwsLCDq0CZh36OZz67NZ464Uy1DRjTvMny28RACvO9ogB7GHhRQTZx0T
 TSYkJ1n2w3W1wE5tN3Rfv1cb37Hock+vUf5lS+SRKgNFm0m1QCBPq4km8Rg76h/s
 TtJ5ql+mNWpTsm4TgNfDZHh0qYo335ixusBGrjZfXY55mb9Kmn3jLyx6ca+aq5sd
 MvlCWCWwSoexeWkwDsdqFNjuUd9Wa77qN2bF+VmF2LwEtxLpYyecMD1ZZnlncctC
 tgfuW38bUPgbgFYECUwYOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741278603; x=
 1741365003; bh=O9Suu/2ShwVFlTQpx6Yid8kG9VdDHAl7WEwF9mTMNd8=; b=5
 oyTAugiJpl5kn7pwNJTx7c4sl/qWQo10jz2Q7o2vExGbFRCqWXDB65BaxpB5dDUJ
 5Nkj13rsMLCB6qzW8lw9qx+dTkJofUQ88e69t+fjr3IUxqJ0RsZUq1gMoh594EBh
 NJ0FaWPrXzobGqFBfyceewvcMooAb3p8Sqn0BmJQPbcLxImP/ukHLNm/TdnTU7qG
 6m155myEMLPJg3O/TgL/1hdRyySMWmzUK3KDGyrGkr5KsktAUiHN7TrKZtVGLGcY
 9aTfEPIly+AQy2CtuHhcLkLWLA8O1EXcIfyjOsNvrAkggRD5jWaR5dKkowbzDa7v
 NxT6rv5ksgzmzb53PeYig==
X-ME-Sender: <xms:is3JZ9z-_Q-ES-2UM1Bkyj1b85M-7ur9cmN64H8sYmw96dvMdi3BEA>
 <xme:is3JZ9RH5QQvMmkx4xQzQ3-Ww1eG3X66TKBg6JpQ2NUGjv2BcifXvsRdJnGE8Ni-z
 kObYiGcqtn5c3Wevg>
X-ME-Received: <xmr:is3JZ3Vl-Bq69fusIUYsnAcUeZWIXzvbIJnIqv_XqqMV4aSnNNxLXJptpZQVK_EkO5v9PaGV29bvp2MleNEx19KqNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtg
 hpthhtohepkhgvvhhinhdrlhgrrghtiiesihhnthgvlhdrtghomhdprhgtphhtthhopegt
 ohhnohhrrdifrghlshhhsehinhhtvghlrdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvg
 hnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:is3JZ_i8qemgvc9hEJVTr84nybTUCAtU1s-n1sQCTnwMspnl7J75jg>
 <xmx:is3JZ_AJ8H1EBeSi4XbZ72b9deF1fy5aLe96OnkYbt1Ot_SKRU2KCQ>
 <xmx:is3JZ4J3SBKlILWjDkT_nOb1l1JD6y7uEwSITkmtIsoquV7dCFY4rg>
 <xmx:is3JZ-A_rz7JDdfKj6eQe0h75LdLG4WeOWZpxgT2Y1z9jg9shCpQ-Q>
 <xmx:i83JZx3TmLL56GSBFaoJpHhGHeycuFkvA17hTKZ2KMWZ36igwP8yGM12>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:30:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>,
 Conor Walsh <conor.walsh@intel.com>, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH] app/test: fix DMA API tests in IOVA as PA mode
Date: Thu, 06 Mar 2025 17:30:00 +0100
Message-ID: <20393306.sWSEgdgrri@thomas>
In-Reply-To: <97f3681c-261e-4ca9-b64e-21c2088a5c88@huawei.com>
References: <20250227132749.753581-1-bruce.richardson@intel.com>
 <97f3681c-261e-4ca9-b64e-21c2088a5c88@huawei.com>
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

28/02/2025 01:15, fengchengwen:
> Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 2025/2/27 21:27, Bruce Richardson wrote:
> > When running without IOMMU for address translation, i.e. IOVAs are
> > physical rather than virtual addresses, we need to translate the
> > pointers to IOVAs for the completion API tests.
> > 
> > Fixes: 9942ebb9c698 ("test/dma: add dmadev API test")
> > Cc: fengchengwen@huawei.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



