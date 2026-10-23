Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B27606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Npi/66rg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E54AD40276;
	Fri, 23 Oct 2026 16:55:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4F140265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792767315; x=1824303315;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vdyx4u8xWLu+PBE7+VM+CAoIIMzFXnikAlq2W8XfGvw=;
 b=Npi/66rgyIm77Vxc60n0Aui2aRTbn1VcezfO9nXtYzOg1ZMnwV2fwWOv
 +KQIXiXVcVHoq6E1oMonao8C6/0xsDxApQzyoHv3XvrcGvJ0c9cA3X6zw
 2AO/xb5NPPbkuf6FRzzBKhvGU5Xz5kd+MDUdhh2xGo8OZ1VHw4whVPSiz
 UMHLm43fawj/M+yaJKWYqVeN/Wu7F5V7Pwu9p1vIG+fwetyFmnDOkHeX3
 87UheMUh2Mb7OB6ukqStvk0dRoFqZGPhBbKz1v1dLPbvxRAcGdpi2jXBS
 HVZj/4r2SUn3t4fjbiyjKFlCc/w1Hpo4/T3dqzrnwK2XhGTrLYOTZ6FTn A==;
X-CSE-ConnectionGUID: bKItNEGFS3e0mhx1vgsw2g==
X-CSE-MsgGUID: IC0+fkrjTYCK30DJzVGa8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1543943"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1543943"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:14 -0700
X-CSE-ConnectionGUID: XACbVkw+TP2hx6v7ZUJ8dg==
X-CSE-MsgGUID: SxYoDA3ZSxWexYeSTa2UuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3548677"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:55:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6hV5EtjVkxSFQGOizeYJpQauSfgVjo6e2bW8NDIscbIev1bx+HJxZxRFq77OaoSID5vUR3EDV+BNxfKwFHMXBI0GrOEfj9AKq7dKmLUIPu3CCN00GD8J/A7Zv0Sys8LxvjWkh6yW6JUhVnmISSWm+cFDttXe0MMLc+EyGcJuSgoMrE6HPDKxWabjvqoaY9xiuN3Ij5pP6WYIQ53fV0Z4r0EdQxNeSMOQVDtCOweXYWjUW4PFCCOWz3QChOrmGShlihiICqEpL9Tu7D+/zkyvzSpC0VXGap3p6bkxoKjailntq3HhfXyzxLM/jGcmsxH1i9iKAN9Jue71WEGmi76sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFxpxgYE/rN5k4ByQabUJ+fAenxH5LLDQU0MUb6iEfw=;
 b=DhxpNRxuJJANWTqhRpIxKE/o/2uMmvOYpIQlhe0sZIPsWE6DQFfopY9rsZwN50UTib1PCz5Mo2Yef2jROxK2sBwsgqGt6PrEuUT4cYnPhyY54QnGy6EoP/kXVtD3lUQpMnts7tknuii9DjBHeaywdcT+NyHP62WhwgdwaF+8c+ShRkidaLhybbbT+dJtsaNTCrUpDn8mdx5NEIBS+4p9YwxpFThXfhKX5lQGpH5Dp129MHzQGo6pSXTXksSIAdpkvXTZ/tvHPU3JhCNUfRgwUJXZDKOtU6UV5YU2ScffOFbiBXrb04YdCuExxo4i0hNNe/qaIcfQxh07pBEcjmNcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9371.namprd11.prod.outlook.com (2603:10b6:208:56a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:55:10 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 14:55:10 +0000
Message-ID: <59ed6f21-befd-4ad8-81e0-c5257ec389c3@intel.com>
Date: Fri, 23 Oct 2026 16:55:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] interrupts: fix event arrays copy on instance
 duplication
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>, Ray Kinsella
 <mdr@ashroe.eu>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
 <CAJFAV8yi8VxCz8kyuw=Qz155KPzWw2OPGMPJ0nRH+HhBFTMHsw@mail.gmail.com>
 <0615fe20-ce56-4ce8-a7d6-be46f741949e@intel.com>
 <CAJFAV8ypGhAUU_XvFrxe9nMrxCWXwRmYL6sqzPjT0UKrYQLw1g@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8ypGhAUU_XvFrxe9nMrxCWXwRmYL6sqzPjT0UKrYQLw1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0188.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c2277a-28ca-4c3f-4a3b-08df3115a298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0OG/jVYSRe8MbpfX7GUNsyhzN0a1Q7ySzZ/wzWupBavvHH1i8Zyn2ewoiqpOrELN06vxH3ZO/pO6fZSGUAGrkQl91ZQXHmezzs3zxq0W08fRrhc+SA1s14bKSu6kSJWy3sIxieQ8suv1xGMTiZIKm8Z20+iG7iAxCMJyK8m0cF+smbRTH9Mm6G7CaC4UTtxhO67tp50daKkWFB+sgPLtqqNpJDl5SbE6oXu8FbaA4dhHcFVi4c5Ynp3HIUU9cgVdZC7mityc1jN0LycpQiagP3oUKXVKW5WI41gMVj3b01uEQyAvfufGxdQo3ExgCVHpXZMn98XxJKu+tXP53aSy6rfrD7evs7xz7IK5fq68W1xyCmxpaLplwULyuaK3U35bMBj8fzO6ais5mROFt4XUVg9anKgChOZFwf0LKfQMlFmORhXX1hd7f0JZ/SNEmwYZEHKsvfzCDMt5NBXmijiadSvBt2kSeXWr1ZHS8JqUJlToV7tNyY0vmTk+HHMdrljqk1fNozH/Vz+9EodZTJY4+xVlq6iEGUzj5QXTtbzmbMyXg+9d9zdK11UgzN48r4haD7PnaPOAZebug/IwX+H6EEPpY+U3kyfAYhgq7xZbvnR8318wcIFlAg3qDL6SsAD/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHkxUnJWYlhxV1FRUjR1Z3crakxoTEtvL1Vtd3hCa0FiNnU5QUMxQVpTY3p5?=
 =?utf-8?B?TmluU0k2MHRkS1lBajFjYnhFRmdHTW1lWlB5YUdZcUJOSmpGZS9VTUJwbGJK?=
 =?utf-8?B?d0hGcitocnBsSk9nRVlJeVgzWmhIV3VGWW9yUDVxOVVKQ3pzRWlSMnFsalJW?=
 =?utf-8?B?a0lzTUd1TURoM1h5bkYzMHBlU1JLQmZ3NTJKWmwwNVhEOWdiWFhhZkdVWDRT?=
 =?utf-8?B?MUhyYTYrVU9hUTI0eDlYejVCbGpIOStOQytwY2RmK3ZjOTFGVFZDdzFnbVlJ?=
 =?utf-8?B?bmswTkthR0R5dHlKcTRUUWJMSTdQUm00NEY2WW5CQW5Xa3R2czlMMzc5aklv?=
 =?utf-8?B?NnVKS1JSV3hvN1VhYW5QcUoxVU04elR0bGc0Q096N2VhQUd3Y0FUK1hFSTRm?=
 =?utf-8?B?cDRDMFBHOVQvTlZWTmxjbnpDdDg5YktKVEtqaktjZ1dRL3BXTyttRjk3NSsv?=
 =?utf-8?B?MElnYmtPZDAvSmZWUmtIelI5Sm1GRUlrL3h0V1FzcEZEMzFDbGtlZ3FTRmNI?=
 =?utf-8?B?V2NGdzZSUDNFUCthalZEN0NoS2RpaFgrenQ1OW5EZE9kR01YclVvRlRJOHd5?=
 =?utf-8?B?YXNuRWNzK2tWMUpRSUtXSjBvSTFLWi9xRWVEZWs0azQrOXdxcVAxbmhOZXYy?=
 =?utf-8?B?NmJ6VWhXNnRkTEZiaWx0SFdTNThCSDhMemxtc1ByYUxnN2Fhb0IwNkRTMml3?=
 =?utf-8?B?dTE1VU16VlNEUmVJUzVlaGpuSFJqd01nWFlLcWtTdmt5SGNQZXBsdjU3ZERl?=
 =?utf-8?B?TDN4WENzaUsvaFJrY2hLUnNtUDJWc1VlZlJQeVgwVUl1bmNiSXNCNVJFN1N5?=
 =?utf-8?B?WW5paHdsRG9IUXFncFloZEVSRmRYamxzZ29sYmpSU3lrUklGT1k2VHh5d2s5?=
 =?utf-8?B?bW04RVplTWRobEZ1ZlFwV05NWnZsMFVyWkJlaHFhUmRDVVZ3RUhKY3ZDN2M2?=
 =?utf-8?B?SVRDbHE3SXhsWDI3cFkzN1pxblluOTdLM2dpQy8vQmRseXJsYzZBbWs4dXAv?=
 =?utf-8?B?QTFmTlpteHRvTzNiOFkvQkQ0TFMzSVFCU1UwNHVYSGtaOGhxc3lkOTBUNmpq?=
 =?utf-8?B?VW1VYnJpM2hpbzdIMTlGbmljU2VEWWR3VkE1YW1GVWNwQWpRS0hJdVBqQkR4?=
 =?utf-8?B?dS9NOHlxVnhJL2FpNm14dnpaWWZmWWoxR2FwTXZYODdTdDdLSnBVcnllWGdv?=
 =?utf-8?B?dTJtVlZISFlTanFsNjFxYVRrSjdMajFzZlByd3JGWFBDdWg0MUR2WjE4bGRY?=
 =?utf-8?B?WnNCa2I0Y2FQbjFDZ3RiNVRIbWsvekxHM2pxdWhYWkE0YytoRG1ZN1U3endO?=
 =?utf-8?B?Y3BTSitYakpZWWxvdXR5SVF3TjRXQnROWlQ2NDh6QmhmY0QreTB6TGlnTFhE?=
 =?utf-8?B?K0dyM3F6TlV1eFE4K3dQVWcvY0cybml6OTBndDlScFBIZ3UrY1Nsb1BzcnU3?=
 =?utf-8?B?SEJIM0swa3RhOXJ5cVVTVUFqeWFoSnZwT2RBMGRKV21uWTRNdzczOHRYLzM4?=
 =?utf-8?B?WTRHdmtYMTdlTGRPQjJjZ2x6QWp4czZJRzFPWjA1Vm53M0xJU29hVjR1cGhn?=
 =?utf-8?B?bXQzUkZrTS9JVjNSc1RTSDUrWFBYYWRlN2tLcGxhWm53Yk15UzhOOWxDUE1z?=
 =?utf-8?B?bXZKVUVKK0l1WS9nQnc2TDhqMlZ5RG81QTNkb0tLZnFhYzFTaXVwMlJreU9J?=
 =?utf-8?B?OThhQXNVS01MaC9XbXJHWCt2bVFEeWdnNEhqR3Zxd2dISXQ5bFZPOXloTXZV?=
 =?utf-8?B?ZlNBQ0g3VlNBeEk0MmIrZ1ZWbWtYSVVIVVBoWEcrUS95WDlqcnJwYUVqa3lC?=
 =?utf-8?B?bzRtbkFkb0ZaQTZ5Mlp2dWhaSlJpTGdHSlR0eFNDVkVQSm1uMWVNNUI5YXlX?=
 =?utf-8?B?ZHBXN2RqYm5oUnQ2T1FhOVU3QW5zenN1OUo5Z2IvUUdDcm40U0Z1dFZjc2Mv?=
 =?utf-8?B?cjFPZzVBWUl4dVFoaDFqSmxmb3o0N1VnQlZEaUtkTXNMdjZmakxrRjlBd0Fk?=
 =?utf-8?B?M1BteStsTnZhUE1MWVNSNXlGZTRZVjEzZ1hqbXBJNWc0WGs4YUpWaFd1eWdq?=
 =?utf-8?B?c0hTVGtzUmhadTBueWI3NHpEQytDZkYrbDhkdnNyQWt5VURxNy8yNERmUEdy?=
 =?utf-8?B?a3dxOEV4VmE2emI0eHVpTkt6ZThyS3FFVWo1M2twVFY2UjV2MDV5VzRaNmI3?=
 =?utf-8?B?RE0rZWMyYmNWdWEvdkJzNW9EdjlHK21JNC9RZFhVRytIZWdNOU11Q2Y5bnJP?=
 =?utf-8?B?RS8zTmFJL3lqVEY2blNrZkNzcnJNZG8zUzM0b09TRk00RVJhVjlWazNhRzlM?=
 =?utf-8?B?dG4vSjZLKzk4V0pmTEZNd0M3NkFpVlhxeFNtc2toKzBpcS90WkNNQ1M3Vi9F?=
 =?utf-8?Q?8LgVCmHEhqxMduok=3D?=
X-Exchange-RoutingPolicyChecked: t4+cRlAhKytV2aFvG8T+ICtpiWkzTBcAq/0q2kkREVaH1uYYdA+VxTdaxydlKnNWU7MxbqekYsBldsPeeQzqRSvtvkHl46tJInr9wsCcOxmVaH8XiKe+UAtrO+jMpDManZ2iEYBE4vQ2t48dEol8MRWEvq0ReiwS1XY9foLEkPcOPswpbvCsJJyFtbwRhejhCNpQ8ngWF/HqC60P5XoPnNi4Y6rC+90pWXAWyrwEzcHeNcBjS9jw77t3rkmm3rXU4VXU2pJWVE9wjg+x0KwbGLYPf5E7GyN1r8gHa4CsGsCBhACOytRKH8oz3yZOaXw5tLOpJfZCpaGEDDzhSAYt9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c2277a-28ca-4c3f-4a3b-08df3115a298
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:55:10.3514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj6PJ5OgttZ6OlHtmzfPXDK1W8g6ZbRiANiRxCBozXww8+X1xJvkjJasVQTaF6u/GRvTEPVDZUQaZQxiNDnIW9HLnFH/9JpuurtS+RuFy3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9371
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

On 10/23/2026 4:44 PM, David Marchand wrote:
> On Fri, 23 Oct 2026 at 16:37, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>
>> On 10/23/2026 4:15 PM, David Marchand wrote:
>>> On Fri, 23 Oct 2026 at 15:51, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>>>
>>>> The event FD and epoll event arrays are copied using the number of
>>>> entries as a byte count, so only a fraction of the entries make it
>>>> into the duplicate.
>>>>
>>>> Copy the arrays by element size.
>>>>
>>>> Fixes: b7c984291611 ("interrupts: add allocator and accessors")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>
>>> Thanks for working on those issues on such short notice.
>>>
>>> I already put a series for fixing a number of issues with interrupts.
>>> As part of it, I would remove the whole duplication principle.
>>>
>>> Could you perhaps test your series on top of mine?
>>>
>>> https://patchwork.dpdk.org/project/dpdk/list/?series=39749
>>>
>>>
>>
>> It seems that your patchset makes most of mine obsolete, as only 3
>> commits survived the rebase (incidentally, the ones I had in v2), and
>> the conflicts were trivial enough to resolve on apply IMO. If you like I
> 
> Indeed.
> 
>> can rebase my patchset on top of yours so that you may include it in
>> yours and take over?
> 
> I don't mind taking over.
> We just need to agree on my comment on the last patch.
> 
> The other two fixes lgtm.
> 

I added my comment to the last patch, so feel free to take over the patches!

-- 
Thanks,
Anatoly
