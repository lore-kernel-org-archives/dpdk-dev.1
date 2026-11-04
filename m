Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D05606A32F
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PgIdOJct
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95F54026E;
	Wed,  4 Nov 2026 10:38:59 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by mails.dpdk.org (Postfix) with ESMTPS id D32AB40151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:38:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0bcI3tUMxgRG9lyEWjwnqFgwViYiH6moliapIPccisjyLKPMUBJSQ56jvhVdpxkVSktZ+xHS4qrwogHaPH4UoSX2CZ2K9b1uWFIuXv2l6U9HUY6Og9IrchrUr5EDuRY/rk3urehEAICaq/7vrIa43WB26QExy/cjT2F6HINv8W7Gy9ReUS7cDwuiRcQ+Ns5mmZI39Wy/voEKPSHCzcQQSqdb1tpburUlR5WKqguW11OGoGLFL9rORqiFUudMk5yH6SXBwJT2w4ODQSXX3sOCF9y4+SlPOvhnkduhhE81oIjF/M+jUiuQlLBfxxlO5fVRhqu9muhJqZl04vLGsBnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZbfw1HCJEYTb0S0lrkw/rEUCbAjP5dyO3jXhYDfBpo=;
 b=Fmgm03WmN1VQi0NYmucHHBdzbwtYiGEU1RoruuxQERUlzFc7ujmaHA0nwyCjZugd5WBqLMp63T5N4sM8eclN9Rj2fbAABcXq7VGrm5uUom6ihdJSyDkmukCZ0zgGLgh5zn9MnDmCCvjhy2QM80vr2p41yzfr8LC1SU8bWLSfy1GhkxkcZ3wIOUvX3UAMRMHLH3TImLeQkkzpBz5g9REkGhxTNNUXGIBkykwHtzyQabDwuzCIMBSgnPKOj9IWYvl1JZpvuasxkypZsh7kjfLnWD/wETLf1AJPFkOT42Xw2r1r01+TkM0TI02Cc8gfQBgSN/qOFLW0XgeXxTDBSX015A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZbfw1HCJEYTb0S0lrkw/rEUCbAjP5dyO3jXhYDfBpo=;
 b=PgIdOJctgCA3FTctN/X3188T+UKRs5AAYkK43LZ0ocMC7K449bqIBbRAfyx6oCccZin3hHK7fJuBSAzyvLC1TnkXyMvAyMhUhYP9SYFEl/DvaCEtczBL+ccBhNHJbEtwTJgb8RrwaobCsxfUFzA1qyZcG7XU3knGCr+bASlWonaDQjdIStsHCHOO/nH6TylOxo/tJovlNW+nV0VmutslHN3w5E1Z4P2c4f0AQXWg0ZY1+IxD+tODxdQ/jBnZs7aXC0TOcb/Is0wGTCwdPahj+yV6sRtX5yI2AjWIO5Vh9WTjXK4wz4ensPchRMtITCIHXuV9PlFSmjUKjGm73xBVoA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SA3PR12MB834210.namprd12.prod.outlook.com (2603:10b6:806:517::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:38:54 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 09:38:54 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Shuaisong Yang <yangshuaisong@h-partners.com>, yangxingui
 <yangxingui@huawei.com>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "liuyonglong@huawei.com"
 <liuyonglong@huawei.com>, "kangfenglong@huawei.com" <kangfenglong@huawei.com>
Subject: Re: [PATCH v2] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Thread-Topic: [PATCH v2] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Thread-Index: AQHdKW7Gp3MFokYrzUGXye3+38cAPbbJHCuAgEietYCACr4YgIABskU4
Date: Wed, 4 Nov 2026 09:38:53 +0000
Message-ID: <DM4PR12MB6087DF53A89ED26EAF9F5E75DF682@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260811085231.2260761-1-yangxingui@huawei.com>
 <4a35e332-d89e-af61-03bb-3b72f3f230c7@huawei.com>
 <c0e9bea1-5fd5-4bed-be68-1d639ccb694c@h-partners.com>
 <8d86f620-a641-48d0-839b-1b04710139ae@h-partners.com>
In-Reply-To: <8d86f620-a641-48d0-839b-1b04710139ae@h-partners.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
composetype: reply
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SA3PR12MB834210:EE_
x-ms-office365-filtering-correlation-id: ebdc71d3-5153-4b92-176f-08df3a5770e2
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|261022113327099003|261021121427099003|4143699003|11063799006|261021123027099003|56012099006|261026121527099003|261009221727099003|261009220027099003|261009223327099003|261009223027099003|261028144727099003|261022075727099003|261022105027099003|261009221227099003|261026140227099003|10067099003|16056099006|20046099003|261102123227099003|18002099003|22082099003|6133799003|13003099007|8096899003;
x-microsoft-antispam-message-info: leyfpzqHy9CFJPQfm1oPKXaHNFSnU6B78NMiSk6LDYZkIQHHP4QtvXrjPhh33fAR6r41MJHjL8dfTruxPbJ/81vZXPSZAtMqe7Tq2OJonXvNOkc7JFqtE19VYhcMoJ+KmQOAgWzL6zM+t5uVPSYKr8/iMdoG+s4ex/CDyu0WbtUjTVtmlFZcJPJ74E5uSvEjW/+cYF20nAs68gh4R+7HSvbMT9iOIJHy4zLWx7GUIkLOrmPpoDrAHyzFtmwLMwgi+L7uKkrGXAHBqsPc4QuKor6RitJ5lPLOfxhFko9xCF8cIZy7HqaVIe3L+dOOLcc1DhjFIdstQN80xI85VCXKLwl1WtrH7zptvVx4uIiFv5Fpt5GwT4UBvIYT4QQZ7UBnlYDJOHHVZhHoyOCfM0PxRVoHi6J3AQakh8RcuErm7X7QO9XirCXGXNa96wWDiYh+NakRSSihP9V+dh4JBmA7BXzy6/uYgOm4WxAZU0fZyljzkWCi0V9pmTcpdeIxPSsVsPja2L+pLKa9Xbxj+79feHseQLQJ5vDTgciOB788S07eJk+R9PRMqlmMYg2Q3TKbLfWkVVjQ1gMMgw0MXu2O+jd4m9OmCWC7fF3x/tfLA0FlJnPMDCDws0c/iUgjuscJ+8YmSrX9oEXdKAgKdWGOeXWQ1Vq17W9u513IbW+0w4142YtRJxJnLkhDz2fvAJWYcNoh2ng6rH6shs6EpcyjZfSwZ95FpTBPUvixjkGJyEw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(261022113327099003)(261021121427099003)(4143699003)(11063799006)(261021123027099003)(56012099006)(261026121527099003)(261009221727099003)(261009220027099003)(261009223327099003)(261009223027099003)(261028144727099003)(261022075727099003)(261022105027099003)(261009221227099003)(261026140227099003)(10067099003)(16056099006)(20046099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?N41zJnKzdafMNwDmvUrCnPsuqM9aBSAex7UFg9RSUcHsZnlHaE23evLw?=
 =?Windows-1252?Q?4tq3Z8uzC3jr176AhL+kDcq0g/zFZ3OKHZ2s7QbaC+VyrJPPbmPEKAmA?=
 =?Windows-1252?Q?H/w1MFeW47a8FapRuGiTHA1rxAdGjDdGLpt8EXSpHID7CunfA2E6RetT?=
 =?Windows-1252?Q?4br+8dmVZD2QcLF7VK1dQ5Yfs7QJ1hIxZeA/93GjJRn0i07yJ/A9UKJb?=
 =?Windows-1252?Q?HAO9tlAYyjvAD2RDZPiUoigxcOisvGr4XdUeW8LrmTCfqEua5ropXe5B?=
 =?Windows-1252?Q?4tWl05K0NL1DnS1h3CWZ8dougyupighq/QDAtg/5j0BcyDoPrm1npwJu?=
 =?Windows-1252?Q?hhVRLQIZbGVmRORFvDEs1cPfxoly4t8+TJ0s097N2nZVi08LkwfwsN45?=
 =?Windows-1252?Q?wqWGVAjuEyHIC41lwwwZH18D9qhHDH/miqT/tTiIP4QZfSKNoT6zm1FK?=
 =?Windows-1252?Q?d32aQ+vDAu37F7xNXMa3ViJiw5JlGuve0e7QirVoArqPG9L2vOspm9m0?=
 =?Windows-1252?Q?j5W1IQhzOq8oTvwkxCzYVWEBzlqfmh9FFRoFVcCbDOFoTbEuXSftvPkq?=
 =?Windows-1252?Q?AbSzlXz07w40fhDNgZQtyT143D5B4DKu4u5AsaBiDzrTUG95UFmzGVax?=
 =?Windows-1252?Q?KJ0Yph9GhX0dquh+/kuorztd15V7RkOAZkpEy1JTWWFwfoBecEqXOO7H?=
 =?Windows-1252?Q?bMm+0FHvQ/lN6Ir5F8OGXpISuAzRnaQVGubO4yb5ZE6s8RmNmdloYW5Q?=
 =?Windows-1252?Q?vvLuL5QuTcdgW4ZPQULArt9AEJXy/z5ZEAeWs0zsc3RCNUlFqcRP9a06?=
 =?Windows-1252?Q?7WcqnAakkjFLUoBjHLSGU6KujgiO50hnH/r9ewqgpKsFTGnGk3AC1oh2?=
 =?Windows-1252?Q?1QE8l6zV6hbG8yEnc4tykPptpGCWSDC9qNaEqGWW6dl0EILoH9yG/oNW?=
 =?Windows-1252?Q?IQqOmSYmr88S1YQdePYzJCeQYK1x+V+1PFCBeskPYoXxttRT+jeFzUsw?=
 =?Windows-1252?Q?xXrohl1xiVzvpyJnp2KF6ALezRTOy59rgJ5MoEdk6rh1ra+h9EdzsPNt?=
 =?Windows-1252?Q?HwtBRCFKzSoPbb/a85dcxRAX6iBzKJLUTX/BWFZcR3qzkAvPNRXKxyV6?=
 =?Windows-1252?Q?mJ6wTWFAhFAX02XXSmegJ+4ZxlLX2MulXy/HrJBfHak37w5t7iQ8bnM8?=
 =?Windows-1252?Q?ylVEcUjgWr8Q64031RGR7iKq9FC4U76OOCupoy8Ntg1bYxzzhpuYORXG?=
 =?Windows-1252?Q?CSdIVyOLER/g+crQlwBkcRfq2BN0y0sdZNqq44jRs1HSYBNKB8bGQvls?=
 =?Windows-1252?Q?AnW5ibJS69Sdxixyq3xN3fvQ6LRUupDGAGfCZz4B9KJXpAJE1rrKLliR?=
 =?Windows-1252?Q?JdH5srBdGLdnf/zaIeMpXSpE6QtK86M14XRXsVgB11dWC2r7WiI747W6?=
 =?Windows-1252?Q?hRPWwpF1j80nw0gKDDtIyBU+BnshS3H/rtNYcQdvRMUlFkxKcAz9NpGb?=
 =?Windows-1252?Q?x9SrJW2PT9Amz7hHHXzmKvP0w5JKMMa5X75RJH/L0XBn/iGuhoGRNqtx?=
 =?Windows-1252?Q?QKnaVGmFAsfoBFKIk0aJd5EnuKLYjvC8TzlyaveQFEA7Tq8QX3jFsHGD?=
 =?Windows-1252?Q?C9J24QPvQjMCDC+vRmoKIa+Mw+SGP6HcxAH6Tt2wM2rusYqVMCgDd2Eo?=
 =?Windows-1252?Q?r0s79WgAvhZseSPihRzX+2oyZkQBtkoIWFPF4MmhIcswC3xK1Fz3GDaP?=
 =?Windows-1252?Q?DW19q7Nf5e534cqFY0fBCGDRaU6YVj69zkyDNpng/pJxk09ajIAdjnc7?=
 =?Windows-1252?Q?NtiJ4q2Fcmm8GwK5kxeMpRCv96WwfkAALC4Prp0qW5C3GTc3?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB6087DF53A89ED26EAF9F5E75DF682DM4PR12MB6087namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc71d3-5153-4b92-176f-08df3a5770e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:38:54.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Du/48oPHkNZoE6bRoBNULY2rLGo2q7Ztl3K9YcBSw5Fnpj3mCJaXWKDxOU5SVBhkNUtdGliSOFdfNmd+5DVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB834210
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DM4PR12MB6087DF53A89ED26EAF9F5E75DF682DM4PR12MB6087namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi, Shuaisong

Thank youm for the v2, sorry for the review delay.
The patch mostly  looks good to me.

My concern is this:

>>if (is_extmem)
>> +        goto out;

It changes the existing behavior for the external memory.
Before there was combining all the ranges within the single hugepage for th=
e external memory also.
With the patch applied it is not anymore.

For the regular memory - we can accept your proposal.
For the external memory - we should keep existing behavior, not skip combin=
ing within a single huge page.
I would also elaborate this approach and combine the ranges within the next=
 huge pages (if any), but
not combine the huge page itself (for the external memory).

With best regards,
Slava


________________________________
From: Shuaisong Yang <yangshuaisong@h-partners.com>
Sent: Tuesday, November 3, 2026 9:35 AM
To: yangxingui <yangxingui@huawei.com>; Slava Ovsiienko <viacheslavo@nvidia=
.com>; david.marchand@redhat.com <david.marchand@redhat.com>; Dariusz Sosno=
wski <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam <orika@=
nvidia.com>; Suanming Mou <suanmingm@nvidia.com>
Cc: dev@dpdk.org <dev@dpdk.org>; stephen@networkplumber.org <stephen@networ=
kplumber.org>; NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>=
; dmitry.kozliuk@gmail.com <dmitry.kozliuk@gmail.com>; david.marchand@redha=
t.com <david.marchand@redhat.com>; fengchengwen@huawei.com <fengchengwen@hu=
awei.com>; liuyonglong@huawei.com <liuyonglong@huawei.com>; kangfenglong@hu=
awei.com <kangfenglong@huawei.com>; yangshuaisong <yangshuaisong@h-partners=
.com>
Subject: Re: [PATCH v2] common/mlx5: fix high SMMU TLB miss with mempool al=
ignment

> Hi Slava,
>
> Gentle ping on this patch, following up on the earlier pings from
> Sep 11 and Oct 27.
>
> In the v1 discussion you mentioned the patch mostly looked good to
> you and gave three suggestions =97 all of them are incorporated in v2
> (see the changelog):
> https://patches.dpdk.org/project/dpdk/patch/20260811085231.2260761-1-yang=
xingui@huawei.com/
>
> Our replies to your v1 comments, including the root cause analysis
> (reg_end =3D=3D hugepage_end causing the alignment to be skipped), are
> here:
> https://patches.dpdk.org/project/dpdk/patch/20260612071434.2722918-1-yang=
xingui@huawei.com/
>
> The patch fixes a ~30% performance regression with CX7 under SMMU
> (intra-NUMA pinning on Kunpeng SoC). It has been pending for about
> three months =97 we'd really appreciate your final review. Happy to
> dig further into why the hugepage placement differs between pinning
> configurations, or provide more test data, if that helps.
>
> Thanks!
> Shuaisong & Xingui

On 2026/10/27 19:32, Shuaisong Yang wrote:
> Hi mlx5 team, just a gentle ping on this patch when you have a moment. Th=
anks!
>
> On 2026/9/11 14:33, yangxingui wrote:
>> Kindly ping for review...
>>
>> On 2026/8/11 16:52, Xingui Yang wrote:
>>> From: Shuaisong Yang <yangshuaisong@h-partners.com>
>>>
>>> On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core pinning
>>> under SMMU nonstrict/strict mode shows about 30% performance degradatio=
n
>>> compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,
>>> intra-NUMA performs as expected (slightly better than cross-NUMA).
>>>
>>> CX7 in NUMA1
>>> NUMA node0 CPU(s):    0-39
>>> NUMA node1 CPU(s):    40-79
>>>
>>> intra-NUMA:
>>> dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \
>>>     --config=3D'(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\
>>>               (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\
>>>               (0,10,50),(0,11,51),(0,12,52),(0,13,53),\
>>>               (0,14,54),(0,15,55)' \
>>>     --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64
>>>
>>> cross-NUMA:
>>> dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \
>>>     --config=3D'(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\
>>>               (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\
>>>               (0,10,21),(0,11,22),(0,12,23),(0,13,24),\
>>>               (0,14,25),(0,15,26)' \
>>>     --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64
>>>
>>> The root cause is that under SMMU enabled mode, the mempool allocated
>>> for intra-NUMA pinning is aligned to system page size instead of
>>> hugepage size, while cross-NUMA pinning correctly uses hugepage size
>>> alignment. This causes high TLB miss rates under SMMU.
>>>
>>> Align all memory ranges to hugepage boundaries during mempool
>>> registration to ensure hugepage_sz alignment, thereby reducing TLB
>>> misses and fixing the intra-NUMA performance degradation.
>>>
>>> Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities"=
)
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>> v2:
>>> - Address review comments from Slava:
>>>    - Call rte_mem_virt2memseg_list() in a single point inside the loop.
>>>    - Skip the alignment block when hugepage_sz equals rte_mem_page_size=
(),
>>>      since mlx5_mempool_get_chunks() has already done the alignment.
>>>    - Skip the alignment for external memory with early goto, since rang=
es
>>>      are already aligned to the correct page size.
>>> ---
>>>   .mailmap                             |  1 +
>>>   drivers/common/mlx5/mlx5_common_mr.c | 72 +++++++++++++++++++--------=
-
>>>   2 files changed, 51 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index fcb3d1bb3f..c8ba648d3c 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -1999,3 +1999,4 @@ Zongyu Wu <wuzongyu1@huawei.com>
>>>   Zorik Machulsky <zorik@amazon.com>
>>>   Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
>>>   Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
>>> +Shuaisong Yang <yangshuaisong@h-partners.com>
>>> diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5=
/mlx5_common_mr.c
>>> index aa2d5e88a4..f9e1ec7468 100644
>>> --- a/drivers/common/mlx5/mlx5_common_mr.c
>>> +++ b/drivers/common/mlx5/mlx5_common_mr.c
>>> @@ -1524,7 +1524,11 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, =
bool is_extmem,
>>>    * @param[in] is_extmem
>>>    *   Whether the pool is contains only external pinned buffers.
>>>    * @param[out] out
>>> - *   Receives memory ranges to register, aligned to the system page si=
ze.
>>> + *   Receives memory ranges to register. For non-external memory, rang=
es
>>> + *   are aligned to the hugepage size if all ranges are on hugepages
>>> + *   of the same size, otherwise aligned to the system page size.
>>> + *   For external memory, ranges are kept as returned by
>>> + *   mlx5_get_mempool_ranges() (already aligned to the page size).
>>>    *   The caller must release them with free().
>>>    * @param[out] out_n
>>>    *   Receives the number of @p out items.
>>> @@ -1541,7 +1545,8 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, =
bool is_extmem,
>>>   {
>>>       struct mlx5_range *ranges =3D NULL;
>>>       unsigned int i, ranges_n =3D 0;
>>> -    struct rte_memseg_list *msl;
>>> +    bool same_hugepage_sz =3D true;
>>> +    uint64_t hugepage_sz =3D 0;
>>>         if (mlx5_get_mempool_ranges(mp, is_extmem, &ranges, &ranges_n) =
< 0) {
>>>           DRV_LOG(ERR, "Cannot get address ranges for mempool %s",
>>> @@ -1550,34 +1555,57 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp=
, bool is_extmem,
>>>       }
>>>       /* Check if the hugepage of the pool can be shared. */
>>>       *share_hugepage =3D false;
>>> -    msl =3D rte_mem_virt2memseg_list((void *)ranges[0].start);
>>> -    if (msl !=3D NULL) {
>>> -        uint64_t hugepage_sz =3D 0;
>>> +    if (is_extmem)
>>> +        goto out;
>>> +    /* Check that all ranges are on pages of the same size. */
>>> +    for (i =3D 0; i < ranges_n; i++) {
>>> +        struct rte_memseg_list *range_msl =3D
>>> +            rte_mem_virt2memseg_list((void *)ranges[i].start);
>>> +
>>> +        if (range_msl =3D=3D NULL) {
>>> +            same_hugepage_sz =3D false;
>>> +            break;
>>> +        }
>>> +        if (hugepage_sz =3D=3D 0) {
>>> +            hugepage_sz =3D range_msl->page_sz;
>>> +        } else if (range_msl->page_sz !=3D hugepage_sz) {
>>> +            same_hugepage_sz =3D false;
>>> +            break;
>>> +        }
>>> +    }
>>> +    /*
>>> +     * Align ranges to the hugepage boundaries and merge adjacent ones=
.
>>> +     * If the entire pool fits in a single hugepage, the MR for this
>>> +     * hugepage can be shared across mempools.
>>> +     */
>>> +    if (same_hugepage_sz && hugepage_sz > rte_mem_page_size()) {
>>> +        unsigned int orig_ranges_n =3D ranges_n;
>>>   -        /* Check that all ranges are on pages of the same size. */
>>>           for (i =3D 0; i < ranges_n; i++) {
>>> -            if (hugepage_sz !=3D 0 && hugepage_sz !=3D msl->page_sz)
>>> -                break;
>>> -            hugepage_sz =3D msl->page_sz;
>>> +            ranges[i].start =3D RTE_ALIGN_FLOOR(ranges[i].start,
>>> +                              hugepage_sz);
>>> +            ranges[i].end =3D RTE_ALIGN_CEIL(ranges[i].end,
>>> +                            hugepage_sz);
>>>           }
>>> -        if (i =3D=3D ranges_n) {
>>> -            /*
>>> -             * If the entire pool is within one hugepage,
>>> -             * combine all ranges into one of the hugepage size.
>>> -             */
>>> -            uintptr_t reg_start =3D ranges[0].start;
>>> -            uintptr_t reg_end =3D ranges[ranges_n - 1].end;
>>> -            uintptr_t hugepage_start =3D
>>> -                RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
>>> -            uintptr_t hugepage_end =3D hugepage_start + hugepage_sz;
>>> -            if (reg_end < hugepage_end) {
>>> -                ranges[0].start =3D hugepage_start;
>>> +        ranges_n =3D 1;
>>> +        for (i =3D 1; i < orig_ranges_n; i++) {
>>> +            if (ranges[ranges_n - 1].end >=3D ranges[i].start)
>>> +                ranges[ranges_n - 1].end =3D
>>> +                    RTE_MAX(ranges[ranges_n - 1].end,
>>> +                        ranges[i].end);
>>> +            else
>>> +                ranges[ranges_n++] =3D ranges[i];
>>> +        }
>>> +        if (ranges_n =3D=3D 1) {
>>> +            uintptr_t hugepage_end =3D ranges[0].start + hugepage_sz;
>>> +
>>> +            if (ranges[0].end <=3D hugepage_end) {
>>>                   ranges[0].end =3D hugepage_end;
>>> -                ranges_n =3D 1;
>>>                   *share_hugepage =3D true;
>>>               }
>>>           }
>>>       }
>>> +out:
>>>       *out =3D ranges;
>>>       *out_n =3D ranges_n;
>>>       return 0;
>>>
>


--_000_DM4PR12MB6087DF53A89ED26EAF9F5E75DF682DM4PR12MB6087namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi, Shuaisong</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank youm for the v2, sorry for the review delay.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The patch mostly&nbsp; looks good to me.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
My concern is this:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;if (is_extmem)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
It changes the existing behavior for the external memory.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Before there was combining all the ranges within the single hugepage for th=
e external memory also.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
With the patch applied it is not anymore.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For the regular memory - we can accept your proposal.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For the external memory - we should keep existing behavior, not skip combin=
ing within a single huge page.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I would also elaborate this approach and combine the ranges within the next=
 huge pages (if any), but</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
not combine the huge page itself (for the external memory).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
With best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Slava</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2026 9:35 AM<br>
<b>To:</b> yangxingui &lt;yangxingui@huawei.com&gt;; Slava Ovsiienko &lt;vi=
acheslavo@nvidia.com&gt;; david.marchand@redhat.com &lt;david.marchand@redh=
at.com&gt;; Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Bing Zhao &lt;=
bingz@nvidia.com&gt;; Ori Kam &lt;orika@nvidia.com&gt;; Suanming Mou
 &lt;suanmingm@nvidia.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; stephen@networkplumber.org &l=
t;stephen@networkplumber.org&gt;; NBU-Contact-Thomas Monjalon (EXTERNAL) &l=
t;thomas@monjalon.net&gt;; dmitry.kozliuk@gmail.com &lt;dmitry.kozliuk@gmai=
l.com&gt;; david.marchand@redhat.com &lt;david.marchand@redhat.com&gt;;
 fengchengwen@huawei.com &lt;fengchengwen@huawei.com&gt;; liuyonglong@huawe=
i.com &lt;liuyonglong@huawei.com&gt;; kangfenglong@huawei.com &lt;kangfengl=
ong@huawei.com&gt;; yangshuaisong &lt;yangshuaisong@h-partners.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] common/mlx5: fix high SMMU TLB miss with mem=
pool alignment
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">&gt; Hi Slava,<br>
&gt;<br>
&gt; Gentle ping on this patch, following up on the earlier pings from<br>
&gt; Sep 11 and Oct 27.<br>
&gt;<br>
&gt; In the v1 discussion you mentioned the patch mostly looked good to<br>
&gt; you and gave three suggestions =97 all of them are incorporated in v2<=
br>
&gt; (see the changelog):<br>
&gt; <a href=3D"https://patches.dpdk.org/project/dpdk/patch/20260811085231.=
2260761-1-yangxingui@huawei.com/" id=3D"OWAe7ac1763-f872-6bc4-4c32-04f9f3cb=
249a" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://patches.dpdk.org/project/dpdk/patch/20260811085231.2260761-1-yangxi=
ngui@huawei.com/</a><br>
&gt;<br>
&gt; Our replies to your v1 comments, including the root cause analysis<br>
&gt; (reg_end =3D=3D hugepage_end causing the alignment to be skipped), are=
<br>
&gt; here:<br>
&gt; <a href=3D"https://patches.dpdk.org/project/dpdk/patch/20260612071434.=
2722918-1-yangxingui@huawei.com/" id=3D"OWAca175ee0-03cc-ed7f-d78f-1b29e60e=
ecee" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://patches.dpdk.org/project/dpdk/patch/20260612071434.2722918-1-yangxi=
ngui@huawei.com/</a><br>
&gt;<br>
&gt; The patch fixes a ~30% performance regression with CX7 under SMMU<br>
&gt; (intra-NUMA pinning on Kunpeng SoC). It has been pending for about<br>
&gt; three months =97 we'd really appreciate your final review. Happy to<br=
>
&gt; dig further into why the hugepage placement differs between pinning<br=
>
&gt; configurations, or provide more test data, if that helps.<br>
&gt;<br>
&gt; Thanks!<br>
&gt; Shuaisong &amp; Xingui<br>
<br>
On 2026/10/27 19:32, Shuaisong Yang wrote:<br>
&gt; Hi mlx5 team, just a gentle ping on this patch when you have a moment.=
 Thanks!<br>
&gt;<br>
&gt; On 2026/9/11 14:33, yangxingui wrote:<br>
&gt;&gt; Kindly ping for review...<br>
&gt;&gt;<br>
&gt;&gt; On 2026/8/11 16:52, Xingui Yang wrote:<br>
&gt;&gt;&gt; From: Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core p=
inning<br>
&gt;&gt;&gt; under SMMU nonstrict/strict mode shows about 30% performance d=
egradation<br>
&gt;&gt;&gt; compared to cross-NUMA pinning. With SMMU disabled or passthro=
ugh mode,<br>
&gt;&gt;&gt; intra-NUMA performs as expected (slightly better than cross-NU=
MA).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; CX7 in NUMA1<br>
&gt;&gt;&gt; NUMA node0 CPU(s):&nbsp;&nbsp;&nbsp; 0-39<br>
&gt;&gt;&gt; NUMA node1 CPU(s):&nbsp;&nbsp;&nbsp; 40-79<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; intra-NUMA:<br>
&gt;&gt;&gt; dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1=
 -P \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; --config=3D'(0,0,40),(0,1,41),(0,2,42),(0,3=
,43),(0,4,44),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,10,50),(0,11,51),(0,12,52),(0,13,53),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,14,54),(0,15,55)' \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; --rx-queue-size=3D4096 --tx-queue-size=3D40=
96 --rx-burst=3D64<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; cross-NUMA:<br>
&gt;&gt;&gt; dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1=
 -P \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; --config=3D'(0,0,11),(0,1,12),(0,2,13),(0,3=
,14),(0,4,15),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,10,21),(0,11,22),(0,12,23),(0,13,24),\<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0,14,25),(0,15,26)' \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; --rx-queue-size=3D4096 --tx-queue-size=3D40=
96 --rx-burst=3D64<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The root cause is that under SMMU enabled mode, the mempool al=
located<br>
&gt;&gt;&gt; for intra-NUMA pinning is aligned to system page size instead =
of<br>
&gt;&gt;&gt; hugepage size, while cross-NUMA pinning correctly uses hugepag=
e size<br>
&gt;&gt;&gt; alignment. This causes high TLB miss rates under SMMU.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Align all memory ranges to hugepage boundaries during mempool<=
br>
&gt;&gt;&gt; registration to ensure hugepage_sz alignment, thereby reducing=
 TLB<br>
&gt;&gt;&gt; misses and fixing the intra-NUMA performance degradation.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fixes: 690b2a88c2f7 (&quot;common/mlx5: add mempool registrati=
on facilities&quot;)<br>
&gt;&gt;&gt; Cc: stable@dpdk.org<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Shuaisong Yang &lt;yangshuaisong@h-partners.com=
&gt;<br>
&gt;&gt;&gt; Signed-off-by: Xingui Yang &lt;yangxingui@huawei.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; v2:<br>
&gt;&gt;&gt; - Address review comments from Slava:<br>
&gt;&gt;&gt; &nbsp;&nbsp; - Call rte_mem_virt2memseg_list() in a single poi=
nt inside the loop.<br>
&gt;&gt;&gt; &nbsp;&nbsp; - Skip the alignment block when hugepage_sz equal=
s rte_mem_page_size(),<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; since mlx5_mempool_get_chunks() has a=
lready done the alignment.<br>
&gt;&gt;&gt; &nbsp;&nbsp; - Skip the alignment for external memory with ear=
ly goto, since ranges<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; are already aligned to the correct pa=
ge size.<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; &nbsp; .mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&gt;&gt; &nbsp; drivers/common/mlx5/mlx5_common_mr.c | 72 +++++++++++++=
++++++---------<br>
&gt;&gt;&gt; &nbsp; 2 files changed, 51 insertions(+), 22 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/.mailmap b/.mailmap<br>
&gt;&gt;&gt; index fcb3d1bb3f..c8ba648d3c 100644<br>
&gt;&gt;&gt; --- a/.mailmap<br>
&gt;&gt;&gt; +++ b/.mailmap<br>
&gt;&gt;&gt; @@ -1999,3 +1999,4 @@ Zongyu Wu &lt;wuzongyu1@huawei.com&gt;<b=
r>
&gt;&gt;&gt; &nbsp; Zorik Machulsky &lt;zorik@amazon.com&gt;<br>
&gt;&gt;&gt; &nbsp; Zyta Szpak &lt;zyta@marvell.com&gt; &lt;zr@semihalf.com=
&gt;<br>
&gt;&gt;&gt; &nbsp; Zyta Szpak &lt;zyta@marvell.com&gt; &lt;zyta.szpak@semi=
half.com&gt;<br>
&gt;&gt;&gt; +Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/co=
mmon/mlx5/mlx5_common_mr.c<br>
&gt;&gt;&gt; index aa2d5e88a4..f9e1ec7468 100644<br>
&gt;&gt;&gt; --- a/drivers/common/mlx5/mlx5_common_mr.c<br>
&gt;&gt;&gt; +++ b/drivers/common/mlx5/mlx5_common_mr.c<br>
&gt;&gt;&gt; @@ -1524,7 +1524,11 @@ mlx5_get_mempool_ranges(struct rte_memp=
ool *mp, bool is_extmem,<br>
&gt;&gt;&gt; &nbsp;&nbsp; * @param[in] is_extmem<br>
&gt;&gt;&gt; &nbsp;&nbsp; *&nbsp;&nbsp; Whether the pool is contains only e=
xternal pinned buffers.<br>
&gt;&gt;&gt; &nbsp;&nbsp; * @param[out] out<br>
&gt;&gt;&gt; - *&nbsp;&nbsp; Receives memory ranges to register, aligned to=
 the system page size.<br>
&gt;&gt;&gt; + *&nbsp;&nbsp; Receives memory ranges to register. For non-ex=
ternal memory, ranges<br>
&gt;&gt;&gt; + *&nbsp;&nbsp; are aligned to the hugepage size if all ranges=
 are on hugepages<br>
&gt;&gt;&gt; + *&nbsp;&nbsp; of the same size, otherwise aligned to the sys=
tem page size.<br>
&gt;&gt;&gt; + *&nbsp;&nbsp; For external memory, ranges are kept as return=
ed by<br>
&gt;&gt;&gt; + *&nbsp;&nbsp; mlx5_get_mempool_ranges() (already aligned to =
the page size).<br>
&gt;&gt;&gt; &nbsp;&nbsp; *&nbsp;&nbsp; The caller must release them with f=
ree().<br>
&gt;&gt;&gt; &nbsp;&nbsp; * @param[out] out_n<br>
&gt;&gt;&gt; &nbsp;&nbsp; *&nbsp;&nbsp; Receives the number of @p out items=
.<br>
&gt;&gt;&gt; @@ -1541,7 +1545,8 @@ mlx5_mempool_reg_analyze(struct rte_memp=
ool *mp, bool is_extmem,<br>
&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mlx5_range *ranges =3D N=
ULL;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, ranges_n =3D 0;=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct rte_memseg_list *msl;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool same_hugepage_sz =3D true;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t hugepage_sz =3D 0;<br>
&gt;&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mlx5_get_mempool_ran=
ges(mp, is_extmem, &amp;ranges, &amp;ranges_n) &lt; 0) {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRV_LOG=
(ERR, &quot;Cannot get address ranges for mempool %s&quot;,<br>
&gt;&gt;&gt; @@ -1550,34 +1555,57 @@ mlx5_mempool_reg_analyze(struct rte_me=
mpool *mp, bool is_extmem,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if the hugepage of the=
 pool can be shared. */<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *share_hugepage =3D false;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; msl =3D rte_mem_virt2memseg_list((void *)r=
anges[0].start);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; if (msl !=3D NULL) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t hugepage_=
sz =3D 0;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (is_extmem)<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; /* Check that all ranges are on pages of t=
he same size. */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ranges_n; i++) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_memseg_=
list *range_msl =3D<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; rte_mem_virt2memseg_list((void *)ranges[i].start);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (range_msl =3D=
=3D NULL) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; same_hugepage_sz =3D false;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hugepage_sz =
=3D=3D 0) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; hugepage_sz =3D range_msl-&gt;page_sz;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (range_m=
sl-&gt;page_sz !=3D hugepage_sz) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; same_hugepage_sz =3D false;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * Align ranges to the hugepage bound=
aries and merge adjacent ones.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * If the entire pool fits in a singl=
e hugepage, the MR for this<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * hugepage can be shared across memp=
ools.<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (same_hugepage_sz &amp;&amp; hugepage_s=
z &gt; rte_mem_page_size()) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int orig_=
ranges_n =3D ranges_n;<br>
&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check th=
at all ranges are on pages of the same size. */<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; ranges_n; i++) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (hugepage_sz !=3D 0 &amp;&amp; hugepage_sz !=3D msl-&gt;page_sz)<b=
r>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; hugepage_sz =3D msl-&gt;page_sz;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ranges[i].start =3D RTE_ALIGN_FLOOR(ranges[i].start,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ranges[i].end =3D RTE_ALIGN_CEIL(ranges[i].end,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D range=
s_n) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * If the entire pool is within one hugepage,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * combine all ranges into one of the hugepage size.<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uintptr_t reg_start =3D ranges[0].start;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uintptr_t reg_end =3D ranges[ranges_n - 1].end;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uintptr_t hugepage_start =3D<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ALIGN_FLOOR(reg_start, hugepage_sz);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uintptr_t hugepage_end =3D hugepage_start + hugepage_sz;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (reg_end &lt; hugepage_end) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].start =3D hugepage_start;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges_n =3D 1;<br=
>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &l=
t; orig_ranges_n; i++) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ranges[ranges_n - 1].end &gt;=3D ranges[i].start)<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[ranges_n - 1].end =3D<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_MAX(ranges[ranges=
_n - 1].end,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ranges[i].end);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; else<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[ranges_n++] =3D ranges[i];<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ranges_n =3D=
=3D 1) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uintptr_t hugepage_end =3D ranges[0].start + hugepage_sz;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ranges[0].end &lt;=3D hugepage_end) {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].end =3D hugepage_end;<br=
>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges_n =3D 1;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *share_hugepage =3D true;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +out:<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *out =3D ranges;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *out_n =3D ranges_n;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_DM4PR12MB6087DF53A89ED26EAF9F5E75DF682DM4PR12MB6087namp_--
