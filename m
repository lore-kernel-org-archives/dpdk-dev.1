Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C790CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCEBC402CE;
	Tue, 14 Oct 2025 16:34:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4DF89402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 16:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452493; x=1791988493;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=O4Ybdk7rhG3pbmJvViduGX0UIhjg7IzBR2WgNbpqp+g=;
 b=UzvYAwRbyD7EOhHhUWkMGFcBcAM3DkTrOIH9T7Vbw3H7uXcmrKn/sUHJ
 VsXbie6YNbnRlG0nHbh3KeRk3JUo7uer13zaYTM05djZlUFN+svNOgXoL
 IZBc9wmC2csqeQDDljDZGCpRMt5E1RewIuRbqD2w8GRP+5LcntwsjW9UM
 /qbWdpcqzbqCXn8zKZX834elsVRsbadl2bSQN+rxZMCcB1xpfatGMAoi5
 h/3bvdyiF2Zqv1BavOADC6YC2MDiy0X/QHlnWDxxUqgPAkZNLDsARoS0A
 d9qypWSZCihLZDApMEksABlpHkfKPYV5+w3t79EJykGObJt44lg8okGA/ g==;
X-CSE-ConnectionGUID: x8BpuSFETyipLpkhCK2fEQ==
X-CSE-MsgGUID: zerWVuKOS3SxTvZR3cW4Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62656142"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208,217";a="62656142"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:34:51 -0700
X-CSE-ConnectionGUID: l0NTIsLsSoCiS+dS6zLRYQ==
X-CSE-MsgGUID: ytDHcxfuRuurfw5zM26nzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
 d="scan'208,217";a="219041855"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:34:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:34:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:34:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go/ub6RQhQD3kIP7TMQ/zi7oBtk+/Ny7Nz8k8L4UujSqkmSGtq/nOoSM4txrzVTCIv4q6xo3m/qs/7yHym4PXjae1kilcrbfgYJ7S2UqHz4ZPYw8hnXRt09rrsXbvlo1B6tQyCUwPV5vtpP9vHb7tpKhFAiJnjuxlImkW0R3aeqCBdot5b6sSbfv3Ui+TODM+eP7SoHFzVdUDjX/WPRMpokv9lOBUUTTxKhpK5JRNeOv6F4TtRePthpa3FYBOY2cXAUCbLMwoBprCaFEMkVlHZj0RIaWM0F8yeMPqmGBPalx/U6rGd53uCytn17e6XHXDxOMVUln/yvORvrClAOYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08i3U1rhyTs/gBV4SDVq0BBzKwMYTfamFyZ06S1BduM=;
 b=YGF+b8XlX8w2Wfd4SXv+oZzLfJGCcC3XJYIgw945oHJFo1aqlG2aFPiaesLWQjrCzNQmM+FnJQWBWg+asfEMnidaQP15OqivmL/kVdHpmd0Szoy0IFm8Mt5BZcR1Z6jus2s9qqRZ8SgjXmiz3okvgs4OWwNfKJlrkhFqv/wjvHFmlpRQyrSW2LLPiC0zPZ2KjMJOb+QZWroNthMyuf/Rl6aZNhfDCwYPQ80YqhDa32d84mqHrw06yOjwIGCxUFzpXMuwAsxpNxB7JnPpO8OcLE2uv83q+/T15IqYaaQlAnXbAAkIPXtNbTuQsy/Pn5rtSUFOjgIGaSDkM0gWkr198A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA1PR11MB8173.namprd11.prod.outlook.com
 (2603:10b6:208:44e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:34:41 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:34:41 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-10-14
Thread-Topic: DPDK Release Status Meeting 2025-10-14
Thread-Index: Adw9F5liaQJ7BjhpT3aFv+b1dlL9FQ==
Date: Tue, 14 Oct 2025 14:34:41 +0000
Message-ID: <PH3PPF37F43E35DE215A689A4BDF14CF260FCEBA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: 1d6ed08b-e6c2-4e10-65f2-08de0b2ecfc3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tpFlACRnTe00b92xCjiWLd1dzLAo4tPhr7Derwjh8bNIzCktaH9KxmOfRoBr?=
 =?us-ascii?Q?tgSPBmhZLfifMU0ssIiXDBFAOzB4ZJpdFWhZNZRrpqKSmZXAK7DZ1qFSebfE?=
 =?us-ascii?Q?MF+jzhAsUlWu4QH0kgBat8T+PWY1AyQqFvnUvrjGvlGK/x0ZJDDZan68dXZI?=
 =?us-ascii?Q?BGC9xx4kDIjpQ9myVi3d1yiIUJOOoaKgHgJNcURIezZeEpo6Pz3bx7cPUGyu?=
 =?us-ascii?Q?fmMcaSfuO6WMnSLm7ogWjnZlUKELUS8S1+BI86HFysjhwovAjvyMCiD99Bp9?=
 =?us-ascii?Q?c0StEV/QLkkE5q0ngpK9yAiP+lK9fVbWvc03yKiZDPq/aBp63c8yYXKbt0D2?=
 =?us-ascii?Q?FvthdJB9MCoDYuD3Lii8I+iXXchqhj0ZRQS095mDSH1x4NM52qJ5Pb/8jzKA?=
 =?us-ascii?Q?qfPKfVFVFFpWeIU4vpF9fXYhuC7yjmnTahPtIFGd3ezEENEGPYn98Ndw/Nga?=
 =?us-ascii?Q?QiU0cMKIxS/ZfnkFqueQruXRl/evOcwzCnweOrTNbZLaRwD4vlfwxDqx93XM?=
 =?us-ascii?Q?7fdbdRLlJTVht4ZfnMXVvliMmbu3Y3qeayRY/rOajY40CZHsDwdwEs69t1Cq?=
 =?us-ascii?Q?1I79Sk2Vt2FvJ5ZMHGp2YsfMHNBy0XdqBttz0S/Z0Vi8Xy5v1C3cyJB42unN?=
 =?us-ascii?Q?FMv2zo8Do42BR7lp76CstRLTihE9W+jTSxdUcoqN+zrUvbcSxbxAk59oZnde?=
 =?us-ascii?Q?U9MN4vbWo+uRHnzzw6jm/RIrmF4r19Vv0jEb5SfFfvi0NcItBIb60PySz6Qe?=
 =?us-ascii?Q?Ty0Eas/OMX//3qKuzX+0iuUUqgdx/4vgwp0VL2FN61tGe9fOK9yfVmuNyPzh?=
 =?us-ascii?Q?wkdAjjhHRUh2J81our8QqqkjoQ/qjEUOk/IGE1nK77U4nnIAILFfKB0STFYM?=
 =?us-ascii?Q?eSaROJcnv8h3Th3bksHDc7B8K7lQ3GpchZ8ZLAuJQq3F4zsCJiM7FuxJRe0k?=
 =?us-ascii?Q?iRRgpCByEgbMTCQSt4pne871hN6+yYQo+8o/5iRirF/tIU1cZ2TAvs6QUqmJ?=
 =?us-ascii?Q?7u5CAAJSKzIXcM/UUOHBQnJ2FF0zEqHYXDDWknHENHxXgN6RSwJlVm9tNPwM?=
 =?us-ascii?Q?hb5/f5UnyYs2oIBy2XWsTALXGmikT44BHL9BKwoxG+rT1FdXKdmp0VESUlXw?=
 =?us-ascii?Q?QHfwN2a3/+wnDilpop+zx2DhWpM4I0M4zYnZbodIFgeh71moZb4U/z/Z7Olx?=
 =?us-ascii?Q?xsInRm/JzY6Fvh5lJvUWU7vFtC05MFQpT5wW8bLm62D3er/gkERJLuUcC80t?=
 =?us-ascii?Q?DuVl9IE+V9LbpO+cnGHVY+BuUFeffkpoj2Hs1nvL3qTWfb5FMhTia8pe7QxW?=
 =?us-ascii?Q?K4c/1SQfQFUsLFEIYslk+v11OKhwSWs0VbJM5KTT71ZnGFcvKHuK520Fbcm/?=
 =?us-ascii?Q?03yqOxXybC/vBU4JdKbzp83Pyfmqsuofs+gPph3TvFCbrIouEGzJOSH3rHd3?=
 =?us-ascii?Q?YwCzQwJ5JRjf79eUEsRzc0T3zkdKHE2soN5DEXSSuW6e3pzT438SoA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHhzdcJEd90HalcOWQYAdXbwi03roE2fLBa2IAGyzgd3EJ87Mu03q2DZ2qWb?=
 =?us-ascii?Q?vxz+DqSXl4Y1MJUe/QALgHaOXk0EPjUWmZer9zRBekYOuFy6ZrQLwsPySLbV?=
 =?us-ascii?Q?fTjUkHvFaYK+CeHkMTFifEXbsUjaYgOhlO8JQNnQzSk98SPzYg0HCt87Akt4?=
 =?us-ascii?Q?iWL7Dvyo3Sei5S+CLrCfP8Xc5Ii4QApGOTfj6yBJ21R5FB1EjURyygjgEHAR?=
 =?us-ascii?Q?F07ILPEWKk4Yh34HDVnYBj3f0GrBpkSPLGbh6wQYJ+81um2TiGrFZ27THE8C?=
 =?us-ascii?Q?pCeWMidhtGFZBLbCTWYoTkOogranHjvol/q6+rPMXSTbx/EqQ4uFaHmRSIKF?=
 =?us-ascii?Q?vend8LcLXa8cubawG9Y17uM7bPzr53gIongTDlNTFaO09VjyZO0kQp/0oTG4?=
 =?us-ascii?Q?YMNpo/qRIMQn6EOJ7ZzgrDj/rKelEEwdAnNMoS6fEREu6gMShxkKswv7bZ/d?=
 =?us-ascii?Q?iuE0PDzgleniE9q1mj+btODz5/lZT22F8zPt3yy96U5t3D8EZwBxx9dYMzBj?=
 =?us-ascii?Q?oKwg+12Ejaq/8gaw0CfT4CTp2UUsVR6j/r5Ghf5kQOFH+G5FuwXTy+kubE2h?=
 =?us-ascii?Q?YArM8+trpqPgwu63WqY39ya8owaf1KsQAxDRpwzc/aBAf1UeVVnseICTIYo9?=
 =?us-ascii?Q?/fNwY01WQT0HxiYf/9OvHUAUSTZngezI+ghUeOa4SulHfvZyT6/cnPlbosYg?=
 =?us-ascii?Q?Rlw6uk+TDobX1ZWA5Mv4u1V9ZMK4XbmndeKrV3x8teX03K0ev/o3x7UZpeH2?=
 =?us-ascii?Q?n4ITan7CbuM0q/Qlz/2D1S99Ik8fcYRg6bt9UYCHGXamFqd0TummWeS5RMtF?=
 =?us-ascii?Q?eY0Bj5FD2gE5b1X0ZGpjaIKWzxyy+M698b/jF3tJPfCZnZ7OwMyueI7DZ58c?=
 =?us-ascii?Q?n2tHRDv+7mHuwl73EvQdI0tAq8mALNncnWM82HW6A5IuH/AAkzwA4O8B2oX8?=
 =?us-ascii?Q?CG0/uBN6KyHHor203HwHlLMcS9NcY5N9T3/Fbf2zfxZXw9LBFiCXcrFIWdUz?=
 =?us-ascii?Q?6qKErMGJymCPaDO3u9P0RgZn0lVkj4IBut60i+kY1fAgSuSMwztN+V7pMfOC?=
 =?us-ascii?Q?0pQYneBmRHV1vBX4cFVIe6ZU5vIFMcD1WMLg8Csg5K/B/q7RmP5WvTzuLbEk?=
 =?us-ascii?Q?9vBQ+4feKA5kykAk4KGAWjz7HginEdZ5mzpWtGP/sD0cTCH8/HvltlgUmCQ7?=
 =?us-ascii?Q?csBnjqXmh6KzXIK32PjBG5zB56XY/vTaODRuAJW+SZo/1ocbleRtQP5lNBkj?=
 =?us-ascii?Q?Zjl5WTJMA5VLAgrf0KYcWfmmZI4tkraaouQXd2GmMgCRQVQmdIogR3sd/xK2?=
 =?us-ascii?Q?ZVIUskQECxRGcek3Lu8FM4l9jziCGhkM98FZsBXlNLzfjxzZglpvVP037OEb?=
 =?us-ascii?Q?V/Zx3NAkIkbCiAHIGARGWEXOf81ukTO3ZH464YlJ1IaDhJWk65Zwdz1Xfa/I?=
 =?us-ascii?Q?XraqvJpsulQGt5nIGF603v8SuS5sN4KGqwmLkYZ/RgyuLH17evPg2HCafBMf?=
 =?us-ascii?Q?93Vd3yuyP71XURow3klONsEpyqwwFYr9igC0WaN6wUmVkCF4JXyqyi0xBl9a?=
 =?us-ascii?Q?tTiNBgXOykwi+FNGCoBRg7h8DFf19AO8McgfPmNF?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DE215A689A4BDF14CF260FCEBAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ed08b-e6c2-4e10-65f2-08de0b2ecfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 14:34:41.5051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MglwbhsXeItKHqry/X2UIcy8wy/9yceSjpC+ZYpr0EJ/y6axUmRWJUAizbzfSdXsuLuoiZso2QNzlHt7UJ/sFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
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

--_000_PH3PPF37F43E35DE215A689A4BDF14CF260FCEBAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-10-14
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
* ARM
* Broadcom
* Intel
* Marvell
* Nvidia
* Red Hat

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 6 October 2025
- PMD features freeze (-rc2): 27 October 2025
- Builtin applications features freeze (-rc3): 3 November 2025
- Release: 19 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 23 patches pending.
  * 53 under review. Mainly in 3 large drivers.

* next-net-intel
  * 12 patches applied and 10 in backlog.

* next-net-mlx
  * Some compilation issues with meson.
  * Some other patches pending.

* next-broadcom
  * Some patches under review and fixing issues
    prior to review.

* next-net-mvl
  * 1 more series for RC1/RC2.

* next-eventdev
  * All merged.

* next-baseband
  * Some patches for review. Will send PR in next 24 hours.

* next-virtio
  * Reviews ongoing.
  * Will send PR in next 24 hours.

* next-crypto
  * No updates.

* next-dts
  * Working on performance testing using TRex.

* main
  * Prepping for RC1.
  * Working on patches for EAL.
  * RC1/API freeze planned for 17 October 2025


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - Released 2025-08-19
* 23.11.5 - Released 2025-08-25
* 22.11.9 - Released 2025-08-19
  - 22.11.10 released 2025-09-17 for CVE-2025-23259.


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
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
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35DE215A689A4BDF14CF260FCEBAPH3PPF37F43E35D_
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
meeting minutes 2025-10-14<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 27 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 3 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 19 N=
ovember 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 23 pat=
ches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 53 und=
er review. Mainly in 3 large drivers.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 12 pat=
ches applied and 10 in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some c=
ompilation issues with meson.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some o=
ther patches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches under review and fixing issues<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; prior to review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 more=
 series for RC1/RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * All me=
rged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches for review. Will send PR in next 24 hours.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Review=
s ongoing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will s=
end PR in next 24 hours.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Workin=
g on performance testing using TRex.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Preppi=
ng for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Workin=
g on patches for EAL.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1/AP=
I freeze planned for 17 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 22.11.=
10 released 2025-09-17 for CVE-2025-23259.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
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
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
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
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35DE215A689A4BDF14CF260FCEBAPH3PPF37F43E35D_--
