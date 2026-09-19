Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A03C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6B040655;
	Sat, 19 Sep 2026 18:10:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C0F274064A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834246; x=1821370246;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ZLlAhBOL4sG8B6YlGwDFdjG/ieGduZ8sOSiwNzQpHLc=;
 b=Jvh02lFJeAmrCRC6K8vDpx9nfVhm+C0gCt+rgWljyuBdMXdJNmXsZT2b
 UULG/7J54611n1f55zjV1UkTOW0hFxD9t6o8LTISRWZGSN7ssqxmj6QBR
 bbWKo6T9Sx+QNymv+4kIV0FKQi7BtaUBl9m58+dmLLwzW0zicO52D8E3w
 YRuUwMAgHIFxbVYdVUrtOJndod68U25jlGk/iEcvemRTkpZYA+Tz4pybC
 BgL7Y+9tL7L7ZznBimbtNcNMHWxoCY2A/PbX3iJCDPiEdzdNoj2M3KJoP
 FsaGG7h7xHRDVJozAuQDPbceGUm/nNDOYgkvzXJ1BcthPIOsibeIbgnO9 w==;
X-CSE-ConnectionGUID: drXvzVDLTGeqczcYjqiAgQ==
X-CSE-MsgGUID: ZBdeLkJ7QYq0BrfppUoOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89490820"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89490820"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:45 -0700
X-CSE-ConnectionGUID: nGc6tNOUS5eNwxfvGez5rg==
X-CSE-MsgGUID: mFUew1nzQzCeaar0TtAwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="268545277"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:10:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPBDImcX+vptADy1ejFzpT6AdCQcLM+pdeBjowApzN6/JpLWSK4ZSxQLEH/5DYDYSGYzL6k9jmVj1Uiup566rmQN2FDtUN5Qivg9RHjy3h7q6WHsfJDy2jLTFejimeMPnfQ6V1aQf+/pDtn2ZGUw89MSzp96WxtW8hMxTzZOZZ+OkOjlnpPqaEqDk9vu/01AvTStjqsSvtgQFhsVx6eGxB+P7sRs5ccSg6TrwfbnLfLqm44HuS5J6z8XXXtlA1zgEhYG9JvjvZw08S81sIH7DgYHIZ0jGIIraDD+OsLzr7P3zFZiK01AUQiAtbjlNCF5TW0Xi6vlemMzpt7S4XoyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9hsYBPYWfRrrwcz/MwWYfaUmGuY53V+OflsDaBpE2Y=;
 b=kfc9JczkleelYLScxG4l0c3gbqx9e3J7/RChaEHpFyfu57WWAD/zcLXzKr/X+SV/Rg+F7pTwUuHhrdTjUGZTlZAY3/pOhf6yPyzDNQUw5OhqcbcgR4Rz0pyWHGZJ4MGM/inMFZPbdoqhWTU9tRrC8AN+2XI548ckoznvfLz5X8f/+slZl9zd95gqUm21gQ1BgX13g7SXxIbKgL1ha7ZVqIUB/tK+9IOu1ZxMT1Pf7nrWuWxD/V2GVR3jAtEGcwzIDQAeVUpkEIEYTO/17BZVTQn3pA0QPqWgVrYzTYIlxTiYKhchIK/rFP23ZzGTLa0B3gqiVTSNtsMZ9ye8Q723MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:10:36 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:10:34 +0000
Message-ID: <9ff39b98-de48-44fd-9d71-d2de44e1ac0c@intel.com>
Date: Sat, 19 Sep 2026 17:10:31 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 06/19] net/ixgbe: reimplement syn parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <4daf67ef6722dac1f9a42d736e2b3cc05fd6c537.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <4daf67ef6722dac1f9a42d736e2b3cc05fd6c537.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:10:234::25) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d18f149f-ecb5-4a28-6f3a-08df16688923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sMTwT04kHdXfntPE6hwzmZstKFLvg1cUm4Iqyn40SFS1fc64ErNrXBF9QscD5x99Cs9bMboSh4H7DAlHW5y9DcwpaTdn43y794hw/Obgz01i+MQk0PdUIFkdXUBrNfzFhiG/IqG3CES2/1ZGYCFgKzotAJPgCnql8p+A3XNoZNtYz4UNz14R93p0ekhCNrC7XeXz5UmXboLugOQVCL12j7bn3pGaeTBw5n7CS+jkChlo72/ON3c04CtUZmbQjTR4N2khuY0fyEc4UPMzAd8P+MtanR903ZLoIndAgYUICtEQouYJF/2cwz5JatiPgpC6lfwJbRNv+5t+BUsuTeh01pl5+9fbBIXGhwYsMx7ef686soAudI7iBxDSa6l2pRU3PNy/Brlv5wwlFbTBkvgb1mlpUxg4Y4/1Vy3so0O94IypN+mEV5h4uoUsEjVPd1qZ/35bal5wrzbdUGDsH7o2VyAVbfnmnc2iz2UkrOlaL3vkGFCYGVKwZn8B89QsjqsYIxNwPm2kbgPIquO88FTMj9lpIFqT2aSbuT68427+mpABlv/qXMGd6qEpWpptXa3bND6+Eygc6ktEcB5b209JDtVCiSJCaurCBQJKh6/XGnQb+PIt8Pvkyh8Cy3wt6jfDpj6oNxIWl9VXItecXlhkzu3H5K6kRW6mQ/bUHz2EXfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lBd0hxSC9TODFSSUtVbFhRKzUwU1h6T0NQRTNoZ0k2TzRSbmV0Wk5OZFZZ?=
 =?utf-8?B?SXNlSEhhbDUzMVAzQTJPSHFaK2t2RnNSVFA3clJxcDJCT01OZUNxdVNwUjVi?=
 =?utf-8?B?WEp3Z09VOXhMSWNyT1lvc3g1ZkJSdXM4REZsNzBEZW5ZS0xNL3dVbmtEamhq?=
 =?utf-8?B?L0gvM21OdUUwbVlXVU5VMUl3Z1pxaWJpOWhCK0FIRGtIZW13TTc5MitDV0hC?=
 =?utf-8?B?MzR3YzhwdGxzYWRHWnQxVWZCTDRUdkpEdEhRVko2bGZ2L3NDMGlFTXMranZx?=
 =?utf-8?B?eTE1UFM1SHdJeEd2K3JwRkNnWWV5TkpYV2JqNTd1SmF6RGJQMjk2bDJVOWxB?=
 =?utf-8?B?L1MvQjNaUi9xYklhUERlM3QyT2thSlErcjBYc0hvQWh4RGwycDk4cEwvVFAv?=
 =?utf-8?B?LzNaY2s0V0xRK1NoWGFTdTZLYXVhY1ZwUTBDVGx3QkJDSEJYZllORWVwR1ov?=
 =?utf-8?B?MTA1Y29vS0YvSHB2NnFRUFF6UWxFN0xsaGNvWmN2TVAvZEoxYVJMTFcxb1Fh?=
 =?utf-8?B?MGdLU05XTzdvaEZDS0VRb2ZGTXJUY25DemJLNWxGZ0ZNbU9aNkhPamdoQmNl?=
 =?utf-8?B?V3NMUHFDaTVXTXJhTWhESzZkVFdyNnZJcThTSG5SZ0hleGlWbDE1QVBLeUJ2?=
 =?utf-8?B?V1IxemRpTTBKSWpLQ3dxRVlONjdqTlZodmcxaGRYOTNJOTFzN3lzekR6TXFI?=
 =?utf-8?B?YXpwemhDOVo3NXJCVU1zSDdkOHJjTERJNk9IK1BlaVZXa3lZMHVBK0JHWHg0?=
 =?utf-8?B?RVhvZ2NqckdHNkdzSE1tc0h3Z1NXZ3hwTEUrbmpQcVVYYmxscWptcGJmbHIw?=
 =?utf-8?B?S2plZkpjdzRyNXlqVElRemNNRGM0MytPcWF5N1lpZDgyK21tTEd3L2hWY2Iy?=
 =?utf-8?B?ZlRlNnNBTElUNG5qYU5kc2pUS3F4aERVdVhTWEtuQWFRYUVIUUZFUjZVRHdU?=
 =?utf-8?B?Wmd1eGFCNDcvTUpZdTQ0LytFbE1GSm1DOGJQem9DdldWZkZRblp3aVJsNkVk?=
 =?utf-8?B?MnhabDhrWUpsbnhna1cwVTZRT2Q0azlnYUEwYUZvSmxHNzRDWHlhWWlmeGlu?=
 =?utf-8?B?VWNVQ1VPUmtBSHNzRlZXKzArUzFUT0lBS2JSaHpvbzdsa0FHcHlhNHp4QTli?=
 =?utf-8?B?Y3BvdHQ5WFVqSk96VWdXdy9rbnRVMGZUNDByem5zY2dXWHBBTXRFRDIrTStF?=
 =?utf-8?B?ZVFXZTNqWXljUXE3T0w0N1czNHJua05xWXk2M05lcFBOWGVYODB1d2VDTUFs?=
 =?utf-8?B?RFBrQkE4Rk1KbGJ0TkhXajVSenJyZTllb1BQTlo5SENucVBjTEhRQU9kWDJk?=
 =?utf-8?B?ME55bzNVeU15d1JvemdvUVdqWW9CbW1pcTMrSEFOVHV2aDc2ZmxHL0ZVRGJO?=
 =?utf-8?B?ZkxNZ1RwcTlKejFJbUlJaExNTjNsR21WYjA3VTIzOFV5NldERXBPdFRLRjBW?=
 =?utf-8?B?M2dxakZQNjJVTEtOUEVJaUkvenlwSGlGNnF2UEFRQk1zUXNOWXl6OWEzRU1U?=
 =?utf-8?B?N3YyeVZpb1FtSGd2TnBnMkpvczJ3NExMYUNIUi9RclZwUUtXQmEvR0FscERZ?=
 =?utf-8?B?MUVCN1NpYXdsK0FPUXJXUkwzNEg1LzhTc3FyaVJwbXAxOEhkOXpHdkZEOHpB?=
 =?utf-8?B?YVAyTmxlbmRjazhjSWxOeklPQTNJU2FTUGJDSXlFSGRxaURGWjFrYUFNM2RL?=
 =?utf-8?B?Q0d6cUhmeDRsVmRYRU1CSWIzS3V5UXFuWG9aaDZBQnp5d045elZnMjZ0Vk9r?=
 =?utf-8?B?V1NWTS9hKytKak5EZWpKUUFvT1NqMEplWWpPaysxRGt2bUJuWmV6NThWbTYz?=
 =?utf-8?B?bkVlQnAwdTY0Yk4rUkVXZ2tnRnVKWXZSMlE2aHl4ZHFISHlMYVZSWXRVRkxa?=
 =?utf-8?B?NjVtUVlRTjhNRWVqSXJDVUlWYTFQK2QwQlVQcEhCNGNNV09HNkNQUkpiSmtm?=
 =?utf-8?B?UlcyTU5Fd2JOV0hnUkF3RVE2OEZJWEVGamlaWXdwK3E5QWlPTVVKSzJxZzYr?=
 =?utf-8?B?ZXZ2c2c3bko5UUJnRC9qOXVPbENwYjEvbU1jeGxGVVN4Z21KS1lzMVdjV3dn?=
 =?utf-8?B?U2xLTytKcTVhcDd6VERTQ3J2cjJEdkJvVFhGOXZlcGE3ZmR0Y1hka0FmUSt2?=
 =?utf-8?B?ZW96aThJbTUrWGYrRXFxVVNlckQ1NWUxbG5XQUZzQ0FkbUNsQjhGNGdDR2sw?=
 =?utf-8?B?K2V1T2NCdFdsL0MwaDZwa2NOU2RLWmg4N3djZnNadVNWUzlwaFFOcXhiMTk4?=
 =?utf-8?B?VTFUUHJ4VVlGNjcwdDFsNVNuN25pWnF2eGtwc3RZTnFlT1hNR2ZTTjB1S1FQ?=
 =?utf-8?B?VVBxVStmOTF3R0daTEE2RWpLbFdyYzBzUnppSVNWcDdoWGZiL09nU0hUYzJ5?=
 =?utf-8?Q?SF83Y6dRjDqjoPVI=3D?=
X-Exchange-RoutingPolicyChecked: qBicOX7Ss+Jsh+ERRlGWPOa/vpDlugNoV04c7w8zgWm6PJlloqD1xqvnO90UGmG2Xk78qGts3DvO8ARPZ4b/S6Cu1HJolm0Ot1Gtv4hBJyyw1v9hkBpUpirTmtO4hiGzYv5aycXWPZmg4n0+V4xvukhI0/NAYelscUddYPIFR0adiK2GrZCVreQxT4634IgiXovb/IXTkGBHEARLIazRaY8khCCjjITQ6kDc4jcOhD1YiJ5gJ/nv7F8JkI8qCVIB8wCEyY1x0SXWamQJRNBQLrN47tbrVhj7cqjf5F2yqY4iPpOthOsbZXPqXiGxZteZFI59T4Ej3wtrfvN8sZumZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f149f-ecb5-4a28-6f3a-08df16688923
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:10:34.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfKrZlEI+et6BAeCZ/II+2d4HihjhEoH9rKhIfLmsuQrpaMV5mDx+9AH6Wc6txJYq5YMd4gFCYUWVbcF/Ve+ARLZaFkxEVw499Im7TAyIRg=
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
> flow parser for SYN.
>
> As a result of this migration, queue index validation has changed:
>
> - queue is now validated at parse time against the configured number of Rx
>    queues (nb_rx_queues), rather than at install time against the hardware
>    maximum (IXGBE_MAX_RX_QUEUE_NUM)
> - the per-function queue bound check in ixgbe_syn_filter_set() has been
>    removed as it is no longer needed
>
> The syn filter tracking infrastructure is moved completely inside the new
> engine and is removed from the rest of the driver.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> -
> -	/* Support 2 priorities, the lowest or highest. */
> -	if (!attr->priority) {
> -		filter->hig_pri = 0;
> -	} else if (attr->priority == (uint32_t)~0U) {
> -		filter->hig_pri = 1;
> -	} else {
> -		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
> -		rte_flow_error_set(error, EINVAL,
> -			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
> -			attr, "Priority can be 0 or 0xFFFFFFFF");
> -		return -rte_errno;
> -	}
> -
> -	return 0;
> -}
<snip>
> +
> +	/* check priority */
> +	if (attr->priority != 0 && attr->priority != (uint32_t)~0U) {
> +		return rte_flow_error_set(error, EINVAL,
> +			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
> +			attr, "Priority can be 0 or 0xFFFFFFFF");
> +	}
> +
> +	/* parse requested actions */
> +	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
> +	if (ret)
> +		return ret;
> +
> +	q_act = parsed_actions.actions[0]->conf;
> +
> +	syn_ctx->syn.queue = q_act->index;
> +
> +	/* Support 2 priorities. rte_flow priority 0 is highest */
> +	syn_ctx->syn.hig_pri = attr->priority == 0;
seems like inverting priority with the previous implementation
> +
> +	return 0;
> +}
<snip>

-- 
Regards,
Vladimir

