Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F9BC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 08:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8BB402DF;
	Wed, 26 Mar 2025 09:31:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9DC22402DA;
 Wed, 26 Mar 2025 09:30:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q1O9T3027042;
 Wed, 26 Mar 2025 01:30:58 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45m7vprpag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 01:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4NQCiUiNr5WE7Sh8/dZwZw3ZDxaSvWhAuiy0SK3wH8sQEx4BQ2lgXOHlGiNc95RZYigv+gbLAcDtb4XMQD8vsNOTF1bLgJEZDwuwSapZu3g6cBtFbhyV4c5CSzRXTMuMMPGXyYFP72tM3VDPih8sfgEkLasJ/+5TjKz1n3qBard0HvzLk3GYH/j+FJ2b1L5x+B9kRFVb1TYQ7Ya/zEN+vmtXyfxigip09saKkAicB23hd/6tA3ULA2ByGhEZlmDpa2wsGnHhblLbwjuXCVNbP3nfsaK4I09xhDymLHYiWC51Iz2+MIwztqdHfaCRW5Sipp4pG18ZVs1exoXiVWUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvqvoqw/mpyMnOYofufrJGIYrp79Dn2gqcJtW5TvpXg=;
 b=bxJ/H2F9N6bmFIq9oUWLi3srLFkaX/A5hPUteXBEmVhZ4Y3c4mvSvS0GNrmSX83L2yzYi1jR77oRVW2BrlPlWduzMo7R0b2fEcgLrlP5Tj3C2ihLLxNdg70WBvbjQFwc01uwSkEDTxO0ZBbs9H4byBY5RJTplVuYdo1obxAUXeU2PtOiORsW9p3z+2J7uPiZboltMn+nG/+mhk028JVp4zqlS/V4qdDrFAANjo6WGRo1AgsoVcaofTHM6JdPnnvnJk3WOXLMlOjpXC73lZTCaWCEvgfA0sAiGSy4Ui7qUDa/kzdALUvTG+034oN02Y9Ju2mHOWE9Tq4aFrt9u1zakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvqvoqw/mpyMnOYofufrJGIYrp79Dn2gqcJtW5TvpXg=;
 b=A/8KAzJd6YxW/Eg4PVcuT4u9CX0u4LugcnNmh9iYTjJ4GhdeGZXX6SNZEMNUbdozviYrcXdVMzKFJ38OMSmKDjxsvltC0CKHzL9lroCmtBLUTicpUSiIQi84N9EUO44IPI41StYM+yHgRqUu0D6ZAk5OS1WGWOfS2cWg03qI9yg=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH4PR18MB6140.namprd18.prod.outlook.com (2603:10b6:610:228::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:30:53 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 08:30:53 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Vamsi Krishna Attunuru <vattunuru@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v0 1/1] net/octeon_ep: fix buffer refill failure
Thread-Topic: [PATCH v0 1/1] net/octeon_ep: fix buffer refill failure
Thread-Index: AQHbnK1lLdQlHlBpIEOfGJMZquZXtrOFGRwg
Date: Wed, 26 Mar 2025 08:30:52 +0000
Message-ID: <BY3PR18MB47854A817558672AEC1E824EC8A62@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250324110850.92072-1-vattunuru@marvell.com>
In-Reply-To: <20250324110850.92072-1-vattunuru@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH4PR18MB6140:EE_
x-ms-office365-filtering-correlation-id: 477d0432-4ad9-421e-da69-08dd6c4085bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ebDQZqKR5Nqi+JqLwx0v+uW1cU8ndsmUvPN9jHUTJEu8R8XqVJO4X+3Vd2qh?=
 =?us-ascii?Q?H25G1huCSncSPKW1yBd6Y8uVGiWt1qfzhjDsWbJRA/AGoXi4VlHppy6b3vLn?=
 =?us-ascii?Q?uIqVgqyd1uLV4cufeYVkAuRBPbgE3ENNS7N3xaiIa98p8gAsSEtz9w3HiGPa?=
 =?us-ascii?Q?6xquRRn+rDbtQM25rtmVPm87lkwlG+lR2X8daQYGXDqyDwj84Fq3xZes2ioZ?=
 =?us-ascii?Q?E4VACyHi9EIaQazHeH6o6/56vG6WbzzQ9JYJ8+QYPOFM2LXOA8sN0rPULqzT?=
 =?us-ascii?Q?qf/Y+mnipdzkyEkkTg7av8HcGdRwUKpJWrEnV0PRUgeRa4Zbs40HcKcQ3u96?=
 =?us-ascii?Q?eBn9ZY0ZyH+tBF0ctwU6jBNqdfCflQULsro4yOCT9I5va1qVsHf0wcgCtgqW?=
 =?us-ascii?Q?sQ/C5bWu+B4nzUaa/tbn9Xh2h6vWy1FR32qtNrKUbKEPvjQmKeeXME3PAx9X?=
 =?us-ascii?Q?+GOolYMI9Rot2V1pv9Lv9OfVSLut4FJmNdz4F30khaL9MTVQzkQZqq/iM8QZ?=
 =?us-ascii?Q?GmUipXA/yHD8xOoGYGLg/pWxdQrLGFTPVkAOlunmGfuDW8KDje2Oob3/4Oep?=
 =?us-ascii?Q?IeclIGgqkxgzgde3bQruRxwzu+Lmrcb7l99hq3nOSziuDjq++/bYh3rfQwfs?=
 =?us-ascii?Q?aX2mdhB5wTf9rV53PUON2NadJI3+emnxBisJ75UhD4W3+dE9PcKpSB3/zFrZ?=
 =?us-ascii?Q?poe0LY5uefK/+adLNBBd5Y/oDCXQPRNbNFKNJm1a9WdrSh8vz+AVlOqhvH2+?=
 =?us-ascii?Q?zYQKKBTsZ8DffYHHADRt1UUGBoQYvugDIGSK8cpZl+KAJThou9oa7YLemZ/n?=
 =?us-ascii?Q?MKiidOYQSpKtKlpXgb5kXpBtKYfU2pAs2TvmSY7CltTImietXe+/2G1zi2Ho?=
 =?us-ascii?Q?oDRmUIrZJwgoidQADbbHVrHx+IwrhqNx/tZgNjjoIpbnM0YE0QKHqTxtrJZc?=
 =?us-ascii?Q?gTIWdxz9gecHyjYt9gW3dsAZAxti8OcNmPxpB5zZyiIH+78gLIZKFBDdg9sV?=
 =?us-ascii?Q?G3ZuqoKIWIiLV/t2xW1/WUKJwB7kviTONLhLdD9MPH1rasH/UeUcMxhpmiZu?=
 =?us-ascii?Q?/xDw1DhcqeHp/jBiY7sBBCZK6W8j/AsmoFJuUdWyWPNmCD+wtThQKvUze4y7?=
 =?us-ascii?Q?ndWlfHuea7nelekphOb4Nv9f1dHiIcTKw38FkKK0ZCKozIiWa4OLwi55nek8?=
 =?us-ascii?Q?qTcmhDilUTixITPaAPsbDwbae2xZgOKxe5ECEr9pxycWFeTLqkayQF5Xw4kS?=
 =?us-ascii?Q?GdKssxofm6/d8C1Ueg8mAxyUFTL4hqB6Z1ybnJKCGELWohgASS7OsZuO//e/?=
 =?us-ascii?Q?oGDgJiGe55kH88CeNbpi3LP3aY1vKjuf4hs9/ct7/cMCw666TXJkNRmfPQJc?=
 =?us-ascii?Q?6Epq+wCdcuy9CX113Yju8/PNt0qYkkWG4pCFls2e3SkyFyEIjThexOdkzQfE?=
 =?us-ascii?Q?J49G6NUtrnnDqu5Q4usANxSunNzB1ylj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C91m/0HQGH8/jPyOM6glED7EZxEAFnI8adbmMwqH/c7qxop7s1/HI0jc/XOY?=
 =?us-ascii?Q?upBKS3c9xomaPu1a3q/yOhxILbeXmNrBIEwEXoLMlsTmR9flop0AOHoP16tS?=
 =?us-ascii?Q?FXTX1XJY8lZQHaNlVQod7+VXmuipeeIpawdLMe4/r8GxrymlwIGbV01XG4j+?=
 =?us-ascii?Q?g3H62koNYEfgSFA+tViGGqHc2TCs3RRtcwMMWOsDkY5+ajqcIu283ut4xPvr?=
 =?us-ascii?Q?Gv2iD4pMeiN7qAxwNSlv0voMV16rEtMJ3GpiWt0yvYZa1NVux1Dnwp+puVgB?=
 =?us-ascii?Q?/x33BUk+fGLfslo3hBjfuRjMP7wMEjw2PHO3l9dE4oIQ9u+9YbB2rmZLphEV?=
 =?us-ascii?Q?8KAsz2Z366xt9162wpKp3Ae+sDXA8a1vMBf8psNikN0HnKuU6IgqrEzSARfD?=
 =?us-ascii?Q?xSVRzTOc50NKZU1vt2LMsp+qS5Y3BHfIyatL5P+UZUmVwVLwGgla2bboFNhv?=
 =?us-ascii?Q?hJkTg5mtBO400FNCCbUCB/taMbADiafHaGznoglERoveqp8Bgl+yAYzYdWrQ?=
 =?us-ascii?Q?nY3cnMiFOaj53U5yIXD/TBsuRHjVskRZDrRnnEbTRojALHt9PszP7hdFPn40?=
 =?us-ascii?Q?RItJ/fCBTs7e5O64/vlzss3TOpap+vutrUj/XfMNV6aAbzld7E6qh4oHee1u?=
 =?us-ascii?Q?ArSHkQCUxbCXeSa5BR/iW/Bu0V9va9ScClbo54WLbBf+yUIDBds9oLPyQtQf?=
 =?us-ascii?Q?2SCn+x4WXIy8HQ77lVttS9FZDje2C9AIfY8X+wLjqvBw2PYmjoj4qdhYMg2X?=
 =?us-ascii?Q?SFIQuE1slvTxk0qJU48YVYpOJlvdHQt5c4xmdkrkPAQPSbKJTbkg6RHZ96Tp?=
 =?us-ascii?Q?j6FE2R1JeCzlTFkNBwwxo+D8h4nFSowBB+RT5gdbegyMHgC/eW+2Bz8cnwi4?=
 =?us-ascii?Q?GuMU4j1GboVKXVfNzeCOUQIT1nI6tmNnnPHEwfuO42sZOP7GE6uWW68Mxnxs?=
 =?us-ascii?Q?AdUJiaiVNm610gcaodKmoYD2yTr8jgS7PnmLa6dXhEAhQcauzBF1kGGzA9jf?=
 =?us-ascii?Q?njxnLsGTgQaJUc2/58tH/dS+wEnCg1SE/bw2mkLk/0XdNsw2n2B1IIeIQbe7?=
 =?us-ascii?Q?yARgocKQAHN6XfQaAaae5/UMfLUk/Bdp8b0lKewpCttISUQSKmjhaw4GCYTH?=
 =?us-ascii?Q?+2m9C1ixnC1g1lUqWqckfgJaqfhWPKnA7Dy+JwTpCfy4i+SO9ZAKY2Z3vE73?=
 =?us-ascii?Q?WQ1K4+zLEqs6WvHLG3Mad5xnLO91fg1JCiv+fzFGOpZptc4HeP81cunf4qDj?=
 =?us-ascii?Q?sVHyA7E627BI39erTr6+FRTBdQiBs3SfldFXjh1uYqqR1lDTdkcrQkKRQIjy?=
 =?us-ascii?Q?usIjLCMg2HNmOi1dW3wY6oD4klKlTsg1NXUi9hprPu/RuWNeAVKHlJQvM7xA?=
 =?us-ascii?Q?jZ7lShn9J8e9RoTu60VrZPNK5P5+LRaCP4GwmG7xfoPAawJdROLbQ0UrZ/7z?=
 =?us-ascii?Q?yOs2WrA8duVljKCe3ufapVVRjLgJVWQElSFuQ8VYa0vfeZhTIDBe5CkkLWhp?=
 =?us-ascii?Q?eYf5oRbgqng2rSlL2NqxJ0JsIX4IU3sVzktV8jmRhI16Ke1+5ijwm4S/7yNB?=
 =?us-ascii?Q?KCaGmk4iW8cQ0dFzY93syt8ua+7OqC5ZwuorKCU0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477d0432-4ad9-421e-da69-08dd6c4085bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 08:30:53.3648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nT/K5rgGRAH3Xxbm54Fb29pk2/N8nK8xzdscHgSjdwkaqD/8D+ZzpbcCVuPBn8Ak3ByeCQziWtIyyeZXo8ZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6140
X-Proofpoint-ORIG-GUID: pe_n-0lFHXSmc-vGgQE0af3_-G9xOu96
X-Authority-Analysis: v=2.4 cv=E4PNpbdl c=1 sm=1 tr=0 ts=67e3bb42 cx=c_pps
 a=GDxOUaUasxmcDRSC7gC2IA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=OXpbGqmncCMsfP_zSZQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: pe_n-0lFHXSmc-vGgQE0af3_-G9xOu96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_01,2025-03-26_02,2024-11-22_01
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
> From: Vamsi Krishna <vattunuru@marvell.com>
> Sent: Monday, March 24, 2025 4:39 PM
> To: dev@dpdk.org
> Cc: Jerin Jacob <jerinj@marvell.com>; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Subject: [PATCH v0 1/1] net/octeon_ep: fix buffer refill failure
>=20
> From: Vidya Sagar Velumuri <vvelumuri@marvell.com>
>=20
> Fix the buffer refill for SDP output queue
> Fixes: ab09499e809c ("net/octeon_ep: add SSE Rx")
>=20
> Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
> Acked-by: Vamsi Krishna Attunuru <vattunuru@marvell.com>



Updated the git commit as follows and applied to dpdk-next-net-mrvl/for-mai=
n. Thanks

commit 5b1a795452a09eb6a0b0a4d8eccd113c1c53f131 (HEAD -> for-main)
Author: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Date:   Mon Mar 24 16:38:50 2025 +0530

    net/octeon_ep: fix buffer refill

    Fix the buffer refill for SDP output queue

    Fixes: ab09499e809c ("net/octeon_ep: add SSE Rx")
    Cc: stable@dpdk.org

    Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
    Acked-by: Vamsi Attunuru <vattunuru@marvell.com>


> ---
>  drivers/net/octeon_ep/cnxk_ep_rx.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.h
> b/drivers/net/octeon_ep/cnxk_ep_rx.h
> index 83677e1c6f..5db32c4448 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx.h
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx.h
> @@ -72,11 +72,10 @@ cnxk_ep_rx_refill(struct otx_ep_droq *droq)
>  		desc_refilled =3D count;
>  		count =3D droq->read_idx;
>  		rc =3D cnxk_ep_rx_refill_mbuf(droq, count);
> -		if (unlikely(rc)) {
> +		if (unlikely(rc))
>  			droq->stats.rx_alloc_failure++;
> -			return;
> -		}
> -		desc_refilled +=3D count;
> +		else
> +			desc_refilled +=3D count;
>  	}
>=20
>  	/* Flush the droq descriptor data to memory to be sure
> --
> 2.34.1

