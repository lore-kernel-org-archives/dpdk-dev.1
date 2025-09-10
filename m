Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508BDCA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 12:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB3440285;
	Wed, 10 Sep 2025 14:59:29 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 3835940270;
 Wed, 10 Sep 2025 14:59:28 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 27A287A0183;
 Wed, 10 Sep 2025 08:59:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 08:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757509167;
 x=1757595567; bh=L3GLXTGQjJHwMk0pll+AnG7sWgEOAlwaULPZxAJ4IqQ=; b=
 e3HppqUY8lsPHVNXe1J225b+4uZI7I+ihHh0ehjEpujyGnoRxg4DmPj+HSZXJ65n
 nKldpJ5VBhNE+iGcck+MPYH3qhUPyY6dLdrsD4/ztg3zFgV6JzolYT1rctDcDpZh
 PuJjMg7mRE+CfReLJBfnM7rAk78AxTrn0qDVQPN81Y0QlaDVnN8RwJ9NyzXTeBgK
 SeLNQblf+2lHvYpZRF0nDxb0f2VZKFBx+AbCdVuZrAusU6RUI0JCrJkN+FiMi6b/
 B//EkHAk6A4VrR5xqSYLV6tSmKPzt7M3EZM0SBuPNm0Aa8mEkbkhd45SazkE5pCk
 zCk2G6zcxQZDCrXgYaw+Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757509167; x=
 1757595567; bh=L3GLXTGQjJHwMk0pll+AnG7sWgEOAlwaULPZxAJ4IqQ=; b=T
 BqlluWCwG05UFI0dH4J5Y6hJoMVKGHvyN/X1x4CokfFn+mBeCrhum9gzdBMIOHMa
 EwK5bzmURJzHOO82yf16wqxXHd/OfSIYNr0XP4ZL9Usj32b5iq6wRsQRX8wK3hax
 2LcaGkb9bWTHMs5pvoMKGdgJF+7QAG2Or4ZM9O+C83gQtcEyT/6b6SA+3uyy1Na5
 SvN5jRN6H+hVTHAlMMFGeeOdDvIckk9xG2hX8M+ns48AvBiA0STcJ4kDMbMvyPDX
 2xXLB8z9IjfJkcQdtMKW1MIN2lcC3kyYRR5nARYHMIezD64gOA43vlI5YMo+VCIF
 IsMUKmZYscfWYD6rABEig==
X-ME-Sender: <xms:LnbBaBjj7Hlseug7YNStxpwBoIifK8Hd2rIuMxbnwoeZmqLl7l-b5w>
 <xme:LnbBaC__kHux7MDSx7ucE9r5bIpOTeC0wFDUwDTxxyzaf3m_t-2rYMzkb1bW-KbtT
 n-ImshS9Fc4PLpUgg>
X-ME-Received: <xmr:LnbBaMv-PVgI13F5cgy3dr2olC5pVp1kujNeH5zhg0rI0EQFdWgSNp1RpPfp7y-RH3cPQNKuXck6HPTB3847IOMBPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgt
 hhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegthhgvnhgsohigsehnvh
 hiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhpthgrsegrmhgurdgtohhm
 pdhrtghpthhtoheprhgrnhhjihhtrdhmvghnohhnsehinhhtvghlrdgtohhmpdhrtghpth
 htohepughmihhtrhihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
 rhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:LnbBaOpsslo99wxlDVUs0CrXYEwUNdMJVDcDMtYS96r5kJ28bSPg2A>
 <xmx:LnbBaIqZQiC9u6ZKMC_l7wGD-rWPtxu_anY39EwNGVch5jpvzjNNmg>
 <xmx:LnbBaFasSEzFg-qyD7Eawaob0W-LGtRERBBeatdxCCyxxeSR23oBWQ>
 <xmx:LnbBaO-EwmuPE1A_yOqDjXuluswyAGLq4C7YsMljYV47yvdT1tQeRQ>
 <xmx:LnbBaEsnHhNJirRwbQUqb3urZd-LBpWBiaq4nEJjtoFyT6jL5Gx7A5FF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 08:59:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, bruce.richardson@intel.com,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Ranjit Menon <ranjit.menon@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 1/3] bus/pci: fix build with MinGW 13
Date: Wed, 10 Sep 2025 14:59:23 +0200
Message-ID: <6190162.lOV4Wx5bFT@thomas>
In-Reply-To: <20250908212034.699713-2-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
 <20250908212034.699713-2-thomas@monjalon.net>
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

08/09/2025 23:17, Thomas Monjalon:
> After an upgrade to MinGW version 13, some compilation errors appear:
> 
> drivers/bus/pci/windows/pci.c:362:58:
> 	error: 'GUID_DEVCLASS_NETUIO' undeclared
> drivers/bus/pci/windows/pci_netuio.c:57:39:
> 	error: 'GUID_DEVINTERFACE_NETUIO' undeclared
> 
> The cause is MinGW has set NTDDI_VERSION to the highest version
> without defining the expected NETUIO constants.
> 
> It is safer to not rely on Windows headers version,
> and instead define what is not already defined,
> after including Windows headers.
[...]
> -#if !defined(NTDDI_WIN10_FE) || NTDDI_VERSION < NTDDI_WIN10_FE
> -/* GUID definition for device class netUIO */
> +/* GUID_DEVCLASS_NETUIO should be defined in devguid.h */
> +#ifndef GUID_DEVCLASS_NETUIO
>  DEFINE_GUID(GUID_DEVCLASS_NETUIO, 0x78912bc1, 0xcb8e, 0x4b28,
>  	0xa3, 0x29, 0xf3, 0x22, 0xeb, 0xad, 0xbe, 0x0f);
> +#endif

Unfortunately it cannot work because DEFINE_GUID is declaring a variable,
not a macro.
It is sad, we have to check Windows and MinGW versions.


