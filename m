Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78254CA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14F1540274;
	Sat, 10 Oct 2026 20:27:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D563A4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791656854; x=1823192854;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=0W50nlh0Oj/aBbscMPO/Z23sFEUcmeoMr+7pKu1llU0=;
 b=E441gW1dckxzpduGas+URj85XWZZYE8N1oeuKVMnvXs9qFBBVs3IASXz
 Vql7zoT5WSCaADohMK7qf58PGJRbd2zBpVaQLSt76rnNBLu5NAfpT+icm
 IbSn3cpEOq3orvCa512qKFwd4cGXBHLLhOGy6ZWrkQi8fGHmWeRtzZrqN
 T38gRJcA5UODnE9sMn+dMjZs/8qXu3lGCflMX3K3XEP0Rpo5khmpX3wGx
 wiNjCjZwQugGN7XionK7q0XLQ2hW0DIW+XZYVY2Zxf4O1v/2zZwj2LAeW
 PEJ8WhYtQj+BnMtuaBugSFLJwJYQ0aeEM22qAIHa8kfvnqDhGS01sJZKP w==;
X-CSE-ConnectionGUID: /hQ40qzfSOSTm5ERw71n1A==
X-CSE-MsgGUID: ErHWpNvoTp6bX3oWVOUisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="307611"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="307611"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:27:32 -0700
X-CSE-ConnectionGUID: UbVwq90WSXCGPhwrSHhRgA==
X-CSE-MsgGUID: qbRMgtiVS9qcJx9lYk6mzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="543934"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:27:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:27:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:27:31 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grxqdp+fh+t4zrrCSoST/6Xsu3WGEFOvgCz3qrOF5/YKct+1CHkuCUMFLwre71kLmCndw6GmoYoshd9hygJBK56HypvAXRC9xsHRUlPQADNicK4+LKuefVzjaH3B/Vo2DYFjXcuWnTcVdD4MiGRwvJwtZS0LJq3kNNyywI83FfeC+ykJBFlXVo5ab79Dcbs46436MSL7XN9mi17uYyjgqseb5/qJ01QRkmMN2m/lbsbH4GNlBi263BWqC0bk4aZxVDxTQEWcCmi6S/0CBY23SG2INwK9ZqGmW/epdJyWgc8HCMYlMn7DrdZ4D99Pu5+WrcswOwp/U9KxDrhu/uMSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SA3/y58FQZV0RugM1/ak4zQAageqzQyKqaCrEJC9m8=;
 b=fQQawQnwgZVtU5/A3wZ9C3vK+qYZNUyfHQwI4OY8h6yjj+aSpm8LEh8LzYXGoCgzlm97pnefj9ROKVzHA2/NP+wT2v2pna6b9SDmfDm7C4/9Ib/wz0uNUg+C3O9xUm6642K0dwTOU4UPeAtQIZyL0UWVwJ2zME4TRN5TjQjoCudFLNIfyPX/VuGAPcanTotfJFrNH+y/stNCQa8tKNOSD8UqIUhHmEuQ78ZNea85wvjCnAWaJ0Bufj86yGqDJWTgg/TgW7mrt3kWeD0Ot3sRXSJSFhW7rRgqWA3Jc4hqaVq35GXJFgoJXwYm1QLzlUPAdrczoP/ZtINgTifGaJJuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:27:22 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:27:21 +0000
Message-ID: <b132a044-2bf2-416f-83f4-5e7bea2a745d@intel.com>
Date: Sat, 10 Oct 2026 19:27:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/25] ethdev: add default mask query to flow
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Ori Kam
 <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
References: <180679a4adcdfb00e7388e2ed65e13451bbea6cf.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <180679a4adcdfb00e7388e2ed65e13451bbea6cf.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::26) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: b2723f41-45f4-4eb3-063c-08df26fc1fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qFP074o7I2lEMnltPTBLUsflgOwzoup513qSmXj0Rt/n+kjRRn1cbR0xdtu2EIKiEzJdnfiY5FEie97mpOaApSy4Mv4JZpUVGtMewLyrh8dlNtVnyfAsGc5Quiie89zOzCkodFvbi9UPHbxxTdAfHIQhGm466XxYCuVqtClggmUn98/FAK4P8oqge3KYwVHEtfe1khcuQgo0jpe6C1pEHeuEDDnV8rhbvu9qXua68PzVpdLEI+6TB3LZstN6dOOrkbgC2oH/Oz2x+FVo9R/j7Tt35ilmUcmMg8qPipHiJzvsUgOHAo/AStV4r6rpaiSo9uGnno+kXSTU/QG6PicVBW6sGC+6J95tYugH/iQlQrphQ51aMqLLevA0eveIroku11rYJzGLzw+nd7heUWHhn+xSVHdMyaXhEew2YhBwm/YLK+Qy4se43TWK0SIFb9nmYBzshX12t6MCdd06KAJxo5EF6h/GBOd91SNf0igKTkyBetS9oSy/fxSNtvD6zXA6MpPPqgHW+vNv0byh4u96N5mTNr2LNDev3nwbXbGu2sdXCvacdwFPBy59wcDUr9tr10/fVbMkQskjsGS4gGkK5Lx22b6Ewz7cg/RgwnxfDc22lCfvNCe9w5sjLZi4/qluig7WNd/S+X7B+GVAQrSli4fU3a04SOIhFJG574asY54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVYd3pjQk5udzZLanNwZDRpb3JWSkJmVm0xOVJCT084d2JZTUdjS2pESnA4?=
 =?utf-8?B?MTFybTZCRkV2MXREZ0F2c0tqNkNMbWNvN2VQZFNhUzgvMmpVditDNk5RL0xq?=
 =?utf-8?B?bDlKcVZ0Szk5Qm9jUDFtcGgvLzRsMUtrNm5JQzBCL1N2R0VINFdlM3UwWkxU?=
 =?utf-8?B?czJSbjZoNmRlaFp5NUVZWm1FOXM1NStOQWlpMVdGdmVpOGFIWGI1N0NmejVL?=
 =?utf-8?B?WU01S0pzYUpGbWxEc2xISXFraTNzYjdoK294R0tDVFZzYWRlbzJ5MzY1OFM4?=
 =?utf-8?B?em4zSUlRbUkvZG5IbS9CK2dnTnhiVDA5aVY4a2VxQkZGdG1XdGk4eXRpVFFH?=
 =?utf-8?B?TW4vWUZUUFpsTUhQN1N6VjVEZWZQT0FBZHdXRE03K0VaK0JqaThxOWRrVlpz?=
 =?utf-8?B?SFFaYkNVcTl3LzI4cmJ0dnhaU3p5Z2MvcVpyYXU1Q2ZIWU4yRUpRTWMwSVFk?=
 =?utf-8?B?WStuR1FnN2xHRVp6Z2F1RHgxS0w3aC9MTmNqK2s1Ykg5RDhVSEozYTgwd1l6?=
 =?utf-8?B?akY1SVcvNUExNVI3VzlNeGZrY0ZwWWs2bVR0VlpLWmd0MjE0dDNnT3hNQjU1?=
 =?utf-8?B?SlZJWTFVQVVTQ0tLZ1RNNkc2MFNVMnpoRnBsK0ZXdkxxKzhmbDMrbUFaZndV?=
 =?utf-8?B?TFlBMHlQRWlGaE9UUmZDa21mT2FkRlFCT2FMQ1JSb09qWkdueFNMZEZsNkpP?=
 =?utf-8?B?Ylp3VStHckpaR3hTNnpQb2lrYTFIOURSU1A0aFBrUit3azVNQnFQYXpkcEFH?=
 =?utf-8?B?c0F1YzBieXo4S0Q0RkQ0NU1qUndBVVFUWmEvb2M1N1hnVXhnc2JGcFpCRm5o?=
 =?utf-8?B?c0p4cUxkTGpzeU9MUUhSdExqMzQ1c3FQeHVZTXpkZGdWenVQNldMZjFhRWpV?=
 =?utf-8?B?cTEvUVFkY05aRzMxekhYRVkwY2svMU9BeisreVhVQU5GR0h5RjF3UE4zTUZR?=
 =?utf-8?B?VDhpaERMc0FYaEJXS3VXd3hVek1uTlN3RDNJbTQ4RHdUMTlVMFhPQXhkSmNR?=
 =?utf-8?B?SVpEbUtIclBzSDBHVEdvRGVoTmE1ei9RTnlia2tCVFh0U0I2Z1N0UEhyTjFY?=
 =?utf-8?B?NEVDNWMzZFp3Y2pITkpqKzg3QnZRSU1XRXQ4RS96VE9iSG56bk00RFNOeHpX?=
 =?utf-8?B?NDlWRXVwaXV1dk9JU2dETDNNQ3NwMHh4cGsvUjFBRVhaSG5GVldzaU1XaVVG?=
 =?utf-8?B?Y3NlbCs2TUF5ZWRuaVI5R3k4ZWlrTFl6Skg5eXA2a3JHRzVuMk9DaW9mall1?=
 =?utf-8?B?TWVsTWlCOVE3NUpwNm5HcUhDVERuNlNnQ1lqNm5uYXlBcmJXSzFpUFQzb2pZ?=
 =?utf-8?B?L3ByTXhKdlk2SDlsOWNyL0k4ZGltTE1oTnJnRkhJdkpRNzV6VVNaU0lObFg1?=
 =?utf-8?B?cHIzekVUWDlJUmJ2TExyTThabWMrdjNRVllWS2FYNFlCVGVFVmJ4UFVoL3Qr?=
 =?utf-8?B?TU1LY3N6L0k0eWJ2R2NTVTR4Vlh1S2J2Ujh1TzJYTE1pdzlUYkQyZ2J2RmFN?=
 =?utf-8?B?ZkszWTRueHVVNmZ0WGpHdnFzYXR2TENOanIrdExwY0ZJWS81SVRjclFZM2JT?=
 =?utf-8?B?ZXhDUmg1V1pZaGFtQnhyQ21QVkcyM1o3SWpsNEVCakQzMGoybUYzOUtZaWxT?=
 =?utf-8?B?RnZkYjY0U1FlQllQWEJLRXh0Q0R5MmlNQnA1bHZrNDc1dk1NenZ0L0p3R0RU?=
 =?utf-8?B?ZlFvSVM5ZFI5anM1a090QjVsc0RKcVR4eWpKdW9ZaHdRNTYyRUpNdExNS0RR?=
 =?utf-8?B?M2JKUVJiOGhrZHpiSkVpbG9NRXpBU0ptd3NDTGhUcEtvNndLemNjSm0zdmFJ?=
 =?utf-8?B?Zk5La3dIWlN3dVhvajBjTFFGRG92UWY0ZENrYnJrYlhMNlp4NTRwenREUnRm?=
 =?utf-8?B?MERHeGxKVXN0L1A0Ui90cXlSTFpYZXpRSGJQUnFleDNoSDdqcTdHaUsralNC?=
 =?utf-8?B?NnN0RjY3b3NUMXR4QzhFNE5jVXQwRHM5NE1XTkdXUlN0ZGk3M1JMdjhpZWpX?=
 =?utf-8?B?Yys2dWJKUnJDME1qajVOazZFUzZmeFdPcWpZRHdMVkFRc2Y2SmtDdUIzV2Vm?=
 =?utf-8?B?MWtKNDdoMm01QkhTLzYxTG1kaGtLMGhCa1FuSGNJVkxFUkxCdDZ1RWozdHcw?=
 =?utf-8?B?ZnNEdlB0dGlYbCtjbmhqZElMMEQxY3ZvQSs2UGgvZ2xnUFVhRUVCeGpNejlv?=
 =?utf-8?B?SkNwT3RydWxLTWNWeEZDWkJ2OFhNUWE5QWZDcFRUODFYSmU2eEpISHgvRWV4?=
 =?utf-8?B?aDRIQUVBVjZjUTRvUzVvSG9CYjZvTmVQQU85NVdnMTJhK1dHZmwxajBIekwr?=
 =?utf-8?B?S2N6OVJPWkVwcG5XakZlbjFhQk83QzhULzhUUUlSSzkrYTlvR2hZWVFOdUIw?=
 =?utf-8?Q?LU3solDuaeqoZRZQ=3D?=
X-Exchange-RoutingPolicyChecked: CcbOlHtTxf/pTiWxcxJSNvu8QeGNRnFOR4Lu7wHy3xAZdtwyxYRHgEEtxvGkvlWopUaoJxn27BnqAZDqtX4PosHpB8V8UDFxbyWJjZQ8AuPZjd07tsIPpkKHByn7oFKLRGxvrZHcdUiHRlwIJAr6gLawQ0R0OSFfWzfKD8iZI+uV3k60GfQo9YFKhv7TrHTwtr1O2LJNFTIs8SYLIMCajPdbiYXHcFgz5jtMSSDwN0yTytdxM8OjS1dGJQhARdCVwMgN5suiw+R5tbfHoZMWl/S7HmemxDhbALUhBbboQY3H0rsdH6Uk8ksd5hyQRM9rZz+Ncu10kdIQXG8ufUa5Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2723f41-45f4-4eb3-063c-08df26fc1fb3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:27:21.8058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGrxrR9TpFGp/6r8M6xNz7VCLNkAv6UINQ5Scih9vVJ708W5vJ2I1uUl8AhejEERezsZl74gcLkS9EAyCvoXHCbVs/kyLwqlJNpur51dnSQ=
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
> The rte_flow API defines that if the mask provided with the flow item is
> NULL, a default mask should be used where applicable. There is no API to
> get such mask, so add this API to rte_flow.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>
-- 
Regards,
Vladimir

