Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FECE8D47
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 15:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C0140E32;
	Fri, 14 Nov 2025 16:59:00 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A815E40E2C
 for <dev@dpdk.org>; Fri, 14 Nov 2025 16:58:59 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEFpZ9j4174662; Fri, 14 Nov 2025 07:58:58 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022110.outbound.protection.outlook.com [52.101.48.110])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ae7ef00ge-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 07:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMoIp0KmL+6pMlyJlnBsRgNpt9x5Js8zZqiw5TTvX5heyhhpN/Mj6LS18Fz8Vy62QIDE1fXFDCr4TH1UyFP+wdINxMgdynECczJJiu3RwVAf2HzngV43OIL81lame0bDV5kw4S9EYFjZm4JdJmcoHvjyaowOrhIKlxpvlQ1XFVH9d3XFHJpnRivVwFBu7+oNvgx9XhI/ydbQo98gsngdxvURmSvfaqVJykNEOuFMgG3B+RHpT0cKCL2R9kMM9J/h5qLomtresP/nFQ4UvqY5ep0Vudy/VTDlcuQb0aFYAdyHCBYCfswX7FetgOMVCYKjYpzPAlZtLG4mL+mv1piEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtupkOaTCORLZfLvFirLEBQjkl3KK4bB5YYctWuh+NI=;
 b=lkIEp75lRg4Rz4wVBQNZ2q89l3Loj+5EQ9qzZp9jvDhN1/D7U9+EKow51oAIdtTa9tK8jjIhZ2C8YziXci9cs3jjIgbAz6Mbm7weHu7+axhiPuZi0hjkXVoiKJtTjMBV2nJ9io0DPWvrqCImGX9jSijvvCNmanIvRl3XN6292Xyf6P6+FhQQ8N5+mrR0aMegVDJHqIhYGUvWbKpWnZ7zSJVej8oFU4FAzCZbdftVSMDmhYYa9fDkyCs3mZ/lFKSYOhC8x0XxKgHBigis7Ee6zhZr3LtsI5hrL756NLtxjCN+n4Qg0zQAhP0luUX9N3amm0jLNMnsSOa0vm7KBuglgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtupkOaTCORLZfLvFirLEBQjkl3KK4bB5YYctWuh+NI=;
 b=IPm5Mf2dS3BH/OBieLK9df5slZ4DQRHayo7EEYONKaArmUj2D7VyU15/QpjVkQ8Rmg0pNQRsVTZ2JoOBWRbCV24Gm4JsuzVOCo6969ZGqhUbl9yxCwwGU5VrETVjWH/oxsJly+9xeLkIurTK/9gjRwo83COG3xLb+YQFzHak34k=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5116.namprd18.prod.outlook.com (2603:10b6:510:16d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:58:55 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:58:55 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>, Fiona Trahe
 <fiona.trahe@intel.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3 1/2] crypto/qat: fix CCM request descriptor
 hash_state_sz field
Thread-Topic: [EXTERNAL] [v3 1/2] crypto/qat: fix CCM request descriptor
 hash_state_sz field
Thread-Index: AQHcU73VWmpzt2WdGEqrtVcaKjVjJ7TyV0Cg
Date: Fri, 14 Nov 2025 15:58:55 +0000
Message-ID: <CO6PR18MB4484F9DF5C9AB5F558037C88D8CAA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251110170107.2296951-1-emma.finn@intel.com>
 <20251112101911.2377840-1-emma.finn@intel.com>
In-Reply-To: <20251112101911.2377840-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5116:EE_
x-ms-office365-filtering-correlation-id: 7559b378-c86d-4219-4947-08de2396b72d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TS9XK05hM1I1bCtuZGZDbXlBQmszTmhITVYyanp4YVB5eitJUWx0S3NSQzBK?=
 =?utf-8?B?aW1YWXhjN1JyVmZHbDNENXlIOWg1UzJheG4wM0lvWWVmQVlYWjNva21rd1Jr?=
 =?utf-8?B?TTRGMEM1UDZIbHhaYVhzY2UrcnkwdU1qMnAyMnJVS2g5Mkp5WTZsR2x0SXBB?=
 =?utf-8?B?dWdQMExYcE5NNnlhYnhucmN5MTJmenNESW1MdDRWVWFVVWpQc0U0ekQrcXVy?=
 =?utf-8?B?a0ZZdWpTQ0ZzaU95YzluWUlqaVJBY3l4bERJSkhrbldEbW0vRlAzNjN3K09s?=
 =?utf-8?B?d2Ricmc2aWc3bk9ZNTNlOG9zZFJMbHh5dzM2ZXdrRHRtNkxMWnlHZUpxN2dJ?=
 =?utf-8?B?NkRRWjltVWZVRm5wOXRrVS9aMWprbytBR2xHU1dFczM0d2hobzBJUSt2WkVP?=
 =?utf-8?B?M255M2hCT0Ribkt0SFRXYklsTUt3cEc4NDRUTHRNTHllT3kvMWszZWZJdGlX?=
 =?utf-8?B?aHgzLzZDaDQ2K05rbTBSQjRVU1FoczVkcFZkOCs0OTdFVjZxWG9IK0RMcmRS?=
 =?utf-8?B?WHlHZzEwR2l5V255NFBJK3EyNzY1TmRLbWwvSTRZSFU5Q3c5K2tFVW1FNEhq?=
 =?utf-8?B?clRnT0c5K2NpZGJaS09xWWcrSkpJcEd1OCt6WlFWRVgxVUZoVE5hRDcyZlhL?=
 =?utf-8?B?bWJtM3RUTWdQbXJLVXNzajZ0ZjUrTGpXMkxzZUcxVkFsYTVrTWNIMzdHd2VN?=
 =?utf-8?B?Mk9jbHNOS1YrbDMwS1ZKazJEczYvYUhXS0M4TkRBaDZiSXVERHp4c01tcWlP?=
 =?utf-8?B?MVVpUFZZNFNQZUF3VzA4Qk10ZkpMd0ZXK0tHblFLV240MkpZbnJVOTJYUlcz?=
 =?utf-8?B?OTF0VnRTMk15Slg3UUxnUWdXYzhNMDFjQVNqb1VkZFh1b0cxT0NWRGVLWXoy?=
 =?utf-8?B?cXF6MUhQdnpCMTlVbk1RY0ZIcGtUM2VHOUJ3bWdRVjN0TEx1RytCZ3R3dWFL?=
 =?utf-8?B?TkxKclEyYmZGVU0wV05ZS1BVbDJOMlZCM1hBUk01bDN1V2Q3dDh4Lzg1dlkv?=
 =?utf-8?B?bU1INnhxdDc0enJrcGJqTlBmcFpHSHFWdmpCWHlXb2VIWUJ6RjZtR2JLMTR6?=
 =?utf-8?B?NWNmOGRXdlNGY0dFQ0NuOVB3endEekZTYm5aVnJkaTlJbTdndHVNZldkYU9Z?=
 =?utf-8?B?QUZNNld2b1RleUlXazE4UGZ4ckJxV1U1ZmZDeldjejI1SHluSEhEcmNyeVk0?=
 =?utf-8?B?OXBwUEtTOWdiZkt1dkVaR1NPa2s5RkJFbUFkdmdORjYySUVSbVNvV0lFejhJ?=
 =?utf-8?B?NTRycGJSWVZlTnBLaStGK015MGtuMHUyYVFBeFdjWjk0TEV0WVI2V3lqUXlm?=
 =?utf-8?B?a1psREZld0l1dlp3STBaZlplY3lhN0I1VUdTa2NORlQvYnRTbFlVeXpjOXN0?=
 =?utf-8?B?NXJGeEorT3h1cW5RaHE5QzRCcG5mNld1eGxCbGxCK2gvWXZtd20xY0tpVUxQ?=
 =?utf-8?B?ZitpZnJzaHR5aGhjVm4xQWN3OHNNNUR4SkxYd0lNSFpzWTczT3dZdlZuQWl6?=
 =?utf-8?B?U2pLSHV3ZGNrRkxSdzJ3WTdZU3pUeWZqTWhuVzVERXdtVVUwMS9YdnFGVjh5?=
 =?utf-8?B?UlJHOWx1alNoYXBnRGRMbW5SNUdhL0lmcGlGam5MM2tVSDlMbjlEeUErWkRs?=
 =?utf-8?B?elcyNThDUkF3b01ZYlN5NEVJTHhLaVFyUzlsRHk3MzZ5QXA3aGlGTFBwVjRN?=
 =?utf-8?B?NnI5UmNiTnBETzVnMm1PZHRoNWxYVjNoQzJWQmZrZEo5c3MyYmQ4c21lK0Iy?=
 =?utf-8?B?NUIrR2pWY1ZXR2p6YjFpL0Q0dVF4VHNSWDBzZGQ0bUdiVjZkVnJoSisweE11?=
 =?utf-8?B?VTJtd2VWVXpqWVFjckdZL3BuNDZOQUtaaHlJb2MyWEl4RWlmSXN3TkpxeU9s?=
 =?utf-8?B?Y29jZFJKVXpXb0R2aXFrc1ZZV2dTamRvRXl0UEtuejFKOGxYOGJ3Tjc4RThr?=
 =?utf-8?B?SkhBWkxxMWJlTmVkN1JSZ2R1RFNrb0p5bkRJbWQ0RmE2MUFRTlUzc1AvOEhN?=
 =?utf-8?B?R2daa3haeCtmc0xyZ2hOQ3hzQXF4WFBZSDhyMU9rZjdxNE01SjZtT0Y3SWlW?=
 =?utf-8?Q?LskXjL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21RRVBZOXJjb2RlVFZycnRVLzR0WUxPZ21XTWwrY1IrS0RkWUxjTlZuOFY2?=
 =?utf-8?B?QzhMTVBTeXBOSUVyNVp3RytTVjQ4NS83cHBrV0IyNWp0MWt1Yk9TNWRiQXBF?=
 =?utf-8?B?R0JPYWJnYXhxOElvc2Q3ZTJCOEc2YnpnalFBNGFJb001bDFiNDdhck1TSEQr?=
 =?utf-8?B?dEpZMnZhaGxrZUltanhoaWFSOGhQTEp2M0dmSnNoekJVdlQzMU1UY1ZoMVN2?=
 =?utf-8?B?Wkx6c1F3d2c2dFBIY0xIWmxFK2xUL2htVmd2QUtzN3E2cnJDdDV2YWpITEps?=
 =?utf-8?B?ZXFEajBNV3AvN3FKaW5RMzZOZW8vMFZTK3htbU5rRkR4OTdGZEgvNU5uQWI1?=
 =?utf-8?B?blZWU3d1QWxYOVZMOHVYNXZpd1FENEhjK1JHN3Q3UytaSE1tTitXMTByVVNl?=
 =?utf-8?B?VFJoOEE1T2tZVlpmT0QwT2RRYld3eWgwcy8yajFLY29YM1gzeWJtMlovODJB?=
 =?utf-8?B?eTQyMFJOc2tVcktxcnBrakFOcGFpdVJFL2dqYXF0d0dIcTVKQkczTlVBYWF4?=
 =?utf-8?B?aDVaZW9pV1ozZWRabi9iNE1NU1pTYzEvTkFVMWxiTFAxYkl5d1NERGdIVzhT?=
 =?utf-8?B?SExJM1pWbGFDZ0JvcTBSZElMRFZ0TGdJdWNkeEVtWlZCVkZadWwyUnB6eVhU?=
 =?utf-8?B?K21yYWpHZHBhYkJuVjR0bDlUNmRGRVFpOTIxRk5JeTJTRFBLMnBDbld5RzNj?=
 =?utf-8?B?NmhzVVl4WmRaazZNV1ZLUUJlU25jZGtPS3Izd2dqQ0I1cmF2ZDQweUpiZG54?=
 =?utf-8?B?aXd0MXJFR0c5eUJBM21kYXdFdGZYd2ZZUmE5YnJRbWw4dEt0dUJrVHBrdGhE?=
 =?utf-8?B?SldMa1dkY0toM0JoZkRTZDRPUzhUMURnSHpYUGVTVlBpdGg1ZWViSXZHeUlv?=
 =?utf-8?B?UHgybDF3YUNQbytZWjdiNHlzYWV3NzhpcFkycTBIbzJ1c05Bb3p0V1MvUFJG?=
 =?utf-8?B?UzNIVDVPVlh1d0xFUXNrTndvM2pzRkFuWXBqZDA4cVl5djRNVGZmNWVDY2lq?=
 =?utf-8?B?WTdUZU04dGE2Rm1DUmVCbzNZQ2oxNkxHM0xoQkk4NjZ5Rm5KRGp4d3ViS1Ax?=
 =?utf-8?B?ZXh1U28xUVYvSnpPbFExSjJyV21ScktXUmJZL1NKQmhXZTM5U0hPK3g5YW5R?=
 =?utf-8?B?VFhWOWJsajZnQjBodmI1Q1lSQ3lHTWZHN1hBeEZCSXhsblA2YUtGMTludVND?=
 =?utf-8?B?aUxSZDRrcmRPeFE0QzhhenpuL2c2RlVoamY3NXdMelcyRFhvWjdmd0lIUXF0?=
 =?utf-8?B?RGlwRjBnWVUrekVIaHNWanVkeTZPazBpcVdqd1ZQcjZZV3lCRzJMSW9nRkli?=
 =?utf-8?B?eDFzNk1jWG5yVWErKy93R0RMK05lLytFeHNEeGZxVlBLWHpvMFpkeVhia0lw?=
 =?utf-8?B?SmtZS1U5NlpkWUlqMmJDdUhBTzV0YThTRlliZFh0bXA3UWcxdmZTUTdvMjQ3?=
 =?utf-8?B?WlNFTmRNTE14UFNXaThJM1hheE5sL3c5UUdjbk1xZHhqM09XdGNpUUtOS1Yz?=
 =?utf-8?B?TXZpNGNjS1Z2VG9uTmpTOTFHamxXdlp0OEFnTjEvQlIzd0JCYzh1Q3crWTl6?=
 =?utf-8?B?SE16SFJESVpqWUtTVS9IaUQ4REh2YU81QTRwY0cvRFRHNUN5VEc0Vi9ISlUv?=
 =?utf-8?B?OWwxbzYvcXdSc3FoNWtsQ1htVy9IYXBBN0JyNUN2UWlNbkZSMkFSNU1ocTdj?=
 =?utf-8?B?Zjh5bTBNK3dnMVFBTGRONU1SS0V6OFViRWtyQVA2UUhWVDllRkVTMzVvUXFo?=
 =?utf-8?B?eXUvVG9uL3BWdzhyanBZenh5azUwYWxtcm02cU9pWjdSc2dmOHVDRk11azFF?=
 =?utf-8?B?TnB3NlZJaUl6MXJUS1VZYkRMKzRUSmk3bmlGd2VLeDc4Uy8zRXY0cUR4TVlO?=
 =?utf-8?B?cDhpZFZPOE92YlNyRmFZVElkeWhEQ05aOEplMm4zNW1kQmY3cENicW5YNk5m?=
 =?utf-8?B?bk8xdTJ5TG9uUGxLQ2Uya3lVRHhvZ1hEYU5NdGg1dTJVdHk0TkIwR2hVQTBw?=
 =?utf-8?B?azF3dVRqS0hZbG1nMVl0dW94RjZSSWRteWpFdU1lb0srN3JjQ3RLbi8yVC9n?=
 =?utf-8?B?aVppbWtEdjlLR1F0Mm5iODIxNFQzZTQrTTAyZkg5WHk5VmhCZUtGM3d1bEUv?=
 =?utf-8?Q?jx0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7559b378-c86d-4219-4947-08de2396b72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 15:58:55.7594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+h77BKWJmsUe49UFmxtoxjrr+k5vHoWDsKQU/WQ4vk5idwhC2SOBAYFrEpn7/4trjcjHU/DnLs3iQ/ZAf/8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5116
X-Proofpoint-GUID: UfGFnvmOGUAjywMm0PL0NudkdFzFMK3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEyNyBTYWx0ZWRfX3En7MnPN5R6B
 PA7E7Mp1+Ssv2xbMmMguDajNlLE/jPLNb3Iwy3rgHn7yzMjbqG+L71SiDUfjmlvsMSQOLN6Gm09
 U5uSEs3FDBtYIOXtrrYgiK045JthxuBiSN6UuL3hTdP3jRlHihndT1kytHoe3agQUCFsn3D15IH
 CqL4PrUspmMIt8jGuevx0+DOlw2Bi7fhPJCDoU4ePB3X62CSfP1kHctYDi0TRbfGFitIAT0eP6n
 v/NpjvBX4BVWJUfnoTXqlg35Jt4DbZPfh7BkGmZoFXCe5rk3PN89ENygd7VfjQJOi+S7FajRzKp
 lQH6iv0AjFeN2zhKRXtpx41+ng11g3lYSD1rc02MBjkqzwi0cFwzmhEn81Itvvz6Ye7A3pIUI62
 AMin85L1wO3KE6ncUTgDZsIfzh1UjQ==
X-Authority-Analysis: v=2.4 cv=Y+r1cxeN c=1 sm=1 tr=0 ts=691751c2 cx=c_pps
 a=ylTaWg/OuTOBUQxDHB/KXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=qxHHMbjqLlHSX_1UxvkA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UfGFnvmOGUAjywMm0PL0NudkdFzFMK3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
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

PiBUaGUgaGFzaF9zdGF0ZV9zeiBmaWVsZCBpbiB0aGUgUUFUIHJlcXVlc3QgZGVzY3JpcHRvciBm
b3IgQUVTLUNDTQ0KPiBvcGVyYXRpb25zIHdhcyBpbmNvcnJlY3RseSBzZXQgdG8gdGhlIGRpZ2Vz
dCBsZW5ndGguIEFjY29yZGluZyB0bw0KPiB0aGUgUUFUIGZpcm13YXJlIHNwZWNpZmljYXRpb24s
IHRoaXMgZmllbGQgc2hvdWxkIGNvbnRhaW4gdGhlDQo+IGxlbmd0aCBvZiBBQUQgaW4gcXVhZHdv
cmRzIGZvciBDQ00gb3BlcmF0aW9ucy4NCj4gDQo+IEZpeGVzOiBhYjU2YzRkOWVkOWEgKCJjcnlw
dG8vcWF0OiBzdXBwb3J0IEFFUy1DQ00iKQ0KQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwuY29tPg0KVGhpcyBwYXRjaCBp
cyBhcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCkZvciB0aGUgc2Vjb25kIHBhdGNoIHBsZWFz
ZSB1cGRhdGUgZGVzY3JpcHRpb24uDQo=
