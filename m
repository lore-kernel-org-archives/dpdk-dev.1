Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EE4C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40BB340E31;
	Mon, 21 Sep 2026 10:37:41 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023116.outbound.protection.outlook.com [52.101.127.116])
 by mails.dpdk.org (Postfix) with ESMTP id F041F4025A
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:37:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QetTTEZ3CL30V4VtbKUEUPvNBZ5RZCtehPoESPee+++CQrVDDZeaGj9jJ+nQYzPPsHKpADed1WMGPrAQLLp3MJQH6FK9qYVTx3J/4lEJj33gpUvg3lcrKmh3zT6mAxYHo5Ihbp3M9N6iCC2FG6IrWgw/RvodsHcnQ4idwlqwuaccaLxGIqfebckQCY+dMNumBai7z4DLrYUQDen5G3HYSCUBDe2Beuoqgo/Uo7iUz+f1fuoE5QVogq4f8EWsza93K3vmGo3XgkAUmLEuQ1FyCktVr5QU4Cqv+Q/hKytjeoCW32yd99cVT9Ec1sLwK5K6ln0Iyx03qWZNtBthmyyLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=pPsVRrHGWz8yWn866vc4h81XPZTE8fqemYTuD3l54xs=;
 b=dqvKWKvFd1nCqMw9htkx+FCDvFhnr1QINhXEvUmvyUaOlp3PHKSSGNbCKm0IxZkzh8Mk81YN1Wex0qDpR/OdcRTotUuSZnv+XAObrckkzWQKovOGNT1QtQqa3v3QWfkTiKWjOd1ihMTa6xUmjOI+HFzdFDzQt8SVrgeFNBYaVDIRvNrsOUYYDemaa1V9O5BvyfR9vmQY3jPygIM+1zRXKA1Jx6D3Z8SDzoWpyB1I16EGvoAWyCNv5u+5I30ea6MgjP8KyuoS/ooH/0CJn9JQ730mRw5qf8gzXUMNLYyLrG5nD3K4En+JbZzExxk0KPJfCU/xY4x5X2qRiMbJBvFYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPsVRrHGWz8yWn866vc4h81XPZTE8fqemYTuD3l54xs=;
 b=h6RONSrq6/75OhUbonET3YxmHepMxUPm7fq5nfUe1xJR+mREfXfPU+gNlMiZw7ZepEztE0apo8qdQ15YapBwNb82WLiJv3I82H1e+J3IhkWDj8Jh1JXkdTTkGA6B+1d/vm6zLHbkv8BasE917WTLxsMTMgSCRJTfChqa31gDuSg=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by SI3P153MB2029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:29d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.2; Mon, 21 Sep 2026 08:37:29 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%6]) with mapi id 15.21.0472.000; Mon, 21 Sep 2026
 08:37:28 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 02/33] bus/vmbus: remove packed attribute
 from ring buffer
Thread-Topic: [EXTERNAL] [PATCH v2 02/33] bus/vmbus: remove packed attribute
 from ring buffer
Thread-Index: AQHdSSvRl63Yd+/kbkObcDoVDBBEqrbYtjmg
Date: Mon, 21 Sep 2026 08:37:27 +0000
Message-ID: <SE3P153MB1848571B18715D8A161224E7BB842@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
 <20260920181347.747210-3-stephen@networkplumber.org>
In-Reply-To: <20260920181347.747210-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a9be50a0-ffc9-4793-9c21-ac2213c8996d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-21T08:36:23Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|SI3P153MB2029:EE_
x-ms-office365-filtering-correlation-id: 015055fd-2248-43cd-8a22-08df17bb9193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|366016|38070700021|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003|10067099003|7146999003;
x-microsoft-antispam-message-info: LXx5zkWocP8niyriJZUPJCDGTjCdVxNQfcVCKK5NZibnhiQfdQ9QCVyiyzqwSj/dAiGGjLt8VGq7aFgyUjhT+3fU3OfhRHY8Po78C18jtEgwFrOXdKnBPGVg2oV8lXbFVPgi6GjgV5iAMRZbAX60rB/gLOZiGJ7bu/L61eoqtgpbczG1Ks+ZqQhP2Tl+MWxAnjGb3zeyTbqJnEi6v7s+JWZgEbxZC3ix8IJ8ht/4TAK957L1Yc1IXwoJp5zDNxLeUwoeIMmQ3FPZP4tn41rjZnOBiLZDs6u2ARx9/kP9UgBOAWFlwqN5KWNUchRPJNqs0iSVQxA++J6G74TK3IyXkZtJKQU51bwbP922Nz0uHvqxsTgP2VrfUxbHQ91M+SNjEiFDlaO+mtWsWMZjcVMlw87s435Bs1ehmW0y5WbvfG3ohHgJl7fm2Lt5zN86+NJWxG0h/c2YHQxX2FPxeIojRyyzb0LpxrD/k8pi7oGQ5H8bb9Q50bxYEKQpUVT/xoIuwSY60lnJlpJgwHUkZBYHmc0BxSraAzZw0joJDPXN9KTfE/LVMJtZhRY9VeGW+NcVL3xSAuN0LFxhm8Upb8LGycr3UfgOCQVLfe/zjPtN2Tcp/yCX2t7JuCuWl+wR4lbrwl9Q1WnDD8ETBM7W24aisTkJ4LgT/2BJ6On34LoS0DLEK4KfjXAeWJ0N4l2uLCMEakrmFQ9OIKH3kcLuFN/Ppst/uxZEFuW6HZ7xkg5NyyE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qe+SpkialumXbqkm/88qi02lLQGoVdjM/Iv7dAaUS3mTLdzK4KWe7I78mYG0?=
 =?us-ascii?Q?onwlxSwdlU3FOtLCO9lPEij2mu9Al262dbTENXAnydosms5ZHn4ci4YO8Zko?=
 =?us-ascii?Q?lcZ0aH6+xGVgqIYT3krc9EnSdpmB1DxbIOXi8gyWN7smBDAcJozvJ5Nes7oh?=
 =?us-ascii?Q?0vKdtELUQbT3DyEy6+ruHSxJWfgm2ouZmgAVbiLiPKHVoRwLH0dcMyO9cM9r?=
 =?us-ascii?Q?cTurB5nxtkPN9SAQ6z+aTXBufLi+sJmJOXxvXy18Ao1MEvot77PqKJrkORhA?=
 =?us-ascii?Q?TitVf4bJZlDU/VkJKmo2XocCkre55dQY7YctHE7gMvNTKSaNWK5L5TbXA63G?=
 =?us-ascii?Q?rSICfhZ+QmrLbsxmo3Ys30lf6hBS95Tsvfpc9fvkJv0UJuBiFnhs5j5IJA35?=
 =?us-ascii?Q?S5YABehMM2nAPZCa7g0GxPbvqDykKR5wkT4MQzbR6NGbPh++RNMOFam+9/CI?=
 =?us-ascii?Q?1soGPfymZgP26gKZ0OytnOJ8cPJbSzpiJa3szBfXmEEhKuQS/hwl1FQpRFMx?=
 =?us-ascii?Q?OjoNgDxCa8mZn90gGoT7cXpxD1rsytTTf1dCfrEKRjbIEDMHBPiHzTwJx368?=
 =?us-ascii?Q?mjEJ/ewcqkXm231CirOIrw43eji/Zh2DBKp1n/Hg0lLcsd4GtoaW5NBIPkI5?=
 =?us-ascii?Q?ebK+Afo7VscaI1cfsjOXeKj19fUixyJZwbFXbHbeC+fjs0J3Rn9aNAndWwKB?=
 =?us-ascii?Q?hk29vRsDswly2IFdCzzewpmuJaw73T/pmeSwg7OilT8WUrHjkIpxPnVngAc5?=
 =?us-ascii?Q?4HUq2rXryzrMjxoYMT48Dey0YvGQ7jnh5aVktcCSzJgQAdpbU9l/jBRD+dBE?=
 =?us-ascii?Q?s6Pfcanva0HkjGqSrur/upddAEjNfGiCDCHY9YRiuEuUqBTZjn1ydluTZQq5?=
 =?us-ascii?Q?CmPkJxxzDk43kuA576jAUZrhQMTFcTpAG5OQoq/2A3wSNW8MdQYAtbQpfoJt?=
 =?us-ascii?Q?RG62SYgt28SlK9yjLE+dnAxnzNf2bNSg1hMadGCflUSi+tctPVYb3jQw77bc?=
 =?us-ascii?Q?mcJdqlP/3q23LnPSbAb7q4W3+/gu/iVyNGjGNgkUO+qHeyIvrbR/fG+tWApf?=
 =?us-ascii?Q?boBREmGOPFkKsP7M/0LeOq6Gsjryb9tyZ/q/nFe0TmVlabF34zf2x2wal9O1?=
 =?us-ascii?Q?B7NC2wlzwcECqtgPyG9sGFl7j2q0JSM07IMb5L6seBojxJvsHYW5YIuA2qn+?=
 =?us-ascii?Q?eCznj5Ei4UpLKqFTiDuxP1pWRb5ExWAJkZ5iBLogwvQny+nKjvKB4+D397bf?=
 =?us-ascii?Q?XGwj4dNfo3X3TprPl6mDrSUHB8lT4gitd2O5lt5vkBNZZBNTRkGpPCtVk49o?=
 =?us-ascii?Q?h0C85Z1HXxQXnGS6K7a9GfwAFI0PUIjiICsiuuSKtRBT41P4pOCL5mNfy0Oj?=
 =?us-ascii?Q?suzvlVQGsV3jL7D8vTmKUdzAkVjowjPua1/LonuTIT9eGtsE+UnmxfzMrrV9?=
 =?us-ascii?Q?LMN6KisLdH9CVj8oRCAM13JGERd3yM0rlCz63WpA3oSbfqZAoVWv0pM2/u1s?=
 =?us-ascii?Q?hrgIWoLF2ia7QQ+7ZZ+S0xSKJEvc2At5kTIQ8XrR6eJVm4sY634f2pCQatvP?=
 =?us-ascii?Q?sMtCbTfkqtg7EZ9ypiwBq+IW+4coL38//WqGYQ9gAt5t6xs3jjP7HXwxBeJS?=
 =?us-ascii?Q?ZLXbZGqFwqy/ncL/ebmO2MXH5JXgB+jlz8e8wuL/N9nmIoekignj5dSal8YD?=
 =?us-ascii?Q?vym4mUV0mARb11fG2t32VHoP1OEC3dsl9MYIQHNJQJ/BJVoQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 015055fd-2248-43cd-8a22-08df17bb9193
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 08:37:27.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o40LKHRoYNawtL+b02szkOP2QYWBcz2DGq0j3dIK21ZHUfsvKMkVy3AfDnZOrzxYEcnGy9Ii04RR5cr1nZjSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3P153MB2029
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, September 21, 2026 2:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] [PATCH v2 02/33] bus/vmbus: remove packed attribute
> from ring buffer
>=20
> The attribute came from the FreeBSD structure this was copied from, which
> ends in a flexible array member for the ring data and is asserted to be p=
age
> sized. DPDK computes the data offset from the page size instead and never
> declared that member, so nothing is left that packing affects: all remain=
ing
> members are naturally aligned and the layout is identical without it.
>=20
> Byte alignment does prevent atomic access to the ring indexes, which clan=
g
> rejects with -Watomic-alignment.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: weh@microsoft.com

> ---
>  drivers/bus/vmbus/rte_vmbus_reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h
> b/drivers/bus/vmbus/rte_vmbus_reg.h
> index 6370a07f95..210328c877 100644
> --- a/drivers/bus/vmbus/rte_vmbus_reg.h
> +++ b/drivers/bus/vmbus/rte_vmbus_reg.h
> @@ -69,7 +69,7 @@ struct __rte_packed_begin vmbus_mon_page {
>   * Buffer ring
>   */
>=20
> -struct __rte_packed_begin vmbus_bufring {
> +struct vmbus_bufring {
>  	volatile uint32_t windex;
>  	volatile uint32_t rindex;
>=20
> @@ -111,7 +111,7 @@ struct __rte_packed_begin vmbus_bufring {
>  	 * page aligned and starts at rte_mem_page_size() from the beginning
>  	 * of this structure
>  	 */
> -} __rte_packed_end;
> +};
>=20
>  /*
>   * Channel packets
> --
> 2.53.0

