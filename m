Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD1106ACD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FACE402AC;
	Thu, 12 Mar 2026 19:08:24 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 0D66040275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:08:22 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6AE5D1400277;
 Thu, 12 Mar 2026 14:08:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 14:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773338901;
 x=1773425301; bh=Xor/b4JtonGPEUjYEd8u0RlKNF/GMbXjcdWVK/YcD1w=; b=
 mv+QfY0kjJl+zML60r+9gawF64v3/bri+DEvsSmicT/oKmSxzm4nhdozyr3Xq51B
 PhnTXhR0CoaC4f9y4w7R9a0IqvkT2UhK9XoW0qvdPB4YvHcJZsGz7A3dGGzkmIZS
 cTXQwwL1DBHO7c2LwdUSqZ3Nb58S3z5ibngSPpq13Nd7pCbvB7Wk8ep2AVUO67+a
 Ul37+3OgfBZwG1P3vI2xAvfAd98P/nbUfsf2FQmAu+fs8XLQuSLan3CpuvSBDmbI
 pEmqqfmg+dS+Oi5DJv/apjpMqJCAz7rOtdPpp5ZZW88KKWCYWVq1xaXFQI08Mqcq
 mMxQYV4rxUo7/v4jDHrGHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773338901; x=
 1773425301; bh=Xor/b4JtonGPEUjYEd8u0RlKNF/GMbXjcdWVK/YcD1w=; b=z
 anX9LSMkg90FeTB6ENoqy+jlOlOD1s6fv/MPiAHlSqFpi+B9ICTyW0gkDVRSwXfn
 UB7GcTN1crMiirBAPdZE1wFEiodYRBX0TEjeKyoozXR0AGMa4RblgEEVeBmi1lWW
 yPl/XvaykjaSSXzN8Ph4BkGj0/zeTdUqnMAYIuBpXxn9DpBvwJXbDT6ck4iUt2qT
 0wsWFNzuW293ZAraUZshdZ7mMaWpDVYBbb8rja0RKCXNTzF4G7W2pAi6xHr9/7cW
 3qbesnQYSfh93uL6+XJIQc2nZwjHdF86lzbWil8OciDkI2NwwUL0K25kc3QuV+oM
 BpmFwH5fzPeCPqp3xfXEA==
X-ME-Sender: <xms:FAGzaWvDwRhZqd9CxinLg7bxf0LlGlq2zOyddiQFoEUPY8pibWheCw>
 <xme:FAGzab4MWKJ-NCxbpbn4Ozs5Ibkd0JEavE_CKOB8_U8aNie-rdPT303o86omu8RoM
 magnb_EKeLPR3z8XWSeW04ToPtKck8Zz69VvAXDUD2weQo1ZG83nA>
X-ME-Received: <xmr:FAGzaScdH4eNHA_3kHtPAnxUgV6X0NrvkR9JEbslSeG9CcC2oFkM0oMNsP7KeVguDZsbPDJrI-iyIaNxq8rGqVPUJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvug
 hupdhrtghpthhtoheprggsrghilhgvhiesihholhdruhhnhhdrvgguuhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehluhgtrgdrvhhiiiiirghrrhhose
 grrhhmrdgtohhmpdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvgguuhdprhgt
 phhtthhopehkrghirdhjihesihhnthgvlhdrtghomhdprhgtphhtthhopeguhhgrrhhmih
 hkjhgrhigvshhhrdhthhgrkhhkrghrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrvhhi
 ugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrghkhhhilh
 esmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:FAGzaYxaMKYEeNh_vwqYF4kJeMfXrmfI27TONzaiOOp45k0i_q-IGQ>
 <xmx:FQGzaX-OpogOVbK5PYRn-J_Zyar8EXOxO3-jImwB99brdSS-wYRoZQ>
 <xmx:FQGzaWzHeYJLpNio3oTMqlA4rseVv7sXy77PRbDevgLSnS4RfsvzGw>
 <xmx:FQGzafrIstJhZUB9AwAIgoh9EnHq9sT9F1e4qm2EJLPmryLIWDfevA>
 <xmx:FQGzaQnpCb5XY4bOaW0fFVcYYUmleFXcSPyIC0hTeElKCbVVJQoPVS4j>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:08:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com, 
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com
Subject: Re: [PATCH v5 5/5] dts: add crypto test decorator
Date: Thu, 12 Mar 2026 19:08:17 +0100
Message-ID: <8652174.T7Z3S40VBb@thomas>
In-Reply-To: <20260306164027.171723-6-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
 <20260306164027.171723-6-abailey@iol.unh.edu>
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

06/03/2026 17:40, Andrew Bailey:
> Currently, a test case is decorated to signify whether to use Scapy or
> TREX. This change allows test suites that do not use a traffic generator
> to avoid the overhead of initializing either one.
[...]
>                      if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
>                      or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
> +                    or (tt.test_type is TestCaseType.CRYPTO and self.crypto)

That's a bit strange to read,
because a crypto test can be functional or performance.
I suppose we can re-discuss the classification of the tests.
If the only need here is about the traffic generator,
we could make it "raw input" or something like that?


