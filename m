Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E142CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 09:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1255140264;
	Mon,  8 Sep 2025 11:23:15 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 9166E400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 11:23:13 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 70AB91D0008E;
 Mon,  8 Sep 2025 05:23:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 05:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757323392;
 x=1757409792; bh=xGsMX548q0s5ddBHlMX9ASStVPH/y3rPiQBg9B7jkhk=; b=
 cbr6GYnItlksg0LxMU+zjkHg3miK35C20r6qm7HW7G1msEB8qZpuj3ndcI1TIvlm
 Q4I2HAjGiHDKQyfyFsGJ2+PS/E8M0Ppl5LiZDH3msDUqfxHxU84luUH+kpnDuo7t
 T0Q7alPR7PtOkGWhRO0n6k/RdHTOy+RH6Tid0Z9K7dcLkerqFyhN5fw9tSOG8cBS
 mRgDVy7BsNmx8ue6SyMZSSuYrbTCZSIU04cyLHXEjM7uSE6sr11LJMQBsi8XV3xn
 +sPoSZ/mIEF1D2SYfhDBXAWeIgCp8xQEJM55Wg6TviebNmA12f9QTRhjsCFZLJt/
 xIn2h02CuZkviahCW7ppsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757323392; x=
 1757409792; bh=xGsMX548q0s5ddBHlMX9ASStVPH/y3rPiQBg9B7jkhk=; b=T
 GBIuWnLFbhZ2glSCaJ9J7wE+ee4TtrgkrfclZmmxUJ89WOk6yW0MGbPs35DpvMzh
 OVOwOinvwGSTaNhPIIATtSAoV0RFF+G05Hno1bkgV2/bJhsRN3/N/yHZzMOn/ri3
 IPNVtfDqCUzfQAnVR41pAt0VxhRmzvhrwA7WOqUbY8rOOgXX03/zvt6WGQxwUBy9
 Gm4C2STIbkbrXUYtywINx6p98CJDiH+5eAvmxDTxipbLE9iCwyH6zMQlO/UzSxdH
 1RA+RQlF/6tyr96zlQYV0p/q0EU5dPc87wapsp6y8t7RnypLbnT2nWLE2KVDgNRx
 6YUnj3SSD4nxKfUlEOnng==
X-ME-Sender: <xms:f6C-aNIf4slsKziq0Elxk5VWSEAT5ccbdGYm5OXUIRiCsMMwszlBRA>
 <xme:f6C-aHGAr-Wl9PUmKm6DqaDuOFzULsU0aUqpoc5dA2U5rBBzwOcpqAko0ZDouHL9J
 zvzZ1JgtwjaWs0H8g>
X-ME-Received: <xmr:f6C-aIB3vNY-AuiFH_euG1TBsdmL0JeS7nd6ujoYF9ZSS27zN06ek85LubSZfKcDRAxECTxiF8LCf_h5zKKiRp4Qeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhkohhrihesmhgrrhhvvghllhdrtghomh
 dprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrggsshdr
 rhhupdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepnhgurggsih
 hlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehn
 vghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtg
 hhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:f6C-aC88XzTJvw_YRIDSJ-OD0MG1kBHlYQBs79s117OcGW-9G5MGaw>
 <xmx:f6C-aMBJ4P108TXBgwKCmBnTNHKXosChp-9wTH4GFjD-rQmkCyXhng>
 <xmx:f6C-aPS1N35OxvLnY04LKzfcnnJ7QFU3EdPpZZXHThenNKtsGoMEww>
 <xmx:f6C-aLvPUa-oaP_KIiDMXX10oBKOaA93FNYjIDkubeqKh4xLRN3WQw>
 <xmx:gKC-aG82xGWk-6x1ygyBELDlw9Zhu1TVtA0ONPg789TXPKPCy_KFnRi9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:23:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunil Kumar Kori <skori@marvell.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v10 1/1] ethdev: add support to provide link type
Date: Mon, 08 Sep 2025 11:23:07 +0200
Message-ID: <5037037.31r3eYUQgx@thomas>
In-Reply-To: <20250908085256.1866407-1-skori@marvell.com>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250908085256.1866407-1-skori@marvell.com>
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

Hello,

The title can be simply "ethdev: add link type".


08/09/2025 10:51, skori@marvell.com:
> +* **Added ethdev API in library.*

Please be more specific, we don't need to group all ethdev changes together.
Each new API feature deserves a separate bullet.

> +
> +  * Added API to report type of link connection for a port.
> +    By default, it reports ``RTE_ETH_LINK_CONNECTOR_NONE``
> +    unless driver specifies it.

I think you need to explain what is a type (copper, fiber, etc).

[...]
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_connector_to_str, 25.11)
> +const char *
> +rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector)
> +{
> +	static const char * const link_connector_str[] = {
> +		[RTE_ETH_LINK_CONNECTOR_NONE] = "None",
> +		[RTE_ETH_LINK_CONNECTOR_TP] = "Twisted Pair",
> +		[RTE_ETH_LINK_CONNECTOR_AUI] = "Attachment Unit Interface",
> +		[RTE_ETH_LINK_CONNECTOR_MII] = "Media Independent Interface",
> +		[RTE_ETH_LINK_CONNECTOR_FIBER] = "Fiber",
> +		[RTE_ETH_LINK_CONNECTOR_BNC] = "BNC",
> +		[RTE_ETH_LINK_CONNECTOR_DAC] = "Direct Attach Copper",
> +		[RTE_ETH_LINK_CONNECTOR_SGMII] = "SGMII",
> +		[RTE_ETH_LINK_CONNECTOR_QSGMII] = "QSGMII",
> +		[RTE_ETH_LINK_CONNECTOR_XFI] = "XFI",
> +		[RTE_ETH_LINK_CONNECTOR_SFI] = "SFI",
> +		[RTE_ETH_LINK_CONNECTOR_XLAUI] = "XLAUI",
> +		[RTE_ETH_LINK_CONNECTOR_GAUI] = "GAUI",
> +		[RTE_ETH_LINK_CONNECTOR_XAUI] = "XAUI",
> +		[RTE_ETH_LINK_CONNECTOR_CAUI] = "CAUI",
> +		[RTE_ETH_LINK_CONNECTOR_LAUI] = "LAUI",
> +		[RTE_ETH_LINK_CONNECTOR_SFP] = "SFP",
> +		[RTE_ETH_LINK_CONNECTOR_SFP_DD] = "SFP-DD",
> +		[RTE_ETH_LINK_CONNECTOR_SFP_PLUS] = "SFP+",
> +		[RTE_ETH_LINK_CONNECTOR_SFP28] = "SFP28",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP] = "QSFP",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP_PLUS] = "QSFP+",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP28] = "QSFP28",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP56] = "QSFP56",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP_DD] = "QSFP-DD",
> +		[RTE_ETH_LINK_CONNECTOR_OTHER] = "Other",
> +	};
> +	const char *str = NULL;
> +
> +	if (link_connector < ((enum rte_eth_link_connector)RTE_DIM(link_connector_str)))
> +		str = link_connector_str[link_connector];
> +
> +	return str;
> +}

So we say link connector, not link type as in the title and descriptions?

[...]
> +enum rte_eth_link_connector {
> +	RTE_ETH_LINK_CONNECTOR_NONE = 0,     /**< Not defined */
> +	RTE_ETH_LINK_CONNECTOR_TP,           /**< Twisted Pair */
> +	RTE_ETH_LINK_CONNECTOR_AUI,          /**< Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_MII,          /**< Media Independent Interface */
> +	RTE_ETH_LINK_CONNECTOR_FIBER,        /**< Optical Fiber Link */
> +	RTE_ETH_LINK_CONNECTOR_BNC,          /**< BNC Link type for RF connection */
> +	RTE_ETH_LINK_CONNECTOR_DAC,          /**< Direct Attach copper */
> +	RTE_ETH_LINK_CONNECTOR_SGMII,        /**< Serial Gigabit Media Independent Interface */
> +	RTE_ETH_LINK_CONNECTOR_QSGMII,       /**< Link to multiplex 4 SGMII over one serial link */
> +	RTE_ETH_LINK_CONNECTOR_XFI,          /**< 10 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_SFI,          /**< 10 Gigabit Serial Interface for optical network */
> +	RTE_ETH_LINK_CONNECTOR_XLAUI,        /**< 40 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_GAUI,         /**< Gigabit Interface for 50/100/200 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_XAUI,         /**< 10 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_CAUI,         /**< 100 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_LAUI,         /**< 50 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_SFP,          /**< Pluggable module for 1 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP_PLUS,     /**< Pluggable module for 10 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP28,        /**< Pluggable module for 25 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP_DD,       /**< Pluggable module for 100 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_QSFP,         /**< Module to mutiplex 4 SFP i.e. 4*1=4 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP_PLUS,    /**< Module to mutiplex 4 SFP_PLUS i.e. 4*10=40 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP28,       /**< Module to mutiplex 4 SFP28 i.e. 4*25=100 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP56,       /**< Module to mutiplex 4 SFP56 i.e. 4*50=200 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP_DD,      /**< Module to mutiplex 4 SFP_DD i.e. 4*100=400 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_OTHER = 31,   /**< non-physical interfaces like virtio, ring etc.
> +					       * It also includes unknown connector types,
> +					       * i.e. physical connectors not yet defined in this
> +					       * list of connector types.

It is confusing whether we use NONE or OTHER for unknown types.


