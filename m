Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D70CA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 16:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EE3740268;
	Wed,  7 Oct 2026 18:28:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011060.outbound.protection.outlook.com
 [40.107.130.60]) by mails.dpdk.org (Postfix) with ESMTP id 4EED440265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 18:28:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh7mF22gAiONkHGGbsq61ix7TQOHgtcx+TptXlQOnlQs4g8eAX2sqiEMidRGFFLnjTy2brOxqH0J+TjUQSEd+MIm32eEVMIKPgpFURb4RC5Mm9bfP3B6sfFLVXPqVMxICu8qpVxPufPoEZsMZwg8w6p3tvzHf4XRE0GvX6z2kbidn5YPc83xL0vskSxyW2pWsSUtCXX25M9MRjEkm8bXJmZJCRaNq1gIPhrTMuChgAmSylAMpgrSuDZv/HIJUCNrJKT1kW0MqL7UruAZH8ngms105li9bOrZEOfkBqqh0D4pvCrZN0dH3vqv5hUUGW2D2RVonS/kKW0ijJohTaBUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ce+cnmyn1CGKRE28m599jaegvdyyC1Ny8pW1qizja0=;
 b=u36C1h6/di4akl22yqwvv4LFXlqc8J8ARNudEcgk0rUeJrdM0djf2QvPTJTBttk9QjjPL61VElzOvWSZGXlFFVY2gVvtlBFXGJOjHbpLukvFqyrs/0GlyIO6jWHnKmjooUa7jZcZeabZYcc8gfRNkQPHFrLa9UMGQRoNcjD0q0A5wBtQLe8rX7CPZMVFbrbU54hvpv8BCohcX+hPd6QF4s4bp/d01uXTFbldPhSbDbzS8gwPJ9jbSvtRS1g8ztsWBGBTXp+JgOe44YTGdBQ39HvkGErP/jO9rggMCHW7SPD+LlV4RWnkrZ3AQaFZM4MMLuv+9aMURGsVs4EoE1tNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ce+cnmyn1CGKRE28m599jaegvdyyC1Ny8pW1qizja0=;
 b=PaeVkDp501zVOfa6ggesTMOspXjNMu6Y2+oGcWTEHG3HtFPFLKkx8XXGVMqJk8KRq2NU3ZmWc8LoL6Qv1nulCWknYHEPS7iRxI1Tyw0LQox3sMA1APOxAgveG1Uo5nuNG+VqNNDEuaqaSIci709KPWeZexTIvYCqa8RlHp4+k/HFDNbu8F6B0QCov8g7qE3dItRok+8VK7gV3rxdKgUipeTLhx+79wHs7MqUZMmbRL4NNQ5DPEBpXNlw1joOA+/+1lqq2VEpasuyjqX+9/Ei4JXYuncEwC/wxVB1VcxYrxe38rpRzyPLBQYrMKVRTCPWyfuB26NxhyoxwuLKuAH9bw==
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by ZR6PR04MB296659.eurprd04.prod.outlook.com (2603:10a6:910:e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 16:28:55 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 16:28:55 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdVXTh7ITYopKKI0+Aj4AC2jVX0rbwnEuAgAEP0I+AAIl9AIAAEWH/
Date: Wed, 7 Oct 2026 16:28:54 +0000
Message-ID: <PA1PR04MB10770B9B7A3839B5F6EC7BA0F89942@PA1PR04MB10770.eurprd04.prod.outlook.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261006080145.33d89b9b@phoenix.local>
 <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <20261007082642.24b92b4d@phoenix.local>
In-Reply-To: <20261007082642.24b92b4d@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-07T16:27:22.845Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR04MB10770:EE_|ZR6PR04MB296659:EE_
x-ms-office365-filtering-correlation-id: dca349e7-9dc6-44fe-9149-08df249014ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: Lut0cp7It1EMJ6fqBV0XbnbvoMlyoPlZazinmlV6CUnqmWk59XupUE6ifWsq/Dq6EuMO0GDvdaL9ddYxsO1NheLMHdqciF9cgGklYBLW/tEujFdhXHntINBQ1nL2f31Z+rDCO1sXfGboKoE29l41YEJy4KVjUs2Ja8Mg3MpdtP+U0x/SVP7QgyXiOlvJHL9SS5cCs27XpC08Fq+BMoBwYI+wj3fE3vRS0iEbp15v5FFxc1kXNGfz1A6yZsumDEhzefM66lRyw792snB4e3yXahsoyrx9x2dPeeWm1v6StNPBKoBZJDMFQOdfHAomSCknWxo4xlLPUnent3PuIi1sNHLyBk/TqdfSo+yKEOhQ09TFlzjKOIxpgvDazdWQZH40/uHUwl2EE3KF2lMVnkw7DZd+j6OiiD5lnIsPAdK+kGKx2J/8IzmJgzqprvWlXo6Jns3HdANXfCwPxidJwKNfTriZ5s27/oFG1rHOX1tgCcs3XK98ey6WtJJC8MOT8621k50wqA+8Czfc9qzcvUWa3GFDJq3dII8Jcr4WY/ryy6Em7s6wvlpSBv+WUwkzKiEBi1yFk5TcjeVvJ6/U54hWBekaHP5DhzbbHlHTszCRYQRnHxwCL90ysx5GEsTH630fQ5VKmlz9ok7XP1G+tTjbvlGdy/BvAUZ5cRU/S6dGpjVhsLCGN2TZhGEJ58tZPYjk28HiLvLVazWkNLwrOwaZ49Qm4iFxC10E3kO9Lj4kt+g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2X7cnl4kEtV3ETe5j618Rzol2DaFkK8eCOM//vLWYWEVZ7H46kwL/dcEAZ?=
 =?iso-8859-1?Q?nkKXvT6DXQtqpK2ux/T8fx/GtalhRAPpoqR4ZFWQcE9NxuQuzS1dPCGUN8?=
 =?iso-8859-1?Q?GSlejm7hNj/cgXHvFJhXuvUYnUvYgu4LOtRQ1jcc+ufCnNEtqr3TENyhs4?=
 =?iso-8859-1?Q?PeQbqcSIyb5B4iUxTzdKPJGu4UCuTNfiKWXLVWlJJKj9PmHupRXMcD+AmN?=
 =?iso-8859-1?Q?xJFQUhMN5tnoK1qKEiLrfHwIWoI93asNlsEXt9duUBnaXqYEoekyos7Xfo?=
 =?iso-8859-1?Q?4iyX/ipdpfNEBhwlsR/Bcta46RbygZSFSbY5vIMPIgOKM02srjP4q6t0xr?=
 =?iso-8859-1?Q?cmtD8/LTHKgoPIpgdn52a73an+5hHejS5UNRrFnqy4Zz5KH6Z9KhGc4EOC?=
 =?iso-8859-1?Q?tXQwmkXmePHSXfymvSpzwZRoM9ImlKJopqVc8IB0HqeMQ0T0UC6JsOTe9b?=
 =?iso-8859-1?Q?sQ9Jto0yz2nrzTckKYIBQlBU3+Fr+vFTpup4ZgHRSSP7QtJgM1boia3jwR?=
 =?iso-8859-1?Q?EFxK5QWnHmnwolBRo+8nlwwiCsBD0SdfePQaiAkyz9ww7tx+hk8jP8EbjR?=
 =?iso-8859-1?Q?HhQpfYR9lGZK3loXuGT4mIUGrrF5NbXIbA9vRPdooKBU5VIxYyvnk0E2bN?=
 =?iso-8859-1?Q?yDGLErcDyDAcZUAVbJWeAyAXnPBaqnjcLHg6gJOCmSxgpwm4nfHblW18Pf?=
 =?iso-8859-1?Q?qVmOb3eM2ckFVSq07HC3wYUGeI7z/zkk843qAOPfsIJP8p68iMSm/x2T1N?=
 =?iso-8859-1?Q?1e+QrvcT3Qgc0QY+Cd8p01Tr1FpC1zQKY4JFOVkkuVapiARUhxSEXSwySe?=
 =?iso-8859-1?Q?OROxWd33UK8qO4XV3AInYMtmBe+hyo85hNbabgf4snoe9iykTfvitxPpJJ?=
 =?iso-8859-1?Q?rrXugi+BVulYiQmz0/r6pzXyk6F/jZ79KSDdGOeCSidNLS8aFhl0yXa7Bm?=
 =?iso-8859-1?Q?JQvDOCyK+jvqcR/TH5mPPXkDyYbLq9YH932/M+T6Jr8oUKD7OKex1QPucH?=
 =?iso-8859-1?Q?B76dxUOumHJFe3tLOIBRpsXsrWGM39YPa0Mf+rlEhteGPbrY6fkYnd3NBZ?=
 =?iso-8859-1?Q?fuiIpS2d/ACBeduySkMJEwk/Kj5NOjQnD8/asIm+zWnnANfySGL9Iaokk/?=
 =?iso-8859-1?Q?fsmoXFWyscA0/ja2AKyIoEYEuOMGtY7hc9Q2jzwv9Dc/7bwl+VMyEuBLxc?=
 =?iso-8859-1?Q?97lW198oN3MkYtQxxt2Ut9K5rELTme0r17BzjT1xPH3a9Pm1t0gQ12a9Th?=
 =?iso-8859-1?Q?frfQVlMA/u0HMiReW3tRQQEt99CcX0dG3TpMbEVx6bH+3ZhnPY5gJpMUEX?=
 =?iso-8859-1?Q?Qq+RvMxsRnZUEhII7yZZmMkMR2m8BhnKNGce4buYYJEw9XHVyYXaftiC7N?=
 =?iso-8859-1?Q?ibVAo1U8gRL2DfOQ81IdE4RXlfS4Ccj6b4hg6LObDG1WZrcMo48mT/azae?=
 =?iso-8859-1?Q?palNVzxV2/NM/OyaxGtcuXP9DibKz8XgwHM0K1YbAC1gsgZ6d3zyi7E5zl?=
 =?iso-8859-1?Q?+/2UZGIaGkMe2slt4ueUCUV3LadCoaJDLGexWB/Up+nr3UYIciwmaCDa1r?=
 =?iso-8859-1?Q?eTafETP21i5S6WN4QaUL6KWx42Gy2rURSyl5z+fDgtJwwS4s3yK4Nq8Tw/?=
 =?iso-8859-1?Q?gOjML36oZqmhmEXBvhP2BDLEkb0yn+vfpY8gF+vwr0OI5MvbVry8vBYn2h?=
 =?iso-8859-1?Q?UVFlsmljwdy6lPVgEeOlagUSctGSK1BkTy5CsmalKXyI9KIyvouSVunoaE?=
 =?iso-8859-1?Q?21IC6BhNHeFInjz+jL1K/iNiOxEsKD5+/y6T5WFKvSNc/Y2GAULn17rSww?=
 =?iso-8859-1?Q?h4PNFFSF4w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca349e7-9dc6-44fe-9149-08df249014ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 16:28:54.9487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kBZ1y3QOiHwdI2uhNie2CSh9/oQOcrdkbPDj2jVvfWL+2AEsHrTw5d6J45fg2jaB7PBcUD5Z8Kre+sM//G48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB296659
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

=0A=
=0A=
On 07-10-2026 20:56, Stephen Hemminger wrote:=0A=
> On Wed, 7 Oct 2026 07:24:37 +0000=0A=
> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
> =0A=
>> On 06-10-2026 20:31, Stephen Hemminger wrote:=0A=
>>> On Tue,  6 Oct 2026 14:56:36 +0530=0A=
>>> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
>>>    =0A=
>>>> This series collects a set of fixes and enhancements for the NXP DPAA=
=0A=
>>>> bus, mempool, dma, crypto and net drivers targeting 26.11.=0A=
>>>>=0A=
>>>> It includes memory-leak and resource-cleanup fixes on the device=0A=
>>>> remove/close paths, more robust frame queue and congestion-group=0A=
>>>> shutdown, secondary-process safety guards, BPID and cgrid lifecycle=0A=
>>>> handling, and several new features: offline (O/H) port device support,=
=0A=
>>>> enhanced virtual storage profile (VSP) port support, fmcless Rx queue=
=0A=
>>>> configuration via devargs, Rx/Tx taildrop threshold devargs, non=0A=
>>>> fmX-macY shared Ethernet naming, and DMA scatter-gather and=0A=
>>>> errata-workaround devargs. Documentation and release notes are updated=
=0A=
>>>> accordingly.=0A=
>>>>=0A=
>>>> v21:=0A=
>>=0A=
>> It is becoming a never ending cycles.  Every time we fix, it finds new i=
ssues. Can we put a limit to accept it with no errors and minimal warnings?=
=0A=
>> I am anyway fixing the following and sending v22.=0A=
> =0A=
> I won't accept patches with errors or warnings, sorry.=0A=
> You can run the same reviews locally.=0A=
> =0A=
=0A=
Ok. I respect that.  Please check V22. If there are still warnings. =0A=
Will you please let me know what all you are running for review. I will try=
 the same locally. =0A=
=0A=
> The other recommendation would be to send smaller shorter series, if you =
wait=0A=
> for a whole set of patches there is almost certainly going to be somethin=
g.=
