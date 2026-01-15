Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718BD4116B
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC28410F2;
	Thu, 15 Jan 2026 11:43:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D8D9F406B7;
 Thu, 15 Jan 2026 11:43:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473783; x=1800009783;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6OXBpuOe6ti87WJ9ABRV8HcOA9w7RN66mRrwUdm5ypQ=;
 b=AXclZnev6DPEYU77j9hg1l/wF/3HtB/H1JOcK3RQjG4OuOdw8UzTYCmP
 aidt0SwH/Yz88mC27/a+y7YQT0qjn+T9TsLFp4CGbJ10HtomFdhAGeNq7
 +roCULzwj06eXNy/T3lsg9dYUS0uM60dvAcp5XP6e72CNdy49Ox3zDCq6
 ONwt+dvHXi60kTWmBGAFNNNB6+liXZxgEdUzmvXsnvuGCFTylmfZf9efA
 D4jxPJ9eTHzr5ncemWhS9E6V3aKQoaT/4XQ1iDE6Ev0o4xdeMDQhnkyoO
 tkKcdSOWpAe0HV21MGFVNDlGfKIUoHAQAj3MHSbWTqAenGcedawYpSf9G A==;
X-CSE-ConnectionGUID: hTZ/EuikSGiWNkIty8MDLg==
X-CSE-MsgGUID: pUkFcL2MRQ2kU3iZZCs8pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81142463"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="81142463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:43:02 -0800
X-CSE-ConnectionGUID: nk61ddi4TaqyxTucU0LoIg==
X-CSE-MsgGUID: YyMIp8BhQmSOPlsi7R0H1g==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:43:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:43:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 02:43:01 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 02:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8GaHvALnfRxf5w7yxIzOC0gzmPSeAbx+vDtZ73D0bz1twOMrD75OBmUdAhOALkHx4GV9xhSJ2y7UlAfTGZXywEwP9OP4HkVk31BwVvTt/b0CeZCGCOraISiTYQu2qCc8mtmGGhipRMs73kwcpSIWrqBETCga2frgTli5ft0TexSsLzV66awHC7/8QpP1L/Ef9Y3ljNul/scG2U4mQMmh69Rw4bAw0gkTeepv96EhzcJkxPPC1eI0BmU9QreLGwyCCDcOaCZXPWDhxvqHWigQTJymhEaR3pX3dfmbu11rNqqQ51IedZN9J8fIxCwdzu2XqbnBKZHvkmJ3ascFu7Zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuIRAEtIFC79D2gz4ed34oziNlG8kYLtov29fZCxubA=;
 b=uN4AfRsIyOYGdVxWmHLBGA29im8HymaY74ggZEIEeb5rGReTSfJv5xyguK5Dz2pVDNYww4EygDL1zSlpVcH04VB0aHoAjPlIVsKUHuDIT+nJ6qQmcBEnNLMPxCOD/ni4Y0kQicyxccQRvvCb1BsbCLQ1MgiVyju0nMjsIs3PFX8rq8vnfjYAcZ0uUxIosvK8WIPgQg97BpsXHvlXa6sUMg8NKo8gZwEUmcCP+fYjXNaAytdXneDelyO/0RDMONVE+XdqUyj+Bn/hs+EJaE0moXZw9FyVVYEhSrWLO4+qzh5CByFyRJa5fcXySmnjpYakdVohmFmZ3mOq0QKSVPNyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 10:42:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 10:42:59 +0000
Date: Thu, 15 Jan 2026 10:42:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 3/3] net/ice: re-enable strict priority on non-root levels
Message-ID: <aWjErt_PY_Q8KQhM@bricha3-mobl1.ger.corp.intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
 <20260115103824.1982220-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115103824.1982220-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 50402d09-87cc-46fd-b8b3-08de5422d9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PAJwboDFFqbaVxFCwEjm9tjVBBPFCOrZa7OyiMUi2Lwe0TRm5Zf1W3Wo1hbr?=
 =?us-ascii?Q?phWB3WdlA+csW1DHAM+qbn5qr5Zsh6/9jXavk5NtqKrFdAXdXPcQVwevJvbG?=
 =?us-ascii?Q?HyhW28vBEtQ+gJQkQ21dE+O4ykdLI58WRx1YhWE3Mf4ojfE6o6pferVFqa+W?=
 =?us-ascii?Q?CtaKen7J12xqfKwVDrdawcWCrW5Arwol4crLt0Oc6ACxHVNsdO4IywrPhA0J?=
 =?us-ascii?Q?csxMwBLwhezigtXWOik7uqA2+nor7X+XFlvk8PK1W1nidT0BC/c96GViJ+7O?=
 =?us-ascii?Q?oCfjytBOE1kXQDxehhcNDIr9oKsksI1XHbsw+qwVoIf6zSZdLh2gWVvKuOW+?=
 =?us-ascii?Q?Pad6SvNfnND6bfFRABNu8vrtrW4hHFMro81ZDPO5Yi2IAB+UFqI230q89x/E?=
 =?us-ascii?Q?WzFhYtyfHDlHX7YtnGpySoQ1DB7CPtdxmF6QjKdu6z2RweLsqTLCuJcUuDE6?=
 =?us-ascii?Q?Yx1ouRKlcyzJXvjqk5W/fRqYTQyZb/zawZ87NZExXHHVvaTPcWgnCgfK3cL1?=
 =?us-ascii?Q?+u1d4WUdcUpSVA3eBj1ggIuu9sU02FD3iydLN/7XIP+kaSafYDX8mMCmlDVJ?=
 =?us-ascii?Q?OMlUVYVOJDzl2b7UMDKSTytBYbOPfNNTv1BkIN4EXfELZrdvWB+DxrwqipoR?=
 =?us-ascii?Q?9htxGigtwJ2A8IoVPSIhSsm54fg8LqTqU2Re5Zc+JClh2yJbvFWTC/Xv+OgQ?=
 =?us-ascii?Q?eXlvF9ZRF0/cZdx8KmWu56MGBPVWwd4SibPyl3N1i8SE43UbG3CHlldbrIAs?=
 =?us-ascii?Q?qR2HhWEZ+yxX4sBXWxgrTf3x1WJx7Kp4vRV1qBLhqVHtlgAvkWvc1p3BrNG8?=
 =?us-ascii?Q?1fovDIf6cTb3IfTSXyiSaLhcRbwZo/578kOeWaOjlv950ApFNCfoslr75TiO?=
 =?us-ascii?Q?Axs0lt0Fc095eacIGpfcXwmy8yvtom7QO7tAVPQ+DVQRfZ/H05KdulypRk1V?=
 =?us-ascii?Q?QKF7ZZJdnf6ghLfXLbXfWACDz3cXYKhfeAZyvee3wW5SqbL7E0g/tZWzq1QJ?=
 =?us-ascii?Q?JYzhA5qFi37ZAKAatkMx8j7vSOA9iNKClJKzV8es5iEegj2IGrRVcjddMec8?=
 =?us-ascii?Q?BskqqPOH//qN/N1822xOeffcCxNhNq9ti7ZXfS5FyM2w4crPBNbPS5HF5TD6?=
 =?us-ascii?Q?aiOienPCiue5IxwJD+6jwFWqeFEKlx80m7T1sX7zTfIzoYE7kRWrm5Puko6Q?=
 =?us-ascii?Q?VKi5Vn4jcsyN//shmFLLg16OiKxt6i4OiUs956TefVxrtJdJHVwCOEuq0iBT?=
 =?us-ascii?Q?97pSu+F1Tj2xmD2u0Q3Uq2i30AgWp16+x8xJpv95JCVaQSdn8kFnztHpbBWN?=
 =?us-ascii?Q?9DR28ytQwH7OTA/SWF1m/z9x9hVDd2buD01VDXw4R4IsekSiZnCdnpRl91ZA?=
 =?us-ascii?Q?0Y8ZJG/u9d4iwIQyyFEEZxAqkxmZeVLtwdGmhdUvhL0FXG2ZxwdZ2adcw0pc?=
 =?us-ascii?Q?FfBAtgacUfbvS54u0krztWVymzAgXiXulsKqEbI7Mt+QwzuduAdb0s1YAwq7?=
 =?us-ascii?Q?nUle4BoACLiizB2/mKl/s3A9+Pm5eTiIDtyDjijNAf/lIeycHSAq2v4soR0p?=
 =?us-ascii?Q?TbVFuHmT5SSeHgZtfxg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?We5fdxAjPwKfNJQ94c8fdLyim7zZz2TfXf/PBOK6oIqmBaxbayBM+y3CjqrM?=
 =?us-ascii?Q?stdDmPXUwWMSB6FW6+P9snfnbQ2fajt7OJL5JFGHsXy7pNKmOVV0ftUcSysw?=
 =?us-ascii?Q?m13W9mAXm7uCZheJ87WivcYJOBttgm93IAmPe74WhrxlAr4AN93h86rL9bvI?=
 =?us-ascii?Q?1DOZLiUCog6qD1dqM4hK6Ow6TiILwslTGof26rULflJnzZcE9Yt/2+DDgMne?=
 =?us-ascii?Q?vIxRMQZM3Q/NNvvWIHR32B1337uHzHpVysCcr3aPa6XcK6l0ibGREcxwaOBN?=
 =?us-ascii?Q?qc9yzEEsWlIDn6oxh/NLLgSpbjc2eg1z8YsQM3sD8fHqUE1f7TQt7KQIzVnj?=
 =?us-ascii?Q?BJ925tJuszJyZVA9dIOytu/Tt0ZHSfE2kM9ccPE/8M9Wte2uvfg1mLhV0ZOf?=
 =?us-ascii?Q?biXyZbQcNfMCcIx7DcsF7gu00tmVv2TUnQRlbrnLYMhYiLhop9f77PTgKxRE?=
 =?us-ascii?Q?ofdtT+o21mD+Aga5MkQHeCR4+h0AEq91hJE/Gh4LJzzxcK8lefFn5CeiREFZ?=
 =?us-ascii?Q?ygfxmWXQU9sNAho+TtUFGWOdHSeFzraQjtIUyUKoKxFB2yq20F9gRfrQve7M?=
 =?us-ascii?Q?KyXif8ILHqr5Ce5V6MEYQ8ZoHPMa5UKX+3PSTECL/pRV4wD92whw4A1fhGrc?=
 =?us-ascii?Q?ilV1jftJeH13QxNE548cP8Kpp1ESGJZwhxR0PDcXZ1VfYMqrdXzOVtZFVsRe?=
 =?us-ascii?Q?wvvq9jVVKBUVJ8ryk+WEhwLJARtH/7bb+ckpwMtmVS2LdKbdoN8w/WzY/yw1?=
 =?us-ascii?Q?qv3FKKWc4Pcgf1tQTDkdNM8q3rn4B7+uMxmz8xCGG4R4G8TdMt+F3YHbmD+a?=
 =?us-ascii?Q?++PblT2VBVOAJLc0XpXijKhrd6a1t4fRvbMx5G+jwuFkQ3TeIDVVt8zh3LTd?=
 =?us-ascii?Q?rsc8LROHOGHLcYCTd1yIgnaSowdt1pe48WMepL7QSWseL3U/wS+UtjYSPlj3?=
 =?us-ascii?Q?RibTPk5quCVWXhd10CnSrJ9YGJvMqwoOmsKNLp+LvZOv/XXlbsXDtzFvBEF2?=
 =?us-ascii?Q?t2zBT+G88HZi5MmgjxMDam6g5s9os8zbw5JF0fLKlxG/2GURj9N3fKzuJLOB?=
 =?us-ascii?Q?XUcHeSIVgDIwrneCK4A1CFbBf1S9Oa60P7rk9mBSPmU0Nl2wYt9/LfPLdst0?=
 =?us-ascii?Q?vxauX3P03pKoOpzR4+CCi+LlZHoHbes3QsMFgu6kLn/Xk3gaqEZ9bji2xzWw?=
 =?us-ascii?Q?J+VMmfYjLd4iig6k5ajLqNjczvzbnc6OCJxkSdPnFd5kgreuXkKGBim8i8IU?=
 =?us-ascii?Q?C1LgY6YcOQX82ETqMhsFSh1yAnwg6LJxkqprhRWn3SXKeVHMHqHHKqW/prKs?=
 =?us-ascii?Q?QvQL3zBHvHC0ijbL3CAdbawL0i6yIUrhoWa+hHraACvwIwc2PdNWtpy325dV?=
 =?us-ascii?Q?ozJIqH586YUqVWG+D3dC89NjxFM99+p8f8TMVnZjClyz7y/LoyfiXmwA9Mun?=
 =?us-ascii?Q?0r8erJQ2xkHu4b+GhqSZWp5Dk/+5w4Z1/sdal2AgQf++Rr0sHPRvScXkjBMV?=
 =?us-ascii?Q?fx8PwDNLF/Y0PTPxJwTXxWWIOdorzTQJbvcRw4KaOLEE/GpmaHVnVJAzDzA2?=
 =?us-ascii?Q?BrbizLKRdeHAx5TEtX13e52hxYRsK9sE8qVd/aXLmA/a1re/cpW/bfvz//Gs?=
 =?us-ascii?Q?NKSbqWIJ6x3NrkW4q0uzQmIiYvENBJGFDhEPBRWrjI7KGNkIhs/W9WWTyXr5?=
 =?us-ascii?Q?UBiy/DPZJrwfDJyHtkU8+pPNLWpq9vPyXFqrGWSFcIkYWkY4SvD1L76TOhKi?=
 =?us-ascii?Q?6/JvhgQtWjkhMnYElAmYlRXs2Yf7W54=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50402d09-87cc-46fd-b8b3-08de5422d9f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:42:59.6500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1vcdBs0zjEzaa56ZR+wRZRpHpOe/zO0DjVwqcCWY1Ry3nad76Fl97mr9kBUpx5Z02SG1khyQK9dK4RoaBZLi3/gWofd8ohhlVe+1hllXFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
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

On Thu, Jan 15, 2026 at 10:38:23AM +0000, Ciara Loftus wrote:
> Commit 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> disabled strict priority on all levels however it will work on all
> levels except for the root level. This commit re-enables configurability
> of priority on non-root levels.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_tm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
