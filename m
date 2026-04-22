Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBB8F9EDC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22E3402E0;
	Wed, 22 Apr 2026 15:16:58 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 1C51F402DC;
 Wed, 22 Apr 2026 15:16:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 469391D00271;
 Wed, 22 Apr 2026 09:16:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 09:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776863817;
 x=1776950217; bh=O3UNZ/utRupl9oC92kdyvNreNFbEzinQYpKp78eHqsk=; b=
 lh6yo7geuwW25W9b9vLlhwRkDAsd//YYTHwCgMPIot7UHQazTqamugIU82JReK7O
 GRVxPMi3XeraWQVR5ZRWNpkZD7kYvsnYEGOwIpzhQnoiJd8+MA+x7QV7aceBs6oG
 OY98zCErDKc6PO79+PAd1BKZ+1VD5J/JZMcbtSavj2jwRZTHMM/m6fJkKmDa1yiE
 Q5Uqp1Abu91YdmGlZlqcSVTn1ruTJIg9aTQ1GXPe+fMwML07/RkUIMxtuSJC4t1s
 q6I+ce+qJPR+IbkLaAlIPwTI9ydzVLO75wnJ97TLmxcD+RP80LaR+FK4AuZhKS2p
 KOan/VrisNW4UyMFLYr/2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776863817; x=
 1776950217; bh=O3UNZ/utRupl9oC92kdyvNreNFbEzinQYpKp78eHqsk=; b=N
 GyiIwZviIb+k7Bmb7G1kM98amB4QYVkDB4umqxVnBHy9d5ZW5rndjS68gqpSOePW
 qXtHFopzbWYMnLuWmqoCB11ytRU7DrevBWyFwDvdHhz0t+wiAFPnDsXBE/8yMXHJ
 JzuQzA9lA/x8NzJPQCl11c6JcXc+YAmAE2cP9PsEXNri5AV04JMZfVnJxiAGNlVO
 +N9JZsbKXad1cU+WjG+G2x4p5nIAcPQbRbn5VRWRG+pgedbYDM2KgoA6u0GixidQ
 xSOpjkn9jtuRyBkO9ojFBJbM6VYrxYbkWqsnf0SWSgNML7y1R6m6mVMgmp2JgNuw
 qurtQLUOpdFwl99ltQrnQ==
X-ME-Sender: <xms:SMroaVnRKmES9OTWPQNx-5_EMHEDpEebld3d2dsB_g9FzbEJUVWpkQ>
 <xme:SMroaQ-a7g1WCV5s9tOl1vy_ABc9IFlCCl--8F-GXkxVOgJSRoiV_a_qbWBcYR9D2
 E-ECAAmgJf1h4xRz-YxF5bhg7yZP1Ec9Bjua_ORz32dU8fVHhPfPjM>
X-ME-Received: <xmr:SMroaTkcqMJRbGSKv_7SvqinRx6jDt7Fs7_1FClguIrdrhEfVZm2-1XTaC2uMeGf8Z25TRZheH9Xx1_Vgjs3xyeRZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehgvghtvghlshho
 nhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:SMroad36qcCuGd3U4YEPOglZmwNZkdnNXO5Quzs5v4x5CBTSU00uYQ>
 <xmx:SMroaepraBfzC0lY6eqHbOTCMHb5ytE0U7bdIsqGCrXwBZnEAakgYw>
 <xmx:SMroaac8QgnnIfklXCk67pQllcAMOqgLzCcpkpQOFBh06MYVOBxgEA>
 <xmx:SMroadoS59yjh-thI81BtbVVGGcqE2LyqSncIihX2ikLkk9qw8SK-w>
 <xmx:ScroaZs7nC7qw2QcIRjNvwhQ2AdaABLQFQAlsk_FlCmHqqLYWJUgcsPc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 09:16:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org
Subject: Re: [PATCH dpdk v2] net: fix L2 ptype assignment in VLAN loop
Date: Wed, 22 Apr 2026 15:16:54 +0200
Message-ID: <1924482.atdPhlSkOF@thomas>
In-Reply-To: <20260422103838.649578-2-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422103838.649578-2-rjarry@redhat.com>
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

22/04/2026 12:38, Robin Jarry:
> Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
> rte_net_get_ptype() uses |= to set the L2 ptype inside the VLAN
> parsing loop. Since pkt_type is already initialized with
> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
> (0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
> VLAN frames to be misidentified as QinQ.

Thanks for finding this major regression.

Minor nit about the title (for whoever will merge it):
we don't really care the problem is in a loop.
I think this title is easier to read:
	net: fix VLAN packet type


