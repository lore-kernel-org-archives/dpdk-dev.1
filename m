Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B20CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 08:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FEC40268;
	Tue,  2 Dec 2025 09:17:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D0E02400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 09:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764663427; x=1796199427;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=XMWItZ7MHLzyIIRRfz01OH3dpYMx1j5NvOa9BVd6Jp4=;
 b=HpiXVKIvMuYeBUODLmSSpFVrFOCsx0fT8zsK4o0OEEY1vtNtkpAwpoTz
 nCiEeQy8HEUXKiQnC3j4j6XWzHXca/qIbFK3qgDzGiEz2bYAaBzMVUXXD
 vpP15EHWndFoubR2cqsG0Mq4Fme5HHTfegfYlJ+4akr0A35GtKxuMW5D0
 KzEGgBph18cBhfK8yqvk48tdwyQoGIgRxxY2fG0nMUAQdFcP/SrEr9xTH
 9FpF4sOCTKEhZEZ8RiAHwgTmzUhnuq+RL2GQfo0ztBAizsne35Rxh61W9
 9eVglNv1FeZDmr/rSXwCscQdn7bpyDCaBIKmUCz7ZYgzARHxkqAjgKIVr w==;
X-CSE-ConnectionGUID: I+WUyX2ARWObuv/HqlC3ZA==
X-CSE-MsgGUID: yvFcSR8qRLSp62RFkhYKiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70470544"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="70470544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 00:17:05 -0800
X-CSE-ConnectionGUID: IH2sx639SsistaeBZc1QNg==
X-CSE-MsgGUID: oiDL6SbHQpKe6T/i+qhdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="194301047"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 00:17:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:17:04 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 00:17:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 00:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0YG6gR6KFtHLsegEoPFlagzVXzS8iyb7N7Evic2vAvXtrG4J5Xyo7Yaa+l1gDGWPAskgIz9acEz9pR95TPIjZKUcMpcb8oJJyi5L1XaLzfjCgfOfGvxdxDVk22PMf9uYHxnZ4XSoGceB+J85z0t9X6uk4/QeUd5YkKCIoZlWNJdeLQgIV1ts8PagsMvnZF4JS7f7SQY7VvD21AIdD7EWZIZg4TWxJb9a1sfg5gYPwqW4dTSrxkgpRLT3EgY2jJ2r9Gm7AVPztJi/ayxYkRPkInORizNJBNkv94+hI+dKlTmJ8QDlV+5GBRcTK3aoL/pi1ue1BqMXuRedJ2UGC7EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCfH/cve7N3JhuNQtEOkVnOzeo6w58+1TUq7nkl1Nnw=;
 b=a2oiHZoT6PwZvzHJkUaMUYy5nxKO4ZiN5TY4WIS3k3jCPRnlwuam6t4GsWOT0y+xjn+G/3/dL807nNGv6mPjVAFGUqW0amsC9u/aTUtFDdS87ONGmX7dkElxpvCrBNMSAn/gq/Tn1HMvpo599/cZi4/vHp6ZoFF3n+5xwxaKa25ZU3dMTzBgn0uILmgV+PJY3/DZQbkc1eTGoeNy9tLl+3iN8hYVwqz0szM/+HqH+nSpJSZSpn3VNHmYK61rFjEJjtdlu2zCT5yS5Gsh3safgcJ6ketzLhLyJ4+WobRO2ecgQd9CqX4ByPo+HRxoh+qHAfWRbrTnszOhk0y/GiOggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by MN0PR11MB6255.namprd11.prod.outlook.com (2603:10b6:208:3c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:17:01 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:17:00 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Index: AQHcVq02Q5MdAwVwH0eQQbAZdQUWgLT07CkAgAFoL7CAAD5rkIAXXmCw
Date: Tue, 2 Dec 2025 08:17:00 +0000
Message-ID: <CY5PR11MB6116A4601EB74D4943216EA2E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251116035749.45922-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
 <CY5PR11MB61167F082015E76C562C3635E4C9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65566@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65566@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|MN0PR11MB6255:EE_
x-ms-office365-filtering-correlation-id: 4f7b51fe-035b-48bc-67fa-08de317b2b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3e+jCwl6xVIHamIS/i+VDktgNLL569ENyoPid5Baq5j+uP1KFs6nJPVjYm?=
 =?iso-8859-1?Q?kGLkFrfVryB269FIP0lNzgq4fqo3naPbRZ6gAvUO7DSAsE1GbP7Z/prBby?=
 =?iso-8859-1?Q?S+NZdPWw9y+Hg1WQsnKhnkHpHR3NzPkUbIpADQI1dvttRGIXYCbX1h4xuC?=
 =?iso-8859-1?Q?zsIa9RW2iRd/NelaRzDb7Ijx9tDY458vScMTR81aE6GA5j6iMdzSfGbuaw?=
 =?iso-8859-1?Q?t1tCyD17JuvFv2JGWUEKIjWTNYFGGkSQI54QHlTIdsXDeOd7OqiE+YplHL?=
 =?iso-8859-1?Q?osK47e+i2T2s0+Lekl2gDn+R2L9a8Y6IrK2TNeM+Ccnbxx7OOo5SWr0D10?=
 =?iso-8859-1?Q?wZDx2qYeJuqazehVVBKn1m85P7+DAgs0ATIviGTN+6tI2GGQzzqbMBwqFc?=
 =?iso-8859-1?Q?v0nLD8qTQsghXJxHWsCjt37dTFpCrq4Tmm4SUf3p/x3RLcPCfbB1wFxIN9?=
 =?iso-8859-1?Q?0dsFsAC+HnDY4xgukGGrw9O26u1mmzi9icdGsiwO2jcCvKcWUihtvLqM0J?=
 =?iso-8859-1?Q?TPNDEVHHi5YOlUNK5ujZjVpUJGCJ//OPF1DN4QpMZJafKHbDgRkhMZ7qDD?=
 =?iso-8859-1?Q?/Fz2oSeDqEdFE6uoCfE+9hks5gxQa8AV+0pkbVC3Ihe4Xp/f3di7zmK2Ma?=
 =?iso-8859-1?Q?BghWE91DpFw8bvYs17a7m+V7v6tWibxkPni2ZOyusQr+v5ZnAWpiR48M3F?=
 =?iso-8859-1?Q?vIqcgqOyi8ALgu0ky93YCHrh8bSoiZxLvaEGuqJ3HQ249+vg3HhhG1ZbQP?=
 =?iso-8859-1?Q?ssy1Nc3CBdC1l2112OQsnK3OgmZzubjsjVDKuvyUccZ2E4gIcb8caRHE81?=
 =?iso-8859-1?Q?GvgNWWEW31gEsiBoN4Gx3P3P0LCvpU/edJsqYTLzw+9DI1FKc1r2t15vVq?=
 =?iso-8859-1?Q?MTgrOFzGwIlsUVkzSMa9rD6jiwsYHuULcuaeax8Odu3DtjvCw3KxA9mrR+?=
 =?iso-8859-1?Q?iU/7qzJ+566d22F4X8PsH/JIBoiRJzSkglQPpsUG1C8MdNH4EjNJVaIW4X?=
 =?iso-8859-1?Q?jk4OjXS0gblg0Mra09K9T89h4NK8FI5+6k0olCR5ca4r300PXEgTJz6TCH?=
 =?iso-8859-1?Q?Ulgn8Qe7LuMYiytT3AI0y6Usvzb5tWf1rI9KAZBL0UWq6U7dqZH/2DtfbR?=
 =?iso-8859-1?Q?xKW3wVD9t2OZT9YknGrl6lZIRW0pSH3wRkncVfXCnTiURCQPH5j5ksvska?=
 =?iso-8859-1?Q?J4TV+BjS9DQv2GKcjqObH7eB0SOUmnfExOpvP42jVnNndzymO8bpnRMT06?=
 =?iso-8859-1?Q?qKmFMQsjvcEgj3NRdET7ivJLw8fOLDP4VQrHXfgkNpWLxlXMuhmwEhlV9C?=
 =?iso-8859-1?Q?E7XvR0H/Iper3tzT2Jvt4f6vyhAbZpPntfSY/j8jzpYgVyLPPDebwSt0fa?=
 =?iso-8859-1?Q?Jwf49G6u40Qr2e7ALM6hM24wzRpUUCrQE2x8mm6YqA5klnE9WLpowEdBWB?=
 =?iso-8859-1?Q?8lTJwx9x6dff8Ot6Gd+TI0iOmpU/wQgrHJPhVoPJkCGJ/I0QMN6dcN+JDV?=
 =?iso-8859-1?Q?wvY6XQIB9vj/UuKmzkKTem3N+fin/gvbM4iQCHjWSvHg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8SXsrv52eE+DJpzP9FQ17YCZImx7LX9CmksZINiE0vI1PZ3yaQujaueh+B?=
 =?iso-8859-1?Q?jVu5+DSFjcdseLj99KV6bAmj2vfL1o7J0HWYGSUQb6RBZP+yz1lCerN44u?=
 =?iso-8859-1?Q?/ddYEwpgAXTiGHQlBksSq1QBL7W5KzkfXLj2A7wWrh7FjLrN9hTRYIMJ3U?=
 =?iso-8859-1?Q?m320s932jDR4MCEFVR0p+hZteeZ6AH1FVoTFTgUizQgJXO6IQ52DrvWBC+?=
 =?iso-8859-1?Q?VI66BOL+WCaY2PjfuZzxN8npYWfmqHXZhx4IXXRmAG2NNpGe5KEaec9PkZ?=
 =?iso-8859-1?Q?iJy9QfLO1MGNCMDBpX8NpmfKvs6hZ5NLK2S3NK3xvYhXfWWJ1icviRo+el?=
 =?iso-8859-1?Q?8u0xYjBbS8pdv8xjClIDfVqNFTl6QAXlKhO9frxOKhahwmEQ2hri+2vBGt?=
 =?iso-8859-1?Q?rxUrUx87/jDVui4ehkQ1wmr9z10zDzmYa25lQ9F7INWSx7mCu2Jel44FlG?=
 =?iso-8859-1?Q?pXgSg4UT/Lzer6JMldw3U1t2n8sbRSdtN+D0GMfG0SMWfEcvBVuAbK+ZPY?=
 =?iso-8859-1?Q?ulRjs34qfpKA6RV1HCZFUozaxriAxa0UVW9bMg1unOidUR/JsZ98nhllrh?=
 =?iso-8859-1?Q?CSkHHkK9sL0PWb5hNNsmUJtoV/014NdX2JQZHu+24SqzOdMpEA1YG7d1nZ?=
 =?iso-8859-1?Q?9J6BuX9cMQKmsX3oSx2vIwCTsqYZvghbAxi+ppGTizc5eSMtOvZsvcnQ4M?=
 =?iso-8859-1?Q?p9rFhu/WVVYEQgC/fWaFaIaGTh8guKpTvjCgRwZW8DPLwn1nk3400OkHFB?=
 =?iso-8859-1?Q?ivdiRZaoizeFW83THKKYCPbi7cdCilK+1r75z+jMbvbWSYHNoHXMvR7Eu/?=
 =?iso-8859-1?Q?xzuPiPugO06EuBcgCeUNkGM8Y2qnO5jZcdg7+u/xVGT8hB8y7TpqWQMsrX?=
 =?iso-8859-1?Q?7EjwQs8Kv2fWgwqEv+0gqxU6k70COJgKwxeuGMDp+E9eIKv5t/C5ma3Cab?=
 =?iso-8859-1?Q?xmWbuOQrZVABtP61ve0B15BMMNkXWitfRlj6iipdgoQirQ3eID5jTVoSeo?=
 =?iso-8859-1?Q?RF45beb/6FZkzQUk5tA+7eZQ2kAqQPb3Snv5XKV//57PJ25Oxp9CyawXRi?=
 =?iso-8859-1?Q?kuxU86Bxwtg6oS7NglQKib3Ee1F2A14zPAVHuXygj2nv0O+AlWZv7KNqo2?=
 =?iso-8859-1?Q?alLCE/S9+lw/bUcp3taQa0nvjmGBHg4oxCnmT81FDL11ocNdM9OAoCuyZ/?=
 =?iso-8859-1?Q?VcFLPyrxAUOY+x0bWQgxhfb4jPXySoIxnb/FiCpzmHwufsFAz1pCiXbKb3?=
 =?iso-8859-1?Q?xqbUc0qgqpT4F4TZHBtO1BlSUFvBbErdYMOCqiBtmD6cNWynTTSJXx5Nag?=
 =?iso-8859-1?Q?B7cjxRQug9/6zHt+gmTDq2lWpL4eYrBLQ3AchkKp/Vs8UpC9Ye15UUTotC?=
 =?iso-8859-1?Q?rkH8SSH6vJkxUsjKsqWp+Y+7pmwTOq3KrGbIbkmjPpTplXIXEgIoaFBHLV?=
 =?iso-8859-1?Q?uiSaJzc9jd9nfi/h1CswPMlpZyMW1BuDEAQIgEPicgmX4gsqg0kVc268sK?=
 =?iso-8859-1?Q?LjEXPP5UqZ5EnH1Y5KejiIDlEE6KoRk3MmJwjFmUbI0j8rpulLunmOzV3P?=
 =?iso-8859-1?Q?3Ym6mandML2FgHUizKgARf9UeK2sUwe8eGTZQNoYsSyvGB4p7J/YCsFQSI?=
 =?iso-8859-1?Q?uB5ILTeeQhxKLb3uFUU9QiDzr7qe/7blda?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7b51fe-035b-48bc-67fa-08de317b2b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 08:17:00.8088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/Il8D1A3U79O1MXoy36GeoI1/Oz3sFfo4h2PHtOeMzEFPPqznAKmw379v6P9vgDOMW6aWxzf484yN3yiBJsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6255
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

Hi Morten Br=F8rup,

Apologies for late reply but as the patch was deferred from DPDK 25.11. Hen=
ce, I was waiting.
PFB my answers.

Q1: " Please disable anti-spoof filtering by default, and provide an option=
 to enable it.
Like source-prune."
[Ans]: MAC anti-spoof is enabled by default in kernel ice driver.=20
Hence, it seems a better idea to make it enabled by default to keep it in s=
ync with kernel and in terms of security.

Q2: " Is support for "vlan-anti-spoof" in the pipeline?"
[Ans]: Not sure but " vlan_anti_spoof_on" is present in code.

Q3: " What are your thoughts about the generic Ethdev APIs I suggested, ins=
tead of driver specific devargs?"
[Ans]: It is unlikely that a user would want these mac anti-spoof/src prune=
 to be set/reset dynamically. Hence,  it seems devargs likely be a better s=
olution.
Generic Ethdev APIs is a good idea but should be taken separately as it wil=
l have much beyond scope than this and would need significant effort.
Also, that again bring the dynamic nature into the picture.

Thank you.

Regards,
Anurag M

-----Original Message-----
From: Morten Br=F8rup <mb@smartsharesystems.com>=20
Sent: 17 November 2025 14:36
To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Richardson, Bru=
ce <bruce.richardson@intel.com>; Burakov, Anatoly <anatoly.burakov@intel.co=
m>; thomas@monjalon.net; andrew.rybchenko@oktetlabs.ru
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option

> From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> Sent: Monday, 17 November 2025 06.22
>=20
> Hi Morten Br=F8rup,
>=20
> Thanks for your mail and review. PFB my answers.
>=20
> " This is the same story as with Source Prune.
> Please disable source-prune filtering by default, and provide an=20
> option to enable it.
> Also, suggest shortening the devargs name to simply "anti-spoof", like=20
> "source-prune"; they both operate on MAC basis."
>=20
> [Ans]: Source prune is disabled by default and option to enable the=20
> same has been already committed:[=20
> https://github.com/DPDK/dpdk/commit/980c840a646a2c8ae49a291c17baf20a74
> f
> 36086].

Sorry, there was a typo... I meant to write:
Please disable anti-spoof filtering by default, and provide an option to en=
able it.
Like source-prune.

> I also wanted to shorten the name to "anti-spoof" but I found=20
> something called " vsi->vlan_anti_spoof_on" in the same file.
> Hence, to distinguish between them, used "mac-anti-spoof".

OK. Then "mac-anti-spoof" is a good choice.

Is support for "vlan-anti-spoof" in the pipeline?

What are your thoughts about the generic Ethdev APIs I suggested, instead o=
f driver specific devargs?

>=20
> Thank you.
>=20
> Regards,
> Anurag M
>=20
> -----Original Message-----
> From: Morten Br=F8rup <mb@smartsharesystems.com>
> Sent: 16 November 2025 13:14
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;=20
> Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly=20
> <anatoly.burakov@intel.com>; thomas@monjalon.net;=20
> andrew.rybchenko@oktetlabs.ru
> Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
>=20
> +TO: Ethdev maintainers, regarding new Ethdev APIs
>=20
> > From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> > Sent: Sunday, 16 November 2025 04.58
> >
> > VRRP advertisement packets are dropped as TX-errors upon=20
> > transmission from a vsi of ice PF due to MAC anti-spoof check which=20
> > is enabled by default.
> > There is no way to disable this check in the Tx direction to avoid=20
> > these packets being dropped.
> >
> > This patch introduces devargs "mac-anti-spoof" to allow user to=20
> > disable MAC anti-spoof check. Disable MAC Anti-spoof check in the Tx=20
> > direction to avoid getting dropped as TX-errors upon packet=20
> > transmission when their source MAC address matches one of the MAC=20
> > addresses assigned to that same NIC port.
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
>=20
> This is the same story as with Source Prune.
> Please disable source-prune filtering by default, and provide an=20
> option to enable it.
> Also, suggest shortening the devargs name to simply "anti-spoof", like=20
> "source-prune"; they both operate on MAC basis.
>=20
> Let's make something generic instead, to replace those silly devargs.
> We have individual Ethdev APIs to enable/disable various Rx filtering,=20
> e.g. "promiscuous", "all multicast".
> Obviously, we don't want to introduce new APIs for every semi-exotic=20
> filter any NIC may offer, like "source prune" and "anti spoof", but we=20
> could introduce a set of generic Ethdev APIs to support filters such=20
> as these, using a bitfield enum. E.g.:
>=20
> /* Enable one or more filters. */
> int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);
>=20
> /* Disable one or more filters. */
> int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);
>=20
> /* Get bit field of filters enabled. */ int64_t=20
> rte_ethdev_filter_get(uin16_t port_id);
>=20
> /* Get bit field of filters supported by device. */ int64_t=20
> rte_ethdev_filter_capa(uin16_t port_id); /**/
>=20
> /** Destination MAC must match NIC's MAC address.
>  * (This is the inverse of Promiscuous.)
>  * Default enabled.
>  */
> #define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
> /** Multicast Hash.
>  * (This is the inverse of All Multicast.)
>  * Default enabled.
>  */
> #define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
> /** Source Prune.
>  * [Insert description here.]
>  */
> #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
> /* Add new Rx filters here, in increasing order. */
> /* Add new Tx filters here, in decreasing order. */
> /** Anti-Spoof.
>  * [Insert description here.]
>  */
> #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
> /** Used for error return values which are negative. */
> #define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)

