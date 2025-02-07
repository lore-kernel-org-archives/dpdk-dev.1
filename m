Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE9C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 06:37:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD4C2427AE;
	Fri,  7 Feb 2025 07:37:28 +0100 (CET)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id BD95F427A9
 for <dev@dpdk.org>; Fri,  7 Feb 2025 07:37:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yq41Q5dK9z1V6G6;
 Fri,  7 Feb 2025 14:33:46 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id A5AAA1A0188;
 Fri,  7 Feb 2025 14:37:26 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 14:37:26 +0800
Message-ID: <fe4426ba-bdb3-4f48-b970-244b92f76c69@huawei.com>
Date: Fri, 7 Feb 2025 14:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mbuf: add packet offload Rx flag for keep CRC
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <haijie1@huawei.com>, <liuyonglong@huawei.com>
References: <20250124095957.3496874-1-huangdengdui@huawei.com>
 <20250124093436.78d9c232@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250124093436.78d9c232@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2025/1/25 1:34, Stephen Hemminger wrote:
> On Fri, 24 Jan 2025 17:59:57 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
>> index 559d5ad8a7..c828200ea1 100644
>> --- a/lib/mbuf/rte_mbuf.c
>> +++ b/lib/mbuf/rte_mbuf.c
>> @@ -771,7 +771,7 @@ const char *rte_get_rx_ol_flag_name(uint64_t mask)
>>  	case RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD: return "RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD";
>>  	case RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID:
>>  		return "RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID";
>> -
>> +	case RTE_MBUF_F_RX_KEEP_CRC: return "RTE_MBUF_F_RX_KEEP_CRC";
>>  	default: return NULL;
>>  	}
> 
> DPDK style is to add break line after the case statement.
> Please do it for both cases.

OK,I made a mistake.
