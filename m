Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE9C021B8
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 03:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87F9A40299;
	Thu, 27 Feb 2025 04:03:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C998240290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 04:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740625401; x=1772161401;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xg/OCnAtuUmjH4zHsA9tWldnjt8ivE0KKUpYDeben10=;
 b=oEgWE5mFSy3D5sUneXmn7DsMEFRG7RE8ADgYLBOVnVbiM+f0lB/45DZe
 atd1C+aTnE4iZGdiXcqoagkoYYk5gdzymbnYMNdOdztfspTjqK+aK8AX/
 Bn8iqb6bkYFQVfzwTWsl1Tt3OnRp/JlIanllYbcuRaIhY/WWO2DR67Y6K
 M0F5YUclnbF9Fe3z0VwdDpZol3JYp7mbCbKa3o8EKa+efvvOhEgiDyY/P
 +0MNo8V+j7AEzwR6KSGlUN8po1aRUgTe7iRrD+lApTp5FFXGARtSuU0U6
 Dd+oBKuboSgQQ4bbIUijwwGaNPrP/WU5prBa6EtMWFrZ7mP5In9jOwzv6 Q==;
X-CSE-ConnectionGUID: yTdoDJtUSEqP2d5Cuoi3WA==
X-CSE-MsgGUID: nkPs0UZaTPCxzVhXvQ0rJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52137463"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52137463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 19:03:20 -0800
X-CSE-ConnectionGUID: jKzxgBLJT4e3QwFabeCsXA==
X-CSE-MsgGUID: LOmzD2c+QOi0hsSNQCcoBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="154084197"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 19:03:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 19:03:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 19:03:19 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 19:03:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N47kIEyhi3Axr/YMI9UrkrSODogChnUz8UIMNW0EAScmMRJGC9hF/B5dSbQaF6846Q0hH0taGeN1wKI2hKb78BFh1osHRf5Ruf+TWxoGi2q+M93ZZAMnejt8z1vS61HniOtRn7OPIszeBAS59QG9X/mhqi26h7M1xE7187lK3FOkmfCRUS2neXL37pDOM+uehcJiFUky4BF3wGZ9j6YmbohbENMlq5T5QeqXld0zjOsKl27yMV1ORcbHhzuutpXU3tLGYKn0I5MH4oXVm+F/NAZuoCaJwC/ibrI06Ykzr/pAhUnODpoB+M2sExSe6xLPyPbDeFzJnWhPQCyXKQWBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg/OCnAtuUmjH4zHsA9tWldnjt8ivE0KKUpYDeben10=;
 b=fIRg/sxH5jl0383POJm6SbzXFghJr8yOGf/0Gn1RdfMb8q/Pl/Dz3vwod2yVsG8e4XEE2uu0d3xpRwcHNqOpqjcDL4jeFL0jkBHkD6yuxNBwmTCF1pw1QMHNGkox/cskIHstN9cAfNDASpCfYrqcF3XHu+rsqxOgwT1v13vUngJiSTP6VFa/aqcOLkicRug6527x5HlFE8gUMgpUaojVdha25Zo7vbDIvIGGF8mLf2FyEE7ZsL7EyRkhiQjWEsF3MGspbVYWpGwnsJMMXWH1zUwlC5knO5sJUcQHqQO3EYzb0biYb1kSBXFNiB9dicHn1J8OzzXLM9bXyKZ8MuHVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 03:03:14 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 03:03:14 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Kovacevic, Marko" <marko.kovacevic@intel.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, "Richardson, Bruce" <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@xilinx.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>
Subject: RE: release candidate 25.03-rc1
Thread-Topic: release candidate 25.03-rc1
Thread-Index: AQHbfW5FBfavuKwZ+k+4AR8buOu3R7NajKug
Date: Thu, 27 Feb 2025 03:03:14 +0000
Message-ID: <MW4PR11MB59126A2A1A3732C4F440ABBC9FCD2@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <17054329.0ZKypZ73Fx@thomas>
In-Reply-To: <17054329.0ZKypZ73Fx@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: 7c5d4656-3a74-4749-da8b-08dd56db46ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTM2WmJtYlV4YTI4TllIVklwbjIrbVVoWHVYdmg0dDBQUVFzK3NHaGNTOHF4?=
 =?utf-8?B?RHZpUndmYU1UbmgrcG01Y09EU0JCZG9YQzl5TkUrMWs4ZCswMDhCWFV1WTF4?=
 =?utf-8?B?Tk9DcGxIa1RPZjBMNy9IT1F3NENLV08zMjRPdDZ3L05IZVZ1eFc0WWJFcnQz?=
 =?utf-8?B?bHVDeWh5WkR4NnluYW5DWElXSG4xZUwxVlduQWpyVkNac2JDdTlnYXNtQThO?=
 =?utf-8?B?U2F0cHM1UFdIV3J6dXRLVW1wRmtFaTJzbmpqWnZvc3orNzZJVUdUODFqejh4?=
 =?utf-8?B?NTB0THI4VC9mL1JaL3hmTVBleUUyNWhTRWxXYnBXeWw0TWRoQmpCa0pmTmhI?=
 =?utf-8?B?TmtwTGxqaEVMejM3bmJ4cEU3amdRM3lYYVdFR0xyRDlHamE2cVlqeWRNNmtD?=
 =?utf-8?B?ZFB0MmdnQVpjMTFjNk5EZGdrb2pCNFB0bnM5cHBWRDVrVE9DaFgybnE4Rmdu?=
 =?utf-8?B?MmF0ejhja2xWNkpKY3FSbHRlUG9qL1V4RHlLZ0tzVysrQVYwbFlCenFia2N6?=
 =?utf-8?B?UTNCM3crdE1TWUNhOVdUcGI5ZXJtV0ZIMTJXWTRMSy9QYnhrNmlyUjVSeTdZ?=
 =?utf-8?B?YjZiOXhjbHFUNnJQT0pteFlOaW1CeUU3SUJwQ0dkSlk5dUVPVXpSVFR0RldT?=
 =?utf-8?B?dkpldExGdHRCTmZyTWpOZEFCNGRJRjFaU3JyUVFFSGR5dkZRd3Azd3ppWUlh?=
 =?utf-8?B?bmt4ZERZb1Vlb0pDVks3MGw4RGdlcGZHN25lanluZFFxU05IaGNIZ2lnczE4?=
 =?utf-8?B?RWh1MEtJc3c5WVhJTGYwOXNnVHE1cXg4WGVoUGFYZ0JkalYrOCt6SHQzT2cy?=
 =?utf-8?B?cElabk1yV0Y1MCt3dXRuUjYreGJTWHJwRTlONzdnRE1UZzBNbXJDc1JyOU13?=
 =?utf-8?B?RHo5QjRFVUI0RURRUlozTFlhZUVtV3NQR2N5TjV5ZUpldVEwaWRMN3dZVWhp?=
 =?utf-8?B?aHJhUTZNQWlTZDAwN29wcmNnZzhtbkg5YjNhMFlVN2txaFZ3WmlxZzRmL3J4?=
 =?utf-8?B?VzQzb0J0eEFLMjZiYXJJL2hoS3Q2MkNkZ294ZEJ0Mk9XZFBrcE90TnJQY0NU?=
 =?utf-8?B?NDlybDY0QzJHNUdBUklZVWU4MHVPdldBblo5TC9RcUMxU0NoaGpkVUJqckRr?=
 =?utf-8?B?MnZhUnZ2Nm9vWi9zaS9pRUw3ZHBJUzgzeHo3U1Y4cTR0ckJ5QTI4eS80M2NO?=
 =?utf-8?B?a3NwLy9rNzFGRlhNemQxV21EOFhyN09ndzBSKzllRlYrQk5xblZ3bGpRbm9O?=
 =?utf-8?B?NmhoYUR4UjgyNGhTdU5GVzdlS3QzTmpKVklkd05RZC9BbGlMRjJhSzVyQnRL?=
 =?utf-8?B?bzNYbDd4Y3BjUzFqYnBmQm9QNXdKR21QNlQvbFJyNjliS1BFNEZ1d3pBOUhV?=
 =?utf-8?B?ZlNKcDRuN3RadGRqSjFQV2pneE4rYS9GZzQ5UzRxV29EOTVGRWkzZWlRdGo2?=
 =?utf-8?B?Uy9DME9tVGZZVzZZOHN0NUJERFoxYjJ4S1ZvQVphbHRqQ0NTMlFyL1NoV0E3?=
 =?utf-8?B?ZG5yamhXek9GZ1BLN0NaUTJUY21vNHlRWGR5cmZoMk55K001YWFJT216YjlO?=
 =?utf-8?B?a1FGcFdOaExrb0owTFB5WU01d2hNNkVMVlRrMjRtanlRakR0NUFZVlVPcUpH?=
 =?utf-8?B?V1NxQ1ErVldmcHUzVTZ4RXNqSEhRTy94M21NQVJ4MWJKNUQ5bWYzdkI5NE9R?=
 =?utf-8?B?bFU3QkFBU3UyWnZpR3dsZ1ZQM1FIeFQxU2FZUmpnVmR5T0xRT3k1UitUeEJp?=
 =?utf-8?B?V3NEUk5BMWN5eCtMRkV4a2NpYThoeDdBWW4rdk56QWI2R25tcm12T2Z6RmNi?=
 =?utf-8?B?ZEtwdjRDcW5UdXBBeW1XYXpRNXR0YmJmRFU0ajRCL1ZRT0pEeVEvOEFpemth?=
 =?utf-8?B?aVc1TVp5TjlkTnkyajlaalZMaHBxSWhaOEVJaU9idUhiREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE9ONXd3YTFHd0lINHhwa3VOMURYNTllQ2RWdUQ5U1NtSnBuSmgwYnlTQ0tv?=
 =?utf-8?B?MkxZRnptc0xUNUQ4cWZKTXZpRUdqeFpuclhCYXJWNkxWNnV0QWxTckNKSVIz?=
 =?utf-8?B?SFloNGtZNk5tRmVWQ3ZlUTZDSWYzTFU5ekR2dmhvMTZkRC9CcDQ4L1hKemU1?=
 =?utf-8?B?MkZiWnArU2NCTmtWVkh2R0o0OG8vQUN0V2wwS3FaRVFPbjdETUlGV1VQSUpH?=
 =?utf-8?B?ODh4RXE0b3ZibU5BYlFxNTBUYW5xNjZMV2J6UWV2RFFUTy9Db2ZYQkMzSVFY?=
 =?utf-8?B?d3Yrb0VKTm9LQ3g5enN3dGJFQnYwM1V0cTAxeTFTZDdtbHlFV0JtaXZwSk1a?=
 =?utf-8?B?YXFua293VmdSd3BTaWhQUklEL0xYZUtaM2hqYXhkSzdiTHZRbkNrQy9MSjgw?=
 =?utf-8?B?VW1obkxwdWxucm5uQUM1eGdNWHBHRkkxWUpJbHhNR3ZmMThQR3RJQXE3d2VI?=
 =?utf-8?B?WmNObVI4dFFyYUlZY0ZoMGZDNVdZNjFDSFVKL2FDNFE1bklJT3BLZStOQUtK?=
 =?utf-8?B?UEkxRWtvUlYxRWxLWVVmUmdwdHpCckw0akx0OThPZVh0R0ZBM1pBTGRlMlVt?=
 =?utf-8?B?dHdUS0RGUmlvQ2liVm1FNlhVYzdEZzg4UmZKUWNFTkRXTmlSdU1jY3o2VjJI?=
 =?utf-8?B?VTFjWVlsNitWYUE3ODRvTUpySmhQSU9Mb0pMWVNjdkxXQVNwNmhncnRBNmRi?=
 =?utf-8?B?S3k1SE5iVXNCMU9lT1dYR3dEdEo4bHZ0aDZCakx3L296UzJsNHRGYVFzNzF2?=
 =?utf-8?B?dlVsUkZyOWg4WmRNb2NLNVl5My94eTJvV2w4T2hiYUh1NURQaFlaRjBwbE11?=
 =?utf-8?B?cnI3MHNUNzdZLzQyVVMyQWhxd0FQRjVmeDhyWTBaaTFkSEsvUUxiYXQ1V3do?=
 =?utf-8?B?RlRTa2dnM3BVMjJBUTEwUyt2UFlGd0VMNjk2MkRnNm9BM2hxUXUxc2pzUUZy?=
 =?utf-8?B?azlWWEM3R2V6UjFZMFdqV3FjQzBuYUVBb2xIU2FlNjNIZzNjV0lITHhiK1dQ?=
 =?utf-8?B?ZVVHc2RJOXdTalZXNU84dmRaMCtPZVhDRmJ4amFZMnEzUEp1RWY4eWxVRFRS?=
 =?utf-8?B?REZQVGhwOFI2cGs5Q1c4U2dkS1hIenNXb3JSNklsWVFBYUpGdzBKTHpnLytL?=
 =?utf-8?B?VUNjbFdST0dVU0h1alhoTU8xWUdibDBXaVpuT1pvZkQxWVVROHFFdnNNbEt2?=
 =?utf-8?B?bDlXTm8vaDRvZUQ2d0s1TVh3NjVXYzVJb2VZMW52QzNYKzZUeDl4bUJ1SlZG?=
 =?utf-8?B?SXFpVDJYbG1oaSsvRyswbEwxSVErOUF2TGdrQ3ZVckJ0ZE13Q20rRG9Gc2Z5?=
 =?utf-8?B?NTZkOFY1SUd2enp4bDFhK2RDNCtIOUljRzhWZE9LcHE2MVdxYjV3VnNEZWti?=
 =?utf-8?B?aENZR0hKZXZkRkpDOUs5ZjNZc1d2VWR6OGhvVzAyb0NnQ2RpLytkTjJhYVI2?=
 =?utf-8?B?SFJ2bGdGMktzQnVKdjJxNEQwT2F5VmhpSS9Qd2JZOVNSUU1yVXZjeXdYbVF0?=
 =?utf-8?B?NnJIendqT2RkUDVJdHRsdlhrMFJJOTBrV3pxdENyYTFJcEFwR0ZWdy9RTzhO?=
 =?utf-8?B?RWpRejZHVFZ0cXZTaGl6YmZNb0F6MXByKy80d0lvQnJxMXBsR0RhQ21FSHph?=
 =?utf-8?B?NVdXNUJSeDVzL09hRjZqdHUyVmJsQUs5OFBKWVNNczJMRXhBSDgrVnV2TXF2?=
 =?utf-8?B?SlRPaWJFaEhWM2lQZXpHSGo1VEZFa3BJVlk1cUErRW4zS0EwMlVGR0NEN1Fj?=
 =?utf-8?B?ZmxraU1MNmZUc1RMT0lnRUg1MFVkZEN4WktodU1ka3VCVjNsOWZJdTAzeTQr?=
 =?utf-8?B?b2l3RGlCQlVJMWhpVkkxVFRxUFUyTDcvVzA0TUNFcHhhU1RZNWVWYjVDbm1p?=
 =?utf-8?B?WVRTc1ozY0hjTWp3WW91M1VoU1hBNGcxMCtqcDV4NGx0RnBSVnBCUFdoQTJl?=
 =?utf-8?B?WjMyOUR2WU42b2pOd0F6SzczZURITjI2b3ZoWkhOSWI0ZG1CR05ITGRNaHFM?=
 =?utf-8?B?cE5jbFdPM0cwL1lXK0NQbUVlMjVmVXBXeDVSNkdoUVZ5enJBV2dYd2NjSnk5?=
 =?utf-8?B?VHlobE11NXdVLytrb0RkTk9vWUZacURZN0xHK1JnbEtDUk1BNHV1U1YxWlNy?=
 =?utf-8?Q?HxmT7Qz3VLNeI+tDk/lAv6bJu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d4656-3a74-4749-da8b-08dd56db46ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 03:03:14.3941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8SENWxV3f/Jc1Aa5tsCihypWamWLl5pTAkaIcm1bzfkwLYVvJ5DFzSH6DS2Q11wdu6AIPJKycfytt6NugNkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
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
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxMywgMjAyNSAx
Mjo1MCBBTQ0KPiBUbzogYW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogcmVsZWFzZSBjYW5k
aWRhdGUgMjUuMDMtcmMxDQo+IA0KPiBBIG5ldyBEUERLIHJlbGVhc2UgY2FuZGlkYXRlIGlzIHJl
YWR5IGZvciB0ZXN0aW5nOg0KPiAJaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay90YWcvP2lkPXYy
NS4wMy1yYzENCj4gDQo+IFRoZXJlIGFyZSA0NzggbmV3IHBhdGNoZXMgaW4gdGhpcyBzbmFwc2hv
dC4NCj4gDQo+IFJlbGVhc2Ugbm90ZXM6DQo+IAlodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMv
cmVsX25vdGVzL3JlbGVhc2VfMjVfMDMuaHRtbA0KPiANCj4gSGlnaGxpZ2h0cyBvZiAyNS4wMy1y
YzE6DQo+IAktIFN0YWdlZC1PcmRlcmVkIHJpbmcgKFNPUklORykNCj4gCS0gbWJ1ZiByYXcgYnVs
ayBmdW5jdGlvbnMNCj4gCS0gc29tZSBJbnRlbCBkcml2ZXJzIG1lcmdlZCB0b2dldGhlcg0KPiAJ
LSBZdW5zaWxpY29uIHhzYyBuZXR3b3JraW5nIGRyaXZlcg0KPiAJLSBaVEUgU3RvcmFnZSBEYXRh
IEFjY2VsZXJhdG9yIChaU0RBKSBkcml2ZXINCj4gCS0gSW50ZWwgY29tcGlsZXIgaWNjIHN1cHBv
cnQgcmVwbGFjZWQgYnkgaWN4DQo+IAktIG1vcmUgZnVuY3Rpb24gYW5ub3RhdGlvbnMgZm9yIGFu
YWx5emVycw0KPiAJLSBtb3JlIE1TVkMgY29tcGF0aWJpbGl0eQ0KPiANCj4gUGxlYXNlIHRlc3Qg
YW5kIHJlcG9ydCBpc3N1ZXMgb24gYnVncy5kcGRrLm9yZy4NCj4gDQo+IERQREsgMjUuMDMtcmMy
IGlzIGV4cGVjdGVkIGluIG1vcmUgdGhhbiB0d28gd2Vla3MgKGVuZCBvZiBGZWJydWFyeSkuDQo+
IA0KPiBUaGFuayB5b3UgZXZlcnlvbmUNCj4gDQpVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJ
bnRlbCBwYXJ0LiBkcGRrMjUuMDMtcmMxIGFsbCB0ZXN0IGlzIGRvbmUuIGZvdW5kIHNpeCBuZXcg
aXNzdWVzLg0KDQpOZXcgaXNzdWVzOg0KMS4gW2RwZGsyNS4wM10gbnZncmUvbnZncmVfaXB2NF9j
aGVja3N1bV9vZmZsb2FkOiBjb3JlIGR1bXBlZCB3aGVuIHF1aXQgdGVzdHBtZCAgICAtPiBoYXMg
Zml4IHBhdGNoDQoyLiBbZHBkay0yNS4wM10gaWNlX2RjZl9hY2xfZmlsdGVyOiB0aGUgcnVsZSB0
aGF0IHN1cHBvcnRzIGJvdGggc3dpdGNoIGFuZCBBQ0wgd2lsbCBiZSBwcmlvcml0aXplZCBmb3Ig
c3dpdGNoICAgIC0+IEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQozLiBbZHBkay0y
NS4wM3JjMV1bVWJ1bnR1MjQuMDQuMV0gaXBzZWNfZ3dfY3J5cHRvZGV2X2Z1bmMvcWF0XzNkZXNf
Y2JjX2lwdjRfdHJhbnNwb3J0OiBidWZmZXIgb3ZlcmZsb3cgZGV0ZWN0ZWQsIEFib3J0ZWQgKGNv
cmUgZHVtcGVkKSAgICAtPiBoYXMgZml4IHBhdGNoDQo0LiBCdWcgMTY2MyAtIFtkcGRrLTI1LjAz
XSBmbGV4aWJsZV9yeGQvY2hlY2tfSVB2NF9JUHY2X1RDUF9maWVsZHNfaW5fUlhEX29uX3NwZWNp
ZmljX3F1ZXVlczogcG9ydCBjb25maWcgcnhxL3R4cSBmYWlsZWQgYWZ0ZXIgYXR0YWNoIHBvcnQg
ICAgLT4gbm90IGZpeCB5ZXQNCjUuIFtkcGRrLTI1LjAzXSBbTk5UXSBwbWRfYm9uZGVkXzgwMjNh
ZDogcG9ydCBzdGFydCBmYWlsZWQgYWZ0ZXIgc2V0IGJvbmRpbmcgbGFjcCAgICAtPiBoYXMgZml4
IHBhdGNoDQo2LiBbZHBkay0yNS4wM11wb3J0X2NvbnRyb2wvdGVzdF9wZl9zdGFydF9zdG9wX3Jl
c2V0X2Nsb3NlOiBGYWlsZWQgdG8gbWFudWFsbHkgcmVzZXQgcGYgICAgLT4gaGFzIGZpeCBwYXRj
aA0KDQojIEJhc2ljIEludGVsKFIpIE5JQyB0ZXN0aW5nDQoqIEJ1aWxkIG9yIGNvbXBpbGU6ICAN
CiAqQnVpbGQ6IGNvdmVyIHRoZSBidWlsZCB0ZXN0IGNvbWJpbmF0aW9uIHdpdGggbGF0ZXN0IEdD
Qy9DbGFuZyB2ZXJzaW9uIGFuZCB0aGUgcG9wdWxhciBPUyByZXZpc2lvbiBzdWNoIGFzIFVidW50
dTI0LjEwLCBVYnVudHUyNC4wNC4xLCBGZWRvcmE0MSwgUkhFTDEwLCBSSEVMOS40LCBSSEVMOS41
LVJULCBGcmVlQlNEMTQuMiwgU1VTRTE1LjYsIE9wZW5Bbm9saXM4LjksIEF6dXJlTGludXgzLjAg
ZXRjLg0KICAtIEFsbCB0ZXN0IHBhc3NlZC4NCiAqQ29tcGlsZTogY292ZXIgdGhlIENGTEFHRVMo
TzAvTzEvTzIvTzMpIHdpdGggcG9wdWxhciBPUyBzdWNoIGFzIFVidW50dTI0LjA0LjEgYW5kIFJI
RUw5LjQuDQogIC0gQWxsIHRlc3QgcGFzc2VkIHdpdGggbGF0ZXN0IGRwZGsuDQoqIFBGL1ZGKGk0
MGUsIGl4Z2JlKTogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIFBGL1ZGLVJURV9GTE9XL1RTTy9K
dW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvVkxBTi9WWExBTiwgZXRjLiANCgktIEFsbCB0ZXN0
IGNhc2UgaXMgZG9uZS4gZm91bmQgdGhlIDUgaXNzdWUuDQoqIFBGL1ZGKGljZSk6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBTd2l0Y2ggZmVhdHVyZXMvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cg
RGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3Jp
cHRvciwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4gZm91bmQgdGhlIDEsMiw0LDYg
aXNzdWVzLg0KKiBQRi9WRihhcGZpL2NwZmkpOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgY3Bm
aV9ydGVfZmxvdy9UU08vTVRVL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZCwgZXRjLg0KCS0g
RXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4gTm8gbmV3IGlzc3VlIGlzIGZvdW5kLg0KKiBJbnRlbCBO
SUMgc2luZ2xlIGNvcmUvTklDIHBlcmZvcm1hbmNlOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcg
UEYvVkYgc2luZ2xlIGNvcmUgcGVyZm9ybWFuY2UgdGVzdCwgUkZDMjU0NCBaZXJvIHBhY2tldCBs
b3NzIHBlcmZvcm1hbmNlIHRlc3QsIGV0Yy4NCgktIEV4ZWN1dGlvbiByYXRlIGlzIGRvbmUuIE5v
IG5ldyBpc3N1ZSBpcyBmb3VuZC4NCiogUG93ZXIgYW5kIElQc2VjOiANCiAqIFBvd2VyOiB0ZXN0
IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmktZGlyZWN0aW9uL1RlbGVtZXRyeS9FbXB0eSBQb2xsIExp
Yi9Qcmlvcml0eSBCYXNlIEZyZXF1ZW5jeSwgZXRjLiANCgktIEV4ZWN1dGlvbiByYXRlIGlzIGRv
bmUuIE5vIG5ldyBpc3N1ZSBpcyBmb3VuZC4NCiAqIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNs
dWRpbmcgaXBzZWMvaXBzZWMtZ3cvaXBzZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJ
QiBsaWJyYXJ5LCBldGMuDQoJLSBFeGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBuZXcgaXNzdWUg
aXMgZm91bmQuIA0KIyBCYXNpYyBjcnlwdG9kZXYgYW5kIHZpcnRpbyB0ZXN0aW5nDQoqIFZpcnRp
bzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBh
cyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0y
Vk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjBVMSwgZXRjLg0KCS0gRXhlY3V0aW9uIHJh
dGUgaXMgZG9uZS4gTm8gbmV3IGlzc3VlIGlzIGZvdW5kLg0KKiBDcnlwdG9kZXY6IA0KICpGdW5j
dGlvbiB0ZXN0OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQ3J5cHRvZGV2IEFQSSB0ZXN0aW5n
L0NvbXByZXNzRGV2IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMsIGV0Yy4NCgktIEV4
ZWN1dGlvbiByYXRlIGlzIGRvbmUuIGZvdW5kIHRoZSAzIGlzc3VlLiANCiAqUGVyZm9ybWFuY2Ug
dGVzdDogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIFRocm91Z2hwdXQgUGVyZm9ybWFuY2UgL0Ny
eXB0b2RldiBMYXRlbmN5LCBldGMuDQoJLSBFeGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBwZXJm
b3JtYW5jZSBkcm9wLg0KDQoNClJlZ2FyZHMsDQpYdSwgSGFpbGluDQo=
