Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72239CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 13:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 736CB402B5;
	Tue,  2 Sep 2025 15:44:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 660DE402B3
 for <dev@dpdk.org>; Tue,  2 Sep 2025 15:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756820678; x=1788356678;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=aaeAuFicGTrJyWZWdIx6bepkcjvsYZA2UapkZomYfOQ=;
 b=nAlvLU6f4vrIDxzKsO+4vrtuRKJO4YjkdxmeRkHjmHtgufhquZA1JbWL
 Htxw2t169/vZsfd+fV19cfCXMr4lfIZBUhO2oLWn012xtwMmtXOhVKrJP
 yWVAznk+BJZpMpctsvUqMp467moRDninAxN0svX+l4ljDmADpsKGFRajt
 XPgXPKPb4JpAynDsKlgVLx+jchMNGWkb16106UpG5yiDWydRmAIDrpp9U
 nu1/UOQVSbJ1xtGiEkFSRY7Ffa4kyM5oe7h4dMuXXd0AK3nT4UNHMaoyz
 eFRf+u+cT5Cr2I4w1OnJlXTKqyTu0S7xUcxv2POCJ4YTY1nZp+09J5V3a w==;
X-CSE-ConnectionGUID: gN4TyQcBR32Zh5aArI2YFw==
X-CSE-MsgGUID: uCBqu69MTlqy1+IFwW5cUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59163544"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208,217";a="59163544"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 06:44:36 -0700
X-CSE-ConnectionGUID: 2N8pth+1TOqGBM3y1rDNig==
X-CSE-MsgGUID: k0d71okkSmOVwoX3miQiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
 d="scan'208,217";a="171441291"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 06:44:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 06:44:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 06:44:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 06:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdaPazlNWWSHmPzgEwiGQ+0AL93JChK5LdGF2Ex7jkhla7tKw93prc0JmKor1CvaeooUWtn6iRQYG/2YcLtLbH5T0RaSjPQLpvBphivp5u17dN4uDdEABmutPPCcF6oTwya+8eTghxT76JrpS7WOuPgoHRoy/JNScr/TLJtauL3jMEVPO9qaA+ZP1CSD3o6tTOQGUK0CfgjanTj49y98+fH2HpivKMMAU8SX4GjVJ9d45GM+ROOTsqTZnxSbNoRf05t3vY9hC/1imaLHCw6GVx6Ahfd8Bn61m/WTnaC2n1Mf/8npFGmGVyduYLwnaSnbigthYbqJSEDQa3RLAOAvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neftH2+Ruk/ELYtvWeanMSZHD3CgizorGfhsx/jyucc=;
 b=v4NDtzn/UhH2JCMvnlHTEFn//CqooQ9FHmlYYRZafmu5N0AYDyB3ERkdv1e3ictCQ806DWbkAhBgymedw7iU/nIzdCr0oLPevv6MYIFVPBWyCMliBnI7IJDoEFJP/r7EcNa/cpKe4EUiZoU2Wl5r1Pn22R+TsuZwDGl/6duyaJXQ7wHeJnplJAZbsw5CzFrqvZgwAgWT+z7os6jcYN9pkkUMgWbFWgZqpcuMRroX3/mnAS0wOumQJoHbVFArU+nyLUnpTnspFwlLwx2/8kDI/MRJy2XRh2ZPQ1Dur05d+u9T1QYiHE53Re2vNMthF6aCJFjaqh2v/FF/Hfhw2EMEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA1PR11MB6193.namprd11.prod.outlook.com
 (2603:10b6:208:3eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:44:31 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 13:44:31 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-09-02
Thread-Topic: DPDK Release Status Meeting 2025-09-02
Thread-Index: AdwcD66c5MpWlVOYRVqxA+mTt7y7AQ==
Date: Tue, 2 Sep 2025 13:44:31 +0000
Message-ID: <PH3PPF37F43E35D2D97018619B8EA9EE55DFC06A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA1PR11MB6193:EE_
x-ms-office365-filtering-correlation-id: fa7e3a5e-8786-492d-f409-08ddea26d826
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aLVOSW7QShbLBQFRuBo4CJhCKtysUsn8lUVZxH6idyk52uuOi/tccrDAiqG9?=
 =?us-ascii?Q?9zjxFxm5QHdR67d0FMFUZjN7HNhysjaXN8TFMesuxmHl6CHHsia9iuErS5J1?=
 =?us-ascii?Q?fKnMtTE2KmWmK89G3V9KlAx1XNVwjf8HWH6qMsATF4J+fYq5U+0G6C8akCWO?=
 =?us-ascii?Q?pmJo+AnuLcyoOcI/v+zKP9CplyoC4iabya890pDA3PssLxnu8aTT4nrLEfuV?=
 =?us-ascii?Q?HMOhGr1BWSjhIJV0OEjhPM7j3zn/yS382LC8Wzz1348Qh9WTV+W0KHX0Obgt?=
 =?us-ascii?Q?jXXIMD93IOzPCE4+XWqv4ui7/KgjK1dJx1jnN6ZR6coIpdFDLhuQ5i34ltRA?=
 =?us-ascii?Q?F2HMfswt3L/Nm3unvXnGVVTsThZoloF6MiU1AhhaYB5S6a1cLeN0U7ZrxXmK?=
 =?us-ascii?Q?34+fmOWDtqJOr/goXVQJ3Jon1+xRBMcp7slg6BGqDoeHAPUQFAu+GbaHvikA?=
 =?us-ascii?Q?ixFpTfxsjLJIZu1UpioeLFrpDjTzenPgt1+5jpDMbIvr0KD4yKBZr4fL0Vil?=
 =?us-ascii?Q?FgbTiPtngD0O+021oHmCDnCNPjUghacL5gCMPiaL8/xY+HPd4jcs7cwZUUIv?=
 =?us-ascii?Q?2mc5Zz9gW86g5ZV1fy0ewQmxhxdvjBps6Qu6aAqIuwjvadGnSXzQ1PT3x8xW?=
 =?us-ascii?Q?xCk+prRNMlyXbj932UNJNjqhMSc0G3tpAAnutPt/th5JEiOTDpZHF1WwxTlH?=
 =?us-ascii?Q?mu6pybpYVr+fJLl6zZawlbn8vTmpxH+YEd+Lz5C1Yn+lJALDqbeEW42FsyWD?=
 =?us-ascii?Q?IAvsoJA8wzGdXPYWUcm1miAm2u95PY9oyBgRoYzrz5QE5ZUA7dG0UcfkmBBD?=
 =?us-ascii?Q?djoQ7CZncrZqjnm0PV52wZbHx0HLJxUh802JkMyixcdRGXrVhJfsbZYSpbkc?=
 =?us-ascii?Q?/AE5x1mPNGY5FP9dWqw63242RAHgdo05bmQDMUC60B++FAN7DNx0aTkpOSNX?=
 =?us-ascii?Q?eP/HiU111ayufq0Hs4GMxDJCWIaYVmZQuZylKV2ylKqcZCyVPCbtgN0sqyCq?=
 =?us-ascii?Q?9N4+BBBfUW5IhlH5xuolImSrNtfO1JzzAY6Ll7k8JcVAG7vt2D3/OrmxhaOv?=
 =?us-ascii?Q?M7kzSIAbEY3fHY+pyB8TRkk+TMz3IowhqKWRI/lQYS899LdwsHr4qDPzIiDF?=
 =?us-ascii?Q?pbfl1cFKCNU6Q4dKPPLhOyN/vhqzjYn6jCD3qOdxMtbxjEaZQYPFUqyzRtpC?=
 =?us-ascii?Q?iPQMxqOonTJZakxsBvwBo13Odl+iedcZBkuBaxa6tOnBLQrhEHZXiBm0yEtD?=
 =?us-ascii?Q?hdYgcETQA60T3xjk1H/M9pushe7/Gof+2t3x1wi+cWadKKVQxhe1fgwL4Sur?=
 =?us-ascii?Q?WamfIZnTXeIP6QNbMAAupEFkMAizyAxSgT9BtTl09Qtp5C1ipHIk886/rW53?=
 =?us-ascii?Q?KVgxxpVG4ctlRD8IX1oHYMb2lOdCy3CMYcpjZhtghNUdiVYcmws/Tk0fCLl3?=
 =?us-ascii?Q?tEFRY/f8op0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90tCefWf0gxZk+zsOknWULz/FcjS6WUTzeSv/pIfqDov5d9Vm5gv+0of7Plg?=
 =?us-ascii?Q?JhQ/KLhbuXXa6BAx7yNehhJiPg7pQPoB7BbppTmDhtslh1CReZJFektRrTfg?=
 =?us-ascii?Q?Zwr+85x2qal5SlCXYAze3W896RkLnLIDxzUgYVNlHnFRD59/bFwyt6MbXhlh?=
 =?us-ascii?Q?hE2Qvx7d5Oqe+BM6B82U5UjskhmHKhzPIeho8OXd2Y6EcVIdvVbHM3b8/+hw?=
 =?us-ascii?Q?BeWp6uY5JNreREzaFSm9t2AkrcGj1SREL4DiWwKZPWvmyZV4R1bPPgJ3mSWh?=
 =?us-ascii?Q?w+aMzK4KF8pCAETHgZkxJ9JA6ARFISFOTIhAOWLb8vUAAUtvJpn3oE3rOA6/?=
 =?us-ascii?Q?5xwKFHhtwQUlewwE2ljkSfSJoKw7Ockfl6XenIsUloQ9aHeW0F7BOKHPVZv6?=
 =?us-ascii?Q?/f37qgOae8PDVYPrm39UEiO9Nd3j5xfJIrQxwrlaZf3DKHh2goQ0ew6x6AtS?=
 =?us-ascii?Q?ddxyyKCY9Vgnzt2lXjIG8okGwGQf0jgVooI1FC+C+vK1+UGxdbm/3yMfBQaX?=
 =?us-ascii?Q?6ZLIYtJcQ+Z2zaUYOziRzE+xIgpRpQtKHEbMLCaDoErW978J1J7r8IGt2Ui+?=
 =?us-ascii?Q?FGd7B0t/B3cRxFOoyhPtNN77X/uOSNfkgOazrRGs3QRbTN5L2nSQKnPs2AIF?=
 =?us-ascii?Q?p+2EccW3uxcQgOybvSs/mesYjnD9m4jbb9hmHESW2BZaYmBhn9NzpJV9LosM?=
 =?us-ascii?Q?2HfiJxYNAohcktpswX2jCEBJqwpCJdejlBiK/vTikLvdRnw8g0Uo+ZixljnH?=
 =?us-ascii?Q?m7v+0NvlZIPvApZGsOhpGVPnBs4d5yK2gS8N9L9ZGDg85FEgvdDXn3YnqTVj?=
 =?us-ascii?Q?0xZnqcKECqtffK1IELnklfV//N29scwGK1R1HPuyhRYpFXX+PARcF603becs?=
 =?us-ascii?Q?3jArD1UxKAU1FAVDdnVzFKETB6zjsVP1LaxwbjxJnnC6JGS6Pmla6atzPRUw?=
 =?us-ascii?Q?UXk3Zf445jBcPvZb+sdUnsw25zZTxAZDH8oYyPUQuKnjrMw+7Xyb7ABteFQk?=
 =?us-ascii?Q?yJswSTqGNJfXY45Uuo65kkwlcNFCdQJxXpFKfUvSBdNpuGGEMyOBKSLWmKmB?=
 =?us-ascii?Q?TUeWhF7mEB/go0a91nUqZI6rz9SHvkHJtvhnsslUrdNJre6xHsfrZi7E2ZsJ?=
 =?us-ascii?Q?uIXbAC5Zxzzo0NwYjM5Wn3SkFgLT6192vXXIA5itnlb+dQ/6EFvYuPCH9EEG?=
 =?us-ascii?Q?K0nnuOQDLbG3N7kXl6W9V5VIrJFefAIJPRupQq6H+FbrVSHEZKKkyh0b0jHS?=
 =?us-ascii?Q?mYSdDNNvBzSfv+wu/tPM5D4matO6vyThFOpYUBsm8o0G68R3TnuEbUbIM5oJ?=
 =?us-ascii?Q?rusMt1w3ZLVGH77GBJb6r25m7yYIiptTQgq3MCAZ9FDn/lY4HqOKBl1KBpbI?=
 =?us-ascii?Q?34AMRTkpayIhe3fO6Ena5GXdKThNZLUf8tHgIkxEAUXI61ChRFUKzgq7vBXk?=
 =?us-ascii?Q?WmRITGDJ/1NQst52qY++oq/L6yq7XY+GTmRFqhpLXMuw70YtE80Fqein7TPf?=
 =?us-ascii?Q?OwOZb0pRJ7iJz2baoiOlM4bVtHfYMzf380DyTkGpJiF8wwUjAUujlFItQYI7?=
 =?us-ascii?Q?TGzH7seuKo2oU/C7AcptusRxdQ1xuo/P5dmSNkbx?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D2D97018619B8EA9EE55DFC06APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e3a5e-8786-492d-f409-08ddea26d826
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 13:44:31.2066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFVA9DRv4yixSyYzo/G1TAjw2tmNsTRh30VOzfOhI77KHJw7Uz3hwneC5zd2XbwNWEfdE3EUayOW2RvoDH/pwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
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

--_000_PH3PPF37F43E35D2D97018619B8EA9EE55DFC06APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-09-02
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
  * Some patches in the backlog to merge.

* next-net-intel
  * 20+ patches applied and ~15 in the backlog.

* next-net-mlx
  * Some patches ready for merge.

* next-net-mvl
  * 10 patches in the backlog for merge.

* next-eventdev
  * 10 patches in the backlog for merge.

* next-baseband
  * Some patches in backlog.

* next-virtio
  * 1 series for SPDK.
  * New vhost-user functionality related to memory hot-plug.

* next-crypto
  * 20 patches in the backlog.
  * Nothing merged on tree yet.

* next-dts
  * Some patches merged this week.

* main
  * Cleanups merged.
  * Merged some patches for Windows applications.
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


--_000_PH3PPF37F43E35D2D97018619B8EA9EE55DFC06APH3PPF37F43E35D_
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
meeting minutes 2025-09-02<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches in the backlog to merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches applied and ~15 in the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches ready for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 10 pat=
ches in the backlog for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 10 pat=
ches in the backlog for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es for SPDK.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New vh=
ost-user functionality related to memory hot-plug.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20 pat=
ches in the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Nothin=
g merged on tree yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Cleanu=
ps merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 some patches for Windows applications.<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35D2D97018619B8EA9EE55DFC06APH3PPF37F43E35D_--
