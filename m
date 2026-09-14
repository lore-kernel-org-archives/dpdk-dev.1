Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3AC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 12:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2613A40B97;
	Mon, 14 Sep 2026 14:02:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4AF3340272;
 Mon, 14 Sep 2026 14:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789387334; x=1820923334;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Z1Miuiu4sFnftlKFoUcII3egzp4Fg/LF8vmbaDTgVmE=;
 b=AjWj0/SlHBIbNRRmYNY9o/ywpxy1CZw4jUQBKY45Ml4d7K6XmTZWgCFZ
 fO7lJ3xqQFIPkmub3z3OZRxAk92RH4/cSQRR8KY3s2NYx6I34qLdHbIoI
 FzbGoqMXWzSvYOs/O9GdKtGi1/QQTTmJ/KJFLbJQ2bxpJWQPaYXLJrp+1
 APyoR+5by5ajeBRxPUDPSxPALhBMFP2hcLzPMkFbs/DsCojriZP+cNh1n
 RQUVP6Ynq9xVgly6v0sVY6r8RzgJIJA0PwSIuN03dcS4dZPLE0ubR+ava
 hAZmVGG50OB/XETLnhaIXhh6+oJllpTTi4am5veAV5lAbSS088PQnt9Kt Q==;
X-CSE-ConnectionGUID: n5zRs29wQNGJ3uI0+2E2Ew==
X-CSE-MsgGUID: c8RO1xyNRZ67HH9BAbTd7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88677808"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="88677808"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 05:02:13 -0700
X-CSE-ConnectionGUID: /kx1d1jYT1CiwTCzDLrVKQ==
X-CSE-MsgGUID: 0jqQpM4hTHuE6NM+U5NiDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="859289"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 05:02:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 05:02:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 05:02:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 05:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zId7JfDwNTGd41dvpeWWr9+8Bvlw9z1LQ1UTL5hupEnMXeJeZsELTYLqHZZzYsxVIJSjnl/OkG4gE1/NvX/tc53QUVKYrkmf4JbVs5iBHb/wcmpfnNNVU601yyMSqZv2fpOmkgjGm+7XL0+51xAY9aQwucKvnUQA+NY9nW/tOdOhGOR47kGktZjUe8D4lM9VPJhksX8ZLVFFQJqcr+jByXkKLwoqWWro2w6uCOe6dEuf4asqXra8cFd5bYxpuZGct4FQcNUZE2J5rj/n4NtEwS/WivAvM7vLDsKctm1BF8kpMzFOxZPNkwkWAaxk4JIwSmps0gtoEubeLeHhBeBiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtSqPQEELlL55S6SEfosPY23X2fH6smUr0uIMAXCseQ=;
 b=oyT6ZWeNtwiyiZV4V9QPi1FbKhcq0J+oMPI2wkIeOcdl8Lr0FzteE3QgBwwg0Wz2HK7Pq4aEgb2qp4b2tUIkJ1RnkmYYAirj5EvNJyD8/682et5nfrEDUqchkHxPuvZ2BbrkOZQ7TcfpYJrz7U8kD1QeNJf5o5fvyHKRidvlDy8bdkxclImmI7OMF+HesUf1T0jTxsf7ceBC3TTLyFYxZ1qJosuiTSQwz1YNodkkdU8EmCHgjBjU4ZKUOBehS+ADxMUxa1UpD/fQKUOhVu22mObdtg8pIssOj+zMynMn2ICgzz8wV99F1x3+EYrx6hqDFydOSgmHVnhZfqTlXup2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH4PR11MB080512.namprd11.prod.outlook.com (2603:10b6:610:50c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:02:08 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:02:08 +0000
Date: Mon, 14 Sep 2026 13:02:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>, "rjarry@redhat.com"
 <rjarry@redhat.com>, "cfontain@redhat.com" <cfontain@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
Message-ID: <aqfiOvgEZpOR_raG@bricha3-mobl1.ger.corp.intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-2-david.marchand@redhat.com>
 <IA4PR11MB9278E70DC4CD62AEF396DC388EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8xZMxZfwSDo=1TpeeV93BQA43RW+ctzkjnC5QnPZ9FQ9Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8xZMxZfwSDo=1TpeeV93BQA43RW+ctzkjnC5QnPZ9FQ9Q@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH4PR11MB080512:EE_
X-MS-Office365-Filtering-Correlation-Id: 51aa3ecb-3e13-480f-86f9-08df12580024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: g79BqS8tNLwW6fqNrrF13MydURojQgQMINXunDmRoAHnCilF5G5Y9ih4T0qJgRGaOx5Mco2q2UrzQLQ4ebHeVQQG1r2IlLsdzHx7Law88fLYyGAufiY2m5aFjcpFkV+fEkbnqAGNKQy0cymTeAwmShWwSBLHATm5eOSU7/nX4+Zw2p0vUaWIyAHe+JOKeNEXjHeaI7W36c5X6uOoIRUKRukOzRHq9YZzT2LVr1bSLUrbXY2cwqN/ndYyhgPsAF0G+abqiJBiCazIuOHTyDVxiIn1TXyErSpfE39t1IGmRekL7buAwrCVNo7NisXJAV1+U87flN1Wd+wJZQ4TukJDB9vl21n9ewDEgcinY879yW2Sb46d1VLb6tUMXTxh2M6nr/wfrDwIXYTGPfXRytbQvp7qziBNIbcG1gduLFNCgsINWF9phHl68f1A+zF4Lid8027sfcGKWcdh+gDeBB1JKFQz+qZ8JZybisVpix8ezPCZe9DRlg2RFFm3IjTOzlTzocBGYqAXxX27ZY/X4BEGN5c+41dQDYeTXelLwCqRsNTpKU2yepgt3Z3ok33GIeld+YPwkSvoW7RXqx8ozltzYQABDcj2CufiHNhtV7Xn4HlSd98Ca0v0hm00KjmgR7zo2IvLXHfcvzD0evKRqfkMetJirWiuf7cFWWWkV5DbKnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMWd6ZYFlG+9nHs8SXUdafCrzIV3BEh9l1gxeMO3Or8ZbJ846yFi/4GL8eX5?=
 =?us-ascii?Q?PyvxUWUZzC+IgWyAlJEN2X/CSVeOZkwX7A1D3AwY5Ihis5K1tNIoGEDWG8C3?=
 =?us-ascii?Q?GYyz1FMrd66+3FB7o+XY77IhVLwXcYmbSsm6enf6EhdM6NggccLR+CD3P2B5?=
 =?us-ascii?Q?n0KXfxWnJ+jPI1X4l7auZ62Gonp9DHH2thHFgz3+bZwiEw/izI55XREnV/p6?=
 =?us-ascii?Q?cFC8X0drzaCMUnwmgwoKgpHRPhmuYgbr8QO8DTMPRDX2RvbToCyD480s2YGg?=
 =?us-ascii?Q?d2LI1j0bubCrfuv7b9VMUyzj8LBY1doDxb2EJTazGqJjtjABCEen/wUVqiMw?=
 =?us-ascii?Q?sZ8i+/pfzmA9GaC3JNPxHVAXZ8sEoagIJ9FAJeCaBNGnctTdEL5etkBIHoCP?=
 =?us-ascii?Q?3KdxoAF3Slc0bOmxPbv6Hz7VUspv+J1a2qOOU9LClTOpiQPsC+sYCYLc0ens?=
 =?us-ascii?Q?ymg04yqr0J6LmRTo3tO//BSTQ44a8RDmUd6Hdp3OENaq0s0UB37V2dLB3xQH?=
 =?us-ascii?Q?cZ+07GVLuw+6M7BioKDyVfVSW76XEHQswPBonnJMoThDQyOY8ARiHK//ubMw?=
 =?us-ascii?Q?354V0qU0fF0cMTYL7OP9Y127VHUqn0o6CzOTysIs47VrLQhcNRTTl78TpMBE?=
 =?us-ascii?Q?bDiVtaMfl/ulca00KdA+bsOnYsEEnD0cFvmOMWnWrhOSdzyAB4L0RojhYWDB?=
 =?us-ascii?Q?WBYs8z1L55xTA0uFbCbY1F3n05Y3GXXndln9wfJ+HjKe9nElfluiyFfYk0ZC?=
 =?us-ascii?Q?jc1V4IB6CyBBMBwewo6Y0x5LS+lbi9vkYObymKAHV012FueDYD06cYKKutpz?=
 =?us-ascii?Q?aZtazSWzTaxnbdpJQGo2cCXxoNVmdF7QBEtC9SHuk7MDj3hNZkxp8kKg2J4y?=
 =?us-ascii?Q?EM/SrjUzw3z6aTG4KGzaKLvtJj+WAkhJx/JGZ/uP7bemFqoxHQyQVy3wrkP/?=
 =?us-ascii?Q?QuoDTAkoxmeCkEwSO4IY0JvHU4pI1SDXimFlAq27Ok93liZVFJfc7DyPqvW5?=
 =?us-ascii?Q?d6w+YSXOpw2M6wqFXkwO9z0I3lIIteonpctMBM6X44GVsGXW/0GIcNbPX4nQ?=
 =?us-ascii?Q?3CeAg1s9NSzlg11Lz1bpQwcCq9VyoOKui0kaD7lS7G4Xv1Kkli4G+mH1WEao?=
 =?us-ascii?Q?Spk9JAdMuxeDTUWNxN5Wmq8XEMxpxVrYgplSUhApj80oeve8rlbr5tSOTgjZ?=
 =?us-ascii?Q?APvMn5z4ML2B8L+KYLqC2CMHOasgsy7lbP49nbKD3WSmaYbW6Ahe7cOc6LLm?=
 =?us-ascii?Q?ilDuPkhRh0147T89c3VtEIzp1IwWzw2AqlIfpCxxWLB77I8mltxHw9OYhlyd?=
 =?us-ascii?Q?bazKWAC+d9bObToqzXtAglv4YC+B1zjmRI3lgDyLA6QhHTExqO/Za8fXALUs?=
 =?us-ascii?Q?//bjK+C0RKXctOYiLO1Zy+EWVkMlxQLtvYiX4ce+VFlesEweJTkxPGIW27i9?=
 =?us-ascii?Q?dZeLzkI9p09tEzRoLHotepRvvk1rEMhL7S5jgaASlK7xDWdcWQKtEU3g4xUm?=
 =?us-ascii?Q?Qtp+KACZndQTyToK2eC9zFXsZAnA7GuMu7HqRIC/bYCTFe+y0kdhaF/iY3NO?=
 =?us-ascii?Q?9R/2ifeEWVrfB3ebrfOItUcEJEzdY6aGEwbhtBs34tS1O5/kZ9e0txGx7zHs?=
 =?us-ascii?Q?GMVBoEiQ4LoQ6mMb61Ga/IDG6YiCOw15CiAbLRmn47KCiw0wx54MrfOsPsly?=
 =?us-ascii?Q?iJKJBxnIzKkA7+1F9Fc/fs9FyHYh/3tIFjoRy151IDP5SjM7cYFv1TEhiZ6d?=
 =?us-ascii?Q?fm/xIrlCzrY1uPL8a1T+t6XUMlf9VSs=3D?=
X-Exchange-RoutingPolicyChecked: wfpOoIm/LJbFFTrokXQEbbxWAPw3f2nrDBSsccDKSsgQnUCf4QCuij0jH7pe3WzqTPF5V1fxPmA9WKKRLtKgJClW81o/0hi55JMrWybTqjiierRn4ymNKst/7aPin6LfAgx73efrnkihuxXt3GBQUmPNF50USRoh6kb9UTYlHlGQWHf1WhEPR5jTXRj0+8UeRDfeFcahBSfTfaKlm5fNMDQWmAo0bLfZj8fqbvaGFTufqeZWNdnmqUL9GZ1MmKyoQU1nQ0rTj94WPt/cS4eu/PBEQQvbbIyw1UjaA1lD4pxkaDy75JtfneT7KnkEyHxRFzj1eQSbL7AhLVMNEb7yaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa3ecb-3e13-480f-86f9-08df12580024
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:02:08.2943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTvLNU/X7CGdVEVqQi5eZXkGc+MhvlGN8PHwpbYbkllAjkal3RLTa0Z6sWy9mAKJFLmZG67CMIQD4bsWkooPTPIiSDz1JSwHNH+AtSmAulo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB080512
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

On Mon, Sep 14, 2026 at 01:56:36PM +0200, David Marchand wrote:
> On Mon, 14 Sept 2026 at 12:19, Loftus, Ciara <ciara.loftus@intel.com> wrote:
> > > @@ -3428,6 +3428,14 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> > > *dev)
> > >       int ret = 0;
> > >       bool allmulti = false, allunicast = false;
> > >       struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> > > >data->dev_private);
> > > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data-
> > > >dev_private);
> > > +
> > > +     /*
> > > +      * After a VF reset, all MAC addresses got flushed.
> > > +      * The primary MAC should have been set in iavf_dev_start, restore
> >
> > iavf_dev_start is not guaranteed to have been executed before this handler.
> > So I would change this comment to something like:
> > "The primary MAC has been or will be restored by iavf_dev_start".
> >
> > Other than that:
> >
> > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
> Yes, true.
> I'll update in a new revision if needed, otherwise, could it be
> updated when applying?
> 
Single line text changes I can handle on apply, no problem, so long as the
rest of the set is good to go.

/Bruce
