Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93473606A329
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DLWWZLnc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1AE6402D8;
	Fri,  6 Nov 2026 14:26:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 43761402B8;
 Fri,  6 Nov 2026 14:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793971592; x=1825507592;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XrdqXECbIWHyZ+J3SX2MHtBDre9Mj0VYsRJEXw3cqSk=;
 b=DLWWZLncG7rP69UmfIILIWXBXF9nreRJbd0ilUYb/9CrhK1A0TCmk6Gf
 QL59C1ukKfbpZ+FOz5LTK2pF8vksIYHU1Rok+NFc6ihqpFb6j2Lzk7AY5
 QS+xZOA2UpSR0UwpOWMuNkuZt9VYnsHECnlMjVrUu20Yf3Y4n9DqNeSbP
 qdSbBfMFtuE6cz+HvZm+/6K6VUpk0yTO60Q3CjeXpJ4soQcz4MMoUZy4Y
 4DjzdVS0LRBBnVtwTThwJnuOxCm0FzP+xLMV+7a9copAfzBTFHw2x45Da
 epcqWElbO/LFBJ8eDQKLCJNHL4lHy6TKz7sWLiIhWtDEu7AEszBpB8I96 Q==;
X-CSE-ConnectionGUID: QwA+lr4tRLay0y9kvS+Ddw==
X-CSE-MsgGUID: mcdSfzcgQoSC3oK71VDHZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2883857"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2883857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 05:26:30 -0800
X-CSE-ConnectionGUID: +bUBlOVwTSawplESQc79lA==
X-CSE-MsgGUID: ZENojvwJRQyG5GJMm2qHsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7445484"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 05:26:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:26:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 05:26:29 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:26:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9V+vLyhiWk1A2wnKvfJD8J2p3rPVAoLlDI5cSLNH/RdJq2KFD9tMBIPXSDMbFvd2jJJD5MS9KZmenb9VBI5YnqLg8IJR1+zWKuYoqhTPZ9RmzIsDyjeILZx4H8e9NInjbB2OBLDP4hvbnj4Hp1o45/1NhdWKmD2FDt/1jKjf4zZaN0y3tSiyKq6UbYKNC775ceC8JhmqW1VBBZVNhdvsN0hcUJlyF3sa6ojjNswQl8CjjtbmpJoFt88KeFnTTLMNbulJM6yCSbCC9+a4D49fPzmI2jX2wFIn8q98IKSyESEfzn5vcUNHcdgQqsazdr5u7sPTSIhnzelbh0H+Y1T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5CyW9dxx8LVxJ8r8RL3FYL0vUauUqFMO3JUT3HrpzU=;
 b=kE5yRW1teL9zGdfv0ICtx90rOZnIKH+1NqpDmMK5yuMEN690fI2HzwryE8jc8wLr89tEwtC6zY0f22Wie/8sXt4DOqOp704cbRx1D9pZ60T4K97HdGsBEt/GgMaE5m7GhOTgrX8kAgK5MgagBGvNnwuqxD3vUhguKsw0/JZ4+BZhF9T32OKdwBFIT2MI0dGDJS0hhH281dThVQBPUByyB7fQwxM0Ev9PnW/scUWDfvLMxoK1px1Gq+GkQN/VndOg9GyJJSw4nbmX1UypiX9Y/2wGciwsTGZ2D/0m72NjQwum8KSchRr8+bVs1OP2Ofqyt3FY9WV2vKq1SArJiwjjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 13:26:26 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 13:26:26 +0000
Date: Fri, 6 Nov 2026 13:26:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix NULL dereference on ACL init failure
Message-ID: <au3Ve9mEk-XzjFn_@bricha3-mobl1.ger.corp.intel.com>
References: <20261106063949.654513-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106063949.654513-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0292.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b35659-ea35-4c22-c704-08df3c098edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|261021121427099003|261026140227099003|11063799006|261028144727099003|261022105027099003|261009223027099003|261102123227099003|56012099006|261022113327099003;
X-Microsoft-Antispam-Message-Info: B4LhjPmRsd7qx9ZPxx7flsmHFQcoq+6tlY0yg3GfsL4mT+saR6pY997QpHDUEf9+Fe+ht5Dw66JgkJkjj0qm2vuEeinyxDLMbzT1vBGpB7i38Vz/bUbaZHNJL6reB3ReDFjt5mgdexJagitu7QCUvVInIWZ8H3TILjFE2TubVZveCDAygFgGr37/oJwKFM1j04DXmSlUekatX2PJoqXhF5JpX/OZFuFSpdv8iDBZWpy2TPi2eKM4mRYohfeO1Ua9zPV4Edi1qD6l+G/wnwZpmYQpUnceSHhlBe8zqvAthFN0VqGCxbqwQdSEKKeOk4Yn0dtJPhE+QVba3ilKuNePN+G0SVm/tqEjrvHwSYhkpuv4DjqljUqhtagy9zy1DivFgEWATlryy5lTA/FFxMN5+tZru4abXMDifeKAAuxwczrNfED5B7ZvUowK7BHKa2h2KblQPPnzjWDn88yHdYEB7k/ijdy7oCw6hh5ruvVORpTetUPkNbS1h6cbB3D7DYVCsdM+LXmtrjckjiJVdj5uIl7BMf1FhUy9qGKidLozny+s4lFJaeUgRfLBz7S76dTOIVkULSwfqrnW6UT6LqtBs/TvQCUr5swEQ19kCbOONXT8wzc405OMgnB1oAPEzOIPnIup0+eThy6IJXZmKr4rh87UC9Ta2vmEWVcBvhvEmq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(261021121427099003)(261026140227099003)(11063799006)(261028144727099003)(261022105027099003)(261009223027099003)(261102123227099003)(56012099006)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iULldQrWhoZowAO0Pn0EPGhq4Fopl160mmgODMWUgeT/+N73YELBukdrLMup?=
 =?us-ascii?Q?4ZOkDEbtbp7zsh+m0Gb/MFJ+CfdNB272mCHCx5SvpxpUFdRYbFcxgCDaYcPN?=
 =?us-ascii?Q?/g+oXrlYIszsoGZl6PBXj4uDXQTejyOwnpTqZYirLx0VPCaIjJbl95tyBul8?=
 =?us-ascii?Q?0lKmQQaID8Z3ozdyP905TZdfUO+m0wDvrEAsjCVApedFeQ8LYvkk/Ydrmy3y?=
 =?us-ascii?Q?wmnyxfyrl4NsXwln7PGnhWPo0wQQBVGiaN97ZCS36Cz5yFGRBWSEfnIx5/L4?=
 =?us-ascii?Q?sWSdG2YJnUhIbnhgiwUW9Y+fF6sj8kzsv+Ws2Pnq9gj0LgyaIypk7LzCTYgV?=
 =?us-ascii?Q?MpW7NxkI433Lj0uHEIs1ZZZxFPEzhQ6l/J7ITLHd/Em9LFkCo7Vwm7QCQ2D9?=
 =?us-ascii?Q?XZppCaXjndpi6gMKTu+AkcEDURn3+3je2d/wxEX9z0xJg/ysMAuUNVmfLEpc?=
 =?us-ascii?Q?7vvy9k2G3DnMLJC/+TrWs7pJEq984dTwEcuuVSxkkAwrUJ/gBwAuGiBD5BBi?=
 =?us-ascii?Q?PIrIsutnejmWoOZ+vsdvgt0vUf2VDQtClThFu5dFSWIQ9o25WAOdI6Y8eqKJ?=
 =?us-ascii?Q?SCa/mViAKijymnXn1l+Jf/9HyJvZn42Z05JAmRkjIcgUokXS+7c8S2IjzDvo?=
 =?us-ascii?Q?qw0xsi93ygeUe0aZqTv7tcAb9DiBvrydiHozKDOgUbDDmxMCL8hd4n47fkO7?=
 =?us-ascii?Q?ipO12triGxvnzXlgKyRTqpTK48biFcIz6ovTz/dSzxze+sOAb6pI79z+QVqR?=
 =?us-ascii?Q?8UkzSBzWS5/0oJRA56QQ49k2nCi1P2PSp0OxYT0EC+/CNH+7lCYND4lxJTTJ?=
 =?us-ascii?Q?A9t8LufD+CvXG3NR/SmxnZ7yj8wbbMNWRPZcr2ClUAG7HNFTR5VGdhiyF+d+?=
 =?us-ascii?Q?f/i8UTwQWZMbL2Ak03twEf9n+lGzMMzXnnMxplJw1dtZO3dHaVuzRw75bz54?=
 =?us-ascii?Q?ZrsnFP7vevudj4Xy0v8VXwbJXh/x83nMrn3lJxYUV1hRW6u5alq5TDTbWOoe?=
 =?us-ascii?Q?9KLBaH60LCIrzRpv/wtGTG/fW3hqNaeWjx9UY+32xn+b7DT+0914/aaQs/QD?=
 =?us-ascii?Q?wMDJoxji/4Jf2eNv5U/H88Jfp7OBIPD3PQI6xGLl4BazawFOq88k8bU1nsiy?=
 =?us-ascii?Q?Gwk5lws3ZR3oNMrgO9F21fNBZBOzq54s4c1l4sqztzJ9cWEKB5XuxS7jdXaj?=
 =?us-ascii?Q?dKZYnLmzZtcgJOl0m8c5H2Fq06kZhJskoRnB//ElXm0bdlGJZypdyc4DvN53?=
 =?us-ascii?Q?QsxXR7vsSHv0TsJ3KIo3p9mbcpct/6RydM9q0o9Dq/8N0FBj8wxf0bi4sNra?=
 =?us-ascii?Q?V0+gnHBBYSIQ6L6tGokBOpGnAkF8GAXFNIlqTNX5XeathAaOZ9JKxGIQfV7t?=
 =?us-ascii?Q?2kh4iR4zhv5McZ/kLpQZId1UHYqnMYIhdh+QFZmSgZTn+ZXqi4RK8JYQaeVb?=
 =?us-ascii?Q?m4p1YYRSeWA5bI/1mjnboN0PXdYgFxaejNOxN4QZvB3VStGlFp5ZP6Oo4fjh?=
 =?us-ascii?Q?Rq/9qdF1KjCMscdHgJDU7OEB/cOw3vtiShVZy1utrowijA03Qw9+FRcSjeUW?=
 =?us-ascii?Q?ZtBZctpZFvDB51bmRspza+bOifjyGSlxQY9cFabmQBRniMzL/u60QtWufn2P?=
 =?us-ascii?Q?zYvw2ro64wyJxtOLzlMBlFxSqh8nC2yyoiiNiiLPIM+TzQdyUEtoWdgahcIv?=
 =?us-ascii?Q?CgWHowb6QJozpY2nnNz0n7VI5dDK8SbYH4TQ5OoK4raZza8YS1fduifV7p46?=
 =?us-ascii?Q?yPxYDxsOK4mjk+RNCHoV77euSa+rnaA=3D?=
X-Exchange-RoutingPolicyChecked: apvR7dpdvgX9DCs7IvVbs8VnsDtaRJLLW9ryH9nOnRB89dYTcVQuwGIl7Zn3hVilSxaTeXCalgiexnRZmdwXGQvsdGnUyquQatZ4V3qIGTJYyRJ53YEcPn6jYAaInuFGqY0TDNFzAuYNPKtsXKmEsLtXfp6NFzNlrh83pPoWuVuTAbBG+0MktQhVmQSAdZ+XVsU8ypg7dqVF9JnFDtSGRxgkEbtQjpS3Atd3w+/d3MOxzjcyBp4c6e7zkS3m3uHngbNsePWP6c3upMunpdgA5YGGSHCcbowcPfMVjXFz9QoV0GQzxXAyvRKrkP5NJwHTkT6hV+y6Dje5UGYNApx/rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b35659-ea35-4c22-c704-08df3c098edc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 13:26:26.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0fB8XBguC9XF3zo8ofIMjFbjV1oQ3Q7Js1bjaZXU1DdlxU9EuACQYs6gfsWxJpDNDfjZaaGxUN5yeDW1Gjx0T8IMHmbTkqFBYOHKaS8PDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
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

On Fri, Nov 06, 2026 at 06:39:49AM +0000, Anurag Mandal wrote:
> If ice_acl_init() fails to allocate the ACL profile array,
> it leaves hw->acl_prof NULL.
> ice_flow_init() then fails and ice_dev_init() calls
> ice_flow_uninit(), where ice_acl_prof_free() dereferences
> the NULL array.
> 
> Return early from ice_acl_prof_free() when the array was
> never allocated.
> 
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> Fixes: 96b25c496aad ("net/ice: fix memzone leak after device init failure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
