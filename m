Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4847CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 02:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9102E402A2;
	Fri, 22 Aug 2025 04:36:11 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9F926402B3
 for <dev@dpdk.org>; Fri, 22 Aug 2025 04:36:09 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LM2Ww9013190;
 Thu, 21 Aug 2025 22:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=F
 EZQwkwwQYxpBVgq6kXqafhlP/CzIda2aiZIQKXwXKs=; b=rGV650GHSHhMp8zsd
 9hOtLQnJ6f4BLKkObOQezYIAOtv7oIaISTi3CEmMCcXG7Qkcb3X6Z91F7FW7ti2X
 S2VcXYovahsdU2fT9Ybsr0bp0tWbTIgwsd9VZX/sQDjpxCxQzGGmogOuyKKwG99s
 dXHXB2QSolv7fBBBysXWhXjwuXIQaNKdAsH7HvHhYyLch7bj4xzalUjY/jFmF3e9
 +uXx7XoiA1yukWupzr/F5uUc9qCjH6haJDIG9Ic/cQLo8SRcx4O1LFKORzeH76uL
 zO+vXJxKeP6prmQiukHaRbRamaEHrf96LZ2xTZorf0sEv5VYf8DmB2HCMGzinKoN
 SXcjg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48n0v9y1n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 22:36:08 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M0rP7Z031518;
 Thu, 21 Aug 2025 22:36:08 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48p68qy735-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 22:36:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5abZvsR9jiNKbbQSyCUPW35GKw8o3uQQLBcQnaxvY8nddXJ/JojhnHRlyL69vqdGwwR7KAjHB8EGkJA9CnrgVy5lldHucfJUBowxNK3O9DOI+4FiFUKxVPwbd9gkLLYr8GaefVzFP+dprGeIIElrGrfE1h7GFCTQOsI9IgOgYv0w8QANOfuGYpkPeA5UA0l5RixE2ALEAqdl+pe3oijCxMU/V+0MN/IZiCZq19rglgCrcAIxwIRzaaT3MS34CxOoAvQpQutD1Ia0Cn8GzOI+FQHirg60M3mzrGnzoiKjUVG/B1iyFouLmx8NbuMEd91YdmOyV+/mjUrdgQ1zEeKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEZQwkwwQYxpBVgq6kXqafhlP/CzIda2aiZIQKXwXKs=;
 b=v8Uj2AU6ifYseJWjlr0I2wOQNLSc6GDfk7ADs3yhSVp1vb164gyPlmWVRv/JBg/6hdhU2gfaMmn2bp1K1iWhEZtdC4iPesc7rPAUJKIAZPeQJv4gsN5BcNo4LHSTmjn+Np8luePMOXEQOc8ZC2cfMegPnMa4uOCk2zwC4qmE6szIyDIXZaHCaQuezW3w6WIyDdSyKy7c0knzYmenuSlYsg/04OwavhfxlLKn2bXjIHgHbovZO8h6XV1OT1VRgEPH+5334u5GxTYcFraESsPD3TRPmGI062zu2xG+B8fOo5EZaqWlAqkQG+2M9Jk5+fmdQsOEgSOvkpkUCuzQMtpytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by LV2PR19MB5719.namprd19.prod.outlook.com (2603:10b6:408:17c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 02:36:05 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:36:04 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQfjIA=
Date: Fri, 22 Aug 2025 02:36:04 +0000
Message-ID: <SJ0PR19MB460604659C14D17C9A6BEA12F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
In-Reply-To: <15537925.JCcGWNJJiE@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-22T02:33:59.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|LV2PR19MB5719:EE_
x-ms-office365-filtering-correlation-id: 18b0c5c9-dd36-4d4e-81ae-08dde124a465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?R0kvWDIyenVEbngxRmpkcG53TGZ6VS95aEZJbkFvWExYcFZ0UHlMM0VwTTVF?=
 =?utf-7?B?TkZPcGhPZnhJUUptV2hrTWU5S3ZGQTVTSVN1Q0dqSjBYd0ZZU1RFVzVqREtz?=
 =?utf-7?B?Y3JMSTBDNXArLU45bE95aFY2VHFqbXRGYlBraURZWXN4TmozV1RSN1lPaE1D?=
 =?utf-7?B?dkRvbjJTZVJZaDFtTENSTEdhZnpUN3lHR3BPc0NoY29YWEV3RCstWGJ3NDEz?=
 =?utf-7?B?Y3Z0a1M0a3NvT1M2T1QvbVArLXBnQ3N5TUhyZTE1MkQ3TTlMZXk1MkhKKy1O?=
 =?utf-7?B?UmNjTFI5YlMxMmtkclBCTkNVMUt1Tk5SWWMvd05TYUZMUlNJZVpvM1VhVyst?=
 =?utf-7?B?cjVhcy93eHlJM3NVUnVuTXQrLWdGRTV1SmdteXd2YnpMTmlTUkxyQWJhSCst?=
 =?utf-7?B?STl4b3lwcWZnTWd0aTRFa2lVQzMyZkVjQVg4VTR0Slh4S0h5Y3FNVTRpc25m?=
 =?utf-7?B?cXdndngwaHNUNXV0VWNSb25PTkt2VlJyVmxrN2RFdGpGVlBlVGlJVHBncjRW?=
 =?utf-7?B?Q0VsZlhMNHhUNzFOMEhtendtaUtaQ3JJYUpwWXlsVkQ4ZU50NkRMUHlYcnha?=
 =?utf-7?B?UzJ1SDErLVJvcEMwVGFBY3dTSDl6R2tIKy1ZZ0RCcnNWemovTjBUZDhOaUMx?=
 =?utf-7?B?Zm9QZDY5V1lNSlQ4WU1nMFEvb1lMMmU5MUZGdjZDaDdaM2tYcWFqTU1BUC9x?=
 =?utf-7?B?Ky1STTArLWlreVdLeSstRUdjVjEyRGYvV2pQYkYyWmMyWjhObkpiRkV0SEVT?=
 =?utf-7?B?SDJFL1ZYZElrcjNXM3pHR3Iyb0ZCMmg5VGhLWnRnSVAyMnBxVFVmNFdoY012?=
 =?utf-7?B?bHNoSFl3QVVmemRJNklNTVplVlVCaGlYYncwQU9rN3piSS9OY2k5bE9EZ0pn?=
 =?utf-7?B?S3BkOUJrMkE4RW80b3ozTXZCVGF3SEJGcjRMQ1NuWW9OKy1TNlA3akpSRzhW?=
 =?utf-7?B?RFZSWWFjclA5STl2eVRPcng5RG9nVUxwcXh5bEt4N0tWMEkwMndrcU5vWTZs?=
 =?utf-7?B?SlNKUkVYSFY0bFB4TlZ5ODRJRW5FdlRua2VzUjZmYTNzTEhWUkZ6b29zUk9U?=
 =?utf-7?B?ZkpoalF0Zkh4ejFaWmROWDh0YkJkbVBPb05WRGhOUjNNVENQdGY0Y1NkM3pE?=
 =?utf-7?B?bHh2TlNVZzBTa3pkQ2xCVkxYWVBwWlgvSnhhL1E4Ly9nKy01dkRGajRUVTdF?=
 =?utf-7?B?UkdCZWM3RDFYSHJGU05HaEl0R0dIOVZiR0pXTVBHaTl4Z0lpaUdlMmZjRU5y?=
 =?utf-7?B?bTdwU2VRWU1hcXdkek5GZnpjUkhUWnB6a1BHV012Z24zck5rYmR6V3VNQmhw?=
 =?utf-7?B?OGo1eWN5Y0dmWmYwN28vckthd0l0ZE8xRlhGa2U1Z3FQNzZQOVJCQnNsbVFT?=
 =?utf-7?B?UktpeFcwOGNlQk91QUxZVnlRMThhN2N6V1BzUzRuVkRhT1dQZ0hlMktOeGNs?=
 =?utf-7?B?QSstMTZ6NUROYjRCQzQrLXBxbGxnKy1UbHdGWm14TVFxdDFnT3VMMDFrTTdS?=
 =?utf-7?B?T0FEcTJCSlNtWFVDWmJheW4rLTB6VG4yZXBrRnZ5WkZWV3BBUnBKdkVDdkd1?=
 =?utf-7?B?U0tiSU96bllsTzE1RmovMUVyWE5NdHZ2cVlQamVjNjV3QnB6OE9ZR2FhUTY4?=
 =?utf-7?B?RVZYQ3MrLUpwZ3FXSXZLNFk5L3JhNjhqT2xYUW5LQnRIQkRMZlN1QjNEVWli?=
 =?utf-7?B?V3lMWEVCbGNPSVNicVFXZUJiVnBtZXJ5SjY3SnRoQ1doL3NFNistN0VqN2pY?=
 =?utf-7?B?c2xQKy1RWUp0UkRrcGhHOFNEUFZnZC9XelhQWEFPbUgvWVNENWdtUXFrS0lw?=
 =?utf-7?B?dkE1NnBmT1R1STJtNkYva2RpVFMzR3VIZWtPMnEzRXZkS25Vd2FXeTFQU3Q3?=
 =?utf-7?B?d1NCNkg0dXNCUTFwL3NUNUw0VUptcGxUZzBtcHRUcXlIUHRNc2RHMlFPeWQ0?=
 =?utf-7?B?cEVhZUhIRistOUZtVkN3a1JDUEx2ZHovZ0xDU2l6L3BYWWZHTll6WDdmKy02?=
 =?utf-7?B?NnpQVWY2SzBrWWxIWVRjdWtHUXdnL0txKy0yUystSnB1azVZbGYwUHhEemRa?=
 =?utf-7?B?NUJWQ2V5em1IOCtBRDAt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?NEt6QUlLd1FQS283UHozamlkSnFVSjRiNVhqd2JSLzNiaUdIcTNCTzJMRE9N?=
 =?utf-7?B?Zy9iL1I4aDYyWTJ4U1JUdEMwYXI3WTlUcHg5d0NvN0pkYXlMY01EQ3JDRDFI?=
 =?utf-7?B?MXRxVndWZDFKaForLUR2aXBFSXdodXZ4bllzS0lMZTdCSlJLNmw3UkcyKy1P?=
 =?utf-7?B?Q0EzVUtsZGd4OHg0SkpwMEhkeG1PUHZMUGlmMFQ1TmRtV2hRRDRVdU5kZksv?=
 =?utf-7?B?dklqd05ZTDdqd0VtS2d5emdtVnhRdTEzMnIxSktwcTBuaHpieWNGRTVmUzRD?=
 =?utf-7?B?YTZtWTRrSmdVNHV5ZjhjR1RCeUM2TmNNUHJGWS9sTjU0dkRldHV4WkJ1d3Fh?=
 =?utf-7?B?dystKy1LdHdNaUpYdDg5NTEvUGY3Ni9pT0Zrd1BRRXJOS053WFQwQlNpczh0?=
 =?utf-7?B?NHdVV2lKaEJqb2xBL0d4a09JRzNidmtFeTF3V1VzU0lGUVlOMVJEa2lWcExX?=
 =?utf-7?B?enFweG1VaU1iRnhrZWdXMlp0TXFYV2xnMnRqR1RoVzhPSjRjMHF6eFI5Sml2?=
 =?utf-7?B?OFYwQ2h1NGNEdDFWRldaZlhxdkNTZGdNTVdMYjRMMzZtczJ5azhWS3d4bk9Q?=
 =?utf-7?B?T0Yya3NJTlltcDJHWVFPTWZjYUxkWXR4ZW9YeTNIYXJUQTNuM0lSWUtTVGgy?=
 =?utf-7?B?ZGlIVjRTMm5qUzNLZGpIbUZMWU1ESlRRdS9NY2hPQk9sZDRicXgrLWlJWWU3?=
 =?utf-7?B?TWFCUmNLMm5uSTJQNkFvR3JEVEpGekdzaksvd0Q1NTNaZjEwM3R5T2x2ZHN6?=
 =?utf-7?B?Vlg3MEVZMVIyRUNxUldyNVNUS0Q2cjM5M0NsOTI3cDlYUFFnRTl5NFBnSWxm?=
 =?utf-7?B?YjI5R1lrYlQ5VHVyQmtqa1pyR200bnZYN1IwckxNTWJhbmpyODd6OVFWUVZM?=
 =?utf-7?B?Y3NPOU9LVjd3MGMvVHVuVERzV01ybHFEekRlUDM1cTY2MnprR2JjSTF0czRP?=
 =?utf-7?B?S2lidWQ0V3gyMHFLdVpKODZtUlI3bmN4ZHZEWHNLTjYzL01iejJwM3BuNjZY?=
 =?utf-7?B?TzRjaUgydFplY3NwSFV3Z3RMZ2s2emlIcVp1b2dKUDg3c1J3SlJvVHF5SkNv?=
 =?utf-7?B?S0lScGZ1ckx0cVg2bUlsaXo4cmdNZ0RDVmFxMTR1aGZLN1dmMmNEQTR4YnhB?=
 =?utf-7?B?cUpFc2d1Zk95UVN5YTZqSWdGKy04YTlkdTF0d1hBU3lsVGFPTDdjZVp3U2J4?=
 =?utf-7?B?RUpLMDg5TW9mUE1xVDI1QWc3VnRHdGNwTDYzQnRlOFJ6RmxGQ0pOZzR0U0pL?=
 =?utf-7?B?S3lSWjcrLUh1bDdCVEVkVldMOGhNNVQ2ZUl3cW9NTEFSRXYxZlR3L1ViazVC?=
 =?utf-7?B?clVQWmVNR0t2aVB1VGNtOHkwU0dnczV0d2lQRjlvUUZET09hNmlhUjU0WDNr?=
 =?utf-7?B?dVA3dzkydHVnL05UVGNhRzdvYngxZWlwLzVYU093RFNHNW51dlFrZHdOajFh?=
 =?utf-7?B?Zkg5NllpUjcvcE80dWlVSEt2NU0zZW9MUFlDWkl4c2grLUJxelVlRDlsZER1?=
 =?utf-7?B?RW53V25PWmhVcHR2alBzTFMrLUh2dWtvTVpnQzVKazc5Nm5kbGc0VkFXSEJD?=
 =?utf-7?B?aFJONWhXR05MQldzeU1GWUxSVTRVZUM2Znc0SFNZb01jMDdEODFzY1RUZ1Fq?=
 =?utf-7?B?Ynk5cktqdnhrcHpGcDlteE05T3NOTnJDanJsdFM2ZmFPcHNpV3VVZFNqN2dF?=
 =?utf-7?B?RDQrLW5lTEhIbzNVUkRLWlkvNWtKSDd6dlU1NURGYXY4MGo2Y0drYnQyU3dT?=
 =?utf-7?B?UER6WFFjQU45YTBGWG43US9DUystYnlmOUtpSCstTistekRscEVyMlpLdEE0?=
 =?utf-7?B?eEprTUhxeTlVL3U1U1I5SUVsWnZrbE03eHZtYWlYTFJrb1hUbmQrLU9WWDU5?=
 =?utf-7?B?T1dpSm5TM1BQNkVXeXFOa2ZCd2l5cWRnc2cvN0QzUlF6V3NWOE93MHV1ODRM?=
 =?utf-7?B?ZlJQd1NXdzM2NEZuY3BFSEEybHB6bjZ1U3BFcE5QQUJPQThkdkNtbUFoV3pP?=
 =?utf-7?B?em1pblpwbGJ2Y2FNQXFaMjBQM0g2SUNybGFzKy1uS0NzZGlIM1krLXkzRTFU?=
 =?utf-7?B?eEFSZTZ4bXVidFhkaWZJWVY3Um8wSzQzelFqNlJHYTE2TVNCVmI3RU9HZHR2?=
 =?utf-7?B?ekhha3ZsUFQxL3hsYTI0OHVkOGNOWFM2U2g4OENOdWc1ZzFTNkZraGE=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b0c5c9-dd36-4d4e-81ae-08dde124a465
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:36:04.9441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhELWwJ3Zm6L0EKz4eT1wHf+KgyILqR1OA0cfEg/suAep8lsYti0IKFFgL9zI+Us/4Iy4z2KnU+LTLewvEMd9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=936 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508220023
X-Proofpoint-ORIG-GUID: f3_zkbfuHxGktsEE_wunMtMt9cSN51Y9
X-Proofpoint-GUID: f3_zkbfuHxGktsEE_wunMtMt9cSN51Y9
X-Authority-Analysis: v=2.4 cv=JIhic8Kb c=1 sm=1 tr=0 ts=68a7d798 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=bt5KbKNvAAAA:8
 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8 a=6-dRa9qSAAAA:8 a=LfxEVeEBAAAA:8
 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8 a=XlRjxQ70AAAA:8 a=BXszkKfDAAAA:8
 a=XFJw1KJJAAAA:8 a=RXc22uv1prqeS9pRFPIA:9 a=avxi3fN6y70A:10
 a=hlJyneSgMmFPbskH-t2w:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=NZk92sZ4hQKp_Sw8PGvT:22 a=7k9nRlTqVbDGZ3p5_T00:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=iapMWHAMLVzCBf0btcAb:22 a=1uMOUU2w0DxzEe95gQqD:22 a=duu7wrcty9prphiCz_fF:22
 a=DKZDSSD9H29Cdu8kcpdD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDAyMiBTYWx0ZWRfX840U6hr0x7qD
 nyKmm3T2SYynXw0l2OAIg5jODEf72rEujD3ykA6Gaoq5OZ8fQiPoB5sBuzZzpnqu40ymJx5cdlj
 xIx71q/bL5Pl5X8CXrxvSIeD9R2jogHYRLv2t8dPt8kpmgJJPW2BagWDS/8rXNQ/2ZMNiSHgd46
 VK0Mb36xDcXXQf7JZitInxhy5mOAiWcTWpuWNKxaKW50gb58kgpJZKY25GR+YvJlh7s5lBUh+zr
 S+GzDnlvFxw8vxx0S1/IhIkbiX4gfmsX+qbE/is6tK5OI+UsdOhNkRllaHJ4SsSyL+PQUPzJbU5
 0tNSb9S2cPEJcQ6uCrl10dkP1aqw8VQE99BfsfMWpVQfn2IDSIWeAM4CxM9BH032iKblXl8cuUh
 UP4VjE2iDJfyZeRDtmEhY8ePPYYI1AStUlxjYtXYAdrIDANC4DzzzcAp8NNMmKKR/St+gcgR
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 mlxlogscore=927 suspectscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508220022
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

Comments inline:


Internal Use - Confidential
-----Original Message-----
From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
Sent: Tuesday, August 19, 2025 4:36 AM
To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Maxime Co=
quelin +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+=
AEA-nvidia.com+AD4AOw- David Marchand +ADw-david.marchand+AEA-redhat.com+AD=
4AOw- Bruce Richardson +ADw-bruce.richardson+AEA-intel.com+AD4-
Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slots


+AFs-EXTERNAL EMAIL+AF0-

Comments inline

12/08/2025 04:33, Pravin M Bathija:
+AD4- - add protocol feature support add and removal of memory regions/slot=
s
+AD4- dynamically.
+AD4- - this patch set has been tested with multiple instances of fio

What is +ACI-fio+ACI-?
Fio is an open-source tool to test various I/O work-loads on disks and file=
 systems.
https://github.com/axboe/fio

+AD4- connected via libblkio to spdk target backed unix domain socket.
+AD4- - please apply this this patch-set to dpdk mainline as well as versio=
n
+AD4- 25.03.0.

As mentionned previously, we don't plan to maintain 25.03.
I understand you need it for SPDK,
but I think SPDK should rely only on LTS branches.
Is there a specific reason why 25.03 is required in SPDK?


+AD4- v2:
+AD4- - fixed warnings with e-mail address
+AD4- - fixed warnings with typos
+AD4- - there is a warning about +AF8AXw-rte+AF8-packed+AF8-begin not being=
 in pair with
+AD4- +AF8AXw-rte+AF8-packed+AF8-end which on reading the code turns out to=
 be false. It
+AD4- is an anomaly of how git-format generates the patch and how
+AD4- check-patch checks it.

When sending a v2, please use -v2 so it is reflected in the email subject.

+AD4- Pravin M Bathija (3):
+AD4-   mailmap: add user
+AD4-   vhost+AF8-user: configure memory slots
+AD4-   vhost+AF8-user: support for memory regions
+AD4-
+AD4-  .mailmap               +AHw-   1 +-
+AD4-  lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4-  lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-------
+AD4-  lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4-  4 files changed, 296 insertions(+-), 44 deletions(-)



