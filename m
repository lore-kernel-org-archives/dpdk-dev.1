Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5BC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 00:27:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E321C402A3;
	Thu, 20 Aug 2026 02:27:38 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021076.outbound.protection.outlook.com
 [40.93.194.76]) by mails.dpdk.org (Postfix) with ESMTP id 0F44D40284
 for <dev@dpdk.org>; Thu, 20 Aug 2026 02:27:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE862cE7jJ5GVmWSweIf1z/WaF6z0yuX4oyzwO2B4TUYTQmNSOGhlUJ9dxyUDrixx0aN0ZX8zO79tEoN6cK/7bkdYwjdZTW524Xu2PdcWlmZwohTHSHPNx028Zz7VdRB+GlPV5uP8cxO89TuQLUhwfWVQ0ikTSxZtQFjEiUN0jss3QWU0GS+DzX9RA5Quak0pF/4OVltw/fN1EbotTU5Q68nwvOOVem5KAwuI9Rj5NyNadgzqUlQCxr9S7XxeKHhMXgRFqD84LDLbb74nG2hB71xzLODuzqU6ahae71prRZMRf0cY9sfhQVpW8Ufnm2Ro0PCahdYfZNIVF6lgYJFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag0rjsD3SIPaLnkwPckdC0ehEDyWIXLhzYp0PZkWgnI=;
 b=vny0Ax+TixaaJHOBvu7l/DPyh5nFi2VcUwRerZONnIQ2LUqjyFRUlFBVSZ3F4kzoTornYdCqz1OJMmvlrf+5xk/hS9pXdE18YMf/7asZeRJ0z3eNniJDfaWJ5giTMiiPp8f8Q+YOOIbsFN3w9Cfp7lZqiM/8IjxkA46wgMpYmEm3JJXr/bMr8ut4YWAxltuTOogp1VRz30zXYlWqhPRtf28xgT+WYkKL8B9rnvcBD5f09zoF5t+v3XdOSy1ZvBdC902VBXBvQ4yunjSU6dx3J9yk42GOu364ZU+mxOUxLvkTsP0pHvL4sgfPUmvZUiKUu1LKjhofJpsVveZTr5xOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag0rjsD3SIPaLnkwPckdC0ehEDyWIXLhzYp0PZkWgnI=;
 b=MmwLxI2/HB28UGSX/+bclpM0AU9MfdTOhfC3xCb6MVe9SFgiD+rf6g20O1CRnrBRQFHD6FaXGIfc+YBX8HX12gWwZezfXwHIPt6mskJ7OU6ZKCbT2ySCcXHFpk3T9ZCGVf14osDOyvWX89ddSr8zgoGKm+ocnQ9p4Qt9lWabv9g=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SAWPR21MB7001.namprd21.prod.outlook.com (2603:10b6:806:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:27:35 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:27:34 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v5 0/4] eal: uevent overrun mitigation
Thread-Topic: [EXTERNAL] [PATCH v5 0/4] eal: uevent overrun mitigation
Thread-Index: AQHdMA5xdavNyHaHkUa5WsgogX6mdramFQhQ
Date: Thu, 20 Aug 2026 00:27:34 +0000
Message-ID: <SA1PR21MB6683111D3B9BC1F0AB2F0352CEA42@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
In-Reply-To: <20260819191036.679330-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ea9e1c3-5cfe-4763-a79c-97814b1a132e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:26:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SAWPR21MB7001:EE_
x-ms-office365-filtering-correlation-id: 79b4b385-0902-4013-bac8-08defe51d4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|7146999003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: X3cXpom1tTCyeqedu044jLLJLT5GJ9sZPu40J4eRmWfMXt1n3PcLA2X2rhaC9fjrpngGrm75Luef5usQpudYxxwL5FlzJxrGsKodTbDvXZyC6r2FYuNbcFt40uUu6dFOJusCgS88keLvg0Co7fJB4HgcTyUeTZXjdiPUtvuyObKR+PoK01va/BmoaJcgIuTG+m2QTg8VVkyYjVYiKG/pcCpqOA3DtrRm6IDzwW4AHhVKw9JC6SQdFl7GPdk7hr7TPyJgKaFWblxXXbyFV2xws62ruqxVPEvyESLRAgEP4D3+PH8s0NtpS6VJ4UYkRo4j2NOXXxkcnU3/J7GXWX29y96pv7EBBIuSr3f8IeXVfYgfQVxWt/fPNPV3mebhjjy8DgT5qCUxIPK7uDZYDZnT0zNP6jVGZHuxZ0D6VCT9xcNFydiCDWmQ/VvaQSZj9FHtAuBY5XelFnTD3Nb8mZN24Nz4Q0pRjpHQhGFVpvRugJMjy+HnaysfRMsCPpV4cL/ObMZqUOGl70KfYTC7xUdbjE2bjMQCoRDncUMl1PCW2OWSSn7dRFJRW5tQ/RDMSGZtNJBhjKIRsoce5/qM8+WihuCcwgIvC4fcU4Vai9b/yRccdJ2S5cbPf4XTYj7HOQXQ+yBMCKxDit5tmwsmHnoPqSqxR7lOPNpW+c92wTBgarY/MKhadpSihixdlx4RlkIMaeyImg8yYen7GaWqfVSRCV1+MzIREMA2C4dCo32pW+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(7146999003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEtb7RO6bCKJIFbm0wwdh9DgL3ayfaYVjA0Bn6mzxYkab6C5vFqNTkR1vM+U?=
 =?us-ascii?Q?n5I8h2BZpbxG6JxLi0MvTlTorOYctfVPr9vGkL+yPY0zo+GgiwL7u/hC1PRH?=
 =?us-ascii?Q?lQro0LmyH540kji0PgpDPY7qyTHSrfSPfRJo7W8wWLh9kA7aeyB+qHJMJHC9?=
 =?us-ascii?Q?mEpzD2KWs3XlmOi7F9CLl7KC7dT+0eSwUvm2i7ufuNPTlbEf+4A+d1VOs6gl?=
 =?us-ascii?Q?wM3V7NX2h90XPwGRxcoUcPDYAymqxskuCQCGhPpdwd1Y2ArVt+NlOP+MM7Mr?=
 =?us-ascii?Q?BWZe3hfsHfEd3kpA6taU5hPBXCet9MigoKmEmWPSP99Lqk8yjBw4LRBrN8G7?=
 =?us-ascii?Q?ljYWPM3Iz6fsIyzRcxMzamPpTwsX7wJd3KA9lmPWx7L4oZtccdwmcUfTcwlT?=
 =?us-ascii?Q?YNoYm+JxTr9CLXVr7MATxWZnPlY/ZEGdYHkUSA1PuW4T7rqsduSBcAoJlpPp?=
 =?us-ascii?Q?qntRZVZ62cJuMVpy9ThVTLE91zWXdXLWtiFarnrpmbgJ3VQQvDEjpePYNIW7?=
 =?us-ascii?Q?2KCC18kCRAYirp3cdoo/iru90l6fL0Dz6z40+kuyitKzOt84xLozEwunAf/J?=
 =?us-ascii?Q?sUdV1PZVxmJ6T2PCNp8SdhA2OwNIWsTeMp7nTqRrDFFDOoJooK/dUqGwexR7?=
 =?us-ascii?Q?vKHS5HOQu+mXw0kbzWlfXl3+uorYjI4FLYnNZTezWz4yQ0I74ggKYOPT1oln?=
 =?us-ascii?Q?obR8KvFjyZkmmP4Pqppj1u7b2ifQ4BiJN0aIMoBlpqZftnUTsc96F2GqBO79?=
 =?us-ascii?Q?Aqa1P6z88MiyD5or52vp+6vmekJAmc3GPCU6uWPx8l7FL3FE21UqYvCKGsgJ?=
 =?us-ascii?Q?25ye6/zTurXOZy5VFwjFPJdcTFqUMq57x4l8SHuRo3ILujC+DTGiMTleleK3?=
 =?us-ascii?Q?VD/V6MyGivgqXcr69Dw3T3Jo4eqZkUeM4q38kqdfRldkDlhUWS4oqVTeYGVA?=
 =?us-ascii?Q?bijuaSIClCCOd2mTSs0vdg3hGpV/5AyZJrL8BLTUXQtYU7T3GNTqzJ+jUJGd?=
 =?us-ascii?Q?tKoe9wDMZC149ZdXEhUrSAYMCsJwPFoh7i5YZ0XDqdUwPHOfpbowN1VPdKAP?=
 =?us-ascii?Q?ONHA2la6Pjy8Tcl2D+AcVeFMN9qGnz000Icv4B7CgEzf+GssvB+HI40f+TWr?=
 =?us-ascii?Q?UPspUUD0c78w0GOMBOcvLy9VAJuM6gy0WexzshbQ6Wzjf7lnLftCFfiHuVcF?=
 =?us-ascii?Q?fWOgifWmYy3vCLUVJ4DLY41lJtO+TqRihiFgKXBMSxrUz1KnioY1rjAwneD0?=
 =?us-ascii?Q?zvyy5OjYNfcAkCbnO1BF6CHLL+u98Rl0F0s4q8ypa+pSZfAhAx0hS0HcNicf?=
 =?us-ascii?Q?GdxhjC5LlIaeeUD51jPtRpYq93vtUnG18QMpqf/Exq+pfsO85Cz51ci1xlwz?=
 =?us-ascii?Q?WZnneOUFausIhvN7L+hNEPmyKYdfFy9H6HbTyteMyPJrE6oWgjafIoyEjfK2?=
 =?us-ascii?Q?EJsFUxUh3BajonIPo4UKiDRqIH6/eFFphtTV7nGNy1CrjZueIELn0zH4t2Nh?=
 =?us-ascii?Q?w8fIKa3HUaLKa4MfN2jJATwY3D6xwUEeh0FgJt5BuWiv+jybqMv7Iyvbs8wo?=
 =?us-ascii?Q?B/yGu7A5WkTdsX0ws4mjd0hiAUG/8S8Zz9YY7RkwhI+kKlUCbag/JIKW0uje?=
 =?us-ascii?Q?1kB0eaqD+UCa8zhriC9IyZaFzolABp1303ZxEsF98JPD1XwRDzZrqGfshFz/?=
 =?us-ascii?Q?unnPOpRA48gjWzb8Dz7Y+QeDKc9iWngDVhMM5o7Hud5clkcZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b4b385-0902-4013-bac8-08defe51d4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:27:34.7367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMjd5Ted2gzdI7z7MRLc1Ibvvh9hiP7dobpw7K400/yRaTlX71EY8Cq+90opNXwY9r4uZ3NfZjO/miGr0OOIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR21MB7001
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

> This set of patches is an extension of the proposed patch to handle netli=
nk
> uevent socket overrun reported by Randy Tice.
> Mostly impacts users of Azure VF events (MLX5 and MANA).
>=20
> DPDK uses netlink uevent to track hotplug events reported by the kernel. =
Since
> this is a one-way non-blocking channel there is no fool proof way to prev=
ent
> missing events if DPDK interrupt thread does not keep up.
>=20
> What this series does is:
>   - use netlink group to only receive events from kernel
>   - increase socket buffer to have more headroom
>   - report the problem more clearly in log
>   - document requirement for control threads

I tested the patch series for MANA. The test passed.

>=20
> Stephen Hemminger (4):
>   eal/linux: filter uevent Netlink in kernel
>   eal/linux: increase uevent socket buffer
>   eal/linux: report uevent socket overrun
>   doc: add warning about control threads
>=20
>  .mailmap                                      |  1 +
>  .../prog_guide/env_abstraction_layer.rst      | 14 +++++
>  lib/eal/linux/eal_dev.c                       | 56 ++++++++++++++++---
>  3 files changed, 62 insertions(+), 9 deletions(-)
>=20
> --
> 2.53.0

