Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7CCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 10:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A368D40B99;
	Wed, 13 Aug 2025 12:25:56 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE5B4021F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 12:25:55 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 97CD21D000F8;
 Wed, 13 Aug 2025 06:25:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 06:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755080754;
 x=1755167154; bh=elKYGoVeEZrZMXVrJxaBgxFqu03oLWnT9NuaIkGh1pA=; b=
 kKCRYU2B1asWCnLvhp4UtMkWK9EfLoIKbq6F7IsFcLxb0er/kP960lEQabfvYzCK
 0eWB0AZy3lAHVgN+TiZTrPLGm78a0OAO58zVhFBWdZYaA99+SWOOyZr0fkRQbtLp
 BDga3+U5zrWNWyZQifQOqxC/uLh0JFhL8WNq035fMmNU6TyTlg/O8yNkFWp1PuX3
 BGJO/MB//SBwzwBECCBNt+gdwLr1fUQ77i0eByRrtCUZOPFp+gjpOAt7KyvBj99f
 rdFmrvCVOuioMoYmHbSy21fteeBtbBZS0pGPdNgNJdmMAnx10FUfi6uv0JekiJcX
 mnIAHbKWDajCWgYRLMv2QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755080754; x=
 1755167154; bh=elKYGoVeEZrZMXVrJxaBgxFqu03oLWnT9NuaIkGh1pA=; b=m
 gKhgU7cz7m7X4i2PB6QbsT+gCDJu9MuXho8sbmg80AdfkIba9IKVQrAdp1zQsWVB
 XI8XX0V8hlo+j5jsfAIqbJoGVUxqX/yVRMjA1fLRVVZgBqlSSPlXACDh3Oxi/E/M
 xeFi6G4kGDGPNQBNHxmr+0IGyeBl4Zh/UsWCAFE3Y6xfehl190XqVYs6oufJUKOG
 aHLQdKSSRkceTbUCa9IMIzq4e4pTfTu6c5u3I/F87PrK6XWanUsR1apmaXxaQuLR
 AEisBT6Cx/KqcmGgeUsdedSMG4XDSEqCcr+ZlgQ28yS6rJdjVgyZGBXVskiYSETx
 LfhGoV8RNB3AXcY7BJy/Q==
X-ME-Sender: <xms:MWicaEDqeHdCwlk0y7PKXukAhzry02UT0cGuRYSP3XorCPlmr_vuxw>
 <xme:MWicaN6z-QEc70n7Tvj6Yo_lnzAK6DNA56C5lDPl44oKwEVImeIVVmSHFCT49BdJ9
 3K5O3S0vjJN54uAFA>
X-ME-Received: <xmr:MWicaNINYYKJfQM0bqSVpH8VLY3W9qsNjHXy4aJSeREdDBVZd80WbeOavVTwevY4H96QKuH4qoC6kYMOvY1o22saaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehskhhorhhisehmrghrvhgvlhhlrdgtoh
 hmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghs
 rdhruhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehnuggrsg
 hilhhpuhhrrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhes
 nhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrh
 gthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgr
 rhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:MWicaGtqmXoL-pAIpnHmtGZc3ivajpzXO7_TNdIoKg1cK6N27GOS9w>
 <xmx:MWicaMLfQXwaP2lHjZ_7rwsdKNp8Ncl5s5widmd-ufl4uPyUQr6OhQ>
 <xmx:MWicaP9loeG36WXKVqEetDEOhvLtn4JK2CQvxZitLH-drMUcKsdBbw>
 <xmx:MWicaFznvI7vse-VZrUkIvq6yvUDLLqxx2Y9_YOTXFrQwHjvp9HNFQ>
 <xmx:MmicaJGObE5cxILL_14Op18fr9NOLOAdSjEAx8y1BW1sMAOrTXUIIjAy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 06:25:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunil Kumar Kori <skori@marvell.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 1/1] ethdev: add support to provide link type
Date: Wed, 13 Aug 2025 12:25:51 +0200
Message-ID: <1975832.6tgchFWduM@thomas>
In-Reply-To: <20250813084508.1446318-1-skori@marvell.com>
References: <20250606092904.3145608-1-skori@marvell.com>
 <20250813084508.1446318-1-skori@marvell.com>
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

13/08/2025 10:43, skori@marvell.com:
> + * Ethernet port type

You mean "link port type"

> + */
> +#define RTE_ETH_LINK_TYPE_NONE     0  /**< Not defined */
> +#define RTE_ETH_LINK_TYPE_TP       1  /**< Twisted Pair */
> +#define RTE_ETH_LINK_TYPE_AUI      2  /**< Attachment Unit Interface */
> +#define RTE_ETH_LINK_TYPE_MII      3  /**< Media Independent Interface */
> +#define RTE_ETH_LINK_TYPE_FIBRE    4  /**< Fibre */

In general we use the US word "fiber",
but we are not very consistent, so it is not a strong opinion.

> +#define RTE_ETH_LINK_TYPE_BNC      5  /**< BNC */
> +#define RTE_ETH_LINK_TYPE_DA       6  /**< Direct Attach copper */
> +#define RTE_ETH_LINK_TYPE_SGMII    7  /**< SGMII */
> +#define RTE_ETH_LINK_TYPE_QSGMII   8  /**< QSGMII */
> +#define RTE_ETH_LINK_TYPE_XFI      9  /**< XFI */
> +#define RTE_ETH_LINK_TYPE_SFI     10  /**< SFI */
> +#define RTE_ETH_LINK_TYPE_XLAUI   11  /**< XLAUI */
> +#define RTE_ETH_LINK_TYPE_GAUI    12  /**< GAUI */
> +#define RTE_ETH_LINK_TYPE_XAUI    13  /**< XAUI */
> +#define RTE_ETH_LINK_TYPE_GBASE   14  /**< GBASE */
> +#define RTE_ETH_LINK_TYPE_CAUI    15  /**< CAUI */
> +#define RTE_ETH_LINK_TYPE_LAUI    16  /**< LAUI */
> +#define RTE_ETH_LINK_TYPE_SFP     17  /**< SFP */
> +#define RTE_ETH_LINK_TYPE_SFP_DD  18  /**< SFP_DD */

You should use more full words in comments, at least for DD.

> +#define RTE_ETH_LINK_TYPE_SFP_PLUS 19  /**< SFP_PLUS */

Please add more spaces to allow a correct alignment.

> +#define RTE_ETH_LINK_TYPE_SFP28   20  /**< SFP28 */
> +#define RTE_ETH_LINK_TYPE_QSFP    21  /**< QSFP */
> +#define RTE_ETH_LINK_TYPE_QSFP_PLUS 22  /**< QSFP_PLUS */
> +#define RTE_ETH_LINK_TYPE_QSFP28  23  /**< QSFP28 */
> +#define RTE_ETH_LINK_TYPE_QSFP56  24  /**< QSFP56 */
> +#define RTE_ETH_LINK_TYPE_QSFP_DD 25  /**< QSFP_DD */
> +#define RTE_ETH_LINK_TYPE_OTHER  0x1F /**< Other type */

Why the last one is in hexadecimal? and why 1F?

Is there a logic in the order and numbering for this list?

Why not using an enum?

Thanks





