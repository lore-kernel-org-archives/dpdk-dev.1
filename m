Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053CBF531C3
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 19:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFF8402EE;
	Mon, 13 Apr 2026 21:18:19 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 45FCB402CC
 for <dev@dpdk.org>; Mon, 13 Apr 2026 21:18:17 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id D97A31D0018B;
 Mon, 13 Apr 2026 15:18:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 15:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776107895;
 x=1776194295; bh=qmLwwtrtttxWEMeWdvuRypHfnFAfc/vluOeQDw5XtzU=; b=
 JIjf9OQeGANM4HT2UXFY+Q6CbIBBGK7VE0K5O9jChyaJHtk7kzQ6977IKWtFvy1t
 Vb5/qT3ke80l5DddIlTk/CtDu3FsP79nsdAHqqNTmvkz8MCTzwLOBxKsEZQE9RVG
 g8deECuAN/D/RXa05fPVrRMw6SGtWxfeN1OHy+TtsWe+CDF3SjKT/znPhxnGTg3x
 EX/RPiydmkexnQ3DfAfhBSEpXyATBEBKwoVuq76MruLi6tY0fPlGiXDoclJSoFuv
 p2DJwygcaQFS+S8Bwrwjd1oggPmmuQf00r31xQYZjfVta1pXr1FvP/cgS4Fzys6N
 rZ45M4Fo48QpgZaOTaLkQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776107895; x=
 1776194295; bh=qmLwwtrtttxWEMeWdvuRypHfnFAfc/vluOeQDw5XtzU=; b=E
 V8inlSD0qiBEyE0dnND34bH9bbhdthdHD2mvFa6nOTRSpWpu8LGkcXPYeEw2MDyU
 wF8k8+pVqFfGpPWlwHIp+F2J2tPqxYM3eouVBgTCzCjarXB9v+5XCUZ7x+F3uiwP
 UZnfVxIfiW/+JlSZZluVaG6l4U6fR3RkWnjNdqfsUtfubz0GvC9c6CKXcpXVEg6j
 faVkdwRVMNIj+d8dqMAF16rW8zPNbQ0qQ+xo57g7W7WQhVYjdDyqMZ+mzMT1Zb8O
 BpBAyUDsAyAZGHO+8Rtqta7oIMjFdi0HMjLz4LAvIJCfnmXMZFfWkOpNk0tF3d6m
 WozZ12snBcj2zrCQgIdAg==
X-ME-Sender: <xms:dkHdaXhhSOdTACYsWsI4SWKZkbgcK-mgKICITxvICKVcyaKY7hH6RQ>
 <xme:dkHdaZmvth9w-fP5S_2GHwlVmfp9OLBP_78BsTf8mtFYV8-rMVjgReFoXZj1rmaao
 FetDnnLeH_t4f3ijqYqNC-ccvgDugIr4HKTQFcSLkN0ohP8DeU>
X-ME-Received: <xmr:dkHdaQrC6UVvf_OnsuQ-LwNZqCE4WsN4y7eAtsql6_9Q13eJitYb0qeqZUMFySutk88OENooNW3ha4DYXJiHCLA_0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledthecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 ephhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhmpdhrtghpthhtohepmhgrgihi
 mhgvsehlvghrohihshdrfhhrpdhrtghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrth
 drtghomhdprhgtphhtthhopehprghrrghvsehnvhhiughirgdrtghomhdprhgtphhtthho
 peiguhgvmhhinhhglhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrgh
 huphhtrgesrghmugdrtghomh
X-ME-Proxy: <xmx:dkHdaVLYmjUkn9fRAoWqQTPcHvPqyN7VXxACWy-Qm98VeeUmNcRMeA>
 <xmx:dkHdacDi2-4sl3x4_mos-DARcLocnLp3f1GbjL1ZEjLeZ8HXGwDZiA>
 <xmx:dkHdaX5Xvpvt-PzhAgYrG_GZLt0MYVFtnd2Cg7VOYi3Hf74-Xbj-DA>
 <xmx:dkHdaYGyzQ4VIwpSItQ73ADPMWApZ2cSRuBIQOO-dYRForItBsRLjg>
 <xmx:d0HdaVgLyeF0RO8SH3FNjREDS6PxRLdt1PG9UadVT4sfG-WCo0MLjo5e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 15:18:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>,
 Kevin Traynor <ktraynor@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 5/7] bus: factorize devargs lookup
Date: Mon, 13 Apr 2026 21:18:10 +0200
Message-ID: <2054977.usQuhbGJ8B@thomas>
In-Reply-To: <20260407115211.1903623-6-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-6-david.marchand@redhat.com>
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

07/04/2026 13:52, David Marchand:
> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.

I agree with introducing a new bus helper.

[...]
> +		/* The name in the devargs is usually prefixed with <bus>: */

Is it usually prefixed or always prefixed?

> +		if (strncmp(devargs_name, bus_name, strlen(bus_name)) == 0)
> +			devargs_name += strlen(bus_name) + 1;

If I understand well, if it is prefixed with bus name,
it is assumed that a colon character will follow.

[...]
> +/**
> + * Bus specific device name comparison function.
> + * Bus can normalize the names of devices using an internal representation.
> + * This helper makes it possible to check whether two names refer to the same device.
> + *
> + * @param[in] name1
> + *	device name
> + * @param[in] name2
> + *	device name
> + *
> + * @return
> + *      0 if the two names refer to the same device.
> + *      !0 otherwise.
> + */
> +typedef int (*rte_bus_devname_compare_t)(const char *name1, const char *name2);

The helper compares internal representation of the device, not the names.
The function should be rte_bus_dev_compare_t.


