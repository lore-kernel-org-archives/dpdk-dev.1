Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E782CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 13:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48A0940289;
	Tue, 16 Jun 2026 15:19:16 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id A3EBF4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:19:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=v2GYuWrUM+I+M2T0W5Jew3VwaQjCgkdq05oTHFLjB2Q=;
 b=O6hxrNgReJORj/i5g1EI9L9PEdTA9wwG2KKjJtpivwFzHfVxxnxpQp6QLiWB7z4qugkd+JPKa
 DbCDa/pkOMscAneq//9Rc5FSF7dKvFdiZvJxb405opzaUVwFT4t2M282fpGXcpWZV6/GihNmnN8
 mXin6FdWwSrO0kQ5HY6Cze8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gfnRy3fVnzKm6Z;
 Tue, 16 Jun 2026 21:11:10 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id F40F040539;
 Tue, 16 Jun 2026 21:19:10 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 16 Jun 2026 21:19:10 +0800
Message-ID: <53403b6b-a208-0058-b998-f1dc8e984398@huawei.com>
Date: Tue, 16 Jun 2026 21:19:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] app/testpmd: add VLAN priority insert support
Content-Language: en-CA
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <aman.deep.singh@intel.com>, 
 <fengchengwen@huawei.com>, <yangshuaisong@h-partners.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
 <20260615121214.6fb7d8b7@phoenix.local>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20260615121214.6fb7d8b7@phoenix.local>
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



On 2026/6/16 3:12, Stephen Hemminger wrote:
> On Fri, 12 Jun 2026 16:14:11 +0800
> Xingui Yang <yangxingui@huawei.com> wrote:
> 
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
> 
> 
> Having ability to set priority bits is good, and testpmd should allow it.
> The mbuf vlan_tci is already a full 16-bit TCI (priority/CFI/VID), and
> the TX insert path copies tx_vlan_id straight into it.  So priority
> insert already works; the only thing in the way is the < 4096 check.
> 
> Do you actually need a new option for this?  Both of_push_vlan +
> of_set_vlan_pcp (rte_flow) and "tx_vlan set pvid" already let you set
> the priority bits today, with no new code.
> 
> If you still want "tx_vlan set" itself to carry priority, I'd suggest
> a smaller change: relax only the TX insert validators and drop the
> option and the global.  Don't touch rx_vft_set -- it feeds the VLAN
> filter, which only takes a VLAN ID and rejects > 4095 anyway, so the
> flag just turns a clear error into a confusing one.
> 
> Either way, if the option stays, please document it, and add a release note.
> The commit message why the existing paths aren't enough.

Thank you for the suggestion. I have implemented the simpler approach in v2.

Thanks,
Xingui
