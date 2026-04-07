Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372FFF510D
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 595F840293;
	Tue,  7 Apr 2026 17:57:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1014640269
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775577444; x=1807113444;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=70vDms6acNIj9uc2fuHrI+U6LXbi5abEks4dxHpyyXU=;
 b=GGeoNiUXD+JH/MGVcuwRGO+SRY692R9B0B2bb9YP+VFswgLFeJ7C8HgX
 T8CsRTkwoVM1ragfSLjQU1pr9q3WcN7T+odOk/H18cE7Lhos2wSOp35Yd
 /FnPvS2IJw+S/uTBXdoK0TkivQ5SYYOXMm6dUwR/6zgonu98Tg2KqVTmc
 vpQ/8r5WCEdcDOiMBAkO8rT2ccgMOfA7ClT2W/XV9lDI1p90AszNjW6Q8
 hKC6brndha7OmEHu1bTOS8jTk5tDtkZEaHPZAKzYqON1/nH8/Z66g+471
 8QILd3TihKM3ZHjznwBkaK4qfh6mwDdzkSsTZprm2iNt06GaFrXkMd5Oj A==;
X-CSE-ConnectionGUID: KPa0u/mETMC8G/8AMuvjqw==
X-CSE-MsgGUID: SD1sYtBIQUarWb0paYP4bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87929780"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="87929780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:57:02 -0700
X-CSE-ConnectionGUID: ZCQbctVlQdiEGR+ZYvdDXQ==
X-CSE-MsgGUID: zCmwAberTm2L9o6excVvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="233082118"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:57:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 08:57:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 08:57:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 08:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+hFrHMB0liWzQJ3SPxI0JS4xRVS7eBp82gAA54xaFbXScw7Q5i6IGtE9nTZKEkFmxqHXdzXL5M5TGu5AVFcQ4UpZSD1yGIBn8URN1VmTRq7T231CUOoe+lgscjEIpYXHk+xJC/JHiUbiYFQNt1oMY8JgCbXh+aSpa2CL499mojEcPKd+r+2gzcrpNCmFBFegjMcjhGWL9HF/xfGNLJ93BZwdbAWja7hsuVkDK7cw97zBkQqWeJVJTiW6GqpbEmCJ/nxrigYutrsr6i74nkpObGVfI+RKzUehc939AhrZS5J7lWLonE9FRqMCqAdWbkHiZbkCpbwbqKcub75dsCnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtDgD1m79PWXSc1wNhyIfCW/miBqbXH0OskK2SE80hA=;
 b=Ywlt2Zfz1PGPj8JAhe11jHrMxLiBxG4kNS6ZbZYGcX303MUsEeTdDyvT3zAg/UaHBdkB76w1RMnHO4y/Q9XDyCkhtx+3JtCWvv2xrSe+xM5kRn0FZgJt/Ln30XGEGL5WfNT/bFI1sYiTFjhmGkSvI69QTeEvmI8VrnjYK3b8bIg8THY3C4eHtehFUAhw0W3hePrV/B8aYy/vXBfrOY4pCH3RnTyZ6uNdxra4yeX8iT6enUMDNhkrXbbjH6gRx2GHmJCreg2AxI/512vS+zHSTIgmTXFmyEOFosB9E2PmR/cMZo5aPAa4QgEsLkKKCc/fU8ZP3NgjOz0C2YuQ4lHX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF0644BB20C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 15:56:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 15:56:59 +0000
Date: Tue, 7 Apr 2026 16:56:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Soumyadeep Hore <soumyadeep.hore@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>, <rajesh3.kumar@intel.com>
Subject: Re: [PATCH v1] net/idpf: harden PTP frequency adjustment
Message-ID: <adUpRQk8X0kt_ZDT@bricha3-mobl1.ger.corp.intel.com>
References: <20260312184344.1475052-1-soumyadeep.hore@intel.com>
 <abKqLQmzhTE6P6bU@bricha3-mobl1.ger.corp.intel.com>
 <20260407081445.39d5cd22@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407081445.39d5cd22@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0314.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF0644BB20C:EE_
X-MS-Office365-Filtering-Correlation-Id: 90277431-4336-4eb1-04b7-08de94be4cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: W0uh/f8z8SpDLBFb9Cznu3LdkMjDwHPG45lva4CsPhxIhUHI1M0nyY9l7ixBbY44R4jOf888C2EOwDY99s+y1WiR27XUo0IseCNMoYirh27ouFLJXMZGtrZowTJZ2as9WXzBnW4HawhEJLiltgaB59T0NWEltaxyivckcCr925+EgAX6ZVCJyVabrDC7qjg4P1QoGh8KVS5VSZTGlof0l+OhsfG8tW56LA9EeAwgm+lg+kbZ6hYExfVqoPdK5FoSZ/31Od25gMX+/CmToSq6GKduPmcoWq3sh99s/GuwF4T5UUyMX4cmLvOj2bXtk+p0shbe3/wimzfWD3pBaKHK99gM6bN9EWuvFu3NmM3csJXw3Nel0fYPh0c/ON8D0OGXB2wqEJlDNxV3ntmslJyBsQz9dgKfQ+HIhZhbVOv0DvOSO2A00YN6Cjn8DN4sPWDkqf0KblyEQijvcVHMvZFXnNTRAukstudirW78ZoGz+QbjBdybOnysjMrWV3u1M5SYOTTW5dxTXnpT/s3ojAkKaDyo3u6Zrx/JVhzelizAUmwkR++WmKxOb5BkjvzNJDMkgcVyRSXkmkQyxTRd/t4uO936+Zot1OE04TY2TACYudb/kunZXJXzociVgWZfxuTiUQW3eDzHOMztwylZzcfpi87+pPXNa1EQidscFYUO55ISuHfVJswPeRcgr1oq1qlLCPn5JtH93rIB7OU1FP+TY4JipV5040IHPvkU+I6RbXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F+reMsEW+7u64A0IyaQIrI7ZuJN/GFPBcz3Y1FU9ppJt5t3SjbEvS5Kebo?=
 =?iso-8859-1?Q?LTrBZLVez3yMI0kcSHI8iL7h83V3ZGOe7vczzlsPNfhJpCYP/3LIdJQnK3?=
 =?iso-8859-1?Q?43SBKwvRt0aDJt0ThZ6lZ8sP4a996hzNr+NmvnQ5G0QVeTpqSvhcaJavBF?=
 =?iso-8859-1?Q?LSY68tiWVVgTaZP7kX3lw5/8kD95TkG/EOgqBv5pkrh+brM77UKOhsn4ad?=
 =?iso-8859-1?Q?WfGpvP6cr0fkvMg7DHf+mJWypui1oTc4U1+SKMBqNICukfpQS7KBlazAXh?=
 =?iso-8859-1?Q?VVyXZxvjVBghXbFRkT5KVYnEbxjEfTZ836TchJSAi7j7wkE2FJ1IXMaIbM?=
 =?iso-8859-1?Q?sLYCSH2Ll1yk4AiUmsRMFbKit+8+nAbVFmM/+sQBqSxctkymLGF6xCvPS3?=
 =?iso-8859-1?Q?NIQe/SRcFlQir7nfORGNotaDJXaw0xVirTS00ccojDAZevpp0v2ZBv73Yh?=
 =?iso-8859-1?Q?z8FhbeAP3Wz4MoECIx5Cf/LTEYPy7v5MSF2jodIHNHuAvVW12HgVlcj82f?=
 =?iso-8859-1?Q?cuZvrY7NzxI8S1X2iteju+x5c1pl/lTpHCRUj9sg1Writj3Ib0Nul91wBT?=
 =?iso-8859-1?Q?vWVoTWTA4Y4vpAgTL4tdZTaj2VJBebqBrJJ/IgsGkdeD/x72BM+YIQDxyM?=
 =?iso-8859-1?Q?cxKOY2VRBBgQxh9wSaxuvdAj5xXaSLw+ShqAsAmhW7bEBYfzORFUjaoCNV?=
 =?iso-8859-1?Q?sZX5oxyqK+TWQ+aa8/MhuP0y5mM+9YqBQaoNqeF1+/tYS+4O+HmS+ZTe68?=
 =?iso-8859-1?Q?shI9mRZxSNnbV6TKo1IipePaGwoLV4TqES4gbqRP1Zjm0cMcfrbGcp5wlP?=
 =?iso-8859-1?Q?trfQmhtYVDsniIFuMFfhX0vGrmkuhJBddzc8RENeniwpMgIicu6CJnDcUm?=
 =?iso-8859-1?Q?7TvMc8vZ/ZO5EO8Gl7c427PENJtnF6dX/1seIaCJKXBHgAdXjmRT0hCp9g?=
 =?iso-8859-1?Q?F1seqXbrlDOVaoiXZkaOvAcrY2KBtH3NK7rHcriUwt2pWGuNAtCMq3Vw5K?=
 =?iso-8859-1?Q?BpvKy/cNaX/Lz4AVP7AfG0DYyt9R/VO3c1xHFxVJlz5AWEjYdz7JIUOJDk?=
 =?iso-8859-1?Q?1HrxR9fQUuGGd0S5uR1RccXdQICS7GX8IScZVDrmLmexRPytGe+4lwnt3Z?=
 =?iso-8859-1?Q?/x3wpJNZRwXpQSALJ4GmevmQJt8cZ97Cp9EmFGkXquEJXS2Hl4hZ+sWu2e?=
 =?iso-8859-1?Q?STM1iKP0dec3K+X+mukHQAFUWaRGk/rR7KbMSrwHIkrTEYEpW28zs9tVhu?=
 =?iso-8859-1?Q?CCER8fhLnLf/HW01mh0gUFYPI/RrC2NXJ2JpCD9ji4SAU0yv9XsxDeXoqi?=
 =?iso-8859-1?Q?tyDtNHo9kQ0P+/6ivzsW+B1S9ovGFQRSG43JmZkuOHuptV6ziEY97MU+Q9?=
 =?iso-8859-1?Q?oGTiHrQR75Jxzvgh9siQuMNE32dt7n50T7HTVD8wLrlAJPMYF3H9sPcpPD?=
 =?iso-8859-1?Q?gw7HSqdeG5Q/is2UVc7tABSocSotV3/K6g8XO0G1PRTA2l4pMxLI8l4QrE?=
 =?iso-8859-1?Q?3cqU2eiqf5P8sFWVwiNfaEJJRYivAuRMxVVLLjnDUgWIdRbEL8RoQ6ns5i?=
 =?iso-8859-1?Q?EkziWc6/bgesv4wNlAmVP4oc8nBDo0UtB0Aso9OpEXr7adpmCBHP03sJ4n?=
 =?iso-8859-1?Q?V8unjFhxhB4gNS2fQkTuwTAzxM6wuOiO/b8kbAeLLODA3Us+NGfWuCWdgU?=
 =?iso-8859-1?Q?DmztmZffzXv0yb5YVd/k5IQD0sWctOHtGxW10um0M3gPCTznQtdW+Mz7lD?=
 =?iso-8859-1?Q?Rr194bVNRO+xZUEjTrxNxrwcOoZkomZFETDyMYKmrB9xOMgnZFQfEWxA11?=
 =?iso-8859-1?Q?6hnJIK/JrYt7T7njG4IEKvYwDCpiZpY=3D?=
X-Exchange-RoutingPolicyChecked: ZyqG/NhSstyIZ6xatbX7T6IyAPi7ClfCtjnR+86R78Z4B11adMYcJiwBEgnZjjlRC1xZ3RZOwfkKErj8bSdScLFdWiGIDSTBehi6foLQ638k+K+naSGRo9LfsAB4x6/IXtyf57jJh8Kzvp0dVCM5TT/VSAJBBYFczg5ehc6QCJdz/0YGUwvBOSb5xvx78JyAh5k+rlERMYOeRlYJul/2e9JHjIDE7XOc7S+EudSh4SutYX9pjZkZChtohGkIBGR3IuPIYuA70tcrg0qoupKyppdOJV/UBJ+v6cv5QT1rqNYAxCsNTwIvUD7CMPW7uAEMMbJ+3XLDG0zGERGyku4M0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90277431-4336-4eb1-04b7-08de94be4cfb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 15:56:59.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+2nWp2baaDr1gexHdlmDTIX95LOlCokkmQkgfOSE8/aOdYej9nRL3XflBH7PdqobdxxFAK5OTB1K/nePbdvy+TGADzQwtMF5qKXOJYTOaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0644BB20C
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

On Tue, Apr 07, 2026 at 08:14:45AM -0700, Stephen Hemminger wrote:
> On Thu, 12 Mar 2026 11:57:33 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Thu, Mar 12, 2026 at 02:43:44PM -0400, Soumyadeep Hore wrote:
> > > Normalize ppm to an unsigned magnitude before using it in the
> > > increment value scaling path.
> > > 
> > > This avoids negating INT64_MIN and also prevents subtracting 62
> > > from the reduced log sum unless the sum is still above the
> > > overflow threshold reported by Coverity.
> > > 
> > > Coverity issue: 501832
> > > 
> > > Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> > > ---
> > >  drivers/net/intel/idpf/idpf_ethdev.c | 32 +++++++++++++++++-----------
> > >  1 file changed, 20 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> > > index 5e57a45775..1c5bd2ee12 100644
> > > --- a/drivers/net/intel/idpf/idpf_ethdev.c
> > > +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> > > @@ -1007,7 +1007,7 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
> > >  	struct idpf_ptp *ptp = adapter->ptp;
> > >  	int64_t incval, diff = 0;
> > >  	bool negative = false;
> > > -	uint64_t div, rem;
> > > +	uint64_t abs_ppm, div, rem;
> > >  	uint64_t divisor = 1000000ULL << 16;
> > >  	int shift;
> > >  	int ret;
> > > @@ -1016,26 +1016,34 @@ idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
> > >  
> > >  	if (ppm < 0) {
> > >  		negative = true;
> > > -		ppm = -ppm;
> > > +		abs_ppm = ppm == INT64_MIN ? (uint64_t)INT64_MAX + 1 :
> > > +			(uint64_t)(-ppm);
> > > +	} else {
> > > +		abs_ppm = (uint64_t)ppm;
> > >  	}
> > >  
> > >  	/* can incval * ppm overflow ? */
> > > -	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
> > > -		rem = ppm % divisor;
> > > -		div = ppm / divisor;
> > > +	if (rte_log2_u64(incval) + rte_log2_u64(abs_ppm) > 62) {
> > > +		rem = abs_ppm % divisor;
> > > +		div = abs_ppm / divisor;
> > >  		diff = div * incval;
> > > -		ppm = rem;
> > > +		abs_ppm = rem;
> > > +
> > > +		if (abs_ppm != 0) {
> > > +			uint32_t log_sum;
> > >  
> > > -		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
> > > -		if (shift > 0) {
> > > -			/* drop precision */
> > > -			ppm >>= shift;
> > > -			divisor >>= shift;
> > > +			log_sum = rte_log2_u64(incval) + rte_log2_u64(abs_ppm);
> > > +			if (log_sum > 62) {
> > > +				shift = log_sum - 62;
> > > +				/* drop precision */
> > > +				abs_ppm >>= shift;
> > > +				divisor >>= shift;
> > > +			}
> > >  		}
> > >  	}
> > >  
> > >  	if (divisor)
> > > -		diff = diff + incval * ppm / divisor;
> > > +		diff = diff + incval * abs_ppm / divisor;
> > >    
> > 
> > Asking Claude AI about this code and how to simplify it a bit while also
> > avoiding the INT64_MIN issue, it suggests using __int128 type, giving much
> > shorter code:
> > 
> > 	__int128 diff;
> > 	int ret;
> > 
> > 	/*
> > 	 * ppm is scaled ppm: 1 ppm = 2^16 units (matching Linux adjfine).
> > 	 * Use __int128 to avoid overflow without complex split/shift logic,
> > 	 * and to correctly handle ppm == INT64_MIN.
> > 	 */
> > 	incval = ptp->base_incval;
> > 	diff = ((__int128)incval * ppm) / (1000000LL << 16);
> > 	incval += (int64_t)diff;
> > 
> > 	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
> > 	if (ret != 0)
> > 		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
> > 	return ret;
> > 
> > Maybe worth considering?
> > 
> > /Bruce
> 
> Claude AI review of this patch spotted some possible math issues.
> 
> 
> 
> Normalize ppm to an unsigned magnitude before using it in the
> increment value scaling path.
> This avoids negating INT64_MIN and also prevents subtracting 62
> from the reduced log sum unless the sum is still above the
> overflow threshold reported by Coverity.
> 
> The simplification is a nice improvement and the __int128 approach
> is correct for realistic hardware values.
> 
> One concern:
> Warning: drivers/net/intel/idpf/idpf_ethdev.c
> The cast (int64_t)diff silently truncates if diff does not fit in
> 64 bits.  The __int128 multiplication itself never overflows (both
> UINT64_MAX × INT64_MAX and UINT64_MAX × INT64_MIN fit within signed
> __int128), but after dividing by 1000000LL << 16 the quotient can
> still exceed INT64_MAX when incval is large and ppm is extreme.
> For realistic PTP hardware (base_incval around 2^32) this is fine,
> but the API accepts the full int64_t range without documented bounds.
> Adding an explicit clamp or assertion before the cast would preserve
> the defensive character of the code being replaced:

Sadly, the CI is also complaining. It seems that __int128 doesn't seem to
be available for 32-bit ARM. :-( Not sure what the best approach here is,
whether to add a more complicated fallback path for that case, or just
disallow the timesync on the unsupported platforms for now. [32-bit x86
doesn't seem to have issues, for example]

/Bruce
