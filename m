Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87ECAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8219402A0;
	Wed,  8 Oct 2025 10:38:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D05B640297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 10:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759912706; x=1791448706;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rLdYDYlyxCDcJuMJwbEVG11eAbF/obR4NIafjdcl4ik=;
 b=K5rd2aZUkRzesgDh869ikXArf6g8GlSmG96uIItDTyY0ACEtWuAXg+UN
 MBvebYSIXtCRPDnMVQcr/6vYkBUqrB8NAnqAaE92DC76Q9rGMOt2nTf2Z
 IoamVuot19onduHBQNBeZTdteGCgKaWD8X4CTtEkIuBD5gaSYqvwqSqVz
 2fuGP/qB5i/SFk1sXtyT+EM0TlK6UFg34e4DvqqoHV7YWXE6OM6MdcPNe
 BG5CTZaMcsRdXfWfPIkXleuGSAqbT8NKkiBSunzzMOEn5L37H0gMB6ubs
 sZSFDgkeR31MCQH/Yp82TKDt3m1GcfXUUbMFs9QW57wrDooL43xlhVMBJ w==;
X-CSE-ConnectionGUID: R2s+bmwdTTGSPeGXmA4iQQ==
X-CSE-MsgGUID: W0bgCUc0RuupMdTsbZXufQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73527051"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="73527051"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:38:25 -0700
X-CSE-ConnectionGUID: qUlO6u4nTYy/z9e/6Tcrsw==
X-CSE-MsgGUID: GTRVFmPkRZ+SOBfTn0hnMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="179631946"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:38:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:38:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 01:38:24 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRGo1Dt4JSFgMZhaZyHTRXHTweIuqCzcgOP6jse+kO/hPf8sjdzlf4azKYYKc6UzwR71/jLP+d/N6/OkooRDB8Tbpti2Nh8GL/ltVji1thb5cUKGs5Ce2qMSCEC65OdfIKHP8X4FbrnDwiJWPGQhxbniELHa0zLea54MHJEgGSrmlDI9m72sn1TxajDJQrzvzasZdMMImTAeOHcpkv7Wzjec/PZX5hdUZ5azaLR9wx3Jds/9BKy2U1zYEh98RvEaHpylB/NwsdyQ+ARper8CUxz+X6t3d/DCA7c0O/n+9IEbLzZieW/VcduG/Q4+4+dwnJnf4kpGbdV/q2tSshQ7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfWWK/xpCrt0PNZnxzk46raUxcaUTZRMIW+G+Mt1k9U=;
 b=N9towxbEio1ZabuUqCsp6GL7eyKSCr5osmFFv0SRwGhZdI8hPKmBMqFe4zElKspn90He+DpNUq+ayBdqKWT0Pfl0DR9sT0+1QR0+BGut0dTn0N+pTzLNd8IKFr8y992ZK+DEqFoLBmqdDYoN/jTqKOiDYi+IM/NaTcytXtWSHHdHFk8pv9vCh3gaWCyU5s6PzFVKjcd5oJBUlGkJnkLVqg9u+Bfwi5SX6+laIUONNrR140VFbvtWpbUyBn/l5T/5g/vanJRPqlw88zBdNYQSRm/w72bTOXEmJfHmaPwacu8gBpmy8QvohZBHC5mfejW4N37eVgtC4wRS2zkxCY1niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7081.namprd11.prod.outlook.com (2603:10b6:930:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:38:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:38:16 +0000
Date: Wed, 8 Oct 2025 09:38:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: Re: [V2] net/intel/e1000: reduce the optimization level for gcc > 11
Message-ID: <aOYi82c71qlZiazJ@bricha3-mobl1.ger.corp.intel.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <20251006130257.391200-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006130257.391200-1-thierry.herbelot@6wind.com>
X-ClientProxiedBy: DUZP191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 728f292a-46f0-486b-eaad-08de06460665
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twj51BttMIWXdRd0e60MFeyOEq6gWV2y3kBUlAK8B++PWf1YgZrGX9I2mX++?=
 =?us-ascii?Q?ITFOSmoHF64gJ2563qZCzOlHzjAYP6WpFGStmHo2MFVorvA/sy6LC+UpzisW?=
 =?us-ascii?Q?O5Lgl1Bax/BioCedsW9HsWik47Q2QLpUTx9/Q3JauK9Q7Mr0iRWe9LO3GTBf?=
 =?us-ascii?Q?2sUKul3yQLAFzkgkMwFhySGBENaXOzpoAd8tWAMzu7ctVqhPNcTavPFBfOkX?=
 =?us-ascii?Q?lMpPBAoX8z2Tvch9MUXXGCDtgZRXddlx48jNfvAG54LUGl+/Jn1CFktGQyzp?=
 =?us-ascii?Q?kKeHCOig3Ryrm5DM3Sd4XNYhwwfABIgaaCMUpEdFJfpzKtYW1Ob3/faAIjDt?=
 =?us-ascii?Q?GjBp8kq3/DxcVLu7LiDDto0w+IvQQvCyIYTA5mhhY3+yCjarXJQreIxqLvfY?=
 =?us-ascii?Q?JAAhVqDmNBUIcO9wIilYDVfevP+tPXE/4G5eg8iB4ocqQ9qYCD8fTgPttPOu?=
 =?us-ascii?Q?4sYFjs+uE7aaulwK2wLeNQAFTxl0LGNdo7aStsnvMG0QU3xaTOJi9VmjoDxG?=
 =?us-ascii?Q?IpI6o2P5gM80pmcyJy9qU98+4faPonDVK9FYMl8PR1cS9wn4lCQpFe6WHO0c?=
 =?us-ascii?Q?foMdbGL/lrBLE2Pd3r5NMkvCj6b56K9Lz5y3mBcem93JStOxGcjV+1pUKoFa?=
 =?us-ascii?Q?HpVwCxuJCrHJl3n/gYpykQtjZilnN+/gP9MPie4vKmirmWxUmUxO0eXPfDfF?=
 =?us-ascii?Q?JnxGlt8QEs435iFnFmDPgr/0+Os36N/ZGHrxFKPai8Jnwd4gCwC262Xcrke3?=
 =?us-ascii?Q?MT+4WXZMJaFbwiHz8YFapRqxYKNdZH0miT5EL5NBBnmvzwWi0nn1PPq71+nl?=
 =?us-ascii?Q?l9OOpMxteV+wKPIJ3n4JNSArYVWDS2JpYSp7kA8op115QGgiaHHqBC2oaMgv?=
 =?us-ascii?Q?jTpjrWpPUqgpwNlDoksY4mP3gpiOJQSbmeW72wRSYyZFyAeY2CkhiYw6ZmHx?=
 =?us-ascii?Q?jPqaC/nS6BVM3n1ejqSKDHEaloqudlCh6bzDgYPWPLoAzDmwKzxWSrrDu9GJ?=
 =?us-ascii?Q?95EbBOm8c3sMgqp89bXR8rWTL5cC8fenXg7UFrTzH7xmF1ntZVLqZIB0imCQ?=
 =?us-ascii?Q?xXe1jDzun+o7m13Vm06Uu+l3woDWMR3+AAW9zrrSKOWOyfTGtfYiMqIXzjhN?=
 =?us-ascii?Q?wx7UpjWwAd0W/CivkVoWv3gimgxNss2BS4rZNNzu1PUbm0+6/I/z9wBv/ih4?=
 =?us-ascii?Q?dsxGtgYqpbu1swZX0onPcEvMjz2Y8uIdgbAuukh0xefkVlnwZIlpkba/QqLc?=
 =?us-ascii?Q?vmfZUwfvoZMYde3u4gmc54d+NBU/VuAO856QHKacMdoPmDrD3qzaRqqwDhXf?=
 =?us-ascii?Q?5xpco9Gv6uDs4m+cK7ipJpHYPKDE4L1lKL02Ipwzt164UCmipTeAABmhX6XB?=
 =?us-ascii?Q?W/+Hgha7ZFvjd5rvZUMWlwCMH6VrV13FfV25w5tLmsRQWxPY6NZXsDGWdPL0?=
 =?us-ascii?Q?VbIi/gRoxTGUvdHUP/5tMbjuPKJtXCW/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pe4FfZuJG6TsPJvZve0B+enNVZ2qQn9w46CMoovTfycOT0m89KjVdtK2og47?=
 =?us-ascii?Q?LZ9sD/q0p2z+QP+GylfoyxsIN/WGvkH1mtSm/s/0E7fmVLpaln6X0fYK7OZA?=
 =?us-ascii?Q?a7CS/p05eucCuBAvKBDe4uZ7+3+icnSF3uHj6m9nHCYQJL/RzBb9TYxj+t/L?=
 =?us-ascii?Q?7uGdnGEl1E48PIUnqpnWICMRAbceG6gvvn8JM17HTHTwmyTS8BxqF4q2XT+m?=
 =?us-ascii?Q?piZY9suoAWJc/8ujDOKkFb1TocgBvbWdRMOSJT2Zbh4rtowWlAymUCZLDuF4?=
 =?us-ascii?Q?/8kL0ZtDhaah03/VjiuQty+HvW/ejKJU7aHfsDtH1IxvrLCW2FqHXVclksoc?=
 =?us-ascii?Q?t+/zu2IYtZvynOJ1lAEGphiVpButlVjjSOoJGaPmhKVApFy5e6mPTlprFEYE?=
 =?us-ascii?Q?kEXHEjIfHtN76SiYejTsIcr3DlRB4Y3tFnAS/bPxJH7pbK6VO4LbZ8Siwtc3?=
 =?us-ascii?Q?z1VXGoViES+5BysNWx63xMTYYTmTMRRh/YWjpYj0lOFm8f0hp0wCmsbywCPd?=
 =?us-ascii?Q?FugPKhrnck7FBszd9lNdXQ1kP2CvVw8ys4aYY3Yj4TFkmhwVOL97vmBivK3J?=
 =?us-ascii?Q?H3Wn4vLgPeakfWqqez2+oFPaIsMmReMUlXizW7/f8kzfYj1ocI4wy4ncfwU7?=
 =?us-ascii?Q?Lju93VPdBAvXoRMsp8hMUnp3/6yce3Y7zN5mIew3VNigxhHy64Co19I3GiSF?=
 =?us-ascii?Q?W2a4Z0M0sULzTVUQT1PcSRkxo2bHT9F7jmovYL0dh6uC8ujZQklK2w7cI1Y0?=
 =?us-ascii?Q?IeiV5CjgUW2scZzZ0Rj3C7etsvPqt2JzdrJu9Kcj74NfXqOwOoom5eH0/QYp?=
 =?us-ascii?Q?aP5f3Km9zlpKTCWq7xb8YBI3f0ntCJhzOoSey+QoWuT1EVzEUxiPfDJHqlKW?=
 =?us-ascii?Q?JemjrzQKLn8Ujg74+MKOhfcqg8mevcI9lLwTyZN8oG3o4comOKen8OGexIo3?=
 =?us-ascii?Q?wfhhyumCCQyZCrDHinPu1qlZduGcXRHQkFmNIX8wCoJqfbsuN0L97K9OzPcf?=
 =?us-ascii?Q?xxvoIfy0p11dK+VIXsjj3tATnj8s0JBHYSEapH0PistYkf4pTKUhoR19WEdG?=
 =?us-ascii?Q?3m628nm3kdnGQzfafK9B7r34ZzUrU43jN/own54TZijU3/36wETrWrGeLKTm?=
 =?us-ascii?Q?CiWGgWgE8mXI0g2SFgjDTxSr17Ps9pjese/QjfWRk5gUi0FHV1uTINBfO/H8?=
 =?us-ascii?Q?wzVq4u+h9f05AcPB0C6vaPSFmH7IPY+L8scXZg7AtzlhmKpZDo79JGdtikq3?=
 =?us-ascii?Q?rhSe6voiZrfNg5Tz9BeJRvqRQ4Z7rc/Jjw+ZvsHQx6MQ58k59oVXSPZaRCs2?=
 =?us-ascii?Q?vMkPJLSsFr3AZPxMxsxzGy+svpSG9Wa/uByKd3A1w/7NY79RtKA/IF4HFFii?=
 =?us-ascii?Q?jU6Bpxz01W8QLM0olzWlpXZ4GTixnbEj2UHat+gudlbohRfqOyf5LNREAju+?=
 =?us-ascii?Q?4a8H4k5YtHFB6uNCfH+c7Y38tJWz65XHHWJR+g3dYtrrfvsz+mdgi7TZyz1s?=
 =?us-ascii?Q?sJSJifvou+zIRsTIToqNWpKZhP7L/sFQDEwfwVsPqD1ZzrJJnNXG3kyvyeaP?=
 =?us-ascii?Q?JaHL3AQFVyQebyasyjmpT8Modi5wTZQ0xDmliiFcoGCv1zuNStN21sx3qeZw?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f292a-46f0-486b-eaad-08de06460665
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:38:16.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOreXHUP0oI92b8xgknk4zN1VCRYTShMUUyNIKOcjgcfCpZG5753m3L0pYxi+VBZ1r7063DuvsRy5Kgm5TI56B9hsAszhP7uHL3JgtTEKNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7081
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

On Mon, Oct 06, 2025 at 03:02:57PM +0200, Thierry Herbelot wrote:
> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> compiled with -O3 (default level for all DPDK code). There is a crash
> when starting testpmd:
> 
> > (gdb) bt
> > #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
> > #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
> > #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
> > #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
> > #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
> >     at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
> > #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
> > #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
> > #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
> > #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
> >     dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
> > #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
> >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
> > #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
> >     dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
> > #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
> > #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
> > #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
> > #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
> >     at ../sources/lib/eal/linux/eal.c:1253
> 
> The crash is linked to the use of gcc-13: under Ubuntu-24.04 testpmd
> compiled with gcc-11 from the same DPDK tree works as expected.
> 
> The perfect solution would be for someone to investigate why the
> PMD crashes. However, this depends on Maintainer availability.
> 
> A less-perfect solution is to reduce the optimization level
> (like another proposal for net/qede: see Link).
> 
Thanks for reporting the issue. I'd like to spend a little time trying to
really root cause the issue before applying this workaround patch. Can you
provide a bit more info about the setup you used when you hit this issue. I
expect a lot of use of e1000 driver is in virtualized setups, but can you
confirm if that was the case here, or were you using real hardware?

If we do have to apply this workaround fix of reducing optimization level,
I see you reduce optimization for both the base code and the DPDK-specific
driver code. Is it necessary to reduce optimization on both, or can we get
away with just reducing it on the DPDK part alone?

Thanks,
/Bruce
