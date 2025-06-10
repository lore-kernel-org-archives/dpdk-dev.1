Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC52C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F627402D4;
	Tue, 10 Jun 2025 09:57:08 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id DF2FB40299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 09:57:06 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bGgxv3bFJzRjcn;
 Tue, 10 Jun 2025 15:52:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3921D180450;
 Tue, 10 Jun 2025 15:57:04 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 15:57:03 +0800
Message-ID: <7355246d-a914-48b6-acf6-4f67b3a9760b@huawei.com>
Date: Tue, 10 Jun 2025 15:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/l3fwd: adjust Tx burst size based on Rx burst
To: huangdengdui <huangdengdui@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: <david.hunt@intel.com>, <anatoly.burakov@intel.com>, <jerinj@marvell.com>, 
 <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <Ferruh.Yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>, <dev@dpdk.org>,
 Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <20250609082154.489681e1@hermes.local>
 <55beecec-89f9-43df-8eec-9e51bd72ed1c@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <55beecec-89f9-43df-8eec-9e51bd72ed1c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 2025/6/10 14:42, huangdengdui wrote:
> 
> On 2025/6/9 23:21, Stephen Hemminger wrote:
>> On Mon, 9 Jun 2025 09:58:27 +0000
>> Sivaprasad Tummala <sivaprasad.tummala@amd.com> wrote:
>>
>>> Previously, the TX burst size was fixed at 256, leading to performance
>>> degradation in certain scenarios.
>>>
>>> This patch introduces logic to set the TX burst size to match the
>>> configured RX burst size (--burst option, default 32, max 512)
>>> for better efficiency.
>>>
>>> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
>>> Cc: haijie1@huawei.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>> Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
>>> Tested-by: Dengdui Huang <huangdengdui@huawei.com>
>>
>> What driver? Why not fix the driver.
>> If RX burst is small, there should be no way to get TX burst larger
>> than that to happen.
> 
> If the Tx burst is too large, a number of mbufs will be temporarily stored in l3fwd's mbuf_table in a short period of time.
> This leads to a decrease in the hit rate of the mempool cache, resulting in a drop in performance.

This commit introduce coupling in Tx burst size and Rx burst size.
Different arch may have differ combination for Rx/Tx burst and descriptors.
So how about add one extra option for Tx burst size, and default the same with MAX_PKT_BURST.

> 

