Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39FFCAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:24:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7983402E8;
	Tue, 16 Sep 2025 17:24:19 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 88DB3402E3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:24:18 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A16647A02BC;
 Tue, 16 Sep 2025 11:24:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 11:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758036257;
 x=1758122657; bh=wKrsbbQCPCOtLFgJD/ig8zv2vmgrgXrfUKQAPCtNvGk=; b=
 r+HFvcmEBclngWYU9WVestXoEdQWEsdZomoqT4oTQgnZ1G+Uh2o+Jqugi/FaN+r2
 XiYWiIryuGY72oYQDwjbm+61ANWEJVqdU0aZCCZRkKcrsNlKGtBiO2YjgfABL6Qx
 Pqo6rOSg6fkPxryYEyxV6xgB5VFpa3vyckr/dKslTXkdmiwtdZbLC8Usm0IluRY1
 Pmw1fZ9pGbSkZ4B5M1r3EECb8GOgzoz4OkxBflNCWTaEAlqQEGsDw4JPc7ogdTnE
 P+p/F6ReTpkAq64CQcg1TL9ffUIAYhRrcBPQhGza/sAwtZiQWYAoJjnNsBECeotu
 qgQBYep8nyMNkAvGRxvbZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758036257; x=
 1758122657; bh=wKrsbbQCPCOtLFgJD/ig8zv2vmgrgXrfUKQAPCtNvGk=; b=J
 CJYe8zEE3a0YBpy0gb5oRomvHoKSrEgsN/eZ9lzLmMyUH1btwLC0XYHVaa77rGS1
 YoA2DJVremA8uWFiJKV42+Is3zUIONAbYYfI1imvjbSgwXF3F8AbCdu6pDhV2Lqp
 2tuU/ObZJIYzxk68QGBGpAzw69Fl/3FolzywAtj6vrkqVx1ikiHXtLtrmarfds3J
 1dHbcNcamZ2Pva18bjomZ7UHBmmlRwQKRcIDhSCKngfLxlhYwi1lWMHNFvbgrVQG
 cGVLpzItLs55QAIQ/HeSLgjc1/L0gv4ooc0rASAv/QM34qcZVggLAqkGvMdMw4xR
 TWJ0VoG9T+eC0jdUU2wNQ==
X-ME-Sender: <xms:IYHJaOBwoHljEkrH7HhkboBHV7IBfXE6L43yy589Kz-Jajc4BAt20w>
 <xme:IYHJaCICzhgOPfWfoDNKNqm4JBQBAQNN9hQrdVmyCt_sDHYjE_NqgEYpcWJpGwBpI
 aYM42AlybMYRv5Jgw>
X-ME-Received: <xmr:IYHJaBlsy8pn2_Djo6EkBhVKd8Bjul0jizuII_QVQTQSQeTE1ePxUfBSeboBvXtBFoLpUc6n1dk12JpdmB-hJcU5Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrrhhrhihhrggrrhgvnhesghhmrghilh
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehhrghr
 rhihrdhvrghnrdhhrggrrhgvnhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:IYHJaAGFRaXboVCqcikk-Wq_IH9WgzE8Eo5i5NaSbTg6KPfsBf_tKg>
 <xmx:IYHJaBELzzd2OLLkkmc9KT2zjgQcQXzBfEPSvHLc5fu1wWKyDYKkpw>
 <xmx:IYHJaNN3JiMPyxpO4MEgDPiSWB8zyKIC3ODTBti3buZgwQnKudvGaA>
 <xmx:IYHJaAEYHgJrlrIFaQNFhOjDUoBTzja361rAV3t_jJ7edMusaR4eug>
 <xmx:IYHJaKQxUjo_-JqMDSiSCU3m8DKTxZy5Hpk-NOUfSuxYZiIrxozflwTc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 11:24:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: harryhaaren@gmail.com
Cc: dev@dpdk.org, Harry van Haaren <harry.van.haaren@intel.com>
Subject: Re: [PATCH] maintainers: update service cores and event/sw pmd
Date: Tue, 16 Sep 2025 17:24:15 +0200
Message-ID: <117204167.nniJfEyVGO@thomas>
In-Reply-To: <20250904150605.1147639-1-harry.van.haaren@intel.com>
References: <20250904150605.1147639-1-harry.van.haaren@intel.com>
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

04/09/2025 17:06, Harry van Haaren:
> Remove myself from DPDK maintainership, as I will no longer be
> working at Intel or directly with DPDK.
> 
> Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>
> 
> ---
> 
> I'll take this opportunity to thank Intel & DPDK community!
> Its been great to be involved in DPDK, building some super-fast,
> relevant and just-cool optimized software. For all who discussed
> tech topics over a $BEVERAGE at a Userspace/other events, thanks!


Thank you Harry for all.
Hope to see you again



