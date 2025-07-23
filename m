Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF379C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 09:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4506E4065C;
	Wed, 23 Jul 2025 11:30:47 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B194040264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 11:30:45 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id CBE281D00981;
 Wed, 23 Jul 2025 05:30:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753263044;
 x=1753349444; bh=bbnney1iXBJDACNS0jlgcLTKhESm9yF/xY0S6EcxxTU=; b=
 ezl39A+SieTLP8up4iQFZMF76M4DzQRzYv/HWqHrpwyG03LEgAg8IJf2UZWX6/k7
 rHhS9C0qeRu1KKudgZuU8qzx8eLSTTwc4oOlt/dNeH+uaUv1K+0y3+imfeHsvc+O
 u+86aPEiS9PYXPCC57SydehXkedIbWJWI5PtJJCI2XuCrVJm8soVAOCrNJFxEy9c
 nMdnR43VLCXBGi4Im1ROXvyQq+pG4QvnQuVCsyK32O9TdTcFMJsy+F4SMGZufI6C
 Jw7NjkwjA2aFQoCVe6LYTSzIgg9Nz2b+yiDWg3fVqEqphMHs8wwtQc4/opTBIrkb
 eibA/lSv58e0YXl2S5oaOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753263044; x=
 1753349444; bh=bbnney1iXBJDACNS0jlgcLTKhESm9yF/xY0S6EcxxTU=; b=Z
 d4Cl1a1TYTAj8hX1HvuQyJJEcud4+CI7bCA/FTjD6h9CboX+KEl3p98asVhosWgi
 J1/0LJ61nO5FaFsJjDf2bkxGuHYrm1uByOUx1nDSekOj9AviLd76+ysygtRiz6p7
 1Mhdb+UYtdZgSju2M8svpUdyZ/m2Cuz0RxsmCvluF9GlQsbDm9YyhIuBRd9mqidq
 TRicBBWzY59Z16bmf5VS09fqVEHAmgBBDB1QJHZMtIfWIPDcHj1zDhuf8GVq4BZY
 wJ/ULvKVjFVM8wZ0XDaJ5CSF4Y9MnZTiYF+t8wzlMg6qnaqhO7eh7DTUXOcEaPpM
 MM3Ao1kBU3+PngwBT6oIg==
X-ME-Sender: <xms:w6uAaPTVY94LCKn9C4le8OIugvJEI4qLzN1psWptqyp8TTQmXSCmUw>
 <xme:w6uAaGJklr-tDMQj4uJq8oyHpMe5_f_51Ti6EA542KHxiDmlm9PNwQhKEA8q3P18Y
 O-iD6gyHXwde8j7HA>
X-ME-Received: <xmr:w6uAaFCwvVLDCs2NtqtUUBRgqgjcPnEYUnNEL8Xj7Q-Y_2RTRXW4K4g-1N7biD-w74O28cOksb-mHGVSFR28Nskwdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 grrdhstghhohhllhhmvgihvghrsehshihsvghlvghvvghnrdguvgdprhgtphhtthhopegu
 shhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhdrrhhoshhssggvrhhgsehtuhdqihhl
 mhgvnhgruhdruggvpdhrtghpthhtohepmhdrphhfvghifhhfvghrsehshihsvghlvghvvg
 hnrdguvg
X-ME-Proxy: <xmx:w6uAaPCE_jPZAfIW_IQw3qXj57zOyhnO_Th7V4NWvMMwIuLF2PLCrA>
 <xmx:w6uAaHBkrwFqtEiTLelonDKxwOywuSa2ClIAWiIom3ynTvwb_fWtxg>
 <xmx:w6uAaKogQDh2yDGmymt18e2kbE_AsauTDCMrJfxha9VCquwjzNmsPQ>
 <xmx:w6uAaBn-Wh2R5FF2aFP5ZmvHJ01D39J4lILkFJCMxhO-5RJiN7LrEg>
 <xmx:xKuAaFPSH_J6hQ8K5idi8cptO9Cg4a8LSic9dKrzT38I-b8_CdEYL_37>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 05:30:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>, dev@dpdk.org,
 Michael Rossberg <michael.rossberg@tu-ilmenau.de>,
 Michael Pfeiffer <m.pfeiffer@syseleven.de>
Subject: Re: [PATCH] net/mlx5: deprecate representor matching devarg
Date: Wed, 23 Jul 2025 11:30:40 +0200
Message-ID: <6179797.31tnzDBltd@thomas>
In-Reply-To: <871879d3-b34c-4cea-9ae0-4715fb1c45fe@syseleven.de>
References: <20250716093846.1117794-1-dsosnowski@nvidia.com>
 <871879d3-b34c-4cea-9ae0-4715fb1c45fe@syseleven.de>
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

23/07/2025 11:07, Adrian Schollmeyer:
> Hi,
> 
> On 16.07.25 11:38, Dariusz Sosnowski wrote:
> 
> > Mark repr_matching_en device argument exposed by mlx5 PMD
> > as deprecated and schedule its removal in 25.11 release.
> >
> > [...]
> >
> > A new unified representor model, described in
> > https://fast.dpdk.org/events/slides/DPDK-2024-07-unified_representor.pdf
> > should be developed.
> 
> The unified representor model seems to only address aggregation of 
> traffic of all ports to a single representor (the e-switch manager port).
> In our use case with BlueField DPUs, however, traffic is always 
> intercepted by the DPU and handled differently depending on whether the 
> traffic came from one of the host representors (i.e. the host system or 
> a VM) or one of the physical port representors (i.e. the the network 
> fabric).
> These two traffic groups are usually processed by disjoint sets of CPUs 
> processing disjoint sets of DPDK ports.
> With repr_matching_en=0, we can flexibly steer traffic from many 
> represented ports to different representors (e.g. dummy SF representors) 
> to aggregate traffic by port group on the receive path.
> To do this, we create flow rules that tag packets received from the 
> represented ports accordingly and match traffic by this tag in ingress 
> flow rules for the aggregation representors. This is only possible with 
> repr_matching_en=0, since only then traffic coming from arbitrary ports 
> can be matched.

Thanks a lot for your detailed feedback.

> Hence my question: Can such a flexible mapping still be achieved without 
> repr_matching_en=0? Otherwise, removal of this devarg would break our 
> use case.

I invite you to participate in discussions in the follow-up patches to come.
I understand we must find a solution to cover your use case.
I hope it can be part of an ethdev API, instead of mlx5 specific behavior.


