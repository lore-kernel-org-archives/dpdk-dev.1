Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E831C021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:13:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CEBE4113C;
	Wed, 12 Feb 2025 15:13:24 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 402B04111B;
 Wed, 12 Feb 2025 15:13:23 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id E0CE413808BB;
 Wed, 12 Feb 2025 09:13:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 09:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739369602;
 x=1739456002; bh=FVi0dY9b7NMLPmsz/x0IXPhwJtv1RC3vUvgfOKS38U8=; b=
 JdeblpFXpzlmuAGMsQIyCv1RoNZJ3ckVCwQkUR0zbnUknIzvi4P5Vq2kjACZ5h+Q
 zLeAEC4u6gEHriYgZX8cIc0h2v2n5CO4l6wB8NmKedBwoc2tkFo8U4jdIYMWWAeM
 Au2jeHBCBHkVC6MUQnh6zCI8nxtUZeN22skwKwtRvCxsC7VWE3AIP+Swclzo8JYe
 3M5Wdq0jKW7Ro7wN4CJ8YRmKudj3IopRF2y4DrDe1mineEEH95CHajIZ8OvtoLk7
 9sgUVlP7pRitoeeDtUhVTmGGdvMJSNR7diHLCUv3utDzLhr1iQtnj23eqPO30FVc
 KTaZrjy7ttbI+1L3EzGwRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739369602; x=
 1739456002; bh=FVi0dY9b7NMLPmsz/x0IXPhwJtv1RC3vUvgfOKS38U8=; b=O
 NSsnjqCkWeLhsrgyTG2JBf3CtDWZZSdtOTmgTKGeyCjf1mbmP9iFEtld0TXRMTyo
 EoLW5Ofid9Jjag4PQsfi3EAm84IzuIh4FtRK9JQFXZYUtxcU9km28ZPyAlDjQf3Y
 W5X8oKEmZ+LlUODwPukmylhJVbI3ZVb862pdIDPo772dnCR5ifuRroRzW7x50PjK
 WDmDgrahat36il3V+LNLEToW1l95K4FjoGXwcsCmt2LEts8iYZfTdqphxGVQc7dU
 aeMay3oKBiK0TJeWSwRf2lJUd1f7eLt/XrHdepelFljRDZ+YpiWuKXO2zHhWjuhn
 kn9aqMtvKpNY9s7RyA67A==
X-ME-Sender: <xms:gaysZ9Q-zN_YQDdGB5T1R6ktV99ZGnPPoTqVgYGuuJqr_MijtyVq5g>
 <xme:gaysZ2xUz9VbAz8YnO3-fiCrO6hZ_gqtpRR_GXqSu-TnqWSOEF2a8Y4tYdIZjyivL
 phbe-57psnmYBVfUg>
X-ME-Received: <xmr:gaysZy1SEMKv7UxgY9r30e_pI-HEFz13ZmOdVmzlacNHPHxyHmAsVMU6oLEwYG_W_RTiYqoyJBPkhi5JwYfcTXjM0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepkeefheeftdegtdejheeuuedtgfel
 feeiveekieekleekffelgfdtveeiheehffdunecuffhomhgrihhnpeguphgukhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhho
 mhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopegrrhhivghlrdhothhilhhisghilhhiseeifihinhgu
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrg
 gslhgvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnuges
 rhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhose
 hokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshih
 shhtvghmshdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhigvvh
 eshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:gaysZ1DXJlf1MHn6UP22n45xmYoIdtLJ5ZNB461dK3HOGRVog3p7Og>
 <xmx:gaysZ2hR_xqULsytG60450EA1xfFwxi_Af3hiXuiKe5SOzHKGHF0CQ>
 <xmx:gaysZ5q1n55Ytndbjf3Qp9f8EqrBCMKkouJVkcKepd6yKEn7Oz3VUg>
 <xmx:gaysZxhAvm8LkrHrgpWMteaHR38z8haXhk7bKrluxz7BHI1aXc9iTQ>
 <xmx:gqysZ6jRpps16rGPQZVqQ0J3eaedDdvo7tNLgq7VU0tr6qNNyDF5QCOw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 09:13:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2 1/2] mempool: fix rte_errno in rte_mempool_create_empty
Date: Wed, 12 Feb 2025 15:13:19 +0100
Message-ID: <6280906.YiXZdWvhHV@thomas>
In-Reply-To: <05499f1b84b6459caa413b6f17fc5e8c@huawei.com>
References: <20250119174643.2162110-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-2-ariel.otilibili@6wind.com>
 <05499f1b84b6459caa413b6f17fc5e8c@huawei.com>
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

07/02/2025 15:30, Konstantin Ananyev:
> 
> > 
> > When returning from rte_mempool_set_ops_byname(), rte_errno is not set
> > for error exits.
> > 
> > The API requires rte_errno to be set in that case.
> > 
> > Bugzilla ID: 1559
> > Fixes: c2c6b2f41305 ("mempool: fix default ops for an empty mempool")
> > Link: https://doc.dpdk.org/api/rte__mempool_8h.html#a82e301ee33ed7a263ceb4582655dc3ea
> > Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
> 
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com> 
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Adding missing Cc: stable@dpdk.org

This patch is applied alone, leaving the second one for consideration or drop.


