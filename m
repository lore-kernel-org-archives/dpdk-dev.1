Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA9FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 03:49:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 527D340270;
	Mon,  4 May 2026 05:49:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B8BFF4026C
 for <dev@dpdk.org>; Mon,  4 May 2026 05:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777866551; x=1809402551;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f01MGXynUvxnBUFm04zFUx8NPuQCwh8dCsTokuoEnI4=;
 b=RooV3gu7WD9I0n0LnKGl1By7CO7CbT6FQ5wnQU9DeAKqGsu3KiypPwIq
 TpN50/n11pl91Xhzp4/tKM3hmhZgAdXD5JcIdTmGRW0b8Y/WDoTyYS2IY
 MWph+RfR5VL8is7Qa20YNCXEoTx4iA19GkDOFmwRIyoSZGeCs/xs7Q9Ed
 wfIkM7/QwkMHjTgTdn0Yw9CFRKVCxNf6uo5br0pvDZ06mbi+poRynq9pP
 +hdkIhz+dM+IJD2xFC98Ml+Olcytjn0q5QbVdmOMEEzwnpIYlRwYyo4Jc
 X3OwgwMRP23puXoHLTg2Wvx8NGkW4fYvPpiMqiUkzJteF9PYMNDoLrG7P w==;
X-CSE-ConnectionGUID: 4EBl1XxPSP+mymB8yegP3Q==
X-CSE-MsgGUID: Jx8yPzt1SBmyP312DtlSFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78585829"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="78585829"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 20:49:09 -0700
X-CSE-ConnectionGUID: 7E5L6sftQ2i1SVJG/weBIA==
X-CSE-MsgGUID: 3czXqYY8Qw6lRuro+dkySg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="258758805"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 20:49:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 20:49:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 3 May 2026 20:49:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 3 May 2026 20:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9pkaympHeLN+ao7D+SOkYDT+gup+HRkNErGrcDn95Wm+NBBMG2CtNghQ91me7KfzaKvSur9YoPIhnm7fPhD63nVkXi/TeoxDM4Hqa0x8OOCALkmkjf29vhNKr9nVVd1VsT3MWuleIaraFBdJsYXDTqvbsEO+WigRDxIx5Nyx1IhNKPmZzGYx6Njf31Gu7AnfJhBDe6EuPqV3rstqNVdr3jvWoqgmoOap6M2qQY+Q5SdSLoPn2sIKezBSMX4KfTkm4RDBtbuNkVQ7Dr6lUSQNeyuNLjuzsiiIActxfZ+5Hk6IKx6x2fXh69xa9Q3sYMLfbDLMFu9QjgenEqbkJy4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f01MGXynUvxnBUFm04zFUx8NPuQCwh8dCsTokuoEnI4=;
 b=GF26vlrPKXBtK8uzapSoGOEeF/a1AN4na8H9Jxt8RKPHqp8fv+Cr+B8C2cRZt9sKZDD9nNuabfciYl8Xa8nRvgJ0hCHGT8qq1UjhG1tHkGlddCEJCH2dnVFCc1DsVT0wCB3OVCIKeSKU9qsKM3g9HDjKhQKMSPCl0N7KP+N8IdvcpwuDEvniv2mxjQs9iY/l7vVJWsWhTlp3wWTTzZ6okSOQaVeqZyBgxmVE+BdULYBnbiGG/6Usd0dNC/6GMgjWSQ2FwTL8DVaQFOnmDUChDToL/nlzhsz53xnl0+tZxhlrRPASMSMQ44uZ1fcJxKrtvvTMksZRMDuOhzSkeSLtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by MW4PR11MB6619.namprd11.prod.outlook.com (2603:10b6:303:1eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 03:49:06 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 03:49:06 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>
Subject: RE: [RFC v2 0/6] introduce PTP protocol library and software relay
Thread-Topic: [RFC v2 0/6] introduce PTP protocol library and software relay
Thread-Index: AQHc1zDnEB7WLJvgmEOP4/KBI3cKQ7X2LawAgAcU+1A=
Date: Mon, 4 May 2026 03:49:06 +0000
Message-ID: <PH0PR11MB75631B35C048DA30A0A583D4B5312@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <cover.1777413123.git.rajesh3.kumar@intel.com>
 <20260429083704.5ea3d78c@phoenix.local>
In-Reply-To: <20260429083704.5ea3d78c@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|MW4PR11MB6619:EE_
x-ms-office365-filtering-correlation-id: c5ca8c38-9365-47f8-c717-08dea990174d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: YkejfxxYUanSmqhXTjesqwWEtgAlRlhApCDif1sebHJO1ZYGDPQyCRrIWkVy/BAIxwtlaO+sN2tvxrWWS2aJuCROuQPK0ht33ttYPxjnpxm3HbmQ5q8Sz7l8uWzArfumZRetknbDKQjfyK599QwyHgHHK2rtk+wS+R25mYFUejmjcEn3awzFUY3d2EYkWKQbxG0qvqw42qT7dC1ELsGk5f4Ko6FwzrX/QtJACbEt2oMsewuWjF1i0FTpzVawjVQCv6nSoOb+y9AqrL9BtyU3oV4VRT04MdA6GuAq5sZmZ+Shz7hTCWa6OtIOdxKGQ7o3BhiSyUbZHm+SZpbjXsNVaXYbClLxGsJcftZmIWLiRtqjc2R+cxqvFL/qDDkIaWc6ewi+Aa5uvD01YIlVb+i6HWn+b7YCIituffAiaUal7cltJOiQRlvVPMflNMECP0wnt6am5aYdsGYalC3A7Z6xYdXy5xYgcpoJbCU8ANwtPl3gfwGYMYRPLMl7YEhIjpdEwYWaDHlgXljChVNbvNWxzdtxkOA9Esg3vHfhVm2v4V/SHQNTA283qw7HED9bg0EXe1qa8dtJ120nX+Y+cT+QcCWv7O2qM9o7T7D/YlDsyVrxbFMyuNUcCH7l9dtij1QqMZoj1R1Yn5584J7T20qV6IRSEqsg4drCJM+EqDzw2/Z9VsHbeRmcoIMqWfmpH+ShbCazdkn4BxTvpnVNc2MzpxKl5J7k3/QKE4bI7+5L1uVagQvWZ1Xvc3wn1uCVqQif
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CzDsk4bEI9azHKNzyfNzccrehNi6GeBdTjUzcCG/j2F099edyaeVNJlqUBM3?=
 =?us-ascii?Q?+ch+C/uWokPT3Xc1sBu09ACv/Jl/eL3814KyRVGlcVYpTY+ehJDOfTm/Sdl3?=
 =?us-ascii?Q?CKvAxl2vDyT/86gZukFraFtfxeU/uKRT52u851PFUfxwNe2a1fNl4UQaiEMW?=
 =?us-ascii?Q?E+Y21k1DKwd3AHoSaoLR9KVgJJn8+Hfwsv4qepdSA5VGyidAkRHpNzqbwwbn?=
 =?us-ascii?Q?soxPll8ruNhmDvZB+kzR7qmYjXmrDxQVz1xYL/hYtbAm9c5andz/CoQn8uzd?=
 =?us-ascii?Q?CkdECdhqMUuuIEP1qEla8JLK0Crwu17tV0MYpeDlqDwsWaHKFtbBvH7SRNp5?=
 =?us-ascii?Q?fwL0f4UyxtBJgDP/pViIM4DX1G1ZjYD3xpjbEPYDtNO7M3Qsy30gWYpQxbha?=
 =?us-ascii?Q?Nk/GbPWZXKY/BynK3nD5P7iSX18+a7tYhiBXC2RhhQfXEfrYNsbbzWC8Amq/?=
 =?us-ascii?Q?VWlD+L0Vd89Lh04X2o+svo//MvqiQux8k4UCNaCntcaRLpq1x70kN/kPBK5Y?=
 =?us-ascii?Q?sW5O0brawzL6R/cvaGkeB7gnX0HquQeH5a0Hb9wAj94A27DAi44wBNnrIo3Q?=
 =?us-ascii?Q?Nwve94+XuoeGDrSnZnwFZzdNWRPufGTdYvk4iWXiJhXuQ9dh2EFg61yaaVOc?=
 =?us-ascii?Q?kaCAAxIC9fxsAULmZQD+OVzhIrPngfeMNdXVuwtcpnYaVyek/v4weOvzT4CQ?=
 =?us-ascii?Q?mG8/e4TXKOljlba/NzoAq0udAlVGtdN6jhOZ/vqzjE1l/99xFh5sMq3IrzBC?=
 =?us-ascii?Q?ac8uuI45w/odnqkAV8xh+Yl1nlWkw+AzjbtWpWcr86o3jO+d/S/GBk2H74m5?=
 =?us-ascii?Q?6v5aJ2EyNqbtbM83WrlDu4vSX1a5jsWNHEp6f++MiOJkICUNnyrnL/CaKkFJ?=
 =?us-ascii?Q?iBfgy+cjfiUmTdNded4lU/CpFrKaG6s95RnDYjvWHlYLXiSjFCfV23KFO+o6?=
 =?us-ascii?Q?VLfL14IgyTZI7hWeZDi+nddg2E8+41pah5Ob+REncXP8Fnbl4xvnpLMflahZ?=
 =?us-ascii?Q?6hKgDn6ObT8QLC1JSYeOTtycfqGQk4rWblH81U+eRL/biz9bCWBH9yLLMAFc?=
 =?us-ascii?Q?C6PIhG6jx4R+xDlzFOcxrxuoveVPUcHar8zoFOPGGzAtlEkIcOJwIhwdURoX?=
 =?us-ascii?Q?qsdkLsEPRsFpM2Nuwg354JclmftV5Xwf4rmfuYnsEsuzSgKRIKKfnsl6Nuu4?=
 =?us-ascii?Q?rDL5qDqq7/5mEJ5LXCqMvSBGB76IAhjUPq6oCnLWAEVN7ZBslWqAz2oUu6MF?=
 =?us-ascii?Q?swaH4ME5qvWjc3U6Dkuxz1aOSt0BGVzLgj357EPTCahZjbORzEIyxLlmH7LX?=
 =?us-ascii?Q?qLlip5WgoES1dQk2w5o6FsIjDgTF30tO9hup5v5OD8J0pJBPZ/lWiNIQrek5?=
 =?us-ascii?Q?7jLvPL78K5s0Xi81kruL5isku2T3K0MqSyFRUrcL6ERgols12r7yNdSZo7Ry?=
 =?us-ascii?Q?LMGn0LEjgEddPCc/uJUwQSkxuEm6rhMztXel1zE/Rvd7wnbX2Ucdi0ybcOAK?=
 =?us-ascii?Q?sJjbTCumz5lVy1SuG2q5lMwTyh/y7t7xIXhT70PwAA2Q1MOGt770dtZ1r6bW?=
 =?us-ascii?Q?eAedwhU8B5uYW3IOi9/MOCiuypfU/s1AjiYZghhLpwfs2LmNzh8nVmoIujzx?=
 =?us-ascii?Q?h54tKRD0A11wwCFgPp0nY1TmK5Zhic4fk7w53oSNwpC0Ze99OaT42AnRbWZ7?=
 =?us-ascii?Q?Rwr2r/xltuevkYVsaNTzU/Doq16dU8Z8B1dvTOYbSeIfEu1Z/8u6V6bdY5Gl?=
 =?us-ascii?Q?c2J//m5L+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hCON6aKdIyG8Dn6gl2IjcJHJjFLO8ASc+6KxK6Mb1Wv609H0prSL9X/s8yKW6HQC3FMl4vluBtTMWMyDvACvEgm7XTd8Npc/jZ0F2pWR6SzRqi35Ve8jAKp1SiwsAZRLXrBs7/OgqLBtkgAytsZWra7lQbr9N8riHu7VzNlA8aygcqjg2i/R7/jcFJhwYVNlhJk82vvMbvCZhrgdQANRoamdHLKfplkk3aN/RYN42arI+J9+nvXAS66m5z4mAngXkN8jq2BLSJjByV0zZ5oIuJQmr4Xh/DOuGaevQyCqkmSqsrk2PhbiT1qhLKsWnKSMGIGDrAVSyrgQ285+NYKleA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ca8c38-9365-47f8-c717-08dea990174d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 03:49:06.4048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMdI/6xp2KO4G2mtVvAa+979aNegowl+B+cU/UWPYFDC5eoIeFk0Lt6PhxQOXZL3qRvmLnwLIVjI2cW+ozLmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
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



-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: 29 April 2026 09:07 PM
To: Kumar, Rajesh3 <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>; Singh, Am=
an Deep <aman.deep.singh@intel.com>
Subject: Re: [RFC v2 0/6] introduce PTP protocol library and software relay

On Wed, 29 Apr 2026 03:58:31 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> This series introduces a new DPDK library (lib/ptp) for IEEE 1588-2019=20
> PTP protocol packet processing and a companion example application
> (ptp_tap_relay_sw) that demonstrates its usage.
>=20
> Motivation
> ----------
> Several DPDK applications need to classify and manipulate PTP packets=20
> (e.g. ptpclient, ptp_tap_relay, custom Transparent Clocks). Today each=20
> application re-implements its own PTP header parsing and=20
> correctionField handling. A shared library avoids duplication and=20
> provides a tested, standards-compliant foundation.


It would be great to have this, though not sure who would use it now.

AI review spotted some things.

Reviewed v2 of the PTP library series. Findings below.
Patch 1/6 (lib/ptp):

RTE_PTP_ETHERTYPE 0x88F7 duplicates RTE_ETHER_TYPE_1588 already in lib/net/=
rte_ether.h. Use the existing constant or alias to it.
Comment on the version byte says "reserved (4) | versionPTP (4)"; IEEE 1588=
-2019 redefined the upper nibble as minorVersionPTP.

Patch 2/6 (prog guide):

The guide declares rte_ptp_hdr_get(const struct rte_mbuf *m) but the header=
 has it non-const. Fix the doc, or split into const and non-const variants =
since the function returns a writable interior pointer.

Patch 3/6 (ptp_tap_relay_sw):

The standalone Makefile is missing CFLAGS +=3D -DALLOW_EXPERIMENTAL_API. Al=
l three rte_ptp_* APIs the relay uses are __rte_experimental, so make-based=
 builds will warn or fail under -Werror. meson is fine because meson.build =
sets allow_experimental_apis =3D true. Match examples/ptpclient/Makefile.
relay_burst() calls rte_ptp_classify() and then rte_ptp_hdr_get() on every =
event packet, parsing it twice. The prog guide added in 2/6 explicitly tell=
s callers to use rte_ptp_hdr_get() once and then rte_ptp_msg_type(hdr). The=
 reference example should follow its own guidance.
Minor: stats.corrections is updated via the global while the other counters=
 are passed in by pointer. Inconsistent.

Patch 4/6 (sample app guide):

Limitations section claims L2-only and PTPv2-only, but the relay uses lib/p=
tp classification which handles VLAN/QinQ/UDPv4/UDPv6 with no version filte=
r. Reword to "tested with L2 PTP" or drop the restriction.

Patch 5/6 (test_ptp.c):

Several correction tests dereference the rte_ptp_hdr_get() return without T=
EST_ASSERT_NOT_NULL: test_ptp_correction_zero, test_ptp_correction_known, a=
nd the four test_ptp_add_correction_* tests. test_ptp_two_step and test_ptp=
_seq_id get this right.
No coverage for IPv4 with options (IHL > 5). The library's offset +=3D ihl =
path is exercised by no test.

Patch 6/6: no issues.

>>>>Fixed.
