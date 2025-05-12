Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D4C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 07:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203A84026C;
	Mon, 12 May 2025 09:32:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 391DF4026A
 for <dev@dpdk.org>; Mon, 12 May 2025 09:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747035140; x=1778571140;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2xo2LO6jzr4IV48uYFYF6mZeJYbYd16CaOGTQDRZX5g=;
 b=c18sUhNQLU7ni5No3dQjhZdxxxVNzYo9jB8B1EB23X0EZhoHbRx4wa6O
 5z0MLEXAterl179P2UbAA89Et07N3ci+TqdICYP+G38TcrRCLzFJ4kB3T
 HyAzZg1sFzkNOOyeMkuwDoFQUM7PjK6fFtQ8U6ti5Ao402exjftpU2Tuv
 u5yx5F2jmRgd/ErfJiKd3JnAQfgl1SvW8a3zJ0PYvVS58ZzMSy49dXpdm
 FfkS/n7uF9X4KIc1NmABxboc8dpQxCUU9JR9t1MhHIPhHNQ2X1cQvCYzS
 Nw0r2UjpZT1ksMeuvHuMCNIaH711bn6DIDoqNEgCDxMQeQ9W+0EGnHQfb g==;
X-CSE-ConnectionGUID: p6+uznk7QV+JyN7EmD1biw==
X-CSE-MsgGUID: CZsBgkcUR3m32zR1FNeiIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48936830"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="48936830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 00:32:17 -0700
X-CSE-ConnectionGUID: 1FjU+ra5SQKnmqIFZbHDeA==
X-CSE-MsgGUID: dm3DKPGoROKXU5jRsjyyHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="142407306"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 00:32:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 00:32:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 00:32:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 00:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO8q/dAWoxGYy8p4ALggBO2RBDCgKydh2WRGjrMgG8ybv17k5kbLxSu4ZhpDy5iN90RnBm4DohkOo4/6VtC2I6sQ6LMcRffYA/f4MIMXO35PTJdwlJC4N2j82AatdYyd/MlGg7V7DAy6jJJIRewqvMPFCO4JGQNv9iz9s6IGKxgSGevyFTxm0ftkRf/HkI/R5cZ01Qoo0a+Jlu5x7Fh+mT6d1Slppj9zuDIhgUEK++OzjGnoNPuIxnZVF3vHjXgLGj91mqStAsd18MW00t6CcdU8CLeTMNGiVn3Ucf6BGpYEB60/JoQuIW+R+R7/Ha2EZ49zMAy1iJETIwvUbgqbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElQUIV00wZQW3dtTJpwuEfnhx4ENh7XI8esMFsXheUQ=;
 b=CyU3MunNv6lWah2U5SFcLFqJ6B0h1pKsCkEHpis/WGyamt7naXpgqa8NRrXf+zwRW9IqtG1rYncg8OLrw7TEZPzNvWzxEeiFccXQuU0vd1vjUXJ6rti4LnOcEH2ad7fx+xcNIqjHYJQfKGFYMhN4n9l49c7+4lBL+oSrQ1NOKSc3EDillyYNQFwb5JDoY2I+utoesLBT3keafRY95tmS5sdZzAgjizgjqv3OmGnMGJdxGeSjPjAM50zKVh3PUyjVEwCDZ7Biz24VV/D2HZMHNs+K7J+D83fsmtqs7cfPHfX8aLXY8MScUXqoKZx0Gl71ZcDroGvT37IkwyxUiMJQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6)
 by DM3PPFE441933A2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 07:32:08 +0000
Received: from CH2PR11MB8777.namprd11.prod.outlook.com
 ([fe80::4fc0:d34e:5f55:8488]) by CH2PR11MB8777.namprd11.prod.outlook.com
 ([fe80::4fc0:d34e:5f55:8488%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:32:08 +0000
From: "Rybalchenko, Kirill" <kirill.rybalchenko@intel.com>
To: "Chautru, Nicolas" <nicolas.chautru@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>, "Vargas, Hernan"
 <hernan.vargas@intel.com>, "Chautru, Nicolas" <nicolas.chautru@intel.com>
Subject: RE: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
Thread-Topic: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
Thread-Index: AQHbuuX1tlrxI85siEWYCq7Qxmt/P7POqZSQ
Date: Mon, 12 May 2025 07:32:08 +0000
Message-ID: <CH2PR11MB8777A31F44AC1BCA34C4ED3B9897A@CH2PR11MB8777.namprd11.prod.outlook.com>
References: <20250501221031.4569-1-nicolas.chautru@intel.com>
 <20250501221031.4569-2-nicolas.chautru@intel.com>
In-Reply-To: <20250501221031.4569-2-nicolas.chautru@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR11MB8777:EE_|DM3PPFE441933A2:EE_
x-ms-office365-filtering-correlation-id: eb5bb474-1524-47de-4ccd-08dd912719f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YRqpfcyi1BDq5WthYvszN6/MfCSGpGpIoPNjOdTZalRRgpDsN/pstKopKGkx?=
 =?us-ascii?Q?h5OcmnjYngXAw4LJtcFHnJUX3OXhDkF+y0SWP6IUN59Lv5DbHqU9lRf832as?=
 =?us-ascii?Q?Lu5l3Pq9CC4FCneYR/W0u6YgVH+jCF1yEAEAbHVhEDND1SM5iAoJ4IA99AjA?=
 =?us-ascii?Q?w/tGTNRrfbCYY/FIxKC+xho/iILvwARPP36rMLtrh5dgUIV2BCesWEv2SeV2?=
 =?us-ascii?Q?q8/3C/vbK9zOjLXhYkOx6/a5NAvKmwmY99koIes7CbwfdAlfumyDAdbM31X4?=
 =?us-ascii?Q?ECmpVjtHW81xXH5xKjSo/+RmtIJiQVObG48JGj6sGiyq0gm/QVG6Xu6NlhVl?=
 =?us-ascii?Q?wqzuRVZN9rwOa/1PVRg/BOlTxvjkrtd6YxDZNWnJ0fRUz83en21y40QpKqL+?=
 =?us-ascii?Q?sQsEnCQedi/zLeS9xYvwFNx86nIbbuiDYKpn1hW4Nls59CbfQ2ZIsJzBgZFG?=
 =?us-ascii?Q?QmMxzQAkXtHNLOFmVuMKe0w8yNSyUBj8mR3mj5s8yHBySjArwQpHYZLMOBjz?=
 =?us-ascii?Q?q5Pkw/KsrY6pLp84CTqbu1f4sTzksPIMJ3njVVyXihB1XLelc3JX9Hkx1mVH?=
 =?us-ascii?Q?LYzeFimPlZgllpQgeIwJQV/7moNv6iWWWQlQj8QNDY/NAsTLWctRYAs5rQTq?=
 =?us-ascii?Q?lyjbuQeNmDGE8eIcpZIhBBJpgaEznUiV2+BkJGr/5k1bLtRwI9aV0CZf4eal?=
 =?us-ascii?Q?K9UeqgFe+kNjlTfTajPOi/7s94aAKS8Mg0XKVcfaGv+D3jDry+2xwmPHuBuh?=
 =?us-ascii?Q?MWgHTVxNnPaprnaDKkGdrnpaNrYAo3IH29UAOsnlMYzJNpjbLK01N41K7R0i?=
 =?us-ascii?Q?BmKBCxNFyk5chsMP0FBunV1bcHTJXMHraiLpwy6yXV1FNc9KM97E3uMI85ZO?=
 =?us-ascii?Q?+zN9A8xeQWzBvC0zbyYxBteomyWNYJ00qfihHy9ulCpGU/VAaC4Polfbh/Iy?=
 =?us-ascii?Q?AVnEZpKupDwnIEy7Sdwbe3XvydGEGacpvIY19chux9nk1BVx0yBiyN6uzqCZ?=
 =?us-ascii?Q?8Ms19IxW9RUfjTo6P9uqRjrUFqCZKVc9b93NvrX66lJAM5ivz329O3ap8CeK?=
 =?us-ascii?Q?3/Fq69gANWNYBGxlXwl+tbMQ1tw4FzRNU9UQorT1AKrGwlkEB2mphk5ObZbM?=
 =?us-ascii?Q?BlC7pTs/Uj3cy6usq5bzU09yA5yS5ROWQT52uftJIPh80OMwp80GXJq/a1VZ?=
 =?us-ascii?Q?13Q9aVz8Kj//eWTDUwm7tVSUH/WfyPhAcDzL86X7TV0z6jbSrdEBSUqENGKj?=
 =?us-ascii?Q?DHxTX67Ji252hunMOfRG8bkzvC8SibQD0u6PgIkIVa/1ZNCyph3oy7r9nJNt?=
 =?us-ascii?Q?MLipvE4nroXXT7B5GrKQ3RiKCnBadBAIjJNgCfJKrU4TYj4o71tdWxR8k0/n?=
 =?us-ascii?Q?6QCTRHd4LKF3hpQgEihOSk3AOzER8xsU2NMPLkm54igFhTQVkzNyjwSm8Nlk?=
 =?us-ascii?Q?0A/apEogOPUg8H8IlOkYyIbK1iCW4/j/tJaRuI1JQa3cAh+TNxkKDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR11MB8777.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FyXMcMFd/6nvi9yX9RImmxx9XsE404gVuQygzlICVxKYEertOv6DMB9daafT?=
 =?us-ascii?Q?HiTJWI04qllUx4TgyZyANMX9Mz7DQiZ1FfGyw6pBWkOPkVkvdtjeqfRJoQX6?=
 =?us-ascii?Q?i5x2yKsmGpRzyUhVM8ZUNpT9dGERoz+fWIOCX5PiAw7ZKuQGUorLZ+KCGa8U?=
 =?us-ascii?Q?ibNookRUjU1Q6FKrSVy4+IuTqmQE0tKejWbJWk/qEHOBl9AcqZwuX1EB/pXj?=
 =?us-ascii?Q?emUvq3p+/B349fjE5ppMN0w1DmVxtgwE8yxNNNsEuZU95pBW9fhFWCS5N/sj?=
 =?us-ascii?Q?oiG+0Ytrc2mVZCLS4slIkyZdPP9qlOcf91nylnYrBZnmSWjKh8/yfcQhzz+W?=
 =?us-ascii?Q?08oTKlVyOWavsbVNU7fzCG7+HZI47zs8GZHBe6eoH734yBBeZSJLYpooqM/3?=
 =?us-ascii?Q?+34I+3OodijmlnL+5tM+jdG9yF+/WBft+SX6ZsI08evoRwic3lYKbYh9Lt/W?=
 =?us-ascii?Q?cF4CNH8Ib0qkTTIYcN9NKywnDABrqVyku0OKa27h6sbmKzXvzyFSvmTpEwug?=
 =?us-ascii?Q?IUfWGFyMnpqinS7nAzK65AdceNRlJFKI4mKlZxrraBno0XrTGiLejU3URbIq?=
 =?us-ascii?Q?+ZEkk5UjHOMHYv6KPa1ILBliBAIjYofB0u85bPSc3k2XeQHxpbZPuqHfgHMD?=
 =?us-ascii?Q?D5wK4eYgY67RhRYzXRotFex62JELK97bXjomQzoZHFR39Eii0QU/ZhFv4G7C?=
 =?us-ascii?Q?5m3lEALRfFp47fLKzCgJnhbNQVU3qdsPzqx8bnYt4A0BINCDOow4qMK7+7sX?=
 =?us-ascii?Q?K6DzYvHaB6UtRVMzQ2sqNZWIwSAovOkdeRdlcBK0bnuR1NIqDqADc6Qlzh//?=
 =?us-ascii?Q?lbQkNa2L3zvrQ042UrUBv9oHYjFZIveYskBjCzMylXQETUTAJbp7vrOmbS4x?=
 =?us-ascii?Q?dVnlChPTBV/jZKYqDv3FaasFIWHHDEYEwXVXaSEw7CuNR2GBwUZK0GwNThga?=
 =?us-ascii?Q?CBXzvIoETfpBcOaC3HdCOE3RiSrQw5o304FxLM0S+VnQH1vPIb5hAV2HTiE5?=
 =?us-ascii?Q?sESxQCsnVA70GAVf7m8CV2uKD55Uqxp/KLH1lMQjMbNxzTTZtEdo4rxhnKD1?=
 =?us-ascii?Q?NLDXhkHDp4h78nlbJdv9ZvDLSNFfg4VROXIQSGyM+AU9oy+MM3/C1BGzbsqV?=
 =?us-ascii?Q?itWE2++jO17DNW+EZCdi7QwuAqDPqM6Ei0UkHk3F4urQh+dyhFuON+68mP4k?=
 =?us-ascii?Q?xgzc7zsJAnvO1VdwUAHlEb0uBdKGE9a7dtxA8F5ZaFlieH8w9k5Pk/xtn5ur?=
 =?us-ascii?Q?xqGSA5NDQYakg40dXxkv71vPW5Ts1R8M+nzOskh8ic0WpyHShsaPS8tgAB1T?=
 =?us-ascii?Q?+ZwEb13Jl5esYqnI2TB9AcjW4/1MPGGbSPofUFIibd0HBPeczQFm9EXaI6MT?=
 =?us-ascii?Q?VAc0ibdVQWxPQr8gJysAHep3u1lCZJZYgE9G5vsfJIFwvuoqtobXGyUYbkwy?=
 =?us-ascii?Q?jllg/XMruDzXHwiZTe9yM8bjeDX3qpNoPNpqy2Kx+yBKOQINsNOuhyR+4NSH?=
 =?us-ascii?Q?LfXeZLFnixZeRw3TkaBX7RNSLA35RX3JFtcEf84ZNWDlqOAGbUrSRbVrgO24?=
 =?us-ascii?Q?4aVE8vSyOyVbUN5oa6acMYgX9oJ8N8uDX8RDqOhpuNpl7vxrqkvcg5QL7m95?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB8777.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5bb474-1524-47de-4ccd-08dd912719f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 07:32:08.1595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ggp84Xu36jQSNlIzTVHuqbPaiyMlz06PLAfihjTqIzxnOy39KWdNDKM4XlcsJ7NZ/hSTiaIZi/1aFZiUZT4m0ZFK2oG4bDZQ/JDEmVYcVHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE441933A2
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

> -----Original Message-----
> From: Nicolas Chautru <nicolas.chautru@intel.com>
> Sent: Thursday 1 May 2025 23:11
> To: dev@dpdk.org; maxime.coquelin@redhat.com
> Cc: hemant.agrawal@nxp.com; Vargas, Hernan <hernan.vargas@intel.com>;
> Chautru, Nicolas <nicolas.chautru@intel.com>
> Subject: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
>=20
> This change addresses the CID 457446:  Null pointer dereferences
> (REVERSE_INULL). Not expected to happen in practice, but the
> config may be potentially undefined through API.
>=20
> Coverity issue: 457446
> Fixes: 61aa25b96e14 ("bbdev: add trace points")
>=20
> Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
Acked-by: Kirill Rybalchenko <kirill.rybalchenko@intel.com>

> ---
>  lib/bbdev/rte_bbdev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
> index f341e6f3b9..56f313ee64 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -440,10 +440,6 @@ int
>  rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
>  		const struct rte_bbdev_queue_conf *conf)
>  {
> -
> -	rte_bbdev_trace_queue_configure(dev_id, queue_id,
> rte_bbdev_op_type_str(conf->op_type),
> -			conf->priority);
> -
>  	int ret =3D 0;
>  	struct rte_bbdev_driver_info dev_info;
>  	struct rte_bbdev *dev =3D get_dev(dev_id);
> @@ -451,6 +447,11 @@ rte_bbdev_queue_configure(uint16_t dev_id,
> uint16_t queue_id,
>  	struct rte_bbdev_queue_conf *stored_conf;
>  	const char *op_type_str;
>  	unsigned int max_priority;
> +
> +	rte_bbdev_trace_queue_configure(dev_id, queue_id,
> +			conf !=3D NULL ? rte_bbdev_op_type_str(conf-
> >op_type) : NULL,
> +			conf !=3D NULL ? conf->priority : 0);
> +
>  	VALID_DEV_OR_RET_ERR(dev, dev_id);
>=20
>  	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
> --
> 2.34.1

