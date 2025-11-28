Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B519D116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 14:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B649402E9;
	Fri, 28 Nov 2025 15:00:59 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
 by mails.dpdk.org (Postfix) with ESMTP id E3720402C5;
 Fri, 28 Nov 2025 15:00:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlCkW4SopazYWg+Fbrcn3qTdjIcJtN4ywj1J3RszTo/aI57YRasdnfbr6PFmmP0TEfKTQDJUxYYNqxa0PPdl+vNzxYjFIEsArBaNPkRo1/XYouSVD1eyx3KTxOSFkC3oXSUhPomelBlLK5dv2U9s3xofxjdtlvQf/1rIpsJ4F8bp+wPZxKC4Q0OVl0Q5DlXOaR44fg1lcfouOtWlgNDWx8MJQCTXVNXrOt6tlR87CswHQd6PipknVpVDy+ZwW2wWexkfjDoIr2Y1riqpfG0kSZBt2+3hJmcUDl2p3v5RUQGa+CAb+uqZEl6MbNrAg7STl48W1xtBGpeTFjhMQONDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=nYvbr16Eoslr+ARlGO9AEdkMn3jCMze+zA5JFrvXgvIba99ZAqU7LKKMLd8yu1Gx6rphcSagEGzFcC+P2i/4h1BpR3fsmIRaJeayLjwb6yCO8oNT4iX3v1uOMM6rn2wSlV73OchSkHfjEeGND422OeuZB2BHMc8kUGQ7m5JTcJLoSr3DFo8gmGg6Cl7mGiqjQoAhLP+k23cQe5MPpCSYAmxDexSbt8V3Ka1CvM+BLRLdwaglqHMNw+6sPcXlLSlc660Gk8mozaNsCYOmjUpcTlPLyjfbt9sY59oreAXu3Gd7jZVpWhFs5KBTu4D4Du+YHh7GHZ9XbefzgVRoqpuLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=U8OHzoqreowuR00YRaLbHByoW4SJLRuib1aD4iFAJku6C+mNB+81VEMjFzp+6W4VdjgC4ucJsIVgqmAIdAMxM+goVmG5n5RD8UNCF92W//u2r+DsFtuwdnIYq3KzSkYt11/Yw4sl/xYwTBECeFFyGxgCVDUkua7CwVfX48S92OIAfG26ZXjcYTyNxKC4CgMeY90W0jb93/TCLutFcqdwk/hebIuaRmt3XC9N3bOwtiHEWKOxgr4lTBYdIz3rtU2dk6UZx0scKI99WEKfalJ6AXzAbSlcraOpjIFzcqW2fQZ/qE6N2RdilgWTsQqlJhPssswzhE+Mp9e+Y6qYkQaEew==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 14:00:55 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 14:00:55 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Gagandeep Singh <G.Singh@nxp.com>,
 Akhil Goyal <gakhil@marvell.com>
Subject: RE: [PATCH 4/7] crypto/caam_jr: fix const pointer in UIO filename
 parsing
Thread-Topic: [PATCH 4/7] crypto/caam_jr: fix const pointer in UIO filename
 parsing
Thread-Index: AQHcYG7XEHPOQ8Hh+U6J+tzw504fW7UIHexg
Date: Fri, 28 Nov 2025 14:00:55 +0000
Message-ID: <PAXPR04MB93289CB2AA525B1AB9EB2AB189DCA@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
 <20251128135616.2662164-5-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-5-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|DU2PR04MB9083:EE_
x-ms-office365-filtering-correlation-id: 093e0f7a-6a31-452a-33f4-08de2e868cac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y5AqcQ1dMFKl52+x6Ga0bZXEEEEpok03DFWujzXpjZgNNrGXPPEPg7ipTPwP?=
 =?us-ascii?Q?M+kKyl3FydJ4Dh0H40w9Ef/2MxsR+KY9S5Dh1xkPhXa5JopPmsZAN1LAeyhG?=
 =?us-ascii?Q?ZDjR3pNuwjzHvl4js+cGLnB/URtcGkwkvl3zBg4ebUOHSDp2vkt/mTaMApd4?=
 =?us-ascii?Q?tjZEroTXejN+ofeKOMzKYlV8kutK69E60ldCIzC5N0AXJBPx9kvpoEdsiURb?=
 =?us-ascii?Q?sCXd3NL64cvdH6/wcJAS04dSLsLRjfx3y6iTbGkLPS62enWRnAyI3f3fUWFc?=
 =?us-ascii?Q?xg+NvyC42xaVsesBLt2/EZ9GEtncSwqrkvVxZQfLjBDMIK/6Cmsblv0I7qyK?=
 =?us-ascii?Q?i9By895kO3J2Fqr8HHDyg6DoFTQXhfHbvhO+2rxPCMmehTjcQyRs3H50nc06?=
 =?us-ascii?Q?2zZsm91NNqHOO7oJBmNJSi+3S904ECoJp2JEWgGB0L2KSGTkoniJN24XnPg0?=
 =?us-ascii?Q?vKK0MYygl7NYbaJfVObEpcm2csne3KZYAwzAC1UlyLofraP7REf9eCwp8I7f?=
 =?us-ascii?Q?B9MWaxQ+VTDv+YO800r81GXNJlfUTxtg66y0EG1zipKuRRx6zWj5I5tAkWjb?=
 =?us-ascii?Q?TuS13ZW/uhnifx/wo06ZNHfPDGvtlDvV6oBFAIzJJNAxuzU4pnnTmniR3obA?=
 =?us-ascii?Q?T2I4Sn4olg1ztyyQDXddkK12peJiuUii4OYkqauug1GHGKDSQ0lTg0p42CH5?=
 =?us-ascii?Q?+AqT3Oc3uAJuz9rAqb0NShcAP/XCxHqDkJWi6XrT9QJR4UQf3h72JRpmgOXj?=
 =?us-ascii?Q?P+/vPI4gmp5cIFnkVToUZ6fAr4ycI7PgtC7CuyTED9yT8NDsZu+ElK4kEEZx?=
 =?us-ascii?Q?jNq6dPf77nBbtpVCTjrXpJS+lX8ofuptspvPp6Mj0ZA7AhtxN+Ywy6ti35HD?=
 =?us-ascii?Q?Y86bvqs8K6bb8MUaJ/ojAoxWhxM2qyfQJcyIentWI81tOkIBOqAQwNMSYQXn?=
 =?us-ascii?Q?rgbIkir4w7ewDMMxQLf6NuJLex1O0Dvl02S9+F/1rRWxsW00/r4BYTGWcFwn?=
 =?us-ascii?Q?5I977wPZWc5IiSpV3165o7PBB9wlq1pVxQJIYNKwjWRLcxSRaDXDem+mCvK+?=
 =?us-ascii?Q?UfjidUdUnpAguteaJzpVUijqjWD0RBYHpHQ0v7Zyqg29FNDUxCX2HxcLoVeC?=
 =?us-ascii?Q?UQ7y0XZZPIQHpa3+QPj5lElcq4LmRmkKAE4osUF7iDRtOB6z4+TNb5A/GePn?=
 =?us-ascii?Q?/JOWAqlq4+4b4NwZ92qzxTa+StL8Y5dVQVxlxT0JhuEUJK5vDri0m8XHmjJn?=
 =?us-ascii?Q?bkA8WKz6XWfRgMXLBglCaA1niR9TGNH0hvJ2Ma+PPbsDBMYtazT5/BYiUG9m?=
 =?us-ascii?Q?5/1Viyv8/wcsCi3+rRrDlNYcu2MnDYWLG1JxSeUOafTsPJid4jucMqPmwi3s?=
 =?us-ascii?Q?d3+y63gwl35i0Gjsl3LhD/NQmE2IIE2inyjf9jNFHVyxAmSNsxgs7a3bq8+T?=
 =?us-ascii?Q?vu9R9lBnSLBP2UbRF3ieB7ixxe/5010r7M8WveN2sFStXWmylp4LgssnwH6m?=
 =?us-ascii?Q?ekfaXYTJ6cyJl1rByvCEH1XIiUM+DmpJyU+h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxJmXnb8kVqkkCyk56nDFllYpy/d9XjwQC5weSiQ7djfVuoekIHUOeCsT3oO?=
 =?us-ascii?Q?xERXeMzC045Ns3d6M/Pa8UCZq1apLZfCB5pCZVABrUlo0r0YdLac9woWpPCK?=
 =?us-ascii?Q?fRzqBpWsUU28xZuVzqNe2FHYpuqc2q7PvdBLbxeby9Sa0NUlcJVfdHvSUZms?=
 =?us-ascii?Q?rySNjct9Tc3ao8X8FqLVUU7Q/21VKbcqpfMm0waUooaZO+eFvnDzY6UtasAm?=
 =?us-ascii?Q?uSyF73WzqQFeLqITfyuuTtzG/yt5JkAsuN00kAEk/posr18lDANLmrUShsbK?=
 =?us-ascii?Q?NCrPcKqTHiPnWHKnBRC9k0xLx+n3yTLos+VsAQbt2+r775kYpqR2rZurUo+o?=
 =?us-ascii?Q?ID+b16ZU2R+ZuScEq/RRdD5ERdnX1cmSOuJSUt6ZS1mluCWUxra/CnUrzDML?=
 =?us-ascii?Q?vIdefuSwLNbRkT3QRf3DzDLwT5vuxELWyhee9mLHUroSCgCUZPE44ewLspd2?=
 =?us-ascii?Q?2yFhu3L1BoJSmhfYxtLRvcuaExZEbtA20aJ8m37k96f5S0iYRwqvTUsJa9O+?=
 =?us-ascii?Q?NBzOtQUYn5suTt2MG1h7IMe9xJjdbeLC+FBSMGMjWLr8I9Eg4pMcvwKcR/pj?=
 =?us-ascii?Q?s8EyBrZDmTHOcPE5gD/EmuPmtJiiZasc3ZLF5TbDdNAt03ymnnuJfvbT4KNY?=
 =?us-ascii?Q?5sRBMfj4/Mh+tOJqSTZZrki2ZXNXiIHOz876DrQQSA+lOSKoR0ZpGGTLwem2?=
 =?us-ascii?Q?VfBfEAoYVBFsU/5pkDiAQ/eQOIZS6ptxNhUE1KFKuksDzSZ4n3q8JvvO3GtA?=
 =?us-ascii?Q?h6DmStkNp09TKekLcOSiuyjcLdbd6NZIXlY5Byyo4/4zlFweGfFD0dNWjBaV?=
 =?us-ascii?Q?kfObbDI5Y6XpAoCtHmGqqgNNFXbG8fuU54DOY+qn5GUBfzGmeknL/stsDC88?=
 =?us-ascii?Q?7whxPoiutspTGAHZHce3uwjX3oDeAyEPucebKVfkGUDP3Rm5SswbEFXev+w0?=
 =?us-ascii?Q?GgHzmfqGP7KSJDteNHTGIWvf9Cyl/vPd154weC8O+VmeBpP0qOLjL4QbOBDu?=
 =?us-ascii?Q?O0iqnD39qf7t9EwshtbiCbE1HsxZVHUfcaPydjWHS16UtP4CKLRv2cizzArD?=
 =?us-ascii?Q?53AIfg01w9xak+BkGz+IdHfhBDzCs1UYfEZ1i2+QTP+Ifg0/Hr8T8deDB7ll?=
 =?us-ascii?Q?S46Ib2HBQUnd2daD6exRxwbEimSe6/had2ZuPH1KUsJGoARmNZRZNfrsQ99/?=
 =?us-ascii?Q?mF/JtbOW0eHzP44c09WoMCeHQL9ESxO3cg9jOwXw8RxblN3+mKVdm4qIKYXX?=
 =?us-ascii?Q?o4AsuAvBrLXXK+l35bdReGdJIQl1jFcQTWIxDqFQImBdpOcnoSygC4CTJ6LZ?=
 =?us-ascii?Q?/seILjf3NJyxaU1VSNmHm0FRZv6PnACWHnyZxnLar8MyYlhj3b/wfd+/j/yd?=
 =?us-ascii?Q?+7bU9r49V7qYa7fVVPGsRTu5zrLciyG3zSR5yv6gMK+6qHTao+aqN6yZZDaw?=
 =?us-ascii?Q?bZZN7JmVzotZAlIUUoa9K7IZ66+6H4pwsGSjhaLfXK2jGbvhxAN+UWIFSdke?=
 =?us-ascii?Q?Qo4ABfE7qStzk5x9sdOY9yokGJ3G/yg+h94xSvCiPxkEaluBdiga19gn37Nb?=
 =?us-ascii?Q?0Fpob4i1sWXXw49gQa8QHsDgriv9ROsqZgVRwVGT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093e0f7a-6a31-452a-33f4-08de2e868cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 14:00:55.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5A3sG0zW5HrY5KjrKYOmyvoZJ5h45DOcOTS8j09cJ/gai00hO9OFfzcC+QIxF/+0pW/vZM9LsxQAx9k0IdtfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083
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
