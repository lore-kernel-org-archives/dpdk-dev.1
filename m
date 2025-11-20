Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF1CF8549
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 07:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AEFC4026F;
	Thu, 20 Nov 2025 08:03:44 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011068.outbound.protection.outlook.com
 [40.107.130.68]) by mails.dpdk.org (Postfix) with ESMTP id A5F9340262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:03:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpIv3/+Bor3gcBt+9lrYCti+9MVmW9WiktuK1YP93jrEHLH5MH4nzCnnt7CVjlmCnHoubUKKYKq1y8re88i7sMN8OkeWTzPqr5tyZqUk+tXUiydPA/nb6wH5m6Zj7OZjHy7Bv2ou0aB8ACIhnqAcF0jx9qbwRgshaKIGYgsI2710fUip22BlncUjcrpNcIVFDJjEVEB0dPjaEpaBQE60VfdOeg1amPBb67zlHVwPJmWx6zG1V5OVreNFN7bv1NkSI1fZiibRRBGtOkIt7eTdHgj3wHXJxUfgf8m4S5ERrJlyAbN9KThDZULYHXFdNapEuWgBPLLBe0GesGvDWdR04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNE8vfRHWSFnPR79Ia4eYix0TtpjpXubTALW7azJMYU=;
 b=w6NHAEbMg3qgBI3ier4g5IHPxby4OdN7WWpIFI3Up8zv3rEeJGUyBdbwYnzc9Rl9E8wtT+fl3T94Mc+IuXdcUZ38oBMY4HnC47IYHW6vWhPpM8xBXL6jB9Ssz/VJhC5IYTSXkBvodawFmWNGb4acm6sgrYH/MLTOOpXuHn3aCyTgny+5hCDs9yJ258Iu6tO+6KKuUqlWvCIKYAOclX315f3WzV7FUXWQaUyX3Cr2uOtL1H761Q0SG3rDGJqCLRCcPbwDN8wbs2O5BVnAdxt3I1ziuCIUt09mLXGcb3T1RYRnZjLdNLUIOEj13GBdWRjJH5DqCtzNSZu/K44N6LzDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNE8vfRHWSFnPR79Ia4eYix0TtpjpXubTALW7azJMYU=;
 b=U25nPEZOCvCKq2JfbrjbrAIVqkQSrt1W9lVSoVewqVmW0i0PqVrwahVAhvdQerzrtRWxSODY7bpot9+58tKm6lzDZ4GHhghgSPPMSzNoOjk9aAtRZ/eQe6Ejf8fQrmKvXNzx7VVlbBkJIhrVYtw3VJKipWJBRdS9X3URMEj/0rQW4ZPy9NaufczbAhllXpDIYRVNHfEhXZXO/083nU/4DXXgrA6E953IH3n54E9/0rTiQ9mOfNtH4AdVV5JPJqmXiDN2GjQ7XVYcK8Ce67+U0VdoA6GUydk8h7cehUz7Go1ZEIZ1Fk7APEEQjASmJ7FoZSOFgWr62RzOAyy5uYN2gg==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:03:41 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:03:41 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH v5 14/18] bus/fslmc: use the new VFIO mode API
Thread-Topic: [PATCH v5 14/18] bus/fslmc: use the new VFIO mode API
Thread-Index: AQHcWUTiSTGfRNu+4UW5alH97hf4/rT7JOZQ
Date: Thu, 20 Nov 2025 07:03:41 +0000
Message-ID: <PAXPR04MB93287247BE4BA6C9BC18F81389D4A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
 <ecf17757a9c0cee5ce7af14a2df444e249d1b34e.1763550470.git.anatoly.burakov@intel.com>
In-Reply-To: <ecf17757a9c0cee5ce7af14a2df444e249d1b34e.1763550470.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AM8PR04MB7809:EE_
x-ms-office365-filtering-correlation-id: 0ff605fa-be7c-4a7e-a53f-08de2802f028
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L8gx+cjZW+J3V6LCQUxCbF9NlJzzYD1hU9SQ3Y7y7DuDHkW9zyd3QU/6MsTA?=
 =?us-ascii?Q?22X/7f1SFBmGGaHrAVzv6vNxR66dD1X5QAtkr+zXLemAg+1N5C+r/Tmf1fmc?=
 =?us-ascii?Q?48pnXUSL56kv8DOk6i2qSD/c/TBjGeLeiFHzJOuCYcB+nOhFkUf02idH6DP9?=
 =?us-ascii?Q?fjyaA28J4/gV/O8kXT698rLMLc5xq07Z000N/hp0j4OtJjAdT1EtgfiM2xXy?=
 =?us-ascii?Q?qzYA2PORiqMW8vWJNle/69k8ub60BhpxkTvam7Lf1GOW1kL0VgNj5N12H3me?=
 =?us-ascii?Q?tdFMp3S5qOcWRf+8+XbwSyzjNK+SinJB5rvziB5HxHvq5Vquh3wooDft+Ecu?=
 =?us-ascii?Q?F9beEK8XiHMbOke0Mkj+NpeQj80pk3zRAoTeVZY7dyDApuuH1PTPqd3xn4BJ?=
 =?us-ascii?Q?KE2dsowYxU94KYATLfCWxR0bglJP1XH09iOOzKhwURiRDndAcoMSpu6XkHqi?=
 =?us-ascii?Q?djiRlUW6tLd3samHFV1lrylI/BETIXNOMuq4h6UkXyok7fDRK3CbiyY/Qhob?=
 =?us-ascii?Q?hfimgmZic3uWA7c7GXXGw66Munpla8H4N33206bZ8POsNN3jWH3yf7QLaHzO?=
 =?us-ascii?Q?err5hE8/irso8nAnYXkVWHDDlsA1Sme6bDqmACKjk6tkgQeGRbk/k2oAapng?=
 =?us-ascii?Q?rFzyPoEfzYCl2hWo6TzjDH4CE72q6LOSQ0sh/MTKLgs/gvO3zZyY4urmgGv9?=
 =?us-ascii?Q?wCrVwczIBOZgk/3iS8VOb9qVZqF/omoF8kyHUcmNY2X0HfkCg/vjxXZ+OStD?=
 =?us-ascii?Q?Pspe9n6dXq7cYbcdo+NHs0mFlRwAZbNP+sKoN//zZ7q8hJhrFOIk/eSOm5jx?=
 =?us-ascii?Q?HTtEsqh+RbKSTFKfZ4V3vajmAYMhXri8CFLOWgcJEEYxZhBUW8bdd15GiZ+x?=
 =?us-ascii?Q?GX3TxM3MOlEYrpd0ueP2+MVOsf0XhyoALE+sxbXe4cfWmmw6yshvjF6JL7GN?=
 =?us-ascii?Q?A1e+YdbyFbfq+IG2FRsfqpr1hLZrWTmv1lpuuJiwSXMCBIhL6C10wwMTsoaZ?=
 =?us-ascii?Q?qJ9dSZwE+/g+eHK8OPEqnA5VZFwJDWgfQIZYkGxoeRBDEghk7LF7zvssau/C?=
 =?us-ascii?Q?BA4YLrG7KAHPNhlN4oJ70s6ycdQ/FukifZ1kFuTTf3BjKGY6dwcssamlADY+?=
 =?us-ascii?Q?JyRfYH/HFKbtdi/QIkCADffWlhY0WhbDYJ50Tht0EbcSdj0wcUMmEFuW4yPy?=
 =?us-ascii?Q?e2XXV7Sx1gpOK+SNDhQNsSsELMf+ReJJHOCp5ZgWTLQDSYSghNreT2307fcW?=
 =?us-ascii?Q?bjjPsd8h5tNGdXOAtW7SebarnpCnp1XqC7SnAcf95ejERPSe6ZgcReIsSckh?=
 =?us-ascii?Q?cDTEIYgX9lqpN32bFaJ6s4cZjNJ3HwCJzX1VLQsJwCvrWVgcXwqBApMyQfBm?=
 =?us-ascii?Q?WM4livB2USAd8lVE/Rjh9Q0h0QTk55N/jj3Z8mdQS+XgtoJpPX41jAdlS5MH?=
 =?us-ascii?Q?eB3Jf0HwEQMbdWMZHwJPbs2CrZsA3t2lEeDBiBcXC5zPk4H1uO3Pg6+b793P?=
 =?us-ascii?Q?LxP6nYl4CPMjVy3Y81KopeazQarfXAIaAOpW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7nhV329GQmr05I2RY/cGtNB6u5nCguOthH0Pe+EyfSWy/CfhMWg2dAPdaT1h?=
 =?us-ascii?Q?SazaCEyrkBDg9l6S272vtYEYDZ9uGoaNh8CnWx5HVP6+33Co48en/7WwtkEp?=
 =?us-ascii?Q?cM7vvmh2mE8fvNiY5huWShTYAuSaFJW/zrG9qTweJ88GfUPb95OrMLJk1buY?=
 =?us-ascii?Q?5iJHA5R+D7x6kVQ9Hl2DHVbdg9KD9fGzGtzyo0Kp17weUX2s33Vp5ZJvMJEu?=
 =?us-ascii?Q?pixm75H5dpx/ftT2PvRLptjgHuxWhade/IDCdMCows59CGoIn6aOVVUye5Aj?=
 =?us-ascii?Q?+qnelwyLJFG73+eNhVjp+D3sj6/bo7q6TnwiQqAEMChecdtXYl/kIVokmjlP?=
 =?us-ascii?Q?Cv+ZNb1lAd/KBQ5ABq+9M5MlWCkYVqL5jdlo4RgQel3ncziupCNgTvXIzHSl?=
 =?us-ascii?Q?EAkacXkUUSnEmeyHdOco51Co+dNTT667mZswxT2rnJE7luJ/XpQB96YAZDRv?=
 =?us-ascii?Q?Cv04zk/KYM1ry89sgX6nP+PogibkWOHzkmFS+LsP9ZDVDnjdaGFp9IoOGXy8?=
 =?us-ascii?Q?rCWPqEfNNbIYQ+E6ZAFMHAv9YMXUMVNHdk3aGdPgC7YbcIncCcPlvjzKOgvu?=
 =?us-ascii?Q?zYugIOWxQBMd55fYp/thALrnZvd1G6iZRroS/hlNJ92J4yn9Lmn4tFtcbYfg?=
 =?us-ascii?Q?S2i+aghHlvA/pT6gD1wtB9ET2JLbt8O0JQT+1zwzTd9ucyuQq281UpEW6KDn?=
 =?us-ascii?Q?wnLFLFveLC5It1+ZFKeQJFnn+BrTX+d++DFZ4xyM/8RwRCM2Ya4OjvgcImy0?=
 =?us-ascii?Q?m5amvA6YTSR33qdgCtEWXSvc+1Rs1u8vzuLxb5GIwSbIC9scqiYzbFIVtPwK?=
 =?us-ascii?Q?r88CCzEpVLXeY9RtbJ06VZjkXgMK5+ZYUNhpbSNPYKU70NHCxpLn6+dGo2fD?=
 =?us-ascii?Q?ul3rANsZ/BqYeUQKSj8C1Yktow+qYNlAo/nXfnVmJgs8vRDBhiCpvhhKoigY?=
 =?us-ascii?Q?v8T/NwhXZY1T8IApfOE9BCJejAzO3hwEHMF4ZlR+uu4jr5hUGFet+WsVLUxF?=
 =?us-ascii?Q?qRQj+KcoiycYyvq1LD7r6pJBUiEyB5tP2p4XEJVPqR2Hd7Sbl3U7d5oJZQ97?=
 =?us-ascii?Q?u+ceEJcH60nIwHZBn8TCM6gbp8SEusYNusrZQdJ+v5+Sbts1X/TPphSoq43/?=
 =?us-ascii?Q?l8M2OWqptpIKdR3YlNXm6I46eOpBXAOpmFbwC2sfjU0A2rqKjVw5rDY0n9M+?=
 =?us-ascii?Q?OLnNbacxnU3MxXFw7STOhkO3FNdMY4ac+e+ZeZ1vNIiswx/vhjID2xwAHXh4?=
 =?us-ascii?Q?MTzf9Td7q6U4XshNppqfHBTt7DtFH8XLA5Nk/mwje+/CvaKGTjGZidE1rnuC?=
 =?us-ascii?Q?9XyF2cd4v1y/UNm9Q491vLIAXb2DEjvRKxKbsnw7F1pGBgm7511zV+TSZ+GW?=
 =?us-ascii?Q?uhG8yY+EFjZd5sfbN1aAbraGoyKO0Yrzdu9SodYyTl9KBrykw39otoj3CEtF?=
 =?us-ascii?Q?/RIVO1fdfkyWLO0YDgxKdZ0hBNpfQIh4Ra63anZ0kH8nZ6bOzXaYUZMgW5Mf?=
 =?us-ascii?Q?b8yuWN0xjP4YK1jp28Uexdu6QflrOYi1V/KF+EAl4ZdXbHqcPUZ76vhySy0F?=
 =?us-ascii?Q?PuutA3N/tPXVrPU/+DswNyzoK2moA9okdEC3c/xk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff605fa-be7c-4a7e-a53f-08de2802f028
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:03:41.7262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNsTncTf6e4fYNK/1KAP/RfN7dAqfE17w7ebt/UjJofgOEnr9S96WWwdCUfgS44YcVac/oVNV7OZa55GjhozRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
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



> -----Original Message-----
> From: Anatoly Burakov <anatoly.burakov@intel.com>
> Sent: 19 November 2025 16:38
> To: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin
> Saxena <sachin.saxena@nxp.com>
> Subject: [PATCH v5 14/18] bus/fslmc: use the new VFIO mode API
> Importance: High
>=20
> FSLMC bus only supports operating in group mode, and relies on no-IOMMU
> mode checks. Use the new VFIO API's to query no-IOMMU status, as well as
> protect the bus from initializing in non-group mode.

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
