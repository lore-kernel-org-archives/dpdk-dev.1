Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC382CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 08:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BAA4021E;
	Fri, 29 May 2026 10:01:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B5971400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 10:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780041709; x=1811577709;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=B90pZ2gA/t6YOxdvojhlxh9jyHaaCCkHfi0qWfpSyd8=;
 b=BY7DgyIHytSy9YfTRZcuRduWdLxkAs6q0Siom5uit4GCVG+G/I3hLQeK
 DnuY58K7VLIMoTxFbe+1mDUyKZbQ0sgnH6qWD2Vydv7ZxoO2iTv9NY7/u
 6NXUbEffKPTPrhkWmUTFKYhG3VGi9Zi2GYloYpjHkiPVdvA9yirS3Twpq
 FutI6iGeCzzYhGLrn36AJCim627VRK3L1IcR4dbDvCrUrBjSs25UKzMoB
 BJDZm4QINmMe3wmUnzsU22j/yVTyyVNyVXymQwMz6f9SkNpijbsQS/Au1
 Zmrz/cDwDih0KXchFm1JPkF6yCWrT3IdfN+Ci9aAv0YwsKCYm24ynAn8G A==;
X-CSE-ConnectionGUID: fHh8kSEnScqTPM5GFm2Ihw==
X-CSE-MsgGUID: HjGGfNxqR7GXD95DX8yTFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="98306750"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="98306750"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 01:01:48 -0700
X-CSE-ConnectionGUID: T5/xmK+jRQiNetOVLZKlJA==
X-CSE-MsgGUID: RzpdBFqDSquY7oZP0/k3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="280904588"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 01:01:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:01:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 01:01:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:01:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpihWQ+SPpcrwDFvBERSCjPQLyFuunoAhVn88uEhloC7j+WmkjzWw4bbrBb/FwJHC4Ogbs2fBPPcwiZQHSVszS1ct2VnNUEJRwpIlJpJ6b8s8TV92kY5H2ThK4MHYRlFkL0K11ZhPBcasL0iKiZTVxKymqD6djNbCDPTJdZiJXWsfeUt2oTCunymwuux3VrpovzNAvffZgN3KXczQ53HGsll28MuU6e2AB4YTQ9jqSCCppJ6umHLjyAUbM+A1y3tyI/dZtbXbeg3ovP7NNfr+MEzjAAdJc+SOlFZfLjPy7UvH+ewgN6GI489WFDpsMxi/8Pgqbd5vrtWOB0wbjQZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L1rXQQoAn1zKmuZ+l6IO/vyYJJuYl1yFouDlitD/SM=;
 b=qAd9UQv7qM7czsEz/Ze+Yh/IvJtDXb3vH9h7rX2fq83cwgeR0EKkOBM/OKFrcC8f9QNzEzHEZidJWztGgpaYMm/JHvPLVuZx9zx0RVdsDsC0EjmGtQTk20SSRvvCLff0FJNQabU5u0fdrbJGj8lLZ+vIV/MxGyLJCesX7xmqNnG1BmdUXxzRNvC6fjUiykh+VoY2vL+22qG5+dHI+p/dfY212b8v6Zscse0BLmmSNS2Ww4PMXesf0wKDZFTLiYfpoGUaLr7MSasiiXn6OkOdWFGM2EVJ/ycXlke66m3A3mav8/PAcchBWKZMy9p6MRRuh7Z4ZIhdWz/Nw1+c5bSZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:01:41 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 08:01:40 +0000
Date: Fri, 29 May 2026 09:01:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sudheendra Sampath <giveback4fun@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Sivaprasad
 Tummala" <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
Message-ID: <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
References: <20260528190449.66254-1-giveback4fun@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528190449.66254-1-giveback4fun@gmail.com>
X-ClientProxiedBy: DU6P191CA0061.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::14) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0fcdfb-9f14-46da-7b9d-08debd5883f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: NVxnbGQcC6HfRnom83UIWsMx/tdlc6ghbK/een9O1dL0FI81K1yNwHFFb9AyalcMAVDtenKf+KKgnFLwI674osCJ9U6UOfvt/lJtIA/59o9mVZsTAt/rdgIka1pfadUi3XKjcFAuSIU5AQALlsM8tTbcQOWxGD9Z8/2K4R8cxSCN1+rb5ptPH+b88hIOJ3VP8q9D6wlk2eG4StYf4oYQXEjXLdyBDuzMJ+pGopXpN+SqcQ3M3p/Fni5vBmkQw1dgq1sJY8YrVtD/PowoGjfkx9HDJ4guka8IcGatLWR+8Nu4RDtQaukENilRIEpNP6gP36wSr6Amzxt4oPBZsRb8FRDPrxxXLuQndJ4yDAasCdbbs7BYXkYDB+OXBmDG0NcP8HOQ9DU/On7L49nKdPx34JCkbAVtDtZFI9pePD7ekBGWuk1k9eqGe13R1dyjH/NjedgbO4Q/f7bKDHqkeDemrvdltAqi10Mxz3ehJeT9jMC4uqKCE55wUUnKThTnSW20ad3BMR6CPfonEAvNghRuIQR5TuhmIiIhdmCl6VwE5StfyAxxhCobrjctoz35CtaPoZsNVWYZlsqQa+1rvpKR4I7FTj+0PxC2j3q/4ERXg3OJAiSoVStH59Kwu9DmG1qXitOaO0gFG1Rs0tg07PAEqEJhwzVNbR1dE9KN+KjaYTeMlCHHChOXVKgzGzV/lmpVmB32PmvExTOhZ/U/sDW7RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LZ6/ufgCMgUGVsyDvJgi8Ctl2Omf1U19ls21AzYwZOCuHeSJHMqbls0Uw3T?=
 =?us-ascii?Q?6Hj1y4pM7I2dZoIDr6WKKjPn4u3e1+cpsMysZXYHd7A1HA1Ds0Q4milqzW/o?=
 =?us-ascii?Q?K21JSChmM0kCJYPMD+jlB44kyZKM+m309GgcghJFKFP2HEVT0/O06QYnHiog?=
 =?us-ascii?Q?j10Fua6fUftKuBKP++FZww5xNf62b2us1sSmu08Z5fLgMjTp7s0bOR10Yisa?=
 =?us-ascii?Q?JtA8GOQu7PFw5lrnZWnm5bttNVsHsOu2x6XZluclg5Q70rufx5a9bIxEb8Fy?=
 =?us-ascii?Q?XbrNI7jeeqW3aws2iPQcuK/KfgnANn0lw8XF6gJqr5XRqIBVgiLWFNNaOhSO?=
 =?us-ascii?Q?h5vN05UV7oEdVLX/hbN+VFvCsNQAsdnD2pQD/K73/VxuastIPQfkzGW6JmMw?=
 =?us-ascii?Q?iTQAkdaFgU5IkmAOT/ZObxSjLnpigNHjElw2NtdSRA3Vz5BkorLCNfgx5zSx?=
 =?us-ascii?Q?tdVW007j0MajWEteoTelYAQKL10PWzWPcJ5eh2SXYTQGs3zuk6kx8maEruNG?=
 =?us-ascii?Q?Are9JloEPFxbia116TPPywMcQL38PmYQM543syOn3S2gC23x5brRxg7ufuUG?=
 =?us-ascii?Q?Haaxnz/63ep+/5T+rBqHaAnSlPVW8AdogMT6/05HlgCEIPB1PL5PsRgWvG5O?=
 =?us-ascii?Q?qiLosNgj5ptg0YQSSF200CDUwhHEMm2CDqYyfMcNeY/Aj0i9xEl5vCSVlM/N?=
 =?us-ascii?Q?sp72FeeAo+W+K0QkjBpgjBjqTTUl1bJAjQYPCv5awgihjQoe3uAr7IF5zRb5?=
 =?us-ascii?Q?68jLiFnn49EZK9Xo7QVBqA5x8FkqCCX4n11i4vMscAZruDMb6KH6xZEKq0GT?=
 =?us-ascii?Q?7PFEg3YExBfrjJL6PF9aqmsCCH5PECy9tiwzc3i6PDYoi10N/lZGwqL6wDBJ?=
 =?us-ascii?Q?sfWWEru1oIOD9Kdr6IyIG+tII2IHhcLkfVpQMKjbUb2igU/rTf7v+0+1eFX5?=
 =?us-ascii?Q?iU+25BG0Hi9r6aEKDzfGodyoEI13n/ikmxt2yHrMOorWH0VI8eq7z3Pq+l2C?=
 =?us-ascii?Q?LAyn+dCj7xLeMsX493R+Uwb9xj59cNsIqJ0hmeInS46FEbiwAAlIJtYpYee1?=
 =?us-ascii?Q?nhRfcF90rsdKl/CXB5OLRUuI7E++gTnFlQu++SHcNaya5+1v8xXfkK5VqDic?=
 =?us-ascii?Q?obAHCODLyeRe7G7U8OyObO3N4IJQWJSRjj7S9NJQN+s0O3Ddc3TKP6Ou0plC?=
 =?us-ascii?Q?fpUUyj9+HkC7We2fkmnL8FFgTpU0ng+qD0q96nO8pPasIAObk/+UY6AA+Nq1?=
 =?us-ascii?Q?5Hma5XfqDanRkuKGvydMYnl+tJGfLaY3jUo4K4XNtU4kgI19NZs94uvD0Nqv?=
 =?us-ascii?Q?SPbgx+QPflIjrrVTBWZFt2aVVaSS0ocTm37nkrJ4hwccAdt5QCEAVdEY5Bnv?=
 =?us-ascii?Q?rZ9B9YMct+s9VvlgE2FPUMKGit1F3Jjh+2tGJupGmIVykRjCSiI2MBKYRgK5?=
 =?us-ascii?Q?57mL6TfYYr9h3FLrsNJXujo9pJkkp0lVSQhlWHv6QYwQbW1oM6pO991KUuN2?=
 =?us-ascii?Q?wUSbGFFN65PKJYQxuTEfMgEIpJLW7aqIc71q/Q8FN5ubsRxh1llFHvDyICbE?=
 =?us-ascii?Q?mQ8FNJ1N2sEwCtFs3agB6Zp+iuVLuWubD8pcObp41joIwpQdC4dT72QvgpJ8?=
 =?us-ascii?Q?Lf/zcu/E5Cjb9X1al1o6b0D1xOhgh8Ac69Tm3062tMecPb9bKxxGoQXAkZqm?=
 =?us-ascii?Q?7CVdT3C0A2hvBaLvnCf0KQ+oH7Qw/mxcOM6anifhiTsF0Vr4IkU9YImwWTtO?=
 =?us-ascii?Q?zBdQA8UfNZxifMKayh3Agt04sfgnVMw=3D?=
X-Exchange-RoutingPolicyChecked: IIckA2z/vGeE74nkYQ/xVAtBWuBjGv6NNN6OF6WrDCK0wtmHnYQ8brvLRxQPzRosL3vT39XbX58HfDaKglDkqFOGDol/mHK2QdF5VbPgP46w87hJNhEots0o2naxCgzeuyGpOMT9yfWwLL5JdTxkGzldT5DVqH99xw8Bznn9lvA8LnnIbB/qpNVJnUx1/sebyJswiR9U9YuPi0mTcNNH/WjqZJsJv1/W4tuxQXKc2imH74QunYJ0bc3pTteeeaXgTXypQ8Opw63Iqbyuh/1JxBVn1GC0oQ5A2nCVMQxBjH7nREj6fyy72En+JJ5fUYZlrQVcq2ZhTnk8om2t2pSDHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0fcdfb-9f14-46da-7b9d-08debd5883f1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:01:40.4038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYgO8lCYR8hhdKdgfG39GpjpFUJJZDR6bHS4AFSZvn3+tvG07M+ADyJMNLQqp9NAuppGHJBp2l3q9+7Dmmg6bu4/OvRX/AeYV3mWZSSt27w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
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

On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrote:
> This patch for bug 1832 will do the following:
> 1.  If /run/dpdk is not present, it will create it first with and
>     then create powermanager directory underneath it.
> 2.  If /run/dpdk is present, it will verify it is actually a directory
>     before creating subdirectory, powermanager.
> 
I would suggest using $XDG_RUNTIME_DIR for the directory path, rather than
hardcoding it by default. If XDG_RUNTIME_DIR is not set, then maybe
consider using /run/dpdk. However, rather than /run/dpdk, I'd suggest using
the normal runtime dir path on most distros as the default:
/run/user/<uid>.

/Bruce
