Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47CC8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB6B402E3;
	Tue,  1 Jul 2025 13:42:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
 by mails.dpdk.org (Postfix) with ESMTP id A83B8400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:42:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfnbYeT6R/4CAl4zujzQMe/3UcTPyF5BjA8O+lNokvS5fY9EYCYjrNwG7pg9/wGLHYtG+Tld9/gnwJwEZx2vRUr/+BALwBmHxfSw/jGCKuMfqq5nWIb9MtSKyn6ZTg0LYawKg8Vy44yHnIqYBgVhaGvJ4q/2LOjWmfUUQWHAtytUAhgoBd8dH68ZDCVDarwgvaZYRlvEagrsYgDHV0Vw4dNrHLk1QUFCLixznvUpzLhV6ja4F+SmoYOAyuurSUYWze8QL9QFCBk1CSGST1MnUqRUgQhHUSPbezbpqN63hnjsuMLHNdcGZn0qevYJRhc9yLaJ/hS2tMMOGkBCvdKhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPBZzo5w9GCcJm9ZxKWfoWZWX0UZXOFdQceV1EiIOds=;
 b=pmJc9Fp7YNqXSukH/BnEDI9VhGaSMOuJOLTUoL2ngTQY5qwLKOCgQk3L41QZdPyLGWLwbCG/GVAsmzjvIMiIAyewsCjo8yeAiYP/8szYs3kyhaM8n+4oggNi0edl0haL6uCpSOTT4nUfPnTPVr7VdXBzUDPJcek10qltDf5xlW2Z8QkVHHI01pdrJ9Llteds5oRb9BLzsLRzgqynLwLaFSYPs4e+LK3BbIjeeIU7JhJ7AfA/Fm7edWnnRcE7uDNL9d2t5+Z7oVe31zS8N6BEwWIih5SXOa52U5ZoYDUUwW+M8Ltjnujkwz7NEJ9qdmIcniTYmsLuaN5IkPyB0pKMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPBZzo5w9GCcJm9ZxKWfoWZWX0UZXOFdQceV1EiIOds=;
 b=UaekEKbCOs1Am0lTun/Z21OIKNumfZ5RwwbMoXvqA2eschpdlDCsmmv8ioH8cquPKT9I9nNI/A1lvIPVsVJc/yM7UikDF1FnydQdQDgcGvqa0yXk7CX8wj26Yphkrvwg2loULRRjz/GPMvJnNhDOEtNTobpKMRW490aV3UtX0ZuHktQe8HEk++JDVaG5jBQ6lf/chUjaxylVk3RgqDABt/xrzU0eQS6d+rU8An9sqcrnbU2gcNAn/rni3frZ16eYF02y43njzB0jLob4d+G/iDKBbxtnXBoVz4/7tknT18ecQSgXM/xi77+LpJ3ePdJ69NrrtpAa0M31qPDtpz2MGw==
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 11:42:10 +0000
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a]) by AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a%7]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 11:42:10 +0000
From: Vanshika Shukla <vanshika.shukla@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: RE: [EXT] Re: [v4 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Topic: [EXT] Re: [v4 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Index: AQHb2p/1kJHCIlb2DUyu3sW795Z1NLQadHgAgALPvNA=
Date: Tue, 1 Jul 2025 11:42:10 +0000
Message-ID: <AS8PR04MB89793B130FC03500D560F9B5F441A@AS8PR04MB8979.eurprd04.prod.outlook.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-8-vanshika.shukla@nxp.com>
 <20250629094254.450724d5@hermes.local>
In-Reply-To: <20250629094254.450724d5@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8979:EE_|AM7PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: 4d46110c-d7fe-4135-737b-08ddb8945090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?O/WBgSTcIzBPXwJdtsCZkafhxvwk6mWfOGAmZKjYMbmhfePlsGypqLmVnhtx?=
 =?us-ascii?Q?/UGSyRKpJks1gJIiFVRuUgG8GxIQH1ZsA1B7y6q6UxUZJpDagpDoZ2PHNxkw?=
 =?us-ascii?Q?IC3xTrTKrtqsID3JE5/O+DpI6atUZ/YfbfhNIUs/6bBnFaHnAQBZjcaUm/1a?=
 =?us-ascii?Q?GELc+Nnob2OgmQBb1asdgNVMImY4ydPRL8v/L3NWPYkMQpv9Am0lFTL98k4U?=
 =?us-ascii?Q?Kio+4jwK2YzQ5cLljYDJXf1aasv1ajGkpOGhG8xzLQDzBss0r6w/FBwFNbgV?=
 =?us-ascii?Q?kemY9bOskwLsZrRkOI7evquVhuN588ZXqNRBC7z6xW6U102f4WNvVNUxA8XO?=
 =?us-ascii?Q?p8lXAE2lyBK+B1UQiLl1z4mP1Ah5sLAcpK/aZ0+zlliBWFZ/gx6QjrymQ7WO?=
 =?us-ascii?Q?TNd5zOZNcR0TnsNylXCI+mPgepCuBqp0qQ8HdT6hMwrAzMyGnYbjVfh2L+QU?=
 =?us-ascii?Q?ToD8yI9MEHZiLZx4jwlgiYcumKQH05f3vzqXrqCHqVfPSKK/dkWAy5b+pUNt?=
 =?us-ascii?Q?1amQKCMvog1mTO2ErRPZVim23c5F8B7afMgDXfecojaDSFVTRzHOgjS3eeT7?=
 =?us-ascii?Q?UMsqz+5fMe92HlNbd/GX7QdfdSjvTLOEML+08+Tm/NwfM1kynWxeXLHEuJbG?=
 =?us-ascii?Q?vASyRR6CKFWjHi9tCZgIsQz0WpzK4+nwRGyg+/9tbncM3PQ11pcLM1m/UxKc?=
 =?us-ascii?Q?4WUaaH0r9379B4r3rzQ7pVsSLQ0LLBNdB6LXeKNzeqn+YNY8SFlZB7eMj4tB?=
 =?us-ascii?Q?J/7ptqVDQHjvRJnVd8aCBuaGXy2g1rqpV6egvAIzjDW2XA3Wvjotk7CDiv05?=
 =?us-ascii?Q?jvkfxYJA/SKm/+yHCpgItgia+7rHV+kHkoRzjV0BiwzAJEo8pz6U2LaneL2R?=
 =?us-ascii?Q?mtDoYK9t0mZsgftWppaSZ/z7psTPm8e6/EC12BmmGwJmpYCdr2rFX4wpFQez?=
 =?us-ascii?Q?UxOKd9ujArRfH8bnJr2NqK32SjjxALvBpQWwHA8Vl/SQBm8FKdjgqBm2G7fp?=
 =?us-ascii?Q?AiltaC2g/5FrGkoPt/wlM8sPeVtokZZoPhEZ2UbeOGFAeg0fn4FF8GkJk+ds?=
 =?us-ascii?Q?ggAlGSDQq9XdE3g+LMvnVs6FHBAnCfVrVGg5NTW8+KDMKoePbz62+lQO29gu?=
 =?us-ascii?Q?gG1wcqRdVCJrkQo0+Y/gfSlRszdOiTb41zoNGhcLufAoX8zDnMbpMjSgPpkT?=
 =?us-ascii?Q?eNgm6yyD4Ow/eiE1j/mcbr2mt9TuyMTJjhPrZZE/9wr/d5xPFJ0j3hQvOKez?=
 =?us-ascii?Q?QLXRm6XkNmbm9ZVacb4vqaIkgvVBdRL5Okz7Lq716/lV5ghmsin0zaIK+0+C?=
 =?us-ascii?Q?YOZC5wNjHRYKk3fFHH+ZZSu1+8Jb7Xh4iv7rahry54aSQA7gROG6OW80/jBE?=
 =?us-ascii?Q?mMo2BLkY0y5LkYDDeIs6oY/XhHXiwvQ6avpYc/zx8fSkLIcM4WD2EHTn6rTj?=
 =?us-ascii?Q?GKYC/+65Qr3DX35tsKErP6I89WgJDsV1LB4D3ktKAp4zClqvZo9vrtoenIb5?=
 =?us-ascii?Q?OjPicNwkNlQpHTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8979.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQiq/EmfS1V2JSZ1McGXah/aTKjebLh6ly8qobcq7UiQ/hO9xA6AecFrHUTX?=
 =?us-ascii?Q?n8JmAI1VTilStHYQJeb+Y0LQJzjj8/qwkRzeoz4lyi99e4hDpcl0dl7C1bq0?=
 =?us-ascii?Q?tYYpiaDGy35XcCWF0zqI4RUoMOPD2iPclYRVNo0GsdjQ1iMHswhCEN9Dfv4d?=
 =?us-ascii?Q?bdrkdQxHYXiUPAZo4+6nhCz76V5eVdc7se70xOEV9ghQ9AYfblxu6GtnPdft?=
 =?us-ascii?Q?KkS92Lrb3NKdQgntp4Cgc4OyAuNQXMfHfVD6FBJ6gxBhk3luZkaqr13lTCGJ?=
 =?us-ascii?Q?d3i0nBiXHIULmRXSxDBJEL87sxIBo9uLVt1b5SjpY1nwFGTwgc69k3c6y/vB?=
 =?us-ascii?Q?xe6qbIP6ca5YsNcTJuuU+9N270Z44LaPbeMHHddcnhN+aw/TUTtXpQbUayr6?=
 =?us-ascii?Q?uZ+2zCGmFvkCp4/JUI3KCcZ1tTevrpFefJ7frJssf3g1GNnVYmW69SnFzFZl?=
 =?us-ascii?Q?j7a9zLhT8gxuPgMdjMlEJzLEh7JufV4R1wq3lMOSVAXDp9uGnyIUotjx1YR9?=
 =?us-ascii?Q?nkbZWiAfb5tvXVsbDeJgCOQl+Q5LmjIfbzqq0m96dkGJuIvKSberT5yMKHRn?=
 =?us-ascii?Q?uxBVUmB+mtQuEodfsO2enOgQ1iyS3rYFTvdRhD2pJ+bJOrUGV5MGqicCDbM/?=
 =?us-ascii?Q?H+Xmi+vAoCP5+CAThixslt+OnISGoDl9fCqcUQ0BgCZ+QxLKSXI9T9OX3XpQ?=
 =?us-ascii?Q?KlkK/VoNctqBJe8wsYdSxKaXN2g6J295IbMvP1gBVCAmZbhER9mNi9HJa3qM?=
 =?us-ascii?Q?PnwJ4jmikm3MRP5TRmsOm93xq8U5o/eaPn67KZM8A6X++ATtPXAE9DV4swrh?=
 =?us-ascii?Q?ndEZ1JMpRCBJKnxZZVjE/yg2F+tnX4SaDODaM9ESHAJByGd63XoQFVWRYPTX?=
 =?us-ascii?Q?+XweO4nrBu8InbzAXG7R4XEB+Pyeo8Mq/t/iZVRPmpggTP+GnIkOf2JBmxip?=
 =?us-ascii?Q?7MqCm4dleZWNeQ1IRIKZHq14Nj0AJgZfT878ZCDREABXkRsr5F7FraDuBcvD?=
 =?us-ascii?Q?3a3m/PiQQb+u+MS+3OZqtv6b+u78zy25NB588vMCka1mXWGnozI1ZG6UJQ22?=
 =?us-ascii?Q?LnL8Qias5abvsFydT8ImQdWiHOnSVlNcK232hA0wuLTfPxt3reztdGly2y7Y?=
 =?us-ascii?Q?vIUWPV6ZdZ7Wcs0awu8X+2ET3Sp82kgEtimrEEj3GV27hytnhq5+EqoNxy63?=
 =?us-ascii?Q?/m+5WS7PjE6aYl+PQU3jYDFcSVpCYSK79vuLb0HuCH9MEenIgkI7bhD+nAjb?=
 =?us-ascii?Q?8d+rNFRbgAVqrzLier/QqzqdKDij2gwg5Vez60Un6q9H6BtaQJTOUfgy1CId?=
 =?us-ascii?Q?Y5bumWy78G+LKljsezqWkm+Ir1Wmr/H/leSedvbNLAxKPV5dlPXRV0EbqVHb?=
 =?us-ascii?Q?hJR5ARFO6lHcxVmUQN/dC1Zi29oSAwS2+MghZWOQZIddOnhHEJd5AycdUPJD?=
 =?us-ascii?Q?0CQ7OLfF06sMVuFD0PoIaFAggHgc8HGVvM2/zrqy2RucDG4a8mVi4fOHdCQc?=
 =?us-ascii?Q?dMJK2fcymyHEyMQunvEE4PHwG+E9+0gIJvARW/Y5mZybn0rq4NCHarcyJNVV?=
 =?us-ascii?Q?Szv53kURegSemJfO/Jksuyy1rO9EHm966OhL2Kv5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d46110c-d7fe-4135-737b-08ddb8945090
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 11:42:10.2197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFqkHDSrgbLRpcVB7DVWAtUU7iaNG3SsEHodgFEj38FM7PzDN/ji8aB+bsSMMkYjU5mHMi7WaqdDf03fFP/+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080
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

Hi Stephen,

We have exported the API and are currently testing it using our internal ap=
plication. This feature is specific to our platform.

The existing ethdev queue rate_limit API supports per-queue rate limiting. =
However, our use case requires per-port rate limiting, so we have implement=
ed a custom solution to support this functionality.

Regards,
Vanshika

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 29 June 2025 22:13
> To: Vanshika Shukla <vanshika.shukla@nxp.com>
> Cc: dev@dpdk.org; Thomas Monjalon <thomas@monjalon.net>; Hemant
> Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Vinod Pullabhatla
> <vinod.pullabhatla@nxp.com>
> Subject: [EXT] Re: [v4 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, 11 Jun 2025 12:40:36 +0530
> vanshika.shukla@nxp.com wrote:
>=20
> > From: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> >
> > Add support to set Tx rate on DPAA platform through PMD APIs
> >
> > Signed-off-by: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> > Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> > ---
>=20
> You intended to add a PMD specific API for rate limiting.
> But there is no RTE_EXPORT_SYMBOL so it was never used.
>=20
> You would have found this if you added a test for it.
>=20
> Not accepting this without a test in test-pmd for it.
>=20
> And why is the existing ethdev queue rate_limit not a better API here?
