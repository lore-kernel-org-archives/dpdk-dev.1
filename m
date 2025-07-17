Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF38DC83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 19:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9F1340395;
	Thu, 17 Jul 2025 21:50:12 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 4826140283;
 Thu, 17 Jul 2025 21:50:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 6A2511D00123;
 Thu, 17 Jul 2025 15:50:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 15:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752781810;
 x=1752868210; bh=BT64H3uXxsWkYA0A1MfbgGFU/i31B+/HzukQYSaH0Kg=; b=
 uNtMsuKdlQnVWRVu/ZfcmlipvxXcVrnHpQzht9+jV7sNgzfSY28Jf3/rTeiI2Oj5
 yuHlHrbD4THuITUiCmIzxJYLhuz/o6ckC9cEfHiNn6Rmu5Ap+gVDRGqLCn1pYzw3
 UmJYMDWAqxE0WbP5VHdw577aykA4ct1eeKWQqt4IuBvcUB1yGd6xkzn/ekUP9Wkj
 331W8JpqrH4QUHpwwFtskMwTJiC0F35nnak60TB30+XolOJl5/C0/1cgDVFkHHNs
 cSIgMpeUmdDAr96FrQ96pWp59DBmfxYraZdA4EjN4CxB/pd5KPT8dkL2VEbsqTay
 Vk+eYczRZwyJ6Zsg3eiwvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752781810; x=
 1752868210; bh=BT64H3uXxsWkYA0A1MfbgGFU/i31B+/HzukQYSaH0Kg=; b=U
 yUDAWeKZijY+TkXP0S5AogJHNru6NUq64pMZTv1Wo2iUPikopoDfG2UIOBLtr0Ll
 KL3hMbJJp6+RZw9M/1U+0y5mHS4Hhg/xGg8Ns5E+sQFYqtRKJSK5glj0u/IVCLTB
 rHb/vFT/7jehRCI6uBP6D9hu/z0+AcX/vQLeJUI2JYsgx/Rx7JfjrUF4Zv4fwh3r
 BsgoGbs+BSBsrAyB2RQ0y8HcV7P9ejPWGjbwX5b1qXmc76vs1HHLdFk36ssPag/x
 8AP/bYm1YHvuLJAMrI1K/t5IEBIXNj2qEp7l2/1wzN29uSTWdIUh6fP4evU+/FIX
 M3KFAFEzhjv0DXJs5SWYQ==
X-ME-Sender: <xms:8VN5aCb01GmJM77O9xYEer8_FjMk-AIsXZZgiURamVQr4oQ-AROsoQ>
 <xme:8VN5aJFZf2GOkGG_stiLmEEhj1VDbhLN3xCWviSykp8bm3pjGpGeAdkC5gswxx8f6
 HKqwprAeRgI3nuzww>
X-ME-Received: <xmr:8VN5aGzDIIZ0yl-vfjZYjr7dxkKNDw-rqz6lXpGuv-jV5m4PWEgAEJiUslufl9j0a82gBr2QR11gHcJ7IkLDd6c8Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtgho
 mhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehrrghslhgrnh
 gusehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
 pdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:8lN5aLmsAz9OgDatiuJ98JJPggcmc_HWE6PhpKqFYMOd8-UWZsOIDA>
 <xmx:8lN5aPmPwDC2sdLoybX5aSyiRpfZEjw_GaHerJb7iwDjVZkVkJKASQ>
 <xmx:8lN5aNwhE_rOtz0_k4c58Q5fB78iQzlHP8VjyTRDBosI08ZthLxBFw>
 <xmx:8lN5aEqJabd3HsMpCdqkZdURqcVYPT9lOD6Dc2TnDIEUGiq-k8g-oA>
 <xmx:8lN5aL4wg5GhmUflo7Ga9WzPT97z-Zu12_EnzE8Zg9KfeFx6Q0xRGBeI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 15:50:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org, rasland@nvidia.com,
 stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] examples/multi_process: fix cleanup on exit
Date: Thu, 17 Jul 2025 21:50:06 +0200
Message-ID: <2233504.irdbgypaU6@thomas>
In-Reply-To: <20250709080104.62fb27dc@hermes.local>
References: <20250708070954.165222-1-mkashani@nvidia.com>
 <20250709080104.62fb27dc@hermes.local>
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

09/07/2025 17:01, Stephen Hemminger:
> On Tue, 8 Jul 2025 10:09:54 +0300
> Maayan Kashani <mkashani@nvidia.com> wrote:
> 
> > +static void
> > +exit_cleanup(void)
> > +{
> > +	unsigned int i;
> > +
> > +	RTE_LOG(INFO, APP, "Close ports.\n");
> > +	for (i = 0; i < num_ports; i++) {
> > +		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> > +			if (rte_eth_dev_stop(ports[i]))
> > +				rte_exit(EXIT_FAILURE, "Error stopping ports\n");
> > +			if (rte_eth_dev_close(ports[i]))
> > +				rte_exit(EXIT_FAILURE, "Error closing ports\n");
> > +		}
> > +	}
> 
> Could the ethdev cleanup be integrated into eal_cleanup() so applications
> don't have to care?

It would be a layer violation.
We could have a list of callbacks maybe.


