Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E652606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tVzsHAcT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3807C4028B;
	Tue,  3 Nov 2026 07:23:21 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by mails.dpdk.org (Postfix) with ESMTPS id BB29C40278;
 Tue,  3 Nov 2026 07:23:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+RX8s2H7Ccb0ca4s3ihSfZpPYhVR2y8FID6D/pVKv0JU3vlUZ1CDE8vDY4WnWINlsJ/DWS3Q/O8fnghjZEol3fQ2sXWAtkcrq1B4aIvxVRgkMZLggkOShoDIpTvcYVirwy+72UKtDjELWAfa288aR4QlBTdkKj/HA0DPAl3XWhkpLCIi5+UUergjDYOExT7h/m79mZcnBeDicYYB2ncXx1NjStMjs3Wnz6o6Tt/1dsHyeDybab0zwk2l9vZRc2DPqpQN4nIEFrisDvVi1O7fKeIh/WqnA6pJnwqNCmrP7fjk8+Idn1Z+6jMI9THdWYSWTL1xVknWNdrb6+9TUqv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xImSeQcvurhYSNsj1FSC8uEdkGBTO1onLXiZNt7jf7k=;
 b=KH/Nhs4kvSxKYDDqkqZ6Y8mfJjBxPFdRSaXgcfn2qW+uaq27FblK0KjvGq5ezoHr0NPN8YIEethBUhbXpswj9Cob8XmhhZkOPI1vNWyrfUFFRM+IUVEsQQTPRbeqKxsEwHRQK/pEorKgriJ6VS5kfNbzZpzDYRlzGXw8Idd75X+cumwSy4LJcHlR9Uplk1FvffMPbOsOdC03QtZaUYOLDpWD7lujdHmjCKNI3CF3NJewA4+IiNiiUEz3HWO4UztPyH62xO2keaACa6OVTK+Z0gVRZJ8K1//gsDPDvl+Htvsw/tmxO43VDH2BEdr6rhHJlvCb2xirngaHQ2lB8hAt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xImSeQcvurhYSNsj1FSC8uEdkGBTO1onLXiZNt7jf7k=;
 b=tVzsHAcTTJ56nhIZjnBFTwZ/1yiEIzc8s8kzFQzVLa9NKEW5Yb4SROxbAOEE8yLsomcCNoNHW9UGzbsuGGf4SegmuxCbGv861OYlr69Lo1SC2+rZ/1X4qJ/KY9Lt9HcFg8lmcY/JNKZugbJsr/45WjJbZMSqq8QvmDpCWdjAslrzo26DBsyuBkG+Lrzap9mgSuI1FO5kd4BuNdvdAQrAmcPGsrtVdV/MZibuPkLSQt+bwhh8RKBwGjpyG+ERBDLH4Jk3yVIHqBZF2+uJq+SEw9JXZEh3IjTN+B36Leo/GBzVJiGiPw/gjF1tA0gC/DdnZFfphvjoAXHtd0r9xTSbOg==
Received: from DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) by
 PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:23:15 +0000
Received: from DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::1b60:4bb5:24a9:4e4b]) by DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::1b60:4bb5:24a9:4e4b%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:23:14 +0000
From: Bing Zhao <bingz@nvidia.com>
To: "dpdklab@iol.unh.edu" <dpdklab@iol.unh.edu>, "test-report@dpdk.org"
 <test-report@dpdk.org>
CC: dpdk <dev@dpdk.org>
Subject: RE: |WARNING| net/mlx5: fix local and host representor name collision
Thread-Topic: |WARNING| net/mlx5: fix local and host representor name collision
Thread-Index: AQHdas1PzM2k6MSbIUOVly70U1200Lcb4e3Q
Date: Tue, 3 Nov 2026 06:23:14 +0000
Message-ID: <DM4PR12MB5342AF236DB03875B047773CD0692@DM4PR12MB5342.namprd12.prod.outlook.com>
References: <<20261102122316.2504667-1-bingz@nvidia.com>>
 <20261102132259.CCB8B6050A61@postal.iol.unh.edu>
In-Reply-To: <20261102132259.CCB8B6050A61@postal.iol.unh.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5342:EE_|PH8PR12MB6820:EE_
x-ms-office365-filtering-correlation-id: 9b7c7aa7-cdac-49a7-bccf-08df3972f142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|3023799007|38070700021|56012099006|11063799006|5023799004|4143699003|261022075727099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info: WvwwlWeokM7UeSNpqIMnc0cqwn+tLj0WEwmBdafScEQjkzkcvOa+cEc6BFxLyctjiL3/FTdS60Nl4kdWaNX36PVKXoaFw7cuLwzafdhWFez/C5Y6OFLEcyAYNpNBmigl1DElRaFK2WSjLLHF1qPG/Y4D7DUkntsXGNaoHbhWRbAiBPYkyrInrEeRet2HXNyVNA+bSYlqD0PTV0AS3HEj70b2NxlX0ILB4ReS7W3MeZ2DS+xii3ZgH6BRe/OKaozClTHokm4pLHVVIzE0d21r2v0AhNKBKwHC3Oa/Y/RdpkKa823Ae+ah2hPDzd/5u0fN4kgRVs3I1zt9M0oXJJukcpm0gBsrgom3WfQ6DRMSKoVHce5zImH3V0OG18sggayAf/c67Ft4moNCpHWjQxJsMtTy3VZDVp1JZ8hCun2l9MKW76mSh4rjwbbqjnC6b4qqPPYJPVCICjDjpRW0P+qXVX2MG3hsWZMgOWyN4/vw7H9e8SeiOicKJ7kvLZyKUWTdiy6xpJ1SC40qkGmBZ79EmVZpjjEopKaN7sDcEdqeBg2gccFvRx9GVjWtBZSkYkjOdA8F3Kj6UgGBNqRjxs84tKEIv1PDggT1j0b2lai61rRpOJ+56sQ+7TykhumKc4F+lzg0LM3fbk57juGrmcdCRCCnRyE55R75g22IKaOsrjmUcvMGOjfM5ySJs8kDw1RtdYOIAv6WHxU9YyVpuKx1AxLswY/PioS8WFc+z0/avks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261022075727099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ejri+SHbI88UxqrMVus5wqNKg+L+70d3HZnZY2FnVz3Z7GReZlNhKA3/NO3P?=
 =?us-ascii?Q?nyiKCT+auOypf7xtxG9jBDs0T1G6OD7qnQl9N6uVr2o9J9e/mZYzZdq9R6Ml?=
 =?us-ascii?Q?mTGA3KJmuGacgIXpNW+c6aMlgguCKDR5kKw6zHsfvyvU8lkDHn6pOCrO8BSu?=
 =?us-ascii?Q?w5R7qtY/6XUlIGGZ9nXqAAYa475Jir362+s5FmfnACvYf85x8VjdtgUpuXiI?=
 =?us-ascii?Q?Yp0wphZS2L4DCNsE9PtCeVOnw4UFUOIv42rQIo08tyqc2/Kho3M8T2IJyDgc?=
 =?us-ascii?Q?1XDr/y+D2A+ZeOFcS13qgdjJnQe1DFX3lI7wgi9FEtpRDxEEOmJH50s1JsC3?=
 =?us-ascii?Q?yeWHGthWt1teNL1ye77KYWTOwtpYVSF8KucGT6EzQdrh+k6Dkmk0pJNmsOG9?=
 =?us-ascii?Q?tcq95bTYLpdva7zDNGPr5veyZz7h3gdEoBlBZufgF/dNOHyI1/LcQmbaGnNo?=
 =?us-ascii?Q?4PJ04ycS7tePGcIepRDAz7r5BbD4kvtmch+7mVv/rIrUOWEZwVdY15LFV/kA?=
 =?us-ascii?Q?vyho4gKEE9imifMp6NJAsHwgQZSHWOR9vXiweaROTUiijrTaSFXmhfJGOpT2?=
 =?us-ascii?Q?stgNZeJTUnBpl8cwloX1xTBWOaAxKrEPyVPgC2A1X1c6ilgOxMZWE3ooZiNt?=
 =?us-ascii?Q?Uii9oeltDr/PmE9MEmkQvpGAjlq74TZKTHun8/8sG2kFDoHhjPhJ0knthrWi?=
 =?us-ascii?Q?W0Ei754ok6m8TQFHQwaBCgAwvQ7eFWLfGwd8z5e4TAwElndIRMSPLawquCwS?=
 =?us-ascii?Q?lgOOoqCUAU3QkdnD6dFi7gOjWz2iefARw4fG+BRAB2utI3ehxhEN4QUVxalV?=
 =?us-ascii?Q?OC1EF2N2GO++OlU7OCpuPYOL5pNfQsPwVISZjxKm8HkCSWjYPzEzQgQ49WKo?=
 =?us-ascii?Q?WQCOlGg8+x20s/yWjgo3GN8+iIxfaeki3rzYbCGMl+vFLrlZmvNG7nQTM1br?=
 =?us-ascii?Q?nDjKbo8as6FenHEWC60pYH0VVR98v+w1qcG0DqtemahDrNnjnZj348nMfEJw?=
 =?us-ascii?Q?g5VGoL2OyvIdMakLaGUdwRoGxPAx/IKB1AwicEtTl7PkD5ATKkj+ifKS3NfL?=
 =?us-ascii?Q?mSY4piKy1RDrmpJre9W0Dg+WW0fyBq0mSr2NDHD4mCcuICwOEvXIFUIwdfyq?=
 =?us-ascii?Q?FCWqpXkzW0AvopaHWfEl7bFl392jZ3+bpruCugUIusjcAAaD3/cHu1O0FD5Z?=
 =?us-ascii?Q?PRxtOTek2lnEL8C3uD3XGoUD+Gmc7Rc3XbYGAoN2pezz1QGIQ40aGfI19Z6f?=
 =?us-ascii?Q?3scPTaKko0C9qe7ODnoYi97/IFyrlSZxPoeZIRgImCV6qLrWeNkQXr3/cdqs?=
 =?us-ascii?Q?vn+MXR0213pCjJaOjgSFWmlBa+/k9pINuWffM54MeLpV5WCW0Y26PacXfzLW?=
 =?us-ascii?Q?0xuiLYnA/gGCsX9O9V/Cb3ZrETneLKHycb+C8e2PJN0oWjAdHZplobx//DIw?=
 =?us-ascii?Q?OrrCzqBP7KQemDF20j899REZHJA4MHLeXk+I6u+tURa/3LSlI8WKwkq63n3n?=
 =?us-ascii?Q?4KdnLhF5quXLD3xLTnHAFIHsi67GCSBQrgVMb0/3AjVHqnTF7hhKGbHVT6me?=
 =?us-ascii?Q?zad8L+4cb7P2AuYqhervtnaqGGMjRf48SWt5d/WXFEO6vfHp/xyjKhXN8Q8S?=
 =?us-ascii?Q?ZfD7AOUR7SPPu9XFlITKmBa3+Vqb/yx02r/+0NVDyqoWAFFDs0xco0F8QaAa?=
 =?us-ascii?Q?MNPn9eyY38iEZAhVi4DeH7EQL49Xu+RhIIt5PKckBLbfq49c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c7aa7-cdac-49a7-bccf-08df3972f142
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 06:23:14.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ql4HR2D/9xtg1kboucwJ7RRp7GUw8Xgs96iE4RmFK9JdXyLNASZKJTtp3aW/gGQKZW6LEAQPFwGtPpJ31tDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The  Review-Result: WARNING  on patch 172348 is a false positive. I checked=
 all three items against the patch from patchwork and the current tree, and=
 none of them holds up as written. The patch applies cleanly to HEAD and th=
e patched  mlx5_os.c  compiles with the flags in  build-txci .

 The review's findings

 Warning 1, missing release notes: not valid as written.

   * The suggested entry goes under a "Bug Fixes" section, but  release_26_=
11.rst  has no such section. Its sections are New Features, Removed Items, =
API Changes, ABI Changes, Known Issues and Tested Platforms. DPDK doesn't l=
ist fixes in the main release notes.
   * A new log message never needs a release note.
   * The patch is  Cc: stable@dpdk.org , so a 26.11 release-note hunk would=
 just get in the way of the backport.
   * There is a real point underneath it, covered under "Real concern 2" be=
low.

 Info 1, bounds check on  ctrl_num / pf_num : invalid.

   * The patch only changes the condition. The  snprintf  format line was a=
lready there. mlx5_os.c:1138-1145 (file:///root/dpdk.org/drivers/net/mlx5/l=
inux/mlx5_os.c)
   * The output is capped at  name_sz - written , and truncation is caught =
(mlx5_os.c:1154-1155 (file:///root/dpdk.org/drivers/net/mlx5/linux/mlx5_os.=
c)) and logged (mlx5_os.c:1352-1353 (file:///root/dpdk.org/drivers/net/mlx5=
/linux/mlx5_os.c)).
   * The fields are  int32_t  printed with  %d , so nothing can overflow. T=
he item also breaks the AGENTS.md evidence rule ("likely bounded", "could p=
revent potential").

 Info 2, the NOTICE log: should not have been output. The item ends with "T=
his is acceptable", which is exactly the wording AGENTS.md says to delete. =
The log itself is fine:  switch_info  is in scope at line 1324 and  port_id=
  is  uint16_t  printed with  %u .

> -----Original Message-----
> From: dpdklab@iol.unh.edu <dpdklab@iol.unh.edu>
> Sent: Monday, November 2, 2026 9:23 PM
> To: test-report@dpdk.org
> Cc: Bing Zhao <bingz@nvidia.com>
> Subject: |WARNING| net/mlx5: fix local and host representor name collisio=
n
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Test-Label: ai-code-review
> Test-Status: WARNING
> https://dpdk.org/patch/172348
>=20
> _AI Code Review_
>=20
> =3D=3D=3D Patch Review: series.patch (via Claude) =3D=3D=3D Review date: =
2026-11-02
>=20
> # DPDK Patch Review
>=20
> ## Patch Summary
> This patch fixes a naming collision between local and host representors o=
n
> BlueField by adding controller and PF indexes to local representor names
> when a host PF is present.
>=20
> ---
>=20
> ## ERRORS
>=20
> None identified.
>=20
> ---
>=20
> ## WARNINGS
>=20
> ### 1. Missing release notes update
>=20
> **File:** drivers/net/mlx5/linux/mlx5_os.c
> **Issue:** This patch fixes a bug that changes user-visible port naming
> and adds a new log message, but does not update the release notes.
>=20
> **Why it matters:** The naming change affects applications that rely on
> port name patterns. Users upgrading to this version need to know that
> local representor names will change from `<BDF>_representor_vf0` to
> `<BDF>_representor_c0pf0vf0` on BlueField systems with host PFs.
>=20
> **Suggested fix:** Add an entry to
> `doc/guides/rel_notes/release_26_11.rst` (or current release) under "Bug
> Fixes" section:
>=20
> ```rst
> * **net/mlx5: Fixed local and host representor name collision on
> BlueField.**
>=20
>   On BlueField with a single uplink and host PF, local representors
> (controller 0)
>   and host representors (controller 1) with the same index previously had
> the same
>   name, causing probing failures. Local representor names now include
> controller
>   and PF indexes (e.g., ``<BDF>_representor_c0pf0vf0``) when a host PF is
> present.
> ```
>=20
> ---
>=20
> ## INFO
>=20
> ### 1. Consider bounds check on controller and PF numbers
>=20
> **File:** drivers/net/mlx5/linux/mlx5_os.c
> **Line:** `spawn->info.ctrl_num` and `spawn->info.pf_num` in `snprintf()`
>=20
> The controller and PF numbers come from the device information structure.
> While these are likely bounded by hardware constraints, an explicit bound=
s
> check before formatting could prevent potential buffer issues if the
> fields ever contain unexpected values. This is a hardening suggestion for
> robustness, not a correctness bug in the current code.
>=20
> ### 2. Log message uses DRV_LOG(NOTICE)
>=20
> **File:** drivers/net/mlx5/linux/mlx5_os.c **Line 1370-1371:** ```c
> DRV_LOG(NOTICE, "representor \"%s\" is already spawned as port %u",
>         name, port_id);
> ```
>=20
> This is acceptable. The NOTICE level is appropriate for informing the use=
r
> that a representor probe was a no-op because the port already exists. The
> message provides useful diagnostic information without being an error or
> warning.
>=20
> ---
>=20
> Review-Result: WARNING
