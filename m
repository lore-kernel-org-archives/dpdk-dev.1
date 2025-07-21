Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320BC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7EAD4026C;
	Mon, 21 Jul 2025 19:49:44 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 232344021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:49:44 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id C0530EC0288;
 Mon, 21 Jul 2025 13:49:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 21 Jul 2025 13:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753120183;
 x=1753206583; bh=XRHA1MeUZ8w+1Hz1W4Qt5jfAtK7iKrxgstE/fJbb4as=; b=
 SbBiq/SmTiBibp/LxAVzF4uX8JFsI5ChM/2cjYI5UbhWPTNOJzcUXkDb3wWr6QjX
 T1MvBIrnXd9oJNqjTmBAHu3wVgQe+weWuj5obI5olg5O6lC1gpTzc6hdAX7RffuN
 JE+5cmkkHEdfaTBvZXhGx04DqoFWlK5s9YX7Ps9HsJgTAKhzx79iphH3ax04zoNw
 ElEf25PU0RL4gQi1qCjEICTihAPDFEERRjrTmVTz4p7YIha7O/Ph1X8cZryb5ZZV
 kMQrDk5iU3KbKfozJihQAuYw5QlqRSw4BV/QQ4ZaoYSnBSRKWe1SqbVjGhCUsQUr
 zR+TkMRaQvXa66UrtnttOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753120183; x=
 1753206583; bh=XRHA1MeUZ8w+1Hz1W4Qt5jfAtK7iKrxgstE/fJbb4as=; b=V
 FxNa+mpCkynW3KbHoqOiFc5xbXV3xT7mJ7WpEhrnyBbvhnS7gQPeGC7+pwU78iOb
 RrKq2GcIssIwShWnuZv8y+5c+k5DjyjI5V21xwgou6FTzQop9nO1NFO3jpCwkkvy
 94+9+zVKyHnynDawfC67R7icTi7TnxalU8w7VJz+CP+NyKv5JzDBux0ERsfYp/nV
 d5wWs8YkTOp32apVK+rDAibUlIIL4bAdLZ6K1DjCALnZ6lUn1lc9enibPSq4g2CO
 oF2rFQ25InR+i0KSa8+bIaGBRoQu+MsRDVlf+qFhhSCuiSoKc81ZsomqmGCPAa7J
 peXjPoWTQUzKA3qzYgYlg==
X-ME-Sender: <xms:tn1-aNcn3wbYtFhT_YSFH8sOT6Xvz7tF4fkAC1u4ImUuYsGaQpY6pw>
 <xme:tn1-aPyzfnm_w6pfvA9tFYqjrmxSoawANRuxM2x1r38mQbOHJfeBIZwMeXZRxXB2B
 vBY_8etoty9mEcSYQ>
X-ME-Received: <xmr:tn1-aDqK10XWsLvjmdgdMqfAY_G0vee6FpaX-YW-9qlM9Ds5akPVxxeg2JJXood_bY76oEF7AjXngAXr3PhV_VQutw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdejvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopegrmhhithhprhgrkhgrshhhshesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehvrghtthhunhhurhhusehm
 rghrvhgvlhhlrdgtohhmpdhrtghpthhtohepghdrshhinhhghhesnhigphdrtghomhdprh
 gtphhtthhopehsrggthhhinhdrshgrgigvnhgrsehngihprdgtohhmpdhrtghpthhtohep
 hhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhmpdhrtghpthhtohepfhgvnhhgtg
 hhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:tn1-aNyHKV9QgR9cH2joMhtZ2vvmXZYSxzxToMikn5dFShCAd42fqg>
 <xmx:tn1-aHqVw2IwRI2cMq7MyksmcyDVtUWehSdUOXLY0_xq-X5RmyU_jQ>
 <xmx:tn1-aNfg0Aqf7FiRv7-SI6LaAgbbT8itdRtG3rYpUUfj-2A1_pKtJg>
 <xmx:tn1-aKoJjBhEIG_dVQXuuR4IZJgFzK3hX6wUu7tILYabB13v0nCjMg>
 <xmx:t31-aAIQjRQIhnW5ZhEnis5Or5lr-QzWgP7oLaxqnrPhnduPCd31Zx9N>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:49:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, dev@dpdk.org,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
Subject: Re: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Date: Mon, 21 Jul 2025 19:49:39 +0200
Message-ID: <3307880.vfdyTQepKt@thomas>
In-Reply-To: <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
 <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
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

> Deprecate rte_dma_conf structure to allow for a more flexible
> configuration of DMA devices.
> The new structure will have a flags field instead of multiple
> boolean fields for each feature.
> 
> Signed-off-by: Pavan Nikhilesh <mailto:pbhagavatula@marvell.com>
> ---
> +* dmadev: The ``rte_dma_conf`` structure is updated to include a new field
> +  ``rte_dma_conf::flags`` that should be used to configure dmadev features.
> +  The existing field ``rte_dma_conf::enable_silent`` is removed and replaced
> +  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent mode
> +  the flag should be set in ``rte_dma_conf::flags`` during device configuration.
> 
> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>

There is only 1 ack.
Per our policy, it will miss the release 25.07.

You can probably do this change anyway,
and keep ABI compatibility by versioning the function.


