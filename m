Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91BD41141
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 08:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E16D40B98;
	Thu, 15 Jan 2026 09:46:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4006F4003C;
 Thu, 15 Jan 2026 09:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768466786; x=1800002786;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5bxty6dnBL12rPjZ8efYsyCfRxWaG4Jw4yLI3CCqNkg=;
 b=WvGob4tp/mbfDBk1o2KsYwyCi3e/DoZTrIaDbkcKLlThORrc2Ebj+n4H
 ypBfR8OH4+FfzbfyoowffR1Ve+Wao9ZC/SF1jFwC6CjdwXXHwJmwe0Y57
 FrLuNY305PJHVLD8rx07HzVSjyTwH8FV2e6mLSLiizvqW95UoKh7DE++J
 PYVTKzGlLMlaSUHZFPC2FfldNkviff/sDgeingL/p2KseQRpLwMsLrHX6
 MOESDfAEn5ZHyrWak7FCh7l1ieHC2VsJ+SyuvjrdqZalOpVQkMsPhd4I8
 lqKqsglD1zVyAoiGkPaHyvJWQdREhbBba1nAOVttW3EroiIdhwHbypRyX g==;
X-CSE-ConnectionGUID: wIg7exgJQk2hPVY58O5Pig==
X-CSE-MsgGUID: 1wfRVzeSRoGy4jv4S/aJag==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="92439608"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="92439608"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 00:46:25 -0800
X-CSE-ConnectionGUID: XgZnp2htTP2MDmdnL+oZ7g==
X-CSE-MsgGUID: zx0JOeMESF+67BnoP7RH4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="209414703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 00:46:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 00:46:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 00:46:24 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 00:46:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDURV9DQOHLoqbHLc9xjohKG2YN5WCUnZKeLcNcqMJeg1V8NZyDVYpSiRJqOVCyWLLLW4vsyOjUbLdfVHIyuximzD3Sj2bEtM8riKBQRgqc1VQRr6h5wfzIdJzY430bvT9l8WIkaBD3rqs90v/AD1djZzN+KzSOjrygEKMlvzhP8gxh1NvjuSkDwE5BjNp3hghLi6i8BKIzUt6ZR34TWepbutLqzsVinYaVccSc/q7t7tC7F4HVvCHy0Vqk9lOMs/AY0LXOGcbp34/EyZlsiJotqqFR2jVBXD9f1Eu0bH/QqdZJjm7jDOeut1bGhtEvBTSFUetpJ63HsaW60rUlErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeUutF0qZ2ZlqRd/5tFHvcvR44ALsw8nI1MuObuVfTo=;
 b=gxWjycFnM442xlca3VfR6ufkX2EGPMGPQ8X6Mpy7QAVi/TDW9Qgay9Zfx4iNnjsLnMVFwAc+J51DikWpxLPhzHD+PvG4VrB4Cnvkud+YKFazOYF+i3vx6CH/RiKe5lzmVy8HabhU+VrikLeihcsh6vv5BQfpiZPJLmvfrG24Ad+wuGellqPwEmk75/pdF2BFlWWPTFK/a3VyJwiN9l7jGX76D+pD4g6gSHbYtBv/WTjqmqS83fTGmDZp+2ibeJAgcCK+NijInRCXKtE2PV5EogBf/SdrLdd8yajaaTUd5qT2cGaLV0GB1GGT2wyuwpqm/iwBIO95KsmdtMRbAD/qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 08:46:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:46:23 +0000
Date: Thu, 15 Jan 2026 08:46:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>, 
 <dev@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aWipWVON45iXUTrg@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <aWfGCglFfkpOAxgh@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6565E@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:8:1::32)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: f51e798d-3214-4e34-3c0c-08de54128f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f9j8ZK83uXPo1ejzE09RsuCYm8qrJf8+wANhJ9GdjU2iUZHr3KU9S5J8j5?=
 =?iso-8859-1?Q?LyqjRmiLsc8qQoiUg5Ant1XniwQCpDwzI66yuQPvvmqd2IEPvjc6zy0/Zs?=
 =?iso-8859-1?Q?3EvOKEeizsdY0Rsk5sktcn8JzbUyZm2hzNtJXwFZgftEIqxxcfvoTJMNMq?=
 =?iso-8859-1?Q?nlXXD7SmH3oK8KSPICqmLPDCdqQG4WCn2mhkaq0OsVifmLocjvR23ZcpxS?=
 =?iso-8859-1?Q?cNc/LP++to/9PZlEXfGTiqIGMYqnMNWz8bfD3XCkvcn3UTiYNkEEazocYq?=
 =?iso-8859-1?Q?5w67nTjVnBF3sCvxOcyFthVJqpd5jbvXVs90DOftJjDn/GGZSBdwC1pIkF?=
 =?iso-8859-1?Q?aKuPH46IVE8dLY7EKFmg8FoEsT3HHiYBA0mtmz6EKd3oZ/IUtYXf9u1Qb6?=
 =?iso-8859-1?Q?yDWfwyknJvLKxd8p1AViAdywGpcs9GxO9KtTDVFh3BQddJR49DalLUCIvX?=
 =?iso-8859-1?Q?namxF6vgf+C/tDHD3myOFf6ds+CvruAwgeVDyqO6wJb22ZNS7xTEpzPSU9?=
 =?iso-8859-1?Q?oDmlg6CxZuskCH5cPaV2C+Mr2DLautE0/XcQKFE+57jOeje9xCF4Orc7If?=
 =?iso-8859-1?Q?G0I876HMmCk9gtog7+pn2Ogy0G2NUE9WM1XVk/+SQlEWTw1/Sotg0aDchD?=
 =?iso-8859-1?Q?ZxAWNhd1aNpWmPXplE9MPSpu74lLZLXfIAz0OzzdeDNmsBdfc5TjWzVPK8?=
 =?iso-8859-1?Q?VH33qN/yaPs1uMIVIXVL/ZpqorMtP0JvHdgFiBRYElvgDSS+4cHJf1vaAt?=
 =?iso-8859-1?Q?LUQiaXFOpOI2IIspZJvC26yvKPxrmstF9kf+q7PhORvwxOUkCEY7kQD/82?=
 =?iso-8859-1?Q?n84mUUfSp/IxB2PTOSBz+nMquWc3OgUfXzD1+UY0TClOPkyz3WhrTmiE/a?=
 =?iso-8859-1?Q?5wh+bseTCyjUIe4fRSIaRyMTgpCeh3BcoSZaXVa2b0UudAQ1cENR7Jt1a4?=
 =?iso-8859-1?Q?pwmkht99qrHu7wptoih7wkOuOkb/l5Y9IMn7xhFDiSlSb8yXP68uFSkQh+?=
 =?iso-8859-1?Q?Tvzs6spisOXsYhRXJkwNdAiFJP01iqBlNswblGbSAplhm6liR41Xjk3XRQ?=
 =?iso-8859-1?Q?wA/vzrkxjKoI/UZHN/wLUPlw1J2wSerajSMjCa/mf9YQnDRLq+3leREKyP?=
 =?iso-8859-1?Q?OCC0D7PUVRYVkq20ezCr6pkr9X1AsWAreE913MEWKtjoCC+nW9VIgoFoiV?=
 =?iso-8859-1?Q?qK7uk7lq+33GlpUShlfrm0c3YhWzeJsBJ3xDf2Eul8P974y7Houiu71J/+?=
 =?iso-8859-1?Q?L3sxPJYqTj4/GByqten1YWrDXvLLCVbb6qxM4e8jopxYTqEDka5S87FAW2?=
 =?iso-8859-1?Q?Uu2br9k0qg55RR2z26gSFTImXB9s0LKSXhQpvucArVqY3VX3DpkzxZjv89?=
 =?iso-8859-1?Q?skgeiA0G3ByNBeuYup1VwiVSj1cPFdovAZ4U69JYZh7jZgGdWZeIhN3SxG?=
 =?iso-8859-1?Q?UhXQ7nvytnemIhXDlexI9S5upZRRuV532jeduiTS1yNRdBNJ1ueQFVp/xA?=
 =?iso-8859-1?Q?y6mJD2PddGeyG2p+t91CGAfHNy+jDTOO5bfOwDYp8qkJlEKIczBN/wVS0r?=
 =?iso-8859-1?Q?4XHETY379toGDyQp2ZVDzqdFJ3pns/KBmquMOOJuPWHs/vRxKHpa/zfpRO?=
 =?iso-8859-1?Q?e7fvvJOjT6X/WjqHSgMaUiggyNe9BBmLk1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XQIfbeYkEgY48+4vlWLDPxMZX5bmxXhD34R29wwdyv/3s1Sr1CGYxi1d7w?=
 =?iso-8859-1?Q?ri7vDTPIPhl7U6Z2zXUBTjtc03ySeCXdmQzoYFkmeVO2HTdD819bvI7t7I?=
 =?iso-8859-1?Q?UqN7LkcOhUMe3UrHf5BamedoBtcktFPTG6f4OA+DD45qLhxmUTbSL8kmXS?=
 =?iso-8859-1?Q?jyZdOJ225dbjRN3iM4AnMfalcw7YarYgKdKWBn///MgPxeAq5Nu8Sqrc5P?=
 =?iso-8859-1?Q?X2ttARje+NB50Y0/zb6sTxQ5QKS4vCgh4RaQR+opQSnn9utok8A5SwwFHB?=
 =?iso-8859-1?Q?U0Bvjrh/NOLcN/9IDMaKiytDVrXlZ13AXdUb5XIQe/M+SaNRSGrToq0XDX?=
 =?iso-8859-1?Q?LM7dpB25N1BZm+HwXOcw5yNID1dXOUPhI+28M6ZZErdF3uXxMxWy6JicWh?=
 =?iso-8859-1?Q?7gDcgvYmA7sAAm0HU1Xh8/7OVS8ztsH/auWm27cd4GG/PrF/kEh7uOybkd?=
 =?iso-8859-1?Q?kEZ86AZdOuoUAICvkMlt2b+kJUrK2fHttgRvlk8DbznWBFDovLGMxR/vmq?=
 =?iso-8859-1?Q?YgosL8gLJ/GzQKVdTRX/F4UO4hyDqsm9sHlnlDo+tk8UxruvKrFQK/CJbm?=
 =?iso-8859-1?Q?Ukjk2DViZSVWY9ec+eQOapDpTZH5Hi7vW+cbkmYkCQswtERB4w6REidyMP?=
 =?iso-8859-1?Q?AdJyjU4LV6C5fhlhw1BccJGcbPYXo/ERt3Ai+nAViHJ7v1Nm5fQ6CpGvhk?=
 =?iso-8859-1?Q?Ui1zdSv4GvkpGKanNtxPuXW8nr8DNVPX1DVJEV8Qw0Gt1nAc4eL7HMF98C?=
 =?iso-8859-1?Q?JgLJdGj1NWZqjtESLqx+x7XUS1QZF1RYvnsHrKkary/UzpZEtEwArc6xDn?=
 =?iso-8859-1?Q?P4J7n1xTeVIXRKi1YpQLCBvJ9q5FSSe4M8LP9mnaAfnCQ/LgSQa7XTUSZR?=
 =?iso-8859-1?Q?SIMYfgvopcc6Nk8IZVpW6KgtMMiV4bUi0jKq2UX//xHGwqbs1ggsCUQSgG?=
 =?iso-8859-1?Q?7FefLYhLnCQiCV562JouU9CtiL0bGuRI6kGgjepsY7YfXV7/uaiy6sR1s4?=
 =?iso-8859-1?Q?rqVK1OzHGkyE0d9MKy9B4blu0WBKiVDVwy8ISzhXFGTfCDmPCpSiNPMQ4M?=
 =?iso-8859-1?Q?ekcxmLpZYSE/Caguzjlulvg7z8IfyRQSElwclUtu406bFIsUQmK4PrnhLi?=
 =?iso-8859-1?Q?Z1M7jAXZkW3Clr3prNydWV+f841sDlgx1Ufz2u6PjlscAT9UmDKwbr3+j5?=
 =?iso-8859-1?Q?i2kXnJU0k9AMbVxT7nskXknA5ulo/EOfU03nGpKoJ4f/mDP9u6FZHVEVlP?=
 =?iso-8859-1?Q?aAN2EOBwWYR1fP2cLuQBf/e6NY1btEPM7VwcrXIK3NhzmL9H3hRrVO0NK2?=
 =?iso-8859-1?Q?PUThOKGIM3JQSRT9AYhia3tWs6FFDP2mwxdBSL9Qme/KSQsWnnaEnDpaLS?=
 =?iso-8859-1?Q?XBuI5ZEGNzVTF3NNMf12eMn9PK/xKBbpQesEb3RpAhQA0aVLn4KqHHebCl?=
 =?iso-8859-1?Q?Y+5YBHG++zEq6awrLLjP02TqJ5VSysNIsSO/zLqsajsxSMT15WPtzvShQi?=
 =?iso-8859-1?Q?kuTSc0l48fpmLA8Tn64GeQl7+q9KLUhGNbGacDiz3yXPnj3RJlSn1jBH9T?=
 =?iso-8859-1?Q?JfVuS3wZoiy+shri3CDiFpQWd/apcvLaKVHjLBC2r5imuvo8ff6fHqLVdL?=
 =?iso-8859-1?Q?Oip0d4mrkFqGwv0lL1bbMwPchlgq+s9zY8udP7M2W8OUehsmzntlNvbwMc?=
 =?iso-8859-1?Q?5F6+e76YqJ0JPyYXib9hnsUhGDxPacK3q7PbaccRJ86qlRVHBqviEMec+h?=
 =?iso-8859-1?Q?Cwbx8EY8L56I94kTkkvyOVr1Hqo8rePH6EZYqvnt9jbuSBDFtsRQ90IH0m?=
 =?iso-8859-1?Q?OiVuzeYN2ms2VmP9lntZg44m9i+qOSQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f51e798d-3214-4e34-3c0c-08de54128f8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:46:22.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryPKKMEx5o8G691PekSU+bq2SR4WkLFLg8p36Xn5mJSitdjkf6vf4NUj6Yq42MiBCDwjsANWNd25JysTMLjJJMG0rpDhFu+Q/meGrE/BwVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
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

On Wed, Jan 14, 2026 at 07:05:44PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 14 January 2026 17.36
> > 
> > On Wed, Jan 14, 2026 at 04:31:31PM +0100, Morten Brørup wrote:
> > > > > If I'm not mistaken, the mbuf library is not a barrier for fast-
> > > > freeing
> > > > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > > > possible.
> > > > >
> > > > > We need a driver developer to confirm that my suggested approach
> > -
> > > > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > > > > preparing the Tx descriptor - is viable.
> > > > >
> > > > Excellent analysis, Morten. If I get a chance some time this
> > release
> > > > cycle,
> > > > I will try implementing this change in our drivers, see if any
> > > > difference
> > > > is made.
> > >
> > > Bruce,
> > >
> > > Have you had a chance to look into the driver change requirements?
> > > If not, could you please try scratching the surface, to build a gut
> > feeling.
> > 
> > I'll try and take a look this week. Juggling a few things at the
> > moment, so
> > I had forgotten about this. Sorry.
> > 
> > More comments inline below.
> > 
> > /Bruce
> > 
> > >
> > > I wonder if the vector implementations have strong requirements that
> > packets are not segmented...
> > >
> > > The i40 driver only sets "tx_simple_allowed" and "tx_vec_allowed"
> > flags when MBUF_FAST_FREE is set:
> > >
> > https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> > 0e_rxtx.c#L3502
> > >
> > 
> > Actually, it allows but does not require FAST_FREE. The check is just
> > verifying that the flags with everything *but* FAST_FREE masked out is
> > the
> > same as the original flags, i.e. FAST_FREE is just ignored.
> 
> That's not how I read the code:
> ad->tx_simple_allowed =
> 	(txq->offloads ==
> 	 (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
> 	 txq->tx_rs_thresh >= I40E_TX_MAX_BURST);
> 
> Look at it with offloads=(MULTI_SEGS|FAST_FREE):
> simple_allowed = (MULTI_SEGS|FAST_FREE) == (MULTI_SEGS|FAST_FREE) & FAST_FREE
> i.e.:
> simple_allowed = (MULTI_SEGS|FAST_FREE) == FAST_FREE
> i.e.: false
> 

Which is correct. The only flag allowed is FAST_FREE, but its not required.
If the input flags were just MULTI_SEGS, it would end  up as:

simple_allowed = (MULTI_SEGS) == 0
i.e. also false

So the FAST_FREE flag does not affect the result.

/Bruce
