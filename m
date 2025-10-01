Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DFBCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 09:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7F040668;
	Wed,  1 Oct 2025 11:22:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE6340657
 for <dev@dpdk.org>; Wed,  1 Oct 2025 11:22:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UM3FeY011670;
 Wed, 1 Oct 2025 02:22:50 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023139.outbound.protection.outlook.com
 [40.93.201.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49gqnphjj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 02:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIU847REvkj5StPXH+vuDCM6vLIABMh3P0mx5k+NarVMhsT3jpIeIx6kej80rjrOKvjJCPYrlLGiFhFDOl+Dol2FDm04+hYHqadojX0fvAsv3ou/frbWSm8lsaAVo/9PLk35BuHX9/CYqMGmoJjDdHjVC6wE+zV6uMF1in6uUfjgWO2IQh6aK2xkBWxhWdn7Z63RvKH+zCQ1pXJQUZd1wqgILwiY1RFk8dEWJsbfLbNayqNzQnmr6YRIeJ+j3AnuIjZVeA/WrzhU4yvjc3/SQ08gukL0RTK7Tzyh+/9N02xeiHCv7VEX7mDgn2ZlXyJUvvECKXL6GXJ/b9Mg+sKDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEhDpHLw+Fcq4MqJANNOA0rq5y7WuGtZau48vmpHftE=;
 b=y4JPLJmmdrYEJ5d+L+2ehXH4zpn6hufBaWyo5vXJsX7PH423Ai/aQSdcgytZkst5zLGIctrbn9BXnekMqKcnjox1ZRNvzGPhzLbo9T3CCjfPpTJaxkys3uXQHC0CQ0vZa0+MNUSIHXgikoaT1dL7yjDdoBkaoT5C5q8vRl11pWGdWGONFJlTaaVJfYgZi+lgBvRvtBP3dH909w4xHdimkRMlwUu5iQxQoPpuxXTphgplAdpsqb7iySSC8A8kwzII0CeFoIH+H1MEQaXX/NheE69JeSWlCk07nZ6nfSJKN1tgBDX2DHMjHQb6VKo1vqJXZY3vQJYFTmsL2bukVL2qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEhDpHLw+Fcq4MqJANNOA0rq5y7WuGtZau48vmpHftE=;
 b=rngn+CLCxYHvnP+yNC2gRpo6z8mV5t5RC5w1rXOYSXYiol3niowL3zeChDwzXvZg8Z6VSP4hIS7EcVLT6c0w08WnSVaaeCF+C8cwJe3QVyFuUp9+VAXH+IaaWfzFEalcl5+NfYaMK+ZkypAh5qy3zT3ktiQpaFyzTaCL690qdXU=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 SA1PR18MB4599.namprd18.prod.outlook.com (2603:10b6:806:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 09:22:48 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 09:22:47 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Topic: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Index: AQHcMrTzexClfQ/wYEy+Q4donQ3Hbw==
Date: Wed, 1 Oct 2025 09:22:47 +0000
Message-ID: <PH0PR18MB40863F1D0859F31AF051E164DE1AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <aNK3KPYmVmMKfFoH@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNK3KPYmVmMKfFoH@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|SA1PR18MB4599:EE_
x-ms-office365-filtering-correlation-id: 21ad0090-69e1-4f30-19c6-08de00cc1639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?W07Ny97YI0bNEjK+XvP3bwiYbgsvJzSQx7AownUlB5QW1YiDDcIFUQYCAI?=
 =?iso-8859-1?Q?GCPKRALqNQRMLAQd8V0Z/NbmtLTkSJ3UCcnl6tQHZWtiZzP4Ix6rZDhAdk?=
 =?iso-8859-1?Q?JWGXYvNqISochOKiyG91208WMKxH41udnVvF20TG8QeypqD5e94xQbUXGC?=
 =?iso-8859-1?Q?0efx47+cdU0UrcBqFc86G55YyjneBbIBYrPIPucfYzBydJrZbNnt+iVBay?=
 =?iso-8859-1?Q?nYA9gSpNdYHBiAqLzcUlUfmA4j20AxqRPuj2xHmRtxbTPJiOceiXQNUyAu?=
 =?iso-8859-1?Q?wsjWSW7gsJLiyKZUv/BY1xzKvTnwByxQB730QOs305fqfb1731fuv79dNc?=
 =?iso-8859-1?Q?VBmlLhcF4svbAlFeP67ergY/lq68aKHn2yEV19/wgamhjh8GUOPx1nuayq?=
 =?iso-8859-1?Q?QLO0SvZFejhKprh2DkwXXHkIIdxwEx8/7RSEHe4G8ePcByTFsA9X8HMoNI?=
 =?iso-8859-1?Q?PQ4ilVFJIwPFxCCZnHghsQ+50Yvlv70W+5K6Qg8GX4FzAL4VCM5Q6frrLP?=
 =?iso-8859-1?Q?yr7X1fqGBEm1Dps0c5sp/LPS9NCg0qc1MyP0TxLSuTvxeVE1Jfpx192aVh?=
 =?iso-8859-1?Q?/hkkTiFgatjiswUFxjZ17iGp29QTxfXBdmqwAIHbXQ2WVcjy0ZyFESXBP5?=
 =?iso-8859-1?Q?4JvNT+2nPwuC5YpQ+PwNG+miu2UqqtLIBRb8a+RwXxLRhajRRmnnsDQK5+?=
 =?iso-8859-1?Q?N54CiLLxFg9Z0nnIi6DuHe8JCy8ZUo/tq0FWLSy0h3XZ6tsZv7ulXS1GOw?=
 =?iso-8859-1?Q?DBbUaA+PDZbF3SD3lrPLylRHpCoSYtmcQwqa9XcURNtSSM7ZdaJD1a92Es?=
 =?iso-8859-1?Q?1BlXL1Ru6TSfGtBKGtvxDFULh2TtaSGMf2JPnAxyigI9Jx2ecGTIENHjyS?=
 =?iso-8859-1?Q?80QVOYunDyyPYqf4fwqZmnEmq/8RvLVk+ngBlM/nv7nAyvmbOptRsVWYoP?=
 =?iso-8859-1?Q?nLf0u01M8oH/KJAflizKVL5UnP+ZNSeCACj3OKZW0voh/DPvR1K6j4WTpl?=
 =?iso-8859-1?Q?09577Na/WwnGFOXaKLEqyQUW5DH9sd6K14Jf41YYQUdpmF4TbxUYlJg3w/?=
 =?iso-8859-1?Q?bZp1QCJsj9uH27Lk4/Y28qS1b+tRd7j0JZKgU/EkjTeOCWv2kWg7ggWQ6K?=
 =?iso-8859-1?Q?GiVISvKn/e/6qk6L8tMN+Lxv+Fe8wJnDk+WJ9GEDZEGuKRmhXLBd0eADF0?=
 =?iso-8859-1?Q?XbpaugRYp30NFG/V2jQr1rcB+qFN5mAYxA8E7/b9asE3Mjpc2sZvcl09c7?=
 =?iso-8859-1?Q?T2YtBnG8KTeytdmY68Ba3B0oI3FC3K/sJh4ZI9BzjjzPdSWJoYBSMPJ8z8?=
 =?iso-8859-1?Q?5dOrplPqNBNIPXnlkDhJLkjPnnsoWQTYU8l0lx23xeaGvpwd3HX9Uc0f/z?=
 =?iso-8859-1?Q?KhsyHr/960JRm1OQvmKeA6BmgKWeFDdEow8x39idLr6/vKKm3z31Lljshk?=
 =?iso-8859-1?Q?hOz+cX9GtADF1wHAkVLEvYKGxjddJJu+PfQh043j0MsWQkCZUTz7CfQQj6?=
 =?iso-8859-1?Q?+Bxb4tKQ3Z9WK2ynXNrya63djvhvWbL0zmaEiaz3UHeI3NVA2EY8lNO7SD?=
 =?iso-8859-1?Q?dB5bgZ4/3AZ0x2y3dyMSgGuhRTNnnAYmr3/tL5C1hIPXKticyA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Om3kqEpaC84BV/PZ2JSjgtWx3r9TMkkVOkOIPLkDDxl4iC34YFbRNzmmZ?=
 =?iso-8859-1?Q?8gd6nFU0On00tt18BB7idVp32/86UzD8TgjUlQwUhi7B5+gt53Jpa6s0cP?=
 =?iso-8859-1?Q?+xbD8PZsp3Z1zd1K0JkFVmRWUWz8KEIqw43md7frThluIMYxNaXoAyrD+O?=
 =?iso-8859-1?Q?u1MJBqTLLdj+SBlaqgtCBqcqd0GAc9iLovV9EVtKyHeLSzA+iOCdR8wb0s?=
 =?iso-8859-1?Q?XE0iwfKH4TVEd83q9K1T7KZZDakRMmb9DXrROFAgQ1b/Hp5rb6LkzxtpX1?=
 =?iso-8859-1?Q?6y816cyqV4gKasNRaDlJaQtA9C9O3SWPfZZ/FlhS5vg6JUAPIczrYgpzFL?=
 =?iso-8859-1?Q?xlT3BZ8z8nxWhIhhbBAGiG3zHUGrB+VKQZTFWFPqbdwVYBPDFms0+sPJv2?=
 =?iso-8859-1?Q?lYN6D8CO/FaQnw+aC7y4uxy7R9L5kmmY8CtrUjbvb6SA+GY50GIl22qa4q?=
 =?iso-8859-1?Q?u93UGe5XoXnuiNxzImCQ8vSsqUVIc+T3vUAHtciLW93gEmixLdV4SbXIIo?=
 =?iso-8859-1?Q?pPLpZJ/QopOswJb5o8XtHZPJtSK73z5wBAC7DaT9t8vLPjZ9WcUpDm23LG?=
 =?iso-8859-1?Q?XiF+abIOSVWZ7ZX+/TD/0OY/NFiJf2JkWDrniyxc+S3YMHjmOyAfK4lrtd?=
 =?iso-8859-1?Q?I4Z5I+FOKZEWFdSV223JONc1SbY+DPMK1OCablv43HSLlpw2ox0asmeXgs?=
 =?iso-8859-1?Q?jeJw/rebSedZIC/StN+t9Vd/mgSUzy1Tpj7eZrqDDMkAHG8Gf/eeMPHP+x?=
 =?iso-8859-1?Q?QuWaqIcs2xviLBYclyJDGlVZymO2uDvARimvPUM+wieVF9ZIW5FljNdGxi?=
 =?iso-8859-1?Q?2BJjxKxLM9gIGFOlC0f6/jiyyLbJvcqp1Ck+ehrF71YGysdmIdtzG/j4vy?=
 =?iso-8859-1?Q?kOxJOjcDS3wIx83vxjvQlOKBE1QZy6eeVZC+E21fsTg0kUGTYV/VPczYm8?=
 =?iso-8859-1?Q?1ioy7BndGV0H71ZibjRcFBcX9jiRea+zfe3tnWvCDwDY9nvBqW6oGV1WDv?=
 =?iso-8859-1?Q?GmttpXrvAUMd/+cBMU4WbrE60MP+FFBfECxkX3/N77cx1N8Uwq/YG6hSB1?=
 =?iso-8859-1?Q?ou+dpj82jAc3AzhstBL7StEpori/cWSrfm7xlt27sm/HmOTToZAKdQ4kWU?=
 =?iso-8859-1?Q?jxscHGsla15G42rSslJZzuPwWZU3RlKkZsSJPGY1gwJ8md4d3/Kj0DRseT?=
 =?iso-8859-1?Q?uXNjmQYK40K8QaIjK6ssDIrdEpsaW+hOt9/VvJ0v0kJ15cWPIaRTCtstJa?=
 =?iso-8859-1?Q?UMdhKq+slBEdSF8IuOFILuzsAJsqGdb+tC2GJVeAZpKoNwEpj13rmdtvXl?=
 =?iso-8859-1?Q?euEAZcgmGmfck8ZTqqZVJfz+LsLsfe2Mu1fbbH+Nq3251pkyNOAqW7m33q?=
 =?iso-8859-1?Q?wr1QZk5k02ul/k1WJIA13l33KRbf70PpqQRjedMravFTnD7tfyVz0iay9k?=
 =?iso-8859-1?Q?OgGvnVUxGKi1FsW8ESESAeJADJTUfRWCgBc7rm/cLJYXwkS0fb2qZ8p35A?=
 =?iso-8859-1?Q?tZAZAZHgeQ+FRnFLKkp7AE1fkysslg884AvpiIrpSKzvrOuGX0IKlb8ft1?=
 =?iso-8859-1?Q?uiOCmcNvT7f2O0BuIN8CRWh4fH0obosE5SJadsT61VnA60XqKS4DDsL22k?=
 =?iso-8859-1?Q?2rWU12bnjDJjnYv5YoFJB41amVy0erLvrS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad0090-69e1-4f30-19c6-08de00cc1639
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:22:47.8959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSMoGU89dF1MKv9GDsxIqpU5RkJPx0KuH4LV1kpDWYhZLvhU5sUdD6bt8ngzwpQwqytD65k6bU72T/IDiEcuoXPsR8Gjz9wYV2WzseQhiiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4599
X-Proofpoint-GUID: 1kkpQBK35p9Hz-sr8PYyh05pARDdAMnV
X-Proofpoint-ORIG-GUID: 1kkpQBK35p9Hz-sr8PYyh05pARDdAMnV
X-Authority-Analysis: v=2.4 cv=WLdyn3sR c=1 sm=1 tr=0 ts=68dcf2ea cx=c_pps
 a=nTChkIIWaLHlKa6Ix9xfsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8
 a=Q2Gd3IRyi0p0L_KfOlkA:9 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIwMSBTYWx0ZWRfX/3FutO3stH0o
 FUsfSDN/CEG31L2j/pAMaUCNaImbb4VCWj33UJ2MJP8gbifcT+0J4563/as6s5F3V/iUT0PWwil
 3Ijh3WK8L/OChAjFuI0assrbAiPdjcYw4VJO6eDmOtf7glwSqI2o8iXqmTZVGr6zQ98SnGn6Com
 Va39PZmY0kTNkVDIPQ08bPxlON6QFiSFBExG7FC60Y7UGiDHfrEJrZHK5eoI28VXsxqUHsrqFRW
 Ya0G9/L6ea7Q1rJW3cIjjX8imMY/xnok/M/QQxekggvMnpmZaFsrOwJvQ4cPXiLB/XUTh75d+0l
 qRUUJmWCubRPQZHdF2nV7OkUPQSR+wzCORXdJi9d2OmeHFvuHgrDoYStz4VR7pCrwTiLsUHXFfN
 jBjfd2NrKe/yZQsImkxo1CUAtWZAGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
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

>> Hi Bruce,=0A=
>>=0A=
>> >On Sat, May 24, 2025 at 02:43:10PM +0530, <pbhagavatula@marvell.com> wr=
ote:=0A=
>> >> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>> >>=0A=
>> >> Introduce DMA enqueue/dequeue operations to the DMA device library.=
=0A=
>> >>=0A=
>> >> Add configuration flags to rte_dma_config instead of boolean for=0A=
>> >> individual features.=0A=
>> >>=0A=
>> >> The enqueue/dequeue operations allow applications to communicate with=
 the=0A=
>> >> DMA device using the rte_dma_op structure, providing a more flexible =
and=0A=
>> >> efficient way to manage DMA operations.=0A=
>> >>=0A=
>> >=0A=
>> >While I have no really strong objections to this addition to the dmadev=
=0A=
>> >API, I'd appreciate if you could explain WHY or how this method of work=
ing=0A=
>> >is more efficient in your usecase? When designing the dmadev APIs=0A=
>> >originally, we looked at using both an enqueue-type API as well as the=
=0A=
>> >implemented individual-op-based APIs. IIRC at that time testing showed =
that=0A=
>> >using the single ops directly was faster than using the enqueue APIs, s=
o=0A=
>> >I'm wondering what exactly has changed, or is different about your usec=
ase?=0A=
>> >=0A=
>>=0A=
>> Here is an example where we see enqueue/dequeue ops to be useful especia=
lly when=0A=
>> integrating with Graph library.=0A=
>>=0A=
>> We had to write an entire wrapper[1] for tracking sges with the current =
implementation=0A=
>> making our nodes[2] very complex.=0A=
>>=0A=
>=0A=
>Can you explain a bit more here. Why do you need the wrapper rather than=
=0A=
>just tracking in a circular ring all the copies offloaded? How does having=
=0A=
>an enqueue API make this better?=0A=
=0A=
This is what we already do in our wrapper.=0A=
We found it unnecessary overhead since, the driver already does this intern=
ally=0A=
and we can leverage the existing functionality.=0A=
This also reduces the memory footprint as in the case below we use a lot of=
 VCHANS.=0A=
=0A=
Instead of checking for completions and maintaining the circular ring, we c=
an spend=0A=
those cycles doing other things in the application.=0A=
=0A=
>Can you perhaps give a trivial example=0A=
>showing the difference it makes here? The examples you give below are=0A=
>rather long to understand quickly.=0A=
>=0A=
=0A=
The example below is a graph based application which currently uses the wra=
pper implementation.=0A=
Which we want to swap with enq/deq ops to reduce overhead.=0A=
=0A=
Also, the ops descriptor already existes for eventdev subsystem, we are jus=
t importing it to DMA=0A=
device and reusing it.=0A=
=0A=
>Thanks,=0A=
>/Bruce=0A=
>=0A=
>> [1]<https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_Ma=
rvellEmbeddedProcessors_dao_blob_dao-2Ddevel_lib_common_dao-5Fdma.h&d=3DDwI=
BAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DE3SgYMjtKCMVsB-fmvgGV3o-g_fjLhk5Pupi9ijo=
hpc&m=3DdXtUywAGV8Rir_dtqGP5J-tvRAxN9zQjmM96PeDo6Ke6QybID8eLdPbVwWzlgZFy&s=
=3DQryV2vh2_mWEz5yS37615Xb1F6B-gQZHM1uZ3badxoU&e=3D>=0A=
>> [2]<https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_Ma=
rvellEmbeddedProcessors_dao_blob_3f364261de91e355699bd9af20d60ea6459f7d67_l=
ib_virtio-5Fnet_virtio-5Fnet-5Fdeq-5Fext.c-23L51&d=3DDwIBAg&c=3DnKjWec2b6R0=
mOyPaz7xtfQ&r=3DE3SgYMjtKCMVsB-fmvgGV3o-g_fjLhk5Pupi9ijohpc&m=3DdXtUywAGV8R=
ir_dtqGP5J-tvRAxN9zQjmM96PeDo6Ke6QybID8eLdPbVwWzlgZFy&s=3DBl2X7g7xXg_XrWvVI=
jPhMuIZuy3PG7tOM-Eje9i2ITA&e=3D>=0A=
>>=0A=
>> >/Bruce=0A=
>>=0A=
>> Thanks,=0A=
>> Pavan.=0A=
>>=0A=
