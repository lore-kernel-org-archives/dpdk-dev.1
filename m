Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D7C5DF88
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 10:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C402F40671;
	Thu, 20 Aug 2026 12:49:54 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 6107F400EF;
 Thu, 20 Aug 2026 12:49:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C1D901400188;
 Thu, 20 Aug 2026 06:49:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787222992;
 x=1787309392; bh=2HsORG2xl83wMrRU9Gzx8pH4f3GQqQVt0pRWVwSC788=; b=
 CoBY+UA5aWjvbJNOG9B0Tzm3UbpGKv+2SnCd6FWYl9nNrnnJ71V+JbdajJ9BEF5L
 W45ks6j3N83ACXQ31nr9MXemiokPXon65fZngwgifTTgmJh2iC1XyNcAAl6T2+5M
 M83EES5JdG0XKv+VDGXZCd9kS/7Hodpi+a8Uhism6PX3lEwcx8JM7iGHZnrMblkL
 7rpL0Rv+YwgxJ+TNonIctABwEcG8gL/d+Zub8W9JgyVLq6F8hqBXmH0RX9mCkTOQ
 wph5yLI0yrsmTNhJkJePQWtRj2DBrseR5ptsOf0Tky5HeyHjSAuWhhUA3VaD3Z9Z
 bXgFH1J/ClZBJryGZ++gDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787222992; x=
 1787309392; bh=2HsORG2xl83wMrRU9Gzx8pH4f3GQqQVt0pRWVwSC788=; b=G
 41lo6OzAqEzv1utc0PyGIfiaSRdkY8VVpGy9HU+Fdir2xItaaKsmOnyJsyTaZ3Lx
 LgJv5ipEPkwnBmjO8kikfYjTxqQ5pWMgf6UjfMuiN7+i9I3UIutfS5ooDXwh6hOg
 iZrscJ5auUGQLqmLB23S9g+luEC+DJ8V1B8xId78W2MVatvwuHKqpwuhqrysCZJ8
 ckTlN2gITVRE6zPduhEFPS8sO0o7en59s41PC2JuvSaGWhPugTQ/yAke9L62M7vv
 wkWGa4PNRqEgSqbQwHxIcbkbGaC7nJag185XW80ChRQffRVK/pzJkZUigFVr5NPd
 Ufs7S+aXxKvWXnaIt8dtg==
X-ME-Sender: <xms:0NuGao_9tDRNJe9qTLpSSQYXg3kUEVXIFSFvg-UIFj5Ixa4K5l7krA>
 <xme:0NuGakZjeGxFgXD_ndRwYNIthaNQxIVagtOtpJ8MTkYWPJsiJandTNCw-HLL6Z3xT
 buEExKTWo0d8fODBYrm9k0JGNzcXoCQHfcD1d8yF_IGmuGz2LtjnyQ>
X-ME-Received: <xmr:0NuGamp2clhmtt-sC0aIjEDVNU9C5XmB7KQH8VUnYfTRC_SKKXUWIdq-Cx6HBfM6>
X-ME-Proxy-Cause: dmFkZTFaBo+Jg+zKxSPfP9ejL48x4dOCBIzupDXexLcv4zslCGzVWtfarsgejOEj1YeWhw
 Zc2AMJpm4l+TsrkoUAycsQjUHhUBklMETSH5J32jzyg5v9dzlOJ8mVp7V+fG5ceQWt7G0z
 Gvuyn3bg9DMakxV16HEeGBE1pB31TTyNpcjcVnrT/wIYHvyrNv40noyx6dzoTPIjA0OOMA
 s6SDG+zRpuT/jDSQ2t8PbShr+1fxRHvjjmFodlXz1iR2mZWidGSeJvdw3BMRbUGsTOztsb
 ZHSq4ZHqpihTZCWU/fX9VXTVvndxa/T34kGqEI08aTU99qMhg0NBBUjCFfUvAEYX3DG2mj
 OS0mEH1we3iPdnrTgRaeSxg92vTPED0KzWmxg3itNNUTyDntlpL7TJnadF55sZjHB0WY8j
 MJsObSn+TeBfsPLYkkrGH1vHViGvSUEMC5v4lE5srtfTK50dMI60eDTL3AZs3ChrTD+PZs
 fy7YZIXPonOhgKEXlKO4ly+p72p48eVfklPnIiiVO3cHtclV6j4XC7HY6gHMgK4X18veAM
 0+ZL6EXly7C6t+ZrQzGpVzYy+bzodGJpYWm5o5f9rJiqA36I6zN6ze/XhPIzprb75acsUj
 ojguw4xM4pKA4at5kJTPsBtEs+M/+O2I079tQOxVDBq+l8Q5iD2Njy3+71eg
X-ME-Proxy: <xmx:0NuGap3uV8VqfHbNLBKK8HghvjB6opO1QjG7sbjaNwakUF2GB66eDg>
 <xmx:0NuGauku-ESl6BR69At1V6iyIeviFipYhKfNwTRB4Iim_xYSPtEpWA>
 <xmx:0NuGalaOu0Kt-VIzjc4vD6z9Uimzph0a_p96VsXHXDiGB1XCO4aTVQ>
 <xmx:0NuGag9ygJl7ptXXHPoe6QfdZD2VG-geKchAYa7-_paijTAGN0yS2Q>
 <xmx:0NuGamkpE4gtsItNWWP49qtOzveiRHq4FSdI4NBE4qOvN4XPlcDzZkRt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 06:49:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: bb <becauseof86@163.com>
Cc: users@dpdk.org, dev@dpdk.org, dmitry.kozliuk@gmail.com,
 ming3.li@intel.com, pallavi.kadam@intel.com,
 Gena Tertychnyi <genter@microsoft.com>,
 Andre Muezerie <andremue@linux.microsoft.com>, greg.cusanza@microsoft.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Itai Sharoni <isharoni@nvidia.com>, Tal Shnaiderman <talshn@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: Windows 10/11 x64 signed NetUIO and virt2phys packages
Date: Thu, 20 Aug 2026 12:49:48 +0200
Message-ID: <cGq2-0faQ9iJv0T0f8ECAA@monjalon.net>
In-Reply-To: <1edaac48.4371.1a01dcd3974.Coremail.becauseof86@163.com>
References: <1edaac48.4371.1a01dcd3974.Coremail.becauseof86@163.com>
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

Hello,

Thank you for the catch and the good questions.
We need answers from Microsoft, Intel and NVIDIA.

Please see below


20/08/2026 08:13, bb:
> Dear DPDK Windows maintainers and users,
> 
> We are evaluating DPDK for production deployment on Windows 10 x64 and Windows 11 x64.
> 
> Our hardware includes Intel XL710 adapters, NVIDIA/Mellanox ConnectX adapters using the mlx5 PMD, and other PCIe network adapters.
> 
> We need precompiled, production-ready, Microsoft-signed or WHQL-certified x64 installation packages for:
> 
> 1. NetUIO
> 2. virt2phys
> 
> The NetUIO README currently states that a WHQL-signed NetUIO driver can be requested from dpdkwin@microsoft.com:
> 
> https://git.dpdk.org/dpdk-kmods/tree/windows/netuio/README.rst
> 
> However, that address is no longer valid. Microsoft rejected the message with:
> 
> 550 5.4.1 Recipient address rejected: Access denied

I think there is a signing procedure here:
https://learn.microsoft.com/en-us/windows-hardware/drivers/install/whql-release-signature

Unfortunately, after 7 years since first introduction of Windows support,
the roadmap still mentions "inbox kernel-mode driver" in "Future (unscheduled)".


> Could you please confirm:
> 
> 1. Whether signed NetUIO and virt2phys packages currently exist for Windows 10/11 x64.

Anyone from Microsoft can answer please?

> 2. Whether they are publicly downloadable or available through a vendor or commercial support channel.

Anyone from Microsoft can answer please?

> 3. The current contact responsible for obtaining these packages.

We really need to state who is responsible in Microsoft.


> 4. Whether NetUIO supports Intel XL710/E810 and other PCI device IDs in a signed package.

The question refers to i40e and ice drivers support on Windows.
Someone from Intel to answer please?


> 5. Whether virt2phys is still required for mlx5 with WinOF-2,

It is said "required by hardware PMDs" but I am not sure it is true with IOVA-as-VA.
We should explain this clearly in
https://doc.dpdk.org/guides/windows_gsg/run_apps.html#install-drivers

> or whether IOVA-as-VA is officially supported in production.

It is not said it is officially supported, but I suppose it should work.
Someone from NVIDIA to confirm please?


> 6. Whether the packages support Secure Boot and HVCI / Windows Memory Integrity.
> 7. Whether redistribution with a commercial application is permitted.
> 8. Whether the obsolete dpdkwin@microsoft.com address can be removed or replaced in the dpdk-kmods documentation.

We need Microsoft support for these questions.


> Relevant source and documentation:
> 
> NetUIO:
> https://git.dpdk.org/dpdk-kmods/tree/windows/netuio
> 
> virt2phys:
> https://git.dpdk.org/dpdk-kmods/tree/windows/virt2phys
> 
> Windows driver documentation:
> https://git.dpdk.org/dpdk-kmods/tree/windows/README.rst
> 
> DPDK Windows requirements:
> https://doc.dpdk.org/guides/windows_gsg/run_apps.html
> 
> DPDK mlx5 documentation:
> https://doc.dpdk.org/guides/nics/mlx5.html
> 
> Thank you for any current information or contact details you can provide.
> 
> Best regards,


