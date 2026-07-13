Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5CDC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 03:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4C240298;
	Mon, 13 Jul 2026 05:57:50 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id EFFBD4028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 05:57:48 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DO/W+aN0fdC0O8Rc4JsRFL/Rin6MmFjwMlAW8OvL8kE=;
 b=DGTYNZ+x8NnS9S6exj9hvl353leV5lNbcWR+IdbNs3j4yhlOBg5tPSg2QGa3B/XlFtIgoAaOt
 G49KJIDIYkGU8K/8CQTsyhFR4tDUrI7/l8pokoXWBN3gvWwC481sgMaIbYSMhhJRqL3hG+XvZeY
 VAkzoObe0CcwKkRHeJ8VJlo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gz7hR16jqz1T4KW;
 Mon, 13 Jul 2026 11:48:39 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B9BD4056D;
 Mon, 13 Jul 2026 11:57:46 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 13 Jul
 2026 11:57:46 +0800
Message-ID: <076a65ad-38eb-42dd-8ad9-6bd3796c82f9@huawei.com>
Date: Mon, 13 Jul 2026 11:57:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power/intel_uncore: reduce log level for dependency
 missing
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
References: <20260512013047.375535-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260512013047.375535-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Kindly ping for review.

On 5/12/2026 9:30 AM, Huisong Li wrote:
> When run dpdk-l3fwd with '-u' on non-X86 platform, user would
> happen a noisy print as the following:
> "POWER: Uncore frequency management not supported/enabled on this
> kernel. Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel
> x86 with linux kernel >= 5.6".
>
> The root cause is that intel_uncore driver's .init() will be called
> on any platform when use automatic detection mode. The function in
> intel_uncore driver will print above log on non-X86 platform.
>
> But the existing uncore core cannot solve this problem unless break
> ABI to add new callback. So reduce its log level to avoid this
> incorrect prompt.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/power/intel_uncore/intel_uncore.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/intel_uncore/intel_uncore.c b/drivers/power/intel_uncore/intel_uncore.c
> index 6759ea1445..ebca395075 100644
> --- a/drivers/power/intel_uncore/intel_uncore.c
> +++ b/drivers/power/intel_uncore/intel_uncore.c
> @@ -419,7 +419,7 @@ power_intel_uncore_get_num_pkgs(void)
>   
>   	d = opendir(INTEL_UNCORE_FREQUENCY_DIR);
>   	if (d == NULL) {
> -		POWER_LOG(ERR,
> +		POWER_LOG(DEBUG,
>   		"Uncore frequency management not supported/enabled on this kernel. "
>   		"Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel x86 with linux kernel"
>   		" >= 5.6");
> @@ -457,7 +457,7 @@ power_intel_uncore_get_num_dies(unsigned int pkg)
>   
>   	d = opendir(INTEL_UNCORE_FREQUENCY_DIR);
>   	if (d == NULL) {
> -		POWER_LOG(ERR,
> +		POWER_LOG(DEBUG,
>   		"Uncore frequency management not supported/enabled on this kernel. "
>   		"Please enable CONFIG_INTEL_UNCORE_FREQ_CONTROL if on Intel x86 with linux kernel"
>   		" >= 5.6");
