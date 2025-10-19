Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CACCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 08:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6094A4025E;
	Sun, 19 Oct 2025 10:12:11 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 5A2D34013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:12:09 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2A2E27A00F5;
 Sun, 19 Oct 2025 04:12:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sun, 19 Oct 2025 04:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760861528;
 x=1760947928; bh=kCybO8F63Tb1Cols9CYV1UHBXH0/sRbooXYuN4+Dxos=; b=
 OnrpD8/pHsbSaw+wmhrP88RvpxHLSLxn3FfFDcq26B3CLuIIUrq72s73ko1XsOWd
 32vvJOY09fL+hexh2oYIMvY674FKvsfNuvFZO9jqnHbVMahZU4031YHmBWalM0m4
 NMjGBmpUdBMq8i9K1FPMckyMnjmNKVD143IPv93apsrbyVI2BE8Xho7dIp+2PJa8
 bW9++nK642CAY9ryoEge1YuCKcU91mzFONVqp9eIX4BoTnbO9Mx5fJP1ZbXdzOgh
 xXQkjvAD/NtIjFtpcnPqDvzFaavVNUkDpNXuycKaiIGQ4VJawU6VB49l8lB39MCO
 hmKlQLOM+FbUbN2KowvMqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760861528; x=
 1760947928; bh=kCybO8F63Tb1Cols9CYV1UHBXH0/sRbooXYuN4+Dxos=; b=c
 XjP1LyBkrIhBE729lWQlZKNfW2HqaAvCqkS6GSfrBB9fUiSX9eBYQ/wcqsVflYyq
 7rPzfBWeibhjQXAUHoRdn38PSLo5WMtGjeKrlPI1oI/ZVQVXiSP0ZOJAkFF8HQSJ
 /v/DkyLlJMndnDe7+8liGKWW/gey8LxoqqM9sUiJdARFJIUI9kTwqrxKqPNG1rO2
 8Vv7Lx9+gBB3KJofP66ChdUna6emGiq/85CYgsObYN7YLij/7FX3tYMoh3mBDYC9
 JaIPUeibO8SM8PbY5W0SD8ca9xo/pEk5so5ow6sbMAniVNtHedptWCWj30PodBZJ
 CFuHmXn+KgM/LhJpXKnIw==
X-ME-Sender: <xms:V530aE5I-fCbvNRXyjfkZXHAUvun7kRue0sBzbxkmvPRGjSmlAr0yQ>
 <xme:V530aNRTCuuFFUmB15weCKPythQvE_FJNKWpP5tlEPc2WIhPQ5hT7KNA8t9c8Wrdu
 OvZX6sW2SzlDJCcuxwU4PtvHVymKcEv7jmvsLxfHBjtAvygnTBzhg>
X-ME-Received: <xmr:V530aJAt9HgfqQNxH6qhFWKuOzy2WjnnHYhBLPi6FHbAa7MDbS9RZc1u5Al5CYNDejjfF1tR2BqyHlxKI6VzZQ_cJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeggedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 vhgrthhtuhhnuhhruhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgt
 ohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtoh
 hmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdp
 rhgtphhtthhopehkvghvihhnrdhlrggrthiisehinhhtvghlrdgtohhmpdhrtghpthhtoh
 epjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:V530aFGi6qxO6grtjSPa6MjV5FmvlRDubmsNn5Y72EnrqzbwDtPOIg>
 <xmx:V530aLBQF93P0X1IAdy6PT37a2Fnn5vmg1zpIaELWAi3z9GHoK11yw>
 <xmx:V530aFVPYF8IitCLaszJ0ozbl9Dufs5YBhDrecjP4t1ydxcLkw9sWA>
 <xmx:V530aPqE8U2mUtyveJyEfx1MWWpn4lecmSifjwmFFWvp9AD12-YHYA>
 <xmx:WJ30aJiKRrun85SLK3f_DnlgQ1wpunXBY3Hhmr3K1gnge2pMWxmkZZL4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 04:12:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, kevin.laatz@intel.com, jerinj@marvell.com
Subject: Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for inter-domain
 DMA transfers
Date: Sun, 19 Oct 2025 10:12:04 +0200
Message-ID: <3166338.vzjCzTo3RI@thomas>
In-Reply-To: <20251017140652.3186205-1-vattunuru@marvell.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <20251017140652.3186205-1-vattunuru@marvell.com>
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

17/10/2025 16:06, Vamsi Krishna:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Secure and controlled inter-domain DMA transfers require dedicated
> control-plane APIs to create and manage access groups.
> 
> DMA devices used for inter-process data transfer can be categorized as
> follows:
> 
> Class A: Both endpoints require a DMA device for data transfer (e.g.,
> Marvell DMA devices).
> Class B: Only one endpoint requires a DMA device; the other does not.
> Class C: Other device types not currently classified.
> 
> Providing a unified API for all these categories is complex, as Linux
> and other operating systems do not offer native control-plane APIs for
> this purpose. Therefore, DPDK can implement its own control-plane
> mechanisms to support Class A, B, and C devices.
> 
> This commit introduces the necessary APIs for Class A DMA devices.
> Devices can create or join access groups using token-based
> authentication, ensuring that only authorized devices within the same
> group can perform DMA transfers across processes or OS domains.
> 
> API Usage Flow:
> 
> Process 1 (Group Creator):
> Invokes rte_dma_access_pair_group_create() to establish a new access
> pair group, then shares the group_id and token with Process 2 via IPC.
> 
> Process 2 (Group Joiner):
> Receives the group_id and token from Process 1 and calls
> rte_dma_access_pair_group_join() to join the group.
> 
> Both Processes:
> Use rte_dma_access_pair_group_handler_get() to obtain handler information
> for domains in the group.
> Perform DMA transfers as required.
> 
> Process 2 (when finished):
> Calls rte_dma_access_pair_group_leave() to exit the group.
> 
> Process 1:
> Monitors for group updates and confirms group membership as needed.
> 
> Depends-on: patch-36386 (lib/dma: introduce inter-process and inter-OS DMA)
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Added experimental status, release notes, cleaned doc and logs.
It doesn't look ready but I've applied it because Chengwen Feng acked it.

I'm not sure about having different API functions for leave and destroy.
I think the last leaving should automatically call the destroy driver function.


