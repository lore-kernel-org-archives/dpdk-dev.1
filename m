Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46213CFD365
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 23:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3914E402A8;
	Tue, 25 Nov 2025 00:27:28 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 686F5402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 00:27:27 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 94F657A0186;
 Mon, 24 Nov 2025 18:27:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 24 Nov 2025 18:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764026846;
 x=1764113246; bh=mbpcC10yRz24T/8gG5+xS2a3L35UqNPRBob53v5d+3I=; b=
 o0R3RGCzI8FrNUAbOFPRx5mvv6JwvU0dBic1BstGmXkFSO3YRSWeVSnjacHH7FN+
 DiInh1C+Of1288UTvAnl3sG1JPKnAvG7LH6vcxtSYRfdZ92NRziKDBfcIYfZUtWc
 32i30TOG5k4FHRr+VVHCc3JdEHWe0e1h00ZbxxDUHFDYfDjcvGnU7ZcE+v4tEGAv
 0oWxBGP2qGZK/lOuyT8o6fEgILljTDeGt1lX4XbecSGIwgmuJFfrVA4g3lydog3R
 InLQrewOApmFclHA16Ab/EKOReCvqP518WxvruhCQqWYQ68R/zM+DAF60XHeiVdh
 04SLrYPh9yaV91eGXgUWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764026846; x=
 1764113246; bh=mbpcC10yRz24T/8gG5+xS2a3L35UqNPRBob53v5d+3I=; b=d
 RE45hBF/KJOLK+W60YMAhdRul/2FWq0ntdKh0gpqQLbN5Mp/3M4+eTPEDry5Ue5j
 nqqDQ8cZqct7ujhFKC2lFM6He6SbyQm6HvjBBC80h1TWXRSGA/Q18tDbe1VwQaXH
 91w9hdgUcz2r61nOq89Z4owZi68FXSw9QcnOxz2iT1IOeKcTFFHzSE8VeouQtVfT
 J88LMCSuGxryvFchzw/ZtTKnSMVLjL617yFKKMYi92VfxH3xYhZYrpZYpdtk0mFv
 XySNL/zi4BcRbgQ4zQda5Zg3F6EOpqAWxRwRPQ6zB1LDKgyw4rNqAEZcCQOSqt7x
 wIpvhZ4GjK/Mr76yB+pVg==
X-ME-Sender: <xms:3ekkaVeVHARoE_p50Xu9MXU9b3qUSI0CZVTEUVTr0lX2kfJOai0qfQ>
 <xme:3ekkaXirIyq0jzt4Nnf9FiXHKoclatOy8-1lIT9f7GhJyRc7Ng_GqZf6Da9_u5iHP
 yQsLI7o9ueTYMdTG6zHlHZCNrXUgVm4dvSVb3IHhkUcnjosJjKByw>
X-ME-Received: <xmr:3ekkadqEcvslw2Y-wBwlThuBy4fwyZzYvtvjJpH1BUqDiHKWtM96KD1Qt2IirEgwOcRkuzsB4P9TrdjdQ8eDPGurKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelleduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepohhrihhk
 rgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:3ekkaXFk6CmbKfjWlAcDb9ofewNJqMrdU-sWIw3EdPK_vQiZB5uZwQ>
 <xmx:3ukkaXlS2myeXxCxwxkvpGAA1C_8Yi3irg7gQptTd36ZkRFemh-8eg>
 <xmx:3ukkaSlXZF0mk74u7ci9Pm-XrYPIJgDgy6mpE1-3daByPkeH5_RTZA>
 <xmx:3ukkaQtuNTwE2HOiZqBLg1IgJ2X6p4jPXuH-DuoKqvPajc6r9ku2og>
 <xmx:3ukkaeMDz26NsD0MllLb1wSs2tjsAGH9dasBidWzR8DBvA5t8jEF6nv1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 18:27:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH v2] examples/flow_filtering: add more snippets
Date: Tue, 25 Nov 2025 00:27:23 +0100
Message-ID: <3100526.bB369e8A3T@thomas>
In-Reply-To: <20251113101347.162908-1-shperetz@nvidia.com>
References: <20250919095246.3118-1-shperetz@nvidia.com>
 <20251113101347.162908-1-shperetz@nvidia.com>
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

13/11/2025 11:13, Shani Peretz:
> Added the following snippets:
> - Steering by Integrity Check Flags
> - Match packet type
> - ECN in IP Header Modification
> - Random Match
> - VXLAN-GPE Header Fields Matching
> - VXLAN-GBP Header Fields Matching
> - NVGRE Matching
> - NAT64 Action Usage
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> 
> --------------
> v2: fix compilation errors

There are still some issues but I fail to understand why:

/usr/bin/ld: build/snippet_NAT64.o: in function `snippet_match_nat64_create_actions':
snippet_NAT64.c:(.text+0x43): undefined reference to `create_jump_flow'
/usr/bin/ld: build/snippet_match_nvgre.o: in function `snippet_match_nvgre_create_actions':
snippet_match_nvgre.c:(.text+0x44): undefined reference to `create_jump_flow'
/usr/bin/ld: build/snippet_match_vxlan_gpe.o: in function `snippet_match_vxlan_gpe_create_actions':
snippet_match_vxlan_gpe.c:(.text+0x44): undefined reference to `create_jump_flow'



