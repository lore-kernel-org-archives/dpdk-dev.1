Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055E606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CMiUwUws;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Hw1iYm9B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC8324029D;
	Wed, 18 Nov 2026 20:12:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 81EAD40298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 20:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795029139; x=1826565139;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ErMaYSlGmi59CPh+EtB7u8lJ+6xxubmaJFfFyzZQiwA=;
 b=CMiUwUwsT02yO3lwXkVJ2dE4HGQOIKOAhBlyslzjjslog6jqTN4ne0++
 cRB/aWG5JZXIAua81nszxmWTPmnQ7mH5Gr6ccJIoFPvlEnJCkvSS7ZHAM
 LZ0fVevFa2kplNqD0VXhzTAhUZA5wwVGC+0gmsGWtfj67PPBpEcbjpGEQ
 Jvk5PLIuLm/dtsiFreZt4lzZELgIvHLzEyZCVA5iaEEH/JMflOpJpqhYf
 t96/r9OszaImC8dRE8sbS9iIToyYdvoNazNRsEw65leizAKCPLWJIRVFc
 yWqxVT3q8jBD25WYCazU2SkhWUgNyV+5vypNnLldC0FVLY0nvpPQgG5LC Q==;
X-CSE-ConnectionGUID: zKCLwKz7TxaYk8+atTywTQ==
X-CSE-MsgGUID: 2cIz5WJhQpmdrDVfgxXZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3934049"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208,217";a="3934049"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 11:12:17 -0800
X-CSE-ConnectionGUID: E8HGLGPWRxORPRbqYpmNKw==
X-CSE-MsgGUID: m6ye4T1xScmyi3HqtrkzBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208,217";a="12039576"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 11:12:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 11:12:15 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 11:12:15 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 11:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s827FZFi9CXgOkhNEj5st2woEUkt6M2dI96x6kNra8spMGCMvu+eISkdCVYrSf4em5RZ6uZnk5XcuV+IcqJmy9M47XzKhgm40N1coRJJsRb88mo4Ry2qyGnTamLnNiKUK6AeMFvQS9sVgyn/silwRKm7ewD3pN8/81YDcBk47QdztdMXeWIOG+H6sp6vJY1WV1ZtWGX0LAr0FZioc+4HOQ7CCzD8IK8gvY5eH9kc0QossRg04pFE8Tpup2XMcyIznt6o6pS6p3phItXYd6CsnrV5l63r7R9Lh4ojtoIJ6FxpRw79JtffxsbIb4VwGkmssA6QjfQnVh1cydu4sQ4zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xscwgfWmYhPF9GadRZmUUEr5ZVqKD2F/Mw8oo4Lofxo=;
 b=Y+pJ4QylXP/hg/iwD2xElhc/GrxKqJ/jsxXA7KMpsHBkuJEPKTU31msB/MwM+Vznt7tXzOjHcPUVub9YplW55JDgxV6J5cZsGRFo9p7of0gRhjBDBe2wanAAs21goL4wb9ClkX+Hn6R4e87w9jc6HFdVdci8PDsQ4r36SEin8SNfZ/X0vlz2nmprwskLVuvk9d5WbhMhaX+yx20YtXY0cbvu/r9eZvM+UrIre3i5pyNI/2UgCBAoe7dmKb90KWBkL7RtiXT3zuXpuSylh6/gL+5XQ06DWy0tEeZrCvk7g+yyDNWAD1aLAwtpb3RJGey9arN1M6Mi1v9Ea1WY/poKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xscwgfWmYhPF9GadRZmUUEr5ZVqKD2F/Mw8oo4Lofxo=;
 b=Hw1iYm9Br5q8iZCH9Hnxch10OiF/gJ120gPRNMTVwwxaVyv0sesPBR7v9LJSRHtZfwFGr469G9p3mCp0BUzNGmAbR/QGXiQrOQ9KvqWN4US7qPQPj5fH0UgzY351R+lZRc8x2fOAaEEard501GKvZhpItUcX7nu9nr1coRs3Pf4=
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 19:11:51 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:11:50 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-11-10
Thread-Topic: DPDK Release Status Meeting 2026-11-10
Thread-Index: AQHdd5CRhmvDmtF9/UWPLOShe63Wrg==
Date: Wed, 18 Nov 2026 19:11:50 +0000
Message-ID: <DS3PR11MB9646581EA3091315B2F484A9FC7A2@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|DS7PR11MB7886:EE_
x-ms-office365-filtering-correlation-id: 0a106508-cec7-4490-12dd-08df45a7ccba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|8096899003|56012099006|11063799006|261028144727099003|261009223027099003|10067099003|38070700021|261026121527099003|261026140227099003|261022105027099003;
x-microsoft-antispam-message-info: XfZD3uwaObjDS15nCpFAePBs+5mV5hJRP4Vg2OZZQollNbXzFQoxVRJDMp6TvDVCUa4dqDnIKB3J2EDP/2+qz5HRyhgIv0m6pvXLHw868O06JFCRJJs28Kn88rsuKSwPvk6eb8Wmz37YNs5BFQssly7EixGFwl9UTNI9mmu8ELRY3pJLyRwqzVg9cmcDc77/PTUQQ/3N2IGRj7Uvc32OQ3ObKUYv/g1P7v5sOFFyNr9mxuXN1ane2jHFGkDGOPQPNW0+89OtxlLAOJ2NJuOOByTlxZKkZ5GDAoAU/e1l9CBK74vTaRJglQHfHZrMJbx1x3WbH0vWuZNlhCHXDvvEldCMd6mLg4LKbGyip4YzoQgy/bgMah8hHREjvA998MImbnXn6+oGmq1khX6mDlVNetxmZpdQpzz3orFy+hwMbosg0nPui9xb9wTuXJYNVhgbUAGZWTQu4KHtLowaxtkB1+iXnt/gKFeQz50cbri68ROfm2e9Lfgvuz5+w+5G/r4/aYaWP1bOZd18zaznXt1GoGrMAeK7E7isNrSlmDNjKD4bIN0LxnOPnkYR4WJH/po3AsljZxcED3KRSOwcwGP4ja1b6WAAqJKP+I9yhNyIKX1mmCmJrsbeP688PJWrKhrR2aO+hVD7tv5B7rhtzJALJaERYcA71IJXjNOEpVDBg1Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(8096899003)(56012099006)(11063799006)(261028144727099003)(261009223027099003)(10067099003)(38070700021)(261026121527099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C1kfCCKq5HEBErSDCUYlcyf5RpTHjD9J7nn7EAmCChsThzQgzM5ALzlPL9?=
 =?iso-8859-1?Q?WMC0KIx4pmuIoQ/omqQNugerpnkz4YWYZDmm3zb5C4N2ZX1IxHRP21//J+?=
 =?iso-8859-1?Q?LRLWbfIB4xzpS316HwipygTfxOzhNmPO+5p8L8zsqiKZly50Y24vvOkyhK?=
 =?iso-8859-1?Q?HzGKFi/T7Z/oCyEucW/VwkDnu9Su2/yagj68V4slmFp8W+79x2bJZJqzIC?=
 =?iso-8859-1?Q?R/AI+hjQOU7TUlNtTmh1FXZ2Y6RugYpm8gMH/awrKEHUJ5msRcMLB1jA9Y?=
 =?iso-8859-1?Q?ybXwX4yzQ1JKcoZWDrhbjYGFJZbqALAe6cIAVooYzKwOA2STnyzSirCkON?=
 =?iso-8859-1?Q?Cz6oHl5oaizPkwgwk+jTMSC6Mkd0N40RO7x8rRzyFA1EfZTYsnmq+6Ckmr?=
 =?iso-8859-1?Q?SRA9adLXGRMlaqI7ainpUzECtGq+B8GGYUt9UJUsCOjk71tZo0Ubo1O8yG?=
 =?iso-8859-1?Q?j3Qrb3X83mfzvHOhyej6Ggex0/YU7Ju74whXhrEWbE3HQMqeQNDv2Z4TO/?=
 =?iso-8859-1?Q?golZNxGpc3ji315qeuOY24b+d6th458z1F4xF+94zjmuAJzwUGCz4sCahK?=
 =?iso-8859-1?Q?cmtOIHq7aiFpk5nwPT/8HD966kBbGojj4eBSLbix4fcd489+7vqrnrqeu6?=
 =?iso-8859-1?Q?kI32N2/uGtRRrcRKabNHJBUmmQeEzwMY5cc1r6MViYglewbX2IQg4/PZcn?=
 =?iso-8859-1?Q?IqpMUrjK9TPqPOe56PIgUSOP7Om5z7njdrujlb2EiCMoGvdkvmPPPramHr?=
 =?iso-8859-1?Q?Dfz3fny9FM7OzmA75m+Iz+7ZU4QR2AibEOLKHVlgb4aA1lmwuIebbWfvlZ?=
 =?iso-8859-1?Q?BQm4DXMd0UtsSmtXeA+GdPBL9ukJYIULvy9tqn40UR0HY3+GEJ6dK0d4sA?=
 =?iso-8859-1?Q?533OuUJNn7/jiz2zWOV3t9PJcz2VneaPwQLOM4N2GNa5Omnb0rhOxmj/uB?=
 =?iso-8859-1?Q?b1ezWSkraY5VUfkQ70MPLyr2AQKUGtzR3GV7d8A2z8QPvSN998zph1ULYD?=
 =?iso-8859-1?Q?aUk8HB0DexzlhWndnKiPj8DznxLAPucAba7oo46mQw/i7s9idFD0K6zxal?=
 =?iso-8859-1?Q?94wPPcoWt/FXvoeWWsh6R+w/Gs9aUufwwp6cOr9J9F59qxeI9ulzuo+Z9P?=
 =?iso-8859-1?Q?U9ikKGePZzNpZmGj0qLq1HyRyaZmyGhgWZJGrYYkhmgRcvrqWgFOSyy0XS?=
 =?iso-8859-1?Q?2CrZlmatTgFzWtdxpmojSCZtBoQ+8c9WpXI3SYQ+V8hxOBURMzr05ockS8?=
 =?iso-8859-1?Q?BeELtZQq+eKnNS10wSTLQ1jLeuR2Nl0VJXujXvlu9JCKvmLPSvZ7U63J80?=
 =?iso-8859-1?Q?KaZoan1DEdfr3LsgxY41KmL5JRtYZYtFqHPY9IR7odnR+4s+dhngcK87QK?=
 =?iso-8859-1?Q?Pe2PjE3hU71qY8aduKOobSIgMfDLjPx/VvBwCYivGZ+a8T2Bjb5l7/xWjd?=
 =?iso-8859-1?Q?1y0TpGzXvZjqZBzqBdtawZQ+W3xVXH9DqQQ5CB6IPrLToPCVp2wSWtMkdE?=
 =?iso-8859-1?Q?dlv42fKNw0rTKQGLnyXrKavdQS+F6uhCEno5M7KV6FlT/9s/q78JlohK7w?=
 =?iso-8859-1?Q?DUfKziBrk77tgnTBNpyiLHrQOX6FRHeRkHbo8oOn9STzEQuwOQBPQAa7B5?=
 =?iso-8859-1?Q?TJiPlNRCy68/B5QyivbmLNZIKo5zjobnbynQC5n5DRj/FPwN23wg5WvFDn?=
 =?iso-8859-1?Q?+Kk5KBU0RfpgFkYAlplFxD2EWYJx0yeykqWLqLIoLhwuMiWqGySSnR2zzD?=
 =?iso-8859-1?Q?F+YXtHdBHnI02ECO/G6KHrBS83n0Obbwpeiyy/4/nIPdqL?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646581EA3091315B2F484A9FC7A2DS3PR11MB9646namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GWI1dUqkp1OjyRdvcXPXlLPGft4d2AfUrpFPKuMWx0DYfBvOawZDxvH6IcrzHWwdqRcg+tMi5nBlzyhr7WFB3QHI93J16T/Yw5lvlvoeKbj5T6Zrd3w0EKcFQnB3srEVSqXjw0qJslqpgsjTgsUPIRUZP9wYKDTnLb6zb9ZTruiBmsHrMtcOcluoEF7ZgEAQq6CZIRz2oVvHjKkK+mSCfnYh4+8k/VRqs6EZwHahWRH2Y/qLPhjGJ7flfJ4004+AOOM10yvrmrQZI4CvbSgDcLuY+3fTac5Ve+Ebh06TH+q7DaKGY/V0Tcje0dEw1ISpYoXLEonyizljGEOqvjc8SQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a106508-cec7-4490-12dd-08df45a7ccba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:11:50.6115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHvT3FsL5HWIYRc28q1sTV+ScVkH6bGGvC9FGISA+yB2eUZvEXeWbhLZwEAP6DTHjtFtPzcAFO7sLAJmdxZTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS3PR11MB9646581EA3091315B2F484A9FC7A2DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-11-10
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Broadcom
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.11:

| Date             | Milestone        | Description                     |
|------------------|------------------|---------------------------------|
| 31 August 2026   | RFC/v1 patches   | Proposal deadline               |
| 16 October 2026  | 26.11-rc1        | API freeze                      |
| 02 November 2026 | 26.11-rc2        | PMD features freeze             |
| 13 November 2026 | 26.11-rc3        | Builtin apps features freeze    |
| 18 November 2026 | 26.11-rc4        | Documentation ready             |
| 25 November 2026 | 26.11.0          | Release                         |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 10 patches waiting for merge. Will go to 27.03.
  - 12 patches in review/waiting.

- next-net-intel
  - 0 patches waiting for merge. Docs only.

- next-net-mlx
  - 0 patches waiting for merge. Docs only.

- next-broadcom
  - 0 patches waiting for merge. Docs only.

- next-net-mvl
  - 0 patches waiting for merge. Docs only.

- next-eventdev
  - 0 patches waiting for merge. Docs only.

- next-virtio
  - 0 patches waiting for merge. Docs only.
  - 1 patch in backlog for review.

- next-crypto
  - 3 patches waiting for merge.

- next-dts
  - 0 patches waiting for merge. Docs only.

- main
  - Fix for the NTB driver. Next release.
  - Virtio fix.
  - Fix for CI.
  - RC3 targeted 11-12.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.4 - Available.
- 24.11.8 - Available.
- 23.11.8 - Available.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.

- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the main tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.



--_000_DS3PR11MB9646581EA3091315B2F484A9FC7A2DS3PR11MB9646namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release st=
atus meeting minutes 2026-11-10</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Agenda:</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Release =
Dates</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Subtrees=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Roadmaps=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- LTS</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Defects<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Opens</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Participan=
ts:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- ARM</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Broadcom=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Debian</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Intel</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Marvell<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Nvidia</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Red Hat&=
nbsp;</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Stephen =
Hemminger</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release Da=
tes</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
---</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The follow=
ing are the proposed working dates for 26.11:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| Date &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; &nbsp; &nb=
sp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">|---------=
---------|------------------|---------------------------------|</span></div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 31 Augus=
t 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 16 Octob=
er 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 02 Novem=
ber 2026 | 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD features freeze &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 13 Novem=
ber 2026 | 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin apps features fre=
eze &nbsp; &nbsp;|</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 18 Novem=
ber 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation ready &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 25 Novem=
ber 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See https:=
//core.dpdk.org/roadmap/</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Subtrees</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">--------</=
span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
0 patches waiting for merge. Will go to 27.03.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
2 patches in review/waiting.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-intel</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mlx</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bro=
adcom</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mvl</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-eve=
ntdev</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-vir=
tio</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
 patch in backlog for review.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-cry=
pto</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 3=
 patches waiting for merge.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-dts=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 0=
 patches waiting for merge. Docs only.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- main</sp=
an></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - F=
ix for the NTB driver. Next release.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - V=
irtio fix.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - F=
ix for CI.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
C3 targeted 11-12.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Other</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-----</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
one.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">---</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See also: =
https://core.dpdk.org/roadmap/#stable</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS versio=
ns ongoing/released:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 25.11.4 =
- Available.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 24.11.8 =
- Available.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 23.11.8 =
- Available.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Older rele=
ases:</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 20.11.10=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 19.11.14=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Distros<=
/span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - D=
ebian 13 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 25.04 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 24.04 LTS contains DPDK v23.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
HEL 9 contains DPDK 24.11</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Defects</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">-------</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Bugzilla=
 links, 'Bugs', &nbsp;added for hosted projects</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - h=
ttps://www.dpdk.org/hosted-projects/</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">DPDK Relea=
se Status Meetings</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">----------=
------------------</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The DPDK R=
elease Status Meeting is intended for DPDK Committers to discuss the</span>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">status of =
the main tree and sub-trees, and for project managers to track</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">progress o=
r milestone dates.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The meetin=
g occurs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DP=
DK</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">You don't =
need an invite to join the meeting but if you want a calendar reminder just=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">send an em=
ail to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the in=
vite.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"></span><br=
>
</div>
</body>
</html>

--_000_DS3PR11MB9646581EA3091315B2F484A9FC7A2DS3PR11MB9646namp_--
