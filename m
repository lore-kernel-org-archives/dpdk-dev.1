Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0DCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 12:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 288554113C;
	Thu, 16 Oct 2025 14:10:54 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7EB40EE4
 for <dev@dpdk.org>; Thu, 16 Oct 2025 14:10:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2fTSyKksa4eFEJqZLHykSEWsU6zJYTSFqOyd5eXtgyfKlcLUVv8z+5t5udkKfObrq3HVZQfAvrNCjYHWe4uWmaSup/y5y8Iv9l0OC4/KReEn1VtTNs49IBkiBFVT6zHyDG7yw5vyCfR2vekvtLwGpWCXqRXmCxKC8V9UAMMNnrAyOOSo2ZCvrdpD4AdLrp7pszFrShua5zzyT+AkRPZozSLGMCmf0O5Ml75VRx3vsiurHzuJ5AwaDrvPNkFVxH9CjYUy4KlliY3CKhviwFY5KFOMnOn9ID2bK8fcvtcuOfcaaTrZ9F6PECbCvjhIG542qGGc6pVmHnnLgdq0mMs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4H5HRR6jSEh3iFj0uqmSHNT/gQbKSnVUXwOOvEHSiM=;
 b=N3Pdfsci/1uU5oYZBG/uKMCAvHBXXvJR9e9k5Qt1NDJCQyIjMR/raRlWbH9vF9tqWRvzR/4B8RFBpsS7Dba20SExi1tgAXZh9AD4ZDBf0PECMiF7OK/ggfEwZfi7hDnyUIvGVue4cBHj6QIqZWRsnt4U3wF6CWnSeb8M/4pBFKx4r44b5HY6lV2qX3cCT4pULEpVCwUfTQkv3vsxeKGY3kPk4hLv/c8phS2EtVDxlJwzoZk70GiomDfNXlduXKXCeNFUzmRmPPWVHiS6XTIfD+bf8wuGjC9jV9QMi0LnLseJEs6GhLP+nFJWBl/e8pHUD0MymifRP7KVbu1CmNEXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4H5HRR6jSEh3iFj0uqmSHNT/gQbKSnVUXwOOvEHSiM=;
 b=gwrgI2GhJYFNeFdDaWyJ3lbFXBny7pn/SVkh/1FXWePpg89TziNAHj541ASVoq5ppbb3A9JifAj1CEPpeURQyINo1Q75x/nJa65kjTsuBkpaxw3i3UJhoIMPbBHD8VXPWGnyHuEGTkri9GzD5AUuqxJwhteGk93rrGH7KLMW3MohqxkOYDlNoXApdSELve4h1mPw9fk4ZpsIcjtV72T1h7fZWoGi0aOB2ymPobVdUBfNLyvIsp5ebGaeNmjoqap14tKbugro48h8VP2o/t9wchQjN+fbqH1kBErT1sRK+tzFVDPpiiSYkNJMiftWxYP1g6SgAGXkLhL2me0U5iS8Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 12:10:49 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 12:10:49 +0000
Message-ID: <14891491-6b62-4a3c-a47f-5ff97fc59039@nvidia.com>
Date: Thu, 16 Oct 2025 15:10:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] [25.11] net/mlx5: add driver event and steering
 toggle APIs
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com
References: <20250827062859.55086-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250827062859.55086-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: e23cad17-5f75-4de3-3776-08de0cad0b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFhKRGNSUXlPa3NNTlNlT29oYTZtcFVGY1R1RnFKNmQwZ0hsM1REZmJMamox?=
 =?utf-8?B?eVhzdlF5ekRGUmZOcXo5UnVJL1RDOGR6azhqcG05ZjVtOURrVUtwbDlSMGZv?=
 =?utf-8?B?STlTMEFEQmNVWVlhUUxjU3UzMjB1ZzI2UGJiWXA1eDlVbkNmNEd0cXBaUnBF?=
 =?utf-8?B?ajI1TkJIY3hUTmhrRTB1dXpGVjNta2lEeGRwZEU1NmZoaDJ5cGRQRXMrNDZO?=
 =?utf-8?B?SDBpUUlha3J0b2xlRlU5OUVHQkVEYnlmWFhtTTNOMjVGcDAwY1pnR0hIQUIw?=
 =?utf-8?B?RWNWU0R0bXdabTVPbUE2b25MYlJETzdWNyt4Smd3NmtqaE1oZkNURVk0OGlq?=
 =?utf-8?B?YlJXa0dtdmpSNldxdklpYmxQME95bFZDQXlwVkttbHQ0cXJ4WFREUkdERDgr?=
 =?utf-8?B?bXAvYXNHajNWWDFmdFNoTE94c3VyRXg0ai9mUXVhSTlmSzFJSjNhdE9RdndK?=
 =?utf-8?B?WkowUENobmxueG8yVDRMK2lselBrSTVpbExYQUxnWWc5U2NldGtkakp1aW5q?=
 =?utf-8?B?N0pDb3lOQTUwNElBdjVlT0tydnAzWVlIZ3NzMmN4ZVVEbitEbnpDUzdaWkpp?=
 =?utf-8?B?aVo0U2xmUGo0U1dlYkx0azhBcGdLM1RMZW02WldRQnhNa2VJM3VCM0pldzg4?=
 =?utf-8?B?SklYM0pVMFFWSWxwOExEU0VyUmxmZU1jS250STJNRENaTDd5Z0VUd1NpUlIr?=
 =?utf-8?B?WUtBcG02UUZPbjhiQmx0VFBkMHprRlhFeEJPd2Y2emk3NDBraE4xSGNYM1Z1?=
 =?utf-8?B?UmhUN2gvb0x0dnlmSEc4UUZTSGlveWhqVFZXTit3dE13Njd4ZTBvRzVJVUdY?=
 =?utf-8?B?VXhRbFR5eG5lS0I2bDd4TVVPYUF6bENheGJqYzM0aHIwTll1K1dIUCtsN0sz?=
 =?utf-8?B?N1FqK2l1bmdLQlVGY01pYlNWYzVFOTh0aHh2Q3gwWmdkaDVRNE9QY25Lb2Rp?=
 =?utf-8?B?NlAybkprV0l5b1oxeDZ2TTkySlNVdXQzV2lyVGFldStrV1dtU3ZCZWtyUlU3?=
 =?utf-8?B?WWw1QlVRVjR4ci8wL1NUTXVCbkMxVUdwSnF0NnczSDF6TSt5TldoUDUwVnd6?=
 =?utf-8?B?SDd0WTFMU1VWNC9Zd2pySDcxQkVWS0VMTHBHeW1iekQrWE5nNzJqVGVyZ0FM?=
 =?utf-8?B?TGNPejN6dVByZWpIaG1uL3h3ZE1GVmh6cGtPK2tiemt2OXZaWWtnRlFHMXBq?=
 =?utf-8?B?RGZQTDUxbDIySFJKM1M3MHBYc2V6cWR4ZWpKZVpSRld1QkIzRW9jaTM1a3FI?=
 =?utf-8?B?c3RrMk5BRFMrTGhnMHAyWFdZVXZzSUc2YTV3UGRMa2N6YkVmT1ZoZzNNQ1ZZ?=
 =?utf-8?B?QXR4RkduWk5mU3V1a09yNzZPd3YycVh2VDBJemZYWHB2dnowSXk4WTFIZmJh?=
 =?utf-8?B?VzVTakM2bXhSZ2ZQekVGSXBXb2QxcEdML0RJdVM4cUxUZTk3c3hlTGpXUzRM?=
 =?utf-8?B?TVJyNUk2bFBwUUFnU2NZQjRKa1BGVkh3NUp6NG9VZVVCb0xyZUxuTnBRRVBk?=
 =?utf-8?B?N0UrOE1hUWl4alc0eFVlRVM5WkhCc2QrM3VieWtlbEVoQ2REZjh4TXpPNVJD?=
 =?utf-8?B?a3NDYzliYTdQQjVpM0loTWdTRTcvbUtDb3hpNUdZM0RyZ2pQOUJlc1VkSkxP?=
 =?utf-8?B?MXljRGFKYm5mY3BicEYwTzMyR3duc3JaeHhPTFdsa0dtV2RMdFY0M09CbFBX?=
 =?utf-8?B?YWlocGtHUmczK0tXdWtPTVRFNGw1VGR5cDRlamJ2MFZJcVp2MUQ1a1FPM1di?=
 =?utf-8?B?N25rVGFqbHBOazJUaGRZTG9sdFl5STZJT0dwNVRBWE9XR3dGcnJRR3lFVENQ?=
 =?utf-8?B?VnlLVHFrMUtoaEwydE9VbzhiN0FXTlU5WTZibXJpMjB5OGlxNFVEdmZRUTVC?=
 =?utf-8?B?L05kK2J4WHJSdDUwazhPa2RFMkhLRjlnVVFMWmlOc08rODFKMmJTZjR6bFM4?=
 =?utf-8?Q?msgVFAxq6F/NCYHybJ80ktnXClqHlaT7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlE1SVFEWm14YXZRMnFSSXBUQXJnS3ZoeUxBTm5BWW9OcnlZQnVOY1hIL1d0?=
 =?utf-8?B?Y2EzTVhtRXljOG1IOTJjeEx0bkh2VDFNOTU3NU5JVU9jWTdzM29SQ21hOWIy?=
 =?utf-8?B?T24rL21HTlV2UXlvWEVYc3pvR3RMcW9tTktVdlJUYStReFVBbktoMkJRemF4?=
 =?utf-8?B?VmF6bVdZMm8zcGlDUHdaZ3o4U2Z1WGJYS1RrZmxtUmx1RnpCYm8vR2RKcHNH?=
 =?utf-8?B?aVVPR1d2U3liNHgzVzZqSkNYdEJlUytORDNYSExjU21ZVjd2ZzZLcm44ay9h?=
 =?utf-8?B?L1Zjb1d1bmhtODgwUlpEY2dhdXhyMFk2aWhjWDhPaHg3YjhjMG5uRUFhVUM5?=
 =?utf-8?B?NzA1VlZKbHZUYndtVVJGK09yZ0FGaFZ0WThlUHQxWnJYYkQ5dE9wTDZDZWI2?=
 =?utf-8?B?bk9lYlhVeEtraEJyb0VLZ0tmMW40L1VPMDV6ZzRwT1paa3ErSlEra1JNREs0?=
 =?utf-8?B?T1A3R3RlWmhiVDg4UVp2T3VETlc4eDRzSVN6d2VUYkZYSG0wajlBYnYzbVdy?=
 =?utf-8?B?dUVqQy9BRlV2UGdEU0cwM1ZvYk1NMGk1ZmFCdmhMS2lvcmtQbDA3VDBWSDV1?=
 =?utf-8?B?TktVKzR4NFllekx3V2IxNUFZY2hDMFJCUEtNdi9pVmdna2w1cXN2K3MyMTJ4?=
 =?utf-8?B?QThuS1Noemo2Slpyc2JyaDZnMk5WRUZoeWcwNC9UVTJpak9YWHV6WjVqSTNW?=
 =?utf-8?B?YTZkQWR1RVJIeUY0cHRVOVVZZUg2U0JFUXduVWVJYzFhWHcyblpCZXBBTXFB?=
 =?utf-8?B?RklqejlzRlR5NU9mbUx0ZFhVUGI0MWNxcmJZc3Q2N0lhekJaOHFpRE05U3Nz?=
 =?utf-8?B?TkpQRldNdUxxOGF0WkJCNy9TTEhWT0lIMHU2SFI1V2Q2QlJPenNOSnUvSlhH?=
 =?utf-8?B?c2gwRWphRlQxTGFWdHVxMWdzWEdoSEVGZ1RUYWhNUzArb3M1QVoxWnJzOGdL?=
 =?utf-8?B?RGFORVdKRERobTI2WDFYbitwS2RySVNQcUJIbWJjd2d1K2c4U2pEa21WT0Jq?=
 =?utf-8?B?Y25Nd3ZHa0tXeFhJM3FLcDlZajdRMkZyTFBSUGdWajVQSGU5UVo5L05OTmRa?=
 =?utf-8?B?OW5FcExCVW5CRnVPVm9IWlh4R054bXBCQ25qYUNnQkJZWkVZVE01eGdJQlIv?=
 =?utf-8?B?dHVjTkMrNmltQ1Y5dGhiRWJPRTlpdmlWNmszR0M4U0NJQnhOSzZmcDVackZR?=
 =?utf-8?B?dmhkd3djeU9yVW84ek9YRHo4aXRaa2JJSUxDMGdCOWFqSkZQL25maEYza2Vm?=
 =?utf-8?B?U29CR3Z2aG53bkU3MFNRU0hwQW5QeDJkSVpkWW9SaXl5RjgxVFdkQlM5dEk3?=
 =?utf-8?B?eWV6R3BWUG81UWw3bGc5MTVPamFiNk1yaVBEcVk2Nmg0d3hjZC8reUpPbUFy?=
 =?utf-8?B?aEdDY2oxa3c4b2FkTXJPRnRHVExxNlRuYmR6ZTR1clplaitwdVhqZmM5b2xF?=
 =?utf-8?B?dXE4TzRFWlVSRVJSTmRmUmo2ZTRBeXU2RlhWaDJvQVowMlk5bzBCTU5Qc09Q?=
 =?utf-8?B?dnFuUWVMdjJOcVF2ZzIwZW1FTWd0ZFA4eUNSUyt0b1hEY2c3bXlhWEhyTm5G?=
 =?utf-8?B?N1d6S1ZrMkhqaDdjSWZqTnY4ZlBBM3RYUzlBK01hWUFXMFhPMEszNU5RWTBJ?=
 =?utf-8?B?WnVRM1dDRTlMU3VHTWMrd2tVY3hTQS9WaEh0eEZ6NGRrSXNxZzZKQTdTQjVX?=
 =?utf-8?B?c0xFbHp1alZLR2c4VW1pSk0zR3JiN1dCMkxRbUhBRWZObUwwQ3FrdGtobi9q?=
 =?utf-8?B?RDArcTBZcmpjRkZxOEE2Q1Jlb0ZoT1VwMVByeXZQSUhDS3NxTFVjb2lxQVlQ?=
 =?utf-8?B?U0xlSEI3UGR5VTNqWWx0dVp1bFp1Um5CSmx1YjJLMkd3TnJKWGhMdXZXdEpM?=
 =?utf-8?B?UWY1VTRwcE1XUWpuaUp6alJuWHBLcnNLOGg5SGxiUEN4SldScWlNZjBwMzhN?=
 =?utf-8?B?d1hKTmVpYlJZckM5R28vaVFHY2NvZFJIQi81Tm9WNnY5ZFByUStzTHBmajM4?=
 =?utf-8?B?d0wrUTdCNUpwYUtubkZiMFdTUVNJT0NRcFRBUkRDR1BPVjd5Q0wydUxOV1JJ?=
 =?utf-8?B?QVRPMlY2OGdlc0N5eU4vbHc3NWV3MWo5R2VwSUIzZHRYQzdvYVZTS2dETS90?=
 =?utf-8?Q?cbBQHQbLPXruxb7Qhs2RED4FG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23cad17-5f75-4de3-3776-08de0cad0b0c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:10:49.0541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrYEMdejKVocuIN/N6FpvfEmzsyNu8SHxrkuYIUPkSmKklbT4aLNRFx3lxqIaZzt508Rkc6HMVUH926F1k7xlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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


On 27/08/2025 9:28 AM, Maayan Kashani wrote:
> mlx5 PMD is a bifurcated driver, which means that instead of communicating with HW directly
> using UIO or VFIO, the driver uses existing kernel and userspace APIs for that purpose.
> mlx5 PMD requires that `mlx5_core`, `mlx5_ib` and `ib_uverbs` kernel modules are loaded,
> and that NIC is bound to `mlx5_core` driver.
> 
> Kernel bypass is achieved through rdma-core library
> which exposes required functionalities e.g.,
> mapping memory to the device, FW access for setting up Rx and Tx queues
> (through mlx5dv_devx_* interfaces) and flow rule offloading.
> 
> One benefit of such architecture is that it allows libraries and applications
> to build additional features on top of DPDK, utilizing rdma-core directly.
> For example it is possible to implement additional flow rule offloads.
> This can be achieved by creating an IBV (IB Verbs) context and PD (protection domain)
> through rdma-core and sharing it with mlx5 PMD through `cmd_fd` and `pd_handle` device arguments
> provided during probing [1].
> mlx5 PMD will then create all necessary resources for DPDK using imported context and PD.
> 
> What is missing for that approach to work, is that
> external libraries and applications are not aware of HW identifiers of Rx and Tx queues
> (returned from mlx5dv_devx_* APIs) created by DPDK through imported context and PD.
> Knowledge of these identifiers is crucial for correct flow rule offload.
> 
> This patchset proposes the introduction of the following private PMD APIs
> to address the above use case:
> 
> 1. mlx5 PMD driver events
> 2. mlx5 PMD steering toggle
> 
> mlx5 PMD driver events, exposed through `rte_pmd_mlx5_driver_event_cb_register/unregister()` functions,
> allow libraries and applications to register a custom callback.
> This callback will be called whenever mlx5 PMD creates or destroys an Rx/Tx queue.
> All necessary HW identifiers along with corresponding DPDK port and queue
> indexes will be passed as parameters.
> 
> mlx5 PMD steering toggle, exposed through `rte_pmd_mlx5_driver_disable/enable_steering()` functions,
> allow libraries and applications to disable/enable flow rule offloading provided by mlx5 PMD.
> This is added to support use cases where library/application needs full control of flow rule offloading.
> Library/application will use data provided through driver events API to configure flow rules by itself.
> When flow rule offloading is disabled, DPDK flow API will return ENOSYS for mlx5 PMD.
> 
> Patches:
> 
> - Patch 1 - Add mlx5 PMD driver events private API
> - Patches 2-3 - Minor clean ups in mlx5 PMD which make introduction of
>    steering toggle private API easier.
> - Patch 4 - Add mlx5 PMD steering toggle private API
> 
> [1]: https://doc.dpdk.org/guides/platform/mlx5.html#device-arguments
> 
> Dariusz Sosnowski (4):
>    net/mlx5: add driver event callbacks
>    net/mlx5: move eCPRI release function to flex
>    net/mlx5: rework Rx queue mark flag functions
>    net/mlx5: add steering toggle API
> 
>   drivers/net/mlx5/meson.build         |   1 +
>   drivers/net/mlx5/mlx5.c              |  18 --
>   drivers/net/mlx5/mlx5.h              |   1 +
>   drivers/net/mlx5/mlx5_devx.c         |  17 ++
>   drivers/net/mlx5/mlx5_driver_event.c | 300 +++++++++++++++++++++++++++
>   drivers/net/mlx5/mlx5_driver_event.h |  18 ++
>   drivers/net/mlx5/mlx5_flow.c         | 199 +++++++++++++++++-
>   drivers/net/mlx5/mlx5_flow.h         |   7 +-
>   drivers/net/mlx5/mlx5_flow_flex.c    |  18 ++
>   drivers/net/mlx5/mlx5_trigger.c      |  30 +++
>   drivers/net/mlx5/rte_pmd_mlx5.h      | 192 +++++++++++++++++
>   11 files changed, 772 insertions(+), 29 deletions(-)
>   create mode 100644 drivers/net/mlx5/mlx5_driver_event.c
>   create mode 100644 drivers/net/mlx5/mlx5_driver_event.h
> 
Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

