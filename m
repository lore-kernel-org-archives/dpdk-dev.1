Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA37FC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02F83402D4;
	Tue, 10 Jun 2025 16:01:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A07444026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749564066; x=1781100066;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=rRszGnvYJM+j1ipbCvv6AXZ/h9d9oWypOGou2IGbRR8=;
 b=TKaAUxOyLtryk6igxfVvmPZ2oU1fs6O2X4gVudfmWXdqwiBWrAVwbOjr
 oqlIszdfMvXm8mf1988LVaxv53bnSXnBytEfQU2SKTnHjNTRXMg1nDr6e
 QQP+PWbp/IJpNyTXFfFh1wKStHuskLSjVi9flxM4tVzNPc9cJxi4H7/cZ
 5fZQIqOJjIVnRp8/nKK/ieBOeGJeYp1ep+dlTfrkM15qL0sm54fHleDpG
 FDM/xCoLU04hlgi4DoE4Je9Rh/AUQK1qa8BUxMyvM4s+jtRSdtUFd2wKq
 UGFulhbRRi32rgkPl/7u9tZwYHR0vlvkD1r6vwA5okgzUA00JE+EEAoSn g==;
X-CSE-ConnectionGUID: Jlsi54siTfm5ztI8nP3SaA==
X-CSE-MsgGUID: GY0BlAZFTQ+7spROqqS13g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62330623"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208,217";a="62330623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 07:01:05 -0700
X-CSE-ConnectionGUID: h/aYX3Y5QGuz9IrY0MGjcA==
X-CSE-MsgGUID: frmtNdXnRBCVMC5i1cpnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
 d="scan'208,217";a="147778526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 07:00:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 07:00:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 07:00:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.72) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 07:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTSSEnaFqQMIHv64uDdEVSXUqvpNKUi4j/jpVq+W9cO7ukFzRxtTpyYEwh2hWQNel0vpTjxqzrsejKu7kYYq9qiR1akGE8t46ITTqvQK0qDy3RIfMtZiUDsrsninqmWb3jLulxVv3fi8DNcjm1yBEcnVJb/EQH1rj25MKCqoMv0Hen4cMiWbEO/BgbJUeG3X/BhRDSre9MDyHmXva1vc8SU11COeTNIb2KV5BZexHDL8AcNd7CXNmkbn3NoiKAc1UVttKnVqVYT7m3HyPL1W/oP7mBzOWD1AP7p72NtzLgO1LtzsIRMvr1BPLzZP8UqyAkgXomF1OP1mRGGJVjTkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXC8T5PjK5ipp6hOVGVDaIdE8zuv/H3VYz6cmE9FV8U=;
 b=Q1Cos3eeeeCBypOFr5WP/lBtB4cKF0NAl0CwaFoICNfJ7Aktp5X5ZqvpX9Ms5pYfF4N5PDR/+yIC3B0PdPi3p64GiQvcrXcOhRkS4sU2XFifrZWg+s7iblJ6Hw9QRH5mESXvWN1XS/DAw/SMqVyMqXexZLjj9yEosfF9FQxCZd9uSyTAglpZQZYenBXsh4tuLpo1S7y5tkzIuk70ZRi/paIWksELtj9sQEbSNrn38Y9MqLGyqXhpr4cVmJEoWOas1CyD4BLbtWhoxY/UqUXWL96aziEeMx5Nc3M58T8Tj9kAxgltUd+6yTgUVJvwloiqDAS5ZLcKibEwovxAuD/RDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 14:00:39 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%7]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 14:00:38 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-06-10
Thread-Topic: DPDK Release Status Meeting 2025-06-10
Thread-Index: AdvaEAJptAtsanh1QkSn5gkDBxzW1g==
Date: Tue, 10 Jun 2025 14:00:38 +0000
Message-ID: <PH3PPF37F43E35D8F4511726136E3D69EA2FC6AA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|MW5PR11MB5881:EE_
x-ms-office365-filtering-correlation-id: 5b92e244-c627-4ecc-9834-08dda8272e34
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?u6Flk2RgAsnte4NJLabBiohAwBA285wvB7YGmB9Lr1vV6Pjjw16MjhxZRNQR?=
 =?us-ascii?Q?25RpPVAnGsIgUIlwX5gMbf2xMtTW9WmoIvb6TMaEEl/Og54ZVZiCosGxU2/r?=
 =?us-ascii?Q?KluYtHqNThdUEPmvPRc6DnBoV44UrUxr7qqZA2v+L5IHN+Ha0O11smndppSv?=
 =?us-ascii?Q?DFROGV7pLm4AHPe9iGui+IiKZVepOTUBBThZ588Ore/+7tMG2Kntse2qzxQZ?=
 =?us-ascii?Q?HuR2YKj1R/CafQcV7MIPflt0g3lSmdbWlDSpt5OBMorQF6bSbVY5eaaH80+Z?=
 =?us-ascii?Q?6TVqHG6fPliUTR0qO/GatsV7jnlzFSxxY4OUdcwuBjiT24K/5UJHoPkWBLWm?=
 =?us-ascii?Q?imtXVhyS8KXLd73T/B24luIy+Ygq2I+z4TBqbKR/DzbZuiPswOP5vhWl/O/1?=
 =?us-ascii?Q?7T90Gu8VPo0Akk+0TFLW4E+/4h5lRdw+qRYMAJmNNBT0HaVT8v9z1vYwFQBj?=
 =?us-ascii?Q?Xv4QP6zteJ/rsiTDoFWoG1H35ywkm9SfQnW/rnyXq+iqkG54pZCQlXWTYZG/?=
 =?us-ascii?Q?+3JRF8zenOgV7sh9WmkP4JM/sO+gQ1dZ3d7VPiOxLmkWma3LVXWw50R9wnV5?=
 =?us-ascii?Q?2JpJHv8hxwxZp2HUOKeFIWgNBjUKXK3hnfLvvgaS3oyxBcDMLbGHUAivx2C5?=
 =?us-ascii?Q?eZlcw+KQQ5Zw5toIfxNylG3taZxppbv1QNB22aYUKA0XNFC7PB6F9BG65gZE?=
 =?us-ascii?Q?8UzY/vIeeoakJnhf5OS/3xrliNMmmlijPgXDVPR6V0pv6rlxdlIs+tXEfrrS?=
 =?us-ascii?Q?sjNtYbcXho8kbb+ZZpb//btRNOTKKxQ4FsBftEG7GKCo0gWgMfJpTlw9tB67?=
 =?us-ascii?Q?eACMyrZ1LUTUkZVDB+Hro4QN4c4ZgQdkRgbEfxwKqXD87ab53z2GQpXCDVzH?=
 =?us-ascii?Q?Gp2nZtX7VLjxYSB+yckVYl3PgKwrGULDDw68swWc9RoqhRS11kkBMtq78SaA?=
 =?us-ascii?Q?/ovQARtA+w2tifJOwU9bEWRYsB9Pny3UzhnR/RbiOMJSIJzYyUuJ/UhfqbnE?=
 =?us-ascii?Q?on95tZ3drPEQqGNXcT7DNVZ14vknXe1HzESrLf1D2/UCN08Y7wTZkHa9Tt8G?=
 =?us-ascii?Q?FBoDKZI1Z0G1GnZzUS7BQRDXvwUCh4J5j2SIKvjYfYTXQz7S+u+4ZU0bVMH5?=
 =?us-ascii?Q?fx47WHjVCu7vDAV1zUHLVpXYORNpYC2ofM2Aa6IhHxe1bZXAmyznlIqmo/WU?=
 =?us-ascii?Q?V82VMHiB69G4VL5xYbWYAZnScjeVw3qW+ulOA3tCwfJYKcdTWua+IGFo5k1c?=
 =?us-ascii?Q?bToSDKpSPdjcrnfpT6qm9XOByCX/PBkwbiJAL5Crzrtgeyb40TM9/Hq9kbKJ?=
 =?us-ascii?Q?CnZWvb10ol8FmBM/1VzvkXfz9K/GPeHBX5cDtEMUGegTSpgn51eYLVaauqFf?=
 =?us-ascii?Q?M4fy1mvbwogZWuS2fzkOX35ffPSm8lI+gX+QbfEH0c4QsovdnyiVKstKnyAj?=
 =?us-ascii?Q?N3P2rsxTTcas3y/sYGZUfEjxapUC2kfE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PVEs/PgKONN73OXJodSiJMwKfuQYnbN2KFG9a6nENoBXQNJeLrS1acPaStM3?=
 =?us-ascii?Q?q316vgBeZ5eeXIJHbHxf2S9xJrpM9fERNqmFNhIBBG/LxedvkLjBYRuYZR6q?=
 =?us-ascii?Q?qoekG+WzfrGagJqQWWT5/H/Tg8a0Saqgio0DLNvnvH/1T3hx9EthjHJ/4rrU?=
 =?us-ascii?Q?gDmIDpaZ3tRJ5fOmmE6qKclFQ4t+m+Xww3Mt9P9pjBXNTJzqZrhKH578sjJ5?=
 =?us-ascii?Q?Naf6dMel0MYvPAKEnbOtCKo4hjtqrIbtMID6vPiKYfs9GBYNxJMSBTAqiDlZ?=
 =?us-ascii?Q?0Md0G3ydx7WlFb8oFZWXNGpj+ZckMfc9hNuma+O7TeSlT9jtnOnUSBULYwDz?=
 =?us-ascii?Q?+nUQPQFw8bM6VzkE/HDdQ74C9doL5GRKR3ysLKROf8wBbbuU3tzsw1pPzDOz?=
 =?us-ascii?Q?UGJJkejBUsND28rCIB3zCmul0jHezkEyUjYUgVSMinVZwogju4BbzFutpaAS?=
 =?us-ascii?Q?FccaUYjCQ1YDCGWyRja7yPWEAhB3ULuz80emEKk3o0KeWpU23vMK29Aj8t8t?=
 =?us-ascii?Q?a5uvGXlXbfOyx9xIWx8JIVQdiqXba6asumJG1+/P/jFDF4rMCsfNJ4xtLzDa?=
 =?us-ascii?Q?ezupAgHdt6QO7Ba1bF9M1OIYEaMAJ1zoqaPzc7/ns4Z/aFUSXPhe0AKWSRRu?=
 =?us-ascii?Q?z21bI0IPzQSK/hAdmG0bvjBvw2K5Dn8oFE2kAEZzTd9fczkY/OLao0otBVeP?=
 =?us-ascii?Q?8RcVqZViEVItme9k6vl6JHXblbMpmGfxrSoeLhqLJF65Mb1Ed40QUoY5fc00?=
 =?us-ascii?Q?8h5Hw5JdohGqOlxhz93sgqIkNAFVcdhRR3CfhkO4gzUhCctqTeMkoDbzfAHr?=
 =?us-ascii?Q?kf986iTudFj8GEUOAvSFtzsG52ZCtZAHZYuKHDabUBfhz8QHVmUIU4gZseZu?=
 =?us-ascii?Q?AfvN18wjE4U/Ym17DuvycPVoRBoehug7WP5IvjrPKCOZzHeSHJ7iHoCdbyA6?=
 =?us-ascii?Q?ri59RnqM26IomLxR7cjxi6VVU7ORmcQU0kj41rkudhNwMH9vXaB4etCRSnTU?=
 =?us-ascii?Q?SaBVG669qmKYrKl1PO5cm58/xb0mHckHsdBVq6SX+oFSJtUp003YlOp8n9Nx?=
 =?us-ascii?Q?BLyKmG9gCgLTAZHnsDY+gTuP3t8seBa9zbgHr2nUWBPTNhtm5zEA7dutHvmK?=
 =?us-ascii?Q?v0N4/a1S+6uggHbUNyVs2unFy/vZlhns5u8c4W7kFqizO4N839vKumJ6jwf0?=
 =?us-ascii?Q?zYtIHPmJWBdBzbniR6y+iVQTGwOQMAfuzNFfYEiJYIjDBYio1GNMMDgPHiso?=
 =?us-ascii?Q?2pAklKKiJ5WDRZleMwQIYJjjFoXjP2FY84qWD6KXfi7wnj1HvPouoKCjnlim?=
 =?us-ascii?Q?Wg6Ih1CWiyA+Xv81uOrsOCZLAnG8hX7bN82I5ldeqFWwDyMcC0Vj74+l+BqH?=
 =?us-ascii?Q?lwSw3y9/EVdZ/wvKKEZez4ADp3f+aXU65Q5m3SiuEzPBiZYbkWdG0gSUVa7w?=
 =?us-ascii?Q?xIhs2bv1sK/tLwyBSjHDc8l6MD1Mk3JerNM8TyHPNR/z6uBHoP430uj9mzVB?=
 =?us-ascii?Q?EJoIXFEwlpOZNDLjJ79qoQM22xXR3BWm1lVU0RCLWftyXqdHTdIQ1gwqvS1x?=
 =?us-ascii?Q?IsigVPfKkewgWYL1Dhm8wPj7/dU8IhNTG8F1Zrek?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D8F4511726136E3D69EA2FC6AAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b92e244-c627-4ecc-9834-08dda8272e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:00:38.8792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9YaIwVd9x2igcovh18GYSTNUexc72kvN+VlRP+13hZ6aTUyK++G8G4QwO73XBzGojkiw5P5u9rUlhNlV6+vmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
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

--_000_PH3PPF37F43E35D8F4511726136E3D69EA2FC6AAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-06-10
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
  * 3 patches waiting for merge
  * 3 waiting for minor changes
  * Mainly ready for RC1

* next-net-intel
  * Clean-up patch set pending
  * Mainly ready for RC1

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches waiting for RC1 merge

* next-net-mvl
  * Tree ready for merge/pull.

* next-eventdev
  * Tree ready for merge/pull.

* next-baseband
  * Tree has been pulled.
  * Looking at one other series for RC2.

* next-virtio
  * Tree has been pulled.
  * Fix for vdpa device hot plug. In progress.

* next-crypto
  * No more patches for RC1.
  * 15 patches for RC2.

* next-dts
  * 3 series remaining for merge.

* main
  * RC1 merging in progress.
  * Some series for MSVC under review.
  * Some issue in CI under investigation.
  * Graph nodes series being merged.
  * Will also look at memset patch set.
  * RC1 likely to be June 7th.
  * Looking for a new maintainer for eth_dev

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


--_000_PH3PPF37F43E35D8F4511726136E3D69EA2FC6AAPH3PPF37F43E35D_
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
meeting minutes 2025-06-10<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 patc=
hes waiting for merge<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 wait=
ing for minor changes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mainly=
 ready for RC1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Clean-=
up patch set pending<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mainly=
 ready for RC1<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches waiting for RC1 merge<o:p></o:p></span></p>
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
g at one other series for RC2.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No mor=
e patches for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 15 pat=
ches for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 seri=
es remaining for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 me=
rging in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some s=
eries for MSVC under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some i=
ssue in CI under investigation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Graph =
nodes series being merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will a=
lso look at memset patch set.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 li=
kely to be June 7th.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g for a new maintainer for eth_dev<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35D8F4511726136E3D69EA2FC6AAPH3PPF37F43E35D_--
