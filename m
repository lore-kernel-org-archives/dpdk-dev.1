Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67966CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 22:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A7A406BB;
	Thu, 13 Nov 2025 23:37:49 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 2D49240151;
 Thu, 13 Nov 2025 23:37:47 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 030AD7A0165;
 Thu, 13 Nov 2025 17:37:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 13 Nov 2025 17:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763073465;
 x=1763159865; bh=yGzozPc8x8UECHf+UM28FkGg0jlzk84+eiMjzqZVxv0=; b=
 c5cgYv2nyJjTA0izFrEaI3DUX0FuP9NfEazDCPglq4PGRwBMfOfaRorst9gGeHF1
 XAO33j/Sdy0z3WbKlk7K52kauxW9ZRTwEcTBWq3A4+tm6bKWtT17QaiTaAu7ox3H
 hBH5VyjL1M5B+w3neCqfjEuz2c9vujrwGZgDRQ0jd/RILWCPXwB4Df0uWt+V4xdn
 LHkut9ujjigW0SI0lLFaA/o6n+JQ/pLyzEijZswqGUH0dEKDok76ygayYbLpQqHB
 /Jy/Mqj3gFbVOycdOCYjoSr6sErmmZgUwWCuPa5r3SZn8asht+UnbwIW4T89H6mP
 rHImA7BxPWW92vKR/rHghA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763073465; x=
 1763159865; bh=yGzozPc8x8UECHf+UM28FkGg0jlzk84+eiMjzqZVxv0=; b=N
 ZPIeG7QkYkE1YRhL51wTnrFHK+ck4gFqBuXSArL+SC+L3VQCKqbxxcGkItvnat4U
 y+DbknVJEb5NOMvCWR2wYktrdC2w4oV2M4JLX3ijZHUyx1M2gGLztm34qkDIFfLB
 P8HJMecsLuTFfNtq+weTIZ/J7u/fS16DWDDLoCv0qViGo5L+/xWR/pzzMdP3fYvG
 5f+GpmR8l51DdG3CUsAJIUZdiMGbc5o2Si6MhrIN6z0pZ594oqUMIarX5oMjMpqx
 uSNGRwR1Z134PD0ahuWzWgsDeukwKUFIuGtR6mrXx+gYnKIbjS6hD7KkSeiHorsD
 l/15OFBxT+Wu1xE8VleBg==
X-ME-Sender: <xms:uV0WaRUirpwWdCttucKk6K1HkHdJcn8K86ApOg-p3jKIbd7IE20Sog>
 <xme:uV0WaZsyHvW-NzCC-Icq3IqjV8D5qDsCREYpwzTKYarPP7SYv9N2rUQwKx_VluZ3S
 FMOdmNvpRtSw6MeSs9N9AXbtfgxLy3KDkkpqAHiZnLykZdLDwM>
X-ME-Received: <xmr:uV0Wac7bz1l3eBxYNrjgUG01c0KZa9kDwL0ZXApi2kw5ZD3ob2hBXWJ5-9VI2I7bEzd3Ho1C6tjHGZskcFrPPtqnlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdekudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedufedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhshhgrrhhonhhisehnvhhiughirg
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmkhgr
 shhhrghnihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrshhlrghnugesnhhvih
 guihgrrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphht
 thhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnohifsh
 hkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:uV0WaUQpTpU-bofAQhNKbPeauv4s_URLe85HyYv6LEvmTeKe9aKuww>
 <xmx:uV0WaXvL-koh8rSBWe9sqtzDoSB5WN3EkpB7G72uqaotrHVe71DAjg>
 <xmx:uV0Wae_EauR_sjYJVtiN5ENXIB8NGPo516YVRPYpeAouBG8AHBcWPA>
 <xmx:uV0WaYyeopUuUz1nEtAZ7h8G6ZTBFk87P-dmCBTZt2jZoo9jlN09Kg>
 <xmx:uV0WaTzzpHTlfIq8Cy1I2jrciNGTD1VmlTN2Jk4f_Hrl7e8n44DrIiJ4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 17:37:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Itai Sharoni <isharoni@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 Itai Sharoni <isharoni@nvidia.com>, stable@dpdk.org,
 Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ophir Munk <ophirmu@nvidia.com>
Subject: Re: [PATCH] net/mlx5/windows: fix match criteria in flow creation
Date: Thu, 13 Nov 2025 23:37:40 +0100
Message-ID: <11095513.IZOipudI63@thomas>
In-Reply-To: <20251113122642.1193-1-isharoni@nvidia.com>
References: <20251113122642.1193-1-isharoni@nvidia.com>
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

13/11/2025 13:26, Itai Sharoni:
> Currently the Windows implementation hardcodes match criteria to
> MLX5_MATCH_OUTER_HEADERS when creating flow rules, which prevents
> matching on inner headers and other criteria types like NVGRE.
> 
> The fix uses the matcher's match_criteria_enable attribute instead
> of hardcoding OUTER_HEADERS, and moves the assignment outside the
> action switch block to apply to all cases.
> 
> NVGRE item type is also added to the supported items list.

Why adding only NVGRE?
Should we mention which tunnels are supported on Windows in the doc?


