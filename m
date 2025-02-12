Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B9C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3B142789;
	Wed, 12 Feb 2025 15:56:59 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id DDDE04111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:56:57 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 5E27F1380044;
 Wed, 12 Feb 2025 09:56:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 09:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739372217;
 x=1739458617; bh=Pt63Wb6mmQttGr+z9J7TfcbVW69RgSJgFjxSvWcM14s=; b=
 dqk8tLSmNf2GcxbW2e6VEu/AyybZ9v2Hn1UG2cnsGskJKH0wX0i1z735vmvSHNsE
 Q2xR8inLlx2jsK9I9IFTswJslhEk4aKrvBhilGXgcbYyJ2UNwlsngngH4i6Ar9TD
 pTfIs5mYoan6KG24D31V4/o4BQR3ytzui6uVUiFqaPMdktNif7z6bm9T1sfwwoqy
 6R9+6FCWcDb7HKzysmYZZDgrLF3fKSva31tuz+He6SPyqktd1IOkRpv361yCl2HK
 O0gNxubqSNiLqPiTCaAIDm5hlA2lvdBPxT6txa2sm0Cbf2bsXZz8hI0ZiYD3xyhm
 tnxyei6LSmx23nNx9sb0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739372217; x=
 1739458617; bh=Pt63Wb6mmQttGr+z9J7TfcbVW69RgSJgFjxSvWcM14s=; b=E
 O++8mRMPh0m+nfRrb69WOUO7UI43HjhdpVeiYUdmf0ojWPr9/sCOi14VO4OUeOKH
 XVxTCsoOGVNe/yi2UW+yflA7bCcHKnKkqvOqVJaPnFm+BjiVIpsumtBqyHIfX72v
 PjSarMOMXiIK9WSqxVbq3gYNjXTrmvr+FtiW4fcFEtRpARBQzO6sXU1B1mgxv46l
 p23lOHvGgoU2twoBMY8z70hrRsJ92zNjkIox5ZbiyYr/jPZBf58ifFC1ShY8onS+
 c6R96x7S2f8M/LDkcbTtV792SjwosQy69rYjqoQUFuJpgWdVQMBXq3VugszXeAa6
 AhCqKEJLDiWjBM4GFlYUg==
X-ME-Sender: <xms:uLasZ7WbCIPS8SsGeVht6_vWdU-MhnGM1qWEIg7ezXJ7RLqbp0dVMw>
 <xme:uLasZzkGYU9nJA2S4yoplaiGwK12Qhs6yC10yBVfr0hn2gcGTuCtrZyr9vFLtTzrU
 NsvE7JxCqeA-a1uXw>
X-ME-Received: <xmr:uLasZ3Y00xnBIOG8s4trHjak-ZC39c90A4zZNntByLHeDqdu13CX_zb4vMVbWAfPasAqPd-KS2GBH2jC9vkFhuRwRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepgedttdeljeejgeffkeekkedtjeev
 tdehvedtkeeivdeuuedvieduvdelveejueejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsg
 esshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehfvghrrhhu
 hhdrhihighhithesrghmugdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthh
 gvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepvhhirggthhgvshhlrghv
 ohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhhrghhrghfshesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepohhlihhvihgvrhdrmhgrthiiseeifihinhgurdgtohhmpdhr
 tghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohephhhurghnghguvghngh
 guuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnhes
 hhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:uLasZ2XGurVfShFZZsnPk02As2O77sPG0sqVtPlMIaVujAot37b4zQ>
 <xmx:ubasZ1n7JOaGTvlSkYtFQd-mNmK3y0wn6Yk6VKpN_qtsyF2bsi0TyQ>
 <xmx:ubasZzeXg5x5IwxH49G5_8lR73CBJ6andlGuN0enESmThkEWUqiPSA>
 <xmx:ubasZ_FdNGm2UEUxeMSUU-qG_CBw2RYshuj-_SpOlSSVgLA4oRe3Gg>
 <xmx:ubasZ-cVFY7XvJ-Lo7SU9XzKlUnrS4FDa24RMyxHWyEHfPRvX9lXw31e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 09:56:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, 
 Olivier Matz <olivier.matz@6wind.com>, dev@dpdk.org,
 Dengdui Huang <huangdengdui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v4] mbuf: add raw free and alloc bulk functions
Date: Wed, 12 Feb 2025 15:56:53 +0100
Message-ID: <3379015.AxlXzFCzgd@thomas>
In-Reply-To: <20250130144949.671542-1-mb@smartsharesystems.com>
References: <20250114162544.125448-1-mb@smartsharesystems.com>
 <20250130144949.671542-1-mb@smartsharesystems.com>
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

30/01/2025 15:49, Morten Br=C3=B8rup:
> When putting an mbuf back into its mempool, there are certain requirements
> to the mbuf. Specifically, some of its fields must be initialized.
>=20
> These requirements are in fact invariants about free mbufs, held in
> mempools, and thus also apply when allocating an mbuf from a mempool.
> With this in mind, the additional assertions in rte_mbuf_raw_free() were
> moved to __rte_mbuf_raw_sanity_check().
> Furthermore, the assertion regarding pinned external buffer was enhanced;
> it now also asserts that the referenced pinned external buffer has
> refcnt =3D=3D 1.
>=20
> The description of RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE was updated to
> include the remaining requirements, which were missing here.
>=20
> And finally:
> A new rte_mbuf_raw_free_bulk() inline function was added for the
> benefit of ethdev drivers supporting fast release of mbufs.
> It asserts these requirements and that the mbufs belong to the specified
> mempool, and then calls rte_mempool_put_bulk().
>=20
> For symmetry, a new rte_mbuf_raw_alloc_bulk() inline function was also
> added.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



