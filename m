Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF93CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 10:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4551B40263;
	Fri, 29 Aug 2025 12:26:38 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2ACC94025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:26:36 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T832aZ022965;
 Fri, 29 Aug 2025 06:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=p
 tYNBZy5yuJYoOlbmqXeV2THwk5bnvsALuRprF+iYZQ=; b=YFZQwfeQsrrpa2iEJ
 vQxNt510GD7F1eyX04G592ozz6MkCPV8anXZz7ACTZ9UvlyM/A8RowCYXWyUR4qO
 blDCMYowLL0eWBkB7P0D+0eW870DVrfWczZEy3Kg46Vi71xkvF2+zcCyc9diWjJR
 MVfr/Ik62MIpd/QiFUZEnd9Vx/9/ysrpabM/kfj1WlIqF5YAkijtQuJI9WhJGLuN
 gYAbrivSlu0i1PcycOUMIpVIoKn4Mm0O3wG6jgFMqNjzJ9BSlKV9XH4jWYdoHckn
 m7TF7YJuFSWiCQvNK4yM/Nc17vZhUad2GtNVG962eRmBhtfWX/p5ZzJdPelAiDmg
 K5HSQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48q8vauw1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 06:26:35 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T84qnK014681;
 Fri, 29 Aug 2025 06:26:34 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 48tr8ynrna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 06:26:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8AcxfDtVrA12vfcCf0D73UoNo4sMNljJh5Z0UhBG5ZT7uUiSKEgsvdxHOITghQlTpJ1K2wHimQzxsfHvpzg+VXiCY5ksb2MsCLcaDohIzzBnbVrQhDuweqKJM8gU1XDXggtUiAzhOLeqDuV+FyTFTOByfh2eKFf14ylhXPybvmu+dzhXO5zzmHmLpvaisSLgL4ib4/HrKY40HsoYIrmQoZ5dLuDNvjLN+cpe9w+32+nTBzWbJWrmQr5C90B2hmzDvknlUjcwSEtBoCGjk/S450I2/rPimZ+YiSShSvOfVpsdIKNwsNlkIzSNEBDGtfAHR5xV85tXlxrYpnOARwLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptYNBZy5yuJYoOlbmqXeV2THwk5bnvsALuRprF+iYZQ=;
 b=yApN1+rmsyOTeyFvjD6TOLpydzttz42FdhHhLV/rHiHAnzlI552jXXWysU2cuuL5M6QGcGPFmjZ/brux2MXeRtUnqIEI09aZMf8xwHCuhzK3AVXYa1bDHGvM7FsTzNyankHdSCbIDynFTfKQMmHFQ/e42/8jgaeG6pshv3qEG6upGEuPywKZdZlmLMbbp3MuX4GAHqgX7qhL+ALk+RrrBETa5Qok2nKcqmCZNDegMeZv5Wi3d/FXSIrNr5P+UzzRnaA5UW7xb6PTRDA6VgbeMWvQdHza7zWvSFjmMd6uw4pjyVYIrMZSbsfniE8YDEGMpaKvJyhj6x/tlwKenXT/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by PH3PPF4787DA698.namprd19.prod.outlook.com (2603:10b6:518:1::c19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 10:26:25 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Fri, 29 Aug 2025
 10:26:25 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWCAAFHO0IAEzWMAgAI4A7CABBa+UIAAAoIAgAAQwYA=
Date: Fri, 29 Aug 2025 10:26:25 +0000
Message-ID: <SJ0PR19MB4606EEE4D44D487ABBD8FCC1F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
 <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46063FDCC149084AFBD7C4E1F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8391ac53-0b5c-468c-ae38-341842f5c492@redhat.com>
 <SJ0PR19MB46063A880B831758A7455613F539A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB460649E8A3D39B224CFB4469F53AA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <ab711389-82ca-4aa4-9796-55106d5fc00b@redhat.com>
In-Reply-To: <ab711389-82ca-4aa4-9796-55106d5fc00b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-29T10:17:45.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|PH3PPF4787DA698:EE_
x-ms-office365-filtering-correlation-id: 94a1b360-b4bf-4982-a28f-08dde6e68221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?YisteW16OHo3WXJvSGZSeXZUR2lvYTlSS1JxKy1VaU9rTjVmdGlkQnd1TTI3?=
 =?utf-7?B?RFdKUW5lZEczN3lzWlJuU2R0bnJuVnhCbkloLzhncnlXVTI4eUl1aGJoVzY5?=
 =?utf-7?B?T3NJQ0NGUXpJcnZoKy1RcXJoS0lxdUYySWRFSU01ZFN1ejAvdWpkQzJpTVFh?=
 =?utf-7?B?c2hDSGNpeEpQN3E2ZWxTYlh1SmlLYU5XKy02OUNXUUllSmJOQlF1dW5TV3Z3?=
 =?utf-7?B?eGRBOXltakJnVUN1dktOdTl5OWdrUWRVcHUzTUJWN25TaFo0SWVUd2NrS0FC?=
 =?utf-7?B?MUlZdGxmc0JLdGtTSEMvbkJXYUdJbnZHaWU0YW1ScEhNTEU3ZlRKNngxa3Jl?=
 =?utf-7?B?Q3BBMGtqa1FlQ0RNZWw5cHFKaVlQeGNGL1FldU9zY3RGNk5wMXI2Yi9WaE9T?=
 =?utf-7?B?ck1FQjFoRXZ3M29iOHRFclVyM2RiblJ2Snd2ZlFXd21xUGlzazNFS1F5cUxR?=
 =?utf-7?B?UVh0dEl0aFZybHJ3dTN4TXdlSjJRempTL2NidGQ5LzJ3bmNyYk9yclZVVWdo?=
 =?utf-7?B?bUUycmFtMTVNb2ZadE5OTUdUL1N0dzdXZGwrLWRsWTNQMllhZkdpeXZEUndQ?=
 =?utf-7?B?VjQxcmV4aWl1dzMvQTJOMmZyUElpT0kvQ0s2SEVtMjUrLXhQanJRZEZTKy1p?=
 =?utf-7?B?V1ZpQTZLNFZBeWk1dG1wS09hLzZ5OGlYa0ZnUTg0a0tIL0RkaGU1eVNpQWNk?=
 =?utf-7?B?U24vMWhRMDBXSm9leUxoMVRpc25nVk9zU04yRGQ0RUVuTkNpQkFIb2ZkVHc5?=
 =?utf-7?B?SkNlQUdzVGdlQUZPZElxSnl2aEg4c0JIR1Jlamd2QnlRREhVQXp4NTVuYm1m?=
 =?utf-7?B?VEhyajdIbjBKQWxVNVR2Y3JIMW5jMURNMjBTbHVZdnhLcWRkTXhRL1lwSmlP?=
 =?utf-7?B?cW1mdVpwOFpzM2x5QkNZVDM1aVZKWnZ3cGFUVFBsdFNNWjBpclFCSystVGtO?=
 =?utf-7?B?Z0pHZzM2clE1Qlhjb3M2cFN4RG8xbkVycWxSN3VkcTBWWkRjN3g3dTRFTUph?=
 =?utf-7?B?WUVaQ3JENnc5RWdKZmtqMTkyYnN6OWNiSzdPdS9hZlNxb3g4ZkVyWGI3cmRy?=
 =?utf-7?B?bHkrLXE0dFhma0xPUy9LT0NURk9lcVBHQWRvVGRXdXJUcUJaVXVPdGpZOVFa?=
 =?utf-7?B?cGZqTystNTlKbmJNRjRxbldqZWVtY3NKVjJBbVRoSnNZdm5SQzBzRGVkZXZR?=
 =?utf-7?B?MTZJS3lsb0JtZ01nSlN5QnpuTzhFKy0rLS9ZUVJzTExFWWt6bC94U2RlcGFn?=
 =?utf-7?B?UXRxVUpIVXFIM0dYcUhBbFhYeDBXMTkrLWRYMWRwUistQXU0ejNTUGpzbVM5?=
 =?utf-7?B?NUNTNEEvMEtvKy12Wjh2aDZQVzBLdlVQU1Z4UVIvUkg3L2IwWVY3S21EN3Zw?=
 =?utf-7?B?aGtwKy1pUFU1aDh0NzlxNGhvUVhyNmNjVjRJcWZLSistZTFoUXJJMkc3UG1L?=
 =?utf-7?B?ZzlSbGVHd25pdWh1ckdGTGdPb3RWVUNRY25BOFNiRjlYOTJWdEdIODE2NTZo?=
 =?utf-7?B?Ky1zb0xpMGNMTTZRajhRaWdJaExCSmN1eVlLT0VoeDRLWGtOcndyTDYyZjJS?=
 =?utf-7?B?azM4SzZzc0ltMFJvc2RJNFcyZXlMblFlUWg4aE54YnB2bWtObHVrN3YrLXE4?=
 =?utf-7?B?UnBrallFNnRMSldNbCstZ0NicFBKNlB6ekJKUmVXNk1EL0tjdkRySWtVaDIw?=
 =?utf-7?B?am9udlVHWlhJWkgzeDk2V1ZZemI3MFNiTEF4a3B0d21HbFNmMExrcFNqeE83?=
 =?utf-7?B?SmtLS1BtVk81eU05NVZDY3B4aGZoVktxZ05ZOEI4Vjh6UGEzYzdqV3Y2bW9H?=
 =?utf-7?B?NnFVVzRkemtnZUtVZkpWZnRDeFdnM3I3b242bTk4OW9jeVkydkZOOHhQZHhJ?=
 =?utf-7?B?QTNPajEwa2Z0eEYzNk0zaWxIbVNFaGVwUldQNkUvSkR4Q3RxQWw5OCstWXRj?=
 =?utf-7?B?VmtHMklRbDI4Ky1tY1hsZGJFR241TDVVS2JsTTJESGxnK0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?NVh0L1VsY2gzaGxzVystVEhBQ2p1THU2NkhIcGE2dEwrLWdXY1FMc1dBbHM5?=
 =?utf-7?B?cWtTQTMxUTQyckFlbm4zdkNwdistZHBkT1FpazRubFZIeDJDMXJzY3pOcyst?=
 =?utf-7?B?ZDM1QWVGRnBHYXZKSnN2Y0laTzVDMmloWlVhM1NQVnpaV2Q2VWJIQm5oL3h4?=
 =?utf-7?B?SWRndlBEZTRaN3hlVVNUUXN6L3VvbldMcUJBMFBuNm9Bc0tmMG1tMVBVaEpv?=
 =?utf-7?B?QVk2RHpNWGk0ZEZLaEdmd1Z2SzFjUm9WNGQ5TXg1UVNZVHhpeSstUFBwcGRh?=
 =?utf-7?B?R1BGWm5GallCQkIxNXREa2hQMnVVdkdUcUJ5eWlldlVJR0l6b2pIS3I2L3Zk?=
 =?utf-7?B?bkFzZjlxckVnKy05ZU5IdzZiYUJsTXdpNUVHVEtiKy1KMVZiUm1RMlVvay9G?=
 =?utf-7?B?dTNjSGhvdUgrLVNOdHgvMXpGZzBSclNGYzlpVk5KRFVMVHRPYistam9VMHpi?=
 =?utf-7?B?S0N2b3pkNTFJamJRWFJpeVVUNG5adkp6Um9YY0UyV2xOYktwM1oyR1B2SSst?=
 =?utf-7?B?bzl1WkR1R2VFNFZacWs3Z1JUdTVTWWYzVHpQL2NpODVXb2dzcEJndnBzc2J0?=
 =?utf-7?B?a3dhaGQvOWFnNnZ2TXFTa003ZjgvdGkzRWs2QmxGMHlSbVROOEZ5Ky1ySmdj?=
 =?utf-7?B?NVB6b2FKS1JHeUF4NSstaVNGT1d0Wk1rNzNqZE5WKy1qejgxZ3F1ZlhKQVll?=
 =?utf-7?B?bmpXb0Q5RXVkVjV6aFFEb2k0bUFKelp4c0l5ZTVBRUhubUZTUkhjbFRtdVkw?=
 =?utf-7?B?TmlFTmlhV3Mzd1ExSFdMZnYwaU9vNG5ndkNPdi9nVTNlYWlXajl3Qjk3U1VN?=
 =?utf-7?B?c0l5alF5S0xkWDRLbkJQL2ZqL2QwVW44YW10c05KcHJMVW4zeGZaRU1RWHE4?=
 =?utf-7?B?UkdHMjgxM3BDbWZyQU5CWWhRbDkwVndScS9GdGkySk91Wi9FalU4QUdVQkFB?=
 =?utf-7?B?VGFwWGwvKy1nRWZxN2hDNno5WmJsejZERHpiNWpBTy9jOW4xZFlxMndKVmR1?=
 =?utf-7?B?ZUlNR0xvcUVxMWJ3aXR3RnV2S2F5QTFDcUpwOHhlcWpQcUljRjc1aThuczM=?=
 =?utf-7?B?Ky1FUHROSDFzaXpEcG8xbWR4MllwQmhCTSstYlF6NGUzTzlLeFpJTk02SDRz?=
 =?utf-7?B?MXVQSFdSYVprdHFiTVBYNFk3b2JnTmVEanh4dVVvaC9kVGNmbVZnL0cxQ2xh?=
 =?utf-7?B?bHphYUxEQ29GWmRhVDh0SlBNajFaS2FVeE5YNThIKy1KdmZuTndSblBoU1pQ?=
 =?utf-7?B?OEJ3cTFTYXVFNm9LVlFod1BtZ3ROa21PSUlzMGErLWFlaUhWYTR5SnZyczdZ?=
 =?utf-7?B?TXpTKy1lUUtCaVJJNlVGV1N6ZVdqSTVVcU54RWYveWJKN3AzMG0rLUZuNGV2?=
 =?utf-7?B?dTF1a3RWblF3UlZXU2FiU1JGTUp3M2diTGJDWGtkeXJ4Sk9tamhtNXNkVGpC?=
 =?utf-7?B?Yzh4bS9tZ1dEb1NPT1JmUTZDM3g0N2VORGQzQmg5Zk96eGQ2QjU0eXM3eXVC?=
 =?utf-7?B?Sk10Z01QS2Iyd2J4czF1UXdJcVpZeEVFaGxQSEdDTDZLdzhGR3BYUFRQQlIv?=
 =?utf-7?B?QzdhR3JEL3AzVFhqb0dWSGFNQXBLQnFCRmpDL05LVU5VRTBSdU9jRk9Sc0ND?=
 =?utf-7?B?eGtDd3FkRGYwVTY3bFFwM01SaXpHVTJXbmtGWEZRRlFITWlmUmRmLzlLOGF3?=
 =?utf-7?B?cjZkOHdLSDlIWistRnN5Qk5sT2pabk1hNFdwTW1kUmVCWFdWekc1YlpUQkRY?=
 =?utf-7?B?bUxUbWZWTSstVTJ5bG1ITVdPb1dDY0JMTXgxY1ZJSUx3SnkwLzdIdzNrMXhV?=
 =?utf-7?B?T0pYcFRZNUdpbnVjZSsteGlnaU1XdEVaS291cUgrLWRFc0xLSU1WMU1LRkNH?=
 =?utf-7?B?TGRTTC9OR3gzOWQ3TDRDcEVQM3VualR5Q3BGY2U5UEhhRnJEaTY0Z1RTWXBL?=
 =?utf-7?B?Mkp3TFdaSEFtSS96d0V2TlAxUmpJaystRFp0Ky1pVWtpbUV2NHk4YXNJbXBY?=
 =?utf-7?B?aGVrOVdLM1VkbWZ5b205S04wcGlIL285T1AyaystWWlvL2tOcFdsZ2xFUnRO?=
 =?utf-7?B?VXpVUlVGZEFJZzExdU5NWU4zYmU2MnIzYVAvVU9ESW9qdmtnSGJEWG1LRHhl?=
 =?utf-7?B?alV6cFBhZ3gwdHVDM0FLcERCaTBmVkQzU2pjTDJ4UUc4RGlXM3Y0bUdGVzdh?=
 =?utf-7?B?eXFmRXZUREo=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a1b360-b4bf-4982-a28f-08dde6e68221
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 10:26:25.6302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8C4BrkEfwcooizifpAa8umwx33nQK5UG3Xpfzt9EARI5MP5/V29tIWk9Ft3kgckPsTrCHHrJ03Li2S6vjaFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4787DA698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280114
X-Proofpoint-ORIG-GUID: tT4FlX3xD7rAE9RHbPP4nqD7howkjzjd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIwMiBTYWx0ZWRfX0VLxuNTqrCXx
 fdVGTOCMw5Wb2KvrJEpOyU9+KspudR0behAv2D7hD+oYQHh42Hvf24nJgyVEBgBHloMtOwDcuMd
 Of2C9tTCpgbthDezp4LrGqwdzZipleXS0Jc/tLA2Fud5z7ezdq9wlfChq325X+kfug3PaG+iqWM
 oXnl+YiuFceAi2lE+PiGn1vHrL2Yefhg6F9v28hNwXU1UDMSYEpf9Ws/hssPqSpexHMQc+2r+kN
 Y/PxovquFNPZ8ptzxTTf9l/hNwnhqNlMIiDfI80uZPM8vJEBItCtKBuBeqrBIQLyukyQXgXf5x1
 OgNG1CPnYKwVlu15c2jdkocqwR0LaeY+F9qLXAT6SCGbEsz/s/2uM1rQ+VpzycimeS+Vu1ZwjRU
 MknBOubC
X-Authority-Analysis: v=2.4 cv=bIEWIO+Z c=1 sm=1 tr=0 ts=68b1805b cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=yLxAKQgpAAAA:8 a=20KFwNOVAAAA:8
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8 a=8rWy6zfcAAAA:8
 a=pGLkceISAAAA:8 a=bt5KbKNvAAAA:8 a=XlRjxQ70AAAA:8 a=LfxEVeEBAAAA:8
 a=XFJw1KJJAAAA:8 a=BXszkKfDAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=6-dRa9qSAAAA:8 a=Ee2K3CqUJd7ar3d_6EUA:9 a=avxi3fN6y70A:10
 a=gbU3OgOOxF9bX48Letew:22 a=zY0JdQc1-4EAyPf5TuXT:22 a=pu3MsO4jS0LNTy4EJMSl:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=duu7wrcty9prphiCz_fF:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22 a=NZk92sZ4hQKp_Sw8PGvT:22
X-Proofpoint-GUID: tT4FlX3xD7rAE9RHbPP4nqD7howkjzjd
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260202
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

Answers inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Sent: Friday, August 29, 2025 2:18 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- Bruce Ri=
chardson
+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+AE=
A-nvidia.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Tho=
mas Monjalon
+AD4- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slo=
ts
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi Pravin,
+AD4-
+AD4- On 8/29/25 11:11 AM, Bathija, Pravin wrote:
+AD4- +AD4- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4-
+AD4- +AD4- Could you please help review the code ? The goal is to merge th=
e changes
+AD4- before September 18 when the merge window closes for SPDK v25.09.
+AD4-
+AD4- I will help review the code, but there are no guarantee it will be me=
rged in main
+AD4- branch before September 18th.
Thank you for your consideration.

+AD4-
+AD4- Can you elaborate about the tests you have run?
- Run I/O tests using fio and libblkio engine to SPDK vhost user block targ=
ets with multiple targets and different block sizes
- Custom system tests defined within SPDK framework
https://review.spdk.io/c/spdk/spdk/+-/26395
- QEMU bring up with SPDK Virtio block device

+AD4- Have you ensured it is still working properly with Vhsot-user/Virtio-=
net?
Yes tests have been run to ensure this as listed above

+AD4-
+AD4- Maxime
+AD4-
+AD4- +AD4- Regards,
+AD4- +AD4- Pravin
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: Bathija, Pravin
+AD4- +AD4APg- Sent: Tuesday, August 26, 2025 11:47 AM
+AD4- +AD4APg- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4A=
Ow- Bruce Richardson
+AD4- +AD4APg- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +AD4APg- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-c=
henbox+AEA-nvidia.com+AD4-
+AD4- +AD4APg- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com=
+ADs- Thomas Monjalon
+AD4- +AD4APg- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APg- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure m=
emory slots
+AD4- +AD4APg-
+AD4- +AD4APg- Answers inline.
+AD4- +AD4APg-
+AD4- +AD4APgA+- -----Original Message-----
+AD4- +AD4APgA+- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+=
AD4-
+AD4- +AD4APgA+- Sent: Monday, August 25, 2025 1:49 AM
+AD4- +AD4APgA+- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AO=
w- Bruce Richardson
+AD4- +AD4APgA+- +ADw-bruce.richardson+AEA-intel.com+AD4AOw- David Marchand
+AD4- +AD4APgA+- +ADw-david.marchand+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw=
-chenbox+AEA-nvidia.com+AD4-
+AD4- +AD4APgA+- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.c=
om+ADs- Thomas Monjalon
+AD4- +AD4APgA+- +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APgA+- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure=
 memory slots
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Hi,
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Please try to fix your email client so that we can follow =
the replies inlined.
+AD4- +AD4APg-
+AD4- +AD4APg- Thank you for the input. I have made the necessary adjustmen=
ts.
+AD4- +AD4APg- Please let me know if there is anything missing.
+AD4- +AD4APg-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- On 8/22/25 9:33 AM, Bathija, Pravin wrote:
+AD4- +AD4APgA+AD4- Dear Maxime, Bruce, David, Chenbo,
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- I would like to follow up on the status of the patches =
and when we
+AD4- +AD4APgA+AD4- should
+AD4- +AD4APgA+- expect these to be merged into the mainline.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Please let me know if I can help answer any questions y=
ou might have.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Regards,
+AD4- +AD4APgA+AD4- Pravin
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Internal Use - Confidential
+AD4- +AD4APgA+AD4- -----Original Message-----
+AD4- +AD4APgA+AD4- From: Bathija, Pravin
+AD4- +AD4APgA+AD4- Sent: Thursday, August 21, 2025 7:48 PM
+AD4- +AD4APgA+AD4- To: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APgA+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmai=
l.com+ADs- Maxime Coquelin
+AD4- +AD4APgA+AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia =
+ADw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- +AD4APg- David
+AD4- +AD4APgA+AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bru=
ce Richardson
+AD4- +AD4APgA+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4APgA+AD4- Subject: RE: +AFs-PATCH 0/3+AF0- vhost+AF8-user: config=
ure memory slots
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Comments inline:
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- -----Original Message-----
+AD4- +AD4APgA+AD4- From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- +AD4APgA+AD4- Sent: Tuesday, August 19, 2025 4:36 AM
+AD4- +AD4APgA+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD=
4-
+AD4- +AD4APgA+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmai=
l.com+ADs- Maxime Coquelin
+AD4- +AD4APgA+AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia =
+ADw-chenbox+AEA-nvidia.com+AD4AOw-
+AD4- +AD4APg- David
+AD4- +AD4APgA+AD4- Marchand +ADw-david.marchand+AEA-redhat.com+AD4AOw- Bru=
ce Richardson
+AD4- +AD4APgA+AD4- +ADw-bruce.richardson+AEA-intel.com+AD4-
+AD4- +AD4APgA+AD4- Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: config=
ure memory slots
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- Comments inline
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- 12/08/2025 04:33, Pravin M Bathija:
+AD4- +AD4APgA+AD4APg- - add protocol feature support add and removal of me=
mory
+AD4- +AD4APgA+AD4APg- regions/slots dynamically.
+AD4- +AD4APgA+AD4APg- - this patch set has been tested with multiple insta=
nces of fio
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- What is +ACI-fio+ACI-?
+AD4- +AD4APgA+AD4- Fio is an open-source tool to test I/O workloads on dis=
ks and file systems.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg- connected via libblkio to spdk target backed unix do=
main socket.
+AD4- +AD4APgA+AD4APg- - please apply this this patch-set to dpdk mainline =
as well as
+AD4- +AD4APgA+AD4APg- version 25.03.0.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- As mentionned previously, we don't plan to maintain 25.=
03.
+AD4- +AD4APgA+AD4- I understand you need it for SPDK,
+AD4- +AD4APgA+AD4- but I think SPDK should rely only on LTS branches.
+AD4- +AD4APgA+AD4- Is there a specific reason why 25.03 is required in SPD=
K?
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- When we do sub-module init on spdk master, it uses dpdk=
 version
+AD4- +AD4APgA+AD4- 25.03 from
+AD4- +AD4APgA+- it's own sub-repo.
+AD4- +AD4APgA+AD4- Our changes for vhost have already been pushed to spdk =
master. We
+AD4- +AD4APgA+AD4- have also pushed the same dpdk changes in the spdk sub-=
repo +ACI-dpdk+ACI-
+AD4- +AD4APgA+AD4- which is version 25.03. I was just ensuring that there =
is
+AD4- +AD4APgA+AD4- uniformity in the 25.03
+AD4- +AD4APgA+- codebase, whether it is on the spdk sub-repo or 25.03 with=
in dpdk repo.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Ok, still, it would be better for SPDK to uses LTS as we h=
ave no
+AD4- +AD4APgA+- plans to add extra stable branches.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Also, your series may be considered as a feature and not a=
 bug fix,
+AD4- +AD4APgA+- so even if
+AD4- +AD4APgA+- 25.03 would be a stable branch (which it is not), it would=
 not be
+AD4- +AD4APgA+- backported against it.
+AD4- +AD4APg-
+AD4- +AD4APg- Understood. I would request that we merge my changes into DP=
DK
+AD4- +AD4APg- mainline before September 18 when the merge window closes fo=
r SPDK
+AD4- v25.09.
+AD4- +AD4APg-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg- v2:
+AD4- +AD4APgA+AD4APg- - fixed warnings with e-mail address
+AD4- +AD4APgA+AD4APg- - fixed warnings with typos
+AD4- +AD4APgA+AD4APg- - there is a warning about +AF8AXw-rte+AF8-packed+AF=
8-begin not being in pair
+AD4- +AD4APgA+AD4APg- with +AF8AXw-rte+AF8-packed+AF8-end which on reading=
 the code turns out to be
+AD4- +AD4APgA+AD4APg- false. It is an anomaly of how git-format generates =
the patch and
+AD4- +AD4APgA+AD4APg- how check-patch checks it.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4- When sending a v2, please use -v2 so it is reflected in=
 the email subject.
+AD4- +AD4APgA+AD4- I will remember this for next time. Thank you for point=
ing that out.
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4APg- Pravin M Bathija (3):
+AD4- +AD4APgA+AD4APg-     mailmap: add user
+AD4- +AD4APgA+AD4APg-     vhost+AF8-user: configure memory slots
+AD4- +AD4APgA+AD4APg-     vhost+AF8-user: support for memory regions
+AD4- +AD4APgA+AD4APg-
+AD4- +AD4APgA+AD4APg-    .mailmap               +AHw-   1 +-
+AD4- +AD4APgA+AD4APg-    lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4- +AD4APgA+AD4APg-    lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +AD4APgA+AD4APg- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-------
+AD4- +AD4APgA+AD4APg-    lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4- +AD4APgA+AD4APg-    4 files changed, 296 insertions(+-), 44 deletions=
(-)
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4APgA+AD4-
+AD4- +AD4-

