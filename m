Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B2CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83354402CB;
	Tue, 23 Sep 2025 16:05:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 14439402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636307; x=1790172307;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=VXgGe0gSWfsTzV8gwIhHX4GHQTF0VChfAeY/AirWr2o=;
 b=Z2QRaLAxTy67JtQSaeIJPm6QmuKX78hjP40m5HW1qPObGOhWpDoKhSLq
 YtzgVOIDK8tiQ+rvsQ5l70FIjM+zFxVYB6j7zo88nTHQieETYQeU27oY9
 +tqkT0c9wtTXcCHL2b1bGNkCmChjshj0RJBvdMV+LU4xWpZunUbPTnbMB
 z94w9+QRV6r4t50zAws1ZoBuZycDcLzIjmPMRJxRdhmD87D65y1MbiSta
 b3jW8HSgAHs1fQRzVUedj3RYiMGN6ZtXKOQLB/8p3X4srX3M1QqWWnkrU
 PhKOTQm7y4y0XdOdfBMHvCu1PxgcqC+yBORbxjTZ0zkhGsGxOtEGUM9wm A==;
X-CSE-ConnectionGUID: 6YnPLQfKTQOFFxwo+BYAOA==
X-CSE-MsgGUID: 7L8/Esp4Tem3BxYkV0RCdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72022221"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208,217";a="72022221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:05:06 -0700
X-CSE-ConnectionGUID: TLmxzu/dS6GoZxU+B8tzCQ==
X-CSE-MsgGUID: am2nV4o9RqmXM/SlsAySPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
 d="scan'208,217";a="181155553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:05:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 07:05:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 07:05:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 07:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhpy4wXycEf7bsIJ9BHoIoUk2X+pNPfw5/V6qHvdC5d5EydiHM2L4unC/ymOOW3pz67aXvcreQisZzsVoyMQkaCEUTPjShdWRX3u6bNQgdMXbM2KeDjrJjM5MFt+h75aDvbh3gbjKeguYReW+nri2DXc/heEnKl9idhD4ab8Cm3pRFcKiTQbhQ0KLSzjbuQb8VdxOFZFYP9yb0nu+p4GNnaSbWuZo/M1hEgccdwfjK6CLoS3UYm1vZJS3sSx5x1RVZHWQJgDrnY5fNw++jonF6zmnJ871nqa7psV5FQV/Re10XCDzgb4MRQhs99rF6SzXEKOQG5xrBWNjooxJUgp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYUcVMCr7D6kwPNQU+E5dMBwgBHNcogoSB9YUfowvIQ=;
 b=PZsU8Q8k0mCd/Ap3c+gVbbeZKPBRMUcB//yCMeLst4Kn7POiuDyAXMnkk1NLI/AgYBgiRhxgkW60B/X2X3QnUfNNLVD+bb0krbai3wzsYf/f/DCFLHdHOLJ0UO90arHcecy57gcdafjxYg8s+wDGIvydgVWv8kTxiDSAe6NFsdAUsZwfhzGFKqRnVJZClcrYyfAJ5seCp6tpH5UfFf6un+grXGznph+UROj1gX0uEKWNZqf12U+v5QgzX8PzlsqW0BvuYbdYMJXJfIL+inEFU+zPbLpjYC6c0TWS3s43p1hniqcbn8sjOdr/Vra+EtJO3a1JOgD1D/4AYU1CI15MCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by CY5PR11MB6115.namprd11.prod.outlook.com
 (2603:10b6:930:2c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 14:05:00 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 14:05:00 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-09-23
Thread-Topic: DPDK Release Status Meeting 2025-09-23
Thread-Index: Adwskp6rlyQzLs2gR2emhQk5W4GNNQ==
Date: Tue, 23 Sep 2025 14:05:00 +0000
Message-ID: <PH3PPF37F43E35D118C7865796F74DC3F53FC1DA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|CY5PR11MB6115:EE_
x-ms-office365-filtering-correlation-id: cd57d450-24e5-4d8f-6560-08ddfaaa2f76
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CiXLhKUftBA9Ue2F8i9f4G4sXDGbHhu9oWuLAifoaXZyvZxsIBr1J+2EVvo5?=
 =?us-ascii?Q?lXhtf/YFlSXGbcDm/Z3YE8/593V8XmmRUdz6XFHvXdzsAlcs1zlYAhy40IkA?=
 =?us-ascii?Q?cG2vSMmrucHtZu3mZI/eGPuNwc+LO/g2zBp+JuClOS2nlqiR+vz/Jw+eq6Qq?=
 =?us-ascii?Q?57wp4dRy+CPXGIRsaWAz+UgrJydd3U4bYmn01ANuKgQ7fqypiNm6ccTJeY18?=
 =?us-ascii?Q?JleQwRzspxGKhm9rzUU4+MqMYjtd87JHLxaui+oPVfud9ezDoxTOvc5MYByz?=
 =?us-ascii?Q?graVO80ChzUO0EdjifqjipvLZeyikhC5lus//xFKm7rvrzuY5iP+smqLbGrt?=
 =?us-ascii?Q?ysZlNYunTiFnEdyCxbycrx9FrkoG2iRAx1ExMbzUje3QrUDCnXu9MRMDGTCq?=
 =?us-ascii?Q?7lhHUV7mMSLQQ9ysuwVgeSrP4pIdp2o/KiBe/lzro8KeowQIDmtEQcJzeVSL?=
 =?us-ascii?Q?FqIPX+8ENNP+ifQ+rOCcEWADWkqbgFds+RV00BBeo39IXklmaY4/BvXxOph2?=
 =?us-ascii?Q?QC/gz9OAnzW04fTG41ec7hXuOlMai+ipXlKWep3//4h8eETRbsrXlYzMdeAF?=
 =?us-ascii?Q?sjIyDn3GTCNnTBResxUNsyvVkXF6jCsqQwyei+2vbfps/3JlR6J8wap92xL4?=
 =?us-ascii?Q?W2HhFbno6s2FsS1f0U543CjSWHMYB7o/TERgnpfgMnv2wfNs2D3dDDQQoD5N?=
 =?us-ascii?Q?matOvquiBmm3vON12THyk+Luj2gpCVrrcDXaLPlI5Gh+efQPxPScW4+9qV4e?=
 =?us-ascii?Q?3BBME0+M2WVVKuiy/D1ioC0zSi5+eUhZ/mhjCKWVfzI+tLDQwx+YhTn7G6H3?=
 =?us-ascii?Q?rjkyBJBL8WFN9Z0nsOBPoY5AhJXCox0VuXJzFd/eg9DoOakiINLe7u5K0/WZ?=
 =?us-ascii?Q?+lhYT/VgRjdA8iGv5Z1G2Osdpi9SVitdo0227sLUzQpy+KPeQ2yRB/qkrlUx?=
 =?us-ascii?Q?wXl1G1tpTmA1y63Az5ng9gqm3zlrACPsDYYaXL4A8HtLDB6JbEaeNpbn2Zl5?=
 =?us-ascii?Q?JcL6Zx+z6LnfQZ+nwMky19xrllPMnmuRpjudFMCO4k3cRIr3GUvE6JxMzQHv?=
 =?us-ascii?Q?MQygb/BCZ6PH9uR+HzRhogOdm092O1Q2bVhY1/C6PfDcvM6sy2uyFwG55Mb5?=
 =?us-ascii?Q?bm8iS37xboq3l43YAzOGKphOfl1xyQoXwMlq1Ktqgs451ve+p99q3cgnl0Ih?=
 =?us-ascii?Q?TU4SyYW2kDNqxdTF/+lnV5wSqcSueakTmWNRwOBC/N8KtYY2wugJzFPs3TcH?=
 =?us-ascii?Q?0obkPMFEDFXBz6L/e0kUlNQVMWYcimoskgHo51etximA0kEwHtqLOH76r5EI?=
 =?us-ascii?Q?9Yp3IIOccAL1fD0Du1H7vxjPzz0obaOsPWqoDIpHLcaRN2R6uqnRTUk+JNvZ?=
 =?us-ascii?Q?wbbjJhob1o2Db1cd3FtlCxUcfgXZm61+VxEhMlnhKxMoNLdrkUB2r/+QUYx9?=
 =?us-ascii?Q?5OjefqgOgdfjB8BFKNDpBHfQtjCoheNE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhVLQ0P9LSBazDy5dVVRSBk5Uk2aaKmQM3oSDY5PILiaBPDTVVGpILD/YqU7?=
 =?us-ascii?Q?DLT7l3TTVFYTrRFO9rl6CDZX0Icdv1pCXfpvp4ZVhfq/aLd90A50Xn1zTxKR?=
 =?us-ascii?Q?WGkD500RRosxlR2RVar6SgBbUTWP+WDJrUzWQ3B5ioet37IO9jY7xOcioat+?=
 =?us-ascii?Q?TXV1wPxVoMJyPMWQr0DHlT0wdQgYMJatDcAvLFzuyNBeef0EAbpS7w0ovwFU?=
 =?us-ascii?Q?SiuVjpf+9tmmVXfX15FH4dSRwO9xTKScib9NnJ0v96dCgh5eCOcdqHRkggDr?=
 =?us-ascii?Q?2bOXBeDSyBUuJtd5M59stB8a9eHlMqiLhXud6HD4Fdo60HlIaIKa6fO17wJt?=
 =?us-ascii?Q?7EUJIUbd30CWsMoQLUPMm4KhwGmXGIr1/juthorSHnguywMz9NuVwysNgZNL?=
 =?us-ascii?Q?dbArToWSIjPPRoSJqWSFve62m77MFx7yyQ+8FNa4tvFqkvMz3ysMkIkhIphJ?=
 =?us-ascii?Q?TVOY19IpD6o9IQRKi2J8Y4uQ3gltMKRyo+zBpDGKWvmXhhU7pcVybsRiuXq2?=
 =?us-ascii?Q?NTNlJT286uhQ+QLYR49aLHfNcDhd1tRbpdA4ibf/pmsdsffGtEYrS+dqz2NK?=
 =?us-ascii?Q?L8TlY9VUn48/+FUGIyLb0wD0ZDljIIju7ECgqeAf3KiKJtPGPTSRpzvdbfsz?=
 =?us-ascii?Q?zgAIQ6G70h82f869q8nTQLfcpDSPHcQW+cTq2hr8kOH9uJ28wwsVKuB6QciF?=
 =?us-ascii?Q?WlErTgng2SoR5PympJn3L4RPJKhKZcO9cR/kC1CPBgkA5mS9MXA4Tpm5s2PH?=
 =?us-ascii?Q?OEFBu94q2gFc3Os2BwcRdPevqfyTBGGqzq659emDdJdPsYGkfuy7wTz8Xbv5?=
 =?us-ascii?Q?Tf8PcWYdititHLfmp2m617idK46BLhAoSHh+WVu8VFoe9WobnZ1wYHvcuhTx?=
 =?us-ascii?Q?Q6U7pOxjaSFdO7hdG6bSgNnldqT9IBl8m9Wripe0X4w7GrhWVjIZBNgAxD6N?=
 =?us-ascii?Q?e+sSVmM7HUndKmjtTcxoe7tfl1me/k0eiQ4OW/Nk1NftrTDY0w1sBys8A6lf?=
 =?us-ascii?Q?hHSnn3EOI17AJp90aaHF2+tyDsmgYxCmu0gnknhWD5wpcErl5gC7mJK4fRGw?=
 =?us-ascii?Q?/03iJoY6xQ/DYCBdIDCcVhwBKnysRz/WwxhXWTILkZI/l0/zhiJnq0lNeo+X?=
 =?us-ascii?Q?XqnzLxQYB3cI+yryEAt65jDkt/JgWAGDI5ThKzOxqksG1I2ifx8Juaq3Q5d+?=
 =?us-ascii?Q?nc6j5cm+NDZE/OR/sm1Mxd6fbajsaSCBl6eTZ9zCwKAYGGOp22ClV/6I4yeW?=
 =?us-ascii?Q?o91rryQsAAN4OfO9TQQ0GThdRlqgM25h8EKC+6829rTF4+wDf3fH1wi1m9xd?=
 =?us-ascii?Q?xACYdHGIZI5vuo6nuB81n/1jmcnb2goAPWN4zctzwvcAcMhlJOhHqEtuTpr7?=
 =?us-ascii?Q?5CHGmeKqCouMYIbsuy3iU1VQWfajXCVPCcJ0dN9XNpLZjT/hEcpKwoUUWOak?=
 =?us-ascii?Q?iD/SHDQ2XDBNxW+JyTrB1ePuuUySlYW1FEK+KGvuVCISavT20sn+Lu/A2UTs?=
 =?us-ascii?Q?R377JGCOPJXycAh1XQhH5H4Oa5N2gYgM2fEBSzCQzT1BhI71kCY4AREg94vJ?=
 =?us-ascii?Q?LwGoOQvl1SbVEX/+mpHHQE2TdMWE9lsZDfyhcTBf?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D118C7865796F74DC3F53FC1DAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd57d450-24e5-4d8f-6560-08ddfaaa2f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 14:05:00.4042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3CsZUj4RtPTnbdsA9Q/0vsKJXuSELIs3M8VnzDpJj8uCVPhx2WOffI94ctoJwOJZf9Ted7eEk2AYwlpF+YLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
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

--_000_PH3PPF37F43E35D118C7865796F74DC3F53FC1DAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-09-23
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
* Nvidia
* Red Hat
* Stephen Hemminger


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
  * 29 patches across 8 patchsets.

* next-net-mlx
  * 16 patches ready to be pulled.
  * 12 under review.

* next-net-mvl
  * mainly merged and ready.
  * 20 patches under review.

* next-eventdev
  * 1 RFC from Ericsson under review.

* next-baseband
  * Series under review.

* next-virtio
  * 1 series for SPDK.
  * Some other minor patches in progress.

* next-crypto
  * 28 patches in backlog.
  * Asking for review of PQC RFC.
   https://patchwork.dpdk.org/project/dpdk/patch/20250828070657.8968-1-gmut=
hukrishn@marvell.com/

* next-dts
  * 9 series in progress.
  * Adding new test: RSS offload

* main
  * Prepping for RC1.
  * Some new work around RISC-V
  * API freeze planned for 6 October 2025


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


--_000_PH3PPF37F43E35D118C7865796F74DC3F53FC1DAPH3PPF37F43E35D_
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
meeting minutes 2025-09-23<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Stephen Hemmi=
nger<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 29 pat=
ches across 8 patchsets.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 16 pat=
ches ready to be pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 12 und=
er review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * mainly=
 merged and ready.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20 pat=
ches under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 RFC =
from Ericsson under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Series=
 under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es for SPDK.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some o=
ther minor patches in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 28 pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Asking=
 for review of PQC RFC.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp; ht=
tps://patchwork.dpdk.org/project/dpdk/patch/20250828070657.8968-1-gmuthukri=
shn@marvell.com/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 9 seri=
es in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Adding=
 new test: RSS offload<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Preppi=
ng for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some n=
ew work around RISC-V<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * API fr=
eeze planned for 6 October 2025<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35D118C7865796F74DC3F53FC1DAPH3PPF37F43E35D_--
