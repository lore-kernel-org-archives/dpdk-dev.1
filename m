Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD04CCFA13
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:48:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0762740268;
	Sun,  9 Nov 2025 15:48:40 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 6F715400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 15:48:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 9DFCC88
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762699716;
 bh=ddDmgkNvxjC/5OOinqS9tnYR7YQZHUg+BvywHgBcj5o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T7+XaucCBrvH3UJYCTj30zfP3uvcHdZYox1AigUt2NPzEhHGS7JAsReb33+rcyXW4
 5C7PbpyVgW70VVHwLq3MSG6tnMWYnZB23Kcvc3scNRchIeL6ZIVDg/r4BaeNjHOXrg
 bcw520VYfP+nd4MsV8OMfDRYJgjhLmq5utc33CPA=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 9DFCC88;
 Sun,  9 Nov 2025 17:48:35 +0300 (MSK)
Message-ID: <bb6cc05d-29b0-4439-bac6-fabdee315804@oktetlabs.ru>
Date: Sun, 9 Nov 2025 17:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/44] lib: remove use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 David Hunt <david.hunt@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
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
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-12-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20251103164915.101713-12-stephen@networkplumber.org>
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

On 11/3/25 19:47, Stephen Hemminger wrote:
> Use the new rte_bsd_queue.h where needed but most files already
> get the needed macros from rte_tailq.h
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

[...]

> diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
> index 1021ede0c2..bf8e870151 100644
> --- a/lib/mempool/rte_mempool.c
> +++ b/lib/mempool/rte_mempool.c
> @@ -12,7 +12,6 @@
>   #include <unistd.h>
>   #include <inttypes.h>
>   #include <errno.h>
> -#include <sys/queue.h>
>   
>   #include <eal_export.h>
>   #include <rte_common.h>

I'm wondering why rte_bsd_queue.h is not added here instead of
sys/queue.h since the code definitely uses corresponding macros.
Is it OK to rely on indirect include via other headers?

