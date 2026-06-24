Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FECCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51FD440299;
	Wed, 24 Jun 2026 03:24:20 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 40F3940150;
 Wed, 24 Jun 2026 03:24:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ilI2bx8OzqAvnC6g6+vWkR0P0I4oi9QLPMlbL+kMXKc=;
 b=xVYzo0ZBg4nQ6ZstwVTlhzvGPrvQCCp1cgvVItfDdUPDZaldqqZ/7zfU4MtT0MHrqwggQwcns
 cwHpBCqPObsOTX6+wt+thrMoT3af/4tGLjDgbyo6JEBs0WKKj8b0Vy/gcI0ptjptM2bMJIFy5+9
 9bkGnbVf31ttVKf1m5PC9q8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4glPB72c0fzmV6N;
 Wed, 24 Jun 2026 09:15:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id A6D5A40562;
 Wed, 24 Jun 2026 09:24:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 09:24:15 +0800
Message-ID: <c4c30773-40ad-4eca-a369-926886e17ab1@huawei.com>
Date: Wed, 24 Jun 2026 09:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] bus/pci: fix mapping leak in bus cleanup
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <longli@microsoft.com>,
 <hemant.agrawal@nxp.com>, <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>, Kevin Laatz <kevin.laatz@intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-5-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260623105439.2144694-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 6/23/2026 6:54 PM, David Marchand wrote:
> When calling this bus cleanup, PCI resources were not unmapped.
> 
> Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/pci/pci_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
> index fd18b8772b..791e9a7b49 100644
> --- a/drivers/bus/pci/pci_common.c
> +++ b/drivers/bus/pci/pci_common.c
> @@ -344,6 +344,10 @@ pci_cleanup(void)
>  			rte_errno = errno;
>  			error = -1;
>  		}
> +
> +		if (drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
> +			rte_pci_unmap_device(dev);

rte_pci_unmap_device() also invoked in some drivers remove callback, e.g.
  eth_virtio_pci_uninit()
  ifcvf_pci_remove()
  ...

In this case it may doulbe-free

> +
>  		dev->device.driver = NULL;
>  
>  free:

