Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C41C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BF7E4042E;
	Tue,  1 Sep 2026 18:09:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 50C49402E2
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788278979; x=1819814979;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=QfPrZHH4uTWfAQ+arafTl8xE2mj2PNG6DyPG4BQw99U=;
 b=IJtf+yKU0fFpw/mBUOQCTmQeDVZy8VZFWSZiLMG/6nAnkS9yC36pFUy8
 jzcmauHy/dxzqVkHvnFCKHx95RPYwTBDvGGG8F55TO6OWrePSSjNVf5PA
 9b6bmoyZ4FkCkeB8NRzQKihQ3csp6cDyaRkowCc2dOlrpuw3rdw4J5b7K
 z5U/ppNHttVgkM6WMQ4lcRbNhHMZd7DJHydbEX9moxfidzKeO8CexYpiU
 j8IBD9uMhIAqVfEdPMqZ72g032Dg2IXR4pFlc/tkVBRVLxx4UtPO/e0pD
 4A7TVHzFMqn+lRAZVdI6SZkfFG1en/sjyc76qqVG0p2yUPK1azYpQPG0Z g==;
X-CSE-ConnectionGUID: ShJSHu9+TUGf9vxob7aLaw==
X-CSE-MsgGUID: yIViPxXgSnOOK7x2XXK/cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106234208"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
 d="scan'208,217";a="106234208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:09:37 -0700
X-CSE-ConnectionGUID: OjvnhaaUSd6Rjx4YGR2pPQ==
X-CSE-MsgGUID: WkCUMEn6QHSb3K8O/uaSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
 d="scan'208,217";a="272917436"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:09:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 09:09:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 09:09:36 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 09:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz/AKxow3IYM7lVF+znrqRSjkSv2qkr1NC+5MV8BTRz7TezA6oefAI4bJC4RHeKJjukBoqdMZdhfS9pYY28QLdfz54Aymw3bB3U2+CuBN0G0a/X6AhyRO5ZsaWbT/w41OoAo50SpoZEX03O6W52U1jSBDvH4dDBC/qgQoJkBlg/EzUsP1WeJThVmDJy2Jsyb8DAg6RQ/Qg/aoi0jgU49DH7u7MeQb3vibcmpG1YlXO1ON9Uj1WXN3s8GlZdfjbh87/Okm2k1bwzrNE/Ecbq25oWuyjF+Vg0RKcimvN1VkIoTckqSY1uZtCR3aOx9ln5VAPb/4HyxbuwwQFLw19XD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7fq6UljRNPliBsFttPkiQCl5gjAkX3xDZ6Q474ZdC0=;
 b=fBSJqN4jIhX9SypYho5IlQA9gvY22kZTFO+FzPRIpusA3hN6pCXDBiKbkzSZxRBmpG4kADeB3qodYi6gfLfRuOXkV6yXxqbjnAUPziC91LYBk/xcvqUwV9v0UDlUwC7SXBKFD00r7jEQgBx4L5PKAg0oyPsFWOndj+2glQz1o7TVeu6hUvJ29L0rdR4GKMTTGYx3/8YBGI/0psCB1NddAypA1nq5GPk1XT2SEnEOf1xQXF+sJBA5TZf4ATsYFE/WaxXnKOEAGph994Emf+/vdqvQXdg5DPcMu9fAeryHV96t+AUzB8NYR4tvCk5r3ELBezFTQ28rlx587NY4yzK9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:09:30 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:09:30 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-09-01
Thread-Topic: DPDK Release Status Meeting 2026-09-01
Thread-Index: AQHdOiwy3lwUIS7VJkWudMOcG0HCog==
Date: Tue, 1 Sep 2026 16:09:30 +0000
Message-ID: <DS3PR11MB96465F02B0ED3F8F78C614C3FCA82@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|LV3PR11MB8743:EE_
x-ms-office365-filtering-correlation-id: 6ed5ae2c-00bc-4eb9-046a-08df084367e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|56012099006|10067099003|11063799006|8096899003|18002099003;
x-microsoft-antispam-message-info: Gmucy8GIZuJa8DKHk2n+IJzOuTeLETxPhZ5t0vHy14/uD6iGalUaad4htXSUjjK7Vi6WF4WUXDHFD3ffBkBXI5jXc6BVZJnkKMh/HDXoF1rvJpJGvMky0OBg8jzze/cAcXng0334ubk5m/zO8LFOd6Pkk9JKirx+KNy3KyxnfjHi2pXilaxo17CIxQ8jVeWhRAQNLuz5GBH0nzVNEAgw+nFX4rh2jJaADIghC8AEh08pWjVZLXGHdIZUaaYipsaGmNeOVmfklO95enRwqlTAHUYE5Lx1AYDdC/DZLsYmUzCXlTGXzAM7rFD5p+2xRn7/gKDeWc5zfQ8U/zqL9erABLyBvKUi2cN1wBcZp83QHvugUXpkhU6+0KnGA1PcMRfZ1ODeNn0j6LRm4SqHcxMbdD/igK4+2WbeznJkdZWhpCs2hDoAEyK8rhhXTjj1/rHB5PFre81MRR99X14N300B5OQIW/VaU3+mJlWo8vTqL5JRQX9zsSzVi5DvQ35n5XLEX7qwXeZ4qwxRLRmIUKnEqP/MpP+OwTb6Id1mga46u+xQ84vNF5PICAGZVdy0Y94+Pu1Fr40jPy0dhHY2kr2v6ka6dNmJZocTmY6Taz5MquWOxJsQt3/8HdX3y2w3AyMd1zC9pKVzPGc4tBzX+vhGgXCuI8zoisJzXjTBQXNXRXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(10067099003)(11063799006)(8096899003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q4A8bz4a1IUHdjzcjSYqMtJHrIT64gOfv9OciKWdSwdR9xJqY5QQS/zQlB?=
 =?iso-8859-1?Q?Cumn48umIkNBLruRi7oZR9CSqINPdG5FCmNHsysMOe1v4/66snxthXq6xk?=
 =?iso-8859-1?Q?/D1lnHYp3M3D5iHv+/fSQ3ZhrJRU6j5nMNBW4Stsmig6ymUIAWFUYAMdID?=
 =?iso-8859-1?Q?W232d8JHyLHHIjgUYOlXpSZn8M55JMTCGynHGmt/FDV8CDILm4oV4UdM/p?=
 =?iso-8859-1?Q?ikVZq2MxisiTwaM52InzIVitFiurHtaTb2VWGg4qyBxo2/TiO1Bvkb7fqy?=
 =?iso-8859-1?Q?NjVJXjEmY1HjqlZRYl2+ffeWqZjt/k3cTmwTGnAJHwM6kfOnmc7PkvCCpz?=
 =?iso-8859-1?Q?mezK81ydLCCpuTjZL9fwrgedqklD0Vjud6pIlijnyD3sxlh81AFkvtAHRY?=
 =?iso-8859-1?Q?meXJuEgRHQnLAMDpygL7oucJE9/tUOXvF8VZdcHU9a9pcxMW42BkHKPiph?=
 =?iso-8859-1?Q?j8hBv76SiIIxTJdCmO0g8Ga+TH6ahfWikb2dnP6JbzAmqzKlX7uBdLJMIt?=
 =?iso-8859-1?Q?GmdSVavt1FaR9kOHurCjyJ/qEomiWdg6yJ0DcrTblWJP9sTPqshuv/Eccd?=
 =?iso-8859-1?Q?mxB3DZ8TNs3LKLnKSrunk02zejXaPpNG5KdxSQe1g/zgIH1vlH+uNySop1?=
 =?iso-8859-1?Q?Ylm6toxfYQ1vvMHTCAItFJaxWqdoTI7Smi6XJhc9aW1Eqhk1qOvAdR5+An?=
 =?iso-8859-1?Q?PWqqTy+6x8sGRgfQZnw56MPAv+UIRJr76n5G6m3zrQ3OuiExUcomeU3bFZ?=
 =?iso-8859-1?Q?mc7PAyZY7Tya8ioHhAW/edtj6k+VmEbSnbLtlUklJoFtKPyQTgwc3WvKpj?=
 =?iso-8859-1?Q?y9Z9DZhOoKK3aBQKC1iHRlmgxERUggmM6db56uWZAVEDcBAtUk4HuRSpkR?=
 =?iso-8859-1?Q?GfM1sJyGgdaPu3VKnvW5rBs+UKEE7lIibd1739+3G7MV9o1JNH+Qqyhm3D?=
 =?iso-8859-1?Q?CeMRwzbO6Q+uWg0aNoeE6mAk61jSFPo5HpTeds9SjPTp5GwIy6c7QFMvbV?=
 =?iso-8859-1?Q?T+SntJee72Wm+DfrZ63AQcESHC6Plz/vo9c2TdZmvYx+0jTShswmf4JfSQ?=
 =?iso-8859-1?Q?ukYhmO1eflyvx+K1O3jsX+bIQYSOHoli0rvbZcOKUa9eyhxhl2XP4Njym/?=
 =?iso-8859-1?Q?XiFojU/3fSJeiQftsS6B8KsXzTWbhFtqhZCMOStGdiKpNrr7CFnOoNGTDM?=
 =?iso-8859-1?Q?RYCQnPDAdXNEULZqdZjpHcnTQNq26ycgcL8nqDnvNHkeFRsv5a0Y6OYIiN?=
 =?iso-8859-1?Q?rq+F7rCVs9Gotn0yti9DTNdlCviOBKZdIpjng7Pd98Bu6+mkXoHYZlLC+V?=
 =?iso-8859-1?Q?f719VCbPYZRqX/RYV6bXNeL006vcnlsda1Rj7w/DGVtFpF/cqjdYVVYu+E?=
 =?iso-8859-1?Q?7PhbTjbk+wRkoeBIxg1krY8/ds0FY0GhQ5MaZ4auJUuqtn7vkTuMbRRfsK?=
 =?iso-8859-1?Q?DauLrlUjFW3aec/HVKlYq9ldYJ/+dL8gWjDGiE/H4RVJwOaclfzzX1QBdy?=
 =?iso-8859-1?Q?Dt0xHsneOqqSGbcivuE/HhDExb5DJGfnS+xJgt34rBMI4KtHPFoFNyRfCL?=
 =?iso-8859-1?Q?9DBKj9N/F4btx/Kc3AuQq5pwOevYwIoLg5ehUZp8sZ6P8SEOwkkX2m8IdO?=
 =?iso-8859-1?Q?ioQIQ6pxFPLRzcanfER1uDdRzeUCR0gzYztvVihdUmxlnAzmGHyIZA+W0g?=
 =?iso-8859-1?Q?sFUM4U66R3LkdKdO1RMDvhW76qEjo8/53KfD8+ujjDEB9T7S4Qxq4C5ZAX?=
 =?iso-8859-1?Q?n3qpT4xGL1K83cGRZlIrFpuseYxVbbhQA85GqnNS9EckB+YwhSRGA2TxMj?=
 =?iso-8859-1?Q?yh2BdhVy1Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB96465F02B0ED3F8F78C614C3FCA82DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OPaMgblx+wlfYpXuzw73a5gQVUZ5gwsVd2RuKLsep9X2Qn6tCbCu5iauiXpH8IWvNpY3xIpg/tTeQ+TG9tIuUJPMeCkJzVQTE2AIT6vq68Y3CguWpAHZKhl9svqwpxgGkla1uXDyEQZl5IW91Svia9MryGURdcB1XyeonOVDSKBi2QSEdEMN68YFrOteyFRh9JyPLcmdi0r8+5iN70qyCpA7S3m6voHDe5x50XYQWk3sT3Ugpoy6liYzD72EEQkxpN8Xl+qjomQ1zvdx474YhYR2OQR1yFzcVAxtt13kNyUIXEsOoPP6nsl0ng9FaYMeZ7uYBc1nST/GilG6YNmEdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed5ae2c-00bc-4eb9-046a-08df084367e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 16:09:30.7874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqOaOE3gndUDnOG3uM9z/b9LEMcANvQGDtkdOErIrkvb4gYdRu9TPuXl/Rx1uhHlPLe5O3KQTZpp++CbVCgV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
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

--_000_DS3PR11MB96465F02B0ED3F8F78C614C3FCA82DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-09-01
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
- Red Hat [No]
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
  - 100 patches pending.
  - 60 due for review.

- next-net-intel
  - 40 merged, ready for main.
  - 17 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - No update.

- next-net-mvl
  - 14 patches to merge.

- next-eventdev
  - 1 patch pending.

- next-baseband
  - No update.

- next-virtio
  - No update.

- next-crypto
  - No update.

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




--_000_DS3PR11MB96465F02B0ED3F8F78C614C3FCA82DS3PR11MB9646namp_
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
Release status meeting minutes 2026-09-01</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- ARM [No]</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom [No]</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Debian [No]</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Nvidia</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat [No]</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 02 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 23 October 2026 &nbsp;| 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD featur=
es freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 30 October 2026 &nbsp;| 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin ap=
ps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 06 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>--------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 100 patches pending.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 60 due for review.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 40 merged, ready for main.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 17 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 14 patches to merge.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 1 patch pending.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merging patches for deprecated symbols/API.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>-----</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>---</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.3 - Available.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.7 - Available.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - In progress.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<b>----------------------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;<u>john.mcnamara@intel.com</u>&gt;=
&quot; for the invite.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB96465F02B0ED3F8F78C614C3FCA82DS3PR11MB9646namp_--
