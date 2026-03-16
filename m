Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A47F4644E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 074664025E;
	Mon, 16 Mar 2026 12:10:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5870C400D5;
 Mon, 16 Mar 2026 12:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773659450; x=1805195450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q5jW7Hfb06EfPndIGfgHDo4nTV/ByI9ZaP1nxQyeb2Q=;
 b=P+T6O/viVhxqWrMpaIzpSW7xO7X02AwqMpLhG9hsD2+/aZ6mgC5In/Ju
 foRkJKWu4qlI6pTIvroy+fvOmtYjV7VvoHkQnBgVAn0sLCU9gezFqAyoA
 rTuEHbFt2ip99jW+BdIqsd61GHjUqR36VrUp5rCqkGP/5m4Zw2v5fArTv
 AonCgNahFew7KaC1WPFpgp+U03WV4n0A+LTNoUHDG/zuC88UALEQmAW67
 22RqCV6AUyaQ2y5co7AjoN8WVyUBWN1z9mVMAs5ZXBEXeZ4aLShMJ17l0
 Cp5MHKppfjT4BzBCXJ5ZPPKCW7Lt+x2Fq1js1Wkcoz0S+8Uwrqy2IULEY g==;
X-CSE-ConnectionGUID: Tes4AphmRMGk+KPQTDHI/w==
X-CSE-MsgGUID: 0acpvJ/VRQ+wuYiw77ryIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="84988145"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="84988145"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:10:48 -0700
X-CSE-ConnectionGUID: TMq6k7ZCSnuGpcS+s6I+vQ==
X-CSE-MsgGUID: QFlwO89CSXCCgqj67Wd4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="259783824"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:10:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:10:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:10:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajUlYAp4AW6SqAn5P6AivhQ5bW6ppXQrlc4thwABFcSjLdmox1HsRdoT1tO396olmRtgLQevK41ChSKrvFDFzAtRy4EkoIm1HO9LBgW0Kf6KwBeBGd9VzRxnvgDXO8jbKwLWJu+JIsRHLCkte7yWrHna8WEufW0RiIUDRoE5srOiXI0307lis/VFK5augfZOoQS3jZOq1u40JAQIPIkO/1LM/waMVzTDE6Wi8r7URlf7seJx9mecjqddjvl5NGf4aUjL2Hlz+VE7mBkxOb2Y8qYp8N+yA7l8GiyoEAhsNDm7sLFquWeQwodn/YYVWf/4vX3KR0mb7YFVCdskg4MN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5jW7Hfb06EfPndIGfgHDo4nTV/ByI9ZaP1nxQyeb2Q=;
 b=NCHMISgznK3mB+XXhkJJEWddm30z9dSvTxEgMhlx7vcNvfpHJwJRRvKLmTyFnlzhujrHdniB7mhhRgsWE0fAYkOChitHloymmVp7US9F1x0XO18vUCUzCoseciPjGhAJ3zek2YMFJfuLm6PJponA8MlPV/op79Grs1t2xXy1XUox77ul+CHpbvYvMmJi8p4y95VMAhl6VTxw6E/XXzqHL91MCfhBTCjRpi5Aj05SWWvnfYzCbR4ersFPBUCC6hqc2jxcXsQ6p4FyjJVNmejbUgzFri9oVyevHhNjvOuwqI0wbATrigWrbQ1GZ7pCoTSF+KWm73pyXDibgpiJtYHwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA3PR11MB8917.namprd11.prod.outlook.com (2603:10b6:208:57d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:10:43 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 11:10:43 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "alex.chapman@arm.com"
 <alex.chapman@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix rss simple_xor hash function
Thread-Topic: [PATCH] net/ice: fix rss simple_xor hash function
Thread-Index: AQHcr20qcYFABQ8yxUqOS6BukBTdNrWl/XuAgAAN9fCAAAskgIAAGyUAgArX+dA=
Date: Mon, 16 Mar 2026 11:10:42 +0000
Message-ID: <CY5PR11MB6116F6383D3382102FFFFF5FE440A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
 <CY5PR11MB61167F0FA868B64B355F1670E479A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <c6739905-2f99-46a1-81b5-d97464cb01e8@intel.com>
 <50717218-f925-44f4-aea0-310f67935025@intel.com>
In-Reply-To: <50717218-f925-44f4-aea0-310f67935025@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA3PR11MB8917:EE_
x-ms-office365-filtering-correlation-id: f3948cbb-0bfd-4c93-9b6b-08de834caa39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: qnDMyi43cJN/UJmHcrbyT2uioPvT8YCNrQlFt9gDqCD5XIzM8zxgZXQlF+KYC9mqaHO819VBDQ81KRLA8LxNEgULoD00ZCYKBnVg4UUcDpV2METzHO/b7YT6Dyei82MhV40xu147wvmpqWV3K8PLe2wk2I3W7gJyS33cKhwOnA3ZEtzNYeHq3h2DC9L3BoPXWu+dsQUOySK5RQeAHHtE6h3RAVW93hOIwFD8wcLrgN0jC//8yajd+WVEF5r6fMIVvV3Q/mXNKZGmeQ6YvZEOEV01gSNL45SxktG797YhRLx331w/L/GFAHVn+l69JO6E88kTRE018E8NajtksXChpBmc5agG3mNpIxuHnjef4DdW7DmgCMQJV3qMeradeZ/7Xc0wvUugj9t95zbWysVRA/a2lGMX5URO7jD/rn4nxALL5o30BS/tHYgurATlXqu891PPx0ADleg0VXePx5mK+zp/8FnMKT4DXgN8p0s8w8Qp+j/zrHueb/ZTwIYBlcM/7AeZ1RYh5orAk/xQEmWva5oa7JQkLX6cRHvct0TCCoHN+cVPoK43Znor2vbPXVoahFTK5z7K/fUknW/IkuqrETb1LPppwqR/hOfkffdbwVli7DbTeOEdTxurc5wwbN5ktyqHpc7p9xU47cHwzKJbWkPV51z7JzI9uqXBj6sb9xh0gpq7nrPTTJQL3LVmCfrCMChjW59ClnRRbrVet9k/fSHg6wtbISIQscumiCEQJtOYwmzAl73G1Y3v/aahBVWAzF1bSDjQN8Ky5QBM3QOO7/erCYoyR4kyGcV6lVw0KnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K01RMU91cHFXNmdLRmJxZDVoOWxRSDQ2ZkxkRWJmVVJKZVFnSHgyZDVNR0N6?=
 =?utf-8?B?SnZGV3N6MmZTd0w4RysxUE1iNktiNWsxdDZqMFlJclJvZVdTeU41Yzc4Sjhz?=
 =?utf-8?B?VE9Oc3M0UTdxaXk5NWNjNUQ1elJ1U2taNDQ4aWQ3d0FwVFA3L09pM0ZOdkN1?=
 =?utf-8?B?aXg4WTJRM2JPSHFuUlFqV1hnM0xXTVVjVXNoUHpRM2NNYWRueFMwQmZaK0VP?=
 =?utf-8?B?UUw4ajZMRGVOZzFncHpoai81M2lnbmd2R09zM2o2UVRVS055OTFpenhGU3Bs?=
 =?utf-8?B?dGtYelEvajltcDlXKzczeS8xYWxvVWU3TTVXeGhPSWpHejVnMld5VnpmWjAz?=
 =?utf-8?B?b2RyN28veUMxR3JnbC9ZZjdhLy9MTGhqTjZ5K2JYLzlQclJpRmVGQmcwVGYz?=
 =?utf-8?B?aGVxV3Bka3MvQW5JVWptZllwNlhCb2xIWStjWmxSelNPRUpSc3NnZmtyMHc3?=
 =?utf-8?B?K0haLzZQMDJuSjRzRFF0ekJmTTV0ZExqL0FMdUpydm1pYW9ycTF1SVlnWXJL?=
 =?utf-8?B?anRKbkkybExPWHlyNzBMRE9IamdPN245UUhxM0ZGWTUxZk4xWFRwTmkwZkx6?=
 =?utf-8?B?ZkhZYllOR1FlV3R3dFNkaFB4UUdPcmd1TnhTQkcxd0JyaG1IRkdKZ2k2bERL?=
 =?utf-8?B?UkFFV1lyUEdxMUhMbVYyTWVRbTZpdE8wRlVjajBOZVZsUVo3WVpoNng0ZmhE?=
 =?utf-8?B?ejgybWRZVjFjc05vc2dwR013NHVRbzMyMnkvY2dyMzBEaWp0akJFbStzeldM?=
 =?utf-8?B?TXcyZEh3Sm1MRkM1RGVrNzN5Rkl1YkhwOUxUaWZ5YTIvWGU3bnk4VWVYMlk1?=
 =?utf-8?B?bmFST0JBYmhzVXdodHMrbHJvRnhsQW1uK0puSVFiM00wMGhDOEhmSjhnZlN3?=
 =?utf-8?B?OHJVdHFOWkdsSXRaYy90VVV3aFdxaFlvU3ZRNkVyNWhKVWszbzh5SzJ1TmVl?=
 =?utf-8?B?RnhSeUQzRzRsbUNhTksxUVoxc3dXODRXV2Q1Nyt4RW9VbngzUXVsc1BBYUp4?=
 =?utf-8?B?aTV1TlR5YUlKVHlpS0VRelZibEZBZGxtaklCeUNhdVdkcVR6WjVJNDZzeE44?=
 =?utf-8?B?bmp1bEh4WjVTRmZNZmpka1ZtdS9uYWZuMnpQcFRlVWZMd3pQTUVsSGM0NTlI?=
 =?utf-8?B?TG5GKzBkYkxMQk5RZ2dmQ0JaYmw3OVo1Zmx3SWVJUGExcnRVYXhjNVF1eW5m?=
 =?utf-8?B?ZzVaajRKZFpRM1dMcVRYdEx5VG9HdXV5ZWJ5ZlA0TzEvZWtYTVZPcDJPN2py?=
 =?utf-8?B?QzdvdUt5T0ZiZ1gvUnl1SWErNFRSWkdGRW5hWVQzTi92d0lGOHdUcnMxdE1J?=
 =?utf-8?B?TmZ3RkFTZzBxUVZpNDdlanQzaDdyYy9IQjgrTlMzamxtTi8vQlVxa0RKS1pG?=
 =?utf-8?B?SFRlVDJncUZuZ0ZWVDVENitBZjJaRHNUVThYeDZWSEt3bkZnWmxOMDV1UmxY?=
 =?utf-8?B?KzBuakFTUytGTlh5TnZROVlsNlFyQzhFSGRueTdaTEMrb3J2bk1mYVAvWlA2?=
 =?utf-8?B?V0FOQVI1Z2NIV3Q3ZDdxeWRGbHRmZnBCTmhzQldiN0pURjBRMktzenMyL05p?=
 =?utf-8?B?NHhQL2JJRWMrRHYzRmVXWXhGdEtUaHc5a3hkeUlCWjJiUWZJVVFGQ0U5Nzk3?=
 =?utf-8?B?U2xOQnE1Q09nUE4ySk5vaDFKTlE0b3RnMGgwU1BaZnVhMDlDTTdEL1NEY3Fu?=
 =?utf-8?B?V3d3Mnh4QU55TkRvWDdjaG5Wc1F6Z3BrUkRsczdzMGpsNU1sNzd0RkZEbHY4?=
 =?utf-8?B?c096QTlWbU1FWnhocjZacUd2V3VQK1FieVFFTkcvUy8wRnY5T0hVY2JBN2ky?=
 =?utf-8?B?UVZZUGxtdTlCZVVqczFHZlA1ckRiQ0pRNmpZVDdrMFVBZnMwdkdVWEw5bjJE?=
 =?utf-8?B?aXdmc2VxRE5TYlRFaVNIOVJIQmkzb1dlQkFyZi9oNWlrL2txbk1kSjdHZ0l5?=
 =?utf-8?B?bzFMZHVkUWRQWTNnSXFnN3RIR0kzQmpvQ1cxRENWcnVBS3BrUk5qcld3VVFV?=
 =?utf-8?B?YjJURXI3NmZBMUNQNzlId1dBYlhzNkh4aXJQTUVTMWFPdGVzaDJDR3E1YkZU?=
 =?utf-8?B?Y2xvU2NtZktGdWw1OTMwdHZMZ2VHMkFxczFVV1ROM0pCUTAwa3k2RFduYUhn?=
 =?utf-8?B?cUZBUHJZSjV2RWd4SWc0SHFtREhoZ29Jbm1hcFRlZnJVNEZGejR5OGNzc1d3?=
 =?utf-8?B?cTNzZTVMWTdFcmtIK2hzT2hQaFhWMDk2WHI0Vm1RMmE4U3Nub08wU3pwY2xM?=
 =?utf-8?B?VElCYUZtSHlHUXJERWNFRU5pYXVZaTdGNFgyazlwazliY3JMRyt6S0xGNGhH?=
 =?utf-8?B?U1gwVHlHYzU4ZEN2VVFjYkJvR1hYWDBIZzdFNE9PWDJMaXN5MWZBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AHa9/CQyjkGUpGN2iCm3hOUGsyLfcsVBL/4Cx3bHGEBBKKsNvbDmDwGj1h0iIdbFRO0+Bcpx0s18M0ln61Xz1ZbcVA+yrA3aq8kcOQZX8Tm0jv9G4QouMiTlPqxnLNgOdWHxSi68fl+2OY3qmW8v15ssLvLQe5u8GCcvCyDl9ryO7RpErcILL/C9kaTtr07cr180ljkrUW0aczFshgKJ20AmM09WsrgEMauDww6FsBji+MhgB3jyvxkcYD16/4CQGPsQT9nU1OW9LxwmuU2bSMvdB5cP6cPT3CSjq1xqgTYnNjYia2ATXzlgKMxh8JCFsic9js+/149xatXcg++6SA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3948cbb-0bfd-4c93-9b6b-08de834caa39
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 11:10:42.9464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0+Dq2wikZkNFqqKTc4iw9uBdFR7O7SIFbIJQv0SXPxbgK3Gz2s2giHzmf4E1vKrezUA02XXW9ofGXG/qVY2zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8917
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNZWR2ZWRraW4sIFZsYWRpbWly
IDx2bGFkaW1pci5tZWR2ZWRraW5AaW50ZWwuY29tPg0KPiBTZW50OiAwOSBNYXJjaCAyMDI2IDE4
OjU2DQo+IFRvOiBCdXJha292LCBBbmF0b2x5IDxhbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tPjsg
TWFuZGFsLCBBbnVyYWcNCj4gPGFudXJhZy5tYW5kYWxAaW50ZWwuY29tPjsgZGV2QGRwZGsub3Jn
DQo+IENjOiBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+Ow0K
PiBhbGV4LmNoYXBtYW5AYXJtLmNvbTsgc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIG5ldC9pY2U6IGZpeCByc3Mgc2ltcGxlX3hvciBoYXNoIGZ1bmN0aW9uDQo+IA0KPiBI
aSwNCj4gDQo+IEluIHRoZSBnZW5lcmFsIGNhc2UsIGhhc2ggZnVuY3Rpb24gdHlwZSBpcyBub3Qg
bWVhbmluZ2Z1bCBmb3Igbm9uLWVtcHR5DQo+IHBhdHRlcm5zLCBiZWNhdXNlIGhhc2ggZnVuY3Rp
b24gdHlwZXMgYXJlIHBlciBWU0kgKG1lYW5pbmcsIHRoZXkgY2FuIG9ubHkgYmUNCj4gZ2xvYmFs
bHkgc2V0IHVwLCBub3QgcGVyIHBhdHRlcm4pLiBTbywgaWRlYWxseSwgd2UgZG8gbm90IHdhbnQg
dGhlIHVzZXIgdG8NCj4gc3BlY2lmeSBhIGhhc2ggZnVuY3Rpb24gd2hlbiB0aGV5IGFsc28gc3Bl
Y2lmeSBhIG5vbi1lbXB0eSBwYXR0ZXJuLg0KPiANCj4gSG93ZXZlciwgdGhlIElDRSBkcml2ZXIg
aXMgbm90IHZlcnkgd2VsbCBiZWhhdmVkIGluIHRoaXMgbWF0dGVyLCBhbmQgZG9lcyBub3QNCj4g
ZW5mb3JjZSBuZWl0aGVyIHRoZSAiaGFzaCBmdW5jdGlvbnMgYXJlIG9ubHkgc3VwcG9zZWQgdG8g
YmUgZ2xvYmFsbHkgZGVmaW5lZCINCj4gbGltaXRhdGlvbnMsIG5vciBkb2VzIGl0IGNoZWNrIGlm
IGEgdXNlciBzcGVjaWZpZWQgYSBkaWZmZXJlbnQgaGFzaCBmdW5jdGlvbiBmcm9tDQo+IHdoYXQg
dGhleSBjb25maWd1cmVkIGdsb2JhbGx5LiBUaGVyZWZvcmUsIEkgdGhpbmsgdGhlIHByb3BlciBm
aXggZm9yIHRoaXMgaXNzdWUNCj4gc2hvdWxkIGRvIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAtwqAg
aW50ZXJwcmV0ICJkZWZhdWx0IiBoYXNoIGZ1bmN0aW9uIGFzICJ3aGF0ZXZlciBpcyBjdXJyZW50
bHkgc2V0IHVwIg0KPiAtwqAgc3RvcmUgdGhlICJjdXJyZW50IiBoYXNoIGZ1bmN0aW9uIGdsb2Jh
bGx5IHNvbWV3aGVyZSAoaW4gVlNJIGNvbnRleHQpDQo+IC3CoCBmb3IgZW1wdHkgcGF0dGVybnMs
IG92ZXJ3cml0ZSB0aGUgc2V0dGluZw0KPiAtwqAgZm9yIG5vbi1lbXB0eSBwYXR0ZXJucywgZGlz
YWxsb3cgaGFzaCBmdW5jdGlvbiB0aGF0IGlzIG5vdCAiZGVmYXVsdCINCj4gb3IgZG9lcyBub3Qg
bWF0Y2ggY3VycmVudGx5IHNlbGVjdGVkIGdsb2JhbCBoYXNoIGZ1bmN0aW9uIHR5cGUNCj4gDQoN
CkhpIFZsYWRpbWlyLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMgYW5kIGRldGFpbGVk
IHJlcXVpcmVtZW50cy4NCkkgaW1wbGVtZW50ZWQgdGhlIHNhbWUuDQpIb3dldmVyLCBJIGFtIGZh
Y2luZyBhbiBlcnJvciB3aGVuIGVtcHR5IHBhdHRlcm5zIHdpdGggaGFzaCBmdW5jdGlvbiBpcyBi
ZWluZyBzZXQuDQpGb3Igc2ltcGxlX3hvciwgaXQgaXMgbm90IGNvbWluZyBidXQgZm9yIFRvZXBs
aXR6L1N5bW1ldHJpYyBUb2VwbGl0eiwgaXQgaXMgY29taW5nLg0KSSBjaGVja2VkIGluIERQREsg
MjUuMTEgYXMgd2VsbC4gSXQgc2VlbXMgZW1wdHkgcGF0dGVybnMgd2l0aCBzeW1tZXRyaWNfdG9l
cGxpdHogIGRvZSBub3Qgd29yayB0aGVyZSBhcyB3ZWxsLg0KDQpJdCBpcyBmYWlsaW5nIGluIGJl
bG93IGNoZWNrOg0KaWNlX2hhc2hfcGFyc2VfYWN0aW9uKCk6DQogICAgaWYgKGljZV9hbnlfaW52
YWxpZF9yc3NfdHlwZShyc3MtPmZ1bmMsIHJzc190eXBlLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhdHRlcm5fbWF0Y2hfaXRlbS0+aW5wdXRfc2V0X21hc2tfbykp
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBydGVfZmxvd19lcnJvcl9z
ZXQoZXJyb3IsIEVOT1RTVVAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUlRFX0ZMT1dfRVJST1JfVFlQRV9BQ1RJT04sDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWN0aW9uLCAiUlNTIHR5cGUgbm90IHN1cHBvcnRlZCIpOw0KSWYgSSBh
dm9pZCB0aGlzIGNoZWNrLCB0aGVuIGdldHRpbmc6IA0KSUNFX0RSSVZFUjogaWNlX2FkZF9yc3Nf
Y2ZnX3dyYXAoKTogYWRkIHJzcyBjZmcgZmFpbGVkDQoNClNjZW5hcmlvOg0KDQotPiBmbG93IGNy
ZWF0ZSAwIGluZ3Jlc3MgcGF0dGVybiBlbmQgYWN0aW9ucyByc3MgdHlwZXMgaXB2NC11ZHAgZW5k
IHF1ZXVlcyBlbmQgZnVuYyBzeW1tZXRyaWNfdG9lcGxpdHogIC8gZW5kDQpJQ0VfRFJJVkVSOiBp
Y2VfZmxvd19jcmVhdGUoKTogRmFpbGVkIHRvIGNyZWF0ZSBmbG93DQpwb3J0X2Zsb3dfY29tcGxh
aW4oKTogQ2F1Z2h0IFBNRCBlcnJvciB0eXBlIDEzIChzcGVjaWZpYyBwYXR0ZXJuIGl0ZW0pOiBj
YXVzZTogMHg3ZmZjYzNlOTNhYzgsIFVuc3VwcG9ydGVkIHBhdHRlcm46IEludmFsaWQgYXJndW1l
bnQNCg0KUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpBbnVyYWcgTQ0KDQo+IA0KPiBP
biAzLzkvMjAyNiAxMTo0OCBBTSwgQnVyYWtvdiwgQW5hdG9seSB3cm90ZToNCj4gPiBPbiAzLzkv
MjAyNiAxMjoxNyBQTSwgTWFuZGFsLCBBbnVyYWcgd3JvdGU6DQo+ID4+DQo+ID4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogQnVyYWtvdiwgQW5hdG9seSA8YW5hdG9s
eS5idXJha292QGludGVsLmNvbT4NCj4gPj4+IFNlbnQ6IDA5IE1hcmNoIDIwMjYgMTU6NDkNCj4g
Pj4+IFRvOiBNYW5kYWwsIEFudXJhZyA8YW51cmFnLm1hbmRhbEBpbnRlbC5jb20+OyBkZXZAZHBk
ay5vcmcNCj4gPj4+IENjOiBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2UucmljaGFyZHNvbkBpbnRl
bC5jb20+Ow0KPiA+Pj4gYWxleC5jaGFwbWFuQGFybS5jb207IHN0YWJsZUBkcGRrLm9yZw0KPiA+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbmV0L2ljZTogZml4IHJzcyBzaW1wbGVfeG9yIGhhc2gg
ZnVuY3Rpb24NCj4gPj4+DQo+ID4+PiBPbiAzLzkvMjAyNiAzOjMyIEFNLCBBbnVyYWcgTWFuZGFs
IHdyb3RlOg0KPiA+Pj4+IFJTUyBTaW1wbGUgWE9SIGhhc2ggZnVuY3Rpb24gaXMgc3VwcG9ydGVk
IGJ5IHRoZSBOSUMgYXMgcGVyDQo+ID4+Pj4gZGF0YXNoZWV0ICYgYWxzbyBpbiBJQ0UgTGludXgg
RXRoZXJuZXQga2VybmVsIGRyaXZlciBidXQgdGhlIHNhbWUNCj4gPj4+PiBpcyBub3QgZW5hYmxl
ZCBpbiBJQ0UgUE1EIGV2ZW4gdGhvdWdoIGNvZGUgc3VwcG9ydCBpcyBhbHJlYWR5IHByZXNlbnQu
DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSByZW1vdmluZyB0
aGUgc2ltcGxlX3hvciBjaGVjayAmDQo+ID4+Pj4gYWRkaW5nIHByb3BlciBlcnJvciBsb2cgZm9y
IGVtcHR5IGFyZ3VtZW50Lg0KPiA+Pj4+DQo+ID4+Pj4gQnVnemlsbGEgSUQ6IDE1MTgNCj4gPj4+
PiBGaXhlczogMGI5NTI3MTRlOWMxICgibmV0L2ljZTogcmVmYWN0b3IgUEYgaGFzaCBmbG93IikN
Cj4gPj4+PiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5
OiBBbnVyYWcgTWFuZGFsIDxhbnVyYWcubWFuZGFsQGludGVsLmNvbT4NCj4gPj4+PiAtLS0NCj4g
Pj4+DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+Pj4gwqDCoCBkcml2ZXJzL25ldC9pbnRlbC9pY2Uv
aWNlX2hhc2guYyB8IDkgKysrKy0tLS0tDQo+ID4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2VfaGFzaC5jDQo+ID4+Pj4gYi9kcml2ZXJzL25ldC9p
bnRlbC9pY2UvaWNlX2hhc2guYw0KPiA+Pj4+IGluZGV4IDc3ODI5ZTYwN2IuLmQ1N2I1ZWUwZTQg
MTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9oYXNoLmMNCj4g
Pj4+PiArKysgYi9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2hhc2guYw0KPiA+Pj4+IEBAIC0x
MTA5LDEyICsxMTA5LDExIEBAIGljZV9oYXNoX3BhcnNlX2FjdGlvbihzdHJ1Y3QNCj4gPj4+IGlj
ZV9wYXR0ZXJuX21hdGNoX2l0ZW0gKnBhdHRlcm5fbWF0Y2hfaXRlbSwNCj4gPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJzc190eXBlID0gcnNzLT50eXBlczsNCj4gPj4+Pg0KPiA+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQ2hlY2sgaGFzaCBmdW5jdGlvbiBh
bmQgc2F2ZSBpdCB0byByc3NfbWV0YS4gKi8NCj4gPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAocGF0dGVybl9tYXRjaF9pdGVtLT5wYXR0ZXJuX2xpc3QgIT0NCj4gPj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdHRlcm5fZW1wdHkgJiYgcnNzLT5mdW5jID09DQo+
ID4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVEVfRVRIX0hBU0hfRlVOQ1RJ
T05fU0lNUExFX1hPUikgew0KPiA+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJ0ZV9mbG93X2Vycm9yX3NldChlcnJvciwgRU5PVFNVUCwNCj4gPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAocGF0dGVybl9tYXRjaF9pdGVtLT5wYXR0ZXJuX2xpc3QgPT0N
Cj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdHRlcm5fZW1wdHkpIHsN
Cj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBydGVfZmxvd19l
cnJvcl9zZXQoZXJyb3IsIEVJTlZBTCwNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBSVEVfRkxPV19FUlJPUl9UWVBFX0FDVElPTiwNCj4gPj4+IGFj
dGlvbiwNCj4gPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk5v
dCBzdXBwb3J0ZWQgZmxvdyIpOw0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiSW52YWxpZCBlbXB0eSBhcmd1bWVudCIpOw0KPiA+Pj4NCj4gPj4+IEkgdGhp
bmsgdGhpcyBjaGFuZ2VzIGV4aXN0aW5nIHNlbWFudGljcyBhIGxpdHRsZSB0b28gZmFyLg0KPiA+
Pj4NCj4gPj4+IFRoZSBvcmlnaW5hbCBjb2RlIGRpc2FsbG93ZWQgc2ltcGxlIFhPUiBvbmx5IGZv
ciBjYXNlcyB3aGVyZSBwYXR0ZXJuDQo+ID4+PiB3YXNuJ3QgZW1wdHkgKGlmIGl0IHdhcywgd2Ug
YWxsb3dlZCBpdCAtIGkuZS4gaWYgaXQgd2FzIGEgZ2xvYmFsIFJTUw0KPiA+Pj4gY29uZmlndXJh
dGlvbikuIFRoZSBmaXggZGlzYWxsb3dzIGVtcHR5IHBhdHRlcm5zIGFsdG9nZXRoZXIsIHdoZXJl
YXMNCj4gPj4+IHdoYXQgaXQgc2hvdWxkJ3ZlIGRvbmUgaW5zdGVhZCBpcyByZW1vdmUgdGhpcyBj
aGVjaywgYW5kIGluc3RlYWQNCj4gPj4+IG1vZGlmeSB0aGUgc2Vjb25kIGNoZWNrIHRvIGxvb2sg
Zm9yIGVtcHR5IHBhdHRlcm5zIChiZWNhdXNlDQo+ID4+PiBvdGhlcndpc2Ugd2Ugd291bGQgZ28g
dGhyb3VnaCBmdXJ0aGVyIGNoZWNrcyBkb3duIHRoZSBsaW5lIGZvcg0KPiA+Pj4gbm9uLWVtcHR5
IHBhdHRlcm5zKS4NCj4gPj4+DQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
IGVsc2UgaWYgKHJzcy0+ZnVuYyA9PQ0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBSVEVfRVRIX0hBU0hfRlVOQ1RJT05fU0lNUExFX1hPUil7DQo+ID4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJzc19tZXRhLT5oYXNoX2Z1
bmN0aW9uID0NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gLS0NCj4gPj4+IFRoYW5rcywNCj4gPj4+IEFu
YXRvbHkNCj4gPj4NCj4gPj4gSGkgQW5hdG9seSwNCj4gPj4NCj4gPj4gVGhhbmsgeW91IGZvciB5
b3VyIGNvbW1lbnRzLg0KPiA+PiBJIHVuZGVyc3RhbmQgdGhlIGN1cnJlbnQgY2hhbmdlIGRpc2Fs
bG93cyBhbGwgZW1wdHkgcGF0dGVybnMNCj4gPj4gYWx0b2dldGhlciBhbmQgdGhhdCBzaG91bGQg
YmUgcmVjdGlmaWVkLg0KPiA+PiBNeSBkb3VidMKgIGlzIHNob3VsZCBiZSBhbGxvdyBib3RoIGVt
cHR5IGFuZCBub24gZW1wdHkgcGF0dGVybnMgdG8NCj4gPj4gYXBwbHkgZm9yIHNpbXBsZV94b3Ig
bGlrZSBzeW1tZXRyaWMgVG9lcGxpdHogPw0KPiA+DQo+ID4gVGhhdCdzIHdoYXQgeW91ciBwYXRj
aCBmaXhlcywgaXMgaXQgbm90PyBJdCBhbHJlYWR5IGFsbG93ZWQgZW1wdHkNCj4gPiBwYXR0ZXJu
cyB3aXRoIHNpbXBsZSB4b3IgKHRoZSBzZWNvbmQgYnJhbmNoIG9mIHRoZSBpZiBjb25kaXRpb24p
Lg0KPiA+DQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gQW51cmFnIE0NCj4gPj4NCj4gPg0KPiA+
DQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFZsYWRpbWlyDQoNCg==
