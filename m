Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCDC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234234026A;
	Thu, 13 Aug 2026 12:18:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 502CD4014F
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786616280; x=1818152280;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9gl0OnuHx23t65oTHQMfR8M1eiekSWD0ppXxkP5Uia4=;
 b=cHZr1Jo3Gyd3K4DCKreHTYYaXrn8nmuX3xdYu3q1N54KPtFhBmxqVpUB
 T87QeEHna0X5CGTtOsoaOhCnHGnNaEzjYKc53p2wgbHNdSAeccxGWxOUA
 5mzW8IetW/eDggHjK1KDEmjkNSKqFKMGPl+55N96W/sfBco3pWaMBwbRh
 uNG06HbnjIFxiuzrkqgLlJgEwv5LGZSKmXBGAD/R52ktfhxxyH/XkHR1F
 7Xj8MXUY5gz2RGqccOq1wtz36AcNWrNRgcTb+kXnV9R38Sw0o6pX55wcb
 cHOd0eiPxvOsI3E3pOjZxBfcIrypQDVcFlk43KJcXzZuEAY8F1+LlOiAg A==;
X-CSE-ConnectionGUID: 1oHtevXiQ9WLOh/Rj+Ltqw==
X-CSE-MsgGUID: Yv/kkEvlRZCAVO6OIhO8fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91061065"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="91061065"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:17:58 -0700
X-CSE-ConnectionGUID: d8A6bA3nTpiKY+i37xKgsw==
X-CSE-MsgGUID: fW5ViGLtR7e7v/SpIpT2EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="259653463"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:17:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:17:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 03:17:57 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRYIILs8nMvYf3HNXsXp40yNDnFsHft9LeRGdXw8aaRi3QjZe/S6ze3KIQLl0Yql7t6Lydi/K801TC1SJs4sVWw6pxsFBdZar8fquWYrWTA5RjB4N3emj6ELDkdQDfM2juD//gLmhh7q2jFik3CpSzBXb5qUs1TsZsxjB21WKoWiHC7r6xjLW/SbG/YjdGWjY143TXf6gC4bnkY/LwaUT6hLmROOWnkSFgUO9ucYZs47CRyHiimSvIgtGnE2ezQIwRZ6184Ik1nsvyccVGCnDkRLCpWjGatvEAOtWmgiJRwcQB6LPBglFBRqbIGBYva6hn9b+yBOxjv6njQKDR5MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5kowh84LF4CuBVYts8Eu/fag0+F01eAj/W1eAyu2gs=;
 b=dQGUYgbeigG+PFL3HupkvMCfNDNXCKu0zwXUYcHbrBioF5tndj633El8amF5L8JrEaycoVpumU6Qn9PK12HStvCeMTslIPZHk4o3w02+J+FNDBMdesjmFiGsnuBqdpXSCCGml1Qw5xUMyZmnjHMDdtzQvrDurAp7gM28Ul3LpGLHgpKmS3i2Nw9aFCnh90sKCiSNNBBS4dOr5LHuQyUa7BX6JRCXWUVRoDFT8pwaEuvG6hrWSoglZhiO3PHCqj4Ms0niHGg7iN7GNWEx3o8AwkN0YjuMhLBY5IOTIjvFIaOaaSyrFHjChhAZf+b2qPyzsuy1ugmHSxK190zmkR4E0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN7PR11MB765673.namprd11.prod.outlook.com (2603:10b6:208:5f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 10:17:53 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:17:53 +0000
Date: Thu, 13 Aug 2026 11:17:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [RFC 08/32] net/intel: replace rte_smp_rmb
Message-ID: <an2ZzTKocmpHwfIS@bricha3-mobl1.ger.corp.intel.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729175715.165120-9-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::16) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN7PR11MB765673:EE_
X-MS-Office365-Filtering-Correlation-Id: 52de786f-6b4c-45d7-22e5-08def9242307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TJGPJ0ten/SzEnemyKlDlyiZFzufjYOT/X+iIMWzuG5lKGxJ0bI31SmrRNzp6tQo+k+D+EOsF0bgzdm3p78eMHPUTcoRNYcwcaOQNhgGAYQSafYAUv0K2mWZNEB1a1dWtALfDlP88OxxRlm7hGe+6kYk2TSQ/Hi0CKy8LEN2B+bIVJsOfc7UdsgMRQvyTqieKCo31nZTNy9cXR7S1jt2+f2FBRC0jgKqIsC9XnYbl3eOG4fT5oi/1ABkSldSTMkcs+vwn3hcg0wdmXiePKUsAUssk61r898v8IgFhg7oNfO1oGIVvB8+MVot28WihiyTuTf52SOF9MCVq3gxQvyp4zWkcvU34UAEBO+HmA9PU4kTo0MLeO4BN1djsLsmFVD/RIkuG85rv2TQYOgiA8Dh2vyvvlaDKsHDNBRH2ixli7/+Q4bEPg+kATMidezzwI1Dfh/XDkeb+08k9EuQUNn/ojOeDPcInCJAbOwzDmdHbiFOdqkfrigWoAFRHTSf0I7fgKo4PyALG5pttId7ab9cqnXbuet7Xe0VBc10M52Uptbd0Bs6YtwVQMR/DV69BpTIfdJfVgCdT26bh1ZPLaqePc9FOqC57P3I1+FH1NtW1pIBnH7hnpA+B2tnRYzNy9StD7mKPm+wYgP7aO3sfoV7ihPv5RbrXeW8U85/SiF+Cks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8/Igoh90SN4e5TQIB5Pe0V2vGUG7aMKAbDhcwo3JZ9WdXK853zKgYLoDhqo?=
 =?us-ascii?Q?bv47SCUsaNBUpc/QwUHPOp6ycmptGiz7GsoJ1SBUGwIKOJc0FZIzWZ6TTETk?=
 =?us-ascii?Q?MueJRxWI575JRSzHOFcI2SepwUUzW8OxB0tUT3oZJchbLaM/T+mhnpSHknht?=
 =?us-ascii?Q?2XfokyrFr7jztFpi3CRk4R9mTwbFhEd9H6qicXoGpmRWzH9M8EXIRC3pM5rg?=
 =?us-ascii?Q?FAklDilu7AO4VyZigiAazDSCBNGzKDEW1pMvTmn93NTX0rV8zfixBhD4A91S?=
 =?us-ascii?Q?XjTfh0r7sXeAN0b4TsGTKoqs7HaGj+GuD/fTBDrX/2tSWtVJnrreenkmnC+1?=
 =?us-ascii?Q?plV2ltDWFPkYwdirflis+Sc1b+wSJAxtk2CWHyFSYxsjJ4poPB5y9rDMAcSV?=
 =?us-ascii?Q?E0XCbl0ap7jCiiKqtW/Z2RFLZWvhZnqpnsOMvpxEO1mH873Dks4Q8Ub+zoJe?=
 =?us-ascii?Q?hEheGzl6wLvJ5V095MWZJJ6szddvj9CDY/uHjQ/yffPlf9qRsVd+CGdBgvJy?=
 =?us-ascii?Q?pgyVrauzEeYkgWCNKsjm5I+0CVxBmHyOA0DhsMW9mPiJK15GzTN7f3bPuJoc?=
 =?us-ascii?Q?HYeoGLQetglvj79fp44xbd9BORyctZfmhzj8v4sBBOnT+eFB6VVApiFOlsPd?=
 =?us-ascii?Q?lMGtXhN7l9RYsWuhGC4cZOEjd96H7H4C8OHV87dt6W6KXPifdHrCMXa0Xurm?=
 =?us-ascii?Q?AlcI3oZMkvsY+mhE9GWL5wGLBIvr4Rus7+5XenUrLHzbcNayde5jvQOwA0F+?=
 =?us-ascii?Q?gZCkylVFacKYoYCAzLhWCMw2685pBnxzsIqJKieP7zlwNJ4tDMYrNMaOcOwS?=
 =?us-ascii?Q?LVcMj231O34aJ0LGQiSsAJVZvpKYP28ftvieSAWOdCeXBX34ggNTpvPrNq9N?=
 =?us-ascii?Q?RHb8V8qlO25BVihe+RtSNQf8isNkePvl8zUylWYPXHzpqArqse3ibzEsebTm?=
 =?us-ascii?Q?g6dlDhbF4j8RzvHdfoDq5ZrtLH1SvZlGJPFnOE4kxX1qtjCk5XjX3UKCY8FB?=
 =?us-ascii?Q?lnM45mp2ncBcHKj98MFBRsodiInNx4ohKTkPA1QWWb25ZRb4jjkXFhEW2r5h?=
 =?us-ascii?Q?DSZJ9C6WzGcX4HwNQSbRxAOcDKAPUJ7ua9KcJLXsI7ePIJSLmsYdV7kkuGB9?=
 =?us-ascii?Q?c1Uad6zYpNYl3cYyVo2TWwa07n2CsCNAuqa83v9rAjHhN3AmOY15Gh8FjEUY?=
 =?us-ascii?Q?lb2Tre/NzeakoUraciH9XqtIWAH4W09jBkcppRIOEOkt9Ico2pyp3q/UmomH?=
 =?us-ascii?Q?D18puCAExyTfgwUIdLeRHuKeuSyl5p+imrOv9LSXUHcFHhx7/YcDHoT7EdNe?=
 =?us-ascii?Q?gf1NtiyQ+VlSDGLMMB8jn5Nf4CxzQmjHzWjHxr5ThH0AbSdV72JA2DBxKqy8?=
 =?us-ascii?Q?6HYwNA/8DL0O+TNxslEr+jyWlLzD5PVL3bwRmi9fggFn+9J0j1ORTaiaCq5O?=
 =?us-ascii?Q?/nCUj/ZT/nAVvZBY+iDZPQOJ2++2a3f3ynP3sN++vR9FLWvzkehmNtWicrPf?=
 =?us-ascii?Q?lRPV3KrE37R4bi/r0El5KwjY5gLZwiFRfhTpjkERtxNynxJlP55EeIRL7FKJ?=
 =?us-ascii?Q?hGueJMXhAzRDqqTMty8EWLZvgsbT8KfgudnqRxSGTfRtQDGd6UnNULpAi/L4?=
 =?us-ascii?Q?atLimuKtwtg+RKvOpYl2XmItAYRmHeE7BcXRhrpE7pHxZUlWyJaOaFqXJEs4?=
 =?us-ascii?Q?JluEQC1PgP0gI8wMg2uYN2is98FL1ETuY/dzAbhHC4L1q9UCaaXqaZE76iH+?=
 =?us-ascii?Q?N2r1H4h4H8C59/zxsEWvMHIMcYaYwr8=3D?=
X-Exchange-RoutingPolicyChecked: Aa94qoYqpYzwISzBbB2PenCiY2CwGu8JAf46KWJbQib0jVOAm6vd8ZqcBIk9bc/qKL22L9pSd8GS1e7Nsz260er47VmpF0A0bOMHohy+rOIm0arzv58gdnmtMRKYsmltI2w5HMhKg/ubMulXM3n/2DoJnPKiGfMu7hiBVek6JnXqvSeHca+FLj5QVOZXufJe6xq6Fcke4R21fyClnntp98epnRtVrXZ7LMcXyKft5+xZpOZEaJ2f6t2dDSi2ANnU83+XJudn6+xiGyd/IYsjg7tRM2jjmreHUHaXPYXrYyRcCZCSVn8bBZK86f91M0gOfKBiTAudx7osXy0jDDY+xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52de786f-6b4c-45d7-22e5-08def9242307
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:17:53.7079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X7XmVXyMTBxJxrYjnCEQOriP403BL8i2SgHC/05GAEKPkZ4A9XoZKu4RsRUwXeTqQqRG6Vq2lugnGekVaRiEdVvLjDcbk0G4US0gTCGQWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR11MB765673
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

On Wed, Jul 29, 2026 at 10:54:01AM -0700, Stephen Hemminger wrote:
> Replace deprecated rte_smp_rmb with equivalent
> rte_atomic_thread_fence(rte_memory_order_acquire).
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

