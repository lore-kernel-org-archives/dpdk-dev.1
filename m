Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6749D47CD1
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 10:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E8642D7B;
	Fri, 16 Jan 2026 11:33:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 43E9F4060F;
 Fri, 16 Jan 2026 11:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768559616; x=1800095616;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6eeC9fwSAb379HdjtYRN0c19bmiPuyoUuk0jXxrDG9c=;
 b=cQrzwYWoM9MPUiCG2y6YcLAIzP8yGDZjQEDXR/ar3R8NQEJvfnU2yQh/
 GPBirs06+W8+0ASv3uzlqYpcCD7mjq+FtqtfERrztKBqsp+/FWPB0Rfi6
 UjKF99SplxmoxSIMVT7VShDeHwlaLUPTIGPJ3Ki1T0BlxZ8yDWufiVpqb
 og3gbM5H0S1e/bUSLuYpLh8snHwYLTd5z1g79JLbNKZkV3AW0EzU+D/9/
 MENDF7ihkiU04NxwrXS6abbW39P0eSyQySd1AfUIuS4h5F5emr3nfLMT8
 AawhZrtFnwIvfpDJ8BNHU3ODTPy2c9delW+wPURWTJtZggN5ZmZXhqDmp w==;
X-CSE-ConnectionGUID: hPqiwYC6QF6UEyTG4O9dNg==
X-CSE-MsgGUID: 9nYNu86KSTKwcfHC6ki1Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="68882330"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="68882330"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 02:33:34 -0800
X-CSE-ConnectionGUID: bAc5hpfAS7q2blEs8Urw5Q==
X-CSE-MsgGUID: 8IzFTHHIQkqZfC+/RXXgTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="209346510"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 02:33:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 02:33:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 02:33:33 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 02:33:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNZXZsVQTIF6P3pWVzwe1IAP/wt9aD8smI+xCtmVaKOttPbFcAUOk6GUs5NPJsfMmWdTafhl5XW6cttB4lLV0VdyYbrF2gtsBgE1dIZjZTo+MbSMw5XYGgfIUNcYZXZvkzmC3toHvaQDitpA2EVN/HSWKm0ZQAQDdHOMoleEo1NFHQaE5mBoV4H7R0z/g2jHSaGzRbFNE+iEXjtoNp1gRla1M0aZ25TgmtEYMis+Rgh9UYuo+IVG0ZOvmqtHgbSfqkRLEOoEtcEETz9VSf0orkdOu1Q8gJpUbOwt8QFVE2pKi0pMWtzO+AAfdOjfcGYDLoNz8gJLBvFlr+AJxwH9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eeC9fwSAb379HdjtYRN0c19bmiPuyoUuk0jXxrDG9c=;
 b=HgBNvZV0XWQhA5ckRV1noUz9vbwxyQlAeasyZlXcfqjPPOXgM1fIjrQ1QlAvt3BkGQOwlC1yWt4cR/Q78ApKMxfpzKrJ4KkGVluH71rH0Nh1BqVjYnhqRMxffUnzxy+kEFIW7tCAT8LrsmqxeAAKZsA2S/enPBippfZJ/2ZAIOl+bZM5siYZBOOCzXJOAEt7kyl0KSqXPhzpJOMMfRmFX1Y1n2SCXwQBW8S6riY6c9ilTdhqAxhUVJ9L7A/SYL2i36YnHfi+qzcltn8cRncPdGdCQHb0j2TEPDPvL4RZq0EUjrEBdoKgbO+kzlwTvmagDZPadwjhG1TWNGW7RfqOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by DS0PR11MB8051.namprd11.prod.outlook.com (2603:10b6:8:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 10:33:26 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 10:33:26 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Shani Peretz <shperetz@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Kevin
 Traynor" <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, "yuan.peng@intel.com"
 <yuan.peng@intel.com>, "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>
Subject: RE: 23.11.6 patches review and test
Thread-Topic: 23.11.6 patches review and test
Thread-Index: AQHcf7ygKoRkyWapY0aGVKMuSi4Oi7VUp1jw
Date: Fri, 16 Jan 2026 10:33:26 +0000
Message-ID: <IA3PR11MB9040224D2707117312E2DBE89F8DA@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <20260107100017.158232-1-shperetz@nvidia.com>
In-Reply-To: <20260107100017.158232-1-shperetz@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|DS0PR11MB8051:EE_
x-ms-office365-filtering-correlation-id: 357ba339-9ac6-477c-2819-08de54eaae9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?L2tGQWtVSnkzVjZ1VFl3UENrNi9ja2hKK3BTbEcyZXkzWG1rVFBrSzhWRFNQ?=
 =?utf-8?B?TC9FUFg0SjNvTVlwaFRrSy8zQTRHeFNiN2Q0a204ZWhOTFZ2eHJJUGJWc05K?=
 =?utf-8?B?bXVBeXA3TzZob1ZpVDBUYVMrVW1mOXlka3NHVWJKSUNJRVlKYk9nTXJoS3BZ?=
 =?utf-8?B?NVlxWE0vZlF2cnd0Ymd0NkxZY0I2WVNBN1NkZEpiajY2S3VpbFc5TWFkVlpM?=
 =?utf-8?B?OXVmT2dObC9rZi91MzhXNTk2NC9pVEgzMlNDL3orcnNKdWQrN1lEVTgzUzBx?=
 =?utf-8?B?TmxFU1E0c05UdGhRM1prRTRpS1ZCb3JnMWM4NnBKTzNHcUdycmhsU3hpSmIr?=
 =?utf-8?B?MjZtcGoyVFU3d1dEM3kvL1gvRFE0SmJKVEJmQmpyaU5wcW1tWU1WY2NXQktn?=
 =?utf-8?B?dS9RM05ON291R1lzSzRNNzRsUDVqYW5oc1EyMngwVGxya0lMWXBTempKTWIr?=
 =?utf-8?B?YklkRllpaE1CVkJHYUFXNXZNK1FHdVRsNlFDTCthUUx2Vm9tNjgvQmN2MXVS?=
 =?utf-8?B?Q0ZQK3VEaXpCN0RkdWo3RzNjMzF4ZFJPZmVDNHZkaDFWRXc4dDgvT09CN25H?=
 =?utf-8?B?MFErU2lHQWxCS1EwcGh6bFdQQTZmZkd2SWFxNVBWUXE2YnYvb01GeTA2RXlr?=
 =?utf-8?B?UEdueXpEWHlmMG1WbmpYL0w5Tit3a1ZkS1N3TFpaVk9FSlFDN09mRXdkSndl?=
 =?utf-8?B?NE1VMkdqRzRFUDAvQU9IT0ZYQUlwMmFZMGZsWGRXOTFMWXBPL0l3SjY4QzJB?=
 =?utf-8?B?cW5wUENET1RHUjl0NWQxQUU0Wm11RCtqSFdCRzJoQ3AwV2tkUm8rcHovWVhE?=
 =?utf-8?B?eGRZMDU5K1k3REdSaXNna01jd2RsRElxa1ZOUXgvcjRxTnlYeFZFVFkvUmVE?=
 =?utf-8?B?Z0tUcHQ4VDZ6a2lwZnpIYkFTUlNaS2tSaTdHMC9XcmQyUkFwRkREOTdUR1FP?=
 =?utf-8?B?bTZxNi96ZVJNd0F1TFpTaTh5RnFvbXptNlFJbm5PMWRlOFIvQVNQSUw1Y084?=
 =?utf-8?B?RjRUbWtzVlFOT1VYclNFMDhBTVRybVNiRkhVZlRuNUYrYXVuTUFJUTQzQUtu?=
 =?utf-8?B?bzJsdzFXS2RITzgwUFBZeVdFWnVGL3A2U0Q5VjMveHNtazhzaWozSVRnNHpL?=
 =?utf-8?B?UTNVZW5IYktvQjJWMThwOHRhQVlzaEsraGdHbFNucHFpVkU4L1NzWnduRU1s?=
 =?utf-8?B?MTJwcTExbGZPZ0JtcHhwNTl1U0IwV0FkczIrQS9tbVhTcnZlZTVCVGowTmM5?=
 =?utf-8?B?T0lJVmI4ZVpmTFQ2L01iT29aWHJlY1BNUmM2YzZISThka1lXMmZrR3JwWWU3?=
 =?utf-8?B?QlJzZDRaWC8zK0FMTUp4Y2JON0hNNFY2a1EzYzFFWi9IVUFDVjFseVRVY1VO?=
 =?utf-8?B?OEZaWEEzVksrbCtwbnVIOTA1aGRINm9rVWwwendxOTVmNVNrS1ZIdFF5TGd1?=
 =?utf-8?B?eXFtT1N2a3hhZFpTWjZ5emxPYnRmdVVsRW9WSXUwMWkxcmF3c2g2TU93aG1Y?=
 =?utf-8?B?TndLU0M0SkxFajhqZTg0eEViUFpHOW4rREJhNEw4TGxjRW5XZXY2T3BlbzhY?=
 =?utf-8?B?TTRSYWt6U2pWMnRvYzkrWW8vUVR1eVVMUHdka0l5WjZ5VVBqbTRybEVCeUUy?=
 =?utf-8?B?Vy9UanF3N08rSTV0ODluYzRHZTdjMjlmd1gwNE5teTd2SGg1TXh3OTlNYUl0?=
 =?utf-8?B?ZmxraVZPOHZtMXEyN3dJQ3V0OTEzMi9TYXM2ZFdpOWZYWnk0TVlCbStGOWM3?=
 =?utf-8?B?bkxDQ1ZML1U2Umt2Ym1KQ3ZjSEtjQW1vSTh6TjRJVms1eHZKZmdQY3pJY200?=
 =?utf-8?B?V3JCNTFRNE1CdHd5NzE2T05LM0tOaWFLZngrUWpvckkrVWN1UE5PTFBhWm1q?=
 =?utf-8?B?UnQxRE1jTWhROTYyVWY2S3RLZlR5R2J6eDdYcFZGY3FEUVRNTTlQUk1yKzBT?=
 =?utf-8?B?WVlqWDhadE9vdGIwK2VEVFhDRHRiMThaYnZNSmxWTFM0YUlIbTZHODl0eGdW?=
 =?utf-8?B?QjRGZHFRa0t0NnlRZ2VvREJPaGk5RlZVT3VHUER5ODFrYkQ3WXUzVjB5Qitr?=
 =?utf-8?B?TWlISytobDEzcGlkQjB0Ym5Vd0t0YTA3R0srY3J0LzJLNi9MOGdLYVZXWkxT?=
 =?utf-8?B?VG1RdzRnWGZlVzhHY2ZTVHlYcEI1eTUwUDBsVWFJUUVvUXpFc1hLa0NiZFhS?=
 =?utf-8?Q?rHgjr+rkWp1LiLnKiUxC1PCC1EeIS0vYLZKE5qOhsfkL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNrclBWRGl5QTkwa0NWam1kZzVEZXl5YVQyRktWSWx4V2g5bDZYNng4akhZ?=
 =?utf-8?B?ZnpaT2NVd2hHUnhGbFZ3Mk1NWkFPaWlmcHQ5YXZqMTh1d1pFb0N6ekl5WnQx?=
 =?utf-8?B?cXJrMmNBNVQvbWJ4VGE0b0xheE5zYzkwdXRsYlFjbm56TmlaYzJQVWVYakVL?=
 =?utf-8?B?d05kRlM3WUphK1VESVlWVjdYSlkvS2NRdDFDQ29OdjNYWmFmVERlL1VOTDN1?=
 =?utf-8?B?dHVwM2pVM01aQjdjMDVHWEc4dnM2bTB2QnhtZW0ycnNHU3RjOGRML3ZCTE0z?=
 =?utf-8?B?MnkwOXFvNmduVnYzSnNNdEtTZVpLRHE0blEwT09ORGJZR1lseE52TE5wUjBY?=
 =?utf-8?B?Wkd2QmxrSGNvSGJTNFhGWlJ5TU8xSlRMQ0ttYTRrcHJlTWc0QW8xS01kRjUx?=
 =?utf-8?B?QnVlZ29IY2EvdzJTM2dZV2hnNEkyZEtFL3llVWowN3Nrd1ZTcUkwMmE1Tis2?=
 =?utf-8?B?dDRPNzRxTVkzeW1nelA1aTBqemtLMjZVSUViZWxFeU9QWEk2em82VG9yUVlj?=
 =?utf-8?B?NFU2TWVPVVFhMG4wTnQ0OXQ5OUpuMjlDTHdIQm5ONEsxWFVZek1sbWVoZGFo?=
 =?utf-8?B?eXU1Q2h5SGJSUmtNZWlhaU5sZ29FSUVSSE84akFDNVJPN0p5MUJGMUR0TU13?=
 =?utf-8?B?eUdzTW9GYjlHVi9LcnRoOTdkNG5DZnBHMFY3bWQ3WmYyNGNwU0lxTElUUWsy?=
 =?utf-8?B?dy80QllhRitjUElCWnI1aFBlTUROK2hxNS9RZlpXOXNGT3ZValVCZmJjc285?=
 =?utf-8?B?b2NIMjFWem9yUnpDUkZ1MmFjS1I0SGZoZTdRdUtaYjRJVU1FKzNWSHZ2VjJr?=
 =?utf-8?B?Snh4MXFXUjUyT25lcmJ4M3U1bUFMYVZHcXNxVWE1TTZPbDMxOU4valFxSVhJ?=
 =?utf-8?B?S0czL2haNzEyQ3NWSjNyOGU1cFBMTFZGT1VROWV1T2JaSkdwdFBCY1c3Zk1k?=
 =?utf-8?B?c3ljSDlTalJ3ajlnVnJ4VTZzRTdGZWxCeUUzSFRKU3dESk9sTE02TTRmalZi?=
 =?utf-8?B?MFZrdjBxRmViQVdPR1JxeDN3RThMNFUraHdiNHJLTVh3MFcxbDdSQWRMN3c2?=
 =?utf-8?B?NjlFS0tBKzdPREhXVmh5L285RWhiSW4yVERFd0tNT09ZZTROZG84b2x3MTBZ?=
 =?utf-8?B?WEVNaStYUnl5S1dQSXpNclgyVTJ4QXFkdlJjaDdPY05JcCtvdWdlZXVYMlhT?=
 =?utf-8?B?dGppM1FOakVNT0Z5d1JTQzIvK0Z1Y1oxUklnNFpreUlWSXZ1eWZNNjRySnB1?=
 =?utf-8?B?QVl0aWxkS09NSGJaV0wxNm9Sd3hQbENIVWNhUGhjMEpvRXg3Z2VoMEEzNmhQ?=
 =?utf-8?B?eG9VcGxsMHQ0V2xmb2RPZVRiT1EzMUlaNVQvSW55TkJncHFqaDM3RVY3L1dM?=
 =?utf-8?B?R2ppZkVtbmZUNzlBUGUvTXRBRlNYMWxmTWh5dkt4VFVlSEpGVGFtNE5oVGp3?=
 =?utf-8?B?TGRha21INlYrcyt6d1pNYTlEdTJmNXlYRzBqOE9Ia2RHNjN6N0VpN1pIeFMx?=
 =?utf-8?B?eG1DeWZDR3VKQ2h2VFpVS0ZGMjJKQU9RZ3JSczdlQmJZTEtvYTRYOVg1NVc4?=
 =?utf-8?B?Vm02bWNKaEZyU2pBSmZheGVndkxMc3AvU05tUUlZUjZzK3ZySGlIZnB1WHVD?=
 =?utf-8?B?MDhoT1I2c1BCTkxDR2gwZFFhVWtROWh5bkpXNGJZQmxvdXRGd2licDNFTEtD?=
 =?utf-8?B?Z0hUQmZNa080Q1g1Q3ZabUd3Ulh5TGd0N3V3eXJlVG1aRlRtZE1CcW9HUzNM?=
 =?utf-8?B?VmZadU51MklreWdaK1U5VjJFMXhKZWJMaHBIOVNOaExiQnhBeHpuOEpoSFZr?=
 =?utf-8?B?Mi8xOTVRdmVjbWl3RGdjU1ZodVFxVnJjU0RYWkc3Y2RNNHR1eUhKRDkyL3NM?=
 =?utf-8?B?ZTBkN1VaYnVkU1gyU1JOQXg5QkdzZnBFQll5MTJWK3pRbXdTM1h4Q3pycm01?=
 =?utf-8?B?bTgrQ2c4YXYwSFdpL1Rubm5qUFVGbVlNVWlWYkNsaGNocldaTlBzVUZFM0F0?=
 =?utf-8?B?L2JOZVFVcGp3WThtQWlmSTEzeXdXT3E4U25OdGhjV3gvcFU4NEpBamYrTUVn?=
 =?utf-8?B?Q2doQVB3VnhwZHQ0dXRIb2JaekZ5aGtUUUNUN0xFaVhSS3pWRnVlTFVHNFBk?=
 =?utf-8?B?cUJYdklVMi9xN1JleHEwUUhmZ0FqdFc5SERFNzcvSVd1clN5eFVUbytPZ1lD?=
 =?utf-8?B?RlVscnRacHFWSmlReC9halVyOStBVXZLSVMwc1pYUURFbHVKampZdkxrL21r?=
 =?utf-8?B?ZUlEdFFnOWR4M2VjdGRxZ3NwbmdNYm9qdW42dnJtVERmOHg0MzdpTWhIVnFD?=
 =?utf-8?Q?LGfiHYSmK413ISue1D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ba339-9ac6-477c-2819-08de54eaae9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 10:33:26.1367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2O61WvpQnY3S5ArAS3Rs36KazAUxppJ+KOeKoFEj/bNl0vnGHefudpvdDKOITAOfcl0+FpsK7wvjPV7F4Rpe4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8051
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGFuaSBQZXJldHogPHNocGVy
ZXR6QG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA3LCAyMDI2IDY6MDAg
UE0NCj4gVG86IHN0YWJsZUBkcGRrLm9yZw0KPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hlayBN
YXJhdGhlIDxBYmhpc2hlay5NYXJhdGhlQG1pY3Jvc29mdC5jb20+Ow0KPiBBbGkgQWxudWJhbmkg
PGFsaWFsbnVAbnZpZGlhLmNvbT47IGJlbmphbWluLndhbGtlckBpbnRlbC5jb207IERhdmlkDQo+
IENocmlzdGVuc2VuIDxkcmNAbGludXgudm5ldC5pYm0uY29tPjsgSGVtYW50IEFncmF3YWwNCj4g
PGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNv
bT47IEplcmluIEphY29iDQo+IDxqZXJpbmpAbWFydmVsbC5jb20+OyBNY25hbWFyYSwgSm9obiA8
am9obi5tY25hbWFyYUBpbnRlbC5jb20+OyBKdS0NCj4gSHlvdW5nIExlZSA8anVobGVlQG1pY3Jv
c29mdC5jb20+OyBLZXZpbiBUcmF5bm9yIDxrdHJheW5vckByZWRoYXQuY29tPjsNCj4gTHVjYSBC
b2NjYXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz47IFBlaSBaaGFuZyA8cGV6aGFuZ0ByZWRoYXQuY29t
PjsNCj4gcWlhbi5xLnh1QGludGVsLmNvbTsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlk
aWEuY29tPjsgVGhvbWFzDQo+IE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0PjsgWWFuZ2hh
bmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsNCj4geXVhbi5wZW5nQGludGVsLmNvbTsgemhh
b3lhbi5jaGVuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiAyMy4xMS42IHBhdGNoZXMgcmV2aWV3IGFu
ZCB0ZXN0DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBIZXJlIGlzIGEgbGlzdCBvZiBwYXRjaGVzIHRh
cmdldGVkIGZvciBzdGFibGUgcmVsZWFzZSAyMy4xMS42Lg0KPiANCj4gVGhlIHBsYW5uZWQgZGF0
ZSBmb3IgdGhlIGZpbmFsIHJlbGVhc2UgaXMgSmFudWFyeSAyMnRoLg0KPiANCj4gUGxlYXNlIGhl
bHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlvdXIgdXNlIGNhc2VzIGFuZCByZXBv
cnQgYW55DQo+IGlzc3Vlcy9yZXN1bHRzIHdpdGggcmVwbHktYWxsIHRvIHRoaXMgbWFpbC4gRm9y
IHRoZSBmaW5hbCByZWxlYXNlIHRoZSBmaXhlcyBhbmQNCj4gcmVwb3J0ZWQgdmFsaWRhdGlvbnMg
d2lsbCBiZSBhZGRlZCB0byB0aGUgcmVsZWFzZSBub3Rlcy4NCj4gDQo+IEEgcmVsZWFzZSBjYW5k
aWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91bmQgYXQ6DQo+IA0KPiAgICAgaHR0cHM6Ly9kcGRrLm9y
Zy9icm93c2UvZHBkay1zdGFibGUvdGFnLz9pZD12MjMuMTEuNi1yYzENCj4gDQo+IFRoZXNlIHBh
dGNoZXMgYXJlIGxvY2F0ZWQgYXQgYnJhbmNoIDIzLjExIG9mIGRwZGstc3RhYmxlIHJlcG86DQo+
ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS8NCj4gDQo+IFRoYW5rcy4N
Cj4gDQo+IFNoYW5pDQo+IA0KPiAtLS0NClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9yIEludGVs
IHBhcnQuIGRwZGsyMy4xMS42LXJjMSBhbGwgdmFsaWRhdGlvbiB0ZXN0IGRvbmUuIGZvdW5kIDEg
bmV3IGlzc3VlLg0KDQp1bml0X3Rlc3RzX2NyeXB0b2Rldl9mdW5jL2NyeXB0b2Rldl9xYXRfcmF3
X2FwaV9hdXRvdGVzdDogQUVTIEdDTSBBdXRoZW50aWNhdGVkIFRlc3QgU3VpdGUgdGVzdCBmYWls
aW5nICAtLSBoYXMgZml4IHBhdGNoDQpmaXggcGF0Y2g6IGh0dHBzOi8vbWFpbHMuZHBkay5vcmcv
YXJjaGl2ZXMvc3RhYmxlLzIwMjYtSmFudWFyeS8wNTU1NDYuaHRtbA0KDQoqIEJ1aWxkICYgQ0ZM
QUcgY29tcGlsZTogY292ZXIgdGhlIGJ1aWxkIHRlc3Qgd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZl
cnNpb24gb24gdGhlIGZvbGxvd2luZyBPUyhhbGwgcGFzc2VkKQ0KICAtIFVidW50dTI1LjA0L1Vi
dW50dTI0LjA0LjINCiAgLSBSSEVMOS42L1JIRUwxMA0KICAtIEZlZG9yYTQyDQogIC0gRnJlZUJT
RDE0LjINCiAgLSBTVVNFMTUuNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0gQXp1cmVMaW51eDMu
MA0KDQoqIEZ1bmN0aW9uIHRlc3RzOiBmb3VuZCAxIG5ldyBpc3N1ZS4NCiAgLSBpNDBFLShYWFY3
MTAsIFg3MjIpIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cv
VFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNT
LCBldGMuIA0KICAtIElYR0JFLSg4MjU5OSkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGlu
ZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0
ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSUNFLShFODEwLCBFMjEwMCkgUEYvVkY6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zs
b3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVz
Y3JpcHRvciwgZXRjLg0KICAtIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgaXBzZWMv
aXBzZWMtZ3cvaXBzZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJQiBsaWJyYXJ5LCBl
dGMuDQogIC0gVmlydGlvOiBib3RoIGZ1bmN0aW9uIGFuZCBwZXJmb3JtYW5jZSB0ZXN0IGFyZSBj
b3ZlcmVkLiBTdWNoIGFzIFBWUC9WaXJ0aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9vcGJhY2sv
dmlydGlvLW5ldCBWTTJWTSBwZXJmIHRlc3RpbmcvVk1BV0FSRSBFU1hJIDguMCwgZXRjLg0KICAt
IENyeXB0b2RldjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGlu
Zy9Db21wcmVzc0RldiBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQogIC0g
RExCOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgRExCMi4wIGFuZCBETEIyLjUNCiAgLSBPdGhl
cjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIEFGX1hEUCwgUG93ZXIsIENCRE1BLCBEU0ENCg0K
KiBQZXJmb3JtYW5jZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCiAgLSBUaG91Z2hw
dXQgUGVyZm9ybWFuY2UNCiAgLSBDcnlwdG9kZXYgTGF0ZW5jeQ0KICAtIFBGL1ZGIE5JQyBzaW5n
bGUgY29yZQ0KICAtIFhYVjcxMC9FODEwIE5JQyBQZXJmb3JtYW5jZQ0KDQoNClJlZ2FyZHMsDQpY
dSwgSGFpbGluDQo=
