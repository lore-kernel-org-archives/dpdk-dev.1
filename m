Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ECF55811
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67EFA40272;
	Wed, 22 Apr 2026 10:19:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id DF55940144;
 Wed, 22 Apr 2026 10:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776845963; x=1808381963;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=nt5DQu28dAyl2erzYCCvL/fLnc7+1OhhNfQ4KZWTpeg=;
 b=FIwEBPDjR5jUvmx02+Notp+LtgS/xTZBUfVXjwpcd+MdMktT6gh2oo9G
 y07uGiymRWoGH4jO7tsTXKtNexWAmufQVA8vnleQgQJ/nVeEouMrA1hLg
 +gHwbZedfuk5t+WNHERAcCjJnAj2wFGvZTVXfQZIui+3Cs5FyqYU9mm6y
 7PXs/gzxd0hPCZFMA51FyyYGN8j5BralYb7EVUxPGTH+AgfFrztfsxS50
 QvXalMyKdANkbJW5cJ6LSSih2/knDQ/Cw3Z0DeA4Slaq/5R5hed6n7ejp
 LkPeAKa9ntsfEqtlTVdBpFdSnQzmJapTt7Evev/vWQFHG8WlhI3B50RpO Q==;
X-CSE-ConnectionGUID: FtJd4hiaQNGMF9ygesok9A==
X-CSE-MsgGUID: V9Of33WORMuMRLw43ZK4DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88095688"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208,217";a="88095688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:19:22 -0700
X-CSE-ConnectionGUID: yuJHZYy2Ql6oLmWZUM1AAg==
X-CSE-MsgGUID: eTfeZiiHTP2BudMhZfjIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
 d="scan'208,217";a="229617506"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:19:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:19:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 01:19:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNNDJghyPlLJpQmG06RZYPNQl2+ox2jb9K9575/fuWoUuU4xHncexUcaVRXnlek1iur2MfGaTFyHmdREhU367kdNH7xbrf2joVmuG7zkUQT35XDRy5R6d2pkni1wWpEoQdci6Qqajjs9LVodT+GoGm4Hbvh4MEZhART5InF5FG3vD6dorXqh5vmjxEUsQd/Cu210DrIp7bPvn1Obd7KnBcdPgpCP9TQPCzPt+fSTTfQ2VmyA6GFuKKzhzMaE98JNbpWJ4RIbkjExpNyc8XbElH8jXWepFH5SMgaeLdytnTvkdBeN0MPbnzJ/5R1xTOKAfKqiamNQtFTvQZSZEE0jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt5DQu28dAyl2erzYCCvL/fLnc7+1OhhNfQ4KZWTpeg=;
 b=Eo1vvHtT10LxaFV1vUNPalscq1gO1MdAxnZ4jPvvanEi/zaLQ1Mt/CCr8GLbHo83zP9ORmF/0r4cOTCYp58KGi2eah/k2mx7wHI3PHVBwSdvBTmism9/uOsQ6UVq3MDAYeRz4P3lWH8njHwkXuIevb3MHYerlv7MoLH1YF0WIsWCAf45GmNbcJS+n67ISBZdxYFfXKlmYNfXJKn/J+dbzPiKxlDTTIpqFcWydURREQfy2LmffaTcfkKulXJfTaMLJxMbQR7RtSMofTVVnYRx2J39kx1mFLMsuMsdb5YYk4DxgGWo5ynv/Frluo6YzADb20DLnf193QOuNYQ+TFj1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 08:19:17 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:19:16 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, Adam Hassick <ahassick@iol.unh.edu>
Subject: Re: [PATCH v4 1/2] test: fix failing tests on FreeBSD
Thread-Topic: [PATCH v4 1/2] test: fix failing tests on FreeBSD
Thread-Index: AQHc0ch2eGUlQqYW+UigX8ucO50LV7Xqvbtd
Date: Wed, 22 Apr 2026 08:19:16 +0000
Message-ID: <CY5PR11MB631842BE0A7E301BFE6315C5FC2D2@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260421195227.1425625-1-bruce.richardson@intel.com>
 <20260421195227.1425625-2-bruce.richardson@intel.com>
In-Reply-To: <20260421195227.1425625-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SA1PR11MB8351:EE_
x-ms-office365-filtering-correlation-id: a1c1c06b-d8f4-4e4a-ccd6-08dea047d876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: RpYHiyVq+e3P5+GxCb/oUZ+VvaIjBIqY1pyTsRbkkH/kENgUkvXPNIWwv7/IbDUL3E5f62fXyCOQlzzrVdMGRlttUlhGq8G6zaHd1Cn7Iy2EVZtvsogPC8Xjhdxx/7iW6s2cJgNs0FDHDFXtCpJtUwUV7Q6mYAihismsV33rF9WeGuRi9X0kxSjoHxnSo/l+InAZsGbkuwJ4s60sxIMrCIiX9Z6nvjzswNlcIpU7sO95odNEgzflIL0asRBHDFeB893obnTa0kohg/nmwJqARi95J4+Ce+SnFBJFA3GDNNDea3hzxJfLnF9BV4VLHH1WU76Z2DRwNYB9SLl49qvcdmj1nYmELt4UynvNeRB1NL9luenBKrlSR01+PyQEQT+kRXsugEkQs2FQnvn6O0I37lFDLklwpeEEwIvcyhFmntg3hQvoA5xuDxorj6BC/Pe+lYic+ov6fZJiixugxey44Ed6Fi60b38OxRiHWETYs2d8fF+eceJKYW70b7Q6dSnQa9ZVH8E9KBSuILGDuObUZ2HH446dPi+Od05gxO0U0Y2t/Mv7Z3RksGr933aYDqOn/va5DGzLJ3DIMaMdzkIhGKLbrltweOtuFfK1jl7ghwVhat360ru/j8Ce0UjuL/3s6mt7Oen4Dko1KRcHy/PukXWqEWpY9xnKb+TvvG7UXqOzZIRcLX1VmF9S7vk5H+MGC7MSFkEhL7HRqI3iNX7+jW6jCmJkXUmPvssRS+CjDPkfXCT/2FHuFvKZvQExKhq7w9urkY2tW24K+BthQlV+6PW1hNz289Phhm3l83yEhPc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1b09jG1wDUDOMc5Q8P6E/5KT0qbJ6a7aQO0j8V2TNmdFQIV02Agoj+91xR?=
 =?iso-8859-1?Q?OgLiFrNuVccVvC2NRDxTvgKPYvc7V0maVNjdwD6jBoAY/Z6Jd1MRev6cr3?=
 =?iso-8859-1?Q?CDLtXQX5xxKy42Is9DqCUG9iEqK8GYbaDty6QzjQX86d+l1NQTEU9uAsNY?=
 =?iso-8859-1?Q?FF12ZxSZQsFkX5RwxNR3L2epaTlOedYo7ZrhQoos9+pQScnmJP8YhU2Prt?=
 =?iso-8859-1?Q?SVsuhsZuxxjtPBzGZlWyKSlBGkvjTNxizLW+/XMPenYgjmtlbL+SmPOh+P?=
 =?iso-8859-1?Q?qKsQbkEBHfopl/5DP3icanj9t4Qf7eahzUOf+7TifSdv0Pb6MyZF19Sm8M?=
 =?iso-8859-1?Q?SLmr0Ym/grcYYbcFv7th1H1FNMw3ujuMJmssvlHVOFydS8zwYLagOCY3+a?=
 =?iso-8859-1?Q?FHkI1ga9QUWgo32P52Xn0SJTXycisUpwG+j3iGNJJNitNsat2y6nAKcifM?=
 =?iso-8859-1?Q?gFluhAU0dM3lovvdyARlBHFAEFlfhkPXNHbii2EmrqBGljqRagNv7UAElN?=
 =?iso-8859-1?Q?xD0CWtRqV2fSG1RQc/Du2EUb2u99oijKzGFPvWoQcww0K5ABJk6U9sDD8b?=
 =?iso-8859-1?Q?r0Bb+woCzNyCx8O9RTk4wbr8j4mooTB8MdDU0iXUtKJDWWXURdp9m92Z5U?=
 =?iso-8859-1?Q?6u9wTX3pXxv8/gGcrO+3aFmjWV/4aYegHSVyYojObWQB+UVF5cLIWGG0Aq?=
 =?iso-8859-1?Q?su5MrkMnWMvB7PAFTIdou+iWjo4KgxBO9+7cc4dXRQHuP+IMa/wye2j5rK?=
 =?iso-8859-1?Q?aWZFFYp1HpKxC86mL72jn4PY6Ha4Rl1mZKG4gM1so5taQQ3UjYjNq8RmdB?=
 =?iso-8859-1?Q?M3Aj5nrciyFjr/gt4+5zsLDEuuXQSNHa0KF8xDVkblSO+GpSvk/EWZDhoZ?=
 =?iso-8859-1?Q?sZgjEEpEDgV7pmMC+fOTeo9dpCqDkiJ+dKF9y5R1LrpXU2CzoMon/ApFYA?=
 =?iso-8859-1?Q?WMBrw2H+tuOrDg6+iZTuB/SowyVb6unCLMT6rC9rw0Ec6UUp3aFm69UFjV?=
 =?iso-8859-1?Q?/SpGQGxmOhM0mgaaFi+O4SbjfpbcJW/Q5xNZ6a/In3q9rdtRyncSzD4mUO?=
 =?iso-8859-1?Q?KV3JqewN16SmxYlTS9Og/T+0cMAykvHaw/XZfQ9tKnakrGffAxcvn6uX25?=
 =?iso-8859-1?Q?8BX98oPXo9PPVh7RNyrNtw5tkLSZDTu92nQe397SDT/ng5tSesmR3ZTPYR?=
 =?iso-8859-1?Q?ouu9hknfZIpqNUWLe0Lq+gQTKbmi47mY9qt8es10hTcuIO4nPvnQBTJVnP?=
 =?iso-8859-1?Q?teCzN5CFbalyzDZesyGln0F3T9ktJ5UatlMZJY7sU7ecsuekStnuCYc/WM?=
 =?iso-8859-1?Q?rv+tr+DJrh7VaFGNAB9+y8fAeHXPxM2NBAi6Nz5prVD5dHbadr9SxRAf6u?=
 =?iso-8859-1?Q?DFSfpkCpu3TbgWMgfNUITcrexj+UfrKSEn1bxpGduV0N4SmRBxR4RF2NC9?=
 =?iso-8859-1?Q?yATLzag1BqYOQTqNHFbZOjp0qsl3z8fTX0ViXuYq36IFMtX/ebKRQIsq/c?=
 =?iso-8859-1?Q?4MwAiOlZamd8HEAdyHFuigy/zT/lpMIFvGWY05KVuozFWy4bvWjt6tXnSh?=
 =?iso-8859-1?Q?lyqh5RtSRx9IiFsy9mvGdFIM2fW5oap3/N/RZ5w2wafiqI6JGmtIhYzSsn?=
 =?iso-8859-1?Q?hlKGTjx9MhltqNF2EQLJ/BDGQB7rdnGAM3h1p0eW0a/0ZT5XBh5kq7X6yO?=
 =?iso-8859-1?Q?T8rqSH9jrg9Fk134Ln0yYTkt4k2ZbrANvrgDjzfOGO0JgBo+P5RAaD4web?=
 =?iso-8859-1?Q?uuaVERIEnHQnqlydUKf7UA6wAn0owT+kB52zeUZaf31/lbfwtifZbj0nHH?=
 =?iso-8859-1?Q?lxM7oL6hLQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB631842BE0A7E301BFE6315C5FC2D2CY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i55spGMUQ96+aCtb0vqAZ8uv1fD+oUArgjyYTqdNxQgaCrzlBiKaEBUZLo+JFVEPIjOl7N2V4qndaxZpOR38L8MwJr5tj8B36wBS06Ub/KjyUUD53GvWLly7z9x3Dh55QHfgFwzFo289DSS7MZek4nJBJHzYdp+i+cS0/eP9HdkXElvgzX15Orn7InO3EWC4JRhpmYKT4Shrig/Cs3DA59Cz+jXCf4iIGDmnwmxkCotxnXc/z8OtP4AcHJJeHC0manaZNm86r7nAcUbRB2gwgr/HZh7b+SJg6PVwo07JD/pc7lLQ36DY/VXq+bBEt6mx8nZHxlSeXf/6guHzmK5nbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c1c06b-d8f4-4e4a-ccd6-08dea047d876
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:19:16.7852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEwTymJ669yJjGLV5kFJeP+3vHQ0JmxHcFVr4EfDTNKmG6OguNFQsFW4mCUf2616+MdT1Mt9XtyKQeBeyIU65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
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

--_000_CY5PR11MB631842BE0A7E301BFE6315C5FC2D2CY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Tuesday, April 21, 2026 8:52 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Richardson, Bruce <bruce.richardson@intel.com>; stable@dpdk.org <stable=
@dpdk.org>; Burakov, Anatoly <anatoly.burakov@intel.com>; Adam Hassick <aha=
ssick@iol.unh.edu>
Subject: [PATCH v4 1/2] test: fix failing tests on FreeBSD

Many autotests were failing on FreeBSD, mostly because of the lack of
secondary process support. Skip these tests, and also fix the debug
autotest which crashes on FreeBSD if telemetry is not disabled for the
extra spawned process.

Acked-by: John McNamara <john.mcnamara@intel.com>


--_000_CY5PR11MB631842BE0A7E301BFE6315C5FC2D2CY5PR11MB6318namp_
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
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, April 21, 2026 8:52 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Richardson, Bruce &lt;bruce.richardson@intel.com&gt;; stabl=
e@dpdk.org &lt;stable@dpdk.org&gt;; Burakov, Anatoly &lt;anatoly.burakov@in=
tel.com&gt;; Adam Hassick &lt;ahassick@iol.unh.edu&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v4 1/2] test: fix failing tests on FreeBSD </di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Many autotests were failing on FreeBSD, mos=
tly because of the lack of<br>
secondary process support. Skip these tests, and also fix the debug<br>
autotest which crashes on FreeBSD if telemetry is not disabled for the<br>
extra spawned process.<br>
</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Acked-by: John McNamara &lt;john.mcnamara@intel.com&gt;</div>
<div style=3D"font-size: 11pt;"><br>
</div>
</body>
</html>

--_000_CY5PR11MB631842BE0A7E301BFE6315C5FC2D2CY5PR11MB6318namp_--
