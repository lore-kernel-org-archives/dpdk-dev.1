Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F81D0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 14:59:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5A8840B8D;
	Tue, 25 Nov 2025 15:59:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D92F2402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 15:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764082763; x=1795618763;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=h0cRBNRDFEKflw41iKw+sotPp9AjxiqZZ429HIzC/s0=;
 b=ToKgwHHsPcaeRU7A5SAiENyI/B4LcLdsmGvXSzQhY03Yn6dS9D6BgXQf
 idM5YIyMA78ipChofqVdiqv9pS8neZRxxdz6jCsDetadIKiITYz8CBtpD
 mP2TjFGtpFaT0yhpLBSimfMdqJwQgp+Hh1850ERBZjVuXBbXhZ0AGRUrf
 HPISFcjV15QgUlS3TAJWhlVNyvlsWsa2DgaLG6bdmKT8agVtX8nzDhmvP
 TOp8plb10mOw9PniXrUyFlNnAYiD87QtrwNBnf1BmelhfZw6zzTKkk79W
 Tr7CBg/w797BSLZ0SjD67mjH2N0ZSQyFq/XaumZ+UelUeQtdsSCG2NKOT w==;
X-CSE-ConnectionGUID: d8DDijlcRRaePzv+y/zI5Q==
X-CSE-MsgGUID: PE56uZoORQuYbY0S/R5E9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65809845"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208,217";a="65809845"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 06:59:21 -0800
X-CSE-ConnectionGUID: dHSFrymBQR+Vjjn2g5yg+A==
X-CSE-MsgGUID: N/b3bTrOTvimGRTlWVJJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
 d="scan'208,217";a="196818756"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 06:59:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 06:59:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 06:59:20 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 06:59:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKDUGwvrO4f/J/8lIVIG2D+6enw9P8edv/bAo5Cx9KSfus4oL5oJws+tovhyOivu8Pq2vGZNaiRJHMQVhLoFUhGLG9CIp5RlH6YEdGf8YbBAoiwGNztMVG/ZzaSvn6w+CSFLjxOae5M1sQ5yCJE7CSxKksWsiyEQz8QNDOzpyhEPtcFvVOg18OGSj8sZA7Vmu2qNZbEvuVh6hVAPaIsIcQkOR23DhRNpfPeysGoAJ7A1i9OvhabMP19S3jisRY3tt/r1vvk3tmk/U+5u1QhSB/d09FFhGbnUJk3XgUPHxS+F0m+cP3bSxpHVeQjF/tWWhQfqABJdyxM6EXDUx8uwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkUXSB6yS955mlMO847n0qqWK0GmI2x3jk8bCNZk2DY=;
 b=Ecot54N2uz7IqMZcRBK0nb+s2aqDW+p4JaohtURZr9i+wy7pjJebxfa1uycVIl2H+x1pSlDQb6dQpSkKzUUsX2+vutK+wUi9wnWin3xRcIpoBX362Dc57t1YmpUadOZR4at7bp6EZcqSlfC4XjfjtFLltXM+QtRWYCbyQtGxAAYZm+Mbi5pwoW79p3uOW5h/c78617WLdGEJXLT5fdb/Fsb/gvvWGBSn3bM1fpNe8LHYx009LB9nDOYa9VYtC6VqXEmt0FPMsTts+axipVIFi7JHkcF2fhKkcFQAWWpDtQRBTKR1/e5gv0mqjH5iqnkRcDDpmxMEL1GSc7L7MbZ8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by LV1PR11MB8792.namprd11.prod.outlook.com
 (2603:10b6:408:2b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:59:17 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:59:17 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-11-25
Thread-Topic: DPDK Release Status Meeting 2025-11-25
Thread-Index: AdxeHAAgBGkE+FO+RPC5QHCyfKDhYg==
Date: Tue, 25 Nov 2025 14:59:17 +0000
Message-ID: <PH3PPF37F43E35D014D4E09A348CB49407DFCD1A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|LV1PR11MB8792:EE_
x-ms-office365-filtering-correlation-id: 9e2aaf86-606e-4d04-c751-08de2c3334d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wyrnz9FE2bP12PAr28nvW17maZmen6YKDqM9czTi1JSP/Oc579s5Kn/dsQMw?=
 =?us-ascii?Q?xOOpWOS50q8GwTNzvFzpoQdupgTL8JgsgF/eLHYCUQzUN8sRDQJLCYlt03bh?=
 =?us-ascii?Q?qjFgM/ypCqhpkyLDyw+QG97PqWZyg+QXQfhfxRkeowlWlVXtQTwMCMytPtlJ?=
 =?us-ascii?Q?154/wd37ta5EFSRJgoHWUHo/x9QfHCpsadH4mBJ7uglZ1j+Fas+bVdcjz8Z2?=
 =?us-ascii?Q?D5YiuaMn/R57B9dMMY3IeAlzDFQd7bYoxANR0SXIXsfgxy0IalePtCuORAz4?=
 =?us-ascii?Q?fSb11ZKkRcf14vWz6bQ3Zg+RtpBKX1U3FygDXSPhD2pVm0zILPnkslcpcUVn?=
 =?us-ascii?Q?6xObUwNaZn8sGIXrAuQxQLQk2uXYLr/IWkVV8nan9u39/x8ZGQVC0/SespNq?=
 =?us-ascii?Q?sf8xy4DxT/+QITPJ33+BD/HVIJVLfz/lhwyw9q5qJMZsxszZD1Y5MgzqzbhG?=
 =?us-ascii?Q?SNmbcg5mSJyIeQJT0AQQYG+nqiFo/1hvRvICOS5++w3vmK1EcAPD4P74AlGY?=
 =?us-ascii?Q?GEGwqDY0a5JB73Nrfu6YR2xg8r6eE5WUCk8YeCo2j9ALoFB3cGm1P1XnRFX8?=
 =?us-ascii?Q?G9ALEOyR1DuJhTywMhF6m7SamSgNEiLD2QSSbK5ERdz4MYz52NU89wyaOi/5?=
 =?us-ascii?Q?zyliApxy+LHV9q5u+XdhG1xybUuBkOyLQ7NJ5CrBuJ97ZJcmSbdoWCvinitA?=
 =?us-ascii?Q?gKMX6qXjJ2s9ydKIbu0awsuoCoJRpM+Cdh086JWyDv9Y4pukO6R5sdupMXc8?=
 =?us-ascii?Q?KcSjTm7kLcBBBEK6mLBAUSfi7/AiE04ZzAuqcel9a2PH3f+GQmFiBtPcRAgS?=
 =?us-ascii?Q?IFg2ci19GpKLDUiNZ8uwk07BzyaLtkwEDXDjKDxccFcBsxLWnb0/7CZASk0V?=
 =?us-ascii?Q?IyTsH3tNwRVeT6tFUrQjjmR9N7cMJdafGfpoJlT/LkTPmURHWuGYx8Zod8ka?=
 =?us-ascii?Q?OG3mph1DH5yuOXxtVz0tOX/LKz+wxZgtUjO270pK0bqHMdto+fQwW6bUUYmi?=
 =?us-ascii?Q?Eh8SIT0KasSP2+7LNNSLDPzi1nJU20+5FkferroBTWc+D2Ry0GNWLqAdyeDI?=
 =?us-ascii?Q?r/pURUiT82xgX1mjaf3f0Px8mlmL2LMJMf/qU7Av0vobOLlo1P/m3+uE6XKE?=
 =?us-ascii?Q?OjBqmwsSv40ZFqXat2h4vNkXbeSLNQYoFPhde9mUXpvHvy56/me/kdBadozV?=
 =?us-ascii?Q?8zguKuANgnNYkl74XVBDCRXPV8H2Zet2t2MgH4grkzI553RnVtIpaQpdwqLn?=
 =?us-ascii?Q?/rTqSdVhbEKqhdUWstWrxNC7PlIZ3SkfOm4Anuw8L+REUGzFok+gJC/qsxNA?=
 =?us-ascii?Q?wytbanp0ybvcR83Ntg0NV92M9kR3GckjKHiHNm0KUMY1f/NTsJ8I+YFlcLk/?=
 =?us-ascii?Q?Z1RbXnSFIFUzUTrVD1DJUgsc2wnSNzN0aBZAGicyZhcP/0APqjqnbrklS6ni?=
 =?us-ascii?Q?1SwhdC9nC/5tQ7PdkjqnI7pI4uuxPTvmaeYGhRG34jNk9vhp0dnnHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iysTRDKVlcG3fUKhiiSsHifzOpqwd+ZmHCNYAk/VB2v2rp8M/ce+OZaIEj6s?=
 =?us-ascii?Q?qwaQfgCiTrHA+UBHC82yP+rHfLzcT1r82JQ3ZM3CvLVmVa0TD45r36yACm1e?=
 =?us-ascii?Q?4XIToVXXeYJisFkFkfmpO5J0rfMAP4onzQ9heEaZDNOJ/YuLCuNOo1V1fYM1?=
 =?us-ascii?Q?aBb1gHDLU7sDRUvYyfBiImya/wVIbz8AlTW1rlfcliAFP7ghoVYD+Ni6hmWw?=
 =?us-ascii?Q?dkWDK8zfog8KQP6h9SanP+zT/h66MA96V5fVJ2OT8d9zGZ7bHz87DDmcwSKq?=
 =?us-ascii?Q?unDs42LGKQdGvW2sLqqcE/yco8/+a8REE5GF3HLHJ0myIPer7a7z1ESbzAfx?=
 =?us-ascii?Q?MwmWVZkpzGBW9eR6JszoQ0PVOku9AAR0ykdP82ZrB4PIyOT4CgsE4gwW4Dyc?=
 =?us-ascii?Q?rNq0VfH9dhcGB2VT6xi1ERkETrsmkK0WEJoRMbtwtKvY45Zosxy2L24Hdk/+?=
 =?us-ascii?Q?yFRkqauuNwTLYcxf6gMm9lYohZon+J0uVpOnKI0U3BJv5KVOSa2+P4akbtfu?=
 =?us-ascii?Q?Cqu4tjHlfoVABEh/N9op8aQRHvljnhzdcjymEUz1xGF4vSl6bYlOPAp/pdtz?=
 =?us-ascii?Q?2v/8OunlcezLCrH9rCUVMQ/LNo3DEIBF+etdqkalkVqQdlsECFpl0zycsU9e?=
 =?us-ascii?Q?1WUjfjVbVjQh9Ycbzu2mZ38gDdPo3gxg/nJOEAh01C1w4TbBS8VD9pwGnOGn?=
 =?us-ascii?Q?Dbzhf+PbFnYPNYcP+fEgcE89bHNxvjwllbPDVd2qZunZHpUhf56wU9VkcJZW?=
 =?us-ascii?Q?NqRaSGQYeFuX0+Yai2/6mYncuGc81T50VUE1MHTBPueVkthFu7xKFMq6k/mQ?=
 =?us-ascii?Q?7QDWczABw7/NFZG5+Xa940vqCzjUT3hZlez8xP0jCz0XMAfMSm4nHBny5rDG?=
 =?us-ascii?Q?DAlbuy5oVyCP3oyi95RwLfym/Cd/MQudU0bwiZFAwUSD+X+TzA8QOgC2zk+9?=
 =?us-ascii?Q?p5Cb1kGUqwHeJQfqEIOpgADlcBWp0+is7FNLOLRO/ltzeaDFMJdJHtByj1yL?=
 =?us-ascii?Q?Q+9WdJPlVm1DFmyXCerD1E7unbQ5Gn0hucZM+qGCMyH9cpD8x4H7Uw4hFNQP?=
 =?us-ascii?Q?RFGxkligDuH+TtbCXNxJMSh/p0xjHCP943fdpGbecOSDE4PdXioxzKcDGudz?=
 =?us-ascii?Q?IXeFxC84x8VfMjl57kAmTvdLFCmS8ApqaRnSNNIzg25yYnnGwTw8QQvB9Q+S?=
 =?us-ascii?Q?ilgh/mqnKtxuo1+LpBJwzTxaWn/8jbyiJtmA8nFPI38DU2+krKrNpOO1zIoh?=
 =?us-ascii?Q?bjsQN89jM6YWbbdpRrWEQEnJ9yaFSeYCZnB6nuxnOyqSb1lhvncNNCuXWUCx?=
 =?us-ascii?Q?RcrqqYXqiobzgRss2U1zTa3yXIQ5ufVLxOw7whaaT7VC+QET7PO9WZXW4wdG?=
 =?us-ascii?Q?QB8I9iXVQvuD77jeyGXbdA0ItYjoZiWC/LA0YTWMuQFq5Yf7JyCeDDoIrjgP?=
 =?us-ascii?Q?/Phe+e7KAOyYWpgVEqDQo4F1MD+mrKWF0oz8Rffggq5cWfXSzLyxTefuowNn?=
 =?us-ascii?Q?vo/1fdmL5a9iZNbATGmONu8PD5kaVHYv8UE5Tj1ahRIKBSelYmLe5jDbW+xl?=
 =?us-ascii?Q?+rYoGLuwtBsLOXFGhXZ9PrybwRjZMr26agyixNcC?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D014D4E09A348CB49407DFCD1APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2aaf86-606e-4d04-c751-08de2c3334d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 14:59:17.3956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EWbLX6ef2BYpcmqS6j+wLcaqqkoBjOQjpj6F5syb0SPKOLls4WnuAXeucVxsJRY2Ijkcdz3t1/iWIloDcqBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8792
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

--_000_PH3PPF37F43E35D014D4E09A348CB49407DFCD1APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-11-25
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
- Debian
- Intel
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 24 October 2025
- PMD features freeze (-rc2): 7 November 2025
- Builtin applications features freeze (-rc3): 17 November 2025
- Fixes and documentation (-rc4): 24 November 2025
- Release: 28 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - All merged for this release.

- next-net-intel
  - All merged for this release.

- next-net-mlx
  - All merged for this release.

- next-broadcom
  - All merged for this release.

- next-net-mvl
  - All merged for this release.

- next-eventdev
  - All merged for this release.

- next-baseband
  - All merged for this release.

- next-virtio
  - All merged for this release.

- next-crypto
  - All merged for this release.

- next-dts
  - Two doc changes that could make it in.

- main
  - Breakage in RawHide build (due to new glibc/C23):
    https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/=
Fedora_Rawhide/x86_64
  - Merging some dev tools fixes.
  - Documentation changes ongoing.
  - DPDK 25.11 release should be out by Friday November 28.



Other
-----
  - None.

LTS
---

Released LTS versions:

- 24.11.3 - Released 2025-08-19
- 23.11.5 - Released 2025-08-25
- 22.11.9 - Released 2025-08-19
  - 22.11.10 released 2025-09-17 for CVE-2025-23259.


See https://core.dpdk.org/roadmap/#dates

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


--_000_PH3PPF37F43E35D014D4E09A348CB49407DFCD1APH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-11-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Debian<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Stephen Hemmi=
nger<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 24 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 7 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 17 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Fixes and doc=
umentation (-rc4): 24 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 28 N=
ovember 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - All me=
rged for this release.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Two do=
c changes that could make it in.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Breaka=
ge in RawHide build (due to new glibc/C23):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/=
Fedora_Rawhide/x86_64
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;- M=
erging some dev tools fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Docume=
ntation changes ongoing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - DPDK 2=
5.11 release should be out by Friday November 28.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 22.11.=
10 released 2025-09-17 for CVE-2025-23259.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Debian=
 13 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 9=
 contains DPDK 24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D014D4E09A348CB49407DFCD1APH3PPF37F43E35D_--
