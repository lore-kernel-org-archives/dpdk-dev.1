Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EBECAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 10:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E8E340264;
	Mon,  8 Sep 2025 12:47:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 00711400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 12:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757328473; x=1788864473;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GuGAFssu+jBM6+3G1X4A74ye2BTz5PMSJ1+Lxb1HYoY=;
 b=B7he0RWpSbkjw3rIerTd4tinbkhU9HYcQ022PmSYoTCDc6K9DlAPQ5Hg
 LEVdQGXCkhNbW0j5M8ktjguCD5cme3hFupZcof+Xghtgys/PXqMF3a4Fl
 nm5LUP5i1qNDP+0VfbOrE5dBZ3eA30vbcUm4wcULjWSFGaZ7oF/BT4Pjn
 4z8Oy0r7Dxx55KIhku9xmB2EzDu/F01vCzH1QTjpqH7sJUrJKGQ8qFL3w
 K4dGV+FafTXTNGczMcXNTJ/pYxPrb6S4iNHnkMt3IaCCWEOyIg9SleC1s
 DvFy4pO2BOAaa7JwB9w4OhKZBQV9ubgK4JcsqUm08gtb4jUy4eIXUOdXb Q==;
X-CSE-ConnectionGUID: VFYk+syMQYqrxAvIZzTg/A==
X-CSE-MsgGUID: EPzxI8IURAKUB5Q88brWQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59439567"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="59439567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 03:47:51 -0700
X-CSE-ConnectionGUID: f9tzu2KIRcSLoSXiFESfjQ==
X-CSE-MsgGUID: 1XRFMKsXTqiewmX4TEYLoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="196404304"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 03:47:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 03:47:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 03:47:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 03:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPelWYD6Ut/81Jayb0D07uPMLRvtqOaeer7dyFaJoGQoqXO8R5dyqQkRNkuBX/RPjv+v/WS1SJQEC+6hKql7juerIqNX//k0AgCO1u02wplTajRy9ijosRM5bxa6rkNKVbH4/tToPwffCEsGtFcPRdhsrAFDl9TQPL7SWilvwy7jt2jO61uzIoBrU1Pgily9c9A2kP0BxDpVLLrIl5a3846yhbc3MJ7fuKdfBkweNE6RjOdRhPE33uuoIIv+Bf6gS8Rzwy+VZFcdLrfeNn361V/nW17o3UVuxSAVb6aROKqGpDceRDCU/WM5ybDJQSAv6gNN5xXXjNyb9DbcQHC2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fppxTk53P8yaNFTAtJFSh914x+/dGmAgo1nFWc78qIk=;
 b=NEB8BnQ3zSTbjZgLgIF9aHMaLQPVOg9RggrpmdrlxTxGjVQxpc+cy6np+Oc+WF94UpE9rlaMKZ6aHh1XqEVWQR8TqjKnxtScxpXTfnsokmXoOVYOOHtlfN5WivH7rLcgbY+kHH/2bLeQ5lh7jp+CGESsLdcS9BJ40kCq5Qzv1LnDg5QdiJjRbAvvpMYP73Am43mX5YgY2KUxDLUf56INEZwnc41LhW6hbBAi/gjcYszyMgvdSrlFwlPLTvk6N644xnUAgMm6KiHq9yDF5QvElkDdtkebMtqXSz8n9H465jgQ4DLU03BmJO+UH3kdEOrt1G7jLeavmqcfgFcKMbJ27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 10:47:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:47:48 +0000
Date: Mon, 8 Sep 2025 11:47:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/12] net/ice: update to latest version
Message-ID: <aL60TwPWctu2D6Gj@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: f94d2fe0-4542-44ae-db6f-08ddeec526a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Z6vgWKWHapz5D4Iz47gtk22xtoQvZRx1/1BhktF7y9QMiImSgI0+tQZOc2v?=
 =?us-ascii?Q?f2lq9wRtwyZuJYksSO3KHaNyM98pDGXCgDV93geej4IbdPNO9WBFAyd/ltu4?=
 =?us-ascii?Q?yTweJnPpzi1xw+xuLP4tqFjAk3cIG5+heWiE+oI7R27Y2fnYboCQc1oR7uhj?=
 =?us-ascii?Q?MlWQjg8CTj7+j4kCsMAv/a3hYYQiIiNC0hA5TgwRBXSa4EJQSoIDzk3TxUEt?=
 =?us-ascii?Q?sTVhQqThM1tv0qGfBzSLcU28VVY/oaVAjHLcgsVjgAJoK8febgRjVQ4oS+E0?=
 =?us-ascii?Q?j14xMShMOcyjw8Btx+vSp+MFy+FMARGa/wNCYEjv09s3qraeKeNmFV8L/5eg?=
 =?us-ascii?Q?DNw/aphmEIYNhDVQvVH8dNzaQfQJ1G6njLDw1jSIhDhIurH33XdRZQPms5ps?=
 =?us-ascii?Q?dfwm6Elt+Ba36kC9qFcLGx2YUtmM2VhKMwYmBud9nICLEYO+FQUtE5QN3WR2?=
 =?us-ascii?Q?5HSL27BTvONmucApbDbiUITR+xh08MprKnRb7896CLtOJpydLMgVWaQs+pnJ?=
 =?us-ascii?Q?B98c/X8pgkVGh7TTr7AMtRJfTZTX/7OrP+MJ1nSJcexWrKXI0xTTrINWOJxR?=
 =?us-ascii?Q?8tB4ORQMoEhKbTrqcdYqsBDwkLDw20SpfzcNBgFVmbHsyQ/EJAfmDEA/tH8c?=
 =?us-ascii?Q?mqx/UfosFL43R1qR9gTOMvdLz4OXCFB8x/Io+i3UvpN0+tpfXYLVaFv/WJ60?=
 =?us-ascii?Q?C9+clGloRdA8e3dhPxshalxc9aYegsiJgeROeWXdO3iGS7fmTXVGojP22cVc?=
 =?us-ascii?Q?OH9dLY6ARrwdRTlnFsTb+IPT4lU6x/4g+GvJBcw6mLFS5b1LVxaGXV0dt47n?=
 =?us-ascii?Q?Vz4TdXBb2bWSHcSIliPLwrM/5gICO/r4lJSEmuqXIFXi7eRBLnJFyEyvgQZf?=
 =?us-ascii?Q?HGey0XTMmymJNEFXu/qM9CleU3266XD8TwUsOQjafGWsZ9svUqPk+q48pqGf?=
 =?us-ascii?Q?EgB0sGryaIrI/8PMT8Ghf820vhAthtJvTWS4khi2bGqVj9y40Di0NxTFUtzD?=
 =?us-ascii?Q?JEN5b2kQ7A9tcQ9BXdQLoC2nYjMV6UduMdKU+sxNVRVmWghkZQF3Wu1POOC6?=
 =?us-ascii?Q?vfP5fo0ImNEYLCMFBImQfcooXXfKWxqTeKiOO23vwN9c3IX7xta1D73YuUVJ?=
 =?us-ascii?Q?ielLhZVtZY203wWabrwpeVYGVze22ZpxRldssoINjGZzcjl/XJoLN1hcgpax?=
 =?us-ascii?Q?UVvRzR0k8SjpXNUBoqJzt7MNptsaqig6dIuIM8EKjdbW8Tdq5Sdt0Ihj89xK?=
 =?us-ascii?Q?fZ+eaAdWeVG7bRlnHd1bNLBrLRHCrFgea2PCD/9Ff0XrR+UvyWGLOThmyN4H?=
 =?us-ascii?Q?4FdvH0AiFXULAjxCfWWVUdjIev+AtobsurRdQb7sNVmkVNGtsKR4myomNr1Z?=
 =?us-ascii?Q?moEfHBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aids7vWKmkEg6xUWFTzXGAwCReU6S3Vxd5iKJt1bOysVZ4htb3D52gvOUMtH?=
 =?us-ascii?Q?UHf5pNH7yEQpYFBXmyVsWK8ZcpZhXxtRsSs1GRmTQErEZ3YvnHkwM5rdf12z?=
 =?us-ascii?Q?9ZFVmaM5n9gCHq0/xtsdXQqIH2ImPIuj1QSYH0rbA+YZgq8ogEWZBf2vwXRh?=
 =?us-ascii?Q?G63wBG5vB64Jg46kdJQFVpS0RZYftwyU6HuZR8EJf751+9aTmsE6la5zdRyx?=
 =?us-ascii?Q?mLvUbkY69W4HdD86uMdbCgu1qd8zEXghJ8mJqASR3RirIsaE7+QP4rc1qL/E?=
 =?us-ascii?Q?W8/KLulBYciDRqcXd4Npn7GGTFAO5hhMutxONyveAKDwVQfio1HW7dS0MYb8?=
 =?us-ascii?Q?iS1X7+nCTbpKtrJRHFwHZQqN0cCG47aHOwD5aYjcFEjV6PfkLp0kFdNDDWhm?=
 =?us-ascii?Q?gVXs6aVQfcMPOVaAsCQl6sLTkkWhGgFPTQi3sZekKizjpkgW21AWJsPhu5RJ?=
 =?us-ascii?Q?zORBysnJ3j4bjsEIV7zqmqMJr0pCROwgBSxlV6MVXdNY9l7O2ed2iLKDRkRZ?=
 =?us-ascii?Q?zXwe8Q13o2tXBUE4iKaf8Nx9UYmy3dIKYHFsH4A24WKtzx1fUpnzr4CxDGvA?=
 =?us-ascii?Q?osFfBbJTF5VwlY6swDRt7FVFit5HgFsvoCBG0gubDm5/SbPZJC5H8B0WZWll?=
 =?us-ascii?Q?yexlWUE/uC6VEuLuDUmlCCxaJ3BagYBwXAkkW/jnxCvAyaskaiaXc6cryQDn?=
 =?us-ascii?Q?gk+3ZYqPsr4416nj3s6g5XWbdPEP2Ve7vsrN1IfUm4YxgidzOAK17OW1cHgT?=
 =?us-ascii?Q?TGiLD6r2pzNu6cwbfuTp1P9OnGhiFhYJ49GHtlQpkT1med2xUzmUxMu/3cEo?=
 =?us-ascii?Q?hFIh5/SUxHso4bFKFCYg+3wpnLHExrV+aJbZtTX2NE0jA0ynlpH28GM/48Og?=
 =?us-ascii?Q?tx+HUdmeZTm/Zn+YrLFOUQlVW6VrOvKJMJe9FnNkdV+4UNHtcD0JnxRB+CiT?=
 =?us-ascii?Q?WK9nzf8i4RyQAyXrwDcgmmRdkX+/0Xcm9zC106DttfpX5O0EvIeOoJB3EPvr?=
 =?us-ascii?Q?+mpVNcymH5z3DaVmc6kXWJZfxMdv9CaRi0SXu9jXAzgi46HWDG7IXY4logCo?=
 =?us-ascii?Q?4rqFbTULjCorjVADJc5GeGrwhXnV6qRSc2fecnuU1ETvPxLWzjWi47nFFxov?=
 =?us-ascii?Q?io3IwUoBK3axs3fUFu/xCQfP9OyHdH4zPLnkG6sX1JMx686Gpkz+dXadSA+A?=
 =?us-ascii?Q?bUNxct3qZo/jqaxuKak57i+GO+Die6Z1h1qBUbpbGCeQpNYCC6v4FZPh3SaD?=
 =?us-ascii?Q?btbUQGulLZb3SKxIPaL/ADHK7zQXWW+okU5Z9uTsxOi9p00qWg/MByGCMPeo?=
 =?us-ascii?Q?A0+J1p6dTxqBk08PyfwonWf0pOkwVuJ2SDJIBVSIndIrFirFZ3ic7FXXIzjZ?=
 =?us-ascii?Q?efr4tVDDcNuHdsKtr085xXwKgCL1Gucm75fkEOrEmiTjYaotLGQfXHXSu4ZK?=
 =?us-ascii?Q?K73+19PQ57f5AsI7EbGFvgsZAv3ahaZwQjTKygNx6u8WUVCBRuPg0wvjBFzj?=
 =?us-ascii?Q?NpEhJFUtKPGADdXDQcasHQULUe2KBjZsP0yVLgLlyUAcWAGJcgS7K4jkoCTL?=
 =?us-ascii?Q?/Lcwqro0lae2e5OKLg2RNuCaGaHAorFD67y2KMXNh/tQByMbLW97U6RjJS8h?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f94d2fe0-4542-44ae-db6f-08ddeec526a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:47:48.3167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUMopdZRlF3iodjUCKXexDmct5/kqotxr7Am2dyUdlYV4g5gPAaxKnn2r0LpOl1OxWG92nnksbWMwGjM0S9JIA7SJ/yK8nl28KHUGGiL2m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
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

On Tue, Sep 02, 2025 at 06:26:50PM +0100, Anatoly Burakov wrote:
> This patch adds an assortment of fixes and updates for net/ice driver,
> bringing it up to date with latest shared code.
> 
> This patchset includes fixes submitted by Shaiq Wani [1], with a small change of
> dropping a direction lookup flag as it's not necessary.
> 
> [1] https://patches.dpdk.org/project/dpdk/cover/20250731044132.110174-1-shaiq.wani@intel.com/
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
