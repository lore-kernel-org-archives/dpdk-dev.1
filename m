Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15732CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 351CE40C35;
	Wed, 15 Oct 2025 17:38:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013070.outbound.protection.outlook.com
 [52.101.83.70]) by mails.dpdk.org (Postfix) with ESMTP id 03601406FF
 for <dev@dpdk.org>; Wed, 15 Oct 2025 17:38:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4dOBBfKGFTfCnJQX4Czs9gZSEVJGLBl/py7WiBo0Czrz6U+1ZnAuEke9/i32U2RQ/D4qxfdasYeX0Uo8bMlH4dTgCTtplseVgQC3SnQHFc29WWwt/zpx9+cVrXVL7AVJAZry8lA+S3gyttcABwKI5wE7/F2gKxjivcHVMQlN4WvK3DA3/TkxFUF2lEWWbUhNEN19cNAm1dzMLSbz2CAZZdGoUTC9x0ecW8bxLRZB1vjbIanGG+MvrUPRrGrm1BhYbQRW86oR3Qouy5szOtrwneMHBS6K4X+gElPzlS3ULohUYXWpONq1HVjgJZIWh3LRNIV9uLQuAPWUeHtPGZ0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQK4zx7Az3u0rhcqidYYSVSTvoVW6rsDuSxqz2d+uUc=;
 b=xCNxxWTr9BDbAtqQCd8yNyBr+0t8WtEujzGy+AuQdG8Y0EbGJb2gigYnU4vKhfCTJtjDnWoRktP/qj+doBR+6oXEwXHpJZUXZmpms/E3EflIkzdz7B3Kxwfq9XGwnrsrTqTMOmrgjzRmGQX/h1o7p2OP1dC6YIwwhGHrVEOOORmMHCj9+RaSg6SeUYa8eJYot3LQ5NfqfeFSXQdjmWJhiUdZ2WUeCbjSfRseInkMoKImgAtYoTCoD6tk5rhMIVafw7MrJyXPN8RsnI/NB24MrqYjMHWyulslks+pD7whLjxx02mQ1W/s05yfwFv08qU52ZCVHt358yTqAkPHmkItDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQK4zx7Az3u0rhcqidYYSVSTvoVW6rsDuSxqz2d+uUc=;
 b=VcXSCp+ClAdovacvsEtGkCFni6oXMxuE9OPzC56DHLLUCdiZBMLL8aCyDiTu3bp8BfuraQOsLKG7NZzGrVB5bz+DAetcbiqQrWiwoipNH9gK0O25f+ZOqJ4WlfcnCS/L+PvHP0NKUrHx5Qv8oESH+9UBVpcIY/zVGGdR7g8B6iuVXGSW+siv2u4qMdi7JZaQxP2ADw3KJ50UgaO3/vNWX0RaJurlORwd825idhdP7jny8IHdnWahyH0vxF/9nDuLLkXWU7nVQhbt+i3uWc6YJS+z0Zz5XKFqByNe9o5G4ctuG5rcuxwsmPGV45biuV627L/XlehugV0VcgsOyjSuiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by VI0PR04MB11573.eurprd04.prod.outlook.com (2603:10a6:800:2fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 15:38:25 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:38:25 +0000
Message-ID: <f327d243-1dfd-4756-a740-4853faca1640@oss.nxp.com>
Date: Wed, 15 Oct 2025 21:08:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] drivers: dpaa2 upgrade fslmc base FW to 10.39.0
To: Prashant Gupta <prashant.gupta_3@nxp.com>, dev@dpdk.org,
 stephen@networkplumber.org, david.marchand@redhat.com
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251014064035.1312896-11-prashant.gupta_3@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251014064035.1312896-11-prashant.gupta_3@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|VI0PR04MB11573:EE_
X-MS-Office365-Filtering-Correlation-Id: de894516-8501-4338-a2a5-08de0c00e131
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0pZYUVLcWozZk4vbXdHa0pOS2tnNjZIcmlHOW1lOWlERDVZRFMzZ1lTQWhr?=
 =?utf-8?B?N3lVTXM3R2s3V2tyMFpxOU5qU1YxU2FraVlhdGl1MUJhaHR1WjZGbGE0UnlN?=
 =?utf-8?B?NkhGSmZISmhhUWhTVHl6Q1hxZjlkaWZXTE40eWNYK1JQaXY2dzFWTVNxZWl0?=
 =?utf-8?B?Q1ZCSE1NNkRaR3FsaFhnN3FqaHBiczdHTHJOZVIzSGhMZUtRWXJYbmcreGhJ?=
 =?utf-8?B?aEJ1ZVlBbnZabFVVUDVLd0Q5U3NMVXR6L1lyZmJ4NDVQYWVzamJ6clEvSnFK?=
 =?utf-8?B?SHV5U1V6a1U4dDN2ZnozRHFJY0E4dWN1MTd1bWlNTU9kN0RBQ2g4Y2JQSDJB?=
 =?utf-8?B?a29DamZpVDJDV3hSV0l5NVRHOEVOU2M5Ny9VbEJ0WEk4MXRmb2tQd1NUcnp5?=
 =?utf-8?B?dnNpZzZwMHZNV0piVmpWbDc4VVlpUDh5OURhV2hodTVxaUQ5SlpEc1FIenVK?=
 =?utf-8?B?aVJQWFBjbDJaTys5MVR0T1FwMEZoY3Z0NGl4MDA5TXgwZXBmWVdSSHI0N3c1?=
 =?utf-8?B?UngyeEV0MFJjSUowTzN2ZnpvaTZZa2RLTlI2ekJUR1hZUWdNWngvNUpMTkJw?=
 =?utf-8?B?bGJrQUNqL1pnbzhuTWpodUJDb3NYQXppZlFtVXdSNG1pamxlOU5OUXJ5c3ho?=
 =?utf-8?B?YmhhZXZJQUIzRkdvaDM1WmRCSXFnN1AzOFlhTzlLNHFEMGUyRUdDSFNwb2VQ?=
 =?utf-8?B?clFJc1BGTkdGeUpZRGs1SDBlNlFIZXFCTVVubHM3SG5BeCtVdTh1NCsreXFV?=
 =?utf-8?B?dkpRMnRPRXR1UHNzUXFpL3hFYmRDRVJFNmVtYzFTMGZKY3crK1U4WjdraUJ1?=
 =?utf-8?B?a04yTXJIS3MwSVgvaFpEeEVCSmtqKzRoMEM0eFhsT3h4THF2OWNndzRjbUF6?=
 =?utf-8?B?Nk4yd2xmU09ZVmd1R2E4SUJMb0dMcW5LUi93MWwvS1Q5Zy9CZWZmVTA2ZnZk?=
 =?utf-8?B?R0lFKzl5QlBBdU45T0dnMk1UeEFuZS9LbGUzdnoyUlJFQ0NadEV0Z3c2OU92?=
 =?utf-8?B?NGZSRE9GbmtsaHpLREp2cFB5dlllWkYrUTY2RnIvOVZGcHkxUW5xeExYZEFS?=
 =?utf-8?B?TmpicUlDdkcyTUVaSDh6SHV2K0JYTE84S3NTNU8yUE9KdU51VC94VnZ1Ykc4?=
 =?utf-8?B?cHFQOGdJY09zWXcrdkFWK2UwVUVqMVlzRkY2QXpZVEFvTVViSURVdnRGZUR1?=
 =?utf-8?B?c0VXWXIxY1JWUnA0d3VuSEt4MEFrQlZBNE9HN2VFV0NBdFNtQ3REN25XZ1cw?=
 =?utf-8?B?dkZzVU1raXk1OHlWVW9zYTVzR0Y1TnR0TlhFbzdOSFZQZEVCS0F6VHVPNlpL?=
 =?utf-8?B?Y2pzdzc5bkJ2cFRwOGczcmxJTGsvdWFIaXVNczZPUGc1bmlZU0drSldmVDMx?=
 =?utf-8?B?NEJMWW9USTBLc0dmSmdQNHN1dmJIR3haTnB6cVVFUlpqY0NzL2VSd2ZYckFk?=
 =?utf-8?B?eUxjK0VxcXRJTUVNOXlyKzZJUU9RWnJMcGowY2xKb2NNbkt1dWh3U2tROWl2?=
 =?utf-8?B?cFRmMkh6M2lQcGVVT0lKZDB2QTRRVUsvUFFpajY0WGdlaEhOSyt0N3FOYnN5?=
 =?utf-8?B?NlhKa2hTT3ZLNllacG1LQ05ENGMzb2pkMDZER0ZaVGV4cTA1b2l4Wk9jSzBt?=
 =?utf-8?B?bzFwK1dCRzN3eUtYZjJFUjFhSklPRTFTck9vSGNGazFYb04xRVNIYjZ4dTVS?=
 =?utf-8?B?Skh1L3RRcEZobFZSZUhJMmI5b3JRV2NQaUVpd0cwMmVYQSszeDZ5Q1JBYjF3?=
 =?utf-8?B?aVMvbHdZYzR1WUpqd0dmZEw2em1scG8vV1d1OHNtU0JGV1ErRkYzTW9LbTNo?=
 =?utf-8?B?SGJERnhJazlJVHZSdGhlOEhaQXR1Tzg2MFcxODRJdzVXVkdwTlZORVNOaUZq?=
 =?utf-8?B?ZWhKYzFBczF3UHhzcm5rS2tnWE4zSlQ2aVBPaHlUdFRwZU4vWUkvbXRGSW5m?=
 =?utf-8?Q?ctna4Nx4LRjMPM1HLZGhbG/p00BH+GGx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZNSFNBZHk4L2VJS0ZUeWptNXVQTU40aGZVSVNtRG9CdThBVmlpRkx1K2t2?=
 =?utf-8?B?MERpTUpzRk9laUtxUkVUZzJOa3JlbUNRWlZqUXRna09OaEh2eTE5N0tLMTds?=
 =?utf-8?B?c1BPUGVtTXZBS2d2QUtwWWVHMElLaTNNTnliSDVNRzdKMklMK2IraEMxRSsy?=
 =?utf-8?B?Mk82Qk85MjViZlE1eVF2QWhweVpuY09Dc3ZQNUtWK2o3b3VkY21ZWXJxVmhs?=
 =?utf-8?B?aTYyQUk2NGJCR0ZtbWFoYVZoT0M3TkhwNmcwYVNzam5PWkdFSzViaktHd2Vh?=
 =?utf-8?B?K1lrWGRqQXZmSnJZMkFNajJlM1ZnSzBsQWpaZ092c2hkcHg0WTdwUW5FbjJU?=
 =?utf-8?B?QmdaWVQ0THIvdDU4dGlKY2E1Yk1BRGRDeWhPaU1DWUtuZStmck5jZXNGN1Bz?=
 =?utf-8?B?aklCNHVFcVpZZ1dMdmgzTGtwbjMxVTlGQ2xwTi9yUGxmd2pJTTRBYUJLWkpC?=
 =?utf-8?B?d1Q2dmg0cTJKVnUxZEg0U3VDanZlRE1saUdZdXA3TjhCU3hQZCtYRDJsWUdi?=
 =?utf-8?B?MFRQUkdaY1YzdWpBYnBrTVdXVFFXL3VXTjJDajlBZ3lvTGY1Tmp1SFN1UEpU?=
 =?utf-8?B?dlVVU0tVUU5KQ3d0R3dhNTBFY0ZMQjRZbWRGSjZHeDh2S09lbEJFa0tyekQ2?=
 =?utf-8?B?YnhQVzlHTHN6Z2dLY0ozMzZZbm44NG4ySVRtY0ppTkFseVBsV2cwTUpDbGUy?=
 =?utf-8?B?QXZveVZqN3FtY0JVWjlkeXd6VHhNaTBzZEJyTEsrN0JyMTNvL2JWMDVIWE13?=
 =?utf-8?B?YVprV0NMdFU2N3lPWUZqM01iZE0xTXZJdjVOclhhTlF5WTVEdE9oeUkzWm9i?=
 =?utf-8?B?SkhiZTg5ekNvRzVpbkFSN2hqN25wTi9Oem0yOThUQVZzT0xtUkQ1TSswZ3dH?=
 =?utf-8?B?TjcvUWF6cWFpSUVaeFhWblBZY3pTSEtFNG9tWWdOOTVNVy9qVGcxSURESmVm?=
 =?utf-8?B?UnNPWTVRQ3Q3R1lnM2tPM1g0cGUyU0NPbllqcEhBdTl6Q0JjMGhkUHNoY2Z5?=
 =?utf-8?B?U3V6ZDY0SkZwRi9KUkRpdEtMOURkOVJ4OC9RNzdzS2cxVjU0cVpzKzRmbURI?=
 =?utf-8?B?ZkJTMnI5Y29jd3ExS1BqdllTckJEb0M0Nk5ocEJmZFEwM0cza29UUklZODFs?=
 =?utf-8?B?YVl0Vk1zSGdTSnlKbDB6Wnhtc1l4dmRMQ01oc3VzOEFYYXFNbkM2Tk13VGt6?=
 =?utf-8?B?dk5OY2Y2UFkwT3U2aEt3QnpRQnBLdlZqWnhsaUFQREFiUFNPV1lLVnFwOHU4?=
 =?utf-8?B?Ly9Pb0orbVNwWlhFYnY2UCtndE9uWXBJOXlab1cxaXhINk9vY1FhT2tWeUZM?=
 =?utf-8?B?akNveFI3enFEeXVCeVZGMElBb1R6SEdOdjZ1bGd1dmFuM2pOZ0FqZVZmbWQ4?=
 =?utf-8?B?WkpzZ3pBMEZWVDRJa2d0UFhPbWQwYXlOcnJncFExdEk4eFVqYjc1NkZBQXZE?=
 =?utf-8?B?eUZGcFBCUDZjQWpZS3JSanpzdjRoa3ZLMlVFS1BYWlRwNU9SRGdCOEQza1RB?=
 =?utf-8?B?aExIcndnUkU1TnBnRW41ZU1rTnVtMXJxdkpOeUhBSEZRdVE3NU1ocnFWeG01?=
 =?utf-8?B?Njl5ZlY4bTkrL3NqWlZlQTNhTEZEVmFiRXRydi94dWx5ZENqRDB3akFWS3ZP?=
 =?utf-8?B?QUpIZFY4bUFCaFRDQzMzUkFDcTNna3F6WStlWkdZZ1hQQmhMREd3KytOVzlM?=
 =?utf-8?B?RUtvYktNdjN5K2ZDS3BMNVkrcS9MYmhlS1hEdHFkQmorT0U2Y0I4aEhtRndu?=
 =?utf-8?B?QUs3N0QwbTNZMmc3Tk8wYTRJMjBGbE5ZdHA3dU8wYnI2Mzcwdis2N1pWQ1pm?=
 =?utf-8?B?dzV2dGZRNWV0WTJudVpWUTNmc0cxa2FkbHo2NWxoaG1MYUhaY29TT3kvMWtH?=
 =?utf-8?B?emxnREEwNXVwR0pNTlY2RVZoMVdNNkNJVkdnWExYOFdDc2JVSk9sZHBIeWZV?=
 =?utf-8?B?Tk9uZWRRakhlYjFjS1N3QWliV1hoa3V0NjE3NGgwWFR1YUJKRnVmSTFIb1Fk?=
 =?utf-8?B?U0RJZmhxcjdhY3hVTGFkVUVTTXNLdUR3bWNUMmR0RWR3TkpUc1ZVbk5YRG14?=
 =?utf-8?B?ZkJvR1dkQnI1L2E4Mm9yRFN0bk9xYWt4ZzJKc2tYZnJHZDFyL1V3T1lQeDlB?=
 =?utf-8?B?Q20yWUUzYmpJb2J6SkExcGxKRjZvWmxrZG9HeUQyYWdTSmZkUWlkWGVwaXFW?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de894516-8501-4338-a2a5-08de0c00e131
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:38:25.4540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJEjn9mhDrHreVMmeoG5/J4zmEf/8Qmh2mnPCiCzo5mfGu17KFkES/Sg58GcyJutsFguB6NgLKseneSAfjQT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11573
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


On 14-10-2025 12:10, Prashant Gupta wrote:
> [Some people who received this message don't often get email from prashant.gupta_3@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Hemant Agrawal <hemant.agrawal@nxp.com>
>
> This patch upgrades the MC firmware release API compatibility
> to 10.39.0.
> the main changes are:
> dpni - dpmac stats APIs
> RTC - default 1588 clock config support
This patch shall be before "net/dpaa2: add dpmac MC header file"
