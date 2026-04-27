Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361EFF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 050F4402BC;
	Mon, 27 Apr 2026 12:33:51 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023115.outbound.protection.outlook.com
 [40.107.44.115])
 by mails.dpdk.org (Postfix) with ESMTP id AA671402B2;
 Mon, 27 Apr 2026 12:33:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojBPCVjsRJgvdk8l71omiuwiYbL3XoXmsds64eb3VguAWykiSXk8PZMxLp8WH95drUFN8zS4YHITXbBteRR5nogZraJ4uI3ENEHvmHEDPsblUggxOZhGShmy21xRb1P96vJ6akp8ZWEsjt0PUAJ8Ybpj7e2GB85ynyML2dGkJc9tQcFqg0nLiFt/1HGsSe8pPwVwchKlACBLegxzw97HvGKk188ZFfOaxARRaVkT0QXudTGOxxtODYie6wNRoBlraTPkpPkOy4SygWgwVLGc+bfvSVpEJYFhrWRMtIa4PRMtbEDJ9iHwH7IRlE568sWFzRU75JwwMqeHEXrbdNPHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hUrJMGOQNPIboNnBFiGjEiWhh3NUo6DS7L/RZ56Nvk=;
 b=oMb6eOMU//58+JRF1tUptmm3duEINIre5DnuQw52JtTZCh6yDaZVlPdNEfHcHUGX2O6pBEcj4AK1zf8AA/mBTo+WeyrNLUMh+QwJAl+j5DLmOB7zB5dj6UFqjJg82hOp7lRioY8ZX/NbnvUMUg5NvBYATK+V6/1PbMDfiBfuzFDeN2hRK+anoFBG/HP8fbhl0jKE1mE1zst1JZqmvNpllzdu4lh/3lNy6MRX+INObzNV5W4jx8zg0OckdML1c933rNdadq3W+k99Srk8fzldkZrHN2Z+luP0F640YXGySrUwPWQq9QSwf4hc9S6GxnLKM/+fNfocwgCZN3pYRU/u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hUrJMGOQNPIboNnBFiGjEiWhh3NUo6DS7L/RZ56Nvk=;
 b=eFPOl3Mo4EYxSkNOpnZHZieDPEgaZRMcS/A7dW6R9D3luCzakiC6GWArOf6G12K8Vh++HstNPH+n+vFgl0XoD3vummAqdUSvSdHJE/0dDam9RItqUDanqgj+kmVcVvjYrVO8u+N5OzQXFcu0jVjErk25Q9CfIBm6Z6OuIEMsCOSXOis6cY3NRlL+hKcO5JtVoM9M/vorGIKFTO1tPUv6E2eJNH2K03T4mZBwfiP3RkmQAWo58y0YWu+5LBOx7QrmG0u8htJ/VdvI2zHOEw34DLVzlXO3VuCJ9azdc0wQR4XBrAs36L1zhPRElEx7y8JjS+R5Y859QkaCzhYdX8kJQQ==
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KU2PPF557D403C2.apcprd06.prod.outlook.com
 (2603:1096:d18::495) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 10:33:42 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 10:33:42 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "aman.deep.singh@intel.com"
 <aman.deep.singh@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBhcHAvdGVzdHBtZDogYXZvaWQgY21kbGluZSB1c2Ut?=
 =?gb2312?Q?after-free_on_SIGINT?=
Thread-Topic: [PATCH] app/testpmd: avoid cmdline use-after-free on SIGINT
Thread-Index: AQHc1iXX3B0qL8LK2UWvC+xpV7zvXbXyrZwAgAAEARA=
Date: Mon, 27 Apr 2026 10:33:42 +0000
Message-ID: <KL1PR0601MB5567C08F8735C6DF18AF973F90362@KL1PR0601MB5567.apcprd06.prod.outlook.com>
References: <20260427091055.22412-1-sunyang.wu@jaguarmicro.com>
 <ae80NGXJc7qgqoDA@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ae80NGXJc7qgqoDA@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5567:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: 214bb0c8-d285-4379-ceff-08dea4487425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: knxDb/wtEsGD0/V9cTJyWpDjm8l8m+NkesrXCedCajitfsiaVJv5UMPmfPk1ptCB690qvbL5gFa8uPxtd+AXWgY0cD+mK/ZbHH4WTsvk7fMIbcEmuaBrWgVcAWbDOQ4cCv2CnIFNq8/teEE1y1A/JOqj2QWhveZCTWY3x0Dup22JbWzp+cJxvPPeunbe/UpmIq0RZ6LAgEgg3/NILk8NH6AOGAf38Tu8sJmV7+qHyJro6DmzMjIMztRek6Ssy+UAWjhW5GDRpsw7GyAHlgPSyJKln/DuasWxjVggEcnuKYnhF18XjG9RIJYF1kDhCiEcFwEJDIpNEtO3FG1YqZF8p1mnkfQ1LqsN1WOv0lFXcKuUaPBYXLXyLrFxRB8vb4zFXz2OcrhUEDrjIxcq0kmhiZsCyIvH2HqAnEc6N3r6K5xNvi1tnTsdBgsnn9LCVkMeJ6nG2sgnlayIv4OzqhOvbawiFprJ+tvj6yez3BpnxKbskk/KCJY77qrCnmIy/vHFBei1EQa6ksp1w6Caik5m3WNM68dKhWobMg5T7jO2sx1YQpM/InM5Bl86OZrNjiwLCIg6itvdNF3aIhzP4jhBaR+26fLEcLwF6cGmQDuP+vlNp5Cnr741dLdMf4W664BK9FiMEpk4ZGzKiukRSfkD7bBXX2k/dGiadKQJtRdK2RsvLZh2Z8i3hniH+ggDzF2KFlWi1gac2AUlpnIFcSIqJgMODlNiNp6d5ZJXPVpj5Zi/qRuP7NLnRuGASxBQb4xAjUCSyRo8Ul8rJ7jn7wHxwCIwMJqiaHJtauh8C1CQ0oM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3dTUUp5TmpYNXRCbHlBeFF0TzZrdFVxUzFsTmdtc21jenVBTzVIN0UrT203?=
 =?gb2312?B?UERPcGhuZzhzTFdBT0tqd2NEZDd1RmJEMEZDV2NrNGl0cGo0c3B6Tkl2Q3Er?=
 =?gb2312?B?bXpoRDhNbFVGNVEwSDRkTG1NbHduNU1DTWNnTVZJUlRWczRMVEtvUWVCRmVP?=
 =?gb2312?B?QW9ubUd1Zkc2eTlIWXRhRWFrWXdSTWx6bGxOcFBhT3pMTGNzQmFON3gremRk?=
 =?gb2312?B?N0lLZkxsZFFSS1NMc1JjcHZNQkNFSUFaUTNkUEwyaG9JQkpza2RPeUx5WlFo?=
 =?gb2312?B?K2kzbWpLS0ZvMlZpNjd3SGlHb0tzRnhQWk1LSDEyYzZUK29MVGh2Nkxzamdt?=
 =?gb2312?B?b3RJYi9NOTVmWlV6Ujl2SDNnL2g4VkVoWWdSektGZDgyb3RETTV5eU02eDB4?=
 =?gb2312?B?eUZ5d3U4L3BsN1N2bVU1cTllbFA2OFVjaUFBOGlTbzNiQVBsVzlqNFlzMFFk?=
 =?gb2312?B?WjVtVnRtZk1heHJnTnZqMDJXOEJHZ0FLY2FDRks1Sm9xczlOY0ppa2ZjY2pp?=
 =?gb2312?B?ejFZQmUxMklkVkhlUkpJdzZLSWw3YVhQVDhZaHhWREJWM2FPRzg5dUFnSThv?=
 =?gb2312?B?SUxpM0ZBRys5blVWZXVUSkdETzkyU1JMSEtNTjVydy81YWcyZ1ZMbFM1WEFj?=
 =?gb2312?B?dEo5bERFVVRpUUNFOUthMlRhSUI0eUhyUDdkTTB6Skg4R0hIUVI2ZzhRaXhE?=
 =?gb2312?B?ZEZKNmdvc0lqRTVRd2pwOVBPMHE2ZXJacVp4UjR4RDBVc0w5ZUxFeHhBYVNj?=
 =?gb2312?B?K3FQQy9WV0h3eS9BREVIaUdQVS9ZajV2aVhBY1B0Umw3eVNOWjQzV1NLZnM4?=
 =?gb2312?B?M3h0MUFoUnZQMkFPbW5aZXd5N0V6eVpCOUFlY0JhUXduTmdhTnhpdXZLVmZ0?=
 =?gb2312?B?S1o1VGgwakQrU3dtcmRvQTYrYVdwM0E2U1BGSmNqNzlsMVhieFo0RDR1c200?=
 =?gb2312?B?cEZsUzhsUlZ1WWg2UTFJc2M1L0p0VDBXdHFKTHBqeVUvZGw5QUlKMXF3K21G?=
 =?gb2312?B?MVBRbHVmYWdjLzF5NCtxcjQ4am8zVGxvTnNqVklSWUhTUkhSQVlYL0hwMFJL?=
 =?gb2312?B?ZGZKa25aeW5aMCtaWlN6OFQ1ZU1mQlJRM0ZtamVqelFWeFFmRGw0L29ka2xL?=
 =?gb2312?B?V1ozZ3dNd2dEeTc1QnczbUlBWmVFMzVUcWlPZENsc2R5MmxsdnM2TXVRWDhW?=
 =?gb2312?B?M1BqN0c2N1pMQVZrQVZCSmtwUEFCWFB0M1VUbGI3OUwrcytOMjcyNnpzeHRU?=
 =?gb2312?B?eFRNd2FVVkxqWVNXNGN6emxSMXNDSkQrdTlWWnRVak5yNWNiZTZGd2tFd0Zx?=
 =?gb2312?B?RWYwMzlKYVI2ellpY2xUUVBacmVCWEJtR2lDbDd4NDV6REFzc2FMS2VkNEsz?=
 =?gb2312?B?Z1hmT3g2ZWFuZ2krQmRlZkFCK21qbjZUYnRLNXpmdmQ5ODhHT0FwWGxqSHps?=
 =?gb2312?B?M0Q2UkxsR3RVYzE4RHl1Q0xRd3hBNG5PaElzZU8wUDdIdkl2djBHSDh1MlBH?=
 =?gb2312?B?ejhSZU1HTVlNdlBMRGJxQklzQWh4VHFJUzFNd0hEbURSbU1nb1NtSmhOUnpj?=
 =?gb2312?B?d3hPZC9WUWVsUjZOaXErVjlvMnZ4dnp3VkUzTS8rYzhINU1lWE9XaXRVS2hS?=
 =?gb2312?B?MTVnTW9STXdEd2IwSlBreGplK2VvKzNITTlBa3h4NWJ0U1BSN2ZBQXNJeTg0?=
 =?gb2312?B?QkFOdlMzMWxoVlBISUppNmErUkJuZVhhekx0dHJ6dU5hT2JHdmZsWEtOWVRP?=
 =?gb2312?B?alV1QkNyQmpxaTdpQmhSTkw5THJvZ213K1NKaEw1STlSSmNXckZJS2JrMnI4?=
 =?gb2312?B?djYvT2MvWE83SlR1ZHcyQjZCZFJFVW5OamNKZG01ZDRueTQxcXJucVVnajM1?=
 =?gb2312?B?VEh5RHVlNFdCYVF5TEpqSUFoc1FBVTBjQnVKZmE4bGx5NkhxMllQRk1FeitS?=
 =?gb2312?B?NDlEWC92NHVEaHMvYmEzQ0VTQnByL3E3UGpqSkZ1RmxCZnhpQ0kwK3dRUnRy?=
 =?gb2312?B?N3ZRTVU2TXZXZ3FNcnEyMHprd2FHNU42TGY2NjlidUt2Q3FlTVV2L1E0RkE4?=
 =?gb2312?B?ck9ubjRrd1pDblB6YS9kOUkzaCs0c1lGaUtNbGYyejhDU01HVjBEM3NuYnp5?=
 =?gb2312?B?MzNGRXJ6ZTRJMXRNYjNsbHJsQTY3SmZwZXplWnEzS1ZMWHBEVTI4aW8xNnlr?=
 =?gb2312?B?dXg3YlRGSmJLdE1KcWJCTEY0a21PaHNjNUptb3N5eXFvbHRYL3BSR0hkR2RB?=
 =?gb2312?B?ZFY5UEdwVG5vWCtaSUZVdmFaZ3VwYmNacG1lUVBFQkxlR3djOWhxZWRCb1ZR?=
 =?gb2312?B?djc2TXowejYzbmtqKzJXM1lQZFRaMDlvZklpRDhKWldld3NRMFo4UXV4ejJr?=
 =?gb2312?Q?vKR+/PA0+Nr/RRbO3kGa78s5WYZb/Hps80Y+o7iUaevju?=
x-ms-exchange-antispam-messagedata-1: q02zKWYzSoL7Jw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214bb0c8-d285-4379-ceff-08dea4487425
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 10:33:42.5950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yewk6wwaQ17lbI6KTT/GBWfhb30smCtGPw//ZZrO2/HvhTpEkxpuRdklCnn/ceW7X0QY+K1uwXg0OR8I8VEvh/rFeDj0v4ZXwnYyiTGHxG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

SGkgQnJ1Y2UsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KSSBkbyBub3QgdGhpbmsgYSBt
ZW1vcnkgYmFycmllciBhbG9uZSB3b3VsZCBiZSBzdWZmaWNpZW50IGhlcmUuDQoNCkluIHRoZSBp
bnRlbmRlZCBjYXNlLCBwcm9tcHRfZXhpdCgpIGlzIHVzZWQgZnJvbSB0aGUgc2lnbmFsIHBhdGgg
dG8NCmludGVycnVwdCB0aGUgdGhyZWFkIGN1cnJlbnRseSBydW5uaW5nIHByb21wdCgpLiBJbiB0
aGF0IGNhc2UsIHRoZQ0KTlVMTCBzdG9yZSBpcyBhbHJlYWR5IG9yZGVyZWQgYmVmb3JlIGNtZGxp
bmVfc3RkaW5fZXhpdCgpLiBIb3dldmVyLA0KZm9yIGEgbGF0ZXIgc2lnbmFsIG9yIGEgc2lnbmFs
IGRlbGl2ZXJlZCB0byBhbm90aGVyIHRocmVhZCwgYSBwbGFpbg0KYmFycmllciB3b3VsZCBzdGls
bCBub3QgbWFrZSBjb25jdXJyZW50IGFjY2VzcyB0byB0ZXN0cG1kX2NsIHNhZmUuDQoNCkkgdGhp
bmsgdGhlIGJldHRlciBmaXggaXMgdG8ga2VlcCB0aGUgZXhpc3RpbmcgcHJvbXB0X2V4aXQoKSBi
ZWhhdmlvciwNCmJ1dCB1c2UgYSBsb2NhbCBjbWRsaW5lIHBvaW50ZXIgZm9yIGxpZmV0aW1lIG1h
bmFnZW1lbnQgYW5kIGF0b21pYw0KbG9hZC9zdG9yZSBmb3IgdGVzdHBtZF9jbCBzbyB0aGUgc2ln
bmFsIHBhdGggY2Fubm90IG9ic2VydmUgZnJlZWQNCnN0YXRlLg0KDQpJZiB0aGlzIGFwcHJvYWNo
IGxvb2tzIHJlYXNvbmFibGUgdG8geW91LCBJIHdpbGwgc2VuZCBhIHYyLg0KDQpUaGFua3MsDQpT
dW55YW5nDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBCcnVjZSBSaWNoYXJkc29uIDxi
cnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4gDQq3osvNyrG85DogMjAyNsTqNNTCMjfI1SAxODow
Mg0KytW8/sjLOiBTdW55YW5nIFd1IDxzdW55YW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4NCrOty806
IGRldkBkcGRrLm9yZzsgYW1hbi5kZWVwLnNpbmdoQGludGVsLmNvbTsgc3RhYmxlQGRwZGsub3Jn
DQrW98ziOiBSZTogW1BBVENIXSBhcHAvdGVzdHBtZDogYXZvaWQgY21kbGluZSB1c2UtYWZ0ZXIt
ZnJlZSBvbiBTSUdJTlQNCg0KT24gTW9uLCBBcHIgMjcsIDIwMjYgYXQgMDU6MTA6NTVQTSArMDgw
MCwgU3VueWFuZyBXdSB3cm90ZToNCj4gV2hlbiB0ZXN0cG1kIHJ1bnMgaW4gaW50ZXJhY3RpdmUg
bW9kZSwgU0lHSU5UIGlzIGhhbmRsZWQgYnkgc2V0dGluZyANCj4gdGhlIHF1aXQgZmxhZyBhbmQg
Y2FsbGluZyBwcm9tcHRfZXhpdCgpIHNvIHRoZSBjbWRsaW5lIGlucHV0IHBhdGggY2FuIA0KPiBi
ZSBpbnRlcnJ1cHRlZC4NCj4NCj4gSG93ZXZlciwgcHJvbXB0KCkgZnJlZXMgdGhlIGNtZGxpbmUg
b2JqZWN0IHdpdGggY21kbGluZV9zdGRpbl9leGl0KCkgDQo+IGFmdGVyIGNtZGxpbmVfaW50ZXJh
Y3QoKSByZXR1cm5zLCB3aGlsZSB0aGUgZ2xvYmFsIHRlc3RwbWRfY2wgcG9pbnRlciANCj4gbWF5
IHN0aWxsIGJlIG9ic2VydmVkIGJ5IGEgbGF0ZXIgc2lnbmFsIGR1cmluZyBzaHV0ZG93bi4gSWYg
U0lHSU5UIA0KPiBhcnJpdmVzIGFmdGVyIHRoZSBjbWRsaW5lIG9iamVjdCBpcyBmcmVlZCwgcHJv
bXB0X2V4aXQoKSBtYXkgY2FsbA0KPiBjbWRsaW5lX3F1aXQoKSBvbiBzdGFsZSBzdGF0ZSBhbmQg
dHJpZ2dlciBhIHVzZS1hZnRlci1mcmVlLg0KPg0KPiBLZWVwIHRoZSBleGlzdGluZyBwcm9tcHRf
ZXhpdCgpIGJlaGF2aW9yIHNvIGludGVyYWN0aXZlIGlucHV0IGNhbiANCj4gc3RpbGwgYmUgY2Fu
Y2VsbGVkLCBidXQgc3RvcmUgdGhlIGNtZGxpbmUgb2JqZWN0IGluIGEgbG9jYWwgdmFyaWFibGUg
DQo+IGFuZCBjbGVhciB0ZXN0cG1kX2NsIGJlZm9yZSBmcmVlaW5nIGl0Lg0KPg0KPiBUaGlzIHBy
ZXNlcnZlcyB0aGUgaW50ZXJhY3RpdmUtbW9kZSBmaXggaW50cm9kdWNlZCBmb3IgV2luZG93cyB3
aGlsZSANCj4gYXZvaWRpbmcgYSBzaHV0ZG93bi10aW1lIHVzZS1hZnRlci1mcmVlLg0KPg0KPiBG
aXhlczogZjFkMDk5M2UwMzRlICgiYXBwL3Rlc3RwbWQ6IGZpeCBpbnRlcmFjdGl2ZSBtb2RlIG9u
IFdpbmRvd3MiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN1
bnlhbmcgV3UgPHN1bnlhbmcud3VAamFndWFybWljcm8uY29tPg0KPiAtLS0NCj4gIGFwcC90ZXN0
LXBtZC9jbWRsaW5lLmMgfCAxNiArKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FwcC90
ZXN0LXBtZC9jbWRsaW5lLmMgYi9hcHAvdGVzdC1wbWQvY21kbGluZS5jIGluZGV4IA0KPiBjNWFi
ZWI1NzMwLi5lM2VkMGYxODY1IDEwMDY0NA0KPiAtLS0gYS9hcHAvdGVzdC1wbWQvY21kbGluZS5j
DQo+ICsrKyBiL2FwcC90ZXN0LXBtZC9jbWRsaW5lLmMNCj4gQEAgLTE0NTAwLDIyICsxNDUwMCwy
OCBAQCBjbWRsaW5lX3JlYWRfZnJvbV9maWxlKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCANCj4gYm9v
bCBlY2hvKSAgdm9pZA0KPiAgcHJvbXB0X2V4aXQodm9pZCkNCj4gIHsNCj4gLSAgICAgY21kbGlu
ZV9xdWl0KHRlc3RwbWRfY2wpOw0KPiArICAgICBpZiAodGVzdHBtZF9jbCAhPSBOVUxMKQ0KPiAr
ICAgICAgICAgICAgIGNtZGxpbmVfcXVpdCh0ZXN0cG1kX2NsKTsNCj4gIH0NCj4NCj4gIC8qIHBy
b21wdCBmdW5jdGlvbiwgY2FsbGVkIGZyb20gbWFpbiBvbiBNQUlOIGxjb3JlICovICB2b2lkDQo+
ICBwcm9tcHQodm9pZCkNCj4gIHsNCj4gLSAgICAgdGVzdHBtZF9jbCA9IGNtZGxpbmVfc3RkaW5f
bmV3KG1haW5fY3R4LCAidGVzdHBtZD4gIik7DQo+IC0gICAgIGlmICh0ZXN0cG1kX2NsID09IE5V
TEwpIHsNCj4gKyAgICAgc3RydWN0IGNtZGxpbmUgKmNsOw0KPiArDQo+ICsgICAgIGNsID0gY21k
bGluZV9zdGRpbl9uZXcobWFpbl9jdHgsICJ0ZXN0cG1kPiAiKTsNCj4gKyAgICAgaWYgKGNsID09
IE5VTEwpIHsNCj4gICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICJGYWlsZWQgdG8gY3JlYXRlIHN0ZGluIGJhc2VkIGNtZGxpbmUgY29udGV4dFxu
Iik7DQo+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9DQo+DQo+IC0gICAgIGNtZGxp
bmVfaW50ZXJhY3QodGVzdHBtZF9jbCk7DQo+IC0gICAgIGNtZGxpbmVfc3RkaW5fZXhpdCh0ZXN0
cG1kX2NsKTsNCj4gKyAgICAgdGVzdHBtZF9jbCA9IGNsOw0KPiArICAgICBjbWRsaW5lX2ludGVy
YWN0KGNsKTsNCj4gKyAgICAgLyogQ2xlYXIgZ2xvYmFsIHBvaW50ZXIgYmVmb3JlIGZyZWVpbmcg
Y21kbGluZSBvYmplY3QuICovDQo+ICsgICAgIHRlc3RwbWRfY2wgPSBOVUxMOw0KPiArICAgICBj
bWRsaW5lX3N0ZGluX2V4aXQoY2wpOw0KPiAgfQ0KDQpEbyB5b3UgbmVlZCBzb21lIG1lbW9yeSBi
YXJyaWVycyBpbiB0aGlzIGNvZGUgdG8gZ3VhcmFudGVlIHRoYXQgdGhlIE5VTEwgcG9pbnRlciBp
cyB2aXNpYmxlIHRvIG90aGVyIHRocmVhZHMgYmVmb3JlIHlvdSBzdGFydCBjYWxsaW5nIHRoZSBl
eGl0IGZ1bmN0aW9uPw0KDQovQnJ1Y2UNCg==
