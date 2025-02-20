Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57949C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 12:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D3274014F;
	Thu, 20 Feb 2025 13:17:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B97C740041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740053848; x=1771589848;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Pgr5cQ8+rjkIM0USFD7sHhtdYbsoheG8cGyAx57yiM8=;
 b=JFx1vehpxf7O90QkeIP8YX5Hf/dGtfh9lEJcZaPH+bzPDYYJ3CSwgr1n
 KyFWKcN4em0acWzaLJnen+hj2bSIBmDhtjlC29BYMG65ODdCSwBfxyXK4
 yWZCqZtDcV3qdD+7mzkuR4QLu8UYCEapFUVYQOipS4Q1ste5vgVykK47w
 EtSreFbViE/L72Kw27VogPSYxRocATYPpkVwMvETAG9uxfeiUj+6K+Pgo
 baj6XBeTK3pr9qoEOcxR/FOMLvH6KI0yCGH0thjOwliDX5eRToLIlkS/O
 tvFvaMh5V67EKJYaqq9Lp5tMiNwUK8JYXMBnkSF8fvgX0826+dgKJowEr g==;
X-CSE-ConnectionGUID: +0NomZFWSCeWzuL/ODvMwg==
X-CSE-MsgGUID: Oa4vf6PNSSO0FGJdfbIQwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40017818"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208,217";a="40017818"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 04:17:27 -0800
X-CSE-ConnectionGUID: pV9ZlX9aTeqO9Dz7jbQITg==
X-CSE-MsgGUID: y6mfhd+QSnK/vptpsOvN6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="119120959"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 04:17:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 04:17:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 04:17:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 04:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPjMipscPR3ZGSeHQ29PuIHC00LFosB+Tw7c4vv1L2+974B1lm+p37Q+SSfcTmPb7KdiuJ9lQRm65Cy0QrK4HCdxKOMEx5MyZYzMu1OkCd5NDUK9u1fp01TjAsKozjHgFbnt/QzPOm9w7go3Uq3v2tOIY+A+IL6NBiesj95ZEbpLZ5ysQucPA+VtFc6KsagELqOwae+Vr+A3vhYCRka3aPXvEGQzmuxA3cKGIJT4uyUaad+jRM8qDjmYkOJg2dCJt/Iqosyf4VicG6nHZY2WRf45tXDHUgjiYyvbPBB5mP8bGwPJ7gF6xo8O+s79WFHxxIPyDLQw5nyK/sWOVqWDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmbtuLNU1+DrdApUUoDCYNU7l75YcSfrvL6spU9/Pfg=;
 b=rGvBOyjBIIUXbbd9FJ97ETf75PSZNOlL+uiOopZJpiioJmFCRsVEaTpAD0d8uwSYuVyClOe5DkxdUeqBBziNBQzbHwcN0dYclMFBwIn3THoUgrxUUhKLNTIUpyJnKlEq5oLWOsW2qRuz7wCUnPNQ9+xYjTTfPgXopmo4sySK58rRgtYgC6FqwRIsW5iXbOzjV4qlbQqwFExPe2myeapOlR8kp8hlgF5LH6vCDWmO0lU/sWawp2qukGWfgxd4TbOHpZKjHzYl9AgM0+2aT7kulM6Hm+cIyrgEm9NXGTb3zEB5AQ1gEMPRzIpLV5KMu6lnuPBN1EJN20oQYvsk1y42yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 12:17:23 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%6]) with mapi id 15.20.8445.015; Thu, 20 Feb 2025
 12:17:23 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-02-18
Thread-Topic: DPDK Release Status Meeting 2025-02-18
Thread-Index: AduDkT1grZt9u3fyRN2R8rWYK+cezw==
Date: Thu, 20 Feb 2025 12:17:22 +0000
Message-ID: <PH8PR11MB6804C3B03517E6618BADDCACFCC42@PH8PR11MB6804.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CH0PR11MB5299:EE_
x-ms-office365-filtering-correlation-id: 3072c181-2139-4fed-65bf-08dd51a887b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ctL0veE22rnxE+hadxqQiZqlVxuJ7XYbgAFW4aCVbN5wfaDZRA+s1eQAbRsI?=
 =?us-ascii?Q?5cSfE4QfoyCG2iwHWo1QBs7lHF3x9tI383j8kDMNPGcsMrDqPXWlUBknK7n/?=
 =?us-ascii?Q?gUlgFM3mAvHWvgssbtXpw7KTsKjh1369locUejlE/kBCAoAatRFOyL+49Htp?=
 =?us-ascii?Q?FW5EBZ86yBdu8Y9gXDAZmavHNqtwzd/wbec3PcNBjnZNWMpLZvFWxgrHzgii?=
 =?us-ascii?Q?a7nOFg4SVLJba2cxPUd2CBaeAN0NRewUDD4Eh0ZxBe05UDWmkET+TIYU9SpY?=
 =?us-ascii?Q?eQIk3No+q1T0q+BeRtUxs71b+uURwBhnxHQyTmGupMkC427E2M7m21FIuWaE?=
 =?us-ascii?Q?QQNx/R09C0T4YTiPFCuqlFxeSMmdDyfGKC5QV6AlAgRgOmJFT+XIO02jSFba?=
 =?us-ascii?Q?TluhkOIKDFF1KpzBK4SIq+zNJi0njJbv2CjI67apK2NNY3y+EwVUIF85Zl6E?=
 =?us-ascii?Q?F+2xz/oylCDswlB3avHC3fwmURZAjE8xjOT95M76DKyVUu+fNDL2wFstduxL?=
 =?us-ascii?Q?PVFx2IBCnptsurw+Sn/m2cdiMLssevEySt1/kaHEcS4l5updSDiZnj2iKB/C?=
 =?us-ascii?Q?+SyGNXzrEUGaDAUOihXOqxqdunXgPOg6amtXoLrNOCmsNPiER31SFp7boLhc?=
 =?us-ascii?Q?9xgdrywqBM6auM4f6Oc2SmvFwu7XGNhH0IyPzcwU0+Sri0MIbTTcRzoahCuD?=
 =?us-ascii?Q?kD03qzsMs+r/A1/5w2gX9hmsr+evKW1c3YsJv4QofaxYVSsHcxPRX+kn2iWv?=
 =?us-ascii?Q?pSgaEodPX+6RoL8xGcjESadt1iUCEJrR2segDyIfUGfniWFz0UqNkkRd+lO9?=
 =?us-ascii?Q?hyGyjgXZgOZcS8Ck+lrCH4cCQlM/59EMfLrQFv7CRyz61SM52LHer3HFMPQj?=
 =?us-ascii?Q?vFyaSU0xA9JVKDHkcMbNMP6FZysAzhOevvAR74+qP7QcaPycrzZn3lUt/rKV?=
 =?us-ascii?Q?2ad3Vgq4fAcr2auilruny2R5NxV7Ohrn444qN8zJRlljTu8EBSrgy5wG6x1w?=
 =?us-ascii?Q?RqlBBxofVgoL3+xYcVdByXTUzHn646AB3mSB8HFveRuJ+uZ6rmTT3QRUblzH?=
 =?us-ascii?Q?YozVaKmVJnptwv8b9j6NWtlGcQFLYPXVHXp0R0BIYfbzVwaSswNxZrBIqe7J?=
 =?us-ascii?Q?fGUMkN3TVIPO5hh4LoWE1ntEBpdmmqaqhn3m2mINRsbc/l0hqzPROMjvm/Wq?=
 =?us-ascii?Q?EF00HpYtnIeOpka9uFmXXVtKmyH8eMO0w4G1MF5lteExn20Rb/1lgeu4OOcH?=
 =?us-ascii?Q?aHgnd1WTURvOaU/5JhR/IBrCURzVHhT98WzMQnvbr3t7/JW7hFHH3wAU2YHO?=
 =?us-ascii?Q?CkSU2laBkK/h9xyq17NQT655oh/wyWdg37yNwzgYAkdwRxQM3XikzwLXlA82?=
 =?us-ascii?Q?iJ3NImsrfRelmCwxW1kSgwk3+b1JGq8j0phNOoo398Hh8yvhZw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TQ+XQRhiVrIwD0RqOoeIUlD+rZSNBALYlnYrXPiLW9ufwizbKwXxw6siKHoC?=
 =?us-ascii?Q?iuGijQutx4pg9gXP3tKUDxPwtS7odjSMZf+7cCvQb55Qlh4hPo0M6nw5pGqI?=
 =?us-ascii?Q?Xk/QhcK8tiJRUcaNZl6Io+MGF5MsyPwW1w+8prJ22MBoIKmD+PGAB6tBgzlE?=
 =?us-ascii?Q?MOt6J3UpgArsIrV/w47nWZA/9eUd5CNldpvYFllrJGUkYYMxCSGoe8FTFBZC?=
 =?us-ascii?Q?4Hm1JJPt/aYfcJ5tcGK91XpvbTM20yO/jQgLAcrp5ttIR0S+SNX2i6aC1Iem?=
 =?us-ascii?Q?KSYH26KVfSbAwzSMmWSCPE6PCptfd+LsIKo4ULjy8rkYt/uLjdTXUAywqSe0?=
 =?us-ascii?Q?wcCjoBJBagVuhx1NleRbeZYVx2Wg1V61ZIFoSUHtQaM3PlPxbEMckqaNFrmq?=
 =?us-ascii?Q?mY1Ngo/WOVQ+pDFjvEfg5xpVvMw+z5vuqFUJD5YSDwSXUNXsdZa8HdQ22nD6?=
 =?us-ascii?Q?WAxNQcOEgUvlx8qt36OO1fraaDqulaqSySicGRx3fyPGT2cNxM2dtJOopN/e?=
 =?us-ascii?Q?oIYThIFU8njvPwTvpnAed33aAHJt1FmfubooB2zUawBVN43GkvQOuX919DOT?=
 =?us-ascii?Q?IlsFXdzivpTGVZ5QsyOAjnUt3TIsLvJ2Cru5JQ8AoVa3nMZLlPljVcyrgiti?=
 =?us-ascii?Q?DTNpUVrvWH6TCRuk9nTBQ2G1pEnbb6vWitTXhwU5hsuW119/3cmyA2ITb+qv?=
 =?us-ascii?Q?3XO7iTtSoIRX+62n497JkSVKMSwVG4XAnGhZZwcJd6IHqqrDkfpUp2FGPPbd?=
 =?us-ascii?Q?gmOGPuF7Hd4jazJu5W3neAFvyoTkEyMRynOO9yFhKp6qy1+RIub4ZaCkhyPh?=
 =?us-ascii?Q?wgy4Xd80Tf7W4Mhao7i6wchw82nv1fEkhG9H2Ma3XqFkf7BAsZ7YgPlmxdwh?=
 =?us-ascii?Q?iYhKQ0kvGGuiYmEsKVz9mXjV6orkqwQO+hK3r2t5IkMUyI1r5RmfL6M8gYI+?=
 =?us-ascii?Q?A4Hp1BG5GohAr38sDdIGdawc9tU7rvMkJxrV+rsP2omIaq4cguB5tSEr0dTU?=
 =?us-ascii?Q?Y1plC8GcyfX3kirQ3rtm6bSn4gh3OaCVJnq9ZjjPhTnIrAMlwLZvhF0KRYxY?=
 =?us-ascii?Q?7u36PqN/f6z//62Dl77bUNWZiFBrFfPCGNtN19s65kp8L5o6CaE4Z+NKa3rL?=
 =?us-ascii?Q?n5Memnx2Uha+Kt6+DiHJ4AEk6RmU2F9QwDO2NBVIGSm07W+R426xnCfwnpNX?=
 =?us-ascii?Q?8KxfjCwpN4Ne1QSQMeXN57f1b/5huGfHLJyWFlz9AUztZ5E9E53rAOFs1eBm?=
 =?us-ascii?Q?Gj079gpSnyPqrvmfqkDM3GpU8XroiVblJh8X+Hkk7/4Ll8A4rY5Sgxd1T71H?=
 =?us-ascii?Q?or9PEw5+G1V2MZHXIFWK9oEcziIcrzm9hkLhLK5fAckMWvPRcgDb/hjEe0hO?=
 =?us-ascii?Q?fF2MsvdDqgHuiC7rxlNG+In9PqMPni8OFBpSl3B/gjegqtLvb/RaSjqy8AYb?=
 =?us-ascii?Q?a8d+uHTCbIw1M3geAR4oFJ02hSNIW3ycI1saL3Jha5cpTqfwSLEdTjUOR5BC?=
 =?us-ascii?Q?j521jKgVScYR5ndF3H96O2TdlUN/baSXGTwqyrQbeuWEwC8RL2rbkPDKy/pY?=
 =?us-ascii?Q?T5Ztx4jAcRDeS1g7D5Tbl5/E0b0vhjIHSl+4s5VQ?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB6804C3B03517E6618BADDCACFCC42PH8PR11MB6804namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3072c181-2139-4fed-65bf-08dd51a887b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:17:22.9256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6RAunLI41jOLL33CtIQakQLo12rsTlp3iNIcjVM+XJk3jXG9+ajwQXjjBJw2H6qpOfQ9vVF7l7gAKZAfLmW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
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

--_000_PH8PR11MB6804C3B03517E6618BADDCACFCC42PH8PR11MB6804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-02-18
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
  * 5 patches pending on main.
  * 13 patches under reviewing.

* next-net-intel
  * ~ 4 patches remaining/in progress.

* next-net-broadcom
  * No patches in flight.

* next-net-mlx
  * No update this week.

* next-net-mvl
  * No update this week.

* next-eventdev
  * No update this week.

* next-baseband
  * 1 series under review.
  * Merging in RC2.

* next-virtio
  * PR merged.

* next-crypto
  * No update this week.

* next-dts
  * Framework mainly merged or push to the next release.
  * Only tests on the backlog.

* main
  * RC1 released


Other
-----
  - DPDK Summit 2025 will be in Prague in May:
    - https://events.linuxfoundation.org/dpdk-summit/
    - https://www.dpdk.org/event/dpdk-summit-2025-prague/


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

--_000_PH8PR11MB6804C3B03517E6618BADDCACFCC42PH8PR11MB6804namp_
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
meeting minutes 2025-02-18<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 5 patc=
hes pending on main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 13 pat=
ches under reviewing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~ 4 pa=
tches remaining/in progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No pat=
ches in flight.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es under review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mergin=
g in RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR mer=
ged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Framew=
ork mainly merged or push to the next release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Only t=
ests on the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 re=
leased<o:p></o:p></span></p>
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
</div>
</body>
</html>

--_000_PH8PR11MB6804C3B03517E6618BADDCACFCC42PH8PR11MB6804namp_--
