Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF4C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 14:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E7A84029A;
	Tue,  4 Mar 2025 15:56:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4021640287
 for <dev@dpdk.org>; Tue,  4 Mar 2025 15:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741100159; x=1772636159;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=zNnf1inW3NJUX/kJk35mp775ntcsvgLiRW59Y9L98jQ=;
 b=QIIVSKo2pM/gshysmw0Nj1FwrT0ms/lKW1sy5KSr0aW8Ax+mNqIK/48L
 waPbqY6SvwPtAgtEAqaejWZhHVfwbWHTlD0WPAn0DRjKGChpizwL7dZ+/
 qF/BqoWdnXXtGiDHoUmiVF5VMeQyAnMFQiNRtJsmyqKDSiIq4sazQyHPn
 gppEd6ohEJQo+e5G/bsl/XsznfLQAcLy66iDx34LXUcOOipk643p0ATQ7
 h5zCg16jD+y7s3mMtcQZVNXmw7bl46/PUDpDhKhT4HiavnHixmMcwcEkx
 Pb1xvNAJMaJe85kT+OSGq6fcR0ma6L3NYPl9gf7Tu9MGEmr+ekUivk+Ko w==;
X-CSE-ConnectionGUID: ZVTnFqEATP66NxD6Wgk1Xw==
X-CSE-MsgGUID: hm5t07k0QTiJVT3/NRneRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45947086"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; d="scan'208,217";a="45947086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 06:55:57 -0800
X-CSE-ConnectionGUID: eMnC3VZhQBu3E1FJH0Vu4g==
X-CSE-MsgGUID: TYPG4kzMTKi+JOP3p7CZWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
 d="scan'208,217";a="123399049"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2025 06:55:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 06:55:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 06:55:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 06:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqnikl8xvXDUgBzHIFQwYixkD83/eu9kCdsvPs+t+RTRzWcu42RS4VibkCMqVA1uuL58DnOeKCIHaFAnqANVXRmexa++QFhGjK4o629ZFgFepUUTlnDrZ3/gVDQk7PbWa/NBL2EecrPzMWUOOIbavi809Zmf+AXCwZMaHnfSuQ6pbY7YYPY1vzo84ORDpu2eohCr0Hg1G2yj2RC46KpLHoukbQCYXoqxsukeVIJ2jZG2AU0RSJq+z/4AHPv9pzGGWuqz1fRJkg/l4vuswU2EBxXFg0pERutcvuqIp78YPraBZcxqnY0ZGA+XBIaI6gPC4TEA6sBeaorr6VnDntA1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4ukdCTVvUtZex4hz0Z9cynbGghiNc6tfY9iYRlJOec=;
 b=qMFBZ/wX9FCKgySX1lC7KsJnziKTsJ/qWOWeu3umledd3RrQ0eRG0clhIfNvcPVY5+Dbo0f91Dhyizn12UDy4JEjnoUsEPSaf5JVSF0ii/yz2YaOp9O04mmngjPQIe/5GYMURQd8CgwIKnlgyfBi/dvq2moNIi8SGl08dmqJueKHCtJqibyOfDbLIEOfJ20j6739A8nxGevJyxM143D4OpZdNCeu7l+Ko2M1Fokht3ye+VIvKGxgCY+SJQZTWMYuxsG3qJEsRZbF7s5R/tXRy+1pU095uMj2ndmJPDI8phUd9Opt0gWqquPaMEc8V3r6MolOPTJ9848869UqVZ1DEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:55:52 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:55:52 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-03-04
Thread-Topic: DPDK Release Status Meeting 2025-03-04
Thread-Index: AduNFVCKaHrA/G1UR1GtAP39yr5hQw==
Date: Tue, 4 Mar 2025 14:55:52 +0000
Message-ID: <PH8PR11MB6804CD2D534098701635FD0BFCC82@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|SJ0PR11MB5150:EE_
x-ms-office365-filtering-correlation-id: 3a38c9aa-298e-4190-5ef9-08dd5b2ca8dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wL5SoM08qM3QxfAGFaVpy3xq25H+rtO45YBotfw88jBtRWwPGaxYZ45o+Cw3?=
 =?us-ascii?Q?VcrmwHc/PbvPE4zQk7SN6BC/C976Hn4JASreQ0xDl/0+v+afDuFPL0GPuk+A?=
 =?us-ascii?Q?aTJft6tgE317BWH4ihe0vfKhiy42sojNaHNXeroWt3mc42xe1Bg2OcGTvFzy?=
 =?us-ascii?Q?v7gkPtrYb6dqavRpKUB3cykHTQdy48O2T4ewrmNkCeBGiWSF21KaroUNpJvl?=
 =?us-ascii?Q?pnh3WQsKMtqwxpdSM/gCnBZcneS0vhnbMTi2KregCRGQ9ACxo4oiCC6Zf9iH?=
 =?us-ascii?Q?kNnEGc0B5YIdHdgtsmkRcv7DTDa1leNZgVcFNJg3Ok9xQji1u3JhfRsDaAjs?=
 =?us-ascii?Q?ujqb0C1PHRmH8ORoy+te8hGr/LHlirdo1CfUncqHBuqxUNj2u7Z2BvA/xr3a?=
 =?us-ascii?Q?QE4AqlNC2nUt/dWrCsFk7FNFtAn8lf4lInucBcnc8Jmzn5N5YVILyBhGNyL6?=
 =?us-ascii?Q?WwvUU5WkMfWpB8ePmNfrqnAQQrIFnqKITMVXhrWa1Q+HrY5bvaBYEEl3VHEZ?=
 =?us-ascii?Q?oBCeulmboodJEP8wOTS3qcNB9EUMntRMubNFjWdeLlIQs0AF+zVX1zxC3zb8?=
 =?us-ascii?Q?ChEB+vBaXs6fY+I/M2e8njinhahiy5AjWPBgkMuOy+hoD8RwY8DzKRHTbIrx?=
 =?us-ascii?Q?AYy/m4yKbeI9SSF2cUCta13b1EpokTUiKu1TUi2dbt4lnGqPqh4Xkkj3PHeB?=
 =?us-ascii?Q?DxOxCeixbjbOgEc2rRgFa41CyfNJuwaMdTaZvH9nQhCDLcngDzjJDo6n8bBX?=
 =?us-ascii?Q?QVRufvyDkaXE1FNMXm7GPNF2cYCyNckR4WfJB89scEZ+4+YIJujuFjvterqE?=
 =?us-ascii?Q?uaVWNRqYzqKYM81HOfFvwHaZoUgfHDBzHsmxujMwykVGkc4hv9ChIqzU7yu3?=
 =?us-ascii?Q?DhHVwEd/GE9PgjRfJ0FtJs/IL0NalGVGXZtmSpLoMaWAW0G6fYiFtGFflOvb?=
 =?us-ascii?Q?s/jHpOQi9zUpsrTAemMtJS3RP+JefOejZN9aE4ZhkMeTt0nyUeEVbeOQVqn9?=
 =?us-ascii?Q?IAg9rNBY0rMf38sEPyHFioKqEYr6KEtlUj9DSZtOUAqnJOteojIC1VEtgZWS?=
 =?us-ascii?Q?KgdrSESjjGd+R9Oy7wTwlhOaqxvJEH+oRyFUh047RSKgF3QKIAv8NbyY28hJ?=
 =?us-ascii?Q?AfFmvZGrvlbx6K+ufnABfljFPtqdZOudPeQu/Ix4TR9T9JLqHv19h7TK8qM/?=
 =?us-ascii?Q?eCZMIfpD1pW8ioGyYlymjR7IXTWKpS3heAvfYV9YqNmBumGDOSfsUf42T1TF?=
 =?us-ascii?Q?HwPar4vbU4B0W7y5JDipP/mrxjT2z/C1NZVeUuWQuO2jbNn3VYhWUDbSEiMI?=
 =?us-ascii?Q?7tnU4fs8VnMQDh5kvDPqw3yA5xYGN4c5V9SEfu5qGUy/DFIn348hzzdG8XOY?=
 =?us-ascii?Q?Q2uNyiv9Dlvz8zwwGzjbsnkggG1W32vroUuVteZM91EJ2cm5sg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D4r7hrhuxUlWggUSEr1uYIxC+fgD2AJN5B3MmespnPgue+30U+lEwdPcelow?=
 =?us-ascii?Q?ECV84EfGH9oTupieg8+9E1OMj8QUZYA0udGjTC4mhLGwSXswIErIPumQcaIv?=
 =?us-ascii?Q?SyslNTE2GR8QrdhDtLlO3eL7KxQEjdBBYhCoaNHroezIaWL/aasgdZfckJk9?=
 =?us-ascii?Q?QGCqXNlLwzo/eKvGmIxT/QyeWPaRXTlDXN7WtL9Vx1JbM1eTk2qbHcqIYnfm?=
 =?us-ascii?Q?Alxddhte7ExL9qIdcZ3UKzXGTfU+PJKWVWb2ewBFQ6P8kZIQ8vUwcJsbU0En?=
 =?us-ascii?Q?YYCbWnCCr5vOSsg2cK6RRWnXWOFTE2GuO0DYb66Uy9M3F+D88i1LbVSwvqOG?=
 =?us-ascii?Q?NQYG7VOODPlTybgUOTo/3lcwcD/xEK0VSgPphxkRJPr0BRNIyyCr2b2fiKCf?=
 =?us-ascii?Q?GQWcCkiK9EEKEgEk2DRRC55363vrO6rTwy1xHw5k/eMKLZwnBon4ANvOcWdS?=
 =?us-ascii?Q?FyBJRmL9wSwzqFGpGoQ0529R83l9sng2Y3ojpIFQ/1j1pgUyputZoTxIiZe/?=
 =?us-ascii?Q?83HwfgPVgq51ZQPaw4KjanBkupSN5vMLbtj4Pj51BzRA16F8Eq4sNmWaR1Z3?=
 =?us-ascii?Q?4vHnUOLNLKH4d0Ok10Fb82LS4zg6RgVNdXT8xoIyBvCNZViPvoGQdYnnFClR?=
 =?us-ascii?Q?DCS+CkmwhC/vKTvsfmDPxaN/fmOXd2FXYDzNpimTKchzm5ikdileSFdQ9QiC?=
 =?us-ascii?Q?3427iWR37+Hfnjsn+LOHqdyWxSIAfIMLKgucQu30aFoGPPYzg+CgVKu27you?=
 =?us-ascii?Q?Qf5GW5J4NtEJWGnbJHB0S8j7S5j3YM/UKfePESOCiJTi9aD4j4BhAdsimuC9?=
 =?us-ascii?Q?xcdI/TSs25suyhXA8JtpobZno3SMrXcdZyE9nPhbadEgUxb/RSiQZqjMs0jf?=
 =?us-ascii?Q?niYFgs4s0zQIefVo+7yi+BEkcsAyjfypqSJcngjavI1WDbaR89F0/eklquTj?=
 =?us-ascii?Q?6VQPSZDRznQo12u085qGbwfS//omztWffKtgkEkwLiTqAzcNzjzqPFkrzLki?=
 =?us-ascii?Q?ha61jiNrKwx2oFYe9E1mWh0ojd1G19SCRuvRxZ9O0JhZk5mUT/PRFVv/A5xM?=
 =?us-ascii?Q?sufo3/6necIgVfDZ0n2PIUo8vrw10c428c5PYURYSU8g1FZnPEMDq9PEzQlx?=
 =?us-ascii?Q?fBbl4lGKUCX0gJ4w66xhRBkzPWTq2/Rghkm7+goZDaTh46qm+5Rlrucv+fgZ?=
 =?us-ascii?Q?OwWBbyiZLcemksEmQqq/lbIEtPPYizICVO/TctzTY39CamrJ4DaTh4cK3vmz?=
 =?us-ascii?Q?IDOWLuEQo0er9kf0YmT1MiI/o0Dezg+dXbi1bQZxXH0sxRbXAOQAv/QPn6BM?=
 =?us-ascii?Q?nYI5xszI/R8bXTTs08ewEOJy2G26Nh5qdl8opRK7NYU1xPVB1PLn2eeBPzXN?=
 =?us-ascii?Q?TnSinUlJ3LT3ilJux6FcNlwn0U83AaO430Fvtwh40t2jvI804L5u4AlSzou6?=
 =?us-ascii?Q?Ala+6C3wAma6viZKHYokgGm4NkxU5KTCBRrFmizc9Xea2+sBXsFuRjs5DCYa?=
 =?us-ascii?Q?JCEGCaj1i962fQZCp7UY01BLIcYV5FjlPNDJoIdjKhkUoMyh2VSkRTmV8SlA?=
 =?us-ascii?Q?aYlKXMow22rYeDvxnjKhHQupm027f8kx/dNtP++V?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB6804CD2D534098701635FD0BFCC82PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a38c9aa-298e-4190-5ef9-08dd5b2ca8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 14:55:52.6107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhMSyjmOjIB2xRkQ/ELcTsNONDg0+6RK3Aq3vXWJyj+Tzcos2ib7ain0q0UiTT+skXDTFJ42hImpnkyVM/LLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
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

--_000_PH8PR11MB6804CD2D534098701635FD0BFCC82PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-03-04
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
* Broadcom
* ARM
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.03:

- Proposal deadline (RFC/v1 patches): 4 January 2025
- API freeze (-rc1): 7 February 2025
- PMD features freeze (-rc2): 28 February 2025 - Probably 5 March
- Builtin applications features freeze (-rc3): 7 March 2025
- Release: 26 March 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Merging for RC2 in progress.

* next-net-intel
  * Some patches for RC2.

* next-net-broadcom
  * Some fixes outstanding.

* next-net-mlx
  * Patches ready for RC2.

* next-net-mvl
  * PR sent.

* next-eventdev
  * PR sent.
  * Expecting one more application patch for Ericsson.

* next-baseband
  * 2 series in progress.
  * Will submit PR today.

* next-virtio
  * PR ready for RC2.

* next-crypto
  * All merged expect one series that has a dependency on virtio
    (waiting for that PR to land).

* next-dts
  * 2 series tested and ready but awaiting UNH check/test.

* main
  * RC2 in progress. Trending to March 5th.



Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/

    The CFP period has been extended to Sunday, 9 March.
      https://events.linuxfoundation.org/dpdk-summit/program/cfp/


LTS
---

Backporting in progress. Current LTS versions:

* 24.11.2
* 23.11.3
* 22.11.7

See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 24.04 contains DPDK v23.11
  * Ubuntu 23.04 contains DPDK v22.11
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


--_000_PH8PR11MB6804CD2D534098701635FD0BFCC82PH8PR11MB6804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
meeting minutes 2025-03-04<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
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
re the proposed working dates for 25.03:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 4 January 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 7 February 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 28 February 2025 &#8211; Probably 5 March<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 7 March 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 M=
arch 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mergin=
g for RC2 in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes outstanding.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Patche=
s ready for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Expect=
ing one more application patch for Ericsson.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 seri=
es in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Will s=
ubmit PR today.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR rea=
dy for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * All me=
rged expect one series that has a dependency on virtio<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; (waiting for that PR to land).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 2 seri=
es tested and ready but awaiting UNH check/test.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC2 in=
 progress. Trending to March 5th.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; <o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - DPDK S=
ummit 2025 will be in Prague in May:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://events.linuxfoundation.org/dpdk-summit/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; - https://www.dpdk.org/event/dpdk-summit-2025-prague/<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; The CFP period has been extended to Sunday, 9 March.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; https://events.linuxfoundation.org/dpdk-summit/program/cfp/=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Backporting in =
progress. Current LTS versions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.3<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.7<o:p><=
/o:p></span></p>
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
 24.04 contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 23.04 contains DPDK v22.11<o:p></o:p></span></p>
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

--_000_PH8PR11MB6804CD2D534098701635FD0BFCC82PH8PR11MB6804namp_--
