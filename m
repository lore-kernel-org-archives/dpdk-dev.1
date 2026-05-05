Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532EBCD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:58:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39DCA40684;
	Tue,  5 May 2026 18:58:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 012E140275
 for <dev@dpdk.org>; Tue,  5 May 2026 18:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778000322; x=1809536322;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g2jv1Q52BUfAr/mjE+A7QwxFFK5e7w+4ytAEeReT1AU=;
 b=CKrleygfTpWdLTJsgqOyX9QrpWUu92PGfHuN9nLBeaJ8KEFH1wkn3RSp
 g+D35vtMH7WUVzLoF2r8C+VI1Wgt89RaZi54qbBsM6OS9niLuXIMELYoQ
 cJtFdNWp6jEwjznb+GxRk+SbAD1WV4r2FqbtTABMa2E30UDvFZsEFm8vO
 jjx6TPhbjxBPCx3XKqFK1INyIegWcH9532cTZaLPXFtQE0EDLaZOW3Yv7
 QFC5vUnp71wTmRTXT3MbUyBKQrYYfAzwZamUa8OU1QWhzHU5amnZUMHLK
 79LcSGHoEykGwO7vEWRwHF284SZKoMtuNu8R2CVWyOgkIqsC+0tepF3ey g==;
X-CSE-ConnectionGUID: 84DAQ0u4QNeDru6Mf2vOgg==
X-CSE-MsgGUID: OEzUa9DHQuSYDXsLQtUjVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90335527"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="90335527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:58:34 -0700
X-CSE-ConnectionGUID: /d4uFRWgT82x5SxZVlbeUw==
X-CSE-MsgGUID: 8b5JgnR/TkucDfPdF7cJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240160964"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:58:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:58:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:58:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnDSCAiZtCt/7r/wzQ755VufjQqvaksq6sv3YjPetKa/jhmzW10NIlt/rlPELBaREoKCArx242fIbQsD2wespoS9Cz2ctb0iDMxUS3Bv5TvrrtR5+xtRmBwGNXBezeKViEXZ/E6YUJXkvDO+kRBav+6X6NhsI0nnhGVNQfOO10KNOyb48X726iagN0bHLe80Qu1vh752rsBezV4XU+DpECesasNP+trJXPI3DgneU786lR961r8jM/Y9DRSAPHTyJpvsiBaF8Ou59c+10um1fjd53Elan/kvWwLMFBbFnny3fNacWQCqDlYFiJlGqtkannulsTc/EQNOxiZrPAC5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHj2FxkJKela4jqnxl0lVAiqWMrTUTOasdd0i6QAnSc=;
 b=NFvzvfFcOanCv4Q3pev8nXCa5HHazo7x0Ab9g7t4y8nOMBMIYBzmw1MydIJMcwwEMI07MHFKuL3lpSHSWbwZZ0bGDBpR2tMm5c6JUaTPmUt3KGcLBQHtePCOgw7zET0bdn3mcUyoJ6eaUqpfodhuPQ2HH6E3xgS6m38+u78Ow3SfSfk/Guzp61n0QX3GH+xCOfQDENRNGaAIsBIRU27AJ1q8szwwsYEo2lXxI2EFgweMBMU0f7dT85et8zzI20s/XMmimvfjLvu7fbBTQD34o1CjcAIbyW/pprdrY8Hs8RU/XAbIoWXdm1g6kH7ZsQl1msGx9+vTnGDZYaE5eKzL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:58:27 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:58:27 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] net/iavf: add support for QinQ insertion
Thread-Topic: [PATCH] net/iavf: add support for QinQ insertion
Thread-Index: AQHc2H9o10ATryObdEyES8aCN9gqvbX/nkCAgAAQQRA=
Date: Tue, 5 May 2026 16:58:27 +0000
Message-ID: <CY5PR11MB6116EB1F473401DD8338FFE2E43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260430085813.230798-1-anurag.mandal@intel.com>
 <afoS_fPQcRO87406@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <afoS_fPQcRO87406@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|MN0PR11MB6136:EE_
x-ms-office365-filtering-correlation-id: ac8266b4-160b-46ab-f856-08deaac7873d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Umq6Mzv3t5sRTGVxg7U/Mrd2EvaYCeM520PN6l5XZ1WIbq/B2KRXmYVI1H0ud+5mjPTStKCxjrZOL6MFN7Tf43n5pgZXYlrId9zhuK8gFrQzZDIbunyTlQnkBAS+2FmJjXXyzr0kl5Ulpk1fsQSCSzUjc/B87jXcm2V5ctS1qWJD6D1wEzyNDvtjvBmLwH944uUbkuht0OqSmm4PRsyUCe5ItjhjR6IwjTdoQNobA3S5fpY5tB/eIUKbi95JJh24o+Gp53W7bENzEEAxZzHGtOkvTVXd+v5QGiRoXiMtnn7kxgALm9e34kH8u7/kEPSDITZ3nPI4/zEOSA6tNAq7CfwhPr2Sy6DZbM/Y1iURbOym66pUhJiMCOZsP132FjXG0arcUDqA9N2StIw6Gc9KSYW3QnCY2+vHVnrMLYjIL9iUZ2L3JiENxklxE1NNuS4J6sY3JpLMzFLzsZeueP8DxL6u2MdTx9518ewkyqIeNOWaeS8B1gh2jvF8gFp0Ticj03vIZR8y+Uu7mIZ36qPppht34HkzhLtfT9/S9yemQDWbTiXYAU4ww+wI7flbeoEbvLE5KqYV6pBggFL2fPxbcHcQmt8qQ9WzpXjI/00OOiAP0bjQ2P5OcDuIO8mWE3q1tx+81XdLbQlSke+boBRRyrF4xtxwIBQiWvVku7l3LrS42TYMbXj+gwZOZEp2bQqaf0zCzkGmhkytAssnqeok42jYQ0mhzB3IaY0RA0NxdHGuYWfj3iqor5eYe88FX7iQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dqQ0QynImxGMS0ry91QqmL1EXD9/39pxxOoRyDcScpRkyW3pznZfcvruU1vn?=
 =?us-ascii?Q?8NwB/S1X8fZyyBuJI/exjkTVisnsmioHCprHGXWN+1+SCVzMNuKgrHZRMcmx?=
 =?us-ascii?Q?IMtWkW0JcXwQY9A5O8olMXEOI3MEmcvssQ/v9AMvcw66DudtzO1m90XKHhKd?=
 =?us-ascii?Q?AfDdWcU30X7b1mj8Lt+ytavNIRqdNnt1QnE4mA4eWfmAD5F+ma6GWPgVMHhV?=
 =?us-ascii?Q?wS2G7gIyPURmGXnFRFgI5CzqefzgqBi6zEf0nwiH2M787WGeODUOkHsER346?=
 =?us-ascii?Q?lp6pCJ+b9frr1aAqFeyPaZIQNmT64W99qzCVkrUSBLGai7bCHszihwANqHM5?=
 =?us-ascii?Q?kTA7ysaDtYLzJuCIVT/cCOOGoerXk1V0CtmobZQv+6Ig+3GIbqCZw92mqLFY?=
 =?us-ascii?Q?kU2CNEEmvyuGi21VbTPpT6I92pbGf8hwu8nbpOb3EdynBMDVVZIWRlA1z8Gx?=
 =?us-ascii?Q?R7VDPSfjMSgMJDRBbhqvdyDJc//k9JDDg1anjWXk5jOlf0nl1Q6HIq0WUu39?=
 =?us-ascii?Q?CC9BecuZub5F90iXcikc/rrRcJbKVC3+nlo5MdivqFFrY3rijYzcImtwr6lF?=
 =?us-ascii?Q?2KNYij7ifivi0cIHUSy6d83k7yLKFFnrL2UCi0lYDiO/xLXDETBwFwIZaCSq?=
 =?us-ascii?Q?uX9mOTkof9HT+Z4owDNysspSIJqGcVOc74wAMgd5YtULnSEYLvX/ws40+yUl?=
 =?us-ascii?Q?La7nh8pPnbZz+ma3AxXdWHnpSVCK1bKwrAHscHTuAmQjU2QM58VgauCOPyLv?=
 =?us-ascii?Q?2MaOVlg9P2n4rIVkg+cXSyLtQYXYiL/NMOSyJF3XPFAF7zJnm8LXlHStMZxD?=
 =?us-ascii?Q?Q9CSWxjFi6GH49UJrhKLS24z2edMvxqjzjrRK1EOqywHZaZU4XgibJldckXN?=
 =?us-ascii?Q?PrDStWn3PcHBFwTcJNf/rcBHGIyzaTREUO4blR0hG+SQRaCWQDvmr/fftQVC?=
 =?us-ascii?Q?AcpIRunzV8gvzOExbp2wfzz4nAnGBc3ghBxfppwZ+Mtlf4NeKQEfJe468e0N?=
 =?us-ascii?Q?8S75AbNuI8K5bHUUmg/8p0AkHP8pJzHdflCb0gfuKZgUDfCeQBbK29iN8GCL?=
 =?us-ascii?Q?36NLGpRDU9wXO0Jo6y1oE1QXjV//bhyiuyqxUUm5crH0fZqhkzGhbkYl9UrW?=
 =?us-ascii?Q?vqBuZDkQRI5Qx6B0QBUOpxVVSWLC3Bm1dd8HYzsB0bJVKuDcsPCUEq2vyGvu?=
 =?us-ascii?Q?vZzdP9I6Mw3mRnxnQqX6bDS3SXUehdVBlwjIjZ9WubaFMb1srIQivKAA8KAr?=
 =?us-ascii?Q?AEiVO9Og4PGNF3YntQ55FaCMpYBdTayhhWczS4omu4xuCR9OpjtyyNARTY4M?=
 =?us-ascii?Q?Luqhu1XBiR4rywjX/vUBIb8YbzNPOEWRRi00oSwPdgFiNmo8oY+7tXljACpo?=
 =?us-ascii?Q?nnQeaNl2e/4KUzIBrpsMHXJbmuvNV4oiEP457dyJqNnpG8ppVfuox1Sacva9?=
 =?us-ascii?Q?OiCw7eshTo6RI2YVYCPd9qCviITmEx3ASqHJk6WAM2+w5WZ26DDS5Pc4VBRA?=
 =?us-ascii?Q?9WRJl7f6utsOSYsfSxvmokSWtpVuy9u0uMo3pbwXTGIRKOWIz0Ssp+uL4Ona?=
 =?us-ascii?Q?H7Hl/AWlz9noG5supdTJe4Pfn4BbVhBiSqUD1An7PYZv6HZJS8yprvbXav17?=
 =?us-ascii?Q?U/uVSwjnh82vAF0NKvU7wGvUGSUQDAszMXsgHsILgbtWZKPSThWUd6T0S9H1?=
 =?us-ascii?Q?O3vEnDJ8lLqWztRn0XPlbL1Cw92C1EL00W0+AXxG6ca0Wo7dMfyyONx29mdG?=
 =?us-ascii?Q?bbXoXFzHkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: afgEqt9xnyi0mZqw2iFriJ6dMqvzOvdovDd+Q5NM+yIRVcKFtoCAy6vY+s8rE+EF6pdrd5lbNokLCNmRLVryb0/d/sDLLQV3saYLJHX+jbMW93ausWSDNOvw68ZiIoh2riaGv6b3hNLferEonZcBudXXAfFvBHvjmvBqBJHb/d0CkRoo5Quzg53jeYYojbIh9YqiJr0GMlj+8my185biHkczA+H84qndsXD9pdrkGbifWZ0PBp+DKE/3dqUYuzXTucceXRZ06HF+ZsNUmOzijcSCsamUf1g/UzAxJj/6YxNDU96hsdnuKaRLUjEbtTKmUVwFk+ynskBR/oKmktzsHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8266b4-160b-46ab-f856-08deaac7873d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 16:58:27.6720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l2z590Dxy9U8xYw7M+6TgNc9igo+lWuaG7hoSv8SzBOm7vF0C1dQIlGwPaEwrVumwvDrtenF+Y6z1iwEUUdYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
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
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 05 May 2026 21:26
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
>=20
> On Thu, Apr 30, 2026 at 08:58:13AM +0000, Anurag Mandal wrote:
> > QinQ insertion with VLAN TPID 0x88a8 support is absent.
> >
> > This patch adds support for QinQ insertion for both Outer VLAN TPIDs
> > 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> > VLAN Extend should be enabled for the same and Outer VLAN TPID should
> > be set properly for TPID 0x88a8.
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
>=20
> In general, looks good. One query below.
>=20
> > ---
> >  doc/guides/nics/intel_vf.rst        | 19 ++++++++++
> >  drivers/net/intel/iavf/iavf.h       |  1 +
> >  drivers/net/intel/iavf/iavf_vchnl.c | 56
> > +++++++++++++++++++++++++++--
> >  3 files changed, 74 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/guides/nics/intel_vf.rst
> > b/doc/guides/nics/intel_vf.rst index dfff69b982..ce11ea6363 100644
> > --- a/doc/guides/nics/intel_vf.rst
> > +++ b/doc/guides/nics/intel_vf.rst
> > @@ -802,3 +802,22 @@ To start ``testpmd``, and enable QinQ strip for
> default TPID on port 0:
> >
> >     testpmd> vlan set extend on 0
> >     testpmd> vlan set qinq_strip on 0
> > +
> > +QinQ Configuration
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +When using QinQ Tx offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``),
> > +you must also enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``
> > +to configure the hardware for double VLAN mode.
> > +Without this, only the inner VLAN tag will be inserted.
> > +
> > +Example::
> > +
> > +  struct rte_eth_conf port_conf =3D {
> > +      .rxmode =3D {
> > +          .offloads =3D RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
> > +      },
> > +      .txmode =3D {
> > +          .offloads =3D RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
> > +      },
> > +  };
> > diff --git a/drivers/net/intel/iavf/iavf.h
> > b/drivers/net/intel/iavf/iavf.h index 6a77dacf59..0b6ed221d0 100644
> > --- a/drivers/net/intel/iavf/iavf.h
> > +++ b/drivers/net/intel/iavf/iavf.h
> > @@ -459,6 +459,7 @@ int iavf_get_supported_rxdid(struct iavf_adapter
> > *adapter);  int iavf_config_vlan_strip_v2(struct iavf_adapter
> > *adapter, bool enable);  int iavf_config_outer_vlan_strip_v2(struct
> > iavf_adapter *adapter, bool enable);  int
> > iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
> > +int iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter,
> > +bool enable);
> >  int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid=
,
> >  			 bool add);
> >  int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter); diff
> > --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > b/drivers/net/intel/iavf/iavf_vchnl.c
> > index c2f340db81..6dd7d455ba 100644
> > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > @@ -920,6 +920,51 @@ iavf_config_vlan_strip_v2(struct iavf_adapter
> *adapter, bool enable)
> >  	return ret;
> >  }
> >
> > +int
> > +iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool
> > +enable) {
> > +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> > +	struct virtchnl_vlan_supported_caps *insertion_caps;
> > +	struct virtchnl_vlan_setting vlan_insert;
> > +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
> > +	struct iavf_cmd_info args;
> > +	uint32_t *ethertype;
> > +	int ret;
> > +
> > +	memset(&vlan_insert, 0, sizeof(vlan_insert));
> > +	insertion_caps =3D &vf->vlan_v2_caps.offloads.insertion_support;
> > +
> > +	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> > +	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > +	    adapter->tpid =3D=3D RTE_ETHER_TYPE_QINQ) {
> > +		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_88A8;
> > +	} else if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100)
> &&
> > +		   (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > +		   adapter->tpid =3D=3D RTE_ETHER_TYPE_VLAN) {
> > +		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > +		*ethertype =3D VIRTCHNL_VLAN_ETHERTYPE_8100;
> > +	} else {
> > +		return -ENOTSUP;
> > +	}
> > +
> > +	vlan_insert.vport_id =3D vf->vsi_res->vsi_id;
> > +
> > +	args.ops =3D enable ? VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 :
> > +			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
> > +	args.in_args =3D (uint8_t *)&vlan_insert;
> > +	args.in_args_size =3D sizeof(vlan_insert);
> > +	args.out_buffer =3D msg_buf;
> > +	args.out_size =3D IAVF_AQ_BUF_SZ;
> > +	ret =3D iavf_execute_vf_cmd_safe(adapter, &args);
> > +	if (ret)
> > +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> > +			    enable ?
> "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
> > +
> "VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2");
> > +
> > +	return ret;
> > +}
> > +
> >  int
> >  iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
> > { @@ -929,14 +974,21 @@ iavf_config_vlan_insert_v2(struct iavf_adapter
> > *adapter, bool enable)
> >  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
> >  	struct iavf_cmd_info args;
> >  	uint32_t *ethertype;
> > +	bool qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> > +		    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> > +	bool insert_qinq =3D adapter->dev_data->dev_conf.txmode.offloads &
> > +			   RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
> >  	int ret;
> >
> > +	if (qinq && insert_qinq)
> > +		iavf_config_outer_vlan_insert_v2(adapter, enable);
> > +
> >  	insertion_caps =3D &vf->vlan_v2_caps.offloads.insertion_support;
> >
> > -	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> > +	if (!qinq && (insertion_caps->outer &
> VIRTCHNL_VLAN_ETHERTYPE_8100)
> > +&&
> >  	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
> >  		ethertype =3D &vlan_insert.outer_ethertype_setting;
> > -	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)
> &&
> > +	else if (qinq && (insertion_caps->inner &
> > +VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> >  		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
> >  		ethertype =3D &vlan_insert.inner_ethertype_setting;
>=20
> Is this not a functional change for existing code/apps? Is it possible th=
at there
> are apps which are depending on the current behaviour with no QinQ suppor=
t?
>=20
> /Bruce

Hi Bruce,=20

Thank you for the review.

QinQ insertion support is already present in IAVF PMD for TPID 0x8100 (802.=
1Q).
Meaning double VLAN insertion resulting in packets having 0x8100 (802.1Q) +=
 0x8100 (802.1Q), is already supported.

QinQ insertion with VLAN TPID 0x88a8 support is absent.
This patch adds support for QinQ insertion for both Outer VLAN TPIDs 0x88a8=
 (802.1ad).
So, double VLAN insertion resulting in packets having 0x88a8 (802.1ad) + + =
0x8100 (802.1Q) is achieved by this patch.
