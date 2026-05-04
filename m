Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4460FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 09:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F3D4064A;
	Mon,  4 May 2026 11:06:07 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 6ECDF4014F;
 Mon,  4 May 2026 11:06:05 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id DBCBAEC0121;
 Mon,  4 May 2026 05:06:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1777885564;
 x=1777971964; bh=WswzXS+1ELeQXqGpDWKG+PV5WBwczGIkV+n9BQXe0g0=; b=
 SLRP/GBNs703isj/d+tjA7+z7c2MzXos+MuOcVHw/tgZZek5FWwae7nS0Crna2pH
 i9IRAAsU8D608THWUDhXvYZ9IDs4/AwoXYAvVwZrCpyyomD85wFrlzL5LEu+DQ3R
 +EyeuLiTRdTCjF5vxmZcFKVrpQzv6zYjRZwN7X+lEbwWqdQLhwGSPza0zRzZZ7ir
 QEVF0ouXTxT+A04qYZxxERxJMhzAIXxBft83ocVG/f2siGi/Bs1qH1ErSPA6p+SF
 r2Xs9zETso3A0WhMDj7GudDqFy0i0wEdR65gyqShrEy82mGEpH2v2NlYhGFz5tqt
 YINTJYfQHMBBUgxWVBSq0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777885564; x=
 1777971964; bh=WswzXS+1ELeQXqGpDWKG+PV5WBwczGIkV+n9BQXe0g0=; b=Z
 Y25QgnStbmoJBwg1bhemnQJQWPHv2Z9Bft4iyVPdV3Dp6JPuGepH0pKvpyix7YT8
 udrwjAWAl0X6w6l44nSzL8ljhbsWaUpJzCjpOscr7zENnCeUH2HyVE/TnoP/xN2b
 pTPZM0hiLs7f+DiwiVpv+6OXQMVqRPyRLTYjZlMU7/ItxQATy6u9rbINeY31QNBu
 J7HRAyosad2o3z7QvCdKgG0m6NLbF+UVKFNiOAjBMXVThnVYlYhk9HcggKBQhx6v
 CmgFlplNkiLwAtTbLygFVJMG7nGMApHHwH8hH6L7FQ9cvuS3TfeowvBM9uABTlQn
 g2DzADr2noWI9INIWZ9lA==
X-ME-Sender: <xms:fGH4aZKYLY-3OBSYinGO_RTM102CrqKqdtoXgzWkrjCGOrvCTBGvYA>
 <xme:fGH4aVSjpjr1SVu3Dva3ppZqqMUMOHBhxHHFcEUYGJdd45Vl0a8YH_22DdFPyff1z
 qpN9aMeVaYxMeZxJTq0WGKXNVzCnBYUSZ4ep-KZqGaewlnFGpFcQw>
X-ME-Received: <xmr:fGH4aZoM9Ib-3hRH0EJ1O6AJ35ty2LtRxqoyrlEjdceCwXH-sAsuRjOabmaOLELfklI2GU2mCHFzfIP0e5-yPssBaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeegfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 guvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
 pdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpd
 hrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtgho
 mh
X-ME-Proxy: <xmx:fGH4aSp6YkZRcSSyN0RS_Zc7OP2NermpqbksbsAZDjKUCQvTUDZxKA>
 <xmx:fGH4abPNUeqQxFmvQ169347Unk3xiqOL4ZFMzV2vOECp5g1YxiP5QA>
 <xmx:fGH4aTx1x_fnottDLgshdQ8N6isPdzlbZPRSFF2m5C_wgp0gFyTHgA>
 <xmx:fGH4aUsI0nseeKG27aZqFmsZ0kgk0ZPjsL1CqGDkyf5bA4snxWZt6A>
 <xmx:fGH4aRwGVU-j2ngS8C-5fNU4XxlAPnORCehBzrh7_nrUePDZxXPDtjZJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 05:06:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] spinlock: remove volatile qualifier
Date: Mon, 04 May 2026 11:06:02 +0200
Message-ID: <6261630.31tnzDBltd@thomas>
In-Reply-To: <20260504083714.2904729-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
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

04/05/2026 10:37, Thomas Monjalon:
> The user and count fields of rte_spinlock_recursive_t
> do not need the volatile qualifier
> because they are only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
> 
> Removing volatile aligns with a C++20 deprecation
> for increment and decrement of volatile variables.
> 
> This issue was seen with GCC 16 which changes the default C++ version
> from -std=gnu++17 to -std=gnu++20.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

I've just found this has been discussed 4 years ago:
https://inbox.dpdk.org/dev/20221221083717.135c3f81@hermes.local

Stephen had found some comments issues that I will fix in another patch.


