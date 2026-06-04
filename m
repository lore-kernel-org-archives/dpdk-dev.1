Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3186CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFD82402B6;
	Thu,  4 Jun 2026 11:26:59 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by mails.dpdk.org (Postfix) with ESMTP id B607140270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:26:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E45o8XKMtG16ijItX16M2IeVzUci4JhVU3ODMAtglRRP5MqJUJpanAsJs34Cgz6j5HdYdM3J5GTJyd7OjhYUGRZsGVdSJCb5yexivdeIGysZz+Bc2BMT4O6L17NP3c/HXxEcDjZKef15Ov6oOttrdbnmwdDpGM+1QVojtht3dg3NrnhbsRmx4aNaN8LUbauy/aISlRcSmCVv3vrJAujz7U3KKqqHRiYDzT7balnXQImO/HA07EifXIvnYHxmkSD+znChnFvozzjKX6HLgH6EA7TU6qXgofZSmpUCxFkjdkdayeOsubGThCc30sZOzGNF5RwTGeYVQWI3yxG5O/5EQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEeRHozJJwnrXe4oLKjCF/3C4EHdSL/ngSIznEXrLXk=;
 b=EbCby2e2XhpH8CHc7MrLmEl55HUDrQOiJGgbF8KF4mNYg4UqHv3JX3ASyZeuHh5ria7ysEjk7ruS9VWkifHOg0LBxelpQNxlU4XdP1VHEDGnWRBEvF3JcEGved9J77a+YN7vH2P39fFT74qfHATgZEcpyLnSgISPITAsDvXwT/1MQtVuJZDOc/k2L5pIvPMbv5FlPSmTQZ4TplhdpXiH8Zd45HgpCRcyv9c5M06XRZL93qjWyC3UaUp3+uElPnzC7e+h4lgr+AHOmI2In0/p/nuIZx9F5zbwLpfMgXbhwc/GPaEkHcVqdeHFsbeem+IjHayUDryITQxWf3nTEP01Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEeRHozJJwnrXe4oLKjCF/3C4EHdSL/ngSIznEXrLXk=;
 b=VSsC3eFqzDKB72zaVRAnf5aJE5dUXwg+cddOI42XGar9rG1UeK6vZYi36MMQqsn1aElyOl/GfrM9rwFV30hcHWeJ8cRCNY4a8yOo56iGXLryGbqAxp1InrcFY3DLXd7Ob05NmCSpATPdvF6dj2r+kT76C7lKpWU7nk523Ywi+9bo1Fa7aT8cTcXriPLR+cqOQiiak1KfbTaIaQryU3xuhLLnK80cAjOT0ZjNK0kSfhYgXXRw1R/c5q5UmjSCHJTLV8dsw/E6zHmpX910PBPsF6Xjh8hU9OK3EF9vZ3fsOL89uwJejyoLisJfhRW5TigK8RztrxXXNo8KNUb6zMoZYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 09:26:56 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:26:55 +0000
Message-ID: <2168b0c9-2321-452a-9820-d9185aceace0@nvidia.com>
Date: Thu, 4 Jun 2026 12:26:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: improve error when group table type mismatch
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20260325215426.9519-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260325215426.9519-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6444368d-de30-420f-b787-08dec21b6b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: VuLbdIhK7lyY7NQeAyvFTv2d13xeYH0f4SndfAeiMKm4B9vJ4TS78uG5Q/z7pXqo3YsdDyKzluzxgE032dmm7kB6ntSD/HojJmKjRBGVih8092kLZHIBpGBEEl99IYH3PxKnIEfYaIw0zYKzH2ipQrI9w7g+YP23q5vAWmXZ4s1gRyDVkt79QAw0l0LfLamD8nBHpGOgfFhr+mpa/r/4m8RkxrceUrO1TFuD3rgA2E58+JH7NcKx51ySKx+J9SYtarosHgOhfvCT+laGTxLvD+4z26F8W7/2xbuUhxW2ccKp93xZXqmpGcRsK2nG+2tWYwigvv1NZ2Ip7EzrMDvzbDbp15nZ6sHxmxfL7/n/HT5r4zE3YIx+flkVYohJrB5MtMnfs4vmcYYcTSZsqhmYwlL2NqNsZC2OT0Ao8Qnm0j7Rj61lIoxo01aFqG9AxoZycXAZy/pJJRtJTnq1Y5B10mmp7ms/1BAqOdDhyc4rPGhnoJDG4bfwPHfypj8UcUBNuihbeAiKyKNFz7BZ0aiau38XAN/oq/WRi3NQG7sgkkKnwr4f3MlGE4n8GunEEP5ncxAmsUjSUHJM5x6qkbniztQRJ7bVWhWdzXioN4Y5uS7imF9CNR2AqbQqLSpisS1eWbouBA/rigyOWfHfvo1aSzktQSoM6G9Fwd/bJ4XlqagpPIAHgf5BamOXROk8mY7L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZGWDZMS3B4TTRUWlpvN25MRnZzOEZEYWJSVXlkYWtLQ2ppRXc4RWFIRTR6?=
 =?utf-8?B?eExKUEw3Q2E1aDhDdHN3c2kvWGFTaERaYXNXK2FGRnFrdjh2a2ptUStsUy8x?=
 =?utf-8?B?R0FtYkVRcjF4NDJrcHNIWGxURWh5WlR1cUNDeW9ZTVp2N1pLRkpjeFlKUFdP?=
 =?utf-8?B?bjUyTWJCUWdFdVEyL2x1SVBDcXFKQjZjOU1mR0Q4VkxGMEVrRmo3dU9rL1dr?=
 =?utf-8?B?TWdEWFdzOTZkRVI0b2t6bXN0OWpaeEUzbllQTjd5d2JKc013eW5HdzVncFBx?=
 =?utf-8?B?UVFIUWxIa0JvSW1OREczQUg2QzI5UGtYWStQcVRSYzhFSnl5b2JWMXJaakFT?=
 =?utf-8?B?WmpFSmVGTCsvbnIvYS9OQW5EalIrTzhlN0dsci9uYmpRUVM4aG93Qy9IZTVz?=
 =?utf-8?B?anQ3SXVtc0wyMXZzM3EwdVBHMUpPK1dvaGlxY1JOK29ta0xrVlpWdVQ5czdV?=
 =?utf-8?B?bEJoWHMxYUh5REE2UFNOQVU0L3lXN2pDQ1N0ckx1UXB5UHd5MVdIQUd5L3Fy?=
 =?utf-8?B?RlhML3BIZmJ3THB0cWQ4RHQvT21rRzVNWldjKzBoNEpWRkxCMXczNkQxVUVT?=
 =?utf-8?B?N1lNZHp3eHZCSTNsRFppT1NzcGNuZUlvcFNrV3VZQVNXbkhnMElmeUVoWisv?=
 =?utf-8?B?c0FReSthYnIvZllydm50UEpxMkhGMnBhWUt3bzljYjBnaEdzUXlyTnA3QWF3?=
 =?utf-8?B?S0gwTXZ6aHlOT01waHhIMUVLcnRGVHZ0SWtrd3JvNzIxUGVFRVpmc0w5ME9w?=
 =?utf-8?B?WkNqNHErbVRlTTlWMUJWVmltL3RIN0hnMWR6ak1SUUNqdG1GbW9iUUNldkhV?=
 =?utf-8?B?RHdya1lSME5WaVFkWHpvenpWUVhGWkw3VUhlRm5VQmFSbVZVNDZ0RjdienBo?=
 =?utf-8?B?RnE1SGQ2NWJXSC9SR09hV2hqeVQveCtBYW9wR2ZNS0Ywd0prakdvU2pUc3Iy?=
 =?utf-8?B?VU1NMU9XSk1rdW5idWpvV2wrQmwvcGE4MlBZUFA0MHRvMUZnOTNEcWFjODJW?=
 =?utf-8?B?VzZLVkxDMHAxMmZXclZXT0hGUk1ObWZVK0NnSlU3Wlp0MTU4NUU5a0QrVWhL?=
 =?utf-8?B?SjRsSDNpNTRheGdmMFd0YWt4U01CY3BCWTNkRHlCRC93aUwwTXpxSWZGUVJO?=
 =?utf-8?B?RSszait6Q1JPODdYMDh3R29aWWhjbDVva0ZrSmRXOVp1Q0EvMVBVSzgyaXdq?=
 =?utf-8?B?cTgvN3V4RWVqckE1a1BxQkNFTzg4TndEZk5vMS94bm5OMEcramd3RVJqTFJ6?=
 =?utf-8?B?bXVJVjBrWDcyVUJ0ZFh6cHNqQnVzR3FMSlJsS2VZSzF4SUVMaEk0dkRhZlJG?=
 =?utf-8?B?NitHeXhBcGZsMFcyZERBTDd6MnI2RXBlV29GaUNYckJ0UHBCVWF4cGtIbVpu?=
 =?utf-8?B?MTFVU2U3VGtmQVBMYnZTWHg3RmJrYjRubjBDQ0xhd0RzZkFyY0ZXUjVSMU16?=
 =?utf-8?B?VnZjbjlZKzc1T091RGpGVEVpZk1jZGRzREFiYi93anJhUGg1R21hZnRzQUt2?=
 =?utf-8?B?ODJGWmR1OThvSzJ3c3BKVWEyeXA2OHZzbXRXclRRUEd3Ly9zbnJydnNzdGV0?=
 =?utf-8?B?Y2IwUzVWcDZad3Z6aEJ4aDAvaHJZbVdwYUNFRFBVNjcxWDduVVlmNFpKeG0v?=
 =?utf-8?B?WTEwS2taMVlXVUVtNkxCYjRpL1IyNnpCZlVOU0JtY0VSMWx1ZDYzREkyU3A3?=
 =?utf-8?B?d0JxNEpiQUJPZ2MrR2o4N1dFVllGUmlHNGdLdGZFVFNnL2Q0SGo2QXVQR2wr?=
 =?utf-8?B?S285cDNwcjBqOHU5NVR6Y2IzakVjZEI5QnlqdjVhVmg1c2Q0MWl2OE1xbi9T?=
 =?utf-8?B?RTJzVzd6RkFGYzNicThmRVZTR3pEUFRvSjhjWGg0ZTFPLzI2S1N2bHd4Rm9z?=
 =?utf-8?B?Q2R5RzI0b0RZSzhWTkxENjExbWhINTRacGtXS0plUFA4QlN6WFlEMVlFS3hm?=
 =?utf-8?B?dUxqQm5pOE0wZlNsNVR5L3d0OUkxandWem5ZV2NjZllyNmdFczc4Q0EvaFNQ?=
 =?utf-8?B?UnFZbUVRVk1BM0c3QjhmZ3BMeHBnWnRnM1RwcThtUmpSdzl6TmhXOWhRL1lC?=
 =?utf-8?B?M2EzTzNiWk9Wb3QyU3dGZmZDYWd6QjRoSDJ5TWJQVkkvQ3psaEcxNENiWit0?=
 =?utf-8?B?bkJFd2JxMG5SeS82d3Q0VmkyOFVSRGhpRXNLOG1Xb1hUbS9vVWNXb090R2U4?=
 =?utf-8?B?OHlTa0xmSmxXRVJMNTNPMTk5cEo5VnRiYkFoVWRERW44aHUwdzVERkg3bHdx?=
 =?utf-8?B?czZYNFRVQnpDc0NrZTdwSktXZHVnSys4Y1c4dVY1blRmK3U0UXdzckJrMDN3?=
 =?utf-8?Q?z8ijhza7o3O0O0znFI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6444368d-de30-420f-b787-08dec21b6b38
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:26:55.5192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRqDTkjtRgAtP+ydZP4Zb3dDGXeVWX3lkbQQAtBEoJUWh6YGyCnuJSk/uThBtQtvITFifVapYwdnF7iiebfDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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


On 25/03/2026 11:54 PM, Maayan Kashani wrote:
> HWS fixes a flow group's DR table type (FDB_UNIFIED,
> FDB_RX, FDB_TX, etc.) on first use.
> If a later table uses the same group with a different domain
> (e.g. transfer wire_orig) the driver returns a generic type mismatch.
> 
> - Add mlx5dr_table_type_name() to map table type enum to readable strings
> (e.g. FDB_RX(wire_orig), FDB_UNIFIED).
> 
> This makes it easier to fix ordering issues
> (e.g. create wire_origtable before the table that jumps to the group).
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

