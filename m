Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1CCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 08:41:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DE0840695;
	Wed, 15 Oct 2025 10:41:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4F6444068A
 for <dev@dpdk.org>; Wed, 15 Oct 2025 10:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760517673; x=1792053673;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2OO6Rfqi3K41cRb/opqOHe7AFdaAAgrzIAzRgjz+mv4=;
 b=MPE3bRFXlvnTI7W06vuBIbkGDxcexfqO434fNo4v2yRA/xYdweRXvv9t
 1WChz1YANo5z7Vxw3SawWLDry5tKcNCn76hVwAI/HMEWKt4yCX9/mJq8c
 IsTYPd6iPUpomB9sEejxPqKeCnv1DsLHfg37nqqXMRlJjfUp9QvJDYpgU
 0zp2efEI3gTFPJtvOgHVEM2NPpXSx5VxA52zcLTQbyW/Waic/jam2bado
 qoUXc8Wn39N4TgngX2RCmXYhW3qTE6aDO5G/+nh/ge3MId6Tg/BvJDVPz
 HbgFdIa4P7V9v6Ycuw1h6D/gPlAPSH9ps8lq1tooJElAhiNmDQnUhHYzC A==;
X-CSE-ConnectionGUID: d4/zCK7XTkue2vuvIk7OEg==
X-CSE-MsgGUID: 7CCJM/kbQQG9C2R5Dmvf2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66547565"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="66547565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 01:40:38 -0700
X-CSE-ConnectionGUID: Z61Kgmj+QumdXOv4CbhjLg==
X-CSE-MsgGUID: 8u+qymy9RwGIqvXR1ITbHw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 01:40:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:40:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 01:40:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBi6vMaTvJApkpcD5zwlL6G1PRUUh/1T23wdibcGup5wGx9ObvN2EFF9tKoi0hh/4IQRnxdNFSqRW3cEytTEH/ePyCuzz2SnPj5ie7PjXajZn3zDZyTkUXSyakMVd+tVo1oVELUzJs7aguikAAxtJiN9Ndba0DElQrT3DKqyi/yUhlgoPTXzbgpYBc8yQqPXkQ4hauaEq4ej6qKoepaLBXQpf0mn1XzHGkOuww1j4yZo1EkaqyRIr/Zgv+qLZPPJ/nRKUOUPrW92zpt0mlpiRtvNkA0czM15qgDEU7915ojArJI3nKYHt1MZTE4EUU6D0AOvDTupVe8Y5jzZu9M/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5nBEKkmF4li3mpr+m6jdKF0hZwN2FsWAJFfPF9XWVE=;
 b=dTG1JcjJkrnpIzniraQQTGVKWfyhGmi8bR1cfBgfICVDdHbEYaRBnON8xeB3kLhz/m6nJe8LYhsSk8Ud8krC+gonQEdq54cFpfuEGsq/F8NIR7dp9EGZD6zerX4nAUFVU+7A8qKoXYdyMJDGUiGkwCpM9M3itx9hj83zf4WSSfTVrhp0Ddp+mfuNQc4yEkd1uf3en70pzJkyT6BM1PtasSarxU1VuAwEVT2zcxnnYHA8IKZoTEtCSQDZwRzOfzTzkqXc9oV3FE4Q7IFP+pLSf471Wpq22HB0XxoAssNgvvKjOzLr+Vi37a5HuLnV9y2nzUOgRRuVPqC9oWNLQHKw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 15 Oct
 2025 08:40:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 08:40:30 +0000
Date: Wed, 15 Oct 2025 09:40:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v11 05/21] argparse: add documentation on supported value
 types
Message-ID: <aO9d-cPpkkKXo4J3@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-6-bruce.richardson@intel.com>
 <a6ca7fc0-d7d7-4f8f-b04b-df637097a374@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6ca7fc0-d7d7-4f8f-b04b-df637097a374@huawei.com>
X-ClientProxiedBy: DU7PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f472e63-fba2-4188-046a-08de0bc67f3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sE7a7gwyzMdAKYWImpddu7FLbQs6tL0CUR4EP7M1ffSoO6COlK5drktfgmph?=
 =?us-ascii?Q?ZEf8lZ1PCtDemeYTMtVGPR2SI5sCaK2UbHLC8gITvgD4FfXavTeA2ACJWXJ6?=
 =?us-ascii?Q?da1UriL/upa0pjO+lyIbXNToPIpnQPEsffmHEBsHXONBWdQZcmWViy1Rp17c?=
 =?us-ascii?Q?7DEh+dmtyX4GEIMf1+ZGjVrPUvtBI+fzrh4RRuL4iSscH1wdXtU/og0o+5L9?=
 =?us-ascii?Q?ud8hlK/csY4einFxoFh4yhwlDnf2F9eIN/7pWzTLuyNgOUd6I/4QKYYfBTOB?=
 =?us-ascii?Q?emrlKulCFFU6gZC1uAYWW/vovoexTNC0TqTXX6bLOvAJ+FHPL77WOmIBVrA2?=
 =?us-ascii?Q?gY3nOmV3dILYW0jv0nVNTZfvgJKCmfl+0cHUulVIw3wBPZpfH9utkUKxgYDk?=
 =?us-ascii?Q?qRke9i7hxr8DbxSTWBLBuLuQ3kbIT9gUKGpP+T2aPdFrxe7AKNzu7qC6eq+F?=
 =?us-ascii?Q?DSDvBGbaJG9Knl2N737x7EAFpVSSbZf66YMeGHGnUFiEXUexCPY1dLZdLkIq?=
 =?us-ascii?Q?SJVZD9fnDYqE53CBdGwnRR9FfCr+BLdkuh6ca9jCmqKXUW0+VTHuCAEWwf9m?=
 =?us-ascii?Q?YobtOfPl7QLCS/A9p+qwVCmrAnSQ8XdB9LVXw5hb+q8XRx/hDBN2tV/rvHZx?=
 =?us-ascii?Q?gF/mC7JP+JZkWAr0d4jbRn+p050teWIPatpcWc9IgIEigho+PKNR/qLiqoa/?=
 =?us-ascii?Q?oHb04KeJy9FE+mKbATdn59XhxOcDyVgnuDACzd0vcWfaAp/pibCb4w08Jgu6?=
 =?us-ascii?Q?dqs8FyiRkZWue3Qt8faKr6Kq5/JKo7yxJKlnuFipFDMioPfgFOkrQo6DwOPu?=
 =?us-ascii?Q?b1PMOZTvjoHlNj6FzxGuGgMVY7HvTRfgNTiPIrQgWtU/joXSXYpJKboWvSM2?=
 =?us-ascii?Q?v2/C7suhpndNn4AQaaA85CifxPbEBq+vwIxR2Uq0czbajpu8IzLLqXmlKqRJ?=
 =?us-ascii?Q?ZNAtpzGnRJT6oyVbQapE8WCuAvS+jS5YNtZdlILPzfbHp3XAyhD+jIgsOWXi?=
 =?us-ascii?Q?cF8M4HVnt+HuolCB6DR17Eh8boeAPikOeADjEvaXgx6gk4ryTxj9kcgyBHoD?=
 =?us-ascii?Q?J+fq09U56/Un015w08nGl3iLSQ9AEQJjYVdoBi7bGfcSU/58G07J0cjOOTfr?=
 =?us-ascii?Q?OG2lBw9DqY4vcExb1i/5kVVSspjTNJ1TfsZAOHzRizTE8n/u2l0JBbG/PvMA?=
 =?us-ascii?Q?jI+LgeYdFB4G4SFX04u0/lC3aUfmXw1YsEJLYjFxqQF9ywuXQ2UKhOKRbsxg?=
 =?us-ascii?Q?7+YTrxzrPy35ws9OWL07tlO2njpCBMIMpwUKuzNRmoeTh7IfvaQk/j1frK9s?=
 =?us-ascii?Q?rN3q8MXfxMbHetU5cLoFoLdRozHb7Kv0x8ufz743veFRE/0LJTm7K51tdS2W?=
 =?us-ascii?Q?LWAKr8YfI9DW2h8gYmoXPQM6idDEe6XRxg2L+bMCwgQ6AXl0pQWGw7hNXYwj?=
 =?us-ascii?Q?tnXCb1wWj5E7a9JRVmqNm80tofthVtcc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2FLb/oS/YncctpWyI0isirU7wEcpn/gMeM3ITZmULbVSBd5Zyyc5tTnNaTD?=
 =?us-ascii?Q?93T6yj0ib+ICfI5kPSMr2vHjgdNR75yZq/qIbpsSPnZbffNaeSYo5Evpjkd6?=
 =?us-ascii?Q?dj060gevRQ3ysMsxpBkhf+CL6s663ljQ1no0Q7zquXK7L3WMvUiQeWUtehLV?=
 =?us-ascii?Q?yXJdObf+JkBoj9ZfH/53ufBjZn6BXwrDvd3MC66lHjZtWRYFhXtOaTvMXcez?=
 =?us-ascii?Q?qAYK0q22lkXB9bLFH+Xx3KJadCdIrsbUfWeMMdCyu1FhSJ/wMM5X9QZzIG1n?=
 =?us-ascii?Q?qtkAzVof3GoCwgtIAR39uyxUfTCkZnZjRqzEFG/Ij5L7q6RS7v3JeV1Fh6iN?=
 =?us-ascii?Q?BozzZ24DxpM4k01zbs5OAL7poB9zP+j5RDdl7K62BXwikqRDFpphcZ0oWRJ9?=
 =?us-ascii?Q?NG/wjhKBTCoQVZIWvw7bWgvORY8upZyb6RklcCd7tRuF6q5EDh8zzWYjP2pc?=
 =?us-ascii?Q?8zfbVB/9wfTJxJbHL02LYYT8aShFrB2D1wGdj8aJAS57Cz+o5xwjRgyXpvme?=
 =?us-ascii?Q?Rclgmgfy5eHzTa65pzX3R3uMMW0WRE+T56g/Je6DyCiF7KzrgnPxKEowA0ds?=
 =?us-ascii?Q?L86xQ24u6xt3mEhvwcRWrCTa7VwoTEQFiLCEcRpt03Mg6Nw8BBLY/I6DbOqt?=
 =?us-ascii?Q?otO14r9SBRf/HP7SRjSkEI/cjp9M3mhPfBWXfvxUNHOE6ybAhcyl7wEl+vRj?=
 =?us-ascii?Q?Chpco3+hCaiVLYdBK4ef5vVJMZztVLyN2sVW179JdvbSeuBHHy9U2wgWjsXy?=
 =?us-ascii?Q?I2dmAka8pQ2YorvFkznPLPvT8ERI/DK0setWSDaLamFV400cm5+iQEXxoYwp?=
 =?us-ascii?Q?YdUpL4xgLg0upu7i0RYBbImQsHKMaFwihw2CEuoGuppJipxFrVBvvFl06gHl?=
 =?us-ascii?Q?UGlunSQcABln03lG46wnIDd7xuWK5xqDHwJm6Oq3Pa5KwpxMH379VWPdN3iN?=
 =?us-ascii?Q?rIIPP7qu9m0J2ihRluc7xl4kUF+/Sqr9hzYPXHiWjmTMGuPEnO4dJGAh1Hst?=
 =?us-ascii?Q?KzQDESuZjlyWhqGKD3S77gMPnh9QttoBSTllF6swn2i9ZaU0VRD68GmycppM?=
 =?us-ascii?Q?U5YKUJZwU4QDyg4EvVapsYTH/xGskikGaI+Bv/6EpSH7QjKDuuG/sMUmI2vB?=
 =?us-ascii?Q?n9JhYbpSq0QycAhV0XRKwaYXEQj6ol3+fkj69UCvh+Gt4tfwn64Mg0EXbpB2?=
 =?us-ascii?Q?8tw4nUKlcCUtBnIhqlCif54O8GOMNIuumZT7YPqHZUi4E/V5zMyTq5aTfto6?=
 =?us-ascii?Q?f2SZJXODcO2CxyFJ6Zc+m+HLve7ADCA0wcNysKlYZjJNfllrVHpA8ESx0Ge6?=
 =?us-ascii?Q?KzRm+/XNfHeZwx5fj4nFj685xWG6qymF80p+72+Xui6JeqrtLNtaeFdERH/0?=
 =?us-ascii?Q?oTbOggmaY92ZLNrDG1/RYbjqJaUBsRjzfAI7fT5qqqbDH648ojfe9/6aZQxD?=
 =?us-ascii?Q?L7u7x5tZAwYe7CdQMgCkIWWNkvEzEf53htCXYr9jf8r9EU4oEPyPU8ZnqAzV?=
 =?us-ascii?Q?aMphucNvG4eu94Kd7vgUOXqqppW/1sJzE/7j1O/awvOWXLH69UkF9M0PkHBm?=
 =?us-ascii?Q?WuWH9ZHO3asIZfybWL6nYZsueUljhMu4TGD3UzEIbCJ9IQfZKnwNZZp6PBp/?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f472e63-fba2-4188-046a-08de0bc67f3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:40:30.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5CKrvtFnir3eCZ6urCCVbf0Rey7PixrSZtdQJ+hSnDhs+j4TdntNS4RlI0SmF6TY7/cCTeYY1cs+RUBGUZoBthGXI5BzEzRW5axIn3sFms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
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

On Wed, Oct 15, 2025 at 03:53:09PM +0800, fengchengwen wrote:
> Minor comment on paragraph layout, with that fixed:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 10/9/2025 9:00 PM, Bruce Richardson wrote:
> > The different value types supported by the argparse library are not
> > discussed in the documentation, so add some reference material about
> > them.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  doc/guides/prog_guide/argparse_lib.rst | 73 +++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 2 deletions(-)
> > 
> > diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
> > index b309260d20..7868af5672 100644
> > --- a/doc/guides/prog_guide/argparse_lib.rst
> > +++ b/doc/guides/prog_guide/argparse_lib.rst
> > @@ -160,6 +160,75 @@ both use this way, the parsing is as follows:
> >  - For argument ``ooo``, it is positional argument,
> >    the ``ooo_val`` will be set to user input's value.
> >  
> > +Supported Value Types
> > +~~~~~~~~~~~~~~~~~~~~~
> 
> This paragraph should be the inner paragraph of 'Parsing by autosave way'
> I suggest delete the ~~~~~, and move the whole after "Parsing by autosave way"
> 

I actually disagree on this. I think the value types needs its own
subsection to hold the various value-type sub-subsections together. I had
originally considered making this a subsection of the autosave one, but
that left us with too many levels of nesting. I think having it at this
level works ok.

