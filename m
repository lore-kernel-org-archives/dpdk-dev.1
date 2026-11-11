Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BF606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LrmH5gTR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9444E41109;
	Thu, 12 Nov 2026 09:07:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by mails.dpdk.org (Postfix) with ESMTPS id 09DBB4026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 11:23:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjIv1pqAhBtBcYu5QAV7xO1QgLD+isnpWzcoeAc50sXKJQsVKOLuWIrbSxla0+WOL+xOP597RuwuZWnvpkNUFl0hfHzNVI6/JfABqucbBRbwUslG2L6SACQiHZnA6VSkauSzp6KRko+fHdshzAV8R9X1kilenhQhu1hvgN05AZwERSRcLUx322kRHSPc/88RoiaiCMKMhMw65V5ADfTQViJn9NPQRPgcsJMfgeiAqAnWa6w7QW0UEgvYMRcPuEogC8jYuBrk02EYHdWP5bFcE7ATyRqvonjL9EWko6vEUN2KBjCSlJadiHB2PUXoddVrWGKTDQTASTTcqWlSlqYEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+tJCEl8rqR54kPYTovQRzUMgQI2FIoO4L0jBw4gZ+Q=;
 b=llDM/+X6D4sDZFZhI9vO4MmvkV3iZYkh0aje0q5SQ3WMwrZPdO52GIvJXsRm6q+Ii1J40si67GLanMHeErNaf46Ipb0tGIBe4BZNYmvseXKnfX7mIV6WCr3WOZuCan6uawrHJdZGpRCPNy1z2FGiOesJUR1DEOsYiLq3xopjVZo9fZr2Qw/uRXNnU+VdoA5DgMUrze+XBSxS6mAfaPiPVrWvpPubonm/aFLxFJznFOH5mzO41aPlViXte7qimhzrqDujCbuU1ggDSxuVOOWlLxGXfF+PjFDVOxycaKRV5FhgP6v5OOV+zfCp4AyR2Tm4uOmuARw1Ijw2ntmSIhfwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+tJCEl8rqR54kPYTovQRzUMgQI2FIoO4L0jBw4gZ+Q=;
 b=LrmH5gTRZ1SlxUKVoST3Q8dP7766W4XDj6uXnWYYUrTuBwnqtobL6hCgyyjH7NdL+dax/7KWpwO2q4L/MspndwPWgXJqc9Crtw7jyevRkgfmW3xd3FBClM3FyoTEM/yfZdmL62n3zbH9rdSdeAE7HX56k/ZgsDCIOl2yR2JzFVE=
Received: from MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 10:23:25 +0000
Received: from MW4PR12MB7213.namprd12.prod.outlook.com
 ([fe80::f8d3:54f6:4c9e:c50a]) by MW4PR12MB7213.namprd12.prod.outlook.com
 ([fe80::f8d3:54f6:4c9e:c50a%4]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 10:23:24 +0000
From: "P, Johnathen" <Johnathen.P@amd.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
Subject: DPDK release candidate 26.11-rc2
Thread-Topic: DPDK release candidate 26.11-rc2
Thread-Index: Ad1xxcLsN01Z+47aRYip5LdBF2/7Wg==
Date: Wed, 11 Nov 2026 10:23:24 +0000
Message-ID: <MW4PR12MB7213851CB9E785FA23C8E4FFF6712@MW4PR12MB7213.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-11T10:15:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7213:EE_|SA3PR12MB9157:EE_
x-ms-office365-filtering-correlation-id: 590e5eb9-4b3f-45ba-655f-08df3fddd161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|261102123227099003|56012099006|261021135927099003|11063799006|261021121427099003|261021130227099003|261021133027099003|261026135527099003|261022115727099003|261022105027099003|261026130827099003|261022113327099003|261026140227099003|261021123027099003|261026121527099003|261022075727099003|261028144727099003|18002099003|10067099003|8096899003;
x-microsoft-antispam-message-info: VNSUFbJRS5PvMVTFcOTDX2uoSfRRc187C2LhUtWrc9AQlB6LUs1f3u4krdeHeSxsQ0UVzyTJWzzVaJNQYPSJ/I74peI1ATDEgBbUotIJY8aqyK/qNCjDf2KNaYvTPxBghC6mtcpngShfgyuTgOevec69aQ+OczqizT0XDweBBDsfubD3PD3yU0l/COzaXRZBabLroApMt2yqdbQ9AnV8KDMfh+la3RHHkGrL8380zpsWppq9El/VTvi6esJ1gM1rEVfx4zIGGo68BWBMz7x0FdL1sJ8rXtZBH6b0mJyUYz1kqUn0iUL5B+hOy55TZzr+KJ/5pHL8nJgp0Oy8lG/Q2aOPUcpCQQ7fYCifY1fSOlIqG78nMbUT0zwmDTQCjvgKQVj/D7FY3ZEp7bw6xo74VD/lvgpMNcQpFrpeWZSBtuULhAuO19aQ1LXx0ViLAlqbe2gpAeDbTYRwYMn82Zw0qj+e/wEL2mlYk41LWDoAcx4pb5F94wvmrevIb1pANQDSD7CsDRnGvs3YRuR0q6DMqzmMyn5OaV0AftLOMO+rmV0RQgcfltF8hOi6Dxpz+ogMy++qf1ujHkxTCcQdOQuuSNMndEvp9NS0y9pjrbO5dYohzIAKm7jD31k9XtoDyWiVuM9e8+xPDn6oVWVhPtZfMdVSbSZfAXnjPo8OV5f67EH9CbRRcZSpTAdJoBfuhHbpO83pL9tuy8WTAzQgyCUT2N5Od88Bas30uLAfv3MDYas=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(261102123227099003)(56012099006)(261021135927099003)(11063799006)(261021121427099003)(261021130227099003)(261021133027099003)(261026135527099003)(261022115727099003)(261022105027099003)(261026130827099003)(261022113327099003)(261026140227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261028144727099003)(18002099003)(10067099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N450dOyUIHCHBVBh9Nudha+ON0LzxC2wFraU7FESqozBl4uhomufGVY6rlHa?=
 =?us-ascii?Q?gn6ur8sNue4/wehFveo92GaLJUwijdZV3zpaC2K0ccE4prLfE3jAVkB+Vd13?=
 =?us-ascii?Q?j0k2c7TLHKboMBC/NYn1yoxYOeZmtO86YawIrAqiWY74CB6/AyHl87hlh+2b?=
 =?us-ascii?Q?BfbrDzdYE79u9PMz2hLIAmSw3upwqgoxQ+mbp3Eyeg/nzvrdruFrz3O1PsWw?=
 =?us-ascii?Q?A77Il3i9EDTtqZ5fYGDeBgWWHVyYzYNRb9MFyLWFyRN1bu4sWu4vYSit0s0I?=
 =?us-ascii?Q?NB6y5JTn47PmfuZUCWqyMiRigseQzE1TTroQXMeUO4Ux6QKdKWXZE7kEyJT1?=
 =?us-ascii?Q?K4zIrDfKbhqNdMFq7V78q1GzAW69OZynNiHz96ETbgboccRI7yOVU0ETzAzO?=
 =?us-ascii?Q?CXoPdrA6m5SEg6JmLH1MSDV6r/Qh7Zkk5Jkg192gq6aJ7Nj+ziWhwm55GriK?=
 =?us-ascii?Q?az2lhVrzV6grjsuRqh93WHkEM2FEA7mAiE5iGm011jRHZys8+EKXwcz6xVnq?=
 =?us-ascii?Q?kUizO8HWUxwHZU2S4UQcen372cHIO0KDc49TkzStnukbtP6iyT/xYroCI01s?=
 =?us-ascii?Q?OWIZYUW+PFYyVBRY1H/sMfbUa0SttIwu6ImBvdLjhUSJMVBfBIzilJu1QcD5?=
 =?us-ascii?Q?c6MxgD296IrjkXkJbmvbrj/6DIBh2hK5FX8fAGIcvagaImfjUtD+PUFJn3n0?=
 =?us-ascii?Q?5g/64CWF8EVvOz6hnLFq75ucre/3rfhyvQCEJ2BNmbX6Drkoe1Nei7gaGg5C?=
 =?us-ascii?Q?Oio+y9dj3eeI6vRZ531Pev56YIARjb8Rj7L9qJv4vN11w03Y8ICJpleGLkI/?=
 =?us-ascii?Q?bkaw9axdbxEqjv7GK7GzZeZ2etJP9aog+RrFCImqPgUwP5FfgKxU4H/Zuf12?=
 =?us-ascii?Q?+L0PszBvjCqn7RMWsgkpXQfNTC+jX2TwwF3S0m1WNAxqni8sQP6CIneBKXGR?=
 =?us-ascii?Q?B/CNpI0wOAP9mt8/6tzacx2zIH64EP+B7SDWzYJ3+wbRvKhBEu7YWQVf4omt?=
 =?us-ascii?Q?Bu7sWgyLRvyWqEdEzW54w5m4p4pfevXODF9+oKSp4H3pws/5YKCnY78zKOCQ?=
 =?us-ascii?Q?WXQAAc+9ieEpX/YKMSX2iHaUp6/vngrusSWRQVnNi1yB/B3nmk3ewvochO/y?=
 =?us-ascii?Q?TYrB+cKSzEn+9Ibfm+AyoTv1+WjhDFN9LNvpV8080BcLBmkDHJwUncfCaMwJ?=
 =?us-ascii?Q?hwkpBTcUQu2vTJBxF5oNJkXLIjAMdjTPoIObehjC+gXqzgjqEkTqdEAnr0eF?=
 =?us-ascii?Q?7besBtlw7IMfhFjab2OmsMZLOaKERiYcPNvUW0QHqAwirseu7WEiVzAcKZqg?=
 =?us-ascii?Q?WhRK22LhgRmVxevzBrB2Hmj2Vmktlf01KTBNnZkEbRixVBNCf2024Oe7FQ+H?=
 =?us-ascii?Q?SBj5Ll8RSacPvnKbM/p0or6PUIrvq3RF96xvoVLi4Ebqor5QBAbuWSXFoQo4?=
 =?us-ascii?Q?LMb7WKHRG/GAAWVOztlqmS8S4zTV/gWv2eyWgtrfW5rswwIs6qMpLXT9nw5g?=
 =?us-ascii?Q?FqGlvDrx+ZceEwDv29v1araWbF0MtZfxGkwyex2xARNr+AOD4d9kx9/Km2ll?=
 =?us-ascii?Q?8TOCkYEB98VqoDXHZe9X/iLB6zf6oU8V8Al64A19TprYS1jd7Kyh5Iu6iTdY?=
 =?us-ascii?Q?DaDgNk+d3f5pgNQ+N61jN39lKHBRKNFfargBoQ3KmyYADBTQ2vgIAw8cl5W6?=
 =?us-ascii?Q?mdY24fNfk2BbHURJO3B94rxMczQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB7213851CB9E785FA23C8E4FFF6712MW4PR12MB7213namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590e5eb9-4b3f-45ba-655f-08df3fddd161
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 10:23:24.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTFkXu/mwHtfhfcZASHlpUqrTas1iT6V69TT8duZuOQWzuc4k21tssDlJgkK+hdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
X-Mailman-Approved-At: Thu, 12 Nov 2026 09:07:37 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_MW4PR12MB7213851CB9E785FA23C8E4FFF6712MW4PR12MB7213namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Please find the AMD platform validation report for DPDK v26.11-rc2.

* Summary:

DPDK v26.11-rc2 AMD platform validation is complete.
Performance was compared against DPDK v26.07 across 6 workloads on 5 AMD EP=
YC platforms using Mellanox ConnectX-7 2x200G NICs.
A total of 4,789 data points were evaluated. Of these, 4,788 points, or 99.=
98%, are within the acceptance criteria. One data point is marginally outsi=
de the acceptance criteria at -5.04%.
All 6 workloads, TestPMD, L3FWD, Crypto, Compression, LPM Perf, and MemCpy,=
 passed.

* Issues: None

* System Tested:

Plain Text
Platform Processor Points
Turin Dense EPYC 9745, 128C, 2P 923
Turin Classic EPYC 9755, 128C, 1P 923
Genoa EPYC 9654, 96C, 1P 1001
Siena EPYC 8534P, 64C, 1P 1001
Sorano EPYC 8435, 84C, 1P 941

  *   OS: Ubuntu 24.04 LTS
  *   Compiler: GCC 14.2
  *   NIC: Mellanox ConnectX-7 2x200G
  *   Boost: OFF, except for Siena L3FWD and TestPMD, where Turbo was ON

* Build & Compile:
Build completed successfully on all 5 AMD EPYC platforms.

* Function Test Cases:
Following workloads were validated:

  *   TestPMD
  *   L3FWD
  *   Crypto
  *   Compression
  *   LPM Perf
  *   MemCpy

* Performance Test:

  *   TestPMD: PASS
  *   L3FWD: PASS
  *   Crypto: PASS
  *   Compression: PASS
  *   LPM Perf: PASS
  *   MemCpy: PASS

The deviations highlighted during the DPDK v26.11-rc1 validation were reche=
cked. The previously observed deviation patterns in Compression on Genoa/Si=
ena, Crypto on Turin Dense/Classic, and L3FWD on Siena/Sorano were not obse=
rved in the rc2 results.


--_000_MW4PR12MB7213851CB9E785FA23C8E4FFF6712MW4PR12MB7213namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:732385236;
	mso-list-template-ids:2066621424;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1574123230;
	mso-list-template-ids:1308363444;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1838810798;
	mso-list-template-ids:-721652568;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3
	{mso-list-id:2026057616;
	mso-list-template-ids:-1469565166;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Please find the AMD platform va=
lidation report for DPDK v26.11-rc2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* Summary:</span></b><span l=
ang=3D"EN-IN"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">DPDK v26.11-rc2 AMD platform va=
lidation is complete.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Performance was compared agains=
t DPDK v26.07 across 6 workloads on 5 AMD EPYC platforms using Mellanox Con=
nectX-7 2x200G NICs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">A total of 4,789 data points we=
re evaluated. Of these, 4,788 points, or 99.98%, are within the acceptance =
criteria. One data point is marginally outside the acceptance criteria at -=
5.04%.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">All 6 workloads, TestPMD, L3FWD=
, Crypto, Compression, LPM Perf, and MemCpy, passed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* Issues:</span></b><span la=
ng=3D"EN-IN"> None<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* System Tested:<o:p></o:p><=
/span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Plain Text<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Platform Processor Points<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Turin Dense EPYC 9745, 128C, 2P=
 923<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Turin Classic EPYC 9755, 128C, =
1P 923<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Genoa EPYC 9654, 96C, 1P 1001<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Siena EPYC 8534P, 64C, 1P 1001<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Sorano EPYC 8435, 84C, 1P 941<o=
:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2"><span lang=3D"EN-=
IN">OS: Ubuntu 24.04 LTS<o:p></o:p></span></li><li class=3D"MsoNormal" styl=
e=3D"mso-list:l2 level1 lfo2"><span lang=3D"EN-IN">Compiler: GCC 14.2<o:p><=
/o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2">=
<span lang=3D"EN-IN">NIC: Mellanox ConnectX-7 2x200G<o:p></o:p></span></li>=
<li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2"><span lang=3D"EN-=
IN">Boost: OFF, except for Siena L3FWD and TestPMD, where Turbo was ON<o:p>=
</o:p></span></li></ul>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* Build &amp; Compile:</span=
></b><span lang=3D"EN-IN"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Build completed successfully on=
 all 5 AMD EPYC platforms.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* Function Test Cases:</span=
></b><span lang=3D"EN-IN"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Following workloads were valida=
ted:<o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span lang=3D"EN-=
IN">TestPMD<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list=
:l0 level1 lfo3"><span lang=3D"EN-IN">L3FWD<o:p></o:p></span></li><li class=
=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span lang=3D"EN-IN">Crypt=
o<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1=
 lfo3"><span lang=3D"EN-IN">Compression<o:p></o:p></span></li><li class=3D"=
MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span lang=3D"EN-IN">LPM Perf<=
o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1 l=
fo3"><span lang=3D"EN-IN">MemCpy<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></b>=
</p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-IN">* Performance Test:</span></=
b><span lang=3D"EN-IN"><o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo4"><span lang=3D"EN-=
IN">TestPMD: PASS<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"ms=
o-list:l1 level1 lfo4"><span lang=3D"EN-IN">L3FWD: PASS<o:p></o:p></span></=
li><li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo4"><span lang=3D"=
EN-IN">Crypto: PASS<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"=
mso-list:l1 level1 lfo4"><span lang=3D"EN-IN">Compression: PASS<o:p></o:p><=
/span></li><li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo4"><span =
lang=3D"EN-IN">LPM Perf: PASS<o:p></o:p></span></li><li class=3D"MsoNormal"=
 style=3D"mso-list:l1 level1 lfo4"><span lang=3D"EN-IN">MemCpy: PASS<o:p></=
o:p></span></li></ul>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">The deviations highlighted duri=
ng the DPDK v26.11-rc1 validation were rechecked. The previously observed d=
eviation patterns in Compression on Genoa/Siena, Crypto on Turin Dense/Clas=
sic, and L3FWD on Siena/Sorano were
 not observed in the rc2 results.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB7213851CB9E785FA23C8E4FFF6712MW4PR12MB7213namp_--
