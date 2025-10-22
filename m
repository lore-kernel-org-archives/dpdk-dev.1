Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B35CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 17:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6845240262;
	Wed, 22 Oct 2025 19:35:14 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0B2624025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 19:35:13 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 449201D0012B;
 Wed, 22 Oct 2025 13:35:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 13:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761154512;
 x=1761240912; bh=iTWhu0HhDWTajHGUql4oTeeLft1cNxaY4IJ4CFAya1U=; b=
 brzXjoccFsrGYOk++Q4lYvWrGdAxTpmZ+DwEHzp22+7g5XsbDsTwUcxUSef1zzfF
 X9Dp+QGNoj7XXvarq8QLDBQtindW8I76xKbBxk4cuxQeDy5jNQcxVg2qNC/n1meq
 RXe05RK7RxNaiS/VUA4csscIFNuxcR9IuEhtj7JG7ynW2Ssda6Nh9Jb/AZ/ZxjBj
 k/0L3KrNPdYLc//3cqXp1j7DhiTf1pz0HmW3McPccbXDC8LfpI/eOMfYDjvXBN4b
 qKUVUVkmDAcPGbXwndepGzt2X+shx7fk9Lm8wvFZxbMdwfQWPJu2xqqB4KvTAruT
 WpakPf8JnydEeG0pZ/lnaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761154512; x=
 1761240912; bh=iTWhu0HhDWTajHGUql4oTeeLft1cNxaY4IJ4CFAya1U=; b=S
 T1bQdURQbJ/aPTS/c4BE2OZOCpxjAB9QG9cOF9z2g9/rUlWp65fl0wtNbJZBz47T
 oX4BleYYdtWy9M+Ri7n8MQv4Ro7q25F2uB0C1buZCrq7Hinto4nEkQuQ3S4gCuM6
 D1SlwuThszDSpzOfLW8KaW4PgMWCAaYAwChZRlEwvK9keBalrewVozhgjU7sdgs0
 NMWAPlVxjzKR9MVsokjBPtSyDditfiCjXUYx7e/1LAjV5CBvlW31zf/wbQImp0tL
 jIFd+Hbckmg7KnnyzmAf0fuwUiXGh40oM5GKG8UtHNiotnDbrI8cQnqDrgiXzmOy
 hq44FD1lL7tZ4oJPBC09g==
X-ME-Sender: <xms:zxX5aO8pcTUfyy4ONhscdA-OqYUpKL9441hgzWkfGgG3McuxyB8pRQ>
 <xme:zxX5aHruK1uqwrDtu4surarbKhaUgiaj-2IXEjFNbcvR1_JjVo3oBA4Oty3ylfj5B
 5c8jXjRrzvqY-g0kG-YFhlLIjtqiuXkH2N0VOZ74xf6F0W6JdXLdg>
X-ME-Received: <xmr:zxX5aPltp0R_Cx7sWteRnU9pWX3YZ3qzBwEhVls_WY2l6syh3EyMZ9p_iTEIEw4skb8pxEYga9W4qs3QDo_ENG1eIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 shhilhdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhkohdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhr
 tghpthhtoheptghkmhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepshhtvghphh
 gvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:zxX5aGjKFO8MgRPPNx-gNwTuaAmspEeA-erikFg0t7yTUjV94LcSBw>
 <xmx:zxX5aPf4VoqQiYmhi6rYkSXGtlpUediCns9niPQoQOI4vrS3UBTpfg>
 <xmx:zxX5aOhaV6QF7CWdb5AwqfOKvHPnPiBai_QNqpTv3yQYLwnHxSHLvA>
 <xmx:zxX5aPzzM9l1BbJPFt9YdloCKWA7y1hNz1n2kmK7uoxn6FKVQ7B6xw>
 <xmx:0BX5aCLre7GTFLiPI2ve8thlm-aAAPxJuot82D6o8Mq40_GuIaIjxmjO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 13:35:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com,
 ckm@napatech.com, stephen@networkplumber.org
Subject: Re: [PATCH v1 1/1] doc: refactoring the guide for NTNIC PMD
Date: Wed, 22 Oct 2025 19:35:08 +0200
Message-ID: <3590447.BaHzMo0RvP@thomas>
In-Reply-To: <20251022164015.507050-2-sil-plv@napatech.com>
References: <9256303.5OynTdThKG@thomas>
 <20251022164015.507050-1-sil-plv@napatech.com>
 <20251022164015.507050-2-sil-plv@napatech.com>
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

22/10/2025 18:40, Serhii Iliushyk:
> +.. rst-class:: punchcard

Nice to see this new class used.

> +
> +================================================================================================================ =======
> +Supported Features                                                                                                Linux
> +================================================================================================================ =======

Columns are too wide.


[...]
>  Following standard DPDK command line arguments are used by the PMD:
>  
> -``-a``
> -   Used to specifically define the NT adapter by PCI ID.
> +NTNIC-specific arguments can be passed in the PCI device parameter list:

So there are 2 sentences ending with a colon.

> -Service API for user applications
> ----------------------------------
> -**rte_pmd_ntnic_service_set_lcore**
> -**rte_pmd_ntnic_service_get_id**

That's the kind of things I've already reworked in the main branch.

Please start from a fresh update.


