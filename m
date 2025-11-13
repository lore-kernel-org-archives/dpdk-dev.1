Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF846CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 07:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D976140B92;
	Thu, 13 Nov 2025 08:18:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 44EFC40A6F;
 Thu, 13 Nov 2025 08:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763018305; x=1794554305;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=aAfRKpOvAStZZaGUAO61E0eF0GtnZAlWXuwMxIZMP7k=;
 b=JYaozgHUYkZFB+N4mCVydaS4p3bXia4NQibW0N6qHrfyo30WK2aaFhDY
 KqdRZT7l8xabDNJKkmsQmA1KFLt9hkg8B/3/JB8aulPUEn3cXfxTiDXWa
 UeNpzDLejYZ/0URocNPmUCK12Ahvr0VD9GPhxLfdtGgaD2wZ+Nnpejquo
 nesE8I6NRuPwWWKUSjX8qkRl5oi1S7PpP4qDwcF/kHBhuE34cDzPzQZBQ
 MLNnWBClT6W7UeL4CyvN0nnz9ALXzwPP+he7fAYRK72f9d5gYK8/TeX1B
 ber5Xco+zlSA6XdeTVtr1NDdpAW2lsBGj62z2iSZsTFtO0BwFwzZ0lBUX w==;
X-CSE-ConnectionGUID: Au2yde6lSaGqhB1WPRCfjA==
X-CSE-MsgGUID: JkMuQi0qSWi7xyAnjTcf1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64799293"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208,217";a="64799293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 23:18:23 -0800
X-CSE-ConnectionGUID: zEluL/hSQWKrmF9E8Cj03Q==
X-CSE-MsgGUID: JuckMnp9T8uHHyDazaFCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
 d="scan'208,217";a="189221810"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 23:18:23 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:18:22 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 23:18:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:18:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZwbGy3qF9IU6aD9yJYfAztvAw0rETNHlNr8KrSoYB5v8rkrSt5PrapUH2F9HAxphqQP3XNMBMDXLpwYyPJAjXCfCcyY6bOWsZiT1YwTA0teftYMkpgAXpfLDYi2HN5iLQ+qI+zgB6EIlyHrWGU2lHNvbBgoIVpJS8jl2XY3q9ADRSLuSQihUj+tBFwdmxyoZMyFWfZHTgigGlF/rxPQsAacxPLC24y3agN1quIlG0eWgOACzbscMFsYY1vTtZ2x8NCNCHuQT7p+p4+k6B4n5MqO3ijsAlsSNFY7MNJcjxNK9jiJzidVYD/FAKv1sSBPzcu04FVJfGGlBgrxwwHNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAfRKpOvAStZZaGUAO61E0eF0GtnZAlWXuwMxIZMP7k=;
 b=fLxGeCAv6hji7B52G5VaqoCvl0z8wD/2yNmdcKfD60Yin5SCzI3yHjjRr7InHxbqXhwM+wQeYXDzIKXvHFw3A6DzgxcUyhJkcNIoB9iqCRtskZg6y+ghA4mT3lVYiZyzwSzSD2vOvy6MqqmptqjCodnxBlRZApuFwQhz9XnP8y7h3/kcTn+VME7y59CNKEwg9jGAvskL3XCuemxVviPBk9fwZcucO3PjkTBJZ/Cfux6AF6j+JBQ1deKs/IdnyqhlLU16NpCwodBak0kQMOIGkJ8fyfn29tZeKhTG5uJMyQ1FAFywwdKocOsAqM8sKeSQ/lCzQ3ZfBuMhzi2DnKVxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPF4990C6B9D.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::826) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:18:14 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:18:14 +0000
From: "Zeng, ZhichaoX" <zhichaox.zeng@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>, Jeff Guo <jia.guo@intel.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBuZXQvaWNlOiBmaXggc3RhdGlzdGljcyByZWFk?=
 =?gb2312?Q?_error?=
Thread-Topic: [PATCH v2] net/ice: fix statistics read error
Thread-Index: AQHcUhX4mL8uYE6n+0GUZADBBdk9AbTu9L2AgAFBTSY=
Date: Thu, 13 Nov 2025 07:18:14 +0000
Message-ID: <CO6PR11MB56024C5A02FB7829E4AB8AECF1CDA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
 <20251110080514.2506769-1-zhichaox.zeng@intel.com>
 <aRR3u0Ady0ZbUbIn@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aRR3u0Ady0ZbUbIn@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SJ5PPF4990C6B9D:EE_
x-ms-office365-filtering-correlation-id: f79533a0-6943-4898-cd3a-08de2284cf6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?gb2312?B?RDYyNitmWGdGWFpVRzlpc0NnbEtUaHhpRitaeWFBaDhJMzB4amZIQUFJNVNR?=
 =?gb2312?B?MGF3Ti9LUGdmdzVhdWlFQ2YraXVoQ0hlNEhPV3NkcjZDNXVGTy81aFd0MGtp?=
 =?gb2312?B?TkZ0dVVENU1MMjlpNEF4QXYyckRrYlZxaU4rRGRoaVlqekxlQklydjg0WnM2?=
 =?gb2312?B?MHlQRjV0Z1FITGJjZDVSTE9xTHRZV0pQWWNQUGJpWitRRzBWdWVhbGNqdXVm?=
 =?gb2312?B?VmtmSi94QWJkRjNoUm9rL0JRclFpOFpTcUdMb0ZueGoyMGpNcTZUcDEveWd0?=
 =?gb2312?B?cXdZdUJJZDkwSXZibU9XUzZrR3loaXhyK1dGTWxpYzBBR1hKYzRObGhKMGs2?=
 =?gb2312?B?OU4vdlFvRytQQXozc2JaQ0hBQW9SMUdFZWNFa0JoU01iaHlNM0dhR1BSVTRS?=
 =?gb2312?B?eTljaHFJNWpTcEgvMjgrSTRDRFBHYzVDVGNqSU1aK2JBOWozYVlFWXYxMlFk?=
 =?gb2312?B?YlF6cTFVWmZvb2J1b1IxQjJMdkgvcmNNQ0U0UWh2bEhaZUFhRFFKVm1rRSta?=
 =?gb2312?B?Y1dQVTJGaU9oVHpoM29CeTRyV0JWWnNvSzhFWkJManptQWQxejBqWkpnYTlZ?=
 =?gb2312?B?d2VTUlV0aUVrT0x6MVRSVnY4SVpyRk5GMWpuZjVZdTBUZWhNNFRJbUZHblYw?=
 =?gb2312?B?d3RNaVhCQnQzTGVlWVBTZ2pxc1MxNDJjWHRGL0F4Mm9jbXorZEltNGtwM09v?=
 =?gb2312?B?N2s4SHl1RzFXRlUrOWJmWThLRFE1dTFXbXI1eEJ2VmZrd1EyK2JtM0lXK2dn?=
 =?gb2312?B?UzVmbm1PRnh5U3VtL3p1eDk4RC9DdEJraWJRTlIwYzlGS2hkZUg5QUZjb1pZ?=
 =?gb2312?B?L1hqVWt2MmZqQ3duak4xYW1pTU5oZkhiVnlNd3kxZUE1NkNhek5kOXBkNVVE?=
 =?gb2312?B?TTUwU0lsYy96elNRdVE0dVdhV2x2WHRyZ1UyUGNoL2ttN29aU3JSZnh2MWhG?=
 =?gb2312?B?d0Q0cHI1UlIzdjJ0Z21RamU5WDZJbmhBQ0c1OHgrMzdzVTFSRExwYkNYYTZa?=
 =?gb2312?B?Z0JaU0NTc0dWRld6NzZUeExhbjMyc0lha2szbHNUeDBUdURMcnVST242UGtq?=
 =?gb2312?B?RDFJVXZhNXZIOVVLQkdNQ2lWRjdRRWwvZ3Z1b2xUaDF5WFlBZVFqNkxFYzdK?=
 =?gb2312?B?Vk5xVldxRG0rNDExdGt0d1FGOHVRc0kwbitzbzEzak9lcDR6Q2RYcjl1MWVt?=
 =?gb2312?B?cTJzSkF4cTMzQVU1bS9XR1NFOUpMcTYzWVgzcE94T2JKQndwMWlJQjBPSzNz?=
 =?gb2312?B?ZFVlbFVBc0NiVjZKNUNOaWhKM1JRd05aNlEyaEhmK2FQakFSckVjcVhvNllE?=
 =?gb2312?B?LzJrWERPcVhyVjZtOU5OcExnUDJUNWpOZ1Vlb3dyWFpEV2RDYnBjVE94V1Zz?=
 =?gb2312?B?MkJ4anY1YzY1MzVwOWVOSUNpdUJzTHhXUS9uRUVTRWxlR21oWTZzdkk1cEZv?=
 =?gb2312?B?Rm04Y3owZjRKSkJwcmJxSDU3bHlHeWhBSU5JckNpS3Vybk1RRkFxN1FuNjJP?=
 =?gb2312?B?eTdOL25HU2tPdzZOZWREeDdlMWhyUmp1YkNTbXZFUXBUUG0zRFBoYU5SNkZp?=
 =?gb2312?B?aDk3dzJVTHJ6N1ltQVpnMkc4b2dGblRpWUFLUUlJSVR5b01mTkdzYlVGT2lz?=
 =?gb2312?B?YmU0RzNjRlhGeXFIZHBMUkJWaGVnRVRmVjF1NkErM3BXejhtZVo1Y3VBRFBp?=
 =?gb2312?B?QWx2cWFvcDVlaDQvcnNJdkYydGdYeERQbGJVYVFWT1IvV214L2JaS2x1cG43?=
 =?gb2312?B?Rnp4eVIwWFBrOWNPenRFUmEwWm5VMkYwSVpPdlkxcXN1L0IxQjBWR3VCamVP?=
 =?gb2312?B?RCtmMGQzSnMwZXh6OHNYYjg4eU5tYitQem8xb1V0YUNwQjN4eGJtRFVhZ0xs?=
 =?gb2312?B?QURlT3hPeThnNmYvUVVUY1FGL29jWFIyd2VnT3lhZGxEUXR5WFkwSnR4dW5T?=
 =?gb2312?B?WmNJVXg1RjQ3alN2TjhrOVNTR3JRVnhqZ0x5Nm9FTTl3UVBHSm1VS01kaVRQ?=
 =?gb2312?B?bytjeDh6S3k5RUl4d2NEUmEwSWszT1AxbjFuQTFkaHovVG1jK09TaEg1R3lJ?=
 =?gb2312?Q?BqUyfy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:CO6PR11MB5602.namprd11.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SWprREhsUW9VTTNEWWEzYVF5Wm9NN0E1SWhHNDlJS0VKeVRISUVXM3l6R2dp?=
 =?gb2312?B?VDIxMDhxcld0SXVQZVVqTll2bXN6S0M2ek51UkFzUE9SQnBKRDNiSmJHRUlN?=
 =?gb2312?B?aW5EcXdXMDlOT0VoMHpaL3ZCUWZpVm0vVGYvM0JjNHk1WFpmelBnZVBwMm5k?=
 =?gb2312?B?UWxoMUEvb1YwSXVXZndyZGNqTEovNExGNkdMZGFqSUlON0kxY2R4TThKZCtW?=
 =?gb2312?B?ZFdjZlBFQUlQK2pPWjhTcWNYNnV2V29MM2h1eFcvZU5mQkdieXZobzNiRGJy?=
 =?gb2312?B?d3FLQktiYmVONWt1WDc5OHB2OVhPWm5KK0VWRnFtS0RVZmtlL3FXYXkyUHow?=
 =?gb2312?B?TjFmM1NVdjVkdUZTZlRubWwzOTFzR3dWajVQUW1hWDRxdTZmcEI4NkdSSENm?=
 =?gb2312?B?a1plY3g5OWJmeVUvNHY1cHk3cFJBV3FUaDFtZnozN2lkUTNwZXZjcU1BUVVu?=
 =?gb2312?B?Yy9NVE4vT0l1SVVxdERucG50UWVtQXBLWVo4dUt0L3VGUDlGeU0vWGxsck1G?=
 =?gb2312?B?QmxOMm1WMHdja2cxRkJUNE1CaHk5eTgxbU9VWWxlaWoyc21PQmt2NittYklP?=
 =?gb2312?B?RzFabGlVR2ZVRGxrazZqb0o3MzNLYU9BUlZCZE9XR2JpZHFCbFJnM0l3QUM3?=
 =?gb2312?B?Zit0RnA3OWxjZFZaRkgzV0tiQ0d3emZRcXJ2NTh6cklqSTAvTjdNNWZPWUtB?=
 =?gb2312?B?N1FQbHVDVTk1cU13QTM3T0NveHpZTWpDWE5SNnd2OUxLdmpWT0srWmdpOThZ?=
 =?gb2312?B?Uzh2TTVXM0lOcG56dEdwUjNlMkFrR0ZvK3c4TkwvclVzOTB5bmxKS1JqekVR?=
 =?gb2312?B?ellJczFTdXl4MnViVUZvaVdBYW9mdjJobVZWbTAvTXVGN0VpcitUVjVjcndw?=
 =?gb2312?B?RlRaZURWNlBySGQzZ1pFVzlaalB6UDBIUWkvRktjVFFFZ3pRU3F2clBwVnRB?=
 =?gb2312?B?VjJzRVZtSGkwdFNwbG55MGpNUlc5Ri92OFRxanVMcXRtY1I3OHdLalRWVmlO?=
 =?gb2312?B?dG5ETE0xVnZPcHFtVFNDRzJYTXJJYXM1UVphaGdoajZPSlpyRTlTajBMT291?=
 =?gb2312?B?UkVyanpGKzFZZXY2dUlkQzIydUp6dUZLVnpTSVlZSkw1WGZVSlA1L1VSNlMz?=
 =?gb2312?B?bFhoSzR2UHVWeWpKQnZKU0M0VnJrY2pxOXArZHBKTytEeGFiNHdhNmZiOTlZ?=
 =?gb2312?B?YmZXRk9udmpRNWJ3TDJBVndxdDJRNERzb1NoYkUzUzZHNlMzNlBEMHJMeWhM?=
 =?gb2312?B?WFMwZEZJaUU5U2xkWHMrd2NaWE5JMGljSUhkV2thNWNabHphM085d29Lb2FF?=
 =?gb2312?B?Qzl0R1p0K2srVnRpMWxNOE91VXNVWXNJaTYrMEtubU9ITU1WWjJPWmVSWWkw?=
 =?gb2312?B?TnNTM2wvS0taN2dlTXlndVlOM3RQb2tyeHpvd1B2VUg2Y3R6QUpncXBNK0dV?=
 =?gb2312?B?VDAweFhkNDgyRGJuNXNkd2NjaGJhUmZCc1ovUzBtZU1rOGRqME9JalI5dkZa?=
 =?gb2312?B?KzJaMHJDSklCZzU0N0x5VmVCd3VwWGwvajlaYU9SbjB2U1QrdHp3ZjQ5ZG94?=
 =?gb2312?B?c2pqU0REdWhOcUNmNldWVDU1ckFvejNnaWRpTGx6MzZGZzFpY24xVU1ZQUJk?=
 =?gb2312?B?MjFtL05GSTErTjk5dGhUU3dIM3RhVVFJNU83OWtOamdrdzdDWmJxV2krbHVI?=
 =?gb2312?B?ZlNqVW9oOWhuQ3ZacnkveUJQenpML0ZTRHpuclNMK2QrczFtS0dQd0N2NGVr?=
 =?gb2312?B?RGFPZWYrUEdTclU4a0l4cGEwYW1JUkVWVEEvcFZ2bHpOOXNxdTNsUzhHV2J3?=
 =?gb2312?B?UU11VVorR0dHNU1vYnpOMlpRQ0VJZ200OWpKZndFdVdDVnlCUytSQ3Z5S1Iz?=
 =?gb2312?B?QlNUQThLaWI2a0JaV0xBZ0VuQk03anlza20wazhBQ3FONUFEaUxpbzMyeHFn?=
 =?gb2312?B?aDZXRDVnKzV2dlZqdGVLUVJESWs2ZHJhZm45WTVvUFQyb3NWS1BQWFM4UTU3?=
 =?gb2312?B?ekVLZmMrbWw1M3FnaGdjdDJLVEFJU1UxRCtMaC9iaWVBWHV4NXc0d2g4L2Uz?=
 =?gb2312?B?VUl3b0o3RzgySlR3OGF1clRFYk8vdzRUTDdOQWcwajkreGxxRnNMenpoWkU3?=
 =?gb2312?Q?wWcpJKHdLobvtw4sLA51c95ji?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR11MB56024C5A02FB7829E4AB8AECF1CDACO6PR11MB5602namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79533a0-6943-4898-cd3a-08de2284cf6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 07:18:14.3766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30hEhlIMO5gId039NIZfFHgF4ji98pS78PatHzfuM4fVm/Z1awL8objZD7tcMx5jSdOnRNeFNZkxy060PvXY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4990C6B9D
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

--_000_CO6PR11MB56024C5A02FB7829E4AB8AECF1CDACO6PR11MB5602namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgQnJ1Y2UsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cyBhbmQgeW91J3JlIHJpZ2h0
Lg0KDQpNeSBhcG9sb2dpZXOhqnNpbmNlIHRoaXMgcGF0Y2ggd2FzIHN1Ym1pdHRlZCBzb21lIHRp
bWUgYWdvLCBJIGxvc3QgdHJhY2sgb2YgdGhlIGNvbnRleHQgd2hlbiBzZW5kaW5nIHYyIGFuZCBt
YWRlIGFuIGluY29ycmVjdCBtb2RpZmljYXRpb24uIEknbGwgcmVtb3ZlIHRoZSBlcnJvbmVvdXMg
Y29kZS4NCg0KDQpSZWdhcmRzDQoNClpoaWNoYW8NCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCreivP7IyzogUmljaGFyZHNvbiwgQnJ1Y2UgPGJydWNlLnJpY2hhcmRzb25AaW50
ZWwuY29tPg0K0tG3osvNOiAyMDI1IMTqIDExINTCIDEyIMjVINDHxtrI/SAyMDowNA0KytW8/sjL
OiBaZW5nLCBaaGljaGFvWCA8emhpY2hhb3guemVuZ0BpbnRlbC5jb20+DQqzrcvNOiBkZXZAZHBk
ay5vcmcgPGRldkBkcGRrLm9yZz47IHN0YWJsZUBkcGRrLm9yZyA8c3RhYmxlQGRwZGsub3JnPjsg
QnVyYWtvdiwgQW5hdG9seSA8YW5hdG9seS5idXJha292QGludGVsLmNvbT47IEplZmYgR3VvIDxq
aWEuZ3VvQGludGVsLmNvbT47IEZlcnJ1aCBZaWdpdCA8ZmVycnVoLnlpZ2l0QGFtZC5jb20+OyBX
ZW56aHVvIEx1IDx3ZW56aHVvLmx1QGludGVsLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0ggdjJdIG5l
dC9pY2U6IGZpeCBzdGF0aXN0aWNzIHJlYWQgZXJyb3INCg0KT24gTW9uLCBOb3YgMTAsIDIwMjUg
YXQgMDQ6MDU6MTRQTSArMDgwMCwgWmhpY2hhbyBaZW5nIHdyb3RlOg0KPiBUaGUgc3RhdGlzdGlj
cyBjb250YWluIDQwIGJpdHMuIFRoZSBsb3dlciAzMiBiaXRzIGFyZSByZWFkIGZpcnN0LCBmb2xs
b3dlZA0KPiBieSB0aGUgdXBwZXIgOCBiaXRzLg0KPg0KPiBJbiBzb21lIGNhc2VzLCBhZnRlciBy
ZWFkaW5nIHRoZSBsb3dlciAzMiBiaXRzLCBhIGNhcnJ5IG9jY3VycyBmcm9tDQo+IHRoZSBsb3dl
ciBiaXRzLCB3aGljaCBjYXVzZXMgdGhlIGZpbmFsIHN0YXRpc3RpY3MgdG8gYmUgaW5jb3JyZWN0
Lg0KPg0KPiBUaGlzIGNvbW1pdCBmaXhlcyB0aGlzIGlzc3VlLg0KPg0KPiBGaXhlczogYTM3YmRl
NTYzMTRkICgibmV0L2ljZTogc3VwcG9ydCBzdGF0aXN0aWNzIikNCj4gQ2M6IHN0YWJsZUBkcGRr
Lm9yZw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGljaGFvIFplbmcgPHpoaWNoYW94LnplbmdAaW50
ZWwuY29tPg0KPg0KPiAtLS0NCj4gdjI6IHJlcGxhY2Ugc2luZ2xlIHJldHJpZXMgd2l0aCBsb29w
cw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2VfZXRoZGV2LmMgfCAxOCArKysr
KysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9l
dGhkZXYuYyBiL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2VfZXRoZGV2LmMNCj4gaW5kZXggNDY2
OWViYTdjNy4uMDE2YjI1YzYzYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvaW50ZWwvaWNl
L2ljZV9ldGhkZXYuYw0KPiArKysgYi9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2V0aGRldi5j
DQo+IEBAIC02MzUxLDEwICs2MzUxLDE2IEBAIGljZV9zdGF0X3VwZGF0ZV80MChzdHJ1Y3QgaWNl
X2h3ICpodywNCj4gICAgICAgICAgICAgICAgICAgdWludDY0X3QgKnN0YXQpDQo+ICB7DQo+ICAg
ICAgICB1aW50NjRfdCBuZXdfZGF0YTsNCj4gKyAgICAgdWludDMyX3QgbG9fb2xkLCBoaSwgbG87
DQo+DQo+IC0gICAgIG5ld19kYXRhID0gKHVpbnQ2NF90KUlDRV9SRUFEX1JFRyhodywgbG9yZWcp
Ow0KPiAtICAgICBuZXdfZGF0YSB8PSAodWludDY0X3QpKElDRV9SRUFEX1JFRyhodywgaGlyZWcp
ICYgSUNFXzhfQklUX01BU0spIDw8DQo+IC0gICAgICAgICAgICAgICAgIElDRV8zMl9CSVRfV0lE
VEg7DQo+ICsgICAgIGRvIHsNCj4gKyAgICAgICAgICAgICBsb19vbGQgPSBJQ0VfUkVBRF9SRUco
aHcsIGxvcmVnKTsNCj4gKyAgICAgICAgICAgICBoaSA9IElDRV9SRUFEX1JFRyhodywgaGlyZWcp
Ow0KPiArICAgICAgICAgICAgIGxvID0gSUNFX1JFQURfUkVHKGh3LCBsb3JlZyk7DQo+ICsgICAg
IH0gd2hpbGUgKGxvX29sZCA+IGxvKTsNCj4gKw0KPiArICAgICBuZXdfZGF0YSA9ICh1aW50NjRf
dClsbzsNCj4gKyAgICAgbmV3X2RhdGEgfD0gKHVpbnQ2NF90KShoaSAmIElDRV84X0JJVF9NQVNL
KSA8PCBJQ0VfMzJfQklUX1dJRFRIOw0KPg0KPiAgICAgICAgaWYgKCFvZmZzZXRfbG9hZGVkKQ0K
PiAgICAgICAgICAgICAgICAqb2Zmc2V0ID0gbmV3X2RhdGE7DQo+IEBAIC02MzYzLDEwICs2MzY5
LDggQEAgaWNlX3N0YXRfdXBkYXRlXzQwKHN0cnVjdCBpY2VfaHcgKmh3LA0KPiAgICAgICAgICAg
ICAgICAqc3RhdCA9IG5ld19kYXRhIC0gKm9mZnNldDsNCj4gICAgICAgIGVsc2UNCj4gICAgICAg
ICAgICAgICAgKnN0YXQgPSAodWludDY0X3QpKChuZXdfZGF0YSArDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoKHVpbnQ2NF90KTEgPDwgSUNFXzQwX0JJVF9XSURUSCkpIC0N
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKm9mZnNldCk7DQo+IC0NCj4gLSAg
ICAgKnN0YXQgJj0gSUNFXzQwX0JJVF9NQVNLOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgodWludDY0X3QpMSA8PCBJQ0VfMzJfQklUX1dJRFRIKSkNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLSAqb2Zmc2V0KTsNCg0KVGhpcyBwYXJ0IHdhc24n
dCBpbiB2MSwgd2FzIGl0PyBJdCBsb29rcyB3cm9uZyB0byBtZSwgYW5kIHRoZSBvcmlnaW5hbCBj
b2RlDQpsb29rcyBjb3JyZWN0LiBHaXZlbiB0aGF0IG9mZnNldCBhbmQgbmV3X2RhdGEgc2hvdWxk
IGJvdGggYmUgNDAtYml0DQpxdWFudGl0aWVzLCBhbnkgd3JhcGFyb3VuZCB3b3VsZCBiZSBhdCA0
MC1iaXRzIHJhdGhlciB0aGFuIDMyLWJpdHMgbm8/IENhbg0KeW91IGV4cGxhaW4gd2h5IHdlIHdv
dWxkIHVzZSBhIDMyLWJpdCBzaGlmdCBoZXJlPw0KDQo+ICB9DQo+DQo+ICAvKioNCj4gLS0NCj4g
Mi4zNC4xDQo+DQo=

--_000_CO6PR11MB56024C5A02FB7829E4AB8AECF1CDACO6PR11MB5602namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Bruce,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thank you for your comments and you're right.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
My apologies=A1=AAsince this patch was submitted some time ago, I lost trac=
k of the context when sending v2 and made an incorrect modification. I'll r=
emove the erroneous code.</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0in;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(36, 36, 36);">Regards</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0in;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(36, 36, 36);">Zhichao</span></p>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>=B7=A2=BC=FE=C8=CB:</b>&nbsp;Richardson, Bruce &lt;bruce.richardson@inte=
l.com&gt;<br>
<b>=D2=D1=B7=A2=CB=CD:</b>&nbsp;2025 =C4=EA 11 =D4=C2 12 =C8=D5 =D0=C7=C6=
=DA=C8=FD 20:04<br>
<b>=CA=D5=BC=FE=C8=CB:</b>&nbsp;Zeng, ZhichaoX &lt;zhichaox.zeng@intel.com&=
gt;<br>
<b>=B3=AD=CB=CD:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; stable@dpdk.or=
g &lt;stable@dpdk.org&gt;; Burakov, Anatoly &lt;anatoly.burakov@intel.com&g=
t;; Jeff Guo &lt;jia.guo@intel.com&gt;; Ferruh Yigit &lt;ferruh.yigit@amd.c=
om&gt;; Wenzhuo Lu &lt;wenzhuo.lu@intel.com&gt;<br>
<b>=D6=F7=CC=E2:</b>&nbsp;Re: [PATCH v2] net/ice: fix statistics read error=
 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On Mon, Nov 10, 2025 at 04:05:14PM +0800, Z=
hichao Zeng wrote:<br>
&gt; The statistics contain 40 bits. The lower 32 bits are read first, foll=
owed<br>
&gt; by the upper 8 bits.<br>
&gt;<br>
&gt; In some cases, after reading the lower 32 bits, a carry occurs from<br=
>
&gt; the lower bits, which causes the final statistics to be incorrect.<br>
&gt;<br>
&gt; This commit fixes this issue.<br>
&gt;<br>
&gt; Fixes: a37bde56314d (&quot;net/ice: support statistics&quot;)<br>
&gt; Cc: stable@dpdk.org<br>
&gt;<br>
&gt; Signed-off-by: Zhichao Zeng &lt;zhichaox.zeng@intel.com&gt;<br>
&gt;<br>
&gt; ---<br>
&gt; v2: replace single retries with loops<br>
&gt; ---<br>
&gt;&nbsp; drivers/net/intel/ice/ice_ethdev.c | 18 +++++++++++-------<br>
&gt;&nbsp; 1 file changed, 11 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ic=
e/ice_ethdev.c<br>
&gt; index 4669eba7c7..016b25c63a 100644<br>
&gt; --- a/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; +++ b/drivers/net/intel/ice/ice_ethdev.c<br>
&gt; @@ -6351,10 +6351,16 @@ ice_stat_update_40(struct ice_hw *hw,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *stat)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t new_data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t lo_old, hi, lo;<br>
&gt;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; new_data =3D (uint64_t)ICE_READ_REG(hw, lore=
g);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; new_data |=3D (uint64_t)(ICE_READ_REG(hw, hi=
reg) &amp; ICE_8_BIT_MASK) &lt;&lt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ICE_32_BIT_WIDTH;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lo_old =3D ICE_READ_REG(hw, loreg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hi =3D ICE_READ_REG(hw, hireg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lo =3D ICE_READ_REG(hw, loreg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } while (lo_old &gt; lo);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; new_data =3D (uint64_t)lo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; new_data |=3D (uint64_t)(hi &amp; ICE_8_BIT_=
MASK) &lt;&lt; ICE_32_BIT_WIDTH;<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!offset_loaded)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *offset =3D new_data;<br>
&gt; @@ -6363,10 +6369,8 @@ ice_stat_update_40(struct ice_hw *hw,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *stat =3D new_data - *offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *stat =3D (uint64_t)((new_data +<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64_t)1 &lt;&lt; ICE_=
40_BIT_WIDTH)) -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *stat &amp;=3D ICE_40_BIT_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((=
uint64_t)1 &lt;&lt; ICE_32_BIT_WIDTH))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - *offset);<br>
<br>
This part wasn't in v1, was it? It looks wrong to me, and the original code=
<br>
looks correct. Given that offset and new_data should both be 40-bit<br>
quantities, any wraparound would be at 40-bits rather than 32-bits no? Can<=
br>
you explain why we would use a 32-bit shift here?<br>
<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; /**<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</div>
</body>
</html>

--_000_CO6PR11MB56024C5A02FB7829E4AB8AECF1CDACO6PR11MB5602namp_--
