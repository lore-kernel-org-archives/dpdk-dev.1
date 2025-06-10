Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEBC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:53:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F3FE402D4;
	Tue, 10 Jun 2025 13:53:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A2D954026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 13:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749556419; x=1781092419;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dclzkXnMwZSO196AC6sWou/SYDSMBYJezLt9jwXsWzI=;
 b=gLvy3iLf8dG/1jm6fcYmoOSVgcSl0w3SXc9aRXAsjAGTkSGmzit5ilzN
 Pdf1USwJiwEfoDpU77JiLwYn05rekW3mDmVgrwp/HLmE8CCO1gkyGHWKr
 1/yeAPKQMm5CjZvVsa1stl/qotAefDCXHyXbOyY5K0JrQqZPxZu+CHH40
 y1dt+qoYAZ8idijrZrgLWEnwzUJIfjTxccKu/Krh9gb9DwDY3w4CHUvhn
 0IccB/z+8QoqJsEyxTb8UkjYQtv2j6rA+FF6xj9RGq2K5xZz+Svu84KTV
 xpJFce4BCwPUNUoX9nEt0lgeyxlcA0EbeUoIxcKUHx6Pk93MY+53Mc1wr Q==;
X-CSE-ConnectionGUID: mkTd4gw5ReeVbDrZwZALQQ==
X-CSE-MsgGUID: OePQOcdCSXy/c3JM+51IaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55327236"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="55327236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:53:38 -0700
X-CSE-ConnectionGUID: VkamzN/QRTO/ODmyZuUKww==
X-CSE-MsgGUID: t6Ykju0GQOK1xEl0w99Ktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="147328504"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:53:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:53:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 04:53:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 04:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8TrySS4eGAPEe59hKKD7ZMuoRC/bApErtUXIc9ZGxxFAmDBU80lazAm9mdJ6vowIQDUmW1ZqADNroIhHDKtwpFggV6vSkShD0gUYv9g594uNxDttroGMqlW2qE4bAYQwzbwL/8YqG+uRx8sE6wxrOXcQLqH54ZQPk6FLZdh3sZvAAZDdluE+S5CGi9VSwe7UtYDAaQdUwiNhwCgjdmW70Z/FYYXc4ap4lk/MdurJoeSA/MXsfC7VDJpaX/AUwzsE4KQ1doO8RDqiJF/GKHM4plnCngDlYBk+JeG8akm7my8o3UoUa0O4DZzSCKxES0VLcE7AYiw99FJ0CpPSK1wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwKZyhjHj5nmGU5Ojb75tOFvvN+hKbe+/hmoogSGpG0=;
 b=QuLXxnkJu85vbnyhYtYMw4ZA3vopNttEIcDSpiJVKgx8c0rsMK+pa331Zz8waupmyc9P+QZnvBZkpFAVBAyFOhD2tJEFMPpgUfgIDNs9ITB1FCnOac1PmMXeZYorqHvuYltP2tbHXib4cj2zDSW4q57T8T4y0jIsAdNwaws2lfLm2iX43VPcUp7gTeisw62SWIR+b8q4l4X3sNNl5eEqYXk7SJlm3bASaUfrFpCxuxltc0JdpFHROFREXx+O4gV4L4X0nxSOEoO3LXox1emkCqgFheg75daoaI/s/ul4AoicKFj9ebgsjBtFPSggS3WppsnmGygYtpRrW3tYR/4W6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 11:53:33 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%7]) with mapi id 15.20.8769.022; Tue, 10 Jun 2025
 11:53:33 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Thread-Topic: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Thread-Index: AQHb2K2BfAp3c5MLy0yB9pKJYCkidbP65x+AgAFjhFA=
Date: Tue, 10 Jun 2025 11:53:33 +0000
Message-ID: <CY8PR11MB7747275A47BE682B7A55D300F96AA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-4-soumyadeep.hore@intel.com>
 <aEbyBWWVn1IYv-_I@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aEbyBWWVn1IYv-_I@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|CO1PR11MB4834:EE_
x-ms-office365-filtering-correlation-id: c9a2e8ed-b304-4fe0-4140-08dda8156cfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?japZlQF/zzKsGcSK+HIXeb+T9ccW0pQlHSx1ckzHKvswM91YwvSAwYeJstvI?=
 =?us-ascii?Q?GqNUjgSAody+RDTh2BocTLmcXeBw9cWltr+TuJLsADZuowISn5e4LAGnwyoL?=
 =?us-ascii?Q?QN+SI8rAsoQuj6KUC2dYx3s9/XnkQPmX9XtrVbPUMGe+lDwyalko25kUjYzv?=
 =?us-ascii?Q?9eNksKBnaaOffh8MCokKlvGy2JcmDMH121JC7spvaRbhE/XcxuqOqt+EsZEw?=
 =?us-ascii?Q?tnC9jSsOCL7fRW1gmRgraxhq89Dcx1zOb/etwbKOlypezyImpA7ROK3ayO6Y?=
 =?us-ascii?Q?dHNoUAntCPzKPTXrUyBwqftWBJ/phONIC9o2KcmIl0Jkp0Kr1xmJdb15GO4e?=
 =?us-ascii?Q?VPMZz0kiuThCCiiXuLv9aP5+Cev6M1Vj3MNk5mJxz4pC4BFa6NrZpV5XoWV3?=
 =?us-ascii?Q?tBNK6I7kc47ngU4KHrFuDIjhb+1uTm9+7p3yY3EdEP4csDx+v8pO/7TNLlAT?=
 =?us-ascii?Q?p3YA/tBa7g3qDqF6atyf+9CPRnNW0VMzyrhG6Hg7y0ggPlYlAIf7O/AtTkng?=
 =?us-ascii?Q?T/v4Lzo9D+BvgaZuTwblLj7bS5h4zLI3qbPa8iCgh8N0no3dOoHQGaUgGy1M?=
 =?us-ascii?Q?IPUO4mdCwr3jQCbx2ADhtV9fx5jYdCAUJ+2qnJ1GcGyNWrM8Z0rSTy4mr7tp?=
 =?us-ascii?Q?D8sjomeRvQ14FXssqeVLz1+Fz1dkTRm1qxJJd8VNui2HdSpsV422DnTmiU9s?=
 =?us-ascii?Q?mNose07MRlIdeVVhZQcEYLgp3LAUXOplnlgz7IRZyWcTs2043TBb9yv+jRqL?=
 =?us-ascii?Q?uJ8NgkPu9MWYzULs9oswapL8UToTd56EGDmAGnu1s2KkJvEXyOxYaTR+A07x?=
 =?us-ascii?Q?+aC0XcqbcSV1s3SnBRdYgHygCbe/xmrqfh+9JpXl50rf6OGIgq58fisbz9rM?=
 =?us-ascii?Q?Zmm/0h65Woh6gNJuZf2NpsV+J3nDMxd9Kc5H8QTfLA3hR0JDAfLM/3Rjjc+a?=
 =?us-ascii?Q?sHOTmVJoGo7oVbWQ7kGOyWJvvHFcrVH7FQaW8bpwuC+JgNeUyyYToiKPizJd?=
 =?us-ascii?Q?ESxbEem9T4nyFvQIZZf3h3l2JahoJYeoBA/Pxu2I0Zcz5XDBQnOfQ15z9eZP?=
 =?us-ascii?Q?R3pbDKDU4JlCrFQzcSu0aGYuiCHH21JdHiWBwC1qTeIXKXuNiGTPinIIWWUs?=
 =?us-ascii?Q?ElxwZhyE0rUHdTXBIqywRFDZa1BHI1wz55MtkYpC5D59M61T1pB+nn8iVptL?=
 =?us-ascii?Q?XQPqB/xevp75CCrOO9uFYhPdUW3Wn0dkz6cnxClIpFwqL2mHq2rgDec+6zRt?=
 =?us-ascii?Q?t0m65eM5qk9uqPYkYvhjPqT2/zIi4A/2FBi/oX+AAEMAkTopypZhx3hk9piX?=
 =?us-ascii?Q?kAzn66TGCQ/gxPnwcgmUZDZ6SrDKmBRRtbCklSzO6Yo9zPnyMsEMGJv3AgLn?=
 =?us-ascii?Q?Qzm6E15HKAoXlScpOcIixOT1gtK+cl0a94J9W3YInMpK4fxRuO/aL1R8IA+N?=
 =?us-ascii?Q?ShGP8eGU/p+P/1fCE0QnxjOkngLn+Av5WMsTYrTpF50ixXbNBGkZVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XkUAvJiKmkiadXk5eBnd8BoPtGWIiVY0kh1MeAWMPR94OCeJy5Q6WDR3neDC?=
 =?us-ascii?Q?K4Bf17Ov691vH4fYQyyW/FRn0KATbgGAQFsQ1Hma+p2rAO6gs0d5lAy7GTt1?=
 =?us-ascii?Q?nhDVFjNK7EiytPuyMVuRxDJbxGZpsokx1JUzwPt0yJg70v+aB8FCjRu66m2q?=
 =?us-ascii?Q?M9KpM8t+0u6pCnFvgzcPzSEOJ6un/eN8SQr85STFC3FTtGTdWlmz5Hd3TJwj?=
 =?us-ascii?Q?nEDZG1R6Y43eBUjV5X8iKNvxvGZf4ynDfj4DrhAXqNVhHLmWA4gkVGhHAW1m?=
 =?us-ascii?Q?H8nEvKX+T0Cynf0xCgoWaJ9U7ujbC1hN/PW6oDvXDWD7O9RnJmuzm8uDmllq?=
 =?us-ascii?Q?a2D4BumB3tBYOkARQPR+3tdD7xMq3mQ9p5vWZgBoKguBOshThMo+HrZ72J6d?=
 =?us-ascii?Q?OANY5+PjW0v8sMfyiFDXjvfjJ78rHpzvOY4Mg95NjMZOtnacyJjcNiRvzSPy?=
 =?us-ascii?Q?dM0lFI6U3wNLA/lreCFtdG8mHsiQ8d9olGgVIr0QI13sPEJ62hDXQxUkbERc?=
 =?us-ascii?Q?eyPYJ/dn+cUk9xtglu+QuiS3tlgQ34zIyQ4fGfRfA+pxTcPiz2WkRTE19UlH?=
 =?us-ascii?Q?5LfZMW9EfBgZiDFlKaR8ao5oo6648dqTJ58TuI7gvsYMYrmut8Xirr/UF+MQ?=
 =?us-ascii?Q?Z+ERzcWv0U3tHD6IU2i9IzBkjahmbwWZKuGfUK76MPvyHgDpcr2plwcmuzRS?=
 =?us-ascii?Q?UMgRqlblplKPloyB1xhqPkw1lSLQ7lyc8gWN/Iq8Z3aErjB97m9EQHReAEGw?=
 =?us-ascii?Q?l5VEmmIHoXziY6vqOqoxWcrtQQZyA91rmlH5prkGSOjy1ChOI2Utyb2hUbfx?=
 =?us-ascii?Q?9jlO9vUqMlr4Cpk9gstdCM8GUYU44mHHblmyvCixvpup9dx54Yw+EZgaO+KJ?=
 =?us-ascii?Q?acbiZczfIu7UIqvPL+ljQ0K26drQKBwfnah8vvQu2gfiPVksytlKhnG/f6LE?=
 =?us-ascii?Q?AR6vOOo1aHGxmTVU7OQ86Trk9ZZsIneZM0RTDlc1hap5gI/6JzSYDgmZ+ih7?=
 =?us-ascii?Q?k8RpzxwZhiNf24ZpZUe8IQxXi4+4W8A95zlh2OXk4m7ZthWsARPcxRre1kCr?=
 =?us-ascii?Q?L6IMR1+RPjP0b4MqlzyUXxAb2sSjTjbI4JXpt0yczUOTkUNjdcZzfLyyBLwl?=
 =?us-ascii?Q?IMX7HIRCdWZHfO2WQfbKCzxu+k3DSDAkU+NCRWsL/9jIQfQz9xuW0aSNgr6O?=
 =?us-ascii?Q?o/kOpU/TrHujtk9CMLEyZrgNpIBRrt6xh6Zb9+jAjGkCovWCq76Ndq4L33QE?=
 =?us-ascii?Q?gm2YcC6VvSf7f126Gu8qnA115l0BSo3UV3JgaD1tJ6MM6ZLbBaFLMYstpVCH?=
 =?us-ascii?Q?5KKgShWV4Kl5JZr7/YQLl2vZWITDgPOdFRkskiulrxP3MrZx7wIJhV0z3eIs?=
 =?us-ascii?Q?KzmQImlwf86imgwQibChVxTRBTQmp0K/01iDbrKy74c3mqeVZQJlD/Fq4UOR?=
 =?us-ascii?Q?USjz74Ax9YmxnAfy7GTcdjF7NbRvc9+CRfoUN0OR4Lvucx9F60fzLCpU7SPO?=
 =?us-ascii?Q?ogyv4+a6I6gjKEowh5OJXYqPpWPTevCmGZFLyvZGT4mctCci/0FuTC6L/SH0?=
 =?us-ascii?Q?y3Kq0FMMbc2BUTld4Cdxapd2MuUXLe82ISl3yrcr49ShZcGOyQF1cgMzJlzA?=
 =?us-ascii?Q?wmZW1RiTomXz/OfONZSqjdGWTMz/vJxREaAiCliubEAk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a2e8ed-b304-4fe0-4140-08dda8156cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 11:53:33.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wwdcmf09TMheX9f33o4wCg3px28/okpi4+MIaxG7LqIuEPDXTrNXReDBglZpU3roqGA7NRHZLykNlwf9sdI3f5XuYcaDGpuMnCfUQY6yvjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
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



-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: 09 June 2025 20:09
To: Hore, Soumyadeep <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org; Singh, Aman Deep <aman.deep.singh@intel.com>; Subbarao, M=
anoj Kumar <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 3/6] net/intel: add TxPP Support for E830

On Sun, Jun 08, 2025 at 11:32:20AM +0000, Soumyadeep Hore wrote:
> Add support for Tx Time based queues. This is used to schedule packets=20
> based on Tx timestamp.
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Hi

more review comments inline below.

> ---
>  drivers/net/intel/common/tx.h              |  14 ++
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_ethdev.h         |  12 ++
>  drivers/net/intel/ice/ice_rxtx.c           | 232 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |   9 +
>  6 files changed, 265 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h=20
> b/drivers/net/intel/common/tx.h index b0a68bae44..8b958bf8e5 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
> =20
>  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
> =20
> +/**
> + * Structure associated with Tx Time based queue  */ struct=20
> +ice_txtime {
> +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual addr=
ess */
> +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> +	uint16_t ts_tail;  /* current value of tail register */
> +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> +	const struct rte_memzone *ts_mz;
> +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> +};
> +
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
>  		volatile struct i40e_tx_desc *i40e_tx_ring; @@ -77,6 +90,7 @@=20
> struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct ice_txtime tsq; /* Tx Time based queue */
>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h=20
> b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..8b6c1a07a3 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to=20
> crossing byte @@ -1303,8 +1305,10 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
>  	u8 ts_fetch_cache_line_aln_thld;
> diff --git a/drivers/net/intel/ice/ice_ethdev.c=20
> b/drivers/net/intel/ice/ice_ethdev.c
> index 9478ba92df..3af9f6ba38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |=3D ICE_RSS_OFFLOAD_ALL;
>  	}
> =20
> diff --git a/drivers/net/intel/ice/ice_ethdev.h=20
> b/drivers/net/intel/ice/ice_ethdev.h
> index bfe093afca..dd86bd030c 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -17,6 +17,18 @@
>  #include "base/ice_flow.h"
>  #include "base/ice_sched.h"
> =20
> +#define __bf_shf(x) rte_bsf32(x)
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> __bf_shf(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x =3D (_mask); \
> +		((typeof(_x))(_val) << __bf_shf(_x)) & (_x); \
> +	}))
> +

__bf_shf() macro is only used in this driver in these two macros. Therefore=
 there is no reason to use the alias at all - just call rte_bsf32 directly,=
 and make the code more readable.

>  #define ICE_ADMINQ_LEN               32
>  #define ICE_SBIOQ_LEN                32
>  #define ICE_MAILBOXQ_LEN             32
> diff --git a/drivers/net/intel/ice/ice_rxtx.c=20
> b/drivers/net/intel/ice/ice_rxtx.c
> index ba1435b9de..0c5844e067 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,53 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t =
rx_queue_id)
>  	return 0;
>  }
> =20
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be=20
> +initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be=20
> +enabled  */ static int ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena) {
> +	struct ice_vsi *vsi =3D txq->ice_vsi;
> +	struct ice_hw *hw =3D ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base =3D txq->tsq.ts_ring_dma >>=20
> +ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen =3D txq->tsq.nb_ts_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q =3D 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num =3D hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type =3D ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +				vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi =3D vsi->vsi_id;
> +
> +	txtime_ctx->ts_res =3D ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 =3D ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)  {=20
> @@ -799,11 +846,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t=
 tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
> =20
> -	txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err =3D ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +868,40 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t=
 tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx =3D ad->tx_vec_allowed;
> =20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len =3D ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx =3D { 0 };
> +
> +		ts_elem =3D ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +						true);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail =3D hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);
> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err =3D ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +								ts_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", er=
r);
> +			rte_free(txq_elem);
> +			rte_free(ts_elem);
> +			return err;
> +		}
> +		rte_free(ts_elem);

Small suggestion - if you move the rte_free up immediately after the set_tx=
timeq call, you can avoid having to repeat the same op in the error leg and=
 in the non-error case.

> +	} else {
> +		txq->qtx_tail =3D hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] =3D=20
> RTE_ETH_QUEUE_STATE_STARTED;
> =20
>  	rte_free(txq_elem);
> @@ -1046,6 +1122,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
> =20
>  	txq->last_desc_cleaned =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_desc - 1);
> +
> +	if (txq->tsq.ts_flag > 0) {
> +		size =3D sizeof(struct ice_ts_desc) * txq->tsq.nb_ts_desc;
> +		for (i =3D 0; i < size; i++)
> +			((volatile char *)txq->tsq.ice_ts_ring)[i] =3D 0;

Why not just use memset here?

I have used the similar mechanism used in tx ring clearing in the same code=
 above.

> +
> +		for (i =3D 0; i < txq->tsq.nb_ts_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =3D
> +							&txq->tsq.ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp =3D 0;
> +		}

Should the tx_desc_idx_tstamp not already be zero from the clearing op done=
 just above?

> +
> +		txq->tsq.ts_tail =3D 0;
> +	}
>  }
> =20
>  int
> @@ -1080,6 +1170,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_=
t tx_queue_id)
>  	q_ids[0] =3D txq->reg_idx;
>  	q_teids[0] =3D txq->q_teid;
> =20
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		status =3D ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status !=3D ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
> +			return -EINVAL;
> +		}
> +		txq->tsq.ts_flag =3D 0;
> +		txq->tsq.ts_offset =3D -1;
> +		dev->dev_ops->timesync_disable(dev);
> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status =3D ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL); @@ -1166,6 +1269,7 @@=20
> ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_adapter *ad =3D
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
> @@ -1249,7 +1353,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs =3D ad->devargs.xtr_field_offs;
> =20
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len =3D ICE_MAX_RING_DESC;
> +	len =3D ICE_MAX_NUM_DESC_BY_MAC(hw);
> =20
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx=20
> @@ -1337,6 +1441,36 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
> =20
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp=20
> +descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors  */ static uint16_t=20
> +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)

Use DPDK style for declarations, putting the "static uint16_t" on its own l=
ine.

> +{
> +	u16 prof =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc =3D 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i =3D 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg =3D rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch =3D FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc =3D max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc =3D ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc =3D RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc; }
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1479,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)  {
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1604,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
> =20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size =3D sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz =3D rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN, @@ -1507,6 +1643,42 @@=20
> ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
> =20
> +	if (vsi->type =3D=3D ICE_VSI_PF &&
> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) &&
> +		txq->tsq.ts_offset =3D=3D 0 && hw->phy_model =3D=3D ICE_PHY_E830) {
> +		int ret =3D
> +			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq.ts_offset,
> +							 &txq->tsq.ts_flag);
> +		if (ret) {
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		ring_size =3D sizeof(struct ice_ts_desc) *
> +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> +		ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =3D
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
> +							"for TX timestamp");
> +			return -ENOMEM;
> +		}
> +		txq->tsq.ts_mz =3D ts_z;
> +		txq->tsq.ice_ts_ring =3D ts_z->addr;
> +		txq->tsq.ts_ring_dma =3D ts_z->iova;
> +		txq->tsq.nb_ts_desc =3D
> +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							txq->nb_tx_desc);

This looks wrong, and leading to overflow. What happens if:
 txq->nb_tx_desc =3D=3D ICE_MAX_NUM_DESC_BY_MAC(hw) Since ice_calc_ts_ring_=
count always returns a value greater than
txq->nb_tx_desc, you will overwrite other data on reset.

No we store the number of ts descriptor separately and it is always greater=
 than Tx ring desc. This is a HW workaround for a
MDD event fix.

> +	} else {
> +		txq->tsq.ice_ts_ring =3D NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set =3D true;
>  	dev->data->tx_queues[queue_idx] =3D txq; @@ -1539,6 +1711,8 @@=20
> ice_tx_queue_release(void *txq)
> =20
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq.ts_mz)
> +		rte_memzone_free(q->tsq.ts_mz);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3135,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id =3D -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3154,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_=
pkts, uint16_t nb_pkts)
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
> =20
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id =3D txq->tsq.ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3344,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq.ts_flag > 0) {
> +			uint64_t txtime =3D *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq.ts_offset, uint64_t *);
> +			uint32_t tstamp =3D (uint32_t)(txtime % NS_PER_S) >>
> +						ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id =3D=3D 0)
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +				tstamp));

This indentation needs fixing. It looks like a block of 4 statements!

> +			else
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));

Same here, and below also.

> +			ts_id++;
> +			/* Handling MDD issue causing Tx Hang */
> +			if (ts_id =3D=3D txq->tsq.nb_ts_desc) {
> +				uint16_t fetch =3D txq->tsq.nb_ts_desc - txq->nb_tx_desc;
> +				ts_id =3D 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id =3D=3D 0)
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +					else
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =3D
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +				}
> +			}
> +		}
>  	}
<snip>
