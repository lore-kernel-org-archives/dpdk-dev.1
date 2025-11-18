Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697FCED606
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:27:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A080640265;
	Tue, 18 Nov 2025 12:27:49 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by mails.dpdk.org (Postfix) with ESMTP id E469940150;
 Tue, 18 Nov 2025 12:27:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8mnON4L7PQ4RQGQ+4fwx79DuVBMmyvhVPjm3NialhtizGflP09Xc1IgfXHbJHOKWvmzWjHY0hoXdL3ThuX6KXeFKtcZ5ADdHtfKlgOrlxsHFS47a1pauwQpk855ymFad6cXfInpkbWZmLVjB2LB8oeVNC3jPGk96uNydIb1xeRgLf85LJCjPlaJpl/g+0lY9VCVIF3HxW8clj2Fxb6JBO+g/1UNaJBLssy1ndON7ddQ8shaSaq1J8UMtDRTiS/s0kBIbFpuhGPI5ZpaMY5aia6MiBjfFuea3d8gg1ftKD4qyu5fTfL8IMd1tSlOroOQk5el9WVZn1iTI1Sd+dC0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLb61r2nEEFa6F5nwRnxeetd0nefg4+XeO/bJBowClU=;
 b=iDrtPFuF+2tcJtcFP40D5WUKZo+RVyz5+WF/u+6HxliSix4yCWV4xQqrIx8YtNFgwTW08fZcaxTAOT34NFUzASL/FnX/mTAmcSxhD0hq5HvhSp1EdB7EFl5uhgY7LkdhYszyRfPUS3DIMNLS49m1iMrKBwIHVnczkIQLE0j5BnSe5ocLRr01AFOWC49Nswn9R1Uc9+fKkD8QmkUaFdj/KUrXd8zjLeb9z2r+DN3qMw8Vp2XDX8VwHEUyeNQGiMCSS+GhzOQMSuspYVCGkZ7A/h5AJSQM5dGt7papxGP1rhyPVQy23as/NHOrbvSW7trqZQsLCNaTSlX9aYVZX3m29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLb61r2nEEFa6F5nwRnxeetd0nefg4+XeO/bJBowClU=;
 b=cdT0kGHqvGVIXo5XKO+BeJqKZ8KlmEBBoQQA/YxZKlzc5iu1Nu5+ZYc7o4efrAVxdRUVB+nG+dW3Vb5FjQZZb/esLeoCIpmBdLxaXAjOH/LVnpylGKxTj9x0vcYtW7d4y6ePE3OHSCQ534LVK783MfivEB3ZLz9k27qgyO/z5+5iS02ktyS9/rT6yI0Bxpz3bbYtt4Fuqp29GjBFiDyzxiFNURndXuRlRvvwkGk8WpkKqLvp01g9VgVsDgzSk+B2v1egPUZ1kx8bgFdqGG8biY3kKavOA8wTLLpmg31AEfpcotkcCsLYO82rzq/VpnzAalnT/a3xfLqXOpqtPCxZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:27:44 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:27:44 +0000
Message-ID: <178fc040-63fb-42b0-a0f9-2b831dace260@nvidia.com>
Date: Tue, 18 Nov 2025 13:27:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix cap check for hash calc
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Itamar Gozlan <igozlan@nvidia.com>, stable@dpdk.org,
 Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251116115925.158944-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251116115925.158944-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8939f2-5bd6-434e-a8b4-08de26957e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEsyNVNlSUtCTDg4Z2JQek02dUgwbFowWUp3U2E1cVpXRU10amVwVDJvTisv?=
 =?utf-8?B?RktNanpwRFI1dDdYeWsyZVJMSEtvTk5VdmNJc1I0RXA0WlNrSFBEOURmaHcw?=
 =?utf-8?B?M0FZZGhjb2R6TVlQelowV1RTT2hOeExGbDVoUms5T2ZFa0NUaVJlSm9ONjZu?=
 =?utf-8?B?TnBUendKWDhnOHI2cFFQMVJOMnZLaHFOdU1xMVU4ZCtqSHk1NXJFUG1oYjZp?=
 =?utf-8?B?SjRNOU01RDF2V1VXQmx5dlN5U1Z1L1d4MTFwWWdUQzNLdTRTU1hHM0ZZakwx?=
 =?utf-8?B?SE5ZODZvM0lQQW5PWEhsSEVNcS9pc2lnclZqS3VQUDZPZ1IzN3Qwc1hmOWNv?=
 =?utf-8?B?Ykk1SVNjbWk5RjNCdStVTVBZaXA2MEVwVGpBNU5HSWdJV1NyNXZRak1JMEZJ?=
 =?utf-8?B?RTFiRVd4Umh0NHh2UXlRdFR2WFh1azZ1cjZaTXBZdjdCUmlrRlpibkQwcXlJ?=
 =?utf-8?B?blQxNFlvL1M3Wlh0ci9jYkx1SE4zM2t1SkdHdkdoRW93S1pFckVmelJhWHIw?=
 =?utf-8?B?UzUxOFpEZ082ZkpNQWFSdEJTbmdoanJnYkREakljSVppWjUybE1PTm5QdlpM?=
 =?utf-8?B?K3NnRnFMdXB4NEUwVGJGNnRFeUNyeGhBL1MwSWtidGJmR1JmaGFPNFhDZTZI?=
 =?utf-8?B?WUZmOG1UeElwREF0MXFiYUpzRDlPU2VPTTk1WVdQVHkyaEtMWlpiQkVCUjFk?=
 =?utf-8?B?MHZnU09IOVJUckdXa3plRkhXdEgxZGFyRDQybzhKTFZBczFWUzFpM05sSDRU?=
 =?utf-8?B?Qmt0cFYwWnVJNkNCd01NMXgwemF6aTFLZkVpV1VOQmpadkh4Smd6UXdCVFhr?=
 =?utf-8?B?SXZaWkZ2SFBIZUJrTkRNZ3FrV09nVVExK1NrV2EyVFhHNEg3Z09vaGk0Q3B5?=
 =?utf-8?B?ZTg0b1VuS1hxcFltWHpZQVJiaTdJMEJ2djJrMXdrUk5UZWRuN0U0ZzY4KzQw?=
 =?utf-8?B?aElmSGoxczAyWW5DVFBnc0t0YVFlYTZ6ZzNNdzc1MmdVMmZhblV0dlMzNXRw?=
 =?utf-8?B?UUZCcGc3dFlEQnIwWEIwMmlXWi95OUZFdzNqdGpGQ0J3bDZOcmFKd1liaXR6?=
 =?utf-8?B?UThXclJIbjBiYWtyWkNZTnJ1cEg5aW9XQ3FnczZXVzFxZ3BwWlFCS0ZnOEJQ?=
 =?utf-8?B?WTFHZG9Kdlo5VWhVZUJPWnNrUkZjZWtjeEFEbysxdjBXNnNxUVVaNkJ5aW9X?=
 =?utf-8?B?QmJYY3orZ2VOT1Y2Snc0c08xTGoxVytUSW0rMzVteS9YbFl6V1hoNnVkelJz?=
 =?utf-8?B?UGhwT0pEd3MrY0htZDJuZWNWdzlrSWJwNmlnZk5ORW41c2I4ODBrQW5ac3JU?=
 =?utf-8?B?VHloaGdkWTVaZENOSStHcG5rc25JRGhmM2VqSXVOY2hjdE5pVmtaK29UUm83?=
 =?utf-8?B?a1NOWTZ2L0VWc2Z6UXM1SEVaWTV6SEprRnE0d0pUT3FYZnpkVzlST0lCWmlk?=
 =?utf-8?B?UXFRMVdrbEFoN0tJajdERDlFVUVweGFrcys2Qk1RcXMyV0RmaWxDK202TklK?=
 =?utf-8?B?bEM4M2cxNy9vWlVPWndkY0dLKzBodlFUcEpzWHBtR0QwN0VxVklqZllJVC9D?=
 =?utf-8?B?ekxlOVZINHh5dzlTbFhnOS9DbEFaZXUvdytZS2dVM2hObldQdXpSUFNNcmxE?=
 =?utf-8?B?Q25sUi9hUGZCMlB3VDdIMW56NXJkS3R0aENNa01kVTdYaTBzV3kvVG5ZWWJm?=
 =?utf-8?B?Q1AyYzJKS0JkV2xMQ1NvOGNwWFI1dmw0dVRhNnFpb3NtNU1Fek4xMG5XZ2o2?=
 =?utf-8?B?eUFtUkxjV1p0eTQ5N1ovMHRsZlZNNTd2WTlmN3FKcXJMaHlsWC80SzM0NTZH?=
 =?utf-8?B?Z3hucEJqMEgrYmphSzVZVVpuNy9keTh3TjNvcjRPeUprVFdmUWJDOXV5d0Vp?=
 =?utf-8?B?L2hobmhraU1GWEVaRGZaZDhJWE80RmhQRlVvNUdXYnl2cnV6OFdBcStjUFhQ?=
 =?utf-8?Q?QO9foOuQJTgqn9qVqkMPNoXEisugYWTf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElweXFqSGNWNVRtdWV0c1pWVTZGSitYektlQm5KdmdZcElXNSs1Z1U0ajBT?=
 =?utf-8?B?cGtEMEI3QVBNV0hkTG9FbHVpMktlUmgyS1BkMlAvSzJtNUNQdTBPWEVPSGQ2?=
 =?utf-8?B?cFd0cEN2R0k0ay9lTVZhaGtvUWZTWXdLMFdabGFPYUZZb294T0h6TmFyRmtM?=
 =?utf-8?B?QXllWmxzcFcrT3hYRXJKVkR2TUdwVEwzbnFWYVQzUnFHdUVMRzJtNmk5aUsz?=
 =?utf-8?B?TVl1UXRzZ2JMUk9Hd3h5NTQ5Zy9GaWt4VWFPa0x5cWpDL0xFVmZHRVlnSHZk?=
 =?utf-8?B?ZkFSdjUwR2N3b0FMYnh1dzBhbmdmRThLR0lDSUxSdmxBclRhdzlHYzhjSmJC?=
 =?utf-8?B?cUZLeUR4bjBJNVk3MzRCSE50L2loUUhIcVNoeWM3cjB0R0RmbUQvOU03a2Rp?=
 =?utf-8?B?MHg4UHZWMmtOVFU3UVRnRXY3dUxtOUtCNTJKTHpGeHVhZGRvS1pqY25mVzZj?=
 =?utf-8?B?bWpvbnVDM3hJTmh3VmRjMEltUmtSNDVoeVBicWtQTEZzczNBbkFvSDB3ajRH?=
 =?utf-8?B?TDk2SmxJcDByYUFrbk1KQ09hcFFlTTNuMFdTVDJMTlV1ald3TTU5eUR6MWVx?=
 =?utf-8?B?KzlGcW5NK3J5amZjd2JJTHdLNGx2bzcrVXJSaEk5Q0N3QjliWnRhQ1VKSysx?=
 =?utf-8?B?ZTlpbTE1UjFhcmNaS3hJMy9VMmMyWWFWMzBFZEJ1UHdadWZvS3dPYUxHL2F2?=
 =?utf-8?B?cWdTc3JNMHJGNyt5TVhhUXhrazJPcVJKZzljc2dWVTdtRDZHK2hJcThHS3pU?=
 =?utf-8?B?WHYwVkdCbWNCZmtkV0lZR2dFeDlnUEFEVHFPbkxLQUlSS2piS3JFYlVDVENv?=
 =?utf-8?B?T05iL050VlJHVW96cjVrQjVvbUtqN3VGa2pDNGxiNVh3RGUwQlRSVCtoS2Yv?=
 =?utf-8?B?T0J3eHNqWm11aHErMXNoTFdlWm5vRjJ4K01QMnJwY1hoM1lGZnRiYW1vWWdy?=
 =?utf-8?B?UjVOeUp5dVFYN0x0N29mNXRqV2ZtWmNPUVc5eWt4SVoxTEE1N1lVVmp2MWpt?=
 =?utf-8?B?bnR1RGVPWnRQbnBTNkpNVjZ3aysxRnh1cTNMeVJzQ3FqbzdISGRtWVhrQTdl?=
 =?utf-8?B?bkdVazRwK2ZkUFA1cDVVcngwZTBwZVBIeGZ0WmNGd0tERjhYNFgyd21jMmNV?=
 =?utf-8?B?QktnNStiaXVyUjV0cTBTdU1EcHFLNFZKNFZYUFRCM1BiOGdsekRnNWl0TDJW?=
 =?utf-8?B?WEJ1V3R1Q0VYNEJSTXcyUWRVRjZacWtyTXc0SDd4dHY5ZS9XSGlRb1UvZjVY?=
 =?utf-8?B?cmY4M0pORzdUWElVZFVXRUs4anYrZnB4UkFIcXlPMHd5TlcrejliRzJaZ3ZT?=
 =?utf-8?B?cEpZSHJsL0l1T00rTGVQRlZVaWRsSkQ0bjIwWGhCUU9xdE5pYzUxaiswMGFU?=
 =?utf-8?B?eVJoSXUrZm1kdFpaK2drbm9lWVBOOEhDa1d1K3NJSTJBZm5zQ05wM0Q3WnBE?=
 =?utf-8?B?ZnhkWWFLOVJ2Rm1PQXFQaGE3VDJiQzNwc1piR2NwNjN2b3B0Z2FUaDdCYVhL?=
 =?utf-8?B?a3NTWGtmMHQ2WUxIbHE2MUpaNWJIa3dVZWlqWUlQUG1pdjV5UUt2ckRzSzJp?=
 =?utf-8?B?T2hLeUlaMjVPclViV0RZMlJ4S25YWVdLRFRMaEZBNVNVWHE3aFpYREhERU04?=
 =?utf-8?B?MFl2N3JMb0hOL0tCUzM5aXR5RmFQb2N1ajdYNUJPb0ladktyZkJNSkdRMXMx?=
 =?utf-8?B?MnVtQW00MnZzd3hvdTZnbGtSc1hhNzRFQmJpU2dWVHdwQkFTTDl0YmhhaEcr?=
 =?utf-8?B?cHV3NVRzT3FXQzdKUjF3NFoydldJTG5lUFRNWGxvSFVOa2pmaEIxZk9ZL0hX?=
 =?utf-8?B?QUtRRVVlNENUb2gzbGtEcmNiTDgyYlgzYnBxc1IzK2VOejAvSFdUYzRMZGsz?=
 =?utf-8?B?N1d2Tyt2Y3o1TkRGSk5UVmRLNG1zb3JVV1NiK0ZKb25LWnp5Y3N2R1BkRDVX?=
 =?utf-8?B?d2d5TklDaVFBeHhBN3kzcE0zOC9ibVpJQnhpMGxSSkFBbjRpbEJzRG83cU52?=
 =?utf-8?B?QWVJeDVTcDRFWXhtM0diREl2TE44ZUZYYUVoS0FMbnRVWC9Nc2owbWtadVox?=
 =?utf-8?B?K2lUYXhWajEvNElBSUxtcEF4TkJ0aU5wK3F3eWpST05nUjJhTVAwLy9UakxQ?=
 =?utf-8?Q?Vp5UFRtbBUh9nhtejWVlC4wgC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8939f2-5bd6-434e-a8b4-08de26957e19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:27:44.3342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEh3GjxZUXbD3SYR251cEMDZKPOxW7rjkNuAQ/yQ4MXwnpSzmoajrPI5Rc59OgMAnqCbvmn28F5t9gw+e9OzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

On 16/11/2025 1:59 PM, Maayan Kashani wrote:
> From: Itamar Gozlan <igozlan@nvidia.com>
> 
> Some cases are not supported for rule hash calculation. For example
> when the matcher defined as FW matcher, or is the hash type is different
> than CRC32. One case is when the distribute mode is not by hash, the
> previous condition checked a wrong capability, while this commit fixes
> it to the correct check.
> 
> Fixes: 7f5e6de53aae ("net/mlx5/hws: query flow rule hash")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

