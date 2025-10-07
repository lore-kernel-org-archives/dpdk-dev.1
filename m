Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E0BCCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 11:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C38402B6;
	Tue,  7 Oct 2025 13:13:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 45646402B1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 13:13:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5970mDSv018698;
 Tue, 7 Oct 2025 04:13:28 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022121.outbound.protection.outlook.com [52.101.48.121])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49mkqyhmsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 04:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwe/GenmchT5YnkRc5663EtTYqqPanf+il3JXZuIBPGh0sUYdixbmgFc3P0XkjvMTE8QObNmyRdZC3clQo7DryFyOnSmUUIpfniHSWRv7ycE6oixZqRivcDUnHex5AajQCVihIF6pdrKpOkvVnhHt7P8n+/Pi79MGpkYePEEDv72m+GNC0T3GprDHu5h55l224gwqDg7qtuGMgK+rCORFmHvb+IfGWau9Tb35XTid/5de9SG+csndIBsJwdxbrNtu5MUt/qiEUv8CgfDYfHgFzdv5OhPnucSQWvc+h2OJSWW4mH9oZaYZLNLQE3mDZCFcUeARe0cgsMs4t5wWwbCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xk6KMtavJjm6THi2AxbQJPI46Bv2I71gdYPalEqQro=;
 b=nNjcc35AWb1KUHpZvwwucgEm8NbA9Ih6s6ULUsTZKruGAF7QC7aTUG34h7RbUxlOrIVQN8Bz5vW4ww37cc0mTDkozrGt06pBI98E6mtAtOs7u6S4DTTVf/F7jWpiHgG8uwxK5rmhpqk0OY5vGkDt1LdSYFkXhED9jp8vOagRiVt28b3ZyQj2M4HKCBb6x28V5pQXRGnHhJ2xYLchlYtl8ligGDeZxvPtFeV3r9MMXKMWJOGpFZHRDVqL9aaEvh6pdX1JqO8B0vISKnjF5AsS8N96Do6vB6/qeFDV/RClW6E+kEO8l3M+QTMfyOzNbYpwQ3X0qhZ3Yr526794ued07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xk6KMtavJjm6THi2AxbQJPI46Bv2I71gdYPalEqQro=;
 b=c8ZdwCYPrJgNQ4MgwSTGPmo4qnYBDQeBvr1cYD67FFr047DeA3A27IZX+lVpwCAQQZrS0/QAbbZhCpueQmKPiLzHzEFamCQdvE5g2Vn6EUQEfSkBYLAI2nBFlkFkDHriwyxqRrYqbdnnRThK0N+CUVEtFYMIETcUd9CjMbPFpmQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5566.namprd18.prod.outlook.com (2603:10b6:408:1a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 11:13:23 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:13:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path
Thread-Topic: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path
Thread-Index: AQHcMsLbtk3gG+Aw6UyigVPIfbMsH7S2kOGw
Date: Tue, 7 Oct 2025 11:13:23 +0000
Message-ID: <CO6PR18MB4484FB7C3691A4998082AE3AD8E0A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250911131447.1247417-1-radu.nicolau@intel.com>
 <DS0PR11MB74589FB5F44DE9D4A0349BBC81E6A@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB74589FB5F44DE9D4A0349BBC81E6A@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5566:EE_
x-ms-office365-filtering-correlation-id: 078fc17a-a950-45e8-5808-08de05928801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TzhlMkVjdmx6OUVSZ044U25LZm80OEZYQmI5MFJVSWZxSDNiWlU1RGszYUg5?=
 =?utf-8?B?dXNnZXlOWFMwczNzSGJvQ3Y5Q3k0T3FLRlV3VnpRRUd2WnlIczRtd2ZMRUdj?=
 =?utf-8?B?TGdPaWZJRnFjUC91TTFqUGhaVHJHOE9MUFA4NmJTNW5tYmFOZFd2bDhvNEZu?=
 =?utf-8?B?UTdCcXlFNk05K3VjZkRSL3N4NFN6cGFPZHQ2elkyV3hRVTNwUVU1VGNmOTYy?=
 =?utf-8?B?ZjdBTFBnUzdmWGQwbmtjYUc2K01QSmlMM3U5MUFuRVI0UXJZbld3K2FFVGtD?=
 =?utf-8?B?V0ZCSXZvd2ViS0l6QXJENS9ibzJJWUlkdVMvN3g3RlFyeXVUN0xyV3Vqd3pr?=
 =?utf-8?B?SzB6Y3dtOUs4ZmpUc0FDY0k2VHBQQWxwa0RhSGpPMXU5V3dSNEF5aEZGb0ZZ?=
 =?utf-8?B?ZkZHRzFWcmlrb3U1dkJRVU93emZybGh1Qys5RnVGWjFKeWpDR1NrSk9UZ05U?=
 =?utf-8?B?LzN6dVdud0ZscG8vNis3dW5kbFBNR1F2K3RKNEJ5ZWo3bXhGbFl2Y2FtNmhD?=
 =?utf-8?B?RzVwY1FMMFpRcGhIN1dTaUV0aTNEdndVTzE3RnQwa3JHNUFVZVdtclhzZE4y?=
 =?utf-8?B?Rm5HcmhveXg4ZFF1VHlsUms5QWcvb3U1MnkwRFFQV2pUNUhyL2J1TUdDTHJH?=
 =?utf-8?B?WUtVTUF2Y1pmVFh5VUlNQUJzTXI0d2VPRnpVTkxIVENkakZsZytTZmh6WlVy?=
 =?utf-8?B?a1FzSGdyTVRQTGY4MlhMMTZpSDNjRFdML0Z3MGlKa01GVGhEZU9GQnNKTHp2?=
 =?utf-8?B?ejNobEprOUcrY0M5OUFYemZvK1RQWVdOeUF5Yi9UTklUTm9KK3FER1VoQ3o2?=
 =?utf-8?B?NWlYdjNqWC95cGEyZ2YvUDZZdXdralZyUStxT1djeWg1dFErQVBqWWo0Ukxw?=
 =?utf-8?B?eFBpdms5R2k1ME1wVGUrZW5JMWVjTFVEMUJmSUNDWFkwVmxlSk41bUtwWDJW?=
 =?utf-8?B?eFQ2dUVUdWxMZURSZUVRQ0dTWVJhNUdUT3dDVjc0ZTVRdGdEVnlKdmY0Y2pw?=
 =?utf-8?B?bmJiVFRZNUg1Vm44RXhGUDZERGJlYmZjL3U2U1ZSQWJ1eHhXYnlScDF3RlRk?=
 =?utf-8?B?NXJnV0J4ZkdWdkNsTm5OMXhNSGZrdzNyTTVkMWdWNUZjRWQyYmVJekZnVVFG?=
 =?utf-8?B?bEtIa1d5aE5vQ1JMR1htWXNsUHFNM05ybnlxWUNSNmZZeUFJZnFyb2VvVWR6?=
 =?utf-8?B?Yi9GZlR2cGpLVzZsMnVQVmhWdHFINGtQWXlpd3dtU2p2SEV6V3E5SGFMaWw0?=
 =?utf-8?B?OStZOFBEQ2VXYzlqYnh1SWFwdnl0U1VMa3VrR01OR2VEcVIwUTBIRkx5VGNi?=
 =?utf-8?B?Q3VoY0k2MVhlUUU0WHYvbFJ1UkdBbmdqdUJHN1BPNkN6eXFGVno3V1VmZEdV?=
 =?utf-8?B?RU1lZDhNSUkvZFZoQVhDaVBjdDVobFhMMnF4MGx5K0VpZGorRWhZMXJPNUlE?=
 =?utf-8?B?VDBNaGlFb045V2dESjFYTWR2UU83MGJzWCt4cjNnNUpySjVPblIvM1NjU3hx?=
 =?utf-8?B?aTI0cVhKUEQyU2t0WTBnUHJtalJYempIVzZLWDJzL2w4a2V2dHJqczU2MWsy?=
 =?utf-8?B?Q0syZXF5RTQ0bmsvd2FCTG5WaVRZMXdwT3JaRVcwcC9RWDFBbENlSUlBR3Bo?=
 =?utf-8?B?VEw5VXJid2J5dDllRnhWRG1VRFdnWENrZTZyZ05ub0xqQjZjb1VUdVZUcHcv?=
 =?utf-8?B?OTUxOTh0cEVNNk03aXMxQTZrcFFqdnFmUG5xeHJoL3AzL0Z1eGdPZ2hRTnJz?=
 =?utf-8?B?R3JFYkVwa2ZYdWdFSXBycnkrdzR1TVN2UzBUc1ZmMXhJcFR2bVhkbDN3dC9x?=
 =?utf-8?B?MWR3NERjWFhqUEh3NEVrclpBYVhyM1FzVDRleXhIMzRBVklXUFQyUS9jRkVn?=
 =?utf-8?B?UVZDNUo2d2NaN1Q1Syt0YVRJYVNKMmFKNlpOdzhyWWxFTTVnM1pXTFFZT3lj?=
 =?utf-8?B?TDhWOFVIOHpwaDhyVldjUEhiZUFPbEVrdkJlYmN0R1M2Z0MxdTZhUHl0d3dn?=
 =?utf-8?B?Nko5NWh3N2Z3dVFubUp2U3JoeGpnNXlBSzBCYngzQW9uc2dvbW10TE9CbFYy?=
 =?utf-8?Q?dQgLXi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNQL05mRlZqMFFuTWZaUFMxbXNOMWg0Y0pLWnZCSEZzc3lUOUhUOW1OVUFS?=
 =?utf-8?B?RUliRWxQcmJPVWhEWXBTVzQ2Nkx2K0lveE5NWC9Odi9ycXZkV1V6MmFqOENq?=
 =?utf-8?B?ZkxIQ0U1TGlIZjNvT1M2L25YMTdxakhGN3JzUWthNFVOcUJmcTRlSlV4V2JL?=
 =?utf-8?B?UEVQVEZ0ZndPeVNmRnMwRmdJOFFzQjUrRk5lYnVQUVd1ZUc1VWtQVnVXaWxi?=
 =?utf-8?B?SVFZVkIzdGppZkNXc1NKdVp6dFVBVEdUbDRQcGpZZHc1aHJrQlRZTjdNU0RN?=
 =?utf-8?B?cy9sRFV4cmxVdmJTQ1RRSUdtOWtVTzF6M0k2SzlpQWo0YjhXK3dhVTFPcTlE?=
 =?utf-8?B?Qi9mL20xK2Q4Z0hBeEUzNFE3M0dZUFZheFF3NFJVRmZzMk4yeExOa3U4eC9h?=
 =?utf-8?B?ZHJOQW9LbCtpV2U4REE2WHJpcHd6Zk9kcGh5LytCVTZIc2FMc2lqU2EvUkF2?=
 =?utf-8?B?NlBmemNsL1pOY01pWFErd0psZGh3OCtsbVB2eWRUbjV0c0ZGazVkdURYMi95?=
 =?utf-8?B?aW92QXcyTEVYN21YRW5uU1FocldXUGxNL2lRV0RNQjFJTVZVbEdSajArM0NT?=
 =?utf-8?B?MU1XTUJJM3I2bVd5dmhBeVlhYWF4akJHQnFCMlU4M0crU1kwTmhrR3FLSGhs?=
 =?utf-8?B?TU5TQmQxdjJyVWxyODZ5emxpU0VlTWlwS2s5ME90NHdIZHhqVkJkVWczUS9S?=
 =?utf-8?B?Yzc3enk4SFJjZU1YVkJ3ZjAyc0dmOGUvUmpFQlFRVXJWQlhOSllaVHEwQmQ0?=
 =?utf-8?B?YW9JQTdyV3VYZFd2bEtRbCtVWVNOUmpqeGtFSUJSVHJPaUozRXV0UGRvNmVJ?=
 =?utf-8?B?d0ZyMlpVbU16M1VheE8ycWVFaGdzR29wMXRMUG5lR3Q4ekpuUE1xWlk2Nldl?=
 =?utf-8?B?TmJUZjNvOGRQcnpGK3pyNEtKU01CWjJYZzF4enVvZmxhN1RQWWE5aVg3dnJY?=
 =?utf-8?B?VlhoaGVFYjlMMEdtRkRBcFJKRUdDVnlzbENQQ1RhWXF0ekMvT3VKWFgwQ3Jx?=
 =?utf-8?B?STlMNVdZemJqU0MwUFRWQW16elJMeGhpWlhlcWFzRWFZUDJOaUI2K3RLNFg4?=
 =?utf-8?B?R0dMMDJHNWJXVnY5UnQ3SDVDbjVRM0IzQVFoM2dvYU1KSDVnM0RzRGhQUVQv?=
 =?utf-8?B?d0Jyb3F4T2RtQi90elArMS8wZjFiUTI3dnpwTFNhYjdOY3kxK2R4NFk5V25Z?=
 =?utf-8?B?UHBrL3BwcERKdVI0dlhXUEJGRUdmR1pwbVhaOUlCaXpRNVBRdVV5em9zbElp?=
 =?utf-8?B?Y3hwcEVBOTNXd2FiV1RoRHhsYWZIdzZOaDRjL0FmMFY1Ykd5WmozWHlYb1o3?=
 =?utf-8?B?QUdzN1RlQVlhNDdOSEhlS1RZdmNXSnZSQXBkMlZ5UVp0Q2JkZTdjcnIzVlFK?=
 =?utf-8?B?ZkE1aVBVeUg1WGxmdUNTM0dqd3N1amlzcVVLbFB3MmI1YUNxOXR6dk50UzBC?=
 =?utf-8?B?dm55elN4NEwyMnFIbUxqaWZiU3VoRzZUa0w4L3dLWFRudFBGL0dkcjlQRCtM?=
 =?utf-8?B?bkhiWU5LNGwya3ZVZWwxcS9sdlI1T0tYZVFoNmNHT1Fad25waHQ5NmwzSFAv?=
 =?utf-8?B?ejZvRFpVMTFDdXkvMUVoRWY2Z2tkUnlncFRXQUR3RTcxRGR6K1N2OVNBamc1?=
 =?utf-8?B?TnNkYng1aVUrNkRkM3R0azl2bUVzNDRyMTRoODUwRHBoS2xlTGI1N2N6V0VY?=
 =?utf-8?B?MDVDNVU4WXJXYXZEZHVuSkdWb0VLWUVGVFhseDIxWDlDQk9iT2h4UUJvMHh4?=
 =?utf-8?B?WXExMGY0S0crbWJaSmdEZ3JsUEcwZXAvSXNNYjFvb1liM2RRazVra1dGUUov?=
 =?utf-8?B?bEJXRURPMWE4WGNvYUQ1SFA5ak1kdk5SOGZnbUVieGt6Kzh3M1llSDdMakhH?=
 =?utf-8?B?WHo5M0NoeXhaSjJVODNxMzA4NEc1bHhuTFRIMG9SOHkzMXVIU1Q1Z2FTMGdh?=
 =?utf-8?B?TUNkNDJjVVFpSm1EYno1M0ZwZ3l5cHUxVWhFZUl0SGJHNU9kNWdDVkJNZjV0?=
 =?utf-8?B?TU83cnYxRmFDR3lVeGFTTlV1ZDZnazdoMDNzMFlKUTFnNjhmK01ranYzMzlX?=
 =?utf-8?B?bUlsR3FCVC9peVY0S3R4YU1zb09kVzFMVFhuMmxTOEdLRGwxby91R1dCbVNB?=
 =?utf-8?Q?1XA1VAI8z7uw2ghiGn1xPGXU5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078fc17a-a950-45e8-5808-08de05928801
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:13:23.7225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUEl3R+4EoJfpAVQ/Y28L5S5AKUS+HY9MC3Esu/B4luYZXt+VvqAxLMGzup4fafkQf84SKvcoF8War3CEHWxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5566
X-Proofpoint-ORIG-GUID: esWTP2JAdz8CDncbW9gzf5QKD6qWa_9P
X-Authority-Analysis: v=2.4 cv=YdSwJgRf c=1 sm=1 tr=0 ts=68e4f5d8 cx=c_pps
 a=jtibSCz00SxEcFhpBRTXcg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=jILgV7x5WoZSwjIC4YkA:9
 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE1MSBTYWx0ZWRfX0GHmfrWiG/53
 akwjJB0EzUvWVxO3le6kmO536rBlEO9tQsrgX8PtL/v9qBTMzLV610tUSKaJCXzV7j5vXJfEUw5
 gFTfCsLdfmu6GA4nFu6JCNFjWQxUnNdW6mw5thLBhZzVnk5hm3PZIQUmSQHWd4JaSZqAMsWwcr7
 x4H1KDBWaIfinP97HXOq1JLzkdsOQDjdg4gtLjvl8YC2xPNUSdTOu+NQ/hqcnHGUMTYgLTszSu1
 9CaKb3W9NtxqS14n2K0aDDK9K8hk0aiP1D8bybSWM6M4tQeIa5Jmv/7PBYMmcxafcjxaZPp7eDi
 eSN6XhOynVuvwuhP5b9DCA8YILonZd5FFRioCpPb0hkXy3artRwzGX1x3yv/52HTUfNBm9smHba
 G4jO4zpZZgsXWhK+/3611qM8S02ISw==
X-Proofpoint-GUID: esWTP2JAdz8CDncbW9gzf5QKD6qWa_9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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

PiBTZXJpZXMtYWNrZWQtYnk6IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT4NCkFwcGxpZWQgdG8g
ZHBkay1uZXh0LWNyeXB0bw0K
