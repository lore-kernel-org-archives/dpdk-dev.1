Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670C8D6E2DC
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 18:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BB1740275;
	Thu, 18 Dec 2025 19:58:46 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52]) by mails.dpdk.org (Postfix) with ESMTP id 6707D4026A;
 Thu, 18 Dec 2025 19:58:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy9MfKvO2PyjFgraBrTXGU0VZCaDKfjZd0/mz9Cu0R1C8AqrGUc4sNRzaj/tcMdGZo/mQ6omWLcQbJb7Ny9Nxt/OEpWLiUcbr0JzDWDh1vfQ5XonoLV5P44bxewoP0cM20ckUV3SesomJj+1nedUdBxfGLqlXTwNcY2n7441iL483oLvFLk3HUM9bNDYUv81GkUhKx4xG2RrZRZJv+jJ2wZsf19uHy8ae6c2VlpVLFFkAEMrXf6zSV1GZ8OzTuURvy7/2gmmvquny8M4Zv1a/nq7+4YNjilJTE+FsMpMRFgcT5EZB3mnacBOT6GoLmK4xWfW6zxRD58fNrxgl3BjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+xYwHXdOtsQi9vMG12Uwk4aaEUAG5rp+cbwmR6Vaeg=;
 b=RB11Ex3lDQdF+ODgTvuPrGXV5OrKIUc7b2lldUeFHmCq1fcsk7yqu0esMfAnGtrc72PY+2atpiugE7vzCr1UuuWnxzCDGglyowIghcY9/5rZYynA48cdqU4nuwekZrXfNwgdCNIDU+IwBDdLZ8v4mXOl6VLbM485Hae9YX2ntaLs+p0KwigIqsdyfqklVkzHEYKTCVCbEvsXbgs4xVQnsValnFGMetjOWAkbX+CuSmcb6C6YYzgR0yEFRj+nxIAwH3YCPvzFYFOmAx7cGXueSOxFZTbvQ88J/QFmwqmflmSFTvCsOnnUBsRMwVTEAC0NOlso6+I06fbbEwhqIsJ2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+xYwHXdOtsQi9vMG12Uwk4aaEUAG5rp+cbwmR6Vaeg=;
 b=P3UROd0nCDlFrzgXtB2dSHlZwcBIJTRIBv1BtN0Ol48FKUgSSkUXmUstORwO423z3Fqu+Lr+Gzhq4tdyS76ITSkOMZmXT2BmoiIy3ELmvDLfmCtmQF9XVFOo/efBUNBTXXSw/gDh1SXowtZf9t+zESQltsVMpKK7m0j0JFj/kUFCumAeZAVpe99lfiq6k+8XNyugr1xW+l8i/vRsGoauZkXdQPJanXLWoa0ktVfl5myqy0XNR60nbe5ZNfYwhPqqEMMoP/M6g0qww/C85l54dyDikw4J6QTDZkgji1xfOdoaki2LfEUIlRGT4bsvPWDAPPIb5cGX6tjNkkOIqzG6kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 18:58:40 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:58:40 +0000
Message-ID: <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
Date: Thu, 18 Dec 2025 20:58:00 +0200
User-Agent: Mozilla Thunderbird
From: Ali Alnubani <alialnu@nvidia.com>
Subject: Re: 22.11.11 patches review and test
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: stable@dpdk.org, dev@dpdk.org,
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 sbadawi@nvidia.com, waela@nvidia.com
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3148dbf0-b8d7-46bf-d10b-08de3e6774f4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWg4eVZ3em81OEQzc2JrbUhEdFB3OC9pb3FlSTJzZC9rZld3cHpzZmZHMjZ1?=
 =?utf-8?B?ZXE5N2F2M3QvVzVLSlhrMHZ4dzRaenZIY2o4SmN0Mm9qeloyRVU5SjkvVlI5?=
 =?utf-8?B?d1h0bTAza25sVVJDNUJtK1pmN2F3SHErVUJsTCt3MmswQWxUSHAzWjhNdlc4?=
 =?utf-8?B?bGJobjRqZXQwQVM4R0s3WTR3czNVcThmdXBtVSt5Q3ErOHNRUkdFTjBUME1z?=
 =?utf-8?B?UlBzZnlXeXJlYUFjbnJScnhpT1ZyYUZTeis1U0tVUkgxSWZLanNCYzdnVkhx?=
 =?utf-8?B?NTFyTmp2Vndqa0hjeXV5Q2pxS1haZnVuQWdSZis0SjNVMWE1ZHFzdmlaNDd0?=
 =?utf-8?B?VTFtNjZHd0YwakFocGtLUkxHazMzdTRsTEMrTGd3SjNSTUNOUTBKd1ZKRlNr?=
 =?utf-8?B?V1dMOTdkV1BvYm15T0cvZWFrUFJiNHZvRU02Z0pIOEkweGZkNy82SEFwclM1?=
 =?utf-8?B?dUhQdHhKMUo0cnVvaDRTVnhBckpmZTV4dUxNV3NHVEw3dDRNZ1hjaGZtRkFW?=
 =?utf-8?B?clJzb1B2cWQ1Qkl3WVRCdW12MDhzeDZSYkZ4amdHaTJiSzFYdlR0UVdheS9h?=
 =?utf-8?B?VkVaeWtnNnA5aCtneTVoamlkVE9pcGU3OHBMQjBtR1QwNWpIZ2h3Vno2M2ZG?=
 =?utf-8?B?MGEyTCthazBsU24vSEtwZzhWb0VmNVYxZ0I3SHFHQkpiMlU1aWpEQjU4UG5m?=
 =?utf-8?B?WFdWWlJSdlV5VTVMZUYrblJvaXgvZkUreGxpaEdDd1kwUDF5aHVCQVJXcTV3?=
 =?utf-8?B?dW1oQVRkZXlJRmRzSmNNd25hdW9pNXBZdjRCemhTOWVvMDBJdXFtTmpoaXR6?=
 =?utf-8?B?N1J0OXZ6QWxaeDRJa0FPTFd6YUZaRTlxZ0wvUzFiNkZsNWkwaGViYVN6MmVV?=
 =?utf-8?B?RURYdmFQY0Q5L0g0NXUrK3RiQi8xSHljUEtZNjNTU0hTcTlWZlpLTmpjTHFK?=
 =?utf-8?B?RTl0OHlONnlYZENPM091UDJoR3B5SDFtM1dQczRRTmxGOGFuWlZIR0pXb3NG?=
 =?utf-8?B?S3hKVzdUZ0Q1d1AvcjlpNmMzSGg4UUVNWWdKcTNoZFhoanljbVhtNEx4YjFo?=
 =?utf-8?B?UTlkbWF0UWpGbDZ1YmtESUJOdFJhQUYxNGJOWFIyUzBDRzJQODlMZWJDZGNG?=
 =?utf-8?B?ZmFDODB5Y044dEh2eFRCeE0yS2JSZUsxSSt6RDdhdnlrR1NYcEJYK0lSVndK?=
 =?utf-8?B?ckcyZ29LY1pJaDNpOFhmRGtham14MHpKa3BIZlRSeVhZSWJPVkVnSzFNWE1u?=
 =?utf-8?B?U3ZQMFQvUHZQc29ONzkzVHRleVNkZGp0akZqeThMVS9RR2VDRnVYVTNmZ0Z4?=
 =?utf-8?B?N2lxVnRWd1Z2ekZoZUZtVHZrMHZkajlpL1RSM05mcjNyOWIyaXY2aldyM3Rr?=
 =?utf-8?B?VkR6OEo2cEFDYW1DRkJ3YzlLVDFGOW5lK2dJUm1hMUROWDRHaEV4MVEyTXBz?=
 =?utf-8?B?R2pPeTBBQ2VVb2F4cTRSQVl6Njh3Q3UrYzk3ZzQ2SDYzdGMrL1kyWThoOFBj?=
 =?utf-8?B?V3lTejEyT3lEV25sZWxxSitzRDIwdnZWLzJhL3daOS9MUDF5c2k4aTlrR20v?=
 =?utf-8?B?bmU2aTkxZEJWdGhWQjdUTmtac1lDb3RKeUQyeWEzRkNRczV1VEh0Z015QlhF?=
 =?utf-8?B?dnprT3RRQlZCbTdxa0UwU2tnWFBRQk5xTmZ0M2JaNUFVbnM3R00zSDNzQlJF?=
 =?utf-8?B?bWNUR0VxdXdodWR5Sm9HeDd5SXlFMWJBZ3VnTmxuOStjam5UeEYyT1dVNmFn?=
 =?utf-8?B?YWh3L3l1N082NTZhaGcyeTFZbnhPWWU1b2swcmtiMWltRVhjQWNqSEM5NVZ2?=
 =?utf-8?B?T1h6VC9yTTloYVJtc3hDSDRwRU84SUFaTlU4dlZMZTdBYjliZW5SZlptY21O?=
 =?utf-8?B?YVg3VFFhakY1Y2QwaVAybDkxRkNjMVFGMTVnUVR4VTQ5aG1DdHFlRng5ZG1Y?=
 =?utf-8?Q?ZBSArEl3fMJ/I3MJDHiXvYpskgUIItsY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NklaZlNscFRlamZ4VVBlV0VRSXMzNTIvRlRueVlmZ3c0S00xUFo1Vi8wUnU5?=
 =?utf-8?B?N3lOOFhiMGRTUVBsV0pWN3JUbElrejdIYW9mNmIzZk1xcy9QUjVnUm9vY2ZC?=
 =?utf-8?B?VkY3cTE4SjVURHBLZ0JjUmxGZDd3NlNkV2FtRlc3eTNwczYwcEVGNmNTNUdN?=
 =?utf-8?B?aGNvUlJwQnhrZ3UwdnpqZGh0NEg3aTcwTkhhWEMvMEVTME0yL1gwVmhma1Nu?=
 =?utf-8?B?eG9SR1UzNGhLcG96RkFDOG15ZE5uWjZJZ2pBTlM4Y3RCaDNUM0l3NHk0czU0?=
 =?utf-8?B?TVBiT0pPdzBmVy8wZkw2MGxLOWtodUNaSTI1S1M0ZWFYRWJxblpwRko2ZmxS?=
 =?utf-8?B?VTFtNnJNN24rZFkrYVZxZU5RRGI3RWhOb3ZDVm1iOFR2NXJMWXNMSGQrQTBX?=
 =?utf-8?B?ckVBTVZlVmsvWjBDV1lORW5mS3pVU3Q0cjYybGhGT0FKcDV2U3hhVW5qbUgz?=
 =?utf-8?B?UlBKU3ZTVWJadWxCTERUQ1RYUXhJeUVsMVowVFUvZUdEc1NWSEZhQ045TVox?=
 =?utf-8?B?Y0FGd1dscnJrU1VMOWh3ZCtYUExoMkFrMUNwaFA3b3pRNWpwcHE5WmdRbDd1?=
 =?utf-8?B?U1R6K1d2NFFJWGdVV0gxYU1lc1RoWm9FVG8zZHgza2NwbVo1VlI1RDhXbGxu?=
 =?utf-8?B?a1pGZmFHeUhUbVRma09Ib01pMXpjeEFVVERIOTk1UXp4cWtHSnIyZWVtV2VP?=
 =?utf-8?B?clZISWV1U1hkZTBvZHlBUHN5WW9yZGtzTGx0QkN3M1pVb1U5REJBNkJ0R3R1?=
 =?utf-8?B?RUhTT3hSTnBvWHFvVG9CUDhWeFlNS0xSZTlxSExUUlpYSHB0b0Z4OXRMcDEr?=
 =?utf-8?B?RVo5MG9OU2lnRE1WaUd4L25FRVJ3L3BoWXRtbVBDQWJOSXBLMWtpZWlDanpB?=
 =?utf-8?B?eCsvMlYyL09tY1pIejVwemlPajhoRjA5WFpiMFl5d2Z0bk5va3c5Rmp6VlZa?=
 =?utf-8?B?N2VYR2xzN1N6OUZySUIvaWNXVnQwTDJVeVNQWnZXSDN0aE5nbXU1V0Ftdy9L?=
 =?utf-8?B?d0xFenV5cUFPYlpwSElBblo3bkNqMjBIWGEvNEZnaG1MTktQUytwS1ZLeVV4?=
 =?utf-8?B?TExvTHJjOS9OSG0veUxJOWFnM1E3cTZsVXFLNldDWUtWZCt1T0NWcy9MM1Qx?=
 =?utf-8?B?V0VFckVnWnJnSzZqRmoyYTBTNDRpSnVLcnBOMStFZWhwM0dGUmNJNEo0VlVS?=
 =?utf-8?B?TjRxdlZLTmdyVHpEN043NVkyUEZkWk1LMUcvYzdKNXJvZTRvc0c1dnJjQmtD?=
 =?utf-8?B?WVUvQWRBRXdUaTE2MXY2K3VFeTdWVHltMVQ1S1lhMTJsdDlRQlFaQ2dmc3U5?=
 =?utf-8?B?QmplNlB3dXU0bzNlUG1xZTdsZHh4L2U4WFpYMFFyOFFwQkxvcGpkMUdSVkc3?=
 =?utf-8?B?T0dHWStqdGM5c25udHlzRTg5YnVjU2FNV1ZsWVVOV0h1cVdacEF6RjUxRGdX?=
 =?utf-8?B?OThqZUZBcm9mNkU3NjhaQTY3ZCtwSUtIQ2YyMzRBdDFMUytjek8xWmpxNzQy?=
 =?utf-8?B?Ri9aL2pyRkVDY0V5dStnSC93bUFxRnM5ZzQwcFd4V2tYVlZvN1VURTFjN1V1?=
 =?utf-8?B?Q3Era1lzR2FHOGc4MCtBVk5PeHVaOWd5ays2SDhML09yM0xIZ1Z5dmJiaGc1?=
 =?utf-8?B?eUl6S3ZGdmZoT0UvekJYVlRwODdVUEJ4VDVHYy8zWm01d0plUGwyNStYdVRO?=
 =?utf-8?B?aVJjSVkwWkxZdTNzOVowVXdVU0k3ZUs4ZmozazJiNzV6cGh1b3JyUG56aVB5?=
 =?utf-8?B?NWhyVmhhNnBaMGlTcG9SNmlPS1VxZHZqRk04VG54ME02VUFDOEZYYnprUnk3?=
 =?utf-8?B?RjN3bExwN0Q3ZklIUCtZaHA5cjJuQmNKNmx0UW5XenJiOUcwWWN1bGFnR2VB?=
 =?utf-8?B?Q1o5Z2tmS0Z5NHROeHQ2dFp5aTdGY0FCeDEwZ2htODhaMVE1VlpGemliRkd1?=
 =?utf-8?B?Z29SdjFiUHFiVytKWktSVE9DWXF4dWRBb0x4ZDlidCtzcXM0TVBlN1N3MURZ?=
 =?utf-8?B?TkdWWTFTaGN4MVBISDJsZWdKTU1wWUNOWERBSDVrK1pUUEd2a1lCMGdvZ0hi?=
 =?utf-8?B?N0FPRjNLQWRIaVZYZWVNa29GMDlTSWYrZHJaeksxQllrRExmSGRYK3Rxdy9M?=
 =?utf-8?Q?YI0ZPRooTOfeTCTc1mqKSk/h1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3148dbf0-b8d7-46bf-d10b-08de3e6774f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:58:39.9620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDMGoJi0/eViUmafdy5xQLGKCVl850ELRnE84eLSnwBtn51YmIGYKgZSmvSvn5iHsHgqqC8ATfumg7x2hFmFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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


On 12/18/25 8:27 PM, Luca Boccassi wrote:
> On Thu, 18 Dec 2025 at 18:24, Ali Alnubani <alialnu@nvidia.com> wrote:
>> On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:
>>
>>> Hi all,
>>>
>>> Here is a list of patches targeted for stable release 22.11.11.
>>>
>>> The planned date for the final release is December 18th.
>>>
>>> Please help with testing and validation of your use cases and report
>>> any issues/results with reply-all to this mail. For the final release
>>> the fixes and reported validations will be added to the release notes.
>>>
>>> A release candidate tarball can be found at:
>>>
>>>       https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
>>>
>>> These patches are located at branch 22.11 of dpdk-stable repo:
>>>       https://dpdk.org/browse/dpdk-stable/
>>>
>>> Thanks.
>>>
>>> Luca Boccassi
>> Hello,
>>
>> We ran the following functional tests with Nvidia hardware on v22.11.11-rc1:
>> - Basic functionality:
>>     Send and receive multiple types of traffic.
>> - testpmd xstats counter test.
>> - testpmd timestamp test.
>> - Changing/checking link status through testpmd.
>> - rte_flow tests
>> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
>> - RSS tests.
>> - VLAN filtering, stripping, and insertion tests.
>> - Checksum and TSO tests.
>> - ptype tests.
>> - link_status_interrupt example application tests.
>> - l3fwd-power example application tests.
>> - Multi-process example applications tests.
>> - Hardware LRO tests.
>> - Buffer Split tests.
>> - Tx scheduling tests.
>>
>> Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver:
>> MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).
>>
>> An engineer from my team reported 2 issues:
>>
>> https://bugs.dpdk.org/show_bug.cgi?id=1851
>> Did not reproduce in 22.11.10, git-bisect points to 58a6421bc396
>> ("net/mlx5: fix multicast")..
> Thanks, are you planning to send a fix, or should I just revert that commit?

I reached out to the engineer who authored the patch and am waiting for 
their response. I may not be able to get back to you with an answer 
today, though.

>
>> https://bugs.dpdk.org/show_bug.cgi?id=1852
>> Reproduces on v22.11.10.
> Given it's not new, unless someone can send a patch to fix it, I'll
> leave it as-is
