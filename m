Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3957C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:25:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C27D5410DC;
	Thu, 10 Sep 2026 12:25:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 520EF4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789035911; x=1820571911;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ulgyaUZR0yDSybwKbEnWCIJWNL+KLjfx/4InFDHZqwE=;
 b=n/NJiKZSxkE+JGdKeJRTvowML92so4lwtBX1HS0sC3bwnTGus6NyzhAY
 BOUdN37Kb83cBpSfJ0kw+OMp6WOEsHjtAxRUK+tbfQ5jKmDtzEb2xKXlJ
 ozfbKq9qeUF/GkluDenXzSnZgru/FjDuZ0TXiIxaVFsgMPjob0stbBpxr
 vbxeOQOCBiOSXjgmENJ3NgnWg7C81PXzpFFp1zuWE0RafYpy5Cr3JtxWo
 hPkapOoYw7N9Tco+CB30llaqY8P7e7Knnv7ZHngTVDYjZC+ILMbk61MTV
 9Nj1UxaOLIDYRgyz2e3Qg2pX2zK7v6Td9xlqQNien75oOGI6yrZbse6R8 g==;
X-CSE-ConnectionGUID: x04FOYuETn+aQYykg7whPA==
X-CSE-MsgGUID: Xi57YH3cShSbh6mggrhs3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106850869"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="106850869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:25:10 -0700
X-CSE-ConnectionGUID: 9RlW9LXTQlq2Qm6sSHfYpA==
X-CSE-MsgGUID: 39Z7IWVyQrylap2BEy6zQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="267903532"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:25:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 03:25:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 03:25:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 03:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD/pYRVFITmMpK90VtbQrAmjRZhgcWfahwFsDVpifnPpISmjS7zybLs0huF8UnFwb3tz1J4TW0PPU0Ba5bdgjULkmmVsBPIqk/UE0hB4NZIV919umstNILJRay96lN4xxKKp8VsA7x6iN2/apTFdzkmMs1SkXB5XpvupFBnLFceLxxxHkCZM7cNlQQr1U1h32hf2bN0T+9jWQBBkn+PrXDghn0U4UJUA0zv+U+5QepfcfRW09/JCPhs95fFHZi3ppreuuTdfh0oJ4zEXicben8v4FTLPWNMBXQQA6DiD+tUJM8u4MRcIVC3QuEG3rJFZu0gIr050/flfXk9zQFO2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmHsnhiashjiVu0/shTyYIdBGLE0qTLO4GYAMaJ5nSc=;
 b=b+g80jBM7WRbNkiUB8tPJK3fYSPTpORxqlnUbK0f9QKuektjKtT3JeZxaYq1G4BBqmTcyBvq3u1s8Ic57lz1kJ7dBrFoJ0gCUia8tWCImc1BtjRVOyzu7d7C2DrjZyNJhV/yZIK8MzVLsHpKroz4vMWr/aEzJrjoh1YlVHEiuMhCM0e5DSZieCPKv1VQgyAUgmdA3MtOOpCdxt2UuIknQBYYFAJqXHrBKMjho+dQ3zkknL0EMnhHIkkUdhS+A1bX4gq6gQjLLq3uQZFqapMc1BXnMvkH3zP08SWp/J1gjyIOwYUte72yMUUZdPSgdMxals7PTD8QAW5VMsenglaatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA3PR11MB8917.namprd11.prod.outlook.com (2603:10b6:208:57d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Thu, 10 Sep 2026 10:25:04 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 10:25:04 +0000
Message-ID: <fa883da6-5491-4b9f-8382-9102045427c8@intel.com>
Date: Thu, 10 Sep 2026 12:24:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260904122804.2256481-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA3PR11MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 379310ae-5c63-4acd-f1ac-08df0f25c736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dP5EZCCMChPlyZdNtnlJe97hpN6VmPfJrzSi+ndyJc6onvLkPAl+cAQ0G0caPEdjzVHtrhkh/fzSw/Hnj9s7BxWQEsdnCbcsavspXwTCu/GYlnciEL3rZ6cZLlOtXZpZkHwJHVdfCQQOACUm+Hw3BApNSjtLD7WfiJ1fAwOqHVIQvOJboUm6+EMkyv+84O6vxeR9lQb5XTSaWeMoUjnggpWGvWbXcx0v1oV5x6bfvS07ng2O1htKfOpybcpRdre6JE4EG0yhGrWw/7mtfL39XZtytNE5M5NXRzXL9LylgQI2TG/bN1lJ0oj4Iub36XI4pIUhhvykBJJ9Vl7CbqWTD0ZklkGrfCaXGLm01NR5pdwVUgdsn3ocOOVvI21eKUtTrCM1l7Vi0yccWPjWubKjJwDaPVEoiEaaRKcLxp6kZclTmI5BOf74Grrvw81WWEjCpuwuXG9BA9lOIpjSvY64OWxawnePUVsIrTc6ZKsYhwG7F4T+5e9qmSaTcqkwHYsXmoL7eSe2zEMdtUzEskrpkHKMSEOZj4Cc18U9cKgASEdQlg4kS3SuDhA5UFMPJAIRBP84WH5PoLgPtgIBg04wMwfCykGqf5s9VL6vIwLXRSDgcGX1VyNq7MqW7afvghV5usm3Vh68tAZMOcXOs1xhB3GukFhJ2HV4kp5WxZ+vazo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDQ4cDFCM3NQYTNodkhCbmJvSVBuN3l1QnNuNStxM2pGS1d6RUtVbmdSMXow?=
 =?utf-8?B?NVNwTlA0QUNCVXVHUTFmWU9JbjhnUnRzRlNGcHNWWG52NWF3MC9jK3BVVUEy?=
 =?utf-8?B?OFJLVWpBb2xPelMzTE4ybWpQZURnQTdSdGlxNVhGYk1iQTVZeVRYc1I4aXEz?=
 =?utf-8?B?ektzWmlWakVaa1pFUE10b1pEb1Q0NVNaOTEwalByYVlkRlhDbWVWUkVDNW80?=
 =?utf-8?B?TE0zeUg0RW5IWUtGL25ja3Y4dE9WYU9mVzhFQi9laENkMU1Ccm1xdEFkUXVa?=
 =?utf-8?B?SW5QcEtPVk5VcFExNzlsMzJ0U09lV2xWY0pVZ2g4b3FSUXA1S05lUmNCazV4?=
 =?utf-8?B?TS9GbndsUmt3ZzRnUGk2MFBCcTRreXFFR1RNREM3Njc0RGhab3p3NXM3SGkv?=
 =?utf-8?B?bTZxaEo3MXNyc2w3TTd1OWxTei9OaElpejVCejhCbExwaHVSY0Eva2FWSkpW?=
 =?utf-8?B?ZHdGQmtERzNLYXMrZkR2YUk2a3FldWtQQU9vQnZzNlQrQWRGckg1ZDFQOHBv?=
 =?utf-8?B?L3NnTWorOGllOUNGV3FyVTB2U1g5bHZtT0VqRytpNjZQVm1CRmFPbHQ0THJK?=
 =?utf-8?B?MlYyZnpHMnREQStSeG1mc1JDcEVVUnNnVjA1djFqREM2V2xEOGFvUjFCU1Vl?=
 =?utf-8?B?dnV6U3pRSEsvVzJiQ0R4T1FxK0NCVWxVSk5wRzdRcUhKUy9nVzhLSi9YbjFN?=
 =?utf-8?B?akhWUTlTNi9qNFhBOVZBMFR4MmFqV1AxWGpRTGxxQ3Q0UEt6WFR5THJJY05I?=
 =?utf-8?B?WHZCeldGLy9GdXBocGMwNVBBM1ZZeS9qSDByOElCV2gydUYyRzVoaWsyVi90?=
 =?utf-8?B?cm5aMnhsVUtMOS9May92bytHOG5aVHovZ2N6ck42eHAwMGdpV2VHdjVwNUZi?=
 =?utf-8?B?YUYwcEdjbU5XNDFxWGIrbzAxYjA1ZFM3MEJFcHRxd0gvbS9XYU5MRTNGUUhT?=
 =?utf-8?B?TmRuTDhuY01yY0pCK3RLTlZlb0tXNGcxWDZqTVozejV6eHR3emVhWVFKZ1Qx?=
 =?utf-8?B?amFLN1NoeFRLOXo0bWh6K0JHQnVaVzZGSXlaQmVIWTF6Q0VBWGhhQkhoOWtF?=
 =?utf-8?B?bFc5SjBpU3JpNzJCQjRlK202cDd3SmVoVEVUYm5qeHc3TnMvcEMwVFdJRlda?=
 =?utf-8?B?eUYzMGVQQUs4aFlSV2FwSTluUDdIZkZVNnF2UXBIVndlNDM0WDIyb2V4QXJ5?=
 =?utf-8?B?OUN0VkFuYW9wVlhMclFxaGppM2R0WW1qcXBNT0s3eVJJWm5ISjZZVVJjUGxh?=
 =?utf-8?B?ZTZUVVhxMnhoRGJTUC9OOUU3ekpMWWdGTVlHRTlYZ3JPSG8xM0k0a3RBaWZM?=
 =?utf-8?B?L0VoK2xYWmJCRmErRnNPZ1lvUXZWMUpXVGNtZnI4SmpKc21VczRLZVhQZWlB?=
 =?utf-8?B?WG9QSms0QStIU2FMd05zRkJWdWxDSnl1Vmg3UVNRc1ZqMjNhb254WFdzYm9m?=
 =?utf-8?B?SUlWbnJVdDVuM3J3N1JQNlUzS2tkK3oyV2pPd1dmUmRNNEcrMUF6ZFBGNVJB?=
 =?utf-8?B?UkJyTUhmL1BWMXpoV0NRL1BWQmErUlBGdTk4UkJuK2k3ejlBb0l3MG9NVisv?=
 =?utf-8?B?MG1GSXlQR3N6R3p5RTlpbEU2YU9YZDRBOW9BVmdvUmlFZWo0MGdmeFlUMDA5?=
 =?utf-8?B?QWpla1BSZVFkVUhzZkZhOWtybUFuelZ5Z2EzZ0duMzRhakZwN3VKdXpJOUVX?=
 =?utf-8?B?RnAvRU9VVW5xNlNWRXlxbWV4UEdwTHBwTTF1QnhEdWxJS1ZFTFl3M0d5WGZ4?=
 =?utf-8?B?aVVqQkhFY0dweVFjWmVTVzN2cUViZWkrR3ZRdDBoVnFHWHZReG15cWtyTm1t?=
 =?utf-8?B?SjZIeU1OS2ttTmdVcHVBZ0M4WnlkaGFvVno1bzYveDRXcG5hQU9HbUw4aVJN?=
 =?utf-8?B?RmN0bmluOU1GaVl2Tjlmc2FLOFBJMkVhSjROWkVFTGJsMnVoVE94QlFLbkRG?=
 =?utf-8?B?ei9ZbXRUQTFaOW5nRThaM2FuSlhNWnRmUXgwaGhNZkVxMGNSajFCNVJPSzY2?=
 =?utf-8?B?Qkpva2J4N2Y2Y0hsNjArdGNPMEVuRDZVN1BuT3VkZUltQzF6cm9QMTd4SW5u?=
 =?utf-8?B?N3RqTVBFVDVOandHejBndkFTSE5BTHAzNzc1WWFmTlF3Tk9NQjUxVkhSSlEz?=
 =?utf-8?B?Zjczc0xweTRTcWRvYVFmUW9KRjJzanFYMjV2V3Nva1FHNm5pSlA1ZG9VR1Iv?=
 =?utf-8?B?SEc5Q3Q1Nm5NcVN6OVQxeG50MG1RK3NMdU1zOFJ5Snc0d0RhcElyUm5QeDlz?=
 =?utf-8?B?NEVSeEVxYXFhaHB4Vzh4dWQvVUJqRFhVY3dvaHJrOTAvc3YxS2FyakozTThG?=
 =?utf-8?B?K0hwSWw1QVNUTkZ0S2lQcHpiR2g4Q2V1dUU3YXFuTVppcEhtdlJ4Wk5KODhQ?=
 =?utf-8?Q?FowVoPFF9QSrv66A=3D?=
X-Exchange-RoutingPolicyChecked: YlEuIgDk3bJyPW+Nzqp+iEP0E736ZdudqQTRq0ANkEtD4PvVv44dEok+ma2ITcQedP6k7nWGk9VEyeBYXV9K4ksy1AZ03NaJLluSyuhR9K2P+HhjBcGHiLO0/laegj/W5LKGN2j7phyP5JssOONiIqcn7LV5AX2rDlqgOY7baJFVhB90cTmvy87aWDPDTzINSdD2uFrwd70h4+yPXJ//xButxExaJW0VMPgD4lF9ARf0V42JOo8V0AT48Z6aXBv5GlUs1JztmP9rLA6oajHtytIgqNYh+ekWPspEP84fHoW7YpQ05BkZpbh6rRsryvvQDBvNrZ4Ku6UYYmbm5F1iuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 379310ae-5c63-4acd-f1ac-08df0f25c736
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 10:25:04.1657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9kPjTu2OIgbpWb6TLGaY2ztM3jxSOBTX/FgRzwR6MOX1Ix4uIX2xArG5JhfPuYkeJOlwANbagyE7xiu0pptRxEqZi0Xq1WhFZIvW2PrdvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8917
X-OriginatorOrg: intel.com
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

On 9/4/2026 2:28 PM, David Marchand wrote:
> E810 hardware provides 32k switch lookups.
> Thanks to this, it is possible to allow a lot more secondary mac
> addresses than what is possible today.
> 
> In practice, the maximum number of macs available per port may be lower
> and depends on usage by other (trusted?) VFs on the same PF.
> There is no way to figure out this limit but to try adding a mac address
> and get an error from the PF driver.
> 
> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v5:
> - separated from series that went in next-net,
> - rebased,
> 
> Changes since v4:
> - rebased,
> 
> Changes since v2:
> - added an entry in release notes,
> - removed unneeded temp variable,
> 
> Changes since v1:
> - fixed buffer overflow on mailbox messages during port restart/VF reset,
> 

Hi David,

<snip>

>   
> -void
> -iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> +static int
> +iavf_add_del_uc_addr_bulk(struct iavf_adapter *adapter, struct rte_ether_addr *addrs,
> +			  uint32_t nb_addrs, bool add)
>   {
> +#define IAVF_ETH_ADDR_PER_REQ \
> +	((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
> +	 sizeof(struct virtchnl_ether_addr))
>   	struct {
>   		struct virtchnl_ether_addr_list list;
> -		struct virtchnl_ether_addr addr[IAVF_NUM_MACADDR_MAX];
> -	} list_req = {0};
> -	struct virtchnl_ether_addr_list *list = &list_req.list;
> +		struct virtchnl_ether_addr addr[IAVF_ETH_ADDR_PER_REQ];
> +	} cmd_buffer;
> +#undef IAVF_ETH_ADDR_PER_REQ
> +	struct virtchnl_ether_addr_list *list = &cmd_buffer.list;
>   	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>   	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
> -	struct iavf_cmd_info args = {0};
> -	int err, i;
> -	size_t buf_len;
>   
> -	for (i = 0; i < IAVF_NUM_MACADDR_MAX; i++) {
> -		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
> -		struct virtchnl_ether_addr *vc_addr = &list->list[list->num_elements];
> +	for (uint32_t i = 0; i < nb_addrs; i++) {
> +		struct iavf_cmd_info args;
> +		uint32_t batch;
> +		int err;
>   
> -		/* ignore empty addresses */
> -		if (rte_is_zero_ether_addr(addr))
> -			continue;
> +		batch = i % RTE_DIM(cmd_buffer.addr);
> +
> +		if (batch == 0) {
> +			memset(&cmd_buffer, 0, sizeof(cmd_buffer));
> +			list->vsi_id = vf->vsi_res->vsi_id;
> +			list->num_elements = 0;
> +		}
> +
> +		memcpy(list->list[batch].addr, addrs[i].addr_bytes,
> +			sizeof(list->list[batch].addr));
> +		list->list[batch].type = VIRTCHNL_ETHER_ADDR_EXTRA;
>   		list->num_elements++;
>   
> -		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
> -		vc_addr->type = (list->num_elements == 1) ?
> -				VIRTCHNL_ETHER_ADDR_PRIMARY :
> -				VIRTCHNL_ETHER_ADDR_EXTRA;
> +		if (batch != RTE_DIM(cmd_buffer.addr) - 1 && i != nb_addrs - 1)
> +			continue;
> +
> +		memset(&args, 0, sizeof(args));
> +		args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
> +		args.in_args = (uint8_t *)list;
> +		args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
> +			sizeof(struct virtchnl_ether_addr) * list->num_elements;
> +		args.out_buffer = msg_buf;
> +		args.out_size = IAVF_AQ_BUF_SZ;
> +		err = iavf_execute_vf_cmd_safe(adapter, &args);
> +		if (err != 0) {
> +			PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
> +				add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR",
> +				list->num_elements);
> +			return err;
> +		}
> +
> +		PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
> +			add ? "VIRTCHNL_OP_ADD_ETH_ADDR" : "VIRTCHNL_OP_DEL_ETH_ADDR",
> +			list->num_elements);
>   	}
>   
> -	/* for some reason PF side checks for buffer being too big, so adjust it down */
> -	buf_len = sizeof(struct virtchnl_ether_addr_list) +
> -		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
> +	return 0;
> +}
>   
> -	list->vsi_id = vf->vsi_res->vsi_id;
> -	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
> -	args.in_args = (uint8_t *)list;
> -	args.in_args_size = buf_len;
> -	args.out_buffer = msg_buf;
> -	args.out_size = IAVF_AQ_BUF_SZ;
> -	err = iavf_execute_vf_cmd_safe(adapter, &args);
> -	if (err)
> -		PMD_DRV_LOG(ERR, "fail to execute command %s",
> -				add ? "OP_ADD_ETHER_ADDRESS" : "OP_DEL_ETHER_ADDRESS");
> +void
> +iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> +{
> +	int start = -1;
> +	int i;
> +
> +	/* Handle primary address (index 0) separately */
> +	if (!rte_is_zero_ether_addr(&adapter->dev_data->mac_addrs[0]))
> +		iavf_add_del_eth_addr(adapter, &adapter->dev_data->mac_addrs[0], add,
> +			VIRTCHNL_ETHER_ADDR_PRIMARY);
> +
> +	/* Process secondary addresses in contiguous blocks */
> +	for (i = 1; i < IAVF_UC_MACADDR_MAX; i++) {
> +		struct rte_ether_addr *addr = &adapter->dev_data->mac_addrs[i];
> +
> +		if (!rte_is_zero_ether_addr(addr)) {
> +			if (start == -1)
> +				start = i;
> +			continue;
> +		}
> +
> +		if (start != -1) {
> +			iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data->mac_addrs[start],
> +				i - start, add);
> +			start = -1;
> +		}
> +	}
> +
> +	if (start != -1) {
> +		iavf_add_del_uc_addr_bulk(adapter, &adapter->dev_data->mac_addrs[start],
> +			i - start, add);
> +	}
>   }
>   
>   int
> @@ -2304,7 +2353,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
>   	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>   	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>   	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
> -		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
> +		(IAVF_MC_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
>   	struct virtchnl_ether_addr_list *list;
>   	struct iavf_cmd_info args;
>   	uint32_t i;

I would have preferred it if the caller managed the chunking, not the 
"add_del_addr_bulk" function. There is precedent for this style of 
refactor already [1], and I would like to keep things consistent - keep 
the loop simple (without memsets etc.), and make the caller manage how 
many addresses are being sent at once.

[1] 
https://patches.dpdk.org/project/dpdk/patch/5e6a55afa2b45e3ee5ec17af7a6c548c96e9698b.1771945933.git.anatoly.burakov@intel.com/

This specific refactor is more about removing rte_malloc, but it does 
also reorganize the loop in a way that I find to be more readable.

-- 
Thanks,
Anatoly
