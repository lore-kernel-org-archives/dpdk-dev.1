Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A375DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 19:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C8F7402D5;
	Sun,  8 Jun 2025 21:46:27 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 2E8CD4026B;
 Sun,  8 Jun 2025 21:46:26 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 4FB85114010E;
 Sun,  8 Jun 2025 15:46:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 08 Jun 2025 15:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749411985;
 x=1749498385; bh=zlvhqFvGwyW/vP5LWN5NmVHRfCfbRbooOwhN/9LvZIE=; b=
 Mya4n7VvU5NjmcGvoZbIvQVnpXkZ4MbgIrTPr6TlGHmcynnjl0Bv0blnIzGqKRSQ
 afMmZEsHN0R2IHCE6Z//QupJYNe0GUv593dChIOR5l77O0OZdpljb4JLRwlIGERn
 L7/xgf0NUymD6tLp4Jmx/CUsDwPURW6+Yhv3GhqJY2LTXG/0sU1Kdks/II0Sbi0G
 eI+eJ/6ZtUTgc96fGvAdZf9V45nHGVJ+YjnIelPCQraeeyhyKqk/e0a6F47Am/n6
 CE4EdB2XjASnYznoK345aIoCWT42jjeUbbeA9azzaxX7yKv5c9Xg3e8RNIVJrsVK
 G2YhtY/WwgYjZgsR4U2JBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749411985; x=
 1749498385; bh=zlvhqFvGwyW/vP5LWN5NmVHRfCfbRbooOwhN/9LvZIE=; b=X
 55pfjmDOf0GiXEiiR1q5PQFJSD6FXrDyiUOi1KOMXMPvHOZzj1TcKuhcj3wt6Z95
 c96hd8bAuXbp79g5yCR1Si+Fcv1Bj1PQYkavCpie6AWRK9q8FLNR078oSXuCb8vx
 82GdGHidKndgdbNY4fh+R9J+Yn+fsnBO5wOfNe00xJwYt4HWGISsVRbbSHaDmBPQ
 H+j+RIadQFiTfCobmuXSmhpKkgEWakFJ8IZTm3F3YVxT5RBJ3IGqgUqjmqpwGRWA
 /TG27gyTITFU/WcGrbIzTxm+vU3PC/LCNNU0MVrR6uYT61yvGQvK+Do6vh0YChBP
 tIat7oJtj6AuGcqr/J8UQ==
X-ME-Sender: <xms:kOhFaG96nKFIu3pB0YY63Z7VnA1vmhZxsSbt_0tucjcdMW6mOgRATQ>
 <xme:kOhFaGv36c2zUWWN47umIoV_soetw8n7NQs-VsxfPS-eC2kjlyM4DNkA55nccGhKC
 KqLgw9zXZyuMXC_Ew>
X-ME-Received: <xmr:kOhFaMDS7LiX5y31OknXqY_ey-CVtV2UNOZtwVwB5fjlmNEJu27Gp5iWOqQg1xwpJYU8fFo9569EIj0KAFVTLMXknw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvih
 gurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthho
 pehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtth
 hopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:kOhFaOenEZAusz14vzBV2RQsfwA_zWZQqCbpBJ3zP4Nzgy5PIlvnbA>
 <xmx:kOhFaLPLlYt74ca-BgBAUFGFEgDNE9iRyoSrh_pQnZUws0cveRfD4g>
 <xmx:kOhFaIkptYdYQ5a5siYszL9r2LKjL7rlZ0C2ug-BrU5-zQQ6oPgGpQ>
 <xmx:kOhFaNtWXRYLuedUh7MQCU6UDFRDc9KEagpGD0PaP0d2xDph3hvgdA>
 <xmx:kehFaDUS8baB21IQWPRq9UCYRtOgw29CA9egBpr0sSuMWQ__FPzfmCYQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 15:46:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH] eal: warn if no lcore is available
Date: Sun, 08 Jun 2025 21:46:22 +0200
Message-ID: <5304331.aV6nBDHxoP@thomas>
In-Reply-To: <cad488ce-440c-4f43-a55b-39e16e17f4ee@intel.com>
References: <20250508051915.226465-2-david.marchand@redhat.com>
 <cad488ce-440c-4f43-a55b-39e16e17f4ee@intel.com>
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

08/05/2025 13:23, Burakov, Anatoly:
> On 5/8/2025 7:19 AM, David Marchand wrote:
> > On systems with more cpu than RTE_MAX_LCORE, starting DPDK with
> > cores >= RTE_MAX_LCORE ends up with an ambiguous error log.
> > 
> > Example with RTE_MAX_LCORE=8:
> > $ taskset -c 8 ./build/app/dpdk-testpmd
> > EAL: Detected CPU lcores: 8
> > EAL: Detected NUMA nodes: 1
> > EAL: Invalid 'command line' arguments.
> > EAL: Error - exiting with code: 1
> > Cannot init EAL: Invalid argument
> > 
> > Add a better hint to help the user.
> > 
> > Fixes: 2eba8d21f3c9 ("eal: restrict cores auto detection")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.



