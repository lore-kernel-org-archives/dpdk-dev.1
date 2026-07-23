Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2650C44524
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 04:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9060402AD;
	Thu, 23 Jul 2026 06:00:49 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 20E8A4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 06:00:47 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lia5dOHUtONCOE4Qf1pTqS51r0WiiyTDMhzL9Vo/qjY=;
 b=rQ0bGfaxN+5l3JdnoTFvIGlTkJjRJdwJWDOBJSl/OnWaqegv48ZBbDaCNOYGtc/H+LUbSAoaB
 rDujHCIXpTtJSc1E6WgaT3cSuWH65hZQvvPLmOoUFC0N4cNQ63HG0GNM8wk+qg8n4IIqhWv9sKZ
 hFE64lL/e089ch0GL2HifQ4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5HGr1FxKz1prKd;
 Thu, 23 Jul 2026 11:51:16 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 62C0E40579;
 Thu, 23 Jul 2026 12:00:41 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 12:00:40 +0800
Message-ID: <2fd6e7d8-7679-2c7e-5716-ccc20550ded0@huawei.com>
Date: Thu, 23 Jul 2026 12:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3] app/testpmd: support runt and ultra-small frames in
 txonly
Content-Language: en-CA
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <aman.deep.singh@intel.com>, 
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <liuyonglong@huawei.com>,
 <kangfenglong@huawei.com>
References: <20260706132050.3054235-1-yangxingui@huawei.com>
 <20260722152256.16fa03a9@phoenix.local>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260722152256.16fa03a9@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: kwepemh100009.china.huawei.com (7.202.181.94) To
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



On 2026/7/23 6:22, Stephen Hemminger wrote:
> On Mon, 6 Jul 2026 21:20:50 +0800
> Xingui Yang <yangxingui@huawei.com> wrote:
> 
>> Allow set txpkts to accept packet lengths as small as one byte,
>> enabling generation of runt frames and ultra-small packets for
>> testing NIC padding logic and undersized frame handling.
>>
>> The txonly engine handles three ranges: normal (>= 42 bytes) with
>> full Ethernet/IPv4/UDP headers, runt (14-41 bytes) with truncated
>> headers, and ultra-small (< 14 bytes) filled with a repeating
>> pattern. Checksum offloads are disabled when headers are incomplete.
>>
>> Minimum length validation in set_tx_pkt_segments() is relaxed from
>> 42 to 1 byte. Random split and multi-flow still require the full
>> header stack in the first segment, as enforced by tx_only_begin().
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
>> ---
>   
> I would suggest that if NIC ever gets a packet < ethernet header it is
> an application bug, and driver should drop it as an transmit error.
> Or crash with an assert failed. There is no guarantee that this
> will ever work.
> 
> Therefore can not see why testpmd needs to do this.
> 
> For packets with Ethernet header plus a few more bytes, it makes
> sense to allow. There are always control level protocols that are
> very short.

Haha, I think you're right. We have an internal test case for 
ultra-short packets to verify hardware capabilities, and this test case 
has been around for many years. We have maintained this private patch 
separately for many years. It's possible that other network cards might 
not have such a requirement.

Thanks.
Xingui
