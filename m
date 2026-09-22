Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06851C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:54:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14D7042DA7;
	Tue, 22 Sep 2026 15:54:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C47E9402B0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790085286; x=1821621286;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=KQnQlkRf2mnKjrX2pSrZ/5SNqY13anpfG9NTrFl9J8g=;
 b=O8gMCri+Ez/3Hn8GU7YGAz7oaoenJq2eEjMUZprlNoOj4hWhTle9IqAV
 Qxk+iykxOPPpgG3Ak29JZcAeu3OffJxBzdTpx0/58YqCYH39PxGx1S5o1
 rmQDmOqI7wKTxNP2vE73pTKdZZWAD51zkMiAvdM6xA5J/eUI5nDxB65te
 cw9YivmDQbrdkTF99PqkHzRyABvc5xCMGRwpJAtXqGdIYBqiNnU4x/bFE
 5gQd466g7Qdn65SPnTEexhG0LwoL3pAz1DtyTQVoc1aiX6rYQNd9yEAaS
 e/Uqgb5DlHhCbZZ71mRki2bP89lRe+VQ3fWp3Q4rOLy+NDnLPO5unYgn0 g==;
X-CSE-ConnectionGUID: IG8FhpJHSCuUfn8+4nsb0w==
X-CSE-MsgGUID: nKo1cmo0SQeSxgFZzh/Aag==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93192601"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208,217";a="93192601"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 06:54:45 -0700
X-CSE-ConnectionGUID: D23oEm5tTSmf+8TA7z8UkA==
X-CSE-MsgGUID: lAZgHUhkQh6rjkN6BWfREQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
 d="scan'208,217";a="277916948"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 06:54:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 06:54:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 06:54:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 06:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddvpwf4uI+I5iOHde2fHFa9Mc85vBBgZrMXnYB3+kMcqZvChztMxR8xqfeoF5W53ObG81oRUesQmrqEhjYhHqS6bT0I3USUbNHimWd+hupxp/ARv1Cm2wcTgucn5C5ZpYnz0Ad5/D3IqppHrg9R9YcV1vmXe+UDVzQmdwa1RxwVC9Fjz3jk2knLKUPA1y72nK/bjE36ofpO4l8MRhF9F8QIs0qy+mbm2b45Z0pnpqibhwsNq9pj0CNTgfpR3UhHk9qbuBn9cTYeMDZlc78ntD3+mBiveJd2MYeIWE5CHAWz2XkNA1MuCxQwPNn4QHu/Kg0c3tuhWXw9hTFd/hHXOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjcXmdEEMr6KINXlJMr23eiq9TbEAQvPvr/YAHIBu74=;
 b=knf6HfchmKa8Q/DfW1dvZ9EAZ/jKf9IcCG2mj6vgmaRLp/PMIIyyOuNMdizFrOS5yPChWGvOBZKxfxIcOJtiTWdKOusA8tb8T96cwaoTGYyx7vRUXr8cW/ilw7sC7vXI7H2NJ8z2imun1uj7D+KIpI5JYnyB0wk6vrou6i4J1QhG06d8Kt+2BO4aj3tFU1S4OrFsKdiSvOhP4hPozMV2ZJj7+9r4cN60lM0BDZBmJGjWr1CzmiibLJZZtPCwLO0QqayCde94SYpvFKPBWtY4PUs7FGSOySUbeo63nNmb/7qTEb9YLcyo9tzWep/6CLy3enlBrP7/SBjqj7vyD44ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB9646.namprd11.prod.outlook.com (2603:10b6:8:38f::18)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 13:54:41 +0000
Received: from DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd]) by DS3PR11MB9646.namprd11.prod.outlook.com
 ([fe80::d32a:8f92:25b:9bcd%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 13:54:41 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-09-22
Thread-Topic: DPDK Release Status Meeting 2026-09-22
Thread-Index: AQHdSpnGI7RgY1gXBUG8RMeXMQouTQ==
Date: Tue, 22 Sep 2026 13:54:41 +0000
Message-ID: <DS3PR11MB9646BA5CDF1DE0C0BB456719FC832@DS3PR11MB9646.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB9646:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 770d4cc8-a083-4370-c439-08df18b10cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|10067099003|18002099003|8096899003;
x-microsoft-antispam-message-info: tjChkBcL6syNL6a4sBdg2ifgdBekUlSynuRNczMMVeOBAEEGMR75rad+OzEGjJEIWS64jmKjyOFCqVMj4RYlP4T0UmnqqGstUM1ExI2LlW1V4iryDgEgx6ErVD47gJOdWMXVa4+F0PDRK26Ve34vrGirC7pG5ZT+zVdTai0W1/p6Kdv3CUDiC7HmgsTkW1LkbreXoAfA8hfhBB1eftXGmEp1mErPTqTbr0GBPDt2q5yBzpKj6nusbYIwfYlEzDozWkuoMpCfzl66M3LvAARL4l0K2zZ4aVPIUeSlJpAvXgAR10whWLx7R7EWRvyo6XXW4HSwm0kut1EKSBci2Jpqp2rKSeP7bSc7CRAa07WKF37z0k9U2tukhF9WLowVlZ2Ibjf5BEeFb9SjWzCRe6KCQe81gDe08bQaegVBhO+DktH6DBcYf7CceAw8dvU/CpwXH8dvEACNSDimZLvUmKuY9ZrQ/DHsQPNl+Jkubx1T0/x5bzAhX/A9zaPEl6xAIcUdksMJBV0dzd1ho+6RZxzCIQ34noOxxHHsZ3WAyxIux8JGLgfkkkD1SbjTgKxSh0vsRDhsBE2sO0zYYEdoJgFYI+JFhVtNKT3nMfjJe6MrDgsbCx3f0zSK5J8XNFPCs9ILNzVIK/tAx0lGt26CwrjW3/IW8J+UJU7XlvCQaUFc6Xg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR11MB9646.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z6f2TsoJW6mG29ajYnpaVqkH0AK2+LRifLOQV9aFw6rPxql0Q8+urukfyg?=
 =?iso-8859-1?Q?yLs9E8rr6jDf4Zz6hSRaitdMSH6kJjpgJZldF48rEImkvmjNNA9jyDgEKt?=
 =?iso-8859-1?Q?0fkrqTq+9Ry3FMnhdZ63eshDaqjkWv7dDxTzq9DOCqrW9Z00HhE/DCJT53?=
 =?iso-8859-1?Q?GctqxDMDN75KvOo+eAVPw5KYEx9ZaypWZdpARjAnU9i8jBV7OMFZjRgPuH?=
 =?iso-8859-1?Q?fv3G0+mzXKV9Dr9aeOIDmODkAccMWmN0TpLB4yjUeC9R9nfNYL1HFeAWw+?=
 =?iso-8859-1?Q?sazQq3loa/QpjlrGeZVu5udt8+MMUx7VpRQcEhoOQnvUkKHabACsSV/S+i?=
 =?iso-8859-1?Q?2gKM+I2PC8NXldwxnhW0WKPHen0rL1WJCJKWFx6/JsVje1BCQkZ6kMFC2L?=
 =?iso-8859-1?Q?uQFbPpKVKCSBDeIhHgmLRXg99mZYQEVsJd7J+RtgIX17l38gMMxcDeNOwj?=
 =?iso-8859-1?Q?dXUVnUrpPgdff7vFlmrT1yDyUXYACxvKmekZO1RQ+HDj6vBIE8PqT29fhS?=
 =?iso-8859-1?Q?T2FgnlafkFI4TpqoTu6tKd6F25b35Scn1TmYcocnoM0tnUZbHv4S8haf75?=
 =?iso-8859-1?Q?GGw3V4ARlfX0gBx0aClOfUuxQsA75IXXJzv0ocDtpXmeF1xByDg1qO/nSU?=
 =?iso-8859-1?Q?2F0FcYWatCNNNGBSjSXJZQ3Y24KM2fa5HvQFC9hauCxXu9pPJcVppKpgM7?=
 =?iso-8859-1?Q?n/3Pdec7AR04pNbthWayJNdJZPC2pCKx8TLOCQtgBhAOF62ewLUupwNbPy?=
 =?iso-8859-1?Q?aqq+52RclWnAwqz/td+3axSIIcZLem8ioval5K1la9ECHV5WhDM6UdKvd0?=
 =?iso-8859-1?Q?gkHmNyt/8TnOzFAjujhD/G9mlkAO5rMWQB6K1ytaurFuHpq9d5wQaNBMMb?=
 =?iso-8859-1?Q?AD6fACFMaEryLjXPIH6sXby3ZXEk1We+NlB3jf+mqBP640fxsQxK9g4v4k?=
 =?iso-8859-1?Q?mAUdztrMnhC42KGf3DEk/npJNLTtonIrhMV2bGmN/stx+upHsSRV/I2639?=
 =?iso-8859-1?Q?6zZZ3mC3NGHhVHPBTMbU7nREM2r1Cl5PbVX5TeGevHhQjWXrEc+hV6DRh8?=
 =?iso-8859-1?Q?/zPks3oAS16CPC3hz3Qv9JOcudqYhbB60wULo+yv/GvefRhuHdGXlozJ7t?=
 =?iso-8859-1?Q?+wNv8PJhnf4nbK6vmeY05A2oRIdAem6BU4bUQNA9wZ9TVYPVLNhN9F8OB1?=
 =?iso-8859-1?Q?m8qEp1CeVOx5iCM7lkO0kxDAI5OKYS3SPxB+/DZ1sMO8tMW1Bo/mIcdx+s?=
 =?iso-8859-1?Q?koAccKw2IuBLS+4kvLq92Cf9BnDzCpe7u2zWAYMrNlxZkc8Zc8owTpmi9l?=
 =?iso-8859-1?Q?0PaNvmSsfT5pAdLorlQZMPBV1zUwx3HWFnI6hLuZDTdZjvKDUEmmi/N53d?=
 =?iso-8859-1?Q?j/Tr/kbJO/jCQ6wg0kBkaviIZMXWZilTa/OolY2kGwj5IGkyhNgPqqvCtr?=
 =?iso-8859-1?Q?Vi8Yc7dcd5QTeQSUx40WS8Qc4BKMHmuvz0GcK1Du+jYzEZIB74uxYYUr1l?=
 =?iso-8859-1?Q?BJjh6TjdfGASA3PSSf6UFOpZdk3iUG6a6yt0bLVMeVhPIjm0aOw/0iaGa9?=
 =?iso-8859-1?Q?75BKKFCIWcf8mhwWzJ9FLZyimUxJ0/nHE/NgUUP8ogXqNiu0/mEkXJxa72?=
 =?iso-8859-1?Q?v54KZ16f8Bvuoj52k7IXKNcD24di8dJ/de/zA9HGxBz1zevld6l4bX2R0K?=
 =?iso-8859-1?Q?6nnzQfy5OeHQZ8+oPuuaXAYVbsEKYTourNkBRVtFMfkfUP8/3sZCp8zJ0R?=
 =?iso-8859-1?Q?PdAn2xizE6GxHmcWUW5glJGOZos76H21ATUmPhqACxqE3/JuoRiNgDFR5E?=
 =?iso-8859-1?Q?hkwaWWYNpw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS3PR11MB9646BA5CDF1DE0C0BB456719FC832DS3PR11MB9646namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PYbZPzI3jlMD+a9N+jUED16JFWpapxQsvV5qxj4uLFZye9ayw1N/zIgn6xsIbGtk8nE+3vLrmkeaYf2ubp+tGeHbLc6dAn7CC8t5WbxQrtDD/QrVy/LgkAMq8aDeJHoOEYCljzvI7yY+T/TXfh9qrUGS2QPVipwnfGhXG8V++t4sZdnz96tWbLh9AN6KSh71tGybP4tbsK3fHHx/tgxL7++55Q/grhMv/2gabdKnbMXLvTdoDv758YgOXDhedEamxbfjHO27ZWiVdo6J9YrEpnk4M0NzuzTVeLHTBYc0Dv4TeRSfBqrlbOym7XjqJ/+451ND8KoaaGywQGX0n6tNfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB9646.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770d4cc8-a083-4370-c439-08df18b10cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 13:54:41.2591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzIdxInTnOot4QOfSYVfhz3ym7VD/KLsiOyR7TgQlCXdu/ZW0gi3IQZyap94UwVrfz5sjqs54F4TvD5w+kcc/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
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

--_000_DS3PR11MB9646BA5CDF1DE0C0BB456719FC832DS3PR11MB9646namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-09-22
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
  - 185 patches pending.
  - 19 due for review.

- next-net-intel
  - 82 applied, ready for main.
  - 23 patches in review/waiting.

- next-net-mlx
  - No update.

- next-broadcom
  - 10-12 patches pending.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-virtio
  - Starting to apply patches.

- next-crypto
  - 26 patches in the backlog.
  - Starting the merge this week.

- next-dts
  - No update.

- main
  - Merging up next-net (and then the next level trees)


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



--_000_DS3PR11MB9646BA5CDF1DE0C0BB456719FC832DS3PR11MB9646namp_
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
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);">
Release status meeting minutes 2026-09-22</div>
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
- Broadcom</div>
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
&nbsp; - 185 patches pending.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 19 due for review.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-net-intel</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 82 applied, ready for main.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 23 patches in review/waiting.</div>
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
&nbsp; - 10-12 patches pending.</div>
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
- next-virtio</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Starting to apply patches.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
- next-crypto</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - 26 patches in the backlog.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; - Starting the merge this week.</div>
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
&nbsp; - Merging up next-net (and then the next level trees)</div>
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS3PR11MB9646BA5CDF1DE0C0BB456719FC832DS3PR11MB9646namp_--
