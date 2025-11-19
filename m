Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3ACF3185
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 09:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10B7C4029D;
	Wed, 19 Nov 2025 10:35:36 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
 by mails.dpdk.org (Postfix) with ESMTP id 1B68440265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 10:35:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlV5p4w0SYeNSQa4yorPuwg4ChbtBC87eyOjIvYpxaNkQB1+FeuptyOCfcH/WDt3JmUKfEwuzl2/NP8nEp73MifsByDALZ08CEmUyYgGfTCXHvcBauiZuHpe2mz381/V8oT9cSWnXw6HY5bifS2N6UIvKorVznJpZ06qv86pTJzmbv5+zhFTu0aTXij0vzYuY2m/59hMw6Qr2nPvZh7XEv4FUwAazl7m1SAnOJ549uzeBExmpgt3wf/bB+XQoU4EU5GwChHIU0EOHlvWYD9kB2dpk0ZUoJeq72pB3U4z+rt7sbB1Ih549WDNpzLzjx5AbbaTXk1zWKyBHuWI0zfLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=MtudvW5AK2RauaRJHfsrKTInw9BRij5ks+XpR1rYyO0U4XW3dM9dDE5v/a9i9BZ4Mv9JpKt2jMgY/5ZCKDCxPh+pmBUsZIfuuGIfcpVz1cx7/VRR4xkpDwdBzocQ0f9DWdcu722R6qvhuqYLmcPMbSLGesujBq1J8AMmr6795wVjRgsnFSO2ruKD5u+6dcnjdsx6a/9o7bpJVUMdNTEucP0OgIetvaN2GSva2StEtyTTOAtSDw2ROpxRs1bwPvQRLb9EZUF9OaoZBQKXkHTVJ6xEwixGlfyHl8SskPXufm/Z4rDMCGfSDwOdXlnf32AG2w6pjrAyVYdXqHSW+8IA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=m2BrXjZrvf99xotxms2gU10xde0y/+U1fMzPwPNXKy5EIROuIiWpJhaY3tv5n5PnHfnqgfyzSVuBH122IQxpL8YinHy5/BC6ok4aSRmHjtPM36ZRxz2b+fp3TCLI6zZFw+RkHA4FkrKQSF+RP4PuzHHChU32VzQZhUTEW7nCtlOtYu0+oA3Ub0uC+Vm6jJrnvq6dh3uLg/8wRMIfCXXUqVIlyOipQqhzXC8Sh29QLAcD80UsOfDbfrqQPAn2obtePpg+Rwnhjj3UzkdKxFzTQH1aZriNfQ7w1aawDFMGLrMPSP/pG8NqXrzrmXyA9Xxm8invUYXzPN+rgUiHM3xC0w==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PAWPR04MB11645.eurprd04.prod.outlook.com (2603:10a6:102:50f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:35:33 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:35:33 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime@leroys.fr" <maxime@leroys.fr>, Gagandeep Singh <G.Singh@nxp.com>
Subject: RE: [PATCH] crypto/dpaa2_sec: use bus device name
Thread-Topic: [PATCH] crypto/dpaa2_sec: use bus device name
Thread-Index: AQHcWSt30d9gsID3BUCvZFepEwuzibT5vUVQ
Date: Wed, 19 Nov 2025 09:35:33 +0000
Message-ID: <PAXPR04MB9328FBCEBEE4249B697E674089D7A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251119080633.25507-1-david.marchand@redhat.com>
In-Reply-To: <20251119080633.25507-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|PAWPR04MB11645:EE_
x-ms-office365-filtering-correlation-id: cbedc447-8adf-4a03-8ddc-08de274efccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tzU56TkgwHDv1mc8pyjx7yxPlTNC2aG1HzJeBMsVQ8V3Uj2TSRdNqVIV5PC7?=
 =?us-ascii?Q?1K1kzso8WbjwE4Q11yQ3waG7jrooOFmRBBQtD7Px+cLp+2tbIx05IRefVst8?=
 =?us-ascii?Q?kYaMj88l4cOPtF8IOJMy/usxjojJEx109ZeodgQN6yK+GOn4fc7sqNls5IoW?=
 =?us-ascii?Q?NQbxFzor02QFm4AjUmUPQZtUM2XyRShWNJPoWF8jIXwmTs24P+/4dfZ+mIM7?=
 =?us-ascii?Q?q8i2+vdaNF+EapI8M9JgqCpD/yO9TAdaFIakZW+4smUXlCqu5c308vLWy3tP?=
 =?us-ascii?Q?4rwe0VeqzY/suosqa+llvzrLk+txLhiIHHmwU6P5mRCeb2+vqL5ATI+ypDv3?=
 =?us-ascii?Q?8hasXPRt0dNyMCmA+n3tH6HxkQtCQkUH4meNuZBa26HdDBH1SutMz1IDNA0/?=
 =?us-ascii?Q?4oa6NWXYWel3dT9ODLEpGV84ABFdUjuwReVlOHgvQN9vjbhidonyo2ocjTFm?=
 =?us-ascii?Q?gVU4cSbHD9yIfLArEvwyct2E4BLxNBqpw4V9aXFAOGwCvjB7Sv6aaDajvUJq?=
 =?us-ascii?Q?5RyDi98x/LOSHQNFsPR1VUWUV+axOJTj2l7UgDWmQAyN+Zi0XF8TEcUOiAGh?=
 =?us-ascii?Q?j8VMhKtd9NnKbGFQB02PMxLKvPWlkFyahFsg0ft4+TL3SPP3G7KUTeAYDJcN?=
 =?us-ascii?Q?SrpEVziK6BSDljykO9T6SLYHDx473ujFMK5pyuZOLgLb+u+I263N7Ew6Pidi?=
 =?us-ascii?Q?epgohfdQhX7QA3bPYyzGx8G7mBxUc0WWT44Ppfuw9RDsHOhq/UvsizuTF65W?=
 =?us-ascii?Q?74rk8p3TFZRDiGmhJOFQERs1xink0aHTUsDzoEA1x8NTMEqr9C5mK10Pmw3R?=
 =?us-ascii?Q?D6AhBSlR4xRwXqbHyegIr5DuefeGnO5PBRlhAw8V4nA0PxdUbdMh8JSqXE7X?=
 =?us-ascii?Q?F7NyX560Cyq/aqmaOC3ahV4gRok1Fxla7YPvD70LmkznziTgtVFj9m0ks0aT?=
 =?us-ascii?Q?svOFR7PmfRH56nzm1CXnwrtOEkTcMB1Nh5IXFaRD9kXsuVC2v/Se+Xo6vrh9?=
 =?us-ascii?Q?/0XULYyi01Bjj0cOJJU4X8E2/nq99QO9n95+j9TE1EzMgqBZz+aFdQpxhSYt?=
 =?us-ascii?Q?VtZ4qCW+c1VDexhwilURKKMg8CSspHBNAyLs5nvmXwPYprJ/yAsPF9BfMH7j?=
 =?us-ascii?Q?9TsIa+KSR6+m/zdcisEHr+wFHFkq/SgZogqYAHuGhNSnxc4BDa2OsWixTQVz?=
 =?us-ascii?Q?UAi7Q9znRQozbgAvjqKHjnamdrEQlvouCZDPKD3PslunvU1fJ3um+tcH/FQd?=
 =?us-ascii?Q?66SnzjkOKNJVBoirQ4o5vGGBjhWJOmCZoaiH9C8cR6hoErr5+ctrxGeWv9uk?=
 =?us-ascii?Q?wslnFLYvHaZiDCAtY8dKREFL3QjQOiaraud6jPWGoad1Pj5jVgUWKxIsgaDa?=
 =?us-ascii?Q?Qym3MQBu/Zz/WMWkeCf56NQVWi+BAdPC1lpnweTmUHqNud3aaS4pDtI16SKj?=
 =?us-ascii?Q?7csNdr356IjbFtOupOxyPmbcp1J82B1JEUJA52sxXV//6CG5UE+pkOuz6Qdz?=
 =?us-ascii?Q?CZSUgoT+rdV7GcfyCcBx+M7J5CgQbFbugwA+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rqpbMzjmB34q3i/UtLdocu/jGm4FvDM7bEz9ZzncMmZuMdLIp100bPzF8emA?=
 =?us-ascii?Q?b9hNeY/66XqlswEZiAhE+yh4A4YrW082/De/CaVx0ob6OBoF+dxClowrHApP?=
 =?us-ascii?Q?bLT5EOND1xal8sA5qcsZMj+OxlX7K6U9DwpbMmON5wZ/Cls7DO2dEfVFKu87?=
 =?us-ascii?Q?nXpRVcByIQLDJxavTdcwH8N1tgjMYs4wU+4/rizMhET2bMbrTxDzF2dJwMb8?=
 =?us-ascii?Q?5eY6fhNe17OhwynB/s/ymuD8ndFSf4qSiU1amWFIJPKAX8CElYTD4zPQ3aJD?=
 =?us-ascii?Q?rHWrmX/K+cLeB36e7nJdRyWD1i7FmeuyBtia3eE6Br0317dAwQo0ISb7/emD?=
 =?us-ascii?Q?WHiBtRQt4Z2MHqhHmVgBwaBMsRJGSM/jQg8C99J7u0SgG7/+M2s1Q9fneNQn?=
 =?us-ascii?Q?J0/4EUEfqY/0lxKitSwoZL/93Iq7PFnFpFR0xlwcX9FkZ6sbfj7Msms1pRlE?=
 =?us-ascii?Q?WC5usILk0fW3ZfJNfobKh9xnIxKTzKqcN6jnDfMmVxMaiSxEeQl76zW+KtYu?=
 =?us-ascii?Q?SmkqpgApue9+pCHRdGID5vr+LQAZX4U7hJ/hMTuhYZbR7JN5H2BYQHg1Mzqt?=
 =?us-ascii?Q?5B7cd597Xm0KSQp+c7ONGfMUtB5vTuDbU4CQ1Wm2FxXNIxG9SID9+WY0B1yq?=
 =?us-ascii?Q?2Wa9DkhFfVR1J53C6VdYFVIhAB6ihyBNfLwVmqr4L8Nr6B6Jq2nM90+uTJC/?=
 =?us-ascii?Q?hki025K3Ow7ymvFahClYOkWVnzd8z7EClvsYdtU20XHc11sQZRhW+HVHQg9Q?=
 =?us-ascii?Q?2Whtkq4x1o3RyZ8JyopWFLTMHD5/2xH8eGzSVelfu8IunD1Xrf+uuq0fs6nA?=
 =?us-ascii?Q?JvUv9pODEBsVGQ589GY9WeACrwwyHBvc3Ns54JC6Kp0ZxFd7zojwXueCqyCD?=
 =?us-ascii?Q?I6GAmksgdXnLeZSqtRLRJ2zILYeX+1xdPh62qlIoPBt4LE1v7k3h3iQywQk2?=
 =?us-ascii?Q?4jsrIRyh26ClTZzDcLpq4xKhzX71BJaZx/cQsRH3GMCIXB/T9BzkyrAHQwVt?=
 =?us-ascii?Q?JtGBD/0PjmWAl5cNobDqfeH3RrmO/hTI3Ze5g0oJgEXAoEZQvEri/5LV387o?=
 =?us-ascii?Q?Pz3+Vewe6YkzRJ6Su5aPLO6d9GEGeMn3Qi6VeELcxk6AVQjaTHpJTlSAyr8G?=
 =?us-ascii?Q?8wHLcCChpMlRxREPp1m2sdEOLnGHZu8lYJnWdzRdJ/BVG9OZrDEi1A6m3ioo?=
 =?us-ascii?Q?nBSpYIlg0OBDYIVf8QcTmghSJc94xTTSm4lKLMDpyiUBlnlO83a3pTJMUd0/?=
 =?us-ascii?Q?TRC+V9O+t0DQ8Ra1Ze/dSv15qaYu0Opf9rW1FetgZY7RMOqBFgy6eAu539uQ?=
 =?us-ascii?Q?Fe22WmxkCxuTmRkvdAMFNhYtK7gBNuhTPLSOxUdXF8i7s3ECIWPPT9Kyskl7?=
 =?us-ascii?Q?FhxEbZzgOqlhCDf9HWcVuYY0hmeCpfTLERzwphPxzg3+DTHSuXSWTkGev+M9?=
 =?us-ascii?Q?4Kz5SpB7qAl70f2hseeJhUn5SIf3Y+sppveHUPEYPKqGk+UPKb8E1HeIZkdM?=
 =?us-ascii?Q?sy9lo0ppTXustBAEmpjCDMzoaxxHV9vFGr8wqs8yVEQMClLI0+HkqVZIWHNV?=
 =?us-ascii?Q?FXIjMIEHo0xS/YR1axwhZSZFfc+ypWuwTNmEu4au?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbedc447-8adf-4a03-8ddc-08de274efccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 09:35:33.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez61DhsT21gr0YtCQ6XQDE/77jYQHfk1bZRaVnN0pA6HpzIARvaXt0Bxnhue+6t2lWCwCa95JD4ecwBTvxQx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11645
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
