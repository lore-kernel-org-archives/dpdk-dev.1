Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DC606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GA8/TaLn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E35B40262;
	Mon, 23 Nov 2026 09:14:56 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by mails.dpdk.org (Postfix) with ESMTPS id 52B9C400D5
 for <dev@dpdk.org>; Mon, 23 Nov 2026 09:14:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7OAkntjDYOYPulJS5KW09p7c8jooki34BPbLZbdo3/AqoFrdbdn+gxoGff05wdIjwnE/9xJsRmS2PhywtKYAdDPftPkp4Ci0+3jZG6R3o/i1avUljskJjkD7mWB6pk2vH/uSE8N7/y5kQa0YYsF7AM/KcmK5r0LDSVS6eXWldQsMVUeZmCoi9jCOH4ncmEEiyUl+z7KKClh+K9xioT2fTK8yxNEpf8+ECKZfZ2xC15Z9y1cNj88Eltoc+mhO7Dzp2jlx08SXHk+R6H+UimdDWXiimiPmWOFoF+XbPm55hFa8mmdKt4EnCwKY1pTsvV4WSS8PJe1vVMmM4Zk8rlmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4IYdfrgwQRCmALHKTougdBeBVOE40WV3OzM5E8danE=;
 b=yiVHJp8xWffu6aPITC7xIA3rrJnofMWfRGZudhmzH+Tv4SISDXaEElNMI9zBS8Z1foZDGftoY4V+dkW7hfnfmsqNfqLOacD2VuNrabbs67EwDO2tVPPM/k3yWA1fLIX2dBmSsrPoWh4CvBB580vtcP0UWW8QM8uKWecCn+0EzbJ+9o7jIMtbI3JpI0Z6CzKkvIov957xyRwNHiNXja7NFfRiYhnQILjqbv0UrQzFEGHMS8tuxHmrlnOYaIBqwj5LKyUkdjpOxXqYcbi5NUYuNUmwQqAWNGiisJqz7G5MxUPXdGLqybEyXk4aRCR6EsxExWjgYq0qO0UzDmSjAOvt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4IYdfrgwQRCmALHKTougdBeBVOE40WV3OzM5E8danE=;
 b=GA8/TaLn27zhG3Gn8NGVr5PuK9Il1/k+qdPZryjYnGpAaOZ/Avv7UOohtPRDu5bWE52OYOrneevkUznSueHISZrE23ulT+yZkXebe3Tg1UFKURJj9Zf1DMIZe57nsqJ/VG+bWRqNay8K7UrWbmnfp19Rk8XBrsZayK4UdBIW77xF43DaH2CwLrZS/K3Q3JLrbyLr+xz7YVwA+wcYIx4NgTPEkQoqoqB6o6irvZAAe7xY3F8zPNXBvwrcF2Dud81qjSshBQJl1gfrqQ1SX51MQg/oigAC0JuTzBukd4qm+Z0DtLIlumtrwqbnGAG19xaxPfGGkY3sy03e5PQMDU0h4Q==
Received: from CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:14:50 +0000
Received: from CY8PR12MB8213.namprd12.prod.outlook.com
 ([fe80::fd94:2b57:9d34:eb51]) by CY8PR12MB8213.namprd12.prod.outlook.com
 ([fe80::fd94:2b57:9d34:eb51%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:14:50 +0000
From: Wael Abualrub <waela@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Ali
 Alnubani <alialnu@nvidia.com>
Subject: Re: DPDK release candidate 26.11-rc4
Thread-Topic: DPDK release candidate 26.11-rc4
Thread-Index: AQHdePH/Avm4dhno9U2upc793waFFbc7To8e
Date: Mon, 23 Nov 2026 08:14:50 +0000
Message-ID: <CY8PR12MB8213B55B3AF586FB5389568CD6452@CY8PR12MB8213.namprd12.prod.outlook.com>
References: <cku3Z3NASyqANwzCcnMu7g@monjalon.net>
In-Reply-To: <cku3Z3NASyqANwzCcnMu7g@monjalon.net>
Accept-Language: en-US, ar-SA
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8213:EE_|DM4PR12MB7648:EE_
x-ms-office365-filtering-correlation-id: 2665f746-334f-4ae6-3688-08df4939d89d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261021121427099003|38070700021|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|13003099007|8096899003;
x-microsoft-antispam-message-info: aSHnY4cpNFaCfSG00yDVAuik08zMVfpEwM7gLsNL5gFbxIj4ryEDK6rgo8gvPQ1iPR70U2IKywH1UIbEfjkap4ToJDRJZKgJZSlYH7OYWTVifyxJxRtOywo5KMWJxqYjvWdOK2S6C6clSX9/QedIygT0T1jRq5Ge6ZfwoyU3Oq72/5nSzbmljxBt33BjgUlhKFLr0RC1iq+b7kmt7XRjdWZgqFvH4753jQ6rkAqW+X1z+A+FIEcxlNv7AoipGUx/3tQzFw7U0gWd4w6rIA3vJvXPWO8VUbN5iWVM5jgkuK+3WZupgD9zaFyf0vsSdo9TpZhIIxVRe5nA2IRHk9uyMkAB69aSmkkoJ9T3MLgpRAxnoLT3o3hBe8rEsSTuuU1Ok5/1F6jNAIImgMxpObv2wkRrFjRWCjPfr6kvPNEOUMNAsd8s9ioBK8OxlgDGQdM5f5MRbbWLmzTzkTcul5IdWLX2WQI5gPtx473uG7PdRJRHtM2y5+a16qPslGJQ0pXCEV7IJYo/lFVxa1189hXzpGHEHT3y2JeGUuzze3nomHs4vKoiDRCXcrtk1W6RF5wSuAMW5Pz5DeOaxT+mYOvmIml34zpgIaTxYL/uCkWxIPSIvCoF11GE3/fv+BjW9C3XX38CuaznKQpXSK+8+YFhOJaeCbKip8aHUXHesBX9aCIXfUu4lgqduT9quDzmmmgiUYL2rikYeap2RSPxBYJSjZOp6npm7LOu/K23zbUoR3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261021121427099003)(38070700021)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Z7XoO2BD0BEhqJpZgcRE7k8gchQu9peM1RTHP0kJ6Ot6oejm6cmXCoQW?=
 =?Windows-1252?Q?gIVte9qdNeuCNyOKfjchXz93rebo4d9/6raOuAlR2BBJ5U5qDMBklrl5?=
 =?Windows-1252?Q?HVGN9SoSTayeH88mNgHhPzfBcoar0E6GlCJ/G97qoeZ1+uXDwqXOE6+e?=
 =?Windows-1252?Q?B/GeehZHiZa51IylVldpsJlKwDA20miPmSsEwmV2fb9EAwPXKq21ViPe?=
 =?Windows-1252?Q?3At83hGHOWY52hEllVwoMsLgdSbnqg+lqokOyu/ycYyUaVoGxU8BFMCJ?=
 =?Windows-1252?Q?vcqU/pY+gGfVmuE+8Y58y5/vOU3gDTSfdYwrw7X2ZdUIfICHSuaIr/Jm?=
 =?Windows-1252?Q?IvVuMVKOWj0E7BoJrAHE4asMsZ8INenpput4YC14MBAUwrlD9WDFJFLg?=
 =?Windows-1252?Q?GdiKx+xczWF6B5r0EW3IifcOrkUJNVKAILbAtjfuNPhss83wNFDk5Ty9?=
 =?Windows-1252?Q?qCCqc0ebt+vvkG7wmuhatC9qLrw7gzPdE9scugCVJ5qswlKEIezQNO2e?=
 =?Windows-1252?Q?zsGcWTyDCRDZuFVEp4MRerKFa2LA9eeA+VToiom9cp5TtZoJyOPCYpY4?=
 =?Windows-1252?Q?VIlDC8uy37R1EKxVrdOwCC43uGHtLThoLigdNrYDPZugZwJPwjUphJcf?=
 =?Windows-1252?Q?lOxGvB0Gn8qfr1QBYjRPRNr69uCYbnpKAhtQxXgXVAOPO7yU/I4h2HLu?=
 =?Windows-1252?Q?R6K7PqW8D0I+nGeWvaRkCGFVeYGbXRjiyiLK0ny3FK+ayWN1kS2MDhWX?=
 =?Windows-1252?Q?MD3uxWEV3kO4+JfcAFcrIRupeFiu85/ULKGO/E6RmiEljfLRszRyEqMN?=
 =?Windows-1252?Q?NFjeqe127jI8AUnHbuNFY8opNi+hhjRWDrQnCYTg6EMijlUjcvWEKNDb?=
 =?Windows-1252?Q?7Q7yij2RkYUbqgxvFvMXChrLC7aUPEkY0uVp54e6d+7LtO2kCMmPG98l?=
 =?Windows-1252?Q?OMnZQgeXZp0qkIQqm3dlxi/JLV8iczaIhhXamwCwdMTbYucFlt46bKyu?=
 =?Windows-1252?Q?wVVV10EMY2fEA8q+gjRMTL3sCD4fcc6A7l/cDyC5VM2bOXT5VEi6bVaQ?=
 =?Windows-1252?Q?4a1LE/uxjtyUppShBAUJHClytSwp3t1kQ9KaSie3EYlw7OC2RUtbGGYE?=
 =?Windows-1252?Q?uu+Q1Vbo3HQlo+r0Dmpgsh1ukbEyARAuQuLWvRqIRKRxFUMgBlXP3OoF?=
 =?Windows-1252?Q?ZNNnUMpf8qlxV/UoCHA9LOOMA7sc7jw3NBL33NwcwqxitHaHkj1syqE0?=
 =?Windows-1252?Q?QSFTzI2ClTnMLuwR3Z2Vqo6L3KzfGcxPGC6P3N9TOJyYftm9bX6EM+VE?=
 =?Windows-1252?Q?x/ycUB04onaZWR3rhdKL0AmSWQPITZjIsmaYQ+kGfxTXuzorXTm75rE/?=
 =?Windows-1252?Q?i8wYRch0rJOGx6YvXsG0dQ5y1Ue9jBh/0aiggLxcdyR4aPAz+izyKuDW?=
 =?Windows-1252?Q?NIugXG5lR3XBKSAuEUpsvpY/Prod83is9v/PiNOx5hxoEfmxBikeNBgU?=
 =?Windows-1252?Q?tEtO6ybmzpzeWaIVIo0D0qDjLQ3/XotMunt4HtmObBnpcHcn5OkFcc6y?=
 =?Windows-1252?Q?/udYsICAovl+nEjcwsrnrk7+E7g7wvY0q3zCjQWx1k7tMzSAdBpPkDE+?=
 =?Windows-1252?Q?shzDcNHnw8HhqGN1D3oZw+6y+EjLaLYSl2BXbeOdZn1Ql2AnpDth+g+2?=
 =?Windows-1252?Q?LJIxmEyPFZIGXv4taC46Aox7BaklZ7Pqeyl016zE4Ki8BxIGU8onIeil?=
 =?Windows-1252?Q?8qdqA/wCLNKj8Z/F9UggAshM8ghXkU/N/+zu7XrQH+hwPx/nhshrGJbZ?=
 =?Windows-1252?Q?WaPeFlREroWso4Ojnsvk13+Xe6X+WUWsTFzF+DmWbhANYoxpeeAR9rsa?=
 =?Windows-1252?Q?Dz0Gwg+xEfLucg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB8213B55B3AF586FB5389568CD6452CY8PR12MB8213namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2665f746-334f-4ae6-3688-08df4939d89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 08:14:50.5465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/BCX0wrKD5p8hGaqCn1M/MgyoNW5qMTPKYcW9cOdzPTucUa0hrtjxpmooo3R6iwM4lkmD7MoBkJVyLAlSKv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_CY8PR12MB8213B55B3AF586FB5389568CD6452CY8PR12MB8213namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello everyone,


> -----Original Message=97=97
> From: Thomas Monjalon thomas@monjalon.net
> Sent: Friday, 20 November 2026 at 15:21
> To: announce@dpdk.org announce@dpdk.org
> Subject: DPDK release candidate 26.11-rc4

> A new DPDK release candidate is ready for testing:
> https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc4

> There are 44 new patches in this snapshot.

> Release notes:
> https://doc.dpdk.org/guides/rel_notes/release_26_11.html

> Please test and report issues on bugs.dpdk.org.

> You may share some release validation results
> by replying to this message at dev@dpdk.org
> and by adding tested hardware in the release notes.

> We'll close the 26.11 release cycle
> once we have received enough positive validation results.

> Thank you everyone


The following is a list of tests that we ran on NVIDIA hardware this releas=
e:


Note: all tests are passed, and no critical issues were found.


- Basic functionality:

   Send and receive multiple types of traffic.

- testpmd xstats counter test.

- testpmd timestamp test.

- Changing/checking link status through testpmd.

- RTE flow tests:

        https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offlo=
ads

- RSS testing.

- VLAN filtering, stripping and insertion tests.

- Checksum and TSO tests.

- ptype reporting.

- link status interrupt using the example application link_status_interrupt=
 tests.

- Interrupt mode using l3fwd-power example application tests.

- Multi process testing using multi process example applications.

- Hardware LRO tests.

- Buffer Split.

- Tx scheduling.


We don't see new issues caused by changes in this release.

Kindest Regards,
Wael Abualrub





--_000_CY8PR12MB8213B55B3AF586FB5389568CD6452CY8PR12MB8213namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"direction: ltr; line-height: normal; margin: 0px;"><span style=
=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">Hello everyone,</span></p>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; -----Original Message=97=97</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; From: Thomas Monjalon thomas@monjalon.net</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; Sent: Friday, 20 November 2026 at 15:21</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; To: announce@dpdk.org announce@dpdk.org</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; Subject: DPDK release candidate 26.11-rc4</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; A new DPDK release candidate is ready for testing:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc4</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; There are 44 new patches in this snapshot.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; Release notes:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; https://doc.dpdk.org/guides/rel_notes/release_26_11.html</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; Please test and report issues on bugs.dpdk.org.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; You may share some release validation results</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; by replying to this message at dev@dpdk.org</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; and by adding tested hardware in the release notes.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; We'll close the 26.11 release cycle</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; once we have received enough positive validation results.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&gt; Thank you everyone</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
<br>
<span style=3D"font-family: Aptos;">The following is a list of tests that w=
e ran on NVIDIA hardware this release:</span></div>
<div id=3D"mail-editor-reference-message-container">
<div id=3D"mail-editor-reference-message-body">
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px; min-height: 15px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);"><=
br>
</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">N=
ote: all tests are passed, and no critical issues were found.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px; min-height: 15px;">
<span style=3D"font-family: &quot;Helvetica Neue&quot;; font-size: 13px; co=
lor: rgb(0, 0, 0);"><br>
</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Basic functionality:</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">&=
nbsp;&nbsp; Send and receive multiple types of traffic.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 testpmd xstats counter test.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 testpmd timestamp test.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Changing/checking link status through testpmd.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 RTE flow tests:</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">&=
nbsp; &nbsp; &nbsp; &nbsp; </span>
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 134, 240)=
;"><a href=3D"https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware=
-offloads" title=3D"https://doc.dpdk.org/guides/nics/mlx5.html#supported-ha=
rdware-offloads" data-outlook-id=3D"cdcf3236-e239-41fd-9fb4-4f350e56804e" d=
ata-ogsc=3D"" style=3D"color: rgb(0, 134, 240); margin-top: 0px; margin-bot=
tom: 0px;">https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-of=
floads</a></span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 RSS testing.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 VLAN filtering, stripping and insertion tests.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Checksum and TSO tests.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 ptype reporting.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 link status interrupt using the example application link_status_interrupt =
tests.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Interrupt mode using l3fwd-power example application tests.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Multi process testing using multi process example applications.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Hardware LRO tests.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Buffer Split.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">-=
 Tx scheduling.</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px; min-height: 15px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);"><=
br>
</span></p>
<p style=3D"text-align: left; text-indent: 0px; line-height: normal; text-t=
ransform: none; margin: 0px;">
<span style=3D"font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">W=
e don't see new issues caused by changes in this release.</span></p>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; text-tran=
sform: none; font-family: Aptos; font-size: 16px; color: rgb(0, 0, 0);">
<br>
<span style=3D"background-color: rgb(255, 255, 255);">Kindest Regards,</spa=
n><br>
<span style=3D"background-color: rgb(255, 255, 255);">Wael Abualrub</span><=
/div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; text-tran=
sform: none; font-family: Aptos; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);"><br>
<br>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;"><br>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB8213B55B3AF586FB5389568CD6452CY8PR12MB8213namp_--
