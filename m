Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0CAC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 07:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9596B4029B;
	Wed, 16 Sep 2026 09:44:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A13E840265
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789544689; x=1821080689;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BDa9KN5K88ddVQ1r5fCfHimX8JZGcVANkjFkcux0aso=;
 b=KfcyL0MaORZaoGEmOE4CyAXw/zkQTJMPVN9aY5XkZU3MfF+UaLGTBJiE
 YDMbEfD2B78b0CemnCccp0NT6CPA9tIhPdSbjUKlqHYMrVorpgIr95Jbi
 NkGGfMyRWeQRV23EDWnoOPuWKPwcAkmc8F0QunvVTrAJzgy8Bk27NN3+w
 n5FuAN4XAuiNFEZAC2oCWA8PBl+hiAOtvvUiZthIDKhsGvFZlGRf0BaQH
 bePzZ8H68PbEXe37IM5yPWm+0XUaotn71z+g2i7kW8bddOc+myDIoLZGO
 0F2cVOylJ6pGUTitBEx3OQ4p0IdPhfSXSBzaWtoMHq0TcrVO8abwNSGaV g==;
X-CSE-ConnectionGUID: YarQruKxRo+mmg8V+rEL9w==
X-CSE-MsgGUID: hWIoCgguQq6iDXAC5Yd9hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89855981"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89855981"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 00:44:48 -0700
X-CSE-ConnectionGUID: HQyrxd3UTWOFYQj9cOjHZQ==
X-CSE-MsgGUID: tkfvlhDTSjqhuGh6JD0iHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277007438"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 00:44:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 00:44:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 00:44:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 00:44:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB/2TEQOsALoJSPY5/M3vgT2/FYRNHYavJzAG9VR3wA+1UI/upbqdARCXN5qWGZDy9Sy1sIIT/UrI0tqQKQAbJ1Dj1F/VmZ1Rrgj8vqbPg3pu1HOcYkM9N5Rb0o8hegG9nibCU7L9PeQOl7T58NIrnC8Sli9Qz4O3n7qRR+NQv5aj2LzrnIyBL31ZkRrcEjMnNZ/HHk9XSZSEgExkEQg9Z1kYqWmC1jHOmi1hmiU0g6FUYqRYQCgfFZymVtnSsdGbSPw5RocIg8scAWfArJWughcQ3ENbDgVeMkEYIrcq4RivkAWJIsOuAbbnKY/Zdztkk64+NFZTVCH6RnSVjUvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HKRJpht8fpjxv52lchN7JHihf5CyoOFTgFEobPVTcg=;
 b=zECZqx6reePiacWHOMT6Xfbo+HdqP8+rZI6Ucs+A8roToZ8vJY/0CBG9AG7PMmqhfVy9s5GfpoE70pIQ1JDu2thmjD/AUhJB/Y6F5DWuZArt827rL+7j2zA49TPtOk3wa3rJLAL/XaaeTBV3o+rYPTLw6FYZuLPVeGe6Zvd3jE/9UViWwthqbWiUefP9Dyh27rlLepMq80rCl29OOJQexJ4Lj97rMNLeY14woyznWO5mnL6EDhQFrRTngBRK8u+KJfF2LHEIP2emWNB0JzcJlgeAyZqar+Me4lzEQVdQYj8WIQXRqKLKsZINbNyf2WEX/7znoSfpR3ELaR2x0HAEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB6788.namprd11.prod.outlook.com (2603:10b6:303:208::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 07:44:33 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 07:44:33 +0000
Date: Wed, 16 Sep 2026 08:44:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Mattias =?iso-8859-1?Q?R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH 15/18] random: remove RDSEED fallback for initial seed
Message-ID: <aqpI3A7IYlTxc0VW@bricha3-mobl1.ger.corp.intel.com>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20260915192207.3926217-16-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915192207.3926217-16-stephen@networkplumber.org>
X-ClientProxiedBy: DU2P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 741b13c5-2724-4adb-b16c-08df13c658d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|3023799007|56012099006|11063799006|4143699003|5023799004|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: tNVmO1p7rVqt2jbNKVqpOk+e28A6qHJ9dpFNwBW3Sq1dPHSoAjLINt3j1lyHT4hJNSUGKmBT/pqxinqe3tlCx2or2AJMLxG57WXCEXxMxzpkTEghPH03AMoxPc80siaZBREAzrAMUuiBCqSE17oPkWxGrGJbdVXOmrvBIYuVNzMz91NzECCS4OEApea90X9X3Z2F42WNhxXNk13tnbuBNEUxJWyUpIBTFHphF1pdot2hOFysVFPR+4zfOSHyCxzyD7Gl/rPerTUMnkJ+ioyoLvjERbaKHD8Npc0IBQRxmy5VzSOzhq/1Q4Y69mzXYfeER2h653qywEF3GcuOSiUTAwK0xrUrBaiVJ4tUXF+aYS+kdzyS6cUUENA3tiJrxpL4GMWBD5G8gXf6NSLG+WHSYSOnTAqYW8n5tTu1CgG3GJrouBHgYqqWmJ24+m2NQd1RPgByQjVnwWCFoUr6v1hCqzUTAOC4/nr76P+wjiPmCpJV9gqVn4JzCauddwGDX7Uwe6zsG/DDO44dxsjwbEerBxl395ro/3D8aVwl2Q0oaRrCPuBXF6wpOAqovkSfYug7MyIY9xUEOQw7lfE5TWeIfEVX2KOJHa1AwTvRPtFF3YPrUBV21hM3Wx3+tLIumk9TWBNm0vt/EjwymEz+AQIS6u+vYjVv1nYho1fPfFazGvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(56012099006)(11063799006)(4143699003)(5023799004)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?af+ukVIcl8uxnt9w8R8f+uLZgW29fd5YU5Y9WBsH0I3yIX4rddlrMyxULQ6t?=
 =?us-ascii?Q?izkfniNWKCBO9uFiIGdbzrW0bPm8Y439yxIV/KW6VVLOxnDaAymIJ4rWvsoV?=
 =?us-ascii?Q?I0cjIGvyERu5M/PKtDB0gTcPr/vFmzgM6tHUagKusYuydEqMKTlgIf6dh1m7?=
 =?us-ascii?Q?KMmRN6rIhSjedowU8IOs+EqBNdYbT2lWn1Oj0ZcCkbLYI390C1gsTkj253sj?=
 =?us-ascii?Q?b4o7KifCYC6KqB4o/6yPV51Ygi+CitDlePA5TQOfxbUwztwTo6CwNiZ4hcR/?=
 =?us-ascii?Q?dDV7qrMcRZN51GRJhW4Lbo3RRH8mZbEY65NRNhes2Ylqs1Z0NFkZzmjlcjtr?=
 =?us-ascii?Q?1UlpUNrCOdizJCa2Y/B8DKS1cJD6zw6qIZTxlwRzym8M5T10L9ujI6PtbDo3?=
 =?us-ascii?Q?rekOKeJZ84eUUTxuDEjqn2QyzQLjqEJjdqWiR/TfTIe+RCULgaDJLgXGMpLD?=
 =?us-ascii?Q?+TXbhikQSTkrBvkP4k16WpFuQWQuqsKi/Q/cG9T28JparQvVeFBc4cKr9fbL?=
 =?us-ascii?Q?Y6CieGydoDpLAkqB35h3N8n5STBJ5Rl+yteDrueNC8P9RmXBJubJ4ViXlTTW?=
 =?us-ascii?Q?DzcIlkvZlHsXKjNyRDTf5q3k3LA/ooF6lr9jA3QAsSGaAVKJeudoHyDx43bx?=
 =?us-ascii?Q?K6Zte7R+fxQ/YmBWoz241ENHwLu31IGH3Hlz+LiSlrx+Gx+6po+kEFYg958l?=
 =?us-ascii?Q?+dh9zzh4oNKAeHg72K1W17EbkGTtu6UGA3CvX7WlZaQhnWbuCk949ZvCj6yL?=
 =?us-ascii?Q?5XUpGdVNKkTrrncpRg9iRj/s2avMFB73gcEwwaowY6KW0GNYE+KEXYU3t9ac?=
 =?us-ascii?Q?vLT9k9zM9NiL9s6FewD8hgLfHoh4vsQJILlOEsQjKYgoWxKYhVtUUM/NASum?=
 =?us-ascii?Q?J0CM7T3eR6RF0rYjLo63ZsJWGm39BbVsTaz7NvsoUit4zWkQhDBY+DexnrZn?=
 =?us-ascii?Q?uboWjvYnb0Dgq2RNxS2ChJHpva4hKfAc0hrxVeT2oYRX06Wfw2Vd2EHCoeB5?=
 =?us-ascii?Q?ic3rjRT/NJnNcMlfiuXsWJ6newpgteQw2LURiqQ393nFaksNSDXEJQJW13/2?=
 =?us-ascii?Q?j1WuD4MTBELx62Byvl4PsKH5mo5/OzL+z3DgDr4eLl3Wqm0ZKlD9EW6c2j/f?=
 =?us-ascii?Q?JFutkt6fVQtLCoYCC4Y7jLKwPIs2lzA0Tb6eFeMLVzclXRqVt+N5ykk61bBR?=
 =?us-ascii?Q?x5XYPBACHRPtSVD9k0/irm1XF46Uh1o4T6lGaVigja7w6Yo3nVI/QCaLnd/l?=
 =?us-ascii?Q?2gcR0Yg/Tw5A85+HwtYWpXV0y+q4gHHKly3yGmpzQXo7ItzvOBNiffRGC0My?=
 =?us-ascii?Q?7qtDKiH1lC8nLJ3JbAKOfHdm2gUF2N0eQXI+VRl/oEo7HzWmrUY5iCjcXDiZ?=
 =?us-ascii?Q?iLgeQ1VsDQFZGm04reOLLoQRIYiYaVL3EDcBOSAH6XgALdmOsv1Q2YhzRlH0?=
 =?us-ascii?Q?gAOHMaDQmwjV7lABAd7tbGZid3KCAZ8r5xk6HFoDTxI3aht40C1Y3nAYakux?=
 =?us-ascii?Q?fFlj6/yDZQEV/i2glJqDqRPjKhcS78NlOS6O1izd85Uv7evdq0WD0XkOYPOE?=
 =?us-ascii?Q?BHoBX85PYmf6IGiePIiEylREWGfsb4fAb/6K+76hGSZwTpeuy2/t66USSF0P?=
 =?us-ascii?Q?bd15l8kkt0uVF2cXFp/LEs7cZDfWT2FHF187dzivx7Mpw4neKvvoFiNjAmOc?=
 =?us-ascii?Q?eecsDIMv6dZvFAgA2/erusZLHtppLWksK5EPXsvf2dZ/I7R7t+oip5Zt63rX?=
 =?us-ascii?Q?q/Ynmb2XENQCUyTSYoh7EMgPtCdlxZs=3D?=
X-Exchange-RoutingPolicyChecked: T1Gsi99OGl2RVbXbz0bgHe8iEIR5IbMwYxcw7zFV71BBwqbRbmlvRKNaJeqKZcQxIjoLaFisU1qhMnSHoK1AcqnTmDDXYkv3zDJh50VEDPmXFoRL7oJ0RDznL0IeAjBGa0yXvVT+CjVvLKa3A7sbDkaygwoNspHGVa7p5a7m9N3rz/pUuLDaIQ0XoKU+sogbwmmLUg1coAWz6SYq6v3ZN/oVZPl3QMh6oB2+qS9w6TlNFYqGBY3feABovfi7CcM1Jgfvt7jFyGdrSnJdhKV4XZDddkMrR3dDz41Hb2HCwJG6YwtPGEiJ1trGFG8mXCTLUHaxuN68yzO4XDzeo9PXJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b13c5-2724-4adb-b16c-08df13c658d2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:44:32.8640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl1Gs0Ghh2Kqa7dEAsS1EcYHoVwHu7i2ZJRl7OXdGU6/hOSnU9s0S8olgAUOVuYG6tmtZ0f6M0kht40GPhx3LDDmHaI+6jY5S6y/OFQtBGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6788
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

On Tue, Sep 15, 2026 at 12:21:13PM -0700, Stephen Hemminger wrote:
> RDSEED is an x86 instruction that returns random bits from a hardware
> source. It has well known reliability problems: it can fail
> persistently when many cores use it at once, and several processors
> have errata affecting it. Since commit bfb3c5b9ffe7 ("random: always
> use getentropy") it was only reachable if getentropy() failed, which
> does not happen in practice.
> 
> Nothing is lost by removing it. The kernel already mixes RDSEED into
> its own entropy pool as one of several sources, so what it provides is
> present in the getentropy() result anyway, combined with other sources
> rather than trusted on its own.
> 
> The remaining fallback, the timestamp counter, still logs an error so
> that a low entropy seed is reported.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
