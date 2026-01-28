Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A1CD3F068
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 14:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BAEE402B6;
	Wed, 28 Jan 2026 15:11:07 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 15FB94003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 15:11:06 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 83C3F14000B5;
 Wed, 28 Jan 2026 09:11:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 09:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769609465;
 x=1769695865; bh=w8EnWQ0tPCEH/95bLBB8ApxsoZC1U38HlXFSLcBUjQU=; b=
 jSLylm9Iq2vRE5VNwmFxtlJWsDu6/5oZk5gvZxwlbIRKfYGhiEmAuXwT2X2+Z7DD
 yJVIKpV2f60/H0gbAO3seEN25Kqoh2iQxMRiGEeIZJ/Kr6TFl0jVccWzYkKu57a0
 E9AtsER2QRxkD0YJ8gQTO9PCpaO+LQhdCmmzfTBgklBulGPaB4vU3aMRtL68bfjh
 U6xnG4ah9EWrGNmX0dJIr8wz/4nnxXlIcnLv09E6FvwE3wc5EXfFjwnXUH73/CMh
 wk+EphoMkw66/443p5FSJUXUcOdQoYGPDQ3CJm7Fped1yVEDKGc0JzvdnLbxL1up
 qXUL1FSr9Qe2rncKXsuY1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769609465; x=
 1769695865; bh=w8EnWQ0tPCEH/95bLBB8ApxsoZC1U38HlXFSLcBUjQU=; b=o
 93HlK1CIVE70MnBLy0+9DtfN/GHAD6oe7sGj84Nbk3tNG2k7gee/hKcj2fCGsfyh
 Bh/Es3ZzqrlebzYrVbOlG8lEaTxMIlUnHnZlzwQN9IUgSeozWzYZNhbjkUFet7YS
 PzBCEAVHu5sK4SsQYTRhBHB5YArBbbxlloDYW4doahKkI0ZzYliQ2Meo7TD+h9J5
 Msha2gEP9o6HCOgaRnW6TKMevniD5ZbR+2+xPa6o0x0gKNjDKPLmXVcsBQFXdpu4
 UuF1KdN5atccahnD5U484JNqEx+NFVuBuyKvW+ubAux261VlzNIW6dSrIQfxxcEM
 5+5k9rbjKg7+coAPKRfTg==
X-ME-Sender: <xms:-Rh6aUra2jPIUlpTN5RJkYQCKr8EWf0dSK9bhAFBxilLFujx3bNsRg>
 <xme:-Rh6aWG7G2ttDUXJSboQnKfdOtriHxOtq55uL65UV5cTNxjnalLv_MnvBLcqHKaxu
 yphYbF33OY0fN6felgq0bCebZTNxqEOWprrWrjrXeBNdHPwVyaG>
X-ME-Received: <xmr:-Rh6acsBf-jtN2eckD_cWhVHOxIMfXVhcV6dreZbRkzZlB8CY8dCbZnoqb-2uc5tD0oLqExWCxU4IRaGU_HcnAxxoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhope
 gthhgvnhgsohigsehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhp
 thgrsegrmhgurdgtohhm
X-ME-Proxy: <xmx:-Rh6aQUMAeazaz5Iy26izXtEexAhiwbRpXneazM7CoN2t2ZZFrQjfw>
 <xmx:-Rh6aQEv7eziUofXrOyv-SuQa-KiNyUTN27eSmsKrM7gUGLb1weJ3w>
 <xmx:-Rh6aa0TxbFlDI2iZ2ySUSc6lvUWI1SmEroDbmeALCAXFX4tBfDOKQ>
 <xmx:-Rh6aaOLKB-9vqIgwz9KaftLDhrEBahhga6GEwt4vuUgFVaCRUFDAA>
 <xmx:-Rh6ac_2UOjWZc0wAFZMqfvHqa1xYKgUvADyw0j-KVd6WSiLjJlExr9D>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 09:11:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH v4 1/4] bus/pci: fix unmap on failure in multi-process
Date: Wed, 28 Jan 2026 15:11:03 +0100
Message-ID: <3016263.SvYEEZNnvj@thomas>
In-Reply-To: <20260128120005.2777473-2-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260128120005.2777473-1-thomas@monjalon.net>
 <20260128120005.2777473-2-thomas@monjalon.net>
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

28/01/2026 12:58, Thomas Monjalon:
> This error is seen in build of type "minsize":
> 
> In function 'pci_vfio_map_resource_secondary':
> drivers/bus/pci/linux/pci_vfio.c:1005:28: error:
> 'maps' may be used uninitialized [-Werror=maybe-uninitialized]
>  1005 |                 if (maps[j].addr)
> 
> On failure before assigning maps, it was trying to unmap.
> The fix is changing the goto destination after unmapping.

After David had a look, he told me unmap would never happen
because the loop range is empty.
So we should change this description with this:
"
On failure before assigning maps, it was trying to unmap.
The compiler should have detected that the unmap loop is a nop.

The fix is changing the goto destination after unmapping
to allow compiling with "minsize" option.
"

Because it is not fixing anything but minsize build,
the title should be "bus/pci: fix minsize build"


