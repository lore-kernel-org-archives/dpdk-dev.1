Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C6606A33E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KUnp+weC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E78140151;
	Tue, 27 Oct 2026 16:28:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 0F781400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793114908; x=1824650908;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sIxLcU49wK1Y+heADXn5enrPvES4y6GwqSapAF8Cdgg=;
 b=KUnp+weCwL4MmRU8a+m6yqPsDlxHAng4vJETK/yXGWxRiNzFPZvELZTh
 lflTcw9xZP+nf0XAzl4JuewAHOiAL5mG3VLIZoDbHxS19FGaoyzyf1tCM
 OGLXp+25SNWBjfZvILnslFM72+waLV5PBf82hTYD4uPTUhwLGZlV20B/p
 N36xUI6kRvPy7mgF57YBsAnL2ORQMCV+vBFmVPzonaaDqUpoATLexHeA6
 4PGQ5QL1w0t9swOhsnXUQjAL33fXHhfXy4JOD7NcbPcgvqplqGQtjz1Bi
 ahD1YTYDJXh85Lci11PhMr5EDSLAOPBhFyyxzRFmjNFzhslUQZGGXq4U9 Q==;
X-CSE-ConnectionGUID: 1Q3Spz2DR0q4HvCQ5Qa/uw==
X-CSE-MsgGUID: bsYmvfWYSCiT1qcuLT5mmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1848734"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1848734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:28:26 -0700
X-CSE-ConnectionGUID: agZ3SrLVQZ2p09xK4Ta5Cg==
X-CSE-MsgGUID: dtOyUzDjTqC93sBe5AT3Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4643715"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:28:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:28:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:28:25 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld+EYNDTJ6W999O96qBU4QKTWimRq+NahSD5/FL/vFtvcHFhgJmH9yH5byDF1sCKR9EzmbnXkXtU8zhaf1C0ZSWFKAPDNtje6fRyTe82HQ0RNNX9AsUQGOuU3jjytdDpyNsnHpo36KUEk+hQb1hO3tQRR6A0ehUHGThjO4K7v3uOsaWOSf9ujlp9Z0+T0msPmh5g/VNzHWxVIIcFCY1OZMrW0VaRFLSqqbEHDLEmy6eRD6/+WnhJ8lgf7GM34UbxR0f7GUk69EA1wuXjB27IvF2CRFHKsCkQzog/MZn7JLFrC072vVvApbk+uHK5QbvSqcIq7utVCWoFmnlSghoE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkpFLr2wjo8AvcXdZzkoPKDP6/NYu2Fz2KqN66ZoAdE=;
 b=nBeQRflqqTFrUvccLD2SP0vMaeLYU4uMIvvdGjhlnL96lOOnsfINk9ElBYhkfrixqUh3yeLMiF9Mmna8GEcz2pjAhdZlQ+kU/E5A99NAeGQY/L5aR2yZTMevsjGO8PACFpnBgrmWBlbAZ+I+6b9AmYzS/y9eyz3X6gpgujmk24mLDxSOzhdKVbMOK6DZNL5xcMcJ/EJZrL0JHUcI7OhJPQypo1BoW0j7fUe+2Fc++MqZK588LtxNls3VjcAkbb6wuvmd/TQprMjOQ8AaXoFhmujyOxGkjUhFzva1Nepl51i1ZY+N0/kisKrN6nAFVuIYE6cm2o0YSxRFaucvWF2xJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:28:22 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:28:21 +0000
Date: Tue, 27 Oct 2026 15:28:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/7] net/ice: fix memory leaks
Message-ID: <auDDEHcNNiQTXCQC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e6fbba-90a5-4360-81ee-08df343eeee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261022113327099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: pzZpuPw5pF4KsuMPIGFMr7UBqhvmA8M9S4f5GHAMKoG4PmUr99IGBL0exzw9hvo+SNEjDsqFiXm8UHeVrtd54HNAY7jBsRGaZat4f+SPULhdGGTx8BxTGWJ06sWdoUJTCH+q8Dq5FoiGVhtrGv2MVGOkBbJ6YnMrKs0y2+FIzSw2KvepbvE5mOF9fSgTqSCG3S7cAtW1ztotqyS61sCaBZjt7MnZWUbnfTsv3oeoukYTlxLUXukwleSvdm4vvi4iOKXIECFeRgnVYyvNFXBIx3hSldRY4NmAG7r5EHDD3jAs5ItGOCBsjmsvLl6pjTW0SLaA2mzcq5zbZ4+XXRLFXFdLi0YzjmVspPZpYvCugkf7UKW2C8OEd6FNzPnd0KoEKyL5Kuekadc6hjlMGsJ4ZGedHm6RElT00HSJJyG6mqGCJA6noRubkHINLLlZdQ9VCoaAp5/ZCHmU8M5AgBlycRzNZ9EUY1tTMtyZ0bD6PWf6WhoVD9GwpFAvW2wmNtd1Upl9MK0N0cRpE0rmn74t0WCwyqh1Xbe4atGWCIRrRnYHt8Cm3v6lK8hwIjMLSbsM3HJFIjA14qocxaNzP3BJbH4+I53N8sRI6Kb9GpwsCtwoBemJHyF+iHoLulfdQNGqOOmep+Z/rL6FF9kRYqfmC9wUGRwxACLK1/LSAJl8AkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261022113327099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dfywg6nB6RPZGeMGFlyXzhKF8jgFV5v3Pfy2Zoqiox7tfEkVf4fo6Df8XCbI?=
 =?us-ascii?Q?Qmqp2hTb5FeH2wWs2QSqNG0x9hjUzP1M+fcGjsjrJem1b2HRa1f3vuIP8kh5?=
 =?us-ascii?Q?bcG0Tgw8wmJL8t7UEtTrEMkvDIp0ZAvQlGpBkXdoaTXFqr7+95YaV+lHYPNG?=
 =?us-ascii?Q?zedJGnS/9y3sx61thfKToZot3b0ZVm9Ofomakwcz56EgebkDUKSMH1pnq59O?=
 =?us-ascii?Q?2cZ1QcM8uvoz5igp/y1xcecT6/xzwjFICy8FiSeO6XQJvGMJFm1NSl+FFITt?=
 =?us-ascii?Q?NTFIw4DzBiz6GI8oZf2LtPsA7Ns9EvxMsFUT96fadNbtmU/z0OcymX5NzvhK?=
 =?us-ascii?Q?IRKkA6OC2vfmy2/ZG4dGZkFmEazF9gW0q4kRyhp97joov7CZChO0U6x2SWEB?=
 =?us-ascii?Q?OmJTzL7gijQtcLH7h7FkG81i79SHlYZQ0f7VQ08x24WkH36pO8EigoTXUzid?=
 =?us-ascii?Q?dSNNIXBUKyg10lN/9whwCHFNacrUkBE5yUnf4OvylUFGSRhSn/pA8ADsUDWX?=
 =?us-ascii?Q?rwZmUVyu9ZH+/ofFSgJmGjm03X8ovu47lWCCUgSUyjprFZvSzOCnlSbzOq9/?=
 =?us-ascii?Q?CDoco98uAvWup++d7izBJMQZnWLX9lNNylWZ+qGqWDNO5rby5Pdwq8uhwd8b?=
 =?us-ascii?Q?SpdDPp0f1RlClZplz6Sa2GD87bH12LJ8ztZeSp9mN/Qra32IPO/fNQpky7PS?=
 =?us-ascii?Q?K0vo/MUxi3lhx8K6uXLqj0dB09OkMIHwxPm4ImXcRLj3cLmVBgcxq5yI8ltr?=
 =?us-ascii?Q?5AWCMz2T+4T5W4uiDt1KPd5ZixNCQAI7DKkRkhrF7uY+7jyQvsvYqizBo9uH?=
 =?us-ascii?Q?VdFUNvTA9zaE4v/UIrhvrkp0Pjh2DBAy6b5aVRE564qQpDiHmhxuPS9I01G6?=
 =?us-ascii?Q?UaiU4KvU8lQTVoHTCllzndLEK28vw7IOAJGZ23z5DEy1McoIXmALxeA+fUCp?=
 =?us-ascii?Q?4HApeapP3rZNcZg+1OdKPfXClpTN0241um/HL64GKE+diWyYyKKVKtMrxRYP?=
 =?us-ascii?Q?EHkkNkWT2s87/1s6zB7hgrskxj9eChRAzdN3OW7fnVqUZiKQm9SdEbCBsQnp?=
 =?us-ascii?Q?xdBrZMw7ogyrLJS7IsVI/l5pZWMVBiLkQTy5/n8qnpJ3ISAZYqRUcWiAOfZP?=
 =?us-ascii?Q?uypE1IbgDB/ggNoxegh6crGYBjU/g8JICJK5rAmaRVV1r62KF62P54HH2YFQ?=
 =?us-ascii?Q?ogK3Qzmlzu+eCNr0TjGhfB08zEQyJy1lrdK8+QYhY3AmN0532OJnRGI2+L0H?=
 =?us-ascii?Q?SJukfqCJbjpGCmPna9xnCjnyBTuAfDdJ+zcnI4SBCxeWCsfD8hRRkFHsZ2kA?=
 =?us-ascii?Q?vNT9TXO1n+iqCQm6+z+ABvCh0G9tRwIs8TFBL/Y32hEHIU2tWEpFkxBAmx6e?=
 =?us-ascii?Q?iCA7E7DVCmU8X0zPT93xHgo/PSuA7KqBLl+Xo5fCpNp/6KI+vMTlf1bnzwiB?=
 =?us-ascii?Q?GGdlgyfJsuwlY4riyyu7sR/zQqfz/0boGzIX+asharet6PiHQoM6RMLk99gK?=
 =?us-ascii?Q?YzQdkltEouwRhHbEkK8Pb6sQiHNeoYuYCIo5lUKEwBlTdVdOt0nEDlsZysyQ?=
 =?us-ascii?Q?v4UoXUvdLQ0EKxwnPmw6LrBzOU/spLtScCou7uUqOgZw0jGap93sARocu1aL?=
 =?us-ascii?Q?eACfaupVDJCmq/CongBxIJFOlE3OzuReLjFNvXFT6OTQIsk/7Z2C6EYVljcT?=
 =?us-ascii?Q?xKGDjMEwv6pZZoPVeo2pi1GipSSZieIkeypycMe2GxvwBPIspquzgfxCIroZ?=
 =?us-ascii?Q?NpQNOEOT2X6VPM3CzZA9Dx2DBIav5lE=3D?=
X-Exchange-RoutingPolicyChecked: V3T5PdOIlImtHqVXp/IndYH8juR4NgrWuK9cGXSiM5SqhY6phBIHdxV3IDA3vEnTBB3wL5tjXZKiG/+MdrKvBEKrtY3KBAdv9TDcRqj6idHkccaXvx1o3goE2FVYNs8ymVP9BcDAv61smFpFyU+1pxl+GE9H/ZPBtck+abzaBCWe1FHGjvcmjGBgSdzIOCorESoOfZpv/+KwqdS2RolFqvkNtG9+5MMLP2H19w/VPxq7r0/YEN1FSfmypSqW3ppGXETmTx/YNx8ZWnZTSfkYc7DZ6MZypfeFpr9uhOqVESZYrZpZBkntOvwwaDYUs+LDBz2666gK5qi7ozGoSspq5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e6fbba-90a5-4360-81ee-08df343eeee7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:28:21.2735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOU6Evs6iV5P97VRkwDHoZHeAqnz/GPwe5wJ8cFtKuoD0iEAa549WambuqhA4884pf5/NsGhzOzUKiPf//oRp7zBxXFBmL5lJMSQjyn387c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:30AM +0000, Anurag Mandal wrote:
> This series fixes memory leaks, and one double free, in the ice PMD.
> 
> a. The DDP package copy was freed twice when hardware table
>    initialization failed during probe.
> 
> b. The switch filter management structures, the DDP package copy and
>    any remaining VSI contexts were never freed on port close or
>    reset.
> 
> c. The DDP filename devarg string leaked on probe failure, and when
>    the devarg was given more than once.
> 
> d. The main VSI leaked when probe failed after PF setup.
> 
> e. MAC and VLAN filter entries could stay allocated when a VSI was
>    released.
> 
> f. A failed flow director setup leaked the FDIR VSI, hash table, hash
>    map and counter pools.
> 
> g. The flow segment used to create the ACL profiles leaked on every
>    ACL engine init.
> 
> Anurag Mandal (7):
>   net/ice: fix DDP package double free on init failure
>   net/ice: fix memory leaks on port close
>   net/ice: fix DDP filename leak
>   net/ice: fix main VSI leak on init failure
>   net/ice: fix MAC and VLAN filter leak on VSI release
>   net/ice: fix FDIR resource leak on setup failure
>   net/ice: fix ACL profile segment leak
> 
See comments inline on each patch. Please respin with all patches CC'ed to
stable for backport, since all the underlying issues are present in earlier
releases.

Thanks,
/Bruce
