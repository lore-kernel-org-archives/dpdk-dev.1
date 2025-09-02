Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DDCA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 07:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BC2A402BD;
	Tue,  2 Sep 2025 09:46:26 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by mails.dpdk.org (Postfix) with ESMTP id C7B07402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 09:46:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLtWvQWdpBxSvH3cdo/JNGx8cBLGW0BIYWlERvRkS3f0AYHyb+AndpHZ6Ft7y0a1Mo/iZxANP+cOiANstBEbMCzlwjmb56WlsRQTgCvNXbYGe8PINvJi1bSdJv5U53UlciPGuV9P9Djd9QXCdqgMHK85YVXVcDVhK6kvJOxz26fn2RGgwV0B0/7MvVCbv2k6cXy1pIaqCHpbYpbilmqigS3DG1f9AONF6qNpZH+FJcv6UbI6Mqb183n/QARMKvvtE1kFjC6UFQ7rc0pq6Er/XiKWl47pQMNdGTIWVKcya47avc3lu3k+RAyIPqBSp/3g6RkND0S/FGxcJwnNPL7B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nypqF7wuKnJgTGnHPs+PbI+deiQlrcWsBS3SGerGCOg=;
 b=tJToelWVnGwSVwB8OTFtpVwPWbMeZGrlrWaCepY3GflDGVPokVgeCsYB+lKlQNKwBUmHFzpa4RJhHg+WkT8534hBD4N5mgPG2vc8ThkJ5g3A6LBq6qpOnf7i4rJrpk4CT2AnyIg2OqfBtyXWiHj4AOjQ/CgTldyY90xwGc7JdbFXs5PSQCjhf87BCZZPAnTuD4RGZ0jdvbN7w7c0++1eoC2xX3k4Jp71qIq2FwLNDmGzTMNFA5x+CbznG4MvdBiISH3BrLEiB1ynowyWH73Cc8uSW3bWNjruSJRSscJ4LGzxMkfUhA2pEZ06IQMQgfhbzfrDGn5pnqaZG9TnZ4aTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nypqF7wuKnJgTGnHPs+PbI+deiQlrcWsBS3SGerGCOg=;
 b=L1zwPpiayH59iGqn9F9MmZSegyir8lzDTBH7IYub2kC5lbeDU2yNNXBqoreG1ZTDqmU5jaqn4iIEOUxFdi7JpyamKMYCeJSy8OJR8h6C1ES4c0xZFbsFORE5gamuGPGtd2ufKZJppaiy/iKbroXnZAwuY8/EptC/NVpRsnrAm8ThzoM9eaKG57u5VemIRK+D8FxfRXxhSIOdeMel+R/i8HPlCWSUgwoL9haa5FX2VeEtwn29npsNvYOOkjYI7z3i848nAUJ1t/9QvMp6/HCuK0aU38YugGDtaXdlJP/2Nr8ACOIgs/lkojkP3Wo6vo063XYTETo3S8qMPwFI2kjznA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 07:46:22 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:46:22 +0000
Message-ID: <2b5a9a06-3319-49b2-8e37-bca688eb230b@nvidia.com>
Date: Tue, 2 Sep 2025 10:46:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix interface name parameter definition
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
References: <20250810132300.124429-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250810132300.124429-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de220dc-51ab-4ec6-b093-08dde9f4cfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlVBOXlNWUEwTXNqYVZ5dWN5MVg1UEdBUFlTeDFyZHdCMUxBKzd3R0YxS0U4?=
 =?utf-8?B?Q0g1VDhFaEk1dU5FZEpDdm1kbjNiRTFzenpXdmdyNG16NDB5a1BZbEhOTm83?=
 =?utf-8?B?Uy9PWnVKRUh0d0QyNlBCb05BUEJ1ODlqVE1qWkgvazlqblV2MjZiQk5scFc1?=
 =?utf-8?B?enVMRDFGQU9vc1cvNFNpV1pncjhZZEludUtzclF5UkV1bDFKbGVwVm5WRXFq?=
 =?utf-8?B?ODdGRmJJN2JTbGpsYkhUanIxTWlDTnFRMTk0bEJTUU9ZbHhWUyswaThpZms1?=
 =?utf-8?B?ODNVVDdDWFNDZmpNMmgvbUYrTnduZ2daT1NEeG45N080UExQWmoxb3VEangv?=
 =?utf-8?B?WFRxajVDa0JDTEczWEpzQVNrdW5wQU5IbHo0N1pSc2ZhQkRiRzQvOTU3VmVL?=
 =?utf-8?B?REJUSnJETE85UytDclJlSW1XeTMvZmFwMGd4MVY3VWNmYVhBSFRqS2pxRGd0?=
 =?utf-8?B?QWdka0dIRkNUL2g5MGoveE1ad3ZCamVnSTVpMHo4eGJmLzFyYThYWVBsMm5a?=
 =?utf-8?B?dnhYSVpqNThqeG1NZ0h4K2orOHBZNU92SnZXenVrVHI2cGExVjh5cUtidG1l?=
 =?utf-8?B?WVN4M044UGVnNWN4SURWbUpVSjg0cnN1RlZIWGp0NmZ3am90Q290SkVhUUZL?=
 =?utf-8?B?WFFlbHVhdUlldFoyMzFFbDNsaEJUMnQ3cXYwdHdxNzhpTDBOOEtvdVZpTG1p?=
 =?utf-8?B?TVdSNnFKeVg0VXhraFNsNHFkTzRzWnlaZ1kyOENnWjBHNC9vcS9hd1ZNNlBI?=
 =?utf-8?B?MVR4S1Vuc1kzRzZuT1VWeGgxeWlxSVVNSXhveWhUdkR6eDlZTFN4UzN1Y3Jk?=
 =?utf-8?B?NlYrTWx4WmtXOHlDMEcvVkUvZmlBUWJxQVdPUkZTUUo4NXRSUy93OWt5NlN2?=
 =?utf-8?B?SVpJb1lZemttZkNRQTNTUEpiOHlNakFlTFA5azY2dUVldWpGVDdnY01yRHor?=
 =?utf-8?B?MFFZcUcreW9BRTJxMy9LSlV4eFhjRE5Sc08xUEsvMHlsblJPVzJ5MXhkRTBz?=
 =?utf-8?B?S05zZ1VCNkJxT0dIZ1FVRVovS1ViMmlwT3MwZ3dxU1U3Z3JFOURFV3FLemZr?=
 =?utf-8?B?aWp2V3JKTFh3Zk44S0IyVzgxZmZINUNQUzgvSE9jTm1BOU9seXB6Tm1tWTFZ?=
 =?utf-8?B?M0Nxekg0ZVNyMUxJRmc1WTVOclNXUGVFdDlQdnYxVWY2V3pudGlqSmxKWW5G?=
 =?utf-8?B?cEJoU1h6WWpSeXZHSEhnTkdXcGR0QkI0emhPZ3ZkRk5vS01OUUVpSm5kUWp1?=
 =?utf-8?B?MWRtRjVzb1dJeW5zWDljUndseHdTeXZXWmZScFYyQ0l4R0RTc09QcDk1MGpS?=
 =?utf-8?B?WkVScS9obVIyOXdGcnBMa3FHbGhMZ04wd1pRejhOUTh5ZG81elRadm5wYito?=
 =?utf-8?B?NFdmWERrL21QT0ZDNDNzVUx4aWZ6V3U1YkpJN1BQSStudE5yN084Q0lQcmQ3?=
 =?utf-8?B?OE9iR2dQOTI4b243RjZGOVNDVjYySVl3dk1NQmozVldlQ1pnYVNXbU5XZ2ds?=
 =?utf-8?B?V2lqSmVINmQzSmloK2xVVmVwK3NWNmtDMWZEYTUySXh3MDBRUEhxR1NCdHBD?=
 =?utf-8?B?Z3QrY0k2Y1NUTjJFZFFXd1QvSktuRWRnSGJWVGVCbG1OdjJpaXo2dDdvYlRa?=
 =?utf-8?B?bHg1YWx4U3hZOXhlOUJPNUsvcXdXaVVvdEExcUJ2eUtwT3UwU1hmNG5yNVZ4?=
 =?utf-8?B?cFhRRHhNVHhxckQ3a0FxK1FqK0ZzV3gzNExaYTJ6YXNrUjhYMWhNd2xQaTZT?=
 =?utf-8?B?VDladzRVWWdMdFRoazJkbzRjMW1KejB5dEptQjlmQTMzSURxWTBwWXkzNHBl?=
 =?utf-8?B?NWJncnlSZFlxNHZLZElpaGl0bXNwUzRuVVNYbzd3dm44VGdValpSREUwcnha?=
 =?utf-8?B?YTdRcng0N2VpdDlZcnZqeWhzMXl4VEZ0OStjMW02M1Q3SjV0bUVlbDhyM2xI?=
 =?utf-8?Q?URLUoJ3Eu38=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdISzhsbnJuSkhuQWVEcWtUeGpmbzcxZitpNnBobU5UUDZlMEFsLzJINTdo?=
 =?utf-8?B?VHRoSjZRLzg0U0tVc1ZvVzZjTnpHNUtxbEFDYmJoMlhhQUt6NTFkWEtJdElZ?=
 =?utf-8?B?c0lmMjEvTmI0SmptM2ViLzUvN3N3ZXlZOENDMyt3dGZwWkMvY04yU3lJakc3?=
 =?utf-8?B?QkUrdEszcFFENlRXdTg0dmNQWFpLcVdnY2RYZHJLQVZIdHRCL0FZTFZYa3hP?=
 =?utf-8?B?TVVZdVNsRlRleUFHUzNsRkRzUUk0N0pqM25MZEthNkpPWEdPZGdVV001eEZa?=
 =?utf-8?B?QWYvUDgwMFI1MjNXL09OcjRHYWlWQkhWUDRJaU1ad0N3bnlONE8xcWZiaDRn?=
 =?utf-8?B?OEdmOHdraU85RWRhVTlQYUx3ckFWdG9KRHBIb2JhZFNLYkk4b0M2YnhRZGhh?=
 =?utf-8?B?UitUL2lEWExTdGZ4Q2szZENBWEl1MG8reHJad3JTeVB3d1ZETXZHOVI5Yjhw?=
 =?utf-8?B?MEFKdWg4ZXNMUHkzNkFIVXFHOHplTklxTk5wZVhYSUlycGFJZzNWeU1NNXB5?=
 =?utf-8?B?VXpGR0pUNVpYbzNkK1NJY2xJUTVXK3R4WUJ0cjJnbk1tQ21vZEJPTnM2OUxz?=
 =?utf-8?B?Rm5xM2N1MFZBSUJGQ1BHaHEyTlFPS2RLTlFUSTJsNFRFaDJXbTZzbGVyN3dw?=
 =?utf-8?B?U21jV1hZMHZlRzZMM3RQUlNEdGk5bjZsanEzYkREVTdLd1hQMitmQnJoRkJv?=
 =?utf-8?B?NEcrWmZiUmZqOUljOHhveHJiZlE2QUo4YVpMZ2FWbDkvZXhFR0h1c29RLzcw?=
 =?utf-8?B?ZUQ4eDVlVXpPUThqbThsVGFhK1gwR3NGU0lzMVJRNzhrNS9IYW9JYjl3ekY5?=
 =?utf-8?B?Q042Rkc5dzdTeE41dDdwQkx6T2JMS1NXQVBIelV6MW5CVE4xNGZIaEdjSzcr?=
 =?utf-8?B?MGMrT3NyNW43MTNuQk1KZlFLcitIY0duVHJMSW54bjRxd1RZTXREemNHTXAv?=
 =?utf-8?B?clNwTFVpSUJ5WEJaSzNGWUozV1NaMndiY3JaRTRPWTN2Vzc5eVRDVjFFTGNC?=
 =?utf-8?B?aDVycW5mTCs1TkN2cVk3M1dKUjJlNlczblQxSkNpaTNIR1BRY0ZUL041YjMv?=
 =?utf-8?B?d0FQa1VWS1JiUWtKUWFmODY5RnNKd0pRK2cyRS9WYnFtKzV0UWhKMXh5aDM3?=
 =?utf-8?B?YjNlTGMybWEra0FVaXQ3KytpWEtuRWhFMU9RZjFlbWNMTXNoclJPNkJFYzJu?=
 =?utf-8?B?dVI1TmMrQ0d6ZEx3S3ZRQms1aUtxbnpjeEd2Ym1KTUQ1Zmd5eGlvbkNKblJW?=
 =?utf-8?B?cEZ1a04xdnJ1aTFzaWNqRnJWRTlMNUsxcXRpR2t4Zm5WS1dZcUZGRFRhYjVp?=
 =?utf-8?B?WFIyRWc0Y04rOWxzRXB2OXVER0grczNRREJqN3J6ZTk2b3IrNGRSV0NFVGda?=
 =?utf-8?B?MGNmZ2V5NTVvSVdUeFVHdGxqMnEwaC9wZmM1MGFaaklQc051ME0rOHc2YmlG?=
 =?utf-8?B?ZlFNcWRDaFVYdjkxL3NwR1lPcXR4bzNsTEIxUzhGMFhSclhsWHAxRU1uZnl5?=
 =?utf-8?B?S0t2bktjbXFRUmd6OVFuTHdjYTJhbnd6ckhJNlluY3EyMUUyOWNtTWxOQUVu?=
 =?utf-8?B?SGNOTkExaGRwMERwZGV5d2xLRS9ZMCtSTnNQSldHcDRnUkZ1d0dmNlJlVEJJ?=
 =?utf-8?B?eGpZWkFIbHlNbW5PUUJVUG9FbWdHdVo0U09DeUNmbGMvK21pbTFySHVEVTJP?=
 =?utf-8?B?L1BNYjZiRkdidmZkTzV1bFFuV2JIMS9PSXZGRHQwY05ZSTZITTJ5SzdEaFJG?=
 =?utf-8?B?R1o4RVQ1QjZSL2tRSmVzS1pnelFHWktJSzF5am45a2V0WE9oWkFOR2JQaEh0?=
 =?utf-8?B?YnRqUkVyMkVYbmVpbDZLb3RhVXNpY1dodU44eVNXS2Z0S2dTSWU5Y0VoaVg1?=
 =?utf-8?B?NmhKeVZLOFEvcFhvSGZiemdObW0yS3AwNldPWDNVbUpCdmNQaVFWay9wdE5F?=
 =?utf-8?B?YzVUd2ZVMEhXK2g3cmdYbDcvanlieldGUy92S0tkelNkMWZBeER2NHl1MVN3?=
 =?utf-8?B?R2dpRnlaUjF5dUQyY3p2YWtZcjNVSUYyQ0JKbUEyWkFLWTJOQzdicFg1VGY4?=
 =?utf-8?B?dGlaME45TzZ2OHpPVENUcklKTjVucDQ0Q0pjaVozdFM3dnhCQXhFMFB3OWgv?=
 =?utf-8?Q?yzDL11v0o3nVyVnyQOCAkV9Iv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de220dc-51ab-4ec6-b093-08dde9f4cfaa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:46:22.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2as8ibFA8n6oZ+RPhOxCOcVPpJwE1KKbQVAUK3j85okr0ALCSmFHpTw1LOevTNqZj26FNTpEWle58jjiDdkH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
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


On 10/08/2025 4:22 PM, Gregory Etelson wrote:
> The patch fixes `ifname` parameter as a character buffer.
> 
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

