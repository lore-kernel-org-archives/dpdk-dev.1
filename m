Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B045CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 12:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B7A40EE4;
	Thu, 16 Oct 2025 14:12:25 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by mails.dpdk.org (Postfix) with ESMTP id 3497340EE4;
 Thu, 16 Oct 2025 14:12:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGoRuWIU0oz1ZStJqCPtmS9AdvGBFZsUck0Ad2qEyVwLJFTicDFaM9a4iorMVSwxR2RJwAtt9xhHHajeHexREXtGtmHeLIjy3aOvBm7gaQuimqd+EAlqDapCUNap7wMaqBFSNDvcEz3+zBit9WyJkT6gnbY1YgVEnWTr4Y4OuMd+LBykPi+QZYALhuub6VqHnEKOLKeFqKoCjiaIMB1BGONg2Cu51Tsj68gqMsG1x8mZbHX6jRtiyZOHKDQ2QVZTjhcwa6V7wHm9u016t7KcdMcJg4iTaVHvt6TxP0SSwhjLiiT/EnvFc7W1hV5q1SAQcEWbdRIz1IPvOX/FxG1a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fabdB4tz7gas1ykH7gZeCfq7JoItWfzpTMRUNtvL+es=;
 b=J3/GspxAoNN1WyvKlZ/QUS6o+sa9Aax30N1FlC3J30F6Q+h53MVZjYfY8OuJw5vHJ6h51qgFoSVCHb8MX/FovmesgXOsx6mEKY/HUliuc7Cakzbx9okUgUBrIZe97kllt5X6uRewBeeP0EEo7/y8ATfzsGrZfRoeaxW3rlMRLhStFguONRgl0HhlQpZq22V5hoRSocyrssqKOEdOCs7GQhBotfFeXj4V5VLvCOVMAbNPwYOIf1yqjczwFiJDpP4s0xuMBF57D0I2VJW+/mYPAFZLRs4J8SVEFqrPFrGLGxp9a18Z6suw1wqq8bzIqOqE3Empo0DV7zvmajPcpATQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fabdB4tz7gas1ykH7gZeCfq7JoItWfzpTMRUNtvL+es=;
 b=oxMqx2SuRVILIuLozd6WvmU1nOw7E/aJJic47+XPdG+bYTUt0w2qYF7ePS/0e7KphpGZ6n6pbX98buefX6RxJzy60LtJNIwg8UDEOfB9+S6pEOkRdskg1fxfHMNTmlFI9RAHzBssXAYW01a7xpXCFnt7UxwISiQLLHLzmGsoIeQ6EpraBUeqR9VYHAT0/P6WTQ09YLSrkaDmjMrGjSMhM4JuXfihOIUj7eAzAbCVfu5G+YH0Wen8XsZ3mM2b8YmYlh6/IT8anpfvsXTUB2QHwRm5/eDEDsNYJ6NscLbY/n2/niQYw6ca3ANf25ljtnDf8RnzVhJwIruZXSiMDEw3wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 12:12:22 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 12:12:22 +0000
Message-ID: <5c967597-0466-4d7d-aa65-89d064a6dddc@nvidia.com>
Date: Thu, 16 Oct 2025 15:12:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: release allocated indexed pools
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Roi Dayan <roid@nvidia.com>, stable@dpdk.org, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251005072346.66007-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251005072346.66007-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc47eac-314e-4339-ee6d-08de0cad4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlNYaXRiYkVtclNaY2RCSk0vMUJBNjluZnNVVmpZM20vd1Jyd3BFTTV4TlFh?=
 =?utf-8?B?ZldEUzN1UkRIU3JacEhSSHZOUklyTzh0Mlp5OHdOVk5oS1hMQVdoN3RaSzdj?=
 =?utf-8?B?eklXUDFJS2lPQkNDcDVQWkNMVU40YVUxdGt4YWZ3TVJva0IzZWMyM0d4Vzlj?=
 =?utf-8?B?Y0tPNTNwT1F4QVk5bGJqY0s0cTk4MWR4TEo0NWw1bjl6Y0JLN2RFbFk3Z1kw?=
 =?utf-8?B?TVJYaHlOZE1GN1lRcWNna3Z6bFB6M2xsdzhqSDVxd1JuRlZNMlFuK3A1RjU4?=
 =?utf-8?B?cEwyM04vdjgwNnh6bEo5YkU5eFlLN0N0c0JQWmxZbFlXUlp6NllJV1diSXpL?=
 =?utf-8?B?enBpZlkzTWRTWEp4RHZwSGtLemFyL0pWSHdSdlBtOXZkYy9nQWZvLzZwMXpz?=
 =?utf-8?B?c21tUVVZSW9XUTVNYTFFLzFFS2dsZzB6RGZPdVVwbW83RlVjOXYxRXBWZDBm?=
 =?utf-8?B?T2VjU2dTTHNuYkI4djdpano1a09kaEZVK0lDOXRidTV4eE9pbHZsMktOOUxr?=
 =?utf-8?B?ZnJTMXhFenFQeG9hRVgyekw1UDhhNWQ5VkJjNkYwRU5wbnZjQUM4UzdEOHVK?=
 =?utf-8?B?SVVvc1RIUTd3b1Y0cHlZbE1kN3VYelNJZnlaUXhpQ3JiTjVPbE12RjlGam9s?=
 =?utf-8?B?cGlkeHduMTNjZndUNS9XTVdpVmNLM0N0NHZ5ekVjQW8wTVRraERYb2xBK296?=
 =?utf-8?B?TjlxMG1rWnE3YnowajFEeUMwOGxSNnVHVFlpdjJzMjlZMy9aa3hsKzdVTm1B?=
 =?utf-8?B?dzFkbWlkTlM0VHJQK0NOTkpPeitGWmdLaDdDQ1F3Qk1Wb0dtQk9yUHdWK0lT?=
 =?utf-8?B?blN6RGJEY3hyTWpBTldhMUxSTHJiWG5PT3F5Tko4WWNkUlpPclZlaWRDM3g2?=
 =?utf-8?B?OFBJOUpLQUlzdzVtR1pYU1J6TmFLdm82RUw2YzZKL2Ntbzk0V3FuMWFEdEFT?=
 =?utf-8?B?Mk9hMlpXTGM0UjFMN3JWTzIrSjJYQnRzZjAvMlhRTGxrUE9ubkhQdWJzQkhD?=
 =?utf-8?B?dVByMlVjWXlnS2lKcjQzMXRKT21RdXlqQ1RwcS9rQmJLOUZXYWpVU3Zlekhq?=
 =?utf-8?B?TGoycEgwNnliNThGb05sYVVWQTlubDM5UUdhWlhLZHdTbFFBeHRnKzZUN092?=
 =?utf-8?B?SktSN0c0Wlc4RXFCeDBzQWlOZDFWV3hnYWpqekVQUy91QTQyaHpRMk8wRXNO?=
 =?utf-8?B?NE5mRXhYWDl5T002c1hUSzF4eWFOY3BJNUJWc2ZxZlBMS0FTVFNyYjZ0cklO?=
 =?utf-8?B?cndHTzU0Znh6bEN0ZUVPbXlhK0hlQWU0TitEd0FOclRQVEFlS0NFa2xkREtt?=
 =?utf-8?B?NXZTd3lSQWhkWVVucm9jUkx6bTVmK1pqYVlFQlU1S0FSUC9rT05aR1QwbGlY?=
 =?utf-8?B?NDAwQUE1QVhaTWJFL2lWckUzVHRGTzIxY3M1T1JZTFFZdnFFMTZRQWR5VzFw?=
 =?utf-8?B?VTBkZWg5cnV0bEZFb2YzMVZXVHhvTE1oMzNJR2FhejhweXVuL0VKdkV0Zms3?=
 =?utf-8?B?aHlib3RKbnExT3pFMGJGeUhMOTArdXR5UkNLOWhyNk5XaHpuSExMWWhOdjZw?=
 =?utf-8?B?b3h0aDRqUlJIeWx4aHJiMVdWbmV6WVRJMGVxbHVlSTQ3SW16YzNLbDJtcjVx?=
 =?utf-8?B?NzlmUGtQd1FleUhVcjZqb3FBcjNWZkhUelZad29XbXliZlAxVFVNRjNBdml2?=
 =?utf-8?B?Y0VWVWVFamVDWXA5RlpYdUpUblU1VHdGL2ljT2MvL1MyV2dFRzIranlrdTZV?=
 =?utf-8?B?RVprQWNOYnpZVGFFVW43QzNldVI4OXl5Rml3M1ZLbURlWjcva2JRR2IxbmFi?=
 =?utf-8?B?eWhUQWxXVnYvOW05Wjg2YXc0NW1aTCswL3N3eFJJODM5NHhOUlhyTnpybHhU?=
 =?utf-8?B?SGxSdmRiSEtjOVJYZ2N5MzY1RGQrUktvTWE3bTUrWkh4eUNzVHluQWJCcWtT?=
 =?utf-8?Q?Y4NNPM7EBdEGAA3eTRH8oWWcPHQBQNID?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWY2ZjkvTWNkL2taK3lGQlhqRkw5WjI4Wm1mMjBZanIxQzVsVEkwMFAyOGhQ?=
 =?utf-8?B?cjlXdFVyeURMWXZQU0VDZWh3TDdOdFAyVzVZcmFVd29tRkZ1UlQxL3ZkYmpu?=
 =?utf-8?B?UnByYnVGUGIyVXh5d0ZsTkpBYjlaMkpMUFBQa1lBbzZseHE3cmxPc3NHbXc4?=
 =?utf-8?B?VXBsclZtRmNZRE9NamUwOGIrbDg0VlFYK3JLemtJS1MySXFlZ1BuS05XaHB0?=
 =?utf-8?B?K25oc0M5NElISnFMbWNjQVZZUGpHTlU5RmNkQ1ExMDNuZHhTOXFCa0NrNWh2?=
 =?utf-8?B?QWZrK0xKUVoyZFlDQVFmY1cxOXdzaVJmNFlPRVlFR2RuaExJeC9pQ1VKclFp?=
 =?utf-8?B?czZGVExjQjVCQm1QZzJRcjhyTGQ1bnlVRm5Fby9FYS83NGR3YjRpNFpxMFUy?=
 =?utf-8?B?VDY2aG5ta0RBblp6RmFYNWlSelB4MENadUdTdS9BUnY5SloxSnNFb3h4OC91?=
 =?utf-8?B?cnROenZweGp3a0ZQaHVlOGZhM0pMVTRMckh4T3dwSUFoZ2pBV1hNSFcrWkRV?=
 =?utf-8?B?Ykw5NXRYUWcwZ3Y4Uy9xc3o2WU5XUUpENzFHT000dnVPc0FyTVQ3WVpJVE56?=
 =?utf-8?B?MnhFbFFLZGZlcXNhd01tTVhJRC9TdVhJaXRwOXNyVXpzTlo1MFNxNGF1OUNz?=
 =?utf-8?B?MzRiUHVQMTdhczdIa0NuakhGOTRvS0hyOXFpdm9LdkhIRzg4N21NTU9IS1hx?=
 =?utf-8?B?R2xvMC9vakFtemtBRE1lZDd0MkY4QVVKUDZabHpXNW81MjRVaHppT3VVY3RJ?=
 =?utf-8?B?M0lRTE05UFI3aFFMRk9HTHkxSkRXMmVha2lnS3ArNzUvTGZIbGtMYjFoUkR2?=
 =?utf-8?B?YXV4NkZoT1BJUndBb2dNd2g4M2I0MWlmeXJUaFpUVlJwYndKYkMzNHZrMmpo?=
 =?utf-8?B?OWx1TDFsNHo1OXplZ2FjRXQrQ0U3TURsRzFzei81QUIrbS9MNzBKeU5YbFlV?=
 =?utf-8?B?MVJKNndZNTkrcEkzWWM1cVlkOUF0WjVoYmZBSGVLSGZmNDcwc2lEUi96SFJ6?=
 =?utf-8?B?SnFIcWE4NW1RSVpTei9mZzJLODdMZmV2ekR0Q1hEWXBieGJURmsvMnRWcHhX?=
 =?utf-8?B?QWEvQ21PdU9nTENyRTA5TXBqMDI5cE9PVDdnblAvejJtYllEUHVIU2ptZlVo?=
 =?utf-8?B?V2F6QzZ6UjY3UjcyRkxtdlUwLzk4M3poUVRtMU1mQVFMNmQza1UrWU1iQ05D?=
 =?utf-8?B?NEdBWXBpNkp0MTE5YjJNeTlqWG5hbXJ1Z1p5ZzBIRXJTSGx4NXJCL3pVMTRH?=
 =?utf-8?B?ZFNNTFZRV29iSVNuSG9IMEl5T2NLVUk3ckZiYXJmWW9od3VPYjRaRDBjbUU1?=
 =?utf-8?B?b1VmbWYvTUxacUFQNTZabnhMZzJHYkpjMkVicmlNZ0ZqN0hKVGhEeUJqaUIv?=
 =?utf-8?B?eVJuU1ZPZklUVGQyVFRDU0Yxc3ZYUjBtNU1pQmZFRzQxSnZhc1NRY3lyalpk?=
 =?utf-8?B?U1loYVAzVzlPOVZVY2FIMUVJT3ZrWHFPaWtPaVFla3FQczVycXc3R2RmMnI4?=
 =?utf-8?B?c2N5T1ppckZMMGR3MXlObzBPSTJEd1pTd2xiVTg1OVZLL2EyZE9uQS9BY3ZI?=
 =?utf-8?B?MFJ5V2RxU2RsV3JGWWdLeHNLZWhtdGRSRHhEYVRXdE8wYklzTjRtc0hVdXJi?=
 =?utf-8?B?Mm1PTm9CNy91alVXTzZLRlR0Z3pKZ2x1RWpRZllPRDNCOE1HTUFpQkFlRjhF?=
 =?utf-8?B?cVpRNVprdys2RlpYclFuUlIzWlFtQmFSTVpJakZoZW1vTzNicFBOQ2h2aXI1?=
 =?utf-8?B?dU5kM0UzSzlNd0xrOWszSWJvc2xESitYd3FaQUxsVVd2eTkwL1FPNEE0TmRD?=
 =?utf-8?B?WGpYZFlkL2pnZ2lVNzFwVEpMckh3ZnRhQm1xc2xnUzdUVGEyWUoyYVY2SFVw?=
 =?utf-8?B?RnlxTjhyYnJLSjNZNzJOc05TS1kxdjN4V3ZBUHI1ay9TOHI3dEM3c05semtL?=
 =?utf-8?B?Nm9JQmhkQndMcEFyRXBjSDBKSmEvdndlNHhVdll4SDlqMTFpRmwwTTZLaWdw?=
 =?utf-8?B?NmVtYk9PVjZaaDRWTkdteVBFenNObkQ0U0R1b1Z4YysxME9vZjZsL3dYMEdt?=
 =?utf-8?B?Y3UwaklOekdlZFpWSTFoQnZTWjVlUFNUNHorVEVLbXBIMnhBdmdrTzBIaHVY?=
 =?utf-8?Q?ySyAAuYEfL5pqHdO0cLBTdwzY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc47eac-314e-4339-ee6d-08de0cad4283
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:12:21.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkJb8ct64ZWSDBJxkNrJrVvvZOAqjnPM480XjoLreKjTqMT9HCVuwpNZE5hsLkjYK1lUpTLKU25uwc+fokjxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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


On 05/10/2025 10:23 AM, Maayan Kashani wrote:
> From: Roi Dayan <roid@nvidia.com>
> 
> The cited commit allocated indexped pools but those pools
> were never released. Fix it.
> 
> Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Roi Dayan <roid@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

