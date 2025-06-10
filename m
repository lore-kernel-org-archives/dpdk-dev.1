Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08156C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 09:39:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBEF742E62;
	Tue, 10 Jun 2025 11:39:44 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 00FAA42E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 11:39:42 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 5659E1140131;
 Tue, 10 Jun 2025 05:39:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 05:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749548382;
 x=1749634782; bh=4P/J0zyT3RyJOJ+lKOkNwfQNtbB39nSRPSMiO1bgeiA=; b=
 SUVvQwcg0IQjOoI/dVnp+OGep7NKX2K4VH0qD8uohjeAx43zXsBXvLP024agRYQl
 R7ChGIGwNU5FYvSIArsJSjaaEkxxsXKB8phqcwDE5zMkYPU3c9JV2OhPW+3HOkHj
 49XGXRRD3POyc9qeTom0rr4Dprh4C1Q1ZUya1bwOocBO717fCml0Zzm0Aj83FMDp
 d5nz265TTGGHQpFYEjEeW5hK/aLGO30CbvagnciX5tZXAYlTloPWA9zmvMwCzsxc
 ZkTiBgEu6en3LAaTjfO24erYJ1JqbpNowujr16xpm77sKp0RRyfk09VsCEZQP+9B
 V2BlPkod+HFVZuQcTw7KKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749548382; x=
 1749634782; bh=4P/J0zyT3RyJOJ+lKOkNwfQNtbB39nSRPSMiO1bgeiA=; b=j
 8AA3OJTWCCH5RPP5BQsv0YzFLMkJSvAeWYwLU7AKFTf+5z6dAVs4eVwa4p5fG+VZ
 Tshc5RJD9wmUoq+VHGw2n3+pp2EJNwTfjlFGnqQ/s5NBOtroKC/mw6KzE7svwvli
 ODI7T5zODsKk7/MDnte/dqNfFSG7/W5A0gh5s60uR2k5gyWW8xsHQQVsp3vkEPd9
 fpRo0dm+RXxouqWLPbA4v8Kf4oQMuAuBPUOxm+tIGJUa5rcarh4aMnb0WPw/eR5C
 GGo9aPonF4QUFLKrxEqHTez/KdAnglyXE9B3sa5hgULaX8+oTx0Oa8pDKBg1qe4+
 gS3rGkpRtWIqsIg3uoTsg==
X-ME-Sender: <xms:Xf1HaKbHvjj1Su1xQkkAi0cgU6z2hXSEOrrtCFxvOsQJbK2NiIhuWw>
 <xme:Xf1HaNZBmNk1em9RAkTbY6wJc1jzMWKDY32oQE3ZrS0ZgipdQY2OtW8ThkriA_c3A
 7PUsRt4DZ-bh6yiKQ>
X-ME-Received: <xmr:Xf1HaE-koq0NtUGaNBCLc5yuCKpXVxg6l7NbTW3-hnwMzA3_t6U2ZAX4rHkdZDZF4Nax9bNUewDxW-bR_ioUZinqYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdehjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhm
X-ME-Proxy: <xmx:Xf1HaMpblk0RgadRCSry6QxMfbmzV8UN1DOyWVW2oYlfDoZXmhgnhQ>
 <xmx:Xf1HaFpV-CX2B4UYCiIMdWiPGvF3p737N5yrY1KDEbVtpJmfFABLnA>
 <xmx:Xf1HaKTPSYP6JHhuSgGh8Ox2RVt3LPVCr5x1vnQfufALizsm-nVZXQ>
 <xmx:Xf1HaFpSyExP6tXmBGzQI_3AvAEAMJtLORiAR-byc4z-mjh9GDC08w>
 <xmx:Xv1HaP7zPvJRQlXUKnnPJGlG37w4DcouxF4stdcNIreMqInDU7qpDKYq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 05:39:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 0/4] more unnecessary function pointer
Date: Tue, 10 Jun 2025 11:39:39 +0200
Message-ID: <15047382.VsHLxoZxqI@thomas>
In-Reply-To: <Z9BfD7I1kjvYa_en@bricha3-mobl1.ger.corp.intel.com>
References: <20250311155300.13410-1-stephen@networkplumber.org>
 <Z9BfD7I1kjvYa_en@bricha3-mobl1.ger.corp.intel.com>
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

11/03/2025 17:04, Bruce Richardson:
> On Tue, Mar 11, 2025 at 08:51:28AM -0700, Stephen Hemminger wrote:
> > A few more cases where there is unnecessary deref (*) on
> > function pointers.
> > 
> > Stephen Hemminger (4):
> >   raw/ifpga: remove unnecessary deref of function pointers
> >   crypto/ionic: remove unnecessary deref of function pointer
> >   regexdev: another unnecessary deref of function pointers
> >   vhost: remove unnecessary deref of function pointers
> >
> Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



