Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66339CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 13:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D333402D4;
	Tue, 26 Aug 2025 15:51:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1B6EB4021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 15:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756216289; x=1787752289;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=lgPKFF3/JN38dEak+1Q/tLVqBGDu6or3GDRBaJY2rL4=;
 b=c8+pvQ2uF432teZKMvy3lamgcUtqS+An42yBF1jYGTnBT17iP6+bNiJB
 9azF8ksIg0kybEY9goHMfEsFTbCgJiTQL6CvN+d7WBQ1dcOKugTZKjSoo
 My/gEFtW+6EEI5knO1ykchPaMIWEIFYXV8gMyyccMDpFP/uhC7IRjMFJw
 oV7bJjwlhbnjRWOTxrBSVrWoBMNgGn865KIdAiKu0ll/qDLQR9WjVujH7
 Uzy7po190rDEoEGvaEuCT3Lmf0MZD/A4743TMNKSxIEqvJr79eEAkrwG8
 PU5aLSLU09PkC4/WgocYAkZ78g1e1zK3V4RBF3Dgy4abS5LwnegF/gkvu Q==;
X-CSE-ConnectionGUID: kzc8hXc8TJemx9sFb9zFhA==
X-CSE-MsgGUID: DvzbHF4uQ9KijWdakSXF2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58370216"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208,217";a="58370216"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 06:51:27 -0700
X-CSE-ConnectionGUID: WF4i59A3RzSKDKd3vvofsQ==
X-CSE-MsgGUID: e6QnMM5PTme4H6U8XfYGRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
 d="scan'208,217";a="174841485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 06:51:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 06:51:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 06:51:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.77)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 06:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCwq3JUFTmIpJlwlxwq5JJNowSL97DqxFW7abObyTLzaPJtU4UoWNoOlRpmUaZo1aauyZ4RrNcxFNzQrOcIe2d0T0eW4ymqYCo/Z3WYmgDGt2ziNz7lWIZJ4Klxj3J2+6VOI9npTSRxB/e1A9GsL3//v7mx2PFuE3reCxfcL8kp07PtyW0SP+YTwOd6mXcaM+n9SFRU8WdrvWk5PpCE+eBFYZKzhQ/mGdX7NGL/sdWx2ok7X30wJyL1e9BHg5cpIBjU4+WSGqKfiaSXwcO4IWSCdbbNgQbxiu8vzXL1fySmQ8A8KQ7frX+mD5VZQ/y4Il7U8EamD6aDcBFCGmBQ48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjkp7Jbl/iLE3aE6XPqgNbZ7Uw5TmXuoTkqSiR7l8jQ=;
 b=PZfX4SG1iWU3RBZ0asKMpOt+9mAuAZ2LAAa/0wUr7BAK6xm82CAv/EzZp0b02gHIrPIRplnXxFpRKv0buQbn7Wiis8fvV3YustgHoZTmZBhT/F8ds7lnc5hf2Cj6YabJwDC1qt2pVW0WcucXHdEcfSSd6znSgFDnDXwyebUpawWWjLyM1GWaDL4ba+I0p1XVxYOtbFkyCt1/Q+jLgIIBT7vH4kPh6ImO62w6wczc1dAr57DstxkxQO9fvAmwLwv56OQgYo5ifOtDN1680R/s2PLX8sjhabL4B9g9/o1+sCHtuIqguofTUpLc30Y1RP2O2QicZRynYaXaiMLZKvb1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA0PR11MB7284.namprd11.prod.outlook.com
 (2603:10b6:208:438::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 13:51:19 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:51:19 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-08-26
Thread-Topic: DPDK Release Status Meeting 2025-08-26
Thread-Index: AdwWkGqavXEcFWBjQ8yuSps6ZqunHg==
Date: Tue, 26 Aug 2025 13:51:19 +0000
Message-ID: <PH3PPF37F43E35D29CB11404A096FCAD1C1FC39A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA0PR11MB7284:EE_
x-ms-office365-filtering-correlation-id: db72ea4c-6a4e-4ec0-bca3-08dde4a7a29c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|13003099007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6b8Njz6s3WF1nB4g5hiM9QEB4vUgKllXoFyDD7CBvOSuG47HtHdM8c6U5waZ?=
 =?us-ascii?Q?Xov4l6UnIfjILlDjo0zVpR6B614yPYjNXMKa6gLHfdbZKf52d+oqVxBQpdR+?=
 =?us-ascii?Q?6drn5FdS2812DJIzV7VvF5iV5nzvsQ+v9yo+P9jQnYsDvOIJAyNKK91OD7b1?=
 =?us-ascii?Q?/LnfDpdUpF6O/gAvg+spHEWnfpRIUS+67c1wLX6aBhHFc2JK02sDFDvxE2n8?=
 =?us-ascii?Q?t5cSMaMRSbLPHWnQi/ZKtJxhUMVteWUPOjbWBurMQB84VgU1vgcDNoa5PBUJ?=
 =?us-ascii?Q?DTVFsSfAePcXfYos+GrJ8aJMDcsSkxvDQx8TOPoJg7J4wGf8+Xow13CAUHkL?=
 =?us-ascii?Q?tZ/dqrEvCXUjxXf9JP0FKJnKrIEE58IHY9Nd3m+DbS5AE6/1BEimtqFYotOZ?=
 =?us-ascii?Q?2WP30TI2eR7ToKr2X8v6j1FemhtwmmssuX1NE6AQnf4epju89LWmDYUmrN/7?=
 =?us-ascii?Q?Nv62tCPC8h/X/HDTCZS+2z0r6RdL5aEsFfbErm1FpZ57J6Gs0QXfRs4e4Gd2?=
 =?us-ascii?Q?eWeLBTuz3cAiWRWt9lxZ5t4J+4/j/Gv29mtq1w5uvk+STapmG6yxEBW3htBD?=
 =?us-ascii?Q?nbIDvne4oStB501FB1g12QaM9hnX1hLGKJo4SFfI4yfKIG2DyoXEbX1ROUU0?=
 =?us-ascii?Q?EAAB/kvVFPBfk73+TBizMDfdsfugOGuNwMocl0KJBlBGFMMudRush1ExU3pD?=
 =?us-ascii?Q?balzjPZnbV4ULwb+NNsDTdBxwGpqTTeLfvtwfLY8kLFWKOMcUU3RnGwa+bv1?=
 =?us-ascii?Q?BxOANc4S7jAHfzmxU+m6g7VXHk5JDO2RjUXw9Y17xIrrUifE6ldV46ozEKtR?=
 =?us-ascii?Q?F3jgGq3h92JaY3r5jrD5+eOj+2Q5RTDqNM9tzP/L9XuodMI8Pvlj4QLGKb7c?=
 =?us-ascii?Q?dEU017Ns0Zdoh74VpXzDSwKAiQYzAFBzmhpXlMEY16QsKaZg+SmKp/5/Ji1p?=
 =?us-ascii?Q?khfBAOvB995n/rwHLL8TxNwBnlG89tdSijx9zU/UbZYhFwAV6KhDQvld1Pwt?=
 =?us-ascii?Q?hv1lK/5vopCGm7Rn9INieK9Ulry9wK5lxORcxT33e/RfgPGkuf9aYl7g4u7s?=
 =?us-ascii?Q?6jpJecGfjGjjVYGHqKwAkLYrCRBqADG7ptc0SFAMGcqTYeqR4+elo4eoDNPF?=
 =?us-ascii?Q?URHHU83jswp8JfvSFjVnEcS+5AbwL8yo4GHThvHl2xNoeeCci3qrdajhEVyG?=
 =?us-ascii?Q?exyo5wUGLsHdWGAgj6cksWZpcjMM+dkXYmezYbPoyLxxundy1VQPGc2pMM/r?=
 =?us-ascii?Q?szcKcQFQ9nX/45triORZLv/Vfj2DrStOdrPJ+hadwdLs0tdcpX0H3SC3tea/?=
 =?us-ascii?Q?0b5hinSsM7rD4uYWnlYZI53OPYih8AdMJ6mhb40OKb+r7Qche9aABpeayqzF?=
 =?us-ascii?Q?oXWyJzqF+I3W12lAupMijrVGwuPVtZ6oygsL/V3aZ+jau5GDalRJUznoJU80?=
 =?us-ascii?Q?o+eAAMpYkEmaJzYtnwsmxpJ6iklUUn8v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pFN28QyuvSkH+2qvrFMeHUbskprBxpGAMw9JAzmzvXjFImkj/WAUsfV3BhXq?=
 =?us-ascii?Q?3GnMIiUu/UF8Qt+tVEPYD1tHZS+twhbJ4e2yboDyPW457vIzXpZ8uZJ3CcoR?=
 =?us-ascii?Q?j62Np0pXUxxnH+N0KPnNQrcCydGKbL0nWxpkD5DeudBmoyzRtmpo9D+XVBHP?=
 =?us-ascii?Q?4jy+htzCPmGRpP44NeoLWleIf8HCJ9H5bc1QX443Bc0kkE3FWphFVV+mDXLU?=
 =?us-ascii?Q?19ShXiag9KSNadd2xA3dPAhTaNnkgZieueAHejz6YlFv7g7m9nCrG0sZHp53?=
 =?us-ascii?Q?lo981H14PEEfzIRpwlCBeW89aLfQLk5Lui+M3JQZJDzAcqOocO192yXg7Mxs?=
 =?us-ascii?Q?k9MQDMYBKU2wdIKjrxiJLdVypXZvCwRpvpF6rOyXWum5ivifyly4Y0jRxqsm?=
 =?us-ascii?Q?B9u2P2VkVIFEneyqw1kXZEKhMtw7pTwjhAGEhFM/HhPsyBFKguB5XgaCOXCI?=
 =?us-ascii?Q?r4F1XXozxuAvPATLD2d1hXJLJ1Pq20Cw0am8WWtdgrqRy2ZxQvQlkYR/alJY?=
 =?us-ascii?Q?Y/tG18uNjM00mOYDF2f6M/m7KznxwIH5JF/nOIW/668ts1HI2Y0cgEO9QKtv?=
 =?us-ascii?Q?5lfn992DDKAPx73PGJuXDNdjGb3hOCD0jO59HpAIFxD1F1h1TllYAiIL9pTW?=
 =?us-ascii?Q?shiGr/NAGqYQidDu4LYsjUl07dmCB/mTJRZheNIcJxGkGuJjewBaEZ8E/0kc?=
 =?us-ascii?Q?anXkW7po9+ASoJv5dZ/7XuajWVvBbJcU1KakhDOBYcDQN5ehxBnYtlWLUafH?=
 =?us-ascii?Q?rWzVduwWF+eyOuUMortpepiz4PffTaI7YsSktsFpWpT/4kAV1NpJ3bzO3iKc?=
 =?us-ascii?Q?Ch1S3GExS5BC/5wrc4CLxo1RugC6m/GU3mJ/uBDiwH3HMVPFpwvH7J6+6HB0?=
 =?us-ascii?Q?R+K4Jh+2W7FHHoBWfo4txgBKxnguLPsFCwIQaKNWAYwm6h40VutrwRTBetwg?=
 =?us-ascii?Q?M3GYrgAgcaWJj+0pUv+c74W3cJF50Zwwf+7S532lLC1n5FJeLj/UxmcT12Q3?=
 =?us-ascii?Q?raihINKBQpAAd9zs6Ne1oylbtstRrLd7WAW7r4O7Dpp2xu98ax+ai4jb8Gx8?=
 =?us-ascii?Q?+lxwXLAi4xK5wK1ULx42ofPe9d09GxLBz17HwU8rs7q6VCWtVoc26S3CkG3K?=
 =?us-ascii?Q?5cckZQySVDo9s5ojCwXYMqEvRvRigE5Qw3fIBAY8S3wG6wtpdz4+TgryJ69O?=
 =?us-ascii?Q?NgouYpbr8C2nqijiXS7hmps3QxG96dnvABjOmAwt5HZE5upm38mFgG17T/AK?=
 =?us-ascii?Q?drBtK4e7XOT7mjmt58tHCd3FiKESu6/p+QrMTWUbB9HSouKdG1zHEEIy9TUp?=
 =?us-ascii?Q?HfwgVOL6mTJGv6sU1+Zzmik3Eao26X3npoY/xvFZr+/VPkNXgcNFTriaNapc?=
 =?us-ascii?Q?IUYZxxfhtA1f7ql12HVIF3jMwkeWNaTMixMzKoMIKWgvYVPZGOWt/+q1M/WZ?=
 =?us-ascii?Q?nlzyluDY8J90xLExo1Q7XegD6BM85etiO3COW1eiALVSTb+F+DqO9zaufTOi?=
 =?us-ascii?Q?pXXxEC0kfO+NpykF84MRxOaYYN2G67pCXr78Z8KyMv6jzFbRCZXa/SVx1CdV?=
 =?us-ascii?Q?LmOxQ09NUURQhvfk7Hutu6qjnhpLPE8Mu6g2TjJ9?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D29CB11404A096FCAD1C1FC39APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db72ea4c-6a4e-4ec0-bca3-08dde4a7a29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 13:51:19.5013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soEnazplz0pSfZtvPokmpr+gHyqRbdTQEC3OK0lXvKyJ2xwwzPs+Pxk4ibSaHo4wLFFUgNacCnkcW/ltlioxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
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

--_000_PH3PPF37F43E35D29CB11404A096FCAD1C1FC39APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-08-26
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
  * Some patches merged.

* next-net-intel
  * 20+ patches applied and ~12 in the backlog.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches merged.

* next-net-mvl
  * 10 patches in the backlog for merge.

* next-eventdev
  * 10 patches in the backlog for merge.

* next-baseband
  * No patches in backlog.

* next-virtio
  * 1 fix but not much other activity yet.
  * 1 series for SPDK.

* next-crypto
  * 20 patches in the backlog.

* next-dts
  * Some rework on the doc ongoing.

* main
  * 25.11 in progress.
  * Proposed roadmap milestones: https://core.dpdk.org/roadmap/
  * RFC/v1 deadline: 31 August 2025


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - Released 2025-08-19.
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


--_000_PH3PPF37F43E35D29CB11404A096FCAD1C1FC39APH3PPF37F43E35D_
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
meeting minutes 2025-08-26<o:p></o:p></span></p>
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
atches merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches applied and ~12 in the backlog.<o:p></o:p></span></p>
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
atches merged.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 fix =
but not much other activity yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es for SPDK.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20 pat=
ches in the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some r=
ework on the doc ongoing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 25.11 =
in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Propos=
ed roadmap milestones: https://core.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RFC/v1=
 deadline: 31 August 2025<o:p></o:p></span></p>
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
eased 2025-08-19.<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35D29CB11404A096FCAD1C1FC39APH3PPF37F43E35D_--
