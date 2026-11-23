Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0DD606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GemtypIP;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LeSWIrO3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522074027E;
	Mon, 23 Nov 2026 17:53:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 1C0C14027A;
 Mon, 23 Nov 2026 17:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795452837; x=1826988837;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bTEtfu3iRrgugNog9Jo1baj3oFTgofzf2eZUYLoQbek=;
 b=GemtypIPTea9zaU1e40/KQJ3xJiU6ah7ORb0VbsyjQ9xXbkrx9vWo0wH
 AAVZDAAH1MiigbihXNO0a/OFbAMb+jV60ylti9Rs570NBy0btOcNaj00e
 hozzE539cN3Ja9BHTPtLyCGV8JkZf0JwFoqdHxIcR7GTvyf+KViHv2uVG
 0Uy35XGMHEuf7IO4SWV1T01HCe9csUWg2F1jZmv9JleVqbnXBCsY33/WU
 QLQtbzBbYnleclW5Xt645cCOVEL4NL3o8XiFHHf+ok4ZPWhlJAJKLhzVj
 xr5i2yAo/K46e/Phj7vPnLwLHpBD16Lo6xauHy8opD+Gj0+mwNB4USiwk A==;
X-CSE-ConnectionGUID: vZSvcZlCTOysGH2iby6cMg==
X-CSE-MsgGUID: e9IQ5NiSTSOC9h1N5+Go7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4117785"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4117785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 08:53:51 -0800
X-CSE-ConnectionGUID: MCX7WJ8nS5aE2dfwS9yg3g==
X-CSE-MsgGUID: SnqbzZkGRwO/1Uw6900gEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11501150"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 08:53:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 08:53:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 08:53:48 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 08:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi6/Ecaa1KWRyn7ISk2ofa0X28NzONKRT4CLyzqwkQQXtoh56IlK8tajcjYadjcIp64lLzBw6IInBLv99lLEvVLsd8nsBA5k4X1bqEEexYN/1mPUJX754R/LuiSpJ1vq8ts/G60BLuMrMoBQmJZaJUkqaS2+jXcOmBk/dSIiwufsZG00VZihEfprbEMO5HCtbMcNx5Xex4BBPI+xZiTTB/aKnLQ+A/WvJCfx5tiUHubt7svrqHROEp7RLKjuB+vXNR5DQ8oGGmovyldQuQHE90kzXSHpV7cXCqQAHXA0VjPIHJ68WKRQs6B+j5NJQa+5uQQYmNlUM1QO27QUJaG6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIG5icSDVtwjGHSt8XT3V6K+PQ27C6hvSrm4LHSCmOk=;
 b=QeQ1ochs6vpmZdyA+69H18urwm3Lqy/DNiEnARTAA7VifeHmkg2yfEtvt/yoGuNp4BIJ1U4xOg56FJl1vbarWHARnkigQqgickYFbXUpg2uUhtu2vqRce5Pjmev3V7F2Nkx1tDJsYWGA8SR8GyNjAtPiOh7EkI8Z74Tfjy7q8Yhd0zWml26yiXmbcRl93evPCXSyq9N0cCv3DYV8rxzjCiNmOw0m6XMk+KG5Tvw3RqpOfE9g7gLhHPuwxT/hNbqvrKFygOG4KP0dPZqpsgJeQIEtHY7FPof3go9ylW4+k2R43Tb9fFhjnE3MbRxrLHQlkZU9kfp7Myq0gl+E+no9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIG5icSDVtwjGHSt8XT3V6K+PQ27C6hvSrm4LHSCmOk=;
 b=LeSWIrO38PZYhrZZsNf55IKkY7dv28tT0WtsAOlxrjv7Q8lqewpQPVNZfvS4zkQ8v9eop/A7WaVn3tEfjKFDw6t43xi3Z4yhLxdt+ZEho3AgMoFIkw5ZKUDtULLZf9nLgjI5jXcSuqOjhrSnODpx7FfP5justPuAh0WfwICycps=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:53:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:53:43 +0000
Date: Mon, 23 Nov 2026 16:53:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] app/testpmd: use burst IO for IEEE1588 forwarding
Message-ID: <awRvkp9PqarVGrqF@bricha3-mobl1.ger.corp.intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
 <20261123122626.2253504-1-bruce.richardson@intel.com>
 <20261123085050.75d472c2@phoenix.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123085050.75d472c2@phoenix.local>
X-ClientProxiedBy: DU7P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5354ed53-db2d-4f49-e5de-08df498254e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PajEiAsbtW1Daq90rbR9wQZR8HEmMP/AV5Jwma+mo3ECOMpJ3rttQPHb/GHoYQe688nOeAOLDZfT550dgykMM41zU9r73DOFI4WviVo3kfF40P0o7c4ckeGGdDIGeF2Kk8ulK73gWwKBdPJ1zO1xV9MPioDPhwMG3ZyBF6era2JzOLiEYv8n1uslyOLVNUeNPzzpEFlUQM0dVWLlq9YnImeH9jHAIXngBZOgJoNOA6Eh4/fwNfT/zQ+7keXRLtB6sW4phTASlbAY2JGVoeN6owCh/uG/UiZeSR8c2PcarzQrjKfkJjclGoYuK2SqSDSut124PwDDzRABXkXcUxM/wVZAS7VblqFvavN3pmzMdZAkNlTkJULyYLB8gdNzZRDnFUKxl5FckSN/iGZ+d90OmEq8+WiN9eQxZx6LJl31evs4Nd5MYO4D0Skb4ia3DpaUzDDeECMFCPlLwv/ISowDsANkoa4s+d+rzcGTkoOR1n1efCCY1j+kqeMVBEFz6Bf70svkKFgUvBECD6sy9oMsR9e/slH/mbFMysfhtze/aCnhAOKoGFD3w0XeX5Tbmq7zqsoKX33Em7CXj5zv+bVEeG42xPd/2f6pAz1Cl4OW3ODgeK3ri6sVE3LevAYZYKJRzZ29R8qfQBQsEbtREbXZAqDB/mPUYjbzc0A9NXilbe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lrC37qPbTcNqAkicugDIIGOXtxJT3fXOtFSVOZGZBfNM8KHFO4Xk4DQsg7O?=
 =?us-ascii?Q?rLRcfCdWoFzeP9HanTL96cQ71cPigaqxJVfCNHrmf+DeGOc3aucd623OvYmU?=
 =?us-ascii?Q?DHvJfc6rdwFdr9/1G9Fkj2NSGvGUvbQBInx0etLYXWhBgWfhHpB0z+idYaLf?=
 =?us-ascii?Q?Po674v8FwDk5d5pBsuJMgRgI4wjaMqiPvgafmBksSS652H8Y3gX6Vld3s2kZ?=
 =?us-ascii?Q?/axIbpIP9lzBitHS0IvpI6Zp8SdmRKa7KnLRj1QgjDNZ0uY0A6U2ltGFaJfp?=
 =?us-ascii?Q?vO/SVU03dpqqSmmkiTSk+SrAih/eZBTYM52aL8uHvpbbEF+9wjhg9pxNFvwx?=
 =?us-ascii?Q?hKVevLHC8Et9yZmXR710AE0IJPSOPiVOKUnLZAW0Ub5CGHxZ/JHEUv78H8dl?=
 =?us-ascii?Q?NXZe83BxPS86fM9LJBtEAmpGFbgjMTMGtYkdVRnAQQeT1CCqAuSbnNl857ML?=
 =?us-ascii?Q?6/mj1zvgqcTrD0yf74PtppGsFyQDq1B/QpwpRvAdWpTUA4byav3Utl5O88wg?=
 =?us-ascii?Q?54v3e5YqpARFKCipXJI1RWsCHoMlVyQaNK4HQkzqIbYJdEOVAvDmqNg4WWrm?=
 =?us-ascii?Q?dBKl4aEtiRIDHhdCAGwIC2uhdSyWvU6WxvGHUqbNDjfuk+Hq2+vC+oowoBLV?=
 =?us-ascii?Q?z5ezRqb/28QNvErEf5sq1AdpyE48Ns6jIkiGhRyVERs2QUBOL+C7Ubgfj7bF?=
 =?us-ascii?Q?AUWw72uKOoLwSExJQGx9g4dWlFEdbN213gGnwlteKADjZ3YWINnHjPlwv4sI?=
 =?us-ascii?Q?sju5EVXCLAYKs3gP8GXYUzq9MiRutSsebLZg0Wm0MYnRvKASdtKO31vByiKy?=
 =?us-ascii?Q?vo7pbkG2Arj+eKOXqUH27dryqLBNeUz4FDnu7dw2JttmRyKaYQFjt4Yuneds?=
 =?us-ascii?Q?GSUZYZRO4YRsXXmQG4jTeNvtW/nWQB7VeIiaP6njomgFFYy0z56kRrizV4mQ?=
 =?us-ascii?Q?0uIYsVNyjiyBpqZiuwWavsuUxS4+XRacKcQa5uEUxaTw5b9yH/Ya6OpjgjRM?=
 =?us-ascii?Q?BvsiVcvs6de8KWi4e31KRubd6dnxqlmRuvrTgqA0XlZwTtLvK7fem63o2h3y?=
 =?us-ascii?Q?vhBoWhN39aYxmCm9CXHFpsqEvMTmzKn1VlBePqz7+WKELb5e3sFfKIaNkFUF?=
 =?us-ascii?Q?Qd08FFwH944YhPoU0TOT5V9sYEa+Edw+7MwYdGKoqDr0GRB3i1AOiAeTm8Mg?=
 =?us-ascii?Q?7nmR7kVfvKob3ceq7OhGEX9AXJj3Ac6VZAKnEaBuntrHdYfmxQqaOK+mabtk?=
 =?us-ascii?Q?t4LEwIhS9pqHvWahv3w/lpvZzv086WXnj8eP1K8F7Y1DS6JREJSJ/6OziGMl?=
 =?us-ascii?Q?IJBw5d/oKschmJibw9oTVRJ/CpbABIDz+/u8TPHAGWycFfvhzgKuYz0I2RAl?=
 =?us-ascii?Q?fxBIiR/p2mZdop86NXQR57kAjS4Pj3O3ST3AkbcI9TFNyNXgEniESZUvmRmT?=
 =?us-ascii?Q?2MWK+aQxPCYYv7M4YoSJnYo8/zhTeVVBOZGHcCXYWcsVVP3mAgQ88y4mqe+E?=
 =?us-ascii?Q?PXjRmiwMGDzPUFm8wl1o3VPuGFTh/dpohe21cCRBBtE5Khyj0eVQNNblcYJC?=
 =?us-ascii?Q?gClaFod0c5CVtNw/Gb2Y502LerAq1uhluGyj4i6Fot4UDVl73MqtWwJVPjsz?=
 =?us-ascii?Q?BoxUROJVdVISQWt9IBF8FkXZi9D12a/R8hIVLPj5exb7aWbD8RH8Y3jzQmD2?=
 =?us-ascii?Q?I52NE020AML4n8H2O6KVHa+hI0+0LWsVmaP/cdGjCdmemLQ+jfWHFZ3AO2T/?=
 =?us-ascii?Q?R5bBc6KNFq2U8AdDNBfrAXywbmhZ6bc=3D?=
X-Exchange-RoutingPolicyChecked: ajEilYTk28xSV3kkaAermb+CABckF6y93Mmf3dtUlmog5O4b82DxvmdbW/K56/zdapObEP0qh7qOtWCygexT/uRFZablCfh7kxDdbycG0q6DGzcUD6gKhKg+ZXKUmyI+rCT/aiiXshYjC1ixUa8e0UncM4mmy1IF2nHOCpGPBa5Wbu6eHnSrxSwX2elDbNF+aXQRvYGObCsNWlI/A2GYg7o8fmi3+fpPjWAc4bEA4iq3dFE1Nl+OHluMBfkKKLg1ebkvTn8YoouoUzLa8fqhUYW+mAJ1xlqgSMe4CGZ5RnaQdOF5/tM9IIQNd6yhOkiPiHW/olLTbbclY8YQl+XoyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5354ed53-db2d-4f49-e5de-08df498254e0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:53:42.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z6freso4lH/jXIDuQ2zXkQizWF4P/DAQVsbXOwsn46yh4abfanWjmlqyPN+/gOZ4i127ash7F+Z246wf8FgvOHK3cwmK6E2uY+BDml/3yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 08:50:50AM -0800, Stephen Hemminger wrote:
> On Mon, 23 Nov 2026 12:26:26 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> Since only called here:
> >  static bool
> > -ieee1588_packet_fwd(struct fwd_stream *fs)
> > +ieee1588_process_packet(struct fwd_stream *fs, struct rte_mbuf *mb)
> >  {
> 
> Make it void not bool
> 
> and drop the cast.
> 

I thought about that, and thought it best to leave it as bool to allow for
any future error checking we might need. The cast can be safely dropped,
but I think some form of return value might be useful from this.

> > +static bool
> > +ieee1588_packet_fwd(struct fwd_stream *fs)
> > +{
> > +	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
> > +
> > +	const uint16_t nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
> > +	for (uint16_t i = 0; i < nb_rx; i++)
> > +		(void)ieee1588_process_packet(fs, pkts_burst[i]);
