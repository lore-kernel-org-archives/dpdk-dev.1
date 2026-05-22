Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A3CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 060C84029F;
	Fri, 22 May 2026 16:34:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DCDB24003C
 for <dev@dpdk.org>; Fri, 22 May 2026 16:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779460455; x=1810996455;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CM4pY5nWTDK8LBpv03li+F3mdrrJ6bThse0/Qwq8NO8=;
 b=haGGd7cdyyFQETXAxV4sozogEuNgEy4eGH2AYl7eVY2yY93wPgFPw4fN
 u1Zb8xYX33zW+r90jL13EyM9B2Q8r7xgoRwiVCi1eEBNk6bx3YDcHeQsF
 Fu6u3JxiGgr8agZeSV1JNaA3jwZFMzsVqGMICnfekVuaMBZNF497fT3Rf
 yXE1BKW9M65urg2UQuzQCSjFxUAWyrEManxKGiaBcF2To8gR7iXP0BJQv
 36PYreUJhGeih8mpKFn27a0fmo+uuZ8fT4hBKoWVvcjhiV+lzJY1WmcTI
 xfIz0FHA+Z1pO5W6Zj+ZFsRfrfasZ18GnSdUnPv8589EcgSiwlO1EhXX2 A==;
X-CSE-ConnectionGUID: QYonvcCwSRuL9skqLZi0tw==
X-CSE-MsgGUID: 7NQXhX3OTVCbonaz3hSV0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="91862096"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="91862096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:34:14 -0700
X-CSE-ConnectionGUID: cHt0im2DSYW0qffwV5eHhg==
X-CSE-MsgGUID: aXg1x3SoRZWKu1gjmvpZdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="279037432"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:34:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:34:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 07:34:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk4MUK9G3KVcwuUnJi8wVI1eO3Xr3jpaWLrzsY92nDJ10bSAv6o6zUkUyG36NoG+BdTgtaIK/1Ry/wiQs71ARnYLdZo2WVKh1cPGXOJ+CkKpkoEARRIjMXt6TV3jFJGpBQDdlCQhejBBKWI05yM0OP6JivNH0mOqLll1t4DvPvTR+XygLUY26YaDG/R3jegL6yLBXG7SFIKrzKy/bUtA6D/uZtJHrJYH2vc8InklnRdwk5uAKubUUA1dqZ24kLlil46T9rmUeh0pzEhDpMbIqCHWY8Tu1XAIYSHegjEo7SLK41dRyfFqhYwx9ylLJwT1Xxs2t4zWa+RanpYrGqFVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzcdWpfHmKRaK2W4QE93LzVoEpL41GJUYYsT75ld5VI=;
 b=ZzyfoKj/frGu1ekoTcGl8+jj/tGDRs9Al5f4a3l1ijB7Q9W/9JSRvOK/uXr820pmPgfa3miDuKSseB2+QPlUDs/q58WRw484Qq6ad2KdRuv0y7QjBg5HD5I4R4NT/WH8QW8p7XoZjMCa56EIKkDNq8l8Cu+k/oIcFas4PBqNyLVDMOxE6wjQmsF1zMxq9EFvtWOh9VbSJKrdMMmFMg25STKqYwhsq5D0WKt+XiMZxXDpClfWvQFzIfJfYmZgZrzfa1JFgzZCDn0YRz3nVMgM5EdFrCdgxnzvxdnF6oiAx/w5jzVOzHQv7JjfwYudo9C0FtM5ErNvGi9DVtz/gfVmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB9613.namprd11.prod.outlook.com (2603:10b6:806:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:34:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:34:11 +0000
Date: Fri, 22 May 2026 15:34:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 <david.marchand@redhat.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Message-ID: <ahBpXv02NBIW4dMH@bricha3-mobl1.ger.corp.intel.com>
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <agyL7MGOLfl-GdIr@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agyL7MGOLfl-GdIr@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB3PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:8:1::31)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e64089-9a3a-419f-05f6-08deb80f30ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x8hoRlYjKwWS4LfMKOjUXbI0SqJwUApE0aqu2UU+BNTdT/wnLATf7B7cx9jLLKhKz7MuMY3QKiIYxdUEsnRtJqQacxcPmrXY/pH/1sQgSR1PHu0UWjgWvXLJSjruc2D7bBgHv9QvSa6REZcsGBL3a+GoG9xr5HMxHdRebzfTzJe5fLlFAQRsjJDiiVQOzqDivAvIgL33rlX/23xFS9oupGFShuAKxAT4TEf9mDkIKUZjMu++5snzvroZnvRPO+K1ES6tbOIyuvMW8hn9aXL7ReS7c45HV7GjkJostYgnQo6liXz6upuFeTYTcuj+3CpdZEM3RTQuLZKp9zvb02X4XxBmrd+xaxKnD/VAJG6k5z4er2qGb15GEFEc93q4mwkwUP50ih+GfgN1LTfxB+3tSRn0HbV0MbQRLYVDitfpE4rGKGV1LEHrJFBS8sMNkA9THoGvvyt/reztUHfhRuLnWUuEsLMwA5KdWgtP0Bn72Ve8KsWBWrbGGU7HXvB7Hu0IhnLU5gfogvIpq2R8aVFrV0IxR4Fntueat2pDzp+rcbbpm39g6FYys6yYsO91BvpXXKvp5uMAtWINMdi6tdoix+RZgVcYE59dLIhj4VjyrSfhtvcD34/vePeI6v1f0yjGT/CsFzVXagab9bRN4mUbCn9Rss88nLrUg4f0RqxsDihsqKbMpZftgyzE7rlD5taj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17k6dYhlLm4H0Fue9tR/S602kHRO/OT5LONMeuZzHKvc3skXYtgqIVfPCT/u?=
 =?us-ascii?Q?oOGx64SlGpifB0Vfrx1bGo4pqbyGcz7Ue8/MFhEvqRsak5/s05HdxCXMnY1E?=
 =?us-ascii?Q?09QfT19gTgDI723ZodHdZRS/6wC3QmO/oGZjEW8ySKUl8mcg2nbbRR4779M9?=
 =?us-ascii?Q?zfUa9xFzi7FkyRmbPiLXAsUZjNyRzoLHY/mHVYOeKhBKHvWHU8FXJ3tbX3h/?=
 =?us-ascii?Q?RToXykaKyHP97BPBZ2Gxa0EgE34SarJRO3o9qdUmrRE29Kp1gdUU14kQ7ET6?=
 =?us-ascii?Q?MgEYqvnljOG7rj7ZvNVb9amkVqk9zMiRqEM+HoBrDv8IYx//1RV/wruyO8qH?=
 =?us-ascii?Q?tpIP0WL+aj4IrPneDm3r5PhvP2ofpxedKDGLn5SA/anCDakcs2txYhaqVySk?=
 =?us-ascii?Q?r1/+PKO+DeBLbYKkZVEveF+pxe/yDB3LfPL7HiNU1rMTOhdrYY17f25YL5Fc?=
 =?us-ascii?Q?TY/qrR+9jt7aSd6AqTvih0ccyXHIUve6KcuJ3eCKfMeU7cQMkBfoQIQSh4gX?=
 =?us-ascii?Q?I1CVVX09qT5ci8fnSqY1vc1Nsbpqf8/6PVEwZMSuEcRIU03b1/hwjVHRauyi?=
 =?us-ascii?Q?yWzVR+O1kgEUM31m+cWJb3q0+Zzk3wHl9R0Jr3x+kBWl/UTu1D8xcLQdEex5?=
 =?us-ascii?Q?iCd+ma+fVgymeWkksSCdtVUuQkTav2fnkaVjwAVQ3FbxpkJl4fUkA6eVRU3c?=
 =?us-ascii?Q?LAINNGWt22ntNA+3CsSfopc2poWezGFHsjmTbmvW24o/tAkfdq1BbqRsrIM7?=
 =?us-ascii?Q?YMPWfiKLAFDFgrt+4ECR2Vyzx+5U2F+veWaZQmq6bECnHITgWZ/LiLLw3ACs?=
 =?us-ascii?Q?AtjOeoskqXfflB7yGWJ3ukPYl4zNTRXowLdAL/BZTtKR5CMrCHqaXn+OFKxx?=
 =?us-ascii?Q?HhgEAWn9p0rXdxgSqnxhJ+0HPexYs2yZQM0mtTi+Ag0qSv6/AXiFx2xMFxqs?=
 =?us-ascii?Q?b/1YWPj/ZGavASN2s8eZYJBFjOCqrm5MqSWAw+LIbaQfLb1y1JQoT5KtIQ3T?=
 =?us-ascii?Q?p+fH17Bx0hCHC9lHe2rX/IpURqwituxgg5LU3LJHg7N+S59kSS8oBHf/fPUG?=
 =?us-ascii?Q?ToVrzbF8DxRzHIqlxKc9OZXfMd+XlPPRNX5Yt6dADmH4eHfIRo6YPR8mHtbl?=
 =?us-ascii?Q?pHRCqpcVC5BDjJYKAB9G3XzoVuVTizQK4PbiAA2tTEqab9oHtOYlnA7dQlKH?=
 =?us-ascii?Q?GmtmvGGvpe+MI72q+7Dqf0TAiZna3AJLVZMT+29axXItkzdo+E43HzAviNAx?=
 =?us-ascii?Q?3WKv1S363HmGcAy2dhvXM2Z1DCt+S2+V5TGrHyhmZ4d45CpOWr9NVsDxU+tA?=
 =?us-ascii?Q?9cXHTAVH0VCpJkH0cfMEwH1uu90p++vefWtgff0kVR7UlwRrkUX6D3eg+hAZ?=
 =?us-ascii?Q?BlSIJioRytx3N4+yyb6dQ/cxasi4twg8c36PevHaJcNkxHbyo01aFXFuaBQ0?=
 =?us-ascii?Q?SO/iWvIeQb4uDex16/2lWNWXPIeOC+HZIfekbVjFvviXMIi8JCPNtM+TYFOc?=
 =?us-ascii?Q?3kexvElCKLXdS0dUV0u7XV7QEwnKeNUtL33xsHwUo7M4sbLFtylGysTzCydm?=
 =?us-ascii?Q?cFfz8Bhj4QPhFfogIfAeVll+33LtrjNwo7MMasSZydfuJtTU8TBUZU3YCUef?=
 =?us-ascii?Q?FjnYQNCw61WCJ/SjT1SWCE+8UjDhrbR0OZZiEdSWQ5fVFKc6K9YcBm75TX40?=
 =?us-ascii?Q?za+E9OkzD453JchezxPNRmFfyXsZXNgs10etR1o2MVlqbmDiau/g2aq9YqvC?=
 =?us-ascii?Q?kbXgEpWe0WQNmHPFpyvnVnWEQ3u+sRU=3D?=
X-Exchange-RoutingPolicyChecked: PgkinyW9NfxGdCEkmNxGvjRKBjhaSaSlL2PGeBQN6rRayt7aF8RR21A0Zjrnr+PJ944CZjMQsL3AYs8hSxvXYuMk723aB41SKxsBpgHo7kryQ2GUthVhJhPGND2Sj3XPWgS6W/t4U3chrFD92SKNccddTcHHpSThvfLmOdbR1DHt9XEw5okAe+FfViTvmb8fHR3l8cXADsTlCMNwEcD0QQEQMawRNwOax35a1FCWsWkKdMRojgBKwgvKfhgQSXJHby5qVaqC/GOCj0URuKe+rt9sAWBrniViIGKl2r5ZcS7nz8Yi46WVYzfKupwXjRvC1fbI2nKs8+3uo4jXcIuTiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e64089-9a3a-419f-05f6-08deb80f30ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:34:11.6264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYtt2Vusiv8gGDihB8Fe/4K3IdCLB54Pf9gMO3PTQ43fStGeRFQU8ZoKLPCkugNmnY4QhMO7XFCP/3lAEq3vtmj9DDwapOwGj2NG0EOQioI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9613
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

On Tue, May 19, 2026 at 05:12:28PM +0100, Bruce Richardson wrote:
> On Wed, May 06, 2026 at 03:07:03PM +0100, Anatoly Burakov wrote:
> > The PF will check buffer size for being too big, and the chunk sizing code
> > correctly calls that out. However, the size was actually still too big
> > because `struct virtchnl_queue_vector_maps` already had one queue vector
> > as part of its definition, so `chunk_sz` was too big by 1.
> > 
> > Fixes: 292d3b781ac4 ("net/iavf: replace unnecessary hugepage memory allocations")
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to next-net-intel.
Thanks,
/Bruce
