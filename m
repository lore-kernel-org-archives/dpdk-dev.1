Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EBCCA5FDD
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 13:13:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5BC40294;
	Fri,  2 Oct 2026 15:13:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7F8E14003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 15:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790946830; x=1822482830;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TslzK8iTT88HBtRqvTJoEvB/qqBg0mRusVXHOYYAGyg=;
 b=YxdQq41ej5jHcr8BuVm85i3HPuSawh7QqwXSxQijxMnVdM89zhN34XDq
 uOc6Dah20mXLgaxUWVq28XOEGpg2DPniWYcWGrszAcJd/nM3QMso74Xae
 5LbhXAxn/d2foi9/wJmAltuuDzSgPnmYMiU+P4hbkQbZiqF1vc3ylAC3/
 EEiRUbrQlrcgbq+fIFVPM5G0O1ttulvveRJMk5oGn4rJSWGg8c9LtjEtL
 XosGzSBFt9qLfiT+zIWYkLXcBBBoIO9kL46vn9+dWnvCtuUPI1cYjRMRV
 vPq1VV7uOCoS32+xExYUtMCJjJM40eYwEAM91EcpW7n5MRJMjt5TOhvH1 A==;
X-CSE-ConnectionGUID: a37ndpA8R9W7/oDPKFCZYQ==
X-CSE-MsgGUID: 0TpjHWtdSi+/d2uoEnX93A==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91812861"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="91812861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:13:49 -0700
X-CSE-ConnectionGUID: 1GhjpcjZRJ6jfGm6t6UgKw==
X-CSE-MsgGUID: InyZeQ6UQxOPS1aD/hw+fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="279497217"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:13:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 06:13:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 06:13:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 06:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8VsY9D9MX394dMzuqAiGUGkbpswz/2aiee7sifHfwfmqU3UXBlT4hmNLUP8oXJMd75dJK2PEFP+Rezi04q85l4BaiVeIjaklJYKd9JJeJTkfhYrZQbgbm/Z3J4Hidst2P/5pYoc4JoZ/kAhNn68k1SyWzprfQzRPzBUgdn/4ehdpxmayKx61BFJlyCgTj3Est95iFdh1UvI0i6Hrgf3zMhbKNSPKHBAs8Um61Is/WQpjki4qoa+jU7xyEM6qUryMGj+TZyShpHO++cEmcEMs9bkpeEjIFdO6zNuduhSFC1Dj5Cd+x1oK8rSwaZroYprr1W2eLbIfuktgZMFQPx+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxTEPvLiceVGF6CmsB/sQyFkMgimS5KyYz+7LgB0eQY=;
 b=LyfZBcO16RwNCFTjIf9nzAYW/KPUL6F14JFqpuhRKBvVcZntPHcXt2Cy1z1RqWK23oC3aehKBFGIcucy5CV6Vs+sLaZ+yrXmqUR3S/ff7aPCyxcKqxKzdPdjnKuPvsh5oAaRHaOcO0NLCUi56r9dLDPspp6DpsASVx3ZgQ7/Nh/f6sHkoIefwqvo0tMThcBNkkk+xqvq2kksEYNLJVLZKyIiPoPI1+Q4FZz+MHy1qpcX23TycW7fjLfyYftFRCYEVqkbdL/sBe+tnAO75rMnjhJ6EISYPxygGrZ48tEb0Uu5j3a88XzcTUsqoC0Y6zfVe9UDjzzViXA3ziNxdew9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 13:13:44 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 13:13:44 +0000
Message-ID: <f6b770bb-9619-48b5-aa2c-b233ca16d6f3@intel.com>
Date: Fri, 2 Oct 2026 15:13:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] net/intel/common: add flow engines infrastructure
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <63c3a0cb245f38af6da4d14547aaac9a4789c850.1789560944.git.anatoly.burakov@intel.com>
 <cabd590e-46ba-40fa-803d-fb0c559fd655@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <cabd590e-46ba-40fa-803d-fb0c559fd655@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: d798f230-b96f-4041-010d-08df2086fc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EVxbDex5vAnxW5eS7Xru3L9AYbWrEMeJk97UWwLJTO2mOpO5eJBiHvoK6w0lZRFVhLYj4/ZoEMhMv3tkS0ZoKUZE7ramyRCdRWEh8WrCgWNk6Qj5eIBy5zX3TfBTc1owoLwR0G63cfdOP3M/4U3ikOjYZ1D5iVmvdTGM3wrSgSe+ndRl1E0t7geA+5SP4xthAzrLJkGS4o7ohIHy88QYq6vRRLzSNiKIS7rvIQnuk11VUjQnC0DTQam8MtUnpCk7n+rkjvHuqEj27sk70N0NrjtyH+oRKldhryQSVHH8Jw69z23TEPj+dcMqvRMFxm+73k8HE/KPZkJ8Im4JDTyRG3fM8AjtMqvJ065+irQPEFqud8NL08BI31DYVsNT9r6EUHbCEPPyz/1IyPFRgvLXWZWwy59dHr6P97Ru2Le2PsUAgDOOvCf6IphFbSj7EkqcVBE9JkO+t2kyLJwugq1zgAKJZ2RWTm4w4g/MDLkmsq28KCRKWnZqYCu4QQtbMZXzCYg63ksloM6ov7blNjqBw28UOTQ/hVOPMdTpMyDHPVdo7oC+KzNSYygYeRpB/qwWP6fvkWn1xgXkSnioYa4/Fic9HCoikaxafG9/6Z4nmfQnVHAmLh/fJJpnPq7j5gZ1pxCnFEWu7mgIuPYlwtRYZxCZlBJ8VsjHzezpU3ZP4U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm8rdUl5TzF6YUxoelhHYXNac09meGJtcytiN09ObVRNQXMyb2d0SGZGdENz?=
 =?utf-8?B?dFp5ZFh4T3ZRK1RIMTdqb0FTMVlCcTIwTDU5ekhLSDF6elhTbHVQeXF2dFJv?=
 =?utf-8?B?M1ZkNUFMRGE4bWJDMzh4Q1RkV0xDYlFlUDZjUFJqQTVvenE1U1hMOVBEV002?=
 =?utf-8?B?clk1dFBDU1o0YlpBUkkveFB3VkNqMHplZUFBd285NkNhYUpOL3lZSmdKamJV?=
 =?utf-8?B?Tjh3NmxFbjNQZGJuc210ZmhQdUhTMG9FUTQyTXZpd0Z6WjZJSktMcjNDMExC?=
 =?utf-8?B?OFY2ak56UjZUV1hPRnkya2NsUGcxelRkNlBrK0YrclBQK01lcEU3K2txWWN6?=
 =?utf-8?B?RG9KaWNERFFPc1VxUmJDaEszRWNTcUllUWJGNEE5OEhRRmdkTkNmU3VNLzI4?=
 =?utf-8?B?TSt0V3FWWEJVQ05lM0Z1MVhyNFNjaERLQUoraHQ5dzRIMXpNTi93VVVrcFJR?=
 =?utf-8?B?RG9HOFdOUGN2SmFEV1NOMU95dmJLSlM1TlJFWmE4T3JDUXFNK21RVG5LVk1t?=
 =?utf-8?B?eGkvdGdONitjUS9LL2lyb2FxclYxYU5rV2FsZGo1WUgzbHFvRm1XOHVzRWJ5?=
 =?utf-8?B?bVV3MWRDTnhocjdoajdMVVVOZk51aHVNcGd5M3FRNXN6bDU2WGFEWEluZDZ5?=
 =?utf-8?B?UUJ2S0pXLzlyTnZRNlArRVZqTVZ0dlVCM2ZNcWpCaDhPTWd4MGtuVUVjbXhT?=
 =?utf-8?B?SktMbG1rRHNKUXIrTEJNejV0bDl5WWZhZjJRdXhXMHBmY0VsaEtBRS9EOHRm?=
 =?utf-8?B?WVgvMlhwQ05hbEkwR0IzcGtlU01Sd3ZiNkR2Q3B2TlZyY1BwM2xlL3pSeUh6?=
 =?utf-8?B?RzVsdXlmbFA2akp2NUtvMkdHZC9NR1JmK3pZN2JCNDJuZ1hqaFhWSUZOK0Rz?=
 =?utf-8?B?K3M5N1BCbkd5R2w3OHg3eHhkVlovYmNpSys1K0FJV2tTbkhSblM0U0R4R3Q5?=
 =?utf-8?B?VU9PZWpxZG1NSmlXMmRKZHB0dEZCQzF1Wlc4T1RaUkd5K2JLa1pyblZkazJw?=
 =?utf-8?B?Wm9KMEF3ZGRhNndBRjF4dGdLTHQ5eEJ0M0ZNVDhDeE9TVkhZTGtibzVISndN?=
 =?utf-8?B?dW5tOFNiZWVTQmVydzdnZVVIY3JHSE9QWWpRZHRxNEZuZHlLaE53UVRibnow?=
 =?utf-8?B?bnZWK3BHTmRaWU1WbE55VjRSeUh2ZjMxUHd5dFRLMkJONEtialBsZ1gvWW9v?=
 =?utf-8?B?WWJGNnczdFFxVlI3cFk4bUFEbjIwS3ZBQ2xEK3R1a0RER2NwUWZJSU5jajhs?=
 =?utf-8?B?S05QOWkvbVplLytjMkZzb3FidzUyZTNIcThwU1RFWEQwNnpLQ1hFeFRSUUNW?=
 =?utf-8?B?d2FILzdobkFNeUw3aUtKbFNpUWl0dGQyUVlOTGxNeVJEeXJNV2JoRGlwaHBS?=
 =?utf-8?B?U20vL2RLM1REWmpyelhvRE1CZkpNUTZqamhDTkFmZjJnSGhEWDl6TkNvU0JY?=
 =?utf-8?B?djFMSXllcUg3U2sxdnRyd0pLaElDdlVnVW9lWUdWb0syMEwrcThJMnZzcHA0?=
 =?utf-8?B?cEVVZ2Z4N2NuT0tsNXMxV3MrT2hXa1JzUUNDWlZJdlRZajBTaVJseU9tMy9y?=
 =?utf-8?B?a2V3MnV6V0Y2SkVsM0FiU3dhZVBWZ2RqQVlKYnBoLzJEZ1QrWUpxR2tOcUI0?=
 =?utf-8?B?WjEwcU5tbGFDZ0E1cVZjMDhaVEpKb0lBTmJxNWVlUDFsMk8wU3QrVUIvK0hv?=
 =?utf-8?B?UzdvaVJRQjJ2c29OQ3YyQ2lraW8wakVqUHNCZmtFTElMWE5uWVJud055RFBN?=
 =?utf-8?B?Wm1LUHU3L3d1VGdpcW9ETTZiUXp1VERxSkZvU1lDYnJBcU5ibEpUWnpQNnVl?=
 =?utf-8?B?VnlTY3hsME9nSldabjY3bkUvWit1eGEya0FtWERoVHdyTHYvc2VHNExtVFdC?=
 =?utf-8?B?ajJ6WFNmOHFaV0c3VXZYUGcyaVczV0kxZGdzd1JFNkJSbTVKakdBVWJJeDdU?=
 =?utf-8?B?anNReDRGVlArSThrYjVuSjNnUkNmUU9XTVpHV2JDWG1rc2k3UUxjUlpRUnY3?=
 =?utf-8?B?UmdMaTdiMC9uRUVDaDVuYy83MndEbWxUV1QrU1NoMmxVOFozd2Rnd2NtbVZH?=
 =?utf-8?B?L29tQ1o0SGdtZDVQVTd4WkR6ZGQvWXgvSGhyUy9CdjBpZWtTL21aclprcEhl?=
 =?utf-8?B?SzZTVFNxaDM3eUVhKzFlTHpuZU9ieFJGQ3BFQ1RUWmRTQ1N4VmZlZ2dLZUZT?=
 =?utf-8?B?UUd2L2pYNTRoZm9HbTU0OVJYQXBiQ2tHRmJienB5WXBFNFFRMTZxaC9MTThh?=
 =?utf-8?B?UjB0VmFveTVWRnc5SGtOR05mdGFYN3ZZM2xlbGRFeVVFbXR6Y3FMdWVNSGhJ?=
 =?utf-8?B?Mzl4aTFPTytXR3JCN2tYVHZ5WnB3L2NON201KzA2Wld4UzA5dVBlT0krYTY0?=
 =?utf-8?Q?CKDdBtsCnhFJpGS4=3D?=
X-Exchange-RoutingPolicyChecked: O8nOZubes7qFXGdtXil0eUt5vx2eXDtjVu2AKMOG02RpdQ1FjsFQQd93b4VkAYYNLn9OLc2JXDAPpIy3FLDBVzVkz2hnYFxh/3AW5jrKMpMkJrCwOztx0OjCsQE0EA37MWRCAXWJPueMmODUDYJD3P0S1RksirFp9+3cXJKQcAjcyykfPw0q4Vk5/oegx8tza11ftpelF/00Q0dBeMF36kyzPIdmG2KUuidJF4tFovJOpp7LVY17qwspjO3T4ppoH0q+0DFW08aHom7WAtfdoIES3GwXNA93dBFzKkhefhJizvZ7L3xqkAdVC4KyM0/vjtB2NiOoFiy0o7tVtOEY0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d798f230-b96f-4041-010d-08df2086fc41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:13:44.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeMHB/1I2cYjBkQSsGKEm+3yMJZ9LujzvY3JhGRfPha504aXp02iDNkUKlly0MqflNKZoLKwKapWlmTnLnpuS+Nxn3e5BNQk71Z4ypulNY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
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

On 9/19/2026 6:09 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Current implementation of flow engines in various drivers have a few 
>> issues
>> that need to be corrected.
>>
>> For one, some of the
> seems like a missed word?
>> are fundamentally incompatible with secondary
>> processes, because the flow engine registration and creation will
>> allocate structures in shared memory but use process-local pointers to
>> point to flow engines and pattern tables.
>>
>> For another, a lot of them are needlessly complicated and rely on a
>> separation between patterns and parsing that is hard to reason about and
>> maintain: they do not define memory ownership model, they do not 
>> define the
>> way in which we approach parameter and pattern parsing, and they
>> occasionally do weird things like passing around pointers-to-void- 
>> pointers
>> or even using pointers as integer values.
>>
>> Another common problem is extremely convoluted internal tracking, flow
>> installation, flow replay, and cleanup code. This infrastructure is 
>> usually
>> done in an ad-hoc manner that has a lot of boilerplate.
>>
>> These issues can be corrected, but because of how much code there is 
>> to the
>> current infrastructure and how tightly coupled it is, it would be 
>> easier to
>> just build new one from scratch, and gradually migrate all engines to use
>> it. This patch is intended as a first step towards that goal, and defines
>> both common data types to be used by all rte_flow parsers, as well as the
>> interaction model that is to be followed by all drivers.
>>
>> We define a set of structures that will represent:
>>
>> - Defined rte_flow parsing interaction model and code flow (ops struct)
>> - Defined memory allocation and ownership model for all engines
>> - Scratch space format for all engines (variably allocated typed struct)
>> - Flow rule format for all engines (variably allocated typed struct)
>> - Engine definitions that are compatible with secondary process model
>> - Implementations of common rte_flow operations
>> - Various supporting infrastructure for parser customization, e.g. hooks
>> - Support for using custom allocation (e.g. for mempool-based alloc)
>> - Support for replaying all flows to restore HW state
>> - Support for removing all flows without modifying HW state
>>
>> The design intent is heavily documented right inside the header and is to
>> be considered authoritative design document for how to build rte_flow
>> parsers for Intel Ethernet drivers going forward.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---

<snip>

>> +    /* allocate context */
>> +    ctx = (struct ci_flow_engine_ctx *)calloc(1,
>> +            RTE_MAX(engine->ctx_size, sizeof(struct 
>> ci_flow_engine_ctx)));
>> +    if (ctx == NULL) {
>> +        return rte_flow_error_set(error, ENOMEM,
>> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
>> +                "Failed to allocate memory for rule engine context");
>> +    }
>> +    ctx->dev_data = engine_conf->dev_data;
>> +    ctx->attr = attr;
>> +    ctx->pattern = pattern;
>> +    ctx->actions = actions;
>> +    flow->dev_data = engine_conf->dev_data;

> it was set in ci_flow_alloc()

flow_alloc might not be called (e.g. for validate).

-- 
Thanks,
Anatoly
