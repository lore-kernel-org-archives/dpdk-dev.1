Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689BACDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 09:27:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1820340696;
	Mon, 22 Jun 2026 11:27:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 007E9406FF
 for <dev@dpdk.org>; Mon, 22 Jun 2026 11:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782120459; x=1813656459;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ulPKj7mE5EA2bfckneuYVMrdIi/y3tF/1yMtev6r40I=;
 b=D2iqyJBJ929/nptI1BKXdqp8cZzI1uP1wWTIlmrJGNbcJHK/eqCdWXm9
 55BV0ENcGb7kIwT6Kon/WevqQ6ft+CppA9Pocpe5R1wlr201eentNLGqc
 MJqdSfoXxkAKoodZmxmsSln3w+bs+4sDdhmBkHjBPymA5KTOXVFEektPJ
 x2EqNLWohErqB+lg4zCEkVdOYceBy+Ka/9X+oTLAxcAZLTRO2LHCiMuaB
 lh7FuZ1J1rb+jQZ/RjLBut0lIKdQEezrQOJ9hc+plaiivzegQU1bQdkn1
 X/2r/Sk0pEOUCZrCiaTNshDHrOWLmJgrZ4KsmlLG6NoFfBIAWdYFEq+53 Q==;
X-CSE-ConnectionGUID: oMD56+MRTUCsgD7Asy1K3g==
X-CSE-MsgGUID: FA3oofqiT4aUr1Cmb0Qesw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82615838"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82615838"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:27:38 -0700
X-CSE-ConnectionGUID: u20b/gYISYOXjTEqDeawpg==
X-CSE-MsgGUID: KpLclyhtRd2wLcx5OIhbLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="273249583"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:27:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:27:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 02:27:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGhyO6Y2Ab+mXiqmj8Mw2MZudkldjG4DcqBKPH8929NYtQWpvHkx8SynQz3oduPssguSyYYSTlWpvZxOsRW/oSwv7rqGm9YsuA2oXg78v+UbC0St1CLxYyFzXf8eb5tJBKJ+6GAQek1pVypG8VTSBRVZylJfWjfNTjC6Kqy2k5P6wPQCovKaXtALHB0IiqkQlrW8kyz9CzvJTrJlLMKzAM6bEeC0iK/cp4xGN2LucR9XNTj7fgDyT6weDXCDbUt0vda/JBGQyPf38gSJnlwMVqctwLffCZ4S/ozZsvL/jcwKQ2ARqEBYOEAKmSS1iIp8oFJMIuwp8mi0YYwvFi/LUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aufruh2+wRVHllEDJpuFn0PhLB98QqdqW5QkfRIZF3g=;
 b=MlK2RQv6USHJUjuVA1kwLDVBrHz+/BIRy5P4LDaEe/fkaTLdgnCI+j+A55C5z+1OEi935gpa4f4mPc4feNrkGxbDuIfGdztFomorSjlavyzq6rGgx1xiXqe4GNDtAAg3fwnaVcR0vCUg3X2p6ebugkh6X+m6ng1xRtl0THQR46CBnjpM3ixNhISNbePVpHArOeGSzvQBhXvg8c0mAvUXg8On+zjsCaS5kKbFXKob8cPiYW35ZEbgNkbfi26Z1peux+YsFjGo0nc0jahhze8/mJ/8Y8kMBlrArPBtcMlb+FGh4sq89pFyBpXeqLnw4vum6HE3vQX7Uoxc48yC3llI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LV4PR11MB9513.namprd11.prod.outlook.com (2603:10b6:408:2e4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:27:33 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 09:27:33 +0000
Date: Mon, 22 Jun 2026 10:27:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Anoob Joseph <anoobj@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] test/dma: add functions to verify zero and one fill
Message-ID: <ajkAAEyYhFu5xPP2@bricha3-mobl1.ger.corp.intel.com>
References: <20260622030623.86094-1-ktejasree@marvell.com>
 <20260622030623.86094-3-ktejasree@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622030623.86094-3-ktejasree@marvell.com>
X-ClientProxiedBy: DU2PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LV4PR11MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 229002c3-fccc-4d69-edd5-08ded0407d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: F7akImfVuT9cE7/rAgcMpL+lSYFaBxRqvQt7HNfYvn70TEf6SUOVsTQeq2jIptBF31LS8scmUDe9XMvvFJrkcaKpPcSxS9YwcqY+E9xgiuiEvw3QOKJUKheiUsP+JnKejOpI+nTUMSBy8BSwzAz8K14H1KWoqan1QAjcffdTCAjc9krjKMQkQl9UpHHZcd0QWi1n0IOz/cnuEaqb+vHPpfHfj8Yni/JVlbRY9YTVBSbkqnbWjKV2IExgx3y2gZ7FClSj1mhZ1HjDK7zYMcK5WaGGDespZpl85BxtLjYV7/XhWmK8QoUn+xJ9I4Jtc5mAv+lHIpB4uXI3JufVoeqWmoDEXu0JQqhHfiQ1vaUZ9NfXNNNx6etv5OtV/nHTuedRrKEslt85l0o+gnarvYQ9xH4ubyEaqQ9OkOyC5+rS+Skm8fv6VEFxc1HhyFkn7O9AKMbl9tO4t3zin6X1AhuottSve5LzUQ2DFjlEr6y1IyVpBJfle3czf3/k5RDMR+GxPLX1JvK9rwBgzOGBaOmOmLWy5FSi5Q6eYweqG5W1Zc59vzFcFMqfJA/kOWW5zIWVbI9NUhdOUxkmX+CI2vvrzFZipTGw60H71EywqJim5GFC4TtORixQUUXAz4TtQ9nmmggrMLhHJf2rGDNm+6icSmAmLYjVIKuxGfAAeJS/7ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7o7Js7d87/bU6uEUZxtqbka4q/LVph/NdwmdUEeYb1pHubQz3coRjacm5fZ?=
 =?us-ascii?Q?2bRxkaQZ0IdI03g4cc+F6/oGX+qn3ksZ6Wh7utndVI6hC9MTkdUgJ87YOBdg?=
 =?us-ascii?Q?/y8KGxZU8eA/kvaxbVvlBTGujR/10TDQ55rD+bIbwSwrzKTSWW9gCR8r8Wsh?=
 =?us-ascii?Q?ovw/bxBov+vOllHXixdyjwhTZxSo/jCD+gSglybe/cqjghZcM9JRvBt5iaQA?=
 =?us-ascii?Q?vpHJPv+Jlp5XUc/rU7Q5J9Xz/nlnvgdBWU5J4y4S+58E8EDYJKweuGE+n8lH?=
 =?us-ascii?Q?NdgUCQ6JMtQUQHtX0JelrowR5Brdm+fbNOYY337O482mmveHLk5rmXOKASbr?=
 =?us-ascii?Q?LQMmBmc96ZheeNJqq/uqp7TncbWXya96ZTdEo8EBg5lRf1pk67gge9NVfVIc?=
 =?us-ascii?Q?oTUhwL6GfFPgBoiYoORCmn31C/khiGTfSxo5bcAXz6FFX5qG/TRXzZc7sOzF?=
 =?us-ascii?Q?c0U3y+urUSB+ELBzS7FN1BzSvqw48ZvybdXriggmnerdOa98HizE7v8pGt1c?=
 =?us-ascii?Q?aW8bG7GcsW/Ayl8hvX7BVTmcQAeZdblUcRC9ipg3ZTilVWHcYZ9TVP9nSuN2?=
 =?us-ascii?Q?85I0H9toKRDeRLnBabC4vEqJ8FUpCDidr6yTkdVsyoDQXog6xQRzG0Llwvjw?=
 =?us-ascii?Q?+eTrt1ae7uKY+KPhvJdf576uwTmYRzW9VfLS7LwpC5sh/NoaTE71pXCSTHKJ?=
 =?us-ascii?Q?gODtLHJqWSm86BotdSYuo4XieytNQghTjv900qxyz0xM1YIfmdVXQMxTsrw2?=
 =?us-ascii?Q?cQS8x9txTMek2V0TJhs3ZZfMJibJh7b37lVbbesX8YN/ZsuZXTJzA012haYC?=
 =?us-ascii?Q?eGAvk0OHrIjIHuvs86C4RijBC92pREjSVyxt5sAvd73a39xW94GPhn8/ip9I?=
 =?us-ascii?Q?pMBTyunLJP/RiQQ6LHaI8C2mwueIRRFgMc2TuYJOI2Eefzvjd0GHBTiKIyRQ?=
 =?us-ascii?Q?1TVnCisz6oO1pFT8dNXoGtddtLEJKVBYVcfQKH4ZJ/AGmk7yiOCJ0K1sjt0e?=
 =?us-ascii?Q?85ZhDsg1MWIMksDrT65uSrlwr0vu6qnuMvy/nF/aeR6K2RZ3jA3SVOFHexM+?=
 =?us-ascii?Q?ho8aEsSywfUmilHa731KT0F8f/Gjj5L8tP1ffl1H8nJWTHHp3swpZkb6u0d4?=
 =?us-ascii?Q?uaDgAGDaVeXnjs8NIFKLctQ+bHLW5cyxu2SyC1c+aFzV4zu7fVZGL8gu3bu2?=
 =?us-ascii?Q?yq9l4BrkEo+p2nd7t4NaZPUVsJch8sRt9EjK4LppUAsn14c7OJuZ/b1cdeGP?=
 =?us-ascii?Q?un9rmi7D8W6q7orkZSRBbMindBeEJGlbjfkM80WvYaAsM/DHdmQX3+L8lUCb?=
 =?us-ascii?Q?vWbAd131qa/Zx5NdKoR3BZ7Vj9ES28QE9TpBuzMZUILKT3rhF2LiVhFBwjUC?=
 =?us-ascii?Q?TOiF/07CpgiR63O7vle6YEaA5TXDRlgt92DzKyeJ3G6PB2x+B/or5zQo960U?=
 =?us-ascii?Q?lqUrO/pVY1eOatgYwPWi4eerMCQ4EjXseMEQN7pIWMqydLBuz9kyYoKWNADc?=
 =?us-ascii?Q?9JoWmlkJjKloqWEiD1fTfRebuvI2UII+XDjOcg0ssQCX5FJ8Np4h1+hW0a20?=
 =?us-ascii?Q?cGytGxmo3SB3YxY1F+Psw0qd5LY8gWArxSyyR/iYCIRDLWlzen+0fajqJzW5?=
 =?us-ascii?Q?S8XGtI5C6vdeH4MMVzD9REfkYletgBcHHwE4bI8YNRiuMpQ+bZxuMviDxXdl?=
 =?us-ascii?Q?sNhakezZ7NCuOaBhf3xi3k9JB+Lsb6MwYLBu/QASkCtRVnKiDwCe+wbV//bD?=
 =?us-ascii?Q?zuYcoDBoctNJ7o25liIEWL39EiShWsI=3D?=
X-Exchange-RoutingPolicyChecked: SziwytsvKH80IeZtD43LDuzpygYeRpeq65+G5kL0z6X3p8x611rlWnIgVYN0gzybUMTPsSLOe6g4L8Pe3qHR3CCpp4UaPxQEKI2Dnx9Sn8chb+FuXwEin8Q04ezTw2Qj/hpXiRsx3XHmN3peUTv3jclAQwtqOlYBMlXxmSp/rhpzW0erGvVXFgVLbz1H6lpqRIaYhWj5l0xZ5W2ltVD0uUG5uKsRcJiFh9Ru3jCJhCC3tHq6lXyzqg2LsfQafVNV4pJxwVTcVVBKgUVhKuAm/I+KgT9pCV+0pCc/iX6HG82NRuuEegDwf6cd9xJVNkvdM7nGNI7GJ9Gx30HCuUjBdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 229002c3-fccc-4d69-edd5-08ded0407d37
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:27:33.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYmYRXX4dfO0IL64ThY0I+/Q2MHeMl+tUakeDXZowlHxkLb53dcZRF0yIMaaXzYlBoxKAVilSCiAJSzLaz4ldXnvFl9nY1k4LfUUXaaBo0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9513
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

On Mon, Jun 22, 2026 at 08:36:23AM +0530, Tejasree Kondoj wrote:
> Add test cases to verify zero fill and one fill
> 
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> ---
>  app/test/test.h        |  4 +++
>  app/test/test_dmadev.c | 57 ++++++++++++++++++++++++------------------
>  2 files changed, 37 insertions(+), 24 deletions(-)
> 

Not a bad idea. One piece of feedback inline below. Otherwise:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/app/test/test.h b/app/test/test.h
> index 1f12fc5397..5fc2d7d048 100644
> --- a/app/test/test.h
> +++ b/app/test/test.h
> @@ -28,6 +28,10 @@
>  
>  #include <rte_test.h>
>  
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
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

I don't think we should reset between each run, because of the zero-fill
operation, which we cannot detect if it runs properly. I'd suggest
therefore:
* zero the buffer outside the main loop
* Run the non-zero patterns first, checking each one, without reset
* Do the zero-pattern at the end, so we can see that zeroing works.

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
