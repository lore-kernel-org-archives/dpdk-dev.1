Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE9E7E0CA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F47E402B0;
	Mon,  9 Feb 2026 12:15:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1DE164027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770635742; x=1802171742;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9lr5gNow8KCNIV5L/PewH6+2iFDvy4FT1Pzf0e+tsns=;
 b=ltaoOb8YLLM5onqm+22ZE5lsGsRHr0CO8JvpmF0lNpLUxTnwCDZBPx+q
 mRzDuUFIv9fwa9jx1wAw/JYo3hNVxO6nffeWd1udj+V6yozs0+VRia+Ew
 INpsRWcRuqRVroA0Ec/R7B4vDZu4X7mD0J7qr+LfEmfmk0/rpv0OJljuz
 Ah1oa6ocyHSp4cX/8LCSwiTr+7kGMP2AhdTN9HR4k/FQ7EofJhyTejSas
 KpWkHmWPfSLKLArpXa5F5U4c1uBWe6dDyZTmm8Hr/JmlgKogg74uw9J8F
 dJ0zFLQn0HgWYB0EibSYpv0aWBS5vL74MC5F5K+5avOrtTbJuBErAONI2 A==;
X-CSE-ConnectionGUID: 3OCqdwaZTgu2xt+AgD6K9A==
X-CSE-MsgGUID: MncvuEngR1qxasQY7vJBcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82479097"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="82479097"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:15:41 -0800
X-CSE-ConnectionGUID: FOVNCrI9STKc6oLvO7GTFA==
X-CSE-MsgGUID: NVtGWM3cQ5uTEc1oLlL81Q==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:15:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:15:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 03:15:40 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy/X1NqCLqXEI+CWYLfB8UKKIUBSp2wOSvpl82A6BIyToCJfizOgsghed3329L2ZZ23P+sI/Ip8qE/a9/AxcUc3DNdbRvoL2Yp61DtHCHnH7zakaEgd/H2S2KPjvK8zMfcaEhSKvWC4BMO0ApDMRoWJU/G65TYZWJUh7HLXixMOp64vQDjYr2uC9ieuMfky+fssjavZh1C8Xld9sg4+/1EpVZ5gTVSRaZTAJ1Vj69EcEHOGNGi0dr7Xt5Ursjjn6bPtANLQvTjdcgblINyTpZXbECT0MneZtIovtfoKXn7Xo2mWguUmGJ3d9dxU0mtLPuEkxBNuShVKNPmMe3upcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcngLxNZll+Aj9POkwqJ0xEcqNt4GzZkY2pGTbhVk2A=;
 b=ETy0Sx8ys+rpSTdB19sPPBTHAMIR6byxCU82RFhSiksCuJx//jzHKmRfSthM6gP/73m41D4R+lFRUVAMgknMHOfkF/1vNM8959Mdu7a77J+W6omRQPyV1GITEVdDCu8LYnl3h3UEIlOI983kq1fFkpem75WmPg9U/WyQOn+1H81AyImPwNDcWN1SlX0XaWTcP0qqI1W1mSOlQs8/Nso03bMERvy7IviGxnftYOfh59cvDwJDDhUV3O1Eh8e08mOMl7YtVF6+2oWMFoICeR+2EAM4xkFOzH7xIrdNy0BDT+8PAmNmhuNlrd/6h1CZFTr32qFAyDqInYGrM/QYpoRxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 11:15:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:15:38 +0000
Date: Mon, 9 Feb 2026 11:15:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 06/36] net/intel: add common fn to calculate needed
 descriptors
Message-ID: <aYnB1pYe-LYGKSO8@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-7-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1ED8AB89FC2F13E0E152F8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1ED8AB89FC2F13E0E152F8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d4a994-5d49-45c7-053d-08de67cc8e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEBxTHjLiBPAYfMGpRKi6TPCM+4U4yj5vOxToKBn1s+/7xlmjjquXGeEqrRl?=
 =?us-ascii?Q?JL3ELwfjoSjTKNzyHsh+DQiEcXZ0erhX9ycGdZ/WSN5iBwt2rAdNq4obnKqV?=
 =?us-ascii?Q?MX2ZdKX7VQeledR2Hl6KNrVKwXKhBeKTIUmxEwbk2ficn62+6m3lZpIe+rb9?=
 =?us-ascii?Q?ojFbhe4+/VaJuultleCtrwAbR9wo4Z0WGn3GMr44qxVtZ4tSu8gKwqufSn4E?=
 =?us-ascii?Q?C0Kb6aesVr8O8kA1z24ENLxji1+quUeSZgrlv4SA7hQXIO2+PR6XSUd2JFOa?=
 =?us-ascii?Q?lZPdg5zE0m9oh4QfMaxBEGl0RnIU9hhBZVMDcxhkXRKNPlfOX1p5hFbBgccs?=
 =?us-ascii?Q?hxziBnn0nPneH7RvbnIRIUGxfrfgkhbb0VgF72R6c199GhGR3YFWtvnSbZkI?=
 =?us-ascii?Q?PWFsqsYNehqUIxhsJlYUL9u0ramtxiSFyfrlhL3m7/umIcoh7q6itgN/yHVq?=
 =?us-ascii?Q?uY/Uq4oTAcCb2beSwydfgHawH2QqrVgllsohwNFnsI5OG/x5PJhI4oifqB7i?=
 =?us-ascii?Q?+2sAC2KNppg3KY47M8V0vWgGDgPkbTrnyYvLbaNiOaIPiYEWM7wFVACYUIuB?=
 =?us-ascii?Q?hQ0hDPs59u6yOOHKR6MXTvcBZUEbtsNN1H+vbvs00CJ2mwt66Cw5v9Y0G1ve?=
 =?us-ascii?Q?OzoZ/bHzHVW32R1KghE4XbumjbvBSijEI4BW0SlR/ZkOMnhyz9TjfAe/rwuQ?=
 =?us-ascii?Q?asNILGsQ8b8tqo3/NasJCcjfz0X9vspZWGycsJBZfGesRLg7pxpQlq1sF8tl?=
 =?us-ascii?Q?dLxLmUjCt//0fOEzt4uTkPz8zbjrLgvOMx/J9mIPH6vNgXZslO4c/eR9axjD?=
 =?us-ascii?Q?RG31DI+IHP371Qtj0FTNW3CfkKUJUmCS1w7UWbgLUomqCfyBykSWTmk0PQLY?=
 =?us-ascii?Q?qh8pw2k0WBn2l9phgKlRqwGSWscnUMTjuE3ULm3PHDXQhi+2tDWwtU3AfiQ7?=
 =?us-ascii?Q?69TgzdyIzhA9Gf79CpgQnYCWyEd5YlAmY52KjCa4BY7UJZABR04nNTgy1Wqq?=
 =?us-ascii?Q?pHQWr+d97gx6gmG2kb20UQpe5F4QXWZbfZACANxQjrsbTvuKG6wK2lFlO4Rr?=
 =?us-ascii?Q?pnDeDD3bpmQqUocTQ1UhK62j+iq1OF5VO9CRFfS5BJxbzrPc50hCG24LP0tz?=
 =?us-ascii?Q?JWe0PIKYCe8RxZ/NUOsHc6wbVU4Zwhdb1IFgpIit4xOsRJDa/shmCZ9fpjl0?=
 =?us-ascii?Q?CYWB9BVqaY53C5XoSoSUWuYkeR0oyeO7d6vGp16/zSHuWQd63IScMf7CbLce?=
 =?us-ascii?Q?MLEef1FMv5OwDY7iKbs7R+EP6CUfoNgp2PdS5S7f+JFb4Y9pZDIqME0bVrFN?=
 =?us-ascii?Q?mh/tVqFp3tn52aKB4y1ivc0LZ+EaSw45pnmlc18GDu3ul5gAikdFD3Z0FSLj?=
 =?us-ascii?Q?LLj4ynRtw33bvuyhLTysRzIZyC33KnIlpKYhEc+LukjnSvI6cp+yJGxIz+cY?=
 =?us-ascii?Q?l+u8bodj2KBF4JklQpuiV9Jb/Fl24URss5TfD+rT7iXfAw7EnIslopVUMsto?=
 =?us-ascii?Q?ZdBC54DxmyoXZKK0oUCaTRlrzl3Jlm940H4hNrvJmpjhxin8s7VywVM16M/4?=
 =?us-ascii?Q?2y3cEFr9djYLhyE6Xk0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z4zLLZy3s0x+gSxJr9Eq7cZrolHUMo065UNvYjkglmVa3y0EfOlGcz2FK2HH?=
 =?us-ascii?Q?HyD1lBMU6i+YtbqFPebnWoDVuo7Cpr8BZrZnxpR7FphCzkpOqbVVX6nLw4jk?=
 =?us-ascii?Q?aCktREyBHYYqhWE9oEkO2gsaTap6IVb7W5fgqKjwENwaGdzO7XPw3jrIpTAU?=
 =?us-ascii?Q?0ILLVhITwdEmF+O6N/QsFwiQPzp760l21H6SiZZMVIuExmC/IciVSzw9rmz/?=
 =?us-ascii?Q?ViAXAE9cPo9Ky9BMkusit/gBkLbxCJaPUNCEIE+qQi9nxz+j2VAUj2tBa7j6?=
 =?us-ascii?Q?HVHILH/kMxkaPn3DIPFyfmm2vTU/fszR/bVBueTMQAWF/sWvhWG43UoY6W4S?=
 =?us-ascii?Q?JUFwMrfZdMf2gLo1f8WQX/LqfDH2QCU35TMeoDxDhMIxKQ+hw2K4ZhQ1tQgq?=
 =?us-ascii?Q?m9zy1z1NhZhvnPCZeLMBopGPbkVQ7AQnTzO9Cdl/9J7IkCTGsf/xmntWcuUZ?=
 =?us-ascii?Q?P1gPleYS6JouMilPT5Jb/G7HXHC3tbyNUnfaBclcFFFXY0COzaG9emwTbZSX?=
 =?us-ascii?Q?i/Bm0DPE7AZKasdFuZUNFiQF+KU8NWMAfMRbzJlGwmSY8KoecooiVZdQ80rO?=
 =?us-ascii?Q?AZpUt7E35L1MUZocD5EnSxt8ZZgOhL5iitBRWL5jnAIVSm7RL486GYEGX3Od?=
 =?us-ascii?Q?c39wngGzphGeM57+//wJPZz3WD3TbiC7mzg+K+6DV6kI6DyfYRpIHovE8JrJ?=
 =?us-ascii?Q?EiiCc2tFCqmlzOJMvBMzUFyCqhM9sajzsIR61SoxBth0g7CLJ9/SDSB7xVWT?=
 =?us-ascii?Q?WNWO11lheusWByASCj2WQ58wtyJbxiv638HaWYJrSYwEet0iALWsAHKXyBYj?=
 =?us-ascii?Q?Z8Vxk56+pwDPNtVybahacC0/05eyp6nKjDLKyloTFVwf5InGmM1ou0REpsjr?=
 =?us-ascii?Q?lRhWYWZmcds5xh4A6RjgtTD4/SCJFob/3Mb0+Yknol6z1P+yckVv+IlCp06e?=
 =?us-ascii?Q?KrVd8OlhfKLWvfkh4BqEKZz2Kcae6260rRjHi8g9OuY04xNv0oMAWmEZZyyt?=
 =?us-ascii?Q?BhSDwFKf2OMaMFu2KKcbPCiFJ0gxPCaDdMVP93Nf8fnznV5oSTpAmilyPlQE?=
 =?us-ascii?Q?cj+ioYpw8zMEt5nOtU/SiLLCx2BxdGATNuDfOsi1W+BZOalpRHuAAbonAvck?=
 =?us-ascii?Q?mVo4GEaQfPRtW55V2T6QcuE059Sm0bIrKLe30u1/vLjSNAE8C+RU64usqzmZ?=
 =?us-ascii?Q?CrFjUounjpayuUildEOcnghP9tE/oe2hNo5yx6NMZuqsquSiXCD5BNE25ykT?=
 =?us-ascii?Q?qriaT9SlHX+cajd4C3807ApQdejPXr346urufDkp8zwBHkZPpKx9jKJBWPVg?=
 =?us-ascii?Q?zpILjHVIOU6In8q94KiO83TkMhbQadSzMMFMjcrhuoJN6yNio9rfRcBEx2Rs?=
 =?us-ascii?Q?Ri30kJXS9Ebxt9bNK5ijEsvkc30dmOMDZztoYtjeIffgqvwZra4HFQ29oWN6?=
 =?us-ascii?Q?ySJR3RepsV5UaUDAVj7/tG+ikrkgHLUg13PxxNzowkmRXS6MZBbnhA9FpWlq?=
 =?us-ascii?Q?H7c/+I8pn7wP9WjruK1v+QfxxtCZIMo2kDycKNDHp6OteQ09drr9Ey6/fS7v?=
 =?us-ascii?Q?iTHS0Cpc2LHVTmMLpNWiHF1lh6tWsc5r2cIT/pfF81lswNp0jfIJkMN7JUdu?=
 =?us-ascii?Q?1MF6ZkVDT11rJZ2Plh53rSh08jfbN/WID/9itbdutwpjDj3ApNQEgcIDqjGY?=
 =?us-ascii?Q?7Gwm65xJUJZ0mLHFN42/Mj/cBjtF66fvqN9ZTvf4guAAYK6V8g4RPGVBtM/h?=
 =?us-ascii?Q?FH3p0jJVgRR2hpE1Sav951uJPQHMhuM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d4a994-5d49-45c7-053d-08de67cc8e02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:15:38.7630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWLbZzFu75uT75jT9G727A6lMgaU33I5IeL+GmLaJw4cApUm6zgYjN6s5VHyF22TPounyiuYRuSrxXKCCZKEFgrRn782+vZwXak3EY0qf60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
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

On Fri, Feb 06, 2026 at 10:25:36AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 06/36] net/intel: add common fn to calculate needed
> > descriptors
> > 
> > Multiple drivers used the same logic to calculate how many Tx data
> > descriptors were needed. Move that calculation to common code. In the
> > process of updating drivers, fix idpf driver calculation for the TSO
> > case.
> 
> Should this fix be split out into a separate patch with a Fixes tag?
> 
I think it would need a separate independent fix for backporting.

/Bruce
