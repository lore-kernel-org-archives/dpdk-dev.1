Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D39E9B263
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 13:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BADF40270;
	Tue, 24 Feb 2026 14:53:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D8EB2400D5;
 Tue, 24 Feb 2026 14:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771941232; x=1803477232;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TA0mdbG++MWsZBw0GFek90baYQOmqzmvStWMc6lqH/8=;
 b=GnY6mprY/tuSXm0LPJk32WbbqWLdtRLq9ivAWJO+FqFEt79l9WDPEUjl
 +gwv4ZHMTq5xX8NbPBVUPmjoAXdbFjv67qGMmluFIXubObOaWiPTBMjVe
 AC+RTthVfdCKV90fGnBDFbPEL0IPeg8xWAyxbl8uJIBXfFoubUF3z8yT5
 R346q6aTD8X9SsR8GBgEr2fj56Um8MVs/kcs6X1n+BDChCpaXSNjQM2Ko
 ou9/eqyy/Z3rn4fe0IVc5xYBe0HjAFj3NKQjHpyYnihbyiLNnfLNaDPTm
 QvCEe3UT/hfWG2T2gU6SGRhQIZw5A6CqYNWZkAnzTpb9L4afvyNB4ZPRh w==;
X-CSE-ConnectionGUID: Tq7svPD/SOCqvyppX5dvzg==
X-CSE-MsgGUID: DoILUVwrRP+5dWg3EbB/Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72995270"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72995270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 05:53:50 -0800
X-CSE-ConnectionGUID: gvXMpsEmRWm7Ayv/0s8qLQ==
X-CSE-MsgGUID: f3JZ4q2rSBiXPbCO9xxGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="215925764"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 05:53:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 05:53:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 05:53:49 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 05:53:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io8V3JqTcEEwexHl7hH93tJWExhAvHlmrIGSMYl0TkW49tNnDCHT/Mf11UPbbDNX4yJglEw38r0Z8EblizY7SpGyyakoNIz2HnQVjCxmG79lAMX88i7zJv1M4vcH5XHfbkwuAM2LKdNllrZGWYEBo6owEJhoTA6irEbxmm5kFTVIOw0BX38QP4n8XXb0XOliFLZd8rAn6OqeK4NAwIZu+ftLssLY2s09eGIW5WtSf74Cm0pob0eIs7t5ML9ZhWay02VJR0cWINMfzl9DVFeM9LocY9xXtIh19QnBhrzj/6BHmoOEsE7OW98QM4eNvedd3QmP4NxcHV2mF17ttn+2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVfOllP42hXEWlqfwGoT7EuEJuhf4n7OEBLWSx3DK7E=;
 b=xosmi/ZVxuZcVPazsqPzfmpVS5GXbJpf+Wkq8Xiq8CK3hNCdXyk08pKJ7ngbj5JnQrB/4P0166zdkeYVrS72g7mI2MwylRdZFEcxXUbvibCcg+wv0QZij5aOcOYOzJ9/YRL4SH1TOKdmzUp8Z1TKC6A0oy4lm3jpryRxv0KbfBXWE5BPmpR4yAGnty3/p98fOPYvFUZzG5pqb8K/ghnjJbfKnLrfSul11nnerallqbGsaKFe6ycZsGKc/Fr5xIcKsyKDWt7Q79rABjw3G+N3dNl0ZJcncliwDVDNmGdOiJnVgLgz/CEcatAZM3H/gibWNfAvBS7XLpVsKiC9rlcv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB8023.namprd11.prod.outlook.com (2603:10b6:806:2ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Tue, 24 Feb
 2026 13:53:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:53:41 +0000
Date: Tue, 24 Feb 2026 13:53:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min
 Hu (Connor)" <humin29@huawei.com>, Chaoyong He <chaoyong.he@corigine.com>, 
 Long Wu <long.wu@corigine.com>
Subject: Re: [PATCH] net/bonding: clamp Rx free threshold for small rings
Message-ID: <aZ2tX1th5fcaCltN@bricha3-mobl1.ger.corp.intel.com>
References: <20260224121358.3102740-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6574B@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6574B@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0d2ff0-9a5b-4a68-6c30-08de73ac1e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zD3tXBqCLVBBQglNKavh7myh3jWfle6vTdmQZ3/RdM9J7gbonT4uf2+VTa?=
 =?iso-8859-1?Q?dpmTZ84+3uq4DkBmgwI1UXcBMzoR9FWE0l1uelYiBEEPIMCN8qh2tGj6Ed?=
 =?iso-8859-1?Q?Y/RsQoc61fmxIKHj2FyNK8ZoCH4UKtw2d0sZ/rVZhq9JY6Il5aSlTdNsyu?=
 =?iso-8859-1?Q?/P+RcWCMF9AUSh+wonbB6sNAgMg7cA5U4TZ6WyOMv3iP1Gv+kmuRxrdX6h?=
 =?iso-8859-1?Q?G40gc7pWsH5ktXnYgq6qH55F4If8JovUvAeJiIMeRJIhKp0LtrG1QO/oP4?=
 =?iso-8859-1?Q?72weEK9dag5rgZseYhJ60kmFAVJfq+H+ADcg3WzCYoCcPmsKlpvn7qSx4x?=
 =?iso-8859-1?Q?oETvAUwadm29xGDCoo/C6rMNHt5wkWSA0oY3yFG48alVEEwhU95hyVwMEj?=
 =?iso-8859-1?Q?YX/XdNe0rUhbcFi1jvKzNEfHAFEJkct9vU2tk5TPuO0qSUVTg+DIiCG4vw?=
 =?iso-8859-1?Q?NGFkOdAyGFamqz+eoLAAZ/F3VwyWQ7wRLSH5kt1jaHGcTgfT6cADMZ8Z3r?=
 =?iso-8859-1?Q?y/lX7qiQ+U15pqSuVASOnZ3F/VDTkDtP+DcCS0u6JCQBXorCiSVvLIE0aT?=
 =?iso-8859-1?Q?5Z/90OeYTTk7kxrLMhoaSOqjc6savcraTRC5DotUj8tsOT2US6Eehs/bje?=
 =?iso-8859-1?Q?/CsYsziHnsgz3lRPLH/gm7dvnqJ1AbTjB1wof0NTauPXh5fDTw3jmB0NwH?=
 =?iso-8859-1?Q?6UymCX95xTraAGnvXftTZZdJpqfeceB4PI8xYxB6aS/dkDkiLmXTrOeM9m?=
 =?iso-8859-1?Q?qGx4I7LSafN1EDn1bjgfsEFdn3v94tn/1ad8oWf+JXln87azl9fxjKqdXs?=
 =?iso-8859-1?Q?L8fJpX3Kk4WxXdVSP8zF+4pkNLqt89XkBj6JnXtHF/7M9fE0QbEgVILaC9?=
 =?iso-8859-1?Q?fEJ+VCa/7/7sfZZI6CUjXOkC2+Ti/XqjXx720R/u6U35JIBwiPdWgZgU5T?=
 =?iso-8859-1?Q?nNPu/5lbK+60drm+tZfCE+AwXAaCKiYAbGjcCNoph+YCr85+b65wGHfKMg?=
 =?iso-8859-1?Q?91pF+TK6u6lTrF4BBHl0SU/7ye2eDCykYSXpMq8JAvrVg3w2953cB6GVYX?=
 =?iso-8859-1?Q?WA+vMHi376G9Skz7j3tiSGsMIz7Xjh2cwHraZ/s2Yn2gchTA/m4XQq0CNV?=
 =?iso-8859-1?Q?UQel+0Fbhg7s18PNy5jHa7EUh3ezK7+X2q7iKjKANKEbHz+bS+Xk1LxuPQ?=
 =?iso-8859-1?Q?5ijja2jYPxg9PkzPRS75Xy+0XXjthjJLKpgtZGjyREb5AYDogO9UxROztK?=
 =?iso-8859-1?Q?sorGJLOTqDxyZJbG/LHxaaji9T/aOPzF5kCPFMMflr+IVDHeAYgrYXBh0f?=
 =?iso-8859-1?Q?J+Yfi4O1o6M1V925Iq5H0vGu+A8Q3vVZtrGUHne2QVNBkibRwiVbTjF2y3?=
 =?iso-8859-1?Q?dagq6H8FeRYuoudpGcS4yMOjELGaoyBLZLGT4Pzi5Y2EqmHJOGu/8/4W1w?=
 =?iso-8859-1?Q?jKjBZT1NiPhy2aVKteFDh3wO/nWd46UcBdrwELti5VAuTFyjdQwN8vomYu?=
 =?iso-8859-1?Q?Kt33a0dBS15mgsDZ3HTQen3uYNIvxlmDYGjnF5ACtVxs9EFCOdVfXTxyPy?=
 =?iso-8859-1?Q?ghYfh0inlxQxtaiiK7eVhH1FN9hg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1ZME+55SKQcOe26K08oaOz9M599RUhIM4EOzWOoxFcrLLZjbZhz4mY8bEJ?=
 =?iso-8859-1?Q?iErPGRH/yINsf3u2xd/y8q08uwN1QLYEneqOafliQ27o2jQXjriFPYNP9+?=
 =?iso-8859-1?Q?e4n0xKpO7q2R+QslEhRaNqxRsi8Jf7ubPo58oITnoc9DJLr5z7Xo3os+Wk?=
 =?iso-8859-1?Q?DemXDolHkAjuWnGrDBVTn74PRNDt0OEcGn4hn5cgi0XKhLiaks6+9bnTmR?=
 =?iso-8859-1?Q?gTmZ5/goAz3ogdKPgldbyD1nxS0QMTcfeOHWrG1UWB7uS2rrLe9QK8GQvE?=
 =?iso-8859-1?Q?DO3RSAMqM3EQcZi5qEwnKH6Ey05hpGKMY0m3AAIEQfRWigCAM+w8vupUiv?=
 =?iso-8859-1?Q?BHsRHNpvWlWdsVX+YXNGkB1kP6ul16v/ml/Y8hoOIG8rXztsanJcJJPGn7?=
 =?iso-8859-1?Q?0Z8EqsMKG3BR96VT1d7+kWNsApgeaATl7RkyKnPSJ8B1wNK1NpKJxEH0PU?=
 =?iso-8859-1?Q?tF336t1/Ae18OTnxbYlFDZwOqj0p+6ETHpgtruXDn46sAsjjy5ZAjS8eo4?=
 =?iso-8859-1?Q?OWEWC+S8D1OI1phhrtUGZT3ubTEUCqyBNi0e0Xy1Gw0v5v67sS4DuydjnL?=
 =?iso-8859-1?Q?zk61oElXZ+9sydhDlvTVVrNsJQbuCqJ43swkK8i84V7dRmmQ9dFakiXh70?=
 =?iso-8859-1?Q?gYQ5UceUrkm6u3U4XZ+pkXsYy4cLXCs3SW81DPRI3FxGrD+veCSogRgRg3?=
 =?iso-8859-1?Q?woSKP5VTaE6V9RbJwbnIfYwdd0Nk4zJfElVF7RIyc110lEYMw/dOd/SOGH?=
 =?iso-8859-1?Q?1SCAJ7F0apBJ68Fb5w/JHwMqqe3/kJM0qt/Iau3otRKWJK+Xw4TGUBwbVC?=
 =?iso-8859-1?Q?//0w85QV9XR/79VxOpHixarCeMI+cJlVsRq5O65WUOtIZS+dJBA3vSjzE5?=
 =?iso-8859-1?Q?uEN3Xjw6E16S/4z4h+uuxbM0nwuLYKugyn20R+R/xE0PDdOnQDN7UiN2Gy?=
 =?iso-8859-1?Q?CdHuCslC4nJY6pFP8retXHkzcGhU66Q4tXJlhGqICLE1ROqZNpgVvZVyA4?=
 =?iso-8859-1?Q?5ZIYFrPrxhje2D7aBDPVjAr4+ms01RWyK+5VgBLja+eYlltPNc4Bj0LA0+?=
 =?iso-8859-1?Q?vtRw30qtRAmpSXgtkIHMfkpcJOPWTRFvwWCBhgNSQ+gc4tVwljWd99DNgd?=
 =?iso-8859-1?Q?cI/idbUW34j1dHqOUINoNHYgoIffux814UUdfQPReF/iF81fdm+Qv6lo19?=
 =?iso-8859-1?Q?Yxg5JhwyVxi9UJP+j6TX1nCc8clriql2vI6yA3qhRJ0Gbl9NrA2gJ5eI4J?=
 =?iso-8859-1?Q?Dl0t+PLyhnMFQ5Z4sHiadet7Ei2Q6nqcFnPGgfhkKxaTRsOLuzqGYxH+63?=
 =?iso-8859-1?Q?qTMXUGpbd4clK3+wFoRECUyy+UHrGL6yRVcxUj8Ur88Nxtvag2eccxmTF9?=
 =?iso-8859-1?Q?F4L8m+Eim5P7Bb5fYrKtbIUspdtj5311Umbfv5xb3YxKJ01NXW0Z8Hr4gS?=
 =?iso-8859-1?Q?t1k7cn3+o45ipO7h3B97XXiQRjztWootfmc//ZktaVhRZ2zqGx2GHpMvSO?=
 =?iso-8859-1?Q?dlimECPfmZajElRc9s4kDEH7VvloGLDzpAknwcrOv31qT/h6JQY9BUipQq?=
 =?iso-8859-1?Q?DKAe4D1JFv5Xbt+qFFvmW1cOcD0RWMkCHEAaW+G6OpuD3F0NrBbJi5Q6/K?=
 =?iso-8859-1?Q?y1M50jJEWU16Jbu1868iPdgEk1KbCuBT9zHFBhZngpqGzwTfIyl1wD5GB8?=
 =?iso-8859-1?Q?FY4Qc9C4IHqw7xcK49XrjVesjPZXLsdCFrB71D4KCOr9YobDOule4Aaj8U?=
 =?iso-8859-1?Q?OWaH6eMwkWvE12h1z6TL56LTORCpY2Ywdp+eqLzJTE0bcsrwpZcgqLb6cJ?=
 =?iso-8859-1?Q?H25wsC6909/GGDxu6Pw9kA7hSnuxdq0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0d2ff0-9a5b-4a68-6c30-08de73ac1e09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:53:41.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzpUM+I46N4uxnUT0J9Z3yLiz/PPRiFtbbkzlN6rYaZDK1xxTaELZYW3/lD5LBf4lcNXd5hhpCo4aYaXrmIfIXrFBJnjxb+UbZr7JIqCGkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8023
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

On Tue, Feb 24, 2026 at 01:48:24PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 24 February 2026 13.14
> > 
> > The bonding driver creates a minimal-sized Rx ring as part of the
> > setup,
> > using the driver default parameters as it does so. However, for some
> > cases the default values need adjustment for absolute minimal sized
> > rings which can cause failures - for example, having an free threshold
> > of 32 is too large for a ring of size 64.
> > 
> > Unfortunately, the drivers themselves cannot properly handle this by
> > adjusting their defaults because:
> > a) the defaults are returned from info_get which gets called before the
> > desired ring-size is known
> > b) the replacement of the NULL rxconf value, which indicates use of
> > defaults, happens at the ethdev level, so the driver is unaware of the
> > source of the requested parameters - whether they are explicitly set by
> > the user or substituted by ethdev layer.
> > 
> > Therefore, we modify the bonding PMD to clamp the free thresh value to
> > ring_size / 4 which should work in all cases.
> 
> I have complained about the inability to rely on drivers' capability reporting in edge cases before.
> Here's another reason for complaining about it.
> It's not easy pleasing everyone. ;-)
> 
> From an application perspective, this is black magic, and should be documented.
> E.g. like:
> https://elixir.bootlin.com/dpdk/v25.11/source/lib/ethdev/rte_ethdev.h#L6322
> 
> Anyway, this patch is better than being broken, so:
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Thanks for the ack.
My preferred solution was originally to add a parameter to the rx_setup
callback from ethdev to let drivers know that there was a null parameter
passed in rather than explicit values. However, that was a LOT of churn in
the code for something so small as this.

In terms of documenting this, the affected Intel drivers now print explicit
error messages telling the user what to fix. I'm still uncertain whether
just fixing this on the fly might be a better solution than failing config,
but given that this is likely an edge case, easily fixed in apps due to
(hopefully) clear error reporting, I've taken the approach in this patch as
the least intrusive, while still reasonable, fix for the specific scenario
using the bonding driver.

/Bruce

PS: I'm surprised this hasn't been flagged as broken before, since before
commit 93de214d5eb6 ("net/intel: improve Rx descriptor ring size checks")
from last December, the invalid config was silently accepted by Intel
drivers and then the ethdev would fail to receive after doing ring
wrap-around.
