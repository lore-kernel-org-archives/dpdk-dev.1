Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F4C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 08:09:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61A29402D9;
	Thu, 31 Jul 2025 10:09:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 82AC44025A;
 Thu, 31 Jul 2025 10:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753949358; x=1785485358;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qdy2uCQZyIZmsiqgX/K2epn1vUE7PZXr9xVDdyHpL64=;
 b=mWj3vsDBAvZxa7rziIuuzrOtcXJgQu8wRyIIHdjDplw/9Jff+QUbOsrp
 wYLXWnbbFHjOwTAKnXyJLYhazdeQegR+WwxXJimDI57MDVS3fStQzDP1j
 +9gMEM+QfhuzuDU3/cd4ODmcW3Zs3x4UeEIw5Pm++x6hHB9VuSiryZPtK
 K9viEvElE/ytXfGLCXiJ86eesMQh17TzPrB6VUuUvnOPemKXEgA1jHzUT
 /dWJCshQYZH2GSHLvJlxaM97Tpoyy35PX23o005ymaBu39Xl6ImuPtj/u
 iEKGkLY6X3rs/5+6d2wbmR3vd5oT4a0tMv6pp8yf1MEGLNbbKQiWjjXB6 A==;
X-CSE-ConnectionGUID: XIntxJ7AQTSPWBGlC4LzVA==
X-CSE-MsgGUID: jnF61DizRh+1BCu88lsWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56193974"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="56193974"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 01:09:16 -0700
X-CSE-ConnectionGUID: UskA7knZTmOkzTruHMv6SA==
X-CSE-MsgGUID: RXKL3ZLwR+K84OGE8aWPeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="200367756"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 01:09:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 01:09:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 01:09:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 01:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV+OAx3khYx2i8y/NVjgS/h2k7tqOrwr5cSPwLJq0+ONX7xbxc41lkxrh8/H5L5ahGTUUpKYLS/Ue7ApE4fUeyWKZDBkiY0vjufiCxQDAEjpvZf6Zp2qg74sEEaBGd7VAPijwZeGIu1MB46nvHe057tP0gshpflfjkwB2Zy0eBa2xBbNZq5x6REXUdHw+Z8+7wMYJBOJGsIIAzQiPSYvDL+R+osERv7dN7Xv/o5WXlt5/VVhX7muE4ou3e88hjRSP/xxVVx3yISNXhsFRIayRslgfts2hg9iWDsms7gHSZLEjTGXU4s2HViBi5Ll+Hs/pC/X6uzyLwo5bZNMzwEWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/51eXi9zkuNl+HeX9nW8gIPP8UZ1/3qtRe6tQr4nKQ=;
 b=K/1UXYsCFMrDzI8/UHEm+QVqPfm0U4Z8zmwvduCwtEwWhvk13xyBU7S0IXts3GfKf0jGV2rtEShs3g1GN4HQfQzjMJA3MMTE09vZIah16tWDIQHqkeyD0yS7Vl/Nd+VkOjxvSKDeKKhdo/7iRWV2lfuoT/dlme6jf+hZy29a4NeWPA8dXqgnjPm9TKF8gmuTtmt7uqbQtLkQQ4kNP5R/30EWm6OicMr+0cyPHrorzbxzyQvXBFwvb0MzRlXWLr83unXLgbMu5ud/S5WF/kY9dzbp8k6v12UNnMqzDIi2XkZOKQjv6J/hJSnVLhp6eC6W2/5ZZeg6qd/JZs1QftzAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 08:08:26 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 08:08:26 +0000
Date: Thu, 31 Jul 2025 09:08:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aIskdAXFfioSnPt7@bricha3-mobl1.ger.corp.intel.com>
References: <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
 <aIeTCX3KbnxIvDJP@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCF@smartserver.smartshare.dk>
 <aIpWP6FCcMXktUvq@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDD6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDD6@smartserver.smartshare.dk>
X-ClientProxiedBy: DB7PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:10:36::39) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: ccec361d-7594-4988-9ef3-08ddd0096d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?P5lEXTaxMfYuvuW5r2VuuCm8BedM+GDioLxwS3iYhttvnv4GgriZKQzo9q?=
 =?iso-8859-1?Q?A/ihzaJO+3Cix7xYjCbuL0LMY5CfVFU7BpEFrOaeC1rE1yBejoc/nS+LZ2?=
 =?iso-8859-1?Q?xUrUdLQDoqLg/nNaAJMp4cMkr9xq2ukxUhC/6Wvbd29ROOj3zhAlBDx5iy?=
 =?iso-8859-1?Q?TzHYTlxWIbJLmsZlJ7eYEII8MRye4MZBcjQ/K2kVFRoctCEFfB6rdHUpv2?=
 =?iso-8859-1?Q?Cj664tDDmQ2QGolTHKLvLyWWwVk9tMAZSBpoUXzLivq690FsvRQ2WrCEmg?=
 =?iso-8859-1?Q?1MkpiaETGGM1joHrkvUX3av/UW2hB7muCduFADYQv24kPbPVk1Cy5PmNzQ?=
 =?iso-8859-1?Q?194BCMpI/22nHdd1Ape2SqMhR14ER+DOzA071AjMaDnEhjNbm9bYhsDcNN?=
 =?iso-8859-1?Q?CA7hlnB/32V/+Nv/1vnQQnqpm9Av8LsYNkEN1OdnHaBl5ZV9wfcmE/wD6e?=
 =?iso-8859-1?Q?cg8tEo5uJqaUqy+Fjf3mvzAdwgdfO2jq+cIjGi/B1CqEOUhzGee7c34vGa?=
 =?iso-8859-1?Q?mXOWcgrd0IJXQMqe8ppCzaAAUdjP9VTOP9muKLNYr+Ti/KRxg0lut5nPc9?=
 =?iso-8859-1?Q?kj4j8EjvXLEXse5GsifnvPOLb3T/Xcsulzx5vr1LG/3SgSfklks37Keus2?=
 =?iso-8859-1?Q?2+Ex8WT+uPNIVe3B6kHEWwdDim+UrU7dDWzakA+2NDiPpd4M6PJhyaN6/e?=
 =?iso-8859-1?Q?zMLxP4s3vUWQ6aXkV0ZYlSsEU+Qrci73JsA5lQLmh2gymvvpGUFb0SVgnS?=
 =?iso-8859-1?Q?mvUWk5h6onlwOmvVPA56t20EypBsqbRlbR66iD9OjnO7cKrGs67VjMgCxI?=
 =?iso-8859-1?Q?MLCiZF07wDYL+4WrUnDY/oLLSsffHtgKsaQZoCbwUs8hbeXUTnyNZHA/OA?=
 =?iso-8859-1?Q?Pxll9DG3Fqd/RANQFkne/qBLOZ8tK6CzNa1C7MFtbRbM/CSGfTa5+SKOjY?=
 =?iso-8859-1?Q?/UKj6WOAmsIHEHAStsiiS28cL/ALkFmYVQSzomniiFqvs1n84Pr803M+TF?=
 =?iso-8859-1?Q?cT0QmaJjH/pAUCkdODoQzLC+XbOmi1831Ku4UHsyqnVMVG/dMD9w+oDuyw?=
 =?iso-8859-1?Q?QwzO+VFxI1V04Mn2AoBb+vfFu+Xo3avs0zeMmr1S7iRfbGN4NEidVwAaKT?=
 =?iso-8859-1?Q?zjCKS2PKxTWd/BxUbUlOq5UEDyI42ir7QpOBfk5NpQ5QdUDYFPyWZQVa73?=
 =?iso-8859-1?Q?FbvOPpNhbqO3gb+VmTFazMUqqFVXwqCj0FNTZz3eZYJDgm4C4x5sAL60JS?=
 =?iso-8859-1?Q?CmBWF3y49aNS9bhalmOGclTtnGsVUTZorM5jPqVCu+PNNxCn71vBrmL+Jn?=
 =?iso-8859-1?Q?+gmC6zaknW53Ay9fTdXAsSGVaoInGGw2ZRGIz4YWcT3v0jN3rGXJmanH0y?=
 =?iso-8859-1?Q?jndC/YuWeeIKghyNMkZw4lFx2IaTKQBOU56rWFdJsvQGo1QG/b5BwvGKev?=
 =?iso-8859-1?Q?5PnoskOB5hILtrnqfC3z9TFAzEZ9y0NUHgjEaM/LVoJJjv81aeMSmrr88m?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?60CTRM+Eota4NvXgakbZtIXECSFKqxyBKFZO7stK6iqXARQH/tWmK1wRqY?=
 =?iso-8859-1?Q?FUNGpvokKMepK5pVakx9ZgqD5e5ImAi8gIg2/ZPRG4Kdwo+14HjNdoRG7I?=
 =?iso-8859-1?Q?vu82BactNHzUlSE/MKVVVTr/QIk5LNAboSduuWiR19GQdNcF/qt51GgQMy?=
 =?iso-8859-1?Q?RrhXlycbsKnpCtC5Jd3jyGvtpkGWaDa4jFAi+ezpOjHL0Z0TbHvRmS5gUO?=
 =?iso-8859-1?Q?irCv6dO5hDkFKr4VNH/7XdPs+me26IFllRFkSvqsSqDG60vxeOoHxwYkcr?=
 =?iso-8859-1?Q?JYsGnNxHSyuMMCeUwHFODBUPUFszeNnKTUHv6/P0kBAr++D/wi/RUMvRnf?=
 =?iso-8859-1?Q?3HXEFvq+ucl4CKBx1ge4HL5hnJM8PkW6Ul9ZEfCvVkVyzPMp6ZeTJHai8S?=
 =?iso-8859-1?Q?hRLqmJxhChWhLph/bpZjoXtXIXfyg1D4LgUgeygZIN6Y5yfgdsn8GMpWkh?=
 =?iso-8859-1?Q?wFmwnNvkf4jza9666Q00yz15RPRF+QCM0P1iwb8WnVQTAno5ZWA10f16KK?=
 =?iso-8859-1?Q?L/o2rSSVrS6RlJAbhnXY6h1d8kqLr8+3L2HVgqdUyrz794DbH6E/75JRXP?=
 =?iso-8859-1?Q?iZG5kaUSTNWjoDHLQOZuW2O5haBzdEpcMc4BY20ixK7t3jGyFnUtmAPTMU?=
 =?iso-8859-1?Q?QX3wvHY3K98tjb1Xozl6EaxEIEqYnPb54pARAO1zfNXgwR6zULGjU69FZ6?=
 =?iso-8859-1?Q?jMFkHm6PPs2CmtVMPahP3c57W7kwpiJctQy50IDRKS+6b1bxZ+upjRf+Dl?=
 =?iso-8859-1?Q?n8IlhGSLShohdvIfUL05e26/fDRBS2TutI0c7SErKH8eeI5LXPxY7kAb0k?=
 =?iso-8859-1?Q?yJKwrQ/e3ADdWEuOMqOhNry9d4Am6POPwti8j+tsneFCZHqSX7nCgTca/a?=
 =?iso-8859-1?Q?4GD1jOslvQhu3d/VF5ykXoKgqY0X5XBYghU4iZ5kPwjWgTxNyHkr6gChk3?=
 =?iso-8859-1?Q?lbvZBjFbdAeYjqXmr6rRpwflpqJzg/IpNx38/G2h8Nj0qiQkJ9NwMuI3ju?=
 =?iso-8859-1?Q?UWtg/0r5zBj58oS9uQnBaZ07SM5Gwn6LqZyP4hlklq0i8DiPlAuK83caMY?=
 =?iso-8859-1?Q?k26E2+pyd9HlOpy4n9SPguyf8VbZW6fePTsqrhO/m6ukDKrbs3WzNov4jn?=
 =?iso-8859-1?Q?clTJfp0eudIAeSPue2zwRua+KLPFsCA1VumyhUxEeYjeLnpz6HiMhFjicz?=
 =?iso-8859-1?Q?M2ZJ73NV6xPn9fJCz+tvoDxJPAHJ8L8tw87v/MzRLlxHjTB56ZWNm0Ji0c?=
 =?iso-8859-1?Q?8NSMlhzTlmUA7VhzEOTpT7OpTIjjsQAkB/4pxF6wnAUBpK8cgzFyHeLbqK?=
 =?iso-8859-1?Q?S71gzvsJ5F2nR0Zgij81L1XLTzni/yW9JwDjN2h12Uo9mEj/PIjLuEGocD?=
 =?iso-8859-1?Q?WaO8OdgxSG4A35F/t0XexDfN/Sh6aLUXIqJcdvxg32Di5jcWyHcqJjRDfd?=
 =?iso-8859-1?Q?w17fLdoRDB3eVh5eNuwCE5XuQT+ndIRoBxZPbgqB8vpI5jkYXkUV+q3bO4?=
 =?iso-8859-1?Q?C2GeuptHLSBPwfxdtb3TkzzrdU9oG4uYp+z6qZaaU+Nf9Zya4H7RaEDN4Z?=
 =?iso-8859-1?Q?wShAbr4PzjGhmS99wJcgmO8phwLSsUZHGdkJM2jz/CMcW/b3ffMTphPX4j?=
 =?iso-8859-1?Q?7lh71+Q6bgLNW8FQjaF+kTwkJkY6wLy8vJAOu009bFmiZIzAv9bsnxlQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccec361d-7594-4988-9ef3-08ddd0096d3d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:08:26.5644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPhJco71sWanPKFkPlKaSdjyZVyKWiwu5lVCJT1c+2K8tKeJoHyLPhe6/xO4CZhdCrMDqLsU2zbWZxn+iUsk3hqkJNFc3P+4Y8XHAOEDvaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
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

On Wed, Jul 30, 2025 at 10:10:42PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 30 July 2025 19.29
> > 
> > On Mon, Jul 28, 2025 at 07:48:53PM +0200, Morten Brørup wrote:

<snip>

> 
> > >
> > > 2. For more tags, start by strictly conforming to the IEEE 802.3
> > standard.
> > > QinQ is EtherType 0x88a8 and is associated with the outer tag (S-TAG),
> > mbuf->vlan_tci_outer, regardless if an inner tag (C-TAG) is present or
> > not.
> > > VLAN is EtherType 0x8100 and is associated with the inner tag (C-TAG)
> > or simple tag (VLAN tag), mbuf->vlan_tci, regardless if an outer tag is
> > present or not. (Note: When disregarding the outer tag here, this is
> > exactly the same behavior as for VLAN in bullet 1 above.)
> > > This defines placements of the tag IDs in the mbuf and the default
> > EtherTypes used in the packet headers when parsing/stripping/inserting
> > tags.
> > > It also defines the purpose of VLAN and QINQ
> > capability/present/strip/insert flags in the ethdev and mbuf offload
> > flags.
> > >
> > 
> > So based on what you say above, having a VLAN strip setting separate
> > from
> > the QinQ strip enabled setting doesn't make any sense, right? So we
> > should
> > decide and document that when QinQ strip is enabled, VLAN strip must be:
> > 
> > a) always on - which makes sense if single tagged 0x8100 packets are
> > still
> >                stripped as you describe above
> > b) always off - which makes sense in the case below where singly tagged
> >                 packets are treated as outer tags
> > c) ignored - which is a bit of a cop-out, but avoids any issues with
> > backward
> >              compatibility for apps.
> 
> No. I'm saying something else:
> With QinQ stripping/insertion enabled, the VLAN stripping/insertion flag controls what to do with the inner VLAN tag (if present):
> Enabled: If inner VLAN tag is present (and outer QinQ tag was stripped), strip it.
> Disabled: If inner VLAN tag is present (and outer QinQ tag was stripped), don't strip it.
> 
> Think of a conceptual pipeline:
> First stage on RX (if QinQ stripping is enabled), the outermost QinQ tag is stripped, if present. After this, the packet has no outer tag anymore; the outermost tag has been removed, so what was the inner tag before has now become the outermost tag.
> Second stage on RX (if VLAN stripping is enabled), the outermost VLAN tag is stripped, if present. After this, the packet has no inner tag anymore.
> 
> When QinQ stripping is disabled, or HW doesn't support it, there is only the "Second stage".
> This is what I was trying to refer to in my bullet 2 "Note: When disregarding the outer tag here, this is exactly the same behavior as for VLAN in bullet 1 above."
> In other words: The VLAN stripping engine only considers the outermost tag (possibly after QinQ stripping has made the innermost tag become the outermost).
> 
> And there is symmetry for TX, except the two conceptual pipeline stages are swapped.
> 

Thank you, that is clear now.

/Bruce
