Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB6ECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:32:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04072402AE;
	Tue, 14 Oct 2025 14:32:05 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 4DDDC40288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:32:03 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5027D7A0044;
 Tue, 14 Oct 2025 08:32:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760445122;
 x=1760531522; bh=uI3WtWK2p5jXjXJBORw+qqs/XNFyyaxw7Ej2/vjIQMM=; b=
 HLYlNfvbqSBrm+JubZnPqrfYTJ9f9eEmM3s763IGqdRAAU7+zB4lcL848TPJp7uq
 CJ/aOT7ENg3p5S1Fk7Do3mFPQ6gN87nmYUhUHjZHVPaSrCmivHaDrEdXZW/7p2a4
 eN0xtOW7OuH5uKyaTCrbCHCLhjKEbifc6YAdcm91IeJx6hyDD+xwaK/+zUkE2bEh
 wjl2PHYADFNumj7Dbql5P7VXRyJ2AvxhNdA1bAj8SVuMn9/vAluJ9JlSvGLYR+gS
 qONH77btlLzrztau8ZnsrFbGVRwzsXD9dQ/1lm1VxrS/eyTxwF6x29+An+LfRw1r
 ZD1LoygKdY68RJlF/fsSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760445122; x=
 1760531522; bh=uI3WtWK2p5jXjXJBORw+qqs/XNFyyaxw7Ej2/vjIQMM=; b=v
 E/ytUS7yHooOpaJvURgO5k9w+j8Or5sgehGvX4tBwLhyaRgm1ql4sbWuTXfOTnm9
 4eiUEqLFM+K7YczOiyoXaT8hbTGnm1Ry6wgQ8l4K7SUc0IifDnxJ0HqrqDB8TZG1
 EnncDbO4dTib/qxr6aebHEm3UVRv+3SUWtTrYCsyyevhHeiouOy7SDSFhmSInHH1
 ZLddqcQDLCZ0EjauZMjEeThoHjrnoo70gWXQX+EYHaQ0yPkn0ngJKDQCUJJ4mUmK
 q5LyUZAvP8oNJ05s1VVMDm6drptJN4Uosp88fJFZXlqgcqljjQTPn7SmPD9j/L3u
 Va6YetnTyXATpcu6iqF+Q==
X-ME-Sender: <xms:wULuaBzKlHZOLLtqZcyyXNurT0EeoJevtp5PEZz8xCy27HmPYTahVg>
 <xme:wULuaKOPu8hogtKtcMZ1w64qqXKEpvPoh4HLpXLMHZ_35jUGju3xuNTDDOjOdXJTn
 rLPRUjQF1BnkM5kSKe9-pq1MFrzCsm-8OAitNIMqVKPki35e5Wk>
X-ME-Received: <xmr:wULuaG7iZRWNOgLZJknqlveXG5yCwnWeeblao7oKQsj-8XQE3dfMddMeI9ss0ifTRRxxNmBOwiYBeojlYNNQ-HOs-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvsh
 hlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:wULuaDl-qb7ehKmRHqIBI64DSjpL-gRYY8zgxtiMfiWce-03r4vJFQ>
 <xmx:wULuaPRO4YjImYBBIbQ3s4PWlrNxbk9sS-IEZDHTSPg3R-5IdBqCXQ>
 <xmx:wULuaKFFu_n_4Eg_ycORAPLyyB7JlDEjBb4efH_DdaB0-pGYCLwxRA>
 <xmx:wULuaMEaLcquO_cGN-KTBxooOac14G1vZaVhJqCXEoDZuIqQWTsMRQ>
 <xmx:wkLuaCda-lqzOG2YxNrOlzWVrvfXVPvxvHF9RPb3_DeVwQAwMZ_GNBqx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:32:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v5 3/7] mbuf: record mbuf operations history
Date: Tue, 14 Oct 2025 14:31:59 +0200
Message-ID: <4348674.RUnXabflUD@thomas>
In-Reply-To: <2949753.n0HT0TaD9V@thomas>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654C7@smartserver.smartshare.dk>
 <2949753.n0HT0TaD9V@thomas>
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

14/10/2025 14:03, Thomas Monjalon:
> 14/10/2025 11:59, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > @@ -667,6 +672,7 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
> > >  {
> > >  	__rte_mbuf_raw_sanity_check(m);
> > >  	rte_mempool_put(m->pool, m);
> > > +	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
> >=20
> > Fix: For improved race protection, mark the mbuf before actually freein=
g it, like this:
> >  	__rte_mbuf_raw_sanity_check(m);
> > +	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
> >  	rte_mempool_put(m->pool, m);
>=20
> The race is about a debugging mark.
> The benefit of marking after is that the last mark is the upper level,
> so we can easily distinguish between a free initiated by the app or the P=
MD.

I've messed up with another consideration.
Here we are in the mbuf lib, so the lowest level.
You're right it is better to mark RTE_MBUF_HISTORY_OP_LIB_FREE
before freeing effectively.


