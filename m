Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDACCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A53D402E4;
	Wed, 29 Oct 2025 10:30:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3B8C5402A6;
 Wed, 29 Oct 2025 10:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761730252; x=1793266252;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ju8jaSvElBel+8gI2w/Csn+M3BclR1SxAu/rKdUiQNA=;
 b=fw3Z5YnbS29BtBfd1g4Zr+4h3vh182O+0tL76Ki4W6UywdAT3CJSWuCg
 vZPMQaKM0vWveFFBW9l71nle30aHUuCdBwFFtGuo4Ao//FN0x5f8oNkyp
 DmzBMZGVbjwUHj62I9PyIDKK0nG//H7BCw6uCifY3sM6kOXa5kfE8l0q7
 ZuN+a0P6LWnQRoAtcbGOLN0ooS7OZ+QddqgRSbcOXTzNT2D71ROMlMfW2
 7rPbkUIiHJLwozUBezIxl8Qi522Eh4Xse/qC8BaJo8ogrZkJnz2UTPJIu
 DG9hLTr78XzuSJ5ICYx8CjNqHdOs2Vi8TrcN6teR2+stGijb9HHRO2WjG w==;
X-CSE-ConnectionGUID: KADFHUkMTnGOV/NCP6tkmg==
X-CSE-MsgGUID: sEW1rsQpQEOaRDA3/HhTnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74522280"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="74522280"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:30:51 -0700
X-CSE-ConnectionGUID: 016jjIP+RF+HBw8moEeHlQ==
X-CSE-MsgGUID: FVZXCSNWQayBRFgkf088zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="216469940"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:30:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:30:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 02:30:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqfldR17BnLLXO9CkAfK8qZDL3SOS2PMxmStj7FFSg0g+6cjt8ykxXKQSsgs9Xnax9WzT3fLW7qzCI0GyMm0aJCgQb8Oi0g4hFsfXmAO4ZOQbqpS9heNI8PCLi2aA9N4ap8TF8kSI0AcRiLitxeP60hcqyYRyZykoqUJlm081Qhl4ZyWUzr7dyfTv9CAZTu0pqANZB3XERgo5rvN3IaOuy+5aafHpFCjP5IUAYzDQ6sg6QE+hdwV2EZavCATWiYC29ZfLuStyYBQsGZb1J3Y3VKIYbPgBsVwTm7Tg9FIbUCRWiCpFagECVXDdXzuw+XEXQCWIDWEttz4/7Aj4dtdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LOamzWweUAiOmInGjczIqTPd5N1szSuaIQpW1torC4=;
 b=WICOPhp+0zSSIpHRVGFWmyWZtsd+hXDH3iAeUw5ooWgadR+81FpyfW+UpDWY1ucunpEfpCYEnWd2fCGae34wwA6qpIjx7esmIMQlh9SWRGbgV81/qqem0LBxMLIQ326ZC5/gln619HFrVxvs3g2STcqiLZUEgG5AefmXqrznddKli5JjyNCY9Xa+HbglXnCIQYS0EfqDOfOzNFz9GuR3/FttfCEaMd4GKYXvj0gtN1TOvuRJYYJT+qE7T4QNOb8T42EkxH/3iDGhm0CcMphF4O7mCfpqhg3yOwggcoydlOkIDhFsFZdEokGVyEvIRyNSMl0aT4CTOJc0Kay+wTJUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH0PR11MB4888.namprd11.prod.outlook.com
 (2603:10b6:510:32::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 09:30:48 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 09:30:48 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v1 1/3] net/ice: restrict testpmd to scalar path for TxPP
Thread-Topic: [PATCH v1 1/3] net/ice: restrict testpmd to scalar path for TxPP
Thread-Index: AQHcRwVADIopvbN4J0q1eBTYWyukTbTY3SKA
Date: Wed, 29 Oct 2025 09:30:48 +0000
Message-ID: <DM3PPF7D18F34A1255900DCE24A7DA357B58EFAA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251027182801.191295-2-soumyadeep.hore@intel.com>
In-Reply-To: <20251027182801.191295-2-soumyadeep.hore@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH0PR11MB4888:EE_
x-ms-office365-filtering-correlation-id: 9204eadf-bba6-4b49-77e0-08de16cdd827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?rLhWYK2vmaCQj1OwvMrfYYrof0Hgekf4Qmj5ctSbThMgDBwnFlvV/meR9ego?=
 =?us-ascii?Q?+QSnhj32ZVSps315x6KWVZ6TlQu1TaqSdJklkh5T7WYzx/B7SX1/t6vjryrM?=
 =?us-ascii?Q?pDmeXG8ipS1HE9WZ2m2mobzlRQBMnrI9QbkeKARNx1Dn2xIEQCVdOdOoRll7?=
 =?us-ascii?Q?D+zfAPa8ZpksdCLaWYE/F0eaM0P+MzUJMp0F8CKisOWnwVZiUaZ8oOXvoSsY?=
 =?us-ascii?Q?mYZDN0PDc2LcETQm24WSJd2b1NgBlKA7hONZe/2FFzjVL1AC5bWbhnbm+3vm?=
 =?us-ascii?Q?7VKNiiV+mQAoelvCMlgLuZbwjo/GbR7Rwl4ljZu7JwfdyrBrpa6jDuZMoeEj?=
 =?us-ascii?Q?InN0soBalJ3Azyw/1oK7vTpTCOae9CgVzFO4SjBOa2DjvZeg5cZE3QZpewFK?=
 =?us-ascii?Q?U3FuWSX38iR/jqsUxT6sxuNBXRBQsl9OI6GAGsa7CFnPem8GdJq2szdDXqNs?=
 =?us-ascii?Q?g3iTbcBpaOnDYWyDdlI2Sk5xPjg2xbUaLcr0aSw3gP9SkHCwnEKRv3i2YXhe?=
 =?us-ascii?Q?EXvAEDUSS3GXizTeaJsQC58pZF0PEBqjrhShF0pHgvd6SQw0j37bx54PnZTx?=
 =?us-ascii?Q?Iz9dyPngkbImgoJ/TXEz4Km2jl31r5d/yq9ajGrAi/k+ScKA8Z60cMkU8zNX?=
 =?us-ascii?Q?7u7cLm3NbNYprwsOCGF4MyfA1IUYHHI1JpQ9Y2An9ueQYjPHf6ixjZTFzmv+?=
 =?us-ascii?Q?wP3uDlF+Da62suOHduQpj1RjQmCuMOn3vR3626djxJg9ECMPQqcr0b/X2OMy?=
 =?us-ascii?Q?+yOKFVtyltyLDPnz3igRuTzvUg3Whr4rX85z2Qc6XDkZ73A81SC7sYlLSYIZ?=
 =?us-ascii?Q?fMZSjRywQJ3rJ0tUZINMF2LMWwaoBDg6ifAkS+xxGxv0+vrIPA2XTC5va5p+?=
 =?us-ascii?Q?Peab82EadKJ0pmm2NB+RmZpc53CzwwDhYDiawjcBhzOwCvPJdlpuFRoAETvv?=
 =?us-ascii?Q?px4JSpmKSFxGyFDtja6+qcUiVuuu7WjIU+KOwiTShZtAnXQ/K9xB4GoS2okX?=
 =?us-ascii?Q?91dD+XI7uwFie2XLpJGkLXKmQmxujtN2AbfqXegjhi2+zILQtllR9/s7L37m?=
 =?us-ascii?Q?q8RMUVvf91zTZ/sSwIQSosVPssNJmFfCCvp1Dhto/fyyNcqmJHN8HmvV0IB5?=
 =?us-ascii?Q?rfJ72vYXtcC+lVlxpLfr6lB1XKdk4r1bWnYxtGuBiHHiF74B500OPHfzNGzM?=
 =?us-ascii?Q?Y4C1w0WnTuWb2+gk5moktWMOpR4wEpsi2zlxjx1rnX9RKhYsrux6oJSWc9TB?=
 =?us-ascii?Q?FhuueQut/XJzkaytB6f5LJ3khBhq1Dcm14FJup5Q2oJeJa0oMONCNK33AWDe?=
 =?us-ascii?Q?e9a2ADXNUO3U4Ir5+uGfEV8gZ4cdZRAM7Falo2QxRHZmG5KvMYU2tTz1qJAI?=
 =?us-ascii?Q?XWcnMttM8/pFlwpy6aZ1ScDuFIEhcbqqpjkvv8MBpPduaZEiYYijLI8A41at?=
 =?us-ascii?Q?6oHMkwahIt3cOOYbeHmtCXbndLypjhUiLnos31yWYpTfyiOtW7pSQPRurlht?=
 =?us-ascii?Q?HsAhe3eViDWcz9NSIMhD1Pv/iw7SbB0iIEsv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C6A5jxBfBZS7KO9BQT84OwNCRYzbLMR1ZfDWhcdszFUiFCSswtrpoh1dOyS6?=
 =?us-ascii?Q?Qv2kjGkC2ef+WpPpMmHSyJ9eq/BuDcU+cZOX9aOuoYHw4z2w25NtgK2mDxFN?=
 =?us-ascii?Q?LJ0N50ZM2xpDgR2nFRMI6SO9dzqzV/D1z5cwLasqlY1h0lKpZtvTkLFrxG+G?=
 =?us-ascii?Q?rPPIkgbBjtZFLrpql9W8t/D0YLkGbi9OJLxTjnGWyARd4GIn+rZBJp152eYk?=
 =?us-ascii?Q?J4zd6/5ZSqaXUaB0XaPhflP7OLDKSn++VVnIebiqRi/ee5K6yT9QLeJGiQoq?=
 =?us-ascii?Q?xDMgofP1b3khG0rfmiUO/aCwldcAVaNEVMPbJPY5kY9o4rRnwE9Vf5+iCU+K?=
 =?us-ascii?Q?NQNuXBb1YptRO1WAhNolHCpoTQ7XIRi2wr4l+N+WkHizv/q/OqoGDzf+CLsW?=
 =?us-ascii?Q?zRoyVZDxXiUqETWz1OGxgHmfBdBXc/nHWKmXVe5qNGwxkyXMz/CkYKDAMpF3?=
 =?us-ascii?Q?sJl436vHzea2A6x5PvRzsV2T8BSgUwxWYOgWFRgPqgxTbsAfo098NFJJj9Sk?=
 =?us-ascii?Q?dJpK4f/XOY/hPGGPQq0QJf8yOIgnvIRkH41OhUCqkz9Pj2OnNMR5UAu18upr?=
 =?us-ascii?Q?z2awQ864oTnz2MK7eF4QQFb2rOWQO0EIQ6BderQvR46GyLHUg0XEN46Tvjgm?=
 =?us-ascii?Q?RgpdmiEY9Hq6GaWzZznirUNion002qWqP9qRMYaJyvTRgjD4Tn3GDYpdXM1H?=
 =?us-ascii?Q?nJw0dQ2qai3sYJW4P/hthSig0xNiQG0g0yvvHcoRYMM8gbLIRE0balD3Cigr?=
 =?us-ascii?Q?rRlBLzMg+OXltTzFSDOg1FcNolIpDrFMEVnxDb3RaWWOI/Juaz6SWdXq3leo?=
 =?us-ascii?Q?SHSxHQucupl9WU1FguctMsA9ubDzAn0rAK7/493miyQv7N6y63ctg4KAfntu?=
 =?us-ascii?Q?PbnVMs5Y0XeBGxyTySOpz7WdMdnub0+bTKOfc5RFQd7+PLCzXLrpudXxvDb9?=
 =?us-ascii?Q?gR5h4RLcBz+3JVRP6i+T/oeu+Sk+MUTvpFSn8KBVEA+mK1p6womS9BWC8Xoe?=
 =?us-ascii?Q?VxRgWYOaJ+aThU9ANQ9u88Qz2FYg4dxZCVirSLtRsMxLEdQgeuraSqxHDYJt?=
 =?us-ascii?Q?//VYUaUBEFbbWfyJk6t1tlL9EYe71kgf9/uhGSpUnbHKUQV6kRaPaJ3zpClk?=
 =?us-ascii?Q?PSbMl1KYnjBwH2XePVo3/FKp1uZeSQLtPFIXU9ssZ0YntE2dr2woOYHfMrwc?=
 =?us-ascii?Q?txNJxp4vv5lanoz5rw6HNkt7X6AtNF/tEn9pZ2owDc28+hvesjTpSCpiQQpT?=
 =?us-ascii?Q?Rs2qLyUfuMLjFuhM1hBGBiOwqDuse4houG8iw4Jp6exv6CvVqfqx6K581Isv?=
 =?us-ascii?Q?m8vltvetn1gsgulFlk8Wrx+SWaDJx+/9rWFnYrU5fichXnG9gfzJat7840XU?=
 =?us-ascii?Q?fsiKSIUwSS0vSQSDCoOEKxZDgZ7F9tgvYlYjQ+PLF+tYgAGgyHf6QmaucAyd?=
 =?us-ascii?Q?ItTs6ekXLo/rLqnLqsWpGOyCt8tHW3chh9ykmYgPvgWEkOsBlh0M/fzQ/Lqv?=
 =?us-ascii?Q?R57nwdDv7AW/CeTTd8dpE46FWX9mZjjphETMt8q6nEKOSe/6G1snNDbvhfcF?=
 =?us-ascii?Q?CUat0imR+4sFaswDPjz3EL/apjpMaFPWAVH2Ej/E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204eadf-bba6-4b49-77e0-08de16cdd827
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:30:48.3711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoqAwWjEKfKw4ZK91BZHI2o2390/6fKwdktacK1FekUoGi+HvE0c1AM/rgU+o0LW9nMZ2jdoF4NhHcII/+50XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
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

>=20
> ICE PMD supports TxPP feature only in scalar path. Hence restricted
> testpmd to scalar path when the feature is enabled.
>=20
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index fd0b3a7532..33d82cd46d 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -4103,8 +4103,11 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	struct ci_tx_queue *txq;
>  	int i;
>  	int tx_check_ret =3D -1;
> +	uint64_t offloads;
>=20
> -	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +	offloads =3D dev->data->dev_conf.txmode.offloads;
> +	if ((offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) =3D=3D 0
> &&
> +		rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
>  		ad->tx_simd_width =3D RTE_VECT_SIMD_DISABLED;
>  		tx_check_ret =3D ice_tx_vec_dev_check(dev);
>  		ad->tx_simd_width =3D ice_get_max_simd_bitwidth();
> --
> 2.47.1

I think you can achieve the desired behaviour by adding
RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP to
ICE_TX_NO_VECTOR_FLAGS. Also you should remove the reference
to testpmd in the commit message. The patch is just a change
to the ice driver so should not reference any specific
application.
