Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A671CAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 08:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB5D402D4;
	Thu, 11 Sep 2025 10:46:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B9041402D3
 for <dev@dpdk.org>; Thu, 11 Sep 2025 10:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757580363; x=1789116363;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=ijvGcqbNSlef3ug2dScBzDzAZQebZN75E496+9ujMmg=;
 b=Rk06QXwOMiREEmD1fVBZOpIAASc9B/sEnFB3TG9wNhpUnzCNrSaOGfjl
 V53jcp8DYXWdDaKdroQoj5png0a+bgu8ZGmuJYmmA1nXqHOrBzmQtsRmx
 dTyrDbeZpufndxTUpVkvpRFKB+/1htmDTcQLaVYUzMav1VMN26Qn5md3S
 l/hZX4ld5TGyXDsalszFtuvRSCSmkoMch3a384ACg6PfjppKBoN8p2SES
 AldlOTp4n4fZ485NO5ucsm1l66Xwrw1FdQhaZUnaByZU40KbottQKxRJk
 796Dpzgvh7LTlKRMQKATE0aVMqSJXnJ6vgnf+iDosqk5VUIc+OeYTH+mw w==;
X-CSE-ConnectionGUID: 3O+S2MZVQ5y6p/S0bxy2xg==
X-CSE-MsgGUID: BCrlH034QXWQB/y8fnUIUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59979416"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="59979416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 01:46:01 -0700
X-CSE-ConnectionGUID: //3yNN9qS9icbwFcl1z+9w==
X-CSE-MsgGUID: tR9Lg5tdReymWcUCCvn+sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173536236"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 01:46:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 01:46:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 01:46:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 01:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvFQnZj18bE3S25twuXfiEV+qR/JmVzyj0l7S11yuzjhTVVpK81tBpWEXquoNd7XGpUW0/N07zfbbsHiRnd8/3zvanWTlDJgx8OhO81wdOLcoYAfVYRiT2hy8602KIj3okq2wQ8X7t/sZD3x84RLdrwK35GAHbo6BpjQJXASc41w6ekSKwhMm3c7XHMbmzYHJeg9iPlxGDIGtVCgCn9s+fCDf/LIKRBw0yoSkDwmm7z/W2lutJ06XTSuu9PSOrhITFtD+bLlFXmaewvEBp8IADNnjcJv7iHGXaLdOnRaKDeHD47aZmnOE1S5DxL6+AEfMUCrEPwm9oSsYM+zwmCDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNklhrovJR0T7yAcXM1uPl8QHR961Bah0Pi8as39vqk=;
 b=r7RskJR75TgqrbttqH5mCZpIoaXFWcuhFOHQWLG2zFc9WIZg8TYv0+IEcgEXkA19Tuma4cGBx8/NgCLdPVDZjBMu+Fj5p9JPGW6/JsprDXq3Xj3W+lK4IJ+Vc+wX8oqlykC1SrrqYsCiABQK4DuJXXhUI6erObaaMoMOm7gnYbrVj2lRkFPSw+70zmjWhi3yPhxoSET3upoqMcVSrciT9XS14eNU762nma6b6BsCmf2hweWROfRrD6GMUQYi3Q6ue3aXxtjQHRahlPBleP2ukj4hz3KVDIS5s2nqZ80j2iSHj0n9orsUVOj8SpwgeUemGtZOwnyJzVsrS+yfhlfETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 08:45:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 08:45:58 +0000
Date: Thu, 11 Sep 2025 09:45:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: remove unused Tx struct member
Message-ID: <aMKMQb93dmUB4cnV@bricha3-mobl1.ger.corp.intel.com>
References: <20250910080616.892711-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250910080616.892711-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB8PR06CA0059.eurprd06.prod.outlook.com
 (2603:10a6:10:120::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 09881056-1ebb-48bc-13b2-08ddf10fa0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rLi3n69XpGVoA4SYSxi4LQ+Yp6np0sOnpN6Kdv5ErKPJOOdgPJ+dgIEcaacY?=
 =?us-ascii?Q?PjwtB09pY2bGittl1ij7B6wih91TJTBmD8tVP7GPJRRg3gOt5EMOBZmPzi8L?=
 =?us-ascii?Q?Wm/SogsO/2QJ0K+ZIMXatTTg+PzLxwYwopQ6WlqysXeIp7Am224mDYp51hL3?=
 =?us-ascii?Q?Gp17oJz/I3NaUrN3k8/8sthlKd0YNhmIszaZLEHLei9/kjM2eptaTcsZ0jzQ?=
 =?us-ascii?Q?WGKAOE3Y0PDlQuK5qSR/bXv6oWKFIKeQSGBPEIToUXgG1MdSzIzCap+GT7ZP?=
 =?us-ascii?Q?d3dfcvPMtafEx9lFdVu/Nog6K3S07duc0vzaKbUqx2kwCzFuOUjEZaiMDkR+?=
 =?us-ascii?Q?JsKcpa2oDRI/cjQ4tCz9BwegX1qLf8mUQ5OORqDu5fxkodr8HpOQT0gjVeNS?=
 =?us-ascii?Q?i/mcHJ0kKl0RnRHnB6L54vDJi9bsdpmtM763KHAgm5jvHo37YAvr9hhi08Og?=
 =?us-ascii?Q?braRe0PO/MiWLJuNST+CrakuPTnv6V6kO9y7GCPhP+By7O1ug3zwjUPKbePv?=
 =?us-ascii?Q?mkBsC+k5sQ8mkK2p3u2+x3fiMQDXej26NXPQIHLnAIWYUe+kYsEoXlBP6xum?=
 =?us-ascii?Q?aqf7K+E5WTuqCyPp0YxxGMna0whgzv/voMt4P5O8spat0eEeMWUvwajNZSV8?=
 =?us-ascii?Q?e8DpghxW1MrkRklm+DS8LppRIdwJDHpH2BrqIs4fmM05KponPVDPwHeoFY0P?=
 =?us-ascii?Q?qgMqzl8oLLKGMdd6CF0oDP/YZYRbNH/oZIKqKZn2tWTbuHU39Hv3SGwdy9ks?=
 =?us-ascii?Q?ItZSupepXbX/NiN3YbDGjb4ppLb3BprKTri8uCgbcwO/+oSS5JSJ+sEBOXAM?=
 =?us-ascii?Q?HOGdLhHef6x37dl5z9JmkRPmcy0+V7eSArZAxKZiDB8EUF0nq+385VU2UtyA?=
 =?us-ascii?Q?FUysv2oL8N6EEXcBMmuDuEyaJOYUvgKbwCfml9EW5cWYbpMSSfPZP/nl3cVN?=
 =?us-ascii?Q?2n0fH9Qe2xPdF6z0/4SzV88MJIUTqI9OuUVIt7PDIy+h+yxuccdwhCSsyCF+?=
 =?us-ascii?Q?9ozu/iPGA7cbRuVJcgd2pL0bLSxg4Hq6ng7ipog9MdVw6fp4Mx5VcRghXjQF?=
 =?us-ascii?Q?1O3I2ZO4uhMA5RUePpohSEqRZzGAU1bKupd6pI8t9VeegHprpl7evla5kuzI?=
 =?us-ascii?Q?y3sdSTZijsZ/gjcQRBZH/N8yNyN/4EYN1XAEqMwD5IsX5nkFe1q/tUoOXll4?=
 =?us-ascii?Q?i0iWcIQ+9UID6d+D7h5phw4xROAiMXTfYrQNqAYbHzG6JRhvrlXXwvQQWM4c?=
 =?us-ascii?Q?uBs0+26uMzcgZexc0OCWHKXWqUDwIhLDWS0hRaDG6HNeWLi1uYcIfXT04pHU?=
 =?us-ascii?Q?hT1SGRDKJkqtQbJ9LhXd+gAFF333N6tT79Pwrw+tB6O5JysQM+xSR2hiTUSO?=
 =?us-ascii?Q?xckISy6ldEcH/uTBprb5dcq9IYob09wTKGolH0OOq2e3234x4oV/Hum+iY8o?=
 =?us-ascii?Q?odLuRhMxXhk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Twrh9DcCu3J25hl/f/6wSksnSYY9Eh9Vlyt5Sj77+TICTCVxRjsCW+uUNYpy?=
 =?us-ascii?Q?PonShJfn0KiNzG+NswcA2oMcO8vPlk0sq1xfhl4vcB5c9VhDkCoPhXjV5pyh?=
 =?us-ascii?Q?C6izPDZOVk3u3JvRdtkieUITIhhEQHfwHhHNzEaBc+TtHn5awHWl3cGbYla7?=
 =?us-ascii?Q?WVjOAGeU6cwIoVKg0aIVBgsVITIhRAYplMpR0KcumB9Exdnz36fbIB/zF2Xh?=
 =?us-ascii?Q?R07IsiYRL5c7/V74fvMC0a1qR5GRbJJXEKmP9h+8mM8UxjER1vgx05FT1G+W?=
 =?us-ascii?Q?5hMbEw5NKIIk/0btG0yv5P0ExRxS/HpcQsdDXIpULQJU7y0jwhZuZ9QrUm3L?=
 =?us-ascii?Q?k/YseGmkVSbuhUxGYtx0E8CVqA0zz4wvCfetpjIx+nCbj4dR66nUTHXXV+WQ?=
 =?us-ascii?Q?C+q7WXBAokqSElEhgtLiOAQXnk4Uk40RFnU02U2o4gRnQi2Yi/Ok1CoqX7v9?=
 =?us-ascii?Q?Ep/+YUOtIqAhBw8UHRGYDPzLPLuF1/AXdYfJA2IC1kU4y2Qg76wOwi+MyG4n?=
 =?us-ascii?Q?ZYPQy1ymVAyEEjsYfQWYqtrc1J9KF/NYlwFomkNRioYsdaLZG2uLHQ6Hdeix?=
 =?us-ascii?Q?m3pSkDPAKjGWYKhZEtagnZKOO6kq48aAQmVJfSw6TJ20MTutvb/B/55HDPMz?=
 =?us-ascii?Q?1VdNVhMLCoQ4UCyNkDoj/TdUnqdxzr2otK4xtq4g2bmL5Ihg6GjzypVo3CaL?=
 =?us-ascii?Q?cCZRMNB2vSjjDKgg6KA+Zj/Garkv79ZtHFRRyrL4TybhfUqW1MZBVpghZqKB?=
 =?us-ascii?Q?Fl5pMLO4BTODAOBZzwzOCZ7StHAlrk26GUFZ4wJBfJ00T7hac9r+0xF5SYe6?=
 =?us-ascii?Q?xbI9s99T7aAvh0XQac4QFN/GWK4eNc0LE/aOF8VNg//nMpOfaLjwXM+nDW0D?=
 =?us-ascii?Q?MeFs9Ok8P19sTTlPNmzA0ztvcV0ow4KV98WE882O088be/QYfwn9CZw0hfmo?=
 =?us-ascii?Q?Wto9zOoJ05+CX6uQ24T/QXJyeDEN1RpYTMIGuBpvNKNu2law4iNc9UG3wGg2?=
 =?us-ascii?Q?yOrt1xmbbEDbAtijBw5U9l1CdzUrwcEWhtfksI0WHVpPvT5bKH83cylMqCVg?=
 =?us-ascii?Q?+p3pcGA3DORs5KiDnWgvROrScpkZ7RgNqVsNLIEuL5frjkOFKqgg6IGkwhJp?=
 =?us-ascii?Q?15uXakcadDYf1Fi7rNVJhredqMItofHlSgJ2l7SkcFrp94pUyoLe+8JaS4SE?=
 =?us-ascii?Q?2IAqULpt9rI+WqR6C1uJ+vFS8MJvYSMl2xX4Zcs3dbk7JhAzLb8otmF4FL8w?=
 =?us-ascii?Q?/iIZAF3QYZJL5934UI2ONTsbLdB7CvS3T/nrSg5LY9S1gZW9yCnBXp2RNylI?=
 =?us-ascii?Q?9SjtHgdflTT1P7ZIfsPgIpdzvCH6iu25IEbsVLyD52xpbmwmgd5lzwh5gLRs?=
 =?us-ascii?Q?R+iDGUcHbwSymr3XRux10kvqoj1WRjasSX1Jfp4Vn6YFnNC5RLWDRC/DDA53?=
 =?us-ascii?Q?gd7koQ9g9edF/U1IANQAj0Q9hQC/dFNYnrmi1+IlxiL689aAz7sIkiQavCA8?=
 =?us-ascii?Q?UkHM0JO6tedBTFVQPH5On8f3AllLIsaD9k1S+W0aPfj8HMxZpx3SCIpFPa8m?=
 =?us-ascii?Q?ROywsAmnoMXBA3ZN0KPPt9MYLd1P3hFz/khx9cJUgETtfggJkVJhBMqoP1Dh?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09881056-1ebb-48bc-13b2-08ddf10fa0fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 08:45:58.5572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/LiDrwJ2Bl+eImLk8l2Z5ySiV2W9OLWNnaxdZ8G0t+e5uS8SLTVdtwW17CvMzM5IwluB+CN4GwEtEa+lRjYyIu20PIbIgpwXgyAB4f2PpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
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

On Wed, Sep 10, 2025 at 09:06:16AM +0100, Bruce Richardson wrote:
> The rel_mbufs_type value for tracking the Tx cleanup function is no
> longer used in the iavf code. Therefore it can be removed.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Recheck-request: rebase=next-net-intel, iol-compile-amd64-testing, iol-compile-arm64-testing
