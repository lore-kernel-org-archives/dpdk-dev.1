Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D4CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 10:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCD040263;
	Fri, 29 Aug 2025 12:40:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8785D4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756464055; x=1788000055;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cd2rnlxCQqA+Qe25aTfuU/vyPNSIQczg8xly3Aq7kb4=;
 b=kxz3lmFIcA8pK2yR/BUyZrq1d4jCWwl2CzZZ9VYtOaTjXjlPhTWCo1HI
 ujgq296BCAglY7yJA+iujMp27knu0ZRnIGU8PuJqAAhoPVpo3wRN4xSqu
 zyUpE3qOQrczD1wTHhZTfljq/XywA1FoCIcS6iKIsosCTi1lhDK0l2Cnz
 JCGIkaGMXyqsvASZZU15QUdgSjU4UuQV/7ZJdaiduX+v0FzgNrbz73u2W
 aVLFpu1spfEMUhymt6jXNqsIF9L3zKgUCvvz5b06RuBv1LVcYPRVB8+br
 qmAQigdBjUGIge3R6XzfmjRjOtI6Pi7FbSgwUF482N0g3RgsU+d3Q+yyE w==;
X-CSE-ConnectionGUID: E1EA5+qkRY269WCWh8hmSA==
X-CSE-MsgGUID: +eehnr/pTUStY4Bt7OTILw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57772692"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="57772692"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 03:40:54 -0700
X-CSE-ConnectionGUID: c2hshXUNSLai70C2EqqqOQ==
X-CSE-MsgGUID: Omj0qrkRR2a70/UtOHAOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170257589"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 03:40:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 03:40:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 03:40:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 03:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR7jbPak3AGYQIFfRFpKABolHkaMuQummg8rFySKxOyvP+t4Apo+OnWco7DpVuLKstd8sg1JdGS7sN6BLdcZ9+6OkUCUAsp44YrfMCCgUHPPrRpzNBI5L7lrwe90ORDV8Q6eQCPPl640S8OILVtCqq/V+LPpmzqB6u1Igh2qgq4H2+pIEzPRCEMWOKDvrQm7Ef0iITEuOrnQAdRHYVS5vN36wpx+YnUSwKEe3zbfzoyZcjsSKD6RY5rR69Yt+6e35PZHU7VlSiwlbLwNIivUXkoTNz5OWeMk4Rg5hNd8L+XmCMecfuX6lvIkfrvZiRDDUZj5b0m4eBioyxaq8zVshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd2rnlxCQqA+Qe25aTfuU/vyPNSIQczg8xly3Aq7kb4=;
 b=GLGGSzYcn8tI7FuTMty+xcFhqE1EW0hjl+aM0C8Pkc+DZKp9R9R6VbVj9zkPliSj6uZoAF7RMCCvEhucCejTRv3lKQYMuf0Dak7BO4AdNThPttjsUkrGUPzOZ+HEG6jNuW4uwxpGXWWIy3SQSKh6HlnXAS6JRIE/m+sqzuY3VUgDs1iKksIV3OnS9BYydAWo4MDIyCvdRpHMFuQtAPNMbDwQ0gJwXbY+YfQ9nxzNc8KxeUXStoRUoVIlRHZKEon3n/a63GGMhcAqmahms5MxNzYvowB303bQxuBG+rcc515BYU0HwwNW2bEQQ0wV8Gu9pEHA9BtgNPM/5YOeQGMRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 10:40:44 +0000
Received: from CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7]) by CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7%3]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 10:40:44 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4lYAFyVfvK0EK1wLnj+HAwKLR30B4AgAGYqhCAAAUkAIAAAKSw
Date: Fri, 29 Aug 2025 10:40:44 +0000
Message-ID: <CY8PR11MB78457F3C1B8380E1903391D8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7845:EE_|IA1PR11MB6516:EE_
x-ms-office365-filtering-correlation-id: b1f547cf-b892-46fe-a8d1-08dde6e88216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RnRlbk9HanBQZ2tGRkJaMm5ycU05aEw2ZlJTUmM2ZzRmZjkvTHVvQ29zU1dK?=
 =?utf-8?B?U2YyM0pvRGFkeEh3ZTJOQWJ6NnEvRnZoT3BpK3BaVUpqc0NhaThjTjR5U0VC?=
 =?utf-8?B?THZacWJoMnFpMC9DS0tVM3BCT0ZOZHlTRU94eVdWVnhCcGpLUXVXRzhrSWpP?=
 =?utf-8?B?MUU1M1RaZjFjMGQxaGFjMWRaNkxMMlQ0M3MrUnRnd0tTbEdCbGljUTc1cWk3?=
 =?utf-8?B?T2hxM3lxTjZSRTN4UnMyY0o0QVhMWVNRNThjKzJsZEJXMmFRQmFuRjg4OXFl?=
 =?utf-8?B?cHRHR3dlYVoyU1FPUXpqTndGaWllR0U5RVpndXNZTG5IdEpUcHcvVEhreGho?=
 =?utf-8?B?WWFhU1lEMUVYMlcxMjJLQTY2ME9PYnRxc2dOR05MYmFaN3JyTm5LOHVEUkV1?=
 =?utf-8?B?UUpta1d3UjEyZWlOOUtNVGNybEEzZGxaS2hCRkt0d1B0QVJSdU16V1pueFY3?=
 =?utf-8?B?NnhsdWc2R0pKUU5aV0Y5WHhWdVcydjhYeVNTZFM1K1BCbE1TUk85Nm9ISnpv?=
 =?utf-8?B?ZHFpTmNZa2c2cVNqVmx1SVoraGFjcnQxRTcvMHFNdVRUUEpLaW83QTFQZER3?=
 =?utf-8?B?L050QXFpdTJ1b0dhTzZsUzdqMXNaNlo1ZmNJZmxMY0l2V3k0WGlvVFN2bXdF?=
 =?utf-8?B?TlIraVZ4S3NSRUJJY3FJNm96RUpQQ2lXSDBsS2J2REhPdVFjcHppSUIveCt1?=
 =?utf-8?B?UEZvY0puQWRaSE81cFlRMjhBRHA5Z09icFNHOWxMY0JnNDl5TzlqemYxUENI?=
 =?utf-8?B?VDdIenNuVGs0L3JMYlE4R0RWR1V3cCt2RFNpZ1JRSzVuUktLdTB6K25LQldM?=
 =?utf-8?B?ZnB6eVh5RkxjNUh2U2NCVVVjR2h1c0tNSHJnSHF5S1hsNjdGQ2NhcmkvN2lk?=
 =?utf-8?B?aDU0TUZ5LzVGV1FGbW5tbzNBTkROVlpWOTYwaXNVMnF0WEFEaG9VeTlBZHdw?=
 =?utf-8?B?Sml5M1RTbXo0blJYU2tCdVRPOHA0VXVVWFU4d1Q4a0MrWmx2bFloTWpON2c5?=
 =?utf-8?B?b0tQS3pBR3BTbUZIdGxZVzZYTjZmaXBTK2xTZ1RkK0hJSjJRY1EyekpLY25X?=
 =?utf-8?B?T2JaWUlMZFd2dDdHRjV6TDY0SWV6WW1RRUVySTJ2QVBzZVgwbS9FS3NtUWxE?=
 =?utf-8?B?WmhBUnlqbEE2Z2NqaU8walErZlQ2emRPRStKdWRJbmNCdzJ0SWJpRVZ4U3Zh?=
 =?utf-8?B?M3p5MnRGYnFRRjN3bDBWS0k3b3ZKK05rdGZMUFlSNHduNGsyTm51cTJlYnlQ?=
 =?utf-8?B?SWV0dFMrQXJ1dWY3RlYyU1NFeEVPZXBmV3pTdjFZdVBOUXo5LzVrb1pLN3F4?=
 =?utf-8?B?N29rUFNDdDdpM1dQTkNhcUhpMzliWUpFSnc3Y3Y3MjNtN3FLejZoUjF1Njl6?=
 =?utf-8?B?VW5JNkUxRFVBWWRyQjNDTWlHM3RHdVNQd0Y4OEFTY0Y5dmRDUW43L09Vb252?=
 =?utf-8?B?K0ZnaUtUaDhQa3NlaDRRVEZGa0NxOUM1WFZsS0dOZ2tkYkVWU1JUVkIzUjJx?=
 =?utf-8?B?M2VJcGRsaW9qMDBtdnArQ0ZZQTNBdE9BYURucXBkY1RFMEtwL01SbmdRQW5s?=
 =?utf-8?B?VEVjbmRmQ1FZTGRRRFNoWCtSYk5NcVpYUkUybTh0VFVJNUo1dnZOeGVpSU1B?=
 =?utf-8?B?OGdQcm4xejBZNUtZWHFmaGhiRmxNSzNkUkhvTnVkNitXMXpUOHJsd1NNQXlK?=
 =?utf-8?B?NGt1Y3pSQitSeUdvenk0VkFzaHZYd210VmcvNUZTNmtrNUxMdlM0TkFubUZr?=
 =?utf-8?B?M3ZvT1NJS3psbWMzNHlEM1VCcms3Qm9xMU1hbDJhYlI5LzJKSmNTVVp1cGo5?=
 =?utf-8?B?Rllnc3Z2Y0hxTTBicVNoS3RxZGpUQi9tVTNSSTRyUUY1SlpxdkNzc0JtQ3NZ?=
 =?utf-8?B?cllRNm5wV1BSbjdaVGVYK2pBMjBjY1h3ckxvTkVKS3VLeURQUSs0VS81OWdN?=
 =?utf-8?B?NGxiOW5laUNhS0dqOTRGL1ZNRUp2RjV5cXJHTTkwaWZCcWk3ZExyenJtMVRm?=
 =?utf-8?Q?UqajkJGyv0bSbOBDW0fMnBx5JMcCbc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7845.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZmMnhUeUx2TkY2RVYwby92R1Z2OW84NUQ4dTdZRDkwTHZoWEk3QWo4Nmtw?=
 =?utf-8?B?SU1XV1VvZGFZR2JCeE56L3hHZ1p0VlRVVXo4V0J1ZDNGei8xclFyTWNQR05k?=
 =?utf-8?B?TVVmUzFtTWpqV0d3NzRkaUhJeWMwUEFaMlp4Rk5NYS91RTB1di82R1VUcDI1?=
 =?utf-8?B?V1V4QlFiNlpjS2tRSDJSRXZDRjVTSjRyZ29SSHYvM2dhV21zK3hQUWMrazBl?=
 =?utf-8?B?Uk1KNTR6T1I2Z2xDMHpObVBySUFDdU9MYWRZdk9vdi9Qa01DOFFIM2t6NG9C?=
 =?utf-8?B?S1ovSnVjS1htV2dWanYrQXl6MmdQNkJsYWJVY1pqdWt6dXhnNU9DNFdRb3ho?=
 =?utf-8?B?K0N4VVVlUHhYUjU1WG92QmpyZG5nejBhM2ptQmFtdW05SFdneEkxc3MwWDYx?=
 =?utf-8?B?eEJiWGkvSFpHQjVsZFJCaXByWG5vYnNrZ0tpV09veUt5dmJiM0dBbE1RVENv?=
 =?utf-8?B?bTBUTm5wWjBuSHZZMWRtTmRqVS9NVGVwYUFWOWI5ck5hN28wRjk3VjE1QmMv?=
 =?utf-8?B?N0pyallxK0s4aGVEZEtjZkl3dlZtM0R0Z2xUTGYzZDFycmFxZ053QVQrNGhX?=
 =?utf-8?B?ek14cExGTGFQQi9FYmRISDdPNkpHV0tEUE5DT2VYRnMrUHFJZXF5VlZwanMx?=
 =?utf-8?B?VlRZd0hCQjJtajRzKzducGd5MkwvSkFlR25CbUxhU08yV3JBRVZQT04va1Bl?=
 =?utf-8?B?VmY0OGlOMVZYcnJCeWMxVHo5bWhGdTc0VGZwb2plTmdVTmtvRHczWXl6d2hj?=
 =?utf-8?B?Kzh4bzZnTXhsUEljbXNRclZJTnNhUjV0UHE3ZE1lc2FrdjNxNFhReGFhNDN0?=
 =?utf-8?B?ZHRnOWJJeXQzSVZ6cVl4UUl1MEMybkJWMHE2L01ocTkzamZlT0tRTStyNkI5?=
 =?utf-8?B?UnFaOG1hMHRPWDR4bzlzVWc2Tk8vU1ZHTFd0WXhHN1NVeUVLYzIxcFgyMDdE?=
 =?utf-8?B?Nm5XcThoc1MyTWowc0s4aTN5NnBVQk9BYS9yakdmaXdaUCthSml0bVZ2WGh2?=
 =?utf-8?B?NTUvVlNTRXp5QnYxdC9kclpoTzdQeDZLQmxacmlRZlc5OHBZeEg4U2xFRWpG?=
 =?utf-8?B?N2YrYkprckZZZGlIWDhPYW91d0k1Yi9WUklXYnI5TkRCblMxaHU0TGhBTm9X?=
 =?utf-8?B?UGNIYmNnUzVqdFJtaFZmTFZCUzBqRnRuSHZRcEl4TExXWFM1QjJ0K3J4NTJR?=
 =?utf-8?B?bDFRYkppaHhZalhLa3ZkVkY4ZGNFL0NsS3pkNXp1NlJEdjd3SlNmNlljTXhL?=
 =?utf-8?B?MHBNdTZOMWRtTGJmQXAwSkZMTEkyWk0xdzN3SVgwRUFMdkZDVy83RE1VeFdH?=
 =?utf-8?B?TXFwdXR2aTRZOG5XeVFjZ0p5a2QwR1djWlI1WlJYQTBUZ3RzcHJKVE40dzRt?=
 =?utf-8?B?YXRZOXpkclNBRHZHelU0Sy9LOWFFTGZWSjNUc2R1OWJ2VUhMQ1lrQWRjeEdt?=
 =?utf-8?B?VDBiZURlakNLUDRwZ3Fqd0xIR0V5WXRCaysvN0lPd241R3hDaUpZM3hjTzl4?=
 =?utf-8?B?bDRLQTZvQWlrY0RVV1haUlhGODBpNjAxb1VnczhKaU9mL3BlUm9LTFVoeUMy?=
 =?utf-8?B?WWNLQ0VuU1RoLzhyNVBSeVB0MGg3MEVYMkZCdDZKMXFRZFVWNUlvUVdoWnlT?=
 =?utf-8?B?dFYvRVZhMkFxb1JGZU5rVnl2Vlluc0tXYXZxL2xRRFNaQUE2Q2ZTZEgwRHg3?=
 =?utf-8?B?QmlxTFlHTHlONHBsNjNYTnpyMlA2ZkpqMDUrRXFTaVhEdVZtaStGczhDWkNN?=
 =?utf-8?B?S0ZUL2UvalIwNHFjR0c0dFA1WVFUUTFocXR0N3IyQ0QyTU9yeUExYnlGUUxH?=
 =?utf-8?B?aHUxVzNPWmFSRHBtRkp5dXlrM2MzQzMrbk1tMFlYRHI4Uk11SFNxd1hTV0xU?=
 =?utf-8?B?RHpzTExZT1k3V2lNOGxHQzJMYXd1bXU2azNWZ096emZHRFFXMEpVWnN2RW85?=
 =?utf-8?B?VEp1Ukwyc08yT2ZrU1VvdjBxN1RMUGJkdEl1VzZUalNvLzBBYnhOdzNDaFlI?=
 =?utf-8?B?dUszdUozSndDZEY3Y2I1VURMWjhIOWdubU9iNUNvNkkxZ2tYMUFrV3VPc0RQ?=
 =?utf-8?B?R0ZKUFF6YnNKU0VtZUFiY2lyUDVFYUxNbE5pbElxOS9LdDNhcGNlaWFlUFVD?=
 =?utf-8?Q?RMH1fE10srXM7+OuHlFLnPOmt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f547cf-b892-46fe-a8d1-08dde6e88216
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 10:40:44.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWGpoSNJ3AVWNFWPUCqF/gdLKQXxByzKPNk7yluuZySU3PuDOefwECUVKf23ZqEMedmk4ZGrrIin6Kl+Wagu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdvd3Jpc2hhbmthciBNdXRo
dWtyaXNobmFuIDxnbXV0aHVrcmlzaG5AbWFydmVsbC5jb20+DQo+IFNlbnQ6IEZyaWRheSAyOSBB
dWd1c3QgMjAyNSAxMToyMw0KPiBUbzogRmlubiwgRW1tYSA8ZW1tYS5maW5uQGludGVsLmNvbT4N
Cj4gQ2M6IGRldkBkcGRrLm9yZzsgSmksIEthaSA8a2FpLmppQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUkU6IFtFWFRFUk5BTF0gW1BBVENIXSBleGFtcGxlcy9maXBzX3ZhbGlkYXRpb246IGZpeCBk
YW5nbGluZyBwb2ludGVyDQo+IGZvciBTSEEgdGVzdA0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0K
PiA+ID4gPiAgCXJ0ZV9mcmVlKHZlYy5wdC52YWwpOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICsJdmVj
LnB0LnZhbCA9IE5VTEw7DQo+ID4gPg0KPiA+ID4gU2FtZSBjb3VsZCBiZSB0aGUgY2FzZSBmb3Ig
Zmlwc19tY3Rfc2hha2VfdGVzdCBhbHNvLg0KPiA+ID4NCj4gPiBHb29kIGNhdGNoLCBwcm9iYWJs
eSB0aGUgc2FtZSBjb3VsZCBoYXBwZW4gd2l0aCBzaGFrZS4NCj4gPiBJIGN1cnJlbnRseSBkb27i
gJl0IGhhdmUgYSB3YXkgdG8gdGVzdCBzaGFrZSBidXQgSSdtIGhhcHB5IHRvIG1ha2UgdGhlDQo+
ID4gY2hhbmdlIGFzIHBhcnQgb2YgdGhpcyBwYXRjaCBpZiB5b3UgY2FuIHRlc3Q/DQo+ID4NCj4g
RGlkIHlvdSBmaW5kIGFueSBzZWdmYXVsdCBhbmQgc28gZ290IHRvIGtub3cgdGhlIHByb2JsZW0g
PyBJZiBzbywgd2hhdCB3YXMgdGhlDQo+IGNvbW1hbmQgeW91IGV4ZWN1dGVkID8uDQo+IA0KPiBU
aGFua3MsDQo+IEdvd3Jpc2hhbmthcg0KDQpSdW5uaW5nIGZpcHMgc2FtcGxlIGFwcCB3aXRoIGFl
c25pX21iIGFuZCBTSEEgQUNWUCB0ZXN0IHZlY3RvciBmaWxlcy4gQWxzbyBvY2N1cnMgd2l0aCBR
QVQuIA0KLi9kcGRrLWZpcHNfdmFsaWRhdGlvbiAtLXZkZXY9Y3J5cHRvX2Flc25pX21iIC0tIC0t
cmVxLWZpbGUgJEZJUFNfRElSLyRhbGcvcmVxIC0tcnNwLWZpbGUgJEZJUFNfRElSLyRhbGcvcmVz
cF9hZXNuaV9tYiAtLXBhdGgtaXMtZm9sZGVyDQoNCk91dHB1dCBzaG93cyBpbnZhbGlkIG1lbW9y
eSBidWcuDQpFQUw6IERldGVjdGVkIENQVSBsY29yZXM6IDY0DQpFQUw6IERldGVjdGVkIE5VTUEg
bm9kZXM6IDINCkVBTDogRGV0ZWN0ZWQgc3RhdGljIGxpbmthZ2Ugb2YgRFBESw0KRUFMOiBNdWx0
aS1wcm9jZXNzIHNvY2tldCAvdmFyL3J1bi9kcGRrL3J0ZS9tcF9zb2NrZXQNCkVBTDogU2VsZWN0
ZWQgSU9WQSBtb2RlICdWQScNCkVBTDogVkZJTyBzdXBwb3J0IGluaXRpYWxpemVkDQpFQUw6IFVz
aW5nIElPTU1VIHR5cGUgMSAoVHlwZSAxKQ0KQ1JZUFRPREVWOiBDcmVhdGluZyBjcnlwdG9kZXYg
Y3J5cHRvX2Flc25pX21iDQpDUllQVE9ERVY6IEluaXRpYWxpc2F0aW9uIHBhcmFtZXRlcnMgLSBu
YW1lOiBjcnlwdG9fYWVzbmlfbWIsc29ja2V0IGlkOiAwLCBtYXggcXVldWUgcGFpcnM6IDgNCklQ
U0VDX01COiBpcHNlY19tYl9jcmVhdGUoKSBsaW5lIDE2ODogSVBTZWMgTXVsdGktYnVmZmVyIGxp
YnJhcnkgdmVyc2lvbiB1c2VkOiAyLjAuMA0KRUFMOiBFcnJvcjogSW52YWxpZCBtZW1vcnkNCg0K
U0hBS0UgaXMgbm90IHN1cHBvcnRlZCBieSB0aGVzZSBoZW5jZSBJIGRpZCBub3QgY2F0Y2ggaXQu
DQoNClRoYW5rcywgDQpFbW1hDQo=
