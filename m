Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB34C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:29:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6109240272;
	Mon, 14 Sep 2026 13:29:28 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id E7DE140144
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1789385366;
 bh=uvE3DrtL5nqMX0E/iZCVfBwsWHWa15XTEDrqhwUrJBg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uUIxKY0NplyiTydcKnaeksM25aDgDVZQ5xhDb39UZ+Gfjq18xMCW9PhAYq+uu5VQu
 CkbBkdrN3KBJsucKKdV1JcLFs/VmjYiMkgrspUwZeZIg2dw05/ijlTkXLSoJd1N+N7
 wFw4OXB+8SZ8CA7coslkHLfRLmfBdtqbTNb6Nn1h3R+UtQpRR+9IkIfDypV0iBxDJd
 Z0UbnL7TuDfTeWG0t6Y/Z94v7DceA6Qa0K9fHL4Hay6uZyoNi2qGQtyZ2JRDcL8tTm
 Z3EKqX/GyWkG7hzB+cWEfuIMQeGtj788sDVcPraHWZRYLAuJlw6k9sw4AsYQls2ADC
 ryOwGCsakVMZA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 89F2A8DBC
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1789385366;
 bh=uvE3DrtL5nqMX0E/iZCVfBwsWHWa15XTEDrqhwUrJBg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uUIxKY0NplyiTydcKnaeksM25aDgDVZQ5xhDb39UZ+Gfjq18xMCW9PhAYq+uu5VQu
 CkbBkdrN3KBJsucKKdV1JcLFs/VmjYiMkgrspUwZeZIg2dw05/ijlTkXLSoJd1N+N7
 wFw4OXB+8SZ8CA7coslkHLfRLmfBdtqbTNb6Nn1h3R+UtQpRR+9IkIfDypV0iBxDJd
 Z0UbnL7TuDfTeWG0t6Y/Z94v7DceA6Qa0K9fHL4Hay6uZyoNi2qGQtyZ2JRDcL8tTm
 Z3EKqX/GyWkG7hzB+cWEfuIMQeGtj788sDVcPraHWZRYLAuJlw6k9sw4AsYQls2ADC
 ryOwGCsakVMZA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 6BBBB8E9C; Mon, 14 Sep 2026 13:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1789385364;
 bh=uvE3DrtL5nqMX0E/iZCVfBwsWHWa15XTEDrqhwUrJBg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=icW4TLoJCh4ejS8iN3cprhytsql3O0SHzKyBRojsHE35sIbbqcYs7tWoOZHS36kch
 6v5PN3fMdM+IO/a+Xf3tGnBnQgOl+eqMWKtEXIrlQXRH2O7DhcsWIWWEv3DSYe3/M0
 TfsYaUDJo3T1EA8CBZfhaWoHfFsVXza50nV947Pa1KmFKwFWdSlRSbaI2KcONKM6Np
 VTvkHzQPQTLFPP6oCuMZcJArRF4hTOtOCUOLJtaXjRBAO8ODuO/aqdip2NcpfMLCSo
 +SJdnm7gM20F3dIVeFw+JLrI/LO+M/zR0kfpjsKxkw2dLDhsfcbLlpgrDYvQ9vnIBd
 htvOtVvpJuF1Q==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 3894B8E9A;
 Mon, 14 Sep 2026 13:29:23 +0200 (CEST)
Message-ID: <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
Date: Mon, 14 Sep 2026 13:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] eal: allow setting random number generator seed
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
 <20260912161744.201627-1-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260912161744.201627-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Den 2026-09-12 kl. 18:16, skrev Stephen Hemminger:
> Many performance tests use rte_rand() and the random number
> can perturb the results. Add an ability to override the automatic
> random seed on DPDK startup.

There is a way to seed the PRNG already, rte_srand(). Why the tests 
can't use this?

Provided the test results depend on something that use the PRNG before 
the test driver has had the opportunity to call rte_srand(), controlling 
the *initial* seed may be required.

I don't think this feature should be controlled by an environment 
variable. There is no precedent for that. If this functionality is 
deemed useful, it should be an EAL command line option, it seems to me.

> 
> This is not a security problem since rte_rand() is documented
> as not being cryptographically secure.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v2 - fix header inclusion
>     - add docbook comment
> 
>   lib/eal/common/rte_random.c  | 14 +++++++++++++-
>   lib/eal/include/rte_random.h |  8 +++++---
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
> index 576a32a46c..3cc0e3ec5f 100644
> --- a/lib/eal/common/rte_random.c
> +++ b/lib/eal/common/rte_random.c
> @@ -8,6 +8,7 @@
>   #endif
>   #endif
>   #include <unistd.h>
> +#include <stdlib.h>
>   
>   #include <rte_bitops.h>
>   #include <rte_branch_prediction.h>
> @@ -247,7 +248,18 @@ eal_rand_init(void)
>   
>   	RTE_LCORE_VAR_ALLOC(rand_state);
>   
> -	seed = __rte_random_initial_seed();
> +	const char *env = getenv("DPDK_RANDOM_SEED");
> +	if (env != NULL && *env != '\0') {
> +		char *end;
> +
> +		errno = 0;
> +		seed = strtoull(env, &end, 0);
> +		if (errno != 0 || *end != '\0')
> +			rte_exit(EXIT_FAILURE,
> +				 "invalid DPDK_RANDOM_SEED: %s\n", env);

Is rte_exit() the way to deal with errors here? Not to be used in DPDK 
libraries, if I recall correctly.

I would think logging an error would suffice. Or rte_eal_init_alert().

> +	} else {
> +		seed = __rte_random_initial_seed();
> +	}
>   
>   	rte_srand(seed);
>   }
> diff --git a/lib/eal/include/rte_random.h b/lib/eal/include/rte_random.h
> index 15cbe6215a..bdd4001e78 100644
> --- a/lib/eal/include/rte_random.h
> +++ b/lib/eal/include/rte_random.h
> @@ -20,9 +20,11 @@ extern "C" {
>   /**
>    * Seed the pseudo-random generator.
>    *
> - * The generator is automatically seeded by the EAL init with a timer
> - * value. It may need to be re-seeded by the user with a real random
> - * value.
> + * The generator is automatically seeded by the EAL init with
> + * a system provided random entropy source. But for testing
> + * it can be useful to force a repeatable starting point by
> + * setting the initial seed. This can be done by setting
> + * the `DPDK_RANDOM_SEED` environment variable.
>    *
>    * This function is not multi-thread safe in regards to other
>    * rte_srand() calls, nor is it in relation to concurrent rte_rand(),

