Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADA606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAwESwvY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32CCF40283;
	Tue, 20 Oct 2026 15:25:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3287340144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 15:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792502733; x=1824038733;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZTdbs5rO0wh+LK3cNex/5vg6kT2o6iGFawF3k9EbbNE=;
 b=hAwESwvYnlTwh3axZk+CSR2ExS+Y0xurGzG2F+B35uhJx27hAKIv1RCB
 oK/4VVOCAXS6iyeLw1EjUxewIgq9mUk4GjghZSEUdRZmxOdLll8PDQ2yS
 rdmAMGXk3ZNdh/PVWaTTmNeSiOHR50kQj0YAiGBswxGCHMw5HIPmNCPV2
 ODZEGcMORKDD2SSKT48gctrX7CTzD1iYPHdEZkHz96ZroS6KAeBBJ8shY
 lgmmhcvwiEkCAAeqZ4MbMU5/ro/SL6rG4uRRL7eU7bZ5SjG7wqHLGAdVz
 1BRWKohXpRhcHsadB9XoPonss8TjKil/wGYGgdt5j2a6LfhASVUte/ahQ w==;
X-CSE-ConnectionGUID: zh4+WmTBR8iTegylrer3Dg==
X-CSE-MsgGUID: ZJ9D4anFTxKoUQq7EqKfpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1238133"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1238133"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:25:32 -0700
X-CSE-ConnectionGUID: DSQro6O+R8inxbYMNrEc4Q==
X-CSE-MsgGUID: PJjT4RQ+SVy9+8rjhaNllw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2850736"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:25:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:25:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 06:25:30 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKN8FUapF7ApQzLO4uPVbDFibvAGryI5CKom0byLeC8lVFT1ZRgUDefJ3LpY9YSLVMxByJ7+vJJJCM6K28w5SjlEurvq6MFGaIVcoCVcPA4zV3LWXyXbyL+HnohtF9WhHwY4tLIY04kWG04+3Y8rKMlYDpnNl3sEvV3eAXxhhveGGYNwE6ILaRb1KyYAQQesv67edMeQro8M4hAbUuYUIhVUbXIMKF//pbgj3aoOp0n+YacPKHSjQKB936CD34rphr6t4B7OBnuASw2qmEHYaFBmCQTr/23as6K/B0gT4cYGilO74rjELJCtVzaOyqqvFybZ+wceD5ZZz00h0e/j3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTdbs5rO0wh+LK3cNex/5vg6kT2o6iGFawF3k9EbbNE=;
 b=Tsp0Y0/aXvp+kFdSgDT86Jovon5UElyzvnLJtBbuyYQzoANNpCMckvCjbgOCm+Etv5mRa3QVhIckwODpBI8lwksgur22oc8pfKTbFe2RGS+gFBX5K7hv15FEVo7uWdfx2Rbl9bcTKn3k9+7VNHNCOsevTGjy7BnQTkhBrtJidmjGCMY+K6HAlJkoLteSaJ4tQEFAk1ZBflmBOKO66AewtVjOqoe1231Mv8xeSf34YtwyCbYBzS89kLIYKi1U9ZSvHDSI0u1PGDZvkZKrTUSh1lObp5BTCQ15XMm54dSBPOBuf4jccyh+qKBhWaSGf1OlYFbloBvbxbGTaQWWPDM+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA1PR11MB8859.namprd11.prod.outlook.com (2603:10b6:806:469::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:25:22 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:25:21 +0000
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
To: David Marchand <david.marchand@redhat.com>, Nitin Upadhyay
 <unitin438@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "maxime@leroys.fr" <maxime@leroys.fr>
Subject: RE: [DPDK/core Bug 1970] fib: trie leaks a tbl8 group on failed insert
Thread-Topic: [DPDK/core Bug 1970] fib: trie leaks a tbl8 group on failed
 insert
Thread-Index: AQHdXWH7B0Ih8eKEVEqWOEwt1uI25rcAKNwAgAZJDZA=
Date: Tue, 20 Oct 2026 13:25:21 +0000
Message-ID: <BL0PR11MB2993E9A0FD0AC921E0A4F0D196672@BL0PR11MB2993.namprd11.prod.outlook.com>
References: <CALUB8OP7m2zbN7YFV+_+BNHxJwrv+meCqaJPZSzynHnqcrpKCg@mail.gmail.com>
 <CAJFAV8zGVhiP3z1Y1c+ZexbzX4fvbNHd+_yKiMp9hNbTFu0PSg@mail.gmail.com>
In-Reply-To: <CAJFAV8zGVhiP3z1Y1c+ZexbzX4fvbNHd+_yKiMp9hNbTFu0PSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2993:EE_|SA1PR11MB8859:EE_
x-ms-office365-filtering-correlation-id: 61bd0376-a72d-4c67-ffbb-08df2ead97a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006|38070700021;
x-microsoft-antispam-message-info: tbrVvxTudmcStB7oHiGqS/bx0+TDIRCBDgsGFTgKP2n/29EdRqByjSKALYL+UwnzhVoLvc5fF8fyHTf39sdzQOtweOnq3wBAanSBSerOzXIkmrGZALKSHL0U/OZyA5fHkTC/G1OOEpdqQntVEiMkFiVqj3Za5LKdKhzSxB5iz/zwpMiwjlizLWIObdX46kv6BCSF2Iz/RCqB0M+yDzoHmw4FsvviL+NRkJSy2n+yvSys8txYd/EuQAQTLfIckky83TKA1cpS9QhVN0Fh3/wJ66cyjRUr4ymXV3h3sZRddz5C/ggC0vGTEbOTZYYr6vDiZ+TD+S7/ExgVMqs5FVHRurKoET82cMuTt9dZ3lKWqDqOjdXHvDLGoEHXKlvPrInIvuzWT7oW58MVGBXYDbxtsP6PlJBKjGBIEHmKHYXoM2tU8bSPAuMa3Np+FlpPc47iWnfj1N2+QS2HrTMepuRs0/Ifal+7Pi51dHXVvrPBUxqbtlliHmT7D72m8GAhhKwQ1prkQvcZV7ZEtFPV5sP1TYV+p7KCraiGzfe7niTF9KQC4JpPiXBVh050wnf51xBsXY34KqNwjiiPE9EDQXKIMlUfIhzQlfMTYDIg5w/jDdjQafDE5XCuAZXEEWEBMk3ancozJ4H4xPgaPW3bsEzoU7nOS3bqQMaIEjnKpjC4U0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHg4NFVpYXVBak5wWjlFOHFkZGJnTk1QRjE0QjRsZmlQaXpEWDFnQUV4VVU5?=
 =?utf-8?B?bVQ0YWY4U2QwVW1kOGx1V3hpdElNM1FYOWtDOS9BRDlpTmR5eW9DRU1xNVNP?=
 =?utf-8?B?M1BQN1pvaWVWdmw0OHhEL1RjUEZ1R21QTVQ4RitLSmNwZ0pOaEVlOTlUR3Fl?=
 =?utf-8?B?bUZDekFPazdtalV1MGhvN0UzR2pleGEzZDh0LzNFVkNFalRRc002RkpaeGFR?=
 =?utf-8?B?cU8zRkI4UFZBbXluOXJxZWhCOGRHZmxQeVF6azIzTEM3cGNEaTJhakVtMDFk?=
 =?utf-8?B?VThVcitpVk5pNWdhMEcyQmhUWVN0VTFxUVlyMmQyTTBXM01SYUk2dEtCSGRh?=
 =?utf-8?B?R1NZNGJqZVB0ZE10WkxhMTlpZEZtVG5Gb0E2b25udDNQcUtqeXgvMStWTzhV?=
 =?utf-8?B?WnpIS0g3QUJrb0lpYXJDc2EveUxGOWl5MC8zWUFOdC9hbGdRQUtqb1l1OFoy?=
 =?utf-8?B?TU1reUx4TFZTR1RnaEpvZVpCMTVCQ3l6L09mK0xNK05wQlBONHM2VVNHQnFN?=
 =?utf-8?B?Y0NtUE8waEhKNmg2MmpIOHgwZU1iVTRCZ3J0dEsyOGN3MjFWTnhRckQ5YjNX?=
 =?utf-8?B?SDUxc0d3aFg2V1ZPRXJ0OEd3OExRZDcyL3FEQmZkT3d1enVxYnV2MnpURWg0?=
 =?utf-8?B?TEFVSGxrL3JyaytwQ2RpUWRteEtDUDRrTzZNS1dFdysycmlvdTNxU3ZlSDNL?=
 =?utf-8?B?ZnFYU3Jza3c0NFBSMFJOdXl6SWtWOWpNMGdyVktSSU9ycTNHRXkzaDVpbnhw?=
 =?utf-8?B?ZEgycXV4c0Z2T3lwS1dwR1o3Y0xEblZyVWtNVURuRzJRM3FGWnRFNzBNeUJH?=
 =?utf-8?B?ZE00bHRVbHJDcUM5Z1oxTjkvaUVac2VUdFIzbkozanNpdERGVUN4bVA3T2cz?=
 =?utf-8?B?WS9uL3NyR0dVWVl4S0pnUnRhS3JtaGU1N2xic005cU12MDQzdnFJL2tkWU1y?=
 =?utf-8?B?L0E4aGF2ZHM3TGllZTB4VWJzUm5peTZ6MFM0Y1ZBK2phaWdhRjNVVmRXUkpn?=
 =?utf-8?B?c2UyZ09QMjhHYVBCc0lRWldIcC9qcXlibVdhbi9WdlYwTHpuR3Rsa3pEZi8w?=
 =?utf-8?B?OURva0NqUUhXdXIvRW1vQ2pEODNxa0lYTWhqakdiUnlIZVRMZ0tlT2ZkRmJk?=
 =?utf-8?B?eDgya3RJTlNNZjVkN1RoYkU0MGs2QS9JMDFiVjlVTnB0d2ZiUWRYMkJ2R1oy?=
 =?utf-8?B?aUlaTzhqenltT2I1bjRIQnlTRVBIRDl6a0J1MGpWZ1NWRHpQUEJhMENERDJt?=
 =?utf-8?B?b3RXQzFYL0RKZElxQW8ycXp0QWt3Umhpc0RuSHZ5OTBHUWl0cnZic29IclBJ?=
 =?utf-8?B?ZTgyM1ZnTDdoM0hEck11ZVpsbjhiMWVkd05NV1h6ejh6VitaK1hpSHIzVEla?=
 =?utf-8?B?aWREREZueHhwa3JZdldxcnVEc2kyNTBaaTI2c3IxeGlvS1RyY0xQaHBJZXBB?=
 =?utf-8?B?WFJ3Uk5vcFNVaTZRT2RJTWcrYTV1UkphdlU5MndEK1hSWUhSeTk3b3J0aVB1?=
 =?utf-8?B?dTF3Tm1iTjJ2cEdkcUtQdFh6aytDQVRKbnl5c2hlTHNXWXoxY3Vkai9ONjcr?=
 =?utf-8?B?RldVMGxTMXhWT2dSUkQ0MGx0SXc4UXFBdGhuNVJSL2dnREt6WlRWUjU1RVIy?=
 =?utf-8?B?SFZmQ1hTRXRMRHVWdEpPcXVnYVlmSlhQdmQvTlNkbEhxSytEa0Y0bHdMQWdo?=
 =?utf-8?B?eUxLSjdzaXpRVjZWNWFnTW5jdEwyRFhpL1E1NDFkdXQ0WmZ1eTd6djI2K3ZQ?=
 =?utf-8?B?OXV1bkppRDF6MHpEZEc5a0k1VXhtS0NHZk1za21iRFhQNWo0MDdoWjBUaFpJ?=
 =?utf-8?B?WGV3SUNvY2dFQ0VsdDcycmlzeithN0xMS2tyZFVRNW5PVXo4akNLWHcyQ2VL?=
 =?utf-8?B?VGZyTnRJVWgxaC8wMFhvcUdia3NqdUVaVmNuZjRMd2QrSjFyWXFiZWE5YjV6?=
 =?utf-8?B?MEJKWjcybGpEMzJ1T09Gbk8xZUNXRnZDMkdZa1JwZVdPNnBVS0tXbWhZUlZr?=
 =?utf-8?B?YnNpaDJHYnhzekY1VmZ2UEZtUUovWVlGdVZuK3Y1NTRheEw2M0lFTmNrT01w?=
 =?utf-8?B?UExCbHF0KzBaRkNCakkvVlZqYnJsZ2FzSnBTWFBtMS9qeFQxRnBhVUduZW1Z?=
 =?utf-8?B?eUd2TFltZXJvWVZ3UEp0eXcrczdxVHNVVzNwZjlyNDB3ZVUyQ0tYZ3Jkak54?=
 =?utf-8?B?SzVXOEVzcFIrYmJVY0EzTTlTN3BWY1ZWNHR0V3BMclB3OEJGY2l0RFJLYll0?=
 =?utf-8?B?NkFncm1NREk4S3FiNDZNdUd4WndXVHMzV1lwbVR3R3AwbEJCWTZadC9oc1hE?=
 =?utf-8?B?VE4vV1Q5NlQzYVVYYnI4cEZzMzN6Qlp0Q3N2bXNxUVBUYXRVcDFhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0o9CF0g61dtXbtFTFxqfMv9+WZ01NKjtISgCEfRHnL3V8kVU/cUsvUwiyMztcW6x4khBEO41NnqV32fZ4ckBzrmoAtlvIMXVTR08Gn9yOX4EDAAKAmLChxDNBIeliznIpRSy+ZH5qvlsm9KsPIoHJz/8Bpkjhx+zcsPwRHjoFs1fqprAjFPEaVBnXjMpTtgRJXjycqWOy37gCI3/0QZnAUVi+hwhzhfEmibR5CLXRzupWkgVFbOGnU1zk5fyVtZ6BZuekZnbuIIxdWk1vhXTkd3Faws/sYY41hBaUP5xi0zLy2fvOUNWHCASXOXeKlf2vOU9vi0v+uUAiEHBRHHHjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bd0376-a72d-4c67-ffbb-08df2ead97a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 13:25:21.7945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gL7aLlPXxMZ0Y07+1irogr7c42sP5d8ips1Nygt44glaYFT04CLjVfCaexDTE2j63cINE1eZKmY5zzW9iXJ+YhH/Ik6PWeh4In6qF+xsrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8859
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGF2aWQsIGFsbCwNCg0KRml4ZWQNCmh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0
L2RwZGsvbGlzdC8/c2VyaWVzPTM5NzQwDQpUaGFua3MhDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29t
PiANClNlbnQ6IEZyaWRheSwgT2N0b2JlciAxNiwgMjAyNiAyOjI2IFBNDQpUbzogTml0aW4gVXBh
ZGh5YXkgPHVuaXRpbjQzOEBnbWFpbC5jb20+OyBNZWR2ZWRraW4sIFZsYWRpbWlyIDx2bGFkaW1p
ci5tZWR2ZWRraW5AaW50ZWwuY29tPg0KQ2M6IGRldkBkcGRrLm9yZzsgbWF4aW1lQGxlcm95cy5m
cg0KU3ViamVjdDogUmU6IFtEUERLL2NvcmUgQnVnIDE5NzBdIGZpYjogdHJpZSBsZWFrcyBhIHRi
bDggZ3JvdXAgb24gZmFpbGVkIGluc2VydA0KDQpIZWxsbywNCg0KT24gRnJpLCAxNiBPY3QgMjAy
NiBhdCAxMzozMSwgTml0aW4gVXBhZGh5YXkgPHVuaXRpbjQzOEBnbWFpbC5jb20+IHdyb3RlOg0K
PiBJIHJlcHJvZHVjZWQgYm90aCBjYXNlcyBmcm9tIHlvdXIgQnVnIDE5NzAgcmVwcm9kdWNlciBv
biBEUERLIG1haW4gYXQgY29tbWl0IGI2MThkNzMxYWIuIEJvdGggdGVzdHMgZmFpbCBhcyBkZXNj
cmliZWQuDQo+DQo+IEhhdmUgeW91IGhhZCBhIGNoYW5jZSB0byBpbnZlc3RpZ2F0ZSBhIGZpeCBm
b3IgdGhpcywgb3IgaWYgeW91J2QgYmUgb3BlbiB0byBzb21lIGhlbHAgaW52ZXN0aWdhdGluZyBp
dD8gSSdkIGJlIGludGVyZXN0ZWQgaW4gY29udHJpYnV0aW5nIGEgZml4IHVwc3RyZWFtLg0KDQpN
YXhpbWUgbWVudGlvbm5lZCBkdXJpbmcgYSBncm91dCBtZWV0aW5nIHRoYXQgaGUgd2lsbCBiZSBv
ZmZsaW5lIGZvciBzb21lIHdlZWtzLg0KRm9yIG5vdywgaXQgaXMgcHJvYmFibHkgYmVzdCB0byBk
aXNjdXNzIHRoaXMgdG9waWMgd2l0aCB0aGUgZmliIGxpYnJhcnkgbWFpbnRhaW5lci4NCg0KDQot
LQ0KRGF2aWQgTWFyY2hhbmQNCg0K
