Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3337CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 20:26:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D925402B7;
	Wed, 13 Aug 2025 22:26:00 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by mails.dpdk.org (Postfix) with ESMTP id 78C7540269;
 Wed, 13 Aug 2025 22:25:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsTDe7SwpFj8p7E/h0MqutGfeJT944XcyNOagUPrXif/fRJulrbDW+a5fCXm11nBU3q0LzZ1s03QDB3IoVsKsWQ9P633zHbd6Dvv9LzpEtTXTjT+Xtyc30+/M8HUGEv+QL5MDw5KP7pTw+Pt+8Q0fA2a9D7atWZUZzUIEEfqC/jSws6yw4Z+pl1HtNqfx/6vFTUgQvjORFD3/QMpx56I8e9aJC4WANTgNXgvml8iMycSBtJ6nYtNJ+ybDA3iNpEHyT2f6MqRWdlbEla1ud9JbpePux4f4LIU0F2sPYxbbgOxn6uOQsnZnstaHDsjWssbqfMbcKQlvTmURFhUaj7f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkWZlPCAhKp3ym9exjY0wONaa3bOyZcLkueXO8yhTEM=;
 b=r/3jfZf2Q38r/nmLY7ypPZ4BGQ+7IAal2TZtGYraOKtx2UdD5mbjl+ia43dFZyOxdba/deZwLs2qD+seVb56iSHeXOpbjjX6BPfEBpBwwxCexWS1rCVfSlKPfW0ajlB9x41PelPXUkAQ2CE70HOJUFIyODw+ADHaQpOXymn2FFFfeOWh5BVM42qIV9mumkc3IGcc6NLIauNGmtyt63IHrpHRKfXO7eShNsPQgbdBiQlmLwztM/xZzK4cQqz0OWmIQIuVz1ddSaYUVnNkTtm0JXLA6MxfFZhHwcqAMgtmCeVQLj2Cg96M6lGTKWkOyWMp9yjsGoWc3MocaMmma5942A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkWZlPCAhKp3ym9exjY0wONaa3bOyZcLkueXO8yhTEM=;
 b=h3lTooLkcDyfvOub8iD1dRuCvpKwbgKElImlvYORTppQPtOtJ2ix5/6e/O60ILLI/vpQvjTBkLivhp0D8y0HRb04iAwIXPvfha1RjPdEfEkIcxcfXA6Gyssqj3kn4xtF8RgF50ly/HWcmDhiZfXXhYCngkVTo9YQZCzvRUZly5nsgP94rxOEpQSukAwWhNfw8lHGfVbLzKxx4dHgaty5AfGComG8bfjrsB7Mvnu3g9hVGBCt0Psv/2wNpyImJZfc6KLhz8OwaWxTHNKQRJw8x8wtg0xqDTK7mZGEY1qJLSpSnwH3EqEbdVoHCFy56jtr0F0a0aetfCim2CYgK5Unew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Wed, 13 Aug
 2025 20:25:55 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 20:25:55 +0000
Message-ID: <1a0cca7f-fd45-433e-bc37-2b4b8ea7faee@nvidia.com>
Date: Wed, 13 Aug 2025 23:25:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.3 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
References: <20250724161514.396245-1-ktraynor@redhat.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250724161514.396245-1-ktraynor@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d1fc91-e861-44e6-5157-08dddaa79a80
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE5sNnBLU1ArYS9QalpDT0t3cWlIM3JQaHZKTnlWNVpSUm5yNCtmRXBPelhR?=
 =?utf-8?B?VWQ0Z1BWNmRadFBZSC9xazVTdUt1dnhqU2JzQjJnMnFQMmRaNVdCVXJjNU9L?=
 =?utf-8?B?ajBsUURBMUtGNDZkYVFZWDBndXZHSk05NkZaRCt3KzFpSXE2VUowdHNBdDk3?=
 =?utf-8?B?S1F4RkZISmtxeEhYSHBsL3NlV0NZbjRtMDZCb29LREpRa0NSVEx0WGRLTFp3?=
 =?utf-8?B?ckVyMnFUYVBwcHg1SXU2RGkxdDEzWEZmY1JHeGpFZ2lyOUUrWEs2UFFoSkU1?=
 =?utf-8?B?Ymp3Qm5ubFNnSjI4dGovOFhtdDlnK3JlQnlyN20zN25xUmJWOFNkSlAzdDJG?=
 =?utf-8?B?RU5WRlBwbjBSVThPWDRrRFNjSFU2S3BYV2EwM1Y1WEc5UDRoeFZSMUprd2JG?=
 =?utf-8?B?U243VTlGcjFrNEgzbWZsMEU3SEJpN3ArUVpBOUN5UjZHanNXUWNoOXJkR0Fz?=
 =?utf-8?B?K0VvM09SK2x0SGFmUEdLT0g4Qm52VTdIdDJUbUdzakVwbS9yMVBySHQ4Vmtt?=
 =?utf-8?B?QVRZcVJhNzA1eE5SRkpZMWhSMEVIVll5R2hBc3NhV1VNTUxUbU03WEg5K2ZY?=
 =?utf-8?B?MVJPY2p6ajlFNkpKY2dUSlR5M3E3TXNKYUhJYkxGbkdaV1VLK0pZUnN0Rkw3?=
 =?utf-8?B?MUJ1VTV2TE9UUlgzNWlmdmtva1k2RmhFU01CUVFQdEYzNS9nMkJVWHUyUVlQ?=
 =?utf-8?B?aDV2WmNaVUVlUC81K05jblJ6OTR4RW9RSi9aNmhUeEh6TzhXditLK0Jidm5G?=
 =?utf-8?B?WE1qZTVKNUlwTlQ2eDNPNjc2aUFsQ0RDc3grVEhlZzRMbWtKR1dsdFdraCt3?=
 =?utf-8?B?NktGSlovVjNsSjVFbFpxU0xGZWw0dkFyNDdBMGp2b0Z2T2JUREMxYW45ZFk0?=
 =?utf-8?B?L3FLRURKTVdEODhiK1M5M0Q0UVZMSzFseVNRNzRCakZBUjVTSGk3NFJubUpq?=
 =?utf-8?B?VVRYWkd5LzNnWDZJQUljSjhWUmJvMTJ5ZlhoMmdYMXpvT1RCZDJ2NGU5R3VL?=
 =?utf-8?B?c09BbGxWTTlGU2oxbWIxMDl4RmJjZDBZOFhyMUFobnBZVGlwSGJlODA5czVF?=
 =?utf-8?B?V090dVM1NjZSR3FMWURpYVZ6aWZDci9YZHVld2VkVnUxajRkUCtMZ3V3eFhI?=
 =?utf-8?B?VVRVY3RtRFRITkJzLzJVZ0hxK1B3U1RCd1NhR3dIWjM2Z2Z3cHFVcHoySytC?=
 =?utf-8?B?bnZlNHhaYW1rQmY5TVFwT2x0TElCTHJzQlozcjZZTWxUVVViS0ZIQnJYTHVQ?=
 =?utf-8?B?dXZTLzY4RFFZODRPVU9NRk1MM3owa0JhNThWcGRWNCtjdVFYMnZINjc4cnFV?=
 =?utf-8?B?a3AxS1lqUUhJRXdRbWJNalk3Y1lyeEFIczhaQ053NUdNRXI3eUZuMGhnR0dT?=
 =?utf-8?B?cGR3aDl1UWl5bytGYllGVUxZV0g2MkdVK3lKRlA4aTBSaGszWWMzQkVtanV5?=
 =?utf-8?B?d0s5L2FPSnFXc1RjaEd3MFZkZTFsWjFGVDlwWGtLYkk2VThRcGJBTEpQU1JX?=
 =?utf-8?B?L21Eb01FdGJPRURGV2dhTmlhU2d3ZkJ2ZWpoQ2Vyd0JoTG9TbENmdldOV0Yy?=
 =?utf-8?B?c21MbGczQXNudU5VVzlrZVlITFg2R0NsdStIdzg0cEUvWDNBeHRmTGFackVI?=
 =?utf-8?B?T2FCU3htazYvbEpTMFo5Y2pqSVVSOFUrTWxCUWxUcWJxU2c1Y1NyNklOM0FU?=
 =?utf-8?B?T09FOFRsQ0NUclRJV2daQkJNS3FZcDBHTi9FcGp6RVpuYXVrbEdJaklyd3Vz?=
 =?utf-8?B?OTY1UGFEMjhBR2hTMDB5ODNrbHZlT1VPWENZNkJXS1JpZW1UQWxBS1R5dlF0?=
 =?utf-8?B?MU0zMHpFQWdSTVYxbzYwRVBIQnBZcE1hRG1lQ2pXR21DcWRBdzBhdVpVNElx?=
 =?utf-8?B?TnN1bmlOY09VYWR3OEJ4Z1cyWE5IR2lwUVJ3TXZEWGRiSk5WZjFtS2FrTDAy?=
 =?utf-8?Q?FZYJvjIQ3nU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VnQlRhZW4xOXI2dVd3S0RnV2tDRUM5aHR0QkFhMzZtdFFvbUMrVVZLMnQw?=
 =?utf-8?B?VlNoTnhJdFhsN2cyalRMZVFnbTllamFmdEx3a3ZtNFRycnJoRjJRNXUwUm84?=
 =?utf-8?B?TERTWFVHbUJlemtqQ291QlZ2TXVYRm51VThDZWhtdU1BSklrNUpPbkFvK2xh?=
 =?utf-8?B?QzMzNyt3anJ5RE0vWURiNFlDRTREcW1USVNGQnpqTmJ4WjU5cFRGazNkdHJU?=
 =?utf-8?B?Wi81cmcySGtIWU1IeGxLVzZGZENLR2NhR2dLVnVVSTdNRmErSEovbzR1dUlC?=
 =?utf-8?B?RzFQMzNFODhPenZRaStSRzhtSVBhNEpEbkgrUjdGMmdEYXFFUzNRdkE2UGZ6?=
 =?utf-8?B?RUs0UHgvN2JoYk1wTHU4dEdDY1RRT2UrZmdhZklCN1dwU2w2STRVMjNDUm9i?=
 =?utf-8?B?RVhtZUhvcnNFeXZQSTRSQzkvdzAxUG4vUEFQZU5ZUjVWSnBaMzUyOEFVc0tL?=
 =?utf-8?B?MUJQU2ZQaW4yZ3hnQkRlNGZ2d3FEMXpiTis0Ymo2Umo5L003RGNiSUJhbTdS?=
 =?utf-8?B?U2N0VkhoS0FCRG5ReFdiaFBuMTNDSzNnVDNxZXlyYXVNckw0UUdsbGtVWFhP?=
 =?utf-8?B?MzdlN0lldkk1SWVueTI0UEpud21Baml5R2RXbmFmMndrRk1xRDRmNHl6bUZP?=
 =?utf-8?B?ZDlBS3VJbWtRZXl1UkxwS3RVbk5JclVJUUNQMHVkZ1RERlB5VW8zU1hyWW1V?=
 =?utf-8?B?QXoreTJHd1g1RGxWYkdZS2xGWTBQRDZ6a1dXYnlRdlYvUmJZWEpWUi9NZ0N6?=
 =?utf-8?B?cVlPTWVJVmdTMWV5MDVNd1J2SlQ4Z3k0RjhnSE5HV2Fmb3o5cEgzT0tYT01U?=
 =?utf-8?B?c2tkNFRqYzQ4eTJ5OUxkWU5pampMOFdJcllhZmxIczhRMlRCMy9wNmJEVWpO?=
 =?utf-8?B?a0ZJcWhDRE9WbGIwd0ZvQkViMzFTSUEvL0tDd3JBbEtTVXRqWmxQU2JkQktC?=
 =?utf-8?B?bkFldm5rdEJ4UHVtTW9CZ0FKR2JJTkltTVVSanc5Ni81Y1hGeXQ5dDg3a0w1?=
 =?utf-8?B?eGVOd0EvbjRJanBpUUNLY1BiZml2N08xVlZLd3JhVGtNTE9EQzZwTGJrMVpz?=
 =?utf-8?B?VUF4OWpGZEx2elVkT3FPUCtuMjFORTFZUjdRWExGdzhrcitsOUI4SWtmZ1J5?=
 =?utf-8?B?clppUFpsZjNmNjNlV0tYMGFRSkFqaEdtMUhSV2M2Vkphc3F0SHJ4dGJ5MzlC?=
 =?utf-8?B?THh1eWtvb1gxUGhjTDNoalptd1VBdVNQVnp2dW9uaktqY1RuSkNXdzZKZnhn?=
 =?utf-8?B?TVpyYWw1V1QyYnd2cFQwbDdCSkFLMm5tZU5WcXh4dDJ5NEhmaVhzcTRPQmk4?=
 =?utf-8?B?b0t6ZnlQODdXeXVSY3IzczdRR2lUTk4wLzc2VFAzTG5iMFVqZC9tRXRud21u?=
 =?utf-8?B?aXRyWkFTM002eERFdElTR3lyQmZPQTFsSU1Bb3ZyZkZxVXU5ZVMrV3YyMEJp?=
 =?utf-8?B?ZUd2NnJKQTBKdTJxMUswMFZSS1RTaHJkYzNHQ29YTHpWd05yanpXcWJMcTU0?=
 =?utf-8?B?blNPeTltZzJwTG9mL1c4L2xsdUlHVTFPYW96dzdqMHBOYng0cEM3SEdnRGRV?=
 =?utf-8?B?TUNPSGpJOEJ3ZE5FYXc1Rk5Qd1B6ekM5U016UnZucmFWaXgwMmtnRXNrNzlL?=
 =?utf-8?B?c3RyNGNSeWhyalVXMnlMc29UQUpPekZ0K0kvYk5DYWR0c25pL3RBSFljTjNa?=
 =?utf-8?B?dTFBYkl4SXNWM2tNUzdvTWRYNkFNTzZnQjZ4K2o4TytZWkdPam5vUUdDT3hX?=
 =?utf-8?B?M0pvQ2RBemlXYW1YTTJseHdhRnVHSmZySHFZNkZQUnJsK1pVaTVsRFltQkJs?=
 =?utf-8?B?cEZyUUxrZm0rSHB3THcrL1gzYjJienVTSDJvY1piT091ak05V2VVaVEzYi94?=
 =?utf-8?B?aWl3SXBVRmpsb3JrMWpBV3ZXYms1elRNME1sRGxYc3kwYkFTT3g3aVA4UEda?=
 =?utf-8?B?eTBaaG12M2ZPWmZrWmNOQmJCeXlVbzlPQmR6QUJzWVFNMHZVSmdhT0VXalph?=
 =?utf-8?B?ektTcnptN1UrdHc5WSthYzcwRmJqNDg1cTdIZXQvazNlU0NiR0YrSWZ2NXhP?=
 =?utf-8?B?VW5HWDdyRk9acTFlVGVGZ1ZncG1sL1FmZXdPbE14Qnhhc2NMVjBlZW9XVEZZ?=
 =?utf-8?Q?fMpF0ZSAhbMmustOB3G6Bhj2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d1fc91-e861-44e6-5157-08dddaa79a80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:25:54.4646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2MRr/s4hAyhay+xQpBi07CYHnENan1gjahpF3hbw7v/SnDu+8uDLs1fvTwc86VBXXR3iF6Ew6RsnaixX/DlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
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

On 7/24/25 7:15 PM, Kevin Traynor wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.3.
>
> The planned date for the final release is 12th August 2025.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.3-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---

Hello Kevin, apologies for the delay,

We ran the following functional tests with Nvidia hardware on v24.11.3-rc1:
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

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 22.43.3608
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 28.43.3608
- DPU: BlueField-2 / DOCA SW version: 2.9.3 / Firmware: 24.43.3608

Additionally, we ran build tests with multiple configurations on the 
following OS/driver combinations (all passed):
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with rdma-core master (091ddb5).
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 42 with rdma-core v55.0.
- Fedora 43 (Rawhide) with rdma-core v58.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 18.1.8.

The following patch addresses an ASan issue in testpmd:
https://inbox.dpdk.org/dev/20250730113243.197386-1-mkashani@nvidia.com/

We are currently investigating additional functional test failures but 
have not yet determined if these issues are new or present in previous 
releases (and appeared due to environment changes). Will update as soon 
as possible.

Regards,
Ali

