Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADCD339A2
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 18:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF964025F;
	Fri,  5 Dec 2025 19:19:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5D34B40156;
 Fri,  5 Dec 2025 19:19:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764958769; x=1796494769;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vQX1v4ScqFYZyCKR+lGzs44bfwGZMDQEM2p3Lz1KaYI=;
 b=YNduNYb+7GR9eIiENzDvSuFTLQL0cdHqJHy9rsLvgMwkhz6WcgfE0YBY
 gFWGKoyZousMRaPaMmAMaM3XItpdfrAZxm4IFarsBiF7Ful8qZBaiy2+x
 YDZXLPQSAzoxsYfljyCMYuYw+r6aYbbCa3+UVa1WWYx/f/q0ELZyBYrMA
 Y6nKk708LXO76r68uyPvIh40CNma+oHmcnBb64W3MvD4niZPqBx0Wsuec
 I1zjNvcIu0Kf0uGlWuhDAGWjjKSsWwI4vEhBH/3ddmsw+6QQxHqGFQf3w
 oTDxFA+GKzy1nCtn+kqAFul+CyeiUYSzdb89e8UJ+WI+OfKs8WNM5NaGt g==;
X-CSE-ConnectionGUID: h7vPxCgoROusO6HqZlAbqw==
X-CSE-MsgGUID: vsQc3vwyQXWvsCqtEZjSHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70615964"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="70615964"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 10:19:27 -0800
X-CSE-ConnectionGUID: WmqGq2xKS7WunHxD1YqNQA==
X-CSE-MsgGUID: MQYZUigERtuZvG5OZjC/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="194421369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 10:19:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 10:19:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 10:19:26 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 10:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTdQxI3SbKHy9HWZsmm+K+UN/0We04bnfNog4qsFTTNtHogOlJcvTyH6e+EjxBVu7mQp5RpxjI2AhdBeHc8WodqvAbHhLYtJCt6V0U20RFc4JOcjF4dwX0pnlHshWPmnF5n2r4C3pNTb0glr4+RDQ8WpLR7iYCsE8iC1FJomGVBOAr5UNM3j2qsDzbzyTjA9uCgukskyyOahwxkNnerePr6hDz30LwSWHMDDpChq3R2bZWnIuItzgIUvhvk8NVSE9d74ZRy2TLB025BzN00Z96cDbITITP3figz/LbGN19og2JwFAuEoTWKeubfSH/85l+kyO44CZvAxTNPUTsdGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBb7bU+LFQNdJl9dL+qt/CHHAJYBW0uAsIe6EQD1rZk=;
 b=ucI1WXncD8o5RhtdG1GR+dDpd7su7B5OaGSFpquMCk8Xs0+HOabjv0hqo6Vsow6EEmpsdIX7nD2JTl0wZGSdi946JwIQ+goshyF6luybw8dvi2QEVpBhtbN8bBcJa22vkSoccnul73opuIW3boIYPU3rVYJ064YmzRzJcnQFvld0c+DkddPkAjkqm4OnulVGKy+59dHYAVigrVXk5s8AxSFZpOYhv/US1mrFyv7VCCDZOqShjzAdMZeJU0RDFc52q+66zNr1Es9SnRDoUibt8yXMTpvPHDA5YL/2y3gDB1nnkMhN/zxsE98O9jM6aH09a8OOgOYjEORRp7/8w8KjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 18:19:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 18:19:16 +0000
Date: Fri, 5 Dec 2025 18:19:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC v2 02/14] test: avoid long hash names
Message-ID: <aTMiH601nyXUIIwJ@bricha3-mobl1.ger.corp.intel.com>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205022948.327743-3-stephen@networkplumber.org>
 <aTKX8x0W3mU6BsC-@bricha3-mobl1.ger.corp.intel.com>
 <20251205090003.5101a52b@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205090003.5101a52b@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0293.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 92878669-28a2-4d8a-08c7-08de342accbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w1DUywZi2/0Ao9qI3TJRJvfsWiQHz4J6updbh7sgqTZbqMbbHaOSsuS1Ihb2?=
 =?us-ascii?Q?bCN5rdaQaw46OrnCYmRpUqjvOieLZqBdFkVMS2suNl6t6lBCs7ddHhB8QZ9/?=
 =?us-ascii?Q?Yc1P6A5ZEGdIezs8taS97FVUte3VZXe4WL54PcFe7lqRI4GBCcv/Ni97k0FZ?=
 =?us-ascii?Q?WSIRNijXgPfVy2qEMp5cEiqWeMeq4p8V7UjwGMIt4HSA3ivQ21WRHnY17WOU?=
 =?us-ascii?Q?w8REsD/6XTo5AHxTIiDI0IQst4ak/GUELmK7F3JHZmWMcDGsu+zfTOZPgAJH?=
 =?us-ascii?Q?wN1k8YAjxtw+r0OMb3izqwweZf8GT0gZlUeHPhaubbRo/ZlxyoxLAN/20gQp?=
 =?us-ascii?Q?KiXSuRR7aw6vKcxNt+sOnjvyQKemkHx3b4j42YuiyOy1lIxDrRGuXEn9IfNI?=
 =?us-ascii?Q?a43qtNCInR4pAOYaJiw//abJVh8Df5vnSMpxPM75DIFARESJL5Z5NaSKHSyH?=
 =?us-ascii?Q?tn4oIgtHqRWpYZXQ9e8IDuH/H9wdCvWEAZ2vPcvSU/gZlel4PnGbhGT/T5p+?=
 =?us-ascii?Q?NkjAmpBd9YNn/nv++3G7BpQFbscK4kQuk/XFyCLnw23jVAjCel6Ic5C0LICw?=
 =?us-ascii?Q?WHC15inBQA/fVOuYgNt/rIT0bmyeBNjyszIn6QEEZYswGylimH4Neu3FMWDO?=
 =?us-ascii?Q?d7yO/hjHlKYqk5zx+GkUWNTmAxe/Sy4zfcYS5t4ua7sdWe7+Q0srtTkh2oOW?=
 =?us-ascii?Q?n0xjDswMQ1tFcQfhO7IMzO5imPrZ8Dou2AohG3rVmJXJxGIcPzJnJZh28J1d?=
 =?us-ascii?Q?vqwj0oSvmXq0SxDQJ1qDrEWoaYMKbSG1q2lCCYxWy2MqgD9V8QYyif90q02n?=
 =?us-ascii?Q?VTOhJ7JCWmxQqAq1LVW84giQ0rDGVfHKAFWrkEiM030E/CgtRFHZYZgP6gA1?=
 =?us-ascii?Q?F5zaFNbYKmec8YdwULiVlWGnilpdzloDEe4fqb+EL7VBKtBw8cn05BzdmX0F?=
 =?us-ascii?Q?NiwkGdXiT33sPEtqLcbnv2U4bdSRbT6m4g3FTUyIX/CJDZ5QlRHFWISQTcxm?=
 =?us-ascii?Q?9FHNC0BL0tXVAmXhOewgPjQso7licZ7SprdCt7pDA37w7cjvg54XICEFOn+c?=
 =?us-ascii?Q?gW/GgZJqmk4wKCcHpNC1KkJj02Mn9J2cKsJiUCVc3SGl91gNtxl+QSMW5BiI?=
 =?us-ascii?Q?G4ozgEr6PFOqxglM5tFzx4TRXfmH1A+30EobopFK/oCpgD2f0T1sfXQ8i8zm?=
 =?us-ascii?Q?MIqz8pEj3QIsxgNZQi4p8qXprqnikRYkXfpKHEyfMrNIImCIttPK//V+GqUf?=
 =?us-ascii?Q?bXAa6QbWxKm6Qm4JH7aWuv/n12W7LPF0IIe+eYEau00k+MLXFDIvslaVgJM0?=
 =?us-ascii?Q?AzSD0raOthEqObOss6i6UkscZ0R6WAsvOcZ149iZGIUeOQc/Za6HK0L6WIss?=
 =?us-ascii?Q?8bH2Vo7ojchviqofVVLlAONma5B3ZP4VNIo98JNCGq6sITsgOxto1vjwr9Uw?=
 =?us-ascii?Q?8ZEKSPNxSHH6OY53W8PPvh8aW6TPdE1C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xh0BbaEq5Rgox2jhMtOuhIAWmTCcFZNLyynq/RqFT4B7sJYfweVgk4AQY3z7?=
 =?us-ascii?Q?uGQQsthdEhL5Jt+Zj3kUujdJqyLk3ORKZdlddfCKzMJQXVuKspUj9wokEGO8?=
 =?us-ascii?Q?mnipe5s/1GUH2HKimpG/Z7ZRLFwS4HI21XPSykG/SnXia30LUijUKQXlpQXD?=
 =?us-ascii?Q?USFZyd+uXpXi2Ayb+yi7h6ruryHD5y0a5qq9QBVkYxNeTKPcXMZhulPG7HlW?=
 =?us-ascii?Q?CCA1XFC3mhUVPRMQnxzg2k3++MHWqY6aKe/gzJuPFbxGPI/fZvOnmZq/1Elr?=
 =?us-ascii?Q?i/by0yYiHEcdDETG1Iz3A9XMZvvHabsbqO3BnJFRmlGGW3xikuehFFWVfChJ?=
 =?us-ascii?Q?0t7m8BbXpRUooZnYUQmgLmb90Mbu6Uc7e2MK/1O95Lp6jZsHpsBnYivfzwA2?=
 =?us-ascii?Q?lrmRFYei1c61FvzMDTmh2xjE7mhcnOyoViIiKC8bY6UWw0ETInEeBGmd7LVS?=
 =?us-ascii?Q?QqV8Pdj1HlDxOfZ0vIy4G+axgmMBWdiUgRSD8W2uHsHS6uZgntZQJewS7yTX?=
 =?us-ascii?Q?y8jojX+gnsZjVqC5W2IPW540PrF4k/ilOSzRsIb5mWUdbXJJ89La+azTbrIu?=
 =?us-ascii?Q?LuLasypJ9Fo3NkKwsUWfsCw6VZYa/0S+6ms21YQE0K/fa2G9a6DIrYVRb5ug?=
 =?us-ascii?Q?MxsT+xlBaCuKvNgr2N6W4W3eIay3fPhA3g2VDvIV2jVo3rrKmiT3mIcOJCXL?=
 =?us-ascii?Q?V9Hn3fjQzeMyJGi5q2uQkT9isN5zU7b7G1UmZqSzItACuYNu+lkUwLHZoaRM?=
 =?us-ascii?Q?j5iRGuM/2OkffuNQf2v5ad2sDEYTQMxthXwRMge8XQkYt6izP3q/Jo0mbO7+?=
 =?us-ascii?Q?p/UrFLEoAYLDERUYYiLKWW+lxHTaWAw/BIj+UY1KeL7bfb98wZSupdB/9gSv?=
 =?us-ascii?Q?tKkdTKydKfowW06z394cQyMv4/BwBqnw2O7G7Gp/y15oJksfvmYbW3LkZxHp?=
 =?us-ascii?Q?PCy35A6Unff3aqPFywFT6w/QYEr34kwvd63oE7P6So6Li0zhpei+5at4wZy+?=
 =?us-ascii?Q?GOMjOcLQtl4K0XGV6OPAlHPq/+h4s3c/Wf12otx0TiCGy8hkia44MdOdkCoP?=
 =?us-ascii?Q?LmN8WZV5FUsKCAAdw3jSr+5UQreZVDldFewu09RZxU73cQ+6W5dVbhS4Y/2o?=
 =?us-ascii?Q?SBjKFkcNaQMGIHyZbnNYn1bTY8u9mxHIpDtgCMWr+U8Of0aXTXHkljHXrYbT?=
 =?us-ascii?Q?72XHgWqyj0fT7YlnuZQ17OlhuevOQCRQYv/b+QBo0xVgLdW6HqwdcnVgQzx9?=
 =?us-ascii?Q?JOqpyGXkBYewJ8jALGk7naNpRQ5DbUzIpMuOV67Ola/DMgdtpRf/8tieSEnq?=
 =?us-ascii?Q?/Yv5hI7FLypU06M2FuT9+fw0Kz6l2+mCSt2M5dub83JRZUIhtuR5pPWsF0AO?=
 =?us-ascii?Q?aeDYEvcjdpc6uWYlFfAZTS1vPIgBuzQL222s5sKDzFK7IQjEXms7VfAHAGPX?=
 =?us-ascii?Q?4kIbUBLbfII9fT9NIg8YU2kRzKlxOYRHSNtw7xA5w+YBhJDrkuBfdd3iFlRZ?=
 =?us-ascii?Q?BZ9GlVNiateRSFNvpRp+/6XbBJTbfbFTivdsi2WjdEVatQDH3C+ry0iwdWA/?=
 =?us-ascii?Q?TnoMOGhyZAnE2OLK+X/IaMqHQnrTiUo8MnHQvvNHC4YcrS6AREI6Jq7eL8FQ?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92878669-28a2-4d8a-08c7-08de342accbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:19:16.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNZc1CsIDKHkbW7N2mwFLnpUJR4eRv+NJnK/EUqgLgja55LQgIYQvm3j7EBHicKUN2zgR5nXi1NSrpGCsXMIwLApy5OIrAQK8NjjbnYhJ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
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

On Fri, Dec 05, 2025 at 09:00:03AM -0800, Stephen Hemminger wrote:
> On Fri, 5 Dec 2025 08:29:39 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Thu, Dec 04, 2025 at 06:28:11PM -0800, Stephen Hemminger wrote:
> > > The test was using hash table names which were too long and
> > > would break if the hash library was checking the parameters.
> > > 
> > > Fixes: af75078fece3 ("first public release")
> > > Fixes: 9c7d8eed1a45 ("test/hash: add RCU tests")
> > > Fixes: 567bb951716f ("hash: reclaim RCU defer queue")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  app/test/test_hash.c | 29 +++++++++++++++++++----------
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/app/test/test_hash.c b/app/test/test_hash.c
> > > index 5791fd7f4c..8cecc28d11 100644
> > > --- a/app/test/test_hash.c
> > > +++ b/app/test/test_hash.c
> > > @@ -1399,8 +1399,16 @@ static int test_hash_creation_with_bad_parameters(void)
> > >  		return -1;
> > >  	}
> > >  
> > > -	memcpy(&params, &ut_params, sizeof(params));
> > > -	params.name = "creation_with_bad_parameters_0";
> > > +	params = ut_params;
> > > +	params.name = "really_long_name_of_22";
> > > +	handle = rte_hash_create(&params);
> > > +	if (handle != NULL) {
> > > +		rte_hash_free(handle);
> > > +		printf("Impossible creating hash successfully with excessively long name\n");
> > > +		return -1;
> > > +	}
> > > +  
> > 
> > I'm not sure about this behaviour, for something like the hash name. I'd
> > tend more towards having the hash library just truncate the name rather
> > than returning an error if it was too long.
> > 
> > Also, I worry that this could break end-applications which were relying on
> > previous behaviour of ignoring long names.
> > 
> > What do you/others think?
> 
> Truncating the name could create issues where two hashes end up sharing a ring
> underneath.
> 
Yes, I realise that. However, we have been silently truncating for years
without reported issues, therefore I think it is safer to go from "silently
truncating" to "noisily truncating", rather than jumping straight to
"failing the API".
