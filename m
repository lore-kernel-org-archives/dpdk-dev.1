Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9003C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 12:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 857CF402C4;
	Tue, 18 Mar 2025 13:55:18 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D824E40291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 13:55:16 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IBhFRt028604;
 Tue, 18 Mar 2025 05:55:13 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45f873r46q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 05:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlCg0tZgLX392FFpnhLah5begLOsn67rsy3K9VTSvHQg/ACBPlnBsWNNlDV7uruln3W6L4nyxWyShZitiR/a3AFCWAEpNUQ1drEOVTtzdrLBpfhCfb4QRoHDTeM/8rgsp8+eLFTmifOEjlFCDZBsOIVwFkohQTtzjIrAcVVqVjLcPWr9iZ8XD4RR3xbgj3RogG02u1PQBlMgx0zhB+s7bAMVyUBw1uZ02uQEotyHcCiyIz8xt4E/wmrzqfRupe6fFNL36UaaBcBzvwv8WBpijx2xEWbrJN1zaiyLMvDONdChWq6gFB/bI/PkHvf6FzvZy+CQfRaN5btHZYlTaw0UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btnpSIW/ZnPfg7O+cB90QoQvXiC+4WbB22r9/GRE08Y=;
 b=OcUNutXLH/DQeTvEe2LJ1XiyAUqT3UU0+1NPa2og4grTiqAGPIY0WEwTsWGB+YCY7Ido7TL6dVuFuX3hi2OgnbsDQzBJJl83u2qWvlCAGOZc1UPjK6BmUHAk6XSb1ynpxW818lrJrrdkknLyf52bexChy95pSuXKHCHZma8YCSihnV6AQEg6m3G0SUR7Yakkd+CqH8uUrjgyxaF3LtA6oYPd6N+NWIVr5525FSFJy39XqThukusB+heDqhKQWS24YCHW2rFnz6IxY2q6or1J5ATgJefW4pm4R3GwP0TdXTDBWjdRDnJHWxeg7ItOhKExRpAcUVirP4xK/cYFpAR+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btnpSIW/ZnPfg7O+cB90QoQvXiC+4WbB22r9/GRE08Y=;
 b=RFDH2KlPu68Qrp39kaIKi1Pfs24QdzYb53rdshgD54t2tKMflEn/yT/eorAKTik4oyCbeFshkYZw9mzo50dlJ0Cr6aLt2S7pdF8CIril20zMpH+KOSGITnNdn89YoQhsmCJW4kV6v1OeNFxzA9BVkaKQL1Pce4u4HL2XHRx4pmQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 BL1PR18MB4183.namprd18.prod.outlook.com (2603:10b6:208:31b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:55:09 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:55:09 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>, Jerin Jacob
 <jerinj@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Thomas Monjalon
 <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
Subject: RE: [PATCH] config/arm: fix march features not being set
Thread-Topic: [PATCH] config/arm: fix march features not being set
Thread-Index: AQHbkAhb/4JBtuLZDkGe6YHLVXxX57Nv7vcAgACVatCACGVQ4A==
Date: Tue, 18 Mar 2025 12:55:09 +0000
Message-ID: <PH0PR18MB4086C85708FCD0B81E79F022DEDE2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
 <PAWPR08MB89099D7C522EFE6681BBA2EE9FD02@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <PH0PR18MB4086C2E00481CD1D2AE770D9DED32@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4086C2E00481CD1D2AE770D9DED32@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|BL1PR18MB4183:EE_
x-ms-office365-filtering-correlation-id: 784d3237-bdf6-43b2-4f41-08dd661c1d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVY0a1o5UTVIMlpzN2xQSm04K1J3TW02dTZHcHN2VUhINW81dkNlb3lIN2di?=
 =?utf-8?B?RDVLWFA4MDJZZENvSzBrTFJxS3NUNGVuSVlSRnU2ZE5zSml0eFR5RStPaVQ5?=
 =?utf-8?B?aVJLREFTa2dNY282dXROVFp2TzZtY0t2a1BQbmg2R0hEUDR5MDFqUjFMS0N4?=
 =?utf-8?B?NkhxRVNOT0JGN0FqeW9RdHhJM29QSTc5L242aDhMNnhuSHIzTk83bUZXM0Zj?=
 =?utf-8?B?VWlpV3JvRE9NZnV4OWd0aDV5MjBqRy9wZ0JWNUVvV1I0emI0ZFFnUnZLenQx?=
 =?utf-8?B?MXBsMjRHbnN5azUwZVZ0UnhlTGJacnd3aWdGSUJmVW9WWW1FUllWNndsYmYy?=
 =?utf-8?B?dmRmZHFLT2JUaFAvSnovVlE2OTVCZHRWTUszUHgzV3Q5Q084cFZnUmhxSXNK?=
 =?utf-8?B?VEk5bFM3ejcvNFFMZGI0QjRkdENYY1FXRzhCOHFxQVF0NjkxQ0lkek5ZUXhl?=
 =?utf-8?B?a0UyNmJQWnRNYkhYa09BbmdaK0hEMlFRSm04cFBxd3Fia201bnhjSzUzUy9x?=
 =?utf-8?B?T2owdEVVL3UrVjZFUTI5MHFZeTZFb1AzQk5pOVcrcXNzRXMva0hZeWV1Smhs?=
 =?utf-8?B?V01QVUlLcThhYzBsZjg3RDIvaDlpZGltWlNYc2tscmJUcXQrSUdKSDgyTXQv?=
 =?utf-8?B?V0YyTVp3dHFTVTFQMEhwRG5QdnRBTzkyeVBwdVJRaUVDMDYwdzNhcWRyU2ti?=
 =?utf-8?B?WkJTSWZvRjJ4UzlMNGRkMEV1a0tvamdyc1JhLzdNV1orbmgxZCtVcktUQkk1?=
 =?utf-8?B?Nmg3L3J5R2l3eXVXWVFSRXMrNFJ2aHZMOWJFSk5XdnhoR1JyK1BjRWcvZHdW?=
 =?utf-8?B?RnVMek8wRXc1a01sT3VWTnprbVRwMnhlU1Q5dWNBNXZteE5FNW1BdGxkWmI4?=
 =?utf-8?B?YTJOSmQzLzVpRVY4THVYNjVIV2QzSVFBbVBweEw0eUU2RDV2dk8zUlpOOGdS?=
 =?utf-8?B?VDRwMjQ3Ti84Q2g4RjlVby83KzdSZGhUOSt2MTdzTHMzcjhFQ1UvS3lBZUxE?=
 =?utf-8?B?TzRKTlp3emZDWEY5NXZqTjkvMVFXQThoR1lFMkt6NXhJbk1sWlFCbmMyY2FR?=
 =?utf-8?B?RXZCU1M3K28yc2pOVTQ1eVYxOHpaSTFFd1JUcEFJREthV1p2TUltaDBiZmxI?=
 =?utf-8?B?UmttVXk3WllVVmNnbWJ5bW14RGZrMzB4d0x5dFI2eDZ5L2hRcG4xVWFBcmdH?=
 =?utf-8?B?M1ZIMWRMakpwYXd3RmxhOGZTV1pWUHBFbVJBMXRnSC8wYzZEQVM4Ykg2OWQ4?=
 =?utf-8?B?eXREczRpL1hyN0pwZWVQN3Z1QTVURm9JdW5lTDE5NlhQUzJNazQ1US9VdStr?=
 =?utf-8?B?dHA0NTlsK1lIYXZzYmtSWW82dnhleEpPWVdCaitLVDN2cHJrTVhzTDlkYXl0?=
 =?utf-8?B?UXpaT2hPSEVoQmg5RDdkeVBSQjk4eVdneWRGNExYSVpQb2hjVkxvNUdPL3hH?=
 =?utf-8?B?U1NIV1FQeXc0TkJMNGlUR1V0eEZ1SkJzRGZySmFQZGxERmtWbXVFSGMyMytE?=
 =?utf-8?B?TGFpN2NCbi8rMUh5U1hkK1VDNW84L3d5TmI5QzFKd2xYVkZ4TzRKZkVVdi9v?=
 =?utf-8?B?MzRTZ2pxQWtPYVdCL00rcVFXV2dNQjNEUVN2MGcyZkhtcWptVnJrbTBoZVky?=
 =?utf-8?B?Mm8yMFJTejFGVlZFTkxpMmwrditnNkdUNWlVOWJqVG1la3MvRk9BOXZTcGhh?=
 =?utf-8?B?ZUc2azVxWXJXSDk5QmNGQWhwTjRQOWNBYi80N00vYXFEc0FWWnJOODY5VEky?=
 =?utf-8?B?ajdWVDVwMEdGdUxrSWkyYTZrQzhKWnJaL1hOU1RYUTRBRmsxNGptQXVZUUFW?=
 =?utf-8?B?QldrejdPZytOYmZwcWFNNnFENm9lRi8xV0VsbmNkQ3hSTVFRVmJJNzVuaUV4?=
 =?utf-8?B?TlE4MnVpQ3piL0MzZjh3eHB5Mk5oTm9seDBIU09WaEdlNzk4NkJQNkVzODRM?=
 =?utf-8?Q?xeizZ9w26mc8OYA5L1HR+sFzzVWbDt0g?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a09sVHlmdFBPaVVxWEV1N2VTd3U0TFU5SlRKTGJaMlNYRnk1NlZkcW1taE4z?=
 =?utf-8?B?U2c0SlBoeXMwTHRTV0szOVE5QjlyNUZhNEVpeEkvZkVSWEdvT1hqcHQvOTg3?=
 =?utf-8?B?Y3dYMStCbkx5cGY5dDdtUjJDVy9wZmZkRWczZlJ2L0F5Q2o5U0hFbE13M0Vn?=
 =?utf-8?B?NEhaL1RWbnpCKzB3NnV4R0ZzVmFGTmpOd3VKd0xScTNyNUtuVXZQREFsRzdp?=
 =?utf-8?B?R2hQWUNhSDVGOWdycTl6b1YvOUgxeTg1bmpGbWp6V1lTbW9KSVdObWMrZEZu?=
 =?utf-8?B?WXVJYy9SNkxxT3BUZzRiOXNGK1U3Zno0ZEhSQld3Qmovd3ZSSGl3dFA4eDBi?=
 =?utf-8?B?NGxzbmVWVnlQR21ESlBKazFGaE1seks0Sm5zT2ZsNEthNFRVeDZtNDhkQmNZ?=
 =?utf-8?B?cVNLUEp4bWNtQURxaE9sSmcvZDJBNXZVbFkreE5EMFBCMmtHVTJRNXNWMy9T?=
 =?utf-8?B?U25YYUQwK2JxdVp0ZVJDQU5rNEZFTGFJVk1sN3FLWnBGdlA5SkZrRzQzNFRD?=
 =?utf-8?B?dlgwUFlLLy9YRi9tSndWNnB2YUFRUXVSZ2VGaHRiK3g5TGJKemw3YUtJejFu?=
 =?utf-8?B?WUE4WVVacFg3NzE1SWJoRU1ISllVWjdvOTBiTGpyQ1RWTkthcjFtNFBUZE5o?=
 =?utf-8?B?MkxLek9JQ3MxVll6M1pGMmZwc3VmWlFSekVVZUVDMHVueXViWmtWWHd6VXlV?=
 =?utf-8?B?ZkNLZG9TMmlreTFOdUYreG1pL2pzejFhYkduSy9lT0dISDlLcmV1OGRUTjBM?=
 =?utf-8?B?NDFLTGNLMlNXd3FvcHZHZ1V5dmowRjR1ZVJaT3AvVFh6MjJObHJIUkM0Q2JP?=
 =?utf-8?B?UXkwNGx0RzYzT0pkODlwWVpwVEpFaWE4NFFpcUVOa1J1Y3p4WUpDQy9ic3hq?=
 =?utf-8?B?aGpPSGFrTURWSEpaeThOZDVoOUcvYkhHLzJTMjBiVGNvUkZZZEk4NFNGRlgx?=
 =?utf-8?B?ZTVFNHY1bmYzN1o5cml5U2hCZ2E5NEJYeG53bHdTZzRIV054TUlTaW95K2xX?=
 =?utf-8?B?MzNyZFdQVCtxVXExalMvc3dQWEY2WmFidGFhWjgxdENTUkgxTHl3cVArTnY5?=
 =?utf-8?B?UnBiVGNKVjQ3NFpSNFg3WGVEcWMwcEhxa1dWM3lGVi9qcEIvVmlIZkxuUUI3?=
 =?utf-8?B?UE9FZjhiRjYyU3dqVWN1azlYak1jbGNGdjZKOU5tOS9JVmZLYzd5TXpldVJ5?=
 =?utf-8?B?MjRScmJPSFh4dkZsVXIvemdtRTRmbnUyV2NZWlhHaGE4NlM1M2JKeUJ3ems4?=
 =?utf-8?B?M1NOdEJkRHVYcEV2V2RDOG1WbUxlam01NVlXbVovUDdOamRwN0pjaXlZN2NS?=
 =?utf-8?B?MGZ1RlN5OE1zRVlERTZUOXpraUZ2ZkIxWUVVREVkWjRsZG1nRUI1eDFhWEFa?=
 =?utf-8?B?a3Y2V1ZjVUZFaGJFYlczZzd1S0RnSmJwbmsrU0N1VUswcFNGUnFVSVRUWk5a?=
 =?utf-8?B?N2RlWUJtYmhRYnlDMjY0eW1RanluTUZqUTUzL3hFQ0xmend2MlB6OVQ0Tk55?=
 =?utf-8?B?VUVBQXZENkNCb09IcWs4eWx5WnEySVozbkJ0ck1LRHJneXJ0SzQ3eHVoK3F4?=
 =?utf-8?B?Vy9qTU5WUTJzeU4yNWZrS2Y0V0h2RmVOUEtONUhkaGhyaXp4TmVhQ1Y5aDcy?=
 =?utf-8?B?SFE3UU0wTDlNaVVrdVZZU1lCRGlEa3VGckRrOXEwdC95djJlcWs5amQ3SzBT?=
 =?utf-8?B?WkhpbnBleklNTVRzTVAxVnp0Vnd5RXloQlJMZmxpekxyUURFalZOaWc1Vllh?=
 =?utf-8?B?TmZlZGhCNnk5ZWJUekd2a0FVZzl0dUZKdEtuN0RzcHNVazhjZVZFUXl1bk42?=
 =?utf-8?B?bTFER1hvdW00bFE0WVFRc2FCbnFKS21JV1dLclRlQjhPcGlmYXpXNXRESkQr?=
 =?utf-8?B?TTB3MVM1M1VpWU1zQ2pMd0phU2hqSXJHSmhWUTFQc1h4WHhoRXdVM2dIMyt6?=
 =?utf-8?B?RDV0T05yYlBRV3g1MEdhM3hiVUVOZkwxOEhhZkNJbjFDcGNLd2NwSFJNZmw5?=
 =?utf-8?B?dU42ZzFQSm1GbFpEaFNBZURiQnlGZHl1UnA4ZFVWRnN6S0dDMkpGSWFCcGZa?=
 =?utf-8?B?KzJqS2l6WVBhMlE0QkhnM3VUc0Q2UjQ1UEZvNnVsSDFjZHNER0VjViswYlJ5?=
 =?utf-8?Q?XyWBtzJeSR07uA+NoJW0Pq+q9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784d3237-bdf6-43b2-4f41-08dd661c1d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:55:09.5951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6N71dtJva+Mv0KdeapNKT8+s2TLpr4ktRLljnt6hDAZ3CjOaLulCYYCEocAN/yWlP0WmRni//0pInDFkxqnnFrkHmya65ZyG/ymwU1nj0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4183
X-Proofpoint-ORIG-GUID: HMF8cIeIsW0F5C6HIYEhbhbFxmx_2ge2
X-Authority-Analysis: v=2.4 cv=L5MdQ/T8 c=1 sm=1 tr=0 ts=67d96d31 cx=c_pps
 a=+kc2f53xTGsvuL7uaCOpcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=7CQSdrXTAAAA:8
 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=yPoJhQ5qyNz3a9uE-WwA:9
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: HMF8cIeIsW0F5C6HIYEhbhbFxmx_2ge2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2YW4gTmlraGlsZXNo
IEJoYWdhdmF0dWxhDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMywgMjAyNSAxMDoxMyBBTQ0K
PiBUbzogV2F0aHNhbGEgV2F0aGF3YW5hIFZpdGhhbmFnZSA8d2F0aHNhbGEudml0aGFuYWdlQGFy
bS5jb20+OyBKZXJpbg0KPiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsgQnJ1Y2UgUmljaGFy
ZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IG5k
IDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBjb25maWcvYXJtOiBmaXggbWFy
Y2ggZmVhdHVyZXMgbm90IGJlaW5nIHNldA0KPiANCj4gPiBIaSBQYXZhbiwNCj4gPg0KPiA+IEkg
dGhpbmsgdGhpcyBwYXRjaCBkb2VzIHRoZSByaWdodCB0aGluZy4gSSBoYXZlIGEgbWlub3IgY29t
bWVudCBvbiB0aGUNCj4gPiBjYy5oYXNfYXJndW1lbnQgeW91IGhhdmUgYWRkZWQuDQo+ID4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGNvbmZpZy9hcm0vbWVzb24uYnVpbGQgfCAxMSArKysrKysrKy0tLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZy9hcm0vbWVzb24uYnVpbGQgYi9jb25maWcv
YXJtL21lc29uLmJ1aWxkIGluZGV4DQo+ID4gPiBkZWEzMjljZWI3Li43Zjg1YjA4OGM5IDEwMDY0
NA0KPiA+ID4gLS0tIGEvY29uZmlnL2FybS9tZXNvbi5idWlsZA0KPiA+ID4gKysrIGIvY29uZmln
L2FybS9tZXNvbi5idWlsZA0KPiA+ID4gQEAgLTg0MSw2ICs4NDEsNyBAQCBpZiB1cGRhdGVfZmxh
Z3MNCj4gPiA+ICAgICAgICAgIGltcGxlbWVudGVyX2NvbmZpZyA9IGltcGxlbWVudGVyc1tpbXBs
ZW1lbnRlcl9pZF0NCj4gPiA+ICAgICAgICAgIHBhcnRfbnVtYmVyID0gc29jX2NvbmZpZ1sncGFy
dF9udW1iZXInXQ0KPiA+ID4gICAgICAgICAgc29jX2ZsYWdzID0gc29jX2NvbmZpZy5nZXQoJ2Zs
YWdzJywgW10pDQo+ID4gPiArICAgICAgICBleHRyYV9mZWF0dXJlcyA9IHNvY19jb25maWcuZ2V0
KCdleHRyYV9tYXJjaF9mZWF0dXJlcycsIFtdKQ0KPiA+ID4gICAgICAgICAgaWYgbm90IHNvY19j
b25maWcuZ2V0KCdudW1hJywgdHJ1ZSkNCj4gPiA+ICAgICAgICAgICAgICBoYXNfbGlibnVtYSA9
IGZhbHNlDQo+ID4gPiAgICAgICAgICBlbmRpZg0KPiA+ID4gQEAgLTkwOSwxMSArOTEwLDE1IEBA
IGlmIHVwZGF0ZV9mbGFncw0KPiA+ID4gICAgICAgICAgbWFjaGluZV9hcmdzICs9IG1hcmNoDQo+
ID4gPiAgICAgIGVsc2UNCj4gPiA+ICAgICAgICAgIGNhbmRpZGF0ZV9tY3B1ID0gJy1tY3B1PScg
KyBtY3B1DQo+ID4gPiAtICAgICAgICBpZiAoY2MuaGFzX2FyZ3VtZW50KGNhbmRpZGF0ZV9tY3B1
KSkNCj4gPiA+IC0gICAgICAgICAgICBtYWNoaW5lX2FyZ3MgKz0gY2FuZGlkYXRlX21jcHUNCj4g
PiA+IC0gICAgICAgIGVsc2UNCj4gPiA+ICsgICAgICAgIGlmIG5vdCBjYy5oYXNfYXJndW1lbnQo
Y2FuZGlkYXRlX21jcHUpDQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBlbHNlIGJsb2NrIG9mIGNjLmhh
c19hcmd1bWVudCwgd2h5IGlzIGl0IGNoZWNrZWQgYWdhaW4/DQo+IA0KPiBUaGUgZWxzZSBibG9j
ayBpcyByZW1vdmVkLg0KPiANCj4gPg0KPiA+ID4gICAgICAgICAgICAgIGVycm9yKCdDb21waWxl
ciBkb2VzIG5vdCBzdXBwb3J0IC1tY3B1PUAwQC4nLmZvcm1hdChtY3B1KSkNCj4gPiA+ICAgICAg
ICAgIGVuZGlmDQo+ID4gPiArICAgICAgICBmb3JlYWNoIGZsYWc6IGV4dHJhX2ZlYXR1cmVzDQo+
ID4gPiArICAgICAgICAgICAgaWYgY2MuaGFzX2FyZ3VtZW50KCcrJy5qb2luKFtjYW5kaWRhdGVf
bWNwdSwgZmxhZ10pKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICBjYW5kaWRhdGVfbWNwdSA9ICcr
Jy5qb2luKFtjYW5kaWRhdGVfbWNwdSwgZmxhZ10pDQo+ID4gPiArICAgICAgICAgICAgZW5kaWYN
Cj4gPiA+ICsgICAgICAgIGVuZGZvcmVhY2gNCj4gPiA+ICsgICAgICAgIG1hY2hpbmVfYXJncyAr
PSBjYW5kaWRhdGVfbWNwdQ0KPiA+DQo+ID4gTG9va3MgZ29vZCB0byBtZS4NCj4gPg0KPiA+IFRo
YW5rcy4NCj4gPg0KPiA+IC0td2F0aHNhbGENCj4gPg0KDQpQaW5nDQoNCg==
