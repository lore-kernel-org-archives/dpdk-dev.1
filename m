Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD58CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:56:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 717D54026D;
	Mon, 10 Nov 2025 10:56:10 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 0581D400D6;
 Mon, 10 Nov 2025 10:56:08 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qiHYV8Jz8v/Bim2bdHvdHROOJGqpQF0mwvq66YVsdDQ=;
 b=SykfihZrF9QVc8q/s7Z63Lsif65UGGSLZUtKq3eJrDDew2zfC8HRhgWPjJZT87kuHz6lnx4D7
 HusN+xBQdkQoQ4So48Nz1OYvxUseGqUVCPh0kzxzzt4XG6QrkVUygSwoheLzrBiYQKH9MRXHrJ+
 W7YU1/HQqHZlP0u/P6W1W+k=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d4lPb70GGzmV6v;
 Mon, 10 Nov 2025 17:54:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 687561400D4;
 Mon, 10 Nov 2025 17:56:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 17:56:05 +0800
Message-ID: <6bf71e03-6492-44d5-8361-c5879f25abf9@huawei.com>
Date: Mon, 10 Nov 2025 17:56:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
 header
To: Mingjin Ye <mingjinx.ye@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
 <20251105024724.830304-2-mingjinx.ye@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251105024724.830304-2-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Hi Mingjin,

Could you please detail the step of testcase? we will try to reproduce it and
see how to solve it.

Thanks.

On 11/5/2025 10:47 AM, Mingjin Ye wrote:
> This reverts commit 496159613ffc7b6ba592432a1ba4d1a38f6935de.
> 
> When the TX IP checksum offload feature is enabled, it may result in
> internal UDP checksum errors in VXLAN tunnel packets.
> 
> Fixes: 496159613ffc ("app/testpmd: fix L4 protocol retrieval from L3 header")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>

