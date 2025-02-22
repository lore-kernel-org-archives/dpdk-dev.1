Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0ACC021B3
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 01:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACBA4027D;
	Sat, 22 Feb 2025 02:53:37 +0100 (CET)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 974E640267
 for <dev@dpdk.org>; Sat, 22 Feb 2025 02:53:35 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z095m3mkwzpkDR;
 Sat, 22 Feb 2025 09:54:04 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 28C02140155;
 Sat, 22 Feb 2025 09:53:33 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 09:53:32 +0800
Message-ID: <4d6ed2e8-957d-0c2d-cc19-7246c9266a5c@huawei.com>
Date: Sat, 22 Feb 2025 09:53:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] net: add ptype parse for tunnel packets
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <huangdengdui@huawei.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Long Li <longli@microsoft.com>, Gagandeep Singh
 <g.singh@nxp.com>
References: <20250108024632.12152-1-haijie1@huawei.com>
 <20250214015638.29983-1-haijie1@huawei.com>
 <20250214015638.29983-2-haijie1@huawei.com>
 <20250214083553.492ddbd7@hermes.local>
From: Jie Hai <haijie1@huawei.com>
In-Reply-To: <20250214083553.492ddbd7@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

On 2025/2/15 0:35, Stephen Hemminger wrote:
> On Fri, 14 Feb 2025 09:56:37 +0800
> Jie Hai <haijie1@huawei.com> wrote:
> 
>> Add packet types parse for vxlan/vxlan-gpe/gtp/geneve packets.
>>
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>> ---
> 
> Not sure about this.
> The original purpose of ptype was to support hardware offload information.
> 
> Does any driver do this ptype detection in tunnels?
> 
> Would the software detection produce the same result as HW offload?
> .
As far as I know, there are two types of packet type: sw packet type and 
hw packet type.

The formmer comes from the call of function rte_net_get_ptype(), which 
parses the
network headers in mbuf data and return its packet type.
All caller(of different drivers) share the same standard.
And it's commonly used in Tx checksum process.

The latter comes from the 'packet_type' field in mbuf.
It is about data really present in the Rx mbuf, and it is defined by drivers
themselves and generally arived from Rx descriptor (or hardware).

Only a few drivers use rte_net_get_ptype() to set packet_type, e.g.

1.With mask RTE_PTYPE_L2_MASK | RTE_PTYPE_L3_MASK | RTE_PTYPE_L4_MASK
	drivers\net\netvsc\hn_rxtx.c
	drivers\net\pfe\pfe_hif_lib.c  under contidion RTE_LIBRTE_PFE_SW_PARSE

2. With mask RTE_PTYPE_ALL_MASK
	drivers\net\tap\rte_eth_tap.c
	drivers\net\virtio\virtio_rxtx_packed.h
	drivers\net\virtio\virtio_rxtx.c
	lib\vhost\virtio_net.c
	lib\node\kernel_rx.c


What this patch changes is the sw packet type, only these examples are 
affected.

And they may not have hardware information of packets to report.
Please check whether there is any impact, @all maintainers.

