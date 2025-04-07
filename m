Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924DEC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF28940A8A;
	Mon,  7 Apr 2025 17:31:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5821940A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039889; x=1775575889;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7y3JBpXYfa3DDWd708AAoVJhdod933jkj+Dpimbdv/8=;
 b=GUkFhdcg8gZB0ZLwZy78hm5G5CAgb43QSSJLrrIE1QMLrdkTnvOVOu3j
 Ukm/DLjszQK5iFwbPVs3beLFLGe4hYopXIoQj2cOAEUDrQGVcUMvFXHvr
 2wHjoyMGw/UuAu5ZCwwX/wDASfwkOq9KJ9NCrdIui6FMIfUz6lv35KNIk
 AFkBSHhnNe90O504oX4bqFv0Mg6XABVr2O+vI3y2YKkmXyPiftTvwckWa
 RoFuNDfgMu+M6sbUoHuX8tvFnBay1mTk3ZdCNCWfsK83TLxNfTbY1OhmP
 WoF1TJxT65XyWAHcE5VzE4T78wjyGF9rl8wcaOpA4d/gtT64KvBLixG9G Q==;
X-CSE-ConnectionGUID: OiyJprxJT0WAfUZugQxlRw==
X-CSE-MsgGUID: RHJPcXMLScm2W6i0mSN3Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56095349"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="56095349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:31:28 -0700
X-CSE-ConnectionGUID: s70luRt/SF+/sQUGbxZvgQ==
X-CSE-MsgGUID: KlKqassETUuED4+hXoaJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="133192293"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:31:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 08:31:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 08:31:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 08:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwhn+LzGZnKk/VCucAqR+FP3nPLEFFyadpKSjdnVnhPZnQByJZ211k1Fk1IH2DyghIbh6A/v4FRmDZvTEsrw5x5FohM/Ca3K1SSP/SsWtaFvSDanwe+ts9aZOXpticvNVXYaVem/Iwa8OXTmgsTRGbSmtWjpc0KGpOCEc7qNs0dTADKY4rzt76tVBbqm279wrxV5wWkPpFk2Ut9letLyrZkD7PQ2JQ34IXoYNX4WoJcAg9w2Gz8nj3yeC9CIxkiJ0UiaQ7gVUjkJamFEa8Pzrb9MCyMOuhM1Xr5chwsaEuddSbrNKSjWORgjCjaixWdXjYtWZCCJ8ETRgG9FOe0mVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNFbuOdb07uR3uBk6HahJIJK3bAWrUjKesBtEh46QM4=;
 b=DxRtMwUXDOIrLRIVaN6Aj/FP783SWZGbBx7Ca/CuVZnlcZtR/A2fx01jc11ddAtIgpOk10UE7TrVGyRBNUfPu69jbzITCpR0EHTGVWfeYCWwsvPhX1ixzMc2ZDENM3D91RNSJ8Lfhi02dYVCJT3dmqU6Y2MCJ44nO2O83c2QhISD7IMvlq44Xq6OeFz7WX9mPqLx6vNorKG2a5ohq1id2DLeWm8CxDYCCKFhTKJMnfz2kUaL7Yy+I2/ikKuvn1mctXXIKSeGfyF2Xf9Z9IZMOQhsqqm9w3GcDxL2gBt8W/BX3iwMQZonB9o+bynqWRZchfldNt4tfIyiVozP8njdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 15:31:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:31:23 +0000
Date: Mon, 7 Apr 2025 16:31:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
Message-ID: <Z_Pvxr5ozfjXI692@bricha3-mobl1.ger.corp.intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <CAJFAV8w3uth7PNR8e9gD0vOhmdd29TdaLtcT0mE2Y2D6eRV9Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w3uth7PNR8e9gD0vOhmdd29TdaLtcT0mE2Y2D6eRV9Ag@mail.gmail.com>
X-ClientProxiedBy: DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: c176102e-03eb-4e62-c0e1-08dd75e940c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzBZQmxIeDNaNDc0ZTN0aVJLUWJtR1BDeEpZbkVjeHVncnBwNHlzNm1zK0Ur?=
 =?utf-8?B?SmpLWEd1MGhma2ZrVDJRa1FXam9IM01KK0c3Rm0xUzFMYlcvRkJ3K3FkNUJM?=
 =?utf-8?B?N2s3dzRnT3l1ckFxU1FDZ2hQMGVERVIySlN2R2wyUlZjNHhCVlZodTNMQnU4?=
 =?utf-8?B?SXZncTNDbk5JTUExajFVbldGTVBSRjNlSURFOXhVM0gzd1ZYaHRCNmdabnhZ?=
 =?utf-8?B?dUZnWnorR3VaNWZOdTR1Z0piNVlBR1MwRDc0M0hvQkpucU41S0g0UTFKSzZC?=
 =?utf-8?B?VWtvZk9GYW9CMmFNOWlvMnVlVEIyU3NxdzQvL3I1RDJZblhVY0t1MHgzaXd2?=
 =?utf-8?B?YnRVa3htNXo3UDJSTDk5Nmdoczc0RmJPQkJkU3NlOGJ5OE0zbEh6K3NnODZv?=
 =?utf-8?B?YTlBMy9aRUxTRnJzT1BVTXhkZkhNbzZjSWNxMm5SbFRLcnVJVmYza09ZeHF1?=
 =?utf-8?B?WWUxdEpaT1BHdHd0a25jbG9NczkrbjJYNGJYdVoreU9ucE0zQlk5NjhqeGlx?=
 =?utf-8?B?L2I1N283emwyclJyZ1Z6bDNOaUFHbTRlVitpdFBwWnM4VjluTkFoL3BmaDJD?=
 =?utf-8?B?Tnk4aWpRczhMUURmT1I0akdLTGJySXhiZlBybjB6MGl2emI4K2ozT1h2ZXJt?=
 =?utf-8?B?WnE0T01LM3hrNlN0R2hKM0VWVXFsTFFGazVjUThyb3ZybkRONy9HZzR5K0lJ?=
 =?utf-8?B?TmFSWmRnUTNpQlZiRm02MUM5aDVpK0E4dkhrQS9hMW1kaXkvSFZxK3lucFRJ?=
 =?utf-8?B?bjhyYmo4U3pjQ3lrem84bmZMbGdKYWhoME1WSlJFSWNZczcyd0d6RXFxM2lk?=
 =?utf-8?B?dkZBd1ZiMVgyL0VhVGE0N2V2cElwOS9ya2V0NFhlSlNBRlIvc0d1bGVKVE1k?=
 =?utf-8?B?SHdoR1FBbGNscHVhTzVQWnpGYjRkYTUveml5MFlsSUkzVWwzWUo0OVE1NC9P?=
 =?utf-8?B?cXMyZG05VTRIWjdGSnZkd2RCaUNPN0w2VUVzT2xyT3o0aXNIWm1xSXIxdFdG?=
 =?utf-8?B?SFptajlHRm5ZdUpKUVFsOGI2Z21TTGJoUk1TeW1rKzVGdWVUOTVKK1hqK1NH?=
 =?utf-8?B?akQweW9lK3I3N2xMK21OUE5QZ3lCbEVrUkQ5WnYwektGcXVuQzV1T0dqSktO?=
 =?utf-8?B?UUx2WVBodDd3Zkwra0dLTlhPcmV3Ky9GTG8zSm94QlgxaGp4ZXY3bWN0ZER5?=
 =?utf-8?B?VDh6aHRiY0ozZWhBd2JHUTRxVkVTSEJ6YzZSQllNZ0xPSStQa2xzOVBoeEds?=
 =?utf-8?B?Y0VDb3lRUUFxcWVKSUYwZFZFZ2YxVDhCZkkxOVBsTkJqMTBNcno3TjRHSmNP?=
 =?utf-8?B?UHdwZjArNE8vQnlBRWZiQktpTThCelV1ZzVsUG9DUmJoaU0xbTFLVng5TjdV?=
 =?utf-8?B?ZGZMR0F6NEQ5NjM5V29ZNWF0RW9mNGZDSHo0T1pqckdtU0hlU3B3WjZSWWQr?=
 =?utf-8?B?OGJIR3ZmSERSY0VZc1BCQlBrNzZXaGVHS2c2QUNVTHpSMDRuVDZ3blFocXZs?=
 =?utf-8?B?WGpKcSs4R3BCTUVuUEpjZWJaNzdRVzBwTGs1V3N3eVhmWktDRnFnTTNMNkw3?=
 =?utf-8?B?UDhzY084UCtsSEVqTzNIRVMrdGlYYVZKa0dHWFRINlJtTDBiU3hIN3dXZ0M2?=
 =?utf-8?B?Uk9GaVVxa1hPNCtXRU93cXp0Yko3bWI4NUpSZXVCbEZPSDN6UStpbDlnKzhB?=
 =?utf-8?B?UlV3b1BmUzNuNnU0M2ZPNjhaZHBjK3kxMytEVzNqSjNFbWM1Zm1CUk13OW5E?=
 =?utf-8?B?cGdNelV0a3ZwbDZ5T3lwWEt1K3JJZU9JNFA3NG9PK1pxWGRHV0ZaMzBiL3V3?=
 =?utf-8?B?R2lOallsbm1scmRLSHdKN1RhVHN4a1I2WnRqOWRPZkpTeng5S1pzSGZXQXlC?=
 =?utf-8?B?VVQyUGZVUFJtN0VCUTY2ZDhzcDM1bUhicjFZZ0gvZE12WmY3Q0FmWDVwdEFo?=
 =?utf-8?Q?7TLLvV2G+v0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxjWG1RRE5XVVJOUXlncDBuMTl6VDA0b3FwZTJ2eis3ZkZaNVRiQitMZTk1?=
 =?utf-8?B?Y1ZWY2dvVUg0TFNVOGlrRFRyOTFkdHhLcE1xOEdPMXV6cnBHOEwvakhCNzBy?=
 =?utf-8?B?WUZ4K0JSU0N0VnNIQ0g4b1JhNm9kMmdSMllUUWNUZ1NPaCtkVHYzRGdud21Z?=
 =?utf-8?B?emN3V28xaWkvR1dwb05jOHJ5TlZrV2Fkb2FtT1RzVHErN0VXNVFDRk12Tlp1?=
 =?utf-8?B?b090dzlZQzB4VmMwdG9Pd3BTV2pEQkVadCtERGhkTTR1Z0oyelc0TkQ4bGVi?=
 =?utf-8?B?MExsSkRIcFQxTitPZjVsNjlRQ2Q3ckJTOTJGbnVoWVNuaGZiSldOZitSWFVE?=
 =?utf-8?B?NmpUN2hkVzVna0ZYak8vUzY3cTU0ZWhYeUVDSk9UcFN0NFdJUUZpN3R0VjFC?=
 =?utf-8?B?OGdyWVZUQkQ1ZFRBUVZLSFhlNis2aTA5TVQ1RXdISjhaa2FkM1M1MDYyNDRE?=
 =?utf-8?B?Y3pCVTRRUytzZ2YwazdpMHZ2dDhGT2xZVVJ5cG9ibTVvTmtOdWZKSjhLajlr?=
 =?utf-8?B?Z21wb3UvWUNGOEIrckw5eXFOQ3hQd1ZhVlhsUzVRS3RBcGdkZUxndWhXQklY?=
 =?utf-8?B?c2lPUGYzUnNPUUh0TzVGRW1rc2kveXFWM2hOOGVpSEVIZThKQlhvelMzcVBB?=
 =?utf-8?B?cXRYTS9Pc2FQOUVLVkdWaUNCSWFLQXBXbGcwV1hsRzVOUTdEd291bXZJc1Vz?=
 =?utf-8?B?YThDV3VDbWdlSXBORVFvbFJZUFdVa1BtQTZvUUcxMC84TUdCQ1lncndjemlW?=
 =?utf-8?B?ODBvclBVYzF0Nk94NUhBQ2FpS3huRHQ4MEpOWTNLaHgrOXVsQzJubnY2eVBS?=
 =?utf-8?B?TmVKbjYrNnBtTnoxekFwblRhd2llT0FXMjZKOWpGVE9TanA0UWJmMDJGVXZ2?=
 =?utf-8?B?dG54c01ER1VqS05WZm1Ka2ovZ2F4MjQ2OTVML2JWVUcxSjZ6blZzM2RzT0d6?=
 =?utf-8?B?OXVPK0p2SFpDOVlPUFBDYS9hdHhZREYzNEdNQkUvNGg2c3l4NzhGMkxoQzFt?=
 =?utf-8?B?KzgzMStjSm1ZekZ0eU5GaWtaWnVURmNYUEhRSHV5TU1CQkpqK0FNcFpUME5u?=
 =?utf-8?B?cHhGUHhEbU5GcXRHZmU2NHZaL0J6dTdmSHE1aUZFcjVzVUcyR3BOZTVDNTQr?=
 =?utf-8?B?blVrRzZ5dlBLOVJRRmlQMVJJc3VjMDVsUDcwNUJDR05pbm9ueHN4WlptRDl0?=
 =?utf-8?B?ZWlQczdyVFBQVVpxQmJEVWkwSi9qbEhmTzJRbG4rWkVNL25DWWVVRHAzeEEy?=
 =?utf-8?B?Zmc4aEF0cTFKbDUyQm10OFBKUUdyYUh3enJKK2dSOFNxaE0wTUhNZHIxaUpY?=
 =?utf-8?B?b0JHbTlpTmdwUjl3ZDIxanhiejd5VmxoSGd2Yk9CM25kdlpWS1lKYmFSZG1m?=
 =?utf-8?B?eGg3VHBzSlpSaEdNMWlHdkJBMy81REYvOUVLaGhBNXFUcldsSHNyblZiVXhP?=
 =?utf-8?B?bE55WTQyMHN4NElnMjZSdG1raGsxNDVpN2kybVlPTzBKUzhNTHh4MXFIcy9j?=
 =?utf-8?B?OGQrSVIySU8vZFgvTjdzbk1JMkpQSll1blBiNmU2MWNpTEEydnp5V0d4NU5W?=
 =?utf-8?B?dVVjM0pzQzc3a1NRNkZ0UjlRQjBFa2Q4akVmNDB4TDMrZFUrSXBNMEtURE9Y?=
 =?utf-8?B?bG91QlVYeTVlWGtUS25qNDBvdUFmNUQ1TjdOZWp2K2w1MGJaMnJHKzByVnpN?=
 =?utf-8?B?Tk1kQS9PaFFJQ0kvZVhLbkJRK09RKzdxQldxcjlRN25DTTg5RWN6d2FXMFdO?=
 =?utf-8?B?c3p0MEFIeFRFbDZISVZuR3d3WTRBZ3h6UEM0NXdySDkxanZnK3EzYlpFL3I3?=
 =?utf-8?B?UEFITEVEMUNEcFNCVDZLR0pxNmMyQ0lPKzZ2Rng4T2UvaWRsYjdrK2RDUE50?=
 =?utf-8?B?TFFsOE11RE9MZ3dnOWtNUzVXbFJ6UTNqMmh1bUdwcmsrOHA2S3RWS014MnZz?=
 =?utf-8?B?UnJTcUZ2VWttWml6cXNkc0RsWWhZSW41UUR6SXNzWStpWjg2ams1UW16MEcr?=
 =?utf-8?B?OUtEZytHTW1ST0F4ZEplMUFRVE9KRE9lVUx0eDJYNG5NaWpFeXVHeDRvZkFa?=
 =?utf-8?B?RUNyMU5mTTNEdllCTDlQTlY4R2ZVdlJ2ZjVXTjR3S2I4YmRrQVVGNUpIUU8x?=
 =?utf-8?B?UVBmem9EK2p5VVd1bTQzNUpiNE10dDBBRGtTSmpiOFRVakxPcmoxVHhPeDRK?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c176102e-03eb-4e62-c0e1-08dd75e940c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:31:23.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08A+rUoOpI5I5moekZF3n3vMSOkNuQz4yhgnT3u3G/+/Aah9wFymSuloTm3CMdSQhVIxbPBsZdY7EqBlKv07vjSKQhrTeX1ovjWoGueOxxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
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

On Wed, Apr 02, 2025 at 03:08:45PM +0200, David Marchand wrote:
> On Mon, Mar 31, 2025 at 6:10 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Many DPDK drivers use the same pattern for base code handling, having
> > a meson.build file in the base code directory which optionally defines
> > some custom cflags for the base code build, then builds the code as a
> > static library and extracts the objects from it. (The reason behind this
> > is that, in meson, cflags apply per-object, so we need to have a
> > separate build object for the base code to use custom flags)
> >
> > This patchset deduplicates this logic by putting it into the
> > drivers/meson.build file, and allowing individual drivers to then just
> > specify values for "base_sources" and "base_cflags".
> 
> In general, this series lgtm.
> 
> > Depends-on: Series-34946 ("net/intel: clean up base code build")
> 
> This dependency is a bit problematic, as this series is already merged
> in next-net-intel.
> There will be some merge conflict to resolve.
> Instead, it would have been better if next-net-intel relied on this new series.
> 
> 
> After this series, the only remaining special case is for SVE stuff in
> net/hns3 and we would have all source compiling handled by
> drivers/meson.build.
> Do you plan to clean it too?
> 

I took a quick look, and I've done up an RFC based on what I see in the
code[1]. Unfortunately, I have no way to test it, so it would be good if
someone from the Arm side takes the patch and improves it from here.
Hopefully, it's a start point though.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20250407152857.2203839-1-bruce.richardson@intel.com/
