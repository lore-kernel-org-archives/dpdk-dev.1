Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E7C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84E9A4026B;
	Fri, 27 Jun 2025 12:36:52 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 28CDD4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:36:51 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 835201D0012E;
 Fri, 27 Jun 2025 06:36:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 27 Jun 2025 06:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751020610;
 x=1751107010; bh=2sKuWPAVd/buq0ZHb43UDGYCc/ebBi3M1lhNePc3j1w=; b=
 grMwwAlDk0B+kRwXPDUNk0bNuvbbVmJYc36c0iP89SxZxzrriKS7Y/7OqZiPq+NM
 oIgmqPgLTF15A3GwcAhQEo2xcU2MC6n1izk9Hf2ewTQ1ZVWlU9sStA6UqKNT6UxZ
 jtssy9EVrCoTu61NzWrjM9UnTLNezKtvvXfsUFe2thItxVDVG914Q5SQCojHZAws
 4h41df8Z2u+997jQjfVb3GYvAqA7MZIZgR6q5Jes90KdqnmubG+t7Gm5mX14CaPp
 gZpK2KRF05/6vE2E/bZGkTZ4wbExDyz4e8onyLWxHRpUZyb1Qyk+stvAtlV7lCiz
 AZwFmbRxzWi62IA4m/znuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751020610; x=
 1751107010; bh=2sKuWPAVd/buq0ZHb43UDGYCc/ebBi3M1lhNePc3j1w=; b=R
 KHL47Wanb8JbHMdWcNETVKg0MxjVUPos8QzZQVXRC2CZvVcjMZrYbIrT0zdn8uU6
 c1b6+1OpYIqZ1sZXNoiYTfwF1ddbaCbrU85C6BGm9NAZdSUCzlA0OgOl/CW2zL4V
 erh7a30kdgasA+rGTgxYnhpzmvM3YyvNsBcYQEuHaIcq9j5+3K6dEFHk6ptCsndL
 rkjHNLAP8mbkshXI2do3p4blpQLXcesfzSQqijVSoH72NDBJvQetSQqePp7SwooB
 O0YFMKkf4jINHYqyFfNP+fgsp8G12uqCw/v2ltOLYCvCaMlrSyMmrqbO+ANLigsw
 HEdblWyS/wYkFED3q9sSg==
X-ME-Sender: <xms:QXReaE1qyy0n_K9w0gqxte77fd35Bpea1I_5oyEL1mHM_vBn1hv2tw>
 <xme:QXReaPGMD05k2pt6s5qvRT2NzTxb9I0BGXrmxQp6Knt_BIo0JP2UmBs3qDNPMlZup
 G10p7P--RNd1VcMJA>
X-ME-Received: <xmr:QXReaM7gyxhOVmYlPJp43hPNNN09PYax_v4Q_A-NxeankR334eiZHBHk76HjRsYB3RukcsRRgw2k0wBfjcEjolSHxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeeuffevtefftdeutdefhffftdduveetffekgeelfeelgffhheejieettdev
 jeejveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuh
 grfigvihdrtghomh
X-ME-Proxy: <xmx:QXReaN03k-HhbL6Oexcv-9Eu1Oz4i5njSJV5XPtEbO6gOy8eFiHBwA>
 <xmx:QXReaHEb37HnY_AfKyP8XbrmRlcDSeVdsGbM_ZHWHtEuK96yfT3Qpw>
 <xmx:QXReaG_RuPlWLPDO1gHU2kkOM-K7ThJ6H9n-SGvDyyytRGzI1WyUJg>
 <xmx:QXReaMl3zCbn0rLXhZjT5VdoR4bwI4oKn3FroJLBukZXSHUyU1Vl_g>
 <xmx:QnReaASDZdjeloO5BYeItS16cX2f5wqE_n8HZye8lJJ9EBkBwC0C0LrM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:36:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH 0/3] argparse: improve handling of multi-instance args
Date: Fri, 27 Jun 2025 12:36:47 +0200
Message-ID: <4354101.7YbXXFKy9f@thomas>
In-Reply-To: <aF5qECJgWupF4Er7@bricha3-mobl1.ger.corp.intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
 <aFUfX05kEUNz5k2S@bricha3-mobl1.ger.corp.intel.com>
 <aF5qECJgWupF4Er7@bricha3-mobl1.ger.corp.intel.com>
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

27/06/2025 11:53, Bruce Richardson:
> On Fri, Jun 20, 2025 at 09:44:15AM +0100, Bruce Richardson wrote:
> > On Mon, Jun 16, 2025 at 11:49:40AM +0100, Bruce Richardson wrote:
> > > Coverity (correctly) identified an issue[1] where, after the recent
> > > rework[2], the internal flag, used by argparse to track what arguments
> > > were previously encountered or not, was out of range for the type and no
> > > longer having any effect. Fixing this flag to be back into range then,
> > > somewhat surprisingly, caused a number of unit test failures to occur.
> > > 
> > > The reason for these failures is that the tracking of args encountered
> > > is done via setting an internal flag on the user-passed arguments
> > > object. In the unit tests, this caused issues where the flags field was
> > > not getting properly reset between calls to the parse operation. [This
> > > is only an issue after the rework, because previously information like
> > > param type and optionality was encoded in the flags, so they were more
> > > often reset during testing].
> > > 
> > > Rather than fixing the tests directly to always reset the flags, which
> > > is simply working around the issue IMHO, this patchset instead fixes the
> > > issue in a more user-friendly way by changing the library to never
> > > modify the user-passed structure - making it completely safe to reuse
> > > across multiple calls. This is done in the first two patches.
> > > 
> > > The final, third patch, adds an additional unit test to check that the
> > > tracking of flags being seen or not, and the handling of the
> > > "RTE_ARGPARSE_FLAG_SUPPORT_MULTI" flag is correct. This closes a gap in
> > > testing, since the original issue of the flag being out-of-range should
> > > have been caught in testing, rather than having to rely on coverity.
> > > 
> > > [1] Coverity Issue: 470190
> > > [2] https://github.com/DPDK/dpdk/commit/04acc21beeeb78477b15a3f497d3628fd70a6a9f
> > > 
> > > Bruce Richardson (3):
> > >   argparse: track parsed arguments internally
> > >   argparse: mark parameter struct as const
> > >   test/argparse: add test for repeated arguments
> > > 
> > Hi Chengwen,
> > 
> > ping for review. I think this bug should be fixed for RC2.
> > 
> 
> Second ping! This patchset (indirectly) fixes an issue in the library, so
> should be included in the release. Can you please review?

No more time to wait for review, sorry.
Applied for -rc2.



