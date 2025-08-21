Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923DCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 01:09:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68F2402C4;
	Thu, 21 Aug 2025 03:09:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 828A84026C;
 Thu, 21 Aug 2025 03:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755738549; x=1787274549;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y5As7DDcq5YoGbztrO3+rooRedqEh3JMSwwZ36Pfjzw=;
 b=gJVjZqsDHDEjjDLCYBMp1x0a9JJSsLRIeeFe95TIhB9yFbHBPWEuv8nl
 L7xr7phys/HpIqjm0TCCBK0EVvzMlH2yhQZ1qkyk08VrdhMrGz4W234MK
 Cm8IpzLeE7bCbrXwR81Ff/TDy3TOar9U82L8xel0+WUYonIYJfDojuXL6
 7yPSxTygkwQEX+c/MTtNPmIuZvstE0CkJoWQ37/9mdUVRm9zK7aKWhrsq
 hOqTINnCNoamc02WyO1f1fyXr8Da7EKFJdSty1OmB2gUVrmQrvkZJq3xX
 oEdPhd0AkTIEy3LPWHUhGSpsD0XgdkXCR1W4BKMIqIeId2+QYYhyz5cDy Q==;
X-CSE-ConnectionGUID: hQmyOWfCRZisdYf3CxGlAA==
X-CSE-MsgGUID: 7d7cn7ByQNahni8/OgdujA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75467845"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="75467845"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 18:09:07 -0700
X-CSE-ConnectionGUID: 8LvcX1AhRSO+t5j7r8cAvg==
X-CSE-MsgGUID: MQk8XFWQTASPkFkbtcexJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="199141262"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2025 18:09:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 18:09:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 18:09:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 18:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+GfDMHULGagoDkt7IPBl1LJrpYZSxZd+QFvvYch1I5zz55tEdD7XECTrHOISb4mSkYiDgNJe+b2vpZ41gQtWFKIxWdr41yjCxcpSr3jQyI68iTjjI11rLqkzzsA3Ah3VnNQlWssWbW64D4UTUCgQC9BOMTx7KuNkSOsz3I9xso8U5u0szPMGC+7nR1n+CJ+/v7micCLYPeKcWYAKwUh5754QPCx7kYLlb0x+D4ZmU5WIzySlPIGdcUN9Az2TnLdBpTU98Je3TEXnT6761YZte+PFQ2km2bcqw2U0x6BJkD+KvY8K64L5dHmLUBaE23PoBr5LCAyKyRFBzxUQL+ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5As7DDcq5YoGbztrO3+rooRedqEh3JMSwwZ36Pfjzw=;
 b=xVkebhmHb6W9d4EOmbqxCqDUuZyXudhr3ix5HWLwve+TMf9FfgXKYk3IIbQa9Lt8Ofkbywx/VyxhYMzGLXKrayJLM6YQklD5k66NifuaOi6JgnxJ2IjxDXW5uNMMGQ1G55GwaW8xbxMpaaw4CDNA61V7FUm26fx1Yuq6gESgqcRQaHKqDmd5j09PsSlfSo56KkQ1l1VRWcuVu2xyvcHoms5uucDdyEFdc06vRYNMvXnYVfmVMQ/byFZWVF7mXc5KjK/B9fl/Aoeey2/j8GpKWamBr6QpNurv6FEHU+4Riz/OqS0KBwDakYld8fKAG4vQrGZ82OhL2GmqA55YAXimsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:09:02 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 01:09:02 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Xueming Li <xuemingl@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, "benjamin.walker@intel.com"
 <benjamin.walker@intel.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.5 patches review and test
Thread-Topic: 23.11.5 patches review and test
Thread-Index: AQHcCsYS9Mf8cwkhWUeRQxqhDLs9FrRsWoqA
Date: Thu, 21 Aug 2025 01:09:02 +0000
Message-ID: <IA3PR11MB90406E8B9EA24FD7028AEBDA9F32A@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <20250811134220.45579-1-xuemingl@nvidia.com>
In-Reply-To: <20250811134220.45579-1-xuemingl@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: 885b8f6f-e421-413c-c6df-08dde04f5144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OFl5WXJDUWVqWVhFZGdncUtSaVg3dmF3RndOSXdHMGUxRVE2WWdCSUNScDVU?=
 =?utf-8?B?anllbnd2Z0UybkZYR0syNElRQSttT2ZCa2VNWWI3cW5sVWZLc3VlbVRaUEI0?=
 =?utf-8?B?YjJoSDBXNlhHdWpQdzdxKzZVK3ZLTUpveVY2bFhhYTZlejFQb0tCSXZ4Lzdn?=
 =?utf-8?B?RW9HY2VhaG5UZGNsSHdiSGRod0gyc1d6YitVRHpkQ1d6aHIvYUFUTllqbGov?=
 =?utf-8?B?MHNOQ25nTzIrWkR2MW11SVo2OXFUbHJ2SWNMdXZyMFpHNVAza2x5Vzc4MWJ3?=
 =?utf-8?B?M0ZqS2trWXYyRXFpZUkwdUxPdzd1SEVmQjNlb0l2ekc0REZPeFdXU0VMRDht?=
 =?utf-8?B?d0tNS1J5SnBKaTgyME1ZTWFFK25kUlI2bnhsd0Z0SEQ1YW1jVGk5REl6VE90?=
 =?utf-8?B?WTdINFBYeFI0U21GSUQ2RGZ0eURZZlh5VWNIWnFQNFZzOW9tZjRqVTJSSTU0?=
 =?utf-8?B?eE4xUStnQ3RoMm9sZlRTbnZmb0VlWVB0dklTQVBsMmxvb0hXZnJBSEQ1aVZF?=
 =?utf-8?B?TVZXbWpIejF5Q1RyTmhvaEFMRWN5NlhXcGd4WGFnSlpteENsTnhZNWMwVGZU?=
 =?utf-8?B?MVNCSU1tbmI3WjkyQmFaVVM4cXBGajl1NlI3ejNWcS9HYUJsRUZXQmpJL3ND?=
 =?utf-8?B?RFRhbElvUnhoVUhCMFlmQ1NrVGZMeCthQTFSN0pZYmUxSmRVN1VHSmZaR0NV?=
 =?utf-8?B?MGgvcTBMUHRTbXNDSWRJNnBxc281bzR6MmtoRElPbldiYWhtSWY5WXcwT3RP?=
 =?utf-8?B?Z2RNU0dHN3Uwcmw1TnZjWWlIejFVVGNxMERrWnEvZDQ4YkFYZTRHMCs5b0tr?=
 =?utf-8?B?YVlNd3pMWGVnMkY4MXgzSStOajFGTGk2eTY4S0czVjUvYmU4MTJpSjJWaTFh?=
 =?utf-8?B?aXQ1NHdESFYwN29icjZCcEc1TE5lQk56SE5XTDA3VmU0TVAzNUdBdGdFdGF2?=
 =?utf-8?B?c3ErbHFFNXJCVEN1WWs4bTlXbGZ0c0pobVhXQ21QdU1TZ1VhWHFWVFl2cUJO?=
 =?utf-8?B?LzQrMlJnZFRkcFF5Y1pMMzNaRHZoWDMzSEYrYTh3R1RHLzJDYTUxK3dnUW4z?=
 =?utf-8?B?dzQ1d24rQXhUMDRuZE1kRlExU3BldmIxYllYcTluRjBRSUdoOHJqQk5MSTdT?=
 =?utf-8?B?T2ZDbG9ycjBETzB4c3lscjloeStWaXhDaG1TSm5NMXlmUURVWWpia2R3K3p2?=
 =?utf-8?B?bE1MUjlvdXBWL3NsZmZOQkZDMVFTNW5QNUh3cVlHWlJyZHFIbGd5L0lxS0dh?=
 =?utf-8?B?eWtPa1NjM09LcnA5eUMwaVBycWlML0hQTjhVVGhLc1ppN0ovTWFqN1R5SHdN?=
 =?utf-8?B?ZlpwRXpTR1g1S2FWNDZFYll1ajhOUUVzZUJaTGZPR2J2RmNUVFROcW1IbW5Y?=
 =?utf-8?B?OEd3R25TRjVkcTNRS25yakJiUmZRbjFjekwyVWh6Rksxb0lCeE84WXEwOERp?=
 =?utf-8?B?MlRTUnNnbGN0VDFtVUV2cUxlL0dOVUhLenYyNlNDNWtGTTlpRi9NRTR4anZO?=
 =?utf-8?B?dEJPOGZLcmlscUlNNUh6TmsyZ1Fyay9WWkhwckNObzRMT2oweE1xY0MxSWVn?=
 =?utf-8?B?THJQWEZQL0VOYWNuV2p3WG1UeGtEdGlkbUdTTnF0ZmZkSHJFNVduWmhLM3Mv?=
 =?utf-8?B?dFBybk5QU0tWNWw5ZGZtVStsT1c1VkRodjliRzBBK0tnMitjQld4cU9DajU0?=
 =?utf-8?B?akRhMHFTK3gyM2RIQjIrdktUakh6RnZ1eTFiRXBqWGJHR0JySjMwYy90NnNC?=
 =?utf-8?B?NFYxNFhEcXMvTUtONXA0Wk40OGpnRER0ak1NRlpObm4xRytwTjZ1cFRzQnhu?=
 =?utf-8?B?UGZ4cWFLTTB1RDRHcWc3Rk1sbGw0K3VNZmlGL2FkWjlPRDRGVzlYSmd2N2NR?=
 =?utf-8?B?VmQ3N3gyeDQ4TzQzVnRrOTBmTG5VRDFGNCtwdkRzaWY4RHdFNDRpRFhJaTRG?=
 =?utf-8?B?VmpuYXh3UCtGNDZsbXN3NFhUVTZ5c0hNeWZ4V3FPUVZQZlNqa0IxTStCck5V?=
 =?utf-8?Q?ytgatHWt0iADMUiiW3NCdiMIonIIWk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmpOeloxQXhEYStpUy9aN3V6b2FraHNFQWhSUXpTV2lXd2FMRkRraU12ckZa?=
 =?utf-8?B?Tm5xSWhVQmQxNUd6T3N5MU1XaUVCdEZRNnpVREJUKzBPTDhHT01rSnc5dDcw?=
 =?utf-8?B?WVljVVprZGM3L1NkSVA3Zy9Ya29RMXF6WjNvTVBSSkJoTzlYWHkrOUVKaU13?=
 =?utf-8?B?dDdUNEtOQi84b2pVQ3NKbGhHaUFzTmU2cmcvZjdNU1AwK3JNNEhQQzZnbHFX?=
 =?utf-8?B?bDRUdzBSSHpKSXJtRTBYSGhEZXNROFlOUG9RdHlGRXlxaXRtSjlMMDhFWm1l?=
 =?utf-8?B?N21zN0R5amNrU1J3QWc2NGNSMjFGTGV1SjJpd0greHhMTkhzcFFQTGlENENJ?=
 =?utf-8?B?c3BQRnRiZzdZdXlUaGRNSlc5ZjdQQU5lRkVBVW45MUFMekZpaDlvSnVTTlBI?=
 =?utf-8?B?SmU5MnJvRVZZRml5bFppeVA3ZTM1eHM4M0Q3WmpZcm9ia3Z2cmUyVUlVZGdM?=
 =?utf-8?B?YmhLeEF2bFFpWGlpYUQ4TjAwZ2J4dDY0ZXlIMWo3U0RsV3gzVGR4eURWbWlr?=
 =?utf-8?B?K1BGQ2VCMmdmSzNvZm1rSjJDSGpkdUVaSSttVW9sZVRBQUZOOWx5TXVqSG9U?=
 =?utf-8?B?VzdTUVg0SnBvelhlSjd1RTE0SlVhUXNLWkFkUU5YeGpQWWlsQTJwUG1CVVdH?=
 =?utf-8?B?QWNkS3NhcHR4WjlrclJhVUFNNVd5UVFTZjhWblFaQnExWCsyaDlSd2d2VWY3?=
 =?utf-8?B?cldqWlFJb0NpWEtON0orLzRBUElGcGFtNTJqRGFTbWZBRitqVHJDTVFpUWJP?=
 =?utf-8?B?eUc4VlBya283TkhDZGZQM3JwMDVmdjFHMUd0MTJjZHNtbkJjTTJNNUNlaGpL?=
 =?utf-8?B?engrQzRkTkE4OEVET2pWeElDRXQxVHFnS3RkYy9RTU13ejFiUnd4UmpSTEZu?=
 =?utf-8?B?VDNabzFuTmlTU3krR2NhdlJkK042YzV2Nkk3SXJsNDZlcWN4TmdWSTNqUWNU?=
 =?utf-8?B?NFdvRjlBOXVCMXVZWEFTTE1BNlBaR1h1RTNnZG1kTXU5dDN0cFpVWDlkVGM1?=
 =?utf-8?B?QUMrWS9YcFcvL2QzbkxNTk5YRENxcnNiNnNJNWFGdzRqL0RId2hBT3c5Wmlk?=
 =?utf-8?B?V09UR1dVQzFTVjh4UEkxdEdKelF4VW9zM0tjL2pHVjR2MG1VcUVOdFNnWUJS?=
 =?utf-8?B?RHVTdW50dTROaHdmZ1c2QnRMN2FFcWVvWG9SUnlROTJ1eFRXMU5mTWtOZTlP?=
 =?utf-8?B?VFpaU1BzcFVHeFRzSzFWVVRtOG5QRWo5TjhhcnpEYWhCTmJBa2xzeThUY3h1?=
 =?utf-8?B?aWpBT2RzamdaU0lTaXBaTUNhN2RSNHk1TGJxL0x1djIraFJhckIzOCtXb3dx?=
 =?utf-8?B?dVRHaktobnlLa3hYVjFtUFZRbGdKS3RjVHA2N3FyODdIUXZPMVpUMWp1OURB?=
 =?utf-8?B?aUVHN3ZjV251QU5PY3Nva0VjcTJBVGRZVU44SlRRZ2xQOU9IRGRPQnNJTFQ5?=
 =?utf-8?B?c2hISUFGQTU3bUJhY0ZuR29VbERMMHV0eTcwcmNBYzJ3QjdqK1FpVGFJN2N6?=
 =?utf-8?B?eHBsbS80d1l3dGdXVnhqdWZmOVRvYk5NZDVXUTdqQzJLZk8wOTN6KytySTd0?=
 =?utf-8?B?UzB2UElqUFBYTC9kUWw2azBVUGx6Z1B4RlZyM0FKOG93TE9uaElHQWxqVHM2?=
 =?utf-8?B?Nnl6bk1MZFhTaDdta3NsdFZuZHJaTGQrUGtXcjRiOGZ0amxuT3lVM3Nrb3pv?=
 =?utf-8?B?cmdSWC8yM0lUcU01VHdTbTNzb0huSjNweU9UQzFUUjdVby92ZS83YW1mbnRD?=
 =?utf-8?B?WmNPMWdwWVk4Qjg1eUdqdUNOS0tlUU5INE93UlB6T2M4emVqYmtad2JEY0xR?=
 =?utf-8?B?MUdrWjU4NGlsOEZkZ1JYTGdkZ1RVRUZSUlhoSndDVzU1NWJDVXRaVTdpMUhi?=
 =?utf-8?B?SDdvUkt1V3BwVi92elNVTnEwRWNpMGZIMENLSTZOR25KZzIwdFhheVMvUzdp?=
 =?utf-8?B?Y3RzMEVzV2tvZkRmTTgwalJmaTVFazdXZEFCTnd1TTVyMnFMUlN2RzB5aC9w?=
 =?utf-8?B?NDBoeHZWOGJpcENhRWRwWjliTDJnTE8vUkNPbjlROXNHVWNOL3RtbWJBTWQ2?=
 =?utf-8?B?S0VFUHEvRGJlb2RDVG9Xa3VhdDNLTlQzSE9JZkFEY0c3MUJXYjdObmVPMXF0?=
 =?utf-8?Q?Tv26PgPIjyTlYK9IAtN7hb44V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885b8f6f-e421-413c-c6df-08dde04f5144
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 01:09:02.6955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68Y9Gp+4gJYRWySQff1TTL+JJ1al+YdLG6JPgddKx72G2atnSCllxlXrdoMtWDiRbPQhXa+B08ZOKzJRstQVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYdWVtaW5nIExpIDx4dWVtaW5n
bEBudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxMSwgMjAyNSA5OjQyIFBNDQo+
IFRvOiBzdGFibGVAZHBkay5vcmcNCj4gQ2M6IGRldkBkcGRrLm9yZzsgQWJoaXNoZWsgTWFyYXRo
ZSA8QWJoaXNoZWsuTWFyYXRoZUBtaWNyb3NvZnQuY29tPjsNCj4gQWxpIEFsbnViYW5pIDxhbGlh
bG51QG52aWRpYS5jb20+OyBEYXZpZCBDaHJpc3RlbnNlbg0KPiA8ZHJjQGxpbnV4LnZuZXQuaWJt
LmNvbT47IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsNCj4gSWFuIFN0
b2tlcyA8aWFuLnN0b2tlc0BpbnRlbC5jb20+OyBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwu
Y29tPjsNCj4gTWNuYW1hcmEsIEpvaG4gPGpvaG4ubWNuYW1hcmFAaW50ZWwuY29tPjsgSnUtSHlv
dW5nIExlZQ0KPiA8anVobGVlQG1pY3Jvc29mdC5jb20+OyBLZXZpbiBUcmF5bm9yIDxrdHJheW5v
ckByZWRoYXQuY29tPjsgTHVjYQ0KPiBCb2NjYXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz47IFBlaSBa
aGFuZyA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgUmFzbGFuDQo+IERhcmF3c2hlaCA8cmFzbGFuZEBu
dmlkaWEuY29tPjsgVGhvbWFzIE1vbmphbG9uDQo+IDx0aG9tYXNAbW9uamFsb24ubmV0PjsgWWFu
Z2hhbmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsNCj4gYmVuamFtaW4ud2Fsa2VyQGludGVs
LmNvbTsgcWlhbi5xLnh1QGludGVsLmNvbTsgeXVhbi5wZW5nQGludGVsLmNvbTsNCj4gemhhb3lh
bi5jaGVuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiAyMy4xMS41IHBhdGNoZXMgcmV2aWV3IGFuZCB0
ZXN0DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBIZXJlIGlzIGEgbGlzdCBvZiBwYXRjaGVzIHRhcmdl
dGVkIGZvciBzdGFibGUgcmVsZWFzZSAyMy4xMS41Lg0KPiANCj4gVGhlIHBsYW5uZWQgZGF0ZSBm
b3IgdGhlIGZpbmFsIHJlbGVhc2UgaXMgMTV0aCBBdWd1c3QuDQo+IA0KPiBQbGVhc2UgaGVscCB3
aXRoIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24gb2YgeW91ciB1c2UgY2FzZXMgYW5kIHJlcG9ydCBh
bnkNCj4gaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhl
IGZpbmFsIHJlbGVhc2UgdGhlIGZpeGVzIGFuZA0KPiByZXBvcnRlZCB2YWxpZGF0aW9ucyB3aWxs
IGJlIGFkZGVkIHRvIHRoZSByZWxlYXNlIG5vdGVzLg0KPiANCj4gQSByZWxlYXNlIGNhbmRpZGF0
ZSB0YXJiYWxsIGNhbiBiZSBmb3VuZCBhdDoNCj4gDQo+ICAgICBodHRwczovL2RwZGsub3JnL2Jy
b3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYyMy4xMS41LXJjMQ0KPiANCj4gVGhlc2UgcGF0Y2hl
cyBhcmUgbG9jYXRlZCBhdCBicmFuY2ggMjMuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gICAg
IGh0dHBzOi8vZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlLw0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gWHVlbWluZyBMaSA8eHVlbWluZ2xAbnZpZGlhLmNvbT4NCj4gDQo+IC0tLQ0KVXBkYXRlIHRo
ZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazIzLjExLjUtcmMxIGFsbCB2YWxpZGF0
aW9uIHRlc3QgZG9uZS4gbm8gbmV3IGlzc3VlIGlzIGZvdW5kLg0KDQoqIEJ1aWxkICYgQ0ZMQUcg
Y29tcGlsZTogY292ZXIgdGhlIGJ1aWxkIHRlc3Qgd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZlcnNp
b24gb24gdGhlIGZvbGxvd2luZyBPUyhhbGwgcGFzc2VkKQ0KICAtIFVidW50dTI1LjA0L1VidW50
dTI0LjA0LjINCiAgLSBSSEVMOS42L1JIRUwxMA0KICAtIEZlZG9yYTQyDQogIC0gRnJlZUJTRDE0
LjINCiAgLSBTVVNFMTUuNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0gQXp1cmVMaW51eDMuMA0K
DQoqIEZ1bmN0aW9uIHRlc3RzOiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQuDQogIC0gaTQwRS0o
WFhWNzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9G
TE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFO
L1JTUywgZXRjLiANCiAgLSBJWEdCRS0oODI1OTkpIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNs
dWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNf
ZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElDRS0oRTgxMCwgRTIxMDApIFBGL1ZG
OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvU3dpdGNoL1BhY2thZ2UgTWFuYWdlbWVu
dC9GbG93IERpcmVjdG9yL0FkdmFuY2VkIFR4L0FkdmFuY2VkIFJTUy9BQ0wvRENGL0ZsZXhpYmxl
IERlc2NyaXB0b3IsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlw
c2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFy
eSwgZXRjLg0KICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBh
cmUgY292ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3Bi
YWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjAsIGV0Yy4N
CiAgLSBDcnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRl
c3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0K
ICAtIERMQjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIERMQjIuMCBhbmQgRExCMi41DQogIC0g
T3RoZXI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBBRl9YRFAsIFBvd2VyLCBDQkRNQSwgRFNB
DQoNCiogUGVyZm9ybWFuY2UgdGVzdDogQWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogIC0gVGhv
dWdocHV0IFBlcmZvcm1hbmNlDQogIC0gQ3J5cHRvZGV2IExhdGVuY3kNCiAgLSBQRi9WRiBOSUMg
c2luZ2xlIGNvcmUNCiAgLSBYWFY3MTAvRTgxMCBOSUMgUGVyZm9ybWFuY2UNCg0KDQpSZWdhcmRz
LA0KWHUsIEhhaWxpbg0K
