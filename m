Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC1C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 08:08:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A708A40268;
	Mon, 10 Feb 2025 09:08:03 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AFDF040150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 09:08:02 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NUsFA026663;
 Mon, 10 Feb 2025 00:08:01 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44pw2r1att-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 00:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3Gd9KS0RJ22VllfCAdsp09Kn1l+DHjsuKuqz3WdyJjHV5lJkvkvR08uSi2Sh9TwWrdujuqF/Y8XmL5cCT8MylT51M8ZR/uO/oVG7wd6mDV9bBon6530/JRBg6MWQ5y10akgX1vBb5ey8FVqYRBKVmLPUbgMLeexsKT2BWn6zge6dTKk4L1N230iqobc2/9SsYrdYF2CO50LrdKR0ZIvmzg14cjAKh3OQjdkP0a1M9N2o955CZ8MJjogLHTIILqS+lMFj7XZyWVJw3wsGQNKUa1eU/ZpTNdKlzL7X0fBQCaQtud1JNACo7cEMU2QctvqurIEyNqL23sL2jwnYsW9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nd32iOdzbKIjZup+Mf/FJDKjSnfNwk6jhOg91M6rYw=;
 b=G+E6Kjs3W7xDNd7LyIX3LBYSWzsRVSaXnz4/fnxfyaOLdn0zN7ah54c2Z5wSZRc3zvs8BzJlO9ATChAAS42k4ogbCoS8EMGvjESLuJfWH+PsA8SWsfsLbVkUB0aBtDyxZ3yA44rXdn2/mMyCmvLtXG8pGmIHhCjwmIhzD6+Ca1TdiC/GMEq/ZsUFhfYXNL9MRTXjnsM0oizH2jvDHC7cwzpBIbWHgivOXSZVq2Vmnh/Iw/OVFuZ287huP6SicTQrNhcRETDqFQuJXPp6FWf3SplK6PQyr84Xvvp7hHERxWXLl+YEiBOAjyQqGCWnO8Qs8wdO5aLD9tdtTn8Mc0ZfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nd32iOdzbKIjZup+Mf/FJDKjSnfNwk6jhOg91M6rYw=;
 b=V62Xf9sOsyePKC3TsESl0jR8xAoMBco6VUI/b+NyrnKqkIoGxZtsnBsouxGmPf7HN65QXFAzqdAsKK8j/k7+6YCI7avMRy9LMtMse9/74nQ6lEF9azLFjSkZWwV6yBHnb9h45ut2N//CPcgaE+JrKfpDwtdgeoSProVeica5SoU=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by BY3PR18MB4689.namprd18.prod.outlook.com (2603:10b6:a03:3c4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Mon, 10 Feb
 2025 08:07:59 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 08:07:58 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
CC: Tejasree Kondoj <ktejasree@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Topic: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Index: AQHbeWaa8VtPzyIXOkmfXxn065HhbLNAMuFg
Date: Mon, 10 Feb 2025 08:07:58 +0000
Message-ID: <PH0PR18MB4672E93B78781B63C57D493DDFF22@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250207134545.63820-1-nkaithakadan@marvell.com>
In-Reply-To: <20250207134545.63820-1-nkaithakadan@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|BY3PR18MB4689:EE_
x-ms-office365-filtering-correlation-id: c1a7578c-d4a9-4f77-852f-08dd49aa0838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qRj9TFAEOt85kH75vsreHHUIl8PdaWEwRdYlzZjOydImn6T0q709T0LDjBG6?=
 =?us-ascii?Q?J1UWaSipQdVoT/fxOebr7XbuHsZPJFoyHc5EMXNGCL8GjoR21TGZtCVUhA91?=
 =?us-ascii?Q?1lNnfeah2Vx7lnK7eMaXKtmTgOiobfcyOQ1zc80uZC/L0BjQpayTweYZMfN2?=
 =?us-ascii?Q?El1dRSTOHqoIowFYgMj1owrw2Tw/f+aApJ6Pdgh2DOuG1UJu4ZpcJPb6CRzl?=
 =?us-ascii?Q?js3ngxd7BnIiMTh7x2zL94D7dF8/LvjHOKCk+0ZKnPIdWCWK7kcFqHdu353O?=
 =?us-ascii?Q?iWvlpBidgBaqg4yjm3rTM9sF0JfrSwbJw72H6YcdrRSDx0bZdCqOTgspV8f0?=
 =?us-ascii?Q?h+eQEe57pxZoHuqpKX+YURe+ebuOQ2aW/x/DW5pdD6qUXge0pupzAAsVCS3J?=
 =?us-ascii?Q?HgRMxKhKhqy1fGnSTaJMnALARK63N8C4I05X3PnBiene3SCcPISmhdtWzV/c?=
 =?us-ascii?Q?Szd2+elVYkVZa2Bx+JzPVoDd/Dkf6ixPCf0mY5DgsyXQRQRc6g5nL4mijmmx?=
 =?us-ascii?Q?LcDCvh9HfG/Nnr0UIEVzBOG20zNzb/IYjTL8ty2nPAgEzTq4ZxCx+7YoAbgK?=
 =?us-ascii?Q?7Onzryd/ENReEfZrHaaNoYyESkM7rAvWJzJ/syeNFbus6/3u41hJMrFw6xx4?=
 =?us-ascii?Q?U5LXarHqHdMO6FY8moR84+ZHWDH6gtBmjeyyr9MUPtfRs0H2KTI7EghIZGLf?=
 =?us-ascii?Q?l+65BMBc8iTLeKnjdus6QhtTXy+fZV7kMw36Bfqrpc86JtN25YGff7Ehbqj8?=
 =?us-ascii?Q?Fpj0PqeA8ZdSDh17cB+zwoj5qCJB/uTQk2HtksMsbE/8h9JJcSTPYgMrl5JD?=
 =?us-ascii?Q?wdY58/K/tbD0e11qXmQCs6Q3anAomsDhxknvtu2MCIeqxKCrBfW2gR4lhuhO?=
 =?us-ascii?Q?vtL+cr6hAhgSIbQtDokyISTvVnNTHLbY4NRZDq1sjTBoIAXtdjaYb4997JDf?=
 =?us-ascii?Q?dzh15WX+tbhYNrJ+4wJ+2tw7uohkPSdjoSeljSrAShFAvjvKV26y7PyMIDWc?=
 =?us-ascii?Q?EXQizzpWqBdKHadIXQYa53zdojZHV9MwP1JRXVLhqZ4+D5I083XssBNww+t3?=
 =?us-ascii?Q?OYpaneGaSFoWLvrrYS3cSb0akO0jvgVC8rdUSj7RaRxVCcWp+Yw9YbUS2VBL?=
 =?us-ascii?Q?/fAZz1qGFTGoG1OR3KPKw6a9x6voIkbMHgyYpENnvrEHmHVmzWw/qw2YmWrO?=
 =?us-ascii?Q?ADtGXLNrTpkc+V/A8dxbsQxYIkYiS/TbsOG3yF4QflgDI1+rDA+5tsnKbaGt?=
 =?us-ascii?Q?uQiHeHVoHqdbnJSvLn7NB9bQMz3WO+qFka7TYF5YixN1ZGunQX90W9EgTLKR?=
 =?us-ascii?Q?JbGcQ976bDZ7ezcO7RZrwHBrFh8JvVbFmJ2uqwh4i6wOYP5NTnSJOjgLG4OD?=
 =?us-ascii?Q?8J7QXmtXwR19AQ62/tTeGGE9oVN+v3Dbv7tyItYpfX4lisrJklqUK4r0+Qqu?=
 =?us-ascii?Q?Lsit+QxafgX61T4NX1UoO94PolX8YpXJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IjVNNgbXpJJxIcNoBoJuFrmE70mNp87QB7dLb6+J185DWIngaP/kDRrcSlyc?=
 =?us-ascii?Q?z9SwNGhSQAIN/YZpDnm7gKfPONgLwAum5F5bRcBvPefStiz5X2iICPHrH6n3?=
 =?us-ascii?Q?YUS6PIi6lhfoTqA9Rc7vlt/IFmJFn/XmYTtqBAc4yK5uGUERbW3KCq4aGdRB?=
 =?us-ascii?Q?hZvZ1SaB7j/A2r5Jy9dcX3aGqYuVUAm+5Xn3eaNJfAFFeHnKqdYR8tE+olLP?=
 =?us-ascii?Q?+cdgYwyM3VfWMHK631HQDA9U4zk9O0GQf7OYKmO/gLS6VzUFortngtB5wbGF?=
 =?us-ascii?Q?5C48T2rj8GS+GteomWXHR+CS2DMfY+up+VtSZd3XjrKXxl0Ph1v3yjyZv4K8?=
 =?us-ascii?Q?cENk3ilSBYvfNQXoYNDkqTEETrF2na3LyPcHE0STKZQ8zYymC1wZhpxF3tIX?=
 =?us-ascii?Q?8nsvmZA7jHyrl8m+mflP+/UsxPmB6OW627A/vxwC4IgmyZcxUMjgJgYy3s9C?=
 =?us-ascii?Q?tbnJajia3RVdApCKJKrLLJBOoVxh29oSUr/tl6zjlcTqsb0zleC5qD4eLZgE?=
 =?us-ascii?Q?Ch+bfwkOiGyPKPdjIp+9qZJHrrbwxCInbF8iUcTDhSPygarRXWhQ0txYQhpk?=
 =?us-ascii?Q?IzOmfCGckMhA5QV0dMTq3JTrqmLZYZAeCvQwi7Y6D0s3BYZlb283L/Fh8qz4?=
 =?us-ascii?Q?aNHxs7c7CCtFiEB+9hiImdmpDUHVzOeoBtMhXRMLgL268xX8H6cvG5Hf8wtm?=
 =?us-ascii?Q?unkmXHsD4vITC5QJzf3YykbN/KFi4EWyWprV4Gn91oCARxSful9uQm3Fp2Z6?=
 =?us-ascii?Q?um9PwzFlvt852Qrp2wAT6lpAYsL0OA5nhjDEUpR2o9r9ziZPoCULQppnzK0u?=
 =?us-ascii?Q?z8YoJaJoYaDJV4KGH5p/S5AKXufg5WjiIDTtop7A2DQxXa3W0rC/zQ7MwF9R?=
 =?us-ascii?Q?Nk0i3Zwv85CsXanoH5MdF8qoWUjKaGXRw3oi9Z7ttyfzhUFavCjTveY9Rced?=
 =?us-ascii?Q?+ZHx2KKpIng8vUpGT+qqzZv0X0PTC84RpjU1jaVqRTRTIQLfK6+P+5ekLNzJ?=
 =?us-ascii?Q?0ltLgVwa41ljIte5i+UbHV/81CiPft2Clc+gvyk8yOMKq5YlCH5yzIqV+gCV?=
 =?us-ascii?Q?6/Hra/o5oiSCj/FDJWZB8yh9RCK4ENIotSfjexR1FjYKoiAxBg0D8/RColCq?=
 =?us-ascii?Q?ZwlGej/yAUMkaCiFG6t6yt7yTXaWmT7MzJyPLBdil8DCSJweVAzdtfdGzxG9?=
 =?us-ascii?Q?nmhKtpcgy14AaLNzc1p9fdd9x6jegXv+ldWHjdXLDgefgp2Jx0oQfdeWEPIP?=
 =?us-ascii?Q?uPInZ8n6KleRsC4Dc6CMTUOCBIFwAlB1AbBnlPQcD1Etsu1lfHZ8HmrtpoA8?=
 =?us-ascii?Q?RZyKqs4IB3Y3u8SjhZCc2MFgTjWALjSqK0hk3F0AkYSwOHKQeGN0LG+4oI3e?=
 =?us-ascii?Q?vaTvs2diggesrWuWLnrMHeZvalgsU5rHY3KE4b/oakEmb1irJ35dUx4Sg2/R?=
 =?us-ascii?Q?fr5tX7wXVCm3RCKx3QBru0iaJg3Fi6Jx2QpcF54nSI5oYn5tCqWv857GCYC2?=
 =?us-ascii?Q?DFcX3ixeCv3obyPU73zK//7jhOly6N6g+1Z1guHZ3N/JJg0MVbfyVhoifqQI?=
 =?us-ascii?Q?CNfVA5o2/b/aRzTyKns=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a7578c-d4a9-4f77-852f-08dd49aa0838
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 08:07:58.7253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0vbqXnA5dY5UKjroEDWMTBJWNb5kAIpTh6LuaJgoadk8N4JpaWuuwAlAt6KS0CrDeNqQObBzjXxqAd2Ay6gSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4689
X-Proofpoint-GUID: Z9prauVwcXThGGkOiDOfYDVuq_UzrGS8
X-Proofpoint-ORIG-GUID: Z9prauVwcXThGGkOiDOfYDVuq_UzrGS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
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

> Subject: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
>=20
> This patch fixes IV length to 8 in case of AES-CTR 192/256.
>=20
> Fixes: 9413c3901f31 ("examples/ipsec-secgw: support additional algorithms=
")
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Acked-by: Anoob Joseph <anoobj@marvell.com>


