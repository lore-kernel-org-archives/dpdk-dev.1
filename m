Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A56606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zbmrh0C9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8355940299;
	Fri, 23 Oct 2026 15:00:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1CC3B40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792760435; x=1824296435;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/OHJJLCH+tMeH8KoBRhTDHSxWoSljaFaHK3R/K2FP9E=;
 b=Zbmrh0C9hPobNR6ziWUjxX/MSjTfZPuW0lM9+z+aeTuaHZlaNUzgEaJ7
 c/+PnmEL7ewG48geQnJ8X1RNd8L3EGigKRJm63t1i5B+L2p6wVh3PW2Gy
 pijprZW3EfuGdXYFpRhaUOVz0M/yXRr3bdg/CO4C3Kjb5JD9AmFtmQUoM
 1phZKBvUVs8to1EaoFLuPmrffPJkq1k65dsF4xwwhdpoerSyY8X8fXlN+
 COJooBgIvZJ0o3znxsSQoffZlP2jm14KfvClkv2VOzO1g8aTgVNlSXigM
 Gw9ztEjAZsCLFpfOAT6yYH1ItJ0hOi/1yv7+jIinhElzQRXskqIlLOTaI w==;
X-CSE-ConnectionGUID: v/2q3rQHSvSjh1xYqPJWdA==
X-CSE-MsgGUID: ofRsf7mERGezC7o7fhh2MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1404023"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1404023"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:00:08 -0700
X-CSE-ConnectionGUID: s+2+wmNcSPSY0+rA09A8UA==
X-CSE-MsgGUID: dBmzzCNKTWGlxbQ6QJ5ckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3703734"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:00:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:00:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:00:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.56)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aklGnFHz9TQkR91CnS8XwfKdY9b7xuoVBvCOKVsknQHbar30THOEqdwBwcw4+0FT0zAoBClXV6AG6pnh5T0iqaqoBCBBA9fZhppaH7xW+hOxij/ebEOmrtSeT98N76gGakQ2tXeUkfysRz7z0Jrvww06F9en11lKtqAC0WDIJO7ntIzAW3e7G6g0TjN4aWHudQB+O/s+ABshKGpgZ+SoMPqAnvNa94lFJ1dpmbwRHpi52rR4tcKPIDlSoKLtY7rnYu8D+U29Uq/oC7OmLAPzilCa0OH6gNXbxQPuzkL4MBOSFjjDSU7diwuNektDHCy974ikoj3IKzF2WYVzQmBIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjMlPISS9MZCDEshzMT9MRJ0AFCK4K0l+Hw+/IqbRrU=;
 b=OEeJcDGz6RyDbrMA5CQYF4oNlqdusuHLXMTBjbc5YrfgULzMSqfFEMwgEWU/U6ukMcKxz50eo3lXHmOVq1LtaVYxPvMkxEmV5UMp+FZ1neNJ/wI98Ox1rQ8dU6urYV1/wY27bm4HfhvyuLbS8HUigeEjzu5/wfvJYYXvWek+A4widVjpnhTRUbofwpKfYs/04QGbBlxCWlrcu1xjTDHylln+dyGEeWWou2CYmdIcsLM805+lw16AQ8gW71qOjxYodN6/gGS9QIO2Tz5uFEJSAiiEm7o0wiFNSwWMWHntpy32bOiQ7mY/o2aD3FGczq6/qVUaojQRiB0AXUN4/OVZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 13:00:03 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 13:00:03 +0000
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH 0/9] Update ICE base driver
Thread-Topic: [PATCH 0/9] Update ICE base driver
Thread-Index: AQHdYkW7p/R6EmvqEEaoJ+SZZ6ELZ7cK8OkAgAAm/oA=
Date: Fri, 23 Oct 2026 13:00:03 +0000
Message-ID: <BL0PR11MB2993FE31F2DCA8C64CB2DDD596642@BL0PR11MB2993.namprd11.prod.outlook.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
 <ats5Spw3EyH9e5wO@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ats5Spw3EyH9e5wO@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2993:EE_|SA1PR11MB8349:EE_
x-ms-office365-filtering-correlation-id: 6b021b54-9397-4021-46b6-08df31058df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|3023799007|38070700021|11063799006|4143699003|261009223027099003|10067099003|261021121427099003|261021123027099003|56012099006|261022105027099003;
x-microsoft-antispam-message-info: HdyTCchfcQt93zVBXfHIjneDBy3zYPdDkOx5YSIj2aRhTIIgN54IS8YrN+Wtf5oZzRM/f15mfK3Syd0wz3eu2XUDqjlQKljpR0prBT28gwOKFsSzAskFDhDOBYPXm3XTi/6a+2vmXSm20vbJQpBHNpbCgU3XjpjoxyttroRvOEzfPvukdjysaHKLF83fo5w1GOzBt67QuAyT9vvNH6kFb6dGKYcB2Nx5s6fa4mP/EB9GCWOvjEX6fQNn0im8mwLIx3JsKC+wKkoEai3QAazzfVemfmDdMRB/oN13vZ4TyVp5okGwhvrq01LWWm6XYXPo0BhsJgG+zesHVxkcCdd5QYiokSh48MZLAr8ivk57J0pXNKw7D1SXlc5qpOOHn7rIVIAGm+ioEOBv8zCB1NwBI9qxKHS5Lgfg0KHY76E47cN4t9+f8uvgYp0YUcIfIHZt6AJHvdRZmzrk7o39EssHk4j/SUVYRLt/iEv7bQUF+KUXsuXJ/NKCFmuy/oMZRXBqAuqGTe91EFrcWqXIXi4xvuSh5MQebBQBuAKGKQHz/TUD+1mUsgY1JTVQ0ghPr4Q9PmKugYP94n9Wtqx4mKJ66wztjjjw4Y1XLDRSHOuE3uPPhQjck+IIBXQSlWpDH4Mv/hLxF+5OiChWZqTAGmWW46v/qowMdPWRZbkY7FDmVwBNRNBPiSlPf02K3TNMpeALRpaz4i1vFXib4shHWlAqfB24Gn/nGyBlbDXKIBkr81w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(4143699003)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(56012099006)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?moo4anv7tDmxMsSW0s8RJlKwpKDCi/FMm5oY63Rk4ojcmYqEl/wmOTPUcLpH?=
 =?us-ascii?Q?6tc5jhqUxVr/6C/MYA/Q9K69fpuhlYjb3YxgpVoExbj4fIjwLPQNE9OJNAU0?=
 =?us-ascii?Q?DCdNE3uYRrjF20ZnCI05oREr3geoiRzImZuIyPdpu0IOQK8SBTNN+IAk+j6Y?=
 =?us-ascii?Q?364+sOn9+YznqcBgorPJbumkrLHZvd7U5BEOl4yFWhH2D20NyKa/CTkdEU1D?=
 =?us-ascii?Q?S9WeXi604HVFh5w6ZlAVWF6zul116/JhRt3gUAS0KwfcUMd7ZmMBZylmMEqA?=
 =?us-ascii?Q?2eE+vEE3kE5VuRDANtwPnwKCQEmxhL4osfOZa4pykrNU7LB14gRMaiv2KhJr?=
 =?us-ascii?Q?O2h21KmsZxrhvKwVLtZjoq+LUno3rgrp3uNkDX43iZWhaGn7gMh4vPWc90t2?=
 =?us-ascii?Q?ZYCYy+66kazSKiPnU5f443w8vA4jIG//me3td+QI8X3yqcz6pm2m8GgFn/Me?=
 =?us-ascii?Q?ybJ/gWP0UlQ9h798XDP1bnLhSsMUVLELAemMjzNPonj3XbODjQd19AXkRCPi?=
 =?us-ascii?Q?TiFuRET6ZZSRd3tLIib6AGAKu3m+JTPUInYA6qErPiJlcPbWik2pb22iqD+Q?=
 =?us-ascii?Q?n515b+1GYYBoclL84dnaP39SIC18BM3gT+m+gNeGsl8XLy8ZFL+IGjaXbxZX?=
 =?us-ascii?Q?vMHyM7IlsF88F3RAx12fGnKE3VVDwflxXWk4eRdcnUgZ1nskageG8pLucw5y?=
 =?us-ascii?Q?azPcDQ2J7tYaD+HYB0bzQDvLePA+ern+ai0/VXfZzRz8es7DRc4nzzfxtaZK?=
 =?us-ascii?Q?eIWdY4wGZXBE6h+3qInboH00GK8c+yW3DJ3JxD94Rsvei5/hrIpyoMZcpBXn?=
 =?us-ascii?Q?olHXx2XbWNZzbi2vyypMnjj43f3gad0Gt5NGsriyQT/OYpvCXRwaQV8Hvis7?=
 =?us-ascii?Q?xO2HfhMO+o/171SAOPZV/K1TATfDd/SdsK9HEvI2C18c/RY/7pIkTQxnHLV+?=
 =?us-ascii?Q?faI9MmU7FZ+adW6zJgyGRqPWpXGJTinQWoIGsuQ4JlA16SKK+BpLjKYJ5DIL?=
 =?us-ascii?Q?lWBhgoDQtLYfsHm/lGyRdvsxfTp5Mjs2k0OM47UxFY2clTLYhbZFzHOP05Cv?=
 =?us-ascii?Q?ytmcS+wXEFiYxP7+bMV8tP8t8eJGk+f9K3BPI6XSgWWb+T+GPemeGsD4Fm2R?=
 =?us-ascii?Q?bDGDvjXUgdvokDHKwaQk8gm9qLjqQnHCJ7KDoETBav2iXequktvO6lcPWPtB?=
 =?us-ascii?Q?4RSkHO7Q/LP3tpzHGojLUIHujXvAZ2POp8R2XtSwemVudGjVeEKJUFUv8izr?=
 =?us-ascii?Q?84bePp83sr5KtztpQ9gxjomFDI56dIwCRSsAmIElZQwopnYNW2uoYGodfTrg?=
 =?us-ascii?Q?s5F0PntWvE6GTt6px0c1yKcMyr7CyYPsVudvQayE3/6EGCoLNa4Zz0KDtisu?=
 =?us-ascii?Q?9Y7oZ68GOdCyV3A3pBrTiHF/ovCSsByit6Wcp6nq1Gdg2etIK8sBPcwTCujS?=
 =?us-ascii?Q?l57gEkt+5VR3pzXTFhwXdiru0RnIorl9jHjq52VGKfQQPYjWUiUe0fCY2xTF?=
 =?us-ascii?Q?az3SJPL4MjEVVaTRoDajzgAI1jD5Twzn5v7MahyuOfR0xqi3Mt5ZUTv1oxQO?=
 =?us-ascii?Q?VpUp9yIujLExdL6eFhnG8bPknG+A/UxhHZCZDX42CIJkPzH3MMD029MeiQ/X?=
 =?us-ascii?Q?3hwKcMwWXkcrpT7u6lBZ9L/tNZq+A1rQk6u0qKvtXcxhLpFBJzJC1x7qc8v4?=
 =?us-ascii?Q?uDRuh9PeGufEa31hnowRZ4V/EAwJqH0FMQplYdDyKKRwQAgQsY+RjrS57OvG?=
 =?us-ascii?Q?Lt2IER9JUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oBM9cV6WKKRT/qceQO8PxtVXpjUkZr4VknkYI1r5l6Rgf0pDM3luaArDPb3yBBk0vINWQ5N6uE64Sd+Eg8MR3wulpY3maNk/CB1zVqqKflLMLDMXIbR++jTq7b6AQXFyCvLP+qF20nQvQVuGNaRZklqboJcj0dbH5kCKgokxXZwhphootGm8IvWZOBGapHt3qie+dNUt96gcVDbk1tt6kDxzPAIjiMgCAChZTnRC2BtLl4lQz3U3xQHpUUaYgtxl+OMXP+VKRYqeNh/TWVQfk8H+txi7l5cmfGKRoiKTR6hT12nb+xlXzNRbnNxdLibqbg/dZb8eLUMuFIyG2MvdfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b021b54-9397-4021-46b6-08df31058df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 13:00:03.5441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiB+SWxz3ecFYcjXc0tbtKR0AdeXivZoX0BW5BlwSz4Tr68AswY+Z+htu7wo+yp614GmW/MST8hlr5GxP7Of+DI43CvQKXjtRq0i7g2Uldo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bruce,

It looks false positive to me.

-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: Friday, October 23, 2026 11:39 AM
To: Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org; Burakov, Anatoly <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/9] Update ICE base driver

On Thu, Oct 22, 2026 at 04:51:56PM +0000, Vladimir Medvedkin wrote:
> Update the ICE base driver to the latest shared code snapshot:
>=20
> - Bounds check, integer overflow and type fixes
> - New capability and NVM definitions
> - New E835 10GBASE-T device ID
>=20
> Chinh Cao (2):
>   net/ice/base: add NVM definitions for Wake-on-LAN config
>   net/ice/base: add E835 10GBASE-T device ID
>=20
> Deepthi Kavalur (1):
>   net/ice/base: fix loop counter type in recipe creation
>=20
> Janardhanan Arumugam (1):
>   net/ice/base: fix out-of-bounds accesses in DDP and NVM code
>=20
> Krzysztof Galazka (1):
>   net/ice/base: fix integer overflow in RL profile calculation
>=20
> Przemyslaw Gierszynski (1):
>   net/ice/base: add RDE WoL override capability bit
>=20
> Stefan Wegrzyn (2):
>   net/ice/base: add PQC certificate provisioning capability
>   net/ice/base: add NVM write flags for eRoT minSREV update
>=20
> Vladimir Medvedkin (1):
>   net/ice/base: update version info
>=20
>  drivers/net/intel/ice/base/README           |  2 +-
>  drivers/net/intel/ice/base/ice_adminq_cmd.h |  6 ++++++
>  drivers/net/intel/ice/base/ice_common.c     |  6 ++++++
>  drivers/net/intel/ice/base/ice_ddp.c        | 19 ++++++++++++-------
>  drivers/net/intel/ice/base/ice_devids.h     | 14 ++++++++------
>  drivers/net/intel/ice/base/ice_nvm.c        |  4 ++--
>  drivers/net/intel/ice/base/ice_sched.c      | 18 ++++++++----------
>  drivers/net/intel/ice/base/ice_switch.c     |  2 +-
>  drivers/net/intel/ice/base/ice_type.h       | 16 +++++++++++++++-
>  drivers/net/intel/ice/ice_ethdev.c          |  1 +
>  10 files changed, 60 insertions(+), 28 deletions(-)
>=20
CI shows a couple of failures when testing this patchset. I'm not sure if t=
hey are false positives though (for example a flags autotest failure).
Can you please check and confirm?

/Bruce
