Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB2C83F22
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 01:57:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D183840150;
	Fri, 18 Jul 2025 03:57:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8A4124014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 03:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752803836; x=1784339836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w9uep1Gmsj087fqg78tKgJd0PVOTtYFVFw6dbrATSr8=;
 b=NTT6eTR9EV7gl+Nv8Skse3w6IdpHwadz5sP/W0BbQP1CEzblgG6Qq/UN
 FH86MXyMysRtD/l9lr6J6gB5JW8ZtqKhvJb5NifTymX0tNxALPGmMCdMw
 7hvSQT1EUPK3T8QtZqETBxNOEwCtLpYeC7F+xDicit2EPx60PYWQlMlnV
 fO40tR6E3GpyPcmr0ZlDNDi+JvTX4txKM9B5OOiS39tN0eWcsRKCo6H1R
 ulhOcOvd1qjnDmMd4og1Qd+mIg5W/FAhZHzfHN9dAapph3Sc1DXMzt+GP
 mKCmxIvdMdYXbH2P+Uq5THhpTbyD3Fp8DnJqbO3sD7T0f/evGhe56oGse A==;
X-CSE-ConnectionGUID: pHOpWlQdTRaZFzu0+BU1YA==
X-CSE-MsgGUID: N+vCpihDReGVpUR9ZbVsGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66443355"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="66443355"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 18:57:06 -0700
X-CSE-ConnectionGUID: b7HrtFrATyesFCB7xNq82Q==
X-CSE-MsgGUID: J/4Bh1gcRXWMFW7z0q2F2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="161968975"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 18:57:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 18:57:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 18:57:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 18:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfwPtsT8er9OH9dPFTM7SOPQcl2dnoIVFF7CoDoUL4xTJRuh/qbZ0AUJz6b/xVSKL773geDA+AULEM5OBGRktXz3ROQwr14IXBrr/LktMKSWIVOT4yn0+bVmefGe7TpiLZB8DW0qIyh8CrJaNuMDTQQZKkmEykeuGxuAwUs+QWQl0PObnGaGHmnCCN7am76AAlOBskMquz3uPCJ2djBqx1STpIdRliebCoz82pJEkkakjgJwYqyuwG9tBqq3zegaE//znJgGvBOS3KSgjqjwyk3wlSKTY6oAW30H+Ro4nQvrGHlWgH8kO4K4ovqWzOAXpvkp+ctakN79/1cQHISLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9uep1Gmsj087fqg78tKgJd0PVOTtYFVFw6dbrATSr8=;
 b=XqjoJByp24WDGp2AVMZ8OBEE4OHebxOv0JcmEmiTE9mD1F/5aLEp5pyJ6gRTqf17oD6bCQvrdkky6AUGH6DX6XGJQrWbLRhy3PaQE3y9HgOBWWCy9oIK1YuaSfWXrg3gLhs0X+3LKO4byQcO9ngLfrf6J55fs+Oj3+AtEAKOpTb4v9gNh0J4zT5SOZ0P17UNoI/+zRxcnlflAR668vz+oH8Y9Fd37vZm0Y/UMuOw9DtWB5aqMhBjCV+QzO7On4rJduNf6kSoFeGsbsoKx1x7mCnTPnzmqyM1stx1AYmaAqMRXNBTXYNR7/oQcQ3YztD5VQ5mu/iQ4zvDQE/SATMgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 01:56:58 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 01:56:58 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Baoyuan Li <updoing@sina.com>, "Maxime
 Coquelin" <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: RE: [PATCH] net/virtio: Fix check of threshold for Tx freeing
Thread-Topic: [PATCH] net/virtio: Fix check of threshold for Tx freeing
Thread-Index: AQHb2Q+ZFqrc5zaxvUa1/Mo9mtXbz7Qh+qnQgBSrUwCAALWisA==
Date: Fri, 18 Jul 2025 01:56:57 +0000
Message-ID: <IA0PR11MB83365863FAC1A5B8418E9536FE50A@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
 <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
 <CAEyhmHSoNF=vJE7jqBhOH+eV2ehqUo63g174tnvp-wf+BMPsaA@mail.gmail.com>
In-Reply-To: <CAEyhmHSoNF=vJE7jqBhOH+eV2ehqUo63g174tnvp-wf+BMPsaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|PH0PR11MB5077:EE_
x-ms-office365-filtering-correlation-id: 552483ba-5aec-4719-1e4f-08ddc59e610e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3RyY05Qc0ZZdVEwMWxzQWZRWEkvY1NVenM0NUpLRkdDYllham84d2VTSGVH?=
 =?utf-8?B?M3FLeE45cFYzT2V0T2huQ0ZibTJpejdUalVhQVNKbW11b0tjOEtZQ0FvY2Ja?=
 =?utf-8?B?THEwZnJudmV0N2l5VllrS1VGZUhGTUVFSnU2TWlzN3JRTW1GRW56S1Z0Y0lC?=
 =?utf-8?B?WHlUa1FNMnNHUEt0R2k4VVp4TUZyemI4bGtzSFJrM3AzemV0TzNCbFFLQmZO?=
 =?utf-8?B?WkhnUVh5V2FUdFduZzJ5aVBJRmVoU2svaHVjdEx2b1RIM2Q1SmR4SU56UmZT?=
 =?utf-8?B?ZmorV0tBSyt1VEZzMDZBcXVXaHdLVWw0dlkwVWo5ZnV2NDZ3bVR3cnEyN2M3?=
 =?utf-8?B?ZnEybE1VZVJWaUt6My9OZlNYZHh2OVdxVnZXSkNzNHAyUEtaSm9Zak5HK1Jt?=
 =?utf-8?B?RnlBY1VCeUNuSXVCOU9RcXV1amluMk9lM1lobjEyRFBmTmd6eFdrOVMwbkVB?=
 =?utf-8?B?MFpOR1BrVCttRnpVZ3dtb3gyS1lIbDA4QVVWaXlxS2Z6UUFkVlNUSk1VT2xZ?=
 =?utf-8?B?U0NLRksvZVNjZVpmek9oVjlDdENETnBSTTVQMkFZNHpaQkpPQlZsTWZYam93?=
 =?utf-8?B?N3FhRDFXU2ZsQk1wYXA2c09IcFRzNUNseUhBdWttNHpEbzlUYnlSV01jdFcv?=
 =?utf-8?B?eGVGZGV3OXI0bHNTUkh2SmpXNVljakUwU1U4dm4xYnVyS3k0Wk1yRXJuNlds?=
 =?utf-8?B?Nys4b216RGFwR2gzeTNlRnRsZlZ6bjc0S2Z5QTJYZWF5OFdtMS9RelZzaEhl?=
 =?utf-8?B?d2dyZUkrekh6Zms4Tk96a1dMNEVkZFVuS0oycWZjMUJjWlRmTzhad09WQTFx?=
 =?utf-8?B?NTRDOEhPOXg5aXJpeWJpSWxXVVRJZURCa1dUVFB1TS9TYmJYR1dOKysvZTRm?=
 =?utf-8?B?M1VTbmxaQS9PWjY3Z0kwME9wTGpWcGIwSWp4dnlDSzZjQXhCVm9kdjN5RWlh?=
 =?utf-8?B?Zi94MGxDUy9YWUJLOE1GTzJ6N0pRclMyQk5BYm55Q2p6aW5mQmMreDhTcE9F?=
 =?utf-8?B?U3VXeVQrY3ZMQUNSdThjUE0zNS8ydFNsUjVoMmlydmdCdklJNnowcWZHTXA3?=
 =?utf-8?B?blh5Z2RETEFYM1gxSmhyYThFNEdxUmd4clY2d1lqSHZ2MWN3WE9SSys1eWlE?=
 =?utf-8?B?VktYditkdytHQVRBVDZXeDZxWWJyZVdQc2RucVNJTjE0b21iVXdiQTEyaEVk?=
 =?utf-8?B?WDVPUnZXSE5iU1lmcnl1ZC9rTVd5N2EyS3hNNjUxQmZYZTJvdGJRZWp0ZWJQ?=
 =?utf-8?B?bjZObGdTZFNwTXA2RDlmUjJZbDN0cXNkcC9hakkzbnNhTjV0KzdFemJqS1Nz?=
 =?utf-8?B?UWswZFEyTkJlM0dvT3g3Z3htZzlKTUlid1poa3F2aStLbkZ3MXN0cGtkcDRL?=
 =?utf-8?B?Z0ZTeXF6WVVla0ErSEpQSk1UUnRrOHlUbGQ1dVJtQjl4SHljTUNRbU9xck1F?=
 =?utf-8?B?cHNLTGYzbFZWbWRNOCsrczV6aEN0cFo2MVZ6bkw2bVVmQTlZVEd1bllJaWVz?=
 =?utf-8?B?ZCt2S3dHV2NBQnlIcWF4c3pINnQ2QXZEK2hVWDFTTnN4S1pBYlFJK2Y0b09s?=
 =?utf-8?B?ZE05eHBJSW9CMDZlNmU5c3JDQnJyamJtNFYwZG1tTE40SHFZT0lPRUFTbGZh?=
 =?utf-8?B?ZGlZYUdUcE16bE1oKzRmU3JhSi93aUVxTXh5V3FRZ2g3eEpGTmpDVTcxbUZM?=
 =?utf-8?B?UStoblQrOXIzYU02NGFFbTFTRGZBN2tWVzRZZzYyaVZzaHNmaWNsd1FWeElC?=
 =?utf-8?B?VWp3WVMyclNJZVpYMHBhbldRcDBIUkVYTGVKc1BwWGRJbXgxV3dCWjA3LzRD?=
 =?utf-8?B?K05PdFNYWUNveUlCM25mbTlZMi9zZ0NpM1YwVnU0elJYVkpkTzhNK3ZRREJN?=
 =?utf-8?B?UnRMdHRxa0dFbDVvdi9pYzcyQlF2clVKZ1lwcjZOMWN4QkFMQXpob2U0em5S?=
 =?utf-8?Q?h+SDCk62dBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDYzWng2SG5zYlQrcERNVi93R1hkTE4rOWM1a0VIbVB4RWlCZDlvZGdWRm1q?=
 =?utf-8?B?aVgxTEFCVVgrTkdBZU14MkMzV0cyZ1VTTit0VEl5T2xqMVpnWXpPaU5GRzR1?=
 =?utf-8?B?NEVERVpKT3FSSjhjMXZHL2MxeVJMS3VmcERrWFJmSUZzQmlpVHc2STlROUNF?=
 =?utf-8?B?cFZOUlZBYVdJbHRFck9BSTNzQi9MYnFzTGtQN2VJRlYvRVV3NFdxeVVhN2J1?=
 =?utf-8?B?NERzTUlGYVFhVEVibjM5TUxPcEpQSTROUzN4RnRyMEpNeTloMzkzTTE3SE1M?=
 =?utf-8?B?MGpjNGFtL0FpS0E1V2t2OUsyb1NjUnpWeTZ0ankvRU8zdFpsYmx6c3VZNHdQ?=
 =?utf-8?B?MmY3aFU0SmhoaFZHa0VIRFMzMWpmSDA0c1Zqam1wRFhOWnVRTHhIc3dmdytH?=
 =?utf-8?B?R2hrcU9UWm4vMXl1emRhQ3NYNUVsbGwzeGJ0dDl5NXM2c2NQOU5JaFNvVUcw?=
 =?utf-8?B?Y3lJaTlRQnQxRFh3NDdYSFRURlY4eWVtUlV3ZngzMURabFc5SkwvaHFvZ0dF?=
 =?utf-8?B?eDEvL0FQV2EybEVHdlBRbkpMVTNXYUFWYzZia0Z2aUJSTDNkTlo1RnhGS3py?=
 =?utf-8?B?a2tvK3RCQjAxQmQ0VnpJSDRRMHlMVk9sVEI4M3E2Y1NuUSsrTkpUVTVwdnlI?=
 =?utf-8?B?NUhnVTR0MXZialZrT0JaSE56c0tZejZYSllQODkxY0lKcFlzNklHeTdHM1NH?=
 =?utf-8?B?QUtWNVJZWmpFYmJYOSs3KzM1bnpmc2xjaDBQNUFsNXNna2JoWDNsRWEyYURE?=
 =?utf-8?B?RXpodlVEOG9KVFFNQzhDc0dqTlJJZ2dsMUpNQnl4aHl1bWpTYnQxTkI0am5J?=
 =?utf-8?B?aTIyaGxleGw2dVk0dXVpclRKOFkyeGlyczV2cjArWlB6Ty8yOURDcjV5WmtM?=
 =?utf-8?B?VE51Mi85NnVTU3lWWStmOVpSM3daVU4yeDdVcXAveTRmUDJlVkhHMnBMTEhP?=
 =?utf-8?B?TTVYeE4xODNzekpyQUlxblo0OS80Ti9lOGdxRDhtdW05N2JFK1g5RWh5U0pI?=
 =?utf-8?B?RG4xeC8wRmJMQkxEdEVOKyt3eUNDZEJSZDJ3SFFhWDRIU2U4UWVmQUZKWmRJ?=
 =?utf-8?B?VDgvL09DMk1xbzNPbjlMUVNVcWhFY2J5YXJSR3FQY2I5WjU2VlhVcGlZaS9X?=
 =?utf-8?B?L3VPRHNBeWhob1d4UzdpR1pRdWpWcUI4Zmt1NWVJREFmV0FnclltQnBHVFNN?=
 =?utf-8?B?MlpNTkEwTzZ6bCtWQVdZR3RSQ2kwL1Jza0FNa3psUEl0MVNXSnBIcWgvTzNp?=
 =?utf-8?B?cmJYR0pPSWdSUFdFQ1VGbnE0NVpZNGJSUVk2QmUzbDdFUjB1R3FJeXZ0a0tj?=
 =?utf-8?B?a2hNWXVnUFBtalJFSW1oK29GalBDaFVVVklRYTlLZkxnQnN2bkc1aTRjdmY1?=
 =?utf-8?B?VGdaVEZaL3oxdmtnK1k3YWRYenNmNFprVHk2am5WMUpscnJWSkhEbDdXSTI4?=
 =?utf-8?B?UFB5T0FnUFd0R2QxUXp6ZnArSVJ6WnhZWldsZEVyL3NPQmlIUDBrdVY2VFN4?=
 =?utf-8?B?U1hjaGFRQjQ0L3kveUlLMXM5cUROL09IYTZjTDFTK0JDeGNqYXN0TVVnYzNN?=
 =?utf-8?B?VzloMXZlMUFXYzFWTlVkTWIwNUF0STBTYU1IMCtDL0U3NmFrbmIxTU9tQ3pj?=
 =?utf-8?B?am41ejhWU1QrVUU1VlJnV2tlaGkzV1B2WEZXdlVjbHprY21JdGJlZStmZ1Az?=
 =?utf-8?B?YUZuaTNKaGpxN2Z1UjV3aVR4VUdPQWFSK1UrNzAvYWVYOSs2a1R4RHZXT2N1?=
 =?utf-8?B?N0ZKTGx2M2xPVG8wOEEydHkvYmthcDg1aTgxbjdNendYbThFb3JNYWQ0Tjd6?=
 =?utf-8?B?NDhYdXQyNHFabUZ5TFZoekJnK1Byc05jNXlRVXZUR0lDOUxvUnVlNFcxQlZT?=
 =?utf-8?B?QjIrT05BckljZVVXNkYvSWN3Ym9CbGtwelJZZ0RDb1J6TGxTSHFGSEVOdWU3?=
 =?utf-8?B?UEJjdmhNNUlBN0FOTkZ4K2J4M3ZCbU5BUjNwRXBJck1kd1lFclMrQ3dIeUcy?=
 =?utf-8?B?SXBlSWx0c29kcTU2aTBzVitEcEtwMVF0REgzeHFFN1MvZ2RIbGNEKzdCbHNy?=
 =?utf-8?B?dVQzNkNXdjdBUWVLY0d1RlJNamlsMGZuaDVhOC9adHNtQzZNYmNpUzhvUDRX?=
 =?utf-8?Q?C6KojKrDsw2UqAdo43rKK8/8T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552483ba-5aec-4719-1e4f-08ddc59e610e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 01:56:57.9709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkvRMUlzGrAxycE6CQxaHYIzcypf5CcRrbpKcKmyOkBd3sS1/pPx6wtD3s4H0dA2qx2aIp7W7XPtVVSzq2JRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
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

SGksDQoNCmNkIC9vcHQvdHJleC92My4wMC87Li90LXJleC02NCAtaSAtLWNmZyAvZXRjL3RyZXhf
Y2ZnLnlhbWwgLWMgMTYNCmNwIHN0bC9iZW5jaC5weSBzdGwvanktYmVuY2gucHkNCmNkIC9vcHQv
dHJleC92My4wMC87Li90cmV4LWNvbnNvbGUNCnN0YXJ0IC1mIHN0bC9qeS1iZW5jaC5weSAtLXBv
cnQgMCAtbSAxMDAlIC10IHZtPXJhbmRvbQ0KDQpzdGwvanktYmVuY2gucHkgbW9kaWZ5IGJhc2Vf
cGt0Lg0KICAgIGRlZiBjcmVhdGVfc3RyZWFtIChzZWxmLCBzdGxfZmxvdywgc2l6ZSwgdm0sIHNy
YywgZHN0LCBwcHMgPSAxLCBpc2cgPSAwKToNCiAgICAgICAgIyBDcmVhdGUgYmFzZSBwYWNrZXQg
YW5kIHBhZCBpdCB0byBzaXplDQogICAgICAgICNiYXNlX3BrdCA9IEV0aGVyKCkvSVAoc3JjPXNy
YywgZHN0PWRzdCkvVURQKGRwb3J0PTEyLHNwb3J0PTEwMjUsY2hrc3VtPTApDQogICAgICAgIGJh
c2VfcGt0ID0gRXRoZXIoZHN0PSI0MDphNjpiNzo5NjplNDowMCIpL0lQKHNyYz0iMTkyLjE2OC40
LjEiKS8oIlgiKjE0ODApICANCg0KQmVzdCByZWdhcmRzLA0KWXUgSmlhbmcNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZW5ncWkgQ2hlbiA8aGVuZ3FpLmNoZW5AZ21h
aWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxNywgMjAyNSAxMTowNCBQTQ0KPiBUbzog
SmlhbmcsIFl1WCA8eXV4LmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgQmFv
eXVhbiBMaSA8dXBkb2luZ0BzaW5hLmNvbT47IE1heGltZSBDb3F1ZWxpbg0KPiA8bWF4aW1lLmNv
cXVlbGluQHJlZGhhdC5jb20+OyBDaGVuYm8gWGlhIDxjaGVuYm94QG52aWRpYS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC92aXJ0aW86IEZpeCBjaGVjayBvZiB0aHJlc2hvbGQgZm9y
IFR4IGZyZWVpbmcNCj4gDQo+IEhpIFl1LA0KPiANCj4gT24gRnJpLCBKdWwgNCwgMjAyNSBhdCA3
OjI54oCvUE0gSmlhbmcsIFl1WCA8eXV4LmppYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBIaSBIZW5ncWksDQo+ID4NCj4gPiBDYW4geW91IGhlbHAgdG8gY2hlY2sgdGhlIHRpY2tldDoN
Cj4gaHR0cHM6Ly9idWdzLmRwZGsub3JnL3Nob3dfYnVnLmNnaT9pZD0xNzQ3PyBUaGUgcGVyZiBk
cm9wIGlzIGNhdXNlZCBieQ0KPiB5b3VyIHBhdGNoLiBUaGFua3Mgc28gbXVjaC4NCj4gPg0KPiAN
Cj4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGUgaG93IHRvIHVzZSB0cmV4IGluIHlvdXIgcmVw
cm9kdWNlIHN0ZXBzID8gVGhhbmtzLg0KPiANCj4gQ2hlZXJzLA0KPiAtLS0NCj4gSGVuZ3FpDQo+
IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBZdSBKaWFuZw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSGVuZ3FpIENoZW4gPGhlbmdxaS5jaGVuQGdt
YWlsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSA5LCAyMDI1IDM6MjQgUE0NCj4gPiA+
IFRvOiBkZXZAZHBkay5vcmcNCj4gPiA+IENjOiBIZW5ncWkgQ2hlbiA8aGVuZ3FpLmNoZW5AZ21h
aWwuY29tPjsgQmFveXVhbiBMaQ0KPiA+ID4gPHVwZG9pbmdAc2luYS5jb20+OyBNYXhpbWUgQ29x
dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPjsNCj4gPiA+IENoZW5ibyBYaWEgPGNo
ZW5ib3hAbnZpZGlhLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gbmV0L3ZpcnRpbzogRml4
IGNoZWNrIG9mIHRocmVzaG9sZCBmb3IgVHggZnJlZWluZw0KPiA+ID4NCj4gPiA+IExpa2UgbW9z
dCBkaXJ2ZXJzLCBtYWtlIHRoZSBmYXN0IHBhdGggb2YgdmlydGlvX3htaXRfY2xlYW51cCgpDQo+
ID4gPiBiZWhhdmUgYXMgZGVzY3JpYmVkIGJ5IHRoZSBjb21tZW50cyBvZiBydGVfZXRoX3R4Y29u
Zjo6dHhfZnJlZV90aHJlc2gNCj4gKFswXSk6DQo+ID4gPiAgICAgU3RhcnQgZnJlZWluZyBUeCBi
dWZmZXJzIGlmIHRoZXJlIGFyZQ0KPiA+ID4gICAgIGxlc3MgZnJlZSBkZXNjcmlwdG9ycyB0aGFu
IHRoaXMgdmFsdWUuDQo+ID4gPg0KPiA+ID4gVGhlIHJhdGlvbmFsZSBiZWhpbmQgdGhpcyBjaGFu
Z2UgaXMgdGhhdDoNCj4gPiA+ICAgKiB2cS0+dnFfbmVudHJpZXMgaXMgc2V0IGR1cmluZyBkZXZp
Y2UgcHJvYmUgd2l0aCB0aGUgcXVldWUgc2l6ZSBzcGVjaWZpZWQNCj4gPiA+ICAgICBieSB2aG9z
dCBiYWNrZW5kLCB0aGlzIHZhbHVlIGRvZXMgbm90IHJlZmxlY3QgdGhlIHJlYWwgbmJfdHhfZGVz
Yw0KPiA+ID4gICAqIHRoZSByZWFsIGF2YWlsYWJsZSB0eCBkZXNjIGlzIHNldCB0byB2cS0+dnFf
ZnJlZV9jbnQgdmlhIHRoZSBuYl90eF9kZXNjDQo+ID4gPiAgICAgcGFyYW0gb2YgcnRlX2V0aF90
eF9xdWV1ZV9zZXR1cCgpIEFQSQ0KPiA+ID4gICAqIHNvIGBuYl91c2VkID4gdnEtPnZxX25lbnRy
aWVzIC0gdnEtPnZxX2ZyZWVfdGhyZXNoYCBjb3VsZCBuZXZlciBiZQ0KPiB0cnVlDQo+ID4gPiAg
ICAgaWYgc2F5IG5iX3R4X2Rlc2M9MjA0OCwgdnEtPnZxX25lbnRyaWVzPTQwOTYsIHZxLT52cV9m
cmVlX3RocmVzaD0zMiwNCj4gPiA+ICAgICBzZWUgYnVnIHJlcG9ydCAxNzE2IChbMV0pIGZvciBk
ZXRhaWxzLg0KPiA+ID4NCj4gPiA+IEJ1Z3ppbGxhIElEOiAxNzE2DQo+ID4gPg0KPiA+ID4gICBb
MF06IGh0dHBzOi8vZ2l0aHViLmNvbS9EUERLL2RwZGsvY29tbWl0LzcyNTE0YjVkNTU0Mw0KPiA+
ID4gICBbMV06IGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTcxNg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJhb3l1YW4gTGkgPHVwZG9pbmdAc2luYS5jb20+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBIZW5ncWkgQ2hlbiA8aGVuZ3FpLmNoZW5AZ21haWwuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19yeHR4LmMgfCAyICst
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fcnh0eC5j
DQo+ID4gPiBiL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fcnh0eC5jDQo+ID4gPiBpbmRleCBl
ZGVjZDIwMTFmLi5hYjk3ZjAzZDdkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvL3ZpcnRpb19yeHR4LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9f
cnh0eC5jDQo+ID4gPiBAQCAtMTg3Myw3ICsxODczLDcgQEAgdmlydGlvX3htaXRfcGt0cyh2b2lk
ICp0eF9xdWV1ZSwgc3RydWN0DQo+ID4gPiBydGVfbWJ1ZiAqKnR4X3BrdHMsIHVpbnQxNl90IG5i
X3BrdHMpDQo+ID4gPg0KPiA+ID4gICAgICAgbmJfdXNlZCA9IHZpcnRxdWV1ZV9udXNlZCh2cSk7
DQo+ID4gPg0KPiA+ID4gLSAgICAgaWYgKGxpa2VseShuYl91c2VkID4gdnEtPnZxX25lbnRyaWVz
IC0gdnEtPnZxX2ZyZWVfdGhyZXNoKSkNCj4gPiA+ICsgICAgIGlmIChsaWtlbHkodnEtPnZxX2Zy
ZWVfY250IDwgdnEtPnZxX2ZyZWVfdGhyZXNoKSkNCj4gPiA+ICAgICAgICAgICAgICAgdmlydGlv
X3htaXRfY2xlYW51cCh2cSwgbmJfdXNlZCk7DQo+ID4gPg0KPiA+ID4gICAgICAgZm9yIChuYl90
eCA9IDA7IG5iX3R4IDwgbmJfcGt0czsgbmJfdHgrKykgew0KPiA+ID4gLS0NCj4gPiA+IDIuNDMu
NQ0KPiA+DQo=
