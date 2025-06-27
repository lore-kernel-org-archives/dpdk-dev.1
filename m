Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF029C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E858D4026D;
	Fri, 27 Jun 2025 19:39:05 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0E309400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:39:04 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 910DCEC01B7;
 Fri, 27 Jun 2025 13:39:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 27 Jun 2025 13:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751045943;
 x=1751132343; bh=QoWjgEA3xPzCLP7kyv9FGpC4SOxnKdwPoXS6F35W/XI=; b=
 zYHt+ESzLKEuSDw1LvNWOfBxvY+lrE5JSfvHY/ezwsIBpxJaQgabPjZI3ojN0x7J
 4xQLUZTJzAFFY9S+ojwCwLPHXQtjtnW+2v3mV5qr5fgX3rS2HcjOLjSFfjZ/11vr
 vIQ3x8lPW227UZDd3ij9Fmo/q6lL4QE6PVNRrt+oNu5Q0AXGIl4wv/p+uN9K5SDa
 EzWWudL0YHkN9E0Ovrt9lk0slMhnrZVJhN5Bq2D28VjCHQZrwB1yCXndqwc5ZPaU
 vAr+hipyJENs08YWou1HZpPezddrr2rPgzJKjvhF8HEPUTnn0aM6H59bBuCd3a86
 KqF/fSFfJ8JFTBLGbMmSmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751045943; x=
 1751132343; bh=QoWjgEA3xPzCLP7kyv9FGpC4SOxnKdwPoXS6F35W/XI=; b=I
 GkMcOwiQfyzLqMq03yiK2SrC684nj92Mhd1HJ7bn5LYPtYD5ITEIkULwTcEKwS15
 T8OgO/eJbeCAwaFrJhFJEjpblw1KDWkqyZ6sqoAR/YXCYZ9D/57GjGMhp0ofhmWm
 I/r6Fl/PzawglFFzND/hwqsSOholw96xHYzcqwSTh/AB0MMjEHBxHlEFfvtmA9iX
 etGrzLPeckbWMyEvef+7qM1b0mlT0v/1QtcB5/JypWamle4lEGCzu7DjsH4Nkx8x
 gSjU3GB/uMRXGhMntN6ejhQlmjRc3EFI37HQsZwKqvIi7NlhH4vnmS35y4lqwsOj
 4Uf8Vzuq+AM6pyrP9WRsA==
X-ME-Sender: <xms:NtdeaOXIvIQF8okPO3k-iXtk10610ByHiaFcpStnuhxuTXW-8G3pKA>
 <xme:NtdeaKlj8TFwNs768UxN98iXMrhT3Hm-j0kDW7yDKUIchW5nvYDUANMhgfWXnJIkD
 NDJMUlhpO4Buy--pw>
X-ME-Received: <xmr:NtdeaCadfYgRFjPamIE7zp5XvhlKcPIKFVVgfnvVj6mhKzEuiOp05Ca6-Pj5q3iWJHMTI9qk0YbsE3LHUqdcy7sOPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:N9deaFV5lxDSTH-OfcfzOjI-xbhTOR-UHcVXfSBSJQuft_zgH_p7xg>
 <xmx:N9deaInLIPRqSNVN31EkokThSrQAXryAac2kCIFQxoWcZwFsDoU4hQ>
 <xmx:N9deaKdbBlpcct1WiF2KjZ29Z5gaSKc0ClzqxfnPvaAHQjXeeYyueg>
 <xmx:N9deaKGhns2dSHFRZP2Ig_Thb2C5OYlFWD8V5PrTDUZ6Zdote7kADg>
 <xmx:N9deaMI14gXJUqh5522gEP5UGXkLA2T5_leK2Bt-QsV5VNlHoZfifFtp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 13:39:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Fri, 27 Jun 2025 19:39:00 +0200
Message-ID: <6923574.A9s0UXYOmP@thomas>
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

I doesn't pass compilation test on my machine:

Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install



