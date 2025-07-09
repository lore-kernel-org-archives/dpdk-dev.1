Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CEC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 15:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4EB0402A3;
	Wed,  9 Jul 2025 17:56:54 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id B9C0C4028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 17:56:53 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EEAA57A0189;
 Wed,  9 Jul 2025 11:56:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 09 Jul 2025 11:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752076612;
 x=1752163012; bh=/1caQ7DM5fAY8yVuknKxROW9R6hoTvOisMXG31D/whQ=; b=
 AsL1WO6aDjItzN0ESS5cS8tIT1aPo/mp+G/Yk26vZ/loqsCaTcCSIIYuou3Bi+mw
 i2jbZZBQ0DzbdF5VF28UYq/YGyUTkxrsorE1yx1hGkK74xOHfZLxMpp4Wntbecs8
 NiHXY0m/h5lG6v1+N7X/MOb0i5PAXeMW5c/kyuS2tSwELqOHAs57H/mwZDAnh98a
 EMVRm84YEXNjHL9+kqIREYzvLVIt4MIRJEJdQJXaVH6zMbmic1T2mOwR42QfXVpV
 N6U9IjVG8xi3bi/6vdjq0yz5BqAaXDnyDnBt6KccB50hjFB1wA6AYt1NW2eqag+N
 pFb9j+UKTEt75ZPjGR8+qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752076612; x=
 1752163012; bh=/1caQ7DM5fAY8yVuknKxROW9R6hoTvOisMXG31D/whQ=; b=Z
 2Pn2V3GYi3AjO1hVKtDBDE+42aWf3UzHXJS5BcWAJfJk6KTrdGGIizpvL6qhbOpx
 LDGLxpQD/7v25NB/PzK9ieBO6e48cAlccCyB04JYrXV+AS5T+o1ApeivNU+Brj8V
 2FRBRDvSFKpsr92V4R4ugV62r3jjGOhURZHB9/VILlkALz2x7zE3HgEPQCMp0tF7
 6KBBxdRymqQ8drBA50FJmDF+zw3BYIILq9X4U6NvqFBIQmjczktA8DM7Uz591taI
 rlOGYvx49Kt4jJgUCA9BPIMY0yd6oUZv7R9HPrLdGHy3Gu9PxBx1tpMgs8TL1IVF
 /G8X5oQ9qGXXrgPnRT4Vg==
X-ME-Sender: <xms:RJFuaOVt3LWsmev83A1oXvfiq2Ge3kAfdvh47FhZrU-S2-8qPtTo8A>
 <xme:RJFuaFeShcwbWGTAeRk_NowK1IoxmDC1YoYUyYWUd1_UNhqD7pW9GkQlk5scsyuUX
 DvW5PA1FUEkl-JzjQ>
X-ME-Received: <xmr:RJFuaKM5vNO3sMhFVS7C9e0iDQ-DiBxhsyzdwa6-GaIWuQZDgowNog2LpKsRpYzf944zyR2HBi9kiG2D2DP9RH9HqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrnhiivggvlhgrhhhmvggujedufeesgh
 hmrghilhdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgt
 phhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnh
 hvihguihgrrdgtohhm
X-ME-Proxy: <xmx:RJFuaDgKGy29B_Wb7VWlJqbEUPCAEpy2lVgPzqBw5sEyvJTyasnRAg>
 <xmx:RJFuaN23cVTbjl9gvxp5s3lPSAUNC6_AZi-QA5kMsOuACtyztvN0MQ>
 <xmx:RJFuaNgMmfLt5Te4igUSrTj0pn9mkD9scYaIEDPPPi8XF3BYlyFq7A>
 <xmx:RJFuaNfVakIjVyrWiT7WWyAwqgqTT-SdJHpwMP2-hHXCv9by-k5rRg>
 <xmx:RJFuaDTrm6Mitg3C9Eivu8qfkh0QT09wA8NngsUoVBfY1cG2itmJvQin>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:56:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
Cc: Ori Kam <orika@nvidia.com>, dev@dpdk.org,
 Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH] examples/flow_filtering: fix make clean
Date: Wed, 09 Jul 2025 17:56:49 +0200
Message-ID: <6926478.STdkYbjpsp@thomas>
In-Reply-To: <SA1PR12MB94916D6069CBED1D815FA460BFAE2@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250329195333.324178-1-tanzeelahmed713@gmail.com>
 <SA1PR12MB94916D6069CBED1D815FA460BFAE2@SA1PR12MB9491.namprd12.prod.outlook.com>
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

> > make clean is unable to delete build directory because *.o files are not
> > removed.
> > 
> > The other way to fix this would be to add all the c files into SRCS-y.
> > 
> > Signed-off-by: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
> 
> I checked and looks good on my side

Applied with fixes line, thanks.


