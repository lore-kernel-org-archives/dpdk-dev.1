Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1772C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 20:25:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BD840156;
	Tue,  1 Apr 2025 22:25:29 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id A2A9640150
 for <dev@dpdk.org>; Tue,  1 Apr 2025 22:25:28 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id E5F4611401A9;
 Tue,  1 Apr 2025 16:25:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 01 Apr 2025 16:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743539127;
 x=1743625527; bh=brb0ploamHL9l6A7y5mjz0OBueOxRNy1AM45fas7OXc=; b=
 gZWY7uX9hpo5BnmycqQxN7h4bJkzar+zHYHFQJTYQvqol5sF7Xj/uhOgh44npKwY
 J7GcdhngYxPV8W6XwpQ9GknzSkyFoGZdlBAluBXOKiZMKT4vgpDOshIdyIyPFZeW
 nPgL1uBbo6Ed7HVveb35n0xhlrWlVlVhdNH6pgBPL7nHKTk1D3V8P020l7vEskeY
 /4HTlHQT87gmJU18/WW/ldNxjDwOQYDOUeCNOi5Ru+nwTAPw7PE+yQHeCIjNy4B0
 eW1XVpv/3O8+stcngQ6hbcLklfIIyxhyRSSflVdTQz1d3yCJFS5J6JLYadkknyip
 wZMwXsHUdM99c9y2TpuPIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743539127; x=
 1743625527; bh=brb0ploamHL9l6A7y5mjz0OBueOxRNy1AM45fas7OXc=; b=P
 c9Z/kZ71eWaAKCUvb9Tq0EzBsOqWtSsmE7JQeyXa732R/3qfop4JOoJMuSXdllkp
 6GyXA4Fq9tRLJsZfkh9Kiulwh1hd9gyJiBHBKhQ6j5rM7dLINb43UWuFVQVQlTSN
 g5N5q/dT6OYpyjacCI3Ei7qxwMHJezqirS1z5yi9b7QuGwiHRTjtk3Fd9BdqnvhK
 3rF3KD/2PRgWxCave6Wi2+4UyF3oyACr9MqRP7reSz3uKxWiPxkf96EWPq9sjG6i
 W7nylTZcpFDqUtlxPUH4dAOPsqx1JyXayy4rkjk9QZCPzFisBcX+ILWN5wBKpYck
 fEPEuL0h0rjcRo9u5GZOQ==
X-ME-Sender: <xms:t0vsZ--v19DZvw6hf6hq2leIvgrxPwVoQ922GuDclV2b6fDZb6F8Dg>
 <xme:t0vsZ-u-MG6wOU7PuSR6pZf9zoGxIwBkoilLkdUcD0v9GoFa13cdMsd0utAU1gO33
 uy35Nmlo6Qy-RdHtA>
X-ME-Received: <xmr:t0vsZ0DETHh5Rn23W954icEkFx9HkTVQuXEVAOV-N2L97JP7c2owrkJ7O_f6aueO4n_bKIqN-80h8zvgv49JAnRxJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:t0vsZ2d75ODns00M-ovCAAWA24yztCWmQjZG4C_ABH51KNBxobP6aA>
 <xmx:t0vsZzPZXlmBM0lskyxpzYtifgl54Eg-BeTQTwM1gWCe1KZpcCtt5g>
 <xmx:t0vsZwnpcDpK52hePyJYQQIvtep6XFvRsJOZaew-eWR-Xz4gamDDyg>
 <xmx:t0vsZ1vgWmiXCnJfmNaJtROzz3w2EYYYd1D1cHtfyOI3SwqUGYaY5A>
 <xmx:t0vsZ-2_HjCncpssb0Qs6atqNKhnkGvBUOXskBvi1faTQy0zbI0mkdzo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 16:25:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
Date: Tue, 01 Apr 2025 22:25:24 +0200
Message-ID: <4725377.72vocr9iq0@thomas>
In-Reply-To: <20250328105250.3082414-5-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
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

28/03/2025 11:52, David Marchand:
> Rather than maintain a file in parallel of the code, symbols to be
> exported can be marked with a token RTE_EXPORT_*SYMBOL.
> 
> From those marks, the build framework generates map files only for
> symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> becomes unnecessary).
> 
> The build framework directly creates a map file in the format that the
> linker expects (rather than converting from GNU linker to MSVC linker).

At this point of the series, the build is broken.
I suppose it is a tradeoff to avoid squashing 2 big patches together.

This is the error I hit:
drivers/meson.build:275:37: ERROR: Unknown variable "sources_avx2".


