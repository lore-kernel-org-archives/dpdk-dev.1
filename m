Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DFAC88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A89540E3F;
	Mon, 14 Sep 2026 16:57:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2737440E42
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789397857; x=1820933857;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OEujWeaCWQ55S8C/SMnNx58kBMkuGAPHcVHYsmcoIFo=;
 b=FWl3CxZrcuLqz+SNPaD9l/QcFqxXUBGGWbj+erTscblaNfr0AwaTZII/
 /JbDsvEL4rhA9XCMYGzhvclDZvwcYU6iFoN8LWaKYrSoOhydwMjsvbS+n
 H9rrQcAzOkXKXdTuMYORcB4dClEvh1QRyAKFHVZvwINbtIG4pv72wzir2
 R+QqR9HbaPtfTJiom+OVMskyYS4uYzEYylfvybhVnrh/jCzQ6ecjDuq6V
 2foGW8AWSLapCsTnnGoOfy5OcIvI5YEIb1s0Lu3U6Hw/EZkcc1Fe5Te+T
 1Mg8p+6UY6Af4E6CyaCzQ80s4WXU3cVUomo5Ov3M09QHvl9f16IK5AGOg g==;
X-CSE-ConnectionGUID: GovUQcAPQQuFPD8rHYXByg==
X-CSE-MsgGUID: AWb1QtDoSA2i9OJ6drLyMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115286136"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="115286136"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:57:36 -0700
X-CSE-ConnectionGUID: oXfViGiYTz6qHkJy7sXUFA==
X-CSE-MsgGUID: SiTVKLymRg23BcpKXVvOrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="296150146"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:57:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:57:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:57:35 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roNI6ikrYamioKBpxCAp14pWMk8ZymZosDscrA/pJU4VVuQ2EYt9BXaB7pQd8U7IIa63fdUqOE5sxLy3la557RMXzBIjmqT+fC+IJ9B1cuOzWV6peHSGseQFgGjN/GCTUkIuBrLejnkqQ8uAriuimlSqj8QNwQ1fWKhjcZcV0eGjjon0Rx5D6bRCg8e/uAcC9mKUGEujVxZqczkqLgytrJ+1HmSiTqXYTRZdQkILrlnZHnJK9Bx0YJnGCbALkq5q5B18+croIXsPd03qWhEwX2ddER3EiE6xIwYswGrAxUVbWhQI4lfG+X358gVSVZWJ5/Ohx4BVlf4O32etsd5ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEujWeaCWQ55S8C/SMnNx58kBMkuGAPHcVHYsmcoIFo=;
 b=uMfWqgNJEREhrKXZA4yFlK5uzUosyy24PzD50X3n/Oux5ne/ALZE/shUeSMiMC4bjOhDkYIE77ggqWQ04uvM9G+rrlmHj/Us2yjJ1lGYKQtL3OBApvYTywTxS3MnVNYE0zqHp9IrEhwOzq4A9ScsmZwbwJ3TSGPOVxRCC5gmV7Ogeu6FoQTg3uk7i0Ms7njpZ59CxloFtRiM8f5DJG+KJvCtGrkbzAoN0soTeNr8AJMjAiSNFUTpUlyWNAELGlUn4SpJnpOzErnwzvDMYAhckXpFkyWXkP9E8baWPb4r6CISfM38X3eNYFEVYbA+EVIWl7hw1OoZrYSN74ASUVRYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 14:57:30 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:57:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 11/13] net/intel: add common vector Tx fns with context
 handling
Thread-Topic: [PATCH 11/13] net/intel: add common vector Tx fns with context
 handling
Thread-Index: AQHdQQa9AVoWQqrdkEi4UrIDGvpN/LbOMKvQ
Date: Mon, 14 Sep 2026 14:57:30 +0000
Message-ID: <IA4PR11MB92786BFC0661D13019CD8D898EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170408.361088-1-bruce.richardson@intel.com>
In-Reply-To: <20260903170408.361088-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA3PR11MB7980:EE_
x-ms-office365-filtering-correlation-id: fdd4359f-d508-4ea6-9014-08df12708006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|4143699003|6133799003|10067099003|18002099003|11063799006|56012099006|22082099003;
x-microsoft-antispam-message-info: w0gFGWIHqibanaLshvzRAFV/uvCCyOU+rJ0eiWnpliRt4USWF+/laU/fwnoZYlD3g7qd+W36ls9dyS10xNnZbnaYE3vrUBuUzAT/EOKRwomTdZyWKw+xJYFpp5G/uYcNTqp465/SkJ2kRpqDXGrYJCZrV1veTJnLwVYZPkUxq9e1/o8fD0iX/ZDcb6ay2rr7uu5eja+yjNcaJwoeuMzVyLwc5gRtxtNqvTbqJUQWfCks3qqcnp7Gwxl+k/O75GzR1iGNp3q7uklqQ2bycFd6FCNw9wBlGxdKbSIX6DKfNwDUUVrZ1S+zFU/smgVLWimDbf4nivTOSHe/nbGi3cseXsv076IOqiqzjoRtDTeejWC7M6AbX+3BovT8QShViDAfFV6mtRT6VKRV3dmeJAc5Uunzih8ud9/CevikVjo/spKflRm+qGDgLASNLS7hOVOPjdk6OmCkiqUSP5p/fMHvI1XG/sjhb1H3TMua/PYhNbea/u3pzNHG4qIcr1LtjnkcL8SbojEbzkHBxt3M1qmoLlYRHbGEd15aWLXpSfA/UJLWWplI161ihnI0jI2koQv25JbnIOqoV8mTC6ivcsy8/Jm5EY3u+irtusDAReKKuPzi9cTyhiCpk2QsZ0fgoMUaDPQvC2PUgroZczvU8I2MRCZPgJsRK255bciMQlPt58wNu8V8K1pE9SlwsH5MpIg6cLndlJF63PiYnk2c3tfuy/9eQ+4TEwHI45p5qMDrMYk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(4143699003)(6133799003)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVh3UytPSjFXNkhKWmdpMGhWaUR4cUg1eDdMZk5rSEVIWVF3dXBNU1BaUUdz?=
 =?utf-8?B?MjhjS3MyekZxRGcyTW16SUtuR2NnNnYyTjBMemJJZ1JBcXc4UzgrQWJnamRD?=
 =?utf-8?B?OUVvL1dRWGxpbUlnSXlscDR2T2dUSFpBeTVMSWc0Um5tMHNoNGJnTndhTTlt?=
 =?utf-8?B?TG5uOHg2MmdnZ053dFhyVW9RQTBYRjA2bkU4RjZybUVNL2pFTWJINXp4amFn?=
 =?utf-8?B?NzlzY3dDbVlqbklKV1hqNklDMVZ4bllrMXh5N2NXbjBBWjhxb1AxZ2FZYU9E?=
 =?utf-8?B?dmFIc255a2hYR3R4bzltSFhTbUxEWFZxbWtiRnprUGRjem5DVVZRTXR5bkRX?=
 =?utf-8?B?UjRDSmMwNFpwNEtkbnB4cmo4MEIwVlorRm1GemxnVVA5dExlTStjTGZFTSt1?=
 =?utf-8?B?Uy9WV05TVG5hVjdzSmpGZUFRQ2Y1anU1NHpYbWx0QjBFT2FIMUNXbEpubXg1?=
 =?utf-8?B?SzhZSzh6Qm1JQnpobGh1Tlo0Q3dSblU2cHN6c0N2MW1qRlI3TG9PYXNENllv?=
 =?utf-8?B?WGd3U3JrWG50N3pFWDBpSzg3R3pGRktlR2Rtb3FQL1hnb2NKTWtRVnd0c0lN?=
 =?utf-8?B?aGFncVRTYTJScWFKS09JT2x5ZUZ3QmZvdm55bWp5VVpxL0hycCtNa3Fvb25t?=
 =?utf-8?B?RTVUa2NMa1BPL1F5T0tLdzFLU0dDOVVUUktkQjFlWGxZbEhNZU5MUytmZWFO?=
 =?utf-8?B?MzY4SFMzazBLWFc1WjI1cWFkT0dCcUJQUzBtTWZCM1dhejlpQ3BMR3J1enlp?=
 =?utf-8?B?MFZFc1pXcDVLVHdJdE85T1pFV3lnKzdmQlNNSCtxbzJRUlA5Nis0bmZHMjRU?=
 =?utf-8?B?M280enhjMnNlUVpNdDhIN1VESE1iMFJyVktHTnQ4aWtBdVdQNzRNTU0zSHNO?=
 =?utf-8?B?SGVPeXVrTUIwMmxReEdqTGxDdHN1SmhuUkJvOHBFR3c5YjNvby9aWXJGbEpm?=
 =?utf-8?B?Z0NBYXcwbFVLNDFMOEV2T3paMlNKNU5hRi9DdGQvUXZwam1QSkF5bk9CMHJp?=
 =?utf-8?B?bllOTS9qajhnUHprV1VjQmhVeG9GamRCWTV2eEVueEtBZHNTN1ZsbmJYYU8w?=
 =?utf-8?B?SlY1QUJ0dTR3YzdIZlo1dlNndENrZHdFZitBS1ZxYjBHS3B4NWRHcHBUemZy?=
 =?utf-8?B?dGN1VmRpODhzUTRJUmw5enhPUFlWNjlwalpQeXBJUEU5UGkvNVVlZ1J3NlRq?=
 =?utf-8?B?U1N0R0ZQZkZ3UUtjRnAwUFRCZUtJbWtTZ3o3UHl6Yk5pK2J5OFBBRGhab2dU?=
 =?utf-8?B?OXFaOU1nTlFHbFVGenRqN0wrNEhvRkx2REhaL280OWtjUEtieDdrVVhnbWE3?=
 =?utf-8?B?WWJTd3ZEc1llblF0V3h2M0JJRVVRT2N2MTVVWk5UQUJYZTU2NGJaQ1Bodnl3?=
 =?utf-8?B?VXo3UktXekRLS3M5WnErcmNuS2lKOGFENlFQY3hyZUJEV2VBcFZ1M2RoZlBT?=
 =?utf-8?B?TjRXSU1lN0I0Y0JnelpteFBNNE5JN0FzMkw4SkJadU55RVVlczVlMjFnQld1?=
 =?utf-8?B?Q3pGdWhXWEFHbE1wUWZiL2E2QWdhanprckJOeGpGQ1FTTHVjc3MrY2xjMFl2?=
 =?utf-8?B?ZjhIY29ObC9yV1pXZk1hU3BWdnZuclVocjBoc0kxQVNtZ1VuNnF4R1FyNzkr?=
 =?utf-8?B?eWhhM2ZsNjFTdnUwc09wcWhOYUxRTElkVHNETmYzRDUzSlVDVDB0ZXFTMTNX?=
 =?utf-8?B?eWxGZTBBS1dIN3RZOXZCRmZGWmtIK3BLRDdnd0JKRGhETEsxWXlwZDcyNEIw?=
 =?utf-8?B?Rm9mMWdlbDVZUUQ5NjV2WnYrWFBGTHpocGd6dTA2OVFnN0JCWmFheUNRc0Nm?=
 =?utf-8?B?MVh2VkE4cGx3OWZONGRpUUtxODlteUl0VjE1UzZTN2RxNEZwMmY4cjkxVzZx?=
 =?utf-8?B?dCtRd0JHRkpKRnhXRDkxWFlnUktxL2xwU05RYXRRTlk3YUs0RGVKS0lkanBs?=
 =?utf-8?B?anFDNi92b0ttdkRKc1lQd05OcDRWN0VVd0t6Q2FYWHVNWHNudkVaMU5VanJz?=
 =?utf-8?B?dXoxQzJDd3RkdXBORlFNaGdsMDBMWXMzR2loaVV2TFFpdjJjUTRRdmJYRXBi?=
 =?utf-8?B?YXFTd1lqcG1xc3IrTm5uTDFpbkswMS9DT1lmY0R5Mm9YNU9PSExuY05EV2V3?=
 =?utf-8?B?MkZ5MWhjSi9yVVhxa0o0UUt4czFNelpYOFEwUzFOR3pWR2xWVmRmUDRqTW83?=
 =?utf-8?B?by9LWkhud01QTTl1ZVhYZysxNWJncGk2eG5qNElJUkVQbTRmL2p3ZDdYRThU?=
 =?utf-8?B?OFBhNmtselZHeG1ITjhLUzlKUEI4MjZ5WFl4VFFwTXFWeTB2VWIyWWZ6RUdj?=
 =?utf-8?B?VGt6dTljUkhPNlZic1VQQ28ycW5vc1cwcC9zREdLMWgyV3VYVHZ3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5AwLIfQAO+dxf8GH1d8gKl6iTwwkh0XCczASsNvFXn5u+h0uXX5zu+AaaJnmEyaF1PIDlKxXGq9JGx6F/KX3L3EVzh9kjmN1liy+fKWqYbGgg+2mBhYnnKvRdFxAvz/XZmOqu/ltI4AZyq3Xv5j6aizIilImrNXCmcRhPhAXpFZ96PDAfIncdIrSvPz0i/LuXJqWBfMThbH7xfKZnMaz5sg14mvIcxqEoibLOcjgsP1/RtGe/vCvxURP+PzgnqtpbHVopAPdcaXF1mMm1hgEpc0pvtkoQkERAs+UGPvI9cgG1NU7s+SrVi76juOu5y2ne77QwU3w448XZ8j5xN61ZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4359f-d508-4ea6-9014-08df12708006
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:57:30.3248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHiMy2rWGXrryUNp7T2vouF+tGQBFBOaH5EeAQ1847HnP5EHri/TGE81YJjC9tCSmangatRAoKGIlRvA28Es+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTEvMTNdIG5ldC9pbnRlbDogYWRkIGNvbW1vbiB2ZWN0b3IgVHgg
Zm5zIHdpdGggY29udGV4dA0KPiBoYW5kbGluZw0KPiANCj4gVGhlIGlhdmYgdmVjdG9yIGRyaXZl
ciBoYXMgc3VwcG9ydCBmb3IgbW9yZSBUeCBvZmZsb2FkcyBiZWNhdXNlIGl0IGhhcw0KPiBUeCBm
dW5jdGlvbnMgd2hpY2ggaGFuZGxlIHRyYW5zbWl0IGNvbnRleHQgZGVzY3JpcHRvcnMuIE1vdmUg
dGhvc2UNCj4gY29udGV4dC1oYW5kbGluZyBmdW5jdGlvbnMgdG8gdGhlIGNvbW1vbiBmb2xkZXIg
Zm9yIHJldXNlIGJ5IG90aGVyDQo+IGRyaXZlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcnVj
ZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4NCg0KQWNrZWQtYnk6IENp
YXJhIExvZnR1cyA8Y2lhcmEubG9mdHVzQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMv
bmV0L2ludGVsL2NvbW1vbi90eF92ZWNfeDg2LmggICAgICAgICB8IDEzNiArKysrKysrKysrKysr
KysrKysNCj4gIGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9yeHR4X3ZlY19hdngyLmMgICB8
ICA3OCArLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92ZWNf
YXZ4NTEyLmMgfCAgODkgKy0tLS0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNl
cnRpb25zKCspLCAxNTYgZGVsZXRpb25zKC0pDQo+IA0KDQo=
