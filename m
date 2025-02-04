Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57003C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BEB640E0C;
	Tue,  4 Feb 2025 16:00:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DD47640265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:00:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681208; x=1770217208;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=hOcgv5cCBARsfmrJpzFwmuBiUTgK1CE/seUeXTnX7DA=;
 b=LNoJMU2y66isdHp1mHVqS3Vo5iysx3lzjITfFk9sPFq9/sDRVcNST5Hu
 kgz7kr0VgFnaMC+MeBdv1AkjYbhvXNf6t/ma91959RQLDtZWzZ+reLByI
 lHUAzz2xThJb83s0ZF1GZMFK1RxVtAUQpvoAfADfKveoTvvcObGhfgBbA
 SU+mc/6vSRqWiTqasLJSIHKMytCGoC0z9GDW+1Bb+lg95xLbIaahSn3pc
 yoH/cf6d/xsepaBJJzKBNgIMO+H1P36ZoByP9/X8lsiazBFPNCD/4FLOv
 trv9oAXpnyGZ6Qa2K2wEAjzxrves3MFiF0dtafcftYqbfHmhALVyumtKf w==;
X-CSE-ConnectionGUID: EDtzq7MDQC233TiL5u7g2w==
X-CSE-MsgGUID: d44X2EcZQtmjcAYEnONhkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39315978"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208,217";a="39315978"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:00:07 -0800
X-CSE-ConnectionGUID: 3taEAO+9SwOOInbu4e7IeA==
X-CSE-MsgGUID: 7zc8jxOHRba1ECzpETEQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
 d="scan'208,217";a="141485574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Feb 2025 07:00:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 07:00:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 07:00:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 07:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlFijC85+xKKj+0cq+FmQb/1/OPhuFN+n0SIry3V2eoGtajINJeAtiZj614c56Zp+/39ARJxwjRbaqfy5RUvtLIoUjXU/kzQGDFxECPw3qxgMOTXpeHwDcz8Om2EnlQn7H7QWQZH7Hs1tj5TVsH7Rf0gmerBRlpWSX4+7WRkYDPAMaVL1zNs37PdL2LTEQWGXzVU8GyHlM8FJEmi5GUgaGowJGH9PCli8Shb2U4EKnZ8JaH/geLMwPG9MUWEfPn3lMMI2b7t9bIqIojsyMpQrLrxDQZf5xRq47goTUp8mMkMWSwX9AjvynBullyqMbqsl5SmZDDM/sB2M2bnZbKlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlInCh3uPOi1Svn7zOCrvY6dko/9g56Mkt8amt0A8ys=;
 b=efJBmbnzM3Wz/bnobtodp/hJOblupEmgZtwldyo07PD2pkM41c8ssnYyHpPgxWp3c/ixQEBMFUNFuvaukmNVuDPj4mw1RTnATRg693uSWZ/SfN8EM2ZN2RqChVby/zd83Q5Ss1Z0ZUtzML1EgIJhsso9u31Je6aBKtQOXaMUh7L3o6/I0zCbogLqCQdobl19ymGBiYQ6Vy6tyYVyBjD+eD5NbfUpGbffJdvrkkT4TaKgq5qmwyR73j5IaqYhWFBGL8i2M71eWN46U7Mhg26wGX2n2uQDcumn85fimvPDxjJpBVmn+6024GdgJewLV8AeC+joRxO0KlWv4YgiAsmyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 15:00:03 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:00:03 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-02-04
Thread-Topic: DPDK Release Status Meeting 2025-02-04
Thread-Index: Adt3FWuK6wPsGZ0ARLG3mF0XzjQsUA==
Date: Tue, 4 Feb 2025 15:00:03 +0000
Message-ID: <PH8PR11MB6804A2BDBF7FB341830BAB47FCF42@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH8PR11MB6803:EE_
x-ms-office365-filtering-correlation-id: 910f009e-db1d-49da-6564-08dd452c9ab7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t6zJIzG29bs0g7c/8iRvpM55hsbOc9V6TpgwINu2Ejha9WlYTCmkDSZcaUmA?=
 =?us-ascii?Q?0MQ1ImFy0Qp68sPkJyzDttDngvKGkhQ66OKVafyWqnjBpHm0h2W5iZRNi0LD?=
 =?us-ascii?Q?6t6Lx7eIRWiT7wdt5MW4sLcgEv4VwyZlIAvklesqS8WD1r+O2ogpY+dpwE53?=
 =?us-ascii?Q?iRId4Cg9wuygbK5TBmKii1i5ltzCuBM4/t7F7B4sx7eV90tpTAYkGwPoWcpf?=
 =?us-ascii?Q?SfftX8CGDjRNl7OOnMe9rgrGS8Ko1H3dCBp2knBki1Az6w4LinfJaRks9MtQ?=
 =?us-ascii?Q?czMvHIjXESC843O7oR9tkgaTijrLuy0BJGWh3k5skTR+qwGkXQYj0DddIjpe?=
 =?us-ascii?Q?UWrMe9oM5KhIikQVSBQfKJOf1G6YJJeh1/Wi2FrzZagK51Zy8l486wa+oYI6?=
 =?us-ascii?Q?FQvjed4q0rrXJXdogs7qYQ3soiumOkLfN1DL8Uscfj0gRkCnR4U62EgtKawo?=
 =?us-ascii?Q?XlR39efE5RzTFfWCw7bVnjCjHH/DfQEPGygU7giCqxwMKQdWxK3cNT5nXZkZ?=
 =?us-ascii?Q?WVhzKuLged5GlnpchSpA756FZbisuIebIqsFJQIzJG4tt6/S8CRFWoplxwp1?=
 =?us-ascii?Q?wFSFfEtoE43SZ5Z2x2rG+0TmJvklHNu+T2jL2bU6FOP+JtC96GYMgFAW+RiC?=
 =?us-ascii?Q?xn6Nlrsvs+buqlSexigc7HkaoEQ/i6Nax3B8TnnUHsPNHxEZ7POb+li/2leY?=
 =?us-ascii?Q?NCVLp+P/xHwpXMvQp4hV94xY7C3+46vvrq4LMURUqAsCA5jMRhxh/cbtoPkP?=
 =?us-ascii?Q?tDI+mB74bCAz/+NxtjYL8gKtle0S+bWtRAyqamYHgiyAKI2HTvqsQm+oMLz+?=
 =?us-ascii?Q?vYuiDxEhVXA422yVDUm3KzZtDTSkxyDfJ/So+1QQezxnn64QOhxnnbhuNmLb?=
 =?us-ascii?Q?+B3enzBPttHpTBqR0KFwNSv5YbvWI6LRD5L80vKANXpDk7siXfr5iJzvQLOI?=
 =?us-ascii?Q?iYljXJyn2WFKUStloqZ6EigQnEGndxkV/MCG8Jafb+5o5SZsmeZlYAVFtDQa?=
 =?us-ascii?Q?bQZs/DmHP3s+uqXLMkIG7+9tAFhx4JBlv8+ie3tMn9Sd+ldf+Et0162jcvGg?=
 =?us-ascii?Q?wkAobzWWsy8IiPdoVNsIPZnT5Ua+QZSC/2jPKCdkzYuW9lL21+AiJklf6FEC?=
 =?us-ascii?Q?Pp6dLuhFcL/pg2UurEsZ4uzsmX56272HhfnBh+UOH8vbo34xqlKTtdnEdrW/?=
 =?us-ascii?Q?2DBglglkYhf69vtppSrF2YCpwgK7u8fWOFu1VOPKICVkmFkPmV56LO1ap8Cn?=
 =?us-ascii?Q?BuA6kFTYNkyAAI+sJf1vtjRm9PTI6W35ylvdcZI0/kWZdnO/7M2CiKaNMZv+?=
 =?us-ascii?Q?pgm5c7tc472/1zjNS51IBvbq/Iz+cptLmK63kGdKkptE4lPgErsKzXzA/spI?=
 =?us-ascii?Q?qrbFQ68V0P1XMUsDAFesM7vlEyiJDbjkUFl9aCiWIvmpnnFZFw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Ze1xbMBjWrP2DfrHDNMXOq0gaall+W4jVR/CC2JzIKmv6B9aQKvP1AbgZOl?=
 =?us-ascii?Q?8Euf1JAJ2b9JQUaQZ+xB4QyTGtKrhtS0r5VmRwf6SKKeewNludNdOJF3T+9j?=
 =?us-ascii?Q?ZZd9M5OFDaYCjg6U/R9Ydwyj8fyCAIP0pRuPuripyZPfQvYT/ZgcM6WnW34d?=
 =?us-ascii?Q?ssGC2MySmcRFmz/YcJmyB5fZ/6fkE6Ldy4OgXu1uewdcB0PqXtMUrnq5pMlu?=
 =?us-ascii?Q?gj0egyqfJq/dxorEAAgfQTEaY620wb0vF4viKF77ML7ntnt4oh2rbmZaHQkx?=
 =?us-ascii?Q?TPWYzUohb0n9OIXqGPbmXMmnG4EDruoNYWpCUH7mqZRJUphUHv2mY9eBE2Cj?=
 =?us-ascii?Q?buEsbPEipvPg5pDRWVfNIK+F0m9r7u0IGipns13jUJxuL8D2Oj6kl46yJKaF?=
 =?us-ascii?Q?lnXyJhvMr/jzjwyu2pcrlCTSkL6Yw/4SdPgAmPndTiIkLGE6Rr2PcinEnEWF?=
 =?us-ascii?Q?ZtvoOEdXPMZA38phkZWG0VGDjUqwXzoBqL0krgpI3tsrsqQGlWppE+Udd8Xg?=
 =?us-ascii?Q?JEn5p3UOTpbn2I0CUnSuUrGNk6nkEiuuIi7UNw2Li48Pc5YFrxvHhfcLsA0J?=
 =?us-ascii?Q?xwPTFg/DJ2LO0gTeCfeJiHuaRzNhmP6O8rkH4vCXNS0NhnAg+FqJ5x7ftOgU?=
 =?us-ascii?Q?Fsf+i1XGzbRazcs6e/Jnw8Sa/0lQuvXhTJGfknl8lRjv5TxX4hOi3ooOk45j?=
 =?us-ascii?Q?4f9+j8MSbBcPGWh3cOZFLBnrQk4ayYl41zCbncYgz8ilGt9FC4lb/HcO4W/o?=
 =?us-ascii?Q?lI8CFzXmKBqNsMRFI7GOyq4VtPMnVA03JSscUVIYKi/JLT8mmwbhx6go2n4K?=
 =?us-ascii?Q?kU7cccbLJ4VHuVYPDwukO8vn4hUTcfjaA1Gr9KtqiSiVd9/U/zaD82aCrypM?=
 =?us-ascii?Q?6LHRlNdMEbGaJTn/knrL66nBR5Ywm9E7ygdg+VolON9MUgj9Quj2eI8dzdI+?=
 =?us-ascii?Q?HfeDI5VNAa44yZ6gcnxb6fYH4iFN0aIWFqTk/VDLbpeOs02sdyatpb8WNFZS?=
 =?us-ascii?Q?H4IGHrDBrl1/OiRWkcHGIFNtzJqaIzTd84V3MWh+oEm1C5qwPt4/QB2YIz65?=
 =?us-ascii?Q?ez4Mev2VUh/mxYwyDzF23UPDQpVBwLQjuDecle5qqTrUUHRR500DyyGWbUhs?=
 =?us-ascii?Q?jXaCvNjCw8E4nchTB4rBjUB+lcTP4QXMLgUEbIcGOBRbuUVFxQXoFhspJ6Qt?=
 =?us-ascii?Q?4Kdxg+BzS3iB+w20UFwmWaMUvQw7RL+6yU36Q4XwWH7GWyheRwN516njcLMh?=
 =?us-ascii?Q?sNuYNXSQ5B6I+74L/r+zXr+bBz/XpAwoufF0bIkNiBCJftXRLTyi074WTNh5?=
 =?us-ascii?Q?lHxMosHzBax7CcfxYN8mmlkFkHV/06uujlQmJbf8Z/TC8MKM6dX4aSApB2AF?=
 =?us-ascii?Q?TrFsXQYw6ku8lDwBsp9KH7U1n3b9/quvWuuwD7q8oDqeSrqOV+TOM4tHXn1O?=
 =?us-ascii?Q?wqDPtpnpGvfO/HmjOstv1WuoGEf3E3/FNhbaeoIlA3r3FaCnNj/lXxyxV94v?=
 =?us-ascii?Q?Pa6hDZiVJmroOmuDhOuOAcSL28Kf6IU7O4pqjxUXErr/UITfVtj+hpwx2XpM?=
 =?us-ascii?Q?rFo+6XeMAYsP6gmgg1XggURLatswi9e+0VNNGBsq?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB6804A2BDBF7FB341830BAB47FCF42PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f009e-db1d-49da-6564-08dd452c9ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 15:00:03.2696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCNCEG8Uj90M1asZnfNHZctMT8osV8xMhfXb0Yjbpvb1mvwEgrxoDypuj3rWg22LEydHSCaZ3oZucwXRZNmvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
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

--_000_PH8PR11MB6804A2BDBF7FB341830BAB47FCF42PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-02-04
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
* Microsoft
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.03:

- Proposal deadline (RFC/v1 patches): 4 January 2025
- API freeze (-rc1): 7 February 2025
- PMD features freeze (-rc2): 28 February 2025
- Builtin applications features freeze (-rc3): 7 March 2025
- Release: 26 March 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 80 patches outstanding. ~50 pending for main.
  * May back out XDP changes. Needs fixes.

* next-net-intel
  * Pulled last week
  * 60 patches in queue
  * Expecting a large patch to the igc/e1000.
    Needs some small fixes.

* next-net-broadcom
  * 7-8 patches in queue

* next-net-mlx
  * 19 patches in backlog

* next-net-mvl
  * 36 patches in review.

* next-eventdev
  * 38 patches in review.

* next-baseband
  * 1 series under review.

* next-virtio
  * Reviewing 1/3 series from Marvell.

* next-crypto
  * ~30 patches on backlog
  * Nothing for RC1
  * Series with ZTE driver

* next-dts
  * 34 patches in backlog. Around the same number merged.
  * Issue with Python 3.13

* main
  * Looking a VLA patchset for Windows
  * New driver for XSC from Yunsilicon
  * Some fixes have been merged to main to fix
    GCC 15 issues.

Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


LTS
---

Current LTS versions:

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
send an email to "John McNamara john.mcnamara@intel.com" for the invite.

--_000_PH8PR11MB6804A2BDBF7FB341830BAB47FCF42PH8PR11MB6804namp_
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
meeting minutes 2025-02-04<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Microsoft<o:p=
></o:p></span></p>
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
freeze (-rc2): 28 February 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 80 pat=
ches outstanding. ~50 pending for main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * May ba=
ck out XDP changes. Needs fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Pulled=
 last week<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 60 pat=
ches in queue<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Expect=
ing a large patch to the igc/e1000.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; Needs some small fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 7-8 pa=
tches in queue<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 19 pat=
ches in backlog<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 36 pat=
ches in review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 38 pat=
ches in review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Review=
ing 1/3 series from Marvell.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~30 pa=
tches on backlog<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Nothin=
g for RC1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Series=
 with ZTE driver<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 34 pat=
ches in backlog. Around the same number merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Issue =
with Python 3.13<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g a VLA patchset for Windows<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New dr=
iver for XSC from Yunsilicon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some f=
ixes have been merged to main to fix<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; GCC 15 issues.<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Current LTS ver=
sions:<o:p></o:p></span></p>
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
o &quot;John McNamara john.mcnamara@intel.com&quot; for the invite.<o:p></o=
:p></span></p>
</div>
</body>
</html>

--_000_PH8PR11MB6804A2BDBF7FB341830BAB47FCF42PH8PR11MB6804namp_--
