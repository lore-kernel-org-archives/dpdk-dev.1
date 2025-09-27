Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9B9CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Sep 2025 09:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 500C940268;
	Sat, 27 Sep 2025 11:28:47 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id C975E40261
 for <dev@dpdk.org>; Sat, 27 Sep 2025 11:28:45 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A49BE7A0047;
 Sat, 27 Sep 2025 05:28:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 27 Sep 2025 05:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1758965324;
 x=1759051724; bh=IXcscPlFZM7PzAJJWoS2rT2TTQCLQ+m4zYOh+nkdwJ4=; b=
 NjZNwCviuHMtxfR3TBYCYsMiuCR6LIVNswBBgdZ52dlF0LTZ/aKJ0KcG2vZTv5ln
 BpwxUznLdT14ug2rWR6OywEaOinVeUgxovF+6hAymfM/OK8RcyXHgH3+F+E2BC3G
 yRtPVQGOFR15Zvgia8Zivbii/l1Iryoi2XuXx14uY7oI0k7ZC8D1Ctwiw+YmYlsS
 sqN761JzERilHU0SJsGag2oZFEBje/ltrmbqQTRBbM/ghue23cswkBoXodwPmKY3
 d0nBTWHXdQgKkhJkDDdYroSrFms1/SDX3QRDIc0MNaNGfmxS694B96mspCkKxvFB
 iZSua3yZBFpZpbuA7HsjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758965324; x=
 1759051724; bh=IXcscPlFZM7PzAJJWoS2rT2TTQCLQ+m4zYOh+nkdwJ4=; b=o
 4Oj3J6vWQho7nYdABG73Vgw6K25fmXIAhYZCdm9tSbwt0hLBK4YWR+vdnsz+4cia
 igAQJT6H3+rjTgm8GVBA1JCVvzerSK7g8IT7qHNQZXunDWzs/86PBrIS9aIsKkWq
 vL0IXBtRnXthWlHGD3J4a2LrHj6+VbRUoMOpRMU55gl3BCzwtOFBshcywewsX5H7
 rT0ZPX5TtY6NlJRfodU5BvEdMw7pAbHRPxv/qZT+6PNzxjD4dKgQuoYbfPRtcwI0
 cj+wO2MO0pLPPrLT7V/HRjyKeFU+IavmGxu8/RZusCYGuxajUruoS+J3Uzy867ut
 gP6FzwX+vlv8WJR27QH1w==
X-ME-Sender: <xms:S67XaDlIXXJb2QzIpskjPbuWd00bmZ2zzn2hluwULiaMIApI8OtSbw>
 <xme:S67XaF7xjxEhYT4fP27tauWtI0t8_cqg8I4rKds3cWmL9BiizQWrhgCVlHmot1jA4
 w8nDUAYCHVlEw6Sq0bsIjKXG5wHxCLii9XzSE_tTJNZF5js33TiHQ>
X-ME-Received: <xmr:S67XaP32WGeC-_tY-flMy5PIm3qTIfpTbP0G33XeKtvW10T1rpLP1wfN9DY7RfU5viBXb9tlMxx67-05vZGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejudeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthhhnvghiuggvsehqthhirdhquhgrlh
 gtohhmmhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgvrh
 hinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhes
 mhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvh
 gvlhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtgho
 mhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:S67XaIGV7Xo2yy-EfKBrbGGQLQM0R0FtVlX7Ofcx4Dyckw0qprgArg>
 <xmx:S67XaGgcpaTSop1_I9nebuJhlOYt3xfInUrgFomxCzmuMErS3RnEIA>
 <xmx:S67XaDCGarJjp9Cs4fDrlbRoq1umlwoXJKvxdwmmYTGXiLKp2X9vHA>
 <xmx:S67XaAST7YIOwZbsFlaib2XqW92IBYkt0bMpTN9-56kDbiKRR58JHw>
 <xmx:TK7XaCiu6WvWdhAuce45ko7EVtmY6ns9-N0sj-KxIAn7_4aHk1dCz1nZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 05:28:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Sat, 27 Sep 2025 11:28:37 +0200
Message-ID: <3296173.BjyWNHgNrj@thomas>
In-Reply-To: <20250925170447.2ae8d5bf@hermes.local>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
 <20250827223216.1337749-1-schneide@qti.qualcomm.com>
 <20250925170447.2ae8d5bf@hermes.local>
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

26/09/2025 02:04, Stephen Hemminger:
> On Wed, 27 Aug 2025 16:32:15 -0600
> Schneide <schneide@qti.qualcomm.com> wrote:
> 
> >  
> > +* pcapng: Changed the API for adding interfaces to include a link type argument.
> > +  The link type was previously hardcoded to the ethernet link type in the API.
> > +  This argument is added to ``rte_pcapng_add_interface``.
> > +  These functions are versioned to retain binary compatibility until the next LTS release.
> 
> Since link connector is now merged, and that wording might overlap and
> be confusing. Would be could to add reference to pcap-linktype.7 man
> page.

I'm not sure it overlaps.
RTE_ETH_LINK_CONNECTOR is about Ethernet cables while
pcap link type will be simply Ethernet type.

This being said, I don't understand the immediate benefit of this commit.
Why pcap link type would not be always Ethernet in DPDK case?
I think the only benefit is for future if other link types are added.
Is there something else I'm missing?


