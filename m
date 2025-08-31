Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C2CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 12:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7116440292;
	Sun, 31 Aug 2025 14:14:24 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by mails.dpdk.org (Postfix) with ESMTP id B33AE40263;
 Sun, 31 Aug 2025 14:14:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEE4lsdGry9WtBw9dfnZR5zryUysvXW/a6t/R0Oq3Ienhtx8VZ91dHicimvLu8rgT7LYp5Gton2XAQ05q7zH3wZj/yILGSD2cw4tbDqVi20DZkIGoPl1N7CtvsbtuBM6CBPsuQIbms2n/Oj676ryZIJuFEfPbLywkLEjKdgCQaoLGKZ4JNb4m+p4kNAZ04OxBtV7Vy0/+RCYxeGDgO5E0L+RM6gr1iaDvqAvFm4jQtL+J1qcoV2SWFznVIwnW/FxZONIJWVx8Ahy8msjf39Ae5OfaWmOynu3dNspOxzTIcE8NzKC/o54iJVKl01vklr/WFXJeeMON/u0xdf/1Y3vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDq4zHmme3E74OYrkabpvqLk3pJDZgNuG5ykbUlVrD4=;
 b=IfxvIo6J47vpIlyPbgmamAZrYe5vKmGHdlTstdpu4hA8fSFLUXkeyNZpiub160U+ZNeFZ1OwtX9F6FmnEtzpBpfxV7s7YNdLrsAXq2i/EWx63bteOQSZFEyTcAj40aXTFH5tH3Ocs8BGkdug491h5AlqygrzePfrZ6FIBRyWD7XF9vXgrvWyevpXxnGIeZD2Xu06P4FyPgxYHWRRX2sHUN5nk4xSzw31y+navQqAYYnb0sIIZavdU1KEdzsbnUq037E4x5dsGauQxaQixZK2xU8clR/E72kFYN/wWczzeXikuUf2dLvr6LLy7F3ZThMCe5/bwIKq32+890HzvlzAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDq4zHmme3E74OYrkabpvqLk3pJDZgNuG5ykbUlVrD4=;
 b=U4bp8M1hqbSkpClEl9XqeeTptCEeicKazR6sO8hYxH1E91dCwQ34JJA0IO3hC5xiL4afwBRKKHdfy2TjEn7gWvPPQQdY8HNikWkSlaHYkk4CaSR7fesw+TdiM990Z6E5l7S9phfB+AyNjeIgqsw5/ypXmRnAFfRBHxV/ym4oTuSnqfRpFOy+WCsF/rJaWNyEyhIUNyE3/q45vJungnNY2Vqnrc55gwurC4QUrRSaPCBpL3p+kXFo4KtaGBPR8Aay/mq1JqFRdYL2IaK7KJyfcMsOtFkcX5TplKtC2hvx+fPz+KMcsMsilkRjN6AdolrssXxP5jmv/MS1Re9HsDnr2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 12:14:17 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 12:14:17 +0000
Message-ID: <aaa40a2a-c1e4-4de3-ac78-bec5877cb6c3@nvidia.com>
Date: Sun, 31 Aug 2025 15:14:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/mlx5: fix connection tracking state item validation
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250814101601.3532391-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250814101601.3532391-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f7b966-00c1-4bd9-6424-08dde887e7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGdIaGFGc3ZWSTBWQ1RGU0RZcnJ5QlhqWnR4TzVGakJraWZXVkRIbjNtUmxD?=
 =?utf-8?B?SHVzMnNLVG9QQ3RQTlFxeEpGdUVidG8wdE5lamhkSlljUVVmRWVQekw2UURZ?=
 =?utf-8?B?Wjd3cnUzM2c5MTc2cGRIN2h1T2x2Y24xMGhycHRXSHZwUHV4OVkrakFoNFBX?=
 =?utf-8?B?a1lxa0NPSUtrbFgvcFE3dDVFSW5abU1pTktKM0xaOWNQb09XUzRhemtFWEVt?=
 =?utf-8?B?M0JuUzErZEpISi90S0g5QldneVBvT2J6TDBmUFdtWi93YUUwN0JnVDNQeUs1?=
 =?utf-8?B?b0pzSmYzaEdzTG5va1lqWWNzclFqblJ5K1E0Tk9sRzFJeUE1UGhlcUVrUnpC?=
 =?utf-8?B?dWJ6YXNrdUhwU3hqbitEVjRTQU5UVFh4emZXZXZNQjJ3eGE5cEdqNyt4WVZJ?=
 =?utf-8?B?SFlLRk5ycFkzdEhFOHRhR1N1NzVCTXJMZDQySzRnc25KY3J1YmZxM2g0ZDhO?=
 =?utf-8?B?NDdiUjRpK090V2Jhb045V0VZUnR4Qy9qbEpGNjdPZTY4VUdQMjNvV3Rpdy9J?=
 =?utf-8?B?b1BpL3J6TUNnQ1doT2E0elU5YnU4YVRwNFYwSnBJR0NXdy9XTSt4d0J5dEJK?=
 =?utf-8?B?bDgxMkFzYjVJUWdqSXFaV1VVOTJNWkNrNytMcGRDK3VWYU5la09jaklUbzdY?=
 =?utf-8?B?V1Y5bW95UzVGV2QwT2ZNMjFpcyt4ckZGTmtzSXdBYTU0UWxZMDhLSnp0ODhM?=
 =?utf-8?B?bFVib2cyb3BINjdyUVJFdlRTMk9HZmlVRDBFaVUzTG1NNmFtQXlVZG9waGRi?=
 =?utf-8?B?V0o1NXE1L1lQZmZURHZBcDVwWExVa3A2Q2pyVXF1Z2xrNUQ4bkNFc2tQSGZp?=
 =?utf-8?B?RHprWGMrRlhDb0RZYzRqanZ3enRGWGZaRzdyUUVQdTVVcHNvK2J3OEJmUWJk?=
 =?utf-8?B?T3pUaGhLcyt1UlpKVXNLUGwxNENJQXFGMk1EcXhoeXpNbW8zYW1pUTMxV0RZ?=
 =?utf-8?B?MnFjc3BZZnl0N0Q2K3VQcVF4U0VuU2pqeUg4MDVUNVQ2VmVYTFhLd1NLMHJI?=
 =?utf-8?B?Q3hyVGVLOXhqNFpIZkUxN2JNNWhqelNFM1prcEVRZDhiTWtGeFM5b1U0TWta?=
 =?utf-8?B?bmNuM2xWemdNOFk5ckpSQkFjVTlpamFOYXRXWE9rcVpKVmwzVlhlYTN5U0VC?=
 =?utf-8?B?VHBMcXdpZEp5L01GazVNYjZldit6c2tjbXJYRUZ0dWxWN0pFQ3N5SG04akZw?=
 =?utf-8?B?bDlpV25wRE92a2JueUdaTHdRdWx5WXlTSmZVclQwL2NrWk9XUWpYUWhxV1JM?=
 =?utf-8?B?SVFjcG5jZVFRZmF2WnMvMTVzQUxrbE9RbDNVLzJ1K3Y0dmJOU2kwSFM0UmxM?=
 =?utf-8?B?dndPblFobUNycVBweHpWUDgxTXFpaFFnZ1c5Z2dkYmtZVVNGNjdydUhscllS?=
 =?utf-8?B?eEdXVXBHVzhzUVQzYi83VVh3bjkzTUVSU3lTT3VIODUra3YwVS9lMXp5bW9p?=
 =?utf-8?B?SEIybEp2ak9ZRnVEVnFPRWovaS9XejVCRHZxend3Mitoci9EREl0emoyK2VX?=
 =?utf-8?B?RlJQeVRVVmozTEdoNWhOMlY4NHZvdnFwaWE0M01ZVW5DS0IxUXMvdkdVY2Z0?=
 =?utf-8?B?a2s0ZUVOcFNIL1cyYWJWR3RXUVNpditDcGkvUG9ZUWtsZG5xdDVESkV5d1NC?=
 =?utf-8?B?VzNnT0Znb3R1NkZoa0Fwekp4WXFJTWxUNDB5TCtzREE3ZVJRbW1KSEVEUVR3?=
 =?utf-8?B?VUFIaExpeE1ldDRZNkYvUEh4aHFwZFNMZ0R4UDVLRnBCTDd0anlhQzJXZlF3?=
 =?utf-8?B?bHppaEpuVXVtb2h6d3RyWEYvclhPVFNEcUhBR0VzanhhWmxKS1JKSU1SU3Q3?=
 =?utf-8?B?L1N2L2RMODUzbFM4ZXA2K3pOdUVVOE50cEZ1OU9XSG9SbmNlYTkzRHpVV1F1?=
 =?utf-8?B?dXN3ak9sMDJTR0tGMExCcWJaYmx4aGRnNUZrQmVvMW1sSnhybERBL2Q1ZkNp?=
 =?utf-8?Q?t8pVHU3Var4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklXcVlZK1Q5WjFpT2EyVE93NUZpUWRVL2lQMWFlNzA0Z0pWaUVhWWIxRk1Z?=
 =?utf-8?B?UmZ6VkJmc0lETmE5NHNYaGxvMjZLSURydllGcGwvMVdEYkRwZVdPWWtxS21K?=
 =?utf-8?B?MGJtRTZoM2oydE8zcG43aDBRV3VsYU5wcmtNR3FyTzlsSTBQMGE5Z1VycnFq?=
 =?utf-8?B?cE1lMEF3UGdUTkNSeVE1aUJib2pqZW5XcEpxTVEvSkdTMVpURnNQU0xVb3No?=
 =?utf-8?B?bEJqenZWZDFJbDZZcXA2MEdWT2ZYTjdxbWg4L0pKaWFZT0dLK3psb0s2dXBy?=
 =?utf-8?B?WmNDTnNqcGZ4ZW1taUtVTHgyVzcvdEhKU2ttZGlZcnp2ais1RlcxT1VQTUdo?=
 =?utf-8?B?TzVjMEx6UlVSWFZTdTBlV0xsWFIzY1RGSHhpVm83UE5KVjh6NnppTSs1TnV4?=
 =?utf-8?B?bFhsQVE3U09hbkZ3cnFTZWJQUWo4TzU0SWxrdmQ4UWdMMFdjLzNnNUJPLzFV?=
 =?utf-8?B?dVFQeDFGV3RkWGVrYnBIbDlPbGgyV0lYUFIvc1F2VHBMRkFrQkx2bUI4clBv?=
 =?utf-8?B?RCtpSXBXYm9uT2RLbGtUN0NzZGpOUEJOM0VuYk1ablVyNWJxaGlYcWtUbC9w?=
 =?utf-8?B?RkFQZXlYZDdXMGJFenkyeTdUd0tQTndQZ2FyR0hMR2FMRFo4bGp5MXo1Qm1R?=
 =?utf-8?B?RHc4UjdYamhPb29WUGpLeVRQTXF3UGtnNzN3aWQ3bndsTUFyUHlXMklDLzBT?=
 =?utf-8?B?eFFCT1pMWlNnQytqUjFHaHlDUkQ3c21EdVQybzdnc3M4bnZoMnNwOTd1bDRN?=
 =?utf-8?B?K2ZhZ0NMUXNyU0FYbGlwcGFrV0piMEtXVEYvdG1obmJjL0E5WU05eWdEN0pL?=
 =?utf-8?B?Si9RajJaZlh3SUxORVhCVVlMYWsxbENkbHhOUm1iODhLeURwZ1h0dzlYMnpI?=
 =?utf-8?B?UEppNHZiNlB2SkxJNHQzdUtVR1dBbzZXOWpaZm5lMGFINUxKMW9VQWtYbUpN?=
 =?utf-8?B?R0Q4ejVPMG5VQVRBZlBjWElTYnZXbHJLNDY4ZXRRZnBtYm1JVEVveFNhaFlE?=
 =?utf-8?B?eU1ES1c3emdaT0tpZXF5aCswb3JVUmZSTlhxSWNsYUg2NEI3VkhTU1Ixc2tU?=
 =?utf-8?B?MisxOUgzQytZTXF0TDd2MFNuMldKNThxam5EMWRNazFGRXBucG81REU1RERE?=
 =?utf-8?B?VFJSZHcycUtZbUdGWGF4dFBSM2F3YUpqNkdlcTUwRGRqdXZDOVAxZFhvUk9s?=
 =?utf-8?B?aVZHV3hXZU51dWJadTZlRUg5SFBPRUc2Rk1HZXgzQlJYN0NuN1RVdGlOZjF2?=
 =?utf-8?B?cE9DZjdXZ0YwM1EvYUhSbXY4UVJ0THExU3JrQ0VPM0ZySGx6Nm5WbjAzT3BV?=
 =?utf-8?B?a1BPK0tIcjBGVzdUZ2k2bER1bXo3Y3NoeWpib0o5cEpvQUpZUkpUTE5uNWcw?=
 =?utf-8?B?b25hVnNPd2lNWVdjRTZDcUpaOUx1cXB0bnVJRHBjdFF0Q3BUT3g5SEFDV1Fu?=
 =?utf-8?B?ZHk4T0s5cUV5Zjh4dWorQml0Q2M0bzVES0ZUbXg3bGNnUUFxTkhsaWpLVUdo?=
 =?utf-8?B?dEVMaEVtNXJMdlBDd2VRaVhZZmcrNjQ2bnVxNW1BTm9CekZtR20rVytUbGtk?=
 =?utf-8?B?enVLaFFHTFhKcFJrWmxNcG84TjJQRENLUjdlT0V6aHMzYzZtWnU0OS8wV3pP?=
 =?utf-8?B?WGVvbUpVbFh5SHBkSERKSU54bGpTamhUU3VJVHZCaDdGVkxHdkczVEdrVEhi?=
 =?utf-8?B?NlhybXRoNGE2ZCsybjd6RG5hbGhnZnRVMytXdFgwcWl4Ynl0RDZvSms5SFho?=
 =?utf-8?B?NmVtMnNFS3VGR0JlMkNwN0htMXltdDd5b0tTNUZ1eUNkZUdJdXIrdC9ra3Jh?=
 =?utf-8?B?cE80RytqZEprak1EL3V1TktYT2tQenJQUG5JWkU3MExuUmFIakNGQlhDOW5h?=
 =?utf-8?B?bU5XMHVVVzhHYXFXTVdDSGVyQlQ2QXdaN2l0RnhBSzRnODF2WE0vZ242amRz?=
 =?utf-8?B?dWh5d1dYc2pZeUNVMWxTT3RWTXBlRWtWaFowTkdXZDlnQkZueDZWaTFVdXhH?=
 =?utf-8?B?cG9rWEwrN2dxVE1xYlRvUWRGeVdWTE9TcmM3dmpJaFlRV2YxRWorQ2I2N1Jt?=
 =?utf-8?B?ZlpvSUVrUmpQcUY0VzU0OWxGb3FuOXd0MWlOTWRjSkgzUFkyeHNGMW10azBs?=
 =?utf-8?Q?H1wgmIo0rADcp9wldamxRZoTM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f7b966-00c1-4bd9-6424-08dde887e7ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 12:14:16.9768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebRrWuJCHyDWD2JOoAkXJOLvcCWZXluTSjpaW29zcNP4dfGGi2DjEHOKY/ZThRDp/OXvxci8tfNOt4+E5zQJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

On 14/08/2025 1:16 PM, Khadem Ullah wrote:
> This patch validate a connection tracking state when matching
> 'conntrack is' in rte_flow rules. Since conntrack item flags
> is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> flags is a valid value to match on.
> 
> This patch validate the CT state item.
> Fixes: aca19061e4b96 ("net/mlx5: validate connection tracking item")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

