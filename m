Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A5C282EC
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Mar 2025 19:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA020402A0;
	Sat,  8 Mar 2025 20:14:24 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5A72F40280
 for <dev@dpdk.org>; Sat,  8 Mar 2025 20:14:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAirdUkRzwgsIjjYg6FdUZWcwvEV+dHUEuwc6xA89aoOOMJTeedeDNcsMc0uDbxvHo39NHoGcFmOR6LKmVcwnw95KvwbFZgNw6gq9KSqpZkSNFeyBNwQ85t0HrDpLdlovjJrBvLarYv/grf2bHjRcUNWhV5f7IhhEOXgE2ARkwfxvYxxIE5yf6Ew4vSN0Apg0SY1dqDi5Jhov7wlUAsqmp8Vaj2rtMOdcBAU3c/tjy0xGr1BkEd7o81CdCRB3m0m2u54wXqfLvNg716HToan7lIRYUaiR/JgaPA3TrqmcBCEZznb4jSCySidELJMVRlS8gK/KcTnGGrrutDM1ySMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FptaXm7SBNAMVB8pPoVtgNWxzBZHDaIXLKuELEHOYA4=;
 b=EXu8CEj29d9J7rNu7mYDVY9nFYdKaaKzWmJnwiNKmIPmQHHVzAX1pSHO+xz2Ax5mlvU1H+iWQ7I9OuSzsx3PLB7pV9Rpz3tt6qc73QjunrjLnPm1PHQ9MG2R3HPsTgCAMfz5LWYEOX9NDQzOc2oTIzmAkHLUB3J3DUDvvtiKSxTgBDssefMOMusVliDW5D/2H+KOzcuL9DMQDZW/rDrfSCUWtcOOy38wo57g0bHXhD6CdlGD9abBfOprVMZSrjfs0ufPfWBDaeb2DOUG3halBWIjuZW5yay4vp5SXGkIboL+LeN2ceUJqKFyHH7KGuk5wXdBbSnsi6LsJPjBUycTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FptaXm7SBNAMVB8pPoVtgNWxzBZHDaIXLKuELEHOYA4=;
 b=OQXI1JlE0G3ZsmZ675F7+bwUvJRrCSwjd5HbFUY1L0PCp25m/Iwb/odiFtn91rYB+n/OZL5pUtmSCmYBT/gJmuLUlukW/H2k1getLmfGfmef8UFr6ND1HwlE8nUf3PiLINckyJaDwDg9HM4HHrMC52meuRSaKgiNXq8ZAT5Ft9DdlWN7iqIuhMeTtOSCyfwuTrAbj+pNK25rEdBMzCHr72hjod1Id870Pfoe+RAhsf6uM8eMNSrUaZw+Rmsr4/LVfM2bUZHQ03OH9+VREfAkx6P5ebgeW752m9ZmSYJDBGGesjMzTiiMtM5OVwCwHNvzKbNmpiRMACAMhUjzvJKRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Sat, 8 Mar
 2025 19:14:21 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.025; Sat, 8 Mar 2025
 19:14:20 +0000
Date: Sat, 8 Mar 2025 21:14:15 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Igor Gutorov <igootorov@gmail.com>
cc: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org, thomas@monjalon.net, 
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <CAL7bPf2ddD=Hnw19uO-EzBBYYZz2vYUKxWapYoYK9Qqt7wdbfA@mail.gmail.com>
Message-ID: <a850dee4-a7c6-8173-2285-22c36292e182@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <CAL7bPf2ddD=Hnw19uO-EzBBYYZz2vYUKxWapYoYK9Qqt7wdbfA@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To SJ0PR12MB6830.namprd12.prod.outlook.com
 (2603:10b6:a03:47c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cbce2c-8acf-4f8e-5784-08dd5e756dcb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vicRbKH9PO/pPzz07WNn7DmMQLtC5B19XCi/gOK+pkaVlRKu9u+/8cKxDBVd?=
 =?us-ascii?Q?ZyH6mApL2GBmWY9WA+I5t0xTSe4dHMPmGtecjU3v1f+2pgcc5zMP91gOyXmS?=
 =?us-ascii?Q?O/ExjCcNjtxHNmVSeDsJfxo5ZNXy9BkBAHa0HsShzgtQx70OkahRYzX6x1eW?=
 =?us-ascii?Q?aFzU6rQcyV45vka29gOpPgBg4xryYqVMyokMV6TmG5CYl915LvN2a6PvvRrK?=
 =?us-ascii?Q?nGC5hYLSKZKDpmhiiLSncakCOSsOYM5AUMKvnvR/mIUQq7FSSqwp/Vu8xpEk?=
 =?us-ascii?Q?RJ93/H8TkBNQyqDOQW2pE5SGnw/aAbK4w0k0wl6FidtW2uQl4A15V8a11DFl?=
 =?us-ascii?Q?BUpiNTM/b7JSHegi+OgUWUaxGNO+pJ5UZKOZMOhXmOgbNiWmQidjOW8Q8rGH?=
 =?us-ascii?Q?mM29yYrNwmecB6ZuglS4PYYOFT0TxxvlhaI2fQVWTd+YkR13hmgMtQKSPilh?=
 =?us-ascii?Q?neshiEK9Su/fUVw0SO/ly93G5J2noLn+S2GGP29EuquU1aXZtZDZBFIw+XWs?=
 =?us-ascii?Q?3zQE63ecxnNI5HR7ke76Idx9rhDG6MUBWXxzjFuL/UTRliSLqRSvgpS2pHS7?=
 =?us-ascii?Q?oSEKLeJNtnsXxlFdYFc8DdrorYuIhXv8+yALi/G4mLqt8Sm3vQNvNL/AA2Tk?=
 =?us-ascii?Q?Z3JjKs1XOY7YEskZs1kQ0n7C6jgxUWcIGZIg6kshPWPicdywyLuftSyYNkjr?=
 =?us-ascii?Q?dC39WxpQcA+BECZsxEhDetEr6/wojp83vJJb2134mf+jx9Y/jyM9lkl1EFRu?=
 =?us-ascii?Q?dMBA6hAD+TsR3WxbC95EbDKX2PmQZ+KjzKS1tcm/Ulq/CDQlxj/a37IYkbWE?=
 =?us-ascii?Q?KMCNTuaACEPRzWqjDOKrW1JuYx5ltRsovVvrEF21oMEEXPcQizemj/W6eioc?=
 =?us-ascii?Q?Vq8Nvdgwac58UtCupdT50vGNX11cFjbYmpt2/9FIyM7JYKnr4bgpyrWO0mhp?=
 =?us-ascii?Q?5FTkhQ8Sm8snmIsGgIE/4kkf6WvI+06GqUnqEPxJ+G/r3RsU3e+K9G2Xa3F3?=
 =?us-ascii?Q?KM0a35OpGmL39cfg+brL4zDmkWnU93XRgtkcgzdYV4jRULiQYaXwPLl8Cqri?=
 =?us-ascii?Q?Mge3fdisqCUDH2SvnyMi7NU0JdsPJ/1wthE3o+6xFjenH1KKTiqX87GUCaq6?=
 =?us-ascii?Q?l73eioYDTbg2rNkHyK0hEDAv7nN/ycuQMcJRGwoS3z1BR6pxbkrqw4EEw+8y?=
 =?us-ascii?Q?nQUplUNijaM3MaP+lJ45NBOAHXhrt1w4qKlk8EOiAlInte/uW/jRDmMAzjW1?=
 =?us-ascii?Q?eP4eotFquy16oV1NhHSaecIdWndPpRUNtB5vKI0Xq9xbEJeFs6ULiCm3OYuc?=
 =?us-ascii?Q?8e2qM68D4QjAMTumJdPQ4/xwiPWU7l6dSgENtypY3LDtZC+Uvx3c903d4oHM?=
 =?us-ascii?Q?kHyefSYE59fqeb2Jq/DSGNYIBOy9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFStW3gkySrl8p27rUEMyUXNw9to7EHiSrNffi4LwO9VCCbN/aiVBGpU4uSI?=
 =?us-ascii?Q?iIF+Cquvrp8Pp0tPo+b6e0Ya79KYc9aTmOXhV3UGtV7+WyU2vBO3vSkg64pf?=
 =?us-ascii?Q?N6osNIZI11XBwM/mvOHVWlKx2txRlLnWdVYBt/JAsJ9WJz7ZyvVCMkRpsMDH?=
 =?us-ascii?Q?B72I638OGZWCzeCSawzcwRhsquQU6h1WD/ZyHWRSLbomnRsCYmBLO5p7WIO+?=
 =?us-ascii?Q?tUzzVameo9HFbEz92je4xOtTkFSSZdIJeeXpoN9aQnm7BR8/CK0BNVekGzCC?=
 =?us-ascii?Q?zEuNWzJ5jSBTJGuNcoM/U+c8F4vZ8L6Y6efFOLoOcWoN3ie96JOhREuREBQ4?=
 =?us-ascii?Q?ZLagpFypMm+m+f3YePLurne4dZPtJmQkWuOequKXCR5HbhlsyeGEP2GC23Sf?=
 =?us-ascii?Q?owGiWe44jHcUEk46BqO+C0klKgmwOuQ2M1D1B3o03BGwv4w/THbBDK/9CVX4?=
 =?us-ascii?Q?ZvMFitVJ59N/w249oXYZC/V6a8FuEH5+iMbRyit4GJdkR8F3x0rCqSiW/vpa?=
 =?us-ascii?Q?VPyNnXLg+Bk3lR5c2Zr5scL94wx0YITtX7zBM3RdpZY15OtIijNSWPHLe3Be?=
 =?us-ascii?Q?Srh9iWLyWDnLuR4yYE0F5wahDwCvEEUB0LoL81FAlT2h9fZZJBYn1WMGiBz4?=
 =?us-ascii?Q?1f3l25dYCFgRySsuaVvoXhMvsaExm4bpbhy1MLNXL2vJAxsEOCDXevIV2Kh1?=
 =?us-ascii?Q?SsluSqIw8Mv88+H4HyBLDny4bJbrU8ujDkWaOehGWaUdclTwocyKSgn7umYi?=
 =?us-ascii?Q?EaQ6h3cZq1rzdeWCP8vkiUoTXip9yC04yME6qEayoF0ujvEVdnMM2+ZK4/3t?=
 =?us-ascii?Q?RpcLvlAYoqj6vWmmlYSWDEHKu4jOpMzVQykTDBJui1VYl5v3xVsFedtbfBau?=
 =?us-ascii?Q?2dYJYKbn90qQ+568ZR9ZnzVO0OP17ebbtdVHx6ZSonrViuVPXtvRqYc1dv1s?=
 =?us-ascii?Q?eFbtgksxvCO2F/+8XytX84ZVOaeWdlp5oaClD0/N7VXQ1jSvljCVNgNOqLm/?=
 =?us-ascii?Q?dFG6vYqCib6G8JESRynMeKyFUG1d5Lzq/RedWjNNpr7fNPUnW7ioGivm3/Ii?=
 =?us-ascii?Q?DlwQZT/NMrJyy0vjIJEIPBGYIorqWpvapL8b4haBPlEPM4a7WyiA5ldJ4utP?=
 =?us-ascii?Q?hpsnajtc2xW8JyrSQoKo5ln0Stpsjo6HF2/XYHIk7Lv92G9XbmvTet211x94?=
 =?us-ascii?Q?g8T/xJDXhN/8cxXgGDBzPlfxYC1IPBq1YpNYhDb7fMlif31hH6NSTqPrd5Is?=
 =?us-ascii?Q?NNqHbcOlEBCx4xtb2TbRgAIO4WoOEcx+G5mCR0K9i/VsI94VPQtmazq5utxO?=
 =?us-ascii?Q?vkhfUDlnJmvNIlDyxTjbwUQ8qMh8QV2JzbJj4nl/RPKdVASTPKx8kYm9cDYV?=
 =?us-ascii?Q?W5HLidg6weTu/gUIyMgcCrbdMXsgxKS7bftQ5cD+Bx3fOmX/5/yXOTLlk8tk?=
 =?us-ascii?Q?nFqAL1uYO37Mu3SXR0tWqsLq1aqDYddHTCk4Cwt0cRtDku+QrIMD75aduuRF?=
 =?us-ascii?Q?/DTkd802AKsk2S5qG3EMrlnhNnNJ8SJvbkTPG9MCrA3GEeC1C1yv+3UTqIzs?=
 =?us-ascii?Q?jR/6h+VLAHpL7vknL3B5j6e3mGxqUqjS1tsUB+Vo1iRd0OIZZ140/TJCuOPi?=
 =?us-ascii?Q?yHDz3lB5NbeRmwh7lyuBzQJI0GwA+wfUO9QK6dZ3D1sp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cbce2c-8acf-4f8e-5784-08dd5e756dcb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6830.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 19:14:20.8091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTZA5ab9KUKIQVd/tvexEOkIRDbh4UGiPMOMqh/mpHMLj6jvQuM7rl1D6Ln3PiOeWwTzzc+llduaABxD4K6ysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

Hello Igor,

> Hi Gregory!
>
> As a DPDK as well as a Rust user, I'm quite excited about this patch.
> I'm wondering though, is DPDK getting an official Rust API? I'm
> subscribed to dev and user mailing lists, and haven't seen any
> announcements - did I miss something?
>
> Bellow are some stylistic suggestions
>

There is no DPDK API for RUST yet.
My patch  allows RUST application to use native DPDK API.
I'll adopt you coding style suggestions in the next patch release.

Regards,
Gregory
