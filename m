Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC75C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 05:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADDC402D6;
	Tue, 27 May 2025 07:50:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 925F0402CD
 for <dev@dpdk.org>; Tue, 27 May 2025 07:50:08 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNrBtw032052
 for <dev@dpdk.org>; Mon, 26 May 2025 22:50:07 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w20e8jsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 22:50:07 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R5o5tg018765
 for <dev@dpdk.org>; Mon, 26 May 2025 22:50:06 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2109.outbound.protection.outlook.com [40.107.223.109])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w20e8jr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 22:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS/jWJNj90kRNN5r+wsYIaaPlJtpiZe6yxleT61+11bdIjhSn+2s352193AIJMEUlMcKD094S+EX7oPdQ29OAitVvqsnQW/y4rpIUSFSaTn+qVtlT/o2bDv1iPB8fqfg04rsogDDrhNnxuNAthHHv+qVMUVzHmDwVCPzgajx+m5z3P+0g22B0W7yUdH6txOcSnsXw4C18H3wLYauG/+gFEbhjdJqV6fVnUdp9y/mx+gY8Dp/NIlMjDImtbCo1wbxgoGbiuhjdSclKTmM2UznTYHnoRL2eKjIL88V8qAQT3PnKANhzSAo38g3PAiJjcv6AaUjK5CmiZadtF2jQYgkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5N512hTf+OBiUSO7UuGW+vE4lDulMwy0KS+6/44N3Q=;
 b=VM2vnnMDh3NhV5tzE8fUX4MGwqMXmFhtXxQUNYVZ9t5o/Dri2RDWSZmuTRdEKx3y7Zwjx9REKZfZfB3atr+tSebJJfozsd4ZWUtXftFb0btW3M/Z9pnHAnKzbnkkAIa8EqN+ovHOmhkRDrT9jEsbetSeHWFdvcDL8NneNuQXr5OJZwJoHQlCwIdx+0qzsk/47caFn1Lu6VvMO1yrYW23A4grkagaLseuQMRpvnQUqhFCmDDW/aiU2LmsKAMwfCL6uZcJ86UqYWHGS8WyxREFVqS3UiFpUU1vJK4w+6lqQNspzzXmVzaVrqjWI5xIMSk35SF3tgXs1FyZL4/tpLKSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5N512hTf+OBiUSO7UuGW+vE4lDulMwy0KS+6/44N3Q=;
 b=MaLO4+bKBK/gSsehJBJl7c+NxK0npzKmzexdXHuM0GMA++R7YeSQFDAIrP18EuPleZREXV4dJ7RfMMXPsBlYcz3Wk+3Vr9dAgUXW4ikoMEpDoz0DdHmXbmVV+N4p78RN5lytOKqUUOd2w7my1dSnvbZ3W2Eu6EVgpUraS4TLFzA=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CO1PR18MB4780.namprd18.prod.outlook.com (2603:10b6:303:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 05:50:01 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 05:50:01 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Pravin Pathak <pravin.pathak@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>, "tirthendu.sarkar@intel.com"
 <tirthendu.sarkar@intel.com>
Subject: RE: [EXTERNAL] [PATCH v1 4/7] event/dlb2: support managing history
 list resource
Thread-Topic: [EXTERNAL] [PATCH v1 4/7] event/dlb2: support managing history
 list resource
Thread-Index: AQHbwJo5QL9uMF+bckmc+SLLtOzlK7PmFQvg
Date: Tue, 27 May 2025 05:50:01 +0000
Message-ID: <BY3PR18MB478577B72F59FBD025B80969C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250509042401.2634765-5-pravin.pathak@intel.com>
In-Reply-To: <20250509042401.2634765-5-pravin.pathak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CO1PR18MB4780:EE_
x-ms-office365-filtering-correlation-id: e928942c-301a-441c-c49e-08dd9ce25297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jCUBh8TkElW0kMUAzkFj4IkFk2U1HYZPvMwwriWVgTDSJ+yGda2fwAivVRRN?=
 =?us-ascii?Q?WQ7YoFdlkgyQfodSyHSbyKVXmaLQU3ykFFxYuh+QxMi3qYk1ATSndV9JWNDV?=
 =?us-ascii?Q?PfYR2Pf2eGUtwpKGzz129ZMoaURO7e+lkOMPYR76AqEXM9mwoim9N6cclpTi?=
 =?us-ascii?Q?hauco27ddkwRDK8Ue8HipyaogLyndukPHpcVl8KraK9A/N38kIHMofj8SV3v?=
 =?us-ascii?Q?E8qRP+xgYFDVMVB7S+Lk8wqCBjV7pf1fDRepXBJ3UTziuYbpJ7w8ONRCExUU?=
 =?us-ascii?Q?Cq7w0MsBRwPdF50qOR1WdcdzCdUG933S0M4YkjZd++dA4hehXWJFfs2M5LCc?=
 =?us-ascii?Q?UCWsBXFuhrPbBgHw/LD7DC+aOSv1amqtba/IdalydKeIDGcakgDi+HQwZJyj?=
 =?us-ascii?Q?Xgv+4Vxu71tTp7kcRAAw3q/YnvHXJjgaOwiMttS2Q9a0y2YDbEEvlU/XTcbF?=
 =?us-ascii?Q?8kPgU/2MLtZaPqmjCnP88qB5j+yMUvXA90YR1EQ+ev7Uj9UE+IjKn5muHFiF?=
 =?us-ascii?Q?tyeo7jlrEfx66LjPyCjsnc+KXGpTn/R5We80iCpmqvG8kRQFmVkzeWwmGVjH?=
 =?us-ascii?Q?fuIG4frhtQduE95Gt7PKlvuEZiVC8iJ95A7pYyvKLyJj9hzk0aiGlzpFy4oL?=
 =?us-ascii?Q?z1/mJSXUppgHMGLroPmMPpxN1zVGYnHnUwoiwRA/W7Cyp/rVlwbjOyo9Grj5?=
 =?us-ascii?Q?+FRuEBuz1GbuvQ3dum9AkTes+6DHVFP2p7zL044QdkeEhSKpYzDmjqzmOdvt?=
 =?us-ascii?Q?4HS7GbeSeDmz7mj9R1i/WK5VcGziFvXTig12WVM6gN/SZnRrXqtp5rjMDHh9?=
 =?us-ascii?Q?lWQxZaTfIa1zY7+J2qTuUE85kwMh+ZSvlaZ9XULGJxKW/KxEgg2vB7zdrGIi?=
 =?us-ascii?Q?bpDur1gLXnqKvXvLVu6/4GK6bVAGQjw5xOxh9+IeKAtyPJvrBufp38EfqJSa?=
 =?us-ascii?Q?MdALySr+k1wFPYe2IirlcNxxZKyHJeWImVyZJ9Ii/uTOBDAC/Q1Dyruyicbl?=
 =?us-ascii?Q?mp5JpncxdbRoclzK1OL6+zM+nvH2nbeM1nqKUwpvuqxfJen5zdMUVzvT1GuC?=
 =?us-ascii?Q?NfYnoj7wvxwygTxQnlQnjz2qDkvsQWaxmnjjscDu3EOlVsqwOl7m+Iv805D+?=
 =?us-ascii?Q?gIEV6qW3xA4qmTnZDgf7fI1HzQWZIwyI5c71VWcSPmFyqq++sLFpFSz++bVX?=
 =?us-ascii?Q?ny9WrGCrfXcsLArcDrdpAwkjZhrwjc5YncHFlhmPNKJ8eXVuvHes1Bt1NfhG?=
 =?us-ascii?Q?uDMno0gL+U+ewUSQkgPtIYo1v1fBFmZ6IB8cggH+1T1+AR1lQ83asj54eot9?=
 =?us-ascii?Q?Dq9xlVxXoyBImy6TQh1uuptCEjQs7I2HiuauyJ4KMAw3fiKIJKFIvjwKOi2e?=
 =?us-ascii?Q?U9a1lae18OdIzTJLwZh6WtfjHI4NVGJd6EEGJyv/Rt9ZfHhi2LAtxYWzssHI?=
 =?us-ascii?Q?3+6crJfB1j0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gWOhX8g5QA/zXEt0zrmZ5FE6H6PVy0ztMGrTKblWG90WJpjmGn6ld5aZIOoA?=
 =?us-ascii?Q?9RR/RnNqyxaCIoT/DrzI09Uw17iKPOCeppDsCc+2R0XQJiNuF3Xfowigl1sp?=
 =?us-ascii?Q?m7z1cMl7jwcYpprX7KU9KKrtMpUdgByXjjbsDIJuWYPQ7/YuWUFdovz5Izgy?=
 =?us-ascii?Q?TfecwO+Ij8Zx5LT0k36d8ZH6cMG8x2BmHpZXSGMdGzeo3DfZIItT1zSwoLKV?=
 =?us-ascii?Q?aDcXIx9ZOIyvfZGptBm4JLZL1Ls+JiZ3CJS1vUBeICpk0vgu7sT+PCTHgXwO?=
 =?us-ascii?Q?bV6NVjf73EGcxjhQcMg9tlKzVA37y0B8dBOdjG7xwDys5+57Gw4qYU4qqFTF?=
 =?us-ascii?Q?w7x5qjCJSP+VtJDBbDMXUpUOpHaDZmdWryebo0H+C6Bh32E/OIvUUrRlAz5p?=
 =?us-ascii?Q?iDoyAK869O4Xnh82M6i0Orb8D5A7HDpDIgXTYBbVofbAABfScy7kGhjuhQ2x?=
 =?us-ascii?Q?r2+FvKh63HghLno5Fgrd4Ig2r662juTvHv5isILQgvI+029FVL3W1LClC+Fc?=
 =?us-ascii?Q?jNYTzcGSM5cq+a85qQzVVdT5aayR/SpKXiROFXyP5liWhOI9ct+O7EFUprVp?=
 =?us-ascii?Q?rYY07L9RAx5oo9m5MSMVB8oQ2Jv1pcad3syLG1Gg6/E/lt5f7w87iuDvyebX?=
 =?us-ascii?Q?joSF46BKkBoBUcSMH/Fhj8a/EFcwrAyxxKOPGyJ2ZknwUC7TC1KHk653+/ij?=
 =?us-ascii?Q?Jr/zsTfH5PFZzUTvHPumukk3fZEJeNRCwNLn4WPbRH8aIfzAcFJP8uCvnWW6?=
 =?us-ascii?Q?KnjzAz6RkIze4vfK8Qp04sMrD1m1uElMbNDzZGKCCOHAZGDoEt9nPGv+v0sz?=
 =?us-ascii?Q?GI1q6qmir0R5Wird5HNdqmatPaYyolJgkybL88V4/+gYv4GoQFtU3Z3B/ihA?=
 =?us-ascii?Q?NVhGe/QynBTHeG5CnSJj05dhjgVK7OWrrR5omQCFnUYwcRMG/IAmuqz/uSZ5?=
 =?us-ascii?Q?BqsBNcX6p/RQ0+29MniP9pSoh/lb5Jc/SHslE6DxQyR93UEYaRPqhdKxL2/z?=
 =?us-ascii?Q?ukPe4BQGHkF1k6BV7m3CGrQ3nkgfwNtGh9YMMtAGeLH4+D8qtqoMoAkyYDe/?=
 =?us-ascii?Q?uWr114C/mmcXaicK8eNUj7o0IThgMgTPzRcpjVLDquOP2B+T1PgJ2Td5JKbV?=
 =?us-ascii?Q?myYZZmJoTRHYxMfpg5V3U6bV3z7Jdg8iBy5vZ1qQNxFlxrWNGCVosXd9gRed?=
 =?us-ascii?Q?1xwYqhvJA5J2cCQQfbwQfTBLs+OqQk9bfPuhVDGQhiaXJjByqBKHnhiFravu?=
 =?us-ascii?Q?ZEpj7qmwSz/psBZdm1BAoYXVpBeliCq1YrzFnNvXhpCm3w0Of8x5Q5Ua3ESN?=
 =?us-ascii?Q?jrIavSwqgwE7TdhFhfqRjRIFPunkdnX2fQydi6y7k4wQEnlCFFMHynE+jGH9?=
 =?us-ascii?Q?6N5blsCvN8mSGB7/oVntJhB7LHx/vdg0YKQoG1WpJckgPx6/eUeX96ldayrk?=
 =?us-ascii?Q?iSTanDhMJS2WA7yl07To9im43kVnHyfkApfVILMJ+kveFh872hr0UpbJt51D?=
 =?us-ascii?Q?r9HFWLd3ONh9YALGEmczCb7VFtUrMVepWSOOhT73v7twJXDZMShG2pNzgDeE?=
 =?us-ascii?Q?N6qg9Y4y80m179eRhtz+L8+XQkrs3GiQPYY16JMP?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e928942c-301a-441c-c49e-08dd9ce25297
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 05:50:01.8575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRUFAAipaQUoPZULx/Z5MundoOPAHpDHnvXd89ForBW4cUiqihXcB3jVJats+Z5GScL9w/UIf/45OW09pSJ6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4780
X-Proofpoint-GUID: HKIlabxmmu03PG7UVFFPZuMmDhoXDyXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA0NCBTYWx0ZWRfXx3WqYErIEW5U
 qMz+Z5hW7bd0ATesgPEhYZr+UQ0v/0seDCtOgYMvU8l8oVD0n524lNU1pADuNAtw/AzKEYmIr7r
 5wC61XiHaduKdwHOkiaEPKVWAmRcvyvLzgUwM3KE5/aMvBB9Kuv89G8vIqmgcv7nB7TfD5+MUeG
 r9vxeVs0brbxcVQIFHCs6kqbr6yAJ/Wa5ZrRxi0O3CbWcMZrl0dqnxQKjL2WKFUYjZt4KxPo79V
 3naQx90DyuUGc/194k5euzUDttypdUSjMsk3iBPljkYEACyDe5rhfgCF7hW0boroJD481BshURD
 Dy9mAJE+0GOymJtg9bNkmEvs/2W1iqZRLsgRalSyGhlbgKRaTj8/9xo1rja+aNs4iAcjb4uF2su
 MSGi/hFwXEOuYcyO4m24C93+RO1tYQZQkmVvNCZ25oILh4/YVPtU8Y1xiT6OmlIMI8jwuxoC
X-Proofpoint-ORIG-GUID: sAazWrBBt7-CoiqOS-ljy66xnIrUUBdh
X-Authority-Analysis: v=2.4 cv=G5ccE8k5 c=1 sm=1 tr=0 ts=6835528f cx=c_pps
 a=JCInGfjmQJ+O+leRUSAC4A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=zd2uoN0lAAAA:8
 a=Ikd4Dj_1AAAA:8 a=RpNjiQI2AAAA:8 a=Qr0ms1Cz38Lz1GemAIkA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Banner-Trigger: inbound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="us-ascii"
X-Proofpoint-Banner-Convert: 7bit mime entity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
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

<!DOCTYPE html>
<!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;height:0px;max-height:0p=
x;opacity:0;overflow:hidden;">
&gt; -----Original Message----- &gt; From: Pravin Pathak &lt;pravin.&#8202;=
pathak@&#8202;intel.&#8202;com&gt; &gt; Sent: Friday, May 9, 2025 9:&#8202;=
54 AM &gt; To: dev@&#8202;dpdk.&#8202;org &gt; Cc: Jerin Jacob &lt;jerinj@&=
#8202;marvell.&#8202;com&gt;; mike.&#8202;ximing.&#8202;chen@&#8202;intel.&=
#8202;com; &gt; bruce.&#8202;richardson@&#8202;intel.&#8202;com;</div>
<!-- Preheader Text : END -->

<!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerStart</div>

<!--[if ((ie)|(mso))]>
  <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" st=
yle=3D"padding: 16px 0px 16px 0px; direction: ltr" lang=3D"en"><tr><td>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"paddin=
g: 0px 10px 5px 6px; width: 100%; border-radius:4px; border-top:4px solid #=
8d8c8c;background-color:#D2D0D0;"><tr><td valign=3D"top">
      <table align=3D"left" border=3D"0" cellspacing=3D"0" cellpadding=3D"0=
" style=3D"padding: 4px 8px 4px 8px">
	<tr><td style=3D"color:#000000; font-family: 'Arial', sans-serif; font-wei=
ght:bold; font-size:14px; direction: ltr">
	  Prioritize security for external emails:
	</td></tr>
	<tr><td style=3D"color:#000000; font-weight:normal; font-family: 'Arial', =
sans-serif; font-size:12px; direction: ltr">
          Confirm sender and content safety before clicking links or openin=
g attachments
	</td></tr>

      </table>
      <![if ie]><br clear=3D"all"><![endif]>
      <table align=3D"right" border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" style=3D"padding: 4px 0px 4px 0px"><tr>
	<td style=3D"direction: ltr">&nbsp;&nbsp;<a target=3D"_blank" href=3D"http=
s://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxazq=
KNrbxbU3QM1Wav6Ecy3a0D90KUJcMS2kHwhFdLXwRRAhafQEtS-IW5IRGLpIgfnwzS7s_RIc1vt=
42pHYvmBNbV5L9tWijJJmydyqe-L2IylTTkhcg$" style=3D"mso-padding-alt: 7.5px; p=
adding: 7.5px; border-radius: 2px; border: 1.5px solid #666666; "><strong s=
tyle=3D"font-weight: normal; color: #000000; text-decoration: none; font-fa=
mily: 'Arial', sans-serif; font-size:14px; line-height: 40px; ">&nbsp;&nbsp=
;Report&nbsp;Suspicious&nbsp;&nbsp;</strong></a>&nbsp;&nbsp;&zwnj; </td>
      </tr></table>
    </td></tr></table>
  </td></tr></table>
<![endif]-->

<![if !((ie)|(mso))]>
  <div dir=3D"ltr" lang=3D"en" id=3D"pfptBannerqpx5gfp" style=3D"all: rever=
t !important; display:block !important; text-align: left !important; margin=
:16px 0px 16px 0px !important; padding:8px 16px 8px 16px !important; border=
-radius: 4px !important; min-width: 200px !important; background-color: #D2=
D0D0 !important; background-color: #D2D0D0; border-top: 4px solid #8d8c8c !=
important; border-top: 4px solid #8d8c8c;">
    <div id=3D"pfptBannerqpx5gfp" style=3D"all: unset !important; float:lef=
t !important; display:block !important; margin: 0px 0px 1px 0px !important;=
 max-width: 600px !important;">
      <div id=3D"pfptBannerqpx5gfp" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-family: 'Arial'=
, sans-serif !important; font-family: 'Arial', sans-serif; font-weight:bold=
 !important; font-weight:bold; font-size:14px !important; line-height:18px =
!important; line-height:18px">
	Prioritize security for external emails:
      </div>
      <div id=3D"pfptBannerqpx5gfp" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-weight:normal; =
font-family: 'Arial', sans-serif !important; font-family: 'Arial', sans-ser=
if; font-size:12px !important; line-height:18px !important; line-height:18p=
x; margin-top:2px !important;">
Confirm sender and content safety before clicking links or opening attachme=
nts
      </div>

    </div>
    <div id=3D"pfptBannerqpx5gfp" style=3D"all: unset !important; float: ri=
ght !important; display: block !important; display: block; margin: 0px 0px =
0px 16px !important; text-align: right !important; width: fit-content !impo=
rtant;">
<a id=3D"pfptBannerqpx5gfp" href=3D"https://us-phishalarm-ewt.proofpoint.co=
m/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxazqKNrbxbU3QM1Wav6Ecy3a0D90KUJcMS2kHwh=
FdLXwRRAhafQEtS-IW5IRGLpIgfnwzS7s_RIc1vt42pHYvmBNbV5L9tWijJJmydyqe-L2IylTTk=
hcg$"
    style=3D"all: unset !important; display: inline-block !important; text-=
decoration: none">
    <div class=3D"pfptPrimaryButtonqpx5gfp" style=3D"display: inline-block =
!important; display: inline-block; visibility: visible !important; opacity:=
 1 !important; color: #000000 !important; color: #000000; font-family: 'Ari=
al', sans-serif !important; font-family: 'Arial', sans-serif; font-size: 14=
px !important; font-weight: normal !important; text-decoration: none !impor=
tant; border-radius: 2px !important; padding: 7.5px 16px !important; margin=
: 3px 0 3px 16px !important; white-space: nowrap !important; width: fit-con=
tent !important;
	border: 1px solid #666666">
	Report&nbsp;Suspicious
    </div>
</a>
    </div>
    <div style=3D"clear: both !important; display: block !important; visibi=
lity: hidden !important; line-height: 0 !important; font-size: 0.01px !impo=
rtant; height: 0px">&nbsp;</div>
  </div>
<![endif]>

<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
<!-- Email Banner : END -->

<!-- BaNnErBlUrFlE-BoDy-end -->
<html>
<head><!-- BaNnErBlUrFlE-HeAdEr-start -->
<style>
  #pfptBannerqpx5gfp { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D2D0D0 !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButtonqpx5gfp:hover, .pfptPrimaryButtonqpx5gfp:focus {
    background-color: #afaeae !important; }
  .pfptPrimaryButtonqpx5gfp:active {
    background-color: #8d8c8c !important; }
</style>

<!-- BaNnErBlUrFlE-HeAdEr-end -->
</head><body><pre style=3D"font-family: sans-serif; font-size: 100%; white-=
space: pre-wrap; word-wrap: break-word">

&gt; -----Original Message-----
&gt; From: Pravin Pathak &lt;pravin.pathak@intel.com&gt;
&gt; Sent: Friday, May 9, 2025 9:54 AM
&gt; To: dev@dpdk.org
&gt; Cc: Jerin Jacob &lt;jerinj@marvell.com&gt;; mike.ximing.chen@intel.com;
&gt; bruce.richardson@intel.com; thomas@monjalon.net;
&gt; david.marchand@redhat.com; nipun.gupta@amd.com; chenbox@nvidia.com;
&gt; tirthendu.sarkar@intel.com; Pravin Pathak &lt;pravin.pathak@intel.com&=
gt;
&gt; Subject: [EXTERNAL] [PATCH v1 4/7] event/dlb2: support managing histor=
y list
&gt; resource
&gt;=20
&gt; Add support for setting application specified port history Set HL equa=
l to CQ
&gt; depth when inflight control is enabled Added command line parameters
&gt; 'use_default_hl' (default: 1) and 'alloc_hl_entries' - When 'use_defau=
lt_hl =3D 1' *
&gt; Per port HL ZjQcmQRYFpfptBannerStart Prioritize security for external =
emails:
&gt; Confirm sender and content safety before clicking links or opening att=
achments
&gt; &lt;https://us-phishalarm-
&gt; ewt.proofpoint.com/EWT/v1/CRVmXkqW!tm3Z1f8UAnV69S-
&gt; 8OZ3abn2jU1Fw7JxGFGecPxaCk1uQu97fQz1QdXWof_KxtumPzB31X_fWX1Ns4
&gt; HIeAFdHnOYAiGPs37vC1U0$&gt;
&gt; Report Suspicious
&gt;=20
&gt; ZjQcmQRYFpfptBannerEnd
&gt; Add support for setting application specified port history Set HL equa=
l to CQ
&gt; depth when inflight control is enabled Added command line parameters
&gt; 'use_default_hl' (default: 1)
&gt;    and 'alloc_hl_entries'
&gt;  - When 'use_default_hl =3D 1'
&gt;    * Per port HL is set to DLB2_FIXED_CQ_HL_SIZE (32)
&gt;    * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
&gt;      is DLB2_FIXED_CQ_HL_SIZE/2
&gt;    * command line parameter alloc_hl_entries is ignored
&gt;  - When 'use_default_hl =3D 0'
&gt;    * Per LDB port HL =3D 2 * CQ depth
&gt;    * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
&gt;      is DLB2_FIXED_CQ_HL_SIZE
&gt;    * User should calculate needed HL entries based on CQ depths the
&gt;      application will use and specify it as command line parameter
&gt;      'alloc_hl_entries'.  This will be used to allocate HL entries.
&gt;       alloc_hl_entries =3D (Sum of all LDB ports CQ depths * 2)
&gt;    * If alloc_hl_entries is not specified, then
&gt;      Total HL entries for the eventdev  =3D num_ldb_ports * 64
&gt;=20
&gt; Signed-off-by: Pravin Pathak &lt;pravin.pathak@intel.com&gt;
&gt; Signed-off-by: Tirthendu Sarkar &lt;tirthendu.sarkar@intel.com&gt;
&gt; ---
&gt;  drivers/event/dlb2/dlb2.c                  | 220 +++++++++++++++++----
&gt;  drivers/event/dlb2/dlb2_iface.c            |   5 +-
&gt;  drivers/event/dlb2/dlb2_iface.h            |   4 +-
&gt;  drivers/event/dlb2/dlb2_priv.h             |  19 +-
&gt;  drivers/event/dlb2/dlb2_user.h             |  24 +++
&gt;  drivers/event/dlb2/pf/base/dlb2_regs.h     |   9 +
&gt;  drivers/event/dlb2/pf/base/dlb2_resource.c |  74 +++++++
&gt; drivers/event/dlb2/pf/base/dlb2_resource.h |  18 ++
&gt;  drivers/event/dlb2/pf/dlb2_pf.c            |  29 ++-
&gt;  drivers/event/dlb2/rte_pmd_dlb2.c          |  23 +++
&gt;  drivers/event/dlb2/rte_pmd_dlb2.h          |  40 ++++
&gt;  drivers/event/dlb2/version.map             |   1 +
&gt;  12 files changed, 422 insertions(+), 44 deletions(-)
&gt;=20
&gt; diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c ind=
ex
&gt; 24c56a7968..cd843bb9d0 100644
&gt; --- a/drivers/event/dlb2/dlb2.c
&gt; +++ b/drivers/event/dlb2/dlb2.c
&gt; @@ -727,6 +727,50 @@ set_enable_cq_weight(const char *key __rte_unused,
&gt;  	return 0;
&gt;  }
&gt;=20
&gt; +static int set_hl_override(const char *key __rte_unused, const char *=
value,
&gt; +			   void *opaque)
&gt; +{
&gt; +	bool *default_hl =3D opaque;
&gt; +
&gt; +	if (value =3D=3D NULL || opaque =3D=3D NULL) {
&gt; +		DLB2_LOG_ERR("NULL pointer");
&gt; +		return -EINVAL;
&gt; +	}
&gt; +
&gt; +	if ((*value =3D=3D 'n') || (*value =3D=3D 'N') || (*value =3D=3D '0'=
))
&gt; +		*default_hl =3D false;
&gt; +	else
&gt; +		*default_hl =3D true;
&gt; +
&gt; +	return 0;
&gt; +}
&gt; +
&gt; +static int set_hl_entries(const char *key __rte_unused, const char *v=
alue,
&gt; +			  void *
&gt; +
&gt; +	return dlb2_set_port_param(dlb2, port_id, flags, val); }
&gt; diff --git a/drivers/event/dlb2/rte_pmd_dlb2.h
&gt; b/drivers/event/dlb2/rte_pmd_dlb2.h
&gt; index 207ce6a3fd..3f529860ba 100644
&gt; --- a/drivers/event/dlb2/rte_pmd_dlb2.h
&gt; +++ b/drivers/event/dlb2/rte_pmd_dlb2.h
&gt; @@ -91,6 +91,46 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
&gt;  				uint8_t port_id,
&gt;  				enum dlb2_token_pop_mode mode);
&gt;=20
&gt; +/** Set inflight threshold for flow migration */ #define
&gt; +DLB2_FLOW_MIGRATION_THRESHOLD RTE_BIT64(0)
&gt; +
&gt; +/** Set port history list */
&gt; +#define DLB2_SET_PORT_HL RTE_BIT64(1)
&gt; +
&gt; +struct dlb2_port_param {
&gt; +	uint16_t inflight_threshold : 12;
&gt; +	uint16_t port_hl;
&gt; +};
&gt; +
&gt; +/*!
&gt; + * @warning
&gt; + * @b EXPERIMENTAL: this API may change, or be removed, without prior
&gt; +notice
&gt; + *
&gt; + * Configure various port parameters.
&gt; + * AUTO_POP. This function must be called before calling
&gt; +rte_event_port_setup()
&gt; + * for the port, but after calling rte_event_dev_configure().
&gt; + *
&gt; + * @param dev_id
&gt; + *    The identifier of the event device.
&gt; + * @param port_id
&gt; + *    The identifier of the event port.
&gt; + * @param flags
&gt; + *    Bitmask of the parameters being set.
&gt; + * @param val
&gt; + *    Structure coantaining the values of parameters being set.
&gt; + *
&gt; + * @return
&gt; + * - 0: Success
&gt; + * - EINVAL: Invalid dev_id, port_id, or mode
&gt; + * - EINVAL: The DLB2 is not configured, is already running, or the p=
ort is
&gt; + *   already setup
&gt; + */
&gt; +__rte_experimental
&gt; +int
&gt; +rte_pmd_dlb2_set_port_param(uint8_t dev_id,
&gt; +			    uint8_t port_id,
&gt; +			    uint64_t flags,
&gt; +			    void *val);
&gt;  #ifdef __cplusplus
&gt;  }
&gt;  #endif
&gt; diff --git a/drivers/event/dlb2/version.map b/drivers/event/dlb2/versi=
on.map
&gt; index c37d2302cd..be5a8f6f2b 100644
&gt; --- a/drivers/event/dlb2/version.map
&gt; +++ b/drivers/event/dlb2/version.map
&gt; @@ -7,4 +7,5 @@ EXPERIMENTAL {
&gt;=20
&gt;  	# added in 20.11
&gt;  	rte_pmd_dlb2_set_token_pop_mode;
&gt; +	rte_pmd_dlb2_set_port_param;
&gt;  };
&gt; --
&gt; 2.25.1
</pre></body></html>
