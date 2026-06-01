Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9DCD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8224025F;
	Mon,  1 Jun 2026 10:34:54 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id ED1AD4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:34:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 2602666
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780302892;
 bh=dOHrBC36CGVM2JCE/y9Drj5PIVG23D0v3xaIP9j9G1Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wxTbmp6+XcPYjPtAa4fhZNmTL045r7nEi1alBPEDSRTRMiyrJ8Ocr/oi64wE0Q4bP
 dpVAmLTDt26XpPiePr5wKB2CX8lks0I3/Af51cqRpc0+3BZfpeIJ5zSFo5MPqm8O+1
 /vyitN9C329mGMerEJlxnA9Zgj1EUJf0z1ezQOy8=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 2602666;
 Mon,  1 Jun 2026 11:34:52 +0300 (MSK)
Message-ID: <1047eaf3-f41e-49b9-a4cf-0eb7d46dc6c6@oktetlabs.ru>
Date: Mon, 1 Jun 2026 11:34:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] app/test/mempool_perf: drop constant-values replay
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260529171417.526892-5-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260529171417.526892-5-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/29/26 8:10 PM, Stephen Hemminger wrote:
> The second nested matrix replays each (n_get_bulk == n_put_bulk)
> point with use_constant_values=1 to exercise the compile-time
> constant bulk-size paths in test_loop().  This roughly doubles the
> work for the get/put diagonal at every n_keep without adding new
> signal: the cycles/op result for a constant bulk is interesting in
> isolated inlining studies, not in routine regression sweeps.
> 
> Drop the replay.  The use_constant_values switch and its branches
> in test_loop() are retained for now since they are exercised by
> hand in any local benchmarking.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

As far as I can see you delete the only place where use_constant_values
is set to 1. It looks suspicious and basically preserves dead code.
Since Morten added the code, the patch should wait for his approval.

> ---
>   app/test/test_mempool_perf.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
> index 19591ad0c9..dd2f0bbaca 100644
> --- a/app/test/test_mempool_perf.c
> +++ b/app/test/test_mempool_perf.c
> @@ -423,14 +423,6 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
>   				ret = launch_cores(mp, cores);
>   				if (ret < 0)
>   					return -1;
> -
> -				/* replay test with constant values */
> -				if (n_get_bulk == n_put_bulk) {
> -					use_constant_values = 1;
> -					ret = launch_cores(mp, cores);
> -					if (ret < 0)
> -						return -1;
> -				}
>   			}
>   		}
>   	}

