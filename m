Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68179606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YfnspEQy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CBD40299;
	Wed,  4 Nov 2026 16:55:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 102BC40281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 16:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793807750; x=1825343750;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2KuAGRMfH8SA4kjxYKdvrYvyqfJ3+an4pCZkW462ExM=;
 b=YfnspEQyFHbGbhDbn3wDo6Jh6M6jucr4Q2BP0mAQvKjz13QlUfl1U8ew
 iuipEucDreEmWvDk2ZC/IYmUumShcDvhFdQoalw2H10LVTe2Q7AI0ILP7
 MZPZG2SSe29pk+cDXc2UB8qvlzKP+NyQ4JawkBydMu3tPLoz1tphyh+Xo
 zY7NrFSpIwvC8hkj7ydh73aSpfr/loY6l6DsG9cG3OTu4K9OHea2+R6Wf
 TcVXzHPpQ+uPGrJ+iaHqx9P2RTT4X+99WicKIEvGOZdIqng8qs86DCzS1
 l1QLMm9YVeEUz/xgUdKj5/gv4kir15DVwid5Ls43GGJnlKycwlgoQmwcv Q==;
X-CSE-ConnectionGUID: ryoJAodBS0GA0E0zxLFLbQ==
X-CSE-MsgGUID: 8j0IkGjdQUGEdh7cwnG4Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2442891"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2442891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:55:46 -0800
X-CSE-ConnectionGUID: eFfRk9xeTa21z53eTZuZdA==
X-CSE-MsgGUID: FpyFJnTdS3a4uhBHc3x4aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6616958"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:55:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 07:55:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 07:55:44 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 07:55:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8L12llCvORu0SgsFtyKZUNp7aJAwyLIGtADC5fLMuIf/kOwUzwGzDhhKBRG26xHseiIfyoQ/Z2q1obhQ9k+M2qgKt1FSWw3uIkPGrxnB+CdqxTOOJUaTTSWVuLeOgOIhnyl3nRsr3j7kRDRAA9fF+PVxYOblwwTcWl3rddx3DZ0wMri6fN1HVZidk6MeTEOQL2U6So1VftQl6HuO/d5gBRRvErvAt7tSX1trG9khQRJeENXEgWHgOhOS9METn1P+4eXjVy5BFJm4THquJYsHKi5La9sDn/q7wfbhsTvERlyff2mCQB3DljYfa/dscL+c8hVcCmZ+xwlBxsyXyDtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeSudMQ+iO2Rb9oxEWe17QoCZbKlnXTK+vu7sMcYJkY=;
 b=glhPYEeunJHsySa3xMsK17If0R7EPiqiLu6/hyq94iA6Nn5dyP7FM31VcDxGdX8+vZFxTif7IeyoWF4db5+Brk0J8BJtlRxySc8qhZAYKWppUapmqvp0NnXv3V3YGMjY7H2YiOJrZtLlTt2A/1TuMUGjnnRk3B7w7zSi1qrKZ0+D5YffYWhvzFw+gOvSlcNj9vO9Wo4YkHhGsRzL1uY6dEVvuR939mxe/KG0WJJ9PzWXk9OOuO3uRIYNvTjbrm+dYeDAaWjZkFxwX1mz5PSqVBZ1qLjs7PBV0fvfQKwEHNYAFl1vp4//8R44V2pTxDPzMUqcWhSphQyU59PCXIySgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SAWPR11MB9546.namprd11.prod.outlook.com (2603:10b6:806:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 15:55:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:55:39 +0000
Date: Wed, 4 Nov 2026 15:55:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/ixgbe: fix EEPROM read callback check
Message-ID: <autVdP_VONKSa5D_@bricha3-mobl1.ger.corp.intel.com>
References: <1877a0177de01bc832f96c8fe99f05fea7370bf1.1793354493.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1877a0177de01bc832f96c8fe99f05fea7370bf1.1793354493.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SAWPR11MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5650bb-a659-47fe-38cb-08df3a8c1241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|261021121427099003|261009223027099003|11063799006|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gJEo4M2qfhw6vslpOT93Swnz9rJ7oDsYpDdVOShtgPRkepM49bbV1CU5F0qhQ3Z6/jUE7L12K+RtPEbyi6DUxBYNdTDaWJzyq2q7wsti9PAgiSg2SojxG0S7b2iJMWNoNlwtXYYMDvPGPSVRLkA+7USMVgijIFnp8cc4DaevX3CSD15dAVMZ3+aNv1Rd3llbAbYfALAv/s4J9h1AaIA3miRVC7Zshe1E0xxeoYrrMZZZQjv/shVXjrtrzpUdf0GS3N7GBtUX72VuQMbRiWBzgMWZwyDutXw6Rk5wK8jw4vVVaDeYLI/7sLxv7M3q+qtlp17nBFFKyH35PfcSVmstpfAV83YR/08ahuzmQzWk8ETByy/En0ayz9NopoKKUcdOy+mClmCi5dKJOexKSVlHva3j/62usg61jifCAPpNgu2IZWA2ddoXw21N9Obc5oT9ULilucDOV0OOcALEKNaWsB3IncBCuTTaPfbxCEGj61T7AvWbwrgG2DJLxiDsFAbR0rp5UZQ3FfXDSfpAttjeJv1shu39TjdlfajQWP8Owh0aSDwx6yI7eG04xW7Mfj4b665QsehRGGd0GjOonz0vMKIWY+yi2CR/GtMWyIGZVuPT8zus1coE3HatLKSJSZaUbBlKXSA8D032xl4im2Ch931msTRFcNwtWlDHE8wlXRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(261021121427099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6kE707dQmR/ORDco+jvzWFH7m11w1LswS98EW92yGbscVpyejsbMpijZGnT?=
 =?us-ascii?Q?y7B7nKzH4tTKIWgWQV9v9JZB76mVZbjt2/y1Q3ENou9AG24BRq9+JHuxUxt4?=
 =?us-ascii?Q?1T3aF20xjS/qiTwvLKjZs5cgDG0K/Rmcx78XG+1VR/Bq10Lgl7zmwitTBcxS?=
 =?us-ascii?Q?wfcurFSOXfbAnBHybxQ1XZGs3vGAqTw9BuAqCrv/OO7/dog1NVGw5ZRAefWn?=
 =?us-ascii?Q?GC/qw6E7EF0M4XIkT0iqhILlV8Oaiwx7E6m5f3FLzayECRlc6yKC7faTh2EC?=
 =?us-ascii?Q?iykYOFN36KKXenzU1x/KnT2Gu2fVSzOhpZ4NsS1eGG2zesJQEk/y1ik0maMB?=
 =?us-ascii?Q?R3CEYbgrlxrBBX5pu9jm+TDfkE17HjW1wMwfOsn/XWrUeWYr8pGcUh9BxjS/?=
 =?us-ascii?Q?ETBFHpXkkPrvO/v/ivW+YaaCflYZ1sEdlmOmjjoZfAo4qBHClP2mZjLBJ2w6?=
 =?us-ascii?Q?cPV3xcbXvc3P+DlyivkqedjSt7PHsuGU2+PdfjWe36hxTtpkED3Fz7hALqyI?=
 =?us-ascii?Q?Ggr/p61qpI0mTyNsjhGZdIIWQpqfueKV4dYO4Ti7ZgdBaHf+lANpdWHQ3MHH?=
 =?us-ascii?Q?fb5ENyal2DfXOuuSajmNLcJLsSdSaAljGGj2jtsok681bjFUIG8sksTp1lMU?=
 =?us-ascii?Q?6kPIWbSJKeG8DJP/XHECTb2se+qkFasNfHwhEZFSKmbsrRZLCr8YTjDqJZcZ?=
 =?us-ascii?Q?icQaMeyGIAzltDnVjP7l1ZLzM7RkjlI23xUlo4vOxG7C2Ag3QRER1mVroLx2?=
 =?us-ascii?Q?OcJYYUfWf0V1Jalt8UgLlUCOfMpequdPeFxMYCxFPqZBM/4/O5HN+w0Wmgnv?=
 =?us-ascii?Q?0g0yll7bv6xiQLu4w9tfHAYGc1cTNKkmgoRfD9oT+UYh6w1r+af2khZmaqPh?=
 =?us-ascii?Q?Usl8Hm8MAPb3TYjwx+1smuVYHczHFM8tTcsvkhpaP+B0ASPkX+/IPbRTB5bi?=
 =?us-ascii?Q?/mJjtJCyfNRN8qkXaSIsrO/L7QXWk91/9nqUvFSneXPr84L1AqGPzW19Ln/f?=
 =?us-ascii?Q?ojeR9Vzj14Rellt8rAQAGhmKKrVLjhgBJjnQAM8vzWLcADPZ6wDBJ9sTGnej?=
 =?us-ascii?Q?yiTvqsGjIbGVAJHfdtRn7rttGd6ZPUEQUz2sX+x3uSR50viNCCJATeZMx/10?=
 =?us-ascii?Q?sNoJS1SbnhDvosqQDWF+EBBPACFamp/bx1AG/15XCj+s+FdEGvyPIVnIHzJD?=
 =?us-ascii?Q?/U+Kvaych+qGGrs38NfdhD5RTNi2/8A7ylRKPMRkoIM97Dsr0Jq1pRspECmD?=
 =?us-ascii?Q?Fb5lTB5KIe5OrW8XzuYAUqC6s+wRqreNFnhfRXbvxzmqpzW7kzFBkmgFZpkO?=
 =?us-ascii?Q?k2+p5J64FIVVvG+tm03WqZUQiEfTwjn6WmScyrBJwG0xxX2nWxMdwXWVPeT/?=
 =?us-ascii?Q?eg6XCTrmK06krFDgtlwaTsCwRTRIz4ThJX4Ozsg9P9pzjwcH0TcK/HUW+nus?=
 =?us-ascii?Q?8dKW6hzADg9YsySLxalzCjNXXzTEk7OkHYKMGH1rW3cU4L9ewBYSGCL0y+44?=
 =?us-ascii?Q?Ex71XyYWMebVbrnEjqTkqxn4w1kDGYBzLzZQcLHy+aiUDCWYC7YV6P8xTPtH?=
 =?us-ascii?Q?xMyLzrcYrjj4f65/emeVsXJLCsFJPAo2GzDXUiZ+WsgwlJgt2NhV5awkUIIw?=
 =?us-ascii?Q?YLQ01vJ7nfsPlGc2Qei8FzO8VXLwBnumTSh630VBEr89ccB9sEZtN1+imyXD?=
 =?us-ascii?Q?AxZ3LrDTdDNeETmV3eLZTcW69AbYT7zBL9xr40OUBpfxJ3n7eqm0wbuzGx/e?=
 =?us-ascii?Q?iPzYI/26ezCwMxJorAugQ41igmVGz0U=3D?=
X-Exchange-RoutingPolicyChecked: WtFHx/aPaDcq7UO+JRHw2bcTXg8rD+N6EuCKMNdiWI3YBCeXi6c0yQBnsM39aNfiHZ29lWMlNNJnkBA6z0dPv7Cv46JYsH65SZaVkaOI90hdYUKK1p0eS5I5/NqsiLDT/nisvi/kjk1qJwmUUjHtNGf2m7JtHcfnwJzfQIh+ahxIB2SxCLHhmgk1OVf21czyw0l40lQagsgLMqRraAsM4D8KKrnG+d7DgaeOHI3FdBYfHngc87PkdMQkYuv2hjz1c+5X9og54jZM3KUN+Wwi14wIYr+fk8gnsBFXa45Nasx0RXb7ndxj0Xvam937PBt1IcWjjz8+O8aAl0hlQw7L6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5650bb-a659-47fe-38cb-08df3a8c1241
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:55:38.8840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXRHUrS0UDGJiva+Zi71g0tmrsGoieQ5N4MeKX5j+xrT1vsBGDYxHz+zOkoVrBl40D5KXfoAoZzv8So8jNQ6LUjTlkNZ9usn6vt6mBNkghs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9546
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 10:02:00AM +0000, Anatoly Burakov wrote:
> The NULL check added for the E610 EEPROM write path was placed in the
> EEPROM read handler, so a missing write callback rejects reads while the
> write handler still dereferences it. Check the read callback in the read
> handler and move the write callback check to the write handler.
> 
> Fixes: 04c3e44b4aee ("net/ixgbe: fix null dereference on EEPROM write for E610")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
/Bruce
