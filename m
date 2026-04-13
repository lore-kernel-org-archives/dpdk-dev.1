Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F9F531C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 19:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BF47402E1;
	Mon, 13 Apr 2026 21:30:43 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 2AC38402CC
 for <dev@dpdk.org>; Mon, 13 Apr 2026 21:30:42 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0ABB17A0133;
 Mon, 13 Apr 2026 15:30:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 15:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776108640;
 x=1776195040; bh=5tlFKSGHEDFaRkz0TNMenp+DisU7fRx9YDRZ04wNT7s=; b=
 VCdzkwY11oMWUu1w6E9JGfREus3vcfzMVVugCz3fs3lUk5Pwpyxef8uY00+UmKqd
 Op0djP/l8pznpp+kcYZiS8VKJl3poBDpw3+WZJgkYoHNNV6PQDiQUA92VODmZ0Ly
 0wYxxK4wxT6YHYAF1m9PXue/wScMLFQbYUrgbX5wXlkdlQ/tIcZvdU69vTIJJLIE
 JLZvGA0W6gg7KR70xDMzhWwfy/YiJBm5Igj8vbg2TbQYDidH72wo6X/lsThQvfNQ
 xMPa/yaXKEvc0L7ssG5ZAsVYQvg5fomAXXlS7WxDKYrruE/c125RaDODViNzfHuJ
 Yh6EHqdAGNuCjfAQ+ItpJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776108640; x=
 1776195040; bh=5tlFKSGHEDFaRkz0TNMenp+DisU7fRx9YDRZ04wNT7s=; b=L
 Qp2khbSC5rPZTrytANU9NUa5ogymWvgX8Ghk3nVIBPqVMnt8erRlsbKzG+AqvePS
 0EXLXQ9ToD8Xq5UJ3K4wi+q+f7L/FhcGV/U45PJHYqR1pYFTOJngiebHEoyPaRk4
 GvjetPnIsEYvpouunbeVD+7sB4FDoe855bcRNNtg7XAoecpgfh9YgZ/SydgmxZfp
 CluS6whgiH82CrkZZwpo7mvp75llqBPbMOdI9JCb7YDgQ4jC/VtHdHa0OeLg9/Wc
 JKkqgYwS036insrx0tpO786ap2qnen2m3DVE6VKJV4EDvAkRuRPTe3+LIIl2dSov
 x32VVdGi8KxIQWLxYxWTw==
X-ME-Sender: <xms:YETdaU6N8mwygb6oyBf2BOx1CLL97DEWZA0ccCJp0rb9enASgGA__Q>
 <xme:YETdaW28WnLhS3QtCvKeZFuvLZdjuje5M82b_i_owHZeK5nkPRy4eKzWPkyPCQvVS
 PYQtAuYVtkQbk9t2Hq1B_eN6xp7Ddlj1aftXnlIURv5aaGrlEw>
X-ME-Received: <xmr:YETdaTwuFU_XMTLZhfMJz3dWjDPBQzXYfUJJpgH7Q9yx9zdmxCqrZkRVlU1caw0LhcbZM4r7YYM6mA5P639MaPzVHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 eprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghg
 rhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehmrgigihhmvgeslhgvrhhohihsrd
 hfrhdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehprg
 hrrghvsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:YETdaXlhYAjcrUJYMLCFY94eMryAYOZmLd3vQVaR62YiYahD3mE12w>
 <xmx:YETdae_YHayS8DKpr4MeQPT99qic5GVtcSfKE2UzUGRJDHUBra0z0w>
 <xmx:YETdaarWNKEI4QbNUDfKKedR82tWYamQl8wIx582PJouoCgHRp6HoA>
 <xmx:YETdaaK-9S94N0q3hS84CF_jJ0pa7bHILZsaRdSEF5DSd7ikLhPHTg>
 <xmx:YETdaU8dCpVI4TWjW2Wh4LE1OHG1dyyebPYtl9mD44bWPrNlXrOvXqjw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 15:30:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 6/7] bus: factorize device selection
Date: Mon, 13 Apr 2026 21:30:36 +0200
Message-ID: <24331929.6Emhk5qWAg@thomas>
In-Reply-To: <20260407115211.1903623-7-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-7-david.marchand@redhat.com>
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

07/04/2026 13:52, David Marchand:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.

[...]
> +/**
> + * Indicate if a device should be skipped during probing of a bus.
> + */
> +__rte_internal
> +bool rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name);

Name suggestion:
rte_bus_device_is_ignored looks easier to read

Actually it is ignored only when probing the bus.
What about rte_bus_device_is_ignored_on_probing? Too long?


