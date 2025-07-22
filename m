Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A35CC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 09:00:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD3F840A79;
	Wed, 23 Jul 2025 11:00:04 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 59AB44065C;
 Wed, 23 Jul 2025 11:00:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id F40AA4003C
 for <announce@dpdk.org>; Tue, 22 Jul 2025 17:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753198338; x=1784734338;
 h=from:to:subject:date:message-id:mime-version;
 bh=kOpS1HeORXTynU9SoXSlJDPmwlsOSq2dfbvoHiTV8WU=;
 b=Ip3kjNctq+t8rFV22OTRj8xKqaX9RUhZXvyn5XcCwCglqPhQzstuQV9A
 XRqvUDPUVciJRGJ+fWnk2+ZvMm0YETF017siaZx7J/vuqLlPN1DvlzoI3
 0Bo0DnHmjf4uEL1ng7WyieeLlwYnzXgFCkkST12gUE6CJprOtk+4J/3y3
 yyoc/PXhKWEqfJaB/2LenLLHPBxMg508e3me7h2tMxTPR2zsHdlgcev25
 NH89bKPsoVyJ5uA1dgeoSgc0CeaDLs2YEJ85bg6yfnVBd5mu2JqanMaJM
 pFK2Ttmsix4O13hVi3jFTx7eDaaUwOkey7PhEsOaATRYyerntDjFbh7DI g==;
X-CSE-ConnectionGUID: qrx+u1fjTR68fzoza5GIOg==
X-CSE-MsgGUID: kG2NZOymT4SlrMwH1qw8CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66142053"
X-IronPort-AV: E=Sophos; i="6.16,331,1744095600"; d="scan'208,217";
 a="66142053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 08:30:38 -0700
X-CSE-ConnectionGUID: goCtZVZEQtyuwIX6JZbPIw==
X-CSE-MsgGUID: xbpCopyKSAecd6jM/VX/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
 d="scan'208,217";a="158477841"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 08:30:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:30:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:30:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H34OBDGqwtNB4CDkDrN/veGJWXphldu+fwV8yNVjQumiQvqtsUsy/q6Mft1nAMjb1Dpc+wCirC8Z5PsB1+CEdGUnf2qVDh1UWsL53tQbPHWfMCSsEr92cJn6MrlsESr1kbrRwuxPSoFqDCROQxL9Xi8ub8/EHeTgszc29sXBwg3BhNVDG7QMRxXh2QMNOwpsd0uuLxQZByt1eir4SfDb1AcbLhq0E3ZgPINWDh9bANPWE9Wf1G1nq8GOyli2/Rx57BtWp2+huQtb3Ao2Zk7VaxctJyQsXWkBoI0xwKQaRdzcrpoh4LlyCS2Z9SR/L/VeQGSkuJ4tpbuhQrwplXLZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTqGmhfK9GBedyrZ6ZxlpBfE0D89umGsKW4tEwmJkMo=;
 b=gwuY2011aHO+QE3JRC/liyeNN5yyuJjNXCuAy5jNB25DIjIWU4TGtkA7+MXzbVls0pHGT1i15jU7fIYfEzGxTNhU2nfeBvh4wfBVyB4lBh6L3RydNSICqZgqz7XtaKNnoLz2l8+SHCm/3SJKAJozD4b/UZkENJ4HU2cXOa8pfe5QfW0wgzyiC9xcHWF8DDVADE3wCdVHqAQTafFKubSjNHbzjmOFINAZp2Cuq4pOmpoSchCfAWasZapEE0HaKL5vQGXyYA9/N1S8B1k6wwvI98DnB2Rhy7rxEfMNp0QBnQW3TxpZXzT/qSPstcOQXIy+SedyQ/ckSGR0yHuc38n3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF3ECB6A513.namprd11.prod.outlook.com
 (2603:10b6:518:1::d19) by IA0PR11MB7881.namprd11.prod.outlook.com
 (2603:10b6:208:40b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:30:32 +0000
Received: from PH3PPF3ECB6A513.namprd11.prod.outlook.com
 ([fe80::17ad:c14:3ae3:a1c]) by PH3PPF3ECB6A513.namprd11.prod.outlook.com
 ([fe80::17ad:c14:3ae3:a1c%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:30:31 +0000
From: "O'Driscoll, Tim" <tim.odriscoll@intel.com>
To: "'announce@dpdk.org'" <announce@dpdk.org>
Subject: DPDK Bay Area Summit Cancelled
Thread-Topic: DPDK Bay Area Summit Cancelled
Thread-Index: Adv7HOJtVdzBZxM1R7OO3XMUzUENiQ==
Date: Tue, 22 Jul 2025 15:30:31 +0000
Message-ID: <PH3PPF3ECB6A51353876C74951580B25DA4FE5CA@PH3PPF3ECB6A513.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF3ECB6A513:EE_|IA0PR11MB7881:EE_
x-ms-office365-filtering-correlation-id: eadb39ff-26aa-4010-9680-08ddc934b1ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+73mmPrCwfFdzS9LYKWloqBVQCCWWPi23l3CH1t9yWl8UNU3/YHOOWXC6SeS?=
 =?us-ascii?Q?dYcdghrXcKd+L2RwO9f18aTYduf9GFEQ2CWzIok1COF+MoCGNQ6vsppofVTA?=
 =?us-ascii?Q?nIKEpBbzf893wHQbviS4YclPkGKhFSXpFtogGOBuUIefhPfhfZC+eWcRC2N/?=
 =?us-ascii?Q?1c93NE2dZiGrMDCTr9B0IKNNRcNde9pBl9XqkQZMTJRJzgeVfdbQV6/QfPSm?=
 =?us-ascii?Q?GGKjoi9bzluzWiqmIK5znIuDdI5lU87mBWwWMCloxv0qFOen/YAQ0h5JZOB0?=
 =?us-ascii?Q?Aeocp5IC2No9lLEAqtDc/pPuse8yILElFuGUyjPIGMUphTeQ2hR50pjq4+dx?=
 =?us-ascii?Q?qk2+/tRrGK4eD4oipDP9xTvA95TwJr3k/9jVU5MVLlkF5sQkJEjYdjN+ghx7?=
 =?us-ascii?Q?FSsc1gEHJa8lvQsj7MNO+6+i3GGT2pGqVr01EROekBEPMeIDTuldxxwgFfl+?=
 =?us-ascii?Q?9YYqpMSfHUfxWT0wWB614UVS6yM08AldAXTEI5t/K/O1BBsBGjoo3X9WcN5s?=
 =?us-ascii?Q?5HNsjgPJOQ59brEv4tXhujddpKh9uf5KslfkU055qAC6blIn0lXu3mNE9arp?=
 =?us-ascii?Q?mBaafHAKN6C4I7yXU+K58q+a973OKRmLZBS83yN6e7/bZszbFjEx7YdWcXwT?=
 =?us-ascii?Q?5OWyX0WNxVKiQ1c0dlmzR96+WhV+mE81QSrIqpAGt8ZeYff/Nf9x/T7AOLMa?=
 =?us-ascii?Q?dJ7W9I4SEn7gwC9rkgPjGG1I+bzBmudBXDuXjhkfl44262reRR/cwBRqbrSG?=
 =?us-ascii?Q?oSlnnf956fRZ7C/84Pizow1EbP/LshcKTWBO5xLIfEzY8gYrV61D94ngrcFl?=
 =?us-ascii?Q?QJm7pvbvLwed4+wCrFnkKHpmqokwRqtAAYYf7qfmdgoEy8IGTrY1gM9SoGwJ?=
 =?us-ascii?Q?34g+qiSPKwSyHAPuRHQ/MJjHV1Fwep+x2IYujeZQTK2JbdtdW3Kp9gB3Nvdl?=
 =?us-ascii?Q?bgUdKlh7EGUNoX+jPbkEW8bjfr97yYbZaWVDabnswlzP1v5vMYLy88FCCiEb?=
 =?us-ascii?Q?FczUJW7dLuDfEwrhtBPJeJqWQheoOAAQ/X5TuWvrgAQ6VfKB2B6QVsmJFH60?=
 =?us-ascii?Q?4jgdZ0BQqgQYbHgmw1FpoCawo6RGtgZ7qEuCVzuYaNUtw2rnR7O31wO64LMK?=
 =?us-ascii?Q?YwJG28Fnkgcd9Yi6Q2gj5I1agNYJIe6L4f4w+HmesA+T7BXtRnfA6egEsrOZ?=
 =?us-ascii?Q?eGcY45RXr5L5o3aFk0ijWd7VY4JLcjGd7IaNO7Men98zBpYqOWdF/PyKPkhV?=
 =?us-ascii?Q?S9CbNKbf/I8NDmc5Y0NAMeIRFpoy2gzXpfDePIB1t81JxHaG0LFowGDxZ4Et?=
 =?us-ascii?Q?uH6nXGlIW6PHfUCj/Ah1crelAThHGSPihbNmPpI+NP8XdhKq+4gplM0kI3jt?=
 =?us-ascii?Q?3IULNZgHfrXl0c7dnQR0mjP63tlhjmgAxxh12RoTMhOFU4aJqSrtZZNzL5vI?=
 =?us-ascii?Q?0S2JV5WKFWtPKmTKWcw72zqqgzTqp+WKpMc20956AooC9CWxYhsgTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH3PPF3ECB6A513.namprd11.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT; 
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VW5cgx8+IKn7OszUXBspkWabgA24k2wVPL/l28BviQg5BE/WoWg05DvecLR7?=
 =?us-ascii?Q?bvyzX+0gYZPnUyylRFnjjXK7rX002KEBzYsefGItJTuaDYW+NjmmOjkfsEUz?=
 =?us-ascii?Q?2aGcyywVBvav6LTZLvHXXJ8S658BWG6pXBqiYmBdOITUdv+QfHJQIaJjggfE?=
 =?us-ascii?Q?r+eb7/3WZsoQCWMbLjUF9qY0f6WqJ/r9UiTJohtPL9q5s7Kx+VwVJ8ZF7o7K?=
 =?us-ascii?Q?Mjg3SILxdR6ehbsfyfw1EICWMktTYeTYKDqdAo/UkjZqH8LU1yfSzCIbBCCC?=
 =?us-ascii?Q?Ka8j9V/qjvRpG2H4+luBvAzP0jaSnmeRH1kQtAp8aWyqk9SWagK4fkvjUPwj?=
 =?us-ascii?Q?jAjqkYEougiChE03XfpwjbmAk3YUwqgAfUd4g1tnFo+9MnJXpd7RWvQKPmAF?=
 =?us-ascii?Q?2weOsdCzXt2AXDaYxfsBvlmkl4lnHiOa5iFKFGq6fG86IaAtS7hUux69L2Ob?=
 =?us-ascii?Q?reOAw6HJpPWDWsIbsWj0YW0WxA0i8GY4AzDjxVrmf1eKTUhPJGH62SdTiVyN?=
 =?us-ascii?Q?nbXEPKbN8e7Mbl9hvxKPMZAftEaRvJKMeKnE/6VrlNmuRPcZjHJYggXa4rZD?=
 =?us-ascii?Q?i7oIduucExYWHRz7pO1+TpQpR+8b3xiddvlOJi1s+Dq904j9Pt7HKrh6L/kM?=
 =?us-ascii?Q?ECGdFYarCerwqwtOSVl/ZPgmODzGTyKdFT3Eg+ouZRlZVH8+hdcME8Zs2SbW?=
 =?us-ascii?Q?6wWUU1K9gpF0OJjgKIQ6drVEBGFLd1jAn5zJDGP2srS7vNfSPbQKDQyWJa++?=
 =?us-ascii?Q?C45OIAlFgRXbykDV3BveatzGEdVNZuq1ACFb6yDcu4C5LVfaoQqgBWe704Hu?=
 =?us-ascii?Q?xAbdk7J1TUfDlQI//9s9NbgJ6l6s0APcudl0ZpSe1KzSDo2AsUUiCprDwdoq?=
 =?us-ascii?Q?Zw8la2Q0QtA1uh6K0k0JcSuHw0oBc3gu0kcdUiRRTrO26q456de4k0OaZFm2?=
 =?us-ascii?Q?6+lJIvnS48o0St52EQc6y0jrGyfRos9dTAQWilvJW/zJpQQyd/vi7BXVJuGB?=
 =?us-ascii?Q?YMw2ljd6KxW2IuthAGnFXKWejJA6m+p0yXEun5jJd/mwE8FsT8t0W6zA95lj?=
 =?us-ascii?Q?i0WHO5QTFgjsUd2M93xVkslSjW5dX/tMRATjRKy/RWXvzV/GRfK7x33h0GxU?=
 =?us-ascii?Q?iK1divtagwy7lqXKlzSCn3bEFOBXlYGyugpmEABhF/UWhaSQkADaJ9/+zna9?=
 =?us-ascii?Q?i6fKrqH5Cb/gvr3GqP4h7pSbAz0c6cLwb3R1SYUTvgRYMOvoDGPafqAtTAge?=
 =?us-ascii?Q?sanO1J/vWWvHiaVFQKAVTmKvDGIU5Eyet509r1t6K487nbd7RXvTplVC/rlf?=
 =?us-ascii?Q?Mf0gSoCwL01GFnmx1PZW3h/r1QU9wXtjASzb3gQFSzok57OXwLdsXPYoeXqR?=
 =?us-ascii?Q?3E/AkaTxhO0Qi/iII4ojrv5I6yAsspePXX2ZnBSBOrCHRcIuO6hHzd7cfuWp?=
 =?us-ascii?Q?XOolv8ggDBtgo9i4fZptRfZ980/nBSlEkIQh74l8BebCLCmBJDW0z5zGROYm?=
 =?us-ascii?Q?mUNBO5S37YGF4GrkGP9B/S1lbrLzbwicU6dc77MO8aRMCyDe/NmiNhsYJp2W?=
 =?us-ascii?Q?psfxGCBgex071HJzzpaJ3JfxVsWhIV4pHI4JIBGg?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF3ECB6A51353876C74951580B25DA4FE5CAPH3PPF3ECB6A513_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF3ECB6A513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadb39ff-26aa-4010-9680-08ddc934b1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 15:30:31.6516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD8vvBCYt+gaCs36OGD5MzfnG0EHoCeT27s2PBz3+KTBW2943HKFxGlkWvMTfj3ZG72ma06gFud5TsMLxBpsFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Wed, 23 Jul 2025 11:00:02 +0200
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--_000_PH3PPF3ECB6A51353876C74951580B25DA4FE5CAPH3PPF3ECB6A513_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

After careful discussion with the Governing Board and Technical Board, we'v=
e decided to cancel the Bay Area DPDK Summit planned for September 17-18.

After our successful DPDK Summit in Prague earlier this year, we definitely=
 intend to continue the DPDK Summit events. We'll be focusing on plans for =
next year, to ensure we create high-value events that bring together contri=
butors, industry leaders, and users.

In the meantime, watch for our 15th anniversary campaign celebrating DPDK's=
 history, major milestones, and community contributions. If you'd like to b=
e interviewed or have a story to share, please reach out to marketing@dpdk.=
org<mailto:marketing@dpdk.org>, we'd love to hear from you.
Thank you for your understanding and support. We look forward to connecting=
 at future events soon.


Thanks,
Tim

--_000_PH3PPF3ECB6A51353876C74951580B25DA4FE5CAPH3PPF3ECB6A513_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if">After careful discussion with the Governing Board and Technical Board, =
we&#8217;ve decided to cancel the Bay Area DPDK Summit planned for Septembe=
r 17&#8211;18.<o:p></o:p></span></p>
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if">After our&nbsp;successful DPDK Summit in Prague earlier this year, we d=
efinitely intend to continue the DPDK Summit events. We&#8217;ll be focusin=
g on plans for next year, to ensure we create high-value
 events that bring together contributors, industry leaders, and users.<o:p>=
</o:p></span></p>
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if">In the meantime, watch for our 15th anniversary campaign celebrating DP=
DK&#8217;s history, major milestones, and community contributions. If you&#=
8217;d like to be interviewed or have a story to share,
 please reach out to <strong><span style=3D"font-family:&quot;Calibri&quot;=
,sans-serif"><a href=3D"mailto:marketing@dpdk.org" target=3D"_blank">market=
ing@dpdk.org</a>,&nbsp;</span></strong>we&#8217;d love to hear from you.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Thank you for your understanding and support. We lo=
ok forward to connecting at future events soon.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><br>
Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Tim</span><span style=3D"font-size:11.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p></o:p></=
span></p>
</div>
</body>
</html>

--_000_PH3PPF3ECB6A51353876C74951580B25DA4FE5CAPH3PPF3ECB6A513_--
