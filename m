Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC96C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA7642EB7;
	Fri,  4 Sep 2026 12:09:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 374EE42EB5
 for <dev@dpdk.org>; Fri,  4 Sep 2026 12:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788516568; x=1820052568;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=KpZu6Fsg3PEY0sZ58mVNjF8+3k5NWC3zEZa6kX1BWjE=;
 b=j1sVD0WAxAqXGKiUqea6xS5vJmIeI6aViZd6jf9W5f/+BSK90X7qaM6O
 NZIqzEysy9i03Trl+0XzSdNM5+zzaQUbrtrOgC6J40W0Ux+JgzBEFAZcz
 Vnux1a41cpoFQITxR5ks21acWpInO8PRwLb+CGX9Y2/HLdYKgLcm7ZDoo
 0/J4wBW8Tz13w0PDBqHhtkSva0lmSleb012q8Z+wkETlc9zlIR659fUsZ
 tVZcNECRmUL/p/SN3xGNrMGzUL/nwK/siWVkgJr4t1HB6/0lrUJj/3oyn
 NTke5v29vXnJIhsGYlx7NPZIBO0+HsGJBLfhw7h/gfj4biptx/tl7ucZC g==;
X-CSE-ConnectionGUID: olVvuHUpTUaKCTIO94b8Rw==
X-CSE-MsgGUID: BW2mA7vxReebHzpdWNe/dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88896347"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88896347"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:09:27 -0700
X-CSE-ConnectionGUID: EvJDbq1EQwuvvtwmQyoEhQ==
X-CSE-MsgGUID: hNoVjchJQuuwNUwqrFG7/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293508005"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:09:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:09:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 03:09:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 03:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiFpsGEXjoo7qltBdfyFb21btesQ3KNLhl13UfMBadkuabo0m5Sp3knB3dCNXPNgzMtAQ2vOGBjsk0YBji4zeMjb1IiHORY6pHlz0MAU4t/+V8PuogiXl9ACljxcYNab7Rle7Hkpaq5m6YgF+NGyXSrPKmDFRK9PTXHNLvi8Pv3iBk0Ogb5ylF9KB2yTMLvag1npXLAFWBAai3n1x7JN9a5EEjJcGvni6Bit7lTh1rjK2+scK3n/rPYZKsMebxaGUywQbXnp6L+jQPhgr8uVN3pX9K5wA3139C9UWP+5Ly4huuq9qd2k280fYHJsTZ9/m1a3HK74QzTjQ3Lf6i2P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/fA1VZ6iGZVFW7cQKucfmc/x1CTLYPQ5p6yakyhDM4=;
 b=rRbIcBYIaSZanFujk1FRn37ab/2N9m/d3WW7Ze9WHMVGuzs1NzfZkYRW4YisUY1llQqT/Vy71fvxb1hEvwSyrnR5Tp8wP/vTAxw/SGjxE3yUCamwr/nF0RP8rVwjNXXRAEdvgNH/oQaGpIdnJ6npu3O4wghnMjiE2028e5ExDElq/iv1B9A4Xv91npSovV4tJnfoIVXSzmxZChMhb6MtbV2RGdXfahxd5X0LjjF8jK9fpwLCrkREIqVAR8MyPKN2WCZBAeuj/hzO7heCq8MpheruCzzfdtUbuwALtMtrdQXdRqyTDVa5QAoJ87gr5C7ggpvztqA4x9o8mGC0C8+mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:09:15 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:09:15 +0000
Date: Fri, 4 Sep 2026 11:09:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/7] VLAN and QinQ fixes for iavf
Message-ID: <apqYx1q55AoKYUN2@bricha3-mobl1.ger.corp.intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903143827.327131-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4322a7cf-a786-4e0d-a353-08df0a6c9335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8BCYFREysESzFsrNxKjvwXybsevn/iNMmOQRPnsnGDhfFd+ki6IOkA962snJ4JkOeRO0oaMyc5KWMxMEvlQvNEluULACKm/7nNbcV5mAKITDT4gLM+PHADcg+ntufWEZRPPkqvHcdGMa+R3Im7f8dSPNh003zOdrod3IWkMExNs1z8rHq1QazFFdhHor1wsljBECzE1o7UKU9P3htYvMEBZuJZuGNFI5ROIYqemOXVens/kCQY8rjMQ5VUD/bollcWO2Uh1NH7f6ur8hyCdEJzp5ehjXXp7Kg33gmkgR5wnCM1wrwZRXrMMN5ONl0cOcM1aUXo78mJcSE1qF3jPQifuRNmMskc4I37p3nrTYVkxp9bYMQFp3ItaqBSMLKEqSAoreRS2Ir686C+UkR5mnI3ccbA6HqS8j7NX/EXrtbt4wlum898VyFCTpYQGELjqBVj/bcEunigqWZzTtj9+9ODsNMdw8SoEB6WUfimdBY2lVG4NeNv4eyKbZ+BR0JvFn8KlmSYn5X6nvFtViYWunpnCvvqwX+SFtc+amm5haVzjfO5+Jg/OeLEZG2intuvfza5WdzAxJeg1Ij1to1zBXgZz7HpynNZYz7l/zbT4laOoRbpQo+PEPnmFf0qS3D1Yzqt5+ehKVkux2bzbvq136NIXKI1lQwProLs35KJA5WMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oN64COYBWZ19mf2oy4PV5cQvg33zzVfLj98cuwOhU+MB7YYFE2ocJ0ukSsJ?=
 =?us-ascii?Q?2yCmTukBcNGUgo2GqAJrWTWrHaMocLDuZftEQqr+sHSpV+w8cnu1zCM/7uod?=
 =?us-ascii?Q?SpQO8weqV9Gdw76GdGuQQ/xYDQu2XT5gxgcS06oyACUejKQ5HDZlxnrHmkjg?=
 =?us-ascii?Q?90vbqKbjRp9pUu6+Dr04Cv6nUt+Kr96/LZdcK4JQ5jgddA+iWgQ4GPeDWlDw?=
 =?us-ascii?Q?SvHKR7nmznIHe0ivn9dVyZSK43JT+OGvI5xfQMO7neA1+IJ8A0b7a5gadhdv?=
 =?us-ascii?Q?gfhnFGTqOhND9sAjvTUt4knC4noaYcOs2KtNAtpnze0BFGm4wEEBzxUhisko?=
 =?us-ascii?Q?LQAfOBwOmKAFygNYEDZTOZyo8M0X+6eSGBeozpeFKoyZeTQIplyn9QnHBcxC?=
 =?us-ascii?Q?hVyGPpFO8znaLzfVT7MoOLU2nWOqnQPfT3vE/MJ5ndaOeDOWUnLYPrHrOKOl?=
 =?us-ascii?Q?PgawEalVwpDLdwPhAbotBoy4ALwBBcm4drA2L49ozI1M9d3H8OUqagWfda4F?=
 =?us-ascii?Q?prfGc9WpORBozcA72KJrj8sdNkvXto/o9EoyvXS0azD9JhPCRiETV/udMZau?=
 =?us-ascii?Q?/7Y4hQOEl7S9sxZ+GVxt4JMPhIltWDzbAEGgSU12VCK7WQFlB+gcqEdjbx6P?=
 =?us-ascii?Q?DMJIfXA70QA4p42G42x4d1PDG0bZ+K0p4dfZ1ZHfWdz8z5FG7TTcEgib97vQ?=
 =?us-ascii?Q?gNeeV21R1ZD0bBR0a08CsRsetRzE6Oz1szMl4sL5skDGkBCt8OtQbS1eBLYK?=
 =?us-ascii?Q?c40si3SPfr78sPVleSgSNvq8z7fAOJiHQdF08FvKa4QPlHHrg1QBnSsCnbTo?=
 =?us-ascii?Q?mIpLqxJR0jPwscQIODDbg7WKD4y8zk/Y0mSuuC4KwsiA1EhEOfAZ77S/ZzGV?=
 =?us-ascii?Q?szR2uhFIsXmiZvDwKKqzufJPNm2+r2KLAEjW8COqcni/EW3kin6PNmGovCUF?=
 =?us-ascii?Q?N2lfpIkiM6WL3Nf7xtDyNjSiiSPc8d2eBsfXjH4OxifWtfN0Znp3abIjlvVH?=
 =?us-ascii?Q?QdaTxuLJLyzC841vk86zu3UmZK88NLY51I5bohGNCnIgjWdxVxndmOBxPVSq?=
 =?us-ascii?Q?hBc7sXXMgW6pjpnZHVV8HXneF9xmG2BIu3CHI98r5bIMdr9HYs/QDZaie4b+?=
 =?us-ascii?Q?ezhjAFaY3scjfUUA4F7VWSfVTwUPJmP5j8zaazDEP3CVGrztgxKfpeYZHIbR?=
 =?us-ascii?Q?OLkvJRzwQUWqXSTfiPPSCnAUaWEz8gFsdFyLJmQNMWGLyOs+Ij5n3ETOkG2o?=
 =?us-ascii?Q?hZKSE4goXlKxhKxLO8OPiiskPiNNXmDiugg+zW5lrhaDrULaZWGDgYGslvVv?=
 =?us-ascii?Q?zle91kBViCvB+p8Zbukk9aUPYSKQ1b5PMMc1HcJtvZKSK1bvs4rTeSDT9rmE?=
 =?us-ascii?Q?pkfjxGJpGDDgk1n73fVFQsiToQnmYMzsWaMsyGABrKqtXXh0jLEbEzaKN/Ol?=
 =?us-ascii?Q?6nYmIariJSYAXSwbF1nZKOlwED8MphF96i65JaGD5dbFtF0ONaGMsEs//Ecc?=
 =?us-ascii?Q?j6/iy2P1x4dC0eiNp5V9z0SiS+CPm7HMmDeGHa/vJ1B6f4/bdKaX2905dle7?=
 =?us-ascii?Q?3R1+1CtKR/t6UokSav2Hy7Zp+bbpdGnG+hZowWcVPpYPBVhG4BXssINEoY+x?=
 =?us-ascii?Q?thFR93jDVNRU/GBNOzD5cVxdGwpf2q2jbKJPUcS/0zLVGlltxGCaT5el4jVe?=
 =?us-ascii?Q?hfJ5rj69UHatHqWSGJNKhMJLvf/XXmKUbb0Le5VVZrbAcGsLv7Y7Z0z2JW2F?=
 =?us-ascii?Q?kZOpgxJDir+qiDidDHY02hH8n8JVApQ=3D?=
X-Exchange-RoutingPolicyChecked: tkUOfOskfZUzpLya1pv04Dzcs6zNhJ9XPi7iFWMrZx4jlWE8UCdKpSaSHFlKrrDzP6EpW5ABri1sZE5sa9u98wL/1G7hBsSqgYA1sZnMyaOBiJ+bjX9P5VYkiBiwMSXTnsxR9mT6W6UVaDALU3rzxKBk9dQ5fjVmK0WgxibkguJUAkbgGeyzGKzvQKhmPbW6FFJ0jDUkcwppVrlJr5hMQILf4z5adOprncE+FdhEM9LL8cDpcRLoTOGRFN4cNHp9zqPB84j2yKwLhaLCW9U7dEtN0jL7UzYHN9jxzTa6QHvhzLs5F6nW4t3ESncLqZ0Ot4Hca+DHfukLVATDDqpHEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4322a7cf-a786-4e0d-a353-08df0a6c9335
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:09:15.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NHYuESkpDjGmjMGE0w77Ttd3EcY2EAMouTdWECfQiQr0BmuUGvPOJqRfRI+q/0TxL7eCmH8q9CYtxyJE5vlTwzdzgUcwWPdU50uldFR7mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
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

On Thu, Sep 03, 2026 at 03:37:22PM +0100, Bruce Richardson wrote:
> This patchset contains a number of small fixes for iavf VLAN
> tag handling. Most issues were discovered by AI code review
> rather than being found in testing.
> 
> v2: 
> * add error checking to patch 3
> 
> Bruce Richardson (7):
>   net/iavf: disable broken QinQ strip on Rx
>   net/iavf: fix VLAN tag placement logic
>   net/iavf: fix VLAN outer TPID setting on Tx
>   net/intel: fix unclear enum names
>   net/intel: fix VLAN and QinQ tag position logic
>   net/iavf: fix missing outer QinQ tag for tunnelled packets
>   net/iavf: remove undocumented conditional macros
> 
Series applied to dpdk-next-net-intel

/Bruce
