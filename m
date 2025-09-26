Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85731CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4581040261;
	Fri, 26 Sep 2025 17:26:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D46BF4025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 17:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758900399; x=1790436399;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=eBRT4JcWkqFS5g60uKuoQ7Fj27BiPYZVmeI7J3Sh1Zg=;
 b=kxLlot1KRMyqLzQSTmHGYBZtE6RdF2zZeppNzITUVYTi253ViI3sGkGJ
 wCOqu3mU/xS2G9crUe1o8Tycxdh3dz/0B+Ep//UaEqgwl81LOOsdvYPiR
 TuAZV4ngWcQR9Hb5zHqAPU05D4pL5neq0LAJ4akSLlt8axR1UeYV5+5ec
 f2rEVMqFnUWIMGWI5qtCt+gR5/Ly80XZsswlmoT3di7IMysAr4RlrvCCC
 wciAwjHJEtjVzkh2txodO8coT+Lv7OuBcdrK9Ho43e6avjBu8lld/72/o
 +DDUSagASYky+oYS9xrLdVgLBJ93mYdujOaRZUXeBkkT3uZXt5vTmnl/6 A==;
X-CSE-ConnectionGUID: M3Rxe/pSRkWmO6w+zQH67w==
X-CSE-MsgGUID: rPSfeRPXSH6oB/Hzv2w0YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61284641"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="61284641"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 08:26:37 -0700
X-CSE-ConnectionGUID: OIlOEDO6Sg6Tjj2T/9nFKQ==
X-CSE-MsgGUID: Zp9BKeNETwOWfnx3Eo920w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="201333562"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 08:26:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:26:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 08:26:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0WpF1wpSsnwPi+Q9S4+oz5Jn4qaWUkWyUZIBSHFXdop4yKpM2XIlaBaa05CstVYGd5LhUBtmZROFyaFfiK3d54CW+pkancljEldTgMRCcdEBvMqPTMu+Z19sXRcxO4/kdolLPx7XQkQZNUEBgCua3WnlM/MGxXoyqZ3w5eiNXdJNrMiH5JuOu0GYYnSns9HvdexZfZc7Uc/OeIQWLQwCxIJju6u5DVs8XXi72y/lzHU7BjFbx3gqiL+tV9COY7W54Vi5lzxxRv1r3P2t2cV50mwidwCbqnezq1h3BwM3JFzwcNSnafbocuNI0nZcy6JAVFpxQvUFyrbjfWKCTCsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjsFcW5mKbO4mSQDs6yfdA/T/Qlvd9U+kjDUVmJ7HRY=;
 b=R9HFs+/dKuIn/ja8WZARJUgqI681szkLp0oQypictdU4HgC8n+vraptmmmw7Or7fLI9nUtl5bX49AHh3B8LTGAaEB82vC2Le3HiiUF2n7pWFgeHuI1EbXzy+8DvgCGMn9RLqTMBffawqmSTor/092uUDflL82hdHz6OA9/rHJ5kmYZF5BwXYZhT88gHD/sqoiWS325KE2wVVcqkvIv0mCJNeOOJUK9sAVSEKASn/h5zjST2nHKZQY0KY+eAE0S6Fsc7ZTn1J+0eN6cFpf6ofdHNqQbdN+3BeZhkvLzy5120wLOp/G8BvfRSSIq1IU/BffZciqM+1a6Aeo1AxooDVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 15:26:31 +0000
Received: from IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b]) by IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:26:31 +0000
Message-ID: <5df3bbc1-6934-422d-bced-8d3a1191faf8@intel.com>
Date: Fri, 26 Sep 2025 20:56:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/intel: add IDPF PCI class ID support
To: Vemula Venkatesh <venkatesh.vemula@intel.com>, <dev@dpdk.org>,
 <shaiq.wani@intel.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>
References: <20250924125749.83507-1-venkatesh.vemula@intel.com>
 <20250925174707.131821-1-venkatesh.vemula@intel.com>
Content-Language: en-US
From: "Singh, Aman Deep" <aman.deep.singh@intel.com>
In-Reply-To: <20250925174707.131821-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::15) To IA1PR11MB6074.namprd11.prod.outlook.com
 (2603:10b6:208:3d6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6074:EE_|IA0PR11MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c557ec5-94d1-4112-3c7f-08ddfd1111c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZFMFBkNmxNVXZuTXRzUTdRNENoTVZqc0lKNnF0N2xiRnQza1BLNTBLMjNU?=
 =?utf-8?B?L1o5c1hHTkNrb3FmNys2NXp3VktVTWNZYVFybHczRDUvVk1qZEpwcFVrR0hY?=
 =?utf-8?B?c3h2NXJXNGVtNzZ6Q1JoeXp0cWlPTlRrUmRib203K2QzZExpODZWTnliaWM5?=
 =?utf-8?B?RFBSWU9EbHNSMkVINWJmd1Q3NGovVlRtKzZEdUhqUFNkVTFJVXhFTFVlMFZH?=
 =?utf-8?B?V1FWV1NwSVB6emlwcm9hbTB6TmU3VXRSNDI2Z1RWT0oyVWFGdlZUWncvcGJX?=
 =?utf-8?B?eldvT0Faalcwa2NwcDJaYWh1RFhneUdGVUptc21Jck1sZ0VLbzFhYTBWcUQw?=
 =?utf-8?B?QXNtcFpEaHM1Yi9OSHRqVUsrazNJcWtyWFV6NjdWTHhNbzFlcDZkbXc1b1A2?=
 =?utf-8?B?R3JRZDB3WktXQkpRSVhiUWhxSTJHU2h5bjMzclFjWU9kUGMxTi90dE40Mk1j?=
 =?utf-8?B?VVhkN2RNRHlqbVhUL1JmOXZrdm1ZRDZBNFg2U1BKenJRZnhuMzdCK2NzRm40?=
 =?utf-8?B?bDRFZTVIYi9WR0kzRjlEWVBkU29DS21vc0Y5OFZVdjVRYWpOY0pmMGdQZDVI?=
 =?utf-8?B?ajROaW9NM0tvK0RvRWgxZUJKckpsSzIrK3R1cURIUHFpSlJ2ZGtZWlFydGIx?=
 =?utf-8?B?djltUDl3NmtJdVVpQXoxa3J5SU1MNXJXWXJ0Nk9TL3pra0dtNHBUaXFzbzVa?=
 =?utf-8?B?WGxmK0NPOTRVTnRJMDkwMkZEM0dNMnZ2akN5MnIzQmVNMlZLQmVvV1M4Q0Y0?=
 =?utf-8?B?OXU1cnQxT1hBRTY2bkRFM1F4UWg3emxSWkJ6L3hPWVRNcVdoSTBCQjhkUS8v?=
 =?utf-8?B?eTZ3QzNyM3hobVNiK2xpMmVTem50ZytzSFB1WDBhYlpYUVFmVE5FbFdXSjd4?=
 =?utf-8?B?eE10YXdHd1NKZTYyWmZUeTNWUUU3TEFJMENCWTNOdWhLVXdNMVh3ejVWNU1l?=
 =?utf-8?B?a0FGUnV1dDd2L0RNQ3AybDU2SU1SamZyS0NKWm95UFd4d0JJTXA3Z2x4U3Bu?=
 =?utf-8?B?Qy9nMThoUFpZNE5GWnA1dHRBT3hBNFNiS2FDZWN4Zm5mM0pCZnNkd1kzVjl1?=
 =?utf-8?B?M0F2c05FeEVhWUMvWnM4d2lJaThDSzJIVUd3UUs3Ym9sWFZ1NXJVZE5zNGcx?=
 =?utf-8?B?YUlDYlVmdk5hcDFNVlNJQ2kwbk95N21FWmQ1cXluQng3MjRvbkptRXhGd3cr?=
 =?utf-8?B?eW9FUlBya1Rlc291eCtnajMwS0ZmNmRQSUpvT3dKTzhCc0podHhkbDJUZEVZ?=
 =?utf-8?B?dUk3S0hTVDRtZlY2bFFIL2dIa21IUXRVcExRdHRGYVJFTWhCMUx0bFZGbzFm?=
 =?utf-8?B?aVNOOUxvZlNBVW14NTJ5WkxUTHQwSnd1MDhmZXIwRjlWeHhGWXhzNUd4TEpK?=
 =?utf-8?B?NFRscEVycExDbVlxRGxZbUY4eVdzQTB3YStLaUY4RFlwMmhsTVdIMUN3cndG?=
 =?utf-8?B?MFpoVWl3QUFQTmxZYkh0Z0tIL2Z1YVBIS254Qk5XYmkxNlNWbTN3SXZnWGxM?=
 =?utf-8?B?TU5rd0t6QnBlSmwzbUl4M3dlZHhTTFh0aWF5VEdLMWFlMG8ra1JsUVNkcEZo?=
 =?utf-8?B?V3ZsK0VqK0diUWFGcnFOMktUTlNpZ05ZRXl6RmxoWmVGWGd2RjdicFdGYzJW?=
 =?utf-8?B?MmZ6a25iT05oMk83OWtSY2pqaGR6aUszWG1XUUQyVk8xeXJXazRRNjcrZlk4?=
 =?utf-8?B?ZnRsV3NScStzaUx2dXQwQi82bmJHcWdjcUdPbnJCZXVuQTZpMEg1cTFSdXY5?=
 =?utf-8?B?OC9xM1lzVG1wdHNBOHl4bjVXMUdIaE9pRERkUlB4ZmEwVUVOYXI4d1lCcngx?=
 =?utf-8?B?N1hhd2xZMEx4ZGdNbzlQM0lLZWVxWENQUGY0R3k5TGE4NGxmTkQ3aUhyUzR5?=
 =?utf-8?B?M0h5WWdZWlF1YXh6YS80V2E2SEhtVmpVdktscnFPWk56RVBrR3RxSHZLZDNG?=
 =?utf-8?Q?OxhYyLXeGA6VKXa9n5vwvABECA2g316D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6074.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVGSjIremsxdFRtWE90SW15TGhQL2IrYXFnNHVGUnVZeU11cndNK0c2OHZw?=
 =?utf-8?B?V3c4aUFHWWtDaS9WT2FZTU4xRDBWTTZMN3A5WmJDUEhoSDFITFpSNldpUndO?=
 =?utf-8?B?NEpGbVRFSTdYcnk5ajJLaWRIRy9RRjBjdld5SEI4bjBpNHh4eU9xV2p1dlQ0?=
 =?utf-8?B?MU5FQVFoZWU3ZFE2Wk9yZ2E5bGo2TnJteTFOdmxOUnhvaE41MEx6aW44QjRT?=
 =?utf-8?B?T09ZUkp5RHVpMUhLazZEcjBiQWxPWW9MTXJrUmlrc1J1MG1CWnZmaEtRY2hz?=
 =?utf-8?B?YTRDYUR2bzVjZ05sazZKbmdFQUFpWk1TbGZ2OCtDcFFFWGRxNW1NdEtBOGxl?=
 =?utf-8?B?R09OazhocitPcWZha2wwTjdWOHhKeU8zemkzZWFhVWRLMU1Yc0kxcGs2bG4v?=
 =?utf-8?B?WWZVTVczM1c5ei9GWGxVNVlRcW95akpScFlRaVhzRDZVNkQrZnFjQ2tiUE1u?=
 =?utf-8?B?bWtsSDAySHhNQlh3RGxDdHB2QVhXRG82WGkxZmpPWVoyd0xCOHlaR2RrWFRH?=
 =?utf-8?B?clllc0RRa0E3Uks3TnRqM2xVazZKQU1GNWNsNVkzN2NzSlMxOU54VVpjem9B?=
 =?utf-8?B?dG1xcU92SURZdGR6WDJrOCtpQkpkbDVJcGY4b01jVmN4WmFXZGVoYUpKWXFn?=
 =?utf-8?B?M213RFZnUGFYRGNzeE5KSG4xVS9PTkM0anVMd1FkWlhXc2JlWkF0MXM2ampB?=
 =?utf-8?B?RXE2SmUxU3NHZmc0amdod0dYc1ZSR2M3YzIvQWxkcmpoREZyNDJZeFlzZjJU?=
 =?utf-8?B?ekpVRGd0UndreWdadmR1VnR4Tzc5Y2ZsQmRYV0d5MVpWcXhRVkMwTCtobmow?=
 =?utf-8?B?WDBjdG9tbC83dit1S1NaZTFRUjQ5Z1pLVjVzUGMrcnFYSHdzb0krTFRiUnJx?=
 =?utf-8?B?eURzYXROc3VNRXBkTXdFclNQNituYnN6eEE2aFBMYkpMV1Zpd3F6VmJoMW1a?=
 =?utf-8?B?M3NxcTVSR0FpZEo3d3pZM1NXekJ6NnFjbGZKOG5lL3JzbUhrQlZFVFgwWWJK?=
 =?utf-8?B?V2FDb3poWW51eTNiSEVySkVYVmZHam1rSDg2ekNLR1JGRmNDekw2Z3hGR1dK?=
 =?utf-8?B?REVnZmpSSTN6dmVxSk94RmhQcVFncVA1V2J2TW9keEFEd3VSOGRpbGxtbUo2?=
 =?utf-8?B?bkxtLzd5NkJ2ZkJUK3lPZngzblZqZUtRcGtpQUVyaFROV2x0djM5OElMQlVC?=
 =?utf-8?B?dGtkM2dlWlpaNjJZT2hZUjZYQ2h3dURXLzFQMW9RVE11SVJIejV1a3lkeHZR?=
 =?utf-8?B?bGxSUTI2OU1pNzZvVGliZmlsa0xLbHBLbGNCbHZVOHE5ZStDZnV3eEVtdmtv?=
 =?utf-8?B?K2h3TnprMnhURk1aMVBGdGpqT0Z6NWF2N1RtNjR5eGZyTWFETy8wSXo1WEhO?=
 =?utf-8?B?OTVNbFAwaUIwaDBiWWFrUDVHZEZGTzZTbkVkckZvVUdzdkhNUTJWcW5HbmRv?=
 =?utf-8?B?cEtMZ3NRSTkxNVd2RnYyeGZkTElFMmJtVnN3V2lIeVhrSkdRczdtU3VJQTlv?=
 =?utf-8?B?OW15YXBmdHlQeGptaHM0NXdyTS9qZlNSSnFma2VXZVRlNm5nL1d4MHhCRGJt?=
 =?utf-8?B?YlVWRTUvdkpHcDFMcEpQbnJCeUNSN3NOckVJMG1EeXBSRVRDWlFmb25yVWl4?=
 =?utf-8?B?MWJ2L29Ka3JjYWRxMThoMnRuUFZYTW5iajdFVVJsSjRjL1QvaElsdGRpVXc0?=
 =?utf-8?B?MlJsRnlpZ1lVcHRaemY1RExUQURKSDJvbzFHdWU4R1RVVmRZenczc0RCUlFt?=
 =?utf-8?B?NlU3S3YveVByWkRtYUl4N2R1dXduZElPZEZkcG5BV0Ezb21ndGUvUVl4bm5D?=
 =?utf-8?B?K1gwZDd4NEprU01ScFYvWkNMcWZpOFFSUTQvM2V1RUxhUjdHUTZ5TWt0Z3g1?=
 =?utf-8?B?UWxyZ2RPa3ZXOXpBTHJxSTE4dzBIZVZoQk9FSUdtMkdvelE0WW1pUEJ3NHVH?=
 =?utf-8?B?WlJRMk9lMG03dXErVFlwRElyam4rTW40SWRUdzRJTzBDb3g3ZHlxWEtudHhT?=
 =?utf-8?B?Y3ArQTJTVHZGUUlFS2QrK3FuREZEYVp2bzRTekNJUlBTSEI0Qm1tS0pvRWRr?=
 =?utf-8?B?WDVmeW9rYXNqS3ZFNmxESjZrMTBXdmI2bjVBRExTdFR0R0NkSkVaMUdYN0Ns?=
 =?utf-8?B?TUVEOFM3K0k2bkV2QTB0aW1USEpJTHRqQmY1eWg1WFRyQlNIZm44bjRzTlpD?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c557ec5-94d1-4112-3c7f-08ddfd1111c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:26:31.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HeGdlfdeXRcqhaU1oRHWEzucWjGViXREZsSxNvW1udhFt/F+qCdYYPs7uBlWsGt5cvkd6Cy99xhg5C7TuInJPGNxdf+3BXXFxEmRSNSsWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
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


On 25-09-2025 23:17, Vemula Venkatesh wrote:
> Current IDPF supports only the MEV device IDs. MMG has new set of
> device IDs and same might be the case for the future devices. Instead
> of adding new device IDs every time, make use of the IDPF PCI class
> ID(0x20001) to differentiate between PF and VF.
>
> Write and read the VF_ARQBAL register to find if the current device is
> a PF or a VF.
>
> v3: addressed reviewers comments.
>
> Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
> ---
>   drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 ++-
>   drivers/net/intel/cpfl/cpfl_ethdev.h          |  3 ++-
>   .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
>   drivers/net/intel/idpf/idpf_common_device.c   | 20 +++++++++++++++++--
>   drivers/net/intel/idpf/idpf_common_device.h   | 20 +++++++++++++++++++
>   drivers/net/intel/idpf/idpf_ethdev.c          |  2 ++
>   6 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 6d7b23ad7a..8cec977ecf 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -2606,7 +2606,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
>   }
>   
>   static const struct rte_pci_id pci_id_cpfl_map[] = {
> -	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_CPF) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MEV) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MMG) },
>   	{ .vendor_id = 0, /* sentinel */ },
>   };
>   
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d4e1176ab1..566b395dae 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -59,7 +59,8 @@
>   #define CPFL_ALARM_INTERVAL	50000 /* us */
>   
>   /* Device IDs */
> -#define IDPF_DEV_ID_CPF			0x1453
> +#define CPFL_DEV_ID_MMG			0x11E0
> +#define CPFL_DEV_ID_MEV			0x1453
>   #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
>   
>   #define CPFL_HOST_ID_NUM	2
> diff --git a/drivers/net/intel/idpf/base/idpf_controlq_api.h b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> index 8a90258099..bcea789ae9 100644
> --- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
> +++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> @@ -179,6 +179,7 @@ struct idpf_hw {
>   	struct idpf_hw_func_caps func_caps;
>   
>   	/* pci info */
> +	uint32_t cls_id;
>   	u16 device_id;
>   	u16 vendor_id;
>   	u16 subsystem_device_id;
> diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..357a2c692e 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
>   	struct idpf_ctlq_info *ctlq;
>   	int ret = 0;
>   
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV)
> +	if (idpf_is_vf_device(hw))
>   		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
>   	else
>   		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
> @@ -389,7 +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>   	struct idpf_hw *hw = &adapter->hw;
>   	int ret;
>   
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
> +	if (idpf_is_vf_device(hw)){
>   		ret = idpf_check_vf_reset_done(hw);
>   	} else {
>   		idpf_reset_pf(hw);
> @@ -443,6 +443,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>   	return ret;
>   }
>   
> +#define IDPF_VF_TEST_VAL		0xFEED0000
> +
> +/**
> + * idpf_is_vf_device - Helper to find if it is a VF/PF device
> + * @hw: idpf_hw struct
> + *
> + * Return: 1 for VF device, 0 for PF device.
> + */
> +bool idpf_is_vf_device(struct idpf_hw *hw)
> +{
> +	if (hw->device_id == IDPF_DEV_ID_SRIOV)
> +		return 1;
> +	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
> +	return IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL;
> +}
> +
>   RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
>   int
>   idpf_adapter_deinit(struct idpf_adapter *adapter)
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..f6154862da 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,26 @@
>   	(sizeof(struct virtchnl2_ptype) +				\
>   	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
>   
> +/** Macro used to help building up tables of device IDs with PCI class */
> +#define IDPF_PCI_CLASS(cls)          \
> +	.class_id = (cls),      \
> +	.vendor_id = RTE_PCI_ANY_ID,  \
> +	.device_id = RTE_PCI_ANY_ID,  \
> +	.subsystem_vendor_id = RTE_PCI_ANY_ID, \
> +	.subsystem_device_id = RTE_PCI_ANY_ID
> +
> +
> +/* PCI Class network ethernet */
> +#define PCI_BASE_CLASS_NETWORK_ETHERNET 0x02
> +#define PCI_SUB_BASE_CLASS_NETWORK_ETHERNET 0x00
> +
> +#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
> +(PCI_BASE_CLASS_NETWORK_ETHERNET << 16 | PCI_SUB_BASE_CLASS_NETWORK_ETHERNET << 8 |  \
> +IDPF_NETWORK_ETHERNET_PROGIF )
> +
> +bool idpf_is_vf_device(struct idpf_hw *hw);
> +
>   struct idpf_adapter {
>   	struct idpf_hw hw;
>   	struct virtchnl2_version_info virtchnl_version;
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index 90720909bf..80bf53db0f 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1201,6 +1201,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *a
>   	hw->vendor_id = pci_dev->id.vendor_id;
>   	hw->device_id = pci_dev->id.device_id;
>   	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
> +	hw->cls_id = pci_dev->id.class_id;
I think we don't need this variable "cls_id".
It's not getting checked anywhere
>   
>   	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
>   
> @@ -1313,6 +1314,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
>   static const struct rte_pci_id pci_id_idpf_map[] = {
>   	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
>   	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
> +	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
>   	{ .vendor_id = 0, /* sentinel */ },
>   };
>   
Regards
Aman
