Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FF7C83F0F
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 10:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B643B402A0;
	Tue,  8 Jul 2025 12:17:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id BA3F14028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751969841; x=1783505841;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mGuKiniDRNTW1d1e07QfJhwmuzYfSixvaPI3kwzvsFY=;
 b=EJaRRA28WPPXrch1IalwTxu5qUudKDSwMpt/4aFAgLZxxEHId1+2HI1u
 kzycnaux+4N8B9CDcY3bgUyFIu7WJJot6irzFhv+dIjKzCwEncY9Z41rC
 uZlMDm3oQfXza0aEUyPUJgyYhuUV89lHE01bLNBPQgn4mnxTKHdU+qjI3
 IMSxZqd1Owq1/Fev76Rqz6gmKiiKF+itZagyZjgffaUSDGKz6kyl0oXY7
 mwcKM4fhWVsQ+a83OvEVvVjIHmWtPTjP7FHzo9PUZtbRhZVHknk9aOzCC
 YgiyU7hoqJ5UYvV3MBSbRhIWrL4HgLnHnv6pGFFEvPwMUu78m6W8lGiyG A==;
X-CSE-ConnectionGUID: J90oguNYQZenL98IRSpQqg==
X-CSE-MsgGUID: y3CtqgffQ0GuYzEWk2Hc6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54331521"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="54331521"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 03:17:19 -0700
X-CSE-ConnectionGUID: NnpLlFmCTtmJ1qpC6PS1ZA==
X-CSE-MsgGUID: ve1MwkOlRvyrFBsF5jhvpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="156047270"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 03:17:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 03:17:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 03:17:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 03:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkcvpi+AAvZKljxIOOjB0PUyho1utPnmWrReOSX/cOqX3n7BM73AuaJNZo9b3NnZAz0JlSlj57Q4VQPic1QanNHpw4+GVv331LXHewngc+qyRSL2NKcK4BMNzHlT1Fgq250e2TffoCCQ8GB0c7AJzfSiJMkEpw7Zv72qGVgu9xTgVx2JmsW3KqYE/BEqYhns4NT8LKqmKgEh2RpA7t6C3X7HK3kzqFh9I187p4OMfQslCgpwXT/phKHQDF996WXd+T+PkDJyrUxph2JJhiGDXR7RgdM14mmfwwRfUj0kJH+ss1E7ziqEyxyPPyhdXGtE1Bzkm31/eUTDj06YdaeQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNIB1Fyv4uIefDf8OIjlYn+3+nl0Rh/z2tHIT403bLQ=;
 b=L+gZwAzNTUSVjRTNEIUrus0IA16t0j0D9SehkjBZDw9CyVCHvQ+o5btmTFe3DAdVP51EfTJAAK6sPZXlzuDRquS1XcgsYfTxgMVir/1hKL5Nw38kpsf8pabkhfO/jjlECg77Ps3w4J5OgXTAbpvbt+GiaP507rlzFqxbkTbg1Lz5RBQKZrrz+VU4MMxV91A9UiPxTq4AXDLShWtTE/Vx1oOHYqord1oh3Y89lkeDkYklGwS1+0jVAeJq8ZOABv1VL9AOV0TVeDyafL/QrB+hOKvGARSb8ZwebsjVy4VEDXz7C6f1A72JlXMMKE5mDmxIndK6VEdcUVjtxSUdohPQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 10:16:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:16:32 +0000
Date: Tue, 8 Jul 2025 11:16:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Vladimir Medvedkin <medvedkinv@gmail.com>, Dengdui Huang
 <huangdengdui@huawei.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
Message-ID: <aGzv-gld5GAFO2N0@bricha3-mobl1.ger.corp.intel.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
 <CANDrEH=NEpj8X-8e6JXGVAMGXuykp1bgOMKyLFm1TPBEovdx-Q@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd5dbad-5e1a-4c46-1eea-08ddbe0882b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjYya3ZjSjU0cHZCU2FtQTlTNzFlaVE4NVduSlBnVFhwTkoramorR0hFbDZH?=
 =?utf-8?B?RHBSZjhQaXB0aGJlc3Q2bE02MzdPRWNOL0VQK0RKNksyQm90SlQwL2l2RjF6?=
 =?utf-8?B?ZjA1NmIxSlV5ZHhYd0F1UTFZbzJ1SitvaDZMOFRiWkZyKy9VUVlZcWFqckNG?=
 =?utf-8?B?Wk56ejJtaU5xOUd3S212cFR3cGlKZEZLa1NFV0UzRWNSZUVVaFFtcVoxT0R0?=
 =?utf-8?B?NzdEU0NYeHQxVmY3Wnl0Wlowa1FiWk5nNk8zN2RKTHFaRVRjQ2E5dEoraDRa?=
 =?utf-8?B?VzU2QzhCR0lGOEhWclZpbG1TWTdlSStpc21IcTFFUTUrR2ViNVRGeWx0Um1X?=
 =?utf-8?B?VGoxWnpUQ3QwNnVWdzNXU0NwUXpEQS9GSzVCT0p4N0xQOW9zb3Ztak04dVp2?=
 =?utf-8?B?Ri8rTzB0Wmp6VUIyOFlDZS9vN1hQKzhXVGFYY0o4NEx2NjRlQ0toeVNRcG14?=
 =?utf-8?B?RytTbXVvalhaeGtLVlR6L3BMUjJSY0hZVVN4U1FhenorNjlYcGJvVWtqb05Y?=
 =?utf-8?B?OTlZZkZ5a3VwekQxK0hWaS81cmFUVS9saWx5eGs0WDFmTW9nRGpYRGdiL1l6?=
 =?utf-8?B?Nm5Nd0ZvWGowOVBIVE5UYU1pV3FtcXFhMmtCRmhNRlhXQUh6QkRmc2FJWHBS?=
 =?utf-8?B?VFh5Vk83ZUhrcHcrVmVJWjJRSUZhTUVTWkUrNHVid1NobGdrR1N6SWdDckhm?=
 =?utf-8?B?WHZnWS9JdWRRLzI4NXJtVzFldTRtM1BmaFc1TjZQdVh4Y0hJTzVuZHl5VWxK?=
 =?utf-8?B?dW9iNGpPTGR3OWM2em5jYUhHUFJBSXBDbHUrRWxINGxnaS9IaXdPSmlFRHZN?=
 =?utf-8?B?VjhXTEJBNWVnaDlDVnFRajRUWVBhYm5vdGZKYUh6eHdhSnA4SitKK3hCWnJv?=
 =?utf-8?B?a1ROSTAvdDYzbit6WXpoTHM5dHl4bm04T1ZLK0xXdERJV0FzcVp0ejZPVmNM?=
 =?utf-8?B?dngzMkwwYzZIYTBrNmRFcEhvT1lwUUNlY3JQNHEva2M1eVRudW9sWTZoUllH?=
 =?utf-8?B?WTg5dFhuZXJuem40djZ0WlBaZnFsSG9Pc2ErVCtXckN0NXFkMVhFZkZYUTFT?=
 =?utf-8?B?NFV5SUk2RjlvMjRabmUwSTdJT3RmUldSR040V0dEdTVLRnhPTWdoU2tZV1l0?=
 =?utf-8?B?d3NBeTU0eVNCbnNmQk9RdElqMVRqdWlzTkYyR2dVdUtOZng4TkJGTTJqbi95?=
 =?utf-8?B?T050UFhJMVBicEt0cHdFSFVvWmJUcVFUdHpRRmU1V0FlZEVONzJ6TGhVMU9m?=
 =?utf-8?B?VWt0NE83QTVodXpaVEJkZ3U2ZzJ6dWZUdnh5dlVnKzEzY29uUk9UaVFkWEhR?=
 =?utf-8?B?a2FtSldNYUt0L3h3STNjdk1WcGJQNFNWb0VTcTFRK3FCZERKTU41MmpHODlp?=
 =?utf-8?B?WnAyVS8yRkNqQjdPRjk1VUZjbzF1eExCRytudmw5bzJiaFAzOUVmSm9pK1Er?=
 =?utf-8?B?bThocTdyK1BXOTBuamxWYytyajk5Q0FWVjBnMjJCMUpYVmdLcU8xeUgybUln?=
 =?utf-8?B?ekY0cGN2OFpmdkRvWlRzZXpIWlYwL2ZqTUtCdUpIbkF0RmhtcjQrL0xGendH?=
 =?utf-8?B?Mk0vTHVQK0J5MFA4YlFNMGhTdm9lMGxKSU8zbVFKRGwzUUZrQ1hHRHc2WEVV?=
 =?utf-8?B?OWxxMGV3bkhadnI0eGlSNlNTT0VMZjYwSk9GTlkxcDR0TS9oc1hpdFJ1Njl3?=
 =?utf-8?B?NXpuM0VjTVdWTms1SVB0L0dFRXVpTklyczVLcjBiVjJDbWNDS3RraVpKOTRy?=
 =?utf-8?B?YVFrL2IzdmR4YjhpdVdJdHZuV0FkYWpjTFo0WTFzeG9tSldhUG1KVlJSb3JG?=
 =?utf-8?B?Zyt3SjRLMDNFRVY4VG90Y2piZG9QT29ROXhWcFl5N2s1d1JqNU1TcVRrRUFO?=
 =?utf-8?B?cjFOWDdYVGVKbzluRENwdTQ0ZVdIZ3l4QjNkU2lHeE9zb1lod2JFZjlFMVpV?=
 =?utf-8?Q?dNNOui9b7wI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFE2dHVhejB2N3N5aU5nUHJDL2g3c3pFV3lPZC96TGhIa0tJTEg3TlFldWM4?=
 =?utf-8?B?cXJUT0tRYmMvYzd5MktoWmpMZXdxNXpIR3ZZUlZ2YkdUSXhzam52NTZQUS9W?=
 =?utf-8?B?Z2l2aVQycGc4Y1U0L0dMQUZsNmNjcGdLZjNOSXlZdEJCeHJjTVR1OTJVSzRL?=
 =?utf-8?B?Njc1bURaczBxUVpWUmRmemVqTWVsdlI3MERQcnB3bUw3VUltZkJ3eUlETXhL?=
 =?utf-8?B?aWZpa05WMG03d0NZcEFZckovNlU1TEZNdGhpSUxCaVR2bTc3U0xEK3ZNSlIv?=
 =?utf-8?B?S1ZUbFRXNmZMd2k3enFQTnRCUVEwd2VvZC91U0l4ZEExRW9lZFZ5V2w1RGlv?=
 =?utf-8?B?NDhlUkZVRXdURTZ4OTJ4SWp3NWdYb0dXZGZxNk5CSnptSlRERGFteThxdEtm?=
 =?utf-8?B?bVEvNW1YNkhrSTdTUFZ3eVg2L1Q2RVpQRiszZG9QdndZRjlIL3FGVE9GdUJK?=
 =?utf-8?B?eE5hVGVLbjQrMEVUcTRxOC8zNXZNUlhuaWtjaThSdVRRNzFvcGhyTmlmVUNL?=
 =?utf-8?B?VjVzODhGaW94SDUxVFp2bDJWcUxTbFQxR09PWVFpZXZRLzY4WkhiYmIwM2Rq?=
 =?utf-8?B?RXA4VnNoMFBaaTc1NzZINTRMZlFieEV4Y2tFTzlZZlVhVy81U3c3TGVwakxC?=
 =?utf-8?B?RVg5bWxkWmlVSkQrSE13enZNd2NlSDIyVTBUWDBJYU5HbUw1V2JMUlVmQnh3?=
 =?utf-8?B?U3hUQ3lwOXNqVHREM2xCd24rNVQxbjlwTUx1ZXViNVg2ZnBxZitWSjRyS0R5?=
 =?utf-8?B?bW1FcVVyTWxTaDZKcDB0cjFHY0plV0ZFVFRZREVSQk9hWEpWd044TFlxdG1Z?=
 =?utf-8?B?VitDY0RqaXNjZ2FybEdXM3FVbTBIdlFic1Zwb29mSTZIY3dqTXp3K1UzcXVQ?=
 =?utf-8?B?eThtSWR4WWJhMkEwdWdHaXluQlRVY2gvZmx5c0x6WGZUSVFWUllUb2hXVXRv?=
 =?utf-8?B?QUNaRi85aElPSGxodkxWZ3hEYkhoN0x3S1RxbHUzVDgzVnFuUkxPVy9qazFl?=
 =?utf-8?B?cmUvazdLVGZTZDV1d29NK0E3WWJkUkZrSkpZL3cwVDc1TG1pazJZTW5yQnB4?=
 =?utf-8?B?aTBha3BnOXFoQVZZVzV5VEwwUE9WRmpSYk0xeGwvcnU3Z0FJVmtCbldmbGlQ?=
 =?utf-8?B?SXhvKzhocDFIb0g5NzBQMWR1bWd2Ti9rN2FVSFZzRXlRZmRYL0tBVXl0Snkx?=
 =?utf-8?B?eXFyRFpQTkhiaDhDcXV5bWk1aVYyUU90VitZN3UxZUN5bjRJUURqNFNKTzEx?=
 =?utf-8?B?aGZHRW13TFNtZXhMQVBZRmg3QzV6L3Z3US9VekE1NlBqOENVekN6ZmN4ck15?=
 =?utf-8?B?RGhGTVBoZUtDT1ZNT0d0UkFsamRFWE53enhjY2ZlZlR4cmtkdnZnTU9xVXl5?=
 =?utf-8?B?cFhtRjRsYVUzZjRxZUVWMUxESUVYNTFrbG9od1luL3liZUlrVkxYOFNzY3hr?=
 =?utf-8?B?aCs5YXRMRlRQa1FraEd2cjB1c0ZqK0ZIUjg1TjRmZWx5dUtqbFNaNkRGcEJB?=
 =?utf-8?B?WWxFazBHQzRsUjVDRXlxNDA4WitHeHhoT3BxajR4dW83Z20wZ1NibnE1bG9H?=
 =?utf-8?B?Q1pIUC9MS0NWMkhqOWtlSitMTHd0Z1JuNG1VWkhsdm1sVHpxcWtWM0doNmhD?=
 =?utf-8?B?bUFZaDc1QnVJNXlmdWc2THNsZnk4eFkvZ1Z4R3hHT1F3VnVsV0dtU3FhcWpM?=
 =?utf-8?B?KzFpUXNqcXNXOHEzdUFENVpSUDdFWDU4SlhmL2RwU1d1MC8rVmx2bS84ckd6?=
 =?utf-8?B?RG42L2RUblRNMWE1NmlxMWNuL0dWdHRwQ2J1SURKVitjQTlXNDFxaE1qOTJF?=
 =?utf-8?B?cVBhS1ZOUGViMUphZHZqY2hIMUpIVzI5NlE5Q1A1NUI5VlRReTQ5VWxLbHJa?=
 =?utf-8?B?SHBIZVR5WmhPVlhBQUVWei8waS9zYWxhdlNZbWZBWUV5SmtCOGxWZlVQaFlV?=
 =?utf-8?B?OXVqUjJuVHRsL3NGbjdJRWI5WnFxTDJhSEx2NTZjTENjTlhuS2dZczNISkdD?=
 =?utf-8?B?S3F4d1NVanZ5ODk0cVNaUVRpdVV5L21ZOHhyOEVsN24rK0xsK2hNSURhUkJn?=
 =?utf-8?B?Ykw3NmVYRWVCaW13OHhYWC9vUnRtdGFBVnhlSFJvcDdVWEpISllNakhXbDNN?=
 =?utf-8?B?ZWl4NWs4WnRpcVUydHhiV01wUVozQWVzMnJDRTB1VzFxN0V4NFZubENhdDJK?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd5dbad-5e1a-4c46-1eea-08ddbe0882b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:16:32.0285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ys3AyGOvqZ+PKTtzJjtSsvX/idSXFQyZL67VlXVV/H8AxCsYiDaRcxJqUaRn95LNs/2QY+gjYgHxpnNfuIZIXDMLJEqwL4LUR10JFUe4Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
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

On Tue, Jul 08, 2025 at 12:00:42AM +0200, Morten Brørup wrote:
>    From: Vladimir Medvedkin [mailto:medvedkinv@gmail.com]
>    Sent: Monday, 7 July 2025 22.10
> 
> 
>    Hi Morten, all,
> 
> 
> 
>    пн, 7 июл. 2025 г. в 19:09, Morten Brørup
>    <[1]mb@smartsharesystems.com>:
> 
>      > From: Bruce Richardson [mailto:[2]bruce.richardson@intel.com]
>      > Sent: Friday, 4 July 2025 13.32
>      > Hi all,
>      >
>      > this email discussion comes at a bit of a fortunate time for me,
>      as I'm
>      > currently looking at our vlan tag/qinq stripping behaviour in our
>      Intel
>      > NIC
>      > drivers, and there is some discussion internally as to what our
>      driver
>      > behaviour should be compared to what it has historically been. :-)
>      >
>      > The documentation - both in the NIC guide [1] and the testpmd
>      guide [2]
>      > -
>      > is rather short on detail as to what exactly the behaviour should
>      be
>      > when
>      > vlan strip or qinq strip is implemented. Therefore, I'd hope that
>      those
>      > more familiar with networking than me would be able to help
>      clarify
>      > things
>      > so we can document the correct behaviour precisely - and hopefully
>      test
>      > our
>      > drivers against it in future!
>      >

<snipping full discussion for brevity>

So from the discussion, would the following be a good set of guidelines to
document for correct driver behaviour:

* VLAN-strip always strips one VLAN tag if available. If multiple VLAN tags
  are present, it strips the outer.
* QinQ strip, strips two VLAN tags if present. If only one tag is present it
  behaves as VLAN-strip.
* Specifying both VLAN-strip and QinQ strip is the same as QinQ strip alone (??)

Mbuf reporting behaviour:

Input Traffic		VLAN-strip on		QinQ strip on
--------------		-------------		-------------
Single VLAN pkts	Tag in mbuf->vlan_tci	Tag in mbuf->vlan_tci

Double VLAN pkts	Outer tag in vlan_tci	Outer tag in vlan_tci_outer
						Inner tag in vlan_tci 


Does the above seem reasonable and correct?

My one (minor)concern would be the handling and placement of the single tag
in the QinQ case. Depending on how the hardware treats a single tag in that
mode, the data path may have to pay a penalty if the HW takes a single VLAN
and places it in the "outer" position in the descriptor, since it needs to
go in the "inner" position in the mbuf, necessitating some conditional
logic.  AFAIK (subject to me actually testing for confirmation), this will
be the case for our Intel drivers.

/Bruce
