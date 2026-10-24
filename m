Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027F606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mNXLhzgK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EAFF40275;
	Sat, 24 Oct 2026 16:11:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id E3DC340275
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792851111; x=1824387111;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=88MJOGGHrsyWHJ1b7V00OVfnMq/YMCsKYoWDE2vlhKM=;
 b=mNXLhzgKdNIxWTtS+3RsS2vsciFbcHQnDM8BEY/JH5hXelXtqm1dBdyH
 gOLERSgiOKD1/T0/egmiOsgjvd3yZyGeLguGeG8NLTTykzpcPzOc1f/dA
 m6FgDzUnmlZWfd7g3OkpjX7lQGCSCy+UJU9oCSynqp5MO9Oex8OlpuWTb
 WuyO1AIEyCFq30D2HDs2G+r65ymnmNC90kKLUP+9kTG1R7zGa3L03uPw0
 1EGQlZOBdOhRqnmrryvdYbn6VY+UOKU9cpQGmVenyMDtMtFf04f4D+kce
 9HOLgtRNAk9O1e8pwZloBQ6hHYukk56WQeoBBFDdWsMe2apbQvBBusQcG g==;
X-CSE-ConnectionGUID: hVGG9VJ8TJ62RU9fNn9qjQ==
X-CSE-MsgGUID: yUwh+IXZSP+JjcqhQqAg+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1473505"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1473505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:11:50 -0700
X-CSE-ConnectionGUID: J20CpwZGT0KHoVv/cWG+jg==
X-CSE-MsgGUID: JWZssqEnR9C0XVPiW9OVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4218921"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:11:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:11:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 24 Oct 2026 07:11:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3d+Q/aUbSwlcPb6XuuBO9frwJveR9hOsmL2aY+2a8Esq2nqg++6NpVN8nJlhp5khuwPRGWvxYh5HOPZTnSyh30wzKWsYjEodKODThGHBnYL9cbQ678A+xJ5gYH9OuZSx7TagXAdRtPQaNtfvEfMysmyOdNiU2Z0PU2d3bU+rf6/Gcs0XX/2cFp0JI2zdaNc3Mbm3EN1S4m9LpThrxsvH3EzLcjr7CcGmEYChREyc7C3TJWPZ9V7asNgXNTVK34oQK8U4/+5THGrLvP5q+6/EM1Jk4NqT/y6Tj4jUgaMX8e0m/G98K066u50KfYoi4n+4IFjTnh+0TAJTw9K9AzcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWA6HESIKRKo6ISGkYOzPgzLpVuN5iKlo9wyZRj3syk=;
 b=a5lb0k4sDGFEHwMN50EQ3bjKbN4v88k7dxLCVwTyy2BmBK7uuoJZTMKbo/h5kPJK+peEGkiwk+vzzf5thTBqrzFlB7jPlcUjprs4VK3Ba2UhyfXS0OFYN6OIiP/R6TnRQp2FPo/3H7tyWzltweKOTLhm3jYt5Ss5hZzqoeOePUSnS2z+JbTVE2KcS1j9tZPoBIPCDajHSLWl1rqeHg8pmZHN75l1zDFz+vOD1cRbJHuYELViT/gXj8cB3HlzMC9J77Aa0cCB0o7bgp5Q24QYDPIQm5Un0+nLDTMGZr/zLg+3mdu5qJWyDQN5lNVWKxx+kELE3DnrkwBQPbCAXgUzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 14:11:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0546.017; Sat, 24 Oct 2026
 14:11:46 +0000
Message-ID: <66ae756f-042f-4c76-a1dd-639338271476@intel.com>
Date: Sat, 24 Oct 2026 16:11:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] bus/pci: reset VFIO device FD after release
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <hkalra@marvell.com>, Chenbo Xia
 <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Thomas Monjalon
 <thomas@monjalon.net>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
 <20261024132138.7239-5-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261024132138.7239-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0250.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: c5305044-3ad7-43db-c148-08df31d8bd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ULHVyVQqAWYMuLd8nQXRpxGcxPXArCPG2eag07wO7j7LOBG2yvpc25fXnGiBbEQhjWCc7FShIMx7qjM7DgmERPVu502XwdD4/52c6Qp6arfDy7OXiliRupN4SJjWXNyIBfsjrXQLFfUED0C+dSYc7vltDd19/lD6/WRsU5nHlQsBw5xZ6bqjIJIeMNcyMVPNFh/2BP6T9cvVmUSyrvMoKhl1oKTKm1LL8oyIbEsR5PA6LfHKQuPi9zUc9rCCoChVRrCg14fWvJnZXTTT6BLEItnY4OE6iKiUWTmVm7gT3zXm6lpZHR/kLsdSlyOro6OAs2j661gus4EjpcGyc3egyXZxo4tV8bbgKXmfo2kyr0tKexskAKysu+Hh4nb4yCG2zri9o5H/JS6EPnLrJjaVbtrrRb9Qf3DGox+yRK2gvrHW7Dz05yTor/m5TpHtGXsqddmrvjxCJwG+kKg0Sdx8KYIhrod1YDI2KZDLKkMBfPkLqkBbo3BGgissgQgmK2u8I2X6efq/E8ICFyaWS3CQyyJ0Px2sv4PAH1MI703VaEU6aVUR36IuiRfW98QEHBEYDOh4qH5Mbk65r6gz3THSoyYIjeKb/JU9FebYRYeCe3q1WpjSCgAdsTGG3htlGHHiAlBf7SFQx4lJ7y8AuEQTdVeToIpHX1BhNxnHgAQ72iA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9KMDY5ME9hYlpsd3RkYzd1Wm8wTEhqUlUyVit1YTdPUGhPMTA1T3BucndI?=
 =?utf-8?B?ekIxdkRhNjFsTWM0eCs0Q2RzVktCd3JhdjUrZHhvQlU2aHN1V0IyTStHSWFW?=
 =?utf-8?B?Q0R1S3F6WC9zck53SmlBSkQzYWNpZWxSSDArMlNQYXNuTkZmalNZdUpQcExP?=
 =?utf-8?B?QzlPb3hmUVFDRndYSGhKZWZUZkVYTUEwZXVjcDZIaElKdkdoRndxczJnbHVV?=
 =?utf-8?B?NCtGS1lVbXdOV25wRDZzZmt3ZExoZDRKdENQT3N2a2pXSVZ5R1N4dTZmTzJX?=
 =?utf-8?B?L2tJRnE1R3lkTElFUDhYQjdJZzFZRkt0R3ZSY3BGZ3hjc3o3dm5wV0UvUzZC?=
 =?utf-8?B?cko4VUI5eDhpbTdyZ1dndFhZMmp6RTVDOXhmM0RLYzg1UGxvSFAyT25ZMFBQ?=
 =?utf-8?B?RWdtTmEvdlFSS1orRTlFL0ZWMWM4RjJ3b1N4Znd2N1U3bmZmakpQUnB6MzJK?=
 =?utf-8?B?OHlRQ3JqcXRIeTBZNFZEMndtWXMrdEN1b3V6VWVNdjJHaTM0dmNtS25aN3I4?=
 =?utf-8?B?Nkp0bngyRWJhdnluV0dnYkdyd0NPMjZFQjhxemtta04rN3dNZ3ZaN2p1Qk13?=
 =?utf-8?B?cDdJZlVDMTMvRzZSZFFVcTlaV1FORldBOE56MHpNVm52WGZTSjJPTlNpaTJU?=
 =?utf-8?B?OEdYRzRldmFlUVNpNnpIVVBjMHZvYWEwSHlqekpGcHN5RUMrVXNJU1Arb0Fh?=
 =?utf-8?B?N2w2WEZlQ2tRMzZZQmlQWkZQUW5oMUxGRnBWcUtacVR1V1NINFhscGVtdkxm?=
 =?utf-8?B?MHk5WUw0YW5mYkJTdUVzcUhpcGZKdTVhd2N1aUprVURKY05za3ZuRlBEZ2Yx?=
 =?utf-8?B?RE9vWUsxUVdoRmJlRTBXcVpQKzRDQlEwV1hLd1o3ODZKbjlDL3UwYzJHbTJS?=
 =?utf-8?B?dGJwZ3RndVJqT1NYM3pEcVh4dVpONXlBWG5STUZpYUNDTytNbk16aFh2Nnlx?=
 =?utf-8?B?Sm9QT3hScVhoRUxxKzY0cllZenNOOVBEcHFCWHIyYmQ0U3RkQVRHOGFmZUh1?=
 =?utf-8?B?d3ZOTDh3RUlha1VTSFd0dnBkWUlHc2VlbkFpcyttZHhnV3NwbTJxcGRYZnlI?=
 =?utf-8?B?VzNYV2hrSmFuejF0dXZpaXhuRmcrWHdHaVRjRThhajE3Uk1DYXJQL2tteHNy?=
 =?utf-8?B?QU9neUtYTm5EVkFWMXNGalVrbmFtL2srY0xKcHBybGd0VG9TclNXTlA5VW5N?=
 =?utf-8?B?NDRyWnltR3UwYmRIajFyN2t4cjdJTGJBN3pMckx6bUZtQnU5RDRQd0dtWmh1?=
 =?utf-8?B?cGJRc0duMEVHeVhCMEljTlQyZ3JKNmhnWE9TYkR4eHdVZGZ6Tk1PMlF2enRy?=
 =?utf-8?B?bm14cUxzQVdPMnd1akF3d1lVaGE5SDA0WXNjcHh3RHdGVkdlS2ZUNVVWeXQ1?=
 =?utf-8?B?RDhCRmNRcHlhaWRLcllic0xpNU4zbDlPWlZuRm51SHNTeUZwQkxUN1g4enk0?=
 =?utf-8?B?TlJsSUFhQXNROHBRRXArOUxqQ2hiSUNYRlNaeUROQUtVbkZrb2RuU0cvczdQ?=
 =?utf-8?B?MGY5SVNZYjVMVGFJWW1TYVpIRnA0UnUzancxRXNwRU5yd0lpNC94eXJqY3FR?=
 =?utf-8?B?Q0tETFNDRWptQklvemoya3BIS0JTYmk4cytBWTFERFRtdTI1WEV1NnBGWmdK?=
 =?utf-8?B?ZmdkdldKS2ppNWkvWW0zRm9KSHQ4ODBiKzZYVTZYQWY0aHhKN2xEMnVmVVZS?=
 =?utf-8?B?d0hyd2RkYTJvdkhPSHlGTEtmMlVZTkh6YU9jbFBhaFhBNm1uSU4yZ0ZXeVFR?=
 =?utf-8?B?cDFSWnlqMmh0SGc3M1V0UXlnUDMxRjFiVDBQdGg5VXRkYlVneTRIenJNd3lI?=
 =?utf-8?B?QWpNN0VYN2dpZjVLenVLYUZJbXZNc2MweFNRaFdnQWsxc0JKdVhEd0FDZU5w?=
 =?utf-8?B?YXpnUCt2cGU5cnJ5ZFYzQ1hPa3BGN1duQW9XMUtiWlVFY1ZUU1J3UDMvWjFm?=
 =?utf-8?B?UjU0b1pGYXI3Z1Axck90S0YxZ2hWN2tDVkd6ZHErL2VBSEU0QUJ5ZWZtUDYw?=
 =?utf-8?B?Nk80NjJWWE9JcnJZRzdlODNJQ2tmMENzZDZqRmVwanArTkNac3UvVWpzTDhh?=
 =?utf-8?B?Wnd0L09ZVVp2NjJUbWdWSVFmSDJLR3hsd1ZCR2JpK1QrS3h6dUlLRFcvNE14?=
 =?utf-8?B?ZEs5dWdKU29DNnQvMDJqb3J3ejNmbXNwUm9LbDRhWUFaeGhNYi9vZys4ajJu?=
 =?utf-8?B?V1dMNkxxaEU4bHVBcVFMOVJXazVwR3Q2MTh4Q1hkWkZybC90VzRUQlFGdTNY?=
 =?utf-8?B?SDdzM1dNWGlLcDh5dkc2ajQrL3VxTDFuQm5JbExJNy81YXFmQXAxcmd5TFJk?=
 =?utf-8?B?dmx6WkxhTEJtY1BuWGtDRzlvTXMrclRNZmxrbVZ1TVZ0ejNRZTB1Y2tlUTla?=
 =?utf-8?Q?3U9DWNck0T04zsjg=3D?=
X-Exchange-RoutingPolicyChecked: Pi51aHdsBu/qn4MxfEzS9aQaipUDdacOnNHivMbsZe6YsY6P+pJyFPBLkfEjhuvFlyNYAZGnhSaQ4KkNfSkIu0sTXlkvZT21kH8+49tUsicL93QNtGDZklJtXnZvpDFdYCFZUlE6kpwRRF4Z7r5S41rZzV4dzc4BbchSFpyyj3+dvbB3LAdZghbL3gaO+MGVLOnDPVZjoG9PKdhaNJkimIiknSMfOGt1EYbq9dex2PnNcL3emcjlDTtZhCy5EUIJeWMj0WUvO2k5qRamD/Ga3ZoDxluhbFU0zb8bV8FhV3mFehGC2aGZlE2pfuySPM0oi7F2p9PPu2hSs/+Ea4+BDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5305044-3ad7-43db-c148-08df31d8bd29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:11:46.7067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMwZCfLesjkU7uvVBUjvKlOwWNXdzVosvvXUM8NrEyFa2odrOaAKOMNRBIP/Iq3ra/e0P/Z0J7PO8RH1dZsSW6pqlwEX0l+Yo7TenZwpiII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 3:21 PM, David Marchand wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> 
> The VFIO device fd is closed by dev_vfio_release_device() but is left
> in the interrupt handle, so freeing the handle on cleanup logs a bogus
> FD leak warning.
> 
> Mark dev_fd invalid after release.
> 
> In secondary process the request handle is unused and does not have to
> be set in the first place.
> 
> Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
