Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8541AC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D0FC42796;
	Wed, 16 Sep 2026 11:26:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
 by mails.dpdk.org (Postfix) with ESMTP id 31B1D410FD
 for <dev@dpdk.org>; Wed, 16 Sep 2026 11:26:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbPWSCGloQG0kB3WAUwwXNVaDnk2EPIi0G2iQ5aJB4k4meCmHpvoAP0rK9FsKNcczp+BcWkEBCGv//qIVIQZn6HLMyjvRTDc0gYSrK4/kjve9hIOf7mbMFEGBwXwR0V7Www08s5qL96TzjUlHPvLXKGpo0+Q8u1v77ztqOozi8xbnmH+13/wRZ8o9ec7dEyK8XwMfc3cMOp4OYkC3qFzNYHPfwMEzV29s7L2qLIYUhYLGWmkXAcBAUX9xy2KAkkKjV3mTtvWAYosZSE2ZNm6z0W0OCqH5VRRxr3wIw+mjj4ZJwJQodwi6H6mxQpq4hr6pXEJy63B+Kz+J5WEQe1tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npHJTbZybpNj021o8eih3ceafQWiMIKBlCcubl5B0MQ=;
 b=gA4kBwScEh2I1fviC9owqeWY46RfVDX+Nu1lmvgIBqpwCcZZgB/Y+I2EcBtD3Rf5dq+OV1ikBH4kryYM3+rp1JisWWi+ebd3XzJZyDYklBDkSyGRqCsbUEhPRNqXNZFY+y44df8J4l7KzjOvHjXQTrejyojYhMeH+4y2gQ33T5kNA38nB0K7VR+QYIYifuheCUNXfXhnnbHSSvNJxO6GN9ithPRfAulx9zgq+OjX9qRjW4phuYU02DQ3TE7IHksYJ0Q8Py5MqFCGJ3rJ0KWdx0JmsKczX9yQuz7kJah8nWBawvWoPQq6L7vy7acpyjd9s0Zv1HvWHDXdiOZ6ohziFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npHJTbZybpNj021o8eih3ceafQWiMIKBlCcubl5B0MQ=;
 b=bI6vkXUWH22QH7XgrOgsFaa4Nklh2ZqNmG90WS/ZgqdNiplQaMbVdzThsJxttOcyWhaQG3Bk9F07qdkaixt9wTrKJc/cGBKHw1kN8pHGC4eJ5KTqZRd467smTDzMjmZIOJZmWWl23BYXCRbf2FHVsJuK6qeqWyJEvF5B0zliOce/Aj4kUjhRs1NcR67fmpMrMZ67VmOneUYLs/KcH8gxRAwJZWIEL1UxgZJNQm3fYhjWogIKwhNTb2dCsdDsuM0Hel5K8iFcjrqs35XvPlRRTAto5ZdRN9jw1Z6JHQD85mPsJEjtbNQFh73b63xNLUvlCcHkOV6OxxGQfNdhmzR/bg==
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 by MI7PR04MB388839.eurprd04.prod.outlook.com (2603:10a6:290:106::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:26:53 +0000
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418]) by AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 09:26:53 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: "dpdklab@iol.unh.edu" <dpdklab@iol.unh.edu>, "aconole@redhat.com"
 <aconole@redhat.com>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Issue with patch application (Depends-on ignored) - pw169600-169609
Thread-Topic: Issue with patch application (Depends-on ignored) -
 pw169600-169609
Thread-Index: Ad1FsUVhaDVkU5FMQqOFx0R9FxyRVw==
Date: Wed, 16 Sep 2026 09:26:53 +0000
Message-ID: <AS8PR04MB8293B2670DEEEE8B780143DCE5B92@AS8PR04MB8293.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-16T07:56:05.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_|MI7PR04MB388839:EE_
x-ms-office365-filtering-correlation-id: 87d99603-6294-4721-9c52-08df13d4a52b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|366016|38070700021|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info: ipu8c2R942FfLbhmXBoRIr+SFEu5ypzED8sit9XcreHgXmVRB0H/sYIiDA+ni4GAlNDV7HH3HCCpTO5OX9aNl/GOH2425UGzmOl4a2ROgpimzvT/miOOVjS+9wzsMj4s2sJDkez11d6Xb5GDErMAPLez71HYnm9viIykVJOVexoUMBjU6aQtrHcwAtR93B1tI473FEW8P/YKZcQmoqH1X00DR4iu8XwYPBC5XCiJG1WYY9iP6B4adElnnmWwIrKHRiNdzQPe8UZVHygK2t2perhnnJXN5gepCVMOx+Zb3W91LyvqAkvTQxWLnL2B8uOKD5/HLN86MXsomKshaRojICE9KsIslTVoUZss8J+NZGnrm8plBKTv0l+KBQF3bfeDh490i7U6hoK4R1sid9Qt85Z93gYfEWUcRZsdEAcSkFbBYN3+nabGVx39jsqWlWyy85JGHrjiUYOXcjBvBwKiGRnP1N4U90XVrT+LClNjyvi1LkzmlQ5DbbihTRVpMki0GzzQMxnw0P7cP9zu+Lym3exQ345gFlmY2LKMyTWvXYqXOpkx1AT3SDiZKWM0h99qtlCdYVun4n+6v2xmRLVzmmQg5C8qOvs3AVLycXN6HE3JQCEPqnef268D593fRnKFYFPqd4cZOticIP+hYEMTGBDLp0pJP6mG98MI91t1vnqaA4E4WQXkSzrdWbIL2SRPxbFmH7uBVmHlAK6UGlZ8LRbJIOMqnfYXSs8TUAldVGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8293.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dOBJVxwfMnKbrl+jHvMRvDiMpubIL3LHalmBhlpCaJ0yc/tEnQfX8TgnnKao?=
 =?us-ascii?Q?Ba4c5CiOD8WcI+yJrHkgxVrPpUywK80XwyyvnlYFQ60HOkfFi2Nb/OQ0YVy5?=
 =?us-ascii?Q?dL0B+dJHsEyVHxE6qyV3gN6KsxI/A1jpVKTrD16IIzxt5IQMvnHfXdhAj8HH?=
 =?us-ascii?Q?ThAS8ZVaqf6DG69g23pC0JKUC9wGeq5ZarSfzQ7u35X+ZmOekvWG/mH4oSqQ?=
 =?us-ascii?Q?XG924IMF7JbjzhNzygUWAYxWcedjrX6V+leMHUJchvjZjgOC2GDf7g7vJs3O?=
 =?us-ascii?Q?MnKkycTW20Zy4feXulRV+TdmrdKT42Ro1jtgNcc0dsv4SEAN3jEWZjJEbeRw?=
 =?us-ascii?Q?bWHlrfPJepWJUQQiKM5aTrHcABaG4IjIwPXAU1Gr87gQCAYrB4Jd2bfQpgle?=
 =?us-ascii?Q?ooeYWtC1R4uX+MP7ta9EVZKR6trgl/+aT1eRIQbs+LaK8BENvEcYvmtn+xFP?=
 =?us-ascii?Q?kIDpJ+Y7+PpbHdFbGxP5f6fHhAhZdSj3kcOqrHfED4vJOQQayktqSXgFAUIq?=
 =?us-ascii?Q?ceijNOzk47272wF3nZjz+joM6I2leaGSfrVdgdnpBgtTbrPEGu5l+kWEeHf2?=
 =?us-ascii?Q?EYaiQ9aO8Uu1jNpajKOrYBtsx7vTmA5s+WN4pALURFNtDSPfK6aLt8+O/rxt?=
 =?us-ascii?Q?rB4VuQ90guvGC31UpXoZ54VvokW2M5mN5+FS7/WV4ZYMTVsHAQ6Mq6SAl6KY?=
 =?us-ascii?Q?hf3KrB4pVgL4qzJqYv8QHUeUTRp6QPuHF98kZWVkfIjHMpxeap7sN0i0mran?=
 =?us-ascii?Q?zo5zXGBu8f4LLH+TtI6T56c5nU3J9SnJEu0bN34eU4G7Nlue7/6PUgFewpzv?=
 =?us-ascii?Q?+a5mAA+xX5BZi5sf6SJD6Gy7+gJgtcEJF8j8JhqXJX/FKa2aaevtdt9zmjzj?=
 =?us-ascii?Q?25YWdb5gZWcEQLe2i2TYOr7O0NmndbHBhlBWgJXKicSyJVBki0CGDIOiV/we?=
 =?us-ascii?Q?hZcK4KmDnRl0wiRQaDLIHeomTABH/TQNtSWoxj6ltzesCQYnUF6VizQVrrj5?=
 =?us-ascii?Q?6iz/YO3IV7XHV25cz8kZAIqFli4/BoUEtp0Q0Gjh/EhSx05Ml5GcqyLkbpMv?=
 =?us-ascii?Q?QSSi8QZejdWFicugQRdFY3/OMZ5BEsld1admAaHdwOw4EjR/hG4ewF0XBbeD?=
 =?us-ascii?Q?xFD+LA6tWFzciNjHoZsV53vXaX4PpB8gaaGNDRJCIr9CjrKslpjRmH3+9wpu?=
 =?us-ascii?Q?PzlQpkvvi+bEpgDyW/wrrwV1rQXdNwkBfuIOk71v0pdOJkZUzm6GGARIZpP2?=
 =?us-ascii?Q?jYrNlw0VIDriNnvvm7zAFqqsBcdrncHNhJf70JchknkiX48JG1HDD2Ur45HF?=
 =?us-ascii?Q?VWRzkiF3GxlPBukbW2GWNKy53MEGC77OVa3H833F1h55bd3Zbee+67vKxn0q?=
 =?us-ascii?Q?FK/HgLxOF2Dgl9eAqUGxGsYd7C6I/37lJY/ihM2Fc/VA3wLJDwqmc+Da+Tf0?=
 =?us-ascii?Q?xozC42RQCXD86lvel97mwutBGHxCEWOWr2wUrIFBLX1h36l6Gm4mvWC5RM2O?=
 =?us-ascii?Q?J8JPPAqT5yiGiNsRNnh4yhApOLBlBjuyuQx6GH07/t7argNTeKfzombn00jM?=
 =?us-ascii?Q?wdCM/B+EoqQCRuKSzW7sPFQz1+3Nhb4sb96H6a3wN9rVdowxWj1HL5f0sNo4?=
 =?us-ascii?Q?tbR8iGYN2gSWgCwfBjeO7vG2wfDtbtnOXGqeq/0mUiuqHv+O7i0/bF4Qx+z2?=
 =?us-ascii?Q?CJVXMaq8ssXkXsYO06i7rkl6zDUdv82Nee+1xExdtf0ujyQg2sj25qjlt1Sm?=
 =?us-ascii?Q?10oovyHrnw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8293.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d99603-6294-4721-9c52-08df13d4a52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:26:53.4594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vk8ulUSfClxNxlbWyJ0sjS0qTa3ExIM3XM+OO7zOAlLc2dkkns2hukrRpDbvYNASorrySZMl6dF5a9jch76KOmvEscnEH39c3AuyrJZICaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB388839
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

Hi UNH-IOL CI Team,

I received an apply patch failure warning for patch set 169600-169609 (Seri=
es 39292). (https://mails.dpdk.org/archives/test-report/2026-September/1044=
522.html)

The build failed because it tried to apply directly to origin/main, resulti=
ng in a conflict inside drivers/dma/dpaa2/dpaa2_qdma.c. However, this serie=
s strictly depends on my previous series 39291 ("net/dpaa2: flow, meter and=
 parser features"), which contains the base infrastructure changes.

I included a "Depends-on" tag in the cover letter to handle this sequence, =
but the CI bot seems to have missed or skipped it. (https://patches.dpdk.or=
g/project/dpdk/cover/20260915120208.4185877-1-prashant.gupta_3@nxp.com/)
(Depends-on: series-39291 ("net/dpaa2: flow, meter and parser features"))


Could you please help me check if there was a parsing issue with the tag la=
yout, or if I need to format the dependency tag differently so the lab bots=
 can chain these series automatically?

Regards,
Prashant Gupta


NXP Confidential
