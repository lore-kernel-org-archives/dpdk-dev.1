Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A073E7E0C3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 10:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3AB3402B0;
	Mon,  9 Feb 2026 11:42:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 76D574027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 11:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770633725; x=1802169725;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HWZ1BoP9SRrjB+hBTPZvJMBgQckGZicz409vpUfU7b4=;
 b=b3D5ZNU5oqdKgZrsU4AxAOUUvIl5ftySSHT6pGTfLHmSwUMgAbGrkqdd
 8KxEn69TVN6Wiezco1mWbsy8LeHXAz3AnnETsOx8UpoFx1e+Y/OkPSqlt
 +yBRKpxJMgs6KgRoGYek7oToTH6T9i/KLLzrJ0b1M2aG36kFOngdtNMZG
 JVB0UjJwGWcLQfYMMI9oexVoDKl5k+YeeAKcZsvG7Y7uIKd8lRzQ4H5Pi
 cvh8/jETN/FrWL03jL7QFqwNEJ02esizrSf1tfy/A5aFKoT7AjtKkd8VE
 B41yTjORDTIRr8wgEBkrcgmpfzW1I2LnYwOaUBzP3FbZ4wkQEclgThb0d Q==;
X-CSE-ConnectionGUID: mj3dh9CgSayhYho0DZmzog==
X-CSE-MsgGUID: sw4EtopkS3GgbfhNDwnAjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71634750"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71634750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 02:42:04 -0800
X-CSE-ConnectionGUID: 8GdjAlGgTMK5rKh869YruA==
X-CSE-MsgGUID: m++319+qSmS6l0cSj5hCCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="215722399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 02:42:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 02:42:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 02:42:03 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 02:42:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku6MXtKUhE+W0+XgW6Az4/t1O2QB4zA737imkXvT94IZERP1iC2pLaD1vFBfIVh+ZOTVP4/SectryXZCiAACsevAtt7Q3FiRGOayDqPc3U8Vl4PwqjB+AW38z5eKr2HoqQ+Q9tGRFdJ2WqfAsF/nncikPy8iVM9xkNw9DjVOusiKQHd/94H1P1ZNBgtICyRiALz7eH/p09cpFfC/QIS/qzuZws5F89Ky8oXz03sDVlZUlgEUI4tvz8R9MH10uuJvV+YvInbCDZJjui0AedITev9SgBdb1SidGnEDHakVEOA1ClOuKyKUs7ZKM5pu8uHZM+ej7ly6Fk+WUOUWIhqpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hURFpEzGX2NHJSfnTysp/BjvPC4U1zYW54vPPZPCkA0=;
 b=pUIJk4DVs0AqCk6rIqx9WHltgfgGiDR7nMYP7NhMynuHAgOdl7K/Cx68qiZZwKgjorNKG9LO50/z9h93QRAr4ZovNgcn1zVw2bqRRByoxSngifFy2NuVlUfgtzHeaewtvLPcD0070ABCAZpaQvC1uxMewESsTE+yUgP6A+G3Qhj/KXO9puzz8sPgE1rCK7Z7wxffIx9kWu8gulNaaE+s+YnR5d6EqLgC6IypK4Y9bFVsX8Kpy5tJFyJZjgrEsCV+kyEsimPuNROZv4iGB/3q9fab4QuXSv3a4s3Kv2D/a6+Xwv3vCxUyWAfHXMYMmq4taBbn0d98uwbK1QooIB41dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:42:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:42:00 +0000
Date: Mon, 9 Feb 2026 10:41:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 03/36] net/intel: create common post-Tx cleanup function
Message-ID: <aYm584488ChgCa6D@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-4-bruce.richardson@intel.com>
 <DM3PPF7D18F34A19F8116020680DC3EB0788E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A19F8116020680DC3EB0788E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: b57be303-2d4b-4d18-47b8-08de67c7daae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bv99Gu/jKxMgLFwQ3M+FvxCJJhxS7lO7TrbFEitzMZsq0t4avxBuYruy0cOH?=
 =?us-ascii?Q?5yG0lxDjFd+i/2FadRJN0NUc/aL7cOwDIAdZJAl0CykjGn01LyppopIje0UW?=
 =?us-ascii?Q?p+FbO2wCw4zpvGChf2ZVFEB2jFfflCD3QmVfOeLVHncS4cw2SDmaxJX+lWKU?=
 =?us-ascii?Q?U0ftzEI6FQabtOqK7nT93BSCzpu71wbQOg4HzFYU8knqyCH1RZBSv2bQfnSR?=
 =?us-ascii?Q?Ioa4a0tQ5LlmuAAH4MQ/uouNUj56BbVuYgyWsEH8pdZvLObeWJBlBJsxf1/S?=
 =?us-ascii?Q?YPwQ+rm0skcKAcMaRm2V2p/yoDiAR8HIiT8sC6pgLARsHgCDyJtViXzVQUi5?=
 =?us-ascii?Q?+zOmAcED4cpnENG1W5Fn/obiev5z7ZPQje1QiBLkfiVMIfpLrX0VolXmv++z?=
 =?us-ascii?Q?4BEM2AhxhiM1bBabaN+CoodfbtkquIIK4cJUicOIyzNWt5WIMlH4L/KdUziz?=
 =?us-ascii?Q?Gy74taRZP0k9/b0DilileN7B6CctAu68ouN8v1j7pIf6pRdPFHTH9vJ6cAXU?=
 =?us-ascii?Q?OHWJY0puom6dulCYxDGdC4KWFd6Z6+9tCFZJEYgrSj6rVgQRhfIxsAd55Bzx?=
 =?us-ascii?Q?zKB1WiVl8IWrbjUkgoF6JgwamFafOrYWjlMx1T0BZw67C+EHz0daes+01B/5?=
 =?us-ascii?Q?KkZRI+XFSAZA1gN+YjIHMW5cL0IIeN4dkVgApjRu793PKrExnhB3M4TRl+7S?=
 =?us-ascii?Q?BU5XcwT8TFrE98F694pEL5mza39KwiNAJnVbz7n7cpDxk63OPpdO4Bf+wp6A?=
 =?us-ascii?Q?ysicaW7OGzESAiOsNTY6ukOVubS+29oapjwQdD+BucMsQLaEVLmzgk4Tofo+?=
 =?us-ascii?Q?OL2tRh7Vc03ACyTMkDJt/X5jvP+MykDVjHDP+xRdfzAs6bLtMFEyOvhaEjoo?=
 =?us-ascii?Q?6q7c9J0/MgAO7pV/RsdtOEiJv5L6HJbey76SF5jk7ElVJDcz27jBhhPT1CwK?=
 =?us-ascii?Q?p0pvmaaGCV7ztHCiiKaGzNz9/45rvnOy0NAtGPW6DJ8rdehuFmsHgK0TTtXU?=
 =?us-ascii?Q?WapNFSAjRFALNQ/2/sn1gCIIE3Go6kz3tHM6mn/9vTO8i2MH8RczlmESIJmS?=
 =?us-ascii?Q?YdEATNqOXXLu81Meuy7x1btjcwnG7QTChME/HetZQhipfgP6gb4eP+EPdUci?=
 =?us-ascii?Q?iRNpisI+vgb31gfSg0BecvUeZgy5s5YdLHdJNMVKdqqJsu1f1lXg8gCoa9ca?=
 =?us-ascii?Q?/Ct2MhtUojlTShVeVJQ+xohjZ7lAapNuwGkJRO1G26yVFFpLFBf26MFmyLgA?=
 =?us-ascii?Q?x449g5xbGKC90nCvCJBfwkNtnJ47TbYhSrT1J1jHAfnX+GoABL5f7JR+NGLr?=
 =?us-ascii?Q?WdM+vdGQQb5W6N/VAtGGL7IbE82cBt54AsrDSJEQ9nGSxZ02o3a8WZVmZRfB?=
 =?us-ascii?Q?Xxur2N0urxFmUYYlTj9DLcgz8JOwmN5cbvgoVP8WK6StlFP8ag+/HzV4Dfpg?=
 =?us-ascii?Q?CkrwR4rKp1qizSdDLoS4iKXe/SMNVC5GZVBGsPsEVsFl43ekeJwaxMiSBh4S?=
 =?us-ascii?Q?OV4yeBtQrY5hRAprbsrBnuEIf5Cfqw7JGZbloiseG7SjXnM8vPuxTnqURt7k?=
 =?us-ascii?Q?rd/Ut0KE9b8WCFeIXrA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JBw9TeSdu03Qh8vMdnX+5hQaLKJkTijCFaWo8VaKnpLQhz4WMt67OU7yPCQ?=
 =?us-ascii?Q?kmR/cyH13GcAqAJK+PzKWJCFyuvbwQMt3dqfhLC3lHFU/28o+NHqnGkuTn9j?=
 =?us-ascii?Q?to9nXpp6y3ccsoCyd+R5hChfUgvl4ZN6CeTXlttyRwJB9QQL1ANHOP0LrQ85?=
 =?us-ascii?Q?Ge5RUxOBkmHamyaZFqiW3Rms3o+Yd7Mo476NGhH80Lg4qKCVtKYWfuht1DCT?=
 =?us-ascii?Q?BWwtRtUuwVoxEPsgZ11mwda/QZDcwiOTxkXqGAz3/C7l04ei+Jvi1q+WDRaQ?=
 =?us-ascii?Q?ZvNb15uGsPxk8RlCijS1sPuhFDgwQ6UezuMIjan7RQRPjV6vIixRWYjJ9nmh?=
 =?us-ascii?Q?trfbpLb0ZUU/EotKCgfyDcLQHztzHZci+gHpm8sILAAzhX0KvRkMzwxyjL+k?=
 =?us-ascii?Q?7jinRTJ+j0iGcVbQgwMSBHoGo+XS/BrXT0BoLSmaQJW1MFmv6HtDv2Pk5RF8?=
 =?us-ascii?Q?TTpZmk3v4Znkx9AobDZZDDpycDDWy7IUKmNNhHyP3E4F6feurYuk+7725kPm?=
 =?us-ascii?Q?UFg3cmpyiHBvjgo4g36VXf4noBw/e/0HyEhUb7Q56Sl7SyauqGVOdyLrq5k4?=
 =?us-ascii?Q?uYh44iWUziTppYIbecKj01AwKdgw0miERVtaQaUhIVUCIXY5deAOsoJZdIpo?=
 =?us-ascii?Q?nnTomctPyYuKgluIMAYvUw6Wnhn62mo8CfnjkGkG0eogQAjau55XbTezAyW1?=
 =?us-ascii?Q?NQqzpSckcu8Lm2xjTBynkYLbOkviAn264jNhOjY49kzJ9rxSL3odrjNRMy+Q?=
 =?us-ascii?Q?5msziCpU4E0BzJcazLh4WU3TT30ohRB7iaGP3MdKdzjrTD6231ofdOQugtOT?=
 =?us-ascii?Q?8bohiAZ7DENtE6AeW2ULrJZAB2ZCfBHR78k5RdGFskMHmJo8yq4riFUu6LVU?=
 =?us-ascii?Q?4C3ImGeN9lQ9GOle24CgtIEa32lUBNZ+e0LIq5NOInMGB4kBJO8dNpsL8wRL?=
 =?us-ascii?Q?hdSpsMcnaB4jOMqXUexjovVXdg5fY3AtjKj36ztYPTmKz+nTw04Hxw2GIj+C?=
 =?us-ascii?Q?I9BZNZ/gMVSqg1fi6D8Aw5lXwSMdKICqlfCjH//Y5oAGR3oHTFMYAWijmQuH?=
 =?us-ascii?Q?xiVFslvdLUw+Rm+NBt/mYusllFtM824ZR+WVwBOSLv+EWWVc341dH2Pxv6SO?=
 =?us-ascii?Q?YtjdpM9UTTlsPfY6lsth4aqXEDvG9NfBZJnpUWvIuZyx4O5Wji4YNK6YXtRS?=
 =?us-ascii?Q?yjUhdt89v7QYIco8HkOfYD4sb1Iy2xfZImL6PpYbcQqujt+wxVCGwyV2iyRk?=
 =?us-ascii?Q?zZhegvxo2jiAwA3O72Mk936b83On4oKH6PdTTOfxSTlilovXKNREFN/3pk0o?=
 =?us-ascii?Q?1AbB2CLZsw1Ryn7qY4r6QvQkVIhZ4DMnp6ZibRiLKGGVpTcy6vb+VG+g6fkn?=
 =?us-ascii?Q?IFYByotkwSHyieTx57RX+RNZTeKfUW7kDE/iz0nHsISVjHTkcKFaDX4raaCg?=
 =?us-ascii?Q?aIDSA426/BweZAEZzv2VbWmeGkTe7RimfDN+ZhHh3QrWwN/5Ih36dijo5gH/?=
 =?us-ascii?Q?H5xuu1aknTfvPU1zFCwbdblmZd4RJduEac2oklt/yFvWo+k8UFKgcfK7CvVA?=
 =?us-ascii?Q?+4qBy6odncyryQ418/4JJda2D6EdF6tJlgi/aHxAlCJNhV58seFd1xA/iq54?=
 =?us-ascii?Q?ng9rYTSA4Lj4lxNc8ZWmLB1vlLsGZs+8AflzYd9ge3Z8f2YPZCbtMA/9aClt?=
 =?us-ascii?Q?lfIrhCNM7cqVlCVtwlOnYwZBUA87Ko040ppqTCab3IV/Dk5oWhZ9pfRS6u4b?=
 =?us-ascii?Q?oX2atKrNE8+HCfoqB2ddsF8vNOVCoGw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57be303-2d4b-4d18-47b8-08de67c7daae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:41:59.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqnqZKwZurnchhrSVSeMm0RhEDPMIZttN18GRYnR+8Cby2T+bcr9WqxPd9f4US8y7xYTRRWJMFZm6bEdN3uQ1yVdyiEbOp1W87JPXOvaZpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
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

On Fri, Feb 06, 2026 at 10:07:32AM +0000, Loftus, Ciara wrote:
> 
> 
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Friday 30 January 2026 11:42
> > To: dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; Burakov, Anatoly
> > <anatoly.burakov@intel.com>; Wu, Jingjing <jingjing.wu@intel.com>; Shetty,
> > Praveen <praveen.shetty@intel.com>
> > Subject: [PATCH v3 03/36] net/intel: create common post-Tx cleanup function
> > 
> > The code used in ice, iavf, idpf and i40e for doing cleanup of mbufs
> > after they had been transmitted was identical. Therefore deduplicate it
> > by moving to common and remove the driver-specific versions.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h             | 53 ++++++++++++++++++++
> >  drivers/net/intel/i40e/i40e_rxtx.c        | 49 ++----------------
> >  drivers/net/intel/iavf/iavf_rxtx.c        | 50 ++-----------------
> >  drivers/net/intel/ice/ice_rxtx.c          | 60 ++---------------------
> >  drivers/net/intel/idpf/idpf_common_rxtx.c | 46 ++---------------
> >  5 files changed, 71 insertions(+), 187 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index 8cf63e59ab..a89412c195 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -259,6 +259,59 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > ci_desc_done_fn desc_done, bool ctx
> >  	return txq->tx_rs_thresh;
> >  }
> > 
> > +/*
> > + * Common transmit descriptor cleanup function for Intel drivers.
> > + * Used by ice, i40e, iavf, and idpf drivers.
> > + *
> > + * Returns:
> > + *   0 on success
> > + *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
> > + */
> > +static __rte_always_inline int
> > +ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> > +{
> > +	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > +	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
> > +	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> > +	uint16_t nb_tx_desc = txq->nb_tx_desc;
> > +	uint16_t desc_to_clean_to;
> > +	uint16_t nb_tx_to_clean;
> > +
> > +	/* Determine the last descriptor needing to be cleaned */
> > +	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> > +	if (desc_to_clean_to >= nb_tx_desc)
> > +		desc_to_clean_to = (uint16_t)(desc_to_clean_to -
> > nb_tx_desc);
> > +
> > +	/* Check to make sure the last descriptor to clean is done */
> 
> This comment is similar to the next one. Maybe merge them?
> 
Ack

> > +	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> > +
> > +	/* Check if descriptor is done - all drivers use 0xF as done value in bits
> > 3:0 */
> > +	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(0xFUL)) !=
> > +			rte_cpu_to_le_64(0xFUL)) {
> > +		/* Descriptor not yet processed by hardware */
> > +		return -1;
> > +	}
> > +
> > +	/* Figure out how many descriptors will be cleaned */
> > +	if (last_desc_cleaned > desc_to_clean_to)
> > +		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned)
> > + desc_to_clean_to);
> > +	else
> > +		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
> > last_desc_cleaned);
> > +
> > +	/* The last descriptor to clean is done, so that means all the
> > +	 * descriptors from the last descriptor that was cleaned
> > +	 * up to the last descriptor with the RS bit set
> > +	 * are done. Only reset the threshold descriptor.
> > +	 */
> > +	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
> > +
> > +	/* Update the txq to reflect the last descriptor that was cleaned */
> > +	txq->last_desc_cleaned = desc_to_clean_to;
> > +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> > +
> > +	return 0;
> > +}
> > +
> >  static inline void
> >  ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
> >  {
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> > b/drivers/net/intel/i40e/i40e_rxtx.c
> > index 210fc0201e..2760e76e99 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -384,45 +384,6 @@ i40e_build_ctob(uint32_t td_cmd,
> >  			((uint64_t)td_tag  <<
> > I40E_TXD_QW1_L2TAG1_SHIFT));
> >  }
> > 
> > -static inline int
> > -i40e_xmit_cleanup(struct ci_tx_queue *txq)
> > -{
> > -	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > -	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
> > -	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> > -	uint16_t nb_tx_desc = txq->nb_tx_desc;
> > -	uint16_t desc_to_clean_to;
> > -	uint16_t nb_tx_to_clean;
> > -
> > -	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> > -	if (desc_to_clean_to >= nb_tx_desc)
> > -		desc_to_clean_to = (uint16_t)(desc_to_clean_to -
> > nb_tx_desc);
> > -
> > -	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> > -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> > -			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
> > -
> > 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE)) {
> > -		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
> > -			   "(port=%d queue=%d)", desc_to_clean_to,
> > -			   txq->port_id, txq->queue_id);
> 
> These logs are lost in each of the drivers. I'm not sure if they're terribly
> helpful though so I think it's fine that they're dropped.
> 
Yes, I don't think they are that helpful either. However, I was in
discussion with Anatoly about how we might look to do logging from the
common Intel code, so we may look to add them back in future if we see the
need.

/Bruce
