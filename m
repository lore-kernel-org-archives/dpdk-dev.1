Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B7C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 21:43:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAFC1402D6;
	Sun, 20 Jul 2025 23:43:29 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 68C414026D
 for <dev@dpdk.org>; Sun, 20 Jul 2025 23:43:28 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id F1BD4EC01F0;
 Sun, 20 Jul 2025 17:43:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Sun, 20 Jul 2025 17:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753047807;
 x=1753134207; bh=RBf5SwewT5nasQwHilO7Kbyn8pLh6AhT94sGwXCtI5w=; b=
 UigiX8qxPhUgBjb7VVa58AIAhlSoWXXAuBHzalZP8AJvWQnZ5rMgvd8pOgyxelr4
 bmDEDYvKyFJfFkRFfvoumlp4KTmDkfY9oqkprAWCvbsa7TWEuLGAOyp0Ih3Q3f0G
 CEu3WgnSzPcz57weJBeUGw+M0ypBW0D3VJmyO1Gp1S2tX236lAs801uec5qjvxWs
 OO0qfF1jZR/5RvUfu8d9RnC4UxLa7UiqpoePX77+3PQ9dUqJ+9lyBKJctZYNSs4B
 +a7FBcDc30xvzybGxJnB92cBWDB8aUpnOKSVP/tMikY4QYTfw6TaNVrZvHCrLCko
 ZeN85hj9Y5lyYrhVNE4qjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753047807; x=
 1753134207; bh=RBf5SwewT5nasQwHilO7Kbyn8pLh6AhT94sGwXCtI5w=; b=P
 Q4eeTuWSNNOAPosLtWz/lfyYQoW1dq8jCic769mYGBlhGSwDADK1Xt3SrcH1YS7j
 pyGhV8cAPG0bzxnBmK98G5fEbzhhDIZ+N7q0P8uGIXuwEbIwjznqaYFZKB0eTJ1X
 M4lWM2NB3xu8VIHPZbZDd9xx6EwQHIkdNTBonkREk6JVEdqSO5heyQGyNV3G8wnq
 /0qxL3kPTIvNypx8D0jZ4hQkgOH/8CZsWagzWYuyM4KNCksxHDASdJr9PEgQjB9l
 685H5qFblv18o0AMz1SRJViZJk0eDHvgMOslw8dwDpDJNbu7MY4ElUXTuSU/ibCS
 jZQWAk4Miqe8nx/kDfrgw==
X-ME-Sender: <xms:_2J9aLzIEib_uMbBoRh1RegTy_okNxwmHyqzaqrsmI6fUYiQQCKgvQ>
 <xme:_2J9aO-YTp8NoiaO9_InxlzlJ6RoynOwu-vG44x2VET4T65SYRKAiFttiJ_B2Hztz
 wgN6WTyKyjAaON6HQ>
X-ME-Received: <xmr:_2J9aBzZpuBgFx7BSF020kNP6jnRJLcS9UT6e6J8UFb_DgZB2RD5kQiP64AgrETFafhXtomXMgC9L9lYVep70q9kHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtdefudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmh
 hitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnse
 hnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdp
 rhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhope
 hvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehmkhgrshhh
 rghnihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvh
 hiughirgdrtghomh
X-ME-Proxy: <xmx:_2J9aOpwB1g3B5WLIgN6oXquyadFR-QoE9MFK0c4kTqf9qAwqE-8ew>
 <xmx:_2J9aCrHVwcgKDy2kdU5dBiXdNpEJBX4Ize5re4t4KM6-2DJig0ePA>
 <xmx:_2J9aODxx5d0BALynbaERpoVNZy_ka0n9fEE3C_wvBldWWxpH5AZXg>
 <xmx:_2J9aAtNY0DFHcDpyqoANj-Z7ymziff4QbtuQblqiPRnVLCoPYJ81A>
 <xmx:_2J9aAS-sk5eTdoJOtDRtb4twQshCzd8BILoDcnpJDfP2p26MsaHjCxv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 17:43:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, bingz@nvidia.com, matan@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, viacheslavo@nvidia.com, mkashani@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3] net/mlx5: remove use of sizeof(rte_v128u32_t)
Date: Sun, 20 Jul 2025 23:43:25 +0200
Message-ID: <2444510.NG923GbCHz@thomas>
In-Reply-To: <20250709072609.an5o3r423bqqapmj@ds-vm-debian.local>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
 <1751987516-30482-1-git-send-email-andremue@linux.microsoft.com>
 <20250709072609.an5o3r423bqqapmj@ds-vm-debian.local>
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

09/07/2025 09:26, Dariusz Sosnowski:
> Thank you for addressing the comments.
> 
> On Tue, Jul 08, 2025 at 08:11:56AM -0700, Andre Muezerie wrote:
> > When compiling with MSVC the error below is hit:
> > 
> > drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
> >     undeclared identifier
> > 
> > The reference to rte_v128u32_t (in code and in names) can be removed,
> > because the code which relies on MLX5_ESEG_MIN_INLINE_SIZE does not
> > really use rte_v128u32_t type. The relevant code e.g.,
> > in mlx5_tx_eseg_dmin(), always copies first 2 bytes of the packet
> > (through uint16_t pointer, these would be first 2 bytes of destination
> > MAC address) and then does one of the two:
> > 
> > 1. Copies following 16 bytes using rte_mov16().
> >    (Corresponds to first static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> > 2. If there is a VLAN defined in mbuf, then:
> >    - the rest of destination MAC address is copied,
> >    - source MAC address is copied,
> >    - VLAN is inserted,
> >    - 2 bytes appearing after VLAN header are copied.
> >    (Corresponds to 2nd static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> > 
> > The amount of data copied is inferred from HW arch and packet descriptor
> > layout, not rte_v128u32_t.
> > 
> > Since rte_mov16() is used in real code and rte_v128u32_t is only used to
> > carry over the length of the copy, this patch replaces instances of
> > sizeof(rte_v128u32_t) with a macro named MLX5_SIZE_MOV16 to better
> > reflect the real usage in mlx5 PMD.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.

Looks like the generic vector types rte_v*_t are useless,
and not compatible with MSVC.
We may think whether we really want to keep them.


