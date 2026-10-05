Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80171CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44750402B5;
	Mon,  5 Oct 2026 08:47:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BACF240290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 08:47:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xSYo2348859; Sun, 4 Oct 2026 23:47:43 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020135.outbound.protection.outlook.com [52.101.85.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h3yfsh5vr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2026 23:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud4yhDj9d3FtztD0DbdB/WW0U6cRI3Hax5VFC28VoZrZgNy6cJWdyz8QdkXqGO4PF6m8j14SGcN9UQcRcR5w14F3hG5a6ZMpDk+jAQjpzoFLttFU9w/ISJ3W2ZdVGxaZDLiUweXIPcfdpM/KF5nYLOk3RZc5TRIdLn2Dv4FjZHQ2BmoBfbjfXdo1OyQcmyx7ZwxY9m6VjXV2MBh2OUKnoT1j4p1BffoSMILAEjj0oaoZ2AxxlFO618KyaXD1rlv5grD+f3gYtI4sqgj+BjCPIDxKYhvMjgCEPY13IVP/0MDDC5ISH17TN6Ib6z5BmTFhLjFfZlEufA57QqazfowuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUU1yLD+1GZyYHk5lm6W2rKLEWDwVwFzMLUIHa5UQAw=;
 b=UBCbihhw5MC9ndHiA7EU3jvzntB7IkP6DRoc9q/wihgSYCkCK2zXqC9+oVzr5llgy0Njlge87YKZgiQSWq51s0Mvm9ECVxMAdkdpJw6YH/QBjjNYhO6S7AJoL/EJsQs0yzkiDjm7A5HiClEK8660bj2Q1Bq8F3WtIGKacXsOQCDd0E5IT/utYSmoB1IbRdiYFuI81wiv1hpB0XfQbnmgcwPILCyF0+ACb/NdNSI9nP0LwBH71EyDvkUTB30NlXiEzcaNKPnvQpL/8oNobS+DSOJfFl4GEz6xTm8pc7A9ogYV/FZEQu+EtI9gBfgEFlrC964kjKjsZPGpAoeCJ696hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUU1yLD+1GZyYHk5lm6W2rKLEWDwVwFzMLUIHa5UQAw=;
 b=q8mPGBJwFlrfaOlXagXkHLuKP645ntmQEwySVChUBOahNKUNZIU1/JIwIc37yySp29yan/eWuT3KQZdsQ69DyQ/pVLt04z/hVZJYWkRRZufYH8nyU/r1pAwH2ZL8Sw3xPVQlWFRJuxKGSILt6Yiu1VZy9uL//3Ygfo9b5jBSVF4=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by CO6PR18MB4004.namprd18.prod.outlook.com (2603:10b6:5:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 06:47:41 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:47:41 +0000
From: Ashwin Sekhar <asekhar@marvell.com>
To: Nam Tran <hoangnamtran18122005@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] [PATCH v2] mbuf: avoid temporary array for bulk free
Thread-Topic: [EXTERNAL] [PATCH v2] mbuf: avoid temporary array for bulk free
Thread-Index: AQHdT9V3K6fwijhI60mVqbvAshNuO7buiupw
Date: Mon, 5 Oct 2026 06:47:40 +0000
Message-ID: <CO1PR18MB47962670A234CB4815FC8627BF962@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
 <20260929002527.7-1-hoangnamtran18122005@gmail.com>
In-Reply-To: <20260929002527.7-1-hoangnamtran18122005@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|CO6PR18MB4004:EE_
x-ms-office365-filtering-correlation-id: f09d58ba-eb5d-4d90-15e5-08df22ac8d40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: gB5ft9Pw4YHmvJ6/IetAaPerBYx327eiJx5lAVVCSpxpW9lRfRfdCECsAo9u3dCWu2QP8LqPJR5N65AzIxxchrdvdFtus5D/xRN72dyR6rV0f9bTpn1R9KpCXJxbs1LUWLLFbZ/GenSZqlBN+TkpRp2dzCCvZ7stThc4lRcT7Yt8UMXBhPbfjZW2m7mUCvxXRR8avyRJ3QsSWZZuEjqPjb2RCqLOtrM+6Kyu/qPjToKEiECxGAnpozsXkxVvSXQ9TvuWFQYaHoFDNqShtO5Bn1nuVNpOFix4ewIVbQcmsNEnmRnh99KcC9TKQ5QqdVxZCm3mYty1msDRSPYNifC0O6/zwrfutrRTF+PC2nfUgGufoh9ZC/q66X0DS8+GzUDrLAnxFv0h16Aht7bnD/wGQo6rAdqzA9RRUareIkh9F+LFdO6UR7kqWaVopcpTkAaFJYtkR8CFdqY5g55VzO/tJAo/ESuumgPnpdNFvfrI/pOsR3Kzx8pMeaNBMY6cGdZkC2h+FViHDNS2BxkVvMZheSLRohxoVOsl/pK7zwBVrykCNwElf8OpFMwBmYh/56BaRcNzfAYDcSiDlVVZ0wRhhz321XGBnyzmrJ0lBmhVt1oxHzaWMm4De49AaXmE3IgDoHgLnma3qwoWLbzwiTj7DnaHRfwvxW4oC4Z64t4VVF1R4gOvYvTU1C6MImoyI+rMgEyeLeP8mhk6/r1gM0atI0wHHYvlixp+0kqjM6p+Bm0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVdtYVJXMkZqVWpHMWlJTzZ6UnF3V0xjNi84RXpMbk1mMnIyU1Znc0hqRU0x?=
 =?utf-8?B?TXpEbXR1OW9aZUFQcnRzcjdMQ1BIZTh2ZjRIeGltTXV1WFVqeFc0SG9uRFo3?=
 =?utf-8?B?NU95V1JpeUN5Nm5waW1Qd3IvVThWdHRyUHp6N0tEaG1lRnpuSGlzQjc5OHYz?=
 =?utf-8?B?OXlSbGsrcnBSV1hkZ3dWZmpxUFVpQkpxazFaY0NYc1JpUUZib1VkQi9yWWtn?=
 =?utf-8?B?NmlNNUo1VGlvVUxJWHNiZFRxb1VFenMxYTNEL29ZVXFYeXJvQUE5MnFyOTB4?=
 =?utf-8?B?enhBSmw2S3E3Q25sMkFWVEROdi9NYStQaTQ3RDltMXNSQmN6YWkrc0VFZUNB?=
 =?utf-8?B?WGlLenJYUzhjNXZzdFFVN3FsRTJVbStnM2ZFRmdIMmlNekgwNGx5NWdOS1JZ?=
 =?utf-8?B?OVROeS90MEhsUThLQnM3cC9QTW9XNS9uOC9ldnphVFRJQTRWVXd1RThWZ0hu?=
 =?utf-8?B?YndnRGlHNnFLWGFhbW9qcms5dnM1em9IRjdSVjFjejg0bWw5YmhhK1k0WGFC?=
 =?utf-8?B?SEFCMytrQmVHcFhsL1k0VDRadDNzQTVaZUljN1NrWkhIQ2hxZVJxMWxMdFJs?=
 =?utf-8?B?QTNSNmd1UmUxRnQxZVNpRnFaTUQ0c1dOZmx3Ym1CNXJscGtvYkxGcE5CQjEw?=
 =?utf-8?B?OFZlT0ZqdmFZa2JLWmhES1B4RXJHNSsrejRQb0J0dkRIZVloRlBtQzMwdHFJ?=
 =?utf-8?B?cytKNWdjMkRvdFF2aFI5bGdBb1RYSjBqRXpNRVNKVFFnMFVJT0N0cWJhRm1j?=
 =?utf-8?B?bjk3YWNZNEhlUjRmajgwMkk5YnFHNFlRYzJtVGFzb3ZaRFdHWEdNNnJZbEV5?=
 =?utf-8?B?VE45L05NS0c0VXEwcGNxekpCS0QxVmRlNlhKcGtoenJ0bXA3U1hLR2diY2JH?=
 =?utf-8?B?dUcyb0ZSdzFERHNRQ29TYlI2MGFrTUl3MUEwaFBHaHAwcmtYV3NqOTFZbnJz?=
 =?utf-8?B?aEhhalNqVlN6Wm9aNTFGZE1vWVRGN0NDQ0xkTEp1cGoraFJNN2VSQ3dlN1lY?=
 =?utf-8?B?WFU2eUNaMlk0aEJ3L0hXc3I3K2p6bHl6RWxNeTZOcm1hL0NNQjUrMzI2NTUy?=
 =?utf-8?B?K2ZvMENDSkhUMFQ1VnRMOXkrbDUwTXJ1MkJuNzNlcERJQWJXdk9HbFowWXhu?=
 =?utf-8?B?VEF6NEJONHlQdVMyTXpLUDFWRFNWYUM5Q2lWQ053VHFzc0ZBUTZYeVQ2VlhW?=
 =?utf-8?B?eC9wa1RnZkRnUUtMNmF1SDVoaFMvV2VMMHJYUjF0Z1ZYYjRxUVBFT0sxNzgy?=
 =?utf-8?B?ZGg2ajlja3BRNnFSVjl5Z1VITnRBYlFwcjdBcm1sMXlQUFErc3l1ZEJ1MGUx?=
 =?utf-8?B?cnFXQ0VFWkMxVkhWM1RMazhZVW1rZko0czluS0lTcWdEdHFmTXhMQXRsOUZz?=
 =?utf-8?B?b01TeEF6Vi9jRXVFZC9GWGlicW52R0ZMQVdlTVdQRE9tR1JUYzF5YmJTT2Fy?=
 =?utf-8?B?R1V6SHhyTWlPT1hjNGlZdEY1VzBCcXBsRk5wci9nTzZ2SlpWSExQb2dqOFhH?=
 =?utf-8?B?ZmVlTGsvS3R6TnFLYVROM0xxRjhCelloZmFvMmxqdVVlK2RnTnh3ZmlOTUhF?=
 =?utf-8?B?TW9HNDJrMjhydnFPZUNxK2Y4czh0M1hsMkpJT1ZLOUo5YUgzMlA1YnRXT3BL?=
 =?utf-8?B?WGR5UXl2QWZmSVBwV0p3L3hDTFg1UjRpN0NHeENORTlYNXU1Z2tlaHlPRlRx?=
 =?utf-8?B?cmg3akMySXhFRXNCNVhndStVYUVVYUthT0JmNU1rMWx3M0dRTFV5UUhNbkdt?=
 =?utf-8?B?QS9LVkFSa1dEem9hc3B0U0dFaWFzNGY1RWp1MERib0YrSmZ1d3BNY0xMd2lH?=
 =?utf-8?B?Rk9FKzRFSXNXaTNBWTgzaS91blUzUkVIZ1VHZVFycXN3SjVGRmVQczBDbXh1?=
 =?utf-8?B?TjV0ckhBWTJWSEFUR2wvb0phdUhUMDFTSGNYMDEzZ3VScWtsQzR5amFMblhB?=
 =?utf-8?B?K0JDanpuL21MNC95M2FaKzVyc3NWN1FwQm90cXNHRHVZbXpvM0Jyd3R4NHoy?=
 =?utf-8?B?YmVIeTJ1VDRlRXR6MkZiajJyQlRwN3BreERMdVdITENjK0VIZVZZWmhRNXN5?=
 =?utf-8?B?Q0JTT1JKSW9wbGMrMERaUmdBMjZJS3U1d3NBUXM4QUczbHc3RWtzWWQ3L3Yy?=
 =?utf-8?B?Q2JaRGV2UzA2M2RjbTgxeHdoQ2x4ZlJlWkRQcnFES29TajdacUpxV0svMFNr?=
 =?utf-8?B?Lzg4QjlTLy9IMWwrcG5BZklPYXlhMHRPaUU2MXcrU3ZCRHQ0eUg2RklpamQr?=
 =?utf-8?B?L2d4SWpYZHd4am5Sam1jRWRCZFBWdUxtdnV4ZWJEWUkveTNBTHdNMURRdjBR?=
 =?utf-8?Q?4o8jKjIueYPxtZPYXY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iv2qcByp7gp9stXnXNuK8gV39Pk81DJkCQjjtt1ptEHbgNcJB3VN5aMu8+Go4aLhuWL/kYt2TqMYUmXkNvbcxSaY32MY4BRSVt0tXtDr5GAFajhCTEo5e69o8jcRNCkLlK2qWvMvqL5GQceQyXchfLliFAciBFpFR1zNi52yj7CB0EVKzkNXk5PTwymsCZpTOU69lXGg7NNPAaXvhABECkuUxSZpBBiiX6Sz4D4pqSgek0DK9a4yUJZd48kUMQAPyw0Nkiqc5O0XF8gbLAqgtuI9r6XEHwNi5TkrG0p3wf7p6INROvn+3RNuapNv4sU/OmUR7Rg5jAJxov26ul4K8w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09d58ba-eb5d-4d90-15e5-08df22ac8d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:47:40.8306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fokGI9Jm3XEvLrir2QAUJjaqvYSetR8ZwVlzj5jnrDvtWQ3jVPmgbpfrBZKgqMIUMkryFbKflsPSaxw7yVo21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4004
X-Proofpoint-GUID: 0o_cQftcMgBwLJ-sTFQN8mqgCwFxDBPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNiBTYWx0ZWRfX3qyEdm1JI8JH
 tfzXqRLx/mVcfliN0KaAM69t5qjnGCSZSQPagQjy7cgaRTo0ZB1/cLBmqETPbDRTRKoogU+G5OL
 1ghudAHpNT81pwMAcYS3eJjdnkTa4yBFWc7tza/H+pZQQrbwjzXKf8I124DbdWvpetm9FcP9wz7
 BOjAFP7wmpnV3bq48OSwwL/0aGX/wouC4jkeBq8zOCWKU/6IOW9FNOOzQukMKP89UaH5r55X749
 hAD9PvYqGYDcEZX4JOswRg8ck+FVGshgaDvMV53MkktcPqMjpFrBO59e9t77B4M1EntcqCsn0hF
 AfgrCE/iCzeOxHl5JCks5f/JMqhj69CWcwrbn7RamIhlApFjyKIsZvSzTLKinTgda7CLLwCnBMM
 hjOw7VQx9U0mzUYSm6f3aFfJzHv5wUrI1U1Vj0kRmjAzSeML6viAudsK5eATi7E6XSQxe81jxSC
 6/lb0A+WJ2/6w5c4L/g==
X-Proofpoint-ORIG-GUID: 0o_cQftcMgBwLJ-sTFQN8mqgCwFxDBPc
X-Authority-Analysis: v=2.4 cv=MsfHeGae c=1 sm=1 tr=0 ts=6ac3480e cx=c_pps
 a=gLGM17pEjTTnGae4oH5VFw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=y0LlIRP-bvxlT9vdxu8A:9 a=QEXdDO2ut3YA:10 a=h4KV_7obaVgA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNiBTYWx0ZWRfX1eFOseTpO3hb
 mZjq3hE1drNAz3mgsP3Avna62FqsT4AyT5lKgYlOrMueVoCSL3QHpaHiupzPlpLKecK4HNkGtYt
 wXBUnS83h0SHxbdpg7MV5SPvdfruylU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
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

QWNrZWQgYnk6IEFzaHdpbiBTZWtoYXIgVCBLIDxhc2VraGFyQG1hcnZlbGwuY29tPg0K
