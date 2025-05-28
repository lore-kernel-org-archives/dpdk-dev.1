Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF78C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 09:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B924067D;
	Thu, 29 May 2025 11:56:13 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1BC8240156
 for <dev@dpdk.org>; Wed, 28 May 2025 16:50:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=end3uE30A2TIHkkILgnI4SSclqZrflslh3Ed1kFkHfUdWxP//srcGRGsHUS8h+SlMQuDlpkzVx8/db5cVPGPO43WBMFcxIkbh/CYMvQLBe9bDTGwqQKarMOr4GRF9DTqD3q+E3tVKKMVqUh13C/4u+hRxZe6y1uiRauy4E+4KXQxDQH5k3RLyA6BNNmLtqs4PkKxiy6zmu34INJgoYqbl0Ue/hEHAHq5xZQa5O8xFdtKxzzO5aayV2lx2Sp/r3MVJ0JzXgdLuw//YKUNphTQiJsA6i5vR6/CMSOnAeePUPmUUYFIBIRsmgtl3Cx5A0qOYWgLNuWX1c2dh/OAZmkLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou5ZGYVk2QILVCp3DqtXaj8D4zWjn0LcaSUpgz8hMF4=;
 b=MRi3GzvNoEdek2uDTQX3lmC0h+WLd+YwYHBzjxYw36mQki+PqGM7WArZOzBilYy/BidZZ+WeMpmNwJS13gVO5phJ7fffDbNIxYt6t/4FGDaaYgRjQvmANgPS5kZDJavIaw67ipjTJuZPmv0I3EsOROr8JfTtOQ/DHhlyLf4TtWThCnTfLVBBl2yUzFWcxg4wzX+OHcMl27pCQ4LI3lM/MaRNNQbpCJ8SDBlWjAmCUJVftxPjFocBIX0TfqmvyRVV0h+ySgXMWgoRQPFUqOs4lzRVsybyQe7OkY/gmqZP+j0J3Q5j+xCXiaIhWTia7JZFaY8FTC9yR6uUx4sF+F4jRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou5ZGYVk2QILVCp3DqtXaj8D4zWjn0LcaSUpgz8hMF4=;
 b=Wn7bSajanQ+Zf+36cfXnxdPeSjoLNAL7hfQ5Z9snpCCGbziItd5j9xyevfshLot93irfDj9WS6+3HRZAJlPGtsCJsspxaqgvRRlgxaxd9R1w8Zzat4BvgnM3IoMl94wZbMIphBObogekJ01TGm3TyfDM32QNjtxM/x/BmtbZiElcMzU9WOeZ7kxv8rgK5XejHdFFNifNlbQW3apASDqetf+LNA22vCoy9Ok5m2ZYVC6tPj+W/9O2Yr+C/FxLrse81XipkV/qPyvmmjvNLBYh+qCS8sgmwoajN6pw1ou2RkWFGnC3phDlf2Op5xLqP7H70M9jWpVn0i435Jbupq+4gA==
Received: from DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 14:50:21 +0000
Received: from DU2PR04MB8838.eurprd04.prod.outlook.com
 ([fe80::7fd3:4b91:ac1c:6a1a]) by DU2PR04MB8838.eurprd04.prod.outlook.com
 ([fe80::7fd3:4b91:ac1c:6a1a%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 14:50:20 +0000
From: Jun Yang <jun.yang@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Vanshika Shukla
 <vanshika.shukla@nxp.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [EXT] Re: [v1 04/10] bus/dpaa: optimize bman acquire/release
Thread-Topic: [EXT] Re: [v1 04/10] bus/dpaa: optimize bman acquire/release
Thread-Index: AQHbz7zQ0B4R2G1eKEqtnBev9WT7mrPoGrOAgAAEN7A=
Date: Wed, 28 May 2025 14:50:20 +0000
Message-ID: <DU2PR04MB8838C15A7C6E780C14FE10E19D67A@DU2PR04MB8838.eurprd04.prod.outlook.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250528103934.1001747-5-vanshika.shukla@nxp.com>
 <20250528073041.242f48ab@hermes.local>
In-Reply-To: <20250528073041.242f48ab@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8838:EE_|AM7PR04MB6951:EE_
x-ms-office365-filtering-correlation-id: 66120c4e-29fb-43c7-f04b-08dd9df6f83e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iqjUFcjM35MeY8nxYlYMgA9CVb6FC2XnS8SkXJMnAOXfLCG9TR/dIgJ6YQCG?=
 =?us-ascii?Q?T41rKOL/RlJGVTfXxnzKDWB5qggaUasV+LMYI/U4Z/u2NbWMmH0ngK4s+Znf?=
 =?us-ascii?Q?ZjZEEbYPsu7Bn2L+EmfHh7LT0OucvEHQcdF9FILheMvPAn36XSwa9rsNnnYh?=
 =?us-ascii?Q?tRV+oCWpsLfdZtB3g0jYMaAP5Cf9ncZOess6DeWeo2WiNsbSl5bOZhmyKBNu?=
 =?us-ascii?Q?vsUghLdSDHV0brle7vL4rHtpiZYadrfMqrQMJsV0TUEMDWjbRCiSoPIjHEhL?=
 =?us-ascii?Q?KHhhN58VjqhneQOLRARfpmvos/fVNUW+WCYZJOHrbQhQzY1t8a0skFCE3LNA?=
 =?us-ascii?Q?eIGVJpGGBgUoOAJkKKMY1NkTdw30t0Npt+PU4MLbQyyW5oOb/UppZcWhuqNe?=
 =?us-ascii?Q?uk7l/mhESh6NA/qHUxWDlBIUKUjaBwRRttfffKqGpIoxF1kBYz0X1sSDIMK6?=
 =?us-ascii?Q?cS9Axv1f6KfOJ2e/Jv1BiFA/GxWPOwgV0B4i88rdSUZPgLpB/EV4JP0AtwGe?=
 =?us-ascii?Q?WWgx29MDIJxMWKhzTw8pmZfnHzqNfPYQNBSfj1MY6q8M5iiHU1+rNG6Rs+sI?=
 =?us-ascii?Q?fRf22VA16+keVo3JS85PrDpG+PbmMKVwuyMHprRZnp2DwtdxuFi5eNgFij56?=
 =?us-ascii?Q?fV9OHECwQYzumJUjZlULaqXVR1WCE0mIuJLtuH80FBvi5FPR3rR8DdZa/S+H?=
 =?us-ascii?Q?V/Dh3uEPyuKnrQnsyZDDPI2m6wPo+JhfV1ccVubyS+SrocGLsL6sMZUeA8J1?=
 =?us-ascii?Q?frBSqwI4vzU6cu2x/y8FTgRdF2iuvh58mAz5LLodNvOeZ105sm//BtKYfbRI?=
 =?us-ascii?Q?SoR3UV97YEINnBm7BGfELDZIy03ngrAM/AC+i9sow3dRdecVJFVsPOrC3oK5?=
 =?us-ascii?Q?2n4oMjzaxLHwKOdk9L5qwwUnJDuRAG9wxF4YFfxLxjSEBEiSvWdWwhMP212b?=
 =?us-ascii?Q?LECK1uS2H4BbvAAkzG55Zpb7Gzj8FDWPdbiDXQqQoiDXF732dtaTp9zDfAkl?=
 =?us-ascii?Q?ODFJDsvbaG4xiMISp2uD1EANjrZnZumwoONYxPr5AcM24O1ayFLCgF2lOV3J?=
 =?us-ascii?Q?UG4Z8BjvUTPLV61w9tYj/qRUwz8EGcWpVigXWnyMS5EDtEuQ7yuuH2egBeUE?=
 =?us-ascii?Q?4eVBZEDkvmLK4lm+9ch9mR4bIV3u5+c5/ywwQ6QsWyEqNvatD1tUVKmtnPnt?=
 =?us-ascii?Q?ZGCFKFhb1xxFx3xu2mKKzEwJXpvE92BfUHbK8NLlcpyl2G2lkZXR/IQTw3bE?=
 =?us-ascii?Q?6gu8vS672ZPw2mvMoJst7w6WBL5fDpr07F4oL7HDYmoA5RMkaQhJt2xqMJXF?=
 =?us-ascii?Q?kB33rAO6qUuePSTcrdUOM37iOydWm5xgpdDFiswxPh0H8+lG3ywFn6UEhVrS?=
 =?us-ascii?Q?OBlZhhFrnQPRlSnSEjC6Usy1PHkhYUKDNPuJZf1WjHAcXEF2RRTOkC07maCa?=
 =?us-ascii?Q?nAaa/Ad0GNaTAwpXbq3fKFyL334pcNBC0u0o8BOPca3q3CW4KME4inRqDDPn?=
 =?us-ascii?Q?rG4wGMlyQnDZEJY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8838.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EqIGCU3l3j7R4tpISRvs+J/z9OsDxNA3B7EbbS1mN3aq+7uUIiwg5UtIlnBA?=
 =?us-ascii?Q?EXkr5CWk3DjuB8u5ggxHroCd64nUszTEEFVr8cmB8f1fAxaWrx746MnOro5/?=
 =?us-ascii?Q?q4IryhrNLT0xsAzDB0dzCVV2nx9Q7ND9gmYaq7ZDmWfz/jJj6HnLCkAy3STT?=
 =?us-ascii?Q?NnJYCowWN4DoBQB8GFpls4/78CBzSecUFA73QJea7e7EiorFLEBiglZtLH2L?=
 =?us-ascii?Q?8Y9v75MUj6p5qiPiZFB3uzkKQQYcyAvHyfYUfJw6wriSORfMQ+in7XkcInWk?=
 =?us-ascii?Q?uUkf8lu7VF8riaQL1LyYM6g/PSZzecqqpyAfTH6EizvreUZo4yMBANsaIV4g?=
 =?us-ascii?Q?mX8dgpB1ZREarJNHtBz2rPPcLkjQoAJOHsYuRt9Uk3+iS50la3xiUuwIh++Z?=
 =?us-ascii?Q?bFnFhVSfEx0UDdj49fhlEWpnz2hZqC801+gUh3o94CQVvslua0tfO1IldFrv?=
 =?us-ascii?Q?0oYMMTs/eX9BH1j+WoGBDtA6pu0liE7TgPTFF6zdgZ2zeQ/Ofk1fad1Mp7Uz?=
 =?us-ascii?Q?3/j/OC0w9nxA/fMph8lY7FcK/A7+1kuhyIDtmWnqJW1/JH5zR81gqy9puDBB?=
 =?us-ascii?Q?mUyrFTBbN8lj/Kcf124s/XF175jwJtTpCFQKOmEe7UgNWsRvcEPgImUyvOae?=
 =?us-ascii?Q?PRiwYXFO9m2lT+kKibM3B7h3p52o0YiJ6CUv4Lj5u53CgVhMRLTb6PI5LYs/?=
 =?us-ascii?Q?t8P7XhM0RroW4F0/Qi8IHtfBvwJ9O9gx0DfupBGccNM2rLOdl57kkubCohob?=
 =?us-ascii?Q?pjkfcrtI1qHthwtuGwXcot76M9ZTkOvLrD9CzgBJu1X9Lx/lF8KnoJJuOy5j?=
 =?us-ascii?Q?mATjjp/KZAh8DGPMbQqdHdiCBqekfa+hMgLTTfan8MSmAdVPRcyqhEoqVGv3?=
 =?us-ascii?Q?1O/Zpp5Mvf08l6UQzwRFEoxj6FZL19vH/6LnxyPyjLXaYo+CFD5tWU+wMPXm?=
 =?us-ascii?Q?TwkyWcPCnesDLmU5pk5bwLMQ7Z2DiV5R8bwrKepJu5MgSOjyU6C3Yc6gVpML?=
 =?us-ascii?Q?uQOZcQGjDmeNHMlLO9RKpXqOQaqTyogifOwuUhr7EvcIvg7JDNCT9oAB0U7v?=
 =?us-ascii?Q?hzttp9t0ex7gHfpBD7+YMbgwT8SN2l9iOIwvDYTuwIX2oMD13oWk6hh1Ka33?=
 =?us-ascii?Q?4m0MmkzUxGrfEOPAmb7296E2KmWUzOPbMM4VSuL/FxAx1yQ43RT+EFqAiq9L?=
 =?us-ascii?Q?odI33e/z+LWwHyaUBD0vX2F9M9dPkamDT2caFBLV4SrKUZoPTlMLMgisGiXN?=
 =?us-ascii?Q?mNncQzvdtxXRNNwDv5E1+Qcnck2LHaJLnCgQZUuTnxi2PhgLpKZe/RhJX6dA?=
 =?us-ascii?Q?fAZ0DIkP+IsvZzQ14Ti+1m78e6b74tcc2DiL4nyQ+/tpCMdC4TwzY2Tscm2W?=
 =?us-ascii?Q?NiA26LcjHWEerX8IJwMXYMnK9O81ctil1iA5AW/4m8ZGSCLeTgi/ZtwAPxVa?=
 =?us-ascii?Q?HmFOxg+P1DnKUYFhWGstbFUP3kcoU0C4RuWqz9jMXLdpxUoyZfTojANx5bKs?=
 =?us-ascii?Q?kegLpRkOyy+Lmca+G3LdA6Sqy1PGjMQ4texOTvFWmQeHXaKYtpZFXsQfracC?=
 =?us-ascii?Q?dUVMP8Vnmvr5JnqTNmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66120c4e-29fb-43c7-f04b-08dd9df6f83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 14:50:20.8737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVEwGCZsBJfGfqxnC88cMJMeJrzQ4eUEVEqGZYj+GHgsNXmH132rxBSQl4p+ai3FQ7S89tfQshcQzf8idH+Xqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
X-Mailman-Approved-At: Thu, 29 May 2025 11:56:11 +0200
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

Hi,
> +     rte_memcpy(bm_bufs, mcr->acquire.bufs,
> +             sizeof(struct bm_buffer) * rst);
"mcr->acquire.bufs" is located in register space, it is supposed to improve=
 performance to copy it to DDR(bm_bufs) to parse and read.

BR
Jun

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Wednesday, May 28, 2025 10:31 PM
To: Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena <s=
achin.saxena@nxp.com>; Jun Yang <jun.yang@nxp.com>
Subject: [EXT] Re: [v1 04/10] bus/dpaa: optimize bman acquire/release

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Wed, 28 May 2025 16:09:28 +0530
vanshika.shukla@nxp.com wrote:

> +RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire_fast)
> +int
> +bman_acquire_fast(struct bman_pool *pool, uint64_t *bufs, uint8_t=20
> +num) {
> +     struct bman_portal *p =3D get_affine_portal();
> +     struct bm_mc_command *mcc;
> +     struct bm_mc_result *mcr;
> +     uint8_t i, rst;
> +     struct bm_hw_buf_desc bm_bufs[FSL_BM_BURST_MAX];
> +
> +#ifdef RTE_LIBRTE_DPAA_HWDEBUG
> +     if (!num || (num > FSL_BM_BURST_MAX))
> +             return -EINVAL;
> +     if (pool->params.flags & BMAN_POOL_FLAG_ONLY_RELEASE)
> +             return -EINVAL;
> +#endif
> +
> +     mcc =3D bm_mc_start(&p->p);
> +     mcc->acquire.bpid =3D pool->params.bpid;
> +     bm_mc_commit(&p->p, BM_MCC_VERB_CMD_ACQUIRE |
> +                     (num & BM_MCC_VERB_ACQUIRE_BUFCOUNT));
> +     while (!(mcr =3D bm_mc_result(&p->p)))
> +             ;
> +     rst =3D mcr->verb & BM_MCR_VERB_ACQUIRE_BUFCOUNT;
> +     if (unlikely(!rst))
> +             return 0;
> +
> +     rte_memcpy(bm_bufs, mcr->acquire.bufs,
> +             sizeof(struct bm_buffer) * rst);
> +
> +     for (i =3D 0; i < rst; i++)
> +             bufs[i] =3D bman_hw_extract_addr(&bm_bufs[i]);
> +

Why do you need multiple the local copy?
Does hw_extract_addr modify the buffers?
