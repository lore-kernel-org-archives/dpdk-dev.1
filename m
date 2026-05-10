Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA4CD37AF
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 09:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2458C402ED;
	Sun, 10 May 2026 11:00:45 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5513F402BD
 for <dev@dpdk.org>; Sun, 10 May 2026 11:00:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcv+6C0j8tEmABPYry8Bla0vk39xYvMZgMEUt5LcGjQfHkh1VuMDY7kRO0priQVn8ZZPjqOsJZIe2cDpvAmjrOl6os/g3xlLOhi2+aOyTT2ZKoi4sz8AQKxkyVgcIBeTkvr3d/P44NTyEROlth3YVTBNAtGSdQQcTHOvOT+CiGZcrI2s+GT/ci/zbtNopPZpjR/vIGtpcBqiwp0wAiFOv6k/zqqpaYiklP+QsUoOS/7Lu/AfMiwyLzDBIf7O7RYb89iOVZpdsJ3oKwUPvQCxipQOMXFORz2VSGgOeSRc+cakDZ/9M+TN5ELcv79zNBZCmNfWTPkQMwJPZy+SqCXQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haN59endEDzrgAN+NvlCJwAzg16DyjIuEEDJqajGjvk=;
 b=sLhA4Jv/qDhHEtkPtyf04II2PPXuTTHyxn3a1oMX/OAt/FdjDz/pg+Cn9Bm/8jsdR65Mrb9dyx48chMowmaAmfYLTFpQIZRQ+OpRvpSb9ZOle7oRYpzDRs07RSqVe2w7ag4dqNrJpLL4AhQtKQ26scnYeePBqjwYZB4JU7YJNX/AHG+NrSQTwNiTxq1dV4Uf/lDk1wdSdvtFwiqJWUIXoxljevB8bpsV+EOVCTIxjTh/kXPXdrrBWoxI0TAZLk6qtR6y+CXXiAXb/cJRGvhn8kuIwMkmgBJJK1hbtQoeQ6THyparbZBPubgrAK38Htdoe4i6be4N3jL2NseDFDKBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haN59endEDzrgAN+NvlCJwAzg16DyjIuEEDJqajGjvk=;
 b=GFVYJSOIAEmsbPJo7hNdobY3D1sX+cKiGfZTHa7fR7vbs6b1SLRFt1LSXeB26fEYaZ8TIAf8YJkm7suNVDhjVRHpgdBzsmfeDFzAYVLhc4h2J6B+CTanoegVJp3yAq0sOegHrzKhhpUSdV+kKFTurkTr/bl/W9GXs0vjN4IzyPPYVwnHWyOgUFjIKNd2HKTbavbmGJQl66v6FtPfPrwvE97t+YSL8JojzaNgMFthOGUdSM68sAdn8NmBybDN/OslZNxvAGx18rF2wsR1UfCKInN8Dp0U+HWZsNYF7JI9Czxy6NoG/qvGyv0npyGn8rK5aPCiA/PVYFLS8AFGu7W0bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 09:00:39 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 09:00:39 +0000
Message-ID: <a36e7f28-b6f8-4f83-bbf0-5f8b80f479be@nvidia.com>
Date: Sun, 10 May 2026 12:00:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/mlx5: add ConnectX-10 SmartNIC
From: Raslan Darawsheh <rasland@nvidia.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, dsosnowski@nvidia.com
References: <20260419111721.7301-1-rasland@nvidia.com>
 <20260420104856.14187-1-rasland@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260420104856.14187-1-rasland@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e207fd-9cea-4da9-a749-08deae729b2f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: oRB3uSokExk9kXzeiDCc2+iFsg6MyDIAXFUqXbOLGq/QRSSNVqmoIOtTlwX99iALnrpH0R20mmgtXYS/SzsrKiJYVJ+ZBvoCis7AJbxZJNpAIoiGLtLNBrF5bTRj/165FU3qDdafC1PkNGRD9I9/GLRPSiKTYx9HJ+TjjdzoFcuGUS9nCbzyQZjLjOdAuzobr+QdtqewGisKHL8QId14q7B9JKmEik0kzalEVFh5/YbjC6mDE9QClRrLLY22aLtRGZzu+hvtDwuy7nhBtiqVmbkE5g2xZeIiQqbbQRaR2ukDjDCcFrYh98VCMUVu3LjP0WwchFcaTnv5/dTdR0oabKpRNxo09+ASuOBYBroIhI1b6LMObEqeOCBbVwq3QNp5OScQR52Y0joY82j8lw84dxltyEOtmXbyRZDw6Bf30iQ1xoSBSbIIS6dmvM44thtgCJ4CTqF/eVuva0AOiYpFrdJa6+KJteNhHcIDPi6q+jHmYdSy6vpDQjo1lVozzMT3ZN6zHZPS9pKk8MXAP1L23Wyk9X22QGgajK8WJ16pYRIN+9Z9BWd5jzRb7zAQ8WJwbKyNmYn2FglYJriYZ2L7xfsa9YFkiW0H7hSCKi751Ip7u85but8u7HJUgFneyaSOWDdV06v+aQcqjcRQRfxRGslegOjuSqhookL7o7/+P6nUe7xTWdSOlBJaXVmq+7U6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1p1Z1NOVllJU1R6NW9ySzUyeUxoRW1VOHl3L2x6dUF5TXMxcjZYUm9OV0ts?=
 =?utf-8?B?RzZKVTUweWVzT1Y4dlRvOUxZYnBNbzM5TWtFaFNvZm82cTZaWWdJSGwxZG5E?=
 =?utf-8?B?Y1ROZU82aytqa2ZST1F4ZEdxcmNWV2RhL0xFeEFQZGYvcjFPenhEOENNK0Jm?=
 =?utf-8?B?ODFvVksvbjluRGE5RUljSVZ0enAvYUZqTklHN1ppNE8xdkgvbkwyVm1wbFZ5?=
 =?utf-8?B?YXBqcjBqUjFxcXZBa3FDdVp5Ukx2eEp2TmVYUndxMExKK1RaWjA0YTJ2RzNz?=
 =?utf-8?B?NWpMN2VGV3ZSRG5KeWpqYnhaamVTKzNpeStlTStLaUxoeGp2SDNScjlGZjVV?=
 =?utf-8?B?SHJqbmdvV3luV2o5WGJLb0lXUEo1cGN0Z2pSSnIrWXJVMklMbS91ZDI1RWdD?=
 =?utf-8?B?QUVMYThGWkFzQVExZExqYi94UXB5cnpEc1A3eGlPOWJDeW0zODZSWjNRY0lz?=
 =?utf-8?B?NmZqU29EMDBXVG5BeWl1Tk1VcHphcDFTMEcwOGw2bWhwbmhReWxuWGZUMkFm?=
 =?utf-8?B?bldSUHZaUTFqZG11b21DVGVrMzFGckVsZDZFV1JLUGE0aFVLcVBNN25KRHU5?=
 =?utf-8?B?dVUxbk1saDlYSCtJQTFCTUJmV0s0RElkM2hMVkcybXdZQytlSmRKc0RMZ1ll?=
 =?utf-8?B?azR1RjJLa3QxSmdsbzA2dnJvdjVlV2pzQzRESVRHRnZFeEpHSUJTTTI5Wm8y?=
 =?utf-8?B?YS9YMlBTZWphZTQrUWxQZndSQXZKZ1lxYzVnUVNqb3NCQW1xTjRSbTl0d2Ja?=
 =?utf-8?B?SFRHTU44V0RHZGRxQUlkdjRzb0NvVm1LZ29NczRjblhZVmJMbm1hY1IxTHVB?=
 =?utf-8?B?ZytLNU12aXFDbXhVYzVsTnY3UmJHZHhxa2d3V3BySFY1c1M4ODkrckVwV2Q5?=
 =?utf-8?B?LzkxMUdlLzFJYjZaTkIwWEdFcnlQeVFBUEM3SHB1R3EyVFdYMXZjVWdxTWtt?=
 =?utf-8?B?L3d1N3FTbzNmQTR3S0szUE1JZXNEdFgwV0MxU3lqckJKdmFZTTI5NEMzKzZ2?=
 =?utf-8?B?YS9hUmNJUmxRa1ljWTA2TWxGOEdJOEV5QU55dDZ3SENVcm91Vis0ZE5wV2RC?=
 =?utf-8?B?OEhwNlc4clhlRURESTVHSThtVXNWNE1KOS9xNWJpZktNL21rYjRSMGVrRVJ6?=
 =?utf-8?B?dGdKOXRIeFlESHhUbXlKR0t3QUFTNjM3TWhQSFJMK1d3QmNkUEY4VUpWNkVq?=
 =?utf-8?B?STBlb1Ria1p3emNBbi9TVVZBNWJDWWFsOGo1aW42dkFJaHQrei9BNXQrMDFZ?=
 =?utf-8?B?S1pqbDZ4RTRxS0xSRWpRZ0NyK2hYSUM4bzQzemIvUlIxTWEySU5NSjdPU3lB?=
 =?utf-8?B?RVVWUVJocUFnMnlIUjYzMGJVbW5WVWxDNGloWG51bVE2cER3UlRiSFdKL0dJ?=
 =?utf-8?B?aHRNb1VRWjB5ckdWSDlzdGg1STRBeENKb09OUGRERkd6VlVjRDA1U3ZFZ0hK?=
 =?utf-8?B?T0JaK3l6L1JFTzJBRjRQQ3pLNFpLMS9aY1dXYk5jWlNpdzlReGdIOU1IL3Bn?=
 =?utf-8?B?SjRHNngwYzA1dkNMKzNLR1phcG9SS0JuMTQ2REU0MlloUzFOZWlqSlBKQTdH?=
 =?utf-8?B?ZHdYT3lHYVd1VlNJaWZmWmJaWUZhblJkMzJ4MlpRajh6aDVMOGx1TktHclNw?=
 =?utf-8?B?NUZGZjBuWS9QbEhiem51U3N3MUlWcXNlN1dHeXNQTjZldEtsWGU3a1JCLys2?=
 =?utf-8?B?TTU2dzhDMTlMQWlBZFY5QkR4YThOZzRHcXNKUjJnTmZmR1NkRWd1MDBxcGc0?=
 =?utf-8?B?YWpnRHRtRGs4dlhBYWdDTHNLUFNJRnk0V28vZ3poTlJCR2s4SFlpdUt5bjlC?=
 =?utf-8?B?dUZ6d2V0bWtmK0JabEZVNGVFYTVUdmdUeWZiL2YzdnVkemw1bDhZZmQ5U1pi?=
 =?utf-8?B?RG5HK2YvOHF0RTFHeTNzL3EvY3FoWEdHc215SFp6eU9tOHl6VHJtckxWKzhI?=
 =?utf-8?B?QmgwS00vS3VwdU50L0hNdENFR3VYNWYrZkI5L1VVS0RWak5CKzZpd3ZPdThJ?=
 =?utf-8?B?TjhLc054c2N2M2dXZ2VoOVRUNmgrcjVqNE9WeEZGOE5SUzdTWW50b2hmVkZO?=
 =?utf-8?B?NDhBVEJvL0J0cTEwVEhiVitJS1FsSVkzR1NjT05tZmlKYVpBV29wdVFGaXo4?=
 =?utf-8?B?VWJ6MlZoSmlXS01pajZ3YnNaSDE4Z0ZNN1BmS1RwYS9wK3h0WjcxMUpsRS84?=
 =?utf-8?B?UjRqREJabWZ3UHdYSjgrdjlkcXlKVHNXZzYvUXM4aFVkZ0MwMkFtZ2ZOS2N1?=
 =?utf-8?B?aG50czBRZW1WQjNRbnJjZk9nZ0o0alV1bUlRazREU2MxMWt3Q213aWg2WnAx?=
 =?utf-8?Q?izdMdwy/VQy6QiOTfy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e207fd-9cea-4da9-a749-08deae729b2f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 09:00:38.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji12K1niBlWghVm7uWj4ikM14+eje4uc87EwPYoL+X1XFPTP2KHJiQgM686rHqUepnPN53ZjoMUTMgwAG7qWaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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


On 20/04/2026 1:48 PM, Raslan Darawsheh wrote:
> This adds the ConnectX-10 SmartNIC device ID to the
> list of NVIDIA devices that run the mlx5 drivers.
> The device is still in development stage.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
> --
> v2: changing order of devices

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

