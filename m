Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D99CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB7940289;
	Tue, 16 Jun 2026 15:17:30 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 623EC4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:17:28 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Pqn0syNtkHqsU9gMn3N8saHbB6IkhQCs2QRqe6CB8Vw=;
 b=CA69+PU9Jfwk7ZWlRONag+7RvmoiVhk4ehr84uAdS74Ge0ILFMyuPw4nAx5C/aUBMK4XwTAtU
 eXb8++AK9A12xT0RwDBR8DhcMjtHhfNXm2XTIQB9siFCWQn03rqlxZavqlEc5EYt7IeqVxgj8Fy
 cAdrPszeiMOXV4CarpISGBs=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gfnPw3zVCzmV8N;
 Tue, 16 Jun 2026 21:09:24 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id C485D40572;
 Tue, 16 Jun 2026 21:17:23 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 16 Jun 2026 21:17:23 +0800
Message-ID: <c340d803-c951-a45c-8f3b-ab3cf94f2718@huawei.com>
Date: Tue, 16 Jun 2026 21:17:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] app/testpmd: add VLAN priority insert support
Content-Language: en-CA
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <yangshuaisong@h-partners.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
 <7ead3834-afaa-4319-83bf-faf19b3ea3ef@huawei.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <7ead3834-afaa-4319-83bf-faf19b3ea3ef@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh200010.china.huawei.com (7.202.181.119) To
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



On 2026/6/15 17:46, fengchengwen wrote:
> On 6/12/2026 4:14 PM, Xingui Yang wrote:
>> The tx_vlan set command currently only accepts a VLAN ID in range
>> [0, 4095].  This patch adds support for an extended format that includes
>> 802.1p priority and CFI bits, allowing users to set the VLAN priority
>> tag when inserting VLAN headers in TX packets.
>>
>> The extended format is:
>>    bit 0-11:  VLAN ID (0-4095)
>>    bit 12:    CFI (Canonical Format Indicator)
>>    bit 13-15: Priority (0-7, 802.1p CoS)
>>
>> This is consistent with the VLAN tag structure used by
>> rte_eth_dev_set_vlan_pvid() where the PVID field encodes VLAN ID, CFI
>> and priority in the same format.
>>
>> A new command line option --enable-vlan-priority is added to enable this
>> feature. By default, the feature is disabled to maintain backward
>> compatibility with existing users. When enabled, the
>> vlan_id_is_invalid() function allows any 16-bit value to pass, while the
>> full 16-bit value (including CFI and priority bits) is passed to the
>> driver for hardware VLAN insertion.
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   app/test-pmd/config.c     | 24 +++++++++++++++---------
>>   app/test-pmd/parameters.c |  6 ++++++
>>   app/test-pmd/testpmd.c    |  5 +++++
>>   app/test-pmd/testpmd.h    |  2 ++
>>   4 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
>> index 36b9b023e2..80cde109e6 100644
>> --- a/app/test-pmd/config.c
>> +++ b/app/test-pmd/config.c
>> @@ -1241,12 +1241,18 @@ void print_valid_ports(void)
>>   }
>>   
>>   static int
>> -vlan_id_is_invalid(uint16_t vlan_id)
>> +vlan_id_is_invalid(uint16_t vlan_id, int vlan_priority_ena)
>>   {
>> -	if (vlan_id < 4096)
>> -		return 0;
>> -	fprintf(stderr, "Invalid vlan_id %d (must be < 4096)\n", vlan_id);
>> -	return 1;
>> +	if (!vlan_priority_ena && vlan_id >= 4096) {
>> +		fprintf(stderr, "Invalid vlan_id %d (must be < 4096)\n", vlan_id);
>> +		return 1;
>> +	}
>> +
>> +	/*
>> +	 * When vlan_priority_ena is enabled, allow any 16-bit value
>> +	 * to pass priority and CFI bits to the driver.
>> +	 */
>> +	return 0;
>>   }
>>   
>>   static uint32_t
>> @@ -6876,7 +6882,7 @@ rx_vft_set(portid_t port_id, uint16_t vlan_id, int on)
>>   
>>   	if (port_id_is_invalid(port_id, ENABLED_WARN))
>>   		return 1;
>> -	if (vlan_id_is_invalid(vlan_id))
>> +	if (vlan_id_is_invalid(vlan_id, vlan_priority_insert_ena))
> 
> Just vlan_id_is_invalid(vlan_id, false) because Rx is no need to impl this.
> 
>>   		return 1;
>>   	diag = rte_eth_dev_vlan_filter(port_id, vlan_id, on);
>>   	if (diag == 0)
>> @@ -6923,7 +6929,7 @@ tx_vlan_set(portid_t port_id, uint16_t vlan_id)
>>   	struct rte_eth_dev_info dev_info;
>>   	int ret;
>>   
>> -	if (vlan_id_is_invalid(vlan_id))
>> +	if (vlan_id_is_invalid(vlan_id, vlan_priority_insert_ena))
>>   		return;
>>   
>>   	if (ports[port_id].dev_conf.txmode.offloads &
>> @@ -6954,9 +6960,9 @@ tx_qinq_set(portid_t port_id, uint16_t vlan_id, uint16_t vlan_id_outer)
>>   	struct rte_eth_dev_info dev_info;
>>   	int ret;
>>   
>> -	if (vlan_id_is_invalid(vlan_id))
>> +	if (vlan_id_is_invalid(vlan_id, vlan_priority_insert_ena))
>>   		return;
>> -	if (vlan_id_is_invalid(vlan_id_outer))
>> +	if (vlan_id_is_invalid(vlan_id_outer, vlan_priority_insert_ena))
>>   		return;
>>   
>>   	ret = eth_dev_info_get_print_err(port_id, &dev_info);
>> diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
>> index 8c3b1244e7..3f37498d3b 100644
>> --- a/app/test-pmd/parameters.c
>> +++ b/app/test-pmd/parameters.c
>> @@ -117,6 +117,8 @@ enum {
>>   	TESTPMD_OPT_ENABLE_HW_VLAN_EXTEND_NUM,
>>   #define TESTPMD_OPT_ENABLE_HW_QINQ_STRIP "enable-hw-qinq-strip"
>>   	TESTPMD_OPT_ENABLE_HW_QINQ_STRIP_NUM,
>> +#define TESTPMD_OPT_ENABLE_VLAN_PRIORITY "enable-vlan-priority"
>> +	TESTPMD_OPT_ENABLE_VLAN_PRIORITY_NUM,
> 
> How about TESTPMD_OPT_ENABLE_VLAN_INSERT_PRI "enable-vlan-insert-pri"

I have adopted the simpler approach as suggested by Stephen.

>>   #define TESTPMD_OPT_ENABLE_DROP_EN "enable-drop-en"
>>   	TESTPMD_OPT_ENABLE_DROP_EN_NUM,
>>   #define TESTPMD_OPT_DISABLE_RSS "disable-rss"
>> @@ -461,6 +463,7 @@ usage(char* progname)
>>   	printf("  --enable-hw-vlan-strip: enable hardware vlan strip.\n");
>>   	printf("  --enable-hw-vlan-extend: enable hardware vlan extend.\n");
>>   	printf("  --enable-hw-qinq-strip: enable hardware qinq strip.\n");
>> +	printf("  --enable-vlan-priority: enable vlan priority insert.\n");
>>   	printf("  --enable-drop-en: enable per queue packet drop.\n");
>>   	printf("  --disable-rss: disable rss.\n");
>>   	printf("  --enable-rss: Force rss even for single-queue operation.\n");
>> @@ -1259,6 +1262,9 @@ launch_args_parse(int argc, char** argv)
>>   		case TESTPMD_OPT_ENABLE_HW_QINQ_STRIP_NUM:
>>   			rx_offloads |= RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
>>   			break;
>> +		case TESTPMD_OPT_ENABLE_VLAN_PRIORITY_NUM:
>> +			vlan_priority_insert_ena = 1;
> 
> How about tx_insert_vlan_pri_en
> 
>> +			break;

I have adopted the simpler approach as suggested by Stephen, which 
eliminates the need for a new command-line option and global variable.

> 
> We need also update the testpmd document

OK.

Thanks,
Xingui


