Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B0CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 13:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2700740613;
	Wed, 12 Nov 2025 14:47:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D8ED2402D1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 14:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762955223; x=1794491223;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YecsSsIwDnFghZfWOMmIG0ukjaLvs43wQ4MpyJYnR2w=;
 b=ESkXBGti/GJ/wHd35vsih+k2163xqThLasiao7CMel3ztMdGvyYGPN1Q
 w9A9D4wLMCqIDP5L0hHZRzPKLKWEk7/xKs//bABOe9YLBdgG0tepqvgDB
 FbMmDhRmU3Y27Vuju4MdE6eYgM4jt51uAfchkSQoMuLypms05wTmQjhCk
 7Pb/BTXNEVxlOCmQjlLylX3QgPnGfeTngEN4LRRQvtJXf4sdR2zRThSPi
 8evgrkah2RUO17ooQ9GpUxgeGKUPOpRg9BfscFD3up6D5bEGi/5RwMIaB
 MEjXRV1qLwiNioQoh+69f3MQit6BqvKsmsgS26crANBBlWfp+TDVeGn2O g==;
X-CSE-ConnectionGUID: aozT/V/HRsaTxf8EqOWL1Q==
X-CSE-MsgGUID: IgTY13fYQVq8gj74i1vK/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76365182"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="76365182"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 05:47:02 -0800
X-CSE-ConnectionGUID: xHxomo8YREKIQayEOZirHg==
X-CSE-MsgGUID: DQE3IVmeSOyekfawX43ZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189073615"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 05:47:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 05:47:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 05:47:01 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 05:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfnOFUdKRAk+H9NrmkiEqH9XN83BHDwpET/O06AePw/ROMDwnVvGWJhJgff0qzP1pwIh57qL0C7K+yuXaei+CnvZw5ML63robIOyQldrrAfm2eq4dJh1WKGObkNC2o3qpA/hBuJoyCDSmLRiDT1MwBONougVO7+Biw5ZZlPXSWYf2yz48iox07FD9tCpQirTHyzJEhlXFD1jkVsvR7AVzUUVMvgIRZp5Icvup812yOialo7qEf4E+JqbWEwySHvMU4k9idzY9pxOIRGVVJDlGVqtG31Fwkz4/guJEbml2ZXpA01PGX08GWykGn1Ar2uPSp8+e3jE4f9pu1zJ2sPtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLUzptYrjZxryRABrKE6+YQ723T0cn2bBJ//cJ7V+zg=;
 b=JISWOLVpocs5FsmVUCD3rosJdIjTrl4YLvHLwE//REIaYxhewUFEhBfBnufhza6OYaSAAGAQvgZ0dq+q0+XR8vYKGXJEJXS9jRwi+qT8oYj/nqN5bQdkE29BAfKjsOkFXu+ywuyQyYCbxTsk6ov0Fzr9pjZoG0b+kchp9T8yVTp+Uy1MMgbFu0MnAbmhl+7vf+yJGXhm1VXzQyWQPLKQfqn/FeD3VmWTTwx+mfF4gsPdOyp0fd8TNwGFtYzTKzAg7AXr03evQvcgLECI55FBGMk2xsRUSMVovKlLj25UfssTALe160fxASYqusi7Y9kbTHf15M+KTtLQ9aTRq3/HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA3PR11MB7436.namprd11.prod.outlook.com
 (2603:10b6:806:307::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 13:46:58 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 13:46:58 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix path selection for QinQ Tx offload
Thread-Topic: [PATCH] net/ice: fix path selection for QinQ Tx offload
Thread-Index: AQHcU8uxa9i6xPZw+keSlmBTqT2dnrTvDb7Q
Date: Wed, 12 Nov 2025 13:46:58 +0000
Message-ID: <DM3PPF7D18F34A14733C367584A08902B1C8ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251112115726.1286735-1-bruce.richardson@intel.com>
In-Reply-To: <20251112115726.1286735-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA3PR11MB7436:EE_
x-ms-office365-filtering-correlation-id: 14bcb596-2d38-43cb-b4dd-08de21f1f331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fWAeWuaRd88uLFp3omjCbFi7Ei0dtjSZZOSe60xFbrm2oVSCroTkKRd/OiQT?=
 =?us-ascii?Q?xMUjtJR22qKty93sTF/siDxzkQe8h7wjvR4alZbt+XIis7QPSjq31EkmSNNL?=
 =?us-ascii?Q?o/8UhPpNwuNVhO4OpKp8r81xrjnnNC3Vp+bKTOnxBOvJeb+8FNkLzcshqYUn?=
 =?us-ascii?Q?PQhGyQnIeAIaOmNZT8Pkv92uJYVDCvLFwLBCjKg2al2TNVaaIs3XJwg/W4JE?=
 =?us-ascii?Q?CqUQzlt9nN254jBOK3uBsmUty457Ys7XWP3GdNJgXM2Ld7v8euLxhEqcBA9P?=
 =?us-ascii?Q?yLIbf6iuUg77uCByhytkZ2GKEr48s9tM1DhxrjE76N6vEQnQF65GCBlvxELK?=
 =?us-ascii?Q?zYE3eYVUNe1fx8rcKKlait7v821UIms4VCUA/hjw1KprFoDpGwR5aCLiBwsz?=
 =?us-ascii?Q?TVCAfmn6co/vV5V3aUgXNfP81YUc2XDRThW5nK45TFyQsoA/0kHatXeVvu3N?=
 =?us-ascii?Q?vYjrK6Kms8L+//299xwoM0owuemekqXrsf4HKkFDt+RSgQWUwUv7KpupIHd8?=
 =?us-ascii?Q?wEOWvwq2wACihQaw4ELZ4aKXoKUIEBwAD34xL/uLF3GRWXoLeU8gwV1kFjPX?=
 =?us-ascii?Q?YGw/uD01tL2UMy6O3zhRAMwKjKmMSVgzow+pOdeerTeUdW316U0xsAcpp8Gr?=
 =?us-ascii?Q?cmpz75dau+mS5awOD2q/N0IqIlr6FWQp6ocdvps8Dzfq7n3uzNbiRLalPd0W?=
 =?us-ascii?Q?bPpeKpDW+GitlH8ULnQFa8X/sp+Q2CwSPtkp5DFWj0tWN+9cnRmMJznwfphN?=
 =?us-ascii?Q?PA/JIkXXH3pH+wsVlbbl47xAO4BtHn7y+gx3QKmEZbXf+rkJys3mvjjI0UFb?=
 =?us-ascii?Q?cs9HQSKFUbBOBZ/hP0IGXVxKejTwICLYP26R4TPvD1iYHHcgYrDN5fW0AJ7m?=
 =?us-ascii?Q?/iQ2Wivl346q8fZNMduoIN++UVxUI2bEyjc6I9qXrhv/1XCMJLFhlsaTETIl?=
 =?us-ascii?Q?BJcQ5BRTYIhJsWaCx8imcPrJp1ITWbivkhxHDCKee8WEZVS093auTBcQMXKh?=
 =?us-ascii?Q?CNTIWObM6TX65ujUkgukbv/uJPa0UvLEzIfR5JttFQqFeifjY5VCCD/WumDB?=
 =?us-ascii?Q?vx4oB0IOTkst2ohKR6rJdS1xpb3XCwG5AKxiHJ6d8e5T8gCyuw4iX/sci57B?=
 =?us-ascii?Q?jO16AwRbGjWOfTjCe7fd81DcoQLnbOrZnY05SaG/HiK2Ph4QXcpH3VzDxxoj?=
 =?us-ascii?Q?ERb8FmSkA1hHuhiP9zGUEeZESPSxB4QnnMnMqDMlXHsK7loPtHDnwRhk1zxD?=
 =?us-ascii?Q?kMxVjRDmlwTz1eG4FtHEXC6ZkkZvWXTi4VwSKJ0IE3q0UdbRSvSYOXqQRlKM?=
 =?us-ascii?Q?GgWJ7RdDMsHMX+cn5vaTHvSxx2KADDTa+MDxTCxhW3U0u+QoKeNF65/sOPVp?=
 =?us-ascii?Q?VXHhxAbebDeg2TrBuQGZF6o2YxArwZb13hzpIKtxYtdr7TE+OhL392gWcc94?=
 =?us-ascii?Q?3HE8OjsZJPMg5DR57NDEVhwYJpCCLfyvjNrBCA52ZG/NaLxwvMUnqCCuRIHw?=
 =?us-ascii?Q?sWbTmpvWi2XbwF/SpdeQscfOv0qW4en+w9m2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vBpZPqtafFdm9qu0/kn6MAdo0Ei0XZ8+yZmSyGzHtrYfFi2inOoZagU+hJv/?=
 =?us-ascii?Q?vEmJYuTEPa69HPAXGWLp9OlKusrttmCQSBMkvAhlHxBZJiEhcE3xLAKbbucZ?=
 =?us-ascii?Q?xucMIlIxSVHF7+4O8/XDIDVGLvJKYEQMscXm0i8MQpuqSy78cb4AXoIx6wgt?=
 =?us-ascii?Q?VpW6pAOEUHMiaVLmdtsIqceQ646fDgWZqAPy45oBl5x8yfWHoRAhWSAzcr+s?=
 =?us-ascii?Q?wT/ag8UO+UIQIaLySptGgFg6nC2INDOlYWPum+7mt7bmA2roO1F5p67V6rLE?=
 =?us-ascii?Q?7kgEZ7GNBFR7P9YxDBpWtL0WescfomesGqCrnB9SbpvGA/VmknI0Z7qgb/aG?=
 =?us-ascii?Q?vUB4oa5EzMEnuazmeKaDbAuE1X8yxQUPdOeBEYn7c1BNW5piqkMW3qKtL+Ap?=
 =?us-ascii?Q?6KL/Pg0xOxoPJck4kn8BGGrwin/M2UcE0tfY52pkiichzcveRmhmDONJqdiw?=
 =?us-ascii?Q?TJ5F/97IrUEBfW8mwz4PjWXSt79WiUXofZJUVi97DrzWUSJthfm6B9hdDIDu?=
 =?us-ascii?Q?QtYdr1K+f9pdyjskQzSqX6WBVFpjAxaMO3u++HhD9HTT1J/nkdym8qfhHQBn?=
 =?us-ascii?Q?G2h/DW95IYm4V/+nBSaW6kvuq1p5bHqoic607P1HfQdn6mzp431HvoFznSao?=
 =?us-ascii?Q?d4eV1Jiw/ADHL/V5QBf57fIFmkZAie/NdSljFRXfT0vk7ArGgJgCJpbxK65k?=
 =?us-ascii?Q?C6x8mERqalsjpxbTHLrFWVq9FEaI9XYJjcJFgN1AqJqcmNVQVs2FMHFErw5t?=
 =?us-ascii?Q?Ta1AiBkAPwg2cnXYVfX+yrVC7Rw/TMJ4jZBUgVp404iNkTEbndh57dqygaHr?=
 =?us-ascii?Q?wg3G5gqVHtZlWFDXEyjhCVwmtjkdV15/WSckZzgCzzZRVGnLVkG4RJT3FnK6?=
 =?us-ascii?Q?OUEGBWOTAM1sWjP9jsnS3/+4i3bHvb7L9LIWiPAVcy+wgzWqrtKrppSksARv?=
 =?us-ascii?Q?qDe3HlM28WBJ7Bbo0Z8PB6/ZP72zmrBtX/ejXZSUBJaG5cMz/cYC95O9At5I?=
 =?us-ascii?Q?vP2bYzSuqDPbTymaWPk9dB0W6y5FHLI233tEu6mkUqA1eB/FDD5eQaljzDVU?=
 =?us-ascii?Q?wcNCBcz/IhtBvpZyZMo2tx5+ZkD/VXB7+1KT3LuS9blWQW/U2WB3Jzvvwq4t?=
 =?us-ascii?Q?4QoVFaY6sr32Y3igv+wroNO+0TJihSy0oqXfAmqbDrca6ULtT0oRDyprhFfC?=
 =?us-ascii?Q?0A9iPChEQu3/2dFzZiN8jZu88ARPLqajaKKeNlBv2nJzBpfneBuGtIEmdYET?=
 =?us-ascii?Q?H0FC+TvBuWwyOSawdG8aAlgSG8E/7fRftAQouK91C5/vRQ9ju/E8VSNjJAtj?=
 =?us-ascii?Q?Naitq+q0X42NPu3Wov93HwW82ECi4vcAPpMxYZuNuw/B7aSOR8p7AStKY+dn?=
 =?us-ascii?Q?TguYTvVeoUmL4hw0gHePIqqRccXCA2CWAjudE/9M8Zhr7xiZS8R8wZx14537?=
 =?us-ascii?Q?U4v+g/4A/HeR992l33tPT2euI0sGCcP2cRAboV69hsML+RsRP8wbKCSfe/4e?=
 =?us-ascii?Q?ZgtZgVkBuNVp8DBXhhPJh/2SejTNAtDswi1WQueqV8JKUaQMALDKZlTy5y9E?=
 =?us-ascii?Q?9kpFp2pu1chF1fCfYCMAojrzmBKZ5e5LUeTecvnD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bcb596-2d38-43cb-b4dd-08de21f1f331
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 13:46:58.3950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJnX4p+spgzQHOIk8wXDD3Z1NxZKlGyM5QJV3KDP0UAayTx6DQ8CP+3iGhSQ/UJPzyYPfuf8H0zQSs7QttybWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7436
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

> Subject: [PATCH] net/ice: fix path selection for QinQ Tx offload
>=20
> The capabilities flag for the vector offload path include the QinQ
> offload capability, but in fact the offload path lacks any ability to
> create context descriptors. This means that it cannot insert multiple
> vlan tags for QinQ support, so move the offload from the VECTOR_OFFLOAD
> list to the NO_VECTOR list. Similarly, remove any check for the QinQ
> mbuf flag in any packets being transmitted, since that offload is
> invalid to request if the feature is not enabled.
>=20
> Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index a7cc4736cf..62047e9f2f 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -53,6 +53,7 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue
> *rxq)
>=20
>  #define ICE_TX_NO_VECTOR_FLAGS (			\
>  		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
> +		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
>  		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
>  		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
>  		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |    \
> @@ -63,7 +64,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue
> *rxq)
>=20
>  #define ICE_TX_VECTOR_OFFLOAD (				\
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
> -		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |		\
>  		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
>  		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
>  		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
> @@ -194,8 +194,8 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>=20
>  	*txd_hi |=3D ((uint64_t)td_offset) << ICE_TXD_QW1_OFFSET_S;
>=20
> -	/* Tx VLAN/QINQ insertion Offload */
> -	if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
> +	/* Tx VLAN insertion Offload */
> +	if (ol_flags & RTE_MBUF_F_TX_VLAN) {
>  		td_cmd |=3D ICE_TX_DESC_CMD_IL2TAG1;
>  		*txd_hi |=3D ((uint64_t)tx_pkt->vlan_tci <<
>  				ICE_TXD_QW1_L2TAG1_S);
> --
> 2.48.1

