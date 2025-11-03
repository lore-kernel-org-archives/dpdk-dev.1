Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A6DCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 10:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D228E402D5;
	Mon,  3 Nov 2025 11:25:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5A4F940281;
 Mon,  3 Nov 2025 11:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762165526; x=1793701526;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jTkFwIEopIgUILR4QT1RIqkAfsq3dJ85JPfBMKYj+fY=;
 b=QeWavuDy7DDTQ5Bk/kxmY4juc5TeG9LlyBIS0GO5d0S59I5RTohT4JP3
 +ObNYtXNv37VL4r7lYyAfrPOZmqtP6ERgoRrVgNf6OMQZz/m6/L5G4jjL
 E4yu0h31lZ9+s/1wdyCALKurI+ey1wrd6IkyR7tapZ1jR0+jEZ51mHS97
 IuIWWbsQEDXOn7NMYJCkF/3YZ/7qNAuhCcx20qtuBY6yFYNOizQN+k6bn
 wulNkr3Srgq7ZcOS9r9/zKI75q3fb/y1XxPGVffBdISNUXjW8G65TU3Oy
 dWoITijyyR0W218mbFVuorqooqb29qu2qkN97C4dETKCY97v20lf2d1hr g==;
X-CSE-ConnectionGUID: OcMDShbMQA6F6iFZasrLqg==
X-CSE-MsgGUID: 1pS17JssTe6rr2WMBIWqpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64162752"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64162752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 02:25:25 -0800
X-CSE-ConnectionGUID: fEtrNGXTS56IlgM/T2xVEg==
X-CSE-MsgGUID: GfbJM95zQ+e6e9gVLfSJ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="217656234"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 02:25:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:25:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 02:25:23 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 02:25:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRMVQhAhe0EWFum/0TIFD0VibGHz3TXH9k250gGgsNZhgBb4D3iQ2zS72EwoZ8l01HRxus4+JfycTyucqifgtv1dmp/LFyL/e+BgceM9AmiDcv0xhzaVPH/A3J8qZOrF9BTZV1w1ghOAhNt1jTgAEAa1egBGBBS9NwVyMdEci+ajTu/XfiwUKkG22Bxw3hdXJchqvteLEPoneRO6UZSJ5VNeYiIBNuGWxjo+2IkbbG+MZrSwQIhSyAcQdVkJGZSo55pLfr1uX4hwj5AAp+x/5RTc///UrNmZFufSI8mJP84ahq67jyY/d8S8X8BFG+eLDbLqnd/fDGmQ9mU9/I3xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxLm9kq3Lwc9W85JFvyo/KtPT70lq7TFfmWYLIyCdaM=;
 b=ROjqwGgb2wqF3HtecdBzx5RCN9O81SVjKIOGAkMo4A84bzHG3MjV0271RuQ25puxnUyBohvLXJBIfSK7lq8TU7MQC/CxlgnZCYsgn+hmlulh4pEtleUYfLdopwZ9NifJkKbbCK9SM4Zy0JTO23D10IOL30Ty8YFNXQHD1s2lMsZ5rtV24GrUjzgUSNoNbAeLXNIKe6IcsuhWWLUEPJ1Oh2gX0Bm02ek6Epjq/j1DN8OLhQ0YuLtJHYSLbEHEKx5DO/v1+eGE7KwAnTz6X34LfR2rvokV15VyBm6zRAtjLEkm+DIEFpHFonHLmU5n85hnd9vzXtZ57V6TxyCIPVTr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ2PR11MB8470.namprd11.prod.outlook.com
 (2603:10b6:a03:56f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:25:22 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:25:22 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 1/3] net/ice: restrict ice PMD to scalar path for TxPP
Thread-Topic: [PATCH v2 1/3] net/ice: restrict ice PMD to scalar path for TxPP
Thread-Index: AQHcSVkZymF+x4B+0EyTQaXygTHCKrTgxOPg
Date: Mon, 3 Nov 2025 10:25:21 +0000
Message-ID: <DM3PPF7D18F34A133AB1DF75CBD81F45A038EC7A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-2-soumyadeep.hore@intel.com>
In-Reply-To: <20251030173304.260209-2-soumyadeep.hore@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ2PR11MB8470:EE_
x-ms-office365-filtering-correlation-id: 729fd218-31e0-4fbf-dd0f-08de1ac34b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?9ydWJe6Z3gRcmzXn4Z9qk5R+kG6c3O0T0LKh5GZ+rVvOrYFWj0js1qkPQG/N?=
 =?us-ascii?Q?5qSbjsMDbcpzKhBQX6ExzqWO7Gvy5AsLUfE3l9n+ix5T2PLaItLKc6ETiy0F?=
 =?us-ascii?Q?jQ64Wvn6G7YGw1MshSUtDgjKB20FfMXuoiIs48NjgWpFA4Xu+9H6oJCw+kXD?=
 =?us-ascii?Q?s50F/6PtoCzZTtkEEKWrsUrjHCu1iKu05/4B9PA9Z70jeTXnpR7V+MeflH7R?=
 =?us-ascii?Q?8FPPhye5wXZ4t8XJbHQCNkTsootxXHEivmZ1K/uiDdQ3IQNJZt3uhMECV2PJ?=
 =?us-ascii?Q?EUHAYOgA/9LbzmA+jdpyN++rfQA+OcBqvBM0mLESyCKji7NWm3L0kA9xIEKo?=
 =?us-ascii?Q?CWSxcZLf43/mODeF0Z9ux72xwObh+p8TCH9SyZv2JXjkm9O2xAIgoYH/sQcB?=
 =?us-ascii?Q?AOUQTAUCkqL4tUZK3vxvhOxOclnVmAos+qo6PRqxpGnpQW2w0z8z9WZfgueD?=
 =?us-ascii?Q?1YzJJ7cN7OQez7viJGB7r968KJWx/ZAgPMJOQH/MU8csD5KWIZkcCggz7bWN?=
 =?us-ascii?Q?iKpcsKHtwryz0vvRZsGT6QS0MTPF+IlRIwXtus+mXyJf1eVszCDoM05I8fDP?=
 =?us-ascii?Q?/rGbUimFefA/3x7eJLLGMzWE1CCWSbkxGOqO8OK+Yb9nJGfXXD54PFUikYui?=
 =?us-ascii?Q?xrrjPCLM2Ic8Agj4pP1vq8BDt3D24uQw3waYuJjXABU0oLvBzdXcmKhtHJz/?=
 =?us-ascii?Q?7+fTQdN5elbjveKoUvEyclHVJfUBi5nVQdSGwbu2SCswub92ZPpf2jhY7Hgk?=
 =?us-ascii?Q?Id+9SIbg5ABIdN6AMRw25bX8kPRuM9XflK42n3Y/mGaUemNLAgcsATg8XuYE?=
 =?us-ascii?Q?Yv8pWRrN8tWQRWluLKzF7wVShz+iOXckywIlbHw0/a1i/S6HvZ2mFuEdKkya?=
 =?us-ascii?Q?odsjkuuYn0euMBJ6m7ejDM9tj9kvN/UQDXfArHtQ0f1CT743vU5GuDyjLWBk?=
 =?us-ascii?Q?Gc7Zxz3tIl0CBIG0XfGMIzCK6bcfHeKTdnb+jPfmLQnUZ2r1s/QYGujOgOB/?=
 =?us-ascii?Q?UfqYtBxaDpnxqBfNd6/2Ua6eYotfHh8U9bsERiwDTnphPk9HEAI7361hdLn9?=
 =?us-ascii?Q?j0uvkJFtnVhKncHo8oxkGzY3W140xoLhS9JBdFVXnsyjDGyVVICca5Z1Lion?=
 =?us-ascii?Q?l3XlaZOgMvz6MiwH75AXLcl0QTC4UCxluOYcNHve21nACjOW7A0NOgva54qJ?=
 =?us-ascii?Q?6G9bC7xCwCgP9kRs9WMj+bsnmCbFDYR3er1Ge/dQXRcBSLFac0FU/eRmCOnK?=
 =?us-ascii?Q?vZm//GmbZAyXCYjdI/wk8WannDCniiXIp6RXxGUY54Fz7W+NVnP9VZkHyBzT?=
 =?us-ascii?Q?j38uLN0hQ1EkQOYFoVHBUv7Wina/DzrpS5xnBGVlMQAZa37rMPosa7PHMTig?=
 =?us-ascii?Q?vccaSDVwy/rtxoAUUsh+xAR8+w3O/lSQ2TpFms95p12TU+dYANldrK2EBbbJ?=
 =?us-ascii?Q?89+964HMjkmx8aDFzLoykLUhbSaXK68/7KpuIsHVcTfq0tGgKFREwQKLTkjq?=
 =?us-ascii?Q?Krs0y50ry2sZK027LUzaHI2dxXsgll0e1Uax?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yW6tniuzXRQf9ufcx4oTFAzSlpBBhl21gsd+hoR9HKUmwfq+bLmk14sJ//e?=
 =?us-ascii?Q?3MfCnvxN8rFDz6WHSPCgDqVbCfDijhx2tamVtRhycjYe1aO/LLvP70lxqjrI?=
 =?us-ascii?Q?fKtYpECpXWejfazZotGdNYWCzsbT5XP4Gr1h1Osgz9jFAo95XOgDaUUb/O/r?=
 =?us-ascii?Q?CKa4xOrJAMNNP2yxoA/oSWoyAg0T0yAbVhPVmAqrnrn7CTTRj+ybFVjCualx?=
 =?us-ascii?Q?JumLuHtgc6MCUAdmMwDi5+ypism3CQyti69AhsJDdbhQ0xE20lfwnR6dho00?=
 =?us-ascii?Q?GXbYCncTr70Uno33aUp8ZaVVGQd2TxclHAeMhcwbdgsCPdIU4asj3/0Sybal?=
 =?us-ascii?Q?afgylgSHuMnWwAhQxWrMCQvLcf46MshQc8YF23peN4d+As4JyFL0N4gdDqxG?=
 =?us-ascii?Q?mvJHL6GIc+0kNPkoQA5ZMdmyag6jw+2bP6Wi6poWA59BwzDEJhmdG+/3tkQz?=
 =?us-ascii?Q?uN0vw1xBr6YoM/1kWBrgdTRrU/S9TOm6KRXk9v2Kb4UmAnIgHVX6Aa8rWMQz?=
 =?us-ascii?Q?fS75Z8Pl/yTVQQQV82lw31g2gXkqrRgW5FTzI4rcVRm7ivqHPiZjiAGfX2YQ?=
 =?us-ascii?Q?OGJT7bZAf3+ahQJ4xkdJlYXJbso0swztCoCERPx5lQWFKuaImjjvtPwIhPTR?=
 =?us-ascii?Q?NmAFdFbsuK4M49kTnOLmHVNOR1BmndjOUJ3aYeAP7b2s1H3NRm6nfKzhE4sk?=
 =?us-ascii?Q?rIuGQjFzKmDKXHylSBWft5TXtzYjE9M3LEy5egDX0ClWvXumK9E3+kqZokUe?=
 =?us-ascii?Q?L4ONX58AQQ76FAVpXHdflcurDE2XkC3jYzwYIBMaLuvSNKErurMyZw9eO9Aa?=
 =?us-ascii?Q?N5SpES4P38wdd595lzvuDFMAYJ6NQpG66maPhfIt1bhXJqfFggsLJjEum3df?=
 =?us-ascii?Q?tGVywd5UmrPO8Z8cmy14uk35krbjHa9hw9Ii0SI8AiYu43GSs/5X8j55BLFP?=
 =?us-ascii?Q?ost077qMoVXDyy2EMOAEm2276xWjx7AtkA996WkK+Q9dTvckKT9ie7GRiflj?=
 =?us-ascii?Q?C6qH7xQMyQlSCgXjYGQaGiyss+srsfhiu1FOanCQzdxvmFytZPZLiaPQ1978?=
 =?us-ascii?Q?XkuL0Tady96RbygoEm+K10Ynz0JkPKeKmsPk9A2Kpe7Esgnlm/e+CWeg5F5R?=
 =?us-ascii?Q?ZkhCqfMXtTBmpmcJvjVRrnqrrCnsFcL7E+1qXkVvP62xZc7ycBs39mTU82Si?=
 =?us-ascii?Q?24z4e+q1e22szgGDesoJETcJNfaVe04Wqdt6kAS8ysIt2OoD7SbUxXJNHPCG?=
 =?us-ascii?Q?Ec6p9wcRIHypi6xZNcRkarzTiJKDQKZaDmQYg6HT0A1ipL3gKgcHqzynMrLD?=
 =?us-ascii?Q?oOZlRolybSiT0WWDzYihnHkqC15FUVwSL8pKYml7xXKUQTLEZ+RcMEdwZz3e?=
 =?us-ascii?Q?A1LFnu2OjIF47sHiYQyTAOK7cMf6LMNUNLDsyCRX5iblTeNQAhc4+yB572nw?=
 =?us-ascii?Q?MYPgrqvx5hhQrmbBI0zOvKmwDhVKD47pkDPBufkVb7msk5unL62AeTW6Xh37?=
 =?us-ascii?Q?0hEQifm67Y3KpjGUtRTTgPPmabfeg+HLsc4GKnzA5N+Nu+o9tZLo8fPCo8eT?=
 =?us-ascii?Q?Svb3n2Wz5LndOAKsOIZbQyLqS0xyPANDrQH08BEF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729fd218-31e0-4fbf-dd0f-08de1ac34b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 10:25:21.9739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67qFgit5xHeZ5eV8KXQkx9bN4nvYFVSTucfaCQwuJFqmIciDkz3Ds6OJfpXD6OqW6WVzeCpupvIQOMUWq69FRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
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

> Subject: [PATCH v2 1/3] net/ice: restrict ice PMD to scalar path for TxPP
>=20
> ICE PMD supports TxPP feature only in scalar path. Hence restricted
> testpmd to scalar path when the feature is enabled.

Remove the reference to testpmd in the commit message, as the change
will affect all applications, not just specifically testpmd.

The code change looks good to me.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

>=20
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index a7cc4736cf..a24694c0b1 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -59,7 +59,8 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue
> *rxq)
>  		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |    \
>  		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |    \
>  		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |    \
> -		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
> +		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
> +		RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
>=20
>  #define ICE_TX_VECTOR_OFFLOAD (				\
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
> --
> 2.47.1

