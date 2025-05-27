Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3FC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B79F24066C;
	Tue, 27 May 2025 17:31:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0FBC040662
 for <dev@dpdk.org>; Tue, 27 May 2025 17:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748359899; x=1779895899;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zOP+0/mLQd1VCA4MfnTcq13t0XzsEsKgqFPsb8iEZP0=;
 b=b1fTsc6+aZZ3gdjvcgD8e8Ws8Yh29xmD6eBu4kRpNhCFwNnbxMDwHCwX
 7UL7YSg8B/5vF/xpAK+lc98wD+B9swcdQSHNL4Ot40z0MoyUfHOb154pW
 dBCy4wBeXc4HQaVqcdrlV3ZIvpYuk/c5+aZzrvnDmBvHFw9vGHRdU5MfI
 uSo9TDnT6BmqL4WZdMrfgMnwdv3AQZpKa15FK1m3FsL9rBU61KM+8tT+K
 XbLYf2KcVNYb4+u+OGBlFSSrj61VUop+S0PrzYMDmJxjMY9gSrm0gn99H
 KoyoGPCFQFdqIN/FXiAuleNaxWLCW4pOWtv0xZpMo6GLdYv7PMQkemHBd Q==;
X-CSE-ConnectionGUID: 820s+dBQTk6q7vCjYgp3GA==
X-CSE-MsgGUID: D7VXFal2TIW8BXMMNCE7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61708357"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="61708357"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:31:38 -0700
X-CSE-ConnectionGUID: s0VuzhJCRcuICZPEHA4kcw==
X-CSE-MsgGUID: QdJt878tSjadXHIq6YwSCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143831456"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:31:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 08:31:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 08:31:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 08:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh0xGDHiHs6e05jn4O11Zs9N6AjbFlPeURkx94Fl8JXPX3bovjK+8CJvKuNRMDCKW/QDbxbwz2eAFji5HsyxE1HoJILnUqQR6KSTn4pOyJRDkhMawCKYmNWfWnHePMkVvkgmZPk1BRGAzLXVOSxtrQ6kqy3oUZd2FDLFs3wb4VgC1Hn7jooPnSRD3sgCgkMdfe8dBEFPMK2dDmiL04GPdkjxigjQ9LtBq48OpBCIYhwpj08DqkQc+XczTUKF2JejMrc/7R852CyvyRAig3ZpWV5nn5bI2RQ2jmP9WNO91J9EOC8L8pVi7g2F1j9MWIlpX8+iqzDsPbp9ooonNsfrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNBbUGX51z0DOn3Ah4ngAnGnWozIcSbY5oqlFxHkiGs=;
 b=sb9xdqcJlWl2WskF9jas64zXPP7vIBmK5vIPTV+wck8XN+C6ipJS5UcubOVPRz2M5FroyL3BBGO+eryySDUrUNYNKOZ+C+bG7bsTGhoZv8iJLvFhW55cNZOE3fFSqUvrQtdOdslU0TRQjiAQIq2F+Qnk90IhaVjNP2vs0ri/L6p+8zrz1VcINdONlg+S3EfCns+3lATllMN20mXfgQSlvi7U5EuX2JUvUaVpnEEpWdgTTDoZpBCLfp9p6l9eUWXVN9YJB5/2LpYw3qPgMF7Tv10C68fZhNoLW7kJYq8LXC/q5LdetLZk/nV1vQ8pSOhx9jlMzeYJDWp4aYa9k0WlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 27 May
 2025 15:31:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 15:31:33 +0000
Date: Tue, 27 May 2025 16:31:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v4 3/3] doc: provide examples of using lcores EAL parameter
Message-ID: <aDXaz0mKX50T4-r_@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250513161710.410000-1-bruce.richardson@intel.com>
 <20250513161710.410000-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC50@smartserver.smartshare.dk>
 <aCSJElU1SXiz6q8H@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCSJElU1SXiz6q8H@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 201e78f5-b124-4c14-43b4-08dd9d338f52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jsBLVM4xIj/aoGm8ufAeedChmGUI7FlWjFiERgzpqleoEgCcCUBmWmwS/6?=
 =?iso-8859-1?Q?mClqOLp0utZ5Ww9jJH/vWm8wZLAgeVW0uwvZ6GBy0+2Ni8s7R/eZRF/sxr?=
 =?iso-8859-1?Q?OCl4mpEHK8E8+taP8QbwFQhr77KOK+RH+AVBF6KYQ8L72CkfnykVEC/0DW?=
 =?iso-8859-1?Q?MKI0zTvx4z7I/NOjBmKy1dzd96kdxoiFa/JaMNdbRzmZEqaVM/O7VukY52?=
 =?iso-8859-1?Q?0PpPDTaoiENFA54KDoV9zQMdcUwOj5W417xQxKfW9tq9+zarwB3weNv8wq?=
 =?iso-8859-1?Q?iUXhLNGti839EbssJkkaYxBUGGkNx2kmg5XHtOQHPWcmxW44vnMrXXBhr+?=
 =?iso-8859-1?Q?+it7kSviY5feJtNSOAkokNMS2+wKvzwoN/gL2s9JxGO5vfkhgAWiabwXNA?=
 =?iso-8859-1?Q?8VKWOgUafzzO2Ufjk9WYaMCyHZdBC8zIH7MuvCN9xI+xUIyV8KacX/nPyC?=
 =?iso-8859-1?Q?kJqPs94ioUSErF4VJWXHUVDSmnhg6qpR+r5BeVSXHAfCDGR8bQNxWzMkik?=
 =?iso-8859-1?Q?zybCFUiPhncLTG9DFaQgHe2WXeCKPJ1KMEEb6Qolgji74cxS8GiJ3qDlt1?=
 =?iso-8859-1?Q?q1b0FTK5XpGMpMkpSogjmd+3Pw3MeeGiRBsA4boTg5AbrHYpaDZfQFMYm8?=
 =?iso-8859-1?Q?9xoQGpO00O258S6r1dR9yGP8L+zP+GJsppbnXtZ4P2vSKsAOMbGZEETu4O?=
 =?iso-8859-1?Q?GOeFkg8C5Olv4tdtARSoSlsneCFvB7oeoRI2EOI3cYv2lhLcVtQs6auFpn?=
 =?iso-8859-1?Q?yVp66lgnHYNIRM8lPPcGfUcv8RqIoWE16gBl4Z4WOqNhBZL3iy2vMZ5AuK?=
 =?iso-8859-1?Q?QDiCr3KMUoeey81yFX1oNBD4tcZiGWkgkEJHfQJfNRvFAG4NK7ct/bLSSg?=
 =?iso-8859-1?Q?9iAUQ9Ez1si8rsblTvlXWy1ePgEesQf7rrZ8qGk+UJZmFuLPpGcf4Gu869?=
 =?iso-8859-1?Q?bnXBxMNdwPlHg6EHvt5ErgZ0R/U+G3sw5VbhSLrzRt9sIxE3JH5o0b7HB6?=
 =?iso-8859-1?Q?rTxJ2SASL0khWERpMAs6BfPc1AWFoaptJFJ7P9jsx4Vcuikrn5j+of4fC4?=
 =?iso-8859-1?Q?Qe7ngQs9hMEMGVXAbQHhjSmO7zBI0Ds+y33rsZeHKCSahebPdSGPhNaDvv?=
 =?iso-8859-1?Q?PU5WwaJwBq4DDcBSPWot8S1IaW/+T24TzFUaQAoBElgh9muylbCoeb47je?=
 =?iso-8859-1?Q?tGR0/BVcdIkgy4dpNddMGSGoS2R7ml+TimNBbbruBxYq/fGAKRDDmO0lP7?=
 =?iso-8859-1?Q?yr+gLC+rQgwnIm9yL8L/OoHF1Yjg2pdEjdQPd0vI9Aw/P85fvRlU6Nn/Y1?=
 =?iso-8859-1?Q?734LYw3AIgRdhJ014rh8m2W0NDjOro3IAayJAg10CL0dTNP1FDe1WC6dWs?=
 =?iso-8859-1?Q?7/buiYo/m+d2KzFuPn4CnuPIa33GYG9PfmDO4J+BlUvzFxeLq1WATNao0K?=
 =?iso-8859-1?Q?HqXd96YS6DundUXo0/oTwkpdLThOBLpWPk2WBPD6349DieVwa1dNkxhIwR?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?29IIQBNolDSiux47/MkgI5dtg6oJdH9/RRRfSDpJ+7B+1g1J2IDu9c+Hzc?=
 =?iso-8859-1?Q?PNiE+LD9eNJhIBLSftYBttDtoZqO0DZQEuT/1ILR1JV/SN7OEZwQaPA5EQ?=
 =?iso-8859-1?Q?nORK8XGydnue5c5mJyDo/dYhXdMfNUM0AO2mKpD4vr7foeFz0SnhQZ63to?=
 =?iso-8859-1?Q?Zl+RKzfs36PKP2rVvZ0ut2Iq92x5xCmIfSYenY6z6paX2btF/lTV/Gq6U4?=
 =?iso-8859-1?Q?PkZE7xnK6MHVRhd6s/KBn9VZRL3RZlfBShzZeoq/ZLhHgztnuXCmrte2Ms?=
 =?iso-8859-1?Q?rFW+I6cxvVz/HOAC19WcmOvat1Jen6XXYO74m/xCVZlDmjiOORgxWPFMNF?=
 =?iso-8859-1?Q?403VCHWjHVzLT2CvrU7d+sDWP9urLAHFhqccbwpLOIrQabGGlwfyeF1TsZ?=
 =?iso-8859-1?Q?ZVnVDTPM7z+NvaSTGL66F4pdIVKcxp5t/uWpSNQsLOzSUG6r5L4Heks0Ef?=
 =?iso-8859-1?Q?upcf1ucNH7YjHxYOkrMDgbg9XUeT/Yl9vnzTor1kR4wgjMSYe8v0fR29od?=
 =?iso-8859-1?Q?cMP7V3O95a4fVWRSsOIxvNIGqJieKeU/0y/Bz1560oCnbjzuIb39+GtfOd?=
 =?iso-8859-1?Q?yaO/6VHxkVGbB/N9epFNG+OhIhaMsZ2cv7OWUv3yVGSUqTPLSuXeI2h4fu?=
 =?iso-8859-1?Q?D0WH4a1pe/1mnp2APX/RLfrzCfH2WPmhsyfgaAo5aBHRjfa7c1oyvAQrfA?=
 =?iso-8859-1?Q?rkLWms6huviZyQCKUgKZh1Ox2pG9bgMAWDDwiZH9LMsFAMp542Jxlm1BjC?=
 =?iso-8859-1?Q?3MLQTPfK7woLVlwRsMHJ977gMYkb/bo9H7ruLuSyTdZmxBH95bsCYti3cf?=
 =?iso-8859-1?Q?M/AB4JpTVSsuQVoEMEIC0maCs7fkOmzRLKE+ZgvdMrjiT2NkG8A1fkKNbX?=
 =?iso-8859-1?Q?10naHyNWGnorruLa3UQyo5BY49KCHkREjybqNnmm+cqE0N0QE+oonfQk8u?=
 =?iso-8859-1?Q?wKGJ2M5ZQ6Ny1CIyYUbPW6565sf/GCTNVnzRYIo/QRvDei9iDpO+95+KzZ?=
 =?iso-8859-1?Q?znJ9VPthBdIIPPUQQ/Eutz0O5t6viLZvwiJY5eEgIb+X3AXRiF5kMtmW8l?=
 =?iso-8859-1?Q?LI9m6o4isVdFm64FFc5IR9ZhaJifSrPQVXxnrKy0xMzfoBGIu775UDR92U?=
 =?iso-8859-1?Q?8DDaTiRnu6s7Ng6D2UzXu0Sc8QBMQyv9RiiqpRKTZuucV2Egv+iNxFG6dB?=
 =?iso-8859-1?Q?vfuz5/ZrJSF+cbZlxLtm7aNyLDO7U6RVhV5sKPCs8zN+0bvwWFq5v8CLcv?=
 =?iso-8859-1?Q?FNVaRzy9nV1dGvKH+ug8p7RhYqRgDxBEZoPzZs+5TtWt2a7AXzaBiZJQ5/?=
 =?iso-8859-1?Q?PAmIJFexrAxBoH5wqRktT54Wta8OMYDCVMFrKfo8Z/GkFZaOTRCEJ1xKaQ?=
 =?iso-8859-1?Q?mCveRs7tBe4ocIeJLtqIAIdLa9Kbt828EWhXToNyg1qYUwrsNoQiDM2W85?=
 =?iso-8859-1?Q?v4a2tjNKAVyc0uAL5HFtNtPRPEePJ1ZS+vpupvhoLdS2iyaIpzO2TOU9aw?=
 =?iso-8859-1?Q?KrYqVw5kufIEMyo1YwBf80n8IKVvb+Jd6UP8Q2t/jfj1wxs+iR1ngJUQ1i?=
 =?iso-8859-1?Q?QoYSDduhKn7rCAiD7kXuST+2wpf4Dw8bNwiNWCQAXqZveNB+w33e+iOdYE?=
 =?iso-8859-1?Q?j6/9PD3K8YQPuBbeijKqZl1v3CBBWTuwGeXzv8KpxcD/SGLzZBc9x2gQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 201e78f5-b124-4c14-43b4-08dd9d338f52
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:31:33.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYJO2XS14KYnKxYY40EOTK2J7sb42RTwBEGGg3M/4TLWPhiLHgPevOiXf0xSEL+7ErcowY3TcK8rSZFyDymvQS2H4o8DwHlSLfLYuZEfrpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
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

On Wed, May 14, 2025 at 01:14:10PM +0100, Bruce Richardson wrote:
> On Wed, May 14, 2025 at 01:38:59PM +0200, Morten Brørup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com] Sent:
> > > Tuesday, 13 May 2025 18.17
> > > 
> > > The "--lcores" EAL parameter has a very powerful syntax that can be
> > > used to provide precise control over lcore mappings. The docs
> > > however, only provided a minimal description of what it can do.
> > > Augment the docs by providing some examples of use of the option, and
> > > what the resulting core mappings would be.
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Acked-by: Morten Brørup <mb@smartsharesystems.com> ---
> > > doc/guides/linux_gsg/eal_args.include.rst | 27
> > > +++++++++++++++++++++++ 1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/doc/guides/linux_gsg/eal_args.include.rst
> > > b/doc/guides/linux_gsg/eal_args.include.rst index
> > > 01fe6a3006..d530215784 100644 ---
> > > a/doc/guides/linux_gsg/eal_args.include.rst +++
> > > b/doc/guides/linux_gsg/eal_args.include.rst @@ -23,6 +23,33 @@
> > > Lcore-related options The grouping ``()`` can be omitted for single
> > > element group.  The ``@`` can be omitted if cpus and lcores have the
> > > same value.
> > > 
> > > +    Examples: + +    ``--lcores=1-3``: Run threads on physical CPUs
> > > 1, 2 and 3, +    with each thread having the same lcore id as the
> > > physical CPU id.  + +    ``--lcores=1@(1,2)``: Run a single thread
> > > with lcore id 1, +    but with that thread bound to both physical
> > > CPUs 1 and 2, +    so it can run on either, as determined by the
> > > operating system.  + +    ``--lcores='1@31,2@32,3@33'``: Run threads
> > > having internal lcore ids of 1, 2 and 3, +    but with the threads
> > > being bound to physical CPUs 31, 32 and 33 respectively.  + +
> > > ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2
> > > and 3.  +    Unlike the previous example above, +    each of these
> > > threads is not bound to one specific physical CPU, +    but rather,
> > > all three threads are instead bound to the three physical CPUs 31, 32
> > > and 33.  +    This means that each of the three threads can move
> > > between the physical CPUs 31-33, +    as decided by the OS as the
> > > application runs.  + +    ``--lcores=(1-3)@20``: Run three threads,
> > > with lcore ids 1, 2 and 3, +    where all three threads are bound to
> > > (can only run on) physical CPU 20.
> > 
> > Just noticed...
> > 
> > Some examples use: --lcores=XYZ And some use: --lcores='XYZ'
> > 
> > Are the apostrophes required in some cases?  If not, please remove
> > them.
> > 
> Yes, they are required in some cases to stop the shell trying to
> interpret special characters itself. For simplicity, all of these should
> be quoted I think. Perhaps that could be just fixed on apply, otherwise
> I'm happy to do a quick respin.
> 
Now done a v5. I've tested on my system all the example commands to see
which needed quoting or not. Turns out that - at least on bash on ubuntu -
any of the lcore parameter values starting with "(" need quoting, while the
others do not. I've therefore adjusted the examples to put in quotes where
necessary (and only where necessary), and added just a note at the end of
the examples list, explaining that sometimes quoting is necessary.

/Bruce
