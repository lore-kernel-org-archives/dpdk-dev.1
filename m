Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52771EA813B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9931740697;
	Tue, 10 Feb 2026 16:53:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CA81A40697
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738803; x=1802274803;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=p3xdAKQiZVnmfP712POFqXylCID4Rh1wjF8SsP2MiTw=;
 b=Kjq7riJ+qbZGhPFLW9hzuF0bqdFp9HrA/4lhJ+edsrsdJTCNNCwe6ok3
 chgJ3Yc+uWzyR098dD2wrD0kNqBoeNxzBzXTIfHn6HjAQOGnQE8LprJ5s
 Cnr4j7as7vEgDUqDHjMmjLnGn9MVIt/e5GAlVBmALuZRuirKmiP7IGPz6
 sy5rces7vVdGnttxuQp8xDthw3s0oHZphc3osyXBxxgEyRuirFokSemUf
 1iOJ3ftHj5bYa5b+VWcpFpHalRST0eNicNAt+SSD719q0Z+YqnLiWvfPf
 7bAwYc4UBDLUi2ipbd5szApp7tQ9Ovf3GKedPXoX0By3qjxhz74UHv5FG g==;
X-CSE-ConnectionGUID: 9jGOgesVTbKPUPeRAY/Pbg==
X-CSE-MsgGUID: suW9OOlJQw6QYCsh7Y4iSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82509046"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208,217";a="82509046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:53:22 -0800
X-CSE-ConnectionGUID: IicX9YkOTfGDcIM/585MAg==
X-CSE-MsgGUID: DJasLe9PSjmgR/3eO1hdjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
 d="scan'208,217";a="242579513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:53:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 07:53:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 07:53:21 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 07:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSMR5NHgsMlUHiK7tQooVwgwiSFMWrtIWx9mx9bVMGRWXN+nu3yl/OO541bt+XuQW6C73VExt4327iyX1JIAmGvWqtvYueRN9hmQDrgg8+3yUYPwkm3kS5wlxfNMOGvubWqQHfyrwFl9/icVRHbLJd0lJZEKq4ILqKexJP2Oh5pA9l2+qBYl1kqT3xS5TclOun1yRsu/R17kar8TbygU1mvtOY1OI86w8pCYnoCxtl0KbbWFpKLILSNX+6yNB7oVpoKW5E2wC8uRJ9rQuwFHbGdxR/FsXRw/YVULYMVT7IIRX8UNqCN5M5KTlY9qRg/z3QvNcJROoKYUcq4hfNnVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZxLQAZX+RZoClukV1nefYt94R6no0leoK4ELhmRzWI=;
 b=xWWL0+BQ3S61b/UxuYqroGdsZAkXUd9O0OWWrPVW/J3VMk9Wav5lQwNoPs6WqJ1l7Y7Ppqs3VxL0DuZB610G9xeWK+PmIBpFELYMTJhTWp+GlaUiSYnz4xrdvdg2zpT4yrIFOwBV6Bf3EKmDuAXydc2UzU8KPqPigiLsK7mhurFSIhivX6Yr1gp7qH46qpl/IQLBFD9jFSjmgqtZIo+iQiNYLewF9NHzdAD/qNNG9aB/Rim7eNqseYqhTiOhK0yQUw6+PuUb69gVjyXQ6/zFApy7hwfKzx+LLGfqjX7W3pJ2qA9PGkJDQIRYhHWgXBNZ80q/wMnK0r+djUZKe/YVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:53:14 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:53:14 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2026-02-10
Thread-Topic: DPDK Release Status Meeting 2026-02-10
Thread-Index: AQHcmqU2atNgdYLK8EOLZxSO+xUXIw==
Date: Tue, 10 Feb 2026 15:53:14 +0000
Message-ID: <CY5PR11MB631805CBAB01528BE0E34525FC62A@CY5PR11MB6318.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|CY8PR11MB7846:EE_
x-ms-office365-filtering-correlation-id: db95bfe5-709b-42f1-a02b-08de68bc7fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OMEOI72DFyPM+UBb6GDO0+WVYyHxe4KJ7s866hA1tul20hWLPNgtjFmMKm?=
 =?iso-8859-1?Q?j3j64Uy9maVs4yg2NiFHK0dRD244kly/2EQKjLcXdWWMRGKn6SuLFDgxR8?=
 =?iso-8859-1?Q?dwy5D7fb4b/HkF1+RR6yV+crAL9AuLgZ6qOH4gZIp5ja+tHL1DJzk4gMVR?=
 =?iso-8859-1?Q?SRfjSMjL6s8kau76p1B2QFjTCUx1uqTS4LvVODTbXv4TorhGCC8D3p6zwQ?=
 =?iso-8859-1?Q?huDtoe4lfTyqtj20rJPvhwPhrr6LbjwCxacsBcMOA9qu85c6IbpVoVRtc1?=
 =?iso-8859-1?Q?pjlz2eksdyd9SDgzJDUoyrHYiQYYbTluhNt0totx9pm+/NfkI5/pGnqLbu?=
 =?iso-8859-1?Q?bl5P2mIZzSPDUAzWdQ6k4Fcyh6aabzQejMrY2rCvnKIzO9Qt0kYI9RUEE/?=
 =?iso-8859-1?Q?jlyYrL4avHb5+xcuSaSDg1XeTpPvk7RNc28kUFP4tNLUtaBM8It7r1/B31?=
 =?iso-8859-1?Q?dp+BwbVU4YJ8ej+/U8sR1c2PabxTj4ICdgl+xmtTM2vma/M+2z5mX5jvMY?=
 =?iso-8859-1?Q?a7Rn2eCy6O4idEHIIsrI3VDjnxI8XQ0c7GyA4jllpRbpzUMPnA/c2usF2Y?=
 =?iso-8859-1?Q?1VHi8wyYTJ4CCGykYHzUe/X/Jv/Rsy7L2jf/GAjW2DMQmYIGFq0CU1QEZt?=
 =?iso-8859-1?Q?bsM/4od8W7OVIl1bwuUwzPqRUDejwZpEI4ljwla8Lecg+mEgGqwubMkQMX?=
 =?iso-8859-1?Q?Gnj9k6e3gdN7RizVpgFvHjp5wHUjB8UKwx1T9BFGZL6QlPyzW7kJs/0XET?=
 =?iso-8859-1?Q?onw80DG5Et5RVD23kmVAr0xMrMGR8eGrzRQDfQwAxHg3GVgYXh5yHLG2er?=
 =?iso-8859-1?Q?oF39ICpEiE53vN48jR3aTZX8CfyaZO67jawdBX9L9O2K41kB5v/evd25ya?=
 =?iso-8859-1?Q?Wto+RU3RM5XWhqRjsInKkrJlR0B4tTxOm4BIVKDtMwKM7Zrkei6hzTHzSa?=
 =?iso-8859-1?Q?4nj+rUp9tvs5dckRyu/BHQXhWITqSAfwNpdHSqHOqX+uKz3pxaT6DB8WJi?=
 =?iso-8859-1?Q?ATCp7OD/d+mKIWMMJTJkXInVxun4gX2b8qRiAVaQ6cawWClDnif2UoREXP?=
 =?iso-8859-1?Q?udNgSFsjSnVuwI2I2IxIZcbMGuBHurVKNtgv+Mh0CuricIAuJ9+7Os8LM+?=
 =?iso-8859-1?Q?O80T3OFzKaD4MGGk8UzKUX+iJQMmZOdhUYqGrCEnudph3bP8FNcadjsYXg?=
 =?iso-8859-1?Q?wy/Eaj+VvatD/21lTszvDWhjGy0IU57C9VbQLVWHtfoEa1O9u48OKdHwgE?=
 =?iso-8859-1?Q?sU2x1d4cGAL92a3hhCS+gNaphQAyDPKQSL9fe5w6ylna4B/+q+WZVgVXis?=
 =?iso-8859-1?Q?q8CGBm8I1TP7V22T7tDO2TCGh8Im46jw74JD1pixwkx6bTooA4amN3bE+D?=
 =?iso-8859-1?Q?XjU8HzCDrq8TPbpJfyKI8YQFwgpBIkNarFO2Q9TcRVdi1lnXGLEnIYMEGq?=
 =?iso-8859-1?Q?X6ypLQcBNdNhHgDyE5j0xNzXry00Wkb6u+1YwxxJk9GjY8CfHgClUZKTte?=
 =?iso-8859-1?Q?My4xBq03U2xk+hdwLZT+5oGqgEjxX5VfaLYTIrpLF2EPb0V0t4f8BIi4Yl?=
 =?iso-8859-1?Q?GMvt+NrjDWyh72dobQnVgSKGkn/tD6mtKgPs+S99lDlbvlMYeuAXwliIaN?=
 =?iso-8859-1?Q?nYukcSybuEj8hno8OaMO6ajJcyKQVR9jKy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HARtIDa0tG9DdlHtyq9HTtzjVPbQGSNsYuMIeM4GGsjrKmyC9sHqe0V2gW?=
 =?iso-8859-1?Q?uWP0U3InZXsuOpCsWMioEtk/WmDGCX2c2kKiIvSPY4ioCX/yKS4gs2imZN?=
 =?iso-8859-1?Q?+fdGWCypzXwjJyORbxIwSEVHe4FsiZL+W1m2NGbnj3uaOFjNVfVpBTsSWA?=
 =?iso-8859-1?Q?2ncyj7AKHk4aMyAwjzWiLDa6AXsMa+SO4W8Kv4zRfYPBQhKLvqK3YQcNgE?=
 =?iso-8859-1?Q?m7Kg8dWc82v2tbCaTX0ojG60TCX+fO0VlNLgvrkEfdxI4dZfa9cRNWtSJk?=
 =?iso-8859-1?Q?TFXRLyhvpEEV94n6lyNES0HIRETSfj0iGkJjkZmpR0Rm6iX6Tv3ZFm/Kvz?=
 =?iso-8859-1?Q?W9rs9ukZDp5/TzmNuPWMrO8cQOSeZBNRcMAYasT2JgHoHdru96O9bznxMc?=
 =?iso-8859-1?Q?RVtYtBxdpsRHOpYA0mLuagklGbGoieCI50Nk1C7LI6p5WPYFfuE8lkk+zj?=
 =?iso-8859-1?Q?wOHHPqaYqoiD2NZcny20OD14D96l46FCde1W6GN+s156xG51USTNvNOfcz?=
 =?iso-8859-1?Q?g4OBjei40UsjEp5RO6cu1RqBsqrU2HCVYGzd1psCVJIgmsumY/homl3lVO?=
 =?iso-8859-1?Q?K2bdGSQQZ5s5l3pYEmVlNFU8r00sxcm9SZLZ9RAN+wN8DWNGStt+vWO9QS?=
 =?iso-8859-1?Q?4TpSM89rmU1bd+oor5vDSz/55reymIS1F4/jOGBHJs3rkKtFojLbllPrJ6?=
 =?iso-8859-1?Q?idzU7A20WzAQpDb9X0QSBS1OS4yCaDCQ2NPV63NKqdomFQKIxnMZoT6+B4?=
 =?iso-8859-1?Q?+m0Gr6aX+SXtSI8nCes6fTUpzant/5LGfPYD1BuLnyazzJwPDm/t9xw4rE?=
 =?iso-8859-1?Q?Y+lYgvl6ekWM2KFEqUPKkOGOgmlXdkWqY8Fbnhse3MOqjXVhe9f7PhHvvr?=
 =?iso-8859-1?Q?LzqefFITsOEPxJpllmKVZgqrkK8bUADZed0XDOA9HXi9gECW4CBTO999dD?=
 =?iso-8859-1?Q?Ys/LANuWo4Z+/LEABnOTV6lNp0EFafTuG+9cA66g1mc09EPmUyeQqvOGLu?=
 =?iso-8859-1?Q?1hGU2Bf1+XgVpYPXbyr5r1tgd7jpX1QLG5iQZZsPfNRKxTdozZGJFJQenG?=
 =?iso-8859-1?Q?MpeLo7ikbbKaV0jTZuzcsAT9RCP31jy74l1ElWPZHnA+IkXEbuF6m/Sfq6?=
 =?iso-8859-1?Q?yoDONUVnNmDJt/bCjQOPBaog0glYfP6YK2Lfd4FP0VmsulMsX5byKeQy2X?=
 =?iso-8859-1?Q?30jGMIcG4ULtzAb9nf1EsoaqP4Or5Zee3bNVbhoi+xAyAh8LDnLGeyzEh4?=
 =?iso-8859-1?Q?fROZ2YB1WQaoD9RajmoLFqQYtw3dXsiT7BEOREj+WSGEb6j1FEhXi4YQJi?=
 =?iso-8859-1?Q?B4cQvt3JBH22Hgmhs/27XHh/PiCzTDaykr13SWKhoE1qEvT24eBBlY7ykj?=
 =?iso-8859-1?Q?IfZyV47Cp2afqLLpqJZHCajZDR64bqhy53jIkjesSNd01RicpaOP8Ntqtg?=
 =?iso-8859-1?Q?8w085GbR3T19Qo1LtX6EVea81le4yYRX3f6J7QH0rmieTa9/5y1+Jc+5Lo?=
 =?iso-8859-1?Q?1OCsQ1Mt7nGtwon6Zr9Qixnavkv1uc/B5fvFGOgyVeMhJJP8TDsKHm9A5M?=
 =?iso-8859-1?Q?IpoteYT9IbkDOoTDUap6X/IDB1Y0lbzTmEK2qa/wVpa9fMq3HDIpkr7GtR?=
 =?iso-8859-1?Q?0M1LlhLcHm0nva/VIaEWm/VpzaeloHQ/uWSYezC+XGOFET8RZLStWgLxaP?=
 =?iso-8859-1?Q?CyICAK2IRRPGtXAsrcSvrG4hTwX+YwUpE66HC2mw4GfbhZRA4zhtOuBdgc?=
 =?iso-8859-1?Q?qZw4llINwuJCZ6xkeMB+W8B9fLxzTnPaqZcNr1MBlwnfxTSHij7QJPk/QQ?=
 =?iso-8859-1?Q?lD/Yvax+Fw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB631805CBAB01528BE0E34525FC62ACY5PR11MB6318namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db95bfe5-709b-42f1-a02b-08de68bc7fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:53:14.2036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM919mN4vrOwpsYIXUku1Or+8YCXXNfpeatdCLpTjSegDnjoVnUZUFPAf6lFJKe09oxjb67xs0T1mywFlO3CWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
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

--_000_CY5PR11MB631805CBAB01528BE0E34525FC62ACY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2026-02-10
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
  - 39 patches ready for main.
  - 44 patches in review.

- next-net-intel
  - Pulled to main.
  - 74 patches in backlog.

- next-net-mlx
  - Tree pulled.
  - 10 patches in backlog.

- next-broadcom
  - Tree pulled.

- next-net-mvl
  - Merge in progress.
  - 20 more patches in backlog.

- next-eventdev
  - No patches.

- next-baseband
  - No patches.

- next-virtio
  - Tree pulled.
  - 2 fixes in queue.

- next-crypto
  - Some patches applied.
  - ~ 70 patches in backlog.
  - Zuc and Snow 5G algorithms introduced.

- next-dts
  - Some patches merged for main.
  - Some other patches under review.

- main
  - Merging for RC1.
  - Looking at string overflow/truncation patchset.
  - Some improvements on checksum under review.
  - Unit tests patches merged. Some random failures.
  - Mbuf and Mpool patches.
  - Will try release RC1 by this Friday.

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




--_000_CY5PR11MB631805CBAB01528BE0E34525FC62ACY5PR11MB6318namp_
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
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
R<span style=3D"font-family: Consolas, Courier, monospace;">elease status m=
eeting minutes 2026-02-10</span></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Agenda:</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Release Dates</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Subtrees</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Roadmaps</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;LTS</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Defects</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Opens</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Participants:</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;ARM</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Intel</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Marvell</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Nvidia</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Red Hat</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Stephen Hemminger</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Release Dates</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>-------------</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The following are the proposed working dates for 26.03:</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| Date &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| Milestone &nbsp; &nbsp; &=
nbsp;| Description &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;|</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| --------------- | -------------- | ------------------------------ |</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 5 January 2026 &nbsp;| RFC/v1 patches | Proposal deadline &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 9 February 2026 | 26.03-rc1 &nbsp; &nbsp; &nbsp;| API freeze &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 2 March 2026 &nbsp; &nbsp;| 26.03-rc2 &nbsp; &nbsp; &nbsp;| PMD features =
freeze &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 9 March 2026 &nbsp; &nbsp;| 26.03-rc3 &nbsp; &nbsp; &nbsp;| Builtin apps =
features freeze &nbsp; |</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 16 March 2026 &nbsp; | 26.03-rc4 &nbsp; &nbsp; &nbsp;| Documentation read=
y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
| 19 March 2026 &nbsp; | 26.03.0 &nbsp; &nbsp; &nbsp; &nbsp;| Release &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;|</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
See https://core.dpdk.org/roadmap/</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Subtrees</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>--------</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-net</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;39 patches ready for main.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;44 patches in review.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-net-intel</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Pulled to main.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;74 patches in backlog.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-net-mlx</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Tree pulled.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;10 patches in backlog.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-broadcom</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Tree pulled.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-net-mvl</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Merge in progress.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;20 more patches in backlog.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-eventdev</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;No patches.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-baseband</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;No patches.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-virtio</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Tree pulled.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;2 fixes in queue.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-crypto</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Some patches applied.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;~ 70 patches in backlog.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Zuc and Snow 5G algorithms introduced.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;next-dts</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Some patches merged for main.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Some other patches under review.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;main</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Merging for RC1.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Looking at string overflow/truncation patchset.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Some improvements on checksum under review.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Unit tests patches merged. Some random failures.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Mbuf and Mpool patches.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Will try release RC1 by this Friday.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp;DPDK Summit CFP is open: https://events.linuxfoundation.org/dpdk-summ=
it/program/cfp/</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Other</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>-----</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;None.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
LTS</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>---</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
See also: https://core.dpdk.org/roadmap/#stable</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
LTS versions ongoing/released:</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;24.11.4 - Released.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;23.11.6 - Released.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;22.11.11 - Released.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Older releases:</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;20.11.10 - Will only be updated with CVE and critical fixes.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;19.11.14 - Will only be updated with CVE and critical fixes.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Distros</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Debian 13 contains DPDK v24.11</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Ubuntu 25.04 contains DPDK v24.11</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;Ubuntu 24.04 LTS contains DPDK v23.11</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;RHEL 9 contains DPDK 24.11</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Defects</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>-------</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
-&nbsp;Bugzilla links, 'Bugs', &nbsp;added for hosted projects</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; -&nbsp;https://www.dpdk.org/hosted-projects/</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
DPDK Release Status Meetings</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>----------------------------</b></div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
status of the master tree and sub-trees, and for project managers to track<=
/div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
progress or milestone dates.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
You don't need an invite to join the meeting but if you want a calendar rem=
inder just</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
send an email to &quot;John McNamara &lt;<u>john.mcnamara@intel.com</u>&gt;=
&quot; for the invite.</div>
<div style=3D"line-height: 19px; font-family: Consolas, Courier, monospace;=
 font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_CY5PR11MB631805CBAB01528BE0E34525FC62ACY5PR11MB6318namp_--
