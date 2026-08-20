Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE70C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 04:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F34140653;
	Thu, 20 Aug 2026 06:41:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 774024026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 06:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787200872; x=1818736872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=8PsKeivuUg3YhqKpGmfiQjtTq62vAaA1WZ5CCDK4DJ8=;
 b=OPgfthYDCwigXmdmA8cvErtKOBckHiXt51VQ2JH4f+aRTdyRHVkHM3dx
 rVADmJbkkm/wBoZKKSjMGRaGmrPEL+y39SrT+JWuUJ8dioEbV6ksNoU92
 9fSE+4e+7ggEEG1AEFphZtWBV3y1515/jIDr0Daz85tofWzYmt44tNAaC
 wqkuK7zNhxm+ZMuaz5XntEBf+ux/UawF+DnvVWIL/OzqHVbF76xHvqtMH
 7W0fpcfKPHXTsVII3dGYZWTUKFfu8wmZchxolQsDCvTmSfhnc1bknS0aC
 iSY/+6NewV7cf3Mv7EmszA1oaPylDA4dzis5jP/mBcKdcW5kUmUfCjnlM A==;
X-CSE-ConnectionGUID: WlxaEjTUQcOBi3MHY+0Lvw==
X-CSE-MsgGUID: XUSrmBebR0+L9FyTVcfCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87489685"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208,217";a="87489685"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 21:41:11 -0700
X-CSE-ConnectionGUID: 3DlRZt7qTaacPrgUp1L0aQ==
X-CSE-MsgGUID: PSdH8p7VRWqPczTxTIBVfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
 d="scan'208,217";a="262532162"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 21:41:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 21:41:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 21:41:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 21:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuRe1WZQu3gWBrHWPy3n3+1NMFC4L5oP/BQ93QIHmBBc78enakIjxnY8C96mubvfev82O0R8My5ItXJO/8e7UsQN8SOIXnS3i7XdhV4TEN3tRZN721UCL2hcne4GiyiSpYZFj3Fi6JHuehhVwcSOEnrRf2g/jWgZkXOsIEXoqU9R8lM60b4PwvlB50Rri81vrjHqwnr1hskUWuZWXQlQQj0AbDtGWTrJA7FDq52+X/2TnD936qWAPAguf5xV2o+O/wNLH0tKeFzoubmK8UvAwACK4Yc6+pIJKpBOfQDgwmeow7AYDPQqieJ4/3INqa1FinAwtZFcSwzZP+yGBpN0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT2xI2Rn/4osXaMl49o+wRXNxqYIGuvtNQUQypa+HL0=;
 b=VCEyuVi7jW15VxgcHyozpnjHsE2d2LHD6eODmylzeNv+stLAs/VqWRDe+K1PdNUPynl7bPDeh8ceWDrHrvQyyPBJ/toJmkFr1Ww2c6qD3XaT0tMVOM0GDicfX9aRFtW282w3c8lNtMXmF5XPA4eI67IpO7Dji7CU6K4eFVnxydvmzz8Y/Jbacc7yDHbdmMSI5M69cSJL+GLUgA1BmyNHeXBYtZxYw4ImTz9e04/TijG9AkCbS+y+Ak4oO8XO2D4dUMiHTtgjRzJg4zCRtCG57j3DxnPKNzCDQWWcYTYLmKoMQWNwoOa7DAGVcqcnzQ/aK1o6wjDzwjHcqhmqbTR25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB431006.namprd11.prod.outlook.com
 (2603:10b6:806:58b::12) by DM3PR11MB8734.namprd11.prod.outlook.com
 (2603:10b6:8:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:41:06 +0000
Received: from SA3PR11MB431006.namprd11.prod.outlook.com
 ([fe80::df97:b201:1673:934f]) by SA3PR11MB431006.namprd11.prod.outlook.com
 ([fe80::df97:b201:1673:934f%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 04:41:06 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC 0/1] ethdev: per-packet Tx timestamp slot management
Thread-Topic: [RFC 0/1] ethdev: per-packet Tx timestamp slot management
Thread-Index: AQHdLn4T1K59liIGFU2CKtNBo8DiSbamXKP2
Date: Thu, 20 Aug 2026 04:41:06 +0000
Message-ID: <SA3PR11MB43100661032C326636FE9E32E1A1A42@SA3PR11MB431006.namprd11.prod.outlook.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
In-Reply-To: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB431006:EE_|DM3PR11MB8734:EE_
x-ms-office365-filtering-correlation-id: 6dd573c9-1407-44ea-aeda-08defe753f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|10067099003|8096899003|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: KQqjeTqfeM9XptagU7j8gRmokEQBJmOnvi0P2THeVygeKypiFMOUPxe7ZxIsboBak+ULwGh41lxtX9BEaV3qnzZKtJHwrobkD5bze+ph1xGZXhR81chzzARlLMZ2P6PthEpi5q+lG6GX5TSPP+8EwFQky9c5G3l+b5DhrL+Q/eiL4Ip1lrJalLZ+gXO3Go2NAr1zLOx2tJ6+cqB8vE2m+UevZ6pOMZff2rUUNPhtLyeAj3Vh3vj4EyiCrleWxHkqqIfccaUqshHXFkZ3SsfHJB6Z8I+kQARg/IADH/uy20bglhvlJNJA3oh27YdzredXBBqskOLEDVRCiHKcoYT/46Q8ZWQ/76KypYcT4q1ZC7UT07nizJITqA0qTXF9W7I2YtzKgNDxttuUIV+7jJTwZ30cXkMoX816eoUNaKt0O1TaoH1tWLsk8w1pT3EcOG3rn1o23y8J/aV3k5WWlu2jK2hqD0ZmKnpYvT7Bzcnw9/+pZVN71+gL5VAkI7n4kwQmGZ7dz8TsBaY3JYIgDyPW/WP2+qOF5r7Ww7m5QTmwu+HbK8qI7C413rMciZOIbqf65C2rJBW2QZ5kHyGS6qQrfYVqVCEPsDaCZnZDCRYhy805AJkWEaYqbhC8urR77lkIom5U5sG5J/WcWYTuIfOHYUTaPhWuzvcizxGe4O7oRyWezAMaO4mNE3IGdh+5IZnwbpTyBybtgMPI62ihjiN9H165XdlxAbQKrHcQTES9qoU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB431006.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(8096899003)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uhydMjBbVh3ycF7mjZDiMqA8FqxB0MpWTxKp4mVBrxEqaJv8leoctgFNnh?=
 =?iso-8859-1?Q?jg0rCmx8xUsxeEASdIDF7r53XM044k1o5XqB3sg1+MiMVshvBpk+K6an6n?=
 =?iso-8859-1?Q?hMwEiaSUcCCWNDUWJ1T9i56vLtsdv7WCBLl650ToRdcUTFOo0ZLBb5rCle?=
 =?iso-8859-1?Q?OSkUSlEJHGwP1v4YCLhNCWEsZJ6tNXjxNtHHZtpk0q3yWIRXE1A8zospiO?=
 =?iso-8859-1?Q?KN4mgCuOGOMptejYIYkYU0mQFi93QG/RlaLRCqMxvWKlaMSVSq86kFelm4?=
 =?iso-8859-1?Q?JEdA7KkQd/KaWZ9xZhiYnfl0L2WP4+/ZUCtit9b9u5ITM9q1+EhMvFg19l?=
 =?iso-8859-1?Q?gGRevAYPc/RRQ73p3xBdJCUXq0kYaMOMKZFHuLykfBgcyFKwj+Uu2yPHbZ?=
 =?iso-8859-1?Q?4D7PIYueDSRggWKLWZ9eB6COo2T7X8+iHp7ou8MsmKAkXak6fvYNFiMX//?=
 =?iso-8859-1?Q?jMx+tCwPDRuhcc30EnfoVJeWfB28UUKyNamPz/7GUaLT6JNs7q22xYB83x?=
 =?iso-8859-1?Q?57urz1YEukSKb7kK+3f1s+un3Y8FxqIT7EueJl0SI20Tstq6EkxS+RMkjv?=
 =?iso-8859-1?Q?p9Xzs01q/UaT0e2bFvJIxpUs84VmUNTdg/Sm/FBPbetsIu98FgcDPivk//?=
 =?iso-8859-1?Q?kpb7lAsf6zNz1gt6EtVUL4Zb5zX5sCgl1ckTJsBmod2vGwrSULiAWg3jsL?=
 =?iso-8859-1?Q?8PqbOf7x0/Y8VKRaXzDG5AQR1Jt8g5SXJS2yxLCNJDR8tCVLcD4Cac34KK?=
 =?iso-8859-1?Q?PqwAu8CxMX3bHCzL6FYfIG5zkI3Mbn2g8rtMbfC5ozCihWKU8RPtg6ZaV6?=
 =?iso-8859-1?Q?lj7E8F+ytwmrP55zU0BE/2XqsljkohpR5zZMq9W3vyGXr5A3dfLw3z3Gnv?=
 =?iso-8859-1?Q?WKWakGTjcE/Tyvd+tZfscStfhWYEZOZZwjXCMb1ksE7pNVZjBh3AC0yrNb?=
 =?iso-8859-1?Q?cwWCiW6YyV36M5pWDrP3mkOsbseRuwQSPxuWpCRjL1Kodi92w9lb8tdjKl?=
 =?iso-8859-1?Q?d7umENIr3JV+31bSS+h9la1B7GvlrQ7sD2DNoDMAa6N44uzOWkCSZmQoW4?=
 =?iso-8859-1?Q?/6YP5+ewGKvvkt0zLbqNlxQue+TJ/2SGrSt974Fz0waCVKoDDVqMGNuQR6?=
 =?iso-8859-1?Q?iL3k9FfcVieipnCQXJGClOezvVu/1YjNAYpk55UCK6/qPgzNGOYWYLFviV?=
 =?iso-8859-1?Q?JU00D8KqgB6YQdfV2cfeQqR3j3GP0/EUM+moHtqZVlRPmQWZcw6UJBA0ee?=
 =?iso-8859-1?Q?YaT89ZgHhlQFxDubiDT1U4GGc8qD9D8xx0cXUPk0QMaYhXTOIg9+g0LLhj?=
 =?iso-8859-1?Q?qgo2ceeYMc60ZmAyokTwSslHEcAFMsULcoHliiGQecCJIBTEHe2SwjTaME?=
 =?iso-8859-1?Q?k8gZxcaUFbgfuBwIPyoW8iDICAHCXSAtw2KaFX8VzS11AmcMPg+9J2eVAW?=
 =?iso-8859-1?Q?hL998TiVd9UuFTavB7y8sUkXkKqrcUFnND+QKxF7knC6/0NvOk7d1f2EQE?=
 =?iso-8859-1?Q?slu/0w62ojOLYCZCYB+sLUjtXwK/UkPQWH5oelNF7tpLWfS9HvExj/45IT?=
 =?iso-8859-1?Q?ljjU7R/JEUCYRgPKfVs5/q2acRJVjrNfQRiUr5nFVzCXc5ccIS7IsxhhLI?=
 =?iso-8859-1?Q?s2FfSXKWs18Ki9UUjiOK0pMI6/2zG7QlBoIT7x16mobdFS9RsI2nSPXG00?=
 =?iso-8859-1?Q?niVqHni27nmCgWm5H0mHyycUfSpr96QuP8RW7VqtZewRfjfb4IiTR5+pF3?=
 =?iso-8859-1?Q?AWe5GTW9owZDevU9NLx99ojBq+/tRq1b//9hC1Ywkhup7nFIthEcMZL2kN?=
 =?iso-8859-1?Q?V/SCX3hWgA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA3PR11MB43100661032C326636FE9E32E1A1A42SA3PR11MB431006_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kYqHVVDjsyAjH/eXwtdTNj1gcsbh+GywvcZoPtWdur+OqvvgxfbcWoglFJBVab80/0sQ4GSE7RJXl78yQgb/tXUC8zgOfZR0Dgl+vqF6EGZabqmCTxoSAzFqGsi095R+yT1/l2NRLWoYfP2okwv+TSlu2wLertAnG9J5HNiBROvW/PSVOxy6S1IW5VTTvHXm8Z/te9pN4HLCqwiRM/Ke5MAl3erF8gq37qfoq+4rx/7KpNCGTJU5TFsl8io/1x/8IwIeogo/VnSxPJuKsaAKfs8yLDV2x576Tg/KRH7O8zkbcEANndUw09rxKrSJzCYK1tPkCk8OEn0oWG/tlGFWHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB431006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd573c9-1407-44ea-aeda-08defe753f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 04:41:06.2129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJnQ0hTicSN7cDkLRArpmLgBnSz5CYhQtWWWqVTJ+GQSdq1HBRMgia05Wh2DTASDKVH7Oini96JJvwsv8gHk9di2WtObV0h5JXh4I0ng5fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

--_000_SA3PR11MB43100661032C326636FE9E32E1A1A42SA3PR11MB431006_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Rajesh Kumar <rajesh3.kumar@intel.com>
Sent: Tuesday, August 18, 2026 12:54 AM
To: dev@dpdk.org <dev@dpdk.org>
Cc: thomas@monjalon.net <thomas@monjalon.net>; Richardson, Bruce <bruce.ric=
hardson@intel.com>; andrew.rybchenko@oktetlabs.ru <andrew.rybchenko@oktetla=
bs.ru>; Kumar, Rajesh3 <rajesh3.kumar@intel.com>
Subject: [RFC 0/1] ethdev: per-packet Tx timestamp slot management

The current DPDK ethdev time synchronization framework is architected
around a single, shared hardware latch. The existing API,
`rte_eth_timesync_read_tx_timestamp()`, assumes a serialization model
where only one TX timestamp is outstanding at any given time.

This model creates severe limitations for modern high-throughput network
interface cards (NICs). When multiple packets requiring precise
transmit timestamps are sent concurrently, the shared latch becomes a
race-condition bottleneck. It makes timestamp retrieval unreliable and
drops accuracy. Furthermore, Poll Mode Drivers (PMDs) backed by
hardware that supports independent, per-packet timestamping slots have
no way to expose this capability to the user.

To solve this, this RFC introduces a formal slot-based lifecycle API
for per-packet Tx timestamp management. The API decouples timestamp
tracking from the global latch model, enabling true asynchronous,
parallel hardware timestamping.

Key Components of the Proposal:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
1. **Slot Lifecycle Management APIs**:
   - `rte_eth_timesync_tx_timestamp_slot_alloc()`: Allocates and locks
     a unique hardware slot prior to frame transmission.
   - `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: Embeds the allocated
     slot handle into an mbuf dynamic field, allowing the PMD to
     program the specific hardware descriptor during the Tx burst.
   - `rte_eth_timesync_read_tx_timestamp_slot()`: Asynchronously polls
     a specific slot for its captured value, safely returning `-EAGAIN`
     if the hardware has not yet written back the timestamp.
   - `rte_eth_timesync_tx_timestamp_slot_release()`: Recycles the
     hardware slot back to the PMD resource pool after successful
     retrieval or an application timeout.

2. **Dual-Domain Timing Mechanics**:
   - Introduces `struct rte_eth_timesync_dual_domain_timestamp` to
     simultaneously capture both the adjusted PTP Hardware Clock (PHC)
     domain (`adjusted_ns`) and the raw, free-running cycles domain
     (`cycles_ns`).
   - A dedicated `valid_mask` tracks the validity of each time domain
     independently, giving applications granular telemetry options.

Scope of this RFC & Open Questions for the Community:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
This RFC establishes the structural definition of the APIs and driver
interfaces. Before proceeding to a full `v1` patch with active PMD
implementations, we would highly appreciate the community's feedback
on the following design choices:

- **Mbuf Dynamic Field Layout**: Is the encapsulation of the slot
  handle into an mbuf dynamic field using standard dynamic registration
  the preferred mechanism for passing steering context to the Tx
  descriptor path?

 rte_mbuf structure has "timesync" field, which can be used for the slot.
 This way mbuf dynamic field use can be avoided.

- **Dual-Domain Structure**: Does tracking both the adjusted PHC and
  the cycle counter within `rte_eth_timesync_dual_domain_timestamp`
  cover the needs of other hardware vendors supporting concurrent
  domains?
- **Error States**: Is `-EAGAIN` an acceptable return code for
  non-blocking polling of incomplete timestamps, or should we consider
  an explicit bitmask status?

Please review the proposed design. We welcome your feedback, design
suggestions, and critique.

Rajesh Kumar (1):
  ethdev: add per-packet Tx timestamp slot APIs

 lib/ethdev/ethdev_driver.h |  19 ++++++
 lib/ethdev/rte_ethdev.c    | 121 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 108 +++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

--
2.54.0


--_000_SA3PR11MB43100661032C326636FE9E32E1A1A42SA3PR11MB431006_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Rajesh Kumar &lt;rajesh3.kumar@intel.com&gt;<br>
<b>Sent:</b> Tuesday, August 18, 2026 12:54 AM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> thomas@monjalon.net &lt;thomas@monjalon.net&gt;; Richardson, Bru=
ce &lt;bruce.richardson@intel.com&gt;; andrew.rybchenko@oktetlabs.ru &lt;an=
drew.rybchenko@oktetlabs.ru&gt;; Kumar, Rajesh3 &lt;rajesh3.kumar@intel.com=
&gt;<br>
<b>Subject:</b> [RFC 0/1] ethdev: per-packet Tx timestamp slot management <=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The current DPDK ethdev time synchronizatio=
n framework is architected<br>
around a single, shared hardware latch. The existing API,<br>
`rte_eth_timesync_read_tx_timestamp()`, assumes a serialization model<br>
where only one TX timestamp is outstanding at any given time.<br>
<br>
This model creates severe limitations for modern high-throughput network<br=
>
interface cards (NICs). When multiple packets requiring precise<br>
transmit timestamps are sent concurrently, the shared latch becomes a<br>
race-condition bottleneck. It makes timestamp retrieval unreliable and<br>
drops accuracy. Furthermore, Poll Mode Drivers (PMDs) backed by<br>
hardware that supports independent, per-packet timestamping slots have<br>
no way to expose this capability to the user.<br>
<br>
To solve this, this RFC introduces a formal slot-based lifecycle API<br>
for per-packet Tx timestamp management. The API decouples timestamp<br>
tracking from the global latch model, enabling true asynchronous,<br>
parallel hardware timestamping.<br>
<br>
Key Components of the Proposal:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
1. **Slot Lifecycle Management APIs**:<br>
&nbsp;&nbsp; - `rte_eth_timesync_tx_timestamp_slot_alloc()`: Allocates and =
locks<br>
&nbsp;&nbsp;&nbsp;&nbsp; a unique hardware slot prior to frame transmission=
.<br>
&nbsp;&nbsp; - `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: Embeds the all=
ocated<br>
&nbsp;&nbsp;&nbsp;&nbsp; slot handle into an mbuf dynamic field, allowing t=
he PMD to<br>
&nbsp;&nbsp;&nbsp;&nbsp; program the specific hardware descriptor during th=
e Tx burst.<br>
&nbsp;&nbsp; - `rte_eth_timesync_read_tx_timestamp_slot()`: Asynchronously =
polls<br>
&nbsp;&nbsp;&nbsp;&nbsp; a specific slot for its captured value, safely ret=
urning `-EAGAIN`<br>
&nbsp;&nbsp;&nbsp;&nbsp; if the hardware has not yet written back the times=
tamp.<br>
&nbsp;&nbsp; - `rte_eth_timesync_tx_timestamp_slot_release()`: Recycles the=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; hardware slot back to the PMD resource pool after =
successful<br>
&nbsp;&nbsp;&nbsp;&nbsp; retrieval or an application timeout.<br>
<br>
2. **Dual-Domain Timing Mechanics**:<br>
&nbsp;&nbsp; - Introduces `struct rte_eth_timesync_dual_domain_timestamp` t=
o<br>
&nbsp;&nbsp;&nbsp;&nbsp; simultaneously capture both the adjusted PTP Hardw=
are Clock (PHC)<br>
&nbsp;&nbsp;&nbsp;&nbsp; domain (`adjusted_ns`) and the raw, free-running c=
ycles domain<br>
&nbsp;&nbsp;&nbsp;&nbsp; (`cycles_ns`).<br>
&nbsp;&nbsp; - A dedicated `valid_mask` tracks the validity of each time do=
main<br>
&nbsp;&nbsp;&nbsp;&nbsp; independently, giving applications granular teleme=
try options.<br>
<br>
Scope of this RFC &amp; Open Questions for the Community:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
This RFC establishes the structural definition of the APIs and driver<br>
interfaces. Before proceeding to a full `v1` patch with active PMD<br>
implementations, we would highly appreciate the community's feedback<br>
on the following design choices:<br>
<br>
- **Mbuf Dynamic Field Layout**: Is the encapsulation of the slot<br>
&nbsp; handle into an mbuf dynamic field using standard dynamic registratio=
n<br>
&nbsp; the preferred mechanism for passing steering context to the Tx<br>
&nbsp; descriptor path?</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;rte_mbuf str=
ucture has &quot;timesync&quot; field, which can be used for the slot.</div=
>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;This way mbu=
f dynamic field use can be avoided.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
- **Dual-Domain Structure**: Does tracking both the adjusted PHC and<br>
&nbsp; the cycle counter within `rte_eth_timesync_dual_domain_timestamp`<br=
>
&nbsp; cover the needs of other hardware vendors supporting concurrent<br>
&nbsp; domains?<br>
- **Error States**: Is `-EAGAIN` an acceptable return code for<br>
&nbsp; non-blocking polling of incomplete timestamps, or should we consider=
<br>
&nbsp; an explicit bitmask status?<br>
<br>
Please review the proposed design. We welcome your feedback, design<br>
suggestions, and critique.<br>
<br>
Rajesh Kumar (1):<br>
&nbsp; ethdev: add per-packet Tx timestamp slot APIs<br>
<br>
&nbsp;lib/ethdev/ethdev_driver.h |&nbsp; 19 ++++++<br>
&nbsp;lib/ethdev/rte_ethdev.c&nbsp;&nbsp;&nbsp; | 121 +++++++++++++++++++++=
++++++++++++++++<br>
&nbsp;lib/ethdev/rte_ethdev.h&nbsp;&nbsp;&nbsp; | 108 +++++++++++++++++++++=
++++++++++++<br>
&nbsp;3 files changed, 248 insertions(+)<br>
<br>
--<br>
2.54.0<br>
<br>
</div>
</body>
</html>

--_000_SA3PR11MB43100661032C326636FE9E32E1A1A42SA3PR11MB431006_--
