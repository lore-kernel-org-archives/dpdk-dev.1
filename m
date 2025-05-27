Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D385C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4E664028D;
	Tue, 27 May 2025 15:58:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7423440144
 for <dev@dpdk.org>; Tue, 27 May 2025 15:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748354337; x=1779890337;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=H4SHFlm+9EvfkhEEVSVAqgGJqAepwoSII0RhKRnMlrY=;
 b=i7eMdWYALeAGkySVEX+yX+CmgAaGeT176yMjbQ0uOTUMbyg3AR74W1jc
 MBOtVdxz3/wlGYqqwoIli9uAJk2iy0+ahoV+W8ZBXrHpbw9bA9K2IWS5I
 yWjPhNnuk8BPcIuo9LLeWQKR5slRfY16ahQHGeZP/GvHUbvyAQJ6sQVqw
 Sqzj1u3xw1k6qWmoZdJT8gWrYWuDX2bSk0DlL+gM0eVYEt3zniwZoDVCe
 3oHs++KzfHnA79o+r0v4K62wyfe5B8P/TzfTMWdqwBEFwyVWsagd1+Gf0
 UcIl5vn59mfESMlIyG9KaenccU+sa56U6G/1SBphnFUozZN0gJ46YXYuC g==;
X-CSE-ConnectionGUID: mADlAES6RoebeEIaQ77Sgw==
X-CSE-MsgGUID: 5bust0eKQNG211VxSlwgIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="37968878"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208,217";a="37968878"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:58:56 -0700
X-CSE-ConnectionGUID: UqsHLhSvQJOjt7zszoKSIA==
X-CSE-MsgGUID: f7x2HuaTQ6ifpUYzl+D9Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
 d="scan'208,217";a="143789369"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:58:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 06:58:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 06:58:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 06:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GehVfvBqF4Y00ah5XLflcgR6/duaEa3KW5u9ZKlKUYhat0z3kximm6P/9u2cuj8IQt0u/PvH/arx9cjfH9SnEyLUJnsg39gXiJHqVnaJQgLBkNYpQMhMW5XjoEekGwLyqQaKcPT6DoRQp2l+YVF+q77HSNdorc4WGQcQ8DEyKTv6snhxCCrr+lCnfPmCoZJRLsO41vn5UlY5wgjQ7TGElSSxbl3BHlb9GN49d9CvmFb92erYuTqdSXX2ncY/0g/G9ICu600QoXKCTD39kgWENj6V5FSKDNzvmvq8nbEudPShKDITU1VbIRyPahKgaTsdh1CTacmLUlGzYiPayXh5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyx7ClWPT4TBJVEW+3eIR1/4ywT0GijxI2g/fBpak/Q=;
 b=qHeqyE7e+VKhfADQi0wx4KnXMgLJNABij49JiEreIsuu7LfZVVNF9R3aSaKfY6qqddIXiGdVkh6QLmLp/F6V3iPs8ZLXHVnSJ/6kw8dgfwVL4KXRNf/J50AJgOBMOITs5Yv8Wb98IUN44F5/1SjtNRMg9s2zPL+eBJkAPTF5gtmtsaljnxvlug0uBKlwkd/cu5mP4K8ZG2aywV+MBthFV8mXrI4hYWt96vLGAiv9XnKHVnW4bIXEYGGQoV7kQ++21D6T7gRuwSNk6FyLPAtiTn2q8EcRy1q29s+kVjVKu7N1FvoeMSWdG7YoVE/5THTZMWIUGmm6U8Xb2zb/XoziVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 13:58:45 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 13:58:45 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-05-27
Thread-Topic: DPDK Release Status Meeting 2025-05-27
Thread-Index: AdvPDz2sNBJsUywXRkaKU9TEtzIYgg==
Date: Tue, 27 May 2025 13:58:45 +0000
Message-ID: <PH8PR11MB68047B22F8D2DE1374D46B61FC64A@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB6769:EE_
x-ms-office365-filtering-correlation-id: 67325b71-4430-4826-bcc5-08dd9d2698ca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3btKYTuEPZw1coT8O8lvA4ZeK3SY6cTieadPSzpBONpTfOXZzJv9vtK7Eo2v?=
 =?us-ascii?Q?qLjWe56V4Ug8CAURGFhB/wOcdYpEtL1f+qLminLGbROMyYFqrFW+d6Fj3zMl?=
 =?us-ascii?Q?JaJjLe4MHMjJCvz7wFyHq7jZiDLTAjoHwptzWHGZmkNXS5YHEclKa6TCTWOP?=
 =?us-ascii?Q?B1YwrAvIiBwEX8x9Nh3UrlOLuwUsTetghMaO2GO2IKIAZunY8/2pAwoRzNo/?=
 =?us-ascii?Q?u0jfeFxv5V3BzpkxnKCZd2mjB7fISMA31g/GlJeNN0S/HmZ7E0muJMZPBsp0?=
 =?us-ascii?Q?XgC5LNQEqTQ3SHjZBX03Q1bfQ4p7ln/fkDij1nlot4jz8qJVZHg56GtrdBv3?=
 =?us-ascii?Q?LvCOuiVfc0f/RSHsUy4AQ6EXdaFJOATI1KpVGuy4sus4SsW26PcIxaRzpLVY?=
 =?us-ascii?Q?oVmR4IX73cwQkrPliZoJefDf1uuDyr306M/cnYULR6aFwk0WUnZWiN0gWl+T?=
 =?us-ascii?Q?qH/+ir+NGbMe2EAiKR1aauJG+Q7a28Nlmvv+loZc7Jozedn3+SJoPUwsZz+E?=
 =?us-ascii?Q?aWRMSG0kHjEazTlF7F17/a073yqZ5Tnp5u949jUorjPPeME27e8tjZ/eNZVD?=
 =?us-ascii?Q?YJLbSWWkv/hJRbdMDfEQ6GDXW93BzpN8vyUYB2IPZULtkAV0/RrWd9xa+y9G?=
 =?us-ascii?Q?zRUbzANDeww+2aQgxv/t+uZX8HfgrccJlkBG7Y8HKFstpP1qh04LnH3gS+mN?=
 =?us-ascii?Q?EBshscaEr5p4O6jBX2AyxRfGFX+WehiIz12fWtGwlLBI5Cbj3ncPGmJ+hW3a?=
 =?us-ascii?Q?lAx3+FNuc04RpgR+3mZQ8K/v2gQuC7kcMbas5tCg5fFKgW0uaSlSQfUNxq9p?=
 =?us-ascii?Q?Qw2eZWPn2i9UIciQw9psa5V8lajuQ/9rzoNavTCya8uEsrwTVAQXBVH1ZogU?=
 =?us-ascii?Q?xK005MrqY2C6ax6LLrXV339g0Ue+qx6pHkwGYNiau8x6iOrLnzG8z4cin+jE?=
 =?us-ascii?Q?0A3XSvUGcKyvB6hqmAHTko/fpVGAUTTeH4QvIcUJdxNTGzYAl0JEZIBQbFq+?=
 =?us-ascii?Q?7UG9jzlrsU77/cdYU5zQgxLMgcd4ufWdodpYEFmSSMPN30KMMPnDkafS95JF?=
 =?us-ascii?Q?43tnJNCAFYlCnLHHpulTATmSnqzDdl69GMwW6SvLPAw88FrijmUJjcg189A/?=
 =?us-ascii?Q?/2Eqlfb5LcBWN7QR25c83Gh6CYmAOT/iQQhJOhD0xm2U9Bew0OHxenq4v5u1?=
 =?us-ascii?Q?+y59OG9G6pZNiPQzWe+OJyIBVfZ0SO8wjnZeQkpV2TGdhX+aoTbbI6DbYp2V?=
 =?us-ascii?Q?bGt4OvlgEFjbu4MUSQVJ14JDSqvGxK5DI/ofRrmKL2HSEWbwwP7gV2ntslJH?=
 =?us-ascii?Q?bK/T7itKOw0N21Ic+QsZWnk7KpQnFNP6WriDlkMw6m0g+7RsqiBbGl5qQbEl?=
 =?us-ascii?Q?vY/y8bgPtF7AKRHdy+dWlNUpmMRbXP74qk1O0bZneMlATvzMhqmQ65nyTogV?=
 =?us-ascii?Q?QsSyrXc/0nAUgRgJ3BbbKu211NH7Yk1v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2be+KZNCBcDL3Z9wGjxFJ7gD0tqFhi663bZtgfdSXeYul0uLx4LKCVs3q+I?=
 =?us-ascii?Q?e1wPfU+QMT/AtRq7Mro4eccKsnyT5fzup42b+msagX60pKRYLCc4M4PaUALd?=
 =?us-ascii?Q?DGFyB4/hpFmtexL7Pkrqd1lKD3GB6Da4kmCmb+U+FgLkasvVuW2reLD9dVNF?=
 =?us-ascii?Q?nyKLc6QZ3y2WulUWeEandoI2uprBzRBWYZZ35ULgTt/Erlo9SWalleWgUM68?=
 =?us-ascii?Q?mooxsTW2mmFxf0OkHoVPWo5X2XXD/c7HiBAYhDxW1SivtXqFqu0leqd1i+Sn?=
 =?us-ascii?Q?mXT2L1cCfrPgKsCgjWBUVNTs8xVe89dV0yg+bvNWxGnSyS1qdmR5TORqGgk7?=
 =?us-ascii?Q?Ir8dGMcOOb/Ljbub8Zdo3UEutakDf9I4nLotjj91Fctf8kzSyK4pvMMGydmw?=
 =?us-ascii?Q?Z69MrbVHtK6W7orsCWZC4EJJh+v0LaUaGC6ZUJcenrt8Ex/g04kGmN/p1uuu?=
 =?us-ascii?Q?jH9quPesWP4ogSaDY3tG7iwdfzGrBU6yV+HTbaXj7KFh1KAJTpQlBe7fcj2Y?=
 =?us-ascii?Q?V8yNc/tEcwi6wBQKSagS9A2QQRwGnP31HDI1NhIROymwPechY+EdsBtQ+/+6?=
 =?us-ascii?Q?yqq3vVYsZEmoAzLl6UAs22mRx2toWujwW0kaIlee84HY6e5XWQXKAjuKeAr5?=
 =?us-ascii?Q?pa3oijjCyrOjVxqswKvsmTn4f1XgX6W26ODDvFo5RGvFssW6hqTuFWRvdE0/?=
 =?us-ascii?Q?ocpoiCdzMI/Hbha2IPmOwZlshIInV3zS5t0417IZL5J2h5P2PDHJD1p6XC1K?=
 =?us-ascii?Q?hI+0cfVnlJri2iTnaStaiMCHM3EO/kch/9CKjL+flZxP7WbEW/R5OGDZGYSz?=
 =?us-ascii?Q?KpL4+UJz8AYKEW+q2+/BBynGhE2Yh8ueO0ERN1Ss6dU+t3O0yYJl+ebFJl5M?=
 =?us-ascii?Q?Pm6D8FvsyCMKVw15LhHWfLOeg1j8ojKMebbClUxMOkTBh7fn6yumzGSZOBNC?=
 =?us-ascii?Q?e5cYl757WC59jummpzfG5F3iDqJTk2Y2GlEpIdfhP6cq2qOg4rdjx2zBgwYE?=
 =?us-ascii?Q?d4J9M2zjybERyeFeghWyHToHw8uHvVKZPI/6KQhjkArU/2nx4yOd3lvXSuC0?=
 =?us-ascii?Q?ICgiHIMHvRn29Y/Y7L4Yaq+Y5y3JGrGsH+/HkBEoJD7Xy2DJXuw1RdnE2AVO?=
 =?us-ascii?Q?YWK8cZFDgacSt6w0V4ohmbLt0ndeUr4sz2mKA+R4AjtPX0O5JujIRwn5ced9?=
 =?us-ascii?Q?Z6+uPu8u3SoaQPUp9I5d4MhD1LNh66ueDPNORKRuUXWIQWl+EvgrBGn67IEL?=
 =?us-ascii?Q?USz5pRyX/+E+GYRK5xFxdk1xPXrMPqtZV+IbnwrZW/+WaSUFB0xrDDOTLM6f?=
 =?us-ascii?Q?kBPUBJ13YbD1/6tK1US4Xj1QWZyJuOw5pLuswC+Au+pcbjQZHjHSPjGkROPx?=
 =?us-ascii?Q?HI0HasrOL2KYwIDclBseiznwugIdPcleZlT1jwVO/UDbWzjxbezPMX+tE9Ts?=
 =?us-ascii?Q?rCJu4ZYw2YKlYFj97wSu0AXgr+Yo2kFc+EL9iyp4dvIUpmtppEQuIS6EpLj2?=
 =?us-ascii?Q?7/2isVT6yMbCRbGhdSO8mPpYx/MoJLlaREPx9a16bIalA+6geZfkhoQsc33+?=
 =?us-ascii?Q?L+Q86Eo37vCcQdmDt+zk//bHYoYrY1N2OG3WrTLl?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB68047B22F8D2DE1374D46B61FC64APH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67325b71-4430-4826-bcc5-08dd9d2698ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 13:58:45.3588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkUOSTKCCOKcZUZf3lhpXxdCeRQDaqnLecKU5Ks3RhJFBsR8hyRlYn+vv9KQsSeGR/+t9Wm2iBzqMg8kHWgteg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
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

--_000_PH8PR11MB68047B22F8D2DE1374D46B61FC64APH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-05-27
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
- API freeze (-rc1): 4 June 2025
- PMD features freeze (-rc2): 25 June 2025
- Builtin applications features freeze (-rc3): 2 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 190 patches ready for merge.
  * Will start to merge to main tomorrow.

* next-net-intel
  * 24 patches merged and pulled.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * ~20~ to be merged.
  * Ready for pull.

* next-net-mvl
  * Patches ready for merge by Friday.

* next-eventdev
  * Waiting for some Intel PMD patches.

* next-baseband
  * Tree has been pulled.

* next-virtio
  * Tree has been pulled.

* next-crypto
  * Patches have been merged and ready to pull.
  * New crypto driver for ZTE
  * New Algorithm: Snow 5G

* next-dts
  * Some patches merged.
  * Planned API changes that were discussed at the summit
    will move to next release.

* main
  * Trees are starting to be pulled for RC1.
  * Patches from Microsoft for EAL and memory.

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


--_000_PH8PR11MB68047B22F8D2DE1374D46B61FC64APH8PR11MB6804namp_
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
meeting minutes 2025-05-27<o:p></o:p></span></p>
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
tches ready for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will s=
tart to merge to main tomorrow.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 24 pat=
ches merged and pulled.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~20~ t=
o be merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ready =
for pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s ready for merge by Friday.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Waitin=
g for some Intel PMD patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree h=
as been pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree h=
as been pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s have been merged and ready to pull.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New cr=
ypto driver for ZTE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New Al=
gorithm: Snow 5G<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Planne=
d API changes that were discussed at the summit<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; will move to next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Trees =
are starting to be pulled for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s from Microsoft for EAL and memory.<o:p></o:p></span></p>
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

--_000_PH8PR11MB68047B22F8D2DE1374D46B61FC64APH8PR11MB6804namp_--
