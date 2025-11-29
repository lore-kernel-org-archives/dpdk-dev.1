Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C5D116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 22:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A954013F;
	Sat, 29 Nov 2025 23:24:31 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 29FCE400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 23:24:30 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7B0341400639;
 Sat, 29 Nov 2025 17:24:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sat, 29 Nov 2025 17:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764455069;
 x=1764541469; bh=VKn6HEXHqqbRMJURR+4fs84e2P+4r0IQDYyt7OIKHtE=; b=
 X5z46Gla34+Nre7FlPX9Yna5u9905cP7tAAyPIJmVqz+92414tRkOdKpK/S7v2zp
 2OSknSZj8eLzr1LLADJjrZ1KQnFREhKtoDyHancghZS6oCJ2WLBM3nR/jzgsRVKA
 2smfZS2yNMM44t3t0oxjD8mnyINRglDfp1/T11d+6S3ppCISGu3/Hp0AXl+GB/C4
 bL7OpQvhvWJpmxqzVfjXVtbVzijcjnND5diVJxoYyhS1oPbe6UZxujZwNpXQ8bkx
 3SuHWqIenfoz6WQ7TPz7oULu1kpuvzSEDIIz59drKfvE3BHGKfWCkMFmmRg7fpjv
 fqwWE8tdOyWD/aN5wJmpSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764455069; x=
 1764541469; bh=VKn6HEXHqqbRMJURR+4fs84e2P+4r0IQDYyt7OIKHtE=; b=i
 a+q+qQ4aYnXPrWTgxXWnFls53gZd/Vzt1sIViX5Bv66LzB+lwbauRo2gFFX9NtdP
 0Ev3M+ZQ2QplO8WcS9TL8P0ZtcRMBRYaKu87F+UOruq1+oVpa9G+c6u77LPQ7P+t
 FlCNwJxLsJUfYoQzWldYJ0UmToQBbL2fo9/JLbXtmaA9eSKtYocUTp7g/pvp6n22
 f+XptLUPe4tq8ZWthCD3GavYQTlUoZCkOGz847l3x99MXCFx+JTUgLSI8kNFdDPO
 NvkRSulHNswG+b88c5TcrafZ6BkPYm+pXEdFhEs2jWAzF5+ZG5EGRFjEti3rVNWq
 y3/8v77Z1w7dvOjXfFhXg==
X-ME-Sender: <xms:nXIraZzg4VfY1JrQEKuNp7VGBdMbGfnmv4wabSWLqSeYcomjBS5U1w>
 <xme:nXIraVTIgJMVDcGYMYgYh2MgjaLzDNGnr65BK0ZRE1j0mnZKy3spDpqVk9tLe6iTf
 xY_yZxTlb-5FRW-58sEDZJDKwVE_71QgBjkMGdf9-88KGGW_FYM1Q>
X-ME-Received: <xmr:nXIraVgUBIqHHxdkOpBPOmDWNMCn1orUT6O0U5mJAF2yQtMlLwiJIXa6CE2ZyzEw0uJSZf642mgzvb-BI84tBgHxtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmkhgrshhhrghn
 ihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgt
 phhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhope
 horhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehn
 vhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:nXIracmZ17Gc5tSzpK8ygOSOADxTm_3LQGjlIqB69W5dmXupl359-g>
 <xmx:nXIraYvlYAemwpy-NSelxh9npbvYsFjRci7HwbeEWeRNQc5eHW63BQ>
 <xmx:nXIraaZTLWZKzv5l-msdJUn9YEw5knh0wiTSnUkbWtNG9YuJgNAB9w>
 <xmx:nXIraYDx-8wX7AElUEotg3WPqIs8iSuwByYHxppp8TXEJFlzOU_NLw>
 <xmx:nXIrafq2Kj6DMwB-NJoLQzT_uzzjQ7WgigPCdJsyvO8w3kkq8St-kXYo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 17:24:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: bingz@nvidia.com
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] doc: update flow engine availability in mlx5 guide
Date: Sat, 29 Nov 2025 23:24:26 +0100
Message-ID: <4636608.e9J7NaK4W3@thomas>
In-Reply-To: <20251129124257.1619774-1-thomas@monjalon.net>
References: <20251129124257.1619774-1-thomas@monjalon.net>
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

29/11/2025 13:42, Thomas Monjalon:
> Starting with NVIDIA ConnectX-9, the future devices will support
> only hardware steering (HWS) flow engine.
> The software steering options (legacy Verbs and Direct Verbs)
> have lower performances, and won't be available for new devices.
> 
> Fixes: 1b55eeb7b76f ("common/mlx5: add ConnectX-9 SuperNIC")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied


