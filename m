Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57977C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7CD42E62;
	Tue, 10 Jun 2025 12:51:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 911E142E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749552693; x=1781088693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+Xa8lIvmHpLzF/R047VWaDthB5KaqR9wyEJccN1AeZo=;
 b=iZRlh1tiFsjltvxbrrl5W3TuhF9r82cq9LmBX7/fXGuog6IOBuomNZTY
 sVpp4KXY2mzwcoS4iBJ6AZuRH2iuqtVhsXDAFmNpEYVNnBkRhUjDiLsjR
 M+B0CcOPTBWn8DMqKkIvCWbQ99FFsfJYmK5j8vljx7T/cln6kOJzlUH5L
 ExSNkVoPPgTx2CKsa8VWWXjqjGwaKbi3W16plAQ1BMvYw3FglgXlWV0l0
 4y4bppN9ujkzTWgBfQ9F5Gwq7PEwE3As8fKEa4evC//1Ay/LmC3owThYX
 Ass99l5CJOQs+VXKOb4pzukL4vAA2FUcsaN4cVzh+hLTttnMSBRomAKhN Q==;
X-CSE-ConnectionGUID: eOC4mSbxQvGDNlr1zwyjmg==
X-CSE-MsgGUID: ZKfzTBESSWm0Zz37Bfe37g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62269044"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="62269044"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 03:51:31 -0700
X-CSE-ConnectionGUID: /TXyM5qqRHiKjAoflhpyPw==
X-CSE-MsgGUID: hdk0UCE+R+CRGacFTlo3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="147763988"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 03:51:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 03:51:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 03:51:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 03:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6pbrgwEIyxASmTQk76Yx8EXL3C2X3Z+CEbwnVi8m1T1qRsNj/lFTHgUo8S8GAWHNsqyQrDlAzr+gS3sq6EYEI2fD76AnMgKuxV3PymY+vk12ORThVVlwn24tgaz/FiX6fCnINwtLin2TvoqqrcKq7bDj2Y7v4qWLx0+ejQqO3sJUZT6poyf5QBklXmtoJ4LCMID4bbOXfDEoLn+50281z/QunpY12W8U2K/4whlsrrSK0ud2Vx8Q5ixcJxBOnwgTgceh5KulBSSfr33UCIZGaRA2y+aFaaayrfqsQlMJSS0lhcs0iCRm6o45E3T7xUUFMe/Nt132UQKvQRLWvh9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbmKN+DhLhD8o8mCxnBYEh7Mwyud5/Hjh5GWS/0gsPs=;
 b=UDoJXThlqbfEJuerQJvrSjuMSIOWLi1QY2wkquHWN+SyM/1oTlWbUkbdn1iHzL1l/PFaQDZWAvM7E5MUX6Gt7N/NGOyjdja4nDIRIQC0Ho5PnFmuo3BjnGlQ5/STmkZb+bFg4b3wiVD+XJf+zulENl0jkxaW19E0Qdlqk50n4YfPJqt1Aa3EeNKTDzL3lNnXmjaM8++RNjB5iJvJhRe0hmg/DL1Vo69hLciGkRIrNwYgHaYu4hPx9+HbedPPAtKBbgkB98aexrH8z/VqefxqKKlyJlCUvy27q8hkcoKGaA3F29qMepRZj0R9zx07sayGH8CPsvnn4Vpmiu63SPMeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 10:51:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 10:51:28 +0000
Date: Tue, 10 Jun 2025 11:51:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/5] Update ixgbe base code
Message-ID: <aEgOK5MjEEL0Z3gY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749464704.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:10:be::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF96964A2A1:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d2da2c-9fdd-41f1-4d2d-08dda80cc070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hMinWUhJ1TpIe9HnI9czfNlHs4Fva82jwYdglPcdFhN9egOtFYpAxMLUPNSP?=
 =?us-ascii?Q?89QWFcLhdMvEDS+c9O7jsqpW1nD14X6H6Lb6aPEYZEYWOF1iU+JuToQvYzYf?=
 =?us-ascii?Q?4Y8EhKJYaizo6W7gTW0qXW4l+1iraynZwtjmY9kLrRhMB5sXblFitOuLe/rq?=
 =?us-ascii?Q?FVlUZnuSzTNqs5cB0VDBm4dZwZIgyp2dscNRsmQ+AC4eZtnJTDzuJRbb4OZI?=
 =?us-ascii?Q?nRbT9IwQ9AZdl80ZLZjoBT4CeamweGFe3OZeSeGo06XMun19Y/h/A4ymhaww?=
 =?us-ascii?Q?DlYDmanvFeEVNbDsapwNP2DQ+3zHJFhwZYwJlynIcDwt/zNBaCvccHxemY68?=
 =?us-ascii?Q?gfVcyezxfzs3tDiY31+xL2Dlksj9btwlHkaXSIuWZQqcq4QW+y6ycllp6NWP?=
 =?us-ascii?Q?/IweJZ/HDpUK69ps1ns5PemdSjh7kci/nwjv2yyjanUH2fESM5Wn1f1kwZgl?=
 =?us-ascii?Q?xo2Xv5vsHOebHwQrk/rD+HfT90Roz7Yf+/XZrevNtqNosGSHI+sTO3Kqyh2f?=
 =?us-ascii?Q?l4yiOSdh7CxaN+gfGl5XTwMMnn8hhj04dIcmtS07h5sHT12Vtgk6kc3cVgxo?=
 =?us-ascii?Q?5eK5Fq7+vVsB3DlcQqiFqu1B4i9QL/WlRxO4jZyDf//GvRRtKF9W27I03F2G?=
 =?us-ascii?Q?nAphzOj2xGAxoy8HQwxnwVUyPmGU2FRNYJ24XpoBLfwcakpH22yekzcRmgXE?=
 =?us-ascii?Q?FTlLau6t57BMcEJVayb+abR+LiMdhYzWRguBstnUedld0OKVws6Lha1jfduM?=
 =?us-ascii?Q?/bnGXAE8WObicYIqzSe75Cmein6u8yh+SvGX2iuZOkxiRMJSMckDc9pk7MQJ?=
 =?us-ascii?Q?unSxQr9tGWL50Lgl+yBZVAQGiS7pGJcOD9TeHHN5x5aW+9wkEN/c/JEGu2FC?=
 =?us-ascii?Q?rrRdpCIij5xQF9UZpHkUAUGIQgnDPa0Wod81A2jfHEgEW3sntIlJIl3Jok50?=
 =?us-ascii?Q?xB3sBEyqHnAJEAOZ980vJ7E9do7aaUtVMyVwGYFM9ssJZgnN45ChHhLIZyKX?=
 =?us-ascii?Q?8LpZiYj3QIFMzgFWmvNXGjxs0obJcJddeuowbkNFPqDWwH9Ii6H7GiwLBB3u?=
 =?us-ascii?Q?vjY+FtAHS89kgnFpiMJVq/8V7huLkjmxXPj5M2q8AAiCyWg3c9UUnlD6HGQf?=
 =?us-ascii?Q?o2AI6ccWWd/qs/QjNR00uVDAHkKk1nm4rKq4FXRBK9OK4Bs9lyw3IVPMeli8?=
 =?us-ascii?Q?E6nz3b+vh8511cdRImqSKjAhwDuuvXiwDX+P+aUiv1kobbEc1FGklB69GLtp?=
 =?us-ascii?Q?Q0qrfCrK1w3tTPxBFYbK3hbWHmQanShx4WLdI3bNQWj11JdU2ckN7GcLlOAk?=
 =?us-ascii?Q?uj1O4emVq7l/1UvUD/0ajd1edQLeaIi+PERULOWCoWuelo33V8fUezifk7U5?=
 =?us-ascii?Q?qOkpMVU9VmfZwSt2bAp7TZQGph8BGXMam8o/iJMdVDcBV+GjoAVJIWvpAptL?=
 =?us-ascii?Q?7L1/RJ9gQLs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RamPCViJoKaPZbv7P0cFNlq1cWzpXNNja/pqTbQ91+mHYz3jqlxVFKpiUnAx?=
 =?us-ascii?Q?7DwgAgQKmLfRlN8YKfJ4pyWaifkOFkPpe6P1k8204YMa3x5Fj/Tv7fAEWfba?=
 =?us-ascii?Q?I8adyNZVgPPRaCfIOCM0+g2mWLo0mJo91amYhul/i/STTj667q72lM2Auepi?=
 =?us-ascii?Q?0SZOXOr0W/MEzNid/LCH9KMu59v2ga3nkJ9/tVoO6u6TUmdNyyOb++GXwGJ1?=
 =?us-ascii?Q?myYi8aocEAiRCeodnS9uvWENCba1F4EvGaLJGJY6BzCliulVmKPmOlos9E6p?=
 =?us-ascii?Q?D/oQJwctBIMLMBn9dOg1BO+rn8sFBsZVsEU/sqr5ht4uwho9wEkziEZpCsrF?=
 =?us-ascii?Q?K8NG+RDTaFR/cTiijl817nHnKRLMOo7vtKfybQTolVtcMmonVXhBG9cHSlFK?=
 =?us-ascii?Q?/NhLZDPhiXIujoMVVZcQ+nVJC0lbZ048c6XVXzXOgHXRUmlvaCvSRwmgN3YV?=
 =?us-ascii?Q?KE1UnhiL5EWMYK3M7MyUyaKSwpC2enb1ZJpmpVLO21mvkIzL/yHvZraNzYcj?=
 =?us-ascii?Q?aNvViXQbjcoX33P010BjqaIVQc+RysKrYUO5sBpRq1IPyP6Zm3FAubGsRKYh?=
 =?us-ascii?Q?ARmiXsUmHDyV+eO2nYA5d1x2R0p7V4wna3AP59qy8NgVIGz0tN4QrCl9BsDd?=
 =?us-ascii?Q?WJrUJgaytdHlPxRrf583kErjn7ruqETLWYpw6bP84SNk4iK8gF4CZqLvXdOG?=
 =?us-ascii?Q?OQdatzB5rsh/1LEyGD0RUlqgP3wFzoxwNCEnehGGfOqe0lTjQmBvs8nAd9/W?=
 =?us-ascii?Q?niAAfKMJWAyYLcYu1Km9upDuMev1c6sKySL6h4I9paeeGsMSH/i3Ydan6Rgf?=
 =?us-ascii?Q?f4iVPoIglu/Zpp2MSdGOUNELxO1g9P7lXauI7NE8bSdIdFrXBNeF5fuF0Y8S?=
 =?us-ascii?Q?sau8xOtSaZecW08PuglCu2VHk1Je+XYmoVRVvTdnASUcI9Ektoo2lvQinR3p?=
 =?us-ascii?Q?9tIO/+JFUObH19HsgamcaEq6LcJSaUPb/QDu4+G0Wv8hFSh81NmdL7u3A7Xu?=
 =?us-ascii?Q?1wvWoSDlB4SjcY06L3AL3LmZdbCr78ccYxoQ90o9cnl8fsEWY6R9JDE1nV4g?=
 =?us-ascii?Q?nECIWfxHhPO5FWGicoSqlTWWoYADpcxVULoQZ1w1mQDcwuYYCHoBLqTsMXHl?=
 =?us-ascii?Q?4Sf6eAwihqV+f+jwj98dU/0CI30x9i+KwUJzNlkvdgMKTruimj+3U4SeuKl+?=
 =?us-ascii?Q?YGV6POj3jKCNIdK1Sq5Mhqioy6bknq7+ThovkTyfqWVMvBnH4RsInKbjshX1?=
 =?us-ascii?Q?1HETcWS8lKiaulQsL6q0ImNLmu7MpjqAuQ5s1CXoEGF1QfqKUtWThCMDKkzz?=
 =?us-ascii?Q?G+ujR1HGEbDi4AZaBa2EFZZjUdvwTcGigrdojHa0MhNcJU8/Jp85Ks4c2eLn?=
 =?us-ascii?Q?JUXFjhnPZgSJEz5VoPZvlWNR7QaW6WNhQVSDpdVu+k06t8Sl2S1e1z8VjyHe?=
 =?us-ascii?Q?QLj0q0ZvwE1lAMHhXlcX10iGWtXF86CIoHRO0a5CmZhXrzw3IiY1u6BLeWxt?=
 =?us-ascii?Q?xNxunFxws8f7M72P7g/aDALYHo1E5NxPLgRV1haThPy2Rf/I0q/CUHSFImQu?=
 =?us-ascii?Q?R3yoy+A5rREKjbFfgcPHvRVcI3Y2FgBQTMX99gNH1lZMQlao+/uYy5GcB9Zm?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d2da2c-9fdd-41f1-4d2d-08dda80cc070
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:51:27.9317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+CVOcTJkKj3TZ0wYqbBqGKX+qr7JBvYtSGnGBih5HXx/KbosUQnnZejaGHXPL3OqDEIuaYVsDCtVGXyyjiQw9wcwl/y3ZXYRUSSdgcjQ7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
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

On Mon, Jun 09, 2025 at 11:25:33AM +0100, Anatoly Burakov wrote:
> Update IXGBE base code snapshot to version 2025-06-04.
> 
> Aleksandr Loktionov (1):
>   net/ixgbe: remove PTP by PHY cap
> 
> Anatoly Burakov (1):
>   net/ixgbe: update README
> 
> Jedrzej Jagielski (1):
>   net/ixgbe: add VF mailbox op for link status
> 
> Piotr Kwapulinski (1):
>   net/ixgbe: add ACI debug printouts
> 
> Piotr Pietruszewski (1):
>   net/ixgbe: add support for toggling VF Tx queues
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
