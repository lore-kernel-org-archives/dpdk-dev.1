Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290FC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 10:59:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2C0402AA;
	Tue, 12 Aug 2025 12:59:55 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 22CCB4026A;
 Tue, 12 Aug 2025 12:59:54 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E6C407A0054;
 Tue, 12 Aug 2025 06:59:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 12 Aug 2025 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1754996392;
 x=1755082792; bh=cINe6mFzjPtpmW3rRC2d7KSFcKIb/ywJwa6U42H8wrY=; b=
 Sw2BzpxRO4rG5QutbMGcWh+kVgvgTljuOmrUq1+aMr6h6ugNea1tiRXkvisVJeDR
 oUuCDHgj8rIDksUbZoVbS9iJU+mdq5krP/4BgFX/6AdvVwA/ALpZU+26mxFV+PVd
 rTsstrzdtHWmMwql6w68kuzPIBA9pblLydE5o38ugqAsgdFQVAw6dsfQvPK+qYKd
 aOSFhIjMulAtnc0rAMACR5rNi333XE6uE30THyU2qTW3qy262bUdMzCESKUTKT1J
 kCaK+SjEhSft/X9gv4FS8zsjbcFfvbZpTCAN5ZU6SB8acZGekq/SBABr6rUmwfYc
 wTfR3uGY8H7wh8MpPXd7mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754996392; x=
 1755082792; bh=cINe6mFzjPtpmW3rRC2d7KSFcKIb/ywJwa6U42H8wrY=; b=m
 ZBsjk3b25F0KRRy3IWB2Rz6SkvtLCBf1bUmsvIOWnIh9EPv3j8K7f51lpEWxS7kb
 WfPkHg1XfSIFCBYVMuvsRLHXVXeRqqUz8IPWYihLhx0wq/x/CBFcrg4RSEob2Xvq
 BudZbTQC0N1IlwI6zSddOztUmNdf3I5FPYzvm8Qjs9zEjm35TkaAmCsl/tDtWSYa
 iZL9i6qc4jlXxc29UOWsSShQ8gmjZQwiKflXLvYkAIrJLGVO/stsauOIEX+uyG23
 BsgcIjwsy4GbZZ1S0CGS7vwPN6vQLFxmf1goatkP7xMpQBhSUl19djwXyWrDCdaO
 VXWoRD1WqHn3bFhIH6azA==
X-ME-Sender: <xms:px6baNa5b1_gKi8K_GPEIol6Rc_klOAmtPwgzfRUAs88PlV0anPI5Q>
 <xme:px6baDVp-3x_A-rO3Ei_x6ETlYwFuf37ZEFF8yYGgb2SGikQbKHf8Z-0WKyEXUeBn
 cXQomqPGqEWDJLhuw>
X-ME-Received: <xmr:px6baMDcFz5rkubzZ_r-7ZEbvBGgfhZy8Z6MsatpC6pSnD5ceVesxjmMcxRQLvawWmFzvEI9_XHa6JMbxOW6M2XHlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduiedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigv
 ihdrtghomhdprhgtphhtthhopehtvggthhgsohgrrhguseguphgukhdrohhrghdprhgtph
 htthhopegrmhhithhprhgrkhgrshhhshesmhgrrhhvvghllhdrtghomhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllh
 drtghomhdprhgtphhtthhopehvrghtthhunhhurhhusehmrghrvhgvlhhlrdgtohhmpdhr
 tghpthhtohepghdrshhinhhghhesnhigphdrtghomhdprhgtphhtthhopehsrggthhhinh
 drshgrgigvnhgrsehngihprdgtohhm
X-ME-Proxy: <xmx:qB6baPLtYEKxTE4OEBq2ry3MvT_jxwCBQv7FallnqTQ_-qSBQt9jdQ>
 <xmx:qB6baKuLtuZ3e-gwaHrzzV8bQOGK0RZqSACPznGERF14TLQONUvlOA>
 <xmx:qB6baHUkhGMsIXrCZIAM5AoJL6HUZ3C5BkxUJVT9lLgyecDnd97Crg>
 <xmx:qB6baFIDlN3GffR46miwHgdmaToxxNbgNd6UKY1Udx7rCtJMiJ-ohg>
 <xmx:qB6baEoMKeh-Q-1hY6242px-Ain8iHDRZAvlEfFLXnrm7aq9qcyonlNe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 06:59:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: fengchengwen <fengchengwen@huawei.com>, techboard@dpdk.org,
 Amit Prakash Shukla <amitprakashs@marvell.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
Subject: Re: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Date: Tue, 12 Aug 2025 12:59:48 +0200
Message-ID: <17207459.geO5KgaWL5@thomas>
In-Reply-To: <PH0PR18MB4086088F7E9E8A4D257B658BDE5AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
 <315e032d-c022-4ea2-b734-3d3a07f5ebc2@huawei.com>
 <PH0PR18MB4086088F7E9E8A4D257B658BDE5AA@PH0PR18MB4086.namprd18.prod.outlook.com>
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

28/07/2025 07:11, Pavan Nikhilesh Bhagavatula:
> >Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> >
> 
> Thomas,
> 
> Now that Feng Chengwen is ok with this change, can this be merged
> along with the ABI breaking changes in 25.11?
> Given that techboard approves the change.
> This change helps reduce ABI breakage when a new feature is added.

I would be in favor of this change.
Let's request a vote in the next techboard meeting.
(Cc techboard@dpdk.org and added in the meeting agenda)


> >On 2025/7/25 14:04, Pavan Nikhilesh Bhagavatula wrote:
> >>>> Deprecate rte_dma_conf structure to allow for a more flexible
> >>>> configuration of DMA devices.
> >>>> The new structure will have a flags field instead of multiple
> >>>> boolean fields for each feature.
> >>>>
> >>>> Signed-off-by: Pavan Nikhilesh <mailto:pbhagavatula@marvell.com>
> >>>> ---
> >>>> +* dmadev: The ``rte_dma_conf`` structure is updated to include a new field
> >>>> +  ``rte_dma_conf::flags`` that should be used to configure dmadev features.
> >>>> +  The existing field ``rte_dma_conf::enable_silent`` is removed and replaced
> >>>> +  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent mode
> >>>> +  the flag should be set in ``rte_dma_conf::flags`` during device configuration.
> >>>>
> >>>> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
> >>>
> >>> There is only 1 ack.
> >>> Per our policy, it will miss the release 25.07.
> >>>
> >>> You can probably do this change anyway,
> >>> and keep ABI compatibility by versioning the function.
> >>
> >> Hi Fengchengwen,
> >>
> >> Are you ok with this change? If so please ack it so that I can work on getting
> >> an exception from techboard to merge this without deprecation notice in 25.11.
> >>
> >> Thanks,
> >> Pavan.



