Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDCC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 10:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1720E42F02;
	Thu, 24 Sep 2026 12:33:26 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 52CF7400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:33:24 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eF5R3983792; Thu, 24 Sep 2026 03:33:23 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020136.outbound.protection.outlook.com
 [40.93.198.136])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvm3kkmg5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 03:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MltmJB6EjCoQeQyUJCKOFma22W5qxMptJ/Pq742eb5Phvs3LZNUDnzMablGyOxXgBDkYnn9d85YGa3/6saENaCmsP82XpWorEtah5bGYykGdG5mX1+uEJbOStoeAxphabvW2ibYSSI6zJr+Y0LHTu7q6GQTdIa8Mey6pijyF3OMhHdwS1L27u3/0OvjzsuHX5VpJDPf0Y1uIEjDVnhui0WZy8ilZasB7SZxv1rEMNwFTFTG1Zz5Yqs9/u0lAEOKiVSacCBqUtq4NBCmQ8MGjGir0OILS3YiYpP/zn33KB61Agw33Z/7/TpHUemGoPxVFoBL79cmguyDBg7R83DzwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIMOqL6zVhr7v/QNp8VDJtyi3qJPyEUMnYYGA48oD0k=;
 b=PTlSZpgXA/FpxUzNsW4lGq/VB5tdk1bp0vBoAcDtmS/O/H5Gjk+WMhk6zM5exmTXQLusq47SYByXfxWabfxaPEwi2pFNbAitl5OVkw9mSujH88+sugLrDKnEK2V21T9pDCFL0RYGaU2alW3VsJz3oVsFDxVmnkHXII0VNqGEDqaMxcLMa17IQQuTrD5jMI4ByDbb3+ffW/BlGJGDN2xFwifSxx5p8Ek3yXXHLSgguLUussK1Uz8I57pjjzaRDDjY086wCWTgsedn0gm/w33mBnp9sqc9wKJziXrLfjE3KVJ00aTUDzT36t+kmOigrX0I8I2EGsjMhzCFjisUgtU7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIMOqL6zVhr7v/QNp8VDJtyi3qJPyEUMnYYGA48oD0k=;
 b=Gk84PCGzFzeHFW3fQpTTCv1/aPw9BDZj0mlfM1ALpfn23nwWwXq/Jd9Mz+kHg86WzVjFnXb4CfAhqKE1tA4UpyPaQTkhffijhetomryhhd29wn27xLortG8sHYvN0FlvrVTE63zpA7j6LLFuVnAz7RKrQ08cQKU7k+pdttRoX8U=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW5PR18MB5127.namprd18.prod.outlook.com (2603:10b6:303:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Thu, 24 Sep
 2026 10:33:21 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 10:33:21 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Prashant Gupta <prashant.gupta_3@nxp.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gagandeep Singh <g.singh@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 06/47] crypto/dpaa2_sec: add support for env
 variables
Thread-Topic: [EXTERNAL] [PATCH v2 06/47] crypto/dpaa2_sec: add support for
 env variables
Thread-Index: AQHdQSurK2nRZvjIeEatX/YGHn7dyLbdnabw
Date: Thu, 24 Sep 2026 10:33:21 +0000
Message-ID: <CO6PR18MB4484954CBFCD0128E63BF830D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-7-prashant.gupta_3@nxp.com>
In-Reply-To: <20260910135158.2181141-7-prashant.gupta_3@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW5PR18MB5127:EE_
x-ms-office365-filtering-correlation-id: 0549b67f-55f3-4335-b05c-08df1a274151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: KZgaQPoDCGNVrsr1xkd1WXrq3JbxnurddVTCZleHC7cCkp9oZyuQqpE8I8NOz3EVIYGXbchhiM0lw5AbGmDAJxwfY6wIqQi5LC/F8eoPgo6vochcuh6eaX+CYlCJFRNxYYHoDLdLoeMIcTFpAvvqMjZfg/SVQIoXj57MGOHTJc1rYeLRJX/J+6myCCAX3+rN+9B+I6n9LhyCIyF12aq5zPkeSjRnsnwYRI87IfnVZlzevV//gJNg8xYRicZ+7D4BQcU8OlqQldUlfxiHF1kf+diUUVSw51BE1/tQzkoA8MxwyURR06HkWMnV2oZ71YoCmzHoNL6823KKVmcG8fUdPGkZ6ueGtWKr48VfzSAAHhTzKt+BSWpp9aVgFdqGqPkrdkKEIpkKGweONOqofJH4I55Wuq795r8ryzPsxHBVo31PAl6gMN6PePNHqEDbVDUCyOqDh1efBLkg8R7BII935viRRbfrRNZP+8T+QTgG1SG+6xjVgLBWcEDh58CQ/KkL+OkDPkwIomjoFjVRtUVaAhDlo/C/A6DLN4n9Dm6co8J/hGBLLy9wKditGt+gi+rPrAuMI/D9zpsXCXjjk21x3lK3rpWLbOGn6D7r1iEhGse6gUI2V1DaqCzFXFuFqbvL83R5Raosa7w1fyTKMv2WOpCDPzuxYF8X7L0B88O0/FZthJx0rzs1Y3Hpc0A9LWKTzHR8xqJFkeEo/aRO0OiwJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aThWRUZITFROT2tud3Z1NGRVajZ1SUNOaXlxVzBJTW9zakZCeWV1dWhPYytR?=
 =?utf-8?B?K1pHbzZkVHpmVVlidVJZU2JRekFFaFJ3a001a3RTZURMYktuU1luTW51TWdn?=
 =?utf-8?B?OVJNa3F6b3N3bTlJbmVnTUtCU3hjTnU1YjhJMEx2WE9qamVHejh1bjlBaE0y?=
 =?utf-8?B?UGh4dHdvU2Jla2lsV2g0ZWtoN1ovRDZEaU9lNmtTeTdnNnpsaWR6Z0krVWlr?=
 =?utf-8?B?UVVySytwOGNxcy9YbkFWM25lZGRBT2Z3ZE9zQ3lGRlF1TWhPbGwzbTNOaXp5?=
 =?utf-8?B?MTA1VGJPSkVVZXdvcW43dEIwQTNSZkc3a2JsT09hbFAxbUdhMVNIc0VtaXZS?=
 =?utf-8?B?TWRid2ZMRzlQL3pDMW5TZytLUnFGYWMwb3BPbDUwVGVQSWtXdGZYMUEzRjZv?=
 =?utf-8?B?dmRVRW0zT3d2VWlYRVQ3UHI3U1BselJCUldTeXdROFpqQitqU0tmNXR3K1V2?=
 =?utf-8?B?Z0NRbU8xRVhJdUw2elJLbDVUSWp6VmdweUFJeU41RE9QT1VFc0ZQR2VjbWNn?=
 =?utf-8?B?dHRrUGJReEZkZlBRUHh0d29tUVVnZktON1ZGN01ISjFvcVpQV0VuYkhvNk9k?=
 =?utf-8?B?a3JJdEIzcDVsN3VCanpQTjRSLy9JV1cvYnNWcmw2Si9ZQ3ZHRVBWT3JWRUg1?=
 =?utf-8?B?MzR1SThUZVpzNmhXUm90WkVRSVkzTFdKV214WEpZMG9BVlN3OUZqSGFBM3RB?=
 =?utf-8?B?RVRHalYvU1FjNG9pTFk4T0xKejlGMDYzbWIybHcwZmplQzJEbnRzSGFWZ05m?=
 =?utf-8?B?eWRobFNWOUozeEZ4SUgwMXlRRW5zemVjYnB4VnBGc1JCMklJczdtdlVNQ1gw?=
 =?utf-8?B?eHE0aHFSSlJ4RkVERGMyMVEzT2FQRm9IL051RXo3OUJnSi9jcCtwanNzZ2ZK?=
 =?utf-8?B?UkgxZDRBZUJBbmFUQkJNOHl1ajhxVVEvSittSU5UUEpiNVJ0bUVlZzQvYy9j?=
 =?utf-8?B?YTVSMjgvVWhEa1lzQ2J2RFlxY29nUlYyTVJ4dUpNWnJ3MzhOcnpKM1ZGTWJC?=
 =?utf-8?B?bzcrWFBhbWh0eFFsZlduTHYzbjE4RU00TTNCS0Z0cmhlcjZMb0tpSnQ5U1Fn?=
 =?utf-8?B?RVFRZm9zNzdaMjBtbFZLMS9hbXgzZTdZVmhmR0JMblNzVW11VURTQUlDNmtK?=
 =?utf-8?B?Njc1dytyNUxUODFwR3FIMDFQaDlZaHpObDg5aHNCTDhGOHNCTGhTd3lSclFT?=
 =?utf-8?B?Rmt0RlN5VHFqeGEvb3B1SFhwcklQWWoyWXRSTjhNZW5wYVdORTlrRDFLSWxh?=
 =?utf-8?B?ZFY4M1pXRVZUMkF1UU1vMlNHOVFXUGlObUxvMzd4eUpRWDQ0RVZEc3pZTGRv?=
 =?utf-8?B?YkwxR3lMNkhjWE9LSnVhRVhMdnZtbTN4SmthRklxR3hHR3Z5RWxRMENHellX?=
 =?utf-8?B?ZVJKQWU3azB2a3RzSWd1OUJ3cEx3Y1FOYk1XSzBYSjBGUVAwNnNSSUNwZDhm?=
 =?utf-8?B?bFFWelM2WEpKMjMvMDZ6SEpqY29QNjBYbmE5SjNyN29xbk9CMTFtV3lVQnZl?=
 =?utf-8?B?c3RwTG5DSlZXOHYwWTBVOFhyUHRRYVBlbjRaNEQ0SGljL2kwUllWa1QrakVt?=
 =?utf-8?B?RkFsTThYUm9VTnYrNS9GSU5xSTVqa2RIdnVVeWZkZHFMSkUrbnE1Yzk4RkNH?=
 =?utf-8?B?QW1zRVBtK2RaR045QjcybVgvc2ZPVHZTM3krVlJQbDlWZDdwSG9RVHhuTDlJ?=
 =?utf-8?B?SEFHTWdyTXZEUHRIeE1lRnAzMmd4QlpBdzFkRWJFM1JhNExvajlBYXRoTzJJ?=
 =?utf-8?B?OFNEOVA0ajFKTC9WUjV4TjZKSjQ5RE01aHh5VDVXM3hKQ0N1clhLTjhLYnZT?=
 =?utf-8?B?ZGJKSm96NUdOOFdiYll0TjZXcFp4d1V4U0ZJdUdOQkF5NzhvWHhaNkI5Tkxy?=
 =?utf-8?B?dmFTN1NWYWw1WERTaGFFUzlwWGZLQUlDQzhqR2dqYXVyWE16NVFTUnRwelJp?=
 =?utf-8?B?UFBNNmx5cjY4V2JkT2NMbndRVS93bnhPdjlZUTBEZ2Q4anVRNGJBdTZBYlNW?=
 =?utf-8?B?VCtOUHhpbk9hQ1d6WjcxVE9TLzNFdUEzV0VJMUJyUmxpSFhDaitpajdtMFAx?=
 =?utf-8?B?ZmxZSDhvODh4RVAxcTd6NFdVUXVXaHhhUFl3SDdhMFUwU0lUL2NxVjhvbXJD?=
 =?utf-8?B?Q214UFlVVWpYMUI3TFMwanloUktqREJEVGdJSGRwa0ZselpVV0lLU3NveVhz?=
 =?utf-8?B?TEtoQ1JCd3ExdzZZb2NkWXZ0STh3QlkvVk43OWZ6cG5DQUV1czh6a1RDakJR?=
 =?utf-8?B?Tm5HeW5odFI4TXgyblJ5cFJ2dVZrNXpvNCtac0Z6b3hNc2xSMlpXZjZLL28y?=
 =?utf-8?Q?1jG87jV5TaOZv2VgYE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sbp7f1JbFewLpqKOHORsknZ2Bb2k1EbK3K7ZrJBh/gBYFIyryNrYqgLDsftOAqZiBFJ16LP3Ko+fDW7iW3AyZyA+R0CEcBpM7gSJEuGbB2s3YpKQ0Lv3xwQrKMRvgDRB7byd42pYInif8Pe0OrssgFtUKrk5yzz2HTvBkIXw4D14KtIhYE/laXjuGOElVB9ymFbD7W069bNzYMGXqIjEeT+Mm4kGl8dIYFMYO7jdwuRo3n9WqRPmqhlOjPOzySOOhMWsM/L7K9YC4F30EBf/evzJq0nKb5hkFUQ6FVG39Vl2ZZ0MoZpc5xvWGg4iscPJWPdB8Cs5GF7k/wdMK0I4xA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0549b67f-55f3-4335-b05c-08df1a274151
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 10:33:21.1612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UB9eoEaX1MqLszh8mpnay/tN1Eq8b/L+0jFEYQFM+Lv3WQQBsQtJeeUSHiNYg9lheiBaA6eHwoY3YrOV7aeGQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX43ELKqLhurQr
 WvANyl8yHcyDS7iMFjIn+9rVu0VGJJC6bumzdH5chd7hk9aU1oRQ6Xy5xAxvhW9cmNPdFLO3Bdv
 1Zxr7En3+BenHUNDvU7FNtgfyVpkNWoOYGMRdxs/46w3lGlY9YcDS2/OOvG4rR24m7RZH8nLwdE
 rvveThfL3VisSRBal+9pbfSmPDUM3lnM8qQANsC7CLUzs1yfwd3U2Vw5KZ5/OLUAJvPbTF0od4W
 1qEeaOjjV/+Ed4hf44WPE8MtHklPKP2pb3ZXCgAH3gC9UnSXxkf6Q/Tw5H9hmCgkYXAXucF7vOZ
 +PMIb8EluEi8N8dVsQBeWmd4Stll/0P0DkjuAq7Kxu0t42/v+FVzjubAO5Jji7WxLErUfCzcYkp
 unGh9upZKD5VIG/+DV3MZXLa1MDxMbrXFr2wuF3mcCW3v7xP94fPol5OvEVW2k8ZZKbKwaPqs3H
 gcrMRtUdBLvFJbUHkyQ==
X-Proofpoint-ORIG-GUID: I6URt4J2x5M7VReDUNmaM4xy2_O2eP0H
X-Proofpoint-GUID: I6URt4J2x5M7VReDUNmaM4xy2_O2eP0H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX8ZTldcYTelFE
 yiX8/XHwBRbxdv45Vr9AK4iAjMvbb3u7g+VKn/J9xhNUCSUCNBh8aXpo3ZthRAIMp70iXUIq0hf
 kTRqLgFTl44hpit7kQVjDQ8cfIa+Vjo=
X-Authority-Analysis: v=2.4 cv=LtQHWXdc c=1 sm=1 tr=0 ts=6ab4fc73 cx=c_pps
 a=N0p9dsNkTmNcAxi3Eyz8Mw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8AirrxEcAAAA:8
 a=FFK0lfc_CA8AN1fmMrYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
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

PiBGcm9tOiBHYWdhbmRlZXAgU2luZ2ggPGcuc2luZ2hAbnhwLmNvbT4NCj4gDQo+IEFsbG93IGRy
aXZlciBjb25maWd1cmF0aW9uIHZpYSBlbnZpcm9ubWVudCB2YXJpYWJsZXMgYXMgYSBmYWxsYmFj
aw0KPiB3aGVuIGRldmFyZ3MgYXJlIG5vdCBwcm92aWRlZC4gQWZ0ZXIgcHJvY2Vzc2luZyBkZXZh
cmdzIChvciB3aGVuDQo+IGRldmFyZ3MgYXJlIGFic2VudCksIGNoZWNrIERSSVZFUl9TVFJJQ1Rf
T1JERVIgYW5kIERSSVZFUl9EVU1QX01PREUNCj4gZW52aXJvbm1lbnQgdmFyaWFibGVzIHRvIHNl
dCBlbl9sb29zZV9vcmRlcmVkIGFuZCBkcGFhMl9zZWNfZHBfZHVtcC4NCj4gDQo+IFRoaXMgbGV0
cyB1c2VycyBjb25maWd1cmUgdGhlIGRyaXZlciB3aXRob3V0IG1vZGlmeWluZyBFQUwgYXJndW1l
bnRzLA0KPiB1c2VmdWwgaW4gZW52aXJvbm1lbnRzIHdoZXJlIGNvbW1hbmQtbGluZSBhY2Nlc3Mg
aXMgcmVzdHJpY3RlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdhZ2FuZGVlcCBTaW5naCA8Zy5z
aW5naEBueHAuY29tPg0KPiAtLS0NClRoZXNlIGRldmFyZ3Mgd2l0aG91dCBwcm9wZXIgZG9jdW1l
bnRhdGlvbiBjYW5ub3QgYmUgYWNjZXB0ZWQuDQo=
