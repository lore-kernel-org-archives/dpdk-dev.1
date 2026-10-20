Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71988606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MvH/B6F7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC3540297;
	Tue, 20 Oct 2026 16:42:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A08634025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792507321; x=1824043321;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gOMBd11Xb8KltZNz3sAKbnU4Nain87Djsq3hzkaMsL0=;
 b=MvH/B6F7sjOjKowOkOcYYfIj6pGUnLI/HGwdvoG9fIdgH48VlhUD7Wf+
 JjZafdWIywOzTqUDl2+grhLAjNo0EQ00ho2SkembXI6a2H4gnvPyjE1qH
 VstbH6JVIVluHapzf0HzG2Wavk03jQwprqKY/Xex/hDFgZbI437+vgS1X
 GXey2pKrbCzVF2oHcI1C4gJ5lrVZHOdN4TPtTiIpMLIzJS/Mq6FPu6Idl
 Ij9lW4PqMOsKgEADslGBovUXGzPSvdvBAicW5UDp6hdK4kBQ8f2BwEQA3
 eZ8EbBPyGc+33vri6Gwg48A0e1z2dNg6hDHTFMFw3DjhdoczKfj7z12VC w==;
X-CSE-ConnectionGUID: kKCdt7pFQ7KBMS0BGBGrrA==
X-CSE-MsgGUID: UE93+CuiSPau41+AByilgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1082493"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1082493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 07:41:59 -0700
X-CSE-ConnectionGUID: oh/6fYe1QLyBKfSBHyv8hQ==
X-CSE-MsgGUID: 5MjxPDupR2u6bTBq2jH3HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2780427"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 07:42:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 07:41:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 07:41:59 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 07:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCvI67U2DXxbGsDrhmbKpL2amJXnjzosn76PGiR0Rxp5nk7/MiYeBMQij2oLoqmFxKPvOU/OzcRVFKajQHzB6iwetUqH1IlV/+ybnIGw0T8L4SwBMTdksIhQ9m1g7TgQmsuzDg79m6r80X5wjXQirwQOM53iPX4WpSxywf0Hc2PlTCTcSv9ePNFpVQ1mtWasOSU7foFtWjWMTOvZJtebVHUYvZfxKwHoAkyIL60rnfOha4UVfFNxPzVWAQ7OmcTGx9TNskaN9nIb7MWFvIg8ZFar6hnJc3m33P2dd8gd0sjE1yavs0NEmYgFNTejna3ekGIkNC8XUy0Z+C3Qox4erg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOqKvEbCKIfPH+Fv6+DS+eK9/HgsFvVnN/CKT2O+pLI=;
 b=HUmBXhCicG4hfWEwIRZUO3OkyQXx7J62x9P8kE/c/ga5SCedGV/kaeWWBdYENNoqiWUFfNXuJGFkjIRcir+hsJ15YbFaYDzMv8LtJJe1lhcwx1HGe7n3AMJHUrWN+LPwNhkNPsJoyewgwsVBpO22BM/SII1xdlDXKQUw7yKjpn5J2RrzFoINPp09dGM9VzG0p1nq4kF4Xdj8RlUh9LhLtWXpZ6eXhfEf8nyoN3TKhtsYifx6PpUA4nU6Ztn6EA8MpCwCNCdPadqZwDEIHfGd9AD4THcaRFslsZFWqPS9cGpMMRdtd6mKzdN/MkulwA07yCkFcjuS37oxY80hnxCJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:41:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 14:41:50 +0000
Date: Tue, 20 Oct 2026 15:41:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/3] e1000 base code updates
Message-ID: <atd9qUY5ywzVVQff@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792146148.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792146148.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: ae750001-c7fa-4dc4-7c34-08df2eb84686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nyzU+8h/eiFDkqz8Nuwsz9DmSxYOAreV+3kSvRbDfBpw+zL3YjNipH7oeeqy2c8a2WRxBSn/XLrAfEFkslcmBSrpPwIuQA2Bh0Qf85tLBv9f/c7FJZH7jv9dZVJf8ZBu8Xp5GtasVcF9Pi3CR42RCeQwX7CkWWU68J6twWjPo7KntV7Z0BDeibpoZq/3OuqGep0ist7Yj0hVy62oZO0SILEUBlawYeGDFcIOjaaYli51csK3GszEqaxOA653sgQdcdMY8QSr+gjXRIsiNF+UqnS9uOerhnK9MTNIueF+JIagp4zu87Dl8vRNHRgFvUyYMJd74E6HfFCyZRySRU0+8BzI5ZbQ9UpDB9juoyBmJiiHw15isS6JZSFIkYKpkxz53XDoWrcQ+ROUwboDhy/zrs3a9k+yMVxFNwlXtqr/fENgys29S13wQ4FiRWloLDlexFy1iV/bGYuWtVj40VOIw/m75hVMCM80uMpIzzvrpTF0NW9c5EHxfq18qi4cKoKoMKnv5jEHJ2UWhRTlMee50moROq/58JaAsrG+3Txb5AzVhDpeCuuULdSBr62tR45+f3MNUVvy2EPPZmnl6ofnTKtohVgNzOOTbsGvXeHGKFf61nJqRruoYpl8sHGGae7i1+hYfDFeKa69+sIKonDjmvfeQjOhhUiEuz176szaQ90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2GEMnB14Q9LYY/qe9RRPSfU++64zOKI/TBoXorADr8K987XvIIIbnTnLVH3V?=
 =?us-ascii?Q?bLinJnjD1RgC0XOVs3EHlQXquHuwWu446nozf98riSyE0SLA7ltSaElLRnN5?=
 =?us-ascii?Q?0y0PygBdw7SscCHS8FPbg2RP6GpyznDS7RV+6sMXpx4bMOMdqk259Pw+Sigk?=
 =?us-ascii?Q?O2BJFC2TdyOBcgfc0sq/LReIKo9jhoTHJwxJS0U8BRPAtO+3tWhKkrrP6tpT?=
 =?us-ascii?Q?Q0/22aE3ilRen8Xj26SUT/B2so5f2zzYoFO+AVPo2fPWurDYxd8cQgzJ83ej?=
 =?us-ascii?Q?KNA0XCYaMaXB4geut32F9y+Soz+t/wC3Nckx2MfV0kB5c5FAz9loO6CcCzt9?=
 =?us-ascii?Q?vrJkOqo/3smJ/OROzvQXp4cu39XorjCgA/0RXFXtMsWdpGttX2Oa6gQ3s2Ob?=
 =?us-ascii?Q?uKCS24/j/oJV//bVkLNXH0519Pm1QtvVIKFnul/IHcMCt9OTE3faoJBXTEGo?=
 =?us-ascii?Q?x6VbKpaTnN52QvOqNgQxyjcNOiWagFkcH3hvHMtl60i4jwLqsPq35J6/t4oG?=
 =?us-ascii?Q?79z0/ZgoT6syET2bdlwMIgTJ6M2KqoazEWt4BLFd1VtmYv4CvK4GszgrxMP8?=
 =?us-ascii?Q?ql27HCf7HDt18ACMqtrCzZ8GtM/+BkvwT+EqOIkworqHjZf+gOZSWy6WBADy?=
 =?us-ascii?Q?F1PTXxnpzPXNUzy7xkLjSPC6t0ZXX5kDc0eMpXwoL/tQNIk84r6EqFlifWld?=
 =?us-ascii?Q?ZuQrTB/mRdw7foAPa3GQ1wYjandg91cINS5f5dhCkcrJu/VX9gQpwg4s7g4W?=
 =?us-ascii?Q?88vlq+wh8ezYSvWsKjy6S0CaJo4cUyhNobJAP15O9Fq6hh+I8860kvxh8QTq?=
 =?us-ascii?Q?87GR9dVk/w0d7IE1Elk0Jl5VL/01agaTvKxrGxOjjBGGSf0rut+axuLFFTGx?=
 =?us-ascii?Q?/o5J50YwIjsA+c9ApHVj3cFfHJxP585SJDsQcFLcqi08cGQ0QT5u2QJ+TUfS?=
 =?us-ascii?Q?MithSwZ6Y2X1DJ5saxL8eKcf3ILmc5lM0TzpMdL4Gs6aqtbDoarlv9NWCpH2?=
 =?us-ascii?Q?KO+ftwu0GwEs/C3AsZdPRrUSjKFWjZWgJEbL8w4igAArE+PNLiVRf0FGwvmc?=
 =?us-ascii?Q?sKoCMN7LKRgeaWjfcz/0k78u36KLlSNPNPY+4d8CMuwAIxtCYVrfRT4EOEpB?=
 =?us-ascii?Q?BKkzYe3P8WyO3BO45Mes4pgcC/0199H3TkOKqCoUJbnC1a09/Ph0qxPpzw/F?=
 =?us-ascii?Q?b+rCWGppPqUyBC3vX4Bur//U/q5X79SbVwtwc+C2Td5g8COftRYicg66wdKB?=
 =?us-ascii?Q?ZUZCBWkEXER2XupuGzsaBxNolOtBBzsHbOwwD2vsOFRQOo8rRkp9S1/TPHnj?=
 =?us-ascii?Q?FUmq74vJelsQ5RM5I/AMK6F0MYFPYi+JxKsNveHUDi23yFOtos5l1bvIUCus?=
 =?us-ascii?Q?wr2Osj1lBvrAihS/HFSSCxXZyZw8NyYYVXvT/LXLBGZNwN9W0zZnHCytE3d/?=
 =?us-ascii?Q?f4/UEVf25CqtDfIAomvC9V/i9Fd1bIO48gSOppCJn0i4g0EVnJ3XwnvAcx+Q?=
 =?us-ascii?Q?68GNEAqQE8+kI3jeri9NXaLef2I4sSY4U7r5jNeKnWzGzoGJGYyB0GubLD2H?=
 =?us-ascii?Q?E2TQOV/iCw5OoYAs/BTcXVrJfIVNekLnp1jWijlIfPgJYBJKb5QiWlUkyhhi?=
 =?us-ascii?Q?29WL82KvPVnnr1jwTq8X8w1KAPFeJB9IGoqt0cC3yf8MnuW/chARbtYshbKg?=
 =?us-ascii?Q?AfVktvpj76AsoZfniicbh9BECJnTNXYK9b4TNnhkUCR2Emy5H0zCrW8uYkGT?=
 =?us-ascii?Q?DkEkfD2jELLtFQpwC2uFyILxZFLPl+c=3D?=
X-Exchange-RoutingPolicyChecked: dZYCqKDKAqab+OEpVQaR1Q2vq6B3nYETvwA4+xmVgvuVmF6u5SefRaC/q5eCADhqJetdNh6+CRm2+vHS9KOkDLhyl6mGyZ3uvKbVvZO125wxEg/13ctIkale7gsHhkYlSx3CT68UIt/7fpG+g/oppUzB/IeVUKgUBo1gZ9tZhvzhXg1JQ2nKs1lW4cxasRkmmTGgd8yOjdcoRrCcgwYM0aKCyPsaBWmyglF+2mkFmwgIIk2mQXB2alQQR102HHpKLvkI3C1AIVhy3yQQEhGg/EvJ//g48uJEfEBoTXXeI7w+G0gNrSniwzXcidqlUreqNmTYsVYehRH2EG+rLMf68w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae750001-c7fa-4dc4-7c34-08df2eb84686
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:41:50.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCczSnywMCoEL07jlWIil32/4ii1HvupqdR1/qxGqsN1YgLEqQShbF5+Mx2GPU0cndVqkSI8wRORuCEOtt8wq84bWT/7Cq7K2oAlCsBz5L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 11:22:58AM +0100, Anatoly Burakov wrote:
> Small base code update for e1000 driver.
> 
> Dima Ruinskiy (3):
>   net/e1000/base: add new PCH MAC type
>   net/e1000/base: retry failed MTA writes on i210/i211
>   net/e1000/base: enable ULP on LANPHYPC
> 
>  .mailmap                                     |  1 +
>  drivers/net/intel/e1000/base/e1000_api.c     |  5 ++-
>  drivers/net/intel/e1000/base/e1000_hw.h      |  1 +
>  drivers/net/intel/e1000/base/e1000_ich8lan.c |  8 +++++
>  drivers/net/intel/e1000/base/e1000_mac.c     | 34 ++++++++++++++++++++
>  drivers/net/intel/e1000/em_ethdev.c          |  5 ++-
>  6 files changed, 52 insertions(+), 2 deletions(-)
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
