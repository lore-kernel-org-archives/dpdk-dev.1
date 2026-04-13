Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E5F531CA
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 19:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA07402E1;
	Mon, 13 Apr 2026 21:48:32 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 013EA402CC
 for <dev@dpdk.org>; Mon, 13 Apr 2026 21:48:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 955EF1D0024F;
 Mon, 13 Apr 2026 15:48:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 15:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776109709;
 x=1776196109; bh=8mPXHgnc2b5q0i6b7rETd4DCNHAWzqNrJMNwSkVIFNo=; b=
 CcHS1i3T1pRHvhhb8uCwsL45VA5qEi9v3kZe0HgkcuMUIGC7JYoLTtqTWGqa0K7l
 qcKgV8D+/w/hqEYL8Uii8MGZfzcFcekDuNvlpEE+YmVD+66sKUO+CJ8uOvNWQRo8
 2h8y+Cb0VrYR/+5Bp9lQb/7AqlzkAHx0fXhuM85yaRgRb21JTEyirubEyz7ShZD/
 D7cf1cCCFp8CziwPXUCfhlpajAib6MwcvTgQcB5Xa9XrxUz8UptORneSxJ1qhGdv
 aerkVxnQqjeEXv/ke2d+62sth4bMoE8aVUWqhhcTXRMFFVg+75f98JHC+sqvGGqO
 agQvIk1azsejf5WOlkUICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776109709; x=
 1776196109; bh=8mPXHgnc2b5q0i6b7rETd4DCNHAWzqNrJMNwSkVIFNo=; b=Y
 ILJrmKWxauVuZ9EYMYS4IPI8laHMvXnWMPrXbm2MBF7BcT32H8n0NYs4knOtI/jN
 2zCDDObLAF1EHHVg/0W/FyHbaUyN8OihRoqTwYcGnXUqI5VQlgl0om/EeQUs6dki
 XcycIjFs0x+kmqJDVAK6CqdmBTMwI//ZFxLOIRvG8oCOo5J8jvaRoFN79rPHnYu7
 MPjBcrY92XCV31Jcwhh66WrB6IKDmZYVV0IBlNrodzcWlwg5RJBBhYmVTLIHF+BS
 QT1zyIA13tiQKtbx86B+PeXNxGKzobpGz3Ap68fLnU8NRjMGd8GyAQ7RIdUufBoH
 tHAPwwm0Rvs0znm6yWDVg==
X-ME-Sender: <xms:jEjdaYihOAdJKkyd1dB38qB-KidTWnXQvJfBqocYz-S65Lht03UTYg>
 <xme:jEjdaWlWUIFAKk4QPgwgfwGZ0ozpyjdFcG2tnjWV_eXvAghkDnQ5pqCi8rzdtMKXH
 0L-f-ictUsmEqXv-OnoxPZb_D8iYGA_tyzfvxGs_C1Hlz7CdLty>
X-ME-Received: <xmr:jEjdaZqo9AeX5mlY2PYKl-kCGtoIVspYdm5rNrzYQFbUWLxnyfLVJTB6GbMRmmj47BuE30x5UoO9TJAvZH5U7iMcmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jEjdaaJjJAxqD9S-r3ltjbkgBsrRFEg_uJu9gF2hFxlJdX2Ib5mDPg>
 <xmx:jEjdadATVqh-mUq7JBj0X_2YtzeHBz0Mvr6sh4g7us2KKOqIWMAzkQ>
 <xmx:jEjdaU6bmXchC8dvgY_h1ep6E0Y-wHEWGEvJF2uqBH9yhm2MacSpNA>
 <xmx:jEjdaRFy1o0ZRbxTZr_QzBq-dspbQ7OUCV0qTXDnkvAojLuD-FiiXQ>
 <xmx:jUjdaSgw0wp6kGCKpX4lrDp824rp5KCOXEII0ez4YxCTiZTymWD_Lm3P>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 15:48:26 -0400 (EDT)
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
Date: Mon, 13 Apr 2026 21:48:25 +0200
Message-ID: <2267120.Mh6RI2rZIc@thomas>
In-Reply-To: <2054977.usQuhbGJ8B@thomas>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-6-david.marchand@redhat.com>
 <2054977.usQuhbGJ8B@thomas>
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

13/04/2026 21:18, Thomas Monjalon:
> 07/04/2026 13:52, David Marchand:
> > Each bus reimplements some similar devargs lookup code.
> > 
> > The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> > device names. We can't use the .parse existing handler from outside the
> > bus code itself, as the size of the bus specific device location address
> > is unknown.
> > Introduce a bus specific helper to compare two device names and
> > hide this ugly detail.
> 
> I agree with introducing a new bus helper.
> 
> [...]
> > +		/* The name in the devargs is usually prefixed with <bus>: */
> 
> Is it usually prefixed or always prefixed?
> 
> > +		if (strncmp(devargs_name, bus_name, strlen(bus_name)) == 0)
> > +			devargs_name += strlen(bus_name) + 1;
> 
> If I understand well, if it is prefixed with bus name,
> it is assumed that a colon character will follow.

In the function rte_bus_find_devargs(), there is this comment:

+               /* The name in the devargs is usually prefixed with : */
+               if (strncmp(devargs_name, bus_name, strlen(bus_name)) == 0)
+                       devargs_name += strlen(bus_name) + 1;

I think you mean "prefixed with <bus>:".


> [...]
> > +/**
> > + * Bus specific device name comparison function.
> > + * Bus can normalize the names of devices using an internal representation.
> > + * This helper makes it possible to check whether two names refer to the same device.
> > + *
> > + * @param[in] name1
> > + *	device name
> > + * @param[in] name2
> > + *	device name
> > + *
> > + * @return
> > + *      0 if the two names refer to the same device.
> > + *      !0 otherwise.
> > + */
> > +typedef int (*rte_bus_devname_compare_t)(const char *name1, const char *name2);
> 
> The helper compares internal representation of the device, not the names.
> The function should be rte_bus_dev_compare_t.


