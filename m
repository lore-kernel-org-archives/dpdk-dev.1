Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95365CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D26D542D97;
	Fri, 17 Oct 2025 17:42:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 22CA742D92
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760715777; x=1792251777;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5wA55acFipu6j9dvoDdUf7DdXN/Ia+97xHVnCXJfuTo=;
 b=j/HYWQueXp/AicEnvxX62261fYafB/2vhP8YNFuc+1/ZJfqgBZLixVjF
 uYoj2LIP07OmchCbgJLYN3XnWMS/W7FCdCJwkVdu8PP+PF3+wC32C/XLr
 ZKxpDeumAkJVY1ASDHbTsbEaBIoW4BKp8Ykp1o0fbTEPgVBHUP3PIdkcP
 SOcLTgpZtAbvPzobR6Z8LLQ2SRNu1U7x6KcHYIIRSdznkvwRucmaBPe+x
 rZydNwjMw+ReSpM5JaFc9c/4Q3Fefux/K1K5kHtL9eD0xUX42cvHEVcOJ
 sRD96mYchddS15gEv35JfgCdErtQA4nxugyFbL/ZNa9PEBdY1E66pkvRg Q==;
X-CSE-ConnectionGUID: JqnrTHWYRcak2m+oOhjaFg==
X-CSE-MsgGUID: QjwiBsSGSsash6TL25tYyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="65545212"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="65545212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 08:42:56 -0700
X-CSE-ConnectionGUID: LpJO/PURTTmFAxs2cCiaRQ==
X-CSE-MsgGUID: gX0XBP3NQBi1izxwh6VD7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182458319"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 08:42:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:42:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 08:42:54 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQbsNS9o55wTNDbfYsgqHXUoKNiWILHJTXENG8ajsDMtJAbmSu3RruAFYD2kar8I61cJj3HEND8n58Jx2qzhs+csyVcifS+Pcf+dwrtnm+G1YIVyjTLktRh8zmAK2COsYuyyFK+QywasIJ7i8iH8fGam9TnAJQwWTejxiPgLdsERK9LrM42RlI2g1g1VdPpjwO9zok9bvpGWpQ+aJHw07k52ksRLdCpfT1OkzwNmc9Vwf3e8l/KFXcBJxOgSysbL9XoeVJjhgNpqZ/EOpt5kCfPOQ24ulxT8L6tlaODZiBbFPE9X4zBGTgQEyttZ+B/d/rlqOPQ5pyTJZi+SoJo6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpqxzJRc/ZTvPoxIGwC7xXoDWmx670RXeRAQXTQwgow=;
 b=DHdc2sad5AzPhLXZe6uxmlFvDyXjL1LV2zspeiIOaSsdAeZv7ReJGgzYO5H+hnf/IADYevGcmoDPj/DywXocAtslK1E7Etbq1YJqQ1x6cpzQaSH0F7wVQNhx0KtE0spr5lrCx8XyNdZWJutr3u4HQn2NjPRXfpqBiCym5ENlMtkoaqaJiELCz0xCfQv08WPOAobTDS5MLWyx+XiD8DOjp+F3MQmUuluEyKfkY1aPQj1OibYmIBxQx5voArSuGQl8/8C/zS7EyDeO+Ipi/g/fc0flfhKQyC/N1Qg7a0h8oGHt/iJVNFsex095VtD+ScnoDVLnP+iYPqVQFew+kMFNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 15:42:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 15:42:52 +0000
Date: Fri, 17 Oct 2025 16:42:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v5 8/8] config: enable comma warnings
Message-ID: <aPJj9xWY9FyL24ue@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
 <20251017150241.28511-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017150241.28511-9-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: c54a6b81-999a-4802-63f6-08de0d93d50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/qYYwluRfFT8sH3mAlMbDLFBNQcPUtqscV/1mY22OEjX+Q+5dK2BG4C2dC?=
 =?iso-8859-1?Q?qM0CGUdJ0Sq1AKUs31ZbaXnW7/8HIf9izdzgPCxAKlWdy0Wly1SrbPl7OF?=
 =?iso-8859-1?Q?qdwogTMJM6TG8RHFI+UgfAnVrRoOcjSAybw5uthKsZerUuGqnDTn08oQUZ?=
 =?iso-8859-1?Q?LZw+ddcKjPsSg5LtIFr4he9uGShR6DWJji3z/aTGLgWmzm9vdrKX6nkDQ/?=
 =?iso-8859-1?Q?FLZ6kJZXoXO80/VHhZOkzuh4ue8EHD+Q4DneKWIK0uDAl9077U1EGMnDuZ?=
 =?iso-8859-1?Q?lGTb2vlGNV3IpFSWwoWxi8NsGHhGsg3fMgV2+USHGzckUb3H9Tg7ZzK5UI?=
 =?iso-8859-1?Q?j4f1xd1tFt3qtd4WLdWQL2C9LwcuDIhmaoh8PNCMJ2ZYOKI53iZX9RHeQW?=
 =?iso-8859-1?Q?MU/rBL0FCmNI8dXCM8k70EcI4Ebqzc5zoxP1jeltRrjFgkXh1YHBGNVrim?=
 =?iso-8859-1?Q?QocWWAEwZsxgLvvKuPHoBToOLCbF48dtDYFCX/HmUetUvCAw+3iO+FyNJI?=
 =?iso-8859-1?Q?emAoXWIWHUBGzvulicXBPxNSvMNpVJxSliWTgkci1T603pMIrLTnj6vRsg?=
 =?iso-8859-1?Q?HJVWFekKIOPQZCoVOXo638JXW7PhilYW+hGeBNS1l7Ccqw7pBaZ18EixQF?=
 =?iso-8859-1?Q?ROymz3OCj8LoazR8tIdIUnvr9vZjnqSKEBu7IJLbSCsWQtzuuAYrOIMe+3?=
 =?iso-8859-1?Q?0JsCBKlbTDO6xsjJqjvKYeCoHXxhhb38GorWFGWBcUwPdzdWKm8IIfM+0v?=
 =?iso-8859-1?Q?ClfDHortuPV01zloWJX0FyXTAIgnTUvtaF+E2YHI3i/Gidjg3AMYvjWEp3?=
 =?iso-8859-1?Q?srD+WtjB84ePGz1LE9yXX3pZsLNGL6NGh71PvElFlVPtkSVvIzY5ztiKMm?=
 =?iso-8859-1?Q?L/G7l4rgLQW9sxIojhhFnyIS39Dk2Y3Yec8LJ0vrsgDDLZb+/NdIxI538L?=
 =?iso-8859-1?Q?aTrpWKqUhIYRU90HHV7CDaUqZRYLb0FoL+Sv6lobxuaScTm0LL12nuM8Ra?=
 =?iso-8859-1?Q?qkz7MSezYBLe6avG14pWjPe3ZWASqrkVd+yCQfun3H9erTx3TaC79iIvY+?=
 =?iso-8859-1?Q?qnWdZfUELYaGiWNUDqNB4uSVznEX4bPIM543ixqiHjDCx6yFz4a4L2R+dI?=
 =?iso-8859-1?Q?mswyzMfwTkSiIHN4xsHd3xZ/iKr9+rismUtuNquq4TNHaZodBxDH+5eNCD?=
 =?iso-8859-1?Q?rkAYIU8EGeOiRN5tcEvPepewnpKEZ8G4eNNWf0ueyWrnpvzXLiYJ0nMIY7?=
 =?iso-8859-1?Q?YBeXwIgXHn2v5TGQPYVT/Y9aGxFviVYHyG1DYVe0iVBI/ZppIav0FKGklO?=
 =?iso-8859-1?Q?qFqlnvXoSfQC7piMbmN25HnIerFWb6PPMz+ZbdS8tA0dy9yXSPYudcxnbS?=
 =?iso-8859-1?Q?XgMaD19tFbbJGO3UZinfCBJ9W8+o0QfrHVFmjwikPAWSMxdgV5dNvUQi0u?=
 =?iso-8859-1?Q?xNh0M2R5/kOdlFVYZkC5ecLRUARCirbJjg7Lm62smkxi2V4nlMKzdpL7/f?=
 =?iso-8859-1?Q?gJdroeZaw1IkWU6tmRIRBI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Nu5o4DvS+7FbuT1Xmv5Ombbst3UgA1U45VpyD3/LF8Sy1vIVPCweI1IN5P?=
 =?iso-8859-1?Q?1AIb2cgFgjW9ly4PJSC5acGHb5fhbvTMXCPxHFiHTemGlO6jzM0Lw5qIze?=
 =?iso-8859-1?Q?WANj4R4Qqy9fVLSQLyl5AiAGfPZ7WJpJVNXdhUpUkL228wY2pJ2vgUqCrT?=
 =?iso-8859-1?Q?fi1WR4M35ZvqGnKQG0pCvHZjBujwy0yOTD1YqJpiDzoDLLBqR+NqDsLClf?=
 =?iso-8859-1?Q?agCW5/41Y835rjZtU1Mx4FBEkYOWX2WSN3a/fvr7c/wbDqsv64YzpvL0oY?=
 =?iso-8859-1?Q?VdtuqFsnTXgF6lIv1Mpv/1J4OK4sf4Jtnr8WyQTtbVbNP3E/Txw0f1ppbi?=
 =?iso-8859-1?Q?mmNCYBqBjVQ0FIpIs3wuTAqZD12PTIYY7IUnD5HffAtu2xCpQsvNDPMis0?=
 =?iso-8859-1?Q?oDBlVVhCnr79++hjS4HZsYUQwLrQGPjyDPG6lZJheMUiGMGhnioZYyAeCL?=
 =?iso-8859-1?Q?6p1VDOzMLX8h+bNb1Iy1S1lfu+VymN+55alI38gM672fmeNKSIMhqU/74k?=
 =?iso-8859-1?Q?fUWzWty07vkCzFnv56WLW88zaZ3ZnFmSaJO1byPSSj42ZkKCI2qYHTatVH?=
 =?iso-8859-1?Q?bzb8qxDCwo5qDVzEBdJGG2iWj80Fj0EUJc6Ba/cx32adtobyLB9CGLGH2h?=
 =?iso-8859-1?Q?VCiusOJeT1ifP4pYVWN/LAMkxCiqNXzh7QoOcLiq9FC24SVrB59ZieN8gb?=
 =?iso-8859-1?Q?eWqdY1KjdJftPHgN936PMQkI3aftZjfhXqY+p93Z//i9Y5QNwKhGTNhT/n?=
 =?iso-8859-1?Q?3GdA+EiKoMVNEtAbUk+KoJosDfpmKeZp2YXqu7gRMIa+zjZkp4CMonWQkO?=
 =?iso-8859-1?Q?qjWXPIeE03ivFcaLBXA8f09D8mqMJViNqbPMY2kub73RDfblY2iKHCXBZk?=
 =?iso-8859-1?Q?ZKs/mTm0rOwyW5ajaGYytwDHBmAT0JHskb/PO8xuQuXhwCWPGdEKtWOm9V?=
 =?iso-8859-1?Q?PrGBgwqfBPHbQk2YHu6x3SreCvT1x4PJKxZItDj1ia2T+2BzFfBcWUIdRE?=
 =?iso-8859-1?Q?jn7BkQmpuKqBpHVsEbhWTW9KPJszWwdTHJsrZ0zRqwgiCC6Gsc8snFgrpL?=
 =?iso-8859-1?Q?IKKxy/nfZxXmrtuSOXA8j0NxfKy6JPF0HllNa5i0E1f+MrqfD5WUuQ4gT2?=
 =?iso-8859-1?Q?pQfIDS2iVcDQsjLC5b9s3wN3XhPI0/UOdF3+WhjhmuKfrRHJ+mMMM8mL17?=
 =?iso-8859-1?Q?tR2fukxr1176Cu0TUssh+YYDO6zOov6vpJSgNze7VB+XlRrCSPKG2sIpoJ?=
 =?iso-8859-1?Q?fBxNWUt/REDerEwuR2DPXfhQePI3yYJ3jlRe2b2qCyEqgDcxAQKyp2rYuf?=
 =?iso-8859-1?Q?uY5/v4B1M2IvDPZOmU+a4/fQQ7X6bzHtc/42MrY89FqER2t9x2pydRFj/A?=
 =?iso-8859-1?Q?ynGvL3yWFYy8ikM7OspwXyABU+DC8YikB4VGkLBKspwUCMh+g/928PwX5c?=
 =?iso-8859-1?Q?QPSb+rUNOXZMFSMPM5cCDgHZc06FY/tC71zGT0rKMApWxr0tWvSHmxG3j8?=
 =?iso-8859-1?Q?TzEQzvndjrJyTY6KiHBYHLFvOvFXgIKTJW1uHdpN4hwHHNbfDfL4/Kp5wF?=
 =?iso-8859-1?Q?aoA2JVYY90uhIVgLEFNS4CxBrNS8MdLdTKXw7YOsQ+0YJWPihDB24rWLbS?=
 =?iso-8859-1?Q?F64UALa2Toli21gEco5niDm7tdayK0ZizLDF7MJe6+BHceHa77J2LnAw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c54a6b81-999a-4802-63f6-08de0d93d50d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:42:52.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLmAJIK/xA4BbV7vAXwInPGlcu+pMWaXP6M1ILSGo0gSVYFREnUSKWC9K1YexxXT3vUU533ud6fhQRM9P41PLMyAfClMN4nM/m3H88SkkhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
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

On Fri, Oct 17, 2025 at 08:02:09AM -0700, Stephen Hemminger wrote:
> Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
> uses of the comma operator.
> 
> Don't enable it for drivers since many drivers still use
> comma operator unnecessarily.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

