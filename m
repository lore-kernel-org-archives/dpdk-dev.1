Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC0C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 09:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 979FA402B5;
	Wed,  2 Apr 2025 11:01:57 +0200 (CEST)
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by mails.dpdk.org (Postfix) with ESMTP id 175D540275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 11:01:56 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailflow.stl.internal (Postfix) with ESMTP id 0E2FB1D4162C;
 Wed,  2 Apr 2025 05:01:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 02 Apr 2025 05:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743584512;
 x=1743591712; bh=FpHV6HxSAasPU/R+78mgHlSGiU8BCw4fMonsQ6K+SfQ=; b=
 eMWzeFm35V1ecxGQ7j846bvRzLPWjw+c72HdwhysAOPaAJjXxjKPrjnN9q6XAM4l
 kG/gos7r55B53Dqq+LikoouE2GbDkimUPQD3MV2qmKc3Y9SpRrOa4J8mSu9a8xz2
 zzdaOrx20b9vdkEjI+o0LFk2LtlaLQlcllJ9Bdzq55lIjryN2vSo1n2iTsOurZD4
 hfUaxn8dUt1XHcsCIn3c8Z0r4bvbp6cFecnec5Fmvof54NNdMnD2f76wZ9JwD1GB
 cycf2DwlhSGO5YW6YEPzmx+gPHUZgkx9QX6bjL6Oublh16EETXKBDTWhpfGFDUG7
 J/2a6eXsSe91CFh3CaMH/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743584512; x=
 1743591712; bh=FpHV6HxSAasPU/R+78mgHlSGiU8BCw4fMonsQ6K+SfQ=; b=w
 cye0eOGty1l7u4VDlJ2/uvGY08heGJnZf2RoLNoYq4/SCC7EUSD143R80lw9M8Qu
 LrTZdXfUz+4r0GfLgnRsYd3VEe+Rw9e/o2ihO/EBcXUfxW4hNVkuOwbvujf3+Fxl
 a7Af8JBf5ki+LMcjXbMm5pxUebodH4CznHZ2F3RdEIHo+VI3rdK7w5wW+IOIbwGg
 5QhNiuN+1vEghAL3qDnrh4OpYiVAFm1YxrQrC2jKAbfY+Nkwg33LmJPtJrels9cn
 7+QPeweV/JLAag9l3w6zGEapJZIYiK9yQucgH/swN7771kYq7t6eeE7jhFTANzt5
 E8JMPsv3Y9izvDOSb+fag==
X-ME-Sender: <xms:_vzsZ8xZUjR2TmPf8KBZrsWXnha1Y871UoW8yYYlKRb9YT0VF1vMeg>
 <xme:_vzsZwSgwzs6xaUQ0aWBuiqRGqQFuwdAvFeuQYQ9_tPnxjXY_63pH80myatce6rm9
 o_BrZn50kHTngVNJQ>
X-ME-Received: <xmr:_vzsZ-URHyfZC9-NzH_fckr_bn8_YtUcsg6vd8zQSQXGmBDvNflA45ldPjfmwTiPFHA044gLHeuTJ1JbpWLMs_rykg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeluddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
 grvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghr
 ohhsohhfthdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdgthhgruhhtrhhusehinh
 htvghlrdgtohhmpdhrtghpthhtohepphgrrhgrvhesnhhvihguihgrrdgtohhmpdhrtghp
 thhtohepgihuvghmihhnghhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuh
 hnrdhguhhpthgrsegrmhgurdgtohhmpdhrtghpthhtohepnhhikhhhihhlrdgrghgrrhif
 rghlsegrmhgurdgtohhm
X-ME-Proxy: <xmx:_vzsZ6jITeyjiSasgSUMBGwQsEvd8aJXVVXlkSh5EzCut8MKwwV90A>
 <xmx:_vzsZ-AjiWbUNxAXYxZhXCskjhID7wuSzKw_gHMNjM7dRYvwmB9R4w>
 <xmx:_vzsZ7IiBrIplAbZuRXYE1T7t7KUkvWwfRriznyj-YzxSsxMwgN1oQ>
 <xmx:_vzsZ1BDfhpXyLj-kIaBz4pw0LRj2wZ3dEWpjRqDXesFKD-kmk5f_w>
 <xmx:AP3sZ_flq8tjJEB-U3RjMHzjg9i-85GEByJoMBxXP17lA07sFvO9Clsk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 05:01:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>,
 Gagandeep Singh <g.singh@nxp.com>, Kai Ji <kai.ji@intel.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Min Zhou <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Gaetan Rivet <grive@u256.net>, Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v6 5/8] build: mark exported symbols
Date: Wed, 02 Apr 2025 11:01:39 +0200
Message-ID: <4410598.IobQ9Gjlxr@thomas>
In-Reply-To: <20250328105250.3082414-6-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-6-david.marchand@redhat.com>
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

28/03/2025 11:52, David Marchand:
> --- /dev/null
> +++ b/drivers/bus/dpaa/dpaa_bus_symbols.c

This is a special case for base drivers,
so we should mention "base" in the filename.

> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Red Hat, Inc.
> + */
> +
> +#include <eal_symbol_exports.h>
> +

Please add a comment here to explain this long list of exports:
/* Symbols from the base driver are exported separately below. */

> +RTE_EXPORT_INTERNAL_SYMBOL(fman_ip_rev)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_hi)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_lo)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_mcast_filter_table)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_reset_mcast_filter_table)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_clear_mac_addr)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_add_mac_addr)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get_all)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_reset)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_enable)
> +RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_disable)



