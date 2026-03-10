Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B2EA8550
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D3EE40A6B;
	Tue, 10 Mar 2026 10:44:54 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by mails.dpdk.org (Postfix) with ESMTP id 7945A406B4
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:44:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvMl1E4+TNrJUBZ/hSYz5bIXzqi91jkd3ZLnNr8Kkx8mCgKlBuiRAET39o0YCJwSyIDnwIopndOmQIHtezdKvjZZiMcV5irIL66jC/8InjmTfLi/iF3zhLPNo8PMNB9XpJy3sYergS+IXFR0DFxuijy/9B/no54O0/jIX7dwT37TyYVLs329aK7IQbgq7VM9J7hinrDMtqQdu/jZCZvDSBEhglP1uSshSq/Q0+P6J3pGlq4exjv1WZygr2h/9ttewSIvr3LsnlmhLjf3W6468lOqvjgK+KQ9b1hb3SBWT0At4aeNahWEZsIzwJARzrtwFaR4xTjXcM6uhZcrYKFlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riIYI+/tWleDyxZR/s5ntNihMgKjrug3SlMD72KjvwE=;
 b=xDB6ool7I6Z7ORmYSMINmlI/Aybxe6DDJsbtMZpGQfIhm2E3nU48+/fFsneCvyQ1SRWMP7iW0NtJlgzMFZ8cZhSXGKMue4/IpJL+ywVtd9OkdtpofFcU5oafKmp5O+WaQWL3wpJXgejHuG+Wlq8nrQogI6DLl1LClqDjp+sdB8P6Cyqz+S3TBSOxS/UseG1WPsekTP289b7gS9xA2BFuoUaUNmEP0AlKXTgc5fxRBhw2srA9D05eu6XwZs2+wH+NeNaPQqq4qjHJbADpaQ/fa3jrczLbWLodeXwLc1DOL3poStJldQoz0cUAhntovlEiI5Zt4rT/NiAHks4lHd4ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riIYI+/tWleDyxZR/s5ntNihMgKjrug3SlMD72KjvwE=;
 b=MnPVchiRI+MwOo/P8LipSzAwnboe1rKhxinFregkL0NrZRPoDL4TvXpQByJrTkDgEDMG29stTetKW+vVW73Ye2lolX6ZrZNdbIAo9Lmj7figBZaERRZQp55UE0Ski8FODjMNWTwk3++KSTG0ajdl3JhkDwxjQDftiuskQDfpv2SeVvhwW6Va5ltVde+wkXsb3nOnkN4n7WJZTDT+kWWN8prZnERXLheHBVWRcqJsf66mS2p8yamVsg/IbraQHRNC5gawjzU3AIiqY0jbBsU8H1c6dU/CXm2hteNVTJU41uvSld5UO0O7iTvFG5fglCbO281J7lByWmoViAkW0tiOGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 09:44:48 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 09:44:48 +0000
Message-ID: <69146d37-61af-4ca8-af57-3e1267c31241@nvidia.com>
Date: Tue, 10 Mar 2026 11:44:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix default flow engine on Windows
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org
References: <20260309124754.226628-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260309124754.226628-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e7423b-efb4-48a8-5aa6-08de7e89ab5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 3gTLiJKAgSduHztIIwyaUycTZ1cgHMRyGLB3nBRQGYvoMcXs0/Ouc01hbwNGVN0yyhGHkCTfSrCqlnqIjuAyj7rHpuZsDub7cQ2vguj1v0Bzy+QMsysoDoczePDXpjr02SHf/rhdFkgLmlByEYYGTrp27ljb2lhzOv/TrE61Oheasuox4qm9ci+PsHfls0aq/0DjWTjqMOnV35DcW1i4IwWJ3AaeYv5v64gmOaTjrvLMzOesYfzqyVZyo41E17hzgCU+0Fz930ybpCFZtm84AY/c0GtGRZGqBshyf6DpyWWw6nwZGq6xK5+Lg3zbmg7zpZ//KbOVuhvnq0Wl+I+BdlwvXj5QAeaBMNwH+mCrUZZGVeixzbSHj2oGKLXdMXXKKMqSyQ7NyOyPmc9K9noAQfB4wESELPhJ3kTPr5t1F5jfVfu261oQgJsyJQPYQDARXeVUV+/YoMZEPQoyKkvkPzwccLkt6kJPMhxZlFn1gIk5Z/1Q9cp33YnSTd/wZ5yVkCg4ClMuvowyp+1q1eY6r0t9pi9aG6kRZ8OFMwgV8XNHeHsJ5Va2wP/nFIov3Gv8edDJ1nfs0E3/RHLrSM96sVaTNmPhHsQjoQ2jY/+FLQUqKlzGwRfsHMBjM/+4GzhzQ68oQ5dnK+9zVTSCyme4Gt0Gl9jerhTIon4mDRiVawLh+7MpA0xLWe4x2CSO3NPp2PVsgAQIQqt08yZj9IclF+ac5CDJfH5xa5j8mZ4Y9fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME1jd2RLNWhWKzFYRWlDbzNqcW1pNDJKZ1pvL2FQeXpaTy91bDlRMUpSejlE?=
 =?utf-8?B?d0tBQTFXRzh3OUpvam1qK2VPMTZSS2cwSjF4VVZ5M3JKS0pnM2t2Y2ExdkY1?=
 =?utf-8?B?Ylp1eHBsQXVOZjZvV2dSQVJtMi92cjNrTXZpNFd5MlZVTHhqTEpqQ0NTc3Y5?=
 =?utf-8?B?d09rNXAxTERsRFdkbEdsRFlzNFA4NlY0VGtFdFVYWXNDUEJadGUvaUE5MXRi?=
 =?utf-8?B?QlByTzlUUTlQVXZrWmkxbFBhdFVmQVArYzViUzBJekFTeFRCVU1wSXFyY3VZ?=
 =?utf-8?B?bzVGc012VzV1MGJVNWswUDBFQ2ZwbXJsSHB3ODNqbHpzUFh0QXdkQjRIMkRQ?=
 =?utf-8?B?aEZJMjdSeHVYWnZVdFI3NmI5MmJpT2U0Y3AyWWczU1lNSDVkMENuUWxtck1T?=
 =?utf-8?B?cXFhQ0xqV2U4aHd0VW40UFJDSzlzVkRRNi9MWlZpaFArelp1dnFjcS9SbXA4?=
 =?utf-8?B?cUhGdEVoNkpXTkJQeHNTaXVNMGpTVzM0Z3lDbnlyNlZDYWkzSHBkMVE4aG1x?=
 =?utf-8?B?ekxFSmY3eW9XbkoxbTA4YUlvYitzM2wyZVo3aWFvTXpjMTQyeWdkcFFwNExa?=
 =?utf-8?B?MEo4TmRjVHlSekRHUEJtK09uUHBhbWFEWEUvek9wbGdpZUJjZ0QxcEhZQ3lj?=
 =?utf-8?B?MkcrditvcmVUeEZ0bS9VVWZkbGJORXdqbUZDNWdndkJiNkxhaTVxQ05LUkRt?=
 =?utf-8?B?N1JFR3VRSEtmS3FodkE1aGIwa1N1dnZja0pkWFhYSCtUZTBpN2piK3hVeWtX?=
 =?utf-8?B?bHlkZlpLMWVpMFpVbXg4UVlDQWh6UDlGMGRBdG1kT1pDelA3SlB5aEQ2TFRX?=
 =?utf-8?B?UTlLall4RkEvanh5TW5BNDFqbjBzQTRjK0dIcUd6RDBkbG5nZ3o0OG9DbG5B?=
 =?utf-8?B?ZUw1YnFsOEtseWQ2T0RIYzUrRTM4NGlQWG15TGNMOC8rWERCYzlmc3RscHVJ?=
 =?utf-8?B?Slp5a012KzN5dW9UY3JXUXF5L3F2MlZuN212U3V2blpmTjUwWGQyQjNkUmxH?=
 =?utf-8?B?T0tEclYvVkYrZmRDeWZHbm50REo2YzAxbDRQMXl4eml6djlOYll3UjFqWWJ2?=
 =?utf-8?B?S1BheEY4Q2FwWWZxUUQxaWdFL1hESXlCeTNPL0VadU05NkhBc3dYTndGUzhM?=
 =?utf-8?B?eGNYSDVrQ0hQcmZnbXcvL05zWTV2RWFOVXFXUW81aGZiRUh6N0NBNWl4Vjd1?=
 =?utf-8?B?NksrcFZzR1JxckJhSkliQUhyTnRMaTUva0VPKzNhdDFobXhMVUR6KzVua0hK?=
 =?utf-8?B?Z1BjZ1hPd254ZG8zSUc5eS9KNDBXYzZQZE8zcUhoSXc3d2wrcGxERmoxeHBw?=
 =?utf-8?B?MjVHZHdKc3dNcCtTV09zczlRcWEvSUNwNzhwS3JpSWtuaFU2SSt4UzdzcHdN?=
 =?utf-8?B?V3N4SEV0NGhaeWFEY295YmhvMUp6Y0lmc2NnNFJ4QyttUm9sN0xnb0JldUdP?=
 =?utf-8?B?VnZCbEpUNFFXeHViQ2xTUTd0d3kzS2JBOU1GSVpqN3ZzM1FZeXU1aDEwcGZN?=
 =?utf-8?B?Z3lQTWZKSVdGQ2pONXNwWitJRThUby9MeXpTM0pLck85QzQ2bDRlQlNtQzdW?=
 =?utf-8?B?eU9KdzIveUhwQ2MzM3JiaW1SUkZ2QTJHeXJ4b0N4cXU2K1dYRGx6eUhsc0V1?=
 =?utf-8?B?SXdTRUtVYXZpbENwMmVyWitPMURDZU5NTXNxYWZGTGdRTGtUbjNNeFkreDlO?=
 =?utf-8?B?TitrV3ltY1BWeGh3VFROWmYvb1JHMjBGZ0JNMVlzSXE1TnN5YTlndG9QOEpD?=
 =?utf-8?B?bzVMOVpyaHhJVGg2Yk5aUldDc01rZm5XdjRCTkltUDcvZXhIZHBoclhaQmhS?=
 =?utf-8?B?WVpOUWZ5UlZPV1J6Vmx1NFBaWEtVLzAwYnBnRG54QWtWbWpNeHhUd0Y5R3NT?=
 =?utf-8?B?VzZ2bWRPVDgvUmdrQ0FkbEwyT1pkUU9ySC8xVXVRMFVBQjJKTlZBS1U1blB3?=
 =?utf-8?B?QTU3YVBGaWN3MG9kTW5sK0tkcU1CSnBKRW9YSElSdTlGRGsrdE5Sd0RKZmV4?=
 =?utf-8?B?M0MzNVljTitkV1ZORk5PNlFtbnNaK2tiMk51U1c3TWxXTkMyNUtVLzdZQ2FM?=
 =?utf-8?B?TDlyVXRKWmZmSklYcml2c2NHbW9QOWZYOFZLdVNKYytpTDk1SThaMDlQWUxR?=
 =?utf-8?B?ZGUzUE9VQzY0Wmk1UzVxU3JTd0dkRlF0MTc2ejhWeVZCcUt0QWNHREtGZFBJ?=
 =?utf-8?B?VmJnOFN2eDBRcFpHZlZRY05LWXQ4alVheTdnZjFyR2tLMGs2MW8xeTZwc0Iv?=
 =?utf-8?B?eHoxbEFCaXZUTUZpa0pJUCtzSjFHa2V1RSt0UjIwdG13bDJ5azlkQ2lUSVlT?=
 =?utf-8?B?YTFpNUNOVkdHdHNuNFBFZEl5Z04rakNiZHBROTZraWxzdnFmdUxzdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e7423b-efb4-48a8-5aa6-08de7e89ab5d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:44:48.6151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuV8E7Pcz/gCCkIvO2ttGsQ0/iE/5Pz6NVsRPdV0K7t906KiKFWZiAdCsZk8zDonULDyyCdog04NSZYUOW97Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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


On 09/03/2026 2:47 PM, Dariusz Sosnowski wrote:
> Offending patch has changed the logic for handling default
> configuration for dv_flow_en device argument.
> This change has introduced a regression to Windows support.
> On Windows, mlx5 PMD only supports flow API implementation
> with dv_flow_en set to 1. With the change, this argument value was
> changed based on device capabilities.
> On newer NICs, dv_flow_en would be set to HW Steering flow engine
> which is not supported on Windows.
> On older NICs, it would be set to Verbs engine, which is also not
> supported.
> 
> This patch fixes that by introducing platform-specific initialization
> and fixup of relevant device arguments i.e., dv_flow_en and
> allow_duplicate_pattern.
> On Linux the existing logic is kept. On Windows dv_flow_en and
> allow_duplicate_pattern are set by default to 1 (same as before
> the offending patch).
> 
> Fixes: 170ebe941be3 ("net/mlx5: fix flow devargs handling for future HW")
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

