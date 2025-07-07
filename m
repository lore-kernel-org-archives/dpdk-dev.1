Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54CC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 06:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C1740287;
	Mon,  7 Jul 2025 08:42:32 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 70F284025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 08:42:31 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bbF0p1LkHz14Lr5;
 Mon,  7 Jul 2025 14:37:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D34CF140202;
 Mon,  7 Jul 2025 14:42:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Jul 2025 14:42:28 +0800
Message-ID: <1c5eeb89-7680-479e-bc90-0b1a46ce8377@huawei.com>
Date: Mon, 7 Jul 2025 14:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/argparse: change initialization to workaround LTO
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250701154202.237442-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250701154202.237442-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 2025/7/1 23:41, Stephen Hemminger wrote:
> When compiled with Link Time Optimization, the existing code
> generated an error, because the compiler was unable to intuit
> that there was space in the flexible array.
> 
> In function ‘test_argparse_copy’,
>     inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
>     inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
> ../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
>    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> 
> Initializing a structure with flexible array is special case
> and compiler expands the structure to fit. But inside the copy
> function it no longer knew that.
> 
> The workaround is to put the copy inside the same function
> and use structure assignment. Also macro should be upper case.
> 
> Fixes: 6c5c6571601c ("argparse: verify argument config")
> Cc: fengchengwen@huawei.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

