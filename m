Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB7C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1A454028B;
	Wed, 19 Feb 2025 11:21:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D1C514025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739960512; x=1771496512;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fcmymPOPVEiWPe3J1I3oC5UuSWWp81QoSiBNGMB34oQ=;
 b=HzvEUKYSzrtVgs5c+9+eFcCKGaK3uDQVW9KicpV9//0/HtmRtbqLn5BH
 ufkqRG2IDir9ipu4OzdKEfUgtOKaEtwUxSjBA7fExt3i0RYJAtZTIKWFz
 MsGAwhyjZte0Et3SPIK7VTAJP44MmE3W9e57OzRiuByPrWMqGE9Yb3sIw
 XSQ9fWPN0UuKJX8ZhhZrDr5ta6vrhCZdDvvMZjy0q9A+qjGCUEkDg8urg
 fi8t0mxA5pI9DD6yUwyyBH6ycT6xX5QDW+XNUd3uJd4hNZMiKlkDh7jMh
 OI/qibnFjdQLICc2q1Jvd1D5rycOBsS9taEdFveQVaPbhsQyYohIMC2CI Q==;
X-CSE-ConnectionGUID: ghKfvo8gRM67IPNV4Sq51w==
X-CSE-MsgGUID: WqIU5oZYRfGG0tew0yv5CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52125710"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="52125710"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 02:21:50 -0800
X-CSE-ConnectionGUID: 4I3fDpYDSxyaguIbuIslDw==
X-CSE-MsgGUID: CCgcfqTcTeKx+yuoEy9Esw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="114595415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Feb 2025 02:21:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 02:21:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 02:21:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 02:21:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwlmSSyRcXu1IEstGTRudaEsg7lixcrPVvF2MRd+BQQncJSAkUuQumKBJg6sRBYmLPGX7OQxm9ZSoSTxPVrXMwWlvl+/az2x5xNtckOoknY3BRkjgGVkgkY3GTJ0IyUnDYEeGzXejVsaigZT8iGiy1AjTGIujArfq3Czpca/fh1tdJqtRHt/6Yv/JfM2TDGnaXmwKaPlRbXoiSNFDWkHe5ZmWarqF1Hhl8XyDK2pKn07P2xHlOnwHUenolKHElORkquvg0DX/EOMh6+qGfOqqODr8b5bp4cx3ImRUWVLLWoBva+FgTntiQete04MceI+YFcd8vCrBwseEHUZrEM1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxJGXw1bYzWRRY7g1YuXcg8zAYdvtR1FwqD5ZY0SJqg=;
 b=VIDzLb2L5JbSzEokmB1iNQXAgENZy4ZkI3b5lxpd9bunNud8wUP6wE1PgK1flenzrWoaz4LocsUcvuh0lEhhHNYdcxmW/FFdrSkg32VwSqM5vT1q/D193/RGdObSomQzbIzW2Ew0BiiXP/v1JGwSNzVpKjwQG/bLTtzi2yhDORHDgvR+2+eQe+1hPVXls1M0rbrlb79Kbmo3siGO9qhcB14axX3pdm+Kj/PCm3qOqwRnPSt9rGwZD59IPK66uumhGMi0eqCTWIYrLkPEyhHqWR92RcH1pAc89PcQMpGZ8EIhJQdYzzNuh+dScMu4Ha3Gl00joQcvWpgviZikA0AONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 10:21:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 10:21:41 +0000
Date: Wed, 19 Feb 2025 10:21:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Sunil Kumar Kori <skori@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>, Brian Dooley
 <brian.dooley@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Message-ID: <Z7Wwr-o416zQ3CSa@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
 <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
 <CO6PR18MB44846826FEEA15C90FCFA837D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA4E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA4E@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0273.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cd9987-635a-445b-25cb-08dd50cf33a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWl3eFlYbzlDSUF3V2xrV2ZzTERRSmxTTWlHeThrUW1KM2VvM2xQZFk3eWZ6?=
 =?utf-8?B?bVZjYmdGNTFGZnV0SkYwSDF0LzB3SENkSmZZM1IzeWhwc3Y2NkdmT0ZGNFJq?=
 =?utf-8?B?c01raXYzUUp0ZURaQzUzSnljT0x0OENIcEdEdi9jTGszd3FQV3dRZW9kVTJ5?=
 =?utf-8?B?K21xRTVZc2JjeWh1YWhHbkRkZlUvMm1vSFRBbTNPaHBKMDEwZzhpWk9vQUtm?=
 =?utf-8?B?MDF4ZXUvZFU0eWlaMmRlYmdzTFk1UmR6MUNvS2M2T1diSVB2amhKeHc3Q1NF?=
 =?utf-8?B?R1gyRVp6SjlTazNsQk9ZZ210a2pTMXV0bHVNdGI4NXNlRS9IQzAwV0hqek5V?=
 =?utf-8?B?U2RaVGtOdFp0Q1ZDS3RWejFMV05yczhNOW4yU1g4ZGNEbytjN2hsaWNTSlNJ?=
 =?utf-8?B?ZlhLL0pDTkxsVVFPY1BLbDFKdGpNSjV1c3FwU1B3d0dkL2tUWjZVaklzWGVs?=
 =?utf-8?B?UVZxa2hRenFrNmlEdXl3N3JRN2w0N3o5Nm45dTE0Yld6RHJyZzJScWdTTTZv?=
 =?utf-8?B?cE92U0luTnBmMVlLa3RCcFJ3eEdrcFlRU3NuVnJJSUlTY3dpTDB3OFF0RnpC?=
 =?utf-8?B?U29jOXBIRGxzOTdJa0dkSVYvUkZkai9iRVZaRHJrT1hkdzdhdUdjdjZyWWR1?=
 =?utf-8?B?dktHbkJVZm5nMlJqWDVHL1JvMzc3Z1VyeEhNRXl4TCt1cytNYmw0T1hLVlFt?=
 =?utf-8?B?TnVjQmZxMnF0Ykt2VG5LV3l4NVRJenphQTlIQW4wWUo5MTdNUi9ma3JqRmpn?=
 =?utf-8?B?QlpQRlc5QmVNYTZlb2tuTXRpMEdFNHI0N3NJL2lYRThqcGxpd2ZEamMrVCtT?=
 =?utf-8?B?M2NXaHJMNUt2TjA2azBPMU9iZUI2ZEp5R0ZVQklNdUJMVVUvNmdGdEZYazZP?=
 =?utf-8?B?YUhaSmlWcWFOUzd3NTJPbG5UZFYwWEY1TEwrYkpFV2UyZ1VQU2JadjNvczM5?=
 =?utf-8?B?V1BIaFcrWjRLcytKRGtLQkc0VW84NWZpb25TNDE0aG1SSnRxQjJaY0duc3FU?=
 =?utf-8?B?ejhNaGw3TnowY1hpSnhUQXFlbmhMYVlpb0d1WkFKbWF4RFRNTHVJOXZqcXk1?=
 =?utf-8?B?N2k2WUE5ODNjUEoxQUExY0ZOMTkyL2F6Z2R6cTVtanFka1lDODBvUjNMRzVi?=
 =?utf-8?B?cUlDMTB3aitheExPNWNMcFJzdWlHeStmSCtLMzA2ZFFPN2F6akttd3hGeENR?=
 =?utf-8?B?MEhkQXk1ZHRZSldEcHN0aWZtVytaN1BsNG5GUGNHc1p5anBLSi9NQUhEakx4?=
 =?utf-8?B?SUZCdFIwS00zVDVadzN3dEVoVHFiWC9Ja3Y2TFhkLy9HTklxQUdnOFk5cUl2?=
 =?utf-8?B?K1hJQVNoUEdjbWthWm9OTnVZYjR5T0U3K01rMDlhbERTVmV2WDdWYkZGUU5w?=
 =?utf-8?B?OEJqeTZUWFdBL3lZV3V1T3pmeXJJdzdQOERkaVZiVU80VzE1eU5mM1BpVGVZ?=
 =?utf-8?B?NllxeXNVaXhZYzhSdVZ1UFZ6dlh1TGtCQ2lDc09HcGhiMkVqRzhQaUVSUGRs?=
 =?utf-8?B?RzAvY0pLQXhUZVUydERrcnBHa2J4RFIyZDJCdXRZTGtoVmFnZkpYNmVwNmlL?=
 =?utf-8?B?QTByV3ltdTRjQU52M2t6ZWcyWDIvVEpkbVFvU1h5a0JoRk1LR1p1dEczalVv?=
 =?utf-8?B?dmE4QUFRNU5xWnMxOFlTK2RzT2FTTGVhRHVjSHhSaFN5a0pWbDVJUkI4UXFL?=
 =?utf-8?B?eVhEUFI5aGxJNDJuZGQrZDl4a0Y0OGh6blBjSUxwOXUwYW1lVGVXTDBBN3pL?=
 =?utf-8?B?cGlSa1FOakNlaUpVNDJkcHdDb1BESlUyaWd5UmNCNGwxemR5Mi80aWZ2SmRL?=
 =?utf-8?B?d29LSTh0N0dEYkYxWXB1aGVJNkhMUnorUjg3cFphVkg0NGZJM1ZyKzlmKzln?=
 =?utf-8?Q?A3ewpqdvVng2c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5Icm91dDZCaHZRVGVmdThWT010UEl3by9NRkZEbzV3eFZBRDJpcGhFSHdD?=
 =?utf-8?B?VGVwMi9KZGZpY3crSVBxenB5bkt2c0tIc25QZjgzaTJDU1ZJTlhreFp5OGNt?=
 =?utf-8?B?UkhHQzBTTVIzd3VDN3czaUg3Q0FzbjFsdzJ1VEVGRU1uaE0rTTFOdnNtYUVG?=
 =?utf-8?B?ampackNHZWtqd3VtV1N3SzI5UVNHcXhRenF0c2FrWlZmU3ZzYitURTNkWjNQ?=
 =?utf-8?B?S05UZGM1QW42ZUZya0o4bTJJaTNQRndzNkFrOVBqU1ZuR1BNWXZMWVhSYVZx?=
 =?utf-8?B?YWwvci9hREZiQUtiVk1Yb1JWdWVPV3ZBM3puR1Btcm1Dbi90b3NvaUlhampY?=
 =?utf-8?B?aEZQWXhIY2lvcTNlaWV0MnVPRUp0azBqdTZhbHdkejhQa0Z3aUJTQ2JHWHRY?=
 =?utf-8?B?S1BBNXFFRTJVUnAydlk2UmY5aTY5a0tBekNDVTVyYlRNVWtRQnROMWQ4L0lV?=
 =?utf-8?B?SkZSV1pMa05CZ3NkSVFEdUJhVmRQQU84T2prYnFXUlZrU3Frd3NIR1NwcFNs?=
 =?utf-8?B?MHlnMDA4TUh4SnFmUlJsa0dBREtOMEJsQk1FbjkyU005OXV2N0ppa1AxNFIv?=
 =?utf-8?B?eGJoUklJR0V4cFhGdlpmRXF1eEltYlJJa0hBbTl4cW9CNUU3NTlKQTkrS0NH?=
 =?utf-8?B?bkJMNVFWOXBYYjdYY2dlV0dNMEp5aEJqbEp0MWlPV0VmN3V2RldtUHd5Rk44?=
 =?utf-8?B?VnJ0amF2N1FqNHZDMlhJLzcxcktBbm5WVW00UXlqOStZSU5mZDU0ZmRROEFo?=
 =?utf-8?B?TkVMZFhpMTBlNmVJS0hUS2lNYTZ6Z2dES0ZGQVJOaDc3RStXQlFSRWQ1VVdi?=
 =?utf-8?B?aFYxMlgyanZHNTVvQW9VbjVUVDVpdTdCYVV6b1NtM0lqQjJ5b1V2VlRzMkV2?=
 =?utf-8?B?SlFpUG5hRGMrN0d6Z0ltenFnZXZNV3Q3RTU1Rk5MQWhxdCtOUS9WMEJUT2JQ?=
 =?utf-8?B?a0laRmtZOWtEUGM1WkQyMTJMSngwU1hkbGRYL3NUd2g0blhYcW1RLzJxNFR5?=
 =?utf-8?B?QzNpN1dOYjkvVmpic2RIVzBCZU8wc0MwMDVlT0UwYlFWSFhqVDB2aURzY2xB?=
 =?utf-8?B?MVZOQ0xvV3IvSjhjamZrRUFURTJhUnFPTkpXenlpZEJ4RkRoOVFhMWh3SGQ0?=
 =?utf-8?B?S2l6bW81ZWhhYzRTRVZId3pMMjAvUVVwR21FWTZmSUlDK29VTVB0d1BvQjJ1?=
 =?utf-8?B?UzUwRFBlcXFPeFlJOWRaMjRYSXZUNkQzeUZCM1lleFF5LzhOOGlzbGNXaDRE?=
 =?utf-8?B?OStwdWRZREkxeXF0Y2cyUXhQVWROVzFGVG0xU0VXYWZFV09iSWVXWWpoRnVh?=
 =?utf-8?B?QThCaWhDV3VOZlBJVktFTmFnbE5lL3NHQXhiNUZJZkIxZjVDYlFoMWpvK3Bn?=
 =?utf-8?B?Sk1tWHI5Mmc1VWlBL2dTUGtTSTdjL1NuZGFWVGoydU1mSkVoeThIejBzQWVZ?=
 =?utf-8?B?TzJQNGxPWis3NUlKeHp0NDhQWFZ0SDhPbkVrZmlRTVBTRTh0cW9WQU9COWlB?=
 =?utf-8?B?RWUrd2hER0M5YUdMa0JKMXhDYXVKY3p0eXdhYnVTSlRKalp0Z08vLzQzMHRK?=
 =?utf-8?B?S1YzM3FudGZwUyswN3J4Wno3T2diZEdyNW9zNWtTL0pEY05aSmE3MWFmT1Nk?=
 =?utf-8?B?cnN3NEFRakpjRDdNd2FpRVZHc0x4YnRDaUJ1QUpNc2Y0Y25YQkE3RXRCdEpE?=
 =?utf-8?B?d0J2MFhoV1RsWmZJc2xudmlkQmNBeDhnT2gzMjQxMkI0eGNqdUppU3hmNVB3?=
 =?utf-8?B?WmkvQldNZHNQN0lQWTQxbXh3MitaRGgxSU5jTVdZYzZGNDBGZ2tHVmdaS2Mr?=
 =?utf-8?B?LzBYTUhySG4rTTRwTmc5NnFTeG1YMlg0VVVVU2luN1JMdVJpSlpVTFFLQ2dw?=
 =?utf-8?B?ek5VbXd6TVd4djF3cGtzaldhNFNMdTRQTDFFVTR5STZaV0ZxSkI0Z21GTDRT?=
 =?utf-8?B?bG9YVWNGNnIvWXovOGV5SVlFdElWNUxuSFdQZmJnelpFN0lsK09PYlZiUkZM?=
 =?utf-8?B?VWlMUFgrNW5maGJ6cFV2MW5BLzRvckd5VC9lOEg1b0dHZG1hbno5RCsyNG51?=
 =?utf-8?B?OFJaVExFbnFuaVUxS2NsaDJlbEk5WnBvUUtrME5DWGNHdVpGRGFNaGREcDhD?=
 =?utf-8?B?RkZ2WjJsNkx6YlFJVlh3bDMyR0lUNnlpUmRJd1U4MDNKK0lwL0JidGJwaE90?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cd9987-635a-445b-25cb-08dd50cf33a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:21:41.3978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psVhqv4ybnDcml9me5rhBnhJiDGK8KvTb1QYlgeEx1fLgPaaHLs7Cb+EkbP6U43Y0PQ1fEU7g7oZ9M+dieZoORIsrHFygEveLSIahsvbQ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
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

On Wed, Feb 19, 2025 at 11:18:46AM +0100, Morten Brørup wrote:
> > From: Akhil Goyal [mailto:gakhil@marvell.com]
> > Sent: Wednesday, 19 February 2025 09.16
> > 
> > Hi David,
> > > Hello,
> > >
> > > Cc: Akhil.
> > >
> > > On Tue, Feb 18, 2025 at 12:16 PM Anatoly Burakov
> > > <anatoly.burakov@intel.com> wrote:
> > > > diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-
> > > perf/meson.build
> > > > index fb48d9ec29..f056431bf4 100644
> > > > --- a/app/test-crypto-perf/meson.build
> > > > +++ b/app/test-crypto-perf/meson.build
> > > > @@ -19,7 +19,7 @@ sources = files(
> > > >          'cperf_test_verify.c',
> > > >          'main.c',
> > > >  )
> > > > -deps += ['cryptodev', 'net', 'security']
> > > > +deps += ['cryptodev']
> > > >  optional_deps += 'crypto_scheduler'
> > > >
> > > >  cflags += no_wvla_cflag
> > >
> > > - This app does seem to rely on lib/net.
> > >
> > > [989/1266] Compiling C object
> > > app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o
> > > FAILED: app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o
> > > ccache aarch64-linux-gnu-gcc -Iapp/dpdk-test-crypto-perf.p -Iapp
> > > -I../app -Ilib/cryptodev -I../lib/cryptodev -Ilib/mbuf -I../lib/mbuf
> > > -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -I. -I..
> > > -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include
> > > -Ilib/eal/linux/include -I../lib/eal/linux/include
> > > -Ilib/eal/arm/include -I../lib/eal/arm/include -I../kernel/linux
> > > -Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal
> > > -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics
> > > -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/rcu
> > > -I../lib/rcu -fdiagnostics-color=always -pipe -D_FILE_OFFSET_BITS=64
> > > -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include
> > rte_config.h
> > > -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral
> > > -Wformat-security -Wmissing-declarations -Wmissing-prototypes
> > > -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-
> > compare
> > > -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned
> > > -Wno-missing-field-initializers -D_GNU_SOURCE -mcpu=cortex-a72
> > > -DALLOW_EXPERIMENTAL_API -Wno-vla -MD -MQ
> > > app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o -MF
> > > app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o.d -o
> > > app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o -c
> > > ../app/test-crypto-perf/cperf_ops.c
> > > ../app/test-crypto-perf/cperf_ops.c:6:10: fatal error: rte_ether.h:
> > No
> > > such file or directory
> > >     6 | #include <rte_ether.h>
> > >       |          ^~~~~~~~~~~~~
> > > compilation terminated.
> > > ninja: build stopped: subcommand failed.
> > >
> > >
> > > - Btw, rte_security.h is included in app/test-crypto-
> > perf/cperf_ops.c.
> > > However, given there is a #ifdef, I suspect the intention was to have
> > > lib/security as an optional dep.
> > 
> > Yes it was initially meant to be optional when rte_security was
> > experimental.
> > But now, it is kind of mandatory library. I am not sure if it will
> > compile without rte_security.
> > We can remove the ifdefs over rte_security and
> > we should not remove security dependency from crypto-perf.
> > 
> > -Akhil
> 
> Not sure what you mean here, but:
> The "security" library is optional, not always enabled, when building DPDK.
> Ref: /source/lib/meson.build
> 
> Not all applications use the security library (or stuff that depends on it), so don't make it mandatory!
> 
I believe he's just referring to making it a mandatory dependency for this
app, not for all of DPDK. (Or so I hope). Currently it's an optional
dependency of the app.

/Bruce
