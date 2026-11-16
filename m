Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A76606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Icwz68bs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE2B340150;
	Mon, 16 Nov 2026 05:08:12 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id E957E400EF
 for <dev@dpdk.org>; Mon, 16 Nov 2026 05:08:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi6H8sWagL2YS87pDgX+z6YuzqAGdUvlUahcb70ntjNs2y7qgK4WEVoIG6zVF98CptmANUJuK7xtDIiuZjxf8vBsVFfWDfwTWwZ9oG8z7hnQ8EKT5ZLi5QeheGD3+oFdDDT+cN1h2OLcgNm/9bhZEnNb7fc92HkECLt4a/Rk+WwsdOu/ykjyodKWIPW9V3oujG3dcSVVCYLsuHh5vAQxlwg7xINdUZK54Op09sUA7e9woUeSSxQPYustWiIKU+l8q/TbfSGSXpVSRe+slLsdMd+8/A3RdF4wAilkSWdsEaAOVcJZwusf4olSoSuGZjFuOcoBdnFm82kXPwaZMwgB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkXqLXaE6VGTps7N5rRIEqDJESH7Zq4cxLZ7fpPgQHw=;
 b=E2rcayyhPU0ciHW93K0vK6G8naA7rsMkkB8NDVuRdcSOB5AjIrKriH+i3oL20gjQMSVsHzA1H4wTbu+YARZFOCAszDSZVXWgyI+w1pLs8fkqBSakvMAwZ1wbgFnXYegCw1Nh9TzVJZIqKE5YnXsSHktNdgtfWS1hQWTugGPZmuOe/DCdvqzag78Ky8VCdGI1RMH1dwJLNnOEIIzAuY8Sn/e+H4UrTKsL50fd9LsdoSiH1raV6Zd/ZoKmlcx6Yf/Xipf1VPF6plLGLdHIfWQ51xDBwsJ7reOEMjPY7zFnmHcXnvNTS5PzALGK0NJg1b0t1tFl3GQWBEeq1ErvnqU3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkXqLXaE6VGTps7N5rRIEqDJESH7Zq4cxLZ7fpPgQHw=;
 b=Icwz68bsrfBmkPX14LkEgbhY2jI39rUwPWD7H93O72oEOQhnr3ETKnsvQIGn6f63NcUrzEy7q5NuMCBhq9hIWzgWM79DMrmJdQKOP14g/FXK0TEyb9sFRCgDGo+L9CDjeb7OoIJWUQSQHIK2RThnfLqqCRI797gpXJyJl98yQ4eynH84IuDvG7QOR64vPyGj8Yj8oObN9tayKog14sKdXAXhlL9du9vPL+aOCzgRd2puw4qRLRiisDh8WvoYI5tErnk2M8dQXwaXGbPbvK39Kax22SWP28F9hdg7XMiWfC0rYTfYJK/yHSDfuIoBjsKmP8GuCwIxkoG0Oiyin+ga2w==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by VI0PR04MB739965.eurprd04.prod.outlook.com
 (2603:10a6:800:362::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:08:08 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 04:08:08 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3 0/2] DPAA compilation fix ppc64le and riscv
Thread-Topic: [PATCH v3 0/2] DPAA compilation fix ppc64le and riscv
Thread-Index: AQHdZfZEsnN1wpf98kWqtd09QBFyUbcqwsQAgAVxWnA=
Date: Mon, 16 Nov 2026 04:08:08 +0000
Message-ID: <AMBPR04MB122819026B231D0F2B87C1234E17C2@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20261027063131.3979699-2-g.singh@nxp.com>
 <20261027093335.4109017-1-g.singh@nxp.com>
 <r2kqH2i-RM-8OZ4ubzaEuw@monjalon.net>
In-Reply-To: <r2kqH2i-RM-8OZ4ubzaEuw@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-16T04:07:39.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|VI0PR04MB739965:EE_
x-ms-office365-filtering-correlation-id: fab069b7-2469-4933-cb88-08df439738cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|261026121527099003|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hMus+y0Vz/NdT8bdHe4xPmhziwqCPGSnFr23FHuWVv8BWTQxMlh6us74d5spiee0fr01rLo3UqjdcNvM0z0f6zNq9Nx7UIXYp6S8NZ36Emn3H6/15MAY90XygLHgxHbaw1RETS631IK/8Eg74Xg2vKEbiFkuJpV3NCVuh3YCh+S7ixmYqb1YaB3XotQeCsEVZhhGFZJXGbGQDIQE7wzgDr8j0C7pmORD3g9KmEwlsVy5HebyPW4ZOvslaA8X4cjJVZ40lBlQti8uHsDLmXmkGtDE2ccFK80js35YjB449YL0eFF/XpbyfLBTTEWc5bwslXv9xYt6syhLa21wfTVeHA0J/TbSpSTDTIZsJrZfMIB/yqfCAcxicw8rMi1QH2ZBUtVS48jl9MGtBEfaP/SSOoZyE79Qe5eaTHgmiIr6Zv/MBidckvjx9wijGY8XHFIer56GC52R9DaQSXtKNzM6uM5ArBYdMIFmfEPZ0Ke5QE685tfpdAeZDnj8Gj4o27UIGtgEaAzg1PRScGkNeXS40WGOJoXYDkiCdyGu+HPz7h90U3lGt2GAp3b99A0Gd3usd00dVBgrb7Q+57zVkzN8H57M5vkdIwjuxNn5U6rmUukmKwygBsl/yd9IJ+qIntvNd3e/XPFdaCf7GI9BLKSKXrjDeIIyNsXBt3KnRx7kzS6kvrYp561gZPZ2UFxDdnYrfmrBFQujtOhXDDn2NaqF/TYb6DhRXA2514aHpSJRvXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(261026121527099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZZTkVnWnpveUNrc3NIc1d6eFZzTHpIY3RiTXFEOWRvOTRCYms5N2xLZUt4?=
 =?utf-8?B?UXhteE9iVkNkbURZcFl3Y3FsVDB0RWlicWhKNUhEYjZ4eXU5aDM2MHFMZC9D?=
 =?utf-8?B?TEFFdHJRZlFNdTNHakVyN292RUx2QUhaZEZVTXE5WjBtNHdFWit2aS9PWDMw?=
 =?utf-8?B?NEtyQ2pZWCtiTmVqNkNqaEZyajFPei9jK1dCUmJib0o4VzJtYlpTT1dpM2ZU?=
 =?utf-8?B?L2o0Uk9FOWJLZGM0dThLUmxKOFpTTE1xQnp4dVh4UEFqaE5kMFZQcTNYdFVs?=
 =?utf-8?B?dnhObXR3bkdKOGZmelVXSHRDN2MzVmZ2aExqbWpTMzZFNnlxTURoY1Y0Ulk2?=
 =?utf-8?B?Z0lEQy9YejFFNGltdjZMckl4d3RGODdzUDAvait6V29JTnFUQ0VrNWhEUmsr?=
 =?utf-8?B?UTB6RjZUWVFkZFJVNUNkMCs3Nm9lb212YzhzTUZaZ3dDRDgvemx5RTFuMXhL?=
 =?utf-8?B?WHNaNVZ3ZG5rbGdlR1BlNCtiaXlRMENaUHBEbExteUtMVkE0R2tNZDY2WFFz?=
 =?utf-8?B?allHNU1xMWlEUDB3RVltMy9JNkxYSVVGdnNNTDRqTmZGNHZpK28yTll1MnlN?=
 =?utf-8?B?K2UrZWpxM1pqdW91TlBGSk43YXd0bkE5b1Z0YkFNUUFFanpzUHp1cHBnK0ZV?=
 =?utf-8?B?MHQwNy9UeVM1YXA3NHFrUWZJayt4UTJnSyt1MVlYT2pkUGpjL09FcXRRUkxM?=
 =?utf-8?B?NG1weWI3WHZQSmN6UGVTZ2Q3Y3o5a2pnQ05CM3NYNmE0T2taZ0Zia3dndDAx?=
 =?utf-8?B?cDJueGxoTkJkcGVrc3B1NDNkclZrRWdXbVNDTDMzTlU3WG03bE1ZMXd2OGhx?=
 =?utf-8?B?QnZIS05BNjJVTDQyejlFMUVmaTROYmxsRmsxdXBZc2hOV3RaUXVRYzJTcmlQ?=
 =?utf-8?B?eUl3NGZSYTRvNmZhc0RHVWhRZ0d1L1FjUVhSWmlieCtnM0k1R2RvN044U0Qr?=
 =?utf-8?B?NEZHZzFwazJEN2xVelZMaXFCVGR1NE9URmVTTjlCZy9CQXgxdVo5Q2Y5eGIr?=
 =?utf-8?B?ZFNLZHovb0dzR3JjUVIxczhqSVAvZUpaNHQyQnJoVkhKZjdydHordXROeTRj?=
 =?utf-8?B?VUNSRmMxVHpaazJEMU5jNFVpV1Zka2FSVzhOZzVLRExud0pTckR3Y1hVZytC?=
 =?utf-8?B?eFQ2djZpQ0NxMHRva2V4THFzcEdQQi9IOUdMMGNwYUJHLzd4OHBORTY5T0NG?=
 =?utf-8?B?azNRYmk3djcvT1QxNVVEUGhWZFljUXNZTXpSVURXenBjd1g5UFFJQ1V2Uk1K?=
 =?utf-8?B?NDBNY3Q2RzcxM2kvK01OV25zckN1Y2ZNSE5OT2JzQXVac29LVW9jYXVHcXc0?=
 =?utf-8?B?NndPZXFPNlpSbDdxYVMxYUVvVXhIdjJqVElFb0xCQ25OSnNhaVlEc0Z2YkhP?=
 =?utf-8?B?dW1PdTlaNlFNNmJHM0Znc0tnaTRRbVNnVnpPWEg0N1FYTjYxeTVEb3NsbTRS?=
 =?utf-8?B?UnJCRWQ4Z1gyM08vRytRb1ZhTElJK3AwdHNKbUUvVzlnVUlrRWpna1JwTGVT?=
 =?utf-8?B?OWdwQTVPeThHcUYrVFUxR0hTRForbGtJeTRGTUVZdmR4RlI0eEdnU1VCN3JE?=
 =?utf-8?B?VWl5QjhETFhIVTJnSWFxMzhMVkpCU29NL1RKL2FHNGY0OEJBOFNJNm9jUC8v?=
 =?utf-8?B?eGpGRFYrMzNhdzJCWjg5ZVJqc25KUHNzeFBLdS80TGZDZ082NXZpVGdTTExL?=
 =?utf-8?B?MW96eDlxSnczQVAzeXNrN0pKcHozZldLbmRXOERzL09ZQ2ZUczVmYkxBVzR3?=
 =?utf-8?B?cmZNdHNMZHVaL3BTRTdEd2dpYTU4YmpYL0c5VGUzOGNSTUp5aUtyMHI2MWNm?=
 =?utf-8?B?czE5YWgwR25VcHRQeFdQQ1FpWGVOamdrUmYyclVrbDY4U1VScEVINTJtb1pm?=
 =?utf-8?B?OFp3dGNNelRENTJnaDNrVlhzZmhaMXBRZTMvNy9rSmJFbCtUd2czRDFSM0dH?=
 =?utf-8?B?a3hCTWhBL1VydHk4ZzhHVFpZekNkL0d2SGd3dFcyY0FrcE9QWUdNcjVmQXRL?=
 =?utf-8?B?RXlldWxuUTJPcXZNZkprazN5ZUpjcjJHTEU0L1k2ZHhaU2VUMTBvSGg5V0ls?=
 =?utf-8?B?dDViZEJESFBlRlJBZjNhOHIvZVpncWF0bDZJamNtSjdoQjBsazQ1M1lNSVVx?=
 =?utf-8?B?MzI3bFA0UXA1YUpINytSVXpwbHIvb21iNWpVUlBBOU4xcEdpSUZTeXp2U1hP?=
 =?utf-8?B?NzcvRTlSQzVDbTBTTVBkR2wyTG9icUFqQnR1MngrdGNNM2hqVElZb2FDUzBE?=
 =?utf-8?B?TjdzUTNCbmNlbGFnMUZudkVYclZyaHdtZGNKWTJYcExpbGdtQzQ2aVN5Q2Fo?=
 =?utf-8?Q?bRAAfKdJI+amFcqA5+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab069b7-2469-4933-cb88-08df439738cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 04:08:08.1805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8TCvrdm+UmZqdMiRQ0P2y7GCRQuBp3/lG8ap+h8uNjE+VQlu8E/Ut0I/eRveZTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB739965
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkNCg0KDQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9uLm5ldD4NCj4gU2VudDogVGh1
cnNkYXksIE5vdmVtYmVyIDEyLCAyMDI2IDEwOjMxIFBNDQo+IFRvOiBHYWdhbmRlZXAgU2luZ2gg
PEcuU2luZ2hAbnhwLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgZGF2aWQubWFyY2hhbmRAcmVk
aGF0LmNvbTsgSGVtYW50IEFncmF3YWwNCj4gPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+OyBTdGVw
aGVuIEhlbW1pbmdlcg0KPiA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMC8yXSBEUEFBIGNvbXBpbGF0aW9uIGZpeCBwcGM2NGxlIGFuZCByaXNj
dg0KPg0KPiAyNy8xMC8yMDI2IDEwOjMzLCBHYWdhbmRlZXAgU2luZ2g6DQo+ID4gVjMtY2hhbmdl
czoNCj4gPiAtIGZpeGVkIG51bSB1c2FnZSBpbiBibWFuX3JlbGVhc2UoKQ0KPg0KPiB2MiB3YXMg
c3F1YXNoZWQgaW4gbmV4dC1uZXQNCj4NCj4gSXQgc2VlbXMgYSBjaGFuZ2UgaW4gdjMgaXMgbm90
IG1lcmdlZC4NCj4gRG8geW91IHdhbnQgdG8gcmViYXNlPw0KPg0KRG9uZSBhbmQgVjQgc2VudC4N
ClRoYW5rcy4NCj4NCj4NCg0K
