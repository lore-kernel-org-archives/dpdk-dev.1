Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CC10A62D5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 13:40:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202D14026A;
	Thu, 26 Mar 2026 14:40:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0240F4026A
 for <dev@dpdk.org>; Thu, 26 Mar 2026 14:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774532416; x=1806068416;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8Vl0KLGqao3S2iYj++gnK/JWdZus3246hKhL7n/HEhk=;
 b=JIht5hIg6N0n09L/SOP7pcTwGJIrWEwPdPs0zVTn4aQlcbZfT7qt69TJ
 UuEhiHzr3MSyetevHc1a3b21OPkfdl3dyHoa1kzEZRQWqXnbIJHnZv+4N
 6oGoGGohQQRxKHKS8a2ISaSBzmdfvlcivEIEI0XEo4WyeLzzeLYlYI9e1
 79/yS7UYFv1k/R0+v3iQLKz7glyPnblaqENwFVYvHqM/FeuRUtogonQDY
 Wmht8BQBy8nd5KSkEppuNaWE2lhTd7aYxzUi7UBlDFHa9mSnVM9HIFMMv
 8+R16ay+TPGYpbB0Mcol1SL9jzjgenkXTm4/dYW3nhgRPxUBSkvkSqmBE w==;
X-CSE-ConnectionGUID: 0RcsRsItRnq6FtqSWuHNVw==
X-CSE-MsgGUID: geV+5YzeShG3a0xQUA5OAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86207527"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="86207527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 06:40:15 -0700
X-CSE-ConnectionGUID: KqRtejL+TFyEymh7LN5BTQ==
X-CSE-MsgGUID: Cvqj2ltgT2qTNvKRHomnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="248416740"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 06:40:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 06:40:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 06:40:14 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 06:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlLpOadTwVBxmpWCT0VwtydFLq5IkCI4p+uE61ZlzxLjtVsgrE6nC+nLNbsxlzJvWm9LUBsHEJL1lRTzaarEAlxxlBfFF5GYHa9wVzPNLTBeDqt5BT8UlomMq8sX+2q+NQlkKRd0umGSM6uqnu/uvCwfebvC1roa74LN/CC6DRHL1peK09eTm9IfG3pjRgTwXT8xXH3sBxRe73Eq2Vn5F6SIksadgYyp2k1khH0rvViQxJvQF8Vghni1XY1lwGDcT+EQiED/id4hPnVwjgRIjVyAo5Ya0dq/0uqsU2A03G0vEOKSxR0OfvHx1/oQUIm+t43wUlmcXYtJAG13Oz1w/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9yXqwe3zc4P1ZrV7ggc3anKKtOT2lO7yDBkt06aK5g=;
 b=Pjb3B1szv18mIaioaCQTIpoZ1w+INaY+WalR8+zWLzzQ9aAM8Ttq0arsDt9AuCEeUtdq9E8FuQlTZETw5DzkckSLTEc8fVPymSWIAWXs2IFlafcq6+TU8oOMSDc0xMwK+FD4DG5Yd/Ng1MXrRewJPuvUeMeKTJwiHx0dUTsitZg9qECZLkCK4/jJmGmjiHRq3PWiwaB9B483HzzbNdc+pLMBxlLx1iO7Zuy92M9XkFHW5WFGqULTf6ShlSp/RRtichtrchiQ6er4ZhBTz5abS8+wqgBUz/ZOnxTcOs+7vEO947KIzwvDua36fl8l3YbD5fCN4RCvMkAY4t0HTSjXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:40:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:40:11 +0000
Date: Thu, 26 Mar 2026 13:40:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] net/tap: fix close for partially configured port
Message-ID: <acU3NAhTocIqUqpl@bricha3-mobl1.ger.corp.intel.com>
References: <20260326124612.2580985-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326124612.2580985-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b3d6db-1158-4182-751f-08de8b3d3332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: F9lUR7ry7GqySq3Fvic5bRwInntBsg+JYU0UiKyIWaH4LfhdLt0C7lGVvThmFrn88GVhDXDDjFzeW8HNglbuFEZbRQORZI+8kgzlt6tDffN+mF5N+mEQZoTdbwYigdQeCiRbwkx9i/z/VpThPprDLFZzVfhmFpJPvkDiYjLp9uHb/Bh9FU/aaaLbbB0lkIom8ozyRN/1M10vlQSwgr24ULtZgWvoSco5049GEdAP7hdJMf2qHWKWaClfNGbX6W2sr3aZ1ahDMG63tPqygvZtzKin+s/PUU3s4i24AOuBlopABu82Mwc2urq1cx37dt6X7pwbdGS2GTDGGxM/LfjcYgF3TDEqhKc6Ac8RF2DF+LLkFGWxToEGiTMc+8+ZnpkHxRmg97/5kAqg5GmMal/9zwwAFdl2SYxA4jBWSoJKKLLQrr6asC2uf3kvX3XwDJKOK81SjREjWNbJuFifzJAhqY95l/tlUad8kZyvks/zMpWi7jlFR75AMwKkH9fTa4i4DznuEycTR2m299Ou7GlVeBQvZyYbx1wTrz32O3Na2sjx+JThXkwHjiAOZbpQGBZPF9Me7yHQ6aF9bF31V0OhEGLK3/zoqmp0rzRHdRUF9lXXsy2vGiGpTZA7KrulkGDmIYwvfTpYxilD8h7Bckql8BnHvXRiO3h0tPxJndRLB8/7ZFk5wmKfTyb3Z7iA1NCSejKPlquN4xy60fCuCC2o6yMFY27dyeKlFgSsu9/8oac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0FKwhXOyGxezzoIOjiHRkVLNKkTFgFve8+1IZ3oLCD85+pUg29r0GrLUhXr?=
 =?us-ascii?Q?zj6fUoaOmNhNzKzALo7CXJmd2gQNTYpJyTzbKxPH2NIDQsQfRcfWd2zP78Rd?=
 =?us-ascii?Q?BGrr7q37aVcW97dYOBe75ILB4UfXss64gzoDJawmb4zKQbDXD9Cbb+RH5Ruc?=
 =?us-ascii?Q?DbgAUT6GPP1oQTUKnKhZ3Ef2s7jZbVI0rUNi9WqfmAms3a1vZabvhWR7Xysj?=
 =?us-ascii?Q?GZCDLDVlDpn5+jyvHZDX50f4Nm1We4OhY3YGcx5y+tZVoHXpIDXuWk5cu1+r?=
 =?us-ascii?Q?sRlJWUC79hcxbvqCVMLrYfKSUKH9LkS5EaKL9sbutok9qdj0aKK5XxCBIr+Q?=
 =?us-ascii?Q?CazeRWd0z1KC5k5JYrltmkw1RhvkssOYtmWFpPBX7rY55I+7gMRkgBDb12GP?=
 =?us-ascii?Q?h6pzV5rDdNojIGWfXP3tQKSbt2CWYyfHCnhb5dKNkw9tC5eGhf4XmmoNR0Hw?=
 =?us-ascii?Q?ltWOJzdW2e2Vc40hDuMqKof0wUBOBMbVQ/mKvz9JB1NtWEQwd4qpW5P2+Rxg?=
 =?us-ascii?Q?aC97J/MKgeKCfkToMKugbFxqJbF6jDzFCsAIpD3Wtp2vTjPsI6mQcOWiADmD?=
 =?us-ascii?Q?vN6kOvntDUEYtmboAa3Rrvl5NVuqAAZE5CDc0JPBCnX3BVkQgWk6SoFwfWNi?=
 =?us-ascii?Q?RjSE4+F+G1nVfYwDxepYHS/EhoN1o7btiO05rjC/F9+ZXv8zO1Id+OiWINgM?=
 =?us-ascii?Q?8TDdBQTdzKFmzRD56gcVhuti5QJ4HXFf/Twq7YTaXd4uY+DYdLV0RfixVo4R?=
 =?us-ascii?Q?PoSvC/VqmWNaQ/0eGYHlpSDAmJTFwhfSB5nP+H8WOX4dY9H5Qwg2OndPlUn6?=
 =?us-ascii?Q?3/c+An4uIVLtOraJQmpwOFGjnvv41+KC4Q0nKxAyhffx91m6Ay5HZae9BceR?=
 =?us-ascii?Q?mlEz8tZyNDrjUpwXV8UTN43Z+ZnuCfQUwE9SDlHdVEqGgHvQJU6cmyhuDeTW?=
 =?us-ascii?Q?IyFd0PrNUGToxZFN7MEDN2EGfyeXs59PWev04pGfknjW1Ma/CdQZSc6MEhaM?=
 =?us-ascii?Q?EzveVycgpHZEPwR3HBLttICHMXcYPx5hiXKW93YpFgMgGn8UASXd+B/1xFT4?=
 =?us-ascii?Q?V7zGetEo5mGXpTi9T/O6jG2O5nuari3EPO5isU5Buo5FpstwM9HCUOd25Zdj?=
 =?us-ascii?Q?b7QbsgkU9Om5dCvxPySReVlsw7VCEqu0yPPCoa+IoRh7y9YBgKNySUVVntWp?=
 =?us-ascii?Q?tDZghs8yTt9885MUb6Sjr1yHewo0cSGdJoIGhrec2yKm8qA59nAMQ35OHyCl?=
 =?us-ascii?Q?slr5jfwvhwYLoQXECice0m6yGYAgR5SPxPIfuNtPrgdPsqRUF8mtJASbKsKS?=
 =?us-ascii?Q?QlOPLWCEwepl8bloBrEAUtkSGsQZFI9XGMO2WYIAwAy/8DP0b1bGXzy71p1D?=
 =?us-ascii?Q?DxyEbWciMXvsCu3CuDPKwcHTm6gUWi/VlTOdpcYZevO2110sbxv3JbGHv+da?=
 =?us-ascii?Q?5aJQmxbsuU8Qcn03R3M16Wa4HTruzbSIYXcc/YGll7lc1CwOVI+qW89q/Mjw?=
 =?us-ascii?Q?24xAoo2sLoGKD9low/M2dqejXjnktqjTVRBWaQ2bl8rVKnkAlBDezV8G6cUB?=
 =?us-ascii?Q?zzhSAzaYCAN5kTY0xEY3CluPW6OFmliRMFaghsYVm/aRuGeb+aDsEGu0+1Jh?=
 =?us-ascii?Q?+nYpUoN2d9pmonOXf10k8BOIktLbI7KL5nCP94GAmTSA1a7PIkCHtDdLxddY?=
 =?us-ascii?Q?xoHBHGVzZed3SyrTgCzQCRszfvUkrAzYOF3wZZXTSlmqssKe390wQwLcepby?=
 =?us-ascii?Q?xDsZh3ari1vhtSJ686wEh8JhSQcF2WA=3D?=
X-Exchange-RoutingPolicyChecked: tR+//t69Ev1bKYi1q60TgDYbBqKmPNwr//Wxh52+9TUaJBiRUkT4YARABsOeoM5fX2GgxDEyzB/W25Qr0tMLD6X1TNLvJsvmoP+BgxQvEShJWAiX/VdjHEaUbP3mJNrPPAd8dftMjHUwDyxGx7aKtqQr0h+8OPVEAfwpJ9Q0uB5hOizyb1rjGu0S/KnvKg8nJO64LYMlVQW2uxvFJmqmazXs97EDff0wFXJ4mFsPWcvbpr4Q+n3pa+cavZUeE5OnBxHrVw05TKUOWkP4ALBLBGkCsDYB7MOlYr6D1m8lU3hkfs4bqBqg7EGrUCGfI8KEdmnkxKVTVXTcwgbIZHRMoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b3d6db-1158-4182-751f-08de8b3d3332
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:40:10.3823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTKjbQaJ0KRMRAi+4GDVmxgd9noQsoL0//hohAisP1ckz60PYaunovyENcgHdB4HL1IZFXJr3SfzsukNhpVl4sjYvJ/WJNuMM6HssAyoL/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5949
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

On Thu, Mar 26, 2026 at 01:46:11PM +0100, David Marchand wrote:
> In case no rxq has been set up (like when starting testpmd with no mempool
> drivers), a crash happens in tap_dev_close:
> 
> Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
> 	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
> 1111			struct rx_queue *rxq = dev->data->rx_queues[i];
> 
> (gdb) p dev->data->rx_queues
> $4 = (void **) 0x0
> 
> Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Looks ok to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/tap/rte_eth_tap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
> index 64b359914b..6d710131e8 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -1108,17 +1108,22 @@ tap_dev_close(struct rte_eth_dev *dev)
>  #endif
>  
>  	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
> -		struct rx_queue *rxq = dev->data->rx_queues[i];
> +		struct rx_queue *rxq = NULL;
> +		struct rx_queue *txq = NULL;
>  
>  		tap_queue_close(process_private, i);
>  
> +		if (dev->data->rx_queues != NULL)
> +			rxq = dev->data->rx_queues[i];
>  		if (rxq != NULL) {
>  			tap_rxq_pool_free(rxq->pool);
>  			rte_free(rxq);
>  			dev->data->rx_queues[i] = NULL;
>  		}
>  
> -		if (dev->data->tx_queues[i] != NULL) {
> +		if (dev->data->tx_queues != NULL)
> +			txq = dev->data->tx_queues[i];
> +		if (txq != NULL) {
>  			rte_free(dev->data->tx_queues[i]);
>  			dev->data->tx_queues[i] = NULL;
>  		}
> -- 
> 2.53.0
> 
