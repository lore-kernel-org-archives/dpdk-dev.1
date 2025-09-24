Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D0CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E596440661;
	Wed, 24 Sep 2025 16:41:45 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 23CE740151
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:41:45 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 263CB1D0010D;
 Wed, 24 Sep 2025 10:41:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 10:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758724904;
 x=1758811304; bh=ZTfk1H5dmkh/rOQVktwW/eW3HHcNmmJhRBwamROwjDs=; b=
 J9oHhNI+qvJDOeo+T59dI4IyjEBVZ4d+2pNOQRwbx8LWTlwglee8VtuVe5nKG1nE
 5APF/YCMp3+UOq/e5bFW0ge2AVbTTwcXCpH1yuzvIKdDy1PNNUbmnBIUX6mdHnsA
 AZQG/BwNzb5pMzrqN9otGF82tj2o/qtQJ5oT0I3NYsSUPIOgPebrjh+v6WBanq5v
 1G5iYCrqsncOZy223gDOatOnp3qwOeaXDNGXRT1qdI3esFTw9nSSBv8GiaZ5mGal
 5ykhIMAM6wYT8SUAlAF5kqBImOjrkq5YzSlODRKcH4NCOt7he7jF8wqPp1GicPvJ
 yFhtAPLtG2PGdKVYR+epPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758724904; x=
 1758811304; bh=ZTfk1H5dmkh/rOQVktwW/eW3HHcNmmJhRBwamROwjDs=; b=X
 y0aPPr6YXNcolBQt7Ln51U+6jqMDNQ8labzzILQ6qbnQSc9Cg3VFBcBQs7lPMS67
 RJ/2q+llRdvGvnTv6svYRM64Fc1gyLE4HrqFL52o/Jc1LoKXY7FdFkkjG1o0SGaG
 iQZ7tNJTiD+gniPJAH+RywBwBgfwl6IoGJkYCChQQhBUmL7GOQkoiOHGWf2u/EXN
 8TDSls6aCZhnDUkthJ14uBW5V18ppSIX6s/zR0/vFhmyORyZuGu+6yQQCO7sOwUm
 D29DMzuuW4rcXog5Alnd1DTwNgm5V0uP3ak7hmkeK4lGgh8EvbVVV0EJg1On0RYx
 aBzGwEEKL7kHW4+XF0deQ==
X-ME-Sender: <xms:JgPUaEU0MNzL7Vzex-AnJoGcpjBzpjJ_w399tqW1kd1hlaC6x0nXpg>
 <xme:JgPUaOm2Gu7Zia2Xc6xrzBHd9A2adBaMW_-faNpWwTlum2zg-asu7fYDmklRv4crA
 dmLuDseCbks04FTlz2QXMXxpL15RMV0l8zjSgV5yzJRcwbsY5vg3Hw>
X-ME-Received: <xmr:JgPUaDOgQaIOiaPhkQjEe6oPUaj-Bhxk7E857vlQy1lPbwpzS9qYZXzel5QLBm9n4IDk2MymyP4pWTCIIceTG9MA0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeekjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddupdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 eplhhihhhuihhsohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepfhgvnhhgtghh
 vghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonh
 hgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehhuhgrnhhguggvnhhgughuiheshhhu
 rgifvghirdgtohhmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokh
 htvghtlhgrsghsrdhruhdprhgtphhtthhopehivhgrnhdrmhgrlhhovhesohhkthgvthhl
 rggsshdrrhhu
X-ME-Proxy: <xmx:JgPUaGIYVbeGZpOpGmnNXfqDAPILgr5XfeiglM4u8kyAiBivxrWnLQ>
 <xmx:JgPUaN0v9oI_71UzxsXN6tR1aRCvLIM7yo0uhPlgjzm9Bq3s93_8KA>
 <xmx:JgPUaCV1BxrNEL61Z9owq8IFDaUJl05IajX7EzgxT6Y0bWBgPT13Hw>
 <xmx:JgPUaHNi1tMJN62Gft6i0cpD2oRDbSQSbaWcDEz-_5f0Umu9KMCRJg>
 <xmx:JwPUaOn-peOEYDf-pRL9gN9KY13cJXB_ldT72IKewr4CICOrbpoB5MaA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:41:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, aman.deep.singh@intel.com,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com,
 Dengdui Huang <huangdengdui@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>, 
 Sunil Kumar Kori <skori@marvell.com>
Subject: Re: [PATCH] net: fix incorrect L2 length for GRE tunneling packet
Date: Wed, 24 Sep 2025 16:41:39 +0200
Message-ID: <3634305.KRxA6XjA2N@thomas>
In-Reply-To: <20250723104710.558623-1-huangdengdui@huawei.com>
References: <20250723104710.558623-1-huangdengdui@huawei.com>
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

Looking for review, please.


23/07/2025 12:47, Dengdui Huang:
> The meaning of L2_len in the parsing result of the rte_net_get_ptype()
> is the same as the L2_len field in the mbuf. For tunnel packets,
> the L2_len should include protocol header of tunnel packets.
> 
> Bugzilla ID: 1754
> Fixes: d21d855464ff ("net: support GRE in software packet type parser")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  lib/net/rte_net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 44fb6c0f51..c70b57fdc0 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -481,6 +481,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>  
>  		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
>  		hdr_lens->tunnel_len = off - prev_off;
> +		hdr_lens->inner_l2_len = off - prev_off;
>  	}
>  
>  	/* same job for inner header: we need to duplicate the code
> 





