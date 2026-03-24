Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2227FEC10B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 20:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54204042C;
	Tue, 24 Mar 2026 21:04:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2EEA6402CC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 21:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774382689; x=1805918689;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=CGQ7iXpCSZEW2kEvSWJhUXV1/FBeQSrfG3G3D93TIJY=;
 b=mo6UTyYp9mo9zW2x9ftH0tn0l9xkHQm5fFfxZY3MG7jAhm1bvggfphVp
 hCIYJ7nBad+3A/MuDqLzhCbo32gAPXzSuEVBC/Nsgw+plTYGE9dRi7an2
 qV4hBDs63NPMFgLSFkKuFMMkMsF4TbVibZ7kRQYFTtF/RK3E0pQjz6f3y
 JdYq4W2+Hw+hR2GfloNKh1u8tbg3D0K0Wzy9i+E7ny+shT7LuvwtYJRYo
 iQMMMMbLZ258TbC757OygmI0pwg28d983VWIvXMcBxvXuNrJH4ZkfqFqQ
 qRPYR0UTpTBwYRJPQylQsNhHTKbAyUO8xy1VCMUF/2QIkFCFKrSXgIkho A==;
X-CSE-ConnectionGUID: EmdCykySRtqRs6n1p3SCwQ==
X-CSE-MsgGUID: KwDJ3QKMSzepS62UFsJ8zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86488441"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208,217";a="86488441"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 13:04:48 -0700
X-CSE-ConnectionGUID: sSAcTpRCQoa0smCovLHtyQ==
X-CSE-MsgGUID: ayqfoWN/RsCyOIg8Jf6L3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
 d="scan'208,217";a="224720648"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 13:04:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 13:04:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 13:04:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 13:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1YzoCLdA0PNHZDPbofBMgZ3LzAMwVsfk+AKtFT9QqW6pl9HueO3nKk2gA80SMcoKNmKd0vgct0mkyyuBxqK794oWTZRfGgKU/L3176/Ju5Nky4LUTKLM1PEjFB+toNN1rc4HQ5CEpHTZS8oQNuLjpTNf9fyT/LMfeyT3Wp334jYR8l2mVVYAAmQTI+5bqkUhmJq6BiofjbXNTdr7EPj4zEanIEPrcVzqhH5h7lXMltukgoLDmDkENBkhvDv2xDESXOAhwrgmqYLWaoHMMjntE4iMCMeV0FlABjIUSivyCE1ilFWFd53CA3yNEYqkQONaP5J16lZVAwPLW4w3QPNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVENpkwnlafrdolAEpDSLmpRdznmE6nDU8tUJpC8/uc=;
 b=HClTzzzmtI20Ysr5W2ngcdFmveNpfLsRbyIaDDgQj2MMm/Wt/kkT0s3CMczqoz+fvp/RMSANZl98OfDMWrTVoZJr4o08MZF1i6noB0OecAa7zv+q9BL5K/BjphBBu0wPkiK0wlL8SxVl13fk/njngjxnGyocEUOxCJmx7jt1OOACq01sn4Vf/lUtdyDpRUp14zpKU8uEKG5hq9W8X983eg7QvepUmjiKBfum1RTv9Jr+rws87QbVgZNqFXBUly1cVbqqPqIImqNq9yMx66JBJoQ48Y8ho0Sb0S4huxXL7A9nXMOktXo3Dyw0nrhSFel4JOmhdx3bR22Qq1+odSK6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 20:04:44 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 20:04:44 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-03-24
Thread-Topic: DPDK Release Status Meeting 2026-03-24
Thread-Index: AQHcu8lVv4HpP9yNc0C4qgG+4Ij0mw==
Date: Tue, 24 Mar 2026 20:04:44 +0000
Message-ID: <CY5PR11MB6318E42ECF018B288FB0188CFC48A@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|DM4PR11MB8132:EE_
x-ms-office365-filtering-correlation-id: 438e6608-074b-4e10-91aa-08de89e0977d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|8096899003;
x-microsoft-antispam-message-info: F+XXwRqUm1UaLcdZSI3q8b6ZQIq1WYxFCB4blG67yRemAcK1gYtZXgmKOnOuB+9vzoGyLqHus3CqgTml19b4jMQ/9+93ohoTlWXdskPoTpo7E8MjTeSvb1cyCeCvWxbNQjc69gaiY4Y7/q1tw5Me7pkjF9IHIRTKuWSpVy9sDFRmsadxKONrUIg314mt0FRkbMSBb103MTjsqVngsfZ+2vVP3SwqlsvWBwWoBqMp70R9/wXNliP5jxWLCFbuAp/OOvtHiNKZw/nkZ/pmeNaHoJ5whBU1uYIIkQZYmyLt3a5UglruVifnZJyrw3GhkU3+xKYKdm53xfoiaegStjxANo5eNlybts8A42xrtE28khDNthXLPD0Lm1McoFk/ocsTWz72fbFy1GbL0lLYYkyR8R0tzYX6yE5ABNp8juWv1uNelY/SOP6D4I9A0T8j+zm3H1fOs24JczXd5THDvvXA2IyhmjUOki7nrFLA9S14oSmaop51X9XdgnR+eyULIMzJviAm7tFiHZKM65iChlvS7VwVL86FcbnxJn9LEhmXCkKwsa2h6UIq+xkDzpx8g5X9+QS49VLgms9jlCa39mWg3MIx11SFbcPGZF7IeXhiMyt+F5TToRH4Ve+WeThxD4/8qW8UdyzQoMITIpmmHjwuLkwMgkDyj2pVk7rps8rswkI2TbkIKgoA5JZYSl3YRnBk7gVvlrh8cL0iUNKYFa9PsZBW3c2PDZmSn6cEOLau1AQCHsw9i1qL67+FBVphcPeL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TwZHnSphopbTgkyWrjxhtSJPeu+DaYnUI4Mw4wvg+sdiu4oejY+DgqVOpX?=
 =?iso-8859-1?Q?jsG9A+ggun4H/yRTLUU/bJaZvgukHNVb106Rw+/SkrmwmC5n/M35nsqJsG?=
 =?iso-8859-1?Q?D1oOD9UMpgBL4KqOgQ5DZnBT0w4pNHrCpEVQLjxBXVnD4o1EQWJSIehQG6?=
 =?iso-8859-1?Q?zD7FE0koA2YCylH6+lDLgXrg8gvSuo8MdoqXisNj5tmRA6tzrqQZ4qPEwV?=
 =?iso-8859-1?Q?sc3PYICBkEs1UFsgdpZ+qtO9AUmSnwgI8SZwhYM7XNVIUSAu8MhYi2t8xS?=
 =?iso-8859-1?Q?XIxNMkLFZVXitEbwXq2AiPt78gQ5XBkk3U5wKkbr8krj/QP+3UMCQMrvVP?=
 =?iso-8859-1?Q?T3sZWE6hwVHUBeKJxc4Pw4k8KnWIlElZBPaeoRpPYvNwIcGVnwEItnrtrN?=
 =?iso-8859-1?Q?RtejnXUjfnu5EmJT4ZvYI1NiMW3adI1NdYL+83RduHZUctWBDV9msO1jtp?=
 =?iso-8859-1?Q?4/HyfkWNcex8ILgtz9cfhag4UXmpctVdz09SLAqr8a+cocEokGTjeZP/F7?=
 =?iso-8859-1?Q?Ii59Fc8pl2T84UowoZm5/arw3iD7zZawkHG/M75OECDeXKfSXqKt5hHXuW?=
 =?iso-8859-1?Q?2SYHKRflvx3N58lqKoxM6rV3Yn0os9ZhK3fQVU4yIH0L0Yi6JE+z2oh8Ja?=
 =?iso-8859-1?Q?hzoAOwQZWvUblyAPtOSnGGIR0yY5cxy01hCF0AbCeb+SENiBXWRHipVQU/?=
 =?iso-8859-1?Q?D/xdpfq4IQWLid08+y6TaPSMILaPu9cGEDc5ExXr59flRd9Luq9K0i75k6?=
 =?iso-8859-1?Q?kQlhmp/vWq2QK2mBtm+Z9PRwmM9Bny1/hHdYoDVOfnM20VMTq6McdGgAIK?=
 =?iso-8859-1?Q?dyJ/JZY9TTm1we9CM16t375qYI6Azqwr5LqDPb9EZ/z8sjdErIROIMqceo?=
 =?iso-8859-1?Q?+4lurnkjKbu/k2fiJLz/mqOd1WKyVJuYljG+8OPmkumYOAAAnHl78iCAOw?=
 =?iso-8859-1?Q?NQNV+4TdZ7Tek9jrVgWLqB9bl4GaV+TN8UqKRLpm16qEFdbZAVwra3hJa1?=
 =?iso-8859-1?Q?SqxcZSPctC+Pk5u7aVCYrQ4PBr/ruXCiBXD/XOY1q9Dloth5uweeJT3hRK?=
 =?iso-8859-1?Q?d5KZujAwK65CQoUmJvO7BWXE7/PDB65epu5IVbUVIcgN6optJYP+NmFE1i?=
 =?iso-8859-1?Q?VK8a/RmQC78Yp0n1N5VKQer54CLlEvu842jkd3Zymd8ZmaI5hYg3l58JRU?=
 =?iso-8859-1?Q?A1w8RJ3/+Rc2N4qxhTLNWHdOtcWFKr6Gw85jP8jKqnl2TlFfmfQXu7qPXZ?=
 =?iso-8859-1?Q?PZQxzkt8QxWTnwpz7f/Nbctvrb9egH+yJRNnloOVFS+v5++bsoN4g27zAN?=
 =?iso-8859-1?Q?gjPxTK4Qc0ZsOUu8sGNyI42zs+Xm3d3zwiY/15ewzseqk7T2CWRccW3505?=
 =?iso-8859-1?Q?nbzSBAHeGqQ6gP0Dyq76uj9AMgUZ8C92/LZjYLAUos0+EZf9QO3gYA236y?=
 =?iso-8859-1?Q?k7QeELRgkRCG816sveA/bnWKm8nh4s/884FI1QdeBhSZfPSKHpOmtBgvM6?=
 =?iso-8859-1?Q?LfkJ5ySc/etjMTm9wUhg5SffEbXlM8171/4cWusp9dikPOfC8GRWqgXZ6o?=
 =?iso-8859-1?Q?PZccYoMzbcxiNLMQBMCH3qQO0wXjP7uZwhtV/OKyED2+cVczyCRWCLkFqv?=
 =?iso-8859-1?Q?7OgOXsy3+sWgUDzob1QNDWPtEjzj+eWvtNR/lLd2fiTN7WVdfpefROkxcq?=
 =?iso-8859-1?Q?bHlZ1xuM8fqOsITz1BFfYVKUVSpSINjSaebgA71XYieT+SucCY4rdMlr6v?=
 =?iso-8859-1?Q?h388jIDK4jhsAJjSNokq6jvY2npfz4YsGCYd/YWTlm28EUYQ5SwdGiEW3q?=
 =?iso-8859-1?Q?0Kr65uqccQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6318E42ECF018B288FB0188CFC48ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sDGuQ9qKNjnQPf23Zxp9Dmh+wh5aN28jJ8MtCD7v5VNMJSwdjYHQTEOhbyX75DxhSdTleKrCOlXwsxJcQPicMYNkqG8m9dKnYK5zLn+B5O2qF09VpzjIxtK483icnMIQdbAZkIngBfmu/c52QyQvx2UdR9QV0OJaleV90VY0w6tenJm1r17Tew3g/TK7c+gOJ39pGLrJ5JZaNwfWmw3nHIWQTbKgL8o5ju2sBzO5PyOtRYAa9xlgoWJUDZM9007pyx8uPfOX8dd1W0wS/7KzNoU59K6NudhFVmpCeGpGEAOqPddTREXkDrUp4Rb5i1mEPhO3OlYsDR3RLFCzBwJD7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438e6608-074b-4e10-91aa-08de89e0977d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 20:04:44.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEMebzHG6CU48+eM/ks+3UWL9sBc8szGflI3YSjNCzISv2BJNzu22ewo/HpdLYcZ+gnF3/ZoTLWbzJkriqyOSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
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

--_000_CY5PR11MB6318E42ECF018B288FB0188CFC48ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-03-24
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
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 17 March 2026   | 26.03-rc2      | PMD features freeze            |
| 25 March 2026   | 26.03-rc3      | Builtin apps features freeze   |
| 30 March 2026   | 26.03-rc4      | Documentation ready            |
| 31 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 16 patches pending for merge.
  - 10 patches in review/waiting.

- next-net-intel
  - ~40 patches.
  - 5-6 patches in backlog.

- next-net-mlx
  - some patches merged and ready.
  - 2 other patches in the backlog.

- next-broadcom
  - No update.

- next-net-mvl
  - 10 patches ready for next-net.

- next-eventdev
  - 2 patches ready for merge.

- next-baseband
  - No changes.

- next-virtio
  - No additional patches.

- next-crypto
  - Some fixes applied and merged.

- next-dts
  - Some fixed merged and ready.

- main
  - Fixed merged for unit tests.
  - Readying RC3 for Wednesday 25 March.


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 25.11.1 - In progress.
- 24.11.5 - In progress.
- 23.11.7 - In progress.

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
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.



--_000_CY5PR11MB6318E42ECF018B288FB0188CFC48ACY5PR11MB6318namp_
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
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Release status meeting minutes 2026-03-24</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Agenda:</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Release Dates</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Subtrees</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Roadmaps</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- LTS</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Defects</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Opens</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Participants:</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- ARM</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Debian</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Intel</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Marvell</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Nvidia</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Red Hat</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Stephen Hemminger</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Release Dates</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
-------------</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
The following are the proposed working dates for 26.03:</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;|</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| --------------- | -------------- | ------------------------------ |</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 5 January 2026 &nbsp;| RFC/v1 patches | Proposal deadline &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 9 February 2026 | 26.03-rc1 &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 17 March 2026 &nbsp; | 26.03-rc2 &nbsp; &nbsp; &nbsp;| PMD features freez=
e &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 25 March 2026 &nbsp; | 26.03-rc3 &nbsp; &nbsp; &nbsp;| Builtin apps featu=
res freeze &nbsp; |</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 30 March 2026 &nbsp; | 26.03-rc4 &nbsp; &nbsp; &nbsp;| Documentation read=
y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
| 31 March 2026 &nbsp; | 26.03.0 &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;|</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
See https://core.dpdk.org/roadmap/</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Subtrees</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
--------</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-net</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 16 patches pending for merge.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 10 patches in review/waiting.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-net-intel</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - ~40 patches.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 5-6 patches in backlog.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-net-mlx</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - some patches merged and ready.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 2 other patches in the backlog.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-broadcom</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - No update.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-net-mvl</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 10 patches ready for next-net.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-eventdev</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - 2 patches ready for merge.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-baseband</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - No changes.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-virtio</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - No additional patches.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-crypto</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Some fixes applied and merged.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- next-dts</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Some fixed merged and ready.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- main</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Fixed merged for unit tests.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Readying RC3 for Wednesday 25 March.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Other</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
-----</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - None.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
LTS</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
---</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
LTS versions ongoing/released:</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- 25.11.1 - In progress.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- 24.11.5 - In progress.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- 23.11.7 - In progress.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Older releases:</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Distros</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
Defects</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
-------</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
DPDK Release Status Meetings</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
----------------------------</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
status of the master tree and sub-trees, and for project managers to track<=
/div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
progress or milestone dates.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
send an email to &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; =
for the invite.</div>
<div style=3D"font-family: Consolas, Courier, monospace; font-size: 11pt; c=
olor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_CY5PR11MB6318E42ECF018B288FB0188CFC48ACY5PR11MB6318namp_--
