Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA6CCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 10:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CDBC40297;
	Thu,  9 Oct 2025 12:31:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6AA8340277;
 Thu,  9 Oct 2025 12:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760005865; x=1791541865;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3kIum0AIj+jfPLzHm6r/f3oHzCbeB4KKYia1ESLqjeA=;
 b=E8MiNYg+rIc+TSi4hd3p81eeHhvq9rTfwfO+85umLLUOC5hV7RGFIPHD
 VbFKQX3m7POVAOg853hxZX5b1cP6IqRbimRXx6rE1srivA9Vela+3rP4B
 Cyo1LzzjlU2WhMHqf/C+svMtMTlp2TGj9vHXdJ8YjABEIe2kp3J+C342p
 I6541Zs5kqtdl1aArOeKir/z+sxzgu+Pzt3ZIazEbxETo+DA8gt4o+HF/
 6f9SOlltreTZwtMa+ij867tVqY0VpKYtrGSjPEUSunUkogOM/UE7rL90P
 HcBsHiEOm/nBb0BH8rkQpZSQydzOqNfLtRUSLAsK1YoM3bwi7AdUrDf0u A==;
X-CSE-ConnectionGUID: kG0r9etGQoOzXT/ciOQCiw==
X-CSE-MsgGUID: kllmCGqJT5u/81KH/Ks3JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62254862"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="62254862"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:31:04 -0700
X-CSE-ConnectionGUID: P8+90SqLRAay2wNEpcAdlw==
X-CSE-MsgGUID: 2de2Y8bSS4aKNc60q7RPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179795291"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:31:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:31:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 03:31:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu991QQqtS5v2S+9DQhp/Gs2iGhAAytXXEcu+r76kI58xJG7429AlruhTqembV2nBwHWNk3z8S2QZPw75z75hSvtlBnkAUQaH7I7EBtKf/F4ipN1ne/y2aB56PzQG3zbdOdI0Y4L2qzjAkms1x2psL3N4Qrq4oYK+dAu2ipgO8yCGEKAC4VoYmscHhkbFXq+Lgrv6gccWwUTnYik9jhPWv6kjzWbCS6shFnwNVdz7FhEypYnfypudy7eox+9ml8PpIlua6hr8wS1kprcjOloE0HA6098pO41rOL8nYEW44A1KTfILZLrOP2iybkVBPTndXg1WXMrYSKXxQvP+6kccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kIum0AIj+jfPLzHm6r/f3oHzCbeB4KKYia1ESLqjeA=;
 b=qJUXkJ5Ob+vKP9/ZXeGCxP44N3kOUHL1Ifg3ikEb9O2Og6q2H+8JCbxLk+mm9rBW7594bIuL7qcPprcDTfZK77x9TzMUP5aOjZJEerNodgp1APyWUzMRxeiQZdGk4St/272J1s1XBpFhZ0CZvMXHBRBjgb4In52nhJcpbF8rBlRqtgFJ1jvZgErznpzgTdy6hET51WgzW/6Xll/6nzfvUvD6twKOos7iZPG1GMZKuUkUc8FsNNLStciRaqaL43z2Rh9LmoXHy/zGann8szDQO5vlltfK67yK6OKGEVDYFbUc3KwAcQU3cdhzP6+eyJ+thVnGtVOnmxvA/DnGDRZClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7DB70F9CE.namprd11.prod.outlook.com
 (2603:10b6:518:1::d33) by CY5PR11MB6342.namprd11.prod.outlook.com
 (2603:10b6:930:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.21; Thu, 9 Oct
 2025 10:30:56 +0000
Received: from PH3PPF7DB70F9CE.namprd11.prod.outlook.com
 ([fe80::49e8:6510:f781:6786]) by PH3PPF7DB70F9CE.namprd11.prod.outlook.com
 ([fe80::49e8:6510:f781:6786%8]) with mapi id 15.20.9137.018; Thu, 9 Oct 2025
 10:30:55 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoCAA0L78IAH2KkAgAGWzBA=
Date: Thu, 9 Oct 2025 10:30:55 +0000
Message-ID: <PH3PPF7DB70F9CE21D69B81237AB58593BD8EEEA@PH3PPF7DB70F9CE.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <DM3PPF7D18F34A105FE85AAA7D7387DDD838EE6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <DM3PPF7D18F34A1B51E203D4A7A495540958EE4A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <3977268.0vhOF50zNu@thomas>
In-Reply-To: <3977268.0vhOF50zNu@thomas>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7DB70F9CE:EE_|CY5PR11MB6342:EE_
x-ms-office365-filtering-correlation-id: b5be4f93-2d03-44d2-e863-08de071eeddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVh6NkFlcFZ3TlZlVW0yWUlaR2ppaHBkK3JiM2NkWE9ock84V2k0WUIvK2hz?=
 =?utf-8?B?dm56NVZNOVFLaE5nOVpHbGk5cFo2MmliWXhHT3g4Szh3N3dVRDdqQ2ZMQXNY?=
 =?utf-8?B?eW41cVRLcEpRWWRkUHNqUlk2M1Z1dmdLMmttMGZYTE1kTllQUXlzVGNuMmlE?=
 =?utf-8?B?WVpwMmEvZDZxWmxBTEJqQjNqZzZET3lZeTZjU2d4ZmhzdWx4c2I5MmpJS0JV?=
 =?utf-8?B?RmFuemhIUlNtdGpVTWZwQ0diWkdnMDhHaG93dmdkUk1ydE8rZEdwaEV3WGdX?=
 =?utf-8?B?dG1YOFhLTEJyd20vdE93TG5wQjY1MlBLZTNtY3hUTnRia3ZZd281ODdrOHk2?=
 =?utf-8?B?c1pBemJJcjZlU2tDQUdBN1RGS1hYOGFWT0RTbEIvNFkzSHJvUWxzS1E5YVBn?=
 =?utf-8?B?YU1hVXE3dnA3UkNFUHozOFNKU25EbUxlU3VXR0RDZkNySHo0WTgvMXMxcGhD?=
 =?utf-8?B?S3dYNWtOb0RkWndIUVlFenVlS3d0WHIyWnpSdEtEYWhpT0lqTGhGSHN2Rjd2?=
 =?utf-8?B?Mzk3K3NkVkZScWlkTnJoU25XYUZveVhCRkxWMjU2d0tiM1ZNV2dyUlVuWlc3?=
 =?utf-8?B?RjBwNjg1amRoaXkwMG5QSTh2TU1tZDArM0xmMnJHTEVKdlZkYk9MQnlnNnZV?=
 =?utf-8?B?cmsvTzR5ZEdiYlVTT3FuVzlXNTE5cmJId1QwcHpDNk54ZWROdU9pcG1nMDBq?=
 =?utf-8?B?V2NxU3RlWHQvV3BHRXBzWk5tK056L2djSlc1MjVsQ3YzMGdtU0lVYTZibSty?=
 =?utf-8?B?NGpsYmxxTzdXYWlVa1BZeTBDQ1UxbWxtOEpDQ3ZBM1ZnVHNpdXU1VFBESU1V?=
 =?utf-8?B?K3RiQTh2SVNyWVZCbVN6MFFvczlGMnNRRUJRK2gybXNGQVpvbTYvOEJzWUhx?=
 =?utf-8?B?cldTY0pNck9aVU5JWUVkTFRGZGNkWElXajRjSjduUkd0bVBsNzZ5aW15c1c2?=
 =?utf-8?B?elV0RmEwRmhRdU9mSlZCMHRHZHhhb2dKZW1TS2VLK045MjQ1c3BCdWd6ZTBW?=
 =?utf-8?B?NWdNelJKclVWVmtCNHZOaUpUTXg1M0szSyswZXk2UEpOb05yNnJoWXZueXZk?=
 =?utf-8?B?cG1iSGJVM3NNWmRGN3YrdFVJdnBxYUdwWnlzSnZpa21FRXhSbkRqaDFJM2ZV?=
 =?utf-8?B?cHE2WWh4YTVvVXE3b0UyYTNYeUhiQVVxZElFb1R4emdhUWdSaTQ0SVhCdEZH?=
 =?utf-8?B?eEMrTHpmcHM2M1NRUG9WY1BLUE9MUi9rZ3Y5ZWNQVjdJWUtQb29JWXg5YmpE?=
 =?utf-8?B?ekhXTzA1VzlSZDJrRkNjSG13MDVkL0E4VjlvV2pvaHgycHgzR3VIR0hIUkVP?=
 =?utf-8?B?a0kyWVJTWHNZdzRLMU10cUJ3ZllJVnVtWTVabHcyeWZYc1F2UVc4eGFmRktl?=
 =?utf-8?B?RUJCN015c09VV3kxeW9ENi9tYlRuUFQyTDNkcy80b21PVHM4L2Vacy8rSFZI?=
 =?utf-8?B?Q215TlVlWGkvWFJEY3NlRHFNZjFtVlE0bjV5SmMzQ1FOalNlUXNYT05YVm9s?=
 =?utf-8?B?Kzc0VHdCODV3dTg5TmxpSW5GZ3FwYlZ1R01wZW9ZRjIyRVVGKzVTR0ZpTzFO?=
 =?utf-8?B?UXhoVjREYjBCcTZIcUlYdlZGUzJCRUxJUGdCSGIrWTBvdGU5TjltNjFMMXA5?=
 =?utf-8?B?a3dsNUVmMk9qNmhZL21HREVRMFFzTkp6bXhub3lDSHJWeXZud3BLYlNXbWNy?=
 =?utf-8?B?VXk3M2FiYkxGYUw5QUZSR2FFcnpPTkloL3hHWldJRDJsU055T2lGVHFQMWJX?=
 =?utf-8?B?T2RFc2RkR3RJR3I1UEcxSTRxcU1qdUs3Z0N1V0VHYXdUT0l3Ky9zcE81WTV4?=
 =?utf-8?B?ZEU5ekJYZDJmUUUwODRkSUc2NjNSYWhsSkRFYVJuRlpWTjBNemV1MlRta0p4?=
 =?utf-8?B?MUswQzN0bnBBMEF6MHdaV082di92V09BMEZwV0RnRjV3MGZjaU9XVnBzVU5x?=
 =?utf-8?B?L1V3QTJHNVF2Rm1JOUt3dDR1WXFydTB2RmZjRE5FZ2JjVWJKK1NvczgrbVBh?=
 =?utf-8?B?U2NMVEJVck1EU0VlNkpyYmJ5QkVRYnZzdU9GTWRuUFNrQTRHWWR3UEluSnI4?=
 =?utf-8?Q?vNK+Qe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF7DB70F9CE.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1QQ3NGRnRNYk1FRE5CMURuTjJoTnozd2kxN1RFVU11ajdSdjFIdjJBMHQ3?=
 =?utf-8?B?ZVRKVFR0elQzLzBBeWVESHRzOGg4dEIwSWhlZ2l0K3ExL3d1b0ljVHBmS0lr?=
 =?utf-8?B?RmpBR2NiVFFUT0FENFBvTzkzdm9tNmQ5OVJLc0l0Y0F6N1h5a1pPVHFSZnZp?=
 =?utf-8?B?ZFNoMVpiUkpiMWV5OUpYZlpBQ0puWDRRMnZLR0x4Y1ZBZGlIS242U3RMcHJL?=
 =?utf-8?B?eGtkRUZlR1R2ZUtUblJ0NnRJUWRtSzFhSjY0V1I2Ujl3OUI4aTBPdS9vZmtB?=
 =?utf-8?B?UG1FVUxxTEJ3cDRnbkUxSVRvajREQnZIZHY0THIvVmdLL0xJWjFsYzU1TlAr?=
 =?utf-8?B?MXY2ZG9hQ3BGM3BWZEkvdy8rd0xNMGN0TVFabXgvQXBXZEdyaElZSVNVMmtV?=
 =?utf-8?B?ZFQxckFNVHZ1M1Y1L3oxVTZRVy9pL0tkTGVuNTE0bVdsc3dtb0JLNUZhNmRn?=
 =?utf-8?B?REhkZVZ5ckVtZmVCeWJYUmxrdGFleko1RUU4RmdXbi9rZXprU2IvNXA2Ykd2?=
 =?utf-8?B?SFZkUEdWR3BVNjlBUnlJVG9Fd1R4bU5ZekVFRUJtL05TZWdmcGZKREZ1cjZQ?=
 =?utf-8?B?bXFOTXVHSDc1cWlQZW5MaFFpOUhoKy9BZUxyb3N1YVNjWUZ4Rmo1QjRwM2RE?=
 =?utf-8?B?WWhxQVQ3VnhCT0lUczl0N3hJVFJlT0ExdklpdjJ6ZVY1TWw4Wk8yOHpVbHE3?=
 =?utf-8?B?SkcrTGI5bHBqckdnVXlPU29SNUs1OHMxTzcwejl4MGdGUnR4VXZXaE5vbjdC?=
 =?utf-8?B?RG0vUlZwSUp2SXNPSzhmZlVjMmtxR2ttd0hlak03YUE3QVdPTkZ6cVJzK0hX?=
 =?utf-8?B?MytXSXpiVEV3aTRHd3FHdnhvOGY5Y3JPcVZkUUtOd1V3ZnU0KzVBaWxGN2Yv?=
 =?utf-8?B?Zm9KaG1hamkvS2RBeU5mSFg0cjl6dG5ObjFkbHpZTThHLy9tdUN2ejJBNVRs?=
 =?utf-8?B?alkxM2o2cnRQYWNJNTRwUEJSbVZnNTdzcVNKYWVvMW92Q2srN2Z2azdQUmpq?=
 =?utf-8?B?c0xrL2FZNkZ4WWJXa2cxTVZBOVljc0JMbGlWSm1CSlNuYnowUnB1dmlBQ3VX?=
 =?utf-8?B?dy9LNGZOY0YrN0Ivb0YzVWppL1llSlNOb0wrdnFTTHdGNzVIMFVSMVhWZnZv?=
 =?utf-8?B?T1B6UnU0eHhmNWJ2dXdmZG5uUThCRllZalFhODJhVkh3cWN6SURQNmgveVEr?=
 =?utf-8?B?bVVGY05CMDN5UGpRM1hJZ1JZTXA3MStkK2xQdXpwK2o5VE1JRjNzTTNRdWU5?=
 =?utf-8?B?QnhpSDBKd2NyWUtiRzlmbHlPRHAvd2xnaFpoUUJRd2lsRnNXY29TNE56U3Vx?=
 =?utf-8?B?WjJXY1JUNk9DRnBvd01FNmhLajBORDR4dmRkWnVpNGlQMHpVZG1oL1VYeEkr?=
 =?utf-8?B?d3Y0eGJDSlZieGY2NEN3bFkvcGJOdHJZQUJPR1liZTVZaWt3bTN1d3BreUtX?=
 =?utf-8?B?azA5aUgrRjFtdzYwQ2M3OUZESlI5dHJBcHFWRmhxOWlBSUUrQmNva1FuNkdv?=
 =?utf-8?B?cG51NXRidlBzc3pvd1AyajRHdkRzVnRKanlBNFdyYkVHd3pvT3ZIUi9sZ0pU?=
 =?utf-8?B?WDRzbGZSTThtdG9DZHUxZWg5Q2ZyL1BkZ0xtbURkRSsrSHhCSG9MNUwyNUxV?=
 =?utf-8?B?WXJWaS9QYWIvUHRkYnFVejFlS2psTkJPRDdNVU9WZU9QcFMyNDR1VVNWb2FC?=
 =?utf-8?B?ajRWZG9pbHZaNFhZbVROUVd4L3NUQnpneDVpbHBYQ3plZjk4Mnp2OHhwUlI3?=
 =?utf-8?B?L2hTclFjVDFnRVY5VnRuVDMrbXBoTzBvNGhnK0JOeG9PRHJZRmdrUnJWSU1i?=
 =?utf-8?B?bXFReDNuNGJtWEQ1L0I0MG43U05lak8vZFBINUtlaytWTXA1RjlwQlRLYTdx?=
 =?utf-8?B?aVBldUkralBNYjVFeHZMUzZkaEtod1IwNkZsczloMTZ2QW1aQkV0dXpyWnpL?=
 =?utf-8?B?dFlndUVZUSsrWVVKY3Q5M3NybmFIZHV4QXZMSFdweW9oRGJJd24rUzNKN1B0?=
 =?utf-8?B?SjlYa09DVXV4ckttV3BBbVdmM2QvY09MVGpjbVhtbHdVbi9RRmtDRDAyMFYr?=
 =?utf-8?B?OGtEaW9GczhzTmxMUmJvTlJHYXBEalZxa1pvRzJkQ29vKzQrb1hWS0U1c0ww?=
 =?utf-8?Q?UnpCn1coX+DDcv6zon1ABYtjs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7DB70F9CE.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5be4f93-2d03-44d2-e863-08de071eeddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:30:55.3660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMXeQ0A2MIwCFjgIv+hcsr2h4ujko/Yx55LLWMr6a/NnK3qhk8y/jjyxuORCTzydmXMM4Q00OuGEGQp7+OR0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
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

PiANCj4gMDMvMTAvMjAyNSAxMjoyOSwgTG9mdHVzLCBDaWFyYToNCj4gPiA+ID4gPiBJbnRyb2R1
Y2UgYSBmdW5jdGlvbiB0aGF0IGFsbG93cyBhIFZGIHRvIHJlcXVlc3QgdGhlIFBGIHRvIHJlc2V0
IGl0c2VsZi4NCj4gPiA+ID4gPiBUaGlzIGlzIHVzZWZ1bCBmb3IgZXhhbXBsZSB3aGVuIHRoZSBh
cHBsaWNhdGlvbiBkZXRlY3RzIHRoYXQgb25lIG9mIHRoZQ0KPiA+ID4gPiA+IHF1ZXVlcyBoYXZl
IGh1bmcgb3IgYW55IGV2ZW50IHdoZXJlIGEgcmVzZXQgaXMgcmVxdWlyZWQgYW5kIHRoZSBQRiBp
cw0KPiA+ID4gPiA+IHVubGlrZWx5IHRvIHRyaWdnZXIgaXQuDQo+ID4gPiA+ID4NCj4gWy4uLl0N
Cj4gPiA+ID4NCj4gPiA+ID4gSW4gZ2VuZXJhbCwgSSdtIG5vdCBhIGh1Z2UgZmFuIG9mIGFkZGlu
ZyBkcml2ZXItc3BlY2lmaWMgZnVuY3Rpb25zIGFuZCBJDQo+ID4gPiA+IGZlZWwgbGlrZSB0aGlz
IHNob3VsZCBmaXQgdW5kZXIgdGhlIGV4aXN0aW5nIHJlc2V0IEFQSXMgaW4gc29tZSB3YXkuIFRo
YXQNCj4gPiA+ID4gc2hvdWxkIGF2b2lkIHRoZSBuZWVkIHRvIHVwZGF0ZSAob3Igc3VjaCBhIGJp
ZyB1cGRhdGUpIHRvIHRlc3RwbWQsIGZvcg0KPiA+ID4gPiBleGFtcGxlLg0KPiA+ID4gPiBTb21l
IHRob3VnaHRzIGhlcmU6DQo+ID4gPiA+DQo+ID4gPiA+IDEuIHdlIGNvdWxkIGFkZCBhIGRldmFy
ZyB0byB0aGUgZHJpdmVyIHRvIGFkanVzdCB3aGV0aGVyIHJlc2V0IGRvZXMgYQ0KPiA+ID4gPiAg
ICAic29mdGVyIiByZXNldCBvZiB0aGUgVkYganVzdCByZXNldHRpbmcgaXRzZWxmLCBvciBhICJo
YXJkIiByZXNldCB3aGVyZSB0aGUNCj4gPiA+ID4gICAgUEYgZG9lcyBhIGZ1bGxlciByZXNldCBv
ZiB0aGUgVkYuDQo+ID4gPiA+IDIuIHJhdGhlciB0aGFuIGEgZGV2YXJnLCB3b3VsZCBkbyB1c2Ug
YSBkcml2ZXItc3BlY2lmaWMgZnVuY3Rpb24gdG8gYWRqdXN0DQo+ID4gPiA+ICAgIHRoaXMgYmVo
YXZpb3VyLiBUaGUgZGlmZmVyZW5jZSBoZXJlIHdvdWxkIGJlIHRoYXQgdGhlIGRyaXZlci1zcGVj
aWZpYw0KPiA+ID4gPiAgICBmdW5jdGlvbiB3b3VsZCBiZSBhbiBpbml0LXRpbWUgb25lIHJhdGhl
ciB0aGFuIHJ1bnRpbWUsIHNvIHRoZSBydW50aW1lDQo+IG9mDQo+ID4gPiA+ICAgIHRoZSBhcHAs
IGxpa2UgdGVzdHBtZCwgd291bGQgYmUgZ2VuZXJpYy4NCj4gPiA+ID4gMy4gdGhlIG1vc3QgZ2Vu
ZXJpYyBzb2x1dGlvbiB3b3VsZCBiZSB0byBhZGQgYW4gYWRkaXRpb25hbCBwYXJhbWV0ZXIgdG8N
Cj4gdGhlDQo+ID4gPiA+ICAgIHJlc2V0KCkgZnVuY3Rpb24gaXRzZWxmIHRvIHNwZWNpZnkgYSBo
YXJkIG9yIHNvZnQgcmVzZXQuIFRoaXMgd291bGQgbWVhbg0KPiA+ID4gPiAgICB1cGRhdGluZyBh
bGwgZHJpdmVycyB0byBoYW5kbGUgdGhlIG5ldyBwYXJhbWV0ZXIgKHNob3VsZG4ndCBiZSBoYXJk
LA0KPiBzaW5jZQ0KPiA+ID4gPiAgICBpdCB3b3VsZCBiZSBfX3J0ZV91bnVzZWQgaW4gYWxsIGNh
c2VzIGJ5IGRlZmF1bHQpLiBUaGlzIGFsc28gb3BlbnMgdXANCj4gPiA+ID4gICAgdGhlIHBvc3Np
YmlsaXR5IG9mIG90aGVyIGRyaXZlcnMgLSBlc3BlY2lhbGx5IFZGcyAtIHVzaW5nIGl0IGluIHRo
ZSBzYW1lDQo+ID4gPiA+ICAgIHdheS4gV2UgY291bGQgYWN0dWFsbHkgZG9jdW1lbnQgdGhhdCB0
aGUgImhhcmQiIG9wdGlvbiAibWF5IGJlIHVzZWQNCj4gYnkNCj4gPiA+IFZGDQo+ID4gPiA+ICAg
IGRyaXZlcnMgdG8gcmVxdWVzdCBhIGZ1bGwgcmVzZXQgb2YgdGhlIFZGIGJ5IHRoZSBQRiIuDQo+
ID4gPg0KPiA+ID4gSGkgQnJ1Y2UsDQo+ID4gPg0KPiA+ID4gSSBkaWQgbm90IG1ha2UgaXQgY2xl
YXIgaW4gbXkgY29tbWl0IG1lc3NhZ2VzIHRoZSBmdWxsIHB1cnBvc2Ugb2YgdGhpcyBuZXcNCj4g
QVBJLg0KPiA+ID4gQWxvbmcgd2l0aCByZXNldHRpbmcgdGhlIFZGLCB0aGUgVkYgaXMgYWxzbyBy
ZWNvbmZpZ3VyZWQgYW5kIHJlc3RhcnRlZA0KPiA+ID4gdHJhbnNwYXJlbnRseSwgdXNpbmcgdGhl
IGV4aXN0aW5nIGlhdmZfaGFuZGxlX2h3X3Jlc2V0IGltcGxlbWVudGF0aW9uLg0KPiA+ID4gV2hp
bGUgdGhlcmUgaXMgcHJvYmFibHkgbWVyaXQgaW4gZXh0ZW5kaW5nIHRoZSByZXNldCBBUEkgdG8g
aW5jbHVkZSBhDQo+IHNvZnQvaGFyZA0KPiA+ID4gcmVzZXQgZmxhZywgSSB3b3VsZCBzdGlsbCBu
ZWVkIHRoaXMgbmV3IEFQSSB0byBmdWxmaWwgdGhlIHB1cnBvc2UgZGVzY3JpYmVkDQo+IGFib3Zl
Lg0KPiA+ID4gSWYgd2Ugd2FudGVkIHRvIG1ha2UgdGhpcyBnZW5lcmljIEkgc2VlIHR3byBvcHRp
b25zOg0KPiA+ID4gMS4gZXh0ZW5kIHRoZSByZXNldCBBUEkgdG8gb3B0aW9uYWxseSByZWNvbmZp
Z3VyZSBhbmQgcmVzdGFydA0KPiA+ID4gMi4gaW50cm9kdWNlIGEgbmV3IGdlbmVyaWMgQVBJIHRo
YXQgcGVyZm9ybXMgYSByZXNldCBmb2xsb3dlZCBieSBhDQo+IHJlY29uZmlndXJlDQo+ID4gPiBh
bmQgcmVzdGFydC4NCj4gPg0KPiA+IEkndmUgc3VibWl0dGVkIGEgdjIgYW5kIHJlbmFtZWQgdGhl
IGZ1bmN0aW9uIHRvICJyZXN0b3JlIiBpbnN0ZWFkIG9mICJyZXNldCINCj4gdG8NCj4gPiBiZXR0
ZXIgZGVzY3JpYmUgdGhlIGJlaGF2aW91ciBvZiB0aGUgZnVuY3Rpb24gLSBub3QganVzdCByZXNl
dHRpbmcsIGJ1dCBhbHNvDQo+ID4gcmVzdG9yaW5nIGNvbmZpZ3VyYXRpb24gYWZ0ZXJ3YXJkcyBh
bmQgcmVzdGFydGluZyB0aGUgZGV2aWNlLg0KPiA+DQo+ID4gSSBhZ3JlZSB0aGF0IGl0IHdvdWxk
IGJlIGJlc3QgdG8gYXZvaWQgYSBkcml2ZXItc3BlY2lmaWMgZnVuY3Rpb24gbGlrZSB0aGlzLiBB
ZnRlcg0KPiBzb21lDQo+ID4gdGhvdWdodCBJIGRvbid0IHRoaW5rIHdlIGNhbiBleHRlbmQgdGhl
IHJlc2V0IEFQSSB0byBpbmNsdWRlIHRoaXMgYmVoYXZpb3VyLA0KPiB0aGUNCj4gPiByZXNldCBB
UEkgc2hvdWxkIHByb2JhYmx5IGxlYXZlIHRoZSBkZXZpY2UgaW4gYSByZXNldCBzdGF0ZS4NCj4g
Pg0KPiA+IEknbSB3b25kZXJpbmcgaWYgdGhlIGNvbW11bml0eSB3b3VsZCBiZSBpbiBmYXZvdXIg
b2YgY3JlYXRpbmcgYSBuZXcgZXRoZGV2DQo+IEFQSQ0KPiA+IGZvciByZXN0b3JpbmcvcmVpbml0
aWFsaXNpbmcgYSBkZXZpY2UuIEl0IHdvdWxkIGVzc2VudGlhbGx5IGNvbXByaXNlIG9mIHJlc2V0
LA0KPiA+IHJlY29uZmlndXJlIGFuZCBxdWV1ZSBzZXR1cCwgYW5kIG9wdGlvbmFsbHkgZGV2aWNl
IHN0YXJ0Pw0KPiANCj4gSXQgaXMgY29uZnVzaW5nIHRvIGFkZCBhbiBBUEkgaWYgaXQgaXMgYSBw
ZXJmZWN0IG92ZXJsYXANCj4gb2Ygd2hhdCBleGlzdHMgYWxyZWFkeS4NCj4gSWYgeW91IHdhbnQg
dG8gYWRkIGEgbmV3IEFQSSwgeW91IG5lZWQgdG8gZXhwbGFpbiBob3cgaXQgaXMgZGlmZmVyZW50
DQo+IG9mIGEgY29tYmluYXRpb24gb2YgcmVzZXQvY29uZmlndXJlL3N0YXJ0Lg0KDQpBcG9sb2dp
ZXMgZm9yIGFueSBjb25mdXNpb24uDQpUaGUgbmV3IEFQSSB3b3VsZCBwZXJmb3JtIG9ubHkgdGhl
IG5lY2Vzc2FyeSByZWNvbmZpZ3VyYXRpb24NCmFuZCBzZXR1cCBzdGVwcyB1bmRlci10aGUtaG9v
ZCBhbmQgdXNlIHRoZSBleGlzdGluZyBkZXZpY2UNCmNvbmZpZ3VyYXRpb24uIFRoaXMgd291bGQg
ZGlmZmVyIGZyb20gYSBjb21iaW5hdGlvbiBvZg0KcmVzZXQvcmVjb25maWd1cmUvc3RhcnQgaW4g
dHdvIHdheXM6DQoxLiBJbiBzb21lIGNhc2VzIChhdCBsZWFzdCBpbiB0aGUgY2FzZSBvZiB0aGUg
aWF2ZiBkcml2ZXIpLCBhDQpmdWxsIHJ0ZV9ldGhfZGV2X2NvbmZpZ3VyZSBpcyBub3QgcmVxdWly
ZWQgYWZ0ZXIgYW4gcnRlX2V0aF9kZXZfcmVzZXQuDQpTbyB0aGUgbmV3IEFQSSBjb3VsZCBqdXN0
IGNhbGwgdGhlIGRldmljZSBjYWxsYmFja3MgZm9yIHRob3NlIGZ1bmN0aW9ucywNCnJhdGhlciB0
aGFuIGZvcmNpbmcgdGhlIHVzZXIgdG8gY2FsbCB0aGUgZXRoZGV2IGZ1bmN0aW9ucyBhbmQgcGVy
Zm9ybQ0Kc29tZSB1bm5lY2Vzc2FyeSByZWNvbmZpZ3VyYXRpb24gc3RlcHMuDQoyLiBJdCB0YWtl
cyB0aGUgYnVyZGVuIG9mZiB0aGUgdXNlciB0byBidWlsZCB1cCB0aGUgZGV2aWNlIGNvbmZpZ3Vy
YXRpb24NCmFnYWluIGFmdGVyIHRoZSByZXNldC4gQW55IHBlcnRpbmVudCBjb25maWd1cmF0aW9u
IGNhbiBiZSBzdG9yZWQgYmVmb3JlDQp0aGUgcmVzZXQgYW5kIHVzZWQgdG8gcmVjb25maWd1cmUg
dGhlIGRldmljZSB0cmFuc3BhcmVudGx5LiBBbGwgdGhlIHVzZXINCm5lZWRzIHRvIHN1cHBseSBp
cyB0aGUgcG9ydCBpZC4NCg0KQW55d2F5LCBJJ3ZlIHN1Ym1pdHRlZCBhIHYzIG9mIHRoZSBub24t
Z2VuZXJpYyB2ZXJzaW9uIG9mIHRoaXMgZm9yIHRoZQ0KaWF2ZiBkcml2ZXIsIHNvIGlmIHRoZXJl
IGlzIG5vIGFwcGV0aXRlIGZvciB0aGUgZ2VuZXJpYyBhcHByb2FjaCBJJ2xsDQpjb250aW51ZSB0
byBwdXJzdWUgdGhlIGRyaXZlci1zcGVjaWZpYyBvbmUuDQoNClRoYW5rcywNCkNpYXJhDQoNCg==
