Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC62BC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 08:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B5D4028E;
	Tue,  3 Jun 2025 10:36:53 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 48B9E4025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 10:36:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bBPDW3WtRz23jSZ
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:35:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 03A95180044
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:36:48 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 16:36:47 +0800
Message-ID: <3ec043ae-f8c8-42d5-9af1-6bff2b0a7bc3@huawei.com>
Date: Tue, 3 Jun 2025 16:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] argparse: add support for string and boolean args
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250527092113.903910-2-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250527092113.903910-2-bruce.richardson@intel.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/5/27 17:21, Bruce Richardson wrote:
> Sometimes we don't want to parse the string at all, when doing arg
> parsing, and just save it off for later. Add support for that.
> 
> Also, rather than assuming boolean values have to be the same size as
> uint8 (or some other size), add an explicitly type for that - which also
> allows checking for true/false and 0/1 values explicitly.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

