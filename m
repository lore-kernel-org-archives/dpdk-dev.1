Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D124CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A08402D9;
	Tue,  6 Oct 2026 11:51:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 54B4A402A2;
 Tue,  6 Oct 2026 11:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280307; x=1822816307;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N83MLhkZWU0kRvqdBqe4ON0emHBl5tB52pphzXuv5sE=;
 b=X94kbi7ceP5HNIN9/37UhC9deBV50R2K4IZ2BD2G8yu6q6ywwbRuuGgP
 9XSgPRa1Jp3QsFm9hlEf0f9zFpU4vbf69d9FTOIA+/Qv+msZKuPAaZaw/
 tyZL1iKwD9PZvZPyGNoaSgHvxaz90eZ2KYa9fYRl8onGjoaTbpJ8hKdsz
 vVTdOpZUDtPK48OxuxPdSQYk3lUTQGpgnL8DIcbqxQUBFN494uknEkTPa
 khiGC9zZbyt3AeSXiyuvq5EhUJVrnZ0gqlUjJjtdzVWk9iaeg2tBOZkJW
 eqYy704vvEEaospI2n9qI4SCyxr2Onppov3x+K595Fhjy0oIbG0piHOwZ w==;
X-CSE-ConnectionGUID: mdpJS64bQBSsG1vJXUkW5Q==
X-CSE-MsgGUID: WD5l0WE5QaSThhYnAxq1DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95781669"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="95781669"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:51:45 -0700
X-CSE-ConnectionGUID: r/Qh56NBTIiXpDNBKRLekg==
X-CSE-MsgGUID: prhYZxCDQmeZp7/Bz2Umww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276225268"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:51:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:51:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:51:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7ctXI+V/x078dkTUGrrK3AIuI0DV8caLopmQXk2UGHADVw0nNTBTUV7K3+cZYBMaM/ZDdFr+v1PIRA50XQpTzcHYsnt2OSSWcfC86xWB2r3TE8mH1ZihKBJ+sn4zHvTrnSdr5KuSy4aqqPysGBstddQ0q+y4BSckdQ4sJDAL+DX3kUvpxJyKWmh6Y+KWTGJBd1QJDGaKfmC9k3Gt8ymXKx3BSQ7/De8EYDFmxcmNizQeNMhrzSWw/9+7CL6wfnTub/c6LwhSNyTf59HAz9UcH8tK0aWSV9ouXFdb20qHq4Bb8jPaQZApUqvANFqKrx43Quf5E+kzTGCIvTwrKvg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADddf/vWxIFm8v+oQB30eFVIK30TyXeF3XuJc3ko4O0=;
 b=AcOlvCM+JuWOXiili8YzMxIuqaGfWDLp1VySLi/p6KJYrL9Gan3xGGsENP/NKK6nkrdY5akKLlunZT0lbODCB6m7kFyBPrjZRq0pEVncvILSbfKdl5m7GLYTedPoTbLcYytt6j8nxnQuqCCkIkq4Oqf0Z9obaGP4GubRzlUIQTlFl/mZ1qqNmAs2x2YX+loJfn45fHE9VtTGefcRhMqlavdGLBf5eBQomuKgppB9cesjH9lX9uNw16Ok5P5/qaIPHYpHFKIFJT6tM8ReUl9eCUHQEsOmBVFjxiqR9EU89RS2dp4/aPrA9sEmve9Sn5MyiPBqoCCJEv8LxuV9fmIpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:51:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 09:51:36 +0000
Date: Tue, 6 Oct 2026 10:51:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Zhang Tengfei <zhtfdev@gmail.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Dongdong Liu
 <liudongdong3@huawei.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2] net/ixgbe: fix repeated Rx packet buffer shrink for
 FDIR
Message-ID: <asTEo5Gc7nd54rD1@bricha3-mobl1.ger.corp.intel.com>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
 <20260927042545.45152-1-zhtfdev@gmail.com>
 <9d10d4e1-c931-482a-b3ac-b8d2a2c37cd6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d10d4e1-c931-482a-b3ac-b8d2a2c37cd6@intel.com>
X-ClientProxiedBy: DU7PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 580a1ab5-dc0d-499d-1241-08df238f6939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|4143699003|6133799003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MZZXvaqyUBXjQ1A/M8kag7zB65Og3GsF8Q0t6/D6OctsZwjMnEe8W240FntMP3HITdEI80Va4eO2jyrxHlcBxtOJaauk4En40aloNm6YfIDNJSXLWDtSYVpWpUOZEmqo3njjud3ntqKVyx0kRZS/8zo0c50AkitGdjS9TqF5QNfZPkgGLzbABiIppkCqse3mQuKBQryOxAT+c9xKtXhnjpNxd9nf74e1boa973oQkqENNxyiYmyBXGV05PBxRKF2neYMl+HzsxSKlixds1L/kI9HMXHrk7ilhj9EjM2dUT8h/WHnkNV8HSJ0e8EXdaGLUnsefeHpwUYvKH0IR8zqbRnbjvWBBmMu0mnmi0cJWIDxXrm3f0xtOhYehVU0DnLFkT0NKK5hfC7+5qjWKY+IP3XsiX809ij6B4ehyM5xzyTQMqkPaXY7VgkRFhY4Hmh04rnWVSY43aDBRS4rW5+cMUGgxO7e6IUfne2YR4eKiAWOgUlghRHaU7xVAtWVUVclvv+Hjy+r8I1coewnUHTkzZhkq2x5flGQTMNxhHfKuXBnnht17AOvGqUP+9c6MZ+ZqbwHz6v8RSaQEYhWtwB0ChIGnPGHsoLwlhRMfF3nky/KLT8Vz74O5+N2JSw61Mr8RUTVhDhJ78IK24GryzivSc6PrX4EnUHTgUtwiozR5xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yuvZou3O07vL4Fhz7ZftVjZTlKz039y8jl/Oiim4dpeQJ/0bRnnysgb8f6Bm?=
 =?us-ascii?Q?nrfDs0FnpBT3v/YFQn9z2pHRAlnZQVj4C5ACfEBrm4X8YXnSpJFFNNa3PkJZ?=
 =?us-ascii?Q?zyvt7gVHRgppIc4Sag8rwtcISltVabveb6DKYmc06tkSeVVGbzvfENPsrJ8+?=
 =?us-ascii?Q?4vHcF3QpoMCmj9Hc6WE6bOB1cKWugxYv7JvLeuAIx5+IDIph0IHt36i6lapo?=
 =?us-ascii?Q?F/V7iE2rYY1KyxiO73sjShxLnoi2PIhl00s2scamepN3ii7uyvhY/3LhR76f?=
 =?us-ascii?Q?cBrbbmdNw2kKvG6x4NzWfh/emQZ0NymQMbC9L3vTQU97fNTuD9kcq8NF59qW?=
 =?us-ascii?Q?OqeAKSoalj6fTA6XZpD8F8lkS8BdhSIinpiTe1TxM4ydWhg5QCq97t2/Z3gL?=
 =?us-ascii?Q?Qsc1WTvAGDSsH64QjU05H/gTJVM+3EeKe24red0kDh11LfS3QDYw3gfalwbz?=
 =?us-ascii?Q?zfQmxSFTaoi26Ee8XccB1nN41plEhjdHolZsQpS6B9hHSytStqRv/x2uJ4xz?=
 =?us-ascii?Q?skPwTMVoMRFbkd2VeAAAXARNvINtAlq4fl9LIXZ6oZ3f3I5e1Be5scQKn7PW?=
 =?us-ascii?Q?oZLLYDwMkbzdtFB+x4FO8hGdn8JXP27BQjRYfimWC4S3Yq5bY2SkKTE7o5hh?=
 =?us-ascii?Q?6CTSRGHh0PXOI9cC9TvdRdlhpKbGMjBE2nfJnRi+U/oDEsv7o0/vX1IWqWji?=
 =?us-ascii?Q?OSGlAtCY5Dqj8qw4u/BIYPcn0pEtppIsBQ9Q/YRgx20vfEmzTVJfK4XhRWoR?=
 =?us-ascii?Q?aAiUYlyFHC38a5UZ1yM5/11+0nyOy5v2Qugv6JzwxLotaALz2yJKSTa3TWNH?=
 =?us-ascii?Q?9eprI1YLnrEetdOmMX/234xidmZYyf8EzJoAgNm1f7R9mg7hhHEwgz5rYaqs?=
 =?us-ascii?Q?rXXje2jcDmIn6XQ4SrzUmvHh6Qtwzf1sETgLSbB5mH3bPKVsQ0vCZ34KG3UI?=
 =?us-ascii?Q?TfjlIyPi0Dv/hRmzsY6cQp3SkcLTyw5GT/ye87sYtuyFWxLPiSZUPNZ+FTS9?=
 =?us-ascii?Q?AUGKw8yL5+qeM9gn7LZ0MKKrFbpZ1xni24JRT3Xgj9t4RJDEXHqfXVlyIjE4?=
 =?us-ascii?Q?25bEC7jp9X4EMUJY6uhNktMzeXWE6ShSwN2tQjC/YIOLbmZ2RyCG6I6w5xrn?=
 =?us-ascii?Q?N/hwqI+e9ltpyHFppRQO6l3UuCGcuXIiSLJnnBgGpABgtTGehHDdck/4+L8V?=
 =?us-ascii?Q?z0butlP3sI7vz8v+BBYIGjmQ3ZzmYcDrBUyWsEP02Ly7bkHgeFSR/w1fEiwa?=
 =?us-ascii?Q?AsSwzxQpmGuLywKzmLl7064QfVRSw7E7i6OHc0QGOh9pwQtc92VOu2wX1ybo?=
 =?us-ascii?Q?eA+T+fsbLZv+lqKoZKL0R5J1NjKzZwpiROPPcV/Y9i7PyZQjfpVSZX3WyErb?=
 =?us-ascii?Q?kH0g6gBXoJ+9LlyjotQHfuvbg5V3PTjrPHajrOWRXA3NRsk4jgnXtyDc4b/z?=
 =?us-ascii?Q?3mYVYxTnqX69qo1huSb/m0+ZTKNxHWRQulxy5Nszeg0v6WqsTvHaTzUYA6ge?=
 =?us-ascii?Q?sATE7aL0bR00nGYz5gkm9qvYWsEq/IhkjcBkFZTF3pkjzzsOXpaPyjmDmXYk?=
 =?us-ascii?Q?c0Wb4d80w4hxHWqcsWKyAGAu3Y1FGyTJzr0SIrCY0LWZYPb3WYjNAriG4e1d?=
 =?us-ascii?Q?k0ktFPacKsTixrF10hxanYBwrTm2MvJqnNlSolrAgpyQ478qEJHeys4ZkJ+7?=
 =?us-ascii?Q?TvBWHz1cpEheaH9kShaOKHeDBzAsb6gkP62arajqbfJIzDU0uf3Q1j5MFVVy?=
 =?us-ascii?Q?PvXb4r8+BALeE7wpsEf1YBuFhHUPmnI=3D?=
X-Exchange-RoutingPolicyChecked: qYs7/1nba8HVAePyA6Fu7Vc9putEhAlBTzuH6MjQ89r1PKp5g6Yzo+omk2wo/otJeRcEgQqCwQm2L6PE9MBLIn3NSC8gfuX/3a5pHCmaNwl3wBJdZdAuWzpTHjou24hfLKq3AkV0bvxMKqLhf93WGTkNYRLMDNURvw9uiIIG2KUWnuRnE9Oq3bgvQtPKPg3IgPdWTuiJ0Jj4q5CCYjrAGML7OehH/ufMep+/PnC1IRtKddsjazCWcXs6bqfQxYtQzZFk0me68UP8oJJnEtI6+WHHn+hJCsQQ0a2Nsty6Mg9TCT7bsNbeXQvVzBUVHwuuIlCtf+erfzklq9wmY1dD0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a1ab5-dc0d-499d-1241-08df238f6939
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:51:36.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGVwlB6G3hEAy/nu94m0lj32X5xANjGuOOw9CvZNCiwBspBe8WkThQK9qn1wDiO3yFWbLF1syP5Q7Gvi7bhFHU/wDHV04HAPlhRLI7GgTpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
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

On Tue, Oct 06, 2026 at 11:23:06AM +0200, Burakov, Anatoly wrote:
> On 9/27/2026 6:25 AM, Zhang Tengfei wrote:
> > Enabling Flow Director reduces RXPBSIZE(0) to reserve packet buffer
> > memory for the filter table. The new size was computed from the current
> > register value, and nothing restored it when FDIR state was reset. After
> > the last FDIR rule was removed, or when the first rule failed after FDIR
> > had been enabled, the next rule created enabled FDIR again and reduced
> > the buffer a second time.
> > 
> > Compute RXPBSIZE(0) from the default packet buffer size, and disable
> > FDIR and restore the buffer when the last rule is removed, on flush, and
> > on the enable error paths.
> > 
> > Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
> > Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel

/Bruce
