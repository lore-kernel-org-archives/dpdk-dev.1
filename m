Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42BFF60FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 259BE4042F;
	Tue, 31 Mar 2026 13:00:53 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 1D0B84026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 13:00:51 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 73779140027E;
 Tue, 31 Mar 2026 07:00:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 07:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774954850;
 x=1775041250; bh=Hrc826yc7PFckzCgc5PpLd9LAIo92qS2yrpoaNPySjM=; b=
 oCy+3ksfq1wnTrA+3zAbmon2Bz8bpk8A4m9XsVKOF6dSN4Sff1IBK0f7CQPTHK31
 a5Gu2X3a13ogBeVdXW4dg3KpEe9Ceg4j2CWLIhviooKJah6Hbb3vAyu2UGSdz3KS
 khQu/OjRju6tt4VDga9YYFWu5YE4ivR672VjipMZaKfsAMqx1HqbmeVVwbsakQMR
 7+wTePY9K5imehmehmtw9fTtNqETInhx2uUrdptUjDEtmaQyaazWFaCqo2ATZDR/
 oWnrvfKaIat5NkyOHhj3ocqzPUpB24Agt2jP9UfvkXOaBBYVYBPOElOfGOXIBWBk
 584VqzvsI6T3aoPJbhwpAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774954850; x=
 1775041250; bh=Hrc826yc7PFckzCgc5PpLd9LAIo92qS2yrpoaNPySjM=; b=H
 AIaiS3t7GUB55E34r+eA4raV0n8Ci+e3nFQy1BSva9U6yjbATznyjF5XUVlqUWGI
 IYW5BMF4yjMVKho0xv7hIrw9nIUqyDI3Zz4+ngTevjpxrydpsDk0kWw0xzEXoCAv
 mIGEd2ISYMreapcnIriQLc0Jp6toD6DjKoEkT0CWWTsz+uA5t7R3OMZvM2EhBwbR
 lEmmdU5u3/Fr169WeuLyfa4BmZRekvLjCWt0f+OP1/8Mt6Lba4Kp39d+VSACnvAw
 58eknFZG82EdhhweVjPCMUXUTtkXP2APWq2qJxD/TA0bwMOx5iDF1L9V4SOZs0OX
 fXM2UIFSMmsJ62r32PVlw==
X-ME-Sender: <xms:YqnLaSf_aKZllVBJARRPOPSDk53yfweEBSX1OqThoO8371JYM2XKHg>
 <xme:YqnLacUud0SHMCD3N1KamLzJ1f85cZ5Nn17-cg-1UAKnuofm4r-ofBp3Z_0B18TbU
 A6iPmRtRoA9liWe7oLqL9xnQmawjybbervtmknJ-MoOK98TnZz7Tw>
X-ME-Received: <xmr:YqnLabfxMpwku6UcCuHO3yP0H3U6vHiMvzOji9fDEhmYmDsDBGg6wgW6zGEwwW6MHWoufxdbjKFkCKNvOOGCbOyTEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepvghmmhgrrdhfihhnnhesihhnthgvlhdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehgrghkhhhilhes
 mhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkrghirdhjihesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:YqnLaYMVvjDty9Gd_VcWQ05z4_C-8pS4htmQTN07aLQr4Uxcc_eZ3w>
 <xmx:YqnLaZjo8GQzEMqZJa_6BmLQoYy5z3b7Z58S2OLypLzUckxZId6ABA>
 <xmx:YqnLab2my4DyEq4xn4AKFcNBQT73wm2XvG_YHL28u0bryjlxus8DRA>
 <xmx:YqnLaTgCARi-aUHBslr_OTUZibWy6jMf0TUu4vC6dJ2zQETsMjIu9A>
 <xmx:YqnLaefxCHSJYueOPXlOCIUQDEBLIagYnB6d6GkyaBHP7jTEUz0fNr6r>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 07:00:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Emma Finn <emma.finn@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, kai.ji@intel.com
Subject: Re: [PATCH] doc: deprecation of OpenSSL version 1.1.1
Date: Tue, 31 Mar 2026 13:00:48 +0200
Message-ID: <2854591.mvXUDI8C0e@thomas>
In-Reply-To: <20260211121916.2598788-1-emma.finn@intel.com>
References: <20260211121916.2598788-1-emma.finn@intel.com>
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

11/02/2026 13:19, Emma Finn:
> OpenSSL 1.1.1 reached end-of-life in September 2023. Future
> releases of DPDK will require minimum of OpenSSL 3.0.
> 
> Signed-off-by: Emma Finn <emma.finn@intel.com>

Acked-by: Akhil Goyal <gakhil@marvell.com>
Acked-by: Kai Ji <kai.ji@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>

Applied, thanks.


