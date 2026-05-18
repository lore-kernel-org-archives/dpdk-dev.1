Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0775CD4F51
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 07:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1552B40653;
	Mon, 18 May 2026 09:20:03 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013046.outbound.protection.outlook.com
 [40.107.162.46])
 by mails.dpdk.org (Postfix) with ESMTP id 208B040612;
 Mon, 18 May 2026 09:20:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7rsleAa2QsBeeNDbCtMJiHdnayJ6ikGrs9V6eNSbB93bIKn/Etdh96PIlLt3QMnBB7ofjp+jOA5QmBffT7sEYm2wTboKw1UunnCBsQ8v3aH96Rp5f9N0B1W+l/EZ36AQ7Wh51Sq5567tvcQiN3S6lrdoR+pZ54tCapCg8JAiqqAJmBPRQZQh115dyWhbYcjIJ7M9/FQ8WEttnJH3P7lQDdc0Zjpse/fgTvjp3+dTg3wCfndyt6oIUyTWd19N+Ntnp++j/ytyg+YCdpBRfF+NTW9q3iPiR5mBGzLGQ/6tFIZ1+9l0RFTzR0K8gM+A3jvdKRaOugeQJa2Q8YkSbvrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=VikvaSdRudYVvPA/+O2B8fuBdIpKQDfJWl0c98Cp2BkWKZsWFRv8XUR9+AncqUrPiTGLp3Bjcgu8xBiC7E3IRDCVKKOKCzlREkPwFZnY9oEtcpTgvGddkufWFa+uChdDSXda8QZqXb5L58g078zXgybq80JmK4MIAOjMwQ3DnJnX7Q8nu0KrUimfk+HJ+E6G/rc1FTlX7q6Cn2SwXLQbRyCPNYi55BrtBHAcwvqXDlTL1+yT1NuHMwcW6Wywgs7AZhA/jqO0W5BDkC1T28TAiBpqNeQE9YM+RkVbT/pRLfqX56Tcki8tewsSgnY2aPpkx2pgFK5n/ZU6796ZZRK6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=L1WhmbwoSyn03LIn59ndSz8xz10mA//RwIZ7wzMnHkKs6k5PrnbH00VoLHDbJErW68eygHqT0EY+KEAPLfm79fcT/83VpkssSDLJZhqy4Wx3fombJpgxpjLkJ4n3MHdtVY6PAk27mzLLy1DWQ/u1GTGaLrLiqBzmP4/ImVKiv0W0cbuQ1KdvPtIRiwjXpp0od65I5BHv7C6rmo+LlMZND3RE8aIx0O6dFWesKZE4Y7d5XdvfxheHQ5ZfbdZtBW+/RXqpbDi+8GA05T/T++1dcE/zpAjxz0HLqosymb1xPCrItD/CrW54Aa783RwOZHbuFdoTP6WDoo7vm2YGw6sIUA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PA1PR04MB10120.eurprd04.prod.outlook.com
 (2603:10a6:102:461::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:19:59 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:19:59 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 1/2] bus/fslmc: fix ignored return value in
 fslmc_bus_unplug
Thread-Topic: [PATCH v2 1/2] bus/fslmc: fix ignored return value in
 fslmc_bus_unplug
Thread-Index: AQHc5SRXeGFbFlY8u06lXAtc2LE9OLYTYyjw
Date: Mon, 18 May 2026 07:19:59 +0000
Message-ID: <GV1PR04MB10750BC006EC480588B01409289032@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260516110828.35701-1-shofiqtest@gmail.com>
 <20260516110828.35701-2-shofiqtest@gmail.com>
In-Reply-To: <20260516110828.35701-2-shofiqtest@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|PA1PR04MB10120:EE_
x-ms-office365-filtering-correlation-id: 723ae4ea-b2be-4db2-250d-08deb4addef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|4143699003|11063799003|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: D28wPHMoW6SRb+jQI17b+8z8qUq6H3tDz1++eJj2fovCpHRJwu4c6czUqOch5CKeisVAcrB5jh5nxN31ZkJI+/8YhE4DC1xHcz05fYWfdhAVSbD7cemxUgxdecdiZj7GvWfZLdJdNlbvfF76kSHlNawfv59BjUbSpMwp3cMeOezkXe0uaD2/R3xnpDK7y7D0fHnCqVHc37HuGI3hnzxsqrrWcjzFhtLAK8I+umlrjw2YYsuMqnktQwV6OJ3xVBfy+VIURrajnz2XUw2tat7lIPj99QuRx2bMA4rDtC17sEQDVEg3Wiy4vh19w/gKPRCtYDj3idMYE+ZeqvLATz8WGbZOlQ1sVLa0CQeklajIVlM0Eqca3LI5nHNakdwJEQ1vOscZSEC7OeK4CTjLx9Kqm2Cy24AzR8Gs3DF3mmvvDBnrqKQUWUfhRVCO4cZn1/GzYBZUrJYMxp69Rc0z1I2w6mFINWKg7GJ+pOzF+BOBZ24bexePxOvPvH30xIqL6Y437vOMRoCOcGBNFDE+hmJoSJNL0LsP7CkKMVpQ78fbqyjD3qdBqDLOVRIZGtKTC+Zgt0OOIHCRzhPpvWAlew3MhR0BNpOgQvioPJbn6LdES+PHz8nfycjhDzjZOhNJqhSjUpUBidU1c8ob2Zt70BF6uSs0nhHFsrnVxieQ3PiDh+P0W1Dqr++RdzG2dksyZeTNiel+JNGzQytrOk74w3uf7h49FagpNiVkWOtJUtLRoHiBFYtB3m01f6qf+klKEYE7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(4143699003)(11063799003)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4s+E7UQDu3liKcFoNMh7mLFYOlTEaGF7E+Bv3zuJ9WDHdjh/aOj+TepixjeY?=
 =?us-ascii?Q?sBjNsvPobOpDtbAPzDwx61wCYjApP0dkJctBoFd/oGf8ZrWT+l+AsUT3hQEH?=
 =?us-ascii?Q?ydDDzFW67zrFWA7ksIAzAuQhU0hnKPvv3qpO0MsaQ7eXhL3AQC2Jqgv3yRck?=
 =?us-ascii?Q?xfEzI43veOd8oxmSnIr5fuOG7qTopg8BBUWJgaODhoCpTDms9AcQk4c2ZszI?=
 =?us-ascii?Q?cWuIqU27mI9HnuxMoFFDAFZzmudQGdS4wVjNtyGsQl6FRx8nspKw+ebeowgr?=
 =?us-ascii?Q?JtVV28igli9/b0ii8FZoZv5BL8UWbNgC80Ywxd/mId+zNIg9p9XsmgyRRGnX?=
 =?us-ascii?Q?Ih2grdn1xRNesIyeqAoNnz9hOdSFt2U73F3TaeFh4iXTUibqBRaYKLJc7R+g?=
 =?us-ascii?Q?VWcZ9OCGK4ZtducR5Us4OTvyhyssbpeHmWbvYz7Z6lHmzR2P6Shd0VQE5trc?=
 =?us-ascii?Q?4XL4MmVl8MGdB7PMlQfu83K5q5S8SfwQC7injxLwcAGIYZppFBN0FWCcuLRg?=
 =?us-ascii?Q?vXBua3mQhRWoMHBblg/15IMrHmIyqfiRXD6VQWAGAJWSRxOT3lMJcervDi89?=
 =?us-ascii?Q?1tzEmjkeM3JkHzBZwvpofHli13pIRRBQITePBmNOX7CIJTsckjxXLS7zAy1h?=
 =?us-ascii?Q?ykaz0IYFbGn6M5ch1b3w528MflwqWMSENzFUrKFRiXp7/5wCXab5f1NLFaQ5?=
 =?us-ascii?Q?2HlxF8CUJnZvGZM5quefboV3uCMVarm6yaZUCORSgDJ80O2LY+s24LFKQQ2z?=
 =?us-ascii?Q?jYm6J5ATP4mT6kTvhmAOh5CUODqAPUdkDk6UwE8+rsyWCNYFHvQSR0pheGs9?=
 =?us-ascii?Q?k3lmzxZRYrGSyyO69MVuU6G5MRK85MFGfcDgIFSCKjJEPS7q90v/krgi4RAV?=
 =?us-ascii?Q?4gLxpXJKjPuzwb0m8XGWYhIIBrsDmf9wQn8XHzLqUYd6g0jHbkwDMdjF3reb?=
 =?us-ascii?Q?LY8mwKXXtRUV1ZG2BKFl2iaeSFZikGF+wQPd4xKACXuIXv7COw37Rm/ddT0W?=
 =?us-ascii?Q?Jm5jmn8FKPgXxvEGnK8nFvif4J2dCYGwbSEUeOjQGwllFep4mzoASwELsELO?=
 =?us-ascii?Q?mC2+xjIYMSWFAwjsvKeWY2qfg/6YUpTT1cnu/DcboAy/6DeJEe8Mq9aba7ls?=
 =?us-ascii?Q?x3rFCzaXzNT45Q/0/zZPbY+IBmQI5h0mPWTLT0IvmY3bc1lH3kAKvM2K+irB?=
 =?us-ascii?Q?+hTiMzPvUW5PszPdEgqU8//3fHCbKISgFvbk/VyRGEewEvKpJa+WWHegmnM9?=
 =?us-ascii?Q?ya+b2EEO+kf+hQ2ilwn2kY+pEo5bLJ0GHllRRlYB/uXp5FC2mXmkPl85KVP1?=
 =?us-ascii?Q?ZoQJIW93piYopWRSab6hprmzPgpDnnxMcU+P8JgZfjtWGGpoGEBMAbcUp5Vu?=
 =?us-ascii?Q?qzQJJoIcXUQxMiBanvglNtBw1th2TPg4aqIttJx0mwQYaxedpE7QENUoTHvk?=
 =?us-ascii?Q?pNiIbY0uLX336DsCyGiyQ9f8lAmXQrCja9dZvEfANF2jOWWOQ8XqIltQksAJ?=
 =?us-ascii?Q?ub5KOTciEWPDSxnqZtS5rS+bdRaOYXj11NvOYHkwgLW+DyPz3vA5DpNkL17T?=
 =?us-ascii?Q?SbX5b2Qn9v9mxVoue1Jozc93Ia1baOamzoFExAU9tdGXuyKAAO/TF50Z/5cz?=
 =?us-ascii?Q?NbE9SrkM1MwnC+Yw/r066+aSogq4uOb6auwbGa7sIGmExhBJCZ20EklFMNjH?=
 =?us-ascii?Q?L0kYlT/8cqMX2BX/zHOA7bCMm7ESSxkmI2w9WAh/MksYpGPvAZZ85oc4yTZ0?=
 =?us-ascii?Q?upr18kxZLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ae4ea-b2be-4db2-250d-08deb4addef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 07:19:59.5726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPspW5gI4mBN7sTmxe4oDWOmm56ruq+ZijJBY7yuk/FXpIFxnSSah0tGFRtFu+5VBbuyDv1jmQtNJA/AV1S+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10120
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
