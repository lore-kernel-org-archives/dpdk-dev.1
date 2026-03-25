Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B2109E52F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 23:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA73A402C4;
	Thu, 26 Mar 2026 00:53:21 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 8F56F40285;
 Thu, 26 Mar 2026 00:53:20 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id F1F4EEC0192;
 Wed, 25 Mar 2026 19:53:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 25 Mar 2026 19:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774482799;
 x=1774569199; bh=6bhvgfRp4C3oJYSKhMVl6xGdWRWxpNimqKuaUNE9PPI=; b=
 IIpVJrJWt7dulPgy/J1niax6UfY0u7+lWBd34uQ9N5qQAkvFyyEaYwAwg6MPBWtq
 /DEMlom69ubPCIewPMBN5A08mYNpnU18oaoaXiSFlTHossvDjK2cyfpN6o255V6e
 cLAS5wEAmyeT1i4JG8adu0PJhQfEbnHihPQFRYAi2GJAUpVUMn75mT/dWgwvyM5j
 /KyG8Vosq2XV5955A1uY5Q/17ikJcltE1AfZkxD1Q7a1TXyETpX47fT7oRyA/d96
 ndcxA7sTmogHYYGn4m0mhkMz0Zq/T3XLY4kYPdFafjGIU+SQWdA98CwDuO2at44s
 Ykah+FPeUqejwRn2Px5nAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774482799; x=
 1774569199; bh=6bhvgfRp4C3oJYSKhMVl6xGdWRWxpNimqKuaUNE9PPI=; b=R
 +YqqmnCjXgjTc+mi6nAvrpFIKFLNcvUSQSvVeaRfFeHv+4I0DM2L8BxlFCukJwyG
 0uLx4YE3wgcJF1u81cMKObf/2GWhGP5FG1N4xfKY1xPPGdW1U64cc4GoP9OeCAds
 8AdSr8fX1OQqUHZJ+fojOr1BDROPEKoGuXa1wHyrb27uWC51KATwHTKDHW5cYspq
 NIACm8LJinghjBUm0AqfZXyiB5JvmwDUrjstQUwDfbtW9KbML5vWsd6m215ZDkoI
 KNRuhDZxMpisDYQytihGiTJGeE3bdcP7oHWPJpFMlJfhUJzW96zFO9BvN7RqrEDu
 mxsofSwdSacbiJBll2ncA==
X-ME-Sender: <xms:b3XEaTV8FVgZK19dzHJ3wl5G4kKlHihJwXpEIpT_Ztwzderey8KXXA>
 <xme:b3XEaf5rMeOayGXMRQtgM-b9pR2a4m9dimNzZ-ubAJwnSQ1J-EzTvXbGAG2P7sqjG
 _EeKoteszSvTPCtAo2srKAZCfzm7v4feklZ2haLvwHXcOUaJpO1Dg>
X-ME-Received: <xmr:b3XEaejhzdB-Oa6SWd2R6xTfgY8Ff6fl6GTa5aB7uVItXMXzV8lUTgq6b_Qf8nI0OqHn1Awq7XI81pRpXgCrgK7Ezw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 vhhiphhinhdrvhgrrhhghhgvshgvsegrmhgurdgtohhmpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:b3XEaWeXUQSHv4s1DwI246nFr6EQ5hBOxvXgLm5YlRAvh3-ZZwEyvw>
 <xmx:b3XEaTcJNj5H9XQbRRIyIta_U9ncObKeLTH0OuXIqdtPySSRGawM8g>
 <xmx:b3XEaQ_axyLwWpjyZSuQHmKc-MHdS8inE4Nq3qVzVml6qAMwXrEBUQ>
 <xmx:b3XEafnNNs-NOGC4GoTi5XffAzbyuyuOnVQhlimGg0f6gYqcwXxspw>
 <xmx:b3XEaQlzh-ha3gdl5Ms8jTZrV76x-6OBBo7Ukrge4MyvWljpTgmDUWXT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 19:53:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: vipin.varghese@amd.com
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] doc: update AMD EPYC guide
Date: Thu, 26 Mar 2026 00:53:17 +0100
Message-ID: <16586827.RDIVbhacDa@thomas>
In-Reply-To: <20260227143133.510-1-vipin.varghese@amd.com>
References: <20260227143133.510-1-vipin.varghese@amd.com>
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

27/02/2026 15:31, Vipin Varghese:
> 1. updated URL for AMD SoC tuning guide.
> 2. add `ASPM` disable for latency.
> 
> Fixes: de1f01a8eabd ("doc: add AMD configuration in Linux guide")
> Cc: vipin.varghese@amd.com
> Cc: stable@dpdk.org
> Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
> Tested-by: Vipin Varghese <vipin.varghese@amd.com>

Applied, thanks.



