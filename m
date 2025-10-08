Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B38CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:07:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEDB9402A0;
	Wed,  8 Oct 2025 10:07:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C8F7840297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 10:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759910867; x=1791446867;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DlMZJNd5gQipX36nH1u6+Y2ISgVRw+JP6emCdNyDJEw=;
 b=mG+EkY5aL+YA4zSTlXRe7Wzxv3OCoU1TW62GRWnuqX5gBq08jIVJE3Lm
 JV+jpDVg7xHHQaGN/uJGw2DFiAysJ+i7KCOVlQRP0ko8DZI+yCKdUm7zg
 KtYEfMlYOc03Ypfy2oSVaGnrSBQehKaENs8RS522l2Z/1A7xuHLG7ION5
 38H0tJzk85IPFo4OABHou8t1/SshQrR1ncDgxnSxI1aoBx7kksugLKjJe
 TaiuF7K8skNU5MWfHmNb3bdbMPkR4inCgUuN7qV9VEJToy/iTNrPTzXXQ
 /+FXtwn59qC6kBNnJRaTP9AeFpXhky4MA+qiqhR2HVaGGG/0JdSLbgsae w==;
X-CSE-ConnectionGUID: W2HxLRnZS26g2MgKcBvJbQ==
X-CSE-MsgGUID: ZQeg+IesRluWiu9apSl+VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73524741"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="73524741"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:07:45 -0700
X-CSE-ConnectionGUID: izZewBFDStCDpnWqlWpIjw==
X-CSE-MsgGUID: XA5/sjHOQjWlfKDLBfDftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="180798698"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:07:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:07:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 01:07:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyxph6JR97DR9nwN2KAUouBxoctNIk1NLKoft+A6Nd7Qj+kuqUCBOVdnQn4neI2Wo5lnT7nBxT5mgmAe9Mbe3rnL1crAM5d0ImfjwNBmhVQZe9FYOj8DG/2RXsHTn75qJO5yX+ywmSnWcXV1m7CJu/ypPkLH6sNX6++dqB/RWAAbs6fNtBD59SFXewhC6NYB4XwCq5EQfZ9t3EL5h5nC8EFDQNP0IPFRLIweyt6MFk7Jsu35e26wkT7eYzPb3PNYFdqMdk6pcLYpHGSphiRx/s8YsE1MalZT6ywOa6LbxJnGY7TQSi2lAHLqR+0mhSq2vvQyleAwYUopnORp8fWIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZcpPufNlMLbRS2h7fN+La4Imgyv6+XqNbqxQJD1ZSI=;
 b=KidJRSQZ0BGJnvzJIaKhPeAcdfqTAIHJEr1AXgcyap8XEF/g0ZueRZQl96+6Dv5WNjtWXqfGU55QInzqbhr8rHd+QsUXFaUY5GhIOeuJsXcsL0fAG2zO7joNq5IK+htZQ+J6miaR+UupMVGgOJjIfYmDqlcNmyNS6SNRYIHp6ve64rqw4rzKbxVVY6+RRooB2Tse2P4cO6udX8uGIQinzJ1FerQD6sbV6IWEYvHCoJNrB1JwY+R477Fgi2/I6LgjorV/os86Rkm8uBzXZW3GVmSiNi7hyZmvhW/EgCSEY308dpOGOIjric0vr5ek6UNcwU4rS1ZFIV+u/DuRBi2aBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 08:07:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:07:37 +0000
Date: Wed, 8 Oct 2025 09:07:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v5 0/4] add vcpf pmd support
Message-ID: <aOYbxFkccYzQPskw@bricha3-mobl1.ger.corp.intel.com>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
 <20250930182718.2997819-1-praveen.shetty@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930182718.2997819-1-praveen.shetty@intel.com>
X-ClientProxiedBy: DU2PR04CA0221.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 07208a77-19b5-4ccf-3b4a-08de0641be39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPIDSDtRUqx2az7RRQ9Tg4aT+Ls5Km2qRooiXX/d5wDpozqeVY/ffq+qpYg7?=
 =?us-ascii?Q?GqDTnLVTo/RDOumeWKmPd6eY/5hmkHZSuUeIqSwGTp++C7kE0g7HCRnSlyYL?=
 =?us-ascii?Q?Agxkam/9r6oqLrXAXa+6u0X7AqwE8PpiZb0Bv93LlHIxjdR5QAryn6fot5uH?=
 =?us-ascii?Q?ugo3350MLDWAKb/cJakUQ1kANUBj/i9XVQ0h0gw8NExoPNp2jCwlw/ArSO2+?=
 =?us-ascii?Q?NCK2HmAXD5zB88kzPBmwPjJEBB2VC+aL6k1cXhWlW93LLQNyFuPemWjQ2ogx?=
 =?us-ascii?Q?tP3stU+2lH8sXVySEyQXbGaXoJ/LFsyTOWFWn9tweHp+Q5OnPMatvwtnC/I/?=
 =?us-ascii?Q?bdlR0VAgGb87hBOk2E8+VyOo0DDf42EZuHNtfPb69JtvX737pKFDse7+VUD8?=
 =?us-ascii?Q?FoYI4AsCVmTgb3t0vLRjL7OsRUE9th7dwPtJ6MCCN1k22OdokdUgb88G4I+A?=
 =?us-ascii?Q?+XdTJYqiqpm8yJYsopR/nYbv/siFzbb59UdWnqseVQSvGB2uod2qC/aCbYXj?=
 =?us-ascii?Q?/xOpWqToJghbdoq0RscOrtO4gMzA6fyh95ppHTqE7cBDaXUygveD64q4JdrR?=
 =?us-ascii?Q?FdPEe3WG5UFeqyAd5HYX//GOLN1KUncmBBJdysGcV7qqwtN5deYgFjfWgqBE?=
 =?us-ascii?Q?8+vHLJf2OeJIF0+C6YE2V7Sz/9q7yMujwe5NN15sqzL7CqJYol3TSrYvWege?=
 =?us-ascii?Q?/rFDqcppizH6xvTyt/qVW8mrqPFlVI1C1cShtak3KPFzs6q4wceqoac8WJ70?=
 =?us-ascii?Q?nxHsqnM7VvLE3QSc4op7cUdbQeiTy3ie+aWkJij4A5vj7OUrEhFcjU2StR19?=
 =?us-ascii?Q?2UY51CWsz4BiAex61Ry3nDPhRkW2FDG1jb8AuT8QZtRwsL46uruRkc/V8Nyu?=
 =?us-ascii?Q?euTZxDYgtKNzOOkUGHuSlxAILTvMrlkKurivt6RXkllR1FZ+rzMUiboxMirB?=
 =?us-ascii?Q?R+xJmgV3+/1+4xAiPN9kmkXPP5NXlama7E1HA3URnv1U2w9GV5t5JaGsu34u?=
 =?us-ascii?Q?d525441cdChmkFtNlek6pVlarQ3N0bomTOkrp54ige/BbwI34zQAHzNmkGIp?=
 =?us-ascii?Q?16hVWecw7HgsNXBrp8apmH25f5EddfD3LTwxZPUc0EWT5nN3L1C74CIaQmo8?=
 =?us-ascii?Q?rPd6obGhKRjigZrCIIjJgROeIJJRQg4R/ThupvT1TGZbGRix0ijUwNOcAb3e?=
 =?us-ascii?Q?R9CM+LgLrKgXLZt2nfbuNrNrlEq1dW+p7FBYNFej/e/Vbp78BasXZqae8pq3?=
 =?us-ascii?Q?wy9X9rSuloAc9ydQ39yg3VapSgR3lRv8JrfJ+uGV4iL4j81wuKlvQCSPtAdR?=
 =?us-ascii?Q?LYVBGt3SkL/hpQCipVhHj38N7IU4lE8gBSG5Y6B2S8rvEFbaxxTD8g+KaiSk?=
 =?us-ascii?Q?bKFErgiMZG7ZhQm6HhbMCV52g+3f3xCqtIv7ExacQWa8rkSYtz0nF/rVc+/f?=
 =?us-ascii?Q?Jk6VRaiVhE1v5o+zUPGOsHoLqWIj943E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3umOnXAFpKpnAhRpLanx4IF/MxGYXSaXBpkrrKys+nCovVfUP5eihSDMf+m?=
 =?us-ascii?Q?tybzMm8l7fYo4M5Jl6z3/GpHZIEusGuC9eI7w6KwAt1xBtUdMZ+Zy4k4iYWQ?=
 =?us-ascii?Q?a66Wg2t/xkTLca5+1ZbMIxTQyAyrIHoDM4vRx85o3DT+UU/pPr24baESV8i1?=
 =?us-ascii?Q?b483psHF6vlJz46TWK/uRhVp00epB6jTXnX+bypLtfw65eGlGY6O5uiPLn/e?=
 =?us-ascii?Q?wQBCef9s3DsjxCYi0QgfqzZSvbLBSLdWrU3CkOwlEODEARSYDaoO62h/KRlW?=
 =?us-ascii?Q?K7cnAoidnXtfLyDDsNjHBQF9UZmpnXved/PFdNaFfeVcvh4i1srHnsy2iCRq?=
 =?us-ascii?Q?1AQ/vP06mRGjcBFgb7tYGOT15+/ZKdoo4u2CQW2uolxR0l1InNkk1f8t72y2?=
 =?us-ascii?Q?LAeBJhzoQEp8m3dcXeo0zoifJcfGTLjNdd6xmRbLHaqSmVe/h7sb6aMkEokC?=
 =?us-ascii?Q?5vXektUT//UFKvrngdtkbh6NWp1JPLMVTsW4GZLVUoD8bdR3LEAgENSUe1Nf?=
 =?us-ascii?Q?ODfwkCI2DtnyQ4SDp02fl5U9hw06btoaUo2EqgoofamzozD4gxqEMl3JGGNb?=
 =?us-ascii?Q?uor8J1datprM90VQz7HgAZQAT4DBM+7N6Dg6LaE07ZDpkBa0lHR4x+4hPHhk?=
 =?us-ascii?Q?fB6Pe6bW//Exam8UNi6M446CDOygEzZTKAZbCJIhOJpqJWagSfeYdyuZrewu?=
 =?us-ascii?Q?e6vAwng5hnMILfZcze7zv/LMx9zp31vsr624rlEJj7sZgfvXJ2btKWPRSl7J?=
 =?us-ascii?Q?nkcF7VbVDiGsYAniZex97KUaCKUMmNWFKE0qk8iW9ADgWq22q+JTB9oe3vSD?=
 =?us-ascii?Q?qJsACxpwoKGwx0SyDJ/sJ59CHOKCO844OPgL+9z8TOO8N9gIX1eqFOtMoI3a?=
 =?us-ascii?Q?7tVg3/APDfg73wpA0KHzuO6iSBZ6hYeljW9TamS8nQgV0IwaO2/KuDTOOe/Z?=
 =?us-ascii?Q?mZ7mLIPWTKJA71FtAJdCJgtp1kqi7qHqH9BSmq8m9wjEGmbFeJH+DLZAVfp0?=
 =?us-ascii?Q?jjda7ssHHSeEPh3wL1i7jj9Yh3tbNiwtkBHES4mJEWLLJlyvpAaeUCN6oW9P?=
 =?us-ascii?Q?pNOxaALOtC5IXRPQuhpoqHVNg4i6BlRnYwN3tomw2uaTWCAX0foDEnYEnx58?=
 =?us-ascii?Q?ZR8kQqHOac8/bWiQrIfzqRe/+cnGs/bAMTFL6DHMDZMxoQR/PTkJEfubdoJK?=
 =?us-ascii?Q?x5wAX+iNUZL/Gb6yNIvkeB6x38AMSfSHkzZ+fjOO12/FpGW2o2yqfOa+WnP8?=
 =?us-ascii?Q?AFS4XCECHZYAHpd/iqRNdob34/6QEIEg2rIj+scQuxj70mYCV/qcVc8mvsjB?=
 =?us-ascii?Q?XGtCHrVVIk0GnM3s/301Bxk1hF7du4wM1+g2KyW075luk7z6qB6ff+4q4Y8L?=
 =?us-ascii?Q?Gncf6LiAJ6XvT2xcpmQXAri/eIqLs5LgMfBhmIri9m7OnInS410iS8GHKWw4?=
 =?us-ascii?Q?PGVDR7sBFztV+8E014y6NpP+Mzn8WnuigG0GFAYVyWfsNHJWBXIpcDjPTCWF?=
 =?us-ascii?Q?sHYZAac5U5dqk2anm+wJoo/piC5PnAqukxEHbaZ4yt+WiVP5hoYH1Nz/Obqx?=
 =?us-ascii?Q?fanz7AYBZxf9tYvhKNyL84ZROX0eOKkRRNwnpnLMZwQthvL83fXsTmwo27GH?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07208a77-19b5-4ccf-3b4a-08de0641be39
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:07:36.9438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYkniMbOyhurKvt3+d9i6vRzVvs2BRTWTySUrNYHf3oJloOL9gEciA3aYVvdPHR0dtedYEVLYwHQMoYz4APFWDHM2/3KmOcnoM5yIVsFo/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
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

On Tue, Sep 30, 2025 at 08:27:14PM +0200, Shetty, Praveen wrote:
> Virtual Control Plane Function (vCPF) is a SR-IOV Virtual Function of
> the CPF(PF) device.vCPF is used to support  multiple control plane functions.
> This patchset is for extending the CPFL PMD to support the new vCPF device.
> In this implementaion, both CPFL and the vCPF devices share most of the
> initialization routine and share the common data path implementation, which
> eliminates code duplication and improving the maintainability of the driver code.
> ---
> v5:
> - fixed merge conflicts 
> v4:
> - addressed review comments
> v3:
> - fixed cpchnl2_func_type enum for PF device
> v2:
> - fixed test case failure
> ---
> Praveen Shetty (4):
>   net/intel: add vCPF PMD support
>   net/idpf: add splitq jumbo packet handling
>   net/intel: add config queue support to vCPF
>   net/cpfl: add cpchnl get vport info support
> 
Series applied with some reordering of patches to next-net-intel.

/Bruce
