Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E731CECD983
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 16:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9080410DC;
	Thu,  5 Feb 2026 17:06:32 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by mails.dpdk.org (Postfix) with ESMTP id 7FDFF410D5
 for <dev@dpdk.org>; Thu,  5 Feb 2026 17:06:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJIKRsOe45B5zTzYM31sRVlmV49O3Mh39crS0aFmAmjkhnZrkq+rzk8yw3VfQWVz1FLU+1850b8HsROIQnVbdW1qFb6mVJ/UVHnyQTVclwN+dapTdeBxGwL0G4lIgwauZ0xIQ/jb+m4Rmj7OJptV7tW+5xAssuDJUAaoY1DbrhaS5mdfNbc7jSI9Kr5tSipnx+GEqZmFZUXapEDk+027XPOGzVfB62o1H5qHerp9IAf2jhmT/2/MYUu5SxDRuhzjZYs09W6mqyvQHUIbbTnhU6rVkT9VQX+4V063BwWTrLVUOlEULApSTfpAf6tDNMxesgZ/g8EQLTHflQ4GcHIuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eCvz3ianEjv+jzjI4xuBuygfbGbTmDQGJSMB6BvKCM=;
 b=hdhXnUoU/xUaOCMXGT+MWRzN0qev6d+SIeEWRyJ/tHL5yBGEECWS4aXR6kR47rXQFd0/CptSm/I0xYkGyNm0y7ouEuHq4gDkgs2Sehddp5l5j7L611E2BQOpHe+y80xkqJEBS85t/UvLidJUglnTDaZ/Njd6VUpXo3atronRSrsFhRuUOwk/nhxYA4h8Wkq0yFQxy+E6wjLpIlHdcrpsQpKHzmHL9/wLqc4wilsLoE6Iisw6zX2etnypELC9wv1mo6uEFp14tysngX7ssKyBIWZ6e6m/tY4ZccYHp9IILu9RJ1m3bCoP3zoGI9utWev6D2QDVm4O7L/69V4xd9Ev5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eCvz3ianEjv+jzjI4xuBuygfbGbTmDQGJSMB6BvKCM=;
 b=eMaePiSXw7oivW2hmWz9jZQAyDbZhj6SW8cbQz5CfJgZuum9vS4/oJng2N9zoc5MawEqppHgFndpPl1GT7mYqKJR876R/mvURGkPgJORuUAB0qYZ3BntN9JRQldb/5XNsMlhHQKKJ21ZJZZE4hRiwBbxQGpL7TBbOY7cxY1J8x4CpEbRxNz08O/G3TSOtJeP+ZP4doA7lhVgALqy+3GfvojPK1fZV3oayZ0GofTePOUzJL9lIxBnoG0acW4Hx+8eY4p8qg2eQsMDpOREBrRWK5jhsktcvCbRE2g4j9ie7FdIpV9ahgwyXi+oKmpslQQippH6DeZixqLWl+sCrht0fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 16:06:25 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:06:25 +0000
Message-ID: <32549b6d-89d0-4754-ab0e-8cb271afa676@nvidia.com>
Date: Thu, 5 Feb 2026 18:06:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net/mlx5: future HW devargs defaults and fixes
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
References: <20260112092439.14843-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: aacbc1f9-3b33-433c-8d09-08de64d0834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VStsL2oyVWRBQTFVNFl1eCt2K1FLSUs4dExIL3dwQkNVWlc1N1RiT242eUhj?=
 =?utf-8?B?QjdsejJ4cWp5WUVrUlNKOUpYcklycjVvU0Z0cTZTSUYvbWVGNHF3VDhvclF6?=
 =?utf-8?B?TVhCeWVKdnhYUHY5UGo4S3dCM2dwYkp4ZmVVM1lURDk5S2cyelpHWGk0LzRr?=
 =?utf-8?B?T3padzV3Uk4xZzNUbmRHbHI5SDBBT29UcENsbjZ3ZEc3TWJUR3BYMFFhRkRP?=
 =?utf-8?B?VTBRL0huS0YxQndTUDB6QmVlekUrdk5ZOWppSXUvWm40Z243c294RThVL3hP?=
 =?utf-8?B?QmFZbkxaNnNCR0FXR1ZMVC8xamJJKzlQbnFPeENFMXpZNkxGbEtOZm9jcGpV?=
 =?utf-8?B?eGc2c0c4STQ0MXFFLzg2ajRjQXYrNGZJUUphNUsvaU1NMXVqOHFqc3RoRUE4?=
 =?utf-8?B?VVpFb0Q3ZTF0T1JyTW81YkVwY3Mxd0V0QnZsWmpGZFlPd243cFYrTW9Id0Vu?=
 =?utf-8?B?VUVVcGRYUXVSZ3ZieWxlVVozaEtwOE5qeTgrOGhPVitObXZNc1B3N05ab1d2?=
 =?utf-8?B?OGR3WlpZVTR0TjRjUW1kNHoyaFJtWk94SUNQOFUyU0RQYkNKVHVMcDdwcmsx?=
 =?utf-8?B?dzM2NWRSV1FaZTF0a2kzODBKQ3JoSGQ1T0xMb2VidTc0S0prSXV3NGhBSjVD?=
 =?utf-8?B?VVQzNGRMczRnY1RBdkNmblhXMEtvaG5lTVVvaHBRUy9NOG9mdGJCUmtkUFZv?=
 =?utf-8?B?a1drV3ZEaTJ5WWdxVm5IZDE3dHZNVlgrQ0VxTWtVd0U2MGVyY3hxVFM3cnFx?=
 =?utf-8?B?dG1pbkJZbmJNVU1raHA3bFVVTEEzSklUaHg2bmFWT1l5ZHM4RVV3SjFCelJJ?=
 =?utf-8?B?dHpSLzdWMGRWbVZUT09mbHpmTE5hZ29wUTd5cHdzZVJ2ZmFUdlBhaFIreno3?=
 =?utf-8?B?VkJDYTZZQ1Z3NjNxbEpnQ2x2UkI3YW9OUVk4dFkvdEZvcXlDS08vU2oxOWZM?=
 =?utf-8?B?eG5jMHVoNC9WQ3FDVjdncUswWFgzd1JwZlVPVENzTms5NGppR205cnRxcnl3?=
 =?utf-8?B?VWVYWlJQN2FlZVlCQVNLMFgxT0pXYXRVUi90QWZpakZOVnE0dHJ6MTRXcncv?=
 =?utf-8?B?enVyTllBdXM0R0hVZkVhbVZ2VUZVYWZTVU1ia0RJaE02ckdMWjBYMW9Dd2hu?=
 =?utf-8?B?OGdhYTF1a0pQKy8yeWR2b1pQMisxUXNrQzVndXNvOUErbVRCYytxZUNDM1E0?=
 =?utf-8?B?bzhoTkYrcFIxVnBEQ1RUQ3NCUkRsbGVqS2JZQW9mMndpbGw2TW9wOEtISyta?=
 =?utf-8?B?VGQxWmEvQWZNNS93dWRpblpFVHdkOE95REFId3VQcFFGdnlaZldiQm5SRnMw?=
 =?utf-8?B?TEJocDlrUDMzMVpLbUJKKzR2SVczQitiTjFWYytLYkdzK3dlbWw2MVRqaXNz?=
 =?utf-8?B?WVhmc2RqWVFzVnRneWx0d2hSWjQ4U1JPMGVUZHVXc0hlTXZva21icUZaaW9x?=
 =?utf-8?B?dlJNSDhYRDhIYVdLOVA1SGpuVmNhYnJITmwrdWM1ZkRVejZXTWdQQjQxTjc3?=
 =?utf-8?B?YkFZVFF5ZTIyVkdnRmhSMkFIN2lzS25rMlJzSFU0WFAxaXFLdUQwbGZEbExM?=
 =?utf-8?B?K21FSGZUNmJ4eXZtREhiTnFCSmJjaE9tN1dwOXZzV1ZwOWh3d2c1Y0RMb1N5?=
 =?utf-8?B?em1rakVXSFl2dHR3RUF5clFjWU1HclZrZTQydm1ZM1Vpdnc3SVFabGlsaTd3?=
 =?utf-8?B?WWxCSUFPendBRld4RFRLWDNZWmt4d3VFdjYyVnlUbGdXeVIvTWYvR3dYbjBC?=
 =?utf-8?B?ZloveGc2UHZEdVhyOTZHR1lyUHNCeWZaTUpyalJmQU8wTVk1ZnY4dGhWYXg0?=
 =?utf-8?B?UjB2Q0wyUjdnNHlzaW92Q280Q1JvdEwyMlRsQXN0d1QxOXU5UjZmTUR1Y1dp?=
 =?utf-8?B?anhnQllQRi83SC93R2hCVWlLTGdpODJicWdKSm1FazZvVHc1MGhQenhxRklT?=
 =?utf-8?B?UGtqS2JYcWNVNFFlcGs4OTEyRG5ZSlJpQmoxbERuQlArSWR1Y2pKU05Yd09i?=
 =?utf-8?B?R2hDakxCWGJXY2YxR2JnMlpvaGUzY25SUHloRSs1eU1kWGREY0h5aEl4M05G?=
 =?utf-8?B?ZHlyOE53OStGNnRqUHo0TVlKejdJRnJpZVhUWDErUWR2czFIVG1ETitwQloz?=
 =?utf-8?Q?8OG8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1MreG5Ma0pzL0J0bFgvTFNWakpyN3dNWENDOFZSNVhRNzhHaUZ1bDVuU3dT?=
 =?utf-8?B?L0ZXMnQ5eXdqZUVkWnlQOFRnYnFwWUhjdXlkM3Y4RlFMSjZzMlExOW9lZjNX?=
 =?utf-8?B?R1A2d2RZUW5JWDMrNkFrZUJvWVlmQWJ6U1pSM09VelBBR1hObjd0UUFOMEVw?=
 =?utf-8?B?QjJoNFRDczlCcGQ3eXlsNDZWTDZxSXcyUjJKSkIwM3h1OVM3U1V1MFdza3Bs?=
 =?utf-8?B?c1JFQkNCYlJWVE85UHpzaC9sN1haOW9XalM0UlQ0OU4xVHVoRjJ3WnZPMmVY?=
 =?utf-8?B?akFRRXZOcXNSMVFZVHlzekRtK0V5dFhScVZXTXhWSGRJa0hreVA2WTI2YlhV?=
 =?utf-8?B?QzhRYTVtNHI3QmlEYTBENnpiRDI3eE9mQ0RVMkppalJyNjlPaVdTdlhtbzZR?=
 =?utf-8?B?SE1QYlVyOTE0ZW9GaUs5Ti9WYWJMaDFJVDI0WUxYOC9wNjAvb2E3cEJuaHo2?=
 =?utf-8?B?b2gvdkJsNm9zQUFSN1Fxd0lRWWZ1NDdKaWtsUHI0ZGpEa2c1WnJld2dsM282?=
 =?utf-8?B?RU4vcldIdUQrWFNUNkZJVWYvZUg5UnRseWpLc2pvMCtYYmZnTnEzOGo4SnNH?=
 =?utf-8?B?MndidVByR3VOeERMdmN2cHNSYUlDa0NUc2lycVZQa0tlbVJmNkhsNlNoMzk3?=
 =?utf-8?B?ZWE3Mkc3NHJTZTRsdUZmQnpBUVpVdVhobVJLRDZmcldkQ2NxSU5MV1F3Ukl4?=
 =?utf-8?B?QWNYNSswSVpCaEpNMFFXQ1QyVlpuZ0podHFneHNySzNOdEJib1JjZ3V0aENM?=
 =?utf-8?B?dWNzbWQyQ1ZtUGZGaW9mSlA4aEoxK21ENzc3RUxFbUZtRm1rTk9VWGF0K0lw?=
 =?utf-8?B?U1R2eFJuaktjTGRibTF5SDdwR3U2MEtWM0E5cFNIWTZYeXNNYkZMbVJ1VjN3?=
 =?utf-8?B?K2xyRUpCTFQxaXVnc3pMMWplRytIZ2x5dEpscHBmaXZjcGd1TjF6QXdMUTJk?=
 =?utf-8?B?RnhvdGt1RlRQSTJUUGZxUVNBMkZ3VVhXVDQ1UDRFdXpMVGtXREp6M3pCNFdt?=
 =?utf-8?B?UWxZMnQxYXkrMDNJczJoQkxxakhxYTBEbkJ3bmhnS2RPdkNZOThWeDA3NC9L?=
 =?utf-8?B?cWQyUkdwZGdza2RhWDZyYWtGRFVBTU13Zk1sdnQ3MXNzYXNWWEI5cW9MaVhn?=
 =?utf-8?B?UFZSZTI3ajdTeks2SkpnWHQwd0xRQmg0ZGpNZlEvVDhjeVpXOGFOTHUwSVla?=
 =?utf-8?B?WkpQU3Z5QXdOL2p4dUlRYWRuYXVhQ0hkb1Y0bFVYaHluMEhnRkwweGd2YXRG?=
 =?utf-8?B?VGloN1pzb3dkY21QT2U1UE1FaWdjK2J2djB0K1BteDRvcjd0YzgwMU1OYjBz?=
 =?utf-8?B?U21tcEdLTU1WdUFmOUtyemIwZSs0NDJ3ZGluOE8zTGxXWWJwR041WEsvSzVk?=
 =?utf-8?B?ak1LazFYU3ZoUmFIbEdOU0c1T3VSNFNKYWZaUGcya0J3TTdMcnZDOExtZ0ZN?=
 =?utf-8?B?M0RqSHlBVW50VVBSU1RxNUNwM2hHTis2aS9hMVJaaEMwM3h3TERHemZrL1Nh?=
 =?utf-8?B?VmFncDNmNC8wdGtJdjZkbDlwcTFLWC9qK0VxcnozMWl6dkdtcFhpTHA5aW9i?=
 =?utf-8?B?RjBCWHBFbm5ZcEhSVzEvc1I2Tk5uM2lndHFRTnRhajlrRU9GN01xZW9qWHNk?=
 =?utf-8?B?YjlXS0VmOExaQ0ZOMWNSUzZtUjhSazdhNTFuVmVhMVVUNmY3TkZMMGVZYVh5?=
 =?utf-8?B?NVZpV00vV1BuSTRJdm83UENhNi8zdnJKN3YyK256bUlGUnhoamlsWGttY042?=
 =?utf-8?B?UktVQ3BzWFo0WFFPNCtTelBHM2s5bWFBdWYrRWp4d3ZETDhsbjEzQTlGRmFh?=
 =?utf-8?B?T0ZzWEk4TlkvR0RLZGFtT0N5TnVWQ1dZT3dPeENYQjB0RlNyUFFuc2hoZTY3?=
 =?utf-8?B?dVp5U2ZURUJLSFk4M0s3YkF4dDBGdVR4Z1hvU0xPMS96RmRFMEduejdLTVdr?=
 =?utf-8?B?elNWQitCM1h0M2RpWGt4OFpvNkxmTTlIN0RuVHRsMm9rUllZbnI1WXFoQVRK?=
 =?utf-8?B?dmw4L0JBMGhZU2dlVzd2azNFVk1LamJHY2pHVWwxb3NIVUJiTHBnNmdQcktm?=
 =?utf-8?B?MEJldHJKdVlZRnExTXdCbmo3c1JqVFNCSytBVENyK3Nzc3NxelJ5R01QRUFW?=
 =?utf-8?B?ZnF6NFlwM2EvQi9RdUIwSExpNzEvMjFOR2Z2ZEFLdWJ6ZENEOXRabWQwaGla?=
 =?utf-8?B?OHAxSHBiTVRadFBzNEJUR01yVEQxNnJEaHZEOVVYeGJ6cHdhZXlqaDN2Y2Vw?=
 =?utf-8?B?YVFuc3lXQzZ4NVQrVUdHSEZ0d0lsZjUxeWd3WFltbDVSaU8yUTAzQmQ2TVZK?=
 =?utf-8?B?SVhZb1lyYW93ZWUrZXJyNGlPeHhBbXRHRnJ0SS93SHY3UjJsbUZidz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacbc1f9-3b33-433c-8d09-08de64d0834c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:06:25.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E3HxV3d3fF5rq1sC2OtGO1helLZMPUxk3W3Z3Kd/Gg/5D1UTAx63y8tn3gdIWpBzMYj8UTyhZkNpNdYxmV7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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

On 12/01/2026 11:24 AM, Maayan Kashani wrote:
> This patch series contains bug fixes for the mlx5 PMD, primarily
> addressing issues with Hardware Steering (HWS) and flow devarg handling.
> 
> Summary of changes:
> 
> 1. drivers: fix flow devarg handling for future HW
>     Addresses SWS (Software Steering) deprecation on future hardware
>     generations (e.g., ConnectX-9). Updates default behavior for
>     dv_flow_en and allow_duplicate_pattern devargs based on device
>     capabilities, with proper error handling and user feedback.
> 
> 2. net/mlx5: fix default memzone requirements in HWS
>     Fixes memzone exhaustion when probing setups with ~1K SFs. The
>     default HWS sync flow API configuration was allocating unnecessary
>     rings (flow_transfer_pending/completed) that are only used with
>     async flow API. This patch removes the unnecessary allocations to
>     stay within memzone limits.
> 
> 3. net/mlx5: fix internal HWS pattern template creation
>     Improves PMD initialization time by separating pattern templates
>     into internal and external categories. Internal templates (created
>     by PMD) skip expensive validations, while application-provided
>     templates remain fully validated.
> 
> 4. net/mlx5: fix redundant control rules in promiscuous mode
>     Removes redundant DMAC and multicast/broadcast control flow rules
>     when promiscuous mode is enabled, as the device already receives
>     all traffic in this mode.
> 
> All patches are targeted for stable backport.
> 
> Dariusz Sosnowski (1):
>    net/mlx5: fix default memzone requirements in HWS
> 
> Maayan Kashani (3):
>    drivers: fix flow devarg handling for future HW
>    net/mlx5: fix internal HWS pattern template creation
>    net/mlx5: fix redundant control rules in promiscuous mode
> 
>   doc/guides/nics/mlx5.rst             |  11 ++-
>   drivers/common/mlx5/mlx5_devx_cmds.c |  18 ++++
>   drivers/common/mlx5/mlx5_devx_cmds.h |   6 ++
>   drivers/common/mlx5/mlx5_prm.h       |  14 +++-
>   drivers/net/mlx5/mlx5.c              |  71 +++++++++++++++-
>   drivers/net/mlx5/mlx5_flow_hw.c      | 121 ++++++++++++++++++++-------
>   drivers/net/mlx5/mlx5_trigger.c      |  16 ++--
>   7 files changed, 214 insertions(+), 43 deletions(-)
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

