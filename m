Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C8CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C4DF40612;
	Wed, 15 Oct 2025 11:13:29 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 5489240276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:13:27 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6B11C7A01CA;
 Wed, 15 Oct 2025 05:13:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 05:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760519606;
 x=1760606006; bh=EEFphoLL4mTYsLMtpzkXkBFjwHGtE5dGJYMU6c93IwU=; b=
 AuSwKn4rmNoqixFg5Z+ENn8hCkCe71V7o2ERwKH4FK+c+ytcowJBOAmZN+tca+a4
 wYmOSf4kZ2vDbq1xCE8VSd6KPehzSG0P4NpZnlFWUcHA2mRRvxDEtfKYhfZY5dLO
 XHK1nisp0UaFlsTOKVsZ6LxU+CR8ak3Jxpwsxzchqrbj/qN/74lai6b7L2BoV3Pa
 efJKb4yyQMJvqUCLDuoOx6ojqDfGVPswk0RUdrgWYCx3Yap16QaubNo6SQmGoulH
 QWzAiF8g+d7/Wlpt8h35NMf50R2Mrx+30zS8MwQwxThNKfVGgUUy/AQblHtzyUZs
 sR5gI+dm+f+3QpGepKDGLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760519606; x=
 1760606006; bh=EEFphoLL4mTYsLMtpzkXkBFjwHGtE5dGJYMU6c93IwU=; b=i
 UQB+punjdyr1zVDY/avQ5bGkuqTRd+8GuTAswXDj6qk54SDloEH/zCQEW7W9/jyl
 0+rnPUgvXpvWsPYNaX++6LnpK4bV4UmoxAZEosBfKkQdPr9TCWXAHQPXhsEUTIbv
 C7QRI6M3gYwqIRBvZqHEqSNRaBYFuzLhve0jp/DaTQ7XT1KTSpHPb9iWLjHn0tmc
 MzlHnbQancr4aYig3eZJjrGhGW+cbvOXPIENvdOh+bURmzv9/ZFeeOtS1pn5v51w
 167KG+VZZ4J/Zy6zWNYyKSZGGzNRcdxE1Zl+7aoTPGLgVNweKmAnN6v43u+2DfGO
 NraBKIxB43WNdpsnPHR8g==
X-ME-Sender: <xms:tWXvaIqPYxgafwmxz68ir3MJjys0zNPBfIPcZwUpiXrCNbuGZN6w2w>
 <xme:tWXvaONYsHIvdOuDQra5llEAQt2jE--msYATtD2gUBPydl8mwrsJH7Y4vrWisyafR
 PAu12QivZXnxyN6JekkTXcGWaEAGHwsHgIFEkmCodeK6lTWm1w>
X-ME-Received: <xmr:tWXvaBhesfIc5YCcgZljTMYNVZmuyILINgz563DC0jZKXBbJZYcwpTm_5n-v6CVCR5EDuK6Z8BMVLN9Wj3rdER9CHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeftddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehpsghhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehjvg
 hrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehvrghtthhunhhurhhusehmrghrvhgvlhhlrdgtohhmpdhrtghpth
 htohepghdrshhinhhghhesnhigphdrtghomhdprhgtphhtthhopehsrggthhhinhdrshgr
 gigvnhgrsehngihprdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlse
 hngihprdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdr
 tghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtg
 homh
X-ME-Proxy: <xmx:tWXvaCYgD39InS_wKFKtKPBrpvuv4KjzkSg_ilEXtFItr9wJ9K_IcQ>
 <xmx:tWXvaFhlFoq-hBw6caN-uPSsqUJuCVGlfyoJ8-uecj_dDqmCb0GS8A>
 <xmx:tWXvaEZL6y72cx26836Ok_ot56cLZOpDeISOo7WC96TIwCu3Ojh98w>
 <xmx:tWXvaLOQHiXrylDA8981wUb6VgEMNTlhRTQmwsJkAdyq4mShw9DqEg>
 <xmx:tmXvaKhXDbTFZngu7LclhIEhoPdbgFlT525rHtl76nEWbAM9Yd_Fh9Nm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 05:13:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org, vattunuru@marvell.com, g.singh@nxp.com, 
 sachin.saxena@nxp.com, hemant.agrawal@nxp.com, fengchengwen@huawei.com,
 bruce.richardson@intel.com, kevin.laatz@intel.com, conor.walsh@intel.com,
 gmuthukrishn@marvell.com, vvelumuri@marvell.com, anatoly.burakov@intel.com,
 dev@dpdk.org
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Date: Wed, 15 Oct 2025 11:13:21 +0200
Message-ID: <2993583.yKrmzQ4Hd0@thomas>
In-Reply-To: <20250524091316.10056-1-pbhagavatula@marvell.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
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

24/05/2025 11:13, pbhagavatula@marvell.com:
> Pavan Nikhilesh (5):
>   dmadev: add enqueue dequeue operations
>   test/dma: add enqueue dequeue operations
>   app/dma-perf: add option to measure enq deq ops
>   dma/cnxk: implement enqueue dequeue ops
>   eventdev: refactor DMA adapter ops

There was no review after many pings.
It is adding a complete new API which gives some performance boosts
in some cases, and it is experimental.
Let's try it for real, and don't hesitate to amend it.

Applied, thanks.


