Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA04C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 14:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2307740650;
	Mon, 31 Mar 2025 16:48:41 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 39352402DF
 for <dev@dpdk.org>; Mon, 31 Mar 2025 16:48:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 4786941
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743432518;
 bh=A4bnjg+iCjiCCagWwP9b4UTzSZTn5K00yo76NM+oZ5w=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=hzLgsH68HzO5DJXeH05SyT9ujw7emuW2YruAQ7+4Kb/V/Wy+Qc2/+7Lk97sSCO1MY
 Y4bRLi3CLmcHzgpvt1RqlHVEZEjtyumOn+ZYYnmva0xNECl+H3Uz/MEa8J6cArfrAj
 07YH4pPylKMzbGyn1NDb8L0eEQT9t+ktJijxBiWc=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 4786941;
 Mon, 31 Mar 2025 17:48:38 +0300 (MSK)
Message-ID: <f49fb9ed-0e34-4752-960a-f2b26bd14b89@oktetlabs.ru>
Date: Mon, 31 Mar 2025 17:48:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] mempool perf test: test random bulk sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250331100343.213430-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250331100343.213430-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/31/25 13:03, Morten Brørup wrote:
> Bulk requests to get or put objects in a mempool often vary in size.
> A series of tests with pseudo random request sizes, to mitigate the
> benefits of the CPU's dynamic branch predictor, was added.
> 
> Also, various other minor changes:
> - Improved the output formatting for readability.
> - Added test for the "default" mempool with cache.
> - Skip the tests for the "default" mempool, if it happens to use the same
>    driver (i.e. operations) as already tested.
> - Replaced bare use of "unsigned" with "unsigned int",
>    to make checkpatches happy.
> 
> v2:
> * Split patch into individual patches. (Andrew Rybchenko)

Thanks Morten, LGTM except a couple of nits

> 
> Morten Brørup (4):
>    mempool perf test: replace bare unsigned with unsigned int
>    mempool perf test: test default mempool with cache
>    mempool perf test: improve output readability
>    mempool perf test: test random bulk sizes
> 
>   app/test/test_mempool_perf.c | 222 +++++++++++++++++++++++++++--------
>   1 file changed, 173 insertions(+), 49 deletions(-)
> 

