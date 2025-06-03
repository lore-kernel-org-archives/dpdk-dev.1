Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB23C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 13:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F365B40697;
	Tue,  3 Jun 2025 15:53:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1A1EA4068A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 15:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748958814; x=1780494814;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=x7FVkaH5dZAEy6GWnUXup5t95WlbZrosHuDOSDUIqZQ=;
 b=lfY7oHeNxYbIIyMtX/fj7keRQDTsv/8eNqjOqcGD5s17IpMOwlFKH657
 GrOTgHoZTEwZbS7Y1yKxGq9KEIMHOBv+oBPyCvnEI+gr0U65c8Hje4m3O
 gkBHRFy4aAkjGA3yF2XgzxxjoSYOTZ0tca+IW7dKXiX0qQIYYAEu8m82v
 WMSlSJKYJjREOTKKtxkmc5/4hoGGUsGrrBEO5dkTLwUBNqLg7IMBCOw11
 eFSEi4sw62GxrzC/Vqf0WT5x5AAp0XtkzSt4LIH0vbx/+3sw9pJTUtUaa
 zfpInsF//IND8S5aydPtLbV5RDnUimQiuPJmRS7IEae3uYwnl/my2ee6N A==;
X-CSE-ConnectionGUID: +ws1GYYgT/yQKdM8XqKcVQ==
X-CSE-MsgGUID: qwR58UjaS0O3N5GmPU8XZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54804397"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208,217";a="54804397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 06:53:33 -0700
X-CSE-ConnectionGUID: kt6JNnOCQS+QD9+Ep/MwiA==
X-CSE-MsgGUID: LjuLLSagTnyWYgkl2YrjZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
 d="scan'208,217";a="145485900"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 06:53:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 06:53:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 06:53:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 06:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbKZacXo0+f9nyay9rrpcXLl28RtxU20WPWRyaV1zD1yO0xj4Mj4ak2bfWZqTJd6O/cCi5mWMxN+rTsp6ixAcDYLScqSDPb9acgmB+Ls5N/TnYUlUBzBR4/DJU7eldhTKbGJO47rKzL8UUhIQnhIkJQp/yZWqGrCHH6G8odrVk8jZn3S8H+wVtHTOXKtPMsXNvWzmfG7ZXgVOFAAoYo/us3pcmCSblGwy2Spt4LZlp6Efnj5hb3MX2L/ZtT3g3IzZ/tL8TMbxs4y3mM77+J19Uhte17hhDgtTgyHPNwCU+W27qJZtSXx30DkVjWTAfE6C0GoYDC3KyvzXjDAsZnIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSwgy8QdUGKMy7XefQMLv8OBXUxAjxDBj8S1s6jpg98=;
 b=cSyJCeJjRx+rlutDeQFb8xR2N6kHuG1GzxKKOU7UuP1ElgsKRPH8XQtsTIDxWzx5JP07v9qlJASsouREKuUpOuaLx85K4bqrGBZgVrlt7m8z5mtu1SwhK1YkxutK2x2MkWIQfFDti45IqfpJstzw9Yj31PPKTwYEj8g5bdUJ4FSPeL5Hp+mLwfhhk5sxxRLuwSm1C1mSzEMQYgqSNvZF+bWxy2t4hpTsEAS5OKBiz+y+RvlEGL0JBoC8IwjRC+m5+pVPq59H98NJDJrIh5YIqspyIrhpIFjis0WXwxOJRVXY+57jkBf5mYMqFSc3ld+gZG06PWFnUEGCxx3VPDXniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA0PR11MB7331.namprd11.prod.outlook.com
 (2603:10b6:208:435::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:53:16 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 13:53:15 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-06-03
Thread-Topic: DPDK Release Status Meeting 2025-06-03
Thread-Index: AdvUjspoUH/sQ6/AT/GoDRj+KMduOw==
Date: Tue, 3 Jun 2025 13:53:15 +0000
Message-ID: <PH3PPF37F43E35D6E75FD1C9D995C27580AFC6DA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA0PR11MB7331:EE_
x-ms-office365-filtering-correlation-id: 2289af5d-34f8-419e-6ec6-08dda2a5fd17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?K936dvDxaKfd1GTMoJy4hCLsrRy6OGh9XUpCiSxPjFodbkzkUzRyaB4c2LEz?=
 =?us-ascii?Q?GwH2uy4AJRYOV0/bMLhD4C6R7FbCY1llLHPVk7zwXO6fdrfQwkc+r4pjkM2Z?=
 =?us-ascii?Q?YZxh1esoTaq474QLWiL3nHPfuy6tRjsdcUwQiM/sHQVUIqeNhlnEMaSa0Mmn?=
 =?us-ascii?Q?A0NRU/YEKvmrcsYpHStEVc9yLqHVARQLSXnKiHgF5bgG+8lHQgQZyv4W5NT6?=
 =?us-ascii?Q?GRXSXZnRZea+Y9K5YCRdxZ7RRECRPoKgrBMR7ACmyydin8QQU/HkAgE5IITE?=
 =?us-ascii?Q?/0rc/k8o1s770kiwJasjeoKEB0S/xX+HMvVgCw4Iqm5oh7vqtChS1UMX9kO1?=
 =?us-ascii?Q?hnb1gCwL5ycb4v9UWDW6AkpBwEMCW1HXJtLY5p5up82a+JU4EBjiQUBuWLfT?=
 =?us-ascii?Q?ZwtcMS2lb7YvZgRlpCbZ/2ZNomKEsM0YiJGlmdBDZ7S33W2J+ngc8zRNfKNU?=
 =?us-ascii?Q?nVTAeRaFwnZamcL5zkPiB6rdvass4zCfcbVyWx0Qhf4JAQo9z4XTcq88llDA?=
 =?us-ascii?Q?Rjjdhad3EPPtJcMehBfLHAS6NSV/SwozBsCv5hvUsdQraEtjk7FyxRDuZbMJ?=
 =?us-ascii?Q?UTUcWlTrjfP5q2kDFCdHEoFEy34EEHRbfuNdESOpqZywJDwhjsSH2CN2F2FN?=
 =?us-ascii?Q?BAEfG4DwsU0kGivnOubH3PgfxyoV5Ay8XnlL7nHEMBHOTpiuEt03HZgeZDQR?=
 =?us-ascii?Q?mNPFV+u0lSmMo3X1qr3r5BInN1cquoTOTloS/uH1Zh4ekWgg8wekhrTHea42?=
 =?us-ascii?Q?AOKbmPkXsIU2ocxoNNqw6NWpaBGT8HVS0nT3Q4lsTrKRe0rUWfYO2gnAl89R?=
 =?us-ascii?Q?AmBy+T0YEkqfB12O0xpiNyaRVMb0PAu3od+2VW0Ie08CcMRIZzlKwk+QnINl?=
 =?us-ascii?Q?XOHAEw8Qp3MPDA6tBz1iwYMpqDQ1mflVGP1SqkjunUoIVVWKML2QWcy7u7wC?=
 =?us-ascii?Q?Vx2/TS+aCPRH209r8+9pgeF1ZsOFPhOUi/lOKRkJkjYK+/wC4KdK+A5XPQbx?=
 =?us-ascii?Q?t0ujWy8oxuLt90l99WZuE4/rivIkpgOdExbzQV+5noAXCRIFcnUbuHP8Gn/L?=
 =?us-ascii?Q?56q8QP90ajzPEYOKCMpNSImo7wf2pBAP9408LTwNIXgy+4ZQ45fZ74Dcyuet?=
 =?us-ascii?Q?IQb49/4YPs7NdkqsTxLQrD2wFLLnDO+mfMbY90d3PMJ7EPVnBB/GPC8eESGz?=
 =?us-ascii?Q?PtTKRAneXGWD7duBymQTFK2oWdWvSQr26vrjTlEoUjlJhgjBuA4HkhHOSgh0?=
 =?us-ascii?Q?KL03h10wR8OrYzIZT6263yXdWdiGzsNlPBThYYTOPVwf7PmB//Mkyd3ExjnU?=
 =?us-ascii?Q?sGqVqpZlJJNEfBOosbvyWtjXT0Xi/8ZLbP5btCWYnBnE5PtfJIxpeA+7FrBD?=
 =?us-ascii?Q?mXaGj9Biwg6KkofqWBTHr1V2gs/3H6+jfVxC+JkQBjfoOrcpqTQJIdSesxwn?=
 =?us-ascii?Q?gW2EbeRAK3DWYI6sc9n/lDctz+c8EHLs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?He5wmN4sOun63MwBf7qNuOLuRPARlgCZ70UvsclZBi0eZpMxlcj59Ha4qlJK?=
 =?us-ascii?Q?nIGF9RX6Opnt15l8TmiSzcZ6FdETUpdGunDuuNHo6IGhXC0pVgA/wNshltUd?=
 =?us-ascii?Q?OWYRNrJ3bGBo6KCLbc915MWbbjTPMqvVndATAYxpoxr+5qLXtWWZseQcIQX7?=
 =?us-ascii?Q?3aSOdaT0zQMuHS81kfeGdLQ3qVE+YqQiUWmxWgrSq7qQR0JPzkKqjOmJ//4j?=
 =?us-ascii?Q?CMEh5jT4xTtB4IvPHjFGHn8BN2DN7r4SWUGV3pL2L6D5VdFwD/rAxUSPOfkt?=
 =?us-ascii?Q?sPLhxGxr9xXfW8AwQz64MKcONXuzzKmZIQsGsBf7/qAHlB/eSs+cdBbdJ3Xa?=
 =?us-ascii?Q?ingTP9Ir2lSuft7tkTVFIU5C0lqMhIXRstGXYDVEM9SJFwVQR++hNtc4Da1W?=
 =?us-ascii?Q?cdAlid6kObAOYkTR9pEoR1LnhBGA9upcPITfIvoIXJIJxApT/1mDzFe/adea?=
 =?us-ascii?Q?Ig/juUzsUm2SIreTFjzunkDlH9ed/IN2fhamPANbjlHX9cYh79HXhQ2QptYV?=
 =?us-ascii?Q?jCRdfstV80u5Aa2awRSmMm37A+othokAQLBeKAb3aXmYY46eCZaQddWMjVxK?=
 =?us-ascii?Q?E/wYjc2t2bjQezAWpVZ3w9jxkBnlLUpzEQhUTLZ3i4yc0/EgJA8mOdTnkuh1?=
 =?us-ascii?Q?jV+lKqGgtRb2YwBM2yyhkpDBjBPBDvGj7xEULJqB86Bgb4HBccFkFFJrHW3k?=
 =?us-ascii?Q?6cZ7sfYHuD6epWtluCv8V5NkBPq0+VaKbFuklbFseRVz0Jh/NjpqTQPenUbh?=
 =?us-ascii?Q?rlAW9xdhUxrYzYapYLgUcNpJPL/36NTZha29wPTyzsFUOeFkVEN+dWH+svKB?=
 =?us-ascii?Q?TwR00/DzuVcXtdMRF0tFPUfSxeK8fmwJQzTeLzcKCuHIBxmpfFi025T7tN1X?=
 =?us-ascii?Q?AlsOuoWSSL2IN2QmjuY6TZKOptD2lypKZLIeRGFlbtl0WUWimlktOEm33XvD?=
 =?us-ascii?Q?n8lOOGdccAw4EACYoDcvt8DHTepkeUF92XtaWk2B44wc20INj/89shAXS045?=
 =?us-ascii?Q?FDMOOrKztO9XmJe7Mx01YyEbXs6zbZSHuoIlgxYOhUUZYLRGSrfkCINTdJNk?=
 =?us-ascii?Q?yjMfwNNZg43oSATlk/Jgv+Ww2DFv4PFEjW1hNK+n4gnVB8B8s9nRh6P5Dy8I?=
 =?us-ascii?Q?sfgSZvvi4kQiG+Lh/NLa0djY/GIdUXNmwe4mDfTP1dbI15/xRAOBv/VcvM06?=
 =?us-ascii?Q?S2x/KLGhwL4urbDDEINRvaJbTewA3cF5jYWvn7/t8cdhWtbRB4Htf/wnf5W8?=
 =?us-ascii?Q?CFTvnQRjnPROBWOAbkoGKLHDjMbtDm4YxkhIlBCIMPbGXnoBTtvHJzkf0GU2?=
 =?us-ascii?Q?M4h2hHpVt+HjftbPou/IPpIYG4ov03iON6uHISNzcGvh8/gELSGw2s96P9ca?=
 =?us-ascii?Q?lC4JZobTtED7lLXnntAtPVSKvffp9ap8DKDlpfsDJ6KgHNQXoVKN1jZfMPlA?=
 =?us-ascii?Q?zNUYcHa2B99IMEmtcPvxc7gTR1yiCbmWU/xijo8VYYHhSzaYcXoCdBj1xc/X?=
 =?us-ascii?Q?9Ps8rNisbHTKZlKyGPzOAdXSmGzEGpStqbRpwZdR6nI2w9o4Jq8v3T5QNGrm?=
 =?us-ascii?Q?yi1GP8IXyH4tyiH1OhxaDhBB5QWvmkd0gHDRTwKU?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D6E75FD1C9D995C27580AFC6DAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2289af5d-34f8-419e-6ec6-08dda2a5fd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:53:15.5680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3111/ryHvEDy8vnPB6Q/fBgqLDkgQQrqvS5THqa7MVVNA9Pc1d2LsobpA29+U3898aJ9iQUb0FAHLEO656iLHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7331
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

--_000_PH3PPF37F43E35D6E75FD1C9D995C27580AFC6DAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-06-03
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
* Intel
* Marvell
* Microsoft
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 4 June 2025
- PMD features freeze (-rc2): 25 June 2025
- Builtin applications features freeze (-rc3): 2 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 190 patches for merge.
  * Mainly merged. Some still in progress.

* next-net-intel
  * 10 patches on next-net-intel tree.
  * One more base code update expected.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * ~20 merged.

* next-net-mvl
  * Tree ready for merge/pull.

* next-eventdev
  * Tree ready for merge/pull.

* next-baseband
  * Tree has been pulled.
  * Looking at one other series.

* next-virtio
  * Tree has been pulled.
  * Fix for vdpa device hot plug. In progress.

* next-crypto
  * Patches have been merged and some ready to pull.
  * New crypto driver for ZTE
  * New Algorithm: Snow 5G

* next-dts
  * 7 series ready to review and merge.

* main
  * RC1 merging in progress.
  * Some major series to review such as rte_graph, mempool.
  * RC1 likely to be June 6th.

  * DPDK Bay Area Summit - Santa Clara, CA
    https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8


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


--_000_PH3PPF37F43E35D6E75FD1C9D995C27580AFC6DAPH3PPF37F43E35D_
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
meeting minutes 2025-06-03<o:p></o:p></span></p>
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
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 4 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 25 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 2 July 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 11 J=
uly 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 190 pa=
tches for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mainly=
 merged. Some still in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 10 pat=
ches on next-net-intel tree.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;* O=
ne more base code update expected.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~20 me=
rged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree r=
eady for merge/pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree r=
eady for merge/pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree h=
as been pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g at one other series.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree h=
as been pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Fix fo=
r vdpa device hot plug. In progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s have been merged and some ready to pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New cr=
ypto driver for ZTE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New Al=
gorithm: Snow 5G<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 7 seri=
es ready to review and merge.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 me=
rging in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
ajor series to review such as rte_graph, mempool.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 li=
kely to be June 6th.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * DPDK B=
ay Area Summit &#8211; Santa Clara, CA<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.4<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.8<o:p><=
/o:p></span></p>
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

--_000_PH3PPF37F43E35D6E75FD1C9D995C27580AFC6DAPH3PPF37F43E35D_--
