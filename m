Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D78FC3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D51C940652;
	Mon, 31 Mar 2025 11:10:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E1E2840150;
 Mon, 31 Mar 2025 11:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743412234; x=1774948234;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iKrGVeRqJm6xjMmn1HpQzV8zlZcvKQchih8+47Kr+UI=;
 b=TBbUgOrInououBLQAjPOz+Txq3WtYX4WCWPdLSF+StWKvhFifJ28+N0g
 UcDMCa5G8ld6iuqmtN6YQC00weqIz80TopaGzkmvfOeEWrw+Hc5WH4dIS
 +nCDN1RUjz38RHFDRz140CUzjba/uTji+HFgIVRh0RhoEwSHlmVCxbOKW
 5hJltkbWticTPhgDrehNlwB0QosSopNA8bl55fVl+GrlKglzmaJm7UkwV
 uWP7OSpQscfhac2bKoMrVsKr0ebeeqnPeVubLBBmg/A/utspU12bSWsUY
 DeiZRMgZjTwvxxRLImb78p6Zox1ZQKoJuS7cnCRd5w32L4/7WjEXuJJLD w==;
X-CSE-ConnectionGUID: 7itLui4sTR2BTzzdsHQy+A==
X-CSE-MsgGUID: cfYcxpynR4+7Ih3PBDqsJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="56070723"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="56070723"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 02:10:33 -0700
X-CSE-ConnectionGUID: UzNOxsPYR+iryv2GdLR7Yg==
X-CSE-MsgGUID: +vXT50MvSjuecV0E3oidiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="131256061"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Mar 2025 02:10:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 31 Mar 2025 02:10:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 02:10:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 02:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVY7tAu0yRvyU1P0T+/yk6eV3FV0zSqvC+adnfjo7x3A5w2jUUWcXyur50CFDhZvljrDo+18AohmgzE2wlGXlWvcNWutnFR1ai4k19wo5VhCcP38tZi0pNcD1HAcJDBrMZChJQ48Vqjk/KhYaQx7yj64D2OIJq4O2OiNC6uTitKVHbo2xVdPSKfJa6PqYuNCjUPZYpmkZHnEFWGBtmYVxZ0Yf/s044CZtZQlKPoOoHga8LrBFhQG7MFORk+C6i3WDUT28a4whhoBU4sETrx4o94cCfRMVXt3zrBRsmxn6MTyZosTxhPe8QwjcT9Deua/miNPB9pwfnNhkTW+FF3Law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDpQoR6rYdelIDJODecwFsw7UVscaXyZ8N0lPqqVwUA=;
 b=YhS0ZAd7M6XnCzPfKvn7NrvQphHYfLf6C337WBzoBbH4dg7wKGYJPWhe1R795sfmUJrSC/Cvb7/VOFLuq7lGTqtLcFxzHPrjYE9SwJ2faqRqCYaGhcq+nJ+eZ4DQ1yTabfwmDZG8pSjSLbwm4SJx9tIN3qn9lx1EHP6kGqXaw6xtHkN99/BwnA6qz8IFqInnlSoz24nPbsBHWGf9Zk6ofOK+8mOZ1gVqxGbY4ZmQ3wBRVgV2HsNB4vMn6t+2LL3tUgMFWwhe0YDyGoTKj6KjnyktEAPpG5rVnWENV2UENnrMVuOzpjpT6DI85GcthWBF2ZrXwfn44u+DhPeU1JD23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 09:10:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 09:10:28 +0000
Date: Mon, 31 Mar 2025 10:10:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "Etelson, Gregory" <getelson@nvidia.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, <dev@dpdk.org>, <techboard@dpdk.org>,
 <mkashani@nvidia.com>
Subject: Re: DPDK for rust
Message-ID: <Z-pcACFS3t7xkQHl@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
 <9241799.4vTCxPXJkl@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9241799.4vTCxPXJkl@thomas>
X-ClientProxiedBy: DB8PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:10:100::48) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e46f0b-b6f3-4413-e0ef-08dd7033e1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9llEH+MCLyGH5hF2a0AAE8SyQ/GygY8LPQWAOrKxcT9wC1JaZ9OR3uLGtrFj?=
 =?us-ascii?Q?cJrBU2UPm04mI9tSIISn7YJQ/OCzu3cESaWrHuhA0fN9xSiu+aKfHxIKTYtZ?=
 =?us-ascii?Q?SOzEHd8aBCeA8vi7RRvyhRVgG9QXc7cXmzPT5w9riZ++V1AAy7mKwcrc8ogO?=
 =?us-ascii?Q?KFL38zELIhpeRlseiJ0zTh89s0KGESxpYs1jpcsYfxrs967V4zHFRLMLYFki?=
 =?us-ascii?Q?37boYdAtV8bS2mTwIMfCh1KKZKDrb9eT01RKcsqcQ0zKHnkNAFPUgrEiuvO9?=
 =?us-ascii?Q?Pz3vO4UBofzX042GhZHTHYOG+36oSD3+Z4WK9HzZ0MXVt9VG9SgrSnaZaW+s?=
 =?us-ascii?Q?gU3y53ZhwgBLF3jbFQBUZz6KnNJnNZNWiZjU7g5PKyLrNjgFp5ToqdLYzsDE?=
 =?us-ascii?Q?DdAORrVZatgDlwzlwUe6a0vJasWJoOmpX8swk9KoZ2DvCPLH5SZ5uc8uiroA?=
 =?us-ascii?Q?mCTkbMGEMG63RFqhJuIa5Cqv1pqRvWj+eJHeYBnNsY0vIcIAuEKusunB9iLW?=
 =?us-ascii?Q?GsqgRkxTtg8K5pv5lqg0aH444ljkJxWH1ZCgRaxBBm0pvB0qgcHRHb7Sk3A+?=
 =?us-ascii?Q?YJsKobFtuksiNBtlNH+YJaIq1wNBam172VJ+4IMN+PXaDyaLCSjcwyJtcI/i?=
 =?us-ascii?Q?ZMN6f8+IINZE1+sZZhd+czKpRkovOCQ7nWlnfT1vMNQDBeyG+gqJT6iYv5NN?=
 =?us-ascii?Q?R3zhz1jtT7qP+m8MiabfwuiiP/a1es0HB52Lm/zPHGasws73O0agr03/B1Qz?=
 =?us-ascii?Q?AdWfvb0XRp2re3d1jXxaBr2oeWR4bkYqD06i9iTX+YnB8ucP+oUQL/0iJIMt?=
 =?us-ascii?Q?IRvG4WMPwGwDK8oio4VZnjQI2cVnZT0+TuPKbrqK+0dGuyKsvOnRw5ESfDff?=
 =?us-ascii?Q?PlZ1PxOnVJuv7YcFbuCgRsa4OxsDBlKuiUdC48Mm7N6M4uKtRJCX947wiJYW?=
 =?us-ascii?Q?oXErUfs5a11lZkIkWRuDRWjnM27fYJfpErIN4/ESZkyj7HWqWMXhgRxAtpXm?=
 =?us-ascii?Q?Z0b9wvQGhtaAG9eWawO6CGx4MaULyk7m4jt63VLGxlBXxY2GkiLMy59YujyF?=
 =?us-ascii?Q?VRA7ms3qz4jeRgUnL6zcOcBewk04HoRUTDU6NajP4gVYm+sxsdTN5avoGvPa?=
 =?us-ascii?Q?ZHmw8cqji+UNpC2yt3x2JJPHJYr4EJXTTxj4BWzYQh1F9H+v4RvfGtbCo87T?=
 =?us-ascii?Q?dysd7DbFo5XXxEtDtBuqYynufhMt9H5eGmqjVnbWetXxz2hIa6PwHvV7sBRP?=
 =?us-ascii?Q?v3AudZSqoItP6pIGxRAABfSkBxtbvFyX4W1xgqnYN4bjZ1hOC3oCldJI8uSY?=
 =?us-ascii?Q?bpT4qT2H+TS6hjnj6Kxt+mWwUV6vtQ9aX7BmoNIRx4oVioZPBL54qKk/QafZ?=
 =?us-ascii?Q?aGxlBWHLGl70+6b/AqA2UaR5m0jI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0/DUkc5Fl3MUlj9ss6s/d5Cxldqtchc91N5J8GRKzSGQB54rtN3qRsNAlsn?=
 =?us-ascii?Q?NuMCSgOd7y93k6lxBhrnNnrYQKraCPfZl5un2Ik0vrQTnVVpoquK34EHlfgs?=
 =?us-ascii?Q?/WmI1yjviX9osUVoNiGuE9YDsKLyrjOe8vZ4PrzSvaBxI3svRE0lWu03Qodr?=
 =?us-ascii?Q?iIwFrwbzxz/WuAlGkoIFLscEicqD4QA2V39l51UKhWeKnrB98tEomWrPUn2h?=
 =?us-ascii?Q?xRG8A0OFqWyFejrFqcJFnAk6RIk2GpZnN9waSnCHPDMkXSu9pwe4eJ03FFkc?=
 =?us-ascii?Q?nfB4NPrYfmbAPu/cCkjargR4fE3Byg2NPWpkO8LM9k/ezaYcjez0jEMmPuSF?=
 =?us-ascii?Q?zn1bbfiIuGOyLGh6xBb+3unEF2RElHaCGHDsvcPGza9VTjmPKIOGTD7tSLap?=
 =?us-ascii?Q?A3uHGBTMG1rzKChkGh69VJIn/55kirSjjN6BTK4AVKMRtucjQkWiOgoDM9PC?=
 =?us-ascii?Q?NaA87aSLIFEYlIfxBRc8yyu6OtxrtV81C3mmV1DzZEKtHCO6xsim3ZSLpIL0?=
 =?us-ascii?Q?quj+b1u0ezuRWZUzRfrBs3DMYJ1DYe49GXbXjJKNBTMCD3xoUm3uBzE4wT18?=
 =?us-ascii?Q?2aD5jbPID5or3hKZAUR3e6CVkHT3cfXiNsSHO7j5bZO1gZ40dVK8UE+mH27l?=
 =?us-ascii?Q?Ehr4DWQVCeMZTVNq8LY73+OEC4wPvdaJbU1/gou+ZF+6spWSVgVs52Xec9LY?=
 =?us-ascii?Q?+sPE0sH7yY0t6gOucuyNzg04gsGyy7lncl80jrSPhYwLi6MSjey23e08+lp0?=
 =?us-ascii?Q?q6xyaQOujG6ooFeJLSxXuzhhzUCcGCItUY6yaY5pxOXQ1TjyNFh8VsY/eRsH?=
 =?us-ascii?Q?1VpKMWCycFcY7JpTduolHFGHaieIZDvRnTxrlFmFE1yex4wtSrdZXJSvqtnf?=
 =?us-ascii?Q?KU/gE9HVX7X2fx3zX2Ub62+NLejn6PZ7LE1JTUA9HmiLM3bId3dB8Ykv63XD?=
 =?us-ascii?Q?loKp/DdmJrCJ7CIQ+40DrCAYaT5dX3EntXaK2t8H5JArPXoeGYXBZ19fofjM?=
 =?us-ascii?Q?omcpZbFNap6z/7xv5gXxOn5Q6xWYJN6ZDQ2P2vXfqLpZhwZqwayUbxtlIxJW?=
 =?us-ascii?Q?lcBC91SHET8uv+HIcryaxdQzFzJupdIAZ+E/X78JqrwAaiSRC1h9Twyx6MOe?=
 =?us-ascii?Q?PTc+M/J+tAQsP1SBjC6QEDFLCB2ywvGnWwAJuNEDG3aN5gX8Ni2v9aC/XED8?=
 =?us-ascii?Q?tPkVhnYbkYwvor9BNj7KkPF4FeqBHElkxmlXLn/l2v+fFYhCyl3ae2ZIghab?=
 =?us-ascii?Q?Ot4FVrcbJRe2G5VJjTCz8+RGPZAZicuRTPeqCRgOLnEYNSJpB/Io5TMnvO4W?=
 =?us-ascii?Q?H3Yn1asn4yRFTN4ltPxJwfmIp6pkUSYkx6aIwLE7wb02NzTpX1KpIzyg6aO+?=
 =?us-ascii?Q?TUKYcQKt7RwK7Yi2A7f0JQwc3ecJBH84D9pONIz4AORdOZnMzsmKw/fgEPGQ?=
 =?us-ascii?Q?T6XmQ0P95filhjWVqJybQhyLKFeuxYa8MJ0bhKgMTrBodr8wJloROhwNenbV?=
 =?us-ascii?Q?MySQcakLJ49c7RUlSBId4yzGeqYXh/lkLoCYAtu1dt4KN26MhRk3B3phTMmy?=
 =?us-ascii?Q?4k4fbrWn9DF67pfq3rkBtIVKUg3ytDwdpOuitw1Rla9y9zZOnB/+7z6y75+X?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e46f0b-b6f3-4413-e0ef-08dd7033e1ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:10:28.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeYNvrnkp3sn8QTr0ouj7jjtm5Atuxi698ES8PoCJIBBloa+wjtCnBVzCT5JlcdTkcx1yhNwdypx12iaYWgO9YcaOAmPinnem45Pi6aKqcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
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

On Mon, Mar 31, 2025 at 11:03:11AM +0200, Thomas Monjalon wrote:
> 27/03/2025 17:17, Bruce Richardson:
> > On Thu, Mar 27, 2025 at 11:00:40AM +0200, Etelson, Gregory wrote:
> > > Hello Morten,
> > > 
> > > Thank you for raising these questions !
> > > 
> > > > 
> > > > Do we want the DPDK project itself to support rust?
> > > > Or should parts of this be a DPDK hosted project, like grout?
> > > 
> > > Rust packages management is different.
> > > Also DPDK Rust code will eventually provide a different API.
> > > At this stage, DPDK hosted project looks like a good idea.
> > > 
> > 
> > For ease of use, that would mean hosting a cargo registry, no?
> 
> Please could you explain why it is easier to have a cargo registry?
> 

Because cargo is the tool used by all rust developers to pull down and use
their dependent libraries. I don't think any work we do will have much
traction unless it's available via cargo.

/Bruce
