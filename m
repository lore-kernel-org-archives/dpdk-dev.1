Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A6C982D9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E0A142EE5;
	Fri, 18 Sep 2026 11:17:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 09C7140276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789723048; x=1821259048;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jLM8UTFoXYymmiuwWVJ3nrmD9ZTQ1CbR0YxwDq8S0kk=;
 b=UdMKEA8CP9Jp/TAlqC59dro1JidsBoNXG1MhU+Z+sRlqaA6O/WfXL8NP
 1AbkMj9haNs2HAiJDk0ypOnxXvGrm6sRVUvR3oUloCMza9+aotg/BxzZB
 PW77+z4jlSDSv0MB6mzK5ucBxgQooroWJLui1pd1DMxmKLgVG4Lvu8d2p
 QG/zd1O9x+kd9Zy5EnfuN7rov84wQ3ZDTBwTvs51csiSFyxjACDXmqjpQ
 1CPPQkLfso7iepJE+sL870ZaUDLpJcIRhiaK28tG+9mfoG44RX+NiGtB+
 G0CauZetKz9rzmevKRAUGlBWsMJ50283cCkNtUu5jaPpXsjTzQ0SiR0gi Q==;
X-CSE-ConnectionGUID: Py56bq3BTMOEaEy24aJG7g==
X-CSE-MsgGUID: OUfFgiV9SBuLHrfXkZG7OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89148176"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89148176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:17:25 -0700
X-CSE-ConnectionGUID: ueOFAummRAKXjkvYhFjRjg==
X-CSE-MsgGUID: jT+YbYQITaiqQjt8+eE07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270624231"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:17:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:17:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 02:17:22 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftJC52YZx3s+x5vdCFsBMZFNBE7n5oiP5CRoii/tTacWd5wzZCv8Z94djoXr1w2wWIdgGCF8+aYHwdx13rrTlL02m61winZSJ8pTkZQ4sLvO7SBNH7tiU/1Asz4Oip2pwrARLysI+fYZXIrXhXP6H2VcyMDdujhx2Q87pI9qLuJntEIt5lORQKHcFnONxvCRCAiba/eeh7Eof4SDK+NVwOohi2C2pGOhkKTfvjUA5hTZYBzz6f1INhYfdKxdiy9xfUesTi50813O5kz9CbNwW0oxUUKxCQd4IQSE4l0DyVPlgqaTiGbQPp93WKzQArU6gSyd71F7CvQ19cHfCUICdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tnC1/xNerO6rEzQeGwIHVBYewK54adbHMyu9whzQ7k=;
 b=zP2HUqGcmZEfq/PItPwjwTfQgombJHrfBD81vmSIS0jLO7qi6zGR7qlh30d14TBkfNuqj7TYG5/aw/i894QsbMdeV+tgSu//auvzQRUddNkESstUeglHEHNUL05a2tYPW/Lg0yzSIX5w6FfM5sQ50R801izrRcG/IL/O6uIockLY7FVu4ETFTCvEYFMlP4DvYyGXBFYtpNpA3sOMJw3u4uwKoY74w4zxDX9gS1CnN6Eafnd1tfU7Ez2L7doLy0OiPYBmAjKv+ghFdfpXlMDkK6UPl12B76ZzHPcDxic10nA/BijKVY0Bzwe47wmcUFlIZhb2g/Kk/wBXVDxrROs9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Fri, 18 Sep 2026 09:17:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:17:15 +0000
Message-ID: <f2a15943-9d9e-4537-b852-96be75db3acd@intel.com>
Date: Fri, 18 Sep 2026 11:17:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] net/intel/common: add flow engines infrastructure
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
 <20260916172640.2dabe913@phoenix.local>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260916172640.2dabe913@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da17b92-f50e-458a-0fa4-08df1565a12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: o3gHDmBoJEy9rFBXZrf/Qv/NotXynEeE7Kh4iFs5dlVY7dR4FBx3FOMEbRBIc6CgmOvyIb/cpwEnhXalb5r5hE68uCpFi9nkH8AyZ17hHazpAfiFZVyg8AOBtkLVDASd+CtVM6dwTNfabxrN33OcbhSruPCim9lOm7vD3NMdLJClSoBMVmc29uTI+9wBKvdEeGgcumO58JxLSCdaRaYmqCPNWm+jG5cPs2H3F3XcVQVAr1GxH5rrQ5Q8290C3Kxrxt3/QRWK09MfuL0ElBFqjv2DmddTSPXUDzq2Yk6oIbKweBqTQZRkp1PXREGD4f9Qx6pT6NppIlXrgLow55VpRWF3wI7xLH9xpxMoo6sOXhaYoxi8gO6sZgtJPznB2KKbh/zfJ+sVGlhUVduZX39tmZVGw6u3IRM/0vfwLNr7/qeEctbN98NqDPwfMJsLUsGvAglv6ArPsLmzMR/6mArgK6ADbGi0VuWOF352j32c2QJKBXpb+C9aLiKHyXx7OR+jEPjQL2zpKUmFsUmwnOtn3m+hDQ3pxLW5P4Og06FBMJDSNrtsQ1jNsLVw+tdzM8PKDtKTqych98MeihcKaB6HR5iODCniNArvS3qrB2AzEdsH3bh/R15abjGvZheCTFV92S7gOBxH4ZRss8wsRvHjy6qtwNQ0AUlBwwIYZCXRVZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEV0RkxIL29WNjZFSGxTZGdQRG90Mkp3THFHSVVZRjdyTThsbG9zbStVaTl2?=
 =?utf-8?B?MzJUeU1ZYXJ1eElqQXlmZTQzS0ltSitXSk5RVG1vMG1IWkJrcnNUdG5WbnFM?=
 =?utf-8?B?Z2dTRHg4SmtCaEQzdThReEJRRjc1OU5FV0RHelRQU1o3K1Q4SFVORDl2Mzdy?=
 =?utf-8?B?SVY1dUNvMXdIaUxjMDNTRUw1NnZxMW5xbDU0QWRmRDJhMWh1d3ZkSVBpUUpY?=
 =?utf-8?B?Wk5ObStyVzNibVJlenlraTBmVXFjUG5ycnRYcGJWU0JxKysxa3doYTRUNVkz?=
 =?utf-8?B?bXI3QmdBWEdOWXkrRFpyclZ4bzBZMG5TZmY0MWlrd25SSEJiYTZzYjJOU3Ux?=
 =?utf-8?B?MWd3Wjg1a3hkSzZlTFR1Mm5lb1h3NzJaSmE2YVNjZElFY0s4cTlKNTRnOUxD?=
 =?utf-8?B?NWNWYVJBVlpjU2hhakExYkdmbE9HK3FMQjI1UWxDU0hzVXo0R1AwWXVYdzZD?=
 =?utf-8?B?MkJwcWFXcFRjYzJjdGxZMnNhZWUrRElMUmkxQ1Bzd0tBYUpybE1MUVI3UHph?=
 =?utf-8?B?Wk5SVnRLMHlCdnI4czdSWitxSmlzbEpTQjVUWjZLMDBJMWs3UE15OE5JYnVq?=
 =?utf-8?B?Vkcxbyt0ZkxpcVJnc3ZRNW96aEJJMHdXRGRsMkpzQUlnUmpsRXRaaUR1YUJT?=
 =?utf-8?B?bkhNWWdueGpzODNnaytwK3VzbUhFdm9wUGJ2bGFZMjhZYUNUV1FBc3EzM3JY?=
 =?utf-8?B?RmRFaWxFT1M5ejFRT0U5Wk9XVGdEL2Q3Q0ErQzVYb0dEWGI1YU9VR3h2QnlQ?=
 =?utf-8?B?SFV0a2JkazdMdWUyTFN3UWRlVDZqckZXTHB2bExzNTZXcDdOdCt2TmVsMlA5?=
 =?utf-8?B?WFNmcThmWEdZakE4Y2ErUTBIM2F6V2VRVThrWG1zOUY4ajYwbG5yeWRzRGJ2?=
 =?utf-8?B?Smg5a1VsK3BVd0VZOXlmT2Z6K1hKOFZ0dWZwUC90MlVzMnlaUmJjS0locjQy?=
 =?utf-8?B?UVdkbXVVV29obWExNnhaR1hJaFY1eUxQR3U2ODEvNHNmVGpwenlXSVFKckVx?=
 =?utf-8?B?UGxja2hJR281ZllIZUo2UFBpTVRyem8vOTB1U2J2ZVE3UEZNSHZMcHYxSzlB?=
 =?utf-8?B?MkY1NkUweUVTR3kyOW5UcjEwUmtqcTVRNEpMMlM3QTNsNzZCbGNVOGR4MEIz?=
 =?utf-8?B?TVhrWkIrM2ZvSWs2T0llZmZFd3IzdnFLcERUdkxRaFRSS1dnZkpsOEVLR3Vp?=
 =?utf-8?B?SzBZRzYrdEd5WmJCWWh0UEt0UlYvd3pHM2k4RXhxZWhvdG9POXZ0UEM0OTlJ?=
 =?utf-8?B?Y1BMSkF4Yy9PZ2JTd3g3Zm5teDRZS2JpK3BjdmU2KzU4M3BpL0Z6SnRpQjMw?=
 =?utf-8?B?dTF4blBGSG4zdndwNW5UbUxhMXBhTlhDZ0JLM3o4MVBCQUdkVWgrRWp0Rk5J?=
 =?utf-8?B?OWR5S0l5blMxYjJRZnUwQ0ZrcDd1dlhYVU1XR0N1Z21GcHY2Q3JNeE9ydk5U?=
 =?utf-8?B?Z1VmNnk0VkJ1NzNQNkl6SThGVS9qNlpCSkF3VDRRVm53eWttSFdWdmVmRVMw?=
 =?utf-8?B?VnRyM0pLK29NTnN0ak1FZUd0UTE3U2JqMC90NzlPY1phVXlvd25ReXQ2QnRp?=
 =?utf-8?B?ejJxdDZqbEYvR2szUDJQMW03eEFnK2YyRkxUeGxQQks5L3lkcWNxZW43MHBu?=
 =?utf-8?B?L1VCYzFCZkcxUXc1Qk83bE9ZeUF1WXVLaGZhLzVMT1VVT3BteVQzMmkxL0kr?=
 =?utf-8?B?cU9MMktDQmd1dHVFR0pWaUNTK1JRUk9wcWlWQUVweE1vbk55RHJmT3BySVkr?=
 =?utf-8?B?UnA1K0hEMWRvd0xrSXhlM2h4bFg1aVFrcmZPZUhTSklqYzlsRzMzOHJld2Jk?=
 =?utf-8?B?bXVoYkdheWQwdmdrNG5TNzlBTC8xY05YNW9lVzUxaHhtb1E2M1NPb1VsYUpK?=
 =?utf-8?B?K1lFSWt3cWRFTEx5N005cUxPQ0c5b09odHd6T05VS3BoTzhsNFQwL2Rqcktr?=
 =?utf-8?B?bkNtMXBJWlA3dDF0bFFOSnF6VXpMU3FWUFBKcmdSUGU3VnRQeXFSQ0pWOTIz?=
 =?utf-8?B?bXBVSzN3SUQ2UnNxWThUYkM0TWFLK2RzT3NENUVaeGR3dERCQks2MC9hS0dJ?=
 =?utf-8?B?RTgwaW91dHNJODJ5S2pmL1NybGx2ZkFNcnE2UUhZdnNLOCtZRC85RHF0TnVG?=
 =?utf-8?B?NUdOWittbTdkMkJWVCttVEVGQ3VTNXNtS3gyYSsrRVBOK25HWGFhZnk3cUI5?=
 =?utf-8?B?WndEcEZWaTBiRzlQSFZ1RjZTZm1XaFRpdit4M09JTmlYMythMHZKUS9MczRL?=
 =?utf-8?B?dlNWdFVMQnk5bUVhSTZRZGJBRTN3V25SNWd6MFUrbjNFcDloL3dRdXFPZ2Y4?=
 =?utf-8?B?NVljT0FyQ203Sjk3eGpPenRQOU9zMGEzbDlGZEdQalV3aXZtcURyZnlCZS9I?=
 =?utf-8?Q?uDoWWQh71V6lpbPQ=3D?=
X-Exchange-RoutingPolicyChecked: fIkem+G62e5eA1bWhGjKLldE8DedZauNgldAaD9UxYfxYkg8m6Fkk2KfWgyXT/2u6tML6hi7G07e80bdBWL3oWr08ykeQNd3+MfP3ayLavXtVC+oS+wBNTaTsAgU1Gtm/0/UYwgZdlpzKpEznvj93sVsGGg287ZoQBXjj2c7E/uS6jwFE1k9Ff69l2l3rpHQAaMXDIkFthzfROME/vKgrphLYspQTm3NbYXJuzC8HF7NdQ0Oeh9+r+KwwUk99g9G/NLpY1+lNVq0TwIlLHxMeHqpjRYjTkatrsuYBq6HJyMhaK+kURWctYrPFOaTkcuISTlRp8/ixuS8rYkRXp+Egg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da17b92-f50e-458a-0fa4-08df1565a12a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:17:15.2197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbJLEPjUddxfv+4FbASCQfcnf+Xj3zDVjPXK0l4XXuIU9Ym+dYd48aiv+4JcLnqk8sihPSWUUf9ijzmHULaGm306q4ihSaL0tz3xCUr9l4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
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

On 9/17/2026 2:26 AM, Stephen Hemminger wrote:
> On Wed, 16 Sep 2026 13:18:08 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +
>> +/*
>> + * This is a common header for Intel Ethernet drivers' flow engine
>> + * implementations. It defines the interfaces and data structures required to
>> + * implement flow rule engines that can be plugged into the drivers' flow
>> + * handling logic.
>> + *
>> + * Design considerations:
>> + *
>> + * 1. Ease of implementation
>> + *
>> + * The flow engine interface is designed to be as simple as possible with
>> + * obvious defaults (i.e. not specifying something leads to behavior that
>> + * would've been the most expected in context). The point is not to produce a
>> + * monstrous driver-within-a-driver framework, but rather to make engine
>> + * definitions follow semantic expectations of what the engine actually does.
>> + *
>> + * All the boilerplate (flow management, engine enablement tracking, etc.) is
>> + * handled by the common flow infrastructure, so the engine implementation only
>> + * needs to focus on the actual logic of parsing and installing/uninstalling
>> + * flow rules, and defining each step of the process as it pertains to each flow
>> + * engine.
>> + *
>> + * It is expected that drivers will use other utility functions from the common
>> + * flow-related code where applicable (e.g. flow_util.h, flow_check.h, etc.).
>> + *
>> + * 2. Full secondary process compatibility
>> + *
>> + * In order to support rte_flow operations in secondary processes, we need to
>> + * store which engines are enabled for particular driver instance, and resolve
>> + * them at runtime. The engine index (its position in the engine list) is used as
>> + * a bit position in a driver-specific 64-bit field of enabled engines. This
>> + * way, the engine definitions can be stored in read-only memory, and referenced
>> + * by both primary and secondary processes without issues.
>> + *
>> + * For this to remain safe, flow engine lists and engine definitions must be
>> + * immutable for process lifetime (declare them as const).
>> + *
>> + * Note that this does not imply that all drivers are therefore able to support
>> + * rte_flow-related operations in secondary processes - that is still up to each
>> + * driver to implement. This just ensures that the flow engine framework does
>> + * not prevent it.
>> + *
>> + * Engine callbacks must not access or retain an `struct rte_eth_dev *` pointer,
>> + * as that object is process-local; use the process-independent
>> + * `struct rte_eth_dev_data *` provided by the framework instead.
>> + *
>> + * The per-instance engine configuration is set up and torn down exclusively by
>> + * `ci_flow_engine_conf_init()` and `ci_flow_engine_conf_reset()`. These functions
>> + * should only be called at device setup/teardown by primary process.
>> + *
>> + * 3. Flow object lifecycle is framework-owned
>> + *
>> + * Engines are expected to treat framework-provided context and flow objects as
>> + * storage they fill in, not storage they own. In other words, engine logic
>> + * should focus on contents of flow data, while object lifetime is managed by
>> + * the framework. Engines may still allocate auxiliary data, but only in places
>> + * where the framework guarantees a matching teardown call, which will give the
>> + * engine the opportunity to release said auxiliary data.
>> + *
>> + * 4. Pattern parsing: flow_graph and pattern_parse callback
>> + *
>> + * The flow engine framework is designed to work hand-in-hand with the
>> + * `flow_graph` parsing infrastructure. Each engine may provide a pattern
>> + * graph that is used to match the flow pattern, and extract relevant data
>> + * into the engine context provided by the framework.
>> + *
>> + * Engines may also provide a `pattern_parse` callback that is invoked before
>> + * the graph parser runs. This allows engines to handle pattern items that
>> + * don't fit neatly into the graph model (e.g. FUZZY items that can appear at
>> + * any position), as well as ignoring the graph parser entirely and implementing
>> + * custom pattern parsing.
>> + *
>> + * There is no way to completely ignore pattern contents for the engine except
>> + * for defining a noop `pattern_parse` callback. This is by design, as such case
>> + * is considered rte_flow API misuse. By default, even for empty fallback case,
>> + * a meaningful pattern (one that is not empty or ANY) will be treated as error.
>> + *
>> + * 5. Setup, teardown, and flow list lifecycle ordering
>> + *
>> + * `ci_flow_engine_conf_init()` and `ci_flow_engine_conf_reset()` are
>> + * primary-process-only (see point 2), and the framework does not serialize
>> + * them against concurrent flow operations or against each other - the driver
>> + * must do so.
>> + *
>> + * The expected sequence of calls for a driver instance is:
>> + *
>> + * - `ci_flow_engine_conf_init()` should run from the driver's `dev_init` path.
>> + *
>> + * - At `dev_close`, `ci_flow_cleanup()` should be run first to drop all flows
>> + *   and their internal tracking. Then, `ci_flow_engine_conf_reset()` can be run.
>> + *
>> + * - Devices may or may not advertise `RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`,
>> + *   i.e. support for keeping flow rules across a `dev_stop`/`dev_start`
>> + *   cycle.
>> + *
>> + * - If the device does not advertise this capability, flows must be
>> + *   flushed via `ci_flow_flush()` as the first step of `dev_stop()` (doing so
>> + *   later may interfere with flow uninstall).
>> + *
>> + * - If rule replay is needed (i.e. flows were kept rather than flushed at
>> + *   `dev_stop`), the driver should call `ci_flow_replay()` from `dev_start`
>> + *   to re-install the kept flows to hardware as last step.
>> + *
> 
> This is excess commenting, which is the kind of thing AI likes to generate
> unless you tell to get to the point. Even AI evaluating itself said:

Such "excessive" commenting is intentional and it was not in fact 
written by AI, it was written by me :)

This is an Intel-internal header so this can't be in programmer's guide, 
but I do need to spell out the design intention and constraints, both to 
prevent future misuse, and to enable far easier and far more precise AI 
review (because now AI can read all of these comments and notice if the 
reviewed code does not follow the design intent). AI calls this a 
"design essay", and it's right: it *is* a design essay! That was the 
entire point!

> 
> Warning
> 
> Comments are far longer than the code needs. Roughly a third of
> flow_engine.h (587 of 1620 lines) and flow_graph.h (175 of 507) is
> comment text, and many comments narrate the obvious or restate the
> design document. Examples:
> 
> flow_graph.h, _flow_graph_node_is_expected():
> 
>    /*
>     * In the interest of everyone debugging flow parsing code, we should
>     * provide the user with meaningful messages about exactly what failed,
>     * as no one likes non-descript "node constraints not met" errors with
>     * no clear indication of where this is even coming from. What follows
>     * is us building said meaningful error messages. It's a bit ugly, but
>     * it is for the greater good.
>     */
> 
> flow_engine.h: the file header and the struct ci_flow_engine_ops
> comment together run about 290 lines of design essay. ci_flow_parse()
> repeats the same match-mode table that already appears above
> ci_flow_engine_ops.
> 
> ixgbe_flow_dev_dump() and i40e_flow_dev_dump() (patches 4 and 13)
> carry a 13-line comment explaining one if statement.
> 
> i40e_fdir_flow_install() and i40e_fdir_flow_register() (patch 16)
> open with paragraph-length comments before a single condition.
> 
> Short one-line comments are enough for straightforward code. Put the
> design description in flow_graph.rst (or a short block at the top of
> flow_engine.h) once, and drop the per-function restatements. Trivial
> comments such as "/* success */", "/* is the pointer valid? */" and
> "/* engine looks valid */" can go.

This can't go into flow_graph documentation because this is not ethdev 
header, this is common Intel code. There's no place in documentation for 
this, at least not that I can see.

I'll see if I can reduce the number of "obvious" comments and any 
possible duplication, but I would not look to reduce the overall comment 
style. This is intended to present a complex system, I *want* it to be 
well documented. The fact that our driver code is *not* this well 
documented is why it's often impossible to reason about it.


-- 
Thanks,
Anatoly
