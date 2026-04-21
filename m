Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180AEF8FA8C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 15:28:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF6554029D;
	Tue, 21 Apr 2026 17:28:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 38FCA4027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 17:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776785290; x=1808321290;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eyCySe3MUMLYE2Ct+LCqat80Thhlm+pPfGyl4/LbU5I=;
 b=guzYTsDSJVQx7Dig5NGOARCsyC/wUAdIaU4EdmW9HEip3u7v5KnSn52F
 G7PIz+MRMNrJlr8TS24/605wuHNHmMBeIIMxcOxb/BjqYXrBCu3i1tTYl
 0UgUMdyhYvrjIqNPJBpQI/2bcYjlBOgZEkuwOJLxxdzoRXgYisZ8BzWya
 k1XOi9hqH0xOp7mtKRZJJF/ZSEJJoYxW/KmUB2a0XdVGyXCQ89G/mGi8x
 hHlYYlnyYKfZ2VtvtYdBGllKp5+xA2dmnpUByd7psBZ9+GpZqEiNc2kj1
 TZiLyHCuvOOqZVfd7Fz4kHwJU8llRNHfipSI9n018Vujgc+c6PnnpxDW/ A==;
X-CSE-ConnectionGUID: MG+YRvowSHGL8urMpX+ROg==
X-CSE-MsgGUID: mqC/pCGDTBGCBvSDIa/Grw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89101994"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="89101994"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 08:27:28 -0700
X-CSE-ConnectionGUID: T9XLLwxYSWajQzWeETDNGw==
X-CSE-MsgGUID: OiTN1RljSC6cnRzvZoaqUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="255323253"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 08:27:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:27:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 08:27:25 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNyoCRWbvPtDbHGOT0Dclev1qK6kRctFBujSTkpVT50aL3kWBO9isc+AXFdWDBKMcrBv8i3Kqp3bryeUkzD7bPMvqLORvEZOyEgE4+NJeuC5j0xX+JorIm9Na6nEXNKzThJ/rmTwvn3kYyOPmXyFLz8pKJh+zpMibv7BzMSpnsQ9W2dwDoDmVPJfnwHJ6HYlOEm1gVVvvV8UpGor1G1NNUUgDkvVbF5oQKbPyNNaV6ZqJ9UMXSCaGjCKQNGLQBtpEIDFB6CH90KomsffY9C+iaNGDLB3STEDK4bk1apRtfAGnRaHiOULAq5uY98ZTF/6tAtY5/9B8+bgojM05BstNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXT2Qb2nCH4IrQHPk+CiDMPLzL7UyEKBovDH1piaeQQ=;
 b=fGBmOJHTIScKyZpCzTKd6TNqwGLTxLmdfDKeDL7I3j/DwETuH0gTEfgltlatRx9+TlWc/4u3lgIllHyBpCjfdqY2i5AIF07DPpG6Gq/vY2kdgHxhoRb7NrF9evqC6/luGSmZmCnVksK0NXJYqz/G/kBOH6RQdpBZjMzQj0+r3I8z3IdMkfzlF8hGW/XQI53KOXjqV8/5zOC/EojJ+GIdQWjnuZ+5AWm6v3XmsTzt4COtzcAI/MtFMIGtUNKJjVTLy5wznT7mZHUtJdE5cR2tzK00xpAOWoQjRJhBEmdLUDKVCE2Q669KcCdZe+bKkdCBH0irAvb9uLdiHFwNmhYTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF4C5964328.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 15:27:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:27:20 +0000
Date: Tue, 21 Apr 2026 16:27:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <thomas@monjalon.net>, Adam Hassick
 <ahassick@iol.unh.edu>
Subject: Re: [PATCH v3 2/2] test: simplify spawning extra test processes
Message-ID: <aeeXUZ8ZW0ssAXK9@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260408174404.2002743-1-bruce.richardson@intel.com>
 <20260408174404.2002743-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260408174404.2002743-3-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:10:234::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF4C5964328:EE_
X-MS-Office365-Filtering-Correlation-Id: ace45ce8-e00b-4dfd-850a-08de9fba7a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: f4dLrCI2xLpX32DyyNsKljAuVF1zcByWfKqXRiHefBg62cWCoon5Yedfw0KI/YpoyzP/d5KCpnHDmsJtAp8wQ8bKpfXgu/XtDkNymXLPdOzV2uC/mLoiFlCNcNHBP+9aDkX7UsSauibvBBb5UMNZ8TzHER6QI5pByVHXqGGUSXG0hpsQQAJ5KRIXa2gT5C3Trp96xC/YBJwrXowP3Sro8aYsuXOeIn9ovAJFJ+Y4osS9499E7ivkhLntyxNFo5ihxvrqePjQ9ewNvmflU4+k1bwGDQVUagGDyvRZWv8BDRS83lQQ+mBZDwdHYc36mfuV1uLEY09aEldVpFXAJTmbt7ca+PsNgSxGld2S28GWtOQIQmTE6lTJFP/ap972R6Pcyn7KAk948o/IN46oEZc8mfCW+mLI/8CR7x2mFpP5TMjvp+grVKjVIhY4lavZPkp47wMzmtfstFZkC/X0cAOekBTZOMc94hMbZ4K+xarvQkggmkzt0aMJu1+yR5X+jbMpu+wq6xoSvm16Fc4g7s2dTBJtzXoDs3fTe5Lup9JjSbp+YHnHJNCxEpBaGOI5T7EvKxJL517VDi+8LQ9i6VCsMd6qrRRKF4SyyYxX25mF20ruryt/ZmWOQMvmyn9gAVXNSHbI22Ew1U83EWVwEDDpUNkjJs0w5FjXGuD7c2IAAzZ6MIGS2xS24TOErWBic8XM7YqTxt7pqwCtudZtu/fkBrvZwy0U1Nel4cCaE8lgW08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTkpSC4fWksDciPw9+UXmVJzD+bAqQTxVHe+8AiCfKi2nDZJHCZb5n6j/ZhD?=
 =?us-ascii?Q?TLTpF/o/uwQOFA8kQMeyKi4o7JeLWC7cuyjzh6qqpqqZ3QjHCnXMOZ224ThZ?=
 =?us-ascii?Q?LjdMBx9RIvfwBl28af4kHkt1aIW+dB2CX1HBGUao/Ks6HVw85fMI6aE0drsg?=
 =?us-ascii?Q?izM/RoLbb1NJGuFQ8jhhUyh3vDrloUd6UYuY3IaNVPwLb1c1vUHUyZ7MqhT/?=
 =?us-ascii?Q?4MVMNzlBWBfOLadaZsY4hKuhGA/VJned2H1CbJciEmDb3HwdviqHAGxgY4Oi?=
 =?us-ascii?Q?ScD6PVDJUc7dQjdAsP6HLHKzD1+Rg4xhXovPK76wf1DXhOSsz+CSKjRL9Tzb?=
 =?us-ascii?Q?mZCvEO+yPZlHqIxFZpVCyid6Ak2WfGgGBm2J9CRYZytF460W8mt29vmxfJDA?=
 =?us-ascii?Q?xzHG0f9JCDmW923uSiDT8flEb5A06i0qcJ+dEKRYdNGlxFl3Oswz7rTG2Ry8?=
 =?us-ascii?Q?5j0UI4HfRpBKyCSuNK3UxoY1EOTQm5gJpQiPyBtAfv67buYKy8Cf/xm5byZn?=
 =?us-ascii?Q?VovBs478Mpsn6GFVGLhgKWcgnDRGRqT5pie/px5wVElam5iteu3CsbpN2WM+?=
 =?us-ascii?Q?YxE7eLhAzk4SURevKtbqyd7WoNm1UeJgfcOxvN9Cz9jTzc4DavwO1hABTIcy?=
 =?us-ascii?Q?wdEwqoQpnKL/VqNAnR9N2avLkZdzN33UT2+b4lRtA7R5GKzn+4gZ3hB2Pnst?=
 =?us-ascii?Q?4pKQQGamhQjvx9D/LmaPJoAkMFeeQ0ve9AY8WPzJx1FRuftBbtcPRdso7HVH?=
 =?us-ascii?Q?dNSN2gHAuLykXoky6uPdcYOiQLoxkAH1cgxFoG1vwHzTKCIZkhyUPHs8FmQU?=
 =?us-ascii?Q?pDDbTtWKTRvKw43SOQt69sCRrse1fdSvcX8zQw7KmbtFBCBCFDQ+eC/8cGft?=
 =?us-ascii?Q?XMOKY/ngapF/nXT1WTVLjQurvEvvp7tfsig9Q43MD69EcrieY82GGw8Map4D?=
 =?us-ascii?Q?cYPrhexHpGdJyRpeELDwFw832IsOgEQU8WuiKJFw2X0CrHEj9rWSrPvDfuSC?=
 =?us-ascii?Q?dr5HarR64sMljpzmNxi64xGo1x7uth7XS8vVRdHfnrVhMUR3EMOb82NSNpWH?=
 =?us-ascii?Q?wdVLjfR32Xtqnj2FozUj7/x24YMQj7txpSAv80haPYTMX3x+YrN/rKNnxBho?=
 =?us-ascii?Q?Y3HRSZYu7e4YUmn4TCNZ6A4iWbgn6Qt1L8ugUvlBrVagxuacBFWmhbwz0Q1d?=
 =?us-ascii?Q?7tGq/2VhXDFymD71ltD77EUklonak2n5VI1jOIKMnPRmVMO3W35c5fI0SXmr?=
 =?us-ascii?Q?zj1sBfMLecyIEG1OZ1EbpZwozpV3mJcwFicLVrcTtNnS6+7DzO7yKwjbH1qw?=
 =?us-ascii?Q?RJ1eowoXQvAWShttX5P3Qw/5OOW5RVWHUANM4atWGgYH/uAaoYmXxsDBTrx/?=
 =?us-ascii?Q?ksuZgwPJIwNZMKsMeV80wzT+yLlBFXW7zW/y98zgxUnWSzE2Yc3xoOvnYRk+?=
 =?us-ascii?Q?a0e6NxywPAl9+MCXDwC9G/lkz4HII5Tdym58w6RbnaYWsRQ4IYIOxSPlaDSE?=
 =?us-ascii?Q?6SoIq5BwSGeVImzpaiFsxcyT3BzpvMM00DsYDedpQJe6uyCMuO4IFDoGldgK?=
 =?us-ascii?Q?M9eE7W2zHZZoGDAc0GVotj7vrHpvALF+2KRzte5PPHvARh7JoJ9+ksQ0Kutk?=
 =?us-ascii?Q?qwhX0NaPGMnVqKEcVMxUNL8GKOmtnTdjUT5M5o1uHwRlfiBRX/DCEg4RwukK?=
 =?us-ascii?Q?QI4dykSqzky0uxNND0CNbMJjdu4WDqs/29NR89WKM+cA9/FTXHie+30a2UWS?=
 =?us-ascii?Q?f3eYErdxZ/HGNO+VKjQ1GFyMwEe1wmI=3D?=
X-Exchange-RoutingPolicyChecked: qpWENAVEqiH66htYpdCNfemLvaJuqYC4lgbFkC0mdCht6HcXpYFdT3x7DGMQ9AW8dvlr7d/dUN6IZ8AThMVCVhNBUE7JXFoanFVLNZr8oM1zvZOU949+Tin8vj/k9Va9R9QVH8alDUU3+Mtl+vL2uvcw7iFeuq1ga0deTlZSYxSgmeyEWgPqfuXOvEKBvVZ6Eoazi2DiXVRlIMUDDRTdfWgsVlEpkwFkdp4IpYgIBaI2GM4jR1O5U0U69CfbO7BmPWJvycBs6oEtPHOFGp+6EBVuFh+lK+bUzRUICpUOH01eDrVDRbbi3Z2OifezPsuMDk4VwqrVjx1A9TpHEOW08w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ace45ce8-e00b-4dfd-850a-08de9fba7a20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:27:19.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdOZJQ559MWTS+YtJG9qhB1jPre64QkeDbQem3vtUICeYXLdbjZyVoRC5lI9g0zpc37TMQme4LybjDMQM5q/FDbtYHF8qbGWyigsf0cgb0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C5964328
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

On Wed, Apr 08, 2026 at 06:44:04PM +0100, Bruce Richardson wrote:
> A number of tests require secondary processes or additional primary
> process instances, so we have common code for managing that in the test
> binary. Simplify that code a little, in the process removing dependency
> on procfs on FreeBSD, by using argv[0] as the binary to run, rather than
> querying procfs for /proc/self/exe (or /proc/curproc/file on FreeBSD).
> The unit tests should never be running in a way that leads to argv[0]
> not being the actual test binary.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Tested-by: Adam Hassick <ahassick@iol.unh.edu>
> ---
>  app/test/process.h | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
Recheck-request: loongson-unit-loongarch64
