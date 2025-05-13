Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE62C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 305234026C;
	Tue, 13 May 2025 08:23:26 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by mails.dpdk.org (Postfix) with ESMTP id 1B7174025F
 for <dev@dpdk.org>; Tue, 13 May 2025 08:23:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcA7GpmblBNJszNhV1GpDwRLZNE1AIUSKa7AZCVYlCIP1z8L1X7bHU+uBX2rgkvzTqG9nhhzJbhYcZ152xGH2r/Q7Q/NIpEW6KyQUPT+bR3NpXJsU3RegwdxVQ6R8ZGH2dICAC3IQwblHJWxfTCfq8u+6XOApDVxDx4zT8p2wm25bNYEyL2Ivdf//v6QcqCEfAZ2YMbfMD9Ko3wE0PUSyFCeOe0Gbgjgg3rzNJXHyEm/BsR2BTwXKBC/WTz3LkeWvJXsV5AZy1ZCjMk8xGAQMzhZYupjQGA15jbQEJ0mhm0uIL7udC69HZvuFmsuXlSYZI4yo8RRUd0WrqNbYeMOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8TjbAsL7+nZJwC+Z3XtVLkL30Up4W3LKAzPtuXkp7Y=;
 b=LBeUjTzHGsvVxafj5fA0NMN5ZEcEab4Fwd0GRR22O7Z+PdOfzGuR27IbnI5KAyYRMVSkvz65YCnbRjLasaT4UJKWXHO0r5iBpiayuyys+R7klqlnw4OT0RQk0YlWpbaqfH/8YjgqMQM7SyBsagF3PH4zHEdhIAlRXimpeZV7IWbXLUwskcSwKzSTtPmUKfhzFjlhTdawtjXDS3ixAjNXNQUqCl4PjY6BLn55tHHhQ5b+1DMNF6GqJt7X4s1yv3VmKLJm6JP/usvSoEFU699KIPTj1RGqF+PWNppBZQTkIXWib92SxSl6YaGd4rp2JiGjCUWJ3Bc5u1HgHI+lgYVF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8TjbAsL7+nZJwC+Z3XtVLkL30Up4W3LKAzPtuXkp7Y=;
 b=o28Z7vaaasOhEzDQokcsvtxJxwC5crYX+Auo/hiNvN0kyIKWDFq1vF9ZIPkap4tIgpmzpVioEDq3k6EpHw0E/j/kz5CKvLHTlZQ6GmO579+2RB2pZWNQLy+/yg4AJFz+mB57r6RPIWsie0nsS7yVpm0NlC4L+5UQZmJJ2FnnwtPIrh6R9vIUqGJXWr1PYzQj0aViGui00hHy9AsMljj4OVANLxGoTauRiwr9vHiyD/PORSuGdhrgn/5UZu4bzdjZrkpEOLVvbRKz6zZGAzEEBLDxBZ1wTbGKxyj1/l3SgoXR3BbXXsKrKBBQpE9WdfbUJEn3kC3/TSXEej22pBvE9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 06:23:20 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:23:20 +0000
Message-ID: <c50dfa76-8d39-4f76-b4d1-aa118e29f267@nvidia.com>
Date: Tue, 13 May 2025 09:23:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/mlx5: read SWS capability bits
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20250427111916.108276-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250427111916.108276-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: e52207e4-990c-41df-c953-08dd91e6a7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUNuaC9uc3lLS08rTkJvY05IWkhRV0FzWHY2bmFHWExpOUhZb0ppejBsS2tl?=
 =?utf-8?B?Q2lLSjNiU2YyS3Z4RmJubGVSN09IV1E2b0I1QUZHVjkrMjd3R0NyMGh2Yk1T?=
 =?utf-8?B?K3VadW5MdytEQVJwOGUwU1k3NjhSYUhCQW9PQnNSYkRlSEpkbXI2T2F0T1NC?=
 =?utf-8?B?cFdhQTVmZWZ6N1V3ZGRGSlNaTXZqNy9jZzBGRzdVOHpCWWNmSEk4Q3FPdjlP?=
 =?utf-8?B?WjJ3THhLUFprSUdnQnJrRFEzNXhLelZiemdQc1lQRk1zU1pPYmh3K2FOTjU2?=
 =?utf-8?B?NmdQakVpNkptb3M5UDA2bENRQytPUmRsamxxWUQwS0tKRWlNcnA4NXd1RGg5?=
 =?utf-8?B?SGNmeTgxcWZpQWl2d0hTaTlEK1ZybWx5NjgwK3VtaUtONFFObWtwSHcxQ1dB?=
 =?utf-8?B?WG9IM25MVC90VGp0Nk5WM09vTTk0ZWlGUkFjQVdmbkd0ZnVrRWxNa1lPQzIw?=
 =?utf-8?B?WDZ1M3NWb2VTVFpOZ0wwTmNXT2RyT0NuRUhDRmRJc2xkeHdCbnFOOTdIaDV2?=
 =?utf-8?B?WG9zcWJJS082aUxVUTVDOHpVaWJBa3J1b09MbERaQWlZYzBsaXJGMWRCOC9R?=
 =?utf-8?B?cEN0R3hIOEV0V0swVUV2Zkc4ZUNjYzQxaVFkR256VEdYdDdNR1pXSG10Z21Y?=
 =?utf-8?B?VXhVRVMydFBLWFZ3eFdLSjh6TEUydlU0QU1NcElrNFZtUkI2YkppR2twRy91?=
 =?utf-8?B?WFV2MXp5eU0vS3pLeE41bXk4QnZEUUVyNWJYS0NzVjdKcUpwK1NrWHR6elBT?=
 =?utf-8?B?Y3UzMWNTdENIVkpiZVkyOGtwUGRodXVOQWhsbFYwcXRYTTJtTGluMGgwWWd1?=
 =?utf-8?B?a2JLenVzTVRPQXhoR2pySGVkQWxYSENyekRkd1FDK25pWjRmY3Q5OXU1dWJJ?=
 =?utf-8?B?VGQ5Q056dE95ZWI0UWU3Q3c5NitpU1VaeXo4aFQ1TkRwS1BkQXZqSHhWcC9m?=
 =?utf-8?B?Q0hBOWVmMENmaXczMlBKSmRHZmVsVEFIbStibm9xc3ZtRUZOdk1WOVNMSko3?=
 =?utf-8?B?OEorVDlnVWdweENtZm1tOExNUWI3cUVyYVF4MHNVelA4d2dLdFRPU3ZJOXR0?=
 =?utf-8?B?WmYybEl0MTQwZDg1NzhuR3ZxRGNEVmVncndWR2JqcHE4UWxCcm5IR0lwS0dI?=
 =?utf-8?B?ZE5rRmlDaHZaVHZSbkVDV2trT3oxc3U4V0gwTlEyNmxwd0NhWllyM0FVdHhk?=
 =?utf-8?B?SjlTNVQzbmdaSHpDYUpJYjd6dzFNamNWKzM0a2dHemRTZGV6QmhOejNHTTVK?=
 =?utf-8?B?Wkx3UlBmb1pUQkpEdXlOSGpRRlM2SThtV2ZyMklmZlpKZ0F6cFp4b3BvUXVp?=
 =?utf-8?B?dVd1K3dPazN2c0ZuZ2dHRUdPVW04Q0ppUGlhSFJNQk5Sb2IySU9xR2pQaDRn?=
 =?utf-8?B?Ymdqa2tVOWx6T0dtWlVHQUFLUk5DRTh3VS95QlRNWDBaTCtjVXMydG9JWHJI?=
 =?utf-8?B?anJsaEt4dEh2UHZPQXdoczZlWlU3Vm1objRmYWtmTSs2NkZSL3hIdEx1eWxO?=
 =?utf-8?B?QVFtazNONFdwdzZCd016L2dScjNQQ0hhSTJkZ0NtdDBzWmdVY092ZHREcmcx?=
 =?utf-8?B?UkVvM0hmbE4rM3h0OFdvVGtpY045WFB2REd2eThSWGJOaVFVaURXWU5VTmV4?=
 =?utf-8?B?Z3orS0VDUXp0T1ovdGwxREJEc3ZxNXAwMjJHRGIyeWRiWmExbk1aTXNvbGk1?=
 =?utf-8?B?d1lQVktFSlhpTnJ3MDk3Z0ljZXhGWUFDQ1hoZFovVXFDajNCT3JsU0Z0YTM4?=
 =?utf-8?B?SzhMWUlwYkphOE1DeHRZTThRNHdMRTJCSjh4WkxWNDJsQ3NockdXdmJ2ZEF1?=
 =?utf-8?B?Mk5LNjhQZnRBTXRLSUtMcHhiMm5SVm9qQWFBRXRvaFlGOU9RUkszQzd5d0xi?=
 =?utf-8?B?dWkrNlhlcWFoTElQa2VrNWRtRGJCK0JOdDBHSTlRZGQ1MXA0Q2M0R0FaUXZK?=
 =?utf-8?Q?hKik3LH1WiM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhIQWpQQVYzNWJ6LzZtVXlZU2svRm5BQjRieEpiTnVqc2E5cVY0UzBlVGQ0?=
 =?utf-8?B?bDcveHFlOG5LK3dPeTh4ODNrTU9Qck5nczhBK1hiSEJTYTJPTVp4b1hIYzQz?=
 =?utf-8?B?bzBuU3lHU2tsYzJVdmpJZ1pFM3kzdVR1eE4xYm5SVi96SXZvZitzaGxsQ3E5?=
 =?utf-8?B?d1o0TWJYMUJiYURERXl2Kzc3N1loczVWdWV2MGxtbm1oc1Z4YktXMjZ2UVFv?=
 =?utf-8?B?NGVRVXdnUFUzMS9pbDhkb1ZPVHhFMG9NTC9LZjNlT2NwZER3L3N1aU91Unov?=
 =?utf-8?B?bXhKUS9nSUkrWGZ2UXQ0ZWN3M1czT2V0MVo3MUlZMk5FZnBFNzhoaExYTGZZ?=
 =?utf-8?B?Qnlxdlg4OXM0Q1BHTDU1QU9yK0ZVbk1PREdWZ1djTVBZVkxzVnlrRDNsZCtR?=
 =?utf-8?B?cEhCMFJWMmhqNDlPYmMvQmhkOEVVZjZiWktvOFBpZ29SWG9VR0RmOHJqQkgw?=
 =?utf-8?B?Tm5PY0ZSUEdEQkpFOWQ3aER1MVZjQ21qYi9LaCtITzB4UVIyRHVNWFRlcmgv?=
 =?utf-8?B?aWtUUTUveVVmaDVmNXRuT2VnR0Y0b0k0QVk4Q05kV1M2Wm02clMwWXN6YUs2?=
 =?utf-8?B?c3AreHdEdEtlWDJwTVJSMUJwZW13QVhQQ294TjlqZll6bk9wU3dYUkNZTHVI?=
 =?utf-8?B?UnJGN1J6VTJHL2hJbzdxYzZ6NXJIOEFqOFc4TUk5eDNqWFdEQlF0S0JGRHZG?=
 =?utf-8?B?R1p2OHRaQ2NsRTUrODY4a1c1Smg1NmZZSjh1aVRRY01kMEM2bW1yWGJFZDhz?=
 =?utf-8?B?c0t0NEFOaWl1TU5RWlJxcFA4NlF4K2U5bm9aSkRqZDdweXZ4anVJN0swYkdO?=
 =?utf-8?B?bDJYcWk3OW8xckRyZzBFZkxjbDVxUDFabVhrRDZDN1M2dFQ0RnF0UThEcjVh?=
 =?utf-8?B?WUtheWFzcE9qcjdUNzRtN2d0Yk4xajlKUlM2MTRROTlLYVhpeUxIdkVVWXND?=
 =?utf-8?B?NlllaTJ2enZNV2VKM29Gcm5Jbm1ySTZ6cmFNY3lCam1ZN3NHa1JUaTFGRHA3?=
 =?utf-8?B?Y2V3cUtpbXlKK0pjMFFiTGdrNzh6MEtzay9FSzVQYTF5eWZkZGtQK2VvOExE?=
 =?utf-8?B?aHk2NktBeHJpeWE4UlllcWdEQXhlc3Q4R0IvVWRSbC90VlRHTzdxdExBNHcr?=
 =?utf-8?B?RXpoSFdwVWV2bUh2UGJEVXRsVXcyQWxpZXdQZ1VoR0VsT1Yxb0JnME02dkFh?=
 =?utf-8?B?ZTByT3hVSEh1cHlnaWRhTThaNGtMa3d0c2p6cS9LeFFUUzZPbzVqcndVUVFr?=
 =?utf-8?B?bU1BbFo3K0tteG5hZTRWK0d2RVRGYTh3bFZpSk5ablhLc1JBa2dSaVlFUUJq?=
 =?utf-8?B?YWc4SzdHdS9mb0FsVUwxcDg4NnpuRGdOazk3V1VmK2hCajl5aWp1SEplYWI2?=
 =?utf-8?B?T1o5MVNQTmFJNzRrNHIyMVZyNVF6SDc2QzZMRStYT3p2bFJSdEo4UVlNS2px?=
 =?utf-8?B?U3V0TkhrM0EvK2pVZ0VzUk5XbHZobHMyOUJnSVhMMC9lSmlWMG9LS2tmVUZR?=
 =?utf-8?B?UGdOVjV5ZDZmOVZUVkdJQk9wQjJtdVV3RXp2S01mL0VuMVdVOFdmWkdXbGhz?=
 =?utf-8?B?ZUt6QXk0NmZNT0Uwak1SRmRxK2pVOUxJempmWFIwN29jTHRGMkVlcGtJKzVX?=
 =?utf-8?B?QTV1bjlQVFdRRW5nNGNwM0JHVVFTUG1mZ1laaTFpeFVCdjJJSlNyakhCejZq?=
 =?utf-8?B?NTV0Wm9yWWhEMlEwZDBGREYxdVc0dE5lODZ0NllGckRNdXh6UTB3R3pubGRD?=
 =?utf-8?B?MWxtSXI3eStiUEM5TXk2c0pteWFFeHh3WTB3bTZ5dzFGTlU0QUdOemhIZmtw?=
 =?utf-8?B?anhZV0haRmh6dUNOMzg3ZWZzbjNiZWhPdGs3ekRsdUJkTFJHbnVWWGNSK2Y2?=
 =?utf-8?B?bGltcmNWUnMyOWNYNFNENUJTTzNCTW1YZW02dlRIeEpDeFhocjY1aDRBTWVj?=
 =?utf-8?B?UGtWc1VQKzd4Wm5oRTJoYmw5WkwyVHorSklkTmNnK1I4Ny9EWFZCakF5ZEIr?=
 =?utf-8?B?VjhWQkpaSlpGYnY3aE1iZU5wWVZBZW55NEJTaHY4NmZuU2lOM2JVdEt3dEJR?=
 =?utf-8?B?T2wxb1hheUY5NVg0NHBJZ04rTEdCS2k1dW5kL3FBVlNxWlZZaTgzUjd3dE5v?=
 =?utf-8?Q?lMzEds2jjK4FPSbWDjrHoP8fN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52207e4-990c-41df-c953-08dd91e6a7b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:23:20.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai/lhG5jcZCDxrM4HMec73JvRqDbbiaZuYlfM35X9qE8FGsmEGsr2n6elnaccvok3DFoMyB++CWRhUFhB51ttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

On 27/04/2025 2:19 PM, Maayan Kashani wrote:
> SWS will be disabled in future HW generation.
> Checking SWS capability bits and returning relevant error.
> if user configuration is not supported,
> will be added in the follow up commit.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Series applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

