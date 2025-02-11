Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF89C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 14:56:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 752B5402C9;
	Tue, 11 Feb 2025 15:56:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 01DE6402C2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 15:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739285801; x=1770821801;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Uv2BVSB7SMrYOPK+ZBQUkchM4ZInb+waSUqzJvoLI3c=;
 b=ViOuthu2//Y8tXuEAjFvDJuYFED0OEY9losEMDAICHVYcZd7ZywURik8
 IMPvqCG5jF6Yn5umFkP5wPtV8eMXNLJboxEyA9OutTF1wRq6qc9E/cvw8
 fgIU5RuNw6PH9HQsNGnoWaPQVmv81tF5idYQ3LE2mmAzyP+0hjLHbFd3N
 9xfbplv3MHDevKiZHDBg/rdsxJTPoCLAwfxQKTxuWTRJimQogu3/B7EQH
 DAZAjqeGoeIX9S4hS6YlukAk1Uwe5XzUWiRlyoUarhI0xB2zCcxMLybus
 BbG3oQiTBdVdeqrfX0I3oWPWVTJ0NlwXR2d0LQ3Nk+a0aRac43dvns4o7 A==;
X-CSE-ConnectionGUID: IeYrLjxbSTmffL/8d53SNQ==
X-CSE-MsgGUID: rO0rd6IRRXuAg1JtJUNI0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="42746233"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208,217";a="42746233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 06:56:40 -0800
X-CSE-ConnectionGUID: qsn/Y7NzSmyE+ZNxs7RuAg==
X-CSE-MsgGUID: i9mGNkB4Q4K3/HZZHRTp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="117150534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 06:56:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 06:56:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 06:56:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 06:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPBMLXRUd4W/LjK53r3svAgHtcafcDOuZnSyTu3po3Jgb/oV9oBfE3c9rWsFDqiyBKlTyCaarCjWKVQdVD4YVjtDc/27LWk+W58SPGHOj8pRLujPwh5vTIMchU7aCT3MUK4vzzTffsHNpgpBISQCFidtGIubWvtWXo6dic3yhluS0VxSJE/HjL5zu8W84Hxz/8pW2BpytFzpTxf7A+1J/R95wki2MFPzALOB+BYPnH0NkNm5Z9ZEHxs3aRrP5tSqXkLy4eWmVPel6Htlcrk6+PxciXhxC8gn3/31o0kQdoy+AXHBtwpdbnQunhlV2TxvxwNQwT0WRFSbR//O6Z9ojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FblltLwHocGum2SPxUHHehBpmmO4vqcc7c1LvlY3Xqw=;
 b=MtZil81oAYoZA0MKtJp4d3ZS5Rd8KO3A44/ly8FHV9ukk9kJ6mAjvzxznlSmoUdHOO58BXeeDgYfXSpnlr0gq/Da/4Nph7Laar2MnJGyotrPfzRs7BkVALj2ea2Xb+YTZgJenkSWonK8yFotKMsmYUAl4Oifi5FTh9ciTgdRHKIuIH8BsFix4KzuZOuj9+6uEVovEFNN8Q3jmE/v+wmbZ6eddJUZThBFltvv9d7fmTCJGAZoJ4Nk2j0qZkMx/oK3G5M2uF7NmQEtmid1rZaidy+MFeTbRS7thZ1pQdoVu9eV9lPPrFdy5hRexkP+rKSZjf+nyATHdjq2/jydJ8zglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 14:56:10 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:56:10 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-02-11
Thread-Topic: DPDK Release Status Meeting 2025-02-11
Thread-Index: Adt8lPuFGewtGE1yQq6BhZqdlFzz1A==
Date: Tue, 11 Feb 2025 14:56:10 +0000
Message-ID: <PH8PR11MB68048E7988E9246DCE6D4417FCFD2@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: 31861394-2d6e-4840-35d9-08dd4aac38d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uY75+bDt5eFnBhPLNlz+jWcROKssXg6mXhEgiU0V5MNUJcHymeJiidh52uFC?=
 =?us-ascii?Q?8HE8Yg0s2oMEnZa8qUiKmmiGhwQ0im8sIE3V5WmGU9DTULCY4pZ1jN4jyRBu?=
 =?us-ascii?Q?3qcIwRQkwRXAoKz1AaOjUq7jjexoliZDzKMl7zgweegbM94pVWUdkyhZ4ghd?=
 =?us-ascii?Q?7pPLZlrpS3TIoGs3rNMJEGMoOUWpQ9bQPeN09XH9HW31aQPUCqfaWpF8RYc9?=
 =?us-ascii?Q?t/bSvasApWU9a5jl3/Kv2m2uOLvt6fHnTrc8tAMCIpe2TKSvDW2XGNG/kg8M?=
 =?us-ascii?Q?lmvyickop96x4RU2JVh74Hlpq8Gj4GOkefpROnmXV8QW7zZPD+IUuGojCj07?=
 =?us-ascii?Q?tNApavgX4BEd/4q7YZ46SqSxiiPpFwLCAQh6JvlkJ3oV0KdkM/Jgr5Cqjpdz?=
 =?us-ascii?Q?QIKCRuioCY54VwK2iWiitwLNUcnrQepzb3sZFavM7cM61AoPHeb7SaVADQVc?=
 =?us-ascii?Q?rIcty6ipLo3cmSg/mHfuSxMhp9gA0QqwCFY0Q/o2e31Zfoj/wQdm3IpDsRy5?=
 =?us-ascii?Q?ZgyJwi8SKbIXG5GEoSiZAcQ4BE8mjvcs0ES0RBUPniP3H2D3P9y6uFQaEriz?=
 =?us-ascii?Q?5Gu67a4tKWCgZrMzN8EefCGO41ZF9QckH+dQBiEXeTNWwQ2OkHg9LCgAFX3t?=
 =?us-ascii?Q?iIcX7D/VMP50KPVdL8UbhJichL+QefN1x2dczGXbaoAKMVZjkF7ixLSk2fOp?=
 =?us-ascii?Q?i8kBT5FmRmBCf/xoKqGdveC6hZLb22G5QCz9hy+J0+7Y4Q4NzatIJTJUCWPG?=
 =?us-ascii?Q?umtBm0Wb7TV3ZpdvohvhtnBWHCZcPQEfmVybw43OAa/ScBeGa+i9PfwZEPjM?=
 =?us-ascii?Q?7AB8Vwy0J2UwFC9+xUkNd8HUPZGV/87NThdzto/30yB+C+ieFE0zo8GJxq5p?=
 =?us-ascii?Q?jqjhs+7vAijbkiJYt7QHgyi3c4siWdH7/G96R+RpIycD31mq2u3VBR9w8Auf?=
 =?us-ascii?Q?g3GqFoc9IR3P8unlBnVOm2HiXmIjE+n347M8VA3KhUDNsT3zYHzb/gzjvFb7?=
 =?us-ascii?Q?qW/CxBwxC/K6mM4isgvrboD+kos9oB77/kpJUyzhfX8UzYNAECbK+vMm7HKB?=
 =?us-ascii?Q?zwJkeVp3E0m8hjoRw/aajzK1v7H9WUJy3L0wF+HCjNIbRm2JE4Eo0xelmgiI?=
 =?us-ascii?Q?jDyxfmGN+tujaVg8qncvKbCAwnXiuNYeVGVY9GNCgg4g7B9ysJ2he9z9QLZe?=
 =?us-ascii?Q?6Gg0kI3z51bazHNdBHbtf6DNgcBCqLk8b74KXeL1E0fD1ICbnkQIM4HlXgT6?=
 =?us-ascii?Q?bWVCfkqLMCwLdkUy2a/UB7M358pjXyn4eqfOyb6qRh+p7guFDyIvcpco07C+?=
 =?us-ascii?Q?EqwiT5tiVmGmKrAHwAEjqYYIt9l6hZX5sP5hkprbPg7A+qEA+YdvjZTbY9+N?=
 =?us-ascii?Q?SqF+lgD3tfbDqSVB3vhCadzIMKOITulu/uO2/xtgKtxPor5wog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5iqVXnFE7mKBKwp8MT/ZIweAvlQj++2dYoNkUVXMTgS0LmqRvuCm2JzeRdLC?=
 =?us-ascii?Q?BjjEEv2nqOmcgMC6zaMqT5OOKCAJSZVfmQDbWcAs9Ty6e2Wnn3EZoug1obWC?=
 =?us-ascii?Q?vR5rXaF6cWWF/GQ+aC8fmXOa+S49usRhnVo4n/AiEiOR6+/XHUDzRYvocAX+?=
 =?us-ascii?Q?tQTaURrhSM2Knq225mrE81FS109CzfbLOzQVCVpMaEhbgmPFGTuY0f6e4nBw?=
 =?us-ascii?Q?Kta9Fut5rINITMvJJhJcZdSJTHfUOnh1pqDK+AZ73jtaQIjCW+nghX241uUI?=
 =?us-ascii?Q?sTScVbz8oCW5CIBg8/rUZ5D9HyUTHdgzCKUwFXVJpL/8tExUiXwfPi6kw6QD?=
 =?us-ascii?Q?eJ0QdNlm+14cFdyY2oUTB5/w7BP6lM+HH4oEwt3m+AMvRywjOQUC40m+kRDa?=
 =?us-ascii?Q?muKePdnYuTgRh3ptG7C1t2CQTReX+ZBNRkuyokgPTZU0vW78upHV4lZy6vSl?=
 =?us-ascii?Q?XmWQnB/4wFDfnSYQNiR/I88Q0IT09L8dUPkQZfhC0w5KI2Uu5JrERw2EOZnA?=
 =?us-ascii?Q?aAwNDUK6z8BEaYolu5ISySyt2AtVJj6C6VXDWhsTBAGsz6ZO99D2h8lWl5MG?=
 =?us-ascii?Q?VYiW3t4LVRS7Z3/r5iKLuhLqg3DZUik1MbBuh4guUc0vUwwgXptalzzr/Q1V?=
 =?us-ascii?Q?/qeZaUjx30CcX13xajcvJrgGYi3pr1rB2f8+wFW7NdzWsZly9kxTaO6bVXCa?=
 =?us-ascii?Q?Hs90mwwwN2X2L1RnqfhrPQUePuhHkiy3sKYuMSLVPAAoqQ+oZetcVUxX6SAY?=
 =?us-ascii?Q?IcrWYIzWK1yFOST8Dg28x/cUpztxH2dOT/RMrImsXKS3roN77F7hFnJLyhS8?=
 =?us-ascii?Q?Gmo0RAyZMjYH5+6EpPsFeNtQlP/t2Z1r8Vdgrk+raXQj3fXGM6CDRbmJjAhE?=
 =?us-ascii?Q?S354pSc2N2k19S7aBX6kvjs09s21RPiHeSi8B5oj4cHA7oKd3hqGnrqEVGrG?=
 =?us-ascii?Q?oJbjo1O/AnQA1Ybsn+2vGApucvwhfJn2yJhc1DwA5FltzfeS+XWGj/W+Ctum?=
 =?us-ascii?Q?0VK9C8RCJKWBFXmfDccC6KfpN1STaUkrfTgF3x3gaIy6TBnVUXVTogmw2euR?=
 =?us-ascii?Q?96aUtNd0I0AWt+85amFdUv0ljYrgk/lu0q0H2vHfX4cOV0GT08kqjZkEUR9H?=
 =?us-ascii?Q?6raGIbvohyK1ogDM5lZiYBCqmOl35F0AImYzzeZse9YBosZEr8XNcG/c0XDg?=
 =?us-ascii?Q?+jmTQoFV+7fcLdnflRnmw/HVaHuNFT2yE0aiEZf99y4BOGAWxS7hp6eh7nE5?=
 =?us-ascii?Q?AeUOZzmqJ3lxt7V3mkH28T1+EcDWCji2j04hJLcVmQQcAUE8IgYJBtVqpckr?=
 =?us-ascii?Q?hjVsoW+zuWMHwhVDJYktccslePd66pFuFgeBhl7tg0zmm2avOd/5IdYSFsDg?=
 =?us-ascii?Q?ZYT5oFgHgErtOPASVgv5qV8InPjrpMb1LjuWjPDfe0Gt1NqIOMlt7QZFVOEZ?=
 =?us-ascii?Q?oF6AAKsZjpbIFS/X2QqnOOgI5qQ1ejYVq/ms7ZW2lTIFc7rIH9o7cLeKM2oF?=
 =?us-ascii?Q?wALnI2F7egCueciQbUDgPRwubRJJgNKEqRpaETOGVziKUoldMgESNzKU18ZF?=
 =?us-ascii?Q?3TnIf1jaGfq4rTo7PJKGL0MWcZpfpalrSLPVbJaA?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB68048E7988E9246DCE6D4417FCFD2PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31861394-2d6e-4840-35d9-08dd4aac38d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 14:56:10.4566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDnST7+HYdrYfuZOy2YoxnXsnFQMU0/K184dTSfdhS9uOTI2J3R7d5ztOXYUn1evCWru9kgxOsDSp6xY78wWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
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

--_000_PH8PR11MB68048E7988E9246DCE6D4417FCFD2PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-02-11
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* Broadcom
* ARM
* Intel
* Marvell
* Microsoft
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.03:

- Proposal deadline (RFC/v1 patches): 4 January 2025
- API freeze (-rc1): 7 February 2025 - Trending to 12 February
- PMD features freeze (-rc2): 28 February 2025
- Builtin applications features freeze (-rc3): 7 March 2025
- Release: 26 March 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 3 patches pending
  * Some drivers under review
  * 29 patches under reviewing

* next-net-intel
  * Mainly done for RC1
  * ~ 5 patches remaining/in progress.

* next-net-broadcom
  * 9 patches submitted and merged

* next-net-mlx
  * 12 patches merged and awaiting pull

* next-net-mvl
  * 32 patches. Will target RC2.

* next-eventdev
  * 3 patches awaiting review from Intel

* next-baseband
  * 1 series under review.
  * Merging in RC2

* next-virtio
  * PR submitted

* next-crypto
  * Most patches merged
  * 1 PMD ready
  * Series with ZTE driver

* next-dts
  * Issue with Python 3.13 is fixed
  * Mainly new tests pending

* main
  * Merged:
    * VLA patchset for Windows
    * Annotations on locks
    * Memory allocators
  * Fix for GCC 15 zero padding issue
  * RC1 to close 12 Feb


Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


LTS
---

Backporting in progress.

Current LTS versions:

* 24.11.2
* 23.11.3
* 22.11.7

See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 24.04 contains DPDK v23.11
  * Ubuntu 23.04 contains DPDK v22.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara john.mcnamara@intel.com" for the invite.

--_000_PH8PR11MB68048E7988E9246DCE6D4417FCFD2PH8PR11MB6804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-02-11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Microsoft<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 4 January 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 7 February 2025 &#8211; Trending to 12 February<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 28 February 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 7 March 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 M=
arch 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 patc=
hes pending<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some d=
rivers under review<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 29 pat=
ches under reviewing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mainly=
 done for RC1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~ 5 pa=
tches remaining/in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 9 patc=
hes submitted and merged<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 12 pat=
ches merged and awaiting pull<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 32 pat=
ches. Will target RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 patc=
hes awaiting review from Intel<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mergin=
g in RC2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sub=
mitted<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Most p=
atches merged<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 PMD =
ready<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Series=
 with ZTE driver<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Issue =
with Python 3.13 is fixed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mainly=
 new tests pending<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; * VLA patchset for Windows<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; * Annotations on locks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; * Memory allocators<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Fix fo=
r GCC 15 zero padding issue<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 to=
 close 12 Feb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - DPDK S=
ummit 2025 will be in Prague in May:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://events.linuxfoundation.org/dpdk-summit/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://www.dpdk.org/event/dpdk-summit-2025-prague/<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Backporting in =
progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Current LTS ver=
sions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.3<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.7<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 23.04 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara john.mcnamara@intel.com&quot; for the invite.<o:p></o=
:p></span></p>
</div>
</body>
</html>

--_000_PH8PR11MB68048E7988E9246DCE6D4417FCFD2PH8PR11MB6804namp_--
