Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997F606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vw/7PCOd;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=CLsGoWj5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA5F402C4;
	Thu, 26 Nov 2026 03:09:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id B68ED40284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 03:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795658949; x=1827194949;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=ZQt+0PlI1MMHtz4T4+KZsA/ZAR/PFVWcb6VxTUEJ9sc=;
 b=Vw/7PCOd9GWScUEt1o/QzneolUOUuj7PzfojdCQJB/1HcGkKBqaHFg00
 mw4Rl6vgt6uIXmxuJReIj553PxW5oN4+lF8S/v8l29ERiKQp97jyrDXoh
 cohnI+8Pl7K8PlhC9Wswm5LT3LXoJ0mBUfM60+YbVGg/0UImGEgOWJIig
 IBSZMjeNUAa1lAwIbV4XntNmFnVVTN1QJ/B84iMCURzsftk4vdgqYGaBO
 GlF+t2+M2t4uvNzywCSHcC8uiFzpq6m5Yigpxm006mqI6UScd4Uaa8+Xg
 GxnYL9r4O8vhJ+68CBhh4XQVacLlagFYBhXXjrI6Gh/MLf292Axn6GxGZ g==;
X-CSE-ConnectionGUID: 0a+2tjG/S2KIns36ZJe91Q==
X-CSE-MsgGUID: 7PGJg58DQl2ltSV/p5oFEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4570661"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208,217";a="4570661"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 18:09:07 -0800
X-CSE-ConnectionGUID: O0JkvVqlS4m5OIyqJnZlSA==
X-CSE-MsgGUID: Nhuv+ZI2TNKSwo2x45YFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208,217";a="12358581"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 18:09:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 18:09:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 18:09:06 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 18:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w21HjLAY6IQQS+gjMGXOU5F8BYVRNI1BujZGSLVu5E498hGEXQYlGI8iGY4I/Nd09ny2y02T3Qt3pl8WEZizjvdPeO928cOUYWu2HFScoJlKZivo3ACoKZnfMrodPD1ahWUTZmbpV6ybLEyve8KZInySQf1xhNqUFarjYAEhRFP+/7H7KR+kbv90BAqbfM/aKsImvZcG7hspYp6nWkZcrKFgba3KXUKOAdk/U8AS0GPN7ffm3oMeWtMAulmt6T1ouZV7QHnQKIRfIzyfF4LhF4bDKc++bLLjPJrloihS1F76qmQcWOMiyliRJDQDh7bBj1CS83BqSG2ms4aFaGYz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQt+0PlI1MMHtz4T4+KZsA/ZAR/PFVWcb6VxTUEJ9sc=;
 b=lfy3PSp2vbn0JZoMD9akkEkUQGFfyJriqzWhOPtvLi1zSJsTVx2ZYMKayOOGyFjMKvYseV1NhUqJ4OVB2kEqd/DwZy3OgUOr2ATWRYRQak0XTkklYHi5DzWxNXMNAKn4sHcB6XL/Bp2L6WM1h5m00tZgexzqBFOCnxEV7Ou8Fn+9ac4SCZRUI8z+8l+io2jxMw5K5kprBjfKdL6XkZwSLsC6lohsrVFTH5lVr+8LlLw122i+NTPK+lFWsp3Mj/44aOhwIrmCQmzMPgHd3YYdVW78K1UU3rDK8HeK6aDlqc0UIiNr+LdKczGwZWiofl6RAIY9HRSvaD/L7NNm27vsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQt+0PlI1MMHtz4T4+KZsA/ZAR/PFVWcb6VxTUEJ9sc=;
 b=CLsGoWj5lILWFJOgmLZ1pjqfdG1pvALT72MmbSlUS8L6p5Ae5Dmzkkli9Y+JFsJLMGHxwxpT3qK5ca6Tk9TszU5VKodoMLos4xq2Xvpt3oT7WjyBHASlsoT9PshNV62Ua3aTAAjLvyBQYqL2e5bQNAmTc4ppJD8MPl06n7q+VOA=
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 02:08:58 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996%7]) with mapi id 15.21.0639.010; Thu, 26 Nov 2026
 02:08:57 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>, "Hosamani, Manjunathgouda"
 <manjunathgouda.hosamani@intel.com>, "Rao Pv, Sadashiva"
 <sadashiva.rao.pv@intel.com>
Subject: =?gb2312?B?u9i4tDogRFBESyByZWxlYXNlIGNhbmRpZGF0ZSAyNi4xMS1yYzQ=?=
Thread-Topic: DPDK release candidate 26.11-rc4
Thread-Index: AQHdePIIhu66d5O/Bk22f2D07KniXrc/o+X/
Date: Thu, 26 Nov 2026 02:08:57 +0000
Message-ID: <DS4PPF00BBED10C14F6DA9C502073956EEA9F422@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <cku3Z3NASyqANwzCcnMu7g@monjalon.net>
In-Reply-To: <cku3Z3NASyqANwzCcnMu7g@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|BY1PR11MB7983:EE_
x-ms-office365-filtering-correlation-id: 245e49a1-9b6d-4ded-c2bd-08df4b623aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|261021135927099003|261022105027099003|261026140227099003|261028144727099003|38070700021|261026121527099003|261009223027099003|22082099003|18002099003|13003099007|8096899003;
x-microsoft-antispam-message-info: SqqO+804lYQc0sFmSHdaRNiIVeVv/1lCAPfd9XBZ7vXp4fgD8ShGUYRqV/z19izMrqk8j596bD/IOGmzUK75sHAB1YJxY0JHu7djvmXf74UrlLSTgkU+bbVg3riazHwh9Pwc7kPSoYyy9lexuk9iiobT0AlJdgVPJFtPk0ckcfnR1d1UR4o/OhTlDjeABsUXYOfCdGqLoKNlNDOjUBZvyR8KQ+dA5z84r/xflTwX0PXujNZTCFemD5YETacZ0XXsh/41lFfu7t4v5xKLJG3bjB8jCycCoaTqk3x8T/+eOd8dZ2z1HoS6FNvlW2ZQaYrXUEzWUQ1xyfhYl51gnRMI9K6YkBReOSeXbtfe3+XN2+wLRb4cEddc3xO4BHcX1uAz+b/UNjsM3sM49g8BBH66BeuoQlt72fd1efUBJ3vZ5NrqJZqQAb3JIc4y951Lk/fqKY04HEBvlFCwQq19mLkDNk5qa7oMfLdt/p6DP7LXJWj7KTs9MOJzXwX+o/+ZuK3MOO4Pe/q14Ad4KflaMrXGFqjY1GXv0+SDeoPPuc06z57qVfK8FK6Ng9010LI7SYQRFmXh0M/mwDxBL3LtPMgJsdEKHUCkEFN1aaZUdLBBNC2jSVQfsNY5ySEraNrQQL2Ph2nKlwPg1TnIRPSHkHXLkHlif13uupvuASNkkKnmkvfWVeeGGb4XMH/okOxAGhCN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QWhLMFo0RXpEWGp0Z0pEN2RXK25NWnU5SmJGbTFoY2NQWUZsY3RnUkVMVS91?=
 =?gb2312?B?ekdrQXZOM1NVWTJOTHhXclNMbTB4N3dvZ01pWitRQ0l4M2ZQNzI1RW5pMSty?=
 =?gb2312?B?SVRBcDNmNXRFNFpZR24ydU14UFZFMlkvd2d4RmcwRkJxVHZmVUU1QmYzMHkr?=
 =?gb2312?B?S3FyVlN2emgvdGFqdExOMnJCZ3puSEtJbFBaNTlXbkJyNWhBeEdMbTd0bkhw?=
 =?gb2312?B?ejdhdXhiVndJbllBcFo0UEQ3K2JPSWxRdjJUS29QTFc0OGc1d0tWV0lLZlVy?=
 =?gb2312?B?c1Bud1JFc0RmSmhlRkIrRWlHb3EzamdPVHFaTlhMc0N6MkIvcnV3R2ZYeXVU?=
 =?gb2312?B?Y1ZqWUVoeHVxVDNXampIMWIrdzh4d3IrSXhvbDNwWlczeDdCcmlVNno5aWVZ?=
 =?gb2312?B?WjJmRFpuS2EyU210VUhvYUVaUXhRbys4NDdCOFhXNCtRK2dwN2VPUUJzbDkr?=
 =?gb2312?B?L1psazVqZEpudyt5OWhhTzFzSEtuUmozM09oYmVqdElQWEp4T25jWmRrR0Qx?=
 =?gb2312?B?VkRGY29sK1JPMDd6YTUzaEFPV2ZpbDBacUNWaTV0aHAyWGlIR3BlMW5wakdT?=
 =?gb2312?B?N2tqYWtOc01XMjRxNWswdW8yR0gzbGJaYzFSMWFHTisvRTA2b3RLQ3pRSCtk?=
 =?gb2312?B?ZW1TSzhxa2xOQkgwUmtDZVRra3RhZTdrQW1xaHZhUHpaZGFIeGpuV1Y0NWxM?=
 =?gb2312?B?djg2VUU4bktDYTdlcGhsdG45NjRGdXlBNVZETUY2QzFpOHYvUGU2Z1B6dkps?=
 =?gb2312?B?N1kyLzVESEE4N0hWQU8vZExJbG9GNThXdXdUMUxmVFFxUGlZZ204VTd2b2R2?=
 =?gb2312?B?SWptaWl4a2RNRUVPckpnbVdXSXF4dWdGbFdTRUlVWGFNcmViUkJ6NFVxcFda?=
 =?gb2312?B?OC9TMm5PWUdoZEJ2SHpLakxFT1lzZXg0eFMxRDRFUmREcHk3TTdlU0Y1ZmZu?=
 =?gb2312?B?MGdrUzhGVGFqQzRqUFZjRjM2TjJwR29zSmJTWUg4ZThZa3BqZitMT3B2Tm5V?=
 =?gb2312?B?c2JuT0lZSVhXcmd2aHQ0bnNmcE1oNjk5dkhzbXBCZFF4Nmw0TmtGeUdJS0s2?=
 =?gb2312?B?SUZ0Wm9VTXJiZnozRFF4TkZZdUdlSzFkTDV3RW1XaTVSOG5rTVlkb3MxYUpq?=
 =?gb2312?B?bjBNU2h1RTI1R04rRkprK0tHdTVnQ1hDZUdyWStHTTRsMjd4b2VEdC9EeFlD?=
 =?gb2312?B?YkQwM1IyZTlaTjZFaklCSnF5cTROYTFwcml0SDRaYVRHejBNYkpEeFlvOGdH?=
 =?gb2312?B?bE5TV0NBWTVhRjJYeGYxb3hnc1MvaDR5QmRVUVlLZEFPNDFndkhTYisyeVJx?=
 =?gb2312?B?YmprOGtVc3RxT04vQ3ZNVHJlQ2RBdnRVN0FuR2RsWTdKVUJHL3dWSUROb1Q1?=
 =?gb2312?B?aHVMMDFOUXkxMjVvWE5oSC9wRnYzbUVrVXgxMmVFT3hOT0xyRHZpY1hNOGxB?=
 =?gb2312?B?cm9BdzJTcnVnQ2lyWGgwd3AxUEMyR0pKc0orVUJJUTIwTTQzc2ZvUjV2Qm1I?=
 =?gb2312?B?azl2Tk1ZeU9UY1FTYUdWdU8zdUtvRW56eTU5cjlNYmdpdE1uR0hiT01TeUF0?=
 =?gb2312?B?VWlTMExKbW9XZVFRTVRERXp5R3ovU2pLRlJmblFzTmRkMGh3cUpTSEQrWmh5?=
 =?gb2312?B?N3dMRVUwbTd1ZzFKWXhFUnlDRTYyVlFmdUl3bm9NQWlPUVBRWlZ1bjkvNU16?=
 =?gb2312?B?MjY4M05IcU1zdEwwR3pZek51S2tjUWhmWnhaS1RsOEdzNHJrODl2S3NsVjNV?=
 =?gb2312?B?cFBFL3M3QUttdEh2VnYrbVRBamJwRkxyMHJYV1BuK1I3K0VFWHBLR3FUcVl2?=
 =?gb2312?B?VXZIUFlsY0hvU3NUbmZ4Zkhnak5GT0tFMjNXQWpGeU9TYllnT0J4RDRTK0d0?=
 =?gb2312?B?RHpPcGFTa2RNblAvOFdHTit6ZmhRTmFLV1BONEx3aFJEV2tnbUZyeVZPSCtS?=
 =?gb2312?B?VmxuZlErRm5GTDczT1NrTWZCVnZaK1B3VHJhVDVXQUFRSkw3Uk9ONGVrWVpw?=
 =?gb2312?B?QmppOXR3U0pNVHVIOS9ja0VWVFhDbSt5b1RjUFN2U2R6TjRhTS9ueDlyWGx2?=
 =?gb2312?B?eEZGUlVMUGk3NXNOZEdVRXQ5S2RpNENoWEpTNTdtS2FKdkw4a1BUdFhOSXh6?=
 =?gb2312?B?YUN6V3U3eHZmUU44NnN1RVNYaWlsWjBQQTZqZ2MzY3UvNlVlbGNIc3ZrZWZJ?=
 =?gb2312?B?WDJnejlQRlJHOVQ4Z2lFbFpnUnVoUHlVL3l5bVNZcjhuWDd2bjVqVUJmaFpa?=
 =?gb2312?B?RG9tYXN6cENRSi9iMEpZeFZnSkV5TDM5VHU0eC9KL0orS04zcU94RGFFcS9J?=
 =?gb2312?B?WEhlNUQyVmd5cEthd1lEN3Zzc0ZqR3ZFUG1kUklyMktuYll0bjdSdz09?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PPF00BBED10C14F6DA9C502073956EEA9F422DS4PPF00BBED10C_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pNgR1zs+en8Nwh0XDL5Uc6ivhUJPDua6AJrNFC4Qtv3mBaeQBkQlukmiCShU8YgOFUMO0lwk3yhs+7rJPJmepmTww0LWHqjw1KdeZJsScU6yvqYKlXsJ6ha0oLoJ0Y3cVf9Ip8KyJgLpdqkPMYuk77Pe/VGofo6UVtR7lB721O5YPLa+c5AXP0Ah9baB8brYFGueiBqkr3rHxymiLHo21+5VrppoA+z6vk0OqB3KKx91dwbIvvmPVpy+F62m60u09IicApbMI64qqsUepGKJZVIqJBq0wCmm/+Aguh3zJKMeELfODuBBLwU/OcXD9XWyaL8BVdGJM3Da4eTSzzSaKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e49a1-9b6d-4ded-c2bd-08df4b623aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 02:08:57.7147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fwjCx05U9brrYFWdyXw7e3fsZVrOEDK4f7/rOFn6qs2CmGGAbIMP/8ymYcnMynoTS04k9dE/NCNpIHW+E+Tgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS4PPF00BBED10C14F6DA9C502073956EEA9F422DS4PPF00BBED10C_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

t6K8/sjLOiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQrS0beiy806IDIw
MjYgxOogMTEg1MIgMjAgyNUg0MfG2s7lIDIxOjE5DQrK1bz+yMs6IGFubm91bmNlQGRwZGsub3Jn
IDxhbm5vdW5jZUBkcGRrLm9yZz4NCtb3zOI6IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgMjYuMTEt
cmM0DQoNCkEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMgcmVhZHkgZm9yIHRlc3Rpbmc6
DQogICAgICAgIGh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvdGFnLz9pZD12MjYuMTEtcmM0DQoN
ClRoZXJlIGFyZSA0NCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBzaG90Lg0KDQpSZWxlYXNlIG5v
dGVzOg0KICAgICAgICBodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvcmVsX25vdGVzL3JlbGVh
c2VfMjZfMTEuaHRtbA0KDQpQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBidWdzLmRw
ZGsub3JnLg0KDQpZb3UgbWF5IHNoYXJlIHNvbWUgcmVsZWFzZSB2YWxpZGF0aW9uIHJlc3VsdHMN
CmJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhdCBkZXZAZHBkay5vcmcNCmFuZCBieSBhZGRp
bmcgdGVzdGVkIGhhcmR3YXJlIGluIHRoZSByZWxlYXNlIG5vdGVzLg0KDQpXZSdsbCBjbG9zZSB0
aGUgMjYuMTEgcmVsZWFzZSBjeWNsZQ0Kb25jZSB3ZSBoYXZlIHJlY2VpdmVkIGVub3VnaCBwb3Np
dGl2ZSB2YWxpZGF0aW9uIHJlc3VsdHMuDQoNClRoYW5rIHlvdSBldmVyeW9uZQ0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBk
azI2LjExLXJjNCBhbGwgdmFsaWRhdGlvbiB0ZXN0IGRvbmUuDQoNCiAgKg0KQnVpbGQgJiBDRkxB
RyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVy
c2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TDQogICAgICoNClVidW50dTI0LjA0LjUvVWJ1bnR1MjYu
MDQuMQ0KICAgICAqDQpSSEVMMTAvUkhFTDEwLjINCiAgICAgKg0KRmVkb3JhNDQNCiAgICAgKg0K
RnJlZUJTRDE1LjENCiAgICAgKg0KU1VTRTE2DQogICAgICoNCk9wZW5Bbm9saXM4LjEwDQogICAg
ICoNCk9wZW5FdWxlcjI0LjA0LVNQMw0KICAgICAqDQpBenVyZUxpbnV4My4wDQogICoNCkZ1bmN0
aW9uIHRlc3RzOiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCiAgICAgKg0KSUNFLShFODEwLCBF
ODI1LCBFODMwLCBFODM1LCBFMjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBi
YXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIv
VkxBTi9WWExBTi9SU1MvU3dpdGNoL1BhY2thZ2UgTWFuYWdlbWVudC9GbG93IERpcmVjdG9yL0Fk
dmFuY2VkIFR4L0FkdmFuY2VkIFJTUy9BQ0wvRENGL0ZsZXhpYmxlIERlc2NyaXB0b3IsIGV0Yy4N
CiAgICAgKg0KaTQwRS0oWFhWNzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVk
aW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2Zp
bHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0KICAgICAqDQpJWEdCRS0oRTYxMCwgWDU1MCkgUEYv
VkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9UU08vSnVtYm9mcmFtZS9jaGVja3N1
bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgICAgKg0KSUdDLShp
MjI2KSBQRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1i
b2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0K
ICAgICAqDQpJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lw
c2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KICAgICAq
DQpWaXJ0aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQu
IFN1Y2ggYXMgUFZQL1ZpcnRpb19sb29wYmFjay92aXJ0aW8tdXNlciBsb29wYmFjay92aXJ0aW8t
bmV0IFZNMlZNIHBlcmYgdGVzdGluZy9WTUFXQVJFIEVTWEkgOS4wLCBldGMuDQogICAgICoNCkNy
eXB0b2RldjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9D
b21wcmVzc0RldiBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQogICAgICoN
Ck90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERT
QQ0KICAqDQpQZXJmb3JtYW5jZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCiAgICAg
Kg0KVGhvdWdocHV0IFBlcmZvcm1hbmNlDQogICAgICoNCkNyeXB0b2RldiBMYXRlbmN5DQogICAg
ICoNClBGL1ZGIE5JQyBzaW5nbGUgY29yZQ0KICAgICAqDQpFODEwL0U4MjUvRTgzNS9FMjEwMCBO
SUMgUGVyZm9ybWFuY2UNCg0KDQoNClJlZ2FyZHMsDQoNClh1LCBIYWlsaW4NCg==

--_000_DS4PPF00BBED10C14F6DA9C502073956EEA9F422DS4PPF00BBED10C_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>=B7=A2=BC=FE=C8=CB:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>=D2=D1=B7=A2=CB=CD:</b> 2026 =C4=EA 11 =D4=C2 20 =C8=D5 =D0=C7=C6=DA=CE=
=E5 21:19<br>
<b>=CA=D5=BC=FE=C8=CB:</b> announce@dpdk.org &lt;announce@dpdk.org&gt;<br>
<b>=D6=F7=CC=E2:</b> DPDK release candidate 26.11-rc4 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">A new DPDK release=
 candidate is ready for testing:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://git.dpdk.org/=
dpdk/tag/?id=3Dv26.11-rc4" id=3D"OWA8a0d64ba-1a88-2259-8587-612a9e6f4f99" c=
lass=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc4</a><br>
<br>
There are 44 new patches in this snapshot.<br>
<br>
Release notes:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://doc.dpdk.org/=
guides/rel_notes/release_26_11.html" id=3D"OWA0869a9cf-bcca-1d84-7db1-9032c=
e7d7d46" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://doc.dpdk.org/guides/rel_notes/release_26_11.html</a><br>
<br>
Please test and report issues on bugs.dpdk.org.<br>
<br>
You may share some release validation results<br>
by replying to this message at dev@dpdk.org<br>
and by adding tested hardware in the release notes.<br>
<br>
We'll close the 26.11 release cycle<br>
once we have received enough positive validation results.<br>
<br>
Thank you everyone</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">------------------=
----<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Update the test stat=
us for Intel part. dpdk26.11-rc4 all validation test done.</span></div>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Build &amp; CFLAG compile: cover the build test =
with latest GCC/Clang version on the following OS</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Ubuntu24.04.5/Ubuntu26.04.1</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">RHEL10/RHEL10.2</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Fedora44</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">FreeBSD15.1</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">SUSE16</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">OpenAnolis8.10</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">OpenEuler24.04-SP3</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">AzureLinux3.0</div>
</li></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Function tests: All test done and passed</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">ICE-(E810, E825, E830, E835, E2100) PF/VF: test =
scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filt=
er/VLAN/VXLAN/RSS/Switch/Package Management/Flow Director/Advanced Tx/Advan=
ced RSS/ACL/DCF/Flexible Descriptor,
 etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">i40E-(XXV710, X722) PF/VF: test scenarios includ=
ing basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RS=
S, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IXGBE-(E610, X550) PF/VF: test scenarios includi=
ng basic/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.</d=
iv>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IGC-(i226) PF: test scenarios including basic/RT=
E_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.</div=
>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IPsec: test scenarios including ipsec/ipsec-gw/i=
psec library basic test - QAT&amp;SW/FIB library, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Virtio: both function and performance test are c=
overed. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM p=
erf testing/VMAWARE ESXI 9.0, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Cryptodev: test scenarios including Cryptodev AP=
I testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Other: test scenarios including AF_XDP, Power, C=
BDMA, DSA</div>
</li></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Performance test: All test done and passed</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Thoughput Performance</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Cryptodev Latency</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">PF/VF NIC single core</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">E810/E825/E835/E2100 NIC Performance</div>
</li></ul>
</ul>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<p class=3D"elementToProof" style=3D"margin: 0cm; font-family: Calibri, san=
s-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Regards,</span></p>
<p class=3D"elementToProof" style=3D"margin: 0cm; font-family: Calibri, san=
s-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Xu, Hailin</span><br>
</p>
</div>
</body>
</html>

--_000_DS4PPF00BBED10C14F6DA9C502073956EEA9F422DS4PPF00BBED10C_--
