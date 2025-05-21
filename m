Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27654C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:19:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B6C6410EA;
	Wed, 21 May 2025 11:19:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E304340151
 for <dev@dpdk.org>; Wed, 21 May 2025 11:19:05 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L99AUS016910;
 Wed, 21 May 2025 02:19:05 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr0k3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 02:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfOzSvsEAHCGFR/JL7gJjwUQNep/GbXGmBkRiRqQAbSJAjMeqv5+3f9Fxy4jR9fLHmHiN95YDnCz4JcGFpAgv6ytYpGs8mW7sp699M+oJIpPNcRgToMaW4uRDOX2zurZ6JnpeqkJDZutP5aTyx8tOp2jdj+erH0eMCiV7r3ubPVWXda4sA8p6LD/qSrwUrD8919h6fDBNd6oYIro3HvyGDgv7ww0sNNKxWGFhCKLXSJvKtlOWJG5Pkg8PZcUcvTrIVSgNK280an0pnjhfyFKn/iFMY+LdNv+et5sxSQ3bqxa4chowpAQw0BdnIluJ6zmhXkQhoVFQGSR6SkH8Y+SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6nqeTwaoiCBpPvamulbm1vJao6Q4ThBfAIv+ck+LbY=;
 b=jiC+bKRU10idh78P25uvSOnyrbFY382PF35xUN4qqBvwQ0uJpX7esh3sOwekqVzw0Apg6GgJ63XTWIZWDt1zvqhbzeWVJnoG4U7nptBvicepwTkhe5n4e+2hGSH1oUUR9hniehljuNvBj0qPzg20+1WZE/XTYvmIcWgNZnvn1axZkvpt0/LB1sOP2le4NbtccEog5FkFudCEMhm5AvARjYADmJQWC4pIpYi5/ky3r/kTm5e9yNluOCSMT6kpf2pc0p1pP3D6OcBsxsOLNWvn56IwpGTWVgvX7luQB3jckiUyIkDA5zQvfsJGp9YHzyUK3vD6c9nczP1x1UwpmBc3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6nqeTwaoiCBpPvamulbm1vJao6Q4ThBfAIv+ck+LbY=;
 b=TuNmmZC4f9286q2ID8VrqlOSW0Gdr+DCL/R0IsKqMRToOZpk0s9xXPx0/F4T6lEE7SW1aQ+E0TUNCcmmSyNKNIqBiCWBVFLvKP0M0jtQciLytfTSBq4cIk59eptxPGJD0171TAZuPlC0IRXR5Rpm9SIDjUM/3aRF2E+Ho1Km/NY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4319.namprd18.prod.outlook.com (2603:10b6:5:39b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 09:18:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:18:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>
Subject: RE: [PATCH] crypto/virtio: check for invalid IOVA address
Thread-Topic: [PATCH] crypto/virtio: check for invalid IOVA address
Thread-Index: AQHbxW/SPfLIvLhjDEyymGBsRivwN7Pc18EA
Date: Wed, 21 May 2025 09:18:50 +0000
Message-ID: <CO6PR18MB448477B8D63A2A80BE5820A1D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250515080313.1612-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250515080313.1612-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4319:EE_
x-ms-office365-filtering-correlation-id: 40540fb7-1854-46d0-f701-08dd98487fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6b6BKL5Be0Oo4GViHC1VFr0X+mNwG0tr2TSFbelojncuhFDW6Mkj0lkgcQ6G?=
 =?us-ascii?Q?D2jcvnMG8EGJb5ZmbEvFebVCbQnwfqcRG7K0/lS/jB+LRXeYcbyME/Leq5ki?=
 =?us-ascii?Q?a/5/eEtbnPwi1QJvW+5Xa8jnpPiYMPrAayW/RlRC0V+Wx92vCnsNcDgwYsAo?=
 =?us-ascii?Q?Bikewd4ZYG79SRKK8Ur6Raz5xWnpDgNTpPILHWYdkKwFjIl+qtmazbRKJNUz?=
 =?us-ascii?Q?AEfbilBUYh0//mLNmJosVn4fC8sET2YC74unqkC7ApkwnjB1Cex2N0pa52i3?=
 =?us-ascii?Q?z3js3ziTiCQ28T5PCfuS6aNcuTkqoEuetA4K2OJKB2ZZSPAU+vE3c0etmPjp?=
 =?us-ascii?Q?ILMzUNwQO2BkOkGF6zR08zHuQx5ojp1PKmo7lZr+syy0BF8CeA45QoNvnYt1?=
 =?us-ascii?Q?iJnE8BDfE16R46oJ7US2e4HWkUBfxptMjLh866aLwzvxOPFCwxaoPl9TYpcv?=
 =?us-ascii?Q?fzBDYG5LjSZwsQKdRdf/e14l2JTcq9zvO0EWbTqGrIkkNdZMoa8eODq0nztm?=
 =?us-ascii?Q?aSrE8q+q7/c92uvd8QrKw/kdnW80vW+FD4OEYRlbq6amvcCa30eZ/MLObQnt?=
 =?us-ascii?Q?6xfYt/qvob8n13iExvoOPIqpCQj5gdGjHLvbIkUm6ZTgM17ICHXDZiE2oLWS?=
 =?us-ascii?Q?fCAXCZwBjzT471hrrQhJZErZ3UfguhR/SOWhe6KwMe2flhee7q3RUTe+g1X3?=
 =?us-ascii?Q?siMBojO9dLt8UOhu3T19pfo6ogvp0I4gEBWZjtdOVHA+WOPknOZz8053j9kb?=
 =?us-ascii?Q?UZsjW7dnaNQX4EO8I7WuJ2nD+AUSAV47efImiAcejWaIdQlRAFFydx9uk3wy?=
 =?us-ascii?Q?oEIY+XAD7udJsP1Q+Pb4RW+X9GZEufEQiL1kNsDVOJDq9mqiJMWG7sI3iGNx?=
 =?us-ascii?Q?RsZcyeYbEraS0FsRi75dDsexr1/2r9ps0gHbT6z0gKpAeZUHK551GUJpITbL?=
 =?us-ascii?Q?QN87+HzWUzTRsjQdVsxKRKum3EPQ/xS7s4hPeQO9HQwj+wCBfpBFlhUY1l8m?=
 =?us-ascii?Q?lda8LTaHpCrJqPhDjXImixAfdxY5pEw3FE4qaInUMo06GltKekcabTj4+WiG?=
 =?us-ascii?Q?yzdyoZ9NIsNLhYMtLi4je7B5yIBUzq6yTKyTBSOVQVOg1+qdj845lfwP9HtR?=
 =?us-ascii?Q?/V7Gbxv7JttAUWyjosyxS5YU7AEA3FgKNHVTix77/E+TejRty7br1Y6gDxgb?=
 =?us-ascii?Q?M5dFL3SYLb45D3XTrYRBjCJkUiUp9iI0yNaK9r3ao7BGtkauPbinT0uwow31?=
 =?us-ascii?Q?4CUQG8R374lKv0cJayCI37scJ0ZOYKR1T6RyPabzNJML76QLBOqTCMMamp/x?=
 =?us-ascii?Q?Yoa0GkkgWeDfpx3QRGOLReDfIq3JZUWOWfKdtXdQpFzzV03rvSPYTm9G4we2?=
 =?us-ascii?Q?1I+f30clTT4HljCQkWswH6+aBvkRlPrR3xZWVLR8SFIT0zhImHNc8OmG6spz?=
 =?us-ascii?Q?BzEIqOm6lB5DrQAfvxKHUEnW2Jcmc3jOUlHJKMzFWulwCJ7ig2ljL+56Udqe?=
 =?us-ascii?Q?wII6EzcmsOIlC/g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gaH5ghtlGUK1+4Mz1q1bgFj7A0OSTGTJ6Q8e0xIueg1IWmOjMEr2gCpoZ+hN?=
 =?us-ascii?Q?zpzHAiPAHn4JlX+xuFGQXX5ylOFfHxYSldmvfx0ywC722Hx6wsDTbXpBXaEp?=
 =?us-ascii?Q?/zSyIlvW/K80ZWgnO+R+NtQ/APpGJ1cEcjUZVmg90oS7a8vhQJYVcQbOSQ8t?=
 =?us-ascii?Q?Y/lHg5weYi6A29yQzgkcsdd4w1zQhBmfUTnRPaWnnrSnAsh7nJTYtyy//M1J?=
 =?us-ascii?Q?6kZyidgyD1Z63Q+HJCDHaKrd2ciGyKVUM7mPm3F8lhmqvoED/glZrBQAkViL?=
 =?us-ascii?Q?A44EWIYK39gSumpV8+zePwMcBsxpqqO5q6AYU2eslQfQmtcRggt4kWmjtBbu?=
 =?us-ascii?Q?V3Ds3r0YkdNv789e0vlIYrNSfaI2j4vob0RzBLFZvo42r5ppwWdXnmHZKuYU?=
 =?us-ascii?Q?MDYrnTIG1/wMufYzg0IhfDPVav7BBBRtdGQVUktIoUM4fi6dsmKeCFt9xGyv?=
 =?us-ascii?Q?uU2CVgGLc1u8ejA0WYdWiikGPQYz2SL1i9LjqJnWy+sSCPITdCihj3b2Dv+Y?=
 =?us-ascii?Q?DL8TyL+3DQx5kfa5/CHwKTZgSTQ5y30dZAZIykhpJXiV2w+wl7Q6l7LajKza?=
 =?us-ascii?Q?qUFU7szc7PQFQ9FmDMIeFLCEOpUOyCm7rSl/O9wrvy2qdZojTypiyN4bymT3?=
 =?us-ascii?Q?4aPAlypKtSqevg1+ANkw7oxEqMmp5KNlW34PaoqDDmLDrkEqf06rqim+SVBS?=
 =?us-ascii?Q?6y7AjczKieC6MPPZE6eCOAcIN3tGqSf8A5rGteRVgYFfwPBowg7dd7q/WiII?=
 =?us-ascii?Q?0uVfrFmlbOekycqVMbM0rYnLRXB2FU1KLuXXjjS9na7snlhNmM/QpO9Fi4sE?=
 =?us-ascii?Q?E9dIwsx6a+uO0mQ8usMAfkzVgaERj5IQp208dDgztoAI5ImZ1BrFRoQMxyIA?=
 =?us-ascii?Q?dr90eDs7V6n/DtXU3tAQkFGBn7N9FM/KvErkHoyQkNiFKm0NGR1k2S1UUBTu?=
 =?us-ascii?Q?rs3ntsy1pGlQ2XLsLxJn2XnvKUTE34mQKzK/2agWywg+qa8bcdaj5gYr6DU0?=
 =?us-ascii?Q?Y9ynx9wz1l8QFBIM6Jma7Ys/d6IYXiLsfPvovlCQtRgGfDD+NcFWEGbv0vND?=
 =?us-ascii?Q?zprbDxd+f9ymAHLfyaB2gS6Mog1LjCClsUE90riK5tenOTSk/Fh9MkF6c978?=
 =?us-ascii?Q?opWFaGOWUF+tGIjD7he+U7gllsrObv8jQE7CuJm7qHPN6gHY2i+dmpBaYzo9?=
 =?us-ascii?Q?EuFzVdBXYBhT8d0C4h9JDUly0KKOaWq+L/jraoBCP77SHTzsX+fN7OjR8XvD?=
 =?us-ascii?Q?NYSgHaSPbxKpoAPu88khJFN5R1xwW4pftJ8Jk3WSEnWOej4r4Zh6yrwomO3H?=
 =?us-ascii?Q?VO+YQKSkJ6n9NyaQeVvBAlDqjwhHFL3nC/fyoOwmO3d6D+EIHhM5DTfCEC0H?=
 =?us-ascii?Q?KJSfpdOYb4aiGtVFo1JqPoTqBtKdt0BGmfL0VT/uCrhEfYUL7++INlDemXgz?=
 =?us-ascii?Q?jRXqfb6quXSYDpFBosc2NyK0nDjT7Sgl8EOIRWvJZejDnFlbunwzoUjX7HQg?=
 =?us-ascii?Q?FqcYMyF57LdRUC8CiM6aOxg57CGpSqVezsbpz+L1fWXBjfUWRyeSoe47U8lR?=
 =?us-ascii?Q?bcy9I0/jkChqlrHTCa8pGo7AfGGvlDgvI0yLFm+t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40540fb7-1854-46d0-f701-08dd98487fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:18:50.6919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sn+xGn2WQymj1gF4lPZJkM1RFy08LbyLc6WTTtktVFY4Dm3Zq6zUWU586ht5N3yMNmLNtQpVZ0sH/NMlmLpM8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4319
X-Proofpoint-ORIG-GUID: Q9H0lrX0Ua0ohZFIs2FUWLcE5O1NQIOZ
X-Proofpoint-GUID: Q9H0lrX0Ua0ohZFIs2FUWLcE5O1NQIOZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfXwWVyqYGxkTHK
 f7rvAaU6hxiHV0TQapAnU/JEThBq6qr0EH7ve1U284SNFyk1K7wypZ+V4R0agU5qZvCZDhFABBV
 Q0n1/AhiCTJ9MfewotRrPkb2Q6rU6WNSBw8JdhwNKCtjX6guN5mZM3yBP+wB/rkvvZOKrAZIVC1
 7wJQH1I88PEF9Kh0OIkVhvK8hZsMfmk0IT6Osrqf2nNoGBd/4czq5pIjx5v+oDm8aQiMuRGeMdW
 Bs0x3fpv37BWVZbaXulXlTsG947j9rMYG6761uZO0sZL+3rNfNi84p/O1ahIY1nWpi06/5GmH2d
 9hlQ/g0U5ujuMAIxmkeQzX2laALgcRT0gbBUbOogokx+1DOXATBUe6fcIhQRh2ClWHUkszNAYou
 lfe40qbexlUsRffWqr3pkhZbGBQdA1ZueTt8+FVWWUtosxhh5f6WkCSSzH2779NJYSq2EJDj
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682d9a88 cx=c_pps
 a=OxY2RB2sa7x8oI2LU21LDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=De9dPgfj5IPThIAfTJMA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
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

> This change fixes coverity issue on overflowed constant.
> Bad phys address should be checked before using it in
> descriptor.
>=20
> Coverity issue: 457462, 457465
> Fixes: 10702138f1a ("crypto/virtio: support asymmetric RSA")
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: stable@dpdk.org
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks
