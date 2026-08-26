Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83927C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 16:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443E140268;
	Wed, 26 Aug 2026 18:54:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 41C4B40264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 18:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787763261; x=1819299261;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=GUgetdiMr2CCqkBFLuphvWFKH8sSPxe80tZDRJ5hgXw=;
 b=N8PiM6+S4wttpu0lY93JkwZD7GYHyQBzjETy4zHFUeni39qfXH5/cq1i
 YwxCcyyL4UhIov/NPXbhJRVDOrscX07+tlXJ1LuBeibUcQ2Rz7gBYkgdS
 uGF5Lexp4QkWT94gCrd67uI5K5oCNe460dJ9b9qZ60Htg/U8pMTV5R+nr
 kkms5CgVHIgDHGS80eHJ3Hs/J2sDST1cwuVb+VIhQyhP68ii4aewWpd+D
 eD70yK33hvOGbAPZigeIEkYMvjzdmpvP81FIab4TtdKmv9ZkMughji2S0
 SuKILRSLvU1XxqEasnnN1HhVtlJ8aSnZz4dEarnLfdq0z0Z7eYYSXOi/p w==;
X-CSE-ConnectionGUID: hMo8jf5xQiCfVIfhg7mynQ==
X-CSE-MsgGUID: v+djBA9PSt2Vk2ggKIHuig==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88455574"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; d="scan'208,217";a="88455574"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 09:54:04 -0700
X-CSE-ConnectionGUID: jztcifrxS4m0u+TvDYdJvQ==
X-CSE-MsgGUID: tzNgKkkCQ/ult9zm6TyLwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
 d="scan'208,217";a="271129774"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 09:54:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 09:54:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 09:54:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 09:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBV5jThpRAoDofj/Mjg9M23UvN5lghcz5oU1hzL4JaF8vf1TwSpBpzzZp+HitceI1MgvkIgI0qs2PHwLmIbc4ta926jT0T2b6KwM7pPcNNwlJLNT7/2tXykKGC7+vPPIeWcJUtjERtDbmcD7knGwXLAmvU+7yEVr2OzXCFPbrO/IqP5yY/iT2UVybERCsmu3LFqq82vOwEZx0CifdjSzhQzx9KD9ktBLhXV1Lp32oPY+AN66+aDWI3W1YiO0ELuxx9lPbyyrGYaGIhFpF1RzhmjScFo5ZX7Oka/LZrTI8pStX5iKgfoRJRnfS5i6pqlJePJ7bfd7402orORbapB8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw83iRuZ4tkY3+3iwtLdyyQyj75eUEwz/xTf5uBFbVo=;
 b=sIAWTIxWLlEPlFhVDzjCTMyyEl7hxsy88FIp2hgZjH6/jKZ7IaRQ2bo/nJto4Y0Pb1NlHHnfYMDS78nPWz60gjdYYxULRLMMXpuNFKnge20kndXBykg2+xLkGoxnQ1in/vyc8/L3c+5TPlgDGhg+Tv5E3biUzHWeFFl48mHJLEHac345xZlZko9W9gIMI8Ysaico0Po2wU8Hrrq1pFp7KxNt++nv/ZNeSZ4y/dhIwEia+Q+Rn+nT5XKIwSeQK5FIdJfLtoCWaHoVvj8NXcPpIHgMzjxSyST2OvfmKEVhii73NfkDYHy6fxzHNvZ05JQKvbBAtSe6Y5cMJUlzA3dhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.15; Wed, 26 Aug
 2026 16:53:58 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 16:53:58 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-08-25
Thread-Topic: DPDK Release Status Meeting 2026-08-25
Thread-Index: AQHdNXtboD3OWqOEW0+QCMRfYP0YcA==
Date: Wed, 26 Aug 2026 16:53:58 +0000
Message-ID: <DS3PR11MB96468CEA0D4F279B64EAD85EFCAE2@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: b1e3bb20-038e-444b-e3af-08df03929f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|18002099003|11063799006|8096899003|38070700021;
x-microsoft-antispam-message-info: hLzUl86+MNuIJCRPTETWQiPp0CVvUPc9VRd+PJl89D9fZ8QBneokgpalxpfl5MQ01ItlfqvKqhzlBnI4hPjdMK39Nvs24i8Sv0VPfYtivIvFWJtUxJufrJHwDVqOEIFDh6B6eKrOVpfhUE2HqoNejBwlBXGhiQsBJgfdIGsnXlFIdD0uoQZAzsNB3mK65WDXMO2SEYeXJrM9FIvrcR1pXCk/M51zq9d2yn7OTJ9Ej+vrzkFR9DKdNww1mJ1LjE/NC7JinBRfYkOkTTfsp4/SqR+uBIQBU1rP5XNeJKL1z9UtoPjqu5rfzLAxmfiUUrVtVw30W+XR02RSSdvOmXfRIbb3dcHiYWbkwAi7PChh6SIbubJkZ4u0kRmBwLQqKFFDz0JXMeWhy5XayzZPs51rKkcYDA8LI1j2Fy8h3O8P9/0F7G77MLKZkVj5S09/QHbtSXYwnPzYB7A0zVSVKzYDt3icMDnjRGWF6UUbFovJlDnLJ7UiFpNuS1ikFyHUGb1n3kGV2foX8tze+M97pkddmIbMi603/rCQeOXiNrN1cCe53ZKEL4V0HVvq057DBWhxgWt7r+Fek78cjRJ9oHS08aaag0hruxBYLPvYGMeqF7vD2vfuQbrtoPeK1swviFxuTjx6K/3zk8rwsjVQqnTDQAbpMCc8P2qH5Ewr1qtlMsc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(18002099003)(11063799006)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Epqur7BfRZXdkUFB8STeoH7ZNTUYs2+A5VZGKjJrem43WEwOEXMf71NSz?=
 =?iso-8859-1?Q?tnEonpuZIo/bOA5K5WFe05fwS4RFIcm1t9UZ8w4jlZ4w5uTE89lQ2q8GEZ?=
 =?iso-8859-1?Q?c1cEJh1JnKeiyuQQpsDfWR8yjG9bC8VovUutm1bn8TvGstE6lOHIct6P8l?=
 =?iso-8859-1?Q?ZlMXuGVccwVjcqlCoYs5Yp3bnvN32Y4WbjJJGeTQdN9pXKtJ6Vjn0LwxGv?=
 =?iso-8859-1?Q?IPE2ff2yvnX05j9xbvAY3HUve6cZ6aw2vWFhSp8v/esbIr8QALipjuxso5?=
 =?iso-8859-1?Q?Z7APBJNTKUA1R8I9DHbkmqIzOYsS8NJXH9B8maYfW1serw6mQ8ywvhA0y1?=
 =?iso-8859-1?Q?e9Kb4XV2j3GYeyFE45OzxocTOEh307kQlS3adpdbXdLNhotYAuU1hEdgps?=
 =?iso-8859-1?Q?97nZxQsJz21FKLksnXcnBV7vxdV9brzoclqYsMGwmjjX4cHIsWb3yPzSHb?=
 =?iso-8859-1?Q?sO7JG/hArog/Vm2NqMRy38sKUC5HmYx30VbFCNUMtVg6EIAgRyB4ePNDso?=
 =?iso-8859-1?Q?70/ohn9FDxaikvL6189pxjn3pX5MxaU8dl2eDgOWlyI25GhC/GQOP7Tp4g?=
 =?iso-8859-1?Q?xHcrUlOadlhUf+1QToKlaG/KJ8Pyx7a2OQzWbMWn0dmtfhibMiZUgzKZx+?=
 =?iso-8859-1?Q?0PHTNXweMcIxqYfJ5TYUHS4oU3pDiwtE3DT5smxm7ybOFfNBnGTbUt1k3c?=
 =?iso-8859-1?Q?3YXDW6REXHEg/KCevpwLVeruk9HVq9/TsUZ5NqJCsOsW4WaYp7yCfKZ8gV?=
 =?iso-8859-1?Q?Tp2GRc3wiwBhQntRAYTxtiiHV4G5cNuStvQ7TC3SDBD9Uv71CKyq20fIdh?=
 =?iso-8859-1?Q?BMAg7wj1nBSz+QtQ/s+y/gxlnm9Xsz/hiAfsa0zcDdzs+d29ZEPh+amOMn?=
 =?iso-8859-1?Q?LjJZrB08g8eVadF21r7l1Ufd6j8N/GeQTtwHMSioHfSA3FNuEiNKbXrjcb?=
 =?iso-8859-1?Q?PpuC/D1m2imnVf/I5r6yyYPaNVE1W+qCGsXGW2keoEfVNvhNkDISxYsPl9?=
 =?iso-8859-1?Q?aQxK5m+2H8IoNYoCeHfqFJef+QKdhvG/O1OeasPxJn8wsuLDm2Yl1Gh/LL?=
 =?iso-8859-1?Q?E5kwa3PGcWP+IgnVkjvAetQCsXwQMaVyq3Lgje8WkM+iCNigkHiorZTqIF?=
 =?iso-8859-1?Q?HE0NYwGuK7EM7BR+p6JuKJr8fteMU6lyzFU2IUVbJTsGr3wFe1lSe4bxNT?=
 =?iso-8859-1?Q?H6+U1NMvcB+7y0u39ddnFLPked6ONIlM6ZAmL4HdrF1gUnOiIjpc6fFQYp?=
 =?iso-8859-1?Q?Er2tP9u94puK8SQRkQ3TepxBgCUqt+6dnhn590IEvtGyLJCqErA/cTbKyK?=
 =?iso-8859-1?Q?58qs4CP6pm1CytMDdDM9bqkk3j9CLR00X6R2Qcz3fvALGCkME6XLir3rbe?=
 =?iso-8859-1?Q?zNXGGjXOcdsA68XKpejrViDK0uV+bdiz9QbhOzGy+WwBHQGls3+LT+GIkt?=
 =?iso-8859-1?Q?Tc84x/gzR8x/eBqeDAqjBPdCOQu6aoBsdXSxR/POKjT4D+wrvl606+pDDf?=
 =?iso-8859-1?Q?hhHb/HFuwUKx+Q+xVrEuVyY6DQJ8dRLe6/05Iv9IdDR6ADfqMY173Uh/Aa?=
 =?iso-8859-1?Q?FNX6s9bT1ELHjfvCwjuRw3gQ6/OnDd+ZVmEWTVVr5wQ5+YwFq9LocTmpV7?=
 =?iso-8859-1?Q?IS+DHNhw4p3DS+vFxrCmheUTiTSnb3xa3XG80aDEQBEBtBcaja3m03WR4m?=
 =?iso-8859-1?Q?L9BYVJJzVu3rmDdYSwHD1DGqgLBn1kbaHTyPphRjjzJhR+YrmK6jRxJLXJ?=
 =?iso-8859-1?Q?8hJLHIyrEk0OuQbD6cyb16kSEegE1uZ/jRR0OqtA2YQ9cs2hQx2F+SOJeh?=
 =?iso-8859-1?Q?MHSBQgGIAQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB96468CEA0D4F279B64EAD85EFCAE2DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EhXgsvaNYGB9rExZAF4undIhCSvPfeYslV8yBBV6dGf3m1rAlQhnI/zpwEyHGFhBqwiNp6z790ANHRn8axVtR64nF2O4iYv4nTqfQBwr+Kh5Nl5W1xeQ+fXXlIprIp1dIXZ6tVuXG3vE3pLzPRjRbkVe4KHoId30SZ+WzZDwv1Q0xMv2SB+nf9EcIdDXpqtjcml/InBI0Hbt8xAQP7TnyGt5oC0pJ3kCOr9wkFxcvkmkcLETQf6KN2mobswYB7OPybmA1fw8aHYet1lNiSc2nM9So375thBP5EZbB3Cdh2DBrp8+i4XAjcztSMVHnhbyBM0GrVjwg1WrZ2DpXeYFUQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e3bb20-038e-444b-e3af-08df03929f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 16:53:58.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWcmb0pn12If8TTg4QmxMo/Jii3+j9YHJQBS2XfwAhxSWtEDNFMHmGnspQHgFWDhXpb7BDdETaI3WkR+Acj64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
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

--_000_DS3PR11MB96468CEA0D4F279B64EAD85EFCAE2DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-08-25
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
| 02 October 2026  | 26.11-rc1        | API freeze                      |
| 23 October 2026  | 26.11-rc2        | PMD features freeze             |
| 30 October 2026  | 26.11-rc3        | Builtin apps features freeze    |
| 06 November 2026 | 26.11-rc4        | Documentation ready             |
| 18 November 2026 | 26.11.0          | Release                         |



See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 92 patches pending.
  - 11 due for review.

- next-net-intel
  - 34 merged, ready for main.
  - 17 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - Proposal for new API/symbol.

- next-virtio
  - Some patches reviewed.
  - RFC to remove vhost async.

- next-crypto
  - No major at the moment.

- next-dts
  - No update.

- main
  - Merging patches for deprecated symbols/API.



Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.3 - Available.
- 24.11.7 - Available.
- 23.11.8 - In progress.

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



--_000_DS3PR11MB96468CEA0D4F279B64EAD85EFCAE2DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-08-25</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 23 October 2026 &nbsp;| 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD featur=
es freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 October 2026 &nbsp;| 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin ap=
ps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 06 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
--------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 92 patches pending.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 11 due for review.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 34 merged, ready for main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 17 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Proposal for new API/symbol.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Some patches reviewed.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RFC to remove vhost async.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No major at the moment.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merging patches for deprecated symbols/API.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.3 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.7 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - In progress.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
----------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB96468CEA0D4F279B64EAD85EFCAE2DS3PR11MB9646namp_--
