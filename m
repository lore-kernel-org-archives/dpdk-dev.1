Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A042C3ABCC
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 14:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D9A64026C;
	Tue, 13 May 2025 16:04:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 12AD24025F
 for <dev@dpdk.org>; Tue, 13 May 2025 16:04:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747145094; x=1778681094;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=f90+chVaGH4NPxaK+EVQPBGo/ODnPNfcRdLQJ5U7uGQ=;
 b=DLohxadXSCBh5neJRGQo4/uw844VQU1hUdQRzyHiGeZLqLot/YwlfF6S
 HRuFooVx+5igLBQC+HK2yWHF8ubXcZldyIIh5mJSCGV7B/pvz3v5TCr2O
 4jeOZQ5YC9rxdcD+PHK2Lxd+K91Zi5sTN3hl0uWnj1nvwrq+hENTQmE5L
 f8v5SMVnN1Y573cyLg+M3aSTPQtkUzo3r0kscjFRhYqAyE0mvZmyApj1M
 3yBXb9AHe2uB9uZFUXP9tbOm2k1ZjvGNe0BZeWWCHLLGzqcgoGGnoy3Tr
 nbcbU3Qexpkm4Cy81US4FIpdTIqJqWaHYaPz7rOQyhiR01RtsUhTcLBFm A==;
X-CSE-ConnectionGUID: JS9vg1SsQ9eS/CdXH1atpg==
X-CSE-MsgGUID: zoQmGSA+QfyIUCkueNFYrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49156852"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208,217";a="49156852"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 07:04:52 -0700
X-CSE-ConnectionGUID: KxWVlPfhTvybVRhyUFwvaw==
X-CSE-MsgGUID: QLYtHth5Qkuo6yBX9RkvdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
 d="scan'208,217";a="141765561"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 07:04:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 07:04:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 07:04:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 07:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8+l21tPZKY+c/eDYn+geC9Ac4dHA5Pq0ygQBa8KSWS+2G+BdrohKUxPxvBlG1YCJdABqnbwidl1JWsCUDJidJ+ozPHCeygOc5XVczuOGOhDrbamllEMWptub7q3Eh0AUwvXIdv13yOtr272ha4/7XZmB5mQJw/fKXhStlAtt6S/CTKUk8PoUTWTasfzu8QRpVtyv43lGoFsmxYAK9VRr/T+9Z84Jeucr6BQSpBSjl+7cETgeEw5sBZFe+ZCC/1KcM+11rUvmEvJwLu+tO9YRMjRIC/wWgIlFOAYx7tnS5fvpgJ1j4T9JWYJKxjlgxWLUI/NG5wYssZ/zHUP+YOxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCeZ+ROITAvjsIOV/bl7gLHYUNKRXSzVDhlpOfrDgR0=;
 b=x1P3aJ6ZBjcRh/96gwXPntfnw6czOXM2qWy8jSIe5i59fZ6vLn/ekd9p8EaUWKKIWXMe0k/ULKFPTczRIF95novL8zGVH8gJq0W2xSjl2S/kCzEWkF8pGA6lkCNR1mRKyFhbEnONMJ0J0lS2zWw5jG0TqIJo9HjybhBHYElmUppU9np122ioM3ggCcZrDaR5CH1t3BtX42k6Eg7UFRTCFw9AmzGv77bl0VdgPY5stPOpWH5KFgpi9kIzUPASa5ZIDVJGiNwbQDdSjq/3tCqeu9fxgq0IOmdCepfxcsmmERiiE0psPyfasLWFNLjbbweTgfWPO9m1h62bQwwjUyL96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 14:04:48 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 14:04:48 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-05-13
Thread-Topic: DPDK Release Status Meeting 2025-05-13
Thread-Index: AdvED+Ynnz19mtlhTcOV56KV2k9QAQ==
Date: Tue, 13 May 2025 14:04:48 +0000
Message-ID: <PH8PR11MB680452F371ABF20C60D15F5BFC96A@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|MN0PR11MB6302:EE_
x-ms-office365-filtering-correlation-id: 870bd9ff-2bee-499d-2a2d-08dd92271f70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?i+2n5VuV9uodu1J1rhhkiaIxWCm+bwjyjcfmq3tGAp6fid6gLqAV/BJLR92r?=
 =?us-ascii?Q?CAFTLRe42D+DokjUIoRpOvfbDf8HBFYL62T7tm0gjMH3hTE5nj2bPL1mlurB?=
 =?us-ascii?Q?cJV2SFlVAPM168qKPjO2enJkplk1MJ03Kga3ylsMaeeK+Py2MNyFaGnS7Zrl?=
 =?us-ascii?Q?sWI++m3ajdZtU/rI+Lx1X+ojx2Yk7/SUtOzzMfbpkkJgTvZ0kHLnlJg9B2Av?=
 =?us-ascii?Q?KmzZbaOI5Im4zjCL64LkhuTbHhkPC1f1E4cWuFzpZ6EH9AxZX7qgEp09/QC3?=
 =?us-ascii?Q?AHvR5VRQdie4qnQcGviB6SqvipjJbjESmtoUoFj8jZq2nhuCe2uGGca8lExV?=
 =?us-ascii?Q?Bdv3LIYRSK+Q1m1oDcp6eKhx8FY8NeNr8kfS0cufYSxc0/S/d21cXO5P35hn?=
 =?us-ascii?Q?Y1POK2wNDmXL2eMTyP8algq3mPfHCOWMf2rMAT6bdIl5wOMj/EzWwRAjqrP3?=
 =?us-ascii?Q?xJ1hRoO41zUlknFapB6Wh1suIu0uHIP/g3LjZ7JSRWjixtLddtI/5LsAQ/Zd?=
 =?us-ascii?Q?ovkTB55THJl9d+KAXD9gTHZtaFtEnYr2VTQN5NO7kTGEOXs3oGVo9f/F0sSb?=
 =?us-ascii?Q?Ug0/KQG3jTiRsptT0L2qEnJfkOEUvc2cc9N1DVfO1UXT0HpcSdUv4QnJ2awF?=
 =?us-ascii?Q?Dnrvj5/vTqsJ6HyO7tPUMwHQub1vudoNUIi/FKUBN2UMnzxYi2RLaTNDHgML?=
 =?us-ascii?Q?OeysrDcBnBi/XMKtMjdr3CQtVZUJqahyJEGJg/EdPb9JmeIfvlnlOgbzeCyr?=
 =?us-ascii?Q?2HiW+TIK5P0UvYd6SgnS0ZAsQ/FMKFazA41CJMeqknI/xu4inxZoZWr01WaU?=
 =?us-ascii?Q?335/LJBUgS3oLTsHdrpOjs3UQnx1E4AEImUUGSZ96k8JZxKWEWogOizXKjT2?=
 =?us-ascii?Q?Wx3aA3/kQ6lHUJ2cCX+xfuaRDNxIUlEuO6ljAV7iPCkLI7MXKQIXjELx7iUt?=
 =?us-ascii?Q?YIK21JWtiG32R2ti1+41GgyW0XBCjvyeCPKq0G7I0WJ3qy6P2BkIGHXDZZLF?=
 =?us-ascii?Q?ai4tJmdMq42r36T8TsPG2AWIDBgIWvYCy/tWKzOUWKeI2K38bmwowFr3Peyd?=
 =?us-ascii?Q?U/xvFrgizUDcAkOqerS86SHYg/iqnuoY6usC7RtjUbkXUnioZOUK9xydFejn?=
 =?us-ascii?Q?ylHCof/w73P7QHuC4vVYRhMzcVtqIeqz47oT3vOFq9nrX8sjsbft8N2wH7Cr?=
 =?us-ascii?Q?Ig/JMUKfcN+v0Pb+MCcRtLmjKpGv5bnEkcnZr5qNWDBlq50kKjGnunkoFqoy?=
 =?us-ascii?Q?VJUjhvtvDupFHglO4TCw7z0e5I0tEY8WD9Y0xcAuuzxx92E9c8H7c4uBMpeQ?=
 =?us-ascii?Q?juNj/W4CvlyLfNG3taqxYnMjb6WexkXmDkPUgTnvs4GrssydkinFYGqVHL+B?=
 =?us-ascii?Q?a+GPJYyKdOAnLMaxCrnKDuEvx7gWnnojzbTU+O/wyQZFfnTgiLcX85AIHUg6?=
 =?us-ascii?Q?nLJl6LKajJLAWUxl3+eXKDBlD9msbkxr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3PWbZP6j05yuGzgv0xnizwj1pqWKBQCuBNyDOaDdcz6Qbuo+ASqVcoNPdmFP?=
 =?us-ascii?Q?A4lrEjZr6q/Amwvli49f4HVNfOkKgpF9oDQ22t/U1RS2CiigIKqPWw7j2Zcw?=
 =?us-ascii?Q?NfI4jLMSI0Pp3WEaaissmmlgJhaMe3TWSe4d6opXndnEAnsjvYHHACeP7y3M?=
 =?us-ascii?Q?d13VZk+6xSXdHnqRmiddvpihFWqD/JW+Ja3YHdLhDIWOZwdgSXZng4tSkG9P?=
 =?us-ascii?Q?W0kQxIExS/mpQ/eRwnH2Zie/tzrnkA8REAW3/FG7Ve30GXrv2SgGhieIAPfE?=
 =?us-ascii?Q?qi24QBl8ScP8DpiXSh2tUGxkG882SSQA+SPiSabhotC6y6GGHppeGhRfCaI5?=
 =?us-ascii?Q?4T2V4INFqU6Ueir4pSsbsUo/TniHacZd5XTx34heWJNjKVZbUe94QfDw3XU9?=
 =?us-ascii?Q?nsSKYXMI11m/CXTJSdVGrkkI9Mz87nV1y/YqLfA+ABMBtW96G0jY47GCALZt?=
 =?us-ascii?Q?vk6QT/kbbZcXDctnytNobekucEv9aUKBYF31bnz6LQamJiM6TqRtJcmyTd8O?=
 =?us-ascii?Q?r5nYLk3LNyY1RVjTKXrqoiwU4+GklacoT0BAn2l2bGMgZKIdvQEFSub3ZRF/?=
 =?us-ascii?Q?T3T0mMv4jufSw9rIL0PEqrES/GcFiyhh4M7jL3genRvrS6wG/z5qUvwldWVi?=
 =?us-ascii?Q?0g3ppLEbrtsmCtO3RRm8Hdog7z9F2Jx+rVWsH418qW6vQMDsmRi5gsp9z7ha?=
 =?us-ascii?Q?gdF6d2i5jqmMhDnzm2otnhQ0ZgiLtTfWFEHhuc+B0Yz0coSaVPuUWTKiUwen?=
 =?us-ascii?Q?aG8mWQNJ6SqcoW26VfU1R5pRjvEKEsBn4oGUyMv/DU/W8bXNnhlELxtsB1rH?=
 =?us-ascii?Q?Et12FqLBLJ4z375t0VY4yLEP1SKGELvHUIJgBuhXYHjoDG+XIFX/YwlQUmM6?=
 =?us-ascii?Q?Wws50rPZ4zAYh27XJmXtW/7xtn+SKLiC78os4af/xd8edhKH+LliJF+pO2S/?=
 =?us-ascii?Q?mzMSmlQ+m8P0p17ayD9OfJc0gw83LTfy5yheIW8YHR1AvOa2jwJgrW7tzCif?=
 =?us-ascii?Q?PwnRGhnEQ3LzODhyTdaf2p4fcGcS7tbA/KTXM5VaCRPD6iRqz+XmP6hFdYyX?=
 =?us-ascii?Q?b86J16Wn3A2yGs5H7ADvA8RSdRexoKlFasD/jUmDSzOfn2InhFwa/CZbqqRl?=
 =?us-ascii?Q?27hGPHI4UM1wN43MpLsgpFTMPUVgAYhtw+WoM1tKQEe8tyh1JgqmEi96PkKf?=
 =?us-ascii?Q?8jOYkatJmtSBllD5nBtmh9FWtACD7/+HOkoJhc9AasizMt6f3XkO2Ww/cZrp?=
 =?us-ascii?Q?ydFUbckI7rg4vy3YlURSnrErrjPy+APU6vl61UQqRLD8x3wKIN0wEnB1i9Z+?=
 =?us-ascii?Q?tofDeRe/N7GGN/yji8Qt8y6UFExG3xTtr5CSHrVsdWVQrz6jrYLUPBufnhO0?=
 =?us-ascii?Q?o0/ATgQfJ81j0K3EnygCvemvWc/5G7Mzj3J+2QYUNHSvdxlrzhUbDEcvSk2Y?=
 =?us-ascii?Q?dMFvwD9NMzc9ljaZYavq9YSOnuXhDRuBPKJZdK48QLJ12DBP868qiiqqaKVS?=
 =?us-ascii?Q?uCtNGUFm7EfguJq3BlMZtyVhaj1tgCNpJzGaDAY4161KnmvLkjS8DHnauCyY?=
 =?us-ascii?Q?upaFJJ2XqlstY+JsZiRH2svRl2F5O57vdMPQJMq7?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB680452F371ABF20C60D15F5BFC96APH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870bd9ff-2bee-499d-2a2d-08dd92271f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 14:04:48.5089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDn6bUdPvJX24qc/5TW3hu8x4JRN3wQCNZcmYr6NvmbPHTpkkxizLjFf5g+BhTnj4tpX38fgal1JFgV67LqDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
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

--_000_PH8PR11MB680452F371ABF20C60D15F5BFC96APH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-05-13
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

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 30 May 2025 - Moving to June 4
- PMD features freeze (-rc2): 20 June 2025 - Moving to 25
- Builtin applications features freeze (-rc3): 27 June 2025 - Moving to Jul=
y 2
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * No updates this week.

* next-net-intel
  * Some patches waiting to be merged.
    Ready for pull.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches waiting to be merged.
    Ready for pull.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * 1 patch ready for pull.

* next-virtio
  * 1 patch ready for pull.

* next-crypto
  * Started reviewing patches for this cycle.
  * 28 patches in backlog.
  * New crypto driver for ZTE
  * New Algorithm: Snow 5G

* next-dts
  * 6 series ready for merge. They just need to reviews.

* main
  * Some fixes merged.
  * Patches from Microsoft for EAL and memory.

  * The following milestone dates will move by a few days:
    - (-rc1): 30 May  2025 - Moving to 4  June
    - (-rc2): 20 June 2025 - Moving to 25 June
    - (-rc3): 27 June 2025 - Moving to 2  July




Other
-----
  - None.

LTS
---

Testing in progress. Released LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8

Test results are coming in. Still waiting for some validation.

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


--_000_PH8PR11MB680452F371ABF20C60D15F5BFC96APH8PR11MB6804namp_
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
meeting minutes 2025-05-13<o:p></o:p></span></p>
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
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 30 May 2025 - Moving to June 4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 20 June 2025 - Moving to 25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 27 June 2025 - Moving to July 2<o:p></o:p><=
/span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches waiting to be merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; Ready for pull.<o:p></o:p></span></p>
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
atches waiting to be merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; Ready for pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 patc=
h ready for pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 patc=
h ready for pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Starte=
d reviewing patches for this cycle.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 28 pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New cr=
ypto driver for ZTE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New Al=
gorithm: Snow 5G<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 6 seri=
es ready for merge. They just need to reviews.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s from Microsoft for EAL and memory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * The fo=
llowing milestone dates will move by a few days:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - (-rc1): 30 May&nbsp; 2025 - Moving to 4&nbsp; June<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - (-rc2): 20 June 2025 - Moving to 25 June<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - (-rc3): 27 June 2025 - Moving to 2&nbsp; July<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Testing in prog=
ress. Released LTS versions:<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Test results ar=
e coming in. Still waiting for some validation.<o:p></o:p></span></p>
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

--_000_PH8PR11MB680452F371ABF20C60D15F5BFC96APH8PR11MB6804namp_--
