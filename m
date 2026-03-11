Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF9104C00F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1CB4067C;
	Wed, 11 Mar 2026 11:53:15 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39]) by mails.dpdk.org (Postfix) with ESMTP id 35CCA40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:53:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzl0JzADJ5pSYOSgICwbaeNzrH/esiJuD6kvN9yWDoxMXoLxNgBMVWfqa8Ru9c1uyLchLxbzTfTjzNaERtb4/IysW6hJy0zQU3AMejcO6vJuAiqRcbVknoMoeyt7stiG+u9KDEfMq7CQo9fyurCUo5a4AYkP76zV3TTJQwLDKECCc1aiZ3FiHIlGHBwD379ZDpV9lT2NQj0L/a32UXuVS78eRTgkMuMwlEFNb674M5k9mw3eSZgYxZddVCZxoRmzC34VimCfbofm6X5HMl5kAiP7cx6Hb/jPW0zODSiZiVTlyEFwpz1L1hxBjgBEFx8NF2jRMibvq8hKGOmeL1K9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZY1GeOJ8VnrvibhKKfCgRk5Ls2uLIGtLlvPYtlZH7g=;
 b=vJ9obNM17KRx+EAUGycs9vjWD1MeDbqVLeqIdP2VF0w2xcBJ0njmBlg2W0XSDGaAK/6ufmctWgfOSmYY3mEg4fBi31yEqb3SrVR3z54IvyOhNXl4+472BPZVtxbHmK7a6jN/1K933IvYN8txL4XMeiyB88PQLGI/rB+s8+iX0hZADsYyi2MZyN7VV9uSFs3Umu/9jqTToM5Q/yOfEsrrvAM/oEF+u5yZ0Ki0s/EmPGXQk06tNOkrvM0iW+cyfj3oKu24z83iK9TuPH3wGFdSL647/A3yh4s3Nmm9Nvv+szpj4UUmZLsQwRQZ+KMZ87vBZ4m96L5VgFoTUsQTXcJTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZY1GeOJ8VnrvibhKKfCgRk5Ls2uLIGtLlvPYtlZH7g=;
 b=Ar9nCiZCn66viUJLv0KuI0eQdC9yE3O5/n0pVV/BaBtE3iPm9rnfkyXBnB4PS/silg7/9yCSHOteIjRePi2+LdFm+8U5wFq7vRuqM8XJDO/AiymrAzCZUvWjU0/L1XzPxXT4vjVFvFYNUdl/xL7/eNx/1ypqoykq0uZSUCsJ1+c=
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 10:53:11 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::d199:4630:4746:d7bf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::d199:4630:4746:d7bf%7]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 10:53:11 +0000
From: "Sebastian, Selwin" <Selwin.Sebastian@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Topic: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Index: AQHcoPW7AVWyyTP5l0eT7Jr1E8wzyLWh87OAgAdUhzA=
Date: Wed, 11 Mar 2026 10:53:10 +0000
Message-ID: <BN9PR12MB50525B365F544CD6D0BEB07F8D47A@BN9PR12MB5052.namprd12.prod.outlook.com>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260306105533.5e8b77ff@phoenix.local>
In-Reply-To: <20260306105533.5e8b77ff@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-11T10:51:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5052:EE_|MW3PR12MB4346:EE_
x-ms-office365-filtering-correlation-id: fa7ffd52-2d1f-442b-fdad-08de7f5c6314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: b51/CpPxtrnbK8NUTsafzqRE3rSALsITTWYbUk4raw9Ecomnvy4m7x/ivlhtHmuF619nqzP3/nHMkYtxMNvTMubyr9LZqWj9r/DnIS9/joeb5Fz/aa4BOU4/NVDb+2D1MjbQ120Oei4kWmi0KE4O4bUFiqEW6+F9Q+WIOJpyf02sFg48bxn+35MIVFMG57ZsPAXcHyGRfoghCqT2F0agxfP+5+HIeqZWjVY8j/BhczeYSxdCSJ/KoMBshAkGOhinobVbDNLNoxhn9KulNIDou8NHOnuM/4+nZ+mPFsA1GzOfbi8c7dHyAIgoBoZyEkagX+uQNkH94J9k19DL6/jWUgrTV2Z3gUCQ6ATllZBMbj+TKHUsM3Qq/b8LcJgc4SiSkYKlTTt9bleM1shayZFXbxtn/Edlic0+Z4h1zoVvyiMnxZfwYbW4ix5xqd0fXCOb2KRV0/2l/fADewdaWmOnpEep0xgJCmCjcdqFL9tK1CwKdigcPUJVQq3HsuDqQ4gpFoGrlju6cx2BJYERRxyz2B6dJV8cqg/TwnyuZ5bUey/cXmQASMftGIjYtXqWhMJjG9Z+Rx90hR6GTL9EMR4Vl4PoEMAn3oIBrSs+xbY3NRARu7TbPyW1kpSdTOQYbAF+/u/g9jvPlJ1HXMoSwM45kI5O7eZu13eNsoGs1wxU+fKiE55OVIajrhMsumsInMB5V7ihj7VpaKp+bAwztFgcycqmkw/d5nMvhg4POXSXtZLwFWY4qxJlBViWx/LcQIAIt51yYVS5knq4sQRLvb67CV+WqSiZlwJTgjpEAG/nTDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohvjTU5Y4qyTf/WWtewbAf2VTVgc7mVr48WVh7HpfPxhEJeuzKq7EBxdgpMT?=
 =?us-ascii?Q?YDMV6c2pF/mHBt1xXyWhAZ8zcAXYPYHXIgL9fMcmsbliRhFTjGwELrqLqNyi?=
 =?us-ascii?Q?KtUXucTAsSez421urepQEWNolMgVBGxexhsIuX3k3XTtt9Y9tNmIJWE6CgHB?=
 =?us-ascii?Q?nT9fojPqH/iIMr2tzmHaT66MauL8XtcUpCe8VaxRV7/StQfmd2LvVZ1VV11H?=
 =?us-ascii?Q?qfT+aLaYzEjrw+2SRsPr+JlYlBeL3yb4/GbzYRBt738YgmQNWLfsZPOxFLRI?=
 =?us-ascii?Q?sHF9kVCG8KeklBmoFdc2x8Zmmvnxe4JQXAqjXlg0x77fV5UgC3I1NFozMSzJ?=
 =?us-ascii?Q?eKgD/5h11UQq+0vSVsYWQU20Wt928Wa13xcww8g3nLALRg+rD8y4Ek7X+Bo5?=
 =?us-ascii?Q?VUAAqkXMpQIPj2Xh4xqAtrEv9rB++59x3pVfMrWE9/xaNi8rHB0fzf/+dtnc?=
 =?us-ascii?Q?f6JOBh786746AhNyj2KlSL6Ecrqknjl/tTaRMaOTMH98p6XOiaKKhzs7deZ1?=
 =?us-ascii?Q?OholRUIFgCywcfP3qbxGCX33oXfb2FmIA9eXoAcqYsiESJLs6VudYUGY1AVa?=
 =?us-ascii?Q?es3kGIlOHnzrD++S72ulOj7CnlQuAVMwgXMz5qfprzmVC2XR3Nb+u/zFhlGx?=
 =?us-ascii?Q?F8VRqSFiaadrYIKvLfa4IEorKeo4iannVWXmhilteqXwJ6/V2538ImhjynZh?=
 =?us-ascii?Q?HmY9FM6tALSnzyMx5wK5Wovr1QHys/GKQF4KW/rXUqo4rRV5G6pjaZefmBi3?=
 =?us-ascii?Q?LKgQQYGlfY2SuN5VKe6+s1UuxZis36qLIfI9CUo52PLmJyVrt7rajBAqOBU0?=
 =?us-ascii?Q?yNEAXvUjcOjJRZC2STM5i+4f9lQ+G9MWMN6HdE283QkCAvPuvsmy+rOaHR+y?=
 =?us-ascii?Q?/LkbDiXhojmosw2Sk4pLWISZhR1ZvC+5SmTzPyuJFJo7vJDQX5/mfTGTD44c?=
 =?us-ascii?Q?66Q4+r/D4EtyotQkmLAbDgGi5h9mtUeOZo0nRqdmy6I8CS9MboeUmWwdY2Jl?=
 =?us-ascii?Q?frIX3C0+sxH8RJyTzCvv5rdvTGmRTwTPO0zaB86ONjqqc9DyGrsiTk6NNJJ5?=
 =?us-ascii?Q?OLajFy2hfFWdz4td8OBV0XKmopkvfB+4z5YK3J5/dwXX08BtK7Un/1ffOG2t?=
 =?us-ascii?Q?40L7We3dpDFqx+8CPHYDEncvX1KnXwYI2swJU4uamOgxUvKSXY+ZinqWoBh6?=
 =?us-ascii?Q?cbFiYu2uwkJyU+TdAo4hJYCHUfCKPP7AXuPh/L5TxwEITWWq2Ek3Ao+qGQve?=
 =?us-ascii?Q?/01GEEZeAIzZmaccyg8Di8mSLkkDLJgkfkLz0/Tn6AdHwBR/w2buEJF65qGP?=
 =?us-ascii?Q?dA+GIvdkDVzGh1aXINQcYji3KjeDIMUjue6IhhpWOQyXJdqvbduR6Be+yvWo?=
 =?us-ascii?Q?W9ipZw8UBTz4Wp1r2rDLs3J+edEWfqQNSxmpiQXcU7mTeoBV32wP1Cq9l9pV?=
 =?us-ascii?Q?D0fMNHLpEbeLJAp8t47mtgSKrvnpr3cKbM6z6Ir/HbutBmDZivPdwH031EDH?=
 =?us-ascii?Q?k4wvn+/7yxaa4s69AN9DAZIasb+O1wmbX8R68pU/Ncx6nz6c/XXf8pkHvg6t?=
 =?us-ascii?Q?x1TeDJVcVFVTKYOoES/MbzKOi+y9Z3cdY/i5x4hyu1q+ux2ABYp/KKH19/N6?=
 =?us-ascii?Q?MtitJar+wjIArMjeTtDE4JQUmgDUIMXkUGfMy/1Eplf37zwnRjcmaOO3dsQF?=
 =?us-ascii?Q?AOX8Vh2Md4fJDHHoXHX+QAMh1SZ5s+ejBV3wWEQqe+5ZDcku?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7ffd52-2d1f-442b-fdad-08de7f5c6314
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 10:53:10.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptsSgBq2g6DvrD8VLCYmdj9ztQdoY3LEtRFDhPMaUoUCHSA+vaNhIt/UqSbjIcMnn8Clib5imGgUY2Ee8EUYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Selwin Sebastian<selwin.sebastian@amd.com>

Regards,
Selwin

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Saturday, March 7, 2026 12:26 AM
To: Sebastian, Selwin <Selwin.Sebastian@amd.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
>
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
>
> Patch 2 fixes wrapper_rx_desc_init() which only releases the current
> queue on mbuf allocation failure, leaking all mbufs from previously
> initialized queues.
>
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close() for
> the four mutexes created during init.
>
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring size.
> The offset is now folded into the index before masking.
>
>
> Stephen Hemminger (4):
>   net/axgbe: fix resource leaks in device init error paths
>   net/axgbe: fix Rx queue leak on descriptor init failure
>   net/axgbe: destroy mutexes on device close
>   net/axgbe: fix descriptor status out-of-bounds access

Since these were code review generated fixes, still holding off for maintai=
ner of this driver to verify
