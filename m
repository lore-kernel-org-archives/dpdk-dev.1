Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F5F513EE
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 03:39:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8805A402D3;
	Fri,  6 Mar 2026 04:39:34 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6958340278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 04:39:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAKBUUbTpXKJbUzipo9rBRIrw4In7o6V6XAfsvUojmL+Jh+2x/95fXpQIdN53jqVCh9Jj1ECAw+7+jKciB/P4q8A1slq1i2eGSnQAjvvTisXJH6jyZwMPYtUXWGoAUR0IsHRaB0PCrBu9nnDuGlTEkCE7F7lh8FG0yoPIFfg91e1cXaHA4Hjm4gB28uR6Q5IBEQwFH3SGVWLUI2sejzI5tDmpQYjPYVxj3qbJ6/5/KqL264UsplTfxZFbWEqZCCT5Q0dnddIpi+4j1OSLkiK25q4hiTOwhc9EsMbaEVkVG7s989tmDas+ANlCo428tuPa4spBH/Ld+7bthsJovPScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XafsTwUANMqx4JOUrhBGg8yUseOgiW0eRC8JseLhEDg=;
 b=FyQ6KRbuu3zDwLqzpBEmDPNPR5Ya8vf1pNgmqAKOTdqpRNzux6ja3gNiTeZt7estXU/uVbqBIj086wZtnE1tZThnuYh9EVSDig7w4TZkF6Hck5fQ29Mao3BD6ovMqeNsoTa3tsU64z/MbrYBq0KXdFurJNlK71FIRn/lmBQY4XN/lBqHxnsxzk7XtMVtWIMYGQJ1SK8yiaQq/25CEMRg7dy3C+YdPBJ0gxZZyTCDcvsMaT32jmy7swS+L6fOVWcZ27pzMS6GXnoae8OXxjNwLE38l45+zZui+9af5Q1XTjvhSBFvhDg0hRWU90FkvOXrmL5iKmp7+uignrhpq3/Itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XafsTwUANMqx4JOUrhBGg8yUseOgiW0eRC8JseLhEDg=;
 b=ZZPo1bLhj1y9g3X7EDwCxjHkQMvupp8+Zqxa0hkyPBWqBtLAXXIAfuTOgNB2/MjjiQnfhsAdMJaW5ODrOHU/SAgpWDH79gSEDuQjKAOKXjZKvxj0LpuJMiFL024zyeWSsC/29foRQGS1QJSRyCxDVzhPy6b54F4v3yEbIiEDMyl55EFRjKyicsKw0Y54TI6sZbWHRmHEmgWGtmi6ZyIrp9fD1NNAWHoW+PItmFfshfbZLKI/NhTTo1a5uNzKnk5HPcOWzk8LoEBTfbWSfTjyvhe1wD6Qaq5K79F7J65arnwKcooAY9QbOzoqEh33nAtFWZWjhUsLLTlKvBg9C8abAw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GV1PR04MB10725.eurprd04.prod.outlook.com
 (2603:10a6:150:20a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:39:29 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:39:29 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Akhil Goyal <gakhil@marvell.com>, Emma Finn <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>,
 Anoob Joseph <anoobj@marvell.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Nagadheeraj Rottela
 <rnagadheeraj@marvell.com>, Matan Azrad <matan@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Topic: [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Index: AQHcrRrWnnWPxK+1I0qZu/eg9Ayc0A==
Date: Fri, 6 Mar 2026 03:39:29 +0000
Message-ID: <GV1PR04MB10750E231752317F51E870046897AA@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260211121916.2598788-1-emma.finn@intel.com>
 <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|GV1PR04MB10725:EE_
x-ms-office365-filtering-correlation-id: 7edee100-26f8-49ab-1aae-08de7b31f8e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: vUzvM5Lap4UVRxdO+J2SRrzpM42a16M2CtHtvQyCSY+Q+GXySqZTw3xg6sHhSzO3TBxCKclqC/G8nXrR4Qd+0lMYSmAtM1oIv8c0N5h2n6pjb2vzPQqC77L+K/FMhEe23Zadueej5qhgjXCOLyWs+c1tZpLV638H/kRJlLMEQpaJJS7kP3NMWqkxezHqpC8E2bmsNyNOlwcV4PUozOnRgFvb4ICpYhkW97dpZmUAxzqoGHTgFkZ3lnB2Pxt8dU0AYkYgYN8Uwgucba3SVwKe/Iee5abmEYioeOG7gqc6Bq0hhh3vJN3Zs0DGxVk8mUv+XkY8TrLuxqqAV/fMsM5u/bk+aZa2A+3Giqsj0Sd4fnQQxJ7Ocu6JlEwQoSKdNsVNVGTXNjZ/qT4qpbwF33/1chlNvI8UAst8iJJWzMo8uCdj65PNwTg59zPTXtE9ZAYFNyfmrh/RIAbR4bbgAT3+qDJlQLTZQ4rCboABepbTTCcVMq3IkA4XhyzCQch8piZsixfwNs6zzu6doHRTfKAUP5zKzUev7+XoF3MqNXmqy6bJy3naq33kjLpjhgnyJ6r0S9qcKxQ4ytKVYZ6UKTJXAUCv7eeVoZ3DlGBpoK/oZ0f3W56E0kDopGHykL7dr2XQXuSWDllCnl6v7VGeW+Mh8UdoNYD6GLMveLnRZhGA0HXJdiUYsNi5jl1yIZhd7H1EBWVHs3v0m87zVYFnjM+0vWAbCYIXT/c+ay1D890s7Tq+SymjQiHqdZd66xEo3BNIqUdga5hOSYYuFyxCDq4G85rlkA/43dNmE9V7PLgfDvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdUYkdPaTZQQ3JuTDFvRVdsTUEzckpUSVpNd291a3JnR05rcWlyODMvMUNK?=
 =?utf-8?B?VUVvbTV0YTFxdGVXYTVDVGp5eXpPNTVTSXh2OTZIN3RlRFJiK3BBSUx2NWtp?=
 =?utf-8?B?TjFRdGF0a1V0ekpoNmg3TmNydTBNc2RVVTQ1TlNBL1Q0S0VXTmEzb0NaemJ6?=
 =?utf-8?B?anA5TU4vRXdvL2NxZndGdWFiVWhxN2lwaWNQa3ZLME1UZCszckxDMUxPZ3gy?=
 =?utf-8?B?RUdxcEV6TDJiRkFucjVUQXRNOG50aVN5NnBUVVVjaHF2Nmx6Y3hibSs1K01P?=
 =?utf-8?B?c0d6UldXNTRORytldGV2MEEzNFNWVG1VWHczbkVhNTQ4RWVzMThCOUM2OWRP?=
 =?utf-8?B?dmpxcmc1THkrcVR0blVCZ1VxYlpFdldsY1NoQzBkbGR6Qm1Gb0lka0Y5VXlM?=
 =?utf-8?B?NEx4M2p1T1EreHZDT1FsTmlPTkJ4d2V3S1dMc3Q4cVMwVlN2dXEzemdpTE5R?=
 =?utf-8?B?dzNHVE5mOU51cGdWMkFvWk5pS21KLzJzWTlFSThsaElCNXN1ZWNlbUtOa2Zu?=
 =?utf-8?B?TEptcXpvTGVLOE5INXlkU0dRYWlzTldCTG5HOThyMTVxQThaOFVVbVEwK3B1?=
 =?utf-8?B?MTk0MTNhbUwxYnZKdXI5dklYVFR1YVFCcTROeVMvaksrcDZzTEpraVoyZFZt?=
 =?utf-8?B?UjN1MDRCQTFhR0k0UXdxeEdNeS9iYXZjT2VDeTR4VUMxUE04cU40SU51VDRS?=
 =?utf-8?B?YXJtaU9kK0hlL0gxU2VDNCs3aWhwTVo5VTNnbUljcXN1RTJxd2tWZzQ0bnVn?=
 =?utf-8?B?ZVhQVVlQWVpiZHh5ZEJOSVJCeHhRaXcxVmJpdC9CT1BHcUZwdGpLRVZvMXpa?=
 =?utf-8?B?MVRaZlZoQ3pZcEdjbHozRXQzdkRsTkRUcnl3QTdJcDR3YnJBR0lCVW9rV2N4?=
 =?utf-8?B?TFlqT1dWeGJRZXFRQ0ttZnd4OU9ua2J3R2dJNW1CYS9mR3VMVzg4VWh5eDNv?=
 =?utf-8?B?eUZJanlkUXFzSEUrc0s3ek90TkZPTE8wZGFYNHc1UUhOeWR3WGtNU1B1bTd0?=
 =?utf-8?B?b2RCNmpvaTZVeWtlN1B0Z0kzRE1tNE1lRGttWXk0ODM3TWZ2NG1YcVVtT3Qr?=
 =?utf-8?B?alk1Q2VPckltd3d1Vk4vQXZzVjE3Ukp0UFBJOWNhRFBzaXNmMGRjTE5scWJZ?=
 =?utf-8?B?NWdwZmY5SjM2OWtmcDFLcEZNRDEycXo3THhtNDFYZ0tLZEFmSDNadkkxOTd3?=
 =?utf-8?B?ci8rV1lCQ1dCVEdpKzIzN3Q5Umh2T3FkUWpOeTQ3R1lxUU1iaEhBREwvNElj?=
 =?utf-8?B?SWloY240LzBhMk93eU5rNUZpZGZuSGxJc09KVEZhY2o0Vm5ob0U2SWJiMG9l?=
 =?utf-8?B?R3MvaktLOWVXMUdTSVFJRElmQ1FscE4rMGxoWm52U1hXdEpISW1HUkZ2elVr?=
 =?utf-8?B?c3VmS1NwUGU5S1NjdUswd2JQQzh4SFRoM0pYcm1DNVlFQTl5WG85UHJKU25N?=
 =?utf-8?B?WmMwMmFYbC9MU2V5elkxSk5kMEhpU0xVL2JEbVl4ejc3Q211SlFYM0sydHNK?=
 =?utf-8?B?S054akg0TUZ5QXk4VkVOTEZNaVNUMDZ5THdZUHNzM3ZrcnkvVEQxTHljSWFy?=
 =?utf-8?B?dmRsOTRvczNFSEo4Mmk1WGZVa3JwczdKM1ppMWdyNjh2aHl5UXdWSnVrdmlE?=
 =?utf-8?B?WkNWazkxVVMwZVdNTmJvRGxzSm80UXlHRGl3bWJ3K0tJbFVoQXdTdkRMK2RK?=
 =?utf-8?B?d3NwcEhVeTlIejhWS0xQcERyaGZLT3R6QmNvTUZjdGcvQzZqc01ZTVYwYVF6?=
 =?utf-8?B?NytwcHNQVGxqc2dqMzJkUUs2eitjb0dmajlzRm42SzFmSTB3dkVOOHJzQzNt?=
 =?utf-8?B?dGZxYnVEQmVIVUFKeXlhTktMM0lKWlR2cmJyMWhvWTN3L1l3ZjU0ZzY3M0U5?=
 =?utf-8?B?VTdQems3bXQ0M05IeGtRMUlXVHY4SWlBYzhBdjRvNlJ3TFR6OHhTMDk1UTJx?=
 =?utf-8?B?ZnlUS1BTQThpWkwvVWtqOHMzMUorb3BIOEpTd3U2Mm44VWt1cmtaNThvSmx3?=
 =?utf-8?B?N3diZHZONEtQd3VhOWNWaERlYXhPWUJxbnVlWXZSQW1XNjRmWWFEc2RTNHBj?=
 =?utf-8?B?YnhucWE5RXo0alpEZTdPczhGb0lYT1R1TEV4d3QzekpqbTZJOTNyaE1RUlYv?=
 =?utf-8?B?dkxTbG13RkNsbEI2ODV0S28vUDJ1R1lpZ284Nm9GaWNMMnE2R0NvaGN6MW8r?=
 =?utf-8?B?ektYdTZNQWdwSUl4MUxPQ1pQWFBSUTZIc1VPT1BQOEVNaC9MdnlkWGRja0NV?=
 =?utf-8?B?emxZMGtZYURXOWZhd25zeElRQnhndnNtYXpMZWFSSU44SUJBYlFHQ1QxQkJi?=
 =?utf-8?B?Um5uc0U0TGJBOG9FTVdBc0dXbTdrRjROb2U4MzlobjV1U0RnSEt1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edee100-26f8-49ab-1aae-08de7b31f8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 03:39:29.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuQT9NFZWmCDLAScuoSnjEpDTZqWARxZH1VBhBVQFjaSy8b5p9ezWZUV+fFU6kWn7VAGZ5D+3otvHo24XyPaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725
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

PiA+IE9wZW5TU0wgMS4xLjEgcmVhY2hlZCBlbmQtb2YtbGlmZSBpbiBTZXB0ZW1iZXIgMjAyMy4g
RnV0dXJlIHJlbGVhc2VzDQo+ID4gb2YgRFBESyB3aWxsIHJlcXVpcmUgbWluaW11bSBvZiBPcGVu
U1NMIDMuMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWEgRmlubiA8ZW1tYS5maW5uQGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVs
bC5jb20+IEFkZGluZyBtb3JlIFBNRCBtYWludGFpbmVycw0KPiBmb3IgYWNrcy4NCj4gDQpBY2tl
ZC1ieTogSGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+DQo=
