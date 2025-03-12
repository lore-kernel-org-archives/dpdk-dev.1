Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D57C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 00:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CBE140265;
	Wed, 12 Mar 2025 01:33:55 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazon11021106.outbound.protection.outlook.com
 [40.93.199.106]) by mails.dpdk.org (Postfix) with ESMTP id 424AC40264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 01:33:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4LyKLifRO8HNGWRLsKuLZwm4ztUXLRN1M95QTOmhdM641jmFIiTF2hT1c5LYkiYqNHq3Klw0C1A6ucfBaPrdrv0fa5q0HYZ8hmRUJ8uDdUQz+edrlJT0w27ScoKbmASPS/9R4nARfnfNcCE0HN516S5AswbTmF5qS/QfqMBuB/sufYk0cFXsSS5D0TmSs4O1emYttAD2BeI7EU2XccrIHbjq+7i3wN9DXgwHcZS5kVJeHAN101N9hMA5elNmyAqjNU/3lksonioZqY+qdO5I/KRSPCxsHxggQ8nRAYrSJVwgAhsmCflxh3aRlRFQKDLKRMNXqpeGL97Y3+sssrB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUwjne5bY9xP+KUkLyM7GKcMlK+n5h5HXFBcuSfi81Q=;
 b=CsFv29ljwbnf7hCnaL7+7JF86Y3xKUuCmtWzD++n99BqIjsr8EZMH047pyag3gMhSdGst6GkL8xShDd8SMBLqK1cObOSjJ/zNT+id0qyX6emOtY60QnZnbhb3gr2SvMM8n85GwPqB81Z8tiMTE+F5NZayvtcQGq7LDMcB92TIgulKQSKVLj2f7S/4AjYmIgm9YjT6ZKYDmC8bK3D3Z5T2OMtpAu+dhCciAOuZh1xAZsP5heIYThHchLuRefS13+M9BTQ5cHQlcaJ2qwFCJIcfIQvukW4mHIItvYS3cbs4TBwrvTr139GKjs3avDsgf5BVdRS61TfGNH9FMf2oqWtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwjne5bY9xP+KUkLyM7GKcMlK+n5h5HXFBcuSfi81Q=;
 b=ODfwQ6q/kTGe3mx7MBQC1Bdg0p5e8SHDLdN2uTK8TYh2nxJ5P1yP4D/HuGYCHlSHjeaAVRlZO5yWGLD08M+ajerz8hCsG0TPmT3SF3p+T8CsF80KcSjuWLqY6UYMbtm7qBD/KLBBO5qY+4KL1TzZ8bTE5VtyzDNIJ5jD4bAIdbE=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by PH8PR21MB3926.namprd21.prod.outlook.com (2603:10b6:510:254::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.21; Wed, 12 Mar
 2025 00:33:52 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Wed, 12 Mar 2025
 00:33:52 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Topic: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Index: AQHbkhMMqddCMyfSsUuQ4ghuHsMq3bNulhjQ
Date: Wed, 12 Mar 2025 00:33:52 +0000
Message-ID: <SA6PR21MB4231702177B6AACAF54FF40DCED02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
 <20250310162038.5c05ce8b@hermes.local>
In-Reply-To: <20250310162038.5c05ce8b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=18470bc3-b783-4f0f-a84e-b94d2857ea52;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-11T23:27:15Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|PH8PR21MB3926:EE_
x-ms-office365-filtering-correlation-id: 0a19c51d-9a15-4fd2-9e5f-08dd60fd905e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UsRGUPgTKgKtAumByesWjUjVcvqCGKs/9yJSrnjIf9Ir2TxZOtRKFBMF+Lwg?=
 =?us-ascii?Q?ex0sD9mvtsKgetoP4iLD5SrMQdGZehj0qVe9oELejg9cSa2THWkLyL5rgDeo?=
 =?us-ascii?Q?8TtbHRB+75OQoO2xN8Dldbz+qEizwOV3ICkzIwre6g5StctNisSE7wDsd/JQ?=
 =?us-ascii?Q?PNQgkb8nS1LTCRUS1LCJXLG1IjDHhNaHzbytu+w8opek5ROee16Z2JTVbZYU?=
 =?us-ascii?Q?N9IJRE+C9OTR49eZGb0m12JRyOLjMCHqDwlvIi+2Kozw2tSiuLW5/lPAyL29?=
 =?us-ascii?Q?IfdV1084QYtJYxBkkUQg9kQJM63BKg0teZqD3hsGHi11nnJ/Ywzx8PahwHbk?=
 =?us-ascii?Q?Eaeyj5ypeg9fND1IySuzS/sSPZLoF9Q3zua4oWNcU7zIozkAvaGt6D80yYuP?=
 =?us-ascii?Q?D1aR2TKpG4rkeCOnkTkAX8es6x9WOQu56Walt2vhYz6/nDMhtQYNUMk+z5/f?=
 =?us-ascii?Q?Kmc+Bafi0P8LfG7Ybzh9EhOL5jHI/zD2QYUG6PjMUryyMpW+pkEcbKYKQAiV?=
 =?us-ascii?Q?34JZnRycLP3fIYh1vfDvYvmRkHR/jyJzdHR9eYyXVBzKUJtHHDdLvHUndKUJ?=
 =?us-ascii?Q?c/u/sFDQpySwhL4rrk+HkXevtzq6qC0PLmcmndADKtbctjjh1ykZLkAfbeuL?=
 =?us-ascii?Q?ZXrmN1n3KyqMlk5jFguFxeih2oxJQi0B38/yp6PaIluzxm02Gjz2EMQ9QATd?=
 =?us-ascii?Q?/Md0oJtTYrFZxz49/+WljucwIMpRZ9GG644L1mZQocW8UVMkouH20ILoS2E4?=
 =?us-ascii?Q?W0G7pequo/6VQJEi4GMKQudLGOxZGSVlZPnLNNHrPKykOKygVdNLXvdiYwDX?=
 =?us-ascii?Q?rPFEUqlZQJpyW/+M9v8MqPApEugJrsVfxcUs2DccY5YIWnEloeFVhUj3wNX0?=
 =?us-ascii?Q?u5//yEf7u/99O4YiStPBNQflH6OcO42/RK0fAIwaYRPKFboB9Wbh8LIUuY7s?=
 =?us-ascii?Q?unlvmBesiBjY+P4NvEgFw2dX70hRI5eieYADDCy6d9Q4YOC2QZNZUth1PfFw?=
 =?us-ascii?Q?4mXcJapsOYcuFOelAjv8oiBBz9q03UI1m1rRcxohGa2PiuTf3vGsEEKDASDl?=
 =?us-ascii?Q?eCgtZWtbcLhLDxOLZL3eaZ477pX8ugVOZePfXI+HPzSb464W97qJg6yHgZej?=
 =?us-ascii?Q?p1f6D6NsTzbUfGfD06x4Oxr/vh+4iVZakyxV+dm4K8JHd+Y8KVlOVJZAmNpK?=
 =?us-ascii?Q?p/Pzi1mSM0l071YOFaSEmCsWGdgS6xGfLT4HtqfCJ9OjInUN7r/Ib4IM8PCw?=
 =?us-ascii?Q?nRiM5kCASPPsI4vXgD+5hZDw97PJ1TrTpAScLybvFn+m1DU3cQQZ727I85Ns?=
 =?us-ascii?Q?UFotg9YQ2N6D56HuQhcb+XAQCpbnMSTmcmG9WoupLrG51xNbvFGGylDtA688?=
 =?us-ascii?Q?lLFynPDm4F5X7HMIHLY3cFOtRFhptGWgn/ZdmJJzwsbjH/wnsDMLxIztTfoE?=
 =?us-ascii?Q?q3LzysvK4Q+MBGKv6lRAL6CY4nmMII3L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GWdajKl5y+pTYa523eMZuBW18P5u93ZMEAbN7XwmE7KLUKeNusmJ/mt6VUzo?=
 =?us-ascii?Q?9pRkt56QTheq0AOuyXhr9hoteguYuRz0OqnZNmmI7FC/51munaoVHhF+KUKC?=
 =?us-ascii?Q?LBFv17Ij7rbF123ikB2jlBsTtnTTpZHxYxBZZDYI4I0RiTmFnVgO7Ee37oxJ?=
 =?us-ascii?Q?eaihf2edI9jNO/260digk6bn512pKhsq7VuKfH3vCgdDxeSJm4OXo6AYEs24?=
 =?us-ascii?Q?phzDegigCPWkEUnx0rwIjXxFt8ZM+IwTfpk37Qnny17j7QpmuZMpQPDSLD5S?=
 =?us-ascii?Q?XIGErNvEgKtUHkGUpcnGTliV/HKnTw6uKjmbKO2pTS92QKD38w9QnFb4GKv3?=
 =?us-ascii?Q?pquvG/b6A14mer9b4OPO27Sdm35t+/fLzBW0P/KB7mnJDLiua+U7d7tx/4Ih?=
 =?us-ascii?Q?mrMoMG1zJBTFgBUq54i3OANC9+YXd81gwwegTNZX75NqoIbLk8ikXuGZz4Ti?=
 =?us-ascii?Q?gBPP87jQ+H7oi3CGG6gjK4sSzBBBKoTH+nfGMTzpmgZ6ixkEZRBGe/1OM6Ys?=
 =?us-ascii?Q?1fq5z4qrELu5EqkyZU+rhzZIOEbQuRfmx+YVthD6ptrqdwtw02hUKz7mHmxm?=
 =?us-ascii?Q?M5O95mPshncBNsVGksfPCsCkWVA0iyt6V+B8vrz5E0jFO+oS0jYkQ6OJhxqP?=
 =?us-ascii?Q?9wh/yxotKexpOxi3+P/GF1Ycp187HZNkDv9lC4AGM0UkHHJSDi2DhAXaB9VX?=
 =?us-ascii?Q?hC0SWrpgBczAxMDuk5j1PYPDidzK1r0ldRh2lrCD7NUdmXpWFfT9X6yySmZz?=
 =?us-ascii?Q?iToyVxuxzDWlnNYxr7Z61MAyXEfxD7/xInq6adyzX78+fmVcLYcDmBN+lzNh?=
 =?us-ascii?Q?kbeQuG/bR2/E5Iy0SxSCOISq1NXuBy4ctA4jwhihR2e5a5+n071WyzTBzX8S?=
 =?us-ascii?Q?puE1ZyB54ysf/NICgxFS4h3sy34InyvgAFEDJZ0G934j9PH59Q3SksBg5ycJ?=
 =?us-ascii?Q?fpEkNSXIPeUvaWgzTHXtQlLvSHIuEkqDq4U9a3Ym+hSyHwuzr1Yjyw+4CsHt?=
 =?us-ascii?Q?QJm0dqqTLJUddExsEhzeSLTcTaQ608qg52QzAM6tlbUsHVPYNe6NkitwxCDZ?=
 =?us-ascii?Q?glVvEFRC/4jdfo7wEg5nx4NusWa1APhJK4x6QV6uiYTzr3NovqFDDPumIw/j?=
 =?us-ascii?Q?yDB0Su20neL8DBPqdTptqv7uMfeBUeeff/bBARiWhNG7SYLb5MbGmQHm+bvy?=
 =?us-ascii?Q?nzhp78ThHrgea3hfZB44pOm05+CofiIFum6XsnSCe0t/tNYZN71kVwBUmOLv?=
 =?us-ascii?Q?OzmKGHbeAKjvMLiHTUvugqzA8c2JMeye5nBDhdDisqg4Qe7oZ+pVNawKGDF9?=
 =?us-ascii?Q?YfLsa/HF3G6crVaoCgJ7axVwuRn3aYrbBFIFEVsgst4USiZp+CYW4OseYp6p?=
 =?us-ascii?Q?xCOsvTLq5jxHjuOWmmNRr55v4ybucQVfpfAgtdfMYnwKZhUZCE2iQ/D7Wvdk?=
 =?us-ascii?Q?Ag9vgmplucu0yp15g4E0kQEqmgt62Kkr8gFVnlcYli9QiSdwitrb/KfRpuRQ?=
 =?us-ascii?Q?hKEabNYOPmORVUXyoHcmYYOJeWzmIpqlj6KPfd5vJuB1aT6KK8PYWWqfvlYN?=
 =?us-ascii?Q?qwD+h+8wbf7p1dOu6SnTl+ztVmo0m8j1ld4P2P3p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a19c51d-9a15-4fd2-9e5f-08dd60fd905e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 00:33:52.1126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xkEV6Fzlv3DkvhkHIrOHjCwY91qUztuHvdJkj9N7uMQZWDRlCrONhn9fIfBxgFz6aPIZ7UGZnrABBzwslLuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3926
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

> Subject: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
> monitoring enabled
>=20
> On Mon, 10 Mar 2025 14:42:51 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > Hyperv may expose VMBUS channels without monitoring enabled. In this
> > case, it programs almost all the data traffic to VF.
> >
> > This patchset enabled vmbus/netvsc to use channels without monitoring
> > enabled.
>=20
>=20
> CI still reports a build issue

There are ABI changes to rte_vmbus_* calls. This patch added rte_vmbus_devi=
ce* as the 1st parameter to those calls.

This will be a breaking change, and it only affects hn_netvsc as it's the o=
nly PMD using the vmbus.

Reading ./doc/guides/contributing/abi_policy.rst, I think the best option i=
s to use RTE_NEXT_ABI. But I can't find its definition in the code base.

Please advise on how to proceed with making those breaking ABI changes.

Thanks,
Long
