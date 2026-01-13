Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F65D2F33E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 16:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ABBC402D8;
	Tue, 13 Jan 2026 17:25:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 838F340276;
 Tue, 13 Jan 2026 17:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768321553; x=1799857553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=859jvmYnZngxvnQ98co6lRrS8JEgAzkM0xmXzzJ/wo0=;
 b=lhcS/yYsW+asXmCCL5z87lN7ZqVtZ4RhsrzaViQRGPdhJdf+VcCLqP3N
 knrb3dWj1i16bTO8WURzYPDFGcTEWZrmoACmLFaqCfq/vBjYO/zW5W5b0
 Ju9ACLorKarfzlGn9lWWswpq3R9swRlZISVeIhbngaI2OSL9IlykcLp/E
 N//gzY2tTK9f84NduJW6ZmitasdxdJMV+Am7qti7zORHxB+PjRqfAKn1Z
 w4tVd1QT+UcL0ECXcGwAD/jQeikE+Pico79QWIYB1tk7of1mgBgcNT3Zz
 p/m5/jYAevIfvIRxfXC+zRvcGYhLq/f7lIKdXsPqK16LZY3hSSPdMH9gh w==;
X-CSE-ConnectionGUID: lI3QVvstQICgI0D9F4fCDg==
X-CSE-MsgGUID: DQ5IYYnaR++nc9eZzD4ffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73466811"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="73466811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 08:25:52 -0800
X-CSE-ConnectionGUID: JREjKox+QpelhrLSUj4RWQ==
X-CSE-MsgGUID: aEc8iUK/Q3uUZLUVi+8DOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="204314291"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 08:25:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 08:25:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 08:25:51 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 08:25:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfHl6KGcBG8NgkgHPKSeaeWLg7qdtCmYfUgWG46XrAGfGKfZ9AIJMMcCdtGyOAi/5EYL0GimuRA6K54zywVX0vOIsgZm5jDy4veV5gxAkBxI7W39hHTWKCNxRmxjtut7NYhymWuWHdjKllBxMvHe+1GDImRUQ5jXUOcOK7IrpcipOFFR+v44Mk2x+Vqiw0KoPgekkTY1bLz372io4ofvQ4RwzIf7jYRlG7rlLu4Um9VSGe/V3nVo6AKbmzvAR/HdwQ2NaChubNLyWhkRQat8qO2y85v1uIMRNKe3ZMkYOrwRzbdZlvClwdent/SUgIVPXXGgIsp5nNwZ4asCRr/lpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zajPoRH94nWcGaBDcgEywlkFl3dJS5Z5Feozg8NYEOk=;
 b=IqXf7VMwSY5yDKe03P84MU793Zanw/zVNkE4jm89hgTtBzadxh/j6DSmhvc4PtpJMvYlV74DBU0yB8x1XyOP3m1tcUUZJkqTIjsSQCp10paAXauJlSl9txj1BP0ZlwilD9wD9x5MEji9l079mgNbyX7FwpZOx20FVkzrRMoFcdy0boF4ASX/5ZlifDikEa7zx2FxVuJgeBmFq8ChyacP7EjVrfEjy+O+IcxiPPIEST9ZO+xBkFphPsX+L9lLs2ojm5UJfhru1QAbpboSCBPsIEQ1So/KOuZDrjJAAzAxH3QjVDC+rqA+Xp0fyCafp32eF4nmShrfOeI606IJkI4hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8704.namprd11.prod.outlook.com (2603:10b6:610:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:25:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 16:25:46 +0000
Date: Tue, 13 Jan 2026 16:25:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix QinQ stripping
Message-ID: <aWZyBbDkoXzeKI9O@bricha3-mobl1.ger.corp.intel.com>
References: <20251206184312.69020-1-anurag.mandal@intel.com>
 <aTrYFe7rmsCyUfFp@bricha3-mobl1.ger.corp.intel.com>
 <CY5PR11MB6116996E086E2822124322AEE4A1A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <aWU3DhthaqHOuIHZ@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aWU3DhthaqHOuIHZ@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: ce070b10-97d2-4ab1-764b-08de52c067e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qDR+920ah953LZPWk37midBwc0lKCKzlet1pmg0zD1Jt4qKQwLkUZV04IiPW?=
 =?us-ascii?Q?rQ3jr3U1A81Yza9QE4wcVRWnpsj+mfYD6+CMwSO7VJSGxd6AyKC4hh6S8efn?=
 =?us-ascii?Q?m3kZG8DjSWOeW4tL9oFoMgCiMhP1qi1dKqdF3Fb07j77r778kr2RgrTjcacD?=
 =?us-ascii?Q?s5JLL4FM4M63iAefifZcwY/4SyDKBQxqLNE2nnNSMWPEK2S+lRdujcPNMIAP?=
 =?us-ascii?Q?k2GfnpQH94hKsjGvMF4c0O60jtwneaM0xrc0NR2804r7vGsL7ao6BDM9OtKN?=
 =?us-ascii?Q?Sky7aQb6MdGfvZQ3oCS6F46FIqqkAUca44RCx1mRDyBiugXMeCDjc5miKooU?=
 =?us-ascii?Q?rvWqiyXivLg96T/fDRgKg+Fw+rD7UVr1eIOztjFfOHKlcg7Dpuu9tkVNPIk/?=
 =?us-ascii?Q?P3ylVpd9JK8gJVe4kJvwrZ39GQSDB2edrRK2Ukou4YhOWIFiSx05vryxPEak?=
 =?us-ascii?Q?KLWKWzO5km6gtzO6ZuW+HwSn+Q249s3TD2xouk9fexQ6gWFgqZFjpVVK+v3Y?=
 =?us-ascii?Q?mTmthvM5hOBLCepzapkxhTi8odalEckIVR5jveIYUDSP7KLGw+MwBJawNLCu?=
 =?us-ascii?Q?DpuMGlqQb9wym4Appr9aOw879wxk1/z9gfszfspJ+vyY77q3Gew8/FDM7E5n?=
 =?us-ascii?Q?+cy4LUDhwNtXtTw6QNcojzuT/9p5DvSX5E9wplAUkRNMWs0itxsjGNRDnoWq?=
 =?us-ascii?Q?Kv3sywu15wlHCRrK6Snkm08d1RFVLWFivQREgusqh9GWikiqm5VjCcH/Uqog?=
 =?us-ascii?Q?L6H9ZrEBTRsYuR4kWKc/2avFvH0eF0a8z9oI39KamJKzV0KcyASe42DHtJSQ?=
 =?us-ascii?Q?ocej3TPIfPLpcQ2S445m45yRHzlT0BM5rD7E1O5Y+0dFnntYkI3TllGTEG4s?=
 =?us-ascii?Q?NK1/J2L0LAzZP3B9k9QvrrQ3sGf2ISPDuXFxf+9b/CGF4ECWJsJkh1mCV8fo?=
 =?us-ascii?Q?0OV2z3EH5Rc4ZIdoraGI6Cwass3iASFDllZu+aA5hA+Eb0/Ef2npDW1zoZqv?=
 =?us-ascii?Q?wdSvtX1y2vWsEEjHwl0QNvvUroVe3+NZ3FrF0eH8kLG+SQvNdZnQWxMOa6gS?=
 =?us-ascii?Q?sFSN+yMgXDcO8foHUu19Tg4gETcqQ1ZvzUnr/zP62W5Oqboy2lv8ezbB2yxS?=
 =?us-ascii?Q?y6C8cSMNzddFF6mUHAXUPgRrPIH0MtPwdCrijr04yC1ZvMUYTeVZrJqaEoza?=
 =?us-ascii?Q?BaYuJRFnqRjhRBovE05eNVP9ukQCjfZJTd8hmwBp3O7k+bNl4TkiCr7lj5fa?=
 =?us-ascii?Q?3mv5BybGqg7OXAC8UdFloX6yWaV0LXBNkpakQ0kLu+8TOXyDE54QW55yBtxu?=
 =?us-ascii?Q?LtPTBo34ed4TTQ2hAnChOTlA0AEC+N4DqjO4EbLzUc/gKogKNeja7OIkP+UX?=
 =?us-ascii?Q?6AIlYqXtd492Zq1vjq3NrakrU7dl1oHvGsEZ3nrJ6w/2mm6rS+aDWdbO5q+d?=
 =?us-ascii?Q?9qQuJh8YzN1sBqNVc/i/j70T4MX+Fhkx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7eaKRq8qEcva9RwtJ3hh5+nQ7aLc/RKxKiYmL+P6toBUGkpWgPnpZveYW+B?=
 =?us-ascii?Q?dHIFX1bcB2u88zUeuhY+KNgdXGu13JVdrLO5cV2QN6ocGU3mPlTeP24Y6vKz?=
 =?us-ascii?Q?TS4ocf4b+77Jpt59wiGh4+jSVfcVQJ5d4gk2xKGxEsHmavGTQBQ8FFDujGEn?=
 =?us-ascii?Q?OYkNglNqD0yGOLUI7xIjKQs8Va3aHEDV6DsIdcxifZkKB5Jnk5A+8mAUlhXi?=
 =?us-ascii?Q?+KylXmXYovqmMDqs99uW7aw+FJ2y/bSFI6sV9HGDpg+2/PG6BPSTXJV7GzW1?=
 =?us-ascii?Q?CRDUAv+hskTtGJ39zXOOQoY79sKSe2cEJZLG19eI0szw1Qq1jCEza/bEQKsR?=
 =?us-ascii?Q?wN92sXm5iyitpT1Srbpu+p0bbd48xFn7Kp4HZwDAbYFn1s7xUb5kJ9EmhnUx?=
 =?us-ascii?Q?Uykhv1dMKicmlwFq5evVhlfD2AkestnJaP7pmUwTlTWGf7ATl2OR76eoxHaU?=
 =?us-ascii?Q?Uj9133epdCSrfpj6B7HcZjhTNhJgjsNwcRtjUOd2YVoDglGteRWe5+R79Kuy?=
 =?us-ascii?Q?+fl78L6pTFQd2lphLIShhOZK14us50DD+Sw0x9oSgIYQjacOhD/6ePD24nv4?=
 =?us-ascii?Q?vDem4j1laSqJilboCzIhHPku6TV2IDvAPC81VMQcOltjSexqX8MWwkdAGmsO?=
 =?us-ascii?Q?4kX2TOtEg5nmMe43OGfs/dIU1F1UAd5gWcmohSVBKrC8/rWSoZWTeqsluUg/?=
 =?us-ascii?Q?m3X7gK/Lk0Iq+mYERS8hH2TGrGlxTjNnxtM5/lpF/Zg0Cq11UpeGa+GRrwn2?=
 =?us-ascii?Q?9UuD/GTjRZ1VKYkaPwmjPIa+uLASLELLf6qmHeOCu2OxPufYA6edW/X6Kkqc?=
 =?us-ascii?Q?omZc18GwlKPziSA3Jw+N3vAjYgHNoQJAHGZKhgnKu2Cb2rl7LFzeT+8Z0gIK?=
 =?us-ascii?Q?y5xIiBjZ1vPyiz2dlxpSw6k/NrZTuRHqWebiEqCwHErJNu8WG0bRcm1BAOmL?=
 =?us-ascii?Q?C9Jtq594vQDEfxde1J7CvkpBoPkQ0jm1d9voJluBvhINB9l+Kux7WaGgEPdx?=
 =?us-ascii?Q?pMBo1s2mYnKJAZkYorC8x5qDc1ip5pDiecpYvv+K3xV2A+/ZTggCRvVdep1q?=
 =?us-ascii?Q?nW+EdFxqvhRAH3nrv5VWd/D1ufb6CBKIPNe9gq1lKij+VFuOR/1c1xsRxfUo?=
 =?us-ascii?Q?wH7ClAuF4lTtXk68p1qMv5wG8ishfrn1B2TxMRPNHbzFSvQ2YjYIzVWBeBGJ?=
 =?us-ascii?Q?+/Iwxg4Vi4OX3oNBdfwbNdwJu7rptzkJd9m9oOYzmT08l7mL7KG1uTjA/kfv?=
 =?us-ascii?Q?UZ5mKxBrGDH+aylTnuTRMOBW4BBK299WwV6nUxWuAY8rAsNW+ZnIcFs2xFbE?=
 =?us-ascii?Q?GBl/tEDXwxZKJEnYesVPTAbgaR0seAEj2w9qkXdX4Egw6wnV7ZYQgu+1nxp6?=
 =?us-ascii?Q?4vxuMc8lfQgHpyC2/sSgeLbIyJrgKxD6fNV3jxMlwgFrMZK1wVrFgZ1rDQMT?=
 =?us-ascii?Q?ZfH902ojFl/aSOVug8x+JY7Ut0mwLDNxoRsLNx9ddz0g9KAMpyhgATF2p5TF?=
 =?us-ascii?Q?KCeIwmpApKJPa1Dwi/wCRrfyDiYwywsmp0bt1wTfNbpY1vXaAhZLc7pR4H+W?=
 =?us-ascii?Q?OZW4FmsZqFOBeUzWMqTdP24ZoDH9V6vQI22gVbOhk9cNls6pt2ErJ0ni3eTu?=
 =?us-ascii?Q?aAgvK0vm+0uPbcDJsDqsZtmqkrXKGDMpKKpiopjgypqqduX2m1XOSre8rgkF?=
 =?us-ascii?Q?qVmU5hp1vfqlfgW0RGRe3H4EP/03soYz6/GcbVsRTcQSPASKQ6bsdOLPWXQp?=
 =?us-ascii?Q?IyZEwP4dGcc+6kwqLRTrnYwhENiC9bs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce070b10-97d2-4ab1-764b-08de52c067e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:25:46.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POEvB0lzvOu3VuLteSHyj3paqrIIPMy4QKUR8akwYqT305Kw4a1PmwrRquZXhocjxj3msMRyooyssHmbIzHlsUQpp0E0tajMeoiVequFVbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
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

On Mon, Jan 12, 2026 at 06:01:50PM +0000, Bruce Richardson wrote:
> On Thu, Dec 11, 2025 at 03:58:15PM +0000, Mandal, Anurag wrote:
> >    -----Original Message-----
> > 
> >    From: Richardson, Bruce <[1]bruce.richardson@intel.com>
> > 
> >    Sent: 11 December 2025 20:11
> > 
> >    To: Mandal, Anurag <[2]anurag.mandal@intel.com>
> > 
> >    Cc: [3]dev@dpdk.org; [4]stable@dpdk.org
> > 
> >    Subject: Re: [PATCH] net/i40e: fix QinQ stripping
> > 
> > 
> >    On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag Mandal wrote:
> > 
> >    > Outer VLAN strip gets disabled when inner VLAN stripping is
> > 
> >    > enabled/disabled after enabling outer VLAN stripping.
> > 
> >    > This happens because the respective register is overridden by the vsi
> > 
> >    > params update of inner VLAN stripping.
> > 
> >    >
> > 
> >    > This patch fixes the issue by re-enabling outer VLAN stripping after
> > 
> >    > modification of inner VLAN stripping.
> > 
> >    >
> > 
> >    > Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")
> > 
> >    > Cc: [5]stable@dpdk.org
> > 
> >    >
> > 
> >    > Signed-off-by: Anurag Mandal <[6]anurag.mandal@intel.com>
> > 
> >    > ---
> > 
> >    >  drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++
> > 
> >    >  1 file changed, 10 insertions(+)
> > 
> >    >
> > 
> >    > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
> > 
> >    > b/drivers/net/intel/i40e/i40e_ethdev.c
> > 
> >    > index b8ce79061b..c8153f3351 100644
> > 
> >    > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > 
> >    > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > 
> >    > @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev,
> >    int mask)
> > 
> >    >
> >    i40e_vsi_config_vlan_stripping(vsi, TRUE);
> > 
> >    >                           else
> > 
> >    >
> >    i40e_vsi_config_vlan_stripping(vsi, FALSE);
> > 
> >    > +
> > 
> >    > +                       /* When VLAN strip is enabled/disabled
> > 
> >    > +                       * after enabling outer VLAN stripping,
> > 
> >    > +                       * outer VLAN stripping gets disabled
> > 
> >    > +                       * as the register gets overridden by
> > 
> >    > +                       * VLAN's strip vsi param update.
> > 
> >    > +                       * Hence, re-enable outer VLAN stripping.
> > 
> >    > +                       */
> > 
> >    > +                       if (rxmode->offloads &
> >    RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> > 
> >    > +
> >    i40e_vsi_config_outer_vlan_stripping(vsi, TRUE);
> > 
> >    >            }
> > 
> >    >
> > 
> >    >Hi,
> > 
> > 
> >    >to help me test this patch, can you provide a set of instructions as
> >    to how to demonstrate the issue with
> > 
> >    >i40e and how to verify the fix?
> > 
> >    Hi Bruce,
> > 
> > 
> >    Thank you for your queries. PFB my response.
> >    Traffic: To observe the issue, one needs QinQ traffic with outer VLAN
> >    802.1ad (0x88A8)/802.1Q(0x8100) and inner VLAN 802.1Q(0x8100).
> > 
> > 
> >    Instructions :Assuming outer VLAN id as 201, inner vlan can be any
> >    other.
> >    a. set promisc 0 off
> > 
> >    b. vlan set extend on 0
> > 
> >    c. vlan set filter on 0
> > 
> >    d. vlan set outer tpid 0x88a8 0
> > 
> >    e. vlan set inner tpid 0x8100 0
> > 
> >    f.  vlan set qinq_strip on 0
> >    g. vlan set strip on 0
> > 
> >    h.rx_vlan add 201 0
> > 
> >    i. set fwd macswap
> > 
> >    j. set verbose 8
> > 
> >    k. start
> > 
> > 
> >    Objective: To get both outer and inner VLANs stripped from the incoming
> >    double tagged traffic.
> > 
> >    Issue:
> > 
> >    When outer VLAN strip (qinq_strip) is enabled first[point f) and
> >    afterwards, inner vlan strip is enabled[point g], QinQ stripping fails.
> >    In verbose o/p we can see incoming packets will still have either
> >    type=0x88a8 or 0x8100 VLAN tag present which is the outer VLAN tag.
> > 
> > 
> >    Verifying Fix:
> >    No change in instruction order. Verbose o/p will show type=0x0800 in
> >    incoming order indicating both VLAN tags are removed.
> >    P.S: If traffic type is 0x8100+0x8100, then points d and e are Not
> >    needed as when we set VLAN extend, both outer & inner VLAN TPIDs are
> >    set to 802.1Q(0x8100) by default.
> > 
> >    Also, if inner VLAN strip is enabled first and then outer VLAN strip is
> >    set, QinQ stripping happens smoothly and incoming traffic shows
> >    type=0x0800.
> > 
> > 
> >    Thank you.
> > 
> > 
> >    Regards,
> > 
> >    Anurag M
> > 
> > 
> Thanks for the instructions. I've finally got around to testing things and
> indeed I see the behaviour you described - sending packet with two 0x8100
> tags I don't see them stripped unless I reverse the qinq_strip and vlan
> strip commands. This patch makes it work with both orderings.
> 
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel
