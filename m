Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8EAC4452F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1692402A7;
	Tue, 21 Jul 2026 14:56:30 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
 by mails.dpdk.org (Postfix) with ESMTP id F376E40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 14:56:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2YiGeNZ7wWsPFB8/pRHpm7ymnGHFle1dXXYEq+s5NEBk8SIMOuj+OALAr8Bnt+JGVlrPGKjNahHjCUcWSCsIp6Y+n2aAWIrhJrvlYKlq0DghzCU/mFPpbr6kNh1SxwzODTEywIjXyupOofMHtxmq0iG7bqwgDuQ8uTD+nn+dnR5ornaf7I8GxCWzvDj25vXg4jFtD1seqZ2VY2ALxG39GtVVzl7kE8tvF17qZOGctr5FDugZCqaIlvclP3m4+wJ3qqcNS62LUHu8zlKQVmcz3+Emqud9z4JE9U90mQ1VJAvhejzJIwudBml/SzCsdQyEok2Snh5YdlvBVejZ3MD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIF1j/yCfSrqvw1VVRrcp2g/oPaWixQPsMYkze8tKSA=;
 b=fEjQzvIbboETtnuy9t6Gnpz63+9wOKkk3DkH2eanH1FASvIBg6/cixzWFG3zBKcm494uBSGlSiQAmCKy/yFdQGdY5PX+WkiLepqo05COqSQ9pyA/UZn4WdDAnOC0rT4A1uhk1LWVyqlw1jf5cURCBhaKc4JVl/gQGVOGjvjXmGhOONpsly6/Cu4z23J822g6Xt0yAp7eYlYYZ4R3ufwbSD03f0dR/w9GCXqnF6r07z3891x0Y6j3MbkqbvA4M1GUvhd31w1ye5SSYMxajyXJK1Mc25JMnaUe1Tp2N5gMqGK3BBzR50wylDIB1gbpezK6iW0hHthPA0wCClhl+7czoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIF1j/yCfSrqvw1VVRrcp2g/oPaWixQPsMYkze8tKSA=;
 b=Ri6p21E4wr3hT++AZuIKN94kXmMeAQAOSoThOeaah4HaxRCIYjOCPOXzdK8J+aMh8AMqnXUcWkCwfDnEv5e2fuY1Yh+74PuquYxYnXSLrJaHBN5utIkIPrb1cyM5oja5xN+1aBgcUlFsetdmq5EAdgHoYfXN0AXCitaxlkjqkRHYdL8CRsxEqUV+H5KgsoEVq0BAAhs9f94XgplJaTd9niY4jRzknvfWMWYEOu7tAi99F/UIuqb5GjDwJk1Da3bYgcZtUGZaTurzayT4TBKAjE8mkE1dZecZ8eO9myQhX4Bp2+ZRAL4WcBELVpleEXjZacHBAu9vi1JVM8BS6LOhVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI0PR04MB10663.eurprd04.prod.outlook.com
 (2603:10a6:800:260::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:56:25 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:56:25 +0000
Message-ID: <b4bd7d94-20b9-4e7c-b51c-7d428bc60b0a@oss.nxp.com>
Date: Tue, 21 Jul 2026 18:25:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net/dpaa2: revert inner RSS level support
To: Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
References: <20260630123857.392884-1-maxime@leroys.fr>
 <20260720133436.869334-2-maxime@leroys.fr>
 <gMKBpMOZQYuU_7FGO7uhXg@monjalon.net>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <gMKBpMOZQYuU_7FGO7uhXg@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::14) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI0PR04MB10663:EE_
X-MS-Office365-Filtering-Correlation-Id: 213d064e-f7fa-427c-c6fc-08dee72778d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|19092799006|376014|10067099003|4143699003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3VAtiVGOzCeGpUfDbPzSfJ1udWX3CXwrlha2DZ1+AYCn7gNkjHTz2mxasUxZvuCX/8cFpGXkmEmFfSGUpLjxQWHkdW1mBHadYmpHLTF8wKDmB3/DgGX2L/TqUMuTLZjHnCLq8MxtKDe0kljEuwv9PMgGPDbM/sOmqG57UofEBQQ+ZEdVDQ+XfpsJ9f1WXMuu4ba8kHkYwTfVghlmXM84zphmcT4waqFEsJL+QDtSYzJICq7qPPpeLko9EiEHNVPULintWQ2MoQf46c9UAT+ejQqkf2E4uI8xazP1u1mYJrIyDp+0pK3S8CTLFEaQ/LBXWskUIB8MaKSC+kdAnQlrJlDZlkJKJmZA7dp8ozuMOOMRXr49SNc2JmiXksjYChV2x57M4SWmloPpIi8bVybUgbBq+yUP4cukofnya8fXQRwH7eR5gmItSmiziwZkAHOadCEgo6735QqteZrajimZDaRduyClMme5XZ4629VGENgN0td/okuPSy2pL4YGlEhLYuNDkUso18jDZccX2UbxJhazzLcL5ZFhmV/7YM2ygyBKPFau9eclCrvmAliiWhDa0aFc0J8h/dq2VW/d8xyPgyO1nzDAG/FReBssITKB7/XyIIdgiCcXecc+BPZuHSOP5UmNeKpvhVEJLqTU5Pt3HJFyFho73WIaN1x/JPSZt64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9qczMrb2FpVWZxeHhDNWdEdDhjSHYwcjdRaXo0SnkyV1NJdEZkajRGN1dh?=
 =?utf-8?B?ZmNvQ2RYU1Q2aDdKV0JOYzNjQWJZSGxoYTFzb1BDUTFScFVDVFU4ZlIrYkxR?=
 =?utf-8?B?UXRHRUcyb2E2eUl6OER4Q0NybUsxVEdiK3FXV1ZKMi9sRFBiV3RxdDBzTEdu?=
 =?utf-8?B?N0p4REZSeDJiTStzSW1oYlg5bjczSzNqcW9GQjVVU1dPL0poQUFBU2o4TEZP?=
 =?utf-8?B?VUg2dTFHd0puQmNMZlkrVEF6enJjWWc5MnY0endsNlhxcEpMdWtMTXI0NGRK?=
 =?utf-8?B?RDhXV2RPeUM4dkFOWU1YaitqQVZoTEhLallsa0VjTVVFZEkyVW5OajFXSnNv?=
 =?utf-8?B?ZlRpTzF3c09YRDhKVDZnYjRPWTFuNzkwaTljMHhGT2FwQ0VXaCtoZ0Z4VlJY?=
 =?utf-8?B?bG9hWFlJY2NOTE45SkVXWWpnelF1K1ZENDBHSnlPMWRHN1gvTXZIZjc2VXBu?=
 =?utf-8?B?ZEJ2WWhaaFM1d2pTWjcxbTl3WW1pZkFGa1VEeVppWExPYU0yWFljdThZNzZI?=
 =?utf-8?B?MDJ3aWEwNHdGWFJ6ci80QUV2NTlzckh6UlNpSWJKc1lJRGVqc3Q3ektQb2JI?=
 =?utf-8?B?azBIUE5jK2RmQUhTcEdUbnNlbXJhV0RwOHMzc0tIM2pNVndLRmNuUW9ROFFk?=
 =?utf-8?B?andleDQrLzRaYlBYakN1czEwOHBSVVF6c1hqWkkzcFFHcU50RDdzWFl2aVJp?=
 =?utf-8?B?MmZaMjQ3SWJEVDhzMHhzcXIzbUlqcHNkbnd0cnFUVzEwTHNoakNIRlh4Mjdu?=
 =?utf-8?B?aWc2V0VHb1R4QkRFa2lqMTNxaU1LY0xYMGFjbUw3RTJETjZUT0drYkVJQ1NL?=
 =?utf-8?B?TjZ3d1F1UW55QjVJd0VsVWNNVGdCekdwUHYwWXFaNEVpQ09qd3VjL3h0Mkls?=
 =?utf-8?B?QW9Sb0ZrbEVScXpRMkpWbmZGNTRvZzdDZmdTTFdBSGtpL2NvdjlWOVBmR2lz?=
 =?utf-8?B?dlhhRVRkWnQ3WS9ubzVRM1gveGUvZXVUMHErOEQyWkR4R2wxMEtSOElqWjd6?=
 =?utf-8?B?Y1lpZ1FKZENpRWREdHhmQ2phT1JCeTIrMWt4RS9ySkpLMVVSMEVZd21weFNh?=
 =?utf-8?B?ZWp0RmJta1VtTUNGNFJldzlsa1Jad1oyRzlWRnordXJhWjNTaXZMc2dkSzdn?=
 =?utf-8?B?Wk4wZnJPUVkxbGVkeFM2T0NZZ1AzeFdIdWFtNXJIR05LYllTTDlEbWNYSkFo?=
 =?utf-8?B?Z2pmT2d5SEEwSDB4alRNajNMbXJNWUVuUTY5VGszb0M0MThTallOOCtzQXZH?=
 =?utf-8?B?U21FVGJWc0hRdnNYbEw5TlpaZDFtTW0vcExYTmE3UEd4M2FhaFhsZGNKUDRV?=
 =?utf-8?B?czlzNFJXVU5xVHVwT2ZhSWtSTFJvK1dpSlJETUZ3ZCtFNlJ4d2I5eVJiRXZk?=
 =?utf-8?B?clJIM3NURTJteUxSSkpla2dGbzdLWTJWUkhQZVNBQXZ1NTFwRG9hZ2JpWkJu?=
 =?utf-8?B?czNUZTdwL2ZDT3pwdHBqZGQ0ODlhbXk4a2g4TlRvWGtWZGRObzhNVG53ZnVk?=
 =?utf-8?B?Wms2VXRMOUd1bEVIOWIyVy83bjgyZ1E2WkhWZ0psSXYyN1FieFRQNHhRVkp4?=
 =?utf-8?B?Zk5haFdkK2JIS1liVnBiUDR6YnUxVFVTK0NrdWZXTXA1TTVOTWt3VmVNUTU3?=
 =?utf-8?B?T1llT3B0bTRxTWJqWXFvbjFMNG90dFdzbFlwNUdiSzVmK3FRR1VRTHFSMElt?=
 =?utf-8?B?WHhqckliTjBDK2F6QmM2K2V1ZzY0WUd0WkpvOUZSNGtxUHBhdTZaOSt2bUw5?=
 =?utf-8?B?azlYRnZDb1RrMzFjL1daOENSRUtFZ08zc1M4Y05FYzBuWm9scFU1ek5IVXV5?=
 =?utf-8?B?dmVtY25NYmZlYWRyWjFKK0NsKzRPV2lIdTI2ejc2b0NuNk1FRVlBSDJmeTBJ?=
 =?utf-8?B?dXltTDBRdWhiblJaUTNxNEJUYzNGVEdqM0xML2FCelR1cE43WnV6VWpmbGtk?=
 =?utf-8?B?MFFMU2RnYXFQdjFVRG1YelllazhuOUVnNTFKSE0yVXZEcXZYODkrKzV4R0FX?=
 =?utf-8?B?QVNsbkRGVml6ZWhGOVl2ZnNvc1pUU1J1M3RVcHBWZDZvZkFQNGFhbXZLOU4r?=
 =?utf-8?B?QUpNTzR3eE15WTdJR0wyQTQ2Q2VhK0FGMlQ0REkwelBNK2oyaWVlZUtNQm4w?=
 =?utf-8?B?SkFKY0lPRXNtRlBJejFvMjI4TzFsYWNlWVVtZVU3WGcxYjBqQ3pwWHV1UWVW?=
 =?utf-8?B?SmFZd09IZEFNT0dLYnBmL2IrL01CZHdxaUxQRzJQemhVYlIyN09BNzNnMVdX?=
 =?utf-8?B?cWZBSHcwc2lUZG13VnF3aXl5WG9wdTdyS3BDVEFtVnF1SG1rZ3hLeS9SemRR?=
 =?utf-8?B?QlJJaWJLYzJPTmlCaW9BNklGbUpKU3F4bmxBcFVvWnhMdk1ZelZ3ZzlHZW4v?=
 =?utf-8?Q?KB8Gx+mIiODdm7FU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d064e-f7fa-427c-c6fc-08dee72778d7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:56:25.2600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRCl60xKDwPxxe+6BARN4bd+RLcRTXDKVOPzsAG6Y2GWcm/12mQJXss2Ryig4ok/ZcLjB6brb0hcCOvc5DnhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10663
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

On 21-07-2026 15:26, Thomas Monjalon wrote:
> I'm waiting for an urgent reply from the maintainers here.
>
>
> 20/07/2026 15:34, Maxime Leroy:
>> This reverts commit 618a06c53d479ae576ff01c7d274b10c60b3d3d5.
>>
>> RTE_ETH_RSS_LEVEL_INNERMOST was mapped to the innermost IP instance by
>> programming the IP key extracts with hdr_index = HDR_INDEX_LAST. The
>> hardware only resolves that index when several IP headers are stacked.
>> A non-tunnelled frame carries a single IP header, so the extract
>> resolves to nothing, the RSS hash is constant and every such frame is
>> steered to a single Rx queue.
>>
>> The ethdev API defines INNERMOST by encapsulation level, not by the
>> presence of a tunnel: a plain frame's innermost header is its only IP
>> header and must be hashed. The dpaa2 hardware cannot honour that and
>> keep true inner-only semantics for tunnelled traffic at the same time,
>> so the level cannot be implemented correctly as merged.
>>
>> Revert it. Hashing the outer plus the inner IP under the PMD default
>> level, which spreads both plain and tunnelled traffic, is added in a
>> follow-up.
>>
>> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>
>
>
