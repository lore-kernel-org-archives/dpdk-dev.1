Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB87CD98E2
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93DC6402BE;
	Tue,  9 Jun 2026 14:04:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5DE244025E;
 Tue,  9 Jun 2026 14:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781006662; x=1812542662;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+9aiaXyQOOeOSeXrpj5a+hYBSTBTuN9V9Hu+jxJoyLA=;
 b=ZaGKanGgwYo4B0Jllz3sq/ewDXiqc8n2MmEAQPcteXK1KNXx8GkcBgnY
 gBwmSU0Y7kNhkq2tw3lDw57sTDnHtfVU6ftsxClxDradqOALQNTtBTg+m
 jkkH04zHnRDTuZeWtKAOqNsCSsZHqdUMNshkqbKk7oTVxg5g80N9PL6zo
 LtHU2K8xxLwJihboOE9WXIzRNTjSmZuLjcoC7MU5WD1+pbEeN1oijV6Gk
 dI7pE3bDymQ9BcIC5Y6vWmaX4Dwc7it8tpysERAjw+9X0KtbUQ8/+9Boc
 bv7t7+vhhS3GRxk76rZqld2hOkEYv6E7tp0mbzK8AZowebUpLzznj4d0C Q==;
X-CSE-ConnectionGUID: YB+VKqNuQru6DStKXDHwhA==
X-CSE-MsgGUID: SaGJGpkFTzSSxbg7+Cvoig==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69297807"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="69297807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:04:20 -0700
X-CSE-ConnectionGUID: sAwCLyWeQMK19iFCZ0Q51g==
X-CSE-MsgGUID: 7XH+hfjlTk6zdl9NtIPLHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="249769981"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:04:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:04:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 05:04:17 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9wT21BlOEz1a2KncPaVTk/N9hsuLFKUEUh6fGxl3B+YBAlO1A+goRq4ovbfFXA6IxprLWNDxHXDXndU1LzinzXUyNHLB2XOYjkqPlKl/HZCDvMMZDET30i2TxY7/aNx3r6f5hgAXEMRKuTIl+dj9PhmevxSR5RitZF5vuU5wGaGbLOsqQqNmZosA6ZDr+eHFVQ5lgdtEkdyVXMtF46vcOnxICxahN6A0EAQkJFXEneVEp96NLao63M7hz+o8kuykjhvj2KNyFE13ocjhheNKXGdMBrlCmKerQyVS9wdHSpdo4BP8GFSoX6bqAt1R+tBbgq9LhDR4w0YXmZtVEsDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YutVYehW1f/xwF8xZiD5mjDzTBB/9DO5x8xesSHjf/s=;
 b=Voui/c20UbsK7eWg96Dl5vKs+VUGN+AfTNsXpn5CJLxL8fT0Th5DcwRRV4tpE97hRxGrBbgFrqxFAtLIjFylhzdtWAyWSwo6o2zs1I/JG6v/JzUYhcAklNNcL2bJ0/ASXC349qWF9wp1gWBTx/GLK8PmVKkHKZh0XATI5ZV/EhERGol40QBdE9hmU4OXq5w06CXKhk6Pz65pZ2xf2JUINEtiQLEkzCW+ETPuEGXgcMUfMk+lQ95ADlvFnHXz1h/1c8bExQOn1hkr6MZ2BIcf1hz5MRc2Cdagf6uEF/fstj6Y5JKMePtCG+y/ti/Q2kTpJndOegI0swEXohQY4WVK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:04:14 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:04:14 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix misleading AQ failure logging
Thread-Topic: [PATCH] net/iavf: fix misleading AQ failure logging
Thread-Index: AQHc92pzqm2hpP7xBk+Vx7iSpcMVJLY14P0AgABABDA=
Date: Tue, 9 Jun 2026 12:04:14 +0000
Message-ID: <CY5PR11MB611679166C6869FCCFF959D6E41D2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260608171559.355521-1-anurag.mandal@intel.com>
 <IA4PR11MB9278A4729FF823D93BE849988E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278A4729FF823D93BE849988E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|SA1PR11MB6782:EE_
x-ms-office365-filtering-correlation-id: 1e7e43ec-609d-46bc-d177-08dec61f395a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: /L95KgiehZjQHgOugiihR2/LEGOKnA+L9kBoQm27qJTbR6XbEjWRLdKJE+gUnBDLLi9qXmXM/jvyvkNUvd6Yy/qrt2/fFNn5aLGyoBPvKbHtbTf/STyo4WhrCduNPPh5njOawceIxqsNtSL2DztmmHnNbmivtgGd7IyncDXzd/EmUKKeiuCwTW/6+3EaBnWVSuy45wXhRbBLchZZrfkvDzzPnPRoajhdkMxwa/mczgAX7tOuOU+5Qo4a9dKObFds8WmlhiJHMFH9URSnkc0aYzJTEbOzaAIwPEOIYvDaZLd/eRq8o2F6mu/faMgZ42aHxZ+KRzYpI7fsbrL7OfLUOKvKfH+0PVVPhzmWPWVhXc3g1cyqHsAQPCOLGt25NcOfOLACJlI+Wd3iVWcEJSDh8gFTMzZSaW/BPLj3Y25bBzv4onyhi3KPcSQQ3EUL5DydRmeMcYE1bcODVppEGwQuaPtg+4/c/Bv1pNEMpJB3zRNk8fRFMxwCcnoyVg5SAe4mrWIxgjPQ8iXXEWc6tFLkRIgMP9cZFNa6gCIHZN3hHdkLPImLVJESGUfI+2WL1Bl4HsUlU1+fpjMYqSFZfZGmfPRkkbiGSlknZbHXAJbtD465whxU32dushfDv3grny5zyMrJG2CffgPw/kRcvHu/Lbhwr9Q4UEsu4ZHlWJCINWGiFTHNqsY69s5soKc/cvezjfWxIaF0owkTsq9hMI43mtSFWz2LLZ20X338r6RDvBEDKIfLDlm3mT523R94aBjf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rKaKtjdyWsZUy2ZQtg2mXRsUKPDzL5UCEr9shBI/an05Cy1KnadJGz/fMkYC?=
 =?us-ascii?Q?IubKnajs6eTG+hykEwbYFE8kSrsTpm40x5OVcEXBIXNN8XQdg6jubmf3J+X1?=
 =?us-ascii?Q?wpGBh+rjdjvM8OBX8gN04TtnsmNQyvzi8dm3+LvFlmabSwBjDDG6trCgUD1Y?=
 =?us-ascii?Q?vBgh+5jYo3pUrfyVKG1zsX1/YumApXdTZsgqybzKYOn/MoMkQFEXAalq+FWH?=
 =?us-ascii?Q?Vu/CAQJOttdq2KJiVGnGgV95LRBY4ciKM0SY1s6jRun6cl7MI49ZJjzWkQUU?=
 =?us-ascii?Q?cFzniIVABzJPD7mpk69ZzbO/ZPKoNnl146UBLJXuFjjPhCraDaENyDZFvIWi?=
 =?us-ascii?Q?JHcvYqisFRVwm2Wpq02NC50QTBcDtS6V95SAxgqsAuw0vnYFFntcBERCDQVl?=
 =?us-ascii?Q?oIm4NfLD3PAMc+dAjpLjfxzm8q1iCRuOD2gLSXwdl4qDCnssuLBhhhe8le1s?=
 =?us-ascii?Q?NQooTlut8Eu+or/ryieVHie0nLN2B4BTCOBhQTuyGPIkycaLxwhqB10vImo6?=
 =?us-ascii?Q?It0M8SQ/9njBCII/o6mlWxpj2cq5z2hUO01wnAvPQubKzGMzaSAjbVnbaEMp?=
 =?us-ascii?Q?RPBaQNL6NwUHsyB2HC72nErb0nIylqv31++WnKlXfAWr7CpEzQ7aP1XE3HyO?=
 =?us-ascii?Q?PZT2G8w03lSZfhLy94oL+DMWrl51SX4DXI8kPWINQflCagMvlIAJ5+X9ojcQ?=
 =?us-ascii?Q?1UrmFBNu/saB34MJ9CJUggQd2J575BOz+8Ajn3aLTcVFlsMjLu9v6wGQz/Dq?=
 =?us-ascii?Q?OlZdjrSH0PLVuMgQ9ElCGwCLCTWBOc8GP3Y4P70WRvrDl+x+CBlnbculs9Gh?=
 =?us-ascii?Q?Pb0nSqvnZcr+iPFWjfMkAm6QQ+jQYve5A7AApn1HawYktWgqzV4E+Q/KMnjK?=
 =?us-ascii?Q?6wv9FSDMEagWLnj/WccMsDp5XMif54+9lxKAJlOTlqqhJHwHcG+js0TVZa7C?=
 =?us-ascii?Q?fNXUM/A4+9fqg1P0FmjArtNAMCWEm2ExJo6xfm+ox/OliawHLTuL9Sk/3ga2?=
 =?us-ascii?Q?qlSvVDH01QhIdkXJ4gWfh9ki7sEIIIZKJuOZXmra799eBEAPzUBB16TXc4HQ?=
 =?us-ascii?Q?jwFgCWHuJA5+2StWQ46wmstiUgcrXiOOqb/OsMTLmdACVpNatIBMhjViRjQ1?=
 =?us-ascii?Q?ec+5N7apOsMFdUw+uwZHu2XDFn6fx5XN/OyXRED1tfKVaEz6EsE3i3vaxIzy?=
 =?us-ascii?Q?muABJWesM35ufpozUk75pjKzO6TJi5ddvd+J+MNKhDQpONszQiq4Tl9HFjQp?=
 =?us-ascii?Q?0Coq43VpNlv9pt1ZY2e3AezVpVk/CjESFBxEHX1FZzqfGzBCGlRlhsMRZnJv?=
 =?us-ascii?Q?e+s10ya/m4FDtzAa+9v9MiyeuXhiZ77jYAa6u1I7gr1uNkniNx5mq5z4W8Uu?=
 =?us-ascii?Q?eejjGv0EJcD/MiNb7pDFlGNs0h90ehkdd9xvAlUTGYeBqsvxCdQCPnhOSNxv?=
 =?us-ascii?Q?6kd1RQ4crW32SBnc71aYatk/zGEAMvoGcnB6AzqCmU/116WLWgYpKaU4L5oX?=
 =?us-ascii?Q?SGU1A4yd+zF+cyhNSwCEgcB70X+YYKDb0PLrQLYWZffhDi+m8hSRTsh8GF01?=
 =?us-ascii?Q?dBwlGSYz4eXMpvtuxxFAsej+/wYkTRiDnEYIONWVm8sIxpr7mVy9DDzvffoW?=
 =?us-ascii?Q?OdPdL0LtU9CVMAxrMZjMnDLXNJ54FTfpSVt6srpZ2GYGim0evq1vaeRwWLV6?=
 =?us-ascii?Q?6yDf4QwktaVFcFnNd8OeKMbKfM0TnEPeKgEoVkA8YKX9JT9sWT0AM6C3ErI9?=
 =?us-ascii?Q?I8ePGeBlEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gOnPL3EzO+XblnKF88Z9G6SeJUV9KZSEyHYOr1kkR7xV47qetmDd89O7hmep5/GhYqRxOXpdEAZ4xy9HO/ZHqZJwnGNoIlnztdoua9k6tzkxPFEU0De71KD/4BOk5chIXfMHQ5wgUoCuz7jUtZjIWieX0sJe1Ws41eySOGKVZrLffSunrw/h84QVn6K58v4tle4a4hNhony9sheDVqzxhlxqRuwGHjL2vB3ifTBArk5znHhJgiT1y/qgkqpCe5V1PI+3UFRXuNBgjLcLV+QAhMerZa0Sv3ZE07hUgDCLznFMxbisJMzAbHISpyOU2bYqySHJXpbsdR4SGM+T/oentw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e43ec-609d-46bc-d177-08dec61f395a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 12:04:14.1205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWRhb2O+JkXdMt6uBZCoHaeXarjJn2YB/dK4eIcoySPv2rrDGA0kbc6n/WBuWDSlRNoG3ouovJwkFtwqJHzEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
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
> From: Loftus, Ciara <ciara.loftus@intel.com>
> Sent: 09 June 2026 13:44
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; stable@dpdk.org
> Subject: RE: [PATCH] net/iavf: fix misleading AQ failure logging
>=20
> > Subject: [PATCH] net/iavf: fix misleading AQ failure logging
> >
> > iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
> > until iavf_clean_arq_element() reports that no descriptors are
> > pending. When the queue becomes empty, the base driver returns
> > IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
> terminator
> > for the drain loop, and is not an error.
> >
> > The current loop treats every non-IAVF_SUCCESS return as a failure and
> > logs it as follows:
> >
> > "Failed to read msg from AdminQ, ret: -57"
> >
> > This message floods the logs on every interrupt cycle and misleads the
> > triage during VF reset by chasing a real virtchnl problem seeing these
> > spurious -57 AQ failure lines in logs and assumes the admin queue is
> > broken, when in fact it has just been drained.
> >
> > This patch fixes the aforesaid issue by treating
> > IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
> > loop exit empty-queue condition and avoid logging it as an misleading
> > AQ failure.
> >
> > Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_vchnl.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > b/drivers/net/intel/iavf/iavf_vchnl.c
> > index 94ccfb5d6e..870d5c1820 100644
> > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > @@ -570,7 +570,15 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
> >  	while (pending) {
> >  		ret =3D iavf_clean_arq_element(hw, &info, &pending);
> >
> > -		if (ret !=3D IAVF_SUCCESS) {
> > +		/*
> > +		 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is
> > empty
> > +		 * and is a normal way to terminate the drain loop.
> > +		 * Log error only for genuine other failure codes.
> > +		 * Incorrect logging like this during VF resets might
> > +		 * mislead into chasing a non-existent AQ failure.
> > +		 */
> > +		if (ret !=3D IAVF_SUCCESS &&
> > +		    ret !=3D IAVF_ERR_ADMIN_QUEUE_NO_WORK) {
> >  			PMD_DRV_LOG(INFO, "Failed to read msg from
> AdminQ,"
> >  				    "ret: %d", ret);
> >  			break;
> > --
>=20
> I agree we should suppress the log on ret=3DNO_WORK but I think we should=
 still
> break instead of proceeding with the message handling code. With your
> changes, in place of the
> log:
> 	IAVF_DRIVER: iavf_handle_virtchnl_msg(): Failed to read msg from
> AdminQ,ret: -57 I now see:
> 	IAVF_DRIVER: iavf_handle_virtchnl_msg(): Request 0 is not supported
> yet
>=20
> I think that's because we enter the message handling code and arrive at t=
he
> default case in the switch statement.

Hi Ciara,

Thanks for the review. I checked. You are correct.
Sent v2 with proper fix.
Please review. Thanks!

Thanks,
Anurag

