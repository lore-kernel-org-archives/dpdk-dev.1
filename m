Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E385C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 19:51:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ADCA4064F;
	Thu, 17 Jul 2025 21:51:13 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id A1D4F40283
 for <dev@dpdk.org>; Thu, 17 Jul 2025 21:51:12 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C69AC7A00A5;
 Thu, 17 Jul 2025 15:51:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 17 Jul 2025 15:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752781871;
 x=1752868271; bh=JlDJK1nQvhPbpMpdAwAdWHhyZ+91Ume3uFFiqB7JDwk=; b=
 ZxdnZsNrgQlMZHIfL0Hw07cR0qY2kCob0SXJPXwa0A9umPDCP5azx81og9KbRruf
 Byyndjezq29rwtPQD9eL1lRgPZlt0NR/B0F/rNHBHddzNWWX0jGw3r7ZuDBooeiP
 11Z12N778UXI9xy/oirNX1iwsGYOh4bxw/olKuhBjbn/beIML7Fg7GwvWGI+Daz7
 Z8fKtgIi/NnkhiGrIpEDQh8Goj+L55ho2WmQGhLea8M9IEE8+Mzf1lJaBciix2k8
 cR2kZ4CrbWdScpnuO2JHDd5p/QoToUwu02qowwQCrg6PSlgQlft45IinQfsPUBcc
 XdNhWvh53d7+HRFG+P4Eow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752781871; x=
 1752868271; bh=JlDJK1nQvhPbpMpdAwAdWHhyZ+91Ume3uFFiqB7JDwk=; b=Z
 adYMQ/3y3XH+adqZfiV/pCUeV9KedApnOEjFb1jtO8Io1DUvOKN5Vqo3dornizoA
 gAL+xjIUx8GvbSrvRENRv937BT9sa6lWZWWfzP4kswSTwwTs60a7jF21S1XRi2Xs
 s/JuRJOY6Ho8gZU9ezaB7r9oAbwUOBq5KmnhwT0+M6NYERGV+KvElhoi7v3dX/SE
 kBqoBYrTGLFGBuBWDB6WNn9KCMCXGhgbQbt5gJI/8v/WG4XTGl/iWIPlmTtYi3ZU
 LRZrDOAhg1oZSx39pSwsKNQGpD58yRHgOxdqOIrdF7GFY71bsZWGjPzobxYrnhYQ
 YubrT4IHxdBmJfxhAQLUQ==
X-ME-Sender: <xms:L1R5aDBPYZ6ygKr1OCvSPsE5qryNO6T7BCwVGlaRBNTsaNhmjJIDrQ>
 <xme:L1R5aA5O3IpPz6QYwzEnLifYTx6zxOJ4w0X0aU7hg_5DQsujdWR8tho9q6lwADm2H
 DM5FMKdS4W_8ulX-A>
X-ME-Received: <xmr:L1R5aELUoyVYnJV4A-nDzQCtIhZvp3uq-oppBlBlXjEP2yNUuvHs9VCgm30GVUnkx0L_AU3jUCIMzyTbF5JwkR0-HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepmhgrthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhl
 rghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvh
 hiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgt
 phhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmih
 hnghhmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:L1R5aBuIkAt4CimSBlJmfUAHn0cFF7eYEE4itCq4K3hLbpSiF0Zazw>
 <xmx:L1R5aLKjZTiu7fDtyfrLf6nTTw8e1fAqeX4FJYn9kdGbcu0mt4vc_g>
 <xmx:L1R5aC9zJeCzKaRRb3Uics8MCyUyanRRW3uw38_Ea59kO-3y-ukw5Q>
 <xmx:L1R5aMykD1kkNV8wYUikx0iq7RFU30fANnpbwkKVSvo4s9EUyL-ZKg>
 <xmx:L1R5aA6RVVvOeXU6ziOszOJVKI-5LK8WBD591cUPrywzn-DXuO2khpJl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 15:51:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: Re: [PATCH] doc: remove Mellanox acquisition explanation
Date: Thu, 17 Jul 2025 21:51:09 +0200
Message-ID: <3370600.44csPzL39Z@thomas>
In-Reply-To: <20250716101516.224980-1-thomas@monjalon.net>
References: <20250716101516.224980-1-thomas@monjalon.net>
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

16/07/2025 12:15, Thomas Monjalon:
> Time has passed since Mellanox acquisition by NVIDIA.
> No need to explain this anymore.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



