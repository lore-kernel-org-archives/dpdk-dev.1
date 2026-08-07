Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B1BC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24C614027E;
	Fri,  7 Aug 2026 12:11:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id E87E340264
 for <dev@dpdk.org>; Fri,  7 Aug 2026 12:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786097465; x=1817633465;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IQBF6mtJZHS8y8Or7ufbHnWJWMQKSd296n2nmZWM7Ms=;
 b=TDQkptxe11/1H+bPKTCztOjqPc+Omx+ex9atetUmCsX/HW1axDBk3KWJ
 s8mXpp9jpenlDH2dkxge6mi2cbwKGm+reRfeEu6wf3qmsu8bXK2lnXEzo
 lcg3Y3Pyi8nXHaHlQ7PiGotpV3RvOC7uPBxxkfSD+WeEeOXxZ21Vsp6qa
 JnWPTxAOqPHq/4Y+n1ZintCzRJEgDtJUSMVIQjEjTF/D7ulphTTHgZUtS
 gmi/gnu5S957tLoJGBcyijSuzW8warzC9VFyc1qDJuRLzJ+LPCl6nSbCq
 gteHOZsSXG9UwquTRVUQQcmk4z5MGlCXsa38d6udRltsGMur7ESBFftTZ Q==;
X-CSE-ConnectionGUID: aoLfHItvSU6lR4KUA7WORA==
X-CSE-MsgGUID: o/+/1hiuQ3m14yoPMuLmeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90520265"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="90520265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:11:03 -0700
X-CSE-ConnectionGUID: 6aNu0M6oSriPh5yxR5vXaQ==
X-CSE-MsgGUID: JBgXBVMLSCWzVGZIlFNMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="258055185"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:11:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:11:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 03:11:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uupxbcee/RfpipHsEnjceh/3nxiIFhp1dBgcT8TgUkQhx3771DSGUCLXDMNuzn4QnGgF1FHvdkU17XGLRqghUDUu9lexjYpJG290jXZFOii+sD6d8YCvMxHoaybTl5exHplijUCoM2hawRB1ROPYTMbiXZgAKGlMvg5u1QlLV+dx4NQByHQJxNzS1ipkyGjN+a+S1kqo9tCjwSjBCx6nCdd7/33OoUCnPcIcE2IaaQZU7IQ7c4lQT5sQIrkd+Rxr0i1w3D5tY6DdMAEFKdp/uZ7YdnytFIqIX8y/crAWW8AeUOyfAemqhJxVGvrsjaDIG/HUlP3d4JDOYEBQhagbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk+j/2F90mzM+ngZXkxCGg9fTMbYMjPHEI8bTSi72Tk=;
 b=PBXfEbF2NjeisJHsEcm3VYAcHRFIg8DFdgw0y50LnFuHQ6szd4Jfeqq7pLec2S+1V9PMn9KCF+Pn/CO7oqG9XdiTVtRZoqs1UC2llvtHtx4igfqZ1fDf5Blm2HhYQH6pYzHsxqxJGKJriI5jJFHZob5JaiIV9SX3VQy8gssbdUO29RMcGXsWQ2FfHm52IodlptcVZLAcsmpA32SVf2MwdzG+/NlB0I43xVrsafq8ELtfAatpzpC3ZSfZJdgimOMfXejhzno3w4vdbAFtOFFmzHWm+nBi9jVwVB6U0tWNqYnDiePaD/vURI+XZq/BtEEL8qyHHCSf/Ys/Z3PTIhT1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:10:59 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 10:10:59 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 1/5] net/iavf: discard empty AdminQ descriptors on reset
Thread-Topic: [PATCH 1/5] net/iavf: discard empty AdminQ descriptors on reset
Thread-Index: AQHdJX15R6Uz3qdg0kqp3+8jeRtEtraSXofA
Date: Fri, 7 Aug 2026 10:10:58 +0000
Message-ID: <IA4PR11MB92789C66FC05DD22C61CBDBE8ED12@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <3953e3a3dc6850268abbac704bbfe0be31020e4a.1786004043.git.anurag.mandal@intel.com>
In-Reply-To: <3953e3a3dc6850268abbac704bbfe0be31020e4a.1786004043.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM4PR11MB6096:EE_
x-ms-office365-filtering-correlation-id: 7230496a-6634-4b1c-73a5-08def46c2d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: M0icDHC1uGIjAI1jkLQ8HBBkl1DpwhbigYYuo+lBkcaT07eNK+kRg2YwLJezL9G4+UOfpD5koHlt2ONYjGWuk3b0eibkXFTHLD+3JDoAxaIZ4T95UxkCid13e7Menfp+6x1YSLZD5SsmcLkwa/qBDpO783g+CnI5jrB60t/XI6L44YM0z24Lt31rcLJksLc8p7G91YMEgeRkdDG2/yrwHxPYc9R17nlJEZnItyFhn7nkP6D5bmHogrNmDFiFbKqIVx847vP5Q77V4BJR/zeVoA9MgxsXXnophW+jn8/+N+avWHI1U5JFS5DBDw6B9hllmt3EFVAnAn8MJmZEoceXBhuZ9CTjUtDNarPakc4nzSIJ323YcSPC6fuUX1bYFBhxTSa255qroU/bna+EnJ7uuyeykjLNVaLvdKVU7wvR7RbHywMB2wzqeNOsrMh+fGmseixfjzvjz/Xh6cp9hw9bv53k/0MZa4y/jiXEjz3Lf/y1lbH//jpZQt8FhlHN9o1fC87wOmnKTwbHSLqDizNzfoXQBMfCwaYhPVX7dqtvEfQTA1uoIEQWLD2YtIZVvhFhMHmtBRpK6TzF4MGEh8yv/FfkjmFRcyybYAdrAV+9IaquPl3dLDH4qnM4j4spflt3vhW1Qdhnl+cNyxnsxKjaQi/AKlU9feSWlHi6oa17o9yeV1MfW1oTsPg9YLxLANVQud9SeeyjTofh2J7pAYR1ALUF6NGwuF1acE4ywblqlIg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SNR/Hae250y8B0C2rNr062+H6NpDsWsZ7/UVkvAphAmeilMRxKyYmdnpLagy?=
 =?us-ascii?Q?wUB6kaADyc+STMFIoiVha9A1VdzWWRU1OtylyCpB0Oz1L3b4PLlCI0qgSVFE?=
 =?us-ascii?Q?qBGpP8x67MWYCqItl913Jx1af0Pv6ZZMD15MVz+/EOT65/bxeo382dLQEuW5?=
 =?us-ascii?Q?XIW6B99ziFH+pnONlO8ZENn6hBTJ37LUVwellLlbmsBIL3NO5fi7KJUXYvXf?=
 =?us-ascii?Q?brwXapU/dI+gBK4mqMRz8SzfmZf6rJbDWocZxpaPeSw4/eMpM4doCq91ntTc?=
 =?us-ascii?Q?iI4+PbVecWu3rp/EVeuPFd/xrTRV7pdEjM2fIh8+cRTzXuPDTEhZLN0Tz66V?=
 =?us-ascii?Q?RlkHi5XvK8jH2XUQvfcAhMD9ag9ewud54hmnQj/qz8ErNVFpvh6Gf4htfvGT?=
 =?us-ascii?Q?8Lq3hYlx9z8v/HQoOfodyzT4fvK/Ve4qMSmEXQ6CwSxZORkhaHwXoPvebCzP?=
 =?us-ascii?Q?ZreBEil9RsKfmoNnyePOTLYSNcdMoEypEjb1/Cri65nPSXxPhDv13u3fEiCL?=
 =?us-ascii?Q?yu9gTDxidExpLE2uBolHqFjHS7r1i8JFXiQHp9dA/qaxaBh7R5y44zMdgbyx?=
 =?us-ascii?Q?o9SjrSox8zxFJjlnHEnyyfajRZfxleowr5JKSXPpquTEZ55AVfy9YbeBdwp/?=
 =?us-ascii?Q?Guc1/7viKP3Ae3FJddqPeK9qgAK5m7IfaZ0myM9wxvyOffkoMj7iXz6bxoMG?=
 =?us-ascii?Q?nHcEg0XLlDVZ8M4PFtB/iE0NzZnGIZhtSLQRAjkTHGhetdHgRasWCdkXaimf?=
 =?us-ascii?Q?ANe41VG06dtqABNGr+1w3j9q0KN8CsuzbexrMxIHApSa/tTbsb48PSLDEBOo?=
 =?us-ascii?Q?iQwTJUL0D3KPgHJuoVgbUXyhE/f3+KBkGT0M7VvNtUXkbrvaWTS3hfqvbYxG?=
 =?us-ascii?Q?cRXqlFcJu9lF3BHbR8Ijplbe2AViECxpgEbBeIZM9QU3DekouOYLIGDvgrjR?=
 =?us-ascii?Q?F71QfB7e4TvjM0GdL3zZ3VJT8OeSoFMG91/589syqxFgpbU3RoBIAinyykJ4?=
 =?us-ascii?Q?GqJua53ON+lY0jipFlJONMYLNPaoj14hpY+XKRqN+m7J7ARv46qDse8r2o8o?=
 =?us-ascii?Q?dXZPP4Uzy6FtxEYs/CceaRsGd7gO8xlpUfhQXeBBz9LabmpQ1vtgtXRkdsZP?=
 =?us-ascii?Q?kwEae4qrEV/EPr8TgdMkBvySHyPv0XuNFwq5tXPOC5aRP+FzC6MXrDffQsn9?=
 =?us-ascii?Q?VLoV/2wHAZ5KNFCUdekGbQyCIhuXJbTQPHFKzh7/X1GctUNZnAQllE6AUExx?=
 =?us-ascii?Q?kHxLOgdaF4hyRdFyEmg3b5I7/UE8B89cc3tdBprsbbEexN0pI5cMReMV07mi?=
 =?us-ascii?Q?l34v9ac3/XMUfZVcPhE6HUKg6Wd1PRZolWQ+cI5S9//MINy38K8ZQ/QJEmB0?=
 =?us-ascii?Q?dqHzNQMrOTPPlJx2K3bNw7z9Tx9CX6uv5deAdl4valNSRzwBcEjd0fDdHXwy?=
 =?us-ascii?Q?yplZwbGl0KZlabRRSjtXpEIN112/hWQ+dwy18bGZjayMU4UvC7IdeLDDe5Zv?=
 =?us-ascii?Q?UE05CB3yuNenSUg3goRC5ha5tGR+Zy25Vl1RZUd+0aGTr8IRSxOoVf3GtcEP?=
 =?us-ascii?Q?gMXK3PxCVI9hvm+JKdcd9MBIL0T9gCAXpJBCCSseCnsgajQqAFPiYFbDOJ8S?=
 =?us-ascii?Q?xJTelozWuvrgIi+3yjbksoqxQwwy5y8zbYlGzxcYFzCeQmEUJ0IOm1ctbm5e?=
 =?us-ascii?Q?86S9zxKU+Iak1bn679kcR21YltMbDBKMC7W8dekMFwxDGQzj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PdRgfPAnkrcICyuKQlBd7sO7CH0seSitzX3HVYHV4SzhoANyrBUnsApAbxDa32YccLzLTOSXaL8qComIDdCL5zL/kqASA8SgL46VXdIgD/NAR21juHPPTxlUyxRSxWDQxLmZR4ZHxEL3Ifilj8bSIIPNzAoborkey8L0jrDXv+B+63KE9xRb2/7w4N+3Vq2Cuwsc8yLb4utdy48IZ9FmHzC6/WdSVIlWzDJC/STDaya/T6cmDAnKUSa/JdLH1Hok7OpGoQGNCpRjAe0kU4hjXmBscQ3k7TzFvSU+WmlvOcJu0hXQ6Q+qW0DY4w1OBdwiF/PA3UI3ZB8AlizLqThZ+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7230496a-6634-4b1c-73a5-08def46c2d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:10:58.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBJtUuxkhVY+tBRU3cUTjYR5U4c9DWp5QtWu8plT2xQOm0CEIrUaMz2ifDHlY6M9tvPS0QLL+bzYhHFc1tGaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
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

> Subject: [PATCH 1/5] net/iavf: discard empty AdminQ descriptors on reset
>=20
> During PF-initiated resets iavf_clean_arq_element() has been observed
> to return success with a fully zeroed descriptor (opcode 0).
> These fell through to the default arm of the dispatch switch and
> produced a "Request 0 is not supported yet" log flood in the field.
>=20
> Skip descriptors with opcode 0 so they are silently discarded and do not
> flood log.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index f346837bf1..56918ebcc1 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -614,6 +614,19 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  			break;
>  		}
>  		aq_opc =3D rte_le_to_cpu_16(info.desc.opcode);
> +
> +		/*
> +		 * During PF-initiated resets, iavf_clean_arq_element() has
> +		 * been observed to return IAVF_SUCCESS with a fully zeroed
> +		 * descriptor (opcode 0).
> +		 * Without this guard, such descriptors would fall through
> +		 * to the default case of the dispatch switch below and the
> +		 * "Request 0 is not supported yet" log flood reported in
> +		 * the field would be produced. These are discarded now.
> +		 */

This comment is too lengthy. This information is captured appropriately in
the commit message.

Something like "opcode 0 means the descriptor is empty so it can be
skipped" or similar. Assuming an opcode of zero always means an
empty/zeroed descriptor?

> +		if (aq_opc =3D=3D 0)
> +			continue;
> +
>  		/* For the message sent from pf to vf, opcode is stored in
>  		 * cookie_high of struct iavf_aq_desc, while return error code
>  		 * are stored in cookie_low, Which is done by PF driver.
> --
> 2.34.1

