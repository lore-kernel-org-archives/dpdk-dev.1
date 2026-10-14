Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9390CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED45640279;
	Wed, 14 Oct 2026 10:06:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 88DDD40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:41:02 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E56iMc3278744; Wed, 14 Oct 2026 00:41:01 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022079.outbound.protection.outlook.com [52.101.43.79])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h9r9xkn7k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 00:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UltxDqCgtoJHqMVdkM8bRnbNO7Za/z2UqQFQU8+Rylwg6Fso8bLt/7MlQvt1srfZnwUDxx1zlnBHmdgVdrvuGfpwiA4Kewaq/2crUG0iqFLKEBoP2hAt/HF88piSuAAZtEH91VVyEf5/lUEJDeAxNQBWNOrOBRnHiQXpxIzECibjbBsZvtioYsnFeGIbmgVS5aud46Dp31mkxtMXnxr194GLU2nhfHz0Gv/Qat7lynDjOKfHJMcLXzr5Z3k7ckFhty9t12uL5ss7ZUUlitH8/7LJZ+O3GeGrsLJaJwsNcT9ZsLnU52sRlRz/v9c1BnQN4nm3yHQxf/Bur9fMUSVknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpNlM0CBgJG4k2u0HRUAPBOIJoFZN7NDmInVKAjl0ck=;
 b=YlEcMq6fidjqKKesYsljfF1qlu7rVR8n2Kjf3DCZmnCMTkfqI1D4SVsIL5ICVLt3CeTYq+Pl2QjhKDH+aNpUMxk5PBIfCDCDwMIYMIBARq99xDL77qpn76Wxet6FZzQ8slOC8wTLFC2HKiTebHmm28tamy7Oe8vXax6sUqDi4k1XQ06FBdamWY+fpzhNrsXY91FbFfWPBLCGpJU/ciy63NwqrywLpX4pO77IBk+/p8adpmx8NdN+voHVfFtlGXPeXJN5ZxUPFiH6/X9gKRGUeL5aXV5licN6JWclF/XFhzm7uQ2BVaULpk3lFwMYBqWAvvOIuuC8WELZbwE5N3GNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpNlM0CBgJG4k2u0HRUAPBOIJoFZN7NDmInVKAjl0ck=;
 b=jkTyklOfEzmPUnG4FGnrNor1VvgfW2th8hrcc0/QKmbFFh2EfVj6YDKhGO38Mu3sK0CBLYkfKUzWf6l2TVWAf7mcpToKLoBPm1YHVPURWPYwpg2E2bx1NiiNA9PITOAFo3+mywYhVLLxON5okalOLKUFs85QMO5wNWk4SbrxNxk=
Received: from LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 by PH8PR18MB5335.namprd18.prod.outlook.com (2603:10b6:510:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:40:58 +0000
Received: from LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2]) by LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:40:58 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: Re: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Topic: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Index: AQHdV+D33rDuqD9F1kOHV+JXOBdZjLb1WK8LgAdPF+U=
Date: Wed, 14 Oct 2026 07:40:58 +0000
Message-ID: <LV8PR18MB60785664769C41BA6F7080BDBD9D2@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
 <20261009112543.1766727-2-psenapati@marvell.com>
 <LV2PR11MB604545E17B9928A3A4758C2A81922@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB604545E17B9928A3A4758C2A81922@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB6078:EE_|PH8PR18MB5335:EE_
x-ms-office365-filtering-correlation-id: 5976cd99-535d-490c-520e-08df29c67cd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: AGMpp+9PjjetwELrebBW72Xq9xnAS48XjaX6lrcz4wTsn4ZEB0+P8HjDwO1HTRlckR3LMdCOdExF/voJOVgwg8WG+R8kFkRRErVN4+PnU62LRpS4JDn8uLJ26kzwsrs72dGj+LZk7dq1tPgp3Dw0yyNvXtXKEgMIub6pLOxLrjAfOb/8fNMpivbKN63DNQsO0yJvv39rIw1Vovb0Y3BXKB2I87Ci2FElpVYYJ/3GCbg0rz/NWzjwMr4lWthBBzaVFVtn0nrV/EZatjLRaIcxW8AKettPCV3b2AiV5TbCyU0+lJne4U1edlwoM9OegrYaml8hLxxpn7FpMuEKJAx9KYrrAc5gynav4vRN8Of9RlZBqu2xijAmJmQ5vGFQ800fds9EWDKFyH3GZCM/PPAfBEkip8PSNt+C32adz2gjLfGDs6YOOUYWp6BTIzZeLe3Q8Py5mw0Njp1fuaxvP/pljkyhT6MrjB3pvCPK3CIfn+0BPMucsTict7aFrcu0CBWf5xpP/lnR4cfKKVCZ/hm5FbULc3azXHbVX+h+zQRA7CjZV7BWK+Ci0hSaDyMhyhIv2J/EzxTRW1OK4Li0kBc87JyzttoVTvvHMsMLy53wyC4LkzQe+RXzMh5ucRtOBG9rUU4jr5OoZDT6vDQkSo/WpvVttjpDtT8BtpTacj/n2HywHt/7Gnb5jiIMadLuxkeysMqA/T08BYtnKPitgjVIA/6ScRPxR0ulV8sgv26fw7I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR18MB6078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rry/dT3XOzd0cv6Mb8ReOVfs8fvuMi5Q192sWaaDYLBimM6L+fnch0EzDL?=
 =?iso-8859-1?Q?XMCnjgSn/dK66xy27QcSy2ZjOZ7LS9QxuvtJrfaur0TbbZuk3adwK160PL?=
 =?iso-8859-1?Q?ieyvhczudY0hVzqbLBzkiBxH4JAByowywsLL4O7YQ3SifufsqZzg2f27zL?=
 =?iso-8859-1?Q?7wTvTe77hvnPpEO7A2Y6neM880FBY06Cy9i1Hsz44NvYbSGrM3paWoLUp2?=
 =?iso-8859-1?Q?TJNr5e7euYrmxAtdDgVwdQ+n8dA3buN58SAJp0rRpfJV2xSxU505PV7af8?=
 =?iso-8859-1?Q?8mqzk2MO3x3kjN7xIyK8/eZ5KMAZTNsVsVgM/6/iBkX5FnmNY5ate0nsCG?=
 =?iso-8859-1?Q?BT66mf1/ECsLTCg/H2fYUTHxf2e7Ub0TZ9mkABRkim6nslPLfnYgR77ESy?=
 =?iso-8859-1?Q?Ze6D0tA2zq+HhtiacfbAOnKOVUFMr+VuGW+Tu03U3qNkqa7fk+MSLA4Ywm?=
 =?iso-8859-1?Q?yeq+QlL19/x55fFjdNwmXnmXMXg5tTI0zuHBVHNGeTz48h/MRFG5Qshg1r?=
 =?iso-8859-1?Q?7YeBHseH8/VyrFBeDfHZLw2siZ61B0TS4ScxvE2xnZ9m+47Xvx2ZhNFCJG?=
 =?iso-8859-1?Q?aSsiZvUqetW4gMqzrIWf823OfppLww9a7tV6jcF/VtTkxSNZ7tnsE6KztG?=
 =?iso-8859-1?Q?VPAnotqa7jx6k7+nzlae0TCSqmd/o/qMSvskjd7c79cHadCMEqos0VscgH?=
 =?iso-8859-1?Q?AFKh+DnpO1PCNZMR9Iy80nwnhu+MfZbXfehRb2/6ly8VX6fEaSrgdScA5o?=
 =?iso-8859-1?Q?in4a+S6vU0q3vKD1kD9P4/580xiE+hYQNhYKKoRayrfAr7eDBD+RGje3xx?=
 =?iso-8859-1?Q?K+GQiVWxoZgjK9iGwvwseGJ3ITlZXqMS2cbb+Bzu17yo5MNrVPQp1xzYWM?=
 =?iso-8859-1?Q?oMm/Mz8TeR90s6WYgHKsiak7iukQHc+YsnlsbF9A4MOssWM7D0d5GFqYXj?=
 =?iso-8859-1?Q?1GI/jBl4EWbvpQ0uQJDSiG0qsvYs8fFMUPQ95r0REDIYpgXBQRXfUVhO3b?=
 =?iso-8859-1?Q?ZtPdbZ7CxgLyGOKd8B5vROcYHv2uzeBBtWHvTdlghDzyJAzeHlr8rY2yy1?=
 =?iso-8859-1?Q?BSdHNCu67FSmXR0K4RrX6M2MxjXI9x4pAuL0RwVSZ775xW+cPQ7w53OtvO?=
 =?iso-8859-1?Q?/grmycLNzgaIbbQwvXNCb8DGSLiz8dx62hJtoCO2vnmT0lcVAUvEDXu+t/?=
 =?iso-8859-1?Q?8W0ifxoWhuxPWXzBC/skeUavEe0MVQSsuIkBuArYamoEV/V1iRfBfFth9Z?=
 =?iso-8859-1?Q?5q/zqQkD+aNIyJv+junwnyE0TUKc8qe6fOgBtjQlz2fziX8erOpuMo5V2V?=
 =?iso-8859-1?Q?XvJ1HEMDWUOr8g74G3z7KB5xCTVroF531NhQH25H6gRS9VMUD6mTIYT3yo?=
 =?iso-8859-1?Q?IO8D5TfjPxLyTU6rGs1nBXaF6NCKWM+P7sgWEJIfVXC038UEw8A9eiwEAg?=
 =?iso-8859-1?Q?cAMjbCZEDukUxVX60eT2KIvsFSXLCLFaI9NX0lzWbInLlev4J7vrIfn3SE?=
 =?iso-8859-1?Q?503/vDbQCIz/Z+r54qDeJE9+Y62Iu0cjmz0R+imC3SA8lZZaPDiNvwHLCk?=
 =?iso-8859-1?Q?8qUW10DH6eD85aL9k73uazhetvxsgnt6nSaQVrB88tQJh8ftDN2CAnk+UV?=
 =?iso-8859-1?Q?V41yXPJQRTKzofqX84elvLzCKMv94EQyOpNh7AhbgIeQhBK1oxtkhb/ViK?=
 =?iso-8859-1?Q?zi/PX9KFkv4QWhalZh6k7NHeel928Oe0D4aPLIDLgFpawGRMol7djpR/t+?=
 =?iso-8859-1?Q?M9/Nc/VArgnRndFjMeHGyKmkPI3sdClqtgo7b+lICZfs5M?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5Jsoa8wA5C5LHqfXd9ET8igsN6Ags/4tG7tUcVuUnV9PJFcOZFQ2I2peFTJefUXvcImL52yR6bktr8XP8ijSG3IBmJDctafiuY1WxZZWalzCxh3+4iLh+/Jm8GlCiqqfd8+k+oVmONmKgNqmbUjEdgB+UZZAwpKtKwb1xT8bsTBzmUr21NluEdnFZT9MVjSjVBEJ5KL+w09rgRuxiFKNg/zLfzwCRwnr4iVUnEEHvMfyEQZjpChnfiT2n7NOUDolzl3s5p+so+ztfKDA8YXCUfNwIVsK21uJtDw0lCZvEHPJd2gSqIzrMxejTsnBQzFGXuvpXwtvHspBw1LCy/9b2g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB6078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976cd99-535d-490c-520e-08df29c67cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:40:58.3949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwpwzkKj4kGBmIUc0i87LXM6SIX5F9EL2qyCgp6ZeJhceijHin+ebROSem4Kp/Qpv9VaUqAgzctQ/CmFor14nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5335
X-Authority-Analysis: v=2.4 cv=DvDDa2/+ c=1 sm=1 tr=0 ts=6acf320d cx=c_pps
 a=floMify7oDVZ59GUGiBMBA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=77XOSPeotPUk_shIfAYA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: dtJoN-HvGQ46kcK4Ak_yeJ0Yc36iSGzr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfXyb3RI5tcaTwP
 4spiuYhzzSCugC3/QzynotSbE8TrOZsSA/nNzA+4bV+U6vfSELBicc/rKJvpJyjYTWOd2ytdo4T
 iZIC78Q8mMurTAALgZ9UJ8szoW/OJU/KKQ0BLG+4rRL5UKjMXIO/lGgvFLrwFRzx7wUpPnefMIn
 q8JQ6vnR/jSdIR2LIqaBySXLs6ZKuLs6IaI1EQsStcv5lRhF77Vym6kT7b4xA4Iof4D2muJTdyP
 JsU7oIsb5rOy5tL92BhZp0qTNbGbeFL8yeiQMzDjXivb+7c/LxgyWUBYJEBnzFjZJG9P9xgfGlr
 tVRiq5TCDes48kfyAs0yLFnf95eb6vxdHPmtowgALonbQqvhtS+2cYfJTroX+dqn1Qdb8z+D0EX
 hl7PHFWWjIVacqDMmxx1a3vJB+eVe0fJco/xWuzHdhMudxGF1Y9l9DbeB9SvUHvsCBX+cXkixYd
 rMWSE/IVaXPJSrsLPpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfX33OxrfNbrUi1
 WJw6RuxgsSX2hEGGQGSFPwZt4sRSY2QXTogi6kL2Qw6/0z6F606SYW9EM5svhWKvLH+zHy4oi0Z
 M0JAORchYSeE/wFCYwEcEACPXah9hYE=
X-Proofpoint-GUID: dtJoN-HvGQ46kcK4Ak_yeJ0Yc36iSGzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Mailman-Approved-At: Wed, 14 Oct 2026 10:06:50 +0200
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

> /** Configure device */=0A=
>static int=0A=
> openssl_pmd_config(__rte_unused struct rte_cryptodev *dev,=0A=
>@@ -1014,7 +1038,10 @@ openssl_pmd_info_get(struct rte_cryptodev *dev,=0A=
>         if (dev_info !=3D NULL) {=0A=
>                 dev_info->driver_id =3D dev->driver_id;=0A=
>                 dev_info->feature_flags =3D dev->feature_flags;=0A=
>-               dev_info->capabilities =3D openssl_pmd_capabilities;=0A=
>+               if (openssl_pmd_caps_active[0].op =3D=3D RTE_CRYPTO_OP_TYP=
E_UNDEFINED)=0A=
>+                       dev_info->capabilities =3D openssl_pmd_capabilitie=
s;=0A=
>=0A=
>It seems  fallback also advertises DES even when DES is unavailable, which=
 defeats the filtering during that >window. Would it be better fix to initi=
alize the filtered list before the device can be queried; then this fallbac=
k >should not be needed.=0A=
>=0A=
>+               else=0A=
>+                       dev_info->capabilities =3D openssl_pmd_caps_active=
;=0A=
>                 dev_info->max_nb_queue_pairs =3D internals->max_nb_qpairs=
;=0A=
>                 /* No limit of number of sessions */=0A=
>                 dev_info->sym.max_nb_sessions =3D 0;=0A=
>--=0A=
>2.43.0=0A=
=0A=
Hi Kai,=0A=
=0A=
You're right, there's an issue where 3-DES is advertised and it causes a se=
ssion-failure. This is due to the fact that 3-DES (sessionless) in the 8-By=
te key mode routes via DES, unlike the 16/24 byte key-mode. =0A=
=0A=
When the legacy provider is missing, 3-DES is still marked as available and=
 when a session is attempted a failure occurs. =0A=
=0A=
I will be sending a v2 that fixes this by making a change in the sessionles=
s path. =0A=
=0A=
Also, after testing, I noticed that based on the logic implemented, only th=
e active list is used, and hence I will be altering the logic to only use t=
he active list, removing the need to check whether we need to use the regul=
ar or filtered list; this change will be included in the v2 patch-series.=
=0A=
=0A=
Thanks,=0A=
=0A=
Pratik Senapati=
