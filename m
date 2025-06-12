Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B9BC71141
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 10:14:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E75C40DDD;
	Thu, 12 Jun 2025 12:14:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 584994021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 12:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749723292; x=1781259292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iBGF8nnYfWHPvgayRi/y843b9eiDKuEFVsGzWw7pXuQ=;
 b=CES+Kt0bH4JVdB2zM4OiX4RA1fqcA3j2tO/YmTJhlFVjTcsadeGOYvK8
 P4tSCa5RRH+Xkqe0tWgSLpjybJxJUkBFtQM0Q4CzJ2o+/v3L+LqSqP/Ye
 f+etootXtX5HwMLkq/DGThvo0LJTmVh9xUE23hF30j8PaURNDptHVrhJd
 +MzfOERnw/RP3eyVkjEkxaVX+mkn4SW0Xt0r02R7uzoQwx47AIRrL4NLr
 4Akxt36FtQTkveiaJ5iJhPxQjq4I1iBYRz8goSalODTdpzTL4a5mTsxq2
 hU6XyPDjKieHs/PsMN45npQZCYHcfzlbDGUbMbRi72vcQnuJKiD6IqtRe w==;
X-CSE-ConnectionGUID: JAxH4bCRRBCn5xmXSqaEhw==
X-CSE-MsgGUID: y7AQqjsOT3yb+7x/usBjLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="54523613"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="54523613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:14:47 -0700
X-CSE-ConnectionGUID: 66CqNqahSaqn06B4kOOszw==
X-CSE-MsgGUID: +br4rGZyRdWR8JtE1c9jag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147359872"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:14:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 03:14:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 03:14:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.77)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 03:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw/m8ZWibfWMA/HfbUDDqny6sPbPqpNQX76FN9rppOXTnoPbUlwv+GWf+LeohW2NBorSg+yTRS8OXtY6BMPBPOH+x/0J/cVj/RunMD/NTosJNDByEnR0PXY2M8g9JVAyeiJaelrljghMqaBG2AMPr4n9HfZ9kA/OO9AQUkB296bLPl9M4QQRYh0SI8yIqOmM3VGw+QHOWfYG6Vap4Pn2wLOw3qgN1M7vsMaK9CMAcUkZlaXrH2+9+S8O51YrjlgZ6w6qnjphFecTtBYtDlI8wp40vKMrJ2QfAS45lG/RAjIF6YdUgOiO67M2/8+PAm8RRZQgA9Hu1siF/ChEqlncnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D65+2o3T8VtQiFlUevD8iUpM5t4DROZmEUBt2ueKTGg=;
 b=sKSkXXMmyk/JZx2j8iCGVvsbML9h43WVEVndvPFZbjK4v9bzvOl2n3voe3cEr8f0urBelEO7gn6FEVWz7wHhcP5MeEuTSYSlJ/vOXfsOWrOl9RxHUcU2hCSsPVttSBOD1rAt1szkBDz/8aPmOWaMOaVGtU6i/ldZ6+doKHOn3AvVotqRkxm77bcf1Ud37jVH49S3nJLlIl0MGXF8MmAfuRlh+d3FMS4Naubmy90sCa6fEl2nSBhNzbAaWmu0BQq7rwDyH+k1L0fby3zVTmYEuqbBJwkN1YytS86MUukAY0Hu/1Pa8VCmunPkDB9DtsEgusaFKv2pwJOIviBddUc7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA0PR11MB7354.namprd11.prod.outlook.com
 (2603:10b6:208:434::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Thu, 12 Jun
 2025 10:14:30 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Thu, 12 Jun 2025
 10:14:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v4 2/6] net/intel: add read clock feature in ICE
Thread-Topic: [PATCH v4 2/6] net/intel: add read clock feature in ICE
Thread-Index: AQHb2k3B+hW160lR+UmmLR1SYaKYeLP/T7Ww
Date: Thu, 12 Jun 2025 10:14:30 +0000
Message-ID: <DM3PPF7D18F34A1A5202037B5AB7DC9F6948E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
 <20250610131159.495566-3-soumyadeep.hore@intel.com>
In-Reply-To: <20250610131159.495566-3-soumyadeep.hore@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 36027de9-6db4-4562-16ff-08dda999eb88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zcy1DIBPcDbmyRehOPHB5JvoARfCFpocr39OL12XGenvQH7p87WRVHPzRQrX?=
 =?us-ascii?Q?8n93x4HHWD8bk6GSCgg+vSpILuBbVlklJwT9O+KAP7np4k5FfxZ5HqFDEnDq?=
 =?us-ascii?Q?TLwHKBb2FDaRn3IphDRH8RI330D+nAke/l327tr6FizFJmADttt3zxPsu5C2?=
 =?us-ascii?Q?xfFF4le1Ryr3QVX6oVV0yfWuGAN/Pff1nqyXJamyqFDxWy8NQon2CAf+llIS?=
 =?us-ascii?Q?pNfT6Hdp9rsEuZXmv2fo3JvtVdGRZcVFo7dzPSrbU85Q/dr5RqPefCaYW9TY?=
 =?us-ascii?Q?CxgM3FDMQNMiHdjVhYir9IIcS8VvuteEc6iyp9BZCaCk19GSL9LwzLYuM29O?=
 =?us-ascii?Q?sqfDwPsSHNFZYnkJR6SDUsiAzZnCNtaqQUKc75a+mvnxKHKqf5gf8139r7Nj?=
 =?us-ascii?Q?mVPN1BNoO4/Pk8l9SXAD6okFShm/8qEAi7CnsVwqiJy6JP07MkyyS67KI5+M?=
 =?us-ascii?Q?rO9jiwqBY45iyIsqEvVNJxyTyNEsPMwt/BCiA79ErlDLWNYyOyhy4ckHGSOI?=
 =?us-ascii?Q?NdEw4XY4iHGusOxeXX7uf/ZKQewNDXvlbVkZIyUJNgl9/OJcpJastFC9jnX7?=
 =?us-ascii?Q?l0RdUkUWuTL3KKUk5UntfgVd6kvHLyohUg9fq4Yj5QgNUVC6Vv1zVhepN9UK?=
 =?us-ascii?Q?+cXu8DPZF0U9u5qK1ZNf3qjzmQKvLPG5SlUMrrfO23nIeCS123dK6d3zNrQV?=
 =?us-ascii?Q?oOtuq3mUN7xD7/6/6VepD9eH+GA9TP+l2G71QRFrioWIg/6M3sjXs+O92BYp?=
 =?us-ascii?Q?/xxVIMbzOPEMzwLzKjDSHr60F3yevA2DTae3P/BPAtgDFCeS2g7Ylk+4S6xj?=
 =?us-ascii?Q?M+q+eLeXv7nieE5+6cIqNURuT66T72qqGhquHmNssQDqEkXATgESybc/rglO?=
 =?us-ascii?Q?+u6rdTTYWyJ2GR5n3GjQvwTe0Jdh80pbCYApVrXkaugKKRyjITWpI3RXl12o?=
 =?us-ascii?Q?ejQjoyaG0LuLzcb28BCR7QSQQ2+5UMYQWKsLppppPOXrz4aqyDNzulI+mkR6?=
 =?us-ascii?Q?+1gmdKjOpNDZ6b9wbt1ZM7uvxyZ4mlO5lkqqWjMTuy3kfgDmNHgTyOACJiPO?=
 =?us-ascii?Q?eSuQwJxF/+8nquZOStixJmCQSv+EGQi5R/Yr2Z7Gx6ngIQ00dL0LOOCPrww2?=
 =?us-ascii?Q?MqJ0TUbLrErw9Yv4NxerlTlIvE14l//a2vzzxxIwU2XuOB9uI77sbqrLOu2U?=
 =?us-ascii?Q?1KAZuPwYAjoweQxRpfHVA4ZQrUU24HcXRVysgC0qa5uuPe4Ll6m7glaJzKal?=
 =?us-ascii?Q?g34Mvc46FIdhtZcdq9hdZiB3QY1pGkoqMtMtF2T4guqACWhSTok/gmzCex+h?=
 =?us-ascii?Q?s9d2LsiMTQ7X+N3SSyDRfJbDF/fBya7LGzJxL4RPCD3ckiwN5DVmGht/covq?=
 =?us-ascii?Q?Eps+uWh3KKt2w3b7XrfQEcDvx7bLW6ikS0zieV4rmgEiLYoVU+QHblMRsgLF?=
 =?us-ascii?Q?FuUtZuM35gPahnggZIizsThIBgdfNZlf1PY3wg0yVKRf2LrzH854Ug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FEe7Wa464y3fFFe/I/J9CmhfEGnXtf3E55bHgp/VBYQ8Q50Vo8bOFYvHnpSJ?=
 =?us-ascii?Q?wbLTjINhZrrDzX0/l87XgSr0FUtty171dM5/vQq1kTd9zic+Zeaff0gev0EM?=
 =?us-ascii?Q?KoxLMf/VJualmOQFCM0FndLPWV3/OfXHFjGtXmDiS5LbuPYBHCM5sdAyKMiI?=
 =?us-ascii?Q?zNp0N+XKmw1SVMsH6PctIKOE2jOOAvcrkE2JFbWxYsgUvI7bqPPBxZcyyPpc?=
 =?us-ascii?Q?v9K03Gol8gHW7vj0F4Vqge6oLGGo4QpJgm+KdGasqJUbpyenvlw6NbifCa7y?=
 =?us-ascii?Q?VIkk9kHayBBxzEPm83SFlfwpqWj606vc843/YElfRrjLd91pQvRkObYDdTqY?=
 =?us-ascii?Q?FD1fR+OBQQi/UwCUtfNHjnYUaiZDMnS8WRutSxnfTdE3FQHpdRjIWdVIccGX?=
 =?us-ascii?Q?ebsmgDxA0s6L62+hfIzhg8PXXJGukj0/PhWBuCLhTs0mYQLr15BayZblFnVc?=
 =?us-ascii?Q?5jMmykXj6l/ybtT5MRo9zOLLbPesa27SjfyO783Idyc9/aduCIZbw3anCFMo?=
 =?us-ascii?Q?qWqsbI8lFUvwnGPuJ3DpDpkdBlWwYoibQVt96GXPTTW7iYkoq4fn9IRw+gMM?=
 =?us-ascii?Q?3QxwVr3qp63l5GN6e8bBeMEP0hmaZDN7KP+4fyewTdDI9iZOBf/nPTlKxSF5?=
 =?us-ascii?Q?nF1U24hyf96d1IgttbO4LN/70cuv/1sogn1/TI5iwFReoY9yPnFMj2VxS2iQ?=
 =?us-ascii?Q?VZrltxB0Kdx9YoRwndTw7Lyj0t0Nx5qNS2uK9WH3f6Sfey3RA3Ii8nD5yXSz?=
 =?us-ascii?Q?tvj6SpXi5o/HVWjw83lrapjUG7din8Wz5FKxxuALthpmlV+m8VMQRBnkYGdQ?=
 =?us-ascii?Q?+8PWRoyTBN6lX7mPpbRklRMIwNKttMfoMi1uiNJuuHIo6IS92JJAZdRv1X4G?=
 =?us-ascii?Q?1Opdg6po+lNEvKawTkW8f0tKu6BZH9cdcru1wMJB4X0aOIiyoLEw456jqPtr?=
 =?us-ascii?Q?KYFkLnEdAZGZICcJO0bqE6HGdiU9Bqw3kgN3AVJFxr35RsRBiIDwJh+acSYK?=
 =?us-ascii?Q?e5IomtQxG9YgaU0WF7vrlxLfDfTNYnejg2YAdfcwMg2inBe4k6qiiIsJ50J/?=
 =?us-ascii?Q?QCPilT6qhqUrkhpjZeyGRGpUPheaxfSNBXMumEaLpsVruX23QJZj8aefJcA6?=
 =?us-ascii?Q?z0I8D7vVQkeJcsovxNnR+E3S33BpPOVPI920lG8j/e3AMOMAfo2zTlf454lU?=
 =?us-ascii?Q?IEpRmUfRCoy7PDY11onwF7nn+WLwCP49uGW9yXZg0V5gsAtY211RU6YhKNoA?=
 =?us-ascii?Q?4zf/v4eO0xDf4OGNnp1eQsXqfOW+wctz5vXs8kyGUqxBwXSaUd+6dxzwoGvb?=
 =?us-ascii?Q?NKbWG7OLC/dCscVQibrlXGhO7pzzpSzFLB+6U0hG9Nhumlpp68GZkBlgyNB5?=
 =?us-ascii?Q?OuboK/lgRCApXBxDam8QNOpsFwR9j30J9UVvnMQpPwjU5GEoR2rSqYu7kU54?=
 =?us-ascii?Q?AI2nGQWaXOlzjTIglwi8KtLhIvLyhIlp0nXyM6KpKueGN9rzbyAUiMGwu+0l?=
 =?us-ascii?Q?qnp8gjlDV2kVTloqj0xaduZUsEvgNgcWeaIkumXjcjWymqlDw/J9vJ+AqEyh?=
 =?us-ascii?Q?Mm8Z34maAlS/FB79hTAHtQwOFlzRyfgPaa1NLO99?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36027de9-6db4-4562-16ff-08dda999eb88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 10:14:30.2799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yigje9Sce7AJZCmEPueBKUeIGhAHcPl7RLu25maPF9VLDdQotr03AmclUHsc89DWgumdkxLeoZbV6eoKsiJczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
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

> Subject: [PATCH v4 2/6] net/intel: add read clock feature in ICE

Since the change is specific to the ice driver only, I think the title shou=
ld change to "net/ice" and you can drop the mention of "in ICE" in the mess=
age that follows the colon.

>=20
> Adding eth_ice_read_clock() feature to get current time
> for scheduling Packets based on Tx time.
>=20
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 7cc083ca32..9478ba92df 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev
> *dev,
>  static int ice_timesync_write_time(struct rte_eth_dev *dev,
>  				   const struct timespec *timestamp);
>  static int ice_timesync_disable(struct rte_eth_dev *dev);
> +static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
>  static int ice_fec_get_capability(struct rte_eth_dev *dev, struct
> rte_eth_fec_capa *speed_fec_capa,
>  			   unsigned int num);
>  static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
> @@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops =3D {
>  	.timesync_read_time           =3D ice_timesync_read_time,
>  	.timesync_write_time          =3D ice_timesync_write_time,
>  	.timesync_disable             =3D ice_timesync_disable,
> +	.read_clock					  =3D eth_ice_read_clock,

I suggest following the naming convention of the rest of the ops here. ice_=
read_clock instead of eth_ice_read_clock.
Check the indentation when you are reworking this. It looks like tabs were =
used instead of spaces ahead of the "=3D".

>  	.tm_ops_get                   =3D ice_tm_ops_get,
>  	.fec_get_capability           =3D ice_fec_get_capability,
>  	.fec_get                      =3D ice_fec_get,
> @@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
>  	return 0;
>  }
>=20
> +static int
> +eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock=
)
> +{
> +	struct timespec system_time;
> +
> +	clock_gettime(CLOCK_REALTIME, &system_time);
> +	*clock =3D system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> +
> +	return 0;
> +}
> +
>  static const uint32_t *
>  ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev
> __rte_unused,
>  					  size_t *no_of_elements)
> --
> 2.47.1

