Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792ED1037B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 10:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B730B40A82;
	Wed, 26 Nov 2025 11:59:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 52D934042F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 11:59:04 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQ96fag3141701; Wed, 26 Nov 2025 02:59:00 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023133.outbound.protection.outlook.com
 [40.93.196.133])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4an9rgavmw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 02:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wek0Lmm1IYOQA/FZErvta4/0m5dMxO6q18BieOSSKZknLt1wM3bXr0v85PK7TMc1Uadzl506/CQ/yYMKFhjm5aZsRu5BoO6O5xXsUzDUZKfgJABC6OMAM0zC9MOZgWYcTnvvPb9F9zN9yJ7dOGt1kF6OYwiipCuCuwb/pKfdrlD9DsA0icXftkP4GYT/BgRhf+3BAlmoFGuA8Ut21r0rVTqVMmKgOJqFS7EWADpqIImbkSxhv03pd16hJ4MWtI2onAfy4N6grgGFUbTTyQhbRXGfHyziUHQBqn3MLyQQCooUKP4G0GYryfVNDp+tR/UG/1gnecwdkyzWOw8fhba0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cYEXYp8H/jiWx360yyIdfUCNbOc4Xcxj9JCbwRVlUM=;
 b=a7fDwCRfcRvXj/Ugpu8XOli9erplrq8B1C23X8qKD6vfaloXY8ApikuXOhYhkOZP0RLokOBPE69cRx5GIXXUBWVlQDKrPiG5lFiUvWY6b4jE2rRDKKyBYvwhDkz2QdKM+h37YnPrSW1R0vqIJb+lLpw3LYHiBjqMZ/WLKs5idgDXpxs3WEXepH5j0AL0rrsj8uFY3FxeCz9j0GAv7cXYF/k+cV3LFNKoa0FAEaYibpBLBmhM6axq1xT9C+s/CDE3RThV0nXDJa1UZ9wYBYurxVKfjAW1c9QXiwgBfOYn04xNvITvKtvU2ahZ6ab8ucGYo12dI9L3QkhBQV0qhllnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYEXYp8H/jiWx360yyIdfUCNbOc4Xcxj9JCbwRVlUM=;
 b=R2hOKgDbTaY9yI+kJ1jMA+y/tPts35ml7BsT34A0P1ztkeCjybRZonpOYtTuZ/7ploppUD4E3NGKXZ0rkoqRA2ftRvQlQNZ2esIjK/pgsA3tyq+L4ieBxz6QQFS9XO09ANx4H9NteEf88dPBu9TlCFSCJPzimbPVHR4k46IBgE0=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CH3PR18MB5401.namprd18.prod.outlook.com (2603:10b6:610:154::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.11; Wed, 26 Nov 2025 10:58:57 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:58:57 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Jerin Jacob
 <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 1/2] config: add optimal burst size configuration
Thread-Topic: [RFC 1/2] config: add optimal burst size configuration
Thread-Index: AQHcXq4VsKPYWcJQ0Eu6wbp/mlvALLUEuLeAgAAIiHA=
Date: Wed, 26 Nov 2025 10:58:56 +0000
Message-ID: <PH0PR18MB4086C72E1769C3CD3F405918DEDEA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CH3PR18MB5401:EE_
x-ms-office365-filtering-correlation-id: 523ac0b6-8333-45dd-d983-08de2cdacbfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jV/DNBh15Xis8Zw2owyaKRnOBQ7PbKLv+2z6pUm5a4fCcBCnjxTNPaMvaq?=
 =?iso-8859-1?Q?qGoT1+kg5bEy6axJCFCB/XxQN+t9G/u56G582T9b5j8r8RX0NWoZtkMtAE?=
 =?iso-8859-1?Q?OeKxHCSVQS7bKyOEMZUzffMaR1CuxljPdqimgLxZcp8jKMpzHC0GCESTdP?=
 =?iso-8859-1?Q?ZwPCktdwBD7rmT3s3sjgGj7lMZ1mnr7GVjJFMF0u/Te30DliVoNV2pjsT/?=
 =?iso-8859-1?Q?zrUJaapwtwcxygZXssuDzVbYSN5Gi1UnJbiDBov5LibTr0FogA2qzl2LDc?=
 =?iso-8859-1?Q?77fZuut6gqsi8X6HAYgzqPpAaF+XlTP7+yxo7Dwc2CG8QcRcrWLvPM6ufp?=
 =?iso-8859-1?Q?BCgavslxHymEQ/XHTw59XMt4n+rkmHRFKqBjDB9NaHyG2HNuQ7NpbOl9n2?=
 =?iso-8859-1?Q?l7d5HRoUczhi2cI1Y19wh8Tw9cwCsRruWM4w5CbOqfpzFY9Mzg2hTrgMlW?=
 =?iso-8859-1?Q?3W4Au/V6I3xnnSlnXpSenwrdbW+ZsYVZ3p2zEmwObeaXP/Uk5yY94bWHCq?=
 =?iso-8859-1?Q?t58IyJuD66qZJQmc+x9hYjxoEBdToWrfUqxLhUHXV2zoa6G/oawBh1dK9c?=
 =?iso-8859-1?Q?cHzXoA/oYepr/y1YGZAwrbZgKazQa/9mqu0GdAk2dxWL009wBidLOOiZur?=
 =?iso-8859-1?Q?2viP1sjLjENhwFsUKmwNSSDAPufwCvFGp4pje77FB5wXfcQTkjXjlvnWzo?=
 =?iso-8859-1?Q?bKrK0ij8whW1iOykpRF2w4HT3nIMxHMrVBxmG/FhNq23WT7mL8EOX4ST8V?=
 =?iso-8859-1?Q?Fdjjj8OQmSdyf9uuCVb4Sr/F2baBoCLbHDw5/H58Y53vTq/wHegNCrVMpg?=
 =?iso-8859-1?Q?q6kbZJQr+6XJ38jKhF7UF+5tKlyR2Rc7e0QS+arnWgx1Kbnp/DHY3M3H9a?=
 =?iso-8859-1?Q?vkJgQo8BL0/+lSiKS+SNPYFwoHZq85+W4MfOXqD6qgAq4PAJVpHUQZbp7v?=
 =?iso-8859-1?Q?NCJbDtBfmZXgUXsgFzeEmJG5rcX2gDCRUIsUopXoVGzeuy7kNj8pCv6e4c?=
 =?iso-8859-1?Q?XShgUOPGjEnR668pNvTlFs/5xUAGpzGW0FhbQSgPMf9xKS0p/cur5hXhfz?=
 =?iso-8859-1?Q?hkybMSV/HCP6qJfcwggjXDgTMqcs7YThalHl/d6PgIMFH9XAJSYA1fyxUm?=
 =?iso-8859-1?Q?lRNt0+lST+C98G+3FfWePxowHu7eMArwa4dkG0W82Lx/1gCMol2pZTPtUW?=
 =?iso-8859-1?Q?QyLFWLgs8grPOsrYloCeWJKWp0PKP8ejZtaRrHfrQJ+FXCgMSq5GmK7aaL?=
 =?iso-8859-1?Q?jl4hJVuTDyjCwN4Uu9kCC+H8afRTH7xUV2Up3wkRSS3mMtYlmCO2jrfmMV?=
 =?iso-8859-1?Q?tkpCsW/VqO9oL/6iUXV8JKh2zttSDCLkDMJVylW0jRworczt+AERFgDZNH?=
 =?iso-8859-1?Q?BwgO/O2wxI8wE2PzrmNTLC05wNY+gZVAmKHES6JkbalG3QfAExGGt2S00N?=
 =?iso-8859-1?Q?AK4jB3ceCaEdBhC2F+HgK0d8bVUrsnzsNFpRk4b17oSI/y8YMnjz+0+xyd?=
 =?iso-8859-1?Q?iKm7bqeX6FOTuzBkHgif7Oy2jh17zmYyOUfepTbWcCW+ejbCzqTuruZBDz?=
 =?iso-8859-1?Q?w6YeVzMnkbnBeQz0VejB5r3PBVvh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VeGnDUid8NJVhyDdBKfHxdU1FvOHMTMxtqZvnFNcoVfMekL2Bdq7lIVQXn?=
 =?iso-8859-1?Q?7+zxiWE6nZEr0RcKd3uZKQNftq+/TcVtQtZeLEuBGS1sSpUu955sppYue7?=
 =?iso-8859-1?Q?DrvZYE+gUxE122KzaRE78ArUi9fXDJGsH3CuZAx8CvGlr0umbWlqDIOxAF?=
 =?iso-8859-1?Q?r74UWJMRdJHwTayf0I9oyUxzBcwF6wMNArBdtHFj7HZ0D4OJ5Tqdz+c8sI?=
 =?iso-8859-1?Q?F5YCZHUnwRXDntsCe3kgAqA+s2BkJo+n106s6ixCSvdU6e6jdUtpNpocdv?=
 =?iso-8859-1?Q?a7pw0I+sszd5by9PGyqhG6bp/6nGwkx+wFMpOsmGtIi+M4eSC/GyW2Ek26?=
 =?iso-8859-1?Q?RbL5lpvAolK+aF9cVvnjSqiIytMPkT59Vpd7qS/3WJDQEBPCDf5sHj+PhF?=
 =?iso-8859-1?Q?POJT7jGAFRxqf8WqZXDFtpHzQLZkZcFc+nOhZ0IWErQMmKkMrDReSV5G49?=
 =?iso-8859-1?Q?4H4l/KADj/Mk632hBctp4yIhHursnw1VbKKdq8GqHYHQF0L/ldVZE8ZG3l?=
 =?iso-8859-1?Q?O1xrHTtVnfBpUidmxN52LhzQQuf05iZEy3SKT52PQq4Wr4DgvfUj8w+Ly8?=
 =?iso-8859-1?Q?Xx8jVnfFD0dqjKm0EpTas+Aq39h86/8MFeP+LQb/dL8OS+02y+Vdc7hBGE?=
 =?iso-8859-1?Q?V5tSuO3btJqH1C1yoZTzz20aJLqobGlwH8GSCzC6vjMGSdvd+FqBlKHw9W?=
 =?iso-8859-1?Q?efHmfUANsJWWDCARSITuuqaw5xoNRuaH0tHgbPfIH6DlBEaK4xjeNQtA1G?=
 =?iso-8859-1?Q?Lx03bffv1v8yXGY7u3MIz78n31ELnxJ054Sx3AjhR219+34lsHVZe+6EBg?=
 =?iso-8859-1?Q?3TlZZ36BulFXAA9TrWBZ/4gLtfOmxg39vcy0RXUQ/015fDv4RtswpQgNF1?=
 =?iso-8859-1?Q?ASGdkowy/W92xxjOzmk0KKTx8QpxwUeS2TVMoPXjNPB4QG38uLqnjGR1dn?=
 =?iso-8859-1?Q?D3C8v/6PRVTRxW0eUFMpHCJkNXxJ1ESadpEDT6QWMgUCGCvo7QLXL7lWS/?=
 =?iso-8859-1?Q?VZonR0/YGtRFJZh2hxqzEzDhurVCVE28nrhJjeSkkb2JpA/Ise7JMbcLA2?=
 =?iso-8859-1?Q?ooR/tk7VoPMCmqZjSI+9ZTUTci/wwsFFX0nqCpl+NTzIkxj5rcjDVAumHc?=
 =?iso-8859-1?Q?BbNPXtpi+SZSBpug5+MbK9Mq+6QSZKMaYngLiLML7jibQPlrhhUUSA/nkz?=
 =?iso-8859-1?Q?QuuUoEJzUx/RsGTOjoTVe0JKCsDbTyD6FoqRhYlthb4nuBhhxKfs+HlrTY?=
 =?iso-8859-1?Q?nFlmEh8Us5144k10sjXOfoNht+0hbbHKknhXnX0S54CBoZnmNGsPAOS6EW?=
 =?iso-8859-1?Q?cqc5BArZmgXrK3tUI2128eqdIy//wZxeyaLzAjnWsSrXy4GTNhG+73iqqm?=
 =?iso-8859-1?Q?GaL6fZ+Cy7Gpv4UXXb/K0+R98HTUCUu+OPz9dbFPD8yycPjfc9MtPNIW9h?=
 =?iso-8859-1?Q?LqwikcQVqcSWEoRItBDQo7ACxn1PO+D+QvzaIdayPEsaV9ZnXW7hZMlTVh?=
 =?iso-8859-1?Q?ve/yW+NqjzxZunLbavdQWBr01JnqVF47QlHBmh9YQOGWo1dGq1tvRoz5po?=
 =?iso-8859-1?Q?Anfft2fhZU70U2LlkqQd3xxkzaxYDK5Sjbw8LCc1BCG5N67C+DJPDTWd4D?=
 =?iso-8859-1?Q?ldnrifeSu3wtRS8OAcJulZlX18GcuzctdT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523ac0b6-8333-45dd-d983-08de2cdacbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 10:58:56.9780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4zOQ4jmirPX6T0RiPytv1n0v01RDo+TQZywsBq16QRX2NRL1/hA9/vbFHxV0otVaPXjmGmOv6DjFrFRQWavFrqH4uYELcVN6KC2sT/fiJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5401
X-Proofpoint-GUID: aAcxiCVh1VAXeLWtRYou-hJD9Wm6cJPT
X-Authority-Analysis: v=2.4 cv=ArjjHe9P c=1 sm=1 tr=0 ts=6926dd74 cx=c_pps
 a=pt7H9/Fs7R05i13VUf3btA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=b_GPxq7AWeGcvNvF1C8A:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aAcxiCVh1VAXeLWtRYou-hJD9Wm6cJPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA5MCBTYWx0ZWRfX3yuBhOBnP7Wf
 GWn76pDbZCyJmcmWgWSyoyP+1ze/7seqF2cqiBNJ9PDrUAsuuGsy7FxqvD1PxkC8EmvtpcYL/WM
 E+T39eYoWhblXVMN+Bb63qSnu/t++iSqZDOThFQv6xdSdNbGCO614qNLEcIJBpW7H3dgfnFCkNF
 /hbs+m8Ag3CSiljR6noUJgKNK12e0q+zSxETPZtquagPpSiLDr8hxmI6ITG2G5wAQmHUKf5Q9kL
 x9wL6LgxzrRs2Qdu2gKMDS5dXpfFkdifFxCm3DRTjuDH8ILmpaHXNdJ9W/loEnKtEdjS8JKlw/q
 g4iUT8wCiSU4iltDvpEh4mXZtKPzoxuw7byhd/BMewjLkwMa7LJXjiWZb6lVoAPBA09MnFRydbd
 dMI8vAPj6VeVUQoX4gT/Khr1zILmTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
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

>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>=0A=
>> Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the=0A=
>> optimal burst size.=0A=
>>=0A=
>> Set default value to 64 for soc_cn10k and 32 generally.=0A=
>>=0A=
>> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>> ---=0A=
>> This improves performance by 5% on l2fwd, other examples showed=0A=
>> negligible difference on CN10K.=0A=
>>=0A=
>=0A=
>I support the concept of having a recommended mbuf burst size, targeting t=
he majority of generic applications.=0A=
>Making it CPU dependent seems like a good choice.=0A=
>=0A=
>It should be named differently.=0A=
>First of all, "optimal" depends on the use case; if targeting low latency,=
 shorter bursts are better, so "OPTIMAL" should not be part of the name.=0A=
>Second, I would guess that it only targets mbuf bursts, not also bursts of=
 other operations (e.g. hash lookups), so "MBUF" should be part of the name=
.=0A=
>=0A=
>Suggestion:=0A=
>/* Recommended burst size for generic applications, striking a balance bet=
ween throughput and latency. */=0A=
>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)=0A=
>=0A=
=0A=
Agreed, would the =0A=
=0A=
><feature creep>=0A=
>/* Recommended burst size for generic applications targeting low latency. =
*/=0A=
>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)=0A=
></feature creep>=0A=
>=0A=
>Having these standardized will also allow libraries and drivers to optimiz=
e for them, e.g. drivers should support bursts sizes all the way down to RT=
E_MBUF_BURST_SIZE_MIN, and can static_assert() that the RTE_MBUF_BURST_SIZE=
_MIN is not lower than supported by the driver/hardware.=0A=
>=0A=
><more feature creep>=0A=
>rte_config.h could have "#define RTE_MBUF_BURST_SIZE RTE_MBUF_BURST_SIZE_M=
AX", for the application developer to change to RTE_MBUF_BURST_SIZE_MIN for=
 low latency applications.=0A=
>This will let the libraries and drivers optimize for the specific burst si=
ze used by the application.=0A=
></more feature creep>=0A=
>=0A=
><rambling>=0A=
>Intuitively, I would assume that the optimal burst size essentially depend=
s on the CPU's L1D cache size and the application's number of non-mbuf cach=
e lines accessed per burst.=0A=
>Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each burs=
t touches 4 cache lines per packet:=0A=
>2 cache lines for the mbuf=0A=
>1 cache line for the packet data=0A=
>1 cache line per packet for some table lookup/forwarding entry=0A=
>=0A=
>Then the mbuf burst should be max 512/4 =3D 128.=0A=
>But local variables also use memory during processing, so using a burst of=
 64 would leave room for that and some more.=0A=
></rambling>=0A=
>=0A=
>>  config/arm/meson.build | 1 +=0A=
>>  config/meson.build     | 1 +=0A=
>>  2 files changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/config/arm/meson.build b/config/arm/meson.build=0A=
>> index 523b0fc0ed50..fa64c07016b1 100644=0A=
>> --- a/config/arm/meson.build=0A=
>> +++ b/config/arm/meson.build=0A=
>> @@ -481,6 +481,7 @@ soc_cn10k =3D {=0A=
>>          ['RTE_MAX_LCORE', 24],=0A=
>>          ['RTE_MAX_NUMA_NODES', 1],=0A=
>>          ['RTE_MEMPOOL_ALIGN', 128],=0A=
>> +        ['RTE_OPTIMAL_BURST_SIZE', 64],=0A=
>>      ],=0A=
>>      'part_number': '0xd49',=0A=
>>      'extra_march_features': ['crypto'],=0A=
>> diff --git a/config/meson.build b/config/meson.build=0A=
>> index 0cb074ab95b7..95367ae88e2d 100644=0A=
>> --- a/config/meson.build=0A=
>> +++ b/config/meson.build=0A=
>> @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')=0A=
>>      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)=0A=
>>  endif=0A=
>>  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))=0A=
>> +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)=0A=
>>=0A=
>>  compile_time_cpuflags =3D []=0A=
>>  subdir(arch_subdir)=0A=
>> --=0A=
>> 2.50.1 (Apple Git-155)=0A=
=0A=
=0A=
