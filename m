Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0082EFEA83B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 10:03:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FDC3402CE;
	Wed, 25 Mar 2026 11:03:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 073E64028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774432999; x=1805968999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gX0kc68Ptjqv6isJ81b9MKZ5ShJm+qPFhlDRz4O8ATY=;
 b=G+op5ZHd3kJQtIt+zhDiEC4Q1Ay0NqmEPTsCKtIHrgl2RHDtx/qP8dqT
 rQYIQlLVsl04aj+nmxc9yeWphg0ph542Jn3CwWPeiQX5t/1Ensh6GTZOr
 vw4b0COU5+aCm9EPvVR+yi26aOGXlMGq7NtsXUI2vy5LdF/vfKLAdvTk6
 RCkjLR6li98/KSi/6hYLwZE9aI+mK6UtS0bqJWhX/BSaPauC6QRHRmUgd
 nzI/dSG+9qDa6JO+JoqUt0ksJUUCsFyZGx0ck9IzwcOU84Cw6sVBBM8/7
 szh2lG7F0H51qGs30fZsWTr+55Q0j19RFez9JUf6VGp6d7BSUOX4SuH7m Q==;
X-CSE-ConnectionGUID: XTpBVwdyRISWpCjpt0EZog==
X-CSE-MsgGUID: 4vYNBLXiQn6T3r0NxN8EIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="92845704"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="92845704"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 03:03:18 -0700
X-CSE-ConnectionGUID: kh8ZxhFeRlC1a9pqjDIscw==
X-CSE-MsgGUID: rA2JCYl8TMKxcCAwZoNfpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="223696896"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 03:03:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 03:03:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 03:03:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 03:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1wsjBatHgcT7AqMmsiUSlPKCnt+dOVyIORDa1X3ljI7xR/5IsXzIM7/xgeVIQYffAOc2ExNwzV1xfLaiuQeLgGTPcKASJUSP2SlNRMKFh+WfChfqsoARSl2BCsRs5db1Uklkz0MOwAwOrh94eEXUQ2rcRW+4cqFGad0L/luXb2zIykiZyFOYXTCCtOpqA57cVymds9fkQVmMISl6Ix39K98Ej2w4maOjiI4REdt5Pd5/5LQphpLJ9jAcanON4dGSluOqsxrKfh0tv1kJbiyNp+yhb87DOQ4cTY9wOAf6JJd2p0MOKnDpak0fLYNznAg66DD6VjcM4Uo1iqOxWhIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX0kc68Ptjqv6isJ81b9MKZ5ShJm+qPFhlDRz4O8ATY=;
 b=T7kEcaHNtrpf5cPWGpaYxLslH4ub80gz5NOT7c4yDClICH2wfawaUpQHGiQCT7Q0OVSoUVVI5scil4/IpCYodgmbvztiQGA+U5BEC5RBz6vFiL7JwnzOEfCtJkOIYEUjEoNdM5ax79tx30NZKPenePUlzb9aRc0GaVBYw/1DAJK5S8tXf1q/XNuYJPTA4yhxbX6CVMTyTN2hjnU/w0F6IMxPYZAPksORVi/Va1PUJcxg0DDaxzeUA9N6pFw+voHfIsK0u9tAuMMLfNNfwikzZkoeH3fIEYcr/T58J9Hhc5rYcuVsGimkQb7+mNs+DwnuODPnzEMqF8XBnjksNBz/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by MW6PR11MB8311.namprd11.prod.outlook.com (2603:10b6:303:241::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 25 Mar
 2026 10:03:10 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::345a:4216:d548:1510]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::345a:4216:d548:1510%8]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 10:03:10 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: RE: DPDK release candidate 26.03-rc2
Thread-Topic: DPDK release candidate 26.03-rc2
Thread-Index: AQHctjHjhkHm0yVNIkaTPvyQCEP4GbWzmC+AgAt0DgA=
Date: Wed, 25 Mar 2026 10:03:09 +0000
Message-ID: <DS4PPF00BBED10C5B7DD76BE42F9FF4FA7F9F49A@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <2739036.tIAgqjz4sF@thomas>
 <MW4PR11MB57997614FC076E2B27E6CE259D4EA@MW4PR11MB5799.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB57997614FC076E2B27E6CE259D4EA@MW4PR11MB5799.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|MW6PR11MB8311:EE_
x-ms-office365-filtering-correlation-id: 59c4ced7-267e-49d6-7ceb-08de8a55b846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: FvRmrKbgkhzmLThkl4ItkwUpSK/WMERO52lC6xGPOEkRCP6nByoEFCEWwL6g3gFeW5in+4DvPYHvNMHfqEdnF0f6ZKIzwxwCODatxbzHy8+aQTyyA7fgFrZdpxKSkzc6MhmnUDedcZGG9C5UNEc+mRFPl+VBmpDCJF+mATav7+Zo6BJTLN7TpLxvi6fiMAl2UZGzUsuouRzH12ME0ypx9+NuFcrPSGoamUICI2s1IYXGVRjwbEIMyuplxRTEuxU1ofnq0GNhT5GyNfOTlsAfFVyC/JxBZdKSF7m+ts7iLPIDR9q0aH9AgNv/qpEQYILu7TO6zplCjwFXBCzycnSX1VerTxZQctGzDLUyDhR0C0Eaa1zD63nTaoH0y2JhHlEMIqk/VjJg+Fy0gcM71wKaNX1r8+3VFSPnAbip/yVQjSRAcBHTcJ+NIaPtesg0lkk5BMBAvdElbNlvxdjR4BtGud/AXBUqPvFwyzH2jO430Z9oZcLOgyYLmY0FfPlNpueWyvUJOyOILyKngag1ExV0sv3ZZRjPdjda6I4LmDkPOMRfmuBDYiUj/dxP7oPLzjkBsl+gFQor1m+klaN2D3ArEVc29f2iC/RnNQ2DwYYc2X730OaJLeFBd/Tk6q9EZAD6tTObOrVQvPUn0e0VZiMlEm77baJTzgEEmdci9C+ns2MC+TBkGbb7QoSSTH0eREi2AkGbrkN2yLyicsBnCrBvKAOSePd3CFY2EdXH/QWNygjVkXgYpT2/DytY3n12as/1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWh2dXF1L0RSTkpZa3p0eFNYdEgwMXJuQlFlR2x0N3JNNnVVZTFselVEREJ0?=
 =?utf-8?B?YWtJeTdhbTh3YmRTd1dxUUZrT3RLbEkwS2V0TFRyeHFvRVI3VzlKSm5hK2ZD?=
 =?utf-8?B?UDBsWG9Cb1NWYTR3Yk5OTzM4R0lSam9uL3IvbWR0TFNzMlpPSlF2R0g2Mkpv?=
 =?utf-8?B?d3NPRUVUbC9hQWNrQzJMZ1Z3ZEQ1d3kyQjNQTGhYMzZXNGZzZWltbmczbm1B?=
 =?utf-8?B?dUp5cVR4L3B3elc4TmhHaXBMYzNFeGk2YTVobVUyMUNNSnRLQjBrZG1PM1lm?=
 =?utf-8?B?TzJ3NDZSd3hRa3d0LzRZcU9PcEVpN2lhSjN6bUdOR1JsellZU2FmenRxQ1JT?=
 =?utf-8?B?Qnd6TzVmTHJNQ3JkUkdBckphZjMreWtLSFk0UFZKR3IvZHJ0Z0k1endrTDY5?=
 =?utf-8?B?VUl2akRmd2ZVd1dUd3VKcGtBcXVUeEpNOUdReDhvTHA1TVdmVU1SZGFPVENY?=
 =?utf-8?B?emtieVpjOThVMXFsdDlPUHptQlpaSzVaQTVuRTh0d1ZzeW9zRWQ4SXdHU01C?=
 =?utf-8?B?WDErNmpCcmlSbDIrRjdwd2gyZXg2d2toTG1DMnMyd2hVZ2xTNU95MVorZHQ5?=
 =?utf-8?B?VjJzenRCM0ozOHJ0U09MTXdqYnh6U3JGZFE5cTZlSlozWDhKQnZ0TTdPZzBa?=
 =?utf-8?B?VXNDV0UzRW0zQkpwS1VrRFlGS2o0TTI4R0puV1p6U3hVN2lLbm12QTdOSHhF?=
 =?utf-8?B?NmFYQkw0azB3Q2dYUmdoblR1ZFk3V2QyV0NVdTRDVlpGR3M4YUNkUDRRVDh3?=
 =?utf-8?B?UEN5UURqUjE2ci95RURHM3h5d0VqMEllVnYyUnR4bG1MMzRSWWUwVXE2SXYr?=
 =?utf-8?B?SHh0ZFVnMjZ4Y252TmNlbHpQdUZpOEk2SG84OHg4MXpEMHRaeW42dlE1NHlo?=
 =?utf-8?B?aWs2cUdwNVN0ZG5qOTA0Y0hPcUMvd1ZmWEIwU3VEMzBPeVZ3TTh4WnNCOXRK?=
 =?utf-8?B?eUtZMmlGbzFyOG5BNEsrMVpoZGh2ZHBMTG01QVFGcjVnZ0wvdU5jYUd5Rlhr?=
 =?utf-8?B?eEh4aDEyNVpuTlBIWkNjRjlmN3c2cU5hV1dSRW9jZm5OVGtiR2F2Ui84eWcr?=
 =?utf-8?B?YmFTbFYzSENRVmh3V2NIOURqZGE4Z0F0T2xHeUlkS09BdWFsSnk5QnlIOUs0?=
 =?utf-8?B?MXJxVkdrMmpCV3pRZEdWVXByajQwMVFObTgwMDlXOVJITlBqYzVNVXgvZDVt?=
 =?utf-8?B?SmNKdFl5UXRhaCtDSzRnOEZqUlpvVXIzVDdRZ0lkV1JVcjJ4Zk5nZzAzdmZJ?=
 =?utf-8?B?ODdmY1RKYW9YUExxVVFxb0x3c0JrdTNWWHR2SjB1bUNxUzBBVnFDbWdaK1JF?=
 =?utf-8?B?UUwrRnVsR2p2VHNVc2V6Vkg3d2gxQUNIN3dqdUZIQnVzZEFFdzFtS0VSb2tU?=
 =?utf-8?B?SEpWY29pc29jbTN0OHZpcWtsb0ZwSGRIdXFSZUFNQmE4RkRPaFZRUG5XMUhS?=
 =?utf-8?B?OUl3L290V1A5UnNQZWdKcmZxclBhVUl0YWxqaTMyN2liY2ZEVHdEUDFKdjV3?=
 =?utf-8?B?N3kxcGRkd29FY2FuaUJieG1uOUp2QUFxZ0lzdXdXQ2pyTDFnWk1RNnJpMGZC?=
 =?utf-8?B?MVM1VFI4STVwYWtpek1oSmZUN3JqdThMUlozQjNncmNNVDRpN0dMNndaSEtq?=
 =?utf-8?B?THE0bGI0UmdTZ2MySERTdGkxYlJJUGxsYTZHNzZkUWExS2JkaTg2SU91THBn?=
 =?utf-8?B?akNEa3FFS0w1QWZYTFArOS8rZUVYVUJiTStTSnp0ZlJiNVpLTWZzZFdobEt2?=
 =?utf-8?B?dTZkVHBxdDAzdGUzMldxNzQ1M2VVUjJIYjg0VHVNb2Zod2trRmZZT0Q3NXA2?=
 =?utf-8?B?S2c4cjF3VHRFdGJBQnVyY3RNanc2RHV2WDBRMVpLN1o1NG9IdHVsK0cxYXBG?=
 =?utf-8?B?cVh5aU95d0hxQkZONnBkQ3lLVUFiNDVmM1JNZXN3cHp5S01kUkt2NDN5VHQ2?=
 =?utf-8?B?LzRKMWRQUUlDb241RUZuU3kwNmFRSXp3TVhtZndVc0RiTmVOK1N1Q29QNGN1?=
 =?utf-8?B?b3k5QnFMSXlFZm41aTNKSE5mRTN6ZHJKd2RwbXkydzEzMWkzSEVzYzExK3hY?=
 =?utf-8?B?S0paTldVNlVGTlA2Rk5lMFIxNmREVWlxMTUzNFhLeWhqV3BtZkxpdk1zWHYr?=
 =?utf-8?B?YTNYdXdNYmdIT0VFMUJDRjNTYmRxTDNiQUFSR1JVMDRDWGI3OXVJaGZtMWJr?=
 =?utf-8?B?MUV3WWpGVFpXbCtMMkM1VUsrd09HZWpiNWVjTXkvTlNjMHF0UlFYVlRBVDhr?=
 =?utf-8?B?RUJFc1dJT2Vva1dxVE9VVTRoQUR1REZycVJTMzZtZW1qSENac3NWMzhJS1Ru?=
 =?utf-8?Q?KIrGCba4Gfr7Y39+M5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M8UQk/A0guLKc+VRoeYtXO8RLjaB9ZYEDrd4GZh/QIGMypQASCfBp3Zw5/dP/Vx6AQXYB7Msd0eAwYZSCuo3O6FRmqHSrNXzxTQu1uVBiXLu0yfANgKyVEeChpqxVCYCA758Ehl9IlqtSlvGGnE25zBaOl5Bwu80YYsKGJxL9mOcfi4JsjYRdqkY4bqq1FxNqURAcTMLmoHjFliG1y46hIWZ991O65YQIuRfzpY/g5Cr9W12MC1xL3XSlH5Qu3icFVAmz7aqWK7zkvYufcdnBUFeK1RvdhqnOJGzKYWUlRlGYGqbThyryZQ75fXiu05jqQhXkmN7MX8kyV0bYXtMQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c4ced7-267e-49d6-7ceb-08de8a55b846
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 10:03:10.0594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8LpfPTD7JTsggKXhL1flVPZpF+fwZ4HLWXk8s2vkIc21jt9oAuvDDiA3IFaPrL85xITOSoMi4wFWcKh9oSI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8311
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IDIwMjblubQz5pyIMTjml6UgMToxNg0KPiBUbzog
YW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNlIGNhbmRpZGF0ZSAyNi4w
My1yYzINCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMgcmVhZHkgZm9yIHRl
c3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/aWQ9djI2LjAzLXJjMg0K
PiANCj4gVGhlcmUgYXJlIDIzMCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBzaG90Lg0KPiANCj4g
UmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRlcy9yZWxfbm90ZXMv
cmVsZWFzZV8yNl8wMy5odG1sDQo+IA0KPiBUaGVyZSBhcmUgbWFueSBmaXhlcyBhbmQgbmV3IGRy
aXZlcnMgZmVhdHVyZXMuDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBi
dWdzLmRwZGsub3JnLg0KPiANCj4gUGF0Y2hlcyB0byBpbXByb3ZlIHRvb2xpbmcsIGV4YW1wbGVz
IGFuZCBkb2N1bWVudGF0aW9uIGFyZSB3ZWxjb21lLg0KPiANCj4gV2UgYXJlIHZlcnkgc2hvcnQg
aW4gdGltZSwgc28gLXJjMyBtdXN0IGJlIHJlbGVhc2VkIG9uIG5leHQgVHVlc2RheSwgTWFyY2gN
Cj4gMjR0aC4gVGhlbiB0aGUgcmVsZWFzZSBzaG91bGQgYmUgY2xvc2VkIGEgd2VlayBsYXRlci4N
Cj4gDQo+IFRoYW5rIHlvdSBldmVyeW9uZQ0KPiANClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9y
IEludGVsIHBhcnQuIGRwZGsyNi4wMy1yYzIgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBmb3Vu
ZCA4IG5ldyBpc3N1ZXMuDQoNCk5ldyBpc3N1ZXM6DQogIDEuIFsyNi4wMy1yYzJdW0U4MjVdW2du
cmRdIGllZWUxNTg4L2llZWUxNTg4X2VuYWJsZTogdGltZXN0YW1wIGVycm9yICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAkJLT4gSW50ZWwgZGV2ZWxvcG1lbnQgaXMg
aW52ZXN0aWdhdGluZw0KICAyLiBbMjYuMDMtcmMyXSBpY2VfbG9hZF9kZHBfc2NoZWR1bGVyX3Rv
cG9sb2d5L3BlcmZfcXVldWVncm91cF9TUF9xdWV1ZV9SUl9TUF9XRlFfbG9hZGluZ19kZHBfc2No
ZWR1bGVyX3RvcG9sb2d5OiBzdGFydCB0ZXN0cG1kIGZhaWxlZCAgICAgIC0+IEludGVsIGRldmVs
b3BtZW50IGlzIGludmVzdGlnYXRpbmcNCiAgMy4gWzI2LjAzLXJjMl0gbWVzb25fdGVzdHMvZHJp
dmVyOiBldmVudF9ldGhfcnhfaW50cl9hZGFwdGVyX2F1dG90ZXN0Y2FzZSB0ZXN0IGZhaWxlZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgCQktPiBJbnRlbCBkZXZlbG9wbWVudCBpcyBpbnZlc3Rp
Z2F0aW5nDQogIDQuIFsyNi4wMy1yYzJdbGFyZ2VfdmY6bXVsdGlfdmZzXzI1Nl9xdWV1ZXM6IEZh
aWwgdG8gc3RhcnQgcG9ydCAgICAgICAgCQkJCQkJLT4gSW50ZWwgZGV2ZWxvcG1lbnQgaXMgaW52
ZXN0aWdhdGluZw0KICA1LiBbMjYuMDMtcmMyXSBpY2VfZmRpcl9wcHBvbDJ0cG91ZHAgbmV3IGZl
YXR1cmUgYWxsIGlzc3VlcyAgICAgICAgICAgIAkJCQkJCS0+IEludGVsIGRldmVsb3BtZW50IGlz
IGludmVzdGlnYXRpbmcNCiAgNi4gWzI2LjAzLXJjMl0gZW5hYmxlX2RjYl9wZmM6IFBhdXNpbmcg
ZnJhbWUgY2Fubm90IGJlIHNlbnQgd2hlbiAic2V0IHBmY19jdHJsIHJ4IG9mZiB0eCBvbiAwIDAg
NjU1MzUgMCAwICIgICAgCS0+IEludGVsIGRldmVsb3BtZW50IGlzIGludmVzdGlnYXRpbmcNCiAg
Ny4gWzI2LjAzLXJjMl0gZ2VuZXJpY19mbG93X2FwaS9mZGlyX2Zvcl9mbGV4Ynl0ZXM6IHZhbGlk
YXRlcnVsZSBmYWlsZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCQkgICAg
IAktPiBJbnRlbCBkZXZlbG9wbWVudCBpcyBpbnZlc3RpZ2F0aW5nDQogIDguIFsyNi4wMy1yYzJd
IGljZV9mZGlyL21hY19pcHY0X3R1bl9tYWNfaXB2NF9zY3RwOiBjcmVhdGUgcnVsZSBmYWlsZWQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAkJCS0+IEludGVsIGRldmVs
b3BtZW50IGlzIGludmVzdGlnYXRpbmcNCg0KKiBCdWlsZCAmIENGTEFHIGNvbXBpbGU6IGNvdmVy
IHRoZSBidWlsZCB0ZXN0IHdpdGggbGF0ZXN0IEdDQy9DbGFuZyB2ZXJzaW9uIG9uIHRoZSBmb2xs
b3dpbmcgT1MoYWxsIHBhc3NlZCkNCiAgLSBVYnVudHUyNS4xMC9VYnVudHUyNC4wNC4zDQogIC0g
UkhFTDkuNi9SSEVMMTANCiAgLSBGZWRvcmE0Mw0KICAtIEZyZWVCU0QxNS4wDQogIC0gU1VTRTE2
DQogIC0gT3BlbkFub2xpczguMTANCiAgLSBPcGVuRXVsZXIyNC4wNC1TUDINCiAgLSBBenVyZUxp
bnV4My4wDQoNCiogRnVuY3Rpb24gdGVzdHM6IEFsbCB0ZXN0IGRvbmUgYW5kIGZvdW5kIDMgaXNz
dWVzLg0KICAtIElDRS0oRTgxMCwgRTgyNSwgRTgzMCwgRTIxMDApIFBGL1ZGOiB0ZXN0IHNjZW5h
cmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2Zm
bG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTL1N3aXRjaC9QYWNrYWdlIE1hbmFnZW1lbnQv
RmxvdyBEaXJlY3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNlZCBSU1MvQUNML0RDRi9GbGV4aWJsZSBE
ZXNjcmlwdG9yLCBldGMuDQogIC0gaTQwRS0oWFhWNzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9m
ZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLiANCiAgLSBJWEdCRS0oRTYxMCkg
UEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9UU08vSnVtYm9mcmFtZS9jaGVj
a3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSUdDLShp
MjI2KSBQRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1i
b2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0K
ICAtIElHQi0oaTM1MCkgUEY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxP
Vy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9S
U1MsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2Vj
LWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0K
ICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJl
ZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRp
by1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA5LjAsIGV0Yy4NCiAgLSBDcnlw
dG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29t
cHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KICAtIERMQjog
dGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIERMQjIuMCBhbmQgRExCMi41DQogIC0gT3RoZXI6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBBRl9YRFAsIFBvd2VyLCBDQkRNQSwgRFNBDQoNCiogUGVy
Zm9ybWFuY2UgdGVzdDogQWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogIC0gVGhvdWdocHV0IFBl
cmZvcm1hbmNlDQogIC0gQ3J5cHRvZGV2IExhdGVuY3kNCg0KDQpSZWdhcmRzLA0KWHUsIEhhaWxp
bg0K
