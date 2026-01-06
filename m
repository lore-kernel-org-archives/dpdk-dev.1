Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F05DCE9D42
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 576AA4069F;
	Tue,  6 Jan 2026 16:05:04 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 9A816402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:05:02 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id C627A1D000F1;
 Tue,  6 Jan 2026 10:05:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1767711901;
 x=1767798301; bh=RUsnAnZdxoZ3wMoHRCKWYySMKQ2fDTuM+XzFAGTFjhw=; b=
 UFhsbryy1blT6jLYR29jrP7T8GEqmBgn2GwxV12hKrtY4zl5mmJbnKFFYdKo4kXU
 kJKQowkaoFCmIMMxCG2gNCNP6QbHwE3wuQW2KeRq0uvUOkMTRp4rnBsr4dNcPdw/
 ZbkZsIvNsv73+36m6xwRXPsXSh1mcXYqoI0C5pwR/75iOyAIlajDlJnLM9t+M0ZV
 EVbD7PneO07nqGelawitY+toe2kzCn7opmyeJVGAC9c6Bu0utGo5ltxxT4DvRdzf
 lU3q23W8NAL9MmBORnlx9tLIDhJjplFN+y0RU0PBHr7znAQIpivtAJMy8NLF1Q6W
 Luw/gfUD+aVDigNvJsjIVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767711901; x=
 1767798301; bh=RUsnAnZdxoZ3wMoHRCKWYySMKQ2fDTuM+XzFAGTFjhw=; b=S
 wAw1sjF6GMkv+b1kiTxmrE6Hv+GadtBmXpBvwlSFOedC0WNERw95AtNdWfYLO6gT
 WzNr0BHwc4cqpvvrYmgpZD+fErKxSJGWOlRvMtBfLHj+jKBS7lM0wIyNoJa/0AqO
 iH2YGzgw/ibJ7HnNr6jAR3eZRneZ43HsKUD68YYlM9D2PpPc14546ou3QlUZ2REy
 PJPzzifNQT6CoXwvWyanKcpsPSYpgF18XDJSSVfWimWStqR8ca3Ioc1sqMDQ+jmB
 ldbjdItmfK8UBwOpd+Dof6sb7X5jS0oCaTTk+fwkrrL9jQTnr1md5igf0cc6hAZg
 dDAGx39996r5LHIXAMPMw==
X-ME-Sender: <xms:nCRdafEN735ahIVb9kQLUa0kbH_hm06kseJwHqz3I81K0JUb2D83Ag>
 <xme:nCRdaWbVyPwciWIG3fmMXdyXPzNfCf4fn2nZcu0z27WsyrXXFyS-MUYf3UNJwA2Aw
 uHJ2rtLo1WpiY0FmXIz9FAyAV72NUshfw8fe6faTH40ozTi3zq_YxQ>
X-ME-Received: <xmr:nCRdaRDcHrNoQig-1kwQmeNT7GeAuDEQrjmY21MEBQw1Y60P7UkDNShJyJTsFGob4y3aOlLQQ3MAkQgvcVuIMXwqUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtheduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrd
 gtohhmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgr
 sghsrdhruhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmkh
 grshhhrghnihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghv
 ohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
 pdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:nCRdaekNA0tcabEmsy1KZo6iO0S3aDc4TEi3ZrSx3CXyzYUuaKk09Q>
 <xmx:nCRdaSwAJSM7N6Me9e1Rpy8oSt7TAD4FAMBhgJct2mVdoODeeKufmQ>
 <xmx:nCRdaYS4YfoM0lTji6wBVamJkTpovKaedkG_saqkcQcm6sp5qKpldw>
 <xmx:nCRdaa-2UCGn50xUELabR0BoZdIMm2RsvdKr30eP8d5j_ub6oy2cfg>
 <xmx:nSRdaR12YDiVmkdw3Pw6L5rhU2LcMsyqCdMX8qXa35WYpkJiAs9-F6Ky>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 10:04:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, mkashani@nvidia.com,
 viacheslavo@nvidia.com, matan@nvidia.com, stephen@networkplumber.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC PATCH v2] ethdev: support selective Rx data
Date: Tue, 06 Jan 2026 16:04:57 +0100
Message-ID: <5953641.DvuYhMxLoT@thomas>
In-Reply-To: <20260105165143.326426-1-getelson@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260105165143.326426-1-getelson@nvidia.com>
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

05/01/2026 17:51, Gregory Etelson:
> @@ -1757,6 +1761,7 @@ struct rte_eth_rxseg_capa {
>  	__extension__
>  	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
>  	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
> +	uint32_t selective_read:1; /**< Supports selective read. */
>  	uint32_t offset_align_log2:4; /**< Required offset alignment. */
>  	uint16_t max_nseg; /**< Maximum amount of segments to split. */
>  	uint16_t reserved; /**< Reserved field. */

Adding a field in the middle in an ABI breakage.
If the ABI checker is smart enough, it should be OK to move the 1-bit field
at the end of the bit-fields.
If we still have an error, we may add an exception to devtools/libabigail.abignore


