Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39BC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88817427BA;
	Wed, 16 Sep 2026 13:20:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0BF2E4067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789557614; x=1821093614;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MH+wiAvC+Zu3Exg18iblVxJ3qTAYEWtsmT8YjglMSw8=;
 b=VwyNa7OhC7/JaHUdzaS6cHxRxPv+GSGJyw8C0Q70Tr0Q9Me2kwrHPXI0
 6jvphLOaQ4OMjZnsCNoDTV87me6uYlWRgXQSEGgXhld8U3jfiGullojQd
 Z3rlrkNNAvipv4OLLL0Tmh8BNV5I91W6AtXvkNK6uCZtJINK/KdDTGnlQ
 F8FDvVoPOf5QBe7PB+8Xoe9MWjt7iDrgxAtSvwrupYGzyx74bIwDLu36P
 /98Kca17WPYsUiWFlIysGn+17JE5wOdwlYuAc1M2p7G5GpNj7W6QVR4iJ
 CL1ucL4wVnbcFmGog8vJlOPyFSTkOqg2qqLldBNExEqtQIYKwlscBCZAr w==;
X-CSE-ConnectionGUID: CKCiUDQZSq2v49QYLzEikg==
X-CSE-MsgGUID: 1YBvU4ZATamsO6u5eap5sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100528752"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100528752"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:20:11 -0700
X-CSE-ConnectionGUID: Td4oXFi2SHawaMj0IiBTww==
X-CSE-MsgGUID: hIBmlKJYReaBi/I/yLjMPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277062178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:20:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:20:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 04:20:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAslKhvsyKY4ICZXGVc6loK6fxtagZAmTOYOOq0AXvmfTciOvheif1J0chg4Ks6jUMO4O/jw6NX/DGyhnBriwaIDxqUNdUwAVEh3KNODNraltcKix9rwkQfDmZdEwaY7+SQnWGbxvRTEm3OTgkcMtqlgOqw8FtAx2kw/2PGxXJhthzSWfBU0LEydkSg6qC6JraK5C50fsGxi8lInqDXImeqKbtasavQsvj71nbf15m9p7PtGhTya1bhWVIiK6uQ8JbS26Yl3JJoxXWkzyF5GnvbvWn6U2gp4ajVkdq2WH3YVPmHqTdCOOaZqlkWhSuiWqvDCi0gvSC8vF74KSpl+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK9zs3O50TnGYZlWdjBvF5IUjZNpP5kEUc+QByVd7uU=;
 b=pkLNrhyZbNl9VBj2BCUvHAL+DBBF5KdrAoWK1BQcTX9iq6N97uXzlyoW3a0/hmyT7yUZ/6Ox6CFCT8WhGMrq9r6kbP63VULOtnUtZcISd0M2ybM64SLVW+5uJbmQgMCu27qcXebjebsWFMrRaH0JhQiS+6E27gzBSKR5nZWIeANzQgDBMpoCqIjPxcW0GaTdBFRFuU4qDOuAIIrRtnSrZJBVlLGeWbhaIP5qOwl/lT2PrwsrWmBOtHsaaSs1S45I/Rg3LMpg2w2wCz6QeMEGmCbzRVUR3wycq9G9xz/KduBdyk7Z1HVDl4BYeTs3luq7b9otKB6wQhZg0yKDcKIlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PHXPR11MB9687.namprd11.prod.outlook.com (2603:10b6:510:3ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 11:20:08 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:20:07 +0000
Message-ID: <03fd0cad-30d8-4754-8065-0216ec8328b4@intel.com>
Date: Wed, 16 Sep 2026 13:19:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/26] vfio: cleanup and refactor
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>, "Leon
 Yu" <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cdedc9f8885ef46eb5a903c907c3b2bfeef0704b.1789044747.git.anatoly.burakov@intel.com>
 <CAJFAV8w8GbvBRQ+O5LkL=jJ0f57Y4XaKJbqXJjxpgk94Ane6Wg@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8w8GbvBRQ+O5LkL=jJ0f57Y4XaKJbqXJjxpgk94Ane6Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PHXPR11MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c1681c-7b00-40d5-9a94-08df13e476c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|7416014|4143699003|56012099006|3023799007|11063799006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 6Eq/oEnqJ9/NP8cHrljC5h3VYl0PGB0pBJLxw8vkuXt6zxMxv5RSiRBBEr4k5zCjjTo+oUyBK4O+X5kBpL7UtlvSO56kVZLbjKY5p6CLVBmgI+8hxOURfvld8zng1spNPZDYyVUJqS5WYcEZbjHHSHrVqAhcTL6jzG0ayv/ejBav0zoWr9TB5CRKezLy3h17qBVH4Et5RMwS4UFFGCET0dh0TGjfVpjFZjZ6fHwE+PyoVcrie8crhBi+54ZLu3SOQaetiC0lBGVIRNc1MX3wM9DGWxPoRFEq8DiGNlNviqW7Lebx6TD1yW0hXx3khIbP82kMFwomPeHIyD0PK2YfA6iQUUtU7lqcKy/txLFenrViXY0fhlpWP3AzaW8SfQ/2JEYwH0TMJL4NfqnCQYbSw7a4pto+7CoU4IpPJhJQcNkTgcaUqHr45j2N4bXMhcOSRECtuy/4ZjcgYQhuo3dp7SVBLGNMOHYh9QgXXkqavxDGI6rV2tIOGY+OUN3FZbkisI4dwGO9kgSkYejWPr/GZF0BKTUxjIQ4b767V+PB6yUwJvNiKTrK7QKL2WCLVM+uE6p2Uc1+IknmphNZJYmTnRe8cr+TiySC5UfSHmBSIlqBpIrJBTz00hClOD+GKpyBGoEGmex9aN48/P0/mL5obh3WWpnFsg6eMh1tlCjhars=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7416014)(4143699003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzYxNm1zN0R1bXh1ZFY0cmZGei9FUEtrTGlKYUtSZU5XYWJPOGQ4NXlhaFd1?=
 =?utf-8?B?QVMxNWJWemI5c0RaMEdnRmFSWkMyV0JlQmJrK1hQTUdVK0JDZ28rNEhuVWt1?=
 =?utf-8?B?TFA2enY1UkprYStyYmp0OVI3d0dVZXZ0MTdQR0tkeldOSDdwY3c4K2FKdmpH?=
 =?utf-8?B?MDFDMHRQTEkzWVlJNWdRVlltS2l2bHo4a2lkS1NMeFQvSWZkZmJWK1d6RERV?=
 =?utf-8?B?Vmd4VFY3eGtva21XR2VJQ1BvVHFmZ3NGZ2N5TXVBeFJIRFBETjhUNnhuQm8r?=
 =?utf-8?B?VWxiN1NnZElmdytwSVVReUFOczY1OW5ub2NPNG0xZXFPWVNoaHRmVStBa2Nh?=
 =?utf-8?B?dHU5SHpBTGlxNkZWSFhBb1N2V1p2WUxpK0FkTlo1V09obVNDVnR4Q2ZhYTkz?=
 =?utf-8?B?N0Nwb2JDRWJHTVhYcnVUOWx1SVRqdmdxREJDRlhnZXJZWHVaWU02QUxGemYv?=
 =?utf-8?B?RXFuN3o4RlpSZmxXcW5IUTNQdFRmSEdxTU1lNXVCK25YdGl2dndZYjI1dk44?=
 =?utf-8?B?UGh5c0ptMElBYjVwMkZpL2Q4ZFlja0ZlUUN1aUxXODFGRHZOU1FDMHQzams0?=
 =?utf-8?B?dGt0SnhoMGVIYndMMkhESDdMZlY3YmRNL0d6VG5CM3d3d3kzQzMxYWFuYmVY?=
 =?utf-8?B?dFROVjE4a21vb1hFZC9NYlNPbjlVMDM4QjBiRHZQcUVOYlplbVFPaW0zWVNQ?=
 =?utf-8?B?WnlWSE44dmE4SVZQamFLR2laYnExQXoyd2huYkdjL05xZTJObGFXdnQ2eDFi?=
 =?utf-8?B?NDc3dnZ1WGcyeGVvdG1tdUFubEorckdjU2h2b3RXQmFiWGVwWmRZdEFnWWox?=
 =?utf-8?B?ekVoQzAyZXN2N25IVFdKd0FLQWtzT3h6WTljZHgzQ1drb3U3WXIySmNacy94?=
 =?utf-8?B?emtHUXRibW05ak4xMS8xOFB4bjN3N1Fpb1NORHVic0l1S0hnaUx4MHM3WElC?=
 =?utf-8?B?ZjVIOWFub2REdzZUVC9KR0U5RjZSL0lMcHh5OEkvN0pBZVpLT1hwNUpaZExR?=
 =?utf-8?B?ZzYrbGYrMTRNMFNhaXhYYWRlOGphSnFRbDJITjdVOUFjZkNMMVlrRVI5cHZl?=
 =?utf-8?B?bmtFQTBTQlJOY3YyR3RwQWNXWk8zVjQ0U3BDbFByTFlIeGRwRVZ5c2REQ0NE?=
 =?utf-8?B?VGJQTkgwREYyMTNwODh4OTZUUGR2NWZWaGE5dGVvZ0ZDTzMwalJDOVkvY29D?=
 =?utf-8?B?OXA5bDcwU0tBVG8wZFdzYWlEN0xuamc3K1JuRWJLL2g1dktJZzdFZE5PZWNm?=
 =?utf-8?B?V0MxdjkxU3Z6TFJCR0NjcGQrejRwMTNEeUtZdzBub0pQdFBFNnZXZGhUUXpw?=
 =?utf-8?B?eEhJc2lpTHpkVnhEYkh3T0R4VFVFMThzOUo1QW1qanJINERWWklCNE5DbXZ6?=
 =?utf-8?B?RFNGdnVNUm5vOEpKRVN1K0FSRXlKK1pmZ1pXTW5WKzRQWVNvN1lJV3p4SUJs?=
 =?utf-8?B?M3E4TER4SnpHSXl4RjJxNURlSDlIdWtmcldVT2tYQi9pcG1CcGxpNmQxY3BW?=
 =?utf-8?B?SnViSTBLZnNsZVA0Ky90STYzTFpZTU94enF2ZUg5NGV6Sm9IU3FCZ1pyek1i?=
 =?utf-8?B?dUZnQkl4dUJ6bTZwb05obThGbUphcWIwckVRRjhna2M2dEM0RzI1ODhnMVpY?=
 =?utf-8?B?UkpsQzRMdnA1NVI2Y0wzS2RuZitVT3pJU2NUWDBRbm1wR080VWFMSm5QVHg2?=
 =?utf-8?B?SG13TkczZzdpUHRKbUFIempMcG5nbUJIVzROaWlHQi9ZS3FYSC9nR0xCYjRS?=
 =?utf-8?B?NlRkUTNhRU1nS3VXU3lIeHBaTnZwTXIzcDI0SDlvLzd0Ykg1bkNvOFpuSGdu?=
 =?utf-8?B?UVg2TlJaL0I2ZDRYQTNVbjVqVkxJMm5WQk1ySEk0UmVTMnNpcENpZTh5dEw4?=
 =?utf-8?B?QVErSm9uK2ZLd0E3Sk1Uajc2bW9pNVNGdFBKL25uS3pXNXJadWh0UUt0ckRJ?=
 =?utf-8?B?c1g0a2RsWDBZekdXUzA1VUxFRmpkSlZvZnhDRDNyTTc2YlBGUGFMQ2ZHcWpB?=
 =?utf-8?B?NHRRQ1dZOEt0N2hmR0FlNi92M2FralB0UDV2WnYwcTZLM1V1a2lNYS9zTnNH?=
 =?utf-8?B?eE9IQXM3YlBiSWlwRGFpbWI3aHc3WHg5YXZGVC9xM3JRckRDWk1ONjdQWEQ4?=
 =?utf-8?B?cVM3UjhHMHJxMWVpRjMyOVBhc2FjL29WWGNncWczdE5zK2tPcDQ4S2szcDBR?=
 =?utf-8?B?bGJXbUpmZlI3MmhiMWFwMmRPM3prTGd6ZEt3Vy91OUJyZ21yN2ppZFQ5ZThv?=
 =?utf-8?B?MGNLSmtYajhSTEhESVYzbUFuNGFwbThKUUpNNWJLdTFORFFUck9nOEZFYUdi?=
 =?utf-8?B?MWVCRVUyUG9TRWMyWXdHTG5YRGZrOVBQNEhoYnI4TDNjVDN3eGVka2F3NzFC?=
 =?utf-8?Q?iHciI5uPmwDDaEas=3D?=
X-Exchange-RoutingPolicyChecked: 469SEY7hGFvjOvtBR36vBwykO1N8JJQ+sbz2EpwlLITkSlk+PXCBpPcgPj6ewrQZf0BI8iUvcOEPlhRdjVfoCKwQlIdfVjRU0TpLC6cCicMt+QiGYzRsSfqw6bPmFUNWQS+kBKbTHA1Cnjz8yqioZNPZC14oeIKeetseYlGX/GJtNVShDkX8J6ICNRP/RFxpo2lW/mmfScdLv2nz+50RihLi3MojE4WS9BmOfVSXFENfCtz5rDWEQosx0B9P1mmiTjYmwL4h5pelvBHSCwpgCs/X3iD0ApUfnDTo+fHeR0Vpfy5ETbZaCNxFoNrLzOt8fRWJN8bewf7XFHQcY0C5bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1681c-7b00-40d5-9a94-08df13e476c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:20:07.7441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVhtesmgDaC8AhDEWjn7BwB/nJsY7zSnZmq6uRpLYZ2v8bvcS7dPuT/Yihb4gKHHxZbY58lod6heSZAB6BB1h/q3PufszZWTUfWTqy/71BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9687
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

On 9/16/2026 11:42 AM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:55, Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>> diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
>> index f2dbf46481..c62d38e524 100644
>> --- a/lib/eal/include/dev_vfio.h
>> +++ b/lib/eal/include/dev_vfio.h
>> @@ -18,6 +18,7 @@
>>   #include <stdint.h>
>>
>>   #include <rte_compat.h>
>> +#include <rte_common.h>
>>
>>   #ifdef __cplusplus
>>   extern "C" {
>> @@ -29,8 +30,6 @@ extern "C" {
>>   #define DEV_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
>>   #define DEV_VFIO_GROUP_FMT "/dev/vfio/%u"
>>   #define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
>> -#define DEV_VFIO_NOIOMMU_MODE      \
>> -       "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
>>
>>   #endif /* RTE_EXEC_ENV_LINUX */
>>
>> @@ -39,28 +38,64 @@ struct vfio_device_info;
>>
>>   #define DEV_VFIO_DEFAULT_CONTAINER_FD (-1)
>>
>> +/**
>> + * @enum dev_vfio_mode
>> + * Enumeration of VFIO operational modes.
>> + *
>> + * These modes define how VFIO devices are accessed.
>> + *
>> + * - DEV_VFIO_MODE_NONE: VFIO is not enabled.
>> + * - DEV_VFIO_MODE_GROUP: Legacy group mode.
>> + */
>> +enum dev_vfio_mode {
>> +       DEV_VFIO_MODE_NONE = 0, /**< VFIO not enabled */
>> +       DEV_VFIO_MODE_GROUP,    /**< Group mode */
>> +};
>> +
>> +/**
>> + * @enum dev_vfio_iommu_mode
>> + * Enumeration of VFIO IOMMU protection modes.
>> + *
>> + * These modes define whether devices are protected by an IOMMU.
>> + *
>> + * - DEV_VFIO_IOMMU_MODE_UNKNOWN: IOMMU mode has not been determined.
>> + * - DEV_VFIO_IOMMU_MODE_SAFE: Devices are protected by an IOMMU.
>> + * - DEV_VFIO_IOMMU_MODE_UNSAFE: Devices are not protected by an IOMMU.
>> + */
>> +enum dev_vfio_iommu_mode {
>> +       DEV_VFIO_IOMMU_MODE_UNKNOWN = 0, /**< IOMMU mode not determined */
>> +       DEV_VFIO_IOMMU_MODE_SAFE,        /**< IOMMU protection enabled */
>> +       DEV_VFIO_IOMMU_MODE_UNSAFE,      /**< IOMMU protection disabled */
>> +};
> 
> My two cents.
> 
> This "safety" mode is ambiguous (for example, the bus/fslmc change
> looks wrong, as I reported earlier).

Yes, that's a typo. It should've been not wrong!

> 
> The main concern for drivers is the "class" (physical, virtual) of addresses.
> The noiommu notion was simple in that drivers understood they had to
> handle physical addresses.

That is arguably still the case. It is the same semantic meaning, just 
wrapped under a different name because I wanted to signal that using 
no-iommu mode is bad practice. It's still effectively IOMMU vs no-IOMMU.

> 
> There is some other concern about iommu capability that is not
> captured in the new API.
> Take a look at the PCI bus for example, where some decision is taken
> on a DMA mask.

Arguably this is not *VFIO* related (it's rather the property of IOMMU) 
so there is little place for that notion in this API except to group all 
IOMMU stuff under the same roof, which may or may not be semantically 
coherent depending on your view of what this API should be.

> 
> In the end, it may mean that the whole iommu class discovery (that
> impacts IOVA mode) should get revisited too... ?
> 
> At least, with an *internal* VFIO API, we can revisit more easily in
> the future, so those comments are not blocking the series.
> 
> 

We can do all sorts of things now that we are allowed to, yes!

-- 
Thanks,
Anatoly
