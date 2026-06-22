Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1AACD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 13:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8273840150;
	Mon, 22 Jun 2026 15:58:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E87CE40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 15:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782136738; x=1813672738;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1FG4xSt+18SqvyG1DlKBZrvrC/RBNFKQXJyWaQXW+gY=;
 b=egi+ssC/2NzuEmeIs70W3qnxtwiQ9H3+voErHzZTtqFtYX0Yx6TwV9rf
 vevtmvUXx44BThB92kUbZsFxmQeQDQ8MWk7YD3mwhb1Z8KnvBBG9/AzNu
 93IMa/JGZeXngHlKC+8eJrXSQtktIw+EpfdB772BR3EH1dD+h1AVSDTnI
 EkaKpmMzWxo5LU/I94VDO7RTNrt+0tOgevpaM/4sNKiU2PuYmgzc3Xr3I
 4bSR5dKyRyID1ZJnTvOFFSbNGl+583a+hmVtXtv99uUPRUu36VsHepE+N
 cNMKCQ9u4+C1+RTcJq0S5B6Q0pKg8SN0eGI20himNM0qh6IwLWaCD+ZM+ w==;
X-CSE-ConnectionGUID: MJFH7MB0SdmiNJwIQhSJsg==
X-CSE-MsgGUID: dbuyzW21QWSS5xoZaX93uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82735209"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82735209"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:58:57 -0700
X-CSE-ConnectionGUID: YB467A3mSGu5sATKtG69tQ==
X-CSE-MsgGUID: uQ2puk35SHySlI1xRLvbGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="273309939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:58:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 06:58:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 06:58:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 06:58:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0NL+p8Cnk6OZez2sw/xFC6lwCWt3lFfMj00Z8S2NRZhcwRgVGOg1Q0oziSA1NLYNxdpYQkihnez4i2wHv3EZ5tomox6unzRNXGSEXo7cSv3Im4CbbYROV0AWYnZBYAN7XMOS4YG4dT8b2co9EkyrdhJgThh/SFu/SRY+NVfm6CK+fLKMXjqS4ddlVsH5YFNIsF4ciW0F+uG/k7ukL2/ZaCtElskSc/26S6YReQrBfdQV1EdJMHjuCUZiiGf1PIabGp2vsymyghv0psUjS2RdOTM0Agu+a7qy2mFuXCqvTQr1xAu7v58CgcHhkC0sF083CIWaEfFxbYqNZGUGiBZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk2PQcF5+qImC7hQFmvNH1X6+yZt9b0XzofKZD4GBVc=;
 b=bBTlPRFhUxpjtEsxcrK7+piuYxyN1aOHaAoMMX0B6YOU8VsROg2dbu5ZSCA5WGJqj/8XNNAqq8tr4a+vMpOvcoQqbqC+6xKb+nFZ//UukgIOml3atOd8KJX/VgXpM2WaXDmmCULnEU8PTCltzWGKl8necxT1byhnaePOomCkHGdw+9ycLjfQN11B5QP3xFMnl2XW0OCM979uwfniVJi6zlx/7wFPA5Vb9hbSl6qf9of5wX4l7u1UYqFbHzWcUWuG2+y+09EUuT3hiFPdQdFW/ZPa/uM7YlpGs9NoRssOYTK5GrK+EtdgM0mzoF4UzJnMLDBBUzgnhwoFp1OkTa6GRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA3PR11MB9182.namprd11.prod.outlook.com (2603:10b6:208:579::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 13:58:54 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 13:58:53 +0000
Date: Mon, 22 Jun 2026 14:58:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Anoob Joseph <anoobj@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] test/dma: add functions to verify zero and one fill
Message-ID: <ajk_mU1TRhliwW9w@bricha3-mobl1.ger.corp.intel.com>
References: <20260622135208.87697-1-ktejasree@marvell.com>
 <20260622135208.87697-3-ktejasree@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622135208.87697-3-ktejasree@marvell.com>
X-ClientProxiedBy: DU7P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA3PR11MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7764cf-4402-4a5d-d527-08ded06664ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: pWMpVHEWwsC4PrFVbCD9QnK9aqaEN1gAFz+FqnGep3cwdAGAw+w9M+/UReaUiK25irQdn/zCV7TdIW/fsJkrYl87MGwLY4tuLLNGbuD9rOHKMmLkcT35LbBSjxo9XYaDYNyo87I3HiHaN+qzzxdAMdhQrWycMu5ovFllaYgfVHMKE5NQi7OOUeCcqJ5wL/eeKb6RjCKmCVw1oSRi/A4uN46aPWwb32Hz6+S2jzorkY9Aw1g0LRpztk69tXVgpKvRaTN4guWA5hpyn2U7RH/S6QcxnM2XjEPpXSQ0/ETOyNqA2Ht+q+y4xuJMZp9DIfLsj3SBrgjSFyELbWge0kSc2qam/3uuOt4+XwFUcrArnEl6V+7SFzuE6/WyFe5X3br7l2KlirQLndPWdaQL/2vLMyu6lqWPy/PnRzxOYgRIGCqYMattqBMJLTezUGx0DZuZDPfe5VsxAwX1gVo/4kBznoBe+GGU3Fnh/G8W6SsbmbonfOJ4W72yNs1rDueEbyOMHxPOyQmlwa40mgUFKT1rZwHwPFw/rR7P7w8fIWna/87B3ATiJQDv6UURg1/65E6NulC7zKF89BwhIA7GvRlse/T0wXSPO+j/CzEnzNCp7XPWOCZ2rBGXbA/ggW9dNyrBe6R09MSjA3Sgi+4XWEuMRaJj0CG90zdLGRAcWTnBwsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ce7Ur0FDXB1wbuIo8ftAmsOadMNQ6P0v0NBmwEhSd4Lbu4aWMNnClHjnmnTG?=
 =?us-ascii?Q?i+fu8uZB4yZXhmB2JiWIlhj1qpcvTNJUDzmuw5WtqGiczFW6QWto622B509C?=
 =?us-ascii?Q?UGvZGT+DqpkSfSSMLYSsYzE7TVXkoEJkjXffleE6stCBxufC+/59ZwQN+Szb?=
 =?us-ascii?Q?WxbyLFa8+daGIqE97tzJwvxi1C14eH7vvshBl/pGQbxe8Rb2fEDsfS7c8yjK?=
 =?us-ascii?Q?aFu5qAZlMmBgoNbD7j2eMVc8vngFknxV6BYwG/RBO6G4CKq56k0fvRyQlbyQ?=
 =?us-ascii?Q?apAEUQWS1CRJaNdrdxHzQKwGuT5RJhZ+jvrcHHt9ApyZljOh8CgiXslp1pCu?=
 =?us-ascii?Q?WIRaoA9BNkbPP0Ir3WZmJOj2cKuQpLCh2Bt4y5shs2EoRBCePXOynZu7nv+8?=
 =?us-ascii?Q?tuQaDGINY5KJaya2WkUuA78O9wvosh6swUR8ODVgKfLriwOuvKAZx3YzKdf0?=
 =?us-ascii?Q?elk5HKYdkQJrj9yyAbrps22CAO7qkg/cS8zMV0wk8rbrsZEMn45rtbs7gQ9c?=
 =?us-ascii?Q?gTBZWSWOtukrZw41Its2WUr/jv5/pRODVC4LgOwC10Fb4sV8l/PA1q6RxCp8?=
 =?us-ascii?Q?lBR92zbIlZpomRVc9sUzVgcZBdGhHsLt0Fa4BCxg1+RAfMZtQbijs7fGLV9A?=
 =?us-ascii?Q?YcDt21sdwraXM4ZWwlA6IC36MtV1axcNqnrgnSm4pqgDsUulgdagv62XpBpc?=
 =?us-ascii?Q?3vXkIH2QTU0ktPfcdCWOO/XI3iii+S7yr2fd6djSsNkUq7NqCzON6xayv1xd?=
 =?us-ascii?Q?yDAXn5xW4pgmqmUy3rJakiNXiQEC+qF/ALCcYZjdc65Lvq0fKfMhrbINumqP?=
 =?us-ascii?Q?weS5sLziYLmGsTwhivztIsgsVoKD6buPREwv87RNZXXGR9nun958ubcAbFwn?=
 =?us-ascii?Q?bByJLvGDyOwD9z3MtCye8whbLUCWilOdaN2bAEQHWP70nGb7hVkdby+1m1qC?=
 =?us-ascii?Q?6a66nuYxMFEvam9fIwIPqNAdMlqF/l6zHhpZN/DzUTk7Sb3BbS91u9AZ277n?=
 =?us-ascii?Q?ZdNiTh6Nl5WehQIbWbQwisIGLf1nIC2VspFdxZHSYoOXshyLX5C1xoHTIrSW?=
 =?us-ascii?Q?AF4Tbaca3WWhw/oyx04XbMzZilkiqrNOqVNMKx/+Z6S6QHW/iILkGT0LCtiO?=
 =?us-ascii?Q?BmmIE64yxtwd+nsQ2F36q/dguDA6H7F/Rr/wHFT3YYbv7sZPBmPcPgQfHtiL?=
 =?us-ascii?Q?YAa7oolAwldx8OV3oxIAd69VPHZc2qN/4gmIwh+WJOmjLyyIduqkcdSyA1Me?=
 =?us-ascii?Q?UAoOLLgx6WAfpGMM10/OjTOK9OGxh1uc7z3TY169rMW8N/Qn2U6Be1kdYuA+?=
 =?us-ascii?Q?R5BZecMoGPFsEPVY9DJi2KHl+My43pPGyWAwW3qkOaU7ERcjBvuQavS92GbV?=
 =?us-ascii?Q?I+SsUmm2vE4dVV6WAEvku6Wq5msLJHADy5ms8q3vN8ZRmGESIAZYo56dMCLG?=
 =?us-ascii?Q?xZtx2ub3O1oNVEOBXNPC6s43IhqRdhPVki7/4XH9q+SdbvAFXomJPLoOoLIn?=
 =?us-ascii?Q?RhhgndAGYCDUbvcypw7M7mGo7JlxsTPYT6Y30j1oMvsc5udEIebETmzpkpmz?=
 =?us-ascii?Q?KpgvTXYnvREApi+HR4ftFXzB+x/TCV9DytUqjCvz6plSxGnop8m8gmSTh+NE?=
 =?us-ascii?Q?DA6dZVx78JZ2IGg0ODjZ+vfKB3rjloI7Ni8Udvl1tE0HyLm3BBdVAKAJWn4F?=
 =?us-ascii?Q?xW9BWHIUA9b9vxDPlbY0K7oTbpa85hsGUZUSEppzQc1WNzNyRGPOLMieVdvj?=
 =?us-ascii?Q?zaEqMy3yiDRDSydqZghXHei/e74gr78=3D?=
X-Exchange-RoutingPolicyChecked: gvY/5avploF0MHZQbirSjNhKM4NeZdVPWzuh8/2+OKyvR+vojCPQM1QC2Yh/L9La5/KpdAYlf1gYIML6i9EvvGcmckalbAslsSV+fyTxZgKofH/uB9VO6ZLYEnklhftSKqJABu4LXFzcYFwciAtwmVehOzj7hS/SD70x2IIAAn9hpXbRV7xVEJIgBwsHoC+szN43UAxfmt90mkfQzbNewpBKlqRlgj1qvBa22YgEvhLmDkj8orAN9ioGB3Mkin7Qg1J35UV+o4L/0pGkVfGDI5hrI3OT2rsRkBZrBY7X5w2sm+ak4XKHvRq43FY37czbFlMdAXP2L1ciOnQCXDN4gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7764cf-4402-4a5d-d527-08ded06664ec
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:58:53.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcspmjvvcW6GtrJ0aIKZdJ5qvn8Wams9z1m6SYKTvWposNwuWMknq5msCs8MLFyC9PQZ2tAzvMrw/CG4S7pjILFG+wkeSTTCKCL1RdFkehc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9182
X-OriginatorOrg: intel.com
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

On Mon, Jun 22, 2026 at 07:22:08PM +0530, Tejasree Kondoj wrote:
> Add test cases to verify zero fill and one fill
> 
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
> ---
>  app/test/test.h        |  4 +++
>  app/test/test_dmadev.c | 57 ++++++++++++++++++++++++------------------
>  2 files changed, 37 insertions(+), 24 deletions(-)
> 
Feedback on v1 of this patch is still relevant, please check my comments
there.
Additional comments inline below here too.

Thanks,
/Bruce

> diff --git a/app/test/test.h b/app/test/test.h
> index b29233bb32..d313300056 100644
> --- a/app/test/test.h
> +++ b/app/test/test.h
> @@ -34,6 +34,10 @@
>  
>  #include <rte_test.h>
>  
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

This is the same as RTE_DIM.

> +#endif
> +
>  #define TEST_ASSERT RTE_TEST_ASSERT
>  
>  #define TEST_ASSERT_EQUAL RTE_TEST_ASSERT_EQUAL
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index b30f2214e5..d4299e501d 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -931,42 +931,51 @@ test_completion_handling(int16_t dev_id, uint16_t vchan)
>  static int
>  test_enqueue_fill(int16_t dev_id, uint16_t vchan)
>  {
> +	uint64_t pattern[3] = {0x0, 0xfedcba9876543210, 0xffffffffffffffff};

You don't need to hard-code the 3, since you always compute the size. Copy
what is done with "lengths" below.

>  	const unsigned int lengths[] = {8, 64, 1024, 50, 100, 89};
> +	unsigned int i, j, k;
>  	struct rte_mbuf *dst;
>  	char *dst_data;
> -	uint64_t pattern = 0xfedcba9876543210;
> -	unsigned int i, j;
>  
>  	dst = rte_pktmbuf_alloc(pool);
>  	if (dst == NULL)
>  		ERR_RETURN("Failed to allocate mbuf\n");
>  	dst_data = rte_pktmbuf_mtod(dst, char *);
>  
> -	for (i = 0; i < RTE_DIM(lengths); i++) {
> -		/* reset dst_data */
> -		memset(dst_data, 0, rte_pktmbuf_data_len(dst));
> +	for (k = 0; k < ARRAY_SIZE(pattern); k++) {
> +		for (i = 0; i < RTE_DIM(lengths); i++) {
> +			/* reset dst_data */
> +			memset(dst_data, 0, rte_pktmbuf_data_len(dst));
> +
> +			/* perform the fill operation */
> +			int id = rte_dma_fill(dev_id, vchan, pattern[k],
> +					rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
> +			if (id < 0) {
> +				if (id == -ENOTSUP) {
> +					rte_pktmbuf_free(dst);
> +					return 0;
> +				}
> +				ERR_RETURN("Error with rte_dma_fill\n");
> +			}
> +			await_hw(dev_id, vchan);
>  
> -		/* perform the fill operation */
> -		int id = rte_dma_fill(dev_id, vchan, pattern,
> -				rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
> -		if (id < 0)
> -			ERR_RETURN("Error with rte_dma_fill\n");
> -		await_hw(dev_id, vchan);
> +			if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
> +				ERR_RETURN("Error: fill operation failed (length: %u)\n",
> +					   lengths[i]);
> +			/* check the data from the fill operation is correct */
> +			for (j = 0; j < lengths[i]; j++) {
> +				char pat_byte = ((char *)&pattern[k])[j % 8];
>  
> -		if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
> -			ERR_RETURN("Error: fill operation failed (length: %u)\n", lengths[i]);
> -		/* check the data from the fill operation is correct */
> -		for (j = 0; j < lengths[i]; j++) {
> -			char pat_byte = ((char *)&pattern)[j % 8];
> -			if (dst_data[j] != pat_byte)
> -				ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
> -						lengths[i], dst_data[j], pat_byte);
> +				if (dst_data[j] != pat_byte)
> +					ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
> +							lengths[i], dst_data[j], pat_byte);
> +			}
> +			/* check that the data after the fill operation was not written to */
> +			for (; j < rte_pktmbuf_data_len(dst); j++)
> +				if (dst_data[j] != 0)
> +					ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
> +							lengths[i], dst_data[j], 0);
>  		}
> -		/* check that the data after the fill operation was not written to */
> -		for (; j < rte_pktmbuf_data_len(dst); j++)
> -			if (dst_data[j] != 0)
> -				ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
> -						lengths[i], dst_data[j], 0);
>  	}
>  
>  	rte_pktmbuf_free(dst);
> -- 
> 2.34.1
> 
