Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD9CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 977BA402EA;
	Wed, 20 May 2026 04:21:24 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 15C96402E4
 for <dev@dpdk.org>; Wed, 20 May 2026 04:21:22 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JHpJNu3903964; Tue, 19 May 2026 22:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=h
 3HQIr0dgGe9MmzP7isEt0MqCF+5v2zhiVZ+l6g8T2k=; b=ah6jVtmMWuL95oyW5
 ES3kx/O+dWNV8UGvxGp/nn+F2ZBiSK/yRFovVn3uFkXSDCt9z5vLP6xk02VFiRF8
 jcq19m0+OKJqMYPzDV8uBySv+FkUiXLCBZGDBFTGxTfhSfW5T7R0LbhkKXLbO7p1
 bZ5aBE3A5NToPRpG7l9y1gD12khlTbA/dWGP/K7LrpbaQIrYzPnyL9Nbo8gu0PR0
 A056s+45eV0wP69eYXfQolICrLssQAhEuhjaNJCiM/U3ZC/XoJTikSseGwfzmkZl
 UJjXi//Juja0oISXHS5L921TjllqB8JLH7NLXRadQM/QwOmiAcxSsCfZDrBMx2SQ
 NtGQg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e6kr6efby-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 22:21:22 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K1k6lb2851094; Tue, 19 May 2026 22:21:21 -0400
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e90df2d2t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 22:21:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGFgqdZKRMxMS1wNE2FikDTmjuX/pPtxA367lFAa9klgZqR/gCuIikLgYw1S9i0hqTbErYXH+ytqv78/t7U//XkCSqlAQ+PBwz9/Ld+H5l8GLrKYebOkZlT5aoFSFTRGsjl0sn8EgWYlMo0rERoWTZMr5NCHNvFZkTCd/sOnc3NHYjLML3OotDSgKf+8qoKi+hb1c/rk0O2CNwjp06Bei1G0BD5qgRumzHDTDIt2oWc1ZIIm4q2hVWSR94d+YQXAglvThjNDWenH7PSAA9LJShQFXohmk5ESXtSHZP1637FkSDQXDEIbwO4tZ4ZiDMi0GaO/Fs0OWJNdtzZpuOsRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3HQIr0dgGe9MmzP7isEt0MqCF+5v2zhiVZ+l6g8T2k=;
 b=kvUbxp5pPqfQuWqjKdcWwltIKqh0C4xazTIUdl25BSKbodbzqEPpFi7ZFord2xrlmYgBgYyaqKBDBBz/PIvs9v1ENGNeD9ab8Smav4SyhaBHCQLz+3rT94yE3RdWD5FLg4afJyzPD78cQmpgXdORVNhoLmvbROVqgW/Crzd3jPshL5XLsaLPwd7y0rQL75ulZdLAdKQk5rzFJEXK7f3anBmTCEY5AH17kWI6rizH/1u8cOLrv7ylEXj4OUkDVbiNX0hxLsvplFLpFfLST1GUwwCpaSnwkgsXGPRQdmBct6gSfvjhl4EUoh9NdlOU9i3+haUayI+pZBFr83bmso1njQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by IA0PR19MB7289.namprd19.prod.outlook.com (2603:10b6:208:439::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:21:18 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 02:21:17 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost hdr
Thread-Topic: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost
 hdr
Thread-Index: AQHc4/OHiraE1wTb+UyiTmzIhbXRqrYOOXWAgAf9PzA=
Date: Wed, 20 May 2026 02:21:16 +0000
Message-ID: <DM6PR19MB356483DFA0304202FA06F344F5012@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
 <20260514224627.2014566-2-pravin.bathija@dell.com>
 <b4e44ed7-7902-4369-a4e4-509ed3addf91@huawei.com>
In-Reply-To: <b4e44ed7-7902-4369-a4e4-509ed3addf91@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-20T02:21:02.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|IA0PR19MB7289:EE_
x-ms-office365-filtering-correlation-id: d669206f-703e-4f0c-fbd9-08deb616792a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|376014|4143699003|18002099003|22082099003|56012099003|38070700021|3023799007|11063799006;
x-microsoft-antispam-message-info: /Qqs+vmor15RrHMVtVbXhCyGtgHErvTBEh8yNGNqHbYN8ChjrqMIP0vaou5Qt6sBvqkIvPYJHsAjFk+m4GMXMcDoaMNaAWNbnMcoQIKjuUEBBDVld2gdrfQ7lulrOP9+/v/BUtEAFJC9hpnDJkK9fwCJ9scVAb1G2o/bz5ckSSGFOSDZ6cGB6beAnIEW0Ammk9SloqPPCmClKuiO1FdRp4C2U/H2/PLd7hdtlXBomBZHg73aSHKOvDzrYrvseMmJ3DvYJPCv0ExxA+qxHTd5YVFkwDzow0xDBakZ7K1MkcV8rjaMRyDNmPZyQZ49ChcoGP+IS6IuqPJNkgWkYG17freo+0CODKj7ptmcFeN33PEIWsohQXjrOcCiahA+wFmZs3HjrcEnre3V+kyPbC6ORT0H9Oclw/2SGnIzeYe/t3VBDVFn30dFaMM3mfgroPCLu0Kq7FbRHE1IjYYLaESRlpXC7cDYvujSj4uBjCUWiUW5W2/9wz/aOjTvjbjI0wCZbSUVc8lKDlw/Ngjwutl8EWyHCO0Ur4OZPYy11MCkCNufUu5Gv6xLziWrIHO6unUZqvf4FOCSbSE4Xta3K77+UfKIjrddUSZFYPao3u6alCpKSBJ5zL3YIst6HS8ho5J0ZBYXrynULq9iPRUTz4oh5cdrmiLMfZcu0Jsu/X2MNhRwfBXoT1n/ff+FkwgaDJ2uZVRMBsI91sU5xomJZtlU3K/PnwdPkQucHhOpMqgB21wDwp/487Fjf//fq5rZHk3X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(38070700021)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anExNkt1aEVEN1BOeUIvck9aTEgySndiY0tDNUF6MmhYajVMbS9kdXBhT2tL?=
 =?utf-8?B?WUpmSUFJM1RoZnJjUXhydkJ1L1Rqdm9sRXFBT2VkakZ6L1VPREprU2RDM2pn?=
 =?utf-8?B?cW9HUVNIRHJhRHR4YWZlaGF0QldqaEFSaTJuSEhydEZYUDM4dUpHTE41cUN1?=
 =?utf-8?B?RFhjNTVUeEx5YzV5RlNFRjZIQ0lIaWh3L2dPeUh2V0hlenFKVnF2Qkp1M0ph?=
 =?utf-8?B?QmpZRlFsaVR6OUJCdGtkTUhZOGhZM0JHbWxERUNMaURzSUtYRUx5bGl6ZWtT?=
 =?utf-8?B?Y25mcmhiZ0hTMGwweS9ZR0Jybm5aRExERFdLT2pkcEhMMVVrSVdyLytFQjJQ?=
 =?utf-8?B?NHlOcDJtZjZZVCtURnZhdHdFTG9QL29MVlBuS1ZOeW1wYnhXa1YyaE9CRDlS?=
 =?utf-8?B?RE1USkJmNWREaXRKZ2cwa0FGeExQM0FXVDZabXYvbUNsL0JaakdKdGZ5cG5w?=
 =?utf-8?B?MEgzQ0E3eFA3NXhQV1dtQ0lYODNPL2ZBZm53S3lWVE1jRHFRYlZOd3JtaGkv?=
 =?utf-8?B?cmUrVWliaFlxeUswOWF0UC82bjhSOTFwREF5QXltT21qUjFQOENOdkx4NEor?=
 =?utf-8?B?ZmxUb0JaV1RMRmNFenVqSWZraWhRRzdlRk9kVkZMTmgvQnpiTTRQSDRuQ3JL?=
 =?utf-8?B?TnRiMkFsYXREdmZWd0V2Q00wOGcwZ0xqOGVFNTVSZThnSGt4VytqempsVytY?=
 =?utf-8?B?amdLaENtTUJTQzkwa3pIWVBPOVBWVHc4Nk1tUVlhbGpTbzNUSFIvTWpZdVNa?=
 =?utf-8?B?RXhkcHFTaDdmSHk4OC9DOCtMU05HbWpraFRjdzh5Z3Y1eERhTVZQank0Y3VL?=
 =?utf-8?B?a3hIM0lTMGNXRTA5U2p1RkV4R3RZdFh6U1YvWnZFVUVUME13N2pTeEdJR1d2?=
 =?utf-8?B?dWo5aWpxdzNBS2hQMVE4bEJBcWNlZm93b252R2FYUFk2ZlpnbXJkTDNuQXln?=
 =?utf-8?B?WjVtRkszcHVMQWdHMHFlSmMyT3V6MFR5SjJzUEd2VmpFVGFWVnZVSnJNQTll?=
 =?utf-8?B?TFVscVRSSFhGdkxKcVdoRUhQK2tiazNHNUdrNmlDdkc3eXZnZjBlSzRIK0Y5?=
 =?utf-8?B?VElwbG1MbWM3UnMwempKS3RRdVRHVnJTNmFvL0xVL25lTmY2MEVKYWRjNzQ0?=
 =?utf-8?B?bnJzSkpvVlZaeVJGa1dobFJaQkZNQlB2M25jQTVxbVVEeFBSTGxpWUNXTnB6?=
 =?utf-8?B?eFJFZ1E4aEhzaExYL1ZzMVIvcEI4RE5FUC81WWZGR0RjNHlxZVdLM2N5M3Bp?=
 =?utf-8?B?V1d2aFg1UThjNjZMSjQ0WlVYamR4elg5aUw5Z3VmY1NsMEZKbGQ5OC9rMjhp?=
 =?utf-8?B?MmpWVHVvU0poeEJjdXZqUkRLZjZZWEFSM3A1elVtMUNQRUdWTGZaSGZSbE9t?=
 =?utf-8?B?UlhKNkh6NlkxeVBXQVFQbFYzUXdlOHpEU0NuMTh3TlAyUS81WWo3akU0Y3Vx?=
 =?utf-8?B?N2dBRjJOUjVvM01GYU9Rb3liQnE5SjZkVUJzSGdtbVNETk9IRVNVUDEwLzdq?=
 =?utf-8?B?a0JPaUwzOXRaV0R0SzBpUzM1ZXE4WExEZWtpeXlydXk3eHEzbVR5c0JSYWln?=
 =?utf-8?B?OEd6ZEg4cE1odE85d05rbWFmZUpOdnhyQ1c1dzhjUWtXMzIwT0ZUUnRrN3V0?=
 =?utf-8?B?clhzb3E5WmVVb05IWlZ5Nk80d3cvcG94UitRdDFkSHcxUGRLTXBsYlRldUdi?=
 =?utf-8?B?TS9SeDFubWprenkwT1hMOG1ERmxZV1NFbXo5RmJ5WlpBaTdYR3lVdHRPNlhw?=
 =?utf-8?B?Vm9RdS9VOEVmQ3czckxBM0Z1eTF4Nlc5cjB2cXd4OTZlSEs5YzJ3UG9KekdD?=
 =?utf-8?B?VU5ZbzZYSExvTnMvR3BsWHBnd3dQVHd3VmhBZXpLbXp6a0ZzUWplS0MrTXBF?=
 =?utf-8?B?RDg1TnFIZFIyZlM2cWFhbkZPbmxSdnpCZG0rZ1RJczlwQStQWk1OUjZtdm5v?=
 =?utf-8?B?VzJEcjQrN0NKNlVYaFRsM1VHWDVQTThTNWRyT0Q4VmxnTzJMcTBJaDBSb01G?=
 =?utf-8?B?clVSQ2FzQVc4czJtbllnaTYvekQveXoyUzlLNmhDYllicXNodVk4dC9IekFz?=
 =?utf-8?B?WUV4QldFdE42clZhOXdYaFFrd2lUamF3dFNtb2hFaXE4elczMzMwNGpXRzBi?=
 =?utf-8?B?WHZrYncvSFd6THM4dWpTZU5DNisydHF5My9UenlZYUpBcGNyL0w0dlM4Rm1Z?=
 =?utf-8?B?L0plM1ZLZWcweUdqUUZ5UEVXRTFEMFMrQU1jSGlxaXdYNXVjdk9uMk9wNVZC?=
 =?utf-8?B?VmQ0LzFsYzBDc21WZkQ3ZjUyclp2T3pJWDZPWXZqUk81dTV3V2VwRUgxdUps?=
 =?utf-8?B?cnlRSnYxMjA1ME44bFAydldzWjh6RlozUGJJNnNHa2RYU0d5S1A5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PMfHkKl3jhYa/WbcfQUb7gP4JEdz30yHagdPd9HMZqeVqWHhAJOJoTJAKLDVZRVWm5l8eMYZWNc4XjdivKFJbUQnUh0LWh4Dea4qTk9ICuD1/iz9EWFaiB1nE13RphpOmM1OCNO2AuxMe7mYIx33+VVbzCQ2fJgnih0N7KBckc8oslFkslmkuKgj7L4XaCaEUZAM0DsBIYUmIfq+l0RcWdntbZgAr4iQeENzoV/dJBD9Lx23b8TpuCaXpHkHSvwWKpU+zbv2m8Krh4BdsbZP3AA2ozsiwX90UuIXlq2vlNPU3fCCEVxbSVEc/cdFA6rmjtniqbaSYaLI/YDRHFqcXg==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d669206f-703e-4f0c-fbd9-08deb616792a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 02:21:17.1000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpEkV8QeubCUV20K7MwqIUWcNQsKq42eFR+d1gL0QvRBGxtv3/H/g5pR7Nxe7cY1PDIRAgIbVwuQUXgsWXUnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200019
X-Proofpoint-ORIG-GUID: mAaRBNE9dPKuYxoZxlrlELK3eoS2FbZT
X-Proofpoint-GUID: mAaRBNE9dPKuYxoZxlrlELK3eoS2FbZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMCBTYWx0ZWRfXyR9+r4eGRUeq
 0KOOOH4mNoRw0DV/oPG+cvOMnlHDxn4IP8nIqWOfq+fsWEBpYlaZJ28uU7VeF99c1EtkuaEPKr2
 PG7lKomu7xkOT4JHRgC7kGdqcBmynEzpauUbXT33R3IqCLtOQCIzh/ta8FshXqs7rbKYR6QPiiv
 1wWIQZYfwC3pwzujwXfpHdSkLe3rZV0xbSmtLh73kDCkaIkrv4bcbDNx3d6R+yLOTDb6b89RTuI
 pxeV96R4nZqbwftWjzNqgFk+CSna5XRJJNfl1Q3yqKHiTHx/HDrFBKgGaCoW9US2hrqkJ4iS8HH
 YfD7sjqtMxGnaonyoTfHBicf/J2N/U6IPslcZcyLplIJHa37ChbzA8NGRjqdwBLoW0nJ7P3CDbm
 +tW8Y3c8i0jgOGw4wcfe0tQTEPT03dy0Jw91YNkAUihBrHe8FR9EbggCVHpKDFjQTbwPQPyrqIL
 CDLULU5J12ekxZKYOsg==
X-Authority-Analysis: v=2.4 cv=f6N4wuyM c=1 sm=1 tr=0 ts=6a0d1aa2 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=m3zZTHMLHbwB7Lmtoed2:22 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8
 a=jZVsG21pAAAA:8 a=20KFwNOVAAAA:8 a=bt5KbKNvAAAA:8 a=icyBAR6-xzvOKvqXA7AA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200020
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

DQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGZlbmdjaGVuZ3dlbiA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTQsIDIwMjYgNToyMSBQTQ0KPiBUbzogQmF0aGlqYSwgUHJh
dmluIDxQcmF2aW4uQmF0aGlqYUBkZWxsLmNvbT47IGRldkBkcGRrLm9yZzsNCj4gc3RlcGhlbkBu
ZXR3b3JrcGx1bWJlci5vcmc7IG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tDQo+IENjOiB0aG9t
YXNAbW9uamFsb24ubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEzIDEvNV0gdmhvc3Q6IGFk
ZCB1c2VyIHRvIG1haWxtYXAgYW5kIGRlZmluZSB0byB2aG9zdA0KPiBoZHINCj4NCj4NCj4gW0VY
VEVSTkFMIEVNQUlMXQ0KPg0KPiBPbiA1LzE1LzIwMjYgNjo0NiBBTSwgcHJhdmluLmJhdGhpamFA
ZGVsbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogUHJhdmluIE0gQmF0aGlqYSA8cHJhdmluLmJhdGhp
amFAZGVsbC5jb20+DQo+ID4NCj4gPiAtIGFkZCB1c2VyIHRvIG1haWxtYXAgZmlsZS4NCj4gPiAt
IGRlZmluZSBhIGJpdC1maWVsZCBjYWxsZWQNCj4gVkhPU1RfVVNFUl9QUk9UT0NPTF9GX0NPTkZJ
R1VSRV9NRU1fU0xPVFMNCj4gPiAgIHRoYXQgZGVwaWN0cyBpZiB0aGUgZmVhdHVyZS9jYXBhYmls
aXR5IHRvIGFkZC9yZW1vdmUgbWVtb3J5IHJlZ2lvbnMNCj4gPiAgIGlzIHN1cHBvcnRlZC4gVGhp
cyBpcyBhIHBhcnQgb2YgdGhlIG92ZXJhbGwgc3VwcG9ydCBmb3IgYWRkL3JlbW92ZQ0KPiA+ICAg
bWVtb3J5IHJlZ2lvbiBmZWF0dXJlIGluIHRoaXMgcGF0Y2hzZXQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQcmF2aW4gTSBCYXRoaWphIDxwcmF2aW4uYmF0aGlqYUBkZWxsLmNvbT4NCj4NCj4g
UGxlYXNlIGF0dGFjaCByZXZpZXdlZC9hY2tlZC1ieSBvZiB0aGlzIGNvbW1pdCBpbiBuZXcgdmVy
c2lvbg0KDQpkb25lDQo+DQo+DQoNCg==
