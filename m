Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6399CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0448B402CE;
	Tue, 14 Oct 2025 16:59:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0F75B402A8;
 Tue, 14 Oct 2025 16:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760453955; x=1791989955;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=24L5guy2RNS/7iXClsn4pahvoJ7GG7ftZPQtN8FVVgg=;
 b=KYto9X6e89Wc/S0/P6/8FyBn9ak85qMYrFSKw9/EDB2d9n2F+Skkg0R7
 e097tRdTXVHhvhQhn2fJZ6tdXGC1mGsFHHc8laiItyq/sk4ZyoZgZG/nU
 3vLCXrh3MHv/DUZVtGERjG1nz9CC5R6lylpId5dmL9vWcygoh7y2wu9X1
 XCxMyCGKaPHq4fN7CGu1+zgggwPqYYYUcrJ15awJnpQdcJZ+/IyI2LoGU
 UUoTGelyfpCrJALu0ayBpUQjTMrJSH8d2qPjvM5rZ16P1mojIv/qOtwqU
 dWcfBWS1R1ElCBxwmNm+FNNjNbf0k0OOxL66KdFXQ/4qtN3YvuLTxKf92 w==;
X-CSE-ConnectionGUID: OMDX4b/KQbGP4oD/UEX/NQ==
X-CSE-MsgGUID: qagUGob7QHeUBiwZOvcUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50175869"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="50175869"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:59:14 -0700
X-CSE-ConnectionGUID: Nxf/P0hFQaeB0wymDh+OZw==
X-CSE-MsgGUID: 3YB1Yx7RRDOgyObGwRXdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="186161651"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:59:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:59:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:59:13 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT0e3d56EKPI6PDNfh6BVl2/0d7AAFw3//0S1haCQhigwZNhNcrNn2T7FQeI/mo/zOA5tRBy7/oWCtL5JamaxJe1C7qpFSUQsArBFn2TpIaXtRPXltx8hzZs2MIg7mATplDyQcjDwz7KkCYaWL/MEBkSSPy+xXk9eqH/dcPXUO5Oh0kVm6Yqksp2FQw0YGpy7QgvSTYgqwEWJgBsMTZqEr5YOI0p+1LLl6toHn62zSBY7y/rrRJsBqKoNa4qySF72GJoEsFIsKN6m6wsYSpjY9ef9i9ZLPt6W2lIXIIAoaPSHMRZLEjf6i+BZYv/jeydNqSRgq9l/dN7byjVBcV+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+uu1Z7qnMe90c01hdn06wngJcFLTK1bgmEijArsPw0=;
 b=XfeHInWXm6OJkZPJGATcN6p4WgKPUKrJP7vmL62ExOB4WjCfIWUq95oOBxXnfW9s1+9g1DeiY8BqjfpDq+UCjObBV1ZOeaNYtmb8dVxNpP2nQfgiu5NrnFNxSXTrzAtILbhGCEJDrXKDD0LJuV7M0jXvbnCbF1QYYPZX8AknXWPCgwj0g03Y5ZWUgoLUK9SgZfJH1fdAwwYmc7pv0TZd/dFblD/lizwaJdcRMWVbjG1BHi4/tZGBMIYL7wLpJqSk4LJCyRSf4t10cQ1RwzBQUqyYyEG6hIJ+K1WprTT2vGij2e53E78Xqlc86i0yy7Gs8p8iqBJUChdrYVlS3t5/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS7PR11MB6175.namprd11.prod.outlook.com
 (2603:10b6:8:99::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 14:59:08 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 14:59:07 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 1/6] net/intel: fix Rx vector capability detection
Thread-Topic: [PATCH 1/6] net/intel: fix Rx vector capability detection
Thread-Index: AQHcPObx3iRpjkdhD0Op6p+ErcsHBbTBsGqAgAALxhA=
Date: Tue, 14 Oct 2025 14:59:07 +0000
Message-ID: <DM3PPF7D18F34A14A5A5D3521477088BD6C8EEBA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-2-ciara.loftus@intel.com>
 <aO5bM-oLUIj828GQ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aO5bM-oLUIj828GQ@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: e064da40-4cd2-4565-c5ae-08de0b3239c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qsYf1rdtdtzsjQqkrH3A4+UEKvDZa+ygQWih69lBnrrkzosxSGN3SfStV0H0?=
 =?us-ascii?Q?HIfpWynCnjWzxMsaCr8hAc/TVkuhrgtFilswi0Xxt7lhhL9PFscszlZvOX62?=
 =?us-ascii?Q?xgbSmtntsgiP+fWZ8Ec+oeWgPLKVMaqnpEsRPN02WVpENLaiXIKewZAcTF3a?=
 =?us-ascii?Q?1s4tuzWhVPtjKT4K1aC6lQXkOwMx/SrfGSxbt3nLv8qKOLh8GQf/sIplS/In?=
 =?us-ascii?Q?MPJDcU1eVSSy8mQvss1XOJtAQ9ggTlQhu2t/GbzfMk4EuOWk6QIGa3P0uZPP?=
 =?us-ascii?Q?+wqDxhAsUj6o0GuE36ooCu4+ABqPG65JJUwkGaQxh51Qhj6351MnjLFC85b7?=
 =?us-ascii?Q?3Ld9eSLinQ+URoEcPWqhAZjkyz9uMwA+Am/Qqx/P7KGIDi+ywanWBQj/RzAG?=
 =?us-ascii?Q?5kFQDcjdnp5gNcjonuDO5pZi9Jj4/Dviw7EziU+DrN4eZI/oOYREyO6u96pu?=
 =?us-ascii?Q?4Dse2kSLjt0aVUFIOL0XcJr8VAt3jSXW1kFQRN7Jj1R91QyKTR5I/2zoi/ha?=
 =?us-ascii?Q?IBirfEXNP87rvIMapaTKlkfa6dDmz0nhoQYg4YP/yefaQoYyKnLGTOLjUGFa?=
 =?us-ascii?Q?YRHNwOyWsOi+dNEeVTz7FuqoyV2BEZSyyTs9DGDyTnbrUc89o5eJtWPxS1uO?=
 =?us-ascii?Q?8BqIMBa4iv/ls26YgxvZhpPjWnRCxNu8pOFYNhrz7XoF4SyD0MGZsm3u+HMC?=
 =?us-ascii?Q?5XAKm1LTimiOWpFK8iAC/p4z5M4F7R8ZFxdmuKBL52wKEtnl0yQj9Y7dnlpI?=
 =?us-ascii?Q?gTGJxtkWvdEhnFabAXnlaV3EuxvzkYoIYLUjU5qhjatoDqek92bvawstDPVK?=
 =?us-ascii?Q?VjhD4yVXYJnGndFUaODucyQrFKsPV/2BiYsxZ9gtC0uMIN+RF752LFfYNJhZ?=
 =?us-ascii?Q?8nHMZUaZjn99rJ/2XR3QxQrOgF2r+GEIO26dK0MV2de9Kowl9gf3cnjYldfs?=
 =?us-ascii?Q?NAW9YXbOQZV2a4p2GSRnlXnXSB70RF3HO/ZonGwkyJw0r2WTDBDgZuvtFQGZ?=
 =?us-ascii?Q?RaaCfphJkukazksvOiIC5dGADmA/YKuLbTaBeGNc4eNdl9OoxETt7FjHcgCX?=
 =?us-ascii?Q?XQpbU7OvacNwr6jIy5DF6lm2bfsJ41g8JF3QiOOKJolqJ70Ppn4OspvX1Ho+?=
 =?us-ascii?Q?dvJHwwMkrnyc0dSll4ISZOO98MYPAU673LiROj7TLOHL8mOXuTiTdienEYzG?=
 =?us-ascii?Q?fmikNBWUGwW+78MSZPPtKzdZBdNs5G2MbGSUn2+UlOSf5t8WJl2aoPjHT1zW?=
 =?us-ascii?Q?AB8X5ecwD93fBJMg22TeuqgynIRpqXYDFq0JxRf4LQDlwXzAStYmXf0eypIl?=
 =?us-ascii?Q?cV0HENkuxm4dX0PpYlvwi+4eyiCks9fTaBFW/9IQ/nuFlDeer7VLrThrf4hL?=
 =?us-ascii?Q?zBHhYYfss/cXm/CXAVYL1Vh9NR67Nlyp/tg14gk0YKVGDMzN76GhBAH70Khl?=
 =?us-ascii?Q?gU8vf5xHRaYX6oJC/eIzZFPNJ4BP683RhO9Lfyi9awym0lXncrpVD+azel2f?=
 =?us-ascii?Q?CSgE8J8ZVLHFRfIIkBcq/5Qy9J+54e9pYJwD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4hPvTSpf5IMOJG09ojk6fBbe/2r7RK4yxQ2EgAxGG0Y125jl6RUt8HLblwr?=
 =?us-ascii?Q?I7+8g7bYkZUG3FoynoFC1KuQBIy4Y57PBDhnIb9agov1Fx5Bst9EuaeBpcLU?=
 =?us-ascii?Q?xP5Qgwinty/mH5ufTRc4igthzjgWIt62OWb89HLgdvWsoR/cEZlHah3f1D0B?=
 =?us-ascii?Q?4ZzV0czwoa1t0moNla4pq8NEMvJlbNFeoSLFe5EYxbZNC5hQo3YBmSAxUSuY?=
 =?us-ascii?Q?Krh65F9k9WZevwQjGXZh31VayR/61du9MJhgyzFTV3jJbfVzMSVYkQ5XJJW2?=
 =?us-ascii?Q?qLc2lxzBww2EdK4wAEppPJYnczACFY0Y/yBQJQ9uXcg2rJva0rvxZRa1C2Xg?=
 =?us-ascii?Q?cEx/+QDvojXUtAlUzgWJPrA+xg2DxqgzqoPCbD+ZGonzpp2BuqapZWx/ys3N?=
 =?us-ascii?Q?uAta580GqdwtMwVx08VApKFlzowEQ+TlutMF3Vczuplm82HILhFFHzZ23zer?=
 =?us-ascii?Q?dGYHq+6ZOLC/3JAnIbKCQms74CPdkmjGKiuPgMRkWyhnoVEBdZTwyEYx1Oc8?=
 =?us-ascii?Q?aqmmUcMaAN20wudxrJi52d8a6+V2/wyVC1CgHtmmG/WLp+u4pSHA15DmXmXw?=
 =?us-ascii?Q?FEdgt3ZrzNJFbypmqi6b289T+I9z3rKEtTMEMzoWFIzVhkCsGOqhz74/JHaX?=
 =?us-ascii?Q?6Vj5CeFeyGLvkugTgbHldWvPaVSFVlknEqNZiHjkaJJ8VRmhSr2QylPRKsfA?=
 =?us-ascii?Q?21bh8EwjfJNRjg7wAZoCgW7fnVXrbsBFSewOc3WG1mEO0s8MJCr+MnGCI81l?=
 =?us-ascii?Q?c9WTgjTv2L7TcGR2qNUt8AFsvRXSTcCCUcbHExGUGVa6aoQiAsvgM0BnZdtp?=
 =?us-ascii?Q?XsVdNnDw+LDImGIpSon8Ff+CWq4kOL2+1krVIOtSqSvuLWi/PIEQYSTD7p/p?=
 =?us-ascii?Q?xgN3zaIy+sSVyvsJ+ZmHOO7UwyAFaWkjfDrDYPuFyDQWfOoAqi66LNpTlw1w?=
 =?us-ascii?Q?m2/z7KJ9N+lvTGP8XxQLYvfsBg+n3DxlBdx4YqwX9Dg1DyVl1497HmWjFDed?=
 =?us-ascii?Q?lgGlMzA2TTgX3yb6VAbAVkGJ7h0DGcoEWRYb6lEbxZg0sD2WI8Qu+P8Njp9N?=
 =?us-ascii?Q?azPnBMMzobmOOUMskX90mDQKEfjD8+p3JR7GCfrevpRm8DWAIojQivl7gRtL?=
 =?us-ascii?Q?VqXv27RHJIOxz3d7qnOxzHK03/MoZNSfG9SXH01IBsd1hahl73TbP8GJqN31?=
 =?us-ascii?Q?7q0e+9jK+Zg+sNmVAjYejUfQB9Zu4OI+IxMEUjSuvw0iLxvS+WTH56oL3stB?=
 =?us-ascii?Q?uscZ27ELjtWkWi0wg5DRJJO7nsfS3pwqOfQc+YS0k3ED+wiI4E9Pvmh/ZnAY?=
 =?us-ascii?Q?SXq632Ygfm5gplxz2C6GYjLoUGGb4dSJJADUvSTgE7QQ0SD7lLj1kMrm0NDk?=
 =?us-ascii?Q?+AEie/b86VpVS/jtMopyevv/RbMqUZYpb1TBsGlSnojFS4MvenUvjOslY/SI?=
 =?us-ascii?Q?5XeeV227RoTRbN9Yv8pDcqR8UOPJIl6b4eJoeZsndYn39kEI6iUTSvcT8Su6?=
 =?us-ascii?Q?8s/yOaUtA7ThotrzY/Y42mmO0+NWfS0Otg3OT6L2+h7Kuv6fuF50QOkZQjxn?=
 =?us-ascii?Q?U+NdgKWaByZXdBAhqvrRbYWcUnRky24lfbqTjVn4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e064da40-4cd2-4565-c5ae-08de0b3239c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 14:59:07.8561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXt2XrNXEgWKMUfCQHPCy71kO82FBdUl4NQAMMRanyWBwaf10noMxr4sPAgdg/MOSfyGtGYRabV1mjY22iCVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
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
> On Tue, Oct 14, 2025 at 08:45:12AM +0000, Ciara Loftus wrote:
> > The common function for detecting whether an rxq could use a vector
> > rx path would automatically disqualify rx queues that had the
> > timestamp offload enabled. This was incorrect behaviour because the
> > iavf driver which uses this common function supports timestamp offload
> > on its vector paths. Fix this by removing the conditional check for
> > timestamp offload.
> >
> > Fixes: 9eb60580d155 ("net/intel: extract common Rx vector criteria")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/common/rx.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/r=
x.h
> > index 741808f573..d3e4492ff1 100644
> > --- a/drivers/net/intel/common/rx.h
> > +++ b/drivers/net/intel/common/rx.h
> > @@ -235,9 +235,8 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> rx_free_thresh, uint64_t offloads)
> >  			(nb_desc % rx_free_thresh) !=3D 0)
> >  		return false;
> >
> > -	/* no driver supports timestamping or buffer split on vector path */
> > -	if ((offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) ||
> > -			(offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
> > +	/* no driver supports buffer split on vector path */
> > +	if (offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
> >  		return false;
> >
> >  	return true;
>=20
> Given that we check all offload flags later when doing final path
> selection, can we drop the flags check here completely? Just have this
> funciont check on the non-feature-related conditions, such as ring size
> etc.

Sure.
This function is used by ixgbe which doesn't use the common
rx path select function yet. But I think this check is
redundant for ixgbe because it's not supported on any of its
paths so initialisation would fail earlier than here, during
dev_configure.

>=20
> /Bruce
