Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732DEF532D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCAC1402CE;
	Tue, 24 Mar 2026 06:16:39 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
 by mails.dpdk.org (Postfix) with ESMTP id 898BF4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 06:16:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ6VEDO4JOmjRhk3oLx/uZhYiHx911IelXbrUXsM4oWLNICL07D8YLvVGZDwnQSYtlNugmTqJbMf2iKZHrhLTroEvoglSaKImLVsKwUx80jHDo9MYv5Pz29cJ4tV3R2/zbQOSYC6JepORkKSkpyWCjIRfMUwFfC3KBvJhHSA8aXDcJvdaomGd5rWIACQNVM+uBoTbCnmGTO2LsVaPrl+Fm27wTAJjfsa10vDIJ+lqqkkofjKSUxNBZcO07dtXeoYE+gcjDHoqVdtLYdgucX/UwEK3y+OCS+Az8qYMxVALNdX68wmONdTWlSaEh+Xsd7uzLNe6jUvCgBPwyV9/2XULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4jbjKTzC+8TE6Kl3IYjUX6xiBKMHfYxGyQYF2mMRNk=;
 b=WiJg41diwfdw+3GWLbZUXpJ0/xvHRRgOfoyxnSHlJZQz/PjTmq5evnpNZp8ySDs4tY/x1FX5oXrEf2R2bprjv869Relw7PPia5oBv1+imbb2qFnDnuppN8muAwS7umj+tuGyPxgB8VmewpX8LLs97+Xpcxr3Sr7/zfU4uZZ3na8fi3HNimopCbLNVYzv0UsmZLuBlB9c4sOp9OgWPLpRQwVErmEcLGuN1y8Gjx3Y+/vbeeoo5a/bJc4fWJyOAgeDmv0VX/wc9MU71cGwiZP1kGMfRsw05aCRPavB/YhZFqwNyFj4GH6dt+Xo9iEot+MY9IX8Z8Rk5pVqQ+Id9FMKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4jbjKTzC+8TE6Kl3IYjUX6xiBKMHfYxGyQYF2mMRNk=;
 b=mxowADlIH4Jd5IAD18vIBsUH4DsbAyrvnHqe5wM4r59L7n/9hz1S/iXtSfAZvSm6PAM5p/9M7WRz0KM5mmQvuQmJiTFw41J2+35HCLACtKg0cfL14okUc2BZEQmjHqeNAp0qowHgloYaHFJoaMMUMEDru/g/NRHiq3MSAH+1gqSztb+FmLFvv+XHRg3bSiTyqyz9bCKqcJ5M0g5jikixbHWRTOH+2tRSMxxV9rdG20tZVLt16klhCXDRsvm5tsjxVnCZTFPn+HvbYiWHbSqSczlJreY3XSmuqDFEYJCfS3HRDOBHPQXHraEu6KYXwCs5Xjlc3g9ys2yl8vEY1imJBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:16:32 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:16:33 +0000
Message-ID: <afd63b1d-9071-46f1-9b47-6b23858dc4a2@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:46:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drivers: cleanup devargs lookup in bus scan
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-5-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260323105306.1531689-5-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c6209e-01ab-42dd-fc41-08de896483e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7416014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tgGZcII9bqaHIDFt5q/leGY6ihTwbk6e8fGOBKSOp7cU29cjmfdLjh1CRKWzJxLIcLWayTSPZI+2zaLVSr2MxsHNejbj8UmsP+DEu8+I0g2iEEAX30nM94OhW3OVvl7ytT2UVyt3tMN6AOEWuzZKam31iIbX+rI/AkAZGjhsmBXO62hLJDSzc/KLXMw/1KAthF2rPxqmEO5Ut9jdEfNIrHQgDrPpNV9iVVdpkPGmojD4vqvUDyILVZnsRyKX6kX7PFu2SOtoQH6VMy5CZo5j2E8Epd6dgFAb7p7Hv2A2UsHP3sjSYj4ZrFqKSSpMbU+3ZSuAE6NgmAf7gQYAhDmv2qmdZlhQYywAyZz4ZnYnEb2WQxsXPnW8MAKm9+454J3GQPCfyaYJfoDdpa2hmAm72PVJF+JSDMki21xj3N3RxFySUIcO47uLvV8VVOvXLUPLiuWyw4xoAm9PJzpLPNkgiilVdnonkjKWdWF7EfXybyLdEavXCwFjs3pAMIG6sIvqQVxEb6KxYD1svgjlGxgrZPs1VwT4kqYUvLK/hFoehHTcgIug6oRdRpsnFN49nv1t4Yy3r++QQmK4JP1UtqbtvdBW70zw0ajFNxla3sprg2N+ol5VWWE0dMJ7fsfv9FkMObZ5ZT2D8Cj5m1DF7I6YiaMU/FLgsFpfvs8C/7APC22sJVdYcBCUtM0arts37XoZVRAV3eEm7wzQ7n8UK7NJrBfIVqq+0Tvoe3dDNLQwlQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01JdmlIYmxMQndPWVpuSjlsaVRmWG5OQUdBRWVWclF2QTVySnltakpIZHlu?=
 =?utf-8?B?dWpkd3crQXBwc1VQNU5UVFNyczdqYjc3WUVpeGg5Qkdsei9BcjVTQkhveU5H?=
 =?utf-8?B?c3RHZjVLMHltU3VkSVUzMkxQUzJxUEROd3M3L3l3UHgyRWdkOU5XL1BORVAy?=
 =?utf-8?B?VEZ5MzBvUzZabFBSK1JjcEw4REl3K0RVcktXSE1SbDl3MWhjWEVFTGh6WGdo?=
 =?utf-8?B?RHpjQTlTc1VhYXBmdEZFL3RyUWlVWFdBbm5MMHV0cFprdlN0SG5Ja2JBMFoz?=
 =?utf-8?B?Qmg1eTMxbFM1MFhLOS9SYjdnWGZJOWNPS3BaSlUrenBsVEYyQmRGOHJ3YzA1?=
 =?utf-8?B?L1B6U2U5MHdOY1NBcE9PZlRScW9JZm5FSVoxWlZxTVJXRHhQMklkV3RwOE10?=
 =?utf-8?B?eTRrTm8rUnp5Y3ZJRHNIYlFrRnNLSkdTam1jNFBNZ2U1Smgzdm8xQUptWWFU?=
 =?utf-8?B?OHNkR3hvY2FwckxDcmI0dzE3RlRXb0hNWXNYZUNuUkFOc2szQUc5WjNNTkF6?=
 =?utf-8?B?K0lZWVVmbG9nZHl1Z0docitacDBtYkJ2VWU2eFU2RlExd0lya1JXeTRtekwz?=
 =?utf-8?B?Z3d6bHN1cE5MeDZWaWpRdVhCcGU2MUUzUWNiMVlMUUE2KzlRbGx1ZEs0ZFBJ?=
 =?utf-8?B?YzZsZHNmVS9aVm5qNFJSa3hOMDJsbTR1Y3Q1VkhQY0lJYy9uL2NRTlRXVlY5?=
 =?utf-8?B?aE43aWFnZk5qcDVjZDFqcVdyK0NjK0g1cUJScVlRdVhjaEp5N1dsZDkrZExn?=
 =?utf-8?B?eml4dHVJekwxQkZDTFhKSityYWp2bnJOVnVxUnpQcGIzV2ltWUR2SW9rY01O?=
 =?utf-8?B?SmxldHR0bWRuTWhiRTJveGorYWF2bWFTN0lxQTdSSnZnQWtxaTFtZmhJN1hn?=
 =?utf-8?B?V3MwUHNYNlhXYUlWNTlHS3NwbVdFUW1PM2RnT1FKUHdQWVhTOFl0SmQvV2pH?=
 =?utf-8?B?RDI1VVhGY0NVU3FodUJ2NTdSblhUa1BGbW9mUll6bnF5UHd5ZTUzbFFpb1RU?=
 =?utf-8?B?bWF1cFg1Qm0zRmN1WWU5b3V6aitBTVcwSmE1a29ZSUF3eGRiTGdwV3JkWXZS?=
 =?utf-8?B?aGk3TjRRVEhrY1dIRWtNcEtqS2tLVDVlaE9VTXM5OFhWQUE1dDlaeXFZQjk1?=
 =?utf-8?B?NDRoVTl5Z2Y2SThQb1MrZVR5TkZzOTBPYlJ3MkFCOFBFcjdsNjR5YnpoM3Nl?=
 =?utf-8?B?SktLWHlrS0hsNVM1YmVhdzBkK0o0d1ZWS2U4TUhtZzZHbGh3SXpnQTZwak5B?=
 =?utf-8?B?dFgvZFZmSVhOREVOUUdFM0JDV09neVA3M29TNjYyUm9RdWhMVEMzdWVubnlD?=
 =?utf-8?B?R2ZqLzhYeUhaOVQyclc2azZNM3pGRFgrVTF6RVlET2hONnJnUk4yZ0sxTmR5?=
 =?utf-8?B?WUNnSm1kTWROTTd5TDA5NFJXbG9pVXVaK0lHN3k0bmlHTUpjcjlOa3lzcjEz?=
 =?utf-8?B?TTlSaWlVOWhQWGhUVWJTU2RJelRPcUVlU0VQUU9UUjJvVnFBOFIyWXE2R21q?=
 =?utf-8?B?L29hRmV0Wmx2MEJyNVN4ai9lOHA5UkhQVUN2MDZoM0NweWx6MktVT29XNFJQ?=
 =?utf-8?B?QWVlUnJ6MDVWV2lSYk9XOHRjdW1pYUp3dzJYdTdPT3hCUkRtdmRic2NEQnF4?=
 =?utf-8?B?WVExRzhoZ0FvSFM2Z1hnUmZHcHVoQjlRT0ZoeEhvOFoyN0MzVjVwQmwvdm9n?=
 =?utf-8?B?TXJ3OHFZYmhsS2pSb3BLZVRVcVJDeUdtSU9qdUJWMDREbTA1T3dyMTZocGZk?=
 =?utf-8?B?d0gyZnljelg5NTJodERyY0RubE5hdys5QksrRnVZK3Jwalk0VFA5M3k0ZUM4?=
 =?utf-8?B?RVVjWlhlSmp5ZmhHVjRSWDZhbW9XdjVrUld6bHMrcVZvc1N0NG05aWhsWkJs?=
 =?utf-8?B?YnBXYWpYM1lWSWxKTmtWbjY4Z1E1WDRBM3EwbDhkbFUrZFF5TFg2WG5vMWRn?=
 =?utf-8?B?V0t2U3k3Kzd6RS9Cd29sWmFmOHN6cndaenFZTklIc2k3enpmbU00VmJnNjFL?=
 =?utf-8?B?OHVlaTAxQVI5a1o2UzdsbGtCUGE0a1lQRVVJZkt0SXlJenVrS2g5Zmk4ZEE2?=
 =?utf-8?B?V3lTdC91OElEVktxSHpFcFQya1EyWDA0Y2NIM3ZWZUhwOXNZenI2MFNqL290?=
 =?utf-8?B?ZGZ5U2FpaFlQSWh4aTZNODFqOVBtdmladzFDcE8yeW8ya0MzcGJGVDNVVzJB?=
 =?utf-8?B?ck9JQlBmeVdJei9KUlNTSTFrQk4yUlk4Z0IxVE1oZDkyTld0MjVyR3Z5dUxI?=
 =?utf-8?B?NVVuWGtMcVNTdmxnWVErRDgzQkpSdlFoeGpNY2Z4d21kUjdXVWFDdXQ1eTVY?=
 =?utf-8?B?VU9GY1NXaUt1Uk5lZ0xJbGE4eGVDUTFTbjJUbVhwSTI0bjltUGhrblFSejls?=
 =?utf-8?Q?lkmbXs3/Dtedx+C8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c6209e-01ab-42dd-fc41-08de896483e5
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:16:33.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX+0y89V4kNgC5DwULIQegX38utUPoVRiydNXWYcKsVUAV9n5SutoQhsXNUDOCfbpVxk7/mQ2Uhbi9XL0Rh5iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
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


On 23-03-2026 16:22, David Marchand wrote:
> Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
> The bus name is set by code in EAL.
> Even if there is nothing broken, let's reuse the name from the bus object.
>
> And remove the now useless macros.
>
> Note: in the ifpga bus case, the call was using an incorrect macro
> (IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
> as this macro is aligned with the ifpga bus name.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/bus/auxiliary/auxiliary_common.c     | 2 +-
>   drivers/bus/auxiliary/bus_auxiliary_driver.h | 2 --
>   drivers/bus/cdx/cdx.c                        | 3 +--
>   drivers/bus/dpaa/dpaa_bus.c                  | 6 ++----
>   drivers/bus/fslmc/fslmc_bus.c                | 8 +++-----
>   drivers/bus/ifpga/bus_ifpga_driver.h         | 2 --
>   drivers/bus/ifpga/ifpga_bus.c                | 4 ++--
>   drivers/bus/pci/pci_common.c                 | 2 +-
>   drivers/bus/platform/platform.c              | 2 +-
>   drivers/bus/uacce/uacce.c                    | 2 +-
>   drivers/bus/vdev/vdev.c                      | 2 +-
>   drivers/bus/vmbus/vmbus_common.c             | 2 +-
>   drivers/raw/ifpga/ifpga_rawdev.c             | 2 +-
>   13 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
> index ac766e283e..119533df28 100644
> --- a/drivers/bus/auxiliary/auxiliary_common.c
> +++ b/drivers/bus/auxiliary/auxiliary_common.c
> @@ -30,7 +30,7 @@ auxiliary_devargs_lookup(const char *name)
>   {
>   	struct rte_devargs *devargs;
>   
> -	RTE_EAL_DEVARGS_FOREACH(RTE_BUS_AUXILIARY_NAME, devargs) {
> +	RTE_EAL_DEVARGS_FOREACH(auxiliary_bus.bus.name, devargs) {
>   		if (strcmp(devargs->name, name) == 0)
>   			return devargs;
>   	}
> diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
> index 1dc814151e..8450d56583 100644
> --- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
> +++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
> @@ -28,8 +28,6 @@
>   extern "C" {
>   #endif
>   
> -#define RTE_BUS_AUXILIARY_NAME "auxiliary"
> -
>   /* Forward declarations */
>   struct rte_auxiliary_driver;
>   struct rte_auxiliary_device;
> diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
> index 729d54337c..b183d98453 100644
> --- a/drivers/bus/cdx/cdx.c
> +++ b/drivers/bus/cdx/cdx.c
> @@ -82,7 +82,6 @@
>   #include "cdx_logs.h"
>   #include "private.h"
>   
> -#define CDX_BUS_NAME	cdx
>   #define CDX_DEV_PREFIX	"cdx-"
>   
>   /* CDX Bus iterators */
> @@ -157,7 +156,7 @@ cdx_devargs_lookup(const char *dev_name)
>   {
>   	struct rte_devargs *devargs;
>   
> -	RTE_EAL_DEVARGS_FOREACH("cdx", devargs) {
> +	RTE_EAL_DEVARGS_FOREACH(rte_cdx_bus.bus.name, devargs) {
>   		if (strcmp(devargs->name, dev_name) == 0)
>   			return devargs;
>   	}
> diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
> index 5e0f32bfe8..e3c17d41f7 100644
> --- a/drivers/bus/dpaa/dpaa_bus.c
> +++ b/drivers/bus/dpaa/dpaa_bus.c
> @@ -77,8 +77,6 @@ static pthread_key_t dpaa_portal_key;
>   struct dpaa_portal *dpaa_portals[RTE_MAX_LCORE] = {NULL};
>   static int dpaa_bus_global_init;
>   
> -#define FSL_DPAA_BUS_NAME	dpaa_bus
> -
>   RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io)
>   RTE_DEFINE_PER_LCORE(struct dpaa_portal *, dpaa_io);
>   
> @@ -206,7 +204,7 @@ dpaa_devargs_lookup(struct rte_dpaa_device *dev)
>   	struct rte_devargs *devargs;
>   	char dev_name[32];
>   
> -	RTE_EAL_DEVARGS_FOREACH("dpaa_bus", devargs) {
> +	RTE_EAL_DEVARGS_FOREACH(rte_dpaa_bus.bus.name, devargs) {
>   		devargs->bus->parse(devargs->name, &dev_name);
>   		if (strcmp(dev_name, dev->device.name) == 0) {
>   			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
> @@ -1003,5 +1001,5 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
>   	.device_count = 0,
>   };
>   
> -RTE_REGISTER_BUS(FSL_DPAA_BUS_NAME, rte_dpaa_bus.bus);
> +RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus.bus);
>   RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_bus, NOTICE);
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
> index ac9fb7a08c..8f3e3dc1be 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -26,7 +26,6 @@
>   #include <dpaax_iova_table.h>
>   
>   #define VFIO_IOMMU_GROUP_PATH "/sys/kernel/iommu_groups"
> -#define FSLMC_BUS_NAME	fslmc
>   
>   struct rte_fslmc_bus rte_fslmc_bus;
>   
> @@ -106,7 +105,7 @@ fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
>   	struct rte_devargs *devargs;
>   	char dev_name[32];
>   
> -	RTE_EAL_DEVARGS_FOREACH("fslmc", devargs) {
> +	RTE_EAL_DEVARGS_FOREACH(rte_fslmc_bus.bus.name, devargs) {
>   		devargs->bus->parse(devargs->name, &dev_name);
>   		if (strcmp(dev_name, dev->device.name) == 0) {
>   			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
> @@ -266,8 +265,7 @@ rte_fslmc_parse(const char *name, void *addr)
>   	 */
>   	if (sep_exists) {
>   		/* If either of "fslmc" or "name" are starting part */
> -		if (!strncmp(name, RTE_STR(FSLMC_BUS_NAME),
> -			     strlen(RTE_STR(FSLMC_BUS_NAME))) ||
> +		if (!strncmp(name, rte_fslmc_bus.bus.name, strlen(rte_fslmc_bus.bus.name)) ||
>   		   (!strncmp(name, "name", strlen("name")))) {
>   			goto jump_out;
>   		} else {
> @@ -704,5 +702,5 @@ struct rte_fslmc_bus rte_fslmc_bus = {
>   	.device_count = {0},
>   };
>   
> -RTE_REGISTER_BUS(FSLMC_BUS_NAME, rte_fslmc_bus.bus);
> +RTE_REGISTER_BUS(fslmc, rte_fslmc_bus.bus);
>   RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_bus, NOTICE);

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

