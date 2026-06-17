Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B87CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A906540289;
	Wed, 17 Jun 2026 10:42:30 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 6D92C4027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:42:28 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ZlTZB1yDiMO7Tbl3QtliIo6W+dwBNnjezTWZU79DBLw=;
 b=d/cFT7pcW/FHbMhvGRxpwfCqMq+LzhrNEP+H08INBdAzMweBHtB1d7O6NAX/MGaNpcVXwWbx2
 hfewn+lemIFrzA9PqCq8ONcnQCEvzh8PlE/QJLgAhnVe9HKFJSpK0nlL5chiWAR1lcL+MUTLkSt
 L88tVqJHv5Bcph3CU5GfbJM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4ggHG731cczLlTj;
 Wed, 17 Jun 2026 16:34:23 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 85B9840561;
 Wed, 17 Jun 2026 16:42:21 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 16:42:20 +0800
Message-ID: <b3007bab-f9d9-8d69-e369-368fa317d84f@huawei.com>
Date: Wed, 17 Jun 2026 16:42:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] app/testpmd: add VLAN priority insert support
Content-Language: en-CA
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <aman.deep.singh@intel.com>, 
 <fengchengwen@huawei.com>, <yangshuaisong@h-partners.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
 <20260616131001.2955655-1-yangxingui@huawei.com>
 <20260616072328.1dcb8cf8@phoenix.local>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260616072328.1dcb8cf8@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh500015.china.huawei.com (7.202.181.149) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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



On 2026/6/16 22:23, Stephen Hemminger wrote:
> On Tue, 16 Jun 2026 21:10:01 +0800
> Xingui Yang <yangxingui@huawei.com> wrote:
> 
>> The tx_vlan set and tx_qinq set commands only accepted VLAN ID in range
>> [0, 4095]. This prevented users from setting 802.1p priority and CFI
>> bits when using hardware VLAN insertion.
>>
>> Since mbuf vlan_tci field already supports full 16-bit VLAN Tag Control
>> Information (TCI), relax the validation for TX paths to allow priority
>> and CFI bits. The vlan_id parameter now accepts:
>>    - Bits 0-11:  VLAN ID (0-4095)
>>    - Bit 12:    CFI (Canonical Format Indicator)
>>    - Bits 13-15: Priority (0-7, 802.1p CoS)
>>
>> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
>> Suggested-by: fengchengwen <fengchengwen@huawei.com>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>> v2:
>> - Removed --enable-vlan-priority option and global variable as suggested
>>    by Stephen Hemminger. The feature is now always enabled for TX paths
>> - RX VLAN filter continues to enforce strict VLAN ID validation as
>>    suggested by fengchengwen
>> - Added documentation updates for testpmd_funcs.rst and release notes
>>
>>   app/test-pmd/config.c                       | 13 ++++++++-----
>>   doc/guides/rel_notes/release_26_07.rst      |  7 +++++++
>>   doc/guides/testpmd_app_ug/testpmd_funcs.rst | 17 ++++++++++++++---
>>   3 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
>> index 9d457ca88e..38758f9c05 100644
>> --- a/app/test-pmd/config.c
>> +++ b/app/test-pmd/config.c
>> @@ -1241,8 +1241,11 @@ void print_valid_ports(void)
>>   }
>>   
>>   static int
>> -vlan_id_is_invalid(uint16_t vlan_id)
>> +vlan_id_is_invalid(uint16_t vlan_id, bool is_tx)
>>   {
>> +	if (is_tx)
>> +		return 0;
>> +
>>   	if (vlan_id < 4096)
>>   		return 0;
>>   	fprintf(stderr, "Invalid vlan_id %d (must be < 4096)\n", vlan_id);
>> @@ -6876,7 +6879,7 @@ rx_vft_set(portid_t port_id, uint16_t vlan_id, int on)
>>   
>>   	if (port_id_is_invalid(port_id, ENABLED_WARN))
>>   		return 1;
>> -	if (vlan_id_is_invalid(vlan_id))
>> +	if (vlan_id_is_invalid(vlan_id, false))
>>   		return 1;
>>   	diag = rte_eth_dev_vlan_filter(port_id, vlan_id, on);
>>   	if (diag == 0)
>> @@ -6923,7 +6926,7 @@ tx_vlan_set(portid_t port_id, uint16_t vlan_id)
>>   	struct rte_eth_dev_info dev_info;
>>   	int ret;
>>   
>> -	if (vlan_id_is_invalid(vlan_id))
>> +	if (vlan_id_is_invalid(vlan_id, true))
>>   		return;
> 
> Why have the is_tx flag if it is always used as constant?
> Just remove the whole vlan_id_is_invalid() branch test in the transmit path.
> Maybe add a comment that any VLAN is allowed on transmit?
> 
> Or make a new function. Since VLAN of 0xffff is reserved. Though you might want
> to allow it since testpmd is for testing even invalid packets.

Hi, Stephen,

Agreed, and I've also taken the opportunity to improve consistency by 
rename vlan_id to vlan_tci. I'll update in next version.

Thanks,
Xingui


