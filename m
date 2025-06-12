Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B222C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 16:47:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96AA842796;
	Thu, 12 Jun 2025 18:47:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1D04E42789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 18:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749746853; x=1781282853;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xbsbGTgifSBE3hdPkS8rWfyQLuShotu5Qx9/0Qz0qjQ=;
 b=cFj4QGhr0O+YqwxcfgXEGmdwyxI9w5VDpYrmFRneRZ/1G2b9Cl0MiFQ4
 ztNmUKlNbYi8iYx/OnQswaHYoYhJ0xVVPwIpvCGF5Q+Dd5hwITO1jH5DQ
 m9MIJ5lUdKX0Vy6zXQPsYel43wlikBpqdYvA+ZowMhpevkJvsR8//eUnw
 zUvDpXDVssaFc+WvPZQfz78i3EonCjnvEKrz+lTF2vfa+yf/S/1i0YYWm
 D7A7QKBfeMZrOlkopC4r/FMlG9tlE9Gorha+UsL4mJoBU44WJNRrf/QRy
 KRRCthSmrMmJSk79CAq/znVG8Y0vM0SqzAIP40jnfYxy1hYzTgjbvR32n Q==;
X-CSE-ConnectionGUID: 4zaiMg5URB6godXJDJDAcw==
X-CSE-MsgGUID: BlAy1PoqRw6M0wGMtZYOnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54570057"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="54570057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 09:47:06 -0700
X-CSE-ConnectionGUID: oENyE7MwTyKC5ifeaYdfzA==
X-CSE-MsgGUID: Row+EVdDRe2ZUhDNITS9Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="148478028"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 09:47:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:47:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 09:47:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CybaT9z9oG35A9xa/LnMeTRR8jJ/yUv/UajimVKH4ZaLtAx2twRK1LVyt2dYHRIqsLQ5lJbXmPMgO23pSsuaknwK5cObEHJPuPATGg6cvdCvvhbzzpYXzbE2vWlA5B5iORvyGmmDrgYXV6sMqfnKaB6xNcNI2/IZZFE8uUXR/3oRUkN68ayZ6FXFjejKeR+nVLnKRKbCAWgXX4thnuHHVO+bhf4AZ12n74hKla7c7GultodFojrTR4XpejQX96tN+83jxRIKXdTcYK6ELjqjGPYXbWMlZPS6dcQbUQbofIEESqOGUq5sbKDUjlpofUWceKPWoDETbOqG+JXy3ofiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjVTCAqo+xlAYS3g37HMVOODgyquD75mNa8rf9iNsSY=;
 b=hMtbdpTW7K5ZacK1S9siA8cCbAZUULWh3qT5qIRKOa9Xbj4yU+gfXj4RoNQHyQduPKgq9478AQQcaY4o62FrH0Dbhdlw4DZgp5cXA/O8q3a5xQ4+I3GHwVOck6AjjB2corgWx8Jrcizc+pTGQZPZ4aZ6UccJHK+Bw/lrAmE7T4We4mDOMlaRbfe5J3/WC1Hcpzzgzq/QR0Y++E/AcKX1ZNXmk89q5UxCxH6ZCPpVsFXtIWuizDQ9ICzQXL8LTUp4hupdEo+vgQsSmB7BX+5WEOxVheyMS3Z2R7G39W87Sscb5Dk6fA7m7mA5q2/N36FmXoKCLfJ3PQdHlMyKdd1oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 16:47:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 16:47:03 +0000
Date: Thu, 12 Jun 2025 17:46:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v4 6/6] doc: announce TxPP support for E830 adapters
Message-ID: <aEsEgXRDmwrH8Csj@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
 <20250610131159.495566-7-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610131159.495566-7-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbcf6a1-ce00-4e1b-ed03-08dda9d0c1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OokR16xb5QXxYC9aoRno9eqnPSKCRhD/Xd0CqyNPh56QvY1difvw++F/wW3N?=
 =?us-ascii?Q?MtwZQt+SDLw6QP9bcObDd6fYThWPaDGRAlXOqHnvqFwO3qd4AusnqqUL3vWe?=
 =?us-ascii?Q?IVMGhl4i+Ri0UNGAo0Y/c4wVOvCEi6SOqicuOsMaaBPU5CIraDFT6ignQwDx?=
 =?us-ascii?Q?XWUV43O8LJN8bW7WrLuq/qODyOYS369t6sWLNVz5+tD7DkfqXaG9ht+1kbxG?=
 =?us-ascii?Q?N2KlE1peal9ELv07kUooHEasU6sickk9QjEhk6HhTALe5hBVLF+vs14ybH5s?=
 =?us-ascii?Q?8a+Ta4B0DPRwRSp8ADjYzRD/MtItZX9lsUqnX4Hu0Vu8WGilDM9NMUGtZDWa?=
 =?us-ascii?Q?xm4xZplzVDsdiEl8nZAR+gtdS7yvsVt0XcG2RTo61mObZLan0/U2Hk/7zQbI?=
 =?us-ascii?Q?H/dpnmibqn8BRQnoLrDJ0Esaykc8b1KhPHb0aeEqJmzHCkuE419i5yUz3BVs?=
 =?us-ascii?Q?TGIfwc8mqgywZ/ihYqkY9N8o1DuYh9OWrgkxLV13c0RGEjT5aSTzBU/ld9RI?=
 =?us-ascii?Q?CUuERwQGcdBnVfvKOP2uqT11e/qsKtG3rZUYTSlLNRaktcU7aiI6qutfRRz/?=
 =?us-ascii?Q?2mbqYs2M5tnSujbISLOAVoBgNSg/DSU2d80+YRG9d5KpH/73mJcBLK1vizyw?=
 =?us-ascii?Q?rqt2uVQp5gKGDXPk6XcNVgs7rYyFFGV8XJfPbMV44gdKPtMRigkaOkmvAEzc?=
 =?us-ascii?Q?CkZC/RaHG2ZXgkTerAd4VDuU4yIG5rr3rSKmLTOaTTdQA1Q5iqMgc8ufFY+K?=
 =?us-ascii?Q?zaiCAkkOdDMM+cWWLubnDdRyonZsMouzFBiasEF2vxxtRQurysHh8ajVTBmz?=
 =?us-ascii?Q?2oSSDWtelaY17gHIO8/3sgdD2hbrOWX2UecTxy6ll0LUZNTIKYflT2yrkRa+?=
 =?us-ascii?Q?LecL3LEGTrFd4OdK5WOz5JLvYtju5cbfwNZRItQxj5Vu0SY6b8ZyZ2bBvF3m?=
 =?us-ascii?Q?G0DesMQJjW2kV/1USHYbDxFDkd9Ee0JtonGjZ0B6Mxf5BJS9VVt8JDzHiX71?=
 =?us-ascii?Q?sSSan3mXuriXYtTV+mj+X7xq3C4EXaAjHqCkDcAMNMuZFh0SZk7CEkkaYIOj?=
 =?us-ascii?Q?GLOHLnwxHm4jGAbtPb13hujbKG9qSl6rYm5zqczz6S/v+9cfPJ/FbW9usLYW?=
 =?us-ascii?Q?ibtwuSplDli7nMdyms9rMWeN3NM+Z/QsdY0mkalNn1xtk3l1PdtghsldHRjs?=
 =?us-ascii?Q?USxzjNgCk96BwwJQjZjz6P6zTRDJpDydq2Hjfne3tzXjO9ok/jHD5itYtAao?=
 =?us-ascii?Q?zsNGVrQoOxDNSx8JNWDoYKLEePcbwm0IxPwvXH0iD0OZaWI1tGG/7PyGrH5s?=
 =?us-ascii?Q?hk/rcxm2hTKBIBGZd6Z/hLPSTVLjUpHLBB0vzRXiH9h0v10Emu1ZaIH+IfAB?=
 =?us-ascii?Q?DedS92q+zo3jnavBgssMjtlVWNFWW7XNT3ZhJxS49X/3MLDbCqFAtH6QwAQ9?=
 =?us-ascii?Q?LzjoJ1XtNG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?STISAZeZXBGO865kaTKgNlmyrb30eIrP2GSwDlbrIju58ENHyowbYqeHl2rH?=
 =?us-ascii?Q?FPf3buCIcvH5F8r65kf2/ilVwvtMI6GXKWEJ9IeKBqILhPC7kVj6uJB6SrrA?=
 =?us-ascii?Q?nAq3CTBNbBnuY8pM05QTxvd/T9bsGBhhKCsQaST8BJVtdk4Pz8xBKXf97uvo?=
 =?us-ascii?Q?LZeedeZyJ0E0Qm+B6vwC5MKJ5zBkqZ1S6IQmS1OxVS/kVI4kXZi7bfw4SvbF?=
 =?us-ascii?Q?c0HIWtWKV3iuQYivFI6bKUrq8UyhMzq9x7n6rjDYXVRoplJ4Cu+3+Vb/ERxo?=
 =?us-ascii?Q?9rZnRvqv67aNjjo1NopNeD8uFTIk1vcm5uGFDFGIiTGm0VpF/zwQmyuvQfdT?=
 =?us-ascii?Q?CFDWubbhQ9iA8NiRfmpP2ys3BxOYWLvC1r2BvP4hANYlMwnR7XJX0vdsvZTk?=
 =?us-ascii?Q?9RO/1cr3ml2iPRFWUvXGNX2V/OOynOWEXwwfYECQClYO6+Xy8Kk3mJeqhNM7?=
 =?us-ascii?Q?8NeZRPiayCq2H03Tasavd+HWubAjC3/8g15eEpVuyCVPB5aN72L6V4j+gUZ2?=
 =?us-ascii?Q?5R/OxP9p+zOgYpTbP98zV6Coe88QUEjrlAhq7gvhZ1tnbTqzm4iT9RhnEXU6?=
 =?us-ascii?Q?WvxBWn6VK+Kt12IzZP0m7jatkTnXX5TojA6UTHW5V/JXospwtoe6UlxXrSWK?=
 =?us-ascii?Q?9NbkjfOMTI9OykWKoxoHxxE95jdeMfolGl2K3aancrLDa6jCEovzRbFhdZHu?=
 =?us-ascii?Q?jbco+myy4KjzbJSdDLNBwJMyWNGKP86GVuIdtZ+WzDjqxDeLi/eeCbXdmfQ3?=
 =?us-ascii?Q?JTk7S1ix6NmOxP6eeSHvnONGm3KIVCpeUBZLq2GgNUy+x7vFY1Tc8gklQTPv?=
 =?us-ascii?Q?GCYZDN9objsKY5mTExP0NB1JGMIOk/ttTw9al8nKY8QtlBTUcJmLzkCQTAUN?=
 =?us-ascii?Q?umIvrUEHwFGkqzhIH1HKeR+D9KWNWKDyltspbghcwRWnwzqrUbkt7lN+V9G4?=
 =?us-ascii?Q?/9guEy3dNe3jfcbQhDjEGVZuAlJQXkisauBymOCux3a3zK29ltm7djRuqcK4?=
 =?us-ascii?Q?TIgVrAzRMjbtdC61kmpDjzgsObe89BeliUK1If7GGro1JHFnkGepZf/b1xS+?=
 =?us-ascii?Q?hUQAi+ENlwByl4EpdMS3zRBRfRiNxxTc+rpmHtny6MZT/6VKdCr22um5vMex?=
 =?us-ascii?Q?RC/ZGw4buySO/TpryGpE9t0eCK+Fl9e7lrxi3Rg37Hd+nvHad4+6VpEZyhaV?=
 =?us-ascii?Q?Z4V5KCZQsBNGCcw4yMwqQO/rkauU94HD58NWtMImYGF1qtIreZ9wtomHo22W?=
 =?us-ascii?Q?91fUJiToJYGSEFI/grjtv4lA99tRutfPdZlqkAKYzJwuclUkrhLb0GtsT91c?=
 =?us-ascii?Q?QOHL7Pt+qMu2oG902EPzRFERID8Wi0AAB3cQVkWjEUSayvGwL3WR2+KSp0lo?=
 =?us-ascii?Q?JmkDd8Ab9VOaOw0t1cntqbfEpjQfbbQ15Mg2o1htugd+0gMKKhNQ4C61O79S?=
 =?us-ascii?Q?4Z5COmbhxlD0hGR/urPJZTc59LQ2ArUJxb1C6y9XaXsBwiLW9N94No/yURu5?=
 =?us-ascii?Q?p1AtoT6ZqPQMFvPEOGY4i0zflK66u2sKVWXiIyIgD5nE1OvtjoSHnQeHiq1o?=
 =?us-ascii?Q?ObbBZEpA9Kgna3h2vOwbeD4Dd+2soEIhIHSx75KKy6Vowx+Vl196Jgip+oDZ?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbcf6a1-ce00-4e1b-ed03-08dda9d0c1eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:47:03.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ixcAL3uacGM+38ZODRE47F0ZF4ahnHfsybLzB9dvlDet8hdOq2NGmjCUfcEkenbyfJNls1IR6Z+d8ZYGg3Banu59LVPZwg8zpHhL4wPhF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
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

On Tue, Jun 10, 2025 at 01:11:59PM +0000, Soumyadeep Hore wrote:
> E830 adapters currently support Tx Time based queues.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  doc/guides/nics/ice.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 77985ae5a2..f284c78290 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -415,6 +415,24 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
>  
>     examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
>  
> +Tx Packet Pacing
> +~~~~~~~~~~~~~~~~
> +
> +In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
> +used, the TS Queue. This feature is currently supported only in E830 adapters.
> +
> +The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
> +In order to deliver timestamps internally ``set txtimes`` is used where inter burst
> +and intra burst time interval in nsecs is provided.
> +For example:
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
> +   set fwd txonly
> +   set txtimes <inter_burst>,<intra_burst>
> +   start
> +

Thanks, this is good as an example for someone wanting to test out the
feature using testpmd. However, for someone wanting to use
send-on-timestamp in their application, is there already documentation
somewhere on how to use it via C APIs, and what mbuf fields to write with
what data? IF so, please link to it. If not, we need some summary of how to
use here.

Thanks,
/Bruce
