Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFCCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 07:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4906E40E6E;
	Fri, 17 Oct 2025 09:32:23 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2D5D340269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 09:32:22 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 9F7CFEC0009;
 Fri, 17 Oct 2025 03:32:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 03:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760686341;
 x=1760772741; bh=RhybTghiZJ/5eNgpSC5e36k03kbpqps2ZGK/sptLICo=; b=
 XHKTryQdGOWXveNcNvOBdqW1gBaQq8vblOKOEcY3OFVXZ32o4/vbFiycJ1Gsnvf1
 p+C1BdAgwsuOUxo5kFtTTVkvPtgXrTaFNKvYZoTjqAwXLgtn3PI/a81f0QcjyfvM
 XMmhqBEYgkJ1pJK577wu0hdNRNnsLZ0DbA5vK6qg/kB39FGG27ziwfN26Ntqk1kW
 kqAT6QeswyWXI1a51M50BhfMTWguP5r2jEWljC2VEzD8bz7xH1lE8xg/saB6Gqg2
 gRdFqSHbPJdWrWAEwZgS5dWXmelzBBULzHrfH9fbjX/wr2OiBl+hpB/6SEzfuMFe
 ns0Wo/vJdW0eyBmFQLpkgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760686341; x=
 1760772741; bh=RhybTghiZJ/5eNgpSC5e36k03kbpqps2ZGK/sptLICo=; b=r
 TzzsPnwBBKyLjHoENI+pKXQmdc1a7VZodLzhZXNwjtyoNswJGWGbabHU/FJ1p3QE
 WRa0soZvWzdHvYyL3i6Le8w0X+9Z3XS1ukT8tRtWKswKt7PiAhDXcazjqUgq2u78
 GAc1+9lmztN6ooBJXeGCz2xleac1WOLOpqPwH3VHd4mu5420vZ85BbEPcIxhsAF2
 /GkWaVokPTCN6R71eTXgxLBpvBtQxiGQUw3rKLW2UO/aCGvuMc6QgP5ObxnWV/PG
 mDEpctFENBpKi9YZIISoMoAWFEsd7KxMCZ7A4w90zAajLSlHgnPBt8kZdes3XpLL
 vtWrZDSQFlMpxZ9iK4iBg==
X-ME-Sender: <xms:BPHxaCLm6NNN0I_fuY-sso6XKlOnbaehuFGWVu-C6B9CI5ZQOq02aw>
 <xme:BPHxaDHiQCB0ZVaEAHPgBTnz6mvmxnN46_kxWA-byF0mjUT9rxSMgRdWnjE4M11s1
 aaHKGr9U9atL96379RpV9VgiNbLK7PMj9z66AUKokWDUv_xcfPnMA>
X-ME-Received: <xmr:BPHxaOScPWD-Oq92BF0xfO3tXHNQQW0XnvL9NdugzWbbBG42i4ztD0eEq-hkxSqY-fFzADsXP_ywhbYYtb-2kllBEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekheekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BPHxaHfm0aZzeDz1E0156PE56A8iN7-dD3oqQr_J9r6K-1wiql5m0Q>
 <xmx:BPHxaFpl5YwQXHdiSTJkXcAEhVn-zlc1FBoyHZkIgd2DWRhzvSjOdA>
 <xmx:BPHxaA9zoHXSQNDlZ-Y0a4tCuRGhyqMunA1IHxziz3GDJjwDARxCBw>
 <xmx:BPHxaJdG-rYCw7RVwXm3B66dL94YqOyIGbY0-LRQCCWhJe7p7nr0ag>
 <xmx:BfHxaH1t7t3VAXiiCwOfycHSztoI3XM6z7FTRO6hzNBZQTe9SW9QflVT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 03:32:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v7 3/7] mbuf: record mbuf operations history
Date: Fri, 17 Oct 2025 09:32:17 +0200
Message-ID: <2943496.bcXerOTE6V@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654D7@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-4-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654D7@smartserver.smartshare.dk>
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

17/10/2025 00:29, Morten Br=C3=B8rup:
> > +	/* Calculate total allocated mbufs */
> > +	uint64_t total_allocated =3D 0;
> > +	for (enum rte_mbuf_history_op op =3D RTE_MBUF_HISTORY_OP_LIB_ALLOC;
> > +			op < RTE_MBUF_HISTORY_OP_MAX; op++)
> > +		total_allocated +=3D stats[op];
>=20
> I might be overly cautious here, but the app (or driver) might have a bug=
, and mark the mbuf with OP_APP_FREE (or OP_PMD_FREE) without actually free=
ing the mbuf back to the mempool.

Yes

> So you should only trust the mempool library (OP_LIB_FREE) to mark the mb=
uf as actually freed. I.e. start the loop at op =3D RTE_MBUF_HISTORY_OP_LIB=
_FREE.

We cannot because these statistics are about the latest state.
So if the app marks the mbuf as freed after the library,
they should be reported as non allocated.

> The app/driver should eventually call rte_mbuf_raw_free_bulk() or similar=
 to release the mbuf back to the mempool.

Because we don't know in which order the mbufs are marked
in the call stack, we must trust these free ops.

I really think there is room for improvements in the details of the marks
and their usage. I suggest we merge and play with this experimental feature,
and discuss in the next cycle how to improve the markers.


