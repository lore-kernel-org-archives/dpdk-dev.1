Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441CCCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3992440E3A;
	Wed,  7 Oct 2026 13:05:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A5D0E40698
 for <dev@dpdk.org>; Wed,  7 Oct 2026 13:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791371154; x=1822907154;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=GIFfoYZUWtyqhOCg6shXw8g4M2bOeMa77XahWoRK+GY=;
 b=DzAti0PJdzU+GohfgZk96vTEzT7K150w7/dSMPH5ppca7juG5UTrHVxn
 Urg5rWfiSXq+pJPJy6qqEiN9mcOlGuFqIlYAcv90yRq+HG80pUFCBxdBK
 +5WN3R9XGVSIGB2bMmelz0OPPUVPtxhUE6XsEw31I0mqOqKWXLIVWvZYJ
 2+JuhOhUPY798WOj2NGy0itrgKtKZNefqllctRP78cpkZeqdwek6rtqF6
 0mI7RM8ja57HFfMhYdMs7jM/PEoj8XlygDr2X6q4cF3fCQv3IB6yAtVSc
 1ws+b5dVM9DOgcErBGN/OUoaHJFz7KmOjV5B2uFHMa2ZF9EotR7XKjN0Z A==;
X-CSE-ConnectionGUID: cbNZYcUfTimVmOy+vBbPaw==
X-CSE-MsgGUID: 4bCQymAfSwOVunqhk9NB3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="132621"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208,217";a="132621"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 04:05:53 -0700
X-CSE-ConnectionGUID: k8S6/doYQ1u/2nab/mYhYA==
X-CSE-MsgGUID: rlaHP/X9QrmSJ+vY5Q7pww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
 d="scan'208,217";a="276531225"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 04:05:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 04:05:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 04:05:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 04:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLzvFy430whO7scu4Y116F3YNldWeBpKUiYpVCwzhqj3VhP2fpwTLJ53GuC/FjkYHM0do/OP4Am86JB8MhvMyf2OKt/ZtfX4184qluNyafMRK5VGdUP1/xt03jEaqy265+nMsAJ6ev3yeDqF1QmG9sE+a23wCV/YyPG+fHwLXWqB2YEEq3DxGR9Sd4GuycsJVkZtYSn3I5a/JKw06rrScOKHIx1aboERKJfMq9TItgmaCiJUp145/0seu0MyCEnxVJ5Ri24zsTOtm/Kq8bHY0w2j1BHhZPiThJgsCrfpj1SLCbmHA7g+G4y3wrzQIC9ms2xrFgImCGTzxkA2y5blOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7jkS7Fy9reyCC7fok681GgByfaaaWjDysnuHVMGx7Y=;
 b=FfFiHAe5GF50tyehdYlEHkSSiMpiKeNzBxon8NBQrKBmMO14X7Vn7+KMGLPcukPIiHspZ/rP+CjJjsrvoYQIm0UJnukyR88O/PMsAK4aAd5N+svSE1TnuJipYhkG8AK1hH56poF8ScBp9/O4RhcAQLzWOsIr9qoyPM1lnq62S8EdXdbN0jYPBigTwWlogqy1zcdHJkrd6jwKvsOZ3Q7ILWl+yrN7+7/o8SauPitWKfus4jHAAj5rGHMujSqoyDI05rNPe7y5OzRgi5VvQblQAyqxZ97zDfuGQyf/NpQkpyiNVh0K1rSsnVwkCzEzCj/N0SoEgcXaSIdfK6P1nt1RXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by DSWPR11MB9954.namprd11.prod.outlook.com (2603:10b6:8:39d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 11:05:46 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 11:05:46 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-10-06
Thread-Topic: DPDK Release Status Meeting 2026-10-06
Thread-Index: AQHdVkt0eJoxYaPpcEqWhX9ZvjCSlw==
Date: Wed, 7 Oct 2026 11:05:46 +0000
Message-ID: <DS3PR11MB9646D2AE421EB940522AD22AFC942@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|DSWPR11MB9954:EE_
x-ms-office365-filtering-correlation-id: 3468836b-72f2-420a-febb-08df2462f056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|8096899003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: EBGVwss5N2SmSBtI1K31RlZch/epRJRWCphC1ZTQhHqXDp3D4Yrnw3+CM6qyW/Fw8nLfl0BZ2Eb4bkHD6upGFXXDbQF3aGhvd7uVnUWnfFlE1KiIQQ5SVxckyoccEdCWWDZV6bMUdS2h1pY454pGB5lUQwiXIdPseI62rKRxHGHpaLVxUmeOkl5W+ODY3PnaXSvr5iuiNBCL1zEXKh1iqqyB8KHwq6ij6IMUPMfnJ/kTArMXkEhE7G6YIHHtsCbgUtAnNdU8PUyUxaE3HTnftwwyFe7RiRju+8Lm/kGPcD6ekl6q+ISVtYi69XXXVbnNy+SzCFC5aWsm8+6zKaYrR+TUCYjXl14rYrEvtNoQqPo0tLl+tv1AqMmNTTzgYZNnbHu3zbH/uQORmU/T7+5eNuk308Eg28i6vwq3VWBYFSe7eSQejj4H8Mt1la2QgNRpYQ2BnSFYcL96tnqJGTUPZteGxCG+ACo1c39tSIXiop1PB5ZDN3OR/afNESjNhIHAzgUC4a43bi6u5bEhM2VQuRRcCUg+7/0D+n2JB2xFonvJbzT35LSkvh5KboL/pUU/UESjdpR8M9swmjpdbiTQpnyJr5+FPj/uFzLpRwD6ofprfVDbY8BcKOiB33mjeOEl675ojYcXlfanhOggitx0XDv5G2cNl5ZVuykOpaOMWKQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(8096899003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JcqYK56aZG/gpN4Q4ts/rln0tZfqElZsB7IdawU/fF6Q45p+qk9x0cIM1G?=
 =?iso-8859-1?Q?uEiTEv8PAHe/2Q9ClxV10DpKe7xsSdQN1Vu/3EMrKs7g/P/aqdP90/LSL+?=
 =?iso-8859-1?Q?5gGqzg1GbeMe9oQbAzSUOQq5VukjOyrLb2MKFAKPr6yIPPk7GPwyTXFkae?=
 =?iso-8859-1?Q?c2nhnVjnGA2MvPI1tPvv+HU3bVtYXeS6zrWvgep8iOPMu/JrdjV1vZibo/?=
 =?iso-8859-1?Q?rAidipP9nPOM5arw4Oqk5CRp+ACtneDFpWV+5nobDyIJcFcXhAFBN3zJJF?=
 =?iso-8859-1?Q?oYhO7a7qg6h4p5RtqeKmEEhW3oPOkf7LExhCdXF5is3DPsEB8UF5Lqy4Vn?=
 =?iso-8859-1?Q?vPf37DiCwJpkgJJku7B58T6fLTIwQv3E8f88MIn6I3mAhXuMSIahiFB1Kj?=
 =?iso-8859-1?Q?DXkHfrFTqbIPESK/bVxlbds5Ka0Y0BOBzlCrMfyFPxwoWtEoKyZvMJLgEc?=
 =?iso-8859-1?Q?tHRMl6rnPnbyzke8g/oEGWlo/Sqw7wAfJkJQaQZZFpXPdbj7F1dX53se1R?=
 =?iso-8859-1?Q?nqweNY7CLXvxZctuadaWlkeG3s01xnCdD32pyAz/i58l59IhKQJMNyI5Lr?=
 =?iso-8859-1?Q?mw94m7FmfAwo8bYRSri23Q6kp2IWeQOwpTwF6Pzc2Q9rupSkqu0D8kqidZ?=
 =?iso-8859-1?Q?kXt6Go98TPdcj9O7haJ/iJS2zf5C0qljtx9xnp8p59Qa5EV3Ysehhjbnd1?=
 =?iso-8859-1?Q?GmPw/6YJGjEFbVsUZ+HbFDJTdhQCULFs+EMjM2CXufbCSVDr+HlINqT+1q?=
 =?iso-8859-1?Q?oAR4vbU8AJaHaFZJ0ba2ntN+QE5uqJuRcOmxUIu2m9jxAdvV1Vz0mfeRFM?=
 =?iso-8859-1?Q?970GvJPRvHkO7ENjG+fMq+b7X47HJCAKHX6aYCDLn4NzY3+SG+OT/kLjK8?=
 =?iso-8859-1?Q?YaNaOyc928cZWnJjajgWPBnGzQizm2fmYWy1u1At45jdawqbIJ9/0tYhCV?=
 =?iso-8859-1?Q?wOH4zrbqqId6sR68RmVUElGvJxpxtgDXaRWo6dPh5OEIGAHhmqh7nI6Shf?=
 =?iso-8859-1?Q?pYElBZO+BlCEqR/zL17ab3gmtGacZiehO2BRVW8gfC80X6ANWnaXv5uFza?=
 =?iso-8859-1?Q?hwlSwHgyS8h1fHHJVXvwVoBBcXP5yM39balL4srz5UlXB0ym+J/g4j3oNk?=
 =?iso-8859-1?Q?9GZdJPqXIO6FgbXO04UwQpBrsKzfJ50fVUPNtjcYVVaKeO4dKmXWhvc2iF?=
 =?iso-8859-1?Q?JwLIjisvPhSLc5a7kLtY58f6Z9BeQaTo0oBNZnGu4uB6xHbArjYe7K7B1j?=
 =?iso-8859-1?Q?tkc1Mv5alkIfNneCqtldi9X+8gO0rMAd/7L/S7AM7kELQji4a8WUJmq4x3?=
 =?iso-8859-1?Q?lznVocyPXS12Ncx+4rdiMF2odWukXXC4KD9AWu35+3VKxYYl1Rur6B/9ED?=
 =?iso-8859-1?Q?eltH8FPmLwNhUTZXnkfUgvaSHi255gNcL2NpHdtDXgpnNkaEwbAOTS7Dx4?=
 =?iso-8859-1?Q?pz08MKQOSDRGG2uZyP637/EngsrYPlzDBjdkdblk0r30XQdage+0T1OOe6?=
 =?iso-8859-1?Q?hmQTo8WtyPig6My4TAQb7MzHrWXGr7K6vrYkziNQmzz9JB3xYYQOO5Ed/x?=
 =?iso-8859-1?Q?7NClp5iS9t7bN6eaz/yxLF0zEwicn780912V3KTuZG/CkVqW0hnQAxPLlA?=
 =?iso-8859-1?Q?/pqNjTpUTzyLV9tVAPh7yRV2Jqsr+ESYnTb2vkaQEJ+NiG+4z62iAbuL47?=
 =?iso-8859-1?Q?7ve2Z6suNhKL2TvS/Y7q8mWR01kXN7ymTD+FNosDWr41M5muBOdB79yveX?=
 =?iso-8859-1?Q?hT5Kg5Ku2xLsKGvBSSHMBdIQChgBc/qzEmO43otEZxjZSaeZpAYaabyQhp?=
 =?iso-8859-1?Q?0+sjKWxP9Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646D2AE421EB940522AD22AFC942DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QcqbG0fUrEpGpA2a/n82p0q4fNbhkwYkxlBALCMx8S5sOo1BQYnjJA69okmEE1UDsuH/Mc343HQFEfhTSo9Y0ddxG1Abn93ayafytWRHzhiSxynW4/ZhA00udzLE8rz8BvQ47GMYRYgf6LT7ax6lNMy+5xPAz9NVcPd6lfMMq4W7CXKujbIq0u7Wbk4aNfpxD/n3XP8B38eSdyYm6FK/2MM9QqEu/9ZWL7ZI71k6m0i+d62iU1mcA0uJnVylWwARV1Xv7WT1pmL3g6GkzLpOgXaB+LjyBMcTMuyzWxf3Jh3N0WfBWt9TtMkbSAbEcQ1Kh3LJ+IcWMVbCPklWWTSZgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3468836b-72f2-420a-febb-08df2462f056
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 11:05:46.7331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjxYHJBvcShZl7zuz3cfGbo8nSrdUeRr2OVyzWVD8UjuTvj4LOND6o9jIsKxUw50p4M/3/axZMCkE+I4ArRimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9954
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

--_000_DS3PR11MB9646D2AE421EB940522AD22AFC942DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-10-06
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
- Broadcom
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
  - 34 patches pending.
  - 38 due for review.

- next-net-intel
  - 25 applied, ready for main.
  - 12 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - 21 patches pending.
  - 25 patches in review.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-virtio
  - Starting to apply patches.
  - Other patches under review.

- next-crypto
  - 25 patches in the backlog.
  - Some merged already.

- next-dts
  - No update.

- main
  - Merged series dropping legacy atomic APIs.
  - Merged series reworking internal APIs.
  - Merged updates on UAPI update script, similar to kernel.
  - Reviewing VFIO patchset and making changes.
  - 2 DMA drivers to look at.
  - Looking at EAL patches.
  - Updates in ebpf library under review.


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



--_000_DS3PR11MB9646D2AE421EB940522AD22AFC942DS3PR11MB9646namp_
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
Release status meeting minutes 2026-10-06</div>
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
- Red Hat</div>
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
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 23 October 2026 &nbsp;| 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD featur=
es freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 October 2026 &nbsp;| 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin ap=
ps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 06 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
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
&nbsp; - 34 patches pending.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 38 due for review.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 25 applied, ready for main.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 12 patches in review/waiting.</div>
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
&nbsp; - 21 patches pending.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 25 patches in review.</div>
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
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Starting to apply patches.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Other patches under review.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 25 patches in the backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Some merged already.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged series dropping legacy atomic APIs.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged series reworking internal APIs.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merged updates on UAPI update script, similar to kernel.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Reviewing VFIO patchset and making changes.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 DMA drivers to look at.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Looking at EAL patches.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Updates in ebpf library under review.</div>
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
- 25.11.3 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.7 - Available.</div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - In progress.</div>
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
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB9646D2AE421EB940522AD22AFC942DS3PR11MB9646namp_--
