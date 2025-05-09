Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC803C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 13:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B79C4025D;
	Fri,  9 May 2025 15:57:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8E95A4025A
 for <dev@dpdk.org>; Fri,  9 May 2025 15:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746799046; x=1778335046;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=ywK5W2v6MBJX6fF0/8IXLFdbJjLAhFyaqN0h4eBxCFs=;
 b=KySk7lhpnrJ75b6UDs+nCNY4GSEOvMvTDRRD0IIXAtEybasMNDOaOG3e
 I/O5R3e+jG8YoPU5TfbTFMA+yJXJm/DfPdF2tNiM3a0S6njRpTwZ1i+rK
 22TTxEl67ztWuBEKGwH8na3GFnwQDvIuNR5XnvB5qLzWCCtPRNZBVv3Bk
 rsXzoDiNlB4LGZFJGGBx7NFidGA33/4lzPLSq+9AlThTvwHrI9Yjxkfno
 bNJ4lK4IPe9m1N2VZwp7ZY2vd3dxT3HBm8w4WJhmzqSowVm+JQtYC4liI
 Hu/peZJs065dLentZO1Yu6/7/dNgunNVylnqTJlG8+UwuphpXT8iuOHrl g==;
X-CSE-ConnectionGUID: EMT0z7TdS7Wvf0mvbJQP8A==
X-CSE-MsgGUID: NsY3PqozQo6y7MkAp7I1gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36254043"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208,217";a="36254043"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:57:24 -0700
X-CSE-ConnectionGUID: 2Sk2/B18Q0S4ISJkyaUDBA==
X-CSE-MsgGUID: eylbopcERTS28k0OGcB+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
 d="scan'208,217";a="141739034"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:57:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 06:57:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 06:57:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 06:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cILflCkBUK2md2NnlB25wQMc/wMTU6hC4zlMk93lK1nyeZyvTHHUv4G+PxFRRRmvatJJihBHbIoYFYC6ORcAhgiYxLkFGnOQbdENaqRcOrB4ef3fHWEXxrWbeius/9Xpf1DLs5BY1gyaqvDTVtEkcN+tt+sJpp4oRKVxhh17AxJm7Im8LtV00rLALB+pK5ZT5TRbeKUu6qCLYBpgP1sYEj2Aq+UN9sD9inUkJ0ICyAJyEqYOzgOi9k8r2oqVcps+wHRrCaH0uusnhD9eYcIrQxuCBRL9GkDynLt/wYM1QEOBGQ8FCsPzR9q/AYWHTEYpocnFS/DPWMultaGtmsUuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywK5W2v6MBJX6fF0/8IXLFdbJjLAhFyaqN0h4eBxCFs=;
 b=wLsGs8cdjJjvZ6B1Pk/wrpUwd64wiTfDge0mi9uxllfSeTvuBtD0FCKSgdNf/3iAJiE7c0jFwf89szll+tD6HWyrMCgkpEqRBWojMI5G7DNi/9g+6STixeZVX32o+2HtotdHGp2ENhjEPCgy+sIUK0NIDCaiJRifww6uAGky08RYlz9RCCWYvDnWsdy0h9Ur7Gt9sECcYakSF28nBzu+4UP7cTJzqyAxMkxMO22fKLhRqrF7LI1VvMpyi1Lod9h2c3+qCdpR+PJSSYLQFcpV3Qu5DPIqt2o2eFVtR3jvUWYD49EFPrpDWol2YOea7XTJfAZhg4+jwFPthun0Xt605w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 13:56:53 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%5]) with mapi id 15.20.8678.033; Fri, 9 May 2025
 13:56:53 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: vivekanandi <v.o.s.openbook@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: Addressing ninja build error message
Thread-Topic: Addressing ninja build error message
Thread-Index: AQHbvbz/dAaqDvIgd0W8ai1kDxGBsrPKWIxQ
Date: Fri, 9 May 2025 13:56:53 +0000
Message-ID: <MW4PR11MB58725A73F8347E4C9B0C7C138E8AA@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <CAEmGFk9v4-QWRy1-N+jMkdM=iVv69xPRaKUzuxkTuD9OYJa5cQ@mail.gmail.com>
In-Reply-To: <CAEmGFk9v4-QWRy1-N+jMkdM=iVv69xPRaKUzuxkTuD9OYJa5cQ@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5872:EE_|DM4PR11MB6095:EE_
x-ms-office365-filtering-correlation-id: e8f90480-ca43-4099-98e0-08dd8f015ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?V2RMUERKdWNJYkhuQkErUUZuTE50Q2FNTEVoVEw0NTFwZXpaK2pkVlNIWlho?=
 =?utf-8?B?TGxDTHVjRTZQVjlqb3J2MEpVTUNtNnViSjRGY0d6Q3Y1dFZSV0hnTWsxaERM?=
 =?utf-8?B?eTVCblFQVXJHbUhLNUhuVmNybmJZbUNLWlpwL3VNS3VFSGNiZ2QwRXd0Rk0z?=
 =?utf-8?B?eTV6WVkzM2RTTkdVd0xQbHM5cloxd09WMW4zNEpZNEo4clFaUUlYdUpjNUx5?=
 =?utf-8?B?c0lPT3pMSGtsc3FBeFJoOFRQMGd5Y3dzcVNxVktjS0tLQ09zdGJNayt3VEUr?=
 =?utf-8?B?cmJ5U0xtYnVFSmNhLy9GV1RWeEdCQ2xsUEd6OFRrZXFTdlljSFBSSGozckl6?=
 =?utf-8?B?SGgvWHVpUWF1dlI3blhDUHZhekJIYStENWJWUFBOVjZyNVNwVkxXd1diRTVM?=
 =?utf-8?B?VkF0MVl4ZjBGTTZtZE5pWDNNai9LUFBrVjdFbFpBVkozYkZ6ZkE2L0Mzb25I?=
 =?utf-8?B?WHQ1dTkwMi92bVVUMUdrK2FyQmNVMHBBZ3hVd3N0RmtTSzJ0MU9ObmUyUDZG?=
 =?utf-8?B?T1RFY21iTnZLR21ZUVVVZG5kcEN6R0dOdEFWQU9QL1VYOTRpU01VbFlnSW9J?=
 =?utf-8?B?WCtlcER6YUpDcVJKVSttU0tuYk9neGhFSTBNeHBVMHFLQjZpWmFJeDRZeDB5?=
 =?utf-8?B?MStROVNSYVBQbGJMUHI0MWVVMFlXaHAzcHFUc2Z1SGp4REJWd29KNGVvVENn?=
 =?utf-8?B?bk52Uk4yUExPTlVDOTQ5YUV2Y3Jscy9TUTN6OGlEekxjb3FEUGNjdWExVXky?=
 =?utf-8?B?c2VzQ1BoT2FQQStjQ0dNRXVpcXlmQmIxN2Vqd01iamVrSTV5MG9BTERCWmZw?=
 =?utf-8?B?RHN2L291d3RGNFZDT0NvckFScUdMVXc0dy95TTV1MUFNYlpTb2d5QVhNL0VU?=
 =?utf-8?B?ZEV5UUpoS1M2OFN3RXoyWlZMTzZOR2g1bU5lK1dvalBlaVdPNlgxU3BscHMw?=
 =?utf-8?B?WE0vRzc3eUpNZiszWDJZSTV3dkJtbUpzNkRlMmNDMEhmSy9YTlZoSGErN0E1?=
 =?utf-8?B?TVNzM3pua1R6eVU0ZkdMVFc1QVlGazNtd3FZMXJNMGppUGFIYkZCZ28zWEtx?=
 =?utf-8?B?QTl3VEpZa1JEMUQzZ0JDQStsaXRyMHFleUNNaHdaWWIwQ2piQ3NnRU94UEdv?=
 =?utf-8?B?N3N0T1hhY1NQT0FaYkF4elJMc1BIQi9hemFZRDFCQkY1UUFCakdFdWpEQS9H?=
 =?utf-8?B?c1M0U2U5WUNRODhLQjQ5eVN0azk2eUl0Z0NpNS8xanNRWkFLZG5kQ0JhY09T?=
 =?utf-8?B?SDJRR0IxSjIxRXEvZ3I4QzBrcDNXR1Rkb1gvZ293OENPWDVlaS9UcTJ3VDdG?=
 =?utf-8?B?bGRIQkxtdkVIQkcyWjFTd053TUlDVmZmOG1aZGU2YUM4TGxVeUlQRVlDSlhT?=
 =?utf-8?B?eG9vZk1CWUxtbk80QmtqZjVYOFpGMDlXWTA2czBMdDVuOXhQaHdZNGd0K1U1?=
 =?utf-8?B?WHV3bUxJY0xZc1A4OHZvMlJHZUJuVFl5QmdnQ2VaNU9icUloeVlMSFlOVGRi?=
 =?utf-8?B?LzR3QkZaV3RpQ2pLWFlzdm4vYXR6Qk56NUo2SnhCMjdsUEV5MnpyUVl4T29G?=
 =?utf-8?B?YjlnU3B3ZzVEVUJRK2lSTFZUNFhkMVFVR1dOQmo0Ujg5OUxiUXVBQks5L1Iz?=
 =?utf-8?B?Nzkva3VIaWUwYXR0YlZrbUtldk1yZE9GWE0vVWs0Q2czNzVTR0E2R212Qmxl?=
 =?utf-8?B?TzdwM0VpZEkyQjJiSFl0V211OVhMTmxDTklMRzBwbVRqU2FpVnNmMnlrZ3U2?=
 =?utf-8?B?cE1ja0JydGdTb2xJNmphdXB1Z3B5T0w5YkpyRm9PMWtOdGJHSGVzT0xKbHdk?=
 =?utf-8?B?bzd6aVJ6UnJWN2U3K3pJWGM2cWdZcmEyM2ZrOVhzRFUzcmEyQWZmOEpONHdU?=
 =?utf-8?B?a0JuMW9NNCtlTG5RQ3JHSlh0Z2pvVzc1VVpiYVhGekEzS0NaWmRlc2RIK1JI?=
 =?utf-8?B?QWptQVJaWEpjV1RDajE2WWhHT09aYmF5cytqbE53OThrSkovbGpMelA1dFFX?=
 =?utf-8?B?Smdrem1YOVF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFA1UjQwNVZTRHB6enVLZDU3UVNNYms1VTdiSzdCaC9pNGlBZWxEbDZWK0FM?=
 =?utf-8?B?K3BackRScVZ2NEpLb0owUmtFZmV0Q015TFhLbUJGNk9EZDc3UmlPQVRyYjFQ?=
 =?utf-8?B?cWF6Q1FjU1dMai92RDdzZE52NmQzMXhqdDhONWVDNWg2QUZHRDZEVjJYNlhN?=
 =?utf-8?B?UGl2ZHJReG5wOHgwUVFhNmZYS2QybGtJMFFUTDBvR2Q1L2RxYXNoOTg4dmFi?=
 =?utf-8?B?MXdHUkU5MGU0UFRncHBOaG9KVkNRQnBoVTBhWGN5WkZkaytUc2NnRjdqQkxJ?=
 =?utf-8?B?dUhBc0RjdUNLeTdFaWNNc3hQYkZkQ2hsWGdQR2NDNjBUWXQ0UTNxRm1acU5n?=
 =?utf-8?B?WnR0NTNGczJhSGU4NVhxSlY5YnFkQVI1K0cxaWJTcnAzL0QzdXQ2Ri9zbnp5?=
 =?utf-8?B?WGlNSEVXVHJvTWZGVFdBWjNXeUphb0Z1WGZ4RkJ4c2o1cHdyb1BZb0hscWdy?=
 =?utf-8?B?bFR4cXdZOFVGTTZuWGFHQUFUbVRHZWZXL3BNblo0YWp1MGw1M1VOQ3BReW51?=
 =?utf-8?B?ZDFKNUlFZGRzcFpUUW1ocXFVTTJYYW5WK1VSYUdhS0tYNmlGa3J4NmpBWWsw?=
 =?utf-8?B?T2twTXJKN0tmUmNxUUNkRXhCNU9CSzZKRFZveUZOaytGL3FZRGd2YTk4cThw?=
 =?utf-8?B?cXU5eUNxSGNZNjg0dUs2dUtabThWOFhqY0l4b01WbFZyTGwwYUl6cENqbG5L?=
 =?utf-8?B?cG5ndEQwUVNKRFVpNzVnQzAySStFUXlQc1NId1Z0c0tjMDhkV1lPT2NJdU03?=
 =?utf-8?B?dzNoOXhIL3dQZERWQXRNdm9nbEx5Tkd3NFBaVmY1NDhjOEJzTW5TR2QvMWhR?=
 =?utf-8?B?c2RUdVdhWmNOa2UrQlkwNWJuSU4rOUlIWkN1KzFTOExFTWFKTGVPZFNHTVRD?=
 =?utf-8?B?c21sdWtuWEhaV0d3em5qTjhIS3krdElMclNUL0w3SUtNbkFyaUxNa0ppWnZ2?=
 =?utf-8?B?UGEvanc2elF4c0xTbmlha1VtTmpsVzdxRzlDY1U1Z0FsL2g1RzRiT0FsbE1L?=
 =?utf-8?B?R0Uvd204R05nSENPNGk1MkRVRXg1Sjd4cVpJNTJqZDJZb3N1d3MzWlNaQU1M?=
 =?utf-8?B?VjZNNU1EZEt5emtBMUdMK1BIK0NvazJ2YjFNZzFNOVJVWmlGditscGczRlpp?=
 =?utf-8?B?NzdsYmxLMVpNcGx0OWZxYlRpRXZsNGUrc08xWWNJdU9jRGdKU2FxRVkwdHcr?=
 =?utf-8?B?NnB0ZjNqVFcwTWVXVlpQVElWelRkamErakkxb1YrTjNJMkNzZ2VBd2dudU1K?=
 =?utf-8?B?MHdTandWZ1IvWk9yc2pkWVhheDc4MHBQODhiOVVvS1RXby9MTWJKM0hDZ0Q2?=
 =?utf-8?B?Tk85bnNnNkVDQnd2RXdwVWN6N2txYmNYWkdzMUJvcDVkTmQycERuSTFuYTUx?=
 =?utf-8?B?WUF0SUVUcVhxektwTTBuanNpR2VJdVVIYnB3dHFwRzB5UGFHUUU1YlAxay94?=
 =?utf-8?B?TURrYkhqY0NWWVduWDFqU1Y0a2N3VHI2djdrK3FTNWdMQnN0NWhvM0hvVHF2?=
 =?utf-8?B?bWRlRUtWeFkrcnJRSXRZSGJTNE1VMzZCSEhPc3VNOUxYdGdJVmdVd29wbnBr?=
 =?utf-8?B?TkMyUDhoYnRLaERKY2d1SUdBeDliM1Jyd0xvN2kySjJ6QjRHRDgwcTdwNFhH?=
 =?utf-8?B?K2FaOWhqcjVnUVdHWlhUL1FkRVlNNXNKSUVNcFNPOFFPVXIvMmduWm92VGRC?=
 =?utf-8?B?WVlodVBlT3VnbE9Ea09nQmg0UGRkOUlxUXh1V0xSaGN5bDNIOGJqa1RWS0xQ?=
 =?utf-8?B?ZXFFbXkvK3dack02SHlLUnVER0xjc3QydHk5TnBkVmMrckVIQlo0UFRNK09O?=
 =?utf-8?B?bVB2djAraFd5Z1R5QnVOMjJRWVdXTi9lWGJWaWFEeXFkRWo5ZHJYWVVobW81?=
 =?utf-8?B?Ynp4U2drbkk5U2VIb0tMdG85UWVWQ3N3aThpTHVhOGcwUm1CUUpSZTBGbmV6?=
 =?utf-8?B?QnhLTFBnMGY5ZUo0cDE2N05BaHdqdnlrbmpmZWxyVEl5clhNVGdhNmI1cWV2?=
 =?utf-8?B?ZUlLUm5taHdvR29zRW5lQ1pob2JYUHArV0lNTWxjc2paOFNEbjFRY0QrTE5D?=
 =?utf-8?B?a3VLRTZsd1hVdEgvMkJ4c0RSMFZaRndRNjRla2QzcVRXK1F3SDdPQlQ0UWRu?=
 =?utf-8?Q?Oe2TneHKScdBLNt3r24UaTXij?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR11MB58725A73F8347E4C9B0C7C138E8AAMW4PR11MB5872namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f90480-ca43-4099-98e0-08dd8f015ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 13:56:53.7969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uriKJJK/OXkBJCVNjCJ0qe1vf0VcTH2rWKMjk98lKQVG99xB9K4Bgk16DD8kB17SYqafNma8INYqJhivlCXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
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

--_000_MW4PR11MB58725A73F8347E4C9B0C7C138E8AAMW4PR11MB5872namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgVml2ZWssDQoNCkNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBtZSBtZXNvbi1sb2dzL21lc29uLWxv
Zy50eHQ/IEl0IHdpbGwgdGVsbCBtZSB3aGF0IHZlcnNpb24gb2YgbGliYnBmIHlvdSBhcmUgdXNp
bmcgYW5kIHNvbWUgb3RoZXIgdXNlZnVsIGluZm8uDQpJdCBsb29rcyB0byBtZSB0aGF0IHRoZSBh
Zl94ZHAgbWVzb24gYnVpbGQgaXMgbm90IGNvcnJlY3RseSBkZXRlcm1pbmluZyB3aGF0IGxpYmJw
ZiBmdW5jdGlvbnMgYXJlIGF2YWlsYWJsZSBpbiB5b3VyIGVudmlyb25tZW50Lg0KDQpBcyBhIHNp
ZGUgbm90ZSwgaWYgeW91IGRvbid0IGludGVuZCBvbiB1c2luZyB0aGUgYWZfeGRwIGRyaXZlciB5
b3UgY2FuIGJ5cGFzcyBpdHMgY29tcGlsYXRpb24gYnkgc3BlY2lmeWluZyAtRGRpc2FibGVfZHJp
dmVycz1hZl94ZHAgZHVyaW5nIHRoZSBtZXNvbiBidWlsZC4NCg0KVGhhbmtzLA0KQ2lhcmENCg0K
RnJvbTogdml2ZWthbmFuZGkgPHYuby5zLm9wZW5ib29rQGdtYWlsLmNvbT4NClNlbnQ6IEZyaWRh
eSAxOCBBcHJpbCAyMDI1IDIyOjUzDQpUbzogZGV2QGRwZGsub3JnDQpTdWJqZWN0OiBBZGRyZXNz
aW5nIG5pbmphIGJ1aWxkIGVycm9yIG1lc3NhZ2UNCg0KSGVsbG8sDQpNeSBuYW1lIGlzIFZpdmVr
LiBJJ20gYSBDb21wdXRlciBTY2llbmNlIG1ham9yIGZyb20gQ2FuYWRhLg0KDQpJIHdhcyB0cnlp
bmcgdG8gaW5zdGFsbCBEUERLIGJ1dCBlbmNvdW50ZXJlZCB0aGlzIGVycm9yLiBJIGFtIGZhbWls
aWFyIHdpdGggQlBGIHByb2dyYW1taW5nIHNvIHRyaWVkIHRvIGxvb2sgaW50byB0aGUgY29tcGF0
LmggZmlsZSBidXQgdGhlIGJ1aWxkL2FmX3hkcCBkaXJlY3Rvcnkgd2FzIGVtcHR5IGFmdGVyIEkg
Z290IHRoZSBlcnJvciBtZXNzYWdlLiBJJ3ZlIGF0dGFjaGVkIGEgdHh0IGZpbGUgdGhhdCBzaG93
cyB0aGUgdGVybWluYWwgb3V0cHV0DQpJIHJhbiB0aGUgZm9sbG93aW5nIHNjcmlwdHM6DQptZXNv
biBidWlsZA0KbmluamEgLUMgYnVpbGQNCkNvdWxkIHlvdSBwbGVhc2UgZGlyZWN0IG1lIHRvIHRo
ZSByaWdodCBkaXJlY3Rpb24gZm9yIGJ1aWxkaW5nIERQREsgcHJvcGVybHk/IEkgYW0gb24gTGlu
dXggTWludC4gQXJlIHRoZXJlIGRlcGVuZGVuY2llcyB0aGF0IEkgc2hvdWxkJ3ZlIGluc3Rhc2xs
ZWQ/DQpCZXN0IFJlZ2FyZHMsDQpWDQo=

--_000_MW4PR11MB58725A73F8347E4C9B0C7C138E8AAMW4PR11MB5872namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpBcHRvczt9DQovKiBTdHlsZSBEZWZpbml0
aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJn
aW46MGNtOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9udC1mYW1pbHk6IkFwdG9zIixzYW5zLXNl
cmlmO30NCnNwYW4uRW1haWxTdHlsZTE4DQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5
Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30N
Ci5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5Ow0KCW1zby1mYXJl
YXN0LWxhbmd1YWdlOkVOLVVTO30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXplOjYxMi4wcHQg
NzkyLjBwdDsNCgltYXJnaW46NzIuMHB0IDcyLjBwdCA3Mi4wcHQgNzIuMHB0O30NCmRpdi5Xb3Jk
U2VjdGlvbjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQ0KLS0+PC9zdHlsZT48IS0tW2lmIGd0ZSBt
c28gOV0+PHhtbD4NCjxvOnNoYXBlZGVmYXVsdHMgdjpleHQ9ImVkaXQiIHNwaWRtYXg9IjEwMjYi
IC8+DQo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4NCjxvOnNoYXBl
bGF5b3V0IHY6ZXh0PSJlZGl0Ij4NCjxvOmlkbWFwIHY6ZXh0PSJlZGl0IiBkYXRhPSIxIiAvPg0K
PC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPg0KPC9oZWFkPg0KPGJvZHkgbGFuZz0i
RU4tSUUiIGxpbms9IiM0Njc4ODYiIHZsaW5rPSIjOTY2MDdEIiBzdHlsZT0id29yZC13cmFwOmJy
ZWFrLXdvcmQiPg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUyI+SGkgVml2ZWssPG86
cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9Im1z
by1mYXJlYXN0LWxhbmd1YWdlOkVOLVVTIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0ibXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4t
VVMiPkNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBtZSBtZXNvbi1sb2dzL21lc29uLWxvZy50eHQ/IEl0
IHdpbGwgdGVsbCBtZSB3aGF0IHZlcnNpb24gb2YgbGliYnBmIHlvdSBhcmUgdXNpbmcgYW5kIHNv
bWUgb3RoZXIgdXNlZnVsIGluZm8uPG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9Im1zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVTIj5JdCBsb29r
cyB0byBtZSB0aGF0IHRoZSBhZl94ZHAgbWVzb24gYnVpbGQgaXMgbm90IGNvcnJlY3RseSBkZXRl
cm1pbmluZyB3aGF0IGxpYmJwZiBmdW5jdGlvbnMgYXJlIGF2YWlsYWJsZSBpbiB5b3VyIGVudmly
b25tZW50LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUyI+PG86cD4mbmJzcDs8L286cD48L3Nw
YW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9Im1zby1mYXJlYXN0LWxh
bmd1YWdlOkVOLVVTIj5BcyBhIHNpZGUgbm90ZSwgaWYgeW91IGRvbid0IGludGVuZCBvbiB1c2lu
ZyB0aGUgYWZfeGRwIGRyaXZlciB5b3UgY2FuIGJ5cGFzcyBpdHMgY29tcGlsYXRpb24gYnkgc3Bl
Y2lmeWluZyAtRGRpc2FibGVfZHJpdmVycz1hZl94ZHAgZHVyaW5nIHRoZSBtZXNvbiBidWlsZC48
bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpF
Ti1VUyI+VGhhbmtzLDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUyI+Q2lhcmE8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0ibXNvLWZhcmVh
c3QtbGFuZ3VhZ2U6RU4tVVMiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXYgc3R5
bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkIGJsdWUgMS41cHQ7cGFkZGluZzowY20g
MGNtIDBjbSA0LjBwdCI+DQo8ZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRv
cDpzb2xpZCAjRTFFMUUxIDEuMHB0O3BhZGRpbmc6My4wcHQgMGNtIDBjbSAwY20iPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTEu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZiI+RnJvbTo8L3Nw
YW4+PC9iPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZh
bWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPiB2aXZla2FuYW5kaSAmbHQ7di5v
LnMub3BlbmJvb2tAZ21haWwuY29tJmd0Ow0KPGJyPg0KPGI+U2VudDo8L2I+IEZyaWRheSAxOCBB
cHJpbCAyMDI1IDIyOjUzPGJyPg0KPGI+VG86PC9iPiBkZXZAZHBkay5vcmc8YnI+DQo8Yj5TdWJq
ZWN0OjwvYj4gQWRkcmVzc2luZyBuaW5qYSBidWlsZCBlcnJvciBtZXNzYWdlPG86cD48L286cD48
L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9wPg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IZWxsbywg
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5NeSBu
YW1lIGlzIFZpdmVrLiBJJ20gYSBDb21wdXRlciBTY2llbmNlIG1ham9yIGZyb20gQ2FuYWRhLiA8
bzpwPg0KPC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86
cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBz
dHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPkkgd2FzIHRyeWluZyB0byBpbnN0YWxsIERQREsg
YnV0IGVuY291bnRlcmVkIHRoaXMgZXJyb3IuIEkgYW0gZmFtaWxpYXIgd2l0aCBCUEYgcHJvZ3Jh
bW1pbmcgc28gdHJpZWQgdG8gbG9vayBpbnRvIHRoZSBjb21wYXQuaCBmaWxlIGJ1dCB0aGUgYnVp
bGQvYWZfeGRwIGRpcmVjdG9yeSB3YXMgZW1wdHkgYWZ0ZXIgSSBnb3QgdGhlIGVycm9yIG1lc3Nh
Z2UuIEkndmUNCiBhdHRhY2hlZCBhIHR4dCBmaWxlIHRoYXQgc2hvd3MgdGhlIHRlcm1pbmFsIG91
dHB1dDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SSByYW4gdGhlIGZvbGxvd2luZyBzY3JpcHRzOjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+bWVzb24gYnVpbGQgPG86cD48L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4w
cHQiPm5pbmphIC1DIGJ1aWxkJm5ic3A7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPkNvdWxkIHlv
dSBwbGVhc2UgZGlyZWN0IG1lIHRvIHRoZSByaWdodCBkaXJlY3Rpb24gZm9yIGJ1aWxkaW5nIERQ
REsgcHJvcGVybHk/IEkgYW0gb24gTGludXggTWludC4gQXJlIHRoZXJlIGRlcGVuZGVuY2llcyB0
aGF0IEkgc2hvdWxkJ3ZlIGluc3Rhc2xsZWQ/PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5CZXN0IFJlZ2FyZHMsPG86cD48L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5WPG86cD48L286cD48L3A+DQo8L2Rpdj4N
CjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_MW4PR11MB58725A73F8347E4C9B0C7C138E8AAMW4PR11MB5872namp_--
