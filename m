Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF3EC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 598EC4014F;
	Fri, 14 Aug 2026 14:44:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E73404013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786711459; x=1818247459;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5piDa7PhAOhBikFxaelEP2OjHd43ysZDO5nFipbI2+w=;
 b=gCQJ3Ok20GJg6i0gkeiTlcyVdD3gKfbKmnzRi18VDtfQykHPkB5ly80i
 aKP9coRXn/yYSYvbFdIrg13tlG6CUQz8HM+WgVuNSQwgQBtdBZCRvEy0M
 K4tzSfqCY/e1tye0Tg8Ush4sBFslxFXeJyBL3aV0xW43CG9V/4SobYeT0
 UvXXmqhLOn7zztFZ+Y0KuGhGfgYju/WmBZE3qZ6ASWs/j1kXa2YfToBmd
 k57M0XzdJEX06VRu6AcwgA41A2xaNkYa223ZGYdIRJaH98naADJEMB4SH
 8zQ3PhiiilwSIGRX7N+LVVP4AKPRjpiDuL8VtK0oWzpO1+OH2e2IuKMU0 Q==;
X-CSE-ConnectionGUID: ZAIBNQ1kQsaQ8Tq7kLdKEA==
X-CSE-MsgGUID: L1EdVIlZRJ2OKZ0buUJEzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87308064"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87308064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 05:44:18 -0700
X-CSE-ConnectionGUID: oVb5ywToR6mHYQObr3Bwag==
X-CSE-MsgGUID: eXX2TAN8SJu03seBoPIeOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="268068016"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 05:44:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 05:44:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 05:44:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 05:44:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5jzh86BlTbVTEMjASgGFhUPDHtLdRLZojm9GPZRHPqy5qDe3PE/ZGkLCPR/jwlZEApmnhhop3FzPTVAHJc57BzOqskxlxYVEi7yKPKWAdvbTAHSNl+jQkQvSU1r0fQ1IdVTwEN3+HlKOT8Mqxf8Jf4rZv+zREQ+ET/5F0LLceEetvJIR0CObfmxhDNkLXUygyrQxEN0oGRaJON6YkmR9OjQUuXdUPogMiPchLEFKJ6znkV2MnUIKHS6kcOAfBTcLE5ZRjric/afIDupPflRAkpC6mSPmgLX66q+fiMHl+ngRZ+YhtmxoN6mEJHArmEejusMKsmaaPVVdJNnqfMpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5piDa7PhAOhBikFxaelEP2OjHd43ysZDO5nFipbI2+w=;
 b=VZR3paGVbsCRV0axsUcx4ugllS8L7fAXjMQgE95teMd0y+4Z4Wak0fYMjmfZ3Bt65foK5dR+UjkT+NrsYt3LauS8d3lKIYLD/Ujb5zC5G8mMIf1n/vDI2/J92ev4C4zi+uMt3T6szXzhD0LOagDWApKeArvhGsWRHDBK5ht4+cTd1Nges3c26oTk7C+gY+Sfdnwsg3WpAUsoVwsGdCB555wiIAWO2BEjYCDd1CGHoKIKal39nHA+74BpJSXfKZmE7/cxNXENaoAB/RXKjCCeGeF/2LMF8pBPxe6v1tR7fFfYSBprEUtyY/k94Yft6wwGfpGzcWmcpO2SNh98zYtLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 12:44:14 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 12:44:12 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 2/2] net/iavf: rename LLDP Tx devarg
Thread-Topic: [PATCH 2/2] net/iavf: rename LLDP Tx devarg
Thread-Index: AQHdKNEowviAP0MEn0Sp3O6jjXiqUracJWkAgAFeBMA=
Date: Fri, 14 Aug 2026 12:44:12 +0000
Message-ID: <IA4PR11MB92789F7BE37B80F4AE92B4798EDA2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
 <20260810140354.1869708-2-ciara.loftus@intel.com>
 <an3n3stq0tftci6b@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <an3n3stq0tftci6b@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH7PR11MB7964:EE_
x-ms-office365-filtering-correlation-id: 35962f7f-37bc-4f82-266f-08defa01bdfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: IsbnTzFqVbMPNNh1qH8fEC4DqhVElzPQxqVyTogRa9dYcKkZxxn/S1+FFgm9hCK4DmQDAlu+oJK75+m3WWVNqbin/mv9IyXoBgNosOxQ2fCmaUrWXzYe/KH1nbG5oDG8QCGzY6XEWL0gzoYEJjmS44lrsbTThDWpFNYzzNuQoKuN8Eg9BTvPGj6laozOcdk809d4sRN84cL5r0niFOpjlaC1sjgQKCYjEd71WnNXHs4umJATpKwyD+IiA4tHAwiqRz1xk96Nc1Czq4D6y/6m0acwyZhGRvtsN41QENT8J/ndTK1AWMPrc3hhIsRo7zqHEOTPnXT0HxwZJqMeoQuwjedgcxGt2TDI+TH/qL3OgyX/YQ37X2DF3ZvIlR0iPFLyXvCnAQoPMOP61BI+rm4/lBiRiXKvS2X0ays014ytKTxYKhA+AJlHnJBGoA4O/i8MG5TVSuOJ1WBztrqqLw8ptbYSnQh1n/LduqpvK7qsVp+6J+qsxRpc5EDcESbi1kkreFxWadAGOQ6Ih9e/3bNNqO9vYjYOcQxoJSRtxJFr9vSfz5U5whJKPB8X7jUwcV01kIsCLbyX7WnwPRNlwrkBoUNTENo2rM/n/Szw+eX3NQ+Td11dfA34zj1piBt/cbbx5k/sgc+0YiNjlHsbvxGgpp4mJKtBCH+Z0wjQ7jZvKFD3BBWWHmvSC+ojqRr8KLaZ0GUAucfypNYtYxmTSMUwCW8ukIiUB6ZfdRRSfx0uBsE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UleleHNfvEObH6/qMrJhcNtZfiZuXRExBek2EilRkRPxPu0qGE3LEj3J8w9a?=
 =?us-ascii?Q?HsbOA609bTul544p1YomqtmMfgvBhq/uPk5otpPWswHAK0li5L7iDKco+9RZ?=
 =?us-ascii?Q?yN+cWxHRQ97Jbxh3lwHER4XpKKHTcHcuO9MYxJYo94DSx/2BDrPxnC2jkKBs?=
 =?us-ascii?Q?fdvy6tGyXVrAdEd75XW5j0DVf08rBUeTbz8WVi0XaefGdzQA+ladzX79i3cm?=
 =?us-ascii?Q?RqhtY74Y19V2ynS/hl4im3xV11A9iNaPBFpeTlZVgWHZPB7ISRVf1MV7OYeZ?=
 =?us-ascii?Q?OGIUlAuK4V6Fd6ei1gzAE35zJ3hlNtw8WlszmvgbvK4+aIg6BpZbiGXtFgbO?=
 =?us-ascii?Q?yUkwK4OcaOX1Xcznk0YoNNGhcZNuNYAz1Z/FGYsu2pLtxJYSawYxTo3FvYt9?=
 =?us-ascii?Q?ysExbV+lAx5ymKzyGvrbY48Z84ooTG2RQcMt8O3kjUl50Lsf8LXEfd020nhl?=
 =?us-ascii?Q?2FmCohcYLGrs719d4/UKXYO7RgZinqRuP3mdFBLJckhKwOg7sc0qoF65eyBQ?=
 =?us-ascii?Q?HLWFxX0Zdn5m5+ZwpPsufh/VpzNpulaYFk9jMOVfYmeRHlOJhTnFgvU1LWZm?=
 =?us-ascii?Q?xvj4JHT3nlQiXR3mGTvumBG8nPy3mwUfHHwKYLXozf/w/Qu1Rv6G2YE44Bgm?=
 =?us-ascii?Q?5tWdrbP+kjsSgnjBkUv8Sf/UNkYyvAMfSD+qJFDjoFr0zlXOsHVPVtK03EBS?=
 =?us-ascii?Q?DmkI6bgGjLfw4zYO5iSEkRToLY38g19WHH2kT775ZtDJBWRz9vxi6bQPHEbj?=
 =?us-ascii?Q?lmL7Nd4GWRXYxEudcvQqmOZNuw3ZGZc3e2YuUgKS2yYdGnvPauTqCKjHjW3o?=
 =?us-ascii?Q?+bm36Fp0aHvEot7/713GAJOy35moUcUSQq0AmcarMlvg7X+OWvU9PPj5GRLy?=
 =?us-ascii?Q?wfVhJl6Zjgj9md83+ueE6Ct3sW+z+c3rK5Bbd3g3G27JkVVy7h41RGujYf2g?=
 =?us-ascii?Q?zzjIlRq84si5TSkRAH/nJlK8zHZnRney2o9yRr1bU8T7c1CyAInQgamIBHNy?=
 =?us-ascii?Q?b8BihlVBCr0QDVJJAZd+bwADhlQE6CYoHjZcRqSt1tsepSgTHsifrjoawPP+?=
 =?us-ascii?Q?pAtNaJcN6L2QSlUBipQHZXafj9/M3nUt0GZ2tF9S44nZAQsrEVvsJZ5VuRiT?=
 =?us-ascii?Q?1nMr7iUg7iXYJ+GaHEqRVl3tRLMbpKH0Q8kdlrlVdOMvVPXZnSSH6PYwm99q?=
 =?us-ascii?Q?fKoiKAKsCIhfBPRE1yJg55FSZ8n5LYWQtOCnxnC47cIPrY9vIwUa2bqm4QG8?=
 =?us-ascii?Q?TO+qI+GlKkK4R2V+Z6N/gj97xumFianmEuD86LrFQ96t7A9rV3SZsDCqCk49?=
 =?us-ascii?Q?+5Uai8P3MLgUu0cX/3SOqxdaE2bG7cmMQNEq6pGjE5C61rT3htyaQ/Yp/SNO?=
 =?us-ascii?Q?WX/3qayTySLK8ZOelcrnRwy+n/AsaMXFyfyCYpJMFn7bn8dGccuK50naC1i6?=
 =?us-ascii?Q?8dTc4zJS4jzLrYXlV/yxCPhA0OvQ4WB6zPuD0fD8g1EcQwwO8ZtO4jy8aret?=
 =?us-ascii?Q?r2i3nIUdOUSeSmClMXv8z4ivj7GXJOqNUvQn8pU60K+37qHbAA3I3RcQrHuf?=
 =?us-ascii?Q?7gFugEnw7ogD9naOT4bwnvDwwnqBeaSjYcjJ4bAGOfsKA+D4lK43pkiPaA86?=
 =?us-ascii?Q?5yfipah6q8OxO6Dd891Z6tevpkESWIYSk8Xc2lkmgChHg0f3a30cqHCzsq6M?=
 =?us-ascii?Q?lP9vdQumx6U1FS5NLv08rDMmtqHSZIBk6PhM+if+GRSk3Kk55V0mcVE44OYR?=
 =?us-ascii?Q?klUw935u6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r48KmMnYDcxh1usxqhitdnCucgYFZMV0l9wVj7t+hNVkpV+q9y+nwIC8DHCmrY9ZE/vZeDcATdOMim4SXs78GmoGZhgAI+H9SnK8AVnvU9okJdeBTzI2acqtKeeuY4ve+yD5DdfJE2AjKsre1VH+rCN5rV6Gb7SW98DezBmcQ+Ia/PcgmbYq9SZcVxbxHwlZLeM9QcyY6PbA04qHr8vJDudafZcw2tGovaKpTdXGtXdCyxL5TcqE1/LOqc2k17LLU23eGuW/nIMbJ1Hlm15pjYuwesQ7E+RRt8tsJh3NEae1qmGpuOXzzC3yy+XxospUoi4feWkyXdwFGqynbdbrJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35962f7f-37bc-4f82-266f-08defa01bdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 12:44:12.2170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GN3D6JHgekoYZFTn006CNHY04e082kWBum/nydm1gJxHaKpjnCrI5VZ5NtDMo7rVxNWZrzrOk4ff8zEFHVxnSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
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

> Subject: Re: [PATCH 2/2] net/iavf: rename LLDP Tx devarg
>=20
> On Mon, Aug 10, 2026 at 02:03:54PM +0000, Ciara Loftus wrote:
> > Now that the dynamic mbuf field method has been removed, packet type is
> > the only mechanism used to detect LLDP packets on the transmit path.
> > Using the word 'ptype' in the 'enable_ptype_lldp' devarg is therefore
> > unnecessary and an implementation detail that no longer needs to be
> > exposed to users.
> >
> > Add an 'enable_lldp' devarg but keep 'enable_ptype_lldp' as a deprecate=
d
> > alias that maps to the same setting and emits a warning when used. If
> > both are supplied, 'enable_lldp' takes precedence. The
> > 'enable_ptype_lldp' devarg will be removed in a future release.
> >
> I wonder if it's just better to implement a hard failure for use of the
> legacy devarg? The old devarg was only present for a release or two, so
> shouldn't be that common and its use implies an app or script running an
> app that hasn't been properly updated to latest release.
>=20
> Also, is it worth throwing a warning on dev probe or start if the LLDP
> dynamic mbuf field is present? It's again a sign that an app hasn't been
> updated properly. [I don't think we can hard-fail in this case].

+1 for both recommendations. I've posted a v2 with those implemented.

Thanks,
Ciara

>=20
> /Bruce
