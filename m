Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4168C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:17:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C8A402A5;
	Tue,  1 Jul 2025 16:17:26 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id DDA4540264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:17:24 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 12EB77A009C;
 Tue,  1 Jul 2025 10:17:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 01 Jul 2025 10:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751379443;
 x=1751465843; bh=JO4cGPgPfHVYFj5IFPJVKjdqKgQyS8G3kxOAI7ZTLRw=; b=
 WsMCxXfldx8HQ7wCYY+bOClVztIvcEXHgoAGddX/3N8O085JTdITwhOc4GUWnsIN
 ChTCOiZZAl9LVtwr/Nies+EmEpYmWknNTwuk4Kh58U8hm8+Ym3f9hk/nZSKaNnmE
 Dieijbcd4haO88lUSDM45kDrdv941E7hRAo9MiNeiBeTlOgaLg5xy38FmFb4SvYh
 s+GU4ETNTQ7qFBP7l12p4GdnswIYbUfn8mWH7VjQOlImKipFcCBNTyaXFokl9iH7
 lJH9qN0GjH1oU7veqmhIXnuGZdKIIBhhYUbUp1vLmGgY7pQOuktPrVQtng1RmeK1
 dH7u74f39YaHo0qjJVrgOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751379443; x=
 1751465843; bh=JO4cGPgPfHVYFj5IFPJVKjdqKgQyS8G3kxOAI7ZTLRw=; b=f
 D+YtS9pfeJvI96UaLt0Wf/WeKRsf/hHHFnHxE4UFX2M7zJi0Q9ihDYd/HpQWBHc6
 UdVx6yGs6Yg2KnWhKBYBYU2XwTxKUE+k/HkHp0pvQ9trOQL1nm/GefAGse1QMiFx
 ltfsv+7xRx9oHiACLYvdroSbL5Jl/u0rwYfsNoKSXFrzoUiHkUuUquPko/1HvXun
 hjOHiWHbz4j0Gl4tvURQe9nBz4RujbFiSVPhqsy3Fj+sFuTNIyFUZtnFUR/K0n+x
 xjKvOaaL2zk5iYDPok+gw0ZO2uFGCtLlVbNxNxOgLx4MTG7G4vHWh2Y9P50jEPNC
 sxCCbj85GXF0S+aD6RNqw==
X-ME-Sender: <xms:8-1jaJ2bH_pSrtleOUA2A5nAtKtEEHBg1nJ_dWddvFPl6-1FqiN0eA>
 <xme:8-1jaAFs9scOcLYlq9K_qjVGXEuIcFWfzLBSCODxRgu04NiK86UW-tJN3eb_khgAh
 b1nWKvzK-M73puDvw>
X-ME-Received: <xmr:8-1jaJ46Qe9353ByZydrgvODsHK31eoLeEGazb26rsTDU8XY1J1IvObzMetHdFHGMJekfPVXcqmMJXlViohdFpffZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmih
 gtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprh
 gtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htohephhhonhhnrghpphgrrdhnrghgrghrrghhrghllhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:8-1jaG1V-8tvQQcJbZ8MM4LqiHRknUs1DRnaXFxFeKAZiC2cGwCmhA>
 <xmx:8-1jaMERgytstjwhx2XPkdyUzv4qV8S03UiI2S9kXFNevQqN4cdy7w>
 <xmx:8-1jaH-RlIWUIJXRBHRtSbvxceqpRtX9HX7oxsIilOWHURSpqaIoZg>
 <xmx:8-1jaJmeqxCkcpQl-jUPW5iaS6PzzDb66VuJcL5ZQ6V94sbhvWlybA>
 <xmx:8-1jaMcBYW1zt3TgmJ6841eY2jDJvhTlmboEVRCu2YNLcV70LDsOuuYE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 10:17:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Date: Tue, 01 Jul 2025 16:17:20 +0200
Message-ID: <4620749.daG60p0z9X@thomas>
In-Reply-To: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
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

23/05/2025 01:37, Andre Muezerie:
> The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establish
> no limit on the size of each element in the defer queue.

Very good, we need more unlimited API in DPDK.

> With DPDK 25.11 a hard limit will be set (``RTE_QSBR_ESIZE_MAX``).

I think it is a step in the wrong direction.
I prefer having no limit.

> This will allow fixed C arrays to be used in the functions' implementations,
> avoiding VLAs and use of alloca().

I don't understand this justification.
Why trying to remove the 2 alloca() in the lib RCU?


