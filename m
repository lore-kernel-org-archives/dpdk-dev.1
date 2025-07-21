Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F35C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A344021E;
	Mon, 21 Jul 2025 12:10:52 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id C06094014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:10:51 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 66AF2140025A;
 Mon, 21 Jul 2025 06:10:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 21 Jul 2025 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753092651;
 x=1753179051; bh=ac6rL3v5g7g0S3eTAtgwwVb2uhvZvEieKIUY7XTDkdk=; b=
 obCn6+iSTiXr/HmQ+YgdMVlx2mwbRW/sbkMaI/K3XYK7Pj5q0MSY6EFe+TnusqX8
 jwrEfbfGWowy1w3kU+Vr01sgbWCL9WlTO2HBwcdJi1p0c8/E6dWjEpby2hs4dVSa
 xHdoLA/3TGd/LFgQH6+Orv0fsaJx2iMJCdxfslqYnQh1cJZ6uB/FYShqkxcV3PVx
 +4qDvXyR5BF2TSop61+JntWYKhrsFY6xHpRfxmUwsgzCQP32Il5HNTdnyE/UKPSg
 6OFcu7mi/CQLa8GAESvut+MWx25TxecofdisRSIiDjyMhNyG3IbBFLiW5mrnBlQh
 776G1eN6hxVPyzA0UvsEmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753092651; x=
 1753179051; bh=ac6rL3v5g7g0S3eTAtgwwVb2uhvZvEieKIUY7XTDkdk=; b=l
 fphdzXt8CSFTg/22YGBuC56ja6RzScgstBss+pMbPPiC//OVCAQhyuEvwdEp9Xdt
 hZro0oditVC3ejHonDZ/THswiT4LOWUFFYFk3aKhKtZngGBZXtvNn7pOO/rJ8Op3
 +gvqvWyrAK3N/ulf3ruArL6pMFxIYBYpCoFeKysN7kv85yOZ3e2UMfQYSTaW/u9W
 PJks/YAGiSc3N7nPRGXAG51TlymeoA3TQxnOHTgE/AiJoyOtyon8p1Z/8nSVhxNN
 sxnErIGkJEIvbMiC/O8Y4nAmPs7jqWm7z7hYmhNj/ZehAupWeD1riHFO71A4xfEA
 ppgnEerihFI6YP5AoYABA==
X-ME-Sender: <xms:KhJ-aEQpkeUY4KjQDfiIR7nl5BrT7XF4e2tms-Wb5aZrukftax9Cug>
 <xme:KhJ-aMqzZJrBHui8O9sSVVOXaU7QUenFlK2_-0j1HBswGtjW-9kMQjvY58CafiZG0
 PNVSdoD-DcujUh16g>
X-ME-Received: <xmr:KhJ-aJrJzoN-T0ahDKouGqnMMPq5hzR_vlr7wdnRY8l_zWhvj8dm5f72Po_2A8IIaYN5WLssGlvxTuSLmtIi2JFpSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudekudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepthhirhhthhgvnhguuhdrshgrrhhkrghrse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepphhrrghvihhnrdhprghthhgrkhesihhnthgv
 lhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:KhJ-aGNADrxrsMrnfxd-8LTYf9pB2fYqbea7nPXU8zJd11TmRfgwwA>
 <xmx:KhJ-aCxqTu5Cu742jXkP2ebFjtBzRRRPvfGeuhyJ9LV_Hg5CZTWr6A>
 <xmx:KhJ-aHvyl6D5rpSEkdvDT3PYFVE4IU6qzkf1coyJ7XPVDAzLoGtvKw>
 <xmx:KhJ-aD4Oh2YUfor73wagKYcpAlOnq37QOXDvqEERiu2lNdsDczLBkA>
 <xmx:KxJ-aC6zT_a6_bvwZS83W95ANQ3Fjqy56IrdEDuFOoufV6xXxHUdiIIm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 06:10:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
 "Pathak, Pravin" <pravin.pathak@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] maintainers: update for dlb2
Date: Mon, 21 Jul 2025 12:10:48 +0200
Message-ID: <2715907.k3LOHGUjKi@thomas>
In-Reply-To: <BL1PR11MB54613E670B1C84E40455F912F448A@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250709050434.1296690-1-tirthendu.sarkar@intel.com>
 <BL1PR11MB54613E670B1C84E40455F912F448A@BL1PR11MB5461.namprd11.prod.outlook.com>
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

> > Subject: [PATCH] maintainers: update for dlb2
> > 
> > Add myself as maintainer for dlb2.
> > 
> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Acked-by: Pravin Pathak <Pravin.pathak@intel.com>

Applied, thanks.



