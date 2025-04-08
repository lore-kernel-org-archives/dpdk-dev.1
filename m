Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06424C369A6
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 18:43:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294B0402B9;
	Tue,  8 Apr 2025 20:43:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 52C654026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 20:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744137779; x=1775673779;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=h5K/upubfU7pjRgSJgDO3ZhziSMSj7UhUek8b0vZkcU=;
 b=VzLgHdg8poU9I4Uky2RYY6gjP3jC7Fj/OLF7Z3q3MmJicWOwDTxnUu07
 FXNbo5KI++c9MelLOcUp40fZHrvhQ9On65Ybd3rhCmnMN3CpGgACiy93a
 jz2hiyzHcusvc/npA6k3z1KLdz7ocM6Kr5qOMNI4RZIjLBzlHVV4SFHPA
 JVFe56Q9VD6dPvCgFYN+V4xw2wx8+bt3pXuza4eal1vw2BGVdw4+c+I20
 QxgV6vDPjMisRDytPuc72roxxTb96eMg/mstp4H9UmC+YewFsB28XSVqm
 mTmuwX4VYvsAsB2MR8I2B3i0FJ9V/wpWPqXzI3hY7n1PLxfo6XJm3ODfk w==;
X-CSE-ConnectionGUID: Y9vxCW1mQoS7HF9rBWdWgQ==
X-CSE-MsgGUID: q7hEa8c5T2mXEM25RxgTdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56569400"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208,217";a="56569400"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 11:42:58 -0700
X-CSE-ConnectionGUID: Z6bbdm/eQpaJSEbOL8EsZg==
X-CSE-MsgGUID: xztcuxQrRdSuc0tZmcxakw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
 d="scan'208,217";a="128221053"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2025 11:42:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 11:42:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 11:42:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 11:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1RrrQbwaQbo15heLnW/NOLlTDiaPCChKBVcJt4DEanC/3JAH8W5yNL2I2cq9qhwnLkoX9DFX7c62DwXxHkYel669clljFjS1n2cKpQtzdca+wGyq4zLVpfMXGyGejPM8yeNZnZY6BlI4gfCT5+DRNAuQiTX3Taz6yO0bnQE8+Pb1zOzMZ+Ia8TJ/T7sWihPxdPOud4FiaObZGi8NxcqdWeyGR2nv0vhg8YnMvE3gpjA9cTcdlD8DByUmwzD1p2yx+0btzpR4vRy8h7ex/JutK8pweAViGmfq3GCvPV9L/qtBcZWopONe/fl07u0KtiOlil9uy8YNicXQRflLzuiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZk8h/diN1Z0mjGIccpTEOxkbEHGfb6awbcLPBhN8Oc=;
 b=C8dcfq4IeT1/PiSuhhalzJzl3ty9T+Gt4d7k3yqyso4E8akm3Tt72nRm95bQsnAyljhPs42ZlzniZAtfRPYjdBBXcsQpzG7W/bWRVx9Li3WIXLNTvhidofh1mva7MraAwuavOItFhBjgQin/kb1ENCjRH4wY+tJ29bySQ1O2UDU0Z3WKH1eOF+ngCNDDhGCJrQRZ6sE8HBC4IIBGJO7+GyyCPwgruU6tUpQpGgDobju4s6Dn+iKfojvT7ooW33Zhms3tSAHPQFloPv1k3Fcspp5WZ/rRwLVes69+hj6SpNNtwxZlMaTcR3NYPPzBhHZ0hYR6mIQP/c0zfHA5irrGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by BL4PR11MB8871.namprd11.prod.outlook.com (2603:10b6:208:5a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 18:42:53 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 18:42:53 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-04-08
Thread-Topic: DPDK Release Status Meeting 2025-04-08
Thread-Index: AduotfIad3KDroPURvijmbbUoaHK/g==
Date: Tue, 8 Apr 2025 18:42:53 +0000
Message-ID: <PH8PR11MB6804B0C915710D106D846852FCB52@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|BL4PR11MB8871:EE_
x-ms-office365-filtering-correlation-id: f89c12e3-4c12-4c2e-613b-08dd76cd2be1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qx8jiMpTrQjt2jAHk9foA3sVZmJHxUbN1w0SeaKIvldJ8lDkL4uzC+E/UPyc?=
 =?us-ascii?Q?PFYf3dJfdQ2ElgVO1IpCnpT8M/BZZ03EYPhMKHtB/vfQ4xpntNdCGO1T0t67?=
 =?us-ascii?Q?nUlctSJvCToqmYst22+OYSeZEFtudrDWdwcJbJxlpruWmW+czKpZVh6L0ok/?=
 =?us-ascii?Q?mknOcxvGRyQVJ0TU97EqQExLC5MW5gpWqnO5OqXOd0HgGXrplkEFaiVOszlt?=
 =?us-ascii?Q?m0hGRmKT4aQYFMJXiBPeMGGori3TiPBndHAXhUzGvnxyMOvVPalSMxavhvGg?=
 =?us-ascii?Q?UX6xIHj5zapQkt4AIFWKf5IIuCAhKynrCeW+y5y1AFMDTOhcyoI3mHEvcSka?=
 =?us-ascii?Q?PaH3fp82i1eqb8DlCK3uQN5KWLECH1N9ErmShNLUAN0ewpD+iaPui12iLdCN?=
 =?us-ascii?Q?MQvWpojZduqTYaASjq0WIXy7IDjeof1OS+LHM0PsvClVlDWKXNGyKhWHatG1?=
 =?us-ascii?Q?Dl6AQ4QjE5QZJLtxbtFZ41NyAST6niuDSNQpvwEFYQ9YWHR56G79Rg4o8MaA?=
 =?us-ascii?Q?oITS/jqinLckqqqT1AAxe2N5xNM+nmqySlA2PTfnlYGld04eOVVbEFfcXjU1?=
 =?us-ascii?Q?/LUsAaK+JATYgJuQuxjHIi42VxASECFICIhwxu+Sj9vP5mDmZmE1wf4ZRdcI?=
 =?us-ascii?Q?+RRvW+amSqgbG1XuEnjLRvAKps7JjVsUmRZ6GO+BpROPlA3T1vEFAXBnEs3J?=
 =?us-ascii?Q?h2iWzSyQw3MNeaYVFPykX1/Hw2HqoQYuqZF5Ruql+DXCVbMedHj7dqMnl/WL?=
 =?us-ascii?Q?QsAheQzOs3TUgMf2uShSPeaWyneJbCeqlBKDuB8u13XUNgAMiA2sKntPX5f/?=
 =?us-ascii?Q?fgD0TQaZekxqbGYRh/MvPoXQ8UuSFI3GoFIl6RUZpgApcm1dGI9fN4EW119i?=
 =?us-ascii?Q?PR/t8GvbmpBMbDiWvBF19VzyKaREhiEEqVRwI5HNNicHfkD1oM+Gfpwx5JOZ?=
 =?us-ascii?Q?tyojUEmosam5FSHExhMxO9LzbQye54pX4Spj63sGuvO5jsvpFOgP4UuzCFF4?=
 =?us-ascii?Q?rM7ggaDzIMtWRhJH+70FsukgRqaWxR1MwFcF4BYGHo4ykN7qskKB7hkZdI8q?=
 =?us-ascii?Q?a+F9QxGAOe9aYciRIcgEnPBk2k0FiLBY64b7JbEgYV4x7Qa13BgkgyJ4JJee?=
 =?us-ascii?Q?dBAH+A3hzF4k4EozVkOBOCzQey9HqDGCGkU0EkEWCWxX0PhNsY2/gsqT67d1?=
 =?us-ascii?Q?izsrFCZaGy6elhMlTYExXkYTift1NOAl3PlGyHzv8PH8cXPetwurQogHPQ8m?=
 =?us-ascii?Q?Wu1pxlqtlIRLaBzMBur5oV1LdB9DnIsGLTUPqrmCX7TqkXxQE8bTj2RCN+fu?=
 =?us-ascii?Q?OFG0xXAirglFosRA53Dfal2VAwU5egHaPNbWq/FI53FQLvwCtrBAvsMwLuMr?=
 =?us-ascii?Q?z0YvCHGiY5F+xC0hI9gnyLbngL/OQq5byjmrf2oJirrtYZKZSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zsO/yPGx/rvQGUlF81Gd5lxrqRuLDMh8TOHco6x4rfwtvllUDWQiSVpWFwL9?=
 =?us-ascii?Q?l38NLYU6JrbwtQQYY24e8Yg4l0WOQ5GYVKF5xFPQnXbW+3JDx19LdWaXDHk8?=
 =?us-ascii?Q?MLHxTJwOeViLGA3LdkcuXiHiUGztXA3rJkm9lrC/T8Ophcq5b8McNuER7SCA?=
 =?us-ascii?Q?svsUpznvylSOFFc7Ncz8M+IxB+XCwi3ItqUqvHQRP/fjOjytwf9KbREVIl7U?=
 =?us-ascii?Q?k7XFkiWrq7VnXqNy4xfvwAv/Pcw4uaONo0NuiJHROOQhmt4lXXug0w1FbIH2?=
 =?us-ascii?Q?KOQ57MArW5s99xTeahCQeJwvgGcAzmAKI9qfAD4yivPQkGNzMSjxlZ/e61D8?=
 =?us-ascii?Q?jtHbwWDRRllljqC0AUHnaN0XUt/8o1JX27ye1vpg6TNQF69vox3WPEILk2RZ?=
 =?us-ascii?Q?70xe3FjHG8BfMGhw0TAFR2+mJfPXA+Hjd6D5j91PcMfv0pz1ny5uDgHXaFBE?=
 =?us-ascii?Q?K+vHbeVHmhznurQQ+UpaAvrBLqvsifbxwcvF9MRfQLfKFok+ZuRyyKEQEOwI?=
 =?us-ascii?Q?22eKhVQ3vlcyTxEWQ7h14xgz3+f7whUSlckH+wafkvu1sAyTxvwGIvWtkoRU?=
 =?us-ascii?Q?6W281YydReOqLpl8sTVlIyL0PhaC8wuPOH7vAaoRkDy+94UQA1yFbKgGIuz5?=
 =?us-ascii?Q?uYkR3rn/2KTZKI68Zc5dz9oslKSrCOh20zhipf0aSVpzW9J4dl0xIV0sGjRi?=
 =?us-ascii?Q?VY8Z783JzTKU9V52XMgO+wlW6F2C63IRs46cdN3q+kF6Be/A7X6Y14tYNrEt?=
 =?us-ascii?Q?ULyD6GfHwBr+03MiEOe4diF47mCw6xuMngduHw7somIqkaPrPpD05M0KOf4c?=
 =?us-ascii?Q?bvxbQjBTqOvoozf+Z0gX0iehAuyRmxlyjZOTgdywei+u/ni7QCSpNNDZsXWV?=
 =?us-ascii?Q?ow6HgZ6owjwqDYxiDrxpmPDaD45m4uTXrAhvN48fV4uM6Wky87Q0syaUIrq1?=
 =?us-ascii?Q?ClpmcBY8KtCzvkt3NvJkg/FaWZu6WPBvRDaOXTPzcn6Vs1LCWCf3BYPv5bGk?=
 =?us-ascii?Q?tFsoFifGFdmn1S5HccQoY6ae+wyw9yAlhpsEP3aF/OGL0zDmqgOM7GyhpMFQ?=
 =?us-ascii?Q?I/ioEb/h/LKKpT4jSLz4uMjajkoV6L97OY7UEJirURz5fd7jECiv2wZB6dMm?=
 =?us-ascii?Q?4Ogc2xZAm0IXsN8/YDxnJ4Ula7ukonpAznmSBruJiLUb1ODQE5NY5gB3yFlh?=
 =?us-ascii?Q?zNoKip8raa03dk9yLN+RmBXv2g+NYVxUsU2dPa/zd27ai2bAlmH+MscWj7Qw?=
 =?us-ascii?Q?Cv35NlDn6LZTXNFnEo6UBOKEnMgGG0JPK9m43kUX5wsK4FdFSLaIPU960szq?=
 =?us-ascii?Q?x852fadog3KSDMgsAaOlh+/BNtMGGwg83TjcjNLrVJ1fcZ9LISUrzujTKkKz?=
 =?us-ascii?Q?rqVGO6WeN08N1ytjrVZVYnKHECPP5a2+7N/FPe+oLB4IHyCB4XkAprNab+Xv?=
 =?us-ascii?Q?aS03SOzxOfCku+OEknu+oUQgmE7w6i8S5IQYQ3Uffg+jxy/FZHxiFp0TYe1X?=
 =?us-ascii?Q?LDcxCA6TnUoyvPDo6u9jj9ciPIft6MkNEF0wiwiK9T9IX4L04AnHJfMQQp57?=
 =?us-ascii?Q?RpalKmTrCZNp9eOCAuSf/Mq+uGPb0Oll75UfAj8P?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB6804B0C915710D106D846852FCB52PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89c12e3-4c12-4c2e-613b-08dd76cd2be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 18:42:53.2507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XrR7fIMDwpV8Lq+rLgNH0N92IkDPCAJFhCTFt0hLXr8Ix30pWhs9gN9WQI/O3R7CBPTHqr5VaTEmK5RnsTm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8871
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

--_000_PH8PR11MB6804B0C915710D106D846852FCB52PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-04-08
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
* Debian
* Intel
* Marvell
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 27.03:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 30 May 2025
- PMD features freeze (-rc2): 20 June 2025
- Builtin applications features freeze (-rc3): 27 June 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * ~50 patches pending and around 30 waiting for review.

* next-net-intel
  * ~12 patches for review and merge.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * No updates this week.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * No patches at the moment.

* next-virtio
  * 1 fix and some patch series pending.

* next-crypto
  * 15 patches pending.
  * New crypto driver for ZTE

* next-dts
  * 20+ patches.

* main
  * Merged symbol export series. This will affect all patches
    that aren't merged yet and which touch the version map files.
    Please rebase your patches and resubmit. David Marchand
    can help.
  * Patch reviews ongoing.


Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


LTS
---

Backporting in progress. Current LTS versions:

* 24.11.2
* 23.11.3
* 22.11.7

Test results are coming in. Still waiting for some validation.

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
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH8PR11MB6804B0C915710D106D846852FCB52PH8PR11MB6804namp_
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
meeting minutes 2025-04-08<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian <o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
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
re the proposed working dates for 27.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 30 May 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 20 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 27 June 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~50 pa=
tches pending and around 30 waiting for review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~12 pa=
tches for review and merge.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No pat=
ches at the moment.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 fix =
and some patch series pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 15 pat=
ches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New cr=
ypto driver for ZTE
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 symbol export series. This will affect all patches<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; that aren't merged yet and which touch the version map files.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; Please rebase your patches and resubmit. David Marchand<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; can help.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patch =
reviews ongoing.
<o:p></o:p></span></p>
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
progress. Current LTS versions:<o:p></o:p></span></p>
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
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH8PR11MB6804B0C915710D106D846852FCB52PH8PR11MB6804namp_--
