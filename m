Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E3CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78E754029F;
	Fri, 22 May 2026 16:53:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3DA3F4003C
 for <dev@dpdk.org>; Fri, 22 May 2026 16:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779461625; x=1810997625;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iBLsqwrLtn/k/70JZ9CR5Qeri4WkXJCCyw8PSq/4LfU=;
 b=FD9iHQyuFORi3P5j5qpcmJWZNp4DQWY8ZK/kV28r+f0FZjzpm9rmnsPu
 QLwow6iw8V6UxffRITVKDeQOYVZPGiMNI/cYcOekOtEKVJIpgSqToUTUL
 RjXF282/8L3okV8/pAxoidv5qV3h6BWh2jC0B9nRk2O/iLmNGxAHuCiXB
 tnRtE8b2RPd7gbhdCi76e9rghgTjKgRlefkiqHL5+kVH/0RXPg87/T2JL
 Mmh8h8OiyzV4Tw1uNJqs6WmddSP2QUhhjWQC4+AQlilHNO2N9rJ5CLTZs
 oFY7eoR6dVf+QMO/sd1vYXzbl2IgCB7XOw5wonssdYIJl/e0+046kH/bE A==;
X-CSE-ConnectionGUID: ClXsP34JSCC3qphxPIYpuA==
X-CSE-MsgGUID: vqdHrvn7TSK4zr6+jBaZ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="91863557"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="91863557"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:53:44 -0700
X-CSE-ConnectionGUID: 1ErWSDwVRTaFjxEAGzQiVw==
X-CSE-MsgGUID: Z/nQ3QvhTkG9woZbiYjBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="242734254"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:53:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:53:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 07:53:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdT1j+GkrIIZkAVsre2WhmDeLPZ44RGILk+3MG3LLrGUQicTrYqGIzqWLRWVuy/Scv0/0eKgKfDEezyIUsb1KyYcOoiFZmq2jhy9IqfD1o4ySNQJh7/FYhqqZOh3oCPHziIWF51aRgZWRqqCTZlJpDxjfknq8bmYgNjfJ+/xwHVrXh3BZ634Wc6CbgYmFHOLt0tV/HM2//exSYbOgwTOt4sulrJbdWadXnshaa7qgl58DTzqB7sWIzFDYpdMwnPnDU4uiwvuYuU8tfFQjOZH8knes0wZ+rqDH1IfS9Xc9Ryf1V1fsvnJ2XPwLXGJIC+X4GNNW3nnvDb1jYPiO9rimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opCbBvGaH2aNkXnCi9KCtLAdLxlBhsHdmqDIfU/Wiwk=;
 b=BDR5kvMHiX0YTdu7mZWKiQQclOqtGJB3QSDoMkaHnJ3CuumVeBc/ip1YW36nb7i2i+/qggTWyeDE0he6EcLJEb3xtd9Ve7ETdBBdHCzoI6GvdmeoL86bwK2QpCPHHw29v/mUQjXwyMI6BLJv9ABygkT7GB2vfyD/cPSydg/QUI1kezLU7lQpLG9eDZXjZ00J4xMI2Mgtrz4xbVyugMg05DeAp+GU6Jq1PvzUJXV9qk8tHCQJZ/A7vYMxiKtpeBZJBP/TThFSD9AmnRCOgs85EPEumI4RYSsWJD0d2L+Z5KP9ZPxGnOfvROKut7zPpA6hQzbrpkUiRfa7qSw1cdXMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 14:53:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:53:39 +0000
Date: Fri, 22 May 2026 15:53:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <patrick.mahan@hpe.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: improve log messages for DDP loading
Message-ID: <ahBt7s4KdEi7eZpk@bricha3-mobl1.ger.corp.intel.com>
References: <20260516101942.443871-1-david.marchand@redhat.com>
 <ag3Y1401SlX2hcTm@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ag3Y1401SlX2hcTm@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB3PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:8:1::14)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1ae77d-98af-4d17-9737-08deb811e897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: t6BWcyUdYnoh3l8kyIg1YwlfbL1RjDcwXr6mPQlS96vzh4uV8aj6JeJRS5SFvPL713WKWvgnDfVM7bxcKSgoaiW+b1SY4inGAQKOW190Y7DzYMoGD74nVFMhMHOscm6NBMaNUhfmVKF7M+Djm+oG66GPwJSNwlUZtid64Ev1JXAZab4aCHvdX4H7FoSyAgLOpPcniZvJRg2RGQQgSVwzAAVIb3BcfHpJXHklWWGhutcO5Uec1BeqeOAC9L4D36RDzFXigwAURDnFoEenYKgs9rntWZyMWOCt0DlLqhiSRzhVa48Aq+Gm2NTIW3xBlBKGp1uQCSxrGg3nuztRBQvRZeSrRYuJh081g7Hw4ozfMab9fmW4BInaCo3+feWmZ0t5rJQhQeXMyqcIlbkb9oaEW0R7/e+2hlgVTdGe1o1wsIcxhAGBWVULWc1oOihfHfYi4Dqr/2fznk5lb3lnZ/qPlyK/mLIz8mgGBgrDm9aFoWF4oKGpo2UdLqVZ+ZyAQiT0sbPF1OeWPXv8JrSoDF8TEdUSC2Hrf3T0EvXw84oqjWkMI5WLYQvmO/wEZIfJWLE4Rhh13SSQSnID82Pk7HyHUCrh9RTOrn4cqEvGfzKjWunTTmdQWHLLa/7WyRfaa17TnAJO4izkt640sNf8TgWyHCV0B77qrLhCdUgIGL4VKa4FIiMweNKcB89mYOHeMpAp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANgHd9HARNMYC0dFKaO6tsZFI0GlWvUoUAtZO67KkwEYB7WVruCJV8Wwc7Cl?=
 =?us-ascii?Q?etCGZtlkUzKZoIaGVsgKftmtNTlDburnngZts4rPEXu68UIkboPyn0t3QRkM?=
 =?us-ascii?Q?nMkj6q0WmF9soyyDkSFiTnZLwaLKMXe3Z2ITXax4DZOkBySIL3AS4URzEFyg?=
 =?us-ascii?Q?bAWwlPByqozgxnZdSxyio+JbgBr93sZwk0b8jJmktj0hHSK6XU4oPb/GbTJt?=
 =?us-ascii?Q?r9oFl9scHtk7S96CgRngzNKXKCdVwt2q6eXM/XmpEXOB+b6s+LJaBQoZmR80?=
 =?us-ascii?Q?KaVWParVXvQdNF3hDS4JJJTiCCW1xvifN8/dtZrnme0IiksAameCpcYCSFad?=
 =?us-ascii?Q?ykRXIVvtcsNe5gnFLFt//aVXdWwRIYyebJcnnOgk58A14aM6kHMXepmxh0Vh?=
 =?us-ascii?Q?2J7rXq8ZNTyJyjWlg9F84k5qxoEUYwsdb/MnZX6NE/q8wT1VliLLRkgpSpyp?=
 =?us-ascii?Q?xfrw9GqJfIoSOl8Htdm1vpQX5sod65aoZTAqER8lt1LVphOVYx1LuhXdx7xG?=
 =?us-ascii?Q?//pYJvPoaPCcAeqd4p1k9RVzTpIk5CprkDzEaWtS1100AinAoSzIPfDlkBNc?=
 =?us-ascii?Q?S6X7m0PloKetllPppVLGa5tpZI2Gl3TD9WuOwz5kJiPCsQZb8QaWi3FnMMUW?=
 =?us-ascii?Q?9LXwDuw8XNv3rQe1jrIPBiMffRjrFnOrFnTWJtYL4etAjofVGF3qya3lXPT5?=
 =?us-ascii?Q?DPOlX0gZSAkeMqZvVTagh/Ez2r7fkHQ3ewE+iEsRn0Fsyu69UOAF+nMjTNda?=
 =?us-ascii?Q?ypJwSSjND2M31PpORwPMKWvrCf8+1yMB7MIeGmihF7ifu22isQjDc/Up6j1G?=
 =?us-ascii?Q?OFS7dhTFhl32YWBsFZK7tSenSc190dcbpbYS4n3pm4SBTmPLeCA6XP2K8lNO?=
 =?us-ascii?Q?GSkew1/HnkMQOkKsfBxRKF5iY11mmwiqI2vUot+bkibSSmrZgJka9rRM6uoe?=
 =?us-ascii?Q?bghsI0bRmZJEnBNrCrq5+kBLJ2qAvzgy+KF1JzEZDuuSTGI3BsQY+geC7sRO?=
 =?us-ascii?Q?ebfUbfTrZDZGNs8mEUdcgHsBTMPooqyxUwe7pTivoQR+bHUf0TsheJRaI/U8?=
 =?us-ascii?Q?OzasMD+cagT8OwXJrozeo8gKXuLv1zsw2Aij9F76SDdAimogNb5V8dPVZsCu?=
 =?us-ascii?Q?3etSIBxNSVpRKwhCzhdU76BHlXLhmAbSURREd06Q/8HS9nsyk/FKjeCcF2ab?=
 =?us-ascii?Q?cS8EtUvxaER3wiouA7jyjyO7D5fVF57Ph/qvQKwSaRy81j+nvSVGuG0xQdB6?=
 =?us-ascii?Q?FSlgwiINjOACf49E1LTYsomDlOfIC+JuYJKPWCL86IV5Q0qSAtTVuE//HtVt?=
 =?us-ascii?Q?eQCwu7yrHC6VOZ3HXyN7A+Kop1ZtXY6s8mi83P1D2wv4oyDKe/MOQgpvxuNc?=
 =?us-ascii?Q?JFVpQNpz/hJrdyMNQPlrkhLpLwhmM3eGzSTwJ4sJMoeTq4zAET+9vXu1GQrx?=
 =?us-ascii?Q?hKbPw46+O3JwYgkwKQc/h1sye6qZQAGs+N96RbtMCzhvln6wPYuiYOvHv5pA?=
 =?us-ascii?Q?D61COfKmqsJUxnwU+/FIqxek0mCaJD8QMiZzZKjBXAwfDBfUKGHBbK7HUtnf?=
 =?us-ascii?Q?1o9K2mw/HSsGN6+EW5GllCbp/hy0VqVCqsmGo2WtGBDrxUh5F7ilt9BONOM2?=
 =?us-ascii?Q?OCEzPflazhPUZlV2OKuNXlEPY0XHfHTfIbaKEa4Vi3N1DYQ3XR+i5fnul4Gn?=
 =?us-ascii?Q?nIW10uczOJfakJLXUvzhkTCuc1QG9r9JiVa4NNKjpG3lh3dGnixaqMtFDNpx?=
 =?us-ascii?Q?GJWEyDIS/+NNgGeZXeVHVCs+lsKNMVk=3D?=
X-Exchange-RoutingPolicyChecked: Lk2I3MyK2q9CO8HR4uVBRoJyaQsqRgHyfglpXw++zxF1KB8UsrgSiCg/7vs2fIBK4UWGog4zAfGsf/M+OmtGXwsy77Y0q19ad9Dm4MUs7blMMnDTUp7LYs5AKgKsDMUyVUyPcwRbQ8VQr9G+FZmyb3ZiTXJOqGWrf8gVxcQSNz1//74uodG5fz6Is7q+0rTOcGQBPGNupsa4cb3DZ/sKXPkM2cdGXWHgK/FQCo6u5CKJe3GtO2zyyBUeZg0vaaAm/Z4c7hfDOr4QD1jxI6HhSrB8WLkp1856wUkZn+VCiLrR7Ry5E6i15dv4l3YJssxiSCWQJP6iIPXDIhKcGYx9gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1ae77d-98af-4d17-9737-08deb811e897
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:53:39.2036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppdug+G+CELeA4TDacr1AcQSCYdSbR1L2cvBHK4I3BRPo0AGOXsfXuGrB3p9hAGyBMYM3rf4K3ViuIh6MUxDEqTt+FwtWqPrJ/WS/t7FbvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9519
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

On Wed, May 20, 2026 at 04:52:55PM +0100, Bruce Richardson wrote:
> On Sat, May 16, 2026 at 12:19:41PM +0200, David Marchand wrote:
> > Some nics may not provide a serial number (PCI capability
> > RTE_PCI_EXT_CAP_ID_DSN).
> > 
> > This results in a confusing ERROR log:
> > ICE_INIT: ice_dev_init(): Failed to read device serial number
> > 
> > This is confusing as DDP loading does *not* require the serial number to
> > be present for the port to be functional afterwards.
> > 
> > Besides, after trying various path, if the default DDP is not present on
> > the runtime system, the port initialisation ends up with a vague error:
> > ICE_INIT: ice_load_pkg(): failed to search file path
> > 
> > Improve the situation with adjusting the log level when reading the
> > SN fails, then add more debug context to DDP file loading and end up
> > with a ERROR log mentioning the expected file.
> > 
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > 	/lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > 	/lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > 	/lib/firmware/updates/intel/ice/ddp/ice.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> > 	/lib/firmware/intel/ice/ddp/ice.pkg
> > ICE_INIT: ice_load_pkg(): Failed to load default DDP package
> > 	/lib/firmware/intel/ice/ddp/ice.pkg
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
