Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCFCCD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDF1540272;
	Tue,  5 May 2026 07:55:03 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6433D40270
 for <dev@dpdk.org>; Tue,  5 May 2026 07:55:02 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644M405Y3659299; Tue, 5 May 2026 01:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=K
 a9wBS+TXxrZN+cDaQGgqOukBUX7Wv1W8lSK5YLpQ6Y=; b=wQBUjEesldke3sGZu
 ZLb2cMzheZ3EWAqC9Wlv+Iw4abu4SFbxq3YjfomeLP1TjtA/LdM1CqKpfFBHI00M
 Kh5ZEoTShQtlHUL4vqPUirpd14T31uB4NwounNMwu4qZQr2M0XvMj/Q63l7DMLRZ
 h9ngnZIvl11HImceRWHbbri+AlG7O5EeXOgTujofiRFaHdPMUZPLnBFcQk5UMDxH
 KVvPZTrbRSAnDlwTRBiK6Q6zoVPgzDkrkEhcUBQ3ypcym9bhdTqTBW/emnAx5rGo
 FRnWRyGOkBohTV3vWQb8ZFB5TI/FkRpZsaG7lOZgekhdNkFeAwyBvLtxd1PJtBqp
 h7tFg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dwd9c9f5j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 01:55:01 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6453Zslv3319190; Tue, 5 May 2026 01:55:00 -0400
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dy3c1muuj-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 05 May 2026 01:55:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Awo/o7kPHr99f2VUhReRNUluof9W9oNjfQoGE98/T23R6wDGuYACRPz9JIpDNw9ICDvk2oEnT0V3NOT6tGQRHExvxekUFA2GM+1n6XXeR3SFfsackiVW2OJ8k4iKTRsT8b5ArFpP1JZeJcSQSA14uqpzPN59AiLG5wg6e7l44X5ccwxfCtbB79CHohBE5FcOUqOamPdxGvvUA8OoTemGPwi6AA5gT+IfVAwtT+rK36M2SnVgi1HewXIf7qc7R6j7CagOrElAiCSWCK820naoflFBWWJKQf0xcln+yQvTegF1/Irg3QdvLJdmEAwpS+021JekN6ksURJMtAo7SpNMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka9wBS+TXxrZN+cDaQGgqOukBUX7Wv1W8lSK5YLpQ6Y=;
 b=IQ2w5doN+76hA6semxxJe+xUPAWns74AOLk/KRJkw8NT3YWpOueBIAudsZMeMOQDmFm/JukyP2utK00s/yG112RY4lzibPLocqgfpXRbMEh6gzTYq6tangP8VMqIKm47ywvMbM0QEdKYnNHznM8J9yrsiuYdMWfw93yJS/UR/K7d+BzJcZM7r/MdSZd/g1pqcjw3r1pp4yxrrn449EyHA4pQCkLzgku+C0Vhv/iFTHxyIQp/QzEw91rz2dgak2ZBbrO8ibELgfzIj+zDS5qif+oKALHR+nvuHGZWBKxObVAJbtzCIR93CP7fJTE99QFQ48yfsxGRjiW7qRPJqCBOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by DM3PPF470CCF9C9.namprd19.prod.outlook.com (2603:10b6:f:fc00::71e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 5 May
 2026 05:54:55 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 05:54:55 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
Subject: RE: [PATCH v10 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v10 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHcxt+ywtDCKgcZpkWhHOgGi7Lor7X+ML8AgADokgA=
Date: Tue, 5 May 2026 05:54:55 +0000
Message-ID: <DM6PR19MB35645B8E93589420596110A3F53E2@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260407224205.3910803-1-pravin.bathija@dell.com>
 <20260407224205.3910803-5-pravin.bathija@dell.com>
 <20260504090120.2c00c986@phoenix.local>
In-Reply-To: <20260504090120.2c00c986@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-05T05:53:44.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|DM3PPF470CCF9C9:EE_
x-ms-office365-filtering-correlation-id: 701bcd48-a08a-4845-2bb4-08deaa6ad554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2XhPDyOjPOY6PxgrDxIPwP8YZMWDYg9kbghnQpcVOhR0eodQmPhqyjctHASb8H5iOVXpRy8MXCVL0D2XxT36s2EKQrtne9uuGuaGLL8I0LJuJdHFriZRMUzeTS/cWGR3e5p3ceiotlUjw9cPzzVRUmqafZmPX4ed6+G8FYcWEhkPd//U9QjLi/3jt/mCV8Ur9xGQ3p+7zRHfsjbDCko2VrzCdS1yt8QK2VtXdDd/Z5uTYWGsLn6nMIMobGREArqFXK+QN440nY61AU4GP+dkbJkeasxPVzJ00nKyjs3zz7Jdq4pz584l9f86krEm50BDFyI3F0sS98Pd3DylgeTZ4bnl5qApbvrma4sazXISl0QeY36QyqMe14bzLRWyB5+XFQ3eeID0Nf6KUxyjCzdbcBsF31rEYAfwDLm9w7tQwofYoMGKQsgxTgTMfXOnD7eeW7Y9EowbvIpAeVCxsdsQWA3DO0SwRHEtsHUpq6Fk7qCEIU3It+9+8Jbw5DXxqAgbEvXBuGk3+1PKsllaRW77m1MjsiwjeW7qu6IcNI7dTTZLX3PDtX/kLiVSUjo0/ciphsCHYpdWSoV98uZDg5os7aCcIAjEalRRepzCkD8vnwWL+LkU7JW+TUF79cnctZcIdqvYDwhMkGqulbSzn9AVdKBA7AwfSCTJqyzLeKxL9HvtucQqnJVvmJ9wFCQoDirRHn0G66p9iisogmxBt0/+miT3IN62AomrL7WcRvThKJim/eYpBdH2/npncEuKNBzg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWh4RzFwREtYK3RSSTh3SjlxQkJRWjFHQ0RqM3hkRmR0bGVXTGVrQkRiNmxP?=
 =?utf-8?B?Z3VhMmtlSkdsS2tZeXBpcWN0am9vRFNYcnd4ZmdUL2JPM2RxWlE4bDAzc1M0?=
 =?utf-8?B?bi9hb2hiWUJRQVdXRXh0UlArNWxtS2cxb2N4MU4xRjkyVGFVMThIc1dvNXpk?=
 =?utf-8?B?a1NNa211Mlgyak9QeEwwdjRBV1p3V04rc2hmbmhJOW5XbW91YXRsU2JrUjZs?=
 =?utf-8?B?NWdxaHJsdDAremJlUXZOWDZleU1JdjBxUFgraU0xblBQVU55aHR0S0gxc1dY?=
 =?utf-8?B?SlFpR0h4ZmVob0xTQVlxNE5xRUhIMDFXVnRJT1JYcURkeU5vVTIvY0hkeDN2?=
 =?utf-8?B?YWMrZTF1VVFaSkFneURyOUpCL1cxUWQ2RGp4OVUzWXpENkdsL3JkM25YQlU0?=
 =?utf-8?B?d0pJaFpYMVQ5b1A0MVR3eWIxbmhaTXp0MnU3SW4zQzZvQ3ZwOHdZVlZSMGkr?=
 =?utf-8?B?YmRBQnlhaUxEWVBPWGNsaEpJbTlLa2dpOUg4Z0pxbGNtUGswTk14c0Jvc1Nk?=
 =?utf-8?B?UmlUMVNoYjlUM2NadVc4QnJyYkRVek95TXdORlVhYzlLQlBtSlBDckd3MEQv?=
 =?utf-8?B?VUNQdC9UZTRGTVdTQmpNWXBGQkQvZk91NFA0MW4wWlNiUVNDVy9DZ2pNeWtJ?=
 =?utf-8?B?d0FsQ3lFa09VQlY1aC9iaUp0RjJqV3Vvd3c4S2R3L2EwSkRMSnZ3cVRXVjN4?=
 =?utf-8?B?am5rd2lwQVBmSHIrUkdUQzdsWU9nZjdPRzJPOW9jQ1VhOGZhK0thdHRjcGxq?=
 =?utf-8?B?Wkp4Z0RGazhOTjd6M01zQ2JZdEh2N2NlQUJ6NzNUM1hMb1BpSWJhL0pxYTFk?=
 =?utf-8?B?TUh1NStKSnlqU3I0bVdxNklRc3JPaVhWMkFya3lXcWZVSFE4V0NlM0NsSkl0?=
 =?utf-8?B?bmVSbEdCTndPc0xkaUZTV3FhRW5oL3dhZ2k3ZDFOekVtaHBZL1JycFdPaTY1?=
 =?utf-8?B?dXo3d2M1M1gwSzcvU2puWm5xenVLWUZGSGNaTHBVTDFVRmI3WHhjaWJnODRs?=
 =?utf-8?B?NmlBZ0t5L2tiNG9rTDFudWxzV0tyTnJxR096L2JldE1jVUVvbDN1VkN0c3lR?=
 =?utf-8?B?M2dvRXh3YTh0ZVRIckFySFF1L3VsMnFub2daL0Y3ak1RWGpGWnFUeUVua0pO?=
 =?utf-8?B?S3krTWtTQTZZZnVRa3FOK29OUUVDTDVhZ1JlWEJUTDRXNE12QWgyLzJzbDMx?=
 =?utf-8?B?aUdRQm02MVMrRWVrcW1xS1ZKMjJoUXlJQmx5Q2wrOXBoT283dHBjQUdycjRo?=
 =?utf-8?B?VGJSbUgxWTJQaXdFVWVLcXUvaHNNZFMyODA1QktJS1BLU00zdFY1NnR2SjVx?=
 =?utf-8?B?S01RUnIxUU80bDRYOE1xZ0ZZcUlVYTh4S1NBKzFlZWVPanFJR2h3eDBwUkV1?=
 =?utf-8?B?R3VJaVhpbHY3Rm1EUmpPS0VoUVVSbEl3MjdtZ0J0WmNkYk4yNCtaT0Q3TDFF?=
 =?utf-8?B?SnhkbXYxR1Ntb01rNkp6eHd1MWpUNU5uV0ozUFF4Vlk0RjJEZ01hdnd1ZlhH?=
 =?utf-8?B?L0ZKS1YxSVAyTWl0Y2hiSktweUVXN2hxM29yWHQwUVh3R29LdlBqbG1kTXpy?=
 =?utf-8?B?V09YcmZPMlFNWVVNWkFWWDI0RkR2TU9ZZ3dEMm9hSHRrUStaYlBxWGNDS1Vt?=
 =?utf-8?B?QkRibjBRVlJzZDR6TkZvbElKSGRWbG04cUl3NU11TDVIK0xlT0VSR3Jwb3lN?=
 =?utf-8?B?cVpRZVdxWUYxOVpteWNibHVBbFVEaUZQMktaQUt6M2x0QUoyam9vOGIxZ2Zk?=
 =?utf-8?B?dHlROFlDYjZXU1VUa0FiZ002WTR5NG41WlZtdlNaQitkYWNwbTRIVVlXdlJp?=
 =?utf-8?B?L0VwUWw2c0NGOXBQTkxkbnU4UUV4d3VhOGlkR2IwK3YydXBwaTE2bit5Z05F?=
 =?utf-8?B?eFNCc253cXNPZEtaZTlrR1MyUjZLNzg0M1VaWmFKcTZnM2xwMXdqUUQwY05k?=
 =?utf-8?B?aVJST2JIVk5IL3JoOEVDWmRYeXpjWW90SURmUnVUaHJBamdaaEhXTjJPUVBS?=
 =?utf-8?B?c3lMN2JOY29QUW4xRktHWWhTdlVCYjA3SXpBV0dnTWZCS2pUWjg2Yy9HUWwz?=
 =?utf-8?B?OFArRG1Hc0hQd3JuN2pQRnN6ai9EWFViMXVRV0h5K0t2QzZJdW5XMnpoQXlh?=
 =?utf-8?B?eDlXbFNSY3E1RVVGbTljL0Z1WUVLSjc4dmIrMzdiamJlYlREajNhS2pXaUw0?=
 =?utf-8?B?dEZ1Y1pFeHhYczdlNVdJa2Ewa0VXY0xXYklxZjJZNGliWXpiUk1Nci9uY25R?=
 =?utf-8?B?bkdqN0pveG9GbkwxWk5WaG05RUdFbUVxandLWTRObnBYZTNQMkhBMWFDQkFQ?=
 =?utf-8?B?MWJMeTZ4WDY1emZhQkZMSXJEakhpTlRDdFJZM1g2ckxmdDJ6YVZLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m3oc0w7aTY0W6+aohPyyWTSAGxtekIvlvBJECzuo44oL1DtSND8CSea8gMcDUxEW50+fLJv6N0VEQmsRTe1bNfXFaAKrYqBpwS/B8oP+Zih6gn/v+yeUUw8ZCU9XILK+Ce2CbNJ6gE1d50GpO8QNDqm4dEDb/VMvwS03Zv3XZ2ajJ/6CbY6f+c5JQMuj/BI4Ar7vxc1css+j0XjOeA2OKUeIy2lY5tJssX+0dGekPStdDlnzirb/32pK99/pvbov8PHAeYHhSfBfH1X9RCLICsiB6t7Dk7A6AksbAnHuJAA+RLH/5aB4ZjrVeCOD7SGjz5EQ436ceiNpF6JcT26HzQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701bcd48-a08a-4845-2bb4-08deaa6ad554
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 05:54:55.5052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0JqFJkSM3PsWlmE8ko9QdkCtULWDLRij2DpEk83KUDmqJ4ILMT8VMpVPR7woeO+xYqPP0D7kfBEGqtOIwi9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF470CCF9C9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
X-Authority-Analysis: v=2.4 cv=JrzBas4C c=1 sm=1 tr=0 ts=69f98635 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=PpEg0BoV_A2aca28hXd0:22 a=jZVsG21pAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=-ywTYykgfPDorzOe38sA:9
 a=QEXdDO2ut3YA:10 a=hlJyneSgMmFPbskH-t2w:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-GUID: 36Mc9SwzNR44MKkUEsZ_k5Z2J9amewv-
X-Proofpoint-ORIG-GUID: 36Mc9SwzNR44MKkUEsZ_k5Z2J9amewv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MiBTYWx0ZWRfX3Gdpd7aTa9sT
 /VHNzGdzhoJmmzSwFiNSbrEkl7VuBOrKJ+jxIOjhtWBpYk+LpP+GQUdEX7vOqadp+6RjCBVQfyU
 pSFvAcv8N02GUUa99GQ6no/7ncX0dS8or2qKdJL/QgQqlqNjxatH7kUu0+ep3hNooJYHzkFW1eJ
 atqFRK/JTGVyG00uZnCsDgqlaKN/rpOOydSMwVNSCZD0XW5ueQqxvE5j3H3De1wrdz9PM90pku0
 deOoS1JAmaM/R3YRDigdOUs+lXCdaxFUqUtKJ3I7UvhWiUdk7daRunMUlBLYtH282tIHD1UI+t3
 P7F6NCRpcC7Rpi8Kx+zsnF+WGJyr60tgmlhGSqlHhBHtIbf6k9SpfyVxK/asc8ssQzGhG9ou0+p
 J/qHPjR654WY002DVXQ4jKggL0/VqVvFrlHP/jJ+YngBTuJ5N2PJgfH/w6vxKGRZqx8/focIdnp
 q5+I1/PfCJRSiyMKXvA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
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

SGkgU3RlcGhlbiwNCg0KVGhhbmsgeW91IGZvciBmbGFnZ2luZyB0aGUgaXNzdWUuIEkgaGF2ZSBz
dWJtaXR0ZWQgdjExIG9mIHRoZSBwYXRjaC1zZXQgYW5kIHRoZSBpc3N1ZSBoYXMgYmVlbiBhZGRy
ZXNzZWQuDQoNClJlZ2FyZHMsDQpQcmF2aW4NCg0KDQpJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRp
YWwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSA0LCAy
MDI2IDk6MDEgQU0NCj4gVG86IEJhdGhpamEsIFByYXZpbiA8UHJhdmluLkJhdGhpamFAZGVsbC5j
b20+DQo+IENjOiBkZXZAZHBkay5vcmc7IHRob21hc0Btb25qYWxvbi5uZXQ7IG1heGltZS5jb3F1
ZWxpbkByZWRoYXQuY29tOw0KPiBmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxMCA0LzVdIHZob3N0X3VzZXI6IEZ1bmN0aW9uIGRlZnMgZm9yIGFkZC9yZW0g
bWVtDQo+IHJlZ2lvbnMNCj4NCj4NCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPg0KPiBPbiBUdWUsIDcg
QXByIDIwMjYgMjI6NDI6MDQgKzAwMDANCj4gPHByYXZpbi5iYXRoaWphQGRlbGwuY29tPiB3cm90
ZToNCj4NCj4gPiBGcm9tOiBQcmF2aW4gTSBCYXRoaWphIDxwcmF2aW4uYmF0aGlqYUBkZWxsLmNv
bT4NCj4gPg0KPiA+IFRoZXNlIGNoYW5nZXMgY292ZXIgdGhlIGZ1bmN0aW9uIGRlZmluaXRpb24g
Zm9yIGFkZC9yZW1vdmUgbWVtb3J5DQo+ID4gcmVnaW9uIGNhbGxzIHdoaWNoIGFyZSBpbnZva2Vk
IG9uIHJlY2VpdmluZyB2aG9zdCB1c2VyIG1lc3NhZ2UgZnJvbQ0KPiA+IHZob3N0IHVzZXIgZnJv
bnQtZW5kIChlLmcuIFFlbXUpLiBJbiBvdXIgY2FzZSwgaW4gYWRkaXRpb24gdG8gdGVzdGluZw0K
PiA+IHdpdGggcWVtdSBmcm9udC1lbmQsIHRoZSB0ZXN0aW5nIGhhcyBhbHNvIGJlZW4gcGVyZm9y
bWVkIHdpdGggbGliYmxraW8NCj4gPiBmcm9udC1lbmQgYW5kIHNwZGsvZHBkayBiYWNrLWVuZC4g
V2UgZGlkIEkvTyB1c2luZyBsaWJibGtpbyBiYXNlZA0KPiA+IGRldmljZSBkcml2ZXIsIHRvIHNw
ZGsgYmFzZWQgZHJpdmVzLiBUaGVyZSBhcmUgYWxzbyBjaGFuZ2VzIGZvcg0KPiA+IHNldF9tZW1f
dGFibGUgYW5kIG5ldyBkZWZpbml0aW9uIGZvciBnZXQgbWVtb3J5IHNsb3RzLiBPdXIgY2hhbmdl
cw0KPiA+IG9wdGltaXplIHRoZSBzZXQgbWVtb3J5IHRhYmxlIGNhbGwgdG8gdXNlIGNvbW1vbiBz
dXBwb3J0IGZ1bmN0aW9ucy4NCj4gPiBNZXNzYWdlIGdldCBtZW1vcnkgc2xvdHMgaXMgaG93IHRo
ZSB2aG9zdC11c2VyIGZyb250LWVuZCBxdWVyaWVzIHRoZQ0KPiA+IHZob3N0LXVzZXIgYmFjay1l
bmQgYWJvdXQgdGhlIG51bWJlciBvZiBtZW1vcnkgc2xvdHMgYXZhaWxhYmxlIHRvIGJlDQo+ID4g
cmVnaXN0ZXJlZCBieSB0aGUgYmFjay1lbmQuIEluIGFkZGl0aW9uIHN1cHBvcnQgZnVuY3Rpb24g
dG8gaW52YWxpZGF0ZQ0KPiA+IHZyaW5nIGlzIGFsc28gZGVmaW5lZCB3aGljaCBpcyB1c2VkIGlu
IGFkZC9yZW1vdmUgbWVtb3J5IHJlZ2lvbiBmdW5jdGlvbnMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQcmF2aW4gTSBCYXRoaWphIDxwcmF2aW4uYmF0aGlqYUBkZWxsLmNvbT4NCj4gPiAtLS0N
Cj4NCj4gVGhlIHJlc3Qgb2YgdGhlIHNlcmllcyByZXZpZXcgY2xlYW5seSBidXQgQUkgZmxhZ2dl
ZCBvbmUgaXNzdWUuDQo+IFRoZSBpbml0aWFsIGRlc2NyaXB0aW9uIHdhcyBhIG1lc3MuIEFza2Vk
IGl0IHRvIGJlIGNsZWFyZXIuDQo+DQo+ICMjIFJldmlldzogUEFUQ0ggdjEwIDQvNSDigJQgdmhv
c3RfdXNlcjogRnVuY3Rpb24gZGVmcyBmb3IgYWRkL3JlbSBtZW0NCj4gcmVnaW9ucw0KPg0KPiAq
Kldhcm5pbmc6IGluY29tcGxldGUgY2xlYW51cCBpbiBgdmhvc3RfdXNlcl9hZGRfbWVtX3JlZygp
YCBtbWFwLWZhaWx1cmUNCj4gcGF0aC4qKg0KPg0KPiBXaGF0IGlzIHdyb25nOiB3aGVuIGB2aG9z
dF91c2VyX21tYXBfcmVnaW9uKClgIHJldHVybnMgLTEsIHRoZSBoYW5kbGVyIG9ubHkNCj4gY2xv
c2VzIGByZWctPmZkYC4gQnV0IGB2aG9zdF91c2VyX21tYXBfcmVnaW9uKClgIGNhbiBmYWlsICph
ZnRlciogc2V0dGluZyBgcmVnLQ0KPiA+bW1hcF9hZGRyYC9gbW1hcF9zaXplYC9gaG9zdF91c2Vy
X2FkZHJgIGFuZCBhZnRlciBgYWRkX2d1ZXN0X3BhZ2VzKClgDQo+IGhhcyBhcHBlbmRlZCBlbnRy
aWVzICh0aGUgYGFkZF9vbmVfZ3Vlc3RfcGFnZSgpYCByZWFsbG9jIHBhdGgpLg0KPg0KPiBJbXBh
Y3Q6IGxlYWtlZCBtbWFwIGFuZCBzdGFsZSBgZGV2LT5ndWVzdF9wYWdlc2AgZW50cmllcy4gU2lu
Y2UgYG5yZWdpb25zYCBpcw0KPiBub3QgaW5jcmVtZW50ZWQsIHRoZSBuZXh0IEFERF9NRU1fUkVH
IHJldXNlcyB0aGUgc2FtZSBzbG90IGFuZCBvdmVyd3JpdGVzDQo+IGBtbWFwX2FkZHJgLCBzbyBg
ZnJlZV9hbGxfbWVtX3JlZ2lvbnMoKWAgY2FuIG5vIGxvbmdlciByZWFjaCB0aGUgb3JpZ2luYWwN
Cj4gbWFwcGluZy4NCj4NCj4gRml4OiB3aGVuIGByZWctPm1tYXBfYWRkcmAgaXMgc2V0LCB0YWtl
IHRoZSBgZnJlZV9uZXdfcmVnaW9uYCBwYXRoDQo+IChgcmVtb3ZlX2d1ZXN0X3BhZ2VzKClgICsg
YGZyZWVfbWVtX3JlZ2lvbihyZWcpYCkgaW5zdGVhZCBvZiBqdXN0IGBjbG9zZShyZWctDQo+ID5m
ZClgLiBLZWVwIHRoZSBleHBsaWNpdCBgY2xvc2UoKWAgZm9yIHRoZSBjYXNlIHdoZXJlIGBtbWFw
KClgIGl0c2VsZiBmYWlsZWQgYmVmb3JlDQo+IGBtbWFwX2FkZHJgIHdhcyBhc3NpZ25lZC4NCg==
