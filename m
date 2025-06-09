Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E4C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA39C40E43;
	Mon,  9 Jun 2025 17:46:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8A6034064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483966; x=1781019966;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5QphAr9BgHdqeJavCaa6nzLxyD5xfhstjI+GyygVvfw=;
 b=aczB3E4nXJsHFUxsqY8hmm4pFMs6LZjeCLFXrBz4XA98K3gSIGxJ8LKT
 3/UqdWtWR5YBl6Fk2MaX0pS7XhMgwAOoDMN507KmCr54Ibn2Q6NJtE5St
 Dw1xJuI9Cy0/U7oMmnB0RHAnIMlQuB/BPe030wiR+86tuxQ8LrmivFSRK
 aifsLuAnoy1qPnAUm+86LOrcZ8tK9Wf4NrNREm+kbdHPr6EfrM0YSt+GD
 2LtaTQVFJo3ifmwECKtMo0zYpDwoq/ljpOgdBeCAvRA+9ewZrGTfswK41
 uJprVDKcO6PGM6JQiB5Li0oK3/x42RMwCdHbhlILNxKog8bYj4cxDZUMV g==;
X-CSE-ConnectionGUID: qUUSprZvTyWCHZVxzX/FJg==
X-CSE-MsgGUID: h8RWJ+0jTq2+hFNX9UY70g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62182876"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62182876"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:46:04 -0700
X-CSE-ConnectionGUID: 1hXMU70LRoyXdjfWy+VhmA==
X-CSE-MsgGUID: B6LVplBIRQezy/rU8oa9tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151548383"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:46:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:46:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 08:46:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 08:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcqdXpGVP4OTI4R7ZE+GLSRyQzWtE3VR/t0UVEWMv9EBIWDnQpjy48EXjEdZCdjcptkxhK79JqHEr2WRoTTmaXJov1bNSQZyJxVDnrVjfT4q0JNJXNRdFEJf+z418J63NNsyAI4xKr918rSW6vj63cM+cdzmQipd6u7YAOqcI05U9dKSVej0vyx6gW0toU43Ar5yHxu7rN6tMX8iozbDYRW6tCnKb23j3ql0N1LQM/yGXHmu3W2Q3wfnT98ES0PmoH8v5tKaZS2wjFEszewHGujE1pmLuzojQS+7yIbu55Wkj7EMQ0s937LLrqY+FNXpHDzYi1da49LKOXe4FLdmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQwUgxUp43wsDYkvVlJi0In+1VfjnxP5h1ehjrqLi+k=;
 b=gXi5Fen/70WG8Q/iaAjNyFCXG4Jzu61uzabMaRmWciU9A+jqdyI6nnik9IPrmwEq13xUL1F6cdpBw0o5fYb2AoikNmXbZnWgbxw5lyuE8bCt94vQipcGjYWkMxA78M/UafrgQ14+HPkd5wJq+Zon3Dz/iHS7BgiKwdwM4SCRAkU8WHWabC/fBbeO8UegJLXHcPbeu9uym9D3+ofRY+GAM+ZBT/teCI1cpWsUjkzBriO41Dv2WxGQmCU3hZHBr2AeTjF1VOGZNoadq9urzik41tMwIH72LU2pTSb64ohVBlJZhJiqcUXXD7NrHlLETMXkb0fCQe2CLn88/wjVpdL5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 15:45:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 15:45:58 +0000
Date: Mon, 9 Jun 2025 16:45:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Andre Muezerie <andremue@linux.microsoft.com>, David Marchand
 <david.marchand@redhat.com>, <thomas@monjalon.net>, <dev@dpdk.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH v6 1/1] net/intel: define __builtin_add_overflow for MSVC
Message-ID: <aEcBsLaaEqJpz62-@bricha3-mobl1.ger.corp.intel.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1749134845-30062-1-git-send-email-andremue@linux.microsoft.com>
 <1749134845-30062-2-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCCB@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCCB@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0206.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 310b9011-e0e2-47fe-bb9a-08dda76cba2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TMAL+OREh7Z/PUNvAyHdWpE56BswC/dxV3JdwoheaGwgyLhkuaJJ/IKU+x?=
 =?iso-8859-1?Q?QEtq24mnwfX3IqxBv/EW+tvpwgxJC2Dpm/TKH0yavC3cWsv0Wj7PsLATg1?=
 =?iso-8859-1?Q?BBjRgULk1EsxZDtBhhyvIZcTOXskWVUQ4Rz9an9dJXIRxdHRBvUIWQBKYj?=
 =?iso-8859-1?Q?gyQMQik5Grdc6/eDlKgykQ6Wpt9ggAHzroZTdoTU4+/q3Gd2WLcA3iboQH?=
 =?iso-8859-1?Q?Xli5H7jDIv4caa/A35xoYqXiKG42JbvD8McLrvdoEiDaaxURI8tEB0hD9C?=
 =?iso-8859-1?Q?vQIbmbLX/FKnDtNUgyBBaAnT/PA2rxo2W+Srloj3qqxn2Qfmq89zmgVsnu?=
 =?iso-8859-1?Q?0jbtlM2bSFS7Q1+Smy/0RjAtBRAbRFUOht5MqN/m1rKOhfm4Mab/L+TJYC?=
 =?iso-8859-1?Q?/+tBHR1bATt+7So8IVBI15cM2fUYDD5MKEwfGdCkGKRrIUR/YuGv/dwS1h?=
 =?iso-8859-1?Q?UhbibGulFyD5aDJ/zP09qT6n8NtDLn2rYbfx6Byt+474GI7meFjtUyOxfN?=
 =?iso-8859-1?Q?sZfUYw62PfSBIhqWBEwxcFf3XlfkmVPcpgdHtFtG5LsgB2FMZiSPCJg3RA?=
 =?iso-8859-1?Q?afB3UvX8zEsW10WLkpmzdhsakfxGxWk5VZAlpUcQjqtfWmqeetU9md2nAs?=
 =?iso-8859-1?Q?p2k5JoQNpWRBD8SYisUhVpDwp+1J/kNAgTqB1GJ0047OMfsdlPG+y/cogD?=
 =?iso-8859-1?Q?ynq3i7yfnss3KYM+7q0kvTJ5I/xV6jR2bq4sA0PYu0PMTCexVEQSRL5Odg?=
 =?iso-8859-1?Q?gRuJobatgUvEeZwUNBUPNIZjqKW+ZIQeoUBLJvXncPfTC2epW7mBs6UKpr?=
 =?iso-8859-1?Q?NiCBQ/MxPnb6p+O1xV4Q3UDKVTWWK66C6DZm9YT8nfmLtJtHkt41lRHxR1?=
 =?iso-8859-1?Q?JK3KGaSZrLMXE42Q0KHEvwQMPr+7q3PxCej4bH+fohkU1lj4MJ3AkQ2aft?=
 =?iso-8859-1?Q?2+v12bU4kcRTjvx2Va0D01m1BwPDXAf6XN9WO8ljw1Wma2FCbQU6zGGmko?=
 =?iso-8859-1?Q?1aYiXTJGZlLxcWgf09QBruXu1QrShXt1GZEKOAvj6jZYsRabfl3t6MuBa8?=
 =?iso-8859-1?Q?3GVrsy7TB3cbkHYTuKmuRcL/W+zxP403yQhIwPYSfAH6CnPZsiiU2pb8Y7?=
 =?iso-8859-1?Q?aXerb+C6XYTq6eDR0jySKtqPk0Hm8hXZO32kF9RC93KYqQOI8CWhq2XwvU?=
 =?iso-8859-1?Q?VrrQX1i2ittBh3ClaMFQjx7Biua+kN2SgXomCEw6B+9Q51NlOiw09tEtBr?=
 =?iso-8859-1?Q?I/Y7RY1CXwrcpzEq5JBsva7Xvjj0GqUS8LMLRz9JLjZ48o6tYIC6d5jooH?=
 =?iso-8859-1?Q?ouFNzFEurdUF/WGnqA3ntv8NY3BCAmHaTSm+P0zwGyE0MeUtNfTBDc9JYp?=
 =?iso-8859-1?Q?RR1neqCs2wtYoEIik+T13PQW3uGjYX/vaKKyd9ggFpF20Vs3by+G3cXiEb?=
 =?iso-8859-1?Q?wwfzi4VlG0CsJs8rqn1TJYJyiUjTiWQWDxGGqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?laFDbr8ef3Xbm751dWCrOcwDIvHzYeLlfkxeCcZTmqlO9cYsNeQYzLeE4U?=
 =?iso-8859-1?Q?ShmgRIbqb6uU59fkOS3RXIBwwfbwGtFRoofcrOPnadRg4oQaBkeRLjGVTe?=
 =?iso-8859-1?Q?6ZPWMAkuIv6tvP78r27bpskaQnic9cq0srHweLUCY0T0dnELSu2LcaU0OK?=
 =?iso-8859-1?Q?anv3/5mq2UKBnPMWgQZgueRIyamXv4sIKanmdvABc7CCJHhkt6u5WRVU80?=
 =?iso-8859-1?Q?G45LAFKPlY89Qbj3z6t5uOwTi7kdTLnAaPAa37s18atRbEYiqYb4pngQ7Y?=
 =?iso-8859-1?Q?4/UO2QZua3z6JeqmjesT/ioqgM4RgXt4fQ2Dk0WXOAk+x13dv43AwylhCD?=
 =?iso-8859-1?Q?QOAn5gVIlwYPsLr+ugEN72twhdpcrmc5eMNO6QgQlJuyDFHMNIaKZIpozN?=
 =?iso-8859-1?Q?kXp5whQeA8H3ysNj/5n3kFeGky449eut87YajxIm6jaGadlfJqms4yvJGl?=
 =?iso-8859-1?Q?vn0goER/h+1neHQ4wU7hk10vVIiux4y+vB5TVWTXdJ1dVL+SwgW68LBrGL?=
 =?iso-8859-1?Q?tla607tmDBAywqC1QfpfrJwcsXW9vRr5nNi9vz7bolkP6n8bmS2OTL5PaW?=
 =?iso-8859-1?Q?xNjkoFvBRj1pjHQ8PyQoQLoBkxklJJqbrEGJRnDK13kZKxILlHO2DXeNWh?=
 =?iso-8859-1?Q?dCMpRQA47gEuFegDp5ojKAgBllwI0PIyEHUm4wyjRf6Ra8TQFcjs1n9t4U?=
 =?iso-8859-1?Q?64J7CV+uUsobGNJEmGFYeSkZ/x2b4HkLRqNBvfWQfpsv/grl8g39E7zuDA?=
 =?iso-8859-1?Q?cYIqLX5OHySwA5X1HqFcakZl12QRDSRljCm/vEQDChIeLfCyrCLlIYWODF?=
 =?iso-8859-1?Q?hHp251j8c9EnB0bu9007dYDsk9sJUG9ABlZo8pltFU4ofQGh7TSx/tZVC9?=
 =?iso-8859-1?Q?+bQLPGXNu67gIs+xJxN9Y/jxZ/00HWXLu64dNoN1vFCI7MH98X4P2QDw5A?=
 =?iso-8859-1?Q?niv4UsdE529Sz2X/Tsey4N7e0EF2xhVBmeIjZ6q/zSOe4KGi6ClD7Tzr3+?=
 =?iso-8859-1?Q?rHgSBfMH0Z914SkNbsOc2VsxnBzFyqsxgpGSMyNSiYq7dipdHlgwOPnquZ?=
 =?iso-8859-1?Q?heI0GeTYjFRO0NwxS3BuM/DPREdEAnaiAU9Bw9or6I/Wom5BI3ZUe9cuQf?=
 =?iso-8859-1?Q?ip1l76s/Wky41yTuwTnDJAy+vKlV8GTLEaLCw6BmK7tw3L3Km9NvBWGOVV?=
 =?iso-8859-1?Q?iM9p1SgaA9nVPUrenLZ4kAWvmYOxZ3ZIgdePrSCzfyNqfwRTGNUfHrSzfq?=
 =?iso-8859-1?Q?Q3vxxgKV3PKgX/I6NUnQQYwpZRdFrvbK4YuA9n1kLlede8tUL6DMRzgv8g?=
 =?iso-8859-1?Q?JwhcxBt6mw16QePbGo86PLY11nUNSK9NVgely25I7459JY1vzizkFf/69z?=
 =?iso-8859-1?Q?bGGQWOj9dvXIGLRnPi0+7GB3Yb/6jBhPS388cOS/P3zRi0bj7QrCR1Veq+?=
 =?iso-8859-1?Q?M5Fxr5POmwgUXFfmKGEauSEWwoQrRM5euFS60v3rPCH4N8S2Zj8nccpUlT?=
 =?iso-8859-1?Q?YRmOqyHX7Hb0zwdc785sVoQwi/5sLky7PaaJ5uj6KvnBKVKEMANhHQSjkJ?=
 =?iso-8859-1?Q?ZAmWlXtfxDr7ms0ShpjLZDQKHNtHTo0j6pHfFnEzBVRlS4NEC7dtXMYzbC?=
 =?iso-8859-1?Q?/GruhicDpb89BbEkRK29VvPEirdIFlYEtFU+8QbeHSUSjynM7SruJ44w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b9011-e0e2-47fe-bb9a-08dda76cba2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:45:57.9727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxAEOqH10iKClr24HAIppchAm1RW0+hPZ5Rxso2//8G3JkDQH4ADt4avqHBKK1p/jAHm5gYXL6Ib3+wNDQjzqLVpGFsb8wEXx0T6uCImNSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
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

On Thu, Jun 05, 2025 at 04:57:24PM +0200, Morten Brørup wrote:
> +TO: David and Thomas, were part of the discussion
> +CC: Stephen
> 
> > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > Sent: Thursday, 5 June 2025 16.47
> > 
> > __builtin_add_overflow is gcc specific. A macro needs to be defined
> > for code using this to be compiled with MSVC.
> > Since only one driver is using this, this patch adds the macro to
> > that driver only. It can be moved to some common place if/when
> > needed.
> 
> This seems to be consensus over adding it to rte_math.h, so:
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce

