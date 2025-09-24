Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F9CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAC8406B6;
	Wed, 24 Sep 2025 16:18:52 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id F34D840611
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:18:50 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 19A247A016D;
 Wed, 24 Sep 2025 10:18:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 10:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758723529;
 x=1758809929; bh=sIseDMxleZk9tH/VcfDbwEYjBmTNyJYtxo7OM+ur2Lg=; b=
 vXD0Q8KCQJore4b0aHthHUjVZ+ITB65Kf+Px6XMrPPkyqH+kK9vYTz674gcb0gzG
 +jd+mu+moj6/3QtQifQ46/3ohG9PB2ifw836UPUVcTrWmqUEauj5NTVV16QZy3mc
 mRcjqJUlJw5CI/AetAJJtbL9rt90o+smLp1bE8O0UW3LP/7FRmPDiGwPVZrm9Kkw
 mK4zjD+MPNXqYGcJSGBCSdkK2J4oXFSTyBCS/lQYzTqgKEA0h07s6J8xhstO8+s1
 hoE4mug1GIJMb9T+hEOOb28ffVX7H1FqKvucEpgvQc0EDDNfnOne13KvFlPa0CN0
 AHDh1pjDb6g6GllKgpi5Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758723529; x=
 1758809929; bh=sIseDMxleZk9tH/VcfDbwEYjBmTNyJYtxo7OM+ur2Lg=; b=D
 m2Ow+G286QPzaMahks1yc5WuTaBRBCicbLV0dSeE7kjXPNeSpuEw/8Zs/5jxoW9X
 7pRmnIl4TiZFKKBb4oQ5KdZZX8u8GcB24FkVBhq0a9n3JdK4hGH6uQ8WPiyVATj1
 NK1YJqPyNl2Ev6Pb7YNkCWOFoD+Aqve60rV57PfaTN8Lr6bgqn/sysSuWEokgOgW
 WKC1/kRzD3UpTc7oIXaV3venI6Cn9cbZCBgoG/UrxD6ZdGNHMpptQpWHC+IHqUan
 aJxyIxOtHgRgyZNeyScgE1Pbol8LvLhu45OlPelND16F14a24hSY0SeUcKXqxNnC
 Kp/vRWBL/TjhFizB7BoHA==
X-ME-Sender: <xms:yf3TaGu0z8Y1IK68X0JhztOJRWvaDH7-LFhG-0RTrOvs-xf6oE0pDQ>
 <xme:yf3TaGYSXO4i6yjcsr1UJxTl2IgSwY0Dv1RMej9t2b3Yj0MT1vy-3NtbuRbbwmR0n
 ooAsQwACL-kca5uj7bmWucGVC9OnwRAe51xTO9tly8Micmsq4cU-Q>
X-ME-Received: <xmr:yf3TaAzwy62OyMamV4CuqijV22Vsft0xXsCG5g0JWQ7ydElNeFCPbwunZKN0nvT-fzfJ33jCznYj2y3d8NF1HwgdTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeekfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghfohhnthgrihhnsehrvgguhhgrthdrtg
 homhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthho
 pehkihhrrghnkhhumhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurg
 gsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeihrghniihhihhr
 uhhnpgduieefseduieefrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepghhuvhgvnhgtrdhguhhltggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yf3TaGgBXutLQdYcJdHvtSNA1VZg6s2Y8cyVVbLE-3Jldn-bXjxBFA>
 <xmx:yf3TaEnlbRNHFWbb5u82FBd6mFIfM5zTbM7WlBU0wD3EzOHQ0UjhcQ>
 <xmx:yf3TaEikxT2y5ESX7t7NOu9lOBmt-n-op9EBJzdlyIcqU9VL0QFiFA>
 <xmx:yf3TaA131AhKXmMNbe08VIRxPP8hTnA2jxgs5n1x_-AUTTMPmhVrlA>
 <xmx:yf3TaLRaxT1PC4-naE109qRdjQwPWwJKM5P1XamPBTgb70xWLRITKsLT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:18:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Christophe Fontaine <cfontain@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, dev@dpdk.org,
 Guvenc Gulce <guvenc.gulce@gmail.com>
Subject: Re: [PATCH 0/2] graph: dispatch mode improvements
Date: Wed, 24 Sep 2025 16:18:46 +0200
Message-ID: <2836217.eGJsNajkDb@thomas>
In-Reply-To: <20250723165001.11162-1-cfontain@redhat.com>
References: <20250723165001.11162-1-cfontain@redhat.com>
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

23/07/2025 18:49, Christophe Fontaine:
> Small series to improve dispatch mode for lib/graph.
> In order to run an instance of the graph in a control thread (slow path
> defined as nodes) in addition to the datapath thread, we need:
>   - the ability to run graph_walk on an non-eal thread
>   - a signaling mechanism to wake up the control thread

Should I expect a review before merging? Someone?


