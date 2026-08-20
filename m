Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D46C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46079402D1;
	Thu, 20 Aug 2026 07:47:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE9F4026A;
 Thu, 20 Aug 2026 07:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787204845; x=1818740845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x4YwOUSbD6jvnYX4Q/XCszIeEqJvtEGTs+s1DUsSfNk=;
 b=C3BJFYvyZvmObFPkN2F37x+NafoBAW5MMD6TZ13HA/VetmZTtMgBhJxs
 nwHu7/mZAwwI4Oi8Jr04wuunl+M1IdK7hGB7ygXlpqysFtbd8VOR4nYLs
 eptvsgPMyZeUCgdfXzXtkPIRw15hxRYYNTRaOHXJIpKFRdpC3l9gzQ11G
 9lxHJlgX7TfpOqYhpotIhGYC2rVo0wpHQ1WX5Y00kWgdwN49NwXd18xfo
 ghdAiYlAdO7ZYOpbpxbieCxFAWwaz3ooJETXnO/TdVLHng6wOxyDHT2KG
 jgPWyDZZEdQn9AZPnM5p/St2o1zdsqLh94e6qQqIyAYBFPeNHX9mtIWC/ A==;
X-CSE-ConnectionGUID: jpwkMIvtSamOrCzVMeSFuQ==
X-CSE-MsgGUID: JDuowsR9TUOchyoQDNFkMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98323910"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="98323910"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 22:47:23 -0700
X-CSE-ConnectionGUID: hrUcoOG6RNCVVMSeGv8gtg==
X-CSE-MsgGUID: rVd6mN9vQ/6j7nxSXdeQ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="264537700"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 22:47:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:47:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 22:47:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxlUMExw0p2XC9WU8En43KZlucP0l880hdzhW44RTIWF2BPaPMuQuj0IwAoBKtz+DQUMpAJWlfoRTRsfAoS81219gUiabYHemCxQsRj1gYnXxvR7ozR3ZbfGIcYfC7R6jG0woDwvf1WfDIdru3H4/spRKlLQFF7mF+bLqQ3BVxoJriuz6dBeOOcXbNAoSx2u3KBDUNfjwrYKjg1QqWn3NmrCf+10UIizGg536rWO2CB6zSEfY+j9zQMjbtx9Jt3zF6oMmisf2SZrbQPGAuVZ0uxAkMix1vMSr3jYjyhkDtvlYOIGI1ymiyirFvbKz4OHYtvhL7WtfoWO4WIW+F78yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4YwOUSbD6jvnYX4Q/XCszIeEqJvtEGTs+s1DUsSfNk=;
 b=bB/w0Cc1M9jUtkG+kyzEKeQ2ir4IwFlSZQ2Sixliy6aKKtaRwcbt7r81NUB5ibBRtsgxzISmiNc8SndUDH2fQaZWFC5ae82FVBcAjkr34N6WueIjnHKHl0QJVcmN1uVZcRK/jv1UeCTsmk4O4Ui9jRRM6tfL0znCHgj6YxmIoy90yk5nKpmb0sC6mPz4j81EYYKuloaCTLBtIYgBzC5Mcrmzv3yAkBOfarqdxK85JXLaPp9cm9wo2jQxzZts+KGACXjM7YhN3hg4L5/GKSesdUl2kypYTnuFl+QYoIZeLvMItB6VIj/cqs/uH4hhddPdn7lKgYSWNxbAj23Y2De9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:47:13 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::b484:377a:1202:d5b6]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::b484:377a:1202:d5b6%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:47:13 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, "Agrawal, Hemant"
 <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Luca
 Boccassi" <bluca@debian.org>, Raslan Darawsheh <rasland@nvidia.com>, "Shani
 Peretz" <shperetz@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>, "Puttaswamy,
 Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: RE: 25.11.3 patches review and test
Thread-Topic: 25.11.3 patches review and test
Thread-Index: AQHdI/7eqvhc56ebAE2NAsnnZUa5EramQgug
Date: Thu, 20 Aug 2026 05:47:13 +0000
Message-ID: <DS4PPF00BBED10C93748DCE189FFFB33BFD9FA42@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <20260804104755.135019-1-ktraynor@redhat.com>
In-Reply-To: <20260804104755.135019-1-ktraynor@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|SA2PR11MB4921:EE_
x-ms-office365-filtering-correlation-id: f9b78992-209f-4cff-8c6d-08defe7e7c15
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|38070700021|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: vRv+Rag/ykEDKHrJtqYxlo6seyqDOjdQ97EjfZEG7s6FdtQotQZLxzdvoQMj9Ort64/vokaupfgbj2YGMbIO2XhLtMKRUd9yryHUUW/ufN7PpHc6VdiOoW5wJ0Td75ABTMMiBoq4zd/aXrWg0F0R1uidAgLXpNO9LnExafDQgofCYTK7Z+shzwr+P7Y/hb1LqKnvCeSS/c/GTeiwYRHUShiy2LRtiyqwhBs2+DmhvOWZhc8/SYPZIIg3Zz2BbvEV768DBsNymM+FGz2oUZ4cMsrKdNCQwIXWESk7Ht07Qoyk/fUcAIJc8QPUWukPqN+r3PlnbouKVE0a5fZgAjNw81TuQaHcwrFOdtaEvc2mpm3sSehjTEdiFbeFqGKuIfU0T3AJV/01f2rUyayVekD/qMlawi4qQbvmX+PWFeczLUsj4lmm3kowcrQP/SzbL5Gfb7x/uAALUvZxeb3Q/A/F/aizRg+5FQUFfMsBAHCJ9X+WmF26JdV+opmCcRTZHpRfuyHRY9JZm2MqbQgebPnmttQamyxG/UyiBZwC8RXC+miIot8DOU9dFA4Q4HrZV4zxZej1c66hTOcHLB2oGkQIu0F5q70+ToT7XzIwx0dyia+nZT6zw0UOYfs3eSZBKwC0FbZUTR1lTOW2YVeJvtxhzQneH3plTX3DMsDhS5MIgNuCAJYTbCcgBhg88zKTrWFypYrifeOvDFu/fqOL4pHiWYhOvL4hhSRgClwFLLkjsRQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(38070700021)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hSek83S1ZCQ0lzcGczR0pQbDg4a25WVGREcEEwSDYyc0RVUFRPNnZMU1Vs?=
 =?utf-8?B?MXBLWnJPMytXaTF6UFA2Z2xIVXcvR2wwcUFWbWtNc3NQeXBkN284UnIycEFL?=
 =?utf-8?B?VGlBMnN4eU5IQ2p5QXphNG1CcGI4NjFOWWxBZzErdUk3L1JDZkJUVUZnaUQ0?=
 =?utf-8?B?WHF2QTdCRGFZUUxkRWxwTFUvVWN4WEgrSjZscjBPRnZ0RC9GN3phc2NrRFZD?=
 =?utf-8?B?TXdYWjFLMmpzNHQ0WXVJRlRmRC9MeDFJU0JGYnB3d1hVbjBpeGZzWlpPYWpa?=
 =?utf-8?B?Q0Q2ZGFoMWpYVWVOZEZVZGEwdjJ5b0s2TUlhM1lRWko1NHJXRFRQWHlra29o?=
 =?utf-8?B?bUFUVWM3bDhUZWFqODZDQzZNR2RHR3FlOHVPLzlSU2hlbUMyRXpEMDM5N3hu?=
 =?utf-8?B?TzJ0K0k2OEVJTXNJL0psNDJ0WG9ZRkNYemJ6Nm5RTkJ6dGhVTGJnZHFWMEtx?=
 =?utf-8?B?Y2xRa0FabU42Q0paS1pESUk3SUJXemJyUVZsQkVBL29ISXZ2ZUxsTWd6enBr?=
 =?utf-8?B?NW82NGIyUFh4bm9FWHc3eGxGT3luZG9TYi9UMkwwOUpBdjQ0djNtMHg2c3NL?=
 =?utf-8?B?QU9jckY0b0VDaVNTSjFsbWgvZFpyY0trVmRDa0Vsa2dCcDhtVFBKS2d5WE9j?=
 =?utf-8?B?NmlHQVNWVVBBVGpHSXlpVy9URWRhdlVaS1hyanhaZ2sxYkk1eVd5aXhHVlRy?=
 =?utf-8?B?N3pEYU8xUUVSandkYlBhUWp2S004Yk9UUGhMR3hTNFZWTU1YWkJmejB6MDVB?=
 =?utf-8?B?d0ZtL0RtRm9GS1RVZ0h2MUorVWZ4UUVRSXA0WHduUHZPL3hrWlh0NTdNSTMy?=
 =?utf-8?B?R3p0emlmdHJQVGRtcmhYL2pGVGc0ZHZtTEoyMk5UVG5YdzZsWTNOSi9vclVs?=
 =?utf-8?B?ZHhESkZvdnpoa3F5Z0F2M25YTGdobkg2b2pwaU9wNU5UZ0pwWEhKNnRtTnpH?=
 =?utf-8?B?cVZETmdJZ1FoM1FTZ2dHOHNwS05uVUtWa2gvanBqT1RWNTliVkNCUkRtNTN1?=
 =?utf-8?B?dDVpZzlxalJUMGpiRGtKclJRVGE0STNDVGdVOExXTSs4NzlPWHNuNThUcHZu?=
 =?utf-8?B?bEdoQVZRaGVQd05tSnRVOXhTbWIrVXNGVlR2eXlhTWVQa056cmhVY1dZKzgz?=
 =?utf-8?B?b0U1UjNqZEF0V2o5RVNwanhkQ2hwVk1ocWliMHQyQ2c5VmxHWFpOcmxzNHJI?=
 =?utf-8?B?V0puRURxZHg1NURLa2U4c0RReXIwcWFWVXBaNmZUZ1IrRXprNEl6ckFCTTNN?=
 =?utf-8?B?dmloVm0zTHBBWDM2S01uZWIzVzZpOTFNcS9wNDhlVDVmS3VOWjl5WHVnb1Qw?=
 =?utf-8?B?bDNKRUdrbDU2R3BUenNLNjV6OW5FUC9FN05uT3QrZlYyaDFjeXd6bEFLQ0RM?=
 =?utf-8?B?RGNSazY2bTlXWVBKYUF4TkQvTUpWdkVOZWRIUGZPdnE1NDNkUmgzRVQwWjcw?=
 =?utf-8?B?Y1ZZQWczWGFEV0wwdmQ3dyt5K1MyVS83bUNUemN2M3VwZHlzMVFYVGFzMEpo?=
 =?utf-8?B?RVF2WHF2TWtpdXRNaUs0dkk0M2lTR1lqNDdtOXRUVlBOSEEwUmlZeUE0WVZI?=
 =?utf-8?B?YWxBUWdjYkxYVXUzL1A2a1l2eG1pZGkxMXJxUWt0NU0zZnl0Vk9aWjlWVmVB?=
 =?utf-8?B?SHFQczZNRC9RcFJQNXVlanZKR05jcE5LL0xmdVlsK0o0Q0NlMG9GR3ptdFhZ?=
 =?utf-8?B?dUM4TjBCcVpXWmlGdkNKSkVkMlFBbFVoSWFIbEYyYzFlS1NDcmhORUJCa3dj?=
 =?utf-8?B?djhzZ3hiL2MrSXMzZ3Z5Z0dkY1VNR3NLYXUrdG9EODRDNkFBU1U2THhwY3VH?=
 =?utf-8?B?dUZnamg4TXVHSlgxTzF5dm9yK2cwS2w0a25ucHdCQ211M09mOUNpakduZ2c4?=
 =?utf-8?B?UDhoQW9ySDFPTzN4bFdjUEdQQjNLYXJ6RUVGWm02YXhycTJrNFhoS1hzWkp3?=
 =?utf-8?B?b2VwK3cvSVRmS2pFeFVLdDRNZFg3WXU0TVZDeHJ1TTdMUWdCRCsvb3BlRkFl?=
 =?utf-8?B?MUpBWittdVpwb1ZwanZwTExkRlpCdyt1K0JyUi9qS3JBMGxBRDdzWTc2dUFS?=
 =?utf-8?B?cy9ZR0RPTS9LSHlwRjNreG9Sd0FNQjJBc3VJNld0bVQvRzlRMVJHMkFNYkNR?=
 =?utf-8?B?N0Z3YXcvT0tONStrcUFkY1RXb0lkQy9RTEZBcTk1alNZWVg1NXdPSi9oOXFr?=
 =?utf-8?B?OXorWUhFaUNwMHRWY2IwV1RiWnZFZUNkb3o3TnhiUUhrVkxPMGxmNDN5cFJ3?=
 =?utf-8?B?eHVwaXB6THNUSVZsNmhGTis5NU9rc0c3Rkp3b2M2VUExSmk1RzJvMlpVY0ph?=
 =?utf-8?Q?9bLGQyBlmEXrqnXTIU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TtSOPvGMPMQP4puvHtKRkAA1+YJupHDMwyGWpIc6twQjRvTUdDrez7Pc0XNpeIGUuNdz4VtG/BDW3CgAPI/0cGXT9u4JqjjD41hyGLWhQFkXVKB5bomRVFPP5UV0TtuI9kaEx2dG0cvxlJmsa51hT6+ZjUgi5xf1Jd9DZNhUXY76vXZ1NF4Yv3AwILSXBa8gze1d9gbTqHs96LiMRq1ux+Z+HOSjGoP2nijlCdXYXl5lcGDrHcA4kM4ojudh31W2lZGeYzy+KjOsjVJbkr0u6S9/azt6Y/fSikf5BCnImDRHrJr9zeI5SeEtSfVka81P98xX3VF1ZBsr5HdfQtw6+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b78992-209f-4cff-8c6d-08defe7e7c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:47:13.4212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lzxOZE+cQhrSz5ysVE9uQOBdbPmFgwX8GobmJu+d3dGOXwnmyJByjY3nrbel+egoXT1oTwZzpjsBC++pzoCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtldmluIFRyYXlub3IgPGt0
cmF5bm9yQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA0LCAyMDI2IDY6NDgg
UE0NCj4gVG86IHN0YWJsZUBkcGRrLm9yZw0KPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hlayBN
YXJhdGhlIDxBYmhpc2hlay5NYXJhdGhlQG1pY3Jvc29mdC5jb20+Ow0KPiBBbGkgQWxudWJhbmkg
PGFsaWFsbnVAbnZpZGlhLmNvbT47IERhdmlkIENocmlzdGVuc2VuDQo+IDxkcmNAbGludXgudm5l
dC5pYm0uY29tPjsgQWdyYXdhbCwgSGVtYW50IDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsNCj4g
SmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huDQo+IDxqb2hu
Lm1jbmFtYXJhQGludGVsLmNvbT47IEp1LUh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQuY29t
PjsgS2V2aW4NCj4gVHJheW5vciA8a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1Y2EgQm9jY2Fzc2kg
PGJsdWNhQGRlYmlhbi5vcmc+OyBSYXNsYW4NCj4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5j
b20+OyBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+Ow0KPiBUaG9tYXMgTW9uamFs
b24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+IFN1YmplY3Q6IDI1LjExLjMgcGF0Y2hlcyByZXZp
ZXcgYW5kIHRlc3QNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEhlcmUgaXMgYSBsaXN0IG9mIHBhdGNo
ZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDI1LjExLjMuDQo+IA0KPiBUaGUgcGxhbm5l
ZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyAyMHRoIEF1Z3VzdC4NCj4gDQo+IFBsZWFz
ZSBoZWxwIHdpdGggdGVzdGluZyBhbmQgdmFsaWRhdGlvbiBvZiB5b3VyIHVzZSBjYXNlcyBhbmQg
cmVwb3J0IGFueQ0KPiBpc3N1ZXMvcmVzdWx0cyB3aXRoIHJlcGx5LWFsbCB0byB0aGlzIG1haWwu
IEZvciB0aGUgZmluYWwgcmVsZWFzZSB0aGUgZml4ZXMgYW5kDQo+IHJlcG9ydGVkIHZhbGlkYXRp
b25zIHdpbGwgYmUgYWRkZWQgdG8gdGhlIHJlbGVhc2Ugbm90ZXMuDQo+IA0KPiBBIHJlbGVhc2Ug
Y2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZvdW5kIGF0Og0KPiANCj4gICAgIGh0dHBzOi8vZHBk
ay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlL3RhZy8/aWQ9djI1LjExLjMtcmMxDQo+IA0KPiBUaGVz
ZSBwYXRjaGVzIGFyZSBsb2NhdGVkIGF0IGJyYW5jaCAyNS4xMSBvZiBkcGRrLXN0YWJsZSByZXBv
Og0KPiAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+IA0KPiBUaGFu
a3MuDQo+IA0KPiBLZXZpbg0KPiANCj4gLS0tDQpVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJ
bnRlbCBwYXJ0LiBkcGRrMjUuMTEuMy1yYzIgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBub3Qg
Zm91bmQgbmV3IGlzc3Vlcy4NCg0KKiBCdWlsZCAmIENGTEFHIGNvbXBpbGU6IGNvdmVyIHRoZSBi
dWlsZCB0ZXN0IHdpdGggbGF0ZXN0IEdDQy9DbGFuZyB2ZXJzaW9uIG9uIHRoZSBmb2xsb3dpbmcg
T1MoYWxsIHBhc3NlZCkNCiAgLSBVYnVudHUyNS4xMC9VYnVudHUyNi4wNA0KICAtIFJIRUwxMC9S
SEVMOS42DQogIC0gRmVkb3JhNDMNCiAgLSBGcmVlQlNEMTUNCiAgLSBTVVNFMTYNCiAgLSBPcGVu
QW5vbGlzOC4xMA0KICAtIE9wZW5FdWxlcjI0LjA0LVNQMg0KICAtIEF6dXJlTGludXgzLjANCg0K
KiBGdW5jdGlvbiB0ZXN0czogQWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogIC0gaTQwRS0oWFhW
NzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9X
L1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JT
UywgZXRjLiANCiAgLSBJWEdCRS0oRTYxMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGlu
ZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0
ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSUNFLShFODEwLCBFODMwLCBFMjEwMCkgUEYv
VkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2Vt
ZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGli
bGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcg
aXBzZWMvaXBzZWMtZ3cvaXBzZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJQiBsaWJy
YXJ5LCBldGMuDQogIC0gVmlydGlvOiBib3RoIGZ1bmN0aW9uIGFuZCBwZXJmb3JtYW5jZSB0ZXN0
IGFyZSBjb3ZlcmVkLiBTdWNoIGFzIFBWUC9WaXJ0aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9v
cGJhY2svdmlydGlvLW5ldCBWTTJWTSBwZXJmIHRlc3RpbmcvVk1BV0FSRSBFU1hJIDguMCwgZXRj
Lg0KICAtIENyeXB0b2RldjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkg
dGVzdGluZy9Db21wcmVzc0RldiBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMu
DQogIC0gRExCOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgRExCMi4wIGFuZCBETEIyLjUNCiAg
LSBPdGhlcjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIEFGX1hEUCwgUG93ZXIsIENCRE1BLCBE
U0ENCg0KKiBQZXJmb3JtYW5jZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCiAgLSBU
aG91Z2hwdXQgUGVyZm9ybWFuY2UNCiAgLSBDcnlwdG9kZXYgTGF0ZW5jeQ0KICAtIFBGL1ZGIE5J
QyBzaW5nbGUgY29yZQ0KICAtIFhYVjcxMC9FODEwIE5JQyBQZXJmb3JtYW5jZQ0KDQoNClJlZ2Fy
ZHMsDQpYdSwgSGFpbGluDQo=
