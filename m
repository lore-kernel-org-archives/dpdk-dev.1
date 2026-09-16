Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F2C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB2B9410FD;
	Wed, 16 Sep 2026 10:56:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 087634029B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 10:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789549010; x=1821085010;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bCxMVXDkZVtvxUpL6H0bRqzxA4gDaaDvSzpURrtWsEw=;
 b=n4Au0VeWARmvmVTZM1kwy3eWOWBKL1JPTyfLOB1a2NPRIioWOFIkdGdT
 2R+G8ei9FfFKk4GucxXSRxArQdcUaHMHrRhAhIN1TUfa9F96fdocaVEvM
 sXRAH987Rlwyy8g5AXAFFAvBZt4txxkB0TT1NCtjuSXVK4UEhGLsI17ol
 E5oq361jORXGBJJ7JUY9ltemRxvuUPk87zGb3W0EcIa9HWKNskS30Z3t/
 0SEvWobTI3WINlnEQ/ZRhj+bmao79Oe+l4tyxrdR9K7qJkLPcPtQj+s5a
 jKenXkT9o1Mpd9BUunkma4PqphoklrGXI6vKNidbsJAij4SwegZk1aYFr w==;
X-CSE-ConnectionGUID: IsL0Sv/zRFWq+pIVmK/FjQ==
X-CSE-MsgGUID: oHiR+vP8StajpYsA/SSRjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88857516"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88857516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:56:49 -0700
X-CSE-ConnectionGUID: s0JCa7nfTX+hEParPpJkQg==
X-CSE-MsgGUID: 3G+9LMJ1RXyfVh16x1n1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277024987"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:56:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:56:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 01:56:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 01:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtvgTr3p6J/WeK7I/oEvc38BmOVBZJxL+RSVVI9FGHNPqrs2qGM1vekkuuD5fUMebJqE4RZQUkxYxruiPqyOx0O499X/Og0jcJ2SYYOPLQP7dMRVdWov04wcevTnSClJpVjqSHY7PNozrcyQw+RCs/THmyVlvlLWPX9cf/OFU7d4hCpc0Z+h7kQ5LKxOpDqxwMY57orpvsBqdNon/U30DhmpONtW83HB0ZH5uFHyETd7WIuAhAh2eMCI9WOrXK+1Us2nmpl38dfTo4MU3CbXcr/7q94EnP4BVHrV7i3/fKjpiBR/TcICHHf+5rlcyKGkAf/HvQ7Ujs7SBWpTG6aEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un3cpXbDHDBgHC+B1M4SFS2PUAPncQ5A0ionPjBoZ38=;
 b=kieDXjso/0I5Q5m0Cne7t/ZFykmTSO3Eul1vDoRypiwgMS1BzK5CX3vPyUXhXgKFfA9wgttXFxrBXI+OKVVpRMnE47ep/3dQoD/Upe8rfQY6rzOmmcN1ROt7l4NLs6KwARiH/avDX1pW3Lk3vOP5qbuDYnFoaJNrTzGCQA58UPrA6Uih2iSy9oRGlccqz55bCzl30AOgiYbmlN8+PqBe3Hc33myn82p5tQ2xG39aFA+1zn1oAhrrPJmfA12VSGJWiy8ImSxiF1TlT04VyhVa7WDGH+sU1AYixLJzRZ8tXT0zyi37FHfPi+bmvb1ZVZQyL81eap99XgAZPO8KMM98TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS4PPF399DBF572.namprd11.prod.outlook.com (2603:10b6:f:fc02::1e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:56:45 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:56:45 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 07/15] net/intel: use function callback for lldp
Thread-Topic: [PATCH v2 07/15] net/intel: use function callback for lldp
Thread-Index: AQHdRRd8RfZBiHm9dEm13MN8gZF1jbbQ6EQw
Date: Wed, 16 Sep 2026 08:56:45 +0000
Message-ID: <IA4PR11MB92780152B69BF910246CCD548EB92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
 <20260915133654.278780-8-bruce.richardson@intel.com>
In-Reply-To: <20260915133654.278780-8-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS4PPF399DBF572:EE_
x-ms-office365-filtering-correlation-id: 831f0093-862f-419c-54b2-08df13d06f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: tJs3ZPajYEcqQoAuZvEDX2wHjR0wY6Yg7bok141RLMvn93o6MPQwMArKPbfPjSwTnazQbGq9a3lyW9+WUJanFwq9E6BGdsUKtLIqSBjgWW0DiyrjevnkkDl+YucFw6SwmVQGk7p6bu1XQg12ISfDG6pOzOlzkRRnTduFSwbjnRCVn3hkTg4NBKPSO26CAiA+UNMlMlEYchNf6VVQKBSb+rWREkSDkTr35Mld+1C09a+hbd1Wv47GjMuFmtztq9hPWCUtwm6I11p5v/hpuXWZ8Mtw6liG4+LVM63YTM9nXqdDZULMC393y/SlpErHnBjTaJT/9Coog05va5C24jXYCX/5N7PLo0wEd9Rni8Nw55YdX9ErU19sJg6Yh+pFDgVwbp7lEoWqGH0rNjm3kYDDSkIKMNV4IVlUp475SAkJUgJuXL+g4eAY9UBigN1vvfJ6cBTdTzNOXMBkWNfKEdzPZd8QUeCL+Hm120LHsnvRKO/d5xT0sCoYCBn+0Nu3gEIY/nDGkVWebZWjSJ3nDqokMr4cl9c+2zQvDV54xuuRtR8FRIGiSSdUfiZbiLZHt6avt/Fr2i6Kh7EnLkX8WKdXGVHsH4BSDBCuk3Ol6tU8DAqkVgg4Xhpwrvq2eFAkI2AYTnyNaGwcaVZfkj/wSbp6JrcULwrrqladaJu5+2QHv9zgbAFCDGob52/cWbJF7C0dY1sykPuzX0GzNdbBSG1mRu4qlBXibntinYw1VC9DHp0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6/lOIPSYF9iEOtZrR3Kvx+ZcfoyVGrocPHEwgLMxX7RSzrDlbuNUXBk2lMl?=
 =?us-ascii?Q?AqmC/dsx8ibkeX+7fdS2jPPDdYYiX7dBc+rHTV+FwpawyPF+r7r5MNZW+Pak?=
 =?us-ascii?Q?oROe5FO4YztuK62224y7mG4UnbxU4zRmHb0awsEC8vFjH/RYCNxAk05Mu4IU?=
 =?us-ascii?Q?rIIi8XJtQKrOOzdXC1KgVRwrSOXFI+GxgpLA8xKzHqscNeOpL87fUJlhmkNh?=
 =?us-ascii?Q?H7H24AtTgBLmLDZWPXsZAV7cpzuBWG8NSXpgvgklyGMNeYtIm5Dml3E3IKl5?=
 =?us-ascii?Q?AoAAWW30qyCqR3i5WI5+e9oZ1L/GP5bHJl0vm3qzENELxzXP9jv5cNUPV1OA?=
 =?us-ascii?Q?8tvFg53z68I6a0DIuhJf8/TWVVIzvXqTuoRdVJjSlbjtL492RivIUWpn1SOH?=
 =?us-ascii?Q?yJe/YEfjJeUafGLOpsb/XbMD1D1y0Xi1v4TIlgxwsYLjwPKsB9IVds8y5JWX?=
 =?us-ascii?Q?KrrX3VkuxTfz9dYnhIBpi4HTiGuXffC+91hcU/Xu6cbT3Ta4dhFzINTJCSa5?=
 =?us-ascii?Q?gYirV5CWuAJRjzYbqmV06VyxLVFlbLJnFV9kYBtTUpHCIWcqM258Ej+Ha0yx?=
 =?us-ascii?Q?9b2AxNIE1s3q+59ssbkrT55N+aqxXVa5ca7SpDzC1QFg+PhziwBSK+TqOz3c?=
 =?us-ascii?Q?yvy/z78aJ0v+js6m+eRt63/hJ4Y+3owC4xa0Dl3MPgQRTw2lcjrmU/OufD1K?=
 =?us-ascii?Q?gi3xVqScA13nFAjCd7/yfft1s4AXGa55xCWVcW3+iaN1mVagN1Xpy8OhD4mc?=
 =?us-ascii?Q?6g4wuId9gXot5qZ88q2CO3XhybJvf4jwOGjqfC1MaSFKqo84tieAouE4TAFh?=
 =?us-ascii?Q?SitICeI/MpIUXbGzi/+k40peNQ9uSZPi0zJGSBsSMzcd2lV08lsxbY3cuiFJ?=
 =?us-ascii?Q?8Czr88/iguNVS/5DyvHCYY3LF64aYPWCwbg0jcz4AttOM0UlMKx8FC7GDNla?=
 =?us-ascii?Q?zjWypSSUomeDLj0hR6iZFqsafybDsfQf97ngwP4iQQEZ60DZNmI1r3mCT9AU?=
 =?us-ascii?Q?QQGZx3wm0sXbaRjCVL4fd/jst+kcQVPayvoclqsQl/uRaB+BkS81AyOPsmvx?=
 =?us-ascii?Q?d7LGfOIcNKLEY7iMYuo3X5+YalrBcQjS5D4x/PQB4llqLbBV/jqj/BYwLXCQ?=
 =?us-ascii?Q?xNdrVExOZKulV3wNet+FidX8wJLWUqfGBrq4f/OBjFRUUXtnpRTs6wuh4uup?=
 =?us-ascii?Q?Wc2a8VRbPpl5fcapU41qU+mYst2tsbKfcD+NfzOmvAhY705KfeGqz3jrwxAu?=
 =?us-ascii?Q?2QCiU6s6S0DUhpV6VtPAoesNRjC6yIqwP8KyhG5VFLWBW6JBDGaE81rKtaUM?=
 =?us-ascii?Q?DFmPiSKzRggNOLuINNz2TTBkyVTNkjySyWradz3V9/QtApPvXTuLqvwcq27p?=
 =?us-ascii?Q?ExWLT8k5nNaZhAH3BQQWnR16JKSEmtGDpI5ij626iPOkOZG/521uh2mFrcTv?=
 =?us-ascii?Q?JUd5CcN8U+F6zRSL/W1nt6Hayv9LosSqtTxn7FAv4DoItZdLLjU5cITt6fkr?=
 =?us-ascii?Q?T8qK43nU5cxIeuaiXZSPOZAF06eMpYDNPAO3tdIoXy/7BU+b8dHlFE8NaBZl?=
 =?us-ascii?Q?VUbay2DR5qC6wP0zwFzamyw/ZvpRAX7z97QP2LLdE4YLCo8uZlou6LwJB5lD?=
 =?us-ascii?Q?UHN5qiDmO1xiOQ//PSdYwnBmKNWgfzTUuCL0dXWZ0FZnSzzh+m5rkmJKfZhg?=
 =?us-ascii?Q?2U/qnbZom8G9YOZTqlc4QWQGDtxRxHvclQgmlAyrCPEWPqZ1DpTmrI9Bi/o0?=
 =?us-ascii?Q?qQFUMMikbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: enMy6vAUdOL0LvX9Ue/J9fj8VBhCqq6G0IiMQTCkrtGdIWFlVlST5pBGRWdKheEQVbc94PjYyp6/py+xebg9TErbQWBina2dMQTagq4LGba+lyU8vIHyacpYTYdM5HvozoZrrknQd5QofKWtHnsxdiMD+MorPCCVUIYSoXkrjgOFibeR2TKM/0EPAu83K8f0JjFahyeoDPIfY7KTk1iFpK+r1o0xXdOgCBMWAE5Ctd/LlCERgTQczkim0CVP7mZ8RikgKmmtAdyVHVupwy6trJgZk4FaCAFIIMfEeuDsuZlQUzG3JvsHqDia1hAjHxHxW2zOyYwC0jfG9hjztgvatQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f0093-862f-419c-54b2-08df13d06f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 08:56:45.2554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MDZY2FXmRz8fkXzlUolX6NlG0IcNTBoEnGZ7irL9qeFFOB3hnfrd3GG1cc6ENLpezJQsXspTQ3KdOLm33AD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF399DBF572
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

> Subject: [PATCH v2 07/15] net/intel: use function callback for lldp
>=20
> Limit LLDP support for iavf drivers for now, by using a callback to
> handle its processing. Drivers not supporting this pass a NULL pointer
> and the compiler will optimize away the branches. For iavf, the compiler
> can inline the subfunction directly as it's known at compile-time.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx_vec_x86.h         | 42 +++++++++++--------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 16 +++++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 17 +++++---
>  3 files changed, 48 insertions(+), 27 deletions(-)
>=20

