Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CECA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A2A40E44;
	Tue,  6 Oct 2026 13:00:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E9865402A2;
 Tue,  6 Oct 2026 13:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791284448; x=1822820448;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uw08W1qXhWLpbqB+g2dXjWPSAjBb4G40Y+b7f7GXJf4=;
 b=fl466VutAn5OzvE1enylC5clCOl6Ss753yXxWpnfhNgFrfuwJRhCWarG
 YYROy6xhPu9SEbr4LygH2704ddx4To60tLKFuuZF5g0bLUjjhm4VzA7rI
 kBiXHb2ExXausqwonWUtlkUJXoBxCYfVMBTtilRRnstIK7hSk080Z2RtJ
 Nd3FJ2atzHJ0G4UsVj3f2X0GAOwXlzsK2a6pCsh9Qs2YlJz/g/J+mJIwU
 zXu3j6cqDPnDW+yNaMEuVQ8KBqDlCjWupucojTOpLjRGymgK0thgB0XDU
 kzhKfM5xTIqa1cIApfporfz/6fXi77sL4nzTwya1mP2N/HQhVfPJa40hq w==;
X-CSE-ConnectionGUID: m7hqPtOpRxCo3ToewO1A8g==
X-CSE-MsgGUID: NyUFp5JKRtGaKHUIWZcpCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102547067"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="102547067"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:00:47 -0700
X-CSE-ConnectionGUID: 0G7RU5jBT+6aKhUC7ty9QA==
X-CSE-MsgGUID: /bqOetN8RU2XT6C6NltatQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277232070"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 04:00:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:00:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 04:00:45 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 04:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZh471MAFE6PppfzA4uHO0gq5u5A9aZuegZF3kIxowkZdLeWSHtAgXDSbA+idmqC11ej/hYMtr/wJxFSjLpWCNpsWbAXRD4s7g2tlhd0Q+WedMVrrEImXvNPvXasNE0nKrDg9uga4MAiqcoOx8RffDWhRI0Psty6aUcXmCJ0d7eoRIm120UGsP75PsbE4BvXwRk3AJJfkC66UrpMLtDZ/W0tbP68palNX6NgY0cLc4q5Wdn0YExTgMpXbwb4ubB9Y3jRd9rshlG0nCdhfS1Wn+j1dP+5gwnNUP1ZdtKvn+/DzpfjlaTToETjvdtembmVEWwKkIILmbu/nShCmYyNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlDFDUkKAxPjOVfODuXks67G+by2taAX8oLvyUxAkSQ=;
 b=QHXwUiHtT6HwQnTR02ec9/L/mDW1SR2sdzU9C7HGXbt16fC+GRRZnJc+78ZjJdzUXoRwgx1lmeaEHZZ4hH3W54jrPe43h9BplDhWd9Hk3687Q47B7XXVa2KTI7I+CcnT5dHzCzPGFTfyQLFlcD6QAW5krij4avbYGLtK8MgGTYbcIn+D9QWP++zrweEfBZyCpC/oNgG5hjyiL5ZtIvwDe9SwRJqEO5rVn08mRGwEeWA+ItlijPoopd6quZluvVbVRFe1tKGOoWTA5C5gtymyFlMnYRN6hzeS1Q4/O5nC4Z/O4auNGretf5liQO5IxuAhRAgXhDAJKEDv4gww0rpReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 6 Oct
 2026 11:00:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 11:00:40 +0000
Date: Tue, 6 Oct 2026 12:00:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Sandeep Penigalapati <sandeep.penigalapati@intel.com>, <dev@dpdk.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Andrzej Wilczynski
 <andrzejx.wilczynski@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix VF link status for E610
Message-ID: <asTU0sq4pqKkUthg@bricha3-mobl1.ger.corp.intel.com>
References: <20260927175240.160260-1-sandeep.penigalapati@intel.com>
 <521f9c58-5da6-46c8-8064-2abf76585946@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <521f9c58-5da6-46c8-8064-2abf76585946@intel.com>
X-ClientProxiedBy: DU7P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fcb56d-870f-4add-bf21-08df23990f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: He5kyXM371C740AnAQPss3dK0nGC8EtW9IeDUG6DTrsYRIGymA2q6kO50aah6TnTLGcFjPPaYbJHiYUDhVC4Qd9iPufUb2EBAzCUue+R1OujSysQ+H0gwUK4x+FnaTP6A1+HPZCDzATIUaZkdG/Nnh36JjdUCq2xEAJUQ0ohdOXSP2p3hrpbJILlBgP2e70ZQFEvKP4V8csqkNDsrJ5f1mNxz5xbHLQnlRJZhgGbytf8DoKWuZWwbvam5jTTsHITbSynFbU4OeaA3uiZVLtr2GxIUToWeGZJol/KsRI4uEUPV6a8gSU7j8p5E6HwYgBMW3wG8E65Xg/uhUTPFQllAS29rX93ddbqHjQ1r5z11Div6imQgVIOOd3Rn8OB9cWwFTsi1FGbZvd6Gz00R0InmKexR/vStyje97xUxE+jqxzvmHjqUeGBpvJ/5hqDhhDgqy6kx3NVtPOfNncMHLCmlgzuWDUmuVZvMfsE7ioMOuq54/JWzrhBZfspL8pp1bzOnSJhvO4QSisV+Ive51EpM0AZTl6vQAaRXJeUmB0BbGYtQ1X3wXmfCZPy/nlCP2UKPRB7czRkGVjtrP/ZtA5iT49thkxRmlGndukKt/S0FiNrzIhZiHSq2+xSc3NeV1JsI8vlMlzvg7JUeaxBUNvys65BCsfjxpSxcdAT6K6I2Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F3aKnccXN/eIo5z/XwUXE9uR7ZwRk6rN/ZLSR37wEDJZSUqCVYq/RRtEHqw3?=
 =?us-ascii?Q?SWM/Ltiif6emCTMff7E+pzXLcQJf7+XrZHRlNgC1qX7RilGfgREtQF0iq5NS?=
 =?us-ascii?Q?XhgUYWVYU0VljiVbKe+yBppHAzXFwVT4VGbuNTKAfJrLdAyn8xm4Kspurnnx?=
 =?us-ascii?Q?8NGnW2D9XcXjKGb4ZyWGpZYVaQpqQ1He7uXlheTCzaimqB8KMdGNSb4zWCE1?=
 =?us-ascii?Q?vK5Oob563OmzsQtestbnbi1XnTC8W0t3l9T8BDJFKAdKT/faLdIAVwcKNu9a?=
 =?us-ascii?Q?moum/mL6l9yMIOghTQCwmnal2VOXNZnyNPkKM+QaW1QZ2+FqRWG4d6tOXb4A?=
 =?us-ascii?Q?xtVkaDRJjI98W9g0wHDMNcXCiw5JGq88L2I+OXmUzIpDRUhAofYd9i+sGvYt?=
 =?us-ascii?Q?mQqlVHrrodfETDG5mzmW2Aln6jjkMZujQHNC45oYPnqIzkQ5RqVeSLdkmuzP?=
 =?us-ascii?Q?639JORJgCL2GWMG7uFQbnBn+ppNaHinLWkRZvR4Negk6JkQqTIni/idGqsys?=
 =?us-ascii?Q?AxmW8HIF1Lozr4HuhYNNqRZpo8KT910rsQC/R8hTYJGaWcEMXg+1xRmZcp3b?=
 =?us-ascii?Q?tn6QhOeYMFNZQzcYtffXjPMOZalfoWh1wfMG3Xic/EPrmaSiJi62E0YMqtbL?=
 =?us-ascii?Q?B7s93WRqO06/DFMqNuttGAek4zf1lw37EDk322Qesz5OVNsZnY0hoLHqXqI2?=
 =?us-ascii?Q?o/Xkg1nw/bzHEOECdAupEos+kX4E10SQQNA9hIdd9ER42tKGb5dj5mWBwZEw?=
 =?us-ascii?Q?YpemK27zqa8cAC/jPG/C3u55G4q4pSP5ldVtpHWsTsw189mipmbpqiaDPQ03?=
 =?us-ascii?Q?rMj/nK0cOwmt8t70XfiuqfzSu50jSjG4TJfmbl8hOPImUhQOVevM/nDbH0vs?=
 =?us-ascii?Q?lMWgdm6nMJamesQo7jbNrCQxxW9+H2bIElFeZVVsfJl5N9G5Uj/OexlnmaJJ?=
 =?us-ascii?Q?0SNQM3MjS0C9+GQiieDLV4tnDgYmiatrVcREu6I7omLeNX1NXrnK7nbL8Z4I?=
 =?us-ascii?Q?IKvVYOIuOBCjZATWl27czXCAK3WZYAkabELyvQsQDHBJQumaGQl1o8ScR0dn?=
 =?us-ascii?Q?2ZpM63tXUFJbl6DXzMbfuXhphRr4xE97ClqK+Vsmpl1kdbB9DuDzdnXuh9mI?=
 =?us-ascii?Q?4IshHVluNR5v6ztRow0HnQcvbR7GXH2nNH2/zuxFu2Hmh7EkRywAPw5XLZRG?=
 =?us-ascii?Q?655gnpcT3uU5Bcb/8CC1Rv/ytGJvmMsjcETwBK1CbD5cp/7ArmHlNUn7ujQR?=
 =?us-ascii?Q?dKj3r4n9HS9cFsNiOj154PjFiIuovFLTJvOYJBzMJIBMWIqzz/wjAj50C5S6?=
 =?us-ascii?Q?9UZmWHkyoo+wMEUFU25SNKQtC/97h9zFo0KZRPzs5pg/JBnwJx2U+c+88h9o?=
 =?us-ascii?Q?1f8sBuCo5OHpI8E6HciJF6U5bXniKjB688u4VF1eGUby1DMn9j2BkWts5Zxd?=
 =?us-ascii?Q?gwlPA8LI+afv3MVWj+akaUGCf6aYOuesgniWpc+uc5iAh0V8CjPVbThFq4hk?=
 =?us-ascii?Q?9XsltUN2xKLWM4GDl+2imq5rWi05cc9lz4/1+VbqYvn8z3ykrb8wshKsDsSq?=
 =?us-ascii?Q?a3m1ifylcmqg6wmXnYf/g4yFwXF3jNqZPwQ9flFlIWpy5mEMJ/qy8ulgvX9X?=
 =?us-ascii?Q?WE1ab8WAxZnqWJuh1ICJthQPaJHLDWS7+nXbVrYFdraHPVCiuaAEDaNluEcy?=
 =?us-ascii?Q?4RrwEWRlv3JSSckHRY1gg/SaLIbF3o3PwqYcKl3qR70P3KEe8moSvYKxfRN+?=
 =?us-ascii?Q?Ik5PeYwnDPidPErT8BPn4CzNLJxM5kk=3D?=
X-Exchange-RoutingPolicyChecked: hAk/rTS9K5cxPVWqUTJACBOWcCARIwG6sf24ZYlJQwC2exrm7+tZg8BuuLiPbWKjf/nRzQ/LpCWyiydBJKlsH3Zy8LRob1hUcSLVrOTab80wXzEE9cq/NYHmguLVMDNQiWZ3SMVmJfCHEKVoNwLisX+xJT29YaXvQdfWYXkChynPOKiTFxQE18NIIdP87OEvjH7UdUZdIlxkSqeQqeuyVsnsRenL+wawgtb4fOZiHQUwHwTXSsxtDXZXDABsp98CtUzZbeuwcOJTWIlvgPamzygx+UE1G9LMDDpVp99j2XV5Jekn14cknksK7Ea5KBw/sIG6zpPlFr3LZp7vPyZtcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcb56d-870f-4add-bf21-08df23990f37
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:00:40.4312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cbS3KRrWU5BXgxr53pP7DroPDQDz8che/Thocwkm9FSzquuoqHsx97H/xUFMyHV0DPSnEsVVfRhZCbH01pV1VQespKIBGCRxv8AGYjl/8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
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

On Tue, Oct 06, 2026 at 12:38:48PM +0200, Burakov, Anatoly wrote:
> On 9/27/2026 7:52 PM, Sandeep Penigalapati wrote:
> > E610 VFs report a wrong link speed (e.g. 10G while the PF is at 1G)
> > because the speed is decoded from the VFLINKS register, which E610 does
> > not use for VF link state.
> > 
> > Commit adbd71030575 ("net/ixgbe/base: fix link status for E610") added a
> > mailbox operation to fetch the link state from the PF and bumped the VF
> > mailbox API to 1.6, but the PMD never used it: ixgbevf_negotiate_api()
> > caps the API at 1.3 and ixgbevf_check_link() reads VFLINKS instead of the
> > base helper.
> > 
> > Negotiate the mailbox API up to 1.6 and query the PF for the link state
> > on E610 VFs. Other MAC types are unchanged.
> > 
> > Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")
> > Cc: stable@dpdk.org
> > Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.
thanks,
/Bruce
