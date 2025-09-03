Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785BFCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:24:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C802C402BD;
	Wed,  3 Sep 2025 17:24:47 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 6202440281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:24:46 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id ACFC17A0412;
 Wed,  3 Sep 2025 11:24:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1756913085;
 x=1756999485; bh=q4d/GuCsjj9X1BCICy8clP3GuN4SICNYAzhN/7SXiws=; b=
 ZRSX6JA3stBl1Bn7M6Dxy4+62K78miWjVbU+kVCTCFtQqCVw03Q4coJOsdvYEA5z
 S4okW1fOYtshlsR2RGnn9eBZp+jyEU+zgROCoMCIQrjqpB5YeZ3EEt2z4SnXrm/X
 voPv1ySRjjta2U6xCgstRQ033LxTJ6BMOYkMnzNcjCopXxvwCsOinFOFzn6l4gYB
 gw6THwe+AWmdnWiJddMhY55ZzJOHyM/r5ypFq+4KBtJyWF0MCqtldDF5slTtAOO7
 Zagi1FfPknkbo7T0HtvavcI6jMwWtOlzBi+85APvlaoInC+F9HR4aHKCZ/jwuE/T
 CJZ5L55KqRTOvAokDe7RsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756913085; x=
 1756999485; bh=q4d/GuCsjj9X1BCICy8clP3GuN4SICNYAzhN/7SXiws=; b=m
 wYDwFUTBmIr+giWbVoG/DWGJEdJiBWOcNCuh97vllkj+x3vxdmwDnAb42x/vroxf
 GIJPKCcbbfASiXWMEIPScy/BDjS/Bo5OzfDEn5Gj9Ykrm/ijKajPuQqrjNzKs3H4
 dihzBtzw6zxjVxHtqT27NMPFe2h3HfWllKhseax18/7HO5WhrV1IAJY/wrpUw/NS
 7g7FlUXsCFwMQglVOIMBkN0ydGGoxxazYzVJHGYvwAfNAwSjpkUYYnzwOArBsRHc
 fSMU7bBbhgS+4+FTnT6nStwuL6UO4HVDe5C9F84zwaiM4J5Jt5nqVLsBmOnTP0Ne
 UUOfmzzJG6FgIl4sPp6QA==
X-ME-Sender: <xms:vF24aEL-UttM0KuELGxXYOqI0H2bqAsAjZGcipccBS3u3JztgoUSrQ>
 <xme:vF24aNxAMm8mIuM0imHbmt4acyH2UJm65cHOSXrqCfCrbvVr9BX68EDweMVMBv09I
 GL2WZgMwo6CeLlOPw>
X-ME-Received: <xmr:vF24aEs9TcO3LLNAvtZIbmoYMPynju9GJsIALhOxNRmn2peCBPxPm5eJASCy_60rhP3c0ru4pM6FeiAmah4i9rbzTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefhedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehmrghtthhhvgifrdhmtghgohhvvghrnhesmh
 hitghrohhsohhfthdrtghomhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhv
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:vF24aEuDlkyxLO-rvzsU7a3X5oTmP3AtC2xYJKFOZzos2kHt2k_AqQ>
 <xmx:vF24aJPM-dHWbEBZGYiDvOG62bn2QlHYULgZebpPkW_jfalWnD13FA>
 <xmx:vF24aC2oDVEOqg3utpoe53JTFpXUfjODPh4I-eXReAiJbBYb1vnFAg>
 <xmx:vF24aFOK9uEdoH0bHlGm8rU6wZDNPERuly1BVEL6nWPosWg-omJLww>
 <xmx:vV24aMC7wLzdGbVCAdKqOR-oedjlW49Ol6BE5zc3UXsvVlWWqSc3ZaU0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 11:24:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Matthew McGovern (LINUX)" <Matthew.Mcgovern@microsoft.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [PATCH] examples/symmetric_mp: log/ignore
 promiscuous fail
Date: Wed, 03 Sep 2025 17:24:42 +0200
Message-ID: <2049297.2IRrRt1zHL@thomas>
In-Reply-To: <IA4PR21MB54098AB9BBC8C4CAEE51148B9001A@IA4PR21MB5409.namprd21.prod.outlook.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
 <8729787.zIJbB62Pao@thomas>
 <IA4PR21MB54098AB9BBC8C4CAEE51148B9001A@IA4PR21MB5409.namprd21.prod.outlook.com>
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

03/09/2025 17:09, Matthew McGovern (LINUX):
> No reason other than to keep the patch small. I'll add some additional patches for the other apps. 
> 
> -----Original Message-----
> From: Thomas Monjalon <thomas@monjalon.net> 
> Sent: Wednesday, July 9, 2025 7:30 AM
> To: Matthew McGovern (LINUX) <Matthew.Mcgovern@microsoft.com>
> Cc: Anatoly Burakov <anatoly.burakov@intel.com>; dev@dpdk.org
> Subject: [EXTERNAL] Re: [PATCH] examples/symmetric_mp: log/ignore promiscuous fail
> 
> 20/05/2025 20:37, mamcgove@microsoft.com:
> > From: Matthew G McGovern <mamcgove@microsoft.com>
> > 
> > The example apps have a few different failure modes when enabling promiscuous mode:
> > 
> > - testpmd will warn about the failure and continue.
> > 
> > - l3fwd has a flag '-P' to explicitly require promiscuous mode.
> > 
> > - symmetric_mp will exit with an error code
> > 
> > This patch changes symmetric_mp to warn and continue.
> 
> Why not doing the same in examples/multi_process/client_server_mp/mp_server/ ?
> What about other examples?

I think it's better making this consistent across examples.
Thank you for working on this.


