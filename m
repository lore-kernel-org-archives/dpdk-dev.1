Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A0C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 09:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B7374064F;
	Fri, 14 Feb 2025 10:36:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id CD4144064A
 for <dev@dpdk.org>; Fri, 14 Feb 2025 10:36:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739525787; x=1771061787;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Cl1yqL1wd1x3fiF7UyjP5B98BeFJldd14lBKP+t7Ee8=;
 b=jbNe3h/7WyzTtB1s/kqNQ8xXqphimkJz7IbQXPC+EeS/uNYR1ZtJOowa
 chJU0HquCupPBPha1VvN+3HsXgnt40ktm4oZ6rdZGsY5s+YZSDlj28PCc
 m+j1tAfdsXl61UzC+l12bIE0NQ48NYd76wn7F1eWfGnIwldw4RAjl3aEc
 Ok/FIjemIjBxB5h++tp1oU/MkcCO6CBaUrR9yQ6nhWuE69jl3FbqxXXml
 YHm7UeuJfbUcWe3YfaRlMVRzL3hCo0A5ZJIeKN6YzFHr9NgPyHN7eECPn
 MW6dFYcXxkS4CyAf8UkRRI3gHHq8dd0eo+sMqhE5dYh9bhHmADyek24LX w==;
X-CSE-ConnectionGUID: U/gofxWyTIeYa8pcxP763A==
X-CSE-MsgGUID: tvcWJMfjS8GfPzxRZW/K6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39977775"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; d="scan'208";a="39977775"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2025 01:36:25 -0800
X-CSE-ConnectionGUID: Tsfjvr1US6+qEmIr3zdHJg==
X-CSE-MsgGUID: EDftzix8SoGbxGruzK1Pwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; d="scan'208";a="114054712"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Feb 2025 01:36:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 01:36:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 01:36:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 01:36:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpYm+6sKdb2bmddaQE/wQe25t/Ov9niL5pKJP/5Oj30I3HdiouhaZsoOlcpm3sxGhms51ANXVrYcxrL2Qo2Emp6f6m/hIhjTMUzdCiFVhRPaQ5me9NL2g4GeRX9gKrP97x+Ket9il83HivDBTKfgH6dEPVLgIEk4/KkOUv9z9ytnjTeCUromQrjTwgcpmQgo7sN2BFlPL9lnIOx3A9olot0X4K+NvW/0TnOlJAD910fWinYpHVZ2C/AAbemrNbfcNTAJwgxhKccmniLjgOAsJ0H/0/pzO5pBTksVIPicNrw30jTijAIKbTvmm7D6EjwsyYkhzjewN/R9ClXcXCkfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va/O4JRn26HMaGq1VjWbXET8JTGCSnCYvrlxAdL5jQM=;
 b=FSUOco2/KsJmqGaRbXo7olVXssINhZrGxpEImfbJhHd2lcvUYaLnR1ECGp0YV9DtS/wxHFm/twoSIYhzoutL6aRv9nXkzTuZf3nlQ6MJe4G69ZDfFViUyfmYbtPb51H5IT6E8zEyH+ueo9PIlo3xEF9pkXzIPjFTzlXMqPJwp5626R5TQaqnPpP/B+UXdmhORb+MH/T8UX2g3SdT4BqYidjn/8jFSG9D7Vmi9p/FVcJlHZAEgXXpfW/5ymGfUFB60YiApA/IJOOXdb+qV0WysaxFlT0uc6i/EU3s3uI9E4RrLkkhF9nJPn+6AWKij78mwxXXGZ/EYsd+6H90Ed+Nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 09:36:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 09:36:21 +0000
Date: Fri, 14 Feb 2025 09:36:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 0/7] latencystats: cleanup
Message-ID: <Z68OkDkG8rEpNYgq@bricha3-mobl1.ger.corp.intel.com>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
X-ClientProxiedBy: DB8PR06CA0024.eurprd06.prod.outlook.com
 (2603:10a6:10:100::37) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 659c550c-7e35-470c-5942-08dd4cdb0a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loNJJGth3Hg0O6H21QSI8WqQpLdLsWzz2VBoFKRHYFjJ/DfKV1+PI36ejajK?=
 =?us-ascii?Q?KlhsDWkUpQ7pju9/arVD6VuPurghnsLc0Dczu7QjBLhAVYP2suNJIV3Jemgd?=
 =?us-ascii?Q?AELlUgULgGysPGCeI9B/aGQxu+wV/cYt8BDBawTNFC3zBnMgDUu4R3TDDqo6?=
 =?us-ascii?Q?rlYl/N0K6V11Wex/psn6P6Y53Pa73UcYdoCcG5AAjoJVXyuEwOoYxg8QgezE?=
 =?us-ascii?Q?wjPJPRrlnJf8cbB5wKfj/hWO8J7iP7ZZg5Nw7Xij38R6/X9JDTCC2qp9is2/?=
 =?us-ascii?Q?EYULVztMlqbmK5HHSyXfJF7BQO9x970+RD19Mny0k7M0RMGBqmsuOocxBugb?=
 =?us-ascii?Q?HVI1JQqEd1Ab4HFUemHbrgpCS6/Sy+46R3rQoV1aiVwlrr+qY4pWXYL86rff?=
 =?us-ascii?Q?Zp9CZAjn80AOv/x9C+Kwl80a5TtO9D5rUzt0t1JXQ7a2tYf5UiJKUnyOGPy+?=
 =?us-ascii?Q?PXIdi9vJ/Lm2O26XvOmyFsshI7mSAdlGwp6rMQqTjYsIEu90scw3OrHn48yH?=
 =?us-ascii?Q?2Vvdt9p5Y6PvbM4A5jd68C2M+hfu3P6qgwJtS/YvRC7ZqOJlOgFmjfzvET9y?=
 =?us-ascii?Q?oLHjANdE/AonZN+y0jW4Lvv/HxRIvj1wPo3Pms1/dzf+/eGcC1M5CUgwoa8F?=
 =?us-ascii?Q?UjBoLrjD5Aw5uEW7AO+V+OyDJdX/PPh70YlSsOfOPNyj9zU6EuvxG/kkopJf?=
 =?us-ascii?Q?ObKijM0YdbnTISWurdCF7FSSAZekbGaUgWvY+09RBCGQMjzpUW6C4j6zwm1O?=
 =?us-ascii?Q?Zssyix/trXkVKm+TdSjIuAVGKGjcSS8E+gQSYMhGH0XG3OT7SNK+4p3b7WVU?=
 =?us-ascii?Q?LuGK8v8e3W1vg+b66ieL+2Rw5FC6Z131lmpW2ZdYW4DaCAqzAD/6+bcnDtO2?=
 =?us-ascii?Q?29/qJJT5qCooJ68BwUDh416Ln6D5e+i9kPddtdY6kmM3TO1PitW5rsjqDbyG?=
 =?us-ascii?Q?vww0Qowx2ZpQtG5CeR+QIImXHYXOEZvL88Byr9yd0zeqrAB4ZbGfDwUtocFo?=
 =?us-ascii?Q?iHC/XQdZxLFHGW3AtYPvYsVRslAX8EWJ+CBtExxEW3e3oc0mvR6B7o/H71WQ?=
 =?us-ascii?Q?CPyCKXDptawO20vyin19WomvI0VYGeHPt4HoQLrDuSdIVUeo23+NNY0modna?=
 =?us-ascii?Q?e8pfWrB/nfn+2PfszJg+JofA8xCz0WnIdejA61rtVKHhujI9qVOPkr7ZQvO/?=
 =?us-ascii?Q?t9PVS7pr5uocKUw9OzoYcYiZA/UxV48hVDaiFGXm/jqA2tPByV0Xi+gQInMA?=
 =?us-ascii?Q?pd+hG07sZzuZJhU7/ev1j+rPMJKGEFBtoX7jFM3NGZQ/5eZAY/RwlEqIBuK3?=
 =?us-ascii?Q?PIqVDBCZBosnNXr3qLE9nHl7c8omsoDyJg5VzhQeRdpS1XEE0oPBOmYY1mR0?=
 =?us-ascii?Q?P+UTLrMkMWC3Plx6LXdNo9FdHajp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08YOsvzYUngN8Kr91Y3yz1xxpCcwmWOqxReLYbokefhJd42VUujF8bthF29u?=
 =?us-ascii?Q?r0Sb8Ewt1eqYY8Y3SeZMXy4u5L91aeqf5SEim26wUhO2+psU2B3Yr/vZtmhW?=
 =?us-ascii?Q?nN43Yz2o92fZ9W6Y5UK81OZ8XdeP62l6gPXCwx/HRjBSuAwR1+Jep3oDAYSH?=
 =?us-ascii?Q?jDAwoyx1O4aeB3kRj6XMrERLxzBqQ/gJZn6iEUZW1OhUlQjSo7JVpCR2QDbv?=
 =?us-ascii?Q?hyoTWv6aXYiNJhipIqzh7F1j39/u71cz6WNF/NdK0p/A1Ey8DKYUUp3RxGlA?=
 =?us-ascii?Q?z+NEOPlLUXmFS9K1HNfdc0oGTyA45THpIHxgBGB1qVnOQabJLiigHQD4oia+?=
 =?us-ascii?Q?tzxLAFGDA8pUwYXGwRVNMUqAv5zxcpJtGSfU5LibC5CFypNXY7sTAkM1QRqh?=
 =?us-ascii?Q?LXsiprDS1rUxc/svwgRU75JncBhRZd5ah9yCQD71FXzi3ZtHrMXITgqCPM7e?=
 =?us-ascii?Q?kfP7ni4unMii0J89U49UH+rN++JoNg/6NzGBLTMXtfKkn8ElQBTgcbdhQ61L?=
 =?us-ascii?Q?jzzUv+G2hZ8FYM696zpNGup91r3r8K9shgrNsPjkR83zEocDThLuKkMudSPV?=
 =?us-ascii?Q?y0mg/uDzxM1QhApvppiuoyE4f9px/3hA8IrmFJddCk58DiEy29g4WmnsFxfM?=
 =?us-ascii?Q?+s/RXTgL9Jv+A1xqrpYVd3vGZ5uG6/hGt8GGrV7vflK+KFQMKydfTjZhIV8a?=
 =?us-ascii?Q?XB548KhjKZsFf3jhsSh2Lq3/3YamhZxPK4GsuhrXq6iOn4s+qSlQPi7D3Jzp?=
 =?us-ascii?Q?Nhjo/ZqRRV//eg96Xa4kzvfTd7SSGuaDjgOyUacBWZaunqIr+7PsM8SiI5S4?=
 =?us-ascii?Q?iHOO8k8r3AkUJEwV4HsDe/REDvCXbuUq24mj4xUDhWukq5cW2G7nHfkIjET7?=
 =?us-ascii?Q?2ZFfz2oe4sHfQmO77wqT6s7L6+Al3l8OWcD6JSaP2t2nNRpMFTxN3uVyzXwA?=
 =?us-ascii?Q?8OoZvkeyB5XGOf7/IFkgru1qlj/O/x05bAHnLPqS8Vns6b1MuOnmVeB+oRtK?=
 =?us-ascii?Q?HXt2sY25u67e8kRv1UbJ6H0Kj0uVkcMvfmYWqoOLqw79OsNk6m0rPePiWSnv?=
 =?us-ascii?Q?sh/gRT2oQ8XkKx+Gc4t8iwAOos+XPf11ZhxzVeKnLMiMx+GdQdBZ/20EGyPO?=
 =?us-ascii?Q?GKPHS7V9G4ShyOhfdn0k1cEAdBXDbYewHz/rqA1m9xbjVX6kTN3tauSjocrD?=
 =?us-ascii?Q?Kk4IYVnumSOXUOciQ+QlvNOrotWaRw58Jrbtc8e1MIAtRgZLuz1rqCMV6xee?=
 =?us-ascii?Q?qkTdYp1jkWtM03lrPATxAif0eoMJHmtYszU/xdLAnowkUU8ELG5Y5r2FNDLl?=
 =?us-ascii?Q?LItHEOXp5TtKZFExjYWt5hry/UUuDPnX5FYY07ttLDbj9syXi75n3ru3UikX?=
 =?us-ascii?Q?N/59QjOsY+Jq0kz7hIanjp8S2v6QhTQLlHpRwDAYHiGpItpqN7NePmyOk+BQ?=
 =?us-ascii?Q?o2nIrpIl0bJQEE2z9eCLTqVM/gF5xqGzYXKs6lEPdJIXWS8maBWt5daU1KJB?=
 =?us-ascii?Q?Tjp8Pztgd7Qt/MJR/N1zP3Utxea/KUP2hprKzjcvecINYgiNOaoRsYQ/Ok/5?=
 =?us-ascii?Q?fJ+VZyMb0PbSM0x3BnArWVMeCBBfC/wDr12C2ABJjxHWJ1mPB9hNLcy2wvam?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 659c550c-7e35-470c-5942-08dd4cdb0a2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:36:20.9884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66aYRXdYGG+hrW7NIeR4QoptOYsNftJK+aH+CCLon7QzhzE023NLx6CQsWSsMazm3l79jmETFUZ8ofv01Pa/6sHuA6dBk1LCh4QGb9mfPo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
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

On Thu, Feb 13, 2025 at 01:20:29PM -0800, Stephen Hemminger wrote:
> Latencystats uses unnecessary floating point and is inaccurate if the number
> of cycles per ns is not an integral value. Cleanup the code and add
> more tests as well.
> 
> v7 - rebase and drop already merged VLA patch
> 
> Stephen Hemminger (7):
>   latencystats: handle fractional cycles per ns
>   latencystats: do not use floating point
>   latencystats: fix log messages
>   latencystats: update include files
>   latencystats: enforce that unused callback function is NULL
>   latencystats: add metric for number of samples
>   test: update to latencystats tests
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
