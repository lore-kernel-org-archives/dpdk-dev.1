Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D33CEE340
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 17:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E8974028D;
	Tue, 18 Nov 2025 18:00:46 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8574027D
 for <dev@dpdk.org>; Tue, 18 Nov 2025 18:00:44 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E5C8914002A8;
 Tue, 18 Nov 2025 12:00:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 12:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763485243;
 x=1763571643; bh=fmhz4YKlOML9saZD7sROKgVNApEeNGdkNLJeRHAQLEM=; b=
 LyKZ2nL+ZqO+Oc9luRA6UXDc8yVuRQCBDrkth2E5272/H/8LLKQsYwMnv4+tvyNE
 V/2GSlLgvLNwu8BbClROLcVnaJ4d/POIRrGpnY2ki2gGZRDfFRH/879KGii2Inzi
 qcoAAO4Fizoqznteu1kE69X/TGZ7iSHPwq916ackmHS3TuUe6SblRRSuTn9+QfzW
 aNOtqIPswGGgm8k+TkYNyS0s9yNfRjxMR+KIUFR3jYqvWNc4Xx8N2DCJzKTWuPCV
 ffUeC89JwsgJxCJAHaGK+jmRg0X8HwDn5fKRTsNyHjhfIlcEM+Km+EHTxHGpqjwv
 xj+brAYny3E7HNHt2u0RuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763485243; x=
 1763571643; bh=fmhz4YKlOML9saZD7sROKgVNApEeNGdkNLJeRHAQLEM=; b=Q
 VmeIOAMVrF33kMgAgaVWsu45CUKkWW3m/MIQGm50x1WYmn9tYp3CmYiCsrvrgbYj
 71zywV6oi5KW1DG6I1uma558JMw8nrQpo1wmWV6tfpwMOlJ5eFYKv/g9CRB6an6z
 YYxbU/xLqYuo+QFjGIoAfYwgcu5FEhxUjyzd9b5OraH7Sp64AyeJE1lcibYRNibB
 9kZVcufs26NduhqHlKWEAeOyUILn53L8o3HhuTKqtTmcMcU+uMCJ8Vkhe7nBejB2
 bm6aM5QY9HZTWW4ZqYnd/16vkr3AJ3T9+biQ8RO+vs7gj2mZgHajAjFZg4BtcQF2
 5tHFmu7yn0DZFtO3DX47w==
X-ME-Sender: <xms:O6YcaaXDRdvJ6PH_UFhyGlm26MynrHdDtoiJo072g5-clHjU5DQx8A>
 <xme:O6YcaSmJTl2_aJ2wg1LBXItUvhufUUhemhwd-Bc753wDp6_OZmDP7bEW6zuBzLnRn
 sKfDJMyLHAbIIXzcgPWq2F8_UOFps8UFZDbNTwhedM15qV4cD1nCWE>
X-ME-Received: <xmr:O6YcaQmNOsxfRWtbzItr-L8LEyFQmNLPf8PyIIdZyxWipP6qRFC0IHZSCk32NyMtVmXua0g_JrquptQQFxOuaZPrfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddukeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomh
 dprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphht
 thhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehrrghslhgrnhgusehnvhhiug
 hirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphht
 thhopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurg
 hnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihgu
 ihgrrdgtohhmpdhrtghpthhtohepfihishgrmhhmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:O6YcaSYDpJTiSme6a8UY7M7lRF8laJzLJFbbNASzTmmPRrWoNxf4QA>
 <xmx:O6YcaSRQzwYR6VBwAfY0E3Ci8oIcqjkGbTaAdZSXrG8nMLyTYvsxRA>
 <xmx:O6YcacssAk-7iEvBBkaORgUzxXAXuNLmElGpeJ_QUO1atS0b6iIN7w>
 <xmx:O6YcaUGkz27O0AXHs_fBMWlQEoziMcGcQL-Kq3kuYea0m1ekH4ozXg>
 <xmx:O6YcadcSgGw1ZTZGSRAj2h7qt3Jsp1bjXVpoucMLsgw4dnLiRyli2Vw_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 12:00:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Wisam Jaddo <wisamm@nvidia.com>
Subject: Re: [PATCH] test-flow-perf: fix the incorrect array length
Date: Tue, 18 Nov 2025 18:00:41 +0100
Message-ID: <3163485.irdbgypaU6@thomas>
In-Reply-To: <CYXPR12MB92792E9F685AA9387C1CC10BA4D6A@CYXPR12MB9279.namprd12.prod.outlook.com>
References: <20251117072858.9318-1-bingz@nvidia.com>
 <CYXPR12MB92792E9F685AA9387C1CC10BA4D6A@CYXPR12MB9279.namprd12.prod.outlook.com>
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

> > The array used to save the flow rules pointer was allocated with an incorrect
> > length. 1 more rule space should be appended but not 1 byte.
> > 
> > Fixes: 070316d01d3e ("app/flow-perf: add multi-core rule insertion and
> > deletion")
> > Cc: wisamm@nvidia.com
> 
> Acked-by: Wisam Jaddo <wisamm@nvidia.com>

Applied, thanks.


