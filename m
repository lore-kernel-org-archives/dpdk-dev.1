Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16822C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E3242E50;
	Wed,  4 Jun 2025 17:02:19 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by mails.dpdk.org (Postfix) with ESMTP id F41C0402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:02:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiPkeuB///6Qz/kcVeJnWLbXGO73PkZDDy12um1TngM7cqUE9cdxtyS9box/YlXsnGc/qBEGbn7OqWoJpnjGlkOczYdosr41PvjSesmGBJm07LMBalOoLzRz8hubFXvNZD+I0uIK/r+K9QcP9a8W7WcmJxNvjiDlfUg4HUWJJ7M9aOXZdzFjBn3T/WtS/klptzHtnWLqXGIyMb2WgGgkKDecLimdztVUjG0qK8CjlQMvs3/0H2tQaPy/J8TcacESsMUGK6I44UYGHJf+hFcq1c+PilbsdHg+vbkyO+9oUzsZ9uDOyD/Dv/PSLo7V4NciDYhlxFTimb59czbS8Vt0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ+5KOVhqLbPG+2KDTdsGoeYQJv1pi/BgMAVsliqsvg=;
 b=VobaEjrdKl06hahkbLFE/u8lailmZZWAu7Ppt/LNcJbM0cZbIlIgv8JxNQIzZUZXQCtYHwgA8Eu7N5BPZamI8pVaa26ZGbDz4UgBz28H/kfAVn+pRsNzTIsReIv3sa6P16uNHVX64DwlpHiy/jFnVihHJ3aCuR8drEljR84Wz6GJlLDOkbSxqWeg3XrbzYj/T3Mm9MjsDyhP2pwmO2vfimxZ65WUYchkWFK1Wsn6yIy5o0nn9R+QVPKxxI7v1dHNzEr6uLk62Tn+58hlc7CEU2UYm0h5t7YNfLmGDZemjSw7ExZ+bfU6zZjq3kDh/ejOa6Es8QowucLy8PmUDtHOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ+5KOVhqLbPG+2KDTdsGoeYQJv1pi/BgMAVsliqsvg=;
 b=Sl4sA1nmrQ0JuzvwDdQgVEnda865b3XXw1fmXt574Bie39zbfgn+K6Qp2thEdY5PpcW3l2wMUF4S7qswC+wZKbvUNqCyhCkPj9UhvXF6jrMirqizd/WkycH7tSx0XMO+uKotGzbvwowVizVmG2wL5BiLxRdo6AI50lwX0bs2ttQj3etaUMmXGCCA5j3PiUou8nKz0j4SLreu8YdlWwOHNydqWGzBhi5BAc5ha95fvIut/3X1UIQkKhQynR1a9dXxALPasZ+cBkRRgGA0UBUJagqkx2+7oTC8WiC4/Xz5T1+djeB45uTgYjhKWVRkgrJ+77e1Bx9pg+0ItA8IsWgQFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 15:02:12 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:02:11 +0000
Message-ID: <31279308-bbc2-4ea3-b47d-6643642acc84@nvidia.com>
Date: Wed, 4 Jun 2025 18:02:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/mlx5: avoid warning about operation mixing
 different enum types
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d61e877-2edb-46ed-aaea-08dda378c8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjhML3hkR2FUck82c2twMTl2R2R3a0s4TkNmaW5aZ0s5Rm54N2tlNmNaUVVQ?=
 =?utf-8?B?dG9rT2lERFFKTEkxdkFmbUxVYWtvdGwraDBvRHh6RGR4L2VmNGR0clNJY2xt?=
 =?utf-8?B?L3F1SzZNQjhQeVd2NVFzY1UzMXFCR2pOQ200Q3NsbjhUb0Jnbmt4MnNzQWk0?=
 =?utf-8?B?WjQwNSsySVRUTFUxcTdPZktqTjBjU2RRcjFGVi8vWTdJMVpDYlp1Q1BPV0xs?=
 =?utf-8?B?RFhlck1BMU1DODVCcXFhZTBZVHR4clZLa3pEaGwwZUJpTnZNWThlam1GMWwv?=
 =?utf-8?B?UzZoUzJjQytJV3VUR2Z5eXRMY3djRVh4M2lxNnE0dW16cTloWTQ2a2V5cVBk?=
 =?utf-8?B?Qm1JOUY2T0FrQ3FoUzhVYUlHejhRNHhmMjEzTGROZjEwcFB4ZmgrWGZFMXFo?=
 =?utf-8?B?dERxS3JTclZGcnk5cW1OdElzWjRNUFduYi85VXpHOENBQWx6eTc3cTNlRUpQ?=
 =?utf-8?B?aEwvRER6bXRHTVdUOUlqZ2YwRng1ekVEbmcyUzZLUk9Kck5DcktRSkdkNEZs?=
 =?utf-8?B?cjNhUlJkK2FxU3JrSG1CbVRnNXFibnhJelBSUkp4ckZ5bHlHSWJXcC9hM0dH?=
 =?utf-8?B?ZzRkcVlvN1JLeDFlYlZMNlhYNGFQWXZXSld5U2RUdFFiN2FqWmlmekV0bEpW?=
 =?utf-8?B?cmxSa1UrbVQwSHJnTXBpbVBldU9OMXFjaUs4ZVdubDRyTmNVVlV4cnh2V1k0?=
 =?utf-8?B?STM5MnE0SmZhV1B0OHJhSjBheCtOU25VZGpBQm9EY1hiRzA4MHQwWjhXYU1u?=
 =?utf-8?B?TFJNUUhOTjU5ZlJqbm9xMnA3QkYwV3BxRVBUWnZUcFl2Vk9VQjRqaTM3TlNk?=
 =?utf-8?B?eUt0Rk96MEd0clplSGtFbzhod05MU0VxTytxZk1SeW9HaWU1L2FOeHhUUVps?=
 =?utf-8?B?akdrWmo0U3ZVTXh1UFNySm9nSnhvQ0w4bjc5K0d4UG9zQnlnSmRqSUEzRTg5?=
 =?utf-8?B?UUJjaHFpT2t6azBEekxEYnNJdy85d3dhNWNqL1lHRm11UWdVYXN2NkxjVlJl?=
 =?utf-8?B?SFUwbWJ3NHZ0NjJ6cmJPYTRWd2YxT04wNTdSaGM0SEQ4ZWVhL1I3NzRCOTF3?=
 =?utf-8?B?OVVXM2FFUFA2SDBLSW9US0NsY0d1LzhNVmZKNWx5R0ZjTmZWbWJ0bStTZ0hq?=
 =?utf-8?B?ZW1iNVEycjZvcUgzdVVpelZIRzh4VlpyUjcyQUd2d0RLWkdjbHg4azUzdGU0?=
 =?utf-8?B?SGR5ZG8wNk9kSGgwYUlPNmFnMG5EdlNWRjlMSzVRdEdvSzIvWlEzcTMydkZM?=
 =?utf-8?B?TTZHZjVGTTN6VHRWT3YyWTM0MHNyMjB3MmcybkVwQVpyV0hld2VsQ3UwQ0Yv?=
 =?utf-8?B?VEhpNzhVV1RaeDFYcFR0L01IZ2ZIdG9OZUpCKzk5UjRqeTdKZzlMb2hGU3pE?=
 =?utf-8?B?UGVBbGl0ODAyQ2trR2QxZE5KSFlpdHRQL3BCZHNzNFVYejd1aTA5UEhKL3Z5?=
 =?utf-8?B?bFQvSzN1YzNSTnF4YjNCZHhna3Ixc3JyUVlQVGQ3czlCclJJNjlGbFlCTUNH?=
 =?utf-8?B?dk5pdWhZOWNRVXlQcWVWc2F4V0ZpZVhHN0FIM29NNVVlRFZydE5SdDBYc1hL?=
 =?utf-8?B?YjdpMUNMU1dGVzhaeTZ0WGNtK21HTWRRN0tKR21FaitLdjRpb25SVE9BZldh?=
 =?utf-8?B?bU9FT0MrdUFPM2lCUFlNelNTTFpnNWlhTGZqSm9ZMTU2NHd4R0t6TlhTcnZJ?=
 =?utf-8?B?RUFPQzR6OW1TOExHUUxpSE9UalFPZS9HUGpXVFE5eGlPdHNIR2Z0Zk53aGV2?=
 =?utf-8?B?bnhhbGl0cmIyODI4YnRRek1BSjFPZ2J0SExXcEpBcFZJYzJEVGFLRGRLbEF0?=
 =?utf-8?B?Smc5djhZSEtScE8xcU5LaXhsc3B0OFlsdXBveUJFS2ZodHNmazVndEdtaThh?=
 =?utf-8?B?OWpQVDJoWlZVNmxYM1I0Y0JaQkVZZDNpL3NlTTZsNENPRzdoWnpjM01URXRF?=
 =?utf-8?Q?xRZOjH9koXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlLMTM0VTFLVVpQeFNnWFBXcjNhQmZ4Zk03KzAzSWZHNEYvWDRLVWxUTklx?=
 =?utf-8?B?NjB6RVZwQm1rV29lWmh4bFVKY3ZtUnBlLzFVS3VLNUpDb3F2c3E5KzNZOVpK?=
 =?utf-8?B?dkpwNGFad01TUnhaU2dseWNpdFFkVk9oYmltQkQzYXZ1Ry92Mi9LU2hmY0dZ?=
 =?utf-8?B?WjJhNllsR3RJN2JMWk56ajVoRGt6NFBqZVdmWjIvTXlVY2IxMFZHSWx5Tmhx?=
 =?utf-8?B?aGUwVHRpWWpjellEaXh0TlJzLzV6MGNqdHUyTEZjUnpCT1BrZmxjYkk5T0c0?=
 =?utf-8?B?VXRwUkQwdHk1MEtqUzdCQkVQNjRsT1l5czZmaHVSMnc5VGNKaEM0aC9nVU1U?=
 =?utf-8?B?NlZTeC9OT0haMlpSWTY0MUtkYWZsZTZzYlZvQ3RFTUN2WVlib3NhUzlxMmhW?=
 =?utf-8?B?NEJ2bUUyQi9NMXFTZVQrSzZxaS8zVHc5Y2dqMlBISWE2dTVTcUtUZUJCZGZB?=
 =?utf-8?B?TUEwaGhJSFdCbEM2RDl3Z0JWWTFLc1NYa0FwanVGVnNkNU1Lay9ZSHlPaGFX?=
 =?utf-8?B?VjV5VGNjY1dUcmt0c3F4QlFSeWxvclM3em9VNVlYVHVjOU01ajdxdXI4Smg5?=
 =?utf-8?B?bSsvQkNnR1FxandIelpwQnR0V0xrZk8vTHZjekpsZ0lBZzB0NnlQYmM2aVIy?=
 =?utf-8?B?MGtlNXl4U2xIalJ4RzBhRnQ3dTNJbWZwR0RzS2lzeTZ0WkpvRFk3cVJXQm53?=
 =?utf-8?B?S0lQRWFhZkFFbG1aa2hXb1lUUkprVWFXTGdsMHZpYXR4RVRTK0lMQ2VJZDgx?=
 =?utf-8?B?TnNTQkZtSDdLZU9FdE5ZS1hldUJCQzZPTWFlaGZSbmVkSW9vbGR3S3d2VUxL?=
 =?utf-8?B?dTVSTE5yNW9RUWNmRFVraXZYS2xBZUdPYUUxMkpoZ0NldUNKcDh4ZmttSXFM?=
 =?utf-8?B?NWw2WFlNUm1aRS9YTjNCSW94aHlZVWxCdHlpZGlhRmNwWmo2clFrSUpuWHNQ?=
 =?utf-8?B?WS9iN2M2UTdwTjJNTmhwMnVsZlhUY2I4aGZkVmlkUDhHb3Zoc0E0YzZCNldv?=
 =?utf-8?B?bGh1MThUaE9LWld2NHRZb1JMZ29NYUZVTEorQ09BbU8zNm1xUjFpYlJ0c2FN?=
 =?utf-8?B?TWVFZEI4cEZkb3pYbDJjeWZlOXZ4Y2l4Rmc0bjNjMDRiaDRUd0s5WDZnSTFN?=
 =?utf-8?B?cWN5NndiUTcxR3NCeGRvdDBLVDk3RFFSbkJHRzNnVk5sUXhLcWo3OHpyZUox?=
 =?utf-8?B?SlR2RnhRTERSRnFOWjJiWUpjNWw3dHBmZklEYXVObVhndmhHNDR5N0NvNGx0?=
 =?utf-8?B?TGJmU05qd0hnY2UvMUh1WUNJRlZJM2U2V1N3bGxDZkZ4OXA0QkRUaXB2aXVD?=
 =?utf-8?B?QlpJUVpmelZUSjBSSFIySys4dy9iU2ZmYTZISGxpaE1CV2FCb2IrR2tyT1hF?=
 =?utf-8?B?M2U3Tm1tcEdSSmhSRDY5QUpmaERnQnJWKzY3RDh0N2loNHVqTDN6b2tsRWpL?=
 =?utf-8?B?a0h1TjhQUjkzRUZITEl4emRyZlpBRFFLWUF0bWNDci9BTFJ2bHRXU1VlakV6?=
 =?utf-8?B?dUl1a25nc3A1TFluZHltVnp1V2NEMVlqbmxJekREalBTMW9STTRGRHJRVFRm?=
 =?utf-8?B?SFMvNWNlMVptSlpha1J4bTVGcEhHMllLRXlzZTRJWEl0TmVRM0hYYUpDbmph?=
 =?utf-8?B?YzVjREduaThVbG5oM29YZkY5N2VibU9STEkyUzlUdzc3S2NzalM4U1lFNVBv?=
 =?utf-8?B?Z2ZscDhrVFBQWFhrZzdIMDM3RFk4d090alJpeFBEdGxYbWY4QTNYcmlibzA1?=
 =?utf-8?B?QzJLYnIvT2hJMVA3aTNtTWJoQnFUTjZ4TXNLRmxqQXhSOVUxOUl4Wm55Nkw1?=
 =?utf-8?B?Tmk5aXFHTGVUOGJma3ozRnF3TzFHc1hkejJoNDZzYnVUK0VJUU5mTXZ5dm5E?=
 =?utf-8?B?ZnhPODJ0THpPbmgwTGd4ejJDMHJoc1U0TC9WYzVHbUtMYitFUVFURnV6WWI0?=
 =?utf-8?B?d2M3Ly9VOFl0ckpPclJnNTN3V1BQQWl5cUdwMkh2V0oyQVNmM2NYUzl3NWQ0?=
 =?utf-8?B?bk9LMGRMUXVYZ3Q0RGREcHFPVzczUW04T0FrWDB0S2MrUzZaa0t5NHJaUm9X?=
 =?utf-8?B?M0xzbVI1bGlTVlJEMkErSXlLQ2F4Sm1yeVhaWS9DdkJOZEVWKzR1Q1JoVTF1?=
 =?utf-8?Q?EhdB6aKbq6RHe6+eVJ+c0ozG1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d61e877-2edb-46ed-aaea-08dda378c8aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:02:11.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/ER5Qa5KPwlVhWX5BeUjG/cdZefNpinEE7XdhOVplNFQo1kImWaoU9zagjcsNCpgBY/fUN1iB6PNfBfIisyvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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


On 28/05/2025 2:41 AM, Andre Muezerie wrote:
> When compiling with MSVC, warnings like the one below pop up:
> 
> ../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
>      are different enum types
>      '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
>      '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
>      to silence this warning
> 
> The values in both enums indicate that this sort of mixed bit
> manipulation is intentional, so this patch just uses an explicit
> cast to avoid the warning.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

