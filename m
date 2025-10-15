Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B85CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 08:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4844068A;
	Wed, 15 Oct 2025 10:51:03 +0200 (CEST)
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [50.112.246.219])
 by mails.dpdk.org (Postfix) with ESMTP id 864324068A
 for <dev@dpdk.org>; Wed, 15 Oct 2025 10:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760518261; x=1792054261;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yHQKFPznCaH645SrIMaBY6zbK/Gjbcd8zFCcUeveqDg=;
 b=E7Wp5irnQF+5KjZcUloNbPsBzy2YnbvLCJzoawr7GNA4/GwwI49xeOlq
 791sZOT2Ymr6kYstsjVFvQ1+8YUByWH125F0JQeaV+LmQKwUtIsGI71w4
 OI70eaot6r5OMdxp9KKFFmpcE3AmcnRP6Ib98FkoO9zGrl0Az2C7QWMUY
 KKal7FoipdzGGOVmFYOrXVRXuWrFxB7v21R4N0tYIr07atqBsRzBoCNnZ
 mS4tgd7jVc8z63yDWJtj+tO53XJbtoQWy/sJRcrc7zaX/oT2vq6HljaAj
 0L7EAPEa+uldAd/8ogtPpUvbllXQ+lMiMvAk9D1mb2Nnw5mP3k8Aril2A w==;
X-CSE-ConnectionGUID: 8bYUQ8mtTo6vH1ShjJODCA==
X-CSE-MsgGUID: tEhwJbvmQzmIAYZ+VEOOHg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4721052"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 08:50:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:29589]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.112:2525]
 with esmtp (Farcaster)
 id 8f3b860a-bfb2-4ad6-927c-918dd4f94fc0; Wed, 15 Oct 2025 08:50:58 +0000 (UTC)
X-Farcaster-Flow-ID: 8f3b860a-bfb2-4ad6-927c-918dd4f94fc0
Received: from EX19EXOUWB002.ant.amazon.com (10.250.64.247) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 08:50:58 +0000
Received: from CH4PR07CU001.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWB002.ant.amazon.com (10.250.64.247) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20
 via Frontend Transport; Wed, 15 Oct 2025 08:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS6zb4u1RgEwqeDhOHQvYMbUJbWHCJ3+c1Yd6sTCt6eBNzaXi1RPDlNOtXk+2oyVET0nWOCAtWTukEH8gxNDmVR7QrNND6P8FbfJAavXI5wmFfaBDykFFpO5EHPzHmb5ux8u14zgvCBliVDAKO95CgPscBBvv7TVbkKzCCjNCzRfyjD+YB2SkNHHODXGJUsIpRIwaTRNCw1EY4lA1fk2NvHRJzpcuJ9zMPSltZ/R/2N8vRTm9cBXuoURj/7IU9v6xDjXar2G2MFlcO5lD+8VcW3zAEjCcyjKKxAc9YXPJWdb5VXCcEABzg35TWAiLu6z1+XNAuif8bYQ3fgEuhlT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHQKFPznCaH645SrIMaBY6zbK/Gjbcd8zFCcUeveqDg=;
 b=voCYFkW4VJ8lom8jLl9H1d3GSSLRv0PWyU8xHtyF6t+zR2UoQSTE3xFm+z6LTgBSJLvJd0mD+dilsAmqxh97Zf2Ifw6d9BC63WCV7GxcJbrlZAtRUaWVa3LqKhseLsJANY9rimMY9JLfyQ0fOfI28bSdwCqMyqGkdRe2cywaX6RFHaSMN4TXR+2xjhtDQW13mQGVpJZ1w7abuu1JRSBR0VK95veZKtHSMvBefBYiCfcML6U8cBp4xcVMj4SHwH9skYzihU+0WGdi8K8G85Y/CrS/VrsJWgh1Hk07Y/a1G4xyfg+llLpAwGvD/ifEBlswWv5RVBqpfKlIVspRDHDzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from CY4PR1801MB2008.namprd18.prod.outlook.com
 (2603:10b6:910:7b::21) by DS1PR18MB6227.namprd18.prod.outlook.com
 (2603:10b6:8:1eb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:50:57 +0000
Received: from CY4PR1801MB2008.namprd18.prod.outlook.com
 ([fe80::669e:cd9f:cd7e:2a9e]) by CY4PR1801MB2008.namprd18.prod.outlook.com
 ([fe80::669e:cd9f:cd7e:2a9e%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:50:56 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/21] net/ena: Release 2.14.0
Thread-Topic: [PATCH 00/21] net/ena: Release 2.14.0
Thread-Index: AQHcPaJal0+UrVQYqUyQ+XWeNVS2+bTC5hkw
Date: Wed, 15 Oct 2025 08:50:56 +0000
Message-ID: <CY4PR1801MB200849B3E18B7C99C0658BADAFE8A@CY4PR1801MB2008.namprd18.prod.outlook.com>
References: <20251015070707.340-1-shaibran@amazon.com>
In-Reply-To: <20251015070707.340-1-shaibran@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1801MB2008:EE_|DS1PR18MB6227:EE_
x-ms-office365-filtering-correlation-id: 07f0393a-929b-4fbc-6e81-08de0bc7f4d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UVzy88QED/BgfvuwJj7EYlachNxI6wqYVhwc5qQ9qYdhrPu1Auy1/bj+pb3g?=
 =?us-ascii?Q?P4R9HGE/jZR1pl7PrQR2xuDC6hQaF1G/VD/NKg0WQ2fVRSCnhlI7cFjz3bGi?=
 =?us-ascii?Q?joccTRhopVy5xxfUXacS1296CCGRPUFgiyQJ0JjH8OO6kACLgCr/tZp0PO98?=
 =?us-ascii?Q?TwxtcauOqd5GQyCdbbRS71wgt3g4/+wygH5gK9zTk3cSyiX9f1AnwMwWpzKZ?=
 =?us-ascii?Q?osEcF33z5qGzSYfNLm5mOYEB69R9vAkGIIcHnJltw6lUV0OINUDueahuNcPg?=
 =?us-ascii?Q?KD6GQbDRxuAYY3OqXEWNZzrHf/bMGb571BOx9+6l1xvCbRf6lIXuz33rOvZ3?=
 =?us-ascii?Q?tVA0Az7g4BkLR03DRWm7NYUecVwiaKhEHpLR+wvUhOduNBdTy1h8GgwTA2yz?=
 =?us-ascii?Q?u5Omkvkh2cmJf7VBsSnOvSdJ8UJTAIKImb21E4wrqge/6EHertDAKCnKt46p?=
 =?us-ascii?Q?2FY15BA1zilmpQ6GF6dHnqeITEEONANlTcVcX6ybMjNsKHMrgzvPjqc/vNm5?=
 =?us-ascii?Q?ugw4jFtHFzfqtm4kVqfJtKIrbs5a438tGg82VkinYqTTOLD3hgV1yYZ97KgK?=
 =?us-ascii?Q?ART56wILFybMql3/jb9EyjdL2Rz/rMFt8ZNbwnPcqIJYleLsYFcbj9aalW1e?=
 =?us-ascii?Q?TW51sIdOL6X2bwTvps1Yb9VSrj3ZuAE4UWcWP6+G1tt0UZkHrPweHxRjZQ1W?=
 =?us-ascii?Q?6ngvYjOFs7dxl0XblVpc5clfiPZ2SNSsIEO1+ZL1sxbnjpdEAyHn3RIqRnYR?=
 =?us-ascii?Q?rQG1Lj4hEqwiK0i7P6HmAjoiaAZDjjkJmiQrK8HciwKQndt8ZXgWXS7g1ziu?=
 =?us-ascii?Q?T++gDDXJxOjQankfu0M35vy3VJyLrB7lHxwlYkBZo5pmqNvHA/xyJk3R4v5w?=
 =?us-ascii?Q?j/0pdWFdYQky0gu7ItgTsMIRYK83YcS8pUFQuyjA8gCJvKWwDoMnzIKpG68c?=
 =?us-ascii?Q?QRZmfgKbOMYMAUTDHBtZC0GRGRsVJhSGMWmoq9aw7nFjPtubskXQUYVET4qL?=
 =?us-ascii?Q?aeqjAHs5SEk3FTlvpOZQwWNhY7RrZeQt0PmZoHjmV3cvHwUYKlEBgHx0KOk8?=
 =?us-ascii?Q?409p0qoUul/bRo0PlbJqJq8l35yLdZ0qTnKTqCHrQWWIEhMAlBGALhIDkXSC?=
 =?us-ascii?Q?5nRqONcTuIjuoITm+slLs7FIsKIqmTFgz73s8iOJG/BirEvFEBrfWNOHfKSg?=
 =?us-ascii?Q?n1C5finRmxgdBb+/vhFqZNzeGF12w+k9KGMoqGIhSMZF8IRqU3fn5t3jVSv5?=
 =?us-ascii?Q?X3A1vAzTuHfIMYBPmLtjJIPw0yVwhZ0ka4uomB1gGbMsqA0LP3aCfOJbdz/g?=
 =?us-ascii?Q?4YqlDnzC5gCWU8m6tgH3vz5GdK++xwf9S5ugX8V9W+jVkbcQffYGiLhlGah6?=
 =?us-ascii?Q?Z1gE8j74kcYfcHIMk9zdz7SIy5kla8uf5dOQ84ny5h1bDSiKTGgP/clyv/xJ?=
 =?us-ascii?Q?d8SEWVU/o+zI4zi+CsADlChOm13Qa43P+rhVxadLrfNNuuJ1e6BvRIx4PJx1?=
 =?us-ascii?Q?a4YR0e/fZu655GfaicrsUa3lCaoztb97AiUh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1801MB2008.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ewXSoZYwRrosOnGypIvhZYiT28IPmKPXXr9hOYfgDOqbZElZnmSLJ6BHvPEz?=
 =?us-ascii?Q?xmKp27lyadvueM93ISLapkXYt24p55DzCnBtMCNDDjDG9VdYz5MRLgUeaJuU?=
 =?us-ascii?Q?4ezkOsOS66mXuAP6CxZF7lV8ZtznV+aMo0xosCCneZ1iJfxK6YElUerY2hEI?=
 =?us-ascii?Q?Ts3wwnORYIarNtLsh1tH1XiXPytlVJl9TpiOVADlInWMW2XbzVEc2JBvV+FB?=
 =?us-ascii?Q?qio5GeszNvT+uJxnIXuFgvdMusiMiHTNV+Yp/atwELS68r8UI0Jap46NNsJc?=
 =?us-ascii?Q?0dwm9OI6Nt2Z/oCCKPYgAIXkyTnT1WN8l9IZkoKiDaj7+eNpR472ziw6SH6i?=
 =?us-ascii?Q?N+ZRgG8Q7/9eFgJTlUjJ6KYuTHmfJDhS4/KJJY/QCIPa1iV08DmQrrE0rwyg?=
 =?us-ascii?Q?4mrVTsmpLreA5bUueaKYrmWs6yLiokFo6IZUbN/KyM1apWhM7DjwdsdA55t6?=
 =?us-ascii?Q?nIDXRl+ipKo5ZNtPcBriUqtYVYVV+6aLTjSQU/w2I0pXZGCAfJCVXjnojKzE?=
 =?us-ascii?Q?3hei4lCF2vswvuPVvAj4/afVMUsIhFMMm8UQZc15pRU4uo0JLyC5UYrbUiXx?=
 =?us-ascii?Q?7Q4tT7LdzUox4EttdbvXpm9oPr5yr3WUeb2QFmleN7aKx6/PXcCuolHvQ80R?=
 =?us-ascii?Q?rQz0XyXEJSm5IVr+RabYsybJeaFSAionoutz2UIDGyOxHBGP0K/gUvhVs4eA?=
 =?us-ascii?Q?fRhjyxxqvikQWUVYRUU8YpymVA5V4M1gtLoTKhUOWYgpCD02gnS3ljU1dRd9?=
 =?us-ascii?Q?CEYAsieFLc2FJcLM6NlU2qHOfFwpFe3K+lVnmf0drYV3jd8DICISWwjudfqM?=
 =?us-ascii?Q?jyhCetyZD+f+nc2r43p2H0CX24BNbVF0luXWvFSgOLEFa/roSo/gOWZHeYww?=
 =?us-ascii?Q?JR7jWF+ZYG/pjh9VlFgQCgfB/RCFX8TvVSZvLWnCURkL4hU2cTg5Vz/ews3L?=
 =?us-ascii?Q?cZwaFJLyhGijRSpDVrPMaeUEyl3n+psiAlxIR7QbTkTFuE52BJyF1AWvPZkj?=
 =?us-ascii?Q?20HT9Hqrbs7W3JsbSVwGQPuQWvzr/ltqbfavyqqkA8SFhK1x3wCPSiOjXvZN?=
 =?us-ascii?Q?FSZS3a0EpDDzxT7tQKHGGRtxVotDnI4RBN5yWQEHr01yA/iwvhN2Lk7FyCnD?=
 =?us-ascii?Q?jMiSV5cIXPXL4KLFFRUw86YQu9xKtuM8jiTcRMhVdOK8fli/q80oDdTdUxZG?=
 =?us-ascii?Q?uKGnvHLoA/gljggV1YU5kMAhDD4t6HBndP37oyXdZ3PboDAPCM+gJ2P7JWn2?=
 =?us-ascii?Q?WXQBAW+ICXgeqvbja9JQFcY3kRn0cYgZfuh9P5AsbWiFSViS4h8963OdB+pr?=
 =?us-ascii?Q?jlEM9+hWUXQ4ZmrNx2U2OvJ4rk2V8MnQ8C1VnHX2VypKkd/Q8qwvMuOIEVSI?=
 =?us-ascii?Q?XRaRpKeSxLvsHFkXySxEkxpBVZ6IvNW2Ld6Kn734NYIdAy8SFkpPvHn+xb+h?=
 =?us-ascii?Q?yRt/gJNlI6TkS0/ZleVqWR/lOYkzqBvbLJ68swcDL3D0dv3MZZ9sNv9FEbbm?=
 =?us-ascii?Q?qEa6q13dc9bgvu1hbaxvFZoELM7ZYQ8OpF1VfWOKx8kNMqzNpq98Zpfac8pt?=
 =?us-ascii?Q?W8UNkT/ANBi/YEiF7K4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2008.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f0393a-929b-4fbc-6e81-08de0bc7f4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:50:56.6853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPBiWahgS8yBqQnz5Jqb2DnzyM0uPST1t88yxfcjkj5/TJxsFOgbxaY9Qkb5X6yYBHfD9VTH5YIJiR5Xsli4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6227
X-OriginatorOrg: amazon.com
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

Recheck-request: github-robot

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Wednesday, October 15, 2025 10:07 AM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH 00/21] net/ena: Release 2.14.0
>=20
> This patchset includes an upgrade of the ENA HAL, introduces a new featur=
e,
> and addresses three bug fixes.
> Based on repository: dpdk-next-net; branch: origin/main; hash: 1d627ea13a
>=20
> Thank you in advance to the net maintainers and community members for
> your time and effort reviewing the code.
>=20
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
>=20
> Shai Brandes (21):
>   net/ena/base: optimize Tx desc fields setting
>   net/ena/base: rework admin timeout handling
>   net/ena/base: add extended Tx cdesc support
>   net/ena/base: add IO ring helper functions
>   net/ena/base: add lost interrupt indication
>   net/ena/base: add Rx cdesc dump on bad request ID
>   net/ena: add Rx HW timestamping support
>   net/ena: rework sanity checks
>   net/ena: add verification of DMA address width
>   net/ena: fix PCI BAR mapping on 64K page size
>   net/ena: style and comment changes
>   net/ena/base: rework log format
>   net/ena/base: add phc error statistics
>   net/ena/base: remove redundant zeroing of Tx desc
>   net/ena/base: style changes in hal
>   net/ena/base: improve admin logging
>   net/ena/base: remove redundant if sentence
>   net/ena/base: fix unsafe memcpy on invalid memory
>   net/ena/base: optimize branch prediction
>   net/ena/base: change return type and improve logging
>   net/ena: upgrade driver version to 2.14.0
>=20
>  doc/guides/nics/ena.rst                       |   4 +
>  doc/guides/rel_notes/release_25_11.rst        |   5 +
>  drivers/net/ena/base/ena_com.c                | 346 ++++++++++++------
>  drivers/net/ena/base/ena_com.h                |  63 +++-
>  .../net/ena/base/ena_defs/ena_admin_defs.h    |  44 +++
>  .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  12 +-
>  drivers/net/ena/base/ena_eth_com.c            | 218 +++++++----
>  drivers/net/ena/base/ena_eth_com.h            |  59 +--
>  drivers/net/ena/base/ena_plat_dpdk.h          |  24 +-
>  drivers/net/ena/ena_ethdev.c                  | 140 ++++++-
>  drivers/net/ena/ena_ethdev.h                  |  19 +-
>  drivers/net/ena/ena_rss.c                     |   2 +
>  12 files changed, 693 insertions(+), 243 deletions(-)
>=20
> --
> 2.17.1

