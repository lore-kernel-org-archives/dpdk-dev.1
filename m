Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C4C87FCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE58140144;
	Fri, 25 Jul 2025 15:53:50 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 8EF82400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:53:49 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 144841400338;
 Fri, 25 Jul 2025 09:53:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 25 Jul 2025 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753451629;
 x=1753538029; bh=g2AfNu1KAqGYWFfFW1/pbfdbuTkaM/cv02tIarOR7sQ=; b=
 Gf6bmTXYrvOHrn93++lc7AZuUoIZvhfPcC/W46vjLYF2frc4lSXIv9EEhqdyBjHo
 u8IBH1NQRecWOyskpxc+2mVLSIFCz8Ynos4D/13io1Dk9hPaek2xSmLTIy3Uv4mf
 M2SluHgHNZTzJQ3V7W472FKtVgRSAwKWNhNYL4NFNCrMDKxzBrWUmXUjddwSJaya
 Ijc5MzY78lTsPXpDqA7m1lN+b4qhxis6HKJauLVuRJlXQ6KbzNUv4+TJ8USi30DK
 8JYqC6GuYRIaWotEe6diLRa4b1I09qBIfgFwz6UejmI0bDZ0+wKzVJoSk5BNTYw1
 0zsuz3KdwxGGknVnxNW3VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753451629; x=
 1753538029; bh=g2AfNu1KAqGYWFfFW1/pbfdbuTkaM/cv02tIarOR7sQ=; b=Y
 BZ2Prk19ICGKDEBfoq1M3qjAoD4N4E1xqsS9Vpz/DXhOMZMnOlhs6yd+D6xaNKbE
 AlyV9Qun7s+szCPJDaevNQ8Adb0HBrzMP+8gY58m1vNdIZqWC3iM/mkOeHag1s9a
 ig/SB9rY3ayfgb48F7Ya7XDYJUO4jF8PAfU0cZG4UJi87uocdbdjsHsDir2224DY
 +4UEP+XdXKVe82MCpdk+mAmlUeH0X5HbDKsdU9fbD2fsIYdYKvQWuXFLCr08JNm8
 3FAoJg4ViDetM20WsMrtBkZC4h11PqaZGL4YS2vAcxZgQwMdEmh3VCBI4XxAEdCS
 VdAVtvyQYqbzBrIC6FrsQ==
X-ME-Sender: <xms:bIyDaPM1W2c0v8DUWAbi3QLyoyisTMMxtqin30BRQ5xG7-4cGxJdYA>
 <xme:bIyDaEhYPNi4CRVYJl0veV5udahbZtMoSAfJY3drt0aUev7pMWpYI7TVs6mZXbxas
 Y74iHLc151CgfEK9Q>
X-ME-Received: <xmr:bIyDaK1UgvS1IUn0TmUWn_gw2NyPyKYnpf1geyHaLoLfqOfCLHrZR58lRbdukHkDua0egHGZBlOuM1o5qyeo4n34dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrrdhvihiiiigrrhhrohesrghrmh
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehprhho
 sggssehiohhlrdhunhhhrdgvughupdhrtghpthhtohepphgruhhlrdhsiigtiigvphgrnh
 gvkhesrghrmhdrtghomh
X-ME-Proxy: <xmx:bIyDaGixTvb7QZELfAN4kvrmeV0Kb8zbdlxnxhGTvm1d0xUtOEGzGw>
 <xmx:bIyDaCdHW5089q_phC8IzC40olk2NphsPrt5OO00HIyf-xW9sP2MjA>
 <xmx:bIyDaBlpqfOeKLgjucxs6NTuK8FKESRgRbkWxe9PoNQd2WXTVjUWoQ>
 <xmx:bIyDaDscx5-wJ8OwBJFoxNulLOZVBa2IyZRnTJ_Iwvw80huYh38JaA>
 <xmx:bYyDaLWsG5oQaI2NaUPCJQpFiS1q8hxYua5xdxRso3EvfYPeL-n1RXXs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 09:53:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: Re: [PATCH] maintainers: update for DTS
Date: Fri, 25 Jul 2025 15:53:46 +0200
Message-ID: <6776419.tM3a2QDmDi@thomas>
In-Reply-To: <20250722160529.2659392-1-luca.vizzarro@arm.com>
References: <20250722160529.2659392-1-luca.vizzarro@arm.com>
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

22/07/2025 18:05, Luca Vizzarro:
> Paul is giving up his role of co-maintainer of DTS, electing Luca
> Vizzarro in his place.
> 
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>
Acked-by: Patrick Robb <probb@iol.unh.edu>

Applied, thank you for volunteering.


