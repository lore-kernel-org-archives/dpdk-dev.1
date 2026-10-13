Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20513CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 18:15:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB17440272;
	Tue, 13 Oct 2026 20:15:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B7C3240269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 20:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791915326; x=1823451326;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=5Rib6Cx1j113p83SDtC+Im07Dr1v50JMMaexK5JAWTI=;
 b=ZUGrigz6Vm79efNS5/lbfTtC5UrMB59zOfgovQOpxhV71W9lJjG9YDq8
 TrZcmZIRClQdZepdkTofJzWhBnGZIOAlBBd2MoqCTTCI/kaP+SCg4NXO8
 bhrDI6wyRUmkFIVokGaGx9h09RFFEAyMNYjFVDHdpKgtNZKoAN3+B9331
 THUdvPlqf6Z2JIOEccgFkf38tEsvjSifTRn0IccQHFcNEPJmYxzh/vkxj
 JT1xTPIXeyn+WGDlPGgI5CBo58Cb9dN3lOjT8A5C8B6FybpAJvhHyRofu
 GBup1LfHtWrKu8tEMNiVZp34/XAXkyTK6cKrQqYCkKNr3OfPoCxxjZepA Q==;
X-CSE-ConnectionGUID: mAVHgBsjQoKOKO/6FmbyNg==
X-CSE-MsgGUID: HchIEzJ3RYC6SpJhEvLOCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="659900"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="659900"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:15:24 -0700
X-CSE-ConnectionGUID: 5TkiXmMfSCS8GrtR8BSP4A==
X-CSE-MsgGUID: OXHyvm9ISt6VBx4f7y4vgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2988372"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:15:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:15:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:15:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irF4E3oakvdSKqFZ/FbRDdtw821tLDDmvrTWxSKjl6MabUjt8sIjSBeWGOiQRrrHUtEnZNK/EbWo+Tai01IbEwsfGBiw7SrjxDkfgLkTY6xQAlY1IKt9t/eTX22ToqiKlydZk7OtWdo+chYvvgPcce4ZCUqaOTqm4Jrd2me8PfuHTtihoEry7MZp7uO+vwRjAZcDYrpdwpJmq1zW/dX1oV0CJ4B84brD5RgLtX7ZXNnd+VyIDy4eOiIxW1o42xVl7Ipnp/J602i2Og1YTakGVohWS+De6IbLvW0mciRm9KNhHDwvxFcVsIya3v/8sgwCml34bu4prlr39MeMHQWkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrvE7wHFcc/+005lNTazK10biXC8+zzBSwD2JClpRwg=;
 b=wNcXEg5HX1hi4FUJzVQg8Dpgdr8O+ky3UB2CU0tPAgbcLVv0CnXYm+n5dEhFiNwAQOG/ipbjqLJ460Uxp9ZjfONurenhB4XeG/w6ll0c5V3pcXcskfhmJvu6H4lLS7lJ9DpIKUR9qnfE9ek6cUp2kVQe49we+NktGVsx38dgBDyU2nvQ83yTZ5bz3g2H1XlwbBn73BhOOqjQlrW6LxOfXV7mTzhyXwNPmMUq/TPxp2NglH2m7zKpF4HFxxfw3KPSdP8+Ouaii1oLdDXLU2iFiA+Grg/MaoaDfwlM+snX/V6vxXAFQyBi48DBC/M1ZgyU0lpTkKDGq/ueGOUQwEnOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS6PR11MB797010.namprd11.prod.outlook.com (2603:10b6:8:528::17)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:15:20 +0000
Received: from DS6PR11MB797010.namprd11.prod.outlook.com
 ([fe80::a181:b29c:6ad1:16de]) by DS6PR11MB797010.namprd11.prod.outlook.com
 ([fe80::a181:b29c:6ad1:16de%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:15:20 +0000
From: "Chautru, Nicolas" <nicolas.chautru@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 06/29] drivers/baseband: convert rte_smp_rmb to fence
Thread-Topic: [PATCH v3 06/29] drivers/baseband: convert rte_smp_rmb to fence
Thread-Index: AQHdV33wIlKAfRdrj0emmRENPVHITLb7zpAg
Date: Tue, 13 Oct 2026 18:15:20 +0000
Message-ID: <DS6PR11MB797010A0187928F0151AE2D295F89E2@DS6PR11MB797010.namprd11.prod.outlook.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-7-stephen@networkplumber.org>
In-Reply-To: <20261008233649.1260843-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB797010:EE_|DM4PR11MB7398:EE_
x-ms-office365-filtering-correlation-id: 43acd860-19ef-480d-3cf1-08df2955f13c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|11063799006|56012099006|261009223027099003|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: Nx/nW+dnp5VxrfRQSgU39fevgMc4wAyJF94hrG8ZrdQHDtVj+DoW/LxJTmn2MY++SCeW4iSVv4vBNhQ3FcYdxK2QNUGCjE33yOBgt1RobLcBEjhQOAtSF6SOtv9oCVJfxmVaG8X+qW+XEDnhjSayFQ1FOeRpAh0uXV+n+oS2SLYiL+R3wSkU42oP2VoqTmL/Ps12rAXjzudKjsTDlSDGqD4FcEADVTnANC13WMEQf18jyzXC4qtx4/lwwEVu1R5Lc+OLjT3YBHjAg2XjhnzbCUfidlRHJ4XH7HkK+ken6Ta3bWB/ZYpW2A9uvL1bTy9XbESkzaDfg7h9DCM2dJLIDzWv/z6rJkdRWPrixoMg8+JdyvShawRhXcazdqRVl2hrYVHSADHNPXa2LzIr/7VN8/wOL359SQ2oZbDgJCAiGnRMNAHCdiVVxmTtXq65AgvfECaO4GSUiZgi9O1dwoC4D9ltywSp2gSIpwezTizziCnx0dWx9Yn1WN7Wbx5sfumSrPmBs6mvpSnDAJ4n3yzaS6lZCzRS8AqwsXIvXvGN115gYQ1KMhi7PELkGxOzBqGWQnPtb/asM2X5vDZJGA9ClzfCZyydlWC6euY1KSKOmF342d0aH2/OZwiVCnOULQdZaAov0zOSqYUWDt1LmdYGdqpwXW1SX94qgmLND1JIh24ot3GisKmPGUzKoAVsgX4KlHwWQNLw2kfZEDqrlQKGuN7u9b7AQvby+XgguTtovOs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS6PR11MB797010.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(261009223027099003)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYg5FQpMm/UY3QiZEcgdYw/GATf8si/XKKsoDcgB9IG0GV0YIkblpC1jIX9l?=
 =?us-ascii?Q?WA5o2ZJK2S64A3rr0iK84AWHifUwozwzivdAQCJBbAVjPxus6AMKlOi3ikzX?=
 =?us-ascii?Q?j8kXfSwED348i7e7Ogxdeikin09IJrRzVmVesHJjc2ipUVVHjbtM7gFnekpR?=
 =?us-ascii?Q?jg06DPlgKYMbwhTvgyCN7xlojjcDtgYwdO3rTxCCgGb5PTG7Tv8XNI/jEyJF?=
 =?us-ascii?Q?XBk3dNCpzHQh0t2fL71noAJmXiwggk1t5fzpPwknViTWgNt4xOKjy7cdrmI9?=
 =?us-ascii?Q?LDkqD/rCEVhp8vPCqvaMjFubfIv4TSIPdw4HUhzMQwWX00YqQYLGA+CEmoXI?=
 =?us-ascii?Q?pKTa6EpkY2xrz+3/VrKK+iigd+LiWGxJuf54R/ZY2Ztgaua6GV8x2yT14cDP?=
 =?us-ascii?Q?60tMTAPcueGGBxwaZFCE+KYDf/jSQyDflckGodtsGf20ZPD2mveerD9msaDC?=
 =?us-ascii?Q?TMXXw+SFWr3tGZKomwZAWjr+8w4StiPxZRYudMFhrlaiXr8H/H8TO6KliwbQ?=
 =?us-ascii?Q?dWLp//WlgOZ2Zso6obDn6xD+GF9mBzPzA1tU5KY5AL39wpEQaPgn8gLzXpth?=
 =?us-ascii?Q?gqUIve2UOlKLV/45ToUDBEkVNa/ZS0c9TNdc/rmkNDiA1gImSben5W86UKvx?=
 =?us-ascii?Q?z+59PnpCt+3SEgGssZUzbfZPVPA/iHwpbfrv7zoJD4zGOTWo1uzZcBpXcndd?=
 =?us-ascii?Q?Zl4+6SIWDimgpDxq/N8rZ1VALmPeVp+Tce70yK5uwE9bPPv1vcVGZzFAO0pB?=
 =?us-ascii?Q?7g89M0IjGbbccsqelByx6ngeoptHZrANuzW0H+XZkN54uEYaUbO0gmzn1+B7?=
 =?us-ascii?Q?JBbjFA558rWCJjQ9oiq8gwuT0W+opg4XR0umq8oGy7WaxLr3NCIE4zv/N+YV?=
 =?us-ascii?Q?ZQRN47raGo56iK5+EK1+h5XahuxTnRBNWTfCl3CX9P4ijpRKXrWxQUOvBq5i?=
 =?us-ascii?Q?Nv/ybPOkLU5V+ZGC/q0WkJ34cwlp69BSJ3VcoSDfn+fDDcSu/8w+cA5L1dMV?=
 =?us-ascii?Q?/QG9HLxy9QXh6ksEYBo+i+wkCQucMGi/k84hzE9FWsVITwklXaLFedDefKIP?=
 =?us-ascii?Q?7UBjPAsSe6qs+gkOXxrE5hbuOqOwe/Ou/cTb1Uu7yiq1EJKwLZYA7lSLmG37?=
 =?us-ascii?Q?f5juIG19wDwspyNMRHp213VsFrF2tWv9HugYHe/qVHjcfKMHDu/raYzrTkhV?=
 =?us-ascii?Q?HoyL1PC0zCFfNbKX2a4LyS5PRZSb5hdeKPSDjSsW9mviOjll+W4ZW2l3rwXT?=
 =?us-ascii?Q?SvC7/0hwbo1q1e77sVTvUTjR9vOcu3S83mOgZRYcoaPoUFv0k/om3jWmKsUE?=
 =?us-ascii?Q?293SHmvAGcAyYB3ogv5WJi3ljmUBsFCH9snM32N7D8qaMTz/Egba2jaHCoVp?=
 =?us-ascii?Q?8yCD1qYiAz+IniOr26buEdhkxP3QAdL296qS+0jSD7o81sAsRCpJHcLh0fXg?=
 =?us-ascii?Q?eoKQjHjxIDxifh6lpAvfOfeXJFkIx5r5ST8z+GT/fPKDWKZ7CPZKhmUkg4u1?=
 =?us-ascii?Q?uzvTWovrS83LSFzuV9R93s6x0Bus1FIEDDGop8s8F4YxmiLz4kzhhS7if+8M?=
 =?us-ascii?Q?xLtFWFogHL4ymypmlRzS5PHl4kWcNuIT1W6Aa6WhvFXVI5jm0Cp67cZWfetd?=
 =?us-ascii?Q?/KySb6PnSlmlCStmuftbkpJ/iMGGHBMYZw+yoeqF3G2cu7yKRQ55DYWQqUai?=
 =?us-ascii?Q?VxhDCD6GYfjR7ZNJZyqpvkhxqhQwjRfiKPGcj8YJ8Q73XpKwf0QjOixM02zZ?=
 =?us-ascii?Q?eGBR6lImnQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QDbI7H0wfImLbo0h0xeK8hacTDQDNNmWP6aFdFgNXq3f8fDwM5qHLBupp3vmeQhSnMv4hKvDkl00ceO1hQJ+mZQws7oP62lfWxJujGPWxnBTzwcOJxQOsOXcRfFVJF2aeIGZDWBBSeAOI8XNx6N4q0iewSYSAbfHN0zDjLS/cpYGCPBa61/ZvZjCeceeGtuwrMoBl32sD+J+ASh0u76I+uMNMo1yYCvgzPd8MPqHqu/fWDFCzu4D+uDNAxUAA1K+jGjQGJlIcOeYQJ3V6oOInITLvJjoBN+p7x8M12vycGuSYccpdKM2QXXtPs/MunHvyNk4bFxdC/FkYEE3xezMrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB797010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43acd860-19ef-480d-3cf1-08df2955f13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 18:15:20.5888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfaHEnaREZ/OZEumj2G9MK+9U8gGlO+RSPXKALH+GRGtrs9RuOB0doadcKv9FJvi/ECs3UQSgbvCc8DWK3r7Vm9xy9OjNEbaFO+yvhhi1E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
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

Acked-by: Nicolas Chautru <nicolas.chautru@intel.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, October 8, 2026 4:35 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Chautru, Nicolas
> <nicolas.chautru@intel.com>
> Subject: [PATCH v3 06/29] drivers/baseband: convert rte_smp_rmb to fence
>=20
> Replace deprecated rte_smp_rmb with equivalent
> rte_atomic_thread_fence(rte_memory_order_acquire).
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c |  8 ++++----
>  drivers/baseband/fpga_lte_fec/fpga_lte_fec.c       | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
> b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
> index 45bd171ca7..e804be4cea 100644
> --- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
> +++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
> @@ -2662,7 +2662,7 @@ vc_5gnr_dequeue_ldpc_enc_one_op_cb(struct
> fpga_5gnr_queue *q, struct rte_bbdev_e
>  		return -1;
>=20
>  	/* make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	rte_bbdev_log_debug("DMA response desc %p", desc);
>=20
> @@ -2691,7 +2691,7 @@ agx100_dequeue_ldpc_enc_one_op_cb(struct
> fpga_5gnr_queue *q, struct rte_bbdev_en
>  		return -1;
>=20
>  	/* make sure the response is read atomically. */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	rte_bbdev_log_debug("DMA response desc %p", desc);
>=20
> @@ -2723,7 +2723,7 @@ vc_5gnr_dequeue_ldpc_dec_one_op_cb(struct
> fpga_5gnr_queue *q, struct rte_bbdev_d
>  		return -1;
>=20
>  	/* make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  #ifdef RTE_LIBRTE_BBDEV_DEBUG
>  	vc_5gnr_print_dma_dec_desc_debug_info(desc);
> @@ -2769,7 +2769,7 @@ agx100_dequeue_ldpc_dec_one_op_cb(struct
> fpga_5gnr_queue *q, struct rte_bbdev_de
>  		return -1;
>=20
>  	/* make sure the response is read atomically. */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  #ifdef RTE_LIBRTE_BBDEV_DEBUG
>  	agx100_print_dma_dec_desc_debug_info(desc);
> diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
> b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
> index 04ac445820..cb3f29c10b 100644
> --- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
> +++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
> @@ -2093,7 +2093,7 @@ dequeue_enc_one_op_cb(struct fpga_queue *q,
> struct rte_bbdev_enc_op **op,
>  		return -1;
>=20
>  	/* make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	rte_bbdev_log_debug("DMA response desc %p", desc);
>=20
> @@ -2123,7 +2123,7 @@ dequeue_enc_one_op_tb(struct fpga_queue *q,
> struct rte_bbdev_enc_op **op,
>  		return -1;
>=20
>  	/* Make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	/* Verify if done bit in all CBs is set */
>  	cbs_in_op =3D desc->enc_req.cbs_in_op;
> @@ -2135,7 +2135,7 @@ dequeue_enc_one_op_tb(struct fpga_queue *q,
> struct rte_bbdev_enc_op **op,
>  	}
>=20
>  	/* Make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	for (cb_idx =3D 0; cb_idx < cbs_in_op; ++cb_idx) {
>  		desc =3D q->ring_addr + ((q->head_free_desc + desc_offset +
> @@ -2166,7 +2166,7 @@ dequeue_dec_one_op_cb(struct fpga_queue *q,
> struct rte_bbdev_dec_op **op,
>  		return -1;
>=20
>  	/* make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  #ifdef RTE_LIBRTE_BBDEV_DEBUG
>  	print_dma_dec_desc_debug_info(desc);
> @@ -2201,7 +2201,7 @@ dequeue_dec_one_op_tb(struct fpga_queue *q,
> struct rte_bbdev_dec_op **op,
>  		return -1;
>=20
>  	/* Make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	/* Verify if done bit in all CBs is set */
>  	cbs_in_op =3D desc->dec_req.cbs_in_op;
> @@ -2213,7 +2213,7 @@ dequeue_dec_one_op_tb(struct fpga_queue *q,
> struct rte_bbdev_dec_op **op,
>  	}
>=20
>  	/* Make sure the response is read atomically */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	for (cb_idx =3D 0; cb_idx < cbs_in_op; ++cb_idx) {
>  		desc =3D q->ring_addr + ((q->head_free_desc + desc_offset +
> --
> 2.53.0

