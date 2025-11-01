Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F3ACCF9F0
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 12:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9063E4064F;
	Sat,  1 Nov 2025 13:53:41 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by mails.dpdk.org (Postfix) with ESMTP id BAE8E4042E;
 Sat,  1 Nov 2025 13:53:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU+KHPa3BsVrPZgPegmJARnvY/h3m6xHNP804KSWTN2OQ11WRd3DhEPPgnJKrHg792LPjZ6TZGsiXvWZ9GefFSMlCATPVyMWVcPp1rLWPbKSQXleyjscsQvNo/syviBuFdSFO4p9o09qr69hfyMe5B7xfWc2Fjjfee/B41j2SzzFUBZRhOYrZnrWmwvXopSYl9qJ7oP68dD9lDsaWMh3Aj1k8hMxiTAMKLgIU+RrpMi0KTPXa7ND2lSVXwKTEvfIg4496qOPwvhdrbFoH5/HFcflDop1s3Nm0NDLFO/LXTNI6cnhC6O7tv5aod2u/Ra4+ei67igLZ5MbarPnVtEAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zlt5eI5Uvsyi32nI8pf+3ytjLCOVlGEm4kx/35Gtfuw=;
 b=tHZd2pdL/sxBrCn6dNwXtKQz+IfO9hr7chShd5YZlDSyXQ6ZURmeXflsvKKnx79IhocXrYOaqLxSIAdg75dkQ+g4MzZd8ddMwwAS/8zjaMrQwkZZc/GklBkP4eSzzDhpf6SxvpCBEcfj3DppUtTI9tvaMI6vX/gikHfeCnIbxH4v/edHLwBIBdPJBtQC/Rvcqlzjr2wLQsq5w8HGcManHGWYvH5Yjnej3xDKeznY4tXbD6aQKxzN094Sab0cLRAWjQevNYEtFpfS2pZ1ai3LI48F/213zKLXBuqoYjVOJBm1GPjeM+nd9UjhIN/B3piOwoJ7SYALRHJMq9n/5w0skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlt5eI5Uvsyi32nI8pf+3ytjLCOVlGEm4kx/35Gtfuw=;
 b=HWUozDr7CS2kOESAZhknV6QRRw0BchW+9lqFgrABOVvwS63TovRR+eETCE6FJbWi5/hpm3BSXPGgOMa9arFSz1oRculTm2Etpk5N7ij7By7XB5gveUW4awpM/RoVUpvPZEWMWduFEl0yxY8U/qgXLh+C8R6qUP0rAPyuF+g5+zo=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 12:53:37 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515%7]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 12:53:36 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, "david.hunt@intel.com" <david.hunt@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Ande, Venkat Kumar"
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Topic: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Index: AQHb2SU+tA7kPVaC/EGjX4/NwXYycbP8deoAgL1hK5mAIwU+AIABzjlP
Date: Sat, 1 Nov 2025 12:53:36 +0000
Message-ID: <CH3PR12MB8233D6BB749461012556FD4986F9A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <PH0PR18MB40861D909AD3BC9A0695309ADE6AA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <CH3PR12MB8233DABD201A97C7A71D8D2C86EEA@CH3PR12MB8233.namprd12.prod.outlook.com>
 <81d70c4e-aa4b-482e-a708-be477ed22f5b@huawei.com>
In-Reply-To: <81d70c4e-aa4b-482e-a708-be477ed22f5b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-01T12:53:36.309Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|DM6PR12MB4339:EE_
x-ms-office365-filtering-correlation-id: 246af2b1-90ca-432d-68a3-08de1945ac46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007|13003099007|8096899003|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nr9e7zROIASfg0cCIIICQU8z+zz3WXueqqGHfB5txjltqlFx6fP2sJjMeL?=
 =?iso-8859-1?Q?h3unx91upbAWycmrrUrUWkLYe9lUEp/pgiCkQBf2Da7U6dn1P26ZU5zaNh?=
 =?iso-8859-1?Q?kczl0A2Fv4Hgn4njv1i8x3PWPOByNWGfB+7hGA+IIJ1jlYueaVuYxZNoG2?=
 =?iso-8859-1?Q?OQQOVGfpnhBL1ADND67Id1HV4RkzSVOXnQswmjOLqe/LAxQ+SJcowfI8Ox?=
 =?iso-8859-1?Q?0CjpjscaVGiKRXtSzmTXDOhRRbMhU1VbMcfFrv49Yi5P0rrzrCU7JbUdYc?=
 =?iso-8859-1?Q?dUOncqpoLeopdTuU/BDTuFj9Aid41z/IYKtAzJfjWRqT3eZ03iApo5maZU?=
 =?iso-8859-1?Q?2KvdidrIZW97MLaWvHzxnm+NMh+yWLr/tGFNAbu5Pb0chWLUYb+kR6bD17?=
 =?iso-8859-1?Q?AcqfOOsWiQVyvemWiYLkHyAkpXyuYuAOos/PnsMuF34ZMQef6t8LKjsukl?=
 =?iso-8859-1?Q?Yt/lCU1DCrKqZi7+AVFSs3aoKBjtG1SrFobGaSKsMvxcucRU5nq6QHLVw/?=
 =?iso-8859-1?Q?Z0DjwyfsUxMklET2cKL/Od20H/JXbhbr4imX0WWrtFTyX+0BoQg7irBswe?=
 =?iso-8859-1?Q?0BzApLHvDN423QolsXJputiL4CjxzZQFFCNNpQtKP3zG2HYEUJ6GTHG3KN?=
 =?iso-8859-1?Q?MsD6ftjcrieJWC+klwzEzPXhPc+F/UOKnWWwJnWnFiC/+LLvk+ifZhr+YL?=
 =?iso-8859-1?Q?fmsVg1q4DeJdsfC3EoiU8qtfvrGdXA+zUkBmAgP2wRrN2iE/BhGrTbR+qC?=
 =?iso-8859-1?Q?XnkN8oVRdWubpV0aLNiXD/TpRoSBP9U/qJmVdbJcJiXLYxYUzrefBE207R?=
 =?iso-8859-1?Q?BxZr4sjVzunrqDSvzEHvYVEjodNqIACItAIeoE+zD2WHPsVAeIhHO9IqdH?=
 =?iso-8859-1?Q?9DIQstiebJSo+XWlWNgx+PnyjThiEgojWus0o93NNoV7Sx7rX28/RegDPl?=
 =?iso-8859-1?Q?fAZRte3DtaMOCBfoFkJb4Tm0v4Dlyhvubo6MZAVKCzphZ0kB6xuerM4zPu?=
 =?iso-8859-1?Q?Rg4iHCJaD7HOG8PUjqpLuR4M5W5MQgwYctyXJhYbqrIAfAHAl6BFZUrMCY?=
 =?iso-8859-1?Q?I/bJlb5FNL0nDc7HVYZZtl/UFRgFS2WReGyE53ZLolx5hqa6G1lO3UEKQo?=
 =?iso-8859-1?Q?0SNCQAqo3KbK3ianD8yuXDg6cizco3RZvpeouLhtxJyu2FltK/K+09ULvn?=
 =?iso-8859-1?Q?DVS9Nu/MjpGkM0Fs4gyKyvS1J6tFUPiSQBKDQrfFz98CRhz/Nd950degI+?=
 =?iso-8859-1?Q?tVzkzEqGL69VyT1On6+98GxMNmkZRUojFlx4maqmrUWCErE+cLJJYPlGHu?=
 =?iso-8859-1?Q?TxP2jmBwAriz1oJb6shlCmGBnI2cPxhdwvLZLkIh2IO5j9Gah3DOSpS1fj?=
 =?iso-8859-1?Q?gN+8YAJQo02rjONUsx4AfMgJq5R6BupLtMtJBq5Ej5LloEA2XegKPSOnDB?=
 =?iso-8859-1?Q?GQlD+DRwvQQ2ET7t7H5iBvi7ceo6CCnhw+AArt44j5D2Zl4oHx1yA7kO3E?=
 =?iso-8859-1?Q?arsJNLFxro6q3HGLLZzUZd9hZQXALJyRH1dqtYIgAl34PQYIwjSfTXm6f+?=
 =?iso-8859-1?Q?1hkw95h4TtK8aZ8wjGnU3Rqk0hgflbTuggEFtIlneBZQKXufCQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007)(13003099007)(8096899003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m9Tcxk8uibXKq3VDGAIV3eX9KFoJfAgHbCiWKJoLMTwlrg1Vl6vjoOF0Pz?=
 =?iso-8859-1?Q?uPCuX73+zpv4Ti/aSF1JjFNqHRh60zULTs0BXkA7WblmqNDHHH3g0CTk2G?=
 =?iso-8859-1?Q?cnipsafiHAxOCdhigMaVupYA/qzDwwunQ8O+j66bYpIm1zK9xI1OW3ZwPA?=
 =?iso-8859-1?Q?SdBd2gnJmHd6jb/vcFM1ftmX0SBOWsA1tiwSuRQmdREg52nb3M7NC1iGRf?=
 =?iso-8859-1?Q?b56lW40hQK3b23/KmWMPh6bRSjhHe5FlMpl7EZBtDZFs3StRNNFiOtk0H5?=
 =?iso-8859-1?Q?V+/gf+7ERhLHplbzarWIWFJTfHge2CQMtNRgV3qJVIAFSH3iyNk2fdX2Br?=
 =?iso-8859-1?Q?YHKTDjnqfdbozrx9VuA/nvwhkiFZtWU4qRCdjWl58OFainLlCn/jmPyomW?=
 =?iso-8859-1?Q?ZG3OQwPMJOba7+e+ZUXEWEc0YTdlJqiKP69pPG9jGFy+3AXBrPfK3vy/1w?=
 =?iso-8859-1?Q?GpJMYkbW0/74RVLj4EzA7ZAXcmTZDEm9jslGNCGdxWc0gAtMi436FXgEfN?=
 =?iso-8859-1?Q?b2BrwwFmMPAAgbanV3L1nBir03pNfxQDv8CkTL4EoYbhxHTmpKNy/9RVFw?=
 =?iso-8859-1?Q?DPlAOI5cGy6lVK8GYPbktMULmRmH2Gee+GeXQ5gKnUJINSpN78sFiN73rO?=
 =?iso-8859-1?Q?06AIIL9je9yYn4Ec3vAt999LjFHxM4MslqpnYcBkx/SzTKtfcFgQSL+ut6?=
 =?iso-8859-1?Q?p7IzMsxtsOuXlLWKWgDtSvtR2VQ2Y6YMbQAB+X5yYZLbc0nbYTjuNTYlga?=
 =?iso-8859-1?Q?i47yq8kMDaKstUeiIhpnuR/8PSrdFOgX3/NDYkjjrPCEG55U39HQ7BuVmX?=
 =?iso-8859-1?Q?B/NDkzGRaWDQ9b5U/9SAp1gAJivsmIeFSFynKSBgB2ORdEqcpuyudCQ4eq?=
 =?iso-8859-1?Q?LZBALHpF3fYoBFnhhtLJ9lmWUE6LogcWVY63tHK92nuxaozBgnZSvv9y2Z?=
 =?iso-8859-1?Q?zpwouEgxsn1tO6TJJM2WmYsp/uQcoinGV8rTSCy8Nin5aJ5+Y+AcGubHtn?=
 =?iso-8859-1?Q?rqsC6SBXGsTo6pscWiQOtg1Owu5bzFX1MEKvHVVGdy/d7QzYj48DB/LrjZ?=
 =?iso-8859-1?Q?1MdZTVoxHDVUcLw6v0HsVEbQ4fg5Pp9Vmiws1RINvsHyBSG+XbR88a3MCQ?=
 =?iso-8859-1?Q?wUM2BKr9sshjnN9B4bg7HwLzSZyBJQ2FkW8deHEpDkpmU5xL0l65sx/eZF?=
 =?iso-8859-1?Q?b6YrrSbpaBm9k0HIniC+pkN23lj+FfpUWa9o8txZ9puozyUrq+yqS3dBhP?=
 =?iso-8859-1?Q?Usfnjlej3FbTtjW43dDMes+mb5CQn0L0iWJjx5VvzoFQE/ABhSH1B2pJ6q?=
 =?iso-8859-1?Q?Z9+D2/KHKEwTIoWWJTAS9yDjw+7FT7bIUmhHCntEB2DP5FIxrHTLdIr/qn?=
 =?iso-8859-1?Q?N62XRO7FX5SdI51x8/SypjRSar3LXaK5EULhCS7ssSBb6cmJVID0wuFD7R?=
 =?iso-8859-1?Q?dHCzWzO+LkxsimH89ypVmp+tiQ2fcCKjYB8yIfM4Rat0pbZAIZ7vsQtilk?=
 =?iso-8859-1?Q?JvKhF3B5V/jD5cfK9179ml6ujb1AYCvchIdUTIw9kHn4atECVOrCTrlVtO?=
 =?iso-8859-1?Q?clu63uSwSBLqWWoooYAGwltiFoDwM5Go1IYVQCfV9h+Q9Y59wpmdDIY3kt?=
 =?iso-8859-1?Q?8d9/K2nzdeB/s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8233D6BB749461012556FD4986F9ACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246af2b1-90ca-432d-68a3-08de1945ac46
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2025 12:53:36.6886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAVhjG9JCF3pjVsIAfK8d+J8K7Lk7jquDWnr6Hajiri7kFqEd2YmZngMbuHV2GqlCwPebqCTw/TpGyThqdVqIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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

--_000_CH3PR12MB8233D6BB749461012556FD4986F9ACH3PR12MB8233namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Fengchengwen,

I will send the v3 patch early next week.

Thanks & Regards,
Sivaprasad

________________________________
From: fengchengwen <fengchengwen@huawei.com>
Sent: Friday, October 31, 2025 2:48 PM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; Pavan Nikhilesh Bhaga=
vatula <pbhagavatula@marvell.com>; david.hunt@intel.com <david.hunt@intel.c=
om>; anatoly.burakov@intel.com <anatoly.burakov@intel.com>; Jerin Jacob <je=
rinj@marvell.com>; radu.nicolau@intel.com <radu.nicolau@intel.com>; Akhil G=
oyal <gakhil@marvell.com>; cristian.dumitrescu@intel.com <cristian.dumitres=
cu@intel.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>; konstantin.ananyev@hua=
wei.com <konstantin.ananyev@huawei.com>; mb@smartsharesystems.com <mb@smart=
sharesystems.com>
Cc: dev@dpdk.org <dev@dpdk.org>; haijie1@huawei.com <haijie1@huawei.com>; s=
table@dpdk.org <stable@dpdk.org>; Ande, Venkat Kumar <VenkatKumar.Ande@amd.=
com>; Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size bas=
ed on Rx burst

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Sivaprasad,

Are you going to send v3 (add log) version?

There is another patch about adjust burst size [1], if this patch
don't continue, maybe we should restart that one.

[1] https://patchwork.dpdk.org/project/dpdk/patch/20241204020622.977156-1-h=
aijie1@huawei.com/

Thanks

On 10/9/2025 10:32 AM, Tummala, Sivaprasad wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Pavan,
>
> Please find my response inline.
>
> ________________________________
> From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
> Sent: Tuesday, June 10, 2025 7:59 PM
> To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; david.hunt@intel.co=
m <david.hunt@intel.com>; anatoly.burakov@intel.com <anatoly.burakov@intel.=
com>; Jerin Jacob <jerinj@marvell.com>; radu.nicolau@intel.com <radu.nicola=
u@intel.com>; Akhil Goyal <gakhil@marvell.com>; cristian.dumitrescu@intel.c=
om <cristian.dumitrescu@intel.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>; k=
onstantin.ananyev@huawei.com <konstantin.ananyev@huawei.com>; mb@smartshare=
systems.com <mb@smartsharesystems.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; haijie1@huawei.com <haijie1@huawei.com>;=
 stable@dpdk.org <stable@dpdk.org>; Ande, Venkat Kumar <VenkatKumar.Ande@am=
d.com>; Dengdui Huang <huangdengdui@huawei.com>
> Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size b=
ased on Rx burst
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
>>> Previously, the TX burst size was fixed at 256, leading to performance
>>> degradation in certain scenarios.
>>>
>>> This patch introduces logic to set the TX burst size to match the
>>> configured RX burst size (--burst option, default 32, max 512)
>>> for better efficiency.
>>>
>>> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
>>> Cc: haijie1@huawei.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>> Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
>>> Tested-by: Dengdui Huang <huangdengdui@huawei.com>
>
>> It would be good if the selected burst sizes of Rx and Tx are logged.
> ACK
>
>> On CN10K platform we see upto 5% improvement, and upto 30% improvement o=
n CN9K.
>
>> Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
>> ---
>> examples/l3fwd/l3fwd.h        |  8 ++------
>> examples/l3fwd/l3fwd_common.h | 11 +++++++----
>> examples/l3fwd/main.c         |  2 ++
>> 3 files changed, 11 insertions(+), 10 deletions(-)
>
>


--_000_CH3PR12MB8233D6BB749461012556FD4986F9ACH3PR12MB8233namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Fengchengwen,&nbsp;</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
I will send the v3 patch early next week.&nbsp;</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Sivaprasad</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;fengchengwen &lt;fengchengwen@huawei.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, October 31, 2025 2:48 PM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;; Pav=
an Nikhilesh Bhagavatula &lt;pbhagavatula@marvell.com&gt;; david.hunt@intel=
.com &lt;david.hunt@intel.com&gt;; anatoly.burakov@intel.com &lt;anatoly.bu=
rakov@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; radu.nicolau@i=
ntel.com
 &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;gakhil@marvell.com&gt;; cr=
istian.dumitrescu@intel.com &lt;cristian.dumitrescu@intel.com&gt;; Yigit, F=
erruh &lt;Ferruh.Yigit@amd.com&gt;; konstantin.ananyev@huawei.com &lt;konst=
antin.ananyev@huawei.com&gt;; mb@smartsharesystems.com &lt;mb@smartsharesys=
tems.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; haijie1@huawei.com &lt;h=
aijie1@huawei.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;; Ande, Venka=
t Kumar &lt;VenkatKumar.Ande@amd.com&gt;; Dengdui Huang &lt;huangdengdui@hu=
awei.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx bu=
rst size based on Rx burst
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Caution: This message originated from an Ex=
ternal Source. Use proper caution when opening attachments, clicking links,=
 or responding.<br>
<br>
<br>
Hi Sivaprasad,<br>
<br>
Are you going to send v3 (add log) version?<br>
<br>
There is another patch about adjust burst size [1], if this patch<br>
don't continue, maybe we should restart that one.<br>
<br>
[1] <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA3bd1b768-=
40d9-f4c1-cb29-aa70d4cb955a" href=3D"https://patchwork.dpdk.org/project/dpd=
k/patch/20241204020622.977156-1-haijie1@huawei.com/">
https://patchwork.dpdk.org/project/dpdk/patch/20241204020622.977156-1-haiji=
e1@huawei.com/</a><br>
<br>
Thanks<br>
<br>
On 10/9/2025 10:32 AM, Tummala, Sivaprasad wrote:<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt; Hi Pavan,<br>
&gt;<br>
&gt; Please find my response inline.<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Pavan Nikhilesh Bhagavatula &lt;pbhagavatula@marvell.com&gt;<br>
&gt; Sent: Tuesday, June 10, 2025 7:59 PM<br>
&gt; To: Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;; david.hunt=
@intel.com &lt;david.hunt@intel.com&gt;; anatoly.burakov@intel.com &lt;anat=
oly.burakov@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; radu.nic=
olau@intel.com &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;gakhil@marve=
ll.com&gt;;
 cristian.dumitrescu@intel.com &lt;cristian.dumitrescu@intel.com&gt;; Yigit=
, Ferruh &lt;Ferruh.Yigit@amd.com&gt;; konstantin.ananyev@huawei.com &lt;ko=
nstantin.ananyev@huawei.com&gt;; mb@smartsharesystems.com &lt;mb@smartshare=
systems.com&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; haijie1@huawei.com &lt;haijie1@=
huawei.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;; Ande, Venkat Kumar=
 &lt;VenkatKumar.Ande@amd.com&gt;; Dengdui Huang &lt;huangdengdui@huawei.co=
m&gt;<br>
&gt; Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst siz=
e based on Rx burst<br>
&gt;<br>
&gt; Caution: This message originated from an External Source. Use proper c=
aution when opening attachments, clicking links, or responding.<br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt; Previously, the TX burst size was fixed at 256, leading to per=
formance<br>
&gt;&gt;&gt; degradation in certain scenarios.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch introduces logic to set the TX burst size to match =
the<br>
&gt;&gt;&gt; configured RX burst size (--burst option, default 32, max 512)=
<br>
&gt;&gt;&gt; for better efficiency.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fixes: d5c4897ecfb2 (&quot;examples/l3fwd: add option to set R=
x burst size&quot;)<br>
&gt;&gt;&gt; Cc: haijie1@huawei.com<br>
&gt;&gt;&gt; Cc: stable@dpdk.org<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.c=
om&gt;<br>
&gt;&gt;&gt; Tested-by: Venkat Kumar Ande &lt;VenkatKumar.Ande@amd.com&gt;<=
br>
&gt;&gt;&gt; Tested-by: Dengdui Huang &lt;huangdengdui@huawei.com&gt;<br>
&gt;<br>
&gt;&gt; It would be good if the selected burst sizes of Rx and Tx are logg=
ed.<br>
&gt; ACK<br>
&gt;<br>
&gt;&gt; On CN10K platform we see upto 5% improvement, and upto 30% improve=
ment on CN9K.<br>
&gt;<br>
&gt;&gt; Tested-by: Pavan Nikhilesh &lt;pbhagavatula@marvell.com&gt;<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; examples/l3fwd/l3fwd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 8 ++------<br>
&gt;&gt; examples/l3fwd/l3fwd_common.h | 11 +++++++----<br>
&gt;&gt; examples/l3fwd/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 2 ++<br>
&gt;&gt; 3 files changed, 11 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_CH3PR12MB8233D6BB749461012556FD4986F9ACH3PR12MB8233namp_--
