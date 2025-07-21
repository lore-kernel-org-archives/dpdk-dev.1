Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89FC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C80A4026C;
	Mon, 21 Jul 2025 19:47:25 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 190664021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:47:24 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B6348EC0292;
 Mon, 21 Jul 2025 13:47:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 13:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753120043;
 x=1753206443; bh=bB0K39AjzsO3tfd02CTjKSGQoudv2Hs9HGc/eZsOvPM=; b=
 KLLrfsg+kb5G+EQU9o8vMCfnQyFT8Kv1E4CZQy/6jqzN3YHhfOKPEIAsQglhuhNy
 2eetXRB2z+xpb48KuxH9lbYsoJr9aDpMv/hegJjrlSDmA2tT6D8rg0vtM0Ia2bmN
 074kHEhmZb5LQWVMr65wv8gkQryYoija3uUa947bnn+5iUW7LF2WMEzTUz9mZIMb
 JfdiREjQ5i5psXLuvRGLMReMJy/g2Mc2EukcunoEHJHVHNbLqfgG7Hkm0tAvH/Tq
 67+TXcySmQlQzMUn7yZrrf5W71E4SPBL9KryoI7dxlaTKBaBwwhWXrR95jj1Q98t
 uI1D87zSx8bi27/5P1wtaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753120043; x=
 1753206443; bh=bB0K39AjzsO3tfd02CTjKSGQoudv2Hs9HGc/eZsOvPM=; b=N
 xuWjDPlW3CTPn/yyt6Vc2x18z6rVMzoXXz1yPnqWLq6XjpjAm89bh95PadpONUH6
 FBE+L1Gj7wk0cB4JkZaxBWGnPx2cQ4Fm+JpuBqOYTmzo8DTFmtQCKhFqlIErLt2l
 YNEPzdYd/W7/MDZHqBU4crxy60697NkVwgeZ8PLA/cxKYdOQdDmSLchoPXG06L3s
 VKsj/x9Q+UnmjGt0XIfoZCycm15rDgEpMeRq2GiKTudMrcQ5uN01OqZ89c5PsCyz
 hloWdTjS5SXe3CFZTJN41q+IumwUvWClp9IKpkcuxc+/ZlXOmg7tkGWdrIpJtdxN
 QKKGZAyk5G8TT+wQdqUmg==
X-ME-Sender: <xms:K31-aI5DCBmO8z4DL-ZPJafFEXL-I1D65tGR6-JXqK_PvZVnzZosFg>
 <xme:K31-aCWy4cj5ifdvI40nqsboMLvAXB6NWNOg1YSZ42UYw1avc9YZj3GswIWXN9PL3
 r1G0lhL4LtNLG-ZNA>
X-ME-Received: <xmr:K31-aH6HL4Ie55v7GgWDfiDETxNnVBkEjE76fhuqePK9DtxQfdiDOs5RePnPaIZaJYV37UH13G8gKEPcaJV_KDriXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdejudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmih
 gtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhih
 vghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprh
 gtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htohephhhonhhnrghpphgrrdhnrghgrghrrghhrghllhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:K31-aNqzlbRb_CAVqWj2WO9da6snznHvKMGSr_HtOhh4YOFUPmpKog>
 <xmx:K31-aKmOe8u-gaJztv5YmGddS_yvIoxJU8bs57WN6IZNj7G0ieN2jQ>
 <xmx:K31-aJMKnMVi4nvKXPqJHqWRiTQ69KqdcPCTNjn_5PLgaAGZKBVtwg>
 <xmx:K31-aOOWQo0cYMK-F1mdTygp_srWlyuI3tRh0apDlF8nNw6lWO5Iqg>
 <xmx:K31-aF5WmT9J-bu6cRZue22he4GyBY_i9ik8PaBTT5VK6imRCIPfzXy6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:47:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Date: Mon, 21 Jul 2025 19:47:21 +0200
Message-ID: <1962943.eGJsNajkDb@thomas>
In-Reply-To: <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <5695570.h0BymrIErR@thomas> <b2f6bd8eda1c4e728caeb5ee918d0068@huawei.com>
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

14/07/2025 11:01, Konstantin Ananyev:
> > 10/07/2025 16:37, Andre Muezerie:
> > > On Tue, Jul 01, 2025 at 04:17:20PM +0200, Thomas Monjalon wrote:
> > > > 23/05/2025 01:37, Andre Muezerie:
> > > > > The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establish
> > > > > no limit on the size of each element in the defer queue.
> > > >
> > > > Very good, we need more unlimited API in DPDK.
> > > >
> > > > > With DPDK 25.11 a hard limit will be set (``RTE_QSBR_ESIZE_MAX``).
> > > >
> > > > I think it is a step in the wrong direction.
> > > > I prefer having no limit.
> > > >
> > > > > This will allow fixed C arrays to be used in the functions' implementations,
> > > > > avoiding VLAs and use of alloca().
> > > >
> > > > I don't understand this justification.
> > > > Why trying to remove the 2 alloca() in the lib RCU?
> > > >
> > >
> > > Only because other developer expressed concerns that using alloca() allows
> > > ill-intended callers to cause a stack overflow.
> > > I personally also prefer to have no hardcoded limits.
> > 
> > Yes I vote for keeping alloca().
> 
> Probably it was me who expressed some concerns, sorry for late reply.
> I can only repeat what I already replied to David:
>  
> For that particular case, my reasons are mostly conceptual:
> using alloca() doesn't really differ from simply using VLA,
> in fact it makes code looks uglier.
> I understand that we do want MSVC enabled, and in many cases such mechanical
> replacement is ok, but probably better to avoid  it whenever possible. 
> 
>  suppose we have 3 options:
> 1) use predefined max value (it could be quite big to fit any reasonable usage, let say 1KB or so).
> 2) use alloca().
> 3) come-up with some smarter approach.
> 
> For 3) - I don't have any good ideas.
> One option would be to create that ring RING_F_MP_HTS_ENQ  flags,
> then we can use peek API  for enqueue part too (rte_ring_enqueue_bulk_elem_start).
> That would solve an issue, as in that case we wouldn't need to make temp copy of data on the stack.
> My preference would be either 1) or 3), but I could leave with 2) too - specially that I don't really use that part of RCU lib.
> Would be really good to hear opinion of RCU lib maintainer.

Looks like this new constraint is not encouraged a lot.

Per our policy, it will miss the release 25.07.
It means we will stay with alloca() for now.


