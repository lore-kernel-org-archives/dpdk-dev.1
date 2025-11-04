Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA5CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 00:29:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1040402B1;
	Tue,  4 Nov 2025 01:29:32 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020135.outbound.protection.outlook.com [52.101.56.135])
 by mails.dpdk.org (Postfix) with ESMTP id E532240299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 01:29:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv572bSR/STpPrtRHJG/C5SJEx/P0QfSsgu7MmaYhoD6U4MVbPNpXMcsBf+itBCEMIwki6nUFProneXI4EAL2G6He7U1VFvSIphzwkXiw4Vj33SWeDmHpHZmLQLZHaqsvnK9nIFb5QUoKhDRJ/3GDRe85yDwwmRN1RQM4q5Z5fip5PhEcrtd2+fDykUuLzWJ6ap5kyJE3hCt781WsIaSNE6P0hHp1tN94lPZaCd8vPCo0p4u2uoNuWE+hJwRugICS3ffyZcsfLK/RagESFNmi/V/clJ+nM/jMbIK98wEPuX6C7DJvSUGxKuJ5l8g75piDJpRUL03s0f0IUu83i36sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbhex2tvVxs/h0Nb8UXqY39zOU2TVa8qViBpjmtmYGY=;
 b=Ot/S9dSDzVVRMuFQqQ9531gP17QkJDjMF/LrASHxhSKhk65fDFz1huG5iKb5/qHU3mgp6u2txO6R/nSZ+WLRDNuCx9xqFadfpmiP3s0NrO/LsqH8MqKy+6L9VVzU0iQ2n/6xBefNrL1nJlROUBUvIOexhx0PHIm42BGb+s1dvDux6l4zeDZLYeTgBe4tYfVeJQ4B2S/dqSShS5dlti4td436+mcFQP2qVkclHjqCzxzuYQO5VTEAj5Em6hpLk85L8d9GiS/MuCr5IFC1sHHEXRFqgpzaJ68awlgcvdT4xMrKLy8WaRLNa2bBUjqft7WbC/xPi2WXc8QmqWmRk91b/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbhex2tvVxs/h0Nb8UXqY39zOU2TVa8qViBpjmtmYGY=;
 b=BFiK12ltaArXbkqD5JebVgLcfzMTe2FgP69skLmfDhfeO3LM4mjlCPp5Yzyz94kAjZ7HJlMrJSjUYHdNHoOUYOhkHoHWZoK87xZg/i86ROdXlwK3i5cBwiyhmLV1W2CHJyjTko/8sydPUEDiqgJnMK1vn3XCNZImJDkPNasOGl8=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB5204.namprd21.prod.outlook.com (2603:10b6:8:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.2; Tue, 4 Nov
 2025 00:29:29 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%7]) with mapi id 15.20.9320.000; Tue, 4 Nov 2025
 00:29:28 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [PATCH v3 44/44] net/netvsc: use LIST_FOREACH_SAFE
Thread-Topic: [PATCH v3 44/44] net/netvsc: use LIST_FOREACH_SAFE
Thread-Index: AQHcTSIUJTcawJaaikedAXfU2LiyHg==
Date: Tue, 4 Nov 2025 00:29:28 +0000
Message-ID: <DS3PR21MB573560A43EAF4DCB2333E716CEC4A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-45-stephen@networkplumber.org>
In-Reply-To: <20251103164915.101713-45-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=67e3dcc4-daf0-442b-9219-9411f882c903;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-04T00:28:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB5204:EE_
x-ms-office365-filtering-correlation-id: 2231e8e5-a0e5-4791-39c6-08de1b3936fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qscYFPhDtIsSFA8UK7E5PXevRzDPusj7c5BrUXmhbJMzTVGJwm//CWu66npw?=
 =?us-ascii?Q?DvZjjAWZJYqbEqmqoqmsAhfmEPTFjPjH6nZMYzat3rOK8xBmUOnuusyV6Gf9?=
 =?us-ascii?Q?f4hhrbrJbQDm915pIZ2+l0Rs0pMMJKKF31DrTXBbQRfF7g8RDmrLE4Edn1LQ?=
 =?us-ascii?Q?3RlQBdaQlmluZBPEq2iDjAIEfE4X5y2309Nan7MWcosUIdHHJuuutDGm4QSe?=
 =?us-ascii?Q?Pjky66AmiFddBd7UhcVeKh51QfvdHkVEuDtpWNPqQaeXK00CXJe+drbB+bu+?=
 =?us-ascii?Q?0MoWp+8hfZMsIqAd876vwEzH+oA6/5AJ0cbNrDP6qrnPDPEN+W/j7u/2RHjM?=
 =?us-ascii?Q?GX6q4VEclQRAiCVh9ez9uO41AUiB8Rnibz8499gkA2xlhHYkIpH4rRADZmYl?=
 =?us-ascii?Q?UW51KnaAsVXlSPzhUlE71+fmCgKwMHnMJTlYg5m/+5Fi6Ixj51tXPqpYpIgC?=
 =?us-ascii?Q?8rsZiw25ilaS3m8zRrufF394V2WuJm34GLwY884UX2cWR9GMJl0WYium1sHx?=
 =?us-ascii?Q?dvxxyC7x2Aejxj69cep+Vvt/589CN/D9xg6t5d+l1NDhMdf70bull0ljzKjf?=
 =?us-ascii?Q?r53TKJYvWBrt5zR4paYpFqa8Ygs8q9pr4HlsL+fX0f7QwQpzpTnkujFHIHEU?=
 =?us-ascii?Q?RlUIv5r2YJmOBm62H+Kx5Fw8ARSzD1NRc7hfriDMzqELlsO+2Qmw0YppIlQY?=
 =?us-ascii?Q?s5n3f+jSn1Bd7uBsf2xLDGorIfaOTFo+hI8bhtNpTbd0ts8zsP8syE4CsR3r?=
 =?us-ascii?Q?wbmO4BEkAujpJN9DlHHc0CBRkTjjaXDOLtP9+6Pz7e4XuXwL8mJFJB/znYt2?=
 =?us-ascii?Q?L6/o6FejHrHfnwxoAUjXUnNiGKAJUhKi+KpgsKfIiPAzyWb7lLbfJefV4LlN?=
 =?us-ascii?Q?88dTdgnjHg7nQUzk2xt4yYrOV997y8/Jc9oX0SajGljBnJtnfL6ieqiLfFDV?=
 =?us-ascii?Q?hv8S1QnIfnJvOTLclIMUjkzdBsboKoOOJlx2ZSlZKxgCfATrGbMt3BSjVNMr?=
 =?us-ascii?Q?6QC0x/kh4JtcBpeUlv+JHVACOvkvpkV90lOPRobVypHUcO8Lt6yIxCmzhqCi?=
 =?us-ascii?Q?PTQB2O9wYehAaL0hlFSaggxM1AojStmZ7lzNStuLUbi1A4BTTuLTsQwN7Zab?=
 =?us-ascii?Q?0v5RhfUzo5NvNeVnKZ8CNoz1tdtqS0+THr5wCooYCer3VSZKGrEKadIYGel3?=
 =?us-ascii?Q?nKtFjDU0BHB54TrgVn8QUH5VCiBqcRmzOTStNlRrlM9FLK4BnF1XfeGQTxDv?=
 =?us-ascii?Q?nBGdKo3Uf6iQV7QB2fAqhjK6LxbO8OVkbQrFiXclSdT92mDlvZ4WZawE9IeX?=
 =?us-ascii?Q?Tzu2DXmBJJBJULVHZ69P7tyv2mCLmvhkfm4QnI7usPmFKziDTaQEarusfYpW?=
 =?us-ascii?Q?k9f7XTGv3bhTgZT1l5jLvoRDX1ePNyZ4aoGFYfTggOxeGBqbmZknq3xble7j?=
 =?us-ascii?Q?oEncmYtGzmzEU4KXsdKxGMBX/D3VFnJ+av5cB2DJzVvjhJUWAIhVMzxYUxjS?=
 =?us-ascii?Q?Siq51oWzNMwna1x2xinisfwuF2fcjUIkOytl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SeHOtuuXjrOSpYfi34bEx+Ejwd46/snXG5MkVKiVfwWDl6+5GUQ04F6n+ENs?=
 =?us-ascii?Q?vD0nN1pHRo3ohKTRQMSMAocFqe7n17dHozYKDde5+n/tLe6eERf7ZsITOCJ0?=
 =?us-ascii?Q?gsESqfLGl/DnEM2aQ6xAh50mRFHjSfr49wRJCWkhg+vz+mFBUKQJbn0NlAuV?=
 =?us-ascii?Q?Hwp6yCq6RbYGXpaYOZReCWgqr62L2elGgZEw8Xetobp9eM1et3WgbaZlC7E1?=
 =?us-ascii?Q?JzVYdqWCmcH6AeZJJz3rhhEpNXFPJ3hUBcKJaxBTSnpql3B1Mb89iRej7sHl?=
 =?us-ascii?Q?kwY08l9tRouZveJSu8N7llG/APG0ADo5LFkfCp5zeIpsM0uWlHiq7IYSeBrM?=
 =?us-ascii?Q?8Ytivc5BRB5BoOBDcJSJbT0dE4RrKZ+d3OiCZwW87Utx4GEPmpwayVvEpiXn?=
 =?us-ascii?Q?qSk0vHQKCZqSFHqHp2ETp2JVWOUrs4A7B+iqYgCFqNEeInVw9ljD4BGm+PHy?=
 =?us-ascii?Q?ATGwiATt9XmURiT/YPC057jMtzaz2/Hq5n8p7YS7c8VgFzl1ghZm9lsQ9yHP?=
 =?us-ascii?Q?Pjav5ek9+MHe9LRk87kFD5v9njmOf4n5XDYNsS7NZJcTyLdVcf+e9vkkxZHI?=
 =?us-ascii?Q?0dfMlSm4MZB8LEdydOYf1hm3LcT5dngIwONNhWVE3Cn1EGzns8J8jGVHkVKO?=
 =?us-ascii?Q?DAo3HSMZo2z8uyokxja5gVtiLn7pUNFf5kyXMQWQeaVjpCpwGeSvApRP37w1?=
 =?us-ascii?Q?Q+4JN0Eqce/GljnvXYNOTDKph/TYzEdYH/mt0mYzPdEZhaprcugFBkh0dQQV?=
 =?us-ascii?Q?0OFsRPIeJEiOY/JqF3Wj2KKvZnBsRALBInAyn+zSJFmMvxeX/gxROuaTImDu?=
 =?us-ascii?Q?FIiiRwihPHK3N6/ID//SvYloWaqR2tjknt7F2sGUO9BZkK0qE4kX94UunTQc?=
 =?us-ascii?Q?9eKIXFfZ4FgCJjzz5wL8VDSX0CTtJgVK2zM3UC9zJhLOjLKsYijwdnwidSsp?=
 =?us-ascii?Q?4G7wjkg4rVjYEtCOy51UKOwz8pBKN5kb788eBz88B+Bu13KezWvr46yRGkyM?=
 =?us-ascii?Q?xlmCLYRk4YngeGFhstQ2lwo6kY5s/71T06W3H/5RjRtFtGA7uay4IA8eG9jA?=
 =?us-ascii?Q?gjPK3k9e62SbWnQo1OlLOluwzp91vzT3vXKYbww1dFcPk90msqK2k7dzUEAe?=
 =?us-ascii?Q?mwvENRzZv8cVE06E4c7s+ud0dZQ2QpUkjsyLs7z0jwlwnl4f+MX8fEkCbF3s?=
 =?us-ascii?Q?R+/O9XOrmhNGQWluXZEAhXT3INyePZD1x/BxJS0pxVab3KhfBPMfqzgxXIwJ?=
 =?us-ascii?Q?Kl8sxMhUBjtCoi2nAhVPb7pBguBH7dOKbjDoHKX8ihc1ND1SszqO02Nslkpi?=
 =?us-ascii?Q?0pQ6drwfHfN+43aDex3yyS206ILGUAf7gUhzx1XuXK/Ftnxw/fma6qfzKshd?=
 =?us-ascii?Q?E9kmJanTbRjWomDcsjCoHJMbK5cttoTxl/ZZLPILUSq8LmmSf98cgtEAJPPK?=
 =?us-ascii?Q?XDklUzIRvnBG6iqCAn4Rc4T9p9S9p0Q4lKI4PgwmsX99jnwi78P2XepJS9e5?=
 =?us-ascii?Q?pKQuE87LTk3K0ZMQT1qY4Suih5EweJ9NhwIgcLaKYCvHfz9wVjYOYyncN1TN?=
 =?us-ascii?Q?F8n/+7dHdvFp2UtrP/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2231e8e5-a0e5-4791-39c6-08de1b3936fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 00:29:28.2753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GkyacxjbPszmaxYRGpvxyBm5lO3zdS2oQnmKpdGMblUTf7CAvAe3l4Yuavoc/oFc5+27HLbwZaDaTg6ImHDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5204
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

> Fix use after free in in remove_cache_list by using LIST_FOREACH_SAFE
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thank you.

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/netvsc/hn_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index dc765e88f7..bc243bf229 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -1479,14 +1479,14 @@ static int populate_cache_list(void)
>=20
>  static void remove_cache_list(void)
>  {
> -	struct da_cache *cache;
> +	struct da_cache *cache, *tmp;
>=20
>  	rte_spinlock_lock(&netvsc_lock);
>  	da_cache_usage--;
>  	if (da_cache_usage)
>  		goto out;
>=20
> -	LIST_FOREACH(cache, &da_cache_list, list) {
> +	LIST_FOREACH_SAFE(cache, &da_cache_list, list, tmp) {
>  		LIST_REMOVE(cache, list);
>  		free(cache);
>  	}
> --
> 2.51.0

