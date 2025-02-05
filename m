Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233FC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 14:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11EF94029A;
	Wed,  5 Feb 2025 15:43:37 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 5AA5140270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 15:43:35 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id BE735138017F;
 Wed,  5 Feb 2025 09:43:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738766614;
 x=1738853014; bh=K333xvwrSan2P9F2wPFjE1uTtqjImHYYJ5H9ZzpnJSk=; b=
 Znkgyb7K1UqY14i/12+n0LRW2j/d4KXthttHNSzkYaLCecORF+Jm1315pjVHI/A8
 zfaSkRvK9AJI6UjKffc15zjsgc6z+BKhIZU0QS9b3OCS5Bm+qTvEfqOuFYsJ4+CD
 tgsWSKPrPp560xzWKRTA0kUa7U4Racp3C14a3NGuhnir4M5WuEHfZIJhoItbKHTE
 s4J0ft4W5atbqjIIUzSvsLNGI23zMk/NmfIyMxkeSZrvgOydF4J8wwMneqdF7S+t
 Xjv+5HTMh3EydFTrARfR8w7uMvOf0+7gxkfTbD/dax1YUbjjy21NCJVWu4xHFsjU
 K285s5b3UbIyHK02rkqZgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738766614; x=
 1738853014; bh=K333xvwrSan2P9F2wPFjE1uTtqjImHYYJ5H9ZzpnJSk=; b=B
 S2updhgANjrOendPFq9I8iFVYhBcAKKrDAEfqOFeQIAnI5c9CFsa5bh0A3hSuYli
 SlbtmZikercV8IAMvXCmpqLncc1FhJ5h7B+o03vjNrKsUi5lfpa1935xC1mkpDUD
 sJ+B25ZRJmoGfBxbo5F4tbMhQYVqx+Y0Wi5KnTO/e/mRek6PU0DgLZoy3+cBsxtZ
 tl0091ONCvXzRXlp+saW8SLev09V3eMWfQK20/m2w26UVPT5+Cexb1029G/ZA23M
 xZh/x2lXpSYczm9yGHMvKn4SqX8UfyHZasYuFOQ4ADjyw69T8qncQ/3/oOwIqujq
 vprrZjg57zEd1/bGYkTug==
X-ME-Sender: <xms:FnmjZ73pWjnqn-uUiBtbNzkMekYtYAOERys7IMWEER_UKUBIrEwFGg>
 <xme:FnmjZ6Fv58GCgA2JvyPMn1hE6dok93yTJl2OHQpexy3-ux-CtgNF8yIQvZuGdAO3X
 BROAds1kx-18rhIag>
X-ME-Received: <xmr:FnmjZ76Fofsjlc1a3_JbZKIqK57GV9UgWvGn-qyXZDLOK0HiFCfWxCOcHncQ-3G3zyB4A0RVQoUDauHe9_CTnE90CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
 fufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgr
 lhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrh
 hnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepfigrnhhrhieshihunhhsihhlihgtohhnrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgvrhhruhhhrdih
 ihhgihhtsegrmhgurdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkh
 hplhhumhgsvghrrdhorhhgpdhrtghpthhtohepqhhirghnrheshihunhhsihhlihgtohhn
 rdgtohhmpdhrtghpthhtohepnhgrnhgrseihuhhnshhilhhitghonhdrtghomhdprhgtph
 htthhopeiihhgrnhhggiigseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeig
 uhgufieshihunhhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepjhgrtghkhieshihunh
 hsihhlihgtohhnrdgtohhm
X-ME-Proxy: <xmx:FnmjZw0S-pVL6eKB_DCw9BFUVgygHnShdaGj3Lx1QlYOQy2Fgru_fg>
 <xmx:FnmjZ-Eh8a3vzyfBn0AsQpeEGc54IzVleOwIhOFznk3Q7wzacVE-cA>
 <xmx:FnmjZx8vbo4Dv6UT9xdXxmYkAG2GhBbqY4NK-t0H5VlhENmLHFT1JA>
 <xmx:FnmjZ7l7cWjXPhSIfOgX3AAuBLKCHtmOiGTa0DjBPpgq8q495EotUQ>
 <xmx:FnmjZ2_u11bNo225bCQBIzpw9cDczhfQiC5_eq9Oiya0_oUQKmoElqYI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 09:43:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Renyong Wan <wanry@yunsilicon.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, stephen@networkplumber.org,
 qianr@yunsilicon.com, nana@yunsilicon.com, zhangxx@yunsilicon.com,
 xudw@yunsilicon.com, jacky@yunsilicon.com, weihg@yunsilicon.com
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Date: Wed, 05 Feb 2025 15:43:30 +0100
Message-ID: <2040007.zToM8qfIzz@thomas>
In-Reply-To: <8fcb134d-3d79-447b-b673-6dae8186744a@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <1873236.BzM5BlMlMQ@thomas>
 <8fcb134d-3d79-447b-b673-6dae8186744a@yunsilicon.com>
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

05/02/2025 15:37, Renyong Wan:
> On 2025/2/5 19:44, Thomas Monjalon wrote:
> > 28/01/2025 15:46, Renyong Wan:
> >> XSC PMD is designed to support both VFIO and private kernel drivers.
> > What's the benefit of private kernel drivers?
> > Why are they private?
> 
> Hello Thomas,
> 
> Thanks for your review.
> 
> It can support the bifurcation model without unbinding the kernel 
> driver, by utilizing our private kernel driver in conjunction with 
> rdma-core. Currently, our kernel driver is not open-source, so it is 
> considered a private kernel driver. This patch series only supports the 
> VFIO driver. Our kernel driver is currently in the process of being 
> open-sourced on kernel.org, and once it is available there, we also plan 
> to submit the code that supports our kernel driver to DPDK.

OK that's interesting, thank you.

I think it would be the first DPDK driver to support both VFIO or bifurcated model.
How will we choose which one to use? With devargs?


