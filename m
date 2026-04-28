Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D60FF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 16:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64A12402E1;
	Tue, 28 Apr 2026 18:27:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DE542402B5
 for <dev@dpdk.org>; Tue, 28 Apr 2026 18:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777393645; x=1808929645;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=GohbJIFWrEnPzYMfVf9fcv2hxsX9yOMPpIGz8wbcf+k=;
 b=eu2c/rKTVS05e4hnIid9PCfXtMec95sfIhAdN36Jg+dRMOSOE/IbPs60
 UBeoZ5B60OsHL9rwTlBx+eTFH3mIt85jTTZLqvjI+AWlJj8AVrPLLLpI1
 aHqbypRobCztwP8WIkhuDUIbPKqkU8t5ZIMx1L7+oNrftdtr2K78LHZ9W
 yKhTlDiWCz1HefSQ1knVRzKQV1ulhpItCdBGfOxhPObe6DqPY4RsbnijI
 /5sXcvE++EB9l2lpmdvn+7cK22GB7AMpJ6DVZN//q8fAMrOxVQg3ZK2lg
 8lsUTmBNCho9dQ1FV10WxmMlov44P69ORnIyZyjFdJolWX3dXX1TIrqbP g==;
X-CSE-ConnectionGUID: LVZ3Kjj3Q5y7ChFaVM11IQ==
X-CSE-MsgGUID: y54nPwezQZujeK7EVzjqEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77472653"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208,217";a="77472653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:27:23 -0700
X-CSE-ConnectionGUID: PalZ9aMtReKXLIyF5ypqMQ==
X-CSE-MsgGUID: l4ln+H6BRECZs1FC/DnYYQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:27:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:27:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 09:27:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krN9FbUD9kzaT2ipFN1C4YxeDVjW0FfRhS1mh4qgq897ybmNJL9qxsblj+o8r4WKc+z2Xlw2jfGGmJoepts5GNEveuayBVuqr/BshPoIillUfRssiyq96rjDWqSwnM4MG1tp5KfPNVBiagvWbwJGXLb3oVKUwt2KRoeIWvz+uHLGa6xoj7aAzhaKBknlLIfa81HxcPNoiG4Yy8sj/rwQvFafYq72wYlXrJAXfCduUpU7TCcr4g72K9XHz1Ndzo/Q9pK98w7lDkxPnZg42AX4CcvgS+qrrUSPmmQWXNXTbkEyCFg8Yz6CoUlgKrmCm8NtZUaGZu17+cUXsPf7sNAx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80AUeONDcWNpn1+II8S5vgxAPA1JeR3DmdSruIP7wAA=;
 b=MyyQWrjQjGi+JGnTvyQQZBnUwZ9gzfwzxIkio4C/hwTouFH0Aud666bDzpxtZU0JB+btYiar0B7KmEXRbATpLLASr47ZdZAoiWXQ8wGtTlAHyvHTAlB+1OeZOVe6HTtjCmuG+0MxE6KR2OnmLTWXmUvNCu6p+h8vklSQgvWXbEJjjnx7M23lrP0np6m7csOm5CGXGEpo/e3FN8+tykSqwSyMRvXjL/1KYdBiA9MQ5e9JZChf4zacw9q0+KbKRm2fPzb5sywXSmPojZkLQzOSeUWxSbyxItP4EWpvNPdm00byasZTUkt1dukRnKLTgMDECRzB3vN+J37EG6ZPmfqjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 16:27:20 +0000
Received: from IA1PR11MB6323.namprd11.prod.outlook.com
 ([fe80::859e:cfe9:df84:46bb]) by IA1PR11MB6323.namprd11.prod.outlook.com
 ([fe80::859e:cfe9:df84:46bb%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 16:27:20 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-04-28
Thread-Topic: DPDK Release Status Meeting 2026-04-28
Thread-Index: AQHc1yvAtSGGMWvQUUqB73CsSRMKgg==
Date: Tue, 28 Apr 2026 16:27:19 +0000
Message-ID: <IA1PR11MB6323B67EF13205A82FD83046FC372@IA1PR11MB6323.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6323:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: e90d329c-88b8-4af3-b6ff-08dea5430506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|38070700021|8096899003;
x-microsoft-antispam-message-info: iSPQmsqwiI+qA8iDjvKoaWc9uhoamF68Twwqw0Hoe6xCPYHzXIQW4tNnYmilMrYJosO1yZKRJ/CctVkPsSWex2Yy0wa1Ee00qXRL9pR5cgli70yuAsZbnmXFhaFOkRvJe2sWnrglQvn41salwilJxDmtvo2iWxE/857/JqmeD3s8hzNXOtSRDORaYhhbWbALljSXxA0QuTHOUISXdaCZd4JQivmVMIN8cC/osSvdPIXKyu9aQWyTnCYXE4WFAUuIXaYVieL//3XfOlEq5hdzRTd+eyHBvlGkum88WOP5MaMbwcw69ViAjKEu6TtiMUuVk5GEM8eN3ld8Xv7WnxG4zyNmtJPC45ARFvWGQXizHEzQIRI6vP2ZVthXequuUnWyIGCMVVtPbDbywpxnTEQI/RjBkxfGN6tmrewAad6FI7ygqw5CmQ53gXxAvV8MX+9E4CuDWb0/lZrCwFnMAHgaRNchrke47m2WIf2y93bvQUvjmLNrll+BBQk7gdWtfasLwGqNjMDJ8sGRefkzwLqeskZoXSdGUD6dCmMcOjLtJWMKpI+OG2t3VQpe1HZUiGQVVScbDcRH8neFLiiHw+qEOiBH1btChvuTlY/osDA9FHZBBLRbgZr3XncWqld/gUyySec8wB3Z5xgF8odA0HGCe/Kno8y1ddI/pmfbkges0D+Zz7u4Q42qUgWFULEeJDz8uNklb71Tsr7BVfMiuBmiEaS5AD5//RhCt6onRQOtQNFZaBJu6lFID4miE6LdSqCo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6323.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UOjnajCghPCZUCeA1qy5i5sdtXzByZVmAFcDs9CWYsgWqlozSbUd/2S4ZJ?=
 =?iso-8859-1?Q?3Sp7bFAS6dgCOZuJBQHagwctYOu7Q42Vj7oBLI2TGchwHE8cRpsjbkxn+Y?=
 =?iso-8859-1?Q?tIYvscr7Z1pzXcufejcNXab4oxBrqlGyXz13L11ZK0cyY1abolF1Cqxlyh?=
 =?iso-8859-1?Q?2H9PdAKVrzuKcU6qrnfJOif8B7dVi3PrbsrYZA7LosQv2WVNAB846VpXYu?=
 =?iso-8859-1?Q?oRTbAifs0ebpTqRe6Ev4/TFMWmpW7Jrpob1uFJ8TY0QBIz5DEJbZ23u/Nu?=
 =?iso-8859-1?Q?TlYjq/q0IHAZpYa1U9GKetnT7BX3MmK+QrnnBUu5DN1W6PCaBTw1/Iei69?=
 =?iso-8859-1?Q?bc7lvGcbO2v0ti9MrymiMIMNQ82P0PQu387VeFb/irqQvzCUaXvVoztOF9?=
 =?iso-8859-1?Q?RXb9zlJctrzpCq/Lvpx5jrjXXumCKlVk6G70wt7qxNvDKBXpYPr/bcM/Y+?=
 =?iso-8859-1?Q?18Po7ilkM5ItRZ4ma3JSqGasY1SbKgiK5GpXmuYCjT2t06u511R8RV2/0T?=
 =?iso-8859-1?Q?aDyGold9XXWQweph8ft70Bgbyg7JpED/nPjgZRpnG1Ni06sXGtrrpg3j3y?=
 =?iso-8859-1?Q?o6xhkGB0X/qX8W33Um+jHQCAJGB0dJ3juyuc4y413MutycFTq2CHWDcE12?=
 =?iso-8859-1?Q?VHE5QtwisLhL6nambSn4inY91wHuIY2AkjQn2RGZkDNp3++Zhg0fLtSrJ0?=
 =?iso-8859-1?Q?K3Uu8GhGUhXc4KZSqnN1VkeYJfxr3QxVBanVUQMFvPnl2vLn6y9wTDx/+5?=
 =?iso-8859-1?Q?bVEU4kf0/eCLZiXrdQMzunDYxGqwGv0a0wLYqRewLg6KhbELcPaekQGkzg?=
 =?iso-8859-1?Q?/R8ZEAxDdwZ0P9f24rljHHLEv1Ycmm8aqnZltQdYkbX1Lf38eXass5+Cam?=
 =?iso-8859-1?Q?SJbDwqY5c1s0+iAdpUKFoU3TlI3acPHeNfKd0Xk6mAailbu1TViuBRYRxk?=
 =?iso-8859-1?Q?9HeRanX8zAkdlWsuNimnQ/yKlbzGCDrPMzjx5kbbF6DuOwNLz6MUNPiViI?=
 =?iso-8859-1?Q?a6xajZNCNpLU6+ZCrWP1P8IE4R3bBU6i11xSMc/8g+QYnXjjxNaoTWysJV?=
 =?iso-8859-1?Q?aZUpZvfyMB26k/VMJGS+noB+OhaMr1mtAKdO7vle60OVNo8lMLUBbbnDJk?=
 =?iso-8859-1?Q?/z/vC/vdIacDN2+g9UFJ2hWA7U719qbjAHDxNiEyfNwGpl2eC5OfqZSNb+?=
 =?iso-8859-1?Q?O+c6SlphaMlgwXeYF+Wsq8TDK9p8xtq5BZXiv0THVZBc1nzrIlosTQcWO8?=
 =?iso-8859-1?Q?hgNiRSSDiADp9Vzju5qrenu1CY5dgqicqy6uiJP/F6RO71tbJksrKJispa?=
 =?iso-8859-1?Q?FVSTJOzU8JYNNJgo+iv8wNMhPqpJYlSYmsg2G8v8IqiNMbnDraTqJNeCk2?=
 =?iso-8859-1?Q?OJ/8MbzjuWRLCYju2+QT5KBqbclsrcgH77HQtxqysUS+Cwst8ht22RIHmN?=
 =?iso-8859-1?Q?QPYlWBUL5k4DE1qSc/+Gwu3Bpt+2h87Ovqlkt9cLcsIxNqXHRy1A5wCSeo?=
 =?iso-8859-1?Q?6a8v1w0R1kGxqU2BFCH5FZ7kw+CndbD7MiKevQlegOQAalUqzhbbf4fy7n?=
 =?iso-8859-1?Q?PqHb3mXfD963n5EhPoIeapr52CLP2aChkSUUxFJjnX1scITm6GgiQtHQGU?=
 =?iso-8859-1?Q?/Lkws6xZfBu9rFkd0nvfWpx4zYdUW6syFfmvV645rD7hsle58qTHZdjt2B?=
 =?iso-8859-1?Q?TxscLX5a9VNGei1Fbr/uhn8pRi5LRQThEy9pxvcxwv8VNRzYGlnjQeQzvt?=
 =?iso-8859-1?Q?9JfLIkzMLSlPr4BLDpYqE7ekMCw0HWRCDQ/yiNPY6CbVsUCNJhdwTZ1irJ?=
 =?iso-8859-1?Q?CxON93yltA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR11MB6323B67EF13205A82FD83046FC372IA1PR11MB6323namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fPt8PuxY4JAVYr1XKWhHf4xXzLbgU05w4gd1v6XvYRXlfTK7PpUq62atfqXEAymmHFZiyqPa3RemEJ5jLQQPZ/PTEFjOd29gQYP/UuAcpTDaWP3zsLBxczCXyVsILXCNseMbLVcRliFDL50fSI/6ol0txJPoUDmWNIrh9iaYY5gaqoX6YY10j5GURbaFyixBUiC3ZlCO1+0CEMgbQPVx4JSmBNfG4cT7GRkTsc8lIFKK/35ymgGjccxRrvZ+RJwBmvlgJbTs5pAffh3O/d7x1Z82EqAB5irZaDox1IWcdKjXTsvWG9B794U0vNCKpCxt6HdaWMtt/DqOTrwfU+nHKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6323.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90d329c-88b8-4af3-b6ff-08dea5430506
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 16:27:19.8075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52my8Qo+jjfxCvm4H2OQ150TQ+6IBI4qJBZ2m+HJzf5yIoH+5+h0n7qzOKjg7dfbIV3ZXxHb0d3cxP8pHxmk6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
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

--_000_IA1PR11MB6323B67EF13205A82FD83046FC372IA1PR11MB6323namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-04-28
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
- Intel
- Marvell
- Nvidia
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 27.03:

| Date            | Milestone        | Description                     |
|-----------------|------------------|---------------------------------|
| 30 April 2026   | RFC/v1 patches   | Proposal deadline               |
| 04 June 2026    | 26.07-rc1        | API freeze                      |
| 25 June 2026    | 26.07-rc2        | PMD features freeze             |
| 02 July 2026    | 26.07-rc3        | Builtin apps features freeze    |
| 9 July 2026     | 26.07-rc4        | Documentation ready             |
| 16 July 2026    | 26.07.0          | Release                         |


See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 13 patches pending for merge.
  - 12 patches in review/waiting.

- next-net-intel
  - 29 patches applied.
  - 13 patches in backlog.

- next-net-mlx
  - No update.

- next-broadcom
  - Some patches in backlog.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - No update.

- next-virtio
  - Series for ASID under review.

- next-crypto
  - ~10 patches to review.

- next-dts
  - Nothing on the tree yet.

- main
  - Working on grout
  - V1 deadline 30 April 2026


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.1 - Release pending.
- 24.11.5 - Released.
- 23.11.7 - RC1 is out for testing.

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



--_000_IA1PR11MB6323B67EF13205A82FD83046FC372IA1PR11MB6323namp_
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
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-04-28</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- ARM</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-------------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 27.03:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
|-----------------|------------------|---------------------------------|</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 April 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 04 June 2026 &nbsp; &nbsp;| 26.07-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API fr=
eeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 25 June 2026 &nbsp; &nbsp;| 26.07-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD fe=
atures freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 July 2026 &nbsp; &nbsp;| 26.07-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builti=
n apps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 9 July 2026 &nbsp; &nbsp; | 26.07-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Docume=
ntation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 16 July 2026 &nbsp; &nbsp;| 26.07.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| R=
elease &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
--------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 13 patches pending for merge.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 12 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 29 patches applied.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 13 patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Some patches in backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Series for ASID under review.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - ~10 patches to review.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Nothing on the tree yet.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Working on grout</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - V1 deadline 30 April 2026</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.1 - Release pending.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.5 - Released.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.7 - RC1 is out for testing.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
----------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_IA1PR11MB6323B67EF13205A82FD83046FC372IA1PR11MB6323namp_--
