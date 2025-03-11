Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C92C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB577402E7;
	Tue, 11 Mar 2025 08:34:39 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by mails.dpdk.org (Postfix) with ESMTP id 13BD140261;
 Tue, 11 Mar 2025 08:34:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXQs1zbD35+LIO+WNbsI2K4CEg/2KAoW3iuNhnH5RMIBDRpcNcP2sneEzbNhIBh4rCR4YSj0l3C4bNAnkiXrYwCguzZFnWa/PIIEqVWB6YlBI5sjhflKVD6Mdai/P2XqMqRdx5xc8/38FsvzZJcRrgcq6UOZvEcNix0SI0jSZPdNLjAOuD+83I1twSOD9DlF+boFAXixtjt0izZotvd0fwXX7O+mCJy95XM9JRrpRt2F9B9G8ADbqE3Raiw2+BRVKdLNGu5NaR2SFQgEEK+76TqQZ/3GhnCquLiSqQsrZfbbj4Mrl4oW6+bbYMKn47lhpW5m544DaCzErsC9q/HftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r8t2KJGCsx6ftpka4Rsd/0n7mJeBvkYtGWMM+nFl8Y=;
 b=jkR6uclJSWzGmbGObL1EP8Tm1p87UPaq9vuQ86zhyhynAOFm5tPoyDXGZuOdyZ8/aBWc9ck7k7r8bPn/xUIhJXpE+PA6P87j5/nU0KskIf21ZZy4AWlrA3+8KHCXgj01eT4toOxjluhQj1l9c/0KTvsihXjyhnDBL6SLd2TyGfAstkjlFHX/N1T1DQKVwPGCGXLTXCdz6+VVInruBcSOVdu+tFzHcGgC/1ts4keIAf95yPq9t+Z7QvyJI544gnSxb/yGHJkip21VfuRfWvkYpbVIRls35dIv2tUQppf64mpjLPj9OMduhSYMp0I0+hcTgcbjXNnycJS9eqyMr3MvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r8t2KJGCsx6ftpka4Rsd/0n7mJeBvkYtGWMM+nFl8Y=;
 b=XPUuS3mxO3HXPqhXB02hNhV5LP2vbiDJtOlVWaugLKmGIAGbur8KQ0lLAzjEcweTgp/Px146LprpoAg3DlDIwGZx28nZzzpdzf+BAGGmftcc+5udFwcy27Jda9WdBtGiwPfGN/uANkqNMmi59qT+VY5HA1nare8rVyE9c0OWPJlt9hVKzs2O0wDhfZhUL2zMglt20GP8ts5ZM18m3YKFBv33FiKFg6xWaRWxOEYGuWCK2MKQnyXUltS6lXODpLdbJHdoflb2tq+sDd6/3xjH6rA/sVL8preqSbyptwwEeWNM5HKA0ZAPncm4mOOkXp9V0WLlkOF2B1qsYw9wStXpmQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:34:35 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:34:34 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix GTP flags matching
Thread-Topic: [PATCH] net/mlx5: fix GTP flags matching
Thread-Index: AQHbiQVa8VG1SA/zfEaAklgL8a9D/7Ntnbas
Date: Tue, 11 Mar 2025 07:34:34 +0000
Message-ID: <CH3PR12MB84601197B1B5F34D4EE217B5CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227104941.93927-1-mkashani@nvidia.com>
In-Reply-To: <20250227104941.93927-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: 7c2ade97-dab9-4c11-1005-08dd606f2bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RVlA0qyE53oFCvfGSNtF6VGt0dUwaxUhiXFTV/PcSss0lBXyHio2ZMr/QX?=
 =?iso-8859-1?Q?5CPRmcegUOZ+O4/wH0th5qjPceUuiBsUbbN3LBgymG3JKCOcefd7fkSR3l?=
 =?iso-8859-1?Q?a0GIKDjFolI3Ip2aj4BTp877ZtWyWOYRLHle//Pu+Tyr1LDuxatCEYyDK1?=
 =?iso-8859-1?Q?pLZnll51QMvw9HkEU3IqBBX+WzqFu8+rhWt1taMvmVhxNO1gjOZuESnA/0?=
 =?iso-8859-1?Q?3GDdS7vF6BBefjSaQRD4eO0Xp91VmFBrbHk6svj2COsklYnxbzU0C2mtlV?=
 =?iso-8859-1?Q?f0Y5qkasd4usVLVgTwrMqN7/Ib4M12oX6tkX4odPnRzLWbOqO3w9lKevdV?=
 =?iso-8859-1?Q?rsoh/fuvapLquNI4SjD/hy+x0sTyk1yHOSKO/InCQ1FW8cRx9zfUOHLw3b?=
 =?iso-8859-1?Q?iOOXToQOmmZqj6h6NxhsIFpgk4wXtZZQK/FgHNB7r/mg6JPdUy0Wmzt8+B?=
 =?iso-8859-1?Q?QdZT7mmRoq1Jsaka2NHW9gZs5JksVG1rCA962u7Bvs2c1HE1CCo2Xrfra9?=
 =?iso-8859-1?Q?u0f1sIy1VVOKhOpET1J4wXOSC+uvkPi8DsZWeEbNwLvT96iwLdOUPFnVuy?=
 =?iso-8859-1?Q?ePwfSObK7gqklRe1Vm44EwnRb5EWgPcvLtwRl3CftmxJaUw+kAWUKn087c?=
 =?iso-8859-1?Q?a0IQ6tDo5TEc9LR/xOizcoFekmoXaiIaTbptgNG7ytPW7vr+CyIuZwJdzP?=
 =?iso-8859-1?Q?ed4B6UZTAK42LgZK8JFDEX+xSovD+hJjm3Vh7OOoisYBQG8cyB4VqKXB96?=
 =?iso-8859-1?Q?9xfI72AvaRSUJYJLWgy6Fb/Ni0gjjWMa2FGmS9/EhBdDK+oNZ9jZ/9hh7L?=
 =?iso-8859-1?Q?1+CdCExfvQfIwTLtIt+imVTZB1VgZoaEFm2U86jX8nWDL7UG1G1H+6bt/Z?=
 =?iso-8859-1?Q?r2efcVNUXtbrbLjX//EV1H7AD5i4ZSFXiqGdjJrk40YkWOLxUVMpc2qVs1?=
 =?iso-8859-1?Q?/jQ/7nMJOfXMdtKF6QlUHw16EsnXROhe8TBjfAHBvDqh13HMipwtB27OEN?=
 =?iso-8859-1?Q?2RIHoi3adhLJjAo6eWv08I0dGOaBhyLvV6BC9IMY4gM2XtW4g9ikdTvBuA?=
 =?iso-8859-1?Q?C3KVC7UKZK9FfAvyDLC51kt7eg9okWHz7bY8npI0Xzf5YZ/08K75nJId9Q?=
 =?iso-8859-1?Q?BeoaJ72m9xyTjjWxx5nCxwEL8Vscdi7k+kEdiztaaz1kW+T4fQ0MaMvKKh?=
 =?iso-8859-1?Q?v5skxqhq9Bj5FCbc8ndmowkJk/D0wlF5+8KbaFvhz/ylfxRZdiZVsOWalA?=
 =?iso-8859-1?Q?uAILAM6+lZvGwsBRg/7e3YtcYv0L220jTj84gcj16RTBIx4gZyB9IC/sZE?=
 =?iso-8859-1?Q?+tnfApWtUV4uYBcHT25Hp9m4itnuRe+7mpn3Pw8R/qjhkvchwiqGtATj8u?=
 =?iso-8859-1?Q?XvCHDNpEGGguMALGFOdmS+bEKSHY9dgcmVygFOYUZpxrygV7vanEV2kWu9?=
 =?iso-8859-1?Q?eltYOsZNqKY7+L2Y6bvX9ia/LqDw5sgW65jwdPVCLbIS6WAEMNjFhvgEnR?=
 =?iso-8859-1?Q?2+galKo/buY3Fd0N7/D8ph?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kKlV1ncz8A9AD0ftcDJPiEyeH+sSHmIYfp9g0dl+BOTXNQ466EzDms4Gy5?=
 =?iso-8859-1?Q?5z2PCoaKXnzb1edXCK+EqRnLlEsNBoSsDqsdL8Xd7CDfSnzEfN+jEQo4RM?=
 =?iso-8859-1?Q?huTtKMhvKnn3orommMogqob75ScwRiAo3I+hJJaUBksRY2NxQ44yeGz4QF?=
 =?iso-8859-1?Q?drd5sG99LaAlDMt/cBSyi8uutOfZJb5fbx5A5KKhhjhBOY/1GpzuQfbrzV?=
 =?iso-8859-1?Q?Lda/AR/urKpLX+h9lx2GOYAdlXa5DP7PrV8TRRzJfCc+WhyyXkpE4NTcyt?=
 =?iso-8859-1?Q?EeiQOzpESNmO0XiTRQ45j1D3XGBl7Xdp8P6tuWItZy2+MXWBFWYKJGqAhy?=
 =?iso-8859-1?Q?r2PY5Jns7uSaHNtqgVFULShpFwdeNuUDXa+0FqFmY/vw+p7/Bb3AqtOHgf?=
 =?iso-8859-1?Q?AcjsJFhIf7VUrU2ygX7lsv+oI30i9/0abcrN+P4nUumzM2HZyROkRWQVkL?=
 =?iso-8859-1?Q?OL6Iel353FRCEf4OsUH1Zehp0if5UJwwRJlAifDnfFQ2L1MgBxgIQcABiP?=
 =?iso-8859-1?Q?mZEDYUB8VGOkK0IFrwDIMwcw1QMPpIcklaIIc5JP4VCSpn0ZAIXYLcm4ly?=
 =?iso-8859-1?Q?peoxQCVMSUcNX1uihA+lC3B6hPXJQ0AWLPDgAMRrkBsCi/Uc8WZU4K9gIh?=
 =?iso-8859-1?Q?kavNumYuhRclMGd9X6pwRSGuvU9+h1bKC1yRfy9k/nQiR3EVkfL7G9MLB1?=
 =?iso-8859-1?Q?QFySNShK7qAye13mMFxIgddOasBcYY8Byy/srVf8v7bmnaFoDsrIMvqKir?=
 =?iso-8859-1?Q?IXmHRXPt5o5Hgkkm9SOk60vrHJiXwbWgqugru+01hUqJCtCHAivKW1rtqW?=
 =?iso-8859-1?Q?PFZqs7+mfWEEqXQqaIAqhMfuQY9NOOfX93iXxPcn7sG93P22VBfcUc86ib?=
 =?iso-8859-1?Q?Z25HxZMqQllPWuGJ287axW7o6Y9B8yC1l6Dr4+F3LUzapIH9c8kb6mR1oR?=
 =?iso-8859-1?Q?cotV4rcWiATEBIgfvr6okjDQKv8UNQICm9ZFQ0SUmL+7F4qhG4P/wnFFDr?=
 =?iso-8859-1?Q?ZaJDbvU2AgpbCk5SbDuiDf/S0Y3sE/BT2AEA9i6zZQpT1lfC1dPIczwjOw?=
 =?iso-8859-1?Q?nqY/KZPEazE+gN11mDxmsdMwWAW8n2KDnFrBmZYotW29m5KqTzMkCKkBKq?=
 =?iso-8859-1?Q?tzPLoXId6CSI1HIQsgMrI4mxjZZA0pHU8XAIY5/RpM2sl/Tij0Z6I2D0mG?=
 =?iso-8859-1?Q?WNRTSHqhR7QUG9EiQCArjX7nFKRG4b7R41Lp83JF9pTkKoNjhnauiXT8sm?=
 =?iso-8859-1?Q?FJ5OQANvcRdUCVps6Pk6DaXbuH5l9JQm0yZrakqq8Ei/LkTBTYHETpRFNU?=
 =?iso-8859-1?Q?vdfmIejtRFQLy+aoyv0qqNLhIbci1npCfv5SPA0qxn5aQUZbYT63FNGCtE?=
 =?iso-8859-1?Q?OLszdTOs/sSRM4EjFOf8tYR0g1D5+QfkV5y25k29s556HiPsKBiiCGC20A?=
 =?iso-8859-1?Q?mG5oqLGcVMP2BWOBvEHq7i1rKDo4Ud3WX340STcOiUQ3N6/W6mqHj+WEWr?=
 =?iso-8859-1?Q?96s37VaBAwarMPTV8sbLFoBNamROW5I05AoYuLuFikGroC03+k/2/YaHhD?=
 =?iso-8859-1?Q?4ZgJ6Q2Dd63PnaZDGbgjRAZnVp2Mt2e2NVxPMDaS4nJIPNVJVqzIMdQiOO?=
 =?iso-8859-1?Q?zGTjVG9s9KJFk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2ade97-dab9-4c11-1005-08dd606f2bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:34:34.7539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSJ9lmAXtTSB4xRC13Y9NiSH4yMPKeKGNvB1sw1nn+tAvcq0qOFUBkwAOYRxEzI/PufGO72JoTj3lh2l8EDYtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Hi,=0A=
=0A=
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Thursday, February 27, 2025 12:49 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Alex Vesker;=
 Mark Bloch=0A=
Subject: [PATCH] net/mlx5: fix GTP flags matching=0A=
=0A=
Support gtp flags in non template on top of HWS.=0A=
Currently, only extension flag was supported,=0A=
Added support to all bits under v_pt_rsv_flags.=0A=
=0A=
Fixes: c55c2bf35333 ("net/mlx5/hws: add definer layer")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
