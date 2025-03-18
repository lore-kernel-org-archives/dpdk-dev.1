Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 14:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F185402DD;
	Tue, 18 Mar 2025 15:52:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C3C21402D3
 for <dev@dpdk.org>; Tue, 18 Mar 2025 15:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742309522; x=1773845522;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=6CLkr9EKK+w2xmixXKvXEsrLizQ0mE8NTi0E7Wg1WDk=;
 b=nOT5JpHFolXH/mhgaR6c7gDHGck0LLs4dhM1RB/ewAbb7ESbzqu2wCL7
 gvD6d1WXz9W9BOECqipSyQObbLpQyePn/nPWvjk+W8vdOqZZXY8HOGQXm
 zuIFV1Y0aQ6iLSKuGgflAAop1Nwd4ZI3ABzJ8IX7PV5mqiCwlh5psk374
 FImFyKZLyqYYP2Po/vvBOJF6yJapqu3h9EeCxRH6OoYm+px+xT3m6tBCS
 QVDjczzmJeh3gEE9yiRlzC1Nd2rAGN4RRa2tgYBLz/gamts1J0V5jgf0S
 SBzlZ/5hOcUX5Yy1vFCd6EitmCiuckZdCPNiXF97ShBVXucJzYi4XFCyK g==;
X-CSE-ConnectionGUID: uWCYVKjJTjGGOdTozmeLxQ==
X-CSE-MsgGUID: I91VcCc8TxiUsjS38QfZTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43374572"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208,217";a="43374572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 07:52:01 -0700
X-CSE-ConnectionGUID: 0vBfYGweTOyShujGmmXzew==
X-CSE-MsgGUID: UXBWWu4JTJGMNIms98lXZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
 d="scan'208,217";a="127334210"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2025 07:51:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 07:52:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:52:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJJM9DezGr8V5Bdx+e5Lh+f8iZSDlj/E+kM1jvcYYAVc1ush1gwPDWqxFeQ36+RsrTPqmUvJNGAmXHDQJBUYlxSqM0fLFCa7jtJMg7HhyZddIqAeH7VnGcLHjbxC+TRxrc/qYoGSvIqc83FJAHw+B6xiEgP582jCgHOEZDYDOSEIKLkmvh6TF7kjvx4B2sWRgORlMtKxv26kvRN/63fyUPWjyb7GgASWdtruoAra1QR5NcCrLxcIPgvC0fT02HlhJn7S6v5nS1ROwNSJmcKm4NFSKjwI34yxXzp8jvREJcRj4AJa3iUpwGLbIhgH0TkWdOIsycUC3sMjO9lYGICZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrdYs6yhrmkAbHf+6Dxl7xrofZP85+nbh9M8xJ6oPaI=;
 b=OEs0fVM2RH23yl3f59qFvM5q6DHcFNwp8YtbC8oc6kG9Mqmpy/LS9Ke6O7Ur+qSaQNnvWtjjflXHYepemUYCJ9RG3SKyDKVZ+o5+eN5xujBeWTZzD6g9hAkQ414iYeRfZh4bJn7gmTWry6XhRVy+FXIIlJ6CqiD/D+SfyFLbjmGb9l5UXspN9gTEmBe01NecalNG3sRO6+jpk0FTcH+/GyJjeBS5hGYA1JXpZHzF3NeNJ4jrgpc79DVr2FrsQiLnrPLGmZ1jWwvs0xBke0M0bs0RI3kJk2w7IJqdqnDP+9FydJJtuci3xGZM/CHVlxOpadqo15+qNmOU+KOwyH/7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:51:57 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:51:57 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-03-18
Thread-Topic: DPDK Release Status Meeting 2025-03-18
Thread-Index: AduYFUKP+dUx5PH4TiqDYgm+92ZAvQ==
Date: Tue, 18 Mar 2025 14:51:57 +0000
Message-ID: <PH8PR11MB68049208FE01CDAEE1A97EABFCDE2@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: dc1e189e-ee60-4a68-7754-08dd662c6e49
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rMtCM2DW5zC3yhvnjkKDsE/XWh+kwYglrQnqmcsASEVR2OMRIu0Z3QWXdi7q?=
 =?us-ascii?Q?wiciSrCW0SejDGfFx4ZJpzJMfgX8xVLv/PaozMW36Le/N6Uok65D0GysEmxD?=
 =?us-ascii?Q?9xNvNk37CYVsBdXJsWPu/IlAsrSypXW/7/4nxU9IDMShuIswd6x+Do06gi3o?=
 =?us-ascii?Q?33c4ebCrzd1v0RVbhFsnUbiHuLcXpLgemS+okixW3QM1pa5wQ78jJtsSyjMF?=
 =?us-ascii?Q?j4HlVbEb1JNvGvUNyDCDbkWCDvC1aJvK47uiCtP52hJ9b6kRIig4FAuxxC+O?=
 =?us-ascii?Q?E2BTKVYj863SAWGnCfxrYAQE1xsrtdPmR/Erz4p1W6EhC3Di3eb1xntPOfP5?=
 =?us-ascii?Q?CO1alW5sQMMJeEzC5YePAQJTnZIS/lkZY/ZQmtmFhL3NSjdUPG85wxP//hId?=
 =?us-ascii?Q?zh0IQsBPS+PpUdZAJKJmt7qR46G9+2ccMo2AH7BkvsAyLy4PFAq+O/cDznmf?=
 =?us-ascii?Q?8UvwuqhP6ZRwjy2GA6AekRZTEEdFhAIqq+zH2Kx89qlN3/bJQd2SAcfF1Iko?=
 =?us-ascii?Q?ToF7Lie2gn2XpB1rlVU6dsyNv3X5IdXx5Dx779ENco2mrANuM6Pk8SODs9vs?=
 =?us-ascii?Q?ytrcxqZ/n2bh+u+cMwO6Y9PdEnzCOTLR/WcbFTma3EWm/qJkGLnEaNqquSl9?=
 =?us-ascii?Q?/GlKuO93WizOvgr9yBhUqUjKcJqy3l95IeyuznPwUMCuRiL7eQWOo96/O6Fa?=
 =?us-ascii?Q?e5m2NVOSbQCBjP7hlDS8myuRbubBmUaQAxMm2/XSJigpZazZLZbONgw707qs?=
 =?us-ascii?Q?nuidCAxGEivYs/BIeX0mGDk6rM9tuXfJpuSMn+Z+qUNFFfTgBKvT6quT+ADP?=
 =?us-ascii?Q?wdYaLs6NQnYp7lrtN//Io0frABjWbwqbBNV+r9oKs8NPU2HVznhDx/2Idfrv?=
 =?us-ascii?Q?TztVD0tETxH6ccsiMC/qhUkKHzovjwsqsjch4D+V5P8oonMTKK5bW8zMVBgx?=
 =?us-ascii?Q?/jGVKGfzam8gPdS45E9XMqUHGL8Dec423hrZRS1yJ+7bDjU6ppYDVz/ZZSN+?=
 =?us-ascii?Q?YGSDAggtFPDyfD8MrGCpLwRuUvpByqG4DhybBx3rtH1zurWiDIZ5tNjo6eX0?=
 =?us-ascii?Q?o2CRCFYRNNH2FZM5c394BTdEcdcufoL3/SeWuBQUPwXHL7smmBt1LZVw+xz3?=
 =?us-ascii?Q?rqY1+ypHqfnNqzKF88aM17UrBMpSVmjmHH+EcUMHsLXPLi/I31XZUkOtS3nh?=
 =?us-ascii?Q?GtMuZvuTKq/SWHFkKd1rx6TZnj87rGDpFXrrx3oLxu9gUHiiy3NtRYcXFU9j?=
 =?us-ascii?Q?Lh+gPGA7uZDeV6etLTdzMImlXZ5gQ5hZ2eaA8DLc6WA1buBU1f0U3cZ2jQUg?=
 =?us-ascii?Q?3HMwtfw/YfGs4UUuYv3QbECNeQAaonPb7kZ2xV0qhq73SLGjPWtp5xBiQomo?=
 =?us-ascii?Q?xowUIuBZIGYrvBCPSoIejCNeV9WOnLDG8366hbtFIjZCZgphcQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/TY4iDoCwBBmg9pq/+dbKxnhiSVRpL8EuvvYqoXnxUSBLGaOCpuQ/5lMbRV?=
 =?us-ascii?Q?sd/qZhmGR7TqI1DWuVFZCPVAejJ9WZG9ifaN37NZ96+4dDDDM5vwdFemJ5RY?=
 =?us-ascii?Q?hp7g/L1zSzIQH4yuprX/lhS7xQ0Bc3t9NlrghT475LjOKdY5Fku/JL7ykOKn?=
 =?us-ascii?Q?SUP5KtxWC6rFOFnF6iIhLwfCqgawhE8JsYyHsEskmOj6lnStU9709NfZCsE8?=
 =?us-ascii?Q?PYnuhR5bDbjYnnZpIoMVIH9bhtRKM6hVN+7IIfy3IAv9x982aBbdPcrt4Bgw?=
 =?us-ascii?Q?p42+Ghx1ebQz9mX4fV+8B/VZIA+uWvu2+7orQYWlNJVOm6O/5Sheyfkjs7Jf?=
 =?us-ascii?Q?MxRRd1X3TIiBxDBYyttjA9DidP5fbVAwJJoXkuIFJYDFlxbVVO56OZn4guDr?=
 =?us-ascii?Q?0obEAbNdqlIB8FLc27upqw2Nr+wttBgRolpkdyXOB+0F3ECOTHYSQ2CHw3Q2?=
 =?us-ascii?Q?rUIuHlq+PcL08acgl1Ck2HjSb2VuduCy5XBpF9FqfNfrMWV4otRpxpEBTLBm?=
 =?us-ascii?Q?gb+bATrN6Ha2pRhmuOo1dk3zf3GDgDgGwFT32utUs1QM6YwKR/922XwyXYV7?=
 =?us-ascii?Q?GTvKoxibHmS/g9q9sdEJtPSQB5qpOkrdqwBw3zrVv/a8L0QAe1x8j/Z5qfKZ?=
 =?us-ascii?Q?D6LswC1mvy4hRc0NRkrYWrJWDI9U8o0Ds1gGt2HQH0tun3BpTT71NbWDHBYy?=
 =?us-ascii?Q?UL+3YaN1gh8cSqpTY41VuXdN9TfaKnMjYezc8zUHVZT8l+bCYgrXGcq0Eooc?=
 =?us-ascii?Q?D0EjLhu12SYi2JFPHi/vcV+07NcfTxqC1JLbvpyTPOF/Q1pr9y9lK0d71yzs?=
 =?us-ascii?Q?aoYCOUrxXvXFLWJGP9EMZWV6MTsQsJpzHteu7bIHudem931p8HnB0r1//zfH?=
 =?us-ascii?Q?XEuZKoW7+mNc98AvpAw30IkwMu/wW1E8Woqjhfb1oT5+VFjp0tZrAQrLrlCh?=
 =?us-ascii?Q?jS+iLZE+C9jfVjfdksgnWLgiGmGD26HPI5OY+uXoG8MZOdwVQfxbcrNcqA80?=
 =?us-ascii?Q?hXVa4mNFGan/LIAc86GyvKgAT6xifeRJiP3wh9/F+JIkH3/8/qO69jP9n/bM?=
 =?us-ascii?Q?9uUISv8F3hAoSMhZtO3qOe5EAuzX27ruGmtk3rIB0Wg46/OArfR5vWEBccZq?=
 =?us-ascii?Q?7cx1lIifRiTRuXz0GSG9Cdf0DRuRc7XC4xOKU4EoeE0K677GdvVf5jQDaKOI?=
 =?us-ascii?Q?nReFbKT5hsONzWmmh1pXOJ4IRFnLJpLfGG9smcF7miTyRnWVszts/yiP5CTa?=
 =?us-ascii?Q?l2WnaGSFmAWRmWbR02MdpwYiFxHFDgDu2h9ge1n1hKNaxil1OXT0m00UMXFN?=
 =?us-ascii?Q?8roKK+sFC/837UzmucMEjELh0ZJYESBTOWfy/gSXfujofB0/qsUQuwXJDvyg?=
 =?us-ascii?Q?PNc211Ht/zlw9vksQmIjUTqpV6YGr299lGSWgNnQnRXE5hvMltFsOFESjl6w?=
 =?us-ascii?Q?bgLM2LxivpwIQqSnC1sdqFPvg8lbF1ceGG7H1PMkxaKZVVHIvuBM4GkWa/nB?=
 =?us-ascii?Q?BKjsmHhV3dLmZtSvlXJckrCPFXXePQfG92V9FY3OsGm47G3s0ontVtI8ky17?=
 =?us-ascii?Q?36aOZdnv3tQLpQgrDdop1te5bLLnwkCF51rqnd9t?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB68049208FE01CDAEE1A97EABFCDE2PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e189e-ee60-4a68-7754-08dd662c6e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 14:51:57.1178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFeZRuGccn6XoM2sUDCENNdQGlB1n1WT9iJj1fJg0+YDIB7HuQ3pN9o9JWB1X7l86pZWq9SEvYMWmID0MXPI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
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

--_000_PH8PR11MB68049208FE01CDAEE1A97EABFCDE2PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-03-18
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
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.03:

- Proposal deadline (RFC/v1 patches): 4 January 2025
- API freeze (-rc1): 7 February 2025
- PMD features freeze (-rc2): 6 March 2025
- Builtin applications features freeze (-rc3): 14 March 2025
- Release: 26 March 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Merged in main.

* next-net-intel
  * Ready for RC3.

* next-net-broadcom
  * Ready for merge.

* next-net-mlx
  * Some fixes to merge to main.

* next-net-mvl
  * All merged.

* next-eventdev
  * PR sent.

* next-baseband
  * PR sent.

* next-virtio
  * PR sent.

* next-crypto
  * PR sent.

* next-dts
  * No new issues.

* main
  * Prepping for RC3 (2025-03-18).
  * Concern about ARM compilation.
  * Will try target Friday 21 for release
    (there will be no RC4).


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

--_000_PH8PR11MB68049208FE01CDAEE1A97EABFCDE2PH8PR11MB6804namp_
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
meeting minutes 2025-03-18<o:p></o:p></span></p>
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
rc1): 7 February 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 6 March 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 14 March 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 in main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ready =
for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ready =
for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes to merge to main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * All me=
rged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No new=
 issues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Preppi=
ng for RC3 (2025-03-18).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Concer=
n about ARM compilation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will t=
ry target Friday 21 for release<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; (there will be no RC4).<o:p></o:p></span></p>
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
</div>
</body>
</html>

--_000_PH8PR11MB68049208FE01CDAEE1A97EABFCDE2PH8PR11MB6804namp_--
