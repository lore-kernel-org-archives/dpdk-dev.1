Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8BCD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 07:27:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1DA40264;
	Fri, 29 May 2026 09:27:20 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id AD808400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 09:27:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rTnVScXheCfnjoJTbjHC0PrggQ96JPChuMQ8KxV4jDo=;
 b=QuPVGwehTkQvLI9i8tH5kTdLy5Db9e4lB9ItjzYkKfcB6Feb/4mm1k150G5OoXMf3PWGcYhzH
 B3sN79TtPm65rUQDRikjVqyYi3P6LKZA6opoxeanWIP43eJpIxHDrlSY8RFekYWH0DZPnMDPsgv
 3ikyAzKjfFrkyuZEyFg0hEU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gRZVT5RYfzLlSZ;
 Fri, 29 May 2026 15:19:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3473D402AB;
 Fri, 29 May 2026 15:27:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 15:27:15 +0800
Message-ID: <124390f4-6c99-4782-9161-545752784ee8@huawei.com>
Date: Fri, 29 May 2026 15:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/25] bus: support multiple probe
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <20260527075654.3780732-16-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260527075654.3780732-16-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Currently, the bus probe is still the specific impl which don't test allow_multi_probe flag.
And local_dev_probe only cover the plug device case.

On 5/27/2026 3:56 PM, David Marchand wrote:
> Add infrastructure to declare support for multiple probe attempts
> on the same device. This prepares for the introduction of
> generic probe_device operation.
> 
> The PCI bus enables this feature to support drivers with
> RTE_PCI_DRV_PROBE_AGAIN flag.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

...
