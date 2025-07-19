Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B8C83F3B
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 00:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9CAA402BB;
	Sat, 19 Jul 2025 02:21:27 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id B8664402B5
 for <dev@dpdk.org>; Sat, 19 Jul 2025 02:21:25 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CFA4C7A00A6;
 Fri, 18 Jul 2025 20:21:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 18 Jul 2025 20:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752884484;
 x=1752970884; bh=4jTqcLkRdL3qSVOzOrptWizGRRcgYVrKl8my4Brty9k=; b=
 XO+ZxUOme9AyIvtKlbnKUt38vuQE8oNAecxAOmB+xMFLMaFvBFrJQ2yMO19T4M1Z
 8U1LoChIAtgRyf3++qzzC2p5ji4D8q4JVU1KIyZ4CcWb8aPJJNvYUVL4wMqfpWdm
 ed5BwlPk9lc6OpDwuV4iKyADj5KCq2lfoFOr39tMnmCTUFwbWdsr/ipZKsZse9LP
 bPvBz5/GiabQTfUzb+lDsSmJz/El9ggr3s3TUFw7b34MjE5pyQL2/M+V4GrIMn7x
 HhbOnGNNhptmfAZ2gTMSFjmnKvh8xEoYcPOjR/yAKOxwDMF2z8+tTWbTvGSR9nOY
 Aym0NqrV+aw1L9c3pm5URw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752884484; x=
 1752970884; bh=4jTqcLkRdL3qSVOzOrptWizGRRcgYVrKl8my4Brty9k=; b=M
 I25YSG6lz4L1bfGxpmpjI/4sLh2m7mCLPF0lCCDsNC/5HGxCptkJB6G4ztJdV1Qo
 GUybKreUkqXd5CSUxIN9RF/PP4zbpJ7MnJNbCstos9Uq0pIFDPLKAg/3p+o8icgO
 A0XWbLarFqSL78BKLdP00wnfDpdhm9EGwBdeLgk6sr02hkzcp/BGsyKd9/zRRnet
 tbgp0cg6quJs5L6t5KvLIE/GXKeFAaDOU71BLZTInabt6TCIU7UE3MoyRdoTdb9h
 iIkmb0MSebmzAmrMxT2BrRqMxu77ICld53AX3xlTAblpJzupMS/LkPyF3Z0gdk54
 gvP8BIfuNuSMo+runjPvw==
X-ME-Sender: <xms:BOV6aKpSUjMtSPWTBcFt3kGxBcR2il060fr5j7XcR5Js3SiXt1NNqA>
 <xme:BOV6aN73CID9Xo4CRBvZ08wN8GcZmmW2mKfVFKKaq-IB43hEQKAWrkesE_lF6GqY4
 RQZCBrrWyN8GH5XZQ>
X-ME-Received: <xmr:BOV6aA6dvm82PX7Am5MF74o1ZNeg9lmwhLsDeXTYM7cfbgCpS48G6FKS9KRDDQ13dsyvCrKVbL6zTKSA91fUYks7MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeekkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:BOV6aCFpdPZdsYI-m2qyf5Gu06ZlwGw4h7Vc8HOZnuKOSpept0MciQ>
 <xmx:BOV6aBSySja06knaJuKXZEBNq-NNLcVsKZFjzlW5u7ArT8OQ-9rB_w>
 <xmx:BOV6aDtIAqZ47eicpWWm6IOvakVnb1WPiJHXtL7V2Lk9Pm2ha8okSA>
 <xmx:BOV6aIyu2RkoyMSlRZsZMXbKXH7R3mj3e8J3zTNZDLiLIE2vtLD0Uw>
 <xmx:BOV6aLG7K71ISDtW420C3Dhc9oBU5cHRIUcMk4LM0tqTwZVltCDlWhlw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 20:21:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] rework mlx5 guide
Date: Sat, 19 Jul 2025 02:21:21 +0200
Message-ID: <22771069.EfDdHjke4D@thomas>
In-Reply-To: <20250718083648.57333c97@hermes.local>
References: <20250717220912.376503-1-thomas@monjalon.net>
 <20250718083648.57333c97@hermes.local>
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

18/07/2025 17:36, Stephen Hemminger:
> Looks better, it would be good to look at the table of contents
> (right column in html) to see if could be better in complex document
> like this.

Yes I've paid attention to the table of contents.
Thanks for the suggestions below.

> For example the Usage, dump flows, VF trusterd, etc all seem like
> FAQ kind of answers and could go under one heading.

I did not really change this part,
but you're right, I should add a common heading for those "usage" topics.

> The section about statistics should also get headers reset
> to the right level. The part about phy_ counters might be better
> in limitations section.

I didn't touch statistics.
This section is clearly not complete and should be updated later.

> The Limitations should probably be at
> a different section level, not stuck after live migration.

You are probably talking about the multiprocess section.

> It would be good to explain a little more about "forked secondary
> process". I think this is a general thing across all of DPDK
> not MLX5 specific. Should this go in EAL?

Yes, and there are things which could go in ethdev doc as well.
The goal of this series is to have a good skeleton to work with.
Some content could be moved outside and referenced with a link
in future patches.

> The part about Rx/Tx tuning and Rx burst function might be better
> together.

Right, I'll move.


