Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A47C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 14:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29837402F1;
	Thu,  6 Feb 2025 15:49:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7F0434029A;
 Thu,  6 Feb 2025 15:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738853384; x=1770389384;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x1X4ZBjEAOarXaipyKn3rO3CovpIPS1tXwUA3z6dbx4=;
 b=jYNDe4Uzt/YsJrOYYSEC8zWWL1QRwMj07dW2QbZeJJAn85b/hKz1u0my
 nEohpb5QU4/H7ZRIDG9Q41GQ97zSPz2ubLHhmbTT2miiBAK8xY23JpCqe
 7yfP0/LHmtXQoLsPTESd+Xe6HOkpzD1z5DAlBZLUka2s71+rC5uPb0kIy
 7wBXC86jRyet7oIPY1442KoXX+uuhQa0nAxXp0KIRT44mjNjtH5pyg1G4
 3BQZKGY1y0OHvJeTMjHDAvbAfCROp7ULL4rHHl6xCvZZ2/lKBdSo+aMcV
 V0YNSI6rztx4EpUkoOMXWFRIV6AzqIr77f4cM8NWxDFq8QK3O5fVzc1o+ A==;
X-CSE-ConnectionGUID: xmXPcEw4TJWMqSW1IQD/kg==
X-CSE-MsgGUID: GwwJ9jN4TxCBQ3pFFfRBng==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39154170"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39154170"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 06:49:42 -0800
X-CSE-ConnectionGUID: 1nwO0DMeSGevw4MYVXiUsg==
X-CSE-MsgGUID: 1E9cYlulT+uAmgbai/y0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116186754"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Feb 2025 06:49:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 06:49:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 06:49:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 06:49:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhc6IgZAUYeX8pPoblt3UdJUtzdzByyS6KMbm74gncvmREuJjsjVn6q1/ET6lbUZQsccCC9btJWrXUKozInza3PCRPG+s0vPahUyBxCAx9n/gqNhNoqfYGVi3dwAvenAKgVjzMMlhQzJgj/iZvknGMmdw5d6hWwt4ZsfpQPwjYLoTbb56S8+AXogFO14jvX4OqC2ybq7LnW1LbWiV1Jm/vtCwp/Ik4uibfrKr+bBzvjh3ry9gG6h9p5C+0AUutF/oqW/PuJHGeg+i4vdjO1R2/YLAJigsRu+PsERE5qoUsOdALHZ9/wmtEsRilI5bSxxgWSmpMjzb6N7SvN3lb7ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE+iSZzM0Ea/xy6SrIKkyvJEmUSwnTVC5E1UmtBzvfU=;
 b=Tq0+Dv6g3xbf1F+//K1f6DAuPc1/hA6NpTvwfzLKylc0p4JtFnJwHv9oj8hoprxsQ3pNE22ojCU+yDSkwx/lsXPTsKd+NZdIbFEX+1BsBJriBj3usu4JjXJiSp/DPZDNEKoa1fujSnsawGDfccKsHDm5umhhyFKcefflXEi8yxfL1fVtBZDRRH5GusIHVKZmdakr2Wx0WA1YKpYW8cl7eHwNt0etoGkFWhLUq8ym+36ERQi1VbCRTCx8T8QiTu9+aSR9rUXG3gUeQ0kk+1g0WOJhiqbN8P1mBcuKc3gndvbARklZ90J0zfsD1knh6ldJOYvh8a5FZ+ziYQ6EAC468w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:49:36 +0000
Received: from BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a]) by BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a%4]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 14:49:35 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] event/dlb2: fix event weight handling in SSE code path
Thread-Topic: [PATCH] event/dlb2: fix event weight handling in SSE code path
Thread-Index: AQHbbCeWssgX5viBJEiKgoV8YAYgbrM6c5IQ
Date: Thu, 6 Feb 2025 14:49:35 +0000
Message-ID: <BL1PR11MB5461221901E20DCF1892CBBFF4F62@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250121171135.2705818-1-bruce.richardson@intel.com>
In-Reply-To: <20250121171135.2705818-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_|DM4PR11MB5294:EE_
x-ms-office365-filtering-correlation-id: d2c1d815-3d47-4119-2642-08dd46bd7953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Z772k9/TLqem4ojo+VOvycEptgZn+dv6EkCmEiNXk+9MvsmhDciE5e2Epssg?=
 =?us-ascii?Q?IJneoVm3Muu7ausAPbmtWi763owHDN+G7DPpt9iMONXyTfwxrGgMYEQ62KIy?=
 =?us-ascii?Q?BeN1FM+Rdh00enJGL+i/QZcXCRcgV7t9Sur1zGfHMAKrGI7jN/0Ofk5s7X72?=
 =?us-ascii?Q?mPdYzPgchDlbLCDuLowtWf25Y6f36UxeHvVtrvLdWz5G3wOUR7YQqdHdYduD?=
 =?us-ascii?Q?m3bOrh409NJmmRI1N7SQ5toftaw+nIfWalYAcahTv9oTMlas8CbVaQai8Zsy?=
 =?us-ascii?Q?Hr/hlPSWOhPzB0sOTtJOqi/eGP8HZVh4AL6Mld3hKFEUDz7X7qN8P9gBnsG4?=
 =?us-ascii?Q?aBFvvgyWTmbRg8Ze0oW3fIygtzNSwjEBfY6UDJlgy5isF81HPt9Rxj69OlV7?=
 =?us-ascii?Q?jjY6/LW9rZISzt2+CPcUGY3JhAITgBOC5h85I14TYADOuekgImuAVR9NiYCW?=
 =?us-ascii?Q?9u0niYaK6IJBRQ0fVUPo7Se1zu9QQBbgvezsOpn3jxFKy/Xu660dB24TQbv+?=
 =?us-ascii?Q?jkSHpLv3e22CBUNFgOI6F3w3Vb9Klg5bs2mMVLRPGtUFeabSyXSPmiVNAgwV?=
 =?us-ascii?Q?zqXNwUaeP3WW5C4aeyPKVa5NymDli8CM8yiIejP0pjx+y9HNd1UcUkwh2NIt?=
 =?us-ascii?Q?1ZscPh7o3/XO9suIKJjR0vwlPREZol6qalv5+zZeqTJUTrdLBwRwMQHj6F5S?=
 =?us-ascii?Q?YE4i9BIKWNNmX6LPjjJjYj1ZalIjQtwZeMW/2C3rNaRONEl8WqFvJ77jtgF2?=
 =?us-ascii?Q?/6gMfRmlhR8MXqgGvQcytX91rTL7YYbti6uZXECqcsFvBvAcNfoi9nSBbLgU?=
 =?us-ascii?Q?Dok55nmZBCut94F67ld0czf2DUD5uVd4D7VNdQFzVJ7OhNWslR/VM/5t01Sh?=
 =?us-ascii?Q?jt0Ig4aULtzbnkRn/GGty5GpioKVCjuzntowvVLD/Xemr0sIY9SIzYMVa3BR?=
 =?us-ascii?Q?Up7khHhQDRyMzSq33ooKHa0GN5TnNlF6rC2K2nm8ZHF1a9lDZ267W3TOvKmc?=
 =?us-ascii?Q?CmTVJkvZq+T6b0/zFIFAw0focBJKS+jNIRfzyfcL6lBqOsWxqtBYAlZ0b418?=
 =?us-ascii?Q?WCNin4JDZGdYUK6kmhkYK1qRMVpEKQPhPMijviAvqpEk2oR+aPHJtJtajLuF?=
 =?us-ascii?Q?E/bWH/JzyB07SgwP/MqhG/jPekL1ifqYnmYKdTfnq1pcOwc6o8fdoAoLTsVb?=
 =?us-ascii?Q?PgvHKtbC1q9ViH+OYyiS9/9bDC6X9oyh6C0jmlRf0d64ytST4W2tfwpC3+VB?=
 =?us-ascii?Q?/HMpwpczip8qmzgqkwPoaBXZ19nU1sOiDH7mH/UJJ2UVnndWM3M6cnsiFuEO?=
 =?us-ascii?Q?Oj0bIDTTxsdLRELEEqdJTAOTLGJsJYTU1UEpKubAaun+/+EbGlqoVzYj0PXN?=
 =?us-ascii?Q?YScPSxymFjhm41047z8+BrJchqA4WCe3OWMFWz6yuz1n7TkoIR4r66URCfuY?=
 =?us-ascii?Q?VH8rFIJi40JfwuIa6J7GkC3JdGYR2IJn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wLTkY0otZtmqeRLB4k7iZYXNkMvNw1cbs/ruJJZ66gERyiIkZm78P7c4HQBb?=
 =?us-ascii?Q?w2quq1QTaBvN4GMveYKTqEs5KlAMUpJJA1XDNVyXkNh6A/dQS0Lh15G1OTO7?=
 =?us-ascii?Q?RkaVGJ0wUJE4e93PY+Fs7uEvhkASgpYaYrEdIqz5IR45stOjLH/oldarCOoi?=
 =?us-ascii?Q?VFUp+UGTKJ8rKzPGJK9eDcTQvLGWjDgEn325MFO+khFToGWzVpv2ROg2PKMn?=
 =?us-ascii?Q?8YxmHxK+ScB7YGXg1qb6Mk/cbE5fNJuvI04cc/hjgaLtaBjU3h0DL5nDsqOW?=
 =?us-ascii?Q?DeB3ESzByA489d68vyOwGkziUZJioMHxRWb9VLg72GPhWoolXrBkEcBhY1E4?=
 =?us-ascii?Q?UQIFL4wWcmOmweU+tb7QHhAbH66H6G2J5qXIVzfQtnWnmNDVp/FbzvisDuMM?=
 =?us-ascii?Q?M+w35Smml4FvHZFhSHXtdAPEDy4AyFbm67NbGpXFVMhYiaH9/AN6x2raS7j8?=
 =?us-ascii?Q?4gAkf7deF3BE9LqnbCEhR3y3Pdd8HUWmApGkelf5JyyMYMaCf4quU5GBTB9r?=
 =?us-ascii?Q?uugvKbZ2KJLkshue9/r1mw64GJCCHltRuzPEOVk/fURIhySqY5b69t0rFv1h?=
 =?us-ascii?Q?5ij2ibwuegv1G1sZ/AD5xZ7VwX8b48S4O0AkNnpS/InLohDajLICuBPc3kLL?=
 =?us-ascii?Q?wKDRIqSIvQZxc225KTflHoEle3ygwKo/k1KMv6xkZ3ZqgVN/DOSe7Xa29Niq?=
 =?us-ascii?Q?yzxi+O/2qHM9uiI0QI2P34eND0B7uIvFVJwj7iuDOG4/EL+rNaLouhX+OEyI?=
 =?us-ascii?Q?2UAKBbwb0jNescRHsLruw5EsfOZvOKUH2SHoXBtongBGN/Cn+EMkQyfeoG4A?=
 =?us-ascii?Q?9FQG0+qcl5ZZkZW7BcgMd3MjwRGTLfceFi7YAzY3yvr59gmKCQC8+TjLk+CL?=
 =?us-ascii?Q?8qR57cTTv174F9hokkqlM1mHOhaQE6cfU8xpo95r9SGM5WKgbRbtUdhHRNd/?=
 =?us-ascii?Q?1nhhkae09iT6pjJ5E61EeKaP7EhYS5fGLG3ZOI51oW01Vz1DlwXCL/7HYfSf?=
 =?us-ascii?Q?kJEPD3VGXAErCG/VqC60e2fsMgmnH2OhQAPp/7e5kDYFuQBM1V83Snfj0ymG?=
 =?us-ascii?Q?Pn0fpbl3RjcS0mI2/I2TCZfyXNAAhUzO+1vNe0Yyz39gsOkcVf8uFP0o3lEF?=
 =?us-ascii?Q?2u61Cu895Ngyqs0/DI3Ou7fK+ysAlpwkQvxN85VbGhgF4aJXLhAcSDAkbVhF?=
 =?us-ascii?Q?Dw0rKub0V5bacz3FzFnZtitu5z8mtb/2tG/i5k1VnpKsYU2s3d2QytaQ+5RN?=
 =?us-ascii?Q?3aUb8ayIS4blpU8uLoFFbOqnv3dngqPYOotejvJFpSL8o8N5DiKK++qFEAUo?=
 =?us-ascii?Q?pp6HBQXFjOXaRUs8DavX6PYGqthpQY+2I7DFw0vqI1Uo1Gj0wgG/UlcpZtPa?=
 =?us-ascii?Q?fN5WrjOOXUrmiAkXDPr87MpS9cN4Wk/E7F12OOKpbavS71HraQeXFIeI4o7b?=
 =?us-ascii?Q?42j26vI+Khs0BeTK9ZdC7djorCL4FiTDUh5WIRB1yioawLx1eclQ8BPFuah2?=
 =?us-ascii?Q?0oxP+wG6kOOvC9jR90cOhWOAzt9NdHwL2N1h7lxRw9KK6LMgIT7J295gN8Lv?=
 =?us-ascii?Q?wtw6JSQCKpZ3wbZPqreSfbkxJS+uMT0ESfYhuRkb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c1d815-3d47-4119-2642-08dd46bd7953
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 14:49:35.4213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcyionAvP+5gNRnnOvpcYdztKBj8AF/ytX+rJRtkR6uxt1P+Pyu3+JuL2PnnVjlflnoglt4e0WMI9dPb46p9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
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

Reviewed-by: Pravin Pathak <pravin.pathak@intel.com>

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Tuesday, January 21, 2025 12:12 PM
> To: dev@dpdk.org
> Cc: Pathak, Pravin <pravin.pathak@intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; stable@dpdk.org
> Subject: [PATCH] event/dlb2: fix event weight handling in SSE code path
>=20
> Commit 6e2e98d6775b ("event/dlb2: support independent enqueue")
> updated the avx512 code path with support for the event, or "qe" weights.
> However, the SSE code path looks to have been missed in the update.
> Update the SSE "build_hcws" function to match the changes made to the
> AVX-512 version.
>=20
> Bugzilla ID: 1616
> Fixes: 6e2e98d6775b ("event/dlb2: support independent enqueue")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/event/dlb2/dlb2_sse.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/event/dlb2/dlb2_sse.c b/drivers/event/dlb2/dlb2_sse.=
c
> index 248d7519d5..f2e1f9fb7e 100644
> --- a/drivers/event/dlb2/dlb2_sse.c
> +++ b/drivers/event/dlb2/dlb2_sse.c
> @@ -190,11 +190,11 @@ dlb2_event_build_hcws(struct dlb2_port
> *qm_port,
>  		qe[3].data =3D ev[3].u64;
>=20
>  		/* will only be set for DLB 2.5 + */
> -		if (qm_port->cq_weight) {
> -			qe[0].weight =3D ev[0].impl_opaque & 3;
> -			qe[1].weight =3D ev[1].impl_opaque & 3;
> -			qe[2].weight =3D ev[2].impl_opaque & 3;
> -			qe[3].weight =3D ev[3].impl_opaque & 3;
> +		if (qm_port->dlb2->enable_cq_weight) {
> +			qe[0].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[0]);
> +			qe[1].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[1]);
> +			qe[2].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[2]);
> +			qe[3].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[3]);
>  		}
>=20
>  		break;
> @@ -205,6 +205,7 @@ dlb2_event_build_hcws(struct dlb2_port *qm_port,
>  			qe[i].cmd_byte =3D
>  				cmd_byte_map[qm_port-
> >is_directed][ev[i].op];
>  			qe[i].sched_type =3D sched_type[i];
> +			qe[i].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[i]);
>  			qe[i].data =3D ev[i].u64;
>  			qe[i].qid =3D queue_id[i];
>  			qe[i].priority =3D EV_TO_DLB2_PRIO(ev[i].priority);
> --
> 2.43.0

