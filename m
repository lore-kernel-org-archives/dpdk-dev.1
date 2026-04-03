Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566FE85372
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 779DA40296;
	Fri,  3 Apr 2026 16:20:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6DD5D4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 16:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775225998; x=1806761998;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7QwtesYXV93ivqG4gOzz1ABlx1iVt4A5eaW5RiIB5uM=;
 b=bsOm6wVQXIUrlRTIvtdbJUfHw599LU0OdToIfSN6+DVJVENeXrmnHzbN
 I5hlT8l3W4+xGh3CYoH3ayocc4vZQoRsnCF5ziVLXokDtg0/syXNE9eh6
 5sYkEmT1pZJOQQEbmEvsWLMfzxzy/stp6toabytpcNYZezPEdEK04G5gk
 j4GqdzKoMN4WB/ke9/DWNLOm9RTm6ttXIRPOThBCwtUmG+im8afqie/Q3
 pv4ESFQtBbbk3M1DwilJuc/S6nYBjd4Rh58ZxPO8BocDP5q50akS765q2
 H5Ik4BoaeoKiPTC5G8Ng6jf08UU7CV2W3aMyeEkZyPz9rshxwBzZe0Qf5 w==;
X-CSE-ConnectionGUID: e2mDWp3sTHeMktG6G1y7CQ==
X-CSE-MsgGUID: in46PT96QjmeEv7fnqwwXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76182780"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76182780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 07:19:54 -0700
X-CSE-ConnectionGUID: O0OwWB8tSX6TJ9eo75gVig==
X-CSE-MsgGUID: 57uZ2P0rQ4aZLmeGZ+eNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="227135705"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 07:19:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 07:19:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 07:19:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 07:19:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Akc3fg0z1cXX2ghZwLiAkN4fciuX1sPIfPqphrsznLkeMuKPypkLSoVgGla/RWX7HhW+dwKnXS2Pt5J8jL2nS+oVrjru1h6+QnPQ4ekko3JybiUOGW5THQPxxd22+lK/IlcvmWqVhe5TU4FsDHHg/vQ59urcet78H6vKR1nHlShJFdrMBrwbLvG6JW/4vA+8MXp6yeA7rZROK8kRuWiJgDtGsp067981iefODzhvXMQdADc10vELg/jyPHFnZihTZ9F3odwD0Pg8Zub2t+HqdH+pcgNqCj+eCRcWByuq/MB2r0hvsQ+w+/1GYoEjWch+sj6pKWpCyCv7Wg7/+b/uFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6t2HZExvl+rYe8fWimNMV/vuhnKbAavVT5p4B3K6Qo=;
 b=JMcYKEuvjKaYZU7WZPlXeQl7agTt1xCt21h9QVow4/dKsPXO7QofOk914ORlkYptJHlahycBku6oKPFinMDp1hJFjY8f5TmefNy6bRMw9GuFDA6bsgRrBfJ3Mdq/k21yt+yXaLuVJjWD7mIk++s28BO05ujUjNFG/CXgszCCuByFOuaUzFCxnBV/nCEX+voMRn/tp5BEbgfhaU0t+4Ul7PAkL7UlH438EsbrN2ZNBZkd5aqkPYtddJfrpAJdjSJxyCoEjAfOhx3qtRwI4siZ9Z/iPwZrrqgddi5R9Q/gvOcik5/k0C/C5xG6NdAkPn/pfO0NHsY0Km3IERizm/r1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Fri, 3 Apr
 2026 14:19:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 14:19:50 +0000
Date: Fri, 3 Apr 2026 15:19:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ice: fix FDIR session ID offset for L-bit L2TPv2 types
Message-ID: <ac_MgPOy3qx9uLH_@bricha3-mobl1.ger.corp.intel.com>
References: <20260330035319.2569981-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260330035319.2569981-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 5708095a-3393-4924-348c-08de918c1089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 9uWpmBv7oHo5lozbGgQBWfAmH26sAhszRvKd1/1+mh+lfIOmxlHOsIA40//otTF8AZTmDvrcMIh+WeQX6uA629/0r8bzRI80ckvIchbhAtPg4JXgEr30sMXPpoltUOvRJOH35D5SYa99veXFgET8WaEa64rfWLW9SY5SWBHalCy+wugyJvQ69s1ZVzG95+HSSKMWG5OBY+oKG3bBZw0CUQK1Ga42ekHtERJCDU47q8iYdDRqoLUw+l6b1h5QXjrPHfvRhzK+FaqWdjbjIjCGpV69LUZPo1ha0cu0EfnCrXIa1q5yoqOKLJmvRGBSOaGAQt16HCP/UkupFBZWPNRkib3mN26G+MUJrUnd0ktlSb+i4xIdF28wwapW6nNQGPUgcBkgZpOJlSvyPmsAHyvg0jOI0BUlXQqoQMEbmSf9EvR7sedhc8po4n/ops+DRRlI7fMkp+7lZoqvF1No3d/Ej5u+RvjN5VctOpxsUT9J8kcZGCzcboqJaibzGHxqKRHqVcy+BDHwDsABz6AViauP5NzfjszfhR/VJ2jBF0Otk5TyWs5o2YgeHMglzKrDLrykYMUzkl3K20SEe0LBn7cAqzkGq0wpbU/tK42Pj2NclSVJUgt1NlgIXgm2f2YFeU0WL8b57RO30STJMMYDBZrtlz74oPr9Alo936GsvhB/62WpEgcogfonSzwpr+obu6a4JaJUdeYfExJoOh4LSYro/zyD+3yLwamlNVCfaTR7sOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XS3qPi+NQB8PcV3XggYIlQsd1K3nA67qujJfqDn5V9N/UamPfeWzwaOsnnTa?=
 =?us-ascii?Q?bChPcXwqjNOjcNjnLxRmHWaADkhf47oBpplc7QiMbAcgIMh23yHOB9fJl5n3?=
 =?us-ascii?Q?Inm9O6EEnYofkkGrgH0inZlAA/gg1/emhNVdRLdcak04FpNDIypfDYuGYOb7?=
 =?us-ascii?Q?j2XoEO2MSB4sNOYF/Jw/9pdTFipBB9xOCuBOPZZFstCvhRf35x3gqe7/25dr?=
 =?us-ascii?Q?eoykmzt2Jmr4KvB/o2PEE0UeJEc/o/1BzXkZg7VbxdWV94ksU0AJAufUeXxX?=
 =?us-ascii?Q?RWJuEevaHrmw8U7BAw2IhIU3yvRWVzdljfVWOE2TLR2mA72rS7RYmOoq6Y+o?=
 =?us-ascii?Q?q7iIiTRJrdTRbd/zOiGrKZUqoKXEPmQ2HIoiA78dfAcdYX7QQAjzef/SZbXP?=
 =?us-ascii?Q?cpZs37mZneEGHpD2qdxzm7nFFx+3CqD+VT3ppJFYs6MW3dK8+KVzwlqji7GT?=
 =?us-ascii?Q?p1bo+ejC3ZnEee6yiYSOh8rATE5K2XwjmfwZpuZ7I0DLgOtmr45eFLbE0Lbk?=
 =?us-ascii?Q?FCG58iM7f1yqDaNEvesWk7nC025yAKAdtvzOAfTkf3uoU9SLW0QFVFczll9Q?=
 =?us-ascii?Q?6gRZNaRPCpk5Ih/RSHCcpatrVZ8OCw39+vnZfh8c8iT992N6usR5VLpGJ7SJ?=
 =?us-ascii?Q?7kGixIsqGjOpvKmSXfnM1ONHQe8Lk/D6gPuoFobS6R3WOWvXEqf1fBRlOnjs?=
 =?us-ascii?Q?/qVGPt+x5+ORTtfbfJuwO9qHtzan8xHzZYkzbnQlAhlG0AlEC9TXhV3qo+D/?=
 =?us-ascii?Q?Wf1/CMKA8mO511r8GS2xzgGdOIXZbkUObSJiOwMCdylh9ZDKl4qm6hHtdJD0?=
 =?us-ascii?Q?yGBOaRc/la7xlVAkXEzhZE0L5sTvfmFzXw6lciZeUqx01CVX47IPa90UZO7x?=
 =?us-ascii?Q?+J6AlW7noDCf2acBsS5g2kdQObOQZTsTXAtJ0GpR82CiBbr9VmLVrWz5OQxu?=
 =?us-ascii?Q?2E2V4g/4sdD/IWATMFdOmzokW36T5o2lfSfUOlS9PR5MaClDw77oTcHFfIBE?=
 =?us-ascii?Q?dLip7wV0JFpoDlPGwXsATC4Kruts7FEj1bwvtjbZMasJ/t5F1hgxwyc1vB9M?=
 =?us-ascii?Q?95A0ZDZMOSXraSSzAbswyD/LUWBrKMjE9M2zhM96JssQab3W4peFzDwUGCt4?=
 =?us-ascii?Q?CsSZGmj4h+w7rQzFvSWvFprqSoKasjccS/Tw8MhpUIFuuJt1mQVk7Kyp78NW?=
 =?us-ascii?Q?uDnocDgQ2wbNLs3Gsp3QVHG80lPjSB6s2qG8TViE2WpkNDxBassXdMhp73yw?=
 =?us-ascii?Q?kZAL7boRVYP97uwFd2ydEslan82sagRNmiyPaJivAadKGywaRx1S/9k1CaVz?=
 =?us-ascii?Q?btra3y+ApnJHFrCT/tS5+BXmTaZSNe511e4WRXqUymKbMfEYkKgg9cETxCBL?=
 =?us-ascii?Q?epoIIFBT5VNcbO7qnY9BpkP3z8FadJwLDdOgwqVXjaag2tt362EUVT/eZ53+?=
 =?us-ascii?Q?4Up8odfj2gmrAG6V/0UYf0MTOOmsyB2UryMo6CLHzWAi6OtBakrBWKUaf1VA?=
 =?us-ascii?Q?sxG3RtlpbRQbc9IeeE20To1dSdrxIv3x/FLyYUOTIeWBrFdIbIbZd8biNzUp?=
 =?us-ascii?Q?Tv1Mcsk/hGWax8t9tnlHNvXaexJvgnU8Lhzt+CX+8tiNAVRfU57tiBsintTi?=
 =?us-ascii?Q?g1Kwc+kicKP3vcPWP+Xg+mW7W9qcwvf8j3t041r1YbiH9LhjjA9Yea+CavJH?=
 =?us-ascii?Q?pTcWeufDqgCAUazu9bEGBG/tkfAGCj6HqdAI1KDdpv3AavImRQ5Y6VDSO79C?=
 =?us-ascii?Q?N2aJcuQnlSh9LgPeLxWhK5ZQwdVogM4=3D?=
X-Exchange-RoutingPolicyChecked: sdJSOPZ8Mlil0Ji12n+lQEW3BVeL2N7T6efDJS4sshDaXgpyugcn3x71hCwLUZVNaKo6jkWwJJPPHTEW+1u7iPbqunWMOCDMe84pDve56vNWopfbs+VjwRG8nj3mjcU387i8VEZRyr+6ZSPR7/NWkQ2bBMajPOIesy2fkGTbmA7SMKiYDvFw6CZ3rFfSgVdiUYdxneckgjNPVqFVqm8LVmw6pU7E8FnhyRjqBg0uaJ52WOaRS5GHu4yPy9KjjzA+yoo/zBo+1AX5EJiivV8xFVB7uU5AJAZ8osxvpyM+4cj7eeV9WDU4vKNXigctkASsEfhJmo0XJYr/AzYCwV6j2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708095a-3393-4924-348c-08de918c1089
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:19:50.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/wDT437KU9sBB2uJibQxUcZsxLCgA7JZun15M60LWj+E5rgytYINPDPiWys20FgP9akmsqNBVqlb87GzQOyGm8qau0S/FChyDq1vMNBdtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
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

On Mon, Mar 30, 2026 at 09:23:19AM +0530, Shaiq Wani wrote:
> L2TPv2 types with the Length bit set have a 2-byte Length field before
> Tunnel ID, placing session_id at UDP payload offset 14, not 12. The
> driver always used offset 12, causing FDIR to match on wrong bytes.
> 
> Wire up ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID which was defined but
> never used, and select it based on the L-bit in flags_version.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c  | 13 +++++++++++--
>  drivers/net/intel/ice/ice_generic_flow.h |  3 +++
>  2 files changed, 14 insertions(+), 2 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
