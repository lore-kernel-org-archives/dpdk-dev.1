Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FDCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C48A40674;
	Wed, 24 Sep 2025 15:54:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id F160640289;
 Wed, 24 Sep 2025 15:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758722065; x=1790258065;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OzBZANjcYG9vErET6kWBIbtxsth2VSqgl6rziq2THy0=;
 b=DTsR9JfL2y7fkcyPTOiI5DQTcm/QbYxtSDES2bL5xyR8GF+hvQNebzZ1
 EOxFaW5d47Vikitjk7q5vsM/mUY+3a9H5e+r4w8rjPcdN1VFKkdAz3r3A
 7OjGYhJQgipsxu5cNPLhW/ZNzYQ6eFzZn571JZRExEM/PcHO0cHl3PymI
 R+S4IBQN2cTiee6gnet5EgZ8WLchl9ZWBqsgzFTNeB2sfVnDuzVDWZnIY
 lvuODqTJQUbORVTHvK0r+mnQ6bqtWhWGRItQO1RLo7+aRT9GqUdKk+45N
 z+sTM5BJbRs9O1Wb/R+Lsz57oOxMwJdUrvvUUBIuxXSlwl50vWPymxi6z g==;
X-CSE-ConnectionGUID: m5o8jbhITfCckW/U/PnSOg==
X-CSE-MsgGUID: B03ykEDeQHi+J/ea8yTomw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60234863"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="60234863"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:54:23 -0700
X-CSE-ConnectionGUID: jGvBOXx1TmGfYoXEbfuDRQ==
X-CSE-MsgGUID: NffWLtP7SsecmrWhEWxPlA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:54:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:54:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:54:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDx8uew/CGvaVwe+sP1Vnn+t9s+rYhDo5pDxnVNIk1/uyl0suX9P37/S46vMS0ojA0V9R7xszTJN8ZpbmkmXlJ8pn8+ugAs23ZBmXo7lFwOwylUo+s/iFNRHTIprfaYnBWFEXQh2fKjx7E6pBqfRul2TZ/bMRsOSMyToVkTu/Tk1rOYu88l8gW5FxOG8QQX3WWDnAhQdojlSBG5XjxpLz3aJPxGpQZXxj8q2AtOMR/mxBYuAk/jqYeBhkS2Y5ahVeBPS4STKeeEkBNFCK7rRC5/tACASu/xe2m6eTj/o9t0/CaM/zCwEtZXBABgfw2900oAn1Ucj+0fiAEgaNdYKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcqJO+UJeNziWf+Zs4yr/qlntCBdq2ap2RdzHObNJ5M=;
 b=OgY+6vIBtpW8D8XgTFAWO5ZcjkWfc3PqgGm03Ofm2gabKuRrT5eoiC0tvPRND+fwLZV1d15NfxfZ7+51SU2S7tMCXCE7ugXHUiYDLrWO+dACgYWXkX0bstTmykIibeOyi02fjNMPTRMQhuIhdHKxXWW/06b3bKOAHNC4Hr/8dSeFDCxTKfPkA/ogKtmrWqzRkUbrZRHcOkx/KHJUyXI2RmBKzvj1yCGljRN6XaQuExMLEQl7tMv+NRzbO9ZFqayYeeYftbuOc75RfxTlf+RXBRctagG646uCFo1WS6URXNuHaee6IjSdyuyJMDGw8j8RsJ9fpeDFNyF91Xa/iQiRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8376.namprd11.prod.outlook.com (2603:10b6:806:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Wed, 24 Sep
 2025 13:54:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:54:19 +0000
Date: Wed, 24 Sep 2025 14:54:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 3/8] net/iavf: fix documentation for speed capabilities
Message-ID: <aNP4BjfJT1aGkcnF@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
 <20250916142113.3485738-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b07bbd-47ea-424c-b107-08ddfb71dba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rjR5n2x25GW545qEG6F0bCxKQmQLe+XDlucsg6KZ0Z9XBdDuTen+wUcgn65w?=
 =?us-ascii?Q?bUitMSfeq1pAtCdIhx4fB0ohnYMpBw1EW+z9g2TPUCe4E2IUQ0fwXgKkw4Xw?=
 =?us-ascii?Q?/IXy76YQLWVrWPIkZIsYc0JiqIMAUq2vHATrA3mMYcwA0kldeaHtCUcRcjQV?=
 =?us-ascii?Q?TYxXMQwSxFSmoS8JCxOePgU/zZPg9Ts290oin8/tfGg0EYRGfBlCcbLYC9KR?=
 =?us-ascii?Q?mlqkkUD5eKJrIjQmhIW3j6Mp+uPEvTRdnpfzIn/B632F6RPOMM68TPNbXxo9?=
 =?us-ascii?Q?UQQtGU+GokjuCMTEOv8QaUpREH+vNyvjwiI1FGKql4zgCb5USWQrH5FuxDIo?=
 =?us-ascii?Q?KxpVf2V86sQFlHhBfIKbRb+p6c/MlLf7zvs0WIJWHOOU/fluU05Kn579QwOU?=
 =?us-ascii?Q?zNJBjZvSxGPop0fsD9GcUxlJ4kLp9ROghNtCeTokW46Qzn8PXrYkXYtFgrj0?=
 =?us-ascii?Q?1mH1XAMdAnI1ARW6yKhORYInmIVePk6WRGZF0LGVQIfNFJPyZ7enS6WuaXsC?=
 =?us-ascii?Q?fYDuoCs3PZ0aOcmUo3Tq8d2ZcyHcmH0J2yUNyMCrEK1zjFinYvD8jSMM8VS4?=
 =?us-ascii?Q?hSbujntTiWVT4VhjuQNttNYn1E3Vt0lB9AtWK7KhVptbiyTO4OkvCaky7ufA?=
 =?us-ascii?Q?+7uHf1DN/RodDc6j386QsgTLTubkHNNPPlPPpCmaWSqoxmJqAxcGIGjARdRE?=
 =?us-ascii?Q?iC2k6XUyLUM+nqaL8UIPnTER2B8I65S/mLmBt7SgDrV6mUpX+yq9rnI/yCVT?=
 =?us-ascii?Q?sgI9z1vDjIvDAwAC3N7pXydy3QyOiMzn7UvyHEgzgCCsAFA4m/meWaHMEHDN?=
 =?us-ascii?Q?XkAy+N72kIZ2rqsonZvq7lSlBBXv2N78awXg4VWy09xKKIQh4qROOkrR4SP9?=
 =?us-ascii?Q?mNRQ9beXNv/uSEkhOZPG2s3luPQ2zCNuK/eazOu4E2Z9ES99bgQxHcBIbd5Q?=
 =?us-ascii?Q?kil+t+ep3WX6E+gnH9ovzk4jPSP6CcsOe5RqiypXHpkI48J9B8OowkM+qSjJ?=
 =?us-ascii?Q?XbbD5FumWjsBWl+356JLoorDE+A6nciTKUBUoJ8oE8VEB4tzEjyVJPbn0rxB?=
 =?us-ascii?Q?azKuUbJz7KXeb6x4zujL/0S4LHLBq3z4VxBCPe9WVkydQ+7SD7X5LSj6XhU3?=
 =?us-ascii?Q?J7tdg5cmjY4iLwWUZeXii8QdRGXKzcy/x8Vp1t7lvhLKcGZnJlKbghagvqIp?=
 =?us-ascii?Q?lkhuXtuuRkkcnAWgETYly1TSAQdDwa0LY81SSqK/t4xum7KLzLmcXz9DZFCn?=
 =?us-ascii?Q?QpJz51O0sLAhRa5QRRINxuGTjuFAXUt8wlX4GeG8iRYeqMZfkeQbacREaSjw?=
 =?us-ascii?Q?yWVHiT9GPeUf9Ydfqzw4d5ecyZd0/LsCdzCC+ETPEWVNRLFaCsnm1IGrsE+K?=
 =?us-ascii?Q?8eKU6X52o3lsidyJhChYMNJlImUMj3NlAIOa1TXq+8iy9qlAWvrrem5KDt1r?=
 =?us-ascii?Q?h3BE4zkxMdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzj8XNZ9Zd6dePcaav0h3BbtW0xTuIsps6LA7ISt8U+yEfz3J7PuOyNq0bPa?=
 =?us-ascii?Q?1h7hy/HzyTnxYctBpfZOLiCZVKoVhjpltKbBvMtyUR5KOifyaevOTiVDwrya?=
 =?us-ascii?Q?YikXVvQRZgoSB7ZJlNUpusOQd+5zQ2MKi3EsFMAr+yFWHjke82Pdtnwq12+5?=
 =?us-ascii?Q?oSK95GHFWWBKODSXVUWt4PtC+jMXlu+AkJHxrVI6HM3wNCrCREY1BPXXEWU9?=
 =?us-ascii?Q?rOPkQ4mIfvZtvaoALI7rkXrpudNXnWU+JHHHeo4mvD70tJmNsMznPb9qJhvf?=
 =?us-ascii?Q?cjvXEDGpekt8Bx4K4zgq/CcU/Jfl2CWItUmHVUSejPui2Nh7qFfGITw9HKQT?=
 =?us-ascii?Q?KYIvY6KXp4Xb23ExCJMCBxdmFdjEQx41naICFHqmZk085pWGcNhoFS8FjA/p?=
 =?us-ascii?Q?bgDvVitrdxC3tSO0PdJURKWv4hhzN30zU9R3WjJrfuDHYOudn5jMQjxzQPuh?=
 =?us-ascii?Q?AQyidpab1SRQtkabM2w6k1yAQNDG1ky/PscRyYdoq80RSPdiMpV6/ml/rVAn?=
 =?us-ascii?Q?1jlKRId0y5Azkapsw/Bonooac8SyA1sIHjZ794yB+1JOzkdUcjlncPvtENMr?=
 =?us-ascii?Q?mvDlmEUuKkPDicYBwCVC8rw0Ilh1IpDNtO0a+ubEGK4uG0ngkcmgd2j0lwId?=
 =?us-ascii?Q?upjpqlQMfFVQuC/unvG+wWCOr19aMY8lIwZadZV035pKgDshQyUfO0tHNe92?=
 =?us-ascii?Q?0nIHmyPl+0EAJPKsOC92aj76P2NRIqlGEwmnbILW9M3IF7vEuKZzdREyAT6w?=
 =?us-ascii?Q?cDaKirFVL4BAs0kuEtCxXiWE+6YK07qTqXC7gMNHrDOhBb0lT0sWYmuEZ91I?=
 =?us-ascii?Q?6qf4O/OIuZAc6wj0nerV+drpW9/1TeGbO+slJlfTayAa+Xg1iYPO/PNscyaX?=
 =?us-ascii?Q?aaShLGLrk0w8qrHoLeeC44PByzovx/k95qJR5aL3wNvTfwRtc2kIVLsfKmYN?=
 =?us-ascii?Q?lRrZoXVI0Wv4Mx5fZ2eFZn22Ao7/MhQvzMzWDYNrCBiV2pweZhiljMA4hDzX?=
 =?us-ascii?Q?MNMl6f7iMp+R1t31vxoRfPnEOAAlKj9MGxBhod1rvK22ywB0uy2NTVejf37M?=
 =?us-ascii?Q?M0LJatXaFoG0JYyQy0uB6yh4ZAkgK89rJelQpL8dV3jmuAjbKdA+/GphI8xe?=
 =?us-ascii?Q?5+aSYoymT2JV4Uhft+cq7Qpq0+/zvQuud5yqtPWK36WUdT2VkWzuqjVNWE8p?=
 =?us-ascii?Q?GSyBU/GOktLaulIel9dcI5ebbpdkI9UXvTtXpHuaTXfzEEYzHpH4atE660Fc?=
 =?us-ascii?Q?mosZ9GgEvtqAGcA84wIWHsMQbrAAy24nA2364AghVzcQAcnKEG3plCGZCYB4?=
 =?us-ascii?Q?mYf80RZ2v7NL4mJGTCv4jtNQ6uXIiD8MwP91m+D73H2IArv46OF3dvIDlkze?=
 =?us-ascii?Q?69JvPA7nBM/aUR1diPBhR1PraReU+XQ0s+6alesivYmqGG79doORGOFl3kmZ?=
 =?us-ascii?Q?DcnYIJksfg5daKumuDAb7vK07VLtPStMo1PVHw4krHjYlGqnDmLNTxPbCpmf?=
 =?us-ascii?Q?VZLleyNFSoYfmmJ8DM//NJ41NtIjsCuC8i577LKWg+avTnmVyqb1j6aP3l12?=
 =?us-ascii?Q?3L0wWnVnJ7beDFFgaQw1o/xSgOrhDbiCNPgrefo0rlmSDXrRKLmVa2+Ni0qQ?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b07bbd-47ea-424c-b107-08ddfb71dba1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:54:19.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTKaGukl5UQWbQhop1F9Oh2vRtFA3OuYo23uvOFmUe6z9HaMpFNaXY+XbTf5aM1C8tyO6F2tWZ3fr/MDwQsXR7QHEZjmD+iA2ihQLAXODMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8376
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

On Tue, Sep 16, 2025 at 02:21:08PM +0000, Ciara Loftus wrote:
> The iavf PMD does not report the speed capabilities that the device is
> capable of in the speed_capa field of the rte_eth_dev_info struct. The
> documentation incorrectly stated this feature as supported. Fix this.
> 
> Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini | 1 -
>  1 file changed, 1 deletion(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
