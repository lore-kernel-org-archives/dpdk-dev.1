Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27FC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9799940276;
	Fri, 21 Mar 2025 11:43:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 62E3240269
 for <dev@dpdk.org>; Fri, 21 Mar 2025 11:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742553820; x=1774089820;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=IeLigrBaJCfHd43dc/h1Prc+Smh9MfxyL+/xllhn86M=;
 b=e+azospSuALW5HMGXlzsOP8CqGAbqNXN99ktMIM0r47xUP9gWSaV3q4r
 Q9MdU/6m6IrkewZ9y9UKvz9v4wU7yE2e5yHtbOZAWngdG2vfgYPTh87Af
 8krajcDUBw6MQcr/bZyh8/DVuw9rmN+JfqZ0JGclSu+NijQQfID41I/GE
 5i9upO3WL4QOaBl3QTEhz8C3YjqbXegTichV2uYKVPM7McbLFx6C/7qtC
 mU4Eua5sMsWJFdarcr7ctwNzNAN7FK+XyJD5t6f5RMJwpngXufQ4NbH8j
 6PVzTH/HZW9cqD/6flOYcV7+vHuTiymIRngxaU1LvCtWQ7n/E5cgrEjTs w==;
X-CSE-ConnectionGUID: mY7dgU2PSquHnJQhJLiMaA==
X-CSE-MsgGUID: 8SlVMNOET3ehWlZovpVwaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43742599"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208,217";a="43742599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:43:39 -0700
X-CSE-ConnectionGUID: jmMSs1r8TLGP28V5TS8uVQ==
X-CSE-MsgGUID: RRf1kzrkSymS2ZTh5+jNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
 d="scan'208,217";a="128475259"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:43:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 03:43:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 03:43:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 03:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWxn0NPJGcTziihxyZp0jytmxgeryvfsfjG8bbvqMNTUwA2ASiFAXMl8jo4BliE6hukuDVETvsNKg/a/tzztyaW0af0/bUWYzI/4EWbbKDgWzKaTXw+L1dO20SnP/S4pFCFC1Lrn8/e5CUkzp9+5of3yvdykr9CIFDBo2jsuNqt80o7iye2aANWiyFn8AiWY+4Jw3b39EaN32KMsDQ77ficJT5nY59xbUeAMcydKhXW9T1VIPNBAcxKURB/WogW6+qzyqNNHHZyBDfoihLB58f55N6kj5wk5gYL/+nWGFYEahlnKIfB4/WHVoOArCItl4qHMENXVdJY4KyTn/ueAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeLigrBaJCfHd43dc/h1Prc+Smh9MfxyL+/xllhn86M=;
 b=ylKggLa6/u2VpK6cnou8SywdqLHXvlOzsjC3QXLr+vn4QZDwvYFaR6fxC5ne8s+tFPVg8dI+D3GeXs8JNTHElzqJCEocynkAMpCwy13f15en1mNVK1e5VsVPNKZFU/ryksQxg3n2Ui3D4Tfx0JHXeJaYeAvBRj2t5A8X7jiMsqRCHBvJ6O5FUz3NCkEO9GsoEFAkgSx5vM5ur344JyhnvTZ7qjDxLB3k1+fde7Zy+6hvJ1ng+qPujWmngiJsnoEQScULzgRjnT6yhQNJg43bI5NrLOtnDdXyXUw0vOzlNXPra8gRRHjvNCgy4ifR4wMt68Qdc0pEioD6tkkKUB9CLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 10:43:08 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 10:43:08 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>
Subject: Re: [PATCH v1 2/2] maintainers: update for FIPS example app
Thread-Topic: [PATCH v1 2/2] maintainers: update for FIPS example app
Thread-Index: AQHbmaNfYjM0gRvrKEO4qeFq4vAyo7N9aLma
Date: Fri, 21 Mar 2025 10:43:08 +0000
Message-ID: <DS0PR11MB7458765144899D98E6C6206481DB2@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250320142113.1130872-1-brian.dooley@intel.com>
 <20250320142113.1130872-2-brian.dooley@intel.com>
In-Reply-To: <20250320142113.1130872-2-brian.dooley@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|SA1PR11MB8858:EE_
x-ms-office365-filtering-correlation-id: 712d3915-862b-40ae-86b7-08dd68652b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nKGVRzZ75UCuR/DpUjeIqwrzjW+WGNmGqMotwKiLA/dkTOPEEIrYjYkCQnO4?=
 =?us-ascii?Q?173Aj5nmRpbchA8mRgIZDRyGpyq8HwnZ7IoNkprL05AGHFHs+WRzc+uyNtjC?=
 =?us-ascii?Q?Ad36to+1xM9ML/KARvHCIrEHZNArs3qcXOc1o16znap9AouGU3S9Q9sR4Qjz?=
 =?us-ascii?Q?B77ub7bVfjSFpJYcPC/+5vb7jnsqwEq+qKw1oijaHwZTnqmVBQzCv/xv8xbk?=
 =?us-ascii?Q?QqwJarkAUdD2TMpBkBIPt4O8qIErjeCDM8OAAQt45sbS7g2k9WI0a5VHr2lL?=
 =?us-ascii?Q?jiVAfe35dWOerLz9hlKFoze+u+IR2fbT7YS7EONqhEjB6Ex4p+6Gggsfp8Sv?=
 =?us-ascii?Q?78yC7MTTRqi+L41l+4jnY6ighpROTX24AQxhM0zGAo4nBgU37Rl/ClXcq2ee?=
 =?us-ascii?Q?grrBfNZXA+hkLTUCfAZIugXfCp+6bpIM0lOnSQAwJdM6kcNSnickwsiiHwfY?=
 =?us-ascii?Q?doV4rJ9WvY/TjGTtMI2np1RCuRPwU0cgMlULZh1kaVqmbjWNzIswERJN3V7r?=
 =?us-ascii?Q?77QdEifbeEIkccMRSWbNQcVxphsM+nIAbNLlcOxbL0DvRmp3Bhr7IJ/gNsK6?=
 =?us-ascii?Q?utUHxhWj68jD2VouEmucxbkhldHXUwi4f/djWXNQznTEE25/tiHfFUbD113c?=
 =?us-ascii?Q?RhcjHnK6O+aR6B97JC3w32o/icot+zEAz3fLw8khy7HNmws64Grt6s2WtaO3?=
 =?us-ascii?Q?SjaIjmOu7+8wsHHaSO/rI6ZWKzUbeyrtfk1dfG14MukO0onndrQmr2YMsDvh?=
 =?us-ascii?Q?NhFWte8g0Hs0bnFfUQB2lMMtX2URzTW3/NFU9Cn5tPM5gwlWIhMfzY++S809?=
 =?us-ascii?Q?LIeP9B1jXTwJZQwn3l7dTmZjHmdQ2S1/fS9TbBXip4ijxeBfYQt1i4tw0wpm?=
 =?us-ascii?Q?Usk2QIh0m+JuQ2qiJU3NKj0cJazqV7QVu8OkI/y+sAQCWgFHxFRZUuVkDWwK?=
 =?us-ascii?Q?BKV+ht+YDPcsjEYkMM0WeOC23+R8mPY1opZtbwjsg/zGIzOjtvuGWeJw2ehM?=
 =?us-ascii?Q?cU9ycTo0CKDr1FOk5UEpH0MUyMwNtFt1QCPywxXYexKtl0z8JD1FnR4EAcac?=
 =?us-ascii?Q?yNDSSai8NroIFmOAeroJ9Nxa/G36ZIEbT8AUyq3Q69atBBJeQojM+PPNJzcL?=
 =?us-ascii?Q?YPuQIEokStUgKQXqzv0R5WPgyDlVW9UWXKqPf1X+9WLUB3CoSzJR9dckujzW?=
 =?us-ascii?Q?FOhAukhLa1/6f117wW3Vybq+I07F28yL/nBn5WfwXMz8M+URWa80g/uoMrJ0?=
 =?us-ascii?Q?gutfUfiM56mea42BM1MxMeshHEp6L4WT0iKtgEyPD6WPJAQetV9O50Ck3fvo?=
 =?us-ascii?Q?qEmc/1maf/V98QIjNySOKIGZluluENZgoC2yhF+n47FNt7er1Cjeue0cOH06?=
 =?us-ascii?Q?U1QBgiS70tuIk8F6rxdzlLhRLLrr7fTHfArawJHa6s3ZWjAKtkL+65x1VqD7?=
 =?us-ascii?Q?SEpwQ6y/rHxBNGSWZ4ZLndp3fTWL3MQy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3dwIDqTY/5Za6yNs/u3JHXaZHy/o6gozNRbAs36GZPlu50Sytok6/fSoVcp?=
 =?us-ascii?Q?PP2HYeR50SihFapBBeO1fNMuqYvGmVzLudExyqQaY1v1m6Zj769hnhlW1cdz?=
 =?us-ascii?Q?DjL+1+TP3XLMw6y4cax70RNJs3paYBQuAL6UAW/hbYE1xkmL5FY3EwffxTLG?=
 =?us-ascii?Q?p6xd2gRO7cn2CWdtKjBWYrIXe+wdhETUtT3Qo7iFjAGOHtfreJTJ7XS9FJdQ?=
 =?us-ascii?Q?rXsf1NjbguvATV8hkpERzqbA0N/q6KrIjt2rOkRNlaoNEg8LRcukzMfgd+3b?=
 =?us-ascii?Q?2IekoKWs99vJvOVQgfkW2JxzBu26sd9KidjvK+coBnHW7VB28QwKP7lzWZd9?=
 =?us-ascii?Q?r/vXzKWd1FhaDeqm5zPeqfifwtj0InwBubuUFZ17JNvv/hmzz2ccVmrj1aoe?=
 =?us-ascii?Q?wb5xhqSKCIXVghhmQhuSXLunbmo2Hvyf8pMo/fZ6ZXmD0GfacWmUDtUTveqa?=
 =?us-ascii?Q?fVYUCYiLS4MbgVIPdcevUv0poNLhXJrdQP/Q9jq5bHpksHFkCo/Kf+bU0Tty?=
 =?us-ascii?Q?QKblJQIl00HzJtm69XeP1FKDQ4FWtne5zQUNY5boZ5NFoJT1J7c2KS8dJ6AU?=
 =?us-ascii?Q?oJYyCEZzzwH1MNfXuS6/ojz7/93JBoLQ3+N8TH7X5kx/HYKm+Y55gpZPPpXw?=
 =?us-ascii?Q?GVeOaQ6msSi2/sjBKvfkBv7AArVqtcj829veSk6MU+OXcCuOHuEUs3ZEDklW?=
 =?us-ascii?Q?iTuBOuYNiZjkWeRn+bRc4ne1KzTebSl0ICpg5CeDrv+YYeLVckbwAhVXYMTc?=
 =?us-ascii?Q?Lz6qd+cpE/Kin1LEbEy18ItHI9Mggj9MYHf/FdK2WrpD0zQU3lsW8wlv/WaA?=
 =?us-ascii?Q?3swWQvAdZiNCFOIxIHfJ4clBPlRZKvR9RYsy9Gnj/FhH3IS9Uq5LQTTYyn2y?=
 =?us-ascii?Q?YLyJLoZWM4mXvHSbbfjlK1zLfZUkIdNZFE2yZ8b3v9rzunDQ7pKGY/J5fVHi?=
 =?us-ascii?Q?sRxVSIPZtIQnJzeTXbmRrCvSHf+E+AF6yLucSBHYTICw5utjaVjhsJ4JdXRz?=
 =?us-ascii?Q?S8Ge/0RDsPiLdZH/uJiItYMSvoQU1NYZwmQsPjD8k/6yeSH/DRXdetnlH8LL?=
 =?us-ascii?Q?1XKjSqcrGFD2i6FDw2W64GkG10AeILgn/GKknDc0a7bxU44sAZgyJDvXSLbs?=
 =?us-ascii?Q?kQm1qJKQBVjMEInTZDf6KHZR7t2Rhr7EM5qXApAiQIwbWCoTdEE4Sh1x52tg?=
 =?us-ascii?Q?DPU1SY6ftlQ/3RJ9DlR3M0cyOlO/sljtuHUxETyrioqkkMoA8/MkrypdYtKc?=
 =?us-ascii?Q?HzQgElzlBxOk/UPnXOpqjzxInfYEI5Lt0HoOiCHZLyrPzBXKURtlV90goY/R?=
 =?us-ascii?Q?kbTmuKXEh6GpqxtfKYGasnK1xapEWrAXv8SccmV2dXQkvIPUiYMeI14YhGOt?=
 =?us-ascii?Q?+Bj+ls2ujfp2P8izN9gTMWg5dgcgru9JG3/vUY8+rod4KbTQ3/zvWKY4c4Hr?=
 =?us-ascii?Q?euYsevH3axsOJeS49ropYPsCEd4SKF0TlldemJJ47HPgXQyZqv08NpV4RX0F?=
 =?us-ascii?Q?jxd4rhMDrv1SInoRQtkMwZE9wcXliCZLPM5ofQL9qt6Tg/19dOEj6eUSSrHL?=
 =?us-ascii?Q?hpl6ym6MyMCow0KjXuM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458765144899D98E6C6206481DB2DS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712d3915-862b-40ae-86b7-08dd68652b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 10:43:08.3680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Of9Te8TOfGAVFLavo/fIducz06L78QY5WU1mIA5u4glwP3Jgsjuro2ydTPAX42jRFWGExd2kU3wm7C9gRGFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858
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

--_000_DS0PR11MB7458765144899D98E6C6206481DB2DS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Dooley, Brian <brian.dooley@intel.com>
Sent: 20 March 2025 14:21
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org <dev@dpdk.org>; gakhil@marvell.com <gakhil@marvell.com>; J=
i, Kai <kai.ji@intel.com>; Dooley, Brian <brian.dooley@intel.com>
Subject: [PATCH v1 2/2] maintainers: update for FIPS example app

Removing myself as maintainer for the FIPS example app.

Signed-off-by: Brian Dooley <brian.dooley@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdcea9aa72..4b01103f8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1979,7 +1979,6 @@ F: examples/ethtool/
 F: doc/guides/sample_app_ug/ethtool.rst

 FIPS validation example
-M: Brian Dooley <brian.dooley@intel.com>
 M: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
 F: examples/fips_validation/
 F: doc/guides/sample_app_ug/fips_validation.rst
--
2.25.1


--_000_DS0PR11MB7458765144899D98E6C6206481DB2DS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dooley, Brian &lt;bri=
an.dooley@intel.com&gt;<br>
<b>Sent:</b> 20 March 2025 14:21<br>
<b>To:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; gakhil@marvell.com &lt;gakhil=
@marvell.com&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;; Dooley, Brian &lt;brian=
.dooley@intel.com&gt;<br>
<b>Subject:</b> [PATCH v1 2/2] maintainers: update for FIPS example app</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Removing myself as maintainer for the FIPS example=
 app.<br>
<br>
Signed-off-by: Brian Dooley &lt;brian.dooley@intel.com&gt;<br>
---<br>
&nbsp;MAINTAINERS | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index cdcea9aa72..4b01103f8e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1979,7 +1979,6 @@ F: examples/ethtool/<br>
&nbsp;F: doc/guides/sample_app_ug/ethtool.rst<br>
&nbsp;<br>
&nbsp;FIPS validation example<br>
-M: Brian Dooley &lt;brian.dooley@intel.com&gt;<br>
&nbsp;M: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<br>
&nbsp;F: examples/fips_validation/<br>
&nbsp;F: doc/guides/sample_app_ug/fips_validation.rst<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458765144899D98E6C6206481DB2DS0PR11MB7458namp_--
