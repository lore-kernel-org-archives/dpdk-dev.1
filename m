Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BFFD29FFA
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 08:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC5124060C;
	Thu, 15 Jan 2026 09:05:00 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0BA414003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 09:04:58 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60ELeqIl005067;
 Thu, 15 Jan 2026 03:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 l7lqPAI6QRLbdTPimi6cJqt0zR/mNsKlH3P8jac+Gk=; b=TAyshk37J1iMcMui7
 yQQ4hax4NN+WaFauy6k3rrGoKeWEZs7Gi8cQmJ/7HYsekLBlsFPN8yTvOp3KlQ1A
 cqmneD5YYanrrdUyR8EkULElbwWjr+VjaIyTTNZzFnu4WyNaDVV30x/3DVmOzLQS
 nVUbtIFQSk0J3MY1siM11mYDvBEInZGRvgLosZ9rFakIcfb8gVxB4tGQXK2jsP4X
 ZKby+3q9aOEiNu+Uq5aQCJPKqwXfJFkCvLVrLmkMnrT/xDP9SruUTr22tFdSjJiA
 CztuEMx5k7LAHjzMydq05y95RcRC3r1TOe3jLQ+5oi0AE36ETY2lALamjOcr7Ivt
 ZwxoQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4bkjsv4wc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 03:04:58 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F81Xho017374;
 Thu, 15 Jan 2026 03:04:57 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4bp2vra97v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 03:04:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxxcc4fL9+FRMf1xzzft0a0mxynsYEzpiVgYddHVQPBPujFiYSAzIWtBo409BibccTCx0MZcQQ61WQsb2bca15Od9InYa5tQYB1PHdsa9Yvg0jXgZ8cXn3l3k54idtv0+0g9vsd1Y0+aVyLIBTcs08VKxYuuTnIS6MzxHm2ltHrSUsmDQitX9LNfutAu1d+WmY02qqYCubkuUYqPWcq/22cONpIYsHgGlXLdKkLXAtBS/rCuhgyqkK0q+9FCC6AUGEcg3ZQQVkcNr9UOjeBBtXw10wHP6lCcVvdWq20LWwLJrSuG/R80l/N9TlzaM58pPEmj1zRFlWaho1qpF699lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll7lqPAI6QRLbdTPimi6cJqt0zR/mNsKlH3P8jac+Gk=;
 b=eyzXtsJrhNuITMMhpsqTkmmf4N2nmiNJUMLwERrUHNAKegxDRcSizv08YhVSS0RNoXzC4iogEpgd/wKPRupDfbvVlo4+HYV+s0EKqKjAbUUY1ynyZW5ZwqiY4SjPW+NgcXCGcs7OrJi4hc2k9b2rbOuHArjR8THv9pPWF61BszssBmjtIo8sUeJZQ4m5FebfFqGId7qLaLjNN84I3irSb4GIqw5n2sQk2hVGp2tQ8n/bapO7zTktdab+Qg9vU09IvhzjCwmbsvn1CAum6XAJxZsARAWM91Ih7cTS2cf1nDrpKjQpriC+lToJQgaSL1BlXZBuhCNv0HTJDBMqwZgAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by IA1PR19MB7709.namprd19.prod.outlook.com (2603:10b6:208:3d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:04:53 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:04:53 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v5 3/4] vhost_user: support function defines for back-end
Thread-Topic: [PATCH v5 3/4] vhost_user: support function defines for back-end
Thread-Index: AQHcVJtOUtNVT6ood0inyppL9ekqZbVFqgMAgA2XbfA=
Date: Thu, 15 Jan 2026 08:04:53 +0000
Message-ID: <SJ0PR19MB46067C59B8CAA6107F67980FF58CA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-4-pravin.bathija@dell.com>
 <db79f122-fc59-4c2e-b44f-97de3131c967@redhat.com>
In-Reply-To: <db79f122-fc59-4c2e-b44f-97de3131c967@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-01-15T08:02:43.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|IA1PR19MB7709:EE_
x-ms-office365-filtering-correlation-id: 441a6171-deb5-4a04-f22b-08de540cc3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?Ky1pQ1ArLUs4bUQ3UnNpOUFaQk1uc25BY2FGMmxEMGE0UkdnaDNtRFNTNURp?=
 =?utf-7?B?OTVxOUZnVTdvTFQ4cGFzSFBjVVEzdysta0RhQnA1N1FiTjJwSTRBME1zWjZu?=
 =?utf-7?B?MW9obEVoSm9BM2UzS2dVeVVmeUNUOVNoMkthNTJ2c1VXaVcyMSstVklvSFVW?=
 =?utf-7?B?ZkJhbUVicXJrck56WmlQWlFRMTVyRDdkYkw4bm5vTjVheXlGSGxCQjFxNHI2?=
 =?utf-7?B?bXEvY25GRFVzb0RZcnlJVHRvV3pkYVZCNFpvVnhTVm1LempLampadzJDc1h2?=
 =?utf-7?B?QVZnMlV1eGo2UjErLXQ0Zkp2NjI2T1d0RjhqdnprNHd1UWo0TTVDcm5hT05l?=
 =?utf-7?B?dnlnY2NTamZWOU9aQWtnc3JWbzI3RzVPZUVvcmFwKy10NjBJSUo5Mm1aVmJx?=
 =?utf-7?B?SzdCVThLKy1zU0EydUNNaS9zZTh4bkVwdGE5bEdFMkJCZmt0N1BkbzdkKy1z?=
 =?utf-7?B?b0t0UWEwUnYzTDBqM3QvV09LdjNVcGg5dFdWUGxZMUtxR1AzZExMWUZTZXhI?=
 =?utf-7?B?eExOSHMyOHg1Ky1BZ2wvVEljMUdtZ2NYaTlUTDhxZFlpbzFLUHpnMko2SGY=?=
 =?utf-7?B?ZSstUG9VMGszQWZYM2g1N1J0enl2TllYZlJMNm1mN2pYQW1ucElvKy1oMTZu?=
 =?utf-7?B?M05nKy1QY21TTystVGY3NkthcVU0VG1UWVkwazhIOHk3aGE2WSstcFNRWHFF?=
 =?utf-7?B?bFR6akd1ZDlKZFBEUVVBWjdlclA0ZkxSQ1lQZDQ2VXh3bFpQTE9EMGN2SGM1?=
 =?utf-7?B?Wld2RzBKYzFSTUw4WE95VTlSUy8xaVFyb3hrQS83a0NpcVVUejlmQ0gzUTdW?=
 =?utf-7?B?WGVqT21tNVFHOHRiUzRjNkJUU0ZWcWhEZmk0dVNGNTlmVU0yYkM5aUI0QzBQ?=
 =?utf-7?B?WUNVejlxb1NjUTFiYVlaUWY4RG5TaWhETE5kYzlodVVJYUdIWlJjbWp2S3Rp?=
 =?utf-7?B?RER4Z2NsV2RJM1V0Znk0dDdyVG8rLTU2WGNQWmVhWXlNMm1TS0FYOWJsRGhu?=
 =?utf-7?B?WjFOSGRrZ0diaFQ3UmtKT2wzdUpEUlVtKy1CcjhNbk1vYTEzR2s2dlBibVBL?=
 =?utf-7?B?YlBMMHQ3OEZEUkZFbUtOTjM3bkFsbkNiYzg5UGJTY2NWUEFZWW9INEg5bVpC?=
 =?utf-7?B?d0VKM1A0V1lrNTJ0cGtHVDllUld5cENGaXRpblduRGNJeHJDaHlmNDlwVG5q?=
 =?utf-7?B?aUVGTzY5WGc4RHBwdThPdVFnZS8xdkJKSG1rNGZUbm5qbnozNGFoUFNqNE84?=
 =?utf-7?B?RzVHT2dXZ2pkVkk3OTI3T3hGbmsxaXlNUWI3dVo0ZzlpdVRFYnA0cHlrMVky?=
 =?utf-7?B?Ky1Ec24rLW1WTmJ0YVRVSnZLVVY3NHluKy1MdXpKS0lLKy14NnZqL0xNdVcv?=
 =?utf-7?B?ZlpLcUxzZTVEQkVWSkhaVlBsQWVLRldPWHZBYndxeDVYUDVmaWN4eVNyQi9U?=
 =?utf-7?B?UWM5ZEx0YUNndXJTNlZBYmo5cWVKNU5IVkdMKy1KY3dZTS9nTUR4ZGJBWkkx?=
 =?utf-7?B?ZSstRDlMNW1hUnVqaXVvNnlhY1EybEtwUDRVSVJkeEViT0R3T3NQYWlZRDZW?=
 =?utf-7?B?cXMzMnQ4aU13RUdnUXo3SVFNNGVVMlJUMm1jWktVSUxGeXdOT2NNVXlBbFdi?=
 =?utf-7?B?RWVlVVFnZzEzZGlabndBblRnMnZObVI3UFc3TGFTbVhhTXZSZHF4Z3BqT1g5?=
 =?utf-7?B?VDhpMDdaOFcwOGVLN1RqTHB5REhEc3BxY3FJNmZvbE9qYXY3OUp0UzVIVmhJ?=
 =?utf-7?B?TEs1Mld6dHV0RGFMNnY1RzNBZVJJVGY2Ky1ZamliYTQ1V2JNYVB4cU82MzJB?=
 =?utf-7?B?dDlEZUNjbkE0Ky1ZWVBORjRETzlRbW4rLUt2Y1RzWkt3elN4TkFlOU9LbDJ4?=
 =?utf-7?B?a3lhSzN3SDhnY1hGTDFLcVVITGs3dUxtUVN2MnJ0Ky0zZXJjRUdkcno0by9F?=
 =?utf-7?B?bmZ2OWVCSGFNaUlVd2hLYystbFhYRTBEZSstZUVUdWRkVistMkpFU2hNNmhy?=
 =?utf-7?B?M2RhRVNkeHRaUTczOE15elp4N3NaeGJRaGQ5NDFmRVdRME0wdE1BNERnQVBs?=
 =?utf-7?B?elg2eXdodkZFUWpOTzY1UWJDZlVXeGZQVGRuR0o5SHZwbWw1VTRHZ3habks5?=
 =?utf-7?B?OExZRWh5WHp4OXNzTFI2UW41V2hQWUtCSnY3TUVkcko5QzUzWEowTGJJcFAz?=
 =?utf-7?B?NC9mOHAyeDZMYXhwL2RDeG91ZnYyNWgyZGZKOWozQUdiTlVrOWQ0R0ZFVkxI?=
 =?utf-7?B?MWI5VC9LemcrQUQwLQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?b1RCR0F1cE43QjhldzBVTFBHbEVCZ2k4TFdBRUsrLTUxUHZlV1JYeXNqWkk3?=
 =?utf-7?B?OTdSWVp0TG5ZSjI5ckJUWUhGV3RHb3Y0SGdwRkhkYnlCZ2xGOC9CRUN0SkMw?=
 =?utf-7?B?V09sRnhkRmRFOWlhUHRuejVVcHU1TWtmVW0rLTYwNystYU9qdkg1d0RwS2RX?=
 =?utf-7?B?elFocHdubHlWTGFLRkVXYjhGczlWSTdUUDdLcnkyREJVZm5SNlNuVVFiREdm?=
 =?utf-7?B?USstSHhxcFF2UGNYVjN0NVFjWEJCaWNzUGYzUC9TU2J1d1BoQlhWdXJtWFRO?=
 =?utf-7?B?akpIVkFCaDdZdU5PUWRNSWtYL1F6ZHNNcG9GdFcwUnpja1NGbnVDQXBIQWJj?=
 =?utf-7?B?dWdMNWVFS0R6OFpQQXNoREQxam1TWEVPcHNudUlFejFKbGVCL2IzYnV4aEg3?=
 =?utf-7?B?WVltSHdpb3FCRVcvNmFFR3pNRXNCd0VWakVGeU9YemhLZ0VSMVR3NTM3QjFL?=
 =?utf-7?B?TE52bVRGN3ZIL0l3UktTaEc5MkU0cjNPbTNlaFVJZ3lodW02REZqRFVqcVJT?=
 =?utf-7?B?QnpBbVYvNjZMRGZXV0tFKy0zRXhXalUvWldOU3IrLXpvS1J3blZWZGo4TnFK?=
 =?utf-7?B?QURxblNhaE9nWktFUlVlSFpON1h4aTdoRHluVzlLN2NlY290bWs2OHZXNnNO?=
 =?utf-7?B?MjdmazU0ZzB3TFRVRk8yTkdwNDVYMUlkdGpLUWxsUnA0cFdmMHpsYjRiTHhr?=
 =?utf-7?B?RFBjYnVlYmFPTzhrTWpHQ0FCQWllWldIOVJHRWFQVjZ1R0U4VDloWFN2eUFZ?=
 =?utf-7?B?VGpGeUkzTkJaYTJjTistdTRTY2x0NG9hdk82NTJLa2ZEOGJ4VElsbjhLZVVX?=
 =?utf-7?B?NG02a1MrLXZ6dTcwVDFyV0ZXV1NCZE5idHREdC9mQ1FlSUd6b1hIWFdlSkNN?=
 =?utf-7?B?YUVFa3AvVEIwS3gvM2hUUEZEZ2xkaERHTjRPa29PZWZaVUJkQ0JwRENOaGQ3?=
 =?utf-7?B?N1NLbGJ2c2MyQkVTVWhMVzdHM1ZsUlVPNndzcmozcWRKNUMyZUNEUUVTUyst?=
 =?utf-7?B?bUluWWZxelZsVUNKR0xBRkZIWG1LTTVmSVZ0c0MxSUx3cS84bWJmOUZHdmxr?=
 =?utf-7?B?d3ZTWE9xQ216WDRUMHRoU3VWVnhSZm52MVVGSXdSSkpFcEJ3QWpmLystdmQ=?=
 =?utf-7?B?Ky1YZlgzdGlIVlBGZjU0MnA5aEE1dW9IbnpzaFpoQm4vV1ZNcHIzTU5kNTNo?=
 =?utf-7?B?MjFFcXRKbFRYM3FXUlRzaTdoN3ZlNFBneGhncDdYU2lVTm8rLVhia2ZZcGo4?=
 =?utf-7?B?TW03cWJ0RXdKc0FKRGwzcFdqT0pkeEQrLU9wNE50eTJsVGdJaURmeFprKy14?=
 =?utf-7?B?Z2FLdDdqOWk2enlPQ01jTGlNazc5dnF3OTBYZ3FoUVREcEZXV0I5dVZPTkdZ?=
 =?utf-7?B?bUxuajNzN3ErLXZOY1d1S2pMd1JFYjNleSstZWZxZnM5ZTB0M3NzNEtaTHJ1?=
 =?utf-7?B?UndOQ1Z1Y0IrLURJOVNac2VYQXRlcVZOOWdlVERIVXZsMmF3T1hxRi9VZVJL?=
 =?utf-7?B?am1vd3RqKy1GMFdnRXpldWZRbGZ4dEFjOVRQSWk4N1F5eHUwajFoTUM2OE41?=
 =?utf-7?B?MystczBreFovZm1rN2o4T29Ua3JScmN5WS9LTmJPYnF1ankyMDQ5YTlEZHhm?=
 =?utf-7?B?REtWT3FNeHArLVlhOGJXQUtYdm5SdWlEeXQ2Y1lJNFVydlJYbjJtVGlBVHNY?=
 =?utf-7?B?dk4yTVRub3FBbk1Tb1FkZVZsL2FRNngrLUd4UE9HYmd2RVdkN1VqR3prN0JE?=
 =?utf-7?B?eWRaSkxLQmlRZ0lwbjNRaHZ1SmNBQmRJTmhHdERValRiRmkvYS9KeVA0SUo=?=
 =?utf-7?B?Ky00UDBLc0paRTFQelhGTUdUbXpLMystamtYcXJoM1Z0ZzV2aC9FYVhyaENS?=
 =?utf-7?B?WTV5aEtvTXo1eistWHZWeGUrLUpVT1VWc3JMdEtCbUpMUUlCbSstYjdYNExG?=
 =?utf-7?B?VmhUN09EWDBIVnJiU0RXbFdtQVBKbDlsbzBUaUUxWkZ5Zm5qMWp1Sy8xTm1R?=
 =?utf-7?B?VVhKem54RXV4aUNQdUZsRnVST1pyMzBKSUthZ08rLVh3bjlwOVhRNU4ybjJY?=
 =?utf-7?B?MWlaNExOYm96ZmwvN0dIYXA1dUN2MDNjQmt0b1ZPVUhYUkpTTGpkc2N3bVkw?=
 =?utf-7?B?NW5RKy1HTlY1Ky12NUpiQWxleEVNTmhiZXc0N0hiUE9wVXh1WlpRMGRMT3g2?=
 =?utf-7?B?dEZaTTltWVpIKy1pOG1FUHVzc1RJVmJrVkZjTkNLSDY0c3laRzlJYlozdU42?=
 =?utf-7?B?Q0RRckZGaGRtMC9oWUdXKy1lZlJFbEtNbkZ0dGlaV2xpVXNQUHRRdVFQZXZU?=
 =?utf-7?B?eUFnR1Nkc0JqOEk2Rzlac1RQbnBMOHg5TWVrYnNSbnhuV3Nsa0Jwd2d1ZXNh?=
 =?utf-7?B?RnJ1cGVlMS8vN1hidXR3TEN0Qmw0cFNaKy1zVlErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441a6171-deb5-4a04-f22b-08de540cc3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 08:04:53.5841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1q+kVAA8+wsavfT5YHVWvHfsZi2hgVVQQ53Gw6jUFE6J0H/rFEL0M8p52GF0QjJjSossUtQ5sKBBEPXoDIJ3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_02,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150054
X-Authority-Analysis: v=2.4 cv=HaYZjyE8 c=1 sm=1 tr=0 ts=69689faa cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=nuuw-2M0FaGnbzcUkHEA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=1uMOUU2w0DxzEe95gQqD:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: J0far8zagSeWPe2zYFkq2ocEBMWeXD_n
X-Proofpoint-ORIG-GUID: J0far8zagSeWPe2zYFkq2ocEBMWeXD_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA1NCBTYWx0ZWRfXwWwnA2nnRTem
 GvBfbVR2CE2920A+sO5JsKd6KNzMUlSLqu9Cqej5D0jpwa/+smrCGUmWtjWer83C6KsWMQYpEuy
 47v6p+fEWD8Vncu8VPoiBuFELqcpcJK1/lkzgXk21pvE0I7JKL1qAXvutOoZ3MiTjtyDpEIpOcj
 QDd5qAat5nbfmcv1/oxMFJFqqz8IaIHCTDNpZi86eURiigLbeuzgu5eGEEN7BVnbOI27+3JlvFn
 KuZRtgK7AAcecC7m60fqUmmJoKX5rFuXCirYMIf6phr6nxswHiBn3b+ofd8DQttHxP3otPVXhhA
 qee1k1BhD7agGQ7fFtVcd9k5uxVotq6MmgCwPWrDwsrwQ6VpRukyxICxN9LjX+41Lypa+7RkBJw
 jrCEINdFSGL1cF5Jyj9VaHuvpr923pWLgHgNKf3PuLEeRh3cIja13XvxQv0X4waugXM/PzYUBV8
 yXjrPwlypZkcK5Dr8ZQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150054
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

Dear Maxime,

Responses inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Tuesday, January 6, 2026 8:29 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v5 3/4+AF0- vhost+AF8-user: support function =
defines for back-end
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On 11/13/25 1:44 PM, Pravin M Bathija wrote:
+AD4- +AD4- Here we define support functions which are called from the vari=
ous
+AD4- +AD4- vhost-user back-end message functions like set memory table, ge=
t
+AD4- +AD4- memory slots, add memory region, remove memory region.  These a=
re
+AD4- +AD4- essentially common functions to initialize memory, unmap a set =
of
+AD4- +AD4- memory regions, perform register copy, align memory addresses a=
nd dma
+AD4- +AD4- map/unmap a single memory region.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-   lib/vhost/vhost+AF8-user.c +AHw- 150
+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+----
+AD4- +AD4-   1 file changed, 140 insertions(+-), 10 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- 4bfb13fb98..7dc21fe42a 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AEAAQA- -171,6 +-171,80 +AEAAQA- get+AF8-blk+AF8-size(int fd)
+AD4- +AD4-     return ret +AD0APQ- -1 ? (uint64+AF8-t)-1 : (uint64+AF8-t)s=
tat.st+AF8-blksize+ADs-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static void
+AD4- +AD4- +-async+AF8-dma+AF8-map+AF8-region(struct virtio+AF8-net +ACo-d=
ev, struct
+AD4- +AD4- +-rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg, bool do+AF8-map) +=
AHs-
+AD4- +AD4- +-   uint32+AF8-t i+ADs-
+AD4- +AD4- +-   int ret +AD0- 0+ADs-
+AD4- +AD4- +-   int found +AD0- 0+ADs-
+AD4- +AD4- +-   struct guest+AF8-page +ACo-page+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   uint64+AF8-t reg+AF8-size +AD0- reg-+AD4-size+ADs-
+AD4- +AD4- +-   uint64+AF8-t host+AF8-user+AF8-addr  +AD0- reg-+AD4-host+A=
F8-user+AF8-addr+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF8-guest+AF8-page=
s+ADs- i+-+-) +AHs-
+AD4- +AD4- +-           page +AD0- +ACY-dev-+AD4-guest+AF8-pages+AFs-i+AF0=
AOw-
+AD4- +AD4- +-           if (host+AF8-user+AF8-addr +AD0APQ- page-+AD4-host=
+AF8-user+AF8-addr) +AHs-
+AD4- +AD4- +-                   found +AD0- 1+ADs-
+AD4- +AD4- +-                   break+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (+ACE-found) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-DMA engine map:
+AD4- region not found+ACI-)+ADs-
+AD4- +AD4- +-           return+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   if (do+AF8-map) +AHs-
+AD4- +AD4- +-           while (reg+AF8-size) +AHs-
+AD4- +AD4- +-                   page +AD0- +ACY-dev-+AD4-guest+AF8-pages+A=
Fs-i+AF0AOw-
+AD4- +AD4- +-                   ret +AD0-
+AD4- rte+AF8-vfio+AF8-container+AF8-dma+AF8-map(RTE+AF8-VFIO+AF8-DEFAULT+A=
F8-CONTAINER+AF8-FD,
+AD4- +AD4- +-                                   page-+AD4-host+AF8-user+AF=
8-addr,
+AD4- +AD4- +-                                   page-+AD4-host+AF8-iova,
+AD4- +AD4- +-                                   page-+AD4-size)+ADs-
+AD4- +AD4- +-                   if (ret) +AHs-
+AD4- +AD4- +-                           if (rte+AF8-errno +AD0APQ- ENODEV)
+AD4- +AD4- +-                                   return+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                           /+ACo- DMA mapping errors won't st=
op
+AD4- VHOST+AF8-USER+AF8-SET+AF8-MEM+AF8-TABLE. +ACo-/
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +ACI-DMA engine map failed+ACI-)+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-                   reg+AF8-size -+AD0- page-+AD4-size+ADs-
+AD4- +AD4- +-                   +-+-i+ADs-
+AD4- +AD4- +-                   if (i +AD4APQ- dev-+AD4-nr+AF8-guest+AF8-p=
ages) +AHs-
+AD4- +AD4- +-                           /+ACo- shouldn't get here +ACo-/
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +ACI-DMA engine map: No more pages+ACI-)+ADs-
+AD4- +AD4- +-                           return+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0- else +AHs-
+AD4- +AD4- +-           while (reg+AF8-size) +AHs-
+AD4- +AD4- +-                   page +AD0- +ACY-dev-+AD4-guest+AF8-pages+A=
Fs-i+AF0AOw-
+AD4- +AD4- +-                   ret +AD0-
+AD4- rte+AF8-vfio+AF8-container+AF8-dma+AF8-unmap(RTE+AF8-VFIO+AF8-DEFAULT=
+AF8-CONTAINER+AF8-FD,
+AD4- +AD4- +-                                   page-+AD4-host+AF8-user+AF=
8-addr,
+AD4- +AD4- +-                                   page-+AD4-host+AF8-iova,
+AD4- +AD4- +-                                   page-+AD4-size)+ADs-
+AD4- +AD4- +-                   if (ret) +AHs-
+AD4- +AD4- +-                           if (rte+AF8-errno +AD0APQ- EINVAL)
+AD4- +AD4- +-                                   return+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                           /+ACo- DMA mapping errors won't st=
op
+AD4- VHOST+AF8-USER+AF8-SET+AF8-MEM+AF8-TABLE. +ACo-/
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +ACI-DMA engine unmap failed+ACI-)+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-                   reg+AF8-size -+AD0- page-+AD4-size+ADs-
+AD4- +AD4- +-                   +-+-i+ADs-
+AD4- +AD4- +-                   if (i +AD4APQ- dev-+AD4-nr+AF8-guest+AF8-p=
ages) +AHs-
+AD4- +AD4- +-                           /+ACo- shouldn't get here +ACo-/
+AD4- +AD4- +-                           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR,
+AD4- +ACI-DMA engine unmap: No more pages+ACI-)+ADs-
+AD4- +AD4- +-                           return+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-   static void
+AD4- +AD4-   async+AF8-dma+AF8-map(struct virtio+AF8-net +ACo-dev, bool do=
+AF8-map)
+AD4- +AD4-   +AHs-
+AD4- +AD4- +AEAAQA- -225,7 +-299,17 +AEAAQA- async+AF8-dma+AF8-map(struct =
virtio+AF8-net +ACo-dev, bool
+AD4- do+AF8-map)
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4-   static void
+AD4- +AD4- -free+AF8-mem+AF8-region(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4- +-free+AF8-mem+AF8-region(struct rte+AF8-vhost+AF8-mem+AF8-regi=
on +ACo-reg) +AHs-
+AD4- +AD4- +-   if (reg +ACEAPQ- NULL +ACYAJg- reg-+AD4-host+AF8-user+AF8-=
addr) +AHs-
+AD4- +AD4- +-           munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mmap+AF8-s=
ize)+ADs-
+AD4- +AD4- +-           close(reg-+AD4-fd)+ADs-
+AD4- +AD4- +-           memset(reg, 0, sizeof(struct rte+AF8-vhost+AF8-mem=
+AF8-region))+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static void
+AD4- +AD4- +-free+AF8-all+AF8-mem+AF8-regions(struct virtio+AF8-net +ACo-d=
ev)
+AD4- +AD4-   +AHs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- +AEAAQA- -236,12 +-320,10 +AEAAQA- free+AF8-mem+AF8-region(stru=
ct virtio+AF8-net +ACo-dev)
+AD4- +AD4-     if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+AF=
8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4-             async+AF8-dma+AF8-map(dev, false)+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-mem-+AD4-nregions+ADs-=
 i+-+-) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           if (reg-+AD4-host+AF8-user+AF8-addr) +AHs-
+AD4- +AD4- -                   munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mma=
p+AF8-size)+ADs-
+AD4- +AD4- -                   close(reg-+AD4-fd)+ADs-
+AD4- +AD4- -           +AH0-
+AD4- +AD4- +-           if (reg-+AD4-mmap+AF8-addr)
+AD4- +AD4- +-                   free+AF8-mem+AF8-region(reg)+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -255,7 +-337,7 +AEAAQA- vhost+AF8-backend+AF8-cleanup(=
struct virtio+AF8-net +ACo-dev)
+AD4- +AD4-             vdpa+AF8-dev-+AD4-ops-+AD4-dev+AF8-cleanup(dev-+AD4=
-vid)+ADs-
+AD4- +AD4-
+AD4- +AD4-     if (dev-+AD4-mem) +AHs-
+AD4- +AD4- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -704,7 +-786,7 +AEAAQA- numa+AF8-realloc(struct virtio=
+AF8-net +ACoAKg-pdev, struct
+AD4- vhost+AF8-virtqueue +ACoAKg-pvq)
+AD4- +AD4-     vhost+AF8-devices+AFs-dev-+AD4-vid+AF0- +AD0- dev+ADs-
+AD4- +AD4-
+AD4- +AD4-     mem+AF8-size +AD0- sizeof(struct rte+AF8-vhost+AF8-memory) =
+-
+AD4- +AD4- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +AC=
o- dev-+AD4-mem-+AD4-nregions+ADs-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4-     mem +AD0- rte+AF8-realloc+AF8-socket(dev-+AD4-mem, mem+AF8-=
size, 0, node)+ADs-
+AD4- +AD4-     if (+ACE-mem) +AHs-
+AD4- +AD4-             VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AEA=
AQA- -808,8 +-890,10
+AD4- +AEAAQA-
+AD4- +AD4- hua+AF8-to+AF8-alignment(struct rte+AF8-vhost+AF8-memory +ACo-m=
em, void +ACo-ptr)
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     uintptr+AF8-t hua +AD0- (uintptr+AF8-t)ptr+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- mem-+AD4-nregions+ADs- i+-+-) +=
AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             r +AD0- +ACY-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-           if (r-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (hua +AD4APQ- r-+AD4-host+AF8-user+AF8-addr +ACY=
AJg-
+AD4- +AD4-                     hua +ADw- r-+AD4-host+AF8-user+AF8-addr +- =
r-+AD4-size) +AHs-
+AD4- +AD4-                     return get+AF8-blk+AF8-size(r-+AD4-fd)+ADs-
+AD4- +AD4- +AEAAQA- -1248,8 +-1332,12 +AEAAQA- vhost+AF8-user+AF8-postcopy=
+AF8-register(struct virtio+AF8-net
+AD4- +ACo-dev, int main+AF8-fd,
+AD4- +AD4-      +ACo-/
+AD4- +AD4-     memory +AD0- +ACY-ctx-+AD4-msg.payload.memory+ADs-
+AD4- +AD4-     for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4- +-           int reg+AF8-msg+AF8-index +AD0- 0+ADs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           memory-+AD4-regions+AFs-i+AF0-.userspace+AF8-addr +=
AD0- reg-+AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4- +-           memory-+AD4-regions+AFs-reg+AF8-msg+AF8-index+AF0-=
.userspace+AF8-addr +AD0- reg-
+AD4- +AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           reg+AF8-msg+AF8-index+-+-+ADs-
+AD4-
+AD4- How is it supposed to work?
+AD4- reg+AF8-msg+AF8-index is re-initialized to 0 at each iteration.

You are absolutely right, it is an oversight. reg+AF8-msg+AF8-index should =
be initialized before the for loop starts. I will make the necessary change=
s and retest.

+AD4-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     /+ACo- Send the addresses back to qemu +ACo-/ +AEAAQA- -127=
8,6 +-1366,8 +AEAAQA-
+AD4- +AD4- vhost+AF8-user+AF8-postcopy+AF8-register(struct virtio+AF8-net =
+ACo-dev, int main+AF8-fd,
+AD4- +AD4-     /+ACo- Now userfault register and we can use the memory +AC=
o-/
+AD4- +AD4-     for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (vhost+AF8-user+AF8-postcopy+AF8-region+AF8-regi=
ster(dev, reg) +ADw- 0)
+AD4- +AD4-                     return -1+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -1382,6 +-1472,46 +AEAAQA- vhost+AF8-user+AF8-mmap+AF8=
-region(struct virtio+AF8-net +ACo-dev,
+AD4- +AD4-     return 0+ADs-
+AD4- +AD4-   +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-initialize+AF8-memory(struct virtio+AF8-ne=
t +ACoAKg-pdev) +AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo-
+AD4- +AD4- +-    +ACo- If VQ 0 has already been allocated, try to allocate=
 on the same
+AD4- +AD4- +-    +ACo- NUMA node. It can be reallocated later in numa+AF8-=
realloc().
+AD4- +AD4- +-    +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- +-           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF0--=
+AD4-numa+AF8-node+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- +-   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           dev-+AD4-max+AF8-guest+AF8-pages +AD0- VHOST+AF8-M=
EMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+AF8=
-socket(NULL,
+AD4- +AD4- +-                                   dev-+AD4-max+AF8-guest+AF8=
-pages +ACo-
+AD4- +AD4- +-                                   sizeof(struct guest+AF8-pa=
ge),
+AD4- +AD4- +-                                   RTE+AF8-CACHE+AF8-LINE+AF8=
-SIZE,
+AD4- +AD4- +-                                   numa+AF8-node)+ADs-
+AD4- +AD4- +-           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, =
ERR,
+AD4- +AD4- +-                           +ACI-failed to allocate memory for=
 dev-
+AD4- +AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- +-                   return -1+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhost-m=
em-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS, 0, numa+AF8-node)+ADs-
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-failed to allocate
+AD4- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- +-           rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-           return -1+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   return 0+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-   static int
+AD4- +AD4-   vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-ne=
t +ACoAKg-pdev,
+AD4- +AD4-                     struct vhu+AF8-msg+AF8-context +ACo-ctx,

