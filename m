Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 01:33:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B73204025D;
	Fri, 15 Aug 2025 03:33:22 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id CB4844021F
 for <dev@dpdk.org>; Fri, 15 Aug 2025 03:33:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c34JV0ycwzdcMJ;
 Fri, 15 Aug 2025 09:28:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B3524180087;
 Fri, 15 Aug 2025 09:33:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:33:18 +0800
Message-ID: <8b5a9c85-0c12-4afd-997b-b190a426597d@huawei.com>
Date: Fri, 15 Aug 2025 09:33:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] net/zxdh: add support flow director ops
To: Stephen Hemminger <stephen@networkplumber.org>, Bingbin Chen
 <chen.bingbin@zte.com.cn>
CC: <ivan.malov@arknetworks.am>, <wang.junlong1@zte.com.cn>,
 <yang.yonggang@zte.com.cn>, <dev@dpdk.org>
References: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
 <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
 <20250814025248.2194951-3-chen.bingbin@zte.com.cn>
 <20250814095901.49018c75@hermes.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250814095901.49018c75@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Hi Stephen,

On 8/15/2025 12:59 AM, Stephen Hemminger wrote:
> On Thu, 14 Aug 2025 10:52:42 +0800
> Bingbin Chen <chen.bingbin@zte.com.cn> wrote:
> 
>> +		} else {
>> +			entry = calloc(1, sizeof(struct rte_flow));
>> +			entry_flow = calloc(1, sizeof(struct zxdh_flow));
>> +			TAILQ_FOREACH(entry, &hw->dh_flow_list, next) {
>> +				entry_flow = (struct zxdh_flow *)entry->driver_flow;
>> +				offlow_key_dump(&entry_flow->flowentry.fd_flow.key,
>> +						&entry_flow->flowentry.fd_flow.key_mask, file);
>> +				offlow_result_dump(&entry_flow->flowentry.fd_flow.result, file);
>> +			}
>> +			rte_free(entry_flow);
>> +			rte_free(entry)
> 
> Use the right free function!
> 
> ==== 20 line log output for Ubuntu 24.04 (dpdk_unit_test): ====
> ../drivers/net/zxdh/zxdh_flow.c:641:36: note: returned from 'calloc'
> 641 |                         key_mask = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/zxdh/zxdh_flow.c:689:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
> 689 |         rte_free(key);
> |         ^~~~~~~~~~~~~
> ../drivers/net/zxdh/zxdh_flow.c:640:31: note: returned from 'calloc'
> 640 |                         key = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/zxdh/zxdh_flow.c:690:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
> 690 |         rte_free(fd_entry);
> |         ^~~~~~~~~~~~~~~~~~
> ../drivers/net/zxdh/zxdh_flow.c:639:36: note: returned from 'calloc'
> 639 |                         fd_entry = calloc(1, sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T) * ZXDH_MAX_FLOW_NUM);
> |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Just curiosity, which test catch this error? There are no driver rte_flow API test in meson test as I know.

Thanks


