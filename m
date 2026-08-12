Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7145C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0359340298;
	Wed, 12 Aug 2026 16:18:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id ADBFC4025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 16:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786544324; x=1818080324;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xZ/Gb0J307dWa6Rsq06ykv1wME+TbYc7eSnQ1vX0Ni0=;
 b=RXQPseM5dBkL6pvMwGUMm6l9hhH8cadm2AtRYepocVqgXHjG47ZpUFQ0
 5W4lcd6l4eohcF0sXlzs2WNU9yjBLSm+U1xhB2cKuVon3W51TxQOM3QoV
 RqXmeQyZYxbzOg5kf6NInDwiN5wJxb/LjGyyMoxVrEXBzgXXtIkYsXPBp
 wSaTSP+28eTu8ObdccfHOFG8Q7HK0wYP0AEKlEzcvMShXekdRISrqEPus
 TP1CBxCpK6jyQhILpfqLHA32fgilCQhWLm1WQYvtzMPg1AWyHubBGdSdZ
 zZJ6hOhmLujjzV4+HPZMHEkjhgCk2FrmqWKsM/FFKgD89apnTSdtk4DuN A==;
X-CSE-ConnectionGUID: 8hnceb8eQ1SRpuivrxUEjA==
X-CSE-MsgGUID: hIaQxh8xQxKk98gYYzIe6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86866922"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="86866922"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:18:42 -0700
X-CSE-ConnectionGUID: 3e9Kbvs/QIiA0EL3JqJxig==
X-CSE-MsgGUID: fITQDuGPQM62AFpnAi9FgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="301904256"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 07:18:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:18:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 07:18:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 07:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFvDLsiPs/F5w6syU29xJ0ODogdltjHJMbZfmX2xIzDkzGGcazr1Urh1PgoJ4eg60eWrIRdndCi9atyMJA82wMigo93X98AdHbUwub4cHVLKWsuQxHZB7K6VE8ameWbAZsayuOksVzFkjnd6f/4f98BM5lhpxwRbZAHipdeOgsT1GHNBIQHBEbUsAIzn2z/HIzqh3QpAiLRX/K+KOZjFworRkeuAfzawOz+3fmGJAA96/MgukioayRrzGzKD2fLTg/PCancl7BVGNUq9JDHDV1E6xr5S2rCrOsbnm+MDGbdkPIseDNepptFlh8GpygPDe8qil061iwGafLRc7i3D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh7X9nXiXLotmH/eRg/2w/NKP10+1GLK598L4PABntc=;
 b=ayThZedpKIU+Ire4+8H8XgcIPFI7mLt7n4YIkrrNI/iv/MAKSaDJYDc9ajXrvol7IgdJRMGQ/C+W9QJ0gBPJMhLOoZTwelE2PnwSUpClRH7A3S/pqEKB60lQR1I76nOU83J0JrNOPzWyRyZjsf6k7lqGtwB4+itFxPDBFV2sUU3wePDw/k9qQWr6y1MNd1Wl8o/Iiy+FpwtgKVEnDK1owXZCxTGdX0txuZ0560SfteeqPy9dWoUfu1ltJ1IWnEYY1uw+qscXgFuPVK/ToaWJ95fB3omUex/M/cJkJEOe5woNhgXUzJ9Qs6GnQkWlPKLaQjP4ZomGynXgkL3eIUqR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by SA2PR11MB4972.namprd11.prod.outlook.com
 (2603:10b6:806:fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 14:18:38 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 14:18:38 +0000
Date: Wed, 12 Aug 2026 15:18:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH] pile stack and mempool driver (resend)
Message-ID: <anyAuXuNRYbeyD1l@bricha3-mobl1.ger.corp.intel.com>
References: <20260801065358.981232-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260801065358.981232-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU7P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::8) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d90585b-304b-406b-07e6-08def87c9a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OAxE0O5xL+dHmHF+TiQO+ltu8cmyBpJbIchy1rSTnqPTpGeOoGNwfxyZordmXYWOVhw/ngaxKSc8buyDiePE4D7ZWVckTRAs6Cx44fa5r92ar6nsf5uadU7f5i/BlW3V91ORdxLOSO5SPfrSvryk+ap8VlTcA5mcOU8bQwKTJ83Y3eO06KNF/vfqzJ5KxVxVqx9MYKTk+O0IdjX/kDYK7pXQe38SReFirJUEyxCqST8phPVFUQXsKrOqZovM898ilnB/9IAxsYAWPaq/dbltlcDv4KhDTbxq85OfoKAOEJdYgYTya/p1Ksqhl3DVYRJV2msdYsvz2QTIrZHhJ1lC+a0UUD7EkR2gW2c5GXRDGMlzL3LCy2vtNhLSTL/65AsdQnA2rse4T8worUoUEwp58FKx+m/Z9J2vW0BVR9uCOtvNWCXzNstRpg5tTuYFbbrn8CxKNua/3BUwEXDXLyMUqz1allhOjfXdYJzpYj9tDWhHtglsBeDMx0vPMKadczHCQOUrY/6inpD2Bvbl1LvClZ4pZQWMIZZMsLhHbTqXjle6BsLX/SAIrftjFSDF59WVWDP6JKWfKRh0e4F8RrgK6+befoNsgA40U/Rx1VMk0q8weMr8qVhh4tfnpzhrj3q3ODRCUJXOAVYePIUnJE9OUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?r+KFDv8JLTGdRm6Y48ue8P8Jl0bHU+M0qKwILk7era8uqaxTJp70uQYnrr?=
 =?iso-8859-1?Q?3DyPioeTHnSgpK66u+l8fL3Mj2enF+cVmBjDBhSrFoCLQ2Fz+e5t2YxgfR?=
 =?iso-8859-1?Q?s7Z+c+ZxoXCw9joqH+NI8hPrONkFMBRklRW86KHCpcSb8Mz4hzOTuPR/AR?=
 =?iso-8859-1?Q?1hNMJ2mSG9mHF5EDpeqo7l+VXny61N5TXR1Bus6NJdMbmT55R0k8nqy/Sp?=
 =?iso-8859-1?Q?5v5jA9njN8EtyRP81DzSR+EhLTgasAez6KlYpGCywE9X5oSWDiA4jsEoME?=
 =?iso-8859-1?Q?IVkBbg5vjTzZoiTFlLLtvKDrXRc0nHo6Aa05WHN9MQXE8vQzqDHKomZllv?=
 =?iso-8859-1?Q?aNv61aqUQzcAGLn9yyEZ7+EV6i607yLVbtHVfFV5w84LYu9AcLmlOATNEo?=
 =?iso-8859-1?Q?8BpOlIySGcR7i5vPrA9huDObIwPx7KtRHWLufyFewJgwmA5Xkgc28wHuFJ?=
 =?iso-8859-1?Q?AeNMYLGsq8/Dlm2uobFkpynRU4aPcXNXpbkVSZMOG6n48Y3Pmi6JC4ZVM7?=
 =?iso-8859-1?Q?vFRHPY9VB5af8c1NRKGEnTXySHoeJmuQyIo93eeF4dlTUec0FMIlh4jOF4?=
 =?iso-8859-1?Q?KQ7L6pIo2Quu1grCqL+OrzQSjiMe/x9QTTYbvJ2CZPboXR5fVmTUph/und?=
 =?iso-8859-1?Q?4xwxzZYieipa2gRvBe5tP2up9oss731VRYdjhcwP0A69cJEqPgUrql74Zc?=
 =?iso-8859-1?Q?ct+quUAqEr+wCi7z8i6/Q34flJkulGBcvPEQAc9w8fn+QEx4zekSs+6ncE?=
 =?iso-8859-1?Q?9GLaLISGdWRgBfnVODsRLHCGNxR1z+fnSRyPRTLSUzBAB6F7YZSEByAuF+?=
 =?iso-8859-1?Q?/nU0uzQm+j+WIT2Mge8L/e+wMDITOdPqUz7iKJVF1y7pwTABgJuNSHntCv?=
 =?iso-8859-1?Q?ou3q8Of8q3jBkPH7nCv9X4r5OP5M5PtFd2uY3VBGHpvm8CQJUEEIB2EUe2?=
 =?iso-8859-1?Q?X9N7sbkKnAMYwL0M57PBlCUF7aKm4h+p+O2ZMbZZePw5SgLRBZ41mEvweA?=
 =?iso-8859-1?Q?REAcXOimP3DVXIKI6lqDceiCTY+YZYnU2Ip5RrbtnfivywJ8b27spfH+r7?=
 =?iso-8859-1?Q?Ebz4n6YsUEVUjygMeBsBTvJGvmqDtmPOZXTBf8qPSFg+wA6OSl8e2ylrFD?=
 =?iso-8859-1?Q?Jp8PqGj9YqdVsq0pHT24Ukkrqb5P6EXR6yfCyX24Z/APWjuItLEG+JvQKz?=
 =?iso-8859-1?Q?lroC0g3lzqk2Hr3qlFxclalNUUdsAQQGaNPvPBvjvaBjuigPIWIXA0lu7w?=
 =?iso-8859-1?Q?gN3fb0eL21vbjtUCpK3lF08s6ErK/fC2I1oCdx4rqyuVvCGD12aB/5qK0g?=
 =?iso-8859-1?Q?Rk5fr8iDHFVi8oGCUnQx+89hCER5YViZUPKGt/ICf2nH/v8tdVAWDTzP8j?=
 =?iso-8859-1?Q?LTtzqayAaD4LMbhi5vzuT+og4pa5dLrV+XgJ/ucsYTGrW84tKrDkMHwWTs?=
 =?iso-8859-1?Q?Q0+3Y6muvlKEWHLdSe9EzOpa9xo6OnlRLeXM6ZvszRz59YLK349Bi3Jxa6?=
 =?iso-8859-1?Q?sHUK0hC0I+ef4GqEhFHvoF0CB7L1PdO8PZ9TweX78pK+C16b19yucL74dU?=
 =?iso-8859-1?Q?1LfMvYLhu7JhNjeJh+/1rHPj71gZplLgTlB9+k7G7NsS2q0/4VCMNPONhn?=
 =?iso-8859-1?Q?bvg47YJx7xDlrfVRcExPumBN9t3bOpC2fBlRvjQK5ZSrZd3gY1SauHHJKk?=
 =?iso-8859-1?Q?ZZqvWyX9o4IKXvIPmUgS6wKJYxRKRL15D6X8gcDusUph0AhO+k1+v7LXGS?=
 =?iso-8859-1?Q?tAxdfZ/LOsZBJjDhsvfGK3SC99W8Y6rAXoX1RJkXZYupujJKGin/+pULvN?=
 =?iso-8859-1?Q?bTicK1oBy8/NTzx1p+iEbY8/POhsk5A=3D?=
X-Exchange-RoutingPolicyChecked: DcjDQQyw33HzQdiLWrEK62ntjH5dlJXxaEinNt2I2JdZqts1dVgvua/6xX37mCtcLKbtSi259CRundjpwfDNVgzjDQyECzJ/pY8k/5s66muIza3PR/8D/J8Y82yt0k4pLN0D9JNMGORsONtReJrmMxTVTS9WxCRTR9ejTxsxdp4mMm4y+VDuRpZoB4g3w11zY7S/INg2i7LrqMXiXmGNRGjU6N7aKcPbnN3Cj3xTKfnJq53Sb4xwzT26oni21MUrR4HVonw6L9a9o5uHHRayEKRImqQcwm42nPRDpVLY+IeNQNlxkuYmzOMwT5ErhoxIhIP3OvnrskWnWL2dikpcMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d90585b-304b-406b-07e6-08def87c9a52
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:18:38.4982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sJhmv8xnFky5ZRLr0cWKHDr7lXt2zohcW+Zl/uXsnvtXRiHYUB4e4hq13nHH25qWCbMlPn0K84gJJSjxKVwI+6TDRzh7MQttxbgN7TXFV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
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

On Sat, Aug 01, 2026 at 06:53:58AM +0000, Morten Brørup wrote:
> Early submission of:
> - some mempool optimizations,
> - a new mempool "pile" driver, and
> - its underlying "pile" stack implementation.
> 
> For community feedback and CI test.
> 
> Needless to say, this must be separated into a series of patches.
> For now, I'm submitting a snapshot of work in progress.
> 
> Some performance numbers from mempool_perf_autotest_2cores, all
> with cache=1024 cores=2 n_keep=32768:
> 
> start performance test (using ring_mp_mc, with cache)
> n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec= 753985338
> n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec= 755805913
> 
> start performance test for lf_stack (with cache)
> n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec=  29132352
> n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec=  29276708
> 
> start performance test for pile (with cache)
> n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec= 560159479
> n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec= 557910933
> 
What about the regular non-LF stack? That would always be my choice for the
default for mempools?

/Bruce
