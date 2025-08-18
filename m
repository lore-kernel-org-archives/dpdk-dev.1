Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DBCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 463CD40277;
	Mon, 18 Aug 2025 08:31:13 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by mails.dpdk.org (Postfix) with ESMTP id EEC9C4003C;
 Mon, 18 Aug 2025 08:31:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1OXV5RamqAQ0YFEHdJh7KK4TcYeIOQ0Fqop5k6liB51tL2i6BmCNc8Paiv9DC9cy78c4WdivYqup07EGN3wgdpYIKiP1q/K60qA61Br0+LWwJrqPqWA1timtuxUN7/lrwlwt2k7hYRbicMNSsRKJlPwykFVeRqo2HQcb8lFKWt3ix0dgESwAbht38d0Gb1zCFIXEhzUIeg8lx3Pt/CVdFQhF8zzzOwEWavqpWodeWVZpQwndaN71EIs//Y7UhlVgpJTUvSw1awng8yMTjE1yFrg4APZe1uIHtijtdUKmrWmMRnDabF9pzffU3NQE8cC5scG4UNKqmQ41tm1mmhSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlwfeRcvI+SCCSqgRWE3TRD0IxM0Gus4HIrrMgj+WEA=;
 b=YXhb6dUfzzJrLgOkkr9twqVOFSunvhxrrXOPqzQ8U9cme+NnX5xzDleBWivQn7fnHIPUIi7ycohnK6L5mT8g4XBhmfypR1bku+3o5fpAkn8ncJrdE63B3+6WM7RqCSauLqubI5hWlNW2vTEFli2d0h7j28YVg35S0x87YMWmw0b66JJy2Sg2m8jdNDCswXOAUXYYl4IQyyyDF4KaC5mw1c9Ne7d4j9bLo/qJHnA7sXZmCFVNy/Ew6/RRMt4yCEEYp9xoFhweQteFTGvJglC45k+1yY4dGGt/zuqlCncFkcKVXUESwh+JbxGtrlVrv9QmWmYgv19m9WbbR0/vrXNUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlwfeRcvI+SCCSqgRWE3TRD0IxM0Gus4HIrrMgj+WEA=;
 b=QPevr0RJSpxeXcy8oAnSdyrbvkMykZ99Tp+7zHPDoJDgRzmKdJYFis3vYjwn8n/fY0X0BrdDnSjLIP3rOYSJU0HahYT5OWmwWsZsUA4OC0oe9MqePJDhO/Sm/4mfqbValAPSgF5wucz3q67bK5h9OdrRgs5+KqPbz8U4oXZ5Ula4s1kbHM8oxT6W/PKU60H1UojpYXLTj2WMLOLoxOLvCZssawLSm5WRdEjoQeI3oHpRtYaiqQeXeZJ2+K7xUQxfnBXH3MayATZKG1bakm+Wg7BwijsPTZDOVBve2VUeEBbIzbHYIVL4vM+lCC+4qUJzGWfcA/DBDsZtngiOAMqkXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:31:10 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:31:10 +0000
Message-ID: <6a474dbb-c021-4f7c-9df1-3cbbeaf040c7@nvidia.com>
Date: Mon, 18 Aug 2025 09:31:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix stack-buffer-overflow in indexed based rules
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
References: <20250730071700.187675-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250730071700.187675-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5138e9-7009-4065-77d4-08ddde20d1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVhoUk5xSWxRWkw0RFh1allQWTJOS1hDcm5UN2JBTll0N2lkNUZLODZHWHNP?=
 =?utf-8?B?UCs0TnRUZnRpL2dCN1hzRU9TVHgzQWhMTlhyWk5XUjBHK1g2YnQvZlI5cUlz?=
 =?utf-8?B?bUc2T043YzR3TENlWDRqZnJYMVhIeWlEdGlxSUVNZ0dpWGxvTTk0d2J4d05l?=
 =?utf-8?B?bjllditSSGR4WWV0V3BXUm9OTTdad2ZWeGVmd0M5YzRQUEJqc0NCcFAyMGts?=
 =?utf-8?B?c3pVVk84MFplVzhOeS96Qks2WGJ1WFVISjlJbHdBWXEzb0RvUEdrVkNUZ3hB?=
 =?utf-8?B?bTdsOFdmMVNXV3FKU0pBN0ZGTVJJYldTU0ZYd1VNSGU5d3RDOSt0b2RWU0di?=
 =?utf-8?B?S2psSTcyeFVhMlNsQm5XaVFjVXFTQmZHN2lhMlI1Z2tkc3J6UW9wUWM0QXFU?=
 =?utf-8?B?MTJ2eUljdmhzTWhUbkkxL3VZdnZLTXRwTnNCeFozNXduNmRUaEs3R1VZQ1M4?=
 =?utf-8?B?VUJsUkxoUW56OHgwaEFPdnhRYk9ENTBtM3RNN1ZaVXM0N216and0ZEpVQmps?=
 =?utf-8?B?bXFESjBkZ3lqRXU0OEw5amt4YitjME1uR3I5eTB5VjJsRGJyZEk0RHUyZDkr?=
 =?utf-8?B?L3VQamx4WGZGT3g4WEZuRWdoL0JOMURpM1FaUTBpNFRzeU5rTHlyMFU0aUty?=
 =?utf-8?B?MzBPYmZIc3ZnSDVGcHB0TmRZL1pmN3lzRXBrRzFFY0J2SGZnaFlWeWdYSm1q?=
 =?utf-8?B?UG5WTFU4OFo2WFpha2RncUQ0cGV5Qm5TcFlNTnBPOU01VktNQXpzOXNyVk9l?=
 =?utf-8?B?ME0zQWRXNjBJNEduVGpvWFZnYjZWTzRUMXdzUHBhcmh4VCs3U2NNUGJLT1Fi?=
 =?utf-8?B?WjJzcnhoUHpUOFc1MkhVWDQ0ZE9pWHpSVTV1S0E1dTYzSVlPcVlCQUhUTEhX?=
 =?utf-8?B?MnlvbEs5UHFKYk8wY3IyOHBIL2VLM3Y0dXk1cVF3NmNSRnc2dE1TZzJaWGFV?=
 =?utf-8?B?dUgyRDlxOFVMVjZvbHBrWDBWRG5uSXZrZjZBSGphR21QamF4empEMzlybzlE?=
 =?utf-8?B?UlZPcHZWUDZ6K0xBSUE5YWkxdmlpNG5Bb0RpQnNiVTJSV3pkTlJHVFFVa2xr?=
 =?utf-8?B?dGJpOEhvZXF6UXY1U29vbHkwN0RPTDdjQVM5bDF2VmpsWXU2eDlTc2lHa01F?=
 =?utf-8?B?akNWMHNhSHRZNWZWQ0NPbHFLbTk3eW9SYTJNTmdoVU1yWVdkdnkrVTNyR0Vj?=
 =?utf-8?B?UHpOcU53V2x6SzJLcVE2ekM0aFZXNlQxazdQMEVYK1hMVVB4ekFwem14Z2NM?=
 =?utf-8?B?QjhiaTFTYmlCSnJ3anY3N1VjYU8yZUVrczhSYVRTb0ZRZGlVY1IxMHdud2or?=
 =?utf-8?B?aVlBNFM0d3ZyZm1JSWNiQjU2UzJPaWFhaXVTVUtDaEpseWRYSmVFWXAvY0Vz?=
 =?utf-8?B?TEpVUmc1WEZMcjU5Nkt1RDQ1clJ2NENiRDBRVFQzMGFiWVF0ZE5DZjNmbU9z?=
 =?utf-8?B?S2xROEZoUXNhNFZjaXE0UExHRCtvNHlzZWZSZ3IwRitIOXVMVjExTGNicWtp?=
 =?utf-8?B?NHhqa3plN1ZWQ2djSWQ3cEtOTlQzWTR2SWhObFZBL2tLUlZCTzRSbGNKb2hO?=
 =?utf-8?B?Y0RKSlVqeUtQQWNuVklxZUNiMnJhTTlzOG5YWm40UEE0elgzN1F5QS93L2Ni?=
 =?utf-8?B?UHdkV0VweHdnTllDUzh2VzJGUkRQT2lEVHg4ZkZWaGlqak9XRHRiK3R6Rkk3?=
 =?utf-8?B?b01YOWlHTENZQTNUV1o0elUrTDhxS0M1aU9adTZBN2Y5VC9ZaEdxZHJwS1g2?=
 =?utf-8?B?SFNTZjRqUitoaXM3S2JHMWt2bUZVRXErS2xHd0phbUN5WlVBaWFwRjJleWNM?=
 =?utf-8?B?anlZNmZIRldEekh0ZjJhYmtNRWcyeThpZ3BxdGswZGMxd041MzhFZGJnZk5l?=
 =?utf-8?B?UlRWbUJUMVJYbXhsSm0zQ3RuSHJadGZVbW9RdFdOTGhmdEFhcTdENndQd1kz?=
 =?utf-8?Q?NRdiPxd2qgA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERLaENVdDIzRlgwUC9jdmlVSjA3eEZDSXA1ZFN2NGE3QnR1K2xqOWN3dkll?=
 =?utf-8?B?TmNJVWJnQ3ZGdkFnUTR5V1hmV2NXU2MzdnpVVzYxVnN5Z3lXLzNRMlFpNUww?=
 =?utf-8?B?aElpdk9qdjJPSFdxa2toc2NjQStZQnZkVWJ0VHU3QlpSMnhORHlBOE1yeWov?=
 =?utf-8?B?S2xHUUhwTzFZdmdjT1M4OFhtRjgwdGkvUWwzUWZ4WDhrNEhRZmxkSmtZbzkr?=
 =?utf-8?B?a0pGNzBEVEYyenFBMnlIMFdLU29EZ1pIam9jWmVWZUtjWHkwNEo3d2syOTNr?=
 =?utf-8?B?QzRqcVpVUXlWWHp3UVpWTEsxTG5xNmlKeGt0eWxybDhTdGQwVWE3OU1pR2NV?=
 =?utf-8?B?QU5RT1VMVDZlbTlJcW1JV1JvKzEwQ0g4M2ROdFNSc0hRU0pSN2FEWG5Ec0xi?=
 =?utf-8?B?Y0RjYVhQRTBkZlB5SklpVGZpZ01SM0Y2ZVpEbEU4eVdPYVFhbHpPU0NETDVX?=
 =?utf-8?B?U3JPa0h4Z0ZKVzJITUsrQ2doSEhEOHduOGtQbVQ1NlBLY0FDNmthTnNjUUlv?=
 =?utf-8?B?WWRXOTdhQllxOVZDaEh5bHFZdXdJUS9kWUE5VEJUZEljbnVueWNobU45cHpv?=
 =?utf-8?B?eUlKZ1o4TWNNaVB0REVnQlloYlpvM0JWODZCTmpGaEdvTG9mdm03UVZ4VVZh?=
 =?utf-8?B?cFRmUGdTRDNQVVpPc2xZRkZITURybnBWMHdqQWZrZEc2aXFWRnlPZmhSV2Yv?=
 =?utf-8?B?MXpyTms2eFFMdmxtU0o0M1M1Z0IwdGpCT3BmYkNHeG93WGJCNzBGRGhZamRy?=
 =?utf-8?B?SFA5eWtRd3UvUU8zZWRlNlRmc3VwVUdRTnFpUmJYVlphcUdEVmowQ0o0eklh?=
 =?utf-8?B?SEtNSENJTW1KQklhNjAwSGRmbkJ3WlFuc3JNem12VGtMY3RLUEM5WUg1QzZF?=
 =?utf-8?B?UkRIOGgxTFJaVFY5dU50V0kzN3JRMDJ5ak9xZjRpMEFwb21vbVRkQjl3ZGVM?=
 =?utf-8?B?d2VpMmJjd1BnOWdmY1UwT1RNanpqUlRkVlFTeFF3czQ2Z3pDOGR2aTB2R3Ni?=
 =?utf-8?B?MUFQb29Ib0xLajRkak1jUTRDN2lVSEtHYUZSbGQ5MkVBVC9UaVRqRlFoOXpY?=
 =?utf-8?B?RUU4VVlPZzQwSDgvUXlXZjFWbGdPN2ZFQm5qbFhSbE1URTU4VjR6SFZIUjcr?=
 =?utf-8?B?RHdkbm5NKzdWZW5oWUpqVUE4dmg2aHVoeVRrdHlxU0tjL0hwTWU5LzIvVDBI?=
 =?utf-8?B?V0xQMUJ2VEp2cS91ZUFZa2VJUkR5akdXYW9qRDEramdWRU16WkQ4L203aWhJ?=
 =?utf-8?B?R1RpbUo3VVpvTmlCaVJHWktRNkJrSXQzMVozWUIzS1QwTERtb1c2VTBicG1O?=
 =?utf-8?B?Rlg2UEVWenZuMHFiT0tJYTJ4aWg1azdNdlcvY2grbTBVU084WE02TTdPdUFi?=
 =?utf-8?B?bmFrQU05alFyNlI4SVJleGtzRCtXeDN0bTlXdVJNYlhkTGM0YnhxbnVIUWV3?=
 =?utf-8?B?VVFBTnMzWkp3T0dsNWNwWm5rdlF1bzVsZm1sUjkvM0EwN1Q4UXJycGNSdU5h?=
 =?utf-8?B?ZTlVKzkya3FMeTNMNXo1VlNoMTNmK0NSck1XMitRWXlLeC9oS0MxbzRyOFRF?=
 =?utf-8?B?cmorZXQ0QjgzSXFSYlRzTElZVG9pcE1HMHBCQkcxbko4VVJxdm10L3VGMjlp?=
 =?utf-8?B?cVpSQTZzSm9QSzdqanhLMlJ4dU13OFl6RStnMlJlNTc5V2lHeVlqNDJzbnJT?=
 =?utf-8?B?UGFiTXpkMWxEOFRnTDJCODdiTlVsWmpwZllydWJJdTFtOGtBR3hBZ25DZEJw?=
 =?utf-8?B?Y1F3WXg5Unc5REdLOExkbFp3aUpCRUlueDJWUGFDUHhjcHVISzY1aWJ3bWZy?=
 =?utf-8?B?eWJ3LzZiSmI0M0xTK0hpQXl3aHE0T2NPZGdsdDVmcGZ2aDVCUEFTcmFxV0ph?=
 =?utf-8?B?Y09oUmNvanhydFhHTlBrb2FKMzRvTkg5ZG91aUw4czdWWUt0bFl3ZGg2eXlQ?=
 =?utf-8?B?aXo0Z3BpekkyT1hzVld2WmMyUlYvMWQxQ1hhSWU0b1hCcWpWYVZUc0VIekFS?=
 =?utf-8?B?WlVCWmxST3oxY0FBNUdhTEQvb0pXbm93OFBwWDYwbCtHaXYwSzVrb1B3bWR3?=
 =?utf-8?B?Y3NseWRWdlhEQW1KS0czZkN1R0llNWZQSEZXd2VwOHVzVUh4NS9MY2FoNElE?=
 =?utf-8?Q?ckbZ9xM+EQ3tiiLjG9Lpy0Jdt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5138e9-7009-4065-77d4-08ddde20d1dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:31:10.0619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLdugdg5Iv6pEwvJJFLqXqjYhhizmj8M/G2yrvlEuFNiijY9ll43VEXKZh+8ZSUfBA5TPbs53E8zhXE1WhwN5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 30/07/2025 10:16 AM, Maayan Kashani wrote:
> During asynchronous flow creation by index,
> the items array was initialized with only one element,
> but the table metadata did not update the item count accordingly.
> This mismatch led to an out-of-bounds memcpy operation,
> as the code attempted to copy more elements than were actually allocated.
> 
> To resolve this, since item matching is disregarded when inserting a
> rule by index (the rule is triggered when a packet reaches the
> specified index),
> the fix is to skip preparing the items array in this case.
> Instead, the items array should only contain a single element,
> RTE_FLOW_ITEM_TYPE_END, which indicates no match pattern is needed.
> This prevents unsafe memory operations and aligns the array size
> with its intended usage.
> 
> Fixes: 36c379c82e82 ("net/mlx5: add flow rule insertion by index with pattern")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

