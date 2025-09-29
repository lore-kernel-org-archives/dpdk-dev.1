Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C2CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:59:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B90F14064E;
	Mon, 29 Sep 2025 17:59:53 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id DE73B4025A
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:59:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023125.outbound.protection.outlook.com [52.101.72.125])
 by mx-outbound10-155.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Sep 2025 15:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLMc2AkA6HrHxW9rNGqAtJz2nKsqKvsQ5IA2pTO8ZyCTMt/ii4XXis2IXvzEwPNRBP8FKViPsj5jMJD1EyebZsFLXoV428+BxbKpVxaFzTjbLLvm/49BiI8nfJmaAzviZszaduYEuQUg65xwsO9829y5TllMJ4i6GO5Bkmkhaq/b0E219CV0vgdajPdt7lJgJwQC5mb0mzXO2iIkeyFbFafHMlITv+F/xLHaYg7OzdZGgPxYsoieoM8ZGVxj98NASI5hjqx2kH0lmP5grt9JITH31YX+QjS8vx1aflpHr3dqzgLivRBd9+6CmC1rz/qiwBg4PIZ89bGxoDR2MXnDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dpgG1tZAcsJuWIIQ3bO/TmL1QYmHqT3h1ujNhkbphM=;
 b=dnDb9/8zIr1EOsSJklELGBsE+YN1600GRINyIo7+sS9IdAqkZ17EhRaokCsp2XeZsXSbvnlIgh30ymNTE6IVWz4i2GlOV6d0ZpCU3D9Qi1UABzYxqQWVibBjhjnMsZrCAHJeVT231WdxcF1nsz5LjNPt7nubjU6tx0C3mrkMT4dDXw9TD88ANq71rVoR1Cg2v1R3R1qrveSsKcainUVMKUbTu+HIhoH+QRMxKeiJprKDXm4cZTyxi47zXioBoLPg+84cmUMklazvlY8yuWnTqd/8RxNhxe3gWBUxehtAWLQumREz3Bu4HU1xJO4kqFN6VGyWePqSTi0J7TiXO45xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dpgG1tZAcsJuWIIQ3bO/TmL1QYmHqT3h1ujNhkbphM=;
 b=I82nDKBrFXAkX/bMj/uhqIqeXwvosLdxPK/wTnzkoxqd6k+vsC5QROLGRmsUYick8zOR9chtMV6XUgqDktoi9YNjfmSwSFKs+ZPjkhDlIPAcp1Wie9JxZID0RilfGPncJUkVw1A9RV/4wQubJ7cIU9sN+Z0xc4j8IzxbJypnEp0=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by VI0P190MB2048.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 15:59:47 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:59:46 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC 0/3] net/ntnic: prefix global symbols
Thread-Topic: [RFC 0/3] net/ntnic: prefix global symbols
Thread-Index: AQHcLwI2GnBqbEYLBUmoniCZ/WfO+7SqLH5r
Date: Mon, 29 Sep 2025 15:59:36 +0000
Message-ID: <VE1P190MB08308308E532B306FCBCAE3C801BA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250926162534.401577-1-stephen@networkplumber.org>
In-Reply-To: <20250926162534.401577-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|VI0P190MB2048:EE_
x-ms-office365-filtering-correlation-id: b30105fb-79fa-4d8c-93a6-08ddff713672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gBh3E0Ng0IrhtD18t7Q/FXCLsD8QZgc6CRCZtStoaxQyJEo3KR4Iq1PtWS8T?=
 =?us-ascii?Q?VF+r1EEkDM8TAi8cXsSr3sLdkCQjlzQEkrKtwdg17MbXDGsWSQz5wCPChjUs?=
 =?us-ascii?Q?6hVrBoR3eVCwWOiyDZ2sXuCR5B4ChkwEl3nEEcG7531UWBmLRwQDHDG2fFFh?=
 =?us-ascii?Q?x5VtE+u9AcY3aZawbm3zLZSwaDsqtuk8fXx6IDoZjlmuZsGho/iok9RcovL3?=
 =?us-ascii?Q?Qog7jpjXp8ktU+cRJDmNh+Or5IdXxnm8XVkcbcDCHVrQY2qVDgfGBfPrKpJz?=
 =?us-ascii?Q?/oSjcGTfggqp3gYGqzR1oLkl05xa2Ckig14XYblsYQb0iF9YOZJJi0AwAnIn?=
 =?us-ascii?Q?J429XOcdKUORM6OVRqVCbrW9MvkkB1QFCvtbAVA3apdCQsy2jl7MRSReelBs?=
 =?us-ascii?Q?V+31OdZ0ppJZQFR53jVeDY4oPiYdDOvzAQSKGleKFIoeKPAGjBh7tDAKWaYk?=
 =?us-ascii?Q?necaJRquxRL2onszVw6JgBv/Vf7RyMwpf3bUultahe7AvWh86GYTguInVmJM?=
 =?us-ascii?Q?NCy2O2MSvOr19obFBvg6MzFc6I+LrGcJOLpRPgQesii1exSWf5MRyIb66D1v?=
 =?us-ascii?Q?j8KGsIAMUFnjLp/EidueIoV1pW7I/ijFtaR7+upEKaCIF1jF3EF39zKuZFGY?=
 =?us-ascii?Q?kpx4hpPzzGULXrzH3eo7OLYA/qXCWeJAqwN/SpqBU6nEHWkThYxDtueVW+CN?=
 =?us-ascii?Q?T62IjmMCFp7hH1oKV8VazVBDemAsiiCK5nCXx1KAC6fpHP4SjiQFztNOqmjW?=
 =?us-ascii?Q?JPPKhXJgpZkN4QYq/wd+W1f/9aMS/u99IOiPUqzvxvW+msKlMzTs0jQ96amZ?=
 =?us-ascii?Q?oC36czpiiiD5hJ9Au6Ffjeiya4T5K32aYbQSdIKlslsIrpPhgpV0icvlrNrj?=
 =?us-ascii?Q?TnGg+fJZzCpnepXnJZyZyFZOLTJ69DUfGFyymV8tAnGqD2/jL5bcIJ5QzFAO?=
 =?us-ascii?Q?aBro+cnz6472tXvfhl5yLvKTGm7l6Vvw7BVQMo9Xwn3gZYugEWZpNGJ1Q51G?=
 =?us-ascii?Q?d4AYucrfxjI0BuQhTDDoqPEdqnTN6H8rNahkArMyV1qoVU9TrovOgwFlHYxU?=
 =?us-ascii?Q?NAwMGZcdsw3Y9Y90Nb+wVMWswWpaqfcdRjAPs1MZafYpF1PJBtpoR09oh/X3?=
 =?us-ascii?Q?ayHrxsTfL6iY9QFRGIRxyQQeQOr7KxPGNlF9WrP3D1C0Hg/jpnn6CAW073My?=
 =?us-ascii?Q?HuwhlOtHuQW3T1J2jqud+VYIKQBb/fxM4TK4Ehwihp4YwkUjn+2z6EUOzfLt?=
 =?us-ascii?Q?SQYXBBRgl+VRws3Ennum2Vd0ra7F6c/IOVgy6Aif0UgWrprigALWdtJQH3/L?=
 =?us-ascii?Q?3yztHIcDYtg8ga77UdG7LAzHhfA1KjzThENv2BT8OmjY/8g9MHkQAf86U7gS?=
 =?us-ascii?Q?ygnKBiT/4bgRKD0LtgN2ncfhtPbZiHKTT9/yjdtKVWryTy/e02fUVav8BBJC?=
 =?us-ascii?Q?ue8aKBVX4Tk8uEfzGmThTJ4q/QSspSy/bkdUdiuKYPAw5Ffyu+of/IihaPp8?=
 =?us-ascii?Q?1PzxPk5V72habiuJT1gMPHtcY+Oaj7iw5MHf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SRITxfLunIS0fI4f0amVDRJUBP8CqYASKWmi9zkJ3n27iJu64nVOcnP6v+/Y?=
 =?us-ascii?Q?ZI4Mm/35d0RvBEVP6nDHlhB9LOgPEF6gsQJ5qHjYxUSIFQnXt2Ghvs0B3499?=
 =?us-ascii?Q?rhDW3Jzgk6igHRrby4jGSVx3r7cfZUDl+c9OChsjgjc7O9j832LoB2MG9+JD?=
 =?us-ascii?Q?jgJbBvtUGBTivJmRaolA0H5yDGA4DHf6YGeJw4ZW0484yGfRg2lvn8uXV/pT?=
 =?us-ascii?Q?IXcezhPlQT34DWOClIdqsvZDtlqB8jF6rqLmkfMyEAfIeBYWebaruU3vLsmj?=
 =?us-ascii?Q?LMwaW8jTBlMoNlYwMMxop+bNY+dd6D2NgHlym/5IV3FgGVjB+kERR2fPb1iT?=
 =?us-ascii?Q?D1l/I1srC60I6zv/DdFhN1K/LPn9XTFgoLK/whSeDNoAQe561TfVKSmfyRxx?=
 =?us-ascii?Q?ua426u0hhNcpYJPWSAX7hM/7zg+VraRkxd6zdMQP5z818OMhxz9SXwE8xa92?=
 =?us-ascii?Q?K1LirtDGovNBbULZumR6TsA/IXPAZ2VO6M5206vjjPgN/xOdlDLMqE7DUS6h?=
 =?us-ascii?Q?LD4T8Q1waxz7lkp7pvStjYVO39+B8pB+zK8+u4HD4wB1TOojg9Z+8iWrowCK?=
 =?us-ascii?Q?zZGhaXzWUc/upFExxKxu2GgIPeEnDVoK1RxXmn6L1uHPkN1t6Yi4o79I26xA?=
 =?us-ascii?Q?LumKXRJLMB8D1jkSOWZTTBfw1kL67nCE7CHh15cqJjpxhnpg3FMLlfyOyiiM?=
 =?us-ascii?Q?BB7jyjn5NWbYZl7hXKo+KrRCNBy//2T6ITlOv5zBil/CWAKLcdpwQpnl6GSl?=
 =?us-ascii?Q?ugm4wq4lAaa5hhVLwPm6BIVbXpk7nvdq89Gtc6Tm6KR97pxYareNppcwofsi?=
 =?us-ascii?Q?SGCwhmakQewTzpWcMDR3xYTm77PjNOOcUKWG1PB4iLGbb5pwNbLvMptPG5t5?=
 =?us-ascii?Q?yqEbZKTXi9c4xCRzYSuUF5rIn9rcQSkEU9g06a5r60Rb7t35ylPiGnv+IR2n?=
 =?us-ascii?Q?ksVxdrDYl73VM+7CuaJQBLiKv6Q22e1IUGYcqJ4tGYpyGZj0XBrPAWqzz5PE?=
 =?us-ascii?Q?nqZ5QzWDxFVYegfx61h9eMGh2yAKzXCy9P15APk0u/YPI3TmEZqpV22RXAYH?=
 =?us-ascii?Q?kErzcij8FPzAuov0yLKQPxa4vvpKrz+cJRdpMeMzY39rj9WBlnqKa9m6ftlR?=
 =?us-ascii?Q?FFu9cWd82ZPKge7NW/M+WoiasAKs/+CGLqlyaDoiHyFf/ncyjAdFIED59iNg?=
 =?us-ascii?Q?DBhjKoU5KwlIYaoyzIKO+PETsS2hpWXBI1RSk72osFo1d4QQ7u1If3cLjxyp?=
 =?us-ascii?Q?R38FX4psn7pIA36y0iuhC1g7FxiDm9nRdrfcjbMCudTZGYSOdAWDMOwojRGO?=
 =?us-ascii?Q?c005cakVQmJ1J11Z463OsRgEF+epDjgsRMkJFpkHz+UUA4mn4W/CJxcobs55?=
 =?us-ascii?Q?8xa/MbuflvjE4S/Ht9g1qP/wfDEym0OhqtGk1eWxsU5iWuR0tR9stHn2gfIt?=
 =?us-ascii?Q?yw9weKRqKbVAs4cRlFciKcoRvyOG6ZJoy3jfFg4JY5K2Xfwlv8OoCP7rmS+Y?=
 =?us-ascii?Q?sy0zFzk+q7lyiqKf8Nl6obB6adL1UzuMO/pUECYgm0J6mstzxwLIr2/6iukb?=
 =?us-ascii?Q?8SA2nbzlHfCEQtnFzU/6IBckJ3cFFLiuzcRJwR+O?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB08308308E532B306FCBCAE3C801BAVE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /btLrsawVI9JekfqD1dLPox4SBIIT4GrtVSXr/C4oG7xkkt4Tne0etcYfkniMuA9TYtB9oMfCF4lt6svJmvabIYNyZUFSSM3VPbCNf2AjsjSX2ZoEhjqu+ISk47a0evNbbWLV6rHpGJtfV6LN3gJ+Dee0wnFyCOFB+8JVufmaKkueO5SmvezO6LgZiUdjsMD11AbooH55L65O5Wq+G5k4ac8e7gY1stKKZZ/wAzVtX2XyxaTdvMa5mSvqCcyCiNqYDd1wow63VWZGPsjDmvRxN+aq73q9mPzyab6pVqRcrMmjsV0dAFDUF17u79MM+eAw1EwPmuJVOOnZFfbvKtps/aKSOIvVRzbO4VRWVtp1liDXg0vwERLGzijokg6We24zTw2POSj/4P5HoS6KPwgJbtij5lkylep/4VqDmVN6GQ6M3zq2SeY1BNLOJk1xn3f8fBzCoSutE5fGRGh/7BdmjxOEla+8i6NxBVawXVZpDKACj4wFpG//kUsSzpeoC6tCUp9DWbMasvlBwMsl77/QKzvviY5+PBYI8MJez+xK//0sKgHcHEuLnp24JCYRMSopD7rbkEQsbDMN8hD8DU2TPvtCPmhYcQNdPaEp0D+O6BitN+7IUO6tUll8i0XVZA/iD4MS/zDYwKX/joO8Ae0cQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b30105fb-79fa-4d8c-93a6-08ddff713672
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 15:59:46.6051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/7UNZGAbJN+zGU1KtmP2gUIutLgP0gbQTBsdkS9l0SBWF9pqtkAwfS/g58iIfs3SihbQKTp24po1ot+ZLY2Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2048
X-BESS-ID: 1759161590-302715-7643-6685-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.72.125
X-BESS-Parts: H4sIAAAAAAACAzXLMQrDMAyF4btoziBZriTnKqWDYstkCRnqoVBy93pIl8fPg+
 /5hfgMWGHMXeB8w0qYadY+z8ZOhKalJmutKFfamJ3DNkmiAtfy9/s4bp8T4e1LD+6qYs
 2pV08h5lnQMmGyqA+4Xj9rqtthgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267845 [from 
 cloudscan21-246.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB08308308E532B306FCBCAE3C801BAVE1P190MB0830EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi!

The patch series looks good.
Only one thought from my side is about consistency between prefixes for glo=
bal symbols for variables and functions.

For functions, we use the prefix "nthw_*"; however, the patch series uses t=
he prefix "ntnic_" for global variables.
Will it be better to keep the same prefix for functions and variables?
If there is no strict rule, we may keep "ntnic_".

On 26.09.2025, 19:25, "Stephen Hemminger" <stephen@networkplumber.org> wrot=
e:

The ntnic driver in next-net is not consitent in prefixing
all global symbols.

Stephen Hemminger (3):
  net/ntnic: rename nt_log_ types
  net/ntnic: rename hwlock
  net/ntnic: make flow_lock local

 drivers/net/ntnic/include/create_elements.h   |  2 --
 .../ntnic/include/stream_binary_flow_api.h    |  2 +-
 drivers/net/ntnic/ntlog/ntlog.h               | 16 +++++++-------
 drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++++++----------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----
 5 files changed, 25 insertions(+), 27 deletions(-)

--
2.47.3

--_000_VE1P190MB08308308E532B306FCBCAE3C801BAVE1P190MB0830EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-UA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Hi!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">The patch series looks good.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Only one thought from my side is abo=
ut consistency between prefixes for global symbols for variables and functi=
ons.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">For functions, we use the prefix &qu=
ot;nthw_*&quot;; however, the patch series uses the prefix &quot;ntnic_&quo=
t; for global variables.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Will it be better to keep the same p=
refix for functions and variables?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">If there is no strict rule, we may k=
eep &quot;ntnic_&quot;.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:12.0pt">On 26.09.2025, 19:25, &quot;Stephen Hemminger&quot; &lt;stephen@n=
etworkplumber.org&gt; wrote:<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span style=3D"font-size:11.0pt">The ntnic driver in next-net is not consit=
ent in prefixing<br>
all global symbols.<br>
<br>
Stephen Hemminger (3):<br>
&nbsp; net/ntnic: rename nt_log_ types<br>
&nbsp; net/ntnic: rename hwlock<br>
&nbsp; net/ntnic: make flow_lock local<br>
<br>
&nbsp;drivers/net/ntnic/include/create_elements.h&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;.../ntnic/include/stream_binary_flow_api.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 +-<br>
&nbsp;drivers/net/ntnic/ntlog/ntlog.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 +++++++-------<br>
&nbsp;drivers/net/ntnic/ntnic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 22 +++++++++----------<br>
&nbsp;drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----<br>
&nbsp;5 files changed, 25 insertions(+), 27 deletions(-)<br>
<br>
-- <br>
2.47.3<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_VE1P190MB08308308E532B306FCBCAE3C801BAVE1P190MB0830EURP_--
