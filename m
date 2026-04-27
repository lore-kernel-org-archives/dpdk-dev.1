Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D29FF8862
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 09:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF755402E1;
	Mon, 27 Apr 2026 11:13:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 476894029F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 11:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777281222; x=1808817222;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f4SdntDYSWI6YOnza1nutYhM+05h14yEA0oO79PviQ4=;
 b=QNn+UHa361kMBhXtvDiStlqmIU6/1vhukRDvEDKsHsJFTVDRmc9xD0G7
 MWjwoAthzFP5SLqdTV8L3ctJ38480lcsUT6jRR5ynW+lEaLE3r+kkqKqO
 VV5YqRD8CfnWFGL2XNucxDcwliBO1WQ2luBiHWqk1+yal0S5R5qyO9K+j
 DKtwgeaXmoqpi9jlPmQ1jqfxzcmjT2gTmh5/XnIz9ZJz3Qqkw4ENwZfva
 DSGU7TfiG/q0IO3/xZ0GJpm7KIaqO4G7a5muYLs1K44lBCWpgzlioP+Kk
 IxSdfgFR2yEPRzFnRvlhE53pq2V8u6DL6NwZMBwMAz7jf4lLrLsU/cdpO A==;
X-CSE-ConnectionGUID: +kfgkBxVQnO/2Vl/a43NsQ==
X-CSE-MsgGUID: a/QIy5T3SraluRL6MeMcSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="81772573"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="81772573"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 02:13:41 -0700
X-CSE-ConnectionGUID: DrGcbo3ySB2am7FS+qZ0SA==
X-CSE-MsgGUID: fm/vjiXdQwW0Y21wv1yHMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="237544454"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 02:13:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 02:13:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 02:13:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 02:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMPFV6RKEE5yQf45iCXfYTwqpPZNXILk0cBatVHTAQRQ3HMD8Pf/7DmuPQoBcUgDzn9h3XmcH74K61o+qBBGPASnVFSFsgDJX9BAiixWF6m3TBMiOblM8atYmS0eOfIGpVLN+/pJBW0HlsuyTUyNq5+7RZWUW+dM0PQRi9NWCSL6hm/JPH6oVLhAXhltxp/tMj7xKc/zrxYc6yMyBLBEjTrgB/nuYdQvLc1voLayv9FLlzdgU5O8c7hH7dSU61NidukiryVMLPYVyFJU1b154vnJ7qA200xfveZGXZUb75JyCJmX5IPfCkg957NTROLjfrrMCW9jW9ZNyddH7Gj9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4SdntDYSWI6YOnza1nutYhM+05h14yEA0oO79PviQ4=;
 b=J8UfgFBtRGasMAITw0brmzv1OGvsocTi3vB026wxmHaTPKHVWUsGsYZuDbO5EJMn0SKc3RkXOoBeEwXs5CgcB13EIqjlDy6LlLkL634BmOXkwPIGYGHMmOKk3jxwG10tM4BNJajyKm5qYWhEKDFcdVR06W0xAM/QIyXRCua6uc7atoIcQaQEHddCnd8idnev43i+dkfPmmcajEqxm0j4Q+MrLbPUbytQYRROdv3SBOaH1CSc6QM3HSRDV/JOQmwffVDMjMUkxCGiBkb8ghMIai/FQZpHPhHC2jwmp5LZEcEeAqRQdKdtDZqAkwX3lgEnwck5mMAcZwlGyhgg3Iz9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN0PR11MB5743.namprd11.prod.outlook.com (2603:10b6:408:165::5)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 09:13:32 +0000
Received: from BN0PR11MB5743.namprd11.prod.outlook.com
 ([fe80::10ff:ad7c:9b7e:4ffb]) by BN0PR11MB5743.namprd11.prod.outlook.com
 ([fe80::10ff:ad7c:9b7e:4ffb%2]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 09:13:31 +0000
From: "Jiale, SongX" <songx.jiale@intel.com>
To: "Wani, Shaiq" <shaiq.wani@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggNy83XSBuZXQvaWNlOiBwaW4gb3V0ZXIgRXRoZXJ0?=
 =?utf-8?Q?ype_for_L2TPv2_flow_rules?=
Thread-Topic: [PATCH 7/7] net/ice: pin outer Ethertype for L2TPv2 flow rules
Thread-Index: AQHc1e9PFSl79QpI5k+2zMMiJpOj17Xyn7hw
Date: Mon, 27 Apr 2026 09:13:31 +0000
Message-ID: <BN0PR11MB5743229A5C858D7442183C16E7362@BN0PR11MB5743.namprd11.prod.outlook.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-8-shaiq.wani@intel.com>
In-Reply-To: <20260427023115.1225843-8-shaiq.wani@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR11MB5743:EE_|PH8PR11MB7965:EE_
x-ms-office365-filtering-correlation-id: 29940095-d7f8-441e-9a7d-08dea43d4088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: HL9g/dj2NYcCFqbpb5i12fWFU3zkdvNk7XwZTuh2qRBHqXC7HdcGc1Px6ZFGPTk4pOg6/zYhqm2xZnK5kE7TN2E/8iQsoNLyQ3DDUTxDsMipEu8LHExJq2aTonkGElilCZ5ransZGNuhaUh1kQmg4l1ZI9qY0E76MWbn74aK4RiOe+/JZnuLUz3ghi7aGH+X5pqDBvommYJx3521g/72HKomUDvAG5AiyH40bVbN/hq43MIz8iR6PXY+F/VUyNUqZoKuQMFLkCgy/oEHFm+lir1CCkN8MXan2yfNnPYA5u79LGJ3pr8aig818P426BfoQZIKVoyJ6jSDP9W27+byW09aEgngbSO8R2SSLo0/SgEAE5Pzu3Ui3RVBkHOhc3hTnF3nzDm18TdVkiWsCiLDhYR23qPpeZgX2kczuTQhsY16BRFuVDyZwQaIuYL/09jXLoPte6xlka5sC5SfL5qgzL46QXW23oA1oSclsI5/6Tm9dRCfJt37kjx0WARbLYbTsdhWwgOXWncGI6afajKGctwSlv7Ho4lRaoaoIm+vi3W2ny6iq3eB0PgTCGQ1nuVMjgGMjtObZwiriHi/AcJ4Fwe4Xj3yM+VP/zYRpSD4hGiOGJfrvwOy4ZAaGxbspaMIifurR5J5FfAh5gmvR0R+U2uK+Pe8vUN4ncuTStO7WSmZeQ8ulfLUFJaCZKlS6zGcG77xvvzL0gMrANn5mjw2S2KF41q4Aon436r868VGYkgIBBvTO6GjNT/tzNwg7hMGa1+0ofDukQv+yKyBBSrqvABiz6Amcw8YrAKkdMSR6h0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BN0PR11MB5743.namprd11.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjFqKzJ5ZytSWEMvc1hMNXJSZ3hnSTZSYm1xN3Nnenhzekw2by9GUlRpRXM5?=
 =?utf-8?B?RXBhSVF6cU5LT0hoenhYc3VBZVBJb0lBLzFBRXN1Q1ladWNiT241WVo5aXVM?=
 =?utf-8?B?NGxLL1FjL3duUThpYjZjVEl2U3hOVHNFQ29GSEorREYzelhRcER4R2RJcldl?=
 =?utf-8?B?Y0tmcVhZczBHakwwcGpJYk5HRjdwUnQrZ0J3VzZsK0tobmN3NVYrU1NJY0RR?=
 =?utf-8?B?bUU3dmRrNDlmWVhCYW4zWjVyTXZSbHpieWJwaXBhQVA4Z2ZTcTRMRi9kQlFw?=
 =?utf-8?B?ZjBqek5OeENWSWo4M0VkSG5mMnJIcndGcU8xVUNlYkVkanRBTDV1MFU1WElT?=
 =?utf-8?B?ekVpVk1hc083eExEemhKdStXc25zMTBiOEpWWFRiUGpab2NlNnprRWliZG5w?=
 =?utf-8?B?MEI4alU0cUw5UlVDYkhSd2duSyszSzJCUGZsTkNJVDBaQzFuNFBFWUdrSlIw?=
 =?utf-8?B?cVIyaWRQZmlJWHl2b3ZRV2ZkN24vd0lzeGlrMTBWUFZZMHhwNE1SMzJQUFpo?=
 =?utf-8?B?K2lneU5IZFdEempYNlJCaUxGSEQydFpzd1pDeUZNOTFFNVZMN3ppSy9VTFhN?=
 =?utf-8?B?cjhTMWkrU0JVWjdlbmNaZDFPeG5Ma24rQjYwcElHaGlJR1doM3FQSmVJR3JR?=
 =?utf-8?B?MTRGQi9WTlBnTG56a0pxaDhuZ2dhMlhsbllkSWNDS2ZzU2kyM3QzTlg1YmNn?=
 =?utf-8?B?Uy85OGVmbXlYK0ZVWnlhWmdXZVZkU0xDUEVNRmsrMUp6TXBTQ2wzYTJQN0Fq?=
 =?utf-8?B?cHpqNFNWOGpDL21lYzVUdFgrbldBVDgyWVNhRWJ2REIxeDk5MEhsNGVOSzV6?=
 =?utf-8?B?STJiN2N0QU1vT2Z2cHBuZUY1ZmFhS0hITFlLWDR1a1p4SURLMnVYWXFaQW9R?=
 =?utf-8?B?V0ZEdWh3K0tndldLKzdBaTlMUGtIMjBCQno2Tlh1dlBybk5IaytQbTdjOGNO?=
 =?utf-8?B?ZkkxQkFmYUZQMExNYXRCNUlHSllyUzFNT05aTHUxZHZGZjdiSHpFdDR2TFhJ?=
 =?utf-8?B?dkdJQ3M0NGZnWGFCdmV5SkdlNG5XdjNTTmtlZlhrUG9vdjkzRzV3SDR4aFlQ?=
 =?utf-8?B?MWRwS0ViYWs0cUJhWXQ2TUhKTFd2OFN6YnVKSG9lQ2pESVh1dHpVeklyTGU5?=
 =?utf-8?B?TTdjTGc1UnNqa1ZHN2gyMTRSaFBVaW5EVmFkeVRORzMxTEJGUGc2dUhZYU5P?=
 =?utf-8?B?M2VrZzZ1MnozMnBnSjRCNjg5YlFETkxTNC9MeVh1VUl2MDBIbm9WR1MzUEY2?=
 =?utf-8?B?cE1OazVpOG40TGw2NTdudWlHR1Y0cStqMk1PTi9xektiU2tPSHA4dUNqeDBH?=
 =?utf-8?B?SEJPczJEOUhGc25IR21WYXh5d1ZGajE4NnIyREpqUEgrcGxGWm5wM2NjajQz?=
 =?utf-8?B?LzNIK0dSSHlRVHg1am5nRy9KVFpjVTRNWjZUWW44SWNjLy9aNUhETDVYOEJ0?=
 =?utf-8?B?aHMxdVJhRkQ2ZVl6WnRlOTZwbzNBYUlpUDFvTjNVcWZsWWdzSmVFQ2oxTXdv?=
 =?utf-8?B?L3hLQUpaU2lmbjlsTFNwK21IQlJiYjQ2Kzg4NnpVbXZ5T2dxaFJLOWQxMmxw?=
 =?utf-8?B?Zmo5cFRWWkxJTnJnejdLS21QOC9LQXgwTmdXSFV5eGJFUUsraHJPTFNIdktw?=
 =?utf-8?B?T1RRZm5XUm84ZlNkcGlnNGdRV3pwT0pCQmxvWFNUZ2FSck83Wmp5dmN6YUVv?=
 =?utf-8?B?aStHNTRObG9kM0VnTUlCM1VVSXVTakk3L1VHblR4NGNudS9Ka1hJQ0dhRVJI?=
 =?utf-8?B?cFd1eEY1ZlcxU1NIZjZ0MVRPY1BtU2o0UmJPVm1VSFBkRTd1cmZia0JvcVdX?=
 =?utf-8?B?NXhURzZXZ1NCK21YUkpRcFdQY3Z0eG1xcHJCVmRSNXZ5dUNPUkNiMFNGTXdV?=
 =?utf-8?B?Vmw3S2JRU1NwREY1MElNWmVZYVpZY1pVcjcwVnRiRVNqQlZ1UjdjckZWUERz?=
 =?utf-8?B?UXdLbVRZZjZvZFN4aTcwT2wzb1p4dGYrbm1pQStzdW1IaG1MRGNHS0ZZcE93?=
 =?utf-8?B?SGhPcHRQRzA3d3gyR2NyTUZVZGt0c2hYNmhybVd3SjJMN1BVd0tyaFNPTDZZ?=
 =?utf-8?B?aFpJRG5UUGMrQ3FBbGUvYzdkK0dKMjYyV2o5Yjdod2JoeVVLUjgrUzRteWhN?=
 =?utf-8?B?L1JUNkJpdjVqb2V0NGlXQnp0OGd2VGJLRmo2cjVIbERmd1pLV3F5OU5JMWVF?=
 =?utf-8?B?S2JKcEVET3MzR1dYSjlDb1kwSW5wT3ZPMjVMMEx6dHdnOC8reWU2cStRdFE3?=
 =?utf-8?B?TUxQVzNPOVgvRTNMS1NDVGdtbUNOZlRlRVZBeXQ2eUxMYzhJazBzajZja1ht?=
 =?utf-8?B?UGZLME0xNWJjU21CYlRSZ25tYmxpUmtseHM0blpNcExzbzhsQWRydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IsVyg61yw8MycysmwfqtPRsswSBXW5McEi3FC0RXY5ek05eS6O2U3TiAeCVU41vcqzqqfTEVYKf4Gd4BmV23CZYKB5fcAx2zdAYz2l0R6JTKP0h2d/X3b4UmIkbcTVHVku+o+cZ3S0yJtOj0jNkRDP4z3IuRIawMPQFeb1nnDyeC0O0zVp99cTD5PvdgntXhZ0bZy8gKicVaOxxnDJ1JwWtrkJLV9qQcAOskXRHj4D8LzXBArgtImuK+4ZviCvsReQVSYqOs3z3i5BPrF4AGsFyLmyYpXMep8M5+KZihJjo/BX6aaZu3mzynDxX/qA1jvGLJ2cUPgoOvmEBprNqRjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5743.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29940095-d7f8-441e-9a7d-08dea43d4088
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 09:13:31.5638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pzbNLAA7C7z6Ub9kEZj6/Ye2t1rJfm5Q/pFq+LrXqWPGNbwZp5xszl5xKAHq+m7IJ0ptQMjoLOlMdKz2hDwNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
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

LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBTaGFpcSBXYW5pIDxzaGFpcS53YW5p
QGludGVsLmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjblubQ05pyIMjfml6UgMTA6MzENCuaUtuS7
tuS6ujogZGV2QGRwZGsub3JnOyBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2UucmljaGFyZHNvbkBp
bnRlbC5jb20+OyBTaW5naCwgQW1hbiBEZWVwIDxhbWFuLmRlZXAuc2luZ2hAaW50ZWwuY29tPg0K
5Li76aKYOiBbUEFUQ0ggNy83XSBuZXQvaWNlOiBwaW4gb3V0ZXIgRXRoZXJ0eXBlIGZvciBMMlRQ
djIgZmxvdyBydWxlcw0KDQpMMlRQdjIgZmxvdyBydWxlcyBkbyBub3QgaW5jbHVkZSB0aGUgb3V0
ZXIgRXRoZXJ0eXBlIGluIHRoZSBpbnB1dCBzZXQsIHNvIGEgcnVsZSBjcmVhdGVkIGZvciBvdXRl
ciBJUHY2IGFsc28gbWF0Y2hlcyBwYWNrZXRzIHdpdGggb3V0ZXIgSVB2NCAoYW5kIHZpY2UgdmVy
c2EpLiBUaGUgaGFyZHdhcmUgcHJvZmlsZSBjYW5ub3QgZGlzdGluZ3Vpc2ggdGhlIHR3byBmYW1p
bGllcyBiZWNhdXNlIG5vdGhpbmcgaW4gdGhlIG1hdGNoIGtleSBkaWZmZXJlbnRpYXRlcyB0aGVt
Lg0KDQpBZGQgSUNFX0lOU0VUX0VUSEVSVFlQRSB0byBpbnB1dF9zZXRfbyBhbmQgc2V0IGV4dF9k
YXRhLmV0aGVyX3R5cGUgdG8NCjB4MDgwMCBvciAweDg2REQgYmFzZWQgb24gdGhlIG91dGVyIEwz
IGl0ZW0sIHNvIHRoZSBwcm9maWxlIGluY2x1ZGVzIHRoZSBFdGhlcnR5cGUgZmllbGQgYW5kIHJl
amVjdHMgY3Jvc3MtZmFtaWx5IG1pc21hdGNoZXMuDQoNCkZpeGVzOiA3MzM2NDBkYWU3NWUgKCJu
ZXQvaWNlOiBzdXBwb3J0IEwyVFB2MiBmbG93IHBhdHRlcm4gbWF0Y2hpbmciKQ0KU2lnbmVkLW9m
Zi1ieTogU2hhaXEgV2FuaSA8c2hhaXEud2FuaUBpbnRlbC5jb20+DQotLS0NClRlc3RlZC1ieTog
SmlhbGUgU29uZyA8c29uZ3guamlhbGVAaW50ZWwuY29tPg0K
