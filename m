Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C8C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 11:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F30C402CE;
	Thu,  6 Feb 2025 12:25:45 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 9FCB94026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 12:25:43 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8D2782540122;
 Thu,  6 Feb 2025 06:25:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 06:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738841142;
 x=1738927542; bh=xxQ1KNh0sZfnrP3UL7NaAtwSKWtsT+FiK6tkJPDvCMc=; b=
 yT0YgI1NludxHxptlfZ85mruzE2D8VpUQbHRTFK36Q7appLK/5/RY9GxZ+MpgV9F
 pTC49ZLzzL36x6YIY3QgeStiyFPsuOZ/LzdHO9H/3jnuapY30BBYj5f9d7a82wPf
 iFltxWk/QQmovUpoDkD/D5svMK+x7lU/b18sJhvCigGXVK1Ws2SgAI7j0nq4W+kh
 mgfs6dSEb3aDEcFc8I67jVUNH+LalowQBjLOJDLEv5zK2quGJgdzjkMewy+bpNDg
 3q7fB66vgi4WnbjPsmaSLutlhPzIyIvyktU+Dc1M4KVY1IuCafKgvBcIF4Be91XD
 R2dIUjXM9xgGbDRxCbbZ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738841142; x=
 1738927542; bh=xxQ1KNh0sZfnrP3UL7NaAtwSKWtsT+FiK6tkJPDvCMc=; b=D
 ASCa53GHv/NevRPZ0o1eKo+J/9y8fOwdMnVuK9zzLBOXFyo3wkVN0sEv/ulGimEA
 yFlIfPnoB7JilmpzHIvsIbAfof7axDyJHJm6XTIfv8x4Bi9ywd3D2dcOHPa9f1ib
 IMvfNsNF3uf0wPum+TEdRDoznkKdSqJEkxT0o47Y5IgU1ZLo34SDjkCGHX2caBOY
 W5fYKF8tQvM6BeclodqjIonT25pXnrfWDePBuOekR+PSCqjJV/eKaU/Z2teM00Xn
 xqH0deo8SxNxrNGu1vDgPTBhTmiCeHBIC8ascu+PGE9ateI2GI7nI+KoLT1kYp40
 SS89k/qoOyQv2+bu8Qdwg==
X-ME-Sender: <xms:NZykZ7lWvs-UpaIS-t3a3ZafsXO2qPSOLUd8X5uckgnam3fK1P5S8w>
 <xme:NZykZ-0-dx4ES4QjKeJkg3xUhD2oh_2WHdEDfeF5OVCGSRCau4LheRzTG21hco9y5
 GOsAm6keCpVrcFVTA>
X-ME-Received: <xmr:NZykZxoRK5swuPM3HQ2FhVhTUJ0UxAujC3QgqRfPfoGABAbQ0xjc_cch9R2wQFIM0C98Kb19OgocubdNj0MU37jDxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshh
 hpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorh
 hgpdhrtghpthhtohepphgrrhgrvhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepgihu
 vghmihhnghhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhpth
 grsegrmhgurdgtohhmpdhrtghpthhtohepnhhikhhhihhlrdgrghgrrhifrghlsegrmhgu
 rdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhmpd
 hrtghpthhtohepshgrtghhihhnrdhsrgigvghnrgesnhigphdrtghomh
X-ME-Proxy: <xmx:NZykZzkQj1dHyKs4UBx5DRLKpb0m_6_R1gWez7i2aWX3DxGzwhPxtw>
 <xmx:NZykZ53iTG-M_mzEhn9YvWwLgPeajRv2KgGOllmfHPOTA6n9UKYGgg>
 <xmx:NZykZysn-Aafv2djNRbA3AUS6L-fk3jS3SbDBwsuQj8LAVpwbr87-w>
 <xmx:NZykZ9XgGsPXWJ8J4nteXEgBHdxv6ae2_ii7PVBAOEa0AsVwqsOPWA>
 <xmx:NpykZwvCAIEzUwj0vX5S4LGPYyaea9vqLbwgGOv8GnyBZ1sXmtD7vFVb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 06:25:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v5 2/4] lib: fix comparison between devices
Date: Thu, 06 Feb 2025 12:25:38 +0100
Message-ID: <3823222.VQhiAETyHQ@thomas>
In-Reply-To: <20250206000838.23428-3-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
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

06/02/2025 01:08, Shani Peretz:
> DPDK supports multiple formats for specifying buses,
> (such as "0000:08:00.0" and "08:00.0" for PCI).
> This flexibility can lead to inconsistencies when using one
> format while running testpmd, then attempts to use the other
> format in a later command, resulting in a failure.
> 
> The issue arises from the find_device function, which compares
> the user-provided string directly with the device->name in
> the rte_device structure.
> If we want to accurately compare these names, we'll need to bring both
> sides to the same representation by invoking the parse function
> on the user input.
> 
> The proposed solution is to utilize the parse function implemented
> by each bus. When comparing names, we will call parse on the supplied
> string as well as on the device name itself and compare the results.
> As part of the change the parse function will now return the size of the
> parsed address.
> 
> This will allow consistent comparisons between different representations
> of same devices.
> 
> In addition, fixed vdev test to use the rte_cmp_dev_name function
> instead of the custom one.
> 
> Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

I like how it looks safer.

Acked-by: Thomas Monjalon <thomas@monjalon.net>


