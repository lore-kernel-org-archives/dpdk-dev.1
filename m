Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC4C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 10:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6122B40B99;
	Wed, 13 Aug 2025 12:02:00 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 73D9C4021F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 12:01:58 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 9D0AD1D00085;
 Wed, 13 Aug 2025 06:01:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 06:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755079317;
 x=1755165717; bh=djiyQTqqPjpUIdtsOkjuyPwR7rsQO6/1l80gXa1Dp+0=; b=
 cp8uDvjNk3dtsdFqyUSzR6XriQZVdraV5rws37e8FMeRAWWTCl4MWDDqtHwD7XzS
 a/l8M0w5mDAtG2K6GyErTHu3OMQtCxsMsjxoUhbSfmsbuVtK/qYNxBsvJZVp6+1T
 eXSOYqGDsGH8+sUS8UM3rpniqleE85y62QYc5iWdPm0f6kVEfzqVhMamMopBCTyd
 XWq0JQx0TfCZ/gGjY06G1/pnpjxk4E17Qguap7XqqrmfZcpQkSlNh/CX7Wq/jauo
 QiHIjibFRECqpxyec/Ot2bMC/HQawCqxoiprcPvVn9zmZTZyKVPH/sxVIEQYJdhE
 tcRaT9WPjhs1Xm2jGeAHHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755079317; x=
 1755165717; bh=djiyQTqqPjpUIdtsOkjuyPwR7rsQO6/1l80gXa1Dp+0=; b=Z
 r2bLYON0SIcBVC0Ba1JKq0FXxv/lzK46ltrlkXbSmaCW40DGKkeCn8p0BNfxeSlV
 pxP6bSXvvzLkE1Thm0qDWk7gWw7S8DqsMiZvWq5sPqhv6BZo67zoROCOCvVkMTkB
 Qa7T4+neDy0xIHGBsfT7N0om4xvGOX1Js2VINxmrk7Y/iEeEPGVNqIpmeWJlHPlB
 Ny47taZ7cHkq4pMbLsaIR8S+dYRRRt6YjkyYu2HJBjHWronVrxPeb2zet01PZThn
 YCPwxa7JJJjm82r/aCsUoHSSnhvhCMDs70l8OM8AzC/KNV56DJzZDgIoswYKG92u
 6rudEmcw8B3Wlnbj5xRig==
X-ME-Sender: <xms:lGKcaK7_pcSwdOLF6oqPemaeSSsmT9eixdYUdoK_LmOdoPAvcB5NOw>
 <xme:lGKcaB15Bc2KA-MmPuwPwI2NDJP5KHd4MaGCs8h2ZE3mn_QZcvtzaHZX1HoByPgFk
 6Vcv2n6403P05wHkw>
X-ME-Received: <xmr:lGKcaLzgUfoOcR9yiBfzuEYFeXqu2TvvwJfua35ECEfqRmyKRlk44xI2leh_W3D3FhiN9vHBiMRtt-C1maKQ0VVDfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 eprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphht
 thhopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtth
 hopegthhgvnhgsohigsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:lGKcaLvy2KKiJgdkyPYMrvga7EdPabSk8cSa_aWr-JoZXYRcOgcs8A>
 <xmx:lGKcaFzLxBLXT1Ovt7wkbXmDWdtbwGLjP8kM-ru1LixF9kEW4G6ibA>
 <xmx:lGKcaGANxXMpsJ-vWWfPPZpmd2SZIhsPMxtQqJHWeDKMCFfbXwSCAQ>
 <xmx:lGKcaLcQm3iiwkf4xsQCQ07gR6vVMYwrk-jddQ9vwDVfQVm-pOjzrg>
 <xmx:lWKcaMTonSDa6pUDjujbxhkQuazxAbJoi7384WzBSIrt-vgaPXM0cJCd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 06:01:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
Date: Wed, 13 Aug 2025 12:01:53 +0200
Message-ID: <3325626.aV6nBDHxoP@thomas>
In-Reply-To: <20250812083431.6502e587@hermes.local>
References: <20250812144249.316120-1-thomas@monjalon.net>
 <20250812083431.6502e587@hermes.local>
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

12/08/2025 17:34, Stephen Hemminger:
> On Tue, 12 Aug 2025 16:42:48 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> > index 5d7fc5ee9d..d23c143eed 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -306,6 +306,7 @@ struct rte_eth_stats {
> >  #define RTE_ETH_LINK_SPEED_100G    RTE_BIT32(14) /**< 100 Gbps */
> >  #define RTE_ETH_LINK_SPEED_200G    RTE_BIT32(15) /**< 200 Gbps */
> >  #define RTE_ETH_LINK_SPEED_400G    RTE_BIT32(16) /**< 400 Gbps */
> > +#define RTE_ETH_LINK_SPEED_800G    RTE_BIT32(17) /**< 800 Gbps */
> 
> Do you want to go further, looking around I see roadmaps for.
> 1.6Tbs, 3.2 Tbs, 6.4 Tbs (2028) and beyond.

I prefer adding speeds as they are standardized and useful for DPDK.

> Looks like will run out of bits in 2040...

I observe the max speed doubling every 3 years.
So I imagine we will run out of bits in 2070,
or earlier if we have new intermediate speeds.
But in any case we have at least 20 years before it happens,
so it looks safe to me.





