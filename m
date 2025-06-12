Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41301C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77ABD4021F;
	Thu, 12 Jun 2025 03:53:45 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 6423A40156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 03:53:44 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9AD942540188;
 Wed, 11 Jun 2025 21:53:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 21:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749693223;
 x=1749779623; bh=fE/Sd0DNhxbHwPqBkYt4Ajhcwyk36M98YmUqTlqqePI=; b=
 mW3HRcHAgLSObF1RvShrfcWXvQwA0qBvGTz4PKP0r9ImaZvVlSf2VlDg4m9wxST3
 fmy3WxvRRaImUEDDVUUSPA1L4k4Z4kVXldtK8rd4xH6rZRHevItO7pQ2e1On+EbD
 a5rbJadAqvtOLTUepd6KSrth/2MaCF3xGcJSklL40nYuAuKmkzt4iTuOmchN43pA
 GPZxw89GJ/BWov874pZNayZ28Rd7B5jCAAEffsF9GJEM7H8mP8KlOSPXS2wpc4jz
 gbu5q3T8VB9pyx+djInD8jsFTtl+RDWtxzPFylQZOQx2QKLYLT7Y6KXW1+VMzrmo
 /Qs7KuRYpEYP6NEdWfgcPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749693223; x=
 1749779623; bh=fE/Sd0DNhxbHwPqBkYt4Ajhcwyk36M98YmUqTlqqePI=; b=m
 P1mq8qqh0UemEg6VLu5RwshzIKWKliVcpcyMIYBxQQqpsxvd2ZYP+Ve04Mto+V7m
 qifc+os8gv+yelZSAzVrmSAa/DZTJu/UGjIqE4DyLzbnwZPJh6pC0iflZcgmqxn1
 t9QuD1/p9Em8nB2049vjdzofQoIwaMcW3lCVKQmXVNES8L/xPxm2f7GZKe01YZX0
 AlfQ3Nbos7DcpajK8drHexGt/b3uUtrOO1SxQWzlwWZA1bwQLLvJYsN12v2wcy4W
 dpzl8llc3GPpwPDaki+7Y+78lI8ZlVBZhBUU4jlarUh5t3dO3uc2R3s5OObsLatk
 R1/GDhs5kw/NNNjs+CHSg==
X-ME-Sender: <xms:JjNKaBghCYQ4QYI3ExmfDTh65yVA0k_3ZJJyCJ_dth7B6jDlO46FcQ>
 <xme:JjNKaGDDtAV1F9c_rLtZwfyqRQkyxFEp1ya27buLZATIhQUMBFWLxkAQgd5aqRE4S
 08tdFj4fqZkBPOgyg>
X-ME-Received: <xmr:JjNKaBHIXylkAMyZRQGgj2hEo95wORCGHl7EcpEfoNsfD022iJyVWWuvN4RX2OzhxN6lTh6iJlq75bnOC4dnPgiWJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirg
 ifvghnfihusehtrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopeiirghihihufigrnhhgsehtrhhushhtnhgvthhitgdrtg
 homhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhr
 gh
X-ME-Proxy: <xmx:JjNKaGThFh60vBu0hpFmRynWCB1o4f2-x_yrM75kBbIEG9yZDionOw>
 <xmx:JjNKaOyTsRqQoOyKc-Ld_sDkk_wi_jrhy3IvvkPRuqth5Q3cfm2Lhg>
 <xmx:JjNKaM6f-G5solWPECi8Dys4fDrb6EC29f9UyZCuzHVhYDYiUPi4-g>
 <xmx:JjNKaDyw9AdUWPKB0zcVlbdHT-G0uETD2wYVHZiDUBePyqQ9UpOIfQ>
 <xmx:JzNKaO6eq08mWGjYh629GTbbwFlfLMlb3WU045MUQWHotG865dq2ZgvJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 21:53:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com,
 'Stephen Hemminger' <stephen@networkplumber.org>
Subject: Re: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve
 functionality
Date: Thu, 12 Jun 2025 03:53:39 +0200
Message-ID: <15768162.y0N7aAr316@thomas>
In-Reply-To: <055701dbdb3b$44eedda0$cecc98e0$@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
 <11711540.2WqB4rESCP@thomas> <055701dbdb3b$44eedda0$cecc98e0$@trustnetic.com>
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

12/06/2025 03:42, Jiawen Wu:
> From: Thomas Monjalon <thomas@monjalon.net>
> > 06/06/2025 10:01, Jiawen Wu:
> > > There were some defects in the original configuration for flow director
> > > filter. Now make the following improvements:
> > >
> > > 1) Fix incorrect parsing to ntuple filter when set the pattern likes:
> > >    flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end
> > > 2) Fix flex offset base to set item RAW relative = 1, and convert RAW
> > >    pattern string to hex bytes to match the hardware identification.
> > > 3) Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
> > >    match the rules in the inner layers.
> > > 4) Support IPv6 perfect mode.
> > > 5) Add packet type mask to match more types of packets if the pattern is
> > >    default.
> > 
> > That's a lot of various changes for a single patch.
> > Please could you split it?
> 
> I'll try to do it.
> Should I send v3 patches for the whole series? Or just these split patches.

v3 for the whole series please.


