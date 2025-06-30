Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E1C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 17:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CBDC40661;
	Mon, 30 Jun 2025 19:35:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 59B474025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 19:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751304901; x=1782840901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AJ/o+KHSuthhm/+qy/7sQ4tiFR97kIJlZzFfDp+dQWc=;
 b=NIc739mh3oTwUNNdvLdL7vlDHmeV4qYhmkY0iOOHyiiHfk7qVB9ZX68C
 6KKRVQjByduRxy13hj+t6lrK7k33JJDbJUU9FVdVUR4/k98ViR/VYfhfo
 h36HJSLR3X/NdoO/ylHD+wXqMpUzjggXvb3VFz6pWDDbTxXACzTa43UTI
 hGw1pPtSDQQvc6JBC82BtAVw/ZVlV93SqiU2ZOYaY7xZp1K85bWClIyt2
 7fiBBNbRxeJBDOSofTkQe9YA9CGA/+8QxXJqkfvAjX8fNaMgRoQE3vgNK
 rHtirQFj/GgQ4hTCDyKLG7BwUHt/qP1RIQqjGSf840SF5PO326rX0bHKR Q==;
X-CSE-ConnectionGUID: yCRCvW/rTXKxnXtGY5RMwQ==
X-CSE-MsgGUID: hMUaSkG3R6yHGrzL+n2DBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56162934"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="56162934"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 10:35:00 -0700
X-CSE-ConnectionGUID: WPhqXWl8SVOfT3dJ1R0UjQ==
X-CSE-MsgGUID: VkwxXsxaSYeTem+36Or0Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="153611612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 10:35:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 10:34:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 10:34:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 10:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itgvHVvkUQPo4d0UOuznk2lidJl0eoFRvnHorV2kXu8xn5a8VdG8BIlrb6Yvu8i/HJjfcTIdM2Q79CR75+Hn//OUFlA7EV4qCtKX3s+ivsO0j1O9rjGSFbuDHgfUZkvZdQTWTwKWDSKVkEEU6FJGoGYCKCWfjO9ol7LAW8MARNuEzNPPHiwEQhMjN89vSrzeilLMNmRafk/DuG0+KRtn2I+SGJE5e0HhLy5X663ULvxWibrAgKpHkiffCXocW8gRclMRFTKNUsiGShp5EUL2OcAf9pZ/ebuF0AKgObwXDkWgO0dKVomaCvotejc8o4J2PL8n22tSgBWwauPdKCgLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ/o+KHSuthhm/+qy/7sQ4tiFR97kIJlZzFfDp+dQWc=;
 b=SEGcZO515I/KwaUw6mHmZ6DZnhOb6xMo4iTy7zjzZZbINSYtlU+cNXY7zZJE9GZ9744CrtMzv3tQbOA7qdR6f8GbCAayc3cTb5mmw3eYAZAVE7IxpTZzG1T3ZeH4XyRG9rfziO/kUlSaS8DbUx9tdOO4z062pq6LVIJM5gHyCaQ1E65pf0Fc7IjmkdxDae1EpIlOwwDofCrJrQIIU6IRuP8YkPgVxqArbjvG1GH0XMLlZQAN10hm9BoGzZTKh/5lDC2CNnBrhNjLGVqdPDjVNwO/IIwlHeR9qI7S9HRhqugbD+j23LBv0x9LlFoZBn+LQ8GFQrsAk/sLBVa8GcMTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 17:34:55 +0000
Received: from BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a]) by BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a%4]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 17:34:55 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>, Jerin Jacob
 <jerinjacobk@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "Marchand, David" <david.marchand@redhat.com>, "nipun.gupta@amd.com"
 <nipun.gupta@amd.com>, "chenbox@nvidia.com" <chenbox@nvidia.com>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>, 
 "harry.chang@intel.com" <harry.chang@intel.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: RE: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Topic: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Index: AQHb5+hQTKfpvceKnEijI2kY71ZrfrQbcGgAgAAgywCAAAeCgIAAS4OQgAAKWgCAAAjpMA==
Date: Mon, 30 Jun 2025 17:34:55 +0000
Message-ID: <BL1PR11MB54613D5082A1DACD884D8F3AF446A@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
 <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
 <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <47e87bef-a862-495c-ad96-fb82c840f443@lysator.liu.se>
In-Reply-To: <47e87bef-a862-495c-ad96-fb82c840f443@lysator.liu.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_|IA1PR11MB7890:EE_
x-ms-office365-filtering-correlation-id: 33f3b10d-62dd-4b58-0fea-08ddb7fc6d73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TTA4a1l2Wk1aNkJ0TVU3RG9tbFFOUEEzdmw4d2FxUG9wMUNtVm9pNU85cXVR?=
 =?utf-8?B?L3NVb2EybVdpWEFDdXNscWh5dkhObWVUcldoVEVpcnVYRy80a2ZSL1ZCdits?=
 =?utf-8?B?d2NxUUZTZG5DWkc3ZUdkMC84c0hvaEJZY0F5T3dMdDRJQzJ1Z01jOWk3NDRr?=
 =?utf-8?B?ckFZbmJzeERmOTJ5OGhVcmJQcjFLK3FmWFVTRzY4ZFpjQUdZTUd5VGlLdzVq?=
 =?utf-8?B?TndUQytjZC9oWi9yYy9WMzZqcjQxUHBpRjlmbFdNS25sM1YwaWZTcHhxTUtO?=
 =?utf-8?B?WVBqNHBvMUxzNHZlQ1RYRklkLzcrMGNlU1I5MkUvazF1c0MrUUV2MThscDVR?=
 =?utf-8?B?SjJsTDNmVDdzbHd4WENuN2FpQlRPcFNKTFFwL29lQ1dHUVViQ3M3aDJNcnlQ?=
 =?utf-8?B?ZmowSHVnV2VFZm41K3ZWQjJvbEdPaTk1b24zU043aFdUaFUwWkFPNlNrMUJE?=
 =?utf-8?B?NlZSWTZhdnZtay8vaUdDTmZKakc2V3MrUVoxaVhXTUpWOWNXWG5vcGFBaXNn?=
 =?utf-8?B?MFluek5GNFBuZ1ZoejlnOWpCSlVjWHJDWllQM0k4SUJ5bEtFVlpuWFEzRXNB?=
 =?utf-8?B?VG5GWFBWb2o5dFNtV2Z6Z0gyU01lbHRTamlRSXBWOWV6Wk40bjRvUHVhQnFR?=
 =?utf-8?B?aEhrNmpITHQzYWdWaHdvaFQvTGlWRGg0TDhFSDZkcytDbld3YzVINEpYb1JK?=
 =?utf-8?B?dmpNL3h2a0h3aVYrUEZyU1BJQ2VNblVkTWxFWlloalZRMFdTanZKSXFmY0gy?=
 =?utf-8?B?L1MxMUMxTzVES255N2M5RnJ2ZnFKdzBaakJheVZONng4UlJLS2J6RXhjemtU?=
 =?utf-8?B?akNvYmxucjVyMzY5NWZrNmRKbzQ4NFM0OVJsVERJVlZ0ZC9NVGlVR2JYL2hB?=
 =?utf-8?B?RUtYdW4rdnlzSGcrRktOM3lzbWlvcWxnaWhjM3hYTjJRdmsyQVUyQk5lOEhO?=
 =?utf-8?B?WlhsRzNoN0k3ckxZV0lKUWNsaDdOQXdsOG96Z3BFWnpRMzRRR0ZoNzY3amxU?=
 =?utf-8?B?SGFjM0FnSnI1enhrMmRmZEZ2WEIrVkpoVkxSMFVTQ1puN0YvMHV2WHdHLzI3?=
 =?utf-8?B?VjFpV3ZjYml4SVNpc0d5YXZ3anVhSklnbHVmMWt0RnVDamZkcG1DRytVSkE0?=
 =?utf-8?B?NmtZWEJXZHJmaE03bzlsZy8wZDZ5bnBwdmk1bTZWLzQvU05ienRsMVR6U1NO?=
 =?utf-8?B?MzZUdTVBb0VTNnNFdGd4SFNuMlBMWDg2bmNVQm5ieEdIdHdtamV1L21wUW5I?=
 =?utf-8?B?amd1RTRxMFEyRzNkeTMwYkdUb1M4NElnZXNBTi82K3JNbFMyVllPVkJlVSs2?=
 =?utf-8?B?aVNCRkJZMG4rVkJIaERxNlFuWjdDSUpMM1UrcGs2WUR6aXMva0JSOXFFMkk0?=
 =?utf-8?B?Tk12VE9jRTROM2l4bEdNYkJyRERmVnNiZWJ4MFF5L2xvMmkvanR5dnBWM0pK?=
 =?utf-8?B?NE5JTmZpeW50UUdueGp0dHE0S0FiRHlVQmVmVDFOcVkrN1hZa2p0dlR6aTUr?=
 =?utf-8?B?anpVU0ZxeXlXbkhGZ3VHTkFDNnlMYnRsQmJZdHFVeXlab1BIc3p0UzNjZnEy?=
 =?utf-8?B?UWdBdjAxblFlWVljN09MeWp6dzNOcDhtVTRuMS9RT05Qb1dLaWxvbGVyOFgx?=
 =?utf-8?B?L2E0anp6YytNZnlLTDBxUlFWTU1UYWgzWGMwZFZFVHl2OE93VlpvZy9OUHI0?=
 =?utf-8?B?cHdzbUthdE9xOVBtcnFQVGgyZkhoT0pKNHJ4QmJjNThvd3pHbGR6dUNpcWcr?=
 =?utf-8?B?dEw5Mm5hb0o4WmNwb1pDUE1PZ0lGN01qVjJYeTJiTE1kMkRQTE9mdGlJR3dh?=
 =?utf-8?B?TityZVVIV2Ewc1o1ZU9IM2d2ellXemVXdEhIZThtcGhTMFM1OCsrRHB0RmUw?=
 =?utf-8?B?VUpJanNaTGZMa3RXb1MyTk9WQThHcGhYZzRTLzZFNktwNi9MZFV5YXNVMFdM?=
 =?utf-8?B?bGxRaUhCUzU2TDRIdy8zU2Y4b0VxNG5kY21EbXo1S0Fxa255N0xXYlZ5VnV3?=
 =?utf-8?Q?PP5LkzvWcRLKBcH1x+OoDGOnm4sOq8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUYyZFVHZXBtdTRmNk43RHEyUlcvYmhWV243UDlNV3U1NXR1VTRFb2lXZ2VS?=
 =?utf-8?B?V1kyd3hHck8vdXQwTkFKMnJ4ZVUvbHRhRnFxdnRPcU5renRncUdZRUNDcSts?=
 =?utf-8?B?SjdZbWtJQ3FtTDJFTFhWd2FWUGRuaWNodnBBS1czUVRQdnRMTFlwMzlmVEk2?=
 =?utf-8?B?ZzFvN2xRNVlORjBORnFQZ3l0QTFJWElvbDNRTHF0T0xrOExTYy9lRVdCMjBL?=
 =?utf-8?B?bnBqQ1Y0N0FwWEJ2SWZtWGpBdWcrRFM3Y0dJRmNFdW5wd1gzaUd2REJ1Rjh1?=
 =?utf-8?B?SUdxb1ZSb0JJc05OeDdrZjVmc0FGd2d3ajVKRkNPRHorNm1jQkp0bFg2eklH?=
 =?utf-8?B?bGVnSEpNOEtQamFkbllkczVCTkN3ZjZVV0NhR09FeWtaOXRjYjlzVDRWYk4v?=
 =?utf-8?B?YkFoN005SnlESlFOV2xCWC9xMW9PM2hwb25acitmNGJFelRKNkVNNUVzcVUw?=
 =?utf-8?B?bk5KREJqbjZvS2pnVkRLVklhQUhGUDFUdW1jTkxkZGZXOUsyQ092L0ZkY3lI?=
 =?utf-8?B?c0JnM0lyNVJ4NzM2MFBTQmtKZXBvcUVhMVRlL0luRGdMYmNiRTROZklnUDI1?=
 =?utf-8?B?c3ZNR2VkZ1pGdmtSTSswZG54eFNnVHBzSHB3M2ZBZzVwaStkZFFnbWJIOTBk?=
 =?utf-8?B?ZzdTczhxVERCNjJsN0lJV0cxczEvL25XK0tzS2FKQW9WSkZSY2J4VHNkbVor?=
 =?utf-8?B?aXcyVVlReVIxbFk5QmpPSG5ZeVA0MHZMMEFxb3NjVWpiQmZHSUxBYUY0cGdi?=
 =?utf-8?B?a0U2Z2dxZGpTcnMya0F4cmZkSTZaMzY3N2tLODZPRVg3Q3pwSXRnZE12VDI5?=
 =?utf-8?B?Q2hXM0s0ckhYRGhsQnFiRGJsNEJmSFhhZXd2UUFtMDFQU2FJaEs4UkhhTzJP?=
 =?utf-8?B?VENYS3lnK3c4YUpwaGppKzRacWU4b0hkdk41cGgrUEplSkJrVFFkb1piWHJt?=
 =?utf-8?B?WG1UNWxWSjRINXJub3RhMDhTbTZ4Z2V0YVFrQXdVTUUxVGdlckFXVEZEc2VV?=
 =?utf-8?B?bE93V1ZBaFcxQ1lzY2k0YXZ0dTQ5dVptVE9qcWtmNjVJemU2QmZzNU85eUxs?=
 =?utf-8?B?di8rQjlMdXpScFpkcXdaZW83UWsrdWNweVEreTVmZURISlhodmMwYm9HTFJw?=
 =?utf-8?B?MnhucnRLMWFkVHRsdElwdExiZStOVFZ6NjBOZlhBYTJ1Z0swRGRlL1RWZ1c5?=
 =?utf-8?B?N0ZRUys2QzhUU2FSRUlmMEEzRUI1Z1pqTUZaVU9SNFJGUEdkN1VmcnhwV1BT?=
 =?utf-8?B?em9PWlR0T05MRnZ4Z3ZNNDRUM3A0U0xFR2VsOU13YTk1WGVwMlhZVnc1cXgr?=
 =?utf-8?B?UTh6ZkhTM05vbzRqYkFLT0JqckczbW9RVUlhd29YU1MxSnZCMGJlNkhEOTJz?=
 =?utf-8?B?WmZIand3MTM4N3p4UVhLQnNJajZTRmcvUGpiMGhLNEp2VFUvRlNLdDNzd3Jn?=
 =?utf-8?B?cEdveHNtc0dmTG9oQjdsT1IvNnNva0FYT045TW5oRDNpeDcyZzV0Q0F1bWxs?=
 =?utf-8?B?MElDMTBXRGxldXRrcWJvZUd2aTA5SkZVRUxqYnNUNUZqanQ4aXlaL3FGQUY5?=
 =?utf-8?B?eThYN2dpVm1MV3pGdVVHQVJDalk3V3pVNjVYYlhEM3lNdGNCQ3FXcHlDSEU3?=
 =?utf-8?B?Y1cveER4dVdVTXVXcUxOUUk4ZkJlTENmR1JEU09WMi84SzBuM3kxRzJpTUF3?=
 =?utf-8?B?UjV4VmkyZTJzREJuYUtHNUtFL0pPV3B4V1l1bWlJd1pRY1hqaXh2WXdxVksw?=
 =?utf-8?B?Z2NjZFZEem02Q2cxcFF2VkR4eVhiT0pKdnh1TmQ1d29JaDJvdlBCdy9Ba1Ir?=
 =?utf-8?B?WUhhVFdNdy9HY1o5amZld0lMcTUrdCtEeEMralUrVStsV1NubUsyUkZ0YURv?=
 =?utf-8?B?OXpIbitCL3hUVmxwSnl4eGljcDFINHovdWk5SW1wUkNXY0J1bmROU1B4dSt0?=
 =?utf-8?B?QmYxcFE2UHYvczFqdTBFWXJXY1ZBZG9xclhyUlR5d1docm51QkdiVVdiM0o5?=
 =?utf-8?B?c240TFNRRUZyWlREWUZ0MlYwZERtQlNxTWxGOW9UK0MrT2lhd1JhY0hkMEkx?=
 =?utf-8?B?YVFLMXBjSDRKMXJwZGpRazE1WTFXZERIZDh3SWdyOFd5SnpTNXY1M1gvNk8x?=
 =?utf-8?Q?3O6iOZpN3QVRctovkVEYR8AIE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f3b10d-62dd-4b58-0fea-08ddb7fc6d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 17:34:55.2181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmzLNYJFVdNNbpB0vTWC3Tel/cZ4ef+DH9Y+fjjP3AzYaoRxHTZF6fDnBZCGvlJ0UhRZRdqyY0WXxtn4PZjKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDMwLCAyMDI1
IDEyOjUxIFBNDQo+IFRvOiBQYXRoYWssIFByYXZpbiA8cHJhdmluLnBhdGhha0BpbnRlbC5jb20+
OyBKZXJpbiBKYWNvYg0KPiA8amVyaW5qYWNvYmtAZ21haWwuY29tPg0KPiBDYzogZGV2QGRwZGsu
b3JnOyBqZXJpbmpAbWFydmVsbC5jb207IENoZW4sIE1pa2UgWGltaW5nDQo+IDxtaWtlLnhpbWlu
Zy5jaGVuQGludGVsLmNvbT47IFJpY2hhcmRzb24sIEJydWNlDQo+IDxicnVjZS5yaWNoYXJkc29u
QGludGVsLmNvbT47IHRob21hc0Btb25qYWxvbi5uZXQ7IE1hcmNoYW5kLCBEYXZpZA0KPiA8ZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT47IG5pcHVuLmd1cHRhQGFtZC5jb207DQo+IGNoZW5ib3hA
bnZpZGlhLmNvbTsgU2Fya2FyLCBUaXJ0aGVuZHUgPHRpcnRoZW5kdS5zYXJrYXJAaW50ZWwuY29t
PjsgUGF2YW4NCj4gTmlraGlsZXNoIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+OyBTaGlqaXRo
IFRob3R0b24NCj4gPHN0aG90dG9uQG1hcnZlbGwuY29tPjsgSGVtYW50IEFncmF3YWwgPGhlbWFu
dC5hZ3Jhd2FsQG54cC5jb20+Ow0KPiBTYWNoaW4gU2F4ZW5hIDxzYWNoaW4uc2F4ZW5hQG9zcy5u
eHAuY29tPjsgaGFycnkuY2hhbmdAaW50ZWwuY29tOw0KPiBNYXR0aWFzIFLDtm5uYmxvbSA8bWF0
dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGV2
ZW50L2RsYjI6IGFkZCBkZXF1ZXVlIGludGVycnVwdCBtb2RlIHN1cHBvcnQNCj4gDQo+IE9uIDIw
MjUtMDYtMzAgMTg6MTgsIFBhdGhhaywgUHJhdmluIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmVyaW4gSmFjb2IgPGplcmluamFj
b2JrQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKdW5lIDMwLCAyMDI1IDc6NDQgQU0N
Cj4gPj4gVG86IE1hdHRpYXMgUsO2bm5ibG9tIDxob2ZvcnNAbHlzYXRvci5saXUuc2U+DQo+ID4+
IENjOiBQYXRoYWssIFByYXZpbiA8cHJhdmluLnBhdGhha0BpbnRlbC5jb20+OyBkZXZAZHBkay5v
cmc7DQo+ID4+IGplcmluakBtYXJ2ZWxsLmNvbTsgQ2hlbiwgTWlrZSBYaW1pbmcgPG1pa2UueGlt
aW5nLmNoZW5AaW50ZWwuY29tPjsNCj4gPj4gUmljaGFyZHNvbiwgQnJ1Y2UgPGJydWNlLnJpY2hh
cmRzb25AaW50ZWwuY29tPjsgdGhvbWFzQG1vbmphbG9uLm5ldDsNCj4gPj4gTWFyY2hhbmQsIERh
dmlkIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsNCj4gbmlwdW4uZ3VwdGFAYW1kLmNvbTsN
Cj4gPj4gY2hlbmJveEBudmlkaWEuY29tOyBTYXJrYXIsIFRpcnRoZW5kdSA8dGlydGhlbmR1LnNh
cmthckBpbnRlbC5jb20+Ow0KPiA+PiBQYXZhbiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUBtYXJ2
ZWxsLmNvbT47IFNoaWppdGggVGhvdHRvbg0KPiA+PiA8c3Rob3R0b25AbWFydmVsbC5jb20+OyBI
ZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47DQo+ID4+IFNhY2hpbiBTYXhl
bmEgPHNhY2hpbi5zYXhlbmFAb3NzLm54cC5jb20+OyBoYXJyeS5jaGFuZ0BpbnRlbC5jb207DQo+
ID4+IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0aWFzLnJvbm5ibG9tQGVyaWNzc29uLmNvbT4NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZXZlbnQvZGxiMjogYWRkIGRlcXVldWUgaW50ZXJy
dXB0IG1vZGUNCj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiBNb24sIEp1biAzMCwgMjAyNSBh
dCA0OjQ34oCvUE0gTWF0dGlhcyBSw7ZubmJsb20NCj4gPj4gPGhvZm9yc0BseXNhdG9yLmxpdS5z
ZT4NCj4gPj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gT24gMjAyNS0wNi0zMCAxMToxOSwgSmVyaW4g
SmFjb2Igd3JvdGU6DQo+ID4+Pj4gT24gU2F0LCBKdW4gMjgsIDIwMjUgYXQgMTE6MTfigK9BTSBQ
cmF2aW4gUGF0aGFrDQo+ID4+IDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT4gd3JvdGU6DQo+ID4+
Pj4+DQo+ID4+Pj4+IERMQjIgcG9ydCBpbnRlcnJ1cHQgaXMgaW1wbGVtZW50ZWQgdXNpbmcgRFBE
SyBpbnRlcnJ1cHQgZnJhbWV3b3JrLg0KPiA+Pj4+PiBUaGlzIGFsbG93cyBldmVudGRldiBkZXF1
ZXVlIEFQSSB0byBzbGVlcCB3aGVuIHRoZSBwb3J0IHF1ZXVlIGlzDQo+ID4+Pj4+IGVtcHR5IGFu
ZCBnZXRzIHdha2V1cCB3aGVuIGV2ZW50IGFycml2ZXMgYXQgdGhlIHBvcnQuIFBvcnQgZGVxdWV1
ZQ0KPiA+Pj4+PiBtb2RlIGlzIGNvbmZpZ3VyZWQgdXNpbmcgZGV2YXJncyBhcmd1bWVudCBwb3J0
X2RlcXVldWVfd2FpdC4NCj4gPj4+Pj4gU3VwcG9ydGVkIG1vZGVzIGFyZSBwb2xsaW5nIGFuZCBp
bnRlcnJ1cHQuIERlZmF1bHQgbW9kZSBpcyBwb2xsaW5nLg0KPiA+Pj4+PiBUaGlzIGNvbW1pdCBh
bHNvIGFkZHMgY29kZSB0byBoYW5kbGUgZGV2aWNlIGVycm9yIGludGVycnVwdHMgYW5kDQo+ID4+
Pj4+IHByaW50IGFsYXJtIGRldGFpbHMuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6
IFByYXZpbiBQYXRoYWsgPHByYXZpbi5wYXRoYWtAaW50ZWwuY29tPg0KPiA+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBUaXJ0aGVuZHUgU2Fya2FyIDx0aXJ0aGVuZHUuc2Fya2FyQGludGVsLmNvbT4NCj4g
Pj4+Pj4gLS0tDQo+ID4+Pj4+ICAgIGRvYy9ndWlkZXMvZXZlbnRkZXZzL2RsYjIucnN0ICAgICAg
ICAgICAgICB8ICAyMCArDQo+ID4+Pj4+ICAgIGRyaXZlcnMvZXZlbnQvZGxiMi9kbGIyLmMgICAg
ICAgICAgICAgICAgICB8IDIzNiArKysrKy0NCj4gPj4+Pj4gICAgZHJpdmVycy9ldmVudC9kbGIy
L2RsYjJfaWZhY2UuYyAgICAgICAgICAgIHwgICA3ICsNCj4gPj4+Pj4gICAgZHJpdmVycy9ldmVu
dC9kbGIyL2RsYjJfaWZhY2UuaCAgICAgICAgICAgIHwgICA4ICsNCj4gPj4+Pj4gICAgZHJpdmVy
cy9ldmVudC9kbGIyL2RsYjJfcHJpdi5oICAgICAgICAgICAgIHwgIDE4ICsNCj4gPj4+Pj4gICAg
ZHJpdmVycy9ldmVudC9kbGIyL2RsYjJfdXNlci5oICAgICAgICAgICAgIHwgMTEyICsrKw0KPiA+
Pj4+PiAgICBkcml2ZXJzL2V2ZW50L2RsYjIvcGYvYmFzZS9kbGIyX2h3X3R5cGVzLmggfCAgNzAg
KysNCj4gPj4+Pj4gICAgZHJpdmVycy9ldmVudC9kbGIyL3BmL2Jhc2UvZGxiMl9vc2RlcC5oICAg
IHwgIDQ2ICsrDQo+ID4+Pj4+ICAgIGRyaXZlcnMvZXZlbnQvZGxiMi9wZi9iYXNlL2RsYjJfcmVn
cy5oICAgICB8IDE0OSArKystDQo+ID4+Pj4+ICAgIGRyaXZlcnMvZXZlbnQvZGxiMi9wZi9iYXNl
L2RsYjJfcmVzb3VyY2UuYyB8IDgyNQ0KPiA+PiArKysrKysrKysrKysrKysrKysrKysNCj4gPj4+
Pj4gICAgZHJpdmVycy9ldmVudC9kbGIyL3BmL2Jhc2UvZGxiMl9yZXNvdXJjZS5oIHwgICA2ICsN
Cj4gPj4+Pj4gICAgZHJpdmVycy9ldmVudC9kbGIyL3BmL2RsYjJfcGYuYyAgICAgICAgICAgIHwg
MjIzICsrKysrKw0KPiA+Pj4+PiAgICAxMiBmaWxlcyBjaGFuZ2VkLCAxNzExIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kb2MvZ3Vp
ZGVzL2V2ZW50ZGV2cy9kbGIyLnJzdA0KPiA+Pj4+PiBiL2RvYy9ndWlkZXMvZXZlbnRkZXZzL2Rs
YjIucnN0IGluZGV4IDhlYzcxNjhmMjAuLmE0YmE4NTczNTENCj4gPj4gMTAwNjQ0DQo+ID4+Pj4+
IC0tLSBhL2RvYy9ndWlkZXMvZXZlbnRkZXZzL2RsYjIucnN0DQo+ID4+Pj4+ICsrKyBiL2RvYy9n
dWlkZXMvZXZlbnRkZXZzL2RsYjIucnN0DQo+ID4+Pj4+IEBAIC00NzcsNiArNDc3LDI2IEBAIEV4
YW1wbGUgY29tbWFuZCB0byB1c2UgYXMgbWVzb24gb3B0aW9uDQo+IGZvcg0KPiA+PiBjcmVkaXQg
aGFuZGxpbmc6DQo+ID4+Pj4+DQo+ID4+Pj4+ICAgICAgICAgICBtZXNvbiBjb25maWd1cmUgLURj
X2FyZ3M9Jy1ERExCX1NXX0NSRURJVFNfQ0hFQ0tTPTAgLQ0KPiA+PiBERExCX0hXX0NSRURJVFNf
Q0hFQ0tTPTEnDQo+ID4+Pj4+DQo+ID4+Pj4+ICtJbnRlcnJ1cHQgTW9kZSBTdXBwb3J0DQo+ID4+
Pj4+ICt+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4+Pj4+ICtETEIgZGVxdWV1ZSBzdXBwb3J0
cyBpbnRlcnJ1cHQgbW9kZSBmb3IgdGhlIEFQSQ0KPiA+PiBydGVfZXZlbnRfZGVxdWV1ZV9idXJz
dCgpLg0KPiA+Pj4+PiArVGhlIGRlZmF1bHQgcG9ydCBkZXF1ZXVlIG1vZGUgaXMgcG9sbGluZy4g
RGVxdWV1ZSB3YWl0IG1vZGUgY2FuDQo+ID4+Pj4+ICtiZSBjb25maWd1cmVkIG9uIHBlciBldmVu
dGRldiBwb3J0IGJhc2lzIHVzaW5nIGRldmFyZ3MgYXJndW1lbnQNCj4gPj4+Pj4gKydwb3J0X2Rl
cXVldWVfd2FpdCcuIEluIGludGVycnVwdCBtb2RlLCBpZiB0aGUgcG9ydCBxdWV1ZSBpcw0KPiA+
Pj4+PiArZW1wdHksIHRoZSBhcHBsaWNhdGlvbiB0aHJlYWQgd2lsbCBibG9jayBvbiB0aGUgaW50
ZXJydXB0IHVudGlsIGENCj4gPj4+Pj4gK25ldyBldmVudCBhcnJpdmVzLiBJdCBlbnRlcnMgYmxv
Y2tpbmcgbW9kZSBvbmx5IGFmdGVyIGFueQ0KPiA+Pj4+PiArc3BlY2lmaWVkIHRpbWVvdXQuIER1
cmluZyB0aGUgdGltZW91dCwgaXQgd2lsbCBwb2xsIHRoZSBwb3J0DQo+ID4+Pj4+ICtxdWV1ZSBm
b3INCj4gPj4gZXZlbnRzIGFzIHVzdWFsLiBJbnRlcnJ1cHQgbW9kZSB1c2VzIHRoZSBEUERLIGlu
dGVycnVwdCBzdXBwb3J0DQo+IGZyYW1ld29yay4NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICAgIC4u
IGNvZGUtYmxvY2s6OiBjb25zb2xlDQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgICAgICAtLWFsbG93
IGVhOjAwLjAscG9ydF9kZXF1ZXVlX3dhaXQ9YWxsOmludGVycnVwdA0KPiA+Pj4+DQo+ID4+Pj4g
QWRkaW5nIG90aGVyIGV2ZW50ZGV2IFBNRCBtYWluYXRhaW5lcnMuDQo+ID4+Pj4NCj4gPj4+PiBM
b29rcyBsaWtlIGl0IGNhbiBiZSBhIGdlbmVyaWMgZmVhdHVyZS4gaS5lIHNldCB0aGlzIG9wdGlv
biBpcw0KPiA+Pj4+IGRldl9jb25maWd1cmUoKSBJZiB0aGVyZSBpcyBubyBvYmplY3Rpb24sIFBs
ZWFzZSBzZW5kIGEgbmV3IHBhdGNoDQo+ID4+Pj4gYXJvdW5kDQo+ID4+IHRoYXQuDQo+ID4+Pg0K
PiA+Pj4gSSd2ZSBjb25zaWRlcmVkIGltcGxlbWVudGluZyB0aGlzIGluIERTVywgYWx0aG91Z2gg
aW4gYSBkaWZmZXJlbnQNCj4gPj4+IG1hbm5lciAod2l0aCBldmVudGZkcyBhbmQgcG9sbCgpKS4N
Cj4gPj4+DQo+ID4+PiBUaGUgZGVxdWV1ZSB0aW1lb3V0IHdpbGwgc3RpbGwgYmUgaG9ub3JlZCBp
biAiaW50ZXJydXB0IG1vZGUiLCBjb3JyZWN0Pw0KPiA+Pj4gSXQgd2Fzbid0IG9idmlvdXMgZnJv
bSB0aGUgZGVzY3JpcHRpb24uDQo+ID4+DQo+ID4+IEhvdyBpcyBpdCBpbiBJbnRlbCBQTUQ/DQo+
ID4NCj4gPiBJdCB3b3VsZCBiZSBiZXN0IGlmIHdlwqBjb25maWd1cmUgaXQgcGVyIHBvcnQgdXNp
bmcgUlRFX0VWRU5UX1BPUlRfQ0ZHXyoNCj4gZmxhZ3MuIFdpbGwgaXQgYmUsIE9LPw0KPiA+IFRo
ZSBkZXF1ZXVlIHRpbWVvdXQgd2lsbCBiZSBob25vcmVkLCBhbmQgdGhlwqBkZWNpc2lvbiB0byBi
bG9jayBvciByZXR1cm4NCj4gd2lsbCBiZSBtYWRlIGFmdGVyIHRoZSB0aW1lb3V0Lg0KPiANCj4g
VGhhdCBkb2Vzbid0IHNvdW5kIGxpa2UgdGhlIHRpbWVvdXQgaXMgaG9ub3JlZC4NCj4gDQo+IFRo
ZSByZWFzb24gYW4gYXBwbGljYXRpb24gd2FudHMgdGhlIGRlcXVldWUgY2FsbCB0byBjb21wbGV0
ZSB3aXRoaW4gYSBjZXJ0YWluDQo+IHRpbWUsIGV2ZW4gdGhvdWdoIHRoZXJlIHdhc24ndCBhbnkg
ZXZlbnRzLCBpcyBsaWtlbHkgYmVjYXVzZSBpdCB3YW50IHRvIGdvIGRvDQo+IHNvbWV0aGluZyBl
bHNlIHdpdGggdGhhdCB0aHJlYWQsIGFmdGVyIHRoZSB0aW1lb3V0Lg0KPiANCj4gVGh1cywgeW91
IGNhbid0IGRlY2lkZSB0byBibG9jayB0aGUgdGhyZWFkICphZnRlciogdGhlIHRpbWVvdXQuIElm
IHlvdSBibG9jaywNCj4geW91IGhhdmUgdG8gZG8gc29tZSB0aW1lICpiZWZvcmUqIHRoZSB0aW1l
b3V0LCBhbmQgd2FrZSB1cCBpbiB0aW1lIHRvIG1lZXQNCj4gdGhlIGRlYWRsaW5lLg0KPiANCj4g
Rm9yIGV4YW1wbGUsIGlmIHRoZSBldmVudCBkZXZpY2UgaXMgZ2l2ZW4gYSAxIG1zIGRlcXVldWUg
dGltZW91dCBieSB0aGUNCj4gYXBwbGljYXRpb24sIGl0IGNvdWxkIGdvIGJ1c3ktcG9sbCBmb3Ig
MTAgdXMsIHRoZW4gYnVzeS1wb2xsIHdpdGggYSBzaG9ydCB0cGF1c2UNCj4gZm9yIDEwMCB1cywg
YW5kIHRoZW4gcHV0IHRoZSB0aHJlYWQgdG8gc2xlZXAgYmxvY2tpbmcgb24gc29tZSBmZCBmb3Ig
dGhlDQo+IHJlbWFpbmluZyA4OTAgdXMuDQo+IA0KPiBUaGUgaGFyZHdhcmUtc3BlY2lmaWMgbmF0
dXJlIG9mIHRoZSB0aW1pbmcgYW5kIGV4YWN0IG1lY2hhbmlzbSB0byB1c2UNCj4gc3BlYWtzIGFn
YWluc3QgaGF2aW5nIHRoaXMga2luZCBvZiBjb25maWd1cmF0aW9uIGluIHRoZSBFdmVudGRldiBB
UEkuDQoNClRoZSBtb2RlIGlzIG5vdCBmb3Igd2hhdCB0byBkbyBkdXJpbmcgYSB0aW1lb3V0LCBi
dXQgYWZ0ZXIgYcKgdGltZW91dC4gDQpXZSBjYW4gZW50ZXIgc2xlZXAgbW9kZSBpbW1lZGlhdGVs
eSBieSBzZXR0aW5nIHRoZcKgdGltZW91dCB0byAwIGlmIHdlIG5lZWQgdG8uIA0KVGhpcyBtb2Rl
IGlzIG5vdCBjaGFuZ2luZyB0aGXCoGN1cnJlbnQgdGltZW91dCBiZWhhdmlvci4gIEFmdGVyIHRo
ZSB0aW1lb3V0LCANCml0IGFsbG93cyBIVyBkZXZpY2VzIHN1cHBvcnRpbmcgaW50ZXJydXB0cyB0
byBibG9jayBvbiBhbsKgaW50ZXJydXB0Lg0KSXQgd2lsbCB3YWtlIHVwIG9ubHkgYWZ0ZXIgYcKg
bmV3IGV2ZW50IGFycml2ZXMgYXQgdGhlIHBvcnQuIElmIHRoZcKgYXBwbGljYXRpb24gbmVlZHMg
Y29udHJvbA0KYmFjayB0aGVuIGl0IGNhbiB1c2UgdGhlwqBjdXJyZW50IGRlZmF1bHQgbm9uLWJs
b2NraW5nIG1vZGUuIEEgYmV0dGVyIG1vZGUgdG8gc2F2ZSBwb3dlciBkdXJpbmcgdGltZW91dCAN
CndpbGwgYmUgdG8gdXNlIHVtd2FpdC1iYXNlZCBzbGVlcC4gIENvbnNpZGVyIHRoaXMgYXMgZXh0
ZW5zaW9uIHRvIGN1cnJlbnQgdGltZW91dCBiZWhhdmlvciBpZiBkZXZpY2UNCnN1cHBvcnRzIGlu
dGVycnVwdHMuDQoNCj4gDQo+ID4gSWYgbm90IGludGVycnVwdCwgaXQgY2FuIGJlIGNhbGxlZCBi
bG9ja2luZyB2cyBwb2xsaW5nIG1vZGUuICBJZiB0aGUgcG9ydCBjb25maWcgaXMNCj4gZmluZSwg
SSB3aWxsIGNyZWF0ZSBhwqBuZXcgcGF0Y2ggd2l0aCBpdC4NCj4gPiBBbHNvLCB3ZSBzaG91bGQg
aGF2ZSB0aGlzIGFzIGHCoGNhcGFiaWxpdHkgZm9yIGV2ZW50ZGV2cy4NCj4gPg0KPiA+Pg0KPiA+
Pj4NCj4gPj4+IFdoYXQncyBiZWluZyBjb25maWd1cmVkIHNob3VsZCBqdXN0IGJlIGEgdGhyZXNo
b2xkIHRpbWUgYXQgd2hpY2ggdGhlDQo+ID4+PiBldmVudCBkZXZpY2Ugd291bGQgZ28gZnJvbSBi
dXN5LXBvbGxpbmcgdG8gYmxvY2tpbmcgdGhlIHRocmVhZC4NCj4gPj4+DQo+ID4+PiBNYXliZSBp
dCBzaG91bGQgYmUgY2FsbGVkIHNvbWV0aGluZyB3aXRoICJibG9ja2luZyIgb3IgInNsZWVwaW5n
IiwNCj4gPj4+IGluc3RlYWQgb2YgImludGVycnVwdCIsIHNpbmNlIGludGVycnVwdHMgYXJlIG5l
dmVyIGRpcmVjdGx5IGludm9sdmVkLg0KPiA+Pg0KPiA+PiBBZ3JlZS4gb3IgbWFrZSBpdCBhIHBv
d2VyIHNhdmUgbW9kZSBvciBzby4NCj4gPj4NCj4gPj4+DQo+ID4+PiBBbnl3YXksIHNlZW1zIGxp
a2UgYSBnb29kIGNhbmRpZGF0ZSBmb3IgYSBnZW5lcmljIGZlYXR1cmUgdG8gbWUuDQo+ID4+Pg0K
DQo=
