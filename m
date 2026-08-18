Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C2DC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECB04067C;
	Tue, 18 Aug 2026 15:36:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E816B4064A
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060203; x=1818596203;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ElL8jGIuk7mCBTcRY+dJMatYMrYT1XUCREyKXYJcxv0=;
 b=BoLv384GTc5kxtYO7NpoAvw70MySHLJ7lqczXanZhoiiOes1FRz87l7q
 psGhTY7poX96xUz0yUCtD9i5PNGfCcpfHLutKXkGZUT+NBpuLwljRj4IN
 WZxdnzVG7lYHcpEBJ8JloPeUYry3NU+nzYTCAJ1g3E9aAxCd1tLNB+7ww
 lP+Yc+LDpYNzgvMOmbRMxkfVeURbeO5Mfrz8xo/ZN44WaIWO+IOgvV7qy
 PYvRXB/Udn3FcMmPHgsPN7SWA7n+4S3seAQSJNtp56y1rafUQhi3x+dQ3
 HIKb0CeXVDa+EjctyUgExyJPNvzuAf4ZhaDVPqRKtzrfZp5Da6xlebLAW w==;
X-CSE-ConnectionGUID: 7RCvR9vXQzaz8EtDAhhk4g==
X-CSE-MsgGUID: JOoNqbQLTJGh8Z0Jy1W+tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87468810"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87468810"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:36:42 -0700
X-CSE-ConnectionGUID: jKJNE4ivRpCzuJ488om0uQ==
X-CSE-MsgGUID: JrGispKOTrqOaTI5/neLKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261482935"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:36:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:36:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 06:36:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 06:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJQSFeSrpuRKY7KabzKA7s8lHgxj7kRhErUeWTx9GvnbpyD/51rLK9RgPaMJktIkr+kVEbrep3A7Cg3H7QOG6F7h8ucy9xt+wSH+U8K6tfVADG6XexvmRwLByU5DVyFHajBIOi9/oCeqfzyX7ilIEPY+srmGCDZyNGZm8N+r9N7FucZA47GA7DZcnLqVcUjsCUBjvuGLB6XI7k+/ee+S4ow6Cs44oiIvCCdVztbV05j33dAAvix/trUG0wbjAV3/jThwVb63gTTadfy8yvxLp94IHTdztryNwMshtKHXn1ylE4d0ff8JEYlQAfpx9WSQ/RrZ8uAnie5e2t3ji8/ESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s80I2l9vgGwfVTEMSdF1JrpNebeObcvaIRvA5g4X6lc=;
 b=CRK+cEFN/3OnP6qh0MfIge97wS0TDwtGZROJXoitoq0Eiq8edzLLTP7ImDfopeN3Y/PeB4z7LCgZF+Tlkvvx88wExFIF40rHjKDH49IGwywtS+5fmLWYynFLUVeZ8czib+9IKRxVxJE3DIeeEABYs63WFkqvslrnQp1z95Je0y11M5tfHZ45XVbiAaEZC13UgoWdDGp3LedxXz5C/+wbWzYd/Qi0jc4RY2b90/ClMp/ouZb2r6RKFBs3hL7Grf86vXvAVqOrpoSCAiA8/uzcJ9+zvjnIMBJqTsLkl/99xDzESe0CuUOtGreFaJC+4gR30RBfVkTfK9TFXslYNz/O3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 13:36:36 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 13:36:34 +0000
Date: Tue, 18 Aug 2026 14:36:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 03/39] eal: define new functionally distinct config structs
Message-ID: <aoRf3ukAxZ0epySa@bricha3-mobl1.ger.corp.intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20260721094555.2188496-4-bruce.richardson@intel.com>
 <20260727110338.777d5840@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727110338.777d5840@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 712bbdce-71ac-42f8-b168-08defd2db84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rV6lIiEIJdypeqJQZMlkva0L6C4VSRbBXx2ovYmeDZRipsx5ZcGgYuDaH0EwhT1VVtOptWkPgxQLpeh4CkvqMtB/JVga0kmND84O/mVn0U8Edy8Iu/ScIxMBxUK5dCT23DrAnYFpxw5FbRarNjFKU9R+BHkXEaecLrUwdnAZb1cvtRxUiqCa4LorztDJJgN71Xw2SGWxtsNFyPs4E2KuheOVaw5XlqB1ByeCRS9NOSVIe3QMbGI3KIlSpZTG4V3KuKW2HNskdFxW4+Dbf/bLssu3iPXdXH2jIa+6AT9j464MrKQhxv6pMHdmc+sXTFZgn6XpvNhw/8Fuw0NH3IavdbqwZ0Ngcnqa5jK5XlFwLjOEmPhoPpah62yhkgLaDiVLQ4s7aVWzWWU1uHBpbM5hYwHaX/6bCi9awPN9so5qQUJ9U0ZA4Nrn/h2Y2DjCHHs/jqvo5dzzgkZg9TAoClqKZcIEfwSEVY4MSODKwbCLsrXz13++Q3Yd6glFkX2r5GcHLaYHNQAA3W6M1YnoyEPZhWGx9lelPq7nwVe2ZVARrkkzMCOnEi49cihD16buErH6iZwD2Joh6kul9WTlhrIVc0bZkYq8hJvlDzrPld9KMdmomTUbndKZntx5RPgBI5RbbvQC48y5QvDfHmqJ0HL27zvvtZppL5pTXSlUGxxFZlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNngibAz10XrD4la6ZYmEDTOSmkZ/toF7ZIEgnWD43ag9d5tiScvMgoolzGQ?=
 =?us-ascii?Q?7IDGmOuVv6sQDk3JG99pInFvFXqsHQR0WBAZ2SAtOqg5eRkMYw7j7tBXZqyl?=
 =?us-ascii?Q?pJrjciJU5T95pBdFzn06sBxdtzkcx4cIBwV2ecS1hfWkplWpieXQ0tgKaL93?=
 =?us-ascii?Q?7MtVVlPzyjpBuIdv26tplLyveM1YHMaC9NBmXT4EDVcPosDaHJm9xDEmWsSr?=
 =?us-ascii?Q?M8i5ucXC7h+QnNiXpMf5WW2YB5uWpIYy7pZDBGI3rSXv/8kB+Wt7LlFgUdPW?=
 =?us-ascii?Q?Vx1HRcvR9lcntf5D9Xtaz3aRFjQOwvZ3jWnrTfPwnUZS38FDM3LKOvusZpWW?=
 =?us-ascii?Q?UwhDWYgrRBmABNFwedR9XHWwiUJlbFH5Rm1sgbNzHpiimxfEeAuTQJ6Dquuh?=
 =?us-ascii?Q?pXq4mKquJj9g5HmGE4YnH5mlHbFAZO+PoApAmysYqBbScJXU7hfiET+i9VYZ?=
 =?us-ascii?Q?lzSsL/dTIRe/0qbKuFwu0myPIcQx/d87N/N8AIrt9zsWvXcxPBuhPAb+Wo6F?=
 =?us-ascii?Q?t1lglzyjgQOJjvPG8zIkyar4hRphpYx+m3uwe/UcAMSclS9lmfAtorjpWaoJ?=
 =?us-ascii?Q?eIvyFqTL0SYaTSuc53/jH1HCn0lT8UICxCsIdc7f25M4sFZ6CuVVMYFXYs6Z?=
 =?us-ascii?Q?glYNrEaEnCgFQ56m3xFHnTldHgHhcIho9EQzOmR5z7e0HEBhBFXLqh8nePYC?=
 =?us-ascii?Q?UZ2ccRJcrTRr2GiZ0o9Ned0W32jI7S3Hw7R8k1uySzgmjSANk58WDa4BZ5R6?=
 =?us-ascii?Q?+Akvkea+jimNHL4yOfD0T7dHUvQopc8QgZvCwiZjx0zwwR2M0mqxG5NQRHvT?=
 =?us-ascii?Q?wgxB/O6hSCet9MIrrKAwpBU0NZsLOMUb13GxY2sAPyWKyQzuYyjq6LX49RHl?=
 =?us-ascii?Q?A7mWmPouRQCF0u0dHTa8VqVak8m+VWWH9N2jwKVQ4Dqb2hc3wwpYOUqKsnEI?=
 =?us-ascii?Q?dw2+dP4wldp54ry9Aqs+VhW1N87u0TKASrM8NF/7vr1+JYMypI8rSn/pBWLY?=
 =?us-ascii?Q?WL+MSjzJ2ZlmpwH0IZyDKNUMhGWTNKw6RrqcNtaMGuDlYIfd+LRDBQhuQz5i?=
 =?us-ascii?Q?RFlCFQoukfS1dDNPWqobW71tIW0LMvS2KbGcaJimMaTyOIJ+WOE6DhWX3ix3?=
 =?us-ascii?Q?JxgHHOwyIrnIxPbtfY9D9sMN/blurSnrAA3nrNnT6QD3OV1q7cFqNm+fwXT8?=
 =?us-ascii?Q?0V5E/IFt4IZo3wHBNmAO4jrbINxGOc0tDKZK2xyedPUIL7qLweFQ9VI4+Td5?=
 =?us-ascii?Q?qXu1dIBIDYGEWkIRN4FIdDPG/Acg0Ui6KGk2+3+HE1Ske5o96n/mpAue/fqf?=
 =?us-ascii?Q?SvuXpYW6kJdGhSpGhkVSJzDP21wtsF6ImK5efcXEs0WHbzm2w0yD9Vq5IHK/?=
 =?us-ascii?Q?Upm7qtlwCpd9xuhrrUdbWEHgWAKLNAbdcLYHwjHX3N2hwSuV/n8VBQ+VhEai?=
 =?us-ascii?Q?i4umUXm2MfDAyT5yJTZ6CvezkERruRZV8JYU1iK6I6+8cZBonGyj3LZgQWMQ?=
 =?us-ascii?Q?KhQzIUqrmiq6WYAanpj2Sl8noWk04B94pz982mMLkIZP4eVGKqypzISDAnpq?=
 =?us-ascii?Q?7IzQYo+KM7C5hdkdyjzYpQAbw8K6klhNMGECfiyf5oHkoe+RSNohYmA/WWNQ?=
 =?us-ascii?Q?x73kEtwf8AcIGtdEA/xMHR63LiTCgWzMNjIAUzujXoB2nrFPX1qtTMShDQqA?=
 =?us-ascii?Q?rcV/ovpsmqB94JY/+4W+eW9tqqTQbM6TTB7tmqY/S7CnrbxSpro86Cy6w/ol?=
 =?us-ascii?Q?faP3rPtmLvwpnQLI4dh1tQ8e59OYiLU=3D?=
X-Exchange-RoutingPolicyChecked: ngmap1xEIQjmvx/HDeCJxHfk1WwJjSwkRbxnwcjqCx7jXENsKsJrvSB8sV5kXUwjxfQDSMt3iz+cTGUjI0eiI8LIMyXZ/mDBCfjxKK/FTzxcmWAptDxz92gtG0O2DmZGHgw+ik7EC4UMg8441vvwoSx64Z2e5an91yzYuuRAESvBjex/Z41megU1UQI3OkzPHCNnvY+Hc85lwxNFefYcdKcKhWSLtcXOEpcevb7+vmHTLjWAEXbNCp45s4oKjLO6ntYbvUEw3bpQUwmXV0flocT1LqVL4pA0Uk7XJ3a1HErhTnzoARRvximcQizxldIb+/rEIATPFDL2h4KN0PLihg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 712bbdce-71ac-42f8-b168-08defd2db84b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:36:34.3190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QPiCMMZhekf1QhHStychFh9ZsoyopqBbCe0+Mx5B1iUeogxCnwObtGHWwbFKl2vr58H2ZCsNxhtfKRAklTjWEFANOF4r+AEKp6gcyRGDvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
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

On Mon, Jul 27, 2026 at 11:03:38AM -0700, Stephen Hemminger wrote:
> On Tue, 21 Jul 2026 10:45:11 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > +/**
> > + * Internal EAL runtime state
> > + * May be modified at runtime, so access must be protected by locks or atomic types
> > + * as appropriate.
> > + */
> > +struct eal_runtime_state {
> > +	uint8_t reserved;
> > +};
> 
> This reserved field is still left after all the patches??

Yes, that was missed. Fixed in v2.
