Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848CC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 08:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3716402B3;
	Thu,  8 May 2025 10:35:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5F4C04027C
 for <dev@dpdk.org>; Thu,  8 May 2025 10:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746693344; x=1778229344;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dPSQg29sR9wQZgyJ3XdBljrJrIjU6XhAH4ERYOOgjz8=;
 b=M/QhqIKwe+I0FDisLL1X92GnVbHxch8htw21L595KD0Of7Geh7qx14o4
 EBFRDhUgIZSzz1U1ZNLydb/08uA7k/8f45+pZAoQrEawoYZYlDY63oBtq
 aLmAL0kOdLAx3iUpDO85RnrTFTi70kSFTw6L5WCfQT6v5SXcW8zIgZZSS
 8GkN8cjw6I1GrPSzmrq8cKuGIy30uJFtAH4/mhcBbQAUTrzBF+VHexN/N
 z8iAzTTB7Fkb5PyEYyob3pt5yyL3nQJS0x9X+BwNXxKOScYE8HxQMBoAx
 ql6sQZowDBIPel4HdpmPgZDgPfeRog7I1JHjGAk9JXbNmtXN2nshstNqH w==;
X-CSE-ConnectionGUID: Dw2OCPeeTjmfjqLQddGtcA==
X-CSE-MsgGUID: J77N7J4qQsyUi44r8jBwFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52273333"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="52273333"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 01:35:42 -0700
X-CSE-ConnectionGUID: /5LwWz18Saib56uL77HK9Q==
X-CSE-MsgGUID: xV+KWWkqSp2pAwOC9UimbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="136168943"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 01:35:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 01:35:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 01:35:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 01:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq21C7VbPslC94Q9uDuJPk/Bpq4vS9SiIqL8rLtzflVstjGuSWxvp/oA42+5fTlrzD29zM+L/E5q/Z8lhcJ56MbNZMZHin2mo1X7/JR2UG5er8oUr57cEYs5F4Zegbu9KuW6tzqnKzQVwFNNuspH5AtejsZqrkGMcTu8y6QRRURpAY9oXxaDB3GCZKaBM3Rcgkx+llxW82RqvqUWaYN9Z1+Ic+ZblIt6JaWrXAcyEjp5sXJ6g85rWC7xMef/6XPD4o3plGEODNylT+e4jswlLL2l7ps3Ig61uWKr8Uaib5n3VOZJpvmFEhPURlnzrszGBr+gJPaJXxyj7yI8zVgKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39b05utHDanv50TBnVNuGhCFwGJ1mhXsFfnfjRxyO78=;
 b=bDlu7vm9LdVOqzlf+IAM+4puOae8nDB/Twu5Ecvmx578fL7fvuS//BX7A9szjq1btF6aIMfP6QbJyVKImD2p+BpQksFHxsdTkx9s4bJtEWYy5T3PTe+lex9R5G1b34GQYZsRtuuFsFXmZ/104/kJPrqqyEv1bb4dQtoFWBHp/14rPplXwvCcX7M0TQW9vk2qWjSTuzMRU0AjmIaxwD2OcheL2IsQMiHGKM9lvKdCTuglbtN7lqBM0n6f6buG2tcNhV/czBJrhOeSYGJSq0Zuu3oHcM2CAfRt8Lcs9sFR0vAxidwvbzsVWy+NIVRGsyuUbMvqKpp1Yn6rDM/P00tnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 08:35:11 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 08:35:11 +0000
Message-ID: <e682e211-8f3f-40a4-a4e7-0a88df19d7c3@intel.com>
Date: Thu, 8 May 2025 10:35:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cmdline: use C standard library as number parser
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <aBxc7XgW1xUeiV-t@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aBxc7XgW1xUeiV-t@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::37) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 866fcbec-362a-4fce-a79c-08dd8e0b3f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzdoOFYydzFCT29XeitHd09XNEozVmdSa3BkMWo0eGVxRzBvVkx0UEJQWUwz?=
 =?utf-8?B?NlcvbHJrbk1XVytGMy9CQVFNalI5amlzcTBIUjh4Y1AwRDZmdlZ1T2Z2M3p6?=
 =?utf-8?B?NkNsRCtGUVR3eFpRZXFwTE4yb0VtSGpSRjIrT1JGZnRveHB0TG1qbExDTGFx?=
 =?utf-8?B?cm02SXV2VmlUMlkzNkFSaDUvT1E5SUVWbm03RHd4VFZsSXB0bEViZkxHV0xk?=
 =?utf-8?B?Rzc0TVpjcUFWRVdMaXpVbExkWEpTODhTbFpqTHh6YSsrYjM4R0g2dE9aQXpT?=
 =?utf-8?B?WDhRWDJHcmduNjBvaU1OdkdPcjBmRURnSlU0Q1YwY3JQUkNJcm9lT21HVTQy?=
 =?utf-8?B?U0Mwb3NvMXVaQThIRkdyRmhockVkMit3WGhHQkhkdlBWL2xPRm9YS2Y5d25M?=
 =?utf-8?B?K0I2dlVkVUd3c0NmVmpGYW5tOUJoZWtlT1ZYQjhFTW5hYlF4SGlTalVYKzlE?=
 =?utf-8?B?OE1NREdBaE5rcEhRVmxEaVhmYUxXSy96VWxPSjhtVXBLNzVwd2pCenFwSXgr?=
 =?utf-8?B?L0JjQ0JxUm9HMWV6UVRmQmZJN1Vac3h1QzE5TmtRWm1OWlAwSDduYlZwMllS?=
 =?utf-8?B?eXZMc0Y1a1JQY2pqS2VIa2gyNWFFV25GWTdXYmJHSHBJK0RuRTFZNjhiN1Zl?=
 =?utf-8?B?VmEzd3U1RWRXYUVLTUpOQnNsd0QyTkRVci9Nckwrek45NEpSbGtuUHp1ZFVv?=
 =?utf-8?B?d0toUlc0U0U2bnBYa1dGa09kc0E1WGRMNEcxU1haSlJWemxNQTl2L2JoeG1h?=
 =?utf-8?B?eU8zM3pzMVpVc2drdno3dTg2ZEI5RS9JQzNZNE1GYi9WQjRMcllzT25YTnRC?=
 =?utf-8?B?aHAwNzNUYzA2WVBEQ1E4R0J6eFUvVU9pMjYrb0tGR0hxeWZiYk4zYjMvY1pZ?=
 =?utf-8?B?dFJtMDBBSkZZZlBGRlY0STkvMVVNTUl4dzBoSDZRY0pWd2R0M2hQYnNxSURw?=
 =?utf-8?B?N1dPUVBZN0JjT3dMRFpTa3lPZXNFMUluZ0hpRHlCWVo4a1pseGhKMDlZUGFv?=
 =?utf-8?B?dDZQZ0ovd0dCTW1tQ3hpeEg4SFBxMWRBZFVPaFdnRWcwc0xrRllJNGdRT0JW?=
 =?utf-8?B?OGZaQUsyT2JiMUFPbU9GcnpPOGZ2bXU4Q0NQcjk5QlNTanp1OUZ4c2dMNVov?=
 =?utf-8?B?em9CUWFpb0FBRjgwM3dOdVMzSDRlVVJrVnRYZ3NZbzdhdFA2K05vSW5DSitJ?=
 =?utf-8?B?YTJSVzlySnhSdVlZYjFTbTBCMEZQbUUrNDc1TkQ0T2pTeE9QYXZVNHBYazM4?=
 =?utf-8?B?WnRrcm5sQ1lkZEx0a3crbEl3b2U5MTIyZWM2Z0hMNFRPY05VZjdhL1RQQ0VP?=
 =?utf-8?B?bWFZZWF0SEUwcDhXRUNKbDNQekdhKyszeS9aMUpYVFpIYk5VaEpBZC9Ja2dW?=
 =?utf-8?B?TDNTVFk1eXJ1VDZ1b083ZTZ6THkyZGtvVXVMZXVTcnlKRnh0bm8zRWh3Uzls?=
 =?utf-8?B?YTBJaEJNcGYvSitzZ21CRDZINDhNNmE5ZDBTdGZMK3lrTTVZQThzNDYwVktm?=
 =?utf-8?B?NW55MmplUnEyMWFhQWZ2QmJSY1llcSs5UnI3QXFyMkZxVG5hMjB5OWlDc3VJ?=
 =?utf-8?B?ZWo2ZWFjZXEzSWxJb1FsQ3pZV0dtb1B1amdjN0ZhbHczYmVZNlF1MjB4T2h2?=
 =?utf-8?B?Tm55bW9PTFd3WkN4ejl6a1hRdk5WaWhyZmtqQVFQTldReWJvMTdvcEoxV3Jn?=
 =?utf-8?B?ZjNiUkZ2dWFuWHN3dlhDR29UMUJWZ0o2VnVKM1p6SVNGMnRGRTNPdUdHVEIv?=
 =?utf-8?B?dEdVUTRXSjhOTS8vZVFIRHJpUkowOHcwWU5aRjlsZGtGTDVpL1I3akdNRndH?=
 =?utf-8?B?NUlTWVhtc1NveHhkN3hFOUQwZXBCZ1IwTE5qRk1UalVPMmU3czlNRWo1QXJl?=
 =?utf-8?B?VzZQMVNpRmVaLzBtWWkxRzdmcGl2UlFzdVEvWVNtNWRiekZ4Yit4QTU1c09E?=
 =?utf-8?Q?l6wfn6J2cPY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3EzbFhEUXU5UU1jaTFTNVNvazVMTXl0YjB3bzVYTVdGQ3pDSVFsYnEwbUNC?=
 =?utf-8?B?Tk1vMzV3SUcydEozdEVTL2lxd0pNVjMxRFM2VTUrRHJrTmhkL2FuNjkvdnJw?=
 =?utf-8?B?dW1UVlMvbC9VYi9GTzQxcCtSRXNoQThRQWVVTWlDeGpLYzJzUVlOWGZXajdk?=
 =?utf-8?B?Z2owNjFMdStuZTFTTmdxVHN0MWdBMmZSK1JDc281RzArQU55WEk3dVNOWlhk?=
 =?utf-8?B?dElNQjhNZm1DdUtwTW5oQ1pwaktqbk9ZdVZlN2ZyZW5Oa21QRlRDRG5CbWIy?=
 =?utf-8?B?ampNZFZ4WHpzUkc1UUVXUmsyWGhLdWNBSHZaUG9tUERHeUdLOVBqN3BmVytT?=
 =?utf-8?B?MDBmNHBvZ1VudlE3ZlpUbHJEM21JZTA0Q21OczE2UlNiVEZtcVU0b2tvVkpX?=
 =?utf-8?B?MnFQZ05rUjRtalhmWHlWZDBjZlZGUVlIVEVJaUs5eUNad0R0RFd5eTZ4M1FX?=
 =?utf-8?B?akQ0aEVoYkVRTGFpSmhzUVBuS2dZU2cxYnFTYm5sVWRGanJURUpSVm96b2dS?=
 =?utf-8?B?ZHBOdnRwZ3locUZrelAvNGNUZ0NpZHBqSDgyRDgwNGRESnhRemVaL3p3V1Fn?=
 =?utf-8?B?RVdFUzJPcGliQXdDL3hHRVBpZnBDSXl0QUgyTTQ2UFhNQ1VPdGlXZG12UjdI?=
 =?utf-8?B?c24vUGFxTUluL1pvSDBrck9RbkkxNU5XSDdaaGRGRDdoV1R6TjJ4R3MzckY3?=
 =?utf-8?B?Q2RUaW1FN3JMb3JJMnlUaW5GUFVlNlcwa2EwOWdYM1RCK3lCN3FLb3B2ZVZs?=
 =?utf-8?B?WUFMZlVncWNzSFMvR3loc0NXYXQ3WWNxVVNzanJERTN1MEZJa0QxSlBhWHI0?=
 =?utf-8?B?WlJycCsrYkVveCtNTENVZytlRzhUZ1hNU3g1bEh3UGVrWXhDeXZtcG9SYWVz?=
 =?utf-8?B?NjVycXl5bjBLN1JiQmxNaitJQlk0N0ZyVS9NaGZyZTh4WGdLVlZQSjA4Q1g1?=
 =?utf-8?B?RWppWVY3YVo0azkxaEkyZm05d29VSlNKcjlqYWErVWw4VjdvMlp6Mi9LOU5T?=
 =?utf-8?B?UWR3cEpoN0xBUGhuWEJoZmhCMGFja1VHc1B1dXR1U1lUcU1mZVdsZ0g5VEFs?=
 =?utf-8?B?ZmhXRUhraFgwU0xQazRCN3NIVmgza29kRzlwSXNXRVpoampJNEhxSVE3Vzdt?=
 =?utf-8?B?SmRubXFlNm1CSjh5aXRNVEhCeCt1SmwreW1wQUtmcldKREJJSTQvM3p4RWIx?=
 =?utf-8?B?MEgxaTZHc0RhMXIxRVFmY3Z5QjhiNXh4Q3ZQSWVVUjI5ZmRPa2dwZGpGTytu?=
 =?utf-8?B?c0VNbVZoU2pWTWIzcWNYRTdzU2ZFdk0vbWFDUlp0WHVxbWljN2pjc1pqSW01?=
 =?utf-8?B?NDNIWmU2MWxMa1FrR1dlYUMycWxRaXpFSXVhTDhCR0JDY1U5a1VKUU9rb0Fy?=
 =?utf-8?B?YVNXZFFMWmFjVm8zVTJBNThhU1ZDeW1ZM2Zwcks4T3dldm1wb3o0NlhvcGdP?=
 =?utf-8?B?QkF5WHhOR05nbjkwRGNMNGlzNUtqelBLSmVmU21OazN2aFRwMW9hVWFHTW5o?=
 =?utf-8?B?ZHl1T2VhREFHcDcwK0JHV09td3pPQVRsQXRBbm1yUVp3UFpxMHUvMlZJOWoz?=
 =?utf-8?B?a2VYd01pMlZlWkVVa0xNSlRHc1RXNUJoTTZkS0JidFh1U2Y1Mm9tU2ViOVV0?=
 =?utf-8?B?SW8rS1ZqdllZdHJjYWJlYUNTRFpsaUtKNlMvcmN3eCttalFZb24yRk5LMkQx?=
 =?utf-8?B?R3czMUFsRXRCeU5EWXhPZWs4eFVadWk0ZG5sZWpLakJTbDJ6c3VaM0w3VHZU?=
 =?utf-8?B?bncxMmMxRTFjTU1UM0JjV0llM01zdG9yUHkvWldrZ1BaT1VuWXBUNUxXWHJ6?=
 =?utf-8?B?M3dsdlp3Zk9IVXZwWmcxYnNJMWtmQlRVM1RDSEZ2SHNNMkt3U21sTFJoRnhK?=
 =?utf-8?B?QU94Q2RmOE5kdURla083U3VOVjRuVDN5ZlRhcm1kazRDclhTOWlHZVM4Zmhy?=
 =?utf-8?B?M1VLdnBRZDRleFRQaTVCZmo3Wi9oQ3plTnBYVHpObENsVEhCWTdzOCtIYVk5?=
 =?utf-8?B?eUdSMzRMNkRJdGV5Skl2YnRYN1pLRDY0SFR5alAvT0VlMStobm9hallXMnNY?=
 =?utf-8?B?ZkhNVU5TYmVoVDVkK2hGS0J2STM1S3B3RU04OHp6aGtYaFUyYmpEY3RiNzFG?=
 =?utf-8?B?MUtlZm1KaU8zSEpZY3Jid25SamxoOTBob0dySWJ3Sm9yS0QyOWVvK3FBZUND?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 866fcbec-362a-4fce-a79c-08dd8e0b3f4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:35:11.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgmVqmVvDIQuOYXsUIWTS3SIXx36Ok333LkSp0uGuiHRoX2+sSx++Gy+ZjnnzNhpxGDviHeRCpQ8wGM0HZPWb9RTu8d+HfoydSiwPnxz+3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
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

On 5/8/2025 9:27 AM, Bruce Richardson wrote:
> On Wed, May 07, 2025 at 04:22:10PM +0100, Anatoly Burakov wrote:
>> Remove custom number parser and use C standard library instead. In order to
>> keep compatibility with earlier versions of the parser, we have to take
>> into account a few quirks:
>>
>> - We do not consider "negative" numbers to be valid for anything other than
>>    base-10 numbers, whereas C standard library does. We work around that by
>>    forcing base-10 when parsing numbers we expect to be negative.
> 
> Is it likely to break much in the way of compatibility if we start allowing
> negative non-base-10 numbers? If it simplifies our code to allow it, I'd
> tend towards doing so unless there is a known case where it might cause
> problems.
> 
> /Bruce
> 

It wouldn't simplify much because we still need to use strtoll when 
parsing negative numbers, because strtoull doesn't do range checks on 
negative values. So it'll literally be a one line difference (use base 0 
- autodetect - instead of base 10 when calling strtoll), and fewer 
"invalid" tests. I can do that just for consistency sake but it's not 
going to be a huge difference in terms of code.

-- 
Thanks,
Anatoly
