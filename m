Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD45BCED240
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 02:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A236F4027D;
	Tue, 18 Nov 2025 03:40:28 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 90E0B4026A
 for <dev@dpdk.org>; Tue, 18 Nov 2025 03:40:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=n3s/6Lf6WCqQoUQvjpYmlaKaBVyx5NacF6An0a4zhls=;
 b=Ull+pt4HhpqHYWMF61u24n4tV8KHP++gLYEbzl+4rmPSfK2LY9dZwLZJb3TA49WOCnK7TpBgd
 4ycioubiL03ZXYeavRCnu2VHHcYHwy+bX26D+tbmIRiuFNVN1gcLQFNfDXWXBKLSvrd7D9lb/Wb
 lenW4PSbm3+Abzp2JfGMtyY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d9TM56DCBzRhrF;
 Tue, 18 Nov 2025 10:38:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 730701402C1;
 Tue, 18 Nov 2025 10:40:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 10:40:23 +0800
Message-ID: <b136ee47-f917-422f-a162-d79f6095b68a@huawei.com>
Date: Tue, 18 Nov 2025 10:40:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] test: use unit test runner for eal flags
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Tyler Retzlaff <roretzla@linux.microsoft.com>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
 <20251117175332.14014-4-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251117175332.14014-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 11/18/2025 1:52 AM, Stephen Hemminger wrote:
> Make the sub tests in eal flags suite into a group
> so that they are not individual tests.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_eal_flags.c | 46 +++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index c2e6c00edb..263f26d037 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -777,7 +777,7 @@ static int
>  test_no_hpet_flag(void)
>  {
>  #ifdef RTE_EXEC_ENV_FREEBSD
> -	return 0;
> +	return TEST_SKIPPED;
>  #else
>  	const char *prefix = get_file_prefix();
>  	if (prefix == NULL)
> @@ -796,8 +796,8 @@ test_no_hpet_flag(void)
>  		printf("Error - process did not run ok without --no-hpet flag\n");
>  		return -1;
>  	}
> -#
>  	return 0;
> +#endif
>  }
>  
>  /*
> @@ -866,7 +866,7 @@ test_no_huge_flag(void)
>  		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
>  		return -1;
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
> @@ -1208,7 +1208,7 @@ test_file_prefix(void)
>  	char prefix[PATH_MAX] = "";
>  
>  #ifdef RTE_EXEC_ENV_FREEBSD
> -	return 0;
> +	return TEST_SKIPPED;
>  #else
>  	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
>  		printf("Error - unable to get current prefix!\n");
> @@ -1650,15 +1650,29 @@ test_memory_flags(void)
>  
>  #endif /* !RTE_EXEC_ENV_WINDOWS */
>  
> -REGISTER_FAST_TEST(eal_flags_c_opt_autotest, false, false, test_missing_c_flag);
> -REGISTER_FAST_TEST(eal_flags_main_opt_autotest, false, false, test_main_lcore_flag);
> -REGISTER_FAST_TEST(eal_flags_n_opt_autotest, false, false, test_invalid_n_flag);
> -REGISTER_FAST_TEST(eal_flags_hpet_autotest, false, false, test_no_hpet_flag);
> -REGISTER_FAST_TEST(eal_flags_no_huge_autotest, false, false, test_no_huge_flag);
> -REGISTER_FAST_TEST(eal_flags_a_opt_autotest, false, false, test_allow_flag);
> -REGISTER_FAST_TEST(eal_flags_b_opt_autotest, false, false, test_invalid_b_flag);
> -REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, false, false, test_invalid_vdev_flag);
> -REGISTER_FAST_TEST(eal_flags_r_opt_autotest, false, false, test_invalid_r_flag);
> -REGISTER_FAST_TEST(eal_flags_mem_autotest, false, false, test_memory_flags);
> -REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, false, false, test_file_prefix);
> -REGISTER_FAST_TEST(eal_flags_misc_autotest, false, false, test_misc_flags);
> +static struct unit_test_suite eal_flags_test_suite = {
> +	.suite_name = "EAL flags unit test suite",
> +	.unit_test_cases = {
> +		TEST_CASE(test_missing_c_flag),
> +		TEST_CASE(test_main_lcore_flag),
> +		TEST_CASE(test_invalid_n_flag),
> +		TEST_CASE(test_no_hpet_flag),
> +		TEST_CASE(test_no_huge_flag),
> +		TEST_CASE(test_allow_flag),
> +		TEST_CASE(test_invalid_b_flag),
> +		TEST_CASE(test_invalid_vdev_flag),
> +		TEST_CASE(test_invalid_r_flag),
> +		TEST_CASE(test_memory_flags),
> +		TEST_CASE(test_file_prefix),
> +		TEST_CASE(test_misc_flags),
> +		TEST_CASES_END()

The judgement (whether supported this test) and implement is located in the same function,
Suggest split them to different subfunction:

static int
check_missing_runable(void)
{
#ifdef RTE_EXEC_ENV_WINDOWS
	return TEST_SKIPPED;
#else
	return 0;
#endif
}

static struct unit_test_suite eal_flags_test_suite = {
	.suite_name = "EAL flags unit test suite",
	.unit_test_cases = {
		TEST_CASE_NAMED_ST("missing_c_flag", check_missing_runable, NULL, test_missing_c_flag),
		...

In this file, we coud sort judgement to several case:
1. windows don't support
2. freebsd don't support

Note: this impl requirement all code compile-able in windows.

> +	}
> +};
> +
> +static int
> +test_eal_flags(void)
> +{
> +	return unit_test_suite_runner(&eal_flags_test_suite);
> +}
> +
> +REGISTER_FAST_TEST(eal_flags_autotest, false, false, test_eal_flags);

