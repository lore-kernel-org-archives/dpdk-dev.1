Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A7FAD3F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 138F540270;
	Thu, 23 Apr 2026 05:37:24 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id EE62540150
 for <dev@dpdk.org>; Thu, 23 Apr 2026 05:37:21 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N30Ai6158161; Wed, 22 Apr 2026 23:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=j
 Rv+jvypE72GbAlV2geWjM8cXIy1PqESqCAS5DOJqXE=; b=ifNYUOpEX0gqvsVuw
 ZPLHICLYfejtzXtki1+y+qaUsflFHiToh6pxaZ+At1zjg/FCgvkGjRUHrsPd7puP
 aWprT3bU3u6S9onfCca7xCKzGay5Y6YQS7fGdXSleme9DjQP+cydIVAep7isEUrN
 udn03OiLS4WJ96jCq5xL64jLdrb5Ba+3XZfvUH+ayN5sz6E48pueoXHgfX4yQ4di
 K/y04nI+OB5+JJtxaaJxzQYtijUQsBJAYWtVOvP2twO3c8ToBx48EfUb8tI4z9wN
 J5CFxpdTQ929Vel7klNAUS4CK0dLB3lUWa1JoC6Qie7aUuZAfTE5uSjAXs6yevtB
 v4T+g==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dpentf1gu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 23:37:20 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N2l9sw642401; Wed, 22 Apr 2026 23:37:19 -0400
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dqaxq8j17-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 23:37:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKsRUz0M+CBN8OxupitgoFPW1ciFE6EhnMqgOf+8ilM2nq3GSOg93lMiZE6VjJYSO3scn9cMSpKgzAS1vVLHT+6pKTw5LoYNnnCCHMFkxm+zF0h1JPS7tDQ5F2xOSUa3ZmMVyOKOVIEWGK0yojXTLJB+YR4iFk/HsVlT68gil1HUCtivhaUkRRn6+5Roi5eigVK/dw2Y+E3UkruxKArhp7dciaw5bO+wPt3sviDYijWXrcn3wbwIVdWOp5eltXoRBn8WkuKEj8j0rTGpPYdkQhz3SOl4RUoEkzUSTmxZ9bQXqwMSBol2uHrL0er2WWoxkT269zdj3vihAz71VQZw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRv+jvypE72GbAlV2geWjM8cXIy1PqESqCAS5DOJqXE=;
 b=t42cv1G6J2tLptgED53h8xPMzxRDptygsIRt6MosmFlm2myBpUMCY+wSXAWMAhmo3NEb0GpG+jp0Iu8nvQtnZx4sk+WooTmzj/IgH4qgepJiG9QLFMnGkd3E8vAfbIpK187RL4tHUwIQebGMIRfTyEQW46hwuOsRUaTo/6BA+xdN4nnj6zanh8Btd0uHyHYYvCvQ3Y4hlmspSBQUNLY2LfE0HYsAUmMHWqsWL0U7yDHYp/Eqbbpuv8PfzzIer3nkF9Lv46VCF1D3KUXhgfWTJ5jXM2GaqZoad6k+gNjRfXPhAZEd/6nZOJTvfB7gSvpL9Uzvf5tVhLUExaViN31byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by CH3PR19MB8163.namprd19.prod.outlook.com (2603:10b6:610:1a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 03:37:14 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 03:37:14 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
Subject: RE: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Topic: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Index: AQHcxmVhNUZdPluV1E6Mg3NnSRxJOLXTps4AgACLzxCAF+QHMA==
Date: Thu, 23 Apr 2026 03:37:14 +0000
Message-ID: <DM6PR19MB3564006D08FDAC801E213299F52A2@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
 <20260407072118.341cdd6e@phoenix.local>
 <DM6PR19MB3564A625FEE9BC61A71FFCA5F55AA@DM6PR19MB3564.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB3564A625FEE9BC61A71FFCA5F55AA@DM6PR19MB3564.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-04-07T22:41:41.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|CH3PR19MB8163:EE_
x-ms-office365-filtering-correlation-id: 425f58d5-9116-40b5-2d16-08dea0e99c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|786006|18096099003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: eU1JVsy4U3gseHVx4iDHzckR2Dg3nM5e2cS9Z82BfM1UoyN20y7BijYT7YlZnSYavEPmYY30f6KF5uSJ55X7ORdglJ8iVXdKImCInHOSrArVd+HzMVB7ZFJfGz0r0zQyyS6BOa6L8fWWf4L4iJHxBwGU2iQHJqVSJT0cP5T6kjimtQVoi70ZXFS7yNrzEXHl62MTWyIoZ2kqiNU1OpJPwF91AdkLD91v0pw19kx6gGCXtKbpti09aUsq956fyPjtU++OfYQ/CI7xIQA/dxPJDoVYVrDDiES20Nyn1IUfMJJEoPxakZq72APBUPTKFJMVlNgOrPwgRqjR4s5tLRuQDLnTWOMYTYDiN9Xsu3py9ucLChS0yCqht3JhJ5DOeKYGPSjZbULEJMY+sNgMETXvAjsIv4TYUs/Vu9e4SxAs7H6TbXTdZsKS3DVNhSSoQtoAkCGWBeO/jfe9sxbKch3Cw5drpFi8B2k7V24ICOxF82arAb3Iy8cUGW8VkgryZWHUjIBOi/WMe3QUCGppHhqN2MsUDxz2ZELe507JQWijDjryKCbHZDIUC+Bz7/FVmVE0ldFKXMreHlo5eyQnqZHnEaN0VxK2uBLjMCCvWsUBrU74y3pw37IDT6fwxsxcPOi7zEi/ArLOc49/20nGDX1I/iYPM3ZrzIlDyG69KgZB02bnIo0MYaX3ljPMuf9pvHLiheQVdNWBrXsLM81IUMQuganYDZH05m7bSeftdOxyJOU9Aibum+AD5h/FXgc6XO8PD8iTIu2jsCV1+hfLIxcvxXMAm+bXoaIjGOjdYJVW3NI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(786006)(18096099003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdLTkVaMmNGb1plU24wdFFSaGZ6dFZySDZhbzFkN2gyNnkxNHovQnRMemZN?=
 =?utf-8?B?RmJxdXl4em9RQlZvZGpDVjR3bGg2ZTlJREVWWVk2YzI4djgwR1hDU3lPd2U5?=
 =?utf-8?B?RmRBT0tRWXc5aXR1d055bm5pMFhRNmJ5WnA5bXROKzI1Q3BhcnpGK1ZNT1FY?=
 =?utf-8?B?MXBMZFduMjh2ZklsUkJ3aDV3ZXJpeXBUMlMwYjdKb1JwblJNYnJEL0RYZ3Fp?=
 =?utf-8?B?YWFJTmpjVG04UVNHbkp6VmxUQjZOQ2JhZURpRlZNZEQwUUFSZjZLOW9oUDhH?=
 =?utf-8?B?VkNqaDFsL1F0VEU1clM4WWRQZW5ERTdYVUNhRFFsTFl6aytUK0UyQlc2Z21Q?=
 =?utf-8?B?OU5XYWdrQko0c2FSeFhDRVhpTExWYXN0dDc0d20xRzQzY0ZGSFBRYm5aR21S?=
 =?utf-8?B?R3VpS012WE9BbCtwNFc0UC9MOThtYVpNV29DK1J6aDBkdG1ZaExqY1MrQmZR?=
 =?utf-8?B?L3ExK1BFZkpOWmlRa2lPVmpsMEVTVm1ZUmdKS3pFNGJKYXM1dHZZS25tdUhv?=
 =?utf-8?B?K0lmbmJBV1B2eEoxOXhmMmwzc21Fb3BneFRMNmpXbkNBOXVDSkFTUjFMc0l1?=
 =?utf-8?B?eTI5SWo3MFd2M3NqbEdzVUxzWnhwWUxjUWo5VkZSMXd5amVWejZQTXdMNjY3?=
 =?utf-8?B?V3ZwckVRZzFJVDN0U3A2d3VadE1XWlVjVVlkdjhtcHhiazZZOFhsY0xpU3ZD?=
 =?utf-8?B?Z29hclgwcFE4ZnVzNnFUYXdzTkFGVlUwN1FCOHg0dlAwNmJiTnc2SjY5YmRF?=
 =?utf-8?B?WWsvUmNWR2I5WWJnbzZtWkd0MjN2ZEd0RDBEQ21HUVRkNzJhYlJWc0VDd0xL?=
 =?utf-8?B?R3ArUzNFV2RJTG5ncEo0dytBcFdwQU5HNzRUVkpZTGJKVGNWTGxZaG5IclE3?=
 =?utf-8?B?WkcrRzI1cWtFRG8xOE1LVkJMVzZhbDF6a1U4QllsSElVUW8zQmQ3SkpLY1dh?=
 =?utf-8?B?SzdCcHJtVG1BWHM2TnRvVExLUk5DSi9WV3VGWlJIQXE2S1pSTDV1REk0UWhZ?=
 =?utf-8?B?Y0Ivd0dmZnpNTjBTRWpYWCt6TGlaYjZySmk2bjd3WVNRWVoyNzhYYzVQS2ti?=
 =?utf-8?B?MHZTazFrMFNhWXgzaTc2Tit5dWNpZXBtOXdXb2NPNFpIQVErLzh3SGE0ZUVF?=
 =?utf-8?B?SUdSMG1PQ25va0d3L3hjMWNtMDJNU21wa1JlMVhIdmNiUk1pelI3elJoOFRH?=
 =?utf-8?B?YkQ1TkpPWnpraG0vWTZHY1Z3M2d1TmNhd1V3c0NyQUVHcThBRFlwMzNCU2VB?=
 =?utf-8?B?ZkVFeEV2V1VQbGVQZUNwd2xlTG9tYWQvWmRONEtjMEZPY1Jqa2NzTzZoL1Ix?=
 =?utf-8?B?aVJMNjZ5bjdPdVR6QjFuUWtqRWtvVEM5K3NnWWNNVDZzOGRGMlVOTHByU3U1?=
 =?utf-8?B?UWJoWlVoU3FhSVhlU2ZLa0Q1TnJ3dWE4OVo2SElzeDlncVVWWjRLd0Y5eU81?=
 =?utf-8?B?RzlqNm1VUXg0cmhDVzJnUS9vZnJ6Q1B4N0QwNFdxaUhGVjRXcUU3NlhxM0dR?=
 =?utf-8?B?eVJ6WFptbi93R1EvaHJkVnNsMElidkdXMmxJTnZWQzI5eHlxN0NYL2RBcmJE?=
 =?utf-8?B?TWFDZU53UUgzQmlOL1FpVy8zdEg3KzJwNWNSdWxKdVA2TkdRQ2RFYmNrVHRW?=
 =?utf-8?B?NmlNWHNkekJ0dzZoUkxDNzRCU2ZYWGpvWmdTOVBiRUE1cHYveElXVVZVUEs1?=
 =?utf-8?B?Um53Vm1qbG5WZXUvWC9PQkJPdkhiMWhDL2F2Wm9YQ1ZjL0VlVk9vcjNWR05U?=
 =?utf-8?B?YjNMUzZIN0phTms5N2N1dE1jVmM0djlhYVBQS25UeUVTZ1pXdXloU1BqYXAw?=
 =?utf-8?B?SWh2dUw2bHM4MWFzSVNlekVyRmNuZFU1SWJmZENKMjh5TmhFUDJnSC9VNmhx?=
 =?utf-8?B?SEpveGZSdm5oQVpTdE9KUHZadnFKVzRvbnU1eWduRnNFbGlNOENYNG15TFFW?=
 =?utf-8?B?dUMzTmtPTE9qOVk3TmNnS044RDY0ZEdwZmEvWlQrQktkVnk1RmFVVXBaL0l1?=
 =?utf-8?B?OXIwdmx6V2tqcEJjQkdvOUVKbzJhdFRxak1RQTNzQm5valVucWhrT0FVUk5M?=
 =?utf-8?B?WjFYaTEzcUVtK0JXZWFyR1Zzc2RscHhXOXhWRmxVWld5TGFZdFdZdEpIVXJz?=
 =?utf-8?B?NjFEc1k1ZnRXODJBRndVNEFiTG9vZkxxd2x3WDVHM0xiVkY1b2J3Z2gzbERj?=
 =?utf-8?B?dzlJZkdZZDJUSG03azM3S3JpMFdPL2RnOHk2aU1KRTdFb1ZiUDRGek1RWUlK?=
 =?utf-8?B?S2JUajZweThyN0VEZmFFVzBGajlmekZCNVlIZ0VzQ2MvU05EM0p4L1Uzd1Fi?=
 =?utf-8?B?L1pxWEVsQUZ4MmJvL0l0TmJlc0hZMjVmd2RZRnErVlVxZ2VsQmZNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gqQl1PAjH+JaPJkdV14ptDhHP56cBfLYyuVz9bCGhFCqkIPCqxBve9Yp6XHhfjjaNfnAvfx5gg9CNPpRJcT/iR+mcLC5gHuNOMNo85KpRFwAJ94m2tzFuvW/Vvw+ELjg7Go10eKCupb4EyaRRNh/B7dR1JXDVzCMJWH7bTdt+ZNGVnJ4jgjkScXFajr/InWrXFV+vi9PCES0Abp2XzSzCKFSbD9hjIDco73IMuHrbwwXiJIC+kqfcKEmC1BeKA+Q2fAQCJ/MtzAP2V3rz/DK80h6L8DF86WytOQDjHcvuvEgiOHTGdYk88dQ3A+2mXwaxUfe4LIk1l7b+sVvjf63qA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425f58d5-9116-40b5-2d16-08dea0e99c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 03:37:14.1750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipp6V+bMjH1LD+4AIub1PRUm2WsU1HA78d0CnI7reryq/SMThjnjCivG7RRPU9eqiYrt015vw9/5Z8Vo+Sd95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230031
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDAzMSBTYWx0ZWRfXzcZbXFXnswxw
 9PkPeiBtJqfP5OLxIhIFVo7fXdiKGoXL0EaxdymTnKIe5w58YB3vIAhzouI/dI3BxKVTPtVgaK9
 TWzuYbaD54ArdbC0GLU7/NlEjxb5nUoKwVNhU9aZndNFezGfTU+LWGx/3slo7L3r3tbXfpYB5vH
 MHyW69HSOvyhCaXd34fg4WSQ3B3J0Uqw7W++S4/cVkJdp5Elya8jiJdojLyRnx2XYw+dU3S5sS0
 HM37mdg9znLpBljMuUjpUIq52jgzRzzTj4G60Y3/HNZTGtZSbHdLgdiM6GQC4hMcq6d2bkvpzWp
 RLGLKZnWeRuIKBIfjbvYYjoMtZOJJqkDBA++kKGgzVrt7UaMI74YvFnxqrDLJbNw9dkEcqXcAQl
 Pgc4j4bsgQ/y3YHgD3fC3EkL20FsSAuo7cTENQE1wFP3G0f/PSYU7Bml0Xy9daAJL8YWeaNQWnt
 rzeZ9u+bUYepubKfEBQ==
X-Authority-Analysis: v=2.4 cv=Rvb16imK c=1 sm=1 tr=0 ts=69e993f0 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=fe1keu9KhAX5AoWrZvs2:22 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=bt5KbKNvAAAA:8
 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=WcWsdkFjvVReYYTTYVUA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-ORIG-GUID: smJ4mE6QDuN_jT-jaBvYVVltQY6wDIHd
X-Proofpoint-GUID: smJ4mE6QDuN_jT-jaBvYVVltQY6wDIHd
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230031
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

RGVhciBTdGVwaGVuLA0KDQpJIHdhbnRlZCB0byBjaGVjay1pbiBhYm91dCB0aGUgdjEwIHBhdGNo
LXNldCBpZiB0aGVyZSBhcmUgaXRlbXMgdGhhdCBuZWVkIGF0dGVudGlvbi4gIEFsc28gc2luY2Ug
dGhlcmUgYXJlIFNQREsgYW5kIG90aGVyIG9wZW4tc291cmNlIHN0b3JhZ2UgcGF0Y2hlcyB0aGF0
IGFyZSBkZXBlbmRlbnQgb24gdGhpcyBmZWF0dXJlLCBpdCB3b3VsZCBiZSBncmVhdCB0byBoYXZl
IHRoaXMgbWVyZ2VkIHNvb24sIGlmIGV2ZXJ5dGhpbmcgbG9va3MgZ29vZC4NCg0KUmVnYXJkcywN
ClByYXZpbg0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXRoaWphLCBQcmF2aW4NCj4gU2VudDogVHVlc2RheSwg
QXByaWwgNywgMjAyNiAzOjQ0IFBNDQo+IFRvOiAnU3RlcGhlbiBIZW1taW5nZXInIDxzdGVwaGVu
QG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgdGhvbWFzQG1vbmphbG9u
Lm5ldDsgbWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb207DQo+IGZlbmdjaGVuZ3dlbkBodWF3ZWku
Y29tDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjkgMC81XSBTdXBwb3J0IGFkZC9yZW1vdmUgbWVt
b3J5IHJlZ2lvbiBhbmQgZ2V0LW1heC0NCj4gc2xvdHMNCj4NCj4gRGVhciBTdGVwaGVuLA0KPg0K
PiBUaGUgY2hhbmdlcyB5b3Ugc3VnZ2VzdGVkIGhhdmUgYmVlbiBpbmNvcnBvcmF0ZWQgaW4gdGhl
IGxhdGVzdCBwYXRjaC1zZXQgdjEwLg0KPiBSZXNwb25zZXMgdG8gY29tbWVudHMgaW5saW5lLg0K
Pg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogU3RlcGhlbiBIZW1t
aW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDcsIDIwMjYgNzoyMSBBTQ0KPiA+IFRvOiBCYXRoaWphLCBQcmF2aW4gPFByYXZpbi5CYXRo
aWphQGRlbGwuY29tPg0KPiA+IENjOiBkZXZAZHBkay5vcmc7IHRob21hc0Btb25qYWxvbi5uZXQ7
IG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tOw0KPiA+IGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29t
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAwLzVdIFN1cHBvcnQgYWRkL3JlbW92ZSBtZW1v
cnkgcmVnaW9uIGFuZA0KPiA+IGdldC1tYXgtIHNsb3RzDQo+ID4NCj4gPg0KPiA+IFtFWFRFUk5B
TCBFTUFJTF0NCj4gPg0KPiA+IE9uIFR1ZSwgNyBBcHIgMjAyNiAwODowNjozMSArMDAwMA0KPiA+
IDxwcmF2aW4uYmF0aGlqYUBkZWxsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IFByYXZp
biBNIEJhdGhpamEgPHByYXZpbi5iYXRoaWphQGRlbGwuY29tPg0KPiA+ID4NCj4gPiA+IFRoaXMg
aXMgdmVyc2lvbiB2OSBvZiB0aGUgcGF0Y2hzZXQgYW5kIGl0IGluY29ycG9yYXRlcyB0aGUNCj4g
PiA+IHJlY29tbWVuZGF0aW9ucyBtYWRlIGJ5IFN0ZXBoZW4gSGVtbWluZ2VyLg0KPiA+ID4NCj4g
PiA+IENoYW5nZXMgbWFkZSB0byBwYXRjaCAzLzUNCj4gPiA+IC0gUmVzdG9yZWQgbWF4X2d1ZXN0
X3BhZ2VzIGluaXRpYWwgdmFsdWUgdG8gaGFyZGNvZGVkIDggaW5zdGVhZCBvZg0KPiA+ID4gICBW
SE9TVF9NRU1PUllfTUFYX05SRUdJT05TLCBtYXRjaGluZyB1cHN0cmVhbSBzZW1hbnRpY3MuDQo+
ID4gPg0KPiA+ID4gQ2hhbmdlcyBtYWRlIHRvIHBhdGNoIDQvNQ0KPiA+ID4gLSBBZGRlZCBjbG9z
ZShyZWctPmZkKSBhbmQgcmVnLT5mZCA9IC0xIGJlZm9yZSBnb3RvIGNsb3NlX21zZ19mZHMgaW4g
dGhlDQo+ID4gPiAgIG1tYXAgZmFpbHVyZSBwYXRoIHRvIGZpeCBmZCBsZWFrIGFmdGVyIGZkIHdh
cyBtb3ZlZCBmcm9tIGN0eC0+ZmRzWzBdLg0KPiA+ID4gLSBDb252ZXJ0ZWQgZGV2X2ludmFsaWRh
dGVfdnJpbmdzIGZyb20gYSBwbGFpbiBmdW5jdGlvbiB0byBhIG1hY3JvICsNCj4gPiA+ICAgaW1w
bGVtZW50YXRpb24gZnVuY3Rpb24gcGFpciwgYWNjZXB0aW5nIG1lc3NhZ2UgSUQgYXMgYSBwYXJh
bWV0ZXIgc28NCj4gPiA+ICAgdGhlIHN0YXRpY19hc3NlcnQgcmVwb3J0cyB0aGUgY29ycmVjdCBo
YW5kbGVyIGF0IGVhY2ggY2FsbCBzaXRlLg0KPiA+ID4gLSBVcGRhdGVkIGRldl9pbnZhbGlkYXRl
X3ZyaW5ncyBjYWxsIGluIGFkZF9tZW1fcmVnIHRvIHBhc3MNCj4gPiA+ICAgVkhPU1RfVVNFUl9B
RERfTUVNX1JFRyBhcyBtZXNzYWdlIElELg0KPiA+ID4gLSBVcGRhdGVkIGRldl9pbnZhbGlkYXRl
X3ZyaW5ncyBjYWxsIGluIHJlbV9tZW1fcmVnIHRvIHBhc3MNCj4gPiA+ICAgVkhPU1RfVVNFUl9B
RERfTUVNX1JFRyBhcyBtZXNzYWdlIElELg0KPiA+ID4NCj4gPiA+IFRoaXMgaW1wbGVtZW50YXRp
b24gaGFzIGJlZW4gZXh0ZW5zaXZlbHkgdGVzdGVkIGJ5IGRvaW5nIFJlYWQvV3JpdGUNCj4gPiA+
IEkvTyBmcm9tIG11bHRpcGxlIGluc3RhbmNlcyBvZiBmaW8gKyBsaWJibGtpbyAoZnJvbnQtZW5k
KSB0YWxraW5nIHRvDQo+ID4gPiBzcGRrL2RwZGsgKGJhY2stZW5kKSBiYXNlZCBkcml2ZXMuIFRl
c3RlZCB3aXRoIHFlbXUgZnJvbnQtZW5kDQo+ID4gPiB0YWxraW5nIHRvIGRwZGsgdGVzdHBtZCAo
YmFjay1lbmQpIHBlcmZvcm1pbmcgYWRkL3JlbW92YWwgb2YgbWVtb3J5DQo+IHJlZ2lvbnMuDQo+
ID4gPiBBbHNvIHRlc3RlZCBwb3N0LWNvcHkgbGl2ZSBtaWdyYXRpb24gYWZ0ZXIgZG9pbmcgYWRk
X21lbW9yeV9yZWdpb24uDQo+ID4gPg0KPiA+ID4gVmVyc2lvbiBMb2c6DQo+ID4gPiBWZXJzaW9u
IHY5IChDdXJyZW50IHZlcnNpb24pOiBJbmNvcnBvcmF0ZSBjb2RlIHJldmlldyBzdWdnZXN0aW9u
cw0KPiA+ID4gZnJvbSBTdGVwaGVuIEhlbW1pbmdlciBhcyBkZXNjcmliZWQgYWJvdmUuDQo+ID4g
PiBWZXJzaW9uIHY4OiAgSW5jb3Jwb3JhdGUgY29kZSByZXZpZXcgc3VnZ2VzdGlvbnMgZnJvbSBT
dGVwaGVuIEhlbW1pbmdlci4NCj4gPiA+IHJld3JpdGUgYXN5bmNfZG1hX21hcF9yZWdpb24gZnVu
Y3Rpb24gdG8gaXRlcmF0ZSBndWVzdCBwYWdlcyBieSBob3N0DQo+ID4gPiBhZGRyZXNzIHJhbmdl
IG1hdGNoaW5nIGNoYW5nZSBmdW5jdGlvbiBkZXZfaW52YWxpZGF0ZV92cmluZ3MgdG8NCj4gPiA+
IGFjY2VwdCBhIGRvdWJsZSBwb2ludGVyIHRvIHByb3BhZ2F0ZSBwb2ludGVyIHVwZGF0ZXMgbmV3
IGZ1bmN0aW9uDQo+ID4gPiByZW1vdmVfZ3Vlc3RfcGFnZXMgd2FzIGFkZGVkIGFkZF9tZW1fcmVn
IGVycm9yIHBhdGggd2FzIG5hcnJvd2VkIHRvDQo+ID4gPiBvbmx5IGNsZWFuIHVwIHRoZSBzaW5n
bGUgZmFpbGVkIHJlZ2lvbiBpbnN0ZWFkIG9mIGRlc3Ryb3RpbmcgYWxsDQo+ID4gPiBleGlzdGlu
ZyByZWdpb25zIFZlcnNpb24gdjc6IEluY29ycG9yYXRlIGNvZGUgcmV2aWV3IHN1Z2dlc3Rpb25z
DQo+ID4gPiBmcm9tIE1heGltZSBDb3F1ZWxpbi4NCj4gPiA+IEFkZCBkZWJ1ZyBtZXNzYWdlcyB0
byB2aG9zdF9wb3N0Y29weV9yZWdpc3RlciBmdW5jdGlvbi4NCj4gPiA+IFZlcnNpb24gdjY6IEFk
ZGVkIHRoZSBlbmFibGVtZW50IG9mIHRoaXMgZmVhdHVyZSBhcyBhIGZpbmFsIHBhdGNoIGluDQo+
ID4gPiB0aGlzIHBhdGNoLXNldCBhbmQgb3RoZXIgY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dl
c3RlZCBieSBNYXhpbWUNCj4gPiA+IENvcXVlbGluLg0KPiA+ID4gVmVyc2lvbiB2NTogcmVtb3Zl
ZCB0aGUgcGF0Y2ggdGhhdCBpbmNyZWFzZWQgdGhlIG51bWJlciBvZiBtZW1vcnkNCj4gPiA+IHJl
Z2lvbnMgZnJvbSA4IHRvIDEyOC4gVGhpcyB3aWxsIGJlIHN1Ym1pdHRlZCBhcyBhIHNlcGFyYXRl
IGZlYXR1cmUNCj4gPiA+IGF0IGEgbGF0ZXIgcG9pbnQgYWZ0ZXIgaW5jb3Jwb3JhdGluZyBhZGRp
dGlvbmFsIG9wdGltaXphdGlvbnMuIEFsc28NCj4gPiA+IGluY2x1ZGVzIGNvZGUgb3B0aW1pemF0
aW9ucyBhcyBzdWdnZXN0ZWQgYnkgRmVuZyBDaGVuZyBXZW4uDQo+ID4gPiBWZXJzaW9uIHY0OiBj
b2RlIG9wdGltaXphdGlvbnMgYXMgc3VnZ2VzdGVkIGJ5IEZlbmcgQ2hlbmcgV2VuLg0KPiA+ID4g
VmVyc2lvbiB2MzogY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dlc3RlZCBieSBNYXhpbWUgQ29x
dWVsaW4gYW5kDQo+ID4gPiBUaG9tYXMgTW9uamFsb24uDQo+ID4gPiBWZXJzaW9uIHYyOiBjb2Rl
IG9wdGltaXphdGlvbnMgYXMgc3VnZ2VzdGVkIGJ5IE1heGltZSBDb3F1ZWxpbi4NCj4gPiA+IFZl
cnNpb24gdjE6IEluaXRpYWwgcGF0Y2ggc2V0Lg0KPiA+ID4NCj4gPiA+IFByYXZpbiBNIEJhdGhp
amEgKDUpOg0KPiA+ID4gICB2aG9zdDogYWRkIHVzZXIgdG8gbWFpbG1hcCBhbmQgZGVmaW5lIHRv
IHZob3N0IGhkcg0KPiA+ID4gICB2aG9zdF91c2VyOiBoZWFkZXIgZGVmaW5lcyBmb3IgYWRkL3Jl
bSBtZW0gcmVnaW9uDQo+ID4gPiAgIHZob3N0X3VzZXI6IHN1cHBvcnQgZnVuY3Rpb24gZGVmaW5l
cyBmb3IgYmFjay1lbmQNCj4gPiA+ICAgdmhvc3RfdXNlcjogRnVuY3Rpb24gZGVmcyBmb3IgYWRk
L3JlbSBtZW0gcmVnaW9ucw0KPiA+ID4gICB2aG9zdF91c2VyOiBlbmFibGUgY29uZmlndXJlIG1l
bW9yeSBzbG90cw0KPiA+ID4NCj4gPiA+ICAubWFpbG1hcCAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiA+ICBsaWIvdmhvc3QvcnRlX3Zob3N0LmggIHwgICA0ICsNCj4gPiA+ICBsaWIvdmhvc3Qv
dmhvc3RfdXNlci5jIHwgNDAzDQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLQ0KPiA+ID4gIGxpYi92aG9zdC92aG9zdF91c2VyLmggfCAgMTAgKw0KPiA+ID4g
IDQgZmlsZXMgY2hhbmdlZCwgMzc1IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPg0KPiA+IEFJIHJldmlldyBpcyBtb3N0bHkgY2xlYW4gbm93Lg0KPiA+DQo+ID4gUGF0
Y2ggc2VyaWVzIGxvb2tzIGdvb2Qgb3ZlcmFsbC4gT25lIGlzc3VlIGluIDQvNToNCj4gPiBJbiBy
ZW1fbWVtX3JlZywgZGV2X2ludmFsaWRhdGVfdnJpbmdzICh3aGljaCBjYWxscw0KPiA+IHRyYW5z
bGF0ZV9yaW5nX2FkZHJlc3NlcykgcnVucyB3aGlsZSB0aGUgcmVnaW9uIGJlaW5nIHJlbW92ZWQg
aXMgc3RpbGwNCj4gbWFwcGVkLg0KPiA+IEFueSB2cmluZyBhZGRyZXNzIHRoYXQgcmVzb2x2ZXMg
aW50byB0aGF0IHJlZ2lvbiB3aWxsIGdldCBhIHBvaW50ZXINCj4gPiB0aGF0IGJlY29tZXMgaW52
YWxpZCBhZnRlciB0aGUgc3Vic2VxdWVudCBmcmVlX21lbV9yZWdpb24vbXVubWFwLg0KPiA+IENv
bnNpZGVyIGZyZWVpbmcgdGhlIHJlZ2lvbiBmaXJzdCBzbyB0cmFuc2xhdGUgb25seSBzZWVzIHN1
cnZpdmluZyByZWdpb25zLg0KPiA+DQo+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhhdCDigJQgbW92
ZWQgZGV2X2ludmFsaWRhdGVfdnJpbmdzIGFmdGVyDQo+IGZyZWVfbWVtX3JlZ2lvbiBhbmQgdGhl
IGFycmF5IGNvbXBhY3Rpb24gc28gdGhhdCB0cmFuc2xhdGVfcmluZ19hZGRyZXNzZXMNCj4gb25s
eSBzZWVzIHN1cnZpdmluZyByZWdpb25zLg0KPg0KPiA+IEFsc28gbWlub3I6IHRoZSB2OSBjb3Zl
ciBsZXR0ZXIgY2hhbmdlbG9nIHNheXMgcmVtX21lbV9yZWcgcGFzc2VzDQo+ID4gVkhPU1RfVVNF
Ul9BRERfTUVNX1JFRyBidXQgdGhlIGNvZGUgY29ycmVjdGx5IHVzZXMNCj4gPiBWSE9TVF9VU0VS
X1JFTV9NRU1fUkVHIOKAlCBqdXN0IGEgdHlwbyBpbiB0aGUgY2hhbmdlbG9nLg0KPg0KPiBBZ2Fp
biBnb29kIGNhdGNoLCBtYWRlIHRoZSBlZGl0IHRvIHRoZSBjb3ZlciBsZXR0ZXIuDQo=
