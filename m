Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F1C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 12:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0200840156;
	Tue, 11 Feb 2025 13:21:55 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 524EF40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 13:21:53 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B8msD8032492;
 Tue, 11 Feb 2025 04:21:52 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44qg1baq60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 04:21:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVZo7ofUI32xHfcFZ5fXfINvgQyBHLE2zOFzJeVSq8RACeBYCoA6gGTj525tPSHMm6dUlL2wErmpZ58JlMp7Pa16V53dBXSYI+8aEgzTU1p/RJS5kZL7d9FVxTGpIMYqJNjStz0Zg8wdc090iGtoiGDNAFumA8cjG9XozRTEAIQEE4Z/GRcGiYZfY/arjjwDmrEJ+Hmvgda2URgA9awweL2HcTTK4/F0eDwWhbjOM7UX/wSB2UUu43rxty7jQRIO3UAlR5qtSwZzruLTHCgS924FTuJKr7EQsjgukF5VUnZiF3ClxvwYy1zw0zlDjQ1d8ySXjJSmh97dYwyV5jQu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di/XUu7VbFOXX38g/4+R5j2k0zVO3/N1UeycroM8RUw=;
 b=WgoCS53ZyGhT1fJoDdYcG8uVq+imB57aPj7Ogl4kabnWgWY3TB0COpK9Hc0JvJoTq/EMWn15Cc4duHtNeJhHgc5D4U5yV8yVK3V8F+wIbDZap99lDbB2+JsrbEKUOO791nSp/1WBxs4dhtutno6gvevt8HdmeK9MAevj42nxkqLmvVb2OB/MZhICPJ04O4+BYUnmoLf8OZMVeY/aeEKbqSSW0U3RXD8zh63gzyOhtmqha1pvAcCeUY/KkL8cVHvAq8C0Azxqp4VoayifD1vQ+vR2dY++XnA+rinTxKJUsE0rn0rajcAZBSSZ2lKDY1FbKhs07L1pqrrx8jH1MFC07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di/XUu7VbFOXX38g/4+R5j2k0zVO3/N1UeycroM8RUw=;
 b=DiHrjFoxhv9kK2ReYJI9uaffBVIYOdjaYNTBE6kJKrfsp16T3gaghd73/xVE6H2cBDdzhHdsMEdOjIj8KNRjNNmvi8V5PcLs0Sp5TsfGRXpvXsFUeBqzxzmj0U731NFvzBLZ9Wsfb3DIxztXbu9vDBKJmsKFKlt1qROsc7BdHuw=
Received: from SJ0PR18MB5163.namprd18.prod.outlook.com (2603:10b6:a03:43a::18)
 by MN0PR18MB5848.namprd18.prod.outlook.com (2603:10b6:208:4c2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 12:21:49 +0000
Received: from SJ0PR18MB5163.namprd18.prod.outlook.com
 ([fe80::53e:d70:81ae:92af]) by SJ0PR18MB5163.namprd18.prod.outlook.com
 ([fe80::53e:d70:81ae:92af%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 12:21:49 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, Radu Nicolau <radu.nicolau@intel.com>, 
 Akhil Goyal <gakhil@marvell.com>
CC: Tejasree Kondoj <ktejasree@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Topic: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Index: AQHbe5LmlfaPRUzgfEG0lpY2Rn3W1LNCB4iQ
Date: Tue, 11 Feb 2025 12:21:49 +0000
Message-ID: <SJ0PR18MB51632731BD406D4689E2C04AC9FD2@SJ0PR18MB5163.namprd18.prod.outlook.com>
References: <20250207134545.63820-1-nkaithakadan@marvell.com>
 <PH0PR18MB4672E93B78781B63C57D493DDFF22@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4672E93B78781B63C57D493DDFF22@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5163:EE_|MN0PR18MB5848:EE_
x-ms-office365-filtering-correlation-id: 04d6e9b6-91fe-46b7-581d-08dd4a96a8b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XKRJzA62rwOLICRma8/LrV+3kk5bJ5PHahr260r8Nm8FW6xidPHuviJIeFLx?=
 =?us-ascii?Q?bN3kGZiReaeMI0gHxvrbsBsG+0Gvt9jpbHzdPrXU2vnkiT4HnRkv6R+ovosn?=
 =?us-ascii?Q?hwNOs2z5rq4Ihmq9tzEH2ACT7pkcAnFPpIlTnwYAwwC16s8o8JdCcRSu7I5f?=
 =?us-ascii?Q?9Nxqi5USpDbiNjtksVTNsScFDJaXMSqtGJcHWYAIO6VMSNmtAzmHV1Aie0ps?=
 =?us-ascii?Q?xs9Pm5QsH4UJb66rbDHGbuFMcMh7a4A8uwU0YGkKVIAQr0lkKadgK4+Wnmmr?=
 =?us-ascii?Q?riE1b5DMspbz2GeltTYGHqiiJR9UsUV0ox9iKVZeMrNgr6t4znJzWgUaWyUQ?=
 =?us-ascii?Q?YILN/NdzuLhP+0uX9I/nG/fZZ5ummhdgB89aBUhYyEPlEPYAPxuo5slnBzx/?=
 =?us-ascii?Q?uBt2nFM1jXQPp53nPiwbIMvTvvaZXO+ek9jL5HHQrk9WSwd3CwW+gUbGUW23?=
 =?us-ascii?Q?4dEFp/QbS3hI6Iaa069/8aUvKE6ZO9Rub4RFe9b878zEbsiIAdgv5Kdm8e0T?=
 =?us-ascii?Q?tQKkXW7aKW7zd2Iy/Sn34Ej3wBhcstMJ2sKeJBtS6v5ggdgnYvqjb7zr0QnR?=
 =?us-ascii?Q?BO2YhMt35HJQ5UIKTWoWeU7a1bljnrK+0qzgd5D0344sP+SyblJK1sqEG2Bj?=
 =?us-ascii?Q?v5JAAn3sHev3/Z82mBeSXaP7Nfc8rn/VIxpYYESEoNwnsxCrKYLXxuw9pl7Z?=
 =?us-ascii?Q?aBB/dox3L2MfizJQAYODAPHHaLR64PZFiNelL86kHExNrhgAyrYvmGEm1eEX?=
 =?us-ascii?Q?HdYqtEGtqxz3idyDG4V8Y03Qnl1pnw+IcS/nonCFQhsu5/RhDzvRjecFb/aD?=
 =?us-ascii?Q?SdWUYkuvxImHukfolDfTGXNTaXj9BVpvwYlZMJxAL3RQhjhb10R8CEy3zFjO?=
 =?us-ascii?Q?NXWDTyF13KF4a23e9z1mWbeIs4KzhE2wBzxe3NdF4e0Bqb1DMPcQX6YcwiNZ?=
 =?us-ascii?Q?P792Q7877WR0OUoazQWwRwgrTxnJQWYCsHmF5Dk3afZBDDFkXStlsqCz4H5t?=
 =?us-ascii?Q?NNAY1WcI5L0lWc+SyuxvraFDYew+y7k9hrrW95el5/T9waVvp78pVKc360zT?=
 =?us-ascii?Q?+Mi3d5TbnbwDwS/Riz/0jP2r4axYBSHc79SUaRdAv4pO/FC2Ipcp6S/DgU/J?=
 =?us-ascii?Q?BUlVIPjc7zAw4w6VaSh9L1m+frtd9I50h/749mzkN9QRpikbSLTdqPtyKLSW?=
 =?us-ascii?Q?lD/CZM1xOn++JopAn7EI4h8qoBiOrJmDwdER7ZVrgi+yZilBOAJRQKci7uAe?=
 =?us-ascii?Q?8Ne5rsI990KDEtgIeKQaZ4EHPJsfBwWIFWKywXoScIMEi4oaGkRHOK8xzSr1?=
 =?us-ascii?Q?in/kDlh5ccMZOw9RwFveOLgW492KONS6bt5SLUbcbBoZtXOFTd+H0tkrxhxv?=
 =?us-ascii?Q?aLqUvW2sTjt8o87s6NxqE0bVyW4dSUQx2Sl2zcVKDZILdrUDjCDFUD/9gnlQ?=
 =?us-ascii?Q?Ve9dMQJHqxA+DDq9uS18suoKoQKhEwwh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB5163.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CD8lwsiZe/z8Iv+bRH+HP5d5LB9DkLxtGw8is907RAGrPaLUvAWt1ufFnayl?=
 =?us-ascii?Q?xm3ucsVJVlnFJbMvHGdo5BJ+7gbnxXNVSo4+P6dfNyse/dlVIfgzKhJ6B+z9?=
 =?us-ascii?Q?79PnE7+1NOzKxlrCUso3czxqaNG+5ipLrJnKGVJMwtqvR86c7A+AtVaFEeU7?=
 =?us-ascii?Q?ri0/ohsGCIYLy5e+pN/Yd3v12zaNmxZv0U4H4vB8vtnyiiW5F5dQhHU+zPpm?=
 =?us-ascii?Q?UE+gIZRAkcjVwZhCEhyHeVTX0waMVpDOt7xSlc9gov9ELUYEWVxhp9VGYe8w?=
 =?us-ascii?Q?FNPlni0sg+1yzV0rtNzjtbsHPq/sA2GkteMgCgbYHRIIGa4wJly8UwfcWX/P?=
 =?us-ascii?Q?SdYdzP0RilYaIWFuu7SPh3+qWjkR+CnOzOZsk3dQg23LKkI/0m6tlaRofm5g?=
 =?us-ascii?Q?fDLMxH7Pu5Xh/wf+D4uoWQ6gHQVIR7qon+FPeM3r0jFCFTNyHY74Ct78ND/s?=
 =?us-ascii?Q?v9mJwr89r7/Q4gpZd0jAgF/4Un8dFelapHQnUHUNCIeAE8m5O1eAwDQQgTbh?=
 =?us-ascii?Q?aqCFV8ZjbY5REp5FREmA1nxelIzyC7/cIkr8a50nfMtiIXt3gbXv9npDuhUP?=
 =?us-ascii?Q?RSnCo7ih9qytvTWmjB9KCdMqpzXRMht3et1O1fOqujX4WiDB7IbxXMSSwp+m?=
 =?us-ascii?Q?qq5fEUQxdUJ8VW6Sr0tc3iytdIoDAcnE5lerC3hTM6foZA9LTuCI5T9DWzCD?=
 =?us-ascii?Q?ZpVojrQElzzahyNsHZw0IHISCllRUxcqVc8unkLlR5mDXtQcLsYW8Yq3azkr?=
 =?us-ascii?Q?1pbLCVip0bKdGQraSDDMXkBJbBmPLxWTuzbEp+3XdpUMoqSKAsCrApATL6oI?=
 =?us-ascii?Q?45zupOlSwku99JC8BM33BGxTYLnUmtmlRaIGJOISDug442Ouv3PHB61KZuTy?=
 =?us-ascii?Q?Nf65rpCJkiaIXMIYWhEC/HgeNRW9IP8Dh6Vse55pP0ZUgqRUzmMt9APq5uOK?=
 =?us-ascii?Q?muy19rL7giDtdN8VK0TTZ11ph+oOmcievQXeIg0eqmfkTB8fBqaSZB6fgKX2?=
 =?us-ascii?Q?VBQZJDPL+8SreyjWce3AZZtf6vVnw6QAx4YDagL+wrRoP3cffk2gi7kTyjvh?=
 =?us-ascii?Q?j9d/NOrfXeUBsU5Ydau8mwPq78FH7XKZuldwxdsG/4Xn1VbX/AXsPm2BA/BR?=
 =?us-ascii?Q?nhR+iH/27zvd4za1Ca8PtnyfcNcXifqQg55QoPgwLbzvIyrwNipltPy6M4u/?=
 =?us-ascii?Q?afKIdvwG49No8zN7fuBaBuh66nSMp5B0pwidmC5+GMt+o4rzpDPai1MJjQTC?=
 =?us-ascii?Q?1wiIF+rjPDGwa6b1OQ3VqHs+jq4inhaaUMch9S7uNnMgwqWS7QtAl4Q1/l/U?=
 =?us-ascii?Q?BJ8WIv/63xcvMWI9Aeyuac2r4mPYTzeA64re3Uiy5oa68oXEhWcukpQHKkuS?=
 =?us-ascii?Q?8o7RyGuqk6HgnWJtOrqOE+Ib6A4om30ZbXBVDph3bjrSDlR+UnJwwqzQ+CyH?=
 =?us-ascii?Q?lWZMAmmFp6f/PbvY2w251zVfsKSol+tO40+HC1aCXNeXDpbX4IXCRbbZh0FG?=
 =?us-ascii?Q?IjEjA/2373DHnZ4EOWT6IhYwbGlRicdNttTENUQ6QPeKSvni5erIr6Q0VjFg?=
 =?us-ascii?Q?0mTZdWzvXyC3w0UBu9RwlB38DPk1EC+MRVtiwLDW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5163.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d6e9b6-91fe-46b7-581d-08dd4a96a8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 12:21:49.2435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XklJrQPqioWZaHTpYtxMDJ/vzx/3QgMxqlvjuaIR+sFbWIrBjnLTgzLJYXtYc8abxnVfO/7612+cjkbFmuJXhihx5B22hso81r5y+BBkB8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5848
X-Proofpoint-ORIG-GUID: cKBfzHO5TzWxLbx_qG00HqtCpVpUwVDP
X-Proofpoint-GUID: cKBfzHO5TzWxLbx_qG00HqtCpVpUwVDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_05,2025-02-11_01,2024-11-22_01
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

Recheck-request: loongarch-unit-testing
