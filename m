Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CECD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 20:21:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3370402EB;
	Mon,  1 Jun 2026 22:21:11 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 95FF140150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 22:21:10 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 14F267A00F6;
 Mon,  1 Jun 2026 16:21:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 16:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780345269;
 x=1780431669; bh=F3iNzAbxAojUfH2pjQjdh3ew7pQsv0Vtn4Zt+78s+MI=; b=
 HGVqnzHQTWPd4xvKHlTm5Yd64+EyPn6BOGgGbVasK8jnf2yeMcaW1sfd0lfYdovn
 fDhqE9QtLZBsYNjYc1l2Y27NHzRiYshNwYzD3UAU0IcqA2abvpPXCF2RjxUwM2yX
 0GZEUqFTltBaWHIpLo/K+Hhmnv3kYHnKEVLxX9tI10rMKQs3birR4SfiiRDMU5kW
 6GcrTl8zIK6ZNNX6ekvh/iQcn28erMGyYciru03z+mLDWakt6j6kIFvQBNN6Q3OC
 BXcMi5SD2xUdOyzuKYMQoSSLQ7z5RH5PHShGMfg6RzMQiw8n4213rssOdk+8MDdj
 YmgBDzOydiy7wjyhzl5+nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780345269; x=
 1780431669; bh=F3iNzAbxAojUfH2pjQjdh3ew7pQsv0Vtn4Zt+78s+MI=; b=D
 dftAzKpA8Bs4Mf+rRfcb4tTNvErXIgU+k+8OEaKys9ueP7AIZLg9Vqub9HQdDthQ
 EmK6PtH0+ZFUpBHQjxoTiA6BxwwLDFdIUijX2AZPO6v7RS7xrmEOo38EiLopKDQT
 BnMUe0AOwRQn5hba5BIevt8P7Vrx/Dw0NRntG0rc758AtsDLlbyaCFl0AfThXTaw
 BT03cs7lqs9OnAnmHlC4SgTKLS/e30hhrKxtwDaQbjiQ8nW4bGtVaP++jmIWrh//
 yjLfPx8AWCCHIorAhda6F+KS50KYHykmF+RXDfqbLnyiY0CFIaXpOM+R+w4BBuSK
 LywbJi7r+o0XQnRi7HD+w==
X-ME-Sender: <xms:tekdasuRSsM4z6HXSIh3PtbeN_FvdSyWLhRzJy6wQpv-j9Sv2Buw1g>
 <xme:tekdapn2caHNLjjL38Ybk1damYg16tfgcugTQo_QbnvnjhKOa_voDMsepzqsTGcSy
 XwiPmq6BmJRutnguMexGZHvKVRIk366CebLupryq_Ybn2v0zPQt4A>
X-ME-Received: <xmr:tekdavt-8pGFbqapFJUkMy8nRo9nUxmqxQgiEug7KlkjbXIWZLWSZBACJx8lDCa39KbWvCP8AxFWumhgxZ97UcVRUw>
X-ME-Proxy-Cause: dmFkZTGQIEYG3iLxdaL4YD/pOwV+INONg4LE434gll6Z2sJtN1RJ6qz3mNoqs+CBW9MW6r
 PxlOqvnj+1QCji9u2cDBJNhZB4GV05Vz8W69zLVOPQuDnOAFDnvCICRzZE7qVAfbLs6XRU
 J+ZHp13U57Nd0gduS/vqXDFXPYKVZrUhiZI713aR2AIdqJPVr3sdF3a6uWKQkBVsSzOOdn
 7sEj8GINenMQKDXCeDDPH863mq5vwZjIBYoXOnvTjck/x49adanxsorBc5mfyi5W/jsJdo
 QdXlhH9TiNkXE2v7y8gDc20aflbew0+cN57dW3MA2YOogEXnDjXIdSEeuGrmBaBcZZBNE9
 y6nQd8sAnPv0S5l8X6nGPG0WeNa6EVj+rsxqW58YKBd35z4UtlxTRZ8KRVzDpO1eXtVNuZ
 gBvODRtqjvd6e04EF0K97o2OxCOAPfh/2YsXxzwIA57+kgfNAv/18TLFf8495/InV+sZCW
 wuDxl05y9FLP9d/3WRDzq4itaGoWRCLrEPuCaNXtGj2j2rBb87m8myv7+XYyUcId2UDxZQ
 nzbfVjihV53ZHOoDmyEP5ZFjTg6CJRbHnSmMXywiVM3XfljRxhRbqIuLXS/ULOK8+pE5dM
 Cx4rQ/agLUw7A1OWIPl/r/0FijXnoM0EY9jOoarl0I/NZGLWJ9yRfdvOW2Sg
X-ME-Proxy: <xmx:tekdandT6B6YxTm-SFo_fEaqo1ipMj5LRDOgXAGdf3Ia6bt_aYXXvw>
 <xmx:tekdanyBhnW7ADmE3m2U8m1aH9y1nqcwmoLPnL-2VOTcJrTtpiOASA>
 <xmx:tekdatGXCqJKR0v8V2TDPu2mUZyzZqEYdGpZ2oihhRLEnAnb0pdOng>
 <xmx:tekdaryf1WJL3KZXBJ5o_rTGA4aRr70IJOxbYJG7wgmiL7fVqC3UPw>
 <xmx:tekdapXmID9WH9uFjIvW5pUUyBuaT9g6vbQLTAWoyU195Kz4KqgxH5No>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 16:21:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, liuyonglong@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH v2] bus/uacce: support no-iommu mode
Date: Mon, 01 Jun 2026 22:21:07 +0200
Message-ID: <OGbmAEQxT1-uC2hrkqXCFQ@monjalon.net>
In-Reply-To: <20260518105857.23083-1-fengchengwen@huawei.com>
References: <20260422075326.34206-1-fengchengwen@huawei.com>
 <20260518105857.23083-1-fengchengwen@huawei.com>
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

18/05/2026 12:58, Chengwen Feng:
> The uacce bus originally only supports devices with SVA capability.
> This patch extends the uacce bus to support no-iommu mode for devices
> without or not enabling IOMMU/SVA.
> 
> For no-iommu mode UACCE devices:
> - The device api name is suffixed with _noiommu
> - The device flags bit1 was set (UACCE_DEV_FLAG_NOIOMMU)
> 
> To support such devices, DPDK device drivers can mark
> RTE_UACCE_DRV_SUPPORT_NOIOMMU_MODE in drv_flags to declare capability
> of working with no-iommu devices.
> 
> This commit also fixes typo UACCE_DEV_FLGA_SVA -> UACCE_DEV_FLAG_SVA.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



