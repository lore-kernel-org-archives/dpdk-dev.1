Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D47CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 12:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5BCE40292;
	Sun, 31 Aug 2025 14:17:22 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by mails.dpdk.org (Postfix) with ESMTP id 61B3640263;
 Sun, 31 Aug 2025 14:17:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWKoWPB34B4/DzOQPQyV84LIm1vLFBd+Oz/SdNykjCWMIq/V16Gct1tdHEBqnOzMUxf544RJmhJS9/lHpBgo7nGznZznXucEcL19F5B9j4yk2YicxuWgCToVK0pAfJq0KTmUNINquLk4tnG67UGB2c8WZ6vG4mnaDKl2KYUdvshuLfVAK0ERC3x0Vbm1Wu5RjkmPJCZ7GJrL4sI3lhqAKYUbwIWo8g15OIsjUHjLvI+oGYsUOhQK9z+vY2dTXM9Q65HQj/jyyXxilWbevQEm5BBYiu4RvrkQQaAUknkHLEztn3VBPnojDkGvjGsLjfjkkMkR7eZGutaAf8RuenK57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJqEEKlwwG+3W7gVOT8Fi6jUIU/1IY+IeaVx7PceIqo=;
 b=ZaEKiiaAMZCemnzMAK9ldiUTV994ApvTOAywvhiKT/TFnLcSYX8nef3IWHQP9bFk6755XEqkPcUGvxwwnA5sPMMaQIGADq6IbJqyI7QEP9vUQi+FUN9oUxEuY2MlExgbwuKI1xeyN/djPhQVRSEQprjkpHpk6dYz0uj+4GAHVTehz4tX/W9vXI/bz757qsV0NmVB779SVEHZgjfkMFQzC7n72aTeQ4M1oXeny6ItMwzBPp4ELhL0SMh9JbdVv2qSr6CqpFKDNhxGSCj0/wmaQH0wD5JZiTLcbAw1vx3gqrgDfz1psAeFqFgCmrzofzqoXF/jAEXCHJJ/cu4PRW7y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJqEEKlwwG+3W7gVOT8Fi6jUIU/1IY+IeaVx7PceIqo=;
 b=oEh1KskbsVIilD/HzyRTXtL6/GBNZssjaihrWmz5g1wzJPwZH83whsHjz3CUkwBIjQ2vhCBSrvYLTm18EPRIgkiVgfRdTFOHP/6oWoGdPXuynhircqwvSzN19aQM7R75Mr1LDmJPVEM5Kx74kJNwU25zIXKRs3Weo8QxSDmhdyS/K+ey8dT0GF9dIWMNjhZjwkD3zn5pBF522EnQytUxtYNW7Ml8FK3mzPjDybTE6tb0CX7xMUaVdS/tgm3+3x4010JAl3IN8+Ibms/rXH0BAULoxjlxdWJZj+eMBK/4rggADmofYF4vAj8Bvn860RbBaa/b9nTUNsQZDimjeiil6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 31 Aug
 2025 12:17:13 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 12:17:13 +0000
Message-ID: <39378537-68bd-46e2-8603-c6849f64de12@nvidia.com>
Date: Sun, 31 Aug 2025 15:17:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix TIR action support in FDB
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alex Vesker <valex@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250814132002.799724-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250814132002.799724-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9530e685-d77d-4453-8252-08dde888513a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU1qQ09jWFFnZjBjVCtmajFmU2VzRnBLR2IvZHRoajBtMEhxa0JIaHNGZXlk?=
 =?utf-8?B?YUZuVmJ6alN6VmFtU004Z0JUbXZYZGJDWXhHRndUTVdQWnFCV1pOVkFYTmha?=
 =?utf-8?B?NVNNUkgrMHRQR25oVU1JSjc4MitrVFZQcVJKRWJ3LzdvRmxGZ3RzV014WVJt?=
 =?utf-8?B?SnNYZ1ExMEY4YlNDUlQyL0N6cWZvb09QY0FXc0MremVhYXV6NkRlV1ZFalJG?=
 =?utf-8?B?VzROV093bUVQK0VMNFJyVmtCYkI5dXlQV1dPblp2TmlzdUNuNUR3dkRtVlpQ?=
 =?utf-8?B?c005TU9uK29qTFh5VExBZUFsN1dFQUZGbnF5OXVNcWk1d3ZHRUVwOEJGY3ZO?=
 =?utf-8?B?cmltVnE0bHFMOS8vVGZkMEhBTlVXa3hHWGR2NnZSQ3hiWEE3TVhlQ09kTHBS?=
 =?utf-8?B?UXZiaXV5R2p4YUJnb3psODBTSm5Ka3k5aEVreHJmVXovdFVlQ1QvTFJVT05D?=
 =?utf-8?B?djdPRnJxMWJhdGRuWE9nSHo4eVpzRDFpTk0vTWI0NFozaU5YTGgxZGZoM0Jz?=
 =?utf-8?B?aGhDcjFqZ1BnZDhCMC8rekI5ZGF3NGZSTUVxTVZoRWU3d0hyaExnU1k5YjlP?=
 =?utf-8?B?eGM5WWhLNnhpWXdyeEtEZVB1TEdXcjB4WXRsTzU5eDgwVEdiMjJmNTFFVFJL?=
 =?utf-8?B?ZHorY2p5RExMdEFzcldHNGJYOStuQzVmNEhuSDJsK2tCOXJNK3hrbEhQdU8z?=
 =?utf-8?B?VUpsSEdXVUJYV0Jjd0lISWplTnFZNURJc2dZampmc2I1UmZpRzJCUlhoK3Vk?=
 =?utf-8?B?ZVpuRXJ1eHJGVG9BR2dGaWZUNzg2cGhOeEVYdjlvTzI1VzhDVDdkN3MybzFV?=
 =?utf-8?B?UmwveDdjOFFTRmdjYnFHZWxXWnVpd05IOFhHQTBnbytvTEJMSVJkenJTaVB2?=
 =?utf-8?B?a3Q4Q3E3OEI4dDM5OVExeDdHMXN0cGFuczUrQld4SlI2ZjZhb0JudUlsWnlT?=
 =?utf-8?B?ZFFkVDFlZ2hyM3g5QmlJQ2M4UXEzU2E3OGFMM2t6enFkRDdZUExLNzRDWnhX?=
 =?utf-8?B?cmFzU0JsOTJsNmZxU0U1Q1JMMmI0OE5qZWtyb09GSUJQejNpYVJwUDhlUkFi?=
 =?utf-8?B?cUxERTQvSW1vYlpjdkRZN1lENUZ1NkpTTXlmd20ycDVRUFN0Y0lPanlWNEVD?=
 =?utf-8?B?OWJuNG5sa0VFdU4yaXZQNXpSOS9UdElrWDZnUmp1NGp0NjhpYlFhUldQd3kr?=
 =?utf-8?B?K3p0eWRnSlV6MXF0Y0dKa3NORkFDSnppMFJWbTVzVlMva2dCZ3ZkdWR2cStr?=
 =?utf-8?B?Y2MvMDdlUjdBenhURUVaREVOOTNERmRsY3MxMm1SVmN1dUs0QzZrNnpQMS9K?=
 =?utf-8?B?bGJkSnUwVExnK2c1b1pZWld6OTFkbWNEcUc0WkhuYUxYU3JUeVJKckFBMHRS?=
 =?utf-8?B?d0tXTUF0UDFDZnJ3Yk9XTk9lRFNad0dEM0J3MzlPdmZWMUhTUlFsNGVRem04?=
 =?utf-8?B?WGIrWCtLQk80Z3JhRmxKOUpJNWs3Z3psdVhYZk8xODNxSE55ekJTRzRjRVdR?=
 =?utf-8?B?ZEt6aVlxTldkNElEbVR5TVR5L0FPRkhUQzlndnVJUzhibFVIVDZPRjQvV0lX?=
 =?utf-8?B?TGR5ZjFKdXZuM3RwUU5BSUUrUEZXd0lVUVQ4amQ0Ni9INjNPK1JLeUIwNUJZ?=
 =?utf-8?B?V1hoUnhSdUlwRjJkV0VTcE15QVUySjdyUE80MjVhbkp0Q2diYVB6b3I1WnVC?=
 =?utf-8?B?UTR6RlZLclZxMm1JZXVzMkI0OFlQZ0hQVEEydHV5cVpyT1Bna0xOK1VSOWFW?=
 =?utf-8?B?Wk1EZG4walN2TnB2VUlna3Y4MmRiLzZRdHJQUDhlTzI1Ly9QWWF0Z1FXSHly?=
 =?utf-8?B?VDI1QU1SSmtqMXVzN0FvSTVwTjhmenE4WElPQzNzVUY2TjdNM1EzalVsVkFO?=
 =?utf-8?B?TWNOS2NwYStxM3NNMHpwT3pXK0NoTmVZR0o2NE9MeWkzUEFpQzJuTUZEMlpm?=
 =?utf-8?Q?pE6y02C7n4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0djUHZXOFVVYTRhOE9zaWdWYTZidmthaTN6dTlvVExjVCt0d1NiaERkSFhz?=
 =?utf-8?B?RTBFRDdDSVdKK2V6ZHBwdXNkU0M5a1FrcGZ2dEUzc1FHQm8wQUd5Zzl2cWJ6?=
 =?utf-8?B?amtuNE1PMHdPdFRpWTd1S3ZDSXZWaGtwOFlFVTY3RG9JVFdkRTMra215KytT?=
 =?utf-8?B?VFIvbjIxc0lFMXBxeVdkSUhYdURlUlBQRmlFb05DYVoyaXVGdkRkY1AyZTRL?=
 =?utf-8?B?NStsVE01Y0RLc2NJYjY5R2RPdlB6OExpaVdKYi9zZ0FQV21zeC9PM0RQQ01u?=
 =?utf-8?B?ZklGV3h1d1B6SjFnODdNMDFTM1oxUzRFWE9wRWl2eFR5QnQ1VklCWXpINy9I?=
 =?utf-8?B?WkhTejVwY3BuQUhJMzJKNmVVK0srLzhyMENoYnhGV2V4VFYrdnpSOGFSUk9J?=
 =?utf-8?B?UFdxWHY1aGRoMnBKSytRK0dlSXl6Q2hnaGRrci9NeFBidTc5bkNlekxDR1RP?=
 =?utf-8?B?eGpkMk5rWm5sTzR5cDhSWkVtVzYzR0pYekpnVmZNMldyZWw5aXozSE1qTkY2?=
 =?utf-8?B?cWtiYTkxRDZvYkdzSVpKaWJ0dGRZKzA0QzNTMExxOE1yL3M0YW1uNkhZbyts?=
 =?utf-8?B?ZEpYU2hZTVNzTjhMT2xZalNiVHE2QmNqMUtNUXc0N3dLSVU5aERMWXQ4TVVL?=
 =?utf-8?B?c3lJTkhXWkFqbndzN01qKzZza3dLOFZnYmFDclV6Ni80bDBrcFdiQmlrUVdK?=
 =?utf-8?B?bTdkaGFOQXFiWHgycXQ4THQxVTdCUnA3Q0poaDBmWEEyeGowSWI0ZFp4VWxU?=
 =?utf-8?B?WEh4WStYVDZQZUFZbklSSlE4bzRjNisza3dmRy9ETkxxaEdDU0hzOU4wZ09W?=
 =?utf-8?B?SmZqQm1xQWRDVEpLWm1uMDRaUExjaVZ4OW5ibGp6MjJ2T0wwWGlFa0hubVpR?=
 =?utf-8?B?dEEzYmt5QkZsNTJzY2k4OHBRbU90YS9FejBaNUFLSVZGVWMyd1F0VGdGMXFG?=
 =?utf-8?B?SUI3YlE2TGRDUzRyOHdkMnloS0NTc3loV001eW83UGdodEVkdnlDSFpGazQr?=
 =?utf-8?B?OGg1SE9aYVVaRzRMVFVtYmZmQ3JuUU5SOXBwa3lOVFUvSEZKZ3djY2w4TFpo?=
 =?utf-8?B?bUN5dVRlM0lTMTNiS3dnbzBmeHJmdlBrVlQvTEdHSzNtRis3L3Y0L1BoeVll?=
 =?utf-8?B?azdUNW94NzdVL1JLSWhnWTlmZmVMUy93OTR0MEdRS3VDNm5Ud1dMeEZweVli?=
 =?utf-8?B?ZjB0Y1A5ZHNDbjFZSEVibWV2RVQrWWJJQ0ZPazhlQnBOdjBBa3NvRDFFdjZm?=
 =?utf-8?B?Wi9rRVdkdG9NM0VEc3dPbHBKME16ajJ2bjBXZTdqTGdMRlorM00yUFhLeWw1?=
 =?utf-8?B?SkE4eXNvQXRRZElkNThWdlJXdkt3azZKVjF6Rm1KLzBaZWRUSlU0dkZNSnMx?=
 =?utf-8?B?VUZmb2hpTVhKOGlmc3JhdlBZZnJJTXM3RmJlZHd2VWpReGFveUdCS2VmcGty?=
 =?utf-8?B?SEhIQkF5TTVuclgwaGNTTjh4V3BhcE11Q04xNndGOEEzMmQ5UFJYQXpURDJ4?=
 =?utf-8?B?Z1BZSHFoVk9EWFZoRTdtSVQ2czgxY1Q0cFdwQzRpWkx4SU9MNFQ3NDRnZ0RI?=
 =?utf-8?B?eXE1MDAwSzViWUFJeXNHQjlrMk41K3RUYzBQVWdObkFwRG1MMURuM2g3VXFh?=
 =?utf-8?B?Uk1uOStyNS85dGtmUkFHOEdMaUZiZEFRTlZUUlhBQ0hVYVdWbWFqSGdWZWNk?=
 =?utf-8?B?YlhUbkJPRWJHQkkwUVltdWhpQWNDbFZWc0ZOOEFoQUtRazYxdDJVbDdIMHQy?=
 =?utf-8?B?eCtBNVJ1NEd3cSs2NWMxenpuSFV6MnJHSUZVdGxpeGdyM0xQNTJzSVVISUNo?=
 =?utf-8?B?cFJMOVlId3ZZZnhsTjF2THg3YXFWUXJXUzdaM1NIc0JZR2RqVGt1R0wzWEcy?=
 =?utf-8?B?U0hBbUJCd3Zwd0x3c282VnJyV3oxQjZxZDY5eVhYRFhSb3dDcXVnRDIxaDNK?=
 =?utf-8?B?Q28xSm9BTVI4RzQvMzZXbTRDSHpVWEZ3aE0yOXJHZVpBZ29DcVRzUzBTdmFx?=
 =?utf-8?B?VVRCckxhbVZ0Z05DNUlIUW1ZY25oTDNZekVrMFIwbmdOMGVRQThOekw5RWhX?=
 =?utf-8?B?blBycWwxdVR2RndFSWRsTGpEbUFWZkgzeXA1aGZVVmFKT0I2ZkpneE4rNHZi?=
 =?utf-8?Q?IZAcMVglxiny5Dj4H+hevEJOO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9530e685-d77d-4453-8252-08dde888513a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 12:17:13.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVJYvYbAM7ovOewDgttthPU0zrF9hPMvWT+S4wfKRH39SM8R9iObJFyIhf5h4FKb8LLG3+VeHNHmeHrcoZ+v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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


On 14/08/2025 4:20 PM, Dariusz Sosnowski wrote:
> TIR action was not added as an allowed action in FDB domain.
> This prevented the usage of RSS flow action in transfer flow rules
> with HW Steering flow engine.
> 
> Fixes: 1f8fc88d4d31 ("net/mlx5/hws: allow jump to TIR over FDB")
> Cc: valex@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Suanming Mou <suanmingm@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

