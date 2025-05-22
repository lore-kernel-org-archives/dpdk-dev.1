Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34698C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 08:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B91A94060F;
	Thu, 22 May 2025 10:36:32 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE5F402B9;
 Thu, 22 May 2025 10:36:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZTWMCSOOd0wulk7fwXYUVu+C2f1NECwXMUBmJJMANagO4c5vc4+lY7XrKqu4yDfGgo8QKxyX4pIRUwR1p7nILIh7w160dBYYHKgVqXIPKBCVJnDSvjEAe7VPrQeLff/LQ2lo83pCETR3KluyC9df8WPBHxkBf3KVYGfMx+mAVAaTnStmfPHh7EKxYkxMoXrSzYzIXnXntw/rrvTTnAUUW9orbSV468K3o7udgwhnOSw1+q5B6DNfoAeHlHueUSAtgslcYlIT5THfjcYJPsuN3m37hHs19ymcA2dBP0HOF9/UVrByUYknX7lt44Nvrrt7jbFm0oyokApMPSs6yztGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8acmNAO6fu1weTVlwB9til8G1WVVwP7j/0V/IQjhACY=;
 b=yZcE9sZFRHUbXrkfnuBl7Gnii1XClbWQ0bOEvRS2unXsSy3iSr4ATBq1vFj6osT9Eyk0Wmk2i5ZKvKIOjXNhzaZKbqfDfD9QhuTJR3fbBwaH01ozLPdvPIvpoGj6Hy9/mq1ORMIMcZzhsh5bIjyC9/64TgNQkFexFZxusVBpw3/15GNASoN0+IIDVgXRJGH8Lth1IrOEAF+7fWeezE//1ZR5RDJdEBZWtpL/dsl6Ggzr/igQUkUjQvMMqA0Ma0tHzZPg2iW1mMWoaXRjSXr95ESZCIOEcimbpoUcwQ4G1QUPeO1hAXXEjlJPpjHUNO8hd91Q0Gf8BDKryHN7ICTIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8acmNAO6fu1weTVlwB9til8G1WVVwP7j/0V/IQjhACY=;
 b=I+3eNBe13zWZLRrpmfQ70HDoRSpaatI6W4r6Jm6PoRuf3GfkvqZvIjwpQCrqSGgCNoEvnyaAQBHASykP0g3MdG2xgB39+DWN8vbHDnmROq+814AJmNICMfaXAoee5u099+tlqAnYzyUz3NiLa8NsO84qUcyCj9Zl8Mpa4xpnqmxb1Xmn0CToLXBtxs3gZEHoZut/d+O++ZEcavUd5466UuHpVk30U41ZjpCvuvXmtALMxbQ0q1cZb7AqGKtzjTl5tq++Bs9ftfPMx6fWenEfmimpxx/UYbdB6usHXySzHJtG3eEEQDFdZ3Cq7yh5S5/jO4WiP7sGBlOybx8oPTqnCA==
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 08:36:29 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 08:36:29 +0000
From: Ali Alnubani <alialnu@nvidia.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "ci@dpdk.org" <ci@dpdk.org>
CC: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, David
 Marchand <david.marchand@redhat.com>
Subject: Addressing git.dpdk.org downtime
Thread-Topic: Addressing git.dpdk.org downtime
Thread-Index: AQHbyvO5sxQSWhITBE2s6+sLDfZQpQ==
Date: Thu, 22 May 2025 08:36:28 +0000
Message-ID: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB9173:EE_|CH3PR12MB9220:EE_
x-ms-office365-filtering-correlation-id: 28479bbd-9439-44b2-18cd-08dd990bbf50
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?XSRTM8l/yU9gF/20+7F1oW486Ju/GhjzRsMYATG0UJN6bvayjw7tpGSk?=
 =?Windows-1252?Q?6ULldzfHA5u8NtttXK4xEsEQrjt6s271QTBoX9wGikkFbBka6DTNMj37?=
 =?Windows-1252?Q?9U4LpDC/YZYC60PdKSL0QSTxI30+OpCwMclBO7W0WW4wqWgfYRFxnA8x?=
 =?Windows-1252?Q?0aG/nP7aO11z3S+iXPgD08sZFChoiSHolF4n64H0vJYhKmfa+Golfd64?=
 =?Windows-1252?Q?AsndyMaeS0ahILnTbfXV3XLvScaBiDDFSQAuxVVZD2UZc8VXmB1QQsXP?=
 =?Windows-1252?Q?VgbkEkwPsvcAzC4sPrMzY3X3YZMMr1j/hCGO/IHzGzJY7jd85/zgJ3r9?=
 =?Windows-1252?Q?k5axIK/xfHcCgfK/CDiPRQN0zcEFlNYJNnol5hO7grWieXXP5U8FjqPz?=
 =?Windows-1252?Q?v1x2PWz+FbsiFdfbceAkCRxuKT5GDQnYCLjw1AhqOeqHafywN02P7ts4?=
 =?Windows-1252?Q?RJq7yKgloFq+G/lM6+s4R70ZTmK6y9nq/AzVyW8F5VPsW3IYgbygTPVl?=
 =?Windows-1252?Q?V6tK2riqf3sMdWAt/LR8UU1WK94R9WO3bU7qKQnxjYNa7+vOSk4RTk3X?=
 =?Windows-1252?Q?nr48XAnqBkzAovYv3rCK4vooW3sIpJAN3AWdRP7xn4sL150+YWalX50Z?=
 =?Windows-1252?Q?3tJFW4jdzHzznFdu/YCg6PNaQz7/woyAMKH0iH6AEybcXu/Gev9fYhFg?=
 =?Windows-1252?Q?0siAbk6IEV8DqUpcn4od/FVjsfnGfInNgRGiF6dEEOFQ9QMELGk0H4ri?=
 =?Windows-1252?Q?bJ8vbQOCMGiHLmRP77XctQ/rNpe/b0LFfTB9tx+EGUrvr3q9h3Nyxlud?=
 =?Windows-1252?Q?g1kIzgsxzxkz+EAF7nP0Lcs21IwagrkczgRIrky/iKUIxLhGtC4yegXZ?=
 =?Windows-1252?Q?/y2jjSMzYhZrO5EbPIZUzG+vknq2yDliigDeIdK9MbFx3wL1gBGGG525?=
 =?Windows-1252?Q?oRDEXEjETtVCeXOizoyTVAIDm92PjMC4qFGlNxWcqEO5jSPZYNzCYehc?=
 =?Windows-1252?Q?q5eRYiVhxOmcxbBJ8dWqAtvacMWkV/3hz+TVDLSKy5T361B1IHkAi1pr?=
 =?Windows-1252?Q?LaY92tq7R2L+3JRvpHt5gFN8Z8c4YDY2S8bslKp0/0vkQJLK+fbfY/vU?=
 =?Windows-1252?Q?AubuGWXF5SqVzDjki4pgGMUZAH4Q7T6DqWn1x81n9jgrqT8f2LJa2VkR?=
 =?Windows-1252?Q?p6TaBuMXJvlZgk1C0FjKsyn0jrdECJvymjfVASXV+J+KBDDWUisfpMvs?=
 =?Windows-1252?Q?TlNdEVtKfz6MT3RCKQl3qlQCksJpk+dEMPVbFy46Om4XHz1hevXfyOPo?=
 =?Windows-1252?Q?gEIpYXnkpbpXt+vjAwAaYmDOmcewTenhL4Zxy5H9fAeyHBRqLgIX8aal?=
 =?Windows-1252?Q?GaBGpAVzy5lKUYSLGTKWCvnR4acyknFnaOBmhsVX0lDKN0HIgVu7KUuf?=
 =?Windows-1252?Q?br7NdtJVs2Ss51z74g2qV6zEFJUqIBKC+fVgnkhpuaZh83pQQWZ1niB7?=
 =?Windows-1252?Q?M75opjpQ7XkQFTA7snusk1ldErdnDHBMivIvF93uYyBBJZ2WSchIvygH?=
 =?Windows-1252?Q?QmeqK3TNpZHhzSx+ktQTaUz6n3phq6GqGKaa5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?SbpTG5I9dF5JvETrsU3OyEtFm56jVeP4OTnX65G7apXY2a7CTVD96tZX?=
 =?Windows-1252?Q?sqouw8FyGudSCA+N72TiMbSQbNLeT/HrsAkXVsXyqJInLFU/IlVPAqZS?=
 =?Windows-1252?Q?NMQjH1nh8ywlLWfeM63+jkzr7pJaioflHE6ZZT/tKc7HKiUkjkYI6USy?=
 =?Windows-1252?Q?xgRLFpOM0FiIPHp7DliHcl49LOXoPaCuoKp7tA5Svwpi2LiIYBTwUb68?=
 =?Windows-1252?Q?YgYMdn9yRBEcz80/pxb6Jor6EgPBRkcjB/Q50vg1B9dae0SnxHr14dIW?=
 =?Windows-1252?Q?8S8xJDUkCEMYWIuFQ3bPfg36+LBdsSoicJCZtGzdUtgUnk1cXyo6fVrJ?=
 =?Windows-1252?Q?bjpzDPol/JdZfgZUALSDScNGk357j57MpRXNRptn+/CEKSf++8Tds2FA?=
 =?Windows-1252?Q?IjXf+WhGQ6m5ih3Zri0gU/6FUi+4R0N7EViikk8dVti/vqgmRGPj3fV5?=
 =?Windows-1252?Q?LYzxwb3k50Rh7RMw11oSvmK500Zvl13VWOVm6xjPcJ6GnaDf77IHLFyy?=
 =?Windows-1252?Q?oDqgD1y6qIKCF/r5gNsbJkCkb5w8UrwFoZ822eB7rupkMXIelObFmb/6?=
 =?Windows-1252?Q?cY8DCTRT6C0UzXjj0XY1Jp9b+e97B0oCoin3I/soCW6enW6H8dq9IHUi?=
 =?Windows-1252?Q?lbnFAIauWdKzZpEdg7gwG963tPhTxlznrhBSkYV6X7uPHQDaB3BGF03m?=
 =?Windows-1252?Q?LDJ2G6fNd/rddfEtQCKzPBN1Tmcbo2rHd/2JJicps4dSD59MyizTJ3Iu?=
 =?Windows-1252?Q?b/MSYMipKjKMCQLYDwMZcyIfPKMMeI+/irw0XuNfAsZLstwlmyjiEuUr?=
 =?Windows-1252?Q?hbffO2ItGVjRoB+HdlQ9YbAV+yYPDeRZxFLrpgWFuumT1hQPcgp3AKTc?=
 =?Windows-1252?Q?yHdp1GlbBtgIysTIo9CtPTC0n2incWSY+aeZgwn9xjRQMbtjWtL7mcAg?=
 =?Windows-1252?Q?gDV8OJp3/Qg9LbygPqHAbDMZx0O0ZWqWPuK1ab813uGOZdjSzfwPIZ+k?=
 =?Windows-1252?Q?PpXerC97SkiT+SOF/IDiuoivJazvlzrRykaCMMMW5A1ZsT2RnpaFzFVb?=
 =?Windows-1252?Q?GCBXjxiJHfd1ToxHf86qunXVU48Pl3dI2RaZN/26Kndqfk/gnIuDyL2C?=
 =?Windows-1252?Q?M6QNKjinYnC0XHMUNjESyh11pdK2kKhTY8z+BP5a14quK7hZRWm1p2Zh?=
 =?Windows-1252?Q?dy7Z7UDo1DBD22Bi47neRjuAYezAL2aon8rtjZPKtFAz+F0yzdHklX3f?=
 =?Windows-1252?Q?fgW1hC/rgq6bHOUX4re2G4h4j7wpt9HCT+xJ8VhNyqaMBNp65aeyI3vu?=
 =?Windows-1252?Q?s0xc1C9M31VQ+zS74K6NBbn0gA9Lk9oMORnTTaAJDpfBlNEZ1lflWu/D?=
 =?Windows-1252?Q?s5DLRdGe09WjL5OkIF89jgQGs1WOfBMtuK11HevGgf93WQzbthAOctry?=
 =?Windows-1252?Q?7cROy9zTlWh11RZR/x/3MFmLsSGMT1rVID4oQnOZdlWYv3gJmBkrNpgJ?=
 =?Windows-1252?Q?Tr0JLFS5seHCHta8qE82MIGvaikg1Jry5pEe5jDM4PJIUBJn6VdSZLuM?=
 =?Windows-1252?Q?AZHIDWOanW3kVUgRVYNop1U55fKRS0jiLDNVXtQFMJDfATKyuEoqA3m4?=
 =?Windows-1252?Q?4ywWrFGQf2sWkED/KG9V0D1VLpU8knTypbgQFkLOLl/fXxdvhxHK6G5g?=
 =?Windows-1252?Q?vjExDxxaV+8=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28479bbd-9439-44b2-18cd-08dd990bbf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 08:36:28.9249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKJmub/Q+L/CLPkjDM//Wv/ItzZ1/caWWkMletR5lvXs1k1D+CHdVbaAuR2RSyf6F8ZtWG8c7w3wzMP9j75wQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

Hello everyone,=0A=
=0A=
We=92re aware that https://git.dpdk.org has been experiencing availability =
=0A=
issues lately, largely due to abusive bots and crawlers overloading the ser=
vers and ignoring traditional controls like robots.txt.=0A=
=0A=
To address this, we're preparing to deploy Anubis, a traffic-challenging to=
ol, to help ensure reliable and continued access for the community, startin=
g with our cgit instance. This approach has been adopted by several other o=
pen-source projects recently to reduce disruptive automated traffic.=0A=
=0A=
Please reach out if you have questions or encounter issues.=0A=
=0A=
See: https://github.com/TecharoHQ/anubis=0A=
=0A=
Thanks,=0A=
Ali=
