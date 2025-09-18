Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC65CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C8E402C5;
	Thu, 18 Sep 2025 11:09:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B3E7F40288;
 Thu, 18 Sep 2025 11:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758186566; x=1789722566;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AQfvCw7YNRyUNwdThoDGj2L0RG/kbrSWZ1E/pkMblNA=;
 b=d7ufmnc+xQPXjyjt25DZpQxD8FkopZr9F1tK0Im1Lpbfvff+QDeE7zvI
 8CDfWsfOaT0Zq290Z5VWAzB0OVytX0cMfA3C46T6CLyKO6M0rTton4bSy
 tFXeTGD15FZIC5sqTCOgsXmbqMgEirUzH+0veLA6EGiDxoo8+r7C7zUTn
 k+8eLgk9A2Z5obQ6A4bIUNZf70lmBl8sPshGIHx2R/n3uSq2PK3F2QKkB
 Wh5mGvm78iCqmf1MVo37uVDJMiq2mWfgfqLmDIuxQquOQvMmaJbjE8w5Y
 8XGr9yaDablCcojszZFJWnBThs1g/s6Hw1m05dnViHbwa0bAys2u82mN5 g==;
X-CSE-ConnectionGUID: O8SBwis5QC27QT5Hh9ZIhg==
X-CSE-MsgGUID: bTDHWt5HQm2n/qe0KOM8/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60398086"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="60398086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 02:09:25 -0700
X-CSE-ConnectionGUID: MyGB0yutR8a5qCyTEreRQw==
X-CSE-MsgGUID: YCtDANEdQ4ae8p/n5pgY+w==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 02:09:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:09:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:09:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:09:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXOvxEhXbfIPzumeqAhnN01XvY558agiA/aseTtWaiYVTpCEc56vsnaNsdGckAKnzvW5LJ79E38n50B5qd47CX+eGEjnPWOlzxjYFGXI+NTm48odytv/Xlo3R1VBfrXSwfYNO6D2xntqUhtDYd4Fh9mcncLZNHliRK6ctsx0ZLrS0Px0/wgy7ZmbPycBYY7cDJqT4Y7J2dSkeTfX4/Mu2aKjW5qhMeeyhUSsYjQzwScIrc6iJ3IEeZWt0lSTxJK+uw1eUANidgrqrzfTUsmFrdWl0MPHBPFUYdDuDGMw3d+uBcQoAdsJFAI5xMRdyoSyhsLxPA1RY3KWMHJcako7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFmcWccsfmVMrf80YVAjmIY62VXSrCoaVnLHLHwoeAU=;
 b=bfFmTwZe2PXawDco9mnQ+5fkF0s5pASotFS6mR6lzM/bIpokOw7bRJOqkziYRO4MtqkP/MWfAu9viiD2q85jO9+R8xzespSNXMPShOAC/C4M8WDVSD8f32EBD+1M14DAyMDs4EcSokI5J1CD1pA9DGLWm1eNdbXwqXLPNPL7+ydxGbodtB29j8cEJUJaIhrHi5E5tRSexVwa3f7DYbmLcriPibQzLfuSZ0LmhOgUkhmbCCu5xuT0PM/eElLqeETOmXtXlXL6NCzVSFYakkinkDbU8l4YaN9HMWLvlEUNRDqJc1LYJpQaj35mmx/UTacCtMQo0b6VDmzoiK4cRlGBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 09:09:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 09:09:19 +0000
Date: Thu, 18 Sep 2025 10:09:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@oss.nxp.com>, Shai Brandes <shaibran@amazon.com>, "Evgeny
 Schemeilin" <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, "Amit
 Bernstein" <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 "Gaetan Rivet" <grive@u256.net>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao"
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Wenbo Cao
 <caowenbo@mucse.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 <dev@dpdk.org>, <techboard@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ivan Malov <ivan.malov@arknetworks.am>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
Message-ID: <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 50edce4f-fe53-4caa-6cc2-08ddf6930d18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wHOWbs9Rnrh83Gw1zrLvTRLJ41lx4P7oRcWiy5cvIDuQQy6eM7QMSmBoQY?=
 =?iso-8859-1?Q?2QsNggQOIi3dlgXgK1VHr3wE45FBLMWTnT1dzawawFX2zGbFgkzLGQCbai?=
 =?iso-8859-1?Q?IHF1yJtwUKtnzdQL6ZvMYIkeTF8vGR4XrfzCMasCG6HkIaiukOMiztfdYu?=
 =?iso-8859-1?Q?W3/Tp0uIYMhKvAeyGnptHrX5qICx3QWDTYxSkxm7y3qhicQGOWh6wKyJbT?=
 =?iso-8859-1?Q?2ttWRX2tRorUAZoWninl+oh1w4JFxl6SpJFd7aQqnYB6DMlc77ST7vDR2Q?=
 =?iso-8859-1?Q?dP7h3ObtKj5trkOHts7G8X9EbDUVhA5otJmNaYhCBJ4FF1OcNIzdDnm1/5?=
 =?iso-8859-1?Q?zJYNqfepE+BCiskRu4cguGoVZHAwUngNEwabBdMYz33YfnKwHlS7jfiU54?=
 =?iso-8859-1?Q?iH/EQ79/eIuOonVo/BjLM3pNBUE8H2C2qVUhRru4MzszBMYa/yihX54goA?=
 =?iso-8859-1?Q?YybXF1d5YKpoytJmy1Ve+XSZx123BCns8vdTP6weypHXq6BESXcbrJukcE?=
 =?iso-8859-1?Q?tREdw8kRIMe2nkNIm9YDwykbpYxXojmefN0BvluWyRiSyrjB9HcT9Si82/?=
 =?iso-8859-1?Q?HFIydV6Xl4wSHvB/WpSTG6a1ogQFS/R2YFcCoV3Xln+smoGsSlKbNEK69p?=
 =?iso-8859-1?Q?KufoxSWGp2ZKCsfy1/ewSni3XGRPOJHoDc26TysPc97NsXZZe6NVxzwv8l?=
 =?iso-8859-1?Q?Sl/jl0isx6RdK4VBJYDawkJMUPIDfKzGJsg7rlGaSaENB90kQ5NSBpA6VC?=
 =?iso-8859-1?Q?A83UG8zCoeUMLD0DgxZcmTXtPl4MMfc+DmHW5v6qIgZ7b523VLscN/stlH?=
 =?iso-8859-1?Q?EHtSpyPq3xNHzb36wpHLnhmP9mabuyfKlc42DutxSVHdHSnTAy7iuFq+hm?=
 =?iso-8859-1?Q?L4hoTy6/YlQT1Eltf1XJyoFF5+3sDWzhPS9xZ8Nm9h9BpVrqqROEpdPJ10?=
 =?iso-8859-1?Q?p5ln6gIjx7/l/ER6tGMOb+BJiVCRVnbgG5ucT4X39ar3Rv4AaSJItRnapi?=
 =?iso-8859-1?Q?PCrhIZwPIjgdyQP/qQiCCIuQO7PSy9tlWnBoyQMTckxqWktWXLOyMiMRAR?=
 =?iso-8859-1?Q?vJ0PYSSAfdnqRpwIg/g1nvMQS4M6eOVYTZOeuQz4/9QlwUdhs+MryyoJNJ?=
 =?iso-8859-1?Q?f4lM5mKyahLfBpM8Z2Zpl6FWvVbdAWJghOiuSiyP2B9H7i08Pz/RuhSdm4?=
 =?iso-8859-1?Q?4qp6m2AB+920C6DwHklGMwRW0UBfZBGypyoZMh+n7byhcXtpBEs646bLYn?=
 =?iso-8859-1?Q?te12EQlKUB3poys4DaivULAAmQF9XrtiyfJtNpb8+1vRmz+EI9yVOspTO/?=
 =?iso-8859-1?Q?ri3TNrVPG5w3O16eMqtyM1pnbGc8PEhQ/efsVvUSPjyluUVUpojIQXyGFR?=
 =?iso-8859-1?Q?ll9Q5ryzor226ev4ofGlA+u8LgQRJDSFtozI5wpm6+/l2AXBhArY2Lbthf?=
 =?iso-8859-1?Q?KeQwrPY6d92NzDPA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UccG8X0YmjP/Yk14XhAV2BvY+Fvs12r7RRlwp8ftSWEKGSK0M50rreg8K+?=
 =?iso-8859-1?Q?UP+f9cGmLNzH1ZRMk4L429Wvkk4nvQN7PJmVsS+JHYGuxd1NgYlqXSBPoK?=
 =?iso-8859-1?Q?ijX5t8FdtmpyeX+Q1Mp+RVvpufniSUTG6T3hn9ZEHB6Kt0qUisjJ+c5xx8?=
 =?iso-8859-1?Q?vdjelkZIOthR3iG7wZp8JSqcqU9wqEm9T/0IOeDloRQjWx72VjB6Q2kFz3?=
 =?iso-8859-1?Q?EwNl222VPAf+ombn0yUKISPFKtWA8nRh241S/PPYVTBlwUSR82Xn2U4/Ww?=
 =?iso-8859-1?Q?dAlD/mecIBNScNknEUZL2n0ysIxFKbtYvEDw6yn3awj81fSr6J2QsrBxHo?=
 =?iso-8859-1?Q?+/7zKw3nDz0dhZ2RtK9o6jvatg+X99ZR8WDa62f921nLtJRlTIZB5gqT+S?=
 =?iso-8859-1?Q?pW/YaOl+BViAfoQabO+TDhoZRem9ic+XZfycCrs68ygPLqs9kzpoHx7trU?=
 =?iso-8859-1?Q?LJ3WK66TnKOQzSdXpkr2OQrzPFSHrW5xmK7qfgXi3pIAEAjE334Fz8mOYP?=
 =?iso-8859-1?Q?aEaUBD5cLy4c9wIDPD68Hv5YLnsWNoQF8/qXfrijJy5ZdnoMTXprEfX+L2?=
 =?iso-8859-1?Q?BehomWWmLLRLjyiOvFepM7ZOQXVcyXe+AiSA2Q8B7n89qHZgLXwcjNNDYS?=
 =?iso-8859-1?Q?f6HgbJVa0cQ6jvm2Y22vc6AgYAy/Shn49dYPErQh+0PgJDuMLRgc1REMmD?=
 =?iso-8859-1?Q?sm0wuu/Af1Ozl19L8u5Z0j8KcexkwE5vpM6OkgC4jouTGarnPH2Bggx8FR?=
 =?iso-8859-1?Q?6eVZ6veGcKBtjEBDPlMuhzTsKGllOl8Y5MUcbWo18I7s7985JiJVeO+bKB?=
 =?iso-8859-1?Q?4gcqyxi3cBVgenXLmDUzF+7GURDpgvjgRV2W4S8U69hGlP7/TmRX8U6tAK?=
 =?iso-8859-1?Q?vF0L4kK9FGbEGUotUxaayxx1fSn2LRm70nAAIgSISSQ715ckaacMuHcs4k?=
 =?iso-8859-1?Q?cfMJKH2hGVh+satfhfF8rofUhkFXoOSlMrC22v6aFYXGSU0hbjy+EdXJWw?=
 =?iso-8859-1?Q?XgHc51zmLuM5Pku3FtQTmIQ376RMLNy9QnuCojbRRoG7iYqkLGlnMPLNqx?=
 =?iso-8859-1?Q?lM0YkMn43zv6IbIyaFJdfb4d748k/PIZXDANHD5Rx8ZRnwcr7qVkE4wem4?=
 =?iso-8859-1?Q?Vjyp6ciq9m8hXV+s6krNLDBimaKcUuPzCI8g/0uqM6cc8OkLilMyJPYsKi?=
 =?iso-8859-1?Q?F9C3pLQ6MBJsYWEKrNcwxRQIxKEzGCTRCVYYE6OM/YGwFMAQrNM7rbA3mz?=
 =?iso-8859-1?Q?AgETjBZyXu6vyLBni+y8oSnDgOJO0LlbcS6vqPwsrTCY6xfxDX+it+eOMM?=
 =?iso-8859-1?Q?IJzbNo67VyTXcFc2aevjLcLEJxkrWMlOXuTtk1us0Qi0eTPkhbhsYUk8RI?=
 =?iso-8859-1?Q?De6WHIow41CtVoTwoFA8qNpstyYAyu0ZH1O3/7z592lWdPJ2UHnQGvLtpf?=
 =?iso-8859-1?Q?kLz3/qix394sapZB21pvq1A6/rUzzg/t0DJtO1TjJpYy0h5nXIQ8GwiGY7?=
 =?iso-8859-1?Q?mR8MPSc0jkvpIh7Cgh02xfG1JuXU1Sux7XFJulcg/A7Z36MsHViQZoAJY9?=
 =?iso-8859-1?Q?d4qGMoKvlqbTjSUl8qvg/aXNmNztTUj6JkmOX3clpkmZXKGUaTEac+J6vk?=
 =?iso-8859-1?Q?q7+ZEcxcwXxLfZmNRvgGjyEjb/JdVx+NpT90zbKKkREZnB7Ci3z4KNoQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50edce4f-fe53-4caa-6cc2-08ddf6930d18
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:09:19.8525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y85UxopumeWVOb1/m4Fhrx8GfeO/iBR35Em4MRYi3wwMS4Fdm4VbyyluhDumKmXbY86W3CTr6nRlNUSCe6WXYeRUsvmYYBOfPKqM+I0TQPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
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

On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Brørup wrote:
> Dear NIC driver maintainers (CC: DPDK Tech Board),
> 
> The DPDK Tech Board has discussed that patch [1] (included in DPDK 25.07) extended the documented requirements to the RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> These changes put additional limitations on applications' use of the MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive with MULTI_SEGS (which is typically used for jumbo frame support).
> The Tech Board discussed that these changes do not reflect the intention of the MBUF_FAST_FREE TX offload, and wants to fix it.
> Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually exclusive.
> 
> The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> When set, application must guarantee that
> 1) per-queue all mbufs come from the same mempool, and
> 2) mbufs have refcnt = 1.
> 
> The patch added the following requirements to the MBUF_FAST_FREE offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> 3) mbufs are direct,
> 4) mbufs have next = NULL and nb_segs = 1.
> 
> Now, the key question is:
> Can we roll back to the original two requirements?
> Or do the drivers also depend on the third and/or fourth requirements?
> 
> <advertisement>
> Drivers freeing mbufs directly to a mempool should use the new rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so the preconditions for freeing mbufs directly into a mempool are validated in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> Similarly, rte_mbuf_raw_alloc_bulk() should be used instead of rte_mempool_get_bulk().
> </advertisement>
> 
> PS: The feature documentation [2] still reflects the original requirements.
> 
> [1]: https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b71391884876673c1
> [2]: https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.rst#L125
> 
> 
> Venlig hilsen / Kind regards,
> -Morten Brørup
> 
I'm a little torn on this question, because I can see benefits for both
approaches. Firstly, it would be nice if we made FAST_FREE as accessible
for driver use as it was originally, with minimal requirements. However, on
looking at the code, I believe that many drivers actually took it to mean
that scattered packets couldn't occur in that case either, so the use was
incorrect. Similarly, and secondly, if we do have the extra requirements
for FAST_FREE, it does mean that any use of it can be very, very minimal
and efficient, since we don't need to check anything before freeing the
buffers.

Given where we are now, I think keeping the more restrictive definition of
FAST_FREE is the way to go - keeping it exclusive with MULTI_SEGS - because
it means that we are less likely to have bugs. If we look to change it
back, I think we'd have to check all drivers to ensure they are using the
flag safely.

/Bruce
