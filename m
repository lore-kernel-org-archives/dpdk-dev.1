Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E446CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 08:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B0EC4025A;
	Wed, 17 Sep 2025 10:49:23 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id A035040144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 10:49:22 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 1F357EC0122;
 Wed, 17 Sep 2025 04:49:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 17 Sep 2025 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758098962;
 x=1758185362; bh=A7bJ9nxNvGasAMiJ3KA6rRLAY9m3ynqcQBqwmEIio2M=; b=
 QhHCgKfRxnktSnGAzliBimV75gbyHVQYBJEuaO974qrEsi7cFdWCHP0ZBIwtutDW
 it0gqPjzfY6g7Ep5lcTdTUuDtrGplK2p9EDk6WGiY9YSY5t7pp7/gfHqr6J+0qEU
 xekudpXYhRkSmAHvG97/i6zfb7TFMZbcToNknXTDTombrgrWVOcrnNvwC5rXhpGo
 202hYrJPYVkDgK55dLeW/prwCcXAb28U9AeVuPrxvqlypSBVQZQy8czDjsjWDNg4
 6XXoEoB/vKRIgDRe4cgh/F9OHI64+YMQTJAz7V2MtOEoGXJOF2iRfunvOwtGiZoa
 oqWuQFZ3oD4sDy/o0iT5Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758098962; x=
 1758185362; bh=A7bJ9nxNvGasAMiJ3KA6rRLAY9m3ynqcQBqwmEIio2M=; b=m
 W7n2a4FD/ulQLys489agxLFdR67qvc9mh/GXl5E0BP6SgAPDK9y2zDkYAU/xooEm
 h4iwzBsllpzknF1UAm3NYbZeR6S7Str5O7lPTh4SLVR0Y1COlAkrD+xQNg9WKbkb
 1flhe3ctL/+fhk7vXW5HeHarQZKZNRK2rxomZtaqa7bUwtdLuvrLfVWUD4YGj+Ir
 zGJT/JjJN6BsJNlsr/EG/aU9uXMh5tWsmg2rSQqRnA9RLuecAM4PTZlBr289CSlQ
 nQJGf4zRrYwh6aS/iXsZntpO/MWLl8jBTqjzcCxFik2nr4q8nwqJ0n9cE2hc9CxS
 O7yLOk/8QsfGOE0pi9wtg==
X-ME-Sender: <xms:EXbKaH5QPACDYEZYhcAXw7sK-v37117CN9vbs89gaDQ_QjsBjlk5YQ>
 <xme:EXbKaCKDJtG49vfhoNO9LXwmoE35H9BcB6P8dPa_vIPYkBArnT4o0OEDEa0od9MK-
 QyZAOZclgJBJFPd2w>
X-ME-Received: <xmr:EXbKaAIBIt-RdivTTzyKM0nS8c8qifIGapfIkM64ZGrPVswL4lbhKBNOrWdvkOV9kR3PxiVcOmRuSl1WqccEAtSivA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:EXbKaAUwg2yzQjm1VlLadMaxB3Tjfvs0HmhNYaIajwmnUQ159qKuZg>
 <xmx:EXbKaCg5dtPghxGFO2IejW9hZJ2nKtOeeWWyhcBJTDW_cv4pKA-46A>
 <xmx:EXbKaL_DVosnda9p3RFk2XEZeZyP8kumYHSO5xPVyKwSTTi2XJqWaw>
 <xmx:EXbKaMDdevvMrKKK9DS73EirrfJUFtfuEErrQGachZLd9CCIeAaWHg>
 <xmx:EnbKaO7mzF3yl83T3xCwqKGvUpzwt4LsK_mQhz5bZRJECOk3i2802IJA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 04:49:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] eal: fix DMA mask validation inconsistency in IOVA VA
Date: Wed, 17 Sep 2025 10:49:19 +0200
Message-ID: <3107280.irdbgypaU6@thomas>
In-Reply-To: <20250908163456.420268-1-shperetz@nvidia.com>
References: <20250908163456.420268-1-shperetz@nvidia.com>
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

Recheck-request: rebase=main, iol-mellanox-Functional, iol-compile-amd64-testing, iol-compile-arm64-testing, iol-unit-amd64-testing, iol-unit-arm64-testing


