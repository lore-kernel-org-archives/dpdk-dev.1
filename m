Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7CCD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5EB41132;
	Sun, 16 Nov 2025 16:37:39 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53]) by mails.dpdk.org (Postfix) with ESMTP id 88824402E3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 16:37:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNTwVKQ5KG/BtMvEwkxq8T1jF1/gQGOOYoPCdVxNocO0vNmnd+TocW1m556nQ9BPkhOfVxaxdI5LVAR97feYorQ2d/nP33wFwMk4uX95fe364oWD2+DWU92H7skIXWv8RUGqjfF3IvjIw63bUzhAte+6eI3L5cJJOfmyNKRbY1HyDarRngkwXfp9kx0mFMuJId+FzJIRSUCBMJ1eEbtMV3pchDwgl93uwnw+8W7VsqCZdUs9wdF1Zl0/aNEuDcSa4v9ewjRgThF9+8GQlzPgVD16pOvsZ/N4PGXTpBeajcpzNGkaBqgIJENd5RWRB2disLWsBU4DLh/0JCNOolaMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W6P9vXt24G0Gw6cEQI9TcdjV8o4nwe6AO4kk3FOlKU=;
 b=mgdWRTMoMMvn6AOpMQWf4k+UXrSf0SgLbBcP2UAs/0qmatu/ZGYjGeXcC8eiTclDeYM38QG/aEHAHuqbw232pUvszEJno4LmYuP6h1bM5/3kiNYqateiR1JUm2KicvsXUPqsB217IFj8mnMMZ4IPM7OxEWYz1f+yEjKynNZqijb+jlGdpsG9UdUqzMrd7ysmYPeF7aQgV3c6BN+Np5IRFnMFkLO2oSnJygXzKhlMCSf/Q4umswweJk4+PQzUPZqP0mjNO5K+hpGNqIeBmvwLye8qMMFtpG90SUcbvTyFz4QDinMMnL92qKEae7XY2rYEc0Q1luprnBBuUGQDI3nOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W6P9vXt24G0Gw6cEQI9TcdjV8o4nwe6AO4kk3FOlKU=;
 b=lfK9TAaCX3fW/g7Iasp/PbZIRJamwFoNq2XNvz7QxJrZgZmNjPlLlFMfq++jHyudq0r+11S6hEvam37m8ElMHeRvDYEV8kODMB3KFE91aJ4KObLSASoXjR5vtjyORzj0jF2F0oQsx2NZ2VJEVAKWA3BHulO61mwhG38P/tkYm3NkyehUMdumd0CKDawTb1RZul8og/2N5Yx40W1ICdFqhwTLRvydJcDagBryJMAJst/fc5OYuRvZ8IOOL80R3/4vs+AG4+7UPmzxWxige51xiZ05wBCSkKFum9/4nsaaiU9/NbQDjuidShGLw73N52RbgVb5H2rbh8++FsSuFCen+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 16 Nov
 2025 15:37:34 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:37:34 +0000
Message-ID: <a6291f03-e4b0-4904-b60e-4148a9558099@nvidia.com>
Date: Sun, 16 Nov 2025 17:37:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix cross GVMI metadata match for E-Switch setup
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251113071746.434067-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251113071746.434067-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: a068637d-7944-46dd-94d6-08de25261037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWJUQlNOOWN6cUtGNDRYMW1lRnlsTEJGOEdNZTBZYXd5N0FwalJ5WFk3S05M?=
 =?utf-8?B?cTJ5OG1wQTkvNEE5dlZESWhVNlVJcW1ZT3hYRVhkRzVjdjN0UnBrbDNJZnZw?=
 =?utf-8?B?YVlFb1RCdzVLd3lDQkx3dFYveFpvaG15RHR1ZC9QbFo0N1VreERCMWtNTE1r?=
 =?utf-8?B?Rit2WC9RMFBKMmZuUHJUWGx0QUQydkt1V20xWHpMYnE5ekwwamhQdklRZ0FG?=
 =?utf-8?B?TkR5RnlRT3V6cHI2OTZqYWhzaUVibjBqOVhXN2c3VFRxNlRBRzRHVlJPVHly?=
 =?utf-8?B?aGNvY3JSVFU3Sk93cnpHaUJjV0M3ZVhQdCtCSWVPdnlPRnl5TEgzbldJa3F4?=
 =?utf-8?B?WjBJSmtoUFJ3WmMzd2pjakdFL0U3NjZ1ZXFSdzJyRlUzeGxDUTJQSjRXTy9X?=
 =?utf-8?B?VXdoZU9wcVpXYk93R0VWaGVBc1BGZ3F3QU5VaEh6bW1WRFlZRmZMYTZVSmE5?=
 =?utf-8?B?cU9kVUQxTDdKQVN2NndUS1ltS0dvRVZ3N0xWQkZDS2MxUW9UU0wrSnpSUlF0?=
 =?utf-8?B?aGFVZCtETWtwOUNlTi9WNkVwTURaK3JsRUVCK2V1dEpkd0hSUW5hV3poUWZI?=
 =?utf-8?B?VVRZKzdiS2dvbVZYQTd5VUovdllOaUc2UGhTcDBPR1dFdWg0UHFIK3ZRcTFh?=
 =?utf-8?B?Mkt4b0lXRkx5V1pWRnE0N1hGV0h2MXFtdU5sLzM3T1gvVjBzVWtIRzVwWUZk?=
 =?utf-8?B?bmwrWFpXTndFN0NLTzdQWlIyUlhmY1Zmdm5sZnJJNk5CS0d6MjdNZWg0U1dK?=
 =?utf-8?B?bjVLL1RLd3EyOGl4RHdOUitJU3Y5SS9IWmJFT0NwczF3TU0yU2k0TEkwU1c0?=
 =?utf-8?B?ZktMNXdQQ0MwWkdsUTBDZWxIOTdFQk5VWnJiMmhzRXNyWnB1Y1dhbEhYKzF2?=
 =?utf-8?B?Z3VyMmh3eUdYOTRvaVFMcllLMnlEaU1rTTRabGlBT0ROdm10djZoYUppQjBs?=
 =?utf-8?B?UzJiSnBNUDFHcEhjYk9iZGNDZ2hmU21zUU5ocHh5K3ZINHpFMk1TVTZsSDdY?=
 =?utf-8?B?bmRKSHFzYVpyVGJYNzhTcnNlcGMzU0JMMFhZQzc4MnFKcmdXQ21JNkNYeXNJ?=
 =?utf-8?B?RE1DQ1FaSnByQ2EzQ252b2VVZ1pSSmJLb3ZxYTBtZzZmRUVRbUtGWm9tcUdF?=
 =?utf-8?B?YkxiR2k1ZmZ3dmpZcTN2STIwMkpIMlUvOVhHQTBpT2Z0aWgrQzgzdHFEaExp?=
 =?utf-8?B?RUovU2pwSWY0TUptOHpIdjV3dXRpYWZpeUc5WGpoWld0MVlveFNod09SeUNo?=
 =?utf-8?B?ZmxwOStrVVBiSFJzajNOMnFSNk55SWJUc1U3TG5TOGt5Tmg4WExNN2U5cy9B?=
 =?utf-8?B?S0s1M2F6aXl5ZElCWFpQOFBQODdNSkFwc3dIK2c3S29RN3BycWpMQzhLb28r?=
 =?utf-8?B?cGh2MDVSM3lBVncyQmprdnczaHg0QmJwTG5OMktwblVteFFXV05DZTFjMlk3?=
 =?utf-8?B?YU1VcmVCRWVldEpBRDk5Uk1UUUplNHNuWkVjYVRHbmhqZFAvUUVxcVFLN3gw?=
 =?utf-8?B?QWlidlgxUjdkbExNSWw2aHBDeDRxMkpQNmFYV3hRMGZvRW9MY1c4TVo2WEcz?=
 =?utf-8?B?STRVa3B1eDVPUFNZVklVYmwzWlVWbzE5NHJyK2FHakFFenpGTnlYeWc1dWky?=
 =?utf-8?B?a25ob0pRK05DakUzamM1Ym5ha1M1MkR2dkp5bWZqK3FhdzZ0NGt4NXExaEZO?=
 =?utf-8?B?eHNxMUY3eDE4bnRQTllGVzUrVG92ZkFPbzFKbUpWU0kvR1dxWW1tMzhVdi9W?=
 =?utf-8?B?d0JuQ2tFSEY0bTdKQ2VEbmlUZ1lMVzZBZ0YzTmJtZTZ5SGVxbWxQL2dsTFc0?=
 =?utf-8?B?MmN0THA4aGdGVk1UT1pWZS83RThtVFNkcFNPRzJqNFZRK05zbGlLSk1BNW1I?=
 =?utf-8?B?WWM1cmdYS2JlZ2JVTGNyemZEZi9tVDhLdGNiU1RLdkc0ZGJ5UnlQVTM1TCs4?=
 =?utf-8?Q?HcRJMoszMbqzqrj3I0Sr0/YjpY06IXup?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZoeDliVUZvdTJDc1hzemVFeGxFUmxUbzVheWtXdlJ2SnJacnRGMFhZRTBK?=
 =?utf-8?B?VlJSNzBRMWk4WjNwSFRVeEhWdThzNjZaVm1rOXhoaXcyOUNCU3N4TTJTVjQ0?=
 =?utf-8?B?ZFU5Vkt2MHMvZ21MRkVyV3IxRmszZHlyZkg2R3ZLajJZOHNvb1dBc2VrY2xi?=
 =?utf-8?B?WkQ5a2NVcFVwR1VNUWs2QUZnTFU0Uk1vWTRuSEJqS2VUWk90Njd1bUNtbWJH?=
 =?utf-8?B?N3NmbVBNTk5LYi9Xc2M3ZVF6TnRYRXVZeWFxOGZLcXRoMnZmbHhXR0R2Nlp5?=
 =?utf-8?B?RENxMkFYajNkYlUxcTVpT3VzSmhwWVZJT1ZkR2U2SXNDMkV2NXFWa2UwNzgy?=
 =?utf-8?B?N1RKUUtRZEFzQzNoRnVpVGk4WVMxZlM0T29YNGVtM0RhbkF6b2MzRHErbXJ2?=
 =?utf-8?B?Y3Bmcm9kRTRXaURLdjRKV1BxL0ltQVk5ejcxN1owbFE2QkVoU0dOU3E3WXow?=
 =?utf-8?B?disvVWRPMnIrTnRYUGhBRlRZeFZsVytHYWd6MXZzK1pJOTJDb2Yvd1dLWFJB?=
 =?utf-8?B?cExqK2VoTXhTa1Q4RkdBQkRMMGdpOXN1OFB5ZlFtamlEZXJDeFNUYXhVRjVF?=
 =?utf-8?B?OHE2YTZkMWpzUmlxeTdoMllzaUVka1Z2SnRBNlZTTG9wZ3g4cTY1T1FUQXpZ?=
 =?utf-8?B?ajRCUkg1bVdDY2RhZzgrTVN3bXdaQnc2ZUhRVkQ0dS82L0E0Q0FoMjlBbEF0?=
 =?utf-8?B?MlNIbStReWNENnBvZEdGLzBIcldFYUNUOXg0eFR2bndDYXc1VDMxVWJ0Mjlt?=
 =?utf-8?B?aUduSFlPa0dBWXpvMlNKQmJlU3duSFhKcDRuSGkwR0F1M2ZhZ1hWM1I0SCs5?=
 =?utf-8?B?bmU0dkdrc1BlU3RjdlVSWklTTEYvOTF2b3lDMHpFNVdhZWtvSjczWUJQYzZu?=
 =?utf-8?B?dTVGMCtmbzFEOUY3bE9rNW5GK0EzeXdQL0pUTzBuempGb0I0MmMxWU5ycmZi?=
 =?utf-8?B?Wk80WFRlc1FaaEdFL2F6a1craVpMRGJpVTVlc2RwUzJKRGRCNERDOXF3a1pa?=
 =?utf-8?B?S0JyZExKalNaSmJnSXNCbzI1bE5NYzFyMHU0WGNmR0ZjUnVJRXZMZEp0QkxY?=
 =?utf-8?B?TGVGN1VTbTFzMkh5N2E4bWQrenh3YStYOTdlMnNqc2xlQ29CL1BXWmdxbWQ1?=
 =?utf-8?B?d0REaUVseGxHek43U0xmaWJHeDV4MVVQYU1iK3daWkxZVHd0TVV3a3UwWjla?=
 =?utf-8?B?M0VpL2ZKOHZidm9tUXVjcE1Tb3V6L0NaczlSZ2NSVm9pZ00rMWNuamZzb0ZP?=
 =?utf-8?B?ZmVxYlVxNzNGeTdQQ0d5c2FuT0hac2hMNzA4UTJSUGJCNy81UmExU0szZ1pJ?=
 =?utf-8?B?M0xCOHp0cHh3ZmRORUQxb0dKQWRXYzlGM3IrdUtvajFjTFYyUjdQL1l6QU1T?=
 =?utf-8?B?MTZ4NkxIWHRCb0FDRkVVT0xNdlVzT1g5TlNxdzQxTWJKUVdLblIvZk1FKzh6?=
 =?utf-8?B?NEhGMUxVbWJMZzZVQy9qZHVGLzhVT1hRREQxYVdDYU1NOUhJbXQyV0JYK3Zs?=
 =?utf-8?B?dk9uejh4WGQwemVlY2cxeHRLQUYvT1lCeVlReUdYZFd6VFZGcnBKYVhJOTZM?=
 =?utf-8?B?V25xQXhtSkhPSkY3ZWl6MGM0R2h2MW00N2RFQTVrME9idUZPVzMyVWF3eTVl?=
 =?utf-8?B?dllBYU14aW81T1o2Z2s5bmZVZ1NPSThDZ1cwRUNJSFp3Y05aK0J4d3ZEZ0l1?=
 =?utf-8?B?RUNFaENFc2dQbU5hbnBLTDFHNHRzaThnTEExZXh6VjdZSGZBazZTMEMxY1dU?=
 =?utf-8?B?Z0s2dEI0NE9KVURPSjhnQjVMSzBrV0kvZzBOc3N1Mkl3cVNCZTNNdVhLd2FM?=
 =?utf-8?B?MlZvQnJBLzB5SFVWZlJhWTVaU09pWThiZ2Q3dGM0RUYvSlRIY3VjbzVwMDNs?=
 =?utf-8?B?eEU1a0RQLzVvdjN2RE81SmNyRHRGY1N4K1R1RmhRc09OdmdSd2tMa2dKMEsv?=
 =?utf-8?B?RHRQZUdxMnFaNGFMUjhqbEhiYm1QSTRhbnNDcjBTL256aHFHa1dMOTdaT3No?=
 =?utf-8?B?R01GZkwzQmpBY0RIaU1pbk1oQzlnM1BZRkpydW95dlJXa3pWMlhhVC9xYXVm?=
 =?utf-8?B?ZGhoTndCL1AxbkRVdTUwNktTVXh0ODZMVkJweXh4SFlYTEFhay90VGlFVitG?=
 =?utf-8?Q?jelJnsO+GmH0LYJ6snomdXI6b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a068637d-7944-46dd-94d6-08de25261037
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:37:34.7454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCW/fTprxy+GyfgIHFnmDaVz/8A1zaDVmO8TZOneKVbBaQs/9vUHSDAdhfZQflM0VScD4rrYTU9MYFZiwF42Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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


On 13/11/2025 9:17 AM, Gregory Etelson wrote:
> The metadata flow item did not check for cross GVMI support.
> 
> Fixes: a78425ba3793 ("net/mlx5: support flow metadata exchange between E-Switch and VM")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

