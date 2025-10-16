Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DABCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4274340B9D;
	Thu, 16 Oct 2025 11:30:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
 by mails.dpdk.org (Postfix) with ESMTP id 4EAA440269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:30:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7oK1SfxBXT+dzo8yl2tIL1MiHovUFZ2aOk4f/RCJHOztRVHCWhEnecKlY5FylivfGn72lcwfLS5H8PE2rHbb8dqUAGipnLkpR4/VM+Vi8qAfkI/a+J/BnN4LYVL14T9Te60EgthIMBPe1afXXNWAVTop932ebDqgxjPCZ5EqDlAp2xm/BqeSfnmn1aZAOP4xMHLpoZHs3gk+gmezFeHUbSht2DWAO7Ugke6yY9cjREkK1koisinxf7k5xu86x6W2eCushxqTsSdg4KykDk/9YT9MafbmJpbcIxSzfAZnqc8B4ufHZW8cV6w0JGOCRlaZbHgn6xqTkPAVgAbLTKRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+4vJ/bl0rf9IhaBdSjuMjDPOBq59EdL/Os1r8okQS8=;
 b=r1tQxGrgf0GYpr9q+nqnZtSp1nqXi0+CnNDtamxmSuyvDtS/H/skzpENQhfOysY3pAuS6aKxT2oW9SD0e7Yw0nHKeWEKOA2QZLyU0rTnyunFk5d+ezocZ7PeHULKl8P2QW8k7+PowDo1td+E11C+NxQbF6+9JIE3uXqi6Q3wi2dI2qQZQ152zDbhmhKS4tKsQ95fDlewUEezuAfXHmHoQSOW6D2Ij5u502D3eMM3kJPLEEWMrDJnfJQdvDviy84UqaRDUgpjSE4JRGM9el2OXodLneobpE5u4Q72P7V/D6I+diGae88APDFNAz4rsZBiHrKlnICsZtrUyPOp3rCTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+4vJ/bl0rf9IhaBdSjuMjDPOBq59EdL/Os1r8okQS8=;
 b=WStUw9Xzke2tIgDPWJHrCtTwA9XdDaEVCkrfNp9XL9jlXC9uKBEyU8pXIjEHO714oksVJKcudmb2LxFLI5oSzk9LQ5HKTfFA4PwUDQbmwUu1zgB4z2PLkixo4ti3a4JcbbkdSFmpcR/ENVaGxhh+fSYsLUtg2refkMgFgEzWr8YoDXjsVdywd2GH6d/QC/eMU6JiHCP4FSGVhch8LSnWCs1n5f7LvjVO0gTNpIROMj6P72ZxkMDKgb/Q1CXXExJRB74BpltMm8QqJEYC4xG1bmKd+kLrVVOdAL+KVzk7Aw0aiQhDcNhSPqR0625yzkie2DIrTc8O5IqB3HNqk0rwXg==
Received: from GV2PR04MB11590.eurprd04.prod.outlook.com
 (2603:10a6:150:2c8::22) by DU2PR04MB9049.eurprd04.prod.outlook.com
 (2603:10a6:10:2e4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 09:30:49 +0000
Received: from GV2PR04MB11590.eurprd04.prod.outlook.com
 ([fe80::d74:fd73:147:9d84]) by GV2PR04MB11590.eurprd04.prod.outlook.com
 ([fe80::d74:fd73:147:9d84%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 09:30:49 +0000
From: "Sachin Saxena (OSS)" <sachin.saxena@oss.nxp.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
CC: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH 00/11] net/enetc: various fixes and enhancements
Thread-Topic: [PATCH 00/11] net/enetc: various fixes and enhancements
Thread-Index: AQHcNpf6wHZhgp6Tk0a94FdnEvmwm7TEkU5J
Date: Thu, 16 Oct 2025 09:30:49 +0000
Message-ID: <GV2PR04MB11590CF99DD2790937CFB03F9E3E9A@GV2PR04MB11590.eurprd04.prod.outlook.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11590:EE_|DU2PR04MB9049:EE_
x-ms-office365-filtering-correlation-id: c67bbd41-e230-4e64-10b5-08de0c96b144
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?niQca0+v/vAUbckAtf0Bv5aquAB8dBxnPjNH8Dlsto4sQ8LE2m4jVAsqzt?=
 =?iso-8859-1?Q?QLQVu1Qxn6Utfmz/OYsOzDGcM/Yxqeab9ta+9sKovDozBeX4E2kVoqHQVA?=
 =?iso-8859-1?Q?e81Skyti0Wi4kpzl6ducCIFJtbd/r6ci/AGUKZ/g7Q2cjVGmI8XOHZ/4vy?=
 =?iso-8859-1?Q?ycuJaLSGvNYtTRFRqyhoKevMho2L17dbS4kvsC83T9hehJFbHEpNT5AiDY?=
 =?iso-8859-1?Q?gMH8aQKzy78nS2yEMXYxE2aOob7H9/1WdF57jgXKknnDSOS7Q/NO5DLvKd?=
 =?iso-8859-1?Q?ngfr3Aw3ZATEOIMATdriE+3jIfG2777LZMta08Fh55btlnYOV82dl5u2tU?=
 =?iso-8859-1?Q?vJoCApLqDGlzli+12dIkOabznbM87sSbn2s50fSMTyfP/zpnDdXop5sQ53?=
 =?iso-8859-1?Q?ih/Nm9+JEsbLGTpn7ACdEFFsXuo7wO0H3uTq6S9WHhNcQ57RefgzxQ2nl5?=
 =?iso-8859-1?Q?3NUGPoGINxLRG7MxQgxh/zbXZX1C8qhR3v+Vuvg/I9nCbkyopFtoPz+Ce1?=
 =?iso-8859-1?Q?E6KV/gpXWn1n9cZCpFCVoZ/aj+lYidyF8HXCDudlvEdLUFy2n6nzM7msVM?=
 =?iso-8859-1?Q?yujUWHDoeAEJgrYW2q5/eVYYhuUW51RJL5vy6FkxNTdzFlmm++BzkA6MI+?=
 =?iso-8859-1?Q?OjcDcM5v4dntUO2bmIikzV9W6eAaTc8gF5B6g9NvyYqFDAuoolaHYHoeRn?=
 =?iso-8859-1?Q?0fQA7SYyYlpU90xtpwjK6w+u+fakKMzbbStLldqa/l1DB0eeBcibNY7NEY?=
 =?iso-8859-1?Q?uUCB1csJtFZzx7vMdqISzrdvjarF1y4Y9PUJ9CiDTI6/E34f2jQ9jiBRwv?=
 =?iso-8859-1?Q?hVKRfeGr88qvERg5UbsziVqBDHn+1sTVYZc6aN1Vf56VTr3XxG4L871lsN?=
 =?iso-8859-1?Q?CdquF/1Z34b0AcAX8CT5zMCqmPTW0qZoY4LtMqZFceiI8Kog0L9JYzmm9+?=
 =?iso-8859-1?Q?pUjYCdz/5kkF/RlVkEviAnWI77NQx3BakNWSk4B8tz2u8O54Sh1HR4nskg?=
 =?iso-8859-1?Q?aD2jA0f1/lAiWMGp6qCqk1kmJJouKy+uWt6ksgZyo509aXly4na5qpyefH?=
 =?iso-8859-1?Q?hXFQKKHucfFGXrMMSizwC7b/MNr7cfatyrtQn877box4b+FSRetKCEIjZ7?=
 =?iso-8859-1?Q?aVLNUCZDbQQ/D/UI8t6dbeD693p6ikQuTmiPTlvd5jjaGqNLmuravQ7Yme?=
 =?iso-8859-1?Q?PQtKu25blhTSFHqmW6XXT3aQRuqqlx592tMDjykz4PhQP0DHUbfFZWtpaW?=
 =?iso-8859-1?Q?/s3f/Tn3W5B2vbPHECCUaarZLyAyoXhL7yGlnQkLIieXKv3bt1u1lAwGmk?=
 =?iso-8859-1?Q?R0fBO0W2EErfwT7YJOQGbfFB6poTgDHWHpsvVRqFZx873CGf8wgf3Xil3V?=
 =?iso-8859-1?Q?FMaYCtUggqOmYa/fWcxskF+Z6c7QV4kTcdmJ8sOjTx5q7hv0r9d7gf9/C3?=
 =?iso-8859-1?Q?Q1oBKcLxO697Y8tBwKPSlRTbfqFkPxClT7CD0HVbSY5uHRcVXDQzoOhi7z?=
 =?iso-8859-1?Q?wl7nK2rMGbgANgSDNp/idc4IGu/KZjH1IoQJD9klHYk1xpdhz9qgiS19Te?=
 =?iso-8859-1?Q?Y17Cw0uJHuwJ311xNM/scxnpVRz8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11590.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e3Jqd52r6IZyY9BasRvPZqHUUntifwDMUZ19tPgekRGaL7JIt/RQhHHnQi?=
 =?iso-8859-1?Q?RVL9VrY/GnNKPXy8LE0kZ4+nfN3X1Dx126snR9BQtWUVcAbSDxpW2NbysN?=
 =?iso-8859-1?Q?IdiXXWuHsm6l51sYnXcMDbTcU0BHTF2EbcTIG9p3H++6gJkTOs61T8osWY?=
 =?iso-8859-1?Q?t+vNKtXYI1Vkl1aV4tL2HuPFGlhr/6pqvCUU1mQBqjZ5NZW4wu/az3LfoJ?=
 =?iso-8859-1?Q?OSJozKWckxS/UlqzL0/gJaf0NrIXUNmVxAdwb2KWyBULJ5m5QEPpe3KpVJ?=
 =?iso-8859-1?Q?CUVT0imGwDnrdKKqh0Cy1nswVbJhIPWtTwREe2OYG1cAJomO1p7/lFS12w?=
 =?iso-8859-1?Q?GzjDoxlUU3OBRgl4MTvRfGwwyCH8AVVRaVrfFh1721uz2xgKKBQkjP9vJC?=
 =?iso-8859-1?Q?iavgtD8XDS7hFHdUJ/ygLfIoQ93qPr+WiIraoqJJOsqiq41DeHl1NYwLyq?=
 =?iso-8859-1?Q?fM/7oipBwGtrT1k/LMktOG3HIs9H3NTsoycvs0e6BXqXFj5tYcemWpsnB1?=
 =?iso-8859-1?Q?radBv+tGP2XfMPVzGuyCJtlmRbqUJ89aehHkdGRw8wGKpMldWtj9UObIYt?=
 =?iso-8859-1?Q?3FVEDDFFQBuYbXwMUzNLRJPMvMkg2fMoWqEx7tKCcfnOFqQE21VBt0hAsK?=
 =?iso-8859-1?Q?qrjWsAURi8JQxE/LwoDA58m7gKbaodbhDJPO4JNV9rCpmZomHIt9L0JT6j?=
 =?iso-8859-1?Q?N92EBr3RIjksbu3tiSTSaakzjLCXiN9deigeKVPp4R7G97rr+np4Tefmo9?=
 =?iso-8859-1?Q?kpGxP4oTwC0tThH5u7aMUzzniem9TWoP6eNvDEu56n7dmCLCBEkg0phxk8?=
 =?iso-8859-1?Q?a08XICvGJw6lc+6CGMnvMedqvqkK5JLlDa0tv0i4t3MLkzbe88e1XWpgn0?=
 =?iso-8859-1?Q?0et9pI1AKwXkgqXebXh3bNXzATTEGZHdjqrDIf69ZusniMd1Zo7x3s8jqM?=
 =?iso-8859-1?Q?nCoVq1ItWtGhPSlXfAvb2yOfkYtaBVcUdWOiY032IOO3wYu0Bmioogq5vX?=
 =?iso-8859-1?Q?fvD8Ab4dGeSD3lMQy90+qeqoG/U5sF39gCZ+6JZbNo1NjSePddxvdeUqYj?=
 =?iso-8859-1?Q?lENn1DzfjUnXJRS/YfLyuTN90Ra81kOF4OQOVXAkufiuSI0f+6NEoGJHh3?=
 =?iso-8859-1?Q?KGofMKI0pYUkLE9NqGgWMtCFLv/L8Buj9Q5FuQ2MLMU1nbDM7VY+69aHEM?=
 =?iso-8859-1?Q?pGLzhTlim15nTQif0wwKfQEGMx4K5lDzb+I4sShSrikXDZTuizz4MobjF0?=
 =?iso-8859-1?Q?A8EkaqBr6JigHd2FD12EZb7N3Mei3Lqx3yZnPd0uQ1X35Trc++8RiuUsg4?=
 =?iso-8859-1?Q?FbblCwTFv9sUr4b5gSY0mpMTsqsy+tCDq4mVl/lnaEvpKtNbCzcCtaoGqD?=
 =?iso-8859-1?Q?PqeoTPL+EG/ZmBs7tUTrN0dDKOPBkxX91kGpFjG9a7PJEBBw9j1gqP3K+p?=
 =?iso-8859-1?Q?uGhYpHxr8XdJSBWDxLhY7aAqOzayWtlHa+vBni4fg4OTLl3UtimsXvYy3M?=
 =?iso-8859-1?Q?fN8hVyabQCJkBMxl6xBatwA2jOcSe4PWp3cHFEuXV6YaV8G+742WIlYxzP?=
 =?iso-8859-1?Q?l6zkGWySik0Y3ff0ukq4ctevYUJlEgspSMMRSe7hxsJ+h3F3FZb74LlyJw?=
 =?iso-8859-1?Q?0r9WMDnt12yYeZx30eIzyJboI3mgET4dST?=
Content-Type: multipart/alternative;
 boundary="_000_GV2PR04MB11590CF99DD2790937CFB03F9E3E9AGV2PR04MB11590eu_"
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67bbd41-e230-4e64-10b5-08de0c96b144
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 09:30:49.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eX0ep/7uw0cg3rGicLJaZ2k18soqktOSAkM5CDnncbbXJvI96M8F+VIRbY4Tg998cqCyzPVmx2LDPdwLGMqFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049
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

--_000_GV2PR04MB11590CF99DD2790937CFB03F9E3E9AGV2PR04MB11590eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series-Acked-by: Sachin Saxena <sachin.saxena@nxp.com>


--_000_GV2PR04MB11590CF99DD2790937CFB03F9E3E9AGV2PR04MB11590eu_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Series-Acked-by: Sachin Saxena &lt;sachin.saxena@nxp.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_GV2PR04MB11590CF99DD2790937CFB03F9E3E9AGV2PR04MB11590eu_--
