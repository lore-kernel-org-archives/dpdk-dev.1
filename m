Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41697107BCCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:48:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C972402BB;
	Fri, 13 Mar 2026 17:48:27 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id D7203402A2
 for <dev@dpdk.org>; Fri, 13 Mar 2026 17:48:25 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 57982EC05B3;
 Fri, 13 Mar 2026 12:48:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 12:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773420505;
 x=1773506905; bh=QXRrg2P88PlCvVyneKe0qUvu2GDcmMhRlHYiOQg5Q2Y=; b=
 bbBU85SKTjgSrEEcNHDvAD+11lGHMIUr2uLhdoRvpuwK9juAYPNSK8t4wlCycNqU
 fbVVHglMm8lblxBfBfMEzrRY2DOrQFJVHwyEklsE6Ff2uOFGKYI4uGzWEtZzS1B+
 9wsvxUte703cGH6XBalG+yz/+DR7lRbgmzIh0aM6WfAzhu8yl2CedmtyQupwd7zt
 alcl00mOAtARf7Qckr7X4wavcyD3ZhzlBFncr9Rxkqs5wUowrtVxjQ5FDTafJEjU
 MUxygqT2iNMZb7NUJkbaxYkQExLQLvZMOmeSW+lBP0uaBUdnGd4KGapuRdVuQGb1
 zRYj9fLwfLs432g+co9eyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773420505; x=
 1773506905; bh=QXRrg2P88PlCvVyneKe0qUvu2GDcmMhRlHYiOQg5Q2Y=; b=L
 U4F16VvlRIgGnE9bXP/kixDtHdZZ9uOZhxPUlD0AQBwPoo1Y/rT89cWcZBAYmDLJ
 O3vy5rlIdruyKBozcvFIhK+NvTz+gURpKZQlXgg6JszCQh80xW1okeaO/px94ELv
 NFG+tu1pcwSRL8iCiR/9NMQAE4OGbnpMURbEEwzEEiR1/vfh6X8pZ4sUf8TRt4nB
 cdiuEgEOsCNtaJ+3j/OhtL4FtKSIIX4DFWeJjHtTa+FwAaajiWi299cTNnWsS4TT
 MCTlAqitmICDnGZxBY1rXd00vZNimZFA+VhQQwXxAhulA9hTcy8XEkI7ozjyjEZi
 cFbyuYJrcRnZ5FTTUzwqg==
X-ME-Sender: <xms:2D-0aRFi6EViDR6NAtHUn2NiCiJHvQ8JJP1CKhdxd66NRdOUo4plhA>
 <xme:2D-0aaryUE8oXxFm1vH3DkNj0FTNLbpKwJ0gWz2HXRPbm-p8jFImkjTOwXIwzL8-5
 euw2gT2TEVTUd_AvCTQOCBYIsyk9uocyugEdNFbm2p48UrIZFD65-c>
X-ME-Received: <xmr:2D-0aSTByHtRkBtqllcHPvhcHKpqUhQg_79Mm0NMHH10EnKVDArbr655V7CfX3Ek1NLzbrMIoUPIy4OD0WjKgc7ZKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtudekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsphhinhhlvghrsegtvghsnhgvthdrtgii
X-ME-Proxy: <xmx:2D-0afOLAgkSUkGMgY4qHx6u4ZWvKtIq-ao0ZiD-7Daoh5M2xp0ncw>
 <xmx:2D-0adPwUxKZC-MH0Z7HY6QPeUJ5N3YFsBAHK9CTOseSA27ZsPnupw>
 <xmx:2D-0aXufaR1Ima6CyiwO35Y8vR8n2MGDQlkKxwhO1dMsF_waZxvj0A>
 <xmx:2D-0afXkBoWD_0LffoEOaShqIELF3YnFzT3f733Htf_jb7TJ-U_Uhg>
 <xmx:2T-0aWqrbnmBWA0moLviujIFKFCfbKglQfsaZJZTyJNnyyn7BMfRlOVP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 12:48:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Martin Spinler <spinler@cesnet.cz>
Subject: Re: [PATCH v10 8/8] doc/nfb: cleanup and update guide
Date: Fri, 13 Mar 2026 17:48:21 +0100
Message-ID: <3598942.QJadu78ljV@thomas>
In-Reply-To: <20260217071040.2855133-9-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
 <20260217071040.2855133-9-spinler@cesnet.cz>
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

17/02/2026 08:10, spinler@cesnet.cz:
> From: Martin Spinler <spinler@cesnet.cz>
> 
> Clean up documentation and update the guide with:
> - Current card list with firmware download links
> - Updated port argument description
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---
>  doc/guides/nics/features/nfb.ini       |   4 +
>  doc/guides/nics/nfb.rst                | 187 +++++++++++--------------
>  doc/guides/rel_notes/release_26_03.rst |   6 +
>  3 files changed, 95 insertions(+), 102 deletions(-)

I don't know why only release notes were merged in next-net.
I've caught it thanks to the description not matching the content.
I fix it when pulling in main.
Hope there is no more issue with this series.


