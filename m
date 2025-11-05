Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39943CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 04:07:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DF3E4029C;
	Wed,  5 Nov 2025 05:07:15 +0100 (CET)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by mails.dpdk.org (Postfix) with ESMTP id 8922940269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 05:07:13 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A53GXeS023262;
 Wed, 5 Nov 2025 04:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 corp-2025-04-25; bh=TY6CSJ6zNBuO43JnOJQeBSCG0Z/oVnLL3gJQyK/0csk=; b=
 RRvbHQskecMNY8m7ZZy3Zv+1MrNwPkOxZ06z7sggJXlYAf3mt0qsTDHgrBcfiD1g
 WewSN1gj7o+5mZOGNRtEPE4ff5HRJ95pbya+Dpo0Qjew9+EY/b00Vipbrukq6Nx4
 GYpABW0fsL6YDI4FMDCARpRIHTSuROZgXRi6fR8sxIAa7CRBtDbIEkOJQTATxFNG
 N24ARTqeYSJ1boBHr3gL6rsKA+x2XIGkSwEKw5AOglnOvBnX6YO23uPFSdCjVzqk
 a2MVmd4h2HcNhZ1/Sm1WBt/4ifN80GdAQd8lMJFpkrrWRsYeB/m1jEpMKl7hMTZS
 FJggSnMnmCxYocaiE8dvvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7xhdg251-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Nov 2025 04:07:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A526C3E005313; Wed, 5 Nov 2025 04:07:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nafpnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Nov 2025 04:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKn4I2emFd5jQs0kuLSdCOy8DwoQ0UJVnARkduteo7ElVAXyfTws1lMwl0AnRyqZA08lsIuUEnbAQpGr1x5pWSH8noIvDqmZxZO7sfUHibIB294t4618qAekyANM0pluOTWolwPrDIaXZNoXA0q/tjyj0wGBt8/8Ue3Xt32q9ADPzWfmnm3H0U+FdX2twjtRzHO1pcTpaeMC9AHfwkdnItWB9UsmWXtqkgaY/3LTZmJCrrRBTRQbqTqulhTsdVB7MD9jaEqmwtgwdQCwkYO0Za+hokYGbknTQnX93SSKf8itCpx8+hJIJxVONNtuZrakj9o+IgVa7RV02biOoG1dlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY6CSJ6zNBuO43JnOJQeBSCG0Z/oVnLL3gJQyK/0csk=;
 b=EVpyb8QpBVPNy6pFMBxhO54FOF9aIFvqXvw+hj8i2S9iLMTTIvTHCAt4FOrdzv6lItjcu2JTdZD5i4XRSoqjCil1+RWdnLnT1+wXIPyySKaZPUXdlrAXZTvekr6ZRf+MEj7q0Or2HgwBgi1kf1sli3EZ5BAzwIFXErYgXDH/yvvfKzgO+lGyP0KI198YyBja9xsapEiWl4FKf9yvkxb6sM3TMgWBfJXxObHXBAVpPPc2GhwoW/wYwvYiS8LpYjt1ofwLrWyIdxtTg34AGb1eguBkPMmP32bQ0Dh3zkYJNO1AZxTELgFZFv5qy8OxKRIfTla3c9RiUzmIm1MnNxIOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY6CSJ6zNBuO43JnOJQeBSCG0Z/oVnLL3gJQyK/0csk=;
 b=HmLR3IdrHz7H2N2PomaaUX2BRlhrjzF5o6MaXcZkt8wTiY1LkNBdKPW8uKTXVHpse9Pv5ioRcdvLgaEf+w9ghmyTxQsqER8d4syb0D21KsjOUzApRlHw4SjDGF8H38k+mgV99vbUArE8cgSoM2TB1L8F77gTNCOQ53t91oRDpIo=
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by SA1PR10MB997557.namprd10.prod.outlook.com (2603:10b6:806:4b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 04:07:09 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::9e32:8547:94ea:619b]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::9e32:8547:94ea:619b%3]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 04:07:09 +0000
From: Banoth Saikumar <banoth.saikumar@oracle.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>
Subject: Query: Missing acl devargs option for PF in iCE PMD
Thread-Topic: Query: Missing acl devargs option for PF in iCE PMD
Thread-Index: AQHcTglRpcnAJyZ76kKo6UuEV42izQ==
Date: Wed, 5 Nov 2025 04:07:09 +0000
Message-ID: <BY5PR10MB437077A6A6E6217AEE718B8A88C5A@BY5PR10MB4370.namprd10.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?Windows-1252?Q?MSIP=5FLabel=5Fa4de43ec-192a-49eb-8e54-baeb8c71bbbe=5FEn?=
 =?Windows-1252?Q?abled=3DTrue;MSIP=5FLabel=5Fa4de43ec-192a-49eb-8e54-baeb?=
 =?Windows-1252?Q?8c71bbbe=5FSiteId=3D4e2c6054-71cb-48f1-bd6c-3a9705aca71b?=
 =?Windows-1252?Q?;MSIP=5FLabel=5Fa4de43ec-192a-49eb-8e54-baeb8c71bbbe=5FS?=
 =?Windows-1252?Q?etDate=3D2025-11-05T04:07:09.192Z;MSIP=5FLabel=5Fa4de43e?=
 =?Windows-1252?Q?c-192a-49eb-8e54-baeb8c71bbbe=5FName=3DConfidential_=96_?=
 =?Windows-1252?Q?Oracle_Internal;MSIP=5FLabel=5Fa4de43ec-192a-49eb-8e54-b?=
 =?Windows-1252?Q?aeb8c71bbbe=5FContentBits=3D1;MSIP=5FLabel=5Fa4de43ec-19?=
 =?Windows-1252?Q?2a-49eb-8e54-baeb8c71bbbe=5FMethod=3DStandard;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4370:EE_|SA1PR10MB997557:EE_
x-ms-office365-filtering-correlation-id: 408d4979-57c3-47c1-6844-08de1c20ca6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?nNVGNCc1hFrJ18JVAIkx1BLaCOoA9Rx6DrET/OexKobncXCXBIduW+fi?=
 =?Windows-1252?Q?cnzdzYyQAl3igRCZ4B2hLMCkLOhcvubq8MIAdjTbHjUYCvTxnSajPCRq?=
 =?Windows-1252?Q?iQIGARkMVP0TUFPgYYetB9XnwsuK6mpb9bXUt/4JqbDDdGWszOCQz8U8?=
 =?Windows-1252?Q?kQnNWylRF5J2aJ5AMMlBanQhhw+Oyd4ajy9E2NurZ1OxrmEPjGLuLR0h?=
 =?Windows-1252?Q?/ukHdMglTi3kKOJ3YMcl5nDFANQGRTcsTliteisCWU71Wlqbx8BJeeIb?=
 =?Windows-1252?Q?CXwMiAFxHe2tal8I62Z1JbfjnK05FnxVjSbxm3/LJtht2iXY6jGv3Sur?=
 =?Windows-1252?Q?aXozKyKPOVyLh5wqeU5fjNV7jGJTsoDruYxUj1PwO0sFUBCbzzqHgVyn?=
 =?Windows-1252?Q?nUSDiXpwhcGt+4CU9BY/JrhUJnbRN11Jmi9V7+j6Whv9duE1iRMOSpYG?=
 =?Windows-1252?Q?5GB2hq+x41SdQ4D7tP8Vc1CBqjeKkQ88hB5jDhIR9lEzOMSxQ7T9mlsJ?=
 =?Windows-1252?Q?BetQhcuOK69cR0B4JD2tBE5UbIFZgd/8QbgUE7zVuZmdGGHijraymNTc?=
 =?Windows-1252?Q?JDOgy8z8qzwSO6IAAqG5FINWIA2sOH2/qdXOwTlHRRDMYVixJVNSHUyK?=
 =?Windows-1252?Q?KF5YYZyTZHaZxYYi7L1xBrvJj7lzsav4VxxZ0ttDYHeXw0J+d2nnNogd?=
 =?Windows-1252?Q?ntPSFQGL+noGX5rxEjVEev1JopBtne13mNlTqCMl7nOHiHiGBO234wFa?=
 =?Windows-1252?Q?i8wt543KZaOD+ToCjxus9pssDx6YovQQ2cZfWkL2kHJpB+uv8IfDYgSk?=
 =?Windows-1252?Q?K+gOa7dDhWDU8p53I0Nl8T24TdWmlLmjC+vmu4bzCaUKeB4q6Z6HGBC+?=
 =?Windows-1252?Q?b7WiXyp7Z96uQDPPtdGFSjBGwh65QliJ7Ele/tx1re/QuVSvVRqPxjiD?=
 =?Windows-1252?Q?tngGeFyueH/TpIJAIoxmhpv0qX90RohXPYkrmEipNYR67nPLo8oaXUq1?=
 =?Windows-1252?Q?zM1jsh3CG4f3FRF0wmY84rz06Afwsb8J/PzDhACneihj1mrd1hYdPNfv?=
 =?Windows-1252?Q?XtwOdoA2mxXgAsAsTlj0DFz7Q3qb9ol9H1w8gNS2gfbEy6xcoxdP6mXX?=
 =?Windows-1252?Q?fi24kXIVl4dncXX7qeDWAETeF+GwmE7KRCjQuxGLC0nmYq6Jlieryx44?=
 =?Windows-1252?Q?rfvDk/MjaxXUPQxnXeL109TgjsF4cfty0kB20o6ySFiF6VjgUty2pSg7?=
 =?Windows-1252?Q?Zhmn2vPmqHejnAVsSC+hNH2aV/HqqmF43uhELqHr74lj0Sm10T78vyhM?=
 =?Windows-1252?Q?ZV/4llT94Ci4wo8ZQNTKRywmKtzr0yqiTo513hQqYBp8D8uuPfRrwYLq?=
 =?Windows-1252?Q?8hP0ke+ziHF+Q10Z1S9qdh07ak7+G+dy9rrZDuVSD7EXfdVBfE8zjFRQ?=
 =?Windows-1252?Q?f7T3v56MOuIZoB8vGwyKpKiXw3iVE2FbW6lCRIxrLnKyvPiwT0okhtay?=
 =?Windows-1252?Q?Ew2wsIjltGD43rEDCdWj3LLg0ArL3Z66YiQERpcpg/6fQr52y2Ayjtk3?=
 =?Windows-1252?Q?RwyquWOwa145itMm8IPAIjgGV3MPFDgh8sXIC/9238+uDJaJ91H75+6I?=
 =?Windows-1252?Q?XzoKDcYW4teD9fyPf3LpoQlj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB4370.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Ul81bSrcQaYmhHXwTGp6rg+skLD2UKg2Ic2jgFbbLZ2f+69gZRnFIQWZ?=
 =?Windows-1252?Q?vmx/aGQRKQVl460SjkRGu68C05PnAd73/TSvbDebMa1F+VOvdMwwvEyw?=
 =?Windows-1252?Q?vuQz2SQJyTN9ENqNMERes/vaHtROp7RQbwGs5rvmiiufzBZs0ajq7s7J?=
 =?Windows-1252?Q?iyEiVlOhXCtZICmIitEL9FviDcJMuyzX8O6DzbGg3l8bhl1jc6+MV/8a?=
 =?Windows-1252?Q?WT4xv7oCXniAFp+xiZDFDG3ij/4wBG86tkmL+ULsScxMJuLppG1twy+b?=
 =?Windows-1252?Q?Hyk6QAU9HlBLxtRKbeyUmgWFQJhGUpnwV0vez6ua2bTJ0lgUKrJQfbiR?=
 =?Windows-1252?Q?oWTTyI/d4ir066KQhzW/v5hLLR6iz4tKs5y/Hrv4B7RzYLFWfJrJutgy?=
 =?Windows-1252?Q?Js4JLajhd49g2cxbeid9lHFEjNar1Q7WHb5a3vgtIssMovtzBBtvLjy/?=
 =?Windows-1252?Q?yWSkdxQ2WWLuj3aR3P957/RJzkys5zOym9Cjs3gtAfxJtU1W2vsEhsFq?=
 =?Windows-1252?Q?tIxXqo/9SM7Ir3P5AMLlEx1Tzy/6He0r4rds6YA6LTvQNsmWMEFARyeW?=
 =?Windows-1252?Q?GGdKMxpNnsSAyRz9TQYoBnf1Sn9HOZV88sHkP4DcGCrMmw/cUqLZpfLb?=
 =?Windows-1252?Q?wUyENUrCT3iC9kzD05rIOrlJzKhnpFo1fW5R26SpbpD0KmKEYr0WR0ja?=
 =?Windows-1252?Q?kAT/g3xFCCyoVx+KyrFNwl+6d2VIyK/bVAWWuTf1ChyIZnZlSDuiktCN?=
 =?Windows-1252?Q?dwF9psDxgSQ/tY+iIxX+c7MHCVHRg//9D20Y3Dmk+hCYWBFDcXWltrID?=
 =?Windows-1252?Q?AknokId81bFlLixkHb5+LqookL9LLvL62H1NcdD/bU7klfWwo7e3waEb?=
 =?Windows-1252?Q?7VWw93PUgYOKs6Z0R3KPIElbNRJiMizExpILfhOyU5d4fBV3Hk9iq7I+?=
 =?Windows-1252?Q?9JXfw4/2leDskccZpPcliIe8VHDWUWv30LYrllqT2OJ1u3dkU52tIHwf?=
 =?Windows-1252?Q?CHgcIxGP8OY8xnVVoBHEWdBCt/6bymNey9/XjlK+WyFM+9SKaV5Awgwk?=
 =?Windows-1252?Q?/pnMUSDh6Le50vH+QS5yDG0OT/DO8YEJIRqzSl85cAi7PEPPhDgni5tj?=
 =?Windows-1252?Q?l4lWyJrsKQ+Z1b2TLG6FbOq4vnC79ObJrls7lWRTogd0VABaO3rk+Rn4?=
 =?Windows-1252?Q?Z5KZBMwt2Uyj4YU9QEF26ZKOoWdw40L51Qy7JAvcLZrRcYh1k7Otc/4o?=
 =?Windows-1252?Q?zL80alTQKhYklui2PYv0eEZgzyYOx9+qe+F02pnSNsmzHabfkYgYFGZa?=
 =?Windows-1252?Q?8kElQYwgkktkh4B1ImiViHsBaRVl5ApvltmI2JCRGTK1EQbFgSJb5lRL?=
 =?Windows-1252?Q?/+Xue7nL6UnLCAk3GrWKZaN5lKdExmlHL9XoXh9QEeocpd3Mk0kq1Aad?=
 =?Windows-1252?Q?DVZvPCOy8W0ptZ3d3mV77Tz7XMnRejEkIzqPuV4233Z1MBOMtbI5vxrc?=
 =?Windows-1252?Q?02DC/O3i+/tHPcLzR0Mf8Ivp6Q8AWvKEhozC2OBixFFvnc1mPuQGadV7?=
 =?Windows-1252?Q?UcCq4x8zC952s18UwH+kMW7L7hukYg+oppCmk+6eXbrLSiEQzohkw92f?=
 =?Windows-1252?Q?Jj7KCf2fMmU84b43jPiTWzAOxejMuurs+e6QfzzNwNnn/3rHuBpf4PgY?=
 =?Windows-1252?Q?c3jgLjP/VR6/Rjz9kFT62CJ52YFu3LRM?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR10MB437077A6A6E6217AEE718B8A88C5ABY5PR10MB4370namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s2SmmO1PHOQ0+96LhUxsaxKPaRf7heAh6BwubirQ8AZupiXUm9Gm9BuqHDRByqqN68Sw2TQBqAC+sa9jOoes9ccn27I+WpF27HvuzIQae4xP97zAmjKzm8VD7P3DSYvwepDvnaQzpIVU84QRGhq9lF9teVg7mdcMCvW0T6O330TYdemMTKMthSH/K1aptsWdjngxoQW9mMWg7oJqOhQ+2dxqjuJvaZROnl608+GX1ZyU3W4hLl2vQN513jKj2PHxFPeohFlgGUA5tHvcvx9UDja9Z58EN2X9iGGp8zqKjZiFmYxsDxD7MjVLIMJ5MioiEaRKPh1tPwzPxexG/L3n9Qo+GNLrPulOc6QfyPq0C+Kq7A8nK2FGEggtUnFAIWuI+BMj8jNpiHO7OMGQn3s1oo6PYyjm18BBpkwLjTz8XT9iXEl51nckLJ5lBQVbjKNzCM/EE+gecHUNXUVh1X02ZuMYuX6HFaj999HX5OJ6MQyq1CpDHgrDfA7UW8+11k8dDIf9l2iqQVe0cunlZKrpFenU/5RLarHOyG92jUA70p/wQFtJJp6hfh9HyC8Bk/SkPXX2RBXIKx4c+fo6Mw5n/cSIcV0r1+g3cC+Ujltscd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408d4979-57c3-47c1-6844-08de1c20ca6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 04:07:09.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lkzsjlf4H8wWKxX5bqGCZ/e4MEboASIx5gAFq8FuRrIl6gB1jPCjcpxEZoUntpkXkPiFMzJZ5M3iiqSJAFxumQr0giYleXp5GjemWNW0BBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=904
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxOSBTYWx0ZWRfX3eYwIs4jNhbQ
 HpuQrgHNumBFs4TXuWk+LsWCSeFdBH5LWY64cKlC6Lw3R56uz6b7G6Yun2SCAJe+AaqWNosf/aH
 pO3HRkN6YheXPDqK1280ktfd9oC54G+f/WJ6LhBXjS655sNLV4V44Zg4d/fxjyuB7hb3JkYnv33
 qrrWpswyu/xX+07scF1EKmNW4SnYsLUiBXjh4V7dEzjXmQ+luvdU5Z02cmL/orWeAeRh56jY26c
 Omct9JJqyTQ/PdJWg3XO0qJkOLPQRptJ1Lvs8yUaQENky3OnFbCbcCrOniI7Rd0a8RepvfeA2CE
 zv/c8KzwbRvaQog6ehFXeOaPRg6uf5dCPu5VB8jYix+LYLKcQrbOLlqaQXwJ9yj/9WtEgNWf+4K
 tcumnhpfZesa2ywxr6BJLl/F3bbE9w==
X-Authority-Analysis: v=2.4 cv=ZpDg6t7G c=1 sm=1 tr=0 ts=690acd70 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WUVEdkC1NWi_H6dMTM0A:9 a=pILNOxqGKmIA:10
 a=hlPDmIbG43FuQOkwv_gA:9 a=-OUGsKbko9sLWSg7:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: 9HxhoIFReNrvNeJP0ELMJnRhljoziJly
X-Proofpoint-GUID: 9HxhoIFReNrvNeJP0ELMJnRhljoziJly
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

--_000_BY5PR10MB437077A6A6E6217AEE718B8A88C5ABY5PR10MB4370namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi DPDK Developers,

I'm working with the ice pmd and noticed that the `acl` devargs option appe=
ars to be unsupported for PF devices. I couldn't find documentation or code=
 references enabling this feature.

Could someone clarify:
- Whether this is an intentional design choice?
- If support for `acl` devargs on PF is planned?

Thanks in advance,
Banoth Saikumar

Confidential =96 Oracle Internal

--_000_BY5PR10MB437077A6A6E6217AEE718B8A88C5ABY5PR10MB4370namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi DPDK Developers,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I'm working with the ice pmd and noticed that the `acl` devargs option appe=
ars to be unsupported for PF devices. I couldn't find documentation or code=
 references enabling this feature.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Could someone clarify:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Whether this is an intentional design choice?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- If support for `acl` devargs on PF is planned?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks in advance,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Banoth Saikumar</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 0); =
margin-left: 5pt; font-size: 10pt;">
Confidential =96 Oracle Internal</div>
</div>
</body>
</html>

--_000_BY5PR10MB437077A6A6E6217AEE718B8A88C5ABY5PR10MB4370namp_--
