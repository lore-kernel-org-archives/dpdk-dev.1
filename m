Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E4CF258C
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 09:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2679B4029D;
	Wed, 19 Nov 2025 10:13:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 44D8F40265;
 Wed, 19 Nov 2025 10:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763543628; x=1795079628;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Z+Gmzq3GjM4535WWG6RcAA781CrnscbWqtHPzcmmEGs=;
 b=MrduSVllmpTaliuv1JtFVYR2zaX9erMzvUH0fdoNyi3ZWy369REl9OUL
 fWhIrkQHsDvgLnUOq9KWPNIwdOcuUkaPa9we3sxVi4ErNqea4GmhmH3gC
 BRRrDADUekSAr/qgeaTuAjvS+pVW8brxRgsOyVsgHfmsJS4KFVanrPWFu
 jxaOOz+nVBogrJjHFKOcDSUmxHIDiHgMCUu4bDxYtO0Ssca0aHROXb73J
 mbMlSAxvTkx06N1tz1tsyM7B3QjnKKk9uWplhL7YHoK4K9ADj9V/X3Lh+
 shF5Kd+6MX8+6ejSjQZr7zo0lBFlx9kmx7Q5SF17VhDRPMxulHp5KKcGx w==;
X-CSE-ConnectionGUID: E7rdm6agTeyK5QMtXzoNjg==
X-CSE-MsgGUID: vHKHDFjfSkyYZ3KtcDpUaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68185955"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="68185955"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 01:13:45 -0800
X-CSE-ConnectionGUID: Lqgj5ChjQnOKus5PQVde2Q==
X-CSE-MsgGUID: 8IHEBjcNQMuRwHw5mIvmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190657359"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 01:13:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 01:13:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 01:13:44 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 01:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l72zwY5kfNgRGFK2zIJ0s/j4qY3gXt8le5uhMwYVQ6KxhHD1ak5/cNDCGbx+k8jfB1lnDPqiHgDqJ66kE0dMKREFCagP6eVrv/aUqIsUm8T+AhSFwrER9wUC5MEg3LfIIZoEe7eKR2zEJWzggt5Zqd24cFLHMywVbCp2cX+ptFMohKtkwx32hIjWYGBOhxN8tvKv0/ddCzw4CbxecazHP7is1FVzC3tr6ikCqxN7DuftYPXZ4vY/1LHSHN2pn/4jiD+GJtKtgVCt3sh8CrdFASobU1E6pv0IMRz3kp7C9Nnzg8qcM5rsgLd0JITGHGnAVvRSaLj8nT/7Po9rUFpPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzZxrZy7ep7TtOldYZlQfbFvVUzOuSx91xQG9XF2Qew=;
 b=ex9xGmewLSOy5kZ3vslztTVHtqVNDqI4EwgAvQ5ieSz/B5eAv/+VLGTmJZnE5lsl7NYPYWDO9id23fdFwlRHGKvYPwKaUGo87bHjYI2R6uGB5L4qXwan6JCLu8Ec9gbOFgz4iD/tMNWM1OFUaX66lemOdNCiLv+j0qekPm3moc/b90g0eIMa7RVGZq1iOu+5firubG40u8r45OvEq611wmMNW6pMHFxXMauZN2wte+bihr4NW2qZjrsIOHVvPZs1aobpmnnEvP3kd0oSUPzTEx7HnpKUHLxIUzCmnrLWH28kzh4hIrUhUy7WdNvRjoXvkMGiMGpW1wq4IQwuqC+Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 09:13:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:13:41 +0000
Date: Wed, 19 Nov 2025 09:13:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>,
 <stable@dpdk.org>, <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 2/4] examples/vdpa: fix format overflow warning
Message-ID: <aR2KQKQhky7Dm-dh@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
 <20251115193749.101355-3-stephen@networkplumber.org>
 <5387340.ejJDZkT8p0@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5387340.ejJDZkT8p0@thomas>
X-ClientProxiedBy: DU7PR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4948a8-a14c-434f-d2cd-08de274bee8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRWj4TaKOWQ1UtBfjLCab21mT6dQMesKqQGoTeEzSiQ5qaTolkgLbkxcgxKD?=
 =?us-ascii?Q?ruo3iVagJEngitGUy5668D4GelzHe89SRYbHmq6RVGDDurCEvuhXq1akSpqB?=
 =?us-ascii?Q?L77Iafcl1fZ9RUkAKZxqk4mnHLcL0qZV34QiF5hwEraCR185hFcSz40Xet4/?=
 =?us-ascii?Q?xUIZCz1blOykn7jNfWxHHi9g+kayPSmcYXEN5Di11qeUjd93UFkV7wJaXsqS?=
 =?us-ascii?Q?is0V9aHKCfy8erWp4uJ8zsC1ktfMetLmBnn/Yehq4xsGgtz8pEn2ctWIITTu?=
 =?us-ascii?Q?/D5PSJj3yWjo69uJ4Y10s9zGKRIVHuzDJ0IH99epjvYdZZZH0L7JP1cl06MW?=
 =?us-ascii?Q?vBZlvJ8uYdsfquY49dvbBKNPqSQRbjdZ8D0JhsW/BqVaqJM+3zfpStZq62PW?=
 =?us-ascii?Q?Z/KC9rzNMpmT1gwqzN7Jap0KKeJfogT7IW/Mw1rGfDgdlSteweKjrNwlgjTu?=
 =?us-ascii?Q?H6xtO1tmfbZgWc7Ownv6y5Xc57dfctABW1IX8ISV3u4+61v/FucQC9ZcYkwH?=
 =?us-ascii?Q?kmPrBJLGLBeX31lQgEnbxmJQOq3BfAQb8OqBIBFYzXne2ChQvvJEFB0JGukb?=
 =?us-ascii?Q?NyCz+Kz/txSzcYMvRgOflUCW+aorQYq2Dr5RxUxYVjCTa5NUjadV87tnZEzR?=
 =?us-ascii?Q?JPyBbeCVgEsUZl6JtcMSv7MO4tio+v5sRyrEW/K5oth9NJOEWeXTbNoIx8Ue?=
 =?us-ascii?Q?qLmfwWRxjSdvAYVs7+mihXTNLkAYa8zbD3/gUSIgKygk0HGYGfWBKZPJ4W4f?=
 =?us-ascii?Q?iMMnL8Apb5SHbyhNeQM/8ClCsEs1VQEZripq7GFZXiM+myRn+xNE5bdLVOPV?=
 =?us-ascii?Q?neDI/PsO0EabcS+pv0NSOc/ZywcajmXN/ZcFZ5Z5I/KJTpFa4zDGjuUSICHH?=
 =?us-ascii?Q?/N7KzAcx8ob6j3gQdfqfiD90c6LFv4533bkA2QokjI9TWaOLWjtXWrJ11Y7D?=
 =?us-ascii?Q?FcvhLCxh5mk62Fiv7uoZmzDXttgHCmL4vRr+iP1b9hV2sWU7aMkAyE02daRA?=
 =?us-ascii?Q?V87OsQcsMGIULLXAWi9aNupo+MBzWFu8hq1eVVNsi6HxUHOMCZikWoFzdBjl?=
 =?us-ascii?Q?troF5IDRY4em61/P/91PzmyEQpHZ7XP9cH36yeYN0FtGwbdTSTxLBReNoFWL?=
 =?us-ascii?Q?wA4tlVPVskx+XmZZszH9z04Ux3/5WBVYzswxt5MHVbAXLgWPPPs33G/jmsWj?=
 =?us-ascii?Q?97AH9Xvgarwfp/Vhm29vyAdDi2UsVoPquT4HYt/H1/LfDaxUrrrV/WHkSo/z?=
 =?us-ascii?Q?dteuvenB1bPTTWgztYRL7q98WVjVLVtIU1H4lN299yReIlvZ8wIrX2m5ZROt?=
 =?us-ascii?Q?R1IS7hD2UzWMC/mnFoh8jH9v66iG4HriPZN0845Xx8NOu0d+LjrLa1VlCJzA?=
 =?us-ascii?Q?vk+Z5fNTFTeuV8ezz6Ug45j6negf3Rq4GFP20pKQC9LGEnkqeIVhvZMlB1jH?=
 =?us-ascii?Q?W3726CyJRCPcta+lWjrvxHpqHfk/joNW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhVolLvVaU6C5Oe2bIzBq5PEwMZpRtWfP/B4+aaHNtCD84L0G9iEFziNx9xl?=
 =?us-ascii?Q?8HvnctIAfOnFt7HNqEYFisV0aMqyTAE1snUEQ5jG9D7vM/54UYaiLIAGP6w3?=
 =?us-ascii?Q?JCFwThlxvrwdggP2fGCx9n8rHsCYBOcQh0DbvFHVFrwEOPeZXf7LeBiTIDTP?=
 =?us-ascii?Q?HMN6N/ioQtiCqxNawk2qjZrGT7p+YyHM7rltjrYqFeBEGJMHcTg2KgWjNtAp?=
 =?us-ascii?Q?P7dB4deKzPJHIPmHPiuIiMnFt2P8RNQDa1VkICeG2bR/UqFNL9Jd9gcJ8G6/?=
 =?us-ascii?Q?MhO0O6uTO4uO3ze04KrV/TzRtwnoP6HfKX/dMzw1+/Co28M10ZehEF80pR8b?=
 =?us-ascii?Q?6HH1FCSJlnjva2LyI6lGulEbpaQ/LaVnIc4TSa+YWLMQYkEMAszWEK+myCwL?=
 =?us-ascii?Q?qlojRahIdyAP3CtohbgRlw4n207y4pZNEou4+PkIvNbPrtTrZR/XVaWPfOIF?=
 =?us-ascii?Q?dTiEGFogU+JiLU4ShKcA+GeP1d5WGQGWuAFYW7myydP1o7On4e0Dp9xptDgL?=
 =?us-ascii?Q?QvbYLq2mWXliFTySihUojcjgS1F1I7/xMGyZgqcG4EcNu5/2zBQif3av1Se7?=
 =?us-ascii?Q?Efv5RQ28YEJkEeZvWv0zzqXZ6Ktkbxk9fa3laTERfRRIeNjRv1PrLcLmNaZd?=
 =?us-ascii?Q?wHjrrDa2xFOhb6ySsIQZa3Ykb+P4Ly4P2mB1TIHZp5g2WsnDpJRRkuhLj6bK?=
 =?us-ascii?Q?+svw6mJWZxksjtTW+VSmFRueEtFUL8l18i9/GBugglF9+JqiRv1L8AMUlKwA?=
 =?us-ascii?Q?jN6Wz1etgDLiDrAYkpLxvvkMBTrdk1GS2Z5+48C2/CCKkjgOoxcLwNVGkNMn?=
 =?us-ascii?Q?6miiZQeucFRSK3BQkLFwpxuwr9GTwzLW0GTrHQwhx3Q00uiVuSUI+/XjJLGA?=
 =?us-ascii?Q?ipg+7rFApwwbYiNYqu3VjtDlzJuWFhZn4vkIoCnAUtlK9bC9Lk3uv8P1MSG6?=
 =?us-ascii?Q?xOiEVslCjen9ARPU10qTeGPoy+h4oKQsuXBXhTjqaShCss622/5vxSv9E0oK?=
 =?us-ascii?Q?e6+g435drbQOE4303KCyWry5MVpHzD9wn97C1651pbu7C+i4tHAXj+87hYt8?=
 =?us-ascii?Q?fv1SlWN3Kir9WpDOuWrZZZk98BHGtC+b7prgn3pSFMaW2oxGLZx5Hl97aZHn?=
 =?us-ascii?Q?LQLAUcyyPqofBkVvYGdvq4PbPmYC+7J54Oo1JcgnemzwkP4OvAXHYsOtidq6?=
 =?us-ascii?Q?uETuwHAQ1KuarKuTJs9mNOPyoUdhBYLhHzvMOL+OQQhMbv7X6mFdcE0AKf1v?=
 =?us-ascii?Q?faObElEblx4rxt7XKFkMIbq8opB7q11c9zEApuoir21ctzZM746U8oNY0h0Z?=
 =?us-ascii?Q?eU7zDjT/PmuesZsIkC9rRz8lKFQq5217LTW1+mECvbMXmMUFi1S2TC4Bf11Y?=
 =?us-ascii?Q?xDcBuibIWlSSHW1dRnSNXOqMv1sv1lAuxcOGMJGJfQTDEswBhkMklxOWIMpX?=
 =?us-ascii?Q?66QToqaEPiE1fhN3xY+7zDab4NQ4OGWliif6xjhsn5dy+UDV3nXK+urICJl3?=
 =?us-ascii?Q?uglfJl/ipAFdNQ9HoyFwa4r1Pp1ALbl7Tny3PzsTO0+XNmLwZh1u6d/h2LDR?=
 =?us-ascii?Q?kawMUmDnG0aZ862OAdpYIf2aK8RXO2z5MwTmGvJ36Uo6X2UBN7Y+CPT1aODx?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4948a8-a14c-434f-d2cd-08de274bee8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:13:41.3410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rBDQQSgZlMBzAk5YIgRhOU+zXqQMbvyX4/+M49A6EZUDJmSrD1Uh5P04wNovRCltjfhmyjKM0gyQ2EqDH6sl4ohyXO84euT164NUOF/XX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
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

On Wed, Nov 19, 2025 at 05:31:56AM +0100, Thomas Monjalon wrote:
> 15/11/2025 20:36, Stephen Hemminger:
> > +#define stringify(x) (#x)
> > +#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))
> 
> Can you use RTE_STR?
> 
+1 I had same comment on v2.
