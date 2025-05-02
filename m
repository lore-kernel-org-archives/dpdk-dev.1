Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F92C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 09:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A9D402A0;
	Fri,  2 May 2025 11:09:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0BA414029E;
 Fri,  2 May 2025 11:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746176974; x=1777712974;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=JflksYVHGdnjP9NpHXxxKv45VDl+uBE9jnrfbf0P2O0=;
 b=TBzyMtEZTA93q6+rzg9BlnVFkXtiHUuXcT4e9MUGh3mOR9cP9wVt54xg
 /WIqsXqoWWPFUqQelHXO7LnSXizNl3cWvfXi5WYSf+wISb/fPnJ2KMeVU
 gzxCclSBfAXf3RZGKmFmVRtxcgCH6ayA2lU3uvuhf0Iz94YwNEdLvOoCI
 Eliw2nykYa/ELcJq9gmSxiKZ4F0spdK/ctlDwHBje+xhBTrrwgqO5DsX/
 x8nss5+e7FuUVnJfvYJZRGqpz5JDbFmxBh0+Ep8fH2YyrUhrKEurGUL8A
 b7vi0ox69wwC50zu3CO/8f09QWc2BgWEzePMTI6t84MKL4eMcWTUy5KoN g==;
X-CSE-ConnectionGUID: y+V8AO/cRpeIJv7H23QBpg==
X-CSE-MsgGUID: hNJPAorWTTmUtVttYAtFdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58848200"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="58848200"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 02:09:32 -0700
X-CSE-ConnectionGUID: TcPYfZhpR+yuV7y1icydDg==
X-CSE-MsgGUID: TrEbLjGkSMSVh+R2aQ75NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="139404846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 02:09:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 02:09:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 02:09:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 02:09:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FefjDjdoGN98BYNCkzDMBBCtFGcyvk+w5YGqDHyI7AM8VCkYkEr0ZwGg5v4sdNZrX4AmBcXkGbCzCbB1eDGOqhfd0VB/Myf5YSPVIMHbn3bNiqruUFQ2zbE1alqzJWlD+mv7YNsiVJJF99E0Y4ASJoDb2rkcUv5n+DiHqf3lYqD1OPNIQMeV0GM4SXXARWJVijdAaHJZ2IugVUCaiEyn+BeCzL/aKgflpt4NYHGcCeJoQ7US6zjpYGRkhAvBpOZGHfCMDMN+ABSRUnCmRwMQmfbhYnMwP78SrIwLrg2p3c9QDMPY0mnMtG5IComN8pRc44tIiiQa8JlPZ1bKaOxx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwVvzI0BUaG/NAis/oJ0+LDHcV7Rb5KBdXR+ZT42dFw=;
 b=oGjR0xsx2n23vjXT9r8baPc+prVciGxYIB0yi3tE4wTbBrwZAk+62vTHMIO8dAhJo51MDA60Bcgms81Aqks+ZBf5pyTmYRMiRhoeACDJF5OP8a6KA7bkMAP+oHisymDFSx0o28gcRdNcbxCKYWUqLMus59S/WTLA1XNUgGghzkEiEC6t4DbIptu6alGMrR2iq4XOVRuofyxnEMshN/VSBLa7yHSvAA8s5lgMAgF0LqzgXjUG5DL+x27ZDchm034TreaqiaGtRy3kw8SC+t5Bx8rbMmoTmaQmIl1pKlCng7xmAMccQoU7fh2NnzJF4JjYU7tjx59sWXoQIdRFVRwRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 09:09:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:09:02 +0000
Date: Fri, 2 May 2025 10:08:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <techboard@dpdk.org>,
 <dev@dpdk.org>
Subject: Re: rte_control event API?
Message-ID: <aBSLqV72om8Gkz32@bricha3-mobl1.ger.corp.intel.com>
References: <20250501080630.440a78ba@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC23@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC23@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:10:232::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9858a48c-dfe3-4e26-5388-08dd8958fb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gQTrikxxYnq/6kZPVWr62ihGp48RfriXLe1a4g48RJFI6y9Ovf15Q5315t?=
 =?iso-8859-1?Q?236IVDTU2G5a17i8e1ye4IsUYHJ+5sUckR7C29GGPaVUQPMmww9iHfySba?=
 =?iso-8859-1?Q?pYmc/3zNcQpvVC2I4Ral4Qk8vHaJGuQS6r2pSVojWeAS7oQ68PsnyFfRqI?=
 =?iso-8859-1?Q?L885ql70MxmFKWjp8DABK0XeYbsqGxF9KdlGl5ibKkmMe1sz6KKuJZSeLe?=
 =?iso-8859-1?Q?+RIfzziZ3RpujmIqoX8lprmJPaoTL3dMiXFSuxKoFFoxT3sTyNjvs2Mnv/?=
 =?iso-8859-1?Q?rIK6GahhcHUs3qDW4XlxxwUDtOzv348GHyCA6BrEGPSb7bHiYWSfLEE9Zn?=
 =?iso-8859-1?Q?8egHRDxqd9+7O5NgKo2QOYl5ySoFjp8hFR9kJqYq7xamMgWdIg5e2HPDlG?=
 =?iso-8859-1?Q?l0JPwzQXBXGLDXU+s+mI0r00gyIzAX9wG7RhmzLJeARV37mZ0prjW09iEH?=
 =?iso-8859-1?Q?GaWVx7zMMaLPI1o3QMvRdM6Qm3h0mLkpS72k5qvCnLjnH4ej95ap2+UDu3?=
 =?iso-8859-1?Q?A3tIfdFPZAHS+ApiTMML7U8MTobFvaY75MYOps6kG2kA0LSm4b/yCrGkmK?=
 =?iso-8859-1?Q?dN3Smjr0M3nhOWx7z5CSY00LDnGm7LFp2TZcQHFqJ7RwGQ64av+mrpBHvU?=
 =?iso-8859-1?Q?ZHXfPpnLsgkWRofnmKQe46eSSZWHbifbR2PrO2XJaj+NzrCqwnODesOlqq?=
 =?iso-8859-1?Q?gTZAqexqJdQIvyUiK5Qj+nxZQ0P9YxduQNbxh+TPV28XAetqMdQCCFEU9V?=
 =?iso-8859-1?Q?CqBCxv3VEaXMdSSrKnDK2Ahu0OEmYPYo4wPlUm0l9Sg+PMyn2fQFopGTsP?=
 =?iso-8859-1?Q?hPmb4nNT9+IP8pZ3cdNINjw39ohEK2Ytmd4zTAUALftxzZDVyh+Xdxas02?=
 =?iso-8859-1?Q?6moPsMX1oeqmLNMdqdvK13AMG3QnUS7zPeWoG2fR8sZagKseAqj8MvAyO2?=
 =?iso-8859-1?Q?SzzpIh2/U1IiD3ZqWxBsAX42rxoea7QjmM9NHYCMQ6Ze0Z9S18ALrJbggO?=
 =?iso-8859-1?Q?OlwH7baryrPG2CWLTStZrIqYPt+xI4ufno5fDYoDYkpFOwcNnNTDnxPUse?=
 =?iso-8859-1?Q?9bVaxvDleQcPIUtZ3vhHrdfuO2VPZeNV2iuGf6TcCFEhsge1BTJEMLltKE?=
 =?iso-8859-1?Q?VKURO9QBcz+tSGSzj0WbwA0JywC1vsegS3OHSbVjI8u1ynYJAIcrxrRZWv?=
 =?iso-8859-1?Q?D/JB9zrzePLSydrG2g/Nzi7clw5VmBemzZkMd6trvNqmdDNu3x7MwiJZgU?=
 =?iso-8859-1?Q?Fc2iso3mC9/AUzw3/Vjf7mqa/uibob0DDRQnmB6/bFhEvNX6Rh40JcnfhO?=
 =?iso-8859-1?Q?Ex+08dmKEpuYmeIAbL+WSX3DF5c42mjL+l3D8ST6kqAwWn6eVJPX4aKrdJ?=
 =?iso-8859-1?Q?9RHCCwstl2LZ0mZXMKvByczbvzOHkBe58WfPg0lzB/lctyItwaRHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SmM78+RALtjGBe5Waly0hRy9XP3oo5/7wRQqyHoBOK72qK/I1XMZ+ELDZT?=
 =?iso-8859-1?Q?7DjrDWQCRajctWAA6KzBS4WGv2kmhWbF/WDyyISVS45BLvUD2+jYvcuKec?=
 =?iso-8859-1?Q?S7/0HGqgo4UnJds7pN8EmewPxvArKknrMHoo4Aop7s94H2W+FJRxXfuC9I?=
 =?iso-8859-1?Q?7y1TdvdipJjus5HGLll4vjYRWCrr/4RhP1Yvzsl1U9/35+RTOYlOm1THV2?=
 =?iso-8859-1?Q?S4KCaKw77Jpc40L361KnuH7OUZvhnb1roY2SK9yaPd9hsC7me2okvIHOug?=
 =?iso-8859-1?Q?Dm5D3TmVP4+zV5XIbW/+C550MdKXxKpF/vXd66vPLsgPPyVpUMW5NJf1KP?=
 =?iso-8859-1?Q?ZsKdL1uNBQnykHzL38WrxUI/fW0bXpWDL9KjRkGYBwm67XzeZN/94Ti7ZE?=
 =?iso-8859-1?Q?+XxTl82VT2VLszjmRBcazN09Nxt02nyHxSxqFJjxFFAKmqeK8lrvCjj9CQ?=
 =?iso-8859-1?Q?LccNpVHyU8Vo8vbR/NlJqH3H0xHB59Nc/dCtDtMg6BMRbiaw9KpzILMWow?=
 =?iso-8859-1?Q?NUXTFfo6lf4Kjq28Hf6XnMrMI332QFcUNCVo2sTs9mU1eGLu+H6/DEoyHv?=
 =?iso-8859-1?Q?DFNWndSmcXGd0ibJ4lGu0jiiKkK6gUW7D2CidS99O2w+GmMhmxN+ekkJTt?=
 =?iso-8859-1?Q?D+53wkRa7URPu+BvkxxI9F06tZ/+GINOnZJIW3XRuMWfJn+olVngIQ/wQO?=
 =?iso-8859-1?Q?8BlcSgy5x7HxIq6vB/JrdRDEGWCcM3WB83ebn/dsHu8buYX7nfxysaVz5i?=
 =?iso-8859-1?Q?zRu7sb46IIiBb4Si1WqxAASl/O8dS7QgU4zbnszguNOavPE1cT23zGkwVG?=
 =?iso-8859-1?Q?2lDtZgPoRKvjBxWFZGnQDZjrobpsYZXw0z5gbTkotkc0Qe8O2GavlVsClo?=
 =?iso-8859-1?Q?WaEiH4tvAKUMW8HFAvzw3HePpZe5o07ybuRjZPo56Tbd2V9zAo9uodBEK1?=
 =?iso-8859-1?Q?A52/Pg8QHB4mm3d0FltxRwXwYmfqm93g8kniyzv8enHg6PLvWW1qTaJcR6?=
 =?iso-8859-1?Q?Tv7V2kXEx36nipY/x7Y+aEnBG7+uGTLDOp8ZUzNa3PTN9w20vWZGS23rRw?=
 =?iso-8859-1?Q?zkkdaDETDm1CUa6YWtAp9JgCbIObl+LkvHIqXBXkSW5ossOvDAEyq4Z5T2?=
 =?iso-8859-1?Q?FKkOtDQROYlYJhrtMI/s+bdlwNeAt4cTXzslUsV3I7Aw0+ZCedRphUPbsF?=
 =?iso-8859-1?Q?OU2Um3XDSPjKro4k2DWDbaYAClczbV7AZLe89i4QQMYeAtmIrGnS+oETGb?=
 =?iso-8859-1?Q?+yElDF7+867RMjg2qMft9uwaFgXRKdnbP3ScXxDq2NmyUzf1J6BxP29+2Z?=
 =?iso-8859-1?Q?zLIySnRFAYIcuBZDRGx1YJ6S/Nxs2D/NpiUYXKXeIXrQERzsIgHir4SkQS?=
 =?iso-8859-1?Q?tps65v4lYp0i5pT1xMN+Pj2Y70nWmn5+AYPi375mrhimliPnrMwCDIBmw2?=
 =?iso-8859-1?Q?E6cugZbQsY0VBKLVupuMA4shB2gQ1MBH3y95S5bsM9kXZsokt0KCf1w3hM?=
 =?iso-8859-1?Q?ycz20ee3wyTGYpW5hdC0WPPkurems48IzQGbPfa1IM8koITJJMrxTbgVjU?=
 =?iso-8859-1?Q?MyNi+rvzwgu+jmdpzuRvGp2GFhcd80AX7irsM2EiDn4wdkYpyFWJPE8vrI?=
 =?iso-8859-1?Q?DEf7n2hLu65KAJ3I+dVTTmlhgqT9KWX8KnfhXGw3uc+8FDE4rwiiQMNQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9858a48c-dfe3-4e26-5388-08dd8958fb38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:09:02.3830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0cePeOzRmiQf50lU4muYWaI9+P5983Bs/8wGAgKilI9ia2w5ZfLlSO8UD/i+EEigoL+w7mZHn33MZl/gBpqbj52FLsdnExf6et7++AR9fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
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

On Fri, May 02, 2025 at 10:56:58AM +0200, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 1 May 2025 17.07
> > 
> > There was recent discussions about drivers creating control threads.
> > The current drivers that use rte_thread_create_internal_control keeps
> > growing,
> > but it got me looking at if this could be done better.
> > 
> > Rather than having multiple control threads which have potential
> > conflicts, why not
> > add a new API that has one control thread and uses epoll. The current
> > multi-process
> > control thread could use epoll as well. Epoll scales much better and
> > avoids
> > any possibility of lock scheduling/priority problems.
> > 
> > Some ideas:
> >    - single control thread started (where the current MP thread is
> > started)
> >    - have control_register_fd and control_unregister_fd
> >    - leave rte_control_thread API for legacy uses
> > 
> > Model this after well used libevent library https://libevent.org
> > 
> > Open questions:
> >    - names are hard, using event as name leads to possible confusion
> > with eventdev
> >    - do we need to support:
> >         - multiple control threads doing epoll?
> >         - priorities
> >         - timers?
> >         - signals?
> >         - manual activation?
> >         - one off events?
> >    - could alarm thread just be a control event
> > 
> >    - should also have stats and info calls
> > 
> >    - it would be good to NOT support as many features as libevent,
> > since
> >      so many options leads to bugs.
> 
> I think we need both:
> 
> 1. Multi threading.
> Multiple control threads are required for preemptive scheduling between latency sensitive tasks and long-running tasks (that violate the latency requirements of the former).
> For improved support of multi threading between driver control threads and other threads (DPDK control threads and other, non-DPDK, processes on the same host), we should expand the current control thread APIs, e.g. by expanding the DPDK threads API with more than the current two priorities ("Normal" and "Real-Time Critical").
> E.g. if polling ethdev counters takes 1 ms, I don't want to add 1 ms jitter to my other control plane tasks, because they all have to share one control thread only.
> I want the O/S scheduler to handle that for me. And yes, it means that I need to consider locking, critical sections, and all those potential problems coming with multithreading.
> 
> 2. Event passing.
> Some threads rely on using epoll as dispatcher, some threads use different designs.
> Dataplane threads normally use polling (or eventdev, or Service Cores, or ...), i.e. non-preemptive scheduling of tiny processing tasks, but may switch to epoll for power saving during low traffic.
> In low traffic periods, drivers may raise an RX interrupt to wake up a sleeping application to start polling. DPDK currently uses an epoll based design for passing this "wakeup" event (and other events, e.g. "link status change").
> 
> (Disclaimer: Decades have passed since I wrote Windows applications, using the Win32 API, so the following might be complete nonsense...)
> If the "epoll" design pattern is not popular on Windows, we should not force it upon Windows developers. We should instead offer something compatible with the Windows "message pump" standard design pattern.
> I think it would better to adapt some DPDK APIs to the host O/S than forcing the APIs of one O/S onto another O/S, if it doesn't fit.
> 
> Here's an idea related to "epoll": We could expose DPDK's internal file descriptors for the application developer to use her own preferred epoll library, e.g. libevent. Rather this than requiring using some crippled DPDK epoll library.
> 
+1 for this suggestion. Let's just provide the low-level info needed to
allow the app to work its own solution.

/Bruce
