Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8DDEDA694
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C096E40F35;
	Tue,  3 Mar 2026 17:24:43 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 3267B40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:24:43 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A46D01400058;
 Tue,  3 Mar 2026 11:24:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 11:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1772555082;
 x=1772641482; bh=xV3O9mgbR1VFaNH81KwPkt1DmghLd9YzN0WXfYc04So=; b=
 mXP4ozdck4yFdjeYDhy/S9iT5IXJUudBi5cVS8rnGYN0X99/J4N2vaqEGpvbGs6G
 aU6+JZv+qLoM9pfglhlv/m68ZEkdrVzEIWpVF9cSxAK+Ax3UtjIWlFFeyh6fqkxi
 g2EUlu2cVON7y2wmK62cTN/E6PWHQRRSlsVfcxf2NhtWoVUTMpcYOhGcrspd8LSX
 sQt7D7Nho5VVeYwoP9b3NWzl+BdEx/gOtt68dhSyQCUKkClo83fu0rFM4iV1WhvS
 FvNMEauuK+ElZNyzkno5ZQen988phG+7sbPGVxYtJ+DofVj7jUeayJ2MyVm55pEy
 jAMkQs7OMJwDj7bVlAr2Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772555082; x=
 1772641482; bh=xV3O9mgbR1VFaNH81KwPkt1DmghLd9YzN0WXfYc04So=; b=0
 Fn38eK5NNyingXKMOuqbWT0kHnFY0Cs3mEOHnhbZRWC+7C17nEngGgNOfwTh4Xtj
 65Ev/gUw0dVOQox/9hMV5h+NN26WkG1JcqbQ04Ce3RcNXZgNTSSb4qRU3K5mozC8
 Ri5c9jfsL5sNUS5OLpQu+yguEhdoLcve2Hqyd5Ts8o354TQyq2YS3u3FKNFgYNYE
 7Xb3pRPwiV/nPjqZdP50pQDax6NbfOAk9kW1O6IGt1hc0/dnpKbqbM2AqwpbZlC0
 xEuM97PCpKEFbhcRP9ekUZdUCzvWbc7cCcLk1DiwCwms+kAps6UrlmxjTI0HQ93b
 i+QQfjmbzMDj2c8oxh8uw==
X-ME-Sender: <xms:SQunaSYpvvEVYsyOnTT5HyAlaU-ww1Tvm68kGhaWDOp96gp6FlMkFw>
 <xme:SQunaXqtxai0yelC4ZOc9OEJpzuRkYsvl2KJURM5seIrg-MBPzqqcn9WZ2vDcGYC7
 FnbwqEEIhs9P429pftiSESjJFIAxTG3IoOkPFYo3aDA465FH6OuJg>
X-ME-Received: <xmr:SQunafNUwhm_5KqFF4I1P2ZlIiKaM5QaWDGn8cPekq2xvINlklokv4u4VN9z6TpdUJFKt5O7r2GWyYQz0YKRDAefPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepsgihrhhonhdrmhgrrhhohhhnsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrhhhunhhtsehinhhtvghlrdgtohhm
 pdhrtghpthhtoheplhgvvgdruggrlhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepgi
 hurghniihihigrnhhgvdeshhhurgifvghirdgtohhmpdhrtghpthhtohepkhihohdrlhhi
 uhesnhgvsghulhgrqdhmrghtrhhigidrtghomhdprhgtphhtthhopehjrghvvghnpgiguh
 esrhgvrghlshhilhdrtghomhdrtghn
X-ME-Proxy: <xmx:SQunaarrwyhE2PWzLz4YWUQXEqcDneMZNEvzlQSNw6iVUWXnTs31mA>
 <xmx:SQunacfnklVj8mfJiH3OQsnlAVtuVxHWgvj57YTmmhyYtHke0Qch3Q>
 <xmx:SQunaYTZivsH3NOfdPhWS2iu3F0HPXx4U48ySMXF3TXyWk8CfZoMSg>
 <xmx:SQunadaQFUulwV-Hz0LM0zp_zwr9IQVJBicBluQOr5odb0PxuGd3KA>
 <xmx:SgunaVXCFwltIwBax5r-KOk_cjQA8UCCh58csozHCDOl0g56aMbr30mo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 11:24:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: byron.marohn@intel.com, david.hunt@intel.com, lee.daly@intel.com,
 xuanziyang2@huawei.com, kyo.liu@nebula-matrix.com, javen_xu@realsil.com.cn
Subject: Re: [PATCH] maintainers: prune unreachable contacts
Date: Tue, 03 Mar 2026 17:24:39 +0100
Message-ID: <4490010.Lu9VnGXXGz@thomas>
In-Reply-To: <20260220145326.289338-1-thomas@monjalon.net>
References: <20260220145326.289338-1-thomas@monjalon.net>
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

20/02/2026 15:53, Thomas Monjalon:
> Some email addresses are not responding to "RCPT TO".
> Drop these maintainers as we cannot reach them.
> 
> Cc: byron.marohn@intel.com
> Cc: david.hunt@intel.com
> Cc: lee.daly@intel.com
> Cc: xuanziyang2@huawei.com
> Cc: kyo.liu@nebula-matrix.com
> Cc: javen_xu@realsil.com.cn
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Javen Xu has replied that it was a mistake.
Others are removed.


