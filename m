Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC9CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 18:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4797F40151;
	Thu, 23 Oct 2025 20:47:32 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id BB98440144;
 Thu, 23 Oct 2025 20:47:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0F0C41400159;
 Thu, 23 Oct 2025 14:47:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 14:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761245250;
 x=1761331650; bh=TtHf1BMs32wkVqABBBgVX4UXpnMoq+uKWG1XYMNdGf4=; b=
 Gmuaw+etXXljlsr//nvtTcCxgWaHIaYprqCUyzTR4D/yfZK7mHWiyaTrw4i8WOYJ
 v+I/9Aqfso6ZKSf14/APg5oJlTp3c5D43i6aFkuXotbc/PoiAGaJGLkxKrsiKnSQ
 5n1+g33TsR+I6tQTHWtGCPjh0M6JaCaITJmq0AIa7ff/vfYIRVNslSTWfQJYMZ9Q
 uWWc5n27kkPURigFRSkuh3pm2K/wVz8XOv3vrfMnhxLxdTA+DikwV608qvVhIobF
 B3XnK1ZO1och7Coem67z89VpLft4jfpEVU0Ni33ow60CMvZNKL1lgSKO2Al4dc1Q
 htK8vQn2B8bI8P0ZigG0Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761245250; x=
 1761331650; bh=TtHf1BMs32wkVqABBBgVX4UXpnMoq+uKWG1XYMNdGf4=; b=T
 kI19fsTAb9Y9V9kf0zavteEZHTLHLoY0xNt5osQn1qYzfMa+t5wLWfWmiafvhT7J
 ZQ/+ukS8RrsvPzQq8Cu1E6krHl1Z0r70wJEMYjsMFqQ5C5IYtjElVlgfE4g9HHih
 zm7irBneQfYQU4Wb/kX4FaWpkrHwgbkrMVWUZN/EzAu5s5RMZ5B1wUJPAlVWM/DQ
 RQgPHaoyRdal1zLvpylKf6PEjiXkkPDZZurOZ1BlslhoD6NdfSN2Nrh1rIGw8f4O
 slWYH9GYv3Qj+VfyTNxt8ktm6UbfLcxu9SPfY1DWhY4/ULDMDxH8VSFz0Qy/oQVq
 oyTF7LLBiU4DMiOWaxy8Q==
X-ME-Sender: <xms:QXj6aMZgoiIhIU-N8zzEM2T7_OmfG9AT6mj1gp9Klk0-C7bAZaXhxw>
 <xme:QXj6aH3OPp5fBMpcrla3vxN7OaifcfHH_Eiy7W-0XqvopWBLoyMZwKXi1CTfsLTtc
 La8Z4Rxey10Av-YZAzzkBSGHaoRMODhcrKLIgIiE9y8m6ZaGzpm>
X-ME-Received: <xmr:QXj6aHo1hVimMKkztau2IVN_kFgSZtXbTa-ONZ2CGihG2mTMbjyC3Ig5P32uufpPXovtiGLLU-C7sB07so-sr7vP_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopegrjhhpsehmrghrvhgvlhhlrdgtohhmpdhrtghp
 thhtohepkhhirhgrnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhope
 hskhhorhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhkohhtvghshhifrghr
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohephhhkrghlrhgrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdroh
 hrgh
X-ME-Proxy: <xmx:QXj6aONHB-8eM8IZJTCC8U4f3Nbnw5vSme4J0eWu7bNk9HHpp2EYAg>
 <xmx:QXj6aIrGmePY65SLt2Ok6gFTEepgw_R748x2oTfiZOzSdZnyVIbJOg>
 <xmx:QXj6aBuGhvRDDY7E5bCKokiBy6BE46vTXxyPvebddHbjJvN4EWxvWQ>
 <xmx:QXj6aH0zxWDZdrhMajaR1vthMUkObNscWLPFIQq0qaYN4y3mh0GMfQ>
 <xmx:Qnj6aOP5_tnQkyDV16UHavaMApzokfmfqzCD2eTKPiNDgxQm31C-NOEM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 14:47:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Aarnav JP <ajp@marvell.com>
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, jerinj@marvell.com,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3 19/19] drivers: fix Klocwork issues
Date: Thu, 23 Oct 2025 20:47:26 +0200
Message-ID: <2492954.jbyF5MZJ3u@thomas>
In-Reply-To: <20251023172728.770661-19-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
 <20251023172728.770661-19-ndabilpuram@marvell.com>
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

23/10/2025 19:27, Nithin Dabilpuram:
> From: Aarnav JP <ajp@marvell.com>
> 
> fixed klocwork suggested issues in
> cnxk component of drivers module
> 
> Fixes: db5744d3cd23 ("common/cnxk: support NIX debug for CN20K")
> Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K")
> Fixes: 4b8eb5bd6627 ("common/cnxk: reserve CPT LF for Rx inject")
> Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
> Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
> Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")
> Cc: stable@dpdk.org

Would be better to split and provide details of the bugs.


