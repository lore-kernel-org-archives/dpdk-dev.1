Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAEDD3CC9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 08:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 370874026C;
	Thu, 15 Jan 2026 09:02:28 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id B03574003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 09:02:26 +0100 (CET)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60ELdMqU028017;
 Thu, 15 Jan 2026 03:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=J
 te+VCFnEJDU8AFrknqTr4jIhsuITwACeUzn+X71Su8=; b=OCQRB/6grQgkkNi2Y
 5ieiKspxlZ9s2Nkgm5CDr8vF/w83DVhd4xG4c1r1M++0XW0WR1AKUADNm/Dye+Zj
 4qx+1JUnN60QkteiOyKbKXgcgPZvsiMjS2+TugmWJaDi+ZP82TMDnADi1grFLxZ4
 5nMIqRcwsUOIBmZcjWHXhSIzVOzVdaY7QBenKgJ5b7jKBENaN84ouxSmReXmnQJW
 7lVrDKGOkHuRHoxZUK+S9ggSP1OWV/p55BgmPAR/AdNbCC41aAyCWiIe0mrsy7NK
 Qa/Of0TC0mLe0V0tqBK8OhUHX6Cq1V2SOtbmuNNYuqykWHVDxHmuRddnp/PMCWZc
 2rOwA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4bkgqsn6g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 03:02:25 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F816P0026952;
 Thu, 15 Jan 2026 03:02:24 -0500
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4bp2vra8d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 03:02:24 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdU2m7RJ53OANxDQUKzm1XWGSNLjClZkJpGF5PcYy8pBpfj9BTUeGp0AqFFBNLPgZ6WpyF7H7+ExP/7LU5+X/bPEqtnFyTBsk5MS+AO6UA3cIs5hJqS1UOrwpDXkhNd5f+95nvWpqsVPKdOBdB34CI4V3Qz301NANYZMlzf6xrMPsD3Ri5/xoyUQHJDmrNC6RyfiFaAJRtvIKB3NrxMquTFSFRFOEf0j4Ifu8lvMgQjPLbPTZdyx0MVWpzc49TO48hFw88/rbsmGTNkDl8qtigVadP/R1udxAnU+4JWpsYZ6JSX3O7DFZD0MnJY5m/oqbqrkd/mnx6BRSxrIZkyn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jte+VCFnEJDU8AFrknqTr4jIhsuITwACeUzn+X71Su8=;
 b=GpbODG6b36Cj/bhoqHr8Y19d0wWLqyrtqsGi09ZBHBLlgBepSGuojEHrLZjqoosI+6YlrZUhAAsOW0hJ4JMyEUzJebNiWFjXBQOeUrKZ9lotAwngOsjNSNU7aptTAR0NGxZfHUbRKLpi9n0fB9jrgDeMqcN9BGhkqWFDvaNa2ou4oDPC8wBwCljveINAlqaTJ6n2pc+V9tCmVIOWx9e6Vp2KTZxrsc4iUZpla/k2A4RysWY+Fhyj5SlaZdXIvMe74oPjddy/927XQftNls4uVB2kDEftdx1fFmPvlvZaMEaHfre0AjNyRulxdYwuI3Y2BjX+fUVhGLsCSzIhjBKCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by SA0PR19MB4602.namprd19.prod.outlook.com (2603:10b6:806:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 08:02:18 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:02:18 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v5 2/4] vhost_user: header defines for add/rem mem region
Thread-Topic: [PATCH v5 2/4] vhost_user: header defines for add/rem mem region
Thread-Index: AQHcVJtLeCxcVlF6Xkag7xVyjEqZdbVFpCmAgA2ctOA=
Date: Thu, 15 Jan 2026 08:02:18 +0000
Message-ID: <SJ0PR19MB4606C6F61D8BBABEAA37A624F58CA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-3-pravin.bathija@dell.com>
 <7de5dd70-45c2-4a76-954d-19beef994e5a@redhat.com>
In-Reply-To: <7de5dd70-45c2-4a76-954d-19beef994e5a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-01-15T08:00:39.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|SA0PR19MB4602:EE_
x-ms-office365-filtering-correlation-id: 22c95e39-007f-4ca7-477c-08de540c678a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|786006|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?UlI5ZHBIU216M1JLa0kyYm56ZmtpYmNaYXd4eWpqdU4xbG1wbThZSystaEJ5?=
 =?utf-7?B?cGhaYzVOTjJpOFl1dFNNTzVIeTlobWhBRGhpb25UMGdvaVhJSDRmSXQvWEYv?=
 =?utf-7?B?TjJ4Ty9pelFqZHppQjJqc2dzbFdwb0tzdFU2TTZGMmZKZklHUG1NbFEyZUIy?=
 =?utf-7?B?dHpaV0tKT20zRFREaXNuQWhBc1h5QW54L0dJWkdKQ25PZHlQQXhEOUp6MU9p?=
 =?utf-7?B?SWpSd0dPRzRzM0xMVlVreTlQRENSdzA4cjI1UjcyWHI2QzQxVjZpTEVHdWxy?=
 =?utf-7?B?Sm44ZEY5am1selVpT3BFdGdFZ1hwOC95T3NiMystZ3pFRk53UG94YXdHNmxq?=
 =?utf-7?B?ZnRXNDBtcUJ5WkdZWTg0UXUrLVg1YTVLZGxHaDlqNCstdi9sUHcwU2pGbE05?=
 =?utf-7?B?QmZTdnA3bFVtZFFFaGhXRTFhakRTNUxuOFVBR2Eyb3NheEhOeldwLzkzQlRL?=
 =?utf-7?B?NUgxckpXRDQ3cm9TZUg3Yk4rLTJ0ZS9mVkxGTnkwWDNBSFVGL1JFVkt1STNw?=
 =?utf-7?B?QjN2bnJDUUJwL3BvWFNnTjI5V3A2eFZNZkdoY1h6ZUNnWUsrLTVFMHc4M280?=
 =?utf-7?B?ZWhkVElRN3k3TTZkaVhXNHJha2ZpaDRVZE9Fbm5zRG1tdnJycmtkYVQ5ZFhP?=
 =?utf-7?B?RUZyY3EvQmxLUlNtV1lmdDRkV0JIcUp6cWt0WEpuMXI1d1ZWcC91N3VjWUE0?=
 =?utf-7?B?bjJyV0Iyc29sd0NhcUtSb2Z4NVVQQmZ0TWVYUSsta1Ayd09CV3gzVTJpaFhU?=
 =?utf-7?B?NHRsMG5hSkp5dzRmdjZXTWdBYXV5R1M5MTlkNUpuTXNNMFEwbnRMWENYWEFn?=
 =?utf-7?B?MngvNDk2TGJ2dkp2VTJRUlVuaDVBd0xETTJadUV0a2dlcDI0LzdXRFcybnow?=
 =?utf-7?B?bUI3Q21HRURXRHZLWU14bzZNNUpyTGV5eENpM0hKN3RYbHQrLXF4cnhzMXJY?=
 =?utf-7?B?blBoVTcxVjRLMU1sMDVRKy0zNnhqSFZqN2xxdEFqMTEvOHZVWklGTUl5S3ov?=
 =?utf-7?B?S1MvVHJOYm1qTEg2dG1XS1dQbzZhekp6VVdpREgxKy1lbG9ieDgyWTZWcGtM?=
 =?utf-7?B?OHp1RTY4a1hKOFFpUVo1SGZjT21wc1BTc0lsaERzell2NFVIZXBPMFJ6RFo4?=
 =?utf-7?B?djFVZzY0UlRYQWl5MUF2RHVkTDUwazhhcU8vOVI3R1UyUEtMaU5LZlZiRW9r?=
 =?utf-7?B?UDBkb2RxVDFvc0E0aEFzYUZ3QXJTZU5GT2pRc0ZCcXNxKy0vY1g4UDFJbjdt?=
 =?utf-7?B?ZXJNczg5cjB6eFZoM3Nza3pjSVdvblZ5V29BQmZrNmdpcHpqZk9mOGhRbTUw?=
 =?utf-7?B?bCstenJhck5VdzlraEc2RXg4WWVTeVB0ZTlGTzJxKy1ZKy1JcUNDai9yTWtH?=
 =?utf-7?B?MWovSSstZFlhNUgxZ1hBVkNqYWV1TGZ1ZGk1TmxOYzNmVm4xZjJYKy0zcEVE?=
 =?utf-7?B?bHRFNkFObmxYVlFtd2h6WUFzaEhCYWgwZ04waDAwZ3hNQ01OSm9ZOWtGSXdH?=
 =?utf-7?B?SXRjcFRIbFpVTklyVWpHcHZQZ09DZXk5T1JxVnF1U1B5THYvT3RLY2N6dlFa?=
 =?utf-7?B?MTAyL3VPTnBadWt3TDY2TDVuSGFkRmltajF3OEhWbistRk1PUVg2OWxhVGMy?=
 =?utf-7?B?cG00cVNaQ3lnemRrLzZEWmRpYkh4L3YyS083MmplVVZDbk9jRHdmSE5JZGlo?=
 =?utf-7?B?Z2lUUkZndEsvemdNdVBqRTNyWmRXS1NGRzNvL1FUTnAwbWk2aVRNVkhpSU90?=
 =?utf-7?B?eHl5N1BWMUpyU1p4MEVMOUgxT0tVZ0RqdlZQaFhCVHJEcFJhSXhybFdYSll4?=
 =?utf-7?B?VGR3d2c2MWFOdGROa0t4Zm1PcVFNaG5scFBIazNQZHZpblNhdUhtYUhvd2RT?=
 =?utf-7?B?cUZvYkNiaXlhS1pUM1FJRUI4QmlWWlhNMEJFMXZmdTFSSDNzV3ZzQ1pqZXlj?=
 =?utf-7?B?WnlodVpvWVRIak9jWDNWL3NhQVlFREx3SXZ4dk1mdystQ1dDUjdvbUNoSlph?=
 =?utf-7?B?Z3BwNlg0SjJxazJWbHBSRzBFNFVVMmVDYUlQNkV6V3NhcnlpczczaGx6MDJ0?=
 =?utf-7?B?MWIwbFMvek9HV0wxQ3VReVBybDkzRTBoWkJZaDhkUUlvVlBoMUM3cCstSzZZ?=
 =?utf-7?B?L2lHYjhZTXpyZE1pSTNiVFZscDA4MU0xN1pRNXJtYXhWbXp3cms2Ky1tSFRQ?=
 =?utf-7?B?bFFMcUp0U3VMVlkxTU1rOWxhNVRQT0lIajk1SjRwaG5jVlBiRUNsRVJncw==?=
 =?utf-7?B?K0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?M0M3OXovcGNtMGc4bnN2WUdmeVhJc0VjRERTR0pQMzdITHd0UmMwYjVLT2hJ?=
 =?utf-7?B?dUh5U1N6WFFndDMvQWVDVSstV294VFdTMUt0TTU2c0E5RGJqd1hoT2FROGpF?=
 =?utf-7?B?ZmtPOHNmY3ptbGNISUIxaUttblV0WksrLWZCMzRqbTd5V2Jkb3ljZ3JEaHdz?=
 =?utf-7?B?bmFIMkFiVGtGdDlXQjhsNXVma0xFbVlVNXlPTVVTZzRpTE9RU2lOYXZOKy0=?=
 =?utf-7?B?Ky1OWWxvdjVaZnZLV1hqZWE0ZmcxaWVrcGVGcjZVeSstUi9lMmR4WWRUZndO?=
 =?utf-7?B?RzdLMjVST29rblhhRDRXZXViZUZ4a3ZyQmlNM3RWTzBGWFo3eHZHUGlHVFll?=
 =?utf-7?B?VWJiWFlPQzRXM2RDNUFrenpuRUt0Ky1BMlhWb2x5Ky1qUHBtWmh4MHJwMmp5?=
 =?utf-7?B?YjN4c3RuSUxZNVBlZzFOeUxLOFVRbWQ0Vko4UXBFaUxySGtKVW1SbGdVQ1JH?=
 =?utf-7?B?U2ZPbmVzQUYyMU5iZ2krLVpPSmlWa2N3eW9qKy1kcHFtTUZWVHhvSmdHR2R4?=
 =?utf-7?B?M3RVKy1HSGhXU2pkZXNyVkJxdFZvU0JlRDlBUE1WNnNFVnhGQWFOUS9SRWpZ?=
 =?utf-7?B?OGUzZ0Q0WHJmU1lzeVRFMm5TaFZmTERDKy0xUk9lRSstZUF4b3dQbXlQNWlw?=
 =?utf-7?B?aTJXVGs1dWN1amFwZHEzajFpcElLNGFJdndoQ2pLMG5zWU5uUnNPbTZqWjdz?=
 =?utf-7?B?aGQ5TFJSSHhSQjVmSHJzdlJqKy1zTjV1enJXS1l4ZlJkUmJoUnVJVUZ4QUNj?=
 =?utf-7?B?RW9pUlVwMHZTVG0ySElGMVdKMTkweGhGSFlyb2NrMzNQUFE4dXkyOTkwWHA=?=
 =?utf-7?B?Ky1oSFNoRFBxVHVvU2xySWxJZmE4Skgwa2lORXF5YVFockRKck9SOWZ5Ujgz?=
 =?utf-7?B?Z2w2QjZPRXpaRXh2TmVzMTVXa29HSjhzNmQ3a0l0TllwR3pBYU1IS1B3Q0JZ?=
 =?utf-7?B?eFNxODZ3UTcxVE9MQ1ZaQk9lYkhCYy9MVkpNcjJsM0h3UnJyZ2dIU2VTdHhG?=
 =?utf-7?B?Q0pqdUp3SDBWSWpPUlZ4L3V5NERpZjR3Qm9ITWhEVWFLWTIyTDVPUy92eSst?=
 =?utf-7?B?Mi90Q3pxaG9INU9MeXMvMEdQTnBjV2xXMkNPc295MmIzdWszMnNmVEtWOXM1?=
 =?utf-7?B?L0xZdDhSTC9yazdlNmdOenFrbGZMbHFxWUFBc3dJNUpYZ1lsVENFcWVHeUs5?=
 =?utf-7?B?aDdZdm05V29PcVdycVRqZE5PQXZEalpISDhHVWZ6dEVmKy0zQ080Y1VPYXUx?=
 =?utf-7?B?ZW43SFJia1JFWEVuem1NVnRPNlhhUGRaUlBHTjlGeFJiVkl4SmhuRThsRHpz?=
 =?utf-7?B?aW9WUnVGTHZYY2ZEbHBPYUFMNU83SUhzbistdng5ZWI1NTQ3NG5GcFVmT3Bm?=
 =?utf-7?B?N2VWQWhua3AzSnlqTFFGaEYzOENDejkzQ0UxZ2NWbGVReTd4WkhlNTFiNTF3?=
 =?utf-7?B?T1JYVkNkcTBjakZzOVRvZ0dOQjlyc0xNZ1FXb2t0ZDl1a09nRWNTL0xUVjFE?=
 =?utf-7?B?cnMyWTNWZ2wzL2hvZWkvRXRTNjV1ZDVaRXZoSkl4OEJ4NjFpbm9IOWhpVzRj?=
 =?utf-7?B?SmdPTjlmMXZSeS96cXlXVG1LSzdiVystcThsOXltSzIzYTdqbEpMMkE2cnBE?=
 =?utf-7?B?Nk1nSUtuUGRxZmJrdGIyR2JGNEViY0ZXL1RRSFlJdnVpbVk2VW9GNXNFSlNu?=
 =?utf-7?B?cjFsRnBwSlorLS9BZ3BiUkU4MlUyV0R5L3czT2VqMjFQbGFHcEZlRlJubkZN?=
 =?utf-7?B?L0VaTXAvSDdXeDBETTFJWk1NTkJDZWIyeEd2M0RpbHF6aDZUSHlyZXczeHJu?=
 =?utf-7?B?bVNCSy9vUHBpZ2tlanhaZklvR3ZVTURQNWNpM2taL3A4d2o1ekFieEd0ZHFp?=
 =?utf-7?B?aSstRDUvRm9pZDVocWZid2FHUnkzYXpHSTZhdncvcHpoL3QxR29FZlVVRWw0?=
 =?utf-7?B?dGtQZ2JNRUVpcDA3WGNhaFY0ajRsQ3ZFdUJlN01ZNHBiZG4zdGF5NW5sOFpD?=
 =?utf-7?B?WTlqTFI5QjgweCstbTNFNWg4bVBVUE9xNllVTlQ0c2k4dW1ha05veTBZRml5?=
 =?utf-7?B?c0VyMGlPUE5FMXdvWG5SMm0zNGxnTS9YeDJia2FoeHJXQjkwKy1COTFEc2xW?=
 =?utf-7?B?Z0p3S0lMZ2hzQ0drUFFYVlBuSXJBL20vck5scFV3cG5SN0pFZEgrLWp6N3pu?=
 =?utf-7?B?OGNZWVhQOXF4QU1hejh2ODNrYzVjbmFCcGYvWm10SlVJWlBJS1R0N3g4eGxN?=
 =?utf-7?B?eGRhYWxTWjlsRWpqZG41TDRqUEFsUGYwU2lpQm1WMld2RVVpVVdmRjVMWXlt?=
 =?utf-7?B?UkFqdzdyNEQ1M1F1N09jMVJYKy1MRWNqZGZoVm1KS2NnSTNWSUVRWUZQWkRL?=
 =?utf-7?B?c09ab1JxcDQyYllqdHNWUHJtNk93K0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c95e39-007f-4ca7-477c-08de540c678a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 08:02:18.6501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0CgXk9fhjIXwi/XrTeWiacjnaIPgEX4fEG557vaPlyuGhIeFRSwFApYXJle3+QrzTtsC6M+zv1zw/1LS1Ys3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_02,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150054
X-Authority-Analysis: v=2.4 cv=L5gQguT8 c=1 sm=1 tr=0 ts=69689f11 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=7VPXR1CUvrKnVLY-LywA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=1uMOUU2w0DxzEe95gQqD:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: pDf136EhIejgINbW4fmhubJCrANBScxn
X-Proofpoint-ORIG-GUID: pDf136EhIejgINbW4fmhubJCrANBScxn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA1NCBTYWx0ZWRfX3TjOqgAZOc6Y
 pPLu0mcqGLgYg5ThAq5UMjgfiO4+6H3cuXtCgjC83IwkSOGqREZsf6VqfDVj6vJ81Xj1bvL3buQ
 TZI3dkoumYvpII8fQREuebisXTkHJYLk+LeWPDd3jRnIJO9bFXrITpXI8WCZzXEjxQWuz1p3gWf
 46/5nrgbDk9AVf1BJ7AXFoiifXksRw+OdUMpkmlSS0u3SEwzW8sFGA7wmEvzjcC0BqvAelxJK3p
 ISlZAvopEmOOKJdx6nC+yHKhfEyO2fSdEAwpujN2JLjFpGQcaNrY8g/dxUkV/g7wloURqLuBzsT
 Prb/wmogpT8RC+GayNCHQjdOOmjVADMnjFdD12AgJmGDZJkI6voBvt7PzEIe3Lc+mxpMEyvd8uO
 q0gaHgXrbkOpSPSdoJpmzFgWqBr2/hvoAK9nCuZh6RCXSZMHTXC3hGEkp5AceGVnNi7SPlyRnWN
 dbOCYseXpZh9OTd7dcg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1011
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
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
+AD4- Sent: Tuesday, January 6, 2026 8:08 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v5 2/4+AF0- vhost+AF8-user: header defines fo=
r add/rem mem
+AD4- region
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4-
+AD4- On 11/13/25 1:44 PM, Pravin M Bathija wrote:
+AD4- +AD4- The changes in this file cover the enum message requests for
+AD4- +AD4- supporting add/remove memory regions. The front-end vhost-user =
client
+AD4- +AD4- sends messages like get max memory slots, add memory region and=
 remove
+AD4- +AD4- memory region which are covered in these changes which are on t=
he
+AD4- +AD4- vhost-user back-end. The changes also include data structure
+AD4- +AD4- definition of memory region to be added/removed. The data struc=
ture
+AD4- +AD4- VhostUserMsg has been changed to include the memory region.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-   lib/vhost/vhost+AF8-user.h +AHw- 10 +-+-+-+-+-+-+-+-+-+-
+AD4- +AD4-   1 file changed, 10 insertions(+-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.h b/lib/vhost/vhost+AF8-u=
ser.h index
+AD4- +AD4- ef486545ba..5a0e747b58 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.h
+AD4- +AD4- +AEAAQA- -32,6 +-32,7 +AEAAQA-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-BACKEND+AF8-SEND+AF8-FD) +AHw- =
+AFw-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-HOST+AF8-NOTIFIER) +AHw- +AFw-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-PAGEFAULT) +AHw- +AFw-
+AD4- +AD4- +-                                    (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-CONFIGURE+AF8-MEM+AF8-SLOTS) +A=
Hw- +AFw-
+AD4-
+AD4- It should be enabled only once the feature is actually implemented, o=
therwise
+AD4- bisection may fail.

So to clarify, you are suggesting, this change ought to be the final patch =
in the patch-set ?
+AD4-
+AD4- +AD4-                                      (1ULL +ADwAPA-
+AD4- VHOST+AF8-USER+AF8-PROTOCOL+AF8-F+AF8-STATUS))
+AD4- +AD4-
+AD4- +AD4-   typedef enum VhostUserRequest +AHs-
+AD4- +AD4- +AEAAQA- -67,6 +-68,9 +AEAAQA- typedef enum VhostUserRequest +A=
Hs-
+AD4- +AD4-     VHOST+AF8-USER+AF8-POSTCOPY+AF8-END +AD0- 30,
+AD4- +AD4-     VHOST+AF8-USER+AF8-GET+AF8-INFLIGHT+AF8-FD +AD0- 31,
+AD4- +AD4-     VHOST+AF8-USER+AF8-SET+AF8-INFLIGHT+AF8-FD +AD0- 32,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-GET+AF8-MAX+AF8-MEM+AF8-SLOTS +AD0- 36,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG +AD0- 37,
+AD4- +AD4- +-   VHOST+AF8-USER+AF8-REM+AF8-MEM+AF8-REG +AD0- 38,
+AD4- +AD4-     VHOST+AF8-USER+AF8-SET+AF8-STATUS +AD0- 39,
+AD4- +AD4-     VHOST+AF8-USER+AF8-GET+AF8-STATUS +AD0- 40,
+AD4- +AD4-   +AH0- VhostUserRequest+ADs-
+AD4- +AD4- +AEAAQA- -91,6 +-95,11 +AEAAQA- typedef struct VhostUserMemory =
+AHs-
+AD4- +AD4-     VhostUserMemoryRegion
+AD4- regions+AFs-VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+AF0AOw-
+AD4- +AD4-   +AH0- VhostUserMemory+ADs-
+AD4- +AD4-
+AD4- +AD4- +-typedef struct VhostUserSingleMemReg +AHs-
+AD4- +AD4- +-   uint64+AF8-t padding+ADs-
+AD4- +AD4- +-   VhostUserMemoryRegion region+ADs-
+AD4- +AD4- +-+AH0- VhostUserSingleMemReg+ADs-
+AD4- +AD4- +-
+AD4- +AD4-   typedef struct VhostUserLog +AHs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-size+ADs-
+AD4- +AD4-     uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +AEAAQA- -186,6 +-195,7 +AEAAQA- typedef struct +AF8AXw-rte+AF8=
-packed+AF8-begin VhostUserMsg +AHs-
+AD4- +AD4-             struct vhost+AF8-vring+AF8-state state+ADs-
+AD4- +AD4-             struct vhost+AF8-vring+AF8-addr addr+ADs-
+AD4- +AD4-             VhostUserMemory memory+ADs-
+AD4- +AD4- +-           VhostUserSingleMemReg memory+AF8-single+ADs-
+AD4- +AD4-             VhostUserLog    log+ADs-
+AD4- +AD4-             struct vhost+AF8-iotlb+AF8-msg iotlb+ADs-
+AD4- +AD4-             VhostUserCryptoSessionParam crypto+AF8-session+ADs-

