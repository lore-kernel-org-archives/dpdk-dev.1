Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF409C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:48:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3E0E40691;
	Tue,  8 Sep 2026 15:48:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 81B15402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 15:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788875284; x=1820411284;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=JvSQCKrsqcP4MiFrTQUdEYeEcn+RAevgSYAqqj0XERg=;
 b=GkhzNYybEc5amhMKkykE+RmOXhfeSo+1yB3OlPCI2khEVjqbVbCNXUsG
 03xYN31dR6UyT93JVPgtKQEtUZvw6PVMQ0NBwjUe4IDqD6vofBfOiEoWj
 AhTQy3MLqudAr+uGcH6u1LyPXjvtYhxQMTooshxRGiCKTWiaSer/LYEuL
 p96O7WfgUo6FsEYlPUBxeO+sDI6Be449c5WS7XLvMCnxRm4DgHaphvsvP
 gRhCHj9QheQfcZ1UPbKGI1Iy+WwCtNM00NSpK9CtwL//VxUkW0e8reKMh
 n/SZhh70w3vP60dU04ypTuoW325c2uqjah15hYkpgIOuoRNoEtfpApHF8 Q==;
X-CSE-ConnectionGUID: l2xzaHtcQd63xwuK+5EBzw==
X-CSE-MsgGUID: LGSUbCscRNyZLkjjmqIIsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89480967"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208,217";a="89480967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:48:03 -0700
X-CSE-ConnectionGUID: CLexY/oUQDqMrfa9Qc19Ug==
X-CSE-MsgGUID: riYI/UwXR0GzOZr+Dvt5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
 d="scan'208,217";a="294509507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:48:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:48:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:48:01 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEQKtrB2Dd+9Hnh3r0z/ZJsY9Z2ASOdXr12D26vPr4Do3HT0hCnHmQ/gk12WSvIEWohRfDU4aSl36qTnEtC0brm3g7xLoppOoD6pOQIZe2P7oSWWBR40N0C8FFdWdGDW4rM1lYbN91FSYqU37nq3mwGYyIy1vSY1xhl3ckZ6Yh5C3GA6BD3yIFLFS35rC6J1ympt0Fyo87kryWZ1A/OPujLi2b+iS90XabQDu+r3VDDJuWAMi9CI+65PUu+BPyOKlJUFDtkGj2a1F/fuFTwWM3HbN+X+M6869n4efRwmXyzPktmTD1oM6/Q8nRoQL6faoQkQx8VomWnJ3vGQ9GJQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ4+yqijXrI7wsW0SEjQNoR7RsfVx/KWx+LgucIHarI=;
 b=RM5X8VPXrBwj1WpkISawQnB/zyseJKR+s8+MfrsqLD4lwV8CcUUm0V5zyIlFIvtJdAMeKBV+MP8mN/e1i1BQ2USYfP4wodcoCNUqukJPughZUN+LFhvloKCd163vI1UF5rmxnyoiIEJttn3WlfNYmMXQrtSlnQKMnM8s9KyV8HH7CL9+3j5Uu8SzZiKMm9MmEBzrTt+iK1vuCiIQfMxZ1IpPgnPdyPXfBtGNS8zjuogiTAw3QYukDraqsGuAQnTpRUrJhyTW9xk1tJjN8tmeFHgxX2QtQ5a9Ln0J9V3JGm57Nd417KaE0wikiJqxGWw70/ipYpkFhgLo3+zTf68JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 13:47:22 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0382.007; Tue, 8 Sep 2026
 13:47:22 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-09-08
Thread-Topic: DPDK Release Status Meeting 2026-09-08
Thread-Index: AQHdP5hwvhAeaPMkc0yyRMU90kopYA==
Date: Tue, 8 Sep 2026 13:47:22 +0000
Message-ID: <DS3PR11MB964626C92907BB8C0BFEE172FCB12@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: 3ceb523e-05b1-45c0-643b-08df0dafb544
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|38070700021|56012099006|11063799006|8096899003|10067099003;
x-microsoft-antispam-message-info: 1couJqrui/NFdu7FjsbSIhmhLbDp/YauJ8iIopdjXSfEsVu+DyvmW4gWZBPX1d1eweUFKkDYPPYe0THCMjp6QGBnfb0JUnU6QhHZcgBaaTDAQ3a7ppzK7d3jkg3Sg+QISFBNhzwbDhWxcB9kwYquP58p4bP+SRg90oFn6qro9UiAyQulC7fjQ/x0/kSW7HhpB+bphfMlOFrqKXPNDCEhPNRimzdtkSjhEH7wYSgsFyY3Ez2BP+pLB40msQu1wkIZzIKw6e/Ujwr2l/emB4/AwRyHc0KIub2k6kqxf4TdhX0rdZQ1nD7n/UpbesW8OzU/ApqeR4kENxbAXCmt4sFKI6G4s2dXZg2h6wUO9JynfBPxaDCVMQp+v3Jv48f7Vk3HMGRa49cXGcvNIePjdaVhOAOJxPePqMspwNTs8NCtc9Z7Ahe6GAIcXCijP+Iguw2ebrJLAWuUjwFqhV/tjkNaHMvJlqW2NA1afx/jdbX5IEeqlG2FiplvJ62txDMHtYVZ4dH4lNFOn1VTM9v9egbA/yB6HLo2PSOtxMk5tIt18y2vo+w4tnqjCU6p4NlHOZPlnSywSjRzhJ4CZx0rgBHkRD/GeqlSQ+YZw7fuLEPCGfL6Kv6jVyeqnD0AyUxJW70/Cp+uaLTV2iEJjB6Mx3S56Ow+Siq6hKeb6mGSVU2m3R8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(38070700021)(56012099006)(11063799006)(8096899003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tUMDD2nMltiI6RKzKY0t6Y/SnD23V0C3u1RwfWkCYvyg93kCNYIwi0ovB7?=
 =?iso-8859-1?Q?rJ0DKX5nsnlf26uhdlJgpyEAGpfz6msaSQKef/CcwWE3AaWwD/sYXLQIaC?=
 =?iso-8859-1?Q?clHP8OyXQet+qetXGvci+LrUMIMwUoK9rILm7yHv7qhkzkcztpSAVLCzG0?=
 =?iso-8859-1?Q?8pHoVVEuRI33kPDffMf0Jz8mcLNZ3+aaomk9fhwiLn9OPbWQbzuIiZx15J?=
 =?iso-8859-1?Q?y6xltI4fxt0rYrDvQK3lJ1Uei+7EwSVAlKXaPSRyKOKWAi59yIzRUJgnqr?=
 =?iso-8859-1?Q?Xc/eEv2Yzv7jNR3L0T7q31L8r8jpP7/XAuB7IRJBC7DngpBEoroXRJpTIO?=
 =?iso-8859-1?Q?uxJaSjN6Pn4btUkl+lvMF5ADPHaewolqUUPNbFcGdoP9wPz7rGQX0pPRAN?=
 =?iso-8859-1?Q?EdZIsCV+pXJ/IMw0NdC9HkwVo8VJHdifeeZbtcsYAEJubBwHvzewOyUKXD?=
 =?iso-8859-1?Q?tKvSAudQEDJGash9nFmquoK3tfaRszyKj3qFLuQUp+dy2Qj7PNoaH6ffpW?=
 =?iso-8859-1?Q?ZMt4sN66i53Rig4mi/MnBICSgRsNozPWq9FlpcdDX7arLboJzhCuDD8uVK?=
 =?iso-8859-1?Q?dtqg7Lfor2awJttx+TOExAxztz/PaSAAo0HaDC7pgDH+pEhQv1EDa6X7+P?=
 =?iso-8859-1?Q?RgKDCZ8GGpIyNsiCU+/IJ/NCpK305lppLgJpa0bJ7RqopIorFFrTSTeKob?=
 =?iso-8859-1?Q?j2wKaJvshnK29dGSc0Y2lhsMxmM2KNFuQgCvkkElnGsYE5XRaXI3MFiFlS?=
 =?iso-8859-1?Q?JrQu2vh63JskgVezBYwoWN4KuYWiuawg8n155gl9SSLCQMIXFZflEJcDv1?=
 =?iso-8859-1?Q?WNjuPC80w4TfXIEtp4H9JJpxEySlt7R1fJQb04JuLSfvgyougBT5E7uL5M?=
 =?iso-8859-1?Q?SaRktFebaXpjmIuZg0+2GYj7hJ7BfP54p3utH/gghoazdVs7/pLaZOgGhS?=
 =?iso-8859-1?Q?RkN3BhyTKpmUpjN35+wXthvZY5W2zbBc4t6RlQ5ogkWHBiS/pAWfyvTMxT?=
 =?iso-8859-1?Q?nYKNAuZ5USR3fCqwdzP6tqC6XeF3yN7rjXE+emeCYX1Qawzul6R2IAygsL?=
 =?iso-8859-1?Q?c6K9kIvDuwZLGSWcoZpE8LBW59/p2H1+ovGiX4x/tfn8fuLrm4z0RqRycy?=
 =?iso-8859-1?Q?uHT1Q/KEpCCbARs2nHiyXqGSiPzDV2/e15e5RZa9hxrMRG8TI7w/f3k4hH?=
 =?iso-8859-1?Q?euXt5Y60WwdYAPUB3ONTZysn6fNyaRrXwLcJ3EOKH0gq0BxtH4i4sF8KLj?=
 =?iso-8859-1?Q?FauKTGQ0LWfIaRAsoEaXUDyVA4gn+0s4oFyQu7qLncux0FIj8DdBLWM2xy?=
 =?iso-8859-1?Q?A6VFRTPtQVeKb/EC67jf+QEqgY1YbRplzFu3SF2G+pV+VuCg4tA48vDCCH?=
 =?iso-8859-1?Q?FB+E3eTStyW7wFUt6PBL//eTXQpAFn/slWr+vfoBaqAND5zW+i6ZViZv2n?=
 =?iso-8859-1?Q?yccrBvkdaCMP6zMR8lz/Jll/nyQeUYbKxpQy7XTjPDNP52UiruTa4tgVco?=
 =?iso-8859-1?Q?hR/F8t6my13+E31Cl1kLTMTupBdhVbBj1tl0zLOI1zr2g6JmezPKU9MnsD?=
 =?iso-8859-1?Q?Dd11BJyyYjwNbndaPeD6avXjgCAC6WG/Go7k+6UnI7yGdPGigsYLMHcuxP?=
 =?iso-8859-1?Q?G4FSCM31dvdPzXEoxKxFi7Dk/r5DbmtpAm0lpxPgwCf+kSaPxzZe5jk1Be?=
 =?iso-8859-1?Q?pucAG1wY06qm6DM6T0gdkBIPWHC2s+VRJKxVF41ne40T+XMAb9qqm2X2lp?=
 =?iso-8859-1?Q?gDeVZAETz7tteZWRNQlfj3BCFTMEqFsPdYuULjl5pgFiLXT0EyCpFs1FkS?=
 =?iso-8859-1?Q?nKXhTdLMxg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB964626C92907BB8C0BFEE172FCB12DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DZxOhu6EFrI7FT1JGjI3OS56UYtucWRxC6K14sSgtW46gi3oH1fvKy1dJPs2vz1vn87i5xeU8BQJcIcHFrLblTAc3NQLqYNqI4GL0v4mSzcXxj8R/OdEdhO+YVglvkJFl6I46xoTykPXF7wMwdX4eHNEvjflkTyzx0IUSWI9PsUvOwgvN3+8XbERMLirrFSAeiybxcIuhgwvPK9jejLft9xRX3TSMMpPqS+t0JWfBw9N8DADLTgDLu+C78mmBWuhyP+jLnPEzGHzjbnsw+R3Kupsutna8p64BXSIOSl/DkOxE80eFnBZ1xLKPukET/WmW+7AFHMlMWwQyEGDNcsZCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ceb523e-05b1-45c0-643b-08df0dafb544
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:47:22.1069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+pgLywnNGgu0mFhWqZ/eigcvy3pzw6NIFeue+G3sEpLJjvostJxIhRmkpglT5Vcoh49D80XJ2t1h19pYrxIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
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

--_000_DS3PR11MB964626C92907BB8C0BFEE172FCB12DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-09-08
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
  - 165 patches pending.
  - 57 due for review.

- next-net-intel
  - 50 applied, ready for main.
  - 32 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - 2 merged for main.
  - 50 in backlog.

- next-net-mvl
  - 24 patches to merge.

- next-eventdev
  - 2 patches pending.

- next-baseband
  - No patches pending.

- next-virtio
  - Working on issues.

- next-crypto
  - 26 patches in the backlog.

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




--_000_DS3PR11MB964626C92907BB8C0BFEE172FCB12DS3PR11MB9646namp_
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
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-09-08</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Agenda:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Roadmaps</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Opens</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Participants:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Broadcom</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Marvell</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Red Hat</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Stephen Hemminger</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Release Dates</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The following are the proposed working dates for 26.11:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Milestone &nbsp; &nbsp; =
&nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
|------------------|------------------|---------------------------------|</=
div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 31 August 2026 &nbsp; | RFC/v1 patches &nbsp; | Proposal deadline &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 02 October 2026 &nbsp;| 26.11-rc1 &nbsp; &nbsp; &nbsp; &nbsp;| API freeze=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 23 October 2026 &nbsp;| 26.11-rc2 &nbsp; &nbsp; &nbsp; &nbsp;| PMD featur=
es freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 30 October 2026 &nbsp;| 26.11-rc3 &nbsp; &nbsp; &nbsp; &nbsp;| Builtin ap=
ps features freeze &nbsp; &nbsp;|</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 06 November 2026 | 26.11-rc4 &nbsp; &nbsp; &nbsp; &nbsp;| Documentation r=
eady &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
| 18 November 2026 | 26.11.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Release &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; |</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See https://core.dpdk.org/roadmap/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Subtrees</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>--------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 165 patches pending.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 57 due for review.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 50 applied, ready for main.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 32 patches in review/waiting.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mlx</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-broadcom</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 merged for main.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 50 in backlog.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-mvl</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 24 patches to merge.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-eventdev</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 2 patches pending.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-baseband</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No patches pending.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-virtio</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Working on issues.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 26 patches in the backlog.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-dts</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - No update.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- main</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Merging patches for deprecated symbols/API.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Other</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-----</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - None.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>---</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
LTS versions ongoing/released:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 25.11.3 - Available.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 24.11.7 - Available.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 23.11.8 - In progress.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Older releases:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- 19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Distros</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Debian 13 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 25.04 contains DPDK v24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - RHEL 9 contains DPDK 24.11</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
Defects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>-------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - https://www.dpdk.org/hosted-projects/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
DPDK Release Status Meetings</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<b>----------------------------</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
status of the main tree and sub-trees, and for project managers to track</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
progress or milestone dates.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
send an email to &quot;John McNamara &lt;<u>john.mcnamara@intel.com</u>&gt;=
&quot; for the invite.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: &quo=
t;Courier New&quot;, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB964626C92907BB8C0BFEE172FCB12DS3PR11MB9646namp_--
