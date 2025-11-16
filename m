Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858CCCD19A
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FEF140648;
	Sun, 16 Nov 2025 16:27:22 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69]) by mails.dpdk.org (Postfix) with ESMTP id 3DCC7402E3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 16:27:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s02WG5rmnX5sy4rncMPJNcJ6XqZqg1u19jzqTOe5OPCtuq/8U+MeFux/7juhar0xCYsr+JNwR0K6oxsOlJl29nCOrllLN+lNR3b6Cp4nu1fPlcooq15A2qLSQEHK/x/s/S0TpvNnaFiv3If6c8Q0vhsaz2RpYW31XT9QshnRpvFB98qblIPtS+mOafpq4qi25i3PFAtux+N3aFduh/9GB+AyjSsR8+FZKz2pcKkhieC9n0rIDSiIYuyz2auxT4OrHaIRwlzTKJts365UEdAoHzL3jMClCvvsnkoihNbsnvQxSnh61KVjVXL8y2lWJXBkrgkd2J+PN7mvS7mBqkpYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuXmxem8lZQEPJWbhyPmrjwGDiOlIi7IZUoJEtvel5Q=;
 b=BJfB/Y5/THfhSTRfeIgNQmBI2oWtuj+tVdIsL1/OOrFV272o5VjCggqnk4c7ZCj8KzgnNeEvFXqv+UszcuuiPDgSHA3wx3ontqd0fqReDzjaBAHyu2RSMIXw0u+f9iqR+mvtZ7GQLpjRgvdtA85vsQO2Atd5PmICOoc3Ok/bokqQIDio8PGGhBP03k8ppnE86+TINSSvERNieKUKyuk5KfxAkfz8NfCtCrh0/K0y1Nc31VKGITy2q90fTDeDM7LsQoTP0d4kab33aqDe8jJY9IMmOp7bHrxp3xtXzpZApCxQXrVrljH9tSb0pw/SwXsbG+jY3NTKB5VVyCzs4jGSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuXmxem8lZQEPJWbhyPmrjwGDiOlIi7IZUoJEtvel5Q=;
 b=K3PjeV1axLnhNHQc5Oc8wHEU2r89xYHMDVgnpIcIMu33zrMigf1m2IFpIswc9B2PK6+PZjp9CENEiznG1mErSe5B5zwOqJ3FWpuR6iDUWknyvcfXPd86S9kZspXUlxOhLVhGf5FAbumxg7C+tcfzJtCbMXJV7ajPxsabx0nuulCDlydbNIIgIkBqUpPHXF9p4aMdvhsnqeVjFrNudLGxJvf1wiwq/gRE5Es3fBv6nI6V/R/ts9YDTvR0zHD2szDus3Zt7kGuQ2v3LQjyvyNWPdvSUGpvo72WVUH0p7ccywUGrdMitS7tcIOUtCIJVnjJDgj6Wip3yu/fCPNvfLXmbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 15:27:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:27:18 +0000
Message-ID: <a0dad037-5377-42a1-b37a-0014e78cd24e@nvidia.com>
Date: Sun, 16 Nov 2025 17:27:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/mlx5: read SWS capability bits
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251106083817.166689-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251106083817.166689-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 261bb1b3-d028-4b29-ebe3-08de2524a0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emxFbHpMMzhmaWRWaWdzVWVKWGNWZktOcDlsY09Ba3JvM0Q2dDA5ai9mMkJh?=
 =?utf-8?B?TUJCSVNMajUzQW9QemgwZG9aTEMrejg0U3ZCMFZPaWJtRmJvTkc4SDNRdmtm?=
 =?utf-8?B?Q1RicFRmdDZZR0VLWWh1Wmc2czQ2Mkh2SEdKb2JIUWpwQXdyVldvNW1vYUZB?=
 =?utf-8?B?b083UnFnckZ4Wmxvd0RILzFVeTdvWkltbG1wZGl0QUJndjZCQzVMTk1ZZExq?=
 =?utf-8?B?R3JZU0REUjJkVy8yMkNlcGw1V1JvSEdKSW1oUmpYKzUrV0tiSEY3UVQrQzhj?=
 =?utf-8?B?MExxRmtzMk4yV0l6VEJkV0FQZS9nVmRSb3ZUWHYvY2Yza3FIcVZzOW50b1JH?=
 =?utf-8?B?N3grcjlQamlrL0tSaTM0ZEhSZjd3UUtLU0VZUEJYcHdXOGIwSzBNWFVObnJF?=
 =?utf-8?B?QmRSb3ZNeUdxY2wza1pUTlR4T0pZQWpzcWVLamlYeCtGWmFiRkI4RVlsK3h2?=
 =?utf-8?B?TlNOTlJjTWg4eTdPS3pmMHFTdVR6OWZDSWYwcDdZeEd4L09LaEF1TDFtNlB5?=
 =?utf-8?B?ZEl3MVc0TzR5VStDZEw0OU4zVlJvNVZKTnI0d2ZBd1Qwc0NWM21ITVZjb1JN?=
 =?utf-8?B?b3RadS9YbG5sL2Nmbktsb3FKM0NXckVJWXpjNC9NVHhpVVlBZXFuUnhHd3px?=
 =?utf-8?B?dUtNc2NsQnZSRkZWMWZlTjRKUVBPOVI1dFp2YU8wcWRMUk1lVWFiUzVKMWRP?=
 =?utf-8?B?TFF3bFNERCtGRmozeGNPNS9tSzVhaWliNzU4dmdDNUpoSDc1VXljdHllNEVk?=
 =?utf-8?B?dFcwbTdrYlYyV0RWMG14ek9IZ3J2ZjYvd3RTTUY4cUpIMk55TUtpbGJxV1li?=
 =?utf-8?B?K0c1RTZNRHkvaEdndlVKbGd2MXdROUtRZjZTREwzQWhyWGp4M2QwcVNVS0Rn?=
 =?utf-8?B?S21yZmxSamhCUXNQV00zcXV4TWVyVjlOMEhBN1dDbTVuOUYvVEFUOXgrRmYw?=
 =?utf-8?B?MnZjdEZGM3dJY1pabEtPWksveVRFOTlDc0V1QVRFRXB0R3lvQUZ3Ym1NSXFV?=
 =?utf-8?B?bkQyVnJMendGY2d2bXFXSWhIVGRTbnNObVNLM2F6VFRFOFhiTUVoUVUva1Vs?=
 =?utf-8?B?Q2U1NE5ScHFXa3BNUmNUalVYeWUwNG9ZR2pTb0IrRDdMbEEvdmFwUFRWSW5r?=
 =?utf-8?B?OVd1Z0F5alNkK2VMN0F1UWdhaHlLRVNRb0NPcGEzTW1ESTNrWUthKzU4cVdv?=
 =?utf-8?B?V250dzdOM29oaERJM3VpNlllUEFYZVVBVW5MWU9INnZHc1VkZFhnWUlwa2RO?=
 =?utf-8?B?VUpDL3d2b2pEUkZSZk9hZS84MTU5cWtQV0oyL3hPdTNyRzFrcFdMTTlkNnhm?=
 =?utf-8?B?bkQ0aGhWSjU1NTAzbXhVMGlSV25jaUgzaUhQZEZhL0RNWWRFN2o4MHJDRnZj?=
 =?utf-8?B?T1hhSHcvVnZ3YVJvVkRNL1lDcHN4eEZpb1ZmYlQreUIyYlNCNUdwOXduZUdL?=
 =?utf-8?B?MkpaQ1J6QzNTaE1QdzFZU3dHa05DSkpRYm9VMndNZnc1YTg2UHpPeGhNRGtX?=
 =?utf-8?B?a0dGTy9pR3NFU01zNzVFVUg0NkpZVWRod2QvcjQyZU0xWHd6dWRHZXczU0Nk?=
 =?utf-8?B?YXYyK0FGbzZXbEpiUHZreVY2ejVxOHF4amU0RnY2NG1JQ0VtZzVWODBkSWE4?=
 =?utf-8?B?bkRORWFiRVJ2SjNpK0xmVml2ZmYwZUd3dXZCOUJubC9qOGc4SE9oTTVtekw5?=
 =?utf-8?B?UzJiOTFsc2k5OXpxU1lBVHg2bThmbndmSkxIbEpwZjI3d0htUGJxNHVBdmVv?=
 =?utf-8?B?RC9sRDZpc01teE5sMm9wbnA2Mnc1clV6V05RNWJFMktzNTUwOVdTQm5lZ3Rv?=
 =?utf-8?B?dzEySFBPTmdZZncvc3RJUGkwb1pMaDRqWi9KK2Z5MUdIbEVyYVNEZ3RNcDNO?=
 =?utf-8?B?TGI4eC94S3l0d0hwMTRZMjVrdnNyOUVRT1B5UWw5cGhmQnk4akZrSUVQQ0k1?=
 =?utf-8?Q?xDRR3ZQO0eS7wWE6WQGyyAjqGuC09bJO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZ2cXFDazhSMC9mYXI5TzFrS1pVekRhWDNNR1hZRk83N1hWdTFQQ1h4WVhM?=
 =?utf-8?B?M2FUek1FeUl3TmJQK3NOYXZuUTlqdDRVWVdSaUJVcXlIMEdLd2NybWpRK1Zy?=
 =?utf-8?B?WnhzMGFLazg5OFZtWnQ5UWthTWJwbTdmVTdwMWw0YXlWQllNVnJJUEQwWlpQ?=
 =?utf-8?B?WHVTQzlRLzdvOS9OM3JvcFVjdHhjSlM2Z2FEczRtYXJ4UzZlSXI0ZHN1Mkx4?=
 =?utf-8?B?Uml5VUk1TlJhM1BNWU10SS90N1lMUE5wWFRyMnNRVlJCQ1B6SFdMd2RBR0h3?=
 =?utf-8?B?SFJjTXE4clBka1ZnTlg3UDdzVUw2TjhVSU5HMWM4SjFHc29Dcm45SnlKOXhx?=
 =?utf-8?B?d2dwMFF4ekNDbHRhUUovL3FteVlzc0pUUmpkMjdwUEYwblZkTEVKR2d0WHov?=
 =?utf-8?B?WTlubFVGaEtSVEZqdk4yYVZLOVM4blNXNnVvWTdEYzJPTnRsdWlVN2VjVWUv?=
 =?utf-8?B?a2oxMVh4ZnFNbXRwS01MVHJLLzlGTmZ0a0d4azF1cEYzaythcGNPalJmMGpM?=
 =?utf-8?B?WkhuWGJ0UHZDNmUvRUg4UDlCaDhZa0FIdW1RYlh3KzhoT2YrRWFpZ3l0UVpD?=
 =?utf-8?B?V2YrcGd4cDhkRjRtUEljUXhLN3R2a3ZCL1hKcFphdnpLZmRyR0trdDFHT3ZB?=
 =?utf-8?B?SnU2cXN5T2UrVDl3bUh6aVpKWGF2aTNqTGZ0ZXZJYmVmZndKL2hTRm01Vnpi?=
 =?utf-8?B?T0tIbjUvakpWSlByU01iVHFwWHFtVUliNXhJKzFmeGJaY1hkMXdmQ1dqUUZP?=
 =?utf-8?B?ekJDQlRHY1RqQ2VHU0xKSDlYRGJFWHVOeEx2OU5GZm81ZkJ4ZjM3eG5VUVBm?=
 =?utf-8?B?Y29teGM5REJDeXB6bjZQTjdqK05PU09KdjYrS2tnYjJpdXgvSWNldnkrQzA4?=
 =?utf-8?B?MmMrbkNmTjlTL2xoNFZabWNQNnFZaDZZZVFlR0VDSzNUaDdpb0ZJZlVkWWJD?=
 =?utf-8?B?c3M5eW42cFF2TVFyQWE1RnhVQW0ybll4S2dNRzFHdEY5eXlacmswdDNyNjlI?=
 =?utf-8?B?dk9tQ2JiOFU3NUtCUjIrMlV6cXI4clNmZHp2elY0Vjk4MDhSeGExbDRnbzFq?=
 =?utf-8?B?SjgrMkhXNlduTUpJQ0hxQTlvTC9kK2d2dG5sWlpJZmI2TERZOENoTzd3eE9U?=
 =?utf-8?B?aFZNQ1dMajIzT0hDZkpGcnlkTks0MWxSdHlhaGVyYzQ2SklPbzZIK2RUNlp2?=
 =?utf-8?B?MldHM04wa1JsN3JwSmZXYTlpQTZGWkUvUWJITnZXeTVlQUxlYXFwdFFBd0ZM?=
 =?utf-8?B?VUp5QTdkQU5uZ09IV0RBYXdjbC9OcUR5Q2ZjWUZVb1BNZTJhdFh1VTBhNnNK?=
 =?utf-8?B?c2dyQ0hlYmZOY0Vrd1dqY2lxTjRiNGp3N0xUZ2htRE9Pakw0Wm5KalRmMUZu?=
 =?utf-8?B?ZmpFNVQwVVFQcFh4d2hQSEZXU2RXUWlKL2Y5ZUt0RlErUEZGbFVHQWVTOFVa?=
 =?utf-8?B?Q1ZUU3M4emZpK3AxYmNSejhmZTMrRkVybllqQXVwSytzNWoxaS9FTXBvRmIv?=
 =?utf-8?B?VDVlWjVXclBrRmZxS09wNmVOQWtXVlBrS1lUY3FuWEhGQWxkUWM0Q0Fydko4?=
 =?utf-8?B?L0NxajhHM21oWVBaL3VjUTIzbzZwL1AyUXUxUk9JZTFVeXhMSGI0Sy8vczBj?=
 =?utf-8?B?Ym5PU2dLOXJkQXlBWlNNNHkzQWtyYmczR2d4bFA2bjhjVlhzL0xIWnhQcGNO?=
 =?utf-8?B?cHJFcFJ1QUpxSFNMbTRXSnpXOXo0bUxIaXJqd2JtL0QyakVrd0x1OXh6UjNI?=
 =?utf-8?B?V2s3WjBCblp3aTR0OElXRkRrcHRWRWJRVzFJRVYyQ1gwSTRJc1lMeHd5Q29R?=
 =?utf-8?B?QjczWFFPN1F6VGpRYXdJd1pvUE9jS21hYlowTG9qSUFIWGVvOWp3eGE5MHFN?=
 =?utf-8?B?dllRVnFZMTZGVHd2UVc3TTJrTXhvQk5iY1JrTVppS3VxUWljR21CV1NxclZs?=
 =?utf-8?B?VGVGSFI2N0wzZVdPRFMrOUpvUHgzWUZ2emZ0bUdCZmdZa05qZVFqSDhGU3hs?=
 =?utf-8?B?WG85TjVDUzRFN3FxV2dUc05CeXF6bXNocnQvWmFXaUJvaXN5T2tuRHhRN2p6?=
 =?utf-8?B?MllmdmFXQ0RKNjdWd0Rhbng4QklVYXZUaXR2MHhDYUZlakRmN3F6UXFIOFc1?=
 =?utf-8?Q?jLakFQSEoqNw+w4Ow+ECKPPZp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261bb1b3-d028-4b29-ebe3-08de2524a0e5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:27:18.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NE+2dSeD5FA5Ubdd9sRK7rkrWqSJgrce9fvzY5jQXAtWBn1uUWX/AXZ/cEobkSNtPgLuiSFfd7zdVzQJwJhzQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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

On 06/11/2025 10:38 AM, Maayan Kashani wrote:
> SWS will be disabled in future HW generation.
> Checking SWS capability bits and returning relevant error.
> if user configuration is not supported,
> will be added in the follow up commit.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

