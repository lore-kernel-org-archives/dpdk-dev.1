Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A5CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 636764064F;
	Thu, 15 Oct 2026 13:32:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2DE1E40687;
 Thu, 15 Oct 2026 13:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792063934; x=1823599934;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zrqnIpdtpBaC85mMr6gQyDOKJ4o9LEb2R09nzrkOrs0=;
 b=h1H08bpuhMuYR7/kvycT0zveGiiRJoazupPBvGihgojH3RtVO5yIl+qZ
 1swwIPegbAwh5DLg4iOqa0fj2Ovnx+vA0A48KbRzoILFe/2mBPkGkb+wB
 NQJCJui/9cqjuqenDTRctSTwItcxXpjweXdZTo31uN3S+Ii7hwgzxmcRJ
 ItWyuXz9WZG/m/02W20ofQSds7HxL8LOAEcoU71+ZLwRMBQJVo5+mPCad
 wiwEVrKPXtMUnH1rX7lCr+jnSkSJ0XnqMSmuyQ/75+ME66qTl31+PAZmZ
 uimc5qxar49cTmnth6UsVgoARwY51ledingtNN/smNuYfHO8k0ohw8ECg g==;
X-CSE-ConnectionGUID: z8dj8GjjQf6m1i6KCPmnpQ==
X-CSE-MsgGUID: Xb6oPpaXS1W6SqomYyc33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="831802"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="831802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:32:13 -0700
X-CSE-ConnectionGUID: 6ori+XcQR7esSmZFMEmgCA==
X-CSE-MsgGUID: UbqiIEnMQoKx18C9JHf3oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1768044"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:32:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:32:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 04:32:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j76+UhGatslOBC2J6sinT1BfVZNJIMAI1biblnS5NUXY0MQxgUl6zjti+CndeLC4BwU9FjtfAAvIzKf4DF2pkVq+kCLj913seQESDYutTnBLcdoK+wIEbxcJB6K+HrFda8F8nO111PDXq01r0/JEBAGjDPH7yOAPPnBvQSKLVVj6jt4htA6mAoYnFhJFLP78hL59f2J/Zg4ir3G8v0U7NqClND144gZwNv5MPNopjETrWvzZXOHSojfHVhTUXCpS0YGePyaqr+CwRXVgR9OqwwUtUQxbqRQRf5aPjSrEBx0TncdP18TmoHkTNxl9Tj29LEUpFLyE3ZaDVCNYDzq8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u02AgmnV+7Tn4+zvfZt8MnD6RBOD+MY80pIKWJVh1A=;
 b=e/nQRIowXfKBakZaZO69dD+f8nzWYh8QN1X4kOAaLcsMpSkZiU+7fJYoQxLzaUDiiz+0Rgp8e4ks5Q7HcwgLawVIo4f3jIOPdf7l2/2ijI+AC0qWidOXdrQW9ZTCGefSuJhoa43i0LncT5HpmkWqMLbEXp09BUeiF1EzTymTZoJCWIMj/nsN9MPeiwTOynOuQb92mIgHiwP9x8BhPpJGK2YOprmcJ8OIxHWwNY+FA0R17yg464G92ceEyJArn8gTxaNFpvjWgKEQh/Sjl4HZ2QDmv3+aCv8NgAH+XCVm2cM0lHk/N0VJYzlx2bK2jYtRzu7WdLlOuDQZ5HzfKC5qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by MW5PR11MB5905.namprd11.prod.outlook.com (2603:10b6:303:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 11:32:00 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 11:32:00 +0000
Message-ID: <6c3d1aa6-2f60-4974-8f48-f5317d8fd725@intel.com>
Date: Thu, 15 Oct 2026 13:31:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] eal: enforce internal API check with Clang 14
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>, <stable@dpdk.org>
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
 <20261015112916.2622825-3-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261015112916.2622825-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0269.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|MW5PR11MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: e5df2c2d-9ba9-4aaa-ed3e-08df2aafec8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aWJdSQgcAog/CWHCSrJsGv5UtuH8ROPWRINda5hPwGp0b/s86wYaaxIUsmT1iM50DFVOYtI9Gttz2tB5zfVTXhCikG9LWi3cnPwDKvMS70v8qR2B67ddIylHx1vGJisQKspsN38SYUmLoPYvbfGCnMRkW/fnSyJsRG1HazWn2PmLhs4i4oA2Tcht3qj9j8j3HFFBZqdzbwjYrJfxcnbzq4LMO53mqcSxzxng4S4GWgW7MLQV+T1OWDL2yNkaevo3YAY2V74+SBykPimBVOiEX0XkBEbeHipkCnF+nal0a34Dk5IXqojXEJaNiUiTf5kbBIl0ZyrF33O1UifSXlgHNoZ6BWG3XaIj1sK5Xpo6nTCJjzzZgLg2i2PLkNrEJBExUxSAU5y/rQzjUgXeSFg9m3HMP5zD8sbB9GZGo9yHKw+aabTQxdelp4ySPJQcwzjjc99rHznZDBBTQRg8eT4Lb7KukFJ+iV4xAgXmYT+9ADO4NNKcASX8p0Hkc7y4gQe+FoA1+T0JRkMAO/SM1RUtLa1CkfMV7RpKcl19aG5Du67sLUyyBgE4qxGdtf0Tj1FqNDzVki1sUZfwUAH19wwH1xTgKkXmfChkJMLcmugFw2e+O1rmq/c4ZN4CQlEFzB/mT4VkKQvy/QLYhB6nDRpZUEjHCIqQ3MMIN4pLiHcedzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhwclRETnRGQmFPOHRZVkFBM2toTm5acDByaEI3S0xUT3NBSUU3STZKK3Z1?=
 =?utf-8?B?MFhTSm5aUGVZZVVkczZxcEVuN0N6VFpsa1lLdTlrazk3OEZzVFNRa1dYSzRN?=
 =?utf-8?B?NzhDZGNEQ242T3lVcU9ZUmpGVnNJeXltd1NlbDFyeGQyZkljWkRWY1huMmhk?=
 =?utf-8?B?MWl5MzVoZEZsdHlOVTEvTW1vVGpnUC9aVndmYUgyWE1JcVRaaDRPL245TEo4?=
 =?utf-8?B?QXNheVYxbC80eGpKZ1lvS1YrTHZvQjlVYjU1THYrMkdoSHk1d3FSZ21HZXM0?=
 =?utf-8?B?NmtnazBZejd6dkdTSlR3d0NOUkc3ai91ekh3WkVVZ2xiZkxtR1oxdCt3Kzhn?=
 =?utf-8?B?eWZnSTd6bm1tU29TbXFqQnVhMzJFM2wxYzUwcXdHaEFvUWFGNEE5U25XRDdL?=
 =?utf-8?B?ck52TDdmbkxrQ3dxVGphZzljUlg5ejluVVRlQjQzdVdPdnRrUkVRUXZ0TmFi?=
 =?utf-8?B?TFd3S3UxdUFmOFovWWtVMkZsTGFvQ1VQSW9zV3pVcUpPUVpYSWR2TzlaMlBF?=
 =?utf-8?B?NlUrczRDNTFUT2VHNkNVTGhGdWJNbmxMdkVvYzk2dWxhNVdEaUlXR3ZYVG9l?=
 =?utf-8?B?cVNCcUpXSUFRcTNkYUxwNU1vZndUNFlsNjFwM24wZVJOcVdlNjJpOGZGQlNs?=
 =?utf-8?B?REdRNDBSM09ib2IyS2pPWjVDZG9PM3FXQW9OT1N2c1hmSnB4R29oODJLVzRY?=
 =?utf-8?B?VG9tKzd4MUVGQUd0WnNoMS9TellnOUsvM2xSVmhjR3A3dmQxa1N6RGhCckdk?=
 =?utf-8?B?bUIyUHEvZnhkaHRzNkU3RkFIZGZIaWdCNlFlRWh3a2FUUmg2SWtPcGU2Qlk1?=
 =?utf-8?B?M0RmL0llU0VDRHRFWnREaHRyMlBEQ3NpTFVHdlpOZWoxTk5zdHFOU2d2SDBV?=
 =?utf-8?B?ZDV6Zlp4VnN4RmF2eFVmeVZodGJyNVBSd2hxQlJseGFQY2VPOHZkbit2V3A4?=
 =?utf-8?B?TjZRZVR4Z3JqTHVlL1JHOG51U2o0UDAxdkIxT29ienRTOTVGSUdRY0d0NVRN?=
 =?utf-8?B?K3d3dXBWSkVBdHA2Sk1LNWZUOTlhR3MrUnVUL1FxOXE5bVhkTXBZUGFOU3ZM?=
 =?utf-8?B?elZQTFUvTDdRRVZyVnVBb3J4bm5Pd1JPcE1PaitOR2dJSTFHbEhhUEh0d1Ay?=
 =?utf-8?B?MGRGMk1hTkRsY3lpZGdhU0R4cUJaeEIzWVozc3B1bkcyd0lRUFRCbXk3MXNN?=
 =?utf-8?B?MjBmYkJsYVdKU0NxRlpKNWY1MVc4M3prMkFVNzRaUCtiMHdHWXMzK0NuYjBI?=
 =?utf-8?B?a2tlRWducUJCWTNwcVg5Y21Zem1ZZzRiUTBOVVg5YmN4aGRvZFFteVZDQVFJ?=
 =?utf-8?B?MTNFRjQxL1U2aUg5bTJwS2RPWHlkU0p5M3BDTm5ZeVBlMUZrTUx4aHh6VEFO?=
 =?utf-8?B?ZnZkdzJ3WExnaWpGSmFheUpzLzZZSGk2V09FN0tCYUZUem4vV3hrVTY0OWJQ?=
 =?utf-8?B?WUExeDhqSk1sTktXUWZhOGVPUFdMcDlLS2FscnM0NlBvdWhBYmlhdUsyVkww?=
 =?utf-8?B?VzNoVUI1QWdRcmpKMjFhekRzODdqOVBraENXWDNvcjl5Y1NrWWZuT3VEWllV?=
 =?utf-8?B?eGE0b2hGd0gxYmFFSlNRc2h2bUN1UTlFQ09sS0I3aXg0dHc4NUltZmZwY3kx?=
 =?utf-8?B?OHVoMGlBczBXNXpUU0pxQkpBaUw4ODUySXpnK25yR0E5bDZ0KzVoYlEvQlZO?=
 =?utf-8?B?VDcwV0dOY1IxNUpUeEdXdUUwV2F1dW5aYnNreXo4VGtneUxGbHNyZDZFOXYz?=
 =?utf-8?B?WmV0OE0wT0xuSVk0TmVDdlIvVSt0RVJkUmpOZ2cwQVVXT292RjJUcllhUXFC?=
 =?utf-8?B?Q21oNWEzek1JOEg2Yy9RU3NxRCtJalFBYlNXQ0p3SDhlQzc4VDk4MHlDWDND?=
 =?utf-8?B?eU0rWThyVDN3Y1FUcjFBNC9GUDYxaktRUEtJbUJqbGV0cjhYZGx2a0J2eTFa?=
 =?utf-8?B?UkFBRkYzanBoSkkyYitBUmFJQ3Y0QTRzUDJTNERPVFc4NTZsak16ZDR2L2Uy?=
 =?utf-8?B?NGY2WjY2c3hsK04xb01oUzdnY3Y3UG5scXJiVFFwTDdsc1Nkazh6YkI3Nk9s?=
 =?utf-8?B?SmIwektGUnA3Lys0V1BTWGdaTkxnVS83Wk8ydFpPc1lrc0tYQkIwK0g2Mmpo?=
 =?utf-8?B?S1pCRlpseUtkZ3Y1akcxU054Vkt6a2hiekI1cUVVSjhPV3FnSjJuUzYrc0hr?=
 =?utf-8?B?OFlXT1NVeXBibGhzdTdxTUtBVDFiT2dPRlV3LzNLNFlXODFyUzVXMnNOQnlG?=
 =?utf-8?B?aFZPUVo4citwR0RDcUtiUkpUSUZNR0c4YlYzcS9FUlZiakVSVnNGNDFpNVRB?=
 =?utf-8?B?WDI0SzV1OW1xYm54QlNNMXVURW9xNDBOZW1JekNKWURjb292Wll5RmJyQ1dQ?=
 =?utf-8?Q?q0ppObhQiC+Gi+28=3D?=
X-Exchange-RoutingPolicyChecked: 2pbCcmbUNE3OX0Tc727Yt7ZHMhINTQV4QWMHoa5pZmJcNzhdt/nY0dxzTU+0nG3aIEkVKah0gH7qGk/XtQ6wCMm+wGc6ziSEi7HqHTW0Bs+AAPwCDtxAx0l+g8u17SqbhkCTp8ctbPQ4QOaN6I3oTr3i3YF9XD2CEwmA+YkRPElYdVLeg86t37YUSpjQDDx8JxoU2sl4qeMbdh0vc+amKpREI4ow7h75Su/+vyoDdoTjUUqGPiaiT48MaGrXUBvQhsgx3BgiethM41/E943wsodU/5fAifBesn4Pm80y5iNIu8cg+uUJ8SEE2E8BhCpGoKMKl66yPH5Kj0Ya0dee6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e5df2c2d-9ba9-4aaa-ed3e-08df2aafec8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:32:00.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufT84YyAB0J6caO/6kTBHRrtN5esk9ICPQH5rr+YypZW1lxij1/2SbfijHDGCd0xDc4tiCfWQEuzZ5wco0MLn2gLbkqJC7S8Ok4GXl9LCtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5905
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

On 10/15/2026 1:29 PM, David Marchand wrote:
> From: Thomas Monjalon <thomas@monjalon.net>
> 
> The __rte_internal macro is intended to prevent calls
> to internal API functions unless ALLOW_INTERNAL_API is defined.
> Unfortunately the check misses some calls to internal API
> when built with GCC or Clang.
> Clang can be better to diagnose such cases.
> 
> Clang 14 and later support the error attribute
> and therefore select it instead of diagnose_if for __rte_internal.
> Unlike diagnose_if, the error attribute only rejects
> internal API calls that remain after optimization.
> Internal API calls can therefore go easily unnoticed,
> making internal API checks less strict with recent Clang.
> 
> Prefer diagnose_if when available to keep strong Clang diagnostics.
> Retain the error attribute as a fallback for GCC.
> 
> Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Missing my ack

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
