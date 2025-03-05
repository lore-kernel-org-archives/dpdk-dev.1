Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA82C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 05:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18DA840156;
	Wed,  5 Mar 2025 06:21:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 269C5400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 06:21:20 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52528xvt006486;
 Tue, 4 Mar 2025 21:21:16 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 456djv89qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 21:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csA7OOoHUc9ud5inG+m8hZSzg5Ld1KnoAkhPINc2h8DkOp7SJ9uHo8zYQA+gy+xGWuHGq5j84EgxVuaS8CP+TMn+dWjZV+HhY1Ow146wnU7cE//B/ZMV48AJ5iuK1VY4NBCmojaHiMbF6YPt08XgM9Sp1MqjNbxh/PVJkzkYoXbsvnrJuUIiUqOdZawsxhLxT46JFrbSWKbwQh3IxBAjjYse9zrKuZg24D1/Li4J1urmXQw5lqjhRjmLjzAEInn643JwgULyse2dZIjwqkx1nkPqcS57T3I4CHz8wtSDyVSYwODuFN6R7fOLqVwdz3WmFWDuek//jRGTxmbUfE7jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc0JkUsWODDqdJ1hePYmVLn7+dbwbQpJ6x2H5ZzSTlY=;
 b=A8jRF9zimJRFRHU2V0jjrrep5lS5dAw5UQpphppAkf6vw8VZq7UpijWQUWmXG8QMT5GRPb+Sj7n92zjCTpSI6/qkRctjj5ZAOgeWhVGYE4b9YzUSUpurzWREXASXxv13VD8pYk3lXnmmVBWEU71fhsoylML/ViJsGQMgHYaFh59uOjLMQ7odswREF6RGNJh1gpOn8TtIQI7SWB5XIo9q9bjc57PXk1rXiRQ5fK4xiDYHn7B2ozVa+rHZo7ERpIk6lA6u54vd8saXR4bNkDwApmoc/ROXmEh6TQRSatBIKvP4Law55zNHlotRz142LF+wLuREdalHTXdgk4JT9Hu4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc0JkUsWODDqdJ1hePYmVLn7+dbwbQpJ6x2H5ZzSTlY=;
 b=IhGB2wF3pKyuKALj9zcw4+cxlb7jQV4DTc8lC8Pmscf7QM3fffh+0QDaNoX0KxYpCAfR2mF13PV5+K/GZ0Uq/vD0S8Z8fOemJ29+5Jsa9eiUUJp2yFCrXv5ZryDX1Q2F7fc/K5tRniMMIvhYVudymgArJ4q2wpXYWvul/GMewfM=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH0PR18MB4409.namprd18.prod.outlook.com (2603:10b6:510:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:20:55 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 05:20:54 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [EXTERNAL] [PATCH v4 4/5] trace: support expression for blob
 length
Thread-Topic: [EXTERNAL] [PATCH v4 4/5] trace: support expression for blob
 length
Thread-Index: AQHbjR+Dxn2CLxpeX0CU927gUmXUCrNkAlLw
Date: Wed, 5 Mar 2025 05:20:54 +0000
Message-ID: <CO6PR18MB386053E2F2EE694D8B185178B4CB2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
 <20250304160633.385185-5-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-5-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH0PR18MB4409:EE_
x-ms-office365-filtering-correlation-id: 5f9198d2-3fbc-487d-d35f-08dd5ba5810c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?84JXRNK6izP4mAFa8RaoRo/Yt3FS+h6TpJt2aQW6l/iiD7Yj84mUz9mm+g06?=
 =?us-ascii?Q?+ArQQ+sW1MEK40LncyWh461v7CT8Qgwj4lg3bmFEPy2KFopnsCl9YpgNmszr?=
 =?us-ascii?Q?ztHyg43DuCMmaYKorXrTS4Li4jjNk0aDZ1W1XjpyS43xDB+DpYb5B6jIIJlX?=
 =?us-ascii?Q?BqVif6lBQGt3qCjP/G5V0eIIjdVJ4Nn1FTansWTY5szBRYk7aKmcY3hKhqsI?=
 =?us-ascii?Q?NrtHBVqKfWGouXoBjeXUuUYpR7MmwXfcSVo7DPwd+ShRO5DQOIHIWJsazHXV?=
 =?us-ascii?Q?M5FVjpCSMVr+EUt9Ex2ykSANmYlWb5f8Czac8q1L5PDVRKQkuOl9XfERNCj2?=
 =?us-ascii?Q?jQDx6actT580+30of2TLqwVg2CIjqudpX0t1Rpdx3U2A/A/paW4uZ/0/EsNj?=
 =?us-ascii?Q?oKUUmChBhAmfE/5W++ro5nIWVSggQxhNuN7X6NsRvpwHN90cPifNadocU/A1?=
 =?us-ascii?Q?Hx9wrew/08xlaF2KP6EFoJ7yye6pT3Ex/3pNJ2iIM0en3f+u8uIAtvfxzZ93?=
 =?us-ascii?Q?lVr66gUDU5I3N+Fa5spFWT8IhfQ9aOzOF6KNEQyR4rf0TQ6iWEE9/T1TnEN6?=
 =?us-ascii?Q?7wKQmJVRfTYpgzoVGO0hHwIWQB698dZyIMJdJnq9k5bTmJnRDo4aOAVPhFjF?=
 =?us-ascii?Q?2fXBxgZw20TwZdo5rZ3Md0LpsUjVzJVp22gTuZlhfn5dsiYMwdEL4d2isiZY?=
 =?us-ascii?Q?mYqaPTEs/hCUkT34uXsk7NNFksHJWBUOaaSWs3sWvDNtIZWMYHrG54RyBlod?=
 =?us-ascii?Q?MNEopGQJahQM8lq/arL0XAmMTAFrUoBrfzzAKXVkbAlYOOFpXYkekGqavSXW?=
 =?us-ascii?Q?09X6ouvkw0vTefi2e36NNHWyRnBhX4jIIUeRMex6ocFrsk/zyxrw6AQfxB/M?=
 =?us-ascii?Q?xayckn0lxXd2EoBoCvPC7/KR8CtFMXPQS30blddER1dXawu1wiTuLqqlZoxr?=
 =?us-ascii?Q?6aa4VxO70RvzdOcfQCsgriqs4VFjxLUS1WquUDOEMdr94cjHXRikKZkqhIgm?=
 =?us-ascii?Q?czkVRNbzzm9Q3u1S2hANhLKlykslq/Fz8FmmEsFUKUfuuTiaL0tfxLfMKbl1?=
 =?us-ascii?Q?FrRT29gF6cj5dHjsSR8qKU+FeLbVmv6UAIygp7nz3dB3jKwpQ/FwseLOTx46?=
 =?us-ascii?Q?IuinavN0l2gTmRoy6qKNifDdgw0SzSDo5cGcj32x6k/cBhVpEASB//lB2jAf?=
 =?us-ascii?Q?9qKXhm4fgRQ1fkvzPMjH9ARsd/xOc8VEawOQE/rBQ0+c29cqY2ihpVpSVxUo?=
 =?us-ascii?Q?zhS+aHbfQsuyyflB5tPCCHVvsvkILvWK0YoqhqLIu73kyBK1rF311JlhOQWQ?=
 =?us-ascii?Q?EO0egoQbiaCWV/rgfFkmHiJ31SoJrD3jDn4hl+/hunU10YOW0g0B07qu68xC?=
 =?us-ascii?Q?Qwl4Uljrq9fa4+PblBysMEI1UHzLE3QC1j9mKjZy71Yb91kiGG+IjFCdkHZL?=
 =?us-ascii?Q?4/t+9rmUALzAFTMhUyuRkP2zHQ5Xw7/E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7py9FvyZRZnTL+nj1dQoZO1x1w17cOqmRcfBGzql4qZ3BGtShqnqcVYyAsZk?=
 =?us-ascii?Q?NUht1IglrsbQf62oAHLGgXPmlcIF5uMv+SW4v5Jm4b5dSGzMAk2Ky7rxGmHm?=
 =?us-ascii?Q?c4v4tKaSMQpUmGCpZpaPTVB1L0qGORqxnpfz9iQ5seHjfl3eCix7FnC80N8J?=
 =?us-ascii?Q?uwyNE6DGVHP7SXGS4hpNgYEhqIB+onPiUScXPtNqkAIE5TOqLqz9CDpj6jIw?=
 =?us-ascii?Q?4gLqVN+c9FVy9TlDskaSA5lqdbtyvi2CVPTKBBoBQefB4eC7uLVg4lOAO2ou?=
 =?us-ascii?Q?DISCzUEyz0wEaQiFRvX99SkvE/LnUhwLbtM0Qpdlzhix7uLnyodArEEEDwiS?=
 =?us-ascii?Q?Xt9GNwRhkdYNltGnSKL+OArDRbTDcRKrNspGcgF01+QRm1mdJXIdhD38DFcW?=
 =?us-ascii?Q?0GLStae4O85WOLmA/j/MQLzi57GQjBKRm2EEogc6UEzMJ5tmrmAMGXvr0Pgs?=
 =?us-ascii?Q?Cg5RNgwOB1if3gwI+pJjymPkqSeV0tZoEZeS5mFc7kBua7g3WNAhzfmSzSYA?=
 =?us-ascii?Q?ZVwDs/GhVC/krzMFJgFz2dhwKnNKm6HCBs/Mh8a/6BdiZCBlEZBvi967i9Ww?=
 =?us-ascii?Q?UV66BGduRXyrOhP18VZHJAjcRmpze2GMWtO7NhqWa8kxIxOF49j8nzet+8w/?=
 =?us-ascii?Q?rC1ajHv/iQBhbqDrD1qmKykESiR0FuPtLHjV5DJiuWHm3hOkbgCKs1mIIGwB?=
 =?us-ascii?Q?hEaQ5CF3bi1LIteCFk3/90LVDpCoxkgmRILa3ADHhEOzVLSUZJ3GNG/mXdXU?=
 =?us-ascii?Q?SrALxag/o3M/Aql27Akd7qs3UDS7YByQNKaZGm16zMKqIyCDbPq906c1pre5?=
 =?us-ascii?Q?RccoEkNZI+B1IUbV3DYqgDQuslFRdcjCYtWrTLCQd4FmHuVK0ZN4nBdaHYob?=
 =?us-ascii?Q?RX6T8gPp5Ho2AZ5ogoXHjLnpBnVJWXL3k7c3JZfC9Cu5DsY1tI6FOv6T1Dy8?=
 =?us-ascii?Q?T7kooCH0KLAjpLWFR36VwBnxztRYn72fDgI2sJiK/HtypGxi4AFEO8MHfo32?=
 =?us-ascii?Q?aPnvYPSGXpKdj0BsWjQuARv74U2LyN38KfdkAfydb28H6nGoB/cNOs7Un3EB?=
 =?us-ascii?Q?CKzF4rz+z09ojnYcgSIPzY9qBreCnisCAsrohVSKD+0xDWTb3xqx53Pvc/JJ?=
 =?us-ascii?Q?r98kNTlxdyQtvP4WDTih33oDOUfNoys8tNSZoSCkS13CjoqasV7g79vuNIbi?=
 =?us-ascii?Q?cY23ZqQMIC/ADazEto4Q6ZschmL4KCNubzTzxW7McIr07G0a/jQsQjXmlZoq?=
 =?us-ascii?Q?KkvR49pKQhy1mjm6TimusD7i5Dhv7llE7tlYl4FUpvYKGJyxJJfoCVK1QFPY?=
 =?us-ascii?Q?vzg1kcCinfMAORDDDQdH9Td+A2sm4Ovkzr0r8Ofo4Dql1ysjYFzErF4Cy7cB?=
 =?us-ascii?Q?3oR7pUyxPzwDxlbeCGwFOHrpXSNJFsFlngNLHdC6YPTQX7pjHy6bwK//oBdo?=
 =?us-ascii?Q?CyZ73REocrr6HKxQkgACAG7gbejupe9NZexbhqS/QzKZp+b54tDWiPITrgJc?=
 =?us-ascii?Q?WBz/6+G+6eNtPa9EPBXea+IaWHDp1XA+hR5AwL2JvldZKQI3xt6c86Y1O+Ro?=
 =?us-ascii?Q?WhcEa/bkNsz54A89cxs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9198d2-3fbc-487d-d35f-08dd5ba5810c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 05:20:54.8795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZIXp4s6Rmu1CzGJGaXZul7Np2iw6rvB5JGLxtjX9Nos0Yx6po8Du31pSkHlIGbAKOdI2X0tMOg4pk0ZSz6nxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4409
X-Proofpoint-GUID: OsqZdIbQDY5juSvt_rlfSMgvtR78ldId
X-Proofpoint-ORIG-GUID: OsqZdIbQDY5juSvt_rlfSMgvtR78ldId
X-Authority-Analysis: v=2.4 cv=Z44WHGRA c=1 sm=1 tr=0 ts=67c7df4c cx=c_pps
 a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8
 a=xPI1sq5IQljhSjl8muIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
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

> Support any expression as a blob length by using an intermediate variable=
 in
> the trace point emitter itself.
> This also avoids any side effect on the passed variable.
>=20
> On the "register" side, prefix the length variable in the trace metadata =
with
> the name of the emitted argument.
>=20
> With this, we can update ethdev traces and avoid intermediate variables.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v2:
> - fixed length field in CTF metadata,
>=20
> Changes since v1:
> - removed code relying on arguments in "registering"
>   rte_trace_point_emit_blob implementation (see patch 3),
> - moved build check in non registering __rte_trace_point_emit,
>=20
> ---
>  lib/eal/include/rte_trace_point.h          | 12 ++++++----
>  lib/eal/include/rte_trace_point_register.h |  6 ++++-
>  lib/ethdev/ethdev_trace.h                  | 27 ++++++----------------
>  3 files changed, 19 insertions(+), 26 deletions(-)
>
> 2.48.1
Acked-by: Sunil Kumar Kori <skori@marvell.com>
