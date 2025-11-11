Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01867CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 15:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07ADF402C6;
	Tue, 11 Nov 2025 16:09:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B7B11402B0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 16:09:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762873792; x=1794409792;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=us+Q312JnamSQJ3h9krQStIPg0usFlx0QaNRTQQVIxQ=;
 b=mTYLStWvXAT3rOS/LtzUaKepHhAj7hwVFn1G6nqfhoyqpfPYk/Jb/A7I
 r5QXwcdvciI2kiJplJ/zOJBr8OpywjAr3e87+zOxrPUzXfBuMarBuftLk
 PwpkL6Tn5mfhcHZcjXeH9zd1MateRrc36KrEKPNrkhT/ww9Lsd2iwxS05
 6ONRW+4FB6njPRyzp/F1vHkji6KgfTXzR07AdASBZUNZo7yeosOuncLnm
 ssed6R7yV6P/nx3AMe/LcFEX6JjFh1F8XlD4L216X26E19i+zWZrd1aX8
 6o+g12sqwSLGQp3MtZ0ZUJ0oV4X7SpW0rXoB9Tf1ldr4G9l+ULkIj6VIH w==;
X-CSE-ConnectionGUID: HJfAS6URT1WISyJQ5ftfeQ==
X-CSE-MsgGUID: dN/DrsgkTpmuppfDNzAooQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="52494054"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; d="scan'208,217";a="52494054"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 07:09:51 -0800
X-CSE-ConnectionGUID: scDdTaRLStO/iX/aVHqn7w==
X-CSE-MsgGUID: WvoixKQGQ7edu43kQrwRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
 d="scan'208,217";a="188950133"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 07:09:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 07:09:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 07:09:50 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 07:09:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjpSmPsokP8R2j2uPsclku9+I1WA/HWSoG/tbnEIYvXb2G+FsTDq6//6OZ46qJPWBIzvb0l3MJerlnTCb+s2SL3C6wBwnzzwpaFBeJV35XwDxjKgEmFB1jii42+YFVZkn0PhZf1i/NSM0k4d/gOcW30vNK4SGSaKfipLiSjyb97nZDVL+MRRIxQH+RMrwlbFOUttJInoKQA2qYguEcKvbYWSMfWl7ZmD6hQJccx62lk9g2biJvSm/kg+DpU0GiySDZuqA4+HVVF6iYAgw96jJA7NNcNC8yDvhdPgeZwG39wzOO9nOkoXOPn+uoQcCgayqVHJRjtk1aGBUfH6HY7Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsFPh+NoJFUcF8bBGFh0qoEn1wyeEIBGF4hWKbgKh34=;
 b=macJcYvZzfP+uFh+KXPSdJ8zfiOzDr8fPKPoP1YNvfP8aDzezwsW+epu86nC6ubZMLCTJYWQEt1bJNSTEvRCX5HuJXOGSnRPaHsTUkwyEq2p5Om8slLctbpNiGi+KjOhnFXQ/5bJPAxGFa2YzHrcYhhaY+lUkj9v+Bi4t3d079oXp9tFQVABTrmO/QP8p3hpV2NROvihce9P7L5aNcFKe2ppAgRnqQ3Iczu3qt/vSGbk9cvDc2s1jZdYm9yYKjtvApZtHrfmYg53GZlDoz/zG9xOfHBAQVYP6a3dr1/o/vPr6ZBtAfIKt1mbqbcGH53j9XndDR+TGTKGyhQpL7yntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by SJ5PPF8B3F23403.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::842) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:09:46 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 15:09:46 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-11-11
Thread-Topic: DPDK Release Status Meeting 2025-11-11
Thread-Index: AdxTHSQy5VDUnbosQn2pvnfrVh5sJA==
Date: Tue, 11 Nov 2025 15:09:46 +0000
Message-ID: <PH3PPF37F43E35DA61D29A2FF10D2EB8F0BFCCFA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|SJ5PPF8B3F23403:EE_
x-ms-office365-filtering-correlation-id: 75e560b5-d240-423c-2a77-08de213459d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?brfJbKYT6iPiB85LeRQqRDH3CUQBDT0vPPUlw06REK4YXuC92TEVTJfAx8nd?=
 =?us-ascii?Q?IPMAnhM1zKPEzi9HODglf24XD87t7lCqxTfsC4RJP+aBLlBxbBc8fat30N44?=
 =?us-ascii?Q?QcW7Hh55+I2kZyBXVs9eNmzD8BTl7+sbk3eZ0l/r8Vc0sn2GhcPTGsthvIP5?=
 =?us-ascii?Q?nmByZnvdnfnw1As91BR/fJPxwvTS5QqYAAjX8IzcjFz2XJMY6emUEqFEgXq2?=
 =?us-ascii?Q?DrnrDfAtjH7QsXQPhpbBs2vXFBKBGxhgRupNjgNr83RFmmLeEBj8NdEIOQxz?=
 =?us-ascii?Q?G5Sbd0/vQvWBlsnzNHqS4FXRV3EX7kJrIdgIiw1pbtcdMAyd5FCTBYVCGa30?=
 =?us-ascii?Q?QPMh8MXd+zA1ZWofrJMpT5AZB7gsvEJZpxOgWZuUvOgYi1Bd981dmXrFCH6d?=
 =?us-ascii?Q?/iUMuK0Aw5N3ZrB8TACMlq3LPq8TnTSJvHpa1/ZHDekl0Y99s7z8LjDqmE6a?=
 =?us-ascii?Q?WhiOFw+es7+U6Oos0CDag6ItJERgabUWep2jfTnl5PzWGkackdbSWyDhiDXk?=
 =?us-ascii?Q?3DnXZ83wJ8Ef1ODK82ct8KynHxpPNgKY8Zjx+f9UMZjae90LgLmzhTRwQqIM?=
 =?us-ascii?Q?o38IFa5OJfGW6F4aJNx2y8SpkF6DNzALAmnXWjZjOXeq/zI7AcjqpGsnfULM?=
 =?us-ascii?Q?XnnSQPpxrPZjSLSJ5jZgiJvg/TaJoI/IXJHgBnEymd2rfRPF/4au5CDV7sL6?=
 =?us-ascii?Q?GYbadPx99jV93RPbswP0f+3spLe7KgEIZGHPq6i0ITlEMUko5pdSnbdOrwN9?=
 =?us-ascii?Q?vsVTntENZF3sOifccw0yCDUU/i5WcOBvlZ9kllkUF5kzOtE8acvusYctmuni?=
 =?us-ascii?Q?M/7FPMl57zWi3452HqNlLiV1UYPpl3uvjdXR6MClS3HjVXerRlgA1T8fbXnr?=
 =?us-ascii?Q?WbrMJWQkCwcFTB+izvrCsmSt9xpV3Iz76H5o/Ji6VYvO6CrRXih87Zo9uB3F?=
 =?us-ascii?Q?ECVpoGaaKDjmKbccyYps1uxcpIrrTeG9yYz/uGN2gVKMCTmdhVBAAl8OunR8?=
 =?us-ascii?Q?V6GRHUwRbIel638DQL+Yw1jb0ZUwiWwmeZw91XtDMbw+184FAcReRBWpFMsG?=
 =?us-ascii?Q?A/CugL86EBVUIuYSHygARXhakospJIbMALqNwpUX2OiDS3FbRmWmyMjexHhg?=
 =?us-ascii?Q?QnWlrkAqT+26jk7kuSPzi4w83vVULWI0xROWU00xCYpK+zu6MM2jcni5txFi?=
 =?us-ascii?Q?R+XdzhKoxHo1hQTFqKCotuIrb9VuuSWNkrDrC268Cs8CHFXNWqxdn3rpquzc?=
 =?us-ascii?Q?1Irq37dUKZ9Ewpv7l85bvXNix98fRWyLyqLitKhbt8q4/5h0zlqlMRhCN2vE?=
 =?us-ascii?Q?fdvGuhaRiiqfmV/FkRLvfXML4PaOPr1U5n1yqrXOZFhgEqUR3IiYm6xkH9bs?=
 =?us-ascii?Q?sSYtyINWd8a6gu3vmYID0uosZYp9WevRhGKO+RpwRJtIx+ca9LfdLdQPMGWd?=
 =?us-ascii?Q?hPDUYAKg3TyXTwMsI9iPrLwptImgM4gdoZZ1pTTX6weisr8U9rhQkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TO3zP+7X6g+UhjuwrUW9wp/g3QqK8T/ZvYa+AWUHLvd6R7me5iAnTLYvSRzq?=
 =?us-ascii?Q?uABQWGaRevSrqHJ/iCoM5P41xSDdl32L9UnZVfD6GJZ1ro4l7A4xMjZfujlZ?=
 =?us-ascii?Q?p6zUxuTaF9aMLXE0hAjNpGm95AADHDvECSi9g5nPJB3zb4cFH7kJPYuCs1YF?=
 =?us-ascii?Q?kfD0AiR8srIkYPkstXRG9/QzsDkcysU3vHfDcIXup4WEjkmVTq7vJgTbXni/?=
 =?us-ascii?Q?+9uSVBB3NGcw+fSjnJK5aVYKaLKssQIfuCKpfoT5V1KqaFqDsRdcKITSjSwC?=
 =?us-ascii?Q?3BtcXmsaaCQTglOkqKQsBXmt2p9r/YdQY5aJaJjXBfTG+5rp/2I+nJ9kB8NU?=
 =?us-ascii?Q?9+KQKpa+JRIr///n4tQzLp3Advlh4MXUEWUd4Ir1+jQZ/pCl04l5N5hozHRt?=
 =?us-ascii?Q?lXy/kP9KgrUaAWHCl7rxyRsHB7eVLcchAQh3/JvgX2gOO2sNmMkcIA/sQ145?=
 =?us-ascii?Q?tkzdNctLwAFiygABmS0SFrm/Yz5AvQ52RZcns5r+aSpmAk1Wb0liDBbECUfW?=
 =?us-ascii?Q?1I6KeGajK3kv2KWLGJqOCSEIoGjejX4fKVPHZiQGmrL8bvLIL0bfP/4PCjQW?=
 =?us-ascii?Q?N04KyaP+lyfP8D2LU7fhOrkINfWJ4+/ZeC8aE7Nw70z0iBeyComJjKTW+RvC?=
 =?us-ascii?Q?+PRCvHObHj1RvEo8S3vPB4RZydbl9oalp8ERiIn7TlZja9Zl4DSqVOIu39Lg?=
 =?us-ascii?Q?mabkvuklDaXUzw7wGM1n64NS5bp0KfJHHycsqmPbzaWRdXv2WnfJBr209ans?=
 =?us-ascii?Q?ZZFzzp63dWqUXUeOZeY2r5WiT1OF7/Kv/WPiDdENvXpEjjIsiVzIw5kEtGSX?=
 =?us-ascii?Q?vtDeUT1cN+IOyCiNMt4hZrQvdSOGXY9yVxbYWheaJEGf8oRIgkmR+wKRIKEE?=
 =?us-ascii?Q?J7oAUzpp7swjN8BuTFBY1E6ORZJH50+bw6x8knHW/9BKl8epkWo7TDaZaTra?=
 =?us-ascii?Q?CwFBytrH97HbCjQ8U6ZQw8YZgMXcD3AlXhnfSWUNiua5TtQaLfU1bZSadkdO?=
 =?us-ascii?Q?tNldoRwhyVKxQ6Hbx2JeXJeQJA80XgjsREQYEWeo4Q2Jy2NrcC6ylPa1DUw8?=
 =?us-ascii?Q?+LmYAup0yoUWsCIz2PDiswppu/CUWsFVraabN7Dp+ERoeEiSwj6pzJnwUF+R?=
 =?us-ascii?Q?A4Z1jRgFjjH+IK0JOd1ahEgKrAwdqer86WnZs4/GAhM7h3oO8gs7obK21lBe?=
 =?us-ascii?Q?F0xhP+QxAoa0O341QTaAvTmHqffGZjFDjyKWZlKTaC8vvK3VkVQUHIs6AvsE?=
 =?us-ascii?Q?x7sof79FsfYncJpW6/hlRNYeHUJGlw8FeoD+V3MFoLfvHM6wnonai+7BbCGm?=
 =?us-ascii?Q?+9ECaAychfYVxxWBF9gpKlcv6S/8mcEx1KiIqUM+tCkdJsJ1Xf/Qr3bo4Sor?=
 =?us-ascii?Q?1UqC9BjU0x4y+eUFel59IbUkg50uRoi9nhZzx1L9ndjHAquEbEGC9Q/dxvnd?=
 =?us-ascii?Q?0hQzNxOg8YJlLyWHIUSCcxDNFL0K+OA4pmysLXXFUYMqfdXrprsO3V1URulZ?=
 =?us-ascii?Q?yHZSuyKhHvsmnWR8YRLfrarT5+yBiMOZZLy0sVnI5dJHi36rxXVI4sY2ph/D?=
 =?us-ascii?Q?xIT+yG7NwQrE7/PLi7XaSaLhy15zgTOUJdHiXgVV?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DA61D29A2FF10D2EB8F0BFCCFAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e560b5-d240-423c-2a77-08de213459d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 15:09:46.1928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfO10cPClpGHX9TrrbB/IAfgjC3ABpadGen5qOsjFgGnaceHEKP0E0yfqLalb/ijRwB1OG24VrBp3QNVns4UdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8B3F23403
X-OriginatorOrg: intel.com
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

--_000_PH3PPF37F43E35DA61D29A2FF10D2EB8F0BFCCFAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-11-11
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Broadcom
- Debian
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 24 October 2025
- PMD features freeze (-rc2): 7 November 2025
- Builtin applications features freeze (-rc3): 17 November 2025
- Release: 26 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - Ready for RC2.
  - 9 to be reviewed.

- next-net-intel
  - Ready for RC2.
  - 4-5 in backlog for RC3.

- next-net-mlx
  - Pulled for RC2.

- next-broadcom
  - Tree pulled for RC2.

- next-net-mvl
  - Tree pulled for RC2.

- next-eventdev
  - Tree pulled for RC2.

- next-baseband
  - Tree pulled for RC2.

- next-virtio
  - Tree pulled for RC2.

- next-crypto
  - Tree pulled for RC2.
  - Some patches for RC3.

- next-dts
  - RSS test suite merged.

- main
  - RC2 should be out 2025/11/11.


Other
-----
  - None.

LTS
---

Released LTS versions:

- 24.11.3 - Released 2025-08-19
- 23.11.5 - Released 2025-08-25
- 22.11.9 - Released 2025-08-19
  - 22.11.10 released 2025-09-17 for CVE-2025-23259.


See https://core.dpdk.org/roadmap/#dates

- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35DA61D29A2FF10D2EB8F0BFCCFAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-11-11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Debian<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Stephen Hemmi=
nger<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 24 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 7 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 17 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 N=
ovember 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ready =
for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 9 to b=
e reviewed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ready =
for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 4-5 in=
 backlog for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Pulled=
 for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Tree p=
ulled for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some p=
atches for RC3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RSS te=
st suite merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RC2 sh=
ould be out 2025/11/11.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 22.11.=
10 released 2025-09-17 for CVE-2025-23259.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Debian=
 13 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 9=
 contains DPDK 24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35DA61D29A2FF10D2EB8F0BFCCFAPH3PPF37F43E35D_--
