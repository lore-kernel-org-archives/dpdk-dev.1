Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D939C282C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 22:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51D9440156;
	Mon,  3 Mar 2025 23:29:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C5B1340041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 23:29:17 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F3A012110488; Mon,  3 Mar 2025 14:29:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3A012110488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741040957;
 bh=wcqMf8OQ7htP+5scf0x9O7oVRUQNraI3pZ4+63KeGAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B+FXJV1o1E6lm++uHompvIKBX1rQFLpsyomZ6gG4R1ucMIbgSXpTRSlK8qolNB3xE
 8b/k+V0ncdcrwFxT1jdot/Sqi23aZBSiyjBvIlfUj5XcX5gQUhkgzBmVLYYd/d2rw/
 jd2Fsk+y5dFKeo/o4LRJopEZYL+JGcZ/Yv6rpJi8=
Date: Mon, 3 Mar 2025 14:29:16 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 2/2] app/test: add test_init_m128i using compiler intrinsic
Message-ID: <20250303222916.GB30522@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1732748278-14796-2-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1732748278-14796-2-git-send-email-andremue@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Nov 27, 2024 at 02:57:58PM -0800, Andre Muezerie wrote:
> This test initializes an __m128i data type using the old
> non-portable way used until now and the more portable way
> using compiler intrinsics. The test ensures the resulting
> values after initialization match.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/test/test_thash.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> index b9c6e9118e..c121b1f43f 100644
> --- a/app/test/test_thash.c
> +++ b/app/test/test_thash.c
> @@ -1030,6 +1030,38 @@ test_keygen(void)
>  	return TEST_SUCCESS;
>  }
>  
> +#ifdef RTE_ARCH_X86
> +#ifndef RTE_TOOLCHAIN_MSVC
> +static int
> +test_init_m128i(void)
> +{
> +	/* When initializing __m128i with two constant values like below
> +	 * MSVC issues warning C4305:
> +	 *     'initializing': truncation from 'unsigned __int64' to 'char'
> +	 */
> +	static const __m128i a = {
> +			0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
> +
> +	/* Using compiler intrinsics to initialize __m128i is therefore
> +	 * preferred, like below
> +	 */
> +	static const uint8_t b_bytes[] = {
> +			0x03, 0x02, 0x01, 0x00, 0x07, 0x06, 0x05, 0x04,
> +			0x0B, 0x0A, 0x09, 0x08, 0x0F, 0x0E, 0x0D, 0x0C};
> +	const __m128i b =
> +			_mm_loadu_si128((const __m128i *)&b_bytes);
> +
> +	if (memcmp(&a, &b, sizeof(a)) != 0) {
> +		printf("Same value was expected when initializing data "
> +				"type using compiler intrinsic\n");
> +		return -1;
> +	}
> +
> +	return TEST_SUCCESS;
> +}
> +#endif
> +#endif
> +
>  static struct unit_test_suite thash_tests = {
>  	.suite_name = "thash autotest",
>  	.setup = NULL,
> @@ -1052,6 +1084,11 @@ static struct unit_test_suite thash_tests = {
>  	TEST_CASE(test_adjust_tuple),
>  	TEST_CASE(test_adjust_tuple_mult_reta),
>  	TEST_CASE(test_keygen),
> +#ifdef RTE_ARCH_X86
> +#ifndef RTE_TOOLCHAIN_MSVC
> +	TEST_CASE(test_init_m128i),
> +#endif
> +#endif
>  	TEST_CASES_END()
>  	}
>  };
> -- 
> 2.34.1

Could someone please review this patch and let me know if there are changes to be made?
I have other patches depending on this.

Thanks,
Andre Muezerie

