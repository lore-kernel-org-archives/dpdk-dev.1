Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D0D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 091A7402C3;
	Tue, 20 Jan 2026 09:54:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6A96D40156;
 Tue, 20 Jan 2026 09:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768899252; x=1800435252;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K470LGfnTYzcSiPNAtZbtPtfYuo+FylD7j/IhWFtJ0A=;
 b=hP+MsEjFDKbcIkKUYnh1Ger2a7Ap42teb/sJFIv5if0hgvmRuPnqU8x5
 5xG+3GrJ6D7JhdWspIvjLFsPdgpg6BLz0PBU6o4R/2AN0HJptJddjHn2F
 D5gGS4AXendkt4FeEROW/bSfaMPxk8Ndcim0SCUkkEbGokx18Eo8UzwNp
 enlEPF1qKFnQPG0yOzlNekQPwEP4nSETJa/gSE6z4o1SlLxUl1MM9eEXa
 UrZ49u57HvSupT+QfzlZl4IW0QOrDpEvkpiD79JfDAnGVsIpDaKLcvAEp
 LFFKi7FQBnRcJXZiD2ttWamoplNcX06ngyyPZ+vjb/vgHzo+3n0EPs3pv w==;
X-CSE-ConnectionGUID: 3he0JysbSI268U+5YJD5yg==
X-CSE-MsgGUID: zTfMhwiuTE6AjwOAZuDXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70003013"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="70003013"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 00:54:10 -0800
X-CSE-ConnectionGUID: IQu2bccWRrimf3hlL/9I/A==
X-CSE-MsgGUID: RttCdnVlSOyXPlCzAFlUCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="210561423"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 00:54:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 00:54:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 00:54:08 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 00:54:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBpyh4nxwFo6GeU0pxULJ/eMENQogdTxGBXYn/kEqTTzZUWha5sZX66IfDrHFKuz4ekFFAg/BHG8Sbl4BOnweLj1ZGH8+/s6EXe8iVHf9onMXhexHK1GZoAYHW51N8QGU/nrunZ9rICMB5De35kEdZSGZIiB1tL9ZDeUWLmZvflja8IHPqH64dVR5/bVHP56BKEPl41+VFHH4ulhM+AFfFSiO9XtbIEVYpeuQLwQN0qiIPIXpr6J/EuKCohXocUS+EtiwvDlj7DqFuZBVx8enjgXmDvF1A2cn0tP6PieGQ8W1KzW1E39Rpu1JVOXEM0e1IXGHqDg85pTOb3ksr48qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K470LGfnTYzcSiPNAtZbtPtfYuo+FylD7j/IhWFtJ0A=;
 b=VLhUsuSxfV8HnXrDttgdAiXnlsfO2Di+PQ6eWd+bTrMQV86WtYArnXKWYfpwmdjJRDHMdiDd9kpcyfrVb/CJwtVY1xC79NI65A8jZKc7IajygOFniQOWZMzNobPzleuU705msiU6gQkkTazUoB+4OzQvsilaTSMCdnfzG3dgxEaPfdMqk/B+SMx6N7iUXGVbxTqwkqqmaCXXSOFEhFIVB/WSHWVyJNp3wlfN8/RR17qHOSz4Od9wZHe4pWDH8oybZ39JpI1dfZr547nfWCX5G49Wirgi2z/aeYMRnbNf5wBoQAo1LVQ+NVORrqMLp43bPkE3PwJrHWqtKaN0TCZkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:54:05 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.9520.003; Tue, 20 Jan 2026
 08:54:05 +0000
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
 Darawsheh" <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.6 patches review and test
Thread-Topic: 23.11.6 patches review and test
Thread-Index: AQHcf7ygKoRkyWapY0aGVKMuSi4Oi7VUp1jwgAYh+QCAAAqTIA==
Date: Tue, 20 Jan 2026 08:54:05 +0000
Message-ID: <IA3PR11MB9040606C2B1305D219B7D7769F89A@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <20260107100017.158232-1-shperetz@nvidia.com>
 <IA3PR11MB9040224D2707117312E2DBE89F8DA@IA3PR11MB9040.namprd11.prod.outlook.com>
 <MW4PR12MB7484C0F98C8D0DDFC2822CBBBF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB7484C0F98C8D0DDFC2822CBBBF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|CO1PR11MB4929:EE_
x-ms-office365-filtering-correlation-id: e591ce12-62de-43c1-9d01-08de58017773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bmxTQ2g2YlFUZDhVZWlmK3pjdm5oS0hpdGIzRmFKZ0tXTkFMU3VJZFhMeVF2?=
 =?utf-8?B?c1ByV0ZaYnpOZmZJZS9iekJhUStxREFqMHlpYVJTOXdhUkovckdjS2NCTEIx?=
 =?utf-8?B?M2VISXozZVA4OTR3c2RGZ2NVRkdISTY3Ni8xck93b3BKQWFvS2U1bFpKM29y?=
 =?utf-8?B?UEdUMk1id2lyMjNiZWw0MU4zVEN1MlBsY3hyb0w2WEtyZkpURitYaTZLaUg1?=
 =?utf-8?B?RE1HYkI4L1pGWm1oNUZ4dW1IZ2Q0M0s5MVRud1lsMHNodFpYbkMvc3RCZXBV?=
 =?utf-8?B?NVMzSkhkTE1sMEk0ZHJVLzhWWXRENGdKNWVxMjRqZFJCWnowT3dTNmhWVy9K?=
 =?utf-8?B?T1h5Rm5wZXV5eFArWE9GYWRXUk9ZcmpFcjhvUlhkcVJ5QVp6VU5kaWRidVlP?=
 =?utf-8?B?bE9tYmp0MWIzTFFwZGtMVURDOXc3MjBwckJJc3kxanlXOFQxV1FRN2l5U1Rm?=
 =?utf-8?B?VG1iS0ZzbXJNL0J6cWFnZnhLUng4eDhVWHhVZkxzSm5lUHlKaHcxOUNXVjJG?=
 =?utf-8?B?ZzRFRlV3WjUxZXFLUEs4SThXeWxIU1YzeFViclN5eVlYV01tNWFEaHNwVk1F?=
 =?utf-8?B?ZytRZGlpakZMNjRINVJQazBPUFJoNUpuRldSUDUxdjJIcDRXMXJxVW82bmtw?=
 =?utf-8?B?MkZMRjB1eGJvQ25UU244QkUrWURMeG9sYzZsZkptUXE1dEExNWF4aFRDNHRi?=
 =?utf-8?B?dEdWL0FoMUxPUGRFclU1TjJOUFNranMxWWFML0RYbkVvUHRyZnFMVW15bE5v?=
 =?utf-8?B?c0lEbWg5QVN0UGRFK1BMYlg5ZGorci9YTEd1anJ0OCs2N1hRRlh3WVAwN09t?=
 =?utf-8?B?RlhySmdpSnlURk52TCtXYTN2N3ZCWks0WU1WWitiY1ZVLzdWWnp4dkw2czIr?=
 =?utf-8?B?OHZuS09IVTcrcWZkdk5KcXBReTRxbFFqbXdVa1c3Z0xQYm52bDlmOWlHWDlE?=
 =?utf-8?B?Mk12eHNMM21uTFc3VzRsVDdUb1grWWtaL0grRC9sZ2NZVEdKanJqeHYrcGZp?=
 =?utf-8?B?Z2ltVGFwMXRFbFJuTlljY0VXZGtXaTJwQ05jdmVBaWQ4Q2QzMGZzRGVUUERC?=
 =?utf-8?B?SE8rSVo1MDN0UVFiMUxobHB3VEp2NzFZcUtVNnRTMGFHOHBUMkJlN2kzTDVV?=
 =?utf-8?B?M2w1eXE2aDJMTjc3V2xudWJnMmhHWGZCOEQvWTFRUVVYTUw5UU5DQk4wRFVY?=
 =?utf-8?B?VE9pdndrR2J4b0NJZ1dxd1VibnhCYUt0S1hWT2ZIa2VoRytVa0wyZEtkQmxm?=
 =?utf-8?B?U2Yxc2xHV2V3eDdSQ3FwdVpjVzh2SlZudHVIa1psK0ZMd3k5RFJWUmxzV3FY?=
 =?utf-8?B?bHNPalR2VlNqYTQ1S0poTWQwU2Z3Q0JXdkpKV2hEZlhVR1lMbTYwd0hMYzIx?=
 =?utf-8?B?U051Y0owclBRMEg0ODdzWllOa0pBTFdQR3lMM1FSSjk0SzNWajVWcDByVW51?=
 =?utf-8?B?RlF3eVBTWkdTMzV5Q05vQkRDUEoycGVBUlZ5a3c5WVp4TllTdFFNMGthRnhj?=
 =?utf-8?B?SmpYTUdjSVMyRUVPdkpzWTNnTzhKcVpYZnBUdFNYdGhiWCtSdDg0ZXFVYVlE?=
 =?utf-8?B?MEpuUWtTY09Rb0VEcW9xYWR3MXFENWR1dkVyZTBoaEs4cGY4ajlRU0FRMHVl?=
 =?utf-8?B?d3YycGdpNVlHQytPNGRXQnNUamdhU3hOWEhvUERIdnV2b1JqY2UvU3pXV0R0?=
 =?utf-8?B?VmQ4a2JTMnhZclFWVDE1Y1RyVzVNcllXeGVaQWY0NzlBVExTeHNhU2Z4Ym56?=
 =?utf-8?B?dEJFTGNLekRvYUZTelloeitCSDJvSlFFUVVCRktMdm1zUTNrUGRqQmlucFBP?=
 =?utf-8?B?NnkzcDNvZVhFb0NYa2QrOVh2MlRVYVAxWHdNZFZJcWtuOGczeHZwa2tWQm9X?=
 =?utf-8?B?eURKY1NkckozaVNWZW9vdlUremdSbjVGdi9vQWlSdUhHaGs2Z2IzYjNCbmY5?=
 =?utf-8?B?Zk5hbzZyWm5UOTN4VTdMOEYvZWpneUVjN0R2VkV0UkNJVzc1L1JOVzFpRkNs?=
 =?utf-8?B?R21ZSWNyQk9hckxod2xNRWJHaHZMNFhndGZTSG1uajRycFNtMzRMdkMxdDRx?=
 =?utf-8?B?V3ZwVlN4RnZQcXl2d1ZEeDdTV1JreWVJOWRVZis5dVBmU3hHd2hwQXdpYkNC?=
 =?utf-8?B?WER3WDBRZ09tVWc1RnVvNVRacWd3dml1Vm5md3pHTUFkN0xlWW80KzZTUTJB?=
 =?utf-8?Q?wOqbmnlY0bvt+UgExwOGjj7+zAGdI6OKDcJ42KjO/dAj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QldXOG90OHFKNDdUQjZXNEpNVWJmTXdvRVVQVGlQek04QXFMWnZ0QXc4ajNr?=
 =?utf-8?B?RUN1UU1Xek1JN3lPSDEwbUg2UnBLTGdYUUt6eWcxZjJqNDIweWQ2TmpJTm9H?=
 =?utf-8?B?YWloTUVJejNVZjgvdTdEUTF4WmlmTFZ0b09qSGZ4Y2thcWpMd0orNW4xV0x2?=
 =?utf-8?B?TUt4bERxWVBLZU1YdGhPWmtFUTlJZ2pGWXZzS0w4V1ZnMU5qT1IrY0dMOGc4?=
 =?utf-8?B?VXcxaG1hNndyQ2ZxL1VCRUV6aGZnYWpEN01DQ0dNRm5qdVRLaXlGMS9Dd2E4?=
 =?utf-8?B?RDlNaFowN2xoNU85WEsvZDQ5eGZ1ZGxBZVpDY3pxSXdJcDFvT2VhR3hlMnJX?=
 =?utf-8?B?WjZCKzBvL2ZqL3NlT0haYWtZSG1sVmM1QThJN2RoeU1Mam5Ma2RDdkZCMDBU?=
 =?utf-8?B?TjJPUXNabmxzMUJ2MDAyUWZLa080dlJnUlFTNDVEUXdzTDlzWnBZa1ArczFw?=
 =?utf-8?B?WVFPRzJtWU1USDFSTkdwcENudjJUc2xSSTRWMGw1dUVXbnpxTXU0SDZYNzNM?=
 =?utf-8?B?Tm82b3diMFR0eWc4MGo3bmJlN09uZERzZFJhblVOV0o5ZFQ2ZlhxU2MzMC96?=
 =?utf-8?B?azlxMDlMSFVZZ0R2a2NJdXJzWW5FZmhwQlg1M1Jpa1hRcDhVZ2JuWmtZYkRG?=
 =?utf-8?B?a3B3cEorQXJBNTlOdlZBK0R6ZmtvcEE2ckJ6cU41QWQ0eDlHN0VPamRRS2NM?=
 =?utf-8?B?ZUF6SjA3N2VHOHNEQnVDY1VmWUdwZ3ZvRmVveFlyMkZzbUNxYy93emVwQ0pE?=
 =?utf-8?B?NG5rTVg1QmQ0L2tEK3dsQ0FNelFYeTdHRzMzVVY0cU9VTUZjalBkbVJQcm9S?=
 =?utf-8?B?WkpyVFNCaEIrSFRaQ1VObGduNVlhNWpMRFg3ZEM1Qk5DRTcyZHM3OGRQbmpN?=
 =?utf-8?B?M2pMV1NFRlJkVUxwSzNjOUF6Y2oxSHhEdFZBK1FsODhlSldOZkJXQi9vWkJX?=
 =?utf-8?B?amR1VkZYU2t2VTBZeThMY1ZxUTBWMGhWRTBkMVE3NGhZdThWSEEwdzcrNnQr?=
 =?utf-8?B?STVmNk52MFNZTllGL1ZwUEhnai9aOEgvL1JIdWhuanM1NS9IcTdiU0tHVk9K?=
 =?utf-8?B?dy9GT1NlQTBZTm1MMm5mT0RQQUQ1QWxuZi9WbFJZQVczNW1tNmhOM1V4WjVX?=
 =?utf-8?B?SU5IOHpscjdFbnAzNG5BR1I0VmRIQ3VpaktmZnN3V2hnS0pLZ2EycGcwY2RU?=
 =?utf-8?B?eS9EYmF3bXZqYVQxcUM1d1QwSzBjaWVtM2VmWVVPRzBLRzhuRG9XQnVMdE9r?=
 =?utf-8?B?Z1ljRVBoZjFmeTcxZ1VMT0FEQSsrdkZRbE5mT1pNNnJuam9HdWhJdkRzMmR0?=
 =?utf-8?B?ckM4MjBCeXlscDJhSjY0V0wwU1ZJeU5BWkZvWEp0OENMNFNPV2tlVUNtMEx5?=
 =?utf-8?B?T3JyenBtK2ZBdXN5ZTl1ejUzY1MzS1RlMGwrblB1eDVic2N1WHRXc3QwQkZq?=
 =?utf-8?B?ZjkxZWpZZ0N6ZjRwTzBjbGNpNmJoaHZxeHlSQjIrVElseUo2U3J5TFZ0ZVVT?=
 =?utf-8?B?RC9GenB6WFo5enNwOXl1bGFRMU9JdnI2N3dPZFpSbERtZDVHNjFjMmhLbVd3?=
 =?utf-8?B?cGxReCtjeXo5d080WGNtOW5sU3pSelAyeFFOS0xwK2VNNS9pV3Z3dDJUWG11?=
 =?utf-8?B?OEJzVi9BaWdQTVVFdmxqTCtJSjZhY1dXbHYwYlQ5T09pcnhKQVB3QU9CaEtJ?=
 =?utf-8?B?V3FJcHNDKzkzUkNuVkZkSlhqVTF1cERqVmMzUnptOGFVeHYzMHBwcnJQZWhJ?=
 =?utf-8?B?eDhYdk45UXZmUko2dStuT2tYbnNONStvbTgzNkozVHA5Z01UQjhrNzV4Nmox?=
 =?utf-8?B?ZnoxaUVVYTY1eTFFd2IwZkhFTlNPRFFTUTBNV1FtUlFYYnhuRlE2RS85Vkto?=
 =?utf-8?B?VW5PeEhld1RUVWQrdnhwWkJlVnZkVy80dDl1R1RkVjZUVVZRc0VhMzd0MUYz?=
 =?utf-8?B?ZWRydDFobHNtTzNibEFWb1BlN3lGdHRBM3Mwd1IwalRmejZyYWMwd2twVTZr?=
 =?utf-8?B?OHN5c3NXa0VTQURFaUJxK3ZkM0szaXNUOVYwTjVxakEwb0FyeWs1elJ6R09F?=
 =?utf-8?B?cS9qdVJsbExQSGhHbXF5RGFMdlNsVStoYk9qdTBkWG1pd2cxRlViTjBvMHpt?=
 =?utf-8?B?OUQvclkvR3AwNFJwVjZGcWM0TmxkejJYOVlTRTN2UGFUa1I1ZU0rUmVydDlK?=
 =?utf-8?B?T2xVeDc1ZXo1bzFycDRSQ2tUNzNWT1psT3BqemNEV1UxVUMxNndrWHFqOGp5?=
 =?utf-8?B?M2VFNmlrL1ZmdEFCY3lhalZvbTJrQzErYndtMm5yWStLdVkzNjNhaEg0b21O?=
 =?utf-8?Q?wBAUCHEbK4qP7Kf6tG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e591ce12-62de-43c1-9d01-08de58017773
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 08:54:05.5289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxHbHyQ35vM+rmcIlNEJ6Xtt63Zp+mW1K6ytKD8Hj0J6TEsAFAsh9JuJtrvVsbw6aqeDawjbgCUqlAzZsSQNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
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
ZXR6QG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgNDoxMiBQ
TQ0KPiBUbzogWHUsIEhhaWxpblggPGhhaWxpbngueHVAaW50ZWwuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUgPEFiaGlzaGVrLk1hcmF0
aGVAbWljcm9zb2Z0LmNvbT47DQo+IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPjsg
YmVuamFtaW4ud2Fsa2VyQGludGVsLmNvbTsgRGF2aWQNCj4gQ2hyaXN0ZW5zZW4gPGRyY0BsaW51
eC52bmV0LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhwLmNv
bT47IElhbiBTdG9rZXMgPGlhbi5zdG9rZXNAaW50ZWwuY29tPjsgSmVyaW4gSmFjb2INCj4gPGpl
cmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huIDxqb2huLm1jbmFtYXJhQGludGVsLmNv
bT47IEp1LQ0KPiBIeW91bmcgTGVlIDxqdWhsZWVAbWljcm9zb2Z0LmNvbT47IEtldmluIFRyYXlu
b3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+Ow0KPiBMdWNhIEJvY2Nhc3NpIDxibHVjYUBkZWJpYW4u
b3JnPjsgUGVpIFpoYW5nIDxwZXpoYW5nQHJlZGhhdC5jb20+Ow0KPiBxaWFuLnEueHVAaW50ZWwu
Y29tOyBSYXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+OyBOQlUtDQo+IENvbnRh
Y3QtVGhvbWFzIE1vbmphbG9uIChFWFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5uZXQ+OyBZYW5n
aGFuZw0KPiBMaXUgPHlhbmdobGl1QHJlZGhhdC5jb20+OyB5dWFuLnBlbmdAaW50ZWwuY29tOyB6
aGFveWFuLmNoZW5AaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJFOiAyMy4xMS42IHBhdGNoZXMgcmV2
aWV3IGFuZCB0ZXN0DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiBGcm9tOiBYdSwgSGFpbGluWCA8aGFpbGlueC54dUBpbnRlbC5jb20+DQo+ID4gU2VudDog
RnJpZGF5LCAxNiBKYW51YXJ5IDIwMjYgMTI6MzMNCj4gPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBl
cmV0ekBudmlkaWEuY29tPjsgc3RhYmxlQGRwZGsub3JnDQo+ID4gQ2M6IGRldkBkcGRrLm9yZzsg
QWJoaXNoZWsgTWFyYXRoZQ0KPiA8QWJoaXNoZWsuTWFyYXRoZUBtaWNyb3NvZnQuY29tPjsNCj4g
PiBBbGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT47IGJlbmphbWluLndhbGtlckBpbnRl
bC5jb207IERhdmlkDQo+ID4gQ2hyaXN0ZW5zZW4gPGRyY0BsaW51eC52bmV0LmlibS5jb20+OyBI
ZW1hbnQgQWdyYXdhbA0KPiA+IDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsgSWFuIFN0b2tlcyA8
aWFuLnN0b2tlc0BpbnRlbC5jb20+OyBKZXJpbg0KPiA+IEphY29iIDxqZXJpbmpAbWFydmVsbC5j
b20+OyBNY25hbWFyYSwgSm9obg0KPiA8am9obi5tY25hbWFyYUBpbnRlbC5jb20+Ow0KPiA+IEp1
LSBIeW91bmcgTGVlIDxqdWhsZWVAbWljcm9zb2Z0LmNvbT47IEtldmluIFRyYXlub3INCj4gPiA8
a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1Y2EgQm9jY2Fzc2kgPGJsdWNhQGRlYmlhbi5vcmc+OyBQ
ZWkgWmhhbmcNCj4gPiA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgcWlhbi5xLnh1QGludGVsLmNvbTsg
UmFzbGFuIERhcmF3c2hlaA0KPiA+IDxyYXNsYW5kQG52aWRpYS5jb20+OyBOQlUtIENvbnRhY3Qt
VGhvbWFzIE1vbmphbG9uIChFWFRFUk5BTCkNCj4gPiA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFlh
bmdoYW5nIExpdSA8eWFuZ2hsaXVAcmVkaGF0LmNvbT47DQo+ID4geXVhbi5wZW5nQGludGVsLmNv
bTsgemhhb3lhbi5jaGVuQGludGVsLmNvbQ0KPiA+IFN1YmplY3Q6IFJFOiAyMy4xMS42IHBhdGNo
ZXMgcmV2aWV3IGFuZCB0ZXN0DQo+ID4NCj4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRp
YS5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNywgMjAyNiA2OjAwIFBNDQo+
ID4gPiBUbzogc3RhYmxlQGRwZGsub3JnDQo+ID4gPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hl
ayBNYXJhdGhlDQo+ID4gPEFiaGlzaGVrLk1hcmF0aGVAbWljcm9zb2Z0LmNvbT47DQo+ID4gPiBB
bGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT47IGJlbmphbWluLndhbGtlckBpbnRlbC5j
b207IERhdmlkDQo+ID4gPiBDaHJpc3RlbnNlbiA8ZHJjQGxpbnV4LnZuZXQuaWJtLmNvbT47IEhl
bWFudCBBZ3Jhd2FsDQo+ID4gPiA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IElhbiBTdG9rZXMg
PGlhbi5zdG9rZXNAaW50ZWwuY29tPjsgSmVyaW4NCj4gPiA+IEphY29iIDxqZXJpbmpAbWFydmVs
bC5jb20+OyBNY25hbWFyYSwgSm9obg0KPiA+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47DQo+
ID4gPiBKdS0gSHlvdW5nIExlZSA8anVobGVlQG1pY3Jvc29mdC5jb20+OyBLZXZpbiBUcmF5bm9y
DQo+ID4gPiA8a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1Y2EgQm9jY2Fzc2kgPGJsdWNhQGRlYmlh
bi5vcmc+OyBQZWkgWmhhbmcNCj4gPiA+IDxwZXpoYW5nQHJlZGhhdC5jb20+OyBxaWFuLnEueHVA
aW50ZWwuY29tOyBSYXNsYW4gRGFyYXdzaGVoDQo+ID4gPiA8cmFzbGFuZEBudmlkaWEuY29tPjsg
VGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0PjsNCj4gPiBZYW5naGFuZw0KPiA+
ID4gTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsgeXVhbi5wZW5nQGludGVsLmNvbTsNCj4gPiB6
aGFveWFuLmNoZW5AaW50ZWwuY29tDQo+ID4gPiBTdWJqZWN0OiAyMy4xMS42IHBhdGNoZXMgcmV2
aWV3IGFuZCB0ZXN0DQo+ID4gPg0KPiA+ID4gSGkgYWxsLA0KPiA+ID4NCj4gPiA+IEhlcmUgaXMg
YSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDIzLjExLjYuDQo+
ID4gPg0KPiA+ID4gVGhlIHBsYW5uZWQgZGF0ZSBmb3IgdGhlIGZpbmFsIHJlbGVhc2UgaXMgSmFu
dWFyeSAyMnRoLg0KPiA+ID4NCj4gPiA+IFBsZWFzZSBoZWxwIHdpdGggdGVzdGluZyBhbmQgdmFs
aWRhdGlvbiBvZiB5b3VyIHVzZSBjYXNlcyBhbmQgcmVwb3J0DQo+ID4gPiBhbnkgaXNzdWVzL3Jl
c3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsDQo+ID4gPiBy
ZWxlYXNlIHRoZSBmaXhlcyBhbmQgcmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZCB0
byB0aGUgcmVsZWFzZQ0KPiBub3Rlcy4NCj4gPiA+DQo+ID4gPiBBIHJlbGVhc2UgY2FuZGlkYXRl
IHRhcmJhbGwgY2FuIGJlIGZvdW5kIGF0Og0KPiA+ID4NCj4gPiA+ICAgICBodHRwczovL2RwZGsu
b3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYyMy4xMS42LXJjMQ0KPiA+ID4NCj4gPiA+
IFRoZXNlIHBhdGNoZXMgYXJlIGxvY2F0ZWQgYXQgYnJhbmNoIDIzLjExIG9mIGRwZGstc3RhYmxl
IHJlcG86DQo+ID4gPiAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+
ID4gPg0KPiA+ID4gVGhhbmtzLg0KPiA+ID4NCj4gPiA+IFNoYW5pDQo+ID4gPg0KPiA+ID4gLS0t
DQo+ID4gVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazIzLjExLjYt
cmMxIGFsbCB2YWxpZGF0aW9uIHRlc3QNCj4gZG9uZS4NCj4gPiBmb3VuZCAxIG5ldyBpc3N1ZS4N
Cj4gPg0KPiA+IHVuaXRfdGVzdHNfY3J5cHRvZGV2X2Z1bmMvY3J5cHRvZGV2X3FhdF9yYXdfYXBp
X2F1dG90ZXN0OiBBRVMgR0NNDQo+ID4gQXV0aGVudGljYXRlZCBUZXN0IFN1aXRlIHRlc3QgZmFp
bGluZyAgLS0gaGFzIGZpeCBwYXRjaCBmaXggcGF0Y2g6DQo+ID4gaHR0cHM6Ly9tYWlscy5kcGRr
Lm9yZy9hcmNoaXZlcy9zdGFibGUvMjAyNi1KYW51YXJ5LzA1NTU0Ni5odG1sDQo+ID4NCj4gDQo+
IEZpeCB3YXMgYWRkZWQgdG8gMjMuMTEsIGNvdWxkIHlvdSBjaGVjayBpZiB5b3VyIHRlc3RzIGFy
ZSBwYXNzaW5nIHdpdGggdGhlIG5ldw0KPiBwYXRjaD8gaHR0cHM6Ly9naXRodWIuY29tL0RQREsv
ZHBkay1zdGFibGUvdHJlZS8yMy4xMQ0KPiANCldlIGhhdmUgY29uZHVjdGVkIHRoZSBsYXRlc3Qg
Y29tbWl0IHRlc3QgYW5kIHRoZSBpc3N1ZSBoYXMgYmVlbiByZXNvbHZlZC4NCg0KPiA+ICogQnVp
bGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0Mv
Q2xhbmcNCj4gPiB2ZXJzaW9uIG9uIHRoZSBmb2xsb3dpbmcgT1MoYWxsIHBhc3NlZCkNCj4gPiAg
IC0gVWJ1bnR1MjUuMDQvVWJ1bnR1MjQuMDQuMg0KPiA+ICAgLSBSSEVMOS42L1JIRUwxMA0KPiA+
ICAgLSBGZWRvcmE0Mg0KPiA+ICAgLSBGcmVlQlNEMTQuMg0KPiA+ICAgLSBTVVNFMTUuNg0KPiA+
ICAgLSBPcGVuQW5vbGlzOC4xMA0KPiA+ICAgLSBBenVyZUxpbnV4My4wDQo+ID4NCj4gPiAqIEZ1
bmN0aW9uIHRlc3RzOiBmb3VuZCAxIG5ldyBpc3N1ZS4NCj4gPiAgIC0gaTQwRS0oWFhWNzEwLCBY
NzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nDQo+ID4gYmFzaWMvUlRFX0ZMT1cv
VFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0NCj4gPiBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExB
Ti9SU1MsIGV0Yy4NCj4gPiAgIC0gSVhHQkUtKDgyNTk5KSBQRi9WRjogdGVzdCBzY2VuYXJpb3Mg
aW5jbHVkaW5nDQo+ID4gYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0NCj4g
PiBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCj4gPiAgIC0gSUNFLShF
ODEwLCBFMjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZw0KPiA+IGJhc2ljL1N3
aXRjaC9QYWNrYWdlIE1hbmFnZW1lbnQvRmxvdyBEaXJlY3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNl
ZA0KPiA+IFJTUy9BQ0wvRENGL0ZsZXhpYmxlIERlc2NyaXB0b3IsIGV0Yy4NCj4gPiAgIC0gSVBz
ZWM6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5
IGJhc2ljDQo+ID4gdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KPiA+ICAgLSBWaXJ0
aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQuIFN1Y2gg
YXMNCj4gPiBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1u
ZXQgVk0yVk0gcGVyZg0KPiA+IHRlc3RpbmcvVk1BV0FSRSBFU1hJIDguMCwgZXRjLg0KPiA+ICAg
LSBDcnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJDQo+ID4g
dGVzdGluZy9Db21wcmVzc0RldiBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMu
DQo+ID4gICAtIERMQjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIERMQjIuMCBhbmQgRExCMi41
DQo+ID4gICAtIE90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwg
Q0JETUEsIERTQQ0KPiA+DQo+ID4gKiBQZXJmb3JtYW5jZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFu
ZCBwYXNzZWQNCj4gPiAgIC0gVGhvdWdocHV0IFBlcmZvcm1hbmNlDQo+ID4gICAtIENyeXB0b2Rl
diBMYXRlbmN5DQo+ID4gICAtIFBGL1ZGIE5JQyBzaW5nbGUgY29yZQ0KPiA+ICAgLSBYWFY3MTAv
RTgxMCBOSUMgUGVyZm9ybWFuY2UNCj4gPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBYdSwgSGFp
bGluDQo+IA0KPiBUaGF0J3MgZ3JlYXQsIHRoYW5rIHlvdSENCg0KUmVnYXJkcywNClh1LCBIYWls
aW4NCg==
