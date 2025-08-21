Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7675ACA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 12:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68824402BD;
	Thu, 21 Aug 2025 14:16:30 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id AC946402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 14:16:28 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c72Nk4ScDz14MYb;
 Thu, 21 Aug 2025 20:16:22 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id E2A04180B69;
 Thu, 21 Aug 2025 20:16:26 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 20:16:26 +0800
Message-ID: <7c8afba1-feb3-4150-8e4e-60655a0c7191@huawei.com>
Date: Thu, 21 Aug 2025 20:16:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net/hns3: fix unrelease VLAN resource when init fail
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-3-huangdengdui@huawei.com>
 <20250813075138.0440576f@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250813075138.0440576f@hermes.local>
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


On 2025/8/13 22:51, Stephen Hemminger wrote:
> On Wed, 13 Aug 2025 15:33:16 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> +static void
>> +hns3_uninit_hardware(struct hns3_hw *hw)
>> +{
>> +	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
>> +
>> +	(void)hns3_uninit_umv_space(hw);
> 
> Overall, the patch looks good. But why the (void) cast here.
> The compiler allows ignoring return value unless the must check attribute is set.

Our internal coding standards require that when we do not check the return value of a function,
we use `(void)` to indicate that we have thoroughly considered that it is unnecessary to handle the return value here.
