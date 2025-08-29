Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BDBCA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC41F40263;
	Fri, 29 Aug 2025 11:46:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3B21D4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756460810; x=1787996810;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y8M5Dllq4x8VhCvmHUh+4mKZM+nEn+XR/MrPDjJ0l+c=;
 b=WH2IeaRmC5ekFrhees+lfoHlauBaXdOWKPYVtiXKrB1tC5Fb5Xhc71rN
 FC6D21DrAohGb1YdKu+KHXVT4am7aIZTh8U+m+8yPxuB5T/h83ObbpM0v
 1O0pMDG2EDUMahGrQM1AHJKeQKNmj8itTI8DThPxVoXR5l1qISNnN4Ss0
 YSFPds7sTGKdffax+DYaXR/uwNfscanbDOAm1TvwIwsAKlFJHVlaUGblO
 nsmhjo9/9rvBaKr65FFylBspZI0nxiB93zreS+oiRXFQIIDNB7Ja+Ihbc
 jaNa4syE/NZ3xdJrshrwtQbHR4vrq1A7kF7btbQaFAHf6J1lCP25XyQUr A==;
X-CSE-ConnectionGUID: MWNedqVFR7Cg6UuHImpnaQ==
X-CSE-MsgGUID: e8Xs7IKzR6OpSFzYn9Ia6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="61378791"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="61378791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 02:46:49 -0700
X-CSE-ConnectionGUID: v35gGBdPSJ+nDKrWzvFw6A==
X-CSE-MsgGUID: nG3THbSoQOqTDJzeP640jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174696539"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 02:46:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 02:46:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 02:46:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 02:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbQ93sUND7jvgZNFRccQqnZqpp0p/D1SPGyL+7lIOnDFTl12ygNlohd41Ld+yco151XYgKnZ6MsNyWLBBtesWvS5wsddwC6z4cTDjUX1Lmsl0612RDNDUPsopWgMzmREwAWfDlo3qnKTn4aTy+gttwCdaNWtTpWpEwbxFagiX2wPmxpMjCiy5g6ytefwjWI/WBViAbMEyfr2DBEmgpoPc5084dwltmo67kxWDVpdk8UuxkYbFtjjgLx6kHCtFUt28eHZqDUFz7T+GxRajue3BvmN7ZKGRAFRpGcJMIpEc7bW7QvYZubiJmuSoMYdpNgI/9gVyhsISB9uhkLtNLV9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8M5Dllq4x8VhCvmHUh+4mKZM+nEn+XR/MrPDjJ0l+c=;
 b=QfCvIzYofJAieZsdSXHryfUNtMHH3mZLLunydJvzMttpss+bT02KaQkZlSyjFkWAAyfbWYTlq1Yl0ctcjYi6bXlLQ6HPPNLcco6lmJ/tdgkB7yc86CFBpWFVlJUG7pJeDLbjML4lHBuu7FpprS4mdwAgCIT7CQkF2lASDOPY3H5tXi07DB+zXRPINzVm7sn38lKDq6F+qYK8ciNnXsywFiA9QiscXpBqN6ePUR77CmFSYqt1QivypjEbKY1sy+gnChZdq3hpZVG3MnPYJ1sm65RXq8tvRINOH4K5qo8bTzm5mcP8yIzKFkAroz3Y/jNbw59/lSPEUcbgn4oml1zkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by CY5PR11MB6416.namprd11.prod.outlook.com
 (2603:10b6:930:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 09:46:44 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%3]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 09:46:44 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/ice: make link state configurable on device stop
Thread-Topic: [PATCH] net/ice: make link state configurable on device stop
Thread-Index: AQHcGAXMSnmY2EqqDEmMyqwChv2G47R4J6CAgAE7zDA=
Date: Fri, 29 Aug 2025 09:46:44 +0000
Message-ID: <DM3PPF7D18F34A158305FAB4D8BECCD2DE38E3AA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
 <20250828075547.1fe99122@hermes.local>
In-Reply-To: <20250828075547.1fe99122@hermes.local>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 59de1fad-f46e-449f-2bd1-08dde6e0f703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cMX8pbLGaaYi5ghgJpHsYrl8lWzqnXAi8P27cKfSLbyBVTsQFeAxdi0tYb2a?=
 =?us-ascii?Q?haWLi+zwGZBVnTnIp83mvMrwRGSmYCBoJNKGwobGkaxivZOgJmsAwSSNG4Fl?=
 =?us-ascii?Q?e0r9Gaah0XO1Zqvde3XAzpkUKE8jgt4Sn96hv7ucTqSNf9vvLyuQ15qGgvV5?=
 =?us-ascii?Q?PnjzFhvP/70n1Rc78fwaL4rx0t7Vb3yYeXJ/CgN1UT1jBUse3QsSC1+Cjc7i?=
 =?us-ascii?Q?ExVIzq2Nrmb4l9FT42cjAoRtjPMrC0AOi6mke7axiWwl7zdw5g3FOA90ySCG?=
 =?us-ascii?Q?V0TfuFPeePxwvCIGnuluyg4OI46PfNrYbVSEVcLJluAEkWnDIOV72O4u3aWJ?=
 =?us-ascii?Q?JiMNc0iNYpfyr8r2NS25TrfEj7kyjROg7PFOTO5ZeFISwfmH3kUB6IqDKY43?=
 =?us-ascii?Q?97YKC8tM3r2LAa70gRITgDT9Ssq7UgwDZM3kwtXrlIRvk+P9D5EwfHjlUuAm?=
 =?us-ascii?Q?1nsZ5HXmvitjlCRSk2/B1lS2SpiYkCO3qNexTSopma0yNCgliJpiPcFrJgK1?=
 =?us-ascii?Q?2Qg5KdXTFebMyYqSr7QRFm/BzSP+F5It/N5quVagruH0a0zx8NnwKKUDSAy2?=
 =?us-ascii?Q?56XnMp/Z/byLBebsbqmdvoOkw18CYnONSMO+lb1vYe2nesGQNUdBaV1sNmx1?=
 =?us-ascii?Q?yUh8iujyyFXRqtho6EdU3oy02I3pgP6l4zhbAErr0Q4kziTSxrDT8L4UrmmD?=
 =?us-ascii?Q?VEdpEhNCC3Y9aCkvgeXWvL8SU7sINgBiCd4pgGu59uZjzlqULIHyzP9gEKRn?=
 =?us-ascii?Q?7gkQ75cIkU2a1foy+MDi0xjTfZz27fCla4Km2APbEzim1eM2kSnrKNAODiAN?=
 =?us-ascii?Q?/1eQoSeKVIXJuQz+UZIm/T34MLEQRR+vGrD56lOMQAp5bHSLy39zaAh05GXn?=
 =?us-ascii?Q?0z0wGPC7W3k6GpxoBLlw2ocsgNYYdX+vSY7ljxf0IqBDDZA2SNcWuKGSj6DR?=
 =?us-ascii?Q?uHIpuRtK0JMqmyOOkoU6CeBJCayD+8eauY36nS4aHvW1T9L1nsb7MeSUSurE?=
 =?us-ascii?Q?WNOpGOrSTCA7ujZafcSMGWwjpxrqjvPEGUjJ8/5okKtcbZSQnDuUKZFDDzhe?=
 =?us-ascii?Q?ijDzsxN0L2g8RFqzguUjEszSwzpnmO8SYsxGo69hHWcQd0uVhnZO2YhbOz/G?=
 =?us-ascii?Q?hTATMsgHwV+pqIDlqhwd2uBKQeokI88GGhSS03vX3hLdXqhEPd6UHe4RQ+nW?=
 =?us-ascii?Q?JRJJvY6HGu2Ksye+b01D4meEAXy5cxeuYuWs00xhM5djGlu3K/NSol7h9QRN?=
 =?us-ascii?Q?zlCvrslPpOcBSCcxrcwr9iE9tkg272d6Yj2BK9FxdViswwRSPmOM7HuFLKY0?=
 =?us-ascii?Q?xtMJDS9CsjPhnk/us3gySprL77OTMJFQJ8IuBKQyapoZZ6xEj5NalbVmMzhE?=
 =?us-ascii?Q?HU281aGkw6mwsP/ayJMlHu1leYAIgEqAn3tVvYE9VWv2ShDTbkxmI0PgicC8?=
 =?us-ascii?Q?Mmwh2dnLFbWwMrqGuLy1emh74IaN/rgD5WMVU8YlE2Kd/8f4/nYSPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l6o3OS/IJMY6sswa2enTZMyFvClScYeoWN3MeWDMPInNheSZfHNa2AK1H16h?=
 =?us-ascii?Q?WEBTWzLQUHW1CtxNVzoeZof6RM/NyecPRoM+yZIClYHEHuAaJ3U7B+h1M/qT?=
 =?us-ascii?Q?tjgIIjpmA5IHpDJn1qY+ZrY4BMlJjt5n11ZfoNza/efThcsRyU+Wr9ju+txK?=
 =?us-ascii?Q?ZEc1ZBr4+vjlq1yyGJdLcOYoqYDryOgQj4f7dqOft6Y6I/dBs80N+mBB8njy?=
 =?us-ascii?Q?vJvykFq4uuoXVheIdt4EMwe6NpQ+zW8OMv+u8B2FYuAHgwJvWx2l3OjfntW5?=
 =?us-ascii?Q?g/Otpa/9t86wlDIkzfsBcQ/k7H+MEcbiST7AYZh5L5ZXsFX4U7KSdjoGq3mI?=
 =?us-ascii?Q?IqWqpvhQ1KlSkTUOBo6C6WzkecTsA5GZuPCfA+eDFNJIiEy7VJ3HSm/candR?=
 =?us-ascii?Q?NEqn10KyvkeETzjZuPObOETj9ZQhlVrLhp6VmWmOjWyNQptVST7twIK85jhT?=
 =?us-ascii?Q?RBehaB3sfqXifbYPMAMJW9IT2QNiudx5OmOWajLadqWiPuyXYhVyflRPbw+d?=
 =?us-ascii?Q?/Z/05kxIEtpOtDTFfCOoYuCLlzYdWjuX2LcpbKyW8RODQsOXuNmTGt5HEzRI?=
 =?us-ascii?Q?EcbgrPfLRD86drdkGEkHPuHuPNDbMkuLsYMtyEPKVXYy2FTCbKkSPf1szanI?=
 =?us-ascii?Q?0EBucwuEVj1mNM03KYZhXQ2xIvlWDUc426DAu5i1OSxL83eAQuWVlCMjd76s?=
 =?us-ascii?Q?0s3FsYGkN+8YOiDsLziRd3qIC5qGgtaQ3VxF7nstPNUFv8lqeNFlVYzISEMu?=
 =?us-ascii?Q?uhjd6G8HBXjqhkO1CAYtJQRDD/5p/9WdTiLVKqP+hVXxTWJUgt0lF8jOXEnE?=
 =?us-ascii?Q?q/jdKgwkMLGYZaB48ECqGiyOAxw7JwZ9Uub1P1eJYPHDAX74vCQfd00MoD12?=
 =?us-ascii?Q?iD4jOURFT4iQctxP5FmUw0zqW73pLfLHfXDQybuHZMEyNK1dNWy5aOrn7mJS?=
 =?us-ascii?Q?dnK+xXambWv3np0zsgV57tKM5YkmtURStyLsWHk8ZYobo7FH/UMiviZcQcoL?=
 =?us-ascii?Q?wDqDxzYUUzmGeY4EyzLkG/6jbBKl8KLDd8LIFuNKY66ZGcWWYFo/93FtWT1b?=
 =?us-ascii?Q?sLnsUmsDY/4jSfWXwRU+UM6zAhOOh/VQupTlVkcHZ42SAX+dsUtsGypS8o72?=
 =?us-ascii?Q?m9HRD842xpyj0SP2+e9J2++jJNPFyiEtOsqJRx2kyAjZXSutdpwUxAcHPXY1?=
 =?us-ascii?Q?VeCnARLxOWZc0L0GsiL2MLYEjrJRWykPxxab+pP4Z+9qe3qYqsNEUFxijmE6?=
 =?us-ascii?Q?DwWvDFucxsdRAslGt/hcGm2gt/Vq12F6zSVpTn5tyxLuu7FZu35E7SajYrty?=
 =?us-ascii?Q?wVnBGNjMbi5/UVdIXnewYP3E09nK6cCDsDvCGsJP9bpE6t10HN6y59FDidRG?=
 =?us-ascii?Q?9yhrf68vQtybBTk5KiFedNbGUZQPW7OiGlVHZNl+zvBZpt2etgpMMz6gdbWE?=
 =?us-ascii?Q?DpA2RGJZ9aKbsLB4H3UeaWXmtWUx87DF0txDMSsPfJxI3dLOwuGHiDjo0RyF?=
 =?us-ascii?Q?KRHRI47kk9RocZaoM7iRQqAz24+jMuuXOnabGtfPulDahQm1OlbaER6cs0De?=
 =?us-ascii?Q?esNEMLmqnT+bAHWuS/IjgtCv8Vvp+QSSEfbxeHFD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de1fad-f46e-449f-2bd1-08dde6e0f703
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 09:46:44.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kJ2SFdSICODcCG58qFmEuUJzPINRmySmIISSRRJPkaPGb0xIz+TCTQI2XFhgxWkLIZhTLzqCctJTZ29r96stA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
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
> On Thu, 28 Aug 2025 10:23:05 +0000
> Ciara Loftus <ciara.loftus@intel.com> wrote:
>=20
> > Introduce the boolean restore_link_state devarg for the ice driver. Whe=
n
> > set, when the ice port is stopped, the physical link will be restored t=
o
> > the state it was in when the device was started.
> >
> > Prior to this patch the default behaviour was to always restore the lin=
k
> > to its original state. The new default behaiour is to always bring the
> > link down, which is in keeping with most other drivers.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
>=20
> Device specific devargs should be discouraged. Seems like the same
> issue occurs across multiple drivers.

I had considered creating a generic ethdev API for this rather than a
device specific devarg. However when I looked into it I wasn't sure
there would be much appetite for it, as most drivers bring the link
down on close as standard behaviour.
I'll submit that patch as RFC and if it gets traction and acceptance
we can drop this devarg.
