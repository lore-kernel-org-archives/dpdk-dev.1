Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA3E9D3FB
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88CA8402F2;
	Wed,  4 Feb 2026 16:10:36 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by mails.dpdk.org (Postfix) with ESMTP id 12470402E1;
 Wed,  4 Feb 2026 16:10:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvDw/liygVUjRJyyu6PzLHJ4cvM8mAPW+8BB64BZ0Rqe6Ul0+VZknc9PuIbtjjV1mf6wQzwVeibar9bO46VKdZ7XiCvKcDMcDPdXqFAY36HJCHZTdssH2BNS4idGLM4dRnEPTmRvr1P/uH/ivPyHW/BekJV1smhbrus4KA7qM58PpnfRH/V12FkfQ1SQQN5KwQLv03ZPlkzwhU7lUOewPiNyKHHsVtggD3C9UTt/WrS8xyCCiS5AZGDKarf/Ph7631g7hbz0GDeJOJlxJoAUT5bJ/JCwCaqubM9fr/ccNRmgMt5yVODaMm6SSvWmKfGx66mK2r+9b2Av+MSjx6TsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsgAbbcpdIhObNkQz28p73/kvWmMmsnIA4gMcTmGSlI=;
 b=gx8QKygvzevFDlq6/JZu32kHFmMnYjwdhGvsvOZK2plHbLawqdAUPiIPct+xd8yGQvOUWG7FtIF13JNoKyTmc84cHNG8Lu2eyCe+ay1ZdT3kjz1DA9hzZHW7kXxhydFMusdxHCSn6zaHHrOnhe3QSwPrfFZnH/vFfJliR4BBgQxzup0u+o4nb8XgpcFyvIP2MrlKauTWxWWuT7QQiFcXS34Xl4duXVkESkEuDW6Z/RscTDcDIOl6fZNKN++6EfcLN1cXdy4LpuBdijn0sdbRerMNg0H7UAbQxfnL269imceInfzCjTbZbWVOjA5ORTXlqBi12strg5KHjnK5xsCfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsgAbbcpdIhObNkQz28p73/kvWmMmsnIA4gMcTmGSlI=;
 b=RR49WcIKYsXwlSESVLLSfEebYDqIMJE7KomzCPF8Y5Q+Hjr+kyn7m6gfjUJLi6+AIjEzcoM4wJjpDIA9wSvEOz0t/DJFGGjz9Hys04eTNA6RD+sv/mR3UOTcVJFkfTQNAqROeBUbv5FtdWG8qijWYKzo+nxvSTE7sY3I6Zr37GwK7AsaM1R3aLcWDYPPqXfPnNjvC1aDZZ0cLQoTaYPJ3EuraJk2vt8MXLIjA5DpZJ3HMoXXFWZj+8D2x6bc1hyIQXWQ0DjqShBz6QZw5ZDelVOC7On0rkEGr1OKTM1gYViZX1/GgLQDf4XI5SVOxi8SNa3v34rvIgFKOVuVKcAtCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 4 Feb
 2026 15:10:28 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:10:28 +0000
Message-ID: <49e01eee-513a-49ca-ac6a-8466ba2203c6@nvidia.com>
Date: Wed, 4 Feb 2026 17:10:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix register selection for metadata between
 E-Switch and VM
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251201173628.266032-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251201173628.266032-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: c31cd12c-e04e-4444-829a-08de63ff8775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW9IU2tzblMvN3VwcE9BekpLNE1BSWNja2pPb2x6MUxmNk1LdXZobVFDSUZs?=
 =?utf-8?B?cWNCYkJDY0xweGFoZEFBN2loVjNneW0zT2dPQStyWFNUUFNhZlk0TWFONElE?=
 =?utf-8?B?VExORTNPZ2piTmpHSVZtSGIyVzlubVpJa1Z2dHZvNi9Jc05uQS90Um1oTXkv?=
 =?utf-8?B?N3VHZi81MFBaTVlqZ2haa0ZsU3drVS9kWWw2ZS9KaENxMlVHNGc2QlphSEd5?=
 =?utf-8?B?elZad2xrTE9CYitKOXlCcFFvbDU2eVEzUWhuSzJ4dmtjai8zNk1FRGdlSVlz?=
 =?utf-8?B?Q0xjbDZadWNoVmJsZlRhMDlPRGl2YjdoZjhGZmFhandkR3pDaStCYnRkT2dm?=
 =?utf-8?B?Z1RBM3k2dGUvN0lHT0FIMTA2Q0htQ1llWmVxS1kyeStqcHNxcXQxVjZaMjhs?=
 =?utf-8?B?Q0hJU2hnall0Zjd2eHpQZ0ptUHVRUlEyZnUvTWhqaldBY2pxcXAxbnVOWURu?=
 =?utf-8?B?QkNVcWhzRHhnQm81M1c2V1N0SXE2Q3piT0x1aDdCU2tpa1IveXVwbUkweHQ3?=
 =?utf-8?B?eVRqQnB4aVR3dlViUGw3VlQ1L05VcEZZUW9EV2V2RDB3SXQ5ZkpYZnZYR3lW?=
 =?utf-8?B?UWlITEhkZXZkMXBvMEVYYjJGdGE2ZzFtUDR6b0RQUlFiYVVsT2tzU0N1VzBZ?=
 =?utf-8?B?UGtOOXV4eVJ1Zjcxd3JDM1AxdzBRUEtVNUFMMUVIMUNYTnhHdVhWZGxDM2Y4?=
 =?utf-8?B?TlBhVlhIUFdRdnpHdCtzZTVTTVFST2NxNVZyYUxGeEJGVjRzRHV5a0Z3NlBM?=
 =?utf-8?B?VGg1UmFZMlQ1eUlQcGhEd1Jyem9ZcHoveG9uTERTUm5GelQ0LzBHKzZKYXho?=
 =?utf-8?B?TnE2bFV1bVB5cnVpQk4zV0x3WEkxc1FzckZVdjU5eHVlNHB5cDU2YmM2bWlI?=
 =?utf-8?B?ZDJ6cktiS0N5M2JnaVlPb3pDK0lWVGorUjJ2N25yZXA4MnEwUVliUTN3RlNa?=
 =?utf-8?B?RmMxZW9sS0xSQzRVRjZ1dXpMZWd3THJXbEpSa1pxaGUxbXBDVFlLSnpMaWhu?=
 =?utf-8?B?NFZJbjU1bGtkK0Vvb2o4WVdCR0w2NGZSOVlpQkhLdmVjQkVpc3o2OGk3Mmpm?=
 =?utf-8?B?d2l1K0RWbEJQbmtxOTZSTm9kTjUwT0hiZmNxSW5XaTdjenRUUzFkN2xoaHNk?=
 =?utf-8?B?SHhRM1NBS2JBTmc2Q0x5cEdvR3VaM1dGQ1k3R0V2aW0wWjBxYkpMcUZtN2JJ?=
 =?utf-8?B?aGVrTVg4emZITU54OThyRGZrZ0tsQ01TZXdtbUZkZWxYRHN1NFhybk44TTdt?=
 =?utf-8?B?amlSNVFxOFFHaFpqN1pyYWVMeDhzTlRraHhBMytxLzFWcXgvY2g0ZVVZeEZz?=
 =?utf-8?B?VU1OdTlCY1ZKbS80eDdMY2lWbjcxRy9SZmg5a1VRVXFWWWcweUlKMTFoS3hn?=
 =?utf-8?B?N0Q1bzBLYnQwelN1VHptUHlJcEltVU5ScUV3RUw2Tk5mTzBhS2RoblBLckxp?=
 =?utf-8?B?NUE4N3lyekRvOVVqM2JzQUxnd3JEN1l5YmtTWHdSdlNOYnVqS1VYcHlIZzA5?=
 =?utf-8?B?akxXdlhCQ05hUnp1OFhrUDNIRGxQR0V5NlNZR1h4UGZTbXlSbFgxRGdTZGJo?=
 =?utf-8?B?Rllad1N5bEt3blpublc2bVZpR3lHRTlXc002cGFXbyswSCsyYWFsWWxIQ2Fn?=
 =?utf-8?B?M3A4YmhSNytQWXBHaU8wa21LWFRsYTNUazcwR3FuMnZqSjh4R3g3MUJtbW5m?=
 =?utf-8?B?ZCtRUXBZOFRBKy9nQ1FaR2d5eHZHMEhBTEFHNU10b1grTUh3c3ZocE52SE5R?=
 =?utf-8?B?QytQU0l3enNDMlR0S0FJNnZLY1E4RXlJb3RwbE95dVA1ZXVyV2c2VXBHMFhu?=
 =?utf-8?B?YkhjR0p4Nk83bk9Sdm5GemF2M1dJTlJFUFlHNm50UUNSVWZlc3dlaDdpM2pQ?=
 =?utf-8?B?QTgranhuSnMvdHlBSUpkeC9tV29vSVRFa0xiaVd6ZEhDVGhsbVZGTVd0MTFr?=
 =?utf-8?B?ampjaTVZdmx3QVNqcXN1Mm5ZMHJuTXZLelgrM0QySGtvcFZIWlh6T2tzNVlu?=
 =?utf-8?B?Q2ZHWUcyVkxibDNyTHA1Mzl2eG4vSXpVbHpESFZCaW1iYUJPV09OYklVUm5v?=
 =?utf-8?B?RFNpWC85VHYyTllkK1E1TEFYMk93eWdiaDgweWdsZmZiNmljL1IweHEwN0xT?=
 =?utf-8?Q?bf18=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXI0akc1RG94WnJuUDFYem1lcnFkaDhqYWRXbGFGandMVStDMmVjQmZZMHcw?=
 =?utf-8?B?bjl4WjY5aUtxV2t2ZGVzSXZISlNacUk2YlVVQ2l3bTFsNUVmQU1iYXgzRXNX?=
 =?utf-8?B?c0xmc0ZFaGVFbS9wRU1ONmRRaW1Cd2t3OGRXWnc5eFRqQ0NtWWlvSXg0RXlr?=
 =?utf-8?B?K3gxOXJoN2tNbHJzdTdpaU84WWViYTJ6eEdFZE1RU013YzFKd3kybXhaNlVE?=
 =?utf-8?B?VzZPSlpUSm1sVDRrMTJDTDZoMFVlUnpqTHB1WGJkTVBrN25hZVI0a2dselR2?=
 =?utf-8?B?UnVKRWJ1dnc2UnV0VThZTHZyUkYyMlBzN3lkbEN3Q0kvY0Vzck1tbkhtSDJZ?=
 =?utf-8?B?L1lNL3ZJMzlYc1B0UG9ScDhBSnl1ZDVMQ25SeFFUSVJEWXRIaElMcTBDMUxi?=
 =?utf-8?B?NC9Va1JpVVQ0bS9oRXZ3S3JBSFdlRkkvOUtUQkFKME1ndTN3Sk8xRlQ5STJX?=
 =?utf-8?B?NkJkN051WEZZdGwwVGVNdGJEQlV2VVgza1RUV3NndTlYY0hOZDkwUVBxd3dt?=
 =?utf-8?B?RkY1U3RIaEFieFNycjk0ZGszV3hLT0NDMVUwQXd6VzNRY3k3MzB6MVZZSW1y?=
 =?utf-8?B?bzVURVNFQk1OaXpHZmxRUnlvd21Cb2RZWCsreWVwSElhcytVMjN1Q2pSY3Fp?=
 =?utf-8?B?eTFoY3RPZWNibFkwdjBKSlMzQ29ydkJ3QlF1MTJlSy9mVk4va2RBMVQzT0hI?=
 =?utf-8?B?Yys3eVVGOTRJSVJMa3h3bWJSSk9melo1d213dDJGeHZnYWJrN3Fadk5qZU1P?=
 =?utf-8?B?SUwxRm03dStPUkRVU3VWRUZWdHFGSnQvQmVqVWtQcnpPVGpZSHppOEFoeHN6?=
 =?utf-8?B?aFNueDN4eWpVVTlHNE4wdi95SGJ5YjBnRGEwamlnRkJGNGhlZ3hCaDRkWHI4?=
 =?utf-8?B?MzBUeVBlMENiNFZkZzRFZnE0dTVwdzY3cVpkRjg4SVlyR3hya1JSNHVDbWJT?=
 =?utf-8?B?S3V4YXU5YmNhc29MY2Rob2xTcDJmVUZzWndtU294VWlMYXJMckJIc0wvbGFP?=
 =?utf-8?B?TGNKR2Fob2d1WllJc05SaGZqd1gyTzArQm1ueXFsMWppNWJheUtsZXVnRlZN?=
 =?utf-8?B?UmxQZGhINGtXTEMzZnJENlQ4K2o5dnJycm5UN3YrUkhsaFZTY2NsRDZ3Q3ZY?=
 =?utf-8?B?ZHJIWlBQYlpjN0QvYXFoMTRNdENKVFhjWThxNnRFaVFjNG5kY013Mm5kd3hW?=
 =?utf-8?B?QTZhRncvWXIydVdBU2k4N1pyQWlyR1RCQ2dKL2pkcjAwQWhLRlg3MFkyQUlu?=
 =?utf-8?B?ZS8zV0JWc2RIRzRlM0E2NHhQNVo1L2t1ZFU1RmVQOWdONHJTazZKNVZJaU9M?=
 =?utf-8?B?MGVhUHEvMU1OZ09hVEViTCsvQURHUm1kRmFkYkxFUWR2ZEVYUlJqbGVldE9P?=
 =?utf-8?B?QWRtQklsNjI2RVNRTXNZUVp6UExiOE1HVHF2VVZMTHBHdS9WbWNBYWVYVFVa?=
 =?utf-8?B?NGE4SVZFOFIxcHVsQU5QeUdNVHNocVIxQ3NRYXNJVEVrNWF6ay84U21zN3Qy?=
 =?utf-8?B?enFpQkYxUmdkUVljcEpHckRxcTN0MExCa1ZIaEhBSXJGaldWMkMvWTArNFV1?=
 =?utf-8?B?aitOSFYyRDhSNEtNcGJWQkxxQ0Z0cGxyWW14d3poYkZRQjJKVlNLU1k0SGlT?=
 =?utf-8?B?cjFReDR2S09rQlZhMkowa3JQMEh2YVB0c3lvUmR4MFo1bXNBTm5XWDJkQVMx?=
 =?utf-8?B?eHN6TGJYY1k5eEV1ZGNhVm1xR2MyVWxCMzNEMzZmVHltRkR3T1ovTGxCU1B1?=
 =?utf-8?B?L01WRUFxOWJpWjdpMGlHNWRtbm1ldExMRUxSai9WVjF3TVVaODA2bTVUSGg2?=
 =?utf-8?B?Vm5oaDVJZmJ0Wlp1RTBFQ1JRcWloaEhvYXEwNTA4bjN2Nkl1dUd6RnNEdDFW?=
 =?utf-8?B?TUVnN0M5cW5GMDB2cnQ2OEJvNWd5VFZLMVdqZk1pNXJ4emcyNEY3T1RucHlO?=
 =?utf-8?B?Q0FxeWcxNmh5REsrbUpEVUhEL2VxUFpWSWxSbDVzelpjYjhiUG1XWkRwa3Zm?=
 =?utf-8?B?d2ZWS1o1VU0zRjNnVVRVTVByRjR6K1kycUpJRTFzM0ZVRVE0NXRicVd6eGhq?=
 =?utf-8?B?QVE5aVNXT3cza2dzMkxRKytqNDgyUnRzcUdVY1JsbjJRSk0zdEsvWDJ0S00z?=
 =?utf-8?B?dER2NGl5YUZuRGR1Ry9uSVBLYUcyOFVkdFZaSHhWSEpkRCtoWHFVSnQ1MXF1?=
 =?utf-8?B?RkMzeWdoak5XUzlybWhJMllmSGtzcWx3L2NVL2l5bjd4WVdtRFE4YnNmazBH?=
 =?utf-8?B?Y2RGSUdqanpaek5zblBOazBDc3Z0c1RSWUNOZGY2R2MrTzVNdEc3TC9HZFdX?=
 =?utf-8?B?bFRUMVJkUEVVWUF0U0M1T0JDY2Z1d3BGME5XUGNRMm00VmRXa1N3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31cd12c-e04e-4444-829a-08de63ff8775
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:10:27.9393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK7JwH+hYdMSXjUdkdjlpbOLa5cKvsU0KJAIuV9xbw+Z+fLyWqw70FDpZ/DmY+P5lLlnSAShqBJtCAqO33hVIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
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


On 01/12/2025 7:36 PM, Gregory Etelson wrote:
> The PMD relied on a flow domain type in register selection for
> modify header action that assigned metadata value.
> 
> In the HWS code, the PMD uses the MLX5DR_TABLE_TYPE_MAX instead of
> the exact domain type for flows in group 0.
> As a result, the register selection was wrong.
> 
> This patch fixes the register selection logic when flow metadata
> sharing between E-Switch and VM is enabled.
> In this case REG_C_1 will always be used.
> 
> Fixes: a78425ba3793 ("net/mlx5: support flow metadata between E-Switch and VM")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

