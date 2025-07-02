Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A8C8303C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 21:33:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5605B40661;
	Wed,  2 Jul 2025 23:33:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EDD074064C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 23:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751492037; x=1783028037;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=bI5m/xNmCa4jRCPLurqIgtkp+Kik4W8UJiINHgErBQU=;
 b=aLF0q1v8pStFC3UIOngksOidEyDKKK/HVbOLIE9F9kRupE7MzGJ2W7az
 IgDb2r/KysyLcw6DHiZyCQLZmk0ENyuSAifEFWiecCqIaaKDc880qtZo+
 9jQrwHFpOCt6TE+j/lZAXrmN/Lhg3MWed1yD8M5itNqBelHv3ilXzlqUL
 8Oyzz6AHSBDohKCvVCMo3OemRewk6qVy2wOhAY32D2Wfamc4y4ZuEQMGK
 1e9YITq4naP8ZwCtWa0RJ7ElfUWiercORCnKJEaoD7r/QFhHUOKuk7h2N
 K9vUMnXu1+QE4mCPc835qBlgxF3CJhqGkpgC/PsgMovHiem3940SNS6NB g==;
X-CSE-ConnectionGUID: QwDH6VAwTSGT97L4QbyA0w==
X-CSE-MsgGUID: j7f57/saQH+T35ABOmLaVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64049827"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; d="scan'208,217";a="64049827"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 14:33:56 -0700
X-CSE-ConnectionGUID: 11mm8o1bRwamUTSY1OpsMQ==
X-CSE-MsgGUID: pG18rDrLTmq6PzYfH9Tfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
 d="scan'208,217";a="153637984"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 14:33:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 14:33:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 14:33:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 14:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw882NpIZSQdU24pkKACek7eIEY43QKDY3nNX7YbfWs2ly80hwYyb0JEPhm9HPFa9qDhgLJkE5HJEbu4SxaoZX7fOOm6uXqOMCspe5t3PKXXUAiMYwWo2sqdpFhq8ke2PjpOva5Sjeyv+C2gwT/lCppxlc0UIIfoYc58gOj+ZjRRRDZxe8ZqP3FBlYC0oIjp9mYMe+TgCoQRgj6pPMEjTmtMdTodesNafksbw4Mbu9DRt70V15RolDNItnhD7SKhn7qhLnlFeoUeAMD58iBWrlpKPYw1ooamrXnu7DCbN6kQ+aY/GsCO+YPw90N8v/7i4mmvr54FN5svSrk0KRmFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2hyPrpIF6GYfgA4C0anY/gzsD1jV+7Z5N6v66W4nhc=;
 b=K/eXOov8Df7lvG+mF7NTFeX8/7ExFXMmmEqIPFNl1r4gFtwYfh0ntd62Aq73MLeNgkFpe5yJmh0t9r4q5UKTqJm127+UhxuwsVC3oZx8oFHTDUHF1nFPnlRtvIacuW5ko2nHMYOi/7R990b99Cl+GgRcr8M5tht8ta3LlmjYF4UX+tqwiWP2xyXFrwW+CMbIolZiyh4KLc3I/AMPsvq1sSpNwxjzKOgwiIbNbXgUQIhEO7sAr53F8dm5ZJiKGsv6+ULoVfVQuGVhLneBHzUqYwN8PPC9HHZ/W08M9bVuCnHziLxqodVPp13FfRbMh4X8b1Z2Sz/luabOYKLCWi84ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA1PR11MB8224.namprd11.prod.outlook.com
 (2603:10b6:208:44f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 21:33:50 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%7]) with mapi id 15.20.8857.026; Wed, 2 Jul 2025
 21:33:50 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-07-01
Thread-Topic: DPDK Release Status Meeting 2025-07-01
Thread-Index: AdvrmO/vShmrCmcGQ5KprbjwpT9rag==
Date: Wed, 2 Jul 2025 21:33:50 +0000
Message-ID: <PH3PPF37F43E35D204589A072C077808A56FC40A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA1PR11MB8224:EE_
x-ms-office365-filtering-correlation-id: e259aa45-e4df-4a20-6e19-08ddb9b022cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tXMj1+RoDyCNRMZySTynMxWdXR8sn68WmQHRUZcCWzL0qwePEZPnk/w+Y6t9?=
 =?us-ascii?Q?DNXkdbEQR5HPYNtYumIW6z5deMIE6cEcW/ciOSYUTJcqEyukmOVGzBluW0wj?=
 =?us-ascii?Q?UJxCGOHNJhDXr48CZnlshFox9stMQ4Jm758/h6sIH3v4dM4S2OkSbIjxOMBG?=
 =?us-ascii?Q?1clG1oPLFy64RJF6XCoGsX/dybqw6IpfjnFpqWyVq/3QGfY06RU7e0kwroTj?=
 =?us-ascii?Q?VM1KTKoka/Fq3TauvJrcxxTY5GkoHKFy9k7QfX+Z5gDBdbGSgFwLrDjT0vw1?=
 =?us-ascii?Q?CTZKg7+t8GT40qMAMzXngTJLwoLE9kpUjQt5SINXtGYiFxTlX8peE+XjHjaN?=
 =?us-ascii?Q?hbuASjQrP+I6C2OJaie6V8N6auCOuVBC/gWwuPwmFYa0Qoqw8cYsY+a3hb18?=
 =?us-ascii?Q?1us52K0kfcBhlPclTldixQVZNiwkT+SEAkfWsRnmy0q+XhE7cX7vClydJ7N3?=
 =?us-ascii?Q?GEG/2vyPwsl5J3ExonI9eywjVTKuDzu3qBE64VZ2EuMk0+zbG90ThFcBxuSO?=
 =?us-ascii?Q?ee/Mja3/Zrb7797PdH19SnsD23hbiJnsn4vAtVLRdIIEJZMvdHiOJf0EZ5XI?=
 =?us-ascii?Q?UlRpuEmUbAupsA/+zgurJ8OhNAWY7SAiPmh/ed8c4BqCE3HGdH6QAVqv4fYU?=
 =?us-ascii?Q?ZHNtv1UyCnKf8AN59hEwue3bgQaIrGNyGX8DYfwxxTTX7CPDmglpJVKA6s5O?=
 =?us-ascii?Q?0v0YG9VMiaNsLViEVwNjnqwqLetQ/IdRJLsA4TlBJm1Xcz9mAQ0YM2E71xOU?=
 =?us-ascii?Q?Ksj1IMNWQRroQGdHnNoN6bz0z/cLODGJw0ray9aqFHR5qUxpMQ6YxTWqz4TB?=
 =?us-ascii?Q?uNPn2G198lPPNwN106pLa43zIwhgX5EtNLSN5rwyQnQ3atTZNahOGjyED/jH?=
 =?us-ascii?Q?ma2/jKOP8y+GEQ0AMDA/iN8gUauumNORQeumsmyrOHasm6LDDtZNFKNc/he2?=
 =?us-ascii?Q?X8lpD0PxpOptbHO5HHsihMTG0N3tzVQnFP6KuETKjkyuC88o2ZsPo5ClHp8a?=
 =?us-ascii?Q?vSSaHAdYK3GI6CqYeYk7ocurf5B1qPE6H/uvoE2FQHrRK8Cajt3BKbNsCISt?=
 =?us-ascii?Q?Z4KaveEdHhXhNabvwv7JTPbcfj2hTXyAzrw7VbUTnB7BFLQK3egvQv+RREuH?=
 =?us-ascii?Q?sYPaUziy8CD6ed1GdgbM3l12Xh0lq+S5EehaxuWJcCovM8/hqCoycjL/7yDS?=
 =?us-ascii?Q?M6djy/NdRUsAlh2y/Pbmnsz8gQSmHrhltSnVKSJNSnsz8xfyjLu8tANHL1Gn?=
 =?us-ascii?Q?x/UVnkzJ1k4Xh3xCOl1DPEIgh2xp3OTJMWv7WqA+tpdddEBsw1duUGe1nA/i?=
 =?us-ascii?Q?CDn0zp+7bNBjLVLfVR1KDhhZSU1int5HWyO1KpkBwBARgTkLNIxgGGEPEDDx?=
 =?us-ascii?Q?MwgqH5ctrlZ9fO7fGjD3GAW+nswzCHPWAvviC7GqXepmkjRMV9JUVV9ch90F?=
 =?us-ascii?Q?J9x/4pS7tX4q4p/VkzkFA+B1gXb/Pgnb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SbMII6tjq8SgJDRy1HJ21g/ueXyyErMxgS2/gGWTQtVCnKUVoBNUV5jYBTDp?=
 =?us-ascii?Q?XVdgRC780V38QC4KEvEyQCClxa+dyND3xDtqtC/o1jt71fLOrr0KGuWsM008?=
 =?us-ascii?Q?XbZS9xP7qT/vWmACmiFFbSGv5a/7xeE1GA9PEoS8FCXe8b+fjGvl99tYuq8C?=
 =?us-ascii?Q?C54pHSID8vQHD0k5NW5F90T4cAm9RbR3tBLnkKTbVtKuB5BxTcGSo0JdpmIK?=
 =?us-ascii?Q?A4EEm3t0fGRdTol+Ghke88ZGRoPA+ogGvKNxdRSb9HdjYii1Vm1p174TV8JS?=
 =?us-ascii?Q?9r+BlQ42YT81QZlhwDY1Gok3/IVwoqjalt7juDspFkZKxisTjHsSUTWfRj5y?=
 =?us-ascii?Q?WWmw1yx0ePwTWhKnB1DvlgARg2j5IyQ1jaE9eWPB3QQLhwPlb/l/Dx8EboJu?=
 =?us-ascii?Q?3VaYgysSgURTrnKajqhkCk7P87KgMkeSAhM46tmLGimm4gocB8+U7qvKi1NJ?=
 =?us-ascii?Q?hl2UaTtd7PK/IkP6e8aavqkT63CTT+29ervRL7/xIANDHM/TZiOutqI+oEDZ?=
 =?us-ascii?Q?NZDr+NF5ROhosOPhb5AowXZAQToVYd3roHf8+05jt7Dx52df2MjBsFTebfG+?=
 =?us-ascii?Q?kQpLRtSpCpSVddZMlfeTbKCPZ9JAQkYf8rybUcoMs7U7HtGshN8q++Ddg3AI?=
 =?us-ascii?Q?dnWS6NKt2D1VWELUvMSEjK2P0VE9xQYQymGxRMq3c0hKMYgnjUzjSkgVHGU4?=
 =?us-ascii?Q?FQT6zqeeVnb+zIFPun5uhZfYU69kLYtVwZ65EVt59E53UJLem+vWEYakXpzJ?=
 =?us-ascii?Q?bIcowBv4wjeBQJDBeauKzbIh5TFY5U48Oxrcq4FPHMl/khIFY+qd7RFzcL5j?=
 =?us-ascii?Q?BJUwzhHSveP01Ihk4r1GvY1pgXJIRoc0xBrjdNfD+KgFknZX+KQHpWgDdXEc?=
 =?us-ascii?Q?6Sg7/2yRxe99FzhpXMcW/RR7To6sL3sKDNpeT9mOpB3bwMtbdaKDfKTdYe1f?=
 =?us-ascii?Q?yPakoR0uPHfA48MxKrYrrAhu/s/VcvQdBuu5sN6e8/geOdjoVhObp6sZzk0U?=
 =?us-ascii?Q?UI7wDlnLAJDcJtrWPFNYcrYpXBRHYyFUEsNj7j4YliURaWbF1YcjTkfffIWR?=
 =?us-ascii?Q?aMAS0L/HaFT8d+bF8Rf/nrNIPM3RBkqN+E8gKbd3L3We6t7qq+GjUp8sLJlZ?=
 =?us-ascii?Q?VIfopIAlPSnoiHzfKfbBhiWRTkjfkHl/H471VaCaBm1kJT1ej9YEzVdNkXfe?=
 =?us-ascii?Q?MXYofTkFQZcObgSW1C7rkdN7SyVV3Ub0w19fW99efr2KeGzU7D6/yTwEzx9a?=
 =?us-ascii?Q?4GpGsRhsJ+VkwAjUdy26ULbORWnaNIj4Jpkoc57Xuh3xIRVF4ScSh2BwEBxq?=
 =?us-ascii?Q?iMWGtLD3HHa4X0MpKHmFrFAWW7ZhiU+PEXZzJ5rKBXhV1QpAWzaJ5o9eZ5MG?=
 =?us-ascii?Q?LjAOAdxPR1aeXtxSEBx2qvwdAIjDA1G9BP/kmX4Zep6+VK5DVLEEBEdzFQ6n?=
 =?us-ascii?Q?DiYe+HCnMs6Ryo5f397FG7+yrboisJJPSeZEd6NEi4pOKOnknBmSih2bk0NC?=
 =?us-ascii?Q?FTus4E5ybcEnBQFP2xLkDn0CgSeIAtucDgBz5ZJG9FV90+bdgybQ+ahn5NVF?=
 =?us-ascii?Q?/sjRqRhpRYs3UdzlO+G76y1m7gskkVmDOuQZSKna?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D204589A072C077808A56FC40APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e259aa45-e4df-4a20-6e19-08ddb9b022cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 21:33:50.5530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAsZ9pOFHjCam5cKPPxXsQOibKHATCgmRYM3aU+qyz9SlXuPX5j0zOlBzq2b95XYm8WlRmjrZVdKld0hQKFKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
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

--_000_PH3PPF37F43E35D204589A072C077808A56FC40APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-07-01
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
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 4 June 2025
- PMD features freeze (-rc2): June 29
- Builtin applications features freeze (-rc3): targeting 7 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Merged for RC2.
  * 11 pending for RC3.
  * Some moved to next release.

* next-net-intel
  * 1 patch for RC3.
  * 1 additional bugfix.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some merged in RC2.
  * Just a few fixes for RC3.

* next-net-mvl
  * 1 fix patch for RC3.

* next-eventdev
  * 1 doc update patch.

* next-baseband
  * 2 patches pending, will move to next release.

* next-virtio
  * 2 patches postponed to next release.

* next-crypto
  * No updates this week.

* next-dts
  * 2 series pending review.

* main
  * RC2 released June 29th.
  * Looking at coremask deprecation patch.
  * Fix for headers when using C++.
  * Patch for UBSan fixes under review.
  * RC3 targeting 7 July 2025


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


--_000_PH3PPF37F43E35D204589A072C077808A56FC40APH3PPF37F43E35D_
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
meeting minutes 2025-07-01<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
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
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 4 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): June 29<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): targeting 7 July 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 11 pen=
ding for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
oved to next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 patc=
h for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 addi=
tional bugfix.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
erged in RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Just a=
 few fixes for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 fix =
patch for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 doc =
update patch.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 patc=
hes pending, will move to next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 patc=
hes postponed to next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 seri=
es pending review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC2 re=
leased June 29th.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g at coremask deprecation patch.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Fix fo=
r headers when using C++.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patch =
for UBSan fixes under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC3 ta=
rgeting 7 July 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
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

--_000_PH3PPF37F43E35D204589A072C077808A56FC40APH3PPF37F43E35D_--
