Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3415CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F01594026A;
	Tue, 11 Nov 2025 12:28:15 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4D19640144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:28:14 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6iefn026594;
 Tue, 11 Nov 2025 06:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=0
 SazHXtHKL5bDNMMhuh+8lAYq7ACG8fbj5ngurCZdIk=; b=J5x+KhGi1hIbiuPuk
 hizCqvv9GskKeuF3crShLsmZs6ULuQkDANTceFfe4BuyVNGHTp+d2ksOTmVsxkRw
 n4T9t3+qE15vhcYaMUOH6/4d3gaTz7/TvtoyDjmKTlGYOx+x5qjn4kfh5URx8t6k
 za7gFlXl91NUvGnKR8ws2cqBhcAqzU/a2oVe1zwQARflWVA4/nSyf4Ps5J1QpV5w
 +Z/5s8AM58i16wq5JPQ+fv4Cr4v9ZjhWqC+v9vTbdrkpQCG7J8ea8j7dd50Trt13
 GVE97jPe1r5NwSFCtDOjHD3xKgGtmmFBnKm57eC/vfWgzPoT8bFbXNrYAXPkbMet
 YVIqA==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1wd4c15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 06:28:13 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6mZBJ017259;
 Tue, 11 Nov 2025 06:28:10 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxvj3vey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:28:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/iKaUa6viN/S+XNEy7R8k1bv2/cH8VrvwxmfL1Wtb6OkEHbuwoNlq57h7z/jB/d/nQVeShyZE3qKwC1BkKy5uzNRy9uugUWBspq+T161UEcsHIpT5UOFacGdXIaBvcyLVBUlOvbQcbIcnFleZZSKInCXXRNkQrTBLk/J4Ka6DrmUdOnHHEy9EoHuDcXJHs4KVgRschHTzGFW20CqgJebxdkwqlxv5gwqJh5TQOU6tGKludTzDtxs915TnOU18XELQjLEKfDrkKa8VFtylD4NRoAQxGNa1I7o35AVoIzaltn79qLdgPNULqWjpeVBjmTfcjWnvU029EbH5fO83/skA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SazHXtHKL5bDNMMhuh+8lAYq7ACG8fbj5ngurCZdIk=;
 b=W7kkt8lkGvKHYiYamSxiDIxcohgRQlYPsKTYufB9iPmmf0RuODyPxoS5CuTpoEKOYunMZzLX8JMZ0CqdUzayV6YvvXywDc23SaZWKuqHcwMyB9aZ3aex+mwpOKmdUvuqHMb/U5cb/czf0GS2aenC/BXo3BMErBQdhi7fRcQQNGjyj+SvlN0axiKNOFh4u2iCEPtbVXZo+CdiyrUOkWxVYNpSIe9pRuAcl1w3wz0DOe6rcZLdFXeWPxcayNa6H9Omtn6iiwWma2vlv3SLwfKYbs3OOrEZFajwLBDwpeOuEwXSt6shdM99KD3/rQNTSiiJA6bKujh28TaqU4E3o6sM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS7PR19MB6350.namprd19.prod.outlook.com (2603:10b6:8:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:28:07 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:28:07 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 3/5] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v3 3/5] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHcTUKtx8PtXhNwbEqjoPWlVORtq7TiJGaAgAs58SA=
Date: Tue, 11 Nov 2025 11:28:07 +0000
Message-ID: <SJ0PR19MB4606F18538D1414C512FBC7CF5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-4-pravin.bathija@dell.com>
 <3ae04cac-b80b-4cc4-900e-41e7669ada40@huawei.com>
In-Reply-To: <3ae04cac-b80b-4cc4-900e-41e7669ada40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-11T11:15:05.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS7PR19MB6350:EE_
x-ms-office365-filtering-correlation-id: e377f64d-bbc8-48b1-e2c2-08de211562e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-7?B?OGkyQVpQTDNUOXdEMElwU3VCODl6RFJQUEk3Q2FlTTJRKy1MMzhEaFlNdDhD?=
 =?utf-7?B?d0EyMVo1ZVZ1bkcyMnNyTjNXNHRQZTJHUG1Bc2hXbGNNQzRnQXIycEFHZE81?=
 =?utf-7?B?Ky1jRmR1U3lxV0lTNVdBY1VxeFR0TURlRmpacmVCbjBBTFU4bVFScXdmZWl2?=
 =?utf-7?B?dUF2WTNnNGdSYlJLQ2FqVCstOFpaV3BLVHNKa0VMNlBMSmJEWGdqOGtwdDZy?=
 =?utf-7?B?clVQR3NYblZ6L3BPdXFFV3QrLVc2T0RGeWxnUjM4YmthdThpdGM2SzJTU3Br?=
 =?utf-7?B?NFpQWHA5OWQ3TmlqWkV5MGppY3hoajBIaVJXWHVpOGN3cHh5bXhKcnc0L3Rx?=
 =?utf-7?B?MkZHTUMrLUVDKy04aVFBb3Rzc2J0WG1DZmEwdEJubmhNQzlUTHZPNXlVTnh6?=
 =?utf-7?B?dzNxMTFqbzRnLzkvZzlEN0FhWkhxL2Jkc0FITWRmTkRoQ2l6ejNpUnZKS0Zl?=
 =?utf-7?B?ZEVVNkJNVTZ1c296LzdZeWhYTWRyZWtvQjhJT1M5TGxzRkxqU2x2RUQ0SEJX?=
 =?utf-7?B?REtQRThTUWxIU2liZCstKy1wVGlYSkV5azk0aFUrLU1uUk1SN2NmSEVLeDA0?=
 =?utf-7?B?VWh1cDgyR3Z4MzlHNlJOdmFMbFFtMnY3T2VmVistTU5YL1J3dmdSKy04VzFn?=
 =?utf-7?B?Q1h5T2cyUGt5bXNDZ081UW1Xckt6c2tsdWlJbXJsT2QrLW12cFF6ZTAwMGNU?=
 =?utf-7?B?VkRKb0liL3RvQ2JETllvd1BDSlZFMnRVSWc2Z3JiakRIWndxdWJqUlRyT3l6?=
 =?utf-7?B?QmEyeGVDT0gwaHZPREpweFYzaDJRc3R6ZFFxc3Q3cWVVTXFEaXd1ZVhYc0tq?=
 =?utf-7?B?TnB0ZGUwUExObjRCWDFLeTlOKy1XWS95dmhYeFVXZ0E0RmEyOTdLaHdBZVFE?=
 =?utf-7?B?WlAvWWlCaU01R2JpOGF5ZExuRXBnYnpuc3JJdHR4c1F1aUt0VEpjYzF3TDVq?=
 =?utf-7?B?TCstL2lENHlTRWc4QmN5SGRMSjFnd0NsaEpEaC9UY2JtdGRhbGpmZS9FUXNS?=
 =?utf-7?B?ZkdnKy1iUlFuSndEdistd2ZiemxwcDRGS29Ba1FGckRzL0hTTTl3cm1WNzk=?=
 =?utf-7?B?WDErLUJPQUpWKy16Y0R3MXd1RUZ1S25NVnJVamxZc2xvWC8zeEhRc3J1WmIz?=
 =?utf-7?B?Y3lpNWpsZ2UxZkNOU2lGTXl0Z2t4OXEyT1ZMcDMxQnZnc1RSRmhzVEdMUmIv?=
 =?utf-7?B?Z290bnZHaHNZUmVJVDRKVHBEZ1ZSckRjS095LzdjRWpCZmpHYUN5d1NCRm9K?=
 =?utf-7?B?dzhxQXdEZ0FBKy1lMHpUKy1SVHdmYnZrVlY2UHN4ejVUdEh1SGRQOHBNYmUx?=
 =?utf-7?B?bkxMemFkTEwyMnlVckIydWdFWUY0M1Y2WUoxUUJWcExTTkNJbmhyQ0FlWnlr?=
 =?utf-7?B?U2IzQ0k2RXdlVFJRdVRVVEI2TllJc0pIUGFTenRNaWRoTUFGbzBPTnVTU1A3?=
 =?utf-7?B?SklXWFhaSk5vaTZreFB1Q2NhMlZpT2hURkRyemxtR0ZsdG5ZWVA5QURMV2xV?=
 =?utf-7?B?SUltNHdNTGszQ1RPd2F6c2tOelFiZDBzOWFjb2VLSUFuMENyaXpibFZvRjUw?=
 =?utf-7?B?MlRyaEZtMkNYdXRQb3V4OFlhUUNLYi9yYWQ2VURTT0NZcW9ma3pDRlFWTHlr?=
 =?utf-7?B?bmdpTGQzQ1BuejRqOEtDRUNiVTVzb3phbDJhWnd2Ky1kYlU3T2xmNUdVOTBz?=
 =?utf-7?B?b0RzUmZsdWVXdUFkKy1kWXJNZlVIRjZmZVhHRTN5WmxqMC9IdWQyQzlGTWd2?=
 =?utf-7?B?U0t0T1dBd1ZHS3NrZmY3NUY4a29ZVUE3NmppRG9LcUdTSC9IQ2FUalIzckRt?=
 =?utf-7?B?dlVZRFNZNmZodDIvM3dkVEVBcmRjdkZFamkweFhjbVpFRG03RHV1bXljNE9s?=
 =?utf-7?B?NGRCSzFSOHNpWGRmYTB5OVUxMjBtZlN3UlJkaElhck00bkJoZDI4VzRlVUhL?=
 =?utf-7?B?azVvRzhISFNBa0IwdnFxazlOank3T0Z4aThkOUVCKy11TzlTTGh1Y1ZhUERz?=
 =?utf-7?B?QmtWam5KZVhnTTlmU1V2NUMycElUYUUybllyUWhtRnlPTE9YcE1WWFhoUVNs?=
 =?utf-7?B?SCstY3NRVVdHeG1lclJrWDVnMWdSRnMyYk9BQ2RLNw==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?bXRjaUQwTkdRVG5yNnZCZmlFVjhjb1IxRktReXRIVDVEKy10ak8xWmpkekR4?=
 =?utf-7?B?Z0phKy1FZUREalloTHEvc0dsNElhdlppbG94bWNzWXlLWDFWKy1WUEJBWCst?=
 =?utf-7?B?bm4vdXo3eUhlOTJMbkxvVWpNeDJHd05odHdGSlVFMTBkdVVWSnJHdjRCOXdP?=
 =?utf-7?B?SDR6Tk1adEE4U01ocWRyQVM0b0JWc3I4OXhtc0VMb2IxbTVydEl6dWU5TGRv?=
 =?utf-7?B?c2dxRHdhR2t0SUkvTjgrLVFqTGJtSSstNEt2cWVjemhXdW1aME5LMEgvSGV5?=
 =?utf-7?B?bHZkQU1hL1c5N25jZFlQN0Uwb0FWTjUvT01uZVRJaWhOKy05dnJNSXp3M2RD?=
 =?utf-7?B?RVBxa2IvY2dOZG9xdzFFZEpVVCstWFI5WFgzckYyRnV6TzBmRHhCS2JnOVc=?=
 =?utf-7?B?Ky1Ta3piemxVUHRxcVViTFR4ZHZnVTRaWTNiSENtMSstM2U5L1FoVnFyVUxW?=
 =?utf-7?B?UWNuNk94elBRTmZPbFYzZ3o0VlVYZlg3eWdSaDlGSUR5Q2VIcERJd0EyWk5y?=
 =?utf-7?B?UHBtUDY0S2VpKy16R2xLZU0wRlhmcThkQ0tVZFNyWWJKNXBTd0RjTzU4QmNj?=
 =?utf-7?B?WkdrYnNNQ3hVS0ZqcDZjLzgwc1VoQkxrd01BSURoUlF0YWtzUXZjQ0Eza0FF?=
 =?utf-7?B?Z1FDSjZJeFMzdUVvVWRrOWRUNWRCZVB1dTRtYUpYTUN5UkJUeVJPMUQ4VFZ4?=
 =?utf-7?B?QTRBTEgrLUVnNGh6UmdKbmhHQWhaNU4vOWpSalpwYUtudElmN0NHVnAyZENr?=
 =?utf-7?B?L0FqYW9PcGNqanhxRlZPdXZSY0RrM3pIUmxIOTJIb2djYldQQU45Ky1oUkU4?=
 =?utf-7?B?eUw3Ky1mb29lMGZUa0ZDa1JhT0xxT3RHNWc2NGQ0YloxVjFXSkx4cXdKekxY?=
 =?utf-7?B?SnlvUjhGdmNyKy00NjNyNjlvSzk0R3hFSzZ5dkFPOU5wb3dJNGhBOXloTmJD?=
 =?utf-7?B?NzE5RS82TzcyZlhnd05DUklMdXNnSFpONlpZeU4rLURLMll4WndmbVlUdFdx?=
 =?utf-7?B?TEU3QzJidVk3QTBCUTd5YWN2S3FsaVlqdmRzY0hxbXdMWTJ6bjJhdjE4UnFr?=
 =?utf-7?B?ZU1DeXlLRXJ4UEVuM2JIMFRXSGphSldnYjViV3pRWTNYL2dDQXZ2YVpHZDNB?=
 =?utf-7?B?NVZBajZaV3Z1dXg4eFhpT2VNTTE0MDdRQlI0ZlZneExIMWp3ZFB6S2gvaUtr?=
 =?utf-7?B?b3pPa1RyMmhySy83Z1JaNVduN3lMT2JlaDN1Rml2Vml0WWZEYUYxQ1JMME5W?=
 =?utf-7?B?YjMvd2ZqQUV6S0FKUUtoWmEwUkRoeElDdlJXQlVsKy1JU2ZqOHJCaHozYXI=?=
 =?utf-7?B?Ky1sKy00WmxPREU3eU1hb3B2YVZ4VE5HSFN4VWhlcVZlVTQ3NVhwRkFnNFFw?=
 =?utf-7?B?ak1rS1p3ZUVZc0kwQWJNazZ1Nlh1bjJpOGhVMWJqNnJkR051NjkvRGowb0px?=
 =?utf-7?B?aVdWdFJoZ0JMRjVnMnJIU2cyY2hHYllGc3RqazRIdzk4ZEJQTElZU2Q3aVZv?=
 =?utf-7?B?eHJSMGI5dk9NVVZzb28zYSstUjA1bU13UWYwSWx0MVB0NllHcmZiOGdISldD?=
 =?utf-7?B?RU9ZdXZmRTVIZldaQW5OaWdFbSstazlxVVVHVjFjaTVYUHdYbW15SFA3bXlE?=
 =?utf-7?B?bzBnN2hrY2VweE1jcENiOHd5YWdyWjRwZnM2QzNTN3I3VVNRUTloMG11RGdH?=
 =?utf-7?B?M25QMzlFQ1dCdnJxd1dTbXdZOHJnZisteldtZjB4bEtUMHpEQ0RvVEJ5Uk5j?=
 =?utf-7?B?ek1TRlAyaEZ2azZwVm50NWJ1ZzNGNjAvSVVrWURlQ1djbkNHSE45aWl2c0RJ?=
 =?utf-7?B?SystL2cvTlEvOFMwbHY1N2VhRXBCTkFSNFdaZXJTYVBuc3A4MzFBaHpFeVRi?=
 =?utf-7?B?aEZEL1ZGKy1MbWMyZEwwUllZUmUrLURmY2ZONVMzZlJvb0g4N0F1TW9teDlh?=
 =?utf-7?B?WXRaRzFwVUQ0NERSd2NwT1NadktKL0w2dWxZSUhZRCstei9NczB1cEhwRmJW?=
 =?utf-7?B?Z0pZZmw4WTFScnIzb3ZOb1p3a0lSQVZxd25DcTlQRUdybWZjR0tHcmNBcndu?=
 =?utf-7?B?WUtpNnd6MDlTVmM5UjhHUVJoVlZja3oySUNPODhnNistbk5WSjhqRDVDS3Vy?=
 =?utf-7?B?OXkzUDVVZE5lN01maG5BU3VFV1ZUUXRLcndqSHFFdWo2dGxXWXExN2lFN0ts?=
 =?utf-7?B?QW1FdW94SmI3?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e377f64d-bbc8-48b1-e2c2-08de211562e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:28:07.0297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyOMdQcJNuH/Tz32Ldemk9Iu9Ccx8ZidmPUXI47mpIL7qA3PxTXoORNsCiAskGrotxw3x889JOu9DWE9jaCyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110038
X-Authority-Analysis: v=2.4 cv=Xvf3+FF9 c=1 sm=1 tr=0 ts=69131dcd cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=tnQImV11bbmB2idsTYUA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: W64oMEDFY5AkMzMYe94iwNKDLsNxeFmO
X-Proofpoint-ORIG-GUID: W64oMEDFY5AkMzMYe94iwNKDLsNxeFmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfX8lcg+W+pL3/K
 uUT0musJx9HRAB5yzd/ITYJvXeg+6FhdIvivZcLI9fs3/fF5f4mI2wwsaeR0nEMBE62LiXAMGVv
 vd6l/tCbr5h+jUmRRCZwFNULFcnD8KDgus+EkJ3yG3rKdQLHw4RrHdyvOSxRQS3e0pFW9YAw3mw
 xNRCFt+6ty6gc6/Kn4hBPm31MLnrr47ZlhjiRIddr3lK4Yx+P+sHQdwf8DuLT1aYJFLWZCjPJMM
 NPelIPQLl2m5l7gZrUwPE/ysJXNmYXAwns59B36pq9oj56B1x1veXOtHurKNsLdHZnkTxUO6+MU
 F05hKakIpyltomVe6V+JgFeq4Si4ibDleFDqB+zdunt4n3CGXmaPf1Pc+n/0YJPs9l8B7/taT98
 pA++QO6zkGPBJZ0fKu5Zg3P7ormt2Q==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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

Responses inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- Sent: Monday, November 3, 2025 11:49 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 3/5+AF0- vhost+AF8-user: Function defs for=
 add/rem mem
+AD4- regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4- These changes cover the function definition for add/remove memo=
ry
+AD4- +AD4- region calls which are invoked on receiving vhost user message =
from
+AD4- +AD4- vhost user front-end (e.g. Qemu). The vhost-user front end sw s=
ends an
+AD4- +AD4- add memory region message which includes the guest physical add=
ress
+AD4- +AD4- range(GPA), memory size, front-end's virtual address and offset=
 within
+AD4- +AD4- tha file-descriptor mapping. The back-end(dpdk) uses this infor=
mation
+AD4- +AD4- to create a mapping within it's own address space using mmap on=
 the fd
+AD4- +AD4- +- offset.  This added memory region serves as sshared memory t=
o pass
+AD4- +AD4- data back and forth between vhost-user front and back ends. Sim=
ilarly
+AD4- +AD4- in the case of remove memory region, the said memory region is
+AD4- +AD4- unmapped from the back-end(dpdk). In our case, in addition to t=
esting
+AD4- +AD4- with qemu front-end, the testing has also been performed with l=
ibblkio
+AD4- +AD4- front-end and spdk/dpdk back-end. We did I/O using libblkio bas=
ed device
+AD4- driver, to spdk based drives.
+AD4- +AD4- There are also changes for set mem table and new definition for=
 get memory
+AD4- slots.
+AD4- +AD4- The message vhost set memory table essentially is how the vhost=
-user
+AD4- +AD4- front-end (qemu or libblkio) tells vhost-user back-end (dpdk) a=
bout
+AD4- +AD4- all of it's guest memory regions.  This allows the back-end to
+AD4- +AD4- translate guest physical addresses to back-end virtual addresse=
s and
+AD4- +AD4- perform direct I/O to guest memory. Our changes optimize the se=
t
+AD4- +AD4- memory table call to use common support functions. Message get =
memory
+AD4- +AD4- slots is how the vhost-user front-end queries the vhost-user ba=
ck-end about
+AD4- the number of memory slots available to be registered by the back-end=
.
+AD4-
+AD4- Too much useless information in the commit log, this features is a de=
 facto
+AD4- standard, and it supported from early qemu version (6.2 as I know), s=
o I think
+AD4- we could simplfy the commit log.

I have updated the commit log in latest patch v4 to only describe the chang=
es made and remove some of the background information
+AD4-
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  lib/vhost/vhost+AF8-user.c +AHw- 253
+AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-------
+AD4- +AD4-  1 file changed, 221 insertions(+-), 32 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- 4bfb13fb98..168432e7d1 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AEAAQA- -71,6 +-71,9 +AEAAQA-
+AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-FEATURES,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-features, false, t
+AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-OWNER,
+AD4- vhost+AF8-user+AF8-set+AF8-owner,
+AD4- +AD4- false, true) +AFw-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USE=
R+AF8-RESET+AF8-OWNER,
+AD4- +AD4- vhost+AF8-user+AF8-reset+AF8-owner, false, false) +AFw-
+AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-MEM+AF=
8-TABLE,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table, true, true) +AFw-
+AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-GET+AF8-MAX+=
AF8-MEM+AF8-SLOTS,
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots, false, fals=
e) +AFw-
+AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-ADD+AF8-MEM+=
AF8-REG,
+AD4- vhost+AF8-user+AF8-add+AF8-mem+AF8-reg,
+AD4- +AD4- +-true, true) +AFw- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USE=
R+AF8-REM+AF8-MEM+AF8-REG,
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, false, true) +AFw-
+AD4- +AD4-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+A=
F8-BASE,
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-base, true, true) +AFw-
+AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-LOG+AF=
8-FD,
+AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-fd,
+AD4- +AD4- true, true) +AFw-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER=
+AF8-SET+AF8-VRING+AF8-NUM,
+AD4- vhost+AF8-user+AF8-set+AF8-vring+AF8-num, false, true) +AFw- +AEAAQA-=
 -1390,7 +-1393,6 +AEAAQA-
+AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net +ACoAK=
g-pdev,
+AD4- +AD4-     struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4-     struct VhostUserMemory +ACo-memory +AD0- +ACY-ctx-+AD4-msg.=
payload.memory+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- -   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     bool async+AF8-notify +AD0- false+ADs-
+AD4- +AD4- +AEAAQA- -1435,39 +-1437,13 +AEAAQA- vhost+AF8-user+AF8-set+AF8=
-mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-             if (dev-+AD4-features +ACY- (1ULL +ADwAPA- VIRTIO+A=
F8-F+AF8-IOMMU+AF8-PLATFORM))
+AD4- +AD4-                     vhost+AF8-user+AF8-iotlb+AF8-flush+AF8-all(=
dev)+ADs-
+AD4- +AD4-
+AD4- +AD4- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4- -   /+ACo-
+AD4- +AD4- -    +ACo- If VQ 0 has already been allocated, try to allocate =
on the same
+AD4- +AD4- -    +ACo- NUMA node. It can be reallocated later in numa+AF8-r=
ealloc().
+AD4- +AD4- -    +ACo-/
+AD4- +AD4- -   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- -           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF0--+=
AD4-numa+AF8-node+ADs-
+AD4- +AD4- -
+AD4- +AD4- -   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- -   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- -           dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4- +AD4- -           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+AF8-=
socket(NULL,
+AD4- +AD4- -                                   dev-+AD4-max+AF8-guest+AF8-=
pages +ACo-
+AD4- +AD4- -                                   sizeof(struct guest+AF8-pag=
e),
+AD4- +AD4- -                                   RTE+AF8-CACHE+AF8-LINE+AF8-=
SIZE,
+AD4- +AD4- -                                   numa+AF8-node)+ADs-
+AD4- +AD4- -           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- -                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, E=
RR,
+AD4- +AD4- -                           +ACI-failed to allocate memory for =
dev-
+AD4- +AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- -                   goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- -           +AH0-
+AD4- +AD4- -   +AH0-
+AD4- +AD4- -
+AD4- +AD4- -   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhost-me=
m-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +AC=
o- memory-+AD4-nregions, 0,
+AD4- numa+AF8-node)+ADs-
+AD4- +AD4- -   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- -           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +ACI=
-failed to allocate
+AD4- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- -           goto free+AF8-guest+AF8-pages+ADs-
+AD4- +AD4- -   +AH0-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev) +ADw- 0=
)
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4-
+AD4- +AD4-     for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +AEAAQA- -1531,11 +-1507,182 +AEAAQA- vhost+AF8-user+AF8-set+AF=
8-mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-     return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4-
+AD4- +AD4-  free+AF8-mem+AF8-table:
+AD4- +AD4- -   free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-   free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-     rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-     dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +-   rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-   dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-close+AF8-msg+AF8-fds:
+AD4- +AD4- +-   close+AF8-msg+AF8-fds(ctx)+ADs-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-
+AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(struct virti=
o+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   uint32+AF8-t max+AF8-mem+AF8-slots +AD0- VHOST+AF8-MEMORY+=
AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8-t)max+AF8-mem+A=
F8-slots+ADs-
+AD4- +AD4- +-   ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-msg.payload.u64)+A=
Ds-
+AD4- +AD4- +-   ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-REPLY+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4-
+AD4- Please put long line in front.

Done. Please review v4.

+AD4-
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure new region will fit +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4APQ-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +-                   +ACI-too many memory regions already (+ACU=
-u)+ACI-,
+AD4- +AD4- +-                   dev-+AD4-mem-+AD4-nregions)+ADs-
+AD4-
+AD4- Currently support 100 char per line. So maybe we could put the log on=
eline.
+AD4- the same for below log.

Done. Please review v4.

+AD4-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- make sure supplied memory fd present +ACo-/
+AD4- +AD4- +-   if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +-                   +ACI-fd count makes no sense (+ACU-u)+ACI-=
,
+AD4- +AD4- +-                   ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- Make sure no overlap in guest virtual address space=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8=
-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-)
+AD4- +AHs-
+AD4- +AD4- +-                   struct rte+AF8-vhost+AF8-mem+AF8-region +A=
Co-current+AF8-region +AD0-
+AD4- +AD4- +-+ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (current+AF8-region-+AD4-mmap+AF8-size =
+AD0APQ- 0)
+AD4- +AD4- +-                           continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   uint64+AF8-t current+AF8-region+AF8-guest+=
AF8-start +AD0- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-                   uint64+AF8-t current+AF8-region+AF8-guest+=
AF8-end +AD0-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                           +-
+AD4- current+AF8-region-+AD4-mmap+AF8-size - 1+ADs-
+AD4- +AD4- +-                   uint64+AF8-t proposed+AF8-region+AF8-guest=
+AF8-start +AD0- region-
+AD4- +AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +-                   uint64+AF8-t proposed+AF8-region+AF8-guest=
+AF8-end +AD0-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                           +-=
 region-
+AD4- +AD4-memory+AF8-size - 1+ADs-
+AD4- +AD4- +-                   bool overlap +AD0- false+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   bool curent+AF8-region+AF8-guest+AF8-start=
+AF8-overlap +AD0-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-s=
tart +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- current+AF8-region+AF8-gu=
est+AF8-start +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4-
+AD4- the +ACYAJg- should put tail of line according DPDK coding style.
+AD4-
+AD4- +AD4- +-                   bool curent+AF8-region+AF8-guest+AF8-end+A=
F8-overlap +AD0-
+AD4- +AD4- +-                           current+AF8-region+AF8-guest+AF8-e=
nd +AD4APQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- current+AF8-region+AF8-gu=
est+AF8-end +ADwAPQ-
+AD4- proposed+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-sta=
rt+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
start +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- proposed+AF8-region+AF8-g=
uest+AF8-start +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-                   bool proposed+AF8-region+AF8-guest+AF8-end=
+AF8-overlap +AD0-
+AD4- +AD4- +-                           proposed+AF8-region+AF8-guest+AF8-=
end +AD4APQ-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                           +ACYAJg- proposed+AF8-region+AF8-g=
uest+AF8-end +ADwAPQ-
+AD4- current+AF8-region+AF8-guest+AF8-end+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   overlap +AD0- curent+AF8-region+AF8-guest+=
AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- curent+AF8-region+AF8-gue=
st+AF8-end+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-start+AF8-overlap
+AD4- +AD4- +-                           +AHwAfA- proposed+AF8-region+AF8-g=
uest+AF8-end+AF8-overlap+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (overlap) +AHs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACI-requested memory regi=
on overlaps
+AD4- with another region+ACI-)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tRequested region =
address:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   region-+AD4-userspace+AF8-=
addr)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tRequested region =
size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                   region-+AD4-memory+AF8-siz=
e)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tOverlapping regio=
n address:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   current+AF8-region-+AD4-gu=
est+AF8-user+AF8-addr)+ADs-
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +AD4- +-                                   +ACIAXA-tOverlapping regio=
n size:0x+ACUAIg-
+AD4- PRIx64,
+AD4- +AD4- +-                                   current+AF8-region-+AD4-mm=
ap+AF8-size)+ADs-
+AD4- +AD4- +-                           goto close+AF8-msg+AF8-fds+ADs-
+AD4-
+AD4- how about add sub function to wrap the check?

I think it would be too specialized of a subfunction without any other re-u=
se. I have skipped for now.
+AD4-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- convert first region add to normal memory table set=
 +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev)=
 +ADw- 0)
+AD4- +AD4- +-                   goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4-
+AD4- I think we could put this judgement at the beginning of function, so =
that we
+AD4- could drop so many judgement for 'if (dev-+AD4-mem +AD0APQ- NULL)'

Done. Please review v4.
+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo- find a new region and set it like memory table set =
does +ACo-/
+AD4- +AD4- +-   struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg +AD0- NUL=
L+ADs-
+AD4- +AD4- +-   uint64+AF8-t mmap+AF8-offset+ADs-
+AD4-
+AD4- Suggest place them at the beginning of function.

I looked at the possibility of doing this but the code flow doesn't permit =
it. Currently We make sure there are no memory region overlaps and only the=
n proceed with this portion. We can't execute this portion of code until we=
 have checked for overlaps.
+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+=
AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-           if (dev-+AD4-mem-+AD4-regions+AFs-i+AF0-.guest+AF8=
-user+AF8-addr +AD0APQ- 0) +AHs-
+AD4- +AD4- +-                   reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+A=
Fs-i+AF0AOw-
+AD4- +AD4- +-                   break+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-   if (reg +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-no free memory
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   reg-+AD4-guest+AF8-phys+AF8-addr +AD0- region-+AD4-guest+A=
F8-phys+AF8-addr+ADs-
+AD4- +AD4- +-   reg-+AD4-guest+AF8-user+AF8-addr +AD0- region-+AD4-userspa=
ce+AF8-addr+ADs-
+AD4- +AD4- +-   reg-+AD4-size            +AD0- region-+AD4-memory+AF8-size=
+ADs-
+AD4- +AD4- +-   reg-+AD4-fd              +AD0- ctx-+AD4-fds+AFs-0+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-   mmap+AF8-offset +AD0- region-+AD4-mmap+AF8-offset+ADs-
+AD4-
+AD4- no need to define mmap+AF8-offset which only used once.

Done. Please review v4.

+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-mmap+AF8-region(dev, reg, mmap+AF8-=
offset) +ADw- 0) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-failed to mmap
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +-           goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-mem-+AD4-nregions+-+-+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+A=
F8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +-           async+AF8-dma+AF8-map(dev, true)+ADs-
+AD4-
+AD4- it will map all region, we should map only this region.

Done. Please review v4. I have defined a support function async+AF8-dma+AF8=
-map+AF8-region that maps only that particular region.

+AD4-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (vhost+AF8-user+AF8-postcopy+AF8-register(dev, main+AF8=
-fd, ctx) +ADw- 0)
+AD4- +AD4- +-           goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF8-vring+ADs- i+-=
+-) +AHs-
+AD4- +AD4- +-           struct vhost+AF8-virtqueue +ACo-vq +AD0- dev-+AD4-=
virtqueue+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-           if (+ACE-vq)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-           if (vq-+AD4-desc +AHwAfA- vq-+AD4-avail +AHwAfA- v=
q-+AD4-used) +AHs-
+AD4- +AD4- +-                   /+ACo- vhost+AF8-user+AF8-lock+AF8-all+AF8=
-queue+AF8-pairs locked all qps +ACo-/
+AD4- +AD4- +-                   VHOST+AF8-USER+AF8-ASSERT+AF8-LOCK(dev, vq=
,
+AD4- VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   /+ACo-
+AD4- +AD4- +-                    +ACo- If the memory table got updated, th=
e ring addresses
+AD4- +AD4- +-                    +ACo- need to be translated again as virt=
ual addresses have
+AD4- +AD4- +-                    +ACo- changed.
+AD4- +AD4- +-                    +ACo-/
+AD4- +AD4- +-                   vring+AF8-invalidate(dev, vq)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   translate+AF8-ring+AF8-addresses(+ACY-dev,=
 +ACY-vq)+ADs-
+AD4- +AD4- +-                   +ACo-pdev +AD0- dev+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dump+AF8-guest+AF8-pages(dev)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-free+AF8-mem+AF8-table:
+AD4- +AD4- +-   free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +-   rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +-   dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4-     dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4-  close+AF8-msg+AF8-fds:
+AD4- +AD4- +AEAAQA- -1543,6 +-1690,48 +AEAAQA- vhost+AF8-user+AF8-set+AF8-=
mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-     return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   struct vhu+AF8-msg+AF8-context +ACo-ctx +A=
F8AXw-rte+AF8-unused,
+AD4- +AD4- +-                   int main+AF8-fd +AF8AXw-rte+AF8-unused)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   if ((dev-+AD4-mem) +ACYAJg- (dev-+AD4-flags +ACY- VIRTIO+A=
F8-DEV+AF8-VDPA+AF8-CONFIGURED)) +AHs-
+AD4- +AD4- +-           struct rte+AF8-vdpa+AF8-device +ACo-vdpa+AF8-dev +=
AD0- dev-+AD4-vdpa+AF8-dev+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-           if (vdpa+AF8-dev +ACYAJg- vdpa+AF8-dev-+AD4-ops-+A=
D4-dev+AF8-close)
+AD4- +AD4- +-                   vdpa+AF8-dev-+AD4-ops-+AD4-dev+AF8-close(d=
ev-+AD4-vid)+ADs-
+AD4- +AD4- +-           dev-+AD4-flags +ACYAPQ- +AH4-VIRTIO+AF8-DEV+AF8-VD=
PA+AF8-CONFIGURED+ADs-
+AD4-
+AD4- The DPDK's vdpa devices will not report the new feature, so this will=
 be dead
+AD4- code I think.

Removed this portion of code. Please review v4.

+AD4-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+AD4-=
nregions +AD4- 0) +AHs-
+AD4- +AD4- +-           for (uint32+AF8-t i +AD0- 0+ADs- i +ADw- VHOST+AF8=
-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-)
+AD4- +AHs-
+AD4-
+AD4- suggest i defined in beginning of func.

Done. Please review v4.

+AD4-
+AD4- +AD4- +-                   struct rte+AF8-vhost+AF8-mem+AF8-region +A=
Co-current+AF8-region +AD0-
+AD4- +AD4- +-+ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                   if (current+AF8-region-+AD4-guest+AF8-user=
+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                           continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                   /+ACo-
+AD4- +AD4- +-                    +ACo- According to the vhost-user specifi=
cation:
+AD4- +AD4- +-                    +ACo- The memory region to be removed is =
identified by
+AD4- its guest address,
+AD4- +AD4- +-                    +ACo- user address and size. The mmap off=
set is ignored.
+AD4- +AD4- +-                    +ACo-/
+AD4- +AD4- +-                   if (region-+AD4-userspace+AF8-addr +AD0APQ=
- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr
+AD4- +AD4- +-                           +ACYAJg- region-+AD4-guest+AF8-phy=
s+AF8-addr +AD0APQ-
+AD4- current+AF8-region-+AD4-guest+AF8-phys+AF8-addr
+AD4- +AD4- +-                           +ACYAJg- region-+AD4-memory+AF8-si=
ze +AD0APQ- current+AF8-region-
+AD4- +AD4-size) +AHs-
+AD4- +AD4- +-                           free+AF8-mem+AF8-region(current+AF=
8-region)+ADs-
+AD4-
+AD4- I checked the 4/5 commit, and we should do async+AF8-dma unmap this r=
egion
+AD4- here.

I have defined a new support function async+AF8-dma+AF8-map+AF8-region whic=
h maps/unmaps. Please review v4.

+AD4-
+AD4- Beside, should we invalidate vring here?

I have a defined a new support function dev+AF8-invalidate+AF8-vrings. Plea=
se review v4.

+AD4-
+AD4- +AD4- +-                           dev-+AD4-mem-+AD4-nregions--+ADs-
+AD4- +AD4- +-                           return RTE+AF8-VHOST+AF8-MSG+AF8-R=
ESULT+AF8-OK+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +ACI-failed=
 to find region+ACI-)+ADs-
+AD4- +AD4- +-   return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-  static bool
+AD4- +AD4-  vq+AF8-is+AF8-ready(struct virtio+AF8-net +ACo-dev, struct vho=
st+AF8-virtqueue +ACo-vq)  +AHs-

