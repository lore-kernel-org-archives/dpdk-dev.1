Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5CC021AF
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 01:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64CC14025A;
	Wed, 19 Feb 2025 02:04:43 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 196D540041
 for <dev@dpdk.org>; Wed, 19 Feb 2025 02:04:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YyJ2r4mjTz1Y1ry;
 Wed, 19 Feb 2025 09:00:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 30C71140159;
 Wed, 19 Feb 2025 09:04:40 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 09:04:39 +0800
Message-ID: <3d4bc080-6353-41ec-bb83-783684cebf08@huawei.com>
Date: Wed, 19 Feb 2025 09:04:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] bus/auxiliary: remove weak symbols
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <andremue@linux.microsoft.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
 <20250218153730.773836-2-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250218153730.773836-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/2/18 23:37, David Marchand wrote:
> Rather than use weak symbols, expose stubs symbols when needed.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

