Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF93F55804
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:06:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43204028D;
	Mon, 20 Apr 2026 12:06:25 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id F275D40278;
 Mon, 20 Apr 2026 12:06:23 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2E9CF7A0087;
 Mon, 20 Apr 2026 06:06:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 06:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776679582;
 x=1776765982; bh=lbzwVNQ/34MuXUBbD8TbZgl9PWVVVjOS6iCp701an1s=; b=
 hoOmriecsTaQoGcFa5xAm/ZA9ISCvz1tvlctZ9YmvdUujea+W1OGJad2+QtK6HSz
 lDFdGAT/lCS0ZPtkEkg2HUJJLSp6UmYxCxUzsT3fgP53kOw1y651uKbOpofoaXEQ
 o1jtN04zdk3Va6RcwgxWcBZgmx6q/TRRF7t1NiPi3UypxbVnWNMuHmnAwPHBL+Os
 ggqvDUaHl7f8TDaaPWeYosZLXZn4F942XEMOHAfwHlPdJEKtNvfJFAIIBOVNf6/K
 2qqXYSB9UcdZ2HNlgRwZzq2nyeWHvD+KHHIOlAaXrXWkXg98ZDb6Og+JPeDE285C
 ANfPXPh7c6S+RnV18I+00w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776679582; x=
 1776765982; bh=lbzwVNQ/34MuXUBbD8TbZgl9PWVVVjOS6iCp701an1s=; b=k
 M2v9Ah2tdq/Yd/6WjHnJ/7Neuoo4GuguruXVOc0/cJVBdoNGMJoao01H5/HGmOdz
 dsyVDL09EE//XnWVHDhf10ik7CYdEOrS7TQM8cw4lw+oZuUCXFQGjU7eIkOzE9EG
 broQ1eGPlFGLeNhpBxv8PdX5pXTAJj6XLZmzrAAMMiY3atrmbYbkAoK28kw/dW0Y
 UxtY79lTcsXDtWMzVtgZcPBud6I4DFKAYSzcI5sxY2zU4JdoYWpGyy9fi/U4PEhY
 1eBfj/bCoyb6lSC7GBqWx2tdbDXxCjJoAI/R0jg3Llg2Ly9gRkvqTNxUubItfn7e
 YOk4/iX353rcxCyuyaUXw==
X-ME-Sender: <xms:nvrlaWf2xvvQtvlCjjQFGtKbmPP3MrpB-aaeUl46MODF-6vSdggK1w>
 <xme:nvrlaQX1nHgxGW32jFGPM-Hmxtj_woXj4qWVrOTIGfnB2DtSKnVgqNklQG-BnF02_
 xPH2TtZEE0BlTmDOT_AMm3Zvvf8zVzMfT1EqNGiQ_g0CZaN9Q-_ZQ>
X-ME-Received: <xmr:nvrlaffaZQN8mzBjhpOy4uL5POSsILP-aZIXQbOIdZsNac60WADQHLNa5Tcc9TrFlw15IJbyW_zd9ZEMwEEDb1_qnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedvgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesug
 hpughkrdhorhhg
X-ME-Proxy: <xmx:nvrlacPl-mWuL1Z-7Nrle-Pbx8ubPLr7S2ChndVIkiarojsJBfS4Qw>
 <xmx:nvrladgT7y3f7nVSQo4oEK5y-n9pEs0giwuEG28lz5ZTo6Q9QaNTEg>
 <xmx:nvrlaf2Q385zqzR_uBidcQ9C3poPgvr2rkotZVflK0EjrsT2IA05hg>
 <xmx:nvrlaXg_8a2aOSj4I8Ey6qI7hqY5pX_FFcUWHKoka-4iRyx5-jN9gg>
 <xmx:nvrlaUJU2z_a0iAmB5osigmK4EDdVC4CG6WObkDlKofjFgeAtlif9O4f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 06:06:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org
Subject: Re: [PATCH] mbuf: fix mbuf operations history recording
Date: Mon, 20 Apr 2026 12:06:20 +0200
Message-ID: <23075230.EfDdHjke4D@thomas>
In-Reply-To: <20260419221220.86455-1-mb@smartsharesystems.com>
References: <20260419221220.86455-1-mb@smartsharesystems.com>
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

20/04/2026 00:12, Morten Br=C3=B8rup:
> This addresses two bugs in mbuf operations history recording.
>=20
> 1. With mbuf operations history recording enabled, when allocating mbufs
> from a mempool failed, the array of fetched mbuf pointers was not set, but
> it was dereferenced for mbuf operations history recording anyway, which
> would trigger a segmentation fault or cause undefined behavior.
>=20
> This was fixed by changing how the return value from the mempool
> allocation is checked, so the function returns early on failure, and only
> proceeds on success.
>=20
> 2. When allocating a bulk of mbufs using rte_pktmbuf_alloc_bulk(), two
> mbuf library allocation operations were recorded on the mbuf, because the
> function calls rte_mbuf_raw_alloc_bulk() for allocation, and both
> functions record a mbuf library allocation operation.
>=20
> This was fixed by not recording a mbuf library allocation operation in
> rte_pktmbuf_alloc_bulk().
>=20
> Fixes: d265a24a32a4 ("mbuf: record mbuf operations history")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
[...]

It would be better to make an explicit comparison !=3D 0 below:

> +	if (unlikely(rc))
> +		return rc;

Thank you for the fixes.

Acked-by: Thomas Monjalon <thomas@monjalon.net>





