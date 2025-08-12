Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB88CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 01:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FB5F40270;
	Tue, 12 Aug 2025 03:53:14 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 3BDE44026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 03:53:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c1Dtp3SjKzdcCx;
 Tue, 12 Aug 2025 09:48:50 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B5724180B54;
 Tue, 12 Aug 2025 09:53:09 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 09:53:09 +0800
Message-ID: <316af4d4-2016-4236-a349-e70ed1501476@huawei.com>
Date: Tue, 12 Aug 2025 09:53:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/22] cfgfile: fix section count with no name
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, Allain Legacy
 <allain.legacy@windriver.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-21-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-21-david.marchand@redhat.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/23/2025 9:31 PM, David Marchand wrote:
> Passing a NULL to strncmp is incorrect.
> 
>  + ------------------------------------------------------- +
>  + Test Suite : Test Cfgfile Unit Test Suite
>  + ------------------------------------------------------- +
> ../lib/cfgfile/rte_cfgfile.c:475:7: runtime error: null pointer passed as
> 	argument 2, which is declared to never be null
> 
> On the other hand, it seems the intent was to count all sections, so
> skip the whole loop and section name comparisons.
> 
> Fixes: c54e7234bc9e ("test/cfgfile: add basic unit tests")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

