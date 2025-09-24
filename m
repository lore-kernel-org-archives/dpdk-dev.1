Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0563CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 01:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AB9402D8;
	Wed, 24 Sep 2025 03:38:06 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by mails.dpdk.org (Postfix) with ESMTP id 22F4F402D6
 for <dev@dpdk.org>; Wed, 24 Sep 2025 03:38:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRc1jiMf6aXC4fEa5diqUhyZ5Oib56QhUH30cwpjUBPpkCOezJksny8NDNBQzNtN4HJvETSrBqSZmaYURXL4gHOTUyU3/WBMaeIwqmC8gqVaXumAK4JCddyivHR7ylsgsSfESNT++b7e1X2aVUiI3FzpC0QnyCsy92C7V/e6nyuOvjPNsobPc85s/EUDVHsvd6PXeXro0fwaKppmng81YvmqGsR7HhC5RSYV8e0J6GDzY+GOZ1mXyiajaFxYWG3IsxfE1BkaNI0pqRtsiXjdwNQbonMEJKlGLYW+kD9/zpYC3fiRGYEjAlcO1JDRs6/+2V1wLlDHm5k9gdH9eAQsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4SDkSY0E1BhDcldoyYzO/dvRl30eWtfYLsRkp+xy3s=;
 b=DbF02Qt3GGaEKOpnoVY4KR4W18bNa5idhg/K9jpFxgOGgn/X7OJ3KtqfObSQM1NIiqVeR/3F9rdu0M15adGFUWnNXzWcaujk4H0r9r4/iGf2Q3py6PbRaDJ4vz51pGR7uTYq1S9UBwM8Q8HEekjzAV4lHbsnYexzCrhwT/H1gFqwB+7iaoGnUiW8PTdhxKGqPHWnSCaPyJlzjUoWMbN4aheg8Vkd2srQws270gi/Eh01WRlU8V8pv0yrjLeIC8WDFEOBaS3efQv0SHTIrWBIGOK7LyBi9d5dfhDZdvpkmoRUVwrv/pIBUeUWC7SDTZ2GWNyudMtgdBBDdCazz4a9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4SDkSY0E1BhDcldoyYzO/dvRl30eWtfYLsRkp+xy3s=;
 b=IFrw/OCTtKpmjPdQ0euxx25rp03DqwvywVkPjbKwt2N9QhyCcSuM+dGPRKvOEb93HMBtkAVc6aYd46XfLg9SgJKlTW5ZhavG8k0pJtXfGJHHdYz+EFSEcSkDzLps44AVttKDOd8IDiNKyVL0sUL8ki0JkWTHcQe30hLH6CjzpzPFbwxHvMhTY8OK1FreoVQzc5da7wCr/56ulp6kdVyqn+SPIn5kMCGU2z+9BXCl1TA3CYlNagrVuQc2adSrhxJWP++TAVdngDgVukr/vLUAGxuKoqkoR3l1trvb0gTSxNFZfeGGSiuXr3Pn2FIpnARSDS/rf2GRGAXR1JblfAvQ0Q==
Received: from CH2PR03MB5239.namprd03.prod.outlook.com (2603:10b6:610:a2::21)
 by DS7PR03MB5655.namprd03.prod.outlook.com (2603:10b6:5:2c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 01:38:01 +0000
Received: from CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792]) by CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 01:38:01 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC PATCH 2/6] net/ipn3ke: drop unsupported per-queue xstats
Thread-Topic: [RFC PATCH 2/6] net/ipn3ke: drop unsupported per-queue xstats
Thread-Index: AQHcLJQX+HJmH1GsGUakJUnGB2D+GLShjmjK
Date: Wed, 24 Sep 2025 01:38:01 +0000
Message-ID: <CH2PR03MB52393A6F0431E012992E9187FC1CA@CH2PR03MB5239.namprd03.prod.outlook.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250923141207.10403-3-bruce.richardson@intel.com>
In-Reply-To: <20250923141207.10403-3-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR03MB5239:EE_|DS7PR03MB5655:EE_
x-ms-office365-filtering-correlation-id: cb6c3b8a-04c5-4369-b17e-08ddfb0aff9e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|39142699007|376014|31052699007|366016|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rigU6+i+YHYCUVEsLb0/JWJNiecSUyZ9LcgP8+TUsQgr9I9HT37zWSi5ck?=
 =?iso-8859-1?Q?xah/Wc62h8WxM8DCjRsYlU4YGAG5MKP9r+0U5FTFJnxATi4z8ODX73gi6T?=
 =?iso-8859-1?Q?5AP9Px3appWOb0sSXKyc17HnlDuZ6jL8faS78eQp4tY1vMHa15QdXxrlhC?=
 =?iso-8859-1?Q?ju3I3kPhscyLXaluL8/xaE7lF+buB/2Z6bUKByAB13yHnIEi/1+Ukitl0U?=
 =?iso-8859-1?Q?K1CPCBNBTWqFV6rW7i3pyJnnv7uBe46b7k3mxuGfSPhydupA+mfG6DwvzJ?=
 =?iso-8859-1?Q?T53TsxjHTfijCcPdbyTCCUzGIknohC0xQXcdKll4XcPT3wZ0zjMT2MfqRw?=
 =?iso-8859-1?Q?sHOvlxUBXpkU/J+oioONs6nANggPVTWEOVEn/z13jFhfEBzTPzTeN1XCqc?=
 =?iso-8859-1?Q?u/SzAZm5tFrzcHyF9hPQPC68gmNzTdeI4PUAjdsmiOGZfDSksv2qFU4EOw?=
 =?iso-8859-1?Q?ZZt3H+I3c98eisxWHfkKR7kkYMzHHXuXrfd48D7YlwV4WO9Q9ymcJn7dz0?=
 =?iso-8859-1?Q?slKiZRhc62jsoUMbNOm0FFL8fGz73ZF2Twfxqwtx9KgENJfqD06d9/g0q9?=
 =?iso-8859-1?Q?TT6Zy0T3yaRjjSnrKRsRxCQ5dCY1onyzmP6ohFGzvsSPx6N54y02wCGbGy?=
 =?iso-8859-1?Q?TYjVDt6XMObGPoOJbs/nJcHB2Vdtx2eoI/4dzh6eC1N565oG/k0nzC92tw?=
 =?iso-8859-1?Q?Aagmxg2Aw5plE3QX0b3gybyMURtyxqxzxXnFK0cK9deQ76g0U6gLJFp1G3?=
 =?iso-8859-1?Q?giZJsZWtnJnYriliAFnJXIK5th0+7DdZs8MPBYylvfyxhG6d4xqnVRQJpv?=
 =?iso-8859-1?Q?T/TIdCGwBYEpEbqRWDYvYXdD+LyxPxFL2v8Y8mdCqcivtOgD0BLFaRD34D?=
 =?iso-8859-1?Q?ULuyJiJTJwBUepvfPzJ65Su3PVJfLNhZoqk+t4vQh3yguhHIpsC0oG/EHN?=
 =?iso-8859-1?Q?G/o3EBb3COB3YMODCalcaGvdDkuDtHa5l+F0p48p8FPUYE/KhOkNrzSLH9?=
 =?iso-8859-1?Q?gX72i498/l7bb3lqrMF9I2YQah8XPn6DqUhYxetcXTyUBRqkLU9PfIUB6r?=
 =?iso-8859-1?Q?gjM4WzlK4hAzcJ9tuItIfR9xVCWO2O2A52RKMN7R/1Zj2jg0gcQZ0HIdnz?=
 =?iso-8859-1?Q?E0GAaYDjxzc9ayP3uJKm/y/DOn6e/w1NYBMi9n85nkXEYrohiIxyNLJ47q?=
 =?iso-8859-1?Q?Om+N652Z5eUeO6BawjfFSsui+uSj5Q30yOyNMHCPQ3bUadJT/NbQBIuyzn?=
 =?iso-8859-1?Q?gO5uT8gYG0sP30e4vXAYAtk9zAO8jltJ2b3W5/abMYuzvCopZoLEJFAoaJ?=
 =?iso-8859-1?Q?9frvVvQTCSjmN7giUxUeomWqjf80jmlQP63rwsqdDkBGvTh41Lhyw6zFFY?=
 =?iso-8859-1?Q?HWtzN1C0toZThIP8iIJAwf/NctubasPDVS6bmicp/7YHGRtZlVJ9IU7dmR?=
 =?iso-8859-1?Q?KBxbfBz+QCu8uke6lNp9iVKSnoEaxh4VmhlA5893pX1tEKQPrjBw7Sefmm?=
 =?iso-8859-1?Q?K3BQacSW2e7aPyK+adHsM1sDG9vtEgIX8VFUzTJ+NOdw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR03MB5239.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(39142699007)(376014)(31052699007)(366016)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HZWrnChKxFJQfEdOJJ8CQn/XXT6/gUfxr+jj1C8S9JtyKAJqbRe6xLrQ6K?=
 =?iso-8859-1?Q?7L18p+STZR3j3ySJkOX+00GnXe0Ph3KwhSgw0+114DJDhxuO80ndwOnPvl?=
 =?iso-8859-1?Q?udDWoBo06W3NG8BrrTcst0N9hEf0kJtk7fkeqXgNeOOBzMwPAqhhqbDjjK?=
 =?iso-8859-1?Q?Dvg9tdNYhJdDM0ReoWOXVZQW+5NwlCn7LdShxOKqleW/BcIB59cOFPkQQU?=
 =?iso-8859-1?Q?gdxYpedHcQkkBTT7CNMAOTH3DAOziTluFLN9MzV/y3DYA3Qdz0veUTz/Nu?=
 =?iso-8859-1?Q?yEitQHuxQuNZdF+M7ZTsZKbrM06b97vgaNM3LyI93275Y7rVi/DtYtbMB8?=
 =?iso-8859-1?Q?BuV0Y3WqMO/+RQM2iUA6Ic2xN8H3ovXcv1GnivFfWOTx31sZgHmkZ+0J4V?=
 =?iso-8859-1?Q?DSM0JyXdSvKUqA1BbzxJTxXDmxk/BJABqDyyRhXR5x8PBEZn7xhD5NWHUQ?=
 =?iso-8859-1?Q?rtz8srUVvOGNc41OwfbeHgC6FnwnCaaDMLabWTrL5OxoXm3RcyKbuq1MA5?=
 =?iso-8859-1?Q?2u7DNkXcv98Dn/Nt1pgqPGwREPEpAqGGGTpxL4tKb2abOXSlVRYTJi1JFY?=
 =?iso-8859-1?Q?ZgeWQTTaGlMCp/LvV/HqhNYZvZpkbv/Ufs8BQlx3Gyz9julnB4BDLyTNvM?=
 =?iso-8859-1?Q?G7ug1gEAoG5NrXdQZBUGlP66Z19DpJLtQoRkS2Pmic1R15TI49wVBcKYAW?=
 =?iso-8859-1?Q?bIe2ig3bG+INaNuUh1BRSiqj8S2SqXGulEmKf5CB03z4Mpy/QPqRQz7o+a?=
 =?iso-8859-1?Q?nnAWbkDR2HGRLSXfkNIW+N7npFm7REf0pt37sF3/BW75oeO4zWYhp3gmP0?=
 =?iso-8859-1?Q?wl1W2AB/nbdNCIjEoQPUohOihYLAjsaMReDXP6W/Fkd6KFHAHxpT+SkJ7v?=
 =?iso-8859-1?Q?FXX7garQaeul4oc7e9D24DhJmh9BEbSAFLZmPUJl3E5JbDB1//WnvIJ6VH?=
 =?iso-8859-1?Q?iE+p80jPjiWFdQwq6SmRkCQZk4RVHa4QdEuSnkgT0zicqgmqa/KBKJ1Ca+?=
 =?iso-8859-1?Q?C9b49MzaZn4lFharZ653IKRpFr6NfdL3QNU7PQotGvahZO+dHr4id/apRB?=
 =?iso-8859-1?Q?dy/jHyyTYYR9MPzHldicTqo+otQISvR7r8kxQ91A2K6tjUQl/0AH8bcfMA?=
 =?iso-8859-1?Q?ClMYq0TxnOGlOPP2iSRCvyWS8mJ49LplruOoiOqasj/CcsBvauVAl7YHCf?=
 =?iso-8859-1?Q?yrv5KaSNq62G+/dFhrEdXIGyonwsZOYlTdb8+JfJedqQYPdPG1C/1pV+WB?=
 =?iso-8859-1?Q?md8hhph8mBpj4JmjoZKgTPpN5WRQev3r17zheZxdw1WzqG/5XeS5pa2Baw?=
 =?iso-8859-1?Q?cd9fw+hTeeLHECgeRQx3+yKHuXAH8E1PgnvXwUJaHhjck2nI7CBQ4D4Px9?=
 =?iso-8859-1?Q?LeOggTrzqRT083dnJDpA1iRAkOPBX8r7vSsVXfhCWYrN0hh8B/Ydc0Jk2F?=
 =?iso-8859-1?Q?0a0WW98xQIzYntSpMzQWTHzIlx5ByjsMZ8e71feCxwFydbJzVpryrsNVSc?=
 =?iso-8859-1?Q?uHhoM4SCTA1DQiB7fPw4ZGHZ/zJ4sZWLKDwITGpnScNEWhkUUOyQi7SuaM?=
 =?iso-8859-1?Q?fF4sEIhongdgT9lHRYv0lPIpw/7OMfRlwk50+q8ODSpptX2F3CXc3KPPpz?=
 =?iso-8859-1?Q?lT5A4PWIto84xkz4B0DXCyUe1Hh4A+dvkW?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR03MB52393A6F0431E012992E9187FC1CACH2PR03MB5239namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5239.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6c3b8a-04c5-4369-b17e-08ddfb0aff9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 01:38:01.3065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c55xtk4lgJmzrrwQues5+mVB7QBvIjwFiOQerwRg8gB1wJpZ8FSqUnjdLyImkhlV36Ff3ozMR3I/iV/OqjwXww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5655
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

--_000_CH2PR03MB52393A6F0431E012992E9187FC1CACH2PR03MB5239namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Tuesday, September 23, 2025 10:12 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>; Xu, Rosen <rosen.xu@alte=
ra.com>
Subject: [RFC PATCH 2/6] net/ipn3ke: drop unsupported per-queue xstats

The ipn3ke driver does not actually report per-queue stats, it always
sets the values to zero, so drop the flag causing auto-generation of
these meaningless xstats.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ipn3ke/ipn3ke_representor.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c
index feb57420c3..c5aca0ea8f 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -2124,7 +2124,6 @@ ipn3ke_rpst_stats_get
         uint16_t port_id =3D 0;
         char *ch;
         int cnt =3D 0;
-       int i =3D 0;
         struct rte_afu_device *afu_dev =3D NULL;
         struct ipn3ke_hw *hw =3D NULL;
         struct ipn3ke_rpst_hw_port_stats hw_stats;
@@ -2200,13 +2199,6 @@ ipn3ke_rpst_stats_get
                 stats->oerrors   =3D hw_stats.eth.tx_discards
                                         + hw_stats.eth.tx_errors;
                 stats->rx_nombuf =3D 0;
-               for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-                       stats->q_ipackets[i] =3D 0;
-                       stats->q_opackets[i] =3D 0;
-                       stats->q_ibytes[i] =3D 0;
-                       stats->q_obytes[i] =3D 0;
-                       stats->q_errors[i] =3D 0;
-               }
         } else {
                 ipn3ke_rpst_read_10g_lineside_stats_registers(hw,
                                                         port_id,
@@ -2931,8 +2923,7 @@ ipn3ke_rpst_init(struct rte_eth_dev *ethdev, void *in=
it_params)
                 return -ENODEV;
         }

-       ethdev->data->dev_flags |=3D RTE_ETH_DEV_REPRESENTOR |
-                                       RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+       ethdev->data->dev_flags |=3D RTE_ETH_DEV_REPRESENTOR;

         rte_spinlock_lock(&ipn3ke_link_notify_list_lk);
         TAILQ_INSERT_TAIL(&ipn3ke_rpst_list, rpst, next);
--
2.48.1

Reviewed-by: Rosen Xu <rosen.xu@altera.com>

--_000_CH2PR03MB52393A6F0431E012992E9187FC1CACH2PR03MB5239namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, September 23, 2025 10:12 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;; Xu, Ro=
sen &lt;rosen.xu@altera.com&gt;<br>
<b>Subject:</b>&nbsp;[RFC PATCH 2/6] net/ipn3ke: drop unsupported per-queue=
 xstats</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">The ipn3ke driver =
does not actually report per-queue stats, it always<br>
sets the values to zero, so drop the flag causing auto-generation of<br>
these meaningless xstats.<br>
<br>
Signed-off-by: Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
---<br>
&nbsp;drivers/net/intel/ipn3ke/ipn3ke_representor.c | 11 +----------<br>
&nbsp;1 file changed, 1 insertion(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c<br>
index feb57420c3..c5aca0ea8f 100644<br>
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
@@ -2124,7 +2124,6 @@ ipn3ke_rpst_stats_get<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t port_id =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *ch;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cnt =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_afu_device *afu=
_dev =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ipn3ke_hw *hw =3D N=
ULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ipn3ke_rpst_hw_port=
_stats hw_stats;<br>
@@ -2200,13 +2199,6 @@ ipn3ke_rpst_stats_get<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors&nbsp;&nbsp; =3D hw_stats.eth.tx_dis=
cards<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; + hw_stats.eth.tx_errors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;rx_nombuf =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ipn3ke_rpst_read_10g_lineside_stats_registers(hw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_id,<br>
@@ -2931,8 +2923,7 @@ ipn3ke_rpst_init(struct rte_eth_dev *ethdev, void *in=
it_params)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethdev-&gt;data-&gt;dev_flags |=3D RT=
E_ETH_DEV_REPRESENTOR |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethdev-&gt;data-&gt;dev_flags |=3D RT=
E_ETH_DEV_REPRESENTOR;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_spinlock_lock(&amp;ipn=
3ke_link_notify_list_lk);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TAILQ_INSERT_TAIL(&amp;ipn=
3ke_rpst_list, rpst, next);<br>
--<br>
2.48.1<br>
<br>
</div>
<div style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
<span style=3D"background-color: rgb(255, 255, 255);">Reviewed-by: Rosen Xu=
 &lt;rosen.xu@altera.com&gt;</span></div>
</body>
</html>

--_000_CH2PR03MB52393A6F0431E012992E9187FC1CACH2PR03MB5239namp_--
