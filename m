Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBB7C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C76427C5;
	Thu,  3 Sep 2026 16:01:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7B62F402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788444097; x=1819980097;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=skGUPPmX0lmKHx1LE2fAwSJiIbwi6lz3c8vbs3iOS8I=;
 b=IgsGsKDLSbKu+KuB4ATdsmhoLEXSg0ZNStfYcwrSPdTbgZBdNedmih5N
 Ea57Sb7BnsuNfN2V8Q2YPzS8CPj8QKXOKDdihFPvZmr273bI6blf2EDoH
 hszN6NFc5E0PS8f6K1rF+q12k28iT9VQuAeYlhpvc06j7n8DklNRZJ2c4
 RXIkqvF5yOmSpYeGDr6k2F3sm0AwyuFQg08+ypmb+OC6MboxKOzPBAJ/A
 jHe9Y07mP4aDRu1YWl7lfS7nh2Rb9oCJ5ZOn2BlehlAv580Y4a5xu8TxR
 U2CktjSsnTD8Aopro/QRBk5dQwT0moX3f9QrWuTuFqDDElrg18sbPiIM2 w==;
X-CSE-ConnectionGUID: XuSJbNNWR8mseitFrwxEJA==
X-CSE-MsgGUID: wpyLlVIoS0ibCl82+i8vhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88804055"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88804055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:01:36 -0700
X-CSE-ConnectionGUID: /MauYoqTQWyTARqMNe1w1A==
X-CSE-MsgGUID: LbcyyLlERb6jBII8H+1cGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="266502474"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:01:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:01:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:01:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSF6cK2UJDazJx9Kp96wopOywEoy8NVN8cJjaMzRVXMcrrWY4RPDLqDH4GH3ua9pwclMbWIptkmcvGYF/6F1AUs1fN1ODGQDmTBQmKknv9ik9kWMGVVQ4M3UEz7g/VEe0usVjcXMWrZxM/eUxb2OSmXe43guLpHwJZQw3cY/6+EK6MQWPKYHgid1nERFfr19pdmlltMwdBVF2030mpXSO3Liq95tpuDmnfJoZZ+3Sud+LfGVyK5VVWePDG3p8FXIFWOKKZbmWBy4r+CXtiSlbBhvUGjgFveNgHO+bTdB02HIIcf+LJaUQpXmg2vDcBp68dJZxlT40j51mAdJDSeB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zayBybVIzQSI04mLnE3y6mRcQZFC30/qA4GileEOHac=;
 b=dYJJAH+jQ6CNlKr46RJ0bM3dRC+AoTTAj1jqEz5AqXfd+jW2SAoylFkMGsbCnSy70FBSIarsIvANPOZGCWGwDk9Dp1JvXSdDfv7YLpKtUME25GyWkMdgbpNXfLfgZubvs+J2QfqbffHTZeGNWeoMlNyV7cr7aOJ+iuiUpRhUPo62RgCVi+QpXepVbqttH8/65pDZPYIpXcSuPAYIwRdKZymolJfp7e0gW37pimTIcUnjmYuSpq+YRy9JKaqk5I82XOIEJvy3SrTDSGgVSvD7Ql5/gib0hukgKuAdOi3Jpa5xgB9osdLi3152iLmsxMRz0yRpSnDBaHW6OAMqd8ilsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LVUPR11MB9566.namprd11.prod.outlook.com (2603:10b6:408:39e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:01:30 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:01:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 4/7] net/intel: fix unclear enum names
Thread-Topic: [PATCH 4/7] net/intel: fix unclear enum names
Thread-Index: AQHdOTNLJEbHyJE0PEOzvOlTbGYzxba85o5g
Date: Thu, 3 Sep 2026 14:01:30 +0000
Message-ID: <IA4PR11MB92788775AC375B0B2A33C9C78EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-5-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-5-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LVUPR11MB9566:EE_
x-ms-office365-filtering-correlation-id: d382203e-5c02-4dde-7375-08df09c3dae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: QvVW78HjyMg72n8C92HIdiSNAhOhTyunK6YvvgfGf2jdVHkDFg4iYrSm/aPTGV3WBN25FlR051VgjS8D5QFJvIPfLrSEKtiTQ97hWM6eONWtniiGLD7XuSFWXeammz5NVyIbuadtS1sTcLqlKBdT4WAU/eAdY8DprcONsd9P/0SkE3a4Ez2LX9zKn4jYy0Ho34MiFtkr+xNJV0Pn0YJlyuWSXekQBr12CFHKOB9BctogaLsCWECsaA4iV5/xEeMWonuhpSd1oLg3hCA3yM3/KCheG1hae7KZAt18u7eoI7/4AMzTN+8EUf+J8sIhkzy/FDsBA/dTJcjeG44XyXbv7G5W3NOtHRvNJ/yhJFtHGXXzKldQEs50JpA6iGtvmycBo2/seFwVoLV9ss/NvaJj7xXJuhgpfz+BfROcfvxucwmZW4c3G14RroPde0gAZnG/W6kBDvZ6fR/cXnrB0aZFkM2fZR9BBbYsa2IXr05TalXqnqJUtbvdJeTnDspCjsAHe2tqreivbSnqIxChz5JvuanhJmUzaP9tpZJP78Xqga2qnSbg4r6jDoAaB8LrtiKeZKXGR20vMy9KiOEECP6A24kdOUujoJ1h89L7c8WnkMnCEVIp0Uofci/JKmfn6Q0WgCXOWH2BgF10VYZOOWWuXNGp456AzzqqNCQltnHVVNJASdyM83NtxdSvhZgn4XC44smQ81luU/7/m9nLe1WKDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZMBRIlWeYNhQSt1PD4f42xcYmjNy7y8cMudqqirhHa7Q2oh49QagXVzt5+hM?=
 =?us-ascii?Q?5wwgTo+TUg+iTk9Wg+4EuR7eS55uee1ZKZrYZPyX85lcImVNtIcgRdC7T+6t?=
 =?us-ascii?Q?0uYACGlN47rIUTS2RdToFFadmL8JkHvaPa/iN2SBHV5lVIRzMQTTt7UdGnnM?=
 =?us-ascii?Q?E+xbq8ohHt3Cmz4Q2+EVChNr18A8QNEZYvQ81svfcJXslXqqZZJBeTUVrNgT?=
 =?us-ascii?Q?NoV3zmMIJD4Rm/Sj1Sgy0HBsFQDSlA9kBkhfQYcLULW5NDAXdLXpn1vdtq4v?=
 =?us-ascii?Q?7S+AZGCojkM77QsqYop9nMdxo5Sy/VhYTfHCNG7hpLk0ygw3y8v467PaNOzt?=
 =?us-ascii?Q?fMcsE2v1ouI6rfIrHJ63rKLNMkq17WWMwJBLJdo7LTK04WBYrPmrMMCkocDm?=
 =?us-ascii?Q?YP5eAByqa+aIhxXRk3LNgRLwIGLlYTNcf03MWu3GhmxVFIgVODZWCWRK9JMv?=
 =?us-ascii?Q?QwfwII1KnR9BAQ5RUtWyPTQm2zrDgzLEy6SXsggO1sI/rdmBUBPdSwcj01fv?=
 =?us-ascii?Q?od5mFosCNBzT9PkZnoNmG6qNw+2pg7MztmYGQPHo8lDWwBYNR2k1sC4/f1m9?=
 =?us-ascii?Q?lvmkBGtcCZKgZrNSMpaptUZNkHn2CJpSiG94F6bWpI+0n90J+kA/pefhd20Z?=
 =?us-ascii?Q?5dqlEiefXNU7gQVZyHJmTzUz7Z+6uv21jmJVaBo/h6nxJb7k4hmetq7OxdAn?=
 =?us-ascii?Q?VlnBhjNDndW5N3yk6NV71sp/7lhebLG4bRXFBROKv2cjzssNyWtEWS6PqXJ4?=
 =?us-ascii?Q?lrV7zecLTxJrP2COh0HujeHwUbk1A5hBL5nqQyTaFwG9IIb9qsmMV31F2W5Y?=
 =?us-ascii?Q?+XeQ/18s9h8AFdsQRYlUEhlSTtQ0zLkZs7sPTp1ZpOVhMPBxKkjxTjDDO4p0?=
 =?us-ascii?Q?d6Jyn6f/W3XQ0duh8se48xk5lM7y3tbmZJVp0TYS5pKGes9xA6eYPanxKFum?=
 =?us-ascii?Q?2xNnfKj/EGAlofstw79wqHKcewmiaG2/4SjeoqC1otgrbWR3M9F2V+ckK5mF?=
 =?us-ascii?Q?Wau3MgGSugILdc4UCEnueWRTLpeNcqhk5+scEhdqV/td1qfPMCPIeSLUMnrF?=
 =?us-ascii?Q?6vKpEC/rEs76O+xandbPhFWrJb0WJSCyb0934C0pZelzK/2g6FTc+flC3c4e?=
 =?us-ascii?Q?e3LcpNm2P0Inly/iRM5vJwAhGVSxRE60mXlo+BiyTgWamyB2gaPaLx6FdZ19?=
 =?us-ascii?Q?3qoqsYJpNKyfsvbJlJ2YRmHJ+p7p1/dSW2WoeEuFAv8KXZxkBvXK05GN5epA?=
 =?us-ascii?Q?mFr5vhm6pDtMN6T/ZAFUU49k2eGR72edc+KRDNqxf+Hzd1Y3c9qV7mPM/Qcp?=
 =?us-ascii?Q?YnfmjNrb/irSuLaM75zixYtGhhDGq/SaPu72LiGQB/BZ+cWatnCoXcVnFDNN?=
 =?us-ascii?Q?aIxNuQC5Umyxouv7g1xOY5Z6T9dUhnpto+9JGhnYXJb18Zw0/E5W89RGd+Mq?=
 =?us-ascii?Q?ra7u+sZw43EHKl8Qvv9yNi71ld3b02obCHvV52qE3qvYCQqvZtIIicFoGOpR?=
 =?us-ascii?Q?jxPT0yIz9q77IJTXDw7+DN2oo5tVIkWyKFR1FW8TqyKhwiw4TX7F7QjKGeGz?=
 =?us-ascii?Q?vNw72vD7sRXxDVVIh6K+jOBjUFSNIVhGQlgUu84pF9zI/K1YY7GDYkEGoR3z?=
 =?us-ascii?Q?jYJMQ6VRrTLNUR7xjC8v5pmPRFayABonZs0DgTIQK40zE87JXv1dQ7Iy2djj?=
 =?us-ascii?Q?FLc0OzRogb4lu25xiDPAV9B0Arg7zI/iMeETfS7w06lCfm9d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yayIg+vsEtyyptTkSZXMhg+XVPmK46114m+LQjG4RbMUyjauNfgPtVhV+bUWs5OLj+upg3naE5QJxAgNeeNVkoo9mltH4JjbXMqRlTmz/BlVaGd+AY3B6mYtprprRvWaeYwysb9RJr9kNrC3j+0+vBCcScWL/C4xJXh2uOhqg8RrMoEBj4vyxnBm2yViwJV3QEG1jmHnH+ASj/sUTxddBCZ6E6b9lte6pWe62UZExNpAfm/nO9TWwFNXkNZscjjrpzAh+izipv8MJPVT45D9T7kEdW3msI6UjuCNKP73e7yG9PExBT9JnXT44TmQaH1vK+ROeFnj6/L2xLdWDkOe2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d382203e-5c02-4dde-7375-08df09c3dae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:01:30.5595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFs2g64nCn/yLbvG2slPuCT0+F+qs4+CYhfiOp0/KFlXu/s++RTGf0A/VWKerpEQYZ7J77Oe4yk57L1ph6lYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9566
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

> Subject: [PATCH 4/7] net/intel: fix unclear enum names
>=20
> The enum for VLAN tag placement was badly named, and it's purpose as
> described in the comments was unclear. Update the names to be clearer,
> and more general for future uses and remove the incorrect comments.
>=20
> Fixes: 6ea6d67bebfe ("net/intel: support configurable VLAN insertion on T=
x")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx.h             | 14 ++++++--------
>  drivers/net/intel/common/tx_scalar.h      |  6 +++---
>  drivers/net/intel/i40e/i40e_rxtx.c        |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c        |  2 +-
>  drivers/net/intel/ice/ice_rxtx.c          |  5 +++--
>  drivers/net/intel/idpf/idpf_common_rxtx.c |  2 +-
>  6 files changed, 15 insertions(+), 16 deletions(-)
>=20

