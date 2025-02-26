Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E8EC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D9D4029F;
	Wed, 26 Feb 2025 10:55:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4ED794029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563708; x=1772099708;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FL8xy2s/63WmO91hNAJcOVVp1/tKJGre5zIZ9JoqTmE=;
 b=CFKU6F10os87jXJ5vow5b5x2LfGq+Lvqbjzj5HZU5G7UHXcqVf3MXKvl
 6YzTYa2rDk7AKpgwfN8KQf3EIRgWKVIB5zyzHW1qFetnkyKZPyl5heuHa
 DYIwuyWRsr3IuWm9QhJU4hyHOtbBSF+VuDrVmEDMWMfV4wamuHZ3xzyzx
 mJEsFpnXUADgDyZxmBpF4iX7XeH5SLcw0P3/QmmuZ028xzFAB1uRK4l0h
 g6gKa7CoWhhYjifS1X0Q9fPXBwGZaehwI7mUTqoDCQzJAEn3Np92VyOG+
 ekltuKchsgMFbpqLf+sbE2YQIVnT+Gv6VYZxPcG7emydI+oA7HM19s+zf w==;
X-CSE-ConnectionGUID: TQq9CFAUTP+i1j5XRa6w0g==
X-CSE-MsgGUID: Y5H/TD2UQMmsRyjkSsN5Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52818829"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="52818829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:55:07 -0800
X-CSE-ConnectionGUID: S/XJagP1RSifkzKk7tpQ0Q==
X-CSE-MsgGUID: 2yq8Y/9vRSaCcn/GqPcYdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121900349"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:55:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 01:55:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 01:55:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmZNiX8Irphuvv+YHh8Qg0P8dELpnr6ehvltGxlsUGVmhg9ERxBY6FtoENNglcNMLAyUYeeSW5KphjwxT6mwdcZ8wpFBXfCWf5aed/Q6Vx1Aj8DY3oLduYOWP1ka3ur3QqTnsjqkawX+z1mAW4GoHtLestSkhB/Au1SCmReieIwUD3q36eRpQ/JFEFXjRlIm3/nTHRUFkUVdqTD26O81A1UOwvIJZcs//hgLLDA4t3wEa+X7kybxsihv+vm2LcwnheOyDzCTRhKnM7C39o+cVbDfIiv+l2uma1WtfjhxRght6d1VmjlKJ83yQ17QzR0whuvISMLw8VRDZ+SGIwuetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiS7eNgD9p9vOfq8WRnG/O08Tsx8Yp6epqUCz2FYOB8=;
 b=Ex1MhCp7ohSvcJPeedYq92FLPsPt7JHLLBm9jMz1tReDZSTfhfZtfC0P7DnB8tHEYsteEslNuqSdZNDaqVzpVfXAVFCYUQsVL6nUrv6cO/8vngvLZKawL1qkzWpNkc5a/hemHhG1ugfcViG/5Y/hT9u0CAWbbO4vSJlqo2B4+XxOKj9XqvBi6MTjGzG+Uc7SjpeKEbFS9ox1VlLpCbaZShzdDZia0T1pFHacUWFNMxdbOwvrt4aB57rwdO3nkODnGHEpAnNgNjsIc4D5SNE5RJ3JcfK7EL1lhXbnRYl04ceOaV9X6DcLR1g9LUzdY0wjX3vRp62bZlHBHJyzJEUFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:54:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:54:30 +0000
Date: Wed, 26 Feb 2025 09:54:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 5/5] acl: make compatible with instruction set updates
 for MSVC
Message-ID: <Z77k0sx39dxHLk51@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-6-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740532016-6789-6-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4bdc43-846b-455c-d0ca-08dd564b909a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZQ+R10F3mTd7ggBkhE/FbAGWuetvYrDm9YBiwX++IIHRCStA4PpwysqrSYZZ?=
 =?us-ascii?Q?/wouY5QybKl2HTs6Uw95G6YRCBsTFNc8xe8I0Wg0PhluKMjAOoh6HxrSBNKL?=
 =?us-ascii?Q?Z/aQz7uAZyPDljUOyhpNkZP8GXcKQRVb1K2gW9zOMJvpLBbyP2i6i89pDxp1?=
 =?us-ascii?Q?AxfaVKvo0r0iDXG3bowMR5PU/yVUZdf5oqD9x2VMl3KaowPMFS86KdYSNJvL?=
 =?us-ascii?Q?fRRi2whWONI3NiNf6DYnzeeC6NxL3/kK/kS78gQqorA2Hy+ypO0YnRy0vok3?=
 =?us-ascii?Q?v0yCrzvnxKTtN3DZqKXKN+VaJUG7S1zPJidJYuDbshTDrWjZMyoJHEIbCSiC?=
 =?us-ascii?Q?yidzX6A9iOhqB27Q1r/TK4QvrAZOAT/RR0qFlZ9eAEjU+AaXGEWkmG5MzNhD?=
 =?us-ascii?Q?FU6fv+EBakvJVdpB95Jod29S+SWmZo8PdO1kA8EtVm2b9r69GQ5YacTznHTC?=
 =?us-ascii?Q?d2JMRtKSJ4LpPwU0tSq4/3SUUzQ+7NKSkWvhcFox2gJoAAcaaXtNqm1cYoGI?=
 =?us-ascii?Q?V1iAS6Mv6GZH5nYdsVsPoxg7CKXnEOQQUB0/pN/gHb6n/lSRUvVOsO1Fec06?=
 =?us-ascii?Q?lHkrASoVijMOwginNyrZS9h01yl83MIwxXBu2KzGoiaS+nwXbV98gDsR8kAA?=
 =?us-ascii?Q?NEvyhQmU1Y4vzv7/2tLMgeJ2KLsLSGSnww4+gISyMFXulfHa1o74cJAPQno1?=
 =?us-ascii?Q?VcKycppCRg7coGmjvhareMpcG6nPYfdGYnKWctMcfDCoS7iD3J3bl4m4jf0g?=
 =?us-ascii?Q?oHYXIqnC0Hl27ekrXZTxnJM9f8yynEX+7VkFj6jqRFcUg6ijmTiPKIP5Etrc?=
 =?us-ascii?Q?3u66n0XriUC1/tRsniwfVYay6y+m5WChna7r6W3+OU4sijdtx/2ylfa321eb?=
 =?us-ascii?Q?oGd48Flf4xM2ABcc5eIhWlkRijfglE8tGwdWO0TloeF8bcjEiXsFPTrSyC6M?=
 =?us-ascii?Q?z77AmRfDxPBfHEia5GeXpNMiKt4NQem6xLbwL8clmsCW6Uco6CrEv8JdHZZR?=
 =?us-ascii?Q?TiYU7NQASTYApLxRJ8h/SmEZit9ShUUc02behMs4+OQOLAp+aezsFAGz5EhP?=
 =?us-ascii?Q?eQVOoSKWG8WxmP4PLgf2vCdSishd4Ol24Sp1E9M8eI7YSGGvwwWCz/6HMvoe?=
 =?us-ascii?Q?3hlO+UL/MnTY1nToW4NhPbvZ9fksmzWd9zhKysS/ctL2yj7dGheUtg3Z3P5n?=
 =?us-ascii?Q?9hrpZ7eE5g7bq6OyrlQNNAhCPW7zv8ZY3Jt0rWT+VCfd8d0H7nW4tQDxqEP+?=
 =?us-ascii?Q?/vTGGlEMPqdDtcTt003JP52H/3DTrOfk/2b70hP/W+VTuWopk4o9TGcl1nf6?=
 =?us-ascii?Q?y/daOCk2eLNImV6w7aLvw1mYAsBGxS536LR6nVyR67Aj0FIt+LU5n8WltwIm?=
 =?us-ascii?Q?HmbicUcQ2SW4JhZi4LMra5JrF7tj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4KVRvhAhuxZdtMl7hi4Fu47vOvDA/BSO6MjgJxBtQ3af/esl02QV320S6UI?=
 =?us-ascii?Q?C4/E4+iND117gqWxcdcWySbH5gKAJRmQMEbq/3/nDABpHXQGwgRgnxcP19DM?=
 =?us-ascii?Q?ABFX4kDcaBS3xzizyEZBE+R0TZEVCGvpHcp1IcVmEYOkC28eYgp3zFtIAwS0?=
 =?us-ascii?Q?cudYTQy7sPfhq8sPwRDjOUAebjnDEsts7pM2eTFBrK+THgHBUARDEHupfinA?=
 =?us-ascii?Q?ZlyzIgfXMrwqZYakwY7K8o9OiJDX598vz1HU6DXN7EjpsOz+Qi5rJqrMMlp1?=
 =?us-ascii?Q?lixxDh0dr29AhBjqGd5rfalgiUnyYTfGRjJYvUEwWtYlUN5HCviTcxFVwhKd?=
 =?us-ascii?Q?GrgAYr/ktrvwXHmqPkV54ixyaYNbCZwXwWFzts3U/ZcV5t/fr69Ap5Mtw9JL?=
 =?us-ascii?Q?MGnsE97HRUcw+WpGVKGASwHRihm38cNG2VS4fvyyFMdYGvk7FwDHQrxYR+eL?=
 =?us-ascii?Q?MsXfD22oLAHihzTSlsjOUURRTc0QsuVs44rXFW4PlAZIlE+/38iJWBYax/aJ?=
 =?us-ascii?Q?xdKb5HRoocjZazN8xXkWIMTcn2TLtSQnaHHZhW3t1QP8vc5euyFxMqgmRL+C?=
 =?us-ascii?Q?nuRfmGOod2kouqB6DbemAbHpneqjCyYsyu9nslu3HznJHcV6+FuoXYLsxFzU?=
 =?us-ascii?Q?afIlnLlf9lFMBixaBePCBbWCQKDPHSz/4H9cov2t6MpJMpde3z0jfWyTVnnT?=
 =?us-ascii?Q?ezs/mtNnZqLMVqsQ1Lu3clUElmFj1N5bb3KCFPm4lNv5AREO0ZWb9qmtB0ZU?=
 =?us-ascii?Q?HLVjx+o13LWZ/hAQVWwOCS1JJo0z/ebMIKe8Jv93wMS5793+ZxJHuV4ANOag?=
 =?us-ascii?Q?tto+8sp+0AIZGFuKSOZfVEQTsaqGbFSPEcMtwEJe2+oKctwPwXe39GF8FqH0?=
 =?us-ascii?Q?3EWRCH84H4Mt/AgbMpfygyBwqQN1ucD95Tr4msMi2DrtjKEgQDKMNoUzKA84?=
 =?us-ascii?Q?zU6h6GCMg1HcSGvhEjMBDfriJtNOhL01J5Xsjo8QUYMlcfuE9lZVcSAxjI4y?=
 =?us-ascii?Q?/bRrTujrEOL2D5W91FPOv6RlN4WAgWl7fi4VzXPAN/G0oJrhhdNUwGO4ch5x?=
 =?us-ascii?Q?6RUN4M/fxr77n4RtwTWIHU1M/klewjuWw/jlvZxc/u4rfhOVKkRUYTiM9/tH?=
 =?us-ascii?Q?LReoN8T5JudpRIgVu1Ogouwuthx34rkXmY05ajkpsTYux6PX8GsOl4/Eqh6d?=
 =?us-ascii?Q?it4B7vwkDtvIMGE6B5TFSS84gFvj081J4qZHqqEhhT8blZAdp0LvBZ5m2RrP?=
 =?us-ascii?Q?gCYSZCgl0QgZtQGBjjeESuVWkUAMG3ro2A88j7R36adNFaDrEGtR3MkwRmfC?=
 =?us-ascii?Q?1GJALwvECSnV2+sKJPbQw5KY3n9Epv8JzWU5pclfj4AfLtrwq4VXNSXagQ9Z?=
 =?us-ascii?Q?CDWKBPLJBOjxtqkeAsE4lhYBxlS3AfcSWUw/ACGe9eEe4kpDhTeIr+rV1mPW?=
 =?us-ascii?Q?TE1CRsxRWnFEvuZXQSfRLCacafs4P2MrgI9ArzWHyEbfHWb4n4uKs4WNxeNx?=
 =?us-ascii?Q?JJ0oWnmaG2GCheehHztCGHwXRIYR3vD2HGYZno17l6Prx+AzSAjrb+XmQpOw?=
 =?us-ascii?Q?tYbqJS+5yNritTqJArEh6RdvV3RrgCvjVzc4H/ZQNx+Nl/RDSzAvmma4UrIX?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4bdc43-846b-455c-d0ca-08dd564b909a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:54:30.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlmpZCKVAxf/ty3FXXts5sU7im1+HVS//R8oASjNnD94QqXg9srwLDqR1uY9QIhLCycSC9sLG+ee0LeyMJIXb/p2E4t1YUWcOMl5Kx1Ifpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
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

On Tue, Feb 25, 2025 at 05:06:56PM -0800, Andre Muezerie wrote:
> Top level 'cc_avx2_flags' was created and holds the correct flags
> depending on the compiler used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

This patch can probably be merged with the patch introducing the new build
variable. It and the previous-but-one patch are both very small and are
probably better merged.

