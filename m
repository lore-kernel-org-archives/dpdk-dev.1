Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417DC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 03:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802924021F;
	Thu, 29 May 2025 05:36:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id AA06B4003C;
 Thu, 29 May 2025 05:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748489797; x=1780025797;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3nKVYN1rOXT0Svf9Wg/Pu7aUFG+QowtAtFcu/RgBJqw=;
 b=AKHsiTzxxLuHLNT6+YRhUpUc7XhjSYTjqUGuHGE0F3ybWwldrXQ5z0x/
 cgrCV666+vBSSzt/CplYHKPJkwuLFQ7u1wAdxktyFswoA9/rcYVrS+m8F
 Oeg308nHVO+9b3R8YGzIhE0Jmp4k56YqnK9AqjOZzw1LqutkKm5bRWMU/
 qwMd82SdJnMs43VvVusvYR2X6zPMKw6nLcKcbXshZ1392sc6owo9zVagB
 +PrUD+vQ/3j+Cx7ww4uQwMi3Ma70Rb7P4EDAVdWCJPq9JVSy5YIYQYp/g
 shERuVk1U81JNRJ4crSKsY6bkM0is8ZpBGJFB8amofB2xoTWK79rzYqPG g==;
X-CSE-ConnectionGUID: UBS9jWAOSRuUHOzzk44IVA==
X-CSE-MsgGUID: AEq8P7JvQCW8Iwk0UCT0tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54332599"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; d="scan'208";a="54332599"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 20:36:35 -0700
X-CSE-ConnectionGUID: aMbWKh+JTpuELrB0qL3reQ==
X-CSE-MsgGUID: QwCViF1GSgK68bsMAhskDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; d="scan'208";a="144423213"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 20:36:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 20:36:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 20:36:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.44)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 20:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXZzbcmffosuV4gj31Yd/5TyCyrrf3DPp3ALdReHrEuBxymzEaIPdShtEQMr991c4/gBPJRcWtrtx3RKVI7zLECIgHlX2SDxpF31hHn3jF11R7Rkr/uTy1f1p3GD+AADo0LH90VKaH5UaYJOhtH7mDbw0QI6kLmT0+E7rGcdHpL126NR2Sw1kvkhpxw4FVRC9E/nkJ6VkHPqHgzJyPs9tOvHaFiUBy7zG8IYUOlSDAW2OCxmbq/ZsemWKNfuam0j8Zb8kuLXlKbv+4cOc9woyaTPiVUV56sd9q9jbKBqORnIQ6RKLOwgXta47EYhz3fIYD82ccuHQSYmxuoJNPsm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1VDL99wmpR5fxba2b/IWhOm6DdV8BqMblFtLR7sUeU=;
 b=EUhO+ZkV78UR0fEux0Qh/o0lIIPVjvzcp8seHY1YI6tlaKJkTOfbN28wDlRiubYPLzeZRRROwfIRSZ1APrmlrHJBuvxBjUFfUXePLVeRGYH76mIXwejg5/yT2Y8WUgZ1WLcI1dvqXloKO785F4p4aq079ctK3rDjJuwIvaDKLhmLAoBmmc9//1SaZ6DZjzyqAKVKCDmKHtOBkSQ+EPSk/Aw03hLzNxvyDImsOQ4sHJ6S62rNI9u/dNsRNl+OBQ56kDQyF97fZXuA7ZDmHVTcUM0k0PzZSDb46HQ41lxG7q0yJScVETfCteT8FgFbqEl0vnj5bUBkzlXQZ4RyUN3/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 03:36:10 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518%6]) with mapi id 15.20.8769.019; Thu, 29 May 2025
 03:36:10 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] crypto/virtio: add request check on request side
Thread-Topic: [PATCH] crypto/virtio: add request check on request side
Thread-Index: AQHby+vGTXr+VruBA0mqyisV/oiIFbPo/SCQ
Date: Thu, 29 May 2025 03:36:10 +0000
Message-ID: <IA0PR11MB833668FBAD20C96C45555DE1FE66A@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20250523140450.75543-1-radu.nicolau@intel.com>
In-Reply-To: <20250523140450.75543-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|PH7PR11MB7027:EE_
x-ms-office365-filtering-correlation-id: f08b7a00-8c9f-400c-a0b0-08dd9e61f43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WLWVTm/O1vH0LJzCvJZp2NtKRkosLR7Eu5DfdzqrV0eXeVLJJU+ZUBkpMqcB?=
 =?us-ascii?Q?1Dps04UhevPRKR5w7bDbKyidUmMsN9pWIgEE2iyvVaSbjvHRRHajxL9g8v+0?=
 =?us-ascii?Q?TYTRuzUW2Ro+W0Hp4l0uWtlreyOAHQpgEqi1Eme2XD6oBV1c5qAHXVEvh2wN?=
 =?us-ascii?Q?cLdUgDjaprEs2s9QNBy4rPP/v+d0Hrpp30gXV94iFWtzLSs3lRYUCWCins2Z?=
 =?us-ascii?Q?PUE5AzejkLMtKbYnVodqRy17YwZa0Gbq5xFYPNM3eLoSFFCu4iwmdGrqMfTP?=
 =?us-ascii?Q?UnngNyKwM3ePIEsACQJi2mmFCkuGyvTc7MSVYWX96/sTttFQGZ2Uozktq2rw?=
 =?us-ascii?Q?pYDpNpk9u50eRsQxLJG1yDnUY86zNUvDd2f8n9N7caICIGQFhA5VSru8x/O0?=
 =?us-ascii?Q?DI1cKizPnrPTWZFn0r3OwcQvSc2cWcSsxYeK1D/vArLx2j4FWZleKc8THXXI?=
 =?us-ascii?Q?Xqwppc0jR9u7XKNlZXR4UR+eSysEUG4iQJDkI+AgfOSGugrlN51pfcc+RWS4?=
 =?us-ascii?Q?6aTyRDwpZg1iQqhEPxxDyaoIM090NDv/AftLY+uG6kmJOX7hclGr6cwW9WcB?=
 =?us-ascii?Q?tUKftfRyH1BhNhoqc2quMK345gsUB8LHwhqjNHImn0IuAMjaeSQLTITujkEz?=
 =?us-ascii?Q?MxydXuDFBs89TyxdAG8YpAvmQmLD7sXXQ+hGFXLyYzg+rEEtZB/cRpibbeV+?=
 =?us-ascii?Q?tiEylgH0FxCdl8IGpO/YE7gQ0PlO/AOsH9t/+L8rqiFAQSdD1QzBMbu7I43W?=
 =?us-ascii?Q?lfwSjT4ch//wPdyD9WGXSeMBoMpKosDg0pJ9FKhHbm1V74ZnYqHLwevDquER?=
 =?us-ascii?Q?HU9LKnBvMUe6CqgLxkCoj93fu4vHqty02alU8CplZgZavNkzvRLZSDUuHnEI?=
 =?us-ascii?Q?vzWeTZrwBzZ4uM8x97yIlFAUu2o+9ntLxO57KvgL+waAomGg3EoEM1p83MjZ?=
 =?us-ascii?Q?23Fv/kbvzSBKOPG8R9bT0L80fxqijJGxheVh9RFAG3KTVaDfnOzfeV++Uakn?=
 =?us-ascii?Q?/ONRR1Lrmrh5KOAdsVqm9av7hId+f2/2ZQTyeQVqDxoyZXKY0cbrHwetOhhG?=
 =?us-ascii?Q?vurGC5/E9ZGL5oQUubhbtT5Z2XDcdo9cIM9rX0KPFzocxI9CP4N0vutiV3bn?=
 =?us-ascii?Q?ZTc4Fw0M43bLuoEhi6fD9sPB5nHQypoPolGr2tO02GWCxk9goNVU2Nsclbnv?=
 =?us-ascii?Q?tWT9ZKvd3NqRzyXqwiCs/LIKsjWIw0cOr6CxxOpbVNn4LwX35PFW+HguQ4m0?=
 =?us-ascii?Q?IaFvcbvKsanZP0zrgxK9t18c0ZnWIGR08MsTO0lwf6LgFnMeAs8dOEEzmuYP?=
 =?us-ascii?Q?bcecRuu3nsl5QnkPpS8BJNXzTv0tR7UMCkGXu6iI8Xx4DTp50f+mDf875yv1?=
 =?us-ascii?Q?UUJe45u+xiuEryqCbLikmtP7DtUguNl6bA65Toj/5cu7FNnAMbad9LWjXEpI?=
 =?us-ascii?Q?foqeGCpl3z9DOizs/G2J8ifGpJZ58l8Bjev8HzGjX7esmkf48/HfEE05zuXB?=
 =?us-ascii?Q?cshpvuDt6rOsKwI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kq7NZ1qR5UOpXUXfyjZ6R/mfCtnxflv6s+CKOvE364nnlV42XLunc7bVrRfJ?=
 =?us-ascii?Q?GkMo65umrpXNwWEAMZAEYOQoDxWJLRVeSIAqAEDuN/wHNc6Lzu8br7k8ezqR?=
 =?us-ascii?Q?dbj4m8ajItn3VS1/grlD6kJfSua2k/oIP3Qw68QD6i6oLBHFb7p8Oq/fVoaG?=
 =?us-ascii?Q?QF9LUDvRyqm22zHcV7kLnhx3J0eWcje2M5YemqbMqvBGNT1Lf2RFkN6so7xj?=
 =?us-ascii?Q?VADcmOsPCfij8lCuGOQGVCS10JjcOdYfG//a11ANCu9befI56fXQouvACmNL?=
 =?us-ascii?Q?xNS3GNQoTtNZSl/WO348zJEtVWiYFsSgaxASQJxy/DDU9YZDVRLs/JwsjYO8?=
 =?us-ascii?Q?eqlVBuVywaZPEBlisK4XwSdqSCmNAtJjbHNVE9nB4itXoe3BkQdNqUmOC+a3?=
 =?us-ascii?Q?0ZSpdKz01xrQe1lP/wlLFVco4b3/GIa29kG+3zESfDE+bSPBxJDq3rUh+K8a?=
 =?us-ascii?Q?lMHohxNw3lKPnE29zO0U9210p/x+RkcPDomAS3msSpapxZR4nvybmxbMKjMJ?=
 =?us-ascii?Q?zpgQhyPFzD08QRX9TVM43GwxsEkC2Fz9dVxXCuQ1PaPz4C3Mz1Ar+gahnyhG?=
 =?us-ascii?Q?TNBfR4zAbQtmOHIDJFDXth+Zy/o3nh4F6IvsCvN+rMbi/6R1Zx4RneM16uxM?=
 =?us-ascii?Q?cf18Lkx5ODmVsMSz9BWIPYi8+nw1sZ40mdI+8HVTpAuRlzvFZkprFnb9shH3?=
 =?us-ascii?Q?54EQbxvzoIy/GlApoBCBCcgBrPhqJehzxtpgRHosH4bH1K9HFciIS/lltMsf?=
 =?us-ascii?Q?+NVZHKg+lSdggfmY6YaVCAJ80+wPH6wpLNdfUtaMo9lAmswk4xwrs1A9dSxG?=
 =?us-ascii?Q?sOX4OCMu/ys7Ou8J2JVc+3iX8OK6g5zIo01CZhpqOqgO9QDQ4KK+yZfhIGJb?=
 =?us-ascii?Q?h3zRJVkO6So6VLyTXRBv8XZN0CXi5TxIIxDwbAE4AgnRUG5JOu4/b/3EkvZe?=
 =?us-ascii?Q?HQt0T4+MHBISSxLJ09J0BpAjI0nkQkPsCFB3UyFWZ7Jtmx4D43ZU6jBdKEMj?=
 =?us-ascii?Q?Z10Np1wCZYveiDfDQ8cAh+t0pjPhrSzHe3VRImVULhiScQpahOz5r0HotHAH?=
 =?us-ascii?Q?dFTVmaxgtCB3UNiWHv/JxADljM7nmwNIFU2Gd0mwVTcPdbBnmTrrdNmMWEoJ?=
 =?us-ascii?Q?QseB3Vpk1tfXla4/oRxN/brH549MD4ZnTa1ecOil6kVhCKttKjYRZ4nvbrdf?=
 =?us-ascii?Q?uJyG2R4UeNR7z5zJzAEyK3DKhfcBdsFGYqDVt8ZSFhk7XhpkgbjBcPvJ0M+S?=
 =?us-ascii?Q?r2YFPQovytWnWVFrrBfag4xaKvZW24iQ3/LhNS4tycknNIbe0do1ubQteP9D?=
 =?us-ascii?Q?ZSBrdwsnwER3KuVet/vuOY1UFQtVY+K+c8KfkB1OUMUR6JMCTV3Vflll3ppK?=
 =?us-ascii?Q?bYNPy0b7U5D77Vi1CNQ+3ypE/zfXxtHQoRYxm4xxKdPZTB3UQQ+0DzTWQYKx?=
 =?us-ascii?Q?LTL/wsHRs0M6ie6DQnent+qlKtuOGR9XU6H6WrygNjXyEZLy7q+oVmEdUPvc?=
 =?us-ascii?Q?ISMu2ULPy3HNuVtSvqDhZxAxKCu6Oi9Y0G3suMR7V1ELKHTl511zjY/tuOZc?=
 =?us-ascii?Q?GSt8LbxPxT++vp4iAQRQ3RIdhI5/D/C5PIG4ZCjb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08b7a00-8c9f-400c-a0b0-08dd9e61f43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 03:36:10.2746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWfU5zLnna3R8fgWWMQNL3+vS+itPdy2HO5SFnzKHBb8zZqEcxrM/+btINoT48TjUFl1d+GSJj3g1FxeWdQl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
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

> -----Original Message-----
> From: Radu Nicolau <radu.nicolau@intel.com>
> Sent: Friday, May 23, 2025 10:05 PM
> To: Jay Zhou <jianjay.zhou@huawei.com>; Fan Zhang
> <fanzhang.oss@gmail.com>; Chenbo Xia <chenbox@nvidia.com>
> Cc: dev@dpdk.org; Nicolau, Radu <radu.nicolau@intel.com>;
> roy.fan.zhang@intel.com; stable@dpdk.org
> Subject: [PATCH] crypto/virtio: add request check on request side
>=20
> Add same request checks on the request side.
>=20
> Fixes: b2866f473369 ("vhost/crypto: fix missed request check for copy
> mode")
> Cc: roy.fan.zhang@intel.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>  drivers/crypto/virtio/virtio_rxtx.c | 40 +++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
Tested-by:  Yu Jiang <yux.jiang@intel.com>

Best regards,
Yu Jiang
