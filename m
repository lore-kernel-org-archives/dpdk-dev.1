Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D251EB2700
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17D95402B5;
	Wed, 11 Feb 2026 11:20:33 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B2C674026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:20:30 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B9kaSc899471; Wed, 11 Feb 2026 05:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=6
 aBMPuYUj8fRAjWvXgxXWpcBIMEuiWNlpWfW7CoA3Z4=; b=waVnJTQ3EIqy9CF4m
 kxzrm8Ea6bNrQEro9PvTdz2rZbXJUFLIB5vBpmVrCEPjK9h7qofClHJeNSHbBNS7
 6SeFjfrHD2dGqRIIlgsuXHOzZt4OMwTm/AJGxCvpb28JTXHZe8cVgpIEqEPKv1sO
 +Y/7Ccldx3BMwJcm9wBYxpaGIlTwDhjF4ntoBJzN3vCSaFLJyw7B7f6OSFQO3Oa7
 618TNW/rI8hP43rbUlWhhgrkjV88uTJ4rWzMKroPBUAKAIV67epHzz4Mg+aIqwf4
 KcXIF1S30OJX29pNzWNnUbm15ZNRUCuGT1o/ENOPf/4iXFwE6H+mGU3sYd+kcAYz
 J7I9Q==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4c61dv0e5g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Feb 2026 05:20:29 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B7TWMX3542831; Wed, 11 Feb 2026 05:20:29 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4c8ne61ssu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 11 Feb 2026 05:20:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGfzOf4f+mqBFNaGQlZ8BATkjYrrMTNAjtzt0rq2NyltDQCIvJJmf/C7t32lyucN5VizU7cIuoTiU1b4wpf7FPQwYN9Qm6Ejby0luHT3HyPs5jzHKVNrmkMtdY4MKv0PEHmqxk3VDPxtJNFWVvTdu1hNRga+y04emU2sA7iA830UZJfnMnNf6A7a3jAP/NxoLvyfuGwQnv/T+vYv69YH6TjEyPeCTX7z+IQ0mxIEpDvI9Xnbi/FgS4PNYrILAo247TOSNvThhXyRmJFKSe64f/eG9l9b000Nc2KiGHFZO4V4KC+IT8DUA5CuyWJuLbtWCMxTvpiPEBgHDrVKVDQYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aBMPuYUj8fRAjWvXgxXWpcBIMEuiWNlpWfW7CoA3Z4=;
 b=n1Mue5rKScX5sZVvwaw/pogN2k76yQLKFT/HXN8mh9w/cjRAQ8CoCAx7phVt0nJRsl+m0goCuWI0JSnCNZustc9uReMlSWTstnja+i6ID0LgJ0EJaHME8hBtIb99UsEzfsb9J63OflY4CQN9ioQFXD04TpllPKn0toemliBdkHZowtysg8GXi8JM/L/0Bja5KPJf77aaS4AroNxCpBQM1z0yyFBzu+Zgm54+9Wk2FlU2LPq4fCkwOhpUDQF8ilL2AYtJECNjUVxUi7aiAUWidv9SFq77GoLAvOk4j1Vc7nBs9iDpSWhC6o9yBis9UBPjZnjv6wAKzPNJgxNVNjmq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by PH7PR19MB7827.namprd19.prod.outlook.com (2603:10b6:510:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 11 Feb
 2026 10:20:24 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%6]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 10:20:23 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHci3OTfavL55cpn0GxBxzt32qlHbVk5SyAgBh9shA=
Date: Wed, 11 Feb 2026 10:20:23 +0000
Message-ID: <DM6PR19MB3564F2D3D5466B57EE018658F563A@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
 <20260122074906.127942-5-pravin.bathija@dell.com>
 <CAO55csy0oikG_HxUeqnU7tMvg+mjCdXP3uEUq7vUNsx8DgBGNw@mail.gmail.com>
In-Reply-To: <CAO55csy0oikG_HxUeqnU7tMvg+mjCdXP3uEUq7vUNsx8DgBGNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-02-11T09:57:51.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|PH7PR19MB7827:EE_
x-ms-office365-filtering-correlation-id: 8399e798-79ba-47a5-5826-08de69572af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|786006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?VzAxaHI0emg5Z0UveFhRY1JkYVlpZkgrLTZnUmkxbEtWUVZKS0FqTGlDUVJR?=
 =?utf-7?B?WHZIclJNN1N4ZzdPWGI3d21oKy1uVFVEbVdaMWcwZUtySnBQMFI0WnoyM1Q=?=
 =?utf-7?B?SCsteVg2M3c2Q3lrZUdqeW5yc3lObi93bXZEZ0xBZWg3V0VVMkVRVzZ0OU1U?=
 =?utf-7?B?Z1kyQjcyazdyNUZHTlBHMjRUZHRISistdE41Zjc5alJSelNnQVZzd3ErLUNE?=
 =?utf-7?B?dmd0MUNFS3dSeVdEcE5RMy9valdoT0ZjZ0FsUzNjeTZNSXhuUSstR2IxeFBF?=
 =?utf-7?B?VTVXc0FSd3BmbnpyZEF4R1Z1aDFKbjA3c1FBb0U5SVUxSGRZTUtVQ3V6OEh2?=
 =?utf-7?B?ZzZwM3dZZVRnckIveVo1WmZoZ3p4WWRjVjVOV3A5Ykt5NHZzemNTYTBlWXg2?=
 =?utf-7?B?THo2UzNzTXlGeE9MSU4wcWNieDJaYlBFSEp1NlpCSFd1cDhWNDg1ODcybERq?=
 =?utf-7?B?d3JJdGEvRE1kOUdQc2wvQkpDQUJhelpjak44NlBQZEgzakx6UHdwVTFoemo4?=
 =?utf-7?B?OGNkQ1l3cEdibFY2bmtBbngxUWdRWm5IS3cyQUhaUmpGekNyQzlPQ1E5Q0pQ?=
 =?utf-7?B?Y2RaRExJcUlDTGIrLTN0SUFlVi8xb1FkUFFWYmdFZ0t0RnlVdklwTFkvanhn?=
 =?utf-7?B?Ukt1Vng2bE5DSGo4UE10eXROZGg3VkNqU0g2SzRseXgySlFzdXZVS2JrbjZp?=
 =?utf-7?B?TC9YV3ROZnliSWVYek8xT2ZDd3BMcDAvVkp6U2dkUUNxMVVZcEg3cXVWNWpN?=
 =?utf-7?B?TEJiVkN1ODgzR3JJWUZvQ080T2YxKy04cnp0MnNDb2l6d21HSHdJOTRRdTFn?=
 =?utf-7?B?TjRUQTk3YWt3Ky00NC9UYjBlKy04VHo2dHpCeFdqUnZvUWNQTkcvaDY1alQ=?=
 =?utf-7?B?ODArLUo2V29pWXo2UFJNdjRhZGFUKy1DZWU5WTNlSWJma29VMHhqWU5HTVg=?=
 =?utf-7?B?cU4rLXlYS1Z2WjFSQlhPTU9pRVNvRnNmdUlUVlhORG1WSTZPdGRBWWFhRjI3?=
 =?utf-7?B?aGhySGFTOEhmRkRyQXk0aWt2NXlza0dKNFRkeEJMOHhhMnRTbE5BQWRqU2lj?=
 =?utf-7?B?OTl2Ky1OUUVSeDkyYWtKSmtZT1B1U1ZPZE1JNVA5L0hLei9QRkZBdFl2eFZv?=
 =?utf-7?B?dW1QWG1Gak1OT28rLWxzWlpORnczVTNmODJJU1REbGdONlRYNUhKYklKV3NM?=
 =?utf-7?B?dDNwZmgxb2dMeW9LUlp0c3JDUlFrYXNFOUxYKy1nQnlvSm5VY0xYTHBySURs?=
 =?utf-7?B?WGJlcWVJL3NuTzkzSm9WaERJSVhGWnZLbjAzRHdDMkdudVNHUjJzS29lM0Rh?=
 =?utf-7?B?eTFmV1dHZWNYV25UR0dOckhNSVdCKy1WcmN0R3ZsL2JqVVhRUGhRdFZUdHlR?=
 =?utf-7?B?QUlIREU0c0pFT0lESVJDRFMxY2Y1Z1lVUElmV1VtVjZzZ1RUSlJuRUZYejZC?=
 =?utf-7?B?azJXSWoyMllUdFJKSExYbTc0bHhLR2N4RmVVV20rLVU3Ykl4elM4Uml2M0hC?=
 =?utf-7?B?ZjBkQWJmVnJZVmk1SXpFVXc3dFlSQ3NnTkw4V3ljcWIvVUhTSC9POWxwUTE5?=
 =?utf-7?B?bHFPRVkrLUJBYncwRksvd3NMTVV2VjhxQ2tZZDF5RWFQYnhpamFzeG9kS2gv?=
 =?utf-7?B?dU1NTFdNOEg5WDUyT2RFNmlscE1lYnNyeWtPZFkzWXJLZFNxMFVUbmVESVI1?=
 =?utf-7?B?R09jaEFxanFBdEtNTTRBSC8yNzEzblZIQVUrLTR0MEJIV1VxQlEyRUpxVndK?=
 =?utf-7?B?bGhPOHRJY2R6SjNuMkRZZElQOGtBQ0hYaVV3QzQrLU5ybG1HS0dXMFprTG5n?=
 =?utf-7?B?YWE2MXVTR0RSRkJDZUJJakpmMVFJU1Rab08xdzJ1MEN6VnphYistRTdZU05p?=
 =?utf-7?B?eUFHbjBXbXNZVmZtdGRCSU4vT1BHVER4Ky1YeDZlZHBNYVJrcnkzcEpZYzhU?=
 =?utf-7?B?Wm1HR1BPaWJmNG9yaE9UKy1GMHZLMlRoSmpaS2s3UWdrTjEwNlY0MjBiMXlI?=
 =?utf-7?B?MjNDcTh0SmxzV1ZEZGpleUxXQktHeW1ZVVpQYjlMV2owaEk0ejhGVHZGWVV1?=
 =?utf-7?B?TC90blhlMXpQUHJ3bjh4SVRSbjJqQistUTRlbkY1TEZRM3ZUR1NLTTNUc29p?=
 =?utf-7?B?TVBxKy1NNmZYeEFXeDM5ZkwyejF3dnF6Umx1QTFyUXNtdVpMNjF4VU9kQWV6?=
 =?utf-7?B?V1VyU0t3RlMwN2g5Nk5WOSstSFNBdTdwdDNzc0FiMjdHU2JxT2hNZlkrLUJk?=
 =?utf-7?B?aEhsOWxBemNRK0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?Yzl5Q0RXYTJqU1MyM25tKy0zRnRXcXBvTi94U2RDUDBNTjFHeVRCeWdwSmc=?=
 =?utf-7?B?Ky0yUW85b3V3Tnl6Vno3cDZlSFpFVGZXOVFPMWN4cEI4LzRqKy02RkxwVUxD?=
 =?utf-7?B?UTRSaE55Ky1lRE9ZbVNtemFJT0dnR1BWTEhBbVdkdUtRcjZ6TlVGVDZqY3Rx?=
 =?utf-7?B?c1NzdlhZc3dHUmFDbTZKY1UzbkRuUTN5OU5rbWkyRWZuTTVKdmN5MHRVWk1U?=
 =?utf-7?B?SXJCV29xMjR1NzRqbHA2eFFpL0w5RVB6RzArLUxRbnkxT0R5N2EyMzlMeXky?=
 =?utf-7?B?MzRHSVR1Rm9PREgwZTY0QlRiZjdCVERDQVEyUXVPcXlkcSstcEpiM1JpR1F1?=
 =?utf-7?B?emhZKy05ak0vMjczT001SlNNdUtjTllpZXFpUjA3Zjl1N3FpVVdLYk1KMXhv?=
 =?utf-7?B?TGNJT2RhNjNxV1E4Yko4aystbERRR1FQUVg2THlJVUhkTjlxSWtHTkZ0Q3VQ?=
 =?utf-7?B?dW0yS3BmQW5hTE9NWC9lSUNxdmJKTDhWai9LUWJTVS9SbFlPMG1jcTlkbWkx?=
 =?utf-7?B?WmVsbmYxSGpDNlFnUmt1c0xSY0NGZWpvclNJOVBpaU1DaHIwR2QyVEh6NHp0?=
 =?utf-7?B?WXlGeTBNNHRnOG0wcU93MUpSTmpQSXJ2ZEZsVnR5VzhPTjlIKy0yUk9ybHE=?=
 =?utf-7?B?Ky12elhuS3NDWUZWRXV3M0sweXE2NkxIeFJEOXV5N1R0MTJ5bXZQRGdraXdh?=
 =?utf-7?B?MkJiaUhwSUppcDRpMTVtb01VeDIrLWV3ZWVJSkxaNExWUExMdmtxZW9XTFFF?=
 =?utf-7?B?RnNXTkk1REE4L0NuZElDelN0UHJRV0ViaUVaYVd3MFJCMTFzRjJQYW4rLXBZ?=
 =?utf-7?B?SzVuWERkbmQ0UistR2JpYzUwU09yWjVxNTBzeUhrZnNtLzZ4ZHdVTFFBV0Ew?=
 =?utf-7?B?RTBReHNrY1Y5VEhUYXhESEREd2R0aEMxanpuNk8yS0VnSWNDb1NJRVpqMXVC?=
 =?utf-7?B?WVIrLTFxZ1dqT0FSekxZaDdpOWRic1ZxS0FnZTNqT1h0a2NtaWF6SUhLbm1R?=
 =?utf-7?B?ZVNZZnRzSGFFRGQ3SHROZUZVYk1pOWYxOVFHcFlCNTZqTGZlWWVlR1dSNElS?=
 =?utf-7?B?dWJJM3RFTU9VYjNBNystSnJVb1lhNzBod01FRWtiM3F2SFpGWEVyNEkzaDdq?=
 =?utf-7?B?WGFacHhoRkFYWVUyUlI2dDZSTTJwU1hkaWE1dGxTaGppbUxJR2lRNnJob1ZP?=
 =?utf-7?B?Mi9xWlB0eVRCcUZEOXBBMG4vSHNTSGltWlRPTistUU0wM21vUjBQa0RZdWpu?=
 =?utf-7?B?aE1QOFpEeWVtMHNscmtPTjVFNWNRVzZpdnZEcUQ4Wkp0Q1U0aTVOVENJcjQ1?=
 =?utf-7?B?OUxpaTFsTEJsRk43aGNxSlVwU1d4WGJ5bSstWjVqKy01RGZyZk83OWtjWmd4?=
 =?utf-7?B?TXVtVThtL3J5VDVxRmtrVHMyZS8rLTA2RVp5c2o2RGUwY3V3TlM4ZmpWQ3pa?=
 =?utf-7?B?NXZVY0hOcDB2bFJzS1pTb2ZXbEVLY2NEc1V5R1YxQmxtNHRmM0hpVUlVbEVQ?=
 =?utf-7?B?WklJbGJza2hqUHRDdEJMM2FvMFBPM0dwM0RNbS9RNSstNzRNVmpNUHJtWnZT?=
 =?utf-7?B?aXE0eEhLQ3k4VnUwNWZTNUhyWDdyZlIzL0hCVUx3VlB1ck5xdFgyY3k4Ni9S?=
 =?utf-7?B?cTRxZWNMam1Oc3ZIb3prNHZ1a2RJS2paY2dSV0tKd2UrLUN1NjAzd1lwUHVF?=
 =?utf-7?B?VUdWZ1gvck1KYVh5TGl6dlQzTFBaRVlUV2xpbjBJdVFRKy1DMURwMk95VFlR?=
 =?utf-7?B?Rk9MenEwN09qSkRCelAwczdnOTFXQkZxWVo2ekdoTTJZYkQwdU93YkpvWWRi?=
 =?utf-7?B?V0U0SFpUaG4vbURxenFNNm5UNkF6UkV4ellSSzNFV0xRRUFSVHpUNlc2RjNE?=
 =?utf-7?B?YThENVY2YUJxN0dVU0szNFpFQjBjVnVOSFpxTmdzTmE5cG94T3dyaWFtVXNU?=
 =?utf-7?B?cHRzaEdpdVRlMGV2ckhERXRaLzh1U0g1bzZoT2JOOGluakFvWWZ0RGxCaU1L?=
 =?utf-7?B?cjEwdEloNlMwWXJqMkV3c1k3azVBVURESWpSUXN2Ky1MSGV4UVVlRDhFOCst?=
 =?utf-7?B?Ynk0Rm1kVHp0SzBOSDdNVXI3SDJMKy1la2tiQTlKVmJjWHhKVURkUzB6SkJn?=
 =?utf-7?B?ZUQzOVZKN1FPWU5sNmdYZ1JYNlQ5d0F1ZWNGdWZtVXdUeFhmdEhoYTQ5Uklr?=
 =?utf-7?B?Ky1YUncxL3lQYktxQnhkcDN3SU9ZWTlIclh2NEdmM3YyYmF2M0RJdWlBdklh?=
 =?utf-7?B?RXN3d2NMbGxvMDFodHhpeTR1dEtUSHpQV1ZNQjlVOGJhZENEUTBrZ2VZb0k=?=
 =?utf-7?B?Ky15a09MaEN0LzlmaUhoLzVoenpvdWV3aElJeng4MXp2OTh0VVpPRGIxTmtk?=
 =?utf-7?B?ekFBWllHR2tDeC9NUFB4bjk5RU0rLVpKOUErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8399e798-79ba-47a5-5826-08de69572af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 10:20:23.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpfeEH8Y+rZMlUT0+wDLiMrAcyKSK4uuQisxPEwMYQ0aJs1uE22jqgj4nFhtBn8NJaDYLw8Kfsy4EihKoe9Lmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110084
X-Authority-Analysis: v=2.4 cv=PvOergM3 c=1 sm=1 tr=0 ts=698c57ed cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=XlRjxQ70AAAA:8
 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=8O-JypFOpi9Rciy5FL4A:9
 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=1uMOUU2w0DxzEe95gQqD:22 a=7k9nRlTqVbDGZ3p5_T00:22 a=h7YW-pclpbZRD8svLbQ0:22
 a=oxySFUAvEW1-6AXleBSr:22
X-Proofpoint-ORIG-GUID: 14gxf_gu4sR1hs0qtPfGr0-1pLyTU1SV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NCBTYWx0ZWRfX+EKwG6Y9pn/s
 0oOtN7c0FrJN3mbQIF5iCQJgEhcly8RbMi1Zhq+BG/BKhkxUKHqpeq6DUigQ7SF5wQc9JkcAzYC
 y+iP2Mq6KiLYxHXwAPRiajDdpAg2yCeqkRbD8MgmgGo3VS0xGIJNj/RFmksM4aoTqcQVsMeiOR0
 wMaEf8vtn/EA1REsIphqC5qv5Vwq9s77FRhgDClMERthwO/FP1ydXMOc48zRKv86obDQKaOuqlN
 L9lz/vq+f/uJgw1CrI+ylRybDGFd8pyt8o9+q4dGBIisXcX4uMA5E1S8vem+SvZb0/nE0XIWFhF
 fgRJM6gS1PiRSLS3VVMjPSFOVkH/7bb81DaJoKxWmf9ax8yZLa9JbzBaFY6SlEDgutxJNi8eFYz
 5DXpE/vD5IKMOFpgAq2xAwHnB8XwRlcfsgyu3KAnTRpmFLSKK/01IW3kHotg6MC4FHCGF3kFvef
 AFHuJDKd0QhF1JndU+Q==
X-Proofpoint-GUID: 14gxf_gu4sR1hs0qtPfGr0-1pLyTU1SV
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110084
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

Answers inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Monday, January 26, 2026 11:58 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- Subject: Re: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Function defs for=
 add/rem mem
+AD4- regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On Thu, Jan 22, 2026 at 8:49+IC8-AM +ADw-pravin.bathija+AEA-dell.com+=
AD4- wrote:
+AD4- +AD4-
+AD4- +AD4- From: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD4-
+AD4- +AD4-
+AD4- +AD4- These changes cover the function definition for add/remove memo=
ry
+AD4- +AD4- region calls which are invoked on receiving vhost user message =
from
+AD4- +AD4- vhost user front-end (e.g. Qemu). In our case, in addition to t=
esting
+AD4- +AD4- with qemu front-end, the testing has also been performed with l=
ibblkio
+AD4- +AD4- front-end and spdk/dpdk back-end. We did I/O using libblkio bas=
ed
+AD4- +AD4- device driver, to spdk based drives. There are also changes for
+AD4- +AD4- set+AF8-mem+AF8-table and new definition for get memory slots. =
Our changes
+AD4- +AD4- optimize the set memory table call to use common support functi=
ons.
+AD4- +AD4- Message get memory slots is how the vhost-user front-end querie=
s the
+AD4- +AD4- vhost-user back-end about the number of memory slots available =
to be
+AD4- +AD4- registered by the back-end. In addition support function to inv=
alidate
+AD4- +AD4- vring is also defined which is used in add/remove memory region=
 functions.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  lib/vhost/vhost+AF8-user.c +AHw- 234
+AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-------
+AD4- +AD4-  1 file changed, 202 insertions(+-), 32 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- e2831b7625..1a2dcfbbca 100644
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
 -1520,7 +-1523,6 +AEAAQA-
+AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net +ACoAK=
g-pdev,
+AD4- +AD4-         struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4-         struct VhostUserMemory +ACo-memory +AD0- +ACY-ctx-+AD4-=
msg.payload.memory+ADs-
+AD4- +AD4-         struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- -       int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4-         uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4-         uint32+AF8-t i+ADs-
+AD4- +AD4-         bool async+AF8-notify +AD0- false+ADs-
+AD4- +AD4- +AEAAQA- -1565,39 +-1567,13 +AEAAQA- vhost+AF8-user+AF8-set+AF8=
-mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-                 if (dev-+AD4-features +ACY- (1ULL +ADwAPA- VIRT=
IO+AF8-F+AF8-IOMMU+AF8-PLATFORM))
+AD4- +AD4-                         vhost+AF8-user+AF8-iotlb+AF8-flush+AF8-=
all(dev)+ADs-
+AD4- +AD4-
+AD4- +AD4- -               free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-               free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-                 rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-                 dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-         +AH0-
+AD4- +AD4-
+AD4- +AD4- -       /+ACo-
+AD4- +AD4- -        +ACo- If VQ 0 has already been allocated, try to alloc=
ate on the same
+AD4- +AD4- -        +ACo- NUMA node. It can be reallocated later in numa+A=
F8-realloc().
+AD4- +AD4- -        +ACo-/
+AD4- +AD4- -       if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- -               numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF=
0--+AD4-numa+AF8-node+ADs-
+AD4- +AD4- -
+AD4- +AD4- -       dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- -       if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- -               dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4- +AD4- -               dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+=
AF8-socket(NULL,
+AD4- +AD4- -                                       dev-+AD4-max+AF8-guest+=
AF8-pages +ACo-
+AD4- +AD4- -                                       sizeof(struct guest+AF8=
-page),
+AD4- +AD4- -                                       RTE+AF8-CACHE+AF8-LINE+=
AF8-SIZE,
+AD4- +AD4- -                                       numa+AF8-node)+ADs-
+AD4- +AD4- -               if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AH=
s-
+AD4- +AD4- -                       VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifnam=
e, ERR,
+AD4- +AD4- -                               +ACI-failed to allocate memory =
for dev-+AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- -                       goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- -               +AH0-
+AD4- +AD4- -       +AH0-
+AD4- +AD4- -
+AD4- +AD4- -       dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhos=
t-mem-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- -               sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region)=
 +ACo- memory-+AD4-nregions, 0,
+AD4- numa+AF8-node)+ADs-
+AD4- +AD4- -       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- -               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, =
+ACI-failed to allocate memory
+AD4- for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- -               goto free+AF8-guest+AF8-pages+ADs-
+AD4- +AD4- -       +AH0-
+AD4- +AD4- +-       if (vhost+AF8-user+AF8-initialize+AF8-memory(pdev) +AD=
w- 0)
+AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4-
+AD4- +AD4-         for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i=
+-+-) +AHs-
+AD4- +AD4-                 reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+=
AF0AOw- +AEAAQA- -1661,11 +-1637,167 +AEAAQA-
+AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4-
+AD4- +AD4-  free+AF8-mem+AF8-table:
+AD4- +AD4- -       free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-         rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-         dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +-       rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-       dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-close+AF8-msg+AF8-fds:
+AD4- +AD4- +-       close+AF8-msg+AF8-fds(ctx)+ADs-
+AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs- +=
AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(struct virti=
o+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +ACo-ct=
x,
+AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-unused=
) +AHs-
+AD4- +AD4- +-       uint32+AF8-t max+AF8-mem+AF8-slots +AD0- VHOST+AF8-MEM=
ORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8-t)max+AF8-m=
em+AF8-slots+ADs-
+AD4- +AD4- +-       ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-msg.payload.u6=
4)+ADs-
+AD4- +AD4- +-       ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-REPLY+ADs-=
 +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static void
+AD4- +AD4- +-dev+AF8-invalidate+AF8-vrings(struct virtio+AF8-net +ACo-dev)=
 +AHs-
+AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF8-vring+ADs-=
 i+-+-) +AHs-
+AD4- +AD4- +-               struct vhost+AF8-virtqueue +ACo-vq +AD0- dev-+=
AD4-virtqueue+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-               if (+ACE-vq)
+AD4- +AD4- +-                       continue+ADs-
+AD4- +AD4-
+AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +-               if (vq-+AD4-desc +AHwAfA- vq-+AD4-avail +AHwAf=
A- vq-+AD4-used) +AHs-
+AD4- +AD4- +-                       /+ACo- vhost+AF8-user+AF8-lock+AF8-all=
+AF8-queue+AF8-pairs locked all qps +ACo-/
+AD4- +AD4- +-                       VHOST+AF8-USER+AF8-ASSERT+AF8-LOCK(dev=
, vq,
+AD4- +AD4- +- VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +-                        +ACo- If the memory table got updated=
, the ring addresses
+AD4- +AD4- +-                        +ACo- need to be translated again as =
virtual addresses have
+AD4- +AD4- +-                        +ACo- changed.
+AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +-                       vring+AF8-invalidate(dev, vq)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       translate+AF8-ring+AF8-addresses(+ACY-=
dev, +ACY-vq)+ADs-
+AD4- +AD4- +-               +AH0-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev,
+AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +ACo-ct=
x,
+AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-unused=
)
+AD4-
+AD4- The parameter is marked as unused but is actually used.

I have made the corrections in the amended patch-set I will submit followin=
g this e-mail.

+AD4-
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       /+ACo- convert first region add to normal memory table=
 set +ACo-/
+AD4- +AD4- +-       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-               if (vhost+AF8-user+AF8-initialize+AF8-memory(p=
dev) +ADw- 0)
+AD4- +AD4- +-                       goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       /+ACo- make sure new region will fit +ACo-/
+AD4- +AD4- +-       if (dev-+AD4-mem-+AD4-nregions +AD4APQ- VHOST+AF8-MEMO=
RY+AF8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,=
 +ACI-too many memory
+AD4- regions already (+ACU-u)+ACI-,
+AD4- +AD4- +-                                                             =
          dev-+AD4-mem-+AD4-nregions)+ADs-
+AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       /+ACo- make sure supplied memory fd present +ACo-/
+AD4- +AD4- +-       if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,=
 +ACI-fd count makes no sense
+AD4- (+ACU-u)+ACI-, ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       /+ACo- Make sure no overlap in guest virtual address s=
pace +ACo-/
+AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+=
AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+A=
F8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-mem+AF8-regio=
n +ACo-current+AF8-region +AD0-
+AD4- +AD4- +- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                       if (current+AF8-region-+AD4-mmap+AF8-s=
ize +AD0APQ- 0)
+AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       uint64+AF8-t current+AF8-region+AF8-gu=
est+AF8-start +AD0- current+AF8-region-
+AD4- +AD4-guest+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-                       uint64+AF8-t current+AF8-region+AF8-gu=
est+AF8-end +AD0-
+AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                             =
  +- current+AF8-region-+AD4-mmap+AF8-size - 1+ADs-
+AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-region+AF8-g=
uest+AF8-start +AD0- region-
+AD4- +AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-region+AF8-g=
uest+AF8-end +AD0-
+AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +-                                                             =
  +- region-+AD4-memory+AF8-size - 1+ADs-
+AD4- +AD4- +-                       bool overlap +AD0- false+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       overlap +AD0- +ACE-((proposed+AF8-regi=
on+AF8-guest+AF8-end +ADw-
+AD4- current+AF8-region+AF8-guest+AF8-start) +AHwAfA-
+AD4- +AD4- +-                               (proposed+AF8-region+AF8-guest=
+AF8-start +AD4-
+AD4- +AD4- +- current+AF8-region+AF8-guest+AF8-end))+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       if (overlap) +AHs-
+AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG(dev-+=
AD4-ifname, ERR,
+AD4- +AD4- +-                                       +ACI-requested memory =
region overlaps with another
+AD4- region+ACI-)+ADs-
+AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG(dev-+=
AD4-ifname, ERR,
+AD4- +AD4- +-                                       +ACIAXA-tRequested reg=
ion address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                       region-+AD4-userspace+=
AF8-addr)+ADs-
+AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG(dev-+=
AD4-ifname, ERR,
+AD4- +AD4- +-                                       +ACIAXA-tRequested reg=
ion size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                       region-+AD4-memory+AF8=
-size)+ADs-
+AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG(dev-+=
AD4-ifname, ERR,
+AD4- +AD4- +-                                       +ACIAXA-tOverlapping r=
egion address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                       current+AF8-region-+AD=
4-guest+AF8-user+AF8-addr)+ADs-
+AD4- +AD4- +-                               VHOST+AF8-CONFIG+AF8-LOG(dev-+=
AD4-ifname, ERR,
+AD4- +AD4- +-                                       +ACIAXA-tOverlapping r=
egion size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +-                                       current+AF8-region-+AD=
4-mmap+AF8-size)+ADs-
+AD4- +AD4- +-                               goto close+AF8-msg+AF8-fds+ADs=
-
+AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-               +AH0-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       /+ACo- find a new region and set it like memory table =
set does +ACo-/
+AD4- +AD4- +-       struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg +AD0-=
 NULL+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+A=
F8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-               if (dev-+AD4-mem-+AD4-regions+AFs-i+AF0-.guest=
+AF8-user+AF8-addr +AD0APQ- 0) +AHs-
+AD4- +AD4- +-                       reg +AD0- +ACY-dev-+AD4-mem-+AD4-regio=
ns+AFs-i+AF0AOw-
+AD4- +AD4- +-                       break+ADs-
+AD4- +AD4- +-               +AH0-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-       if (reg +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,=
 +ACI-no free memory region+ACI-)+ADs-
+AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       reg-+AD4-guest+AF8-phys+AF8-addr +AD0- region-+AD4-gue=
st+AF8-phys+AF8-addr+ADs-
+AD4- +AD4- +-       reg-+AD4-guest+AF8-user+AF8-addr +AD0- region-+AD4-use=
rspace+AF8-addr+ADs-
+AD4- +AD4- +-       reg-+AD4-size            +AD0- region-+AD4-memory+AF8-=
size+ADs-
+AD4- +AD4- +-       reg-+AD4-fd              +AD0- ctx-+AD4-fds+AFs-0+AF0A=
Ow-
+AD4- +AD4- +-
+AD4- +AD4- +-       if (vhost+AF8-user+AF8-mmap+AF8-region(dev, reg, regio=
n-+AD4-mmap+AF8-offset) +ADw- 0) +AHs-
+AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,=
 +ACI-failed to mmap region+ACI-)+ADs-
+AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       dev-+AD4-mem-+AD4-nregions+-+-+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-=
is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +-               async+AF8-dma+AF8-map+AF8-region(dev, reg, tru=
e)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       if (vhost+AF8-user+AF8-postcopy+AF8-register(dev, main=
+AF8-fd, ctx) +ADw- 0)
+AD4-
+AD4- Post-copy live-migration is broken.
+AD4- The assumes the vhost-user message is of type SET+AF8-MEM+AF8-TABLE, =
and so
+AD4- assumes ctx contains a VhostUserMemory payload.
+AD4- But here ctx contains a VhostUserMemoryRegion payload.
+AD4-
+AD4- Given the complexity of the patch, it is worrying that such issues ar=
e
+AD4- overlooked.
+AD4- What other features could be broken?

Although I tested this before I have again tested Post-copy live migration =
successfully with qemu using the following steps.
- Ran dpdk-testpmd while enabling poctcopy migration as option.
- Ran two instances of qemu, source and destination. Source was running alp=
ine linux while destination was started with option +ACI--incoming defer+AC=
I-
- I did an add memory region at the source VM which invoked vhost+AF8-postc=
opy+AF8-register function. After this I did the same add memory region for =
destination VM.
- The +ACI-post+AF8-copy+AF8-register+ACI- debug messages which I added in =
this upcoming patch-set were correctly seen on the testpmd console.
- Following this I turned on migrate capabilities on source and destination=
 VMs at qemu prompt. For destination VM I also set the incoming migration t=
o TCP port 4444.
- Set the +ACI-migrate+ACI- destination to host 127.0.0.1 TCP port 4444 and=
 invoked command +ACI-migrate+AF8-start+AF8-postcopy+ACI-

After the above steps, the Alpine Linux VM memory pages were correctly migr=
ated to destination VM. I would be happy to share console logs of the above=
 test and step by step commands.

Source code clarification: In the function vhost+AF8-user+AF8-add+AF8-mem+A=
F8-reg we provide the argument of a single region of type +ACI-VhostUserMem=
oryRegion+ACI- in the message payload. This single memory region is then co=
nverted to type  rte+AF8-vhost+AF8-mem+AF8-region (variable reg line+ACM-17=
61) and then added to the list of memory regions using the call vhost+AF8-u=
ser+AF8-mmap+AF8-region(line+ACM-1779). By the time, vhost+AF8-user+AF8-pos=
tcopy+AF8-register(line+ACM-1794) is called, the newl added region is part =
of the +ACI-dev+ACI- structure.

+AD4-
+AD4- +AD4- +-               goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       dev+AF8-invalidate+AF8-vrings(dev)+ADs-
+AD4- +AD4- +-       dump+AF8-guest+AF8-pages(dev)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-free+AF8-mem+AF8-table:
+AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +-       rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +-       dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-         rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4-         dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4-  close+AF8-msg+AF8-fds:
+AD4- +AD4- +AEAAQA- -1673,6 +-1805,44 +AEAAQA- vhost+AF8-user+AF8-set+AF8-=
mem+AF8-table(struct virtio+AF8-net
+AD4- +ACoAKg-pdev,
+AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs-  +=
AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg(struct virtio+AF8-net =
+ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-context +ACo-ct=
x +AF8AXw-rte+AF8-unused,
+AD4-
+AD4- pdev and ctx are actually used.

I have made the corrections in the amended patch-set I will submit followin=
g this e-mail.

+AD4-
+AD4-
+AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rte+AF8-unused=
) +AHs-
+AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +AD0-
+AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.region+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- dev-+AD4-mem-+=
AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+A=
F8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-mem+AF8-regio=
n +ACo-current+AF8-region +AD0-
+AD4- +AD4- +- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-
+AD4- +AD4- +-                       if (current+AF8-region-+AD4-guest+AF8-=
user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +-                        +ACo- According to the vhost-user spe=
cification:
+AD4- +AD4- +-                        +ACo- The memory region to be removed=
 is identified by its guest
+AD4- address,
+AD4- +AD4- +-                        +ACo- user address and size. The mmap=
 offset is ignored.
+AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +-                       if (region-+AD4-userspace+AF8-addr +AD=
0APQ- current+AF8-region-+AD4-guest+AF8-user+AF8-addr
+AD4- +AD4- +-                               +ACYAJg- region-+AD4-guest+AF8=
-phys+AF8-addr +AD0APQ- current+AF8-region-
+AD4- +AD4-guest+AF8-phys+AF8-addr
+AD4- +AD4- +-                               +ACYAJg- region-+AD4-memory+AF=
8-size +AD0APQ- current+AF8-region-+AD4-size) +AHs-
+AD4- +AD4- +-                               if (dev-+AD4-async+AF8-copy +A=
CYAJg- rte+AF8-vfio+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +-                                       async+AF8-dma+AF8-map+=
AF8-region(dev, current+AF8-region, false)+ADs-
+AD4- +AD4- +-                               dev+AF8-invalidate+AF8-vrings(=
dev)+ADs-
+AD4- +AD4- +-                               free+AF8-mem+AF8-region(curren=
t+AF8-region)+ADs-
+AD4- +AD4- +-                               dev-+AD4-mem-+AD4-nregions--+A=
Ds-
+AD4- +AD4- +-                               return RTE+AF8-VHOST+AF8-MSG+A=
F8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +-               +AH0-
+AD4- +AD4- +-       +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-       VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +ACI-fa=
iled to find region+ACI-)+ADs-
+AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8-ERR+ADs- +=
AH0-
+AD4- +AD4- +-
+AD4- +AD4-  static bool
+AD4- +AD4-  vq+AF8-is+AF8-ready(struct virtio+AF8-net +ACo-dev, struct vho=
st+AF8-virtqueue +ACo-vq)  +AHs-
+AD4- +AD4- --
+AD4- +AD4- 2.43.0
+AD4- +AD4-

