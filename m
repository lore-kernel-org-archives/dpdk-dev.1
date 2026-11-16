Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD74606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sctEQSn2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4224240150;
	Mon, 16 Nov 2026 02:18:05 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTPS id C76B7400EF;
 Mon, 16 Nov 2026 02:18:03 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=2AenfQOqrawKAhVhYE9pDNX580Rk8zklf1HTaOoNMSw=;
 b=sctEQSn2KgoKwY3afTe61wlG6PVHIpUBHilPfyyW+Vo51W7+uPy33QUn3Ns0x8vr0EEgu0bro
 nANDe0IyRcLYZIfYeMo2sFTkhygLQVcfgfMA6bA+R1wYE8z5s/A93fcgERdnqwWxKptl6CPB2T+
 1fjfVYKL2q0ztT1T9lwzVTA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jSVNL05k5z12LD3;
 Mon, 16 Nov 2026 09:17:54 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 672252011D;
 Mon, 16 Nov 2026 09:17:46 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 16 Nov 2026 09:17:45 +0800
Message-ID: <829a9343-bc03-47a8-a039-3447f364f62e@huawei.com>
Date: Mon, 16 Nov 2026 09:17:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] argparse: fix null dereference in corelist parsing
To: Artem Novikov <naa@amicon.ru>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <rrv@amicon.ru>, David Marchand <david.marchand@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>
References: <20261112153039.291045-1-naa@amicon.ru>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261112153039.291045-1-naa@amicon.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Artem,

I prefer add verify in rte_argparse_parse_type(), because str=null or val=null is not allowed in this
function according the definition of function.

@@ -971,6 +971,12 @@ rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type,
                .val_set = NULL,
                .value_type = val_type,
        };
+
+       if (str == NULL || val == NULL) {
+               ARGPARSE_LOG(ERRM "argument and value should both valid!");
+               return -EINVAL;
+       }
+
        if (val_type == RTE_ARGPARSE_VALUE_TYPE_NONE) {
                ARGPARSE_LOG(ERR, "argument %s doesn't have value-type!", str);
                return -EINVAL;

Thanks,
Chengwen

On 11/12/2026 11:30 PM, Artem Novikov wrote:
> Parsing a corelist without a value dereferences val_set even when no
> default is configured. This also occurs with
> rte_argparse_parse_type(NULL, RTE_ARGPARSE_VALUE_TYPE_CORELIST, &cpus).
> 
> Return -EINVAL when the default is missing. Add regression tests for
> both parsing APIs and copying a configured default.
> 
> Fixes: d78103fb9488 ("argparse: support core lists")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
>  app/test/test_argparse.c    | 24 ++++++++++++++++++++++--
>  lib/argparse/rte_argparse.c |  2 ++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> index fdc6dd113c3ce876f1e0928e5d6d8f94e0bc8752..ffa9144ae8d19689c22a07b0d9ab13dc811deedc 100644
> --- a/app/test/test_argparse.c
> +++ b/app/test/test_argparse.c
> @@ -501,9 +501,10 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
>  }
>  
>  static int
> -test_argparse_opt_parse_corelist_of_required_val(void)
> +test_argparse_opt_parse_corelist(void)
>  {
>  	struct rte_argparse *obj;
> +	rte_cpuset_t default_cpuset;
>  	rte_cpuset_t val_cpuset;
>  	char *argv[3];
>  	int ret;
> @@ -531,6 +532,21 @@ test_argparse_opt_parse_corelist_of_required_val(void)
>  	TEST_ASSERT(CPU_ISSET(5, &val_cpuset), "Core 5 should be set in corelist!");
>  	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in corelist!");
>  
> +	CPU_ZERO(&default_cpuset);
> +	CPU_SET(2, &default_cpuset);
> +	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
> +	obj->args[0].val_set = &default_cpuset;
> +	ret = rte_argparse_parse(obj, 2, argv);
> +	TEST_ASSERT(ret == 2, "Default corelist should be accepted, got %d", ret);
> +	TEST_ASSERT(memcmp(&val_cpuset, &default_cpuset, sizeof(val_cpuset)) == 0,
> +			"Default corelist was not copied");
> +
> +	obj->args[0].val_set = NULL;
> +	ret = rte_argparse_parse(obj, 2, argv);
> +	TEST_ASSERT(ret == -EINVAL, "Missing default should return -EINVAL, got %d", ret);
> +	TEST_ASSERT(memcmp(&val_cpuset, &default_cpuset, sizeof(val_cpuset)) == 0,
> +			"Rejected corelist changed the saved value");
> +
>  	return 0;
>  }
>  
> @@ -966,6 +982,10 @@ test_argparse_parse_type_corelist(void)
>  			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
>  	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (out of range) should have failed!");
>  
> +	ret = rte_argparse_parse_type(NULL, RTE_ARGPARSE_VALUE_TYPE_CORELIST,
> +			&val_cpuset);
> +	TEST_ASSERT(ret == -EINVAL, "NULL corelist should return -EINVAL, got %d", ret);
> +
>  	return 0;
>  }
>  
> @@ -1588,7 +1608,7 @@ static struct unit_test_suite argparse_test_suite = {
>  		TEST_CASE(test_argparse_opt_autosave_parse_int_of_no_val),
>  		TEST_CASE(test_argparse_opt_autosave_parse_int_of_required_val),
>  		TEST_CASE(test_argparse_opt_autosave_parse_int_of_optional_val),
> -		TEST_CASE(test_argparse_opt_parse_corelist_of_required_val),
> +		TEST_CASE(test_argparse_opt_parse_corelist),
>  		TEST_CASE(test_argparse_opt_callback_parse_int_of_no_val),
>  		TEST_CASE(test_argparse_opt_callback_parse_int_of_required_val),
>  		TEST_CASE(test_argparse_opt_callback_parse_int_of_optional_val),
> diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
> index 88c3e7740c715ae6c40f6bf44787ea67a1e96c8b..e407dbe31253362add7a537d4caccf4b97c5797e 100644
> --- a/lib/argparse/rte_argparse.c
> +++ b/lib/argparse/rte_argparse.c
> @@ -576,6 +576,8 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
>  	int min = -1;
>  
>  	if (value == NULL) {
> +		if (arg->val_set == NULL)
> +			return -EINVAL;
>  		*cpuset = *(rte_cpuset_t *)arg->val_set;
>  		return 0;
>  	}

