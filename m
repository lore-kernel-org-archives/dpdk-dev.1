Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0627FC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB9440B9F;
	Mon, 14 Sep 2026 13:57:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 87BF2402F1;
 Mon, 14 Sep 2026 13:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789387032; x=1820923032;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mKPgIu1VS/3etPAHRs7UolrTHjVKASEBFSTmbLpoGcE=;
 b=AhBYhwkKgrIR5uK0XCn/0LGoE9mZk+z7uAO/JKH36UXbErnNx4nH+zd/
 r4M3+JgIw4rbXkZPP2uItxILqodyxRXP1+XSeAyhNmMsLvu+i08zuOle2
 UpX9TyrUT9OMVIe4MIUwY36NXsijRtDB3w3NNRFoXSzzwAK5/sRYPa6Sp
 gixb+zc79by1v/ulwGC1SZVKUJF3qRv/ClxYpVU+P8SvOhmrZAgVyv9Jw
 nIg3xTmmm8W3kbt2ASHokyFD+CtCdapTbAGcyLRK/I0hS7EDs1h4XfTiI
 3wdxutseZit0OHloY+bwGyLJsLoEYhqS+ANsJZTKZ0R8c6nuM0K1YlNZU w==;
X-CSE-ConnectionGUID: z191LDzPRcWBuOn2cRsEsA==
X-CSE-MsgGUID: p5wa9fTeQFKZ2r/nybA/AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93432973"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="93432973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:57:11 -0700
X-CSE-ConnectionGUID: rO1yZGcOSLSH8ymHOtS7VA==
X-CSE-MsgGUID: xT5utlULQkS9W5rv7HnwMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="272117561"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:57:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:57:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 04:57:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOpNIDsaSFV6LTjxePSQhAcRvRTerMnZiyZEwlVKjs5Hk3bmm4f+MCHBjWFh/muEZKRD4ny3slpleibMHQ5wVHiGvmwiWxJvwcoAghWH9+kkeHkCaVqjxm8K3z54/l19lXDJyJqKV4K7ftDMBm1PLf8ECFKPpHIM6Kzb5Ezofpjn6poQQWb17vRGfmnenf4Y1Dxv+kbnI5BTUwcdyjmC7tTYKO+qJk/UH1Uv/oJAt+jgd5HW5NGbQ8tu2wJl3p9T+AcHc+gBrXE6ukIHbkBcRrz42UUZYf5TRqfxKhItbKJQXfY6DLbNySBAAKwOLsUIgLC8wKqp3Nu9/RNgEd1Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKPgIu1VS/3etPAHRs7UolrTHjVKASEBFSTmbLpoGcE=;
 b=Fym9/KfBAdH09YbX/7NzVQH6F8TzAjIaqWkZ/ZKwt8AabR/P3Joo1u9WukwGxaJAmIKlXE+sY9vxhGQvMRh+Q180uSep3kd/6d6i3pkOemB2sDgmB2Mr9X1neEo5lR4HuW7FrLUPxLk3NqwT8w70zXZRq27DoYqK8zxj2SrQ40Ow7CjZRhzMdLqXoo3C/te18EzI3yA736J2GdTBjF9M9v/UpXvYErNQCwd9OGvYwztitxdTAIOb8tlWUu0PO1EG3+tJAtUvW7Uy0XhtAugrMOGVIF+Z2wADJN4cubYseJ5sTLzkpBiKO8b/hKBkd9GbgrrKNVGNnYn/G2fpKeinoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:57:06 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:57:05 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "cfontain@redhat.com" <cfontain@redhat.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 Lunyuan Cui <lunyuanx.cui@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, 
 Xiaolong Ye <xiaolong.ye@intel.com>
Subject: RE: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Thread-Topic: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
Thread-Index: AQHdRCGPgqyD/7JkykqIZgE6/0RWB7bN2x9wgAAcQoCAAABX8A==
Date: Mon, 14 Sep 2026 11:57:04 +0000
Message-ID: <IA4PR11MB9278A59FB4B28DF12BE31B338EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <IA4PR11MB9278D5E85C6AD7C17FCF659D8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8z-yyLsScuWJhoZp-1Jz+3r1+zV2Qr5z_qFWp_sLfTFPA@mail.gmail.com>
In-Reply-To: <CAJFAV8z-yyLsScuWJhoZp-1Jz+3r1+zV2Qr5z_qFWp_sLfTFPA@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LV8PR11MB8486:EE_
x-ms-office365-filtering-correlation-id: 101d08e6-3bf9-40d4-ba99-08df12574ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: UzfcbdFJbq+r6n5XDUzPNRW7YCsdJ2Vsfdu2iTU6LLguu5oLp8AWveYdfT6e2Ca2I7irJGaBgAoMxwGRH2hnZP6z7fXmpqFWWszuIcfRAO3rxq/MMWHsy15i8hKm20uv6F+eVFw4xntxI8XgYIZ3Wl3EnRdyvMmcVk4BJd6KGcVGSSDpVU7H/X0jwhOY9m1YZJS/3QOfv6shCQr6btizIBJi7107yz23jKeGdDU2yTkzvzfknMf4OnKBwFJdvR3a6WyXnyRVeiG89tkCZjCFl/j0vsZ068WuoMLQqt/wr8rFtJbJjVWLaAktlS975J6OrkhB/NdgkWKaaqZZaHFAijN2dQQRsm7AstqoeZ8F3IHx7GVOuLrdk8l/b2dXkJ1irWorbauVC+gtmG0d4wyX6FUFCOriWsFvyMBtkkbaBKpDsw5xDkBVD5r1JJnTTzJ0LxhcQ96PwclvpBefelybfWcil7elaxzFEhLilAn6+kN05HTHNvd4TSrM6pAO6MtzTzMEC5elWzmQli6Dk7XRj0SXKltdEizfioVafojRmtcxUp5GJbIm5uiOUx8W2tDXnCM9IPlT1sWKlM/GcKVvBojzzzSSQMfmXT7OqzzChIC1QeyGIGT8/UrYXnQZfWoM5nOMsjSU684qL7l+AItZvLC/xOCmyfN9hDTR4sV0B5uR2//uegMc+zkukLTM4Nc807lTso2DIBA+4K+sSB65dsY++IbX2UxYOJAIHtftIYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVoaWhWbFJhZEdNR0ZmUmlXcWdHamlSckN1cXF5d0o4a0x1Q2ZqVWR5NFdk?=
 =?utf-8?B?WWtOUzJNcW8wZHhuelpmRmp6NlBtRzE1VWdudFd1YXFyZ1lBNVVnTUdaVVJx?=
 =?utf-8?B?TEQ2V1VGZVFOSlBqRzVqSk1SQ3JuMC9QUWlXdEJuWERtbTVxVzJIdjloaHVJ?=
 =?utf-8?B?S0VMUThqK2pXaHRGK21JK3J5aTZTUkNwSXdGaWtoQURSYWxscURpNjlGV2d1?=
 =?utf-8?B?bGZ1cWtGZ2krVkNaeFpremdVanNuRC9Xc2FURkJ3dW01b0t1VUMzbEtDalps?=
 =?utf-8?B?OHBsNWdQcjZScVN6dktsVnVRQzc4T0dYMGxUK0E2NFVMbVZiZGhDajQ2dTVw?=
 =?utf-8?B?UTJXU1ZYeWVsdHVtem9aLy9JOWd1VHF6WXpiVDVhOUdTYmJFZWlwM29qR0N5?=
 =?utf-8?B?UWNqRm1Xd3JZeVBqOUZSbVp2Y1FLbXcvb1FEWU52YjVHTGNQY3lJcFVvRlFm?=
 =?utf-8?B?QmR5U3ZWMXM4Mm1qaDhCbkFEOFRPZUQzQzA5YklieDlxVWNSNTVHSEY0ZkdD?=
 =?utf-8?B?Zkc2Ui9vOTdGeTFWK0V4bUtHWFBTZFNqbkIyd0w1K3VPOWhYMnBFcm1OV2Nr?=
 =?utf-8?B?L2VPNTVlQnJsWmk3L0JTM1VlQnJIQVIxRVVsRHJOTVNkcFI5dVdLeHRLSkFr?=
 =?utf-8?B?ZjBscWtyL2szcVNrZnRaU2x5MEJHUmlGaHFCdmNkMWU3L3dDc1ptVk5BTWRu?=
 =?utf-8?B?dE5PZGZaRXQ0NXZUWURxT2NhajRjaDRiTUVzemlacEd5cnQwSG11cG02bThj?=
 =?utf-8?B?c0pPUllNTjU4YnB3bGZYOFFheitidGlDbnB6YUZYTE5hQ3duL2pHa2ZROHhq?=
 =?utf-8?B?MjNHTHlieUtLTE50SzFTeWVROWNaUzFHQ3NXMmg3VlluVEdUUWtNd1VXeHhp?=
 =?utf-8?B?NUhOU0N0SVhwUmlKZjNoNy9qa0t3MktiRmtYQUFCM2VObHFoRXkwdzh4OE1v?=
 =?utf-8?B?UjRaUVRJanFpSnplMGhaNHhsSTFzYXhnK1pYblhZSzFZd2JLYUJwN3Z4VFZO?=
 =?utf-8?B?YUtEUlJJWFBMWXdjU1hIaG9ZWkFza3JVOXltUmRnOUQwMElOSFJkc1Y0ZlNZ?=
 =?utf-8?B?V2dDRjBwT1ByMnhLL044MkNRNGRoZzVLRVF2cXNLTWJyRXROT3FpdTd3UEhm?=
 =?utf-8?B?T2ZhU2NyaE8rZW9qajJTcmpyOXZneEF0SlZSN0RTeE5keDBrYlBHa3plckQy?=
 =?utf-8?B?VXlTakd0ZzB3M3dPY1BHOTZaaDFmd2R5SHl1UnE0RG5ya0t1V1U3WEFjVVhX?=
 =?utf-8?B?L0FyV2JxWnNhTnM4emFLZ2JmTFhzK2V3VzNKNktPSVgzOTN0RnJEeExWSUNk?=
 =?utf-8?B?UCtEci8wV0UwcGxrTGpVeEFvenk1T1ZiRVJqT2VSSFZldlhVVnJCSjdKZlpm?=
 =?utf-8?B?cndCVEZFUnVTcU1kU0Jtc1BCM2dlNjkxOWdqNXNScXFjdXBjSGllR3NQdG01?=
 =?utf-8?B?UnpDNFZQdWF1SVNMY1F4RkJWdERacEhYb1BJRmhJMFJnUVhweE90S1c3b2g4?=
 =?utf-8?B?OE4wN09kdWRJTmNVbVNhVW5PN2VrRis2cTU0cGpMbGlHaXlhTWJncVpwTDFY?=
 =?utf-8?B?b1ZrMGZPbUtkK0t3L283N2FFbEU4bXdteFNzanY1bXFIS1crUUJUd2UrOTFB?=
 =?utf-8?B?b0tkcGdkK2NuVUFoWk8rRUt3aXZpUlNpTldTc1Zqa2h4NktsMmNIMHU5eWUw?=
 =?utf-8?B?aklHTGsxVHZHaytMYWtRSmZzT3ltUFNrZ2RIMXQvSmdUcTFUeFFZNWlkbXZi?=
 =?utf-8?B?MTRzNXV0TS9BOTB6ODBuNkQ4eHlaSEo0SDdLcVgzdkhMNFB4cXNOZmdXWlRZ?=
 =?utf-8?B?Z09mYnBtSHZEbFl3TENWcGR6TUc0dnFoWXJwNUwyWERmS2NYektGNFdFQnBh?=
 =?utf-8?B?Y0NxeGhlT0dLTGZzVmlBdXk4R1FudGJkcEwxNWtEZWhLaERLSFdlWEZ2eEht?=
 =?utf-8?B?UHdvSDNZbFpKR2N4RThRMzhSNU12ME9BNlZvRWREK04vZThDWkpENExxTlVI?=
 =?utf-8?B?UFFVQzBVOXRjRkU3THo2SGpYZ3gxVUIzelpCRzhCcWVrdlVUYzhNNzBhRlVm?=
 =?utf-8?B?bldOamI0OWd4Q29nUWRla2ZRR2V5SlorYzNqNDVKNTlLWUx0OTlpdUFJL3VF?=
 =?utf-8?B?TFZ1SmtNNmJNb3Z4YXY5MDA4cGhpMjF4TWo5N0s1elEvR0xBRkZjRW9kTUpM?=
 =?utf-8?B?UVdNeHRPazQ2WkdOak83WWFIMk9xSTEwbWJHSTlyK2g3LzlFSjZmZ0RBS1Zk?=
 =?utf-8?B?WkJiaXdGSDNOaEpkRWsyQlhHdUJjL3k5U1cwbU5LcHJHSHhSNThadTkxbjlO?=
 =?utf-8?B?QUVwTGh1eGh0aHh3cS9LOGhPZlhwa3VCL0gxSEY3MnByaG1JVk9mQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4l8uvhctZqqOyHwHat363qS35lzRzEx/VgRxF6I8l2Wq3OXHBIj4oLMlgIPYHHaysKB+9cV1ZmjHOIvBNA4TEvVwflmperb5uO2DuTt2pDCCSkJq0zsZJ8tQrvQdaD/LEveCov+6DVRoTknitIbFBn58SHRJbPRm3TakMoftqccil64tLf4rCVgqcZ7R4vh+7Y0CmAIK8wJjk4oYorBRSbd0wqtJkUbjhwWdZogt5fPrnmNtv4yKsBH8K3uX33rIGcJrNhBAXvcA6zQbdUcb+aMEc6HKULwLF8Lx+gX5a/hkXU5Rpv2gNRKm/vM9YtGb5xezONo9g8bGcj4RL4tD7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d08e6-3bf9-40d4-ba99-08df12574ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 11:57:04.9616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/pRxisYZwn9cbXeDx7dbbpBkp0PfuvkjQXR4/kNx1EkxDPmYiQXsZ+86PJ45iVqHnqSuJtkk/VnDVhhIltZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDEvNF0gbmV0L2lhdmY6IGZpeCBNQUMgYWRkcmVzc2Vz
IGxlYWsgb24gcmVzZXQNCj4gDQo+IE9uIE1vbiwgMTQgU2VwdCAyMDI2IGF0IDEyOjE2LCBMb2Z0
dXMsIENpYXJhIDxjaWFyYS5sb2Z0dXNAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IEBAIC0zMTIz
LDcgKzMxMTYsNiBAQCBpYXZmX2Rldl9pbml0KHN0cnVjdCBydGVfZXRoX2RldiAqZXRoX2RldikN
Cj4gPiA+ICAgICAgIHJ0ZV9ldGhlcl9hZGRyX2NvcHkoKHN0cnVjdCBydGVfZXRoZXJfYWRkciAq
KWh3LT5tYWMuYWRkciwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAmZXRoX2Rldi0+ZGF0
YS0+bWFjX2FkZHJzWzBdKTsNCj4gPiA+DQo+ID4gPiAtDQo+ID4NCj4gPiBOaXQ6IHN0cmF5IGxp
bmUgcmVtb3ZhbC4gVGhlIHJlc3QgTEdUTS4NCj4gDQo+IEkgZGlkIHRoaXMgb24gcHVycG9zZS4N
Cj4gDQo+IEkgd2FzIHJldmlld2luZyBhY2Nlc3NlcyB0byBldGhfZGV2LT5kYXRhLT5tYWNfYWRk
cnMgYW5kIG5vdGljZWQgdGhpcw0KPiBzdHJheSBkb3VibGUgbGluZS4NCj4gTm8gc3Ryb25nIG9w
aW5pb24sIGJ1dCBJIHdvdWxkIHByZWZlciBpdCBpcyByZW1vdmVkLg0KDQpObyBvYmplY3Rpb25z
IHRvIHRoZSByZW1vdmFsIG9uIG15IGVuZC4gVGhhbmtzIGZvciBjbGFyaWZ5aW5nLg0KDQo+IA0K
PiA+IEFja2VkLWJ5OiBDaWFyYSBMb2Z0dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+DQo+IA0K
PiBUaGFua3MuDQo+IA0KPiANCj4gLS0NCj4gRGF2aWQgTWFyY2hhbmQNCg0K
