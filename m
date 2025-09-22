Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB742CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 08:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AE74060B;
	Mon, 22 Sep 2025 10:31:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3134060A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 10:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758529901; x=1790065901;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=wAolKln2fv1+zxjt2kA/74YsEpsubHKMYe4q/zlwZKQ=;
 b=KeoSaw/r0UrC7jJR/pDSH0cRXIhnX7GYQSRYSd9fvdELIJ9F5+xdtS+1
 h7pN6B1bG+W+EbPveDMDEmVZ3CuAB2gzIwA6MZDQNRhFIe0d1jgSJn0kd
 5ZZhWYljEyBRp6m93EterflI/91tosgPojmVunqxYX2dO1GnSaFYqMRcp
 z828jwFYc1r0m4zWA/0xnpsz3P/DidvgbYhjQ9VMQs31s0eruSFnQ/KBo
 rfKuTY2i4OHfcELgIMC3pSK3XYGU/5eRNc5ErUtMn7j0z0FYdlaOohNNr
 BK9WqPAhzB77Dp7+/37MpM6cZYlE/m9tKsYBE3a2OFlfYG4LovZm4Lmsu A==;
X-CSE-ConnectionGUID: 3dWrYpQ2TFy+ve97d7zXbQ==
X-CSE-MsgGUID: J31SiFz/SN2q1WPfDFo+DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="63416741"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="63416741"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 01:31:40 -0700
X-CSE-ConnectionGUID: IDNrBnywQ4eT5JnSyVRL3Q==
X-CSE-MsgGUID: oksyss2fQ52wsWeIv6sZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="176243671"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 01:31:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 01:31:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 01:31:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 01:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUIOrqA4V8WuBl+L3muT4CWND2ICl7Cs8a4BFzC1btRY6ZXuxJ3oIYyzB9+3DwnwgjiTlrgziTEVbISBYefIXAOaQn9Hn2EFtzNfloSa2m4WqCsw7ao3xoR5SzthInoj6fAv7VbD6pG106UwA0XtJY+slg1yxjZUCFpOjsK43DakxE2A9pfg5ySe7zcz+qEEM4kMov2uN1ataDyFehehi/vF4RAgKi47Ttq7fa+6Zrwdt8l/nplf1ViBagLD0z5+if5crELFDJtOaymF9CkzWpSvmwSWlxkd6oAKsipaaBbmdtoQpY+F/cJOA39HZyFiQaLpbypdEtR50lqadgV/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=923v1sguZi18M2iX4aLkhKNSqREhFrhAJf7fdASZxNA=;
 b=sXJuwi8n4/D88ajmz2g28qu8nCS1B7vgkz1K6G1VZxQ/wPyc6MF7ZRby/UFfnxcpAM3y/ETEx29MELpmyijryqNrAk5iTF7xhWJYORXW6ZBk+N9Ir2ArtCWZhQ3cmT7houdwGiEx+ocSOfuFSrkgKdiDRQj54TD7KUE+l6oHja6VCmIIb6K3vD42h9UBMR9pSySPL8rvmdCV1bt8SpewgSWkglCuxjPbQg4XR5VoZgxbN+9qzuv/9lOhlxeOvBpP4W7lgfnjX9HHAGy5ZfEyAKRTeUrAjayNw5VJ2lWieonoxfpLaH0H957l3PVexqdxgazGBeDTvmIhxHffzWPGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9034.namprd11.prod.outlook.com (2603:10b6:208:567::22)
 by DS7PR11MB8808.namprd11.prod.outlook.com (2603:10b6:8:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:31:36 +0000
Received: from IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a]) by IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a%6]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 08:31:36 +0000
From: "Wani, Shaiq" <shaiq.wani@intel.com>
To: "Vemula, Venkatesh" <venkatesh.vemula@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v1] net/idpf: add IDPF PCI class ID support
Thread-Topic: [PATCH v1] net/idpf: add IDPF PCI class ID support
Thread-Index: AQHcK4sO2Ih0y4Rbs06Imjay9kE3cbSe3nWg
Date: Mon, 22 Sep 2025 08:31:35 +0000
Message-ID: <IA4PR11MB903424D0F1832BE2A349C0139212A@IA4PR11MB9034.namprd11.prod.outlook.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
In-Reply-To: <20250919145125.113028-1-venkatesh.vemula@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9034:EE_|DS7PR11MB8808:EE_
x-ms-office365-filtering-correlation-id: 1b71b497-672b-4400-ae42-08ddf9b27188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eBSlknNQ7BwAjPbgy7q99pOj1bWGrUCOPA+Tfnqb0pS/ZFmIqqu6m5ZEbBse?=
 =?us-ascii?Q?lR/C0uLpTHWyiDojG8d29YqztnrVbFF6O0g5I88u48uBh3vfHEJ9dhIpiapj?=
 =?us-ascii?Q?YS8Id8XilzgtXHM2EkYBORsWLnRnU0iEjql1HBaV+OaGhTVP6ymbxOWK/zUW?=
 =?us-ascii?Q?fKvbRVcMQCrh6DIiyaf39fjSMdFg8wdEZgC7mcCFZfj8b48vPeMbeZoT+R0I?=
 =?us-ascii?Q?CW/uLd8/GYKTVLN51IOXrXerQ5SnFs5EputldDGpfsCyayCTH6Xw/QJH0jep?=
 =?us-ascii?Q?sLCvFN3Gjlw+zbty3SGz9+Qoo9SOFo/cTDNlTq0V3NYBtzX7jdOaz/i9LMkf?=
 =?us-ascii?Q?R8/ViFDRoDQ0j9j2XScJdpswc0pW2e1Fd6s5P+K7QTOMnTmWaZrnM8daTRSi?=
 =?us-ascii?Q?cCbZggjcOe8CJritjPPW6F94CqJAZpkmWiJ4YkT4DJgu6rB2+QZcTcH+odMi?=
 =?us-ascii?Q?FM8efzDZKAk34OBYdiOIULoOkFDRc7JYNfhmdUjcZAcFBUKFxB3i35+sSn6j?=
 =?us-ascii?Q?8cuQ6p0U4cQ41Dcb/lVQsOXcI/CMDggiOSYmnTHk+fpKDQ52r+YEyrH013Z+?=
 =?us-ascii?Q?9vnhBvCGS5ZyI8+iHbcKOQGMF/Iw77fPzAoka3KOyHwro/4RjZ1TWS5PMQUZ?=
 =?us-ascii?Q?YQHEdtYLlERb24WLNHGi0tJ+PdjJqR4ct82QSXC0W0NLKkX05Jd04BjNQB2M?=
 =?us-ascii?Q?8RdsZc8mi7n1lbkrnigEcDxz5Ni7ACsczQ0+wTEt9OYjIGbvoTS68vAi5j+8?=
 =?us-ascii?Q?V3wOK4euvZPYqmff7+M6K5kmYfeMGBsIA7cOH4PGiIpl2Oiz+kF0CbWxCjRX?=
 =?us-ascii?Q?SFWpCiqQDFIvZYvrdrQKbnEm+zraqpdv6MzvotAk202ySd2bM4Kubp+DHDjC?=
 =?us-ascii?Q?qdwVGU+VI9r2eRE81i4Xz07PE4hkV3MKl5y3WynKGS4rdjYJwOIOH5RztdOC?=
 =?us-ascii?Q?DNBphc0VsEnqA056E1wupPpQ2aqAhTvtZ3TYHAtdd20ARioJs2xjJmQ6cMt9?=
 =?us-ascii?Q?0xcL201yELyVzrIbck1v2sVPWOsZXP/WteIXV6l2I3+12tHF63W1tlrfKe0t?=
 =?us-ascii?Q?4pmdPzYCZUs7xB7eHOAv9eZA2591yvl6xLHHP3NrvRp5U84msRhFCM2sZl+M?=
 =?us-ascii?Q?KdlqSqbLDbuiXjlelvdMm99KZvhW3aufSna+MNdtUJ25XYsVYQv7/qT5PjQ0?=
 =?us-ascii?Q?25D/d6PaS0Lz9eMk1nguMxTwMBhrP/53CYGWqbs90mhsUVOzFGkt6LY2yXFw?=
 =?us-ascii?Q?U41MxtedsjyfSxkTK5YL04E7QGTlMmr/K5YsE6hz9M/6oUOalgpVBMgZdghy?=
 =?us-ascii?Q?ioruluukOgNGZVqG7OT5Ii3oB76fqAmlQ57Oa2BLqasUbEE1AChFf8wDVtTx?=
 =?us-ascii?Q?v8KMj0EQMr/wLlrJDn/GR7sLR8ebmXbOi5dr/XB/jyjPqhLs+SMYxUv72I3u?=
 =?us-ascii?Q?H43Eks9IXfq5Qm8I7RgQUtrVr3nkqusajam6vF9SK9MqtcVrC86GKeoOOfrb?=
 =?us-ascii?Q?7qRFPxe2ozybTFQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9034.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cm9WlYPAuGTHV9Uvn4uNx4+e6Czh4PXPXwly6Ph0XJqlfZEe6Zm4QjSkcx/S?=
 =?us-ascii?Q?QZZOSFx+0lQiQW/1pCHiVRxTu4AtX+vRn0d5mbZ9Om//AEa8QDeeqdoDzPoh?=
 =?us-ascii?Q?ZxL8gIQ+RkfH+TB7teRd1sTUqx3NkbkWhPcL4+Bwv9hvZ8jBP70Q+AHEer9k?=
 =?us-ascii?Q?tPlxbtnQGBd63ksXjS68yZ76BIOTrEtsc7s3GyvEDAcU5M6ws7WYIRGnwSB1?=
 =?us-ascii?Q?aLp+ksGsVXXaOobtaD/jc07jZYggcICQumU1DS/jwm1JSH0Tl/KfGC3ksKM6?=
 =?us-ascii?Q?tePPGl7LFw74yMmC7EqJ0FOe8DYxDGW6ws+Z8/3cDBruIdQzPvstOKL9j7/U?=
 =?us-ascii?Q?RgncywJQuxWs4QYxFZAEMmEIK3vd3PWn4nOELbLwEILZZ9VsOlW4SEQocbUw?=
 =?us-ascii?Q?Va6jbNJtLZ45U9pPzoNg/okvLYPnQkETq5Zr1u8IRUh7WwP1qt3EhFhRc3fb?=
 =?us-ascii?Q?ORPQe10uGtfKF5QU1n02lCmUJC3xRmWGoe11RbtcZ23Nubmb6I0WezkrWGlU?=
 =?us-ascii?Q?OxAqBbjGh5ag70HEmlK9dlZY0V9toSOWc7vxCyJNhHB1CyENtZDk6lbc26uI?=
 =?us-ascii?Q?7bZJ7j57Pc7ZvnZ7y2SJ8GN6eFwBDY+xwRjG3IybBtNqXsOn+yD6IhODz1o7?=
 =?us-ascii?Q?vAL/onwY9prvmZmjO2J9e5rOhXXPah1bMaUl1DW7Pn/wEqgn32HAI3lnOwm9?=
 =?us-ascii?Q?xry6JBrCFMAJpHH7FX35+acfYq7wdY9YefoyrbUpiIH5hJI12GuOZ6KQH47+?=
 =?us-ascii?Q?AawaIWXaxYQjNkUANEnkiI4to85hr47zUHWpqbQJuSZSPll8Ujaw+tm5OgJx?=
 =?us-ascii?Q?KW3x4aIy7CC3WqdzfS3HD6UOD2jwFHQN4LbBobeT21pSNi91mrX89PLndjjF?=
 =?us-ascii?Q?oZLtpHjVtUXlkSsyg9sPueL5E3+yYhqcpkk8OBIp3tvK64zWoyoWw+yZClsC?=
 =?us-ascii?Q?Ujl5HZgZoOZ2UQetM+TCT0z0wN7lKku4EZKI7i3RTQ4jWleyrDwSN9tOcUTz?=
 =?us-ascii?Q?tDCXBVm/5JYa/rdheGcCvLrUDExTTr0V9kd6O4Q0kVyNPfGnH7NzBaTGeHz3?=
 =?us-ascii?Q?kVpbqy8JuSHyiCKvtAZ9xBGgYjGs77PxqzDqBPrJYds6mOK1+C4e7oeKJiPH?=
 =?us-ascii?Q?AbvdNvkHoj3MDiCWEC1mZwJVQoJDF28kTf9pHzUfsh65OfqJ3uHQz2VxlY2W?=
 =?us-ascii?Q?opp1iPRutYENoLbbaq8vmMSfjWEBK4cIauYwRjE53oeI/HzvLoKziliOuRJN?=
 =?us-ascii?Q?+BHRcxMTZigi2L/SI4mXnfy8u3axmSNsF6cEDcpLpSyhSK+giGuY0h+WNE6+?=
 =?us-ascii?Q?CADFKNu+4sWYTMHgRaOb9eHlxelO6NXcc9FCaqop6xK9Uzdm6Y4945Y9LLX7?=
 =?us-ascii?Q?UCQfjz5nfIdy8J/0yMHwt7LHfMWvANYzmcTuQJJdZBV3a/fN7iaMdjT4Hvse?=
 =?us-ascii?Q?xPZobvFODucbcIsg69OQxhn2qqgDmcCY5F2oibPwj1OTK00qmfimezKkVKT9?=
 =?us-ascii?Q?9DQL0vuNGncFc+Mejh8CzHo6LqWL9cm1Z21HUkefla/yc7OVoMriKLnVsnd8?=
 =?us-ascii?Q?Ha1BE1rxe8wFNfWzxWZZlXhDLTxT+gsNC9ZRAWT0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9034.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b71b497-672b-4400-ae42-08ddf9b27188
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:31:36.0147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oT9ub5EvYl41OMo407JwITAboOLBpO5zwq51uvtOG82KESz+Vu6eCax5OQCo3QkDybp9lZ61S8DdmPJ9jYZjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8808
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



> -----Original Message-----
> From: Vemula Venkatesh <venkatesh.vemula@intel.com>
> Sent: Friday, September 19, 2025 8:21 PM
> To: dev@dpdk.org
> Subject: [PATCH v1] net/idpf: add IDPF PCI class ID support
>=20
> Current IDPF supports only the MEV device IDs. MMG has new set of device
> IDs and same might be the case for the future devices. Instead of adding =
new
> device IDs every time, make use of the IDPF PCI class ID(0x20001) to
> differentiate between PF and VF.
>=20
> Write and read the VF_ARQBAL register to find if the current device is a =
PF or a
> VF.
>=20
> Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
> ---
Reviewed-by: Shaiq Wani <shaiq.wani@intel.com>

>  .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
>  drivers/net/intel/idpf/idpf_common_device.c   | 31 ++++++++++++++++++-
>  drivers/net/intel/idpf/idpf_common_device.h   | 17 ++++++++++
>  drivers/net/intel/idpf/idpf_ethdev.c          |  2 ++
>  4 files changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/idpf/base/idpf_controlq_api.h
> b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> index 8a90258099..7c25aabb28 100644
> --- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
> +++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> @@ -184,6 +184,7 @@ struct idpf_hw {
>  	u16 subsystem_device_id;
>  	u16 subsystem_vendor_id;
>  	u8 revision_id;
> +	uint32_t cls_id;
>  	bool adapter_stopped;
>=20
>  	LIST_HEAD_TYPE(list_head, idpf_ctlq_info) cq_list_head; diff --git
> a/drivers/net/intel/idpf/idpf_common_device.c
> b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..4ad94da449 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -388,8 +388,21 @@ idpf_adapter_init(struct idpf_adapter *adapter)  {
>  	struct idpf_hw *hw =3D &adapter->hw;
>  	int ret;
> +	int err;
> +	bool is_vf =3D 0;
>=20
> -	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV) {
> +	switch (hw->device_id) {
> +	case IDPF_DEV_ID_SRIOV:
> +			is_vf =3D 1;
> +			break;
> +	default:
> +			if (hw->cls_id =3D=3D
> IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
> +				err =3D idpf_is_vf_device(hw, &is_vf);
> +				if (err)
> +					return err;
> +			}
> +	}
> +	if (is_vf) {
>  		ret =3D idpf_check_vf_reset_done(hw);
>  	} else {
>  		idpf_reset_pf(hw);
> @@ -443,6 +456,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  	return ret;
>  }
>=20
> +#define IDPF_VF_TEST_VAL		0xFEED0000
> +
> +/**
> + * idpf_is_vf_device - Helper to find if it is a VF device
> + * @pdev: PCI device information struct
> + * @is_vf: used to update VF device status
> + *
> + * Return: 0 on success, errno on failure.
> + */
> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf) {
> +	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
> +	*is_vf =3D (IDPF_READ_REG(hw, VF_ARQBAL) =3D=3D IDPF_VF_TEST_VAL);
> +	return 0;
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
>  int
>  idpf_adapter_deinit(struct idpf_adapter *adapter) diff --git
> a/drivers/net/intel/idpf/idpf_common_device.h
> b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..9d1d7dc47c 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,23 @@
>  	(sizeof(struct virtchnl2_ptype) +				\
>  	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)-
> >proto_id[0])))
>=20
> +/** Macro used to help building up tables of device IDs with PCI class *=
/
> +#define RTE_PCI_CLASS(cls)          \
> +	.class_id =3D (cls),      \
> +	.vendor_id =3D RTE_PCI_ANY_ID,  \
> +	.device_id =3D RTE_PCI_ANY_ID,  \
> +	.subsystem_vendor_id =3D RTE_PCI_ANY_ID, \
> +	.subsystem_device_id =3D RTE_PCI_ANY_ID
> +
> +
> +/* PCI Class network ethernet */
> +#define PCI_CLASS_NETWORK_ETHERNET  0x0200
> +#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
> +	(PCI_CLASS_NETWORK_ETHERNET << 8 |
> IDPF_NETWORK_ETHERNET_PROGIF)
> +
> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf);
> +
>  struct idpf_adapter {
>  	struct idpf_hw hw;
>  	struct virtchnl2_version_info virtchnl_version; diff --git
> a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethd=
ev.c
> index 90720909bf..7c1db00562 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1201,6 +1201,7 @@ idpf_adapter_ext_init(struct rte_pci_device
> *pci_dev, struct idpf_adapter_ext *a
>  	hw->vendor_id =3D pci_dev->id.vendor_id;
>  	hw->device_id =3D pci_dev->id.device_id;
>  	hw->subsystem_vendor_id =3D pci_dev->id.subsystem_vendor_id;
> +	hw->cls_id =3D pci_dev->id.class_id;
>=20
>  	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
>=20
> @@ -1313,6 +1314,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void
> *init_params)  static const struct rte_pci_id pci_id_idpf_map[] =3D {
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
> +	{ RTE_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
>  	{ .vendor_id =3D 0, /* sentinel */ },
>  };
>=20
> --
> 2.34.1

