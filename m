Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487DC44502
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:40:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D16F4026C;
	Wed, 21 Jan 2026 10:40:12 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 30A3F400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:40:11 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 83B1F1400161;
 Wed, 21 Jan 2026 04:40:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 21 Jan 2026 04:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1768988410;
 x=1769074810; bh=zTX4DHye910sTeaSDZhUXYemSNl/WoEeibf02sZIEEs=; b=
 KYRYGWGKTvH57kVULwj7v92RIl1uyTIyvOC/IuZlYFuI7iQUqamL9cA/0Z0izjcb
 VANG44nzdMYcLtee3LGwdDq4YoF70GRheBkD6ukKfmapPg0qqhkyjI2VbkhnZdHn
 bdtZucdlK7IjNMvTyiZ6pHBww69own8lqjqTEPF38gJnJ+EzK8LRXlWZpvHnr17E
 sIxE2+aJZFEPExb+6f8dy7xStuEz/IYsCBsw3u2vm4NroQjUkUnlFePFKoUh2zVK
 O/iH07/mjF23zxHxAOySItu4knb74XS6VPpr9J/QTJ3QLzVaUaPOHwdAssLnxthu
 9EWf+HZiVX+q0sU0+vQ+Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768988410; x=
 1769074810; bh=zTX4DHye910sTeaSDZhUXYemSNl/WoEeibf02sZIEEs=; b=S
 ox9VwNYKeIy+Sj7pnun6/JEw47kexZr2DvUT2xi4+343Kg3Ab7APEMhLYIYCmpuu
 0CM/iKvnPzcQSlHcdYLJjB9TAF2dWalx7VCqnQngwXFtQndS1pkq31sCaReKhSzM
 eqVeEHoS4N6b2jH+h1/nywASK9RqHRpTsdNJT6bMFqyxekSHuN5/qFyiN5fcEZj3
 53uqSZqufjLOvi4OHgA4r+uYjpW5Fdx5tSZO7X5839w7e48+M4X7VPxna10dgjSV
 nebsebkwAG6MzPhLPtANr9x2iI7tsisAx3Nu4mJYqYVlonvlwFemC9andZsjP+QG
 AejE7Q/fapvaeI4mf+BIg==
X-ME-Sender: <xms:-Z5waYqH4FXUnzFLnP7P5YnrKQ6vLAQN1mRcdBpiwZJGB4XsAotXWg>
 <xme:-Z5waewyKfT11lmI0Yz35DCJk4vVVyCQs6wjjmmGtiaNtlMyeqiXR2xTnkxOVlFBl
 bwZIeiEsNnUr42BSbMumAHwCpnzVKgWOvZyG_j-Z1JPDhsadCbWtg>
X-ME-Received: <xmr:-Z5waVLArQCWvN6MkxYVwC5FpXKZAP8rrOiGOXL0L6xhbXpLyJtf5eTvmBV8qf5i-VsUjhbZEuwLY7BGaPhOgMxIdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epfigrnhhglhhirghnghigihhngheshhihghhonhdrtghnpdhrtghpthhtohepshhtvghp
 hhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepfhgvnhhgtg
 hhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdr
 ohhrgh
X-ME-Proxy: <xmx:-Z5waYJPiy9SWaIYQDDS-2ZjM6CDC6_lLmJpF-WI5iMzelFIjYTo6g>
 <xmx:-Z5waSu0gd23tC9-mR6ItIrGYQyeGYJWyu39D-DiCRlUj-ZxhDLd8Q>
 <xmx:-Z5waVRm3BJ4kfzPdFdL9OYVEWlaapMywpb2ho6V15qv6E2apzi9RQ>
 <xmx:-Z5waYM_eOYsob4Vn-eVlaQLcTOSCOrWMyBHMPNqpWBxDXFscJBGaQ>
 <xmx:-p5waYEHvaybNJfgfJQPotTBhtAv2w8Yu08jbqmLrD6HhixXwU-vjJ_G>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 04:40:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Liangxing Wang <wangliangxing@hygon.cn>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Date: Wed, 21 Jan 2026 10:40:06 +0100
Message-ID: <15656361.tv2OnDr8pf@thomas>
In-Reply-To: <c0fde19abc9e4b44b2d21a9cf22553e8@hygon.cn>
References: <20260108072919.1279731-1-wangliangxing@hygon.cn>
 <c0fde19abc9e4b44b2d21a9cf22553e8@hygon.cn>
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

19/01/2026 10:19, Liangxing Wang:
> Hi,
> 
> Not sure for what reason, there wasn't any test check triggered by this patch. Do I have to submit a new patch version to trigger the tests? Thanks.

The whole series got tested and reported on the last patch:
https://patches.dpdk.org/project/dpdk/patch/20260108073135.1279814-1-wangliangxing@hygon.cn/


