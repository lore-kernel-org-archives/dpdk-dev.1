Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D45E909B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2E840261;
	Tue, 17 Feb 2026 15:59:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B7424400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771340376; x=1802876376;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Cgj1BjXaD1NwLfZnNAY2CAb7Gnu90L5PLBbQPzjp2Co=;
 b=A2bHWODdliHIMM6dL1p+i+FzKjrzKg3g1iDUYbidJ84cJU+SBwd+iPha
 b3N9i7UEGnc+A998+QUwdIcfRDvJxD2DYBLJStdxTEJVG1jLwxhqr+IMy
 prCiul6k/MVxSJK+qDCMDoDMqHoltS47bY+nmbDyVDmajrAlMl094Y6yG
 mg3PBIHmnCCFRarCP0kM4qbMR+yF2lp/HxFKLzt6sq4nsI/vkR0r2NPN4
 nJwHuDrO6x9TS70Dc0qST6O0O3TRCr462SXdfX9LxHgE0ee6huV51OObT
 65sfbQF1lj5AHjjjuj+bejzYYICAKkU+0c4BpfHUGNuT+OzE5GDuYeu4k A==;
X-CSE-ConnectionGUID: R5TcPu4kQoWOe9kJhik64Q==
X-CSE-MsgGUID: GZSdxlP+R6uAW+mi3d4rwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72120393"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208,217";a="72120393"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 06:59:34 -0800
X-CSE-ConnectionGUID: 3Uyjm48ISYGNWXp8FAPwmg==
X-CSE-MsgGUID: wONR5A+MRYGDt/0s68Dyow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
 d="scan'208,217";a="212364783"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 06:59:33 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 06:59:32 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 06:59:32 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 06:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgEe0FnJwKKBNwPF5gXLoUUPeVv7tDV6KBk0N09wualaEJ21NgO6wYFHaaYXyizSSgkT/ED80FfT1WOgK5i/etiT+MsUziewHId7rLcU8lor20cjFWO6uGJpW0X2AHKZpe66abhS7P/ARJ86bXnQorihUzFN5IV2ChxkvOZbMaqOX0WZtuWMpqO5WKdYdixK3VB/8CY4zZBmxTwOPovmRejyxoNmkUQwMbLB6WWEGfB2fhxXx0VhgIyOoCANb4gQG8vglcFFJkFsq5pSSvABxNJeHf7+OJp6ed2t1SXcMs7IMmODjNaoCTDQTxCct3Krvxn+Y4JyTVZaPuaUtswisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY2rXS88j+MaXrvdCi6gY1/OzF+QHY1kqORTQsCd39k=;
 b=EGfF7/WwR3GoJt9yY4JsA0cMlw6S3Tpya+ykIk4FgW9CvDJiYFpDoZbdAQEv3yxbCjejJZ35YyFhxooJnnNMvKaXjeq1HfksFruc47IWF+CyCjETRyjYhm+DBKIN0A3aF6Sv3F5HVP4gcnr+8pzTp/AnaMCVLIpjYlFqBuIR41gViGd6eCpYJDoXZdWGPv9l9tQJUTm34O6BI/ruBFYx5B9hp/GY8gRmWcNcIu31DnaoZtBMtlHDnY00bfPcqnmmsbM9CH1u9YmqPrsDgRit8k4mq0gxxQqGUn2Cks3Kfq+wQIaImhqcg1ISxQpGzmHsJMMxzPhfGnvB9pk2PLw33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 14:59:29 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:59:29 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-02-17
Thread-Topic: DPDK Release Status Meeting 2026-02-17
Thread-Index: AQHcoB27zAqmyRiJ+UqVegcNft+OOQ==
Date: Tue, 17 Feb 2026 14:59:29 +0000
Message-ID: <CY5PR11MB631838F59A6C732C8E85DCA7FC6DA@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: 7539a9d8-9896-43dc-11d9-08de6e352681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Xrzt3qxY3UncHBp6zOyztixoZvj+jpfMclXjrTkeahrhYFLpuPCgdxaM5S?=
 =?iso-8859-1?Q?rCYZxeH4lXcd2pA4i9KzEV1yhxKRX26uJVsfX+nnjOcQzt+3zuKw2AvLtE?=
 =?iso-8859-1?Q?tU5dFqoi7jGs0Oa1+ZBgkoG4OqW9hLIRSbIt3jXmKbLOBOl+ZspLAvzJ6u?=
 =?iso-8859-1?Q?OBcgLf0OjwPUrDD4eNbahtMHWTKky4b1ocATgrWkdHQSIwI1WxF5813+Oq?=
 =?iso-8859-1?Q?AJvlJdxY2s06K6B0Zx9Q9+ENcHj/sCr+8AUrXGhko4mboOU1mVqFk1Dkfd?=
 =?iso-8859-1?Q?QlsDTU0/7JNPDS+CjOrLhAxsbhyUTSLhTYAkxcM6V/QXypS5hIDW7w7bzu?=
 =?iso-8859-1?Q?BvxcOtZrTsryl8INoqYIugXeqULY0HOWnzV1U0KJ1ccgDVhdmTu7jmqzBi?=
 =?iso-8859-1?Q?y/qyEHgrWliJldcLYKxxV2kNUwymFGKTCSxXYlwVX29TOdQ8jnJSqZEC/6?=
 =?iso-8859-1?Q?dAmVVAt/usBWUux4xp+2UHOziobLyxnG4PdslJlYnAs/KI4q59UmFSZYop?=
 =?iso-8859-1?Q?DpDPTSmC0WwJB00S1xr7B/XFQsu4N3Fh7a/GHIfAxhlFBm6Zipq9wII8k0?=
 =?iso-8859-1?Q?GZwGe7cIuyOKydQuv7GPnigrbdhfYxeCk/vKc5f+JfTuYyfZrfjcYwEMho?=
 =?iso-8859-1?Q?scvFqxmG2FnIjtX9SSgPWYf4DxzLoUgpM7A+38fN8GfwYnu/CZS+pSxZKm?=
 =?iso-8859-1?Q?uK3MmFHMm1eGPEBn3MiOqIEpEQxAlsMZf1QQklp06ZTFwaG33PKzMkNEgC?=
 =?iso-8859-1?Q?hqWnaCl3ajiuA3Xgo0im3IYAA+l98pHWb/P/7ADMNM24gthwzryTakrxPg?=
 =?iso-8859-1?Q?QTqxKYvN36YUVp3YEGRztyZGBTMjrbrc62WQGBYhuuS8CWPC1p0srLvyyn?=
 =?iso-8859-1?Q?QGXWJq4rMxWe8uz13xC4MnuW5ilgI+SxxT2jlX91Z+F7StenCCKH4QRX2U?=
 =?iso-8859-1?Q?ZNdxnxmADPOIqAXc+C7MywJHQCIBsIKmK+pPSiI5EoliclPZwyKEKAFnUF?=
 =?iso-8859-1?Q?YqCtMfR62UBsRD+sX4kFenZ3ZomgJlHTKAP2oN4mOCtv2jLFLW2HE5MZsy?=
 =?iso-8859-1?Q?iSsLFwixT6E6KPmOilrHMrVOBOhkSgvdx94FW1Fs3YJNOXDga7pTBnfgJq?=
 =?iso-8859-1?Q?Cv9HtcyshhRk6VwoMq0L1pvQQS/o0XUNPEvcP/vbWUIB2nRnEy/5dz7t4K?=
 =?iso-8859-1?Q?8SQUTi5esxS7tQ+t+5HqXGS0YSVyuZ06uBrw4OiGDOWvJv3C0ifx63L3sJ?=
 =?iso-8859-1?Q?pnVgupGsuW5EGLkkFaYNj/3Z09iDWqR6mQSF+jo9VAuR2mX0x00rKnW6NJ?=
 =?iso-8859-1?Q?0VFpMV2S039ed2pj6lzBeksD7SUrooLwT/lj3m10ww89Hr5EHCHEh8NJp7?=
 =?iso-8859-1?Q?VakDUXOksjcGxyynTnTNSJItKJ9MGb9eRDDbFtes04C5lFV/IQT9MMceZc?=
 =?iso-8859-1?Q?dCJtjNKTQ7fc1pvs7Hr5w4OE8JLZIlCR6lE0nHOGPKHbyP4DMoS+CkzY+X?=
 =?iso-8859-1?Q?XEZQSgrMSAHuhFzHrR19owoKoPqD2rYs7yt/NLsX54pMETDkqkKzB82YYt?=
 =?iso-8859-1?Q?SpkuVOSogFTP9brenIAKZ7lyQTFaGixZd9zv1fxUAG0JYEWyTWwdmsZdgl?=
 =?iso-8859-1?Q?f+4fKzQHejrHQMMclmTMkA6UMDZXD1tkCi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zx5ALbRvPY8j82mKLPHJJQLY5RdbTS6tfvhAPS6jIGA1tJFf1yVJUeqVI4?=
 =?iso-8859-1?Q?NaCT9CjAPyjUbUiqu8fxyDp7yjShVsHtR+ViFQq6dOBwW9KUl/dEHBRS2w?=
 =?iso-8859-1?Q?UmiVxvqwXpR0clV9Hx2LNmdFJqO9bCUCYETGa+meLPs4BSMvX8+g0g4mKU?=
 =?iso-8859-1?Q?t/lCs0OdqPzMvnSIkjG9hUmYATWEEPw7oUANk+j+XsKsKT12u8hBH0PG/M?=
 =?iso-8859-1?Q?k1OygJdcPPnS1yyvCm+DABq077pJ3XBS4eIIQbIxFgWcIVc44qeHHG88BN?=
 =?iso-8859-1?Q?RBIUY6SeS6rA+6rNu+F3fPTp4/8fFHrC+BO2Yt+r5eJgdJEZvLkjwvxW3i?=
 =?iso-8859-1?Q?MpvGoS0JqlAZm0lfKKxNYXVMV3rK2JTH/JQwmfjbim1YfIZlibvBZjlGjy?=
 =?iso-8859-1?Q?yWEz45wJy5AMVeh3kh8yVlM7l3SNhminYA88YZWHF+73bGEhL6Il2y7w4R?=
 =?iso-8859-1?Q?B6IulLpOUV57tNketzmXO3dxeEATWLb697qth7UaYFIKNRPWglD4Xku9YG?=
 =?iso-8859-1?Q?4Ag4qTnBhrTwqonIKb7Bricv1Nf18ecin4zVXWa4EF5mlXo+yZ503dFaN+?=
 =?iso-8859-1?Q?tklVsY3VoXsknrzxg2elQf2Nl4VNN0zxRGDZZpl3Nzrac4DAM5IzL2dHV6?=
 =?iso-8859-1?Q?g2FUq/8GdRmEm86Gk22ECqWiGVAeHiGewiZY0XrPoLeGGc8aueGzxPiI1K?=
 =?iso-8859-1?Q?tm7jrMpb4eRs2n7SvLUifa6x/UqZ9o95pmPmfqvrh798N9tPiUVTenvG2Y?=
 =?iso-8859-1?Q?yx4z+SDWF8GuIGsfEW1PGv+BjUjKF9A0wcRb1awOyBYSwRP33Eza5GgPyY?=
 =?iso-8859-1?Q?5o/Jprn79s2RaP8jniZGU5gZTdJFPGaSBXxN1AsAdnUuh9+yMiZT8pa8oP?=
 =?iso-8859-1?Q?YJkOEugjQTi58LPjeX+GsF6zSEZ9N/WwQCSf5rMs+tvyWlkLjW5a1t600N?=
 =?iso-8859-1?Q?WsqPGsXfDNpvQVaNCim79YmRb3NdLEptwQIb+w+558463gaycVfIPYraDX?=
 =?iso-8859-1?Q?4Stq5OfH3jZrxSKDbOyKz+dGTU+8dnBBXWmUo2J0J/nogAQghFRgI1F10h?=
 =?iso-8859-1?Q?ks8HJTm1xn8WWOG8kTka1mUup9TBfjkyVv6i8SqRbCOsOpJCPLZ760JRLS?=
 =?iso-8859-1?Q?xI52WWMBfb8PdEfT/xK7kXvo+e7fpFOVtBzju9Sq/VfDkty47n5BOTeZFW?=
 =?iso-8859-1?Q?rl2vBS7j38z3Oxa3VcQ4vqNfU6AMBIMfWoWGlSXvmLZhEqCeDkRBpJ63Hi?=
 =?iso-8859-1?Q?5NYO4D4VUIL5B93T3wwwwqjuxryGtegJ4CcXW2/GyZCFCcFxZJ3GXUhKxx?=
 =?iso-8859-1?Q?j/Ollv+zpHl7v6g8+D6D31Z4cYYAPfu7K2ZwkI8Y1IK58pJiC6DoiIEIOA?=
 =?iso-8859-1?Q?rcQ/rA0MDabbItHKLoViGlv8/s7OgkloDQeZPGVumBh7oJVoB4ovx7ChqC?=
 =?iso-8859-1?Q?rtEEuNfGCNwLx02k2e5Ub3lAvPQGuPdZtmAGc584cklV9g7j3sVwCk0/PF?=
 =?iso-8859-1?Q?QgOtfXtu54B2o8qLDWPsyYmePpmaXU/mzMbhoCY3z2WSK4SC8tfhG2bESy?=
 =?iso-8859-1?Q?6Q8h5rzNlGuhRP59aRd8xs91vjeXJCVLufSA3unCxI51kv42TA/0KHglje?=
 =?iso-8859-1?Q?x6DctMZoObpGYhpTm0NeYcCq72NDE80qzwc2mUksqFFdSQ5qW9kQJbEo6p?=
 =?iso-8859-1?Q?Q/mt2s13orVa5nMihiaICPQSW6bxYBT/cKmn2Rpwa+kham+esalxPjo4C5?=
 =?iso-8859-1?Q?lqEu38EyFMFC1dgehuZhJLT/EVYt6Dwr3Jw5hqyLppkcHQdxFsynEq2EyH?=
 =?iso-8859-1?Q?Cf29Wn2RPA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB631838F59A6C732C8E85DCA7FC6DACY5PR11MB6318namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7539a9d8-9896-43dc-11d9-08de6e352681
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 14:59:29.0646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwbeKFdmajMUxVXWyd/qP2fYg2tbJTBMQMYiqB7Y1no57gMvmfRXh4QLqvTC8yORPBZX51a95/J20P9PNyP9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
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

--_000_CY5PR11MB631838F59A6C732C8E85DCA7FC6DACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-02-17
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
- Release Dates
- Subtrees
- Roadmaps
- LTS
- Defects
- Opens

Participants:
- ARM
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 26.03:


| Date            | Milestone      | Description                    |
| --------------- | -------------- | ------------------------------ |
| 5 January 2026  | RFC/v1 patches | Proposal deadline              |
| 9 February 2026 | 26.03-rc1      | API freeze                     |
| 2 March 2026    | 26.03-rc2      | PMD features freeze            |
| 9 March 2026    | 26.03-rc3      | Builtin apps features freeze   |
| 16 March 2026   | 26.03-rc4      | Documentation ready            |
| 19 March 2026   | 26.03.0        | Release                        |

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - 8 doc patches pending.
  - 46 patches in review/waiting.

- next-net-intel
  - Pulled to main.
  - 50+ patches in backlog.

- next-net-mlx
  - Tree pulled.
  - 7 patches in backlog.

- next-broadcom
  - Tree pulled.

- next-net-mvl
  - Merge in progress.
  - 26 more patches in backlog.

- next-eventdev
  - PR ready and pulled.

- next-baseband
  - No patches.

- next-virtio
  - Tree pulled.
  - 2 fixes in queue.

- next-crypto
  - Most patches merged.
  - Acks/reviews required.
  - Ready for RC1.

- next-dts
  - Some patches merged for main.
  - Some other patches under review.

- main
  - Merging for RC1.
  - Merged fixes for unit tests.
  - Looking at string overflow/truncation patchset.
  - Some improvements on checksum under review but there is an issue with M=
SVC.
  - Merging pcap-ng patches.
  - Will try release RC1 today.

 DPDK Summit CFP is open: https://events.linuxfoundation.org/dpdk-summit/pr=
ogram/cfp/


Other
-----
  - None.

LTS
---

See also: https://core.dpdk.org/roadmap/#stable

LTS versions ongoing/released:

- 24.11.4 - Released.
- 23.11.6 - Released.
- 22.11.11 - Released.

Older releases:
- 20.11.10 - Will only be updated with CVE and critical fixes.
- 19.11.14 - Will only be updated with CVE and critical fixes.


- Distros
  - Debian 13 contains DPDK v24.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 9 contains DPDK 24.11

Defects
-------

- Bugzilla links, 'Bugs',  added for hosted projects
  - https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.



--_000_CY5PR11MB631838F59A6C732C8E85DCA7FC6DACY5PR11MB6318namp_
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
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Release status meeting minutes 2026-02-17</s=
pan></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Agenda:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Release Dates</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Subtrees</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Roadmaps</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- LTS</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Defects</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Opens</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Participants:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- ARM</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Intel</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Marvell</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Nvidia</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Red Hat</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Stephen Hemminger</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Release Dates</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">-------------</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">The following are the proposed working dates=
 for 26.03:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;| Milestone &nbsp; &nbsp; &nbsp;| Description &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| --------------- | -------------- | -------=
----------------------- |</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 5 January 2026 &nbsp;| RFC/v1 patches | Pr=
oposal deadline &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></d=
iv>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 9 February 2026 | 26.03-rc1 &nbsp; &nbsp; =
&nbsp;| API freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; |</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 2 March 2026 &nbsp; &nbsp;| 26.03-rc2 &nbs=
p; &nbsp; &nbsp;| PMD features freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;|</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 9 March 2026 &nbsp; &nbsp;| 26.03-rc3 &nbs=
p; &nbsp; &nbsp;| Builtin apps features freeze &nbsp; |</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 16 March 2026 &nbsp; | 26.03-rc4 &nbsp; &n=
bsp; &nbsp;| Documentation ready &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|=
</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">| 19 March 2026 &nbsp; | 26.03.0 &nbsp; &nbs=
p; &nbsp; &nbsp;| Release &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">See https://core.dpdk.org/roadmap/</span></d=
iv>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Subtrees</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">--------</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-net</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 8 doc patches pending.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 46 patches in review/waiting.</span=
></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-net-intel</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Pulled to main.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 50+ patches in backlog.</span></div=
>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-net-mlx</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 7 patches in backlog.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-broadcom</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-net-mvl</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Merge in progress.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 26 more patches in backlog.</span><=
/div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-eventdev</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - PR ready and pulled.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-baseband</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - No patches.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-virtio</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Tree pulled.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - 2 fixes in queue.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-crypto</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Most patches merged.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Acks/reviews required.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Ready for RC1.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- next-dts</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Some patches merged for main.</span=
></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Some other patches under review.</s=
pan></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- main</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Merging for RC1.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Merged fixes for unit tests.</span>=
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Looking at string overflow/truncati=
on patchset.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Some improvements on checksum under=
 review but there is an issue with MSVC.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Merging pcap-ng patches.</span></di=
v>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Will try release RC1 today.</span><=
/div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp;DPDK Summit CFP is open: https://event=
s.linuxfoundation.org/dpdk-summit/program/cfp/</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Other</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">-----</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - None.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">LTS</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">---</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">See also: https://core.dpdk.org/roadmap/#sta=
ble</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">LTS versions ongoing/released:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- 24.11.4 - Released.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- 23.11.6 - Released.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- 22.11.11 - Released.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Older releases:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- 20.11.10 - Will only be updated with CVE a=
nd critical fixes.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- 19.11.14 - Will only be updated with CVE a=
nd critical fixes.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Distros</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Debian 13 contains DPDK v24.11</spa=
n></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Ubuntu 25.04 contains DPDK v24.11</=
span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - Ubuntu 24.04 LTS contains DPDK v23.=
11</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - RHEL 9 contains DPDK 24.11</span></=
div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">Defects</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">-------</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">- Bugzilla links, 'Bugs', &nbsp;added for ho=
sted projects</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">&nbsp; - https://www.dpdk.org/hosted-project=
s/</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">DPDK Release Status Meetings</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">----------------------------</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">The DPDK Release Status Meeting is intended =
for DPDK Committers to discuss the</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">status of the master tree and sub-trees, and=
 for project managers to track</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">progress or milestone dates.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">The meeting occurs on every Tuesday at 14:30=
 DST over Jitsi on https://meet.jit.si/DPDK</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">You don't need an invite to join the meeting=
 but if you want a calendar reminder just</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span class=3D"elementToProof">send an email to &quot;John McNamara &lt;joh=
n.mcnamara@intel.com&gt;&quot; for the invite.</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; font-size: 1=
1pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_CY5PR11MB631838F59A6C732C8E85DCA7FC6DACY5PR11MB6318namp_--
