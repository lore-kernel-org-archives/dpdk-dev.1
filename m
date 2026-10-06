Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771ACA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01EFF40E0A;
	Tue,  6 Oct 2026 12:37:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2AA23402A2
 for <dev@dpdk.org>; Tue,  6 Oct 2026 12:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791283019; x=1822819019;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5ywqdQefx2CST9/wuX2s8DtwkYgzY8BsSiMT+hUs4Vc=;
 b=Fyvulhmie+dKgNDZLkmkAIfhJy/1RNmk2ofNS6tg2OUuokKKzu4EAkLc
 1RoEX4JqOW2tDWtU02EMOkqBuJIvimCnU3lYTIEc0AiImyXeEkSi1k0NQ
 Ba6KJW+1MRP6S/qpIRpOtezMbfVIbQ2b0hq76IKuf+swixPqxnzZGoBHN
 W5ckjpHmg7mJTyZLg1WTGa9vx3etYkKtna3wV60cEcSYPJQTNayusqnEe
 peMeT0OBpHqClsuORXiy5vvW7pSFsVCOkg0zZGlGcphKsI4Hxt61rgk3y
 HYEQmaPAp6nWCPMebQtcg5dLAYGNsq6OCKhgdkQMlT+XKHbn5uExFZ8Xl w==;
X-CSE-ConnectionGUID: ryzVFf9GRdesDYpnrG0Ofw==
X-CSE-MsgGUID: g7YYXf2xQEq4dAa69XFzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102639164"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102639164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:36:58 -0700
X-CSE-ConnectionGUID: KroVW8XoSJafHY0Ml10IDw==
X-CSE-MsgGUID: 7gsElkZ5SpOWgFUDsl0dHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315138598"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:36:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:36:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:36:57 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5jKlQzVKWLuvU6errsIqleYW3DWmcXDdyPIacCkNsONMSC/0K2TicK5KTPcz+ZP3uNWksNe6sGcZ4Q1VhP3aZhCh94KfgvdRAmG94RhMrYKva4lfcgYIqtuJHTrwNCFAq8ExABZDRE8xTtTzf7qANxJ1sx7+ra90q8DWybgKn8MbHztNQZHkJNH786vE4p5yFInQDQFQ7naFgDmqn8Pv/Fy9F+NjDVwP1uDpRwwBmg3LoWBXt+dD+Ep0LEk07YGVY+kR9BCiIXZTiA+Hksjw486AtAis8b2efpOck3ucUdm6vnFlf5QWIHIan4YUME9gW6hDQYHpqMZQJRosxesBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ywqdQefx2CST9/wuX2s8DtwkYgzY8BsSiMT+hUs4Vc=;
 b=yTIAVK62SeYMSuVD5KcUU2bOR9LTfg444QB+4pejI+afIgoyuAafdXVV9fF977w9QzLOUzFQaOdWMHJAiqweyEApE2JYTnJfimYCCl1/uTR9xeFxcJvt8idbZSdU/MGbJWPssteVpzlR++ieYaO2iV/PJQUnSf+n9DZ/Scze4fdtXGpXVDyYLZqZYuwRrY5agklgXVUYHOnE+aZhTnrEUV+7AjDRTe7GxreC71WKZ02BzdeLp1B1rudbl0E6nz8LuJv2Ihx0fpLIx4Mc8grjEtoBBVKCbJmdnnxprW69OPbpMRWiR4eI6nDWAeLqtSJqYBrYoFTDFjRaVx+t4jlbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by PH8PR11MB6975.namprd11.prod.outlook.com
 (2603:10b6:510:224::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 10:36:54 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 10:36:54 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/ice: fix unchecked Tx time context allocation
Thread-Topic: [PATCH] net/ice: fix unchecked Tx time context allocation
Thread-Index: AQHdUhREqgJeaXt2N0+pDmaVVFJgArbwT4wAgAAJHcA=
Date: Tue, 6 Oct 2026 10:36:54 +0000
Message-ID: <AT6PR11MB0445268173D71C808640CEF8A2E4952@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <20261002021937.391321-1-anurag.mandal@intel.com>
 <e5809107-013f-4f3d-b1ac-741eb6788b9b@intel.com>
In-Reply-To: <e5809107-013f-4f3d-b1ac-741eb6788b9b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|PH8PR11MB6975:EE_
x-ms-office365-filtering-correlation-id: 6bb2332a-9d06-48ef-577d-08df2395bd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|38070700021|4143699003|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: tbOwBFL6vSAECdviwQIqMRxgUXmVRaZcAb5zy6wyBLZbVsKlCOZKxwhxk7HzPovQOGsI5TAjGzDERdqLRpHbErr78P/pkQilHuUeOKNuy2DVLcah+aXAVAjEGAHyPQ8vmqF9qrU1kBZ9RjHM80FV3fvZCw4orVOwVvY/71UmpTY1oIe2ISSGA1hFp9viMXAicjWt/OKVCDCnofxFlq1GopQ1mSXQ++MHlUYYBTRXM0hacM9tGCfHFCQMhpPv4uBpyaQ9h5Txzn5nt2runnPo5EL4/54GLK/hN9s50C5RguVBEoLo3dx4M726e+D/rkzIDtfV2X9uEDvVYlPDiiM4O46ZwhYE8HQRYnMkNd8GsaBUZLUvLo4DcqPgiZeJz9g8FABGs4tst9n0kkJhCwh4Xs82aCw21plyQy1/QTnoVIyoeMx2UnujnrmOKcO7FeT2kMt7AR8hF6NSMtRAPowd7tFzK7erB5id2wIKXdTcAvLrwZK0XjPXiL1mP812MdmBUjk6LSGTT0aWlexBDeFXakA0lkO8bQ/Ua4B0TBxUUwuAAGwCakYdf7JBGkdUZqXSiDjNvfm3hr3H/ockdzpV4M8Rob9r62X6jxM9At/8JPgrUmFhjsEr9D5cVu+7fHpLV1lmwyAUkdylkryiOBbP/S5iGKMVK/Vy9fav3MMcTZKX8PwxZggFQo8d5FOiomQKABpPEYlYSEHV42chLIwGUvnMDjZDW4KmY/O9MGl9WnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M250Z29UbFo5bnpsUk0wdGVSTWFDUkpQb2JXbG1oZUk1U0s3YlMyYVp0Rldh?=
 =?utf-8?B?b2o0VnU5V1hUK2g4Qi80VlhZa2xTU0Z0R2hYaFVkSStad1dLUHA0N3BhZlpD?=
 =?utf-8?B?RklnSHJVS3R3aWIyRUVYRE5HRHFUMFpBdFdKUVJFa1VyYnFycFdWUjc2QmRK?=
 =?utf-8?B?ZVdsRTBHSkd6dGdkdzdsTnBROWdGSnBlZGdtOEJVTW1vL1hjZGFyZkNoQ3lC?=
 =?utf-8?B?SVB0cmVvUW02SHQ0NE96T3ViVnJ0NXlMaENUVVU4cnVydXdhaUZwZXFXeTZi?=
 =?utf-8?B?NGJEcWxPdG4xSUI1RWlnYytUZUEzM0ZYbTJUak42VXBqdGt1R2hObGFwZkxJ?=
 =?utf-8?B?bzFzOWdzcnRPbGtpcnltSUZNU2lyWFhQM1B4aVd4UlVKSWtLczE3dnNRelJz?=
 =?utf-8?B?eklZYU1hY3JVaXdaQ3pKdkFxNHRoNVVnME51MC9rNEh6bzZXNkZGc0RpMVVj?=
 =?utf-8?B?TXhzY2l3aXJ0MFROaUFwSjlCNnl0M3RmdXI3TmlITjlvaHcwMVpFVE15ZHlO?=
 =?utf-8?B?eW5BY1NobXpmVUZSTFNITm1wek9YdTl4Z3Y5d0FXcFViUTc2RVlmWHJRbFJF?=
 =?utf-8?B?SEtJaGovVWxQSWt5bUR6V0Y1KzZWSk9PMXUxQ2NqRVlzcllSeWxabmY3K2Jv?=
 =?utf-8?B?amlMS1k5YUZVQTFJb0dLTVNldFJUYXJ3eEJ0OFJkU09LbTV2V0JlaDNlTlJ2?=
 =?utf-8?B?TVZtSWhxNGVnR3YwNHMvVS9ZUjhOVlIveEF0SjFQZTFsL0xJYWRyTVduMjlu?=
 =?utf-8?B?K2wxNExiNzdUME96eSs5dHAxaHBvaWVHZFk4T1V2NWEzSnRLbzlhTnZ3Q1dx?=
 =?utf-8?B?UldYL2hEWVlrMmxyV0ErSjZUN25LNnpJbElNWUdkUkJMdU5wYm5DVEhSNWpO?=
 =?utf-8?B?QlZURXJZM01zMEkxR2Jxa1RzcU5YaVVXU2ZhZUk4YUFDbkI3d3dwS3BiaGc0?=
 =?utf-8?B?Nldkc2hEYmtuMXRsR05wYVcwTFFLelRZM2k4dzJHR01vSVp6Wmh3WTBaczhr?=
 =?utf-8?B?bmtTWGxOb1VFeWtnU1o0Y0Q1TGQvLzdMYWRkdTZUa1U3ZkJmam1WTkM4elZv?=
 =?utf-8?B?RHRGLzZxaHU4NHBHM09HbEt3cjJNbzNVemh5NFBaSWV2UUcya3BjejN2eXg1?=
 =?utf-8?B?Q0RGUWpXbzVLYms3b3pyWFdvam81cGJZcGhaSzN0dTRITlJMWG4rRUJIeHk4?=
 =?utf-8?B?U0llNUZJV0xlZjZmbFAvOEUwNVphMnFOY3A5bTBoMlRqd0NiaU81Q1d5SGpL?=
 =?utf-8?B?MU9ETHNtdzc4d1lsaGlTZkRURzNQRnEyQzFFcEJnVjZDeXR1RnNud1ZjSjFp?=
 =?utf-8?B?SGdaamNjWm5VZ2Nhb2Z2YTVaUi8yM0kwNEs0WlZYUll4RFpaNjBrbHR1cW5H?=
 =?utf-8?B?Vm1hNlF0em54TlROQ1IwMDk3ZFVvN1JHaWFBQXRIdE54Y0NjYmIyZFBGMExi?=
 =?utf-8?B?emZzVnpqUDNKaTdjamtvczkwbVN2c3l1alR6dEg1VU50d0tmWkJFaXdLVEhv?=
 =?utf-8?B?dnpBMHFzeXE2dDhtN1pWM0YyMVZvbkRacTJwaUI0eEJsZE9xZWNnZWFFREFo?=
 =?utf-8?B?aHdEcFJTSWs2QU56K2tJTmp0OFVCWERSOVRkcDg4aSsyN2lPTDZiS3NWTCs0?=
 =?utf-8?B?R081a0p3b2N2QlBIbmpUc3dJcmtiVWZvV2ZBQXVWcnU4NmovdzNGcDBaMG0x?=
 =?utf-8?B?YkYyemFabVNJR09zU3E5TVc5VnBrT2hrcGFZeHJIVmtZYkxtS1RvK2FhV0ha?=
 =?utf-8?B?cEZGRnZOVGxVS0lOQ3ZrYzZFdVovTGpOOHUvb1A1dU5PeGIzY2FOc3ZoT1BF?=
 =?utf-8?B?NVZ5ZHNQQzdPdmRzbktVTEY3Zk96d0g3RVo0ejFGMlIyd3R0RUJGdGRab3la?=
 =?utf-8?B?TkMxcDBHZWFDcCt3d0FnbHN0TGlaT1VMQXpZcXM4QWdsT2krSVdDcXZIeTZt?=
 =?utf-8?B?aG9sdGR5UTVVUU9RdEhHYlI2YzhZUXNlTU1BQ3l5dEp6RGV2cTNkb011NFVW?=
 =?utf-8?B?ZysvNm5RTUdHWnFCMmxtaE44S3lEdUdpTE9xMTU0b1ZFbm5INHlJaWlxVnJ4?=
 =?utf-8?B?aTFwRnoweWhCZUcrVXU2WXcxZWZoRG9XV2pGUjZVMHAxYS9abjFxbkd0MXZ2?=
 =?utf-8?B?R2RKUjFMVGFWSzRXL2drTy9qejZCc3BZTEVEdm1Bb3dmOGlUY3YvZkNlYnBB?=
 =?utf-8?B?T2lodExLTW9uNzB0cnlTdlV1K0llSXRZSmEyclhJdzNGNDdaNzAwU0gzVzBo?=
 =?utf-8?B?NVc5a1YyNXkyODlOYWhkL2xpNWxDNFR5cjA3SmllQmpWRnRSalhGUDVKMExO?=
 =?utf-8?B?ZHZ3RzVKdnFyLzhtQnZ5MEVqZGRZSmlaTTM0N09pN0JzK2hDYkUwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IIx58Ea+q6oy9FQXExXHblbYutr6f9NTNoC6PIBknDBUftzZn+DBbQ8SIoZM2sXxp84O0gox6iSnVPQej0sJpC42uIX7Ae/2jS0qyARQ7Wx3zWB2MtsSkR9sOqgdpEN/cxaV+ogS4nPtvQrR93cVNjZjPQ2nnIwVBkRSMoNYcVRWGXNvrR1XmsX2m9ds0dsPoCJHh0Z2ng0Q4gaQaAfcWpxCgZUUzVcSbtKKgHO+xbdbDpTBd7bFxT9xHWwVZ+a0zbBhA0QBxfIHLjPTv8nPvRYzf+GdcOtCyFlTIOa+hBHkGdq67BovXVWkNc4mUFThFp6IG8xQw6JiJGIwABm+jg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb2332a-9d06-48ef-577d-08df2395bd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 10:36:54.1509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH4ZF5bjgel1RTifwYZh5rVjCaA6VtuZTAN3e+lQ9Skbtd3RPMa+gQFOSMLN3/FJ+ZkDvrniJQiKoRqp0StTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJ1cmFrb3YsIEFuYXRvbHkg
PGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb20+DQo+IFNlbnQ6IDA2IE9jdG9iZXIgMjAyNiAxNToz
Mw0KPiBUbzogTWFuZGFsLCBBbnVyYWcgPGFudXJhZy5tYW5kYWxAaW50ZWwuY29tPjsgZGV2QGRw
ZGsub3JnDQo+IENjOiBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5j
b20+OyBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0L2ljZTogZml4
IHVuY2hlY2tlZCBUeCB0aW1lIGNvbnRleHQgYWxsb2NhdGlvbg0KPiANCj4gT24gMTAvMi8yMDI2
IDQ6MTkgQU0sIEFudXJhZyBNYW5kYWwgd3JvdGU6DQo+ID4gaWNlX3R4X3F1ZXVlX3N0YXJ0KCkg
ZGVyZWZlcmVuY2VzIHRoZSBUeCB0aW1lIHF1ZXVlIGNvbnRleHQgYnVmZmVyDQo+ID4gcmV0dXJu
ZWQgYnkgaWNlX21hbGxvYygpIHdpdGhvdXQgTlVMTCBjaGVjay4NCj4gPiBPbiBhbGxvY2F0aW9u
IGZhaWx1cmUsIHRoZSBFODMwIHNlbmQtb24tdGltZXN0YW1wIHBhdGggdGhlcmVmb3JlDQo+ID4g
Y3Jhc2hlcyBpbnN0ZWFkIG9mIHJlcG9ydGluZyAiTm8gTWVtb3J5IiBlcnJvciwgYW5kIGFsc28g
dGhlIGFscmVhZHkNCj4gPiBhbGxvY2F0ZWQgdHhxX2VsZW0gYnVmZmVyIGdldHMgbGVha2VkLg0K
PiA+DQo+ID4gQWRkZWQgdGhlIG5lY2Vzc2FyeSBhbGxvY2F0aW9uIGZhaWx1cmUgY2hlY2sgYW5k
IGZyZWVkIHR4cV9lbGVtIGJ1ZmZlcg0KPiA+IGluIGNhc2Ugb2YgZmFpbHVyZSB0byBhdm9pZCB0
aGUgbWVtb3J5IGxlYWsuDQo+ID4NCj4gPiBGaXhlczogMGI2ZmYwOWExZjE5ICgibmV0L2ludGVs
OiBzdXBwb3J0IFR4IHBhY2tldCBwYWNpbmcgZm9yIEU4MzAiKQ0KPiA+IENjOiBzdGFibGVAZHBk
ay5vcmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudXJhZyBNYW5kYWwgPGFudXJhZy5tYW5k
YWxAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9y
eHR4LmMgfCA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX3J4dHguYw0KPiA+
IGIvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4LmMNCj4gPiBpbmRleCBiMzMzNDQ0Y2Jm
Li44NzNhY2EwMTAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2Vf
cnh0eC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4LmMNCj4gPiBA
QCAtODk4LDYgKzg5OCwxMCBAQCBpY2VfdHhfcXVldWVfc3RhcnQoc3RydWN0IHJ0ZV9ldGhfZGV2
ICpkZXYsDQo+IHVpbnQxNl90IHR4X3F1ZXVlX2lkKQ0KPiA+ICAgCQl1OCB0c19idWZfbGVuID0g
aWNlX3N0cnVjdF9zaXplKHRzX2VsZW0sIHR4dGltZXFzLCAxKTsNCj4gPg0KPiA+ICAgCQl0c19l
bGVtID0gaWNlX21hbGxvYyhodywgdHNfYnVmX2xlbik7DQo+ID4gKwkJaWYgKCF0c19lbGVtKSB7
DQo+ID4gKwkJCXJ0ZV9mcmVlKHR4cV9lbGVtKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gKwkJfQ0KPiA+ICAgCQlpY2Vfc2V0dXBfdHh0aW1lX2N0eCh0eHEsICZ0eHRpbWVfY3R4LCB0
cnVlKTsNCj4gPiAgIAkJaWNlX3NldF9jdHgoaHcsICh1OCAqKSZ0eHRpbWVfY3R4LA0KPiA+ICAg
CQkJCXRzX2VsZW0tPnR4dGltZXFzWzBdLnR4dGltZV9jdHgsDQo+IA0KPiBJIGRvbid0IHBhcnRp
Y3VsYXJseSBsaWtlIHRoZSBmYWN0IHRoYXQgd2UncmUgYWxsb2NhdGluZyB1c2luZyBgaWNlX21h
bGxvY2AgYnV0DQo+IGZyZWVpbmcgdXNpbmcgYHJ0ZV9mcmVlYC4gVGhpcyB3b3JrcyBvbmx5IGFj
Y2lkZW50YWxseSAoYmVjYXVzZSBgaWNlX21hbGxvY2ANCj4gcmVzb2x2ZXMgdG8gYHJ0ZV9tYWxs
b2NgKS4NCj4gDQo+IE5vdCBhIGJsb2NrZXIgZm9yIHRoaXMgcGF0Y2gsIGFzIHRoaXMgaXMgZm9s
bG93aW5nIGVzdGFibGlzaGVkIGNvbnZlbnRpb24gaW4gdGhpcw0KPiBmdW5jdGlvbiwgYnV0IElN
TyB0aGlzIGNvZGUgY291bGQgYmVuZWZpdCBmcm9tIGEgc2VwYXJhdGUgcGF0Y2ggcmVwbGFjaW5n
DQo+IGRpcmVjdCBgcnRlX2ZyZWVgIGNhbGxzIHdpdGggYGljZV9mcmVlYC4NCj4gDQo+IEFja2Vk
LWJ5OiBBbmF0b2x5IEJ1cmFrb3YgPGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb20+DQo+IA0KDQpJ
IHdpbGwgYmUgc2VuZGluZyBhIHNlcGFyYXRlIHBhdGNoIHRvIGNoYW5nZSByZXBsYWNpbmcgZGly
ZWN0IGBydGVfZnJlZWAgY2FsbHMgd2l0aCBgaWNlX2ZyZWVgZm9yIGJ1ZmZlcnMgYWxsb2NhdGVk
IHZpYSAnaWNlX21hbGxvYycNCg0KPiAtLQ0KPiBUaGFua3MsDQo+IEFuYXRvbHkNCg==
