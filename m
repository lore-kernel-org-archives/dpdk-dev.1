Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442DD2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D07240B95;
	Tue, 20 Jan 2026 09:11:42 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60]) by mails.dpdk.org (Postfix) with ESMTP id EDFDC40273;
 Tue, 20 Jan 2026 09:11:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uap8xa9hYq3GhVC7DcvfZEX1LdXBnWi09+ZPLd0i5xS8f3za7cZXXIkUzdehAt7BHU+T7+U9doum31AzpAL1U/QjhICzSHAmVif2Z5KhFZnK7VtRDJWghUTYu9vbs9cU4fty4+2lBnwiXJmy5pxUReyv/ogR5OOstpN8qFvcDTwILg0LkkD6V57BGdUFQ78PV4OnFXfU+D5d9qWspuiPe3oO+TaHYk+bkc3uBsNN8LMsK/K7b7lT44JXeu0jrxZxE6JOIKHIwbFl8YpermFB9A7jmyMCxSe0+wMnuDrd2uPSubezM3PXL9XKnIh4sO6J7r2bb+KYuP+mXOhNLvYeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHsFFtbc9ddHTyWRwhpGT18U+rGDUKmaOr7UDEFqQdI=;
 b=DRmrB1Kh5rVtZ2mN13kCfEj53bzr/P6v5bjtf3khrU2iCwy6yCbGUWf3kdfswpkSjdpI0wtljerJPlbjcxozq9/Rm/CZehDas5APT2ZbdxwPejod0IAO5ZJ/EprBAfZmJk1DFaWqZZrA9ZpNU4DztPlNFy3UqjaR07CNtb7m0j1sC2tcpoW3jr8D9/K0H9r0WtoELZ+qHaLgGgWk/cVA5JE9IoOBVCTHFPvGNWKB+BF0L1zN9H3dLyWkjBKNM9CJvZeBMYo6wtmq1L28NiQh6Ntoewq7W4sZp5rLtRpufzAvE9x0MDuc3sitTNOiZwcj8VuBL0IxFi9aFyF2dmBxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHsFFtbc9ddHTyWRwhpGT18U+rGDUKmaOr7UDEFqQdI=;
 b=bmjPvUDBGq5HaWKTVjnsJmAWXyi0tPCwToV+GJLqamMruYU/2GkVl1EP3qAItDR9XaHxsBFeKTlTcY/LZN/6b3UX9GZhJT80NvZZJPdXrnOLrB6tiSgs9oCqSF8q3xoyB4h2FyOMfTXhLdeoxy4pLtfCLJFbba6dbDAjuxU1W8sOiwLDTq+iSg76XBhPWmXFLa+m8MPIIUhcfhVD3vCssJbjYRT9qdEJZzIK1S+GCQzfqVOAArwUWS5/yZ0VsZhRLKIoFpw6sJC2p5Ohyoft3ygG5D92dSbOgiAIS6lwMjSN6pmtNTXd09kPuSkKl+zKQAOTb9CrTcfXjgLculb1xw==
Received: from MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:11:36 +0000
Received: from MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e]) by MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:11:36 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin
 Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.6 patches review and test
Thread-Topic: 23.11.6 patches review and test
Thread-Index: AQHcf7xqN9ktUqPFgkWmF92WSgQ86bVUp58AgAYgzsA=
Date: Tue, 20 Jan 2026 08:11:36 +0000
Message-ID: <MW4PR12MB7484C0F98C8D0DDFC2822CBBBF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20260107100017.158232-1-shperetz@nvidia.com>
 <IA3PR11MB9040224D2707117312E2DBE89F8DA@IA3PR11MB9040.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9040224D2707117312E2DBE89F8DA@IA3PR11MB9040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7484:EE_|PH7PR12MB5805:EE_
x-ms-office365-filtering-correlation-id: c56bc0e2-68dd-4f09-c405-08de57fb880b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bHIvNzNkQjR3c1UxaEZyTTg4aWMvQkJJQ2NQUjhiZEJ0b1pOTWVEanltM20w?=
 =?utf-8?B?UVk0WXQwM3NvZVBwZDZZVmdIQ0RZL1dyem1GS21YbjFQb3V4dzVvYUprSGR2?=
 =?utf-8?B?VzlKdHBzTGpPaFdyZFkxVGdtMUZZbjZGMVJlaGI5QUlBbmRpRFdlYlBJdXNT?=
 =?utf-8?B?R1U5UU1pUzNyOTl2SHFwUUVTQUxWbGNCWXg4MzFvR3VCcXYzVEZKa1NtMVIw?=
 =?utf-8?B?Znd3TVA4Y01rTjV4UkFzMEFrWFBzNVZNcEFuRzRTTzdQSjVmaERyUjByVWJs?=
 =?utf-8?B?MWxHTlNxQUg2OGZkU3d2cmZvRFJyZDlXZS9qVmhyRlA3cElxVGxDc1RPdW5U?=
 =?utf-8?B?VjE0UUxHTWhJLzB0QmtjRlhEVksyc1FTNGR6aUFEQ3RDbSt1bklTSWpubHFy?=
 =?utf-8?B?N3Z0RFJYT3RTbkh1Z1ZZRDltQ0lvQ0tiODgzTFNpNmtrTGtiWGIrZG0zcTRI?=
 =?utf-8?B?M3Q5S2F0L24zY0xkUktPQUQzUHRzY2tVTUY3cllWbVdVMHRFVVlzeVN4Uzh6?=
 =?utf-8?B?NSs5RkxWSWhZc2JBQnQ0cUV5VzRTR0pNOEx5bW4zUFhucnBSY2F4UkN0YjM2?=
 =?utf-8?B?ajBPc2w0SEswWTREeVhMMDFBMGozTDdIL2RhWmUyWlFpUFI0RXRTMXpOYWF1?=
 =?utf-8?B?Sk1QWDI0RXdKR0pKM3ZEOVBIUUdDMUV2MXZqTWFBclNaQ1g5U1pQS2x0dEVF?=
 =?utf-8?B?SnAvdUtSZDgrMHhpeDc2VEhoS1FWTkw4dHFoZDBOcytoclBFY01RcjRpS1Bq?=
 =?utf-8?B?TXA3NXkxYzlnQWU5ODlnUHE1R2gxMnpTMWZZU0ZreWV1eUtYZ25QK1RMaURq?=
 =?utf-8?B?SHVTVWo5akE0ZWphZS9Meno5aVZyTW8wSmtXRDI3QmlxNjdkZWZiQnhvSXhT?=
 =?utf-8?B?TG9jRnFKWkNjOEc0RXgzdGtwYVNZNXBYbGszNTBFWDh0OFFKN0Z6TXdCVnFL?=
 =?utf-8?B?VVc2U25hQW81QUtWQXdEVWpOS3lqcFp5QnJQUXg0anJWUXU3K05oY2NYaDQ1?=
 =?utf-8?B?K25pcDBiZUNXa2xXeTJBY3VldExNSHhmKzhCZFlXUDArdGlDbGdVb2VDNUo1?=
 =?utf-8?B?MXc2VlVnbnRkdFdkSXdaRDlNOTh4NE5PdDN1REJLVy95OW1odG44cDlUYXla?=
 =?utf-8?B?c08wUTl1UC9MaENCMVJjOGxXL2N4MmpvQUJlMHdFQXQ4ejdUVkhNRTNOa1l1?=
 =?utf-8?B?d1p1QnN6Z0UvcXpmbnUrNzU1OEptR1JXdW5pKzRhcys3NFJxY0pEZDluUmpn?=
 =?utf-8?B?THFUYzRpUUZRQW1RaURib3lWMjlKRXBkZXc2MXBtbmZvdkN2YmI5REJtZzZt?=
 =?utf-8?B?ajB1RTd2Q3ExdFJjZzBUVk9vWTM5M3FCVVNDUW5HQUUxcVk0TTBuRW1aazZt?=
 =?utf-8?B?aVViNTZhczVNUVFoQ3Z5VEpQMVY1UTIvZ1lvVmdFblZXaW1vd2pveHJreWV5?=
 =?utf-8?B?ZW9RMVlBbWJ0S0lSS29CSWwvejY0dFJVcm5zblRRelJVY2dQWHZqb3BJRTJh?=
 =?utf-8?B?SG9hVUpyMFBqamhVSTR5UGZiZWttdGpjNThhUCsvUHFJZWQrOExZdE9ENFBG?=
 =?utf-8?B?amFYVkNTUU9ieHZjaFo0VGFBYjdkMzJKN09KK3VTNW9qT0NETUhqaW93ZXJR?=
 =?utf-8?B?ejIvNGtYZi8yL0xEQUhudjRtcFJkaWRRNXc3VjNWbkdPcGE1TFdXZUNSTWVv?=
 =?utf-8?B?L1hTWEp0Qkw2SUZsZDRXa2t3RTRFQVVBV1VQOW13dXRmaUFEZ1NYQU9oL21C?=
 =?utf-8?B?UkY1OHhnL3RxSk5FY0lJdFd0Nll4Y2ttSUs2YzFtM3B0MGMzbGo4T0xmMzFF?=
 =?utf-8?B?Y3NZQllwSWRMZ1E1NExiMDlBV1JvenJmb1UreWFNVll3YVRIS01wR3AzdjVu?=
 =?utf-8?B?U2xpM1VhN3JFSkxmbzNvY3NKWEZyTGZOSmNDNjMwaU5jY2lpSFVTNCtsYUNh?=
 =?utf-8?B?Y2tYaVdPdWdDdEpUbkVaRnRXTDdGWFBDVElMdEhpTFZmQldNeVZCTXN6aTZz?=
 =?utf-8?B?QmVndDZEV2pmSDNFQllFZXJKMVBMWWlGSkUra3gyMm5FOUQ4QUZzSTB4Qnlz?=
 =?utf-8?B?Y01kYlFxMFVhcm9qRC91MlJrNDhjYnVxNTZCTkNaeGVxb05ZTmE3dmp0dC8x?=
 =?utf-8?B?djhYL0lYUm1DZ2dSVDNRQ0V0NC9DaXc1ZGRrUW92RVFSdXBDS3hTay90aG5u?=
 =?utf-8?Q?aWwKnyKHi1nsmnRsRPxNtU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGNkL0xRUnpsVmNKODFCNFgxSWp1SlRPOG9pKzB5NW51Y0NpZVU4KzdhY1Js?=
 =?utf-8?B?MW1walJEVGdvWEt1TkpFVUpsZDYvdjI0SGlCTDFnZ2xBcXI4eDFNcVZWOUxC?=
 =?utf-8?B?YnJHN3J1ejZkS0pxSzRnbGhLejVzcSthcFp5N21NNmNCdGNEWGp3NTh4TmVn?=
 =?utf-8?B?WmFvRXBVWktvWXlxVnlpbncvOXNOdFV0OGJlYlc2MVRsZmNUQVplVW8ybC9E?=
 =?utf-8?B?QVQxbmJvUGg0WlgzUVliSUhGWVJCWEwrako2SU5tZXgzSlJSSFQvNEdYNmdp?=
 =?utf-8?B?QWVseTMyTitUdUNRRmVaTnRXU1IrTTIwL3ppeEhGaDRXN0FjNDVZUW1YV3F6?=
 =?utf-8?B?RGhwMTFBUmpXTGVibW5peSt6UktvU25EUWhjVzFicXhoMThPSTgwN3FIYVNG?=
 =?utf-8?B?dUthQ3c0aHRiUWtUUXZEV0lMS0NHN2hDTXdPajFvMWFodHo4RlNmREVKZEUw?=
 =?utf-8?B?c2xJWGliL3RYY1d0ZlV4T0ZSZkc4Mk0ydlBLNHVLYlY0T2JsRTBvNWtCSkJG?=
 =?utf-8?B?aEk0MkIwUG9CZi9hNkIzRCtxNjlQK2lmb0tESXRha2Q5NnhpcnU5aVlyYW5a?=
 =?utf-8?B?MlFHbjhoakRiSS94di94bW9PY1FXaTR0M3JWRjdLV3dKV0JaWGZpWWJzclpm?=
 =?utf-8?B?SmZJZ2k2MEhaa0Jwek4xK2JpcGpJZngwMk1DT2I4ZklrYm9YSURyQzZIUHVO?=
 =?utf-8?B?V25GTHkvbUtHZElZSTZsUGEvZ2dnaEpCQXgyRWUyTVRSanZVTVM4Z1d0WTFz?=
 =?utf-8?B?M0h4RzRDODE3cUVRM0VTdFIxZ2dJbnVmQS9WU05FNk9iZmVmSi9YdkNHMUVn?=
 =?utf-8?B?eVcxN3g2a1kweFNPRHovVFlHa01LV25uUG5mb0I0cDVyV3ZLaXV6L3M3enkr?=
 =?utf-8?B?UEJsWm1JcHlHYnU2N2ZseENWNVcyUTNpNkI4QXJQeUJPK2VNRlZiQkxjZGVu?=
 =?utf-8?B?Yi9qTGFCc3lJY3JhaVYrNGY3TGhwTWJuSmtmRjdVNnBMQnYvRWU4R2FnNkZB?=
 =?utf-8?B?RC9Dam5KZUQyQm1aRWdZZUlpZ3hBN1lCZUxIKzhITmszeHJrSnQ0d0ZtWGp5?=
 =?utf-8?B?OTNEVk5OcVhQUTFqTXJmMTgwbDFSckovUWNEdDBJVU1FZnlCR3FZTkRTdEtS?=
 =?utf-8?B?Q0M3WTNmd21lL0pLRWsxTTV3VTdLTnJGQlJNZ1o5S0RRWkl4Y3dQYXR6Slhv?=
 =?utf-8?B?Y1hCYzhTOWVBaHplZkR2Slh3am41Z2dCcHVIWUR6MUY5VVY1SXB4Nld5dEFv?=
 =?utf-8?B?bmRZNEhZRzZsRVhXZXgwUWozSHBlcmpSbWorQWJsM2NVU3NJcktKZ2FrdVlU?=
 =?utf-8?B?T2lidVhUTERpRlozQllVK0N3QjFvbVlacGRtZzNOdjJQODBtTE1mdEN0M1Bj?=
 =?utf-8?B?Q3JRb25rV2U4L2NtOS9kemdnU0h2SVBjTmdWa3ZBaGlRQVFjU3ZvbW5MZlJI?=
 =?utf-8?B?N2xRdDhwbkl5enpQVUJ2RGFWbUpPdDNHU0J6VE9RSk8yNWNFenMyTndQcDhI?=
 =?utf-8?B?dHk0Q1hUekR4NFZ1RXd3TGxHUStTUnZmYTdGSzZyWWZ2MlRRKzEzRnVXUW9z?=
 =?utf-8?B?bFIreHM3eHhtd0xYbEpYVkhaZ0REQnNjQ3h0Z09rWWd3NlFzL0FBS0FYSzNH?=
 =?utf-8?B?NGFuTW40MFJWbGtYM1g2ZWVoRFUwTks5dWtRcytTWWV1UTBSNzc3WWcvRkNa?=
 =?utf-8?B?Q2RETnpLSmdlbW9OVEZSYUNBRWwxRGxmRzhtY3dCK2ZFazl1dzFPQW44U25P?=
 =?utf-8?B?NCtwRDBpZi9pVWRabTcvSkw0L1NRWTF1dEFST1FaZDNDcUxjaDZYVmx4U01q?=
 =?utf-8?B?UTREOW9WRWdHRHVLbVRvSzNtTnZNYURkUXhUYUFhR1RVajhBdGg5STR0SUZJ?=
 =?utf-8?B?eGZNTHVkNHllbXhjSjJ1YlJIcSsvVS9lWmtpaVA1YUhGaENoT2s4Q202eGlI?=
 =?utf-8?B?L1UvWmY3ZHhXMnhmVTBaalFKbld4UzFORUZKU0JWdkN3Qy85d3V6bGo2bmE1?=
 =?utf-8?B?Q2dzZWxzcldvZnF4WUFWOHRCSUk4UWxaV3BISVlGd0JaNlBNbmdLb2htbEJW?=
 =?utf-8?B?M3UwQjdoVDd1UEN5WWFlb3pCUDRQTjNzdWVlakxKN3RnNmJjQTdFWUZzUEhG?=
 =?utf-8?B?Rnp1dnFETW1KZTZpYjdOLy9xZDFiSGRzRi94RSszQXdiL0J0ZnlaODhuZ2Y1?=
 =?utf-8?B?cEgyS2JrUnlFaVpPcUN3ek9teGxCdFhJa0JiQjduVzFQd0F2cnJuSmJlTVNZ?=
 =?utf-8?B?NXlQZ2p5VmdPYThXVG9TYzB1c21UUnBJN2tyUysvaVBhNEt5a3o5V3F2cDBN?=
 =?utf-8?Q?hp2K3zWQ2BXHuEu38S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56bc0e2-68dd-4f09-c405-08de57fb880b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 08:11:36.4010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4MddBYwoZRYrx5lLCi++CdIm+EjIJcJK8nnPXTpmwEAiUCrivhDFa91hApvt1ISAiksfE4xcNn6d06vqNai5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWHUsIEhhaWxpblggPGhh
aWxpbngueHVAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIDE2IEphbnVhcnkgMjAyNiAxMjoz
Mw0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUgPEFiaGlzaGVrLk1hcmF0
aGVAbWljcm9zb2Z0LmNvbT47DQo+IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPjsg
YmVuamFtaW4ud2Fsa2VyQGludGVsLmNvbTsgRGF2aWQNCj4gQ2hyaXN0ZW5zZW4gPGRyY0BsaW51
eC52bmV0LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhwLmNv
bT47IElhbiBTdG9rZXMgPGlhbi5zdG9rZXNAaW50ZWwuY29tPjsgSmVyaW4gSmFjb2INCj4gPGpl
cmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huIDxqb2huLm1jbmFtYXJhQGludGVsLmNv
bT47IEp1LQ0KPiBIeW91bmcgTGVlIDxqdWhsZWVAbWljcm9zb2Z0LmNvbT47IEtldmluIFRyYXlu
b3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+Ow0KPiBMdWNhIEJvY2Nhc3NpIDxibHVjYUBkZWJpYW4u
b3JnPjsgUGVpIFpoYW5nIDxwZXpoYW5nQHJlZGhhdC5jb20+Ow0KPiBxaWFuLnEueHVAaW50ZWwu
Y29tOyBSYXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+OyBOQlUtDQo+IENvbnRh
Y3QtVGhvbWFzIE1vbmphbG9uIChFWFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5uZXQ+OyBZYW5n
aGFuZw0KPiBMaXUgPHlhbmdobGl1QHJlZGhhdC5jb20+OyB5dWFuLnBlbmdAaW50ZWwuY29tOyB6
aGFveWFuLmNoZW5AaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJFOiAyMy4xMS42IHBhdGNoZXMgcmV2
aWV3IGFuZCB0ZXN0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiBGcm9tOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+DQo+ID4gU2Vu
dDogV2VkbmVzZGF5LCBKYW51YXJ5IDcsIDIwMjYgNjowMCBQTQ0KPiA+IFRvOiBzdGFibGVAZHBk
ay5vcmcNCj4gPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hlayBNYXJhdGhlDQo+IDxBYmhpc2hl
ay5NYXJhdGhlQG1pY3Jvc29mdC5jb20+Ow0KPiA+IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlk
aWEuY29tPjsgYmVuamFtaW4ud2Fsa2VyQGludGVsLmNvbTsgRGF2aWQNCj4gPiBDaHJpc3RlbnNl
biA8ZHJjQGxpbnV4LnZuZXQuaWJtLmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+ID4gPGhlbWFudC5h
Z3Jhd2FsQG54cC5jb20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmlu
DQo+ID4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huDQo+IDxqb2hu
Lm1jbmFtYXJhQGludGVsLmNvbT47DQo+ID4gSnUtIEh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3Nv
ZnQuY29tPjsgS2V2aW4gVHJheW5vcg0KPiA+IDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYSBC
b2NjYXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz47IFBlaSBaaGFuZw0KPiA+IDxwZXpoYW5nQHJlZGhh
dC5jb20+OyBxaWFuLnEueHVAaW50ZWwuY29tOyBSYXNsYW4gRGFyYXdzaGVoDQo+ID4gPHJhc2xh
bmRAbnZpZGlhLmNvbT47IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9uLm5ldD47DQo+
IFlhbmdoYW5nDQo+ID4gTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsgeXVhbi5wZW5nQGludGVs
LmNvbTsNCj4gemhhb3lhbi5jaGVuQGludGVsLmNvbQ0KPiA+IFN1YmplY3Q6IDIzLjExLjYgcGF0
Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gPg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEhlcmUgaXMg
YSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDIzLjExLjYuDQo+
ID4NCj4gPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyBKYW51YXJ5
IDIydGguDQo+ID4NCj4gPiBQbGVhc2UgaGVscCB3aXRoIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24g
b2YgeW91ciB1c2UgY2FzZXMgYW5kIHJlcG9ydA0KPiA+IGFueSBpc3N1ZXMvcmVzdWx0cyB3aXRo
IHJlcGx5LWFsbCB0byB0aGlzIG1haWwuIEZvciB0aGUgZmluYWwgcmVsZWFzZQ0KPiA+IHRoZSBm
aXhlcyBhbmQgcmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZCB0byB0aGUgcmVsZWFz
ZSBub3Rlcy4NCj4gPg0KPiA+IEEgcmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91
bmQgYXQ6DQo+ID4NCj4gPiAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUv
dGFnLz9pZD12MjMuMTEuNi1yYzENCj4gPg0KPiA+IFRoZXNlIHBhdGNoZXMgYXJlIGxvY2F0ZWQg
YXQgYnJhbmNoIDIzLjExIG9mIGRwZGstc3RhYmxlIHJlcG86DQo+ID4gICAgIGh0dHBzOi8vZHBk
ay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlLw0KPiA+DQo+ID4gVGhhbmtzLg0KPiA+DQo+ID4gU2hh
bmkNCj4gPg0KPiA+IC0tLQ0KPiBVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJbnRlbCBwYXJ0
LiBkcGRrMjMuMTEuNi1yYzEgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLg0KPiBmb3VuZCAxIG5l
dyBpc3N1ZS4NCj4gDQo+IHVuaXRfdGVzdHNfY3J5cHRvZGV2X2Z1bmMvY3J5cHRvZGV2X3FhdF9y
YXdfYXBpX2F1dG90ZXN0OiBBRVMgR0NNDQo+IEF1dGhlbnRpY2F0ZWQgVGVzdCBTdWl0ZSB0ZXN0
IGZhaWxpbmcgIC0tIGhhcyBmaXggcGF0Y2ggZml4IHBhdGNoOg0KPiBodHRwczovL21haWxzLmRw
ZGsub3JnL2FyY2hpdmVzL3N0YWJsZS8yMDI2LUphbnVhcnkvMDU1NTQ2Lmh0bWwNCj4gDQoNCkZp
eCB3YXMgYWRkZWQgdG8gMjMuMTEsIGNvdWxkIHlvdSBjaGVjayBpZiB5b3VyIHRlc3RzIGFyZSBw
YXNzaW5nIHdpdGggdGhlIG5ldyBwYXRjaD8gaHR0cHM6Ly9naXRodWIuY29tL0RQREsvZHBkay1z
dGFibGUvdHJlZS8yMy4xMQ0KDQo+ICogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUg
YnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbg0KPiB0aGUgZm9sbG93
aW5nIE9TKGFsbCBwYXNzZWQpDQo+ICAgLSBVYnVudHUyNS4wNC9VYnVudHUyNC4wNC4yDQo+ICAg
LSBSSEVMOS42L1JIRUwxMA0KPiAgIC0gRmVkb3JhNDINCj4gICAtIEZyZWVCU0QxNC4yDQo+ICAg
LSBTVVNFMTUuNg0KPiAgIC0gT3BlbkFub2xpczguMTANCj4gICAtIEF6dXJlTGludXgzLjANCj4g
DQo+ICogRnVuY3Rpb24gdGVzdHM6IGZvdW5kIDEgbmV3IGlzc3VlLg0KPiAgIC0gaTQwRS0oWFhW
NzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nDQo+IGJhc2ljL1JURV9G
TE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+IG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZY
TEFOL1JTUywgZXRjLg0KPiAgIC0gSVhHQkUtKDgyNTk5KSBQRi9WRjogdGVzdCBzY2VuYXJpb3Mg
aW5jbHVkaW5nDQo+IGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+IG9m
ZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0KPiAgIC0gSUNFLShFODEwLCBF
MjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9Td2l0Y2gvUGFja2Fn
ZQ0KPiBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FD
TC9EQ0YvRmxleGlibGUNCj4gRGVzY3JpcHRvciwgZXRjLg0KPiAgIC0gSVBzZWM6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5IGJhc2ljIHRlc3Qg
LQ0KPiBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCj4gICAtIFZpcnRpbzogYm90aCBmdW5jdGlv
biBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcw0KPiBQVlAvVmlydGlv
X2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZg0KPiB0
ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjAsIGV0Yy4NCj4gICAtIENyeXB0b2RldjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9Db21wcmVzc0Rldg0KPiBJU0Et
TC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQo+ICAgLSBETEI6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIuNQ0KPiAgIC0gT3RoZXI6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBBRl9YRFAsIFBvd2VyLCBDQkRNQSwgRFNBDQo+IA0KPiAqIFBlcmZvcm1h
bmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KPiAgIC0gVGhvdWdocHV0IFBlcmZv
cm1hbmNlDQo+ICAgLSBDcnlwdG9kZXYgTGF0ZW5jeQ0KPiAgIC0gUEYvVkYgTklDIHNpbmdsZSBj
b3JlDQo+ICAgLSBYWFY3MTAvRTgxMCBOSUMgUGVyZm9ybWFuY2UNCj4gDQo+IA0KPiBSZWdhcmRz
LA0KPiBYdSwgSGFpbGluDQoNClRoYXQncyBncmVhdCwgdGhhbmsgeW91IQ0K
