Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D90CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C239402E7;
	Thu, 15 Oct 2026 16:45:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 93F5E4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075518; x=1823611518;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=PAcmlQ90WJ4tTSJuYYa8ZMkFJ45JUBiKLlGHZi56lTA=;
 b=Px1lcG/MXi1Dl5mEwnDcCH4H8bMNSRAAduOo6YJFtm3TlWXJLjp7WxEV
 3hKauHefE7E/m4MtVzU1hIDCfhS+oBshjdl4YUv4G3MYBIGk1YWSKN+PR
 1MYNf12wxdm/cDlH/uiIcsEYO207hLP9uFm8vAbCHOgw0QdA/C4+uGkcu
 TU0ey6DtNNHCcn7S1AxzGkLX+XMtNO/qS8aa1cK8xg73XNZbisOWvVKif
 2t3fzNhvs7LBxc//yr0OU1HthFjfVoqGRs4k29SqfM3ymeeuyP2uTTBUO
 qNI2J6JjaeYzmfszESvOFxNDLf80Hpa7v04U9W28Y2jlvcMymLzXeEphA w==;
X-CSE-ConnectionGUID: KGzu9rbXQdekxwhKH70Yfw==
X-CSE-MsgGUID: 82Zqeo1PTeuOJBIIujB9Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="734278"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="734278"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:45:17 -0700
X-CSE-ConnectionGUID: 4rWGKhTvT2SsfYrOzGEs/g==
X-CSE-MsgGUID: /6j63E3ETqaVSmE1/b925w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1640890"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:45:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:45:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:45:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBYfFP7JoCwfkMOLAqtUIYfBjgV69l5XUMElKMLnN0lthryhHoU2BioGth/fjgWnbRT+c0iqeUH+MWtcAVN/VXkNT/X1bm6lsp6RpgyN5sDn3qUU3RcQhWHvHWVL+RirAE8lmBeVChN5AhcqAuM9ttgRLhFYFGDt4R794M5yZPihHkAss/bgBbGRjJ64TmuLzrHT2W8J/a45kyhalgmggbCuyLnWR71NSZBxFYWaTatyYa4rE9h5zBMvdxMTApSMlGZUXV9cJ/egLHE5oIDVCq1qhpP13xcg2vhRQxsYxAevbhRh/Z64CbI72dOPi5n9mnBm4Al59D7EG/uyVfAmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlHGKQtv7jQhnvjrzWa/OB7+NvJ7RYF3d2k10bnBkF8=;
 b=eVXOrD6yBN2s2niJuNyM8DUjQWAdDmAKMdxBUoulyjkUx4r9Kfo33XjtjT2kW2x8i2Ej8DFt5mAa6MNZ6MVyccLmFR5f/aiOyugFvJhHf9jMs/+AL6ohPG1htS0sMJm4/HONGimq75h+/oeugIi5vZwI4I8fBu3wYL/0UJwNChvcLYNywsnbJ8gzcDCz0xkJx/Cye3BSiE2zNPTOowsCJk0n3y76UTw8ZNYFlXH9CxG8MNmYytZFU8Btk7AUOVfor7KW+jVih9PArj1+zg5ImfKxHkTX7g9gSKitX0X+RnrsULZlQltdf1JQheftCAyHT1VLOuNJZGMMuGfRmiu5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DS7PR11MB9497.namprd11.prod.outlook.com (2603:10b6:8:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:45:14 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:45:13 +0000
Message-ID: <9c7bd9fd-5db8-4011-877d-363cd54b985d@intel.com>
Date: Thu, 15 Oct 2026 15:45:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net/iavf: do not include private headers in testpmd
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Ciara Loftus
 <ciara.loftus@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
References: <1e05a203951906eb042fcf1010d2b120c85bb4d2.1792074055.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <1e05a203951906eb042fcf1010d2b120c85bb4d2.1792074055.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::25) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DS7PR11MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 666064e4-4d0a-447c-4fee-08df2acaebbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2hYlj/NnyKDMgvUaY8mJKVLIbmaWNgKRz+PN/GJZNC2xyS5PnwX3RylmSHDNC7jvltas64sAnTVFgYjaQThyXC5Es7Ge1ct+cZDPn9SDeT1aRsQljZzJF1omx8gHOAR2Hxq+bGVTvEkzrMwricWMLGiwGeaymEwDJlRb4DDMhZ+hMH15IOARAXtgfNjhUcUY7nvJ+1DR9opin+fmsd2q20Q2ufYZ8G4R9Fvacij++MepHHWbjyOeApHHPy3j/00UWHB4QzDkxc6960XLK2vgv70l2QImRNAlB8HVWbxxHMDhDoEiCUVCIS69Lhy1vHyo/W9sgyCOMnhT1/i0bWb4jKypoHPizxGprAeISdFtq9TOy+ao+PZNJRUiJMnP0Hen02KZt+wB2mA1/3x1ZuCLyXiKrYnkfUGlIbty25giIXGL2/SgAZXQ/JBkT3lrKTrfcO8ngXwMnuBSrWLmgcdXsNMbMD8Iuyp0EpNn40xC8sJJktYx+6bHQ2ra3GOVbMofEzsqEjOgH6WX5ezk5z034mlWp/2GAkdhzL3sx/nhLK+WA/2XOPZd9itA1dnpS2ALsI5HYlwqzZttX6x5kCvW9XxZw+RQciDddU4um1j+j/R+5ZKAvM26rW+T7Js72Y8TWiuB6UINYFZ7ixKiLTO9Our8TgsBSMbV41NZoa3La84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRtcUx3NUhzemhqRXU1c3FWTjlTbThHM1FVTHlCTk5IdkJsTHdjYVczMUdC?=
 =?utf-8?B?N0F3ci8xQ2dhMng5U0c5bGFIV2RsSEQwODZ1ajBnTGJEejVTMDhkdkNzajcw?=
 =?utf-8?B?UHlKUVhyc3ZEV1Q0dkpnNnNoNUhibVBNTWdnZGNaMGlZZTZKdGpoTlNpclFB?=
 =?utf-8?B?MWVvUVd6V2NMMEdueWo3b3FDU2s5Ti94V3BJaFZhMEJ5ZVl6eWprVEZZS09D?=
 =?utf-8?B?Z2JlV0FOWVZFVzZZS1VOUDhoVVRUcTBvKzMyMWVaemtKU21KWmx4K2lZRTJu?=
 =?utf-8?B?b0psS2NIOEJDckk1emx0d1FJT3A4anIva2Y4eVdtN3NnN3Z5WWZzbmNZY1Y2?=
 =?utf-8?B?NFI5TDQ2cHZjYUxuWkRCaGp5S3FDdDVmM2RRT21EaEg2SWkzZUhUYnNXdCtv?=
 =?utf-8?B?eWxYR0V6VU9qSm9tbkU1dnU1d012KzZqb0FBZkJuMFVaU2pkQWtpUmxIN0V2?=
 =?utf-8?B?ZHFETTFSVmpMR2lhOStBSnVyeTFsUjBQckNyL0ZnS3pGR0tCbUtkRU5mVE42?=
 =?utf-8?B?ckE2SFZqWjRMa2JEQlRMUmRDL0l4YUI4Wm9GWHAxRFdxcER1YXV0QzBUS0tS?=
 =?utf-8?B?RHBOYjdYOWZUdHo1VWpxSjg2d2dDMklDMU91UktXWDIxeUhVcHhldTdZNGYv?=
 =?utf-8?B?Vk9rK0l2SEtwM3FkaWIzUHV2c2x6VG5ZUWZQVDFTOG0zWEQyeG44YzU2VkFU?=
 =?utf-8?B?eDFxeUwrKzNaWTNIRFBzWm10R1Z2LzV1bEtNL2ZuRjRxKy9iczlYeExKS3Yw?=
 =?utf-8?B?OXVLNDFJVitMVDdnWG14cmcxd25vaGZ4QjUxSE1YaUdoV1hJaDFuRzIwcUx0?=
 =?utf-8?B?WldBNm5GelpUSUlRNzMxdmp0STNMYlN0T0FvWU5MTjZveXR6V2FEOUY3ckJT?=
 =?utf-8?B?elRPT0pzZmtlYkNMNWZjK0hOMEVGVkJoVEsxTjJxMDNwRnMzazREbkg5Nkgz?=
 =?utf-8?B?N1h3N1ZVdFFFVE9zTFdGbS9iWk5qWG10anhtOVl4R2FpWWV6ZkRHSDFybFlK?=
 =?utf-8?B?aTNTOHpObFpNeEZBL0lxeEF0TU5Rd1lkTkxPb04wR050dkltV25KQnQvdlgr?=
 =?utf-8?B?Z2xaaXRXRXYvUndIMERtS3dqeHJmSDZNbG1EeFRJMStyTVR3YUljdEFsZFRx?=
 =?utf-8?B?WENON3RhTFArdlgxL2daWHdraVVSdnRWWXUyYzB3b2JBaHhHMFNTVHVFZHl0?=
 =?utf-8?B?VFB0OUc4WFlHVU9zRGU4TUlQWWZnV0lEY2lLVkI4RFlpbjVkZUJCNVBtL0Ju?=
 =?utf-8?B?MWpUelNGSHM5TXhLUlhUZlF5Yi9ES2pGaVNENENOSVFuZm05em1OcndLODVK?=
 =?utf-8?B?eWhMQXFUTEhwc1VrSm9kZ0lKZmllWWwxdUJ4MzlWaUF3NWhhRlgyU1BUcXRQ?=
 =?utf-8?B?YURJR3NYWmJRaVNUSmExMDZaZGtPSXhxNXVKVEV0YmhqL0ZXSzc2bzVCUGNs?=
 =?utf-8?B?djl5SnNWVlJoQjhaL1RTVTR1UXRsaHNYUktNSUJHSG56QTcxeDZ6bjZqYk5y?=
 =?utf-8?B?bXJ3OTVPZDVHVVVEcnpSTWhXdWYyL1gxb2VIck5kKzVYZXZpUHMrWnRwbEhE?=
 =?utf-8?B?UU1LUE5sZlVwQy8zL1hYQjBiZjYrVEVmcEVzTENjUTJrUm9qVFhZdDFocDZv?=
 =?utf-8?B?a1VEd0dxcG5jSnFWbHRhZlQ1czdsSXd4ZThTTHJYMGtuQVhxek50Mm9UNFhT?=
 =?utf-8?B?alRVcTR6YXk2alVKYUxpZXFBN3l3N1JwanRoYm50blNXZDRFb2lXTHZmWml4?=
 =?utf-8?B?Z2U5MzQrOFo0T1ZGTGt2NjhPdEF3a1I1WTlEaFVvUUgzYjFqc2J1SVdYSzIz?=
 =?utf-8?B?ZGVtbGFVZ3ZIZDgyNlIxN250Vmg4ajRRdmUvaENJN1FPVUZPbm01SmZ0ZXZZ?=
 =?utf-8?B?RWJ0ZncweFI0WGxJS2Vxd2IzdTZ5Mm5uV0U2K2lpZ2hIbVc3ME1DOU1WeGFz?=
 =?utf-8?B?ZXRlNnMzWmwySmlacnlVWW53NUFNMnJzQVBDRzV3VW5oWkRkSkFSV2kvTnpk?=
 =?utf-8?B?bndZQk5Ob3Z6Q0VhMVlyRWk0L0M2ZDJub24wa3J1c0hIajg0OFNEMW43OEhs?=
 =?utf-8?B?SUVaeWZKSm1Hb1d2SGtualJ0K2lXaHpTRk5uT0FDVG9oYWIxVlhxYlcxSENS?=
 =?utf-8?B?N1pObkd6MjQzUi9kREM5RGtsL1pmMzhZL3JCTEpUNElXMG5mc1BIL2o2WDhE?=
 =?utf-8?B?SUozem4vbHduWHpCWS9XNUNvdEhFenNvQUl5M00rL3BTWDJTQmp0QnV4UWs5?=
 =?utf-8?B?SkFxTCt1Y0syYm4rWGdxRE5ZdUJYelZ1MXRVUkNxeXRLWHp2V25SS0NyUDdq?=
 =?utf-8?B?SDh1YkdkTUpTOURDUnBMOHlUdjI2cEloS1NOY3Q1M1dqT1lHbjlMUE9DZWlG?=
 =?utf-8?Q?hK8xFuVU59PX0uEs=3D?=
X-Exchange-RoutingPolicyChecked: Dv9F0BVUIwBxoAie4V5fgJKEtzqrt7G+1nmT6a444xTqcZBeOWCdG2p+Sm+QB9PKZ36IKvMK0QMDzdiCifaHPNEbYD4hCrlkFisii/Vba6MNRKe+DLqdz3uA0jkvjzngu8+eIrusIxwcKmRm4lF0Zn+Kr1A6QkZ/465yzcJ9QhPlWn8eGScTdGMxlQsq91NiFR/wFe8lIbKMKa1GJRltrLc04cGbv0nZwc3pCgHG8fEWHB/VrhNitfr32dWFHaJiMLgfBK77q6SgHC5xbCjLNcqDwjsx8WSi6q+/zu8ICGd8bgZu9k+eCAMpdjlt8nHbtm1HSS8QwZyP/CDv4aoBmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 666064e4-4d0a-447c-4fee-08df2acaebbe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:45:13.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDVQWmogwm828IpQoYlbEvqOzRgHOUAqN4KiWZtN5VseZI/Nl0+zUq1WkV4zp6RRr/1ZCG/d1i0I3Y4NAlLbIwFGzb9zRIoCLFxdJtAry1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9497
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/15/2026 3:21 PM, Anatoly Burakov wrote:
> Currently, the `iavf_testpmd.c` file includes headers that are only
> available to driver itself, but should not be available to applications,
> including testpmd.
>
> Fix the testpmd file to not include private headers (they are unused).
>
> Fixes: c702044ed909 ("net/iavf: remove Tx LLDP dynfield method")
> Cc: ciara.loftus@intel.com
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_testpmd.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
> index f3b932da04..1146f534e3 100644
> --- a/drivers/net/intel/iavf/iavf_testpmd.c
> +++ b/drivers/net/intel/iavf/iavf_testpmd.c
> @@ -9,9 +9,7 @@
>   #include <cmdline_parse_num.h>
>   #include <cmdline_parse_string.h>
>   
> -#include "iavf.h"
>   #include "testpmd.h"
> -#include "iavf_rxtx.h"
>   
>   struct cmd_reinit_result {
>   	cmdline_fixed_string_t port;

-- 
Regards,
Vladimir

