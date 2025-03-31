Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5935C36014
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2024A40650;
	Mon, 31 Mar 2025 11:12:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 99F4A40156;
 Mon, 31 Mar 2025 11:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743412331; x=1774948331;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O3FE1qqdLkDFPE6+K31pi+3312BpRR1yzbF5e6Bm/BE=;
 b=jL8bhzqq9LEM1/P8+5BApZ9yOk4TAvc0rY7B4EeWgfkebC1c6BBWTeNw
 SgwbiIC8B8pCwlljjSQILjRnsV9/Edn2XDCOL8aR4RCq0pTSaP62imYlm
 VEB4EyUp4+Ko9LaFfDbolQalN3j6XECwxFy37aSisZpiOL24KRzr1TLIF
 ZKMy7vPXDDV0sU0tIU1VrmgWW5Xu0v5EmDFh++mnls1d/YanvSPly3B4w
 6ZZiurHnQ79xpXLyzFOY28z9GqaU6KubOz8LcaC2Kd2j8aQOiVYTV8wK4
 23K5Y0WiISNrVmxtAeeSETqdfwpfNMowTiPnYLcjNeckRML4yNDaJo1lc w==;
X-CSE-ConnectionGUID: MV+Ysv1ETq6taHSDhGdyhA==
X-CSE-MsgGUID: Mb0xqv9ESeS1A/6Vj1YCCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44580156"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="44580156"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 02:12:09 -0700
X-CSE-ConnectionGUID: E1Avne1XSr60K2smf3e09g==
X-CSE-MsgGUID: pab8erWQROiwfzirGF8z5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="125796115"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Mar 2025 02:12:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 31 Mar 2025 02:12:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 02:12:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 02:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvN9AX7nhjD5V0Udd5C0LZOnNl5yznEFv2CNPPUAqovJTmpCDBC+DEoda7EWPIcAaHUc8Y2PLuZRyNi8l0sQOTNi8Fihj29BHMYCiLFTQX/XSJUcL97ifZLABXqoRjFWEpva4jRC9isodocVLyS8Qh/jyPBCBnOH+ZX8SIfpUiJLNTfRNAK3HI+37DT/TLA1KTcWzAGo4F6VR5YMIuHJknEAeE530zEFMsSaHzMHNRBNglJHrRcluJI458msedMUkNzBElAWPKsJoRvyajp3IG0AL3JAuFIbLrV72v46uu5j+hSXYzJyvCuaHHQ2oGHzwnHTa81msUefJhwZwdU6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYupGLu8MxoTKI+oTr3o2IXLt1lHJnte0hq6MSAIqR0=;
 b=liE7ct2jQOcuuDt0QuhMDYyRvTT2m5rtL4XW01IrfSnU+23zz5ST7QpGIsDXShNCyQcJgzCoROQKurGIkpwNRfqllHHyMwDgrPSeEjs8QgtWvgLRaRfQUjtMGidLKJ6WiuSa5/Mc/jJvj+V8DA2grtV9Ael4ianIV7UjhPiFADDsuAiDBDCU0cLROR148HF0PS1GRPhjMk/ZJao/eHnBOoTbCqhNhcea1B4/puv3smNyM5GJQJns10spsRIxxUtdzvMm2iIpNbo7sLR5FsV40UTcZkNGsVVx/ffFhlMAPC+C5pF+y/pfIcN0/P4QgZLcKFdmgGgk1aQNrOa4Kz3ykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 09:11:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 09:11:33 +0000
Date: Mon, 31 Mar 2025 10:11:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "Etelson, Gregory" <getelson@nvidia.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, <dev@dpdk.org>, <techboard@dpdk.org>,
 <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: Re: DPDK for rust
Message-ID: <Z-pcP_sbk5T-e7EE@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
 <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
 <20250328122516.733217af@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328122516.733217af@hermes.local>
X-ClientProxiedBy: DU7P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e03658-8a0c-4bbc-7ae7-08dd703407d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLIuuTI7+6F1t14pGHF2tDMWKRL1z9qOJ3doLC6xTKYu8wSjABJXaxYWk39W?=
 =?us-ascii?Q?YBzrqEQbXbC2U7aFVmFUgAMo0Q9Ex7cQROmpKc0i2z2I+Z+cSNH5xiOigDCw?=
 =?us-ascii?Q?973gyOrlar9JABenFQdGH625iSlnBmWukmphCezjSj6cAI9199okIGD/HR/6?=
 =?us-ascii?Q?g9ZfCoeKtoZWo+VcNpBwf5k/XR6vPizTuV1bdyOybUiIp9FnrlUn8opJYxJ/?=
 =?us-ascii?Q?gUXL6vUqasX3gK4OG8Tz36z3102/UH0taKxVcEGel9aP1JGjnNamgP28CAAp?=
 =?us-ascii?Q?TCnJAi9Csow8u4uQdEo/UvVhUvPS9aGYocxFJGmJNBk0CZzUE86XZ8eQGJIV?=
 =?us-ascii?Q?e6KdCdxOLWYMLCUxmj8CkzpC0PHJbtNzvbSQPQ9i8Zn+WsCk8Wsrg9mkjW2E?=
 =?us-ascii?Q?nnRlF20eHk1It3p89+EQEG9A3urwhQy2gfpAcLMlLcJltMbjUZSfmz2H9Iqt?=
 =?us-ascii?Q?12M2E/3wQG0+EJuSxwdyiTJYmLgLvsvu6COJAeGbaBH1T0o4AyaGj64oLLUl?=
 =?us-ascii?Q?smQxZJhT0EGWyCozH5z33dHWAb7wuqJPzvSP8Nt4uPeM24iLHDJgDLDGnKux?=
 =?us-ascii?Q?eny52vWTC3Bujit90OJbqR7O9PuLsUnVn6WdN0/rtRl7UCF9QFpfH+CF5GBQ?=
 =?us-ascii?Q?3kPuz5UlUA4ysDGUMr/tXO/AIZSf0THy7NYT9X0e6C+Vpx2HCsM+MrWsXnD7?=
 =?us-ascii?Q?3TNPq11pTCjvLwGUbT4wNJxEO1PKHBHTbjOVpCaxGoZrKKwX8XMDUGqU2W30?=
 =?us-ascii?Q?Gp2iryi85TIzxavEHGHvx1pwBwIobYIm89gn6wYQPeZMIViGzYKBttMzrPUG?=
 =?us-ascii?Q?ZIBQc+NbCrUtJ9irM4zfBSa8QPw2CxqEnKSYPZcRs+qDa5M/lwMx6+WsdSGy?=
 =?us-ascii?Q?4pDFGDLt6Sc+giJQNzAN4cyI84CwPu/duDwvgD4uVqqIG9Sf3hjoC3PhD0Qr?=
 =?us-ascii?Q?srDYQ7rqltjU5VotpRLCM5iPwtX+GlCBgx8H02Z9cAuBDyf4FzpaQLQ5U9gh?=
 =?us-ascii?Q?Hk/aPriY38doxaFOH6UhffGJSZlI3/K48djdo1kWpxZwOclL4g6Q7xCwqSDp?=
 =?us-ascii?Q?mQf4WYekgyLIzCTtpcvDg3OHOBt8nFLb0pjgyLFgUDpclGote6ywUSkxNTES?=
 =?us-ascii?Q?mSWTgx9QgrqoA9WeliIErvKV87B6z+/EzmfSXGaG7TyTVnfYY2Th048JVj++?=
 =?us-ascii?Q?d+EjnKT8H5RqqSVEbIXaeU1IO9CxHmRAkaFt7hQII8ZwwfrthVkNpgwEIKZx?=
 =?us-ascii?Q?vco8FLrdBypspRJBZ9w4wfsWeTip8WTsQthaoLmqWZ0B/XGD5Ho3dCWX6CR8?=
 =?us-ascii?Q?Ed1Eo36Nu2ASF3IrERr3zJk93Ro4iIlPd63KGdNk8RLtGLb6IK92Oryg1klW?=
 =?us-ascii?Q?ajsl1Xz3BZxsiR5jQ9Zfd3XLknDV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59dQKeWtchDP/ieMe8D0egKDg1f8ZJn4lZh84BU8OZ35497IX1uOAIZ+x+D3?=
 =?us-ascii?Q?t/fIJA70yhBY+ZQgSspY+rZW74o3YNfSdPsFyZOqddVlD0mD+0DY5abXFaf5?=
 =?us-ascii?Q?JoLPiotdJ0b7le+trUURQDqPmeMtiDXURHlc1VUiCIIJUvCKRuHwq+lPigoD?=
 =?us-ascii?Q?6RHXvo4Z98jZktIWZ4J29NWDjLYMGVDwI1hGpT5yaNCr88QgLwMaa3CD4/Ml?=
 =?us-ascii?Q?a6wWy3FYkFdXZ08+g4nWu2NkndUiRpTuyhTcd7N7qlpSEOOY5DrzzfSnxTsy?=
 =?us-ascii?Q?J9D+E3aaxpmVqXafJrGBClOp3KlWr4gmcDgtE/35refbM4krLXAOOgqg4gXi?=
 =?us-ascii?Q?w+pMHQBfbC7Q+4istrPFowpllzw2YYPZQbJwqeD5KRuTx4dKNbtjoxsYTbgi?=
 =?us-ascii?Q?w1RyMZyr3k9nS9TfILNsE16rtmSeRR73aAeo+F/oq0j/dyUCLR7Y0b/rfRRN?=
 =?us-ascii?Q?4J805guaGw43xPZhVcPXWwvpNT8UkaEfIS8fCc/DPB0Udh3p0OR4y4mBG1MI?=
 =?us-ascii?Q?cqCCLhb+HbONKyB0W47YB3UFVXWNF/OETNOmKk7hiuYn7j/jeMpZYFnGVNTY?=
 =?us-ascii?Q?NmxfUYR0lpFzczPWe1eTVk74v62ho1iAP2Mh4uleJYvCFcGYCm7YPwMiXe/+?=
 =?us-ascii?Q?4i95pMRh/d+jgNZCFd1TBEOqEciOTMLn8gp5sNaHEHr+ButEKIp4AyJ3/mh3?=
 =?us-ascii?Q?nOlcIDtRfcobvKmBa5bG2i8G5IjDg0eeIWvHq4lBkwdIT/3vllipyIh3528X?=
 =?us-ascii?Q?jTQ8B7dK8PG1/rty7v4rVLeQTUQXoQT6wxRiJzKY+7C+6kYQdP4MNxilMbto?=
 =?us-ascii?Q?ySWdnz+nCkCqw75q2+XyQSlheuxMlejsWwx8irwDQY3qziaAS9SfmjA9b2Kz?=
 =?us-ascii?Q?qH+mQQ7p7GjB49AcQ5J1Z9tPVXe7tTiOFoo4uRg2xcNWNKXfV2lyIecG0BQz?=
 =?us-ascii?Q?aamkME7Y3q0jbjGENlpIxv1hmNdQoMCTWRh2UErfbZfGjqTkt9ZOyaEjJQez?=
 =?us-ascii?Q?GWHPzvUKupNcqfhlxWQEQVhpSqsPlQdQoT5ICykkCqqMW0eaJhGTHKq1UUBU?=
 =?us-ascii?Q?sbfOrtjhgZ6MTsNWPn7L2dGvDv4wJOFl6NyAd7OjweJ2PP6FGtqCbTuQtjKu?=
 =?us-ascii?Q?gFQyHwZEd/D7Hxqq1tcrQo0xWLIY3VcHqNNfCOPZxNXnpYA1GpZ5/NmVicG8?=
 =?us-ascii?Q?wr0v4AbzXeeB7So0A0bDuFfRz5bh4jO2l7FdovtKkYZw/MVpVnkFTPiDA8qn?=
 =?us-ascii?Q?dya+Hd4+46MpwjOGQ8LjAcWWtOpjwaLUBxVD3zXnsfTr833vOGH4ffmEuAcb?=
 =?us-ascii?Q?ZYCX3Ea4DjiyIUNZVnDM+3dj7kzWsvea2HZnHtdQmNuLmIE/XhOzyY518Qhv?=
 =?us-ascii?Q?Gu30NC+Uq+FMxQXJIZcorN7u/IrmAXmjG/ZEcEm2CnxJaDLS6FtePNvfCvOP?=
 =?us-ascii?Q?pv50MJBmbxhc41ndEcxW2hWrVz9UORlvXcfhueJdJ/cIS7Q+pQ6UCw8VopGr?=
 =?us-ascii?Q?FFzC6ZmzNmbhhktvfYAl/0bKyFgVY06UKLg1ofSZd0dW+TliFOjZ6/uhEIjR?=
 =?us-ascii?Q?tlEXpcyJtYSRYv4eLBFgBAIME5dqZ+rPXKefW3a9csn8wD6cthL69vI84ypT?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e03658-8a0c-4bbc-7ae7-08dd703407d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:11:33.0883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPxKyP1xAs/Qp6F59YPN0TmbtlnsRAD6P5UKc/Gze5IksuiSOwCiz4EngYMMx/GqB47t9WupinwoLKWC8c/Kyl3LSH2vQZE/JLTDg5za0Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
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

On Fri, Mar 28, 2025 at 12:25:16PM -0700, Stephen Hemminger wrote:
> On Fri, 28 Mar 2025 21:09:21 +0300 (IDT)
> "Etelson, Gregory" <getelson@nvidia.com> wrote:
> 
> > >> Hello Morten,
> > >>
> > >> Thank you for raising these questions !
> > >>  
> > >>>
> > >>> Do we want the DPDK project itself to support rust?
> > >>> Or should parts of this be a DPDK hosted project, like grout?  
> > >>
> > >> Rust packages management is different.
> > >> Also DPDK Rust code will eventually provide a different API.
> > >> At this stage, DPDK hosted project looks like a good idea.
> > >>  
> > >
> > > For ease of use, that would mean hosting a cargo registry, no?
> > >  
> > 
> > That's correct - cargo registry is the native way.
> > Also we may consider splitting the code between several crates.
> > That approach can provide more flexible way to arrange files.
> 
> Talk to Luca. The current rust cargo registry model is causing
> lots of grief for distro's such as Debian, Redhat, Ubuntu and SUSE.
> 
> Packaging is always a pain

Yes, but cargo is just the way the rust ecosystem works right now. If we
want to have DPDK available for rust developers it needs to be accessible
via cargo.

/Bruce
