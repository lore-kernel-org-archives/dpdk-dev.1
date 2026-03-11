Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC5B1125858
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACAC640A76;
	Wed, 11 Mar 2026 18:08:38 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 7E8B74060A;
 Wed, 11 Mar 2026 18:08:37 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id E65B51D0020A;
 Wed, 11 Mar 2026 13:08:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 13:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773248916;
 x=1773335316; bh=UFkOOa5JciZox9me0NpdAckwy1DydyDptKuX1/kZ7WM=; b=
 OPnDUCCCoDIqIlqUTcr4WuqgPyekswQWfoZKnz0+X4/1XpL5n+Nt1a9j/FOicED9
 fkfd7rXJKznsHb0uO2E1HmUAdS5HdFnXIlmYdxWXEzbba6NdOpZ1Fh6RCVKGmgEs
 ToP6XVSlSYcCkJCDAJGO6BsduUuFUNOdtYZyKfZLw4Crz8Laf2J5VE2MC5mIJn8/
 fYv4voP2I/DJwZusF8G3tirmynbX/ow2q8yr5r89WX5A4UavwiUeNEzURQaFvwMe
 svZfvYzRHlbiDi8jsUIM/e1Kx83qRc0uNdfQCW0IQd8Ps+wIaRWPtmi/MmyInpJB
 3SI+nioKgdL8Mxo/x/Qa5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773248916; x=
 1773335316; bh=UFkOOa5JciZox9me0NpdAckwy1DydyDptKuX1/kZ7WM=; b=V
 MA0PfpXCuelUreDs03EpfbKzXU8dw2vk399cDU1OiyrsQgGwh5y+Nt1iz4220hJs
 BpmJZhwmc+kC//S8fBMmLCqzmGhwRvVju4zp2OhNDIrwwCfu/fACcdBoJl0aT9m4
 BgI/GkNNanqQ3mX1cWlRIRJ6liemV1dqAkih2P11e9mr+ynkxv/gmFx4O02A98m5
 lU80FXA/jEBnQdsss6dzPDBlDYuIPuHOn2ZBBYXuAics3qSNpoRWF2Iq7/ZH4V9S
 G2WbIGh09lFdmHA19gviU16HN1h63WmvSdxwgnt6McHtPROyXimbdC6DjUJbqzVD
 y9Lwx1UuL4AxtLLrEpU8A==
X-ME-Sender: <xms:lKGxaUsnWFJnEXEN9CbhheIRVps9N9q6MUsxMixA8sqCsIka2Dc9mQ>
 <xme:lKGxac5qkNTg_OQsNic91qPt0Sw1WMI54--IGR7pVZT8HPJ5KUsHWmebNmX6XNBMz
 5Bgyi7MIdIkzPZfCKJ974ldRoo6nkjgvou2-k19QBc-hRHxhRZc-w>
X-ME-Received: <xmr:lKGxaTShReOdEGYnDNNRyVsoikDRSk87GalrwG0H4HAa5kHb-T0GitkgJ-CdlSA3HQAWUjbCklx7U6aKx64kZR8q9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvghgrnhdrfhhrvgihhhhofhessg
 hrohgruggtohhmrdgtohhmpdhrtghpthhtohepmhhohhgrmhhmrgguqdhshhhurggsrdhs
 ihguughiqhhuvgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthho
 pehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:lKGxabpBlyJaQ0MyFmX8RGcM1lrdqPxDzZH9bShkMQdosDQBYSv8AA>
 <xmx:lKGxaRKr_iXzz8HKR1SlLD5BCG1zNou8fIzl4x0jtrbNRF15SGBiBw>
 <xmx:lKGxaeosWtH6DA5ngWn2BTidg9knKLVWXdNAJD3yir8aGCMvI6qvWQ>
 <xmx:lKGxaZwYjbCBwRjIUz4yNP1FqUgYxgB_6t-q5hRTdCCqb-kKO3BwpA>
 <xmx:lKGxaQu30lg7mcbpTEhpFDIcQnU1cyHy-WiETHwYHkxsFVhdgSdIBEE5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:08:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Keegan Freyhof <keegan.freyhof@broadcom.com>
Cc: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 dev@dpdk.org, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: Re: [PATCH] net/bnxt: fix reported VLAN stripped flag for Thor 2
Date: Wed, 11 Mar 2026 18:08:34 +0100
Message-ID: <5082683.31r3eYUQgx@thomas>
In-Reply-To: <6ec6e43a646c4ae0c22ac3330d4c346b@mail.gmail.com>
References: <20260227202042.71404-1-Mohammad-Shuab.Siddique@broadcom.com>
 <6ec6e43a646c4ae0c22ac3330d4c346b@mail.gmail.com>
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

> Modified the way that the scalar path reports VLAN TCI and the
> RTE_MBUF_F_RX_VLAN_STRIPPED flag.
> 
> Bugzilla ID: 1868
> Fixes: 65d2b0557ba3 ("net/bnxt: support Rx completion v3")
> Fixes: daa02b5cddbb ("mbuf: add namespace to offload flags")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique
> <mohammad-shuab.siddique@broadcom.com>

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Applied, thanks.


