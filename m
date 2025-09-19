Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE18CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 10:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C814066A;
	Fri, 19 Sep 2025 12:41:45 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 48A9E4028F;
 Fri, 19 Sep 2025 12:41:44 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7BA2E7A00EF;
 Fri, 19 Sep 2025 06:41:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 19 Sep 2025 06:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758278503;
 x=1758364903; bh=6nayxKsoQOzDHp80lBfNHCUSmjnmXqtUFvCHHPUb4hw=; b=
 HXEWkvie6tMVSlnO+yDuRFcvP96yBMksmAmQdwza7g5O6MKKOiAwbRcdTsqYX4Oj
 6cjo5g1JR4AiN1Z57UAOJK3r/uYXQ0ndBq1pwvkheEqVK5eDre/EZ0e4PNZKZQV2
 LokjDswPcSWADmm9hW/+/lHeZ9po3VX14CQ6CBnQ2ZfY7n7Z1+DCyo79YuvrIV49
 VvIrUhP9keCjJkADslcR3kDT7V2CQaMor4OD1/GcLAz9gvAFn/VH1LHPa8lXrUNC
 eEVob8wmWNrqL2zLn09zRDhuheu8fK7Gcz62lGIWNBNNHSiEr1m8VtZMpDUi+adE
 A7IX0AtJNizTYmF4Vz2mPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758278503; x=
 1758364903; bh=6nayxKsoQOzDHp80lBfNHCUSmjnmXqtUFvCHHPUb4hw=; b=H
 GfepQmHeio34N4y10ziQfwnDdXjikELha3261UyxPVb422W2YiDbIcsoFd20ZUxk
 Yi1HPw8ym1/Cy1mbM0rmmxI3FeerJbftCuYNSxaaUTIMHXYHg2x+M20M4Kd8E/cS
 AX4SOcrvniik5YRNmNXS6lkVUzp4RlYoODgJ1m/s0YsrRWfvQ+q4USeY2ZDPDQBp
 wZxCV6hu22awSvgWlHJEyo6XnedcjC+uMlwv5cSflVesE1qb8JC3CvnDDNeGGa1+
 9w8v5OAHzLiulbZzBAlo6517WHaGqaoL+YX8dlitYmbtViSzstVT3Gw0QgNHtBZo
 0DYcauPX3nPawgI3SaxWQ==
X-ME-Sender: <xms:ZzPNaDxoZXZ6HTEPigoW_qP_jG24XyyYw3rKsiVt6hb4J3rIVqVtUg>
 <xme:ZzPNaFRnDBlEBhfJH5T7YFzdOc63NIvKqjJpApqp-kuSITnZDcTTmsC8H0wHXykNY
 Hu6E4sBkQW8kh6xew>
X-ME-Received: <xmr:ZzPNaD8FzBCpBE-DVK5b55t7E8DHymReyYFAzBQxhSNKklkSRi4u4CnOXhaDrkqsJHVJdgR7boZGVijBwLksI26dUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegledttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghl
 vgesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhkohiilhhiuhhksehgmhgr
 ihhlrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhosh
 hofhhtrdgtohhmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgv
 lhdrtghomhdprhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgtvghrohesnhgvthhroh
 hnohhmvgdrtghomh
X-ME-Proxy: <xmx:ZzPNaLvTYMy_UN0IW8slkEPGz64dt9SLIOI5a0z9AVqE4nMYO1s4kA>
 <xmx:ZzPNaDN5m-Bms6LKUYdhJ3ruMUJNzvSOoHoRzK3UZ3X_ZeD6smNKNA>
 <xmx:ZzPNaAhNzngOPXC0xvJR9gEtEjmLNT7N4F6nusaIvssqH4aOWxuPKQ>
 <xmx:ZzPNaF7RiUN3eCIFHeC-IJGTFZLlCqCzMDDMP3KCyZ36IlUEdOdwWA>
 <xmx:ZzPNaLB8OcND-085bOHMDEOi6inH4b_FTxKSmBP-5rybSbrNSh05MmRV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 06:41:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alejandro Lucero <alejandro.lucero@netronome.com>
Subject: Re: [PATCH v2] eal: fix DMA mask validation inconsistency in IOVA VA
Date: Fri, 19 Sep 2025 12:41:40 +0200
Message-ID: <7662076.G0QQBjFxQf@thomas>
In-Reply-To: <MW4PR12MB74846210744CD9A67CAC7A92BF16A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20250908163456.420268-1-shperetz@nvidia.com>
 <20250918064754.6116-1-shperetz@nvidia.com>
 <MW4PR12MB74846210744CD9A67CAC7A92BF16A@MW4PR12MB7484.namprd12.prod.outlook.com>
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

18/09/2025 09:55, Shani Peretz:
> From: Shani Peretz <shperetz@nvidia.com>
> > 
> > When --iova-mode is explicitly specified in command line, DMA mask
> > constraints were not being validated, leading to potential runtime failures
> > when device DMA capabilities are exceeded.
> > 
> > The issue occurred because rte_bus_get_iommu_class() was only called during
> > IOVA mode auto-detection, but this function has the important side effect of
> > triggering DMA mask detection (e.g., Intel IOMMU address width checking via
> > pci_device_iommu_support_va()).
> > 
> > This created an inconsistency, when choosing explicit mode, the DMA checks
> > are bypassed, but when choosing auto-detection mode, the constraints are
> > checked and enforced.
> > 
> > The fix moves rte_bus_get_iommu_class() outside the conditional logic to
> > ensure it's always called during EAL initialization.
> > 
> > Fixes: 4374ebc24bc1 ("malloc: modify error message for DMA mask check")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> 
> Rebased on latest main. Patch was already acked
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.


