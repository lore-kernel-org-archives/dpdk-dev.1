Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFCC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDD6040A6B;
	Mon, 11 Aug 2025 12:39:36 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by mails.dpdk.org (Postfix) with ESMTP id BBCA4400D5;
 Mon, 11 Aug 2025 12:39:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVbidaterhQj3dCiGKJUJarRfkOPO5qF6NzK6vv9l8May0iGYHVm47VhjpjjwKXfBPIKM42Eg/ku14ZxA4fXYMYiIziFFGQhhA9HaLB2JM66I0Xa/sEkwkGo56l4/Yn020197hCAZ2chr9kpQ8vDVVW4TlSOqCpC3pH0ASY+lKRcBn8h8KC0b8yYHlYErpbCk3Ug2/ZrwZLEo+0Fl3UBW6RcMS+3un8FZWTJjEgc6w9o1rGU5FkI73Jcm8dkR2ww9Mwjwa60yexrsLI4uNMieB6OxzgGFFa9rXcTrplPQdqN7YmaXzktYRXJMjltHBHaaXMGf+i7X3BBW0x2BLQu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/3hRb3yFuZeFftt4rndmkVV2JL9orB06nL7QgpKzQQ=;
 b=Malng0FoAWt1lB6Bp/cQp+bOmaV2qHeSf0zG82SqnVdMsDPs7sLC2eWqdbV6nfMcae+f4v4RVU8eNi3kBJF8q3laaJzLH+CWq67VgGJWJHTk+wXTnzcO4gomwuO2rscD4X/JAWs1TWUPi3a+/bMPKMWCHlTpWZqbXYEkWRsra0LDD6ZJigLnWYDtzn4INhnvow4ogQdxLM5MSxoSIt5jQkZ6wayJ0UgEVdTw9GxjyQmZ8JGIGSi+MDHHqhuImyQc7xM668IV4fXQBFsHYnBnwXa6WNRlyjCVUv4P2y0eh4hl/JANrnxb2D2QcU3oavhNF+KEZEUggB8xi2PC9V22oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/3hRb3yFuZeFftt4rndmkVV2JL9orB06nL7QgpKzQQ=;
 b=zvoBdCwsbsQmeltBXjwfa3gWkkrnxjNwDgOicVxcxiP1FrQc0CCRWtBMF6HxmB+Pw+7vV2hKOZNFKfuDA07A24GW5OVYynzE2smA/S4KL94Rf1bpdHxwH8UGD7UpiH208tjKCusNRzgLuR5SCYiS7j502p2hqluD/WDOPeslY10=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:39:31 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 10:39:31 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Stephen Hemminger <stephen@networkplumber.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Topic: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Index: AQHb/WN0TIA+slWBmUK4+lP+hWGsxrRIFzMAgACFKoCAAQnyAIAAfnsAgA4OFcCAAMWJAIAEXvCAgAADIwCAAALkQA==
Date: Mon, 11 Aug 2025 10:39:31 +0000
Message-ID: <PH7PR12MB8596F0E1D1D0CD123F7A87BD8228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729143420.0fd7b627@hermes.local>
 <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808083204.0174ac6b@hermes.local>
 <PH7PR12MB8596785BCD76C0436A1F34898228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x75WVrD+x8wZeH7XNsemOZYcKMUBYB9GM-v--6AxVetmQ@mail.gmail.com>
In-Reply-To: <CA++2-x75WVrD+x8wZeH7XNsemOZYcKMUBYB9GM-v--6AxVetmQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T10:38:36.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DS0PR12MB9039:EE_
x-ms-office365-filtering-correlation-id: 7d603951-289d-482d-d420-08ddd8c35afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|7053199007|38070700018|8096899003;
x-microsoft-antispam-message-info: =?utf-8?B?d2UyMFZHbUwzSkhjYVNYKzhyZmNUajJjMlRIUGJBVGJjMW14RUxTMW5LbWMz?=
 =?utf-8?B?dzN5aS84VlhaT3E1Slo4TlY4dkZ1ekV4TFZHbVE3d2VGNms0RDEvM1A4emNr?=
 =?utf-8?B?WW1aWXUzbnY3eS90SVpHTjkxM3dWdG5HN3NNM21xbHdLRXVlNEtNVDRtbWY3?=
 =?utf-8?B?bC9tRXFIV0YwaVVzVG45RUV6QWtKOUpWYklNL3NndnNmazlmb0E5UVBTSXJ1?=
 =?utf-8?B?d25WZzV3QUthZVJBVXQ4K1RiR2ZpY0hJVWtRekp6WHZPeEhWNjFYQlVMZ2RW?=
 =?utf-8?B?Si9LZFREdndSS0UwZWh6YmhWaW4wV1RSMWJyWWZJVUdPcS8zMk5XcFd5Zm15?=
 =?utf-8?B?TWE2cWtXd0doK3VMQkZYYzIvTnRJejZQOHA4T2RmeWxlVytDVFhwS0trUTJX?=
 =?utf-8?B?R2VQSDRERU1YSVNaUWJTWGJKZlFkaHk4MVdXSjdMSnBXK3BKamo3TU85MzlU?=
 =?utf-8?B?RzQ4d21ZTmdNOEthb1B2NWRtcVRlZlpWaG9PYUhEaWdSa1J5NGdTVitOTnF3?=
 =?utf-8?B?d1lxK05HcHZ2VHF4Z2RXd2Jjd0FtQUNvQTMyQW1jSkEvRWpESHlWOEJVMTlI?=
 =?utf-8?B?QnhPRlluWk8wWVZOR1paZi81eUpqS0FlMWJRWkFieVZUYnZZakVXNGtXK3pW?=
 =?utf-8?B?MHd1dDNYSytWSW1ReitGSXU3Y2RyY2UzR3IzNTVENk4zdjFkcEt5dUVHTEND?=
 =?utf-8?B?NGV0Z3Rza2R0U2xmZjNBc2Z0RFgwazVaTldlRWg2WXgzWTF0ZjdGUTZaTmtQ?=
 =?utf-8?B?ZW9wSlZkcGNlMjAyYklMSDhYeDJGemd6K001eHBLZG85QS9ESlJ3RnhxYmtr?=
 =?utf-8?B?YlFtcndwNEZDMWduOXZWMXFaREVRcTlWVHFRMjdKQzlwcGVGTmNCdlAzZXZO?=
 =?utf-8?B?b1VSRUs1RDZwRGptM0krRm9rWkdwZUR6cG5Fd1lvbGJPZy93eDRDaVpXYjcx?=
 =?utf-8?B?cmpzcE8rVk5IczJYUERMc1lIbFV3UDVjb1B3NUdJWFNGaUpxQWRENFQzd2Zu?=
 =?utf-8?B?aEcydkFNeFFQZnI5djJxYXVtWXlCYUNTRzd3dmJFL3V5WXlySk9lNFBXNnRX?=
 =?utf-8?B?L3dlSGdJMFJPaHRSa3JLa1lMYjcydHNua2hKMm1nTWRIZkhTeXBRR2xWa2lM?=
 =?utf-8?B?R3hCVGxBUzNMeUppOHFCa0ZDRWdRZ3YrWEtYR2R5MjcrSUJDbXVCT2FJSG5N?=
 =?utf-8?B?VFloZFYrUWo0T0VOUGJZUDZuZDZHUzdjc2c2UkdKUjNUMDRodTJNMGhEcnpn?=
 =?utf-8?B?eDlzRyt4b2NzWWJEV3V5WWtwVDRYUDdCeVdtdjAvdVlodzg1SWsybEE0YXNO?=
 =?utf-8?B?TVg1YUFQS0ZPM1kwMStnbTV2TE1WajBrODRwVW5wYmlYNmFQSVRBWCt5VVM4?=
 =?utf-8?B?d2VaUUkrTXdCOXNBbnJGaUs2OUFKc09pSVVxOU16T015cTFpQkphZmNNZnlr?=
 =?utf-8?B?cldzOUNOUm1DQTZnZXJNQmNFeVlCSnZmcnVOUXFZRTA5QWxaOXhuWURzOE1Z?=
 =?utf-8?B?TUI4SENrOG1Cakl2NmVwa1U5NFRwSzlDQkpJbjhPRTVPUWVjNTd6UnFHTEli?=
 =?utf-8?B?SVNyMUZsa25GeE41YVJLajVPVHR6K0VmOEpoOXBCTEp6YkR5SExqWFpZMytN?=
 =?utf-8?B?aHZvTXBMTWVRUzJqTE1BNXhFQTVSTUd3NzRzNFZ0OCtQa2ZMMlgranVrWHgw?=
 =?utf-8?B?QVp0bXBLemtHN0xNaEszUFdHSHRML1dCdWFkcHZyRmpqS0g0Wnpjc2FKTU1B?=
 =?utf-8?B?NE1RcGI0RndQbDc0a012VUxBY2Yyb0NIRmwxRThJTnM4czVYZlZVV3lmRlZs?=
 =?utf-8?B?S3BxN0RhdkthSmNvN2VvWm0yNytsZXJUdTRCakxhVDcrc3dhV2Z6L1RVckZ4?=
 =?utf-8?B?emowM3FBdUhqL3JsWFFBNXRuVzl0bnQrMFhySUtzVERFRWVTQ2VDQVhoa0RM?=
 =?utf-8?Q?V800MxtJAGw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm8zVVYzVmdJVXRHY1dRS29nZndVWkRoTGFmenk3RVlLQm1BWFBqa0xYem9U?=
 =?utf-8?B?c21HU3VxRVFUVnoxUElqbThGSUkyMGl5Tm56YUZZOFVjSnVJdFhGSGo5dkZl?=
 =?utf-8?B?ZmlYNEpZUit6am9YQ0xnd2FxMnFsUkFPblowYVZpM21uT1c5MWFQVmkrY3lZ?=
 =?utf-8?B?RXJnbEtDVDg2RjhUd3UzdjZKMlJEQ2J0N3IydVlvRS9wczhVY0psRUE4WGhZ?=
 =?utf-8?B?bVFhSTBNNUJ3VUZZT2o2bmp5TDNmdFpVZDVoT3NhOG5nTmdRYW9iVXp5V3lR?=
 =?utf-8?B?UG81ekswTXU1ZkpYWWhJaUFpeFJ4TW03MHRmdUtuYitQbHJZZVpUWHB4dkVs?=
 =?utf-8?B?UHhnY3p6d002bTVpWWtqTFJTNFNNM2dpVnpvK2lhU3ViOGhIbHRtZmtaRnQ1?=
 =?utf-8?B?UHpqeDdIdVhONWpicEdtcFRvMENFeitPMzNmTXhKUGdqYkdxM1N5MmlUQzVz?=
 =?utf-8?B?NmZrN29MaG96WDBxeHJRTVNYZS9xbnJwaDIyemI1SEJGRjI2Vnc3OTEwd2I3?=
 =?utf-8?B?eEExckhPeW5odU41ODEwKzVkZmRPMmY0Q1V1TTFiWVV5RGo3STZUOWpKRUtn?=
 =?utf-8?B?eWpZM0JOemlUTjEwaGVGcmt3YTBCbHk4MDFvTXZ4eUpaN3ZoSEltNldJSVls?=
 =?utf-8?B?ZmpjU05SY3JyalZKOTZnRUJKUHl4bjJ3QTl4WWFxdVZmazgzdmllTXlBdERi?=
 =?utf-8?B?SUR5MVdOWjdUYUx1YktKMm1EZjF2ZjlWV3dtdmduTVlFSm9WMVdNQUovK0Rt?=
 =?utf-8?B?Qit2eXVGWnM1WSt1UUdINm5lbysrOER1NE44c0hpSG8wZEJwc3hwak1Camd0?=
 =?utf-8?B?U0JmZ1lYb1Y0cHF0djdPR3h5TkEyUk1aYnVrNEsrYWxES1F5NVBIWGlPdjNQ?=
 =?utf-8?B?MDBOMTk4YThvV3UzOFAvNExZSVVCOWYwc1RZNXVYQmxwOUxqS2hUeHJzWE1P?=
 =?utf-8?B?U0Q4VmxTb0txWEpnWVp6ZUZDbWFrT3NnVnE0MzI1QWdDTm81VUs0alc0Z3pa?=
 =?utf-8?B?MDhQa0lwT2xGNk82RVlwaEZvOWF2VGNrNkxZaTFBMktSWmI5OU5CaXk2L0Vx?=
 =?utf-8?B?cGZYRFFmS1IwaGJLdEJLVUNuYkt2NUc1TDRMdzFyaU9lS0ttbnlrdW9iRHlF?=
 =?utf-8?B?TktGOWlSV3NXdGZlMmVNN0FHekVWbmZ2RGU2YXNBV0tYY1V0Rm0vMEJtWHNV?=
 =?utf-8?B?dktDWitXc2tjK3R2cVQ4Vlg0ZG01QUF0SklSUXQ3Mm9UbURmQlpWdHJjT1FD?=
 =?utf-8?B?ZSs0SERlaDNkaUJhbzFMNkhYZWFkU2J5dkVCK1REYXhyWDhOK2JvNm5WSUor?=
 =?utf-8?B?OC9NMERES2lHdVB4Zm1BMCtHN05mZDA5dWVhbHhCMmRzSU05QzdUZ2pmS0Nj?=
 =?utf-8?B?dFRjRzRYTFhjeWRSMjNhaGs5alZoaXAyR3Ixend0eU5RbTI2YWFFdEhiUTg5?=
 =?utf-8?B?U29BK205Um4xZHlETmNUYkkxeDhKaUNqTEl3WC8yODVtRWpwbklRdTJrajZE?=
 =?utf-8?B?OEZhbXRkOElkNWJXSGc3NnJsa1c3TU1VUDIveHdMcWo3ci9qYWdpMm1wWkVk?=
 =?utf-8?B?Z1I2OTAzanZ1a1lIazJwUVZMdkdzQkhER2Jna2FUeTV0Nmt2cmxPN3V1YUhz?=
 =?utf-8?B?dGcyc3ZFNkswRi95ZEdoQU9VUXptTlRRcDB0T0FITm1pcjRESlkxTmhSMVRX?=
 =?utf-8?B?amFmemN2TE1iaHZqVHcraEpWajFoLzk2MmlQL3c2ZWdNcU9aZGNBb2YxaDNO?=
 =?utf-8?B?bFF0RGFMbGJ2ZE16MzhFckJzYUUwd3ZDV01GODNsSXIwcW5BWElwV1NUclVv?=
 =?utf-8?B?amdDSmxKSkRVRWtrc2xGQnptSHloa0lJRUU1M0ZKV1N2T3pyVDhBTTlnQkFz?=
 =?utf-8?B?cU9ycXZTeURSTnphUDZVSGtsRnE0ZmFtcUw2MXV0MDhIU1ZjOXJRMkdnRnFa?=
 =?utf-8?B?cmkzMC9CWStEcE9MUXNMUFRJbks3RXhGcmUwazg4dUxBUWhKUWhlSC9ZR1dy?=
 =?utf-8?B?VzV1TWtvZWpONmZwNDZBc2d1NHk4VGFOVDRrQWN0dGtGLzdCakdWRXRkSlFi?=
 =?utf-8?B?THEwUnRNMzlWTVZXN1ZjMnJhL3BKWERGVW9iTkxMM1NuMTZYZERZVlB6QlMw?=
 =?utf-8?Q?KN+M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB8596F0E1D1D0CD123F7A87BD8228APH7PR12MB8596namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d603951-289d-482d-d420-08ddd8c35afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:39:31.2952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBYU/oLMQGpMVJ48Q2KZR8G2lM+dXnqJdzbkr6Khx0+QCPGrAsqTg4/zWcckK6B0YOfNtYYMN1ZUoRQ3/M+YvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

--_000_PH7PR12MB8596F0E1D1D0CD123F7A87BD8228APH7PR12MB8596namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KU25pcHBlZA0KDQpIaSBWaXBpbiwNClRoZXNlIGNyYXNoZXMgYXJlIHNwZWNp
ZmljIHRvIHRoZSB0ZXN0cG1kIHByaW1hcnkgYW5kIHRlc3RwbWQgc2Vjb25kYXJ5IGFwcGxpY2F0
aW9uLg0KUGxlYXNlIGNoZWNrIGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsv
cGF0Y2gvMjAyNTA4MDQxMTMzMjIuNTM2NTAtMS0xNHB3Y3NlMTIyNEB1ZXRwZXNoYXdhci5lZHUu
cGsvDQpUaGUgZGV0YWlscyBhcmUgcHJvdmlkZWQgb3ZlciB0aGVyZS4NCg0KQXJlIHlvdSBLaWxs
aW5nIHRoZSBwcmltYXJ5IG9yIGNsb3NpbmcgaXQuIEJvdGggaGF2ZSBkaWZmZXJlbnQgZWZmZWN0
Lg0KUGxlYXNlIGNsYXJpZnkNCnNuaXBwZWQNCg==

--_000_PH7PR12MB8596F0E1D1D0CD123F7A87BD8228APH7PR12MB8596namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkFwdG9zO30NCi8qIFN0eWxlIERlZmluaXRpb25zICovDQpwLk1z
b05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNvTm9ybWFsDQoJe21hcmdpbjowaW47DQoJZm9u
dC1zaXplOjEyLjBwdDsNCglmb250LWZhbWlseToiQXB0b3MiLHNhbnMtc2VyaWY7fQ0KYTpsaW5r
LCBzcGFuLk1zb0h5cGVybGluaw0KCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7DQoJY29sb3I6Ymx1
ZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCnNwYW4uRW1haWxTdHlsZTE5DQoJe21z
by1zdHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5Ow0KCWZvbnQtZmFtaWx5OiJBcmlhbCIsc2Fucy1z
ZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10
eXBlOmV4cG9ydC1vbmx5Ow0KCWZvbnQtc2l6ZToxMC4wcHQ7DQoJbXNvLWxpZ2F0dXJlczpub25l
O30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXplOjguNWluIDExLjBpbjsNCgltYXJnaW46MS4w
aW4gMS4waW4gMS4waW4gMS4waW47fQ0KZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0
aW9uMTt9DQotLT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVkZWZh
dWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0iMTAyNiIgLz4NCjwveG1sPjwhW2VuZGlmXS0tPjwh
LS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPg0KPG86
aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEiIC8+DQo8L286c2hhcGVsYXlvdXQ+PC94bWw+PCFb
ZW5kaWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBsYW5nPSJFTi1VUyIgbGluaz0iYmx1ZSIgdmxpbms9
InB1cnBsZSIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIj4NCjxwIHN0eWxlPSJmb250LWZh
bWlseTpDYWxpYnJpO2ZvbnQtc2l6ZToxMHB0O2NvbG9yOiMwMDgwMDA7bWFyZ2luOjVwdDtmb250
LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7IiBh
bGlnbj0iTGVmdCI+DQpbUHVibGljXTxicj4NCjwvcD4NCjxicj4NCjxkaXY+DQo8ZGl2IGNsYXNz
PSJXb3JkU2VjdGlvbjEiPg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29s
aWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0Ij4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWYiPlNuaXBwZWQ8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4tYm90
dG9tOjEyLjBwdCI+SGkgVmlwaW4sJm5ic3A7PG86cD48L286cD48L3A+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+VGhlc2UgY3Jhc2hlcyBhcmUgc3BlY2lmaWMgdG8gdGhlIHRlc3RwbWQg
cHJpbWFyeSBhbmQgdGVzdHBtZCBzZWNvbmRhcnkmbmJzcDthcHBsaWNhdGlvbi4mbmJzcDs8bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlBsZWFzZSBj
aGVjayA8YSBocmVmPSJodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNo
LzIwMjUwODA0MTEzMzIyLjUzNjUwLTEtMTRwd2NzZTEyMjRAdWV0cGVzaGF3YXIuZWR1LnBrLyI+
DQpodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjUwODA0MTEz
MzIyLjUzNjUwLTEtMTRwd2NzZTEyMjRAdWV0cGVzaGF3YXIuZWR1LnBrLzwvYT48bzpwPjwvbzpw
PjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
bWFyZ2luLWJvdHRvbToxMi4wcHQiPlRoZSBkZXRhaWxzIGFyZSBwcm92aWRlZCBvdmVyIHRoZXJl
LiZuYnNwOzxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdp
bi1ib3R0b206MTIuMHB0Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7
LHNhbnMtc2VyaWYiPkFyZSB5b3UgS2lsbGluZyB0aGUgcHJpbWFyeSBvciBjbG9zaW5nIGl0LiBC
b3RoIGhhdmUgZGlmZmVyZW50IGVmZmVjdC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYi
PlBsZWFzZSBjbGFyaWZ5PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPnNu
aXBwZWQ8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9k
aXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_PH7PR12MB8596F0E1D1D0CD123F7A87BD8228APH7PR12MB8596namp_--
