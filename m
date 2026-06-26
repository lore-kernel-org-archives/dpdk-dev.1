Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013E8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFCC40613;
	Fri, 26 Jun 2026 20:20:38 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023110.outbound.protection.outlook.com
 [40.93.201.110])
 by mails.dpdk.org (Postfix) with ESMTP id 7038B4026D;
 Fri, 26 Jun 2026 20:20:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWlO1BzCkJqLons1NgurmU6rsuNoacq3ITmDvRufJ1kItjdJxDrvhZqJvrgrD5kkFlhC/SwjoAEfBy0OONL5SYXg2HmIOBvGzMXOd3MuzeX+uyPAqpdxF0Hqjx8R1nl5zJ+s5mPF9nNFCsA2bEI0yABisVqzGlNmFj9UEIPnsQtu1mO3+5TXmj2ePEbIUMw6BITaX7YrkLaxIoaPtOgUNwFYSPztWrCM4cUZf493EhNMdZIu20d2X7472YrSMNwdMLxWbsUH4EYzH6TD11U6aHW0V2kXdJQWXL5nJXE4rg5w+Y+TS20WnBqI8uekoPB43PffO4Yg53nuueCps2XCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/cQeIu+bPIcxwcOKL9gdzMqCx93jkiK8f2FGADAoiY=;
 b=BTTfGIdaUFxxVPlUdY9BVK22biFXGhs1HjcyTLR8n7XBuG2/JC9iL0uEO5BYNLDc8Xg7E6VubMH0LVGaFbAD76NuxuKZ7qv1cerfyyWXfOtrOToOROEwdS5wX95kyzd1rxixJJTVYxvmyn6ovRC4ME668jO0LAE2VeQTSliSiLShUP2wq0ffvHCzeuEGQTi+9AuQPeFJjqgMbIYzWiQQrHivZHdqzIuaV4KbFiDoEf4ES13vNKqDqrsPSxaoOtCiSBVo3dYE/vhf/WI805y90YxwLFJTNV8ZX0Lcpi80ttcfCJs/oK7r5rtfJxtxKDQwBmNP5l3mrS3WayCKQugJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/cQeIu+bPIcxwcOKL9gdzMqCx93jkiK8f2FGADAoiY=;
 b=cKvWQ2jV4zdZ4+8le6TwWzmGTRJgEaa9WLRe7T8qFEhjTpFdP0J8xAI/cnLSUCtQlq9wpQhZ5tgsoeGVkasw5u2S45HowKOXjUWYsfvPeiOmuY9O4nCQdjXqbULG9iIRc6VP+12TjO5hE+fkjIHH9NDgi4bg7bFlm1NYcu9Dzvo=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS4PR21MB6913.namprd21.prod.outlook.com (2603:10b6:8:2e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.5; Fri, 26 Jun
 2026 18:20:34 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 18:20:34 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Thomas
 Monjalon <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] eal: return error on devargs truncation
 in hotplug MP messages
Thread-Topic: [EXTERNAL] Re: [PATCH v2] eal: return error on devargs
 truncation in hotplug MP messages
Thread-Index: AQHdA2059rGhnh1caEeNiIch8Gp1qbZO4EEAgAJHAiA=
Date: Fri, 26 Jun 2026 18:20:34 +0000
Message-ID: <SA1PR21MB66834BB21B6AA86BCA50B046CEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260624000531.1562655-1-longli@microsoft.com>
 <CAJFAV8yScD-2zevEo30YrA+93NwYi0qPseHZUbw2riwmnDSk3g@mail.gmail.com>
In-Reply-To: <CAJFAV8yScD-2zevEo30YrA+93NwYi0qPseHZUbw2riwmnDSk3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c3077ba0-b298-4f71-8882-e19d931380f5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-26T18:10:24Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS4PR21MB6913:EE_
x-ms-office365-filtering-correlation-id: 77d80f72-5af7-4291-a2bb-08ded3af9d28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: z7+8gWENrzGuH2gWAAHu0yt/u2b+p9GNSv9bpsdsssKWfYc62M1PXX2cMFH0OdQzbjsFND/omJrumRJMCfzG+LV27GUtYOQIIyjxs1KUoibgk6XGjn+SAqRPkRA9Bu/KtlsWz8dqeWwPhKA63Cn/1RYFAcv8JlIleVZ1dMJamJNKej9735N3zheUP32Ffo97U4ZRjIubAWopa0lG+0/8dpr3ZNvkQc+1KhWdmX7IU4dFkMUVsaFXGgS/wza/Ul+F/LW9N6/+NFPFjL3vCf+oX4TvEgIm6wjEHTAHzRd94OvCc0rdi8IXoXxOUMMhw/dODxMBEk1KO1zFVISGffUvV6pThhYT3ix0RFH+rbJm/K5+Har0jZX7mxbBJ+VZQ5EBokAWNXral1Aop/0LEm5s+QIu6fywLErTDxsn0SqhatlkbowyuU16EcB2RZXPSf7qKDkleQIneZ2zNvuece6VftNjaKjyeckb/fAtNiB4XmBlIHrJcIu9P3rIZiu1NXXYQaqSfmtg5QtGdYDls5abANJwtZhQHqBaxUdNNT04rU9IJ2HdeogGVJiX5wksPJUz+jeFpyVZ99wAyrlrjQTVdLkf9psYv5mrGPeFXBWwKp7cxF6YE7gDbSdgubhlu7PXdpLBPWetLeFPR5GyPdS0e5/yAcOMC4CsJutxSV0gvA2iXpbgH1IvcAWlgHz+Chlb6r4/a993bOyHBexqlj+ilOSrv12/zGMZfbdC/WLYKBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/sxUwWJCgFDxnFAl9uNyvwfG1vgtdswQEBbiTiv5FxBrkQZl9xQ/XlV8pEzZ?=
 =?us-ascii?Q?/Lgv4mdOb24dZCX1yaoRkEsYQMqtVroqeNcUPWxEhXi7mAuHVYR4HqLuJM+3?=
 =?us-ascii?Q?9y7yM81LC+WWBeTh2zgGCSMsCicH76d9I9ZhydI421khV9Ew0hUFIyUB4mxc?=
 =?us-ascii?Q?Nng7tjlbS8xXSMdh+EixbgXzQBaqINCoo/dhzgCvEZ24JJH/w4HqzXIKrrIS?=
 =?us-ascii?Q?xLjS/u82Mnntlkx0RTLabXN122JXK6AB/5YYfDLnMnor4+wjgUjBvX7aAFuB?=
 =?us-ascii?Q?YpJqllJADGWaQZjPV3cqxYYcmFbOMRceIiernR2qjg6YmNNVbXnXAihutgb5?=
 =?us-ascii?Q?91LK7Q8kFYD2Lete9F0REP7YSJl7+/+acCLdkPsX7FePd5FIL9yZ4K3gXUQ6?=
 =?us-ascii?Q?60g9U2W2zz2aSSPS9yGW/ABHTzQOSrUT4OXPmS1jd5pZwsn/arJgiDsFILia?=
 =?us-ascii?Q?4AISYs4Kzk9xbYlnTdWmuTyo5d9kZP4we++kZDbR3rvAgdP/hSeduAjUeGs9?=
 =?us-ascii?Q?kxxX9chGfIYo3y/yuxKULK7XDWEuIrT7xI2r2rB34tArQJn1gCJdHuv7r382?=
 =?us-ascii?Q?CR6TZdUiQtkqJA+vU8MVZde8sK6pzqqUmRJsJoYUH9VC8tspdze4gEZYui8z?=
 =?us-ascii?Q?it/WA/zCtfxdKZO9VdeXuWZRFPSAtU+gkEpo2JnBlU2z3OaV4tR/jNHqWPck?=
 =?us-ascii?Q?mvaiJUYNPJmEuRJ9CeGMINl87WAf9cC6UpfTN3obUa1+uhYLOLb9GpNKRRsG?=
 =?us-ascii?Q?YRoqY7xBVe3kfX7mnwsii0RbkC9IC4SSM51a5+4uhdAAKts4axDUXZqZT4iJ?=
 =?us-ascii?Q?Vms0hdXVy8l6PTOTAhKrQsPzAdtOiekfy43KvPnT+YrzRs6d4bftHyEbbU+b?=
 =?us-ascii?Q?Qx94n7VkMqak0KD2cMxBjLT+g595TpZcRbMXv5OhYmQVYqdCfqcKaBaMDW9d?=
 =?us-ascii?Q?vTfWCYpMpyoeClqFc23KeQlnjG9VTVvjtcG5Sgh+EWfvb5aarAgyDa2f9TTv?=
 =?us-ascii?Q?GHXq6v44GHSXVx/A773x6OW/YSZerGiMkXB1QPCt1aPRTe6Sw1W5YOQUwwWK?=
 =?us-ascii?Q?pTBYYQ8UBOF2/8jkCMhePfYn3PL61+23PmZRm1yzxc6Iwg8+DlzfEA3UU2jf?=
 =?us-ascii?Q?kQSdMPE6bkqMmwNNcRcDiqlsJOCNUZiiWu32umZ5IAs9V8aTV0IftIPpt42a?=
 =?us-ascii?Q?IsYQfBAOcfK1ndLYoIPElSdEuA2yYnliff7+3INgF5HUBunKkECiJ/3WI4lT?=
 =?us-ascii?Q?QS9/7EXqFRPmGCF7FjbUAHN+IjIiv6Gn6kRPwtnL4PvVRL4HWPLzQAhVyujM?=
 =?us-ascii?Q?Lvy4nv1TOZizJWtbUtrUiNIFn9DadZiSFeGrCwKhvQ/yC+6HZOxbE7v+Q09T?=
 =?us-ascii?Q?0y5UglNGZbP3SqXdyboMXrnH/RyCETBYlQFcERPIhlWwOxdI9EeKsvgYGIUD?=
 =?us-ascii?Q?mgBVPLvnj1t3MK+TIBOGNTb3l+Is4dazeJz+8Yd6dPk2drpTJJkRDpOWIL9s?=
 =?us-ascii?Q?fpaxCvMKThYIZw3pIB+A2j6faJUd2mYsVphm+Pso+XBBPGMvjJNt6zk9qrPm?=
 =?us-ascii?Q?sFHtYRLvnp8f5EYSwm/emLEhlnmw+KPtv6/fjzMRcOsPejErsx8hhBgpxs7A?=
 =?us-ascii?Q?4QcmUhO7EPhrDaBJ/jdZeDyTQC7nVicF5gjYYP1HWCtVOPEozpWFTZOu/bzQ?=
 =?us-ascii?Q?+Rbrvq72/ID7NoMe5GpCn//CpKtFDeKQj1r7rF+rRsgAhaW7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d80f72-5af7-4291-a2bb-08ded3af9d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 18:20:34.2430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9YOQ3Y31w1LOB5cKZvwhcJsqwFV2j1fq9zy9QPZPGcQJwEgo+lMVZ2cBKpFqQPKYMD4uPjYSTe/n3q6NL4lLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6913
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

>=20
> On Wed, 24 Jun 2026 at 02:11, Long Li <longli@microsoft.com> wrote:
> >
> > The EAL hotplug multi-process messaging uses a fixed-size buffer
> > (EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
> > When devargs exceeds this limit, strlcpy silently truncates the
> > string. This causes secondary processes to receive incomplete devargs
> > during hotplug re-add, leading to failed port re-initialization.
> >
> > For example, a MANA PCI device with 6 mac=3D arguments:
> >
> >   mac=3DAA:BB:CC:DD:EE:01,mac=3DAA:BB:CC:DD:EE:02,
> >   mac=3DAA:BB:CC:DD:EE:03,mac=3DAA:BB:CC:DD:EE:04,
> >   mac=3DAA:BB:CC:DD:EE:05,mac=3DAA:BB:CC:DD:EE:06
> >
> > produces a 131-byte devargs string that gets silently truncated to 127
> > bytes, losing the last MAC address.
> >
> > Return -E2BIG from rte_dev_probe() when devargs would be truncated,
> > instead of silently corrupting data. rte_dev_remove() does not need
> > the same check because the length was already validated at probe time.
> >
> > Fixes: 244d5130719c ("eal: enable hotplug on multi-process")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Re-reading the function, I have one concern about the fix.
>=20
> I agree there is a bug with multiprocess.
> But this change here also imposes a limit to 128 that was not there befor=
e,
> even if multiprocess is disabled.
> It may not be a big problem, but we are calling the the multi process
> machinerie when unneeded (it ends up with a ENOTSUP).
>=20
> I sent a small patch on this topic, could you have a look please?

Thank you. I sent a review comment. This patch looks good.

I'll modify this patch to have the length check inside if (do_mp) block.

Long

>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Finbox=
.
> dpdk.org%2Fdev%2F20260625072254.4190227-1-
> david.marchand%40redhat.com%2F&data=3D05%7C02%7Clongli%40microsoft.c
> om%7Cf1cf337c1f014cc8b83b08ded28ab9d4%7C72f988bf86f141af91ab2d7cd
> 011db47%7C1%7C0%7C639179690431011725%7CUnknown%7CTWFpbGZsb3
> d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7otoCpQbXZvcj5tSD
> QAJ77sdfu8U%2BgPwZZyYeTC%2F2lw%3D&reserved=3D0
>=20
>=20
> --
> David Marchand

