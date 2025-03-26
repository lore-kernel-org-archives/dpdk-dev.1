Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4218C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 894E1402F1;
	Wed, 26 Mar 2025 14:08:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C13B8402DA;
 Wed, 26 Mar 2025 14:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742994504; x=1774530504;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GOcOSGWrT3uo6cO8jRFkPEfTK0Lyg+a+caVomYjr+04=;
 b=bgUuLbdNTDQK4fUNRAepqXocwEt2knqp20yXDxp7yud10gOHjMQvf4/g
 UGm4sKHf5deAFsCnPxy0VbF0E1+ChQT1LvB1mnet9WpdwOIML1Gs7Op0p
 +tXTat9VumkH0087OByI4nSuiVxzXSFJDlOVIIW4fyoZTPHfQpKVR9ECD
 5ReYk21+/jVc4wnpO7IxfV+RhrMgBGMmP2GgQjquFZZTCATVqkQ/vx4Qh
 Qaw1EkUo2NG/p+fS1fRLZb3i9XFtYTWGOITVCMAfqWkyH1JRoRybkDSuB
 rUVu0v3miNa+XHE1al68KkHy59IyghDFoB9CyBqBBHyP0rgTrHlnbDLjm A==;
X-CSE-ConnectionGUID: 9o1rSOQQRo+8aqTXZxb/vA==
X-CSE-MsgGUID: Kf2TXUkrQTalO5w0gMmy6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55648133"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="55648133"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 06:08:22 -0700
X-CSE-ConnectionGUID: IEIDC15yQzeIHZQz5f5nyQ==
X-CSE-MsgGUID: iyRyix6iQ7W6V+3Ci4Jaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="125272709"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 06:08:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Mar 2025 06:08:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 06:08:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 06:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZrRigL/7l8iWmYQKwEeTO1j1gvr8i/H9qL17H9sl2HFTf7cvNzYtwwmuU3MLoROIjM57hrw2gj1ja+yCdxCqzyMVFz9B2/ovtXiongZ/wmG9Yo10v5z3clBwnjp7pXelsb6hCA+59hc9jPdZlfdzlUFe7v5kSWwhVt0SGJXihTdHCoCRCY9BMT4DZBNrKnZt1KTZJY4BYwKyWXDoWkOEVZno8RnPpxy7Rmhn6H5GPiLsC+BcXs97KGVGrj+8jZBF7KX9/T1QRU4h4faDvQKFBoH7Ki+wEledeYWn41ySjhZx+1K3/u6E6G0DZHB7hOMcvZwF7YpmpJP4GQJrHA8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj48PQgt1Sniep4DDL1DGf42bUwxD/b7A89Z5tJTDFE=;
 b=JVm5ViDDk6J8vPDyjtfwJ0yZ07qwf+HKIiF81yc4dstj9PfUYpyvFPbAwej9WY1HmAME6j+gj+fzD+1TdFBNDUakLxRLoz3iFRXDwDMV8JHj7wNM5bhGQwkrF2UzWhsAT0KNt4lyWC1McL4wma53PEc8Bv8db2qYUONwzFGljE4gRqFKsN9Hwzu+owdFRFhQwrX7LXEq9swP+uyS2MZ1kBavmNYOYYpEkWmI3YgFNBk841iHXT1ITJuSTDeZEtqjeckEwteDjqSQWdjcc0SUg7rmFNw/uYZPK4fXq9lY4c/ZDCqyz/T82oQEIoLp1ZPUKkiuXc91TLUpQ37DcmmIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 13:07:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:07:30 +0000
Date: Wed, 26 Mar 2025 13:07:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <andremue@linux.microsoft.com>,
 dpdk-techboard <techboard@dpdk.org>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
Message-ID: <Z-P8CyT9_DEnkuqj@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
X-ClientProxiedBy: DB7PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:10:72::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed13363-bf44-47c6-a60f-08dd6c6729fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1RUZ0dxZHF4UmZ6VjZCQ2c0TVBSam9MWEcyVzd4UVcybE4rNlZQL3Y5MU41?=
 =?utf-8?B?UGw3UUZqUElpbWtuRlI3YXU5ZTRZQXBLd0dWVHJockt3ZklEV3hmbHY1SFh2?=
 =?utf-8?B?YVYzbzBDY3QzVXNqKzRCWkp4aW4yS0ExSDdWalNWVVgrZmZ0SVl4WVNUdlR5?=
 =?utf-8?B?VGN0M0FDMjdveUlHOUxqeTUzWk93QWg3T3AwbzczSEdhSktDMzVqNm1UVC9E?=
 =?utf-8?B?VFZGb1poeUh0bEFVRk5NaEN5aVBDaUNHR0pqQnhZSkNXTDkxdmE1T3lZNGZZ?=
 =?utf-8?B?d2RwcW95eiszRnNTdUQycjFONy9MY1dYRDRzSlhCNExpNEx4Q3FaZnhUUGs3?=
 =?utf-8?B?VXJXS3BlVkNTYUdPVHVqb09CK2xKK2RWbnFJVVZNczFzNEhxZjYyYXlYZGhX?=
 =?utf-8?B?ZWdVcFkzS0xlczE4M3M3TWNhdlVwcEtGRHY1ZnNuVy93cHp4aDA3UnZaWWVR?=
 =?utf-8?B?S2RHMHo5b1hZYkVSY285OVVTZ005NEhYRmhpMUMreHhOQzZmQ01tUHB0SHQ0?=
 =?utf-8?B?bE5Sek5yS1loSGNJaStuN2E5eHVkcmtXQUp3RFpqVU5ESGN5YURFS1RoQzQ4?=
 =?utf-8?B?ODAxSU5iRTB5cHVVdVh3OW5rWDFkZFJiZlFsMW9BQ0tvRzVyU0VDWXFPRWkr?=
 =?utf-8?B?dXNqN0dXNXNIM3E0UGJSUkREMG1EcWNYZVdnaUg1T2N1K3RxUEllMGJrUmFW?=
 =?utf-8?B?YXZCRk5rMm92a0xxT0J6K3NRQjFZbzBUWlAxcVljY0p3M3lUVUNSKzVNZ01i?=
 =?utf-8?B?U1IwR0JPNm5CbnEweDlSL2NBa0oyVFBPVHhqT1lrbzcvbWZKK21rclRpN3NM?=
 =?utf-8?B?N3kreXVxVGovdG5ZMHhKS2VjeDFmWXp1RjlRSUN5SThlSDJrdjdjS3M3OTh2?=
 =?utf-8?B?WUtBbWZ5SDJ1dXpjTi9IcHBKcTVNOTFtUGJteENzZUJONmh0cnBtRXNGdGZn?=
 =?utf-8?B?QXNPUzBaQWN3c0FHeEhPenlPRzhzOVJZRy81Z0lBQkFsenY2cWFrbzhXelRk?=
 =?utf-8?B?Y2pmYWd0WHM1ZDNpL1FnS05qVDBqak1WbEJub05XWWZlRFRQRytQKzc3cTFI?=
 =?utf-8?B?RVh5Z1V1YjlydzhwWTZoYTBGTGhLbmhnekZwQ29lRm5XWDVuYXpzWHRUOTA1?=
 =?utf-8?B?Mk1rdVFpQmVkUHZkejJQRXhmZDVEc3o5Y3h4NHJuTSt0eXRpUmU1ZUNtL29R?=
 =?utf-8?B?cnZ0SzFlWDNUdDM0ZVRlOEJGY1BtSU9kUGcxazFOSWtrQnZQdEhJbFExdHNO?=
 =?utf-8?B?MjJuZ1JLWW05Uk4zS0RucEFZZXBhRjBLdURnY09IS2hTelliWXBIQkM4T3JY?=
 =?utf-8?B?ZzhETjYwSmZ5ekZIbVF4N2MrdXhqajJPWnBPSnRpR2krRlJpMFBRVU9LQ1ZI?=
 =?utf-8?B?UEkraldwRkdCa0lBa21ZaXBzUWZOc0x0aFFEUXkrK1RISlFESTgzSWZZUyt3?=
 =?utf-8?B?d09US3hEM2F4aEZvMHNSRlZWM2xOMmhWT2JtVm5zQ2QyR2JEWXF6aHB0Q05H?=
 =?utf-8?B?SEJtRzRLTDc3dldWNVNkcEFZSGlWejliRHlOSHl4Qm9YR2lycC9URkx4UVIx?=
 =?utf-8?B?OTNmRE93cVp2bWVLNWhGcmQrQmxSV3YxenloWUV2N1MzUjJHeEpTOEs1QWo2?=
 =?utf-8?B?VDk3WXVlNlcxU1EzUEI1SG9Ba3NJNWI1bU9Gbk5JYTZpWnFZc2xZQlQ0WnJr?=
 =?utf-8?B?azNHMXo4TVl1aFZnTzNIdXJrcWZNaWZkQmtTYko5MzgwK0k5UUhxQUFRYS9s?=
 =?utf-8?B?bG9rK3EwN3hKdjQzdFdtZXV6anZIVWxFOVRRWGRqZFZNeFFKN2RxcC9lR2Rs?=
 =?utf-8?B?UHViZ3phOFgxbmtySUh3MHljUGZVSjJXT3RBZDA5Y29ReE1vVnVONDBMU0hl?=
 =?utf-8?Q?sOBgHaMH352sI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRFVVIrVHZQR0FhWUNtYUFuaVNtWU9Nang5NjlYVGtneEZabUlkSEhyNE85?=
 =?utf-8?B?dHB3T3krWGtSTXFyZVU0NXJOVXk4SDBPdzU2dlVvSUh1NStzMEljN2U0cUV6?=
 =?utf-8?B?UzhFZG5DQmQzUWFwTUpIRlZxY20xK3d6ZDNFT2Y3dVZMVzZWN1N0THNMdXJJ?=
 =?utf-8?B?UGtZUUJpTUFlWFBEU0Z0VXlOTjhmOTBQS0JqRWJ4b1ZySDZDTEFuUTVPRllk?=
 =?utf-8?B?dkVKSVh4V01RdFZTYjg5UGdzeUVMQ1NGWXI0V01yM3NqdTVnZVduS2ZpN3hk?=
 =?utf-8?B?OEVtcWoxek5jZDdtQjBBTzE4YjQ1WFhqQXJlU3N2YUxXbWxpUTlrRDZ5d01k?=
 =?utf-8?B?SGpQeVA0c2w3U3BjWWoyOWxPbWk1UUxGQjlhUVIwMlR4QlZESy9ZY1pRNElp?=
 =?utf-8?B?eC9SV29odlV3bTNwUHlyeUNjUDBtcmQ0M2o2QjMyYStEZGsyVTJtRXZVREt1?=
 =?utf-8?B?QlY5elZHVnlEUloyUGlqOXptVmU2VzhlRmhjVml3dW5BOXRaN0FSbjhlZGo1?=
 =?utf-8?B?cGNqQmJqbU14eWFMZ2s4MDc0NGdEUGNMRlc4c3RvbXhtUnlDQkloM0FjQ1h1?=
 =?utf-8?B?UXh5VHpxOHRocmtLMk9SNzFBL2NjNFhyRzQ0ZjduNjhwZndoVlFaeSsvRW02?=
 =?utf-8?B?TEgvN2dGb25xQ0Y2em1LWncyY3Rjek84V0NwYzhRNXI3M3Y1cERQcS9qRWk1?=
 =?utf-8?B?V3Z3b0NoSGU1REp1dzBqWG9nYUxrWkhxZytsdzE5a3hocEI3WUhJS2NsMVpE?=
 =?utf-8?B?TksydG9tSnpVSjljVUN5b1U2aFJZclFKa3VUY0lmUkdyaFdmY2I2SzBYVXlR?=
 =?utf-8?B?NkR5QjB5b2pKcU5ZWEFNN3VMc2Jldm1CdnVvbUpNNFB1OTE3QlVzQmJ5cEVr?=
 =?utf-8?B?MXRrZWpUbjV1U2JiOXRKYmFMQ2hOdXpGc01NTTRsUEhGdHl3WjNvSFBsdEVH?=
 =?utf-8?B?M0E0RGVpTWpZTzRoS1RRV3ZKeDI2QWtpRm4xcXNzdWNuYVU0Y05qemREZzg3?=
 =?utf-8?B?bXRJTWszZ0IybjBsTjZkeEc2b1RMdEEyTnpUTVd1ZEtOWGxDUnZZZWJhR09R?=
 =?utf-8?B?T3Z0a2lvQXJscUZVRHdWMkV4T200d09VM3BzREI0U3lsK0x4YUxDMGk2VzIz?=
 =?utf-8?B?VzdOa2htMnUrLzE3YnhlckxyMWluQmNNUHRIR2NjSXV6clQzdzh1YzFsMWNI?=
 =?utf-8?B?THRjYklpY2d6Q0tCVE92M1ppMzY2M0VIRlhTVUVKOURnOTd4VmUrTG9vTWxF?=
 =?utf-8?B?T2FJbTNYV0t6MHRRVEJpYU92Zi9lTXc4bjBZREtWM2k5YS9kYXRxZ2I1ZWJL?=
 =?utf-8?B?R1N6RjdpSFJYbUVwSWJBbmdlb3RadUVGcGZmeUl0eUN5NWs5TTVwUzVaaHc3?=
 =?utf-8?B?UUowTzEwT1NsOUdMYVpMeGc4S2lScUw1MDNLaU1sSWpQZzlObFRxTkY5cVFR?=
 =?utf-8?B?NEUrUmk4SGFrSVJMdm0vaXJqZ2lsL29Sam5aQkdGZktmQU1zOUNtRldJYU90?=
 =?utf-8?B?Z1NXNjBENlN5aVpsQUswNzhuTFJWRU9MNTg1V3RPK1QwaEFpeGZrUmhOeXZJ?=
 =?utf-8?B?N2ZxZitMUHRHMHZiZHV0UXFFUWtNRVVOWUNvVGNEYlYvbk1EaEJjVXh0UEd5?=
 =?utf-8?B?enFGcTZ1YTM2NGJPUml6M21TeTh4aDdYTUEwSC9vb1grVkFSSjFRNVpCUG9Y?=
 =?utf-8?B?RFFRV0pKSzVqcS9Ka3FVajNDbEV2MVl4QTBPempBQ3hFMTVEcStsenBmMitD?=
 =?utf-8?B?cWJyenV5THlJNXpHR2pEOVlRNlR3dUtXZkpsWEN1YmZBRGRrbGI2UlhQeS9k?=
 =?utf-8?B?YWlpQk9CTkRsS3pERGo2TGJOZEs5UWRWZ2RtbmtkK2o3ekFzbnRLNWdzNEs4?=
 =?utf-8?B?WWJ2N1hnVEp5d0RRSnM4M0lBRnVYMkZ0TjNoeFBrYnB2eDNmZndCL0djRU1j?=
 =?utf-8?B?Y0FVWVhubXVpa25RdVNsY1czQ25qbU9WSDdiVjFCdGpvRkRucjFQSmJuWVZM?=
 =?utf-8?B?bmwrS0RtSW9PWElJdWpEMDBjWWZNN0oyT1hJdkIxcU5HdkNsOFNia0lsbXF2?=
 =?utf-8?B?b3Q0aVA2NHBRUGR3THhFMHpGRkhremVFUXNZMnVvcDlBb0l0VFJERlVRbXV4?=
 =?utf-8?B?YnY4Qm1JbHJRV3ZjcnVUMGdPVzkzbjh2SEsvdTFoS1U1WWNKYVRvQi9QbjRH?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed13363-bf44-47c6-a60f-08dd6c6729fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:07:30.1077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqcWbd6nHRpRDAE8ACy1/AIH+DXxqOclvqfbw45uBt3XCFYMdh/ZGhLFiqyQNWuLn009RAtoput0vKeBx9Uy+IyCYK6AIlHLu9tVWSyG4pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
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

On Wed, Mar 26, 2025 at 01:02:32PM +0100, David Marchand wrote:
> On Mon, Mar 17, 2025 at 4:43 PM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > So far, each DPDK library (or driver) exposing symbols in an ABI had to
> > maintain a version.map and use some macros for symbol versioning,
> > specially crafted with the GNU linker in mind.
> >
> > This series proposes to rework the whole principle, and instead rely on
> > marking the symbol exports in the source code itself, then let it to the
> > build framework to produce a version script adapted to the linker in use
> > (think GNU linker vs MSVC linker).
> >
> > This greatly simplifies versioning symbols: a developer does not need to
> > know anything about version.map, or that a versioned symbol must be
> > renamed with _v26, annotated with __vsym, exported in a header etc...
> >
> > Checking symbol maps becomes unnecessary since generated by the build
> > framework.
> >
> > Updating to a new ABI is just a matter of bumping the value in
> > ABI_VERSION.
> >
> >
> > Comments please.
> 
> - I am considering making rte_function_versioning.h a non exported
> header (precisely, moving it to buildtools/ and maybe renaming it).
> 

+1 for not exporting it.
-1 for moving to buildtools. I don't see the need to introduce yet another
header path in DPDK. Let's just keep it where it is, or moved slightly in
the EAL folder, and then not export it.

> This header contains macros not prefixed with RTE_.
> Using it requires some build trick (see use_function_versioning).
> And I don't see symbol versioning as a MUST infrastructure that DPDK
> needs to provide to datapath applications.
> 
> Yet technically, this change would be an API breakage if some
> applications indeed relied on it.
> 
> Cc: techboard for info.
> 
> 
> - On a similar note, this RFC series adds the rte_exports.h header
> (defining RTE_EXPORT*_SYMBOL()) in config/, though its job is for
> extracting a symbol list during the build.
> So a better location is probably buildtools/.
> 

Again, don't particularly like buildtools as a path, as it's not really a
tool, just a header file. I'd rather keep the tools folders for scripts and
the like.

/Bruce
