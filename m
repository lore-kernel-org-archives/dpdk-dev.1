Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1496CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C39240648;
	Tue, 14 Oct 2025 16:33:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B0685402A8;
 Tue, 14 Oct 2025 16:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452432; x=1791988432;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=shWTWVKXuw6YoaE6FjiVCQyGiZhqQyHgzaFPHT6DXQI=;
 b=BnENXkGBZvv3xHEJdS1Hh03YMA9q8voC/bhJHW+okMNIghS05wjXhrcJ
 ce9DBT4FGDw9mV1Ixe4sAYur30Iukf/O168SRPG/CL8kwqLPeDErA5H6u
 EVGJTvGk79jLk/n7TAZayPoWLbJnYUbWCINBtLEvwhKUqBUHSpHpplgG4
 f7A3qns7xV4YtsLTHY7VkeDJ+YxRKYlRdselI3lGI0kbGYzAtu3sx0+LQ
 GUd5W6H1CEo6nY3aYR15ngiSpvVkevVgIl8SFyVMvWQP796yA0Gy2irn9
 cYDhKWxiFX6M77aJAcRCqBmGfWSUPsuhVuQgr3/nygIEYzf8KD72qeO42 g==;
X-CSE-ConnectionGUID: SpKrHBV9RTK3ZMA+7kwxYw==
X-CSE-MsgGUID: XQ+GAuNqTzWq61D7Q7c4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62655787"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="62655787"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:33:37 -0700
X-CSE-ConnectionGUID: nwAIIBk0TdCh62sF8aHE8A==
X-CSE-MsgGUID: JWevaoJ5S4+BvUQokJTvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="219041673"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:33:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:33:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:33:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:33:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urA+G1at7ZudEUiVDNvteTmuciuDbmaR5vL41dqss4k07Uu1shirfUzRPTwp84x4dU/Vo27N/St4yh9TMT+n+gik1kPxU/DBcFo33DABmDaBYMyRvfTaUaq8ihEHJwqQlFm2nMT8krWjwKxTZx7SI1ksFuEoOTQb9QoDWVAn4jfeDqorER3Dwzbq4jKB0nyaYAxkS/c3zp/Du1/1p3I53seWuHRFScWoAkRM8qhrjrYWioAcrzy+AuFtKLRKfvVswwLYwB7EV/vvFAa8t0yHQ9HbsO9rjmySnlgu3Olo9gwjg4Jvc0uA3bZU6vk5AR2IHUZNR3Zhq+WOyKFxYmkvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjdMZQ9OlGJADpzVz7Uutr40qxBBNKEU0m9eMQYWOE=;
 b=DuudeD2dc8WxKSi6ne0VmLl4KK2MfC3w/JCBsZS/0sox7ABgWh6y09F0T9HSHLnQpjWFLCWBKh6oM5gUEbK7Ol+QbD8g/YFv1vCkUvx42qRZApGZgVYu/4PPcoF3PPf6tU+aT3jNLJtkjirwJ23ISGyFz6l6qb0gweqpx6rqwvEiQRUtTjvivuFYn0Py+ImcJbN8Ph12o0aBSzppuqqh33QDZ6V6rNrexrprEIJcyoypHH+owNgaUHV1sVjDxyOcYRcA51ewAAgSboPOeoXxlszn/r2ncJ1rT48yWcyWCcUfjapBaVlD6MEBSoZWPvLVSWcGQ2G3AtU3QWFMSNc1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF058255456.namprd11.prod.outlook.com (2603:10b6:518:1::d06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 14:33:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:33:33 +0000
Date: Tue, 14 Oct 2025 15:33:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 3/6] net/iavf: fix Rx path selection for scalar flex bulk
 alloc
Message-ID: <aO5fOLednPvYjAdn@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF058255456:EE_
X-MS-Office365-Filtering-Correlation-Id: 8972e80e-7b87-4d81-0a4c-08de0b2ea6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A4Z0cO23jPT8LEyyQho/SHgc0QMZHvWtnKwbCHCalQvgvm6sIim4yXfUJ6Yy?=
 =?us-ascii?Q?9h/HM3bVzJPmi45ZReELLeXY1S/CfcuFSnDCWFrqRmYA7b+h372BCh8ShbUD?=
 =?us-ascii?Q?fc6yqoQfDXDxi1JZ5pSwLfB/pLyAL/CyYffOYcnt7iYnfn3zkXjtyfmgwUkF?=
 =?us-ascii?Q?07eiGJOr8nAvPCz86iznJGX2506SvoJW7htvODRSmBUisVD+ODlru7T7j2wk?=
 =?us-ascii?Q?aCBQPgEMR4175ZCOsJ3WJK/qzGwrtbqfteW1PvPcxFtzF4KbZfOY2wG6NuV0?=
 =?us-ascii?Q?RKoihtQpjEA1DQmKhV0500ATftTf1fJrO0jJXe7VNsgcyslrqPhikfEeVl0Q?=
 =?us-ascii?Q?3QQwedRodDY3omyYczbVbwVgyi/Xe5Vud98BQh70O3MN2sF+RdNT+JOIGUf8?=
 =?us-ascii?Q?PYrFYM+wOm6iowJ7mXsdPJMtCiTULqATTTs+Ar30FEAzRJ8ZDZ5WY97+6CEH?=
 =?us-ascii?Q?ZYAFvUssCYvQ0BAhCXwyAPXqN5oRlxWuXGeOrB8Pz2noTCz0Lhplw6q5uRE+?=
 =?us-ascii?Q?y3ofhzPc2LY6uSw2vV+m4HzSvuhfME0qKFPYeRWdH07qSCe2qKgLjTiVcwpU?=
 =?us-ascii?Q?6QHp8zrDC1wChDYIyXfFgk1jUixJ3shwBm3Z6RAkpBcc3LW55YXWSuFhX3a/?=
 =?us-ascii?Q?CVTZbttjA6gDvhB2ACR1nEODfkA0TIAgUF6V3S0eW6XyYxR3pvkBqkLRsmZO?=
 =?us-ascii?Q?7IUFb5R+yjzIG/Ltu3hM4Vv3iJdMmjXKK9w37Nb73S0Hr+5nMzi0+nsj5RFJ?=
 =?us-ascii?Q?iM66K/3jk/9qS3adlQXR8eM2RzxvYsVRjuLuR5VQ8M3VlspSzfTDVg67OU8R?=
 =?us-ascii?Q?CzLsybrzRxEnoQ8nN56uXp/IBWbG/VvoMbxUCKtSAvKJ72G40OslHjITqHcp?=
 =?us-ascii?Q?GJzqdbogrTgNqN6LAOKfNZE8o2bcq+pHsqgB0CF+GgzY+Br7pq2jUZb4m2T0?=
 =?us-ascii?Q?yUt/2oHSwYnH/AEPuHoVACBFNsluJBtPsUMZNecltzBuNiIimThXITz8SNKr?=
 =?us-ascii?Q?mMof5WP6KYyZQLOSFPfqKiQ58DWPXHpPbZAqH53M6mGyWLHM5OkYoZj531QI?=
 =?us-ascii?Q?PQ3w9wrONpcSAJ8zHNcgr6zQpUwvwerNXVdAmrzC9nvCTm/Fm1xCyFU7NDQZ?=
 =?us-ascii?Q?a71M/6O6pAoQj/9wkfAu7FSkvTz5lRsKwqhwZ8hX9nab5/0XKvPrLzPmZm2G?=
 =?us-ascii?Q?aIWqp+Z+dPqKFfHzIcCeW1JkJGAMD7BCCg9S6kBQKKtqFV2g0iCdBb3FdvBp?=
 =?us-ascii?Q?sFxmjlfipqJi7Q9GgH1RbjNJ10dzmPzh4AXhmkqlUFLNFX3dJmVQIjXihFVA?=
 =?us-ascii?Q?+Zh6gFIdOhTf/nbJCVHp4+CeOFbF/AOWCzBmGgU677jZKW7Z5Beg/NLvFaaK?=
 =?us-ascii?Q?FxeYWqYkNts4BH5oWHxwSB/puynD1mEQvGroaSefMSGEOFZpLh4LU7u44v8N?=
 =?us-ascii?Q?acY2qC3z8aAP/vXw9RGTXtpZUlULpfAw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2aVk29uGIq/n03e6RDxl/dTRL1sCZdyvALMcT72JeXahjOx+1w0sHsRMlO0n?=
 =?us-ascii?Q?8IKmYdUE8kkA0PtIYlR94o2g4OzT7kr5yK/706kxJHXkMgBVjDbKYNBWsz13?=
 =?us-ascii?Q?IjKIUE0b1HUSmTTVq0yP2QEt+i92/mpchOfaNWtlMLHsGIBxk7Vuxx3yhc9K?=
 =?us-ascii?Q?wMa7Qs9fa3A7pvadRbuM4Ah653zL04usJQunJCKef4kApCWX2UwXkvNY/JkS?=
 =?us-ascii?Q?tmD30uDJHAIDyZ209NTdi4eViG8B66tDyvAOKvLXWURX7iopgv3kUDHtKx9f?=
 =?us-ascii?Q?TTk13RHAd7cy7zwddvz2R6/G/01+nLlK7uuIvUn4PtSu6wbO9QltjJMDn0ox?=
 =?us-ascii?Q?R5szKEPO/qKxV28n0nr7Qfd2dS8Zp4CnZvMBXHbUnZ0xpUqSt66XfLf0DfV7?=
 =?us-ascii?Q?HuB2Dotg1wKu5jX2mYattyDwGw+fhCJG4dPSdd/pfl74o7rVKDRTIfaBqpvu?=
 =?us-ascii?Q?tqWiW4hN+FtmDSqkSXJUMmiyEyt1YoRU6BQthYNX+oZU5xTXHz9UMxivR9t1?=
 =?us-ascii?Q?NNnPNXGvec6cEhao3giO4i4hOvRFn8+unGRV8E3RQMvQuLXlOZlH0G0DEQIz?=
 =?us-ascii?Q?LEyoVG4uLPnSztGYsiTSyCTOtBj/zn+NT/AW/kjITWqXjnjc28zTn4kbhv2U?=
 =?us-ascii?Q?/wbuP6UFtGjbvA9gobapP9wFdBW5eLodt25JUBrUSJ9PbR21NO5RMZA64Z2X?=
 =?us-ascii?Q?Os37V61jn6TzlaC4/qJgUOmR74evEZVpeCfwWyG50t0h0a5LXhc0qCrnn/vS?=
 =?us-ascii?Q?H1A2WvmFuLcRzb+vs44azTCj6WkHDFluHtjK4/5I0lG6+oehKigbXXXjZWrC?=
 =?us-ascii?Q?oHMBE9PhY9r/99hWOImDKIQuDsZM9OIWJTdRAKtEWUB7QMZGOu+DP1zVtuw7?=
 =?us-ascii?Q?6YJnhHFTHqNY78eJNyH+rAAqexkxYF+5QWO+YfQYI29NdQe5N29US4n6Dcpp?=
 =?us-ascii?Q?+vbjy/9tKPznbLEchI1Qf4r3/atouGA1W/pqCrugIb7fDyWkcJRualKtlDUA?=
 =?us-ascii?Q?cRaT8E0z7KfOCCf9LCLnfLbj/Ecjzus9G3UzhXLUq/WwoBKpzMCixiz9oknp?=
 =?us-ascii?Q?cWgcUyT+ka0oJfh6KF/npXTdfPCGxhth9oEBrNXhjRpVluWIRRghnNLKzbAD?=
 =?us-ascii?Q?G9rwUuEiKgqEmdVRWJ4iGGh8FTpZqIz/lAn8Hxc3HsqOFwQnmYWYCEHDf+UW?=
 =?us-ascii?Q?qIap28r0bsWfnspAULLgE/C19nzrSi0GZiD0h3wX3mTPIESf9ZM6dUKQh9gn?=
 =?us-ascii?Q?OBCOzsEcAXITsjRjv1ZLjcoOeZYyukA9SurHZNAEPIDc0GPAwMd7IgipdWve?=
 =?us-ascii?Q?oc2oy2aQAFeg+Avs+eWzmPoYwwctUsZUjgdH7KPrPo2AcYX3fUl5jWX7Lgz+?=
 =?us-ascii?Q?Mnbl1WeIbDVWQFoRpCSDxlAsNBpcRUHWoNcfRsqi6LnwNfOyYJk/H78cY0Y+?=
 =?us-ascii?Q?GQSTYmEUSTiTkP+7KeOnZQDwGw18w/8k1CFj9jFTgXQKnjZbcAFH2IUYtGpw?=
 =?us-ascii?Q?ZM/q8noXMaXSnZn7AkxumSCaq7TdZGkEcfjsZlY/+99BzoWBN/qtA2DR95Wd?=
 =?us-ascii?Q?bCOQ4hTRawG4pHHWnsf3SCoSU6gVc6xmcCDlBNQ66S6L3NvCRlRmU9CTwUaG?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8972e80e-7b87-4d81-0a4c-08de0b2ea6f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:33:33.2702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHz6wv3qBM/CF38SXUqZlQSolVh3ky4xmL80GdLxebw6qj6lMaVlDopGQAWOn6N81KJR0Dckz9X9IRDv64SxqtqQ5Ur4sEyhPc/itb9VXdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF058255456
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

On Tue, Oct 14, 2025 at 08:45:14AM +0000, Ciara Loftus wrote:
> The scalar bulk alloc rx burst function supports both legacy and
> flexible rx descriptors. The rx path selection infrastructure introduced
> in commit 91e3205d72d8 ("net/iavf: use common Rx path selection
> infrastructure") cannot define a path that supports both descriptor
> formats. To solve this problem, have two rx path definitions which both
> point to the same rx burst function but report different descriptor
> formats. This allows the rx path selection function to choose the
> correct path.
> 
> Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

I find it strange that both point to the one function but have different
offload capabilities. However, I realise that the code path bifurcates
again later in the function, so doing it this way is correct!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/iavf/iavf.h      | 1 +
>  drivers/net/intel/iavf/iavf_rxtx.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index 435902fbc2..4e76162337 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -327,6 +327,7 @@ enum iavf_rx_func_type {
>  	IAVF_RX_FLEX_RXD,
>  	IAVF_RX_SCATTERED_FLEX_RXD,
>  	IAVF_RX_BULK_ALLOC,
> +	IAVF_RX_BULK_ALLOC_FLEX_RXD,
>  	IAVF_RX_SSE,
>  	IAVF_RX_SSE_SCATTERED,
>  	IAVF_RX_SSE_FLEX_RXD,
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 67c73f9ad6..bbf3a1737e 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3734,6 +3734,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
>  				{.scattered = true, .flex_desc = true}}},
>  	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
>  		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
> +	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc Flex",
> +			{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED,
> +			{.flex_desc = true, .bulk_alloc = true}}},
>  #ifdef RTE_ARCH_X86
>  	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE",
>  		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
> -- 
> 2.34.1
> 
