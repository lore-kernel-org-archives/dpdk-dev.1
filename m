Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329CEC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4138F40E1E;
	Wed, 16 Apr 2025 16:54:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 176E740655
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744815251; x=1776351251;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+qILaU8IjX+5CbgEGVo3LNI9m28SKNebCDs7DtQzAyU=;
 b=fYb6lmCyH5Wkmm0Opn3XOvQxIstZk0ihVAbxSxFclv2fT4dtfTcavr9L
 mlPUnwZiaPxjsubrJ7Zf2AB4Cma8blwFG9WEtfDigo+oOYGKdqoZe/nRH
 bZTLrzNxJXj5fR/4Qm09m/yBwb4wgsVg9oukNkQkEJcRIkAh4d+ENw7L4
 hNUFuWRF8xyvtpBPA5KQPMmotkn87hiWRGlK3EgU/3v/jOfL0EBSIRGMu
 gpFyK14by0r76j1V1m7x5hrEXpBlLIzWfmNfzPDiprXtGMCUAOCJOE6ht
 yLpJn1iggFtctGx2koDrVchpxHTf/fBQ4mmh+egjjqhT8jwP5LF+bw84H g==;
X-CSE-ConnectionGUID: 18CC2ewaRRKFtNDCab3KWw==
X-CSE-MsgGUID: BLrPT11yQIijkVmGahFlJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="45503810"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; d="scan'208,217";a="45503810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 07:54:10 -0700
X-CSE-ConnectionGUID: aeLb8+0sSL+Q/EBepuhTAg==
X-CSE-MsgGUID: LghhhF6YS5a/9kJGoe07Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
 d="scan'208,217";a="135307626"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 07:54:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 07:54:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 07:54:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 07:54:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYJ3kldaOCtPHS5ynOi5WLEHbxpcmZVh8yJN4N+odfBjeDVttdiq8iMh5rUsriGT3Rlwm+fcWxBv3DDmQcKPH8i/XCygwMjhQFUMJQY7Xd17DfowJAxTtjBrtsaf6YrHhYvfMUUqHlDblmVWobFDgCFihB+XRfiqmBD07KWuyNrOgyTeEyNwPBnXb5hoP99Owk2gkrsWWu7Xq4FJzlD/z851voyz0eAFbpZwxr3vFL/vn7GuQn3nuZzM8EwIb1DHyMddHrqsSr1O5IjMGKTYL1wKndVfeCKzFfx5oxxr3Ns2RWy4HINMzntRpW+ehxFJdAQvt+asc/KbR8TWBS5Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdh0vugV+ZGKpcBeYI4lgsdwM4OqFpdZphQ/Z2nu+ng=;
 b=X6Eh1QhIydlqQXegSBOMiAuxDBDdNGwlQhhPPFaGsbfIbrrTL53V1UyvNRBH2xO9tt9DbkQxF37BMQJv/q/jOqD9Rv4LirUnj0E4nMfL4GfYBvRv74Mn2NVKta/IJgB+5LvA2qZ52jxXHlQ85cYq+8ay6836450t+kdAi9JNPB96DdtC8t1edFZbMAPYQGBbzyvFurUt6WHMrXLB85cwJqD5yY6wtmWusJIDZl+tIHujruyqQy+JXgirvxvBvdFwnI0ywPunk7iuD3YaXeU9nR0yvltLLaxkt44lnyVcQn9bt4UA8JtjsjKYLYkIky9BOS1tekckd3AiOb/a68g8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 14:53:38 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 14:53:38 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-04-15
Thread-Topic: DPDK Release Status Meeting 2025-04-15
Thread-Index: Aduu3z+DCS+UB9YcQ9CDRGuhsTOh8g==
Date: Wed, 16 Apr 2025 14:53:38 +0000
Message-ID: <PH8PR11MB680470573A118EAE462E3127FCBD2@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CY8PR11MB6868:EE_
x-ms-office365-filtering-correlation-id: fa84bad7-9a94-4b69-1d87-08dd7cf678a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cPlZ7D5RddqtS7zyx4imL3i3Ep/Bh6KpmELR3WyI2IAG6kWmw+JgMELR+kyh?=
 =?us-ascii?Q?ggY8qGa5dCv7/eDrr3EJaDCDLnrwQAknmmcWZZUsjcsbF/FkdUIs3WzQGNMa?=
 =?us-ascii?Q?Jm66KsTUSyA6T+5XVwKx/vvdRE6zzKvEZ7m85592b7wSurMffYUIAreJNZtM?=
 =?us-ascii?Q?IK7Xn+p+/FcHo2bzMraLPhWWMB/zP7bDdGoNmot2C3KTtBnW44KB3WklN4nL?=
 =?us-ascii?Q?KtqPGDjDGCoMcwRrM+JG5Umpz46neLu4n3rclotT/Zq9s/PhwNBfMmLELulw?=
 =?us-ascii?Q?0aGejBn9puDVd6S6qNeE98wjchYCxAVf8u9vPqx+KNZAw+47bL8qL+j3kTEv?=
 =?us-ascii?Q?iYkYyrIJBuyi3QJG9VC6HvtO5qHc8Q9XC0D9G4aCuEo+Tf9uhdv44811ekY0?=
 =?us-ascii?Q?qKO5MIs+8+q9rFwcnz5GtCWny2fWV62nMrjAvxLhJNG9i4VfOQ8PrkTp70CK?=
 =?us-ascii?Q?cDvDUIxmoJdvi6oL/2HFFec+30uJSVYvVLV5368yJFP4VJ5SrUQSriP154VK?=
 =?us-ascii?Q?x1qhtgd0EaaICd7t2wEbpHIurpQEJyNMngz8k1GhXK4Kusi134sxI3Tf52AT?=
 =?us-ascii?Q?5aiV6ELraDJDyc/GPjjJLGOmXf6upeW7IbqqhwBWCNZpwMWLCxh0mjgQ8zxr?=
 =?us-ascii?Q?xZzIuxnAYyX8F87M7XuAdgPOcctWT1z+nrNCZzp9jw9ouRL3/qfKZiqKF6Aw?=
 =?us-ascii?Q?HPzFEA95BgKoLRznVjMcsvtrNQYFoJ+PZ99dWXhkQn097mKFB6+6wiH/1IF5?=
 =?us-ascii?Q?3C2r0LsxoEMJjEyyv+LdxTiOH4czpepc3AZwjFHfJBDRG36Zh8lEutAed8IM?=
 =?us-ascii?Q?2MFHVx2UMvxfgEfesAl3eXqA37U0a3dxr6fSr1X+pfGU4GyZ5aqs235TzQUV?=
 =?us-ascii?Q?6Cq1nn4zB1hdnKTbRQGixBvurFK2OTg6zY4QL4zwHojcLyS7MFteXcVlpTvz?=
 =?us-ascii?Q?sX/p0bSw0JzNDvW4RTh+bBVb/Ypae6i2ftJ/SpX/dzRo6rH2HQ4TlNeghKoS?=
 =?us-ascii?Q?jFJJgrTHDugLTAYXyBpu4rd1Q/dds0IHcwDvslvgXC1dUNZMXvRJZXtLeAZw?=
 =?us-ascii?Q?Lmn4QjMqsJ7byai4fj0fQyMledJNXHf/zlEmBAvY+Rx5JRbCbCWwiusj9Oz9?=
 =?us-ascii?Q?SOBbhWW1lpFgEGv0ddT4B8K3lFjUrT6jDxRut+BxxCQXA0idFuDrOWDDyw9Y?=
 =?us-ascii?Q?oxj/i31m40BwKt8+bdjK1vbpGgwJKIkGcjFbpnLmJrW9i2FxobFXp8hlY37C?=
 =?us-ascii?Q?6QVpzxq/sDLg+sUwnettm4FZ57m3kTLoAfqRTiYkxb+XqweaOqjosyOwuSlh?=
 =?us-ascii?Q?/bEPe76C3Jn1B9W/5TWEJychP6oh6RUj42X0NTOiQKBvapoZ/q1tzVgRlfa+?=
 =?us-ascii?Q?heMuV0McuIHS/PWaG6QVGBO8hIjG6wqN5UZJZq+x98rVKuYcTUo4Te3753VQ?=
 =?us-ascii?Q?zagzb8C32gR4XBKPAT9kjJxmfHCIvynU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1GUboZMNS14uT9l84NX5TaXmuWJEqybFcRl41vCNZz+vpWZh70MGFu4pz+l/?=
 =?us-ascii?Q?2t0mNCtOHgoaytdOEE2qWxEOmqZPayngClEmjRlkssGDcIvpc9lFRyL6Fiqp?=
 =?us-ascii?Q?dwKOroqZi3Y2qc8ssK09OQch2t4692vYi0t5a37xE3AjculbOM/FAR1Ce5Ex?=
 =?us-ascii?Q?2Qm/EHPrYxoUnez0UKKIT0OWIGHL6yj8srb2lWu3Q0ju4qT386Jc0wvO9B11?=
 =?us-ascii?Q?VRteyNrOqJ2ubhMgUMfs2UWyRC3+67dz+nxjszSYAlNJ4NtHriC/nLHGlLw1?=
 =?us-ascii?Q?YkdzkjjH7TgckGTGgdFWaVAkEn8ItJNrS/zQ3HhEnEWZ3YszsF2W2TnmBWio?=
 =?us-ascii?Q?eVZEAc8mjkJ5AXVjuyKtBn9rmStUwX/pkbs7FPvDVZ/6gUM7+5IPBWgC+4+M?=
 =?us-ascii?Q?whNERnaBHFthlg7qI3nTqpY5bjdYA7vUIPlxNrKD07V21gzm7bUhYNHCzQKq?=
 =?us-ascii?Q?EJCQTyviabf4knRLw+N+9oHlDpDVlA2TjO3Dzen80NzGQ/E8CHuV8Vferarj?=
 =?us-ascii?Q?EyrQMHoX/YU4qrSQZOviuva+mBV/4QXaB+caYFxaXWrZDheu1LHEv/SJzXGk?=
 =?us-ascii?Q?E+TYaAADtDXYThbz9I/vY6chrcNlyUUjerQKvkDHxIyWTBI2fZhqjvkqh0Aa?=
 =?us-ascii?Q?MQDm+ha7N3HdMu+wBha6zOQ++LaVAEOotOsuhRYu3hOkVIUWCHH5hAP89sfe?=
 =?us-ascii?Q?RMEvVJpzhxPFCWRnPEJH6gXWUbyTRURyc6yqg1PiCEAxytfJfzi/HFd8UdzD?=
 =?us-ascii?Q?bxlvWmYtuRHtkqP5bSMC0DmfagyInEJ1f1RTQy9QTOpUOGUkbPCrc0UXlVfj?=
 =?us-ascii?Q?mddmoG0hennR3gtFynfw53x3NN7MqDN34GUmjh4bWeCZxerq+cTtH165ymyg?=
 =?us-ascii?Q?CeyOclW7Yj2WOU2IGEwzhXR2ibBvruEnf2R3SlUVVt2Z9ZtipEUEwrXB9riq?=
 =?us-ascii?Q?l0BzLUUb+UJJLOAAipg6crhN+xipRX8fUilAOcMfHgQBSFtfrFNk5Ee+kmES?=
 =?us-ascii?Q?qa3ZOKG1Vxr6M2y8SpS1DveSDntFVVQbaVRk9i0/nMZuR8PL2Dg798BvIt7W?=
 =?us-ascii?Q?XyUqw5Y26ECYYXn0jiRFFpt1+NE9f7q6RQ9EbsAP3n2Nfm/ETcLdoJD6g3di?=
 =?us-ascii?Q?DMIaGIVZiGMKIw1bVLK23qGytJrfBYYjMDiGgz48fI31R57uMqEDXkICdh/B?=
 =?us-ascii?Q?p6Q+Nbi4zz7O0WGtgYS4J1TrnZMbNbLhGRbKXEkvyAo4elwa7lHyDEyY9Boc?=
 =?us-ascii?Q?RRY77p/yOp8KXiVV6vjDhbnEd/Z6N0+c2/iZLbDYwXTYG6zo9cplg9SRAkqF?=
 =?us-ascii?Q?OMFXYr5MmxC30/oZEqyVNr9iUScJoDUmLzH7L+tkrUUCoFIsQ3R89ByAfJqZ?=
 =?us-ascii?Q?FxX9ydgJKqIINZxR3B+BbTrH1rxgS6G/MDjWgsbckgW/fuEl8Dk5zUd3ulvn?=
 =?us-ascii?Q?0e4dzTCFWxlYzKhNhe0OtJX5r/5iOkZtR/8QwG4eRWYv04h1j0+x10pgUPWZ?=
 =?us-ascii?Q?RR66qNhKWcCvxSyQgb3ZYCom3HMp7SPMm87b10lCqvF0Nc1PLdkeDLfDm5Oe?=
 =?us-ascii?Q?Fd7GAgdAh3KO5p9Qu1ijKG5GIKrn69sYgi2RUpd4?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB680470573A118EAE462E3127FCBD2PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa84bad7-9a94-4b69-1d87-08dd7cf678a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:53:38.4161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrAqY7Xob+bYVVT98rTiYHPvSGR83LNRIJHSAIjR0SUxZTfeeKh+uz0zjOUSRxM4w3jpUl3DnnlKi1Tlz5TU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
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

--_000_PH8PR11MB680470573A118EAE462E3127FCBD2PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-04-15
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
* Debian
* Intel
* Marvell
* Microsoft
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 27.03:

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
  * ~70 patches pending and around 16 waiting for review.

* next-net-intel
  * ~10 patches, mainly deferred from last release.
  * 2-3 new features

* next-net-broadcom
  * Gathering patches for this release.

* next-net-mlx
  * No updates this week.

* next-net-mvl
  * Anticipate 20-30 patches
  * Review and merge in progress.

* next-eventdev
  * ~20 patches
  * Review and merge in progress.

* next-baseband
  * No patches at the moment.

* next-virtio
  * 1 fix and some patch series pending.

* next-crypto
  * 20+ patches pending.
  * New crypto driver for ZTE
  * New Algorithm: Snow 5G

* next-dts
  * 20+ patches.

* main
  * Testpmd now builds in the CI with MSVC
  * License check approved.
  * Merged symbol export series. This will affect all patches
    that aren't merged yet and which touch the version map files.
    Please rebase your patches and resubmit. David Marchand
    can help.
  * Looking for updates to the roadmap file.
  * The following milestone dates will move by a few days:
    - (-rc1): 30 May  2025 - Moving to 4  June
    - (-rc2): 20 June 2025 - Moving to 25 June
    - (-rc3): 27 June 2025 - Moving to 2  July


Other
-----
  - DPDK Summit 2025 will be in Prague in May 8-9:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


LTS
---

Testing in progress. Ongoing LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8 - Released

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


--_000_PH8PR11MB680470573A118EAE462E3127FCBD2PH8PR11MB6804namp_
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
meeting minutes 2025-04-15<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
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
re the proposed working dates for 27.03:<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~70 pa=
tches pending and around 16 waiting for review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~10 pa=
tches, mainly deferred from last release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2-3 ne=
w features<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Gather=
ing patches for this release.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Antici=
pate 20-30 patches<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Review=
 and merge in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~20 pa=
tches<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Review=
 and merge in progress.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New cr=
ypto driver for ZTE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New Al=
gorithm: Snow 5G<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Testpm=
d now builds in the CI with MSVC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Licens=
e check approved.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g for updates to the roadmap file.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - DPDK S=
ummit 2025 will be in Prague in May 8-9:<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Testing in prog=
ress. Ongoing LTS versions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.4<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.8 - Rel=
eased<o:p></o:p></span></p>
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

--_000_PH8PR11MB680470573A118EAE462E3127FCBD2PH8PR11MB6804namp_--
