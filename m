Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F2C87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 09:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6780540DD7;
	Tue,  5 Aug 2025 11:28:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8D3F340A4B;
 Tue,  5 Aug 2025 11:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754386120; x=1785922120;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5n7Hc3oOmeUw4A460YAnEYWikeENd8zITOTi+kDZQIY=;
 b=m7Vy+nxApFcZ5qexQzRonzgpqTNdmpbleAQAIgWBhy6RiBKjSlBGknj7
 sFIXE6Xi6QaUbDf0PtwJ9mzeYfDBZ+bNwSXkqdyJCb1nuhM2psbzO0pma
 93ROcmDBAvJzSPnmrrsKkbYU73AFJKNdYIolBSVSk+FABAf81Pn9333mx
 qAy3MPJ4PSahAzmJiK6E6RHC5aRFsQllk2Rvk4kLOqPVWe7P4M3ep7vQE
 Wz1IR22SGE8xhJKpg0nr5MI3bGg0tOrkTsZ5w/atzdLlKbHEe5icW1xLu
 Vwkc+jx5Iu5YRbKV2cLxQfHjaQsCtdSrxd1GjBxJuujhTuVRlDmycUEEq g==;
X-CSE-ConnectionGUID: 3kHk6GBnSWeB91mxBckCgA==
X-CSE-MsgGUID: B7t+1dmBSJSnmquHOh2d/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="74252246"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="74252246"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 02:28:38 -0700
X-CSE-ConnectionGUID: Q16tH2OeRJG/IaH0B+227g==
X-CSE-MsgGUID: uliSF6v/SUWPd8/yQF1P1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="164856821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2025 02:28:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 02:28:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 02:28:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 02:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfCvEkpJyYNu2UjPZJ60Zj+t3w7oHKZGpm2bQkVOFeXMEgZTs/hRvIS77L4j/WHhgQJp//8kc3+kapAyPIxTK0fA4URkRqtlW60eQL+MfgEkcr6TVSnkCQIIeBEicNWAa0qAeeZwTdRit4hhXGsd+uj7OL4TxXzs3eqDeljxtfX/DJXUKh8MbBbCaEFpoMjmQg5Wf0smSqP3H0y3hSYZWI5Dz3iWUalx1sdfMiybUcEXyGWv8X9Hd6+3ACQJ+fR6QbJnly1gWst5KJjJsjPG1kCdIC2q7o06rdn2WYvkfiVwJu0tVL6krhpNuuUWetfBkmboZz+2bEQvTp6BzEVx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n7Hc3oOmeUw4A460YAnEYWikeENd8zITOTi+kDZQIY=;
 b=ZwJPpsO547Tq0zBX18VW/NZPiM3UZ2Jw5KvGpccqPUoNmtEpB1ok7hRvj/fOar+xuIXbzOtko/IAtjmsu9R0+GKwiF1e2i+whjEOeeoraI9p/46jJ+oujH6JLndgUkm3RNc4YuV1DHCuWZhDsyxVY/tfEIFFgR62A+mbA5zxjcYk7dW3S8cvEmkpc6MCoF1+bbNnVxBSHqfHJ1EHl/c0qy0/HavkoTz+0l7DHLF6zYj1boyXcTMN1a/pxkjRqGfhgDq7Bm+Yn2yB6cjJRVlKKCWcJ0jBzAI17d5nZePUTkTrXkVAtwpvHCpKuKMxZMZC4E5L4RyA20fjrg2J/VCDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 09:28:19 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:28:18 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: RE: 22.11.9 patches review and test
Thread-Topic: 22.11.9 patches review and test
Thread-Index: AQHb++weWQJ9SbwvN0Kihjzjk0IuYbRT3a6Q
Date: Tue, 5 Aug 2025 09:28:18 +0000
Message-ID: <IA3PR11MB9040438B8C576F33588A3E1D9F22A@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
In-Reply-To: <20250723160822.1686060-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|DS0PR11MB8162:EE_
x-ms-office365-filtering-correlation-id: e33d0068-0500-4fa6-3a88-08ddd40269c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cElhWWZxeEU1ZW1LcHN1MS8xODhkT0s2WFoxYytSY2xsSmFNQmNEOUdyUFk0?=
 =?utf-8?B?cU9JbEFiV0Rkb1NseUIvWThvaXZxUlZXWTJKckNMaG1RVytMb0RDbHFRL256?=
 =?utf-8?B?ZlI4WkN6ZlgxeVREUzQ2bmxSOC9oMGtCeHRONTA0Nk4zbEYvYzA4cDBCaUtp?=
 =?utf-8?B?UmdWOU93WXJSbTlHVFRPUFhNbDZDNXF2R2hKeUZPWm9kRk5FbllSbVNtcnRH?=
 =?utf-8?B?eTZJMVBkUi9QT3VVNm9jL1hZRzY4a0JoY3BPNlV5RU1odVJPM0RHWTVOK3lO?=
 =?utf-8?B?ZGhHUnRxWXVWSE5peTZLUVRKckZQcEdHYWdCekVScFRFNWh2SU5xTFVDRkwx?=
 =?utf-8?B?NUxoS3FCb1FKbDBUTVBUbUhXU3dCNnR1Q0RqcUlTb0RjZUJremkzL0g2aitp?=
 =?utf-8?B?Q1R5QkR1NkhTWXZOVUZoWlY1TGFrcVBHdlJmK2xkaE9laStFUkt4RUl6WlZn?=
 =?utf-8?B?S1g5emNrY0RmRU5mMHVFTUREdVNwRjRIUnNGc044YVRSbnRnb3JUbmxNQTg1?=
 =?utf-8?B?dXBMSkQ4cWpqU09ZZThxaFJGcXV6eFFoLzFGZFhNRnpIQXB5WUp2SmwyTmN2?=
 =?utf-8?B?YlZ5aE5YOHNuQTV3ay94YjJ2WHYvMWdyME43b1ptQmxRQTZmclYvSEVlc0FW?=
 =?utf-8?B?L0E5ZEVRSzR1ZGNza2RoNERIdERMS3VhWEVrRXNiUFg4L3pHZndVVHhzVml1?=
 =?utf-8?B?Z2RNNElkY21LMFlSVnIwNXMrTTN1TmgwRzdZT09iRHo3Wjkyay92QWJLSnpX?=
 =?utf-8?B?eXZrbFVXRHgvelFKU0ZDMWxjNDJONnA3OTBQSUZsZTM5Y1ZBWXJzSTBmMU9q?=
 =?utf-8?B?TDVZZ1FIOXlxOFFZc3phRHdrRWFoS1NsSExQdDZoVnA2OVdsa3dJMW1KTGhH?=
 =?utf-8?B?UFJxQTgrcGE0WDFZZ3FBUUhraWVlUG5iUytUeVVQYWE0bzh0eUI1YnQvZll3?=
 =?utf-8?B?VW5rVkNnQ0R0RGh4MUgzYlJybW1TVHhLdXM5b05kbXVkMW1uTEx2MVd0RUQ0?=
 =?utf-8?B?WlBhYlo5L0tJcmhYWExxVmluL2RDUFE5OUtEWExmRnlOMmNWMk1LTlNTT1VS?=
 =?utf-8?B?M0p5RVlndmhtWGRVcFM5ekg0RDlSMDRYUHNudmp1bUE5VmY3d0t6SnA2WEVQ?=
 =?utf-8?B?OXphNVFaYld5RENROUd0NWJGdE81eHlrVldLcHNOR21TK2ZRQ3lmNkVHZDA1?=
 =?utf-8?B?UDhJZFRtckhqcW95RE5NKy83SnNLaDIwYUdDcWpsYW1nT2tXMTU1WlFEa2t1?=
 =?utf-8?B?WU05THZqRXR0S2FjeStlbElTZFg5MnlJekdRUXJqdFdCZDZnbTdqWGJQMy80?=
 =?utf-8?B?U1NzZElKZjJGaFVYSE1aOG1la2ZrZjgxK0VjSG01ajMzbjEraUlTeHNhZERC?=
 =?utf-8?B?R25DeUxqZGRNcVdUVTJEci90RHNGb2J5aEpiYXZKYktyem1MNGphbG9QbkVF?=
 =?utf-8?B?QldwS25hYmZiRGMyNTBic2xNbkRkMDV1MFQ3V3NValN1alhaOTZ1MzMyNlpo?=
 =?utf-8?B?K0JnZGU2R1lCRzB3bFBTNkoxVTZrempuK25qNjdOeHlzbnl6enZ5RS91QTBZ?=
 =?utf-8?B?aVFzOWpNamsvZUM4M2VEMk90U1hQT0REUm5mT3JKQVB5ZmhrNEtsODdCcFRr?=
 =?utf-8?B?M1kwemlDQ2w0V0xLWGlPSDA4aGg4enoyUko4a1hidm54S3k5WVRnUGFOdmxG?=
 =?utf-8?B?YlIyVG82QzZ1NnBRU3gzK0xidEJoSm5LRGJGSnJKL0FrTHBYZWpmL3BiVGt2?=
 =?utf-8?B?YkxGSjNOSWJnY0dPaUphano4MXVHN1hEQkN1eXVwNGEvVW9uUU5ReHJ2ckFI?=
 =?utf-8?B?NGMrK1Y0V2grK3hvd0lVSG1aMFY1Mmx1RHFiMFF1VFlzc09XRjh6S2gvTENT?=
 =?utf-8?B?S0NCTTVvcGlKblhqWmU3MnF0eWtqVk9IbFJibTBsVEVCclNxSVFaUC9RZmcw?=
 =?utf-8?B?V1VuS2VhckkzejQ5UW54ZWJaV2ozQm41VzJzMTR6THBWaFEzTll3Q2lYNWlv?=
 =?utf-8?Q?JxWzBni8EicF84DJ+Sv/2v2EFFJy1E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0pnSFJ3ZEhpK1JSYkFXSWkwZFYraG1ZamV6Z2x1M0hmb1Y1ZVFDQldzWWdm?=
 =?utf-8?B?WDFSRUJGWUFmWHJGVml2eTN2d25TSlR1blZYcU1odjRidUNZZE95QWdyL0lF?=
 =?utf-8?B?MFpuZmlVNzZRYjZjbzZaUEVZYUg5cm5KSW5iRE1yR0U2OWcycGlLZW9JUk91?=
 =?utf-8?B?cDUwNVYvUTFYb1dFUllNK3VacGFza3RVVlg0bnNOTGxYZTM5UStMQlY3Q1Vw?=
 =?utf-8?B?NXRqU2xnTUNPZEQwVklQS2J0S3dPVUV4aVlvbzNWODRnR3JadTZvNk1RQUg4?=
 =?utf-8?B?cW83SDVqV05vd2NvY1p6eERmbjY3VUhTaTlmZW44SysvRER5R0drWlplTzg0?=
 =?utf-8?B?UlVUZnJ0VExFZXlJdEZoWmJyMzd0bktxaC81LzFSREUzMW1uV2x4MTlkNGEv?=
 =?utf-8?B?SUZXeDJhSk95ZkxSY3V3VjVQaWh6Mm1BWDRib0k2bjZQUGliRnBJSDMxczc0?=
 =?utf-8?B?UHNlQi9QbWFDNW9LaGhneVRGMis1YlBpZXNUYk1DbWhEWEJpa2hTWElOVmw3?=
 =?utf-8?B?NlAxaEVJTElPQjU2Zk1JYTBkYTF5T1VCUHQ2dEVRQXludzk0T3hQcWd1WlJk?=
 =?utf-8?B?UFYrMEJkQ2EyOXZhc3FNR2tYSUJHNUhZQ3hxN0w2Y1o2SU04bFE5UmZraXdV?=
 =?utf-8?B?NGp3dHBGZXM3TXhNbklFdVJJazRxTXJJUFF4SFdISVBqaHhQVk8ybzkrNnVh?=
 =?utf-8?B?OG1scUZJK1VGRjE2empEVnJMNlU5Qm9Ua2tFMlRvMmREeGlPaEQxUnY4SlpR?=
 =?utf-8?B?RDdXQlhZUnpwczNEY2RGOXJtRlRJTVkxQWl0ZmdLUmk2V3MvVmNZdTY1NHRa?=
 =?utf-8?B?UUFIMXd3YkE1em1HNEhDQUhwa0hkWlhlVHZxZ094c1Y5ZzJ6eG1rMmdFSThu?=
 =?utf-8?B?NWx4Vm9DenUwM1JPQXR1d2lhOGk2Rzh0NUtHZFdYcjVJN2tnQ2lDMTVJdUt6?=
 =?utf-8?B?M09kVWVpRmFxSlBTdUUzK0QwWmE0VzNsc29oRjdkQ25YbjRhR0xIaGZkNXBS?=
 =?utf-8?B?Yi82Zi8wT1NnOVc2U2VaSG5naElLMDFhU2ZDVmo1dCtxUFVtT3FhUjZMdXAv?=
 =?utf-8?B?WStjSlR2MllPZERUMlRYY3ZEWjJhdTFUcUN5cHJRWkZoTlRxRHVCZjNxMit1?=
 =?utf-8?B?T3NmTTY4UmRzelVsc28zYVVHM3dhSzdLa3BYYlpRZlRLWm5yVitxazlnbTBR?=
 =?utf-8?B?QUNwK3JveThTZ0kxT21CMG42cGxPOFFuU0Z4OE1HVEZLVVB1ditaMi9pUGIr?=
 =?utf-8?B?UCtQTENZQ0xxYmxSUGNtRVFXSWtqYU4xVG1JZ0NOQ3FWTjFyb2RhOUgrRzM0?=
 =?utf-8?B?NWVCTFZYZjl4d1duQkkvaFplMkRTY2JqWXhUOTZybmk0RzFZOHpuU3JhTXhx?=
 =?utf-8?B?UDdaYURILzhrVFNOc2szcW12Vk9GQXY0Um12SWQzNmZacjVuekFhUVBjNXFX?=
 =?utf-8?B?Uk1xSmlIY3Fvbm5Wblk0aWhuSUErNWtjSTFtMm53S2x1U3RaYzJ5N3FLbUdY?=
 =?utf-8?B?TVBEQVVBeENLMEsvZGVJZUltVS9CTHpGNnNtVGpvVzYwc1BjOXNhbnlLQkZQ?=
 =?utf-8?B?RVV3am01K0V0b1NiU1lwaE1tTXZ5Vm9tQ3NZeEhKQWY5b3plSHpZdXVhUVRY?=
 =?utf-8?B?bzhmL0E0eklOTTN4WnpzMm5EN1FuRk45Nm9BM1d5Ung5RWFrY3Zsak9yamp0?=
 =?utf-8?B?NU1RSmY5aUtiVzJCUkRaS2xsakZBcDVaY2V3MFFBSUlYREhPVFk0NVhoUXRZ?=
 =?utf-8?B?UHR5TURKbHRQcUgzMm4rZy9nMndSMkpQUVZGamxtZittMW5STi9VWmRkbDUy?=
 =?utf-8?B?Yk8vQjhEV0FENXcrWEhxRzlvS3V5amJXeDB4ZTBuMzQ4aTV6T3AyNFY2Um9n?=
 =?utf-8?B?eVkwM0llL2xyVStqWEt3clRaUkJoSUYwa0VpbW5HQW9hNUVkd0l6MklEdk9M?=
 =?utf-8?B?czFNSnllRDBOeHRJL3EwU3B5dXlLb0pmeU1TbXovRTlZQnhPNDNiVnNiZVdx?=
 =?utf-8?B?NnVsWklNcitML21Qd1RqWVVsR1I1MDlKb3VzdnBpdnpJSlVabCtsSUxoQk54?=
 =?utf-8?B?cTFyNVZsb1MrZnUrV1d3K1JlNUZzNjNmS0hqRUlzdStyMnBuRFptWVJadUxw?=
 =?utf-8?Q?IoXdUHJjv38Pi++iZTz3lneHd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33d0068-0500-4fa6-3a88-08ddd40269c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 09:28:18.5674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKhPR5lat45Nt9DeW+CTxX65TnMazCu8VIzzfonpsITvjaFHWOkcMz2WcPud2X35a6wR5Abw2pMahKhKdN/eWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsdWNhLmJvY2Nhc3NpQGdtYWls
LmNvbSA8bHVjYS5ib2NjYXNzaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI0
LCAyMDI1IDEyOjA4IEFNDQo+IFRvOiBzdGFibGVAZHBkay5vcmcNCj4gQ2M6IGRldkBkcGRrLm9y
ZzsgQWJoaXNoZWsgTWFyYXRoZSA8QWJoaXNoZWsuTWFyYXRoZUBtaWNyb3NvZnQuY29tPjsNCj4g
QWxpIEFsbnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+OyBEYXZpZCBDaHJpc3RlbnNlbg0KPiA8
ZHJjQGxpbnV4LnZuZXQuaWJtLmNvbT47IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBu
eHAuY29tPjsNCj4gSWFuIFN0b2tlcyA8aWFuLnN0b2tlc0BpbnRlbC5jb20+OyBKZXJpbiBKYWNv
YiA8amVyaW5qQG1hcnZlbGwuY29tPjsNCj4gTWNuYW1hcmEsIEpvaG4gPGpvaG4ubWNuYW1hcmFA
aW50ZWwuY29tPjsgSnUtSHlvdW5nIExlZQ0KPiA8anVobGVlQG1pY3Jvc29mdC5jb20+OyBLZXZp
biBUcmF5bm9yIDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYQ0KPiBCb2NjYXNzaSA8Ymx1Y2FA
ZGViaWFuLm9yZz47IFBlaSBaaGFuZyA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgUmFzbGFuDQo+IERh
cmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsgVGhvbWFzIE1vbmphbG9uDQo+IDx0aG9tYXNA
bW9uamFsb24ubmV0PjsgWWFuZ2hhbmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiAyMi4xMS45IHBhdGNoZXMgcmV2aWV3IGFuZCB0ZXN0DQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBIZXJlIGlzIGEgbGlzdCBvZiBwYXRjaGVzIHRhcmdldGVkIGZvciBzdGFibGUgcmVsZWFzZSAy
Mi4xMS45Lg0KPiANCj4gVGhlIHBsYW5uZWQgZGF0ZSBmb3IgdGhlIGZpbmFsIHJlbGVhc2UgaXMg
YnkgdGhlIDI1dGggb2YgQXVndXN0IDIwMjUuDQo+IA0KPiBQbGVhc2UgaGVscCB3aXRoIHRlc3Rp
bmcgYW5kIHZhbGlkYXRpb24gb2YgeW91ciB1c2UgY2FzZXMgYW5kIHJlcG9ydCBhbnkNCj4gaXNz
dWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJl
bGVhc2UgdGhlIGZpeGVzIGFuZA0KPiByZXBvcnRlZCB2YWxpZGF0aW9ucyB3aWxsIGJlIGFkZGVk
IHRvIHRoZSByZWxlYXNlIG5vdGVzLg0KPiANCj4gQSByZWxlYXNlIGNhbmRpZGF0ZSB0YXJiYWxs
IGNhbiBiZSBmb3VuZCBhdDoNCj4gDQo+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRr
LXN0YWJsZS90YWcvP2lkPXYyMi4xMS45LXJjMQ0KPiANCj4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9j
YXRlZCBhdCBicmFuY2ggMjIuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gICAgIGh0dHBzOi8v
ZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlLw0KPiANCj4gVGhhbmtzLg0KPiANCj4gTHVjYSBC
b2NjYXNzaQ0KPiANCj4gLS0tDQpVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJbnRlbCBwYXJ0
LiBkcGRrMjIuMTEuOS1yYzEgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBubyBuZXcgaXNzdWUg
aXMgZm91bmQuDQoNCiMgQmFzaWMgSW50ZWwoUikgTklDIHRlc3RpbmcNCiogQnVpbGQgJiBDRkxB
RyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCBjb21iaW5hdGlvbiB3aXRoIGxhdGVzdCBH
Q0MvQ2xhbmcgdmVyc2lvbiBhbmQgdGhlIHBvcHVsYXIgT1MgcmV2aXNpb24gc3VjaCBhcw0KICBV
YnVudHUyNC4wNCwgVWJ1bnR1MjUuMDQsIEZlZG9yYTQyLCBSSEVMMTAsIFJIRUw5LjYsIEZyZWVC
U0QxNC4yLCBTVVNFMTUsIEF6dXJlTGludXgzLjAsIE9wZW5Bbm9saXM4LjEwIGV0Yy4NCiAgLSBB
bGwgdGVzdCBkb25lLiBObyBuZXcgZHBkayBpc3N1ZSBpcyBmb3VuZC4NCiogUEYoaTQwZSwgaXhn
YmUsIGlnYyk6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBSVEVfRkxPVy9UU08vSnVtYm9mcmFt
ZS9jaGVja3N1bSBvZmZsb2FkL1ZMQU4vVlhMQU4sIGV0Yy4gDQogIC0gQWxsIHRlc3QgZG9uZS4g
Tm8gbmV3IGRwZGsgaXNzdWUgaXMgZm91bmQuDQoqIFZGKGk0MGUsIGl4Z2JlKTogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIFZGLVJURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxv
YWQvVkxBTi9WWExBTiwgZXRjLgkJDQogIC0gQWxsIHRlc3QgZG9uZS4gTm8gbmV3IGRwZGsgaXNz
dWUgaXMgZm91bmQuDQoqIFBGL1ZGKGljZSk6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBTd2l0
Y2ggZmVhdHVyZXMvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgv
QWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIEFsbCB0
ZXN0IGRvbmUuIE5vIG5ldyBkcGRrIGlzc3VlIGlzIGZvdW5kLg0KKiBJbnRlbCBOSUMgc2luZ2xl
IGNvcmUvTklDIHBlcmZvcm1hbmNlOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgUEYvVkYgc2lu
Z2xlIGNvcmUgcGVyZm9ybWFuY2UgdGVzdCwgZXRjLg0KICAtIEFsbCB0ZXN0IGRvbmUuIE5vIG5l
dyBkcGRrIGlzc3VlIGlzIGZvdW5kLg0KKiBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5n
IGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGli
cmFyeSwgZXRjLg0KICAtIEFsbCB0ZXN0IGRvbmUuIE5vIG5ldyBkcGRrIGlzc3VlIGlzIGZvdW5k
Lg0KDQojIEJhc2ljIGNyeXB0b2RldiBhbmQgdmlydGlvIHRlc3RpbmcNCiogVmlydGlvOiBib3Ro
IGZ1bmN0aW9uIGFuZCBwZXJmb3JtYW5jZSB0ZXN0IGFyZSBjb3ZlcmVkLiBTdWNoIGFzIFBWUC9W
aXJ0aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9vcGJhY2svdmlydGlvLW5ldCBWTTJWTSBwZXJm
IHRlc3RpbmcvVk1BV0FSRSBFU1hJIDguMCwgZXRjLg0KICAtIEFsbCB0ZXN0IGRvbmUuIE5vIG5l
dyBkcGRrIGlzc3VlIGlzIGZvdW5kLg0KKiBDcnlwdG9kZXY6IA0KICAqRnVuY3Rpb24gdGVzdDog
dGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9Db21wcmVzc0Rl
diBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQogIC0gQWxsIHRlc3QgZG9u
ZS4gTm8gbmV3IGRwZGsgaXNzdWUgaXMgZm91bmQuDQogICpQZXJmb3JtYW5jZSB0ZXN0OiB0ZXN0
IHNjZW5hcmlvcyBpbmNsdWRpbmcgVGhvdWdocHV0IFBlcmZvcm1hbmNlL0NyeXB0b2RldiBMYXRl
bmN5LCBldGMuDQogIC0gQWxsIHRlc3QgZG9uZS4gTm8gbmV3IGRwZGsgaXNzdWUgaXMgZm91bmQu
DQoNClJlZ2FyZHMsDQpYdSwgSGFpbGluDQo=
