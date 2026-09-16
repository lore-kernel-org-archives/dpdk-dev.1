Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB0C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70007427C9;
	Wed, 16 Sep 2026 11:02:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6B846410FD
 for <dev@dpdk.org>; Wed, 16 Sep 2026 11:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789549349; x=1821085349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XryTLMLoFiIFV+ZhlRo0QyQVNwgbMDvXyHKiPhrmu0E=;
 b=e+r5h3w8TLI1ndLqVxZltWHgarQZqvnQ+BE4r9zFC8DXjZV/af8L2B4w
 yjLr+mTofSogCKD5AfKdkQcRamWNUcDNzlHSeibeHBokHoNY90MA2ErIp
 1NrYJ5mmPuG82Hi4n7h9NL1vJhlCYebu0f15DU6Ja/xPY7Rx2Qznp5EXR
 WkfAMLGQRbCCdDBm9OGlyk8CJtW9Tqb7edDadu9gH+q7fXPtRj6uoSTFg
 emJtsqDkUPwT8mlziWqS10gY3lnXfBTAqOiO0oz/1WzrI/1/4wNwX1xbA
 YMm8yoqPjfIo1prwAcLOACRsEEzv3RCcXOiSK+Qx8DfOiuOWEBYDiV+t5 Q==;
X-CSE-ConnectionGUID: p1+zdwSmQkGY4BuArVyMsg==
X-CSE-MsgGUID: SA3APZL1RPGAjt/8BHZp0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101266418"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101266418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:02:28 -0700
X-CSE-ConnectionGUID: wJfjUmkFQgOENXtEin91KQ==
X-CSE-MsgGUID: +BwcBsgzTO2YnhpX3cgisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273247120"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 02:02:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:02:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 02:02:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdg6MwCheYwKCt+XETdunD7B0WQDkklduNEelUUZJ89xo7mkv3nN5uN/xRpboZKGXrNm8rJKesQVblbXuFK6nAoipwbZsfJ9JJRcBhaccGkmt9FKzWSoKSmWypbDQahjopvh80dxC7bZ7pR04cOXaHHcSXPZDzRcg36KtRAIv4F/wwR9b38X+6KBYJ+Ran5Mgp8VfyNzS0sWZQLMXIT09XENxXxU0FM4uJ9P5ns/tWw6xBfRADY2sv//QNlzTRD2Y02lpJjwwFUm5wx200eCbIXO9/ZujDYlUk02yDCATZNpqLsxOrZdRk3wPW8qrcS2w0IGTnsnzLHyt1pe9O3rPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngidrJN30ofh6vjQQ8NedFEq3b4anEINHi9K2St2570=;
 b=spvkTK1LTNbJ0uEatSkRVhPyWr18Ym7CvGaeyzyNMXmXT9Vf+Bo2+Gc01AKqpOFNq8y0tJnMiSktC5BKVx1O0bOT2ypcwroIJniajlRE4kyQx4KAswAmxLHYkVKt9x+rXme9JU5BiAMUu6TuVrgvT9DMa7Kbs6z621X1ZRzGt/gUdW6pd01pvF51PtOk4zbgnBMshGpTDCXRo2TpUlYIA2apxc/Q6QHhT0yrb0TcZEi2M4NNobj7typi8oBpwgChzPnbgKHzTVQkojefU+AhgmGMCvMxqU+QAB2D+qzTyTq+I+nW/rNK/qlq4b7hNXf6J8TsgXsd+btK7fZpaC4N9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM4PR11MB6312.namprd11.prod.outlook.com (2603:10b6:8:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:02:24 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:02:24 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2 15/15] net/intel: consolidate Tx vector offload path
 checks
Thread-Topic: [PATCH v2 15/15] net/intel: consolidate Tx vector offload path
 checks
Thread-Index: AQHdRRergkLBtI9g7Uu+5fE6APfGlbbQ6drA
Date: Wed, 16 Sep 2026 09:02:24 +0000
Message-ID: <IA4PR11MB927816F045698F9A5EAED2938EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
 <20260915133654.278780-16-bruce.richardson@intel.com>
In-Reply-To: <20260915133654.278780-16-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM4PR11MB6312:EE_
x-ms-office365-filtering-correlation-id: dd3e041b-1a34-486b-b8ce-08df13d139b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: OCafBq4lhUA5ttmpHLKuSfYDFqaidY0rVNGZn5F5Y2Ip+vFuFwwavkYbyf9AvZqQ92R40sB56byr8R40hvLC8BvYTCHCqsmEOHl+he43/y9GFQI6Uu+k9TZEZIg0+QYLPqeLxKC+TngIMMexYsXCZ3n3TJEaFV1aKjwEk4m+98nMfhKE5oOGM7npbQpN5VAAugc4KoBNg7wHdjHnpnP4oiZ7gCIvaiX5f75CQR6nslnd5C4wKUi8s7HWjjNF/Qsdp+42GOTkx/XpabFRWFjW1LKJi2BJNaUyRD7335e8mKlSWrA14/hOGtDAzMdKF9n0OE3TDpDRMqF4RNJQboUr0xGRdoawSOhGTcDUP2n0oOYnBwpn+/F/RpZMWVLi+4ij6BCtsi2gmgM1ykNCDvr40yTclyVGH3T4Vug3rz0+T3Exh5Rzjw1pGH+8Er+Z3+k7yywUdMH3oBxDoX8NuM6/X88r/JS/uHOnDjP3JeKm3W9n/bGu5NqJyMr6+O0JpetlM64gNdbGDqRLvYHvQv+7y3DlLtkVacSe7PVaa+oiPFdqy6yTmNTEJc76fOd0iqeQXrlyHorWBvmjffhfgD5XdmQmLgdzd6DW103WJtNta5FG75Ej8Hvr1Hd3CS7ha4JgE7dk/cEwr0ovimNHEOkxzwkHZ2jrCxyXnZ9gllu4AmjIcpl+CrQ0qR76xEZnGGI4ZDGurHV/mAKE5Moj9/ONkVxTx1zJaR7hnDHPt7X5i04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iFUWvXFArCV9vUK1kj+kYsXuS8Dsw+WJOs3g3OPL2MbEaKjCS10aFb181Ht8?=
 =?us-ascii?Q?lcHBS3QpDfyQ0hj9ridjTgZJAl7P+tsOLND0Yd9v4x0mYQ1MRJXAuT9XwP59?=
 =?us-ascii?Q?2G3TWou40xVOPW87NUcMdEX50UbNbtbgSQyk1fxsoKN92osmXWHldmcdM/WF?=
 =?us-ascii?Q?nIsF+Jc+elx/Ftd4FppOHfqpcX4xJsKeRBXrG+DN619Y7Q1o+LdG8grLbBUR?=
 =?us-ascii?Q?7kv7SeOqoqcLpEvf4qKo10rkPGizIgdZMfXQMzmuKZVE0Z5+FMMDVeVvU//g?=
 =?us-ascii?Q?Ms2eHs6J62UO00aSt8zgQfBF+vVnmEXii5dIhIsXxqhvheKlzBOdM9smpZUX?=
 =?us-ascii?Q?+u3QUauFQV0UzOMb5R9nfIHF0939VMLj4OPK0WK9zsywzOD+qmbZxIDmxG17?=
 =?us-ascii?Q?QAv2UBKAQ7W631PAXW/Nc2X/fctP/1WMKlOcLiq9nHKswOLxi54QAQyx58X2?=
 =?us-ascii?Q?jCO/lci0fJS9RiutR64ugjlGu2UIhSNNjrTMjFWt5kjLZQ5D580SW0mEdOcU?=
 =?us-ascii?Q?F7PbJDfEYOlLL7bbQbESMqmlLrLMFpahkTaV9Zeac8OK72+z941zA38qL0bC?=
 =?us-ascii?Q?DVygdOXW+Ofr6znRUhmnfq1ZWye0Xpmx60Yuw1T8B09wQlEzOoujWp6gCNaX?=
 =?us-ascii?Q?vpMfF3RG943l/2AxKjYEKOttuuo3JO2DWnFZ0S4GGiFJUr8DPW2s/Qh3lefp?=
 =?us-ascii?Q?WQ60I6xpbEEz1HSY2ZqSbZ8hU78oOmn91mD6XdaIX2x9FQQl7EuewDh2I8CS?=
 =?us-ascii?Q?D6REdP8BLjlmicvdS4or2fAJkRXj93ttC2GzV+0BnY3dd0cz3PpO2o6kcocd?=
 =?us-ascii?Q?Qu4gKffGzOHT5cUH8+sf4npgNsZtMSkKj9q20xyMkLqmFriCSxJ9gPm0iivt?=
 =?us-ascii?Q?L57ioABaFbREgpBYFEWVagqtxLiuCqPShPZkuXIRv7G+N07qyMFuLDhAyHEN?=
 =?us-ascii?Q?4406UjMYNg39KRxtXoeTJue1RHKBCpKwbvy9K6XMSNOxq+yltnXEU6rhX3hc?=
 =?us-ascii?Q?FgNMQmTPH/2YOS81Zf1UZEoTzqZhajAR469TfpfIRpZu+nRInWH5e5DVf6zP?=
 =?us-ascii?Q?2Qu7W/+fIZg+yjUxvCLBh2eGTI48ztXVQ0QsuBJN2nHey6JrNiFqh51iIZG8?=
 =?us-ascii?Q?nfWXw7uwJ8Ype235Q/9H6cbwFtD1Rt8TeTXmMVrB2k9IQEu37NxnW4rnZwkz?=
 =?us-ascii?Q?dD85pEcV4oDjI58LwPdJ/4W/ihw57HrKD9TK96rOe/hyze0yJXY9nA9/Ocw6?=
 =?us-ascii?Q?ir/lP08CspijcuCY8GMQxjtkNs2Sa2k2FLB0Vbd4qAt8EZfSEBJIOKdz89xI?=
 =?us-ascii?Q?iZSe3J7GU7YwDPfdFbRSaxCyanP/RIMBU8soNhkZhPS49r1CvF0KYa8+Nq95?=
 =?us-ascii?Q?nI1vE7jTqvZKWCiNfYyMKHSYBhasdCVXgbeRvSC1hEAJ1FwEmGY2wcwYcynJ?=
 =?us-ascii?Q?zGRopqj9ih6oM5grKn9YAYVRGyGjcl6HrJnKtFERqHdC6zf8TYt3P3BNxDOx?=
 =?us-ascii?Q?vCO3Et/P6k6aAtmjet39OA2fqOdp1/eVwMzGLg6Y+qnlnlb7JhJIIkVsA7gX?=
 =?us-ascii?Q?QzN0sNjLNDHjbZjDZSrOY4FaK5wd/D7SVGaILi7qY0bEVRrRgZUKbiMY8hX2?=
 =?us-ascii?Q?48M0ZvLj2KmO3i5TJWjBVASh7Z2DkP4HAefp/1I2f8P6M5Pe49pdwC7edAwY?=
 =?us-ascii?Q?KjhUFJyU8Y3+ec4fgo/vDZwajcCRtENGsMcOss0Ifh8sNMw3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xAwu5TsbpIMKD3RgmbFtnElg8jx0voQ/2rwR1XjPNk3Dsxpg9mWSyqQIxHe4EXpv5gR+Mc4uHqHny6ypZjdVIHdWPlvt33YeUsohnkU3LDDJwZH+reRz4VLzFva4F7IHdGXQ2JvEx69eCC/OdAvQbImIMXNmz8ihRH/SrR5iNnE1cdiNbtcnSpkZeVY5c4h1sTTsosL8ahJxbS9fcC4OET1nIzAo0O+JBXQqtPdIz3NusI0X2/9a+zClAzk4fuCNImH60EakLkHv7RmhEr3CR1fjHtkHX/EMm2eTAvd/LhSDni2MgqWOLfXiv/i/2ZSVuknqvFGPW4DYQZ+9tLBa6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e041b-1a34-486b-b8ce-08df13d139b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:02:24.6586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKxTAHR/W/JbP9fee3kis1VyKZ7d1moENULd0p3BgbVEzN5iIIjRhCyT+zqvtoFDGXjxHiUWRMhsbCKH8eemBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6312
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

> Subject: [PATCH v2 15/15] net/intel: consolidate Tx vector offload path c=
hecks
>=20
> Since iavf and ice drivers now have common Tx vector paths, we can
> consolidate the path decisions a little, including replacing the
> per-driver offload flags with common ones.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx.h                 | 30 +++++++++++++++++++
>  drivers/net/intel/iavf/iavf_rxtx.c            | 18 +++++------
>  drivers/net/intel/iavf/iavf_rxtx.h            | 19 ------------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  3 +-
>  drivers/net/intel/ice/ice_rxtx.c              | 14 ++++-----
>  drivers/net/intel/ice/ice_rxtx.h              | 18 -----------
>  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  3 +-
>  7 files changed, 48 insertions(+), 57 deletions(-)
>=20

