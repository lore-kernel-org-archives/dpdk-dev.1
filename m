Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A31CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 14:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E94D427A4;
	Thu, 14 Aug 2025 16:05:42 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 97D58402CA;
 Thu, 14 Aug 2025 16:05:41 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8B7BC7A0130;
 Thu, 14 Aug 2025 10:05:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 14 Aug 2025 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755180340;
 x=1755266740; bh=gVQB1Tbx1vQHniRmHq2HvFJPg09Rzn4jd8U1biyzUvQ=; b=
 gBKgGDFWykl/vP8DHIW34LKGvx/Kw5r8wqm0f005WunQHZ/jCwitTNscnYEhq0E6
 p4d3u9HgwX7Vpylx7hEhvWkqMNoyBRlE1jJuEwox2k17tSrPHBIuus3GtR1t9x5C
 DdPmveQpI/QzC7wM6bXS3uo8Xz4ulOpxIp4w6XQsc53eUL+xL3V2ew5OOCeqLt2e
 AHUI7NDh5ZG07at7qcdKh649rHKZtA+IGRSnsnuheotkMa1kXxHms55Ey+Wg+z+P
 DqPRlWWLvIpKSyESk0SIJrTvYXPNRSZQTDQqzjPP7CTq4hP+B45ozwRGeZotwAYI
 eFP8KTExfIf3IhyN6U02LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755180340; x=
 1755266740; bh=gVQB1Tbx1vQHniRmHq2HvFJPg09Rzn4jd8U1biyzUvQ=; b=H
 Hrark0F4g+B26ZN1lHIycd6XorKd8ypMdJHyI2ZqsORMvVAu2o4SXvY6XnI8kAY5
 hR1+sAdPijfAqR0R781qyuZOzYqmeAgZbuhgyqWLtUSVXGhzhyTQsKE7HOcE4riw
 zP5aGXWpd3JjfOWdYFk+C2L2P+k42kaI8Vxch/JPAtxRBtoaw/xyYrFJQRk/i8lt
 ERu1erjYh6j2zyDpSxeuXM8g34E3T5mnaLJsxe/dpEaEZMgk4B8VX0gRypdJ1YI1
 3TVO2PEpQOFRBVT3n/fNQ1HeU7LByaq8TcwclrC2rKmJjGmAFyJah4SyiGQJXtvk
 B6udv1s/7XCQVSDURkxlg==
X-ME-Sender: <xms:NO2daHJYpPkdbLVf5HRjzbhZpnAS5es4wuPR5g3U-clE7pIazSdsWQ>
 <xme:NO2daMsQjyCyHgkp7F2f1aJxXTk9mXaVsjPhM3ZLfii2IdYhKoOEV8pyPAoJUZLxj
 DKjdvwZ9es45VZmFw>
X-ME-Received: <xmr:NO2daGBv8GJ824EZbtshSox0ETov76n1iQGPhymNreVnW3E13-PTHnOEddfjOnwPYWZpPPdheWDfGpFe-DvojRKDHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduvdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrvhhinhhlsehnvhhiughirgdrtg
 homhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehv
 ihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrse
 hnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:NO2daMPklYSSMLZGO1c4y3A5ntlk55A24Jxl7ELotO5uv5xHm4GC-w>
 <xmx:NO2daGCakk1lB9hRFOdAL7uYVV_HnfZsK5QIAnYWiB5UgGbbPScPlw>
 <xmx:NO2daN7Su6r3vPbe6ElOB0YaWGi5EfAZ6ZR1VHuwuFGF43x5pnREuQ>
 <xmx:NO2daA60FjOiAdrPimeu4IGAex7_VsE_IchFwSrKHI4x8n4HZWiP9A>
 <xmx:NO2daKE4r4F3d8-nyo60NtP8A48bjPFsmHtgbk2IFD8JkD7NyUDMcB_E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 10:05:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gavin Li <gavinl@nvidia.com>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com,
 stable@dpdk.org
Subject: Re: [PATCH V2] net/mlx5: add support for flows targeting multicast MAC
 addresses
Date: Thu, 14 Aug 2025 16:05:36 +0200
Message-ID: <3720215.hdfAi7Kttb@thomas>
In-Reply-To: <20250814100815.801132-1-gavinl@nvidia.com>
References: <20250814100815.801132-1-gavinl@nvidia.com>
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

14/08/2025 12:08, Gavin Li:
> Rules for multicast MAC addresses are intended to filter multicast traffic
> and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
> addresses via netlink and store them in the PMD device data, which
> includes multicast MAC addresses.
> 
> To update multicast MAC address rules, create them within
> mlx5_traffic_enable.

Sorry this is not clear.
Please explain what was the previous behaviour with a past tense,
and what is the new changed behaviour.

>  	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
> +	BITFIELD_DECLARE(mac_pmd, uint64_t, MLX5_MAX_MAC_ADDRESSES);

Not sure about the naming.
What is the difference between mac_own and mac_pmd?


