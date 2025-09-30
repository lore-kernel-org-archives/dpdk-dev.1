Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDBCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:50:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F8640150;
	Tue, 30 Sep 2025 09:50:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 51955400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 09:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759218654; x=1790754654;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Sgt3COv6HbmWWnjnSuLI8FOBs1aJYkKTjUVq+JypDCo=;
 b=NiUfzDZ351EzE1X3Ki7FuvmmnC1b8e/IndDiOq1m4sUf7JdGQzkvqAif
 UZ9MMXtqe55O1k0p8RnpaYN1xZMEe5VCjvvkO1Nt0zSCRtQfS6Ocy1RHk
 CjwFP3CHBHb+r2z8erFHqykSV/lhRPviO2j6iX4/uF3LuRNG+z8jjv3Y2
 T+E38WkjehMdb5txTIk6yecoK7c8o/kt3pZMKkelgeYbmMFYfOgClfjh1
 pDybKbiMl1+zBp9uhfBTgOTTIfjWvSFor3rjbHgxYqthSmgbKswRfX54r
 iKIGJFcOlbmKqTuUsS/Kt9Mc5fW9kSa5g1feE2+RMwfCIT/ohEft8fCLJ w==;
X-CSE-ConnectionGUID: jHgU/CltSdas4xNh16tj+w==
X-CSE-MsgGUID: HPQQ5YIoQ5iMJe9tuO1BiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60681587"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="60681587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 00:50:53 -0700
X-CSE-ConnectionGUID: qgJOV2esTBCPqtU28U/jyg==
X-CSE-MsgGUID: vKk2PuXJRpC7XvIy54EKeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="202137682"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 00:50:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 00:50:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 00:50:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 00:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYvdbWBolyEHP9oXxuyo/PPpJlG8zwgv7F8kAs4WqG8FsqObVDoQogjmaBIcdWSdzzb4HPd18JfkWckukNC+9blcIQ10WPLj4Syw9A8FjlLVHQpDGauIAD2MB25FqvWJA01Mdiilewvf0tqhwo4rjhR2n87X+L4RlG2fvJ2Ogbnj0cPjVTH7JhDhEmmrhk6IOjeGKqt3iLbjn9sbWP/gV67o6F4H9iaEq4STj90r5HqMy2Lyy4tv4YFiE5amcG/eHuDnwJf2ykcJEjhAz+oWfnGf+b4u2hxl0jVxfZLhbUcJRbjeTYzvVMw4aRtHeSWSX3GxGfYqh1WeEUNvPCo5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igheD9lTYVhoIG9aNO5CJQYquJdJNRnYqkj7BXUdaDY=;
 b=fLAth3DfKLpP9+RulPnNcW2RlBxT3cWlsZdbEMEOUwCyjRx8KzxIOAcahNq3dVFopfVxk9duekS5jeYqTsMkRwxSrWyBGkwuARr3tFNXec35DCn0CL9BaXXducgJz9FNmXaMlZtMTyD8bNWHlsdjgp6NHu/fXecdGrueLCT+yzdYdF36UID1QrSTEoNr0GD4q4y9YxKOKGXnG4cryNSjpravc/N4lX/ULJ8rMZDDAl7TiXnctWSUZ7FdNwixySQ1FRH184alSsn/ASR4/k4r3eNHz2klduoJMNXclxMdEl1gsfcUz3hdHpc5x4S7bTXV92ENOd3uwrVU/kWIagEVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:50:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 07:50:44 +0000
Date: Tue, 30 Sep 2025 08:50:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shukla, Dhananjay" <dhananjay.shukla@intel.com>, "Patel,
 Atul" <atul.patel@intel.com>
Subject: Re: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Message-ID: <aNuLz_WBxYmQFtZW@bricha3-mobl1.ger.corp.intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-4-praveen.shetty@intel.com>
 <aNqMSu1HDRB8qsvd@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF291EF9BF18F7EF5D14F1ADF7F83EE9D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF291EF9BF18F7EF5D14F1ADF7F83EE9D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e15295-5388-46c7-d069-08ddfff60f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+I78DCDrwifMJMdQ5jf86mpIoaCtPsVgYNvHJTJGWWVmRhwpKe1TLbNe9xZ?=
 =?us-ascii?Q?1HjYu/YpwD63yS7I47nTyzltMYOAGZbl2Dun2KqmbPFwplNe4YYxza/pkxr4?=
 =?us-ascii?Q?KbjN4791ls7Mhf9JUiKMak9/aMLPhhOrC0/5ciGCT3d3GHi+8XU+Bml8sDep?=
 =?us-ascii?Q?k20Hc30fr77fLYpoa00FB6aYMTgLs8tOo6lkzbHu1ychU4xXwmnY+auifmn7?=
 =?us-ascii?Q?mCM00nOkVkaU+q/rAvk9oJJccMabb2oYMo7EpIvCfqZ0mGoudJEqJeJKpRx/?=
 =?us-ascii?Q?jzchjmyiln1pWY7mNypPGti+6pp73p10PMXbNzVKEHDaXE6Pbh762EQpXAP7?=
 =?us-ascii?Q?ITVSAdBbwtXAzuekViAVJu+E5poEE5VRkECglqPkjuXDkVBt8rOYR42osBRi?=
 =?us-ascii?Q?GNBJvcbwwqrF0Fy5pmbXW7d4T3PjuCR6Ze22mMZoH0PPH6cvbziunR7hcBBh?=
 =?us-ascii?Q?WLIfbTrno+4vLcyLgHgaItq77nfOtmrY9MqM3zQVYGd7FFWjGZAbwvqb9/g1?=
 =?us-ascii?Q?2wtzOxuMKixd6ivBY3chNTAD8YOfRcHrbtKP3oEtu4OyWw17oJRLhaixWq2U?=
 =?us-ascii?Q?hUhiagZlZJc+vZMgv2Y6bEmb4F7QmPLtU2ONNZ/MHc07YvEcFQdmBnKYp0u+?=
 =?us-ascii?Q?Ia2urCk1BJKDd9S7h6R8vzEysp26SRhzdIwEcHt1AmrfQhChbreYx//9dfls?=
 =?us-ascii?Q?gxeP5kZymouX2cbsmNi2euQg/ZqYNYGQ/opkwdDKRhDkCpfHukk6+m+b4d6b?=
 =?us-ascii?Q?p0cGY4qtRYGhVb5/lLsRMA/W46MGg1fjwBwQoTaByoSG2haDTkA2eveBDv3U?=
 =?us-ascii?Q?ibmkDUVEHeTEDVGV3EMOcStMWG4VHXFbMstP6Dc+kRse6AqjJuK/UTbgVP4w?=
 =?us-ascii?Q?zxAbFf5uAViZURpHC/8H1kx89Ebj4/ByOAvV5uOq9FtHtB+0nw/sWVfj5dx6?=
 =?us-ascii?Q?9yfRhU3SyBiVMlLr1HtzU7k+4RVkqCsDsB5oECRvT1v+McjIBdI3HYrocS1l?=
 =?us-ascii?Q?kkM6sPvdG+lbmy/S8Sy1BnAr280etpwHm38JUqPZPXLe4kS4bLJKBu55mqy4?=
 =?us-ascii?Q?fgsrF8gL60vrICXkfOpDOWbvXBnmlo8/G8OkMpvW/FYLnm5+QFQWoQjAawQg?=
 =?us-ascii?Q?dxxn2f6klnwYDFjab42ul5aXA/KfE8tXGIqnLsmzticaLfvi4gTCQTrypKKS?=
 =?us-ascii?Q?b9PFxEvC4oiwAyYk2VUBWzX1UP72JDRCYtXYr20RxstCF48/KbLqfBi8EzRJ?=
 =?us-ascii?Q?E9B/E/hs0ZFuMSG9G/f+YMcov9S06peJeeYnHWlZ+U9GhAipUJU1A12b1EaB?=
 =?us-ascii?Q?qetcnofgtGHNh64Jz5W+rIif58cW8UyNxjPc8XBPqjwJ2Iet1xvMRnGMnJ0A?=
 =?us-ascii?Q?nG0EEDGG5NVIAM33XUIjCoi13ZuGbaPKPskWXpOzOUy1t4oxiDpACK3CrVfq?=
 =?us-ascii?Q?pEw6+XOD8tYtK6zCF73+dzz3ly85MDj1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQPcfpfAuLr6oVJCAmuwK4E1vLQIsFVjUm6hJNaceNvkqs13ScVnoxAkSAQR?=
 =?us-ascii?Q?xf3rvdF8b7aCvnpceN6EFXWkVB2ae+V58iNoPW4BlDBwrRyN/WiyNBGGW9j8?=
 =?us-ascii?Q?gYvkPQgc+mPkBFHzY6bDyiXN79Arv585oW5EiDSsvBmIo+sFTVSYJ081Bg3/?=
 =?us-ascii?Q?QncP6uTbJI7atK31SZkkxRtBa314ly7TS7szKxrLG4hHQnJgn9dmHhS4ORWV?=
 =?us-ascii?Q?mskHr2Z/24p+B3iQAd/Vsyu8z1ljqIq2ehIamQDc/JgbdoP3KE3V89D3g/nD?=
 =?us-ascii?Q?lPVnjijP+G33lyVw+IjWp1DFtZfedoTSmXiAmTs+2cYJXaRMxe7sM9ck8GuT?=
 =?us-ascii?Q?4ko7ePZsPqSs2s+bDpb7L5awbNOTb/rgpPc+Ucg6LFbeZFGKqRerv+eYEc6D?=
 =?us-ascii?Q?vQ/VDaVg9wRQyh3EOC2iu0TwtLUWtZ3QLFkwkZv1FI0aJZllixge4R7PqgHR?=
 =?us-ascii?Q?rvK/GnCwuQTx7PO8Bi3gKbZgaEjNlSPuIEgrk8qTWLmd0pLiI87tmuZ19vDK?=
 =?us-ascii?Q?ZRBEP1ZSCVW+b1lRJKXkw5upatls8+tjQWAByU24tKf7crsYO6VD2EHuNASk?=
 =?us-ascii?Q?XrikyhMoSHYTYmnxy757gci75eKjwUU7awMC/p8hr7qkLfxNYggPK9LqEu2d?=
 =?us-ascii?Q?CF/EIsyGrrMuzwy3nJ/SRXgAcDg5NQ//WkYiMbcSahWHCHIH6wdKWloT6tRA?=
 =?us-ascii?Q?fFUHooKKAgVcu+m5yKQ2i8SVNUUGIX7sRS1D6Hyj/A1OYYIV20R3FO4//YMU?=
 =?us-ascii?Q?0HFLt7SGg3iVcYMHk0mxZ4NQWNUoUdW8uK2rOPdsQ5rnmu6uUjsBwYnsIFy0?=
 =?us-ascii?Q?AtlUw2jAOosKb9qNzdDoAy9Xbw86Tv1TtTiH0Oro2meGV6u+K408vF5kLQaN?=
 =?us-ascii?Q?YI6wtVe/JlNOF3DL2dZmi34WSOpr0Lf5QOIKkymIsVQ3pxK/60tZAv2L9+J4?=
 =?us-ascii?Q?p+V8Cz37B+XsmOnUCnMxhU/OIKz+2AwzuSdtCYgAD2Ry9zoMBEvICe8V4Oz9?=
 =?us-ascii?Q?TjfCX9uBum8OIun4pNkrsUN+gKLbY4X6BAfdxF9WVn30WTGQkdGKaiJeOhYF?=
 =?us-ascii?Q?R/7/kQX5TRRGwQnrYDue5H4RjzaDFKS0hozenYTWUh1b2kmb9lyQcbel2RPn?=
 =?us-ascii?Q?FtG1OvAEtNsiEeE3sKzgMxfO8wmmP81QlPjxov5SGr8bDOA25z2qj9QsSNzX?=
 =?us-ascii?Q?xf+qA7oyWd63LTmbpyANdiw/km89+SeMpzKwqsXJpNTwrwZNwHct88e9HgL8?=
 =?us-ascii?Q?knz/MaVCCgGA9yC6bckYkYMoAVFVpV7aQTDcdDHlM+7z5CoOosPwHAbg18+N?=
 =?us-ascii?Q?9LmARDgSQoiSaZy2Mj7cc1LrzXf9YZAtYQ/BCOA54ThDldXDX7N4UwIkiTYM?=
 =?us-ascii?Q?iRQ1OvrMzFYcVt4y2e93uKk+LWwovycyfrHXCOP3MwmLpC+yvvv4lcvhbulg?=
 =?us-ascii?Q?kP+yrthpNjYQmQQmlsd0GSnZ41OKp3/np7yNRqYjozodkJX6AmtzuGVNY9p1?=
 =?us-ascii?Q?eQ65kWutXT+bDryI72ynil/2OVuGa6Ex54QIGQZE9OzAMDWPmHPQMs2SzbQJ?=
 =?us-ascii?Q?rQPmST+90oBR80BpONfeAbPVTL5qC7oUoNkrr9nIhH93ABJ5vienCKGc3rLv?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e15295-5388-46c7-d069-08ddfff60f7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:50:44.5707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B40NdSC+mzMRrOYAgj4qf+4u36RAuLwQaJSDQ1yb5o5v893IST2P22NLkFRoKhtTPVof8NXGgaNfuGf/F4LztLVlBwKdKwzE2l6xI4uVsY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
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

On Mon, Sep 29, 2025 at 08:53:13PM +0100, Shetty, Praveen wrote:
> 
> On Tue, Sep 23, 2025 at 02:54:54PM +0200,  Shetty, Praveen wrote:
> > From: Praveen Shetty <praveen.shetty@intel.com>
> > 
> > A "configuration queue" is a software term to denote a hardware 
> > mailbox queue dedicated to NSS programming.
> > While the hardware does not have a construct of a "configuration 
> > queue", software does to state clearly the distinction between a queue 
> > software dedicates to regular mailbox processing (e.g. CPChnl or 
> > Virtchnl) and a queue software dedicates to NSS programming (e.g. 
> > SEM/LEM rule programming).
> > 
> 
> Please provide expansions or clarifications for the acronyms used in the commit message, so that the commit log is understandable for those unaware of what the NSS is, or what SEM/LEM refers to. As far as I know, these are not generally known terms in the industry.
> >> Sure - will address this in v4.
> 
> Also, you say that the hardware doesn't have a config queue, but software does -  I think that needs a bit of explanation as to what exactly the patch is doing/implementing? How is software providing a special config queue if the facility is not provided by HW.
> 
> >> From the HW perspective, both mailbox and the config queues are "control" queues.
> >> For HW, "opcode" in the queue descriptor is one of the key differentiating factors between mailbox queues and the config queues(operation code is different for mailbox queues and the config queues).
> >> Mailbox queues are used for Virtchnl and the CPChnl communication between the driver and the FW.
> >> Config queues are used for programming the FXP pipeline(Flexible packet processor).
> >> This patch will request for the queues from the fw using add_queue virtchnl message and configures it as a config queue.
> >> vCPF driver will then use this config queues to program the FXP pipeline using rte_flow.
> >> will add this information in the v4.
> 

Please provide more details like this in the revised commit log. Doesn't
need to be fully this, but maybe a summary of it.

Thanks,
/Bruce
