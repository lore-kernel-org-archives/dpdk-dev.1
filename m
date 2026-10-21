Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FD606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A6Gb8kML
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3A07402BF;
	Wed, 21 Oct 2026 18:25:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1B0DB40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 18:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792599913; x=1824135913;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1N8vzFuS0PCjNPD08BdS+U8NdT1GN1BPGA8Jrmwaeg8=;
 b=A6Gb8kML0qerMD489ZyjUbkoo9/DGry/yitYuVbYLPyk+8EzKu5d+mtB
 TO6mJWs99SGeEAyS7WCi1wS1m4WNEiDRczR/6WUQlJJK1prBtAXR3hCI6
 biA1INlCQtszWCGV032JYIj/I4sPWs2Ic+dMVf/hOWOFPvl4Ta0CpGJFd
 YT2ok3J2OXjsc3xFEeGDRK6JPCdmVoOUFMaCD4WM7CRuFwD56Lwagn+Tw
 wVKbJeHXEFIf6MkZ7gsc8N/HaU2aTA5qKHJvJcSz53JJO66a0TflINXwn
 TluLnqC2jigKZHCUh5mYw+LvjY9uJg8GKWd2RTV3Oy4XYdpQj9r7m+5gm w==;
X-CSE-ConnectionGUID: xc3hExC+RPawx2Of0nLvfg==
X-CSE-MsgGUID: tX/fjPiiSQGp/9xlDY9uYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1364488"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1364488"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:25:12 -0700
X-CSE-ConnectionGUID: WU5/zKkjT2iFEmXMzbOK5w==
X-CSE-MsgGUID: QTicPSUqRbmh5e14iiMGuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4971844"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:25:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:25:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 09:25:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZd/LOswtJE4iJuKznjku7wKyYBeDGlG2viiJe9WXeT+F34iOUq+xKfh+nbe6ERBTaQEY6MybTGPmFoJDAjlWRHmRDNhGEGpsMiAAH3xpruuNhGU4s4TX6tFJYvORt8X70bkf6N9ZQI8NeDzJIUh33QU4IPNaHB+EGBMeEac3YtMXboWLSFt3hjkLo+i/eP6e7ssevojHqVw6/WpAoZRp4Pt2vHH0qEaruCMtuymKtNa9rLOSf050aKhkdfGJJHnpnLZL8Dcjv7AjhqoeZ9iCGCIMMQJYge4XRYQZ3nzWrKQFrOwISs3qGW66Von31EusFFTT13oVRBTlA4ZDOJ+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh6nZxs8xGEpePAZnGfI09q9d93oMh6NyMDrqslruJc=;
 b=FwFHBUNNMwqEi4Kaqty1slS2O9UB01PQjXPXsjKxqtYqhmiA/Ve2KMU7PflKLVc5rnmI6axO0Q3ZD9YQGooXylTILtI7cZyy8vC2dApw0Xp3IG+bVATNer+wiCh6EZhAS/nD4hHfDmzWr8LK0CqpdY8/ZpQDULD0odRqwgZ7uiAboNBblyDAQAFdnKVxGvZsU2Qdsa3BHNtzjWYIbldqeW+qKF9Ags11Gn9zAIIi48YkzSqo0GeMKkIw/QLZtfH3ofSsm18iUfzL6+O18ipmVgV97SxUF+YZXNSdqW+7MqQc0icF3k0i+jzobYPIjITlxTdMr41C2giT8xK8jtTLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPF7D18F34A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:25:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 16:25:05 +0000
Date: Wed, 21 Oct 2026 17:25:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 3/3] net/ice: rename RSS flow configuration variables
Message-ID: <atjnXKN71d3D8uHA@bricha3-mobl1.ger.corp.intel.com>
References: <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
 <09882fdcca7a467876582e530e4ec7c20b93466e.1792579964.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09882fdcca7a467876582e530e4ec7c20b93466e.1792579964.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0329.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::34) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPF7D18F34A1:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0001a8-5164-4574-f586-08df2f8fdd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +AFIRVcX8VuWYbs/S5lSGJt4JJKFF26Az0DMPw20w6ACDylwoD4mGY5g07qNJLWlDqCiZo5Ak7dWdmq8DSI4N9mSa/yc02ONBvM4xGd7hcALE0LPbpyAZeKOIPdbktvvJ+BdHHjRlmqJzl/eDhjsuI0nVv171iuk4rX/Ov9qlVUSqCvM+xVgyCiVmiDrQ2OzPCDlKO2DN33fyPQ9WSgnFgolUGTRTRB88mxVDbBs94o1HLe8eRCIy7IgGWpbqxyNFlLZbxtXCLhLQQ0xs+F9vANGPOg2Q01OzMUOdka+reh6Rqi/HUM5xG2wdMcHwTbHHQdRsaF4raaXOfo45j8kxkxLYEFet5h3Oa/hd9+FctaXbaDN6qCi47fcsaTJpVBx8qxHLGEiN5/NXw0YYmINyWU/i99wZP/u2R4jl/IKCesHO1Z8PyOZs3ZpOHd5rSCz6G7UnjJMLItuMWaogEHeAJDEMJQMzVA2AbZrzxviNajhJvG89dvUDYxcGIc/pCZlEHaKFkwyAKBYoGoaWzXqsfi2fpZTUzaJU3E5bJ4De+y6BudZesEiuZ1xP3V//bUy1WSrTSPgXHIJuFmF6HsmE4jg10b6amfHSUQUTsRBqqud390ybJ0HbM5F/lVio2sKTkRXzT/ak4xVsYidC2x5Vd/RqYKZPwoN9EUzp2Y+oEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8COChX/f6qVQpffKaaWYkDCofx979PG3zFouKJ4JOwsA3wC44dZZFSXYpYk?=
 =?us-ascii?Q?29ufSrJ3Fqy58E4NtUVCFH9qtDv1IZeSL04dkTFBQoRxbsLCeObL3j46lbwz?=
 =?us-ascii?Q?1iP97vPpoj0KVGqNcFWvs9+VtaSPO1dsMV39PsLRwGLWLCIGxcCQHu9qxzNp?=
 =?us-ascii?Q?7l0gZnQEAjtPCU7C7FBT8jWUWRd1Rn9opsJM2LYRJoSXYDX0SMGfnvIEMMuB?=
 =?us-ascii?Q?Q3vKegA6jhe7D3dTzvNJca2C7fdXYExrM8aOz/X8v2HC4nPuXHBvnKTltPOs?=
 =?us-ascii?Q?W0G8mCs7osI+Ti52zy4XapcwJGrpjojRcta/kdpWrelsu7hiOrhDSgwWoSEZ?=
 =?us-ascii?Q?7rJoczlEA7wJxiDvCrtG2q3Wu/Q0q92srhJ0uMUq17xtmYgZ7EhldCFHjPbb?=
 =?us-ascii?Q?t6FbURgWdFE0+ield0zDX/f5ZAL/n00HT71MSC1AiHTEu4l1QFf5wTqTyefO?=
 =?us-ascii?Q?zZx9N21A6m4ZIajjzABIsp16MPOlR87qy7PvugJVTt2gmUQV4whBRMqno2wU?=
 =?us-ascii?Q?itNyMh//rsnGZZ1Inph3384GPv8q2E55wPM8u+PAxSsdLH04I7juf62bfdpj?=
 =?us-ascii?Q?Fke9r4ZO/puxWiFI5SOew2vPo/P1noPlUmjC07SU4ZKJ6YD8GFKVR6UPUW8l?=
 =?us-ascii?Q?OWX4+OCJZr4AF7q/DzEtRz4snexV9x4WBhYgmB2+LFunfZ58PZnlTRE7e257?=
 =?us-ascii?Q?XUVdJgzIsqkFdubNCaek0s/S5Gdoe6MzLCBLF11CCJxS7bJHst9wBq8vJCZ0?=
 =?us-ascii?Q?ISnnnIyGN2Y37In1G/g+HFKC8qKiZU154kRf6iV5zKb05MiiUcNgUeS4py5d?=
 =?us-ascii?Q?KXrgmD/avP12vPNfQfE1z11FS/cYnZV4dySC6RqHM9tJL6IMFCHNJxoj4EG6?=
 =?us-ascii?Q?jfaR0Q40PAvQ7vHmkJeulOtVLV7o8KqSUd55w56/2a1LnkfobVTzoLzBTE2D?=
 =?us-ascii?Q?FOJGurg8JhmiplQ931yXV72nT100Y35BGqa9zIqQLy0UiHd3ov/1KHgA8wa7?=
 =?us-ascii?Q?q60PJh9wH2y/dh5A7tooX2MseudyFa1VISfIqbhsg6ATCatMKSV5CyUL7eVD?=
 =?us-ascii?Q?edDoOoq/zgWiO9i/NeyNdceaVqo41XvMEByWQFVFCnETxHzBTPaOO2mADWv2?=
 =?us-ascii?Q?WaEWb2bsZg7kJEvzgT71xDqsUAUVEu5yf3pnlLN0Dhdvn7BTGEXmKiEntpDu?=
 =?us-ascii?Q?JoN5dOMyESO0B2dZZ2duI0ohrFhpsQJcHoFJb4Q+/iipakwsPzxywsjGoj7f?=
 =?us-ascii?Q?RdasLpwRGviSGZ8lpFC6Md+Q4fnUnRHEGxsSF3f4yN2DtEAXEvpA2kqiWj1t?=
 =?us-ascii?Q?+/fya28O/RPNb6lp55wcFDcZz3eV8IWSrSl2EIjnPdPG8lOXeL+uKHuyxhsl?=
 =?us-ascii?Q?DMzMGBZDsrfK67Shje/1W+H+L4uHb7oWvrlpqvCvb408G1XStpaxBTycoxKF?=
 =?us-ascii?Q?r11j80D5hJE9sdxnVW2KPP4pkC2JkXGVQOQhANbVvbPbTX27OwLeB6BNKbJ5?=
 =?us-ascii?Q?n/wYNJXJ6ZUOnD8GvcAblVObKjCAfYIqQcBl+5AoxzuQ+XUXBcFNHkcfePv3?=
 =?us-ascii?Q?KcKy5pGQolbR1BJ4LVrX46RTTYW8PwNvkDa5dal+JOflB5Mkgk92eXCbQmHp?=
 =?us-ascii?Q?jt9yaRrrt5ZGb5ujPBXce8d0ZasQWdmEc5sQj+pdDJpGXjqsb+vbkwPq1oEE?=
 =?us-ascii?Q?F482t49HDTa7edtjPmR6F1spHoyEvNYphh/8w19i6S/q5vEYt5TRnwVyjTV9?=
 =?us-ascii?Q?TZc1QD2UEUr+WKPOuEGewtYBxqLv+T0=3D?=
X-Exchange-RoutingPolicyChecked: zegjeVL07rgYxx8aNkrqIGrfkZKsdDGk2uhZ5FseSzwr6jDalzkBKv9/2trLBqh6HVI4ikG3b3nvLXN0y7qUgFCF1+oyjNvjHQUM6hggQpYzJyARz63f+ouIvCWy6euACSG2bRqUoXi2Lt8EP9+OeFOPoaL+uy82JXL9eKEEqIuuWWkIsKAJOd5ixkYGeureOhOwNRhWWBX252hWVvhFhNlXMl89GiPGUGbbPxAOvYeApfgLMsXKrpxz0kvw0YS7/IwJRi6OyOSS7by20eoMUv0t35++jh32LwzifmLc7pgmhWVIpXSu1bd7qePGecfHo3dBMV1io1Y8ufeV0XWUMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0001a8-5164-4574-f586-08df2f8fdd82
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:25:05.4450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkzzC9y+GCXPggVkjglksRMvNZ/zecn9eaRwSXW3eYaBD/l0KyvKLHkHLQ1/RvTo65ab/S0iXBb4nxMtdPALEZhJs4TEfaxO+brPd6QQJSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D18F34A1
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:52:50AM +0100, Anatoly Burakov wrote:
> RSS parsing now constructs the final flow configuration rather than
> temporary metadata, but its variable names still describe metadata.
> 
> Rename `meta`, `rss_meta`, and `rss_meta_ptr` to `rss_conf` in the RSS
> flow parsing functions.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
