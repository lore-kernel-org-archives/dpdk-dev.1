Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01366C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FEF4402AC;
	Thu, 13 Aug 2026 15:49:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0360C40298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786628946; x=1818164946;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RsfeZNSNRc3wS1eywgDDPpHhzy3X/fw5DvQQRKmx3Ag=;
 b=eJVSLoMGbLxtADrTYqwq/45swGZtAyflFYyrmP8r5KRe0cq6SE2uBDDz
 s6S146oH4y0O9FRvxW25n53oVNy4cWkjLXefob8E76HZpNndsptuaydcR
 V6XO2/q22+FyUowfSfhP/K1YNXj8F/fXBsCLLg7Vbg8uhbSITxeWPyrAM
 8OIoGC5xv68owqB3i47A5av6AOjlLO2ObO+OyM4D5PTCio6rxqbF6AiDx
 RfwqTJEs7nGPwtszXQX/lKjvCnzWFqU42cHihvOsRP/Pp2cOvQoqDRozf
 iPXuftMg8MWOJ3DNKa8eU8p9DplJYySipmpWeq+bozNXVKNbwU5mzsAJG Q==;
X-CSE-ConnectionGUID: giAamUn5SL2/2bb4G0R3HQ==
X-CSE-MsgGUID: 5/bjDwVgQo6gS0e2rLnRYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87126635"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87126635"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:49:00 -0700
X-CSE-ConnectionGUID: KWUxs/wITXukXdVT33AFUQ==
X-CSE-MsgGUID: iOQWcQqwRFWeJEJ4hJ55Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="261317137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:48:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:48:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:48:57 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At1ybGQdeEB3PeSKqkSghn3SGTxGkQQV95+Y6GHsXOJZmLBKqr47dMbz/Er6RVDcS53ej+irt9xdtm/HVHMSOC7Hk+4klUmdJdRSAGk/yDxw1+wI8XKjMlUVbfYUkzT3HVIw21hQKGr4wJU/rh7htmRqBOjbK68mL+vGaaOexsFhvBLuH3B9Io8+swgq8IcyAXzNmakGLMNtsZIdYpIrZxrWRoBevpXBBUmDQxUGZMcnKsWZmYCJgfKOMklQdNlNE2DYVymvj4Oi5Gm/yI4Pt8rQlAKZm10MkUMc5JfyT5JOhFEUVTqzf+RVEbM4Ru8ixMKmGQq3nH9hRN+R4E58NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw0so6ZL/mb2UY2lxlAxshGZ8rnClCIzo5wcKZu4H24=;
 b=sn9thqcNx+DXmqjZ8o/HQD3QF2w47ZLhB2FyoGoRaBZNODYLe3GXYfyRoYwh/YcankVsW6m7MQlFYwSkq6nvHL2Ytdf9C6RuAHyaMND19Mlj0n2YdgrLPqJAVxmR+Qj5x0LDccy+2oAOgZrOgyqIOxsx1apoo9ll34fcSw18bSV/sD2Lbqp0c2izSM6MObpA4Y7a+kl0xpueizwzUkNzetjmucr1F3fe/QM0E7dpYgNn7zrQpOOAFcYJMC3EaeKwBDxmVJp5uei3VuOM76s2FQE/LJjRU8PgiUblq/29GU8dvkFKaqS3TJ0gjVONx7sEoBQvr4xegtqRP687LeVGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DSWPR11MB9761.namprd11.prod.outlook.com (2603:10b6:8:356::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 13:48:55 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:48:55 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 5/7] net/iavf: improve VF reset detection on fast ARQ
 flip
Thread-Topic: [PATCH v2 5/7] net/iavf: improve VF reset detection on fast ARQ
 flip
Thread-Index: AQHdKxEQRuYNRMjXzEWXGNhHdI+r+7ab/oXw
Date: Thu, 13 Aug 2026 13:48:54 +0000
Message-ID: <IA4PR11MB927899DEA234EE61CB57610F8EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <1087472087390290d367d3906743894ae20871c7.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <1087472087390290d367d3906743894ae20871c7.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DSWPR11MB9761:EE_
x-ms-office365-filtering-correlation-id: 348a97e3-04d9-460f-7e92-08def9419de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: DlY3qqM6OfrKj4Z/upgKEuqFXjWrytn5dxwveGTfmX2P9dw8ZReOnJXel6hvvVKNvzx/fD3EpbgklmYTzWq0+TWtc5B0ifCTuuLCnwGsoXxkuE6NzSgpDVm/ABPJ+tmxufnUpGkkbHjDeFdAzmU0L1DNSwvXzl0nCvIQiOW7fzYUfPTdENoSr8i5fiUi+kfd6jEYZ3mAukMJWLwboJZsp5hBMf3zcHFk33boOXIvW5qYBIsDopPCsDdkXmhYdWdMuoEdtUedpXI+Noq4JS7yfxxMWSgLHU/+zADPad+euFz+uZqrRbiVunq53+cv0GkYBwuvb3/QkQl8DzGAKLBHebCxpexTnEuHHzRLGIMK6txCFSE3QCZEoBACwCfvpfYmWy62v895h1OhFE5E1yNU1qoY9KYbfgfKu4+XBTG9xAcETR9nPIvgryZV/dCISUlkjB94ckRHB/vJAzptMWYiO02zhpl977Adggp0ocg6a8gpZXOYq2iO/JYHEY9CTgesftkZrJyyYaj8D7X8ZY5KRi9rFRQ2012WgFaYAqMOhwmzElDE8RD9mr5UXzYzmcyrzS+I+1M3Siu3Hv3upkfvgdesvi0fwMUAl4Xosv8qfHECrrFg17JrbL/t1ZTQoHmvcAdCSRr8qI30erSRD5+IzCqMi5qL79NC5hAk25SvMLyFYtqUuyYUx7ZcniGUBXEdZp51sxDTVpkPZeL22UtxBksvW234Kw8KljcpbEN0P9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W2/MdTEr1YfnwSCFKgISKmVkrETxDPzb9FzojNutKBWeWA6FLUHCxngnN+w9?=
 =?us-ascii?Q?XWFVtqru6n/C4GZoblSFZFKjOKpekiR1Dk7MIbJAfV6y6edNr0GcG77rfDFc?=
 =?us-ascii?Q?smlNM80vJHg/e1i7gUtvXY58D+7jdZ26I2lAF6e17dF5KgQfvkHpMSyLamKG?=
 =?us-ascii?Q?JDBCx4XnCXTuBSHX6dUbmg2+nFK3vZaeEJgM5NgTc/Q3bzM64ri+ibFJlfew?=
 =?us-ascii?Q?yr3SafSGj39OqQwph7DhCTlRJBWWWl32Y+ZAFFGz4O2VzmxHsCNcp+sLP4Qq?=
 =?us-ascii?Q?gNUYL9XwLh1sR9ABEAJe4aZrMO2g+SUZqV7ybPD7J00FkkMJ5blqAljh33hH?=
 =?us-ascii?Q?Umih1yVkRgykZdHervUyBV/yMUwxVtQyMck/E4hIxNSUbJJp62YJH0iCYqUy?=
 =?us-ascii?Q?X8om/aHWB6pZdFTusiWJ7SNvuy7/40oZdKtwAH4w5sJV/f3EjtM5binzYVjN?=
 =?us-ascii?Q?08gi0T/w23YUqrdTPOmrJfOXL72icA5oknnnfT/f06TFPf6wnRqigZWvtt0q?=
 =?us-ascii?Q?ZuVIu7/15r+s6XLu1J20cS9LbVShdI9wr1LrzLeGUQ3moWz9cv0cNYtlMiQ7?=
 =?us-ascii?Q?ZM2Rn4h70DqV11/lffU2meDvxcMJGqYwdtOTOpdLisFWhpz/U1OCaQNFW+Vk?=
 =?us-ascii?Q?RyZJcMfBO6qGNHmCWFewznjkZRZklCZrR2eYGdTJQxIuRwLOad0FDOfpQasJ?=
 =?us-ascii?Q?4FI43WBbzUh1XHq8idXKDk/EJZcBErhTbs5rH8y7GaHu1KmP0GxzrpcuwT8A?=
 =?us-ascii?Q?U0DjissiK0IxkJbnyNPR7CsK8hY6sGuBrBkMJowP1qM9rrL55IYoj3z9qwqP?=
 =?us-ascii?Q?XjBnAIzybpFOX5QaZh91FD5CewpqnHAhxt/xYQNP/6FI4lP1e1YrVusH+Rio?=
 =?us-ascii?Q?j/qNU69ccHnDQWbLtCtQJmUacyVfzFxa/vSseSHY5v1KVwuToaJNG+U1720G?=
 =?us-ascii?Q?PLN/p+AiHAlNHqbRyrpppmabuyj7hbVYErrY36pLtvravpO/iFe2Ti9+B2e8?=
 =?us-ascii?Q?YSZH9ruy9IblOGw5Ie7eAwEjMrkmzMgKlKLyqODsfSZV56DYpN/CnmfobQlE?=
 =?us-ascii?Q?VJSKeUMR1Ia/pYDX/BN9Ef/4kMqq6g+x/4vDdabw/Adpfm6sbg4Kc0ul+HIz?=
 =?us-ascii?Q?mlCSHHDGVhBvpwDRDomn2lhN6VzFMa2FN4C1rh/2LRmaW813cshjSHG4tICq?=
 =?us-ascii?Q?KGPfGOFL2QI5ugdbh8pfr6l6USdAInYWfU8vuRQ8hupHo8/Y5miKOKY8/4JI?=
 =?us-ascii?Q?Hy4CwjenlannUNWYomItT3ppv8MIQOdHd5YBIvQhQ558f1jgvIz8kcGSnuN5?=
 =?us-ascii?Q?MU0myTrPnaXYItOoEi4zfvqTtSOpJ2jsmnlMJUmXw2nv7ZrmeL5wMV/fSYdN?=
 =?us-ascii?Q?aIz66uXIPIymFDu1AejW3mBjmTbsM/7j1SyqWVmzQcz/6Fyb8jkKL2UQxbX9?=
 =?us-ascii?Q?D0FGhhB+xyhO4WA8C8ARSzMHDFnaCIDMv1zxxUTaps8b+sWPJ1vIJPZYFBxQ?=
 =?us-ascii?Q?abTW0obHA4B4l4i/y5dWgxA80NLKL9R0bVHDIY0R7YExxUI/Adx2Whmmyrki?=
 =?us-ascii?Q?1SF6bG2Nr9yqt1e85fWYR2L9847RMi32z3YNEJFkP7BAlMxE7Fn7IdLkpeLr?=
 =?us-ascii?Q?13/32hnXmoogkTIu11LVmbCrd/opYdLSfnEao8g2h8pncqms3kz58EXfwHR5?=
 =?us-ascii?Q?X/O+cj5ISUM1oJUBKuje20psSTXIBM5XkQWfpDKeChDGLn8pES/sFu8/w/Pb?=
 =?us-ascii?Q?amCcdF2kuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: odPb6MJDtvc6ymXtRg5qu3oJudfmhZ3LE8dhB5GE81MTz5lwPjlXrhUX/w93sWwjytq/LL0W+ZM606s9yn8xGTVZA+Ig9lP4B9MB+EXDpmPw/ENW/zbJlhKYHmD3SY7rYPAkd8JNJfyEB4f2lDTdpd/awKF/x3yDi2lqNGZOcZc2nUPpW7TNaDs65eUo/ZL9V/8xjHq/C4gE8G2EryV0LR7/ls96UaWGK8nI28s+2EvPFUliNM4w9xTFy11fLjg53+aKSb/YjJbbRSeKfDInLsd0lFcvZsOyUcwWqrsbKw7SJ3u21IvplWi/0wXP2WnMYCF9735lc+2k3GIFNPsHCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348a97e3-04d9-460f-7e92-08def9419de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:48:54.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meYfDOhPx9+xYcWDdji3MxxokNYcAF1e4AXqXhhtTLYLyoHMDwQe9oWJL7tPaCT78ztEcTA227abK5KEak0W+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9761
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

> Subject: [PATCH v2 5/7] net/iavf: improve VF reset detection on fast ARQ =
flip
>=20
> During PF-initiated reset or a remote/ToR switch link-flap,
> the PF toggles the admin receive queue enable bit (ARQLEN1)
> so quickly around a VF reset that the VF's sampling window
> misses it, leaving the PF and the VF states out of sync
> and the data path stalled.
>=20
> Complement the ARQLEN1 check with VFGEN_RSTAT
> (VIRTCHNL_VFR_INPROGRESS) and shorten the poll interval to
> 5 ms (with a proportionally larger count, keeping the ~10 s
> budget), matching the Linux kernel iavf driver.
> When the VFR is still not observed, proceed with recovery
> instead of bailing out so the PF and  the VF states converge.

Double space between "and" and "the"

>=20
> Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")

I think the above Fixes tag can be dropped

> Fixes: 80fb3c920458 ("net/iavf: fix crash on VF start")

Cc stable?

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>


