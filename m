Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE421C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE7834026A;
	Thu, 13 Aug 2026 12:39:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8EBB04014F;
 Thu, 13 Aug 2026 12:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786617551; x=1818153551;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZV3QW0RrzJZEW8UNFZbfDxBQDR2SU24iG5oWAAUyDTQ=;
 b=RCIFjRNEdBHMRgZNrZRfO+cqPDqUd2DaP4vIQ+VRlKFottnzs6K39+Mt
 0wkg3qj5GcPQJdzjeDCnykePp19pDoXuc0Dat0mjkfgwaArpBBYmDlR1/
 DXawXpbZtR8FkpBRVfI6IMLzPbmZJOodNY7HtRW+0ScVKC22FtIy4uhI/
 ZOS24mHeLinw696dccEm6Of3jTGZryHD10kmqx80qYOIDVK5bJZUGURCd
 P2xlgMT0DSchsLw0sQiXCyPdr9DsW72bAdmiNlcpRh6YxdtifK58IxxFw
 iXr//JUX1NIPXR1XjGplq+y1S3o0TbA43oFzhuBUzVH1UTxlE1NoyVdVZ Q==;
X-CSE-ConnectionGUID: o/HGJVKEQjKdP5VqjCFoaQ==
X-CSE-MsgGUID: zFiHebAfRGeD9epPgBjxjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="90866451"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="90866451"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:39:09 -0700
X-CSE-ConnectionGUID: nqCXKw8HS5C4jmAcQLtA8Q==
X-CSE-MsgGUID: txm01YkRTcq+AH0dzg8J3A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:39:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:39:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 03:39:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 03:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKpKQ6VoURA0bP5+5Bn1+KM9GAdZJX7i4yhTinDa0u6I3F2VyLDvUODHOTdD4Y5qGO51wYllNVvFLBUDUjXGagp0mKStqy8SxNy2nYAycImWmsvBYQCKatuuJWVUb28eI5imdtyDonJvZr9gZ1ks5R0+e1N3Ry+icWTSyVMHb7WJfOAwG34V/jwm7ksq3pPDrN5GmaPqtZj7Nct1RqClqRfhAZnBgY2HNO3dsr6dEJO/4XEteX8+z61z3wxXaDEbHri4JMyo8UaZdApQu2NfrrX/YtGrcfszun+pWUAsow4FLuOqANGS73HNdIK/+OuKdopXzcpJ4Z9GCFjfhI7l0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a5iWdyNQSRVCS7RlxW3glGfVbVErmOsT3ETmV04440=;
 b=X71oKdlglLPdcqi0rDYgWjcoqHiSqksCQJhAdguwedNUQ2JuUbCiZmdIjKWslgaajAc6Dtbp6m8r/yJEohK12q/bPideHVNMvHtA47437X74+fpF9D5p+RHuIBI51VPkoiH8SINN2gmqL6nJlb4KiZAAncq2elecvuWT+PDe8v7fXQKo8MKkEb6n4BOqRQpzehd5CwsJC6EfTQMXmjCk/10qO2LJkaqiYXAzr9/3nBuvS2kdscF+4hu8bMzCJLjUr/v3+09R7BECG7OBB3JD5jDnde04YwIalaGwGbJTG7/wsMFLis3zXwragdQmz5QBJ8WwYCIL2bNB1yAu5WSzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 10:39:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:00 +0000
Date: Thu, 13 Aug 2026 11:38:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFC 15/32] event/sw: fix unlinks in progress counter races
Message-ID: <an2ewXnX2QFiX0rV@bricha3-mobl1.ger.corp.intel.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-16-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729175715.165120-16-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 18249e48-6f31-4b83-4872-08def9271654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|5023799004|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: dwMbe7Q2qNCMPNT84fzLbP9KNC2C8hrCtgXpxZ3ySj3VfHgecZlGXG6wRGePCe19o1KaKHeoKyZAYyDcqs6K1qigzr+2uHzMkB8azoRgXqLIIu9t6xrBU+4Cial2JdB/yX2Xhy2J+KwV1Y3uhROYW3ASB1EWPG0s/B7WGwXzxfOiOy7mj7R7SYChIb+urizm0w3ZYkWhmEg+dXFC6lhd8RxThWJnU/Wdju6Up3+dNnZkUK1thHueLK0ZLJ/1KK6pIJFCaoPGMsQiMkIb7QmLHeMYIAqIv721ynbA2qG//CWX5Ftc2rIaZcX+mz0Jw9Dt4TRUlmubJE0T317x+gvS020G4siMoiLhkolVEPZKckFijueY5rN4K2F0sI0R1jb/HYstHmRPbjUqazxbJ7v20VXiYZjq20NeXXgUa/LsUrxUdq2P9Iooa/mele0ibXE/OFETKtpgWt7hbQdAQlnmk8RoUygvcW++NzfEFzE2e5SJM9jX5dTRq0ihBH0Z9ICGo0ovuXa17cZXSZecNPsqfOwEsRmIz2ci96T+LFmsTYt+s+ikgdGuSr19lQGefpcGmr55td+2Zv+TJzo+akGIS4P3gsKZRLYbvXWG5/wK4+oTXXQyd9TNcvE18L4vctN0+BSNtTN2oZFQyzTXGH/5KK3Qw/uwfFG+QUX+sfgKEUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EeGzCcJGlFSc7dbdAlZgxiCAEqXB2B8uHY/Vm+BMeildKbYh8kUOh8bh78Z?=
 =?us-ascii?Q?JP7jlObOa5OhB1j5h0doEFbPXkROG9PmPSIqXYfoiaqpidWocxttWk6p2VSh?=
 =?us-ascii?Q?h17qPIlynS2cS6pXs+ocbYxXfEX5RuPADixKAi/dzpoGc+ikrKq7tkJjJXMC?=
 =?us-ascii?Q?gqFsHynpwsEoCmifnmdrbqYgt5SAODKbxrCQPKm6i8UeLtt/v8XB8rqqeZkG?=
 =?us-ascii?Q?RuZ60Kq+yWDX3z8oYoGSRtZ/f1pBxWEeQA5JAQCd4OdaGHWJR0iuJq6Ywt6I?=
 =?us-ascii?Q?QETA1DPjOWRN9Fpg3EQkQQpZlhUot+wf1imrl1br875saDlQJRjJA9FgCRTJ?=
 =?us-ascii?Q?KNJoO27xU6PEGvktlFsxiC3eWitVa1HNQzSawr+oK334TpZ+hIoZ7lAnp+m0?=
 =?us-ascii?Q?X5zgpisuVyiH9c/l2/+OuiYAz+arrKunO0WIOHdk9D+nuZAAqgKfQedL+QtX?=
 =?us-ascii?Q?+qOrRJPIW3ZcASAXHFqdfpFXOBdANBl/eVbASzxkNWXaRvpoLIikjzxQXCwN?=
 =?us-ascii?Q?4hyBPOIUIvzhyVlXO3VRX/cgUV7DEQksMvF30beH0V0gQDV2yfBEHc/FTlPs?=
 =?us-ascii?Q?Y33MIcInh2L8IqvrsjVXUuKHz7/+bGOIfOEc/YMSkG879+jz9jSI4RDh5Vqs?=
 =?us-ascii?Q?0z+CR0Teox1jfMVpHWVzUUbE0tiZX083/g2Krnj82uTTuwX9lWBN7Oo5xtSJ?=
 =?us-ascii?Q?EbBJAy7jx3z2W7hJPCwZJIYafQ2/M3CV7+Rr/Op4q+5IolAwDY2H8qB738ed?=
 =?us-ascii?Q?AShxHIubKvpTrGcMFWZRzIt5nXKIpWoRKQoNUALuOlIgDBFyiWAIZsY7DUvC?=
 =?us-ascii?Q?uoNma8gWy2uMSLrCbEEMA2kSiikp2pLwj//yEFfBCH4+91U081Y9OK0yun4y?=
 =?us-ascii?Q?we9jFVYnnMjH0VTf0bRUN1McuPpAQbIK3J+DuEXEL3lTtLsoIJKenUwIoV0I?=
 =?us-ascii?Q?iyULjqRD2NuPFNmIcr1SxUuAGc3MH6UwNIxtTIyo0KArYtvOy8Tipslk0GYY?=
 =?us-ascii?Q?rgEniiDUJGmx15IkLsMtzdK7r4bIhnO4drtICJTP8N6Nqr2+v8bLDigeMeZV?=
 =?us-ascii?Q?zi9Sr2B+ocoMUGZPBKi3jupVjGufxl57HtENBfAXf45B6wxBQTwzYIJY1k2D?=
 =?us-ascii?Q?s02vebvTfQXTKaohYL0RAG9q47nH7rwwbF/BK+NI6kCBgiAyVasw0OoHr+SX?=
 =?us-ascii?Q?e5TlolrAqTLlqoMZ8oHKRJaPgFTeqx/Dozw0NxGi6KjZ0cxHEsSbjZNvBbIW?=
 =?us-ascii?Q?uW9pSOnSqwYVOzOkAdDlx7n4peFhsm/Q4u5Qlqy4yt6Koufnn4BSNWNyk+77?=
 =?us-ascii?Q?llrL6QXSir9rnY08kcK1b6E657xI9+LcMpvAzuuY7gZNXoY3CfFNvre5kSKg?=
 =?us-ascii?Q?bhxIKSbfFqSSoEfuvyrZAlzDZRODIeIsa8H+snoDylCHu7rTR+nzH7u9vKrD?=
 =?us-ascii?Q?WvS+vpBMuv0coODi/3u16TePPss3vY1ZVzkCslaZ8WXLBeED2tI0ZJN+wG3Q?=
 =?us-ascii?Q?XY9Xh9r1BOWxLoJI6gCLSp5uty/o51UtdVG5SGXGUvGiQi/OTnUg/RA3w9x5?=
 =?us-ascii?Q?NHfDxsoCtUt6m2DvGatgdyTvhF/22XNP0inZMUhkE40T4zdt0Pqeu5oxqe30?=
 =?us-ascii?Q?XmTPglr3ERHLyow0aEUly7CR5phOb6Qlzgnsx+We//mhATfX3pzDr5H+39o3?=
 =?us-ascii?Q?1jMg71GOt1poFfnvCf+UK4DoMw0fI0JQTAeNglHaDY+R7s3BsCejzqdSVxji?=
 =?us-ascii?Q?HKxtuEklstSne4woOE62KbQ4uHKl2aA=3D?=
X-Exchange-RoutingPolicyChecked: VeYAT/x8e8AWCUWt62kpLj+c5J/nkHiUXAv7TWPjQI4RPtr1I0QgiaUjxDte2SueX0EzX+kayG679+M4SXacpBnD4l10/ulDYDg90Xp6ahZkl2/RIIBAY9TwGTw/kWfnbHUuNYYkOOch3PsBLXfex+1CXR74GHNUdEQsByIlp6V9PW9lEwpDC9bChE7l2fpqE91WfyadBkvhxhXLW/GEin+JozdSV+IS/RTne0+MxYb27q+2DEOAUU5XwuwIVTCTzhww9Gfv9s5KcWN/lSxJP2RMqCx+UQVAp2+haQWlhUu6PBGeFl86eJljtVRaN8u8yOpg4s2P1MgLEQexXE+uKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18249e48-6f31-4b83-4872-08def9271654
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:00.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjzewqEaFIRpBPLs3iD+sJinrQS3KIkA0ZjHaaK1hTKvJjj+FOABIRtT6lXlxMTmrUC0pkwI40si740UHIjb3bQq+tzj9B7jlZwZuOJdpyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
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

On Wed, Jul 29, 2026 at 10:54:08AM -0700, Stephen Hemminger wrote:
> The counter is written by both the application thread (increment on
> unlink) and the scheduler (clear on ack) as a plain uint8_t. An
> increment is lost if it lands between the scheduler's test and clear,
> making rte_event_port_unlinks_in_progress() report completion before
> the scheduler has seen the unlink. Nothing orders the scheduler's
> later cq map reads against the counter test on a weakly ordered CPU
> either.
> 
> Make the counter atomic: release fetch-add on unlink, acquire
> exchange to clear. The exchange cannot lose a concurrent increment,
> and the acquire guarantees the scheduler only acks unlinks whose cq
> map update it can observe, replacing the full barrier in unlink.
> 
> Fixes: bd5ac24fea88 ("event/sw: implement unlinks in progress function")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
