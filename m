Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF66CFC269
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C360402A6;
	Fri, 21 Nov 2025 13:07:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EAD014026F;
 Fri, 21 Nov 2025 13:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763726826; x=1795262826;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DzNeCN6AV0AmmjoWBcgc3D3dEnkkwYX0gHXYFx1qi8o=;
 b=BclQrSOlW1DE+heiPDouW1/VuPldiHYwld5GHBqvxCpvy0rR9CW9d31v
 L+Lcr1/lwtFv4RM3BhDXaNpo17tcBMTliapWezDWzU8b8Q2IFATmCa3Uw
 YM7v3a7Ujn3qNSSDvp1O81BZPJDL5hC4MUT74ZjnIFMZWzm99N8kEfwy1
 8XPHbDe5J3WOtQ47ZpziUeQBcvAKvbGUurkPHP3ZmF3pgOGc24F17VLfL
 wuPhfsLZZ6Tmzj0izeMTK0aUuyf58UlAQbmoAOQj/qWMDCPL1T6NOI/O0
 VeSv2kZHfEVYDJWOcrZt/TpuvicUb/YUL4ThdXPxCAZ9/HLbvQcdbLNHk Q==;
X-CSE-ConnectionGUID: eRFR93aJT1iSYTwNyALLlQ==
X-CSE-MsgGUID: bt/27d21QhCB0JPYyVme5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65006354"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="65006354"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:07:05 -0800
X-CSE-ConnectionGUID: c++NBhjeQt2BXWYk7Ojt5w==
X-CSE-MsgGUID: 7x/ht/i6RH+ZIsAja+kRTw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:07:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:07:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 04:07:04 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:07:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2JE0lHItJ5825CLx6MUb+skRHaVC16ttrIBmPXwbuOuyFZ+VCBCvmELOLoZMTSfkAJanxHo4nPW4x/MHVljXSQNuiZ1h2D/j9xlmtQnf8DewtFxdJm4UxJ5cmujsSGfXjEsaoG2oi4W+tdktLQatx7BjTVmuebRBh4zMfYdRZ7tGxDmRqLNVXmXXPcYiNnbCqi5M8V7BJJlvKrfbyxFamOVwcHh2FBHuMnMSlfxxXX89x82LK4gUn9TuqMeqbRZWdJEPFiRocLlM6v6VyNC0dRNZcSgqsjlVX+/eAQg5OoWD9glUYQeTm+JbIwJcswxBMjdgwEqd1EMCG38XsBPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UA3DN/uQtNNy8hKe97GzlPbF2vCTRlXlcjlUQsi1q8=;
 b=PXZTwUUZ/vFrrkJ/pvux+wbTuYoOBHk4NVi1p+hkJqcAY/SBg/Pb7KkT6XV8P//vm1ZujzYq7ra9Qck1ehMfEpki4QwHuNcL6kLIxrkxicu2I/O24uGmJ79iDLoeNvq92/Rftr80+QL645BWd4xOJ713sfzuJ2WH1/GQya8yQ54KDewK4AP77IWn2eAciRa4A9NPLF6WJ1i7Lw9SyNWFF7uCYYnZXAfCl4GBMpKbg99BC4AYN+30CxF6MWnTJdQ1g4HDuw8aExZWNY4WtnTQARbNBsw/5EoeLG9R+zDpyCRD/hovk7yA1+R98OJYOAtACFPi/V3MjK6mlnD5fAk/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.14; Fri, 21 Nov 2025 12:07:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:07:02 +0000
Message-ID: <7a81b8f7-f147-4c9f-97ed-ce475a9934c9@intel.com>
Date: Fri, 21 Nov 2025 13:06:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] test: fix format overflow warning in ACL test
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, <cristian.dumitrescu@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
 <20251120165713.120238-6-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251120165713.120238-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: adb715b7-a65f-416e-ab80-08de28f67ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1VQUmJQMStNeVRQaTR3cGpqTk1rSXo2bGc5eHRRWG5NVkNFUkJWMnZUYU82?=
 =?utf-8?B?akkzRElRMWNmUnBOdFRnem5GYURvUG1GOHltNlcxQzVBNGYvRC9yditIdy8r?=
 =?utf-8?B?bk5wb0pzQ1RoaUFmdzNBRjkwVWFFM0lSeWtFYjFIN0gxaDZkUlFYRmhoZVZH?=
 =?utf-8?B?RW1MUFZ3YmQxbFU1bklEb2xUd3RCRnVjUkVoQ01uSDVwbERick93eUJscDhL?=
 =?utf-8?B?OGs0THEyY294SnpMWWRha2k0SkVGdzZCcTdXdmI1Sy8xY01ib3BYTGhNWDZQ?=
 =?utf-8?B?WU5YK3lTcHQyV25aTDYwSENiN21TOVRxbzc4amEyQXpqK2hnTXAzeTVrWXo5?=
 =?utf-8?B?WkR1eVFTQzk1MFZUZlFudnNYM1daeWtrNUhXSUZaWlVOR0UzL1BBOVVGaEM2?=
 =?utf-8?B?WCtvY0liVVdJVFg5djZTZ0RmbklkSzd6aEkwR1B4dEZCaitRakFjZVk4VlVK?=
 =?utf-8?B?OEFmRGdXZ3pvZERsMjRxeUY2QnNPOE1oZFFaMUI5MDI0ZzVkWW85Z0tIOGZ1?=
 =?utf-8?B?UXlubEh2Z0tFYkoxVlZBT2FPd1c3Z3JVQ1pXS29xa1FHMWtsZTUrY1E1ZGJI?=
 =?utf-8?B?UVRGVHNmcWJjak9uNEtCRWJpT0JkNE9mTU56UVJhSWM1ejJrM3B1UnBnU2VB?=
 =?utf-8?B?VFVHaGVDeW1uVVo2dEN5U2k3cHhabGFGOUFaek9DcVBZT3QwVWUxcTl6NmNW?=
 =?utf-8?B?VitrdmlpMlYrbzY3OEtudEFMWkxlODVndkJkQ0F5THM3YUh1MzdqTFI5aHB2?=
 =?utf-8?B?VEZjTGRhL0N2SnFaalRMOFdhWXAwN2hKMU9IakYvV1AzYjVTUHpieHUxSktx?=
 =?utf-8?B?Y1o5YVU0TTQ3SElCZmFMeEcxUTBKb01NRVk4aTRja0lOSm5KZmp4NEtrSmpW?=
 =?utf-8?B?NjNBZ2c4RSt0YXYvOGpIS0VXZjFqZzdUdmxVaXdqaEdRN2poUkROb2dveHBU?=
 =?utf-8?B?OSs2OTJndFFudU1xamtXVEFOYjBVaGJCMXRMRm9LMEovVmVYV1JRd3hiRk5I?=
 =?utf-8?B?elZ5L0cyNHlHWHJvTVdZSHY5Yzl4c3BtOGlwTVJzK2NPRXZlQ2hMVVdtS3Rq?=
 =?utf-8?B?QTFJek80NlVYZU4wMXBLR24rN0QybjBhVjlOQnJaRkhyenEwbXZqelhEMGN6?=
 =?utf-8?B?R2hiaERlSzdHVldYTVk2RTZGWlFUZ3BwMkhEME9PdzVMbjdWeWhCQXBKZm5z?=
 =?utf-8?B?YVpaMjlCWldxNUJFSWNDMWJwSTV1dEtHQVJHZVdVbWYza1VvSEgrZXhpZ3dV?=
 =?utf-8?B?ejhjNGxuUEVackZ5NTVpUStYaFpVeG1CWjNUWEZCVVdmQm9DMmZZeWRqUnla?=
 =?utf-8?B?a3hXYWdKOWF0UFlPSC8xalJ6cnVEUWFmbjhBNTlJOVhRTUNpK283c3M3S0RR?=
 =?utf-8?B?a21SNWt6Nm1HQTYyK0c0eDUvdGxVNzFSRFRSN2lhbkZHdGNKVTNIVkdWYUww?=
 =?utf-8?B?Rmd2eml0TG5KbEVIRFNUWGFSaUxZLzVWbXZzMVJZaGswUEVrYmxkWGtrcUd3?=
 =?utf-8?B?VVJXWHBIL3NabDRBSFF2cHFXcFhuTlYyeXJYbVoyY3VoU0RGcmRub25WKzNJ?=
 =?utf-8?B?a2k2eTZJb0x3amtvMUtGN2p3aVhtY0RoeVpad0l4eXVsdWdPei9pVU9MT3Bw?=
 =?utf-8?B?eHBpNjBpQm5RNC9XdldhcFM1Yzg4RWVoWVdRcG1FTVplekQ2aU9OaktMRXRV?=
 =?utf-8?B?aXJiZjZiNyt4YzZ5U044cXFGRVBMUldlaUpwaDZKOVdZekZscDBHYmdoYUhm?=
 =?utf-8?B?TzIyMks1N2ZnV3ZwNjVXM1lkazROWGhmSzBadEpWL3BQSUJnV20rc0FUdWdP?=
 =?utf-8?B?ZSsrZDVhelNITXpUTjYvZGN6RlNpWVd2dUVTd3FuZDBTL3RzU3FWWEFsRFl4?=
 =?utf-8?B?dTMvS0RCL1g2Tm9WWTVlT2V2dklHYVJVWVhwTTY1bTA4RXF1K1Rzc1hoeXlu?=
 =?utf-8?Q?7yerDI+tkJNM0eHdr/H708JiY6DFSstH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0R6czBmS1hOT3o2UFpEelA1UkZkaFBXaDNmcG02U1cvVVJoNU9BRC8raGVu?=
 =?utf-8?B?bnQyRVh4N2RRZUJ2eldLNG1OeEI4L0R0WHBtV2dVMjJGazAxV05SWkNMK3A1?=
 =?utf-8?B?bXQrOHpUaHMxMmNPdXpBQzVWWGdkaTFLREU2TGdJZlJhTHV3bE56OTBYcVRJ?=
 =?utf-8?B?cGtCS3cwOGlxeUIwMnV4VXM4UEdZcjVhRDE2UTl1cFZGNjJ5N21sRS9OWita?=
 =?utf-8?B?YXhGQ29IRDRQRDk3UFNIV3J5ZjJtVlhvNDkvaFlocUZRTlVEcjFUWnJPM0hQ?=
 =?utf-8?B?MGUvY1FxTWIzWi9VcXRUQzNEeGJCRUJjQU5BSTFUaCsyWnhpWnl3K013NUVJ?=
 =?utf-8?B?NWYwcnB2OE9RRzdEZitZeitOSnhtVkN4R2N6K2RJaUlvajRnTUV4eXFUcVho?=
 =?utf-8?B?VWgva2FNTHJsS1hLQ2lteUIwVmNQQ09YS2lidFppWkFjY1AzSnRUc2Z5MEkv?=
 =?utf-8?B?cXFrTks5UjVucmIxbUZhNzRzeHJKb2tJYmd2emYxR210SmVvRjM3dkoxS2hz?=
 =?utf-8?B?RVZHamgvZzlpanhvdVdQUWVnejhHa3p5MGlJWkRTY0NVWmNudzFoWXdHMFBB?=
 =?utf-8?B?bk9CY0tHb244dVIvb2RZdjY4SlN2aHJEbmNDWm5ycGlROXFSM004MXdWdW94?=
 =?utf-8?B?RkhHdjVSV1JVT0JHVEczdmx2b1E3YkEvZ2MrMFdJUWhyYUVrRkQrLzF6Nk5m?=
 =?utf-8?B?aUZLalRsNTVPZmZRMnlLNW9zODg0VWU1aDhuL2lZRG9EblpBcXkzd3Q0a2tB?=
 =?utf-8?B?R3FSSUNwY0lVbEp4cEJ6Sk1aSFN0Z0w0UU1CdkdKSlRNY2dBdS9MQndla3Zw?=
 =?utf-8?B?RnplNVFqTEMvU1NnUkp1ZENSTFZ2dm8rc3dSdVI3TW1OZ0gyTXYycDJHM1Fn?=
 =?utf-8?B?cGc3b1Z0NDBLS05vbk55dlNZMEpDcVZvam9ZYVZJQlpaYjhlRnhWZWVSS0lN?=
 =?utf-8?B?Vnl3azQwYXJGdlBIYTgrWjFVNDFWOVJlbjBleEl0dXFMdjRSRCt5ekdtMHRD?=
 =?utf-8?B?OWV6Ky9Ldm5aQ1IvRUR4Ly9wY2szdUJEYXI0S2xjWHBVVXAzbDMyaHgyLzJR?=
 =?utf-8?B?blpPZ29GbFZNbHorcHMybHV5eCs4Mk0zR3BRaDNYR0JwRzZxTllEMVh6Tk1h?=
 =?utf-8?B?VVFlUTlIWld2Skw4OVBveHlmQnB2YzBEZnBBRm15YTJFR2ZrWWN3emJvU0hr?=
 =?utf-8?B?ZHRqUk12dUlRWmh3ZjJKTHZYbmlLR3F5eTl5YU8vWkNGMGc3TUFTS3dUbVZu?=
 =?utf-8?B?VHZ1RzZFaVNBL1hER1oyclpxa3RjNk9JUDNuelM4aEZ6YW42bUhvWWYwU01J?=
 =?utf-8?B?SDdjT1Q4NmF0TWNoVy9yK1FuZG9pWEVkWGQ3RjJvblRqR25qSTk5NVgxTjJ3?=
 =?utf-8?B?WlNrN1R0aUZoVGRhU280QTFoSTZrdUR0V1BTV0xUMEoyNWMwMk1UbWF4LzQ2?=
 =?utf-8?B?bVM2WFovVUV1dE9BZ1AzOTQ2Y0RCQTNPWWlORjZ0RWY4LzJjRml2L3hMOTBS?=
 =?utf-8?B?V2xaUnE5eUNRQ1doMGtzbzc0TWFEeEhXS1pNUmhLbDY5UUV0TlZJVjkwZ05O?=
 =?utf-8?B?NXZ6NWRjd3NyL2g5MXVwR0tPRk1YV3FESHV0NUQzS0VIc25xZmpvZlA3dFBy?=
 =?utf-8?B?MC9QdFlEMWZPNEFNdVNVWDg3WElSV1JBTXdvNXg4VU9oTHgxZ216MFp6eXdx?=
 =?utf-8?B?QzZ0UGhMRldwOFFKZGhML0E1MDdhWlJocERyRkk2VFlXSGpVOXBnQkJSUWoz?=
 =?utf-8?B?NE1TU0xIOHhseXVLRnVTSzAzVVJNZWtBdkRsVnRnOTU1bVE3dlJDc2J3ajd3?=
 =?utf-8?B?cmEzOGhSZWtaVWFIc2hQNWg0NnFMN05lRkpjeU9ZdllPd2hQdVdMUmwyRG5q?=
 =?utf-8?B?S1g5WVZud1RTMzZOWHdCaS9Vb0VwYXNnNCtsMmZST25PZ2VsNzhHenhrcXc5?=
 =?utf-8?B?K1BoSUJHL1hrQnZ5UWUyTW5jUDB6ejhxd3I0UndxblAwNGFST1MvcnZSU29U?=
 =?utf-8?B?UUx0Qkl5QUpFaEpYUkJnc1I3cUUwaGNsS2xWc3ZONWV6QUQzOGZHVDZWdnpV?=
 =?utf-8?B?cHBFS1U3aDVBWWl6ZzVmNzFZMFBMMHFjZGZlRlAzbVBLM3BYREJSNzZnTG5Z?=
 =?utf-8?B?Ni9VSE5Xbis4WFNId1owVFJvNUsrbFRQam5kOTNIbTV2ckZpV0ZSL3Z4cFh4?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adb715b7-a65f-416e-ab80-08de28f67ae2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:07:02.4660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnvPCIrl8bcDddmfRrmn4vpjfIbIKzBnC2EgL3HH561vmit2NgDwBEnEi+UqAZrw7tOwfcPmuuvegt8xYO21LbqFVzoySOWo84J3jfbrNkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
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

On 11/20/2025 5:55 PM, Stephen Hemminger wrote:
> This test has an array of input lines, but the two dimensional
> array confuses compiler length checks. Convert to an array
> of pointers to fixed strings which avoids the problem.
> Make both variables static since not shared with other code.
> 
> Fixes: 5205954791cb ("app/test: packet framework unit tests")
> Cc: stable@dpdk.org
> Cc: cristian.dumitrescu@intel.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
