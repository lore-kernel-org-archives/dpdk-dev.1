Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B8C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 16:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8122C427E0;
	Thu, 10 Sep 2026 18:51:24 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6C13640274;
 Thu, 10 Sep 2026 18:51:23 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FD50200049;
 Thu, 10 Sep 2026 18:51:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDA6E200048;
 Thu, 10 Sep 2026 18:51:22 +0200 (CEST)
Received: from [92.120.147.87] (wsv03115.swis.in-blr01.nxp.com [92.120.147.87])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ED9EA1800068;
 Fri, 11 Sep 2026 00:51:21 +0800 (+08)
Message-ID: <488abb0e-d7bd-451c-856a-336759bea5b7@nxp.com>
Date: Thu, 10 Sep 2026 22:21:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] bus/fslmc: fix build of qbman debug code
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Youri Querry <youri.querry_1@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
 <20260904191652.2399074-2-stephen@networkplumber.org>
Content-Language: en-US
From: hemant.agrawal@nxp.com
In-Reply-To: <20260904191652.2399074-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 05/09/2026 00:42, Stephen Hemminger wrote:
> QBMAN_RESPONSE_VERB_MASK is a private define in qbman_portal.c, not
> in the qbman_portal.h header included by qbman_debug.c.
> The debug file has therefore never compiled since it was added;
> it fails with seven "undeclared identifier" errors when
> RTE_LIBRTE_DPAA2_DEBUG_BUS is defined.
>
> Define the mask locally, next to the other management command codes
> that qbman_debug.c already defines for itself.
>
> Fixes: 64f131a82fbe ("bus/fslmc: add qbman debug")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

> ---
>   drivers/bus/fslmc/qbman/qbman_debug.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bus/fslmc/qbman/qbman_debug.c b/drivers/bus/fslmc/qbman/qbman_debug.c
> index f13168dce3..1c5c62addb 100644
> --- a/drivers/bus/fslmc/qbman/qbman_debug.c
> +++ b/drivers/bus/fslmc/qbman/qbman_debug.c
> @@ -9,6 +9,9 @@
>   
>   #include <eal_export.h>
>   
> +/* Mask used to extract the response verb from a management command result */
> +#define QBMAN_RESPONSE_VERB_MASK  0x7f
> +
>   /* QBMan portal management command code */
>   #define QBMAN_BP_QUERY            0x32
>   #define QBMAN_FQ_QUERY            0x44
