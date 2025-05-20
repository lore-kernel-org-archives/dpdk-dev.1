Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D30C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 17:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93F7140B9B;
	Tue, 20 May 2025 19:00:32 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
 by mails.dpdk.org (Postfix) with ESMTP id D5F074029C;
 Tue, 20 May 2025 19:00:31 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VHG57tD1SS++c6LqQ5wqJNxBujLhde8obmw2w2vDE0yJJU7HNfT3NCqDqCkdq1peCuK3xPa1VSrqc0BwqxsV4ccO6obMn0pq3nNRTTKW/3JObJHAJnU5AMz+HY5x2HAtbiBuYiJ1LfvI96pWWuhtA8AcsIlh2+l+oxZbhjkxLLt1EsrHUcy5kfOOwL0NShPQDXnCe7LlC5oU+dwabaUEDJe7mm2oqz3ggvTY1AJpXr4eBqkZ6OdgDLbF13gKMpf9WK2k1bbgOuxLOaxjidGfwUdjZSx9qJEHSgS+kKtIPnUXd5HkpfSQ0RxUPiZ0VC2Yye93jygDCJl6ukdoyIO7LA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjrh3P5CqQ4f2A7YMj+VKj6z5inp++9LNTB+7T8fQ1M=;
 b=MmwKKZ9bTyXR+lMN3kCUw6vvLEOujHh6Pp3zIgJU3W8gBe6fXBoRHEHGxxxPo9mL55M+4WicmpU9fFOZ7x8nhhoxKtzszhD9arTEjCVeD3a3AE9s7ZOFAnZOB35die2BuB/auKGXNmNlWjM26Xkwfk+OTgdxdJ5DZ9KIqJkrBqqwFj5JK6H3Eg5E2jQz1Yw/Tkz1NLU1RycZGN0D7JmTaDNyB76ixXDjpTH1YpL09ZUaeNOgz4i4Sg7A735z89jNv1JJLGHISrmcVgyq3vvQWcoeVq2eEqYFeelRVretRl4UzPb+5taderSsVPFUf3sOCikrXrTVo/36eYI60QsMwQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjrh3P5CqQ4f2A7YMj+VKj6z5inp++9LNTB+7T8fQ1M=;
 b=peXVvkwSLfxP4HIbw6n4VY6nnoxAze0kz5Ie+bZ4KidgapmYcevFjYsWvXDXCncbHWkvJ6vG9mZ68cugyaH3V9J+OLjHrdKJcAIYalOwUK/Q+nsa9pH6bq63VzQ2CR584NXS4om0GTVvbM0OVZ6nvfSiwL0/86QosA14VChg66g=
Received: from DU2PR04CA0085.eurprd04.prod.outlook.com (2603:10a6:10:232::30)
 by AS2PR08MB9047.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 17:00:28 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::d4) by DU2PR04CA0085.outlook.office365.com
 (2603:10a6:10:232::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 17:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Tue, 20 May 2025 17:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmajNhoguge4yu7X3Z2hjUVVL9pOnOHzToEkptyB4O9hl53NXAJ810DsW9MCk72HHJSrORPl30dpCfR6+LuIpxTteY2vm8Bg9RQaYuUju/yvqtD/XuVQCj4RdWjENqtf9mYb7Mr29gL/vi4pFu9I7eNNAM1B7MIiqt3tVV0PpIw1RuID5fMddFGNdjdHZ+ZlF2WKGYZfCxyRuaxWh6qRi+V3SFkKlJZlAgqGunxV20okA03G9f2qtKpFUC2p2I1juwsARVtJ2wz10LLmTRa5IkpsvgxrGfSeps8F0Fks6byqZgtNV//KJm2BPH5DDZBak8qv++NUflX6dncHrjpq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjrh3P5CqQ4f2A7YMj+VKj6z5inp++9LNTB+7T8fQ1M=;
 b=YD9t7c36FnnZS+7gvPjiSU4XEe7N1o78ZWa6ZJecPgpUZXKdnUs4GiobvnDJ4eRPHRIxvVMF/1nom/IlT2O5zdNHKL3GgyWq/e+PTBjTb8yD+J8gM/EvS0Jck/PUfyru4PGTN5xuaU50tOHtaRJPB0+nxq06Kb1AwPGXFkKNygS7KxRN++SBTe7qlZsext8n+b+HpGbnIkN2W3o7ioBSVKCqNBMbkBbgTb1y8jFXvQyiWCssyyk1KYMxoseaO9sZQgxAUa7IeGuTXfk/AKU9iOttaKm+8BgMXsmMVSyrkr49BfJH3GssJT4VHtDtSmRw3YXQupci9sBEJ17nGK8kTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjrh3P5CqQ4f2A7YMj+VKj6z5inp++9LNTB+7T8fQ1M=;
 b=peXVvkwSLfxP4HIbw6n4VY6nnoxAze0kz5Ie+bZ4KidgapmYcevFjYsWvXDXCncbHWkvJ6vG9mZ68cugyaH3V9J+OLjHrdKJcAIYalOwUK/Q+nsa9pH6bq63VzQ2CR584NXS4om0GTVvbM0OVZ6nvfSiwL0/86QosA14VChg66g=
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com (2603:10a6:20b:446::11)
 by DU5PR08MB10493.eurprd08.prod.outlook.com (2603:10a6:10:518::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 16:59:55 +0000
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8]) by AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8%4]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 16:59:54 +0000
From: Doug Foster <Doug.Foster@arm.com>
To: Patrick Robb <probb@iol.unh.edu>, "ci@dpdk.org" <ci@dpdk.org>
CC: dev <dev@dpdk.org>, Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, nd <nd@arm.com>, Wathsala Wathawana
 Vithanage <wathsala.vithanage@arm.com>
Subject: RE: meson error on ARM Grace server 23.11/22.11
Thread-Topic: meson error on ARM Grace server 23.11/22.11
Thread-Index: AQHbuLEeKJ6SB5N3OEySh9o8oTsIIrO6zhaAgBl4/ACAAIdRYIAHA4uA
Date: Tue, 20 May 2025 16:59:54 +0000
Message-ID: <AS8PR08MB733911AE8B83C45AFF3632BFE59FA@AS8PR08MB7339.eurprd08.prod.outlook.com>
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
 <AS8PR08MB73396AB179C12ACDCBA214B5E593A@AS8PR08MB7339.eurprd08.prod.outlook.com>
In-Reply-To: <AS8PR08MB73396AB179C12ACDCBA214B5E593A@AS8PR08MB7339.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB7339:EE_|DU5PR08MB10493:EE_|DU2PEPF00028D0D:EE_|AS2PR08MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 278f09d1-342b-42df-6e3a-08dd97bfd211
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aFROcCt6UTFsREVjTnYrTDVDc3RmRzF5NzZuOEswRWN0SW1aZjB3aFRmTkJj?=
 =?utf-8?B?d01QcmtTRVdIeXVrWTg4anR6a2tTZ3YvNU5RalZlaFdrOUhOWnZ4bUtVbDk0?=
 =?utf-8?B?clpveldTUy82a0h0ei9ZTWxyZDFhV2tBS2xMRVhNZlB5a2pLN1BXbFp3MmxY?=
 =?utf-8?B?eHRNaWdNSFlVTWVVNG8zN0JFa1F5emRhSlVmTHMvblRxUmtGY0FEZHU2Rzhz?=
 =?utf-8?B?YkNQblFSZ3VtVUFqeVdDOTVjMHpxdDdjZVFnWjdwMEY4b003MGdlK2lxOU9L?=
 =?utf-8?B?dm9iM1Q3QVU4OENOWmdNcjN6NkZrZ1owNWpYQ1JKdEIxckd3SGE3ZVU3RWd1?=
 =?utf-8?B?aGJqY0lhcnVVbm9XUEI1UmplZkN4TE5UK3g5cjEwdVlDblc2UlN5RGQ1VWM5?=
 =?utf-8?B?cDFhVGRUUW90THF5SHhHNjVULzJCS0xOTE01dDk5bTN1ZEJIRXNmVTF2bHNk?=
 =?utf-8?B?M1d6bjhKR3FONmdCMGpNQ1JxelRWNWYvRmZ3M1MzMHQ5Y3duTS8vNDEvVkVX?=
 =?utf-8?B?UTc1Vm9KdjJ2K0tQemp3OEJYbm10SFcxdWlOME4wZzJCODR0NUppM25nb3g5?=
 =?utf-8?B?bkR4ZHVFRTFZTDNHRStKVUxOREtrdndJdHdRTWNhM05vQUw1NllUQzN3RHFM?=
 =?utf-8?B?NXVyZUJLenN3V2N4RGlEOWNZTHFCWjBzQ2llUUVkeXdvTlpGWGs0UjdlS01T?=
 =?utf-8?B?NlpwRDBQK0Q3RzBjMDY0N2VuTjkyendYWUZLVFBWR3lmZEZud3ppRjJ2b2V4?=
 =?utf-8?B?MzMvQXpHSWZ1cXpBazhmb2tURFU0NGxUc3J4a2dwOGZTOEFPdlU3dlRRSnF5?=
 =?utf-8?B?Z1BLQUhYczRsd0dGY2pEK0wyZlhWeEpxQlVCK3lGcE1JY0creVkxL0hxTjkz?=
 =?utf-8?B?Mi9EYkFLaWdXZG5zb3A2Y1VyRnUxZUVIMXlDYWhCMHdid2RZeUUzZDIzRHAr?=
 =?utf-8?B?MlVDUldNTzVJaW9lUjIrcnltSzcvbzgrcTNydERYS0xYN0VhNm5VWGVCMzNG?=
 =?utf-8?B?REFBSDI2UHhScWI5WkxOM1djNXZreGh4YXh3Sk1Nd2JySzNSQ21jNTJ5OWtF?=
 =?utf-8?B?eUR2dFN5dlFHZ0VheExZdkd0MlQzZ0xubEQ1eG55SHFRQmFuOExqeTY3WHdo?=
 =?utf-8?B?NEYxeERrL0dXelpRbEFNenVYRm5QTkw1OUh0a2ZuSnpHM21YSHR3UmU4OXRr?=
 =?utf-8?B?NVZtVUJQbSsyVExhdFJJOTdUSFNwSFhSdmZWSmVXM0dGWmRkTUViRXZXSTNC?=
 =?utf-8?B?MEtnbzcrMnVQU2VaWHJYekpiZU4yMFJkMWE5VUhuQisyWDBpblAyNHNuc1Zr?=
 =?utf-8?B?dkREbVM0T1dzd1hScmlUQjJiRkNTSmdDS3dZbjlBUjZZcXpNKzg4aEpiV1FV?=
 =?utf-8?B?aHpJK2pCRFh2VEdQRHU4Z0xhc04wKzJtM0MxUFJoRkhJQzRmVlNidWQ5Q3Ft?=
 =?utf-8?B?L2dKU2lQSVUrM0YxWE1IaFhuWmM2SzdxMWVjVHhheVF4Y25NT3N6c0ErRDFu?=
 =?utf-8?B?QVBiek16RDBxWFZ0U04yZjNEWEhkRnRjcVYrbTF1bVI1NjZ2RFA3VUFOdEh0?=
 =?utf-8?B?OThYSjIybDc5YU91ZnVqRzdTZmdWTVFSYjE4ODQ3amJIcDFseWxuZ3h4MFY2?=
 =?utf-8?B?K0JSVkxCMjlIM1pJRGxTY3FGWHA1YzlKMXZmcHNtdkVTOXd4dThhY1d0ckZJ?=
 =?utf-8?B?VnFTMGgzTFQ2Z3FSVlVwZEZicVpoOTMrSExjTi8wcXUxSWFaUzBGR3Izd3Zy?=
 =?utf-8?B?WkdzK2t2dTlNM2hieUVqRVI4d0lLRVplb29HdTlhM0xBc3NtZmhKdWJHMGNv?=
 =?utf-8?B?alJSLzMwOVRoUG9HdGhjcktFWklTYUhBRDF3bUhZWm43Mi9VbXpsNDBsUHB4?=
 =?utf-8?B?WGVRRDgvc3NpWUJSQWU1STFUWTRwRWVkOVJHbjM1VURDSGxCNHRFdDZWa0N6?=
 =?utf-8?Q?KjVHjCYsq2+Uui+yzlcSpyK/x13hD8fK?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB7339.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10493
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c450edf7-752b-4ac4-783f-08dd97bfbe95
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG1oaWU5K2JnMng2aTJrZmt6UXBOSXZhWkQ0dUJSOXNxa2pHWUlOWTIwN3ox?=
 =?utf-8?B?VEtTRklCbVVxb3ZLUVF6OVJhVnYvNnczVFo3VGhER0JOVTZvOGZSZXErK3Ra?=
 =?utf-8?B?dWhBZTlBa0JhSktibjNwM2I3VWdENjBQVXJtQ2h2QVdSRlRoNzRPWnA5OGxT?=
 =?utf-8?B?UUQxTmVvZ0FSdDA3MU5zM2dpMktUUGpKOFh3MnJGdDlZV01VWTBlTW1sbm5L?=
 =?utf-8?B?bnRjTVh4d2k1VlNnVUpiRWxDNk9WMVZ4VnB3UWJyOUJqNnBITkdPc3NTYmpX?=
 =?utf-8?B?Z2paaTJxRzc3OFFHMmU0UnVaOTE1OXBOUFJzVk1JQUpoNkVsQnUzOVU4NmVp?=
 =?utf-8?B?MDJLV2tEaDFoOWVXdHd3c2JZWUQzVVUwb3VrN0tpWUU4VDNydDVGNjJ1VSt1?=
 =?utf-8?B?UkNoQmZlcGFkQzdieTlzRHM1dllyQVIvVUR3T1ZxWXQ2V0xBWEdONFhhdlNL?=
 =?utf-8?B?cGV6ekpSOS9zeHdrajd2NFRIWGNneFNOWDBTQTZabWJiTmliRHlTL3ZIRHNw?=
 =?utf-8?B?VFNUcWUzNFR5UllHMi81SG5VSzhnUnM5L0RCcmMycUZaUjNmVXJZT2lVd3kx?=
 =?utf-8?B?dW9UZ1plamNMaURzV3g5eHhOMkpUQnhBN1JKMnlhbDlod2h6MUFKZDRCa0Fl?=
 =?utf-8?B?TG40eVB1NEN0a0dDSnNGVlBJUVVsWE1oMFNBVXBJOG1wblAwMEtqQ2VjMHEy?=
 =?utf-8?B?TG4rbjA4SktoTE1BYTUzek5PRGpPME1PQVJieDJRRDBPWVQ2NnB2QTBMdks0?=
 =?utf-8?B?VlJraGpzVDRYMG5rTThNOVg4Wi9ZckVCWW1DSkRXRllpbDBMcFgxWXNiY3Rx?=
 =?utf-8?B?WEhRODYxOUl0Y0xRVHFweTVxNGY1VkxBbmwvU2ZJd25sT1VSTEFtUURvOThk?=
 =?utf-8?B?c1IzekhXcjlJQ2QxMlc5dWRqN3FWTm0wR0pLdE9XZFNsSHN1YXpSZ3I3eU9B?=
 =?utf-8?B?dHo1MFV6Wk81TitqcE5YUGF1a010SkhETEpYSzVPOWhnWG80eU1HVEUrTjR3?=
 =?utf-8?B?Y2FyL3NQUnpvVGErWG1zU2JMR09reHZDUjR3NE1XVU9sTlJUWmZRRDZBT0VQ?=
 =?utf-8?B?S3VWMVp1UllWdWpIRUpVMndWZEw4STlaOVR4VTNoNzRXbDFFckVWWUJvVVhq?=
 =?utf-8?B?MDhnRGtjL3RRZkNEb3NiUjg4M2JCZWJnWFFiczRjYW5hQXY3c2I5dVV2TEFW?=
 =?utf-8?B?MFRCdWQyNmN0TW92SWdRU2VLS2RCak82TzFSSTNTVFBMdjlZbFpacWN2UmZj?=
 =?utf-8?B?bmJkOTdiZWpoNmJES0F6THZNNU4wZk9Jbml2OTgySGNPRFloQlE5VTlUOUt4?=
 =?utf-8?B?c1M0N2FUaWFMUjk1NUJmTkRzRUJ5V1I4RDBSVlc2dUFzUVhpeWNvV3NTKzJn?=
 =?utf-8?B?WXhSMWdwamZrc2Z6MU9WcERvNVEyUVY3ZENJU3ZpRFZHSjZuZWtnRTVtMzlM?=
 =?utf-8?B?SHJweS9hWk85Yko3cHd1dFdaWG0vWkVPa2x0SVJiUnJMenlKQkIrTFU5WmpY?=
 =?utf-8?B?VVJXQUsxR0trZXBUT1krclRnWVRMbW54eWhEOEVYcjd3em1tQ2c1ZVBWWnd6?=
 =?utf-8?B?TzFiZDZsVGpoVkdlL0lMeUltRjIyWVlncXlscVdScWxuZ1ZGZlg1UTY1NEUz?=
 =?utf-8?B?U3NUT3E0dUM0MzZqUFg3a2wvakx3dXJNZktkeDNhVHdyL1I0TWxHSzJ3K1RK?=
 =?utf-8?B?Q1R1UUNXdUpqQWlRWE9KaFR2ZklSbkZCRTJtV2tQU0ZtTnFEc2J1eE52WWU5?=
 =?utf-8?B?WWlNMHlKL04xWjJWdG9qdDh4MTlrV3FIOXJnOW42Z2M0N0UvbjEwMjJuQUx4?=
 =?utf-8?B?Z1A5a3EwM2xmdktmVXlFdWR2OXNzeUtPbVFyREhHK2h6L3hGQzlzc0U5a2xh?=
 =?utf-8?B?Z056OEZZTnp5eHQ1MWJ4SktwZCt3N1E3c2tobTNQM1FHd2tzc3FmOEVMZ0Ra?=
 =?utf-8?B?WEdoMnQwOExiTmRselhtK0k0T2ZKQmFxSE00Sng1b0VOK3l2TDhKZk1aY2gy?=
 =?utf-8?B?SitzV04yZFdRPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 17:00:27.4284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278f09d1-342b-42df-6e3a-08dd97bfd211
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9047
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

SGkgUGF0cmljaywNCg0KV2hpbGUgYnVpbGRpbmcgMjIuMTEgYW5kIDIzLjExIHdpdGggR0NDIDEz
LjMsIEkgbm90aWNlZCBjb21waWxlciB3YXJuaW5ncyByZWxhdGVkIHRvIG1lbWNweSB1c2FnZSwg
c3BlY2lmaWNhbGx5IGludm9sdmluZyBfX2J1aWx0aW5fX19tZW1jcHlfY2hrIGZhaWx1cmVzLg0K
V291bGQgdGhlc2Ugd2FybmluZ3MgYmUgYSBjb25jZXJuIGZvciBDSSB0ZXN0IHJ1bnMsIG9yIGFy
ZSB0aGV5IGdlbmVyYWxseSB0b2xlcmF0ZWQ/DQoNCkZyb206IERvdWcgRm9zdGVyDQpTZW50OiBG
cmlkYXksIE1heSAxNiwgMjAyNSAxMjoxNiBBTQ0KVG86IFBhdHJpY2sgUm9iYiA8cHJvYmJAaW9s
LnVuaC5lZHU+OyBXYXRoc2FsYSBXYXRoYXdhbmEgVml0aGFuYWdlIDx3YXRoc2FsYS52aXRoYW5h
Z2VAYXJtLmNvbT4NCkNjOiBjaUBkcGRrLm9yZzsgZGV2IDxkZXZAZHBkay5vcmc+OyBIb25uYXBw
YSBOYWdhcmFoYWxsaSA8SG9ubmFwcGEuTmFnYXJhaGFsbGlAYXJtLmNvbT47IHN0YWJsZUBkcGRr
Lm9yZzsgbmQgPG5kQGFybS5jb20+DQpTdWJqZWN0OiBSRTogbWVzb24gZXJyb3Igb24gQVJNIEdy
YWNlIHNlcnZlciAyMy4xMS8yMi4xMQ0KDQpIaSBQYXRyaWNrLA0KDQpJIHdpbGwgcHJvZHVjZSB0
aGUgcGF0Y2hlcyB3aXRoIG5lY2Vzc2FyeSBjaGFuZ2VzIHRvIGJ1aWxkIG9uIEdyYWNlIGZvciAy
Mi4xMSBhbmQgMjMuMTEuDQoNCkZyb206IFBhdHJpY2sgUm9iYiA8bWFpbHRvOnByb2JiQGlvbC51
bmguZWR1Pg0KU2VudDogVGh1cnNkYXksIE1heSAxNSwgMjAyNSAzOjU5IFBNDQpUbzogV2F0aHNh
bGEgV2F0aGF3YW5hIFZpdGhhbmFnZSA8bWFpbHRvOndhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29t
Pg0KQ2M6IG1haWx0bzpjaUBkcGRrLm9yZzsgZGV2IDxtYWlsdG86ZGV2QGRwZGsub3JnPjsgSG9u
bmFwcGEgTmFnYXJhaGFsbGkgPG1haWx0bzpIb25uYXBwYS5OYWdhcmFoYWxsaUBhcm0uY29tPjsg
bWFpbHRvOnN0YWJsZUBkcGRrLm9yZzsgRG91ZyBGb3N0ZXIgPG1haWx0bzpEb3VnLkZvc3RlckBh
cm0uY29tPjsgbmQgPG1haWx0bzpuZEBhcm0uY29tPg0KU3ViamVjdDogUmU6IG1lc29uIGVycm9y
IG9uIEFSTSBHcmFjZSBzZXJ2ZXIgMjMuMTEvMjIuMTENCg0KVGhhbmtzIFdhdGhzYWxhLA0KDQpI
b3cgY2FuIHdlIGhlbHAgb24gdGhlIFVOSCBzaWRlPyBEbyB5b3Ugd2FudCB1cyB0byBwcm9kdWNl
IHRoZSAyMi4xMSBhbmQgMjMuMTEgZGlmZnMvcGF0Y2hlcywgd2hpY2ggd291bGQgYmUgYmFzZWQg
b24gZDAwNzAzOCwgd2l0aCBzb21lIG1vZGlmaWNhdGlvbnMgYmFzZWQgb24gd2hhdCB5b3UgaGFk
IHNhaWQgdG8gRG91Zz8NCg0KSSdtIG5vdCBzdXJlIHdoYXQgdGhlIHByb2Nlc3MgbG9va3MgbGlr
ZSBleGFjdGx5IGZvciBwcm92aWRpbmcgYmFja3BvcnRzIHRvIExUUyBtYWludGFpbmVycy4NCg0K
T24gVHVlLCBBcHIgMjksIDIwMjUgYXQgMTI6MDDigK9QTSBXYXRoc2FsYSBXYXRoYXdhbmEgVml0
aGFuYWdlIDxtYWlsdG86d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb20+IHdyb3RlOg0KPiBIaSwN
Cj4NCj4gQXQgdGhlIERQREsgQ29tbXVuaXR5IExhYiB3ZSBoYXZlIGJlZW4gcnVubmluZyBDSSB0
ZXN0cyB3aXRoIGEgbmV3IEFSTQ0KPiBHcmFjZSBzZXJ2ZXIgZm9yIHRoZSBwYXN0IGNvdXBsZSBv
ZiBtb250aHMgb24gbWFpbiBhbmQgbmV4dC0qIGJyYW5jaGVzLiBJIGFtDQo+IHRyeWluZyB0byBh
ZGQgTFRTIHJ1bnMgbm93LCBhbmQgcmFuIGludG8gYSBzbmFnIHdpdGggMjMuMTEgYW5kIDIyLjEx
IGZvciB0aGlzDQo+IHN5c3RlbS4gU3RhYmxlIG1haW50YWluZXJzIEknbSBub3Qgc3VyZSB3aGV0
aGVyIHRoaXMgc2hvdWxkIGJlIGFkZHJlc3NlZCBvciBub3QNCj4gZm9yIGhhcmR3YXJlIHdoaWNo
IGlzIG5ldyBhbmQgZGlkbid0IGV4aXN0IHdoZW4gMjIuMTEgYW5kIDIzLjExIHdlcmUNCj4gcmVs
ZWFzZWQuLi4gYnV0IEkgZmlndXJlZCBJJ2QgbWFrZSB0aGUgdGlja2V0cyBhbmQgZmluZCBvdXQu
IEkgYXR0YWNoZWQgdGhlIG1lc29uDQo+IGxvZ3MgdG8gdGhlIHRpY2tldHMgYW5kIGlmIGZvciB3
aGF0ZXZlciByZWFzb24geW91IGd1eXMgd2FudCB0byByZW1vdGUgaW50byB0aGlzDQo+IG1hY2hp
bmUsIEknbSBoYXBweSB0byBzZXR1cCB0aGUgVlBOIGFuZCBTU0ggYWNjZXNzLg0KPg0KPiAyMi4x
MTogaHR0cHM6Ly9idWdzLmRwZGsub3JnL3Nob3dfYnVnLmNnaT9pZD0xNzAzDQo+IDIzLjExOiBo
dHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTE3MDINCg0KK2RvdWcNCg0KbmVv
dmVyc2UtdjIgaXMgc3VwcG9ydGVkIGluIHRoZSBHQ0MgMTMuMyB1c2VkIGZvciB0aGlzIGJ1aWxk
IGFsdGhvdWdoIC1tdHVuZS8tbWNwdQ0KZm9yIGdyYWNlIGlzIG5vdCBhdmFpbGFibGUgaW4gdGhh
dCB2ZXJzaW9uLg0KQWRkaW5nIG5lb3ZlcnNlLXYyIGFuZCBzb2NfZ3JhY2Ugd2l0aCBjcnlwdG8g
ZXh0ZW5zaW9uIHNob3VsZCBicmluZyB0aGVzZSByZWxlYXNlcw0Kb24gcGFyIHdpdGggbGF0ZXN0
Lg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
