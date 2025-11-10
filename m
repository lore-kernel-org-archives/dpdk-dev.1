Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C3ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 12:21:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AC8A4026D;
	Mon, 10 Nov 2025 13:21:58 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by mails.dpdk.org (Postfix) with ESMTP id 32E1E400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 13:21:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbUH1RB4LiBRk27ARj3vY3SDjw0G2QMtPR+NfogtqybFMPBXcDgS2hDSN+y1ejoUwJR97xwTJKPgcrU2XCnhcc9QiEIRxcmrPFQspk8WQf/0DVHJEsv8fZ3CxG0IyMSEndi2FQtb1i4DDRskpcvTy5w2mcQBzUvp4hjTeHcOmr2glxo3lQ3refhNn4KvpynKiNULMqX6JYMd2TLke5e58AyoTAOEHneLTJD60aQCqAX2ibiJ3HF8pSHrDVvY3xlugy0vA8xywPKkVtPHdcWfkRxVNyPpqp2y446H310W7u/VuzdjJis+WlTFjb9N9BhLLYzJ3gJhFReagAEsQ4lnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6/5k3kRdv+Fj/430xaZfvl2QFJX5ZTJlj6pst4wWjk=;
 b=Iz45CJc2raKllYaLEpxq+hi8lh9zraQyDDuiPMnCzxiqj63hz44IH6V/k1JAfwGHhn2Iy0yN07FroSMBSA5RAM5IVJSu5zG6IF3Iy+jmOOdLN6Gl3mC6IVXRI7nAfd4mzYHwDOiAJHL2+kQpHTSI4QcHof+PunSlYEXnZpIZaprVz2m9S/EYd0W6tJauILyVKoy9cTx3YY8owVqwpJbxY2J5vZ+/rBkXqO30M3p2yNE5d0EfdmLLAN8JypPfFHWLleByJnA9rDjltUja9Hatop2FhRf64Hc5VRC3lmini7hcQS6muj90UPkyLEa5vWNyYE9jr2FNGrTSITeUWQpKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6/5k3kRdv+Fj/430xaZfvl2QFJX5ZTJlj6pst4wWjk=;
 b=DDnT1vxJb34fNTYQNTyLLMw+o1Qk6LcpIipHFwWH1M7tN5TiVD1ZQhut0RDQ4H5xiZt6/yGs5B8JELKzRe5jEfbfxUOdURor14eKOOvDz3w9n1JkmFIssd0h0qyiL/jrAq7HXnnXVton+4ATi03NFcTLOZKFqOPz1LkkJlBhqt8Jv/N/TgelCWBUWsn/iRwaxfHi7+Wk8fpfe2oNGHt4UhClOhnB2CaViDIyLdywdDTEmtQxZVX77yDVHkLZN8kpfQseE5D6M75U+C3cRNFFpv4+R6UI5JCMm9n9J6kFLYSL8eATBldxs+r/VEfpoJN+utsjNiN4bjy1B/QoDaEi4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:21:54 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:21:54 +0000
Message-ID: <3e35d30d-3a22-4551-90b5-c9856d0900e1@nvidia.com>
Date: Mon, 10 Nov 2025 14:21:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] net/mlx5: support count and age actions on root
 group
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 6010b809-f1f8-4357-658c-08de2053bbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTJEcWZkV3VSMGd5QmlXYThZRTN5YXBwY1pzcEs1QllGVjhaeUd0MjEvMmRL?=
 =?utf-8?B?UytZd3ZWTlIvT0RrWE5sZWhVcVhaYStmelVaT0pYY2hoZFp5NWxOM1RZWHVG?=
 =?utf-8?B?aksvZEZ0Umd0UjRud05HTU1henV4T0VwTHIxSkliQUNEc2QwZTVITjhFcllF?=
 =?utf-8?B?TzBKRDhQRGNxalIyNVNTVGk4bHFzcnh1U0JPT1NseEpiQVVCelhzaEZzTllW?=
 =?utf-8?B?bEtHRVlROW9abm83eDhxVUsrQWpZdk1ES2ttbDd1cVlhSUt0Nlp6ajdhU0lw?=
 =?utf-8?B?K0V5QjZLR0JLUzY4amxNUDArZXJRODY4NmVDZUtRT1BKTW9reW9hRTZNTHk5?=
 =?utf-8?B?dzBERDViNDA2eGNnY24rOTRhSHdmZTJ3eWtETEpaVDVNWUtkUThUU09RTng2?=
 =?utf-8?B?VHJMMmZtMWc1ZllZa1FwUlE3d1kwaFdHNU1TckFNbGIzbFZmNmxxTVlzNTFu?=
 =?utf-8?B?UkhwRG9pR25zNGpWMjlkUndFam9QcjJWYUNQSHdtUHg0U3EvK1JJcXA2WnpK?=
 =?utf-8?B?SWRGaXFsR3VVbFREbDJpbU9pYS85YnJsTDJ6Z1M4S253bVpkVVJhdlB2Ym1s?=
 =?utf-8?B?K2hwYnplNXZoOXd5L3h4Yk15OGhVNnVQV0VzNzNmMmF1MU4wcW5Jb1lyVjNY?=
 =?utf-8?B?bC90MWpiNjJTT2YvOUVTYXA2U1phUzhBR3UyNDgyK1M1M1U4N2FicU9OeWxR?=
 =?utf-8?B?QTV1d2lrQ2I5cjRXQW1FeEF5TTM5RUIrODFVNGVvRjBmdEM0Z2c4b0RHcm03?=
 =?utf-8?B?bnJOVWF4MXR0bEc4TTlsUGVLN2JFSEtEc3hBaXBuMFFLYUpnWHI1SWxDV2xQ?=
 =?utf-8?B?d2tpT3lKWDhKcGVJVFA4S2hGOUc1Z0ZBV0doM0MvcGlSLzFMNy9TUzZ5SUlw?=
 =?utf-8?B?aGJrZTFhWHdDMDJMVDJMblZndmplUWF3OVBaVVlpdk1yNERnWmJQWk5Rc2ln?=
 =?utf-8?B?SjJiMTU3ZHRxY1ltZC9teE00cW1DYkhjNmx3TVFKL0Y4ZFFnbzBmaWVOSERM?=
 =?utf-8?B?eTkrYzFraFRJdmlUVEdkc2JOWmUwZ3k5V1RGRlZuYlhkK0U3eHMwL3Y4aWpv?=
 =?utf-8?B?dHViSjhhV2lqN1AyYjEzb3ZGNHdRV0pOOVVaelNQS0hCOUR1RFRHWUwxeVJq?=
 =?utf-8?B?cFZyVU1zVG5lYUJWbllQNjA3WHltYWVwQ1o2STFYT3N1RDZkZHZzKzBkQUI2?=
 =?utf-8?B?eXhNaFB0cnp0MUE4cUt2UUVxbUE3cU5MdGhxOCtVbStBU2N5c2UzYTIwbWRI?=
 =?utf-8?B?dExZMElkQU54RWFkNG9FWEhTcFFPTVZ6R1pMRWs0ak04azFjNG55ZjZLbVU1?=
 =?utf-8?B?dWpmcGVjSG8yZ25JZzJhSU03ME5Qakx6aGJWMjNCRXpGZ2d1QnBtcEhqTlA4?=
 =?utf-8?B?WFRXWFJtcGN2NmtLNTJRbzVvQUNUYUpRc2huQURtZmZXU081TVVPZWtKQzRB?=
 =?utf-8?B?R3cxenBxNGR3STB2U0p4UTVYVkhzdjAxZ3lZU3RTS1pjbm02dXU3dmNKWjYr?=
 =?utf-8?B?cXpYNE9YdjY2LzdaaVJjbjFmQVNER2hqcWRUOXVWczNUK0dzT2szODMxYXFr?=
 =?utf-8?B?VXlpS3Y1aUg4SkNJVWpZVCsyd3hJOTQ4L2RWa21EUmtMR2FKWjB4aTFLZGx4?=
 =?utf-8?B?dVc3QWZrT3ZoZElqTUFPdnNvU2RaQnJzbEp6TjE0d0p3eWxnNjRwZi9nNnJ3?=
 =?utf-8?B?aWQ1ZEo3YWY1dGp2RWd3MjhQTmdWSGI2OFFDZEZhcEFzU096RUVMVlR4Z1Ju?=
 =?utf-8?B?OEJ1YmpiSTM1aXBuSFAveCtnbmZZUG8waWxBR01MWUdYY1ZsbEhUSG9pT2Uz?=
 =?utf-8?B?Z0ZxOVFUclo4dzFWQmlSTlIwWDNISEFDWUNGakJxOEltOHNqUm5NeUJPS0Nl?=
 =?utf-8?B?eHdsYVNtc3FTNjVXRUxQV20ybmlJL1hld0pwNWM3emp5Z0dUNDhjZFpNck5V?=
 =?utf-8?Q?fdDdWutlmzZGvqjwR8IizvVsR8e1F+kz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lqN1FZZFZVakFsOFkyMzArWGdwMUFKZi83RjFWT2hrZ3J6SkVBWURmZjFR?=
 =?utf-8?B?MmZpRWUweDV3d2laNlhPQ0tjeThCUUlra0YzdUs0SzlHYlZzTzZpcG85T2JI?=
 =?utf-8?B?SU1sVkI3NDZqVmJ6WThaN2FQMytVaHRDdU52bElsNVM4Y0VxdGRNeUFlTFpJ?=
 =?utf-8?B?RnREMTg5UHpWRklnLzI3SGJsMSttUDdMY1BSN0EzUjI5Wk5teHQ4QjYwUVpI?=
 =?utf-8?B?bjFvS3BLMTZSSGgrS2VtS1NXbTE4enJ0VXdNb0RCcDN3OVBhOXIrNWlhdkEw?=
 =?utf-8?B?UHlyU3FnOUJJZHB5bVp4Qyt6V0JBdVhaOUtWRmtKSjNXNU1Hd3RjRXBLQWZi?=
 =?utf-8?B?ODM5N2o0WS8vZDNNODNFQjBsUStGNzV3TERzM1FrR2dYNnlvMVVkRjQ1dTQ0?=
 =?utf-8?B?UkxBemh0Qk10YUp2c3B5STN1OWowY0kwUkQ3bWVqa1pEd0NhUTFyWUNlVXd1?=
 =?utf-8?B?dGh1OEJyQTVtYzNCTCsvVlhrcG4xK1dSKzdBL0xBK2pFUG84SHlsVjFvNmNC?=
 =?utf-8?B?UWVYNkh2S1gyZmJNelRtUVd3NldLbWRpZnl0WGptRS9tMXU0UWRCNmdlVFUx?=
 =?utf-8?B?QXNyb0xwZ1JGa0RMNzRaMnZVL1VEcmhVL003dEJBelU1VmR6RnBGc0I1aTZR?=
 =?utf-8?B?M1V2Qit2NHhEbFBlcmQ3OHc2UzVwd08wQXI4V21Tc0hPeWhiV0dhdmlZVk5r?=
 =?utf-8?B?bkVtVGZYa1BsNnNMWDBRU1BFaVNTK0RuQitCRStYeXR2VG1aT0dOYlNQVVpL?=
 =?utf-8?B?QmgwSTBDdzJmem9oOHFjKzgvVzZDR05tTmpUVWpSelM2bU9NZTdlU1pIMW95?=
 =?utf-8?B?ajZ2d3Bsb3J3cjI5ZVpKOXo3UnIwRGd6a3JXcFYwZ0poaVR2Y1pkRFR1c1RE?=
 =?utf-8?B?aVZDL1FlWE1zcmJSajJnK1Y5d0txL2IrcWlqZGZhcFU0TkNHS3RUblhIRUdQ?=
 =?utf-8?B?RXJPUlB1eWYxRS9CWFJMZCtEODdxODJlUU8vYmlsNlNYSUw4ZXFrVGo5M295?=
 =?utf-8?B?U1dYcWlaUTh0QmFVN0pSVGMxV0N2aWNvVTM2V0c3Ujk2YmRlZWEvdlRQNzFX?=
 =?utf-8?B?MlN1Z05qNXBqcGViYTlqbFRLbGNDZjU0TGpkTGJqck9NbnpKa2VOS3VZaUVx?=
 =?utf-8?B?Ky81WU1Zblh5L0IrOWVtZVpockI0b0d6amJmbjhFTGE5Q1VaWWp0Tk5HakZC?=
 =?utf-8?B?VHBrU1hCWmE1YmR5eEU4aldlRXVObmlrc1RaeDBMbGVLZUtuS3h6ZUk2M3hv?=
 =?utf-8?B?d2Vyc2FwMjZpVU9xQm52VGU1VVJHc2NBdUgveUZJR3h0VUM0cGRYRStlR2U4?=
 =?utf-8?B?VDhsdEhsZytXNjBIeXVwSUtYQlpLdWdQMDE1TGtrVytRVGRMUVFJUE1Jcm9J?=
 =?utf-8?B?QzFyVVRucjRIOHoydzJ4OUdvNWVRQitoTmxqaTlRV2Q1V2d5VjhuZlhob21U?=
 =?utf-8?B?MVZkNlo5di9UQXY3NWR0ZFBwUW9DUHdWR3ZXSFQ3VndQSVpHMVpteGw4UGFx?=
 =?utf-8?B?b2U4am4wUnVHUFg2Z0xiVDBKa3FxVU5TaGJkODBqZEZvcWthaUxHLzNKNlll?=
 =?utf-8?B?aVNYWnR5bkxLNWI3YjJHSlBKS2tpY3V4UzZWcWliaFErelpudzNRakpGTXZC?=
 =?utf-8?B?eGkzWStFVWRHSzY1RXBqNVMzVk5sc1ovdWxaZUVkeWhaNE8weHpHNkZDcm91?=
 =?utf-8?B?YTJ3dXhFbUg5eUZQWFphVDgvbWp4RjVYSzhjeVpTTG1KeWhxR2FuWWJUWnFx?=
 =?utf-8?B?Tnh1M0V1SHQrQm5VMm5mYlN4VXA3VUREYm9GdUk3VEhRekxobWJmSUN1cHNo?=
 =?utf-8?B?WXBhWTFpdDJaM2xmNFR1NU9HZnlBL3RnY2lEdEI0ZjBpYlZiRWFCM2ZSOW9D?=
 =?utf-8?B?YkFLOUxOakR1OW1FUkpTZVIvNlIzZWxDOHR6eEVyM0FpTHV1MU9PVzZ6OTFt?=
 =?utf-8?B?dzAzNXhBa0c2V1UvVks4bGlkc0oyNUU5WWc0WHEydDNIYTR1MnJsQ1V1SmtL?=
 =?utf-8?B?ZWVkd1N5TGcveTI1bSs1OXdQY2I0RkRkeVM2YWlnWjYxUE95STVwYU9pRllV?=
 =?utf-8?B?MWo1UGcvSmhlOUVzV01COGxSZEJjWEgzNmliY0xXRllMQXdVQnFjMU5TZlJt?=
 =?utf-8?Q?2EsJiFdKYCqyM3b7hpCUquNrH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6010b809-f1f8-4357-658c-08de2053bbb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:21:53.9275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFGQpVC3zo13L3fl8tuwas9k7OV5h7+6rdaq3OQkuRHjAhebTCLYa0tLitwY/ix5Xlc0ZG/wapTeCDYRekC3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

Hi,


On 05/11/2025 6:52 PM, Dariusz Sosnowski wrote:
> When working with HW Steering flow engine (HWS, dv_flow_en=2),
> mlx5 PMD does not support using count and age flow actions
> on flow group 0 i.e., root table.
> Flow rules on root table are special in a sense that
> they are created through mlx5 kernel driver using rdma-core mlx5dv_create_flow() API.
> This API however does not support using counters from FW-allocated counter bulks
> which contain more than 1 counter (extensively used with HWS to optimize allocations).
> This affects age flow action as well, because it's implementation in mlx5 PMD
> relies on counters.
> 
> rdma-core version v60.0 added a new flow action type to mlx5dv_create_flow() API -
> MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET - which allows the use of counters
> from bigger FW-allocated counter bulks. This in turn allows mlx5 PMD to extend
> count and age flow action support to group 0.
> 
> This patchset implements that support. Patchset contains:
> 
> - Patch 1 - Fixes for indirect flow action error reporting.
> - Patch 2 - Adds detection of MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET in rdma-core at build time.
> - Patch 3 - Adds support for counter action in HWS layer whenever MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET is available.
> - Patch 4 - Reworks for group 0/root table checks to allow easier implementaiton
> - Patch 5 - Enables support of count and age flow action in group 0, in flow API implementation with HWS.
> 
> v2:
> - Added logging in mlx5dr action creation whenever count is not supported on root.
> - Removed redundant is_root_supported field from mlx5_hws_cnt_pool struct
>    and replaced it with compile time checks, since feature depends on version of
>    rdma-core available at compilation.
> - Unify error messages for unsupported count/age action, so all refer to root table.
> - Added Fixes tags to patch 4 from v1 and moved it as patch no. 1.
> 
> Dariusz Sosnowski (5):
>    net/mlx5: fix error reporting on masked indirect actions
>    common/mlx5: detect DevX counters support in rdma-core
>    net/mlx5/hws: support counter from DevX bulk on root
>    net/mlx5: rework root group checks in table create
>    net/mlx5: support count and age on root group
> 
>   doc/guides/nics/mlx5.rst               |  34 ++++---
>   doc/guides/rel_notes/release_25_11.rst |   4 +
>   drivers/common/mlx5/linux/meson.build  |   2 +
>   drivers/net/mlx5/hws/mlx5dr.h          |  14 +++
>   drivers/net/mlx5/hws/mlx5dr_action.c   |  20 ++--
>   drivers/net/mlx5/mlx5_flow.h           |  17 ++++
>   drivers/net/mlx5/mlx5_flow_hw.c        | 123 ++++++++++++++-----------
>   drivers/net/mlx5/mlx5_hws_cnt.c        |  42 +++++++--
>   drivers/net/mlx5/mlx5_hws_cnt.h        |  16 +++-
>   9 files changed, 185 insertions(+), 87 deletions(-)
> 
> --
> 2.39.5
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

