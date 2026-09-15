Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A2C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 07:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ED7E406B4;
	Tue, 15 Sep 2026 09:13:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6D83C40290;
 Tue, 15 Sep 2026 09:13:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6ZXsY2902127; Tue, 15 Sep 2026 00:13:53 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023127.outbound.protection.outlook.com
 [40.93.196.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gpsc7syby-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 00:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T99cJ5vVInTyi6LrdGJcxlS2lO4o4vT41qy9trRuQs7MV8aLyyufxcq5eIh7psR5edppx+eZ5R5Z0GDRwpX2OAqImenNLKwrHgU6M/72GOHa7mb6AFgVuaKHZGrspvA+qyqNow4O0KRNtAYgM+EwJOFs2kgYAo4DBrEK3WciOG6JZWz0abHHl7/qrkA87G032kWecJ08OvRbAOiUq+3Y5l30kkSmeI5uGJqtB59dAgjtob8MdgGqlhT+0ROGh1WxekBc12sGouJjT/ZxZ5BFrzlZmt1JYSfNFogSYPsp9rtna0GNFnm23jj9wPP4MPW/I320NUpNIm3uUG+t8ubU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiP6EHguW9D6iBdVz45GUKY5BWyNLWbNxWJNo1atf8U=;
 b=ECFrOXI0WZfYUcleF9b3lTnuKQ2FDKi0jIRtyJ/V6d5CRjmrmBojEXxtuzNYyvns0TRyeVpRPO/cR+oI2UX8T0jR9ha5ehgrLq4ghbm/9eyth96Bby2eIEJe9SuPXv035uoiIsfKoeaVeJ6LvroKl+KMCTSXbsr42w/TrCFGoWBgq6sZOttZJconW/kkqocG8PJhTHXShhaepjdQpJWh2cM84yYq5R7ZIobVp/Gf3xiJSxR32lCDLdHdypLws9HOSbfrHXhHeIOuWvjfeKynBv/qcZxFNSV5AiHUJu3xsOnWj+XPc1gdHO130Qpgw/mclmqsQU6UTEsqStWXlki4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiP6EHguW9D6iBdVz45GUKY5BWyNLWbNxWJNo1atf8U=;
 b=mBvtNU1DsdpqqYGvQMmVrE8BsdBpSoz0mTa2VFZKOjGylZaa5AuoVorDGRn3HLnqBR+/wPYTqp1jcILiOa4U2AYg143u4qcrmS2IyCpTRXuYIacvXlnPKz7Yq5vo12bWCYloDm824Fj5izm/B4FErMpfMyM6d6JkmA6IcWiu+Po=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by CH9PR18MB141078.namprd18.prod.outlook.com (2603:10b6:610:311::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:13:51 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0382.012; Tue, 15 Sep 2026
 07:13:51 +0000
From: Ashwin Sekhar T K <asekhar@marvell.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Harman Kalra <hkalra@marvell.com>,
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH] common/cnxk: fix duplicate mbox alloc in
 NPA aura pool init
Thread-Topic: [EXTERNAL] Re: [PATCH] common/cnxk: fix duplicate mbox alloc in
 NPA aura pool init
Thread-Index: AQHdQEnyFaNe2oRy+UCe0WxLlpHZsLbGHzeAgAkjCNA=
Date: Tue, 15 Sep 2026 07:13:51 +0000
Message-ID: <CO1PR18MB47962DFB9B96FD9E2B86F8F6BFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpNCdJDJN77BFwFP4bK887xsRDtid7HxSZ=3yapW5mvNsQ@mail.gmail.com>
 <CAL+mCpOxM+AeN6ehfr5vVwQQ=1KSv8uivEC-Ng7j3tQ58cjbLg@mail.gmail.com>
In-Reply-To: <CAL+mCpOxM+AeN6ehfr5vVwQQ=1KSv8uivEC-Ng7j3tQ58cjbLg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|CH9PR18MB141078:EE_
x-ms-office365-filtering-correlation-id: 424ca5ac-5277-4966-61a4-08df12f8e504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2KFCaoeksnew7Jd2w4BgqNVJHL9ddfbCpRj6lq7Nq7cnwTNyR+cn62HemaE6xU5mlk0tNs0iHVPmjAERdN+vG88LwCixpf/sVohFuebkwqF1MTb4fnAkY9V6zZc5JETG0g1rlJt7vNwSx+AlA0LCjxtGESp2ywuJHA+jCn8MuZji3dYNCP4LMREWHq7lF65c2U/1PlOWl5k+IjJwElbc7SS080IRxkfS8rwHr1Yljx6px9P429RoggJRApEZ8E00i0EDelv8nE4ly/EMPNZOfub5rdACSYOZsSJS5DklYB3jzBxvzdkFKr5RDwzFsJidzFOsARDLs8zIjLVXyvH6akmSGqafDrln29K91x/lFDZx5wwtDkk/Qnp5yq9zwq+o2c15pveQ1C3OvF2N5AfP3WE/7IZpcTSMeDvZQqBgAP2N5OV2M/qOa5w4m297xAclIP1XQcu7Za2v9YspWEOTHSst+rCZiKSRZ8glWUkEquoyiSQp2fCQqYz406rho/fpa35+OCy5IujYEfQmlr+M651vZXH0d+xq6+0WkdVPxU4IKE3yMkrFYuphVxr2dv+j2h/1y7BvmhM7hMaSdzS0MWa/F3f6Mfx6+gcBt0N7k6xnL1YXjy9SlHzipLhqKRTjw6mkpzfygfHKemll3E935Q9ap8ZbXuBfOlUZmRZcuvFHuINksFoU3ynwXmoDM2Q+qN8J3gIqbjF4tn//6nTGSis5xeyK++CSMrLTkLklG9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTg3R25jWXc0TVQrcDVCWldrdS8xOXNCV1VGb0FvZDBCUVNNQ1o1Rmc3a3E5?=
 =?utf-8?B?b216Y1MrcWczWGYxRTV5K2tYbExhWE1uajhHZjlMZTBRa0pVTGdITFVHbjY2?=
 =?utf-8?B?V1NFMUFzM2R5bWFOTmVLS3dLaEY5QVpzTFhxeUVMZVcwd3h2Y2NGVGxxOTRH?=
 =?utf-8?B?YWNZSUxDMVljVzBiYTZNOGQwUlRvbkEwWjlRVnpFZEtNMzFob0RUbzBwWlZZ?=
 =?utf-8?B?OW5GaWJHUE40MjBUbnJlNVJmY0NKT3hSSEFzV0ZoQmhZck13ejg1bU9QWms5?=
 =?utf-8?B?bmp2T2NzTDBUNlEyY1RyNE5oVDRrWExwWGxPUFE5aUZ3S0JteVk5T2UySXh2?=
 =?utf-8?B?eGZJNk13Tmcwd2tZUHg1QkswMkU0VTFLK0E4cng1T2l6NCswbnRRajdpVGNS?=
 =?utf-8?B?OExoQkRyR3ZMdzVobmVYOHRNOE9ZSyt4bUpwKzNjZHlrUFRMYnVITGZSSVhm?=
 =?utf-8?B?c0Qzem5GQVdWV1FyWDl2NExrckt6ODE3NUpKTVNHL0hDS2VDbnNjK0ZETDBW?=
 =?utf-8?B?NVZ4ZmNMdUlLLzV3bnQrSVRNcDdXa1BtTlhoRGtsL3RRdlVSVjJqZ3drTU91?=
 =?utf-8?B?MHB3T1BZLzRjUForQ0F4dmtybUxFeHhJT2VGeWtnanJ0emE3VDdPc1pCcTQ1?=
 =?utf-8?B?VDZpaVRNT1JqRzlFNTdUa0tFeTMzODBzaW9KbDFCbWJsczlrUlVHWEZBVFlV?=
 =?utf-8?B?UkNZOVBaWnRwVGs0VUZTb1dkYkZ5RXhjN0g3SmpXazJiaDNSZXhmRE9hWWYw?=
 =?utf-8?B?N2lHU3Y3blZ1Q000M1I4bWJnTGZ5ZjJWRGxaNFpTbldjZkl5bmk4WXBqT0NE?=
 =?utf-8?B?d0M0WlJYcXFuaDJ1bVM3ODJ1V3l6T29PZk1ZS0R3TmxTc1Y3S0ZEYWRiNlhW?=
 =?utf-8?B?bEx1SmdoQkdKTGt5MXVPVlpRM2kwUVFNdzlrUjVsUCtTV1U1VGFrS0llR1Br?=
 =?utf-8?B?bHpBL0RLbi94bnR0cGxCTW8yTWFBQ2tiQjNEbEYvWDRTRGxFemJBSU5tTzVE?=
 =?utf-8?B?VXVhVmhUSTY4djRHT1J3LzExQkJ6RUZoT0g4UXBmRzRyR2RZRnZqY3NhRlZM?=
 =?utf-8?B?NDJJUFRkUStSUlhabTJmMHBjVHo3RlBHUU9SbXFibTNmcERNVzAzTWZYTklY?=
 =?utf-8?B?TkkxSk14L0lHcG9saVZ0RVRHU3lzT0xodWxaYU9vSDNnd2dGZitqT2dMQ2lW?=
 =?utf-8?B?U2UzVmR3TThTeHdNdGZuQW1VWWNyZGZreEVpQ2RyTVZEWHJaOWV6NTVqMnly?=
 =?utf-8?B?Y2hvZHFUNmNRRGhUMjVKUVhXUzFOMFR0ZGFSdFAyVU1MeXJMZ2o3Q3dtNjd3?=
 =?utf-8?B?bWcwaW9FenFGaEFaWWQzUkhXdm1WMitIZElJZzJCRUh3RU5TVWxlY05Nb1hp?=
 =?utf-8?B?M28wd0xJem9SVGdRb2J2L2x0SGlWU3U1OVdhTmExUDh3dGpjVDFwRksvZFph?=
 =?utf-8?B?VnBUc3llTWo5Wk5taENIenJVdlh5dlBWRUZJaUxzK3p6WU4zQnZ3ZFdLQ0NT?=
 =?utf-8?B?eWZEc2RxczcvNG85cjFLYXF5bFZldzJqc2tyVnUyQk5heEpIT3NNcU81eU9K?=
 =?utf-8?B?TENieHVSUHRmVEREbDZXNy9YYk96OFo5TzJqOWIyNXluUG41Wm52WTlUVTJo?=
 =?utf-8?B?MXo2U2tnbDdpWkJoZ0pacjNxdkYzcEMzREk0Um5PbWJjeXIwTmN6RjhOcWtE?=
 =?utf-8?B?ZFg1MnQ1YkNodjhxZ0FoTUo5dm5nbTBFenBkbVJvRVJNVXQ2V1Z6UjkzMHBO?=
 =?utf-8?B?bWlvYmlWbVVhY3BpS1IxWVpUN0NFeUsvV0xKVzVwVkFROVpPbFZEV2lxVTlF?=
 =?utf-8?B?d2ZHc3UrM1dFYmhFWERxUzNLWkc1bGovbUFnQTVQa2hQQ21YNHEyWE5wOU5m?=
 =?utf-8?B?TWNQYm5BcXFDYlZXYTFHSjJPKy85OHA1L2RVeDBYS21waWlFNVFpOUoxelFm?=
 =?utf-8?B?MHJzN3YwOVorZlE4RnNaZ1dpam5PY05Wb09XbE5LcEQyZmVVbHNLWElmMGda?=
 =?utf-8?B?SXhHT2hrbTUvWGdlZ1BhSGYxZDFLVUt5MmdacjFFcUxSSTNjbXUxMVlsN2Zn?=
 =?utf-8?B?MHVkc0FEODRsLytQeEY4MjMvM0VwenJxZmZkK1VFQXZYTVp6bmltbVRwRlVO?=
 =?utf-8?B?QllUQWlCRHJuN1F0R2YybkV1MWIxcGtNRHZRVkVtY1dWL0gzK3dyeDVYeFQr?=
 =?utf-8?B?UTVoYllmMmpaQlBvMHNrdEtiUE4rbi9MZDBKTU9LdEF4cmsxVlJmNjFCRUd2?=
 =?utf-8?B?RkRVb3RLMXE3WE1xdExMQ0hUWDRNMHBPVitKR2RyTE1oQzhQYkxHcWxBRmQv?=
 =?utf-8?B?Mm1UM2RSSml0dCtja1pyMlNFR1B4MEd4dXdVdUV2UWU2bVB2bVo0VlFIMTVN?=
 =?utf-8?Q?gcABQ6pTNNYfcAuxJuJjcwFW+2BP3H0lm5vE+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ocyJfTnRWwCu0wyo+RndA5tgdG1YK1b5wbIoRgsBaNfobAtEVwhqF5ZgntE1gj4H5zpATP9Kuv5UIt3qePlC9yecZcg35hrsQzxMYUnYvLNw+/7V2MxLTUPimvank6nZMdfl7Za/kwoIOBH7jSDrl9q+M0kBjR9LRygOlLUAW9d5ZfPh5z9PUVw4ldW3pjItJ2MqpVVvTr8/N1e0B6+qAqgwX6Fzx8V8PMtVBQYA4CsuH+5EYNynDjm08Es7o+Jgot5XMcjh7bweB6Mz1vjfyPJcMbmSHS30PCG5QAb3OzPh9f4UUIvXcv6Ug0eY3uj+pW5mgXVdS6C6lUsFakbjqQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424ca5ac-5277-4966-61a4-08df12f8e504
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 07:13:51.2964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F482QCWCJ8gp7PbvIsQs5AWlCrVj3wXr4/b/7QgYBW29nA0PXhKvEGWiIZrfE03dusz8xjd0khOsraquDcPF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR18MB141078
X-Authority-Analysis: v=2.4 cv=aIhlOr9m c=1 sm=1 tr=0 ts=6aa8f031 cx=c_pps
 a=wzgbdcG65ZVbW594nUvNmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=qYdws7VecPJMLTrF0EYA:9 a=QEXdDO2ut3YA:10 a=h4KV_7obaVgA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: S5sGvMjw4BvNaLm8X7xN5D5VX3kmbmGu
X-Proofpoint-GUID: S5sGvMjw4BvNaLm8X7xN5D5VX3kmbmGu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEwMiBTYWx0ZWRfX+ocMR6KeUSmK
 1RF5EX53j9M9xdHKCEzh3drZWkWZCPDZUAOlD8gmdEBAAP9Lu0/7X+u4qC7/CkWWKhJOe4lQ5vI
 QPlcwEvfzTtvftdFlrpysPHqnm7knUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEwMiBTYWx0ZWRfX/oGVZjXe6zip
 mmQtRrIYT2jTkJ+DoBmg+ZnQ2vIRRzv80LDSbSp/srhg89XHPF+1EuaeRQb6sucds5iVU+KpOAt
 kaQMEsuTuYhHQ85JIr49/P98eAZyjfv9mKAF0AEO78amlvxUvum2roTuMacp4QqA/K/kI8nuh0C
 lmiCWfjPUGSvjVZSOLVfuSOHSCBiJK8oUwPYwqYTVy+w49U72LXtTFN1Oo+QwF25bdo2Vscv09G
 9SqFtX1ZvIRxkFpSWOcM3MpF9PpVQ+jyWDqGmc7F+RBTgSjqE9ASujcJmi+fUb9OBFFk5tClG5E
 VYClLcRxGxaXWlZuOWN9zje3gltjwry/Cn+QfZ7O6WejRG1mKhYwS3WsuCSb/3Du9FkdhPc455c
 PKCReDjVHvUpukTCPLOt4api0ZZFNlYeZio1roiHzxT0zhSey7y5UafhexsN2KFwNpZ65Ficu+m
 iYhCpRoanJn94XYlqpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
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

QWNrZWQtYnk6IEFzaHdpbiBTZWtoYXIgVCBLIDxhc2VraGFyQG1hcnZlbGwuY29tPg0K
