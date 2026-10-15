Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E1CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B4024027C;
	Thu, 15 Oct 2026 16:02:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9B0724025A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792072952; x=1823608952;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7b65agfPW9jTaE6Hhd6P0UuzyyfgqvI5/rIvUFJvZSw=;
 b=HqLeqgtPVW1e/uBMKmW7zSpspAb5JHe1wT9C2LTAe4N6NyUr30PU44gm
 00YyGDGsdynKOMp8v0Gjx/X5agCY2IdATP2plDPDPs9zAL4hv6d0MEg6A
 6Nh2py/AC4SIQ1cxSMEOEbhPMzMrK2foDNtWm/INBIfa67DiSgop3uH85
 IbXQ2tnnxF4geVakWg3Nfj4ikX1xzjxg1GXgeqTkRiwzUixmB5uL1kUih
 7Awu+Wui7Hm4vJLdr2Q5dibrJ+46VTRMK+ATDwCOQpqdR1jzAloVUayt+
 V1r4oOMm0boa42aLOyQQnhV5x1nJ7MEhNR+4AyyVRI6tIRVNaDxSEOnOc A==;
X-CSE-ConnectionGUID: HEubqsvfSO+6Og0b2/WF5g==
X-CSE-MsgGUID: eiL8mezxRDmH4fOgoSQh4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="946400"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="946400"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:02:30 -0700
X-CSE-ConnectionGUID: 0QE+kZ6BRVy0cig+pJgiyQ==
X-CSE-MsgGUID: rYyFxhipS3+1nAWKLid29Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2134767"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:02:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:02:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:02:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO5C+SKxh4sANe9TKFgpNvCKLkCHTaYjkGOGo4yE91GTeTcywMlzzMVs8QVukuO722gdXUrYVxaoif/uLZKphAHz+XYDaKUH1ws10pNZ0rOkUZXIxYxBcFgvHKH/se6z8t0CT6runsvMNlRWoG/X3n3wvrj9f97xGP+g892q76WkVfIbY0d0Efc0MmrpwY1JLL0P9W4FPiPMmMiWma1DIIc17nwPXvOSxNTFWqE0ZHW+WulW42rvWLN3/gNJTnkb7YAQAvAs3wVIzBHu4C2nZcKgASZ/aD7gbvSpCwWNTcdCrbANaw4ASbBGQGYNX8LKLX1V5xO63kKwjBz9ohpBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqiZDHL5ypSjJoZBRkvkE9MD+h3CY2IggrODGgc+SZQ=;
 b=vbjiV7F2JmiLEpOmQWMYCL4zPhYNTyd7VzLJTChT1gs03ynMl75UFeqpPY1s2HLUfyWTrzbvOkvIYZpX1i10ULRpqxPMSP1hpaYZu0L/Cv2OLGOQMSriorYRqkwzqg1sN3ZqDmZQwQFbDo3YzDT3fEr32TiN6kB2U30i8Z10Ms6WR0nmMeUVlqPHUho5yRJZY6E+Yfl1CDtoSDTs9SBKnYIAOc7mtKzlxruqNdlZBcwlGNCmAUe1RosFDhwwdaPGWKDO6WVdT2iU25ssUJeFfsxYPhSyNV2weOnC5fCSBJIsh8EHFDgwqpO/yUrBjqnAEJ/baAhA4j1tjegsOlWu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPF529E923C8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:02:19 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:02:18 +0000
Date: Thu, 15 Oct 2026 15:02:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: set interrupt throttling register
Message-ID: <atDc5cZqzHSSF-F6@bricha3-mobl1.ger.corp.intel.com>
References: <20261005110613.473007-1-bruce.richardson@intel.com>
 <atDYWtn8lwvGspyT@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x_-WcbE6i5vh_vaTXPUqYwaNXNY7eFgQpqLjzHWP1CVg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8x_-WcbE6i5vh_vaTXPUqYwaNXNY7eFgQpqLjzHWP1CVg@mail.gmail.com>
X-ClientProxiedBy: DU6P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPF529E923C8:EE_
X-MS-Office365-Filtering-Correlation-Id: 04142ccd-450f-4818-9212-08df2ac4ec9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XsVSVPGnZOMPVBOFAE5HmtqepgHtnuOwqqV3QFMNiksq+lksFXscoinepdI1C4zu3zsLaKBQ2+m49O/e39eY8F5TlmhmPFX9//kewdGZuHpzgP02RAtpjARscHoLWIfQSFrH/ncO3W926MhIfmw5hpuyGBgKQyPW3+02KYFHKudZyjoe5C+aWcs1QiWj7D4Z7iyegn5kRj/W9BlrfL+G7rGn5P+VpaJrop9x/mzBXMY9XMAXteG9i1ccE4hrDZEYQXfoGYuI7Iqi+BI+fv9P9Op78pPE1QvNThrSLmEVA1qpIH+Io9P17WEky5YBkjIq/rjMziygIUiAh/YLUVSoVG/lBoqDmtcE9RF1LUIoeL7xQe08FGobKoZAI0bmS8rbVyyStgIuIU4pgLjKCYCO7fe5MMJ3epZ9HwFkaXwO5W3bmGFVZjHOWNN4pXRldzv3zm2FjR25nNDLt5t1CGTEpRY+NtVEO8fRRo/7Hh40aSWMlvoPZwFb+8//Fo8+1HPVykDbLfDOyRMb5YIsd0negX7mA4hXuXBMl8AtYHCL45yeK5gUQUdoMGoFDm/89BnbVSNQogPl72Ov9m4HKF4kIdUvj9bJSTdXzGnYVkbM40jCMwpSiH6QXogUWvNnB7+Vl7V1hFlUeAktuxDQhWAlW1hyUj+UmTvoJ/sj9uCNHog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hxgI8NzHmy+xhM0td30E10yA5rwNEU+rc/sm7eYLViNX5f6hwrs6v9tJsKKZ?=
 =?us-ascii?Q?QCFCBMATh+tT8bLYgPafAdTexc0iSoB84TQZiSinXL6eJgV+fFREP2I3A1xp?=
 =?us-ascii?Q?E9Nqnlbtm7XvcrORXTryRjLcTCYtTRSRe+hQ5kM1nzDWO05bOJSG8uvK9sQK?=
 =?us-ascii?Q?LQyxfVmUOpQfF+l9coOxHT84jAHaKBbwwC/7Sw7t3dLhi+UQu+u020twIKfK?=
 =?us-ascii?Q?VPFACnjiVXabs6o1Nh5W6g6I+oSSd2ihfBfarUf0OLfJMaWmA5nbfJSpwhMH?=
 =?us-ascii?Q?rhpjk4JP7NbxGWMYG1OwTLTyj71qj2xSs+MM3AcgqHVGJSn00sXNzyf4j/pj?=
 =?us-ascii?Q?pC/wsr90lRgxK0r0ed0alFZK0JdFC7YCQxMG/PoaR880DIN1SR+N9CSCUJ0l?=
 =?us-ascii?Q?Z+Lp3rflV4B2KDkCHYEaD5s4nARWoah4ycQRId9IW10HfYTwWAD1D5ZSQ4Oi?=
 =?us-ascii?Q?mZQKWZ55srKJH0ZyjfeC4awh1mIaCVbOFg1dg5FMtyPbuf2bk3mor0qteWoA?=
 =?us-ascii?Q?X1r2cG0t6uksllHSJHiAyqFXoFgYZqC7Ge3H+zmjVYZlruLXwQJeYze0RmBJ?=
 =?us-ascii?Q?9GuyquaRi79fPVZCyxu/+SiivCcn6v7t9P0jxvtyVs/hIsOlhnWYzwLvwEuI?=
 =?us-ascii?Q?5GNEN+1S3kiMX7yzXN09MUy/NRjT8U8PAFdzcRb/Qdam3d0MgTFdbP2jJCuf?=
 =?us-ascii?Q?eovP7AeRLUzYzqZRCckGNX1T42TZiJn6iNVoIiXAKwuopH6d0xxtnCnbbcW8?=
 =?us-ascii?Q?MrYI2B0yt1yEncECenr5r/2MzoHqsb/9s1v57qeC4gjU+wNkMvKFiYfZRXd8?=
 =?us-ascii?Q?SLC3hMJRSq9wjulmkXU6c4pIfP7S1FO8ueByCe3p1zwKRnKaSYi+Y1VXadfe?=
 =?us-ascii?Q?/lse5RSJyDT6xCRaZiCcUAohmIw+38n56Epx4M8WwPz3pWImrnHD5KXSp+uW?=
 =?us-ascii?Q?r1xiO2EZPdKm6Wnj/OCadDEpIVQq1IQBQX37SYG7SyNXTbXMyi4C5KRqy4Vt?=
 =?us-ascii?Q?35M3IleDVnVBaUQCfun84Q/5QcW2blkmuWYiZP7PNgj9rrYfwH0aMgnUPhhW?=
 =?us-ascii?Q?V1MDegKTWLgXvJotrAdZFwzTp3mFUqhyMf4XqbQFzkIxdIj3JyZS0rOmW/RY?=
 =?us-ascii?Q?7cCAtUjsYnhaO3mxRCTO325B5OOv6NBotVJWtAp8KamHAf/rDa1QRG0P8fgn?=
 =?us-ascii?Q?mrU0cn6FzG8SDNeGIbow681E+S3gLau2E2xX0mvB5Dvp/Beo4Jvgg2mBj7vI?=
 =?us-ascii?Q?omKhu2/FZZ1Ejw4fTbi2n+WKb55S4Guvkn16yf7SbJxU9BQBCB+btUgt648E?=
 =?us-ascii?Q?SPfzbSbDjzvqtv0Nbnz/hdR+Zqoum96LsvEHgrKOE0FTv9PdMe2ducPI2rgi?=
 =?us-ascii?Q?JTQX0btJc+U7WKETK2LXXEVIqT0EWOMskueZb7mZYJXJtepBocnKPxgMxTar?=
 =?us-ascii?Q?s4/gDObl2fgP5iakwb4jUKxg9Nh68MgInlOA2da5qn2ucX4+mUyorRXlA1PY?=
 =?us-ascii?Q?gi2hBNYhtbkd7nY9IWcCLKKtzXfujnuanGOCURVIURkLwJ+WSi1zk9bMwOOJ?=
 =?us-ascii?Q?Fr8KgADjA5Yc3wYTU1dLXqncVYTojs4T8E3eS5ctA1Xbvy9Z/OUuG4I+nzxO?=
 =?us-ascii?Q?VWS3mcyGV4ImMnvwaUsnQXXiEAO8vXR34zQWO+Am9CZtCk7Aj02YsvND1lmu?=
 =?us-ascii?Q?B1gHeUMl9KKYhRezC6ntj2BNmzCJTG8dAAxf3TjbvwF6kVygwDUxnUqv9YxB?=
 =?us-ascii?Q?cZnosCYC/U6rH8QIuwIHubdz5pRxbiU=3D?=
X-Exchange-RoutingPolicyChecked: 4sdoCwaqhd8JRUTQ+3gDF7vCjCTlOrPA/ZwVKF5MX6sLQcXEi7Wo/G0U6pdj+TwZXr8j6ujsV1c0XhzM71AJUc/y2NfgDsISoKvUOhD/si7cDCc1rYxTILTxN+6iDsnYyDZYZ+iNnFylZkDri3hub3kjEQDImYo2Ghx9wYffrLtVuHNyQVdtB3EELmv0N142rF0Kt4xoIzKllRFJsoJ4BWqQddYQ9W3WkttwuVg1DBu/eM1c1ljoFMouw3RCt7KfR48Qz5XAd/u6wW3coHRTN+G6Rndf2qlU6s7MWu8rZqBdBihNbwW30911j+LmNUefxKYKUF54SDLkAXIWsePNUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04142ccd-450f-4818-9212-08df2ac4ec9b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:02:18.5312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcOQSuG6W0jg5lUB3OaKqdUbHfewKenr5stUCAwW1lHTN68PoGQNTwPJXFygsBeQafKDnGCPxFwX3MqPLKKeiFbofOgCz0T1LaCTWWM4LCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF529E923C8
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

On Thu, Oct 15, 2026 at 03:47:41PM +0200, David Marchand wrote:
> On Thu, 15 Oct 2026 at 15:43, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Mon, Oct 05, 2026 at 12:06:13PM +0100, Bruce Richardson wrote:
> > > The interrupt throttling register(ITR) bank 0 value is set to 2, but
> > > to ensure best performance across all systems also set the bank 1 value
> > > to match.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf_ethdev.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> >
> > Further testing has indicated that this patch is simply working around a
> > config issue on kernel driver side[1] and should not be necessary in DPDK.
> >
> > Dropping as rejected in patchwork.
> >
> > /Bruce
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb096882095e5a8d6b5159e43793d4a38a0c5b1f
> >
> > > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> > > index a8abe0154c..dc3cea0b95 100644
> > > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > > @@ -899,10 +899,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
> > >                                      (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
> > >                                      IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
> > >                                      (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
> > > -                     /* debug - check for success! the return value
> > > -                      * should be 2, offset is 0x2800
> > > -                      */
> > > -                     /* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
> > > +                     IAVF_WRITE_REG(hw, IAVF_VFINT_ITRN1(1, vf->msix_base - 1), 2);
> > >               } else {
> > >                       /* If no WB_ON_ITR offload flags, need to set
> > >                        * interrupt for descriptor write back.
> 
> Why keep this dead code then?
> 
No reason. Just haven't got the time right now to do up a replacement patch
to delete the old dead code.

/Bruce
