Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD4CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 09:35:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D82A40264;
	Mon,  8 Sep 2025 11:35:05 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id E03CC400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 11:35:03 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 222237A0085;
 Mon,  8 Sep 2025 05:35:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 05:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757324102;
 x=1757410502; bh=KNeXO3TJe5SbZ1OtB3zt7b3qb8f1tyUndkoYsFnjRa8=; b=
 Z1p9VHJyCZe5QgaUFibofd6kDFfGJVQ5N2ktIX0t4dfQDjIuizXDN8cyg7FeHZFY
 ZGd/7DbQgSdFqVSKTYD+X+7VFonv0ZMAhvBYPEfZnn1NfpTzO/pHfEXbp5yiVxvU
 mzyK0rt6b9iZtNLpHmakw0cKYePb86K71oKdLXXQ/r8GseUKpj82dD9Y2GUWnK9z
 eb2t9UxwlA9D2MtB071peAAXSFSgiAcZ+vuP3sHnlSYdZdsNCkFIg19gGYO7T2EA
 yBeaT3CwlOeIzdGgGmuKWaMgAuDhSxVkD0W8iTOeckjQxSkVI0k8AS9ETAz7DlQF
 OBFZSpdzCAy0KD7XSNMzug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757324102; x=
 1757410502; bh=KNeXO3TJe5SbZ1OtB3zt7b3qb8f1tyUndkoYsFnjRa8=; b=T
 8UrdUb96CXoKtWMs5z3hPm9UVW+h/NwywAhyd/rw4WV8Pc9jw7kXK26RAmQvj/b1
 CkjkD2ignAkpAIWokw3kfcpFnUy5Ic9BDEMd8H8aFjvNaXO9NB7hchHpDwosl20T
 6kh+N4BXyjPMkLoppJNRWPEVkS/xNSNqQR38uVSQjNxzSpbmqbXUDPWIVgE8kqBy
 W0u4E54qpjKz0ewr5jHdc+DisQ4Gu5LxBY/exPMl/f6uEXoBVQdR+raYT6v1+Xi9
 0ot18VZi8PCtAbLRCvYocJXhMbQPggcwnVIkKw3N7r5kTpIhqOlZndkc/luHXRI4
 JUmOYu+vQ76MeAzIIk5ig==
X-ME-Sender: <xms:RqO-aC12fMyzHDe6uzOX5aePxCB358WNp6wY3cCcvU3WFm_SD02Ezg>
 <xme:RqO-aKXIpemmNFmn1cbVerHuwIb3SLp-_GIRbvh4UTxEXXVrCJ36FytmHLZ-sa9d3
 YbcAUPf4JTB6tuLcQ>
X-ME-Received: <xmr:RqO-aMlLilQHVaOOmlx-CDfIUXUWXDGLLYA1qSWVwoVdgp_ixqjJetXndLr4_UfTQZFSoL4OZQi1DfVh2tubhePb6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:RqO-aMDQjZ6tAw7L8SSv3vffnDg2qujPiIuPueNdjkcXhbfvw27LPA>
 <xmx:RqO-aMeqyAQa_N0KKQ0uQmhSrpNCRpROA9b-lbmtc4K6Y3yQidfKHg>
 <xmx:RqO-aHL-GT73ifYXUS0Vd40V9axmEKtWRfnA2KpXESsg4OkGliSOzg>
 <xmx:RqO-aPetW9ajNmbrnJPKGDJ3tyGBpElWedTJWWLaqOc4D4k-YnXzgw>
 <xmx:RqO-aOUNNDUPvxEZr0UHC2Av38SVg-F57bw2RDkMy31GnuSWSaKQ6iR3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:35:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: Re: [PATCH v2 0/3] fix build with MinGW 13
Date: Mon, 08 Sep 2025 11:35:00 +0200
Message-ID: <2379702.ElGaqSPkdT@thomas>
In-Reply-To: <20250827151759.1448018-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net>
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

27/08/2025 17:16, Thomas Monjalon:
> After an upgrade to MinGW version 13 on Arch Linux,
> some compilation errors appear in PCI, mlx5 and bbdev code.
> This series fixes them all.
> 
> Bruce doesn't see them with MinGW 13.2 on OpenSUSE Tumbleweed,
> but perhaps just missing some dependencies.
> 
> Thomas Monjalon (3):
>   bus/pci: fix build with MinGW 13
>   net/mlx5: fix build with MinGW 13
>   bbdev: wrong fix for MinGW 13
> 
> v2: make status_str variable local in bbdev patch

The patch for bbdev appears to be OK,
so change the title to "bbdev: fix build with MinGW 13",
and apply.


