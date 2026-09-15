Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B752C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56EA140DDC;
	Tue, 15 Sep 2026 16:04:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A4CCA40B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789481080; x=1821017080;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=aCzh5wDs8YiZQi35StM+vTMuYm6u/GO7yaRMtHyWDgM=;
 b=D1jtWeIAir8UM3TQG0VN22Jjt6lR9RHfbXvYIQrxF9lfUX/gRZDl4psR
 oqq+zPtI4Zu3qzR6jw26OqBOHF2+IhHvWdwtLfx9jjfP9PtxMkjc+lo3X
 ap4ZtjBoR42W3QWXovD+uVJW+Do4lxeKht+NfMpFFpKTw3iLnAo89jiUH
 cq2/ITiF1GzT2jBrNdAGKixopQ1gH6HOSueI83ZbOB1+2yunPnaPd930y
 aCDvzOlsEXIhYZ1OyvFkF87JYeT4PMN/54ish+SIuVhyJB/5leYlQF/wr
 7pSuDzXc4SPw72lRtZfCsZh9b5//+oPIZ7Vfcu2Z1CFqj7KbJiKuWg8T/ A==;
X-CSE-ConnectionGUID: e8Dv/ze0RU+DPwRb99eCxQ==
X-CSE-MsgGUID: vxYR+wcXQqORIeVMBkFtLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89603036"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208,217";a="89603036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:04:39 -0700
X-CSE-ConnectionGUID: PcgWxYt3Qs+bYAU6gK+DOw==
X-CSE-MsgGUID: 4HhVN3v3TfqNrqNDd7BbGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="278284798"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:04:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:04:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 07:04:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2314HSNiHoYjhzlcJU9OCM8GjziMQZf3ZWSHDT3LqY/i/hHTm1RLtTnd+kCsC8ReGoPrdu6R/0RHjy35q6dEZKzmuGRmWijjvf1CAzZUM7icJ9bwS93oMrQNh3EpSJWdqjCWMqm3nAt2gIszATEx9jHwbnlmd+MrYE4BXSyOpgTdFLr2sfwmeI1lqU/XVYXI/5LNUACm3hJ0BMlMk9R6DI1w69KBo5VDTR4GoBccyI/+WNyDXyVWl8ThHltkf4LFooxpmKt1NRYrr2rMrF36g/NJLP2op2yOXJV5zWeWyqc5mJTmVSuH+OCLt3tvsYLEJFVqNCorlEtIN13FGMHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaQx2pz0JcKvs8ZGufnNQ+ZsEIiVgZwksQRjCcMXgRU=;
 b=qmWbdcATNKxqUvLvxzPlpa/dPqGgtV6MC+N+42ab6Eo9qGNqS7dNocYnZkkE71MfK1XCbqs0W4Uaexi2WL5Q6HGld6hGCLA9LsOj4FejI6xGfl0tvEPSyGrXmhC4Y9H8eBzRVOdpduDJcvbLrhEYQ70WqF34pMFlel7Vu95A5nIFgi4Zu3FyeCzwicuTaVYpy/5fT0aXS5XYBGgjVMa/APrsqJW9iN56/CfNPi2Q4lz7OauxPXcArifH/kXeUkbP9RABPuKp0WJPEIfKTgCJrqPXrSPqLzQsUa9LXexaIKxvmMDCUY7UFX9IeXDIUhqoQGpAHKTCPhS+SPni5wV6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by IA3PR11MB9399.namprd11.prod.outlook.com (2603:10b6:208:577::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:04:34 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 14:04:32 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-09-15
Thread-Topic: DPDK Release Status Meeting 2026-09-15
Thread-Index: AQHdRRsJIv0GZoH/T0m9VHc4bKokdQ==
Date: Tue, 15 Sep 2026 14:04:32 +0000
Message-ID: <DS3PR11MB9646C3BBFEBF3A70F6C56286FCBA2@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|IA3PR11MB9399:EE_
x-ms-office365-filtering-correlation-id: c06ee82a-0832-4146-1432-08df13324469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|38070700021|8096899003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: EPUcFc+eAxQtsTwtMnygcatL66aFPY4kCmpcRJvSqDU1HiT8f7Omz0kKRQ8prScQmgMnIl2PP6PTmkspi5i3il0T1QMNj0SwTdgV7DSRzzMTrLMCxpMP6306SfoN8Ebu7NXURi11TuzUUsyc/st0DEbVy/P7L99c/I+2vrz/Vl2IMWr0dJEA5rtSKlozFZwlFIf122go8kjYe98k3KpP0wNPKoFc21j3F4sY31rfgH9abKl3tdHQN8WlgghB7eBvWoPEK9ApCAgv7vKRtgbkIr1AJYA9IQkhB0aUzTOfIjodvFghvyalDUP6XoX1C6s4UHCgmxF7T0n6JscwkMqgIH7xccumBWhbkTIYGV8kfdUL6sCjqfQysaYbjhL0DBMdp/1kX3b+RVkXMZ1zYV8jGLs/Ee7YJfVAQ6+4lh3N1UQS0oy6McvQGoXHg5YYyLY10K4sgYT7HNTs4KvQsSeOkQl6xBedF2N3Eo1+oaM3SgkqiyTKnYCSL5dve+GDKIN0iEduU4N6U2xogIgvLPIAHtOsAra/LU+PnyBxVoaK9cDmZMU0WLhygHDylGlGDOn9MJG+CWw/yvtxCFEeTO878Q4IwUeRQhciugl8pCbagLImuLwgCRq9dPEvt2vE1pn/gyZ4WVblnNBdmKxeSjuod3ei51C4k/Slgxp33g0XHAg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(38070700021)(8096899003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9oaBybAusiXHkJvIQycD6CTIbT8j5R1CgsRyd/e4ZdezmbOeH54+fVBosK?=
 =?iso-8859-1?Q?mnPvx/wu0PvMsKZ3zGgI9Kct6wyWD8kjNp4Bd3WY8FY6PDrSVvFPPhW1xs?=
 =?iso-8859-1?Q?jn2ZwodzGmpMI0XyRmVuYlhWvwA13Yb+Gfkyybo9f6obIPkiCRHzEV7bp4?=
 =?iso-8859-1?Q?Km+C9FPrivYg7KLvrKwzLbanIWPrlGZp3LjrKaLwq6HMrz1QjbX73MplPB?=
 =?iso-8859-1?Q?xTeUUf8TuHp4HXfjGW2e6SzzN9ugNUNULqNCwBthokPw69AmDKhkjLJzYU?=
 =?iso-8859-1?Q?Dzt+HxpvGgf2QLDdg13Yy20mBzV8ud83gGsONbrCpE19/g/J064h2DVakD?=
 =?iso-8859-1?Q?5sIt0lfFqr7s6qjL7jb0ypL1iP0O0UrCYc0TLM09cbX1UbdNgm0DG3jmvo?=
 =?iso-8859-1?Q?eyYEr5VbzFgtaIYdqH2tGL5X290y/yTWY9G14ydXxwG5qaS/Ny3/C+seKB?=
 =?iso-8859-1?Q?h2hSOjVJyhsgmUTiMac6cv3GIsE09E4+0/KM/UO3Gwfw+CFyQCspCQB1cE?=
 =?iso-8859-1?Q?CLfLiSz36DiXwIzITLfpOCagNW3QtDpg4VIhhVb82m4AUbCJgSIl/7RvOn?=
 =?iso-8859-1?Q?JMBl8OqrI2pasO7Fu1KM0Etkdy6uqYjpR1k98JBbfebUv5hYEty7Sa6QgR?=
 =?iso-8859-1?Q?7CAA1iK11fVvY+HKftL2WBqt37cfF+zZb+yTmBwJkpYgszvCxsrpbOG274?=
 =?iso-8859-1?Q?zNRhiY3Fn3kRqVJ2nGXUjf51fLAmaJeL3FRXFm/jgMNfow+tnqpZCbFU3A?=
 =?iso-8859-1?Q?5eytrPucerR5VR1XP2KOpLfhaWB4IlMCMv6GT0VqKHZjOMAVa3fpKQjSI9?=
 =?iso-8859-1?Q?41ST6X7v8O12hvThAx6HsraTYWIaRrH9nuvfreqYMfQTLr1TQjnCq/8EJu?=
 =?iso-8859-1?Q?PewQJNKfkcUya3rR4J00NI+wtzUm3wKlzoLR9eieCbFCF+27wks3V3WPcP?=
 =?iso-8859-1?Q?tz214X1lE4LChJVJANNcBeypN43slhGzi4MEZWIa82kqNar+aeQbH1O4eT?=
 =?iso-8859-1?Q?4B6+6zG+jWyl6WDFSpWJ2AJh3bpGX5eWe3GkE3VVuE9YnSrKFTFP28Tm+Q?=
 =?iso-8859-1?Q?tRDV+eBE8GS4TBXZnM3dGYNXEhXit5k8l3AvI2bu5fWdkmkAPd7ojVtzlP?=
 =?iso-8859-1?Q?mszxHFRER7oPgv3tkVO203Cf0MiLK9bpDJMar3vKrazwgoaCv7rpk9zgcz?=
 =?iso-8859-1?Q?tXrlNsOzpUw+ubN97qKiaPMk+2yFTtZs0LQC6C05bh0SNsR6XgO96sfWA4?=
 =?iso-8859-1?Q?Tj7Bzc078rQSzVgc4x+kTiF74EJxOaOSabUy11Z4U81WqMfT4S9aed6Xam?=
 =?iso-8859-1?Q?tCuL9AT4q5M9bBSMHsHXuZg8zxNyZ+sacDQt7G/PedtAFtf5IdSJPbtCe6?=
 =?iso-8859-1?Q?uvDKSWNS7PObLIFI8SqytKwOIKGFSSh9BLacRNS9CUJoZa9TN+Wjq2Sil+?=
 =?iso-8859-1?Q?7jOFQ2K/hxDjaEWUCt1I6yG+FkPjc7vkUjPiCRtm7XZhiu1njzfjMIF36I?=
 =?iso-8859-1?Q?+AB3GOPiFu5QWLljtavvzvUVpB9UK7b171CCm88nxkPKAFKLr/iCut6nNQ?=
 =?iso-8859-1?Q?zp2qU8N8raTWXOGU3qy5Ub0GUCeUYO6QEp6OfIlgjMOiFO55JO653CF/ig?=
 =?iso-8859-1?Q?sa4QNo5FEMYLx98f2FEKBs/8sCQ7MPC7p+gNLH9b7ntx7jnrzXi7LBPCKM?=
 =?iso-8859-1?Q?OoXL47kTHGuwmFNjKqavSR8lrseN6QHoDMSfmgNrz5a5ACOp8IEd4L5/kD?=
 =?iso-8859-1?Q?jPgbFNMi5KviqNUvRhO0Za0W049MVs1mc1zfEodDb8MkIP/RAaBuYYkMH+?=
 =?iso-8859-1?Q?YhR0pCzyqw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646C3BBFEBF3A70F6C56286FCBA2DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yb+ApXxUKGoSh2iaqtXO9fI433giO+K5QbhWMce5JliNWWNb9r0voim44N64dmL0qQ/SRAKR5VLVG1kZYFWK4fJeIN9l2qPd3Tu2QMNzvA7k6KIAKNZN52ghbUI3R7apcG7v4edhnNw/v3s0Z0HyZUsSX5MQJd5jpn6Ins0cMtJkffVrKcb/M+BlNCESREsThsTJydRQbv50qL0FjfRHZoyspxT8GTIHpH1bItYxP/RdVPhWfSwYAh7lMQqDnRRk/p3zQkSvrSAIuB016Wzo98VWixtMpMdirbT+2BEZV/BdNqA3qfwX7LUSi/P9vWkuXa482fs9dFoJDE51n625Ow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06ee82a-0832-4146-1432-08df13324469
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 14:04:32.6846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WiwqSJzFmPbT1dqqzOX0E/9YaTA1aI0mhYx+nJF38SAWigg76KSLGvyuXDuh7vpX620ivyundti+ogqEvlp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9399
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

--_000_DS3PR11MB9646C3BBFEBF3A70F6C56286FCBA2DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-09-15
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
- ARM [No]
- Broadcom [No]
- Debian [No]
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
  - 201 patches pending.
  - 30 due for review.

- next-net-intel
  - 50 applied, ready for main.
  - 59 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - Some patches merged.
  - 8 patches pending

- next-eventdev
  - Some patches merged.
  - 10 patches pending.

- next-baseband
  - No patches pending.

- next-virtio
  - Working on issues.

- next-crypto
  - 26 patches in the backlog.
  - Starting the merge this week.

- next-dts
  - No update.

- main
  - Merging patches for deprecated symbols/API.
  - Working on MAC address fixes.


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




--_000_DS3PR11MB9646C3BBFEBF3A70F6C56286FCBA2DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release st=
atus meeting minutes 2026-09-15</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Agenda:</s=
pan></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Release =
Dates</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Subtrees=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Roadmaps=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- LTS</spa=
n></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Defects<=
/span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Opens</s=
pan></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Participan=
ts:</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- ARM [No]=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Broadcom=
 [No]</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Debian [=
No]</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Intel</s=
pan></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Marvell<=
/span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Nvidia</=
span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Red Hat<=
/span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Stephen =
Hemminger</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Release Da=
tes</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>-------=
------</b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The follow=
ing are the proposed working dates for 26.11:</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| Date &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; &nbsp; &nb=
sp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">|---------=
---------|------------------|---------------------------------|</span></div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 31 Augus=
t 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 02 Octob=
er 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span>=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 23 Octob=
er 2026 &nbsp;| 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD features freeze =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 30 Octob=
er 2026 &nbsp;| 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin apps feature=
s freeze &nbsp; &nbsp;|</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 06 Novem=
ber 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation ready &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">| 18 Novem=
ber 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</=
span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
<br>
<br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See https:=
//core.dpdk.org/roadmap/</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
<br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Subtrees</=
span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>-------=
-</b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 2=
01 patches pending.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 3=
0 due for review.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-intel</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 5=
0 applied, ready for main.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 5=
9 patches in review/waiting.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mlx</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o update.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bro=
adcom</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o update.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-net=
-mvl</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
ome patches merged.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 8=
 patches pending</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-eve=
ntdev</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
ome patches merged.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 1=
0 patches pending.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-bas=
eband</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o patches pending.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-vir=
tio</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - W=
orking on issues.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-cry=
pto</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - 2=
6 patches in the backlog.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - S=
tarting the merge this week.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- next-dts=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
o update.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- main</sp=
an></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - M=
erging patches for deprecated symbols/API.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - W=
orking on MAC address fixes.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
<br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Other</spa=
n></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>-----</=
b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - N=
one.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS</span>=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>---</b>=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">See also: =
https://core.dpdk.org/roadmap/#stable</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">LTS versio=
ns ongoing/released:</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 25.11.3 =
- Available.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 24.11.7 =
- Available.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 23.11.8 =
- In progress.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Older rele=
ases:</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 20.11.10=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- 19.11.14=
 - Will only be updated with CVE and critical fixes.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Distros<=
/span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - D=
ebian 13 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 25.04 contains DPDK v24.11</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - U=
buntu 24.04 LTS contains DPDK v23.11</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - R=
HEL 9 contains DPDK 24.11</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">Defects</s=
pan></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>-------=
</b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">- Bugzilla=
 links, 'Bugs', &nbsp;added for hosted projects</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">&nbsp; - h=
ttps://www.dpdk.org/hosted-projects/</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
<br>
<br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">DPDK Relea=
se Status Meetings</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><b>-------=
---------------------</b></span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The DPDK R=
elease Status Meeting is intended for DPDK Committers to discuss the</span>=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">status of =
the main tree and sub-trees, and for project managers to track</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">progress o=
r milestone dates.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">The meetin=
g occurs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DP=
DK</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">You don't =
need an invite to join the meeting but if you want a calendar reminder just=
</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">send an em=
ail to &quot;John McNamara &lt;<u>john.mcnamara@intel.com</u>&gt;&quot; for=
 the invite.</span></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><br>
<br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"></span><br=
>
</div>
</body>
</html>

--_000_DS3PR11MB9646C3BBFEBF3A70F6C56286FCBA2DS3PR11MB9646namp_--
