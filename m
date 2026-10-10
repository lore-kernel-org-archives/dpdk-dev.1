Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001FCA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:39:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39CEA40A73;
	Sat, 10 Oct 2026 20:39:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 18706400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657557; x=1823193557;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=s05sOsnL0wOFRJh0Jp9WZPn5iK8rYMKWzAp0Ps3DgPk=;
 b=URR9nj0eHnKA3JPvgDJudzlw5ANoYwxUKtOTqInn4Upnpuu79TziZDHd
 RSqLzeEgCUbPwPeqIscXBCDSFv8l2bG8mOKkAVBkajzP6+PU3eKhiteXX
 b47z5Xvv80cn8u9b4lpTjJH5Prl65AxmbGM2cLHGGXIN1o3Pu3z4BzJ6P
 5BOSeXvPt8xgY2E/CwjCNaD2XuU+LSN43/u61mRCIws65hb0rVOE1abZA
 9MGio9vAschhsov+mxwk729fsNaWYZzDSd73PZuiySqJeDs9xS3YlJfgC
 8bFQ2G5LW64XdZnnxlRv5swRU2Q/fydq6OhjDt8fYtZRO3qnUlyspn49G g==;
X-CSE-ConnectionGUID: vh5o8FfSRiSRbYl06/PC2A==
X-CSE-MsgGUID: huXJ6qjnR5SnYdvLqKJPOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="435015"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="435015"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:16 -0700
X-CSE-ConnectionGUID: /zM4EaBNRZ+d81nSbeMiNQ==
X-CSE-MsgGUID: 21AM8MNvQZusILfvq4uqOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="877851"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:39:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPJd0ySp26qu8Md5dsn3CSykLMzff3iBr7fp1RO/OhjkyI0VhhvqemX9af6K43Ww/puExzeJ7fjsysI1xFI778HbFPvVoizwVB2Ah+zbeP+wq/2SmlZzXGQBjgt+ysjfE0YThxPCeEXZp5c/tXh5uVwACP7+IaYk51U+Tan7FXG//nPf34RgHhUf8HeUgUYHM/3EJzR9qWkUigpD40zdmgFK1rcFef4quWzkc2vj23LPfjYJ0tC8pQboCwmSwL26iDxfWA2OZVLaPdvzA2fg43Qqn0O3G0jOWjFFnaEcnJx0/yduBL3MgKM0AKIvWQ1u42kUPM3kYh51HPIeIVJsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBTVscssDWNtVsVkw7a7Gc0IVS0Po9twXg4BXyyQplg=;
 b=AKqJ8N20EaJs0AeCQtmb7MZOQ7G0Vl/nVqY/+49/bXkQfEAaS0/WrRmV/8uWcixmOU3szFcx1HUWLl0Rpdzw2ObfpWZlUijGL+DylITP+C7yCb7Y6+4axPsx/VGFkFoGzskG8Ied05hwG+FyxDBRnf/r6bcssautJOevc7qNJxPJhbQlZuzrzJ9cvEv5K6JoRdkU9VYo/fUAhc/Yn8r0U1e6hF9e3d7qhVyEiqu1C3ruL5QGLdI+c17hVECS1EttSvpoMVOGcAXnpEY6+iCac3KXSoLEvngmfFO/EDswEgM/Ca9JADbQTKox7QBc9hoIAiBpCUvhUl2gChm9rCX1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:39:12 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:39:12 +0000
Message-ID: <993e5903-1942-4a8c-aef5-a15b1c9f826f@intel.com>
Date: Sat, 10 Oct 2026 19:39:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/25] net/ixgbe: don't embed RSS conf in filter structs
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <5d52c8303e69b79d41ff41d2e1a0d932e62cd552.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <5d52c8303e69b79d41ff41d2e1a0d932e62cd552.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::17) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7a9749-d6a0-450b-7792-08df26fdc756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: Z+w7J6u+9GwELQcSCwUo2XmIvLXaYbm0DPje/j/EIwPSLQyeBaSbwKHLjmwTykTvJGvZJoQY6VtngdEHeI2/lAHh/MhgAbC1rKAXVermORsseBhkClBwnxfngBbNa4a2S0bq3Z61kC1wCclCFybTs77hjJIKga2h9K9rmOHKngKt96MIO8AJImJyQ3jV47Hfj4r+jWSrFEXAxqONbeI2eF1aZFFSwffEVAQqEgvSOOpBWR1ChFwvpA0+eOHEZiBpd23pMXUrp7WL4yPy2MWqYtVCbuMOjVxfjzLWZp39VSoPkK3WHc+19sloj2TSDWv9Wzx8Er7F+pNBmpXq2X4THOHVT+yku+tkyBTzt6ef9iR/oS3QkK57bc+idUnfHhSLGBsz6s7bmC9WaKwNoSIqfaupB1s1owU8hgEPtZFyGd6dFaMjLQal9tAUVKX+TAxZIrWq3MB1BStpUxQRIpq7AghgKjc3cY8pGdH8X9lS9nZIMm99sCymXGKwMtCO5zmYn4smi1QMoPmHgV1C67zZvxcSR9QxrPOJJY6p0J7hFYpwIZYIbJaDjzpSyrEnKqsprvXHhIiIO5ri5p5pK6bxIPQnIytMxevdhjxsjFruaUKHQJNDCZgq49Vvw48aIPi6TPBZpQO0LROqeMNjVxk7IIJ/1EG59xdMG210uQYUSHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRsejhMRHZZREZQb3FNWjVrL1ByNTZJYXV0Y3hyVG5nZTdtaUhyMFlIcFZL?=
 =?utf-8?B?UWErYnorRjVQWmJKM1liQXloYUJWVURFb3JOdWtRSmsyV3lOS0tOeHh6dmZH?=
 =?utf-8?B?WnI4NC85d0czRWlCc3UzQjh2ZG9kUFBQOTkyNEVNSlV0QXdXc1AzVGd6T3RU?=
 =?utf-8?B?R3VUT2tXdVEwYmk1NmZ3M3E4ZFZ3c0EycDFxMzRHOE1vRk1FTDAvL3Jpdktr?=
 =?utf-8?B?TUV3SW1DTTNieVRLZHpZZ25RdXBKVEdpUWFGUXpkOFM0TFNsTmc0SzNDK3d6?=
 =?utf-8?B?L2hnbElTb21ja3oycGgwdW1nTHBmWEI1ZE54VStacTdVaHNHaWUvV3VCR3BM?=
 =?utf-8?B?Q2RtaTRqdVA2MG9QaWJoU3lxT2psMWlUcTVPMTZySVI1VEdobFEvTE9paXJz?=
 =?utf-8?B?SjZPNGF5OXBLSHlHdFd0MDI3WTlGQVFoN2hQelVKeUNXa09OdU5CdXJFNkZM?=
 =?utf-8?B?dmVBR2xxWE8wNm00TTlRSDFyMHQyZ0hPa3JmdCt1T0FnS0I3V2JWcTJibU13?=
 =?utf-8?B?d1Y3QXp1RWVFOWY5TTZLekUxRm1VaFhSVDI4Yzg4U1RYTm9KQm1OTEpUM1pN?=
 =?utf-8?B?M094MldvcXRFa2k3MHhHUiswMmFoLy95bDhWaEo4Ymw2c3dXZ2FTcnZWSDJh?=
 =?utf-8?B?cHZiNWtRTlhCaXZjNnUvQUJTNWRObVBlYzBWK2dnT1ZvUnFwZUp0TklhZHI4?=
 =?utf-8?B?S0tUZXo0V3h6b29sSDBBVXMwV0lKbnEvcEtXNldhUjV5Yk94UHZNQ1Y0VVZn?=
 =?utf-8?B?cG9tSkNicThRSnV3MzFKTkhWQ1VIY3NGUnZKQ0VXcitmbTQ5Qm5mdXRIVll1?=
 =?utf-8?B?QnB0MFhBUS9XNGQ1T3NZOTQ5YUJlZktnQnpqVG42VjVObXdKQVp1aUdOZUQ1?=
 =?utf-8?B?NThKMTBqQS9ta285RSt5dEVob0plVGU3TUVhR1Y2OFJUdjhvNEZzMmRYNlFm?=
 =?utf-8?B?b2FGeCtWTmlmUFFwSDJUQUZiZ2wvTUZkbXRQbXpNeHVpYUVkeWp1cm5HV2R4?=
 =?utf-8?B?QjBmV01LTVdrN1JkaHhwaVVxYkJpaDd5ZDdRSHU2b1ZCK284OWVQSmJkMEVk?=
 =?utf-8?B?L0x1dXBYMnBnVGNCNzZVNHBKVEJIM1drdDhXN0JKZG02NFFpWWtTcU05OWJ3?=
 =?utf-8?B?KytMNWExWGV1SDlVYUZPTHR1YW1lNitxOVRQSVdCeUtobFFWdlE5eFYwNGF2?=
 =?utf-8?B?RXFVR2FvaUlFVW81cm12a1BzN0xycVhmM2pFaGN3bE5SL0lBUmJLcldERytq?=
 =?utf-8?B?bHVOcE01aEFHKzBxb2pQcEpySWFhVWsxdWZ5ZDZna244c3JYalNBS0JzUHJo?=
 =?utf-8?B?bzdRR3l6VFBPWktUTlFFOUNxYU5ObHVDeXl5ZjMvZEpLQmdkWkN5dGtaUXRy?=
 =?utf-8?B?NStIdFZ5ZU1oWHNFSmg1RVozQi9KN2M5NHZjaHp6YWo0QXlYTm00eWhaZHV0?=
 =?utf-8?B?bmZEU1d1dUdXMWYxVllVRktjR21jQ3ZrdlRyOW5DaExBYzhCcDJya1ZpK2VK?=
 =?utf-8?B?aC8rY1ZWSHNTVlFmaFUxMnZEa0cvWmxZTE1UU2M1cmwvWE1ETXpuWWg2Q3Bk?=
 =?utf-8?B?b2lHUlBTNUptTkNCTHVMZnBiZVJuTEdtMk4ybmZtSDZRZXp6OHc2UHU3dEtG?=
 =?utf-8?B?YWxvenBPVzh3eUhReXhFbEtoalpRS2N0RUZ0Snc4RXl3SEw4dlhXUElFMzlC?=
 =?utf-8?B?UGpmblQwK0cyUW9kdGlCY2tSb1YwakhlcEpjNkFyclVuejJmVXQzU3d5V0NJ?=
 =?utf-8?B?NTFSS3c5OWdEQUVPbHhYUDdHSmpXSk5JM2VSdFNoK0M0UWcydWJ3K1dpR00r?=
 =?utf-8?B?dUo5YlZnWk90NVIzRXpsVmkxaEVKd1pSMTVkT2N5ZXpReDZWN0YzSHFFU0N3?=
 =?utf-8?B?dHdhRmh0aXNZY2U4OHV0ZFM4dkxyUHB4VXRJYTZibWhTeWlzRnRwMS9EVGNO?=
 =?utf-8?B?SktkSG1ZWFowbFhjYnorRVZUV3BCWW4vekc5Um1vK1JlNFp6UFNqdFhCa25M?=
 =?utf-8?B?Tk84TU0zSVJ5cUZxVEVYdVQ3ak9xZDE3ZnpQK0JNVmx2SGZWUVIrREcrazhs?=
 =?utf-8?B?azRqVXNaRlVWU3pOZXdBeDhaVTdsTUd4c2szLzZIbTBFWUIxeXdldEdmR0xG?=
 =?utf-8?B?ZytlbjFlbGpVS0tDcFhoOXhDSXhHc2l3Mit2cTRUZHhaQ2hrQUljT0ZPS0s4?=
 =?utf-8?B?SExCbzQ4c3kwSEsybWlvNVh1K1A5VHd5RjUxZWlRR2c1SkFjYUZXZStwTFd1?=
 =?utf-8?B?Y0JiZWo2LzVLdWJjVXN5TC9iWmNCVzVRRmhMU3JUMkVEeUFMM3huWlZmS3Nx?=
 =?utf-8?B?ZEdSa1lTUnJhSnliZjFQQnBONzhzV3BibXM3T25jejVMZXZXeGE1bE96elBX?=
 =?utf-8?Q?eB/JEdtscxwa4ycE=3D?=
X-Exchange-RoutingPolicyChecked: dp8/YHh8CTncj9nQ3yGdR4CLfxiE4XrXs+90E5iVd+wWs0TzvCSiH/6Bdr3yBw1MubSAnFQXBd6x3zzfxbLl+2vvZ5rBxGoRhWJjyK0p9VnZjOUjXfhG0be4M1LbJynn3PzwuIRh0NU3DRyIweBDFRpBq+NQ19X9GkjL6YxQqrgkVaWfDJgvotxHtOyxInyYJHlCue5nJxw+01k3FOpGCW9LaWdSD30Cg7kyb0+rK1VSQBnfg20edzVZ6IDnDS603XfYXOr39LC+tuWIv/apXbJQKQjlZJ7H1PRaqXi1Px5qJkQK1w+VMdzG5QSDF2EX/tEIGRSMsaSOCeXp0khaPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7a9749-d6a0-450b-7792-08df26fdc756
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:39:12.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYii5vtq9bg2KLx04MjzaLMNoid+WV/irrme2/QXLnLuDf+yGx7VKW1xkbbhLWt2uU0xpEiU/4l6ajLgzytc29ickMdCd0cL2RywlllnvKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Currently, the RSS configuration driver structure directly embeds rte_flow
> RSS configuration item, which makes it so 1) the structure actually has
> duplicate data (or, to be more precise, a local copy of data pointed to by
> the RSS conf), and 2) direct struct assignments don't work because the RSS
> conf contains pointers.
>
> Fix the structure to not embed RSS conf, and instead just store the data
> directly, so that we can perform struct assignments without any problems
> with poiinters.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

