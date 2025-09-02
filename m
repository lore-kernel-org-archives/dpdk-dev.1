Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85992CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF6F402BD;
	Tue,  2 Sep 2025 12:24:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5B565402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756808683; x=1788344683;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EbAzLK3Lcyc4zsl9/Oq7utKlePdGCWc725KHeq5i4iQ=;
 b=CPcZTQ3ka2myi72wNblSFgEq+zBCQCEeM50BgmCnjC/MM5r3ePIandVC
 1htZJz4rUyKS915oWf2BDTss++vOR5CRtxbZiTE4V3cY9IPAADqjr/kQh
 CpkBMwKZhOwUtt28qNwUgXiCILcRAL1qkVyG11RTXHdfQu9yBwnk8j8ks
 Da3MSZewocoPCuFanH9a7UTTTgJMev7xHPHJ4rHfu/pAwKSSDd4OoP5rq
 t3f8OJePtaUF9MR/4MuE4FUEKFho1vTrayz5UsM+0JCEXQBUN+DRT1hpU
 POYmQEHQf0fuE0/himg3UgsbvdVYnmCuGHgk7i2B97MIUrkeAyKZ9MjOm g==;
X-CSE-ConnectionGUID: QvOiJkvKT029z8Mmk0GM+w==
X-CSE-MsgGUID: qgMB1QeYQbOfNwZ+1Z9RBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="84492693"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="84492693"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:24:41 -0700
X-CSE-ConnectionGUID: dvFwMNUYRd2BAGpkzzvpWQ==
X-CSE-MsgGUID: LBz0RsEqT0O0Z6hkjISmUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="171121311"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:24:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 03:24:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 03:24:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.71)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 03:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRagP1/Ts7DdONvHkF40Je0LmbDIBHhV4HnNEmsFwlTvLllpu8h2Gg5H40TRy/dbyO8Gg/aOcSP6h9OkH8+QbreKPZQWWFVt8xFB5c25R2b9+vAThLh9KbTLcFIXrFo7VJIOwhmX/RXOdPli1gOA0zzyF92bOHQm4ONP6WuTs4PSCUxnOmYeex/lwvWn9uaZ1kWpPNlm5ZDVNa7pRHOhDS/EWcXJ20QcRAbYeXU4J6Xc+GMlMI7U+F/uCgCyLNgz4NzvhP020si4Sgb5+d1JF/hebumebRdfcGAo0moiPXjke5XmUGpwBCpB0zmoY0JGZew1KvXQcURdHaWldtvz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbAzLK3Lcyc4zsl9/Oq7utKlePdGCWc725KHeq5i4iQ=;
 b=qHFEw3W6zSeGXknnK6ibEWT/dVYos28BwBZizxy51hwM6QALt69gck6An39yRRUtaeP6u95UxsVFG62QsGX15ZgU8YqIWtVkWCngsraxX9Rb63zeuiD88JndoE2X/bNAEF1+lqGaFfn3AMXr9HtzqM77ZXMhI1ARisTjzH7shJHzb3JSEFTs2KdXbhqP5ML85mieSu2EPWct12TiD+vcauNlNx3BaEck3Iv34k64FIfC9SouSy1CfP+aASgPLbRSr7d+RWFa8Gv0Vvp95mPR/T1kLF38wheQo/c478F9TPCdmziU7dnO1wBb0Za8xI2lfBoqdGH3sQLrCHsP9L8FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA1PR11MB6807.namprd11.prod.outlook.com
 (2603:10b6:806:24e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 10:24:37 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 10:24:37 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Marchand, David" <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/i40e: fix supported offloads for Rx vector path
Thread-Topic: [PATCH] net/i40e: fix supported offloads for Rx vector path
Thread-Index: AQHcGydDBI9od5tTdEKEwRp0h3iXZbR/iycAgAAliIA=
Date: Tue, 2 Sep 2025 10:24:37 +0000
Message-ID: <DM3PPF7D18F34A194EBD20359A19F59A2ED8E06A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <CAJFAV8woLUsk=B14RKG+cvOrbdXvGdKaTU59m_A-r_Wkb8KZ6g@mail.gmail.com>
In-Reply-To: <CAJFAV8woLUsk=B14RKG+cvOrbdXvGdKaTU59m_A-r_Wkb8KZ6g@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: d1d50f51-9d8b-44c3-6b0c-08ddea0aeb4b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ck1oVm5iM0VDM1M4OGNaS2JNSXZsendIbVNVNGI1WUtxajNYT1lLN05nck8y?=
 =?utf-8?B?N3BuRTJKNUowdTNmbXpLVGJ4UGdxTDVJcE5FV245dmp3OC9LVDdwbkRkRzFt?=
 =?utf-8?B?dU9GbithQ01EUEIrbFY4UzNFaDdzRXdPU21oNFA2OUMvQzJXRVkvb1FzRVNq?=
 =?utf-8?B?dWcwS05UWDRzYlcwR3I4M0FkRVFWbG9IU1ZYWmVmeTA3ZG53MHFPSHVzSGk4?=
 =?utf-8?B?ZjJnNnl5SHMzZU9WOEd3dk9ZNmJHd1Jab2tOaDduKzd5MXczV2h5Ny9OdHAx?=
 =?utf-8?B?SXk3b2cvQml1Vlg2WFY0bk9QZzlJSEVkcXJWWFhZcUpLa2RRUFFlaVY2TEZB?=
 =?utf-8?B?SUJZRGJqWldzMGU5L3ZzNm1IZkE0bU5qbzRhWkUvWmQrc01uTk02d3ZBOEdR?=
 =?utf-8?B?ci8rbWtva0MrVWRBYndwUzIxaFZIMWVyakYvQUdFemJ3MWJIMG9ReHk4QTFP?=
 =?utf-8?B?Zkc2MVA0c01xd2lIeWhiend2dmgyRnhkc0ZCc0IzTG9CUkpMd2RZV2M1dk9F?=
 =?utf-8?B?cHBRbHcydXB0OUFldktOY1FDU2I1K3NKUzl3TzExbUcxU0dLTndjblBvdmJh?=
 =?utf-8?B?cHFQVit4c0JyYVBvSzhFdk5sRU9reG9nVHhTVDY5RUcvUXNBT0I2Nk1KZ203?=
 =?utf-8?B?QnNnSStrMkdwMWtuQ0VoL0N5UEdvUEZQakx4Nm1Hdm83ZjhaSU94aDVYWU0z?=
 =?utf-8?B?NzJGUXFGdHNJd2VOTEdyMkhLcDlUamVEVERicWxwS1M1MXdOamxlTWJMM1g4?=
 =?utf-8?B?SG5ZNmQ3dWpvSWpSNzd5OVZXcXd3L2MxcmhsWVY5c2pvT0hlV0R6QVg0S0Ji?=
 =?utf-8?B?TlZMY2pnL0xZVXhOMGRkUGV5cTZNVGwwRVZXeXdvMzdkV1JheE1qRW5UbWNV?=
 =?utf-8?B?V0pNWXlncURMdkJmTDJZWnpoYTByTTBtZ3B0dWpkcVRYRkFLL2ErUG5lS0dv?=
 =?utf-8?B?RTV6aHBqTVk1V0Q1RWdvNWw5cUV4eTJ3TkJ5dldYZEtBQXppWFptUlVrZ2VM?=
 =?utf-8?B?VTVxM0srbkFkREVGMElQcFRLRERnbnIzZTNWUXpMaXk2K3lYY3YvTWNPeldB?=
 =?utf-8?B?UGdHUWFud3RZQVZlZVlodTFzMys2R1NBdTBiM2tPREVQbWdjSTZjTEl4Y2I3?=
 =?utf-8?B?cllLYy9udWhkdldBVjVQdXZwakErVEova2JFVGcvQXJwcXBmKzU1Smp3M1B0?=
 =?utf-8?B?WDVMRkRuTTJUOXRhekdrdHhHK3lPaVZrVk1IQ0o4VkVzcmZ4R0JWM0oxSnZL?=
 =?utf-8?B?U0hiOHkrWnhSYWlVWGJrUldMVHBwVS9hOFhhOHVjL3kvNXByejNTS0hjM05h?=
 =?utf-8?B?OGNCN0Q5V1haMWNVcDE0QUpLVisyU1NrZmtYVy9Gb1NQUXVGNEJxd1hhNzFu?=
 =?utf-8?B?bnRRWjZMWkN6SkxBMzBXai9wM1RqUFZlQ2lCbFJMV3VnU1dya2dURG01T1pU?=
 =?utf-8?B?cEg1emtTc1NHY3BjYXhwdWs0T3BwQytzeTRpWXRpdWhuQzBWZGlobUg3VnYw?=
 =?utf-8?B?TEMrV0JIYkdzUzM0V3lWUHRpaFQzVXEvQ1VHcXYzSlBYeDNDV0d3SG14blFv?=
 =?utf-8?B?ak5sQktDWU0veTJJZVNPQWVrYWc2UENidTFlZkZPWVFNU3RqcEt4ZjZFcUU0?=
 =?utf-8?B?VWY1S1RIb2EwYm02SmJDa0VpTG1ZTHkraTBxMlRSaWUxYzZGelhOZUtwYXQ3?=
 =?utf-8?B?R1Q3bHB2NEh4aVNCNytnc2pwZStOeFlYL1l0NW9vMWRLenlSQnJmZGFwaWpa?=
 =?utf-8?B?Q2RKU3NOQWZta0lKcWh2K2RQbDFXaWxENmljMk5KZzVlNXhWUFI1U0FSc2hj?=
 =?utf-8?B?aVpjVFRZTHJjWHRYeHN6U2VMUWRuY3BMRjhIcVJNSGxGZWR6SjdZTEh5RnVP?=
 =?utf-8?B?cGhkZW9mUHpkdWExVndOajJxUGE3eUEvVythRW5SV0RocnZGRkY2cGUwUXIv?=
 =?utf-8?B?NFRrRGcwYWlnZjZMc0tFTmlBV2hLbUdEaDF0V2trSXVqUnJzL1FIVzJPenFI?=
 =?utf-8?Q?QoCVaC3zm+lHJw7r0THeVkeTIOuPQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymd3MEtBcnR4MktKQUpHaFdsT2hMc0l2WEZ3ejdGWm5YL1VubHppb0ZNenJQ?=
 =?utf-8?B?MzFocENDUThndTZFK2R3OVQvcE9LUEdJMDBZNWR2SEp1SWJMZUxadno4TUQr?=
 =?utf-8?B?OUZxRDBNcjVYK1IwcnR6SHFvR3huYSt5TXE4NzZ1NkRWNm11YzBma1JHVUsr?=
 =?utf-8?B?QmNueUVXMjFjcXNEZUVEQ0xyMUFWQlErcm5JTXpFUXFWQ2Jpanpia0duSkx0?=
 =?utf-8?B?S2FmcklTWnlkL2lpK09DZDR2bU1qdFlzSStWTFRsQWtENnRyWjFMZFRpUzlQ?=
 =?utf-8?B?WVhkK1R0WTRrVTJqeGZCWnBhV2xwMldqOS9xU3d6c3h2SUZ1Z2JVaHJPelFE?=
 =?utf-8?B?aVd6RGxUNVdWSjlmVnNWa0lnVlYxdmZjWXE5dHBNYmdtMzBkdFc5THQvK0Zj?=
 =?utf-8?B?L01DcFYxYzIvUTdsNk81am14VkJ0WkNPM1gzWFlhRFlzaFYxZkNVblV0MkxT?=
 =?utf-8?B?MzNsM0xZUVBZVHJBSzczbGpIbnlLQWsrRUJCWm9xS0FaZnZmZS9CU0RMb1B6?=
 =?utf-8?B?QXpmanFmZnFMejYwY1V4VkxtaTVGRU8va0xQOUxFSmE1Wkw3OXdYRlAyZVdp?=
 =?utf-8?B?aTh0anc4MGxjZ1ljTnh1bk1KZHVOZU95cG0vVnE2Z2NHQmFvYlpTSGhYNG52?=
 =?utf-8?B?NnRNSWNMWU5Ob0lEZEw5QkhrZEt2YWExejg1b0pBT1FPZ2lFQkNCbk9McDZJ?=
 =?utf-8?B?eVd2cXppaEJldkJ1ZFNtY2lieDhZOXdkOGpXai9nNEtIMkt5L1E4NHRYeFFn?=
 =?utf-8?B?L25VT01CcHJza3Z3YjNrOVh4MzMweTAxTU9pYWQ3VjNCSlBEODJuSHFlRHRH?=
 =?utf-8?B?djl5WkYxQTM4WHNicndaRXB0cTlleGt4dU00NlZSOTZ4MForRituVS9QM2Rl?=
 =?utf-8?B?dzlyRGxZWXRpMkwraGNnU2ZNRk1RTzh0dkZ6ZDV5ajJ6dkpmSFJBbnhuajZY?=
 =?utf-8?B?a2o1NTc0SHE1cVlKZzBFT1puL0pRaVhUd0dTWmdxOWlnWmFFRmovMGFha3Yz?=
 =?utf-8?B?MDl6eHJBS2pkVlpueWtDRklOTWNhZGREMkw3M0E5L01PZndPTTNPNDBaK0Fu?=
 =?utf-8?B?VjVKYkNkQ0NleWowZ1VZQ01zaWN3ZlNWTG0wTUFKT0hJOWp4bnFpSkJoVVFs?=
 =?utf-8?B?dGxHOGkzdklkcWhhODk2MVVzY3NkcDc4elpoVkQ4VXVqQ3FOQ1F1TFIyUGli?=
 =?utf-8?B?dG5zdGJPV1lVT3JDN2h2c1h2SE9WVHJhRG8rVzZ1d1VVdGlaRmlaS3hQRUxZ?=
 =?utf-8?B?c1RZTlFQY2c3eTgwMHFOVnhXUDY5V0s3R1liM2xmNkQ0elBTYWpWMjdzejNP?=
 =?utf-8?B?MHNYTTkyMWJ1SmRxMkFVWWlEa3htY0R4TU5Na0VSN3ZEZXlSYk1sM202S21Y?=
 =?utf-8?B?aUV1elM4bXFucGlVOEEwUzRhMjlERm5nU1FBbjNpVWtjdU5rUGZtVXdyTE9M?=
 =?utf-8?B?U1J3NmQ5L05MU0VWeXRSTkpnSHl2b3N0UnBiV1B6TDVnT2RvZFJCUU55aVVl?=
 =?utf-8?B?c1pUNm13RjlvcVNUYlIzamhheWw0THBneDdHT2VhZEs5Sy9KMkozbnp5UmMr?=
 =?utf-8?B?cEpDUmZVSGNZNWExNWgzUGlzZEFQVE91UkRxVmQvWW1jTHFKWDRwZVlrVkJz?=
 =?utf-8?B?VURlY3ZOU1phWXlxZzFsN0U5TDl3N1drSUJiMkt0bFl6YkJqUjdFY1FlSXhF?=
 =?utf-8?B?WEhTdWdCMWdBaWFtMnl3N1hQdFZTRTRGUkREdVlUNndLVXM2SmxjdEtSQXNv?=
 =?utf-8?B?NW4xUllNRXlFRUN6VmhncUlodEE4ejRDcTVJRHhXazVFSVdFSTMzUW5GNjRC?=
 =?utf-8?B?aHNidVF0N1NiNHJCUmU4WVZ6dVJRWXJoUUh5dkV0dTdYVEVmZG5tYUp0TW14?=
 =?utf-8?B?Vjd6SXY0TTVvUGpyVng4UE9KY0d0cjVpZE9lSXBTNHpNQ1FWUWZiN0c4YjB1?=
 =?utf-8?B?czFTZUxkc3FsV2NlbHZPRFpETm1MTFFzQzdua2pHQlBlUVhCY2kwOUxOZlg1?=
 =?utf-8?B?OGlYYkdJUWVENjZxcDNya1VTTm9lc1RuVFg5UW15SzUvTE5RYjZYSDdDSEZv?=
 =?utf-8?B?d2dZV0lOd05GMHF6emFVaGhLdjFDUlJKbWFYK3dXV0pMYmZoY0pnOEFWVndD?=
 =?utf-8?Q?Y1kFN7oCuSnXG00nSQxDmAWON?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d50f51-9d8b-44c3-6b0c-08ddea0aeb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 10:24:37.4595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3KTJLsJPaNBJO3VwzfVU9S9ORiWLmYFhIU+58J5yJSfjBZoMAJiVR274YIIy1UrQzpF37l1S6v1b1qmFxxglw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvaTQwZTogZml4IHN1cHBvcnRlZCBvZmZsb2FkcyBm
b3IgUnggdmVjdG9yIHBhdGgNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gTW9uLCAxIFNlcHQgMjAy
NSBhdCAxMjowMCwgQ2lhcmEgTG9mdHVzIDxjaWFyYS5sb2Z0dXNAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFRoZSBzZXQgb2Ygc3VwcG9ydGVkIFJ4IG9mZmxvYWRzIGluIHRoZSB2ZWN0b3Ig
cGF0aCBoYWQgYmVlbiBkZWZpbmVkIGFzDQo+ID4gdGhvc2Ugc3VwcG9ydGVkIGJ5IHRoZSBzY2Fs
YXIgcGF0aC4gVGhpcyB3YXMgaW5jb3JyZWN0IHNvIGRlZmluZSBhIG5ldw0KPiA+IGxpc3Qgb2Yg
c3VwcG9ydGVkIG9mZmxvYWRzIGZvciB0aGUgdmVjdG9yIHBhdGguIFRoZSBsaXN0IGlzIHRoZSBz
YW1lDQo+ID4gYXMgdGhlIHNjYWxhciBwYXRoIGV4Y2VwdCBpdCBleGNsdWRlcyB2bGFuIGV4dGVu
ZCBhbmQgcWlucSBzdHJpcC4NCj4gPg0KPiA+IEZpeGVzOiAwNTJhZTMxMTA5MWMgKCJuZXQvaTQw
ZTogdXNlIHRoZSBjb21tb24gUnggcGF0aCBzZWxlY3Rpb24NCj4gaW5mcmFzdHJ1Y3R1cmUiKQ0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2lhcmEgTG9mdHVzIDxjaWFyYS5sb2Z0dXNAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9pbnRlbC9pNDBlL2k0MGVfcnh0eC5oIHwg
MTEgKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pbnRlbC9pNDBl
L2k0MGVfcnh0eC5oDQo+IGIvZHJpdmVycy9uZXQvaW50ZWwvaTQwZS9pNDBlX3J4dHguaA0KPiA+
IGluZGV4IDVkNWQ0ZTA4YjAuLjFmMjEwZGZkZmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvaW50ZWwvaTQwZS9pNDBlX3J4dHguaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2ludGVsL2k0
MGUvaTQwZV9yeHR4LmgNCj4gPiBAQCAtODAsNyArODAsMTYgQEAgZW51bSBpNDBlX2hlYWRlcl9z
cGxpdF9tb2RlIHsNCj4gPiAgICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX1ZMQU5f
RklMVEVSIHwgICAgICAgIFwNCj4gPiAgICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FE
X1JTU19IQVNIKQ0KPiA+DQo+ID4gLSNkZWZpbmUgSTQwRV9SWF9WRUNUT1JfT0ZGTE9BRFMgSTQw
RV9SWF9TQ0FMQVJfT0ZGTE9BRFMNCj4gPiArI2RlZmluZSBJNDBFX1JYX1ZFQ1RPUl9PRkZMT0FE
UyAoICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgUlRFX0VUSF9S
WF9PRkZMT0FEX1ZMQU5fU1RSSVAgfCAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgUlRF
X0VUSF9SWF9PRkZMT0FEX0lQVjRfQ0tTVU0gfCAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAg
ICAgUlRFX0VUSF9SWF9PRkZMT0FEX1VEUF9DS1NVTSB8ICAgICAgICAgIFwNCj4gPiArICAgICAg
ICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX1RDUF9DS1NVTSB8ICAgICAgICAgIFwNCj4gPiAr
ICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX09VVEVSX0lQVjRfQ0tTVU0gfCAgIFwN
Cj4gPiArICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX0tFRVBfQ1JDIHwgICAgICAg
ICAgIFwNCj4gPiArICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX1NDQVRURVIgfCAg
ICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FEX1ZMQU5f
RklMVEVSIHwgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgUlRFX0VUSF9SWF9PRkZMT0FE
X1JTU19IQVNIKQ0KPiANCj4gSSB3YXMgY3VyaW91cyBhYm91dCB0aGlzIGZpeCBzbyBJIGhhdmUg
YmVlbiB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUNCj4gbGlzdCBvZiBzdXBwb3J0ZWQgb2ZmbG9h
ZHMsIGFuZCBJIGhhdmUgYSBmZXcgaW50ZXJyb2dhdGlvbnMuDQo+IA0KPiBIb3cgZG9lcyB0aGlz
IG5ldyBjb2RlIGFydGljdWxhdGUgd2l0aCBmdW5jdGlvbg0KPiBpNDBlX3J4X3ZlY19kZXZfY29u
Zl9jb25kaXRpb25fY2hlY2tfZGVmYXVsdCgpICh0aGF0IHNlZW1zIHRvIGhhdmUgYQ0KPiBidWls
ZCBjaGVjayBvbiBSVEVfTElCUlRFX0lFRUUxNTg4KS4NCj4gVGhpcyBzZWVtcyBsaWtlIHJlZHVu
ZGFudCBsb2dpYyB0byBtZS4NCg0KSGkgRGF2aWQsDQoNCllvdSdyZSByaWdodC4gVGhlcmUgaXMg
c29tZSByZWR1bmRhbnQgbG9naWMgaW4NCmk0MGVfcnhfdmVjX2Rldl9jb25mX2NvbmRpdGlvbl9j
aGVja19kZWZhdWx0IHRoYXQgY2FuIGJlIHJlbW92ZWQuDQpJJ2xsIGluY2x1ZGUgaXRzIHJlbW92
YWwgaW4gdGhlIG5leHQgcmV2aXNpb24uDQoNCj4gDQo+IFNob3VsZCB0aGUgZGV2X2luZm8tPnJ4
X29mZmxvYWRfY2FwYSBmaWVsZCBiZSBmaWxsZWQgd2l0aCB0aGUgY29tbW9uDQo+IHNldCBvZiBm
bGFncyBvZiB0aGUgc2NhbGFyIGhhbmRsZXI/DQoNCkkgdGhpbmsgdGhpcyBjYW4gYmUgZG9uZSwg
YW5kIG1heWJlIGl0IGNhbiBiZSBkb25lIGluIHRoZSBvdGhlciBkcml2ZXJzDQp0aGF0IHVzZSB0
aGUgbmV3IGNvbW1vbiBwYXRoIHNlbGVjdGlvbiBsb2dpYyB0b28uIEknbGwgdGFrZSBhIGxvb2su
DQoNClRoYW5rcywNCkNpYXJhDQoNCj4gDQo+IA0KPiAtLQ0KPiBEYXZpZCBNYXJjaGFuZA0KDQo=
