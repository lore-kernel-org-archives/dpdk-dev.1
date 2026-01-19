Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A478C98315
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 00:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53290402AF;
	Mon, 19 Jan 2026 01:47:21 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3FE402AA
 for <dev@dpdk.org>; Mon, 19 Jan 2026 01:47:19 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zXnfkNGL8MtpB2U+ua5jaOTgCfu4mJ0cV4s74/FWG1M=;
 b=S5j22SOAn3ctmMdsEfEt7DszouPCpJfYoIiIXLzNIFApxClWjisGhpn6c0CKsGVRYdvuctuDA
 QOFTxLoelU0xFV6jHbVR9bl90Vk1UnLLzPVhvCxMZGqS7EYOzKIXWflbRu8a8hzMmb0x7ZplFTl
 wTdOmPR97tysbNUxcnUUepo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dvWt30TMqzLlT4;
 Mon, 19 Jan 2026 08:43:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C248E40563;
 Mon, 19 Jan 2026 08:47:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 08:47:16 +0800
Message-ID: <2c017afc-bde3-4f48-97bf-fa6bf7a17386@huawei.com>
Date: Mon, 19 Jan 2026 08:47:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/29] doc/guides: improve DMA sample app guide
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20260114222458.87119-1-stephen@networkplumber.org>
 <20260114222458.87119-17-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260114222458.87119-17-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 1/15/2026 6:21 AM, Stephen Hemminger wrote:
> Improve the DMA sample application documentation:
> - use Tx/Rx instead of TX/RX per DPDK style
> - use "software" and "hardware" instead of SW/HW abbreviations
> - add missing articles and fix punctuation
> - use consistent option formatting with leading dash
> - fix grammatical errors throughout
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/sample_app_ug/dma.rst | 104 +++++++++++++++----------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 

...

>  .. literalinclude:: ../../../examples/dma/dmafwd.c
> @@ -210,8 +210,8 @@ When using hardware copy each Rx queue of the port is assigned a DMA device
>  
>  The initialization of hardware device is done by ``rte_dma_configure()`` and
>  ``rte_dma_vchan_setup()`` functions using the ``rte_dma_conf`` and
> -``rte_dma_vchan_conf`` structs. After configuration the device is started
> -using ``rte_dma_start()`` function. Each of the above operations is done in
> +``rte_dma_vchan_conf`` structs. After configuration, the device is started

The rte_dma_vchan_conf is used with rte_dma_vchan_setup()
So maybe we could only descript functions, e.g.
  ``rte_dma_vchan_setup()`` functions. After configuration, the device is started

with this fixed, please:
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

> +using the ``rte_dma_start()`` function. Each of the above operations is done in
>  ``configure_dmadev_queue()``.
>  

...

