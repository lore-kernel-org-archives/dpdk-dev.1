Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F141E7E0CA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 402A5402B0;
	Mon,  9 Feb 2026 12:04:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4A1C54027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770635079; x=1802171079;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=I//4N/IbcvPLIbygxz8+RLr2j5xwiiB/6x4ogOin7xM=;
 b=UYWuF9wRzEPqJrqY8vn0Rc1tMa+rDVDE/rcCEyXfwgHpWEke75IIzl2c
 u9NlnxvBa9IkpLV21gf1DFhBmgYP9GyckEHFxJVK+BitdMhpIGC8huG1u
 OIXU/4YNLSPIOeuPGiC5A2jdTTnqtnno/PFySnxXqbMDWdR6IlAkv2/WB
 eWutoaxH8sDCtlHdQKz3qqwNOlAy127Eoz0ui+OcQzNlS1/wzeNQrB71C
 Qk6LiNp6aP8wHc0UIacDSUsVakrUV1ITx6dBWeRgz5wqiqM5j6VL5spOk
 WwpRlCmO0I8y3ruYzBltte8IDruo+XwZm87lBhEYPxD/J6jmLH0oweofe w==;
X-CSE-ConnectionGUID: 6IKzPPbsQFCvhKtf14Q15A==
X-CSE-MsgGUID: ybh4M6z5QyuiUZZgTznL3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82478279"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="82478279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:04:37 -0800
X-CSE-ConnectionGUID: YQhHXPyHRgmBDyEwbpM37w==
X-CSE-MsgGUID: j8j4NsSZSxuzOcZp/2FhQg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:04:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:04:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 03:04:36 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:04:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/lvQY4ScPxkzcoxWuo7OlD+b7RLy015Bov7HNb+dRrQRGww27ICm0xoxqpxwFMqAGFAUAm6C8a+AL0egJt4jPxABnO4F+d5lZjmZisX1VkOh7onZfm62brDvDdOZ1cDxaLBJxOLQRX0RGCoNW5evqWMrj8LWE2qB6cE2rQmv5+GEaabPtZLjwl6Db6VNZqmwtpPZGsJqaRib2SZWDXrg7w1OiLFscNVIiIWby8vwNDo144aLf4VU1VXlkbCCgXrF6+6CzckoRNYCLyJLTdwVKRzf25VhHPkuyrxwyRypyQAgKK91599cC6UdE90RhmMbkiNths1JOvm7bSPAyjGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNLSauc8FMx4qA5PLCk5SvNqVnTwsfrEkaraJx7annk=;
 b=Ll+Js45TIRpGTS/QTHDvtOELdxQDwr6PRDRdmUsPUXzIne8qLYpN+2Kk7AugDss8euAY8yHVgbJo27WE/Cph4L9yk8ZfexEFva5i2y3RMBiJc0WxHSWAvhAv1bRpnreXN8q1JU85wzzLWn/Bml37qfLdeMnW2BuqygE7jlW0DlYve8y4AzrBPeXQv3pW9de6w1L+tuSFW89P09lXwGxNxaynNKqqvR4ZyqcCeB1ac3eVcNZ4fGugLMToUzEuie8VmSj8qOJbr1I0jD7yvXSX4hafcxj5Rae+rmDgP5GYw/Mx1t3vAIcCmLKfrddRCX5+dqDVyHjxXHE7ilrLStK1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 11:04:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:04:34 +0000
Date: Mon, 9 Feb 2026 11:04:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 05/36] net/intel: create separate header for Tx scalar
 fns
Message-ID: <aYm_PR16C0Nu7WH1@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-6-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1FE170818FAAF21F014D28E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1FE170818FAAF21F014D28E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: LO4P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: e690012b-056e-424a-0cbe-08de67cb0228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4DJZMoU39chgzEn42e2/gqeLDA7jbDgQNeH/M4rpCz8Db1G0x4U1RgO+e7O0?=
 =?us-ascii?Q?VCpO6VebF4TVzMfLQ0QE/et5Vwe8SNwfsgrE9vQdOzeA05UgWJp0vpxFkF9B?=
 =?us-ascii?Q?zKE1lg8kniyB5G+DQkEtXufm5yeSJJkGPyZDIvLKC1ZJ2YKh7/2E9u+gZwJp?=
 =?us-ascii?Q?s8LHjVtlwfIUtMBP9xubYhiCBnTBvbyDZGIG5HowGYwpFbl5ldYEomXW+c9s?=
 =?us-ascii?Q?m93uLGsTRxFtSG9QGqUb+46ADW3G7eck1VaeX/ljdZTNFOZsZha2iu0e8/hj?=
 =?us-ascii?Q?oUEG2vidRq9OXl+uIoDynVUI4F0QuI5i//tduO2Fz1VL1YuCLYyNdbao1Cd4?=
 =?us-ascii?Q?P/zGOwk30uyaroTSKa1TwJ3AeSf92Ix/j7hU8cD6Eyp7u2z7vYwk5EnRVnW1?=
 =?us-ascii?Q?V9DLV0mlPZE7FhcNHJeaJ6Lxzse1gZDvWwlm+lvNO2m9CIjsARoDf2jY+cWf?=
 =?us-ascii?Q?ltr78BF+3NT25eyH4PQ3Bw+LqvAEX/IQUuoZvwTMN/6PdgHbnmUyERUt7iOf?=
 =?us-ascii?Q?IsmFcCl/t3ZNnmIMmvoXraElgx8KIomZ5jwK2OORd63PqInFJIoeF9F2EasB?=
 =?us-ascii?Q?kElD+KtJwhzVe1m+QaGmHVmwYS5xEJQHVw0qsNJFnRVSoCby0w7qPlAut5pi?=
 =?us-ascii?Q?+2YQRBbef8KiXYevfbiZdoNeTrtqJFrXA+y8aCtL2OgXD8ccUqVBTPyjYKx4?=
 =?us-ascii?Q?PKzf9AaPUeAoKIkBTjfG+8HzTIrPeBX8so2n/kGt7YDy6L6JipONbDBhQl8I?=
 =?us-ascii?Q?ZzT811+M+Mp3A9IxqGw3+uuF0PflktBi5DbVC2HopjxSJqL5AwURnIklAPKN?=
 =?us-ascii?Q?vHwXEgKl5EIxwMMzmuoa79+3c5kGixYpw/r1dbq5bWWMsxUqDNKbg3U78w7s?=
 =?us-ascii?Q?nvoLA7sIFe9oqF2Cr6Jqxdpc6AJl71sZgj/b/tt3ghoIbdz7Ae89yThI7Xsr?=
 =?us-ascii?Q?ZAzaGhlEZCSE4nR7HlLXjJyRuwvBB6tA1+2azWzblw1Q2NDHdIziK5Gxp5Cr?=
 =?us-ascii?Q?xfT0ULg5x0sWzP6QDLNTAu8qebtT6GXTkatl6V+3gHmJNUlNWtFE/JQP9B2J?=
 =?us-ascii?Q?XUSXRpsLkclH6hpRK1aeHtYtuA2q9mJUY1skT3zf+B/EXCWor2125l3ctRKr?=
 =?us-ascii?Q?2mOrDCm9EyD9q4fb6RWLy6FfE86zOa9ePEKTcYmZEu/1Nd6N8orY8XTrf3Jf?=
 =?us-ascii?Q?YT6oVqxrcHdAbDWDh//564Q5+DLcb7krgINyjOyagr735DgpWi33wAahaNac?=
 =?us-ascii?Q?lbbjI0bznhdgUB6c3DNH0dl6nBlaKikVZQ9l1Y+nQjG37MEMfF1mfvNLzWdC?=
 =?us-ascii?Q?TuErZXotZBbKfg2BpyavGdtp8+G5XigceI5kt0Tyr9mDf8u2kHowTh+BE83w?=
 =?us-ascii?Q?E3icm1QjU+1LA8DJC49JcZEUuUR2E/+GUROYivhZQC6hBtE5I0hhpoefJDdH?=
 =?us-ascii?Q?AqvSSPjObG/4uWdMFNHrgyCFiNm26mrwMU8jAdKsQh2+NudFA7+MBbmK+FvU?=
 =?us-ascii?Q?gxNRXLOeDcJWUorh3+6W8mxNwAZuFXgUqDBm0hK7f1m8jGjRVVNq7LAJWaVQ?=
 =?us-ascii?Q?Ox50TdZPZWHaJ0YHA4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rdCDD+gmVJ55oTMW7YGytPK+eFrtYBH0OuXuETjaz17GO9fVW+iCmnROx/e?=
 =?us-ascii?Q?MGGslzZgSFYOJPGwneU2eEJ6cxU8gTKiRq2GeCzAWB5I18pRa65zxZb680Vl?=
 =?us-ascii?Q?AULBjUgxbA9T/dcmGFqnI4m+C5PvVyu6LWK7CDL1mWEcixkRFPPGBdDPH2tu?=
 =?us-ascii?Q?8+U7LcStgHHr7BMKjQcRS03XHswQECxXMy+KCvvhnkDx+mSFEujbipMJIkvR?=
 =?us-ascii?Q?wnEG3rvCYf+yD0lJJ9pxK2bVaXY5bhU80DfP0UAQJ+XeuvH04gsa0ab2ANOc?=
 =?us-ascii?Q?nkev9z/HsIqZs8If55a2lRaR9bDCGPNLnoVw8J98pNFtovFIzZtQ0tZWwE+s?=
 =?us-ascii?Q?PBPfskCE8oKmuiq42WVZYigLrPKSaZ6bfvD6F8OIDrooFG/XxxXen7hDV58t?=
 =?us-ascii?Q?DwvG3Tepy1fUEcQ7Vk4Oop51Ql6Q1wj33abxPqxRtuU25lQKmvPPKmvX6rz8?=
 =?us-ascii?Q?lKOwjX2vME7EdaY5tiM6P91U4ZlNY/Iqw74nbWbtgWATw7QJKxgR6ktYs4Kj?=
 =?us-ascii?Q?MI9dN4Tt0vB20RV/jttQUqXXBXe131hJvSK4tz1pwKpiRcrehwsDU5ds6f8v?=
 =?us-ascii?Q?rzOBNucp8HEg1u+ClkK+nUzlqOiWRyIlmLYg/kRcPByML39AaV8bVhBC7moH?=
 =?us-ascii?Q?o66kn0o8UNikHRPIOlR5L0Ye2ydeyR8eJsJju1CSQ4uNCnH75ynJp7iwaeTq?=
 =?us-ascii?Q?wCnBpJzH550VH+EGOtrU2LtnXenzUSthJl7PfC3hXv1ZaYlj1AGDKMbqa+5Y?=
 =?us-ascii?Q?OGTSVL+4WRs+z0L1aLQKjo3oIgEOTMkldxdTvyUqIWjKTXkGY2a7AFzvqF2l?=
 =?us-ascii?Q?BYSClD31Kw2Ij8ySxXQFYXd7MQ+ubKuLOZ1SsSc7Y2altspUHpWe+BIAClCk?=
 =?us-ascii?Q?5903+OSgDXkxGoILS9vHZrV2mHPW7q4uJ1CPQiR2jdSQaD8PausUOsT3Z1Bi?=
 =?us-ascii?Q?9R0VMOFFuEXYnoSg5GKk++IO0vsShAENzRNj9QG+ZHiWrFT17MJTs4WWdJLv?=
 =?us-ascii?Q?nZSAJjsmECO60VKFh4//wbZlOat2xriisIcYpooamAGjtLaJEaX8f0cdXo4g?=
 =?us-ascii?Q?KkOpSW3ZIWfFlTRYp+CwDif6I3uoujJPn2hmCvN2I6n5hrnEOvUw9J/v/nop?=
 =?us-ascii?Q?ZnMwlvG4BHSCSlJw/iIEa3pKopff7S0WkvuCPiF/HMswk3VJQBiF1RDsL9ni?=
 =?us-ascii?Q?Jdwm3lQujtVYcuNJ1JPBJqPFE6r4unXBz874WpcWL8YD2KYlI/fQFQK4J6e/?=
 =?us-ascii?Q?CcGWE4wM8RdHpL/eYA9SVMiaa7C0FinpMT6qYflo1llnCXcdXLmSlg4mZE2e?=
 =?us-ascii?Q?p4cR2NkcISL3ipdAipwis+OhcBgkUan7di2JBWr1L56M0vNlYFhExm2NbFVc?=
 =?us-ascii?Q?pjwCAKphvPCRT0o7hRIYda1PIa4aeRH3lPXBy5qu8ZezOZAU0bNbEFxSEri+?=
 =?us-ascii?Q?B7kv5fX9ASg6Jv9ozjVEGPLHg+cojU9PFCn/TaDwV4zlxQjHMyyeUEG/zwkb?=
 =?us-ascii?Q?Qnd7685MNdeKeA28l4oEB9ZWYLpfra6JuPmtbPVTIE3vsApgwsfb7WXOEVal?=
 =?us-ascii?Q?AXgKjg3roII3FXZIh7LZ0CFin6+wNSsN9rwuekaiUHU64PX7iJErMIFlj5Ww?=
 =?us-ascii?Q?nJo4939u3x254gPBa3EvRV7oMzZ8NqiqBs+xzIMYx5ox/B+d8RtgNeM98DbX?=
 =?us-ascii?Q?2oR1lE3QetaNRwWQ0+qIQbmAOfB2eDztZS0qrUnA2f7ZGqxhsg916SZxx7e0?=
 =?us-ascii?Q?+C+zRGU3ikGvctDDQeCoK5K7Nho7cK0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e690012b-056e-424a-0cbe-08de67cb0228
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:04:34.7941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNylFKxhhqmGbHXIzliRUXVGaDCnVHwuSDRsyNwqp0oYGh6zVI81ZKIHoMnj1pq09lWWFhvHQUmiESYvwsdK6QUuUhwKK4dDXOkIWIye0l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
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

On Fri, Feb 06, 2026 at 10:23:43AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 05/36] net/intel: create separate header for Tx scalar fns
> > 
> > Rather than having all Tx code in the one file, which could start
> > getting rather long, move the scalar datapath functions to a new header
> > file.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h            | 58 ++------------------
> >  drivers/net/intel/common/tx_scalar_fns.h | 67
> > ++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 53 deletions(-)
> >  create mode 100644 drivers/net/intel/common/tx_scalar_fns.h
> 
> Why not create the file when ci_tx_xmit_cleanup was first introduced?
> I prefer the naming tx_scalar.h but keep tx_scalar_fns.h if you feel it's better.
> 

Not pushed about the name, so happy with your suggestion. I'll try and
create this file back in patch 3 - some heavy rebasing will be necessary!

> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index 03245d4fba..01e42303b4 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -319,59 +319,6 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > ci_desc_done_fn desc_done, bool ctx
> >  	return txq->tx_rs_thresh;
> >  }
> > 
> > -/*
> > - * Common transmit descriptor cleanup function for Intel drivers.
> > - * Used by ice, i40e, iavf, and idpf drivers.
> > - *
> > - * Returns:
> > - *   0 on success
> > - *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
> > - */
> > -static __rte_always_inline int
> > -ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> > -{
> > -	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > -	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
> > -	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> > -	uint16_t nb_tx_desc = txq->nb_tx_desc;
> > -	uint16_t desc_to_clean_to;
> > -	uint16_t nb_tx_to_clean;
> > -
> > -	/* Determine the last descriptor needing to be cleaned */
> > -	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> > -	if (desc_to_clean_to >= nb_tx_desc)
> > -		desc_to_clean_to = (uint16_t)(desc_to_clean_to -
> > nb_tx_desc);
> > -
> > -	/* Check to make sure the last descriptor to clean is done */
> > -	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> > -
> > -	/* Check if descriptor is done - all drivers use 0xF as done value in bits
> > 3:0 */
> > -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > -			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > {
> > -		/* Descriptor not yet processed by hardware */
> > -		return -1;
> > -	}
> > -
> > -	/* Figure out how many descriptors will be cleaned */
> > -	if (last_desc_cleaned > desc_to_clean_to)
> > -		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned)
> > + desc_to_clean_to);
> > -	else
> > -		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
> > last_desc_cleaned);
> > -
> > -	/* The last descriptor to clean is done, so that means all the
> > -	 * descriptors from the last descriptor that was cleaned
> > -	 * up to the last descriptor with the RS bit set
> > -	 * are done. Only reset the threshold descriptor.
> > -	 */
> > -	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
> > -
> > -	/* Update the txq to reflect the last descriptor that was cleaned */
> > -	txq->last_desc_cleaned = desc_to_clean_to;
> > -	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> > -
> > -	return 0;
> > -}
> > -
> >  static inline void
> >  ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
> >  {
> > @@ -490,4 +437,9 @@ ci_tx_path_select(const struct ci_tx_path_features
> > *req_features,
> >  	return idx;
> >  }
> > 
> > +/* include the scalar functions at the end, so they can use the common
> > definitions.
> > + * This is done so drivers can use all functions just by including tx.h
> > + */
> > +#include "tx_scalar_fns.h"
> > +
> >  #endif /* _COMMON_INTEL_TX_H_ */
> > diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> > b/drivers/net/intel/common/tx_scalar_fns.h
> > new file mode 100644
> > index 0000000000..c79210d084
> > --- /dev/null
> > +++ b/drivers/net/intel/common/tx_scalar_fns.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(c) 2025 Intel Corporation
> 
> Should this be 2026?
> 

Code was written in 2025 and actually submitted upstream for the first time
in December 2025, so I think this is correct as-is. [Open to correction]

> > + */
> > +
> > +#ifndef _COMMON_INTEL_TX_SCALAR_FNS_H_
> > +#define _COMMON_INTEL_TX_SCALAR_FNS_H_
> > +
> > +#include <stdint.h>
> > +#include <rte_byteorder.h>
> > +
> > +/* depends on common Tx definitions. */
> > +#include "tx.h"
> > +
> > +/*
> > + * Common transmit descriptor cleanup function for Intel drivers.
> > + * Used by ice, i40e, iavf, and idpf drivers.
> 
> Do we need to call out the driver names in the comment? If a new driver
> were to adopt this function they would need to patch this file too to
> update the comment.
> 

Good point, I'll try and generalize

/Bruce
