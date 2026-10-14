Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE19BCC6B19
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 03:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D39B4027C;
	Wed, 14 Oct 2026 05:42:01 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3289040279
 for <dev@dpdk.org>; Wed, 14 Oct 2026 05:41:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ektfJ9F9K4iAj3K5qzPfsLQwqmUPsxRHU8mgSQTMhiataNXiuwlqFSyZOVcsb+CxVU7/qmNVvUx87Zti5GU02z6Lb5vFck+ZInpOdchDaK5F6qSvURZfrWXDD/9TRtbUlYNE/zX5R0EZPk1ACPj/wl3Oj7O9AldmiBxfgXzyoB1LXaeJFfhN8uRq2QdXF6GZVTq4cuXN/vm5NlJcIjBqSQHYBXGIjrW90ffr8mWmN8r+GM3JPrOCutp4mfQJqfwLdyAD/7po5+NmRisC/Hevef81QmroKE2/ahNPk5w7t7IyFzXrWx+YF9NHRW191ZIuiwxeUZEtK3XOOwt+4tRjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHCh1VRDLWeuszbTQ2y+Ax+fiX/5/lAk6eKwoI7U6jE=;
 b=LSWI3n6w6Xx3cQilncm2fz00lcUQj5YFMy9maEhGAzODwamTjiOF3KO7PZtzt3qhZRdoViWsRQTMvvubtMv1b8q2Qq5+WJg3E6aX0HRmL31O3OuygVjmor3wyfJUrsYOGn95lcTy6hspUtnRsDnQErjeHKIXQVjw0SrPcJNnJDzy964WmqEeVuh4+aHumlvXmrU73e8538hEtdq1soG244n1zt9INNYNE2xNkVUxczKwNauPRQoMrX/MAojEeZSjJDFCwj2Ei/PsUUlC5OS14WEb9X5PyFbHmcwt1dNSiKViHV2/soDGoY019/alDMzjzKqPuYGSxjeo68R6SGNx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHCh1VRDLWeuszbTQ2y+Ax+fiX/5/lAk6eKwoI7U6jE=;
 b=22D6HqnwtRJj4UFFZAK8ULogA3Sa8REnCR/D43gsq4zlPvsF0fg4udj67pRX8QJu9WZk6M3+ftjsNIuZFO7uM4txLAODGco1e87AZfiViTw3nirk6Dh9XkrrtIRj832YDyU9bQxRHDdtchtLKPVWanMTL8b9FASj/RSWp1I9+bU=
Received: from MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 14 Oct
 2026 03:41:52 +0000
Received: from MN0PR12MB6248.namprd12.prod.outlook.com
 ([fe80::348c:4bf5:915d:cf52]) by MN0PR12MB6248.namprd12.prod.outlook.com
 ([fe80::348c:4bf5:915d:cf52%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 03:41:52 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, "Tummala, Sivaprasad"
 <Sivaprasad.Tummala@amd.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Jan Viktorin <viktorin@cesnet.cz>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore
 grouping
Thread-Topic: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore
 grouping
Thread-Index: AQHczEZtVOY6cSir1kSAfnvJX+lQ9bXfADMAgERLK/CAHMNp8IC6QyYggAI9yYCAAPNi8A==
Date: Wed, 14 Oct 2026 03:41:51 +0000
Message-ID: <MN0PR12MB6248ABE923F147AAD0167734829D2@MN0PR12MB6248.namprd12.prod.outlook.com>
References: <MN0PR12MB624886A9D6D326FEFE773805829F2@MN0PR12MB6248.namprd12.prod.outlook.com>
 <20261013130951.3959832-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20261013130951.3959832-1-sunyuechi@iscas.ac.cn>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T03:40:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6248:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: 3b9688ea-287f-4c6e-330b-08df29a515bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FHDJ8Z9gpP17VJRMYA9uFGEA5l8Xm7/0r5iU4u5uZWvHEfSKt7/MEdtw9NJSjk9YJQpqG7mL96wsXfJr+kaz7rtzXAV57KBdkOYJiNwdXZEqCaK7qJUu7FoAEN7g/+V08UGMivhDZb5x5qcpZ1IDnA+eUSAJf/jCeFXeCV9lMuSORudy9R6pUp4cEmrxhVXDHXmewfzC8M26bXdLajB3YtmqKcUYkoNqpDao7Z4FMOarIT9Sqzy3UVglFwie4+u4EnrjReRwmbZyue5LGjbyB8GLQ3d7n1Lc5XkERftKxvAQfVTuYni9KORte9grJrDBuWIVvyFAlNHjHV7T4nqkISW5aRm24BsynF+AJS2pYvXAw1hLB2Ux3OvRarrj3+5KyBNWPapvCQuFUfRwpKDAg5Ps6VdjK2NxNr8NVm6fJe9NuIcoi2HV8tvzFP784Q+q58s86Qjj75kzAZX9JbFQ1tQ98HcK5WFwlSpB9jOD1xwtdZX/ADXux5yRzBW+biZJG/7DJ32StaFx+252M2EQVZygYU+zn/k6tJGTOL+FBnULCpURyt4Ptfmx2h8kAskgBkrGr808W8iaSs9RECeVIenha3uyBRt7zogQZi1BiRNVL2lPOVwOdmu2/X3nf69IuLYRDgOJBCJINR5yNq2zdqXBgec9/fCbA2y7DtLrjfhD1zrZHTiIDAgoiLI0VmBqN4ijCgEuwzVLRRV682RvOAClK2z2aH1eLwX9fQf731E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vw2o39UIKE6F8jQ5jSMDznVqgMCTbwFNreCCcnWrMu21gNzpDJfSPTmwb2?=
 =?iso-8859-1?Q?mnUkVcCMcrBJjzT6BjMThrg+YLjelWAdWQSzjAUUoWzGjSsnInsPx2E7Zm?=
 =?iso-8859-1?Q?Wfjdk9fTuL6s65Jf5VRXg4cfM0fivifvkabU8Xl4M7Ktr85DkBgcHKwz06?=
 =?iso-8859-1?Q?y+Goo4IYmf9hS3udHCNbPcKZ7VUSMcEOBOjqYT9l+B+dz7ryLQL+kf7VJ6?=
 =?iso-8859-1?Q?VtD4iLs5mzItKbBkmFDGl/HKY7FMB0CgzRgxgdhlb8iD53ucQt0Bi8bjVF?=
 =?iso-8859-1?Q?EYkWVvNw1kl+Tg3mA75XLTB1M5L1K0Bnn69DKasKHyqMsA4js7Pn1wsWnm?=
 =?iso-8859-1?Q?Dm42d0YiACYe5KR0zwU1IST0ZVE+JUtxw/CbwIhuCgBecfAs0eH8+pIjb+?=
 =?iso-8859-1?Q?wQtJYqLS0g37GxtCFzMyShi9CAcZek0SayfYs1NYzbeWyIBdEr0IVVAeGJ?=
 =?iso-8859-1?Q?Uy+DBXob9z/B/cT6shzK4vBmpl8O0PcvclTecJfxVzUUWiqcDfdsgD24hT?=
 =?iso-8859-1?Q?3coHpaiY2Zg8TOzg3y6LD1C5484sZPuWMZ4mOQNY9Dp3HdgOC9knmenYfb?=
 =?iso-8859-1?Q?TKU9OACkQiJyrWpdQ5CCb4+/H48MIDJNt8hFzusgjkTsHiy4i2e1Mse4sT?=
 =?iso-8859-1?Q?i7/1z43OkdbCQeN2LYt0CsTHf9T7efPiJ2CnPHioWv77lM8vuZdY6AX/OJ?=
 =?iso-8859-1?Q?6LYpSLiZxdgaX6iChNQiP9SwDXOAljRg/WEiLu0IH16z104LGuHQeiLy3i?=
 =?iso-8859-1?Q?cSWZ6H2q7fTTFg+whyFXFDl51Rbfs4QbdReqIPAN3voHs/C73maKPgjLML?=
 =?iso-8859-1?Q?hlqI09wL9BkCal90yU/JW/YOk7lg0QbOPGxUpt6W6C2LJKOd4+oIJjecI/?=
 =?iso-8859-1?Q?UUpprVfH6FW5l/6+C+Nwhy8GuLH7p1aN0LF1cGFZzY+ZgDV6BBs1k2gtzd?=
 =?iso-8859-1?Q?RCsLrlOZABn6ZqXg3Q9h3/TPBSydPoANhCs8pA8fvT2Z72rjPf0O+ov97E?=
 =?iso-8859-1?Q?X2tNFQDxhBxIJi3GvLGxUxjkFQx8SsANdJzlvLAL+LCtf0IK8XXz8y4ej9?=
 =?iso-8859-1?Q?00VJGvT5Vz01buf0hyex6vR7yxMgYhlk+tqiin4XsB6S2tS8w/InyJnyhy?=
 =?iso-8859-1?Q?U4h7S8OR5Dp77k6HUHWieNL3zkY4zESZHXzbvrVwgymL0v4ma0KwK7bJCS?=
 =?iso-8859-1?Q?OxjpZ86lMMWQvdkNaG0Rh1J+5GMRbwlePAFRqRYtgWPT8O8AaOkb4JNQOL?=
 =?iso-8859-1?Q?UkMvuy6BuAU219u/9XHhcPe4aJ3DwQiH0lGFne/9/Dcoh6ASPOeJR21NXR?=
 =?iso-8859-1?Q?qBKY0imlGY5Wl6lrHn7s9vl6qzeqEkH3O6wLYr3nz80MKvgS+7VTqvpq8T?=
 =?iso-8859-1?Q?FMw59tSWbwnQ7Gb211eJjZVe6WH1LuTITk4TCihv2sd84EglmUOIYvELvc?=
 =?iso-8859-1?Q?1z/JdWNuDFZGvhL3kRs59v+4N/I++Cf3uJkKYDgPH7W/sGBffQl7OGFWeL?=
 =?iso-8859-1?Q?/JWhWvXpUBlJW+jVclUGAb6qGcFUAeApVWQgX6gqnlDuBGVxJsg46mGiZG?=
 =?iso-8859-1?Q?E/XVQO9HHVjuVu57uWoDoiu8/8XkpmM7Fe4wH6fbX2JqD2N1b+EJ856FaO?=
 =?iso-8859-1?Q?YThTzVNBQwjr+t3PgECeJfFOuNlUXAt4qhR/zsciLdSQnjo2lOY3jwZZnN?=
 =?iso-8859-1?Q?+inUWVUVPpN3Zs1+De0zPgb/NGB0ukUoffdmjbR1TMKmq5VhOGjJ+AAqrK?=
 =?iso-8859-1?Q?asw2rb8gslSTg7CX7r/rZvy6wPf9EhO+CGWWi7dhRlr3jK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9688ea-287f-4c6e-330b-08df29a515bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 03:41:52.0491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A42jTZARIm9reQ6dFSoiiNMaJ8MuPjKm4qTgaWrqmgsfCCKaWZuwbBwwrbyR/xr3smGyfTRhOhVns/ibsEQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

AMD General

Thank you very much! Then I will use tag x86 and RISCV

> -----Original Message-----
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Sent: Tuesday, October 13, 2026 6:40 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: dev@dpdk.org; Stephen Hemminger <stephen@networkplumber.org>;
> Wathsala Vithanage <wathsala.vithanage@arm.com>; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Honnappa Nagarahalli
> <honnappa.nagarahalli@arm.com>; Tummala, Sivaprasad
> <Sivaprasad.Tummala@amd.com>; Konstantin Ananyev
> <konstantin.ananyev@huawei.com>; Bruce Richardson
> <bruce.richardson@intel.com>; Jan Viktorin <viktorin@cesnet.cz>; Morten B=
r=F8rup
> <mb@smartsharesystems.com>; Thomas Monjalon <thomas@monjalon.net>;
> David Marchand <david.marchand@redhat.com>
> Subject: Re: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore =
grouping
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Hi Vipin,
>
> Tested v5 on two RISC-V machines, no RISC-V specific code needed.
> topology_autotest passes on both. L3 is detected where the firmware descr=
ibes it
> (SG2044), and empty where it doesn't, same as on ARM.
>
> Tested-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

