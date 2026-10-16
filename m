Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A8CCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EBB540298;
	Fri, 16 Oct 2026 20:22:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
 by mails.dpdk.org (Postfix) with ESMTP id 2122740291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:22:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCpf8dRUtTa3IvsilrDHyjtoF4E+zvwAKwZHZ8MOrKuC91jUxh+idYB/WJGM6xXWXNnV8kQzhnDSgikzZX5WJRqFzlERZOhoeYK6MDG/5yQChGRU95fj03rlcOi+OoVz5MI7FulWXNgTXKBoF33hCLbg+eUjCBnMrAbqj9JlinV7h/bu4Z8nhV8WwacWAhUoEVQvVf+jcvMHIJAiUFZZiY4hJdIOZ7Rsn7MfgUeyvk1R2nPti5sRugK1EvpJ9MfjpBdke8X9q8F/BmfcL8lhuCSHj2Yn32EZQLEXgRLo10PORZVAd/QnmDffGFrO6WR2c+8N8d+YvKPapmwkLeKDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+UqVHrdm5fhIxVxl+cVqqN258yMbJckbaLJ9xrZ/es=;
 b=TjH2/tVEDi6melyeM5x9CH8+ioS5tMk5fMPqHkNdedLSjccv61XERPiq1QztOSeGLwsABzgkdTrsdLZjP7UF1/H/QnYyq1atE1FsLRZzhHFKyjjEDMF8gBUwavWnSPwsM2ZP6or0sPHEhGTIbjuUzN7xYdDdORw8kT8Qe1nJe3LwYEPsuF9EMIyM9QMslh0RTgKsTRhvsBw28Mq5gqniy6yEvXlOtGSRMHBlcp0RzaM/40xWKOHK2mRvtswrAwoy0ai7sI8XmylljwxAt2WbrksU7gsAO03REW1gREShxIkMcHEuOs/jwjLUl84mA/ujEi+FfCRgsITzib2hcsYmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+UqVHrdm5fhIxVxl+cVqqN258yMbJckbaLJ9xrZ/es=;
 b=hZVq2+zwtK+SpJLlP5dY6qELPuTHkkBXYbCtn0wu3TTdEwaJHryYzdGUEW3P1OiuP7qj9R1+LiytZaVM/X6kxvPVWa9Qk6h3cVACXWQgLY/eipA3/EDN+nD79p/4uZE8OC6TkWHbKDgCUgJDZiE6TsPzlRVLNFkl7UAwSuzYynzSCHmTLUtueKnRV3XHwbe6DZqjPns5IZvxZa2Sm0Tr3bLlweiiDdbEjO95wbNGfIbHThS/B6XRNTYDzPOSDST58lXSUP7FNDtpLOetuwLqsDPifhZq95BnsuC+vVft8Hu+NA4FV6AfMeYSHdvEQ01A5OZuhoKqTfqRJHTHOQObKw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM0PR04MB6994.eurprd04.prod.outlook.com
 (2603:10a6:208:188::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 18:22:50 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 18:22:50 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH] net/dpaa: make mac_idx static
Thread-Topic: [PATCH] net/dpaa: make mac_idx static
Thread-Index: AQHdXZkVE72P7lVo1UOpTcQu+U+cErcAe1pQ
Date: Fri, 16 Oct 2026 18:22:49 +0000
Message-ID: <GV1PR04MB10750BACCE2653B62BABEF2CC899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261016180624.3507846-1-stephen@networkplumber.org>
In-Reply-To: <20261016180624.3507846-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-16T18:22:17.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AM0PR04MB6994:EE_
x-ms-office365-filtering-correlation-id: ffa46a61-18aa-4275-e17a-08df2bb27c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hy3RPn0a8FzD8zuLzzkCKUhgIYMzPKbeJeoswwiP8Rkd7UNaUJxLoYObQ6WfTFGNJ1MuasrWgYCilI5whEltojUdAlnlQQit2zyH9H3ky9MTrQnLQbIayiWSxKXPwkk+atr/olPOIEe8ABbrFECU3x004ep6oH2t8vAqITEGzc349Ov3+cAJF4qcQPz85uA3rUvXcsTgpJZdgRRYLpK0uBzEa2EhIR1wQKv3Z4DAU+2rMy9Nf2qaJ5V7EN35qCTkxrZWQanGANkCodGGEB81VDLTDYDfmsqCP9g69ZlI6P27VjwyZhirjKooa7APKtHwsaHUUGQFwX0dl6ZLWklaCLuY3kg5mo7SzIvtGgh4J3DJR8K0pQKVppN+ntKnVx7AxAukdUZB9DoCj0+9wLvmjgW/sQb9ladWWCxziMWhyMRmBPrt1MADeN8sAOhj+z2b48ta+m6FKc6IZpRVTV4hnTVRnTv0AD23wv6sktmOvzXVKOI9gRrRODuhafTAsaWg4qhMHaSzOrK1qjKfyrWl9jbrb1LgspEqjJN9jFJrplxbMDPECxKFIPPNmfcSI1xfE/4uQ787+tpiHgj8QBv1fiZ3v5lSwfRi88T6HsRyz2TKptUojPnM0pq4/qyHe9cb/0npDIoJkQ8sPLtI4X9sNScQF7sGQhreKfeD1OYxhwwFUlgE6sa5qrq1PzwWleiMI3wrO/6HbmMwM3T/0t/WVRRjk6C+0/vKNkBh7oynuz4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alloNGZIOTNOTm15aDFySnZKR3kzQWxFbnkzVGN2NmxSM0d5bDdrNmttVCsx?=
 =?utf-8?B?K2kwSngwQkdSV0FUMVB1TElmNGJsdUZyTTJCYjhSamdnUHFYeE9vRlBYUHE3?=
 =?utf-8?B?NlovcEEzam9TNGNSenM1c21aUk8xdEJlVzNBSERtSGVXUUpQV1F1N0VLNHZP?=
 =?utf-8?B?bVI5eHBGa3NpVy9kYjZNV25LMm5PMmtDQkhqMlFEQTZNT2tpWWZJWlVFbnJ3?=
 =?utf-8?B?YUJRQUt3aDhsZFh3STEyeVVhVTIrVzhjT3pNVnJkbVdybmNPOWI1a2xCeDBU?=
 =?utf-8?B?Szl3UHhkWWZOVlUxaVFKSjkxVXFWOVZHVEszV05wMHJMZUZVeFJPZVdtU1o4?=
 =?utf-8?B?bWhMR3dNUHdLazBVVmMrc0YzNEYweXd1MEdvazNoeC82K3lQcGg3T2M2L0kw?=
 =?utf-8?B?bXVxNVczMHN4ck84K3VxNUREYmJDdTVJMFZpaFhoZzNKM0VWTG5GTFQ3LzJz?=
 =?utf-8?B?ZkhFR1JFY3FwR0pBeUlUK1ppclZ5ZEJxcjlROWhRQmI3RW5va2Z4QzRFRXlJ?=
 =?utf-8?B?SDJSZXF2QStsWU1pemFGUlk4Y2w1dTg4dGZ6ZDhZVkF0bjBrSVMzYlFlMXNm?=
 =?utf-8?B?N1FMQmJBVGVsNFh4T0ZGakVJZmxNL0hOWTRZWXE0RGM5ME5QaUhNUEE0YnlW?=
 =?utf-8?B?ZU9KRWdXbzAvWE9zR3R0WUMvanBUcUtIYUdyZXJjQStxeDVPQkJ5bVZIalE4?=
 =?utf-8?B?V2l1ZU4yWWZWWFowdkR0SDZobUFwUkhDdEl6bGxMM3lyUDdFaVNTdmhIbHda?=
 =?utf-8?B?djUwVlRQN2ppb0lncEJ4WkdNMzg4dFRyWTBXTTZBVkYvd2paMWZjc0o4WGVv?=
 =?utf-8?B?T1FGY3VLS2Y4Q0lQUXFUc1RvNTlpQ0VQdEJwYlVKOHdOYnVZdC9zN1Y0RmNQ?=
 =?utf-8?B?aFlieUprOHFNeGp0OEJBZzhTTUI1UUxjVThKV096MVlhVVdxRFpVWEhRRnIw?=
 =?utf-8?B?UkxZVUxrQVViT1oyQStPUlh0ZmQrYmR4MHptNU5sK245V1dYcXM0YmkxQXNl?=
 =?utf-8?B?SU1BVGUwOEw4RG1GdnRTeVBTOWpjMG9zbWk4VjduQytXQ2V2ekxKSDJ2T2xu?=
 =?utf-8?B?UUFTYXM4eDVpVkVZc3FKdlRITDJ5aVFNYlZNOFo2alJqS050Mm9qSjEyMUlo?=
 =?utf-8?B?bDhTUDdRTUlkN1VxMFpIUDhlVGFvUExWK0tZNGwxRXNNYWQ1WmxvN2R0ZTBB?=
 =?utf-8?B?Qm90NVV5QW9pdXd6VldYZ1RlTFBlMVBoWXpTUGU3a21tUndqem1FdVFibFlO?=
 =?utf-8?B?VmJpUnp2YVJVS2pxVjhGakZvalRtTGFZWWc4T0sycStZcXhYTk5NTmp3WnMr?=
 =?utf-8?B?YXNHMDBwV3R4NDJGY3BjV1MybXVOQ0JkMFlqb1FRR1psNGVtRXROUlZSWUxw?=
 =?utf-8?B?cS9SVlBlODcxZzVkUjJqMGlnRVNCVy9qMkVKN05UekpNeWVRWVdSYStYTHQw?=
 =?utf-8?B?Zlc1OE5sMXp4WnVoS050by9FeGhwWUQvZU8rbEpISXg4S2tIM0dPUnIwTksr?=
 =?utf-8?B?TmdFTnQyaWhsbkg4VWRvdDVtcUhGeWZac2NtMUhUczFlcVY2bzJOT1hwb2FG?=
 =?utf-8?B?SjhLdlRpbDlHcHQ3NEkxRy9kZURyeENlOG9KdytkQ0NkZkhDNFpVZElkNkg1?=
 =?utf-8?B?MUI4VUtKZEwyQmZRYWJxU25pVmtpTmg4ZWlRUTMvaEgvV1Y5TDltTytnSnpi?=
 =?utf-8?B?WmxwRzI5UlJpYlV1WnFNbCtjaGxLZUtyYlJycXhCSGRacmxiNjVJdDJ5cTlP?=
 =?utf-8?B?Z3ZRaGpGTno3UmFMZGN2T3BaZGxmUWpWV0FyRW8ra0NPWnBTY1BrZW02M2E5?=
 =?utf-8?B?Ync2ZkQxZ2tqT2RIN3dPVDFZUFBveFJtZTQyQjd3V1hRNm1Ba1lOK3g0UHll?=
 =?utf-8?B?SkE5K0x1UmRBOGhZbTVuY1NTd3Y3VTAyNFdTbmYyWVB6QVloOHM5cFVldFV5?=
 =?utf-8?B?SGx2UVArM3B3c0YyaXgxZlcwRFF6M2JLdWpMQkg1a2ptL0JxTWhPTTcvSzly?=
 =?utf-8?B?a0tJeEZSc0FMaVRJM2ZDckR6aFNUUmlRRjdLL25ia3hSMWNVN2h6ejZqYVU2?=
 =?utf-8?B?Zk1oSlR5V0EySVRRemxLcGtqQUswbkFTUk1uK3hsOXU2VnJ0b2ljYXp4OGw0?=
 =?utf-8?B?K0ZvSjBsT0h5Njh6b2Jua1FiVzVRcnlyTmZKclNETVFjZ2hPK2RiQzJUSGlX?=
 =?utf-8?B?dlo3V0FubHNqNk5ueE04Z0NrZ1pqWjVqcitTUi95ZDJkYzZ5RVNGam9SNkI0?=
 =?utf-8?B?UzYvWGw4emhlMjkyZ1VOYjNJd1pEOHA0UGppVkRmUFdpdVdGanpkZlpzMnp3?=
 =?utf-8?B?dnZlZkJHeGhEZXl1czZ4RktpcFMyVHJtZjZDRTNJWGdFd1V5SDhNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa46a61-18aa-4275-e17a-08df2bb27c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 18:22:49.9443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/yCKAWtNw/v5UWK7EmgcybXI63eb//ZV3H1bF3WUCWnRZpyI1o1oyIo5NAfZ0yIho2qDM7mDdeQ3KhLQzLbcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994
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

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNl
bnQ6IDE2IE9jdG9iZXIgMjAyNiAyMzozNg0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBTdGVw
aGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBIZW1hbnQgQWdyYXdh
bA0KPiA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhl
bmFAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBuZXQvZHBhYTogbWFrZSBtYWNfaWR4IHN0
YXRpYw0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+DQo+IFRoaXMgYXJyYXkgaXMgb25seSB1c2VkIGlu
IHRoaXMgZmlsZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBo
ZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KQWNrZWQtYnk6IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQu
YWdyYXdhbEBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RwYWEvZHBhYV9mbG93LmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RwYWEvZHBhYV9mbG93LmMgYi9kcml2ZXJz
L25ldC9kcGFhL2RwYWFfZmxvdy5jDQo+IGluZGV4IDA1YzFjMWMwNjUuLmY3N2Y5ZjMzM2IgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RwYWEvZHBhYV9mbG93LmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvZHBhYS9kcGFhX2Zsb3cuYw0KPiBAQCAtMzQsNyArMzQsNyBAQCByZXR1cm4gJnNjaGVt
ZV9wYXJhbXMtDQo+ID5wYXJhbS5rZXlfZXh0X2FuZF9oYXNoLmV4dHJhY3RfYXJyYXlbaGRyX2lk
eF07DQo+ICAvKiBGTUFOIG1hYyBpbmRleGVzIG1hcHBpbmdzICgwIGlzIHVudXNlZCwgZmlyc3Qg
OCBhcmUgZm9yIDFHLCBuZXh0IGZvciAxMEcNCj4gICAqIHBvcnRzKS4NCj4gICAqLw0KPiAtY29u
c3QgdWludDhfdCBtYWNfaWR4W10gPSB7LTEsIDAsIDEsIDIsIDMsIDQsIDUsIDYsIDcsIDAsIDF9
Ow0KPiArc3RhdGljIGNvbnN0IHVpbnQ4X3QgbWFjX2lkeFtdID0gey0xLCAwLCAxLCAyLCAzLCA0
LCA1LCA2LCA3LCAwLCAxfTsNCj4NCj4gIC8qIEZNIGdsb2JhbCBpbmZvICovDQo+ICBzdHJ1Y3Qg
ZHBhYV9mbV9pbmZvIHsNCj4gLS0NCj4gMi41My4wDQoNCg==
