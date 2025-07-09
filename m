Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C790C83F14
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 19:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53A640654;
	Wed,  9 Jul 2025 21:57:29 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 430634029E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 21:57:28 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9C21114000F9;
 Wed,  9 Jul 2025 15:57:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 09 Jul 2025 15:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752091047;
 x=1752177447; bh=ZXpfSDieRyIPoS8hhuEa8gyhysDrBtC/VpZlLdl/ErM=; b=
 Rz+7/T8D1w1meF9Q6phAP67AbPLLuFhurK2cJGzDK3GvR2kybMpM+i4NRqHivF6P
 PBYa05oSxh4Pl2cUpkebAZB1oaK0gh5D4ktmvvOci0zyj510Fsemyg+zjjan6nP2
 NS2ZXkHQclFWlbnJp8FzeAM+HUmyOZTlrn2TZoGS688CWN14uYajIPHnx6ilm2t9
 OERomneN/NrCaEsw4ECSCZ4232ssXMwD+4viPpS26BUGR4sS3ucIdZRQTtNEEEsX
 2I2O9q/xxfxqLA8rjrwcrr0j1pahSx34NZv+YvCwYP1pZIPEsp+SOXC250+DoNqE
 qIhK1O1PtLbiZMy5X9OUUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752091047; x=
 1752177447; bh=ZXpfSDieRyIPoS8hhuEa8gyhysDrBtC/VpZlLdl/ErM=; b=a
 i/ModgMdhqeUscHUQEB0/Hit/LdD2X8A1SjBAgC3ApCbUyH8KU9Md/wGcGKnd4+w
 jyUJLJ6+EX8r9Gtr1PjVRFXve+FMW3w9Dw9ct+af7YiByScOFv3bNoEbAzMnaw2y
 48x1ZcIalW+pTITXeijQKB4fKBumRNAVSypleLLdFA7rRpYWNLmsArRyZrR37oZO
 DT2CT8+c+sMsJ2C86PeCgUVK1MYowdCDyGSIdtkLPWhN3elLdRpRZy+CsDat/5FY
 u73SZQPUJnlKnlP2wdfm19yUs1JHE8xDhgnu96m8RHPsrmv7tEN4jvOV7UK3SE20
 y/8smEmFJWmU20gX3Z8Bw==
X-ME-Sender: <xms:p8luaDMB5BVzA6NtVVFOKfsT9isahx4SjhLh__j7gA2SYkgA8qeODw>
 <xme:p8luaEul7wKkD0_3KYJMVnXXeF5ljIQ_OCRELgIFxkGGN6_28wMlGahH7ZciGg8GI
 LPgbW7CpSpjimxpNQ>
X-ME-Received: <xmr:p8luaECjYiwvwaN5OTDJRdzG6W-0xOPy-XRnQE37pR_RgdX2zV4Le_mXLZTxV-yACAoxxAMgnPeljx7kgNI_UnJkUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvgguuh
 dprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvughupdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtoheplhhutggrrdhvihiiiigrrhhrohesrghrmh
 drtghomhdprhgtphhtthhopeihohgrnhdrphhitggthhhisehfohhsshdrrghrmhdrtgho
 mhdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgrlhhlihesrghrmhdrtg
 homhdprhgtphhtthhopehprghulhdrshiitgiivghprghnvghksegrrhhmrdgtohhm
X-ME-Proxy: <xmx:p8luaDbXyAoFOO5fTcUR_xxsGJjL41ndhPQUUOjCFJCJ1racigeDdQ>
 <xmx:p8luaHXbMlAxfBRUqQsnEpODaQFO5AfqzMYveDMUKUDMzl8ysinicg>
 <xmx:p8luaKO-Lh5R0xxEx62uio7kFq6mSkE3P9t-p82UcctqXx0xf4KbAQ>
 <xmx:p8luaJZTEwNYYxuVb7y6nUsttlTVuPzJfJTH6QeHgOU041bMyaVOpw>
 <xmx:p8luaNLMQIWlD6Fl6Ew-NxX33cvTiOrE64KlWATRYNWgX6CvCKJhy6ZQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 15:57:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dean Marx <dmarx@iol.unh.edu>, Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Subject: Re: [PATCH v2 2/2] dts: rewrite dts rst
Date: Wed, 09 Jul 2025 21:57:24 +0200
Message-ID: <3827624.axiByQ7kbq@thomas>
In-Reply-To: <CAJvnSUAGND5nTFHp71_d4ELqY20bcLC8Oc-OAhWz0V1jcpvOhA@mail.gmail.com>
References: <20250527153734.368235-2-dmarx@iol.unh.edu>
 <20250603172827.458725-2-dmarx@iol.unh.edu>
 <CAJvnSUAGND5nTFHp71_d4ELqY20bcLC8Oc-OAhWz0V1jcpvOhA@mail.gmail.com>
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

25/06/2025 06:07, Patrick Robb:
> Applied to next-dts, thanks Dean.

I'm almost sure it has overriden some doc added recently by Nicholas Pratte.

Anyway it is too difficult to understand what is changed in this series,
because there are too many unrelated changes.

I prefer not pulling this series in the main branch for now.
Please split the patches with clear explanation of what is changed and why.

Thanks


