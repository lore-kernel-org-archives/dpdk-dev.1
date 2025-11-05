Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDABCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 10:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73386402C4;
	Wed,  5 Nov 2025 11:06:53 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 2554B400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 11:06:52 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8ED7B1400250;
 Wed,  5 Nov 2025 05:06:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762337211;
 x=1762423611; bh=2/Jo7MvdMhg9SDO3zOn+BEhAjboNNV0UtM6pdtGrHok=; b=
 Mw2CrHU4n0Tv4mXJaXYSJIYe0wmgvPSLYXYztdLRyQRNRabOPfWcjiICqc/x4Lj5
 Kc28oZ6cjhEzvTKimt1Z4oVUj0lxrCeLGk+y3NBE6viacFufF+LFgb0WRJigleQY
 aasVz5mxOR5zTAXKt3o0KAvOeTvReED97TN0BptSotrZzynqMqCohKSzHaH9cVyd
 cgKS96/rvCBWqQfYSQnNyWPV3le0m4jEOrIaOC2MbB56Lpm0RseBp5dmglQczJSk
 kjgnWv2DIGgRtAaFTnNoK/tnjWh0p+37ULF8lk2YWXzFfDtT7O13GHnzVYspqMZ+
 LDlAUZbhAwoDcuC6APKz6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762337211; x=
 1762423611; bh=2/Jo7MvdMhg9SDO3zOn+BEhAjboNNV0UtM6pdtGrHok=; b=n
 ssdNFs0uEAhbzzfKnT/pcdWc5Zd4wI67lusRRKFz4dtsz9vYMogwF0NFn2Hlc7Bi
 7+yVHl1hqUMcujVbhjtECg2LbvpxQ4FkhIFDMslGIvAQeeRickab1OsxHSlhcsuC
 KLRFyI7HGmJSTwrPbfiskCVb3+08cGtbGGaNh9uqNfe2+7niIaRHK9C+DiiouC/p
 ytfj+66dsyFHI0DPm9TxTy1Kpdt/XG4NajSNgp/YFYpZ/8aduHDDPL9oNGwWTTcv
 uPEw8vL7HrHZ5PXCqnhayOPYnJZfrhEQL/lzgby0C1Xq8ObLYmEpKSuZp0Q7iN92
 a4z4NF9u5gcOL9vh5eZlQ==
X-ME-Sender: <xms:uiELaUyvvhMC0iaQkMvLb7aczECOrPxHKRn-n-uBSHWqVPtbM7vcoQ>
 <xme:uiELacnWVtn31JH0UQ6KysRS9OEeJWkQpzXA1EGu3STko4QDgjj6z64O45VIS4h6b
 7kBIT003n7OuTgge333y-dGJb9OAL56NfceEHYSpi9GLj4ou5dGrQ>
X-ME-Received: <xmr:uiELaVe80rmkMJdVa7kl26I_674I8CEF7TDvP5ZjFpJZR-rUq0-HYtR0YuM13CWB1nPZlWibN-Nq8c9XQPAycg64Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeefiedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 vhgrthhtuhhnuhhruhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgt
 ohhm
X-ME-Proxy: <xmx:uiELaapS9jcibUQSmK6a7aolOY5zyGD79M0d6_l1DfA6vEo7UvKnXA>
 <xmx:uiELab72W_fwRE9TbQNZYUYHGYiLaHZsgJCTPX2FYGIwhqr2qCgFuA>
 <xmx:uiELaYpGyRXrLcDkKllxHTlCwbtZwTmZ9ETEt56Vn5ZTbVsLCB6gJA>
 <xmx:uiELaViArDmHVpiibKfkV77e_o_eHLSIjWEaIRzK80vjeGEycF4vWw>
 <xmx:uyELadTBsXlUfVjQP9WPfx_wzTPm228fqrsduo0nILlxH9BH5CDsH3WV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 05:06:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 1/1] dmadev: add domain_id field to access group join
 API
Date: Wed, 05 Nov 2025 11:06:48 +0100
Message-ID: <2511688.Bm8zEkEi59@thomas>
In-Reply-To: <793529f0-959b-4d72-a4de-5b06497a7c5e@huawei.com>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
 <20251104052146.2308361-1-vattunuru@marvell.com>
 <793529f0-959b-4d72-a4de-5b06497a7c5e@huawei.com>
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

> > Add domain_id field to access group join API, which is required
> > to retrieve handler information associated with the specified domain.
> > This enhancement ensures that domain-specific context is available
> > during group join operations, improving flexibility and traceability
> > in multi-domain environments.
> > 
> > Patch aligns the parameters of access group create and join APIs
> > for consistency and clarity, also updates the dmadev.rst file with
> > detailed steps.
> > 
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



