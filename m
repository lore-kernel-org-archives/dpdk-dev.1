Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DCCA0FE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 14:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F9840263;
	Sun, 31 Aug 2025 16:51:37 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by mails.dpdk.org (Postfix) with ESMTP id AB6D14021E;
 Sun, 31 Aug 2025 16:51:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2kRf4UqWerO2SUzuhk+UZFO14U7/e6IoEJ0ze1x8RMiuT+ukEEPMjJ7KpiqmT4D3az5HeS/7/isqflRlbaH+xj9EpjtciaBxM7r+7Ldvapbx+8V2oykYuBmX2HD/y/xysvcyyPk9XVrJ09WYYUS7V06UU5uXmVOgFYUt5LES4P2naQnd5nqvQ7Oq3UiOk/BRBZh4/ofQSs8g0vFzp29AQREf23t7ZsSPWD5PHedBovG/CkuyKT92scEpsx1bwFeCoQzi92vbrehUYMGU1iDAuSELrtcyW6KcWeoxXL59Kn1W+OwEcjCXk9GX/ozhqYZPVzDz7RRNKGCq49idvJ9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaXZccfKE4ve9vLx/1BhALnoSiSpGjKIZcrnubyOoWc=;
 b=g9CpykR+uqYVjRp90KWH6365KdFhdR3zNeltkXvI3Cq7GTVCXLBbAPtb9iQix9tMeviLv3CgFAXVWIA5J2s1br39v8JxPJtOGeWdnlRFBOfuibT+azkNCW+O3I3v/J/ut8XksOEB4xGM3zYlxPG+VvQibAwW6DBpJjLkrhsAYkZNTkBhuNTk8o4iaiWkWECCc4g/Rm450HcbpjQfqbLCHWCTNu8VVgaLUqk8mAfEd2pTDKpVmOUuUasTiEULYU6HmNT9Mj/DpbfiyX3BH84/Gq9uUEWB7fvAki4ZLPsuYYpbu1nLqw1I5GgdkBwhqLBOyTbXtkjJVEGqPd4rZhteRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaXZccfKE4ve9vLx/1BhALnoSiSpGjKIZcrnubyOoWc=;
 b=t2bDe42DXGaaftAN9SdQy3ExT82hDfwxJbTCimB4iZWHT4leulq90iGOIzety3HrtWN0z5psJDIND5PO5rFnmJ76GBENkqeIUGQfkcSed30lWrEPe2gK4wx2/TTPPNjiRMAYkv8SrwsnBtDkadzuer4xX9d3pG3AA6yDtq/Z1Y3mEkiYS6Bf24Q8HCk2czhN+orPjQa1Nd9DDAmhfGxYvlrLSFD8mqPg9iAGfgRDqz4SXGlnC+mzUVuWuLKSI15tI2R15wffHBJHp75IERRnRtSbQyTG23iITCJ8hc/43EAhtLSmA5t8Qw6d40ySQOpc2DGN11fxsIclJGXDfLiDbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Sun, 31 Aug
 2025 14:51:19 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 14:51:19 +0000
Message-ID: <b0dc1675-3b79-4dc1-826f-667334b93537@nvidia.com>
Date: Sun, 31 Aug 2025 17:51:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix indirect age action handling
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <net/mlx5: fix indirect age action handling>
 <20250819112742.1068903-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250819112742.1068903-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f1d1dc-982b-4d1a-1ff8-08dde89dd811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUFTK3d3SmpZc0sydndGSzErN0ZZODAzQ3hDNDZRNmxkYWttRmNXaVppSUda?=
 =?utf-8?B?U1k4M3NXRDZEbkFYRmlmdk13bjhSdnZMejJISWJ2S0RiMEk1alRNYjVndTJy?=
 =?utf-8?B?dWYrTk5rOVJLcUxrVmxFNnVzd2dDdW84RGNZU3Nzd01tVHlUZmRaT29oanV6?=
 =?utf-8?B?UzZBUTBOc0hldkF1bWF6QzgzeTd2WTk3cDlaU1FQVmdNTjkzc2xTYmd6Wmo1?=
 =?utf-8?B?Y3kvSFNuZS9VbEM4MlY0RnZNdVB2blJnOGR3SjBPWGZuQ2RkbERMRkg1b0N0?=
 =?utf-8?B?dlhjVU4rM2J2V0pVdUdaZ3UrSjV6ZS9Qa3c4MVNWWGpFb1dLTzBMVk9GVmhy?=
 =?utf-8?B?SVdudzZlbFZDaEhnS0lIS01ERWpEN210UHlwR3hXWlI1LzJaS1NxR2pNRVps?=
 =?utf-8?B?NUpDZ1RxZUJYc2lraEZDVEtuQk5nMGI1QTNpRlh3d2FxWlZySldGdDNyVVdh?=
 =?utf-8?B?TFZPS25ybzNYamUvQjJKbWxpVU4vNmFVYnJWVEFITE5KL3lseG5SSTEzbGFp?=
 =?utf-8?B?R281OU04T0VwTkJ1M3R2RlhlQjNTd3ozeUZtN2JoT2ltWnp0NVNwTG10ZDBy?=
 =?utf-8?B?dlNLd24rSkl5L0xkQTFiQWxRaG5ZcGgwN1U5dUg0MmhTM1NqQUh6WEhJbmRq?=
 =?utf-8?B?SVEwWnEvRTBqSklqNjlZcnZUL2VWc1lvZzllNXJwTVFPdmdVOUhMSCtkc2tQ?=
 =?utf-8?B?V2xkQkJtd2NsdHk1MUQ1ZStSV3M5VUVFZFRaK1VtL3lKZ1h6NGZEQ0QyQnVL?=
 =?utf-8?B?S0hFRlEzOTVQM01zYW9iYitwUUxYZWV6WURONUhCZlhtSjB0WXRHdFJrWUlh?=
 =?utf-8?B?d3dtdzVHRlpyVWFWSzB5ZmxKSlAvdGFjd01sV2gzeEtjWGRaR3VkSHhjY3Zr?=
 =?utf-8?B?cEJGZFFyVmVBYWtQZGZtbG4wclB4ajBSL3paTEg0QXgveGRJV2lIYmJBOWM2?=
 =?utf-8?B?RXVuSkhvRUcxdHVtbjdsU3luOW5QU1pPSERvVmswSUEzeFUxWmZ3R0tTeEsz?=
 =?utf-8?B?bHRic2twWXNpbDhMVGNUcSsvYVdDV0l3Z3VOWHk5QzF1MVBqQ2N0NThSOHho?=
 =?utf-8?B?UUcycGRvU0l1T1lhTXpOYWNGZkxQSGNNRTlia2t6aWwwaGtxdHAwODR6UCt4?=
 =?utf-8?B?WGxWU1ZabFN5Y2J1a2RHdGY4REhpRFdDM3hIdkRTcVRDYkkzMTB3VWtYbUp2?=
 =?utf-8?B?VTBNYStoUVcreTFoZmxyY2kweW13clBsdjVhZi8wQ0d0Z2MzSkYrL1p1RmtL?=
 =?utf-8?B?WFNPaVNvLzRvbWF1TEhSZG9TREFEZG8vTkxUR1RnQTlJanZxakpSalVNWTBr?=
 =?utf-8?B?M21GUDRoeU1kMzViS0llTHVvVncrOWdOTE81QlZnOEZmTWFuZFVNemV4SEQz?=
 =?utf-8?B?dEY0T0JPazQzUDBqRkxzdUdGSHc4Sjl4ZFU0WDZYVTcrNHFOdkZ1Y1Uwbmhn?=
 =?utf-8?B?aTFHcDdvSnBtZmIwbENUUDBocWZ4MWx6WDJrS0FBc2w2Y2lWM04vT0dKcThU?=
 =?utf-8?B?MkRaNUJGdjhQek1RMklmMjY3ZkhTYXEyNlpxUW9YS2FwL0cwcGcxTUtPZjJa?=
 =?utf-8?B?dXBLSWRRSWk5bWhGK3QyUSthbFh0RUVVdTdDYTFkNURweEcxZEgvK3BtSXVL?=
 =?utf-8?B?aEltclN5YWZpdzc2WktmVFBETElNMVhsZVdFTmtiTnQ5U2M3SmdaN0NpVXZB?=
 =?utf-8?B?WG9zbkJYV3IwbzF6WkhtUEpieTlKTUhyc2FybzBNTm1HUnV3cG1kMjB2d09K?=
 =?utf-8?B?SXNSc3lueGNoRDNMekNidzUrSnNRRmhoQUV6RVVZcVlWL3dnUjVEdHptcWZF?=
 =?utf-8?B?ZUkrMzcxUUZySWFPc3V5aFVvZDZUWFM4bGNFWEJoTHcyYU9TMHNESTM2M2xu?=
 =?utf-8?B?Z0VVLzl6ZU84VElqWDNEUGdQNVJsMk5iZVNHbUQxMmNOTk0zbXVyaFZDNm15?=
 =?utf-8?Q?CQv3ySkKNyQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZRa2owUVRHSHRHb0xpWWpONWc0NWw4R3pJaEtxak9TVkdBcnhyemcvODF0?=
 =?utf-8?B?Z2FwZ1NjK1BCNzFxVWxrZ3RnblRRUUgzUHhxbUNyWU9qUjNQaWlHNDJ3NTdV?=
 =?utf-8?B?MXBpK1hEYjcyYXFGSHB4WnM1MldYWFFQQlBJaklQNm5YYmZta0FBbjBObGJk?=
 =?utf-8?B?aDNWQXhQaHFYUWpwT3hzOWJEeVRUVjlMdU5oTVl1N0xGY2YrSTN6eVE1MWFa?=
 =?utf-8?B?NzV2UFg4YXBjc2JYRnFNZVByRnRDdDFGRXFrQnovbENlU25xeC9jMlVoYXlP?=
 =?utf-8?B?QlhJRFZMQytuLzBVcnZPdEFRUFBOamEzNkxsYlJWMkVLZkw1c2orTlJMUkl1?=
 =?utf-8?B?TC9YYytPRWIxdVRmNkZTQm9LU1AycnAzQ2JtQ3pOZEpmNmpMVVkyL0F6UEY5?=
 =?utf-8?B?TTRPZU1ISGduV2V3WXdQSWlXMUZtdU03c1ZYUWRXeVB3UXBVVTluZTFzeTQy?=
 =?utf-8?B?WGc3N3pzQkx5TmRqVlVJZkpUZ0dQbVEwb3ZEbWVEM01QMG8vOE4xL3ozRVlQ?=
 =?utf-8?B?RjVkWmNpRlZXT3BDOFUzMDZaK1hCWk91R3ZnQ3gzaUdjT0VwZ0VPNnlSeklZ?=
 =?utf-8?B?T004cG9PVTdQQVpoeEhwWVFVMmVZcmduUU9BMUM2WnlMK21zTFhkc3MwbUpy?=
 =?utf-8?B?aXVpQzRGZjk5ZlFFbDNteXVHR1Z2bjRody9wWHozSkZDdmdpOWgrbU1uc0kv?=
 =?utf-8?B?M0FyVVNQVytQblF3VVhqUm1iRk5YeCtwQkxzVkN1eHZ3RmExcnNIMGpCTmcw?=
 =?utf-8?B?cU91Z3l1M2QzVGtUbjc0MnVZcVdzTk5iWmhrZEs2VkpMTUxQckxWOXd2TGd1?=
 =?utf-8?B?bDZSWmNCYVJyS1Rrajd6VndDV2w5TEVFV29kQytBNWd6dmpNcW10UjFYMVdr?=
 =?utf-8?B?c2gzdkJTYnlmQ2RkVW5KR3d1ZFRzRHVUWnlJWXpsTnR4cEZLNzZkSnN1dnRp?=
 =?utf-8?B?WkU3Ty9SSTBPY2lSZ2h2QVNEMnllcW1rVDRGRDBsbVhZejl6VUxXbUhVckl1?=
 =?utf-8?B?bEV6TngxVUlJUFd6N2t2YXNOMEVmbzBYeS9POTVsbFhKY0JRQVVWVFBzdi9K?=
 =?utf-8?B?ZDN6VDBEUGlzVlRjNFFQRDJZdVRuRUtsSnFiOTFIc2dreDkyUE1WamZXUS85?=
 =?utf-8?B?cWg0cnJqTjJSaXE3eFJFTUdNdVp6a0pEdHMybVdQNkdTd3J0VGZvd0owbCtH?=
 =?utf-8?B?a295WmNGMWdaTVpQZ0tGVVhhT3k3VUw0Q01ERUNuSy9WMHFNN1pmenR3WHJh?=
 =?utf-8?B?MDhESmtGb0NuTFVEVjh5Ni91WjFBbk10dnhDbnBubEZDZlc2TGhzYSs3V0xI?=
 =?utf-8?B?MGJRekRTVU93a2wwMXJCbXM1bjRRYXJ4YTBSUlNIK2FPY212RUJOc1kxY2Vz?=
 =?utf-8?B?RUVTOElFbG5JSUpiVzI3UDRDdEpPdWk3NGVhLzE3UjNrVlQvaDdxdG9PSFJz?=
 =?utf-8?B?NGd6WUJQY2pnSjI1NFBxdmhCai8zN3FESS9ITFhjbml3UHA2RmoraDhncmpB?=
 =?utf-8?B?L29VOEdFa2J3Y09rZ0thQ0xqdHNqdTNlL3k0Y2dDZDhzWm9TZlg3L2dXTndu?=
 =?utf-8?B?SlBBc3N3TXRxcHdTTUc0Qy9OMEpGdkFyRko3OWtYTzB1WThEbEs3TERqNnVl?=
 =?utf-8?B?TmFMQTNscEV5R2JPTzJqWEV1L3dkcTUvMU9TaTFkZm9XK3gwdVFXRlBZM0lI?=
 =?utf-8?B?VURpS0t5Q21KTzZZVE1Ba1k1S0dHTkZpZUY4c091OTB5L0lsTisrWGJxUFhX?=
 =?utf-8?B?c1l2aTlqREJvV1VzYkJsMSsvRzVISm5qaDg2YkhMM3IxKzlPc0NNUUwrcUdv?=
 =?utf-8?B?Y0FZUmNXZm5xUE45UmpkSlhLN2FZa2xOYVZtM2dVVFcxVU5rNHNkSDRTaTlr?=
 =?utf-8?B?RU9TRm8zS3NWOEV5Y2NCbFJoaUVzcERMQmM2b3NzTFE4YlExa2xZR2pUaEFV?=
 =?utf-8?B?UXlWR3F3VXZYVXFZQTZCODVRMFVGcE5nK2o1S0hvVVR1UWtIcTdwckZwUy9E?=
 =?utf-8?B?b1BrUkY3ejZEMnJZUnFVektHekVPcjIxd0lTM043WVMyUTVaUjdBRmF6dXN0?=
 =?utf-8?B?N2RPdFJXS2ZpYlN6OWI4UnYrZWZZRlppNDRabEhFSExRM0I2Q1FaNGVGQW80?=
 =?utf-8?Q?R1rBIFnZLx1nz6Xc+uPRmjySK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f1d1dc-982b-4d1a-1ff8-08dde89dd811
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 14:51:19.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVvzLMpSfyLyUDxpahWwdfIL1weBoogHsExI+6/6gMBqAe0863H59R0Wy8UT47MvFSKA0vO5PpBvzvhqeTpiiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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


On 19/08/2025 2:27 PM, Dariusz Sosnowski wrote:
> Indirect AGE flow actions can be created either through synchronous
> or asynchronous flow API.
> mlx5 PMD stores the queue used to create that action to support
> strict queueing. When action is created through synchronous API
> invalid queue index is stored instead.
> 
> Whenever a flow rule is created with indirect AGE and
> direct COUNT flow actions, PMD allocates a HW counter for ageing
> that flow rule during rule creation.
> During allocation of the counter a queue index is needed
> to select a proper counter pool cache.
> 
> In case when indirect AGE action created through synchronous API
> was used in that case, the associated queue index was used
> to select pool cache. Since queue index was invalid, PMD crashed.
> 
> Counter can be allocated using the index of currently used queue and
> it does not have to match the queue used to create AGE action.
> 
> This patch fixes the crash by using the index of currently used queue
> for counter allocation.
> 
> This patch also adds missing validation for synchronous
> and asynchronous AGE flow action creation:
> 
> - If strict queueing is disabled, only synchronous creation is allowed.
> - If strict queueing is enabled, only asynchronous creation is allowed.
> 
> PMD documentation is updated accordingly.
> 
> It also updates validation of synchronous query
> of aged flow rules in regards to strict queueing.
> When strict queueing is enabled, synchronous query is rejected.
> This aligns PMD behavior with API description.
> 
> Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
> Cc: michaelba@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Raslan Darawsheh <rasland@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

