Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB04C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 05:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D40FF40648;
	Mon, 19 May 2025 07:42:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by mails.dpdk.org (Postfix) with ESMTP id D6EB64060C;
 Mon, 19 May 2025 07:42:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9jOh7eC9SuDaTjgwgHwvd+JlG8cUkL/8xhpTkCu44Y77W3+qOq/J5dXOeOOqxL4KcNQjXsNco9eC74yIX7JEhi81mxI/mPtdYprz4jQBXND4hES7eyfPmcKmJVsoONWfbx78tIujFaprzT7l6vtxgnnvAvyki/CO4Tc72248V9LF+GIMGsM2ofGA7WCesB8+i+cZDrMqzuLN4Be24tZiZtF/lh81kxMElfcGJKNh1hy/pg6y+GPp13ecbM43x1YLTYuc8JE6STctDw+lax9EF6385qJ3UbkP/CdJ+PmCwj9nRliYL9wUDY7KT8NrraDn5quIHIr0qGSnOKA5znOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRolqRmfkWc0aBrSw7gy9+c9iTFgBpldnRT1NLWkxB8=;
 b=riBXdrqqbWRqprNYMRJ+6U1IMBSvb/7jFVU3AqnK6WKzA8AsHu8g3DT7xCtrC3dFhX83S5xo+JcsGjzCH3Wdzs9PE42sTe6SsCfwIQpldKjjzx5F8nNRLSIXBndDj85U6tcPbxk4RfrCmN6CLO1HWEhOCsMTDZu7p7rRlo6kArM3WpEaPQqwZif/Q4pf+tSmPKeXgfNx7vWE4IClNqz3B3yF/Ido5NTOXiTHsHXEZwACIORcrZxzuwLzD6DMLSSQfYRUGnYU+fEnDX3Z3BuBg8k2uDyRH2iSWWH7zUV6o6zqgkjQPSjFYuIndNcGxnuQMBP34OVxHApQotkO2qEi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRolqRmfkWc0aBrSw7gy9+c9iTFgBpldnRT1NLWkxB8=;
 b=hK/25pDjILeLrsyttAKuiaVfK5VKSEI9TWH6nYKG83du0f2NSgS8WdHKHjVerMSGYxKNDijdhpKa7NIkUglRMBC1cBX/ZyORf2ntpScbEKCXEz/ydZPBwZnJgp56dLdXXVEUXPwaK/1ZOm3gOJMNu7d0bV8ftxLBGtQ/kgC1ACqYi/T6XNo3Pmp+MPhu4gmAPOZ1g18wUqq2u8WS6Bdypa7EOfuETji6wLxVC5sA5Oxcy0rYB+EIv1uZsTYdPEAaxOCWZJ3peoweNGoJy/COLTIzjnSyCq9Rfzqlun6hJuCcFKSy9D5aoppsit3yb5IhO+ufvV9GvpNXJLm/SKtgoQ==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:42:45 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:42:45 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Shani Peretz <shperetz@nvidia.com>, Akhil Goyal <gakhil@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Suanming Mou <suanmingm@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, 
 Brian Dooley <brian.dooley@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Index: AQHbkmQ2fHSrVkDKA0W0UfYk+ZI74LN3KDKAgA3v8yCAVMSX8A==
Date: Mon, 19 May 2025 05:42:45 +0000
Message-ID: <SA1PR12MB9491AEBA0261CF7E7C07D67DBF9CA@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250311090122.121190-1-shperetz@nvidia.com>
 <CO6PR18MB44844B0F7C3BA22106DD9620D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SA1PR12MB9491AB9BB59AB52B0D3A37FABFA62@SA1PR12MB9491.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB9491AB9BB59AB52B0D3A37FABFA62@SA1PR12MB9491.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: 2d6161cf-eef0-425f-e13d-08dd9697faed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NnFNcFhNejVQUjI2WVNQTTUzanBLL2NuMjQ5VzJMUDJDK0JGVVI1QjRjdVcy?=
 =?utf-8?B?RVdkOVFZaWRTU3VFNFpibmhoVWpqc00rb0EyelgyRzUwc3F4OUZZNXBkUXBx?=
 =?utf-8?B?QjlPN216ZFdYVWs3b1MrMzdaUUw4S0hSV0xvb1NSVndVTkk4UUx3akIvZjJ1?=
 =?utf-8?B?T1B3WmUzY3pRd2Y2UUIraUl1KzVzOHZNMjJ2ak14cmdUZm1ka2JJTnVNNGY2?=
 =?utf-8?B?dHhncXVMNGtCL3RVd3ZYVld0c25WdDRNYVJvckdWS05RVTNiYjFMU0hmbUI3?=
 =?utf-8?B?bTZaTVB4VmdhNWdHVnZkZlVHVHRIZGtGVkk5RHJVd29pZEZaakRPMFluWjg1?=
 =?utf-8?B?a2hjZVo2bTQrUFl5aTZmc3RwWDFPS2M5TDkyQkJLWld0enhMZHFvQm5VYVdq?=
 =?utf-8?B?OHpZT2lGUFNjYmJqQzdzRG50a214RzI2QzhrTm8vQ2d2MHgzL0l3dUJnTmJS?=
 =?utf-8?B?WXRtTzFrRVpmNlhEaWRWSllLMDBDODhQVFZFa0t5dndnbmZ4Y2FCN1ZXM0xh?=
 =?utf-8?B?RlBPMHRpMHA3UUpTQnkvZkluZW5mcFUrN2l4NnArYk1zcjlXY2VtTXlmOHox?=
 =?utf-8?B?eDJiU0g3WlR3TERXTnRNMmYwUHFJTEhXbmMwb3NFd0FReThya0xrb1E5RkFJ?=
 =?utf-8?B?RlNGV1RZWVI4YVJJeFRBTWl5cFJFNFEwY3JteTQzODQvOWJrV284RWxZNWVn?=
 =?utf-8?B?Y2k4ZGdQZE4wcGgxdFNPOUozdUhDVDJRQnVGSWdwZDNSQm8zVTJVdXR6Tzll?=
 =?utf-8?B?b1pVWmlLWFJYclVMMW5GR2Zkd0pmWnh5LzY1ZG5uczU1bHhDMWt4YjFOVWxL?=
 =?utf-8?B?aW5rdHdSMWRDbytwQlBHakhNZ1lOemgxZkpSZlpGREkyRGRhQTM5UU9uaTd0?=
 =?utf-8?B?STg3UkZ1NVNQeThVRHJKc1lWK2VYQU1URGlPUEl0L0k3dFlQa2dKM09aOHV1?=
 =?utf-8?B?Y2wxTzJzbE95M3Nnb3hmR2tYZzhaM2NuRENaam1wTHdqeEV5b3lYclVscEpj?=
 =?utf-8?B?SmxZMkNZamNJc3F3WHlLMHVhTnRpVkltczc0azJUeWZ3OXN2TDNEYTJVQTh3?=
 =?utf-8?B?a3lyeTZnT3Jvb0pKTmY2Z3l1VUUvMG94ck5IV3U2YmI3QnU4UFlScWhLc2pp?=
 =?utf-8?B?ZUovMHRRdUp4bW15SHIzZjY2UEt5VFNrc1BzenFvSmlsak4rZ1VWcFU2UmlV?=
 =?utf-8?B?TVlvYU50ejNaZFREbXh1YkJLQkNMU0FMR3BBQUE2eUp2VU1IcTU1SHJvd0Y0?=
 =?utf-8?B?aXdHU3luMnlqRHNnNk5OVGZmSXc0YVE3dGptdFhCWEd1OEQ5cEZLYWhmVVhY?=
 =?utf-8?B?UitEUXdlRDAwZkdtMHVCYXdyM3pMQTF4WE9CMzJYTUxRK1dHdk5CdWpscG9F?=
 =?utf-8?B?N2c0QWRtZWwvVDdXL1ZNZ0dML2wwQktIdFJkL1MyUlJ1SzhZbTkwVkJvUnEv?=
 =?utf-8?B?d0RxRnI3ek4xWWpqaGg4K2VQMGx3Wi9CNDIrT1Jid0tBMXNpMEdWVTgrd3VI?=
 =?utf-8?B?c1lIenJ3cTMxa0QrckpWL0JRekIrN3hLZGZFbnVtWllWbEZRbDZmVVVjaERw?=
 =?utf-8?B?U05pblZhNlM1NVM2QXBtZXprSUJJa2thUlJ6SkNseDh3TUNoSXhBTnNzejQ5?=
 =?utf-8?B?cVpyNDdTVTdPcVBVRjVYVWFta20xeTlJbXh5MVo2dVdGdFZiaVVxRk9yM0xN?=
 =?utf-8?B?TUNUODMwSWd3M3pneXFZckwrRnlaVFNDcG8zMTdyQk9IdExDQWxEd3FNeTd2?=
 =?utf-8?B?RmU5aWhidW5sOVBDM3Qzc3VqYm85RHV0M0QzdGNZMjRIM2RhZ0xjSU9HTUJR?=
 =?utf-8?B?ZHk1VXN0NVl6TG5TZ3N5bTVqV2JuMEhDSE1TdlVNdUZyZnhMQU1PUDZNa281?=
 =?utf-8?B?cERRWjdhcnNlK1BBckxvNERRMmFLVVNVRFBXSlovcTc2c2pSRDRZcmdINGt1?=
 =?utf-8?B?bTJnaGdUSndqWVdaQ2RlZXpxY05zbkY3YTlDMG5hWFZvU2lwRlluSmlhQmdC?=
 =?utf-8?B?Y04yWjVSLzB3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZiamF1NmVob29FYWJCN3RoYnJDRThmT3RpMWlFMERCZEhERytNeUxwc3E0?=
 =?utf-8?B?WmF2c1R1UFEzOGZPVkFzOWpVbldwU1hZY0lZVCt6dEoxV3dtZURYdVJYVE4x?=
 =?utf-8?B?cUFJYUlSVE10SzkraEIwRFNMNFBjYkswZHNXdlkwNDNuSzNxd3dkNU9qazlm?=
 =?utf-8?B?Rlk0NFEyZjduTzhoWHZLdm5NWXJ2eTFmTTJDWWJPb1Y4Sm9jR2VtM2hwS0FM?=
 =?utf-8?B?L01OMXRncnFVQVpNeW9sM0kzendlbml1TDNTZGZiUnVMamJidlFUYXVxVXE4?=
 =?utf-8?B?L29TSEkvMUd0cEtSaWVxdlpnS2VxdU1YbmxpNGJySERVa0pVTlNIYS8yK1F4?=
 =?utf-8?B?cTlOVkRNbldFNmZtM2J5dlRISXlQQytMdVA3S20xVU1obkNZeHZHL1UvY0c1?=
 =?utf-8?B?b25GYjNRSzJiNGtzTE4vS0lZUEJDMDN5TUZlYW5SNE1VV3VENVJwOFoyZWdB?=
 =?utf-8?B?dGpISGQxTlVWWVROVWtnTDl1S3NmaEpJS2hSQnRMejdCT3c3SHdhelV2UzR4?=
 =?utf-8?B?ZjRyYUxSQ0krd2JvSUo5RXNUUnZYaVNGTkNtWUdoR0RxbVlhN3dTWDhzOXVm?=
 =?utf-8?B?cVBidTBOT3oyU2J3TEQ4NDlqUTZTNDVXVUUxRUkrZWNJVmhjN3hwc0dUYlJu?=
 =?utf-8?B?a1hTVm5nMWoyQ0h5dVlWQ2RPdjNBS1UwRWNSdFB1b2xKK0JyWFlLRXkrN2o3?=
 =?utf-8?B?RGRYNnhEU3RmbEFlYnRieUwvM2U1T3UwcXltcEN3Ry9OK2VyTVFObVEvZU1Z?=
 =?utf-8?B?bDErbWlib3dPQTRFeURSQStKbXZFcHN0eUtjNU9RUERaSTd1N0NPVkNBN0VI?=
 =?utf-8?B?RHloSjNMTGhyKzFKQ3FMNHUvSVFncW1yVXBxMXB4dUdRTUdWcUYzMXdaa3NN?=
 =?utf-8?B?ME5ZeE9vY0dwVDZXOFZmalIzWEhSTElYc0JpVTNmdldMSXBHelFuU2dPd25h?=
 =?utf-8?B?UVFrcEZ3YWgzS2c5NW5VclFucHJuSGRRVzFtRmd5Z0UwRlQrUUhOTzRzSkdu?=
 =?utf-8?B?cURSN3Z5RVBjdDRKM2VGWDZqemFMVUU1WFpSSnE1VmJXbVJRM3NFeTl4Y3Y3?=
 =?utf-8?B?THRodnpDcTFWUEtQMlZYNjJjL29YcExjcUVxODRrTEdDQTNyTE5Va2J1T2RI?=
 =?utf-8?B?L1BJc0NFN2U0ZXQwOEFpYmRTbGIvWEp0L3dKbEVIQ2paTHgySkFNS1NZV1RQ?=
 =?utf-8?B?VlNyalBxOVhQNnA4VCtCbkJyNjdvQ3RMNTlINDBRdkdPMFdKanpFeC8vdzVE?=
 =?utf-8?B?dkd6dWt5MVR0NFhQZmxPOXR0aUhncFNjWkVtYzBOS2N6VEdzYWhVeHlOUWRo?=
 =?utf-8?B?Y20yQ2FETlZMZkJpaUVTZTNySTZvNkU5NEI5TEhjbGZWTnQvMnJ4ZEVCNGph?=
 =?utf-8?B?ZllLVzBYaXIwRHhCUXVuaFZYOExUYnBwNkdpdS9xNDZiZVY2QU9KMFlLMXhi?=
 =?utf-8?B?WVBMQzBnVFU1V1hFaEtmbVRIWlJPekJHcEtsenJjREJHT3pWS1VnL3lxTGY5?=
 =?utf-8?B?cEJ4akxFNnFXOXppU3NUOEdGQTZ4aEFtL2IvdWdxNUVnQWZLRHlsQnhPVWNW?=
 =?utf-8?B?aHV3YWRRMzJydzdIVHZpRUxaQmNiZlBrNTFDZE1wVWxJTUNvbk4xRVZDLytE?=
 =?utf-8?B?YmtVMDUxUnI5MXJyYWlpK2xaRGV5MGRvZDN5VVhsckxvdlJCZG9RNnFYYUF3?=
 =?utf-8?B?cnR0cXZza29ST0xFN3JGb1ZtMGRwNDMzY2F3WjVQSEMwR2NRNVNMb29ma0Mz?=
 =?utf-8?B?Wk5XUjMwbys5dmlBZU5tY1Z6ajV0czFiZEFNOHAvZWRYUytBUm5KdzFjbXdt?=
 =?utf-8?B?Z2ZsZG5aRzRKb3RUMG9yYWJMUmorOHdRdDQvRTJCekRsRDRyVG1ZbUZsQm1j?=
 =?utf-8?B?U3VwWVowK1FwYWNzam1KWUttR1dBTWNXVVFtSDdibmpWYS8wWFFHUG9zOXNF?=
 =?utf-8?B?VFovMU1tVUJ4YmhGd1U1VTlDaEg4b0d0VDNiVDArRVNFMGtQbnlITWxSNUFK?=
 =?utf-8?B?aC95Nmx5SHRjOGYrWXhtV3FZb21DQ0wvM2JWSWsyUkpHNmlQRlU5MUhTM1Q5?=
 =?utf-8?B?MkdsazFGUkhFNlJ1a3dNMm1BdytETW9UVVBDTTk4MUt2OHVva0tGZngwYlRp?=
 =?utf-8?Q?eRPVZigfTNwsGsroFc/kiAoLV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6161cf-eef0-425f-e13d-08dd9697faed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 05:42:45.0484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTTsduxURxcJZeuIkCX+Fyq76GT1IKocX0sGel9pL4Yu9u7EJPHaYuetVDfE/zkM8QH7wEHyICVI8lybdCqWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbmkgUGVyZXR6IDxz
aHBlcmV0ekBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI2IE1hcmNoIDIwMjUgOTox
NA0KPiBUbzogQWtoaWwgR295YWwgPGdha2hpbEBtYXJ2ZWxsLmNvbT47IGRldkBkcGRrLm9yZw0K
PiBDYzogU3Vhbm1pbmcgTW91IDxzdWFubWluZ21AbnZpZGlhLmNvbT47IHN0YWJsZUBkcGRrLm9y
ZzsgQnJpYW4NCj4gRG9vbGV5IDxicmlhbi5kb29sZXlAaW50ZWwuY29tPjsgUGFibG8gZGUgTGFy
YQ0KPiA8cGFibG8uZGUubGFyYS5ndWFyY2hAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW0VY
VEVSTkFMXSBbUEFUQ0hdIGFwcC9jcnlwdG8tcGVyZjogZml4IGFhZCBvZmZzZXQgYWxpZ25tZW50
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgMTcg
TWFyY2ggMjAyNSAxMjoyMw0KPiA+IFRvOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5j
b20+OyBkZXZAZHBkay5vcmcNCj4gPiBDYzogU3Vhbm1pbmcgTW91IDxzdWFubWluZ21AbnZpZGlh
LmNvbT47IHN0YWJsZUBkcGRrLm9yZzsgQnJpYW4NCj4gRG9vbGV5DQo+ID4gPGJyaWFuLmRvb2xl
eUBpbnRlbC5jb20+OyBQYWJsbyBkZSBMYXJhDQo+ID4gPHBhYmxvLmRlLmxhcmEuZ3VhcmNoQGlu
dGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFUQ0hdIGFwcC9jcnlwdG8t
cGVyZjogZml4IGFhZCBvZmZzZXQNCj4gPiBhbGlnbm1lbnQNCj4gPg0KPiA+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4NCj4gPg0K
PiA+IEhpLA0KPiA+ID4gQUFEIG9mZnNldCBpbiBBRVMtR0NNIGNyeXB0byB0ZXN0IHdhcyBjYWxj
dWxhdGVkIGJ5IGFkZGluZyAxNi1ieXRlDQo+ID4gPiBhbGlnbm1lbnQgYWZ0ZXIgdGhlIElWLCB3
aGljaCBpcyBvbmx5IG5lZWRlZCBpbiBBRVMtQ0NNLg0KPiA+DQo+ID4gQWdyZWVkIHRoYXQgQ0NN
IGhhcyBhIHJlcXVpcmVtZW50IGZvciAxNkIgYWxpZ25tZW50Lg0KPiA+IEJ1dCBmb3IgR0NNLCBk
b2VzIGl0IGJyZWFrIGFueSBwcm90b2NvbD8gQ2FuIHdlIG5vdCBhbGlnbiB0byBieXRlDQo+ID4g
Ym91bmRhcnkgZm9yIHBlcmZvcm1hbmNlPw0KPiA+IFRoaXMgaXMgYSBwZXJmb3JtYW5jZSBhcHBs
aWNhdGlvbiB3aGljaCBtYWlubHkgZm9jdXMgb24gZ2V0dGluZyB0aGUNCj4gPiBiZXN0IHRocm91
Z2hwdXQuDQo+ID4gRGlkIHlvdSBjaGVjayBpZiBpdCBpcyBoYXZpbmcgc29tZSBwZXJmb3JtYW5j
ZSBkZWdyYWRhdGlvbj8NCj4gPg0KPiA+ID4NCj4gPiA+IFRoZSBwYXRjaCBjb3JyZWN0IHRoZSBB
QUQgb2Zmc2V0IGNhbGN1bGF0aW9uIGluIEFFUy1HQ00gYWxnb3JpdGhtIHRlc3RzLg0KPiA+ID4N
Cj4gPiA+IEZpeGVzOiAwYjI0MjQyMmQzODUgKCJhcHAvY3J5cHRvLXBlcmY6IHNldCBBQUQgYWZ0
ZXIgdGhlIGNyeXB0bw0KPiA+ID4gb3BlcmF0aW9uIikNCj4gPiA+IENjOiBzdGFibGVAZHBkay5v
cmcNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52
aWRpYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcHAvdGVzdC1jcnlwdG8tcGVyZi9jcGVyZl9v
cHMuYyB8IDQgKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QtY3J5cHRvLXBl
cmYvY3BlcmZfb3BzLmMNCj4gPiA+IGIvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMN
Cj4gPiA+IGluZGV4IDZkNWY1MTAyMjAuLmY5YmU1MWUxN2YgMTAwNjQ0DQo+ID4gPiAtLS0gYS9h
cHAvdGVzdC1jcnlwdG8tcGVyZi9jcGVyZl9vcHMuYw0KPiA+ID4gKysrIGIvYXBwL3Rlc3QtY3J5
cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiA+IEBAIC02ODgsNyArNjg4LDkgQEAgY3BlcmZfc2V0
X29wc19hZWFkKHN0cnVjdCBydGVfY3J5cHRvX29wICoqb3BzLA0KPiA+ID4gICAgICAgdWludDE2
X3QgaTsNCj4gPiA+ICAgICAgIC8qIEFBRCBpcyBwbGFjZWQgYWZ0ZXIgdGhlIElWICovDQo+ID4g
PiAgICAgICB1aW50MTZfdCBhYWRfb2Zmc2V0ID0gaXZfb2Zmc2V0ICsNCj4gPiA+IC0gICAgICAg
ICAgICAgICAgICAgICBSVEVfQUxJR05fQ0VJTCh0ZXN0X3ZlY3Rvci0+YWVhZF9pdi5sZW5ndGgs
IDE2KTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAoKG9wdGlvbnMtPmFlYWRfYWxnbyA9
PQ0KPiA+ID4gKyBSVEVfQ1JZUFRPX0FFQURfQUVTX0NDTSkNCj4gPiA+ID8NCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBSVEVfQUxJR05fQ0VJTCh0ZXN0X3ZlY3Rvci0+YWVhZF9pdi5sZW5n
dGgsIDE2KSA6DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgdGVzdF92ZWN0b3ItPmFlYWRf
aXYubGVuZ3RoKTsNCj4gPiA+DQo+ID4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbmJfb3BzOyBp
KyspIHsNCj4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IHJ0ZV9jcnlwdG9fc3ltX29wICpzeW1f
b3AgPSBvcHNbaV0tPnN5bTsNCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjENCj4gDQo+IEkgY2hlY2tl
ZCB0aGUgdGhyb3VnaHB1dCB0ZXN0LCBhbmQgSSBoYXZlbid0IG5vdGljZWQgYW55IGRlZ3JhZGF0
aW9uDQo+IGNvbXBhcmVkIHRvIHVwc3RyZWFtLiBJIGNhbiBzaGFyZSB0aGUgcmVzdWx0cyBpZiBu
ZWVkZWQuDQo+IE5vdGUgdGhhdCByZWdhcmRsZXNzIG9mIHRoZSBwZXJmb3JtYW5jZSBpdCBmaXhl
cyBzZXZlcmFsIHNlZ21lbnRhdGlvbiBmYXVsdHMgaW4NCj4gdGhlIHRlc3QuDQo+IChUaGUgcHJv
YmxlbSBpcyB0aGF0IHdlIGFsbG9jYXRlIHRoZSBjcnlwdG9fb3BfcHJpdmF0ZV9zaXplIHdpdGhv
dXQNCj4gYWxpZ25tZW50LCBidXQgd2UgdHJ5IHRvIGFjY2VzcyBhcyBpZiBpdCB3YXMgMTYgYnl0
ZSBhbGlnbm1lbnQpDQoNCkhleSwgSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBJIGNhbiBkbyB0byBw
cm9tb3RlIHRoaXMgZml4Pw0KDQo=
