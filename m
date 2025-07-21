Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25832C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228644021E;
	Mon, 21 Jul 2025 11:48:20 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0D48F4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:48:19 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 9BAD5EC02AC;
 Mon, 21 Jul 2025 05:48:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 21 Jul 2025 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753091298;
 x=1753177698; bh=C2b0vEGN5MzKQ9mfvY1aVD/jeRKmak4updtZrjzJZHc=; b=
 vDH6NSBgAeAvZdq1yqYSiSheJJWgNTbDW/lM24oMu5rbKK2DQyXgpZtHfmJ9yTe9
 iovEbDmGoIPVq6wWTEWClujpwosq17iGX3joSwYp5/Xm5yVugR/APDiAcB7tQShW
 p3M1YkJxyfp0jcKwp7fs7hnjRsYbl5pOElSAGz17kAamE6tVUZBlH36W+XpDu2Fi
 NKyTkW3Aq8MiNuHJcwD/yWMEjGIxxwkspyjl13/hl7d3wR184DeEb8MmcZOqydze
 wy9Waem7PpibkgGZ/ma1zxJxeyFpqO3YIKkKKZ4IpfgA9mO4W6T/cRB7UorjW+en
 yNf3XKs7/ZRh8+PQYTBTkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753091298; x=
 1753177698; bh=C2b0vEGN5MzKQ9mfvY1aVD/jeRKmak4updtZrjzJZHc=; b=E
 7bdlUidA/WKH8mEqgFPZ5WgElwLMNfZBtIqSJkldZVUyhod+9Gbf3E+pIeLA6T2g
 IbmBnO7Vaf9jcA3eoTovS2hMhaUv3ey3zF+xq5d/cxVbn+tKzTMuvgokqZYn+CeV
 eks5u0TeF1psoJZlQWPnIIP60Lur+84IJTbhKmM/5bHQfAO3qCnQHqLI/mvDW4II
 14GRRimjllL2oU7FZIq3V9VTRb5ybX309SBVMwTZRiYVZQQQDsxuJln4o3Oa3AeD
 vvW0iMblx1S6OJsksPwinx7X5euWuuLRwbQZBH0bQkQsAWkBJO+QxUzLN8EAnZnf
 aSAQ9CGBBeC6ljdSzOq5Q==
X-ME-Sender: <xms:4gx-aHhAB-IzoYY857et6YC1-wLvp3KrB5hrZ3IdOolwI9z9x1SLBg>
 <xme:4gx-aO5Mda0hm-f9yUz7OScPvypUvihOph-oxYZ0Qno1s5w8MloAfZrxJQL66vaYA
 3ETkB3-KLDkWjBf1g>
X-ME-Received: <xmr:4gx-aO5VpvCdCSn4GuLABuUKWIrVMoAsJY1K57mLfgFodMMdega6cRwUJBq88HGh9LZ70HcABohFTHIYsSHq6dOoOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephihugidrjhhirghnghesihhnthgvlhdrtg
 homhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtgho
 mhdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:4gx-aCd4WPE9iltT73tOeTtCRaIWmd6TCk4P2UaltzeQQPqS8Dr4HA>
 <xmx:4gx-aKBAsq2j80O1k5_5UIWcB4r_ORS8sBuy2jK3F5q0G8BvvjYJIQ>
 <xmx:4gx-aN95thvqcL5EHkzI0j1BHjn2ZY15t0iTzVEsTj9daWyqL1ostw>
 <xmx:4gx-aNKLWsjCIREHT_Q3lNSvHHDWIGD87SPBOx7wCTuRSVGifskx5A>
 <xmx:4gx-aCKJQjwJgfcQwDbeN4bjKPDdrn6IIqFIAwh3thhpWMHAXiFPqpff>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 05:48:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yu Jiang <yux.jiang@intel.com>
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com, dev@dpdk.org
Subject: Re: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Mon, 21 Jul 2025 11:48:16 +0200
Message-ID: <5102531.0VBMTVartN@thomas>
In-Reply-To: <20250715055748.1006691-1-yux.jiang@intel.com>
References: <20250715055748.1006691-1-yux.jiang@intel.com>
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

15/07/2025 07:57, Yu Jiang:
> Add tested Intel platforms with Intel NICs to v25.07 release note.
> 
> Signed-off-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.




