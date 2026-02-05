Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F3AEC1EA6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4588540684;
	Thu,  5 Feb 2026 13:02:01 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2D0A84026D;
 Thu,  5 Feb 2026 13:02:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XckbyR86u1cSD8HxGTwQNGgEW5rOV8TT98xtyxqMa2Yb8janlokBuomfvO07VgmemEz92TLbxLz5hGflrc3Qq2OCAjSbnAkn0yp+CNBlMmPAWxNv9hc6xJSng8HmkCYa/Y5Tqo49MNifIyAipDMWBoG4Vwae6ydEeFZDy+YIh/vsyO8kJqds+TP3yhD64dT5Els8sQhFWPqK16YvzTocSPbccI0cKrRKiVZmc2lT4xJmYtUmo/6R1x3AjMe3zmMV7BNdObiplYNkLrP8VcPbLZGDJSxrgols1sBa3aGMc13J5PzzKqtc5NGCTn4w4kbtMTgI597sdUB5p2fGFnpYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKCLUg5ygizpLMJzrgJbSexXsfrxrlCdnG2ON1vTDPc=;
 b=SXlTmlP7OgxbEsyyTKMSSpvqWZ9bWSZh6ioN1DX2XjuO0FWS7WAb6pAWitEH1dtIVYUUtd0+C+Ni1nAPghH0UzOtX2CuGMQO//Mp7IarhQu9rB//wcg8iuoepXa+z8hmvmzgr9i3s3L+/agN1VCjDxQRQhjb2nF7nuOR0tqRdBCHE4B7c/0isksBFTdEqHqCVupT7GoB9NBEgalSiwdjy+onOqD/e55FzcMIFQKaPMXz4SSqRLUb2GfVYgHbtSs1cm1s60AIRffgg7CvpCrf1I7olvtI2+4CsIchAIYgSnohAasJEr2dIMQ1rer1AwBJKO1OljLrhQKJb3+SdpOYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKCLUg5ygizpLMJzrgJbSexXsfrxrlCdnG2ON1vTDPc=;
 b=ZUpKth9i6Fs5wsZ83OhTt46+fN98H2on7UTmUioMfZo36fRNu4BAx0nm6YNh17jHeHaMVfDc5clVWDugMcbOxAkVbVfhjxUml4Nj5EqClFsTBlL6MXNpXfCvvZrPC3Mam/vqvrkjbB0NItzTuN5OwTxlriFRVM8Ds7kG2t6NS38Nte7LMHntT9sYlXfOlQ+rHf3wTXrdVJFQ0iAN/zusqEhuKQcDXzVJSmUx5pBPnu9zWOysECNsyFoI0oRM+8sVlLiRmNhgfC7nRJUBcH+KVKrC/HZqJr7jzlBxMPwHT7XFxOXTCXFdke6IDQg1tltrayGLTSbXto6TS7ISIFpkFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 12:01:55 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:01:55 +0000
Message-ID: <11b98129-abe8-4fe6-ab0a-a227b007c312@nvidia.com>
Date: Thu, 5 Feb 2026 14:01:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix IPv6 SHR flex node header length definition
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251225110201.590263-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251225110201.590263-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: e480d463-e7aa-4b39-18f5-08de64ae5b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Smc3ZTZ2MzM3Y1gzL2d1OGJBRElYaWw2LzNjNmI2QytlZ01oOGFEcE5rTllD?=
 =?utf-8?B?Q3o1eENFdzNmcVJLdXJNbnJOUkJoTVdMTmdVYzBWbEJVNXlES1F6eFAvaFE4?=
 =?utf-8?B?T1dZNnE2RWhMeDB3ZVhhNGU0YVc1RlFKcjQyRFN0TXdUN25HT1dnWGNtbzJQ?=
 =?utf-8?B?cnM2NUc4QmNHYWM0NWRncVY3aWVPSUtuaFJSVk1EQUxIVWVZR1pINjRFT1V6?=
 =?utf-8?B?MFJGb2l0QzU5bERCYUtyUCtFdGRaOWoxcWQxMTRRSzVacHh5UW1CdUlTRUxD?=
 =?utf-8?B?c0ZIUUxYMEJUaTZBSzdadVN5KysrNS8zL3RpT1RmdFdnRWcvTWRXRWw5SHFB?=
 =?utf-8?B?MzFQSElWcXlHQk1vQUQ2NGVydTVHL0gxNjNSNTB6RGxsMHZMMzlqOWtGTW5L?=
 =?utf-8?B?VDBmbUhUeTFIYk5sSXRTZlB4VUg1QVJZQysvbytoZmRCcklYbmZzbFZ3UFZ0?=
 =?utf-8?B?VnRvb3NzQklxYnI3dzgvNzVSNzBVVXYwTmlCYlEwNS9ETzhTNzlYN3JPRTdl?=
 =?utf-8?B?cUNNdE1jUnNNOENmUktnUzBPaW5KbmNjeWEyUmhOS04wMXh4bDVIZTNlWURp?=
 =?utf-8?B?WldpSkhGSWFYc0ZKZVk2dnhTNllwTWc0RkZrdGlUYkMzTVJPNjNkUHZBQkUr?=
 =?utf-8?B?RTRwT21Ic09UQnNzR1psdHg3Z3JsUTJTNE9TdzVVbDNwVjRsRTZmQzZ5aVcr?=
 =?utf-8?B?dHpXRkMyYW9ycnRxcmcrNWsyT0RjUkFqYkcvallsenlXVkFmRHhoRFROQnhQ?=
 =?utf-8?B?eml0SVlmd2FlK3MzTWJCM3ljYkNSMnZBZ2pudnJZMlNPb0p6eHV3TnF2cjFa?=
 =?utf-8?B?TGNlYlQ5UjBNYU1SblZ3U3I3amtHYVZwUjhCaFdxcXJIZWY5NHozMktJcThx?=
 =?utf-8?B?cXFRb0o3eUwwSm83RzJ2NmNWUDhvUC9OdlBJQWovQnpHTWJCYXFkYzJ5cUE1?=
 =?utf-8?B?djN1ZkpXNjV1Q1pBTXROV2FRQWpsc2ljdGpCekxjb1pWNnU5SFRadzNqVC9D?=
 =?utf-8?B?Uk9XZllXUllpS0RNdGo0ZlA1VUwvWjlzK1pBMWtQUnlwSUpaMUw5OHJmNGNP?=
 =?utf-8?B?MDFraW90WkQvS3VNVTl2WTYzaFF5VmlNUlF3UDNPMTNmc2NpUS85QktvekNT?=
 =?utf-8?B?L0swbDI3SWlMdDRpT0lOM09QNVMzUUtwMVFQdGlMRzEzTzl3QVl2STZMMFhD?=
 =?utf-8?B?MXo3UUkrUTBYQlRkdVhiN2RkaVlCM3pYblNnTHp0a251VFNuNU1QNEVPblQv?=
 =?utf-8?B?d3RrSWgwL2cvaUVuUUgrSE90WHhTWW1uNlF3MmtzVGdxcmNEYVc5ME5qNWFK?=
 =?utf-8?B?UjMyTEUzalVrSzAyRndYaC8rT3JLOG05VGJhWG5qM1prU1JmZ1JUQ0ZFeFhT?=
 =?utf-8?B?b1VIOUg1QXg0LzZXWllpOHpDaXNYb0Q2RlNGSVhTcjZNNkwzd3R5RUVSV1Ew?=
 =?utf-8?B?MGsxVWx1eDZhd2h1NklBM09waHFtWnFtd29QTWc5ZSsrY3BzNDdpWmVaTjc1?=
 =?utf-8?B?b1FJSlVJcUtPVHQvVDJ6ZkloV0JOck5xSGhSZGFlRy8wamRaSFdnZ1A3ZkJ4?=
 =?utf-8?B?dE9UVHB5YnRCZzNxSkd3S04ycUYvbUI5bmZwaEhWVzRqZUl3RmFMaVI1RENr?=
 =?utf-8?B?YlN2N3gwT3hrUXNBV1ZMY2ZaSmt1cjhxR0ZvdGg2Y0xwSDRLUVJKNDNMWEFD?=
 =?utf-8?B?SFZrMDN2OGtNNzFWdzZVQUFnYXl6ZXRuMGFsS1ZZdldqc2RyWGljazdEWlQ1?=
 =?utf-8?B?S2srSFRVVlo1dFl1ZklnMEcxaWlUczh5REJ4Sm85WVZlSnU2OFBrZHhXVlZk?=
 =?utf-8?B?MDNwMk1xc2ZXZmdIaXRUODBpMnV1M1J4R3AvN0JTcGdXdENDRjEwaFFCaFVC?=
 =?utf-8?B?U0NaZWg0YXgxNVNFWnNNUitiSkJQSzF2Wk85STcxOFU3K09lTkQ0SUdIbGVG?=
 =?utf-8?B?WlBLM1QzTWpoZnpaNkNVT01aMEtQVThkM2xUbXJPeHRWZk9HUWcxUFdtY1FO?=
 =?utf-8?B?ZHJzVERoUmhpbWg0cUUwOFNlckdZU1FrUTZuOGxpSnJ2M3B2VnYwVThFK21z?=
 =?utf-8?B?cDZ5cE9KU3BJWW9KVm55YVUySzNFNnFPb2RsbWk2S0FibzhSNkFGVGJ1TGww?=
 =?utf-8?Q?X7vg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJRSytOY2JMZndlc1BYcWhUNi9EMHlmV2Q3S3JtSkh4WDNnWkpHMmNSc2hr?=
 =?utf-8?B?NVlQa293aFZtV1AxMmYrY3JtaThjQUpKejV6QmtVUXF6VTF4WjZWR25nbzh0?=
 =?utf-8?B?Sk9leE1ubGZVY0pYLzdja3Bwd1U0ams3UzhiWm9UZ1Q0TjdXNTFzNWpNYVVj?=
 =?utf-8?B?NURPL1I1UldqdHVLVG1Oei9SNU5pR2ozMVRVLzNraHJha2phSGlwWlpwRXpa?=
 =?utf-8?B?Q29Ebit1V1F3Q3FkR3NJTFZnZExYYVdjODFtOVRnVVg1eEFzYkJDZ0VuUGFD?=
 =?utf-8?B?MkF4TmZvZStSdEh4UlIzcWNJbDd0Q01icHBKWFZEc1F2ZWpLZEpUbi9mc1Bj?=
 =?utf-8?B?MG5ySDcxM0JCY3IxZUJSSVM4MUhkVUtCa3RCQmZVdENsQ3hUSklXaTA0T29I?=
 =?utf-8?B?OEFFcWwwSzVBckhFQzB2NkdneFo0U0tIZXBPdUZ4eE9MUTQvaWhZN241V2V5?=
 =?utf-8?B?QjhZVDFJVHg1SUJqeTh1VXNFNXpFTWlWNVNTSVJlS0VUdzRSMGRzVU9PbUIr?=
 =?utf-8?B?aG56QWhHM2h2NVBBeVNycGpXcWJFQkZDUWFzelBvWjNUTGVPYlJiVWR6Rmp4?=
 =?utf-8?B?Y1B1UENpRmpsaE5zZEg3eWhUdHdPNDhVUjd6alJiUlhuc2hmM0ZhTHp5a1NO?=
 =?utf-8?B?cUJRai93UFRLcHljb1ZCUWpveTAzVHlwMmhNQlFDeEF3YXFwQ0NlZ0dRNkRT?=
 =?utf-8?B?cGt3aDE3QlRrR080cGtJTmNmbGVCa2RZMFh0ZWZEZU5uS1cwbXRvK2xiVUNS?=
 =?utf-8?B?NUtOWFg4K0s3TWROWlhMUVh4NHViTEhXZGk5enZOWXgxekpPejh3VUNLUEhp?=
 =?utf-8?B?VnVrNE5nZnByZldmN3h2Z0JCOERsRWVkN2x2OXNvVEt5SWdZYTY3YlFLSmFN?=
 =?utf-8?B?K2l6WElTUFdFK05vSnhGR2ljcDJTNlNxZE4xUUdGUDliVmdTYVVMTXVuNHRp?=
 =?utf-8?B?RXF3enl3VGNTdmtiTVNOS1hjNjczWG44a3VVUm4vQlZTdzVGUnNYelN0b1dE?=
 =?utf-8?B?YWJMQ2Q5M1BYVm1lU0JvanZTSHE4Y25taHhOTncyKzR0UTBlRWFNR0lKc3Rp?=
 =?utf-8?B?MktxcUhTNFQxdURjeVRQYkdwcmt0elprSWFMbU53NXBmdWt6d2RJWFg0cXVm?=
 =?utf-8?B?Tm40ZWF1bS9uODJURkJyeXJjRm9aVnJIaTF5VU02VnJBTlkrb3RoSXoyc21C?=
 =?utf-8?B?S3o3YlB2ZUNpaGgyMlNiUCtiaWVqUHpPQmpEenRHUmpsOUdoWmt4SEpabmhn?=
 =?utf-8?B?RGUvQmNVU1dVbHVndFhVU0V5TVVxcXBmWExyMWZSU2dTV3dQN2xLZWNvbmtP?=
 =?utf-8?B?Qlo1ZUZQcWJqNWwwV1VLdFlCVkVicFVkNFFwczM2TDRvaktlak45dHg0ZXRI?=
 =?utf-8?B?ZE43Q2FQTG5ZamZNWmRURmNMekJsM0pXb0lLN2lvTFRrR1E2eGxqY1dSVW5G?=
 =?utf-8?B?RTRYQkF4RFJLVDNYZzJ0VjBqNW02cFdyYXI3akppbnhSSG9sUG9Nc2FJVXVJ?=
 =?utf-8?B?MkZaMmVqdWNsbUJoVDVJK1g3VU05bU84MHZTM2pIbWg4U05rWVBWUUN1UTl4?=
 =?utf-8?B?N3VMTW9QVmZ4dUVXQTBuQWpNR3BIQTN3RURQcUQ0UnYycEdUREUreDh6alpN?=
 =?utf-8?B?bDBYRVRSa1FaNUhZaUJaSlY3ZVJBdTVyV1IzTVVNWGRTYXNreWZ1NWE4d01H?=
 =?utf-8?B?OCs1L1BWZ1kwNGFjNUVpRlpaUFphdmw0RWRYTXVlbW9LSFJkT2Z6MEFYUGlW?=
 =?utf-8?B?a25GZDczYzR3c0xJMFFNMVRzT1Vnb2JrUmdYcWNzSEQyUmZNMjRwM0R2Smxi?=
 =?utf-8?B?NktkV3FzdjZZZTBCbEZXMmtHQ1ZGdDJRY0lxaU9aTzFZdmhxanB1OTlraysx?=
 =?utf-8?B?MnFOU1YyZS91bU1kYlIvSml4Mmo1cWZrRTdhbWZLQ09YK3RpcXpuNlhuT0Fr?=
 =?utf-8?B?NEY0MW5DRE1mcUNzQnc2elpnQi9rWkVxcnJkTVpOWUJMN3F1UG5VWlFEdEdS?=
 =?utf-8?B?MXNacGhQRTFXY3Zmc1pwakltcVJHZnlHbU5KemwvWTgra0E3KzdtYmtWODdp?=
 =?utf-8?B?Nk5pNnRCWWFGODBNdTBuSzZDTXpxME5PV1NSWW1BTjBhVmw5QWU4d1NTOFhY?=
 =?utf-8?B?RUFXZkRCZWR2aS81alNxWUUrY2ZNU1JUSE83U3E0bW9NeTEwSmd4WTRxZ1RX?=
 =?utf-8?B?U1Fxb1RJVGgyb29YMS9IR21GYVMxWmMyLzZ0aTdwOG42MGl3SkVKcGZYSElE?=
 =?utf-8?B?dmU5TlNwWnZqMUhGWHJiU0I2SUppT20rTVdKSDN4UXhYa05iZHpxZVFkNTBu?=
 =?utf-8?Q?DyaJreNbNxs4VyoX3/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e480d463-e7aa-4b39-18f5-08de64ae5b03
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:01:55.0916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcD+q76kA7dddLUE9Ue02lR084DXF4HF6mZ9yrCOUH1gyFlOpPT4myaWKKrGUoZvHI4gQaT7GNl+GNUVt3uZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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


On 25/12/2025 1:02 PM, Gregory Etelson wrote:
> MLX5 PARSE_GRAPH_NODE defines the header_length_field_offset_mode bit,
> starting from ConnectX-8. The bit value must match
> HCA_CAP.header_length_field_offset_mode.
> 
> 1. The patch copies header_length_field_offset_mode bit from a port
> PARSE_GRAPH node capabilities to PARSE_GRAPH node definition.
> 
> 2. The patch fixes the header_length_field_offset value to match
> HCA_CAP.header_length_mask_width.
> 
> 3. The patch replaces the static value in PARSE_GRAPH node
> header_length_field_mask definition with one that matches
> HCA_CAP.header_length_mask_width.
> 
> Fixes: a2234609bf7e ("net/mlx5: fix flex flow item header length")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

