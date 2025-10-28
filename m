Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E58CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C111B402E3;
	Tue, 28 Oct 2025 11:16:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 78B8E4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:16:37 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SA0j8G207700; Tue, 28 Oct 2025 03:16:29 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a2ttbg9mn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 03:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cedB0JDAeuXXGKkad3koEOYTqb8m1f8+PBDTU8tAc7lGK+vufkriHpXDp1CYtaHvPccYsgqUUcUR2LgRpAZxYi0Yiv5Vgu36OxEHQNc4aEgastBmgNf8caXe+n9wliZOivVtPGUYwxreOmVqgLo6ktCb3TVG8IZCXA06Ae/nBvt63r8T1j6ZgeNMeqxodfKMbhrIZ3uqfZ9AaysQzzMsksJ+auABLKWIzlfl6DeW7BhTCkiKzeDFbLfUeC5lJR6dCSHcrWdn6b0+4m1IapwgGDLHZhVJE+nHmnDVYmMTerazaEgIWsPpnq2Xn5V3N/lop4dMMWKaix67UpV6km+nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECWxvVb6zEhgpwxgBlNrh7EDlJSd96hW7+d7Kdahmks=;
 b=AMcdtL95IO1hMzzhKw5AP1ABmYG6h9SzOk0iqhUfhJTYFHP3eIsVo0bzrETAEP/jseWc19k8eL7wyWOu9JWmPASxwK/I7ICO1ctRQJHGCmVjxUHg1H/OyKb2GdREdAon4tt88bpKHXB3451Wh6d7YGfxMLTNTz/tLdU7v6n0/dnSH6u4LT7WBXgfZAaGmjwRgasyB3VuJDwWbVwkzTM3tAUqFRg92BYe5GMUnN2oZCQCnAWNLh7Y2E3mEmhwjZhURbjKb/0VD/1+jibZovu0A15F4Ory41kwfl89x7dTDtAGvJE20RJfjtVSNiktI00EmBDh2LDyoSDZxZOXh4uncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECWxvVb6zEhgpwxgBlNrh7EDlJSd96hW7+d7Kdahmks=;
 b=mTSVvhGHkY7nBKnHCHyStsHGLJI8k2BKJ6hqSCcnQdz6gC/32mcLD10Ome0cRZ1yxzrKEJY5jiETDoZ0vKjCVNbyDUJOsRTDd9xSkMaVMry8FCTkYO/HnIdeYkU7VKKvT6nAZlg+8AUHhSh5geZ1eNT7q6/YOIuxw+au5lkQyfQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DS4PPF0E20B3A18.namprd18.prod.outlook.com (2603:10b6:f:fc00::a88)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 10:16:26 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 10:16:26 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Christophe Fontaine <cfontain@redhat.com>, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] graph: fix xstats description allocation
Thread-Topic: [EXTERNAL] [PATCH] graph: fix xstats description allocation
Thread-Index: AQHcR/OPwFqyvK5Qq0qtEZlStVidsLTXV5IH
Date: Tue, 28 Oct 2025 10:16:26 +0000
Message-ID: <PH0PR18MB4086C0C4F949EF9B456CC953DEFDA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251028101333.14776-1-cfontain@redhat.com>
In-Reply-To: <20251028101333.14776-1-cfontain@redhat.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DS4PPF0E20B3A18:EE_
x-ms-office365-filtering-correlation-id: 50281347-be5c-44d8-9aeb-08de160b0de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?33rpT7dAPOfzs70c3Zb4+XNRsRTDSGujh2nlKGcJ+isV9vqaDOgZA11993?=
 =?iso-8859-1?Q?mo93G4BQLNpOCdUfA/xu/STa4od9ESEkpagLib7yhUM8EBOIUzjFvSTm26?=
 =?iso-8859-1?Q?PPlu2Iw7fy4wRcRfQEU3zTd9ajxsDBjCJSpodIP2RoczaTxzHOuVPE4HVp?=
 =?iso-8859-1?Q?TqGArc2v6eNxvP6RnDoESg8ZLYbV1K9U2I6pjvNL3lmPS6Rx7h4fMXm4U/?=
 =?iso-8859-1?Q?mChCKsV/54kyqdJIhnFHs3Vz5bow+D5N8mqc+AR/1zC/pPcAQPcVSTxmSW?=
 =?iso-8859-1?Q?Vwqgf0hUjhRSpo5IgCT8GnOextF9NIG4leBcSKSCq0ANWh9eJce4pqwGI2?=
 =?iso-8859-1?Q?RCzImT0nJCnpyni8PQ6obIsT9ojMwLFcEvcT9FkPcN0Cryua/675ZTHzjH?=
 =?iso-8859-1?Q?2DOFbdhMtSOa77sXE/xW9uR6f6Il1lfHxQFc4TOdU4jPGU7M65HVDjGj1G?=
 =?iso-8859-1?Q?xtTlaqW3B5sI39lqxMv/KXVLMJTWCYS2q0EjvhFlJSDeQUXarWIovQlhdf?=
 =?iso-8859-1?Q?2TqyZAwBooM0u6PS8BxyeZXET1nhKxONmDAVKsbfRplxXk3kYfaFYSHjNz?=
 =?iso-8859-1?Q?mvSdpXJU6R9JbyLh2dZkJ5n7AcA6rjExZGuyyW9xtdqBWl7Cs+0pBcWC5d?=
 =?iso-8859-1?Q?GiVGnEI4VyP2VtEG4vfCMsihW7p3yDOBwx4Psw86bn2HfpcMWDW/aZqYWV?=
 =?iso-8859-1?Q?BNFd6IkMthoDh4xn50XJX5w32rGHcJIN7ux7BhD7XZeZURX3I736giNyEg?=
 =?iso-8859-1?Q?fz60crp1EEE7dZora7dP53/20YPW5AjP+lrDCnseDmr/dk48mZsribODjG?=
 =?iso-8859-1?Q?+TJOxkq5+/ZFAPVYesGmDH7EzyWfL0B2gw2lOhwnHNXtTI2vH2hBwAt5cf?=
 =?iso-8859-1?Q?mXHrM9BOMiPBG66Dx3RMF7llwf/e+dr0JEEOVnvJby0b7MRQl0uSEnchEU?=
 =?iso-8859-1?Q?macOsZRcmmtdv3JvxMljIXBd4/QmDkFARFPH7L3mAEWmZtUVfmHcg56Twh?=
 =?iso-8859-1?Q?/5H8vAXdQlC7BUgis4x2SjYq0iua+oCT8RO0Fkh8O6Qw1NXQlaR3273nwV?=
 =?iso-8859-1?Q?0mJzC3DZiU5a16b7sESJdIFqtv7VtgcYmZH2xGPDsyK6j4rm4PeIYgGwn9?=
 =?iso-8859-1?Q?so5hPdYYsvakb/9qey9xK/OYHSQ9bZwf3HmxKF4KR+Yb6K2jATcPplWuEo?=
 =?iso-8859-1?Q?lqmGJWh+5t28ib4Yy7lbciJPSV4Y82xCbCbzCzZAxV1IS9s9qEDuxcMz2A?=
 =?iso-8859-1?Q?P2X5AvOxwLIkxfqXT/gRUkXJTKE4XTgrgXd9pBfcfCE9duA0DqYZ6MUWhO?=
 =?iso-8859-1?Q?cvMtB6j7bBDYkB67SUID/ghLpEyxqe08RtLKRkPSY4Rc4yt+7WlHkGXas5?=
 =?iso-8859-1?Q?7z/niFK0hox/V+L74uqSjurmo4FG+9/TPGfu5T4tFe2+1gMBk0+ESjB1Tw?=
 =?iso-8859-1?Q?xuLyGt2Ev+Hj6psoh3LTve9SLKKoTJPEDwKVBMpUZkazX6nEbO00435THs?=
 =?iso-8859-1?Q?i1/KXHXmzvR9LQ6LFfgQeoh/oiOBf2aGL0CLddZgoovociVYxa46O6Reha?=
 =?iso-8859-1?Q?XDhqtaTyeLz2A/7mYdNwWVpYpnaR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MUcg8klR/aVoIGIGzd4enyu8l6Mz1K3ay4yMl4xQa13mk3y9UcexKzQgLA?=
 =?iso-8859-1?Q?+vvk7oaq0BVVb2UgiDfUNdFIciOvocnqF3/kixr1XcZ4Hcb8Aw8XFplExq?=
 =?iso-8859-1?Q?B9AszlcGBCa8kW53puNHy1xR+RUYgePJ3tN5LuSZfS/2cd6bENnzc4DB7b?=
 =?iso-8859-1?Q?GQChctctsMT/88ruHf8RbZL8Yd+C2BGeMFAu2QpJuByuP+KTBeVfn81G93?=
 =?iso-8859-1?Q?IDI9SMG9SRsGqRi8/g22tgoX1Kpp3WPZKbWI17zClpUaWse+fufhyHmUjq?=
 =?iso-8859-1?Q?QBPEUVfAKSu8PoPIVd5NCgvQfhOHZ/YREVUOVBn6c486YssgUlT9jBA9nG?=
 =?iso-8859-1?Q?bmzQN4Dpw4UiNHYNHwnjMMZbPdSfng0K7b5gwaUwpRZX2tO10Ghy2WyQid?=
 =?iso-8859-1?Q?zeH2Dm2uP5Jq47eEaNI1h1HoGxMp24XRrBTm2+ipOiS3BWPa1OHDsi86Xb?=
 =?iso-8859-1?Q?o2G3as7yXT3DlZBM7eQamFPE11y3ZV6nal0fQaBWbhf8j9kPW9Z1WnG89Y?=
 =?iso-8859-1?Q?CGDwx2bzInNN2FrvgN9v3CQ2SdvapHVcMXQVY2NukcnHuQfF1SQAYZ9/Kc?=
 =?iso-8859-1?Q?aD5ijC5aAqpVUS9ssB3gflG1r1YY8y4U7TzGU5ck9PRAj7TuJja4Ct2PXG?=
 =?iso-8859-1?Q?O+aOg+VFVXsusIaqPON4HGPmVYS8PPY8dUwREAaSVtvTHNhtr5nQXOrKpX?=
 =?iso-8859-1?Q?Thy9H9swUNiSvg1BvuEgejnp8T2wRLEmQj/eBooJIeIOe5B1fCC1rUdKM6?=
 =?iso-8859-1?Q?DVJdovg/Geye7DXWVstt1pAnotY5Hl2fnzwWkVV90LcuYlG6Rnln5E31kQ?=
 =?iso-8859-1?Q?7hpjYSUJxAbQZsTCp2P/CQ0/066+tsCwvdIcLgsmjG4/u0Qv+N4q5IO3OI?=
 =?iso-8859-1?Q?f1PgpFlAu4tUj0frIOBdXJ0xLkgyz74XgYNbzVp+peezaFAw+TEUhNLdb7?=
 =?iso-8859-1?Q?tLbE2EKi6YRc3H23d8+gqDO8ZkX3l+thkAY6jisWW+uJQTrDj+S3pZxOxX?=
 =?iso-8859-1?Q?RzMLVtP5cdMGRhwmWxC7us77jbhW8BB97Y5uxtMnJn2QsbMtMCGj1haz3V?=
 =?iso-8859-1?Q?Q7faU9fgwEqhKfQKU15An6KYQgBbuD19R/nhJyaHbZE3fFVjBdZ0vQFgta?=
 =?iso-8859-1?Q?TZ7uORIP0b3Ejz2HWJO1NQNBEt4VrmDLM/uW8e9c0YfElHEUzJnHCZ/8WM?=
 =?iso-8859-1?Q?rxGGZuPS+6oMPgGi3zWUqAjgDheZ5r+WrVqLBV037UEj0HyAi7VBEvhR8N?=
 =?iso-8859-1?Q?bm6EiXwePkExB/uURLVoLfzbfHZscp/hYGQHJ7Jn2x2sauo9i+NU74BW4p?=
 =?iso-8859-1?Q?hPZg8KzCFRqLKPzvJWTTKigQCLr4O06IbdjBgiMHbOSWxQImbF30gcIGNO?=
 =?iso-8859-1?Q?yK5fIJOOpqxuGo94Z9NVlcEJGyTm73yQMzPrumUCE+rPKCVrICLSKDyYNB?=
 =?iso-8859-1?Q?gE8BAqOjhFL6rS4axHxnK3nwJz9TCTfmygWxmzjrr8B5YGigK/orkNO5NV?=
 =?iso-8859-1?Q?F15lUVI5jFgJeWGOZM6VPaINWvHT5V/zH0uyXYI/xumquGtwKm3ickUJAG?=
 =?iso-8859-1?Q?Fb2ody6zTDPwFk1S3wROLIMOSdXUgFTmflI2SUKqW1E/XEwgFLMiXTIHCa?=
 =?iso-8859-1?Q?Y83p9f+75MQaEpLqKtZMr/pHvOpvcPWPoN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50281347-be5c-44d8-9aeb-08de160b0de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 10:16:26.6720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYNpMSRkKseYt9Sv37xz43pdNOu7T69qrfgwyYuM8PGp1GUnsr5U9hd78wpUFnX6jX9nYRU7exmCI0raTm2tQqAC6+tKMcI7FEmkB79x/5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0E20B3A18
X-Proofpoint-GUID: WuRjUdrsf7qBGt2s_NfURP1S7rdmQPJv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4NSBTYWx0ZWRfXylqyxuJSummF
 BtjSFyAU3MYzMhSHmnGN4r4kVlECojH1CfenAM9OWnfeaerpkLdO7T7tLG4VgeO1o48g5/EkMZ8
 CJvs/gNgYXu7aJNsmiVL61dfoqZy2UAZT7gs6gzWz08ldFCUm0mBuDPxUxmf0EFS35/KbqSi1oV
 GMwtHKdw/A+jNv73S0llG/EN1aLqn1rK4VU7uNoZ4H58lTtTH6e+CITp/1s2Y5DT/tnGKt9xZ4Y
 JTF7Xl0d2P+ePGyTlbg7heBN3MLs0w8Rya2vZYoZalPIscHOKMvUpEfy0wBRKcOyJNRlrZdxAZv
 wVEloC3/phtRGDSAC88uThoV2DCX07SwImkU6rxndWfh3lOMjQ0pQvppfG4zzpPpU9AbF6LE6nJ
 49rzqIbKq4ZkmZQJoHvlBZdXRp87ag==
X-Authority-Analysis: v=2.4 cv=Ffk6BZ+6 c=1 sm=1 tr=0 ts=690097fd cx=c_pps
 a=Q5kcJUpSFGSGPQA8zxlsBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=GhBz4CYVK26Py-R_4gAA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WuRjUdrsf7qBGt2s_NfURP1S7rdmQPJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
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

>Fix the extended stats name allocation size: instead of allocating=0A=
>RTE_NODE_XSTAT_DESC_SIZE (64 bytes), only "sizeof(RTE_NODE_XSTAT_DESC_SIZE=
)"=0A=
>were allocated for each xstat name.=0A=
>=0A=
>Fixes: 070db97e01 ("graph: support node xstats")=0A=
>Signed-off-by: Christophe Fontaine <cfontain@redhat.com>=0A=
=0A=
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
=0A=
>---=0A=
> lib/graph/graph_stats.c | 2 +-=0A=
> 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
>diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c=0A=
>index e0fc8fd25c..b87b5707f7 100644=0A=
>--- a/lib/graph/graph_stats.c=0A=
>+++ b/lib/graph/graph_stats.c=0A=
>@@ -302,7 +302,7 @@ stats_mem_populate(struct rte_graph_cluster_stats *sta=
ts,=0A=
>                                    graph_node->node->name, graph->name);=
=0A=
>=0A=
>                cluster->stat.xstat_desc =3D rte_zmalloc_socket(NULL,=0A=
>-                       sizeof(RTE_NODE_XSTAT_DESC_SIZE) * graph_node->nod=
e->xstats->nb_xstats,=0A=
>+                       RTE_NODE_XSTAT_DESC_SIZE * graph_node->node->xstat=
s->nb_xstats,=0A=
>                        RTE_CACHE_LINE_SIZE, stats->socket_id);=0A=
>                if (cluster->stat.xstat_desc =3D=3D NULL) {=0A=
>                        rte_free(cluster->stat.xstat_count);=0A=
>--=0A=
>2.51.0=0A=
=0A=
=0A=
