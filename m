Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA972CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 153D7410E4;
	Thu, 14 Aug 2025 15:16:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8D492402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 15:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755177406; x=1786713406;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9W8czqPGQSH+ARIdp2cRqAHMhwD30P255qd1cLUKlQs=;
 b=cYzL9qLPaQuckX6+9vRya9VNL89zpT5GFqruXXusejxHYR6uwfbYrka1
 PDzfBsdj3b4d8JqrNeD/Q61kgOk2w89vECBvioq+n76pynzBS1V7iQzL+
 E16ZsvHK9qENVkoXDVeIjptRHM/NW3+P7PPDFFYPHuVeAGYnqnAkuJzwo
 uW8qNKqPhhpHVfjAbChM4WKCH2YMhVLYcxIt/e5p0hO9LHXTGetHU6Y8J
 ItzBVudsjhEixrpLX54pdeR+xnix38Fgqc9qmxG5cW/HpcSC8cDBh1eSy
 iSo6X5A4c1tZ6reHpWnbSKXeObOFz8plMY9Uom067Rd1aHX2NV0b63w4p A==;
X-CSE-ConnectionGUID: pcb3UGkCRlqFcI315xDdqg==
X-CSE-MsgGUID: vUev2id1TpW9KT1BzGuAzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61118469"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="61118469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:16:44 -0700
X-CSE-ConnectionGUID: /5y0omU1T9ihlmUn7eYT/w==
X-CSE-MsgGUID: BfAsY+nZS3OT+6RsjzY92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="171216728"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 06:16:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 06:16:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 06:16:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.68)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 06:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzTYu1zc4f9gvl6WJDE+xSh/fha7cc1S1D9pIGLU9yQOb1MCDFulQCIJXQqbMnSOIGibRnr9o/GBq41Wj4gJB7X7qEYle6QK25Qaif3vh37dQ4DVKet6N6Iw4SOP8wEIfLRasL6LIWeQqkH6AV5jg6Pz8roKj8moRqZOERWXyEG5e+Ksz6PnxHLytA9opXwHLahMpB0w3Km3mDsXZXtI+J7GEMumLiN1iOqfKOYjTUVjSqvsr83ckk65Rvcsz0yn96vQg0lKE6ZgcJgJa9VAK6QwSU9gUOAJy+vfRHm0W1EP4SGUtNYBYHhgKdd7xG8B7zeKARUJf2pTDmUXqfTEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exDl656kLXvWv97gabQH/6axXEP9/8PeJobmDEgPum0=;
 b=opn0UU9lTJZ4fyQJH5nvTKl/EBW9IRw1WFTDjobYz1RH8LWK6O0qKJxZ2fT3BCmqJ5ei3ojIjKAhukpb6BTXyNmRrWv7rokNeO0GDQL04H6vjohTOvKdpkGUMRLFg8pPuFGwoOf8bN60HZ+1zT5XyJalxToiiJMXQCWIddnOyEqLgr0ohNHtzYrgFAkSnr9sbxl2Zx6zqyi3/nPxQKVTuToFbl4koLkLRUfEi0AtCUfr4D1TycCYm9FrSS9arNgg0fWB7dfyBeng9eIMWdJCOgrmzYzVEEVY7fI7Hi5XKE0SttQ26u2jypu+EgS7unVY8da484Z/CIAX4hYtPMpGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:16:39 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%7]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:16:39 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 06/15] net/ice: use the new common vector capability
 function
Thread-Topic: [PATCH v2 06/15] net/ice: use the new common vector capability
 function
Thread-Index: AQHcB5hrZUrXjOcGQ0+M1sPLRCLd97RdS1iAgATgfwA=
Date: Thu, 14 Aug 2025 13:16:39 +0000
Message-ID: <DM3PPF7D18F34A15794D13A11F4773270028E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-7-ciara.loftus@intel.com>
 <aJnKJf1NZ9ih43Fk@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aJnKJf1NZ9ih43Fk@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|MN0PR11MB6206:EE_
x-ms-office365-filtering-correlation-id: c3a75387-ba4f-4c9f-1da3-08dddb34ce12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WGxyUmcXK3obwmXzbbKsBWUH8OW8ubd5kvaeRMrV51hnjlflAduLaSwE+ZYU?=
 =?us-ascii?Q?oXNVP8ldY6Nu8l9twC0AwrgMI2rqVoRivzb1bub3eTAHVmqWFD+oXsoAbJpf?=
 =?us-ascii?Q?PUCvrUpX8HiHO1gRs76RH4hZBNwWuyLkZWb8BHc4W5e+p2h6kSQkCGh39YD8?=
 =?us-ascii?Q?YK4boyTK2uCAiqYgEC6P6v96wvVLOzMg3MKDmUHOjyO7aPv2ju1PFysEEzJw?=
 =?us-ascii?Q?vGCTbDlnfQ3ghGf+LjF9gXYSh+KwIRGQnSvxOPAC34RUu8+ZDt5vIgseeKB8?=
 =?us-ascii?Q?S3yUDA9kUBUl9jlOxgvFDau5oLx64f8vdb2IGdlVud2xlnryYRN0xzneYq7v?=
 =?us-ascii?Q?e998vI77+SoTn/jzx4npGmf/kOwZYKC5GcvWfjvGjPV2ofcgvA1tKkUdJE5g?=
 =?us-ascii?Q?0cVvn5j7+Px6osYrB5pX6tdtcp5f1hZHy7diQwY6+uqDmTiPTnOdukIuEGE7?=
 =?us-ascii?Q?bZNdKBAbHtXoiY1b+YCgPYCD5FTPwL2otdqvmlxsPji5lMQV7YEkxL4a2huS?=
 =?us-ascii?Q?vKuVcWbLHftri3jGUqn3RM5Pc8SkejoSPtit5iqDiNEZ5nS3u/ySTvAabtud?=
 =?us-ascii?Q?v8hWIxH7j3dHfiSpqF194VV84eovjuvJlc5Wlk8xbkqczMrfWQ7LyhGmZdq4?=
 =?us-ascii?Q?yVZGAr5KZrdt38Lsp7N/zimqTynKTTuuVftgNJjeNajJ5tZYkRrKRVbNNaDI?=
 =?us-ascii?Q?Lhd6J6U65ADY/8u5IuAZl6SUjw0Z6CNzMPtCzRB1esrXSU4aaYmxDo4IQsPE?=
 =?us-ascii?Q?evC//qf73/7Rw3ZbCmD0sehjEbWoxrMVanzQY6dFgS0D6lUn2oZLFc6cGAhk?=
 =?us-ascii?Q?n40YWSa6H73TWIMpZ41CvD8geRTk2FO6IHBUBAKlddM/amf6OC2NM0pGsouP?=
 =?us-ascii?Q?wVq0IuFIJ/cIcwhOSVqpABaCnUxMqNz9JN137O3hb9fTegoFg+1ObNkpRvNs?=
 =?us-ascii?Q?rzP6N6wMQEDrB9alVNziXJpRu5+E6Rw2wUCm+WQXf1SfY7tGoojYygCPs213?=
 =?us-ascii?Q?WbMpgpbkQf9xlApC4Mr5QYiIv78DKPMzqhSfXBTLqZVE8I3yGGxjPQKcSmQo?=
 =?us-ascii?Q?h5dt23hIufjBQitmghoqGyAMZOZaLMHOXEHLyCZlJk9BQeTf+WhdEnmJUdnx?=
 =?us-ascii?Q?QZDXVmUjDt+WMIJZby+jcoTRzjxWtvmo3JfUl23dTKLKX3LQTZ8m9+kr//EU?=
 =?us-ascii?Q?qaUwfJKKFg5e4SGIp38Ubs5N3IDOA7yDocexODJCWhlMu1Smf/ehvwnp1PjR?=
 =?us-ascii?Q?Ah74afIrMyv7Iy9paN9/FIpcJS428TEGl3Aa7uo3VcpoNojp164KUWkLPb9x?=
 =?us-ascii?Q?qQ5MYDiFlvITdSLc4pzHiamfEE1bOpUDkul6/FZer2/amyjFiUXwjyeR4R8/?=
 =?us-ascii?Q?WwmTOVhEEnZzhi/gv0+LI1gTV5YX5QjVk38dgh0SYgUm4i++G01ndIfKeIAl?=
 =?us-ascii?Q?1/MhGoAHA+OUHDEAu2R/X2RIwXtCmWCiN9AXuq1PQCIa89GL83MnyA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/kcqjGOczFrvLQa2qx1k48i0ugEwRebdoJNlimCd6AlMEQ6po3U3bdv4EdL9?=
 =?us-ascii?Q?AT8/HR8jXgHwPmYZQ3S8wzeBk/w+kwFEcf6CrJKQjtcNYGbGFTQUigajXlku?=
 =?us-ascii?Q?kTZctcNRF6EvL7xqo9L/J4zUfOFRzRcw9XSNOQw1JbpYg+bQNDkFREi9YZfJ?=
 =?us-ascii?Q?+hFwErOfnlVe9vZtqsqDZka8HOWd4qI22+CxIDAgcacX7dPHSBTlWtUdvP0a?=
 =?us-ascii?Q?C/Nj++dtOTQWGB4AC3jYHOX/5i2xrG17LchZVt943pq6mYQIBNlLTA/Dg+Qk?=
 =?us-ascii?Q?p/G+mj+KVK17nXR9HZynuuvIMO3ltJB8uls12VK9ANPcNNfLQEHSwFgV70+k?=
 =?us-ascii?Q?uPM3kFj84Wrobbh12Bd+UJCSk/7h53y1lhwtSlWDqYnw4Yt/Nfoe0+MjL6Yb?=
 =?us-ascii?Q?SJckttnVkEZ8eJlb86SYOHxW5vLiZn9jfr+yKCP50f5MO1qWJ2aJS5+Ghj4I?=
 =?us-ascii?Q?LOWebwckK16M9ktcFyKYu12lXDJPqBo94sEJKOtjWdDMiyO5DVnHV1YLBMeg?=
 =?us-ascii?Q?e0UuhpnTt/b6aS68gdDpIms9zDEURhB2Lk5aRNupKmjYpSUh0fyTj+nKPi+T?=
 =?us-ascii?Q?8EoUhjuS8HwRWPFv4UldFi8nfU/hE5zXrH/KxI6YMANTmUV0SRK2vhQmJaCz?=
 =?us-ascii?Q?ksWjKYJ4GCyYX4QBuwEHSLwYe9JdZfJHKRV3ASllL8Z1KPDu2jysCueZTrJ2?=
 =?us-ascii?Q?QFyCJiQv5I7mz9Dg3QtVIh2l5cjSFikIgX5LrpySowGUgnp6yGJXBcFiy3Ay?=
 =?us-ascii?Q?YsWJ4uDY39Jjm4OPmlr2ttjqEesAk/vo9pzIbZz70jjIwFPcUeymFgLeARU6?=
 =?us-ascii?Q?yc3YQBQGqCZq/ArvyYIvIjkov+Z0994UuIVvU7+oSaG/KUx44c9rmXlOYUlF?=
 =?us-ascii?Q?QhKUViHIUVLexASL4j8+jmfV5/VG6Tm+9w9PKjtgU90wH3MoqLG1QRRv07Cf?=
 =?us-ascii?Q?mFLfBQBUEeIYIzFSNRWrMcwhW+taotsqfqxK0GCCkE6HiifgmsuwEFmEN6kL?=
 =?us-ascii?Q?hIiasUgJdAfgp/FuPHCdbFERlYdR8YRwqKNymjRQChtNs8k0qp6PiZZC6vrm?=
 =?us-ascii?Q?8UZPgDxzyRgcE5STpweNvWNeah4cxW/NC4TvM162nJ0bfWvsD3QJHLf6OQ7a?=
 =?us-ascii?Q?9DNShLZHuJv9Z+EKJGmTsT7JQnEUMm0Ly7Q+D6cU9wmB1Ez1Y18GxFcNQiBO?=
 =?us-ascii?Q?1VZ8moFN1F50EOtUj9L6cXZcJaOx2YfAclP82k3NexwBCXAPahB1eaXEPHMO?=
 =?us-ascii?Q?hjx+UIBekNmhkULC7s2pYp6oou0uopI2E9+Va7q1AXC4Gc0T15JK7V0DRa4A?=
 =?us-ascii?Q?yepPKTOxqAJPuEJkOdtmtoicYUnMdygo4zIMPBp6emJTpcu2Wf2I/6xyxEW6?=
 =?us-ascii?Q?H6DFsi79NPyKHcG9vkTLysG8WVBCabiC+SdC4vmw1oqHq2mUdyhZeeedCU9X?=
 =?us-ascii?Q?V28+zmCcXjFoNxK/kXJhMRlk+5OoEQPwfsLytYzZoxQfwchUPfn7vhdtU99P?=
 =?us-ascii?Q?mlKoMBZW8KZ5sEM7oWOTqsl7PjjvpxbfrIMzd3k79fCN1WvFC9VIk5tx7WMs?=
 =?us-ascii?Q?adKkwMUBSiLZV9uXRXD1KF6XtGDYQxOZ/VeLPj15?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a75387-ba4f-4c9f-1da3-08dddb34ce12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 13:16:39.8268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIGCTomuJgYzD5dZrbL2zGWTTwxghywz3jBI8shmO1F9FwxHeegqa9T5ioL/H667UwxMfCHSGxag6gbSojd3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
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

>=20
> On Thu, Aug 07, 2025 at 12:39:40PM +0000, Ciara Loftus wrote:
> > Use the new function for determining the maximum simd bitwidth in
> > the ice driver.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
>=20
> Couple more comments inline below.
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
>=20
> >  drivers/net/intel/ice/ice_ethdev.h       |  5 +--
> >  drivers/net/intel/ice/ice_rxtx.c         | 52 ++++++------------------
> >  drivers/net/intel/ice/ice_rxtx.h         |  1 +
> >  drivers/net/intel/ice/ice_rxtx_vec_sse.c |  6 +++
> >  4 files changed, 21 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> > index 4505644f87..8d975c23de 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -11,6 +11,7 @@
> >
> >  #include <ethdev_driver.h>
> >  #include <rte_tm_driver.h>
> > +#include <rte_vect.h>
> >
> >  #include "base/ice_common.h"
> >  #include "base/ice_adminq_cmd.h"
> > @@ -674,9 +675,7 @@ struct ice_adapter {
> >  	/* Set bit if the engine is disabled */
> >  	unsigned long disabled_engine_mask;
> >  	struct ice_parser *psr;
> > -	/* used only on X86, zero on other Archs */
> > -	bool tx_use_avx2;
> > -	bool tx_use_avx512;
> > +	enum rte_vect_max_simd tx_simd_width;
> >  	bool rx_vec_offload_support;
> >  };
> >
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/i=
ce_rxtx.c
> > index 428e136bfe..8c197eefa9 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -3703,7 +3703,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  	struct ci_rx_queue *rxq;
> >  	int i;
> >  	int rx_check_ret =3D -1;
> > -	bool rx_use_avx512 =3D false, rx_use_avx2 =3D false;
> > +	enum rte_vect_max_simd rx_simd_width =3D
> RTE_VECT_SIMD_DISABLED;
> >
> >  	rx_check_ret =3D ice_rx_vec_dev_check(dev);
> >  	if (ad->ptp_ena)
> > @@ -3720,35 +3720,22 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  				break;
> >  			}
> >  		}
> > +		rx_simd_width =3D ice_get_max_simd_bitwidth();
> >
> > -		if (rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_512 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) =3D=3D 1)
> > -#ifdef CC_AVX512_SUPPORT
> > -			rx_use_avx512 =3D true;
> > -#else
> > -		PMD_DRV_LOG(NOTICE,
> > -			"AVX512 is not supported in build env");
> > -#endif
> > -		if (!rx_use_avx512 &&
> > -
> 	(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1 ||
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1) &&
> > -				rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_256)
> > -			rx_use_avx2 =3D true;
> >  	} else {
> >  		ad->rx_vec_allowed =3D false;
> >  	}
> >
> >  	if (ad->rx_vec_allowed) {
> >  		if (dev->data->scattered_rx) {
> > -			if (rx_use_avx512) {
> > +			if (rx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_SCATTERED_OFFLOAD;
> >  				else
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_SCATTERED;
> >  #endif
>=20
> Since without AVX512_SUPPORT, the ice_get_max_simd_bitwidth function
> will
> not return RTE_VECT_SIMD_512, I think these ifdef guards are unnecessary.
>=20
> > -			} else if (rx_use_avx2) {
> > +			} else if (rx_simd_width =3D=3D RTE_VECT_SIMD_256) {
>=20
> Minor nit: since we are using "else if" here, rather than another "if" I
> wonder if it might be better in general across all these to use ">=3D" ra=
ther
> than "=3D=3D". If we did need to ifdef out AVX512 support block, that wou=
ld
> then allow the 256-bitwidth block to catch those AVX512 return values.

I will change these to >=3D however the change won't be long lived as this =
block is removed in the patch that introduces the new selection logic.

>=20
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX2_SCATTERED_OFFLOAD;
> >  				else
> > @@ -3757,14 +3744,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
> >  				ad->rx_func_type =3D ICE_RX_SSE_SCATTERED;
> >  			}
> >  		} else {
> > -			if (rx_use_avx512) {
> > +			if (rx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX512_OFFLOAD;
> >  				else
> >  					ad->rx_func_type =3D ICE_RX_AVX512;
> >  #endif
>=20
> Same here, as far as I can see.
>=20
> > -			} else if (rx_use_avx2) {
> > +			} else if (rx_simd_width =3D=3D RTE_VECT_SIMD_256) {
> >  				if (ad->rx_vec_offload_support)
> >  					ad->rx_func_type =3D
> ICE_RX_AVX2_OFFLOAD;
> >  				else
> > @@ -4032,29 +4019,14 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  	int tx_check_ret =3D -1;
> >
> >  	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> > -		ad->tx_use_avx2 =3D false;
> > -		ad->tx_use_avx512 =3D false;
> > +		ad->tx_simd_width =3D RTE_VECT_SIMD_DISABLED;
> >  		tx_check_ret =3D ice_tx_vec_dev_check(dev);
> > +		ad->tx_simd_width =3D ice_get_max_simd_bitwidth();
> >  		if (tx_check_ret >=3D 0 &&
> >  		    rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_128) {
> >  			ad->tx_vec_allowed =3D true;
> >
> > -			if (rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_512 &&
> > -			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F)
> =3D=3D 1 &&
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) =3D=3D 1)
> > -#ifdef CC_AVX512_SUPPORT
> > -				ad->tx_use_avx512 =3D true;
> > -#else
> > -			PMD_DRV_LOG(NOTICE,
> > -				"AVX512 is not supported in build env");
> > -#endif
> > -			if (!ad->tx_use_avx512 &&
> > -
> 	(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1 ||
> > -
> 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) =3D=3D 1) &&
> > -				rte_vect_get_max_simd_bitwidth() >=3D
> RTE_VECT_SIMD_256)
> > -				ad->tx_use_avx2 =3D true;
> > -
> > -			if (!ad->tx_use_avx2 && !ad->tx_use_avx512 &&
> > +			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
> >  				tx_check_ret =3D=3D
> ICE_VECTOR_OFFLOAD_PATH)
> >  				ad->tx_vec_allowed =3D false;
> >
> > @@ -4074,7 +4046,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >
> >  	if (ad->tx_vec_allowed) {
> >  		dev->tx_pkt_prepare =3D NULL;
> > -		if (ad->tx_use_avx512) {
> > +		if (ad->tx_simd_width =3D=3D RTE_VECT_SIMD_512) {
> >  #ifdef CC_AVX512_SUPPORT
> >  			if (tx_check_ret =3D=3D ICE_VECTOR_OFFLOAD_PATH) {
> >  				PMD_DRV_LOG(NOTICE,
> > @@ -4100,9 +4072,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
> >  				dev->tx_pkt_prepare =3D ice_prep_pkts;
> >  			} else {
> >  				PMD_DRV_LOG(DEBUG, "Using %sVector Tx
> (port %d).",
> > -					    ad->tx_use_avx2 ? "avx2 " : "",
> > +					    ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ? "avx2 " : "",
> >  					    dev->data->port_id);
> > -				dev->tx_pkt_burst =3D ad->tx_use_avx2 ?
> > +				dev->tx_pkt_burst =3D ad->tx_simd_width =3D=3D
> RTE_VECT_SIMD_256 ?
> >  						    ice_xmit_pkts_vec_avx2 :
> >  						    ice_xmit_pkts_vec;
> >  			}
> > diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/i=
ce_rxtx.h
> > index 0301d05888..8c3d6c413a 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.h
> > +++ b/drivers/net/intel/ice/ice_rxtx.h
> > @@ -261,6 +261,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void
> *tx_queue,
> >  int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir=
_desc);
> >  int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
> >  int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond
> *pmc);
> > +enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
> >
> >  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
> >  	int i; \
> > diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > index d818b3b728..1545bc3b6e 100644
> > --- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > +++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
> > @@ -735,3 +735,9 @@ ice_tx_vec_dev_check(struct rte_eth_dev *dev)
> >  {
> >  	return ice_tx_vec_dev_check_default(dev);
> >  }
> > +
> > +enum rte_vect_max_simd
> > +ice_get_max_simd_bitwidth(void)
> > +{
> > +	return ci_get_x86_max_simd_bitwidth();
> > +}
> > --
> > 2.34.1
> >
