Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A412C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 06:21:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A85402D3;
	Tue, 24 Jun 2025 08:21:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0B79E40264;
 Tue, 24 Jun 2025 08:21:34 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NNUSdk004264;
 Mon, 23 Jun 2025 23:21:33 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47fgn8gna2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 23:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBMOTGKlL+fA3RbgMINmIGkER9bUZrnbd9poWZE1UAipPAdxlDd3wd5xmkB/xkS9bum1iRSBejOx9YfyXjksgu4dJzSbjfWgG5lMjooKarIK5jui9zmjDySWdM0nWv6wdIEiITq7Zk0kfZyhJXpRHP3HOZdgMqvZFRgg6b+7nzN01kQ4szLZep+yqjTDfrvu5lXQfGESNqqORxMuAclRIWRexf4RA+j9QNkKuSn80glDFQXo5I2vMmhZ1bBbY+3eJ+5UHCHFgTFbkO6aPBd/BV3Dm/Nnc8FzvZNNDLbg1JEwf3P7ZIYVpau0WzIGuIM4RESAht+6UEvldAtWCavhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhxPb3Es4G4x12QqTSw9X8VwDHzX3PQlz6Y1bGnsCnI=;
 b=n8cDPRheF2RhvfFbinnU1bOnYjSYJWFfPLSTAjLHLv7QGJN/ybO2bdHZYs98hmGVMslx9UJ4ilpkuzsf4+mrv7x+Dc4BRYGjj4Kj1rLi+vgRYjG0QItN8UXcP2Z5CFk0bWiq+XkufdTNnHYEqw9RFJM7ayUy7Vfxj6MhottCarmRVJIe8RRkRpOBcor2ukeE36eETcIQGvCAMtmin/L9MF3nWzA0UvKVLWT2VCxli/3ag1ByJfJHrxxIKVStKVeowGB+pCayCujszsEXOsXgnCOkKTQcc+r0wG556gxJvN2oWYRS7TbeSYXyrQvmCAWRRqWmyIXE5Sk4d5BpReVWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhxPb3Es4G4x12QqTSw9X8VwDHzX3PQlz6Y1bGnsCnI=;
 b=cJnV03nIw5bwO7lnxOY4M94RoX+f9srgzllZJNIU01I0NGCsBEeUPbziR2RcywoLq20ap07uUQI+2BlDUaH7bTtthmn39t2LIGgZNbpo8qTf+L86hLtRi9txSlWkMl3BtcSeTvx5KNIPI7bQGnCOJCIFc1Pn8bBsV1DFmKM8xhQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 SJ4PPFDC51F0310.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f45)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 06:21:28 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 06:21:28 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Pravin Pathak <pravin.pathak@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, "mike.ximing.chen@intel.com"
 <mike.ximing.chen@intel.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, "chenbox@nvidia.com"
 <chenbox@nvidia.com>, "tirthendu.sarkar@intel.com"
 <tirthendu.sarkar@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v1] app/eventdev: fix number of releases sent during
 cleanup
Thread-Topic: [PATCH v1] app/eventdev: fix number of releases sent during
 cleanup
Thread-Index: AQHb5NA3fIZuh8YTpEWmIVXRGpjplQ==
Date: Tue, 24 Jun 2025 06:21:28 +0000
Message-ID: <PH0PR18MB408634F09235215A9DC29685DE78A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250622181352.440499-1-pravin.pathak@intel.com>
In-Reply-To: <20250622181352.440499-1-pravin.pathak@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|SJ4PPFDC51F0310:EE_
x-ms-office365-filtering-correlation-id: 881d8824-39c4-4526-815a-08ddb2e75a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wWzKkeriWK5TDrzATCg8718eJQiUes6w4tTgfCM1zY38IMGajQx/kQxpuP?=
 =?iso-8859-1?Q?OTpEv3+iwe+G1AAwO97+lwv9d1XbhUGO5jIhlCvVUiQ88wzyLOAWXmZGqc?=
 =?iso-8859-1?Q?r0aSnCi39eMmbRNUDo8/zo3QZ/jiK9wfZa2SxDHa0jV7sDvcTDkPsnbPvi?=
 =?iso-8859-1?Q?9r2a3KhVqrWI83ovaMBKzvi3VKt75zyAfRDSTia6/u38rg4o6vLm3CY0ss?=
 =?iso-8859-1?Q?AYSHgyYm5sl5LrYrwMfG+twLdW+/nOiAF+2s98624oVAw8HsVbSQC2aYLh?=
 =?iso-8859-1?Q?242eYJ1T4Jg0rx2+Db0GQqciHmlQjnpPSr7ytLD9ta7O/FbSw7fANzIyzI?=
 =?iso-8859-1?Q?H/JDtPVZwBN0ocI34w5CeBSZD85KuDfVDpU+IJWIsmYeqQGVqODvLzU71N?=
 =?iso-8859-1?Q?331ZdeIFnKz2Wy5Y9kZ2LT08+h/qPqzo2ln1rmzR5a4pT0H3eVyOTouSUZ?=
 =?iso-8859-1?Q?M7AQHWAQS78GNyfG0y5At70kwkSrs0KU4sn0N1m9UakpSwwaTWq6zZ+Q6F?=
 =?iso-8859-1?Q?s/gF/Ii4/4ed1/akmV+8eFZvkZSaJH9HvyCU9d77eGEGxfyz6GmKkjdQpJ?=
 =?iso-8859-1?Q?jJxcL7iecf3UO6kFhJ29jiDYCQot9I44wdNyumgJ4gB6T9XplWpXtK9M5E?=
 =?iso-8859-1?Q?nJowyw3Xk+m38rHyhbZx2OGMj/xwSg/bYpMyUkoKRFF5F/g4KBoG3TraXM?=
 =?iso-8859-1?Q?emS7AEcNT/CI6+H3M+GZ9rY/tT7d9s9uPC8Do6qQ0l6sMCN/8LpJv3TCZ5?=
 =?iso-8859-1?Q?yF9Z+AiijU8S8+/+1zmKDKlcLFC0oUMoswkhuqRaVUNQGMiUZJK3nilgPV?=
 =?iso-8859-1?Q?rBVBXXxpDqBAtl/I0Gs+N9C6krOxI+Ad78HyonvsRUWZsiidp1kseU2NaM?=
 =?iso-8859-1?Q?97hrhsRPAzTZM7kXkKamyPTtIpVCBiLmDdtXPhBv5t2yddU4uDu/oIf2AD?=
 =?iso-8859-1?Q?4Ou5bk2ubtpT5eeFzCF7Hvsx4dy/PKwOc5mSZP3bN+gGUGqt1hBmodrGJ0?=
 =?iso-8859-1?Q?JhfZ0EHc+0Iy09hD4yWu2DGR0vKMnVeZPUeRplbJ/H5h05nkxV2J74grBR?=
 =?iso-8859-1?Q?AufEMB43i7MdKZZDyMqbHlV6DFOsfD83eL8OMq+a4OCAQ/PfRKtbb4cDEh?=
 =?iso-8859-1?Q?h43Sm7nJKrd5citVMY1WqXCd3NmcptuoeqsyGuO/p8G8tQ0v8hmCUnUyMH?=
 =?iso-8859-1?Q?zP3MHDp5vg7NlhMAgTAIUiKwJaP5WvWJeTxayUg0hfV1fRh6Ryt6Rn7QlA?=
 =?iso-8859-1?Q?tc45JXJXeXS9f06N6pP8kwTWYRQRvVRQmRN06y36gePxm/CLNGCcRBbtnT?=
 =?iso-8859-1?Q?uV8Vnh9Hsj5748xdIlu/i0evgZ9sbYSy8P1YgP84J0uA8dOyZ9sEEMbyHN?=
 =?iso-8859-1?Q?oCV2ib37lPwCdxLk+u3narumVeXkVnu9INUPMxj3XbilGC/QN7dXYevLQA?=
 =?iso-8859-1?Q?C8d0cYznOxr6MoCBrr9zJIHmTub5wTMrDX/LkIZZpnt2ph36/hYTM1JkMr?=
 =?iso-8859-1?Q?drmQcroVarhKgBIAUYtXOFs04Zxb/CTbLMqRZF2frypA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8p0k1WjOlD3H8CyVCY5naz1LnfP7t8ZGcK432TWtS3RR5ltp/vb3Q2vb3d?=
 =?iso-8859-1?Q?xkxvWklMxw+S+4lIEgTRyXYFtAo7CIqQhgzA70JtiBPpyF6aU1U0EW2Hhu?=
 =?iso-8859-1?Q?g/MWfG58kjKodjEaMNYsGaEkPh608fuHmPvd1Ax53+fTC1IuyjpwUikilK?=
 =?iso-8859-1?Q?YiCz9gcpgt6oirnJpl19aG5ofNpMohhvfMQZm3ubrs40G2DvZzMofAK3yc?=
 =?iso-8859-1?Q?yuVqp1shiqzNhYEmIBqhDj6sUHmRbkaWVts2x9+GNscMr//V1Q9Qm2utTH?=
 =?iso-8859-1?Q?/tA7Ep+cE/5ViXAdyv+EIdS3/m0nd7SXqx/7+Zb+QDClmmnN38ClpnVJHe?=
 =?iso-8859-1?Q?f+B8L9w7aJpPtndJ3m+kZjkRnYV5yg/9VVJ2FNx2Bq1uFrdle3FO/w0cdD?=
 =?iso-8859-1?Q?2gGlhN5AiMzS+bnWOYUsWAwdj09gSlzwyHFj03Dt9NKitUEBiRxwi0OtB9?=
 =?iso-8859-1?Q?i4lykTymwg56atBFFlDymk0L/IM3c8HAL6+mtBOiVaRdDPEA7aTMiPMjLD?=
 =?iso-8859-1?Q?YixxYqlVkZZ1XHXy0Z8lRtv0rre3jJRmBA41USafdRFywN+DiKlnUQ05IO?=
 =?iso-8859-1?Q?ktNNcbUIh37OcCqrpA9/slE9JVaTN4hVPFewNIjA3Umyx23OVSpeB8lLrP?=
 =?iso-8859-1?Q?m9hYba2RpF46GumTroeONiFcfymond+U2QHzhxqI5gykN2WbIa37mR8O7a?=
 =?iso-8859-1?Q?bhhY8lxFHeBOJe4el975hFocmLW79Q/FAbc2dyENaOWJopox0VK/ccfYbm?=
 =?iso-8859-1?Q?GK0tgLy/bVhWxnQLWyNxOwkfixjsJqoJM3piv1MaNvzJfVuR+DIIlIVDMc?=
 =?iso-8859-1?Q?YSPsJRcvaC2UpPQ2nycdE2PHq8qknNC1TK/oWWPyo6D/nE6bFyiY59ez8P?=
 =?iso-8859-1?Q?uxABjvq654cJsIziTb+TEYvobr8RIpdMp7jrWj1wRV8FfEnvV2oQjHbLtm?=
 =?iso-8859-1?Q?ukktkZz8q7AIg3UlNvPbJDOxELzET8hRL4QDHMmZV4CRk/pLRahECGV+bD?=
 =?iso-8859-1?Q?2DZ7qPExNJzApzGkiL4OcuHYsB58xuXXVpI8ihsTvcDslqNJHI7ihP7omL?=
 =?iso-8859-1?Q?eKAurd4TznpBfQXh/0MpHOU3B16LS/ATpUAWBmo5CcuoakHV9VUWoRqhHw?=
 =?iso-8859-1?Q?atGKkc5b0d3HxHexlWPVmWHL/J3CxvemYEJPY+1gEeRGYyENi0pCSyN2pc?=
 =?iso-8859-1?Q?TMaHg/y93Sh6zBYQ6uAdzIS0ZUoXBC6zKZIX3ehk4twjNV/Q82qSk2S3TM?=
 =?iso-8859-1?Q?li2AnfJ0cbJ2iBiUOjOvFmWYknSyEad+C97pXCHnQ8jya1SYqoNzyaE0gb?=
 =?iso-8859-1?Q?IA65vjk/rveRAZbYNbJ95Eh2/ntqe2b/7ly4L6IFr6ITz1ffUrgL7ZNEya?=
 =?iso-8859-1?Q?SWjuXGGaM5azRrApxgGzTI5emFeaSfQX9tWrrvXxmIqLmX4jHl94Qxe3Yg?=
 =?iso-8859-1?Q?aYpoI8L3/7KeTePAxuNSlsDWW/3uAjQU/I79jFh2LOsZfkwjeysXiprGHy?=
 =?iso-8859-1?Q?ONUhXk+YwO3Dtk7+vcK9lmGKCbPaUkUrMHuvYHTUnM7EA6wIdaDZKjBtEH?=
 =?iso-8859-1?Q?w9Nu/wESFEXtZBGWb++oGBft4PYi9Xcc83t/4ZIOfH5W7ZAV8kzJjRH4B9?=
 =?iso-8859-1?Q?WaMrl50Cdx/+dCYj1i/TA/cvuaAsIA0AUA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881d8824-39c4-4526-815a-08ddb2e75a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:21:28.0437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4VCsHS5j879ffNdntwStdEIVT2nlP8N4BX6nChBpy4mSJt0gc+1+T2j6Nad251GxmCe3OEFljDkm+CW7klKLQAfajIQHZ7/7Pswlt4nb38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFDC51F0310
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MyBTYWx0ZWRfX887N06ilDBHv
 KV3Bte8vLK9p3p4aABL0rkHpYj1uu75Gw6S9twnHPnnt3tNPgLDcyZ3U4sNSdXQhkNIYpQmGERo
 C62u4ElPvcim44/kwGHRjOoUD0YNvUIT2rs0IWmSJx0FUmY9bh0CuXaoY8caO0GL/mutwemirNX
 esT2f5TUKmHu6Epq2vlCOOP56aYkYT8LSvJSyFDvrKjXKYrg1BE9iNlJQ+Yfa+VvGKCfIZLTkwB
 nTB0wFLwFTsZ25503n8hbBANUlB43n3RIiNBaWcfcyT+7r+WmoNIl+/y/hgI2oXrG3VL82JVw9l
 4Cq3HImbXe/QI9DfhImGLhBPjw7NqkKzccZL12edz2RJ30klts/A+A2iKdDWvbWYjSnFKIG1Uuq
 cI7ZhPN4gGkwOCwUWGfJ75hVqwhZoJgC/pCSBTAI8Dfp77YcVX03NClnvIususJBTkP2rows
X-Proofpoint-ORIG-GUID: 6AiVdDvU2Yid9bIKjeXw-jIEEIZJE8L3
X-Authority-Analysis: v=2.4 cv=F8NXdrhN c=1 sm=1 tr=0 ts=685a43ec cx=c_pps
 a=pku/1lBvkZ+edmA4ffcYBw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=nLHqS3fdgiasAyqkL-cA:9 a=wPNLvfGTeEIA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 6AiVdDvU2Yid9bIKjeXw-jIEEIZJE8L3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
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

>During cleanup, only send releases for events app was=0A=
>not able to enqueue. Current code is sending releases for=0A=
>entire dequeue burst.=0A=
>=0A=
>Fixes: f0b68c0b2af7 ("app/eventdev: clean up worker state before exit")=0A=
>Cc: stable@dpdk.org=0A=
>=0A=
>Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>=0A=
=0A=
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
=0A=
>---=0A=
> app/test-eventdev/test_perf_common.c     | 4 ++--=0A=
> app/test-eventdev/test_pipeline_common.c | 4 ++--=0A=
> 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
>=
