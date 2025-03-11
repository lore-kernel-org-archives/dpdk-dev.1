Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A9C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF1240263;
	Tue, 11 Mar 2025 08:32:23 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by mails.dpdk.org (Postfix) with ESMTP id 322FE40261;
 Tue, 11 Mar 2025 08:32:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpbtFlLer6GEue1gmaZSk8hLBcKo0vWvaSsYPc7LUCT8ZQl5voxxKT8loCziAIZwqJ3cJ6+Oy/Ui6CEWppeWJJ745hYYH2+NvTmkPZu+uqROQOHUZW4VwPiL+oQ/84pHM6ekWWvpvL8Uy+DJ/X4MvBB6jtoPC7MObnVMvkl4GDi3KiehgU3r6n8nQcr/T4Yho/uYQvaczW6pBNu8Xtfe0vNPc06iLWZMkIM9bxPmNVHb8wa3FRSUwC3yK2lKWgs1/+zzieN3uSST3AYPizSOdapOADXEOOl4oEfoRS6A5VAuZt9bun/ynaDMF68jFOHgbq4u0Bf9eIN4kiMSXw5J6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqKMPPzlH+hvtcQoATjdt29khp8xMgx8IcQPv5VnI0U=;
 b=a3fFo8+M6DNYNNWWbuQwhS9mAUOIblm4dRZ2IqGHwbpss5hJ5hUnZf34Du1MyNjFLvtXuAuhZJ20iDQ8G6YHQingto1AgxjRoyihEOgtQ4eopf6udWdsQ3Ql6SpcYfeRpJ5vX4tOWbKngJeVwjxfUTqLRkSAMHHnyWMVDlerdAEnNAp36Xcw5F9xSZic/nr3XAJvUmBPQ3uqIgz9DSJ4Htr0B/56nFSGhFMOoz4MYh6gWNNxbWDDzknUcPWCWx7tQh24oM4lmD1skg2+VwyCrz/hKzLxGJxpajx63PvGGK/oZI1vIUVhmVte0ZTtYuKav2x9gbWP4PhWGKcV46iUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqKMPPzlH+hvtcQoATjdt29khp8xMgx8IcQPv5VnI0U=;
 b=RbKgrQKbo/OkpiuAud9EVLSJYVuAlguVHZ9R3Zq7JMNHqB4QAYbTjQ541+N7MlwB9pgMNqo6P9NrClAJ+gsosXDsTeMZ+GYgrrOL4x0H8nvoH98whTN8jTEKrqUcdjBRoy5BA1PRsbk4taQpsbIsKTfbnMDKMVnv+iOrzjSY/gmxxMSPjunhC78JvqZKS8FRWvKORc2v29HWsagCbWZpYkXerIVWhPDt/9iRf4HEmjAuCI9liyWTd292eDxbC6IGOjD2aHz84y9UQ9oixAHtdIUkvxB8R26Xh4NZiC8TL3ocLLrry5KlMqe60eVQ7a2no86FwUgCre0yrbG2ArIP+g==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:32:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:32:18 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when using represented port w/o port
 ID
Thread-Topic: [PATCH] net/mlx5: fix crash when using represented port w/o port
 ID
Thread-Index: AQHbiQMX0OhKXlVWaUSmTmjZw5YLvrNtnUKY
Date: Tue, 11 Mar 2025 07:32:18 +0000
Message-ID: <CH3PR12MB846049348C3C13A0735D0D90CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227103329.93196-1-mkashani@nvidia.com>
In-Reply-To: <20250227103329.93196-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: 98e14bde-3ba7-43a3-0603-08dd606eda87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FEkJ4uR60nxHgqbtVfVMB3ekDo24+x50AsDAe59BDy8gnvmHsKpHHXMU18?=
 =?iso-8859-1?Q?qdsAbN2sNhiUwCSb7scJhNZf78eaw50vjHHMH505X3WBQk0v6LWTU3GIoS?=
 =?iso-8859-1?Q?YpwxlLa/OIYi0ddJiYPsZdFREO/DE4xilYJfOMedAd7CpJT9JZc2fOxt2b?=
 =?iso-8859-1?Q?DyjxcU+OE1bYNkvSNsVfOd+jP9UrdStWYgVfGKQhZMAS9ttE7BwA+insv8?=
 =?iso-8859-1?Q?/54eF8pDjH5fiN0anTM9liWTPwoXQrlVg0tPgMD9h0rLWVPto8id9GkD6l?=
 =?iso-8859-1?Q?K69QgeLvJhbfpvZUd66j1yBBYBy/DAnh1qlE3Um+pL2Vfk1SooINMMXFzm?=
 =?iso-8859-1?Q?KyCUpYQxYzuSndIHKRC6jKASE+7iRzykQNWHKVpHnNsrFm13+bKt2rF0un?=
 =?iso-8859-1?Q?cBpqTbgyVFsGRnxgXi6HjjBkdoiSI1bAeZdimYXnY5QUffJD3fOPV6Psl2?=
 =?iso-8859-1?Q?O2tEVkzwzKJnzXjfVi1++y0U7QTBrYPddurmy452z3nXUMR2nMfnGvpTaz?=
 =?iso-8859-1?Q?9SwarPQd+OYtQDLXXxOo1vUDyaxr3whcv/RmeWpYTBQ7s0Kus7YyzQLA+c?=
 =?iso-8859-1?Q?KOMhNGSbGd55CjJ8udOXQM61ksV4dkg5J1kplqhDoJxBG46hJyy0N0v8tt?=
 =?iso-8859-1?Q?BCoBp0UF7b+18tYhW/j0NoyHR9YS62wfrIYwhCkHyYFwzqersBiWOaDebW?=
 =?iso-8859-1?Q?EjOYLSUgvPtSn0lvZHfBjO+PO6sYMpTLuu/z98bLHqX9FjOJxP0YNhnZR1?=
 =?iso-8859-1?Q?3Z82BqDxGmGwSerlc3PJXLaK3TLnTs2yjVYTs7rjxyb3iG6MsJE/8P+xof?=
 =?iso-8859-1?Q?qXv0LZagKDLgZKuEz2nu2t6jvJrhZiz+c+YNXctfJ26RN7taitdFEnhXah?=
 =?iso-8859-1?Q?axhtaBCKfqenDJnAPeVbMLyi3cvzml467kxnWkxubbjGE2wXSj2DKC5P69?=
 =?iso-8859-1?Q?c46PVuj+SYK3Mn0uFRzsZDGg6yRb+wjuBn7OtStz9CCOpOOBOJacjRLiwm?=
 =?iso-8859-1?Q?Yc5oE2FtGAjcJ6oOXh7pWAFI/LBHDeudRQ4BiTyDQ2X5S6ZyGQ4oW+6jYr?=
 =?iso-8859-1?Q?B9lI1V/J8vSuL5mTOn1C7mqfuHTVn9iFyFadw+lPiunSJsuuNmKSNcPHIp?=
 =?iso-8859-1?Q?g1dvnoCBw7KMY+NadPLjJKZ8wO/2rwPELm/5swjpriB72Lg5t53dZaYRVv?=
 =?iso-8859-1?Q?nbvZsew2x39krIpwPyErr8PTyWON19h9WWtYjmzgIKTLvs2LyZtirEzqqm?=
 =?iso-8859-1?Q?D7a1ZzHk2PSue7C5+O//zOlZjH/Ka0b79+xyWjqO74/OyvoLXIOXXSyYLJ?=
 =?iso-8859-1?Q?1OjtonerB02UOVqABPMfES+if2VtnHw4YaT3AXo8YzDCFZMQ/rv7wV2VCT?=
 =?iso-8859-1?Q?LWXb0zyTvwt72PJmIV6CQt3h/T6GXpeANkaqBGzQbWWdZTCb4Z5ah02WvU?=
 =?iso-8859-1?Q?HHb+a6pMJWLxDw4kuKyMhyBDZ7wIEnuBHXa1C6zk/yIjNmzLkItwxuJaaX?=
 =?iso-8859-1?Q?cYuNGGU+D6ABoEf4fAYS14?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0U3LedOXBWf8zgDaQc2/N+ZeQNdWTtJ0gqm7viPihiUrcMGFX4ortgMW+O?=
 =?iso-8859-1?Q?nRCr73XDKCy5ocGlvoAo0KhvA8n6Jr5RSq4avwOuGzYuJH+Mrj6F5ILcKw?=
 =?iso-8859-1?Q?uvze1KLQZbSp0dvEpFt0Jl3bf7hbxidWG6AN3tKATQH3DjimcQkMdURNpD?=
 =?iso-8859-1?Q?IQnrwiTZ4sOkXAY2+nZGDFPHW7Z0BKlvUmbUg3HR8/MdL/fN2Kg3mFxmDn?=
 =?iso-8859-1?Q?6fmetXS/OsoBIquDCiAoZRmuGG/LBU+PUXRH2BTtqIAKIBYATIUGdGzr49?=
 =?iso-8859-1?Q?j35gII4hzaIPwvyAY+xBSFvVi9PaYaV9onR/QTHM5U5kB2zX90I0Lp5a4M?=
 =?iso-8859-1?Q?318hKJfLDaXnaz4+Cj5bqlt4+FoUSg6XMXXXe5a5LncoTEnKv4e39F6iI7?=
 =?iso-8859-1?Q?BWVSw+b8lSWqc2vyemWBKi3Q+zlvwzdB161kb8Rye9E6IBePTk23Cm3ys5?=
 =?iso-8859-1?Q?f8xaqbeklvFmttTJfVPUKCQQ6nd6PrQ5pfYiH9qUWlguhd7PLhCA2pP8ft?=
 =?iso-8859-1?Q?OKvsJKQfyD1wWJSY3T05A8bSp9KQS3JGFmkFqNMtU6N/NKIR9PjpCAa2ma?=
 =?iso-8859-1?Q?yeubOoH0Tav0IKUuJ9du0Wkny9axAS9q0IKPWV0o/IHWrEa1xDdPyl5MVD?=
 =?iso-8859-1?Q?yWF16S0biu3xX2CuvL80SO+4ykEksVdKYRl/uDlCnt63WlxJyyLKVBmSnA?=
 =?iso-8859-1?Q?rLw0EONA1Q0cnw44q2bIFUPucG4fZYzV0lKsWSFS9vqo3k8qZ2oEy5j1Oz?=
 =?iso-8859-1?Q?mzCzX0x0Qt5Jb9rXQJw7DKraAD2BaLfsAJzhi+eu9lmQZHxvp3nnbl7KBn?=
 =?iso-8859-1?Q?ht9b4Z3W0yGs5EvpUQiAZRK7nxUZ9b/NDe3lLYOlgQ1VgtpFmx69v2rYVc?=
 =?iso-8859-1?Q?WlON1b9bfjQnpJe2wNPapnZliqUXGZvtw8jSzG6JjOLsj7dUkYnNVpF6Lx?=
 =?iso-8859-1?Q?f/+3CHVEQTKvr/JaWf3aUFnXoeAosUVMCGbrRrLtObMyjx/oGlhwedgE4u?=
 =?iso-8859-1?Q?GYMTQdpKUjMi53otkmr+HxhH862Ir5fwSGghHKnk1lIcST+WXdwlOGo2gO?=
 =?iso-8859-1?Q?KtpYM79T3/nmJVmAWL0GGqNbrGlKcZmlwE3PASbsQcDlga88BJIo5Ux+5+?=
 =?iso-8859-1?Q?QxMGd/bYFooyfXWymnSWCfmk2LEFZGX26WKYojEhA/DKHgsQ6v9wYGvk3m?=
 =?iso-8859-1?Q?2QWSsS8BJe8h2B4didRl422g6Mz+TfC9LIGwlrvQ/sDs0wjBa7F+AqTVir?=
 =?iso-8859-1?Q?ubYVfUrTGcafF90WAsgAZnVgipWQLl07lwvks46x55+tr3BLnmiZVhDrtl?=
 =?iso-8859-1?Q?CHadCX6OjnP5q0Kwu2QbrBxhTcMtTooNiO7dXRkmyx/qAEem1N9/LjGbgm?=
 =?iso-8859-1?Q?7ckCh++2+o5+Ys6x4JlU+Fce+WhvJEr2VrL9nSnhPBV2xudPd0B015g3Jn?=
 =?iso-8859-1?Q?tRQ+chFDviu5glb3b3BQXaR+Qt1qKiwuJZqcS478Hp0ffnGLdlSCuqTpto?=
 =?iso-8859-1?Q?h5Fup8T7BKp0VDU1L+zBE5rO0kdWNrDsGt6mACAi4XCJs/9ICfx6ns8q09?=
 =?iso-8859-1?Q?vUBPrMVElBuoiKvEUBbWvtbNo4eKIJtYtYuHmAg/+UqlqCBPusG1wLLa81?=
 =?iso-8859-1?Q?CZIgj4fNC377s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e14bde-3ba7-43a3-0603-08dd606eda87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:32:18.5182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsiYB8f63HAaMxOyogceEb+w3kJ25aFhYCGG1KzCQzToV+IUxMIKp+3RyQIBvABed3dEpXtI0l+RVckWgIHaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
Sent: Thursday, February 27, 2025 12:33 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Alex Vesker;=
 Mark Bloch=0A=
Subject: [PATCH] net/mlx5: fix crash when using represented port w/o port I=
D=0A=
=0A=
For non template API on top of HWS, when trying to use=0A=
represented-port item w/o setting the ethdev_port_id,=0A=
it crashes.=0A=
=0A=
Added default values to match the case for SWS.=0A=
Default port is now eswitch manager id.=0A=
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
