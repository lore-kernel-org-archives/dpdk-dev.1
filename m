Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D731CD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 10:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 989E8402CC;
	Thu,  4 Jun 2026 12:54:35 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by mails.dpdk.org (Postfix) with ESMTP id 7D374402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 12:54:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad0xzl/7bjBRWhg5xjY/n40zevVH+LEZL6uysIJ+AVrD2PmhBL4rUPw6sp0UAB2u0+PEz+Tk5yAgVkaRa2tnI0qDJFYiS/WlKIAmx0YD7Adaz0Eq3g8iyNCVmSjBAznI43uSzYW7eZ68UsfR8wC0T1oxVjPVNiJeedytJnNzJyrLpiVcx7xzot+XM8XzfwMcDDRHvWYUpN6I0B5nR8HONi0TIAzeYgP5vDKZNr3p/XHpa7xathAgmLpC/BbN16LxtiHE5kRuhcdoUouy838z/3L7vFCvSJB4HCzbXjXp71cYPHdIC3nnhUph/bwJvwjL2ywfnSC+iK296Qb/TLqt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7i8tej25xqLyN2WhuLs67bnEhGIvphN/sElFogRVNM=;
 b=femgyPnaYxt1Xbf1C+JpxMr7CG6yYX8jz7oK64rwsfq1aYFm+R/um8zUsyhavnudcFJE5bQ+M5fk7r2eLD30m+aqtiGrcfjyTVjtffY0N5Gu7PY3Ao446CY0lcyFTRF3HWbp4/26orkN6ljLKf1yClwxz1yS8KB1JtArXOWMnXVNq1whkm+nbwO3KBIQxtAP7YpgIqO+sODeWENxTTBvAdtfAvU6NOeFDo7lh2kquxfUHpl5HdfT/CHWYUI6DGGpRsoafpgAdeKVMWFP24yJ2P6r80kIoMndc/HfYYmZChAxk+3+OoaHtF1Vln71756U8nsaM96BH9mB77gd7nbIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7i8tej25xqLyN2WhuLs67bnEhGIvphN/sElFogRVNM=;
 b=rN47fdB8+hUHrZ1xVYJbmnQpjz/EVMyXh8rHKGflEbLY3AMlaBQCJlbJM9SvYAWoJcVCvUZquBiQbCyDm4gf+7u/JPFu8jtywHjFrC3HN5IOmbkePnqTRbe16WhRcdeRVI4Jyjni8nvW4VaTTWbvKddf+oi3dI1I6m7wr+y8mQ5JFSI+keSLWHQt3jwLUSURwhB5LHRz24kkKzLBjGIjRYz5BjsptQ2dVanj/d0kfbYhWQWYwx64L67w/fc4RFu54I3hwxz9ZDXcRCF6MnhOYDPxrRAtriHwlKqhjC1YpO9Zx4fycqh6Y5d9dULPydpT0h6pkn1eNr6s+nX6awZDUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Thu, 4 Jun 2026
 10:54:27 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:54:27 +0000
Message-ID: <1556c279-540f-443b-ae5e-3d403c6b6bb1@nvidia.com>
Date: Thu, 4 Jun 2026 13:54:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix the eCPRI match on HWS root table
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net
References: <20260604035222.3415-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260604035222.3415-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: eba237fc-23fb-468f-6831-08dec227a5c1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: UIH0Mbjt862PPoEyMMj/MNeHBQTSBJmt2I3JZkZgSSysLnFskeCH2Uo/2bLkDRjFMjc0j0+zbXYYl3hexiB2ai4Vf5li4fM8c8lNPU5yxHwjBJVoRCnr6//rE7/bEB9+Y+1F2xfLI7PuENcUy8kZRwcZ8v8/nJAty/CT7E0330tPIJrPezNjoUVx2vr0Jhwk0REk8znxaXTanaLUOBC2a0GPHbid/fhj4/6Wa4Y6pDsSIYI6KZZG9oCVZZqGiNr3eJenzGWWvU7ncXRWQ/C46kIaGO+8tzSsrJvGc/ZLZ8nG5PR7EQj9n3n2SmpYLc1gxrwm2Y1bDxpXQL2ORyXAfU13svVzsKuxeUJMfDq7IQ9d7xZ2Mk2/df8k8hh9u7il2XDZcOf3u4o7dwBGt5R+O7tGeGlE4jcIprLUla4QziSIeIcVa/ei8+ybsfhWQsmKDcEbHIsul+CLnPl4ENVbu3gdVAfHeJvZGB/0xKnFoWHjdwjJqIvM9VAqwKqUEb9EW9kg07qWWq41OGjJmRv+9W0i3J20ZGkOcB0UIckGdz19+bzSPrwlQ1QeeqxGIaTfG+qEY02ppza1q1jlJfVuGU8WX1PG0gEDuAw2Qd5QRGsfmbZVTWlda0F4TJOt+mk7a12XA9MbY1V4KziQ1lh97Od0cLkx5/Q4dCy1LYEB+5yF7ZuUwtlFuxcOm6yeRKEF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2sxa3pRNHBjT2Y5MEZwOGlsL3pXdHhtU2lsby9IM2ZOd2phUmxEb0RFbU5o?=
 =?utf-8?B?ZkZqcVNGUE9BRHRqMFhXS2ZkR1hnemlRT2JjaDdZdDZhcGRNdGtydlBMZ0Q4?=
 =?utf-8?B?QUFHY2Z1bU5ZSTVibFhOTmtUNk1uMFkyNzJKQUI3eDVNNXFVeXpUZXpZUVo2?=
 =?utf-8?B?MGd3M3dsVklyakQreUFpbHBMUjlldGt1VnNsL1pGWms1eG5pMHI3ZFRaUGpk?=
 =?utf-8?B?UTQrcThQWWQ1UUgwMXRnZTIySEN0eTJ0eUZLdnUxRFh2VWtYOU5QWTZMa2kx?=
 =?utf-8?B?RXdlZVZ5dndRNFE4dVhWb3hqNEVLVjVkdER5SkpDNzF5QnlzQ0ZUV2VGdGll?=
 =?utf-8?B?bjNpWGVqMjA4YVdVQjFNQ1VrbFpGdWlwUTJUWlpkRGY5c1hkbUpRenZ3YUsw?=
 =?utf-8?B?bnAzVW1TTXJxc3ZNZWRSWjIrS1hhc0xZL3cwSWpRdHNLK2FKQmhLNXRwUlNm?=
 =?utf-8?B?MWdvejY2SFRibXdnUGgyNy8rSnZZV01hVFE4UkR4Y20zSEZFSXc1dWJDWjZm?=
 =?utf-8?B?d2RIcVZIb21Qb2IrMUNDbHBhdVAwbktlWWlTV1E3ZXVqSjNqV1RuaWg3TDBL?=
 =?utf-8?B?NWt1dmRkenlLRCtVUk5xU2trcWdFSkpya1pWbUh2Z2dSakpMV2dvMENXSnVj?=
 =?utf-8?B?c3dvN1k2U1JOdDYxSEQxVVFicUZLTE8wZnpiK2l1VExJK05iNUt4a3lKT0F6?=
 =?utf-8?B?V3dHZ01rQUwrN2JsU2p3WEtFM2toVGcrcWlUVi8rNlg0Z0lxR1EvL2VTL3Yr?=
 =?utf-8?B?Mzh2ZWJ6T3Fyem1IWktad1JVUExzMDliTVorWHQ2SU9mSXgvRndnVGJaZHc4?=
 =?utf-8?B?Tk4zVjhOT3JRNlVUNHNrbmczUncxNXB2Q29WN29CcnluQjNpTnAzYUYxUXlt?=
 =?utf-8?B?UkZOdWZSZTE4NndrUTZkeHV6OWVTaGpTb3FHNkd1SktreEgxckMvcHBwMHNp?=
 =?utf-8?B?czlLRXYxdnNnSXgrMG9QVCtaZ2RlanBMODdaSkJOYlNlSWQ2aWliU09sWks4?=
 =?utf-8?B?c29tSi8rN2ZqZTFVWGFSWEJwVm9JbWpydFRQcFF6ZXc5UTUySWhZaWRnbVpK?=
 =?utf-8?B?amprZUM1UHpPeHFpZGRDV0dFTTVXSGtsbjRrbHBvdmNPbkY1WnRBakZuY3Zp?=
 =?utf-8?B?WjBTQ3hyM3ZpTGk0T0lKM3lQS2pxK290MVAwYmIvaFMweTdaZmE3Lzg4NFRT?=
 =?utf-8?B?bnhTd3VvcUlkQVRBWFhjZ0s5aU9OVXEyQ0FLMmRSc1lyd3doR2d4N015QUV3?=
 =?utf-8?B?UE9mK3dtWS9nazhsMDRVSWd1eGRtMnpJTUlVUkxQYzhTRjFnUkdzZUdPZWs1?=
 =?utf-8?B?TGZRdUZLVnNGOTBGblhBWmhvbUloc3dmZ1VVOVRiUk4vYmpZVDFNWVB2bXB3?=
 =?utf-8?B?OVNvRHFsQmdXNC8ydkdPV1MrWFpEWkxiZHJBU09qKzN6WUhRb2RPbE13M05D?=
 =?utf-8?B?WGNqT3BJU0w3N2RyVS9mdjUza2lYbHVFV1dZMDFDTDloRmM1QkkvOVNkQXBB?=
 =?utf-8?B?K2JzRVV6aXdtcWxQV0ZtN1p6eTUzSERFSmVMTUd6MHVWZUVWSVJYRk1HRGdi?=
 =?utf-8?B?L21IOGMvRHV1dGdJYzJPSUQ5V3JlbC9jVnJ4T2REc3VFNCt1TjRKK1pVUnRD?=
 =?utf-8?B?THQwUjBZbklzQkd2QkZIVHM2cVVzb3phMmFKcEg1T0srK0pxSE5VWVIrTHlS?=
 =?utf-8?B?TU4xZ0lBc0trQUtvS3QvQVVnVXkyWjZsYjd0MXVKVjBOenp4ZzdDOFpDY2NU?=
 =?utf-8?B?MHpld2Q3V01QQllsK1hRVkJuWHRXdXVoNXBiTjE2azMrNFhvYUpmZGtvQlZV?=
 =?utf-8?B?eTBDVGg1dVdjV3pzMlcwZXhPM1NURlBialJsWW90cEtoVzBDc1lBZkhyTWVD?=
 =?utf-8?B?bHU4ZXppZ2pURzllNkdyK2FTWkxzVXQ3Vm9EcDZ4RjNvVmFqYVF0ajBLSG9H?=
 =?utf-8?B?QTRPZENiYmU5Sm01Rk1FM0JEdW9TV1JqWUU0RHNKa3NFR2kzVGVCR2tIbEJY?=
 =?utf-8?B?NWI4SUpFeGFKQTc1ZU81cGVlOTcrM0hjRit2eEhFcEFDYWcra3JLY1Z2Qndj?=
 =?utf-8?B?cWhqRmlsZFc0cTJ3bnhYb0NnM3RIbkUrTy8wZFMyaDZCKzZBNVYzbklmVkIr?=
 =?utf-8?B?ME5CaFZ6ZnljMmh6WHJFNTRmT1VYanN2L2NVRjFzbnlNS2E0UEtaZDlCUWhX?=
 =?utf-8?B?RjFFVEc5cHVrd3J3OHUrdlFhRnVKdDRxdVhZTnQrMlR0eUkwWGQva25YNEli?=
 =?utf-8?B?Vnh4K3lva2c0NS8yTXBkaEVFMlMrQytkNnFCT1lpcGdxUWtzeFlQY1RWOFNt?=
 =?utf-8?B?YnUzSTI3ZndPd3NpanZ3ZTJnS1UxVWNYNWJuUTUrVXBoNUEwSWF0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba237fc-23fb-468f-6831-08dec227a5c1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:54:27.6423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFnprbMlOuVuFoJGGiJPfyX0QbcC1DKpXhCDmSK01rclSntA5MAnFCeUg8vAQ3FoqbDYwhlKo9qPIz0cSPkB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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


On 04/06/2026 6:52 AM, Bing Zhao wrote:
> When inserting a rule on the root table in HWS mode, the DV
> interfaces are still being used for the matcher and value
> translation.
> 
> For item eCPRI in HWS mode, the DWs of message header and body may be
> 0 for a valid rule. So we need to use some flags on root table to
> decide if the sample ID and matching value should be set for the
> rule. Since the table and rule may be created in turn for
> asynchronous flow API, the flags should be per table to avoid
> over-written. In SWS mode, nothing would be done separately for the
> matcher itself.
> 
> On the non-root table in HWS, the callbacks to fill the WQE will
> handle such case automatically.
> 
> Fixes: 93c7d4c22628 ("net/mlx5: support eCPRI with HWS")
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

