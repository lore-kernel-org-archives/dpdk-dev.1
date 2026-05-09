Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DCCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 07:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9622402AB;
	Sat,  9 May 2026 09:19:03 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6564026D
 for <dev@dpdk.org>; Sat,  9 May 2026 09:19:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=GsOWg6wtqWd6BVDsKBlqlvfUImggpCBVQT01nijhw5E=;
 b=ypY3fcs/zfe81ZszmW1RK6LIZdF2Dk/dUkQ1/jd7SgitrRJsOD54NmpWzqOwP5BJ4c0jBXqA5
 JsCFCQJpq9h24HIAxxrxEU0x2jgLkuLHO28xTLrGzhqgSUteYRrlZNxbKYM5GdMkf+5+DHpzpjP
 IFC7LgE1JNFVXnza3ZzixU4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gCHGP5C7NzRhsn;
 Sat,  9 May 2026 15:11:25 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 06B6B40576;
 Sat,  9 May 2026 15:19:00 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 15:18:59 +0800
Message-ID: <661f7210-3d5e-4d18-be71-3822151893c1@huawei.com>
Date: Sat, 9 May 2026 15:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/hns3: fix L4 checksum incorrect for tunnel packets
To: Xingui Yang <yangxingui@huawei.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260509064753.3292074-1-yangxingui@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260509064753.3292074-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 5/9/2026 2:47 PM, Xingui Yang wrote:
> In HIP09 simple BD mode, the driver incorrectly calculates L4_START
> position for tunnel packets. The current implementation only uses
> l2_len + l3_len without considering outer header lengths (outer_l2_len
> and outer_l3_len), causing hardware to calculate checksum from wrong
> offset.
> 
> For a typical NvGRE tunnel packet with structure:
>   Outer Eth(14) + Outer IPv6(40) + NvGRE(8) + Inner Eth(14) +
>   Inner IPv6(40) + TCP(20)
> 
> Expected L4_START: 116 bytes (from packet start to inner TCP header)
> Actual calculation: 62 bytes (missing outer headers)
> 
> This results in incorrect TCP/UDP checksum for all tunnel packets when
> using simple BD mode, including NvGRE, VxLAN, GRE, GENEVE tunnels.
> 
> Fix by adding outer_l2_len and outer_l3_len to L4_START calculation
> when RTE_MBUF_F_TX_TUNNEL_MASK flag is set.
> 
> Fixes: 6393fc0b823c ("net/hns3: simplify hardware checksum offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

