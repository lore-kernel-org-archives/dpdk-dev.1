Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB2C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 07:24:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 683864066A;
	Tue, 20 May 2025 09:24:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2008A402AE;
 Tue, 20 May 2025 09:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747725876; x=1779261876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OuBU6jjd4Vze9hap4FM0kCDQtc6EOSV3fX63/Dajki8=;
 b=MTrZWAId8keK3z1h48z8Ex00KXP2aznSH2+hl4oKj3QpSMtar8uh3hUA
 Of9EM7R6Myt5fl49VMczL0lvYg+LXUyU4+d2hwbTtNwo6yM6gLtsrzJSY
 xcLG5oKJqnLND/W8seJv/UNm7dJhPCGuRd24kWHJ6Tw9AJGG0gKKGzyu8
 RIxNShcHoorPUq3+XYDBZ/rqDH+OTjMfm8Ls+yjuLU1A34XmOCx7IUJku
 Sg5tfdldcaKZMPAMJnShmlJjzifQP2uYqvoIayXITHpnj53Xe4zyGPW9E
 ZzCOtC31A4DxwGXshwn7oD7OaFiMrkIeY21uHEzviAweNiDy7E1riEflI A==;
X-CSE-ConnectionGUID: WsP/UVj5QtGm8LoxZF8wuw==
X-CSE-MsgGUID: x80f4h1dRHGtwoTtxQwSlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37263108"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37263108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 00:24:34 -0700
X-CSE-ConnectionGUID: ybVWYxunQ9CnvNMz2X215A==
X-CSE-MsgGUID: M+4SskHEQjGvWxTWHvKIvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144729173"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 00:24:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 00:24:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 00:24:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 00:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMinza1GgwL2CsRln5wAAfUQpc6B0EYuNbtpYGXudu3PJFBWq/k8lt2wkRcAAHftevR3dhd6WK7+enaP2OMoJH0F73TMMnU1cExPDiGJkvBqoV26wLagMsEfLsXR3+dkgxRp9iFJJjIoiSQFaeHLELDdKOcA4QRKkNHvSmAK+J6BEc9oNwz/4IQN80vKcYCJrwVaCM3DhHrm8BM3vdXseKm/fGpGN5DgZqvpk62jVJsNxOv6XXHV8N6hREuTuce1gj1EW/FLibMOFdmU+geotU36yOn0ku1XCgoRIUSp7yDU7tIXMyXfBQKeWTS0ki+6d897KcsZA+CgNQZPzQOYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuBU6jjd4Vze9hap4FM0kCDQtc6EOSV3fX63/Dajki8=;
 b=USco+xxrB8nOjo/xr4l031fJhrqe5ADgbp4TX73MsK6XVUFcA4pJiSh7xe5OpPMu0DVdLpV1Xf/qf4qBAYwfILMR1ZIEI6kJK9Xxf5zf0VsjgKmg2YgfoxBPeoxe9udTC+y41+BYgcrO/pj3ElyVI7tyXPM9bSFpiBQkiBD/3C4sl3/z1UVFEzqxRU9QU1ixw6wywnJX2OfjQkZqBRAAFBZsFp7dX4WpqcjebRjuV1KRhIJjWPZcP2TO+w9VUOBQ7ksusTKuogLx3QJ+/KCIQPSIEbiHfk6iwQFziiNJJX0UtfhOwrrYi1FMarsB09ETsHwaDGVNpK3JFvmKfQH4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:24:30 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:24:30 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "Deng, KaiwenX" <kaiwenx.deng@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Deng, KaiwenX"
 <kaiwenx.deng@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, Tiwei Bie
 <tiwei.bie@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: RE: [PATCH] net/intel: fix ixgbe get macsec stats
Thread-Topic: [PATCH] net/intel: fix ixgbe get macsec stats
Thread-Index: AQHbySxfTlsTebwhIkGsE1ozkX1QdLPbHfIw
Date: Tue, 20 May 2025 07:24:30 +0000
Message-ID: <MW4PR11MB5912C619E34C0870B878A2339F9FA@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <20250520011316.561890-1-kaiwenx.deng@intel.com>
In-Reply-To: <20250520011316.561890-1-kaiwenx.deng@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|SA2PR11MB4972:EE_
x-ms-office365-filtering-correlation-id: 3baa3c8e-a496-4c75-2810-08dd976f5c52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?KzR2UjNEVGxUYnh5aFg2SWFtOVdVZHV3Qm9IWDJQdTkwODNROG9OZDRjcGZi?=
 =?utf-8?B?blBQVTRMTExKajZWa2VJMWl5RElDYlJiMWgvT0tkZ3VTUUtXaU5QTmVlaEdF?=
 =?utf-8?B?MFJ0VkpPczBCSXhLQy9OYzBqdVJQY083azRMcWRIUVFoTjcvdHdXM29DRGdW?=
 =?utf-8?B?NlhOdWlDSkJuOXNkempHcUZKdnJHZU1VajVyLzVwWlo1UkJzMHVFSGtPWjNK?=
 =?utf-8?B?WWdtZENNOWk0QWJJRUdha2tOckNSVHh1QlZBbjA1bFdjT0pVNExCUFRjNFpN?=
 =?utf-8?B?WThtNEdFdUFiQ2NlcGxNT0pDNHFuRnhBWHU2NDhnNUtsT0xTa2xHaTFmRDA4?=
 =?utf-8?B?bWRJYnpBMXlSTkhqUmFKNXV4NEpzQXFuWlc5bG5QcVF0NTVoVjVKUjhOdmht?=
 =?utf-8?B?RG80dHhSS0xYeWVaTnVzU2l2bVV5MWZsSGN6U3RCVS8wU3dSUXZnSmoySUtZ?=
 =?utf-8?B?WFJ2bXVFOHZCNGpTZ0k2SnJhOW9JbnIzNlNYVy9kTjVMRU83Nzk5OG9tempJ?=
 =?utf-8?B?Ylc4c2J1ZUJrc2w4TlVBWlM5dStNUUdKcVI2N1BoQlR4UHVCT1ZndFZ4NHVo?=
 =?utf-8?B?SGJiRXhNbGg1a2Nrajh3NGVRNGhCeWJ2VURFWU9NQVh6OUtWRGVrc29EMjEr?=
 =?utf-8?B?TDB0cEl5ZnhqRk5WRTNBdjVZK2xhTTUvdFVmeW9YejJvazh0NHBaT1kySUJI?=
 =?utf-8?B?SEFEVGxKRHY3TklGd3orZzMrVnZ2SnJVbG1yRnRQNjN6ZDBDRGNaVVUvV2tR?=
 =?utf-8?B?ZVpyWGc2OVg5THJxelVQcFcrZHF2bDJVSnYxblNGZm0wOFhvbDE3ei8xbUFN?=
 =?utf-8?B?OTE1dVlvUHNXcUs0dzdZMTJQVXJoVnpGZ2dJc0g5b3hYK2xzM0o3aXNtY3ZL?=
 =?utf-8?B?S2xkNmdjZDRJUzM5RWJaWUcvQUZOdXBPUk9RRVJIUmV6ZzZYRE1xQjJsZ3lx?=
 =?utf-8?B?MytvcEdNN0FkV2JKTmpUZ2t4WEtHVWtRSkpLdUZqYSt5VnVLa2V2M21IcTNL?=
 =?utf-8?B?SUZ4eXJzSExKczU5UWkvOEx2ajJSem1LRU5aZFlXbGg1M1FQdXVLYzU1d1lm?=
 =?utf-8?B?U0RtKzl6NDlyWTNSeklqMzBqMHRvQjV2SW83UnQ2VFpaREx6YmdEbi9oSEI0?=
 =?utf-8?B?QTFac0ZVdGdNdVA5NllMek56RGJPN2lHV2UxOTU4N0lyRXhKUUswY0pIbTZv?=
 =?utf-8?B?UmY0N1pPSTdKTWZqS1VLTEFnOGw4ZFpucHFLZDB3cHlzRHR6MWxNeWN0ejZO?=
 =?utf-8?B?RU5veHEyNjl4aC9vWGhpNXhtTXJLWWpvVmVOWE9JV0JwQ0V0Zzh0M1BidUd3?=
 =?utf-8?B?d3pxUW1UdkVZS05BUllGeWZoNmJVTndLOUpjdDhsa2dYNEJ1Ulp0czc4a3Jz?=
 =?utf-8?B?eUJGdjQ4QW5aa29rZW5ZdkRPUlluNmxrQTdiRHNzU1dCNC9GMmN5YWNWbk1o?=
 =?utf-8?B?azN5V1dyM1l6dk9hYlgxNW4xZS9FR21RUGdxRUZxTlNtTWptdlZyZkhCWmc2?=
 =?utf-8?B?cGtRQStOZ3g0dTJ0THp3Uy8zZTRyM3FsREQ0aXpZU0N0TnB6TVZYY3FPcXAz?=
 =?utf-8?B?NGZzRjdpTGVJRmFkUENnekIwd0NrNTByL1dDOWpWUnJ0emtjOVVtWDZvV2NO?=
 =?utf-8?B?dCthdjJlUk40ajBRRWRZSmlLRTFUUVJwNlZMNTZlV01LNFBDbTZ4R3BkY2RN?=
 =?utf-8?B?UzhKSWRLTkZMZnYyOHRqdTE5RzJCdGM4RkhFZGh3c29rYmlCZDh4ajF4bk1l?=
 =?utf-8?B?TmlMRXg3Nkk1OXBQQ1FhQmUrb09tMGJ5OU5ycUJyZWpRajE2dkRlZjRaekt3?=
 =?utf-8?B?cERmdFZZN3JjUm5JLzFFVXgwMm16WVErTjlxb2paU21QUEtxdG5ORkxoL2t3?=
 =?utf-8?B?VkRicTAvd25INEptVGtaUURJZ2JTR3JndEkxRVZ1V1E1elRSa0dSbWZPdkh3?=
 =?utf-8?B?ZVN0T3BHYk5idWNXL2VQY1EvdWpPa0VxL1B3aGJrQUhOcmxJZFJzR2E4TXdY?=
 =?utf-8?Q?2qvBIZC/B57S9uReiUhSGaZUeBdMcA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdFWHVDLzM1MDlYRmxJZWFZM3RYOTRvNVVaNDN0VldwcXF0Y2E2bldFTklq?=
 =?utf-8?B?bUVsSXhmNXdDclFhSlBZZmo4S3puL2dNM0NpalpmVlVDaVVHZTFZZStUaVZw?=
 =?utf-8?B?SXI1ci9SMkFlaGdaUTk2aTZYTUloTWtSNmlOSitXL1c0ZDhSZ0xEOWM4S1VI?=
 =?utf-8?B?elQxcUN6ckhhUWYwV21Yek54alNTOUszanhHZ05FdjhiakQ3MXNnYmxSZ2RI?=
 =?utf-8?B?MDJSUGRXLy9HaXpLNnBTNW82dUJlVzFzR0ZwSXhWWWRZYURjMG5TWHp4aEpG?=
 =?utf-8?B?dWd4Z2ZZOUt3YytuZkh1K3dmdnhkT0U3bGtrVTBNV0gzN1NwMTgyK3doWE0x?=
 =?utf-8?B?V2xYR1NzSFlwSmxHWllxbDlHbldPVzN4dG1QUDczRWtqQlBXTndkWU9qNG8r?=
 =?utf-8?B?TWlIU0VGaExvYWJkdFp2VG1ZNEVhRjZUc0tSc3UvNUU3aUFNOE5LMmFkNXVR?=
 =?utf-8?B?RlV4OGNzT2g0NG0vanNwY0JyOW9WM3E0MUhpM0dxcTlnVUYvNUFJZ3ZJcEhu?=
 =?utf-8?B?THhBd2xqNGdSdHJBMWJ2NVRRakNxaFpDWUhKdi91Zjc4bFFvKzIzbGJ5Z0kx?=
 =?utf-8?B?bVRBQjJvVmR2K0h1Sy9RajF5TmMxbC94V1RyVzlsbEFzRm5Eb2l3cWs0enVX?=
 =?utf-8?B?OXF0WUhmSVpzdXI3ZEZjNE1uOGZLMytEU0Y2Z0p2Smp5VloycDlIamZNVnh5?=
 =?utf-8?B?YmRUK0hZSHphQTAwWFdrTTIyOFhmU3VqVXlYYUR2TDhrTkFLV28xVjhGNEZM?=
 =?utf-8?B?cVlNSTVoM1oyLzA5YmdhL3BzQmR1N21wbW0vMk1qaFZvV1YvU1AycEE5d2NN?=
 =?utf-8?B?VTFsWkRTMVhCTGxCNTl4eHhjaERxc0xiZTVrd2pPZ0tZTng5OXFFODZWUnFl?=
 =?utf-8?B?b3RKNnVTSVBFN1dkeU1UdUEyQ0hBeGxMalpjWHFIMG1Cc3pxVG1xTjBKNTc5?=
 =?utf-8?B?WVFVN0xSenF1Q3E1bnpnZHkyaUg5UGNVT005MWFhR0lnMTQ2eCtmb2svY1Vh?=
 =?utf-8?B?bE5HOUYxOGR3Ry9aMHQvakoxTXJOWFBHNFJyQ3M4VlpLN3dZZWxFZlV2U3hC?=
 =?utf-8?B?VWpoMEw2ZWcyMGdxWFdMT1I2VzNBY04yZm9uaTdQakxrT3ZFOG5VNzMxVTkz?=
 =?utf-8?B?R0dEcTB3V0JIbDZxMVNBamc2RmdKNW1IaEI2NXptTkxvekFsVjFEclVHalR2?=
 =?utf-8?B?UVdIc2w4aUd5U1NiYjd1QUhFdllWU01pWDRRNWEvM29PK3dMbXRML3Jvek1r?=
 =?utf-8?B?NEhTT2x5ckc1SDZqa2VRVVVxYUxpcVZQcDVSVGlrdGJ5eHllQmZsNnozWlAz?=
 =?utf-8?B?cGpYRlRMelNPUThJeDFRTFRpZFBFK0JyOExldDE2d1YvQ2RNaGNFRUhUWHJJ?=
 =?utf-8?B?YkZpZDFIbXVSL3J4eDZ0WW1FQTBiemVCVU42dlFzbmpqSGVESjdaSnRwdzZw?=
 =?utf-8?B?NUQzdEF1UkFDM2FjUXVFQ3pqQ25IVDlERTZ2Qzc1MWc5aUlaeis1OGxRaTg1?=
 =?utf-8?B?emRxWE9UMGc4K2pxUlBhZVRvOEZNRUlVeU5Yb242SERHelF1RmQ4a3F0b1VC?=
 =?utf-8?B?NWR3UU5sQmpJMnNsYzdobDFHYWxEejhrclVFenk3cmlOd0hHNE84b2Jma0t1?=
 =?utf-8?B?Wmp0Qk9ZQ0VYTEhWWmlDeFRQUWk3dGZEL1RZOHMxMGdxcEk5bE4wMG5qa1dn?=
 =?utf-8?B?M1NuQnZLS09EODhEY3ZkeklMSTdWYWhQZ1J5aTdoZUVlVHN2WEh3aWN3QzJS?=
 =?utf-8?B?MG5KRzRCOWxtQVFObU1xdGJvZHFDTWJ3eXRUY2JxSXBlOXIrY0g3Rkg4YzlG?=
 =?utf-8?B?UTJVelpKRXRPV3VsMHVlNnBlbzRMTUtBU29MMUFkWEd3NWhheGd2TUhVeVdi?=
 =?utf-8?B?RWVldmRmVXluOXJRTUJIWXhYQkVwdXJqRDk1VG9JamtJd3lwWnJwZW9XT0pP?=
 =?utf-8?B?NitzNEJNREprbXBzb0FJZ3M5WWxEYTRQc2Z4ckM1bzZoOTZQN1J0K05LSlZ4?=
 =?utf-8?B?UmRFQzlVbkFraGhVbCtHZkVtYURmZEk1U2hIVGpRWHVYcmkycnJjbXpOaDlH?=
 =?utf-8?B?Y1V3cGlEYzVOUE9TMjM5YnQ5T2pqTjhjdU9ldXNxQ21RUjNVTmhxYlhGQVVZ?=
 =?utf-8?Q?XtVHxyfj7t2LTkVCej7MMc7U4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baa3c8e-a496-4c75-2810-08dd976f5c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:24:30.2258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O87iTujNiXy0k7sba7DZ8J0Q/dYoEubO0NnIItFp7hx1OtIbfXLsY9HiVYTE27cguTeNjgBU/4Puf/pTsP7VUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWl3ZW4gRGVuZyA8a2Fpd2Vu
eC5kZW5nQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDIwLCAyMDI1IDk6MTMgQU0N
Cj4gVG86IGRldkBkcGRrLm9yZw0KPiBDYzogc3RhYmxlQGRwZGsub3JnOyBEZW5nLCBLYWl3ZW5Y
IDxrYWl3ZW54LmRlbmdAaW50ZWwuY29tPjsgQnVyYWtvdiwNCj4gQW5hdG9seSA8YW5hdG9seS5i
dXJha292QGludGVsLmNvbT47IE1lZHZlZGtpbiwgVmxhZGltaXINCj4gPHZsYWRpbWlyLm1lZHZl
ZGtpbkBpbnRlbC5jb20+OyBUaXdlaSBCaWUgPHRpd2VpLmJpZUBpbnRlbC5jb20+OyBXZW56aHVv
DQo+IEx1IDx3ZW56aHVvLmx1QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBuZXQvaW50
ZWw6IGZpeCBpeGdiZSBnZXQgbWFjc2VjIHN0YXRzDQo+IA0KPiBUaGUgaXhnYmUgbWFjc2VjIHJl
Z2lzdGVycyBhcmUgbm90IGNsZWFyZWQgb24gcmVhZC4gUmVhZGluZyB0aGUgcmVnaXN0ZXJzIGFu
ZA0KPiB0aGVuIGFjY3VtdWxhdGluZyB0aGUgdmFsdWVzIHdpbGwgY2F1c2UgbWFjc2VjIHN0YXRz
IGVycm9ycy4gRWFjaCB0aW1lIHRoZQ0KPiBkYXRhIGlzIHF1ZXJpZWQgdmlhIHRoZSB0ZXN0cG1k
IGNvbW1hbmQg4oCcc2hvdyBwb3J0IHN0YXRzIHhzdGF0cyBhbGzigJ0sIHRoZQ0KPiBtYWNzZWMg
c3RhdGlzdGljcyBhcmUgaW5jcmVhc2VkLg0KPiANCj4gVGhpcyBjb21taXQgd2lsbCBhZGQgbWFj
c2VjIG9mZnNldCBzdGF0cyB0byByZWNvcmQgaW5pdGlhbCBkYXRhIGFuZCB1cGRhdGUNCj4gbWFj
c2VjIHN0YXRzIGJhc2VkIG9uIG9mZnNldCBzdGF0cy4NCj4gDQo+IEZpeGVzOiBiMzVkMzA5NzEw
ZmUgKCJuZXQvaXhnYmU6IGFkZCBNQUNzZWMgb2ZmbG9hZCIpDQo+IENjOiBzdGFibGVAZHBkay5v
cmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthaXdlbiBEZW5nIDxrYWl3ZW54LmRlbmdAaW50ZWwu
Y29tPg0KPiAtLS0NClRlc3RlZC1ieTogWHUsIEhhaWxpblggPGhhaWxpbngueHVAaW50ZWwuY29t
Pg0K
