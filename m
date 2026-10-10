Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E72CCA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB0340274;
	Sat, 10 Oct 2026 20:29:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3B3354026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791656951; x=1823192951;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=mxw6HkGANFhxSeVW2OmSV3wa018msJ1Jtj5SjboMJfU=;
 b=oJM7/Ma7KTTmOTtLQmf0OyQRMS/J8zb8iHMw7ezoV6SV3216xGNmYoAu
 JS1cBqLzb2peezEikOhlgD3s0dvEXQ/x+RoevsXNfFXMdHNFq0MvbEU5Q
 psSQUEWKBbWQ3BiBoiQO1zXgzDLk4kGG2VLnwLkhJvL7i2rGgYylELbx5
 AtG1FALux4/OgjLedqilPeG1rc1RmM+6XBdFHx4Sl3vdExZN04SSRgRMy
 MmoLlTCSOkgKgjbsEWfrIQUJENXCBzH70msg6fgKtO4VDOkKIxIFA0thy
 JLva9xpVNda+7ze4eyvEjC9oyZSB/GvgxXpDsXEn0JwMcNWYiJFcP8ISV g==;
X-CSE-ConnectionGUID: JWywVCvDQfiJAu/cZ3O8wQ==
X-CSE-MsgGUID: TSkjbNk1QTeWBuTNyInCRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="304914"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="304914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:29:10 -0700
X-CSE-ConnectionGUID: VCxRtVWLTfGgYHtfeuTQAA==
X-CSE-MsgGUID: 3iua0SBaTKiLc9zSPekLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="541603"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:29:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:29:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:29:05 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:29:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPN35cVzraEf5kmBGJ2N7I8jk9A2zzN9CBkMhbcP8P6EGge+VE5Ya3ghekYFEhOPqVSISv/YhpJlG6a7BdrgveGm/D0QVUtvPb1si2Li6k+1dDTOL0L0Sb8G38l/jyTjHeRnQ6vaur4/6vHRWm28yxxzwv8zdKmF3VbmoiNLoXkKGyKrp6h/84MG3//kGMIyGFAeXo7vOvmt161Q0WlmRYslqdl66/lo7SP/iK32gin9H/FxnZTzHx0qA6sB0urvFxyNnEZ7NVhIUi8PaP4QZx3Ntd50uwoDPv+NWZxIJuBpHC1/24GPjHgcewLZWA7TJKNAIiK9kkp72QfMhaBFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voPXBkrhSp/wcws4vC2yL/iVeh+pCxx/hAp2CQTdFQg=;
 b=DhyQAHdvPERsYPRLpSNnrELe5I1efLQd/GlQCUcSOOhMLvLr65nuDeWRAmD0ZGW41zomtku+Blb6sXDMq+f/cxMwGHnekyq7bLyvqIFzzfyL6+Nk2KnM1WkKllKU0vUjw3ogEiwKmxszYdKKu47wJ4RrRzdtzeopiI90p8L/XfNG4hfDEpfv9+OoLjbIpUS/BAeX4eILP2T/d5bGQjQ6n8+IU2H2LBAEWR7UzimfNY0/byp4X4RxTAvZZqRM1ZlODEV8DYvDWdZPI4C4cohvXRp0tPR8JCKnseX8OfZmKKvFD3FCXZD2ep+DlvF0LSHeF6Om8SHol5Lv3oUrLqx8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:28:52 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:28:52 +0000
Message-ID: <431527ee-ff6e-4786-894c-bd5c6803a679@intel.com>
Date: Sat, 10 Oct 2026 19:28:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/25] net/intel/common: add utility functions
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <2f52da8f93664b3267f998c0df061f35df456151.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <2f52da8f93664b3267f998c0df061f35df456151.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::8) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 514ade7c-9690-4dc3-4d11-08df26fc557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VVYFRuhRCV/lkshKeYn8P68YceCtMLjr/kYaucvWfqujfcrjyWwqgabZzVoeZPqEfw+kQHciqVSz4GvUf/ns3V6xukFcVwvd3IAYjMR8bXh3PMFKo554Gj99Wdh6bWcuKEVSM8OG1xoFTI+FIyGEmgDpxPCaMescX65wOOP1MtlVnR6JInQL0Nwqin0ZH4oFZl+EIQhRKFiEA17W0mxVSoCoRuHqifMzKrS5gP+1JCsvLjVFkik6PDWd0fHNJDyE8iKVlcLnj/AsQgnlSmUZkkeF/7UxOnbZrPmZ1ar4ob8MuHTLrY5HpzDY3B34HLBWC8cpFNNwm9UgyGaut93kIZoxZmfkn4EwcavE1sR0uMDMpbHpaMDuvZLt++CAZutMi7Koqm4BHZ8VQ+GapSRUOmPgHet8uMlda6PRqnKLnbbReX7dSVs38BRnkepBFfvBPdIzT5CvlJDdWN5e07oavPc/ICoJjlM27JrZnWQ/mPcv2gzyCIDsyodH+noeKiwsVimhTufPvlHSv7tuhbjUTiM1Au0nLp1VHEqsRJT9ANHog5COJ4LpvPv6vVILhvRGcnSVbs6/dGV+cctg5bZ3tH3CSXE/Pfd3/kKtjp2txU7a6TSdq2Pl2tdkynr2Fr4PyYumHP3deTXdMOzzs+zZJ37hBpydU3bAe6E5rWbcqd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5GYkpCYlVpc0t6RWREckRxL0Z2ZjVGRVFZSlBDSVVZeG9ZeDRrUGN0cnFj?=
 =?utf-8?B?d2dqMFVKOXBPMFdORlpOaWw4bkQvTS9nZHJiMTRraGtLL2R2ZFhkQWRqS1hz?=
 =?utf-8?B?TGkwcjV3QzJNWUV0Q1JGL29rck1uV1JPWmZ4Q2VDbzFPK2pQUndZWDlHb0tz?=
 =?utf-8?B?ZlFCeW5hRllQbUVnM3E5RnovaGg2eUtjOHBPRjdVbHp4UFBPQTlkTU5xbG4y?=
 =?utf-8?B?SWYrVWFEUDZCbmZ5NnBoNTF5d2F0VFlkNkQ5bGFxcDZ3SlYwOFVCOXRZcEN2?=
 =?utf-8?B?U1hFcXpxZG54bkdJZ1BPMTlkc3ZLSUFKQkg4MGJXd05LOU1pLzBZZVlDSUV4?=
 =?utf-8?B?dW54Rmt1aWZieEVXcVAwSzRMb2RQcE4vUnRFWlQ2TitVYXdhV094ejB3Q1Iv?=
 =?utf-8?B?UU5jT0tHY3NKeGliNmR2bEVLWFNoQTVBaWEydzlodjlIUTFMdVdPcVVqVXhj?=
 =?utf-8?B?WW0vckNlaFJ2eUhiUzd6a2t0MVdIUWl3QVhGVzNEb2ZrVWxqMXFiUDBXTGRz?=
 =?utf-8?B?TWlGU0YxU29wNGtUVmtEUWd4Nm5GeDY2WEwrUkZvblFpMjR5VVYzblZVOGg3?=
 =?utf-8?B?L05tSG1nNVBmd25uQnE1UVdueUh1V2piR3RLMHh5cmF5bmQrWjVvSzU5RThB?=
 =?utf-8?B?T3o2RWZCUUJVZXM3eVJCa0FYM0lKeW9uN2dQaHZzQ2UvRHF5WDA3VzdYcm1y?=
 =?utf-8?B?L3ZBbHVpUVBsK2UrN0R3cGNlWlYvYVpsMUd3QjBpcVJ2Q0c5SXo2MXUvM2F0?=
 =?utf-8?B?YWR3c0t0RXlJRWRWdkJLZm4yRWJnd2JZdi9hK3N1dkdaWkljZExMUXlYb2Zm?=
 =?utf-8?B?Ti9PNE1DZ1UxYVhPRll5MHlkVHEwZll0c1E1MHJPT1MyODFJOTFnL2F1c1NV?=
 =?utf-8?B?ZGlwbTF5SWxEdys4bnhvOGFYY1ozRmI5TmNSMWtkdnU3U05TYkFuSC8vT25E?=
 =?utf-8?B?cTJRMXVmbWtGM2thSzFZTFVrTFVwcDhDSnhZZFRZZmtka3ZhdFVBa0JSQlRL?=
 =?utf-8?B?ckkxalFCZXNieDErcFZPbkxWYW9CKzZiZkNnaGdManhtYk9JZWpHWllvZWRR?=
 =?utf-8?B?ai8wd0w3UUVTbS9QMkFzK3lkeE9iejMwMVZpK3JpNDFpWm9nNHlWdDVpQ3kx?=
 =?utf-8?B?dkpad1A2L2RQWCsrZUdaRXJ6K3FuV1FvMkg5RUk1Mm9GWmNXUjJWRzFBRzBL?=
 =?utf-8?B?djhQQnNaMzR1NXZOczNBdmxtYVBqZ1RaMXlPWGw0Y2dZNjFoZVk4cTYxelBo?=
 =?utf-8?B?TXQ0R2hGWVZqaWR5WlV4OG5VcDU3L3kydWptWmdNaEx2VFFNK0tnRG13SFh5?=
 =?utf-8?B?ZG9wc0t0ZFJHdUxoQW1BZzJWSG04S09CZHB1WFhaSGhYb0c2cWZWYWJKRHFo?=
 =?utf-8?B?cWh4d3dWQVc2azZ5SE9VRTducko2L21Tc010TzNVWVZTbnNaRDBiY3dDSUdT?=
 =?utf-8?B?QUgzekw3WEV4aU01TUVlVTRCMGc5QnVpU1Y5M0RVVXZ2aVV5ZWZPVDQ1SE11?=
 =?utf-8?B?Wndzd0owem8wL3c3TUxvRnhiTFlFNVcxMmdSU1l1enk0WFBkbHVWOTBtQm16?=
 =?utf-8?B?S0pRMXUrV1hsNSsvTHhHTEFjbENKUWRqWDhLUkhucmZwQUJwcjZyUVVxYnQw?=
 =?utf-8?B?Q1JGWGFKOThlMlBpMklIWktrbGdxWC9ocjh3UnBBdDA1R3Z1dmE3bERGdGd2?=
 =?utf-8?B?ZlBDcVVpdVBzK0o5dG9sU0tnMU1pcnRzQ1hkMmQ4eFNUMXpWcjFSTExueEFD?=
 =?utf-8?B?MGY0Rm04dm52SldVVjNaWU4wWFc3TXc1cU5wSUNYWWZUWDRBMEc5RXZzc3hK?=
 =?utf-8?B?VnBtbkZjaEkxTkRTblFDV1cxN0hPWHJ1VUZEcWdEWlFVWFBtTzVOd0hqZCti?=
 =?utf-8?B?VGdwSkt3ME1CUCthNTFxeUlSR1g4eHBSUzNSTHo0Y0x2eENSZm5vbEZKVktY?=
 =?utf-8?B?UTZOaFpXTC9ZcmFPQXhudnpLV0Y3QjJzd0FScS9mYjRERnZISUlyK1p6ekhv?=
 =?utf-8?B?a1dYcndkQW1yM2dWRmc4bkplSmhtU0UyUVlUbXV4UjdENG55UEVhYnJjVnp1?=
 =?utf-8?B?aTNoNVRiWnk5aFllNjV3QnFVdUVmeTAxU0NwVHZyejRsRFZZM2pqSFNqVUV0?=
 =?utf-8?B?azQxOEVzTDl4OEI1T1ErbEFzWjRTTnhxMlBISUxRZWJjL05PaklUem9nV1k1?=
 =?utf-8?B?RVNySU5CMkZiVDNXTTczek91TGpDTUxhSjhwUk1xbDhiVFFlTFZoWVg3NGRD?=
 =?utf-8?B?ajBPV3lVUkNnalh2ZzNsZndYUTVUM3VKSVlacEtCODNHeDdLbDl6TGVOTUYw?=
 =?utf-8?B?REVuWHJZbHVMc3NraEw1MHVabGhWTkxwZVg3UEZVS2dZUENuQ2JzY28vOElj?=
 =?utf-8?Q?5unSO0oLj4MWQbSo=3D?=
X-Exchange-RoutingPolicyChecked: j9FbayPz7TyybZMVLtfHgvbvGYajBjIRlzxly6WFH3xqMW3ptfy/8HyjePLbxsUM3LMqBJk5k7Xkya1iZYQqnqHAAnRtYccRdHS9EnzLjuNbLyxThWX3NeHOjn4FLhwwexEzksmh4AhorCdmwLVwGX4mMo957FDRtPZ25B7KV9HA8RdbtWvaJF6PGuPIPM0ufmI8o3E9RDvWpeeyhQ5oMqnvAhxsbCDMMqYiBcwO9pQT4ZpFxaOi1OSXgrDUQzxIhUVmTDbLcrwxPgUTSlMefoa3wzDCRrFuGncN5AwIQ0i3m2KR5s6Db6TEOURtQvLwopkzxcmh0awlNOpHmEJdZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 514ade7c-9690-4dc3-4d11-08df26fc557c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:28:51.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1e+GB9zq8+pQDStgqvLSpVAsv4/Dj834ZhdB+n1ziPoK9l/QSUomj5BiVDiNCE5ONjHGIfEC5L5TIi404YDezWkhmDQWcHWKbamnzXFmbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> A lot of parsers will rely on doing the same things over and over, so
> create a header with utility functions to aid in writing parsers.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

