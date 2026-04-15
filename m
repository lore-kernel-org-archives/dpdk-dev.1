Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C4F9D0F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 01:24:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6889C402D5;
	Wed, 15 Apr 2026 03:24:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5C7FA402D0;
 Wed, 15 Apr 2026 03:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776216279; x=1807752279;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x/QizITL2gkQcCULuH39MSmWq5YQ9OSqu1FUuxMLiQw=;
 b=eTLxgSfhb+TJUsegSgrDzCOHQVMpj9O67fxfbX8I2s8YjZFaiQ/jzVre
 2K+jy8JA4YYMjQVjkGbQjXuZlaQNL8xAs30WcDC6/o4RRy7w7zWY575QO
 s4IAdO9wjZyBIhbR7QNyAPP4Mt9O2IhxUA7Gc8YD2TKox/CFxgsfRv9yr
 txHWchVD+rshFLoqTSGhC04z/qhHlIImM/cPPtKv274oAdY09JxW2nbpm
 6QOH6xT4Bb1/ND1OVJ4u7xiAxxgwZ4PCo536NjheKjl/+9wgOjr1JbAka
 H42lAafL4lznBXoYMcvLeH514iYRw8DcQYKivFXc5OQlyK3lzD4PKyGT5 Q==;
X-CSE-ConnectionGUID: t6SHt8ApSgSr1sjdZAA6Kw==
X-CSE-MsgGUID: cZMmjdk6STmwZfYl+dKGVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76351961"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="76351961"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 18:24:37 -0700
X-CSE-ConnectionGUID: hVuMtwEzSWCP+HeWO7nmpA==
X-CSE-MsgGUID: 1NsSt9CYQD2tA4ZDfnWEVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="225564553"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 18:24:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 18:24:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 18:24:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 18:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THzwR3MAO3lvf346wlZh5jjPyKML/7Xsxk4/jrG+p3sK+lUQyEDpntOhiMgccButBWNeqnKEN7S1F/TEtXnnxoEdlFbczWz8yPzbg/UtpkCtIlKPo5d2tsfpZhNBMemAUnL7urvc1tocjgrdyT16jtuyjMUl6p2jV74H2qzLaFEDvuRxCXu2VPnC1i39ApS2OgtH8cPUHu3nYVJXvgK5MHXXWOQBdWvnT6TNHOQRlhWnP78ORUvX+jWUrCRYJDMtSReuCbUXI5dvYif+oS0gx5GpQpvmv1JofzLfa5HzhY5bN0h51DlBzXVoAghZRpR8krj05P9wNiJxrKJWGLS3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/QizITL2gkQcCULuH39MSmWq5YQ9OSqu1FUuxMLiQw=;
 b=hXaETRtYYp0Q74SclKFRiocOZjvrmZCTVB+KSC2uW1zKcxBkHv1ysMjjZ5NP8NcCwHs2Nw+xlij7Ay8vwFhN68zrmJ7hECRu8uGCP+3if4lEuOpgM9HS3BSHdBh7DwY4q1AQ4mwFEm8haaJ2HWSJu+TyhaRgLKl8Dy2HKRdUbTMD0PULJKZ3Rb1AAS0QnigByhRzG/rPyS4lf7Ds+/UDAWS+03OiJW1zzM7009pCU5VkgdfMukwJEyghfI1Z71TmBKXR3UltuuINeOxCQVe+YMe+xPaRZ6sgG6lQsH8+NhNKXgbxzgADOIWfveNam5fiY0aQL30bEanhiBSHRWMlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by SAWPR11MB9547.namprd11.prod.outlook.com (2603:10b6:806:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 01:24:32 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::e1ba:9b4:57d2:3cf6%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 01:24:31 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: RE: 24.11.5 patches review and test
Thread-Topic: 24.11.5 patches review and test
Thread-Index: AQHcxBm9jCZDvgI5I0GSS7w+d0TigbXfZNVQ
Date: Wed, 15 Apr 2026 01:24:31 +0000
Message-ID: <DS4PPF00BBED10CD8DA7B76160DFF4558979F222@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <20260404095902.856502-1-luca.boccassi@gmail.com>
In-Reply-To: <20260404095902.856502-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|SAWPR11MB9547:EE_
x-ms-office365-filtering-correlation-id: 7fdb5e10-c1c6-48af-4a71-08de9a8dbef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: AznI+ePv2+EZ69wh6mvM6DTB0OgO7WGLaVjO4S98GLaLQtvZh5eIDJZCrKTJtqn/3SLXQ9NmPKGu1w5LgMzus/eU27FNb/mLwLhQi3guDXEEl6uEn0BMY7xgQkKd0Vz136nE8hjvpE41kSQP+w1su9OVUSSsA2Q6Yfs+AIjNy7XpOO+ICPEfjXHeLI4SJITVyECWKwWQXtx+z/MgVtMM6e3kcqR9j5pR17OYlZX3lAeImFaLdFb9+M6JFaxthdDu5ijetsf4bPHpog6ILGxripOnZNA0/IGFSvrgyOjAFRsQ8/bjZpJic3gdxoUirEGYDsDNCgyZuqngB0c4l/WU0llR1hhpBC3UBCkm2KhLwR8ioKjbrq2aKvVWBiNiIDJP1ewAZOrjGXZBoNLW4kpuFDSsG10ttGtQHagb5Ji0FxJx6uR8hJXID5K0u2lgfJpvOudlrreV1T/9z2gGZy0IwfwAiFde2593fRWqVL+dsicDPqIvQhxGlE7kr8SEVApgJWvMc60emcNQnlX2sOsI/OtLBFNEjfBLLZXwixE29GSsMAcgD9lhtC9a1xkJhKXfIcdv1lBNIo3UYOFSujANcNWHsnCgaG/Qv+zUt4IHOPNi/cmQxiTZDeg08RW77eB2VGAmXQGbEUQvKo1hLqzdf+Td/t6lZw+5INODrx/ybH1wDVvHTk+c8xN1v/l31tmbKHvPDDGqSXTzF6HQzGZsMkPxk3spKivqrxp4wDiU5seuLZw9ACX11KYu1dV09iRSQ+uUwTpKCX6/NomMX6iENRaJ7ejHaV78bN5nDfNCcIN0CVoa2KfTMBsAMzPyjLSx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG9vRTJ5eVoxYVpGMjFEdFh2c29uYU8zS1BzQTVCWDBFazFsMDU1RkVqQmNz?=
 =?utf-8?B?dzVBTXhkcm04ZlNEQ2JnR0JhcnQyWGd4R0pYUTl5RERFUFlaTy9jTTIrckZ3?=
 =?utf-8?B?ZitiUWJWK2pkb0xTcjVNSWdTbytiYXpXTitHQWp0QzNxMlc2T0pWUEd0RU5Z?=
 =?utf-8?B?dG1BU2tOYmdXTlZ3K2hZMG1FdzJleEs2YlhpczZkOU4vTWtZS0Vra2N6bENk?=
 =?utf-8?B?WG1WWVJOOHNscHB0MzZEWms0dTV6bWVCQUJJcjNyZVV6OHQ3QlZNWmZZbXdZ?=
 =?utf-8?B?MmpNTGI2QkJnS0lCMWg3ZzNFY2d0TEZ3amJ5QitnaFZjT3lKVmxNR3kvbmZK?=
 =?utf-8?B?L3lKZi9raFlZZUhtVDlaTkx4SWE5ejVnQzY0YmxXYXVpa1g2VDVZKzVsYVky?=
 =?utf-8?B?RUFHOFZNR1psTlFXbFhXQng5RkFSNjVmWlNnbUFOWGFiOFZCUnlMTGhUajVz?=
 =?utf-8?B?L3ZlcEpVVnc4QkVkWHU3ajRnMlJ4bHBmV3A0dTBxMjB3TE9rSjR0SjZ1RHFH?=
 =?utf-8?B?Qm9QR05OdSs3TUVVNGZ4anZUaTMrSmRZamhZajA4bDJzSFFsZWx2MHh6Z3g2?=
 =?utf-8?B?WmphZzFNcFlQRFJtR1F1SWZGT2tyZlB2bS9GSlY2eUF3OEZ3SEpmQjU5NmlG?=
 =?utf-8?B?THRSZFgxUVAvV0QwcTVYZmQzazRmUkNCaS94T25NUmdCampKTXo1RnN0VzFS?=
 =?utf-8?B?NDdMQkFVdDNBejdjQm5FK0ZKUS83T0RONEF1TTRnV1d6NTJBc3k0eEhKWndm?=
 =?utf-8?B?bkNRcks2UE81WHlFckRnWjE0clB2U21VV2ptR3c2cHE0djV0aFRaSVJabzR3?=
 =?utf-8?B?SWR4Z2NBOVBPRGhTQVJhU1RmY2daQXVBOW5vMVhSS2JCazMzZHVvalYrU1Jr?=
 =?utf-8?B?V2oyQlBxU3lYWHB2cmx4andMRlBTVERxck90cTQycHNUd1VJRmF6N3VRNVpH?=
 =?utf-8?B?a1ZtWUc4dW0rcFV3UFpSYzU3V3Z0bE04S1RQcjZYVTlLeEpxNU5zWm9JMG1R?=
 =?utf-8?B?eVF5T21qUitmc0R4T3A2WG8za1hjaW9FWkl5anp2MlBHVlB6VzU3SzYrOGNZ?=
 =?utf-8?B?U1lEVm9OUUt6bW9YbFFRQmpMTDF3Vkp3aVR6amVnV08rZUZvcmJaVC83SjF1?=
 =?utf-8?B?dGJrcFNNbytYWTBxZTRvaVdxM01jNkp6STNIa1YwVmlSZU0xR2tNRTMwR2Ix?=
 =?utf-8?B?MDhuZ1BvS3ZvbWpuRXgvcndqMFpXUXFQdmwzRmFPbEtWbUtaOHdLenFZR0tB?=
 =?utf-8?B?ODdSSWZyOHgyWEM1aTVYZzd6TEFORmNrenpIVHhvVExOVThDenh5Vis2U2FV?=
 =?utf-8?B?VDd3T2REMk9MQmU3Ym1TZEVla3ViNnlpd241RUZyQTFyQkJPWGV6UmZoSkJz?=
 =?utf-8?B?c0VNQVp5OEJNUkorcFZkV3NhclN4YWtFTytjWFg2TVVUV3VhaFV3WWh1NkhT?=
 =?utf-8?B?d0ZsZ3FaWW8wazlOQ3ROVmkvTXZYNndDTTFWNUpzUC9GbnEySjJxcVhvYkdi?=
 =?utf-8?B?Qk9uUEN4RmJ4TVVzUXJzQU1kZnFIVi9Jc05ONXIrcmcxQ2NlWFJITkdzeTVV?=
 =?utf-8?B?ZVF5NUUzbUpYa0tKQm1zd2xsUnlIQ3NjTWlxVTlFWFJPMWMzQnUwUzF2UTY0?=
 =?utf-8?B?KzdoVjhrWTNsanMwNTliRG1YL1ZQOUNxcWpuMW9qekVSZUdYaXdFaUE2Y3kw?=
 =?utf-8?B?WlZ4QWZ0bmt4RGQzWGNEMnpJMlM5ckErT2RTbWRYSFFPNXlGV05xSjloUXVK?=
 =?utf-8?B?QXRGOGg1S3BqeFBzbS8wNU5VdlplNXUvbFhqbVZhc1BidkxqSUZFeEozY2tQ?=
 =?utf-8?B?Vyt3M3FWYlZDd3ppeW1jQWNibWpWb2tLSmhaTVJlNmFDN2RuaXFLVHhuTmxU?=
 =?utf-8?B?cUhjZDhyOXZnUFpKbHFOQllMV3JiR2RLaFJDN1J5WXhWelBQTGMyYjZkK25N?=
 =?utf-8?B?U0J4N2N3cXhlS1IzQlNZZnFZSVVqc0p6WUFqMDV1VHFLZ1lGMC9iY3BVcWRC?=
 =?utf-8?B?ODVlbFpyQldHMGh0S1lKSDE0aHBoN3JGVG5wcVBoR1ZwbHp6SVVXemtqbjM4?=
 =?utf-8?B?WHpZcCs2akprdGprWFdsSjJOY2RBbkhkWWtNWENjeDdKK01yejNqRlU2VDJG?=
 =?utf-8?B?WnR2QVVXTGdqOG83WmVldGlKY0Y3STNUTDd6blFXclZGbHBzR1phTDV4OEFi?=
 =?utf-8?B?V1dRbU1hUVNXcStPZTY3OW85bml2aTdySzgzRnd0bXQwdkxkei9sVkFrVlZY?=
 =?utf-8?B?THRGVUk0ZnhRdFlHMXg1NXU4UlhjRTV3MENKcUlneHluUjV2L3hOUGlRUEJs?=
 =?utf-8?B?ZnpETGNscHo1UktPT2tTNmwyQUdmUHVMTUJjWCtKWG9WSWEwWkhldz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UXR2qwBtuGXcrXOLv3u/nPoDBUVoy+9OO7vT3pwLDjBWp8Xxn5ZIbFIbiTFYYRId06oIJa3UKiGW3p5pZv5ce3N5aUiRDwd1JOg9sIuqCd7I/ivrJgSyNXNJ5NIuuDUURe3OuYzaTIIe8+O8H87HwgiQ4xFsZxQRkrfdNbVtUCFXnRGtZKb85Lga3EgoSZSqcOcO9AOC6Bqdf32/aZKs/cA1l9vt2ICxmD7qxYckP/L5jNVchgaYhuyV1sJaD0IqI/11vycK/NMkQsIXKOXDfQ4MJTnVu1GdkyFhyJVGsVMVdq6rWD1oJMbXkWvqnm6k8opRhMW/omxSMktzVvFtpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb5e10-c1c6-48af-4a71-08de9a8dbef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 01:24:31.7422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: go0bmH7t/2Od1X7rjrWvZQT6XRM2x3dUqStne8PYeBWEFydyeOdmlqSB73y+W7adzz6clSCPXEA2KhbYkRecoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9547
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsdWNhLmJvY2Nhc3NpQGdtYWls
LmNvbSA8bHVjYS5ib2NjYXNzaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA0
LCAyMDI2IDU6NTkgUE0NCj4gVG86IHN0YWJsZUBkcGRrLm9yZw0KPiBDYzogZGV2QGRwZGsub3Jn
OyBBYmhpc2hlayBNYXJhdGhlIDxBYmhpc2hlay5NYXJhdGhlQG1pY3Jvc29mdC5jb20+Ow0KPiBB
bGkgQWxudWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT47IERhdmlkIENocmlzdGVuc2VuDQo+IDxk
cmNAbGludXgudm5ldC5pYm0uY29tPjsgSGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54
cC5jb20+Ow0KPiBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmluIEphY29i
IDxqZXJpbmpAbWFydmVsbC5jb20+Ow0KPiBNY25hbWFyYSwgSm9obiA8am9obi5tY25hbWFyYUBp
bnRlbC5jb20+OyBKdS1IeW91bmcgTGVlDQo+IDxqdWhsZWVAbWljcm9zb2Z0LmNvbT47IEtldmlu
IFRyYXlub3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+OyBMdWNhDQo+IEJvY2Nhc3NpIDxibHVjYUBk
ZWJpYW4ub3JnPjsgUGVpIFpoYW5nIDxwZXpoYW5nQHJlZGhhdC5jb20+OyBSYXNsYW4NCj4gRGFy
YXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+OyBUaG9tYXMgTW9uamFsb24NCj4gPHRob21hc0Bt
b25qYWxvbi5uZXQ+OyBZYW5naGFuZyBMaXUgPHlhbmdobGl1QHJlZGhhdC5jb20+DQo+IFN1Ympl
Y3Q6IDI0LjExLjUgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gDQo+IEhpIGFsbCwNCj4gDQo+
IEhlcmUgaXMgYSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDI0
LjExLjUuDQo+IA0KPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyBB
cHJpbCAxNnRoLg0KPiANCj4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9u
IG9mIHlvdXIgdXNlIGNhc2VzIGFuZCByZXBvcnQgYW55DQo+IGlzc3Vlcy9yZXN1bHRzIHdpdGgg
cmVwbHktYWxsIHRvIHRoaXMgbWFpbC4gRm9yIHRoZSBmaW5hbCByZWxlYXNlIHRoZSBmaXhlcyBh
bmQNCj4gcmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZCB0byB0aGUgcmVsZWFzZSBu
b3Rlcy4NCj4gDQo+IEEgcmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91bmQgYXQ6
DQo+IA0KPiAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvdGFnLz9pZD12
MjQuMTEuNS1yYzENCj4gDQo+IFRoZXNlIHBhdGNoZXMgYXJlIGxvY2F0ZWQgYXQgYnJhbmNoIDI0
LjExIG9mIGRwZGstc3RhYmxlIHJlcG86DQo+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9k
cGRrLXN0YWJsZS8NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IEx1Y2EgQm9jY2Fzc2kNCj4gDQo+IC0t
LQ0KVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazI0LjExLjUtcmMx
IGFsbCB2YWxpZGF0aW9uIHRlc3QgZG9uZS4gZm91bmQgdHdvIG5ldyBpc3N1ZXMuDQoNCiogQnVp
bGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0Mv
Q2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0gVWJ1bnR1
MjUuMDQvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhFTDEwDQogIC0gRmVkb3JhNDINCiAg
LSBGcmVlQlNEMTQuMw0KICAtIFNVU0UxNS42DQogIC0gT3BlbkFub2xpczguMTANCiAgLSBPcGVu
RXVsZXIyNC4wNC1TUDINCiAgLSBBenVyZUxpbnV4My4wDQoNCiogRnVuY3Rpb24gdGVzdHM6IEFs
bCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikgUEYvVkY6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVj
a3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSVhHQkUt
KEU2MTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNP
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBl
dGMuIA0KICAtIElDRS0oRTgxMCwgRTIxMDApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRp
bmcgYmFzaWMvU3dpdGNoL1BhY2thZ2UgTWFuYWdlbWVudC9GbG93IERpcmVjdG9yL0FkdmFuY2Vk
IFR4L0FkdmFuY2VkIFJTUy9BQ0wvRENGL0ZsZXhpYmxlIERlc2NyaXB0b3IsIGV0Yy4NCiAgLSBJ
UHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJh
cnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KICAtIFZpcnRpbzogYm90
aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQVlAv
VmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVy
ZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjAsIGV0Yy4NCiAgLSBDcnlwdG9kZXY6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwv
UUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KICAtIERMQjogdGVzdCBzY2VuYXJpb3Mg
aW5jbHVkaW5nIERMQjIuMCBhbmQgRExCMi41DQogIC0gT3RoZXI6IHRlc3Qgc2NlbmFyaW9zIGlu
Y2x1ZGluZyBBRl9YRFAsIFBvd2VyLCBDQkRNQSwgRFNBDQoNCiogUGVyZm9ybWFuY2UgdGVzdDog
QWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogIC0gVGhvdWdocHV0IFBlcmZvcm1hbmNlDQogIC0g
Q3J5cHRvZGV2IExhdGVuY3kNCiAgLSBQRi9WRiBOSUMgc2luZ2xlIGNvcmUNCiAgLSBYWFY3MTAv
RTgxMCBOSUMgUGVyZm9ybWFuY2UNCg0KDQpSZWdhcmRzLA0KWHUsIEhhaWxpbg0K
