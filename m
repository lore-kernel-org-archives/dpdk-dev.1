Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC97BCA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1110F4025E;
	Mon, 25 Aug 2025 09:05:29 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9534025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 09:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 7831144
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1756105526;
 bh=m1/4+qwuGTDValP9Qee9ly8825O/hVqH1vEiuWh1Ec4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ftEjrRODx7JjFZYamw9qQimsFszh2XeaPWgkk6viZy+mJCzMf043ztTBiXpEi8E9q
 zfO9qjdLDiAj8eJEhpZKFGA4DGsilccPvC09GhM5nqtoCskUJPt0HRE+1D/Vz/Z09F
 Vl2STF4LhT6uGnwDyWRmAjI+rr8R6uDQYHtHB8TU=
Received: from [192.168.1.42] (unknown [188.170.78.15])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 7831144;
 Mon, 25 Aug 2025 10:05:25 +0300 (MSK)
Message-ID: <1109e6d1-8520-4d90-b586-67ca5f9d2549@oktetlabs.ru>
Date: Mon, 25 Aug 2025 10:05:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/43] lib: remove use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 David Hunt <david.hunt@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
 <20250825034126.12046-12-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250825034126.12046-12-stephen@networkplumber.org>
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

On 8/25/25 06:38, Stephen Hemminger wrote:
> Use the new rte_bsd_queue.h where needed but most files already
> get the needed macros from rte_tailq.h
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

...

> diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
> index 5987c9dee8..9a20033021 100644
> --- a/lib/mbuf/rte_mbuf_dyn.c
> +++ b/lib/mbuf/rte_mbuf_dyn.c
> @@ -3,7 +3,6 @@
>    */
>   
>   #include <stdalign.h>
> -#include <sys/queue.h>

IMHO since rte_tailq.h itself does not provide/implement TAILQ
macros it is not nice to rely on indirect inclusion.
I think it would be better to include rte_bsd_queue.h directly
in the source file (nearby other rte headers).

>   #include <stdint.h>
>   #include <limits.h>
>   
> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 1021ede0c2..bf8e870151 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -12,7 +12,6 @@
>   #include <unistd.h>
>   #include <inttypes.h>
>   #include <errno.h>
> -#include <sys/queue.h>

Same here

>   
>   #include <eal_export.h>
>   #include <rte_common.h>

