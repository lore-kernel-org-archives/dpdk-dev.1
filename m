Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A8ECA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F9A402DF;
	Wed,  7 Oct 2026 09:24:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
 by mails.dpdk.org (Postfix) with ESMTP id 44F964027B
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:24:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXJ4yVy95YMktVd1cKq9cSzasBuC7xdqHJeSpQSCZLCYK/UMDTYQ9f49PGJjkfdtMTEWYuOjEKpujs8qMfSCAvadsoWX2tprpqDbfFAsL/L9C4nY2yNk3p77mNRrrN+JLhPACLoGn9hNJ0UNRDN+01hZJrBr2+1x6gH3qukGad0sWuPZzjVIL+osayF8NrjXPVTQyyNVFrV4roM2oP2WB8V4yx873kQrsocZt3E7d8FudVUFBL7OX1L4/zetPtskLGx2VZlaC5GjRHDFMTbUdtQq3uIgRC1Ao5Rbu54DyTVLBf16KvzExrw6Av6+Bab43z5tsMoiQpKK2QiSiOdRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oRrvWKOZRJvpQvA7/liDNlbS3hSJ06Hx4Q1Nj8kcCs=;
 b=P1yxTSVJaMg1wiFfw4cSKMcMod9FdidOf79cRJdrtkNNP1QIdb+ORKd3Axi1mHQovTCMJuN2AVRC1aT30Sr9ts0CG0m4hgscYNXL6O0dwZi/yOMZBzcfyf+Xa22shTI76BfBAsQD9GPUFjrieu8/ezCfv17oq8tUF+pTc0TQbpbPc/C+oNAmEyaOEqTmdWsAeiLjVT5xDaCbWJ3x+FPxSRz8Qof2fnmFlHMCYolt6Z6oaNLNz6EZyFogeb4e34rgE4P0MR26qSBhCTqO0ozdqC64mI1wsidazseRwcyvWZTiqNEpe1VotdGLuXbpa/5gXndkvK02RqeP0y0kPqTiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oRrvWKOZRJvpQvA7/liDNlbS3hSJ06Hx4Q1Nj8kcCs=;
 b=RNTITbqkmR4Wlz/CYTnx/eTgVC2Rjlw7tq+DR0Ab42epRU8S0ADksBbzWDFUp4sHxGGjCL3IbniCK1eRuiYj8oPUl2kxmWF83XZqYjCj0jH4KCVL3iYhiUBMHTd56Qn7RC9tYJ7uNRvWD/JrCmd3ncdkEWHQI3SizCILEUx/yvJrH9KqScywljARJHdHgddFfM9PW9PcBR9p12ZOSkZteLnGC1GsNl/NbIPewZZhNIp+539D+IHnD4zhjJlyz69ZVftISLvXLzFIjzi5H35RBaNI/l+NoHozKqI5X3g4O/Luofsqgpk8/doULJUOyPxhtrfGEsWF805gkKneRfkCrA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PA1PR04MB11506.eurprd04.prod.outlook.com
 (2603:10a6:102:4df::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:24:38 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:24:37 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdVXTh7ITYopKKI0+Aj4AC2jVX0rbwnEuAgAEP0I8=
Date: Wed, 7 Oct 2026 07:24:37 +0000
Message-ID: <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261006080145.33d89b9b@phoenix.local>
In-Reply-To: <20261006080145.33d89b9b@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-07T07:24:37.803Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|PA1PR04MB11506:EE_
x-ms-office365-filtering-correlation-id: 12c6d4d3-e4a0-43f5-e21b-08df24440b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|19092799006|366016|38070700021|4143699003|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: tTFRqFbgqNwzF/3RnEAat7har3RCi035BrbzC/KjtjvJU8vpS0WEkwRp4Yv2NsUzx/nfIt4BWUcR+cHdZ6w4e7i9AvcA8PWA6VhvcER0kT9x28Ph37L0Io75w/MhGkKUneVzoqRRQR2ZL/J3GSKhJ0xgNYi03S8LmJQWx3hun5DTb56UWBd5HPQKeednUngIyzLS+OgGgBEBjKwqFKWUi7zEGovkxIvmvntq3NjW49B2UFY7hW23rO2gWUYmtU0NPjqiUYPHi7ut2dTIYSQGozviJhN4AgnQY5P54OizSiNacp6ApRCGiinzbtZ/T6TRKHNKzTWKYVE1TdqAYzf17j0jJyGz6MpAORQKxrOap8JS2Zd2etF+dcDVY6eKK/6sqlAzai7dM33yztfnHv5sF28hKcmVw4LLANv3rJlXiOYjuefyQkORqnyq50wVkxj2WKxHZUg+Pkj24TNEGNDL7+xWPLp84BVBNmglDY4toe2a3kEuJYgNEd5uz9uRSmscZRI8awDQRPenAcRSiP2ASMBjdme4wbeGoAMtkc6yO90xxGJVemMHCsoIMn07IjFFfA/j9ww+Nai+pVklNC+z6RBw7P6A7Zml1hsn5XH16Alym7ha4m5+b7Ymr+xXjHVswi3QUgVjAtNlBcN54rpv9M0oQAva6cFqIxZtA4Z22spnOt9iNO2yb/R+wOFy6I8i8TbGQZVC+DsYQzaHlSjLJT9vGSAcRK6A2vb4pSawC9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(38070700021)(4143699003)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?3AVS8uV88P18M2R9/uSKIeHNhRPWvhLtjLeP08OjAjZr7ruwkaFpDuT+?=
 =?Windows-1252?Q?HFYSaRgn4LGX0HsLXu9X4qu+e/dMvNCFZ5YbdcU083abZIuKV3CqK4pb?=
 =?Windows-1252?Q?VfzZmpgYp074QYGeYOpBZy0LNOX/kqUrHlPxGcj7mg7/2GHy1wYSQElA?=
 =?Windows-1252?Q?u4YGtNu9XcR30XscmRDqLnTjsV8/sEiUYJo5dqR3HwAX77+6fmFZ1hA9?=
 =?Windows-1252?Q?gDFOKHU2MUyNWeK1w2NCH9LlhotEfy+KIbfw03S49LBX3XAoNwERKxKg?=
 =?Windows-1252?Q?mrnRazhE7kudUGgCBQsDj+ixBAdKy/jHy5UyjXlcSjnd25l+FGkhSsc/?=
 =?Windows-1252?Q?lgI8/N7sik/AGRyedoOXBi8BeqY5AmJ6n/itPzUJr+4uiMY7pob/EJhy?=
 =?Windows-1252?Q?IxOe74emAy2sHgv0vnzKm0FZTqMpoQBaj7zR+I1C7n1755/Wg3NVAr0C?=
 =?Windows-1252?Q?7PcxyTv7GtKtwbOp9Vl1eFO6520xcZkMJGzOBj0/x2Sv3gDOo0qufXXr?=
 =?Windows-1252?Q?EaI6KO84rWOX5iO+eFMo9l8CucR51wkaTDiVwTlnSr7Bbmv2PvbvKOMH?=
 =?Windows-1252?Q?qe7Pp/5HAi0ji8mhDAqZyVeP8C6brgkQiv+AEz6MsUeZDYDPwiBH0o3m?=
 =?Windows-1252?Q?n4dlCI7oo6ru1gpd8gLCaDeJWHzgT2U3rOVfq04x/JSucGC8RMrdqFQ6?=
 =?Windows-1252?Q?oXOeT7zwonfGyqVmshtRSn3VvWXxJyMCn3yAyXjYCEfx+3yEsxgOUH7S?=
 =?Windows-1252?Q?gThm47oe7KpIwpPkXyvYq4DXk/y70qgFWqzvjK+6CMRxdnKfqkqrdbaj?=
 =?Windows-1252?Q?KJrPr54l38vhXVJJjU/DuzHZLC63s2FYZPQyFvUP7e6ynLTUF8HgYCCT?=
 =?Windows-1252?Q?MjpRejF+z0adam/KV6hCmXPWON9/yJPe+Oc8fSh2ZvTr6Sn7U9Smxiae?=
 =?Windows-1252?Q?9+1+GZ98vvRGSzuJRPcmw5CiZlbCnu6ucnDRIJ+KqUKZKzhjxJC0NIy+?=
 =?Windows-1252?Q?JKR0y1Wm14iL/leojJ6dnJ+HtvA37iglq2bhur5GVVpQi60gpBPBlseg?=
 =?Windows-1252?Q?QMGox92kE43zWI5mvPKYSnQoMrJwieOvclFHv5LiMDXusJbHsqcSudYW?=
 =?Windows-1252?Q?kXbWK9DVFJFPk5h9OgwNBD6gFoI93zzVxjv6/fuaZnkyadaWf/KlJtal?=
 =?Windows-1252?Q?te89DvZbo4f3eb5AEMnoZ9kQgeAZ9Yy6b2Z5l+bpEmXfEOAw27rlpCCT?=
 =?Windows-1252?Q?vt3/BZ2uhM8JXN4gzs+dspsQv4kQhiHRarKHV5wBf6elTfQCoP7UNR+7?=
 =?Windows-1252?Q?gQ+rezvcZeBLVTZHXQ9n8zVCV/rdX4xCrDeI5LijBmXvOt2FFyEB+cPP?=
 =?Windows-1252?Q?kf9AI7faq+Z06InTHRzQqhUVIpHqDSrXn46Ee347qsYb5Kq/q4Ae1JMp?=
 =?Windows-1252?Q?gMvyesWsMmM5GKfTSV3aWdMKH49Cx/gFUQl1KVJcMLCpc0JkMCPC3sRN?=
 =?Windows-1252?Q?p4W0JCWN/PpIYXMBrHpvNslTyneb+Dp6CY/hPi9VsWdpKFP+V7qZX7gu?=
 =?Windows-1252?Q?nQhN3hN2Pc8IlaQBdrXGVZikchafPtU6CXmT3XhtdkGhYQ2QtsVe2gdk?=
 =?Windows-1252?Q?s5H+AP35gVqbm6FZ5RuHphgeq7fhJqGUXwruLWLAiLjYdui5uqlnbU5W?=
 =?Windows-1252?Q?wyT7kcK8T/JKz16smD5fVw9gksAykPrE0UzkM7gyNb/I2WAfPq/A4LgX?=
 =?Windows-1252?Q?A6ZOZa3I4RAG8HqhzgmFaLDS40dya/xAjj/SyoUeOLUOHIlMcMyFniYz?=
 =?Windows-1252?Q?vnCKsSHu81waYwuixTE2liVjgp7pQ6uJkQxldKgkRFoqBRgRnJnHMm3U?=
 =?Windows-1252?Q?VsCWEWVWTqKyew=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c6d4d3-e4a0-43f5-e21b-08df24440b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 07:24:37.4754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9bfX1gufJJ0p8mqnZh83krGhL76QhNsxnN+fZ9p9HHwRFP7RZLwNeZljoui10GH7e/qHVi+mhkHVyizs6XPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11506
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

=0A=
On 06-10-2026 20:31, Stephen Hemminger wrote:=0A=
> On Tue,  6 Oct 2026 14:56:36 +0530=0A=
> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
> =0A=
>> This series collects a set of fixes and enhancements for the NXP DPAA=0A=
>> bus, mempool, dma, crypto and net drivers targeting 26.11.=0A=
>>=0A=
>> It includes memory-leak and resource-cleanup fixes on the device=0A=
>> remove/close paths, more robust frame queue and congestion-group=0A=
>> shutdown, secondary-process safety guards, BPID and cgrid lifecycle=0A=
>> handling, and several new features: offline (O/H) port device support,=
=0A=
>> enhanced virtual storage profile (VSP) port support, fmcless Rx queue=0A=
>> configuration via devargs, Rx/Tx taildrop threshold devargs, non=0A=
>> fmX-macY shared Ethernet naming, and DMA scatter-gather and=0A=
>> errata-workaround devargs. Documentation and release notes are updated=
=0A=
>> accordingly.=0A=
>>=0A=
>> v21:=0A=
=0A=
It is becoming a never ending cycles.  Every time we fix, it finds new issu=
es. Can we put a limit to accept it with no errors and minimal warnings? =
=0A=
I am anyway fixing the following and sending v22. =0A=
=0A=
> More detailed AI review shows some outstanding issues:=0A=
> =0A=
> Applies cleanly to main (49bb9a5).  HEAD and each of the 27 commits=0A=
> build with -Dwerror=3Dtrue (gcc 13.3, x86) for bus/dpaa, common/dpaax,=0A=
> mempool/dpaa, net/dpaa, crypto/dpaa_sec, dma/dpaa and event/dpaa.=0A=
> Not built for arm64.  All Fixes tags resolve to the commits they=0A=
> name; v20 02/27 had a nonexistent hash, now corrected.=0A=
> =0A=
> The v20 items are addressed.  The CGR delete on a never-created CGR=0A=
> in 11/27 is gone, the 04/27 Tx gotos are fixed, and the commit=0A=
> messages of 02, 10, 12, 18 and 22 now match their diffs.  The 19/20=0A=
> devargs are range checked before narrowing, the unused defines and=0A=
> macros in 15 and 22 are dropped, and 25/27 saves errno and releases=0A=
> its FQIDs.=0A=
> =0A=
> Two new problems come with the fixes.  01/27's rewritten message=0A=
> describes the wrong mechanism.  The FQID release in 25/27 runs even=0A=
> when the FQ did not shut down; 26/27 has the same pattern.=0A=
> =0A=
> Warning=0A=
> -------=0A=
> =0A=
> Patch 01/27: The new commit message says rte_eth_dev_release_port()=0A=
>    calls the close op again through rte_eth_dev_destroy().  It does=0A=
>    not.  rte_eth_dev_release_port() never calls dev_close, and=0A=
>    rte_dpaa_remove() never calls rte_eth_dev_destroy().  The second=0A=
>    close was the explicit second call in the old code:=0A=
> =0A=
> 	ret =3D dpaa_eth_dev_close(eth_dev);=0A=
> 	if (eth_dev->state !=3D  RTE_ETH_DEV_UNUSED) {=0A=
> 		dpaa_eth_dev_close(eth_dev);=0A=
> =0A=
>    Describe that instead.=0A=
=0A=
fixed=0A=
=0A=
> Patch 25/27: dpaa_oldev_queues_release() returns the FQID even when=0A=
>    qman_shutdown_fq() failed:=0A=
> =0A=
> 	ret =3D qman_shutdown_fq(&dpaa_intf->tx_queues[i]);=0A=
> 	if (ret) {=0A=
> 		DPAA_PMD_WARN(...);=0A=
> 	}=0A=
> 	...=0A=
> 	qman_release_fqid(dpaa_intf->tx_queues[i].fqid);=0A=
> =0A=
>    qman_shutdown_fq() returns -EBUSY when the retire does not=0A=
>    complete.  It also returns -EBUSY when the FQ is scheduled on a=0A=
>    DCP channel with frames still queued, which is where this Tx FQ=0A=
>    points (ch_info.channel_id from the O/H port).  In that case the=0A=
>    FQ is still live in QMan, and the next qman_alloc_fqid() can hand=0A=
>    the same FQID to someone else.  Release the FQID only when the=0A=
>    shutdown succeeded; on failure, leaking it is the safe choice.=0A=
>    The Rx loop has the same issue.=0A=
fixed=0A=
=0A=
> Patch 26/27: Same problem in dpaa_sec_uninit().  Shutdown failures=0A=
>    on outq[] and inq[] are logged, then the whole range is released:=0A=
> =0A=
>    if (fqid)=0A=
> 	qman_release_fqid_range(fqid, internals->max_nb_queue_pairs);=0A=
> =0A=
>    inq[] are QMAN_FQ_FLAG_TO_DCPORTAL queues towards CAAM, so the=0A=
>    -EBUSY case applies here too.  Release per FQID, and only for the=0A=
>    queues that shut down.=0A=
=0A=
fixed=0A=
=0A=
> Info=0A=
> ----=0A=
> =0A=
> Patch 11/27: If qman_create_cgr() fails, probe now fails, where it=0A=
>    used to continue without tail drop.  That fixes the crash, but it=0A=
>    is a behaviour change and belongs in the commit message.=0A=
fixed=0A=
=0A=
> Patch 17/27: The FINI now uses the literal 104, but the=0A=
>    "#define RTE_PRIORITY_104 104" line is still there and has no=0A=
>    user.  Drop it.=0A=
=0A=
dropping `#define RTE_PRIORITY_104 104` breaks the build =97 `RTE_FINI_PRIO=
()` token-pastes its argument onto `RTE_PRIORITY_`, so `104` expands to `RT=
E_PRIORITY_104` and needs that macro to exist. EAL only defines the named o=
nes (LOG/BUS/CLASS/LAST), and net/dpaa and bus/dpaa carry the same local de=
fines for 103 and 102. I hit the `error: 'RTE_PRIORITY_104' undeclared` and=
 restored it with a comment explaining why it must stay; objdump confirms=
=0A=
=0A=
> Patch 25/27: The FQIDs are now returned, but qman_create_fq() also=0A=
>    takes an FQ lookup table entry on 64-bit builds.  Only=0A=
>    qman_destroy_fq() clears it, and no DPAA driver calls that.  So=0A=
>    each probe/close cycle still leaks one entry per FQ, out of a=0A=
>    table of CONFIG_FSL_QMAN_FQ_LOOKUP_MAX (32K) entries.  net/dpaa=0A=
>    and dpaa_sec have the same gap, so a bus/dpaa helper that releases=0A=
>    both the FQID and the entry after a successful shutdown would fix=0A=
>    all three.=0A=
=0A=
This is a bigger fix. we will target it later. =0A=
=0A=
> Patch 27/27: The FMCLESS default Rx queue count change in 20/27=0A=
>    (rte_lcore_count() to DPAA_MAX_NUM_PCD_QUEUES) is user visible and=0A=
>    is still not in the release notes.=0A=
=0A=
 fixed=0A=
=0A=
> Pre-existing, not introduced here: in FMCLESS mode, dpaa_dev_init()=0A=
> gets Rx FQIDs from qman_alloc_fqid_range(), but net/dpaa never=0A=
> releases them, on close or on probe failure.=0A=
