Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710521061B0F
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 16:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9277F40615;
	Mon, 30 Mar 2026 18:44:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 46F17402D8
 for <dev@dpdk.org>; Mon, 30 Mar 2026 18:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774889062; x=1806425062;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=xqQfxiIHs7YbnEHDky3zsyc0LbQi9IQwj2IRFc2DaK4=;
 b=X5BANWu1Gimf+jBVFwpJNkxF+xl1VnF12mpn9Bet/YcQEdhUJoAoDZM2
 c9P69K/fd1mX/AtVA7K6dgpy6iGy8FBMM97Ecx1A1wEZHYQONUGEKU9Y5
 qGKxmCnUoxkGtIg+L+4Wda557Whiu9Ax/M32YysRl/HMd6NqoDZbm3zQP
 ttR3tdspANfm4H6v4Psdiui7nyP4RyxkeO36jxJkgYmlpNqyMDKf43wGN
 5D50cJy/TtvHT6DJYFxanq6THHFc9AzzgUXXFoPmIiAmWI8UHgjNGX+si
 CcSEcnYKr0AOjJKVOpDNvzCutxb2a76yiGh8niKLZJ8yVZfKOgNhS9I7X g==;
X-CSE-ConnectionGUID: 4S5hCa2LS5Wr/rbBm5ORbA==
X-CSE-MsgGUID: 5NzB9y4IS06Lp/xN4JsMIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86191457"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208,217";a="86191457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 09:44:21 -0700
X-CSE-ConnectionGUID: iF/6RkdQS1i7pRlbCIyeTg==
X-CSE-MsgGUID: makoBvvESCylG+H8u9p0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
 d="scan'208,217";a="231026606"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 09:44:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 09:44:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 09:44:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 09:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQpZ4oulojGeH0506Vx3tWO+yGnBu4nyZJKnoeuNia/T1J+WsEKbElwWG8aRt4U/i4yvsh2QqWpR4NKJjwqUGwkvgk9asqKYoOME/RGppnm2+VBdb9X6yYhBTTN1ERJfyesEyKdv68XNQEhJpXmFuh5cE2mieJ/XcGUx8F4F2n/Zk0wU0SbS1Hdn+ZVjJGHuPNSMidi5OMo+HnPPPaRmmw7sBNnQHOeMpJi6Ih5anj+1gW2DIN+bWmpn5r+wprThtzX0dtretIoCeG1Z09A3+K6L/K5GmBVAZBaw5e8wkTey1lg8Rujds6ozF2gv7y3XR2AqrX2DVwUaA/qyG5uAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqQfxiIHs7YbnEHDky3zsyc0LbQi9IQwj2IRFc2DaK4=;
 b=dVwogAJFyqtXJ2y7e47ICaItYmd5rFH35Ic9LlEdEpo4QRXaVQpBGeOKKOSstA7VXmPNSvCX74WYgDfMPB8l04BdsP5NpPakI5I80GeiHWsrDuErDb4yTLZv3H9tudDJ58SNb9eBstAivfbUAV38E4fzLktLCnfKcQJWUDkTBYJsZ7DiVJS8FiZVvkgxnJJ+CoGBEfh7wPj51Nd/rplMVZbgfc1bbT839oElNXdh0CGegGk6gD2TJALJUSuKJErkEvEN5Irv1KkH9SUNadnmIih9Yh2p3LF0dGeEKAIjplFu5T6XZoWjIOCcJShGUv0KTsX8C5xe1W22tcdow6xL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:44:17 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 16:44:17 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] Consolidate, shrink and update version tables
Thread-Topic: [PATCH v2 0/6] Consolidate, shrink and update version tables
Thread-Index: AQHcwE+IFDoXWbvZnEu25zvla45C6rXHSBR7
Date: Mon, 30 Mar 2026 16:44:16 +0000
Message-ID: <CY5PR11MB631813C43AC9D9373E875FC8FC52A@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SJ0PR11MB4942:EE_
x-ms-office365-filtering-correlation-id: 2dab6a04-f794-4fe4-bb32-08de8e7b9544
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003|8096899003;
x-microsoft-antispam-message-info: +zxq+i0u+imsUHd5f6ThEx+eo3FmQPjjr7RnXd+4EvY9vR/1UDDmOj8v8+Yh5YujGuR9oKJBuRlz3yFapo/UsvGMBJKqG4BwVRSPCKMTdpb0lFhOCQIYWJ/XEW7vm5JHRb/EJ7XWScPE+DFkxQZwKBRpSnjwRVqby8wDSKT2rADTf7oXqhzJoHvihEynT6luY0hfcQ/uO2KEEbCtIiUyf6xtFniGMwb2+VCSPXPZxbbhoBf/qWApdHRzaD76too4CBG0TYI97savQJj6UHwVdKsL0yO/t2kzCmY2RQhNfMcstU/XhLAfeBQA/S9gybUhzimMS9LzBqIgR2jJ5QT8kkHQkpu+/pXLgZCQ8RHHPoFYEdR37aw2iGJIgm0Urbj8pT2uEjgyFHDG6WuELYQ/IK4dBjvW69qXz1YHyfY+TyBFgReYTpD/Eq914llIYTMX25CTjKcYG05KkpHqC/wzOMlBvhMh0JGyf8WSDboHpA5UIsGz3aibmM1v2nAg9FGjJOX5u5uKNqGItEdsFmgIz254wauci46USrKhxzFNbGKZlDXMQXx4UnQYJpWL3/iwt3lAkRs7PsH7u6X9FO45vvFa99XxUAs+A0zsYZf4XD7n7EcMADDxEF1Cv1PmGhYxN07aMsFZOLHXDrcG/vYdTC4Fq4SWpkQfSGO5l4Est+Ju43MqubXnBWRuXfKWRxN22v2WPfU3BWTmTC0kc3VxhQp7Dj9HrHMpM/iiHcw7NRIEOlFm2ti9JRuylMl2r2Zd7J8Rxe8sqdm0YtakWV2owHUIIzwLGAfc9m6Ow4WL8V4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zPLV0V1BJR9LX2DtTtqPVtwUBCYxyqEOsMFE9gARhW5Via3i/EAnTQx+2T?=
 =?iso-8859-1?Q?E+VmtGObD3OLJbIE4Ew6JSzJyzJECloIxtGWdRgJJAw8EQdpG4N4BsHj2R?=
 =?iso-8859-1?Q?/JkkphmaqknBtBYTShcPWrJk4qIrhUpSfgbdFIt/Mi8L+uNXpRlmun90lm?=
 =?iso-8859-1?Q?CVrFDLBSrR3/wPdddKtRfniN0Co4XSGEBkBTIS5RYb3GC52BtX0vnm9rfT?=
 =?iso-8859-1?Q?wrnSqP89EIUMMoxDhLnTjRrirAL+hSOlYF9W4H6F6CkjyfRPI8ZTIe0RWH?=
 =?iso-8859-1?Q?yAnCxQi2DgvwxQbZXmyId0jQUkVhBKGGm0KAqkJ0u1sEcg8Et4euNVlpBy?=
 =?iso-8859-1?Q?o03uAcfDf4D6DvEJ/Wpx/T80k1HTHGa6ohBRNw5GvhQ9XBx1azsuh+eBsu?=
 =?iso-8859-1?Q?DSbxHM+TWaPLt8T8Nrh0+lkIc4DS37nPJ1dpDaL8PlEA2cLH7kVZViye2C?=
 =?iso-8859-1?Q?GJ6Ih5Pj9T4lPh3f1G7sxmZK8CWE366XUpSx11qhH+x/n+FQUgmGKATJu6?=
 =?iso-8859-1?Q?3hf1HaanGS+x+nXCnBtKkSSw4dkfaB1osD2PgislS0FS3mceqzu4iIiV0j?=
 =?iso-8859-1?Q?Ac/lyopr4Z3kF4Z0bymG39pGB4q3a6ED1L9gKBb0uIl0HE4TKsmCyl28Yd?=
 =?iso-8859-1?Q?YLkqa79EO1eA/qicCxyZUDjicV2vRB2J2xFDn9KISaZWmFKIdBkweHugtB?=
 =?iso-8859-1?Q?csz4ZGEbo2ZWTLxFZi9KUYo9924JCoj9LTpHZ+/gvGQFvEvn+9kWFtf9Oq?=
 =?iso-8859-1?Q?dMH2AeS1F75ZoDze9OMLXcHAa3Tp1tNrlTCcgFamHoYGrQhh3uIgS7Eug1?=
 =?iso-8859-1?Q?40L4QoctdUaB3mvhPBni7Ep073mY2OXH58YeK86zuggI85z8I6++WvUksc?=
 =?iso-8859-1?Q?QgX9/OE2xhiG0tzT04d2R2f2pjS1MiAYUQl9kk9qz1eFE2NmtgjnsI2CrO?=
 =?iso-8859-1?Q?IA63QTD/rboe+83wWJCtvFEgsNDKc/8gBUl+oQU+Nahc6Drf5nNSuMWMXH?=
 =?iso-8859-1?Q?6my0Sgh0gUVMVYn55w6hsSHZossHLQRbJPMh7UzTdFbvwA3qelp7oqDOQH?=
 =?iso-8859-1?Q?UzDuB8IKJD36f4MVrNnC6JgosQkQX8CyK4riI6UUZXjfpCKLceqzQnTvuz?=
 =?iso-8859-1?Q?Jq8j8qTeI+T7mdaml98zNHcBsA0Nr2gWAYs0vrUQsE9GZv8smcVwqAgWr1?=
 =?iso-8859-1?Q?Oq01WMjzzdyvD91G633Ex1KRRu0NxMEx43JA7OU8mBHZJyvY8UQhhQBswL?=
 =?iso-8859-1?Q?mpErc8MMAE4hOStuO+Oz5FXnlZSUKZQouMb0s3NA+BZ4ZRp3iKoEM/u6Sk?=
 =?iso-8859-1?Q?l6yd9C5PQBHbGL68buMFCDrgriAaTuNYygYEMphmaHJIr+ab2zbhVTrv60?=
 =?iso-8859-1?Q?a+CSOo+oOmHei5xnasXZ1bpe3LJZTJPrrbfkD8c1iG6j+rYNCKffhMWzOb?=
 =?iso-8859-1?Q?xahi4XQPLaAOXv5/M9HRM5SkpsigAdx42Fo6AeG50u+xPaj9VgZb1ryyNw?=
 =?iso-8859-1?Q?mNcBunH6GaS/WHiLWWIMfD628/6JFe2hKqqSTogLJW6ufkTb21XUIPg856?=
 =?iso-8859-1?Q?UMLROASBbJTKgOHGlzAAEQji6mhVtvKVjyjDQGuGz0n97qrbreUn0Jjk0C?=
 =?iso-8859-1?Q?KKlSZZKNtLlLAkFyrEm6AskKoS5R8zwRDRya9Eet+mz8nKv0BFA0OGWaGL?=
 =?iso-8859-1?Q?CNtyBTXk86qWOpJyY1DxCD/YDzejCKkAq2ss4oKvksp5VwNIoNV36aL+IS?=
 =?iso-8859-1?Q?9pKR1fzcCdbLtoMd5mmH1S4hl9LEJcSCPBNoc63m3PqSAL2MISoPasNwte?=
 =?iso-8859-1?Q?L8I7iNk9IQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB631813C43AC9D9373E875FC8FC52ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KcRhk/lTw+jxAwYgbwN3Lym0jjM1p0UU531k/hnwBAdk93uU4zillrhGkkLXhs+tWQAjFrIWsDZctUnGu0EjB/PCT0P3fhLYs/h6XYZK8RXAhofdoZ4wc8UkMo51cQRWNiuZPi/4vYj9g2mHZI75Nu7WCisyDAL+0PpExhcW4VnnfwdM7SLKh5SCpp0KWnFzrVYYu8MPeZZ58y41Y/TKX3SM5DJqhRDGQ1W9I8pYb+lJ/rRfbdCjTX0uK2GOUAvlptJrgS1CSc5gPeGQkC129lwwP5SibqLd80yk0dcEhe3p4TbH0IPhQkCAzKdgau9GSM71OHaQX6vPnOjAYkXVSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dab6a04-f794-4fe4-bb32-08de8e7b9544
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 16:44:16.9534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBQ3htJT+JOz7q3ncMEkqBaHw05n9RmGuhiAjIjK9jEtt4S2SGc8bmXkaXQ7N7SgC2A2o5HYYQIkmOGbGNKhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
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

--_000_CY5PR11MB631813C43AC9D9373E875FC8FC52ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: John McNamara <john.mcnamara@intel.com>



________________________________
From: Richardson, Bruce <bruce.richardson@intel.com>
Sent: Monday, March 30, 2026 3:11 PM
To: dev@dpdk.org <dev@dpdk.org>; Mcnamara, John <john.mcnamara@intel.com>
Cc: Richardson, Bruce <bruce.richardson@intel.com>
Subject: [PATCH v2 0/6] Consolidate, shrink and update version tables

The version tables in i40e and ice were overly long, having details
about long-unsupported releases, as well as containing duplicate info
in separate tables for different NIC variants. Merge and shrink these
tables to make them more manageable, then update with latest info for
26.03 release



--_000_CY5PR11MB631813C43AC9D9373E875FC8FC52ACY5PR11MB6318namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Acked-by: John McNamara &lt;john.mcnamara@intel.com&gt;<br>
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Richardson, Bruce &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, March 30, 2026 3:11 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Mcnamara, John &lt;john.=
mcnamara@intel.com&gt;<br>
<b>Cc:</b>&nbsp;Richardson, Bruce &lt;bruce.richardson@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v2 0/6] Consolidate, shrink and update version =
tables </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The version tables in i40e and ice were ove=
rly long, having details<br>
about long-unsupported releases, as well as containing duplicate info<br>
in separate tables for different NIC variants. Merge and shrink these<br>
tables to make them more manageable, then update with latest info for<br>
26.03 release<br>
</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-size: 11pt;"><br>
</div>
</body>
</html>

--_000_CY5PR11MB631813C43AC9D9373E875FC8FC52ACY5PR11MB6318namp_--
