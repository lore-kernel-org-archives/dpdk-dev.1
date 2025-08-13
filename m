Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC8CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 01:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A0814025D;
	Wed, 13 Aug 2025 03:07:01 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 12C0A400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 03:06:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1qr53mwPz13Mx1;
 Wed, 13 Aug 2025 09:03:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 464761402F0;
 Wed, 13 Aug 2025 09:06:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 09:06:56 +0800
Message-ID: <a1482800-d385-41df-94f4-e4308bc550eb@huawei.com>
Date: Wed, 13 Aug 2025 09:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/22] test/mempool: fix test without stack driver
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Marat Khalili
 <marat.khalili@huawei.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-4-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

The test_mempool() has 270 raw lines, suggest refactor it.

On 7/23/2025 9:31 PM, David Marchand wrote:
> In a minimal build, the mempool/stack driver is disabled.
> Separate the code specific to this external driver and rename unrelated
> variables.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>

