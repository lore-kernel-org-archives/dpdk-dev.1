Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103AEE6BF11
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 14:33:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0750D402AF;
	Fri, 30 Jan 2026 15:33:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 44D9440274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 15:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769783596; x=1801319596;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Tdf3qUKKQFfoEvIS59eouill4rMGyvXGSRpcuNwfycM=;
 b=RUE4JtC3UYZi8rPLB33wkckdsG4WBzvnGQFinuDunZ/cgLANomEI7jPT
 zuekPb+D8u41s4lAjhSl9Z4ilaRD9eL2iAQU2WsoKoDc1dub2UR8XyZVP
 rETjhdc8hS0Qr2uRro1LTlIacW7kqx6KsFnVAS2L1n66M/62F4D7enIe9
 NBNCm6T8k8CMiVB2AV2fXlYD//R/kEuZgdhpS46sHyTM2kMWuphuvuw1l
 yruaV97+ON2h7HBw7/dgjYpvxveMVQAp5ET0544BcSimVlAuzvTqgRliM
 49ikpvSZm73OuSlvp1Q9oNJnnkK5m2DaLOTD9BCGh27rTqc5p53ciNFAN g==;
X-CSE-ConnectionGUID: D3BT/tOrSfy0kCSLnvn3yw==
X-CSE-MsgGUID: VBzS/QbqRayxl7vOrl+hmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70052365"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="70052365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 06:33:14 -0800
X-CSE-ConnectionGUID: oPWsW/gpSBaL2WD3QFfMJw==
X-CSE-MsgGUID: bmdOZmN7TQW0+28JeSBNlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="213811762"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 06:33:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 06:33:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 06:33:07 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 06:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZfX5P5HG2sqDTQaZfAw/c4vIcYTJtmbqJ7bSD8D3fWEpGVCjPxbgChUk00vzCnWs/1fUb2jBfTZZpN9lxzdmLkG3/DwfQ/HVkweCQ94wTVvryHkXAeL89p4N6EJCeCcEad6kJDwR3OSWTPqKIOMqmz2eBldBBraqfJLygmiyZd4N5c2YqfLbxCHDg64XfqEFeSipBW92oPICw455N9akVbv1XgSs/HY1bvhqd4NIacoDJe11/0TneMbACkylHwOUu05+9ak0x6oUKv5cQzKG/a546SVQX+eGfEfeV+0HiLSQLZY4DmdT5jiC8Ittap/8lASgr6YEOe8AMPORXS7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyJJGwzxJPdXJVmiGYLs2GVaadyN1f4qOwEoyw/RHGA=;
 b=ytK1TItUZrlxW7Kk1YMQWJy/1VAlWzuZ+fnsXf3u2GzMwhtudsFkeRDlFdEI5cjBsb7bDAEjwviRBYwulzdoa6iAnaCqdIOfAX+V3hoy+cW0DUJMjaVnyQu82Xn5d/x59STlLgortGYjF8eHui1aZ8mdFGIfIlAPAoaWzXGtIdEeYdMVFf4mgmlieTihjS76+0CrHTPB6OI1zSZulPTeSwQRq+n0f0y6sPvhuVME0uc+cpu3kqU5joySD/lYF6tohbzgQWupikavoomV8I0vI2Vh56kIVmE8lJWY4RbExg1hJ13ztewOAsJCTUam/WdedQHfQpDwobFuoFySIK3qPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 14:32:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 14:32:59 +0000
Date: Fri, 30 Jan 2026 14:32:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <aXzBFlU6eW5SFTwq@bricha3-mobl1.ger.corp.intel.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D4@smartserver.smartshare.dk>
 <aXyVd7BpQKR_4uRj@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D5@smartserver.smartshare.dk>
 <aXy6EQgYlugWne7t@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D7@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656D7@smartserver.smartshare.dk>
X-ClientProxiedBy: LNXP265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df80fce-5add-4a65-0f81-08de600c770f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HhPUVCPXB4SK6x+0haiD7Vab3FCnLEAxtxxiITgH1b+QOEqfw3EemWXX5G?=
 =?iso-8859-1?Q?FNXzoT7s2IgDtf5pICRxf0jAicVFAwUBxQnn6oRThU/HEnyTV/99J92uX3?=
 =?iso-8859-1?Q?q2xeqYRARZ6jQmLIkZzVmDjQOEoEfg0PGZdOO/jRQY+rEkka2xL2oKMWWD?=
 =?iso-8859-1?Q?mbgQEA/AZri1a+QTW2EO5hlF82MokQoD0ZPf49pWuR+x9I+7wxuA0S7j9s?=
 =?iso-8859-1?Q?gWi4BUIm3Ys9ul/KgKnwv9txZqpX2erW2h6GObbh8STV81ydZMrRlIfETt?=
 =?iso-8859-1?Q?9G5EPuR+107z/o+WuJxxFH9okAGPyr5BnC6+Oc/x7HQZKqZITM/SnhfE5p?=
 =?iso-8859-1?Q?Sa/bRBZ5kQEA9Pibr6MzX3mzubpN7YAcwsbXtMOgfokXoCRhv/xe/4TQsu?=
 =?iso-8859-1?Q?sROv4V/BMJ+sJLxYddu0rgMvWGuA9LjiSAt/99Yx8gr1kjMUd3JBQG54Xs?=
 =?iso-8859-1?Q?Pmio8D6PxbnKvnwxOsOUdZGbU0XNJrSllxcs/E5io4gphpi1W9gqm/uYJb?=
 =?iso-8859-1?Q?GD9ScUKQZiqWFTKVkySGdThnMtya2b1Hbn0nZ9xErwU09wGt9UE9kTe2NS?=
 =?iso-8859-1?Q?2nIthMj04BT14qf6tEijbTfLKCcnMTax4Ke2xl7ElYoaDAqvXNc5Y68/wI?=
 =?iso-8859-1?Q?bRDK7u+hnXrYldSaDQVaQBXXks8TrTiFxJc3Cniyg5LJEC8QN+SM7eC7fT?=
 =?iso-8859-1?Q?+o2GduXInokHNKCy4wWO7xfFek5wCjd1KSXBXXeD+wyda82qMM8OoZDec2?=
 =?iso-8859-1?Q?B0gGP39n3tBbou3Bb/epErBFzjf3hpG3221H065HLX/KuonzvVhI0iVzdi?=
 =?iso-8859-1?Q?Tx/4D2GbRgD1rJt0bur8teh1paxDA4fIJsY2khvWkQd5tcHl1ffpsNToH/?=
 =?iso-8859-1?Q?hxlzUhAQ8tm5uKEiiKqIGkmLArZxjxtqHyLEyW2BwtKWW3jerPTDtfIiGK?=
 =?iso-8859-1?Q?1bEIxLYW02U4FDiHyfoDZY95R8k2I62emXUtNtKPjFmdaXzwaUvPK2zp8H?=
 =?iso-8859-1?Q?o+qhSJJb1MX5j73HXoqUuc+vd/Bk/3BaUcyXtwqorNEj7RJPsAQmSVOc03?=
 =?iso-8859-1?Q?dJ0RiCO3HJTNhFrzbV9b9E0c7LaIMzGRBQw6qO43BR/YpL9j+UceAEPySs?=
 =?iso-8859-1?Q?2RSqOQe+Wmkgp6PBFqIGt061brBTDuMVesXJM6/Nc08wkNtPVLSHngLQza?=
 =?iso-8859-1?Q?K5+t4Ta0mLIZv9p8FUR5J5UZqce8xeAd4E8oZ2H7O60GAwCHQqCPnw6Jt3?=
 =?iso-8859-1?Q?bB0lgjTQE/u+Qs5UWsq9Ldvqhwc45sc0ilQLop2AKttyGp5Fzl1/ZWPXT6?=
 =?iso-8859-1?Q?cB1hLP+2fU+th+boz15Q04qD8lzukagYyyF2vy4zHoO+DG2bP9nu0PA68w?=
 =?iso-8859-1?Q?oj8KssOOrCZ2J9ObXBs8vUoejKcdscYqRyhpGcOJ7ZZYBBHyjGP3RmIjHT?=
 =?iso-8859-1?Q?ENFuy7TCQgFz66gQxbiXwwMhpqsCEurbtPoOk2YfnwnlJqvXhIeICHVKle?=
 =?iso-8859-1?Q?cdqNUhdggUeGSZIkxKV6R6z6F/JczmNsgwl1AhE2QG1PL8myaNIaftRzfY?=
 =?iso-8859-1?Q?i3C2Png1X2UkDmdEIFHvZJY4suDO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VrpfP76+AC1Jeplorwy/14klrtIQVOOhohH7f/BgMzQVohHkEB0XHa9mAP?=
 =?iso-8859-1?Q?Az3nGfwmROc2e9DFPBJUS6pfHs6EtxrRT43F5eF4fnmoRfhs5F90cOaxi6?=
 =?iso-8859-1?Q?qvITMCnOrapnj0yVshspEvpl1zIofXJcPn7jfT20eixNS9eVTKphfcr8nv?=
 =?iso-8859-1?Q?/f5oO227WkDEIgbbtYzc1u/u3o9aReEWc0/a4PgTHYpxDM2z1je2a8FK/G?=
 =?iso-8859-1?Q?B0HFLKTbe/ShhExTFiBxRxbvVdplRtXeVUWaU6xs0pdXuqvJU6pPzckvb5?=
 =?iso-8859-1?Q?sivh50ngjO0TD+305PK7gElM9DiuM6l5G7j2mdBP8gO9ke4qd9CZXtfMoT?=
 =?iso-8859-1?Q?aNkLGZ0g7P7zweSrlzsttvPg7y/ZH2n+dLPa2QY+lGA9M3uLBR0WD6MYp5?=
 =?iso-8859-1?Q?Ad5gtc0E7OHW4lbi7uCAIo/iAxJ6qzrfNfOt+Pmnq1r7sdvjOGEKabuzRr?=
 =?iso-8859-1?Q?ebbQAyYnYd/To+LqYGiDvbLS4fkQCtV7c/Lay274BPCObnpfGdq7gfDl9a?=
 =?iso-8859-1?Q?2K3zbcEYS/mEW7vNpYDe2ceYGjhvVrnU9spxEgTnWfFwGsU3+5KMZa3ChY?=
 =?iso-8859-1?Q?Snv2U+/qUzaXOMfwk7tPZeZmWNglQHukdEVt6u3ol+PXSg6zRlmEaoeq7J?=
 =?iso-8859-1?Q?15iSbxKUyk5cNY0irpxuS5a67yh/LdkBbCOE0/ISPdBPWQJKppJqp7Jl5W?=
 =?iso-8859-1?Q?uut0R5sF+s7nEUqWIX2CU625pcY9/z0iA5y4TZZHKVix1oCSd13f1P//zG?=
 =?iso-8859-1?Q?7I8UhwhECwJRIiUhGWh4QhMxl/8JdMZaSZETwrJP/M4xw9c9bZoPeF6WBt?=
 =?iso-8859-1?Q?sEkOoc6lMRlHf7jtAHMLH3IDOIjePYpeEE2OnrwC06IO4131/0qc7WqiE7?=
 =?iso-8859-1?Q?P6yMJ/WF+3EvfIwn+Qy005aH3c3wDRWQtp+KXKTflKlRckuIRn1eipBQF4?=
 =?iso-8859-1?Q?gqi0V3qv5aLkPhYb2vqUNZFAYH70i6Mt8JnydnyMf/WFmTqdY4T18exQ7z?=
 =?iso-8859-1?Q?n3Gm1A5qCG5EyyRGhika+rW23eJBYb8uFJ6zeQNzzMpuq+N/Bcaa3BwqCN?=
 =?iso-8859-1?Q?7K3M7wmFmpmigDLDfyTm0C3qEily35eI5rybCCVlsI+sg3CqQt89h5Ah2N?=
 =?iso-8859-1?Q?jIY2i+y+9w/qVm1gaA7vtL93DR+qAF58AeaxzIu83bwdWGm1Wdj7Ki1Sdr?=
 =?iso-8859-1?Q?wv2PnF2VFcMks6b82bW50DlMoawuSPWE+VwPPJKqmTo4vPbA3+6VrHv+1r?=
 =?iso-8859-1?Q?a0rPJl2pKQc/1ouB4EOX0XUr2uAx2JPAvX10CrdOvs+BYAuqcXF1CjxE8+?=
 =?iso-8859-1?Q?0pnU7gPbmK8QTu5OTpqNcpS6bCPCObd4/Z1ns3eYgAy/Tzc/N59ApPW3jl?=
 =?iso-8859-1?Q?tlvYTxrSFYDC44zhRhtfV7EkBM1K98m7Qn53aG7S8cJxi1IEJ+sd74CJZm?=
 =?iso-8859-1?Q?eHV1bggb3Ufvr+sXBat4LgMST+nMw0CzwgZ9eePvimzONymE7Jb6I4QdRX?=
 =?iso-8859-1?Q?BngHanSuq1Qg9/WNK7D4zxgKcPH8GdOpjqeTPFgUaA+NVY3jrw3/ofEJCU?=
 =?iso-8859-1?Q?opHOw1PWCb1aLS7TuwOBJB02/uC8hXCiF/RhTMkUF+WR9S016MCXTcG5On?=
 =?iso-8859-1?Q?ALTWBjyOQohNMN0DZde4FikpBpSov/lRTNurH3WUAJo+olnoM/lmY86AQE?=
 =?iso-8859-1?Q?7xv9I96g83d16Jg6q9KY6zdH7OjgMSCNmgWmWHSac+V+Dgtg9IfyIKlpkH?=
 =?iso-8859-1?Q?vNopo9USJZJ0A71Y/Uo/VdIzfo8g+xnj4q316bZtiIufvmYtb/uCoPAf/1?=
 =?iso-8859-1?Q?GxozOcrak0/MLNRpDvdf3pxNxR8cmH8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df80fce-5add-4a65-0f81-08de600c770f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 14:32:58.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxpGxQ+/NakfVgvhr2JXIRQFYA0vh0gr+GrnsfUrSEA14RJPKCelPiOFoNXaZNdwfKSJNgAhF2iQdOP7+uz6DvMpRFX9S+TQOXc3L/MOymg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
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

On Fri, Jan 30, 2026 at 03:25:34PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 30 January 2026 15.03
> > 
> > On Fri, Jan 30, 2026 at 02:54:52PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Friday, 30 January 2026 12.27
> > > >
> > > > On Fri, Jan 30, 2026 at 12:16:43PM +0100, Morten Brørup wrote:
> > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > > Sent: Friday, 30 January 2026 11.53
> > > > > >
> > > > > > On Fri, Jan 30, 2026 at 10:46:16AM +0000, Morten Brørup wrote:
> > > > > > > For CPU architectures without strict alignment requirements,
> > > > > > operations on
> > > > > > > 6-byte Ethernet addresses using three 2-byte operations were
> > > > replaced
> > > > > > by a
> > > > > > > 4-byte and a 2-byte operation, i.e. two operations instead of
> > > > three.
> > > > > > >
> > > > > > > Comparison functions are pure, so added __rte_pure.
> > > > > > >
> > > > > > > Removed superfluous parentheses. (No functional change.)
> > > > > > >
> > > > > > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > > > > > ---
> > > > > > >  lib/net/rte_ether.h | 19 ++++++++++++++++++-
> > > > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> > > > > > > index c9a0b536c3..5552d3c1f6 100644
> > > > > > > --- a/lib/net/rte_ether.h
> > > > > > > +++ b/lib/net/rte_ether.h
> > > > > > > @@ -99,13 +99,19 @@ static_assert(alignof(struct
> > rte_ether_addr)
> > > > ==
> > > > > > 2,
> > > > > > >   *  True  (1) if the given two ethernet address are the
> > same;
> > > > > > >   *  False (0) otherwise.
> > > > > > >   */
> > > > > > > +__rte_pure
> > > > > > >  static inline int rte_is_same_ether_addr(const struct
> > > > rte_ether_addr
> > > > > > *ea1,
> > > > > > >  				     const struct rte_ether_addr *ea2)
> > > > > > >  {
> > > > > > > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > > > > > > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const
> > > > > > unaligned_uint32_t *)ea2)[0]) |
> > > > > > > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t
> > > > > > *)ea2)[2])) == 0;
> > > > > > > +#else
> > > > > > >  	const uint16_t *w1 = (const uint16_t *)ea1;
> > > > > > >  	const uint16_t *w2 = (const uint16_t *)ea2;
> > > > > > >
> > > > > > >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^
> > > > w2[2])) ==
> > > > > > 0;
> > > > > > > +#endif
> > > > > > >  }
> > > > > >
> > > > > > Is this actually faster?
> > > > >
> > > > > It's a simple micro-optimization, so I haven't benchmarked it.
> > > > > On x86, the compiled function is simplified and reduced in size
> > from
> > > > 34 to 24 bytes:
> > > > >
> > > > > 00000000004ed650 <review_rte_is_same_ether_addr>:
> > > > >   4ed650:	0f b7 07             	movzwl (%rdi),%eax
> > > > >   4ed653:	0f b7 57 02          	movzwl 0x2(%rdi),%edx
> > > > >   4ed657:	66 33 06             	xor    (%rsi),%ax
> > > > >   4ed65a:	66 33 56 02          	xor    0x2(%rsi),%dx
> > > > >   4ed65e:	09 d0                	or     %edx,%eax
> > > > >   4ed660:	0f b7 57 04          	movzwl 0x4(%rdi),%edx
> > > > >   4ed664:	66 33 56 04          	xor    0x4(%rsi),%dx
> > > > >   4ed668:	66 09 d0             	or     %dx,%ax
> > > > >   4ed66b:	0f 94 c0             	sete   %al
> > > > >   4ed66e:	0f b6 c0             	movzbl %al,%eax
> > > > >   4ed671:	c3                   	ret
> > > > >   4ed672:	66 66 2e 0f 1f 84 00 	data16 cs nopw
> > 0x0(%rax,%rax,1)
> > > > >   4ed679:	00 00 00 00
> > > > >   4ed67d:	0f 1f 00             	nopl   (%rax)
> > > > >
> > > > > 00000000004ed680 <rte_is_same_ether_addr_improved>:
> > > > >   4ed680:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
> > > > >   4ed684:	66 33 46 04          	xor    0x4(%rsi),%ax
> > > > >   4ed688:	8b 17                	mov    (%rdi),%edx
> > > > >   4ed68a:	33 16                	xor    (%rsi),%edx
> > > > >   4ed68c:	0f b7 c0             	movzwl %ax,%eax
> > > > >   4ed68f:	09 c2                	or     %eax,%edx
> > > > >   4ed691:	0f 94 c0             	sete   %al
> > > > >   4ed694:	0f b6 c0             	movzbl %al,%eax
> > > > >   4ed697:	c3                   	ret
> > > > >   4ed698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
> > > > >   4ed69f:	00
> > > > >
> > > > > For reference, memcpy() of 6 bytes (compile time constant) also
> > > > compiles to a 4-byte and a 2-byte operation, not three 2-byte
> > > > operations.
> > > > >
> > > > What about memcmp? Does it compile similarly?
> > >
> > > memcmp(a,b,6) on Clang compiles into something very similar.
> > > memcmp(a,b,6) on GCC compiles into something with a branch after the
> > first 4-byte comparison, with the assumption (regarding static branch
> > prediction) that they are likely to differ.
> > > I guess GCC's counterproductive behavior was the reason for
> > originally implementing a manual comparison, instead of simply using
> > memcmp().
> > >
> > > BTW, GCC is clever enough to compile 8-byte and 16-byte comparisons
> > into code without branches.
> > > I guess that's why rte_ipv6_addr_eq() is implemented using memcpy()
> > [1].
> > >
> > > [1]:
> > https://elixir.bootlin.com/dpdk/v25.11/source/lib/net/rte_ip6.h#L68
> > >
> > > > Before we start adding ifdefs
> > > > like this to the code, I'd like to see some measured performance
> > > > benefits
> > > > from it. While the code may be 10 bytes shorter, does that actually
> > > > translate into a measurable difference in some app?
> > >
> > > Excellent question!
> > > Some quick rudimentary testing shows that it seems to be ~4 cycles
> > slower than what it's replacing.
> > > Reality beats expectations.
> > >
> > > I'll drop this patch.
> > >
> > If you have the test-case already prepared, can you also check what
> > memcmp() performs like? Replacing the whole function by memcmp and
> > punting
> > the optimization to the compiler would be a nice, though small, code
> > improvement.
> 
> Good you asked!
> 
> While setting up the test for memcmp(), I noticed that I had been testing my improved function without "inline".
> With inline (like the original), it's ~1 cycle faster than the original.
> I have restored the patch status to "New".
> 
> The memcmp() test (not forgetting "inline") performs very close to the original.
> 

If memcmp performs like the original, I'd be tempted to forgo the 1cycle
benefit just to have the shortest simplest code.
