Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1CFCDC19B
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 13:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 744DD406B4;
	Tue,  6 Jan 2026 14:16:03 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45]) by mails.dpdk.org (Postfix) with ESMTP id 50C8F400EF;
 Tue,  6 Jan 2026 14:16:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di/7dCvTaBSDiZy1DEwzxJZo8z6WTalXv8vY3ysj1O4KTHVcLLQZym/n1BvnnKoD4ERk2zYJ+YEx/+JQSax5Gy3c81jZVPaFHwurCo91OCkV2LYZkIjwqfFb4EvVbGcWMswz8s9qLU+05FF3DGpvAze8Q9XH7zf9jSadCx8cgR7PqpEm62kcAHMq+/1aNCfl33RFk3fyqzsphCBRmfzb0hx1tvC8XDjBSUVn2hJmI3DzcVnbl/X87IB5Tkobvc/UuW8Lp7+6iGg1Fydxt5rSp65ADHnht75tn1tNHzs4X+nPO6/5sxeBTrAq7u66MGUPQ/sDekeVjGGIqYvDenC9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7voScxzKAwdDaHTT3lMlWMRDZ6kKsJTOddcrYotCOw=;
 b=TSB3zdlNMcCBwg1Ba5V4pq91iDTFCDjCxydAS9uq+Ozzk3dPbQdNR+Lj+NSxZb0vdIUf7WtE9M+Go3TL7IosT5vd4LT+WNq4xfyWqKNa7rUavpLFe1QbmF0m9Ab6shrb6UDVSDt5rRenu95JRybmSmojxxP/y35tMKEl50PyCo0Tp7PnywcgmsCEQW1C2/Jzl/ozUZWa58lhNZQsOPJbLPM6Rfvs4iVd5enX/bWtShQuOg1qZokdhkgNbxII4l7pIQeZuW2NCsBu4GYXR8Y/rBQk66rAdyETSYSr4ZAeE56cFyPhWXWPE5YVLrS5ZdGM6MbVQY3/QEBxHIh/n5Nlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7voScxzKAwdDaHTT3lMlWMRDZ6kKsJTOddcrYotCOw=;
 b=BweIEV0Hjx3CgaXxBrO1KRjY3paJgDuTlvk4COpgZq2oibw/V7LvNgLntMCHLs5NPqDeXKPBHJL4gVv19xptLpnPMAtlZcdFP8ekYJFoO5V4zYsLZwxKANW9O5aWhEX28oVW0bzmJs5MFpZsrEOp80u/PLiT350LjrT7NzIx9WbUj2t6S5W3K9lOOfC4ZQ9mX+veweo+zXBvaV1yfArBvqYRgkCxEK9Z3cDtuiYM5DKF75/fspPGuTtOddQPqSz/Ay0AHpYXRlheX+/6y5ErRj2wiJC1U2hu4y7RirUIbaE4RFwtLW06a9/ozltuYpC263X9ftUj4pgzKJ/kXQDFYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 13:15:59 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99%3]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 13:15:59 +0000
Message-ID: <368e8769-4b02-43b4-9b4d-3460a3571927@nvidia.com>
Date: Tue, 6 Jan 2026 15:15:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix MPESW PF probe
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, Gregory Etelson
 <getelson@nvidia.com>, stable@dpdk.org
References: <20260105132941.72705-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260105132941.72705-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 242b214e-b3c0-4c94-1626-08de4d25bb7e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlHL0ZBdWRWWTkyU0RnaXRQOEE1SVVxZWl5aGl4NkNsUEphNUpNN2xOcVZN?=
 =?utf-8?B?MzFsUVhLR1NFVmoxV0M3Z1ZZcUN2b3RHSWNIbkVqWGlvTENZb2xFeDVLODB2?=
 =?utf-8?B?djhQeEhjbHNzdzFuTndscmloN0JsQVRDdjNkOU5qa3h2QVNJcFY1NDFqWkJy?=
 =?utf-8?B?djJFMklObVNaNm5JaGI0NHhIOVRCL1VFVFV3bmlJNnp4K1EycjVBZTVmOER3?=
 =?utf-8?B?N25PVDdyNzdLMkl6ZFZRSUlkd3BySXM2QStYUU9qcU9xWXhLdU5QeCtteW5F?=
 =?utf-8?B?VHlOUEt5R2hCQWh6a0MwRHF4blg0eFowa3lEMUtnWi9ESjFEbVR1VVI0TEEz?=
 =?utf-8?B?eWZLMUNTNEVjZnYweENvZkpwQmlONzVFQ2Nnemt5cnVQVVNhODNnc1pYR1Nq?=
 =?utf-8?B?Y2dreVh6S1lBbW1Zc3lWRVVOMFV2TDZ6WnBCb0FHSng2WUtPbVZ6M1M4Y3dV?=
 =?utf-8?B?eE5MYzU5RDFoYmtBSTJaQ2l3enM3YWJQUElkcXZ1YmVDWVRIUUpaR3huOWNo?=
 =?utf-8?B?MmZMck9jSFhGM2p5RXhDU2VPbU5ENTEvUjdpWlZrTGZCOW5LTDNYTStxNXJO?=
 =?utf-8?B?OTRIUXlaMGRvaDZubkNBdCtSMTRCSTdsL002V1U1SFBkWTZPcnFIREdVZCt0?=
 =?utf-8?B?LzRlL2VCcngxdEkyb2FEVzJDdVFMVXQ1Y1U4Y0xGeVI3Mm5zZ0M3aVVkcjRk?=
 =?utf-8?B?M3F3R0R3OWQxMzFuSWYraXlDMmRKTFhKYjZyRXFRN0hrRGVTU2cyZ0V0QjB2?=
 =?utf-8?B?UURLeHdzQm5lM0xoc25tY2Qya0d3aEpoZ3kxU1FScTNzemIrZXlWV2JHNXpl?=
 =?utf-8?B?TkhsbitoUjZjS3QyUDFkMnVhdHIxRWZmem9nSy9IdE81M1RROVlKWkxLWjZY?=
 =?utf-8?B?Z280Q3cxbzF6UGIyK09jZU45dzdXYkJyMU9SeHV3UHk4d29zc1ZTTkdsN1d4?=
 =?utf-8?B?MVdmdFY5b2oxdzJLTXpSUnFCRjlUNXJ0ZUc0MXFXUGZ2YWZDd0o1RDNEK1d2?=
 =?utf-8?B?VnBibTRITURkVmhCc0xaRVAyU3kyYjJrMmdBU3Rkclh2N2VDZTJYNVNCdG96?=
 =?utf-8?B?cWFOelByaDVNU1pWZ2hNbnlISVBsTWRCclhyejJlbjZqeEhSbDdPL1J6WS9H?=
 =?utf-8?B?Z1FCSU94Wlo1ZTZ5Q29uL0JEQ2VqdlNFaHNSTlNscVk0cWM5QWFmR3g5ZkhR?=
 =?utf-8?B?UlFOaHh5Y21TeklpVjNtYXQyK1FEcThSRXZWYzl4aHpHcFBQeklLdVhJS29X?=
 =?utf-8?B?TGF6bUM2anRwTkM0S2VBWFdmTkdkRWVIb3dsdWVzektlOVV5ZDBZb2k3eUxn?=
 =?utf-8?B?QkdrSjZvZFc4Q3YwalFNdE9COWxtWTJneEt3U0twc2QweERLczc2enRDT2F6?=
 =?utf-8?B?Q2FFN1R2Vm9nbWl0Wk9RY1ZaZzVndjUvcm1Tc2ZoOXZ4WmEvK2tXT0pBbHNo?=
 =?utf-8?B?ZGpuLzZRem00T3A4Z2pIS01LQ0VxZ2Zkbjg2cnhwN0Y4L1ozdXRKb3ZwWTJK?=
 =?utf-8?B?R3YzOENodUs4NEZVVHR5QnZMTHR1cVpROFRJcWpHTDJWQkVZTHpvajhCTGc4?=
 =?utf-8?B?T2djUTJ6MUMvUzRXQ0tMODAzQjh2RHZMektZOUVWVUtkNENoOXlTR0lZaDA1?=
 =?utf-8?B?a2pTUXNwMGo3MHJPd1BPSTRCZWtjNWhhUXhjbldVaEpQRzU1dkpnVm5LdjBU?=
 =?utf-8?B?Q2gvd3RvRk1wNGdRZmxTRi9UUzVnWDA2Q2dYM2RqZktNR0NoVHU4YVdISnMy?=
 =?utf-8?B?ZVRVN1ZJTG9aSDVWMzMvZlNmZmxmMWorbTJRVVpxcmtDU3BUNVVSQU16VWpH?=
 =?utf-8?B?RlJlZXU4Q0pKeW9UVXV6MjEyd0wxNVp5cEJmUzBhZUlzVDZWd0U1SFFBZUZN?=
 =?utf-8?B?MUdDMjhMT1lnMjBnUjFVTW1XUmVPWVczUDk4MjRYVzljVGV4ZzNzT1dmOXlE?=
 =?utf-8?Q?0JF6LKDCXT+lCS4RB8OGZL60iHjHFtDj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KysrcVlTMWNKN0x5NmpydEtScDRaT1p5M042KzhmRGRjMGxVeGwrejMzOXBO?=
 =?utf-8?B?S1BhT0NUZ3ZJZklHN3pLQzQ1WVdyQmN3TXRyYWZjOURmdzFUWW9RaGc4cURr?=
 =?utf-8?B?QitXekNVdXZTN05ybXprMnRBeHpiOEZOaFI4OFpzVUxKNTQ2U3I5WUpaWExj?=
 =?utf-8?B?dHNEQkYrS3JBdDBTZEdrWWZLa2t4b0JWOVMrUXVrd0pMRUtVL29YZlRXWnBC?=
 =?utf-8?B?UktWNEFncGtQbkhobFF5c2E2MEVoaUpoYlduS0VuaWlvSGh6S003RGVtSXlK?=
 =?utf-8?B?bEdaZUdQOTBwbzJMOExneHV0Y0hhYzI5alRtcXNBcTZDbVAyVmNBamVSUzZa?=
 =?utf-8?B?RFh3NWJHMEc5VXQ2S0h3VlZ3M2ZyRE00b0dBVWVvZDl1SXhQNEUzdS9hT1hL?=
 =?utf-8?B?a0FMaytzcGhjMkhDQ2cxaTVHMFJQL1hMUEhRWHllYlNLaXVGOEQwWkZGMWxR?=
 =?utf-8?B?eXhIREp5Zk5oYXBhT1FIcGNIenhaRWpldmtjR3pPMXhldlozdys2U0ZsZ29z?=
 =?utf-8?B?enR1TWxUMExzYWlXUCsybmlLR0dENmpMV3hRM0NjbzFPM3lrMjYrWTVrVlJ5?=
 =?utf-8?B?dzFZMmI5NktEVHI5ZFZGM2E0WjBNaVJ0dXFmU3NPZjEzYTEveTY1NmJINnZv?=
 =?utf-8?B?S1ZXQUltVGtYeVEvWEs2WnRnbFJYeGY0TWVYMEpIRWpKTVB4blM0MHRRQmhp?=
 =?utf-8?B?SkJOM1B3S3I4MTlLYkNtNEltbWtZRU9yTGM4blQ0ZDBETnNPek56dW16akJG?=
 =?utf-8?B?cEMva1dScWFFNzlGUnNLOE04dzlhOS9tajdpdXVVakVnSzVXQkJCQ1d5bTZS?=
 =?utf-8?B?cGI2ZkFsWTVkZGc0Wm52RU1lbGNvZnVjVU1yellpbjUrOUJkbkpCa25VWlFi?=
 =?utf-8?B?L3JJSXl3SEFUN2VXTDZkaWoxZUxFOXJITXIrYnpYS3UwWlc0aFd3ZWh6UFJF?=
 =?utf-8?B?ejJKYVBvR1BCUVFMMkR3OHNDaGVpSzF3UHJkSmM5TWRVMWFBc1RCUjJLYXFy?=
 =?utf-8?B?R1hJejZJb3dhOWlUa0VxQkllenRpMHBPQW93MnovaDdybER3QVZ0blJ1TXNu?=
 =?utf-8?B?Z2pSOWRVZVNoUWNwYkZpNy8wODlSZjRnd3ZRTFdJOSsxSUY5RllQT2ZKTWxO?=
 =?utf-8?B?WVorVU9Gd3pTVVk2ZUFRUHZzWFRiUm95eW03VTk2U3NpL2Mrb1ZFcmFpMm4w?=
 =?utf-8?B?K3QrODVvZCtkemMzM0xPRGRaNUxacmlSV0NuL0ZadmRETHdRb2ZGNnR5VGZB?=
 =?utf-8?B?NjFFOGFUWndXL1lwS0RVMnY3SS85bW80SlR6NytkeVYyTXdOejdrczk0OExt?=
 =?utf-8?B?SU10V1huSDBvdjdIcUxZUHdZaGtoUXRFUlRBSmhzRjNEbS9NUFFkQkFMVklh?=
 =?utf-8?B?b1VibC9pZGY1VG5ieHFlNm91VFdsWXk1YUM1amx3MWRYeExpSi91UWZJcmI1?=
 =?utf-8?B?T3ZybWZZUCtLcmdTYTY2UnhsTXhna2hLemlidXB0VnhPQVRZWUU4bDJvcEFF?=
 =?utf-8?B?UVFSQWh3Q1Z3c214d05NVUNBeFVWNGtBZUVKV3pDa0hZTWNjREU2VW8xeXdD?=
 =?utf-8?B?N1huUkJSY1NCZUJ2RU9mZ2NpMkNESXhlRjNiL3ZIQlZrbXdzMEVtbDJEWk9U?=
 =?utf-8?B?Tm1zYjF0RHkvaHVFa1ArMFhOV1pZTUNmamhIUXhxaEh6MWJQTlNSek12ZndH?=
 =?utf-8?B?MzhOL2c2WW9selZmZDJiZGtya3NjUWcxUzYrV21JeUZRWXpzSnI1eHVGVmdQ?=
 =?utf-8?B?QzF6K3IxcHJ5bGRPanJ2QTRvVVAwYXc1UG1XWk43Zi9xTmd2S21rRVIrK0VL?=
 =?utf-8?B?dVRSK2kxK2pWdWkyTGpHeGxFNmhndVhyMjZldzNYL3IwQ1pyTTViUmFybE5C?=
 =?utf-8?B?eFpybFZab0Y5RGpxdndRMFF5c3NHYzY0UXBWRVkzZlNLdWlDSHlBU1hQRHFz?=
 =?utf-8?B?YnBRVzI1cVR5SkdsTjdkY2h3NVBINTJYQ1NZRUdPT0laY0tscDBjcDdXOUV6?=
 =?utf-8?B?MGJGamR5ZkpzNzc5V2pMQ2RFNFB3SUFwWU5zNDUzMnlkeXZhWFU0VGVkREhU?=
 =?utf-8?B?YjNrcEdLdjBycTQ5NzNaOVVVSWhWMGVnOUczMTE3L1I3UFVrSGVQSHpGalQy?=
 =?utf-8?B?emY4VlhpTlRKb1kwTUdaaTljU3QwdXNrdmRVOUF0dXBiMEMyU0VUalFxc0xJ?=
 =?utf-8?B?eDJydkJxYllWcmhVNUdhRFBEMGpSaVhEV29URUswRjE4MU8zYlNPbitQNTJ6?=
 =?utf-8?B?V0lvR3VLQngycm1yL3JlS1lLSDN5MVJLK0lSNWlRVGlsdHBZRy9LMmc0VzIz?=
 =?utf-8?B?eDVyL2RpbUVxOFZQNDJwL1grT2dCQWUxV0prZDFnN0k4V1BDZFZPQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242b214e-b3c0-4c94-1626-08de4d25bb7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:15:58.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00Z9KTprIgCdE/Xp1xoKuYr0DWjRHVknjpssdFjAyf3BhD2s1FDN/b1JCx1LgrBrFkOQ27DeXFDfm8pdclpfqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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


On 05/01/2026 3:29 PM, Bing Zhao wrote:
> From: Gregory Etelson <getelson@nvidia.com>
> 
> Current MPESW PF probe was designed for interfaces with up to 2 ports.
> 
> The patch can handle interfaces with any number of ports.
> 
> Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")
> Cc: dsosnowski@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Reviewed-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

