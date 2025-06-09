Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774EEC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C663940661;
	Mon,  9 Jun 2025 12:25:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id CB99F40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464729; x=1781000729;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gRHRiv044A3Zx1iNOVYeusRZIw/nIMkCmhTVrt+YWs0=;
 b=Y47oDIiq5VJYN7draanvgG62SiL+vV+oMdD17ElGJ/zEhNjODackLVrH
 IMmsHPx8LqpZ9fz+EWmJSLjQFlUDPy8g2gW06OkxZg/zovvvz2EK0FZs0
 ZvFeVtlvZQ0pm+Gvs59dmQoHlDwU6Qf30SxJrX0fplZ2FdsnmombHtU2W
 v0ZiMe7yITbUWz3XU9XpS0+1gNfeVNTVkwNjZe4o64ns2ahX7xb2UxXsL
 CkCWUrODONwljTCwAlZI/HFcpwphuwlVDtLlR5OnmXxBafRWKEdD/0knA
 HA1MjGhjFijcAjigrWF4Snsy696v0tnCaNXnyHg/LAQxfyRn6dMG87HvW Q==;
X-CSE-ConnectionGUID: VOMC3niZR2aR4utUiIddZQ==
X-CSE-MsgGUID: kGvLZmABT9af6Fckk/8nSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74068429"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74068429"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:28 -0700
X-CSE-ConnectionGUID: u2fJpZKyQemU0Uxs/CyJ3Q==
X-CSE-MsgGUID: u1Lg6f84QjCEfcPl0vTTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151347580"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:25:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:25:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd1Oh4MHiYeYrFIqHSgrH5e9umqhv2gaAPsDJUNQBGp3v2LIA0cbZo5GW81EtL4PhhE+udg2kGqZWWPVFHpYOvivT6UeyJBDs4o9IQ3RILJ7K30t1/6RRZp8sfhkQfJS6qkDViFIVTFnAdkUXDEj2fwVYGKkPv7RQRdNotcyBcRkpblocSvibkEntLl64owWmuIcGU9XSV7eFOgBBrKvnGZfxVIWNvI1PxTyko38AATVPS9qNvWIMl6Hf854x97DkZnL8CDHHa+sAb2oBWo5uGR/ZHMmx7dJPiipp/LOJJc8N7CAjxr1aaUtHRrw9b2im9LeGI0S2yww8HRgHIo61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/NC9M024/Un+hlZAN3t6gcLX1/zTvkkUTKeggGLbAs=;
 b=TU7SjiUAaRnVnqen5Sl5LpMCSas/2sIo4ADvNjxI/ghtDKbBEV13wGkaA5hYdC1VKJxpQZWUqEWY5kIDwvWdXyv742elU55q/CjWmkaCHooD1pziGc1QPug/ftz9hUWLbpyX3SzBki+0eoEFWNAEqmOsbHqjvDz94uxN+m0+NIbrgK2VkRXJuxJrbgAXVxNgNxyUGHx3bze/lx5T2aHpZoQKlV4Dk+kFirL/s0D0t+4iiT8wY1aRmXtQIvM/+shsEWss5aiM+xHKQ8M9BiK0wsjDrnR711duv5YrBkmKsIzc4EtRUYpVjM4uBnLx71NnhzUvI+ZvRKezX1mJn69ThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:25:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:25:11 +0000
Date: Mon, 9 Jun 2025 11:25:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 10/34] net/ixgbe: adjust indentation
Message-ID: <aEa2gX4H_gHmlVy0@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <34b198c37a77842b6d721a6e6e1264b9f0404c67.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34b198c37a77842b6d721a6e6e1264b9f0404c67.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0061.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ad8d20-5906-4a5c-e3bb-08dda73fea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vO8UlSPs2CEtkzrn5Q18brshYv7MeB9C8DB1yPTSoT3H6SvhnDepoz5vVIh5?=
 =?us-ascii?Q?32Pf4Ho2Bb9r8kNkzRP528JoITWI/GP5iWcO7lg0g46+jEuaWsT4Hie4ldFw?=
 =?us-ascii?Q?Pk/e79jrh8xSoSMMV9wXiAw4v8+8tXOCmlItCUAGkbjGyceq2365Y1QINV4D?=
 =?us-ascii?Q?ho+P+Y3WynWLWdLzUWe8PC0fK+aEnejY6ShyF1+kYjgjQoC4VqvtWUZhdYRS?=
 =?us-ascii?Q?AMlJ3E43pPG010Je1t4KWLX2MWuFUwy3q6mSIXaa8Dp6jOdrgIFZWlecnKlk?=
 =?us-ascii?Q?AUlEvDDcmZTKsMetiq84hVFv656gfOj3bw0Fur7zyL7aMZFt0hLeixKfj1jI?=
 =?us-ascii?Q?2WZb64xAtCE//ScFqMaZ+Lx7Pg3Nqjv8M6VXr6E/GeArRjyjmHtHqqhs71Ko?=
 =?us-ascii?Q?7UAI2Xl70x866TrPMLr0joRJATpN7HuxSPdsVFnukWrCwaVMox+YaWibUKSm?=
 =?us-ascii?Q?Jg7jKr2hxu+oV1S2k/kkzuHcsC1x1/y13SJSkxKpZJ1uRWubDlCbtS5Ve2pv?=
 =?us-ascii?Q?IPlxAaV8H+R6ovrvACyUqcuOn9Eu7gncUPbYbDvEjxKwkoyRDbxDPWw1/fLU?=
 =?us-ascii?Q?5szy08y5u1OkNIHlVzPvicQQ4nOZiZSeQMbG2qawprl/3zSNPfE2V2OpE8Pg?=
 =?us-ascii?Q?jKn8S4G6jiaKoTjUHn3mkVvBgHKo4lQ/eTYqgiKicfiWyNO7wk/MVTtHjwFy?=
 =?us-ascii?Q?g8KqQMQbw72uz5pQQMhCX/WG9ljgLTfQxU9pBXDCP45NutLC3Iru3r1x3EIG?=
 =?us-ascii?Q?eEwkY36JyPuBYcFZWEzejOYqDrzFnRSfEAaTglPeWeCdA+xMPLGJDpb7DuAt?=
 =?us-ascii?Q?USPlH2rSGz8mef5T0BIi+iKFabp1/mlYkoIRpoaJ/GPu884RQ2JdhLnLOkrB?=
 =?us-ascii?Q?QPslDx2IGKmmedBaKzz4mvFOxgx4OblAyNm3eIEAjtzxIUuYD0ZanHPPuFHJ?=
 =?us-ascii?Q?hU0WKEiuTQ1FOWn6dlH46uqjjU6RFeOl02T4+ObphHXZz+GmJSg1/HYcWDE7?=
 =?us-ascii?Q?/ryvJg/7RDSWhSpnHNLEdhzgDB8fkg8+1rfbxjymX5l+Yb26/PLuT/IGfbXK?=
 =?us-ascii?Q?6W+rw+aDvteZHmmVixyyulBqBmJykL54Zb8sv4x/a5N3DcjwmmEd69g+p6TM?=
 =?us-ascii?Q?/sdK1chcNJKPwhrlmB5v++qOOJx1T/R8oB/xlkUDiujjEJIJynI5gIt/OMkZ?=
 =?us-ascii?Q?Y4aC2mQcy5T8JPfEqcDBPLKGZUPO0s9zbvI7yDb37pWj/VSGShpSOA3yZmY/?=
 =?us-ascii?Q?acKZkjRI++opQ5E26CfoA5/g0kI2++3QK+gKcZGwRCG3lHwoDlQdYYPW2V3B?=
 =?us-ascii?Q?Vsy/6VqbTmTMa+xi0VSNDlHUHmbBMJYvv0qfTjwGhQYXlgzrV0DfHFITAQR/?=
 =?us-ascii?Q?QpATUvB9EyNtG0b1wJ7dyiYnaGH6ytUMeAD8DYPQ07dkuilGmPfYzIsf+gFD?=
 =?us-ascii?Q?fzY484O/dbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awoWXcG1cwj0I0mvgXsixPD+iZHQezuaDBqlIAARTmVS48S9S0b+C7U7TSMU?=
 =?us-ascii?Q?yFROztgXAGu8Mr2VqMQ7rNPCV82aZXlgRGExfbMuSOHZl2jfdGMx6T5nEBDS?=
 =?us-ascii?Q?4KWNRrlGTYX0K9jpuZK8yPCXJsHJisvqhpDavkO/VhO3iSC+WOfQ8rZKp+IM?=
 =?us-ascii?Q?qbTNQzSmRerozsAVTMMuQcrtADO0cfS+9qI4pfexJGRAn8L7Rgd/UDjE7eDW?=
 =?us-ascii?Q?x6PMlh6kt6bYzgova2Q6/HdZS6MS/M5zJX8d9YqV8y94W/cu0pzGK4xKHp+i?=
 =?us-ascii?Q?dYISy2RNbpTNMlP84wvJVSY2MpLqyRh7xuiDMJYrjnxJYfK1Jv1JrX5/75yX?=
 =?us-ascii?Q?ybkFPcfeEldCjine/+S59avnu2VPOdyrmmGTlmRlJiOkRo4viuWDbMnr/c5C?=
 =?us-ascii?Q?Oeowilu6Kv3+rG3onnI25GTF5r6UKa4yl2mg/HPMHoMX4kPt/fyKbiltdSge?=
 =?us-ascii?Q?ySTju+0EZTuQdU3Ll35lZpICLo9hM9LLvIaufbP7+G9x+katGclGYfnNPrZu?=
 =?us-ascii?Q?QveA/vJo+hxKlUW4nIF6hjVbGK2EpjdYrSCqIWX+V9W77KOhlLln4NpCEXd5?=
 =?us-ascii?Q?ZA557lBjCWFwq5y8G6kPzUz20sPs5TEaX4ZGXYLCJC6BKfokwnRu9elq8DGC?=
 =?us-ascii?Q?B8Ob5jYN/BUlLY0N1WPiKiGXjNgUVEnNcoEtuWn+JtG5ZfBustPHmLXoa5Lo?=
 =?us-ascii?Q?Rjm+PZCJZ5tAc4J9pIQLeWrJk+42CKI7b+DH+/tiY8sQ4sF77nS+0YzkfjRx?=
 =?us-ascii?Q?Jqx+FCFVJeX1DdJsXXTQvEeSdOV0Pwab6QUWiktjy/5AJfVl3sSBJMmTSeuj?=
 =?us-ascii?Q?pl72FXybAiUnSt/ar4fplaNLlqbSvcm5WpdKbarv/FvwbAgspq4M4kmBfUOW?=
 =?us-ascii?Q?8+Vuj/XjXbLronQQydglZZr54tkd7u6oRS1UW9X6JHeCo4whpfeXG4Z30zPD?=
 =?us-ascii?Q?jfijJ9XoR1YSOZWsSANjvyiC5hHDrtw7paX4dvVPPZTHcVmGvjg6kpfWGgJM?=
 =?us-ascii?Q?TWlz3/dgsLsJ3FCavtYEDp4rQduiU6vU84Yf1MQX2McsP6AMOw2xcwdrowpP?=
 =?us-ascii?Q?SL3IsdEzdu7Nc8nT+EblwMjCO/FfZ+KH2187j095dBfyFdNkaHojHWWaxDNn?=
 =?us-ascii?Q?NjxyyheH5t/Fso31TYOrVA0LaEowWqupzSOso/jO+ny96NGJNF/xtrIamWvS?=
 =?us-ascii?Q?OsoC0dnCIbycXhSg1tQWVqpE6EqubdMW/UjfeLRmw2YV08qGS4/GpEbtKzg0?=
 =?us-ascii?Q?epeOVdhd+v4G589+CsFa0Cw9mA8mJ6VQzQH6Tx9ec9VhDfcK78E/FrF2oyOy?=
 =?us-ascii?Q?WFsbTFW5gvQJYbT+s1oOY6XVGS8RoZqwH6s9H459pOSnqp/BG121OnwW9KBj?=
 =?us-ascii?Q?kutIOLZvpEANuXZASfOl6s69+jxwZ6Cf9AswOrML7VtTBWCJUm2psiwQ0fjS?=
 =?us-ascii?Q?fZj//PFW+FyiZjHE6itzRJlHnCs3Unt8XzlOAev5KLl4x2lqC0LRJaDCMqwz?=
 =?us-ascii?Q?MAyRrHwBNjl4SARNsuG2jMTrKC3V5PMuO+A5lb2QGT7aAqctqgISlpLsS2Ty?=
 =?us-ascii?Q?50b51BFToucj/Iv/OtJqUJhlrhpJbA1PP71nE7+YstHM1dEIkLFAhc1PA5I1?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ad8d20-5906-4a5c-e3bb-08dda73fea4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:25:11.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtjPqgMxwBRXbjWlMcPGiRgtm5vy8TRmY6S+WTs2k2Yw1cImeHszU2NvKraSHh7WMEJmYMDsbC/12w4PMHbicVf0m2zZ68EYzZnI0CUki68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
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

On Fri, Jun 06, 2025 at 06:08:49PM +0100, Anatoly Burakov wrote:
> There is wrong indentation in `ixgbe_set_tx_function`. Fix it.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
