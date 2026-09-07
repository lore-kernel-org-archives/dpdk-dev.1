Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C5C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 11:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D1CA40658;
	Mon,  7 Sep 2026 13:16:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 11AE540041;
 Mon,  7 Sep 2026 13:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779806; x=1820315806;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VTqaMVhCCbH3jvVA97wgHb+JCKvtDO3nmFYX4zboLtY=;
 b=h/iIXuZ5VjdzwPpOJ1SPvFhukt4GOjgNUGF9jRZUYMadxqty8fd71x3/
 9W+/FqxhzY6NFWaeI3woDUmQ2P90Vu1lZpplI5rfN5zvzIqrt8ofzF34P
 Ql+5roC3TY8Y5PgGek7+OEibJ9qqjSOtOxkHbIUNck7xyIlzKz1TM14nF
 oBBombjbux3zeKBilR9CmGJguQyQEriobY9WqLKnlbP6y28Y4rY/gLI4i
 2LeZBQNEbTsE3a8nVqG00DoZssHklFx+tz61eriHWaBV0TDGQ1kEmzlZC
 TzSvC+KhpPayO7QPmY9AUE3oDCUb1ScbpovWmYc1c8R13q8/ykajfU2sK Q==;
X-CSE-ConnectionGUID: Up2wCr9KT1O30BpfnWkLRg==
X-CSE-MsgGUID: g3TSth/xR1Wd+PniCzbZYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89026191"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89026191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:16:45 -0700
X-CSE-ConnectionGUID: o95JhVs4TPm9QgSkLmsNNA==
X-CSE-MsgGUID: OIvzN+FUQCmuBQ/zn2pQyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="271198646"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:16:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 04:16:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 04:16:44 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 04:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdXFbgvJ7pyGgzMJtp+nu8EEjjwpigaKgh/IeyWQAhDgeQ5qGXV/D9nbNVBQTTDNDG6XLtX21wEaT0ze+BY7PF+dWPl1lkXaukkYFjLVhGK7VadM/3afkzEkfrBWFBCBykuSMYkPuWuS25oBLIW6y9yZOqUIYS2ITpVUh3V/dKsGiDM2ljJhfcxI/V3ReklI0iJHTUHCMQw2zvQmz958vliizpxa3RDHL204mfVtVh9NmT054r42GoxMCiQ8UNwbfDR5IkIZaKag0yCwmdoxoKzuApif5ytr0m+m4WHn7MNQDRP/wcDgsHoA9ajqnHP3bMCQTR5Lve3ODzhGDdBdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTqaMVhCCbH3jvVA97wgHb+JCKvtDO3nmFYX4zboLtY=;
 b=r+mCPu3j6B2wLXx0xQNEglsA9It/b0J6xOFAcsSp1x5Yo93OIJgOYIfHH5XNSJ6ob34O8i5llGAGTC7LkScD01/08iYF3KS0ZzeI9/Rase3FOenyxgS5W4m+7DBgR2b5uNYcCisN3vBbfvTi7jat/IqYpZwN7RxxiqYMdC3jrvxF8+tbSsKhlPuq3NPDK2A2zfDjT8SObXxTksc4otCu2Jfxi3D/gBCohPyREuIMfbYjNF6nL3QP/VY7NIwSuK7JPuSGZJAatkjnkrk9K1sAUn0pdG5IkGhU6Na51QvPoCpZ+O9XVRZYi4hyxbhXkHbvZUdRqIfmIib2EEvrjgaQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 11:16:41 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 11:16:41 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 3/3] net/ice: fix Rx queue count reporting after TM commit
Thread-Topic: [PATCH 3/3] net/ice: fix Rx queue count reporting after TM commit
Thread-Index: AQHdPFuAVfGB1p1vPkeP6d4tQsno+ba+a1uAgASQFWA=
Date: Mon, 7 Sep 2026 11:16:41 +0000
Message-ID: <IA4PR11MB92785666CFC3CA26A8B637B48EB22@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260904105139.3117640-4-ciara.loftus@intel.com>
 <aprIxQgs8bEhcO7R@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aprIxQgs8bEhcO7R@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CO1PR11MB4916:EE_
x-ms-office365-filtering-correlation-id: 919e2b2d-b93a-49c6-9ace-08df0cd17e21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: K84e+b3NySmYdaduuKp/mI9KlUJu0lb8FtkWfQzCUSHn6hYVCt3jxsvbXWo90+qnP/iTbdYzaqSLi8+TJgVWnW1fZOnF6vpSE/HDXnSC1fdJQSUFvUHVhESxuikVagWEA/siLHVxL9anDws5kh3UC2WBYXZW759Lkc801b2mLYf0OTBHd9UaUTDmGY7UttE0yMtdBfbwK147XktZwhAmGaUX2GZRHlfLQ79DoKMMxpJqC5errjtsU3Of784M/Wj51N9DVEHJHGSdP0tv1fkObS4HG9wbfXBgAweyEtbySSKjZBMhAYmlqiwa7OrkGUqrC1SpkvZpKRsInXjrUn253SIP38yRDy0Bkw+V9eSyopdHqJmqs+XhUExfwDo9Mdg/z0351qnYWSsVzm7jkKqTltDCmzS2QZkHzNVawMRstQUxbtJZLDOwKSfbME7AOdlorgeIH3N8IQL4BrDZCPJgwGtqpYN6vMriX2uWh6n1ek71vfyJnuG7b3SaQZKlzQSkaFZE/iFC1p0aSyZIYFRhyV9kknSB2cy7RbtvpHNNOcs9rfIjcm/6FEM/pxmxwa+2rFBGzQhdsPzpzgztAyb0/UhAYpvMKmgs8UoPoiFN3wY0r8iRzHGK2bb6ayd4aM74QsFiwr8N04W0JOXrb1U95N/C6VdjWPPcZfIMTOS0qt6Hi5oD4bV64WBflXPFey1vr25XwI7cuan9iq/KsGRbhWYKnOVImC49PHs3RyAofBA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r/IdGyt9Vu+7AdsH77nDEMI/8CWH9R3iv5siU1Xuer7D40pEfmxV62NQQ0xq?=
 =?us-ascii?Q?pyW/gtutMb2JyXZIw4Zlr5pCmoTjJkHLsnIpi25muOW2iRI0gWIyOniKmqLY?=
 =?us-ascii?Q?Q1kbRZ7ZaKP+uYpNxiQIQz20DxgOUuJC4/jKok7W92JXHjK/SW9Uw2gf4K1q?=
 =?us-ascii?Q?ud/qt42DR6gfjEnv2cLI/mIaQpmxGzPYzg1J+JVcR6Kb3PbYBXzYe1dLJB6n?=
 =?us-ascii?Q?xm70wlKDUvNTs6jzHc3xKwbDQ6V4iQS18GKV64Nj5MKeMi23XJ1KXYhqQxze?=
 =?us-ascii?Q?y/MKJYFNfEc90ZKZE9QyIPgljOR2hq7mAQQAduaFW7kqsPpfRmwuHMMCBt4l?=
 =?us-ascii?Q?AKvFi4H/zwvKewNcpCHmfsaS9+haVinKAZ0H/SGgECQCtzrE60sTKIWYSyQ/?=
 =?us-ascii?Q?cs7wLPf3RAx/eEyhjP7aF/fSIrJPyE/GF5FxSF8ubJTknl1Xgw9Lr37YDG04?=
 =?us-ascii?Q?Rye01jgyJleigf7Hf0SFWhIEtJyGwHO+Cap7lZ78hVpVcKGuTdcy1bFY1xyY?=
 =?us-ascii?Q?6T6yFERyl8GCY8Na7XcFRDDL1yAKH6l2pEnmLC73l0Qwu5t2nxNuTSNw0kOE?=
 =?us-ascii?Q?h4EhUot9jRAf5+quGphIrnGFq8c/82N6YNylHxxgn6MlzmtjFfps2iwUm7Yu?=
 =?us-ascii?Q?FUob6QltkSqIiREkEmOBm//PW9zCXsJU4sUYcm6497EnskDM2kh9hZiYCFGl?=
 =?us-ascii?Q?yFxADNQAd5czOvKzoANx/LiAZglWCk+aTH35ld/WynPLksmJaMBkliix7P6J?=
 =?us-ascii?Q?VwFU1V4pqYagnFWHC57z83Pit/CcZowpPzaXWYz98R67YcCKx6nfvUZRY+qA?=
 =?us-ascii?Q?zVqK+NUSsFosSh/NR5/MuJo9hhJosgBs3rVAIilsU5Pto32eVm6heOIRm99Z?=
 =?us-ascii?Q?a3B6jhVBjk4rJsTwGovY5mVqyXdzwu/rKTKlu5MdDWhf8SpTitiqy/Iqm22f?=
 =?us-ascii?Q?nEihYFXzITLBAqPrV3hm7Xhtd1hHRoMrREf2uxB5s6q/LsDTxJFlXRqKYukA?=
 =?us-ascii?Q?wCQ39IdDfMaYzk1OpnaxHSJvHJ5Peb2zRApm9UQBg6QJqam2TGBfeg1IQ8JR?=
 =?us-ascii?Q?DhagaHvc8lkdUWYy/OHoqIO8Udz22C/hzOzV1cmGwKmsVJMuLzh82d6TEhu3?=
 =?us-ascii?Q?rbX5EagPVS3sjq0+DGz2U82q+l+RFq02XSAR3nI8QN0hCdhOtCHe9hVmb7W8?=
 =?us-ascii?Q?8MWw/XGhK/qqYGmicQCjsKHIX1Y0r5dh8AobZSO0qDMkyJdByJ94lpo/CaK2?=
 =?us-ascii?Q?Xo9yXbN9Bp1Oxd+KkIwfMq3FkskxaSY/Sq5lsrHs8sDtr4qDvW2+Lfe1F+BY?=
 =?us-ascii?Q?WCu/s8KMB6IkblSc2+2MdVmlYZf308iZKidIYvN0rLiOr3NOFumqiXNXNSjC?=
 =?us-ascii?Q?X5KzCEtZ2qhuCiusCQmbipCZF7UAs/jZNWGf0d3J+nr3/v8WG494cc2AnJkR?=
 =?us-ascii?Q?5sjp1kHkCWrdXgOBdnKmAw+32jujcCmI425ODOUA0vywWSGQdOZVvHlebb5d?=
 =?us-ascii?Q?4P1zkAKpd2CZnS5EocHVzpotioawnyfZvLRkYTUXOpsEvlUTRwR+DdHNUhJS?=
 =?us-ascii?Q?62pBIxqgfh8oslpebYV4b0Y6tIAq2+4P11Cb2kcPSmWbMjdKEIlOr6N7+WG1?=
 =?us-ascii?Q?PQrKGCskYNgZItlEGnJdFT7oOg7GtPGZAMrmbBCt5cEZcZQuV28ykuzIeoyg?=
 =?us-ascii?Q?winiUyYpLGcJp7J5SL+cwxMDzv4SvLsZKieslDiS5EfwVxq4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S0V6Wv5atHYgJMi6mTa1x9azs1rYJAoepi+83y531hlHsYym2wAQWtAH9EzsWo7BJzf0cj4Lv06TwHw5xbweMwpf7wggEuSIfNgY+BpGAgpYcDAVrO3Ygwi6aTRRDTV/wVRRS+Pm+qu99l+ZyloPgIrjGABtoN3BP1YowpEvHDly2AvtIf/Vatb+hiR+Yal14n+y4DUyE3wxpUMvlkdsQpmPuDZvepH4bvUIybhnbvdcq1HRYFi3+7+LOnK/wzmIapHG9nkd5lD/IYv7jkUH32SgNNzyVq8mk2BYvNzwwRGtndk3Es5ollK9jS9gRFevBmJX2AlhW9uevg7e5f0CnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919e2b2d-b93a-49c6-9ace-08df0cd17e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 11:16:41.3272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPHv5hSJldGpYseI3zaG8HmeVdHu1cz2n+BFuCYXH4sIBGSRhAoAECO0A8qUBTA87JhwQYWIlL2HysbOr7Xx5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
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

> Subject: Re: [PATCH 3/3] net/ice: fix Rx queue count reporting after TM
> commit
>=20
> On Fri, Sep 04, 2026 at 10:51:39AM +0000, Ciara Loftus wrote:
> > Currently, ice_dev_info_get() assigns the value of `vsi->nb_qps` to bot=
h
> > `max_rx_queues` and `max_tx_queues`.
> >
> > After a Tx scheduler hierarchy is committed, the value of nb_qps may gr=
ow
> > to reflect the VSI's larger Tx scheduler capacity. However the Tx sched=
uler
> > hierarchy change has no effect on the VSI's Rx queue allocation,
> > which stays fixed at its original size for the life of the port. An
> > application can then request more Rx queues than the VSI's actual Rx
> > resources support when the inflated nb_qps is assigned to `max_rx_queue=
s`.
> >
> > `vsi->nb_qps` also feeds `ice_vsi_disable_queues_intr()`, which clears
> > both Rx and Tx queue interrupt registers by absolute queue index on
> > every port stop. Once `nb_qps` grows past the VSI's fixed queue window,
> > this can clear interrupt registers belonging to a different VSI.
> >
> > Fix this by introducing `vsi->nb_tm_qps` to track the Tx scheduler
>=20
> Just a nit on naming here. For the tm block it doesn't deal with
> queue-pairs so much as Tx queues, so the variable should probably be name=
d
> nb_tm_txqs instead.

+1

>=20
> However, that opens a wider renaming question - rather than tracking a
> generic nb_qps and nb_tm_qps(nb_tm_txqs), might it be better to have vsi
> variables separately called "nb_rxqs" and "nb_txqs" and ignore the whole
> "tm" part of it?

I think that makes sense. I'll add that change as a fourth patch and you ca=
n
see what you think. nb_qps is used in a few different places in the driver,
mostly on init paths, so there is a little bit of churn.

>=20
> > capacity as it grows, leaving `vsi->nb_qps` as the VSI's fixed
> > queue allocation for the life of the port. `ice_vsi_disable_queues_intr=
()`
> > is switched to `nb_used_qps`, which already tracks the actually configu=
red
> > queue count.
> >

