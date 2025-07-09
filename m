Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C524BC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 14:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DAB1402DA;
	Wed,  9 Jul 2025 16:50:35 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id E2557402A9;
 Wed,  9 Jul 2025 16:50:33 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F37937A02CB;
 Wed,  9 Jul 2025 10:50:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752072632;
 x=1752159032; bh=fo/uKwrQq3uTvYaoQUbGlUoCxtjnYXg0yjCQR0lYugo=; b=
 J9XS55KSPFRFCoDMJ+ve20qxYm+OA4tb6FpKUh+TUDtQ9oEoCyp6N/1CSTwYNegk
 8IpQNMKN/VDsN1+Krbc1G4cyFli512nDl2CUGegCNGSspiNcn7L2M2EDkJ4tGuSv
 K0FA94nGehv9NxvpyzhL1cGvmqeC2/v9i+gZatkJATO9VzCjDiLpkzVdffIAh+FC
 FdK959f9du/g9UTWMODoqn2ScQGhA21UbueDAEhNzrCIeqVgSPsX6IYjgKk+pxa4
 jauUj437ZdTgmgyMELwKr8ON8eCbia9oNggAhKUQQGMDTRRxbCJOu/knRcnbtxni
 8jb6NHd2CDzDPESyendZiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752072632; x=
 1752159032; bh=fo/uKwrQq3uTvYaoQUbGlUoCxtjnYXg0yjCQR0lYugo=; b=Q
 JGP4D+yMQHSCol98hftmqKMxu0vwSgwtftBYkuVJ9Md+GygxWVHRqIn4n4L2pdtL
 /eSusMv3s+wEzYaRYxJ/WuQKpQeFKJe/GkDrt7pO2NlNpJoFoeoJGyHWebEe1gSM
 V8vTHpp5YgLsxHBMDFkUmbVYOhyUA6mdzqJm0gRgqMnR6sGj//5So3vu4UaZvaTX
 Rm0LcxIqtcbIvHnqgOKSvpUm+waA1h/dtJ4wNbUUHtA9MbS8b7/+PUtzZfTK1uth
 UB+TEs3mK9lJF0yzekqRD0nMhiAjUd2gZllQDrh0wpYhBlM/UuzF9pq4/Mr1JTTl
 OmB1bXIBx3DNBtFnOfl2w==
X-ME-Sender: <xms:uIFuaLHf_B1zYy6uGMo3srkpZWBpcyXwEEroGA2ha8Um78oqYQUlLQ>
 <xme:uIFuaPu62Lhngnmrr_-jt_L1k_5XBlS891ehxTNcgMByPUjzZ6ODxCWEOZI6sfVuG
 xmDT1kU_LQ57Qlpmw>
X-ME-Received: <xmr:uIFuaCsjd3SM8mT7QlIGXox7OWljoZ3KH9Jm1oH5XBB0wbqL5VUEONkw64yaQDkFdwVqAmj7V-LgpdCTBraj8wg89g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepjhhinhhgjhhinhhg
 rdifuhesihhnthgvlhdrtghomhdprhgtphhtthhopehjuhhnfhgvnhhgrdhguhhosehinh
 htvghlrdgtohhmpdhrtghpthhtohepgihirghohihunhdrlhhisehinhhtvghlrdgtohhm
 pdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehfvghrrh
 huhhdrhihighhithesrghmugdrtghomh
X-ME-Proxy: <xmx:uIFuaFB3OkHuwuBf-4LKzQJlVUqHiPluM8mRH7kfuA_0sw7akVXMWg>
 <xmx:uIFuaEMbhjlUxOViM45rOLXLqqyhPnpHCelDnR_It0uqG08R65YvjA>
 <xmx:uIFuaOyhEH4gtogL5wBhk2RvomdwUgNmI6RNBoaj9TmDj3c8G02x1A>
 <xmx:uIFuaEVZbN66SLnLlRl2ju0iMt1xypVOyDl-j00aJklFCJtroN6qBA>
 <xmx:uIFuaMa_lUjk1jqMyGqJMiNvpPX0xuq9_Xx5RrGkuxgVpLhqYxKG_nNK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 10:50:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: dev@dpdk.org, jingjing.wu@intel.com, junfeng.guo@intel.com,
 xiaoyun.li@intel.com, stable@dpdk.org, ferruh.yigit@amd.com
Subject: Re: [PATCH] examples/ntb: fix the heap allocation check
Date: Wed, 09 Jul 2025 16:50:30 +0200
Message-ID: <8553120.6TB3vktIsb@thomas>
In-Reply-To: <20250521172333.12859-1-bingz@nvidia.com>
References: <20250521172333.12859-1-bingz@nvidia.com>
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

21/05/2025 19:23, Bing Zhao:
> In some rare case, the libc memory heap allocation may fail and
> return NULL pointer. Before accessing the memory via the pointer,
> the NULL pointer check should be done to ensure the code locates
> in the safe side and no crash.
> 
> Some newer GCC version will check this by default and report warning
> on this. Adding the NULL pointer check will help to get rid of such
> warning.
> 
> Fixes: 5194299d6ef5 ("examples/ntb: support more functions")
> Cc: xiaoyun.li@intel.com
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Applied, thanks.


