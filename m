Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1196C5DF7E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 15:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 808C2402C4;
	Tue, 18 Aug 2026 17:14:38 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by mails.dpdk.org (Postfix) with ESMTP id A887F40269;
 Tue, 18 Aug 2026 17:14:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlwefV9NqmfNbmyHEroCtqCYiwVTMDOTUuv+vBwOyq8W0RJIAAsMocRUuBIQRaB+nuIS3e/aNbdACpC793jhTkNn53Vm/tz7qgaXB6pesAyu4HDTtiXgb1Iucw6zdwqzLqakW7e8U+/bLXpx8q29LVo6r45HCoLgbZl9/yRP6n92ZaGeN8QUE1sVluAV67xhUH2qfwe0qgZYSDiDJiNAAtSqYfXFzZuFMDgRJ77HFuRfVfm5AVlGL1L1xn8MRB94ANeV8kkSNqdWef1kSF3G86O0j6OXZcziPV/KXz+HxNJojy4QRZ2oLAN4hi/QWTzX8pszMo2dmY74qVVw4WIqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZg33BEMo2dEYW0zF4XIM9WPya4b4JcSpCQuQIJYeEw=;
 b=aLcsZY7D0AE2WM4LaFa9QNUbZVqQ1z8q9JTJdYkR532XBRZREEMX7U3vta44NuV5ARmiRQCn9Gp/t2J0SgQlj6AtqtBn0o4p/TvWd1g2gzDMhG5/FnPqlsHmi/WumyFHqBbyXONrvjZ348t2e4ZNyzvPIyLIM9/mU+VO+LsfPaXk1Y7UY7xADscFzmq7tMMrr48O8u4DYVWGK7zNKK6NPZfemM8ophjiMfFva6hFCdmfly9mbzYq+LxF9tiNSE/gVbouEDEHyc+MLx+gs0/tppJqpHfMLtf/RiiAWFxRg3FkoZ3lCoSAASJ8bgCqauZDHOBb1NNlH46FWIxiaTd/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZg33BEMo2dEYW0zF4XIM9WPya4b4JcSpCQuQIJYeEw=;
 b=AumyVuDDpWHSWGLNa5SdBAeWXj33u88GQ1wM0+Y1btisIyqotadu7dGDXoCu7wX1LFBH+UKxiYJ13CQnyOVNL4ss5SazYu0/uo5thynI2X52Zth42AYFuPC0ASX5iKuJ2ohBS914DKwPuQTH8s0ig0YJB2XbBK753LiJcdhykdq+oZBPhJhcsjLUuI1lUqdcHuxbm5ZKoeg48JU+d571UERQJUu2SzOneVoaPLd+ft726K9Eazln1m66u+4baTDe8jHyQPCmBRvasKPTJ9x3pGV+FLrv1OaS2KU+GkmHW7+5GAZeMv+AFAZxv+QDr2mOaZjBEKvEgiDrBMfH6YSpkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 15:14:32 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 15:14:32 +0000
Message-ID: <45705b36-123e-4459-9287-935485b3658e@nvidia.com>
Date: Tue, 18 Aug 2026 18:14:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.3 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260804104755.135019-1-ktraynor@redhat.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260804104755.135019-1-ktraynor@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5c3a1f-b777-4e6c-f1b3-08defd3b67ef
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: G4bmBO8Jm5yCZ1WqBB6BkTdafKyQ/EebsNHA+Y/EQni2Z7ej3gWdtT+ihERR/k2XkgizOIevqISvVNYRsFIcv3SLZk+6z63eYZJIhv6930hvUVCZnx9C1VCRRKy26zKYsgk1i76jfyQq8qMMK/6AOaZOn7luT1mdSn33KP+cTvvaojnQv1RFnGOj4+4tz7K+BAze+MTpBP5fKsL2Pygz4HUjRTrNVgCc40l/WdCUfi08YadI7OCsNnyOosZOMG/xyvkLXCan/ICWUIevE5l7W38NvktLQQsCp2QGiIrJno2y0GoMjxV5PsIKAEriDYIz62YcSzQhwVPbi7Dwnfnw5mWV6il4THomOQbnlEhBg5uwBYyheTuoXAzqLAQybD/xFuePZkd5LL5/dIp4l/i9R2QxU42A/6G85W1dbtig5zgKwvhFwpG5yzz4wprWuQT3W93R+ESLAi+chbVMXGYEyBC4W2ReGORluIXMdRq7Ce/ei1KcRWXxrSNpoYgCI4YaFEQZ4IdRa31aco8hv5lde2XJ6s6+J+A0TJYyUlR9nI4xlqKWQJggTcNB2mpagFsfvpdA8hv69R1uCAYxxAumwn48gaIKu6YYd5tObf2NmS+Kz2csnBedyHgM1CVvOvTVrcgLfJOMGQjzT8blzsjunhr/n8u5lseeA1H6WFyeRx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdVMTA4MUNDWXNFTmxFR3J4VS9yKy9XcmI1aExrTnRBb1crUk9oZEpWVk1T?=
 =?utf-8?B?MkRHcDhMamxKQjRGNlEvKy9CaEVSTExEVktiRHNCeFROMlFDQ212ZjRxNkU0?=
 =?utf-8?B?ZTVrcWpuMjVlV1RGMnlZYmlNTm1UdkdBcnB4SG9kY2xBanljNmVHWXdGNVJp?=
 =?utf-8?B?RXZFbzZaaUtEZVk4RldQSjArT0RTUk9qcnRvRGQ4OGYvemQ0ZU85a2RVZ0Y4?=
 =?utf-8?B?SCtILzJySm03TElWUWduQi9WL1BiZ3ZnRTVDRUVKajVGNWpESW9WYlUwSkJj?=
 =?utf-8?B?WWNtbnk4YzNDYlBxRW1wckxiUUR4UkV2ckNid2x1blZrUE03SnBGV0taMlR1?=
 =?utf-8?B?MThlcmlZVFpEK1daVG44SDRkNUFaNE5wS1N3UnlYNlcwK3lUWHhvTEpZajVC?=
 =?utf-8?B?eTV5Z0srd2pEZGU3SWIwaWREOUozMmtJUURjMngyZGZVTkdpVTE3aWJCTjBY?=
 =?utf-8?B?T09MQmRBTEo3ejNRUGVVdWF2Y2ViL3hWODg0UGNjUnRReGZqZkozQXZvTHJU?=
 =?utf-8?B?V3dqaGZZL1R6Z1dYUVgxS0hnSWZhYU5jSysydG0zQkNQSExFRHdPMVRsc3FV?=
 =?utf-8?B?RHByR3VSQndSckJpVmhwSTVPL3JNZHFadnJOQ1RrWWhBd3c3RG5FK05wb2ZZ?=
 =?utf-8?B?TW5BTkY5TnpER1JrSlpSUEE0MGp5R1BLRWc4aVdjS3ZRaSsvaUt6cGJjR3lC?=
 =?utf-8?B?QXVOUWRVcG1sSmdldEdYOWdnZHNsL3lVajNGNitSRHZtVHdQMFNYaGUwQ2FK?=
 =?utf-8?B?bmVxMUx3ZjlEM0FZUktSaS9ZcXJ4a3VQTWNIMUtvYnBHcjhLTVRtVDlTazlN?=
 =?utf-8?B?THVhTHFITlJoR0Y0WFBQNzlWbkNqOEJuMEEwbm9TVVRkWERZQ2xudEk2aXpU?=
 =?utf-8?B?L3BwbERPbHFDSFBvejcyeEtLdFB2dmt0Y1hTWGRrWWxWT2hSZjM5cXJtMmE1?=
 =?utf-8?B?aEF1K0Mwc1pvTGRpS05OemxqN3Jmb3hUcU83N3Y1NlJJSkJIVy9BbTFiVkh6?=
 =?utf-8?B?TWZPMzBUdGNOdzdmeWVES3BKNjhybnQySUJuVDg5Wkxhb0ZtdXFpWDVyV01o?=
 =?utf-8?B?SU1uZ3B5djVZelJaT2U5VW9BUWVoeU9HWit2RUpWSW1aMm1CMXdXM2ZiS3Ry?=
 =?utf-8?B?aFFKRHlVRjFVSmxSUWxqTWp4S2o1WjRoNE1BN0cvVDNaNWhhRFhkRnpZMkhJ?=
 =?utf-8?B?VWNib3B5SlYyWnF0eWpDYlZKYmI3UDdxL09FNG4xUFpMRlk5Y3lzTEtWS1NB?=
 =?utf-8?B?a3AxR0tpc0tyZjVCMG5LVDJZb0xxd3BCckJYb3VSOFNrQ01mOHRuZmxjMDA5?=
 =?utf-8?B?bE9vbmYwSmMyMGs2N0NPRWJoRzBEcDN6QWpnQ0lhOU9jRU1oOFVub3Z4UmNv?=
 =?utf-8?B?WXhnaDV2elNGd0FGZ085VzFseVlCWnBVYk5zNHJqSzhReDgwTXBUNkppaTlm?=
 =?utf-8?B?SmE3TUc1N09ybk5TbkZpSWF6ZmxmSGdQUVlDS3pSbHlKb3NZT0U4bDZITkJO?=
 =?utf-8?B?RldkenoyT2k4OWJ6eFB3MlZHcmNRKzlwM3VscGNxU3JSNUtLODNpdEozTWJj?=
 =?utf-8?B?TU1LRWlRMUZEN0NRdWhzQ2pxQlcwZHpySzFzekNldWFMTDAwTG1VbE94Y3I5?=
 =?utf-8?B?SHpwQnppMnloTlYrTmsvNzYvT3Vua3NTMk5PSHI1aGUzZ2pXWjlyV0R3UCsy?=
 =?utf-8?B?RDQ2Slk4RXJ1M1JJN3RmOW5XOHNQNnZlUERlZFBZTU9SWDA4SitBeUZEUGNn?=
 =?utf-8?B?VVFyTVhlU1I3MFZtcHoxWDMwUVRacmhSMnJkZ0RKb3YzUHpFU0hZRytraENH?=
 =?utf-8?B?V0pPZkI3N29PUzQxaXBkQm1KK3M5emsrSDVISThUejdMRmpiWklodFJ4MS82?=
 =?utf-8?B?TWdhRkhJMW9kb08wNGpJQW5BdXNmOHJNUmhyTXBOa2FQWVVqSzFKbGpsL1k3?=
 =?utf-8?B?OUtYeWxVRUJ5UWFaMWxSYUtzb0dYcFBTZ1RWc1NvU3RZM2FEVHFORURqdjVn?=
 =?utf-8?B?K0xxVCsva25yUGN3MkdOOFdOeVJlTmVkQklLMFRiTEUrS1FDcThTdDlJOUNR?=
 =?utf-8?B?OW9ZcHRqMkRIMmZBazIyTjdhdDJ6Umx2QmwrZkNoUWlJQStLZFdTeEVMMXZM?=
 =?utf-8?B?ZmJ0bGVFQWh3TFRDQmR2QkVuaXV0MFNZOVFQNEkxbW03YkJuamR3T2VlcUF4?=
 =?utf-8?B?Z1FXYUo3dEhPTjl4M3YyUGg1Sjh6Q3RTNkl4NHFvbXFySElzSDUzY08rZ3h3?=
 =?utf-8?B?YkNCOW9ZV2pGMkEzQTVIaWRLc0JDNWRnZnFRUzB6V2lxcGhIRHRJdm9OdFJO?=
 =?utf-8?B?TUpiWC83WjNHWGxJdldSYkpuWmd6cWpUQlk3WWVSUTVYQ1FST2JiUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c3a1f-b777-4e6c-f1b3-08defd3b67ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:14:32.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5gj+fPBYpoV8anfQNQTEkTEAyIGEOWE3Vipx0vFCtUJLkAf7O62+ebC6dvjNncP+6Vk2cOQx5XAxH4Yp0TySw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

On 8/4/26 1:47 PM, Kevin Traynor wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 25.11.3.
>
> The planned date for the final release is 20th August.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.3-rc1
>
> These patches are located at branch 25.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v25.11.3-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests (See https://doc.dpdk.org/guides/nics/mlx5.html for 
supported features)
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

Environments:
- NIC: ConnectX-7 / OS: Ubuntu 24.04 / Driver: DOCA-Host 3.4.0-085000 / 
Firmware: 28.49.1014
- DPU: BlueField-3 / OS: Ubuntu 24.04 | DOCA SW version: 3.4.0 / 
Firmware: 24.49.1014

We don't see new issues caused by changes in this release.

Thanks,
Ali

