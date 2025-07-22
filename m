Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE71C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 13:56:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8386E402DE;
	Tue, 22 Jul 2025 15:56:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A45AE4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 15:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753192592; x=1784728592;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=t7K/TrjoorRlFH9jFlcBiB70eSC0lQB+NugubKum2pc=;
 b=dskvRJaOAz3cm2cyfOh9cjfWmkCefg1dSwFAcHrjs6VHVI8YjMChTVry
 pTNCPrllqgr/hxh9ok4d8dwRjasu4JF5ini4jDgKWmAnRxZHChMPE7vc5
 Oaz/DVR8PrySqbqcLUjSdRga4kB5JbDfewlYsabQ8ENiFbcDt5aCmrWIS
 9OmKDXNoCVTUPHBfd+1es4XCxPt9gkkJKokgx/KC2XoaL2jbiRZNKb9Lr
 eoR6Hyd064fLM0gzRv7XIJqclqzz/c3F7qnj+/4KNLsPrpoBScXTi9QMw
 6xoki+2tfSWRHnmvpIBeVcsjxynRu3FW3aET4ed0ZcJM+/f4nQOFXzWO2 A==;
X-CSE-ConnectionGUID: eT5ewsWvQqaDvWINqACCOA==
X-CSE-MsgGUID: SQ1yNW29ThmBmSFr7ZS/jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73015215"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208,217";a="73015215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 06:56:31 -0700
X-CSE-ConnectionGUID: I7b97tjoRFWrGxMNivx0AA==
X-CSE-MsgGUID: nGMiId56Sg6ohGkLx+WAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
 d="scan'208,217";a="190102440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 06:56:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 06:56:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 06:56:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 06:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdwsyON/SrxOVkfCCqQ+BU3xbRdPpSYD2mZjy5UHOYqwJ9FwV6bOK+9G8poYJAhOoqEItLsun+RCp+sTF+A4QLIqP/vNnmXxLrsAqyDwA3IwePClU/SNk9ExEuE1mRhw4OJ/LCdfrWnCwnhHvBgHiikfewqoPJU2JeTBdBBlt/Yz/QtPap4Ovtk8w5GWH/OOXPwcjKy6xqThi5mzQh8fd9Q8jr3Ij2pM3GCYoFQeAENGejLMh/EUzty4kyGoM1JPY1o3vNIH1ULkzIuF9Yhlm+vPCt/foQuHf2frO6LVwRDcAKBLTkQo6DU3AtSPDJyPOj5jApvhiqfQWavXEfhPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wFJFeUZeJ6674DjoE15yPYTVb+BujKAzTgCH8dl06E=;
 b=ioFFcxsf0KA6ZTEsFwqtefZXoHmqriJDDol2leZzFveZtVedDaXQGEJF+mf1xyfHdcmRWUkcgwPUVMDiAJ7HfSonTCKIzbvAeueFfZrPhqF6kjXPw0PbIB/wSYJrJS6Dkk6slTB5P/REFW5E1yunqgJxt9Qk/+dVWeT/twZgYvzL9j51oIPFggsFbVrIRBszz1o37joD1Ry2hjmK/zfjnzQgYHm+ZQkNpmsEXgXcZ67jkw0fp/MteqhNEQIMFWDrRoylXFWRUlA/GnysEU3kZywBrymstol0ZNYQvR6OETNBtyj0skknmgJXEc7fP4aDCEibU8We1oeptmywYJRERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by DS4PPFCCD6F4BBE.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::4e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 13:55:57 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2f1f:61ff:3b5c:b309]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2f1f:61ff:3b5c:b309%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 13:55:57 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-07-22
Thread-Topic: DPDK Release Status Meeting 2025-07-22
Thread-Index: Adv7EBcUglZ1TFZaRGCwda2BTrfVGQ==
Date: Tue, 22 Jul 2025 13:55:57 +0000
Message-ID: <PH3PPF37F43E35D2CE0D82518489368A46EFC5CA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|DS4PPFCCD6F4BBE:EE_
x-ms-office365-filtering-correlation-id: 84e48efd-ca75-4503-4eef-08ddc9277c05
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dCWif+ULzhfR88zhqZOQaQ6J/ViB3FSEnYctBlDjlMCVoQoEIp4bF/cVZM1i?=
 =?us-ascii?Q?YOj8GF2HGD3P7NNRTNrnmncqyEcpZOfgWKpBGaCOXPlIwikQShgANYxlaUpG?=
 =?us-ascii?Q?hwHHTcOi1jWZLKPFwNi3a6IsyEusZgdptA1SxXnWN7NAn4zh7fYmHv+XAJO1?=
 =?us-ascii?Q?yYSN+aHl3XzEi65TpCktFz8h31lVAHLP2IJpONDYTCRAI0Dt5ArHPQmIcQgu?=
 =?us-ascii?Q?yf/lL00PIX4Uvcu/Ov+JltSV8hVrGo414lVUc51/C5rsfb4IELjb2Rc8E/ly?=
 =?us-ascii?Q?n+4yqCva9i4IOQsO1ft4mIY5110m5nYIdojP8GPRWIHWQg2gcGbONBM0tmdh?=
 =?us-ascii?Q?Ruelv9hFPYuG1f0PGEcJ72IjMQRAWncqVcE79Vb9+0EpTMlzdVAHLC6BlxC3?=
 =?us-ascii?Q?9cg9td6OuNySyEi7/FydjtoP3l7X2DMXiQQDC4HyjEuT7ablLDa4X2ja9CGu?=
 =?us-ascii?Q?7n2/Rvo5jrYtKR+E9HKC+juPh3L8FAi8XgreFilAaanUdYPoBlIsk5llKyWt?=
 =?us-ascii?Q?o7zIs+Hw968/jFWIdGGNwksDXOj4ZmllgrKbHi3NH2ZFF30hPY03RengLxbk?=
 =?us-ascii?Q?rKwD6ivIfpqdDdQ96peo1sGKF1CBHU0HsAvbY/3ySuxet1kXAwdXJ7SrJBie?=
 =?us-ascii?Q?GFJyyrfE4mze5D3Awj6KkKbduB5YZ98qNkSXmP2OgAQZjqllgyGJEf3TTeDQ?=
 =?us-ascii?Q?pIXTRy7SACUjDI92Br/2NfTRMk98HorfFV8eLyvKyp5T7ig1rl9Akipl2YCL?=
 =?us-ascii?Q?1dTUoI266isiWDVvjUXZyxDCS96cV43N5E+qfVjxNZcGEfIuOs/3KXHwq92f?=
 =?us-ascii?Q?7XL5RmO3S05+CgWkujFYcZcJwSKityx0hCiGchZDKADHLOPG8lN3tTDAUwjw?=
 =?us-ascii?Q?4Hfi9BjNxsrrXt/gB8D3Ww9tJdej42bbYO6p7KUQmupACXvTPrZP8Hg622OX?=
 =?us-ascii?Q?+aJX39A0lPnexA1y2U3P/ikM1UKcLvQQiAq/RZBGbS2uJG3Ck3mzuOamOlEq?=
 =?us-ascii?Q?RvA1glQuNBBn6QLFL/HMNK0GrxwEQ3muDUC7J2ZxBYII4qHPkv8abc94slHw?=
 =?us-ascii?Q?szD8Yeb7ICagfcFlRRgakFtcS0mVbdnUHKWUb6OMwhbAI9S1wWcBaNHLhPOe?=
 =?us-ascii?Q?pRqrw3LNe/82LIPL1mJ3kjcZqpsrEXKbqyAqNJ8aRCGdGe9Aq6i6Dq4i2hIE?=
 =?us-ascii?Q?Ai/+UvtDRuHqifOzgyj5kf5SQ6zpVKPUhDVWsLftQRSijIZdsLPdeQOemwiB?=
 =?us-ascii?Q?8+zzVMjJ/ggwapH9mCDK50Mkc7RfO378U6eX5KT6wFinu8bCPWLvBv5m1y0p?=
 =?us-ascii?Q?hmGhXhLJIvZ+LBVgh6rgi8fzqgRJP9vNCHOwR54ExFOY59v6HSwr8xw5Zn8A?=
 =?us-ascii?Q?VJ9/Cw2plrAf9RcsV7II+RD9I0XhjSA6kbSqncjq3SQRZRPPNRiTDgrIfcxK?=
 =?us-ascii?Q?GSEft7Znx2s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?drpuDTeVvcDZ5HL96umP0QzULQyjQzo7NLCPZXIxPtexotT2X+B4zMztXNIZ?=
 =?us-ascii?Q?bNmvZBHc8ZHopInL/L+1Z5E6IOt2aQWS5lzeA+hEFHJmvB1ALHUQFKlmUJ4H?=
 =?us-ascii?Q?CgF0u3SZIige0vIU2lU+5o8xy+nkPYfsAcP2iVkGNDPRhNEtffxNLfJw9MqE?=
 =?us-ascii?Q?tZjnpaDizCWAX3Vrh6/U4lBRsGuNviTMdGpg+1Jbk0Q/Hmt9OFz2sFtaecs/?=
 =?us-ascii?Q?MYWVxQw08MX7SEtV7zMpqGTYKNOmIjB4aEq+9MVc4R9zgyZq24iIAjFgMifI?=
 =?us-ascii?Q?C02C7+ve1h7517xaNdwNYtyNIOl8HGoy/xDG/BqB/S4uUZ0j0Lue4PcIEi3k?=
 =?us-ascii?Q?08aadYmDNbsolIkKXWWWaRw+Fdq8VUJDM+GIPOwPb50UpWZ1QgfO36UDVA8A?=
 =?us-ascii?Q?waqJvSlFOxvkRNps41ztp9LYY0k/eMqEIB4p5L3N82BpuzBzNZfdQts2W/84?=
 =?us-ascii?Q?lJIBrE2JZjlI54cDu/sokexgE7rqE4mdcYkutT57nx1t6b48HcDuO+4Ryp/B?=
 =?us-ascii?Q?rcnZlWBBBFW5WvBPAbaFMNDzKVBJLupJKLA9CiavVg2dCbUks0A722BslN1P?=
 =?us-ascii?Q?CWBEcvc84s0pm4w0PKzz82IxpYJ3HMek/C3VhvzSg94NPBLtKXZOH9Y/5UjP?=
 =?us-ascii?Q?xkgNJpli09GLcQDJMS1QZI+So4LF81E+iIoH3zCqNM0q4Z1GF6Gw8aGeoGwP?=
 =?us-ascii?Q?rQv/YnS/XpytViRT5/c1EARvvUGzjRvRb5TG/1y5RMzK+V2b47M+eMJ3PYyR?=
 =?us-ascii?Q?HNA3lCu9kXHTEnQaymuygVlX4A84Ev/ZilPjuNP+BxO+zLrV1e7QmzZWrj/u?=
 =?us-ascii?Q?l7eaxXbCJ+7NaVjRHUV8SdKgInKoveBr3XMjd4B8+1TuzQykuCMVauvEd9UR?=
 =?us-ascii?Q?gnziIJeHGT1FpXtXdMVUOr3pY8YBv3doFyL8JbJHVlgb7IJyp/X8iYUy65Jp?=
 =?us-ascii?Q?6bIn4IOKCoUiMwS9kovsb7ybOwjWvqS/b7SVAgP7kuFvnAwJQR4a0ibteDNR?=
 =?us-ascii?Q?w6zMlsL95LHKCQsHDNgslDRxmH9WsjrNhuJzFIK5OACRF7ct2CAH7vmuAcOl?=
 =?us-ascii?Q?LQSoozGKuDjNulbVfWWO8x+6EnpOIyMshQGOI07w789KcjXka7pZE9qt5HCv?=
 =?us-ascii?Q?BbuRp0ctSYw58DAz/d+aNUDGqfFeGzLLDKyI3QOCWOLoAa3Ggw8uH3pC48NK?=
 =?us-ascii?Q?jLJWsC4gTSMd5eIOGz9kczQKulsSsPtGLBJLMt84nbJTon3GfUowALcazvQi?=
 =?us-ascii?Q?WSVFJ2nImRKq943TH3SH+VRSJFEfgNXGdgfu3vfYAbcOeMnGvvnG1PWLlRk1?=
 =?us-ascii?Q?DBVSadznWNrEzbO2OgsZBB5v2bvt/7i5Oumq6SGaLNN4d4dL/xYRDhZ9N8aQ?=
 =?us-ascii?Q?TghR2i65QswlGYmZ3dBr4cq7LPRfgR9r55RrJiKdcjtsnpx8cHL+kPBk7RDh?=
 =?us-ascii?Q?0+kE/a9398JOEKz5JQ1XLufar1sJ3tXUJdJ8TXg52s8DmOFcPOE1lcAI67JE?=
 =?us-ascii?Q?esksyIBw4YCF6Bk0LrrZUWxGvsQFw52h9d6EzeXnywCNfcF0UyXpPmVld9FP?=
 =?us-ascii?Q?GX5kAge/Z4pj1SG5OGJGvAv9LErHWSPuIISOF92y?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D2CE0D82518489368A46EFC5CAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e48efd-ca75-4503-4eef-08ddc9277c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 13:55:57.7955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crck4EG4iKEKGAtaY6tHK0Rmt6ecZRRKCUtUhBvOfEpGzlTPWGj/oqxBDCf7+QIsWCFtN6b6duFG9YyW4m1ARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCCD6F4BBE
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

--_000_PH3PPF37F43E35D2CE0D82518489368A46EFC5CAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-07-22
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* ARM
* Debian
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 6 October 2025
- PMD features freeze (-rc2): 27 October 2025
- Builtin applications features freeze (-rc3): 3 November 2025
- Release: 19 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Starting to stage for next release.

* next-net-intel
  * No updates this week.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * No updates this week.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * No updates this week.

* next-virtio
  * No updates this week.

* next-crypto
  * No updates this week.

* next-dts
  * Luca Vizzarro will take over as maintainer.

* main
  * 25.07 released 2025-07-22
  * Proposed roadmap timelines for 25.11:
    https://core.dpdk.org/roadmap/
  * DPDK US summit has been cancelled.


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - RC1 later this week.
* 23.11.5 - In progress.
* 22.11.9 - RC1 later this week.


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



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


--_000_PH3PPF37F43E35D2CE0D82518489368A46EFC5CAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-07-22<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM <o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 27 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 3 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 19 N=
ovember 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Starti=
ng to stage for next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Luca V=
izzarro will take over as maintainer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 25.07 =
released 2025-07-22<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Propos=
ed roadmap timelines for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://core.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * DPDK U=
S summit has been cancelled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.3 - RC1=
 later this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.5 - In =
progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.9 - RC1=
 later this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D2CE0D82518489368A46EFC5CAPH3PPF37F43E35D_--
