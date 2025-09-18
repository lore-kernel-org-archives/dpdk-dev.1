Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F06CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B9C40288;
	Thu, 18 Sep 2025 17:51:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 70FB04027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758210699; x=1789746699;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=b+dfXN/MclIuwxB3eMLUgSs8oQpGKUzLXKeJelL0hiM=;
 b=gGopsXnh82bdrMd55aIyREKL9jQ6QQSw7i13vrEoADRLxMuL7QcO2QGG
 7hlDM+L4/gpURePQDpXuCCo0dlHqOQNZUGX90sW2LseplzUo0TgIQ90E4
 gQdK26e1yNihq7Y/5LYe08CN9B0br/o1tBS/Np+UrWRNJsmAh5xUaX90y
 VSMPJQXLTiNJqyH09VuGm/zTCyCNhFt3RJizbnOnTntfHqkLyHJuw8JLl
 MP+ER/iLOOO1B09+8Ib3RgIzDJDa8MGCElp+X92SvJh9lw9iQPqz8WDox
 y+ux+ExLDPaT6UtRiU+VFD/d4eDx/Dg3o54WUHOJsj/h7LJORU2TI3OCx A==;
X-CSE-ConnectionGUID: qLSHnhI6QY6WAmQw/drjvg==
X-CSE-MsgGUID: FIXwudJfT2uj4QHaDaARiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="85986431"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; d="scan'208,217";a="85986431"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 08:51:37 -0700
X-CSE-ConnectionGUID: VAcqy2oaSk2L8LumZ4rULQ==
X-CSE-MsgGUID: TKFy2/BcRRWrhrSzau1h2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
 d="scan'208,217";a="175644363"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 08:51:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 08:51:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 08:51:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 08:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeURU7mCs1ERc7ZWDozgjTkY3VU4UQ+fAi6XTiXYoXl8uite2U0mT1drmrfx+ArZVCb4sUWsWNa+4Wk0ufAbyH3BjonfLv2oETJ4BEtFikeJEU2DaC9eOegCkR/ocja6CjssWTaD3JWoLb3Y3YSrRT0a5rCSkgIMfxLiXmTGUtY5itbXnt6PsGqfO4/x6GQE9+sn/4s2mEbmfbUPVsFMpy25i7vX2tqT9uMbeoF1MPHaQakDat5IXwaFLxVcXWHjnAZRO2Hwt0Miu/cwULp3t2hhgPpfR3z9yNYr+kPZGwo4+tji2h4YNGGnf5iUKDkBQfoo7Z6NTpbvoaiW7N5ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0U26RFcFKRCQWVVMftdhLz2MBNizs7Nf/oIA2Id8CE=;
 b=CZjkF6O1N93O+seOv6Ge1nShDLOT/fbKCIsa7V449t/0vEbBTSPM0DlVQAonqR+1NuY2YCV5yjulFCbjXd8YQX1apCNfvndl5CHnHaDgv/rxbHiebP3xlVGRx64tatyj4kPSIJDBR0p0Jp3Z7+kFDQ/T5AfYDbDSciXWYAk27VT1rE5cZdRZM2aNCUkEuLXT44vlpU8JyRwU7YxbFFMQ7QKnBr9LF1XEUT/87h0H9V6U71F9RY/sx5T9UtCZky1bWcPe2pilelV+r6NiljxWcAxybODBMXPihgzFZLeaGn4ge0S6c+IvgqVvwZeohK1v6iOgBUS7Bf2ZzPCxMhc53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by SN7PR11MB7066.namprd11.prod.outlook.com
 (2603:10b6:806:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 15:51:29 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 15:51:28 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-09-16
Thread-Topic: DPDK Release Status Meeting 2025-09-16
Thread-Index: AdwotAlnkXrg+Y7RTrq5aaIejWbOrQ==
Date: Thu, 18 Sep 2025 15:51:28 +0000
Message-ID: <PH3PPF37F43E35DE71DF96E1D74033980BEFC16A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|SN7PR11MB7066:EE_
x-ms-office365-filtering-correlation-id: e9ad5d0f-099f-46bc-a896-08ddf6cb3af0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QyzpOS5aPk+UzxE8mDr+oeUqjR1v3q17WVjWPmj8XaGqpyd/FtgpHudR6r9K?=
 =?us-ascii?Q?GHgvM7uDL8oTuDGoMIyAAdkOd45A33EuTQrR9AiWTkrAHbhS7yXK81X6da67?=
 =?us-ascii?Q?mbXJgqdZCJITwxZCDDQfPk8wGLVBNqlDlTsphtEutXkayqxGWwyaRBCpogFv?=
 =?us-ascii?Q?MqbjqMLR/iNNTMOw71aQDpTOdeI06z1mXDqAhwwnNICkA5B6rhK4ExZPAEYP?=
 =?us-ascii?Q?WwwjlWEB9DDf4gbcJfLn2K2+0rgJtPzcfUm6AmUYm0e6BJcuY50ay3R3hZmn?=
 =?us-ascii?Q?o7lhFb3MF3+hl41cMqswjMM3P8msgScKT9nza9WjC/OkRfusfB5mk08E5QrN?=
 =?us-ascii?Q?kgqL3y85yqmcSRUjmKXXd7UuRGC9DWr5iTmFr2EQqWhIl73Zoi4oSpaeQ9tz?=
 =?us-ascii?Q?hFVpZh3P53yj+RigXiDwhNYwHwsl9hboONootBCC+2W94DEwn5J+Ki563EWU?=
 =?us-ascii?Q?huR3n4lHn0ls0m/yPl6wv9mOY08aS/L7gXMKkRFjenT858bZ7weg9oCXIGE0?=
 =?us-ascii?Q?XZ0jYgNRI/ATUaoiiBRSLweqMqyieLqb2jysEC7hnaTJ29BcGXWns2PCu8Nt?=
 =?us-ascii?Q?S8LBFtvCP5CWSyOTACZeMWOtTgu+IOVxusa0uwFCSeWpCFVqrfWZhMqV69Wc?=
 =?us-ascii?Q?LNcaK11dnsSfslq2T86UqAoc4WuIvAEv2KIGQ3upGqi4IOiYFTBSibP2NsoR?=
 =?us-ascii?Q?aSjpPafLljHQhwKd/Zv/Jyg74o5YVtPnfb19oqWUaMw8gGbTqjkxaaJa1zjd?=
 =?us-ascii?Q?fjYgD/KyzD0FSHHW1h8IFOhaxmZkXLiLBlnmDZlNQ+MtGCUstUxiDfBpFFsB?=
 =?us-ascii?Q?QZS+T3VGu2Z6e0QJ8xj/q3lhoZqoeK4qhHYqAovyRaLnUBmsWEhKKhfHvZsF?=
 =?us-ascii?Q?CfGG6KMdZHr50GE7CVgH5SDU1R364vkrDTBArDN26NeI3Luey1SnOprFCAAx?=
 =?us-ascii?Q?gHsdhSncIU59Oy+POJ7F1NB6pS9vK12tu2wrYWsah2Q5E2Yq+C1M00vNUAu+?=
 =?us-ascii?Q?SkCYF5fOc4IsO2vecBpmYjJ2H3ytgy67p/lDmBXFdGY8CYxKG1dYmEX5N6Av?=
 =?us-ascii?Q?m/9e4iX77aW65XcdnU3OQutJRi444LZKZnhoI3lnFjkL+C1gPGKfpJa+allP?=
 =?us-ascii?Q?wxPqPsHyU3B/bf4w9sWrX7DdpSgFHmgOy44jy/a7N+iK0BhJ0+/c1tYP4HkO?=
 =?us-ascii?Q?+DjDhIY/ixG18+NZ2m14b0YCTzMEO8wo+DIJ0W8kDMR3IV/bgdkgXylpDqJQ?=
 =?us-ascii?Q?vuXM13lgsVBMmvIvM/cihIsaY2HkGZf5s3IfTlS//wWOF9Jmvuv1dlAhyo1g?=
 =?us-ascii?Q?yPqwO3J6q4cc4wzxlJffpaiYC3Cw0O+wD5JH9OGIENAaGwsD43HQalOpjn4K?=
 =?us-ascii?Q?2sHAgCKT2Mhu4lv3O2hGkUPEzLe1ZXo5f2pjy7ZEZA2+8Dt3lEgih4QuQ77n?=
 =?us-ascii?Q?6GHArJI8vRs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAZ0+Hz6k9NH5C62jeSvC8R0uxckj7wF5Sbax/5kPW7CKcR3J9LsYYR37xG7?=
 =?us-ascii?Q?qRBxIDL8fJHQ/ytilmmqCdolj668FxfPCdj+sgONJja9HTTdEQ/PCRH8xK3Q?=
 =?us-ascii?Q?1qSba6Y9MoAR+g3+Yfde07S4jNdqn1iPXL2AAsRdcYWzQybuJXcUIuIZ9gUT?=
 =?us-ascii?Q?qpF+s6Ude1MuIRkgFiLhdH9XvGZXsY3s3/syPeizH3yXaxKrBIKCgetFZpRJ?=
 =?us-ascii?Q?UxpKry5A6I2Az658NkhUjwk2GRwBUgXZWcPdcxaWSvdTie3mNfDVRblgveFf?=
 =?us-ascii?Q?UWeJIoJe6sZXoHzDXKxuArbGgJkXxUgmTJUzYSbgpJrp7k8iToej3wPyCXyX?=
 =?us-ascii?Q?u0cZ0xeVUzC3sA9FNv64CVTwPhP3b0Nt0+ElLRDNlJdJBHXu3AUjDLAR1dOg?=
 =?us-ascii?Q?2vWLrNb+XxMqdAxBcva5GC/hIzyittGzZxG1mSo3v8tP3cCORvRvzL+6+YbD?=
 =?us-ascii?Q?TBKbXJRWbIo9FopkDAR0z4SuKIstrcUr4ufNSqZShZUt844Xw/gNZ6cVAmKG?=
 =?us-ascii?Q?BSLYI09DPuQP7UqyM+9yFPPAzX/lIYhrHwvf5lQcjqbyoZUw8k1Pwf4SeE9n?=
 =?us-ascii?Q?UYbJQ9b5HaaAukSOoostQLuKdDiCkEGQs9sIR3wTpOUp9CczI1e9R+W5Qe6b?=
 =?us-ascii?Q?lDUPLnESMBT/bWGoSS7LTCFjgKIZgf87BaCCXDwQKq02GVNHIGzdzxBDAPK5?=
 =?us-ascii?Q?DocloUYRqwOq+8CxhnUX/z6prgbnmap/LVwE0negE4IsJmBdNg1YnjFnqlRF?=
 =?us-ascii?Q?pMVSY3jP5cDKQRlBhUiQ7BC5t/t9LsSgvu4yaKcHod+oQeVmuA9tSzFXEFGL?=
 =?us-ascii?Q?hVDZxapK/NJbTYS07Y087mGliMG+KhNmJcttz903aZk2MGMRBJ2ATv9PjfYP?=
 =?us-ascii?Q?230F7uh0WFc0I8rKE6MQ4S0faQiPmBdtj5kkzZa3HxFi6XbPUKqouWTfo25y?=
 =?us-ascii?Q?9a/ykgc7g7CCce6jAL0YxGsWCZvhVB/rOhZ95QU9dcfwsbWoS9vXusjCMEq6?=
 =?us-ascii?Q?Ri0yXTOS35W2M3WSk7EdL46gJSMpHuiGP4jkpveRv3Ck96lx8Acf8WY6/I6n?=
 =?us-ascii?Q?J5qmXRzkj7Zg0qDYsX9sh6YPj55gTbJhJ9BqTs+eUIrxHPqBLPg9ub6EEedx?=
 =?us-ascii?Q?XMnnuvXETBcF/Oo3wP4VWDbulCKAK+AkmNn7E2z7bB1UB0ptnRlDgBNCHFb3?=
 =?us-ascii?Q?TUuX105oVvJiJztDD5UtaT0LtrQiEpv9EFhdvzbJCu5zOlGH32mT1h+P/x+w?=
 =?us-ascii?Q?y7VXv/yicAV1u6mb0+cR5B6RHBaJG4hsgRdHL+bCX+G57c5aZPSYgxrx+D+9?=
 =?us-ascii?Q?gBlV7ZwrGKi6hcPthsInu4Z6+3nnqx6QUOj6AG0uh08/eFK560yZqde86bgz?=
 =?us-ascii?Q?/rjj77H2whNcZ9Nq0i1HNrFU3JaVGy8S4L5RJQ5yLSlT5YuyIB/8oPgKIa54?=
 =?us-ascii?Q?dam7gvafZwm78u80SbwSPHsMGtNUmZLel0yx7GMHzljwvfDJ+m/TbiD59GzK?=
 =?us-ascii?Q?DxzmsnIMvvkyrRtO8QhIzm1Ns/7U5ifDWU5O0iRuGfpuelRkbcXwPiLxVwSj?=
 =?us-ascii?Q?XNvJNqxer4XMp+juB4vm3AOwUxXDa7Rzna5jwjCs?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DE71DF96E1D74033980BEFC16APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ad5d0f-099f-46bc-a896-08ddf6cb3af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 15:51:28.4093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+nvI1iyaol17ReJiMnpw7+5MJf69TVRC6xMBv8GOXOxtC/8JmhpYHP5+PpdqlqxqNf4ljcmswJdexAJWLqOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
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

--_000_PH3PPF37F43E35DE71DF96E1D74033980BEFC16APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-09-16
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
  * Most patches in the current backlog merged to main.
  * Some other fix patches pending.
  * ~40 patches in queue.

* next-net-intel
  * Next-net has 8 patches pending for main.
  * 5 patches that under review.

* next-net-mlx
  * All merged.
  * More in the backlog.

* next-net-mvl
  * ~25 patches under review.
  * Will be merged soon.

* next-eventdev
  * Under review.
  * RFC from Ericsson.

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
  * Some patches merged this week.
  * Some more in review.

* main
  * Most V1 trees merged.
  * MSVC patches fully merged.
  * Working on namespace consistency.
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


--_000_PH3PPF37F43E35DE71DF96E1D74033980BEFC16APH3PPF37F43E35D_
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
meeting minutes 2025-09-16<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Most p=
atches in the current backlog merged to main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some o=
ther fix patches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~40 pa=
tches in queue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Next-n=
et has 8 patches pending for main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 5 patc=
hes that under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * All me=
rged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * More i=
n the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~25 pa=
tches under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will b=
e merged soon.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Under =
review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RFC fr=
om Ericsson.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
ore in review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Most V=
1 trees merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * MSVC p=
atches fully merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Workin=
g on namespace consistency.<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35DE71DF96E1D74033980BEFC16APH3PPF37F43E35D_--
