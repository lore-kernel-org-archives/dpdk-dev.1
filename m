Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A3FC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 17:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBE340268;
	Mon, 10 Mar 2025 18:38:35 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 985B9400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 18:38:34 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGjXrm006683;
 Mon, 10 Mar 2025 10:38:33 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45a3vh03qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 10:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lU76aSAdAwSXaYwrNw5Ri4d7C5upNS6o5zcdZdBUFsI4288R6ex5eEfXJJBB7k07BoU52FfDMjofDr/YXroVyMNeSN2Sj7dtbeA5MXj3ZyS7ayW83IxIvZwR/e/D4sVfnSjFLblT/Blb+92AQxfiUkkLPN2iE4jDeS0Q5KgEFnbSVGaarUv8pGstQD5fQJfcthaPd/aLUfZSIAvOwJVkfedQxpdykyrKvp8mxff/6OV/ldaIP6Es4tr9sSyem+DOhi1gu5/sKek3JRHfDKQ7tlDZG9KSYdUIHAq8aO4VpJAxT6lVZDnBp9dJu2fsEenVyJc2JJIfviQneuBo6u9IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtFEhHq9Hzt2jS9u4gXsE6Wr7NMamhdp8T2rXedhEsE=;
 b=iZES/D5NjT1BA96OA4oXZsVGkN1U/0yO8QAxQOxLFLeOxFCqjdqAfqfVIsTuPs6xQu7piAwdzAJifePk3AYCblwZF+qnLhEeZiXNpueLE9DnbHcVYZ1zlGrapnv6QzFmoBWS2WvauMaUIOoGuHlqeK2UY4xzXesx00hhB5KhaD35QC0gbIXw5RBc8dT2jaisaH96kB/AX5wsZl8u2/K2Z38nP1imHzc0HktMjItFfNpEnpnhsMf7E0G5nTHgoVGUw8L/Lfkq5khtaM5giuCSiZgcSz7h6Wy6/ED62Ngjnf+nP44P22Z1N7GE/W9csAhbmQ/obzo8tZAD98f4fISFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtFEhHq9Hzt2jS9u4gXsE6Wr7NMamhdp8T2rXedhEsE=;
 b=r6XZMu+DM771qzJV73mtCxZRA+0VS7jP/TSGm4WEs4IBXCbfnYQNQZYBYkciPgy8GzyYWkUTFLrxKIah/PazxnSNL+OMxN5VwTUz6enMJypFTGpsEnYKvkTrvb2uDDo0IJV5Ooukm7ejvLOEzMqWgfUcU6lq+meiP9V0cGzH8v4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB4054.namprd18.prod.outlook.com (2603:10b6:510:2c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 10 Mar 2025 17:38:30 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:38:30 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Brian Dooley <brian.dooley@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>
Subject: RE: [v2] app/crypto-perf: add RSA support
Thread-Topic: [v2] app/crypto-perf: add RSA support
Thread-Index: AQHbiURZpHTqdpJcqUClKUxxYPZ+9rNss8dQ
Date: Mon, 10 Mar 2025 17:38:29 +0000
Message-ID: <CO6PR18MB4484DE75DC54CAEDA7A327FCD8D62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <72eb6cf47e9f475913d4e0c50c0983008efaec2a.1740159804.git.gmuthukrishn@marvell.com>
 <e19c3994186ce5e0d4693425ef700290008a2239.1740680261.git.gmuthukrishn@marvell.com>
In-Reply-To: <e19c3994186ce5e0d4693425ef700290008a2239.1740680261.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB4054:EE_
x-ms-office365-filtering-correlation-id: ee7cf3c6-c2de-44fe-b2f4-08dd5ffa5f35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?abddy4A5UdX+U2+1Uf99N0VkkyWeeejD21koXrVaOV5acKeULU3otJObR7no?=
 =?us-ascii?Q?80BKzHonjRoS6KMdwJ9ys6wOrWp2k58rp9Bbhh2OAIDfWgFoELa62DrTWob+?=
 =?us-ascii?Q?yBAlvct/GsD143p6z7Wb5i9QLs2r/ikioTG4cITFBCFs3DMloAFO6ZZDD49e?=
 =?us-ascii?Q?ZVY/7CnD2qoPaUgH/nalu/i6y1LsISjI/XVX1pFHkC49zSbQn1zRvO/3woWb?=
 =?us-ascii?Q?bsyGLWu4aICUsRYDVKS+nqks0E5+zeIrhwey/YrQV8Nq89erFGCRXtiugJu3?=
 =?us-ascii?Q?oxBm+TvTqoBSFVvhirjfhOiWEGCRBsU+35X+dPJKBqgsYNGJwfqAj+SEYD/e?=
 =?us-ascii?Q?ZWwgLT/dxusSRZtBPUQnDZ4hgo4+eswTOX+npis1HaoiARquT3/b/0HqNmE3?=
 =?us-ascii?Q?h/PF6uG53qanzCZEWl/yJWblr2DjsYMkOC1mTaAdzlhw6PZRxyhJAGIV3XoQ?=
 =?us-ascii?Q?VDceSSf1DddVHOJmt+Wh/8kPVlIfxbV7DBsSbjowDPrIDmQ/GZkLZ4ooxxFu?=
 =?us-ascii?Q?IwaBp5VgFU2mnO5eJIGlGwhtX4v8BLgqjHl2t3VI+JVcGSKDhdLumLdmy/ks?=
 =?us-ascii?Q?TcxaLOhf2bshiY+4co17bXetWjd6BDYBoyFwNoXOwOXR/iirh4+0sJO2cSHi?=
 =?us-ascii?Q?fh/XZCks4OnYhyerw9VkrSsAc0vJoqtNibm3l9hrwuOFyt/pVv3il80YPKy7?=
 =?us-ascii?Q?pIl164TN9pW9YcsQdO46bfKD+O+mFi+R5yoPaeKVotlSzioJMD6fX+lSBskp?=
 =?us-ascii?Q?jqcGGWb4Rl7NOSd1zrCT6Ges+jUNC53V++QmcbxXSOkCqdwPhmUjmKbO89yF?=
 =?us-ascii?Q?C3yI/RnyuTfQ/r+GaNONfz7KuvlnuPWtaI/GLeY3a7hnt+3PIzQBM+3vqN9h?=
 =?us-ascii?Q?IhIXeWalB25VHKghOSxQssofJt74qujWDwkLhSXu2fDQom9suqw51rSsKFtz?=
 =?us-ascii?Q?zJHnrHR0yVbE/2aWHcKUJmFCd+BXWeW9Ka7gET2tVxHJZ764gttO2Dr9QGWd?=
 =?us-ascii?Q?lLWIsyZmHuOgY8OvBCzJJKHDCkN2wuigun2NU+P4w3ghu+sSkbXFi3eeG5Qo?=
 =?us-ascii?Q?mzNJUVNL9r+hoNSNxc5gAfNC7imalI9dmIVjruo+yIExLyZWZeUaV+MnieMT?=
 =?us-ascii?Q?dLqkbawg7G3KSPdLVoaWntv4fWbJnhqf4BmtxA57ZdmA9skW8vrGml5KEaXX?=
 =?us-ascii?Q?WcO9Qa0dbO5s90BQmdypbVSPtpfJchMS3SHj/CRw2oFN+C9DUL0OsF1btMZO?=
 =?us-ascii?Q?28hqu1bY8+Z7+G2gOKAFdXLNxlOjXyiitsK0BXixEU3U3OZw1v0q2lAyn8Bs?=
 =?us-ascii?Q?R587Cnev3XXEPz7zdDnj9dpT1um7K/maRSwQmaeo+VMj5/sYKguqdOcvsebI?=
 =?us-ascii?Q?vl9k24Zfz4Fdn/l1MMU088ybotSvvyatpEoKsdq77EHnnFcJPljPXbb57k0x?=
 =?us-ascii?Q?nLLpLVRyy821nSSU+Vq+1ue9+NudxZDD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9tBdztGbsEPcHnHzvmegIT7gDdCO+8MEaauz5Up3s6G6l5tTezUqSapAT/f4?=
 =?us-ascii?Q?kUlfGYuSeZtPoiS9lclhJo60ehcgg/aCJfj4kxpHsjtSanJrwhSQklmpndFL?=
 =?us-ascii?Q?QK3Sh8IGZ2q8VUIC0nqviVoQXNSVVwJbK3cDxjs7GoCUsCIJP07VFgyP7Vbd?=
 =?us-ascii?Q?X3uqeRYgbLoLIJVR5MHLbM1DUcSUEqAjejSQcRcbWG3dthB+AOqBf8VNanMD?=
 =?us-ascii?Q?1hrtzsf1b64ThaU2TmbfdscqKPFBbJtfyRrcD9uFQ2EgF+lycdtnrtJw9AtO?=
 =?us-ascii?Q?zKiDOk0cXo6S+vHAwg6o2AosSt577x32tLK+y7KGmU5F0xzva3Ep1MOA2hLO?=
 =?us-ascii?Q?Lxw4FNKbj205QTg+c4X9JF6xqH2qc/wxmARVcUBmXc2smSJzlnvsHw0z1fmY?=
 =?us-ascii?Q?paj2QL5u8Fq9z6y9+IA0sStESZhcfqnHvLURMvxeyqZwbhOccDT9Umw7xCW+?=
 =?us-ascii?Q?aI5pXiowj8MaKYv1dsab1sGnqJ3gNgh6vM+7fHwvJpVmdjI6NtMbXfu1W5fe?=
 =?us-ascii?Q?tWfTX1laqc3Z3q/u2Rpw2dW/J3Wj7xVVN+naxOrMhA1B1uhKEGkkM0vhuoUX?=
 =?us-ascii?Q?FOScPT0pmICI2/zPAANELhB8og90I4MojLe39TpALb9yLUAs1nhuIBDlOlEj?=
 =?us-ascii?Q?0RykXsmZHRKNlMnuWLMJBflNw0Ezwy62jc1QPnBzIHl+OEePjCdrpJ5rO//V?=
 =?us-ascii?Q?FRKhPIKMSJKru9WUHxFW9+FpODR7DiJCXaTCUZw8mauYAn2nJAMGsDnB3/vS?=
 =?us-ascii?Q?aOtUQxp5h1/qcCrbjv7leXCVq6toT8sneBOSd6kE33mA8u9E1G6uvrRZyN8L?=
 =?us-ascii?Q?IkwvlVkjlO4IUxIttxF3+RV5a8FfQI9UovwhLiEqrC4M0/3fCcqFXfQiUpGd?=
 =?us-ascii?Q?Dqs0xRcZSr5SGoq0RgiK9c9Z77poifZfGkc4aNagSahVGnIrUpwML3U/JstB?=
 =?us-ascii?Q?+SpLmG6JjZF0V4wgLfY6H1ZBlZEu01R9LtOodO5uayILIQ6f/3SMeu1DHQO2?=
 =?us-ascii?Q?yqfFHlLwueN4IC3tIWPZZ27e5VW5dOrBahAiz+4aXnbRZu50KsxtayvUPVj0?=
 =?us-ascii?Q?LshlFDFg85gALi24d9ikjyI72U8CixcpMYkRJlRWHsy1T3rX99viNvn8VLE+?=
 =?us-ascii?Q?zZIpE+xDhBUkaq2AWl2r4OvaQcOa2QIYu/npblLyiknxKh2+8ZrnGqSXnKrb?=
 =?us-ascii?Q?/XKIvX1RyhOOD1GWUYoo+88d7tU7XQiSHphLTmDPHi4lLZ93OZSZ0EcxIhA7?=
 =?us-ascii?Q?Khr/eWl6b+iBfMknD9u5BMX40rrq3DWCbz+NPHJErFN5BBZAE7M3kANnLK3e?=
 =?us-ascii?Q?CDIs6cqBlJBNRhZhOyTNbw4IKIsUm0WcBgLr4f8M4hk0agf28058gySqxihz?=
 =?us-ascii?Q?9tuRf+rS9KDuE4SgPzStLIHszmjYHpGdNSEq+MyBSl89QJsNBwmnmVvWcBDG?=
 =?us-ascii?Q?TIa2uUYu8Wxijl1CbT7DX1MC0/Ft5jxbNCU0IPzAFtiDyrNGDKBx8LZzT1KY?=
 =?us-ascii?Q?7PX4a0oqcFl6QJsPb5SEh5drc20pC2ruxLEyP/xiaPMxR8t/Eo92ImUKuh7p?=
 =?us-ascii?Q?odMJ7hMQF9Sd7sfJUVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7cf3c6-c2de-44fe-b2f4-08dd5ffa5f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 17:38:30.0171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65t8iLoUDTXBR2205gsCiSFjomR99X4HJLYjcQUyOhkjLn2apr9xSfhB+OCTkjS2MKd8acoIZyZaiXoKn/5CtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4054
X-Proofpoint-ORIG-GUID: b8oqPh8QoSoAHtam9BpBYcbztcn7O1nr
X-Authority-Analysis: v=2.4 cv=Qqmk3Uyd c=1 sm=1 tr=0 ts=67cf2399 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=2T6qCWNNUAlGxcNGW7EA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: b8oqPh8QoSoAHtam9BpBYcbztcn7O1nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
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



> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Thursday, February 27, 2025 11:51 PM
> To: dev@dpdk.org; Brian Dooley <brian.dooley@intel.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Akhil Goyal <gakhil@marvell.com>
> Subject: [v2] app/crypto-perf: add RSA support
>=20
> From: Akhil Goyal <gakhil@marvell.com>
>=20
> Add RSA support in crypto-perf application.
>=20
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>
> ---
> v2:
>  - fixed RSA padding type.
> ---
Applied to dpdk-next-crypto


