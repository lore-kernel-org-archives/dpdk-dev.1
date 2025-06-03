Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 08:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 230B44028E;
	Tue,  3 Jun 2025 10:44:49 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 0388F4025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 10:44:48 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bBPNq3vhRz13L9Q
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:42:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 95835180482
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:44:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 16:44:43 +0800
Message-ID: <b58d1963-c4ca-4049-95d6-11293dc85e67@huawei.com>
Date: Tue, 3 Jun 2025 16:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] argparse: make argparse EAL-args compatible
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250527092113.903910-3-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250527092113.903910-3-bruce.richardson@intel.com>
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

On 2025/5/27 17:21, Bruce Richardson wrote:
> The argparse library was missing two key features which made it
> unsuitable for use by EAL or any program wanting similar behaviour.
> 
> 1. It didn't stop parsing arguments when it hit a "--" character
> 2. It never returned the number of arguments parsed
> 
> Fix both these issues - the latter is a change to the ABI, since we now
> return >= 0 rather than == 0 on success. However, the ABI is still
> experimental so we can make exactly these sorts of tweaks to it.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/test_argparse.c               | 46 +++++++++++++-------------
>  doc/guides/rel_notes/release_25_07.rst |  9 +++++
>  lib/argparse/rte_argparse.c            | 12 +++++--
>  lib/argparse/rte_argparse.h            |  3 +-
>  4 files changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> index 6b0d1524b5..a907fbe53f 100644
> --- a/app/test/test_argparse.c
> +++ b/app/test/test_argparse.c
> @@ -360,14 +360,14 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
>  	argv[0] = test_strdup(obj->prog_name);
>  	argv[1] = test_strdup("--test-long");
>  	ret = rte_argparse_parse(obj, 2, argv);
> -	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
> +	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");

Please compared with specific number, eg. TEST_ASSERT(ret == 2, "xxx");

...

>  
> @@ -780,7 +780,7 @@ test_argparse_parse_type(void)
>  	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
>  	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
>  	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
> -	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
> +	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");

No need for rte_argparse_parse_type() API, this API still return 0 if success.

...

> diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
> index 332184302e..8cdb3195cb 100644
> --- a/lib/argparse/rte_argparse.h
> +++ b/lib/argparse/rte_argparse.h
> @@ -183,7 +183,8 @@ struct rte_argparse {
>   *   Array of parameters points.
>   *
>   * @return
> - *   0 on success. Otherwise negative value is returned.
> + *   number of arguments parsed (>= 0) on success.
> + *   Otherwise negative error code is returned.

Please add note for "stops processing arguments when a ``--`` argument is encountered".

>   */
>  __rte_experimental
>  int rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv);

