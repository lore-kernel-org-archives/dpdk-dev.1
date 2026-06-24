Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD4CD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 00:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD2240299;
	Wed, 24 Jun 2026 02:38:50 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id AFEBC40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 02:38:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JbQ0J2ZmCd1pTuTPAoMSh5a+DfM0mqWU8jFNlMzX0hQ=;
 b=u1qWSsouQS8a2dK+Ggy22DJDv4BlZ229/63rZhEbyLA/sqdAg9H09061qLUkixpuLtYxrmnYV
 Fh3Au43wdKNQTMeUdtqybLgJ+BkriSxm65t/IvzVLO73kA8hdtB1R/iRe8j5ATw51zymh4aJuJQ
 5B+eGDVKKh0FxcXD6kEgPSA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4glN9z41Tsz12LCg;
 Wed, 24 Jun 2026 08:29:59 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id D56D44056D;
 Wed, 24 Jun 2026 08:38:46 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 08:38:46 +0800
Message-ID: <05af78c8-851d-4b63-abe8-2b6df3d070b9@huawei.com>
Date: Wed, 24 Jun 2026 08:38:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
To: David Marchand <david.marchand@redhat.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
 <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 6/22/2026 8:06 PM, David Marchand wrote:
> On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
> <raghavendra.ningoji@amd.com> wrote:
>> Add the skeleton of a new dmadev poll-mode driver for the AMD AE4DMA
>> hardware DMA engine, providing only PCI probe/remove and per-queue
>> hardware initialisation. An AE4DMA engine exposes 16 hardware command
>> queues, each with a 32-entry descriptor ring; the PMD maps each
>> hardware channel to its own dmadev with a single virtual channel,
>> so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
>> "<pci-bdf>-ch15".
> I am not familiar with DMA drivers, I am not sure it is something acceptable.
> @Chengwen for info.

This is acceptable. For a DMA controller (which may be a PCI device), there
may be multiple hardware channels, and each hardware channel is presented as
a dmadev device. The device name can be in the format of BDF-chX.

