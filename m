Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107FACC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C95D4042E;
	Tue, 13 Oct 2026 12:41:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D45364042E
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791888080; x=1823424080;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ic/gm9p+92Lbo10kHYcelNvI/gP8biAcUWBQqMjNWTM=;
 b=BriuuZBK/SDluFvr8HuqLqfrG6U8SdMvY5QLEru0ny7zDb1NrYBFFs4t
 s2NsdM7vRbGfH3UEGTsYq4LZT2f1wO2sPg6H4DHgB6FmqYPkALryq5EE8
 cQwSxIuwAYdGYBtswvdWCPQaSQ0SZOelKMeqZo4BrMSQ8tLTNfyC/smay
 tCIBKK8lKZDCQhcAUZLGPVjZu7Y4IdVnmC8DCbm0VYVwO9xcGrIFoTkBa
 QPzuOrfblLLyacZWJibnLeXQ80VwznNNltpTuRaak4uC78HsrnWll8/wo
 GKpR3y6irRJ5W+Q6nVujKmSz7utvwBGmSLSlDUI/VA6FCEhAnxRiw3ZEQ w==;
X-CSE-ConnectionGUID: r518Pt14QqWwPJdhqSeWPA==
X-CSE-MsgGUID: tuRwX+QtTciLcFuG7CDA6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="493748"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="493748"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 03:41:19 -0700
X-CSE-ConnectionGUID: M9gKnoKzTgWFnUdLp6Ij2A==
X-CSE-MsgGUID: +dgC0tclROiGlOni6sH+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1061677"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 03:41:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:41:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 03:41:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaP9Ca+QJNi8mkx9SrNmSa4cTKj3jAu6kO8DJZ7p1OEV18VRg2h6ap0fMfVm/KVjlH+uMbSe5n2PjMl7oYx39Te5wrYOUyuePz3H0KM7twe7GC8tl8OspVbOMYWm9q7fcF+RC3CeUG433LjMsr7k9elBg0fCLkE3xwZYFUGeeHGMAp9GU6Rl8tmnDAJMRc19Uw4+p9tZaNVJL1zTeAYB7Y45oGF1mouTb+0rGSYsLuI/DzDo14u+DFX7LeoGiN4r2nTVdIGrG6S6EQgEFvbNxqWgEErZBVJvxOnut7C+3AEOcXuUaMqOWz12Gt7KAv/HdFP5/11GBMOtNFoE+z9B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY0/UCk9M5Ki7o8/U4PLI/DIVysK6xW/JxbyQK5kjoA=;
 b=CGWF25kNPrxX9F4Ff6lVg5UclNwg7UaxYatGBR9cFA2yZzu2U9xeIhapayacurpJzXY9l5kjSCplCcOkKn5GuACcPdeNWN1vvWNjSvqamrVy4qwoq0wLV9NUQGFN6rKWJz7T0BKJhwdBrx43HmNnFPLZetoqWaDcvJfQt8G9D8GR6G3zBa/BQZit7GoMDh1L41kJBOLy6FWlb4TQ4osOu9FDKdNsc7D7F7sQDIJbfM5dvAtgDmOWhs7WEetCJSQDwj8zOxls3Fc9nN9S5GjApWW4QpWBUTVgt561cp7UhuUgquSXm2F+PcciBQ/e7qrc7YclPvFDqsiTDO3bmIjc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 10:41:16 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::45ad:ed1:a048:ac11%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 10:41:16 +0000
From: "Cornu, Marcel D" <marcel.d.cornu@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Nicolau, Radu" <radu.nicolau@intel.com>, "Ji, Kai" <kai.ji@intel.com>,
 "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v3 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Topic: [PATCH v3 2/4] crypto/ipsec_mb: add support for 256-NxA4/5/6
 algorithms
Thread-Index: AQHdWlIm4swBEUX4I06OhDlU0mm+Dbb7P0kA
Date: Tue, 13 Oct 2026 10:41:16 +0000
Message-ID: <MN0PR11MB6280D3EB70283657123B0159DA9E2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <20261012135947.1895429-3-radu.nicolau@intel.com>
In-Reply-To: <20261012135947.1895429-3-radu.nicolau@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: 3c64b2e1-482a-4d8d-3c1b-08df2916824c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|18002099003|3023799007|22082099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: V1VZk50zQYzt6N70sfTWY6J8FHnWegcIsiSfUULGs63mI9IeAebKrwiZQcO6a/8muMyKy7bgriGftWbTes1RAUcq9whp4jkpJUQjCDYeP7rMgt1hcbA0/nk9oAFpKT+5qdNPI/257TykxS9Im+Piv2bPan2sOI3Ps9jYI8siQ/DBsGINq/L00xYzQn0SH5cm++Jl2scLBoqjOyZCQDOImuGhtImrpgqGeqxNTQobdGoLhj0LOHQ4WTSMd70dLhyDLfUh61FdVLOzc8pDGabhZb4X1Xwfa8z0oCySGqyhOZncZiDvxUQZGfUU9FXq4cv7ElCpud7auqFvfDwqiB58dLH0pnVjlQG3qPSI3p+U8vm4ACtTiMVAfDL0NC7k8WMVYnjBSOIcRDRqcfL9GJkE6nk0y553hubN/Wa28TsqtJLYSEUBLIGiZz2MvJVwg7ivI7OxM+c/9PmhrYK/8U1aH2FoADBl0WmOAojPZ6p9qgMyhLJd8IBamyxVkHVlBbQrskDcJwUFnsa+5GYAvY9Lgn/zu0ZCW2r64z5dkyEObG0rE5H/N+9yDMSwMF+Mtfo3TVBya5bk9oyYdl4H0dJaaZ3z1Q/9p2mffUDFQ9dG/wqgRGd5LN4oxYPX83VZtW1eSydTvsGL25Q2MbzuXvLIG4rvObOVyFg2KI/aYF+VdmdDEy6FAZUJIY39fFH7gnJXB0XaiJ3h5WS+7FuaPlIoTFFOSeEz8SkHW31SG7R7N1o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(18002099003)(3023799007)(22082099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jVm7XMSB3QGakN7S/wL9MwNifhzD9x7uk1YyBYzY1yV03MOJ3GNFfJ7bJKln?=
 =?us-ascii?Q?55Eq2XOFbGRCjl9GOnF1gW9a5mlBpQBn06iOOVE6DCMCab3FY1m6e2/J51d6?=
 =?us-ascii?Q?dVDoV4hP5lJirzu88hvt//biQnqv/i3Ha0eS+IbL+X7diNjkzucy91Z99mC0?=
 =?us-ascii?Q?5nH80USB10DW7bdQsoCipJaPAZXLgL4fgyb1Yt4pI/EKjdS1juyapZM+ti4d?=
 =?us-ascii?Q?xLZCjmqggpgR2n5Co76QEN8NUcbU7Fj7fux1IAmtdr1wiEmjFUSF/sytFsmJ?=
 =?us-ascii?Q?2c5u/BTiYls52NmU7Gu15ganGKZuqs6moGbZrxZWJu07k3I5E7xu1fB8MP2c?=
 =?us-ascii?Q?8BxSv+lrqFwUitd3AkcImQKjzkWU+cWNaBv/HNzdP5o52KbQ+SbCuFTdPyWi?=
 =?us-ascii?Q?7uX6BpuUxTG9gUc1W49uo+DwikNettkulcSZ/LbrMNkgZxCKQdWN0/OMpWXm?=
 =?us-ascii?Q?+DsUdV3HbUwl5IJo7X1ldUs5JyMKgGVsF8Zl/XKO1agWJo8vLP5gmQLsBnVP?=
 =?us-ascii?Q?48u5YVV1UzxAerTUG0vwCDRTpG6ORiWwf1/SyIUSsTRFCWr2bLyr2v/m4jJg?=
 =?us-ascii?Q?Pck4qhBGrAolQ1cXiOurF9Ok+NuFOz6lVoWSWGZlYzdU7M97wtLPwxbexEQ7?=
 =?us-ascii?Q?VtS9r+Z6WW21QzvCt6KD0bBjeI1QVPTPE3mTr/ymJ3bjZUq7Qj94JIIC6A6M?=
 =?us-ascii?Q?qdI4eh+CJOTsRL0kYRZ867nP+Vg3vSY3RX9l45yGqR0Ftim49o7D9jKdDS/N?=
 =?us-ascii?Q?RS8gdVeXYSx80ozAelVDCzsTSJce7FwNtiARNznUImc2IDC8CLHBAlzJFb4N?=
 =?us-ascii?Q?/lh0EYNFJdVNXVcB5XF9Mny1+dOtNtJcN1uxEhwYMxfb58XvLi2qtRku14Yo?=
 =?us-ascii?Q?DaZndDgt3Jie0K+fbpEIpzuzdCPBym4jyKR4PbrtWCokw6HJaJ5KVixsEtlc?=
 =?us-ascii?Q?DbIs06E2sHgoL083JqJz4Kp8zqtMpaqR/P/hVmeJE3KvC7TLAI9pITlP4fQB?=
 =?us-ascii?Q?zxc/Cqaz5EW0xQJ3k2RItHZPAi28dJ+/g1HFeOU9RucGm2NfEZge8h+c1fFG?=
 =?us-ascii?Q?POT67Zrw2ehC6uXPEkRbM75vyRdkzrWtg773CMItgfsidWxs+HFlX6grSQHZ?=
 =?us-ascii?Q?f4dw3R+ayh13IrzSqQmpUVxUYq0FSH02gVB3XX2lHW6u9SgjYpifXY7PwdlL?=
 =?us-ascii?Q?Ib5xaN5eoQOmILEsh2npZ5CQTAbzU3niqyTq3VH98xofjR/87ZS7L+kQIcf6?=
 =?us-ascii?Q?f8eHSxFizbKv5T21tUr0h4QXUyeW8ZtBhTRoNXqaWGKSFR2ogbuxFfJLI1Xs?=
 =?us-ascii?Q?5rxAkdKSOQsO2tM7iT+eqxvDuclowCD1JJZ5GBE9w6iSa/qST50n/4I/QLLM?=
 =?us-ascii?Q?mae2DuXYNMoBKpVYtSzkuOGRPB2PaewtRDjj7+s6LPkBbA3zrOl/J80lHofA?=
 =?us-ascii?Q?0HePbNzHV2ymBqz2AkZBW8AR88nmIklq48nxXDvCYbd8D7e8FOyaZcsdCn2H?=
 =?us-ascii?Q?LQRUqQbW29p2oc+cjhW0G7R4ZqGyNcoXG5bmZ45maMuIS0+iqc8pCJJypjlR?=
 =?us-ascii?Q?8OQ40fpD9MTVetBB4Z/y2NUVeWxWKVIwXLS8CDew++7BpuMqNEzInAGRHYH0?=
 =?us-ascii?Q?885KajfuQF1u2fOitt5VyPRvMtIgRBpG2xI+29UDC+KcJhUOe4DpYIxfeQ/w?=
 =?us-ascii?Q?nWV+Upz0qiMLYMIGjI9RKmHbThnRPYxNdvIQ9hz+tZoCzSDGLYQlTUAvQV0E?=
 =?us-ascii?Q?+8wMgbDiaSj1mWNHp8xFRRbwrVPsDELd6Feo3O4aEIliAGzzkNUUKS4OlnQj?=
x-ms-exchange-antispam-messagedata-1: vsjZNPeMZ8M41Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JtvOHhZxhbslK6elPZ4Alj1NVFqIaDMY8syOBTCvT2bpppCYLg9s04TGis1DjdNZHROEVL3dfFSfSHCgXaJC1/Gl6PWyc/4c2eLH1bA5c8NikjWM0rlnyz6/VZFo61H13+bKFd5RrVnAg886XBR2Vdi7Tz6c+a/ivtTirxy+GTVPLgB1VhHNmCcPrZyvBemIdu8O9t2FYWfas5vbey+aZvCLF/8jNcVSs5hZGPtjfNvgQKmK37zIGrDQCP+czVCsm+vLF80Vm4YA1QQS0nSU/kVKr4k/3BwUAO6LUnWHZfasDmRd3k+dSyd+z1WmkOO6ieeLGLANIlezoygwQ2C/Pg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c64b2e1-482a-4d8d-3c1b-08df2916824c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 10:41:16.1919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKCAR8YIhZDYUZnGMrZdRLZJAXK7P+E/PFoIGUCAy3xft2Q3iV6QGM5PNbzDz/kWOTXftwtISCTRam12Xh+KM6N8t8qMx32aykafiPWZYU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
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

> -731,6 +808,67 @@ aesni_mb_set_session_aead_parameters(IMB_MGR
> *mb_mgr,
>  		sess->template_job.enc_keys =3D &sess->cipher.gcm_key;
>  		sess->template_job.dec_keys =3D &sess->cipher.gcm_key;
>  		break;
> +#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
> +	case RTE_CRYPTO_AEAD_SNOW5G_NCA4:
> +		sess->template_job.cipher_mode =3D
> IMB_CIPHER_SNOW5G_NCA4;
> +		sess->template_job.hash_alg =3D IMB_AUTH_SNOW5G_NCA4;
> +		sess->template_job.u.GCM.aad_len_in_bytes =3D xform-
> >aead.aad_length;
> +		if (xform->aead.key.length !=3D 32) {
> +			IPSEC_MB_LOG(ERR, "Invalid key length");
> +			return -EINVAL;
> +		}
> +		sess->template_job.key_len_in_bytes =3D 32;
> +		memcpy(sess->cipher.nxa_cipher_key, xform->aead.key.data,
> 32);
> +		sess->template_job.enc_keys =3D sess->cipher.nxa_cipher_key;
> +		sess->template_job.dec_keys =3D sess->cipher.nxa_cipher_key;
> +		/* digest size must be between 4 and 16 */
> +		if (sess->auth.req_digest_len < 4 ||
> +				sess->auth.req_digest_len > 16) {
> +			IPSEC_MB_LOG(ERR, "Invalid digest size");
> +			return -EINVAL;
> +		}
> +		break;
> +	case RTE_CRYPTO_AEAD_AES_NCA5:
> +		sess->template_job.cipher_mode =3D IMB_CIPHER_AES_NCA5;
> +		sess->template_job.hash_alg =3D IMB_AUTH_AES_NCA5;
> +		sess->template_job.u.GCM.aad_len_in_bytes =3D xform-
> >aead.aad_length;
Should be setting u.NCA.aad_len_in_bytes and u.NCA.aad, instead of u.GCM.
Same for other NCA algos.

> @@ -1775,6 +1947,31 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  		job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
>  				session->iv.offset);
>  		break;
> +#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
> +	case IMB_AUTH_SNOW5G_NCA4:
> +	case IMB_AUTH_AES_NCA5:
> +	case IMB_AUTH_ZUC_NCA6:
> +		job->hash_start_src_offset_in_bytes =3D
> +				op->sym->aead.data.offset;
> +		job->msg_len_to_hash_in_bytes =3D
> +				op->sym->aead.data.length;
> +		job->cipher_start_src_offset_in_bytes =3D
> +			op->sym->aead.data.offset;
> +		job->msg_len_to_cipher_in_bytes =3D op->sym-
> >aead.data.length;
> +		job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
> +			session->iv.offset);
> +		break;
> +	case IMB_AUTH_SNOW5G_NIA4:
> +	case IMB_AUTH_AES_NIA5:
> +	case IMB_AUTH_ZUC_NIA6:
> +		job->hash_start_src_offset_in_bytes =3D
> +				op->sym->auth.data.offset >> 3;
> +		job->msg_len_to_hash_in_bytes =3D
> +				op->sym->auth.data.length >> 3;
> +		job->iv =3D rte_crypto_op_ctod_offset(op, uint8_t *,
> +			session->iv.offset);
> +		break;
> +#endif
Should use job->u.NIA._iv instead of job->iv for NIA algos.

>=20
>  	default:
>  		job->hash_start_src_offset_in_bytes =3D auth_start_offset( @@
> -1831,6 +2028,15 @@ set_mb_job_params(IMB_JOB *job, struct
> ipsec_mb_qp *qp,
>  	case IMB_CIPHER_SM4_GCM:
>  		job->msg_len_to_cipher_in_bytes =3D op->sym-
> >aead.data.length;
>  		break;
> +#if IMB_VERSION(3, 0, 0) <=3D IMB_VERSION_NUM
> +	case IMB_CIPHER_SNOW5G_NCA4:
> +	case IMB_CIPHER_AES_NCA5:
> +	case IMB_CIPHER_ZUC_NCA6:
> +		job->cipher_start_src_offset_in_bytes =3D
> +			op->sym->aead.data.offset;
> +		job->msg_len_to_cipher_in_bytes =3D op->sym-
> >aead.data.length;
> +		break;
> +#endif
>  	default:
>  		job->cipher_start_src_offset_in_bytes =3D
>  					op->sym->cipher.data.offset;
Does the default case need to be converted bytes for 3.0? All algos now exp=
ect byte len messages and offsets.

> @@ -1048,6 +1275,8 @@ struct __rte_cache_aligned aesni_mb_session {
>  			/* *< Expanded GCM key */
>  			uint8_t zuc_cipher_key[32];
>  			/* *< ZUC cipher key */
> +			uint8_t nxa_cipher_key[32];
> +			/* *< NxA cipher key */
>  			snow3g_key_schedule_t pKeySched_snow3g_cipher;
>  			/* *< SNOW3G scheduled cipher key */
>  			kasumi_key_sched_t pKeySched_kasumi_cipher; @@
> -1101,6 +1330,8 @@ struct __rte_cache_aligned aesni_mb_session {
>  			/* *< Expanded XCBC authentication keys */
>  			uint8_t zuc_auth_key[32];
>  			/* *< ZUC authentication key */
> +			uint8_t snow5g_auth_key[32];
> +			/* *< SNOW5G authentication key */
>  			snow3g_key_schedule_t pKeySched_snow3g_auth;
>  			/* *< SNOW3G scheduled authentication key */
>  			kasumi_key_sched_t pKeySched_kasumi_auth;
> --
Should there be a separate expanded_aes_keys in the auth struct for NIA5? C=
urrently it's using cipher.expanded_key which may not work for chaining AES=
 cipher with NIA5 auth.=20

