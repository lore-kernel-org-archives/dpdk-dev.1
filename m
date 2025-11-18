Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B70CCD19A
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 07:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38AAF40281;
	Tue, 18 Nov 2025 08:39:13 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by mails.dpdk.org (Postfix) with ESMTP id AD7A540150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 08:39:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ7KxelU+BXcwkVjBHBvGiOId4uATNqShUFl8RY2f+mgULfIkzvhhi8yVGSobD9ZL/kqMnKnRR1IsFmGoc65gmrd3Q36IBOsi0eIE8vAHAaWiUnR2HUr1rg2JnqrLB6NlTGpoJsxmwC1/Vl2xLn3mqw2pQ49yebJBEUmOMd595hEeR+x5Y+xZsvIZdHiGIcqeTAyIbKGry1aGe3YbRLYYq/D6nbRESrx3XGGy2gVB1GgJhZNQeOPWFFnY4CvwhFDeryZ2a6H7vXYeWT8kvQpTSLhiFiIw0mX4i2OoSEkbizT+dNij1yDDU370/jcleCxZY6PtwjDfyxhPiBDD491jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHnoJvxuSX4YnH/9zef3aIwbzKQBCwEoWnTHTLXAcEk=;
 b=jlLH0imzN5Car6SXElRkox3XUmj9e/AMLD16N6hWlAy2ZaJuAIk6ltwux6h7tokV8t+KvgISlxXH3YrzHWTYzjgSn/ikfMnvh0jjMBHvZ3FlJkFetSGnSuuSkOJKYDL52Z6gaPWEzFw+T31KSQ15WAHA3vj8nyI81RgV68DnbkSlYLPvSytJWI0X9rHwosX7qtPHhaHls0TdcfQtqtxuBfH4DNnYCjbfHk2CDArIZWjBJmXNYs4pHMK4ZLibVH8Vyft01ZWxGNRTSvO1RE4BKF7sU0D9AhHcJe0nUGvRxIavZ470urt7lFrG8/z7AnbrrNSiq6qdY3QxcOrmWN6a7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHnoJvxuSX4YnH/9zef3aIwbzKQBCwEoWnTHTLXAcEk=;
 b=ilR66VHnykTE0Wmmdur6ZfY6D1lh8+rEtZYl/U6sGj+H+Zbnd6npidfcgZDNilX5ZQvJW9wwkBX4QkY1O7wJ9PpAlUMTZL4Q5EBVxwOjJ8j0SBVN3Mz80KLaG8GUucNtx3qThe7r9hNLbvadM0J6G/tSU0tXueIkSriPLXUjbbSVHz0TLpB/vnhNEVR1L41WVreA2wXCM0Y/har01VdGoGzVhEbogaW+X8k20Wjm9TOVt7NwZY++gxKP85wyM09SPMdiXqmG58LToC90ilkBr1KHPmDTlTlT+9rNIQOG+H21+I2QNe/9KJtfj1HL6aA1Ys1kNJOFLGCe+3EcNRJXOA==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:39:08 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:39:08 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Gregory Etelson <getelson@nvidia.com>
Subject: RE: [PATCH] net/mlx5: improve error on completing table resize
Thread-Topic: [PATCH] net/mlx5: improve error on completing table resize
Thread-Index: AQHcVZzMpy8f14cKxkWNyLwEzxRLdbT4EWkg
Date: Tue, 18 Nov 2025 07:39:08 +0000
Message-ID: <IA4PR12MB9763EC1A5333663F77DAE953D0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251114192712.1637369-1-dsosnowski@nvidia.com>
In-Reply-To: <20251114192712.1637369-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CY5PR12MB6129:EE_
x-ms-office365-filtering-correlation-id: 046ea59e-399d-43c8-5f7c-08de26758f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qDyWx8tsM+7oeG4Suh6c7NB9dMjRbFTrAv0H0V0WLlqraJ13Y+Q/X+17NFxl?=
 =?us-ascii?Q?QWIyRJPY/ijbMCvkrhQlppEV4t5y9k0YeD6tz5QDTX8p/6KxFpdYIhVLzp3H?=
 =?us-ascii?Q?bxEwd0GACuNLnxKqsbk1lnKEz8hz7kVtUpgDdkvSXuLw6y87tUMJWwg0l+Un?=
 =?us-ascii?Q?h5N8NBml9gE7Z9V5lJJ2DTYbShDpcTffrtaHaKV1FCfiaVoquKf640xWuAiH?=
 =?us-ascii?Q?+oy6r5X1GjQeKc7jFXDHl/wYu5kdB2N+0uxr6lCjB3EipqKA9sczKa/BBz5N?=
 =?us-ascii?Q?jpVA3Izvo6bJ+Xv0OC/TR2pUYUTcnFjTAKFFu+IPYXVlp8yTdVyWDTS1nPGQ?=
 =?us-ascii?Q?wMk3JgxzqtHGLT7E1N+UOgpgHm191kEX/Mo5rW/yidxKOIAwoSi4aZNQ1rhx?=
 =?us-ascii?Q?jg1CKORzvNsElLrKRQVMop4nEM4/cq+G8RPdGXOhqua6IX3b1Ri5o08rK3tT?=
 =?us-ascii?Q?WaE59mCJMOwCfeJ2YWsk+Hjcpm/8rlPDRrJIs7pUoPnsP+HcmC4YtGSmS0T0?=
 =?us-ascii?Q?3PkP4knQDCFhTJ72gLVVIGfuZzrx1VfI0OrQwAenD9jB865gmwEYAmRqqRVg?=
 =?us-ascii?Q?n/vYp+RBWJVmLpmg4BPVz3vdJBYDBv7BV+t7xjv6TrN9RHePdKsr0FmXSTiQ?=
 =?us-ascii?Q?kJVI584qCcyP6agU5rVqvZDLW/FhxsoqSE7jtGpdHJ994VN7PVeFtQIvvMpL?=
 =?us-ascii?Q?41S+gtYNHrovGoajm/bdeAsI/HHjPROpC8CZCt7e2F3ZWp7q8KvRd3QpBVmY?=
 =?us-ascii?Q?s9MiXFruRV5XQKYU50VGVgjcpXvvGM4kwnmBnjAkvXiPzoUAkvURS1HP3n7p?=
 =?us-ascii?Q?KzMRtxv2Vq1YXnEXxd1LGE4XLJNVq8ugiT5xJjwTPZKa1T7tcKj/tBytEhud?=
 =?us-ascii?Q?lvuGo8h+cGqcdMo6OQQ7gIgi5D8TVwpf9gCJIzljKCA3Nu8919Udiwsnlvuv?=
 =?us-ascii?Q?iQOfHu3gBrFxchd5D2hONFwIOqnYDpmTRE0uPUfcPDjTcFHEiEllMbaSCupc?=
 =?us-ascii?Q?Az5ThSjKnbvrL+uqpf8t26qSjjFK+6Tx9a5ZDfRH3KCLBvcERGyX57Dka0J6?=
 =?us-ascii?Q?7Rt48eE//pxktMDeJtXvBSMvTZrz+VCBoRPp+FswSLMpKM1eGB0Xa/ronlb3?=
 =?us-ascii?Q?lnlf/7bWn8ePWtCfdjmu0uIPShaWCpodnyoxmsEKU/7nL+AdMs805NMA9VV8?=
 =?us-ascii?Q?Juw0v/sDc4JtXeN72X3wDHF0A5xMcP71n2fHvtWtFz87oeDUqoG252Ds3oAy?=
 =?us-ascii?Q?Ur3mViRr8QXyxzOCI6rV0cXkKTj/vn8qvqcxtBrnQbAQvYOfCBa04vY8SFzo?=
 =?us-ascii?Q?0VEEBbhCpEjcC1bTaweVXDcMKdrDtJbxv1/U1ZNfWb2gOy4iWJy5uRQNlyjx?=
 =?us-ascii?Q?NamozJbdUJ2gBM8q2/JSqKER11v4uQD3s2hnZ3y01yhWgLUDCTyjRcIl5Tii?=
 =?us-ascii?Q?yynAw2qNnLzZon37BfnfaMsx3bam9r9sFhr1EnPg/XOxxku4DXDKqre8poT0?=
 =?us-ascii?Q?l8Q7t9sjHRcGaG67wqs0904ckkaqt2RWmxwI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lefkNxlPMuOf4fmt/LPTBIys5VFjfPx/FKrAI70hDL97RheHxTv/8utC575p?=
 =?us-ascii?Q?odAERSS7UFt4blutOkwtZ7QIE4pkxEhceRbfEHQ1STgJbbFtUy9z+CsBu3GM?=
 =?us-ascii?Q?yPPmq7shKtbYnc+he3bDb/XyoRCYYXj/qP5SrkQAg7aUcc3U9kGLjtIJ7SfA?=
 =?us-ascii?Q?6ZE0GBJfz3rynwvJJglfxCyp51JVvH7OwkpPcgOjJYt8sAAFYnlWoXlHstxr?=
 =?us-ascii?Q?28Gi0kk7tWSS5SxyiybWu7xpPjPp207y+clTVeS3ym5CJ10YBsQmfy5VLeEo?=
 =?us-ascii?Q?5qXy0nkxaargA0OTZRVgup4+YT7sm3/BwAGOi356mfmWyLFGaLTuUHpHV3Iw?=
 =?us-ascii?Q?J6XhbnOI95HpdQ4SAqb8hs/opK+KG8irMOe+GXh5UmRjV38+ADqQqCRRHszU?=
 =?us-ascii?Q?H/1iAQoGx7CrMEmySQMi2iQzgFE507eIfaMbBETl1UTspqXlfBlfrw7QEAZS?=
 =?us-ascii?Q?iK2KmIbhhRf5Q0md6dKBQxCoQQ8M5HhUzZhfZFLYKpguFlIDJoQgDkczkHlL?=
 =?us-ascii?Q?CzDfeRwrkH81BYn9UpJ9Aw8pnU/QFVI0s6Slxi1iAj3hs6p/Vu3MlbGgnKEI?=
 =?us-ascii?Q?HhURszA/2wJoJaZwzoi0HrdeN8+rmJC4HtkR2NjeL90OHG2B3Pd6M7pZR2Rh?=
 =?us-ascii?Q?P404ZCFDJ5JB2qm8GZLac40on0w9DnTsM60lLWjBOrmSpcDL7pY6KGI4c9xk?=
 =?us-ascii?Q?kXS7hlG5Ai4ISxdLx0Zvnm93C6LOcoNmqPKvAv4EAHb3oLT5L7S/SsNGdm/J?=
 =?us-ascii?Q?2anR0Wu7V92l7/lDHLEcmTuSPS/U3l0/1bVc7yUG4d69mYwdEyw5E19XnmzX?=
 =?us-ascii?Q?sGrooIH+lsyzOBOTQGJYT+nUPqeHff1suaspOYANGWwlDCiouFRdu6Z2HVzF?=
 =?us-ascii?Q?1u7HA9vkgwE3EnbhukoUkj9cRSoIMBGR2L3J62hpMOgb829A+uKuuUHC4AVt?=
 =?us-ascii?Q?dRBIJIilRcCRxGP+ptXsWYO0YKDz22XAzy9FZyfKTHuYedk7Vl8KSQDhKcu6?=
 =?us-ascii?Q?l7ntD76g+nZvQqcuoucC/fQaUTED0useSgOHcJBBcI45+mR3/lrwVAGTYjdK?=
 =?us-ascii?Q?F3eoGq5SLifr22czxZarXH0+vxOoZij6BujHQoKkg/Q9gsRCOnhkg/hInfGS?=
 =?us-ascii?Q?1UA7RTKBScEXpJTulOVL4271QBfsC4GiJq3+Tk2egpDlL91x6uua2JjETIip?=
 =?us-ascii?Q?NGMMQSU95cgy1XYAXEjDHAO2WNgwx1onlEZBg7hTeDsHCAXApdXYoauPGWk1?=
 =?us-ascii?Q?TC6+D/8dmAuMGFws7bj7EZo8Nl1eq7Gugwd7HgqwvtbCiGj6ndvQx4ef4Q75?=
 =?us-ascii?Q?ipwU9iMCY8DPUOIFWTtwGkAU7NmzL2C0/brCrGq++HJ1XX2d2FEOXcINefjA?=
 =?us-ascii?Q?jrMYEOkV55FKF6XZjzOwa08VKa6ZQrhNnlaKQBSdr8r0A2cuJUlaTOitEdjb?=
 =?us-ascii?Q?hk+2+0/TiRKGdNVIUPVdGtOjVQ/z7MzXfPI8mqmwhC4lvoRDY+Gg+JT9wYwa?=
 =?us-ascii?Q?t/wbrTUCUaH8jGZO/d51UekibeUoL8vkv1b1PfBnu0QDxmv6I9liylatWfjM?=
 =?us-ascii?Q?SZyMElg6hBCgwJtHhUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046ea59e-399d-43c8-5f7c-08de26758f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:39:08.6649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TKu//9+Q8r+sl8j0tPFwd1meJh9wuRA2zY4Mg4bibrfh8HRK6c45cqBhtNHJfqHy89etAd8darMZpmT9mEPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Saturday, November 15, 2025 3:27 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Gregory Etelson <getelson@nvidia.com>
> Subject: [PATCH] net/mlx5: improve error on completing table resize
>=20
> If flow template table was created with resizable attribute, then
> completing table resize could fail for 2 user-related reasons:
>=20
> - not all flow rules were yet updated to use the resized table,
> - resize was not started.
>=20
> Both of these were reported with the same error message i.e., "cannot
> complete table resize".
>=20
> Since PMD can distinguish these 2 cases, this patch improves the error
> reporting to report these 2 errors separately.
>=20
> Also, this patch removes redundant __rte_unused on device parameter.
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Gregory Etelson <getelson@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index 208f50fbfd..8f3c84dec5 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -15384,7 +15384,7 @@ flow_hw_table_resize(struct rte_eth_dev *dev,  }
>=20
>  static int
> -flow_hw_table_resize_complete(__rte_unused struct rte_eth_dev *dev,
> +flow_hw_table_resize_complete(struct rte_eth_dev *dev,
>  			      struct rte_flow_template_table *table,
>  			      struct rte_flow_error *error)
>  {
> @@ -15398,12 +15398,16 @@ flow_hw_table_resize_complete(__rte_unused
> struct rte_eth_dev *dev,
>  		return rte_flow_error_set(error, EINVAL,
>  					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
>  					  table, "no resizable attribute");
> +	if (matcher_info->matcher =3D=3D NULL)
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +					  table, "table resize was not started");
>  	matcher_refcnt =3D rte_atomic_load_explicit(&matcher_info->refcnt,
>  						  rte_memory_order_relaxed);
> -	if (!matcher_info->matcher || matcher_refcnt)
> +	if (matcher_refcnt > 0)
>  		return rte_flow_error_set(error, EBUSY,
>  					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> -					  table, "cannot complete table resize");
> +					  table, "all rules not yet updated");
>  	if (matcher_info->jump)
>  		mlx5dr_action_destroy(matcher_info->jump);
>  	ret =3D mlx5dr_matcher_destroy(matcher_info->matcher);
> --
> 2.39.5

Acked-by: Bing Zhao <bingz@nvidia.com>

