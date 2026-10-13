Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31938CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151AA4028B;
	Tue, 13 Oct 2026 14:48:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3EC004027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791895729; x=1823431729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wqFhu+VyVRlPsRalTrQbw5RaqzjuSS5XmZRr1AGr5ag=;
 b=Z3sedjJ+J+ChdnK51cCfCW9Q1Tn9d2W5OlE728AeEITRDP3zbT/wieqA
 yObiSPMg4J1lS2/WIkrhefEdgozv9Psr3L0VSehXWOJmtoC7RJ0Eq/yZb
 RePpZpK8KVlKEh7JkJrqaRqqZLcl4ZXUyiZ/ODfrsnNdfwnXs0Up3WebO
 fWCYINKF0dfRF6DUcvmLmwnTPpsg3Hz/d5uLhTqsavc3p+qZTdM6gLFzB
 gQCVV93JOiX0ZVIVjWBEw78toZ5NjE4G85/UpAohY3hbQI+kcWTzdUAF3
 8Eecq1DsX5g09Uf6fdzFoqfmIPMzTYnYFfuGSty717GqbMPfK7jwes1El w==;
X-CSE-ConnectionGUID: 8TeVMcMLR/iOqmID8TPugw==
X-CSE-MsgGUID: xI3TC2kmSsacAYEMEiO8Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="627340"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="627340"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:48:47 -0700
X-CSE-ConnectionGUID: j/g5ZlNIQQmUbOzWRIAnlw==
X-CSE-MsgGUID: e90QC/YUTWCJsDrvm/IA7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2925034"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:48:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:48:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 05:48:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 05:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjOSmnuG1WSzIfv3TG5fPNVheNsPEjhKMEOJ8Bl+lxPKCNyH436K/4ee8bl/3WWJh279N9tAlfy2+/vQbIRFg6uflgZneXNwiTQWfWcOXRxytA9TpSTYDYSl1NuIsqL+XPfAyco4jRyqzekmaNQzBoqh6SXOof+TKKPfRGObcq4xFkJPv2iIyup+A/NMku9whbLli83lVBqVCBK3DDLEJfobgoCIEC1Xz+EgH1W87q3kkAy/AJhJdRiSu0XAR5iqVHVHF9mmby+LTIyoP773FGXaBmK1cCxsZVUnDwx6UDzIcc4YKPVw8VBBIroA8ilZKgUqfWwr9VcEQnE8FWMfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B1xdpVJSl3EMIlV6vkp7LL16NYbPkx2DB2eTD1e6zE=;
 b=Od85aVZ70nSOUMQMg23tokmWRn1yplg93apqO/087Fi1s8r8EZxXB0TVtJi1h8i1p9VPDQBPSVR2WuXsZY+yRadtHS45Bx+YW8U1WVpMx623Lk2TEYA2iqGIcYc24Ur0R326iAk+UMOw7zAgJSiHtcmqIlMm3Kh/7rAD6wSDHsapBCf9L0uUMIp+IypM2OT9xvLhIceq7bFKguj2mbeQ2JR2zXJ4GBnLX493GKlbrATnRFXeoKhfff+6VI2LwxbyoiBLB/swuOXJ9fuorsaAxB8msloegLiWBntSdbZ8QSZ/S9PYaHK/FhhPH2oqxsLnNVBZ/1b1dec01xAROtYd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by PH9PR11MB937099.namprd11.prod.outlook.com (2603:10b6:510:419::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 12:48:43 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 12:48:43 +0000
From: "Cornu, Marcel D" <marcel.d.cornu@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Nicolau, Radu" <radu.nicolau@intel.com>, "Ji, Kai" <kai.ji@intel.com>,
 "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v3 3/4] crypto/ipsec_mb: add support for ML-KEM and ML-DSA
Thread-Topic: [PATCH v3 3/4] crypto/ipsec_mb: add support for ML-KEM and ML-DSA
Thread-Index: AQHdWlIzuxLVO6tWBUODkwop5WNVNLb7ZLLw
Date: Tue, 13 Oct 2026 12:48:43 +0000
Message-ID: <MN0PR11MB6280464D02E46FEA3778C97CDA9E2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <20261012135947.1895429-4-radu.nicolau@intel.com>
In-Reply-To: <20261012135947.1895429-4-radu.nicolau@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|PH9PR11MB937099:EE_
x-ms-office365-filtering-correlation-id: d6ce0dcd-9ff2-430e-58d1-08df2928507b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10070799003|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: TqHQTDoIVTvdn0gGoKthTGECVqPufJxGHXF+KdLrm+MrfSokeqsjz2ieTE+Yss+HOoAVU2/GCoHNl0Ly8oAO6Ey60pkHH8QuOi8xu1yLsgDg+qmGbKPKgLgRyXQh6/2aO6tOI9Ysl9uSTR5KrjT1v/94hsta2u7ZVS+Uw1DNgFNlDaSGjBSNcam3J4PX+2kiuGDuURYNCb4E3JeBvBo71eh4mFJ+aFf4A103nT0mKpE3iK9lMtbILNb302ic5o1mfCx6YLfAgNRWrbn8gJ0dKE2MQnPpgQFfcJgTcWWNQepOpCp6sP5w1K6MYtnmMshOUVYO7/24aA1fSlNVFpt/XJrWj5Uj8FHrlqLpwLt1bXtBGLFL0zsL6ATrHHmlwy8IoNiZMVX8AatomMrAD0W50Uq3686ONyW7j6gOJLKZAkJjbMEc4pVTvif2wosqKGVpPEl2uRfyXcVamhdmrT/q2HtZ+tSHUQIj0kYvFPDZXXEgEHIaprv4HNT+NGh6Qj891ySLGzn9X3iRUIGEItkSWNB08UavYkBi71KVjy84svqOdR8VKpfs61plzoff5WGUddyydUItRl9e796R2OQmdqGcJ7Tt0Gf8/9/8xXuuBtiuX1IxujK7u1ePh6CWRWcaowDWGHxq+4frDpz1E7NjcG9IH/dJ1GGTNyxFYWTZASaamItEU7Ag52pXl54AGsSmZSHOQ+tEZy2eIrRhPtrX4MzH0m99h4Kcl2ZQOVoOMiQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iCntxRwmtlk2WSxQdYFBiEX87VTdFUcfiEqDgQHAZztIws6EqrRYIx+0YrFq?=
 =?us-ascii?Q?nqV8WoAz1KhS8L091EVwPSE4kMGa1a4wXWAaICG6jHh5YiMWnVEufes158fD?=
 =?us-ascii?Q?rcbYJwED4D9MVIoaBXENzUXc7IdiCpUGipaHKGt7K0f0OTar1kBcv5OoWFsu?=
 =?us-ascii?Q?oRr1aN0pspw64LXbUW5L79I+rfUIEk97/pJ1IH50rCjjX7gXzp7dIkJQ86CB?=
 =?us-ascii?Q?80uIYwQhWDsiWlUccHQ99m3S8mVrUWHO5SAnUlPzp9T8mjzvySDnMIhq2nsm?=
 =?us-ascii?Q?hcMHPnWxh0uUcYVmlteLOqLsG0iVt6XpZM69KK2A54hRIQe56Lpc+lV2tL3M?=
 =?us-ascii?Q?h69AGJ9i6iMhE5ocsZmsEOSEam1nhezv0RyQv0z1ofe1LYcOv3hFmPe/Z6qr?=
 =?us-ascii?Q?VR+0S3U1zKv0KmKAbCK+aauuXWYtulMa+jVLYjkOcKYcYlMdcXZW8+XI+Hrx?=
 =?us-ascii?Q?Ngnl/vs2+BINIUKzMFEWzvSEgTLRzv7ZpRAZ7oi4B+9O0boYnU0V6G10RNBh?=
 =?us-ascii?Q?MfFPt8egH9wdyK+LKYbuZJk/Zso3s5Qk3smFzET6YXsKRZe7FzHxuj5/7SyN?=
 =?us-ascii?Q?5wuKBj1BW5+1EsEAU7bckSRwx+IjK6vvKOJ4ELh8H8zGon0I6TT994UKn63H?=
 =?us-ascii?Q?/DeQPo1/cD9is+IX90LyxZxCQigLF1mlE/SKyI4pXrgcn9E8EPB3osbXPvz9?=
 =?us-ascii?Q?4RpUMZULlhLS3kUQBpq2wyNaUx/ZdTi29LeaJWaG7k7XzBEVYRo8oceqqEon?=
 =?us-ascii?Q?lXx04OSEscVYYp8yzxaBbmviQWKB5mbTelRPo3c/wYAXpl/9LbTvCvknYjOX?=
 =?us-ascii?Q?qK07f4BLtUlz6ouWhCxapQU5z+JDXY+Clj6L5WeLoH2/pFNzU1YPb3xG2i6A?=
 =?us-ascii?Q?GbVKjioSOzq2CerZt4HPkfQXH7X2B9Q5B4M1d+Vq+YKTy4tUsIH//Ygqrfnm?=
 =?us-ascii?Q?fW6Pp09ykx3AmmO3oFk9FMlNgdnJYdT6Yqn80D20UdXB4IE15/kXn8hfeseR?=
 =?us-ascii?Q?nj4G8lyAlmS78DgN6+JA1RdakgyRq1cvA7HqAK6ahH0wKn43eM4ob0r4gSFW?=
 =?us-ascii?Q?aTE83/JpiHzinjql8hkKIdBKnk9tfD70jHsi/AXas08nMudXzOBq3gkLDAV1?=
 =?us-ascii?Q?A04SE/Ap57nHdhnNydhdtJWRz4rHGOk/I3+8HbbbwVHL9vlix5ly+s6UBvWl?=
 =?us-ascii?Q?N+W89gvnLV4XbxygRYstAOOjfoScqzSsXAPSrmm/lEhaDiUGUJ9ofZqzC4c3?=
 =?us-ascii?Q?YoLVneNohekrdlKPhp98Sn9BvSL75AQwcSJMcL2wVy6+1NXclmBAx82IjtL/?=
 =?us-ascii?Q?+ZYlCU6itwhMunyoq4rdl/ShF3aUt31uHEnkwdVMNwTwkMlSvOdpfLgX7LNM?=
 =?us-ascii?Q?UN9kVo5ic20TvLUMGqfEAE3Uc4Ic811nhm4fTVXh4RlLJiQVVIUvQg2LT2OX?=
 =?us-ascii?Q?zBRtUwTE/XfJIGRrGUV/AVAuXhStagQXIwJtIjKRusFMthok7T6KdCYBDXnY?=
 =?us-ascii?Q?8oY7iDAb9YrXtXS1IwXQ9dbJCk6XW/A4M8lm3hOA5KymHB7Za2TTPUa0zPLj?=
 =?us-ascii?Q?QV2vanbpn35kstSUtOsoyoxklftRwBAIcilKnwFiqC2ODnRseReAk59sj/2W?=
 =?us-ascii?Q?A8TwiQkC+nKId4KoJpuhmJxH/kjcYnD+lLPBmMXuizGngxj2J5XN85phB4Un?=
 =?us-ascii?Q?JN/Yw+E6LRKUm8WaA/zEd4b1AfmKTDT3DLlTbX1N7iqa5k7Y/q7rnBzYlcrH?=
 =?us-ascii?Q?rTgbOosMtTe0mkvwghyen7WLmYotTIHTuW1HOXMprxafO+v9KAMRZq+jPPup?=
x-ms-exchange-antispam-messagedata-1: rbpexIAaqoBQ0g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aanZwumlJUTQ29lnO075SID7xzJOKkUw0AWEiSsjGLLB9K+0EdPIGazxiEFKi6JUYiUWkLmtYbDqDM1IoosJiAOvlg/ED/BE21oRj+rQFeYyd8+A8PU5vmvohyqPVaSaXfT3GcCKGZpeu5Jkf9TEhOv+/nrqMkSpk12RogJFdbQR6d9ruS00qDhruHPLQa2MV+kaLaNyypHvseGGz9ip2Z8PIfKC89U3U+tGbuAglXNV0ccORU7EmRDGJqB6SoHbrK7n7X1REjaXC18NIRmMbXi05y3aE4w5CD4ApFhuIy4JVrrj7R4mQ9oWBJ1nQMbHV2Kj+quM2qN+SF2JkdmF5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce0dcd-9ff2-430e-58d1-08df2928507b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 12:48:43.4979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C9piXLx/9sgMJmB2Kjly1loRDkvsRxCCk+DCNAa/T36bpRnyqCznXO4aUiD16W3vrOjVxayjiNtCXQ9G6cYRYDDYXmgoM4gZ2DUO13LKmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB937099
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

> diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> index 50ee140ccd..308775882c 100644
> --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> @@ -453,3 +453,61 @@ void
>  ipsec_mb_sym_session_clear(struct rte_cryptodev *dev __rte_unused,
>  		struct rte_cryptodev_sym_session *sess __rte_unused)  {}
> +
> +/** Configure pmd specific multi-buffer asym session from a crypto
> +xform chain */ int ipsec_mb_asym_session_configure(
> +	struct rte_cryptodev *dev, struct rte_crypto_asym_xform *xform,
> +	struct rte_cryptodev_asym_session *sess) {
> +	struct ipsec_mb_dev_private *internals =3D dev->data->dev_private;
> +	struct ipsec_mb_internals *pmd_data =3D
> +		&ipsec_mb_pmds[internals->pmd_type];
> +	struct ipsec_mb_qp *qp =3D dev->data->queue_pairs[0];
> +	IMB_MGR *mb_mgr;
> +	int ret =3D 0;
> +
> +	if (qp !=3D NULL)
> +		mb_mgr =3D qp->mb_mgr;
> +	else
> +		mb_mgr =3D alloc_init_mb_mgr();
> +
> +	if (!mb_mgr)
> +		return -ENOMEM;
> +
> +	if (unlikely(sess =3D=3D NULL)) {
> +		IPSEC_MB_LOG(ERR, "invalid session struct");
> +		if (qp =3D=3D NULL)
> +			free_mb_mgr(mb_mgr);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D (*pmd_data->asym_session_configure)(mb_mgr,
> +			CRYPTODEV_GET_ASYM_SESS_PRIV(sess), xform);
> +	if (ret !=3D 0) {
> +		IPSEC_MB_LOG(ERR, "failed configure asym session
> parameters");
> +
> +		/* Return session to mempool */
> +		if (qp =3D=3D NULL)
> +			free_mb_mgr(mb_mgr);
> +		return ret;
> +	}
> +
> +	if (qp =3D=3D NULL)
> +		free_mb_mgr(mb_mgr);
> +
> +	pmd_data->asym_session_created =3D true;
> +	return 0;
> +}
The IMB_ML_KEM/DSA contexts maintain a pointer to the mb_mgr passed when th=
ey are initialized.
Could the mb_mgr passed to asym_session_configure(mb_mgr,...) be free'd in =
this function and the ML-KEM/DSA contexts be used later?
If so, then that won't work as all ipsec-mb ML-KEM/DSA APIs will use the or=
iginal mb_mgr internally after its had been free'd.
See: https://github.com/intel/intel-ipsec-mb/blob/5d1f646e5011183725329694e=
dfcf8b645f9c1e6/lib/x86_64/ml_dsa/imb_ml_dsa_api.c#L16
