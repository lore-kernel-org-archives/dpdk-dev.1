Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CACFD004A
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 10:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5DF1402AA;
	Sun,  1 Mar 2026 11:33:56 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24]) by mails.dpdk.org (Postfix) with ESMTP id 98FB640297
 for <dev@dpdk.org>; Sun,  1 Mar 2026 11:33:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAdS6MJG0ymcp4k/cSYH6i4EpTq8091YCV1cFQz9XQZnlR5c9HCrRIYLvHzlOgnUMRCvlygbJIK6Em13G+jjtxz923P0XT9Q8gXQ6DOLzXCnW3n/7ovzah6w3iVzE/uHT455rTrj8JC7nqsAPeTBsgE5qMmlv9cqm/wpL9n3c4sZYWaeNgwyerft+JfsXKPBXCGLg6XPziH5cSp6LTQtJbVOQlFMmmQAu5C+U6I0UfhZZItOl6ezIoxr6hGlHqMGN2iDqh5Mq+WzTJkt7uD5MvOxMB7q2mnZ72R/G9muV0S0lDMDKq/Ho17bQsBxrJ8XIB2YC88qvLOsIUd8LAIP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLy9z9FCZxBbcfaMkbRfPqnUiG4fJh+GuKRWOj9AuKs=;
 b=ZlnplRUM7baNw0NU8/E4XugMGmAcARQ6aUYOIg6trzALCyjfl8yVrNnklOfuUN7TpSOW3VEtgkhz+YGMSXctcarG/bED3v0pZq04Qrskohn1hT29EGdYJCaKysyS45ue70f3t7DmV9Vd+GG8C7T+Nl0zDJn4WL2DnGBkt1b6eZJDTYbeVuLHkbGD11Sckc1SCzLVuYhPjbOSOk07nPG+EvDrr2aeLhVlQBYZujuUrOnXuNiLvXXWwZfco5qE5F4EOhR74m73Swn34wjTTxHLmu3ddiJNJMsKPHfc6K5iQx0/VN4ecWaeWgw59x0513Px5NI5l/AlfQnjAajbvIGUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLy9z9FCZxBbcfaMkbRfPqnUiG4fJh+GuKRWOj9AuKs=;
 b=p7GbAqf3ltJzUGmZ3/SO5pNHOtv2ZzxupZba+LvSKwOxkDzJHQytFhp6A3VROIH7YPA2tuSfYI1b517xYyWuwg1NAhdGDOKMAcOCsIHP2iCzRBa0eQeFvgQWvOc1HB0Q2x4Aol4augyIZ38DcjCXOw6J3+o6UtEdmuWMN6TwPYUSnoa0RMeKJeJVsPICZWDwjSLJuM04rJTPF+8EcHBajqF5Tb1klW4SeJKXZSIVwfnFYRwNQrtLfUDTAH95mzXZynjIZ6qLVdK4x+g3myLbF4Z7KgriZMBtjfwXg7lGiR4iWB2HYvzVCDrPYT1tZjMoOfGmF+ley1Hb80q+agpAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sun, 1 Mar
 2026 10:33:39 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 10:33:39 +0000
Message-ID: <750ed623-662b-4f3e-9045-3564d7c0382f@nvidia.com>
Date: Sun, 1 Mar 2026 12:33:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 0/4] net/mlx5: fix several correctness bugs
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260217150635.134031-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 86975fc6-0a48-43ab-3b5e-08de777e005a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 59P81xGll+YSCRwHddBWX2cqCsXRuOeqIytFB8NGp/OazK4n4AHE7FsHRrTmgVA5+enDpTp8XnphDqdChoeCfb34GXz4yvUrGg2pzjLT2wgUuhhri1yRbOa1o1eBXYuHYAAFNLdKEidX2p/kUcaTciTURVnU38cEh57s1621BX9hET7d18cnu6q+qNfrZMzNJ5UxygcZiVyl6tEU57aALrPqlNnSmdG4ZQYD00sW//5EICVCOhrdpxlLAuLggkYQLRaJsnVkSO4YpBTr/TvkZOodx11nCM2Kg+AlxNNV5wmeTmSP87Bs2BdT2losaMYYWrn0SPxT4jjrIaHLGKRnit1jezun31DxjrDXt0h+i2qsDgWi5qBG39iutcUfMOP73FJxPM3/KaYdnavU2dU66k9K+f2cU8Mj8LV5MD8ODsIiTrKXiQjztsEyxtn7/bInJHD9tTYR9Qxbh7rx07RYdvjrwu4Uo3dzyGIXknK0FKxSIr9sD0C6WHn8W8GDVbRMoGmi8fQ9BD8rf041PlB5djNCeCeEyP96JWwIrBIbZpQcINkKkWsVLt7o4Ol260EIs8YasUDndgwUdCWECzTBzbGIxhSauYkQ33y789jZgdpgjajadmJgzcvbKyMyVNF+Q3l2Q90iH/ssLiFH2pbfRC0omT+as5XNEpDx5iXKX9/0Yf6dLO4rktVheRl4uDJZQgRjTPCa1T37Ll5/eleRVKBOcknaMl4751JV/4dgEZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhhU1Zqbmc4QTBvZHRRQnlpZVpVcEFiajZJLzMvaVdlU3I0Zjhjb0tRWklF?=
 =?utf-8?B?NzU0blpaZ0pocnpjdzdMZXlYazZLK0drNUdzbWlHekFPODVBdHBFMnhvWkpy?=
 =?utf-8?B?NGxMYk5DVHR6SVNrU2c4MEJiaXdwMjZTNnJrcTA0VVUzK0RkWnhRbUhwdFY2?=
 =?utf-8?B?MC8vbFBmSmxVVFUvWTVUeG0zQTM0NGNSVHNVU3o0WHNZcDdXc3VHTHJOcDNu?=
 =?utf-8?B?TTBndWZ3cjNJNnlVNVo4bDJ3OHVpMjRIdHFsOGZmR0FUMC9pWEx1WVljc2Rx?=
 =?utf-8?B?QkFuSUVrYkgvOWJpT1ZoYW5jOHp3THlvTjZsYjd1dnQxZThVMVRRVlVISzA1?=
 =?utf-8?B?OFRSQ2ljdXVwWDcxcS9aczFMT3lkSjAwTVlra1dtV05KWEVxckpGRDBzd3Jk?=
 =?utf-8?B?anNkbXpFOFNVMFJPbVJ3TENnQTROM3BndW82bXJTeVVRS0gvR2F2c2JEUmpY?=
 =?utf-8?B?b0kvMDVvTnFMdTg5Zys3SW15NWp6VEU0MzRzTGZROFNUNVpJWEdTWHBZMjFn?=
 =?utf-8?B?Y2lhNzFvTEN2R2RDTDZJWURwSk5tSzJMaUt4U3lXY3I2dXRyZUNCTWpXMkoz?=
 =?utf-8?B?L2tsWlN6S0hCaFB0VzU5eXRrdWwwOTNOcDdUTXVXS0lwTVRHQVA2c2ZMMHRx?=
 =?utf-8?B?eHpkWUpseEdEaFludXkyZy9uS3BlSk0yY0pyTDJlVWRzd1hXcGZMSDFyeE9Z?=
 =?utf-8?B?Skc4QjgvSTY5RHBpT1BEVWpXQ1BHaEVzZFRIWWdtS1pmVmxHTEh0dDUwVFBI?=
 =?utf-8?B?WXVEaTRjM005UFVHVEhDNjNxM3AzVmxFSWIvRGdzSDhNY1N0N2d0OFlSN0Rm?=
 =?utf-8?B?OThmdjJ6NWtoMEVFS3lQSXZYU3dOcUJETzlHSkl1M3FPYjZZNElqUVc4dXlp?=
 =?utf-8?B?R0FiQ00zNXVINlVLVnAxSVRRR2ZyY01ha280L0wrdUdWd09PR3dkL2ppNTBB?=
 =?utf-8?B?S3FWRERjMjVwaHgxZWk1RVNZdlV0Zm5pMHZyWUZCYmIxdzZjZklBekJvRWhC?=
 =?utf-8?B?RDkzYTFlSEg3Qnd3OUxPMC9UUHBrRXFnVjd4U002Q0pGdkNYZ0tOY3JYQmxC?=
 =?utf-8?B?ai9YdGVJR3V0cGRXV2ZkMi9XREZKTGI0U1VEZVVrZHdFVDYrWDNybXZ2bnRW?=
 =?utf-8?B?QWF6NU5QQVJnQU16b1VLZ2NjMjlMMWVtSXkrYWlET2pkejM5VitRNFE3akdH?=
 =?utf-8?B?OXFoSWJxMTlRNlhvVitjaUtORkVBemM1d3ZkVkZrNmVsVS9nKzdTZzFIMEpE?=
 =?utf-8?B?Y20vT29ZcmI3Rmd1b0k5UFE5cEJWeXdvYjdWSmsxZVljQnJqNkJNbGlYcVNy?=
 =?utf-8?B?ODJIR3NSY05LMmxUb3pBYllPOXE0ZjZ0Yng5amp5THFOMXpUWnVubVloU1dQ?=
 =?utf-8?B?UnhtOFkyaklDV2JXWmZyU0ZaZ3lRUEJXYUtacENTaFlkWWVTVWhjb3V6OENI?=
 =?utf-8?B?bUlvNmFTdytRazVad1c3NjRocFU0OHpDN1pXemdWS3Z5cnlJOVVaZ093ZkI1?=
 =?utf-8?B?Rzk5dks5dHRJbWxjNFJHaFM3bjNtT2ZnMUpWbEdVYzZXUGRSYVRxVUVzb3dR?=
 =?utf-8?B?Tjh3bktmLzNMakxRNTV5TFAyaEk2SndYZGpML09HWXYvaGpoWlBvZGp1YU41?=
 =?utf-8?B?RkpiVWV1bEF0bWhXWWd1UlUrb3lHdnVjaDFSN1paUkhvYnpXV0RBcmd6QVpr?=
 =?utf-8?B?eWJhVWhaODBsVjBEZ0g3RHJFbmdudExhcEFySlVvVHF0am8vVlZETmZMU3FQ?=
 =?utf-8?B?ZHlMcVIvQ0RhOUpodUt1NEVjejFQTnFocEgzTXh5TmdvOXUwcXBNNStIUnFh?=
 =?utf-8?B?aUtHa0hVbDVJOFU3S0Q1Z2prWFJ0N1hhZVVmanpVdmQrTGhMTEE1dUloc0hV?=
 =?utf-8?B?T0U4NG1Xalhtam1WZStaZ3VSb2tESm02dks0d2lVcjNwVldFMVViSi9RNkZU?=
 =?utf-8?B?d0xGRWRWWFJndTJUUkV2STdJWlYyYUZKejJwbUVyWUlvMHdqZnM5dkZESEJT?=
 =?utf-8?B?aE9vZFJZV1d5dDExNE9OVTJsWU9VbmlGODJ1c01BU0dGaUdldFNpVmkrdkVG?=
 =?utf-8?B?SWpxaHN4bmYxaS93NTdxK3h5WjhvTnFpVXdSRG44VlBmREo2bXJXVU5OMHZR?=
 =?utf-8?B?VFk0aVVCaTBxQ3pxdDVnbUwweEtPZDZxUEJHY29wY2ROVmc1WkFFRThCMjIv?=
 =?utf-8?B?aW5yTmFrcDBoMDU2V1Z0VUZHS3hQdktxWnpHeHhGNVQ5VTV2a2FkcDM3cjZp?=
 =?utf-8?B?QStzMEIzRXo3clBSaEZRODZ4ajdrQndDVW5GZFVNYXBzNmhiS1VQSTc3aExN?=
 =?utf-8?B?N0FFRE5TZ0tHK1lsQm1nZ3Q2blBjR3RxV2U4bGxMbWNHU1VyMTB2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86975fc6-0a48-43ab-3b5e-08de777e005a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 10:33:39.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58Tx0PY1HD7jIWvmEgQL7kOns2wAVeR88kja6cUp/ae0Zuuk643IqftF1XS0JzD/R+YbICCHwSNk0U4BPm/4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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


On 17/02/2026 5:04 PM, Stephen Hemminger wrote:
> Found these during a code review of the mlx5 driver.  I don't have
> ConnectX hardware to test, so sending as RFC for maintainers to
> verify and test.
> 
> Summary:
> 
>    1/4  NULL pointer dereference in mlx5_txq_start() - txq_ctrl is
>         dereferenced before the NULL check one line later.
> 
>    2/4  DevX queue counter leak in hairpin counter setup - the
>         counter object is not freed when the subsequent modify call
>         fails.
> 
>    3/4  Use-after-free in ASO age and CT management init - on queue
>         init failure the management structure is freed but the
>         pointer is not NULLed, so a retry dereferences freed memory.
> 
>    4/4  64-bit counter truncation - uint64_t* cast to uint32_t*
>         leaves the upper 32 bits uninitialised, producing wrong
>         hairpin queue statistics.
> 
> Stephen Hemminger (4):
>    net/mlx5: fix NULL dereference in Tx queue start
>    net/mlx5: fix counter leak in hairpin queue setup
>    net/mlx5: fix use-after-free in ASO management init
>    net/mlx5: fix counter truncation in queue counter read
> 
>   drivers/net/mlx5/mlx5.c         | 13 ++++++++++++-
>   drivers/net/mlx5/mlx5_trigger.c |  3 ++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

