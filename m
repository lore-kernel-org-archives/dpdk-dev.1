Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C892B40B9E;
	Wed,  5 Nov 2025 22:59:17 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 06C5D402E6;
 Wed,  5 Nov 2025 22:59:15 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 51A8DEC018D;
 Wed,  5 Nov 2025 16:59:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762379955;
 x=1762466355; bh=wmetYS5DQ6gcKZbW085+cr4PCClU3mfAaO1I3cAhQ0M=; b=
 cV4+mpqNtSq4kCzgLmmcAmKX4OP6IimQGTdji2CDVgJB9e6PPCOlXK0HRx4ovuyp
 8sabiu1/7G/DxhnfndkQ6D+iUXLqnMo5+ocnBMM5HRpK8hKeZDXIH2vs01cw8Vpm
 dDR3sbhkOyPFZhyfds+up5brbNFgQqplpoAbszgXpcBobZN8xdRT6+ES2RPs+dyW
 l5LrxEdlZ+DUAw7um4C27Yykzmwb1Tpj5TWwXlfQSNweW79astZ2sdCGe3CcffVh
 EC8CkkXh1jD33VFm0VbVdrnWKlzAB8oD6SdEReLR75buEfbpTh7RAYQMarstN5nH
 pESGXx7SqBwT4GkYDcUQIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762379955; x=
 1762466355; bh=wmetYS5DQ6gcKZbW085+cr4PCClU3mfAaO1I3cAhQ0M=; b=r
 fY9EsUUIBwHHua18JcJFfd7x9bEevMdHGEctGGNh21Omcx7ucsvDuSYGWVOF3bj5
 63g7nUfnGSZZo/FRor4yD/YQSc5r4cTGathVbSNDI5+AXZkszLPsv1mF6ZA3w/91
 BSf/eGECKKvXTjnA0D+pqVzrdxvdyY7IqpL0qxSxoQ1cGQjMXDLGJW/7JjbBOdOd
 UO80E8JfPq84aAwo25FlR0t1AehdfZLap0V/zs4HVuUogvQLkWTGkANN8BwG80kd
 GpuRBlWhjzJASjeN0Yjd8frHqUwB3oAXN3NugK2FWCpYQQUqrCckowFqs7KFL5L5
 QC0Fiik10xCQhKEby98og==
X-ME-Sender: <xms:ssgLadBbFX3PJ5rjxgBnYuNyGhJsSwbuYTRlKjgXy_bFkOCi80Pvzw>
 <xme:ssgLaT9SGL_HnRA2oQ-eTN9eIA9by_sgaCWDj1NDuktqkdK5Jh-RReSv1q7MJyPBi
 mg1r9dv7bbtoVWBDjyauMMXFp1D0cHT3zNwLXyqGxvB0N-kP31Fmw>
X-ME-Received: <xmr:ssgLaZAOQY_LtdMKHL72V6ErSlX7Sglitow0wkBgDMHctdEb-vbqzsKLd5WDPH56bBSqBBWM0ie8AQ13TjFWRYjVwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehtdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmh
 hitghrohhsohhfthdrtghomhdprhgtphhtthhopegrlhhirghlnhhusehnvhhiughirgdr
 tghomh
X-ME-Proxy: <xmx:ssgLaYRi_iTL3ZI5Y0s4TUDmVM9EzcQ7oUTeDEW1xdadau6NsaRUyA>
 <xmx:ssgLaQupsiVEFKHg-dXaj774FFwHQnTtj7S8_hg54oFaEuap-kB7Lg>
 <xmx:ssgLaU1SHv8lpLNO_1s1gD_INtDFtmCBaYYvceWhDe5Oe3AmPPU3cw>
 <xmx:ssgLaRU9pIFr_seS7HM_jeavxnKiW2y_D48LpIHELrC-0Aavy2uUrw>
 <xmx:s8gLafKQ8WiJedWUDGyCXS_cosG_5rtDtw80dMWm45GfJe1REHNTB6rk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:59:13 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Andre Muezerie <andremue@linux.microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>
Subject: Re: [PATCH] docs: fix Nvidia bifurcated driver presentation link
Date: Wed, 05 Nov 2025 22:59:12 +0100
Message-ID: <3041567.aKNjEaI27c@thomas>
In-Reply-To: <20250929113110.50545-1-ktraynor@redhat.com>
References: <20250929113110.50545-1-ktraynor@redhat.com>
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

29/09/2025 13:31, Kevin Traynor:
> Fix link for Nvidia bifurcated DPDK PMD presentation.
> 
> Bugzilla ID: 1793
> Fixes: d052a9a7d5f9 ("doc: fix link about bifurcated model in Linux guide")
> Cc: stable@dpdk.org
> 
> Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Applied, thanks.


