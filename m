Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A3C83F05
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Jul 2025 14:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 456A84025F;
	Sun,  6 Jul 2025 16:17:29 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by mails.dpdk.org (Postfix) with ESMTP id 1EB6A4021E
 for <dev@dpdk.org>; Sun,  6 Jul 2025 16:17:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz3S6BAh+68LkexxR3DMEDNfEuvt3zwthd0DIzUf5A40FlbKmqN1o0lvLfpAANxOGvXSjw1IiMK8rPK8JndciRmtYiftjuMUT80FRI1AkUsnaw/S+NWYRjRGikkgruyZ1G60FAaYY7+i8ONVkC4p3Ut6hoyNi1gbLUHHDWSvzTyPhGoZbwwA8MBvnPhyl6HKo2wZkzaPxZVmUxWha9lJNl4Rz2DUewIPowYE3StRtM5PQM3M/1rdv4JZBlqn0XvZMWYpX1fAgQR69e/SYM1Ow6eSEFqScckiQ5xREHE1WLPGlr97mcyc/Lgb9GV5E4tAh52McTzOqDpOJuQCWXoU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x811ZAu/WOh+8IBZ167zPmwBIbjFGGWE/nrtcxTFSiQ=;
 b=sY3oLRnXBBwTa+L6HVAy9O+KOlMZdQp13w/AMVKL48/d8dMpJSpC8YsBImvjUJ/m4LqHpAvk1vBNW9BotEKwBvyaLFb++CQkiqIj4K1VXc9zs7eBQqAyFAw+P5vklkmTt1vcVq4+dRamWcgSit/NYXnBZIzd3ZhwVKqRn/5xT+UZ1f5B3Tj+zUSdLGvpTDtCAtISPfUqp87oELkv7ZJi57JjN4Xp8NRoJwnu4+lupVE8tUL5ioDCitt2YE3u7sARH5oXT+Ye6m9egwVD/ernSCz6mEqHdUZSuF1fCzaxEB+Q93eZdthb0bbqLZq5UpLQYEEQNFhYVm7WQQWhgUebFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x811ZAu/WOh+8IBZ167zPmwBIbjFGGWE/nrtcxTFSiQ=;
 b=p/yWtVu6GOWJ9hTXIpxgH/00v5rhSh8CoJq4vlnA1t8+acl0x41kQH7h7tIrrRrHyrnw8WtPvhp1BmPMHj1Jt635FzzAzgDxmjClT49vcbeCzIc88FZLAfXma+QrJpu4YvWogeKKQIcdmVc8/RYo+a2ZTZM1q/rwbZUl+8EYWmFwa5SybmVqrgORkIEJIRVqgFaET3yt+GOgUR7e0XINXjPW+kOKkayrELbjNX8mxOrXKUy//5ls/YNXsdYshWIz0pkJDvihoBCr+d3l8AuD9XNlClzALyEAWtmxTOQgVE7ZAoG/inTj2/oRWnfXsGgWEnmliRF3Fv+SgEa2aiC+VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 6 Jul
 2025 14:17:24 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8901.021; Sun, 6 Jul 2025
 14:17:24 +0000
Message-ID: <e5fb3ee0-5e42-46b8-96d6-5f094a620939@nvidia.com>
Date: Sun, 6 Jul 2025 17:17:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix decreasing the reference count of a Tx queue
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net
References: <20250703150252.145065-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250703150252.145065-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c9da31-49c9-457b-652d-08ddbc97d3da
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejVnSWhtZTJoc3BDWkV4aFR6SmJLYUNBR0RUWGlQSEpIT3ZyQUhBSVpQRjYy?=
 =?utf-8?B?THp2Z2hIeU16RFJmdXZFY1cwNkpoT085Ui9jZUNoOERCWHdSUzU4MHRneE04?=
 =?utf-8?B?YzBkeGRQV3pIU01ERFQwREVtazhPRHhyeTBma2cvTWxLR3BHVVFEdzFoNUZN?=
 =?utf-8?B?ZmdScEdHSDhKd3lnYzNmcit1dEpyS3N4SGtIUFNJUTcyZitzRkxHQ0hQVTRP?=
 =?utf-8?B?UlQ5UExCSFJQQ1lKK0VHbGlyRFB2by82UDh4ajgxaXFidklEOGtDNmxiN3da?=
 =?utf-8?B?TStaeUpYNHg0V3VmRmFOc3NHTHZqdEdsMm5IZmY2bGROc2lBdGhGWmJHeDFE?=
 =?utf-8?B?dEJxb096MERxbS80OUw4TDBuWHhBNmJNZ201NXpQd2NRZGNvS2pjSGpGSU1C?=
 =?utf-8?B?TkM1dDArbFNFcWZObFZmSkV0aE8yY0k4aEJMaFVReVB1Nm5UczNDVUlmbml4?=
 =?utf-8?B?VGJRSG02TjRLWUowbUR6eVZFUk41NW5IYkRIandhbWhGYlZ2T3RCZ1hJekhp?=
 =?utf-8?B?Zy83TCs5UzN3b2x1TkpvajQ3SVdqbW96RXVTQnZKOXFpanNiYWZrVmM2eWZu?=
 =?utf-8?B?NFZwZ2lRb0VQNDlyenBJdXo3aXcrQ091TXdLSVhOQnd6ektYSzk3bzZ3ak1N?=
 =?utf-8?B?UmlKd0J5UW5ESWNsenNUaXBxZkRLWUhpMWphaVV5bnZqV0dKS0xxT0lpRnpl?=
 =?utf-8?B?TzFldDFqRW50MWx2S2JRZDB3VGVVTGVpcUlHWjFjdjNUNHM3amZMZHY5SUE3?=
 =?utf-8?B?KzgvQjBuck5ZeTk3YlRubkpFNnQ3enpjQVkzUTR6NnI0WGJISjBaTWZtcy9u?=
 =?utf-8?B?TFdGaHB6VzYwcmYyY0xpZUxsNlkyMXg2K041d281bUN2MERpSEZGR01hSVZ3?=
 =?utf-8?B?V21HaXJzbXZ2YVY3bmwydUcxN3FMOS9xQ0dPOTJmWE9nUTVzZkU0OUhrMlhh?=
 =?utf-8?B?MzY3OXJWTnRDZStycy9rRzFiQ3ZZZGdUKzNXSTRURGZnamtnczdNNXNsN1Vp?=
 =?utf-8?B?YTRSWWIxMXJKaDhWL0VWaWJhSkE0Z1RDK3o3WHZPR3ZwbVh4OC9hMWZjTkxD?=
 =?utf-8?B?NmV3a3VyY21KZi9GcW95K0VwQitZRDM2ditZL1NUZTcrVHNpK0ZrUGRqVk52?=
 =?utf-8?B?QnhhajBjQVJwcWVCcDZoTzRrTVg4aDl3dmZRZDc3SmdqelNYdDl1VGRZdXhN?=
 =?utf-8?B?d0VVbzFzZnExTXVKdEt0WE5hZVR1V1F1ZTk3TXdqditVemNrWW82ajE2NE5M?=
 =?utf-8?B?Qk8rUll5YWJWcWZOYnhkK3F5TmNxREtVS0w2a2Y4anpWNVVmcFhNRnRlVzIw?=
 =?utf-8?B?Q2RWY1dSRkdxK0V0UUZUSVBrTEczYTluWUYxUE1pTGhhcXpkdG1JOWlOSEln?=
 =?utf-8?B?a3pKT3NCQUxndmNTdUYwaDdISnRHNW5wSXcrbnZGRTFzZnZtdTBpY0NxVmJS?=
 =?utf-8?B?QkdMSTZYOTRnRXBmVVZKNk5WYm1wRmJscEdtNWZsblR2SnQzUzJQaW5CZXBS?=
 =?utf-8?B?aXhkMUpNN0NRZjR0bVNLOHRhM05PTzBtWmlzVHBHdWJ5MXR0RW1Yd1J6TlNN?=
 =?utf-8?B?N3RtNzI5TXRDVUlHSDJqbVdIN2JoVllXcFJGeVc4TVhjMWRJMUgybmpZTklH?=
 =?utf-8?B?L3c0alRmaEorNWtXalRINWVKQlZ1NUoycDB2VllEa0hpS2J0aG9uS0dzRnRl?=
 =?utf-8?B?MVliSUxMSTNYUDNTMG9nVmlSbHNIc0ZmUGl0VDBPUFhnaHp0eHRPb3Mwbldw?=
 =?utf-8?B?RExvVHh3d3lkZ0xRbUU1eXJVVWFKTVorVEwyM29zS2hjVkpiK2pWRmlkZWk3?=
 =?utf-8?B?VkVETjJ3cGZVL0c5MXFUSG5JZkp4Y2ljTUh2Z3hDTHR0aG1xK3lEckNnMnlW?=
 =?utf-8?B?UFVWWkVIZHBYSFZ6NzcwYjhzMEFBcFJ6YW1mQmN0WWRraU1lTWNHSno1elpx?=
 =?utf-8?Q?NxGKazOn+9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZwRE5JME4rV3ZXMVdTZjg0MnZzd29XckM0enJIZjFPOFZYcXRPTTZSTHV1?=
 =?utf-8?B?ZnJvZzk4NmMyUkxpNTR6Q0lCRm85WCt0cXJ2ZTluS29mS0w3T1hBdnl4TXc5?=
 =?utf-8?B?anlPY0RySEJFSUluUUd0Z1UvTHVjeFpYYU43MmdXQVBraXRJSkxXQXg0cTkz?=
 =?utf-8?B?dFhIdGFaU3d2QVgzWDhUaFJ3b3lUTVRVY21SYUNOZFgzdGVWR2IyWHdvQlZV?=
 =?utf-8?B?OGZuWVoxM1Z5OEJrLzlObkRDNXl2clc4TW5EYjMvc0JyQWlteGN3anZQRDlw?=
 =?utf-8?B?c0xQOEdYd2I5NW40NFpZc1FucXRIaVVkTHBheUcyZHNRVnAwMjNhTUVDOHJH?=
 =?utf-8?B?MkFLV3dLSnp2V09FY2dIa0RTV3o4cis4K1lpaHZ4R3hQYUhnOWlKT3hESTE1?=
 =?utf-8?B?Tk5LSVBqcmIvQUdtNDhpcXJFYVZQM1NqdzY3YiszbVE0MmR5K2pBTnlkNGJF?=
 =?utf-8?B?c21hSFQwaEZlVElpdFlyZ0NrOS80eGRIM202UVU0eDE5ZXVlUmRDc0dXZWNa?=
 =?utf-8?B?WGYwM002OWRaSzY1MXhNSXpjRXNLbkFqVXFTTHNMV3ZHM1JNWVljSVZpNHhx?=
 =?utf-8?B?aTNqY2tTNWtaY3pINXBLaW02ZGRMZUlMd2NkVWtyZnJ1QVRyVVFBSkwvWTlK?=
 =?utf-8?B?Wks1VFZJbHA4NVpYalBjVzROdndUbXcyTFI3U1Rkc2xUVCsxNE1FNXEwSkhO?=
 =?utf-8?B?RmgvMzlWd0Z5RWs3REs5N1l4bWdTY29ISElVeTdwL2pmVzQyTTl2VUMyQ08z?=
 =?utf-8?B?aVZQOUc2cHZLNjRQQUd5WnA4eU5WVXdVQmhBa2p4UUo2YnZ4N3lPNHRuV3JZ?=
 =?utf-8?B?MlpFc1dZWkZlOHhOMWZqNExZc3lJTTlQenU2THlVTkFvU1RNMzR1eDdzRGVG?=
 =?utf-8?B?Y0tiMy9IZW5Id0pUWHQxelJrL3FUUlVoN29pWmRGZm8vd2plMXJXam4vdlBH?=
 =?utf-8?B?dlhHYXJ1ZmFNQUxyUktNNGFkcU01ZGRGcnpkN3BBRUR2UjFYK2lVT1ZYdzFV?=
 =?utf-8?B?ZlowbDBoMXMrZ0N3OFFZRmk5bE1jdnRJUlN6a3lNcHl0eGlMc1hlQkdFMUZk?=
 =?utf-8?B?YW1sYVRvTXZKQmZrYmpCSkhhMVJnTzhMd3ArUXJkbDhoSVl0WUUwOEJQK0s3?=
 =?utf-8?B?Z0R5TmlLaVRsMGVaVnN3RTZvWW5NbE5PSXZsT0RxOWxjUmx5bE1JVDVVemZM?=
 =?utf-8?B?SUFncXI3ekg0S0xGcEtLaDhmYnN1ZnU3eGlDMnFpcGFLcDBMUE1OVjkxaWgv?=
 =?utf-8?B?bmxzN0RtRkR3ZS9hSWtJYnFXYkdYRXRuZlZJbGlKUmlyZm9iaksxMTI4bnJt?=
 =?utf-8?B?Qjkyalc3U2JQNWNvT1BmNGxvcWtTbVlUYkNDbjFJSGJ5UXRvT1ExYVFBVkZr?=
 =?utf-8?B?Y1JZWXNGdE12Yk9PbHUyQlhGMzdVRkJVd0lkOE5FUm5jZmNkQTlhbTI1aUVY?=
 =?utf-8?B?RXJvMXhGbmVsTXdyR2RjNUNyUXhpclVxT1Y3MFpLY2k4ZnN6bkVPdWVVN1Vj?=
 =?utf-8?B?MzdDRnVYVnlhSkxqZEdybndpN0orSXdteXZpSXZ6Z1YwYTRncElGU09PQ3Zz?=
 =?utf-8?B?RC9ETCtqTXBoWmpyYU93d0FFZnBVV1R5RUJEL0lxR0NWcmdsTnMwY3pabWIy?=
 =?utf-8?B?ME5hcXcwcnZTekV2Qy9yMVNvM0tTbVBuZ2xZTlh4MmNtQjBpdFN3Skpxdnp3?=
 =?utf-8?B?ZTdJTnc0Zmc0a0NSODBBcTlGcndkRnFpb1lteUp1T3laN0FjOEhQZEtKYkNE?=
 =?utf-8?B?MEVtcnlpL05OTndBUjhUNkJ3ekkveHVhOHNWVVQ1WmNvWFlwSjlEbU4xK0xS?=
 =?utf-8?B?N0tReTBBZEhvK1J5Y1JCQkpuU29DbzJJNVBWWTRRamZXUHRpU2xHamVCNlk5?=
 =?utf-8?B?K2RUbHdmbVg2SUxWSGs4cUs1dHQrRDVpdm8wcCtkbXBlNnN6VTUyZkxnY1Mw?=
 =?utf-8?B?elpGYVBrdytKQWZoeDBzY0tJeHArWkJCOUp1cTRIL0p0T3hMckRDUDN5UVZn?=
 =?utf-8?B?UXNQY2NKNVJnb1RzbjhVSkI5UXF3SDZWTFlXM20yNEFyS25USS9wM0Eydm9W?=
 =?utf-8?B?ZjVXOE4wczJSS3NGc0pMb3p1M0dNOHIzU3R6NGxWM3o1OGhtSHZLbjZqWUdi?=
 =?utf-8?Q?/jT6clkjzK8YZl9Ps0ZMeSFes?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9da31-49c9-457b-652d-08ddbc97d3da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 14:17:23.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4p9+yg2nvY8N7Zk0D2jTld758/dRTRrFLnf5aT/eSSSCc8+XWdH60WUNKbEXboCLlaw/GJa3xDYy5pytkphoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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


On 03/07/2025 6:02 PM, Bing Zhao wrote:
> When changing the order of the Tx queues startup, the depth of the
> queue is compared. If not equal to the current big log2 value, next
> queue will be checked and the current one will be skipped for the
> next iteration.
> 
> The mlx5_txq_get() will increase the reference count number, and the
> size check no match is not an error and the startup will continue but
> not fall into the error roll-back label. The reference count should
> be decreased by 1 to dereference the count, or else in the device
> close stage, the queue cannot be released in the FW and the TIS, PD
> will be leaked as well.
> 
> By calling the mlx5_txq_release() before continue will recover the
> reference count to the initial state and solve the leak.
> 
> Fixes: 6f356d3840e6 ("net/mlx5: pass DevX object info in Tx queue start")
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

