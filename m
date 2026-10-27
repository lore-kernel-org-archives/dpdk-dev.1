Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1D606C80F
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faFj/YNC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 717B8400D7;
	Tue, 27 Oct 2026 16:47:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 4059A400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:47:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793116028; x=1824652028;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qHy/ry5naSiEpkj3ykrQawfR9DJEiRy68ERn28MrsT4=;
 b=faFj/YNCMTyM9QN2b6Q/WU77iyMVJ5NwtUkiALP7whbHpWXsy9K0XnVW
 pXLDI9ibGDxs/2rQALkk8CB+GiYqXAHYAe37kN4ITBY3zfPuIC0GAAvns
 esaYmU5EFU931oEi/keZbe9xfSwn4juSoVJ+4OwcX7MJMyDZ0kJKjKFPy
 I5x5+bKZNrlDOdyxy6LOCx3sVH+Xurl1twMz5Ro857VQ7uonlFFMh3c7k
 hSQEMDp3/SqrNZ7mt5o/IkIzbVWRbpbeO6FKX0hhPJiOx/szrCJqLoC7X
 7ZrdLG8raf0fKfVswGNd0C29o5mlnbFiulzLjwcvrl7ePQ9Il46/LkYmE g==;
X-CSE-ConnectionGUID: 20agWAIjTw2s/bNcdYLcqA==
X-CSE-MsgGUID: n4AqPFDAS4GoF+Hw+zeCTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1843851"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1843851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:47:05 -0700
X-CSE-ConnectionGUID: +dnkCtQUS4e6X7hKKYjwAA==
X-CSE-MsgGUID: 7lpiVIGHR2C4xLVEPet6Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4476683"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:47:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:47:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:47:05 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJX8+laZOLGA0NN6/uI99Dmf0SfmrbARyJ2U18uv46yXdKy6z2i/rX53+BRd18rshc/3l9yNhc2pg7HtkK6WoXCdirngoQTDGXV8MBj5H61zde9EvAC/Ut9z+C0G2v5X1U/oTYjwsX3pBX4x5yMs7uv/8twWmXp13AfYhiq4didwPSMLNMpXTb3CF+O4Rlz8OlRtlMBTVaD8Hd7UzcJMz7b5QodTwu5NsCsDy2LKvFKHOHP71sT9AKAKG+3mDC+oNVLAVnIKgUMHwdaoSUYRf6gJOucl8/NDQrzlCNkwUCov9fTKeBlnX+HlQoU3pH0cmcwCg3GcZs/0VOHg17OX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHmT2S03D32M9dWxPfHHpCqHPUzqG6dVmPdWqevobSg=;
 b=uufnYvD1zecaLXE7eoKUVTwkf4L1QohMi8D6BcsPfBzg5We28/sK77mJEVBktJLm0A24ung8HEy4fkq2NKghIeb67p5Hc6fJq4GzEBLmQi7M/2j7oMquVECJR3WZaP49PGxX3ceTjwui9QCKUBppqCMn+8PAd7w1bQqSyO3OQdPxhYidUb17UmhWUfxmvOaLcadMltUnIAzhTp3eoD0ZdTOWvaCm6uqPUeKU8L538VYsgiNW8CpPRVgXqK0CoHhLpc+MZCkrnIGhRfSwmJBB884ZBb59cGFPoeATXIkbHM2gv39l++N2c53cm4NpER0kjZt0P83ij1Mv5E8axaZEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:47:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:47:02 +0000
Date: Tue, 27 Oct 2026 15:46:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix MAC address removal without VMDq
Message-ID: <auDHcgAimL56mUIT@bricha3-mobl1.ger.corp.intel.com>
References: <20261027095832.358077-1-david.marchand@redhat.com>
 <CAJFAV8xHTKLFB-AgN5iMhVf5bhHk6qoGW82dpCD4MEYfbgi9AA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8xHTKLFB-AgN5iMhVf5bhHk6qoGW82dpCD4MEYfbgi9AA@mail.gmail.com>
X-ClientProxiedBy: DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 445b2189-ef59-4b5d-f3a1-08df34418b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: bBuz5XDUAbEQYnAG5JhIYU8+rmfczxb39A+3S4qx4pJDxX2K22FthakBS650G8oFkZeCN+WiNCwAxxlY3zZcpTOFDr4N6KGTwPlGnV7VHtB+sH3uzqS7O2TjuZAqwdhrOLWUnaxC29ND5JZnW5e51gyDh9JrXJduPUd77uFIfdN51TSPpY+dmU/BpvSkvbsv8TjU3HSy3neUzpHWjgRlclZQOY9YltD1WdQsfuIq6Mp5w9leQZr6qoYHDTvQHaoWvz+y/ZIWwwlnxLOfWWGFDwnxZLTSSNiY9PLJ1QK/gmr08y7vMqC73rkUur6vIHZHu6Olf37YstMpSXbOTMB8/XTP0/zZmK9v+D/dK8MDEjLR1kRUv+V2QRUIZ20a5795BRNfhi/DZ33BlAxxGnLohpkjC3b5bGcb+UwYMZHlmxNOMj1p9NStM3ZtU8py60uq5TK6iWp53towZZ9i6rQnpCRVwlKwFSVoixWEYKFoEGUfdRhZwEZx+1MqwuPdwA5IKMRu/1+HAWau09nOS9xeWEMgtEsl0wVq0+xXqiE+B2U4jUqsYLBCEOdbVqQbbbv5RUDD6CSRkjPGNv9oAxcXi/NGM4yfTz/zn93m9Y3C1ZSXQtjDvZxB2k48lg6vcIi1t9sUdxEK8y8olh6WQxnlu/2/o0WST9YnCreZjdYlu+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?idU6EspS5Bj9kIQzZUgtLnb9fQGxouUMjWsKRuG+AsC1JdNsaBT7sDPSsdlb?=
 =?us-ascii?Q?1QM9vHIsHnelMtgdTXM0vbtNOmO2OPeVtY+PUmUH+c1MPyMKR0w/ZhTevfP7?=
 =?us-ascii?Q?7sPX1CgSblDwpSqtJyLywK/r2r19i5YEmu3yo76+K/PrqiMsyc1fNbieNZdl?=
 =?us-ascii?Q?jX6pGjWsCgCpwzVF8c3KMQAliWaMC7OvuPJ+l9colf3xfF6xkE+vOXlAjqgp?=
 =?us-ascii?Q?RvkipmdCpRcg0B2ViVDgeJmoOx/Qh8eSFPNFUxRDgaIpsZkPTX2dbDCJX1hG?=
 =?us-ascii?Q?g1JuhSHbpDnQJyWM0Kl6TmV1aQ2UxpTzMPIDCrFvAI1y2LicIsUiyto0w5zL?=
 =?us-ascii?Q?4psv43GG5n8iHvVJ3GOdZmngY/j6zZboZF7TJbgkDCYus6AEVok1Q4QGBA1m?=
 =?us-ascii?Q?nKb9v4ZAU7Ezb8LWdkzYO5OdFx3AhPBafqdPiO+OXGrxCyfmIirLBUDOs6ZJ?=
 =?us-ascii?Q?iJbTzAjEUq6TC5DrLCUr2z67O1kavgQKOMlrfHn+Qpld1yd/yWPd4KzvxWEP?=
 =?us-ascii?Q?0e9hSImttDq5jhODAWcXp8gn+Y1i8gvH+2mFhlnNt412SHPh59Qtl8fdPzdc?=
 =?us-ascii?Q?XfEl+1ae/d9yZUDZZJf6dfAtZyIA1BwAVHLagajctip7OIGCLUTbNdzCMGJn?=
 =?us-ascii?Q?ZAY1lW69mCN97WL03PbAseJBmUh6d9r7wty530SWb0kCeCG6rBqBz98PV1/B?=
 =?us-ascii?Q?9W2A9eML6fsz/FrRuwtqkBRLyfC11n1N3JFkwB04Xa6PTyBFjH+y/HQpphlP?=
 =?us-ascii?Q?S+m0ElU3ZmLQVVxzSmm4zVahpppj8vOX/LMe15bMCOkP+7CssnjXt2UHUjrQ?=
 =?us-ascii?Q?f0X5QNkk8t7tjaprguZPCduHJjQ3/YeMNkm8XePgtjHZjvJA6nuB82sEUECa?=
 =?us-ascii?Q?O1qBcylqBqlbqSVLvmRKTkch+dTEAxtTG8l81g8++j+HMVTyIyrqEdwzwHIY?=
 =?us-ascii?Q?P5T3mCfIBMqkvZ5OD31KCTIGE+E1uU2sZ/GD3EVMNhOTg+IWrh3LfAEl/vp9?=
 =?us-ascii?Q?yZ74cgkiGvTsr10dkQSIZJYJKO5TLIfBdFjo69C/FrGl96WULLdNhoupaHxN?=
 =?us-ascii?Q?hhY2fJl36T2QLzuuWpiwQSi7PK65GLOof1sy8SHtxzLYS1qjGt9NWV6UvZ7j?=
 =?us-ascii?Q?tV4Nle89d2koJDY6FMvbcmKtqrVwszpVg/e4u34LEo0sBIvFX3gA6DWh8vsp?=
 =?us-ascii?Q?7sWB6w3Tq2PskCnSykVetwhFH/j2c+xSgbg3Vz3YzMQQmj4mlFmbfmTemf6J?=
 =?us-ascii?Q?SYx7A0MwRu62yIaClPDmB9g1WCFysgitC7eqdmPA0pMIBFBEKBFQz9q0NgFe?=
 =?us-ascii?Q?ozZ2GL3dav/Z+TpCiaUniE7WezQ7brSM15DzayEAnaA53g0znAH92kxMPP2U?=
 =?us-ascii?Q?plBhOkHIyNDRhJTUFXgSI1LpGXG9ILosqeqUmTA5Owmy4zYYrznMNd6sctNg?=
 =?us-ascii?Q?ORNWe1JWYWLeMbePziXg6HZRqvYCL3IG1qxh5g8hPyMLGM+GVc9bF76WeCQz?=
 =?us-ascii?Q?vZx2MN3YF4wdcKK1hJgzZVx40giuqRqYgCrS57uMu6UY4sxht6IJ74EpsBV4?=
 =?us-ascii?Q?lxZa7H5VLxZ+KolPWrzEERmJnKP8cr7CiJBmYcsYyyc2O3Cp9gNOyOfloOAY?=
 =?us-ascii?Q?hxgdWUztTILL8j163Y2n6y6OUuyu5fmgFV9du+hV2vy/t+L/0Xmf8Kpl63mM?=
 =?us-ascii?Q?VjVE0oiOCWzPonXEObxBcX0tsAHro0hMTNSsiP/grYMirPufBt3bSoLDoX/S?=
 =?us-ascii?Q?mX3wW0lKqSGoaLXfW7BncnCEA7/9DWQ=3D?=
X-Exchange-RoutingPolicyChecked: R97mjCgnBH1MCogehZBFuZYtM6gGgwYpsDfPFoPKdvRlsInwQ8+Orf5Q1WKbApj3jCWd2N/Kq++gjQ1mQwkSqFzj7jODRRp/rVKFIUamW6wFVhAX/r85L1DQ3pat/7vbO55gtCKMBCoOaRuLJZBqrdX40z8H4AeApzHqQNY40nue0BoDk79g4JLT/afVJjJP93nG5Zbq0zSeCyQCw8XeQo0prJwZAmZXBxLU7ooyOuU7h0O5vRtZNo98x4UFUJ3IOT1BSfYbg9LyqAYIzhAgJrl7BSt9+BYmgJNVxTRbjotPxEUCBEZJGdUdapadtMGKw+J1WX3LLDWiGiaWm8Mr1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 445b2189-ef59-4b5d-f3a1-08df34418b4f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:47:02.7235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIOE3aFdGewhRZA7ab4btWGOUaN/3Z74JeQNbDB/xa4BB4NZeGQzFCFovhjMKTZEothChlsu3x5qKRMnMTZmGpY1+Wq9BMFn4sidkbpJ9rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 02:02:46PM +0100, David Marchand wrote:
> On Tue, 27 Oct 2026 at 10:59, David Marchand <david.marchand@redhat.com> wrote:
> >
> > The MAC address removal was checking if the hardware supports VMDq
> > (I40E_FLAG_VMDQ) to decide whether to use pool-based removal.
> > However, ethdev only populates mac_pool_sel[] when VMDq mode is actually
> > configured. As a result, when VMDq is supported but not configured,
> > mac_pool_sel is 0 and no MAC address gets removed.
> >
> > Fix by checking if VMDq mode is configured, matching the condition
> > used by ethdev to manage mac_pool_sel[].
> >
> > Bugzilla ID: 2074
> > Fixes: 774365884bb8 ("net/i40e: fix MAC address removal")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> 
> AI review raises a concern that dev_conf is the requested
> configuration and proposes to rely on mac_pool_sel[index] == 0.
> This should be safe since i40e max mac_addrs count is 64 but maybe
> worth adding a build check here.
> 
> Bruce, wdyt?
> 
I think it's fine. After a successful config, the dev_conf contains the
actually used config, so its fine to test against. And if the config is
unsuccessful, we shouldn't be calling this function at all.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

