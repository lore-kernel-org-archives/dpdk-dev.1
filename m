Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A40BCEE334
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86F0B402EB;
	Tue, 18 Nov 2025 17:31:44 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id C9C87402EB
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:31:43 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 602E1EC00FF;
 Tue, 18 Nov 2025 11:31:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 11:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763483503;
 x=1763569903; bh=kOrJeePTiyMMnLGnVYjZDMubW2shCoiSAglsnG8wfOs=; b=
 BpvfInW4Y6N0dQYlch+HV+sP2Ktls9kh8l/MIJtKZBefc/rTgKqGG+UUO87vEhWT
 iEHiHaGV7isu4kxIksZ4TagFnxZxYjoFCxax3BMYzjlMoRQ/llulqo7iZQqEo0eA
 2RTBXORrXH2ml9uxVpNTEw74pxPlGOpRffUx8hQYwLvuezcb/EWUc5cANx48OV4k
 MY0KyQ8uLU/oOWzJ2hp4Z5+Hp9c7SMaXSHvgxF3RcR2N8rBNHvGTpGAK1H9Vj/6a
 FGO8XumGWgc2E6DoQcX/eUyHCtCqxGB9H8CqbbrzCwCETfYIZ2pGE9Va6Q4bmcBX
 d8uJnXvHTjNpQolgYr+tGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763483503; x=
 1763569903; bh=kOrJeePTiyMMnLGnVYjZDMubW2shCoiSAglsnG8wfOs=; b=V
 sN8FBZgFClkw6UwNlK2k1Lx+3hsWwCQgg4vgLOYb6SOwNx6DDGNTR8ostTxpJAQK
 sW7BxNhMbJJzOgLYzoed41jLue23/BVqC54ZglZXho0XwuNi7xLezcHqqDKuKfSt
 bTRVPj735eWVrEVtmhBHK/cUS9Tp4u38lQifg4x+Sa5a09EX34bl6G6dLQoeOVmT
 vp7hchy/fmhF2NlAkfS3EmhT/daTLPhI4TO5EyejpFSBlFTFZeaSyD4BQSN1Y1+o
 GcmkRZGzkT9Wp/4kBppykcuPYjEtY0pX5SD1T0wKCkaK8vnNU8cWbndQ67DYuCPx
 lM8GbIKbcw8VRNbFS5V0A==
X-ME-Sender: <xms:b58cadEZMpQUZZph1zQnDbMcsqmFnkye-Wa1gQpUQvzK4QHR5ez4eQ>
 <xme:b58caSdFxDG1KeKOlkIxS8UnJl9AQY7MXS9yFYfUrCo7ez3kh5bFB4XeOWto8kUKC
 NN9bdQd6yPNw6SxRSXDPuYLtd2Oc1SRW1EcbXA7jKlPFSG4ipTpnw>
X-ME-Received: <xmr:b58caXGFeYZvc5FF5VMSNDfoTRNJ7vKLKVVrltmhgwzCCcdJC1fGA2ZdaYyksciI055Fe01AQ2p-RxBCEjQYvIj6Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddukeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguohhughdrfhhoshhtvghrsegrrhhmrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepnhgusegr
 rhhmrdgtohhmpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvsegrrh
 hmrdgtohhm
X-ME-Proxy: <xmx:b58cabUX_NRtseMd37yr43XWJnDZhG2mthqKEO7ON8riXsd30AicRA>
 <xmx:b58caeLDaGs0hsZoG5zxPgQq9HsQ2kp8FNfkqFLBrJIl6Rhzkg7yig>
 <xmx:b58caT-BEEWbG7tZyPXyg9YKCPZhzcCF6Ejz91PmBsYHIzeouCnklQ>
 <xmx:b58caZLXerE7Ji_FrESiTN4yMRQEjUiVQBC1zaiYVgXM73SUxeRanA>
 <xmx:b58cacgp7_LxpoK9-IlJaMSY0kWRquwJ7lDQIL_XEqc9WEQn3zscm6V2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 11:31:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Doug Foster <doug.foster@arm.com>
Cc: dev@dpdk.org, nd@arm.com, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] config/arm: update mcpu for Cobalt-100 SoC
Date: Tue, 18 Nov 2025 17:31:40 +0100
Message-ID: <5946885.GXAFRqVoOG@thomas>
In-Reply-To: <20251111190639.3470596-1-doug.foster@arm.com>
References: <20251111190639.3470596-1-doug.foster@arm.com>
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

11/11/2025 20:06, Doug Foster:
> Update the build configuration for Microsoft Azure Cobalt 100 SoC to
> use a CPU-specific mcpu value supported by GCC 14+.
> 
> Signed-off-by: Doug Foster <doug.foster@arm.com>
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

Applied, thanks.



