Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C88C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 14:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9233D402CB;
	Mon, 30 Jun 2025 16:28:30 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id A75DC402CB
 for <dev@dpdk.org>; Mon, 30 Jun 2025 16:28:28 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 29320140019D;
 Mon, 30 Jun 2025 10:28:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 30 Jun 2025 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751293708;
 x=1751380108; bh=V8rYaseW3jxdR1nyu6Ls1JR19psD07iwXwKZv37my+8=; b=
 ESjz9sBLou6F3bSUUoUSTPJicAUV20MJ7YeVDqI9LTbBi3S8eSWznfNE//Y8Jqpe
 6zW6i9iJivSVzSSn+KabGJ+lzRvAjpgCMYYr7wnjfwCU2OLPFomFtmURNNwPzgjk
 OE0v7qDHCPGQv7uagA0JVlzWHC7jPtuAiiuOm1Yddu37GFlQlFA5kHarSaka58xZ
 sbEhZj5b70YQabNmn3F0/21VNOqlUNOyIH9OGjXpzmZk6T7Wls04cqBUoAEJ0kqQ
 5o2x3uKavlGYFTWLevaHlirpzDco8B1lKeWAdcb6gXOp8q0Uxx75SAp7mF6lCC5U
 u9zR+bYqIgoXfFVTyRt1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751293708; x=
 1751380108; bh=V8rYaseW3jxdR1nyu6Ls1JR19psD07iwXwKZv37my+8=; b=k
 7n2THJ1TG1Js6dZdR1mnpAGV71UgQIFd14+5vZj8DwX22kbMlsyTe9bAezM2gkAQ
 BLbae5YtcV1yQ9Uv3H+3yb+Ei5tuhZHuEhw2M/k3jrNG7VlWFdOozcB+h9LZd1xa
 Ge3igzebmgRx7wohxTEGgV3KA+TJBGAzResxIsutCfGarIeesSWYE8fZHAdRWh6K
 48/RTbji+t9ndLVycDI4WCKOEUjvfNLUzj5tbUFw2Ci50KbJjgEV7yo9jhejGeBg
 junpTB4NRmKPQHwrJi4GoquyzTxVSnEoOsvR+/5HaGw04PvIrMpSs292v+6pbbdy
 9rqBC8n4SYquDwIX1pG6A==
X-ME-Sender: <xms:Cp9iaPrjyUJHPPV6ufKjLDzd5KgDKkKQZu0QDwJ9KI9YlCeIugXULA>
 <xme:Cp9iaJrJNhH_JKGkuKxhXpeRAiIg0n4FPDbcUcf032Vztpq2ciSQmaT3Q4yV6SDj7
 T-DJHsmaqxE5Ja3sA>
X-ME-Received: <xmr:Cp9iaMOKzOoYOWUl4u4TbR1tgj_dI83xB9EHA76Rzk_brab6hOxTO6Sdg-bdjIvjRyajVUxqJWrqZ0ZV5h8P4h3g9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudelgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthhhnvghiuggvsehqthhirdhquhgrlh
 gtohhmmhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepjhgvrhhi
 nhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmh
 grrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgv
 lhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtghomh
X-ME-Proxy: <xmx:Cp9iaC6zaQjsGSOC6b---pFnjjxWqYQ5BPrYV5GAA4yu-hIjp3Zi0w>
 <xmx:Cp9iaO5iqNpaFUCZS3Gw0J7F5gSOAjzFSutTaG3N32JD4rb1wHHCkA>
 <xmx:Cp9iaKiP4nqjThrIHozdQovs2Kr2RJZbEn7vaPjg-7NMS6kPpx3ZYQ>
 <xmx:Cp9iaA6sBXEazD4svu3G0mMwuvaOSgbPt54gc64skR0s5BAdup3wmQ>
 <xmx:DJ9iaAuqD2--Eyx2eDBzXmZA7Qw6H0nXwwYP5kFGb48BQq7hUI7NmelJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 10:28:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Mon, 30 Jun 2025 16:28:24 +0200
Message-ID: <4485771.rnzLaay6km@thomas>
In-Reply-To: <IA3PR02MB107711F11A8681D42D5B911B4E946A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
 <IA3PR02MB107711F11A8681D42D5B911B4E946A@IA3PR02MB10771.namprd02.prod.outlook.com>
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

Sorry I did not investigate, but there is probably a different installation of the pcap library.

I have this in a config file:

pcaparm=$deps/libpcap/build-aarch64/install # requires big changes in DPDK
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig

I don't remember what are the big changes required, and why it is disabled.

Checking Meson, libpcap is indeed not found on aarch64:

	Run-time dependency libpcap found: NO (tried pkgconfig)
	Library pcap found: NO

Can you check whether the error can be related to the absence of libpcap?



30/06/2025 15:50, Dylan Schneider:
> Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI. Is there a reason it would pass there but not on your dev machine?
> 
> 
> ________________________________
> From: Dylan Schneider <schneide@qti.qualcomm.com>
> Sent: Friday, June 27, 2025 11:46 AM
> To: Thomas Monjalon <thomas@monjalon.net>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> 
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> Hey Thomas,
> Thanks for the reply.
> Can you tell me the build command you're using to produce those errors? I have ran the builds on my test machine and cannot reproduce these. Thanks!
> Dylan
> ________________________________
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Friday, June 27, 2025 11:39 AM
> To: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> 09/06/2025 23:19, Schneide:
> > From: Dylan Schneider <schneide@qti.qualcomm.com>
> >
> > Allow the user to specify protocol link type when creating pcapng files.
> > This change is needed to specify the protocol type in the pcapng file,
> > DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> > for other protocols to be used on files generated by pcapng.
> >
> > Includes a breaking change to rte_pcapng_add_interface to add link_type
> > parameter. Existing calls to the function have been updated to pass
> > DLT_EN10MB for the link type argument.
> >
> > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> > Cc: stephen@networkplumber.org
> 
> I doesn't pass compilation test on my machine:
> 
> Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> 
> 
> 
> 





