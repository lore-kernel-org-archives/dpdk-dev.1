Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36193CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D6A40611;
	Wed, 24 Sep 2025 16:06:13 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 4E88140289
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:06:12 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 489667A0166;
 Wed, 24 Sep 2025 10:06:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758722771;
 x=1758809171; bh=qDT90y0tW74BIBpBZ2fS2hEZ4cdekp5MK8dkpajXNRw=; b=
 IzqjQnvCS8mas7mSDH3ESEQKPU1GRqR8D/K+MPQ52Kd7QS+49Mng5eROFr9GvdIa
 fdwM5oGJeIwE/pzsx7g7pawl3x9Ni5EvszHFQv5tG4arl9jBGf5hIZUPaEm7FxNX
 GfZ/RwuJulhoxrGP7f3Z/tkojr08vVnXij6EX/2GFp9N+bdDmsmiHkBcBFG153y6
 +hyUekEr6L84O872jy74Sy+2KHLLQ9OMPQJQ7pUUz3biQx2cpvsiPmUdIuZwmct+
 llcEKuVcBkI96KPQUscQJp3FbQ8+q8n0RIDFsPuouW/4F2U3wiDqr1qY2WZdAdPX
 kAOMCM63JgPzcvXLBro38g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758722771; x=
 1758809171; bh=qDT90y0tW74BIBpBZ2fS2hEZ4cdekp5MK8dkpajXNRw=; b=i
 ripKQX55spl0kaytnxyVKplCxSy9Nog2Yfc0hM4qDZ6NtxCnCP8cqBbDrzUuko+b
 1PBczgUJwI+mjwUoNwlTRlpW1GkDVvZJcV8/hvib8XhnS0Wp/4OZ4g8xqOqStJi6
 oPNVGN9WC367IT5qqpV4Uh+uD/mFydalTPt1y8+Cic339ElysZgF4MsiIeK3xoCC
 1uFKnlfPJciOYBP+EDIBybmdbfvkYRLRHFHKS95EoDqJ2uO++HN14N40wLON6JY1
 lOI1sZN5y6mXrszV8K4jyS7K4I8j1dew6cE9Dw+lx0AUJ9+q+GgahZUriLpvReui
 j2syXGlnyKE1J8JEgeeMw==
X-ME-Sender: <xms:0vrTaPlMAS70kaYqdzQA81hq95ehCK4yiiubkD9HrST8OOzRk-ovZg>
 <xme:0vrTaNyacTQ8_d3_Wwk1F_9ubuRV7TWfzzXL2iBR-k35DsA0LXtl3e6-G7LldfNHv
 wbxEH5e5EzCdO1r7fIyfRqa17gyL1PvlNmui6U0iuJG66XmYhm8QA>
X-ME-Received: <xmr:0vrTaEoOWf57urpmOb5vbzMiKMDbqFpifLxVH8KBhj2pzax9l11cSC8CRZ52xlY5E5CJFYQ4lC42ecXaoChHrI9fZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrgh
 gvsegrrhhmrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehi
 nhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 eplhhonhhglhhisehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepfigvhhesmhhi
 tghrohhsohhfthdrtghomhdprhgtphhtthhopehnugesrghrmhdrtghomhdprhgtphhtth
 hopeguhhhruhhvrdhtrhhiphgrthhhihesrghrmhdrtghomh
X-ME-Proxy: <xmx:0vrTaM6Vx6W_eJhGbfE2siYzYl3TDR37NheVvKOXu8pnhqIoMz0WJQ>
 <xmx:0vrTaLe4vY_tFmLnVZX1VhaeE0eRpaf_JL2F-x393o7nx5u5YZJmHg>
 <xmx:0vrTaB5-HzGAmiNmHSRGKx01MqkcIX0cJr6fgqfWdG3NmijzJk8Juw>
 <xmx:0vrTaCt7FMXKhG97eA62qt-qEphz7FjID0qMlUvZwQ6w_xPkA_20KA>
 <xmx:0_rTaG_G3x9Wz0tBhFchcT-Ch2967LdTKH9u-9BvIKmx3gzRnnETHfBy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:06:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 longli@microsoft.com, weh@microsoft.com, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH] config/arm: add Microsoft Azure Cobalt-100 SoC
Date: Wed, 24 Sep 2025 16:06:07 +0200
Message-ID: <3629974.q0ZmV6gNhb@thomas>
In-Reply-To: <20250723185349.4116573-1-wathsala.vithanage@arm.com>
References: <20250723185349.4116573-1-wathsala.vithanage@arm.com>
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

23/07/2025 20:53, Wathsala Vithanage:
> Add Microsoft Azure Cobalt-100 to arm build.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---
> +soc_cobalt100 = {
> +    'description' : 'Microsot Azure Cobalt 100',

typo: Microsoft

Applied with fixed typo, thanks.


