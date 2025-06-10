Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE2CC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 01:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0C7741109;
	Tue, 10 Jun 2025 03:27:53 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id A6B5740276
 for <dev@dpdk.org>; Tue, 10 Jun 2025 03:27:51 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bGWMJ4pkpz13M10;
 Tue, 10 Jun 2025 09:25:48 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 6B68D180493;
 Tue, 10 Jun 2025 09:27:49 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 09:27:48 +0800
Message-ID: <fe7134f5-2f9c-487a-9828-bb2dbd4d879f@huawei.com>
Date: Tue, 10 Jun 2025 09:27:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net/hns3: fix the hardware GRO function is abnormal
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250609130651.2752977-1-huangdengdui@huawei.com>
 <20250609130651.2752977-2-huangdengdui@huawei.com>
 <20250609101354.45732d12@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250609101354.45732d12@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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


On 2025/6/10 1:13, Stephen Hemminger wrote:
> On Mon, 9 Jun 2025 21:06:49 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> +	rem = dma_addr & (HNS3_RX_DMA_ADDR_ALIGN_128 - 1);
>> +	if ((rx_offload & RTE_ETH_RX_OFFLOAD_TCP_LRO) && rem > 0) {
>> +		hns3_err(hw, "Hardware GRO is not supported when mbuf DMA "
>> +			 "address is 64-byte aligned");
>> +		return -EINVAL;
> 
> Best to not break messages across source lines, it makes it harder for users
> and tools looking for error messages in the source.
> 
> I.e do:
> 		hns3_err(hw, 
> 			 "Hardware GRO is not supported for if mbuf DMA not 64-byte aligned");
> 			 "
> I can fix during merge if that is ok? or you can resubmit

I made a mistake, can you help me fix it when merging?

Thanks
