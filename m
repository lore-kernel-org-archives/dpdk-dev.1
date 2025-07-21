Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA1C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E583B4026C;
	Mon, 21 Jul 2025 19:44:45 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 682204021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:44:44 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0E1AA14001A6;
 Mon, 21 Jul 2025 13:44:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 13:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753119884;
 x=1753206284; bh=gyq8XvVJJ5RfT69hZNHjjb3VU2cj8bOgkZBL9QtSzLY=; b=
 Aa+7IMlO/0Cr+TotfeSIACOXjTMUoAYhv5NPmh2XOD8PG5m71CVW0EG/gnhW3Kcn
 BDyxigWSdB81mAI6duJZgRwqqsrBeUba+F6wpY0D+XgVpu+Z9wDc5hSH4Cz5F95z
 EeyI1L4dUYizSiQ6u5r8fjSbVOna76fos6qvnFpw4Fa9WhgUqxM+hC16/4Vkzkuq
 2dYzd9iio0L9kWhHhynYrHQDYiGMFGUdBWZsH3cme3HUcK4u1gR9+O88U3AqBcBt
 yTPI8W7AREKKsEWlHQprdHsk+XdSkfUqvijPKZa6Johe5eOkh4o2KU8bppzyzTnN
 Hjhcd/udOvzOoGrSHSS9nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753119884; x=
 1753206284; bh=gyq8XvVJJ5RfT69hZNHjjb3VU2cj8bOgkZBL9QtSzLY=; b=W
 8eRmcAebsq8JPaz/9e7N0b6vq+iNB2lwRXakAHmu0Hmfr98AJPI/EbGS4eRONnt5
 +RXET4i/u8XOMs4cP67VW6/DExDBJxSHC8Sn46XjYFxnWcFNMhdQUKT3uUkkfXwB
 z6bhDbMC+C1Vw9qhs/Ta0WjAEpgQgJ322mmlQULL+uECET2AZN6ya1UpwSvtA/nV
 3D06c7Rm4HWIJhtYcZoWWDNscEG4jBH2kB7EKe6csWqmvWWDOmHTiv8/H3Ge7SOV
 +HvQf2K6/hG04hxmNeCjspJspHdZkBqsQPVAtU50LW9OEaJgCW5XFw5e/zKoHUEQ
 X6T2Ez4S0tSK3QkAfZFyA==
X-ME-Sender: <xms:i3x-aNn9nSNYbONIFsHzUFm1fSpqdMjINeiKqI-5K_FR2zRpEf-A2Q>
 <xme:i3x-aDsVNbyt7wrdIJfmS9D2V5qBSWBJn9iJU6GM6BuRr3nxhVmvCCKr0nOQ1SByl
 _YMrj9oN5KuIybykg>
X-ME-Received: <xmr:i3x-aLfMP_PWzygS2GVW93i05S-aOLqpxxLdjdxyYMWgpEfd4InF0dApsrjkd9GkGXaxkJ2FUToDI3pjV9p8ybODew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdejudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhht
 vghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepkh
 honhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:i3x-aLyhtLwmR2yeWe2-9ys3uDTLWDCxd3SIH9SLrOaTLnOmNJzBNQ>
 <xmx:i3x-aBHTp5zGokX6deI85yGEbVSDhlqbzriEyb_tDV5xywyvQ6O-_w>
 <xmx:i3x-aPxZA3oRIN1Kux3x1msVV-XHTlA4FeOf1dhYh_RYpfjQDqKQEQ>
 <xmx:i3x-aCsGLMHuhSi7oCrQoKeHm7SfxSjPPvbHnqz5MRhP-o5X-EmJWw>
 <xmx:jHx-aLnjx_TTP-siswDE79rmas3SytHJ5icdTdgLoFJI-3AiykSh7LoI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:44:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] doc: announce mbuf fast free configuration requirements
Date: Mon, 21 Jul 2025 19:44:41 +0200
Message-ID: <3800967.RUnXabflUD@thomas>
In-Reply-To: <50e97877dbc7422fbe6ba8e86e9ce2ae@huawei.com>
References: <20250713142127.349940-1-mb@smartsharesystems.com>
 <50e97877dbc7422fbe6ba8e86e9ce2ae@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

15/07/2025 17:12, Konstantin Ananyev:
>=20
> > For TX mbuf fast release offload, the mbuf mempool pointer will be added
> > to the ethdev tx queue configuration structure, so the ethdev TX burst
> > operation doesn't need to fetch it from the first mbuf of each burst be=
ing
> > fast free'd to the mempool.
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> >  doc/guides/rel_notes/deprecation.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_note=
s/deprecation.rst
> > index e2d4125308..a7b4505a24 100644
> > --- a/doc/guides/rel_notes/deprecation.rst
> > +++ b/doc/guides/rel_notes/deprecation.rst
> > @@ -152,3 +152,9 @@ Deprecation Notices
> >  * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
> >    ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
> >    Those API functions are used internally by DPDK core and netvsc PMD.
> > +
> > +* ethdev: Configuring a transmit queue for fast mbuf release will
> > +  require specifying which mempool to free the mbufs to.
> > +  For this, a new field ``struct rte_mempool *mp_fast_free`` will be
> > +  added to ``struct rte_eth_txconf``, and must be set when the
> > +  ``RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE`` offload flag is set.
> > --
>=20
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Looks like this new requirement is not encouraged a lot.

Per our policy, it will miss the release 25.07.


