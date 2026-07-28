Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB4C531C9
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 00:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66E1D40279;
	Tue, 28 Jul 2026 02:22:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A0EA1400EF
 for <dev@dpdk.org>; Tue, 28 Jul 2026 02:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785198125; x=1816734125;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=lylHgOYrr1V8qrpO6TpTrieKGXya4zr9LZXjcFu+QXY=;
 b=Yov3qxkcXry1OTJmX3WTptVCCj3MCM4yb2i0GMjOMAl8F+3UVe1KZNXA
 8bhzTcaC6ZL2mLp8ZV4sX+xcjIBTYPaI2gl1P9ICUUYpOXa6AWSn1pMWu
 CH+tE0tvyoihsQKIVNMQyJM8wdKEmdIMQ5J5D5UMSW1V3adnGcR9fgy8+
 AsE1++4xuhhAgUVg633HCHxzwFoJaZHf8DpVkU54BDZ34dHFSnc99cHX8
 a55JW0yFIR4meuLCg6iNF05/7Z1V3rnEhAZ4+EFHstnQEcrx0l3twvJbm
 xFjg+pj5hIjgRahzlxxd9gV3Qnrtbser4f6dRxCXtsACXEjCq8rVX/eb+ A==;
X-CSE-ConnectionGUID: Z8f67rAPTRqm70/XT2Vo8A==
X-CSE-MsgGUID: OKCVBvWpQ4OcXmdamA1cgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85788258"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="85788258"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 17:22:03 -0700
X-CSE-ConnectionGUID: w4O1DgH1SBqT2a+gXM1MwA==
X-CSE-MsgGUID: cHgOHRoYR6KJod8dx3HaHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="260200184"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 17:22:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:22:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 17:22:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzOh8Sl5fWQtmwuulXfvie4WFQ2EPY7ll19DPEZ9vE9k/fWRQKFYZbahYsoHH+jqIxIGjYaIv+sLpH1Bq3KQkAa0lmspKDsuA7zSNnSvDu19amMIP0LduJGAlOCzl7fP8Kv05JxuZ6AeyuLjHlsDCEb6qKB4tYBMGTGelmULNMsRDNiWXsTo9WpXDdMYBYPHNqEZf4m269BPlzudkRnqevrsOLCwtOCb0DcmQSU9gVJ3bUvG2EKiDrsujFNLgTOO97BkOs5i4Bp8mnIapevzUmBaczZ8Fsga0RMzrIMuBVHowPJEDuHpy5g+sg4fQKTcsuJ6x6rfxXpknS9N++stqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7kx169+WVszwzZunEG8bu6PcrOyj0luvEsZerSO9ds=;
 b=QaIa+VV0UM53j4GzpzmRVb8wzLkzZKMl07zFT11S/AuW/HEUdgayD94fDIG6xCkSNp7n9fEaTbp44Ev+ne/3AVvjUCUlViv9et2FnHyR1neHO8J+D7eMdKDzykjr2gh8hQBFQEEjpZCTpQ4kEgZ3zpXdUVUZqRTOQmH+914aGbbpwX0Rh/mayOkOhvKEqZqYPS/mdk18gcIsbhGuPy5lrBdRyD3kMko0uFKiDT/ay8Bg0sKKy8DpexdXTp8EstODI4RYbNDjxoR/BSnq8y/7/3SO8gfDQvTh5/JtLt6Pvrza/1O0O4MOtjlg2sn3CzNxjsVU7a9kJny7fp2gBDsDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by SAWPR11MB9924.namprd11.prod.outlook.com (2603:10b6:806:54d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:22:01 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:22:01 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/iavf: add clock read support
Thread-Topic: [PATCH] net/iavf: add clock read support
Thread-Index: AQHdHbJATTIZ/Zk6zECiD1SV+UxPoraCEnnA
Date: Tue, 28 Jul 2026 00:22:01 +0000
Message-ID: <SA1PR11MB67821735808A078F36349C5AE4CB2@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
In-Reply-To: <20260727102444.789833-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|SAWPR11MB9924:EE_
x-ms-office365-filtering-correlation-id: ae7acb06-0579-4622-546b-08deec3e3e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ejN5B9fXOAMW9kfhSolhuESU2rWPDa7BFZ8N1pHz9gcVueFfePhhrs3Olzj3+FnGz9VHVHodXBrlYE6c5fxeFp9wmEbArL6+2Jn9neZMKekhveUr2mZTNWfeOGk7Emwjm60Pcy5ZayhiH2UhpS8gCtEmlhO83usoM7uKK3269n1CvktYUBxT3LHqTDOmzXZPQZlZ/UvxBUjx5DTvewksPUXziOl0LKUEXTDgFQR2n8Lc5SprVwzjKCx1IK9NADA5EmCqTCszqCfkVOAjND3PTcfmvCrAqc0QfWZE88Kom456yyyEb/R2xxZ2oJ41vkpQnmh/YMOOJR4ieqEXRck4yTJ9ljDDQ1mMwYUFihhZrDiKdQrKit9py3WxAOR3hh9fxIwVyO5JfajMVNB96g26rm/k3kEJ4oxSTSeyf+Y9nDOWhWrhGyxmlfYi4T+hkqWEj4JX8H19QGsQYOwEBC184vbaMtJSDkmJKE7e28YnduiNC5ZK2idqftFLNvJgv3CirXnty06HHpvNsjhiZZzmRpXgRECo32JvpWKe9tVBAoZgdMeOaiTqgBw3uVz0hXQRG8YmOMfbHsw1Nk8GDI9FoKcQ8L/c1T65F7ORVeUZkADsXod6c2ckiUykWyoZ9hT0LPVZKyS/I59VIvnKL3e/BTOH06L2iBvlgzDT8OLWL4NhR1Qq95zFDRikR1fTHLLx7XsrEuPFg2mG+PnkTwBaoihofhoOt/Asq8iLZi6CVaU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qhCIP8MDoeu4TluyJsSUA5Qm8sYb5L6jN2v7ywtosYT5n1IDmtaKFaoaMozQ?=
 =?us-ascii?Q?1D8QNBYTpJAzAtRvGLKEuvuZeCkml1yD4AThZ5ttCRp6pnEHO/ljMwpWmH/U?=
 =?us-ascii?Q?Yfu2OZMP+DmgMqzMErEb15xG28rtGuwGZQyKRsvdtqS2GmfDCpZX1rASV0F5?=
 =?us-ascii?Q?LJ+2YesozQK7vbDfPccvwD4xxaMVj4mkf4HpDnSEGZbKE7Yq3x+wKF1zXw7X?=
 =?us-ascii?Q?B7i/jHrHBDOqvbQy7QDTuCCrRfxXVRcXxEX2FM+NfL3Z52b06viRmzWQbuSN?=
 =?us-ascii?Q?UcEmUxaIatrpgXn19veIGMXh3dHVcW1ys6HWL8QBos1zdg8LMNEvUunmEg1V?=
 =?us-ascii?Q?mAhdN+UOaZCc7+W+EsGxAGEW5Dy5lDyLn9cxBKdhCizGsdket/57IKVl7idb?=
 =?us-ascii?Q?uFtK+czgyJGbchnihQU1O8Y6fviCSw2aNguQasiam2PmHEbXoFqHYhA7X2pX?=
 =?us-ascii?Q?1t1BMDYyBmtPu906vPQbJkFX27UCV3PtNoiMxLWVusU0yaQyJlC5uRSzlH3m?=
 =?us-ascii?Q?APkySeIJCbojFckrSh05fvHb4KaNgrNFDkbhjgA+HwGe4oJowBEZeGkBIVSL?=
 =?us-ascii?Q?q4SLgIC7Uo1t40CD+v/LgwQZUe3XCeg7kaJxCRJ4LE7VTPegcSizsUHcgYMk?=
 =?us-ascii?Q?uK7NjuG4RFD4PV8rqAlP420BfEzcdlo9bUEMb9zz+Ln0/dzK+8QbUeRnC5Dd?=
 =?us-ascii?Q?ZIMB/RgQ+MUmnSgn6ed8xzXqUT/NAs+8/eckkhuQmXYG0hXbj7b1L0mVUfdj?=
 =?us-ascii?Q?OnIfpVcbvn1YJ6kquQjph3lriBuRoXpLgFY8Lb2+ZRyzJ9ucf4myTEv3nNTF?=
 =?us-ascii?Q?PFLOroa/A8BZKG7FSvDnlzo3d0fPd+3nVP+z6Qayoi8AFrO8YwZ8fNV2TiyF?=
 =?us-ascii?Q?0aZeZQXGJDd8xOjRi6eO2vRroMdDbQ8hP+znqY1t41VI2kGdO9FolYxCk6xD?=
 =?us-ascii?Q?i56gNa89zsfNsqNaYROB+5yEVheNp5BSqk27d6rp8Su6PhZoJ3RhgZB1YQ2C?=
 =?us-ascii?Q?HkxrPjMeI95jqnve/pK6oNHogI0uEIF7t+HM379hjRSxxZmeb8R8ps8hDA7T?=
 =?us-ascii?Q?HDGv3+QmIcLtvXTRhGTYpf1pY2HqnouGwpJG5ni9R85FiAfv/NzauoV+QOez?=
 =?us-ascii?Q?ZKThkGFmKEIntlyUraS4ZIw+ePQgVZQjL03gD5kO6tkklKq9Gd/nqme8mhvo?=
 =?us-ascii?Q?2dY1q890DoLuTTa6Y+JDTfZcPJv+7m8PYpK7VfgxfUu6wv00YuTNVDIFIptL?=
 =?us-ascii?Q?FTZaqJ2dJ2EBSDkimEEMgf908vwWq+Aijtatpqlz/dr670reLBUQyDNlmeF5?=
 =?us-ascii?Q?YsNeIG4i7gHwZsWUVVXjo7PcLwdwa+OuX3XIBEsq+SR3eCRsXpS7JVD59h7M?=
 =?us-ascii?Q?mtBygVF0JoEt/hgg7CmsQHHP7jXyrISOqvbWAr8XsTsCrCH0fSczD5Q5wCs+?=
 =?us-ascii?Q?pSLncMugU5bjH6Ne2KcPzaZdndH1ghBOhFf227BW+phSp7Crdf28OjuvGvWF?=
 =?us-ascii?Q?IUDnTiat10A9UDQkMLvsCxh0Up1bur0UmEOrsEu3xQg+fPGEBawQ0iq69NkH?=
 =?us-ascii?Q?0bb0/nUKItfVHKvtjuFCFo/P10AAl6vBbDiYrDk7+5qGTg5m5P2C6JFCw2VB?=
 =?us-ascii?Q?KBO44apZVz2KhOq2BrJs7rglvhWFOwiOJXNWHtLDl98spEoiNl68RYfDafoG?=
 =?us-ascii?Q?61ADZwGUCbxgetSPwaw8X6n3OVJWyuOKCHPo42pMwkCLCN9iwoAzvHB8zGgS?=
 =?us-ascii?Q?CawHfY93Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cfy85bdpZbrzmpq68m2wLDfofPxs7cfNzl7dUE0KOq5r0fnFnYAyVWJrjqE8woS0Cfcrdf0A78kdiFY0fSq1ZVxuFeW+AChRL0PRbEy+If/x/IoLr0zCvfGgrUciQGctGR8y3LRFVuRGyjGPjiXL1u0OZiDdHJbS26YFybMOQgPhJP+KDVXj9B4IkeVOXY8Z9wVGXt9ufqsw1E2NfMICHyJ+hk6WtP+GnQU9nUMfwVdIUMDSz46IQdUlP/JlsBUbuFjERqQ2eCcm3LL95lqlTLtjQsMNmKpz1LFs+jL970nFzRYUiBzKh4weGwrFI/Z9MF9Hn0RpseQomLvtrKXaWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7acb06-0579-4622-546b-08deec3e3e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 00:22:01.3794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GJd8rfzWBRd1Nl9U2iFF4tTbXmfSnzxYLOxiTh/4CzFL9xGoTUuX9ZyvNxMUiyDzzcYKUSo2WJtQyl3goBW7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9924
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

Recheck-request: rebase=3Dnext-net-intel, iol-unit-arm64-testing intel-Func=
tional

Thank you.

Regards,
Anurag M

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 27 July 2026 15:55
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Mandal, Anurag
> <anurag.mandal@intel.com>
> Subject: [PATCH] net/iavf: add clock read support
>=20
> Implemented read_clock ethdev operation by adding
> iavf_dev_read_clock() feature to get current time in nanoseconds for
> scheduling packets based on transmit time.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  3 ++-
>  drivers/net/intel/iavf/iavf_ethdev.c | 24 ++++++++++++++++++++++++
> drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
>  3 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h index
> 293adaf6c9..cf2b6596d5 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset);  void iavf_set_no_poll(struct iavf_adapter *ada=
pter,
> bool link_change);  bool is_iavf_supported(struct rte_eth_dev *dev);  voi=
d
> iavf_hash_uninit(struct iavf_adapter *ad); -#endif /* _IAVF_ETHDEV_H_ */
> +int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
> +#endif /* _IAVF_ETHDEV_H_ u*/
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index e475b64971..1a36885107 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -165,6 +165,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev
> *dev,
>  			struct rte_ether_addr *mc_addrs,
>  			uint32_t mc_addrs_num);
>  static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *a=
rg);
> +static int iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t
> +*clock);
>=20
>  static const struct rte_pci_id pci_id_iavf_map[] =3D {
>  	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID,
> IAVF_DEV_ID_ADAPTIVE_VF) }, @@ -264,6 +265,7 @@ static const struct
> eth_dev_ops iavf_eth_dev_ops =3D {
>  	.tx_done_cleanup	    =3D iavf_dev_tx_done_cleanup,
>  	.get_monitor_addr           =3D iavf_get_monitor_addr,
>  	.tm_ops_get                 =3D iavf_tm_ops_get,
> +	.read_clock                 =3D iavf_dev_read_clock,
>  };
>=20
>  static int
> @@ -3662,6 +3664,28 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
>  	return !strcmp(dev->device->driver->name,
> rte_iavf_pmd.driver.name);  }
>=20
> +static int
> +iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock) {
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	int ret;
> +
> +	if (adapter->closed)
> +		return -EIO;
> +
> +	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
> +	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
> +		return -ENOTSUP;
> +
> +	ret =3D iavf_phc_get_time(adapter, clock);
> +	if (ret !=3D 0)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
> RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
> RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci"); diff --git
> a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl=
.c
> index f346837bf1..a63639549c 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -2521,9 +2521,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)  }
>=20
>  int
> -iavf_get_phc_time(struct ci_rx_queue *rxq)
> +iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time)
>  {
> -	struct iavf_adapter *adapter =3D rxq->iavf_vsi->adapter;
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
>  	struct virtchnl_phc_time phc_time;
> @@ -2543,9 +2542,17 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
>  			    "Failed to execute command of
> VIRTCHNL_OP_1588_PTP_GET_TIME");
>  		goto out;
>  	}
> -	rxq->phc_time =3D ((struct virtchnl_phc_time *)args.out_buffer)->time;
> +	*time =3D ((struct virtchnl_phc_time *)args.out_buffer)->time;
>=20
>  out:
>  	rte_spinlock_unlock(&vf->phc_time_aq_lock);
>  	return err;
>  }
> +
> +int
> +iavf_get_phc_time(struct ci_rx_queue *rxq) {
> +	struct iavf_adapter *adapter =3D rxq->iavf_vsi->adapter;
> +
> +	return iavf_phc_get_time(adapter, &rxq->phc_time); }
> --
> 2.34.1

