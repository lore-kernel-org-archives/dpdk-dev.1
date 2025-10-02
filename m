Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2ACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 15:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C094402EF;
	Thu,  2 Oct 2025 17:42:40 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by mails.dpdk.org (Postfix) with ESMTP id 9431B40268
 for <dev@dpdk.org>; Thu,  2 Oct 2025 17:42:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjTSINiubQavsToixAmhHtj1qicQKdaBDN7cBvluAzx0gQXySBFceIzsBovwnWyOTyJLsxUCzu0mys7mQo+EgZlrXOP7S5pQXTFcW42Ej1vTfVz5gdhU1Df+GERZq7Bx4I/o7EkCnj+J7wnzryMCKXN4YsBRAzfhhQ7TLkr+DRTleusiZinchzDfo4BWIVVf1qCvYb/ljOTr15cC9PSe8QFo7TAYUno+T/PSOCATuQjBZsF6Jk+mkjYQV1LX7W6JxLMU4bq0QFgGD/8JMCy/g6kX2fpus3llCkV2yRkDBlO71UaqkS90mah3un10AZsUp5UPb2kz7p4Qb51kCxBmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaxMROcA1FrTY7gCdXio2mKsUimM3meejS+g4Wchqlc=;
 b=Y8XHKPl8tzFNjM315HQvS/RmTztGpR8xufusPaWKjKI7LYwZ40BfttMafCqXWCHT9XmhOr6OT7OjbnQjAWy893oQSgGUkqlM3RI/l2P11O6wjrQreDef/G4EXZzhH2BbK/839wC12iXH+spCIShwoy1Pp144FMVECprPqh71CV7KwmbGp3NGa3KB+rfCQtkVQpM8J8G/g668DIXMjuMb60wztFK06mU5Y3jS/nAu7TK+vnzGN59W2/iYvbbg4QEeYv6M6DWNMcqmGeAgpDAYUKbeJ4xBXCVylGMpBDsO5ZqB60+570gnl5FsTms7Ivyn/pp2g2HwLtgzweDLe9f/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaxMROcA1FrTY7gCdXio2mKsUimM3meejS+g4Wchqlc=;
 b=d+WAvm/L/U2NVQXsMLtHQbRGuKogBUi9tnhI5SuX4IEuaVAcnuhlXmbbOQnK58CtOydlsoUd3cwt0F3DHDxKuJLCwh257bkdSTTe+SiwuigmIHk7hVX+fYjgN3ZHn/KdcczLbheuy7bczN1b9WyOPf8Kkja8UUD13fjRaddZz5bFsNdeLpbyvyJlhPlbrUvbWkDfXdKKdkedo0X7EG00ZbVnvsSY/GCaLfPrb0WbJtJ+6K2QSSQ6mr8UoFWiGdfcZlquqhgsz3D3ath1fdAM+xz1XeRCJSMm3IKjGR0BaMB4UfS4CnzcH8Rjr3TvrBGMZBAMjdCFhpj8tf8q/tXPRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:42:28 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%4]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 15:42:28 +0000
Message-ID: <54ffb23d-0720-4dcc-a6ee-9bb1f9007670@nvidia.com>
Date: Thu, 2 Oct 2025 18:42:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
To: David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Srikanth Yalavarthi
 <syalavarthi@marvell.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Rosen Xu <rosen.xu@altera.com>, Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, rasland@nvidia.com,
 thomas@monjalon.net
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
 <CAJFAV8z9e9B7BfwXRr_H76sm_5kTGyjnv8MaT5NriBTykbyQgg@mail.gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <CAJFAV8z9e9B7BfwXRr_H76sm_5kTGyjnv8MaT5NriBTykbyQgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c6b581-5630-404d-81a7-08de01ca4a44
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFNMUnE4T0YvcmlFSU9adWtKbmRoWlpndXU3MUdkUjBvczRsUkFMNVZSMU56?=
 =?utf-8?B?Y3FRdElFc3ViTnp5VitBNFlXK1VqU1ZxMlFERk0wQjhkSEZza1dGNnpsU2px?=
 =?utf-8?B?OUNFL0tUR1o3S2grazNqczNJQzNmMWc1bmZIM2ZZSmZsMHBwdlZNQlE5TERE?=
 =?utf-8?B?QUxiZk1VeFZ2cUdvME5rSTQrWVYzaC9uZDZyRlp4cEswdXNtMW9RRDFCVmlk?=
 =?utf-8?B?V0U2OG14bmNiRDhvVk51REpMaXhmc1NsNTBuVjZhRGNJRXdiaXVWZ0VnOG4x?=
 =?utf-8?B?eUt4eDJSWTNmV3ZEanBjVWl0bldiSWhIajNzUmNjZFNkS2hvK0FCVkh4VTlp?=
 =?utf-8?B?QW1CY0FXVGVodGg2S3lFbi9LRjVLTVA1T1dDbGFkV1NUQ1Y5dlBGanhhOVZE?=
 =?utf-8?B?SnpZWVF1d1lldWgxMmk1YVByYSt0UUJyT3Rkc3FYT2tMQTljK3pTcEtOUjBw?=
 =?utf-8?B?WjVNTE5LdlI1MlVialBJbXk2VFByTkpiUkprUFRrV3R0d1Jrb3RzME15aFZF?=
 =?utf-8?B?SDFxU1JMUThaaHdoOGoyMEhucG9EQXZnaHhwL1Q3L2ZjNkg4aWxod1hCODVw?=
 =?utf-8?B?V2ZPTEFXMnRtdEVrRVIyUnBuQUxOVHJtRHdPdFNiZ1ZFcERJM0J6YnNqSXAy?=
 =?utf-8?B?RzdMS29BWmtld0RtUG5vRk9xY0xVRDBNSDE4UEhCVjR5dHloSHRLKzk5OFRo?=
 =?utf-8?B?OHZHczZRNjNKaGF2bGk3S1NOek5mSWFEZTA4UFhORWFMZmtNM1NGaDhCM1NL?=
 =?utf-8?B?RjdiVHYwTnR1LzJRNzRYeStCQ29xeU5pYkk4NE1ZN3JMR2FSMWZZc2FMSUh0?=
 =?utf-8?B?R0F4M1A5bTE1U2NvVGxoSVBPQU1YNzRDSXhTRmNiU0tLNHBGRjV4amJkbmp3?=
 =?utf-8?B?bFY5WDAySjJqRzNib3pFZk02QWVqWWdWQ0N0c2Q2YTl3V3MzT0Y0NHVrVEZy?=
 =?utf-8?B?OGZTaXpKRkVsTFN3NHlyVjhaZlZ5TnBOV21xUmQxWnR0TEZURE90ajVvdHhY?=
 =?utf-8?B?ZXllR09sa1JiRFpRL1VIbTJ3NWhZTVFaWmZ3VEdiRCtWSVN0VHVQc3Q2MVVB?=
 =?utf-8?B?dnhKNVlxOUVZS2ROT0xZVlNmRzRUQnhxMjM2U3k2WlBJZU93Q1hHQjlNTTlL?=
 =?utf-8?B?UFFCcFBlcm1xMmlNY1pNQXBaQlVuTEJJMDZNVUF3YmVlOVQ4eVo0NXNKRzJK?=
 =?utf-8?B?S0dVL3RyWXlhL29tWXpGdTlGTElHTDhKRk9tQjZ6cXNOS1EzT2diOWxaTlA1?=
 =?utf-8?B?Z05FZVZtWGlVdnluSTZLaWcwK3MxZEI0MFI1b1hGT1Y2YU9wQllLdGlDR2Q2?=
 =?utf-8?B?L09abTdManpQaExxVmlZcVRJeGQvNHIydU1qaXhHSCtKY2t4ZGlWTmNaNENS?=
 =?utf-8?B?Nktmclg1UzFVcXNIdmZrQUJSNUQ0ZzBPamxxQlcwNDZEdkJkemVPZ0RmWDln?=
 =?utf-8?B?SFFxMnZIZjZjbUlIVW5CWEV5NllNRDhkMXRsMFhkQVpHbGRIZXJhc2RmNFBW?=
 =?utf-8?B?cnBtcHNxQkw1NFBibmtjQ2VEai9EcHJyMURMaHlwZWl5bkgrc0xmS1ZHd0Fk?=
 =?utf-8?B?V1pESmo4OHV0NTh0RTYxdTZUZk9LeUVFWVNFUGhSbEJrVlM2WnBqNDZkMjdh?=
 =?utf-8?B?eGt3Y0hQcHVrTks5OUN5UWJsd3FKa0FOOHd4UDFWbFhFaTRIblNRbFl1dE82?=
 =?utf-8?B?UThDTzJiaDZxWll0OGZBN3Z0ZzVlbkowbENIWnpFVEhlQ2o1dGhlaitFMTlr?=
 =?utf-8?B?Q1hpelU0TVh6bjZQRzF0QnFESkZtRC81Y3p1MnpUMFlIZldrNDdVSzIwdkx6?=
 =?utf-8?B?MlpaUzZtM0hxQUdXemJwWWlGMDBUZVdMWGZLbkxnQTBMRXlnaHNyS090Zk15?=
 =?utf-8?B?QkFTRDRDMjNjMUVHMUVob1dsV0JTSnE1eEVLN29VcEQyM3ZIbWVkYlFVSm1z?=
 =?utf-8?Q?BGJaDXS0roWPGIdDgn7rVlmltuDAWlW0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUR5aXVMeWpIWFZIS1JXNjF2QUdRMkZSaE8yTnBXYVE1QUp4TWV6dVJvc2Qv?=
 =?utf-8?B?SUgvaHJVOGNUYUFZR3VjL3kwUFV2R3ZtVnZ3Mi9DM2Vwd09EbnFMNzdoRWlL?=
 =?utf-8?B?MU56SDNPR3AxVGwxdkMwZWd0RWltS28relduU0ZCM1hwdDZzaXNZangrS2dF?=
 =?utf-8?B?VDI3OXk2VzJtQ3M3OGtLaHRlLzQzYTE0UFJwOUJwUmwyeFNpWUMzVlVGU09E?=
 =?utf-8?B?UmIwaEE2U29ydFQ1dG1Mcm1FUlYyUEZwYnRpQm5Zc1VlVXZkMGY4b3JZMFlB?=
 =?utf-8?B?UklackQrM1p2NDFLK1pzejRvT0FZSitHdFBqWEtJaW1qclhXWHNXMG5wcWg5?=
 =?utf-8?B?eE5OVDhXVi9xYWJEcGxsTGdEaDl0TFV5UU9WQTk4OXU0c3RpRGE4YTFSQWZp?=
 =?utf-8?B?cXJYT3FOWlIySjF2aUxkUjAzRERGUi92dloyajUrZXlLUXgrZHRGck44aDB4?=
 =?utf-8?B?TVVYR0JTUjNpWm5la3ozUWx0K2FHQ2k1b3lDckRieHVZNXNZdWd0SXN6R29l?=
 =?utf-8?B?LzRhRzJSTWYvNko5VHFhM2tZd213UXRGQVlRZ3dIRDB5MWlWR084cnZEVW5R?=
 =?utf-8?B?ZUZTdGZIYVd2S3ZpNy8xb2dndW0wTXRNN2RFY3B3VlI1Zjh2NFY0SlIzVSs4?=
 =?utf-8?B?azByVm0zVVViaVhvNEQwZEFneGRZaUd5NEhkQ01HTkZueTRTU2tQb2V3c3pZ?=
 =?utf-8?B?SzJlN0t4TGMrOWw5MWJVSUVzNlhSelVaZ3U2S3hZbnJubDlIczJyZzRXMnQy?=
 =?utf-8?B?d01na2FHaWdBQS9lSXlTZU54d1c4RjVxNkZneERKWWpMWGxCQk5jZWVTQktO?=
 =?utf-8?B?U1ozd2pBc2JsVU1VamZVR1M5SXVUZ3djbm5mcGRsSmZ0TVM5MG1MTHVrcE5x?=
 =?utf-8?B?c1dxWXVFR3p5bXV1QUl0bFVsaXhMSEVlVHU0d0RkRiswSWcvN1g0MVhucGVk?=
 =?utf-8?B?QUx2TXhJSGN6Y1lDNzd2ZlZuY2k0TTJKSDM0VTVDc21ZN1hyeVVYOUViaWtm?=
 =?utf-8?B?amZab2YzUUVGVy96UUhqNnhOdjUrc2VHaVBscjdsaDdsV1RKQkJ6TU1pSEFu?=
 =?utf-8?B?VkswVVNWS1ZsSXVobUtmYnVaL0lRUjVoMW9jVExYTFlocjVnZFhGR1loeUFr?=
 =?utf-8?B?ZU5yV2YrNitBVDVPbkhsdk1ZNUo2bFVwUm1PSFNJUHhGOHpxTHpGOTJ3MEdZ?=
 =?utf-8?B?S3czL0J4c1A2NU9mNW8vQ2ZFcFNXNjFHUWwwMFRnZHc0T2ZlY0x3Uk1nN1Fs?=
 =?utf-8?B?SXhmbDRBdWtMbFVkdmxURXRHR3VUVmJBZzEra2JybHZWbHlpeUxLdXdWSWpq?=
 =?utf-8?B?Q2dFS2xGSVJXaGEzbURaLzRENUdRZ2E0QnNDenRsclVIYmduSEdQaUx1WXh0?=
 =?utf-8?B?eDdZeTRIZjdWZHBRRXRueEFlblYwNlR4aVVXYVRmUlhGN25nVTdIY3VQSzhR?=
 =?utf-8?B?TGxKUjdLaVlhSzdVNXMyZS9NNTIxYWxzSG1LdHhobTZZSEd6dWQvQSthZVdL?=
 =?utf-8?B?cjlXcWN2U1ZlQjAwRUZkeEZGY1pJNWdIK0pad1d1MW5FQUNLc1FYaWQwbWdp?=
 =?utf-8?B?MStyQTZOcUQyait3bU1ObHdUOUFqbDhsQzlEdFpVdFlxTnJiNC93VzFWR2x5?=
 =?utf-8?B?UWN4ZDM2a015Q1c3UldlMW9DYjBXRDk4eUwwZm5xOURzTEc3Uzg4bVl3YTFv?=
 =?utf-8?B?VHZxZHJoWXpJcUUrODJhWGJEUTR1cGJhRjV3akdxOEx3SWNMUytLRzBxMGJw?=
 =?utf-8?B?YURkMFZCNm1CSGl1ZzhvZ3JQT1NVZ04xZUZmZzl6b2JBS0tYU3hTeXhUcEdG?=
 =?utf-8?B?WUFIYys3TE1uUUc1cndXUHg4c29ITTMxcWRDV3p5MXp5ZEZzQW9LYjV2OU1i?=
 =?utf-8?B?MVU1K2pFNEM0MXpWdysrVUJsbHY1NldzTnpXV1lBb3FSdUFVQzBXL3hiNWJT?=
 =?utf-8?B?eDlyR2dFL2lOdVV2NklLY1Y3TVpHNmZ6YllzeXhqenJiU0tlTWtGTUM2aVNp?=
 =?utf-8?B?Wk5TWnN2NnphQVZsRTd2cFlYU0NIMy83SGg3S3dlZHI2YmFLTTl4TzFOQzVZ?=
 =?utf-8?B?Z3pJc0plMXlSNFBWa1pNdUwweEtiblFFdlo3dXBsT3RFTXNMRjRxbEd6cVVm?=
 =?utf-8?Q?1gVqjz2qpfAi8gWn5jrDcN4Ag?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c6b581-5630-404d-81a7-08de01ca4a44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:42:27.8275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmN+D4Y+/govgcFAaWgbINSL3rrW3zj5eYCYS1v86E+a3vsSXwg0N7pIjQ0hAflJU8M4Bsd9kUhOG11d5SXctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
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

On 10/2/25 3:45 PM, David Marchand wrote:

> On Thu, 2 Oct 2025 at 13:54, David Marchand <david.marchand@redhat.com> wrote:
>> On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
>> <bruce.richardson@intel.com> wrote:
>>> The meson find_library() API call sometimes finds a library that is
>>> actually incompatible with the current build, for example, returning a
>>> 64-bit library when doing a 32-bit build. To avoid problems with this,
>>> check each library returned from a find_library() call and treat the
>>> library as unfound if its incompatible.
>>>
>>> This checking is not necessary (or should not be necessary) for
>>> dependencies got using pkg-config, since the .pc files for each build
>>> type are stored in a different directory on the system.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>> Acked-by: David Marchand <david.marchand@redhat.com>
> Applied, thanks.

Hello,

I have warnings like this for mlx5 drivers on Ubuntu 22.04 with clang:

Message: Disabling mlx5 [drivers/net/mlx5]: missing internal dependency 
"common_mlx5"

Build command:
CC=clang PKG_CONFIG_PATH=/opt/rdma-core/build/lib/pkgconfig meson 
--werror --buildtype=debugoptimized build

gcc does not reproduce.

Regards,
Ali

