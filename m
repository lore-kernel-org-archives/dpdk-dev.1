Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C1E6BF11
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 14:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF166402E2;
	Fri, 30 Jan 2026 15:03:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 58E16402D8
 for <dev@dpdk.org>; Fri, 30 Jan 2026 15:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769781791; x=1801317791;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ympzhe0PhZXJDigNFRLJUJUp1mINlosO4e+upNnvknc=;
 b=TtNOh+HcsG0mVheQmPsNcrEN1Jbg3nTuCZqFqBFYSsXte6wlu68X5C79
 LmtcqOmPa/TVJUyuMrirz0H99zxewWtWHXI4d8RmkhU/cYXQizmZrzYuj
 ubYO4Ol+CtQIEolrtnrJTaBzBbMIfzrqepqGJOO9e9hmsvdc45C1K3wBi
 msc/wmiKHxkiOkLTg3SPNiv6T4NuVKfgazztESScnV+Ct+M9XVNB0qCcL
 w9cTt1FQmGhEIlHKW2ajWEgfVaJuC4XUD5vohLbCo8HsJPxib3Oe/tIzj
 Vtea6AeXO1bJ9OBKJ0Ys/KrAsJOBfFSwlwUP0gNTmIbuuxDCDG1paX2nE A==;
X-CSE-ConnectionGUID: 3Tyn5vEuQhmNk+mpKS6Vaw==
X-CSE-MsgGUID: rdRaMcSOSDWPWHpVdPRx7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70232589"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="70232589"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 06:03:10 -0800
X-CSE-ConnectionGUID: 5hXZU1ruTyC+Dj28AmElZw==
X-CSE-MsgGUID: 37YH3aBbT2S/xjdhcMI6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="208664411"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 06:03:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 06:03:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 06:03:09 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 06:03:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puEWmqaZ5po9/LtZpAEEu5uklOUQTnOZqDy++n4qupMfX5SL8EEMRzqzwl7gC3Usr3dS8GzTdkY4D/9ScS/TSC8GfPh96U/qPveOsdPma+7Z5RRJKCy45mIsije9rUkT7CaZU1ABXhNr+9yjuppCUtXHKBNpkH8vsFJHxnNtTnB2RuER7VU7DjTHcuChmiBCtN0JHRbFCIEiVjb62QMjriYkX1kdrynLah2o6fNx96G3IqpYICl1aBNQNhLj+eo2Fb8nYXj2dsPFn3GbtKc5dcdi7KCJ0DST/iauvjEOqXy/FMWvN+U+5K2DJrPcbIaSObb5sNlhnAyEtMdFLS/0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMl9iz4HX35vjY3CcwebHr2j4EVqrYcPUJgqaIvCz6s=;
 b=mIjR7Pxvtda5W1R3LJy0xgardrTjKjo0/Nj5CHvkoBK5kbXm2Kgc9mkVvfsERRQh0J/sH9a3lkYa5ydFCCy1vv2wKNtKO8VwjWZPWJH1ZIaPH7KGQTVloZx3Inhax5BLGt/A6FuWuSnGu+c7hvQ2gWgvOFCi55WTlCKHJeGTB775GVkn2eOXpQGKVjhHHR8MLMPXbmCf5uid+MdCyfnwi0HtxsGVVikj0O0bZMzZCMoTAQFoQGhS1nVz9zRHTv1pGAEY6FLBgMu6smnh0BP60DN6PWPASFDjmFL5cK1GlMpT84SmEftRZy03SRXsTa1Y9QuhHb0P4haij+Ib6Wp3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 14:03:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 14:03:01 +0000
Date: Fri, 30 Jan 2026 14:02:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <aXy6EQgYlugWne7t@bricha3-mobl1.ger.corp.intel.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D4@smartserver.smartshare.dk>
 <aXyVd7BpQKR_4uRj@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D5@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656D5@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P250CA0009.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9c5212-646e-4af1-1474-08de600847de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?yShfXyoGmkLdtphXJNr8hlbu6eArfS9KyeNqFB5myv5+MkCuBllWBBHeFI?=
 =?iso-8859-1?Q?jiRR2siDJiO4yJ2oFtwkWS3HsorFKadXR0gIfUF3Ps1bVy1cF+/MRIg70G?=
 =?iso-8859-1?Q?HXtht9jyeAEEbA+lNCUqw9kmq4w+oTO4+oqSmHgSxzkpgcuquDCidEqeyn?=
 =?iso-8859-1?Q?HLZhM/zrR6CxBWRTLL8XXA/GLUwW3pkN2f0jhfS9CLlthYd/ImuvATt6Kj?=
 =?iso-8859-1?Q?Akvvevic7c7jwt89DYnQktw4biclp4ehYIyRJTDWYaAAZdvsgh2MGF65KU?=
 =?iso-8859-1?Q?r6XS8CM894vWaTCR3qZ8vEiQ2czSBVZZZ6lo0S6agp2UKN5/bDNLe1LBfK?=
 =?iso-8859-1?Q?8sWv5i0C5f4o6ZFPGnZcIE1zOiU5eLcS37v0yVENL42MMpi157WggLg3Vx?=
 =?iso-8859-1?Q?iY40s9ruf1IIGugiGzCDWMibm0M29oxVtLX/rHIbSij3+4CBC9YwhglA7i?=
 =?iso-8859-1?Q?SKBD6Y9zRbkwGBSHgGO5NQXRTEbWRwEvq1zrucq6NPvWUsIb30xP8ac3gw?=
 =?iso-8859-1?Q?oki6V7+mXKRbnkUJZIN4Z7CFFwPUIP+/FV6N9ar6JYLx8WCRhD2CT/8CfD?=
 =?iso-8859-1?Q?cCU2eO31RqcByiFkwEdbCeZ/o/mirnNaJBoh9iXkVffqqpYKSucFBFqSLK?=
 =?iso-8859-1?Q?SMPOmZrOBZ2tunMVKxLw9HU83asxk+rahVKYwJIbgCUFMT9m/d0fDRxpwb?=
 =?iso-8859-1?Q?55k8ZnIQ5b8VxMyzAv993z+UKefEru+qcE3peRB0UchBFBEI8MTm0peTVB?=
 =?iso-8859-1?Q?Ksp/Ox0Tx5pjZfqZmdrOtXOrYuTv6fwfMirVL0oFuHSMedF39TG9tfypKT?=
 =?iso-8859-1?Q?9x3E1XbvXhU/Q/4gHYLeTMAfVPvaRaD8xwfRFQ1P6G+eOXINNNGgECidUd?=
 =?iso-8859-1?Q?ON2sbdgrlNmWLSDN5Ca7Ol55g/A/ePIbFZSG4AmBn019BIPpPgPj6KjpXB?=
 =?iso-8859-1?Q?nAMCWGfAI6l8bNdKMvKLJPwx9/cRHP6HDjDGFowDd3vaCZ5BUjFoPjVSoK?=
 =?iso-8859-1?Q?NQ5X2BRZPit2mG5yGmr8UbL+5JumsJlwao3A5Ua8wrwdsCeWxGXHngCXN0?=
 =?iso-8859-1?Q?iWhGdLy1gJk6EYWsxbagjmyXfna8IBfxHKswb+ai0JGgbo3BJE/ZqoPn6E?=
 =?iso-8859-1?Q?iNhwEq6swj69SLa2JDYMePG7uK7nrEsPAUYZfJjbtnAxmu+/37YItB73+y?=
 =?iso-8859-1?Q?aDmExToQfHlENEKKXZenw0h1W7VIIvlCMlLLXnvaOVCQX/MnwTHCuTCwJM?=
 =?iso-8859-1?Q?J62oZmUzh7S1t3Cw/4UKDoAm89ax1ovq4yXTln+6iVovOiKYyrZMwPRGNf?=
 =?iso-8859-1?Q?fF0k+VlWlH/M3hJM4g6aVH07avkBZ3dInzgnKqW532+rzdraFjV8l5uq8T?=
 =?iso-8859-1?Q?kEY0G9sl5O5K5uKO4ikHqvMqb+3dAisJPErBp+86/gKZ/Yg1UuKK4FoYKy?=
 =?iso-8859-1?Q?nQiAqLY0jWVejTQop0HvoYTzN23L9tLqEquc3jFBy3sZ4N7Pe2fZ0NPqzV?=
 =?iso-8859-1?Q?pOFLuCWYkq3Q7pNPG21Q4OHiGk39lr6zjMpH6mDmqn+/lY8bYr3gW/jBRK?=
 =?iso-8859-1?Q?hemGbf52R2AOOyTRxTJjYjAYloho?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/DD++C27t6JauAXgmIKtlW4KKFThoDiJslel4cIge5dUWELvef/VeW7eTL?=
 =?iso-8859-1?Q?Vux0PJ9/WMrU9ScYR8mA7ujy4CPLZ64wPKW/ou+n30kjMu/n+SkMKdp72F?=
 =?iso-8859-1?Q?o0aKN3k0M7dDXJ5KVBF4hcRWVIypBEsBM9aeQATHXrFTMj4pTa6ELeob03?=
 =?iso-8859-1?Q?QVvObGrH3JN+UJk+lWatZUS+jlfF1sIRQlWKZ5Vz6MvxJ40Z6B6k4rewf0?=
 =?iso-8859-1?Q?uIaysmn8FtOry+QoyTMcHuFWNRTolTj6hNllgsccx5YenVljzCtFTgODrz?=
 =?iso-8859-1?Q?oV6/fpW3Wnslqnx5lwMO0IBf4SBL++9rKzvaalgrHlkZM4AKeWmEeESvqE?=
 =?iso-8859-1?Q?loV2diFtjlwjHjkjxdtWL3rCZZGmhO7Hb8guUrL39Bkbsd0cehZOSrJpFq?=
 =?iso-8859-1?Q?IpN1VzUhiHHrxrGACPIPkifU1rOoX2CQEghkMrPNb25Sz5GHIUzVfq7ZEq?=
 =?iso-8859-1?Q?s0rFPQKqPuW4t8nEBn5lEQdHt4Y8aR5T2GONvsatdYYhyHijyM/R7O0KoN?=
 =?iso-8859-1?Q?+3krsxI2mfn/tGvEG5YKVailOier2YbOpfI3gVAnrgAKdHi0hb3Nn/FwpT?=
 =?iso-8859-1?Q?4I9dugurhBcHIdwtX6Q6+gl7h5r7Fjns2/CbmyH6CoCkDL4wzm4i+bGvzk?=
 =?iso-8859-1?Q?j3q4qWSAt9pluLPpL0D0dc4abnmlH9PFWf03alK7VPrNNYMVCBvmcxIHji?=
 =?iso-8859-1?Q?UYPex6YPMABDxv51nOC56AdXimhcLOir1q4vu0x2Ffxrh3YJ7BVxTfNBx8?=
 =?iso-8859-1?Q?OR91hjZAzruCIMePgmAMu5uNAYFstPjlyjB4H3AAnyfsDpaciRauz+vPcB?=
 =?iso-8859-1?Q?vADDmn9fKazAwz7M7HLraY/pofZWcx5aueJX3gwj8cML3BLXpe18AMiYeU?=
 =?iso-8859-1?Q?vAf4J3nzMfuEKCYXYo/Nrjd9HNrgWfFqkLmO2XWNTU7ykiMHJ8vZ/KIQz6?=
 =?iso-8859-1?Q?QxlBBQ/IBC4LpuzZy/8PNzkQvLt37R7E1ZE5NwvHuhfDVGa1RfgAaehvYN?=
 =?iso-8859-1?Q?TlDoLUq679OkCR6EC4b9S0qDMwJDf2VuiSzl1uT+aEv1G1dv8CnWXyuP6t?=
 =?iso-8859-1?Q?AK4N3iGz3ffd8OFcrsvMy6vKqcZez8WjERksyN+1iWP6Q5Xzfts2H5GBpk?=
 =?iso-8859-1?Q?9ZcI2HdFhskRqlY3WxrwfgNAmZVjlTftjjbuch7inqeJq4nMU6ExdLASJP?=
 =?iso-8859-1?Q?zHxJRog/Kks98ThiT1IOwkYyHej7ICW5iboUTI0j7YpDwrHio4v9JkRsBk?=
 =?iso-8859-1?Q?lDIhFVsYIkWEVfYlYCl8hVZeABNxtt6v8hXZ3HtoVfv8pjNkNtqiMjXG9J?=
 =?iso-8859-1?Q?347V3Z1zi7j5cTGkNPlMkX9LjCYenXDNKrlHwJWAUslNb6jCYDimVvIXqz?=
 =?iso-8859-1?Q?wxnFsF7jvUiQpvFXnW3S6rI+wVgDhUEruu/H6PemscjgLYYbAnNv2x8J/w?=
 =?iso-8859-1?Q?Nu5R2JghdEEVAEkfzBXr/uZsqdgfnegJyHtxwRa6U2HQgnGpguuhwBwCNp?=
 =?iso-8859-1?Q?zEJRiXv+rSMhEHayx3t3+lpXW7HoDWzcl9Ba7ODdFepPt1om17s5yg+YP2?=
 =?iso-8859-1?Q?mKT8hBjxISn/4k6XExw9hcFW/r3jJqe6bYrT1XTvViu9pWvtdZon0q6fta?=
 =?iso-8859-1?Q?NppbfK4Z6m/POYgf1E5Nbb3kY2cycJzboIKGU1alTZTbznUFunx/hVb3I1?=
 =?iso-8859-1?Q?nsXSuJsP7/cG5hICZxubuM0NCSe7FnCtZfRlawHIqR4W2MunU7UU4lFEGp?=
 =?iso-8859-1?Q?sqEyh5MW3yYaoDG9t6gGyQYN9tERI49qkrF9wGcZ4AhEbsQh2o+KGb3t+h?=
 =?iso-8859-1?Q?qb7Rm8DGDJDOpZqcsxtf7Z08TbvR7bs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9c5212-646e-4af1-1474-08de600847de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 14:03:01.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVFjtT7rysKJVbOKVf0DSwL01lbi5OiZb/7tsSxbeLa7JRgq0VQB4FFWYjtuNfIyKG3r3aPfKViPt0NQ01+GVKy9dgy54X3zoN/02GHux1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
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

On Fri, Jan 30, 2026 at 02:54:52PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 30 January 2026 12.27
> > 
> > On Fri, Jan 30, 2026 at 12:16:43PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Friday, 30 January 2026 11.53
> > > >
> > > > On Fri, Jan 30, 2026 at 10:46:16AM +0000, Morten Brørup wrote:
> > > > > For CPU architectures without strict alignment requirements,
> > > > operations on
> > > > > 6-byte Ethernet addresses using three 2-byte operations were
> > replaced
> > > > by a
> > > > > 4-byte and a 2-byte operation, i.e. two operations instead of
> > three.
> > > > >
> > > > > Comparison functions are pure, so added __rte_pure.
> > > > >
> > > > > Removed superfluous parentheses. (No functional change.)
> > > > >
> > > > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > > > ---
> > > > >  lib/net/rte_ether.h | 19 ++++++++++++++++++-
> > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> > > > > index c9a0b536c3..5552d3c1f6 100644
> > > > > --- a/lib/net/rte_ether.h
> > > > > +++ b/lib/net/rte_ether.h
> > > > > @@ -99,13 +99,19 @@ static_assert(alignof(struct rte_ether_addr)
> > ==
> > > > 2,
> > > > >   *  True  (1) if the given two ethernet address are the same;
> > > > >   *  False (0) otherwise.
> > > > >   */
> > > > > +__rte_pure
> > > > >  static inline int rte_is_same_ether_addr(const struct
> > rte_ether_addr
> > > > *ea1,
> > > > >  				     const struct rte_ether_addr *ea2)
> > > > >  {
> > > > > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > > > > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const
> > > > unaligned_uint32_t *)ea2)[0]) |
> > > > > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t
> > > > *)ea2)[2])) == 0;
> > > > > +#else
> > > > >  	const uint16_t *w1 = (const uint16_t *)ea1;
> > > > >  	const uint16_t *w2 = (const uint16_t *)ea2;
> > > > >
> > > > >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^
> > w2[2])) ==
> > > > 0;
> > > > > +#endif
> > > > >  }
> > > >
> > > > Is this actually faster?
> > >
> > > It's a simple micro-optimization, so I haven't benchmarked it.
> > > On x86, the compiled function is simplified and reduced in size from
> > 34 to 24 bytes:
> > >
> > > 00000000004ed650 <review_rte_is_same_ether_addr>:
> > >   4ed650:	0f b7 07             	movzwl (%rdi),%eax
> > >   4ed653:	0f b7 57 02          	movzwl 0x2(%rdi),%edx
> > >   4ed657:	66 33 06             	xor    (%rsi),%ax
> > >   4ed65a:	66 33 56 02          	xor    0x2(%rsi),%dx
> > >   4ed65e:	09 d0                	or     %edx,%eax
> > >   4ed660:	0f b7 57 04          	movzwl 0x4(%rdi),%edx
> > >   4ed664:	66 33 56 04          	xor    0x4(%rsi),%dx
> > >   4ed668:	66 09 d0             	or     %dx,%ax
> > >   4ed66b:	0f 94 c0             	sete   %al
> > >   4ed66e:	0f b6 c0             	movzbl %al,%eax
> > >   4ed671:	c3                   	ret
> > >   4ed672:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
> > >   4ed679:	00 00 00 00
> > >   4ed67d:	0f 1f 00             	nopl   (%rax)
> > >
> > > 00000000004ed680 <rte_is_same_ether_addr_improved>:
> > >   4ed680:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
> > >   4ed684:	66 33 46 04          	xor    0x4(%rsi),%ax
> > >   4ed688:	8b 17                	mov    (%rdi),%edx
> > >   4ed68a:	33 16                	xor    (%rsi),%edx
> > >   4ed68c:	0f b7 c0             	movzwl %ax,%eax
> > >   4ed68f:	09 c2                	or     %eax,%edx
> > >   4ed691:	0f 94 c0             	sete   %al
> > >   4ed694:	0f b6 c0             	movzbl %al,%eax
> > >   4ed697:	c3                   	ret
> > >   4ed698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
> > >   4ed69f:	00
> > >
> > > For reference, memcpy() of 6 bytes (compile time constant) also
> > compiles to a 4-byte and a 2-byte operation, not three 2-byte
> > operations.
> > >
> > What about memcmp? Does it compile similarly?
> 
> memcmp(a,b,6) on Clang compiles into something very similar.
> memcmp(a,b,6) on GCC compiles into something with a branch after the first 4-byte comparison, with the assumption (regarding static branch prediction) that they are likely to differ.
> I guess GCC's counterproductive behavior was the reason for originally implementing a manual comparison, instead of simply using memcmp().
> 
> BTW, GCC is clever enough to compile 8-byte and 16-byte comparisons into code without branches.
> I guess that's why rte_ipv6_addr_eq() is implemented using memcpy() [1].
> 
> [1]: https://elixir.bootlin.com/dpdk/v25.11/source/lib/net/rte_ip6.h#L68
> 
> > Before we start adding ifdefs
> > like this to the code, I'd like to see some measured performance
> > benefits
> > from it. While the code may be 10 bytes shorter, does that actually
> > translate into a measurable difference in some app?
> 
> Excellent question!
> Some quick rudimentary testing shows that it seems to be ~4 cycles slower than what it's replacing.
> Reality beats expectations.
> 
> I'll drop this patch.
>
If you have the test-case already prepared, can you also check what
memcmp() performs like? Replacing the whole function by memcmp and punting
the optimization to the compiler would be a nice, though small, code
improvement.

/Bruce 
