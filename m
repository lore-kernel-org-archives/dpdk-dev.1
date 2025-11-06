Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6ACCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD3740DDC;
	Thu,  6 Nov 2025 12:13:47 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 595C84013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:13:45 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E91A214000D0;
 Thu,  6 Nov 2025 06:13:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762427624;
 x=1762514024; bh=5aafPbCgQM8OpBGyjA4rCtDxZtVYAHuy8KHWv/8NRyM=; b=
 lvFwB0T1mHdgtl45JwB+A7Adn4k5wxNaKRobs/5pfidpsGC210EmbKttHy4Yq+oD
 IPGoRFEZPBmtRQQXgF/rotlgV4wUBdRmBYSQ0w4ggeie9o3qcmDzG7Vq6J4IZUDD
 pBZjn79yZv4JubteNFQN9/ZiyriCiKgcN/oldc67CzDK23jCtiq7xrS/8z8CTAEJ
 ASN9Surg48+zhwGVI0pmZl9FMP6JmO03VQFBI2bx7bfUm6V9tq1/EVXNBrLBsrJx
 xOkBtKpcZb9nlDTRXNjbMLGg+rpgA4/pst+U1BFkc0oZ0d6Y3pN3GBzKMK93vnOl
 A5n+5fmaNMzT0x4kJ+peAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762427624; x=
 1762514024; bh=5aafPbCgQM8OpBGyjA4rCtDxZtVYAHuy8KHWv/8NRyM=; b=h
 lykMSOyz9Tf15+hVBoiVxuUcYzpxeymXIZR8R2UrVj8c2Ac/BlfRAywM0fdYGsOY
 P87jL0ghTWHaWDaafVldNUNuOUR/KCJ5+yim37AegXNidhWHISG5s0nrfPQ0kGZ9
 NtnfekSTwbaIYiCbmQ9wCkeizVqStUiq80dpRzqR759JO2XyIDfpkqJny7Gb7SCi
 QTATgn92LV46Lxtq8ziOet95oauha1lfZ4AFfIZShbHZYnr7J70wkPBN9nKHpF93
 bObgl85z6UHxD/cd4hTAZvrql/MUweIjlhZX+TGElNIE+CReXCRdWNFkViMgpU02
 UUMpYdwcE5365q4d4sU5g==
X-ME-Sender: <xms:6IIMaVqCGelPM7CqL08fJtO57UMfAeHyq2TIsIONCOIiKDPDPR3StA>
 <xme:6IIMab9Hif_IqtpXlri4Pmeor2yO9VMDht9HUybwpB2sS8oly1OX5w_1BBMrxjgkb
 wDPUohNwIklxjPi4wOdiZhH_cn3Gc4eeo9N5ItfMDaeHDsU0Tl8Wg>
X-ME-Received: <xmr:6IIMaRXZkcUR4m6EtOCA56MYP6uaJPbUiUUHZmjBM6U9zQTbkW2j99a_d_t5WxXFX7uWcpRLFnbCiCoiaI2S8cW6vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghs
 lhgrvhhosehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:6IIMaZBDUC8cVwfA7HefW-WrMmqUOQsKlAJ0LEcjeZs9Tkasc6MKMg>
 <xmx:6IIMaawsHp9iWy3aZ-n6oXcEoe5NfROjql_dY0G9EZtYH8iWr0GIjg>
 <xmx:6IIMaeAQVhvqVmRJrR76w0jMXZTRrpBchir1fU-IUDaqTTRh5WBqcQ>
 <xmx:6IIMafbqry-T6im4IPwO8GqDAkvilwZS50FeZ2loHK0DtJFZ3mefoQ>
 <xmx:6IIMaToxiWxtPcRvGgj3dM1mQi8jxgpsgKbCe8KdS97cAbU8_d8pqMcV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:13:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: Re: [PATCH] doc: update mlx5 vDPA guide
Date: Thu, 06 Nov 2025 12:13:43 +0100
Message-ID: <2468556.h4nFI6E9mP@thomas>
In-Reply-To: <20251106110807.1223973-1-thomas@monjalon.net>
References: <20251106110807.1223973-1-thomas@monjalon.net>
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

> Adjust supported devices and reformat headings layout.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied


