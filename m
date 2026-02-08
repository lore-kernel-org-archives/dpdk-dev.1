Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16800EF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 13:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6FF9402C6;
	Sun,  8 Feb 2026 14:43:12 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3094028C;
 Sun,  8 Feb 2026 14:43:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A28/sDNByGFCswm3VYiYxqVYhpAfVr+zD2K6CKhodLx7fKzDWKOSUTDLJDYFIau4QX3iYAmEuEzlVZvLaD49s7g4bJz6TuZ3vIK8M5VrZLjSeS9KAillYVvMpPlSOb6ICaIQv+qHdSxXUvpR5kUqtMMUvX/xibflcmeYm60aK82zW28lq10VyFQnobKEwsWIMT/EagwByKGTpZwGGr2b1lfJHEly4YP0/eb4Ffpwp52+M7Jakqp07I9QgyXXEqFvn2gfYtyuJYN6aMpE3AE0WejWZaTgheY2WRDfzOrT2yzjEh9EeJijOBjDr36dSpoqBrO/EOcv9HvegsX8NhcuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g38BPSjl4Sa0qU01YXyalgxyj0b8XQ6tL2UPiGtGNY=;
 b=UcmJg+Wxye8HE7G2gYE7NKzcU+wfJvU6Ggc1hHGp33ANrTxLGwT4YXDQZ/QmIJqZ2q0GfHcMxCPKcLQruOE7IHbT47fD1j9+dU/X1ssNtI7A8QCN/wjtFYCYdHlnJ6dwC+gQd2FuYOZffAeUYVvPrjdbX1E3Dmnybh3ijltSGL8mtFoCYZ+uoH3fz40uMNPF3LVwNcygemFgVHKWSMR/5MLn5QBABL5zNikeJnBIVPaLg+BKbB1aG+yViAIUxWBtiLzhQi8yvOxtmw01DqHQnVZwUWZDqWenVOSLQ/qUtidUXf9JXK2B29cgqbptCbEA2aLJaVDbz2HCYw3jVuLrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g38BPSjl4Sa0qU01YXyalgxyj0b8XQ6tL2UPiGtGNY=;
 b=GPiwHZVtXoD/ped94LURR1v75W+mMk/vhw3uLneJvDJYVUZE8fLtc1ww91UrdT75X/k9cKxrL7OsDw0/IkCl3ruUM1ASjtpIIpJy+jTb7+EH7lXYzzQHSNgaRD/CR+9EGulqKXAhr3cT/KaNuwogyQnXBtLzRlGcPlnc5OTWSN5TdnK9QNXPlc9FRzx9fDJhTJJca6OdhXL/mshn3VZQHCNxDSZoqYJyu7FqBBlwN5ML4sBxxDNSW7uT3DrXBpzGJY8H8E37BO13qYJt+9kcIVueJCSM+gyaTOzNkbUla9pTR4vdxpmh2nmgnXf7Q4cpbgIU6dnLLnKzIElEzyGHmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:43:08 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:43:08 +0000
Message-ID: <287bfef9-1070-4261-adb3-152936f49aa1@nvidia.com>
Date: Sun, 8 Feb 2026 15:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix stack alignment for ASan compatibility
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
References: <20260121081447.224127-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260121081447.224127-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: a94053b8-7ecf-468a-71b4-08de6717fe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0VEUzB4elVtQm1VQmhTUk11cWhrRXNnNXBHdU16eHF0RWtOZEsvK3BUQzlM?=
 =?utf-8?B?UVRHTU1GNmREQmJFa1hmbUlPOUZGaDNOMjFZcFFQZEtsbHhGVmoyWm55cld5?=
 =?utf-8?B?N3FBcmVJUHFmcTdLSzBqSjluTlE3WUVaT1VCaVJyWGFzbmorUTBobi9HQkpU?=
 =?utf-8?B?T3pMc2tRbDQvYWJWeGpJR3NFUmpOT3RxRk5KY2VWQkxXMUJXc05xditwRm9F?=
 =?utf-8?B?cEJ0ZEtUdi9vbUxQekFuN3doMnhuWHdVSEJDQjYyUEo4MmVFUGwxc1FoZXZw?=
 =?utf-8?B?NTFhUVZkbGFHT2o0cHRRaG5MM1RYVjhtU1FTZ0FTM0JTbkRCQzUzVUhVVnlB?=
 =?utf-8?B?YTlDZ2tjbVV4Nk4wMVVZT0MvQWY1MGl6Q0dnMWRPWXRGSHI0cldBOFpxVFpu?=
 =?utf-8?B?eG1mVkFycHMyaENYMlVrVVlFRmhlUWFEdWhXS0h2UjZiR2dDUi84UzRDMExE?=
 =?utf-8?B?RTc4R0Z1ZWpnTFZZa1ZSakZlQlpCa05iWjBVTVlRT0ZmTFNPZi9EcFVsUXBO?=
 =?utf-8?B?bHNMVG5oUWkzRHpmK1Q2UTAxT1lJcUlsT3RVdnpnQ2RGV3VoemcybWczMXJ4?=
 =?utf-8?B?bGtZS3NhaGZLVG0wdzBzajhhVU5va3l2b3oyR08xUjQ2N2M4UkptUUFGQVhD?=
 =?utf-8?B?VjIrVm9FTzFPYVFzb3lZRUtGMDZua0hob1YxUzNQYThVUHRyWkVRa2YwdDUv?=
 =?utf-8?B?Ti91OWlDdWxTVWl1N1Q3ajBnSVBtaWtsUVBINVVzVXpmQXVwQkxhenF1amZX?=
 =?utf-8?B?Sy9OalhhVjJ4U2Z5ZEpxTmFvRkJFWEdMeFJsWGY2MWxWeFFuQW4rM3FtOG1R?=
 =?utf-8?B?WmtPb1BBWVBvMjBaR2tjUGYvSlZOZmZ5ZTdaNDloY2RwS3BVWCs2TmNRR3hz?=
 =?utf-8?B?eTgyTGxyVGxxTWM0em9ZM2VDMDdsd2xCYnZrWEVYMTl6YzRZSi9iSnVnQ0xp?=
 =?utf-8?B?M0RrczNXOE9NbFhaWWkySlJOcHRMZzNhZTc0Ty9JMkpZSWxTSFhJTnFUd3RB?=
 =?utf-8?B?Ym5mNXl5bjhaUEdkYVcxaGh5YkJmN2JxL01xRFlpN3BUSFh4Z2tlYkpla2Zq?=
 =?utf-8?B?VWdkclU4aXJyYncyayt0cWNsaWpQaEJ2dTFFcm5PUDRVeTh2bFMvV1B6ci9J?=
 =?utf-8?B?cXQyVHNXeFhHbkFhcXh5b2FHZ1poQS9CeEZ1UWtxaGpyVW5URzNRbDR6aGVL?=
 =?utf-8?B?ZEQ2OVlzbWZXSDQ4K3dqRThJVS9ieWgrTGRVbUg3eFpqR2cwdDZHdHdvSXNk?=
 =?utf-8?B?OTlBSXNYekJWNFQ0UWVMM213WHRQQ01HNnJvN29PWk01Z1FiOTQ5Y0NMUzRT?=
 =?utf-8?B?N05NWnBYSk5Yb2llQ2hVZEdXTGpaalN3QXdsQ3U3TXVwZ3I0L1Rub1RMamsx?=
 =?utf-8?B?c01icEZLeDFEUERuZ0dwR2o2dVFOQkppVTJnRVV0R3hoZXNYTTMyUjdRd3Z3?=
 =?utf-8?B?Y3hsRDhEcG5oRmMxYmlucjVmcFFMY3huYUJ3UUJJZDhaZ1A0TnFneDZGaGVs?=
 =?utf-8?B?Mk9xWklGanNtd240b1NXL3FHMlEvMk9ISmlwV2FFVG1HT2ZRM3JiSEM0NnNa?=
 =?utf-8?B?Y0ZLeDdEa21IRU9DVC94TW83RDg5Qnl2TG9VR0NOT3NYQjk4WnpnQ1dlL1hl?=
 =?utf-8?B?bldqOFhZejRvSUNzTWdocm5qdDRVSE5wbk1kYXl0ekx4eStXWjFsRzBvMlFH?=
 =?utf-8?B?RDZyWXg1TVdMM05NVGo4RHdLUERzQ0FwYWZwcitCWk5EVXNOMklDYUFWUFlD?=
 =?utf-8?B?L05zZE5YQzkxaEI3cVFlbGpOcE1kTC9tRUZYK2ZQRlBwU0VROVg0aUwzWGRC?=
 =?utf-8?B?UDZNNXg3V214a2xPcWN2UDBLc1JQUnFkc3U4Q3UyMUh5MlE5V25jbGIrNTNB?=
 =?utf-8?B?eFZVZXNUcHJKeHlGZmdIUUFHWFFpL0xPWFgzMktjdWc4Y0I3TGZuQlMwMjVB?=
 =?utf-8?B?TTcrZWh4cTByMXhrekc0dlllZURXS0dlbU1UWUR5WjBkM2pPRkVnSllUWHpG?=
 =?utf-8?B?MkhTVFVFTVhKbU5MM21HU3NGcmEwRUZiRGdkZWhPTmtQRjB1MjBEM2Zmd1NS?=
 =?utf-8?B?TUpBQmhBM2QyYThkVU9qYm5DQWlycGZ6TWsvOEN1ZStrZFlSSDBSN0RGK1E2?=
 =?utf-8?Q?qGH8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlQNU1uUEU4NE5Dc1BxanpwRWZSdjcrVXFMWU9zZkUvUmg0ZUJWRi93RlEv?=
 =?utf-8?B?WldhV0FSUkxQbnh5T0dHOG1kMlEzb2J6aXJvZWhjM0dqSEtNakVOZGVuazF6?=
 =?utf-8?B?VHdaL1pjM0ZvY2hkWHRzempkNzU2YWhOY2VCSU1oazJid1FWZmVHSEJaaE9a?=
 =?utf-8?B?N2lzUGw2ejZhY2d1N01saDR4TlI5blJ3eUJLZy9QVjB3cUpydkV3STZ3bEVO?=
 =?utf-8?B?bjQrckVmL2xQaGZ5ZEVpbVZRZzJDV0dhSm5YZ1BWV3hITEdZbjk3Yi9sWDEr?=
 =?utf-8?B?TmlCTjdZbk9uMUNiYmVrNU5nRDZ4cmxwV1NRK2tDM2V6cjByRkt4SERMSW8w?=
 =?utf-8?B?ZEwvMS9mNkNlRU9lNWIzQjZvQ2hBcjZvK0FMUTFzRFR2dHZnenlaa1lpN0Yz?=
 =?utf-8?B?alFJb21vNmZCYy9mUHBwSDNnSWFuK2VSNVNLakVHTDk4Mk9DZjU5Wm1oTTZh?=
 =?utf-8?B?dXZJT2ZiT1JKVDJjRldiUGFiR0xjZitLTEoydjJ0S21aRkphanJNSWw1b1Vv?=
 =?utf-8?B?YWxjMHVaQlUzbVV4eWJaZStqcVYwd2NYOW9HckVOZU0vVTZiYnNhNTQ2TUNV?=
 =?utf-8?B?NUxKRHF3SVBweEdhc2EvSHRJYUJnYlplMXVub2xvNlUvN1MwMzkvT0VtVkpX?=
 =?utf-8?B?U2VTczA5SGEzdGoxSFp2U1lQalBXUytNMXpURysyK205YVBlU3ExbHRJZmJt?=
 =?utf-8?B?QnFPRW1hTVV1dFVUaEtjcTJFaS9zQ1JCWXJoZHFHV2tMZVpPd2tmcE8zMDF0?=
 =?utf-8?B?dk53WW0xWmVEM1FFY25ZalhIaitTR2NOdXF2LzE0MXU0K3o4QXAvb0VBMmYz?=
 =?utf-8?B?VU9QZlhObkV1VzkvakZDbVhEb1Qyd1FXMHE4TG4xTkJzT1ppeWp6TXh5ZEJn?=
 =?utf-8?B?Q1RNcjBrQW5TZGVMbVdBV01LazlJOVNpNzVOTGxMNlVjZ0J3QWlSbWRmZndq?=
 =?utf-8?B?Zmd4OCs4SkU5SDdVWjcvZjBMTVJ1U2VjckRZYlJOeFNnOXBKSjhIZ05ZbVR1?=
 =?utf-8?B?UVJJN2pjZGNVaml1SUY4UmFvZW9XVzQ4VW1Lc24rVDNmQ3Q2Q1BnUGkyUGYw?=
 =?utf-8?B?T2hIeU0zeGhmVWl3Vnd3d3N0NnFMWDNJKzZrWEtYRWJaTzJBY0pDb0xCRFB2?=
 =?utf-8?B?cVc1MTJvVE9jNkpMSU0wQXRQNnVmam1iTVo3c2pXVExpV1JGUjhqZmFyQitI?=
 =?utf-8?B?eXg1ako0MHRnOWR3aUZHSFovb20xQkVVUTBlajZsb211eDZMcXJ5RlVucGxC?=
 =?utf-8?B?bURmMitmQ1BaV2ZGbitsYnFpTUxQT0ZxL2hoaW9nc09vVkhObmxaOHNoWW9H?=
 =?utf-8?B?ZlVGQXZXS3JaRjVhWGoxa2JZRExMS1lSR1FOWWNxNi9EVExxbnJrZUJMMHhl?=
 =?utf-8?B?a2p6S3JScnBBa3kydEw5QWdoeG01dy9RRFRHRXZaS2U2cFBGZ052VjdUclhO?=
 =?utf-8?B?WFUyN0p1U2gvSVBFMnlmcmc0WjcwZmNMa25TdzVQQ3p0OC9qTEJsNnJBdERj?=
 =?utf-8?B?UythMjIraEdMc3ROb2ZJR2d0TnFPNEdJKzFGTldWdE50aHplcStMcm1qb2FV?=
 =?utf-8?B?SjRKY0xwQXNuUzhZUVEweitNNEtSbE5ZM1BXY0wzMjF4OVd6WEhqWHFHTXRV?=
 =?utf-8?B?N0FjU1R6cmR2d2Z3ZlZuRndieEhleGQ4bFArVGp5S1Y1WWZVcDV2dUdRaVVt?=
 =?utf-8?B?NDNTYXdxSmRZaTRHaldRN1pabFpsd3gzc3BpOFRlZlhmSEJBNFZNN3pJTU1h?=
 =?utf-8?B?NDNZT1VKTXFPUzVSa3VLL2diL3lPK2tRN0VnaG5ITjVsNUlIWEMxUzdmQmQ5?=
 =?utf-8?B?MC85R3Erc2c3Y3ZqNzJVenZWSTlpdkdCQUJEZGdiM09YY1hLUHZ4NXJTR0ho?=
 =?utf-8?B?TWgvWFFYbktISFpjRGZmcnpHZUFkZ3JUTTc1UnJZV3g2S3JNaU1LSkRxSTMv?=
 =?utf-8?B?T1dxK1YyczU0UHU2TzB3NWhLY0JTemhmNGd3aWdvalBOa2RtTEdsQXkrZ3dC?=
 =?utf-8?B?MWpYREhNOVNFaEJGV2ZVcFhMb25vc1daUUcyQXk2aU02RHpLNURSRVFnSEEy?=
 =?utf-8?B?UUpnc3M1N0dvdGJrRVl6SExjS1VLOHRnZWxLU2hYWExjUFkvcmRNSTZtRVdn?=
 =?utf-8?B?VUtWak9jK1Z2NXl4Wk5DY0FESTBoQ2lCTW5NcFJoUHpNbHk5b25Rc2xaSE5V?=
 =?utf-8?B?RVVGVnkrOFgvVXhnSzE5UGFubzVTZTBqVkQvOXhBYkMxOUY5cXR5WXRSeDlU?=
 =?utf-8?B?eVZyRTVxTWpUZ0V3aitCdlJWWEpoRk9TTlpWZkZiZDVLTlM5Sjl0bndLYm82?=
 =?utf-8?B?N1RTdWlxbXhIZTE5bzBvWWd0REl5SkhsRlBsMW5uSDd1MDc3UlRvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94053b8-7ecf-468a-71b4-08de6717fe1a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:43:08.0731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWimtKr3t2zViK2cXzku6cggWR0JgV6cTr/B9zvdAGM8K2E/pJs7XxVgUCjCMTSvgXz1FDbCmKBDmIEsP+9ujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
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


On 21/01/2026 10:14 AM, Shani Peretz wrote:
> When compiling with optimizations, the compiler uses AVX-512
> instructions (vmovdqa64) to efficiently zero large structures.
> This instruction requires 64-byte aligned memory addresses.
> 
> When compiling with ASAN, the stack layout is modified for
> instrumentation, which can break the 64-byte alignment of
> local structures. This causes a segfault when the misaligned
> vmovdqa64 instruction executes.
> 
> Fix by adding MLX5DR_ASAN_ALIGN macro to ensure 64-byte alignment
> when building with ASan.
> 
> Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
> Fixes: 12802ab2c8e2 ("net/mlx5/hws: support GTA WQE write using FW command")
> Fixes: 405242c52dd5 ("net/mlx5/hws: add rule object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

