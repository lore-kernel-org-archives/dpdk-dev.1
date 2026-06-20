Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70ACD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D55C440290;
	Sat, 20 Jun 2026 20:18:05 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8290D40151;
 Sat, 20 Jun 2026 20:18:04 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KI8TWv1224927; Sat, 20 Jun 2026 11:18:03 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020107.outbound.protection.outlook.com [52.101.201.107])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ew8yfkc3r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYup4mIvzDEDpdJMTfoS3KyfU4YlA+HapItYGiCO2ZZ7FaPIKwQCUuDoPc8J6cjZS88UVE4Q9lJ4fsUYx2ua5zhouO9AzGmsRvWgSGK0T6vQAXXgx49ec2qpBpvhrI5YJ8uRvOU48AMMLlj+1i+rXFannqc27NLjXlC5Gksc2T8zw+iV0u3SiX3O7XVleGBf7JFQhHM3AmoqKv3DCrV/ypQushmms5y9XHBuO3FqY6UrlFdPW2NEsFT+lnA0KTNgBzB6TkOFLarrjVSI/ST76ylrpNJRl/BT4IgGPVrn7uC7ucED5C+RI70gh4QFss7N+zRvvSd4biGmLHk6GPP1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMmRuYSSL5o70kIPfptQnnQAlVJesjfK+ixtd9xz07s=;
 b=fjDMYnNAcKP0+2zmgpB+wckUicd/B0vieQoxzCDSySSmPBjIlzx3F0oy38GcnxAUbQar7haYWuNh9V4bCULBoSxDzrDuebQqPjm3K0A7ytNRM7woMhvVtgKUSbTIIBjz+Fm/FyXicsS6PNSntbzb1CIKL29CTT1IDG+9MKum4rZ3d5tY/t6DFKTdiD2yuFfOGwckQMrWJIN1Imexx1Ko342xAGRsZnxzGgbT9vAtezr51iKRRvggDPrJyo70sqO46g91BLr3YrSvr4pZ+4L79uXmbEqb5eTtqk9de/l13e9wqNsoLfEdUiP6Nif15b4eRw0lHXjMvuwfokZwM6KJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMmRuYSSL5o70kIPfptQnnQAlVJesjfK+ixtd9xz07s=;
 b=sKA/oES/ctX18R+uZv7KpQKNbYWEctNczoDzCGSl983vTcgYnJNRLHOxn2SbjZYmND0z4hP155k168TKxrG40TpDgfNUebIh26ys9dDwTwZcsoN0QFqTXW3uxhcA+QN8lVvEEeLoiFMPavsynIEjRe6WO6PFXsrxLE3cdkX6LfI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Sat, 20 Jun 2026 18:18:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:18:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 1/2] test/crypto: validate ML crypto keys
Thread-Topic: [PATCH 1/2] test/crypto: validate ML crypto keys
Thread-Index: AQHc7bZI7941/FJVZ0yUZp4HRgp1ZLZH5q5A
Date: Sat, 20 Jun 2026 18:17:59 +0000
Message-ID: <CO6PR18MB4484973BEB36907F0D428335D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260527085257.1933-1-gmuthukrishn@marvell.com>
In-Reply-To: <20260527085257.1933-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO1PR18MB4666:EE_
x-ms-office365-filtering-correlation-id: d9b9a8d6-a876-4147-4320-08decef842b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|56012099006|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: W2JY/MPrRjFDjovinTcBY8WBd+833qMUrchPfu84J7AE6F/Fj8pBQ3vRR/KT5xBCrCMI/G8PwDXJD+YYzxxLP+oBywvbbgdifgHfylh4Lc8TjsKYf3cceN9COffAfYF1qIFMgbbRfeMy1P9cgUSjTutiZwneDCJZKTldRCaglfZp++oUq5DK3i5/l2VyaBxffmubAzztlOXn9LsdM/a4upHCg079y5hOsDrrk3H3aqpEkLLrbvfPDpuc1YsmpZJnBhaILT5cnON/OmCwcJAogzR/PUeIB5kR1Mw52QhKBL4z7CIha7WJYUh0vOPyqGf4POUd06xJ4cfpQ4PezasRbv6wDFdXAviIumtn/NwbK+ymmFZNwdiVZDaE7voT4RDbK4mMNgZOJsm/OFLBSmtvs52u6bbzC7mvPKgQMrafnXS9TKLErfX23kv/XJoso3Wd+542dFoIN3MJF5mGhorqBaLMYD9O3gbyB5DhV75hJXWeIEzK47f53tzZbJajg4shp6CxCq7fq1y0haOSdAAA3Tl4qhjX7pSHdSgKHGH24DqUxQYY5gJoMj+HhtKlH5Ov1LF39Vjyct+9OQiesQYHne6DganNJFpvFENNbrn67Gsw3DIc+w8Tdn/1WqB77OFn7GRW61y5aEkWVrMmc8WZuSnCcFIa0qMQ7XhxeKgkrr5DIl7JGKx9QWYNXBIs+v1KzstOsmIhdTHklQrg0K6Oow2EyW1QTZR5gRyk+Sl9l/E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(56012099006)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7p6JAa6ObHLbz+DJDc+rxvNze+v7kVBcWf23Hu2uE6ZkdQvjidQXfdSMdpB2?=
 =?us-ascii?Q?EhN6gROuc+QoSqy/eiv5jm+thFO9xU3mFiAajkmB0Xv1Xx7cIkYOkZE7Hu2l?=
 =?us-ascii?Q?iDTw/OrlbIdRDDU4Wd+Sld2keJhXpDN6N+67mMCzrTJTrLoc+GeazeAW1ude?=
 =?us-ascii?Q?1ye6Uy17Dt9A6Hco8dGB6PfwU+aR2Um/B1qw9H7BOKEfYRUwE4bWlLMFTbib?=
 =?us-ascii?Q?1UWq4Xo8ZCPiVLBBnjsSAvZiLIAsF0JXJxGWoZmf2j4BCLKDErkp4KkCq1RZ?=
 =?us-ascii?Q?JjZg+QdL5oErTsJDMnjGGqyLlhUfrVHOmTqVDQIOJDt0II8+37YCtABKjQgD?=
 =?us-ascii?Q?qW3tZhqid8OuZjvXZtrtJgc8QUXiSRcFRcQ50yzPXrcOo/ObxOszQkLN4UXs?=
 =?us-ascii?Q?q962uNU2TuYr0Rq5COy1nCI+pv05poYcv4FRiuzd1XS9DFqdBJ7pAwv4aLYI?=
 =?us-ascii?Q?ILq/oKkv1oU7zWfGbHAX0fmxdReXYzQqkZ27NmGbCwdOkOqE3pU2VfblrXSL?=
 =?us-ascii?Q?MLmww79jt9N2QeCEKT1GtpZoTPixlbCow3zKluVIdCtqrosxLUYXaU5gmRDZ?=
 =?us-ascii?Q?zbBvEWPONT8vfHlT9ZFPZl5icgrWGHWQ1tSCrYECJLlIii3HFYFyGG1hcA6O?=
 =?us-ascii?Q?wlCD4DLHkRx7DB9BVmVMrK+t+5C4nk+bGhYIWUHFUu+YVZt7huiou/8e95qH?=
 =?us-ascii?Q?nPhMdLfqzLsBiW1DwvyRDx62v/vw/i+6sRKrXOM6lHCXVie7DGrhG2cTCmM0?=
 =?us-ascii?Q?BIvgqqJvw5jRkKpDkczPxDDxLDRu8GYm/dgkgYKsgUcmyESj5qZwLGO7NGnR?=
 =?us-ascii?Q?YggoSEelnqGWHqGIUZGIZRhBCT/XLEWT8Mtq1GelTrWCMeCq6mP9lrE9Wz5U?=
 =?us-ascii?Q?24irY0aZNX6xs1hjaFlw8d4r7/2qYJ/RGnehurUVA5L2O6EPsMZ+sSnItcYh?=
 =?us-ascii?Q?4F3VSNBc2n/QY+Ecy0KrpFVcJI2uXVLC5xUeQdo4uOTdbFSTRd99Jka1CBvt?=
 =?us-ascii?Q?wuRiGgJJ6gHPFSCg8oepYYZm1sewDZikRfbnyt93o2wGX5emryfh9myc49W5?=
 =?us-ascii?Q?TvBAOYwKWaJdCt342oiQq2oThYtDAyD0pouQB86oa0TEdTc3x33vk9DfK2VH?=
 =?us-ascii?Q?Yz0PQ8260bV6mY0rGGB4gXCnVtH3dAZL+R2cBbenMVNQHZ4E1BFsFxFw0aM2?=
 =?us-ascii?Q?Le9LuRZ/HE0LYAofAIub0WuussE1LEs9rVR+BThwPOkajxEI4JYxTN9RH3HE?=
 =?us-ascii?Q?z1Owh1W9hRSY6GwuAdoRrJPITugsVzb2tnL+iyGRw4A6kuGqxlacMup7Ym5T?=
 =?us-ascii?Q?F3Abuag26OLYSxso0cNAkxuPC9ueE23ROmGTwxgK8TPsK4GLwo2wccZGCwF5?=
 =?us-ascii?Q?Mugkfst5FrNtQABIaQSNLgJK+iRkzcMMP5aomaDm5dvuFwy51iS3/GPQcdhb?=
 =?us-ascii?Q?QNPp2aTCUkitNLTrMcNPOxdHyamgA7C8L4peegmbqFF1jT1laUzGtadz2Swx?=
 =?us-ascii?Q?5aJafwu8L2ZxRhYWihGiVBs7E3UK29Zj1yaaX5Io1zlKEV4uJir0RL5vd84T?=
 =?us-ascii?Q?WhGLZpWZFqAzkgsIP4mAAJ3UoldXvTV/EMpUFYp9BGMjPZrqAw7K0cgsPvEo?=
 =?us-ascii?Q?uqf5t1KqEhDuz+9TGPx3ZMNFlTkF7T3VboFEsCiCM2/UlcmZp6XFAuAngvpI?=
 =?us-ascii?Q?/t9JIWcnvkI9ply14U7Isy9mpL6OZmNUkhJf/4x0jwkN7ri9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aSnC+I4w3YvsYbuWGdn6sdFy+HsJVT3yS4fNslWhFdFSKIAmR5ELQff+r3TRaQI3EIKp37G+//JjaGyeOrC+EYJHGQw3LY30o6ugShCSkq3z5QVrBoX8gj+WHUYZQL2Y9+x9h6cOUmQ1730E7XOaocxmYoALUW98ZkKA+ak1/FyrV9OMb4yxYgSlKPhT4xuPyEiV4bpHd5c7C2gVRAB+LUA7KVQx1noGkcXs7b5Isp8aze+VmKm2dHEc+zfhSe7S0CP8l2g79iqb33aSNt+riRe+Wf3GAwcZMe3hzubme6HFeLiYwhqJV7lZgx2oHZXXuwNtX0DQyS+U8Rrhdl+peA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9a8d6-a876-4147-4320-08decef842b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:17:59.9338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZwVJDzu6WVPIgk30evt9DmZn+Ii7RtuZ8SiA4AHJ5q0hYyJry29nqSOsZ4K6T/zk8O3NTmG5godpR3LOpBa0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4666
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE4NiBTYWx0ZWRfXwex+IMtLlOgf
 7XjNeY59yx+hysExSdZPn3knRhIAhTOAjy1nv0wgUX1qFflTQGMdeC1OHmrNEv12agQYmgb2OkF
 H+sYH9Yu61fgz0L5jjp0hblXiOUl2hU=
X-Proofpoint-GUID: B91BzaXNeWfj0vh3JCjjY7wjrPCQqweP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE4NiBTYWx0ZWRfXzlhjqb7lOVu9
 80tgyMU4hlxJ4M1Fk2cler7qRdruANbJN8iZZSKvTwoICWdsJaXt6ueC6K9cKXcVafvNe3snt+f
 50s47ICz4Kk8YCCYHlI1E3PCSAbgTKh+961TJPRefbjUczCOsdYEAZ1fJdhgS6Y+wnmPj+/LeKm
 VEh9CW1H9fUnjW5nMzoSqK0MGV4IzOpv9mO9hIcFl/ZV+XkI/BrvryHoSvnJrX3rBpILARP2Odo
 7xisFXb+S9NRHkGXaOiw0FKPe8ZNggwWYguoCI9H55SxhYrN/hfsnXeK3+HICp2vz/E2rn8ix6x
 qPzPY4YlvcXMx1eMoM7ruePgAAdFdvtkOCmroETLuXrqdbeV6SPcDwuUMqTI/KRcL6ZXLETbYVc
 ytchynJzGi0uw4CWB3FKDnX7AhLdIIL/ou2Ke7fR6LNtsYW/bQsvejI/TXLHyu9Yl/rh/FQ1neI
 4cwer4iL172fmEb6muw==
X-Proofpoint-ORIG-GUID: B91BzaXNeWfj0vh3JCjjY7wjrPCQqweP
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a36d95b cx=c_pps
 a=hXZiUtiVoVCKrsLoS6Demw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=O7nmYSS8aj-IHI7UogYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Wednesday, May 27, 2026 2:23 PM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Fan Zhang
> <fanzhang.oss@gmail.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>
> Cc: stable@dpdk.org
> Subject: [PATCH 1/2] test/crypto: validate ML crypto keys
>=20
> Validate ML-KEM and ML-DSA keys.
>=20
> Fixes: 76a5877072c ("test/crypto: add ML-KEM and ML-DSA cases")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto

