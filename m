Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E08C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:10:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56BED40695;
	Sat, 19 Sep 2026 18:10:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 716DA40655
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834219; x=1821370219;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=XcKq3somBixGy2xlcgTlhge04B3z2kADjh1gpUZng9w=;
 b=ae6YrDPM4cvBUElvOaDLhruDQ6fV3GPzNn0NHB34DimZJ8Y63mllOz+8
 ZSelVukv3kTqki81rsE20Dgh5OQH3Ya0b9J/Sfq6C8y28iRDTrW42AFS7
 eRsdSIs3+N3tvpWlwg8FOQPJAFTgPMPKI56IxqZY/Y+hZzdeCvpwIIuPx
 iFmV27hxH6wx8ekhK2NmZCEcoZT6WMs/Z9QrT7SHhFNg+PDCzDlh/cNE6
 dD5qvUdOWxpEawZrklDt2TxIFfoV207OREyoEYaphpwdFlU9nscpi4AwF
 66H3+nY0F+Wasw1Ovh44Hv+KBrUlb9Alqi1lUxYRLKFudNeChP/6Sh3AH Q==;
X-CSE-ConnectionGUID: /t56j3jTThaSeht/x3Hzaw==
X-CSE-MsgGUID: ov9RVBXtTSCFEOqaR9gG5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="871703"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="871703"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:18 -0700
X-CSE-ConnectionGUID: T6WmSOqJS3asiDzEVwT2og==
X-CSE-MsgGUID: p4ZW8wTYQmWJNVFCUTByJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="299943564"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:10:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts0b+xvaYze8rdIgjYz82sZkwwMSXVmXtlvxZvEF7MkGQ+yhW10HwaIdAlZ8lEqjdi72xIveSgX2az4aa1zMfLfq7G9YL/qRrp/G1OVCrMyGyhAu9mH0AhVENN3bvceGGb7rz/auX5TnyqSPowxIzl9u5TORvUcf8sfn0f5RAqVqVBZrxPmxw9h3jkfEIrvRqrWJ7oEM3F++VnQEO8+FcKHuS+Qce5a1VFFdMqwv92bbTfOT9LYQhEBIJaI/Ryy4bwoxPhXBQxPCnSD7DtJrKUL9oDeRr+tthN+y0yiF8HU7yEMqP525+z5T3w3c4vsLOr2l9bxaF19dvUaofHx6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuBeqKnzraBzgxt2dSISehR5BKd1P7JqZCUpdqLLTO0=;
 b=H0osNzf8rmaifUmYHtrDJmm+69ljwYaXyToLOT0U/zxQ/iQHVJEGLHK2eQzyMU/JwCuj3tHGGjxyLEh3S7KaUlqL+AFmkFJFa66tlcUUWVLnXhLj5DS3fdQwTdsgXhbVdnEKW2yL37eZYIEMKmhg67IBi6gPIyGij9uma2LGrEa5jigYWgqMkfXoedK9IpYV9fuK5kHNX/GCa/UsUo7kXC++clNGXmAg2MaPX43ohTx2rIyYjtMkMXH3eDJ5pglxLwj/P4NWLFdJijQbSMsiriNl6DfzU0lfXt+XFevHQtN+834Yzor7iF84YOHcxsYGthU/fvDUmKS5KgMZVPe6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:10:14 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:10:14 +0000
Message-ID: <0baf24e4-ef72-4462-8804-6be86701a423@intel.com>
Date: Sat, 19 Sep 2026 17:10:11 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 05/19] net/ixgbe: reimplement ethertype parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <e389782f585880877bd626cc0a05bac81e418393.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <e389782f585880877bd626cc0a05bac81e418393.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::17) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e783dd6-83fd-4086-412d-08df16687d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sDh64vIx/0OZAgW53QKyMQ37Bufkpr5VGoUanWvkr/To/arpqEJsOUIHg441jJLTOA9Db3XTMjWYn7Iu2HozM2DyKP0+pY56X7qz1N72x2QQNRKPvAqWCy7Q9w1RTNa5iIX/dLHt7vZ6Xms4oTC0vI5G2l+EYBkaJ95p4HwgHuiCuBj3azaGMCSo9wbgfzqS1gNKfr8om3Yo0HO8XlJNG8jEEY+RSqZQdsihuJCZxlHLSqPB3ydkDNbneh/K7KVinvqaToesaYuJp1oy8SqV2ZS0PBypOZtBhscl71xJtb9kkEinsqdVPJowvdBY7szK0jJtUADb5b5+bbHFM2PsHWN1Zwe7vNMTHtGpjVSeR9z6E5pGxo7SLNGOj1ZSEkukFHD6p2ZszV0LSaP10deMMRsqGSObfRbkikRtiSiiF7UyYEIqAYOk2KWjg6PBzDb/E620B5c0NJ0ZBiRtOFC/W9WRt8h9+0PTFldObAgTGt3pMEIz3jY5DCHN4DtzmZK4JtfLeXrLduFAZ7aRmTsuZy4y10+Zthetk5Wv870271xQTd6BRLLNjAdduRk26R5NnUAYVQy7tlCgJBcSrj4LGBpsyxaXfqneEOOfxqoRtDiMWuQUCaDzzJhQN6wRGn5R8X9yi2mNK3xuRmbQpVaJgNcpINFUs4gxVWPOgBHYN1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVwSVFrdE5YRm5WVFdoUVBYQVp2NmNUS1JuS0pNcDFsRC9RcWZxMFNWMDJ3?=
 =?utf-8?B?MXBWRXJHa1JHVkZBeWNBRDAybUs0Zk5KNVZFcjcwNEFVUWlWRjNFbWlheGUr?=
 =?utf-8?B?dEdDWDdiRFl3NlI2YmthaEhNZDFzQkdPcWZtRFUraWF5UVJyMWQ3bzhWY1Vw?=
 =?utf-8?B?WnJZN3dFV0ZHck0rYkFhZjB0T29UVi8vTUFwL2MyQWtsZ3Jad2RsdHRORHIv?=
 =?utf-8?B?TFlEMDN5YVNsdm9OdENKeUFpeHlsc3BBN2ZXRW93c1V3bGFMdnhvenhsa3ZF?=
 =?utf-8?B?azZPaVVTaGIvWVlCNVBldy9hem4rMzRnSXVwWExXUnhINytLck9YY3dUT3Nm?=
 =?utf-8?B?eGFHaG1BVEkzcS9BZHZYRXlYbGR4Um9henpWWjZFRTNHc3RsQ1FmNnZ1cjFr?=
 =?utf-8?B?SlZmVWRhd3JldFZsMFQ5UDBhWlA2cEJMcDRNeXZQQlMrdjlaYmxpQzFFNk9W?=
 =?utf-8?B?Nmp5KzNuMVVZcEwrZHBQdjc4T1JORzlaQWpUZUh1aWlvS21nSkV6TmNyQm9t?=
 =?utf-8?B?U1JrczB2TG5jYXFwYmhScTlwajN6azE1cG9wY0FwbUpZTjVkVlhWendObW5U?=
 =?utf-8?B?YmtXdm5vclNpNzJ5RGttOVltWFc5R29oTEpLVkM0MTh3b0NuYmtXcUpDdnFh?=
 =?utf-8?B?dUR5RU96cG1jenY4Y3RabVBSWEVNTGtXTDYrNkt1d2tDeTFyY0gwSytxYjFP?=
 =?utf-8?B?VjZobXdDY1BHZDNWNUswZmtqUGFmdFdwSWthVjIzTzlDK3JlejlsV1JCTDBn?=
 =?utf-8?B?eFpVekZYeEZGa2hlOHd6UUxCblJKTXFiSFJsS0oxbFdrZkh0cXhuWjR3Q0xi?=
 =?utf-8?B?UFV0bS9objVhNit1U1QrMmlnNUlTZzFPNG5rekQ2SGpGSTFiemE1MldvdnYr?=
 =?utf-8?B?UFNBeFpRVHF3TG0veXN2UmVRMVVKRno4MmUvVHBnSXUyMFhmUWRNYUoxbWlQ?=
 =?utf-8?B?K0wzMlVDN1dzeHpKTTBpR3IxbmhKQXlySFVlY1pMNDRWZjVWSkgrdjVoTllm?=
 =?utf-8?B?RjhkcmY1VHU1WHJzZHNQOFdqNDhGSkhydnFDcHdsT3crejkxdGIyVGgvNTR1?=
 =?utf-8?B?UDVzdzU2V1c1TXJ6eHJFck92cFlOSTdiS0s4a1ZYZ1pqMGR4NldYVUlVZzlN?=
 =?utf-8?B?RFhCUnp6WVlybXYzSW5wN2dYOXQrRG1wK09SU1lWYkh2dmZzSitkSjRuUmJW?=
 =?utf-8?B?ZnUxek5TdENMalN1VmtrUGpyUk8wdVV1eFlCM0VGeHJXc3VqOWRVM0JaSVVz?=
 =?utf-8?B?dStZbHozcVRPVHVjbTQxTDFycDREZzg4K3R3TjEvU1BYTE82U2hIdHpDTnZa?=
 =?utf-8?B?blFQSVd1VFViNjdDZkh0eHNjelBtendNcTFOa1gvblFTUnQrNTRra2F1YVlR?=
 =?utf-8?B?YlJwOXNYaHNDZTJkNWI5QTRkM2doamxyOXBvMFpmTDFTMEtYZzhIUm1vTi9n?=
 =?utf-8?B?TXBjcEdIcWRndjVEeXRGejRyNVdQTEdDRnRsWlllM0cxSzFmUHRYSUhQbFlj?=
 =?utf-8?B?UEF4OEkrVnF0NWk5dUczVi9POUVycVIwY0tBSHg4NndieWN3ZmxhNnNQd2Zj?=
 =?utf-8?B?Y3I0R1FHR1NCd1lNUjNQZnIrb1E1ZXRZZzBGcUVnY2tqSlJRWHVDakw2OUFv?=
 =?utf-8?B?aVNiemxKRHNiQW80RmZ2OFpJMk5EdHVtUmJBRUxkK1RDS1Vwa0pLaHNJd3ky?=
 =?utf-8?B?ZHB4T2NhRU9hQ01zYThCVDZGME9SclNNcVhiSWhVT3FCbHJwQXZMYmUzRGFM?=
 =?utf-8?B?YXZrcmJjTkUvanBwSExuenRhMWVqek9VZDg1bEQ5OGZuQWRPR0pScWZSU1I5?=
 =?utf-8?B?UTlZM3FlSUs0UHA4c002ZmJsS3psVjVxd2RxS3cwWTg0aTZ3WHUxN0NjaUF1?=
 =?utf-8?B?RngyNVZrZ2pCaktXVTJtUzhZOW90NFZ3REVSeFBqN2FlYjlQL3Ridm83dUNa?=
 =?utf-8?B?M3czbDM5cm9LOFJFWE5SS1JBZEZjSUk0N04vVSsrSWpQa1JBVHltUGFtVkVF?=
 =?utf-8?B?RytNSTJyU0pOUUpFVDNlSlBJaFhxM1M1UlVSUlhNSzQ4dTBIUFhhQlU3ZFFP?=
 =?utf-8?B?bndpTDVKRGYrMUtzSHlzT3hudzBqbnFOSG9rajBCK25LYThxUXVnQXFxY2Jm?=
 =?utf-8?B?UzM4b09EN1ZuZm9UN1FCQ2tzbFBkMHYvVWc2SlVlMldLbURUOEd6VFgzU1Yy?=
 =?utf-8?B?cFlGL2xMWHZRWHZ2d0w1Tlc2ZkkxM1N0L2NDczk1cTBuWUVtVGl4ZGJ3eFVu?=
 =?utf-8?B?RmpKWk14c2pDWXVwcEdod3R3THN2NndOc0RKUHA2T1hjRFk0VlhzakQyTE9N?=
 =?utf-8?B?NFNMcWdsUjFjQjltTGJxUDhLVlBIVG5vN2VHekV2M0lDT1Qrc3ErZ1dkeXJq?=
 =?utf-8?Q?W9uwpyN3pLQ/RQoY=3D?=
X-Exchange-RoutingPolicyChecked: FiL1WSJbJ/jCqywHgHaM8FbvOcBmoLvZQyfnYcU4I5SMUPPL0ZXx5KmdjaqorOjO6FS0LwRI+AqSbXofZTBPOHOt6JDvjvV9jX+am+kHQwLTT3oUDOTkQ0Rb9T45jt81aLmr+KSHf1r+iWAbiJxVsK6hrlbonQfj0KpzOYdcgpG4fOE+g1rj4YikqclwP5yVZFxAetctxXNfFYo7w2hQfBW61lncCz6Fqh9/bLdRKL1mKviQarf+VEZy9SpO81o+asKInrrHaNllc+YisyNSwl/IjHN9etNeb4DfpKZbxYNtawL2DCM7p2Bo0eliXLwEK3MUtuDbcBDqRXE0zENubQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e783dd6-83fd-4086-412d-08df16687d7a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:10:14.8240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpBZBQnx5trfQ1VMfglkJQlwMZXTqOP4Phb7KsQQYwJ72gv3i69f7Zb2IM8TMwlti3si4d62hRVi/wDdmksAM4Wc3t8ekVEsapey2JJwln4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for ethertype.
>
> The old ethertype parser was accepting certain things that were later
> rejected by the actual ethertype installation code, in particular DROP
> action as well as dst MAC address filtering. This was removed from the
> graph parser.
>
> The ethertype filter tracking table is used by the rte_flow ethertype
> engine, but it is also in use by other features, so the filter tracking
> is refactored to be properly shared between the engine and other features
> that write into the same table.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> @@ -7198,8 +7177,11 @@ static int
>   ixgbe_timesync_enable(struct rte_eth_dev *dev)
>   {
>   	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct ixgbe_filter_info *filter_info =
> +		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
>   	uint32_t tsync_ctl;
>   	uint32_t tsauxc;
> +	uint32_t etqf;
>   	struct timespec ts;
>   
>   	memset(&ts, 0, sizeof(struct timespec));
> @@ -7221,10 +7203,19 @@ ixgbe_timesync_enable(struct rte_eth_dev *dev)
>   	ixgbe_start_timecounters(dev);
>   
>   	/* Enable L2 filtering of IEEE1588/802.1AS Ethernet frame types. */
> -	IXGBE_WRITE_REG(hw, IXGBE_ETQF(IXGBE_ETQF_FILTER_1588),
> -			(RTE_ETHER_TYPE_1588 |
> -			 IXGBE_ETQF_FILTER_EN |
> -			 IXGBE_ETQF_1588));
> +	etqf = RTE_ETHER_TYPE_1588 | IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_1588;
> +	if (!filter_info->timesync_installed) {
> +		int idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
> +				RTE_ETHER_TYPE_1588, etqf, 0);
if I understood this part correctly, from now Ethertype filters are no 
longer statically dedicated for predefined set of ethertypes (ref 
IXGBE_ETQF_FILTER_1588) and now are dynamically managed. It is probably 
worth to separate this to another commit, or at least mention about in 
commit message
> +
> +		if (idx < 0) {
> +			PMD_DRV_LOG(ERR, "no free ETQF slot for 1588 timestamping");
> +			return idx;
> +		}
> +		filter_info->timesync_idx = idx;
> +		filter_info->timesync_installed = true;
> +	}
> +	ixgbe_ethertype_filter_program(hw, filter_info->timesync_idx, etqf, 0);
>   
<snip>
> +
> +static int
> +ixgbe_flow_ethertype_register(struct ci_flow *flow, struct rte_flow_error *error)
> +{
> +	struct ixgbe_ethertype_flow *ethertype_flow = (struct ixgbe_ethertype_flow *)flow;
> +	struct ixgbe_filter_info *filter_info =
> +		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(flow->dev_data->dev_private);
> +	int idx;
> +
> +	idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
> +			ethertype_flow->ether_type, ethertype_flow->etqf,
> +			ethertype_flow->etqs);

nit: is it worth to check if idx is negative instead of handling only 2 
error codes?

> +	if (idx == -EEXIST) {
> +		return rte_flow_error_set(error, EEXIST,
> +				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +				"Ethertype filter already exists");
> +	}
> +	if (idx == -ENOSPC) {
> +		return rte_flow_error_set(error, ENOSPC,
> +				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +				"Ethertype filters are full");
> +	}
> +	ethertype_flow->index = idx;
> +
> +	return 0;
> +}
> +
<snip>
> @@ -168,38 +180,29 @@ ixgbe_add_tx_flow_control_drop_filter(struct rte_eth_dev *eth_dev)
>   	struct ixgbe_filter_info *filter_info =
>   		IXGBE_DEV_PRIVATE_TO_FILTER_INFO(eth_dev->data->dev_private);
>   	uint16_t vf_num;
> +	uint32_t etqf, etqs;
>   	int i;
> -	struct ixgbe_ethertype_filter ethertype_filter;
>   
>   	if (!hw->mac.ops.set_ethertype_anti_spoofing) {
>   		PMD_DRV_LOG(INFO, "ether type anti-spoofing is not supported.");
>   		return;
>   	}
>   
> -	i = ixgbe_ethertype_filter_lookup(filter_info,
> -					  IXGBE_ETHERTYPE_FLOW_CTRL);
> -	if (i >= 0) {
> -		PMD_DRV_LOG(ERR, "A ether type filter entity for flow control already exists!");
> -		return;
> -	}
> +	etqf = IXGBE_ETQF_FILTER_EN | IXGBE_ETQF_TX_ANTISPOOF |
> +			IXGBE_ETHERTYPE_FLOW_CTRL;
> +	etqs = 0;
> +	if (!filter_info->antispoof_installed) {
> +		int idx = ixgbe_ethertype_table_add(&filter_info->ethertype_table,
> +				IXGBE_ETHERTYPE_FLOW_CTRL, etqf, etqs);
>   
> -	ethertype_filter.ethertype = IXGBE_ETHERTYPE_FLOW_CTRL;
> -	ethertype_filter.etqf = IXGBE_ETQF_FILTER_EN |
> -				IXGBE_ETQF_TX_ANTISPOOF |
> -				IXGBE_ETHERTYPE_FLOW_CTRL;
> -	ethertype_filter.etqs = 0;
> -	ethertype_filter.conf = TRUE;
> -	i = ixgbe_ethertype_filter_insert(filter_info,
> -					  &ethertype_filter);
> -	if (i < 0) {
> -		PMD_DRV_LOG(ERR, "Cannot find an unused ether type filter entity for flow control.");
> -		return;
> +		if (idx < 0) {
> +			PMD_DRV_LOG(ERR, "no free ETQF slot for Tx anti-spoof filter");
here and for ixgbe_timesync_enable(), what if 
ixgbe_ethertype_table_add() returns -EEXIST? It is better to add since 
ixgbe_ethertype_filter_lookup() was removed
> +			return;
> +		}
> +		filter_info->antispoof_idx = idx;
> +		filter_info->antispoof_installed = true;
>   	}
> -
> -	IXGBE_WRITE_REG(hw, IXGBE_ETQF(i),
> -			(IXGBE_ETQF_FILTER_EN |
> -			IXGBE_ETQF_TX_ANTISPOOF |
> -			IXGBE_ETHERTYPE_FLOW_CTRL));
> +	ixgbe_ethertype_filter_program(hw, filter_info->antispoof_idx, etqf, etqs);
>   
>   	vf_num = dev_num_vf(eth_dev);
>   	for (i = 0; i < vf_num; i++)
> diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
> index 0531d37acd3..f2857feab76 100644
> --- a/drivers/net/intel/ixgbe/meson.build
> +++ b/drivers/net/intel/ixgbe/meson.build
> @@ -26,6 +26,7 @@ sources += files(
>           'ixgbe_ethdev.c',
>           'ixgbe_fdir.c',
>           'ixgbe_flow.c',
> +        'ixgbe_flow_ethertype.c',
>           'ixgbe_ipsec.c',
>           'ixgbe_pf.c',
>           'ixgbe_rxtx.c',

-- 
Regards,
Vladimir

