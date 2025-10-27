Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E11CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 15:32:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50371402D7;
	Mon, 27 Oct 2025 16:32:04 +0100 (CET)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022096.outbound.protection.outlook.com
 [40.107.193.96])
 by mails.dpdk.org (Postfix) with ESMTP id 130094028B;
 Mon, 27 Oct 2025 16:32:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvSZUUewDyO3VjqwCkTSjVLO3GSA7/E4X9/hgXSoEwJHXW2MbtUXndwp0XVp1mUsOMW19nqtM2xpjnxRHv2i5ymOZtW9DCGZWYLqnH+Ydmsm3OzDUIHOocsWfo2KLem0YgiyLmvv3qIQQn+CPhGZ+Wpug+BJHadmiCha8O0arRTQ69AQIbZdtFftVGGBvp/2yymxAHN3CG2ZqBzDU1rC7kinZnjyC2TVvky17vpYg/B79LwEEjDs51l/bznPs2wpSSa2achJ0tuDxJexJ0Y+UEpRlODWXyEqCG4vfoxNXn4I/sHHXjWDvnzgx+7J3RczT9wJtCHNdTk7oocWj6GAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhdxpXzTRvQznX23iImtTDeFDQc9eb7ao0GB42dWB7M=;
 b=DnE7yn3SpEOwPm+rAI3u9wHBq/s3kK09t24AIdbypzqXdqAwya6IksvAI5+2suaJq2zoFCF44mCESfhtTtIBEgkUEPBZD8rzdow+t/JT1JHCef5TUaaYIyivA0eFAXGRuyatEc4IeKcRrrAyhw1jOLtkUlkaTl0rnF8hJdrf9WF4hvwn/V1sOFgtJfTBirXqw6m86Ja5veYtqmPDjuYe4dn5eD8b95rOa6MPKaeSI2Yekx4qNqDDm0WmMbPqx+ztZvjmXVF/KLtiUPDOuEuz4FYORyhU3rfCuzEfZQaorJtVEI5FKGWxOadwGgMJS3cxtj5fPIAkQhSHb0pC+7TTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polymtl.ca; dmarc=pass action=none header.from=polymtl.ca;
 dkim=pass header.d=polymtl.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polymtl.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhdxpXzTRvQznX23iImtTDeFDQc9eb7ao0GB42dWB7M=;
 b=NMfnell3EW7TzRzs1bCuROySx/mD2UVFzeqghFE6dfn4A6EIU5n038hOeVaN5bDgy8wbfnhadzw626Ey4Qn5ZMcpnkNS4C4+hOGCKv1aqo3OBKmkfjuqdOhxY6pQWyRxzuu+mfidfSZKSmn0nQKd60RPsvd9n6xvMsXPTYdN+9jko9F9+irjtGPBJlbG6ADtJNxF6GppJCURk1iQZgVkZmv7Upy7gU0fVXwXTkx3JItOYRPGybMFOpGgLczCLDAXYmguLQH6KaViamY9Z85ABU8h7VeqM2K1yWFtN0TCC6msC7tktCFBMXXH1vzrUB43fyElnsc3UmWLfTQnY05D6A==
Received: from YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c9::20)
 by YT2PR01MB10369.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 15:31:48 +0000
Received: from YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1416:213a:12eb:93ec]) by YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1416:213a:12eb:93ec%6]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 15:31:47 +0000
From: Adel Belkhiri <adel-2.belkhiri@polymtl.ca>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: =?gb2312?B?UmU6IERQREsgb2JzZXJ2YWJpbGl0eSBzdXJ2ZXkgKKHWNyBtaW4p?=
Thread-Topic: =?gb2312?B?RFBESyBvYnNlcnZhYmlsaXR5IHN1cnZleSAoodY3IG1pbik=?=
Thread-Index: AQHcQpUfW/LllDpFwUifqnuIQ+jgXrTRWYmAgATLAIM=
Date: Mon, 27 Oct 2025 15:31:47 +0000
Message-ID: <YT1PR01MB88261798F3919CB8AF4D68DB8EFCA@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
References: <YT1PR01MB88265C8B9023D8653C29BCB58EF2A@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
 <2720733.htQpZWrp2x@thomas>
In-Reply-To: <2720733.htQpZWrp2x@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polymtl.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT1PR01MB8826:EE_|YT2PR01MB10369:EE_
x-ms-office365-filtering-correlation-id: d42d39e7-054e-4dad-d82c-08de156df163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|38070700021|7053199007|13003099007|8096899003;
x-microsoft-antispam-message-info: =?gb2312?B?ZTNrV0dTaG9uOUtnVWxOaDBmOHFOQUtpMnM1R0VaNVZTWXAwUmRDcE9ETFR2?=
 =?gb2312?B?MlJFdFlibFB3VUpmUXl5UmZQS09QT09mZUZMbzlXNklEWWxZREFlV2JlK0Nn?=
 =?gb2312?B?MUJDakdZVm9wdkJuemk5QXlJRkgreEsxWXVXRzlpUzRTb3R1Q3lEQWtaY2NT?=
 =?gb2312?B?S2l3SGEwSUVmS2xCSGR6MGRaWndHQmZIL1dEQjVObW9lM0xYcFd2RnhzTHEr?=
 =?gb2312?B?emVtaWZYWkE1c2N4aDlFRVdhUVZYMldLbklOUFdFcW5ZeGkvUkpxWkNwY3BM?=
 =?gb2312?B?eFZxZ25IZHI3TWZaU2JkWWhaV041dk1GUmxnekQ1OVg3Skg3QTJKZnBYTWZ1?=
 =?gb2312?B?ZDJmQ3FEcVZLQWErQUFJNUU5WmdENmZRZzBVaUx6aUdUaWtPZW93R3BNS1NG?=
 =?gb2312?B?S3g2ejFKWHV1OHZ2TkNwRUExVUthcWR6QWErcVNuSFF3NWMyajJlOVdIQU9h?=
 =?gb2312?B?bnlqcXNoNG9vdGg5WDdPamsrOGxiZWUrdy9GdUlUWHc1bFVTVmY1b0hCOVFr?=
 =?gb2312?B?ZEYyS0NDUmpkNzdqQ1hYVFpJNkRoVXhkVHpYbFNxWThpcDlMVzlEOHEvYlZM?=
 =?gb2312?B?VGp3N2c1cGZUeHk5STlHNHZpU2F3cGhYMDZ0ZS9BVGoxdnMzY0VwUEk3b0sz?=
 =?gb2312?B?TXJEY3c5SVNwYTN6c3RPWGdnbjlEYVJHd0F6NjI5N2hkQ3dvQ0VGZS93VnU3?=
 =?gb2312?B?dVNXdHdpNU16RkJYUEYxTTZTWGVrdjZxbU5QbndJY0ZwcDU0bFdQNk1zcG5a?=
 =?gb2312?B?ZmpOQ2NZUk9wZzBTL1ZRT3hMZzVLQ2R5UjhXWFZ5bkhrYkplRVA5cmw2RjFv?=
 =?gb2312?B?TFNBT1puMExZL1NhYzdvN1JJZndTRis3eGZhVHVYM041R1Q2ZzhGbW00NE5N?=
 =?gb2312?B?V1JMazZELzVqZmpEeElodGFYSG1DRU1yZTNkeml1Sk5VbUhYdHlMVFJiWFd0?=
 =?gb2312?B?WEhsY0QycDl6N0RGNWNZcmovYzZOV1NXa3Z3RkFWUllHNWpUbjJOWnFJdlEx?=
 =?gb2312?B?RzZhQU1HRjJ0QmMycUtlTWlna2JXOTFXelhFQzgzZkZpZFJuMERHUWk2UzNz?=
 =?gb2312?B?dzFrRU1GUlZIdzZSZ2kwdnNRTVJZOS83YlNKclBDaTh6UEt0TGROMjg1VlRS?=
 =?gb2312?B?QlZDLytWaEZJWG5YT3NJWDlpT3FiTVFCRjNDbndHQitxRkJIUWllVU1XR3Fu?=
 =?gb2312?B?WWNxRlEvMW5XZFl6anhzUVFZdU44N0NGVStIN21kekVnZVUzOXJwU29uelM1?=
 =?gb2312?B?d2ZEQzJhTU1qd29RSnF5Q1Vub2VzSS9jMWZ0OVY3QlBNb3M0SGQ4R2lLSTdo?=
 =?gb2312?B?MS8rRVhlSVRBLzFkOHp4ekZyb0YyZDRUTW5lWUtnYkZNcEZ1b2o0TkdOVTcx?=
 =?gb2312?B?NG9ZdkNUWWRTRTVpdDBaMytRL2hXWUxXSGxhbWszTU5xQ0puNERxTG8wZXRL?=
 =?gb2312?B?S0lWREJMZG5kc0tTVUxSYy9MdlpsTjlNaE9kRVNJVVUwWXVtUmJ3M25scXJi?=
 =?gb2312?B?VlpOSkVReUw3ZkxCZlJSelBheG1ZeGRmUlRTcFozVGpZdnl0RTVzL1ExeVBw?=
 =?gb2312?B?RHBqS055Ni9MclhrMGptSGVkbVVVcHVZbkxtbWZCT0lHdlp6dnJpdGIxKzFm?=
 =?gb2312?B?ZU1PanhLeDhhaFpMcFBHdUVCa1I5eTA4K3AzOUFZT0ZzRUhXYUhtWGdzQmNN?=
 =?gb2312?B?d1lBclFGMzBSS29kOFVPMDQreFA3cjg3TVNjb1lwZVFoWTd3ZDhHbytOTG4x?=
 =?gb2312?B?TUVVdUdGSU5DTDlMRStldjJ4Mk5henZnTGVEMlVIdDNoWFlVOEtRall4b2Ja?=
 =?gb2312?B?bDBvMkI2aUFmdUhBWjN1anF0cmdlYVFvbTZrUnJsekZrMVIxMEhkRHUyV2pR?=
 =?gb2312?B?N1V6RHk0VEg3ZVJ2SHY3SUo1L3ZsejY1NHk2d2JudEM4RXFLVXV5bVlQVFUr?=
 =?gb2312?B?YjdSS09NbzBTRHdIM0tCbjFvak5hcHFrUjlaOHg2WlJ3V1JTbzMwVytpRHNo?=
 =?gb2312?B?bEpYZ2dreFN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cGNvOEhzUVJwcUU3T09uS1dnb2ZjM05VbU9kanNmSDFHY3JxK0xEMHJ3eHpP?=
 =?gb2312?B?Zmd0TlhEZmlZSHhCeWdON1I1RnY1NWpKV1ZLMlFNOU1oRDRQNW4raFVhTmhX?=
 =?gb2312?B?VEhDbzV3Y2liRFpmcDZ2SzJPVFJvb0kvNkVtc0pJQUkyMWhBaC9OZ28zeURN?=
 =?gb2312?B?QUVJSEZyY2E1TVdRbGwrdVowWGtmeUNKOWdFZ2hpWm92T0poTHJvZ010Y2lD?=
 =?gb2312?B?MFZoaHc1RzZnR0NJazM2Y0pDeTJHbHNIZTcxQXIzU2NZUFhGZ0dPSTVMekl1?=
 =?gb2312?B?cnVJbFJ6WlcxQzc1alN4b25IKzgzMWhFWUNLSk5xZHVjRnVZSW8rc2tzWFk0?=
 =?gb2312?B?RWFKVDZ3dVpYMWw2ZE41dWYyNmlWMzgxYndoL2pGQW5NbW1zYlp0dlZuU2pF?=
 =?gb2312?B?U3FuYXlta0Q3ZWZ4UVFUMjhGRFpJaWRwZWc5YnhNd25WQU9QQUgxdTBmMnha?=
 =?gb2312?B?ZmpNME1jRVhUK09kaTVSc01LcFZEU0d4a0QyVG90alZ3ZEgvc2g2TlArY0JV?=
 =?gb2312?B?ZlpuWHZ0bXNmNlNLVlJrdTh5YXM2MDU2MGcrdTNTN05ZK1Z4dngrOVFGVGlj?=
 =?gb2312?B?d3QxM3BhL2d1K3I3dGlYckxaT2huTEl3UkRDTXBGQzI0N3Q1YUdPRjdKb3NY?=
 =?gb2312?B?cjVEU0pvWlFta3g3dmRpaDFMM3lpU2NydEtBbElCbU5leHRMZlplZnBwQStH?=
 =?gb2312?B?WWYzWEM4Vmg4Z05LV0RoR2MvbnBEakZNKzNQaVdLS0ZsdEFxMy9MWU1zTFdN?=
 =?gb2312?B?eCtOTEZXNEhJMFczRkdDRHJwSExWMlFRRytXVDFrTWlrdWd6YmxJNWVRRS9r?=
 =?gb2312?B?M1k3alVxRlBFeGJFelJMc2NCVjZidVBBamtGcUJHaE9mVStlT0l0YWVpMFgz?=
 =?gb2312?B?dGdDU01IY1V4UlVXNU1kV2pNNnc4NXlLRERPNktkSHFiQ1hIR1VaaDVVNG1r?=
 =?gb2312?B?TTNMcWlYbjVOa0x4SloxMHY2MW5wbmY1VSs0SWpYL21OekxrQ253U3ppT1hw?=
 =?gb2312?B?TVlJK0VWclJ3SXY0a0E1SldNVk5rampmSTI0SGlmaWY4OGlJYnZRSHZKd0Rk?=
 =?gb2312?B?YlExMmdWdFRGK2Y3L3pTWis1TytCK0NzaFZRMWNzM3E2VXVsMWhkS1RkYXFY?=
 =?gb2312?B?TFhkTHBSUzRvSFhMRnFXVzVneGZBbWVhTGJraTVQWjZkWERHZS8rRmVNWU1k?=
 =?gb2312?B?RkZ4L0RIc0VadTdTaE5PVzdkcHNFVmZUYVo3eW52MnFmdGRUTUJaZnZpUExi?=
 =?gb2312?B?dFRtU2s4Y2s0SnJWQ2FQTmRwclpUZUg0WHF0ZnlmMDRkWHdyNU5Ha2lsY1kw?=
 =?gb2312?B?UnduR2laTk9WRURoa1lkRHZQM21yWWFQa2U3dWFLYldsT1RESjhNeUFjNi9N?=
 =?gb2312?B?Zi9yNk5samE0ZTRPQUx6aFF5Uy8wSlVpa1JadzRRc1I0SjJ6VTBmaEF1Vzd3?=
 =?gb2312?B?U1ZKTGdpYXZPaXZyT2JtU0lteU9PSGFKaVcwYWtRUHdyZU1oZWxRZTlhV1Ju?=
 =?gb2312?B?YW9EWklPRnFiRzRxbExESnlsQkFMMjliQlVXQ1pLV0ZnUFNQYVZuZlUwM0dF?=
 =?gb2312?B?Q0l3bE81bEZycXZtSW9aNUFvMDk5YWtKb1ZLWkdPaC93SmNRQmhVcVU2NW1q?=
 =?gb2312?B?Zm5ZMm5SMDRYTzBkNXVtckNzTmlsbm9Mbi8xNWF5VDFRVkVIbURnL3cxS3or?=
 =?gb2312?B?T09rYjZ1eExPdEg4NGNSK2ZtUzdNeTRTQlJpcmJIOGVFRGNqVWFVQkdxbmxu?=
 =?gb2312?B?NEE1czdLVHZCNmc5clQwUmxSS0NzNmZmRmZBTXdpaUNUSXA4NHYySFFEa1dt?=
 =?gb2312?B?N0dlSEVQdGJNMTdaaUgyVDhaTDVlRjVscmdXR2Z0anZLWVZyOExrT3lZbXNM?=
 =?gb2312?B?QTNQdGhTcGtxM3I3RjZaU3BDaDRkYzlMcUxQeHRlYmpBVkJ4dE9heWU4U2Zr?=
 =?gb2312?B?WVI1ZVN3d3VhZ2I0QTEvdXRjTDZMOGZJSUhkT0F3Rm9RQk1xbm1vMTBPbFBW?=
 =?gb2312?B?Yi9HQWhKdTNkdndwKzZFT3d5Z1Zpa1NSVktKVUMrQ1VubG0rRnlXUmdpMDFx?=
 =?gb2312?B?YzRBZlhyR0x0RDB6NDEvT05Rd0U5RlRYL1dwQ21hZSs2UDE0RlVPK3dqMHR1?=
 =?gb2312?B?RGZ4elM1NzFkV0FFVVYyZzVBRlV3M3QwUStZQ2E2dXh0eU10QXV1ZDlzS255?=
 =?gb2312?Q?lGivaJRTytdi+rMPwhz86mrsFLNba+4ox65RZbtt9X06?=
Content-Type: multipart/alternative;
 boundary="_000_YT1PR01MB88261798F3919CB8AF4D68DB8EFCAYT1PR01MB8826CANP_"
MIME-Version: 1.0
X-OriginatorOrg: polymtl.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d39e7-054e-4dad-d82c-08de156df163
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 15:31:47.8301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 253209e9-7731-40eb-96e1-6444a6823237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqgioCvir5EfdYkos8e7mOnF7PPrvPh9CAB+mzSB5ze2Ge3nhbfhcVSBN2DqVgx6cIdNPetb6ZurXYk2fz99VCpla8Nakho8SuNouXKwoBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10369
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

--_000_YT1PR01MB88261798F3919CB8AF4D68DB8EFCAYT1PR01MB8826CANP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8gVGhvbWFzLA0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBjb21tZW50LiBXaGF0
IEkgbWVhbnQgYnkgYmFyZSBtZXRhbCB3YXMgYWN0dWFsbHkgb24gdG9wIG9mIHRoZSBPUywgc28g
eW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0IHRoYXQgdGhlIHBocmFzaW5nIHdhcyBjb25mdXNpbmcu
IEmhr3ZlIHJld29yZGVkIHRoZSBxdWVzdGlvbiBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9u
Lg0KUmVnYXJkaW5nIHRoZSByZXN1bHRzLCBJoa9tIGN1cnJlbnRseSBwcmVwYXJpbmcgYW4gYWNh
ZGVtaWMgcGFwZXIgdG8gc3VibWl0IGVpdGhlciB0byB0aGUgSW50ZXJuYXRpb25hbCBDb25mZXJl
bmNlIG9uIFBlcmZvcm1hbmNlIEVuZ2luZWVyaW5nIChJQ1BFKSBvciB0aGUgTmV0d29yayBPcGVy
YXRpb25zIGFuZCBNYW5hZ2VtZW50IFN5bXBvc2l1bSAoTk9NUykuIEkgYWxzbyBwbGFuIHRvIHNo
YXJlIHRoZSByZXN1bHRzIGF0IHRoZSBuZXh0IERQREsgU3VtbWl0Lg0KSWYgeW91IHRoaW5rIGl0
IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIHNoYXJlIHRoZSBmaW5kaW5ncyBoZXJlIGluIHRoZSBn
cm91cCwgSaGvZCBiZSBoYXBweSB0byBkbyBzb6Gqb3IgSSBjYW4gc2VuZCB5b3UgYSBjb3B5IG9m
IHRoZSBwYXBlciBvbmNlIGl0oa9zIGNvbXBsZXRlZC4NCkNoZWVycywNCkFkZWwNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFRob21hcyBNb25qYWxvbiA8dGhvbWFz
QG1vbmphbG9uLm5ldD4NClNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNCwgMjAyNSAxMDowNiBBTQ0K
VG86IEFkZWwgQmVsa2hpcmkgPGFkZWwtMi5iZWxraGlyaUBwb2x5bXRsLmNhPg0KQ2M6IHVzZXJz
QGRwZGsub3JnIDx1c2Vyc0BkcGRrLm9yZz47IGRldkBkcGRrLm9yZyA8ZGV2QGRwZGsub3JnPg0K
U3ViamVjdDogUmU6IERQREsgb2JzZXJ2YWJpbGl0eSBzdXJ2ZXkgKKHWNyBtaW4pDQoNCkhlbGxv
IEFkZWwsDQoNCjIxLzEwLzIwMjUgMTY6MTgsIEFkZWwgQmVsa2hpcmk6DQo+IFF1aWNrIHJlbWlu
ZGVyIGFib3V0IG91ciCh1jctbWludXRlIHN1cnZleQ0KPiBvbiBob3cgeW91IGRlYnVnIGFuZCBv
YnNlcnZlIERQREstYmFzZWQgYXBwbGljYXRpb25zIGluIHJlYWwgZW52aXJvbm1lbnRzLg0KPg0K
PiBTdXJ2ZXk6IGh0dHBzOi8vZm9ybXMub2ZmaWNlLmNvbS9yLzZ6UkFxeFdZS2oNCg0KSW4gdGhl
IHF1ZXN0aW9uICJSdW50aW1lIGVudmlyb25tZW50IiwNCkkgc3VwcG9zZSAiQmFyZSBNZXRhbCIg
bWVhbnMganVzdCBvbiB0b3Agb2YgdGhlIE9TPw0KRFBESyB1c2VkIHRvIGJlIGEgcmVhbCBiYXJl
IG1ldGFsIGVudmlyb25tZW50LA0Kc28gSSBzdWdnZXN0IHJld29yZGluZyB0aGlzIHF1ZXN0aW9u
Lg0KDQoNCj4gVGhpcyB3aWxsIGhlbHAgZ3VpZGUgb3Blbi1zb3VyY2Ugb2JzZXJ2YWJpbGl0eSB3
b3JrIChUcmFjZSBDb21wYXNzIGFuYWx5c2VzKQ0KPiBieSBQb2x5dGVjaG5pcXVlIE1vbnRyqKZh
bCwgRXJpY3Nzb24gQ2FuYWRhLCBhbmQgQ2llbmEuDQoNCldpbGwgeW91IHNoYXJlIHRoZSByZXN1
bHRzIGhlcmU/DQoNClRoYW5rIHlvdQ0KDQoNCg==

--_000_YT1PR01MB88261798F3919CB8AF4D68DB8EFCAYT1PR01MB8826CANP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hello Thomas,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you very much for your comment. What I meant by <i>bare metal</i>&nbs=
p;was actually
<i>on top of the OS</i>, so you are absolutely right that the phrasing was =
confusing. I=A1=AFve reworded the question according to your suggestion.</d=
iv>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regarding the results, I=A1=AFm currently preparing an academic paper to su=
bmit either to the
<i>International Conference on Performance Engineering (ICPE)</i>&nbsp;or t=
he <i>Network Operations and Management Symposium (NOMS)</i>. I also plan t=
o share the results at the next DPDK Summit.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
If you think it would be interesting to share the findings here in the grou=
p, I=A1=AFd be happy to do so=A1=AAor I can send you a copy of the paper on=
ce it=A1=AFs completed.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Cheers,<br>
Adel</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Monjalon &lt;t=
homas@monjalon.net&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 10:06 AM<br>
<b>To:</b> Adel Belkhiri &lt;adel-2.belkhiri@polymtl.ca&gt;<br>
<b>Cc:</b> users@dpdk.org &lt;users@dpdk.org&gt;; dev@dpdk.org &lt;dev@dpdk=
.org&gt;<br>
<b>Subject:</b> Re: DPDK observability survey (=A1=D67 min)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Adel,<br>
&nbsp;<br>
21/10/2025 16:18, Adel Belkhiri:<br>
&gt; Quick reminder about our =A1=D67-minute survey<br>
&gt; on how you debug and observe DPDK-based applications in real environme=
nts.<br>
&gt; <br>
&gt; Survey: <a href=3D"https://forms.office.com/r/6zRAqxWYKj">https://form=
s.office.com/r/6zRAqxWYKj</a><br>
<br>
In the question &quot;Runtime environment&quot;,<br>
I suppose &quot;Bare Metal&quot; means just on top of the OS?<br>
DPDK used to be a real bare metal environment,<br>
so I suggest rewording this question.<br>
<br>
<br>
&gt; This will help guide open-source observability work (Trace Compass ana=
lyses)<br>
&gt; by Polytechnique Montr=A8=A6al, Ericsson Canada, and Ciena.<br>
<br>
Will you share the results here?<br>
<br>
Thank you<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_YT1PR01MB88261798F3919CB8AF4D68DB8EFCAYT1PR01MB8826CANP_--
