Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E3D6E2D8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 18:39:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69B7340275;
	Thu, 18 Dec 2025 19:39:30 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63]) by mails.dpdk.org (Postfix) with ESMTP id 3F94F4026A;
 Thu, 18 Dec 2025 19:39:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBWU6YBXQqWDYJykjKcmjhtoAkZJimIx580GLseU2RdCtTEnQokYQkHrBt0E2fS2dyLJNl+GleV7ahe21Qs7RbLPTEy61/9auX8xjbQmntj+3kywrqxJtTym99Xl677nGN9ZYqOUolqq3svO7aCpljdBfx9dUkKwcujvFcP3NswLKN754VjL3kRVIySNlmEHwDwUQfa1C1zahB+HEnKryOEcmf45Rr2SmnGTnmYpmpcWdG2vNH3SlR9JQDVCYklbdKrY9vTiHpYzLR/AEwCB50GUldEIse8zYGjwQtJdgH9pKYPyQED2njKp+IEZTu8BeZStr90GMou2p9joniNCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfFYBpmSCzcUi8JL/VcoU9SMwfUFlNTN7pWk/Rjp3Ak=;
 b=dp+TvvYb0HRzVnw+uNk2G9QOfm+JYcHh/pHfMhWZe+hzcRjKs0cu18vQlxU7wHP2UL351mLPn/CxeqPdjwMpobbmsfGsN6tXT8pJJh7tcEdEGokNYbWWhUM/Ac+feM0YYfFw1vLknCXC9ApDOaMwnAaXdtQKcRBfiJofB05ipC7XlENxto0IbxCZPBGbtPseH7XJ7iFMBt5T288IGwaCOgxECtdq4mGYXWhqeV94x/BWHvzVhTL+4uyzya5zZE46SnPahC8X1OOlraxccxuBWkdvyT1yoJWyKqB4bIpumAKXqsPXfhLfyNjMHl81ohzZtbzw0+UkpQIrTN+MZpfT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfFYBpmSCzcUi8JL/VcoU9SMwfUFlNTN7pWk/Rjp3Ak=;
 b=otpO4riEnKYqhOpum1gM5A1YHzedvr7Eg/GICpM6OwR9kfnQCs84PRWYLwDrMuyXznolgWl2VF4y+uQrZUlZ8s9NGfpVFxvuxXsd2GPZLpiJvt/qu8boJsrSqyeZVQGDRiC4P3EQeOG7qrtWf0XSXJ3VyIxoMvjDBAke5eJDPxlELuQR95mYVePJ0CaXPg2ycFZIhPgZBig2QdOgOtDVcZ2T3thp1dxZR50eq/ZWj6F9o6ItZ4qzOe027H0wWevMuLdWSp7BIQtEAqVmshFz6FXEEDvESmgQ1TfQ48VoTPcrT2MiQvHNKwZYXvTDpboPs6vkCBHTAmN3+BSlcaTq4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 18:39:24 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:39:24 +0000
Message-ID: <c44f831b-9d17-4487-9ea7-258104284dfc@nvidia.com>
Date: Thu, 18 Dec 2025 20:38:56 +0200
User-Agent: Mozilla Thunderbird
From: Ali Alnubani <alialnu@nvidia.com>
Subject: Re: 24.11.4 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com,
 waela@nvidia.com, sbadawi@nvidia.com
References: <20251205095931.160577-1-ktraynor@redhat.com>
Content-Language: en-US
In-Reply-To: <20251205095931.160577-1-ktraynor@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: aae5808b-ce6c-4cdb-89c9-08de3e64c3cd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZOblNJWVk3MnlUNVZyNndjOG1VNGk0T202L29weG5nSG9RMzdJaitHWFFV?=
 =?utf-8?B?UGNaNGUxVGVvQy9MY2JXdUxwUEQ1NHlFVURQeDJmTlFOakgyV21wV0JxYmpU?=
 =?utf-8?B?ekZ6L0hFWVhoRkNHNzZvejYybmppUmpTbmZKdXdSQU9sMExMN3pzZFFBb0dh?=
 =?utf-8?B?cjhnaEd0OWlHMFFQN3VhOVBvQnEybFZRVXNWdFByUzF5T0Voc2ZBZjZIbCtO?=
 =?utf-8?B?WTB0MnZZeGwyeWVDUjhjUW1ZMXdFMEIySlZEUUVFSUVnSkJOaGlRQUNaNjA5?=
 =?utf-8?B?dHQwdTlNbTZIUUIrTC9XZnAvT2VkeE9Xd1Z0Lzc3SzBXVW9tN1djUE0vMjVy?=
 =?utf-8?B?bGZOL3ZLS2NwMGgzU2JwZWV6Z3YzYk9kL3RpUDMwZ0x5MFpSUktjZXAzbE5I?=
 =?utf-8?B?UFNuMEtKL0hOODNpY2hXaFpzNm5KN0I2aCtnZ0JYOXZPME8wdFdDY2txeVBz?=
 =?utf-8?B?RndyODR5VXRwSTBYUkQ2TXRJUkN5UGJ6UUhZMGhESmdHWU9YVzBZSGxEOFJ2?=
 =?utf-8?B?bDZCak5QbHpNRzBQWU5STmRIdlpBRGFRSHFPdlV6YUJ0WjJSdW5wS1liZEFY?=
 =?utf-8?B?d3pRa3NLaTlCeVZhNGJEM21pSFcrS1dhdEhMMG5TUk9NR1E1V1pqZm5GdDVw?=
 =?utf-8?B?RGt6bTNmcU84TGRSZjlrL3U3WWRCNngrMVhLM2hnODJhV2hFWDlHWDdLdTBX?=
 =?utf-8?B?YlU2bmpVN3dPZzQreTJ1dEJFWjd6WkhyQnpyV0J2d0xxcWtyMDlUSXduTzBt?=
 =?utf-8?B?REFSbTRMNWFZR00zZXdLbE1NTS96MjhxWEc0dnRJajBTU2t3UVpQNmVkMnQ2?=
 =?utf-8?B?WjE3TW8zL3h2NTJWYjg3NURlekFBR05lcUhiWWF1SUpCSDhTOGl1Wm1qaHNj?=
 =?utf-8?B?QldaRG1vZW5hN2M3dkV6VklSdU5XaG5HTDVrSkhyck5TTXlvRE4zREM2cnla?=
 =?utf-8?B?U3BDbGtaRDBTNStWaWNsYlhBUTlKRGwvTHh6cituNDR2S2N5SVoyRkgreEh3?=
 =?utf-8?B?NDQ5UUxRMnBvUndDb2tIVWQvN1FqUGVEQ0l3ck5zdjBpRC8rd0xVbXdreml5?=
 =?utf-8?B?OWtxTnEvenVMQ2lLY2VQQlhoNkg3UU9yZ2ZpWTBDbys1T1VtMm1lOEt6bTZw?=
 =?utf-8?B?bmFyL1I4bnV0S3hSSXV2K0VpalRTd0g0Vmk2aThsRmFpWG9vTWF5L01SZ21s?=
 =?utf-8?B?ZmtzM2NSbnpZRStISlUreXU1RUVCSVplWnMzdkJXYm8vaTJxZlZmL1RYZVQy?=
 =?utf-8?B?eGx2c2ZLV1Nnd2wwT3RwcTZsK1hYZkxYYU5iYUgxVVZwTXpwMlU3WC8xemNs?=
 =?utf-8?B?WmFnZ3hwQ1daWFZ6UXEwN2VWV21OVVlEQ21VMWFIMzR3UUkrVFVZOExSR3hD?=
 =?utf-8?B?K3BCcGpWWEN3dXo0QnUvQ3c0WlBZcmhhT29tdmtqQVVvQjYrSTdMbGgrRnA0?=
 =?utf-8?B?TTVNYm83U1l5c3AzVURhNUtaSVhIaHZwZndkZHJnRzZ5NWRnN1M2NU1yamV3?=
 =?utf-8?B?c08xUEpDUmNWUkhycDRlb3BQYmpKcnVtMENRK0NqcUExd3pCVWdjR0cvVWtU?=
 =?utf-8?B?eTRiTHRMK2t5Y2QrdHlnelBxVE1UeHZXaVkzZFdtZ1B4bXRKQUJrKzA2eWhJ?=
 =?utf-8?B?bjBMSEovVU1waHkxOTV5YVhYMW9FUktjUmc2QVh5bWFGTHF6TWdMWVl5emRK?=
 =?utf-8?B?WFJEZXM5cHVBaVZNZkhaUnA1TEZLR2ZGZVFxSy9qZnltR2trNm9wa3lveEhW?=
 =?utf-8?B?QmFXSlp1MHVjZC9MZGJwUU9yWEVYZnhDOUxSSGhZVzRIMmVtSUZ3ZU04T2p4?=
 =?utf-8?B?N083NUtXWVRjTXlnK2NwRFhMR3MxNXIwSVZCT3ZUOGRyUk03UTJ6azBzbXQ1?=
 =?utf-8?B?WEtGT0E1eU1Fd3M5UHF3SDBvOFRmdFN4Y1FwQURXUUc4OFFZWXRKcnBUOVg1?=
 =?utf-8?Q?Iv9oE4dSejKArvaaPXIwjQQyKsBNHwuT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDkwNWd1RUl5dTRuTUFjVmVPajcrcDh6NGgvYzVoMjg2emUzVkdDSXg3YTcv?=
 =?utf-8?B?UTlqUHJWd2ZpREh4aU51RHFRcS9VNmgvL055Y0djTUV2TWJYQ2JqYTFwYmRm?=
 =?utf-8?B?L3hZdnFoby9JazRiT1ozZjJ1UDd0U0d0OHFmZ3Z0bTNxSDVFUTRpdTgveEs0?=
 =?utf-8?B?RS8rV0dsN0psV2tYSmUzNTl2Y3pWTVJqNUFSMzg5QnQvUGd6NWJwRkZRQUV4?=
 =?utf-8?B?eXRNSHJWUDlyN0t4YjFMYmFTOGlucHhoeDhDTEFZN2VJa0FvZ25Rdk9QQVlS?=
 =?utf-8?B?ZWxaMzVBM1R3YjBmYWw1UUpnNThMeGFReG00MFN2VHQzSUZWOVZ0bFc5d1Fn?=
 =?utf-8?B?dDNGVzU0ZUJYZjg4V3pkVkM2WkZDKzhrRHNESGtMbGI0MmF2L1lPdG1oeno2?=
 =?utf-8?B?RW56THFzNk5UTUtJM3BqY0l4cEx2ODB1cS9iRllTQnR5a2V4bndsdjlJaDI3?=
 =?utf-8?B?ZmFEL2VtdDVrNmhJNGdrU0FLbkFnWGl6Y28rSENBNDJueWhYNlZpYUpyb0I1?=
 =?utf-8?B?aklIYWdaakhudUJ1TXI5MW85dk1sL0E0ZDF1SkIwTDBlTjRUdUZCUGg0eG8x?=
 =?utf-8?B?WU0zdGdQK0FlVFpoVnNqYTNOZFZtM2Rpem82OW1OZ3pLaFhxTVhSRXRBTzJJ?=
 =?utf-8?B?RTB1WjJqaFJwSjVIZTIxUE0rN0R1ZWRHcGpoWmhBYnF2K1lHd3Z4NW04VmVN?=
 =?utf-8?B?eGNxMm9aRVlOaDZPNVZhd0Y5MnlEWk96cVh2WjVHZ0UzM0wzM0wxU2lIWUFT?=
 =?utf-8?B?Rk5uS1RBQnBkQXg0WkxBMlQvVDVWdFlEdjJyeVlGbnhGc0svYUQrbjNjTk51?=
 =?utf-8?B?eVpjd2FOUXFsWldLLzJWem9kM1Y5VmlTVEdJM2F0bzQ1QXpkSzhueENyM2Nq?=
 =?utf-8?B?dHZRcUtBNWYyZ2g2MXV5NkM5SFY0aXlBRjBFM0VJOHRkRk0zRzZpV0MxT0hi?=
 =?utf-8?B?MGdwcHlxNk5JRVA3Lyt1MFYxb21lVHRSekE1RXVxMGZEVGtTVHNuUUk5Z3Qr?=
 =?utf-8?B?T3RYK0t0eGVzelJweFdSbFBBODNSL1VheHlnV1FKYmtnbG92VHo0aml3a0dZ?=
 =?utf-8?B?TXFNa1lsc2ZGclR6R2tzVk95RnNwVHlaZmlKd3VJRUJpQWV2UVhJRmJqbkx0?=
 =?utf-8?B?eGNUYUxSSFNLWHlsSllxQ0pnZXl2QWQ5ZEFOYVFqNXZhYmRBeFh6M3oyU3JM?=
 =?utf-8?B?VGR3U3FrVW5KbUJ1dGJ1c0RKcnozWnBzeUZmN2tTVm0xcXpBQi81WjVCVlYr?=
 =?utf-8?B?SnhDclhpTXZGTGdrbTlVc2xqZEpwcS9WaytjN0RuSmxYSUt0Zm56VENpMFZp?=
 =?utf-8?B?alF6Ujhmb3ZnNVFRUHV2QmpTMGpsbFBmNGRrZEduMExyMVJFQmprMEVxZHFV?=
 =?utf-8?B?YVhSS21HOVBOdUJ3ODR1RCswY2JIM1k2YmpicUs0NmJLNVN0SEd4UW43R0NX?=
 =?utf-8?B?dDRSNVNqRjNrUFZFRktLemZvWXF4KzVNYituam9XZXBCd3lISkZKSEFLN0tV?=
 =?utf-8?B?MXdJUG9oTC95WURVNVBTWkJOYVhGNWZMcG45MzVKQkNvaFV1T0NXd3hQVHYv?=
 =?utf-8?B?RHNHWXdReXhpc0dkb3EwZnB2TjJDVEdqdE9Tc2pXYUxlUjhHaThaclpZaHE1?=
 =?utf-8?B?a0RaR29DN3JyTmdGWldFa01SZUtRYTAxUE9FT2dUYkdSUURWa01ERHI3M1d2?=
 =?utf-8?B?R2t5Ulp6SG1Nc2ttaUo2T1Y5NlpEb2VWQ0NhcHkySHluejNaNDh4SVpYa014?=
 =?utf-8?B?ZlJvQ3VTQ2tVZktwK2xyVUlnOFNRTnE5Vk0zTnNmWXlTVlp4R1VVRWNJNWZw?=
 =?utf-8?B?N3V1SDBxMHRPa29Xc01tOTVORThBNE1sU2Y3QU0wd3VySGl4ZW1TSWZlUkhn?=
 =?utf-8?B?WSsyejIyU1B5V2MvRm9sQXVmTkZqNnZ3R203a29weDJvbGRaWm5HZTNNMFNr?=
 =?utf-8?B?eTBySWVNVnphNk9haXA4SWhaOHNTbEFFRlhaY09oY0V4OW9ZamF4RlBwQy8v?=
 =?utf-8?B?eFgyZHVPdmtoZ0V5YnVIcjEzR2NvVkhxb2Vhak5iMGYxajVGbXlucE1Gc1RF?=
 =?utf-8?B?UVNFMGl3cXNYbTNWSlVFS2xYVXpUa3ZBNzB2SStMZ2kyOHdHaTNCMTJVNUhF?=
 =?utf-8?Q?61wtT6eMNXHgdPNCkEgeOLzFE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae5808b-ce6c-4cdb-89c9-08de3e64c3cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:39:23.8879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOMN5Gqczs4bsu1Qtgve2tN6egOCIaLhHmAYIMFxPm9fKWR0y8YOYGM4lmj/Bnu3C60Vupp93FfjX5YVXOAQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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

On 12/5/25 11:59 AM, Kevin Traynor wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.4.
>
> The planned date for the final release is 18th December.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.4-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin

Hello,

We ran the following functional tests with Nvidia hardware on v24.11.4-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver: 
MLNX_OFED_LINUX-24.10-3.2.5.0 | Firmware: 22.43.3608).

We did not find issues caused by changes in this release.

Thanks,
Ali
