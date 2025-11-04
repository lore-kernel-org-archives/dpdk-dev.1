Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C99CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7903140651;
	Tue,  4 Nov 2025 15:47:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A83D840613
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:47:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762267657; x=1793803657;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jRwvJRRIc1JOduXTyc2bSqlvW5R1y6YuUEo+r3K/sos=;
 b=UfNNxCql/XOdUiNFTZOU+MUPiHs7PfW8OzshKKOS53cth/ssmA/XacOh
 B2MEh95cswJ9ZEoKsiZ0fBhOScJoINMpKfn66Huy0NEjFl3ysN71IBKq1
 T7x0HR6RnegQCZkl96pDxvlcy5AZdT335u9sxWYtTtwnBc2RMVcLa7fnv
 BePrRPdllimEclUy+2wmC639QXe94u59/CywQmr7pTNiOvyYSE3+pft80
 khgu6xGdmU9nLWn0PueWKA7vKpmYIVFQ3cf4JNhgsMfWonSJc6eb8HRcy
 u4UZOAsL5k+hJ2LNiR9f7+xkr1MmjGtJGzjqPzfESAQ6BHhI3dSZ3Hx2U g==;
X-CSE-ConnectionGUID: Sh4gly0wRyaQwRKv3peHOw==
X-CSE-MsgGUID: bKzzrVO6T0KrYQbCNGpK8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75042356"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208,217";a="75042356"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:47:36 -0800
X-CSE-ConnectionGUID: 5QdpCk5iQeugl3SPIgOFPQ==
X-CSE-MsgGUID: UuARS0SjSce6yUqEQ5rbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
 d="scan'208,217";a="191480961"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:47:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:47:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 06:47:35 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 06:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io8hxl8YwxABEgv+ffTRwXpyz9sIY6BZPGfhErFl1L5D8S8A48P3vMoHQbWD4akhp2mqdmwrzI22OBYreEgF/XbIDG3j7vS5u2zMgrfqfzTeH8tVvf+W+1NkoA1bzxYDMNeC3P1LiHyAxX9+5Gai1+BNrINu7WywLYLu7+9Jp78YfTg7WYrb1yMCERfqug7uunL38//GJwffxbtH2Q6FI8STX4yrrdfGgbAB/VjtVXpqEt5nbiR8T7qGgc2xPL0LtGfAr45o9dn+CgsykOG6Dwxu31bMNs9TNilHhsx6f+FQDcK0VelHmbQqQQ1g77EUzM/ecGu4xSJS4nmQU0Iesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWIX3m5MKk7hwVqVMPDCbEQ2wsutvaYN5ayofE8Ap0E=;
 b=nMT9+8iklZw1YT7+cML+6K5QyFifLUKIte4KbZLkQa5pPYYrUndds1LPyIZ+TjtZcqFaji5kK4n4dyJ6RqtRgE5x5TwHmtKlmBKib59pEuFp51t1i76T1g8nMf8TXk1EXFxjRtxxeXFqxwadvz1GesFJAKo51RmaDd+yaBprFPXD7rqrCxVfql9chV5QMSPb/OJlVXUSTNTvK3K1SjIldPfxjXhGpsGrtvkvFoOaSSA7mM54QQzgEukLZMUhhgvFwFVxisC/6AhluCogcODKpDZhb+miHXpYKl56mtEVtE24/84CErLr7Of6JVigmsjDa0sUZq/bPl0Rn9zrJhaLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by IA3PR11MB9424.namprd11.prod.outlook.com
 (2603:10b6:208:583::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:47:32 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:47:32 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-10-28
Thread-Topic: DPDK Release Status Meeting 2025-10-28
Thread-Index: AdxNmd/ymnKObYfyRSmeUMmlyh40FQ==
Date: Tue, 4 Nov 2025 14:47:32 +0000
Message-ID: <PH3PPF37F43E35DE638DB371AC4FB51F551FCC4A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|IA3PR11MB9424:EE_
x-ms-office365-filtering-correlation-id: 1fe8813c-c614-4c47-1719-08de1bb115c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MhoVvfcp0/ME97NOGIv+7bEoYqGelLfbKqfq+iJ2cpim7qMMmvb+irSCPjUK?=
 =?us-ascii?Q?W1LiHLjY8V1CXhCo6WRllkTtvp9fmAWvjP741FiCR2OTjh6mfuG8Db41A8Yb?=
 =?us-ascii?Q?kwyeGGGg/Mu2JI00GLy2UbacVEjtGP4EJMDpy1nIt4Yuk91e5v7Em8KERTOR?=
 =?us-ascii?Q?5Q4mEojbe1VkclFhRfi5kn19pAK3312GwqA8lZFESV8Xhfl7VxQEvUxU6QIk?=
 =?us-ascii?Q?tZnNL6xwYQ1CvD2kjK1PDmBsAXkksd9iPlrSD9GccDOvd7dKgyTL/YA18BXh?=
 =?us-ascii?Q?UQkz7/ipT5PWjlmWZUA58dCN6ZEd3Ke8mHnhFTTvqEOpOMHyg5qWhXdSPAD/?=
 =?us-ascii?Q?jIXVSgNYw8/As5O/Z9+BXCA6HbjuWw/D9Q59sBDXLE6N/UfswZ2INfbeUVwi?=
 =?us-ascii?Q?VdDFO70K1dudPHARbfyqQ+MHpZ0FL5hU6snNsWLyeWtTEDD2ceGo3QmU9TXd?=
 =?us-ascii?Q?cFD419w7gjBta1/adzcKEtPsHcEnOqTy+u6q9Dxzu+0a10Q/v4nWlSdZX6ie?=
 =?us-ascii?Q?E9EMKNL4Y5sUG4VKGF/ZHKnmn2KKJDROF+qj/EmhRuh8rD7so/zBVG5NczwS?=
 =?us-ascii?Q?QVXYeqSjaU9vEl3vIynubRqqrhj5nIB9YEeJVB6pQ8njuQiEVni8okSZdwkN?=
 =?us-ascii?Q?gQRN7Ye92z1R4v3LMaXeltfZdgoVBkWRMoevCeoBDPZjAt6/4FWetEWeh1Zz?=
 =?us-ascii?Q?bao8+hT7LHRxpHXV7Tk25lwW+q5vvh8N2/OnRoVfMxsxfZJo+fgjY122SyWC?=
 =?us-ascii?Q?CkALt11XRHXAuWVWqy4On9lqzxTv0CtsC4zyWL5jFXXFqLd9oLvI3GOJBFLU?=
 =?us-ascii?Q?h4FLxXD+kl98oNh9AT4IIvJwbf902+LP0eI/S2GjlVB6WuTmxhTLQGPbonet?=
 =?us-ascii?Q?15Rh2gDKUc81wZHjf6mW1JLr1k4uAu6NZBbwashec6sNUEmkjoc+H3TFnHwc?=
 =?us-ascii?Q?2O8aucElpHK9mt8m9c8sWdwQUgA2Q92kabGKljiqjPvReEfsCKp3DdyUml9U?=
 =?us-ascii?Q?1MbE6eIhqPhLJ3Rbxsl1iBenKzh7ZZWRNieWR16TsOy0i86CCYyHUGFL+0Oa?=
 =?us-ascii?Q?/SOET+fNmrBOCHXX5jOMrza3pGau0t8CHeDFCd+op9mwrm6dw4bvgEclNR+I?=
 =?us-ascii?Q?ODt0RMyrK/rq8LgCh6WGHHpT0z/MNEoqKM5r8R/RjlG6veXTnnXVpBaSsZse?=
 =?us-ascii?Q?gYOgxkMgd/fzY2bXS8eLleIsRduBJrLVpvSKVR5OPgAuzogP1g7guq7uW+zK?=
 =?us-ascii?Q?qepbZw2HzpyDjRuHreEcBkwWOiUl+6x2K92DFcg5Gz2UxJ8MQbhpzUs37GNS?=
 =?us-ascii?Q?ZRIk+oGyMxlbbpe3a1+1XfEzZL2d6x9SSUV+n/sOPvw8JlurTeBnMnlC6aoR?=
 =?us-ascii?Q?/J41z0ZMlpBcRkAo/c9OepV2bY2RMTboNjbROZF7r+oLH+KIyNBnFBmgsaau?=
 =?us-ascii?Q?VrV5kKsBzAZfux8uz4rHPTCIJpWSu09a/SCM4gUfWZKazi4mC69R0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HzchZdQFkqfyu+cRfmmXGpJCTW/C3+3jTYBaXV9eCkj9T+6UnbK1oKLPuWU5?=
 =?us-ascii?Q?clpsLYBat0Et5cWnrDh/b+4E/Yu3hIIZFQAd6hKirxoD42zWK2WidoDlmM0i?=
 =?us-ascii?Q?9Nyfa2CkIUJynNxYLXCtuwSlfjpn2hRV1DsWIEydt03RWjD3XKI2a29r4mHu?=
 =?us-ascii?Q?yxqm9uJdwLEZ0fuNTSWAI3OOVk+Egdrf4aKqsDL6T9xiQ63aFZsjG3j9jayU?=
 =?us-ascii?Q?3s079pOCdqcvzhpJjoErBSHut0XKjVoAqvZ9hV+7KjPxTSzAoZ/OhdSJi1pn?=
 =?us-ascii?Q?g7VtbWWME3wwM/psHyqqEj8uwXz84BmW/iC5UgxujUNTj8XCobKYRPHkX0Ac?=
 =?us-ascii?Q?rroO7b8LjgjhfCdScU0XtIFogNdzQgJy9Qg5/yV1wuU/casoaKKitLIY1gSC?=
 =?us-ascii?Q?CbnF8XIdV4pQUOC4h1t0XHcl/8S7meUfXShfVqi45S3RLfgg9YJ9BT0dyC5T?=
 =?us-ascii?Q?EZdKSCBLnoWpM92VXlrtRPO9JS9p/irjoCG1IWc5slJzC8YNKTZCjG7w65pM?=
 =?us-ascii?Q?uwCQud3AXwXjv/PsXgBOn8zuJvnm8z8bTW9O1IWtYZwIvgxpOcpm6xoCwEZV?=
 =?us-ascii?Q?TUoW9AmBxAFnIEmk/fYSl2Pipd+kLweodePInwH5z0hmfHHwlJ0U9TkKgEbg?=
 =?us-ascii?Q?83frBspwnceBhWDa7fZRjBxiZ7KMIBR9xjFNih49u9sXN9RflOWsUnrGKpCW?=
 =?us-ascii?Q?FDI7YLOdHANSbcfcoczufQEUPIgj4B527xcrcO0Be+pjkRej/DIH20P2UHdl?=
 =?us-ascii?Q?6GWb/QA1Jrs4Im+Wj38KEr1MAB0NK4rIbIeblHNLcA20CBbZsHfEp/poA1ve?=
 =?us-ascii?Q?DG4h8h7PvJ9LVvMUUylktRM3VwyXtVFigKDbDtiC/v5jrG0VfGhTfDLyKMdZ?=
 =?us-ascii?Q?VJgDvVjVs4ASRcQecToVyOVK37eK40RsAKcMx7vzOGuu+ZrDjOKXo8rvc9tC?=
 =?us-ascii?Q?5BW1Z6Di9oCNZVGYr1jQ7eO5rzLk/7bfvl9iRIjpNa1Z8kKXQ39zYB+jJugU?=
 =?us-ascii?Q?ag8c2l2TdDgusnEdCzm1Ts1n6+t6OcxAKeDiCaNgSfAT6P7Rcsl8jalIWxTL?=
 =?us-ascii?Q?2SL4pF1efvt2A5nDHUY0jTI8i9B+ygKQk5zwpKQf7qo7gdYAurdw+jNPlnVZ?=
 =?us-ascii?Q?XhG+Cn9ETqGEAnlqbAFN7CYoH7ejXDwzrpD4wSw1nrZiNKQRpEPuiVWqrWEH?=
 =?us-ascii?Q?TIKHyWhKrEoNmeflyTD9l8nnR5GhyxbXiVdbrYjZRuLLGGx+ZdFV+hO8Oyv/?=
 =?us-ascii?Q?acyAsi72IpG+i/4alg1r4/PbHgjSFbRh1f5uKe/2/0yxqwZqzv4WR87MoY7f?=
 =?us-ascii?Q?zTC4RgMlG87RYOi1LapdUpB59lS4tkaliKLs/sB1tG1St86mh0vn6/ZNsTYA?=
 =?us-ascii?Q?57g5KMw3HEtRYQRm8yYWMpaxsN2I2Zf+tm4p9Rs+OSx+UIEEdhP4Ka8RY9oP?=
 =?us-ascii?Q?/rhbOi8zzgXKVolQOu5AsZXYyGpPyDLEuh2aWAJcvt1OonwuHIf4NJaKGZ6W?=
 =?us-ascii?Q?h+ld1cD2CX+bI47d4deYLg9ZefnltuoZNjjnxZNHqXcZMsHDN1CjXcsXbo2V?=
 =?us-ascii?Q?1JgNK5cO4wXIvSaY0nsE+sFyY/SMrWyLxJKgVm0B?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DE638DB371AC4FB51F551FCC4APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe8813c-c614-4c47-1719-08de1bb115c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:47:32.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJsbU1A/W2tWyHkZaOAI93B+R2hGWW6JSjRUNmsblHdMGp3qba0WCcIDtBDELYAHDfj+Jb0jvaFG4eIEV0ukZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9424
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

--_000_PH3PPF37F43E35DE638DB371AC4FB51F551FCC4APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-10-28
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
- Broadcom
- Intel
- Marvell
- Nvidia
- Red Hat
- Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 24 October 2025
- PMD features freeze (-rc2): 7 November 2025
- Builtin applications features freeze (-rc3): 14 November 2025
- Release: 26 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

- next-net
  - Merged to RC1.
  - 46 patches pending.
  - 7 to be reviewed.

- next-net-intel
  - 2 patches applied.
  - 5-6 in backlog.

- next-net-mlx
  - In progress.

- next-broadcom
  - Merged ready to be pulled.

- next-net-mvl
  - No update.

- next-eventdev
  - No update.

- next-baseband
  - Nothing pending.

- next-virtio
  - One fix patch and one under review/almost complete.

- next-crypto
  - 3 patches merged and nothing in backlog.

- next-dts
  - 7 series. Almost ready for merge.

- main
  - Some fixes merged. Mainly for Fedora 43.
  - Reviewing PMU integration in trace.
  - About to start pulling trees.
  - RC2 targeted for Friday 7th November.


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
  - Debian 12 contains DPDK v22.11
  - Ubuntu 25.04 contains DPDK v24.11
  - Ubuntu 24.04 LTS contains DPDK v23.11
  - RHEL 8/9 contains DPDK 23.11

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


--_000_PH3PPF37F43E35DE638DB371AC4FB51F551FCC4APH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
meeting minutes 2025-10-28<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Broadcom<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Marvell<o:p><=
/o:p></span></p>
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
cations features freeze (-rc3): 14 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 26 N=
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Merged=
 to RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 46 pat=
ches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 7 to b=
e reviewed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 2 patc=
hes applied.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 5-6 in=
 backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - In pro=
gress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Merged=
 ready to be pulled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Nothin=
g pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - One fi=
x patch and one under review/almost complete.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 3 patc=
hes merged and nothing in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 7 seri=
es. Almost ready for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Some f=
ixes merged. Mainly for Fedora 43.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Review=
ing PMU integration in trace.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - About =
to start pulling trees.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RC2 ta=
rgeted for Friday 7th November.<o:p></o:p></span></p>
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
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
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

--_000_PH3PPF37F43E35DE638DB371AC4FB51F551FCC4APH3PPF37F43E35D_--
