Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC75CCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 05:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8027D410E4;
	Fri, 17 Oct 2025 07:14:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6C10D40DD7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 07:14:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYsl/OqRwog53xR5Lb2KZkuR/K6IKZwISw0OalYLN6Kzz5qClRuEKkMwM4Zl+aaHV2LHaM8sgtSl2TcfGJec48irr3eZStfjajb0D6J8WOe56thiei2B4/fJXTUASCX7X7nCNnAysHacavwMrdhAoTgPBgK9vYvKMiWZCTQxAwgA4IwPwhUxa5+uXqggHe2LBh78VPABOBxYmHQDGW+n3txOi3PPUNQa8RJES1Y/Jt8m4bdG5gV21holrG96SR9ey5tfDNy7O2+PZNwMsazbcOT4ZttNjLPtCU1QG/rNeIIv/Wbx1zJBA4Do1zU3UMtzqDi0stV+neAWwwg/WSV5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=NrPEy85tENQGAy6nkTeeBdsNohuiTmyl/RkzbXZdcUoMw84l9x0E2KVgzSXixh/0O/mZduWD7p/wf8qGTuWCC7CI3Mb7wDgr5MgqqQ40AkGfPDaX9Kwnf4JszOEIeCzU1VxJFHqC8Hnd7ec8y+3UqvJT6zDQhiEMJ49vgexcyk+K3v54Mfu3xTLPnNj3ppXRK/iSYHMvjReuAFfq1KOYCh1ydh68ORTw/Rqlm3v0BTxqjR5o1entI+sHAcUkvDB1ak+PP7B+/1Ub3I4j35VJO53NVsv8zYr8Np9c5XJcAGfPp+xHqbmY+71DZPfYO4WVzM76mslNBr/v5yzxYYEwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=fOy9JEiHrwA6lt0U7C8061c7gVPGjWExxxvLyWZJ+TF0AylSMaUo38Up3PhPn0ZAqbvZUpvxgkI4xD3Wi9jIRF41WOHQ+1s6DGgSvHyASHy0x8bF+j0oxgkq/632wUhmMQvc+X5YxXMLBXkRgOkkwVVUO0Rmpe/tffIpG02crAt/Zqkkk+XoaHgeZ7WebtDlVaNNA24WnMJulzSqiqQb6EDkAh9hq7yOSiHTPbMl7dBTZ8jc+lBxPRP97sXDN/3zZcsxq83XHV73340nTdTSNyk/pJh6B0FDID2JZ8M1g3zA82B+AHj4apUTK5IxNbanAOM+RgQ+TvBs8dEyPfwVuA==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 17 Oct
 2025 05:14:33 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 05:14:33 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH v2 3/3] net/dpaa2: make total_rx_descriptors static
Thread-Topic: [PATCH v2 3/3] net/dpaa2: make total_rx_descriptors static
Thread-Index: AQHcPumj6h6R5hKQYEGTltlKpdzuvbTFy8cQ
Date: Fri, 17 Oct 2025 05:14:33 +0000
Message-ID: <PAXPR04MB932831AC13B5E87BF01FCAEE89F6A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251016220959.15671-1-stephen@networkplumber.org>
 <20251016220959.15671-4-stephen@networkplumber.org>
In-Reply-To: <20251016220959.15671-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|DBAPR04MB7301:EE_
x-ms-office365-filtering-correlation-id: 01cb5a60-c695-450e-7bf6-08de0d3c0f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Puoudqrk1xe3tsRnwPfabrjD49X1evannpNTCrMxW2CCiSFdLG0iWeGXSZJ5?=
 =?us-ascii?Q?/9/bgzHGr28KiYwDwbbDHn9iS0Qm6Yt6H6lIBlqc4mH2e3dujm2ohxLCTwXj?=
 =?us-ascii?Q?UdMkZ5xOePrwZjiR4OpyNnJJV5bN1xPk1956LT02OD4PSH/StTMCyWlAqB/p?=
 =?us-ascii?Q?9SEhJyZs8cUv5VHTKTsnPReKct9J2dMDd3j4VqOkG26PIr13TKVDYn8I0/v2?=
 =?us-ascii?Q?Zm0WnTmsfX+WNHytymok/ftOfi+m0tdoJuSUAU7hqDnuEVSQ6OvD31UUzZ8l?=
 =?us-ascii?Q?iX9GzPGogEyOWojuKVs1k16RWKwkLCxR97qLYqPsv1TmEnA1iI/UMxAGwVh/?=
 =?us-ascii?Q?dDatgVPH2DB1pE7ndHoTIRICKPgx8jt8TLtdtXlu0ZAqnya/L/F3OFIHNQ7y?=
 =?us-ascii?Q?a9et2a+P1ElMZ6vC/rn12YxFfdGzahX0/JtFhbHuGwS+/kwQ8uHTgHw2qk/t?=
 =?us-ascii?Q?cRV/aF8LR+x1WO5ueRUA+9WuxaGf4AMmUQRDhTuOcdz7gQrcs0g97M9Jnhzn?=
 =?us-ascii?Q?lat+hntVNPmkNwWm1txmy9EvnzBXsIoqAUiURPuuV/ms9DDLfmngkevLV2Ju?=
 =?us-ascii?Q?zYayauPKZZ+v+bIiN9kge001L33JewyNnj4hJWuHKDAKpGGwqSQykGjbb4JX?=
 =?us-ascii?Q?Y8WeNxNq0v5zZMO2v6IPmcrhrphRs+5uHmXpOrHgRdm4tn+amOICuKI+j+/E?=
 =?us-ascii?Q?CKdb9LsOQPcKXRlgUuLEFa5w2Ielv90/b7Gy1glV+mdSPmK7JeiyD0bqozm9?=
 =?us-ascii?Q?TomqdfLNAblPYbeEL2So8Ja2efEpG6fkxXF2s3yCXwF/5m4xxXwySZNn9WiT?=
 =?us-ascii?Q?x4PkNiE3QxSrfoP2YNFTGcJb3yJED45OKJxGI/7LrtmpfMft2MdPkGJUZnIg?=
 =?us-ascii?Q?bQUqW2svwp6uVxEYV6z06ZCuzZQJAspNoFzN9wr3EOe5rUgI0KHXPy22Hurf?=
 =?us-ascii?Q?AH+Ee4Bu9qB1VMdVUxyfC88LMmCLLi0mvW7no4uES6PGHxKCrVIdY9y7a1Gz?=
 =?us-ascii?Q?wtvS01qYP3XewkXMBbcdYVR8iSKq2DX/wLKuGI3CjQ91TExS8BkpczSpscD1?=
 =?us-ascii?Q?X8DrI9WCiYXULz2icfdmsFgpdh2i+drqfGUkrYHZ0zqX6cP2RjIT186UBcLs?=
 =?us-ascii?Q?baT4ZRt19SJBXaIzBAumngR4Msw79WJKN+fyEddxcF/JGLZeSu3/7LRDnXOG?=
 =?us-ascii?Q?HhXi1oZNtTSwC227ccKGCzULd4qco8qSWVQJ9LPAwsU0aCxZfsaG+semoid5?=
 =?us-ascii?Q?rcbP7kLnDjTIM74f2qcW464Jen2DYDh8oyJXm4XQ9ATlvK8LFLyYfJb9nU1S?=
 =?us-ascii?Q?1EJ+yCTA+iR6W1wxxhQMx+fwP7AD37v0OGFUtCS6g2pwx0mpHaHaeB3HRZdn?=
 =?us-ascii?Q?cgNcfftAkUx60nZbOVX3pjdAkzTm9o1zf+dnzFFIeT7RO8F/LkknwK+45i1t?=
 =?us-ascii?Q?94sC7soF43ldiL73Zgxu2btsbN2apUvfVb4HmC38G09A/5Y0P7XtrKRVS5g6?=
 =?us-ascii?Q?xolfnUKKRW1cuS+tpMidjQrvshDCS5oJqOnV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P1jjX884x83Iy7lGLTCLsi5nEwnD5Faprj4xT3NNJv0ygrzBftncQdfB+RuQ?=
 =?us-ascii?Q?YsX7/sW6hudE5AR3NQsTBYZsr8csU5kv24C2ncExFQScWvsfF2tsDQRsSRnh?=
 =?us-ascii?Q?mpCOZUrBhy/DGqJQ13kM8iqxHS+abPrtePbLpyIDxBZl/sSldF8gMKzJDgAP?=
 =?us-ascii?Q?JOwLWj/4vSpa7XUwUclYsqisY7iOoMXLBhwKL5HdWzH5hNYXhwx60N8qE4QO?=
 =?us-ascii?Q?CxdXl94DcM4ZglQjMwG8AwYwcgaokAG8DHq1MDwldpTqWUMcajwEADIrOIRq?=
 =?us-ascii?Q?xzktL5Tvo5mem/rt3K8y4zgb1xkZ5mkPrZcChUVItCpx4dMk7ys7+1xYySZh?=
 =?us-ascii?Q?OQnZsUsmn0UUonOMy6/XnDvMnIRtQMSiJ1w1nlghdSmOLwPU9kr+fsv1Hg0L?=
 =?us-ascii?Q?t4LEGiTDZrBYjOzTiGS5qXFiPIPEgl6nDKmrSq7JM1u420Es3Lg8nGcVA281?=
 =?us-ascii?Q?VuopgkiXoeJ9gmG9ut8DLCPRTQ0d+qmcCq/uz8kv3O8M39xMb4FEyDgebW5B?=
 =?us-ascii?Q?0fhRkngfQKK00B0cm8GM0N3z8SyL6SCFRJu7ekt7BCHUWe6Som9pqZDmXaVo?=
 =?us-ascii?Q?aL4k+HUDgdYJCCS/pRPd8bny0mbGFx6pA2dwsnOWbR9VRf+tzOQQLMvGcNv0?=
 =?us-ascii?Q?mbGRiScwOXvASqpgobftr/QG/ej3LdMmGQcQF79Af47dA/8rPZlkniwQnFU/?=
 =?us-ascii?Q?8FaFp/i3D+VNJ+xYYj1HV3fQXgjBiYY+bAQY+DxJG0qHqwMfJX3w/0QIlwiY?=
 =?us-ascii?Q?MsmFAV5Pi608v+xFTvJemNPpSBof/H1Za0bEcoMsq+6eM/v1kEBBZmaXQAW5?=
 =?us-ascii?Q?ED3Qrta0pXZgyRohRb14biGkkDQ4FDs51gkmxvZFUe5xNda09dWHUYxWFX8X?=
 =?us-ascii?Q?5Cn+4us2OtqUzEDoMq6Gom1vYNOGHSgs7B1/FLimNQKqUAh/S85w3/e1SoZh?=
 =?us-ascii?Q?j8ZMcfuNAwaKRkUuk8Hc7pCP/tpv89HB8D52zITXbd4XurPudE0QxRXylkfV?=
 =?us-ascii?Q?/aeqoc3MhsVeJic93eayR99nTFvGhZcHO/hgUOEjPu3pg8tQVia/dcJgEWpy?=
 =?us-ascii?Q?g4eYzpbHezL0HbnQI2/7VjIYf2/dmJKTXrQ7opC5rcBnUL1SvhBsaKA0FrPg?=
 =?us-ascii?Q?4dy1WseUuN5zy2b+6BysT38/6Lbbxmw/oZ+pP0OGVvTUyZXddYBau5qN+3U6?=
 =?us-ascii?Q?TdheqX+JYcH+10vqaCwJ6PeNgFcqZAPi/E1z7T+KIXb7zYR0KfWdowl+GjKI?=
 =?us-ascii?Q?/vQ/oqf75wfqpNHKUHYzQcKQW23i9gALBLGANXtASIv2s9Y1anuMA0I9QLaJ?=
 =?us-ascii?Q?GXrSgQ38/tyIzT28+GWpeuwAswSgnSGNFQVxQypFB33BZ2XTO8WiGkcMVT3F?=
 =?us-ascii?Q?2jrn7buPFpUw52v3MnojXLG2XMC6KN5Ia3L0xjkHj9V2r4BjG7qmrfqa+uZB?=
 =?us-ascii?Q?UOE1MqP9bTKeWVyeMnwcr8l1VHZUmy+RSLzoH7HGEi/hnU2nf/wQPdojHdJ8?=
 =?us-ascii?Q?A3IO7J/qtx3MVu2QEz7zNhtVJblQeN4Jius6Lw2y2RQi1RT6iUjk85enUY7M?=
 =?us-ascii?Q?CheESt9O1We9NYPNcLIkVmLr7e0w7+VTB1v2plie?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cb5a60-c695-450e-7bf6-08de0d3c0f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 05:14:33.4652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2qSRB05U2L5t7aXm7lU3Th2Mpruvax6/D5/mW46JEiybyC+gATT7WbgZ2pjkiapQFszdcZ7GPxCpIDbBxjqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
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
