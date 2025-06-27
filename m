Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8900C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03232402AE;
	Fri, 27 Jun 2025 18:05:09 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 2C25A400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:05:08 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 90A301400177;
 Fri, 27 Jun 2025 12:05:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751040307;
 x=1751126707; bh=vnG3jhqZmGmEWIIrRimfCBA5aahApMRmNPlKuwxbMvw=; b=
 tBPdke9ABJHAx3xZQ7WqCifyNSgZg9mXRjUXDaTwTH4i/HzVqYG+QPfhuhwjcdr4
 QT3iLCsAmIKHnMwsrH1NKagsceHasbbYIoQ/No0RaS9E2cz8RhnoqzYeQmMFz4sU
 eb/J5/fKsZbVHQmd2JSXAKYDWjrGiP7U/TrRJ4/LjxTW9Yn9Z+cAJBHuANnbUr/6
 OC8ptQiy2Oonc2+eLmEzQxQ1yRtUSkrxWmHiraXjKHoJowmziHds3Z20hMygJn4f
 uat+0XgKt9XrzwPqy26DX0exz3bHNXnKT7sPjij5+vzEvmDD9RQvZx2Ol0kYUjyA
 pPR130qMYJW7j205SvQbQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751040307; x=
 1751126707; bh=vnG3jhqZmGmEWIIrRimfCBA5aahApMRmNPlKuwxbMvw=; b=d
 EtxGPKBW2Y7uJwI/vxNkOcDXrUvdrwSnh2H/Ym1L30ydpSFvNB3vmo51d3zN4+c0
 R96i8Yndw3/ira0qgujzcuQ8F9aL43d7Ukj8X+jH+tKNviUua7swIuDwO/OHGh+O
 4eGBwd5AaQKoktR5ymWsAbcdbUIXv7JcPSViJJaCtF5ugO8pjEHM3sQFXOGqqM8X
 M2lItMo0pa43KNyJB5c8PighTyJ/aSrp7rNhy+xpddWklq0tQqX2MZYLXbO6q27p
 Z+c4kOu4Hog8RKzXnK2xOneqDFTp53TmNQhC6b387SvUCYb514jq221MuW/RYxjz
 1jb8ajdZzJIlcQjuwg+Pw==
X-ME-Sender: <xms:M8FeaE2JrW60hTEGfwbvvr_9ykZa0fPIgyBYtFaYf5omRKzfRP7LJQ>
 <xme:M8FeaPG_MKqOJQRiSESx5LxOJuR5_QpMUee8uAJjuO6SNP0_ZcTEMXxLTQBvKl48t
 9z2Qkw0nGLl4qoMyQ>
X-ME-Received: <xmr:M8FeaM6XwCqeJVqt5LJHsvsQHmeBLQf4T-kk02XgAC45E_9sZ0HcWFjavXnRMZicP6CGoR4Cay4id4sWcmFYqGhb0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehstghhnhgvihguvgesqhhtihdrqhhurghltg
 homhhmrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 rhgvshhhmhgrrdhprghtthgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgvph
 hhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehjvghrihhn
 jhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumhgrrhhksehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopeihrghniihhihhruhhnpgduieefseduieefrdgtohhm
X-ME-Proxy: <xmx:M8FeaN0iLxdmLQ-uA6_jKn8vIkv4tLgTmPp7cqHs3dNrX15kwudb_w>
 <xmx:M8FeaHEqZD6fJtBMtVzSB1HwODYkZgJwK39TjJw9k3h6_cHs1-bycg>
 <xmx:M8FeaG802i3zMQyPNtUZH_R-JeAP8Zn3qQsevwzy-m9l0pODglqfkw>
 <xmx:M8FeaMme9ZsS99rqPB99lZoeB55nJ-U0vk-DIwykuGTsXdZ6Eza6VA>
 <xmx:M8FeaMyqVnv0T-5uCoH-_t0LZ6PHywOL7DS6oswXY7VxoXkWc4vSZ2pm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 12:05:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Fri, 27 Jun 2025 18:05:03 +0200
Message-ID: <3799976.Ii9rTq9gLj@thomas>
In-Reply-To: <20250609211937.345620-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250609211937.345620-1-schneide@qti.qualcomm.com>
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

09/06/2025 23:19, Schneide:
> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org

Excuse me, I'm a bit lost because you have sent 3 v2,
and there is no changelog.
I suppose I should assume this last v2 fixed the comments done by Stephen.


