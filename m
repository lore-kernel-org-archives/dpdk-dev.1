Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938FCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:04:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DF614068E;
	Wed, 14 Oct 2026 18:04:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 613AB4064C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791993838; x=1823529838;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PpWvF+ez7a7pLDXF285RiXp2qt6W2FqgTos/1SdPmd4=;
 b=WYDG6y5XSKwcDXgCTdEg3aFYJkxweh0DYzP0J13OBYtyGBxYW6MInZzt
 6RfIVVrjZXBTBntOcHa+qOveojG9ZeWMK39bRCiJ0RuTB1Nd2qfy6YmqH
 M2E442IHh7ys51/Hc4vUVb2f1ug2eFMR2VkDsiEZK3D9W+fVri6m9ReLa
 TMTRUB2JAzc24Pa+AwSWytdm5z0ephbRAv1i5iKUT3HPfUz4bkfZWxaxz
 RNIqrCsQ+fw5YiTtwMS9sJMrRV+5kpFhm1Wa61v2V8jRWpFWYPBghjail
 OFDiYLuRgRiSJtLj65ZdPseFVhNcJrA3UTldRA3YcyOzzU5V0tmjPRouh w==;
X-CSE-ConnectionGUID: gYg8ID+PRYaYJnI3iL58pg==
X-CSE-MsgGUID: W1siYGlcShiza8ohMOmZAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="643370"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="643370"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:03:14 -0700
X-CSE-ConnectionGUID: Of+tPtiIQ6qeB7nYVJB9xg==
X-CSE-MsgGUID: 734N0s1mQEahe7kTtG2/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1483296"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:03:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:03:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 09:03:12 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:03:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRGY+ac30Fl5RGjfZWd4WCMVWFGjzrAuDu8/9fir1Smz+fN3SxdVEvcpPk+adyBH0DLdybUK425BO6oT5xhX1PE87KBcnuPfM9lh3YQGtU7Gm6FdwGvgeJ1S3ZOKIOPNREJn+dEmvN3aXanafQSyNvSCgq9ExLGrEPM4Y4pr8YV1u+JvfEKOh8KlBqOp6XRChbxf65+12S3RwiQWC1/gxgBfN1KdrM3Kt0Jaj70TbZPZIeU6++hbSQJMjLJ4brneX5TUji4vAnOpwyrHd0NN33VOyeNWbNxnilZMbqJ5wowTuPx3hz+XcicxgRXSCqkcW+JbQTApHD8t1OSbAWMb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prW1kuB3bGWx7jXD/D+GuckxOB0WBWYyBJ8M5h/yXT4=;
 b=ysb0S2BaZtzTCrMI3iBq1haQqbGC+sawbrg9/XWmq7NbSfTDewVBq4DGWrh5XPWuxhGcKwYJWQOeh+uDUw/dWLxLeSYINxqZd3jZkecQEakeeu5HkM+dDkcKBvF+mjJYFmg9f2v20R+dUi53zEuFnv5w4p/HtFe2vjGvdOujnWrET4JeyAvxA79z6ey8bX4b6ht+9ogf9gMxtbJ2f4I13/IaZbg8Ct7sWJDyqDoeQo378vPTzgXPUqnycyhk73ZYrEe/AgYlNq34o9jJr24V0AlK/PYwooFO1rJSPseQyFZbUVtm223V+UMwBg07OHCZYX7kw3YljbH7ZTbv/JgRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by DS0PPFF95D191BB.namprd11.prod.outlook.com (2603:10b6:f:fc02::50f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 16:03:09 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:03:09 +0000
From: "Cornu, Marcel D" <marcel.d.cornu@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Nicolau, Radu" <radu.nicolau@intel.com>, "Ji, Kai" <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v4 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Topic: [PATCH v4 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Index: AQHdW+eSYgX1XaCnqE6IpEgImX05uLb9HCvQ
Date: Wed, 14 Oct 2026 16:03:09 +0000
Message-ID: <MN0PR11MB628087CFAF27359BC8926B2BDA9D2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20261014142217.2117229-1-radu.nicolau@intel.com>
 <20261014142217.2117229-3-radu.nicolau@intel.com>
In-Reply-To: <20261014142217.2117229-3-radu.nicolau@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|DS0PPFF95D191BB:EE_
x-ms-office365-filtering-correlation-id: 871d824e-78f9-48a6-22d1-08df2a0ca448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: nGdZbb6mZNndylmqv+7795OraLTmUkmfKPXu1nP1Ugc7VhY9JwLjP7gQwgKfZqR+5OF3BOK6I4kn9ahnq0j7WP0usSWeX00BxaJ8Ma8jMLuwUz7h0GmKe0SBB9tiKIKDPWOA0OFCSbknEltR8Pa/1ZK4FlzZCgiOHmCl3Y0S1eFE2nO7C3nIO8Ogz/5xakUDZo0j9hRU0yhUy6kK5mBj9W6Ih8PatvqRNflwzyJsVdaeMLDv2j/OUwMttNDaJ7wDUzhTDof560qDdKWR7tOqj9wCavgWQ25OuTe/MzcYjMjgrH1dsvY2tDrKmKU0zHuyJjBkF/RGT+AOtF1ud8CH2fDLVMtEUJ1VzD7A2xpVaO6ulnUD6d/OysOfuXetaIJv/9An6Jjl05L2szOBK40a4ZqW6lmlDEMVaEB+Z83HBkHEvkrUL8L1HWHKuU1CxdeqpCiZiLrJ7rCEXsBwVScfN0yQRy0Q6XBBvXIgb4b/6uz9s676dyhpnwprFsZxEU1tWOlfxyiBEXTryAjhMmsHLqOULMJSpROtFVphJKYnPPK8reY3PkaJGhNUe4HJ79l1+yB6vbR+r9okMGVtkmkhoXlmgPqz3rIQH3HM8k1VO1CsIAO4O0yegUVLFvSgfsOZHtCxfpA03il2qAfNyKdeksUY6RsOKI78awUwZ4MENdnhebk0e/2ZDC0Lzgtn3H37wAaDyyUUv3wHTdaFMHaNyQIyw+lTPAZq6uHyQcEWud0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGa9PI6doMaGf+qsQS2oMqFDtxQFtwcy93l9+gAPfTlOxhv3ou0YNKHLtf9k?=
 =?us-ascii?Q?F3RtuvPKO0baRKAk1SNHxeahesBQyVuJ4KP9New+R+CMl8OnlIyWCCKBgItI?=
 =?us-ascii?Q?DgLih6baKXHWDiCCIq6gq4B68lklay+3dxEdt/kvRN0kxo3eSVIw1uI6Ardr?=
 =?us-ascii?Q?IlHHlt5CfwlXE+RH2oKWMiXyD0NGwkrU9pRpinb4zzkrwPYN+/Sj6b4GK1Vq?=
 =?us-ascii?Q?iesdfgA3ksYJxii9nISPQPemRbUYxuwr215Mk6Q3bXD4dIJuokSnlVc9MOvo?=
 =?us-ascii?Q?aVMuITzWrN4IZFocKd97jzmJlkiY+41VONIWoxndw4Y8O3Aw3aJoR3d6NN35?=
 =?us-ascii?Q?Mt1m0Afe0Ao+KO0mJjzqsYnrYYKJ1mpWDXxyE6WwBnR0TLSszZGNKiLcUfit?=
 =?us-ascii?Q?prXao6cshIWwfjqx7OWr7Oy4aDk+xmUMLnUv/Ygwi+jOiICu1VvGwku0TDUb?=
 =?us-ascii?Q?E+jlia6XRduyam9DhvJJovpQhUiivyvW9qE2+MqnV6iOC07omz2oHyMopV+C?=
 =?us-ascii?Q?rv6HESLeQbZeTeyeySUjBwP1uVUU4S6R7gHt1broO5TxJyhxa6eIvdeQ1gIX?=
 =?us-ascii?Q?ZdLe+F3EXjj2HxNkgfQDd2jyRcbf9L4IeC8wU8gNxVUAPD2RFt8CljbQtilw?=
 =?us-ascii?Q?FnGXjoqlK+LCu6cge4m2jPgd5HhrbKJQM+yDrYG8VnWMS81Ff6/BNRiBwyUx?=
 =?us-ascii?Q?LaBUu+rTwSuqVlVatZDT3+T2T8qDQ5xYF2PMF246Wg5GBDogsCr67xB3JqHi?=
 =?us-ascii?Q?VFWFMDvFZGAhkQ8bll5VmXLvt/D9a7h3K5cJr5B9mmBwcL5DYZLS5GGiyXZx?=
 =?us-ascii?Q?ZPoz59ZsqjDJANDWiI5JFYM5f2qlbLliWlApZlJZFU/PUgbAX8Sz41gNrUR7?=
 =?us-ascii?Q?6dhtZjvZqXozq60IBrgMbGM5kmDskl5WeR6c89gRIFZL8HNctKaQdFkWVRja?=
 =?us-ascii?Q?MDIH24SldGoMKS4glMd5dMIqH8JV5pGprohOrT8VddE/wuTJvED9xsyhKAiO?=
 =?us-ascii?Q?JSWgByA2p4+HenA8h0VOhykr2Ri8h0KpEratQOyJ5BjdxgmH/sG9uMz4mCb6?=
 =?us-ascii?Q?JTyH1dTvHZaGA06oVAM4EoWNxjbd/Sgi8Ai50/7r213wxa7PWx5KLiz1edFw?=
 =?us-ascii?Q?2UfxhR07AfEWWKEfFavPoxYjZzIkkpzW9IB6px3gQaZ6GzBxdHiUk1l1ItvN?=
 =?us-ascii?Q?VnRSF6vFs2pG2ZhsRW7gLcy7uD4L8iCuGQy3HFmNMli20avLPzKrWaGBF8a8?=
 =?us-ascii?Q?ih1NbyLqkQ9n2MaN8aEZ6c9JS/x1kIkUQRf/1ZO1YuqRx6upplbrRitC9isr?=
 =?us-ascii?Q?AN0yFUik5C8PX6iEjnyuHiTBhzENCrzAeGZzDRKoAHyHDmmQOmcNKPK/ITet?=
 =?us-ascii?Q?SNaHsrhZmyWlJ/XtgV9UCL7zlg5APejWcFlnMGdT/wvXvCgT0Xoe/q4gMFyv?=
 =?us-ascii?Q?dVEGd1Q3XrQJLvXlXthYCOzqlMIbkQJOOUR7ZV/td6yVedCCV3D0SXSPumN2?=
 =?us-ascii?Q?899HALMXrdtznq2D/6+KQpL9pKc7nUTXBjvRKALmVivmlQofaiFM6QhP7H1h?=
 =?us-ascii?Q?lNGBtjm/fI6f9yddLG11GRhmxxlJqgKJf7pj6GTTTatDj0Q818FDTidY/xj1?=
 =?us-ascii?Q?LU5GX5qEbuMuJmF4dL8FQo4CILxdEXPeJ1DP8U4JMlvwnja/AE1M2doTO5rc?=
 =?us-ascii?Q?ZNNBDS5D3ltuZTrrNWpcVLQBFOWMsPKFc+o2VfY9gmJuoPcn6aHjqZE4g+Ph?=
 =?us-ascii?Q?2mhIdlQBSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1FXGPTt4M1c2ChGseMC+aOX2raxhymgrB9yoo/c0+LcEhRB5cbMjQmIMXeVG1dos7i3JxYXMKQ9RUf+mVY/uXz/P8co2cOPedUy+xtb17EpjOSu/HdkNH0YzJpweHYM8wjysj4spCTisZv3vF15KJ0c/cb+0Xt5URS4NKUqbVYoP4ddCObt5uhjDrKCqZ3groAeybko9R7vAXfij9rpz60an20d1zlEgtX46MkCVlX4OKkgl5ZUgTZ5kTa3BKRfLSX/SRehiZcSXLUJJwzUMSbwJiPDFsJdafcF4V63b3iGDP1yGQUWza2TDjGdZO6vXBoxbGAD9ZTb0KDtjKA+U4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d824e-78f9-48a6-22d1-08df2a0ca448
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 16:03:09.3524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOgm0AnnCrgg+twxiP6mlncu2d9CjBC8D2HzEU2ugtpm+YBdfVymaUBlfM0IggRkBfyspDLJgGy62xyLMOdvSPgIpWOyPocG0oOL+bgKMJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPFF95D191BB
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

> a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> index a2f7f9abf8..dc07d96aad 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> @@ -18,11 +18,18 @@ struct aesni_mb_op_buf_data {  static inline int
> is_aead_algo(IMB_HASH_ALG hash_alg, IMB_CIPHER_MODE cipher_mode)  {
> -	return (hash_alg =3D=3D IMB_AUTH_CHACHA20_POLY1305 ||
> -		hash_alg =3D=3D IMB_AUTH_AES_CCM ||
> -		cipher_mode =3D=3D IMB_CIPHER_GCM
> +	return (hash_alg =3D=3D IMB_AUTH_CHACHA20_POLY1305
> +		|| hash_alg =3D=3D IMB_AUTH_AES_CCM
> +		|| cipher_mode =3D=3D IMB_CIPHER_GCM
>  #if IMB_VERSION(1, 5, 0) < IMB_VERSION_NUM
>  		|| cipher_mode =3D=3D IMB_CIPHER_SM4_GCM
> +		|| cipher_mode =3D=3D IMB_CIPHER_GCM
> +		|| cipher_mode =3D=3D IMB_CIPHER_SM4_GCM
> +#endif
> +#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
> +		|| cipher_mode =3D=3D IMB_CIPHER_SNOW5G_NCA4
> +		|| cipher_mode =3D=3D IMB_CIPHER_AES_NCA5
> +		|| cipher_mode =3D=3D IMB_CIPHER_ZUC_NCA6
>  #endif
>  		);
GCM and SM4_GCM are checked twice here in the 1.5 block.

> @@ -1793,6 +1968,29 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  				session->iv.offset);
>  		break;
>  #endif
> +#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
> +	case IMB_AUTH_SNOW5G_NCA4:
> +	case IMB_AUTH_AES_NCA5:
> +	case IMB_AUTH_ZUC_NCA6:
> +		job->hash_start_src_offset_in_bytes =3D
> +				op->sym->aead.data.offset;
> +		job->msg_len_to_hash_in_bytes =3D
> +				op->sym->aead.data.length;
> +		job->cipher_start_src_offset_in_bytes =3D
> +			op->sym->aead.data.offset;
> +		job->msg_len_to_cipher_in_bytes =3D op->sym->aead.data.length;
> +		job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
> +			session->iv.offset);
> +		break;
> +	case IMB_AUTH_SNOW5G_NIA4:
> +	case IMB_AUTH_AES_NIA5:
> +	case IMB_AUTH_ZUC_NIA6:
> +		job->hash_start_src_offset_in_bytes =3D
> +				op->sym->auth.data.offset >> 3;
> +		job->msg_len_to_hash_in_bytes =3D
> +				op->sym->auth.data.length >> 3;
> +		break;
Should NEA be added here? Is it falling into the default case and not conve=
rting to bytes?
> +#endif


> @@ -1058,6 +1285,13 @@ struct __rte_cache_aligned aesni_mb_session {
>  			/* *< Expanded GCM key */
>  			uint8_t zuc_cipher_key[32];
>  			/* *< ZUC cipher key */
> +			uint8_t nxa_cipher_key[32];
> +			/* *< NxA cipher key */
> +			struct {
> +				alignas(16) uint32_t encode[60];
> +				alignas(16) uint32_t decode[60];
> +			} expanded_nxa5_keys;
> +			/* *< expanded NxA5 keys */
Should there be identical buffers in the auth struct for NIA5? Will this be=
 overwritten with NEA5+NIA5 combo?
>  			snow3g_key_schedule_t pKeySched_snow3g_cipher;
>  			/* *< SNOW3G scheduled cipher key */
>  			kasumi_key_sched_t pKeySched_kasumi_cipher; @@ -
> 1113,6 +1347,8 @@ struct __rte_cache_aligned aesni_mb_session {
>  			/* *< Expanded XCBC authentication keys */
>  			uint8_t zuc_auth_key[32];
>  			/* *< ZUC authentication key */
> +			uint8_t snow5g_auth_key[32];
> +			/* *< SNOW5G authentication key */
>  			snow3g_key_schedule_t pKeySched_snow3g_auth;
>  			/* *< SNOW3G scheduled authentication key */
>  			kasumi_key_sched_t pKeySched_kasumi_auth;

One other note that features/aesni_mb.ini still has "Non-Byte aligned data =
=3D Y".
Should that be changed to N now?

Regards,
Marcel
