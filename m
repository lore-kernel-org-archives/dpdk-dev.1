Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BFAD3C92B
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 17:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 536DB4028F;
	Wed, 10 Dec 2025 18:01:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4082540285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 18:01:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765386061; x=1796922061;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/pHfvkUhhCH9qBU789x+VSwcSdBwgnLTuzh9tCdrENc=;
 b=UnFsZ0YsaFHkIcqLU3Ttt9Pzk0pfEvkbWK0lcLuRky+q6VZ2wpnsSHKB
 OFRJM1s9LlK6iXPOVd2ICEAzUicCLbi9qwplZS/WqJkFpKrybK2ZNXA5u
 yepV0Sei79ktDky8E3oq8ig/Phf8p7oAEzGqzoCLva3HgPsDq3N9xBW+l
 54th7ui4Z8B87kTAf3zp5ESu5FawpoPH3+QdQlfiHI3AJw7FXwQZDr0D+
 ryzfHOay2AM7ZsgxQKTtpKzjvMnOLpj+Ug+CEh4R73ce3ss8axOThCg8K
 nHLVcC1nyTluAYggU5R+3COsg0krBA2fcI5IZqN0nmnZqjyi1W0IiYXNS Q==;
X-CSE-ConnectionGUID: MncBJMO9Qmmi6yueAAeQUg==
X-CSE-MsgGUID: wRpytICtSI+67MkJFyS9lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78058971"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="78058971"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 09:00:59 -0800
X-CSE-ConnectionGUID: Oh7oPqszTciEIdwVjgSYJQ==
X-CSE-MsgGUID: n3r8SniPQtCf2SXiuFcNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="201483348"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 09:00:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 09:00:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 09:00:55 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 09:00:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIHmjbHkgOx5w3A3/3HNUmJa+jAK352777huX0Mykm40NtiuzTZCMr3CgECqW1Vc3WcouCKOrqHZwuVunXe0yaWfOlvo2Yh8DuN87ly4YsenwfA3fLH64FF+x/gkz0rRRWChc+lhU8cFSTdGttj28Dz8iTCsRKUjETKRyQfxn510WNJqj/cmrljK1c53CWl/enWXPTSABss9L/N4UDCpuUjCfnqPC4C5X81sn0l4wexSLWlW56g1uRujs4MyOBzWbwKeg9liocr8WQQpWl/Udpa4qCspc69jATLj37wqKE3J9xfzR/7HHJCHbBPIv5ZQ/A21F5+Ercpj8o5AwNZsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbu5BqiwQONxgdTMKxq3XiV+Xu76aN8fbunWRSKys5A=;
 b=jiMi+eWcB0va9VWdpuoGDWp1pCIpehxmdqlpEFSL5kGHzyiFhPbDFdCQCLQh0V4oNKDazvic1A7c/4kRvJXKHXGfcckUKpHw75O7zBZ3g3fNdwgARO49tJZneF2lxg5ut5PTttxLvmgmXOY7aLnCZrZ10bKcMJbmjY1yLSfOEO7DSkYqXgx6vWiVTZObxx3cYU8ojGQdr06oo9mVAbLOB+eu6ssnctZHUcrQ3lYPtF6AEb9HKIhmq194/oLStqHMNP5e+JPOytLfXm7zrj/TE84ly4uS560LfA/QRBH5EFHjfxekK7pg3CKv1A6JNHB/+qmA4E0Tiuwq/8mGj6xqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 17:00:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 17:00:48 +0000
Date: Wed, 10 Dec 2025 17:00:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] net/i40e: Fast release optimizations
Message-ID: <aTmnOwyh2u75Y3qp@bricha3-mobl1.ger.corp.intel.com>
References: <20250624061238.89259-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE25@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE25@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:8:1::44)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 039bcd1f-080b-4440-a1cc-08de380daa56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6tPInw1CG9Edbot0BTcCUiEDQ4HpYSZFGZTILODbuh8R7q2exnjn0T5cWW?=
 =?iso-8859-1?Q?VR8A0R5ddcxCv2ygVbEeY+REyfhzMB2FDQY4gCajlMU4XbhVGM0r75H7zc?=
 =?iso-8859-1?Q?8E+KObzRBuCU29sDAzdja+VR5tW9sKzi4jKI5vOlpd2vVOY6oPTLcgn5Wv?=
 =?iso-8859-1?Q?qzRn/KDFGcqi1cy/8BawLVdG9RLiV8Y+T5UMktpj4Si6rP5Lh/5kVwbrBs?=
 =?iso-8859-1?Q?iM1NDGiFo/vcsCsnPncThF3ntQwf/TNGYGOVgjZ65+zjDTP8HooWKg797C?=
 =?iso-8859-1?Q?ZN8b5F+erDJ0+1AM43Chf1XmrTiWMuCd1THvanwqmDPCyadvq9iR7U7kvM?=
 =?iso-8859-1?Q?fn90WRKZQqgRE+DEtjbVI1qjBYiKF9h3o2WGFyzAGtdzln1ZM0cei3UeDs?=
 =?iso-8859-1?Q?iMooFVt3rw+d6mlqN1ANkzNQGlUM+eD9jDPJMb41QuYy5+Gu/vA/I20tUU?=
 =?iso-8859-1?Q?zOiky0sNHrahKzD4b80YGNjSz26+9qfUHo7RlAO4f55GWmG5NbPaOhyH5/?=
 =?iso-8859-1?Q?pT8cw4K/b8kIQJ2D7m+wubvEPB3AvqoG/SLBpXc0jVGbJoEjZpcIc0busQ?=
 =?iso-8859-1?Q?preCN9kjrwjjEEoKPhYShYTNbNkAEkBZL/ZeRkXkyjSAxyAgVtVvcDn4uh?=
 =?iso-8859-1?Q?3uBg8/TRlEiCqo8eC12ZZD/fGHL8lxMGA0X0EChK9ibcuR88x13Hg0hmsl?=
 =?iso-8859-1?Q?UnqjEf4F/SiVEwDlEhaMV3lGzKM3Y8U27Vo8in506WgCxHp46/IDr1X/Yl?=
 =?iso-8859-1?Q?5cSAqacUrmYJU59J8qtt3bo1oIaOixPnHyN+v51+gnv1klFH7pI82ybrg2?=
 =?iso-8859-1?Q?cIoSze9UpUBkwMH6S0+E5MKf5p0CfDNPUD1h5JN2Zo4SwOaQbuV7zBZm87?=
 =?iso-8859-1?Q?e4h9eZFefAnMHv/MNHucn/a+DvQ/d9GzABeBJPn7p72cH4z1MsptLPHDLe?=
 =?iso-8859-1?Q?R466W8qYG33bt+UPjAXBvIdVKm0NevdBRWfb9JEFnS18WH37km1Freyjle?=
 =?iso-8859-1?Q?vX6ncH1JCabKWuBrqPO8BxxEBvDh0b4zRylrW4HLgVq+pQdaRGOmbmI4Fp?=
 =?iso-8859-1?Q?PbxW1JyX25uWGzi5s6ImaLRbEOqonr29gqJQoGjzriFQJTz6huF2/4ZeiC?=
 =?iso-8859-1?Q?mYjQgIcNyrJoHm0x6Tf4WZ094I2IcYQDEqSYiR+R+XUz1QJ654zxbDtTXs?=
 =?iso-8859-1?Q?PcqthWm63lRgDJcVkvYII+MDDU1WYEP6F241qFktE3Zsz14YjGY/2jiq8m?=
 =?iso-8859-1?Q?/8P73/+C06v3mVVaYJ9cKF9qFNWx7e8FY/C60G3p/juUlupYlkuPxWNMfd?=
 =?iso-8859-1?Q?T8ZzjBok3BfumzH1xHEHP8WU6Wt6FUiLJcvLl84O0fHMQ892AEQaYnp8n2?=
 =?iso-8859-1?Q?ilHFfMsEnwhbBPmTbpFnTLrKHslxFESC0Hmd/R1JGtVy1t2RXN/jWCS8Wj?=
 =?iso-8859-1?Q?7NHnUTqBChiAMEIhQg0E0vFiOCh9drDQVWIJIa2uPX5hhJAeB/3SVv9yZ0?=
 =?iso-8859-1?Q?axqSkYKD9Oej/OnIwrDt4a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ggdxsP3EK9BWfsFkP3OPFXJLwHePv0p0PDmAOY8JaVpAOtQrkupAltRGSR?=
 =?iso-8859-1?Q?2dhQ7XaYHUhErSCjZtLnGDo/6u+eX/Zp9qDGfSaC6Sws27Ed9Mwu8PJuG3?=
 =?iso-8859-1?Q?zDkepODH5RH6clIYCLmP6XIGTE3SFwwr6XSusf3sZHtDh2+4GT9DPd3hUQ?=
 =?iso-8859-1?Q?v4pyqgilVrppqxTgOUge2CF9zJDhueZfVYd+R2YB9laer5jN7lcXPvxikt?=
 =?iso-8859-1?Q?1Is/Ao3pGZQMuim3XLsmaZsmBftfy3bd2U5+dm97UAKszk7P0wOo/CoyJ4?=
 =?iso-8859-1?Q?OWRZKBWeGB2cF7+G/cRRq06al9+s4lXDy45aS2eWtRr2AlhToPHqzWmMSa?=
 =?iso-8859-1?Q?VXXkeM59BgkZQU5ej+DnZCdzT0dFGs0aX4GacPL4cw3hFisB/jmxNJXYoZ?=
 =?iso-8859-1?Q?A8+ccuTK18u6ibDoejNSoOiLMqgRLPcQuLH8+tS8rrMPGoi4ropsiZNUgT?=
 =?iso-8859-1?Q?iNav9pNSR4rSlrXDtv6vSEFq0IndRa1ucotu2QXUxC+j/2QeT/h7QZSNU5?=
 =?iso-8859-1?Q?LqfJE2KON/2Oq5uRRJiU90KBbC9L35Hu5VpvNiuf28pn/t++ts8gDmhIlB?=
 =?iso-8859-1?Q?YhDPEP8THzQzKQ/7shQH9GXzyBGOYqhQqcksft3WQ5IqhaKE0UyTEE1CEG?=
 =?iso-8859-1?Q?sRxJhL96ncqXGVEbimLgkxcZKdfkvi/wFgtIhOX9n5AvrMzKpvW5nlFAfP?=
 =?iso-8859-1?Q?FbNq6Mcu8uzlvF5jNDcg9aoQq+sIwcdnG8tI8RuVGJt0v2eA+hZXNZEW96?=
 =?iso-8859-1?Q?rpyamqB5sHU5juRl+YxxXjoLG+d5Cv2Ug5432i7l53Xf+O5OKIgzjgsjcB?=
 =?iso-8859-1?Q?kon1ORuGXCrr9tfBeLoo3oM/rjZ+2s+ywL3Fk7Xd6NRPrTS9PD3CgRXWyh?=
 =?iso-8859-1?Q?Jow44BsBW7rXLCR4PI8KJQUZrxQVFtt8VQP+6jS+WnrTKGA9jEclahqHbd?=
 =?iso-8859-1?Q?K5a0yBBtgbXiFEN1dXyxMeVoYEglyv61XT3u2Osgl47uVKMrzFTVz2fCqe?=
 =?iso-8859-1?Q?ZybB3cSDK7ymTfUXmnKtGnnVtz5HYo1Hc0xDBF6acpnCmw+7FLaDaTHcJh?=
 =?iso-8859-1?Q?LdCrTlZJmIxq/mhcLC/clAG2G/+MA5Znf7ZB3R6T4BGubN02e8MV4zYCMp?=
 =?iso-8859-1?Q?HofS9kzVm3yQX2tKpOvPIrzkukecKcC774vzbMK/y2chL5WhiiOWn0T+Wo?=
 =?iso-8859-1?Q?VLv32Azxz83/C8iKfuJYr6804MqfcM2Pc8jJoi1UOFegGVgZsuiwbHvqF4?=
 =?iso-8859-1?Q?Pjy6xzWiPsJOqkLby2bl0y2S99b5WamseHGj/UAexMKfjsTDh14+LElWHk?=
 =?iso-8859-1?Q?uRUuvn4BTVsZXWxQP2SDTU9M4UvdtWaLg+p/pUyXvxNpJzx2flLXClOyo9?=
 =?iso-8859-1?Q?zCN/VIq3lpa7wGi0ITsk8H5WEAFfvnzT+OW6HkQrv6CHyG7eChDuf2FkRe?=
 =?iso-8859-1?Q?FUdoJYPJkKgAKvcYZbJIdQupJhy91mQcA2JUyNZbS1Ip8m2NrzRIpyvFi9?=
 =?iso-8859-1?Q?veX1I3smuLL1IfT4dOuufhAO8GfFZ8KBtu4wAvZSjTyQY/dHf/AO3XY+G8?=
 =?iso-8859-1?Q?XZ8fMCXQi2KCGRQC2hY9GMfsfGPZt0dAo5A90WeXCAe2aKtY4EmWHJTkSY?=
 =?iso-8859-1?Q?LUCKNI1p4Bln8LVatFOgFrbU1VNk9LHZytpNHcE+/NSZq+NShMqM71ow?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 039bcd1f-080b-4440-a1cc-08de380daa56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 17:00:47.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12ONb8zpLn5jejoTaQAhgUwZsVF7FBPC5Q/qEboCebFt/t7/Z/l6DNiqIFCXA6cWtnsseQvSJisPwNlgrfWzZL6P2OFrZP3WeviRF3Uam9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
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

On Mon, Aug 11, 2025 at 02:47:17PM +0200, Morten Brørup wrote:
> > From: Morten Brørup [mailto:mb@smartsharesystems.com]
> > Sent: Tuesday, 24 June 2025 08.13
> > 
> > When fast releasing mbufs, the mbufs are not accessed, so do not prefetch
> > them.
> > This saves a mbuf load operation for each fast released TX mbuf.
> > 
> > When fast release of mbufs is enabled for a TX queue, cache the mbuf
> > mempool pointer in the TX queue structure.
> > This saves one mbuf load operation for each burst of fast released TX
> > mbufs.
> > 
> > The txep->mbuf pointer is not used after the mbuf has been freed, so do
> > not reset the pointer.
> > This saves a txep store operation for each TX mbuf freed.
> > 
> > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > ---
> 
> After further consideration, I think this patch should be split in two:
> 1. Remove superfluous code: prefetching mbufs and resetting txep->mbuf pointers.
> 2. Cache the mbuf mempool pointer for FAST_FREE.
> 
Hi Morten,

any plans for a new version of this patch (split or otherwise)? This is
popped up again on my list in patchwork and want to decide what to do with
it for this release. :-)

/Bruce
