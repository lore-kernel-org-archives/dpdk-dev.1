Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C1C10A1E77
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 11:22:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF74427D5;
	Thu, 26 Mar 2026 12:22:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 561E840E1E;
 Thu, 26 Mar 2026 12:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774524163; x=1806060163;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OqqjS2hKY78sMLKFpaowUO6kAtjfrnF+4RoKHrhgDvU=;
 b=KTtUMHyYgDvDn39fPK5VkDVwGLxxTvjP8rJnxiDQSzKMPfWoDr9sT3fu
 Wpmp27MAX5y5VIyuAa06YF+K5Lc4sqFDqE2T0URz3bpiaEKmbr9N0zVxr
 4ki3504Tx/Hc3PWra48TN2qklT5vB4snPiNlkEpeC1rj4bJZIez2cztAO
 fJAv10223+ZNq+0vu1w0AVpR1nv6azqFk/TuWqgaAv3zF3DRH0CTne36I
 ONw5Np/0uIkZ+Yq+61UVvT07q+e7ST8XqGprv4HJCOVxQl1CYuSg231EZ
 J/j9xNt/DibGyQdyvnlsGkN+YTq3Qo1Pnh8s7KfoGAiSAHCi6Xv3ZaB3E A==;
X-CSE-ConnectionGUID: QAI/Z2vbQ5Gjidq4w+sgSQ==
X-CSE-MsgGUID: tZ0KbY0DSlmr6tkAPkvvnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75466864"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="75466864"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 04:22:42 -0700
X-CSE-ConnectionGUID: dAnlCjfYQ9eJUZrjNM66zw==
X-CSE-MsgGUID: FyLS1lXKT4mk0MN2gV0ZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="229916974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 04:22:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 04:22:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 04:22:41 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 04:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXUtiyhdYRRK2QECH1q/IazU59kseBsXvquU+arfo6c0Kpvt+NSXG7t13elINsN5JQArHVhvOwXmZ4SnM1upIqrN2yvoYENfCtqkTqRR/GejV+Hfb4Lo90/S5A4jl+aWwpinDjxBEdvInNWWGjSfTPTvg6Ti9JX36wrx+LxbJqj+mT7jm1OJ4vrOrnOTf+QmQ3hAMSj+rI+1OMaJrd5mtgFZaVebFOcMDPufz0L8IiUDUdNw4WZoARUBWPOCIQFJMmjR9OXcHeQL7xDM0kAokvST9hyeJJjhJ8gt4r7CXB3pH0qTWBh7I15W69YvyQlxoTUQ4la2AvtVtRZJEPyHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeLEboQvge+rDAjqUdiNn/fkiojHtOSMrluYTpH34nY=;
 b=XD55o+rKtVn8d6CJgp4kc+xcOKMxJ/bxQlb29re8a317qKcaW8jhwqoQQ8uP3O3XZVNHNVyxSiTuyeb8yIqsRp6Eq24Xzq+rYZnpUpLdUHLsV/HOc9oYLMLY1uQ+DM1AAvHgRy03M1lO/u4eIg3u+HW5al8+IdtRO1p3o83glpB7+6BFAUhocJRh3w9euxqkm/etjwvnTvfDXSWQ7sRfGzjzor3vgsk5oJ/YnVK1kuesZ0G78vosQpXcGuV3t2fLgcv/CuCV6Rst77UNNl6Pr1AOKikq18J7yq+rGmbD3y4u8tQqwULY0k2vl3uFCeeK3snb0yDvvZ/128uHvmqaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:22:38 +0000
Received: from IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::d829:19fa:4217:df66]) by IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::d829:19fa:4217:df66%7]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 11:22:37 +0000
From: "A V, KavyaX" <kavyax.a.v@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Wani, Shaiq"
 <shaiq.wani@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] app/testpmd: fix DCB queue allocation for VMDq devices
Thread-Topic: [PATCH v3] app/testpmd: fix DCB queue allocation for VMDq devices
Thread-Index: AQHcu3UwgmgwyEz/U0KpRyjL8lpwWrW90/eAgAJ8oYA=
Date: Thu, 26 Mar 2026 11:22:37 +0000
Message-ID: <IA1PR11MB6170C0E47DEB50F9E1D53FE6C456A@IA1PR11MB6170.namprd11.prod.outlook.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
 <20260324100500.2516672-1-kavyax.a.v@intel.com>
 <20260324084655.6d22c7fc@phoenix.local>
In-Reply-To: <20260324084655.6d22c7fc@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6170:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: c9a8d0aa-133c-4565-6499-08de8b29fc7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: reaEPfuM5lSFRT/OJ9Ik+LXSWfnKtTCE2s6jI7qqFLuco/mDCijbzhQXa/a+nNuG1BWXHXqa0MmnTt1oHNPuJmdxBoQO4lpTqO3xnFjITm2h9Vnyw3ZMcfKzIYhRExWFqzel4nRwoBbplP2lOdbXOkl6AhR2EpFymDJkemKgi898G9r9IXPmnA2Gk0Vx0wgMA6UeYdAJW20khyzQj0Hq4sBVCKMXqzilYmSZRoSEYdFPj9QHVW3K3ajg0IWy21JxugfkdOquzA7eHRCt4XWWPD/T47hM4A7GzvbOlEJMpH8lXz5BY1s0pgpWhVUQW5+2HDeHIGyRfP/1reY7jaBZ7/v8qcaeDcGC0H/6W6sCzTWWfN5HaH+fTUIBBYxaUl5v10cdgM7xBuUfrgzyRjKHtiF6gXMfpRWd1ci0RCwObzmYypTbSt2lvq0dNiirMay7odZpqQ9g8QqYb29sup87BIGT6EGo5Zd9e/9x6N0QSry6QZrgU+C3XCR5ho8j7nFr13379kVCEvkRceiGyhUVTTjiJGjg06zdtz9rBNYe/2bShcmZeMzsc4GaOMecdczjhC33JT8SwkbcpfYS8x+ypMQ3jU/VACUprNLq0l7OBl1OOw3ZLWdRJ7wSszD2HSW+sRjizWDinS4/QB5u9d0ubcUPWCYnr8A7DDCIVZk9bS7eBVmaiOPxfHeLICn/nOWTys178soF5qkoSx4JFV0ijK2d+jWc3EYWLZAfzgtp6VGnVVoUD6NPial5I2Ld2whZuEhOg95+S7D6p4vD2m/nFdB2rnvb0ElAgnieqwsEhbU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6170.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+SciSa6K+5xVtH2AotMBLvQdt2HcvgfWrOYHL5lqgZ/ID3Y6vskgCZOB/SAz?=
 =?us-ascii?Q?oKOIAI4zzjQwCFmu4pl6sQG3kvUJxaQk+nEjhJgq1huyWjLZ36QHsyf3N9YX?=
 =?us-ascii?Q?BQ2YqPRRUJ3w6hfGjet+AS1lEL7OJab0wiLltnDXenJblY86ORJj+oWHdod6?=
 =?us-ascii?Q?Csj1vmu2JKmMlJwixjC4pbSslTrOKivYNWitj00ssItr7dGw61WlBzViCein?=
 =?us-ascii?Q?hFB9ieo+W887/6kgyPVbslUwCgF68+LhAuFOemZWGAm8uafyrOSmDhSrUNKb?=
 =?us-ascii?Q?aJadm9U79jMsE1qFq3O807ABE1BYqTfnKK/UH6yJ8gWt64zmod7VVbnJ/tMZ?=
 =?us-ascii?Q?Atzt8BXDh7cZFmF3fY1GD8AhdrTAryLljvT4qMbQkgGsPuPgok+88emBmWZx?=
 =?us-ascii?Q?ExSfZBoyYjdTMBLKWmGAcXvrNusP5so6lhJ2u0T3uuz1X4jHxt1qpVmf+bvT?=
 =?us-ascii?Q?oiYJstSCUAO/RXEjeS+qvqWPiKkWfQQilZ44HMgHz11jXx+UgoG2C2iCMXUc?=
 =?us-ascii?Q?yZNIQwmPgsua1KKarSEnMaflJ4uCyxNDiwo0kwww4e8JZdvo5x11NPk9n+nm?=
 =?us-ascii?Q?I7/nnNS38DN9FvWFaPVoCiwdk0tUy6dyn4ChoiejkcdvHd+cD/Lq54Zcmqtx?=
 =?us-ascii?Q?z/bDvPhElXPD4I3PuNhaU2SMBenI2jsC55C66UolUYxLRarWa6Rn0Ar/rKTK?=
 =?us-ascii?Q?w+tXi1HSQ8nOG+FZTZ9my1xoaebnLjMDe7rgRdAH/BAteBmtyXFmtSqi8JQY?=
 =?us-ascii?Q?GEQwa607+zgTvd43JzxMgbiwGjjaZshdFXhzzn0BQmfosHX1n0XGxJaSoyPv?=
 =?us-ascii?Q?Lv6LAqYw4RB+yI33/Q2VAOSXOT2nuBhd5Q4TdsAv+InuWnY1GuskgYwq/0+p?=
 =?us-ascii?Q?YOHRlzaF73pxDNBp09HmGT0aVugkxyAmn72Mlq3eyzDJrPPDGorGkZfpEU0d?=
 =?us-ascii?Q?a6FWl9JgQdqtFSTy+6K01td9zyz91QEcel+dZl8s+TmZiiFodO5rME1RsCO1?=
 =?us-ascii?Q?J9n07MH8Ouw9vTDs2F/5UbBiJT1Jv1jFth/4/HO4aUHT9nt9OIEvxgDo3Zep?=
 =?us-ascii?Q?NYTyLygwkkAh6PYoV85yIUlWbHOq0UVh52M0RiD0ydJSYbNc+9ZCGjKRR1g1?=
 =?us-ascii?Q?XHF/c1hBDnZZiuiibKcC+5QtlwjAipzFWlObW62A6g0Vt6I3vFY334mtPYcx?=
 =?us-ascii?Q?6T7zHQtbMO1r6aPYSzBuoSRzPBnwkUykgLDQopkJPIs+yb1C2YlY6dOoGbPg?=
 =?us-ascii?Q?JQ/T/7Af69oXal8H9BFSEq4pp0NXpQZWyhmYfrVPt0e5WiIpIy4b0jRfal0a?=
 =?us-ascii?Q?W/k6uEVqyFBWM+s4cRL4gZhJx8/t+3shfBIzS6RRqr03ipWIHjTbuLCOJplQ?=
 =?us-ascii?Q?rSW2wQVv1SM8QlFS410FV47cjiKbV3Fmm/Z3I4gL3nwNMq5WkwG6D34xId28?=
 =?us-ascii?Q?ebYCq8AjR2HXytMkB0Hz5E0UPqQQ5nMVQ8AOJZEHV+NV67xAqNsHMPXtTuvB?=
 =?us-ascii?Q?KGBAZuNlbsHRlkPjOQY0mfS2MaGE++YJmD/XwKlv/JvPXrTWTDdlEOF4PLjb?=
 =?us-ascii?Q?wVO3YmQkalORN43UxCt7ygYUhcjgImlj9PxEUnL51A0ZtUNxX9gxLAbZGaRH?=
 =?us-ascii?Q?ANli3bbIS3osXvFhREgyYBwYzRho9KnlhLq2ae9MM/BYBIHP0KXng2BeZ4l7?=
 =?us-ascii?Q?MeZmsLejW1a63vOCLgAAIuHNWmQkxn7J16FNXMrIeS8PNxIS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dWvqSqeEVlJfbmCxUxZNqG0oQRgow0Uuo/QZ4Sds+Iw527FFAD4+AZMw4R4T3uMn2Lws8vf+ohDCT8UtDOb5GeYjUFj9xLY/t/Q6jnBTI+UseLpB0mFBxwkkbUo+1MFylxUj3BKmQlhAZm5CIOCy5E7YGyXiC4AG/HCfhVmdqWIuKmG8FjQ+JzVZj+PynGljzHfKhspjycCUpaLmmy15n2evWG8p6xfUFmZlyoRT7g3WpIveTiVwTBUMWa6rXxSLwopOBYAlZ9uf7L4M4IDDilmE6xv5o664VxBvHG5leD+gtdhLKde2PCOAYP6WknA5CXQ6U07jjG1yLRILWcWZCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a8d0aa-133c-4565-6499-08de8b29fc7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 11:22:37.8668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnl0jg1O0ZTNfFJrqchVnJK+ZmmGg7CzUY8tKoYmK3UVU88/0Vdqo4BCXTiIuLkbE0TRYVnJPzFmASan6RWL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
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
Sent: Tuesday, March 24, 2026 9:17 PM
To: A V, KavyaX <kavyax.a.v@intel.com>
Cc: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>; Singh, Am=
an Deep <aman.deep.singh@intel.com>; Medvedkin, Vladimir <vladimir.medvedki=
n@intel.com>; Wani, Shaiq <shaiq.wani@intel.com>; stable@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: fix DCB queue allocation for VMDq devi=
ces

On Tue, 24 Mar 2026 10:05:00 +0000
KAVYA AV <kavyax.a.v@intel.com> wrote:

> When using DCB mode with VT disabled and requesting more queues than=20
> traffic classes (e.g., rxq=3D64 with 8 TCs), testpmd crashes with null=20
> pointer errors because it artificially limits queue allocation to=20
> num_tcs.
>=20
> For VMDq devices, use actual VMDq queue layout (vmdq_queue_num)=20
> instead of limiting to num_tcs. This allows VMDq devices to utilize=20
> their full queue capacity while maintaining compatibility with non-VMDq d=
evices.
>=20
> Fixes null pointer dereference when queue structures are accessed=20
> beyond the allocated range.
>=20
> Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB=20
> command")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
> ---

I can't follow all the stuff here, is rather complex and esoteric case.
So did AI review.

The feedback from AI raised some questions (the I here is AI not me):


The basic idea of using dynamic VMDq queue info instead of limiting to num_=
tcs is right -- the current code clearly crashes when more queues are reque=
sted than traffic classes.

However, I'm not convinced vmdq_queue_num is the correct value here.
This code path is DCB-only (VT disabled) on a device with vmdq_pool_base > =
0, which in practice means i40e. In that case vmdq_queue_num is the total V=
MDq pool queue count (vmdq_nb_qps * max_nb_vmdq_vsi), but with VT disabled =
the PF queues are what's used for DCB, not the VMDq pool queues. The PF que=
ue count would be max_rx_queues - vmdq_queue_num. Using the VMDq count here=
 could over-allocate or misconfigure queues in DCB-only mode.

Can you explain why vmdq_queue_num is the right value rather than the PF qu=
eue count? Or test what happens when this value exceeds what the hardware s=
upports in DCB-only mode?

After testing with values beyond the hardware-supported limits, I found tha=
t the application could still configure up to max_rx_queues (320 for i40e) =
without any errors or crashes. The fwd_stream allocation and queue configur=
ation also completed successfully.
Current number of RX queues: 320
Max possible RX queues: 320
nb_ports=3D 1
max_q=3D 320
Created 320 fwd_stream(s)
Although show port dcb_tc 0 indicates a limit of 8 queues per TC, the I40E_=
MAX_Q_PER_TC constant is 64.
testpmd> show port dcb_tc 0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DCB infos for port 0   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  TC NUMBER: 8

  TC :             0       1       2       3       4       5       6       =
7
  Prio2TC :        0       1       2       3       4       5       6       =
7
  BW percent :    13%     13%     13%     13%     12%     12%     12%     1=
2%
  RXQ base :       0       8      16      24      32      40      48      5=
6
  RXQ number :     8       8       8       8       8       8       8       =
8
  TXQ base :       0       8      16      24      32      40      48      5=
6
  TXQ number :     8       8       8       8       8       8       8       =
8

As suggested, switched from the vmdq_queue_number-based layout to the PF-ba=
sed layout, and testing showed that the scenario works correctly without er=
rors.
 /* Use PF queue count for DCB-only mode with VMDQ devices */ =20
  nb_rxq =3D rte_port->dev_info.max_rx_queues - rte_port->dev_info.vmdq_que=
ue_num; =20
  nb_txq =3D rte_port->dev_info.max_tx_queues - rte_port->dev_info.vmdq_que=
ue_num;
Please confirm whether it is appropriate to proceed with this fix.

Minor: the prose line "Fixes null pointer dereference when queue structures=
 are accessed beyond the allocated range." reads as a sentence fragment. Fo=
ld it into the preceding paragraph or drop it since the Fixes tag already i=
dentifies what's being fixed.

