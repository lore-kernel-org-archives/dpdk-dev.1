Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3FD1036C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 23:57:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69186402E1;
	Wed, 26 Nov 2025 00:57:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id DA99E402B0
 for <dev@dpdk.org>; Wed, 26 Nov 2025 00:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764115041; x=1795651041;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=YTGlYhMC6w9CC5CtDFX851PAv0TD6sqWj3/WgPEdWb0=;
 b=GNxFSufX/J+HIOUXPmfpRyL+2ka5UBJKNMFcwlXBpU10fdPaZevafg3Y
 ioTZxxYoJPu81HyeqSrxXIxt12a1iA5Dnzcw3kViMwN7AU9WSLpegmc4V
 MHh/B5AL3hXIOkPN/XUezgQuKqBN2RA2olOixIN+MkAlkhsw92zclj2YU
 J7in7ELIurHn3e54uJ+nTAUyq8thVPgA1kSZLedALbtQCPLdrWLqqLRtJ
 8Pq2SwECQLlp7or/i6u2JltT0l7nprGW0ZeUxHEi50Y+gUpbzZZF3NC2y
 w9Ii4z+fAFt5NxGLs102tBk0uXtjKE9jkep92f9dVgCGgau+JOxwd3Mqb g==;
X-CSE-ConnectionGUID: 5N/WzueiS8+FAe+BIaZxLw==
X-CSE-MsgGUID: jKZ6MZ0ES1KlHLBMtSSAcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66090460"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
 d="asc'?scan'208";a="66090460"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 15:57:20 -0800
X-CSE-ConnectionGUID: kOSljB+BSaSMRKP5/1dnUA==
X-CSE-MsgGUID: rFict3/aRdWnqIFwccy5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
 d="asc'?scan'208";a="197261822"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 15:57:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 15:57:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 15:57:19 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 15:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSvopWdDmEA+OEuBH4q5QBdpdXAE+7/qcIdVOA6NmZl1LepDku7wty2df6hcopKMmbcm06lYsadEl9qhNi0FJNu1DVATtV3s5Bv8mRev6DM9n1tQVvJ7cTqMhfGVvF5bl2zCmlRxYKBLyHn6Gh5VRrHcAqzT9P8gwMAHkLJucuck93Nh7R6yFwvBj8L/dOzzdXejfd1dkAh8Hl+VcMP/z1nSjVbQrbU/5+IMtUCPj3VaohKM2URH+ZGCyaM6SZGjecfNfLQR1lvFumffP4Mz/+jFPdO32rbO5vDYhCCPOh+/KcSjVKmldwkBwQfkFH/BI2h/VwiN8rXMedCdhsZwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAIdBm+LSCr0abvdfYMtZXGw/WYPAYwc7qdVqjtgaZo=;
 b=UAXS5gdNBeOW2auLeT6RtzXOVIdb1ZS3nq7Co8GxPtCMJbv2dj6MK6mDtQ8UqkNbB7BMtQOvIrfUcjfMAvl53ITrB3J9w4phkTrGg+qAETs3QEfTfjBzOS4YfaTqq94QlBjMn1r4vfC+yGzg1XXVXJ88NmsLsG6PvDNw3/SbwE5VCaetXfn7w3v/mE/sDd6g1khB/Cj1REVw89sxfgRoRGHMY/Ko45gCEv0YJGBV4/Xrt4ISUQzZQkVf34mvUjy4nwsTmY3HF9WDESzBlNw0GBLA/CwGDb7eqybUnixS8OeT7+KwivnNjhg8jYKJ8j/N70dAJ/5Ko8TH1OYzW1m95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 23:57:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 23:57:11 +0000
Message-ID: <c6635526-a576-44ec-89f1-985779ba0ee0@intel.com>
Date: Tue, 25 Nov 2025 15:57:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: Bruce Richardson <bruce.richardson@intel.com>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Greenwalt, Paul"
 <paul.greenwalt@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Jiale, SongX" <songx.jiale@intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
 <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z45geUZRkSmMI67vkeCqc1sw"
X-ClientProxiedBy: MW4PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:303:b5::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c23c0b-028f-4dd1-48ca-08de2c7e5992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzVldGVGejRJOS85N0luQjE3RzBOUEhJL2RnbFM4SnRKcnFJS3VSSzBpZTBH?=
 =?utf-8?B?eEg4czh4U29aTVFTSEt6ZThCNThCWHliNUJQRTBVMUZMU0dScTV6RGJOY1hR?=
 =?utf-8?B?YnVOQTUvU29hZGpwOGkxUjBEdXpxM2NXUmY1bVJsZ2JMRkJOWkFVYjJvZkhJ?=
 =?utf-8?B?ODZkZDZYZ2xTQWJYZWY4eEZoU2UzSngydnFUdDdJWVgwQXAvdjBHbll6cHU4?=
 =?utf-8?B?WUY5TTl1cmVFREtqNVBCZnlLQVZjWHh3N0tKQ1p3U2szM3UwT0k2ZS9HS2Fl?=
 =?utf-8?B?aHJ1NjNUWkx6cmVvR29TZi93dzdUMnF3V2ZxcFpha2MwQ1RkcFpUK1U1Q04x?=
 =?utf-8?B?MTYwbDZ5TjFJcFZsME02bm8xUi9PbFZEWThqMWU2T09VU0VzKzFIVlJBVUhJ?=
 =?utf-8?B?UmhNRU5wWS9jN2hsMVpPWFFaRER3N2tXTVhJeS81MDJMZ1Vyb0V2dFR1OTd1?=
 =?utf-8?B?UEhiZDJKelh4SklzWTVoaVlqYTNEN0tiQ3dyZlJzczFlN2E1eXFzSHFjR3N3?=
 =?utf-8?B?dVBWUkdhcnMxQ0NmM0xiMWdlZFlhMHV1ZENpNXAxdFkraHVWTjIrODZaTzRa?=
 =?utf-8?B?MnBPTDRpb0E3enNsbWRnZGEwQlo0NjN4SEx1QlFOdWU4RlZWenB5SldySi9Z?=
 =?utf-8?B?T1pPZ2ltTm9iQ1FmalJtV3hqNkpPZ1NwVFJ0KzIrMTA3RU9EY2JPZ20vTENn?=
 =?utf-8?B?Y05KWXRiSlNEbDFZTFU3dnlRdkJrcUNidFlZVXNkdG9vMEhHS2VLS1o3bDU1?=
 =?utf-8?B?dEZsSTVCTmZ0OGROUkxvQ2VnWGJXclg2UUd5bngrWDhsVXpTYm5nZ3NrSG5Y?=
 =?utf-8?B?VjMwRy8vOXg1RFhCODBFOFZ3WkhjODVRclhQSklNTmtKbUlaMEtlWjhxajJE?=
 =?utf-8?B?YXFPQXVvT2ZwSTloVGFWSVQ1RGtqRzc3eUk5L3NweFpVVDN6NzZiVVFpYUpo?=
 =?utf-8?B?TjRqcFdUT3ZBMWVGU1oydmZRZWtrOEtvY3Zta2t0ZEpBOEdpclFNMVJzbEtu?=
 =?utf-8?B?ZjJ4Z2NsenBpZGdWcEEwWDNCSGE1eExueXkwb3VXbGg5d2dQZmZTMWtMSFcv?=
 =?utf-8?B?RkxWclNYS2ltcjBweCtqdVRiN2Q2eERpMVkyK2xqZ24rTVFWdEprUzF3MjQv?=
 =?utf-8?B?RHZxRFBSbUlhQ1V5VndkVWllNkQyeDVPOURPZXBXYm1meUphYkwyS1RUbzhQ?=
 =?utf-8?B?akZyS1ZmNW9sWHd5RWVGZlZoem4zbGVEL2ZKNEdoWmdrUlRnS1EzT3cvUjNY?=
 =?utf-8?B?MVEwclRRVFJuWjdPK0VtbVNEMXZvSDhid3JJczZySC9UakFOT3dnMjZNUUli?=
 =?utf-8?B?Y0gxVFBiRHRNU1NVYU1EUXI0bVRPS1ZFTjh1Yzdhb216S0N3YW5tV2o5M2JC?=
 =?utf-8?B?dEJLdThvTTdMV0R2K0gxb2FwNjBXSnovMXVDT2VTWGJOTVdGU1B0OUxCM3JT?=
 =?utf-8?B?djhmWDNud3hLVWpsb2QvMVlVSlU1SENvWXl0bVJQZjhYNytJZGlqSEJDU0Np?=
 =?utf-8?B?bEJjbXM1ZEl4bFpqczdKcWZZMjIvQlc1Q0lXaUdmMFJrSUdwWi9EUG9RMks5?=
 =?utf-8?B?SHdmK3VsL3hSOWJTdE1OaGZzd042NGhqT1dOOE5pbWowZE5RSDFHRW41aEVz?=
 =?utf-8?B?UFQ5YWdXdkNtejdnRUkzQWJ3N0QxUGpPOUJZdmRYUUcyallHdkl5Q0xJVytG?=
 =?utf-8?B?bDBoa2dMSXNPQjVJYkoxckdDZkJBZEY5cU0wYlhWcmFsWThwc1VhSytzUXkv?=
 =?utf-8?B?cUE4S3NiZ0REaGc1dzViS2FNOGEvSDdHSlgyVzFUYzFSaU5TZ2ltckYxYVN0?=
 =?utf-8?B?ekZIRFlhbVQ4eTQ5N0dIdW1xZ1hPckRnZUFOVmFRR01qb04ySVJ2eGk2ZkJh?=
 =?utf-8?B?S0lrcFZsSTBPTmRCOTF6K3JWejN5ZktUTWRmUHhlbi9kQTluNUdyLy9Kc1pW?=
 =?utf-8?Q?hELGAPcBvKnTyRaJa02/CAaz1XL03lIc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5paDVGNng5VFZwQUxzVjJ0SlBCTHhEa3lYUFZjUkxmL0ZPakhrYlhtWElV?=
 =?utf-8?B?K2JOOHk3S28venRXQlA3cmViRUIxZ3BLbWIvRkFRZ3RuUzVhVi9nYUUyN0V2?=
 =?utf-8?B?WTBKMlQ4U2N3R09IQmkrdjVXZk9RVGV1aXNRSTdjd3QzZ3Y2cmdWeDBES0Jq?=
 =?utf-8?B?cDlDb1RrSTRobnFUS01kV1hxSmZVeGtPREppbS9hLzYyOFRzaE5iNXg1cFZz?=
 =?utf-8?B?ZG53cnZRQUVuc1dxMURGUXdDZE5HZHFsMVM3M2RXQnVTUFZMOG1Bby9lZWly?=
 =?utf-8?B?aUVIc0ZyUlhLTk1TSkllV0x5TU0wNFBwWjFrYU1wUnlkaFcrTGxPOHQ1MTJC?=
 =?utf-8?B?YVhIbUdMNysyWkRMQVYwMzh1QTM3VjJJak1IL1dZRnlYK0dqTE5TRllVdFpl?=
 =?utf-8?B?anVJK0RqL0tvdXdoQlBCTnR3WWVKRWlyMlYreFdNRlVhdExlZGswVVdXRHhJ?=
 =?utf-8?B?VTYvUTZaRHNSTTR1dk9lVG1CKzExcmtuakhBc0dYZTltWUJsWWZsVDBmY3l5?=
 =?utf-8?B?c1NkamI0UWdMVkJtbHVyMGgvOXFmcks1TE93aFRpUFFvTmFmZ0hFNDhmZEp0?=
 =?utf-8?B?anVUNWV3cENsWEU0d05Oam1mYVBORjhua3dVOFpKNlNKSnNzYjdIWTJVV2o4?=
 =?utf-8?B?Q292Zm4ya0VlVjZ5VnIxYllqK1o4ZldEb1dVZFdlWURPTzNyTC9iUkI1eTJZ?=
 =?utf-8?B?UjVob0t6YWZCSm82OE9aYS9FQy8zR21KQ1c2WmFNWXJKN0d4c3BJdlhUT1Uv?=
 =?utf-8?B?bng4WlFtZ015N1NHY3pQbittbFQ0bWdaejhtZVBSK2UrQ283Z21IRzMzT0ZU?=
 =?utf-8?B?OVdQdHR5aGNrN0ZzTWlIN2h2VVJ0T2hQc3hFaHVtRkRlcVIwUmNtUHpWU1BB?=
 =?utf-8?B?c2FWSXNEK3l4ODFXd3duYWpZajVLd0xudGNDNk5WL0p2eERqN0dRWVg5UENR?=
 =?utf-8?B?cWEzNVFMSmM1eVZjbXNiSW01MlUxYUJwZkd4UmVialRkTzc1QUtxYnR0Kzds?=
 =?utf-8?B?TnNzVmwzZ1VieWpTZlRmK2Jqb3BtZ3lSK3NBWE4wdmNIcEMwUzJ0aGdJbHZC?=
 =?utf-8?B?SDJMSzU2VVVhQ0F3VUgxVjlYdE1RUmtDdWp4Z055N2ZNb3Q3VXk5c1ZINFNr?=
 =?utf-8?B?STJ6RFZxbk1aWVBsUUlER1BpbTBPV3B3NVdOQTdoMGVZVkJxTStmVzNsUlND?=
 =?utf-8?B?bmZqNG5CTlliblJ6b3NpdWVWSjUwVzd3RkRFZ2h4Qk8wa3dyZEVxaEs0d3Vr?=
 =?utf-8?B?RXZQK2lzeUR5NFB0M0MyVXVsdWtIc3RlbjRPQ2FvV1JQVnlSR29JSXdRSnF5?=
 =?utf-8?B?b1k5MDRBK0tkNGRON2c5SmJOZXRrNHA2MXRlN2JnTUY1eGIwUXJQL1hDZFZE?=
 =?utf-8?B?d2FIanFaVkx6cURoZlp4OXJHQjJ4UGVhOUorNkVvMzUrSFAyVURzcUttb291?=
 =?utf-8?B?UGE2NWt4WVNvVklXWlZDYmFQaVZoSHA2WEprcSt1emMrSmswcGNWMFpYSERZ?=
 =?utf-8?B?UzZMRC82ZzljQlRiWVBJU0FhTnZ0RGZ1c2R0aHFLWUhZN0NTNkZWSzV3N3pm?=
 =?utf-8?B?YzUzT3ZmSkJIb05nNGdxV0pIblVKR3BPUGhUeHU2VG9mRG1QcEYyYStINjFV?=
 =?utf-8?B?Rm9oVFcySnlWR2wySUs5OVBaRS9Ed0hkQktOaEtIWktBbmZvanM5QVVyR0F3?=
 =?utf-8?B?eS82Ykl2QnJDVmxibDVuSzRnY2dVcnpiZVh4RGxFdVBXejdFK3M1S1crTDlY?=
 =?utf-8?B?bEdkbCtURGVOQ0kzK2hKS2dmTi9lQWFJZlZkVTB0T3VEbkVaWmt5Mk44ak9V?=
 =?utf-8?B?NzdFQTliUW1vK091YkdNeFpmUDNIelBsOHhrdzZNV05jSE1Ua3VydGxqb252?=
 =?utf-8?B?REJnRUlhaHdPRXRwbmI2c0NGT3U4M3NmR2Z5Q25NUU5iS3BheFRJYlB6MlJG?=
 =?utf-8?B?OGpSMnlIOGt4dnpYMGJTSjBpbEZkRy9Sb044TEtqR1QyWU5TeVNrdXJNY1Ax?=
 =?utf-8?B?cmpmem9OaGpPVWlRN1hGcnZLKzNmc0NEdjBOd0hrMGh4WCsyeUVKaHdiQ2Qx?=
 =?utf-8?B?d0hzdE1PQUZrdTlQMGxyenFsdHRpOUhhazZsb0o3OUZobi9sRGttVkZ2amdW?=
 =?utf-8?B?MFFHSFVHUXhpWVFhbTYxYTNLbnFlbXpIREdwN2RHVlJDelZFL1UvMlJxUFdZ?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c23c0b-028f-4dd1-48ca-08de2c7e5992
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 23:57:11.7574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRKP9tDV5Bi92+ipSrJiKbeNnLxKU1sLx/UcT1Y2JtFxO1A5PRJw9Bz5nNaR29FOQ+xV6VeZ8zA6sq1nn4Go4mOL4swPmXsDUsa8qExcLWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
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

--------------Z45geUZRkSmMI67vkeCqc1sw
Content-Type: multipart/mixed; boundary="------------xlAYoE9sqBoeYuwa0s5Kz2ah";
 protected-headers="v1"
Message-ID: <c6635526-a576-44ec-89f1-985779ba0ee0@intel.com>
Date: Tue, 25 Nov 2025 15:57:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: Bruce Richardson <bruce.richardson@intel.com>,
 "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Greenwalt, Paul"
 <paul.greenwalt@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Jiale, SongX" <songx.jiale@intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
 <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>

--------------xlAYoE9sqBoeYuwa0s5Kz2ah
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 5:12 AM, Bruce Richardson wrote:
> On Tue, Nov 25, 2025 at 10:30:37AM +0000, Hore, Soumyadeep wrote:
>> Hi Jacob,
>>
>> Currently PTP features are not enabled in DPDK. We only have the Rx ti=
mestamp API in place. Typically the change that you want needs to be impl=
emented in ethdev_ops.timesync_enable(), which is not implemented.
>>
> At this stage we are post final RC for 25.11, so taking this patch woul=
d be
> risky anyway. Let's target 26.03 for this, and then look to  backport t=
o
> 25.11.1
>=20
> Thanks,
> /Bruce

Sure. In that case i think we need to revert the other change that
checked the RX_TIMESTAMP flag as it corrected one issue but caused a
regression in Rx timestamp offload when it *is* functional.

I think its commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx
timestamp support"). That commit without this fix will incorrectly
prevent enabling Rx timestamps.

Thanks,
Jake

--------------xlAYoE9sqBoeYuwa0s5Kz2ah--

--------------Z45geUZRkSmMI67vkeCqc1sw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaSZCVgUDAAAAAAAKCRBqll0+bw8o6HSc
AQCWXSgG6EE1swUtYMIDd6mYhkuQ2M+nIP1leSd4lyCyLwEA4RXhlc/ksH91tNpquFRYAycPeFnG
tVmTEAbI46LBYQo=
=XiH0
-----END PGP SIGNATURE-----

--------------Z45geUZRkSmMI67vkeCqc1sw--
