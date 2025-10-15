Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C5CCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E11A40E2F;
	Wed, 15 Oct 2025 21:11:29 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1E240273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:11:27 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8F7377A0112;
 Wed, 15 Oct 2025 15:11:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 15:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760555486;
 x=1760641886; bh=D2y1ZKt0x4nwuVtw9959jEQNJXZIFiGrDmRlyLXCPIw=; b=
 Mt9zqGH2XR+ZzrYwJBX2+zm5RZO+2L6EVpJosdqv/KJZHRC2Pw89zpbj7q7ffh01
 biuv6qWFXalkQ+bgojEowTgoa62jvNaw0jWQY+aqQ7xA3CAtebgdbFy+ojH2/U/u
 MrxvLz8p+VU3UG3ag+sMMdlJdxSzduNYwF1p9KFIx5KalTo7iIHsKQNzszH+INTl
 7Z5pOTkoNxfpP+aa8/zcdJy5qOPiTvcQQTJILjZAhhuswtia+NQkEiLYo5vLNEnW
 7Uuk/JTgkHG4Z1k1z2idH+3pxer+iKSgIZ0KdtgZQGiIX8Xyz7Fn4D+x06FyhNku
 DlZnHGTBw8TW8nxTFeHefw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760555486; x=
 1760641886; bh=D2y1ZKt0x4nwuVtw9959jEQNJXZIFiGrDmRlyLXCPIw=; b=X
 hg4hus3XB7aMlgoGE3qGzHMrqdBuZlzfrVi3AxeeRoMyNphdjriqPh9kArA06Upx
 /r948bh+pH+zkj3fkwq+BVv3Wx6TpTq1fQwOwBVgp3nfbhxwDxVdE3fx6s6naees
 +E/0CbJjlURqXqHorQrkW6PtZGZNblcAR02Hw9kQqy1ROYUoflIs0c6r38Y39RZh
 IPF2LD9zku9FHtlW9PpuHc9NemJD4BPeLkTTtF+QZ8/S6BWVMhjGWHwGsm1usJi6
 ymme/j1jKJqgyyLMIWjTQKHnIrAmLCbs8XY2pAPRd31REXF4avpNiRaUpwh0ufNZ
 /IL1WOcaq3MCkx4rHPJOw==
X-ME-Sender: <xms:3fHvaJEK3U5471x70zWAixuCSjX_gkEaevI0IYWt84iEtoDlpqEuMA>
 <xme:3fHvaJTkdzY_L9GXy-2dKgs6q4l_yT_fsD6couWYLGZq3StJr71T4ofoHHpdt0tod
 AvQKv1FiRgy_xlhMKl3jcg0zog4OrdqHZ7L31Ou8SKV6LZ-gEO1IA>
X-ME-Received: <xmr:3fHvaKLB4QbjZHUjgUY_BXWayY9kxsoP7xTYVeLsRNQdGh0Tdn0CA82Cury6cxIf4rwC0iIquJ42aJN5fON-yiFqvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthh
 gvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghh
 rghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrg
 hrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdr
 tghomh
X-ME-Proxy: <xmx:3fHvaEYCPb7HLdA0_Nd4SVXSEH5_hE3_H8m1utaMqeJfZpD0JSb2Xg>
 <xmx:3fHvaM-30Id30DbOvUb3Sq9fAWjHO0UiAG7qTYsYwAsaFbnfOyDXWw>
 <xmx:3fHvaFarhdwpvo_Xtl7uRSp_WYzf-8RBTOl_bi-z1oQStf26Mqn2zw>
 <xmx:3fHvaAMM1svqKJCAAAy9601pZwdylknzCQlQ9wQ6eL-K68bct3XM3A>
 <xmx:3vHvaCD-FdvX61CIinOiq1oAIOOjEmSiQrtYQCoigTZfX4UQwwB6bT0Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:11:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, mb@smartsharesystems.com,
 Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
Date: Wed, 15 Oct 2025 21:11:23 +0200
Message-ID: <2946607.ECZNHGQPT7@thomas>
In-Reply-To: <20251015105025.573f5d3b@hermes.local>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-8-thomas@monjalon.net>
 <20251015105025.573f5d3b@hermes.local>
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

15/10/2025 19:50, Stephen Hemminger:
> On Tue, 14 Oct 2025 14:33:40 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > From: Shani Peretz <shperetz@nvidia.com>
> > 
> > Add a Python script that parses the history dump of mbufs
> > generated by rte_mbuf_history_dump() and related functions,
> > and presents it in a human-readable format.
> > 
> > If an operation ID is repeated, such as in the case of a double free,
> > it will be highlighted in red and listed at the end of the file.
> > 
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> 
> Minor stuff.
> 
> $ flake8 --max-line-length=100 dpdk-mbuf-history-parser.py 
> dpdk-mbuf-history-parser.py:14:1: F401 'sys' imported but unused
> dpdk-mbuf-history-parser.py:29:27: E203 whitespace before ':'

Interesting, thanks.

I'm a bit lost about Python linters.
I ran black, should I run flake8 + black? something else?



