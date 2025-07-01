Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F2EC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:48:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32E9940269;
	Tue,  1 Jul 2025 12:48:36 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id D659B400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 12:48:33 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11022134.outbound.protection.outlook.com [52.101.71.134])
 by mx-outbound47-35.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 01 Jul 2025 10:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtS1Zo3bxIWFSwimzx8gL7heizkw40zE9kgaWPke8nHsA7FaQIWvft9C10yURkUpKIrjxRF87FaRgU/YBh0E/Jw91JO24dCxThWeuCbwS1F7nEolAkRLjAa8iMh0gVIuF4J+JJ9ha9Y2IgCp/zPPWTSvG05CwD3IdHWP42nbI8X6xFZ9f6whBOugLjSJ1LtQcRhXNi6NglZEfCkfTekcXJ2rpIp6M9f+T76tik6ExAMSJcFwCOqcEUwi41kaAtbXP9mByYRQpac1VhAumHtN2EDbSzRDvo9J2FPgkg2tpNqC61ln3hoVsh4wJnv8eNsujNqxzaZ0+Jv1QVVAJGAwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7Xo3Qd19DzIiftzHfRZQ1+bihmakHwxgtx80lKK5+s=;
 b=qd2brJhLbwz3YRF2s5+KBcV6zWdWIt+uIduHML+lG+85j/B3LYLNNw0CBDEd4IoVENMS7GAxkm0thXqAmyhQpQpIfMIJoIhD/GPvySMxzG98M/54pQgp67u5oeCjLjxgPFHkzSb1D8Hz6wM2qZsRGR5kg5kQATsWnNcrou4aG6yERNHgULkKFy7FUlSazL7eq3Qj2i7tzzVe6F/tLWJuDVhx03SmuHT0/H5h8OnQR0jWzynwLRFVxdqHVfwvCtW28QKTV0OsQNKEgd0dUMdHqiYDVnHWYkPsbgjfU5PUb1kR19PF6HYB1XzN4FjMmrfpcNg0U0V3m85feDOTu290Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Xo3Qd19DzIiftzHfRZQ1+bihmakHwxgtx80lKK5+s=;
 b=Nahbb+uYHQeoOAqEHszazgUmjR8wUKaV7FY8vggCizcb6bajXERVxfzHBshV8KgOTRNOz63VmFfr1afpmkoyZBPuMo/Kn7BOz16+PAmO0go+r8KIMQ6aDV0hih9GKr6FqKhDb1Tu39D+wuzI0kPcLR4YX7TWR1kuQEIGjwvAQp8=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by VI0P190MB2233.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:26b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 10:48:24 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 10:48:24 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Oleksandr Kolomeiets
 <okl-plv@napatech.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v1 0/4] net/ntnic: implement start, stop and deferred
 start for Rx/Tx queues
Thread-Topic: [PATCH v1 0/4] net/ntnic: implement start, stop and deferred
 start for Rx/Tx queues
Thread-Index: AQHb4dZPNZNSSw7NSUOkLm9/BiGhLrQZMiyAgAPzM0g=
Date: Tue, 1 Jul 2025 10:48:23 +0000
Message-ID: <VE1P190MB0830A9B6C3BADBFC05E052A48041A@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250628152059.36574ba5@fedora>
In-Reply-To: <20250628152059.36574ba5@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|VI0P190MB2233:EE_
x-ms-office365-filtering-correlation-id: 9eea1b81-c923-4834-49f7-08ddb88ccd85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yRWZRuMxfiBmObjVkxcaRFXv5g9nnLt39ogLktcI0qvtveBRj9UGkPfUwnRt?=
 =?us-ascii?Q?h2UAldm1U3s4y/vCsK1+p3FUtl8Bq7IEZ8K/35kj6hI2Zr6ZV8wenPEIB94f?=
 =?us-ascii?Q?Jb6wInQ2gkyrHo9xX+QaOFoufT8TC2ut30yMIeJj0pTcU1tvgz+6hW7MOhK+?=
 =?us-ascii?Q?mEZo1ujEaUP4nwFpZVMztQfTLl6GOLv9Skdml1hIz2jwQNdBK4UZLK5mJW6G?=
 =?us-ascii?Q?GdGika2ZdxQ2HhRZlICmM4/bF064p6vttdPmUJbBTuZeb3PZgF+9PYKyf2Cr?=
 =?us-ascii?Q?wdkcyfu0so6w9JZhpRlK4h/TFvmefKqoDxpDqx3lYnQU5oVADyHKH3tKaeJq?=
 =?us-ascii?Q?sugQyuqZA4OZ9xQMtgN6LrrpcQW+moDnc5P7jJJdSNML+qAVemvvSzgFSoMT?=
 =?us-ascii?Q?0sQMQpaERUOsBnPL2OzelMWyTNckFGXDdWKoJsN4fKM8K4ZVjyfdnsos4Kw/?=
 =?us-ascii?Q?JUMjJwqdhID3jS691aPpim64z1W/nlZ2892tnwL7ZsHtpBry5Y587pM0UTAE?=
 =?us-ascii?Q?aNhB8QbfZvl9MXk6jJjWQhtPF4i//a5Krf3fYIvzQkOn8hx4hn21yQ3RyPEC?=
 =?us-ascii?Q?8pT9pOhqbqAR+oIK8GmC2h3CTO1bi5NvyakYF1PEEeQyIGLO9nyCxjht5o8h?=
 =?us-ascii?Q?o/UDgZAFTruCFb2BWhzPti9OO+BDSJIgH0ViXKNbxDvQyrhRIZnaECvVLyJc?=
 =?us-ascii?Q?irelPN/RCyCFZh5I1ye2alVxPx4vsmkTx7iqN9BE6Tdr7M++efgqYK4/beOk?=
 =?us-ascii?Q?yAGpfL4xQQpvT8jEVDuQ5TpRYBomZe5c3PPI373Q4OPgqfU8rVZwo2UJCMJe?=
 =?us-ascii?Q?O51nbQeJkcANLTD4kiaFznyhXhb0tO7kJOQkkXoIbp387R/0vkg1walo4HyG?=
 =?us-ascii?Q?0PIUiOfJpCd0d6on/pqVX/L+CRRHsS7nS5FwTsZrS8Upu/1I6bOh+suWd5sd?=
 =?us-ascii?Q?Kfnmq7lSN+VmXRiiOlZNz7bW3ousdGCofW9iP72IBiGLw/EQreiXnznSone7?=
 =?us-ascii?Q?dgnUq0/EOKS/2+RkRtRtbwYl1+nmYJ5VaJBF398g9wt09/62aBi+mXsLfi84?=
 =?us-ascii?Q?5OxnJaNAcBKXo3rRhPRIV/6puSwgWPyvsD4H7cjKTfipvcwSF1P+PxPuGS9u?=
 =?us-ascii?Q?ElIyQ1LtxquZO2Shnh47s4uGkt3Iuz+3o8dnQ5sl3LameBI+VUiXLe2NzT7b?=
 =?us-ascii?Q?m1pbDjCx4ckHy12UqYlubJ0eqySxoTNqVZCJkSjCVLFclZRXW0+/8tOFhiRB?=
 =?us-ascii?Q?njytRsObz7KrKo96aQrV7XANH3dVMxDqbWvIhDQfYtSmsGOlTQ66rOTrW6N9?=
 =?us-ascii?Q?4bVfoD0ZFNzsMcBXNSKs8cFdzMpBaB6oJCPFyBc9tommbGTNbp1pPsnguwfm?=
 =?us-ascii?Q?JDUm/cBo8BGyd2MxWb88OU0sxB6R7sEgy38MUoxv2PmndPQdUkX9GKXwBGOt?=
 =?us-ascii?Q?2wwy9iyKrbwGSpDiUa0IQ7uQFsso2wKO86OEI+viBVjdgU1VUw+JVE6YHQsp?=
 =?us-ascii?Q?k0tBYkMddv1OXW4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9M+Zw8BedwePNPz8tJKGSY1kv4GkN0utUItB0oOYdyaeXGgoDodXNppWOUx?=
 =?us-ascii?Q?z+Qtnb8b0oZJv2+I/AOiKmGc7MIMRGG+YCRWuYTx+vIwWZzOP3vXiwFpaxxo?=
 =?us-ascii?Q?GAcR9iA1mdi5xpY3nSGDV8BtmpJthccOtzEts3edp5rIGGYUcm++dRxFn7wv?=
 =?us-ascii?Q?T41ILApj2mh/kJUURTzzAW2R/zUJ0adO+fStfgHLIEs9NyskR5aHssgYOC5A?=
 =?us-ascii?Q?QuJhmBFp2l0dniX8bLelnBwMX3K/pNZFc8zFeGtlQlMkzNqd+OylIPGurtpA?=
 =?us-ascii?Q?TazF0Xxl3xjbRmkk1dTSvWn9fTrKUoypS7xe3su+kYSubIWjv2p7evbauSFk?=
 =?us-ascii?Q?Zj8Zq7nQl+7H+jTipck9HLX29JzM9OAnoLtJBkW7VZYXyfrCTq3jZi+iiBaZ?=
 =?us-ascii?Q?Y/AaO3H7XBSkf/r2OhS29repVnGbYmHqhACptlZbJZcum+37OmQtdy/TRtGg?=
 =?us-ascii?Q?I6v6Dv3qq+Uk5QiW5HH18zAoUYoXHjvMp+bcrowYU1vDT8/UKjVcuvijLD7P?=
 =?us-ascii?Q?gSyKPYshbQ5eBm3DgFH0174EvwpGOPKFGzxXHJDOzwjqpRYoINYAbyG2jtuj?=
 =?us-ascii?Q?2ZVc5Gl4VRZTecQnMbf551pFepp3YTTUjSxp+em275gNOlnqDLUpAi0zKma0?=
 =?us-ascii?Q?Tz4Gkg/tYR19QVSrNHJbftq2kWjGz17jdKg1dp0K3ai6dV0UZFMp2Ewkill8?=
 =?us-ascii?Q?O6VcTjKd0xjZBABX0hYa8cZHbzBgBus93xDK36txO9ONKDEJl3cu6neVUHl7?=
 =?us-ascii?Q?pxy2hd9s4MRMp+VLogMusUlS9+8Yw5YhuN1Z6Wes4r8ekkhOqoACZlWoftb9?=
 =?us-ascii?Q?/DW6xuNXw3N3GGe0vp8OE1vdM6ILBh/4Ucub4bARtNTFXpX9QOHNuOSLK6mX?=
 =?us-ascii?Q?mOPVwjwG+BfNlk74pe79fyafWLiEYIXeEKcBP36kVd6ZOGgZPSGsMcMT6xTi?=
 =?us-ascii?Q?+CHYzQZIUU58eq8QZuNVFrdMPdlt4M0g5B43DEHlQYdWRVQ9thYo7euBJDBC?=
 =?us-ascii?Q?UozGztLLAEVYLTR6vTT2huPnYl66cZsC6OFtTeMIUq9LTYTvxC4Hm7bEdaNp?=
 =?us-ascii?Q?/glh1Hu+pbet1gPSvflg2mJZiNAGWZQFiadU05qt0JIm18D4A2ZDtVcYfkj5?=
 =?us-ascii?Q?1yF09e4BxJmyWF1dwgkEeZHb4M2jllFylDKPUJNtDDbHG+nDd01hf2GLS3RM?=
 =?us-ascii?Q?6U0yKffuhtC5xPBDPxbIuWRH1jmE2iO1mH0pPI2y5SKWRUi//UxWW/897+OR?=
 =?us-ascii?Q?85+CxnJUp+4VhY48wXcMxlibC7gMieJdp42j1nmHd+yyFGbE95TZR8LXqMRh?=
 =?us-ascii?Q?nwBLLj+SQBCCbHxTr+63x6/8D5XyQ96YjjVRZP6KnaIv4RfEKO20FTMdO8Sm?=
 =?us-ascii?Q?FHpjszTd4Ne60O0nNRQUcwFlvDtqKex1FCySEtzn24m4BKLvmGd7613TnxYQ?=
 =?us-ascii?Q?Vp+TqwIAetzZrEvj8nxy+rQGXzbaEjMiPJ32wUfXA0kHkmM5uHzuEwaVOeZL?=
 =?us-ascii?Q?8UbyI5+tB57rGUNm/ANIXV2hYa3w+vRDqs51vjGSUnj740a0Xq1EJv+hYWpv?=
 =?us-ascii?Q?e/fSMNO2UDCFYl3RkgjdcQ9DDUzllOHePqAlVBFs?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB0830A9B6C3BADBFC05E052A48041AVE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nux3z/3sZHW+WjgfcA2Mn8XxQjS5c5kbQoy8fK1mISyh5+RShTu+JLHH0jmlOeyNT8HOMx87ZFb2ArmWZT+TvoF/BsMSRsU+9C9EUywe9JrS9Y1BMcH+0l/RhSpqsLL+kudVUNeH+M4R332MtBhZM3Wy9LanrvY/uj14xCW2979JRiATVuv/gsgtETTQS35X4PFUxNUy/W+NprrVLbnVdbIxlE18aYmPg52NbEtm2bYMk9GXLXOzD7X9R0WTHB2PI8MgFxHZxcfgRYR+mZcBL4ejQYBI07ct59R0Dx/8iDg3U5X0mTCOG8NIbxtWdLAuvA4i4UdGU5HzknGEIboF1yvkuLUhFYgglG22koE61Cp771nW6wkPqo+4jNhf1hwttSzkwEP4+xjKfTFO5VtubzEIeU3YI8MSYgbTxoL22c8hPUSlYcpU8GdKhEqiRBKZbONviOodFlUlw6FbjFXZ7tt6awoN1syKzkKFNKWNDhOem0Y8Msv+V2dYX32LPmj6VrRUWpQuYC0kp433fowcNpI1pAwmzA/2iKIi2sKeEHsnZh8d3uo4tf9fISxMJy0apU+aVNDYxOg3zrO9AxmbhV2m8up/dEEP6QCkgp2mKfggt9BaRSt0kkNBZ/Vc08W6c2I5yYKe15RcEOSaLfgtKw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea1b81-c923-4834-49f7-08ddb88ccd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 10:48:23.9400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWc9FnweK0YwlkT0Dr0FfEU364+GlK4vsGtSpwq2asYx6mMbGgrHtsSrsWY/1jcpDW8445Gpo3e4G06EBFRtaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2233
X-BESS-ID: 1751366907-312067-7654-3570-1
X-BESS-VER: 2019.1_20250616.1856
X-BESS-Apparent-Source-IP: 52.101.71.134
X-BESS-Parts: H4sIAAAAAAACAzXMsQ6EIBAE0H/Z2uIW2B3wV8wVwEpsLhZSmBj/XYqzmUwmk7
 dctJ6dZuojJ9oPmkUgbtRtrOaRQpEsgEnU2FoFhFvkYFoYdE8vsPXfH1AX0gukcQ815W
 b+w+Coa80ZXL2hSFFH9/cB0X3TK4MAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265646 [from 
 cloudscan21-210.eu-central-1b.ess.aws.cudaops.com]
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

--_000_VE1P190MB0830A9B6C3BADBFC05E052A48041AVE1P190MB0830EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for noticing it. We will take it into account and address the issue.
________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: 29 June 2025 01:20
To: Oleksandr Kolomeiets <okl-plv@napatech.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Mykola Kostenok <mko-plv@napatech.com>; Se=
rhii Iliushyk <sil-plv@napatech.com>; Christian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v1 0/4] net/ntnic: implement start, stop and deferred s=
tart for Rx/Tx queues

On Fri, 20 Jun 2025 13:27:03 +0200
Oleksandr Kolomeiets <okl-plv@napatech.com> wrote:

> This patchset includes:
>
>        * feature start/stop queues on HW layer.
>        * feature deferred start for queues.
>        * Improvement for memory mappings when IOMMU is unoptimized.
>        * Improvement for logging
>
> Oleksandr Kolomeiets (4):
>   net/ntnic: implement start/stop for Rx/Tx queues
>   net/ntnic: implement deferred start for Rx/Tx queues
>   net/ntnic: unmap DMA during queue release
>   net/ntnic: add warning when sending on a stopped queue
>
>  drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  58 +++++---
>  drivers/net/ntnic/include/ntnic_dbs.h         |   2 +
>  drivers/net/ntnic/include/ntos_drv.h          |   4 +-
>  drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |  20 +++
>  drivers/net/ntnic/ntnic_ethdev.c              | 132 ++++++++++++++++--
>  drivers/net/ntnic/ntnic_mod_reg.h             |  14 +-
>  drivers/net/ntnic/ntnic_vfio.c                |   3 -
>  7 files changed, 193 insertions(+), 40 deletions(-)
>

Unrelated to this patch, this driver does not follow the convention about
naming external symbols. Since DPDK can be linked statically, and C does no=
t
have namespaces; the same symbol in two places can be a problem.

The common practice is to use a common prefix for all globals in a driver.
In this driver that would be ntnic_

Doing a debug build (so symbols are visible) and running nm to display
global symbols gives:

$ nm librte_net_ntnic.a | grep ' [TD] '


0000000000000cf8 T nthw_adapter_init
00000000000038ca T nt4ga_stat_ops_init
0000000000002a11 T nthw_sg_init
0000000000002094 T nthw_link_100g_init
0000000000000000 T link_agx_100g_init
0000000000000432 T nthw_port_init
0000000000001bb4 T nim_agx_read_id
00000000000019f6 T nim_agx_setup
0000000000001781 T nthw_construct_and_preinit_nim
000000000000099b T nthw_nim_id_to_text
00000000000009f4 T nthw_nim_qsfp_plus_nim_set_tx_laser_disable
0000000000000976 T nthw_nim_state_build
00000000000018c1 T nthw_qsfp28_set_fec_enable
000000000000186c T nthw_qsfp28_set_high_power
0000000000000d59 T nthw_create_action_elements_inline
0000000000000a75 T nthw_create_attr
0000000000000b16 T nthw_create_match_elements
0000000000003455 T nthw_dev_flow_init
000000000000346b T nthw_dev_fp_flow_init
00000000000000a9 T nthw_interpret_raw_data
000000000000343f T ntnic_filter_init
0000000000000d7e T ntnic_xstats_ops_init
0000000000000039 T dbs_init
00000000000011a3 T dbs_reset
0000000000000000 T nthw_dbs_new
0000000000003470 T nthw_dbs_set_tx_qp_data
00000000000017e5 T nthw_get_rx_idle
00000000000015d9 T nthw_get_rx_init
00000000000018cf T nthw_get_tx_idle
0000000000001703 T nthw_get_tx_init
00000000000013a8 T nthw_set_rx_control
000000000000176d T nthw_set_rx_idle
0000000000001519 T nthw_set_rx_init
000000000000145f T nthw_set_tx_control
0000000000001857 T nthw_set_tx_idle
0000000000001c88 T set_rx_am_data
0000000000001cfb T set_rx_am_data_enable
0000000000002eb1 T set_rx_dr_data
00000000000024e1 T set_rx_uw_data
0000000000001fd8 T set_tx_am_data
000000000000204b T set_tx_am_data_enable
00000000000032f0 T set_tx_dr_data
0000000000001643 T set_tx_init
0000000000002a9a T set_tx_uw_data
00000000000048e0 D nthw_fpga_9563_055_049_0000
0000000000004820 D nthw_fpga_9574_055_049_0000
0000000000000000 D nthw_fpga_instances
0000000000000000 D sa_nthw_fpga_mod_str_map
000000000000001a T clk9563_ops_init
000000000000028a T nt200a0x_ops_init
00000000000008f8 T nt400dxx_ops_init
0000000000000acf T rst9563_ops_init
0000000000000dc8 T rst9574_ops_init
0000000000001b75 T rst_nt200a0x_ops_init
0000000000000f30 T rst_nt400dxx_ops_init
0000000000001433 T get_nt200a0x_ops
0000000000001467 T get_nt400dxx_ops
0000000000000431 T nthw_fpga_avr_probe
0000000000000000 T nthw_fpga_get_param_info
00000000000001fc T nthw_fpga_iic_scan
00000000000009ce T nthw_fpga_init
00000000000013e5 T nthw_fpga_shutdown
0000000000000942 T nthw_fpga_si5340_clock_synth_init_fmt2
00000000000002a4 T nthw_fpga_silabs_detect
000000000000141d T register_nt200a0x_ops
0000000000001451 T register_nt400dxx_ops
0000000000000000 T nthw_gmf_init
0000000000000551 T nthw_gmf_set_enable
000000000000058d T nthw_gmf_set_enable_tsi
0000000000000000 T nthw_gfg_init
0000000000000eff T nthw_gfg_stop
0000000000000373 T nthw_tsm_get_time
0000000000000309 T nthw_tsm_get_ts
0000000000000039 T nthw_tsm_init
0000000000000000 T nthw_tsm_new
00000000000004f3 T nthw_tsm_set_config_ts_format
00000000000003dd T nthw_tsm_set_timer_t0_enable
000000000000042d T nthw_tsm_set_timer_t0_max_count
0000000000000468 T nthw_tsm_set_timer_t1_enable
00000000000004b8 T nthw_tsm_set_timer_t1_max_count
0000000000000000 T nthw_gpio_phy_init
0000000000000408 T nthw_gpio_phy_is_module_present
000000000000045a T nthw_gpio_phy_set_low_power
0000000000000507 T nthw_gpio_phy_set_reset
0000000000000039 T nthw_hif_delete
0000000000000d57 T nthw_hif_end_point_counters_sample
00000000000009f4 T nthw_hif_force_soft_reset
0000000000000a5f T nthw_hif_get_stat
0000000000000b84 T nthw_hif_get_stat_rate
0000000000000054 T nthw_hif_init
0000000000000000 T nthw_hif_new
0000000000000db3 T nthw_hif_read_test_reg
0000000000000d0b T nthw_hif_stat_req_disable
0000000000000cbf T nthw_hif_stat_req_enable
0000000000000a34 T nthw_hif_trigger_sample_time
0000000000000ead T nthw_hif_write_test_reg
000000000000004e T nthw_i2cm_init
0000000000000015 T nthw_i2cm_new
0000000000000bb4 T nthw_i2cm_read
0000000000000c1f T nthw_i2cm_write
0000000000000c85 T nthw_i2cm_write16
0000000000000039 T nthw_igam_init
0000000000000000 T nthw_igam_new
0000000000000223 T nthw_igam_read
0000000000000325 T nthw_igam_set_ctrl_forward_rst
000000000000029f T nthw_igam_write
000000000000129b T nthw_iic_bus_ready
0000000000001323 T nthw_iic_data_ready
0000000000000a86 T nthw_iic_delete
00000000000003e7 T nthw_iic_init
00000000000003ae T nthw_iic_new
0000000000000d60 T nthw_iic_readbyte
0000000000000b34 T nthw_iic_read_data
0000000000001475 T nthw_iic_scan
00000000000013ab T nthw_iic_scan_dev_addr
0000000000000aa1 T nthw_iic_set_retry_params
0000000000001083 T nthw_iic_writebyte
0000000000000f36 T nthw_iic_write_data
000000000000180c T nthw_mac_pcs_get_fec_bypass
0000000000001858 T nthw_mac_pcs_get_fec_stat_all_am_locked
0000000000001832 T nthw_mac_pcs_get_fec_valid
0000000000002184 T nthw_mac_pcs_get_fld_block_lock_lock
00000000000021a2 T nthw_mac_pcs_get_fld_block_lock_lock_mask
00000000000021b3 T nthw_mac_pcs_get_fld_lane_lock_lock
00000000000021d1 T nthw_mac_pcs_get_fld_lane_lock_lock_mask
00000000000014ee T nthw_mac_pcs_get_hi_ber
0000000000001514 T nthw_mac_pcs_get_link_summary
0000000000000000 T nthw_mac_pcs_init
0000000000001279 T nthw_mac_pcs_is_rx_path_rst
00000000000014ad T nthw_mac_pcs_reset_bip_counters
00000000000018e1 T nthw_mac_pcs_reset_fec_counters
000000000000168a T nthw_mac_pcs_reset_required
0000000000001224 T nthw_mac_pcs_rx_path_rst
00000000000016ff T nthw_mac_pcs_set_fec
0000000000001a12 T nthw_mac_pcs_set_gty_tx_tuning
000000000000129f T nthw_mac_pcs_set_host_loopback
00000000000020d9 T nthw_mac_pcs_set_led_mode
00000000000013a6 T nthw_mac_pcs_set_line_loopback
000000000000216a T nthw_mac_pcs_set_port_no
0000000000001cda T nthw_mac_pcs_set_receiver_equalization_mode
0000000000001016 T nthw_mac_pcs_set_rx_enable
0000000000002119 T nthw_mac_pcs_set_timestamp_comp_rx
000000000000116a T nthw_mac_pcs_set_ts_eop
000000000000106b T nthw_mac_pcs_set_tx_enable
00000000000010c0 T nthw_mac_pcs_set_tx_sel_host
0000000000001115 T nthw_mac_pcs_set_tx_sel_tfg
0000000000001fc1 T nthw_mac_pcs_swap_gty_rx_polarity
0000000000001ea9 T nthw_mac_pcs_swap_gty_tx_polarity
00000000000011cf T nthw_mac_pcs_tx_path_rst
0000000000000039 T nthw_pcie3_delete
0000000000000a77 T nthw_pcie3_end_point_counters_sample_post
000000000000085b T nthw_pcie3_get_stat
000000000000091d T nthw_pcie3_get_stat_rate
0000000000000054 T nthw_pcie3_init
0000000000000000 T nthw_pcie3_new
0000000000000818 T nthw_pcie3_stat_req_disable
00000000000007d5 T nthw_pcie3_stat_req_enable
00000000000007aa T nthw_pcie3_trigger_sample_time
0000000000000082 T nthw_pca9532_init
0000000000000049 T nthw_pca9532_new
00000000000000d3 T nthw_pca9532_set_led_on
0000000000000092 T nthw_pcal6416a_init
0000000000000049 T nthw_pcal6416a_new
000000000000027e T nthw_pcal6416a_read
00000000000000e3 T nthw_pcal6416a_write
0000000000000262 T nthw_pcm_nt400dxx_get_ts_pll_locked_latch
000000000000023f T nthw_pcm_nt400dxx_get_ts_pll_locked_stat
0000000000000039 T nthw_pcm_nt400dxx_init
0000000000000000 T nthw_pcm_nt400dxx_new
0000000000000285 T nthw_pcm_nt400dxx_set_ts_pll_locked_latch
00000000000001fb T nthw_pcm_nt400dxx_set_ts_pll_recal
0000000000002868 T nthw_phy_tile_configure_fec
000000000000241a T nthw_phy_tile_get_link_summary
0000000000001a43 T nthw_phy_tile_get_no_intfs
0000000000003130 T nthw_phy_tile_get_port_status_reset_ack
0000000000003187 T nthw_phy_tile_get_port_status_tx_lanes_stable
0000000000002616 T nthw_phy_tile_get_rx_am_lock
00000000000025e2 T nthw_phy_tile_get_rx_hi_ber
0000000000003221 T nthw_phy_tile_get_sys_pll_get_rdy
00000000000032de T nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled
0000000000003259 T nthw_phy_tile_get_sys_pll_system_pll_lock
000000000000269d T nthw_phy_tile_get_timestamp_comp_rx
0000000000000039 T nthw_phy_tile_init
0000000000000000 T nthw_phy_tile_new
00000000000026e8 T nthw_phy_tile_read_eth
00000000000024fc T nthw_phy_tile_read_fec_enabled_by_scratch
0000000000001d0c T nthw_phy_tile_read_xcvr
00000000000022d7 T nthw_phy_tile_set_host_loopback
00000000000033b0 T nthw_phy_tile_set_port_config_rst
000000000000229c T nthw_phy_tile_set_rx_pol_inv
0000000000001adc T nthw_phy_tile_set_rx_reset
0000000000003291 T nthw_phy_tile_set_sys_pll_en_ref_clk_fgt
0000000000003363 T nthw_phy_tile_set_sys_pll_force_rst
0000000000003316 T nthw_phy_tile_set_sys_pll_forward_rst
00000000000031d4 T nthw_phy_tile_set_sys_pll_set_rdy
0000000000002649 T nthw_phy_tile_set_timestamp_comp_rx
000000000000234e T nthw_phy_tile_set_tx_equalization
0000000000002261 T nthw_phy_tile_set_tx_pol_inv
0000000000001bf3 T nthw_phy_tile_set_tx_reset
0000000000001a1b T nthw_phy_tile_use_phy_tile_pll_check
00000000000027a3 T nthw_phy_tile_write_eth
0000000000001e0f T nthw_phy_tile_write_xcvr
0000000000000039 T nthw_prm_nt400dxx_init
0000000000000000 T nthw_prm_nt400dxx_new
0000000000000173 T nthw_prm_nt400dxx_periph_rst
00000000000001aa T nthw_prm_nt400dxx_platform_rst
0000000000000082 T nthw_pca9849_init
0000000000000049 T nthw_pca9849_new
00000000000000b8 T nthw_pca9849_set_channel
00000000000003c8 T nthw_si5156_init
000000000000038f T nthw_si5156_new
0000000000000419 T nthw_si5156_write16
00000000000001b8 T nthw_si5332_clock_active
0000000000000167 T nthw_si5332_init
000000000000012e T nthw_si5332_new
000000000000030c T nthw_si5332_write
0000000000000262 T nthw_rpf_administrative_block
000000000000029e T nthw_rpf_block
000000000000004e T nthw_rpf_delete
000000000000037c T nthw_rpf_get_maturing_delay
00000000000003e4 T nthw_rpf_get_ts_at_eof
0000000000000069 T nthw_rpf_init
0000000000000015 T nthw_rpf_new
0000000000000345 T nthw_rpf_set_maturing_delay
00000000000003aa T nthw_rpf_set_ts_at_eof
00000000000002d2 T nthw_rpf_unblock
00000000000003f6 T nthw_rmc_block
0000000000000392 T nthw_rmc_get_dbg_merge
00000000000003c4 T nthw_rmc_get_mac_if_err
0000000000000360 T nthw_rmc_get_status_descr_fifo_of
000000000000032e T nthw_rmc_get_status_sf_ram_of
0000000000000039 T nthw_rmc_init
0000000000000000 T nthw_rmc_new
0000000000000444 T nthw_rmc_unblock
0000000000000039 T nthw_sdc_delete
000000000000034e T nthw_sdc_get_states
0000000000000054 T nthw_sdc_init
0000000000000000 T nthw_sdc_new
0000000000000569 T nthw_sdc_wait_states
00000000000003f7 T nthw_si5340_config
00000000000005a8 T nthw_si5340_config_fmt2
00000000000000b3 T nthw_si5340_delete
0000000000000039 T nthw_si5340_init
0000000000000000 T nthw_si5340_new
0000000000000447 T nthw_spim_enable
00000000000004d5 T nthw_spim_get_tx_fifo_empty
0000000000000039 T nthw_spim_init
0000000000000000 T nthw_spim_new
00000000000003fa T nthw_spim_reset
00000000000004a7 T nthw_spim_write_tx_fifo
00000000000004ea T nthw_spis_enable
000000000000054a T nthw_spis_get_rx_fifo_empty
0000000000000039 T nthw_spis_init
0000000000000000 T nthw_spis_new
000000000000057c T nthw_spis_read_rx_fifo
000000000000049d T nthw_spis_reset
000000000000023b T nthw_spi_v3_init
0000000000000000 T nthw_spi_v3_new
000000000000044e T nthw_spi_v3_transfer
0000000000000039 T nthw_stat_delete
0000000000000ec2 T nthw_stat_get_load_bps_rx
0000000000000f72 T nthw_stat_get_load_bps_tx
0000000000001022 T nthw_stat_get_load_pps_rx
00000000000010d2 T nthw_stat_get_load_pps_tx
0000000000000054 T nthw_stat_init
0000000000000000 T nthw_stat_new
0000000000000ce5 T nthw_stat_set_dma_address
0000000000000e3e T nthw_stat_trigger
0000000000000000 D dbg_res_descr
0000000000001aa1 T nthw_flow_api_create
0000000000001f1c T nthw_flow_api_done
0000000000001fc7 T nthw_flow_api_get_be_dev
0000000000000f38 T nthw_flow_delete_eth_dev
0000000000002950 T nthw_flow_get_flm_stats
00000000000029af T nthw_flow_get_ifr_stats
00000000000000a1 T nthw_flow_nic_alloc_resource
000000000000024f T nthw_flow_nic_alloc_resource_config
000000000000069a T nthw_flow_nic_deref_resource
00000000000004a6 T nthw_flow_nic_free_resource
0000000000000596 T nthw_flow_nic_ref_resource
000000000000005e T nthw_flow_nic_set_error
0000000000002a0e T nthw_init_flow_filter
0000000000002032 T sprint_nt_rss_mask
0000000000000000 T nthw_flow_group_handle_create
00000000000000ef T nthw_flow_group_handle_destroy
0000000000000153 T nthw_flow_group_translate_get
0000000000000322 T nthw_flow_group_translate_get_orig_group
000000000000014b T ntnic_id_table_create
000000000000018c T ntnic_id_table_destroy
0000000000000361 T ntnic_id_table_find
0000000000000285 T ntnic_id_table_free_id
00000000000001d7 T ntnic_id_table_get_id
0000000000000000 T nthw_callocate_mod
000000000000061b T nthw_flow_api_backend_done
000000000000037a T nthw_flow_api_backend_init
0000000000000346 T nthw_zero_module_cache
0000000000000100 T flm_age_event_clear
00000000000000b3 T flm_age_event_get
00000000000000d8 T flm_age_event_set
0000000000002680 T flm_age_queue_count
000000000000021e T flm_age_queue_create
0000000000000128 T flm_age_queue_free
00000000000001d6 T flm_age_queue_free_all
00000000000015a0 T flm_age_queue_get
00000000000026e4 T flm_age_queue_get_size
00000000000004c9 T flm_age_queue_put
0000000000000036 T flm_lrn_queue_create
000000000000006c T flm_lrn_queue_free
00000000000008da T flm_lrn_queue_get_read_buffer
0000000000000087 T flm_lrn_queue_get_write_buffer
0000000000000fc2 T flm_lrn_queue_release_read_buffer
0000000000000767 T flm_lrn_queue_release_write_buffer
0000000000003c7c T nthw_flm_inf_queue_get
00000000000018e4 T nthw_flm_inf_queue_put
000000000000028f T nthw_flm_inf_sta_queue_free_all
000000000000079a T nthw_flm_sta_queue_put
000000000000e97b T done_flow_management_of_ndev_profile_inline
0000000000010e5f T flow_actions_template_create_profile_inline
000000000001106e T flow_actions_template_destroy_profile_inline
000000000000f6e3 T flow_actions_update_profile_inline
0000000000011448 T flow_async_create_profile_inline
0000000000011c73 T flow_async_destroy_profile_inline
00000000000109f4 T flow_configure_profile_inline
000000000000ede6 T flow_create_profile_inline
000000000000f286 T flow_destroy_locked_profile_inline
000000000000f4f5 T flow_destroy_profile_inline
00000000000100cf T flow_dev_dump_profile_inline
000000000000f5be T flow_flush_profile_inline
000000000000ffad T flow_get_aged_flows_profile_inline
0000000000010424 T flow_get_flm_stats_profile_inline
0000000000010640 T flow_get_ifr_stats_profile_inline
0000000000010953 T flow_info_get_profile_inline
0000000000010cd3 T flow_pattern_template_create_profile_inline
0000000000010e18 T flow_pattern_template_destroy_profile_inline
00000000000106fb T flow_set_mtu_inline
00000000000110b5 T flow_template_table_create_profile_inline
000000000001135b T flow_template_table_destroy_profile_inline
000000000000d015 T initialize_flow_management_of_ndev_profile_inline
0000000000011d4f T profile_inline_init
0000000000005514 T hw_db_inline_action_set_add
0000000000005704 T hw_db_inline_action_set_deref
000000000000569a T hw_db_inline_action_set_ref
0000000000008294 T hw_db_inline_cat_add
0000000000008460 T hw_db_inline_cat_deref
0000000000008401 T hw_db_inline_cat_ref
000000000000583e T hw_db_inline_cot_add
00000000000059f8 T hw_db_inline_cot_deref
000000000000599b T hw_db_inline_cot_ref
0000000000000000 T hw_db_inline_create
000000000000080b T hw_db_inline_deref_idxs
000000000000064b T hw_db_inline_destroy
0000000000000c1c T hw_db_inline_dump
00000000000022c3 T hw_db_inline_dump_cfn
0000000000002385 T hw_db_inline_find_data
0000000000000bb5 T hw_db_inline_find_idx
0000000000008d4c T hw_db_inline_flm_add
00000000000092a3 T hw_db_inline_flm_deref
00000000000095bb T hw_db_inline_flm_ft_add
000000000000940a T hw_db_inline_flm_ft_default
00000000000098cd T hw_db_inline_flm_ft_deref
0000000000009817 T hw_db_inline_flm_ft_ref
0000000000009235 T hw_db_inline_flm_ref
0000000000009a91 T hw_db_inline_hsh_add
0000000000009e62 T hw_db_inline_hsh_deref
0000000000009e03 T hw_db_inline_hsh_ref
0000000000008556 T hw_db_inline_km_add
00000000000086ee T hw_db_inline_km_deref
0000000000008834 T hw_db_inline_km_ft_add
0000000000008a83 T hw_db_inline_km_ft_deref
00000000000089e4 T hw_db_inline_km_ft_ref
0000000000008695 T hw_db_inline_km_ref
0000000000004f7d T hw_db_inline_match_set_add
0000000000005290 T hw_db_inline_match_set_deref
0000000000005222 T hw_db_inline_match_set_ref
0000000000005c5e T hw_db_inline_qsl_add
0000000000006244 T hw_db_inline_qsl_deref
00000000000061fc T hw_db_inline_qsl_ref
000000000000a02a T hw_db_inline_scrub_add
000000000000a3ea T hw_db_inline_scrub_deref
000000000000a38b T hw_db_inline_scrub_ref
000000000000290f T hw_db_inline_setup_mbr_filter
00000000000064ad T hw_db_inline_slc_lr_add
000000000000672c T hw_db_inline_slc_lr_deref
00000000000066cd T hw_db_inline_slc_lr_ref
0000000000006ca7 T hw_db_inline_tpe_add
000000000000783b T hw_db_inline_tpe_deref
0000000000007b4b T hw_db_inline_tpe_ext_add
0000000000007ebc T hw_db_inline_tpe_ext_deref
0000000000007e51 T hw_db_inline_tpe_ext_ref
00000000000077dc T hw_db_inline_tpe_ref
0000000000000000 D flow_be_iface
0000000000008436 T nthw_bin_flow_backend_init
0000000000008c88 T nthw_flow_backend_init
0000000000000113 T nthw_flow_filter_done
0000000000000000 T nthw_flow_filter_init
00000000000005c1 T nthw_gethash
000000000000065f T nthw_init_hasher
0000000000000506 T hsh_set
0000000000000000 T kcc_free_ndev_resource_management
0000000000000270 T km_add_match_elem
0000000000000000 T km_attach_ndev_resource_management
00000000000032e0 T km_clear_data_match_entry
0000000000000203 T km_free_ndev_resource_management
0000000000000cc5 T km_key_compare
0000000000000555 T km_key_create
00000000000010c2 T km_rcp_set
0000000000003242 T km_write_data_match_entry
0000000000000029 T hw_mod_cat_alloc
0000000000006d3a T hw_mod_cat_cct_flush
00000000000015ce T hw_mod_cat_cfn_flush
0000000000004fd8 T hw_mod_cat_cfn_set
0000000000006667 T hw_mod_cat_cot_flush
0000000000006d07 T hw_mod_cat_cot_set
0000000000006054 T hw_mod_cat_cte_flush
00000000000062d8 T hw_mod_cat_cte_get
00000000000062a5 T hw_mod_cat_cte_set
000000000000630c T hw_mod_cat_cts_flush
0000000000006633 T hw_mod_cat_cts_get
0000000000006600 T hw_mod_cat_cts_set
0000000000006ea2 T hw_mod_cat_exo_flush
0000000000000a3d T hw_mod_cat_free
0000000000005c53 T hw_mod_cat_fte_flm_flush
000000000000600b T hw_mod_cat_fte_flm_get
0000000000005fc2 T hw_mod_cat_fte_flm_set
0000000000005c1d T hw_mod_cat_fte_km_flush
0000000000005f79 T hw_mod_cat_fte_km_get
0000000000005f30 T hw_mod_cat_fte_km_set
0000000000006df1 T hw_mod_cat_kcc_flush
000000000000523e T hw_mod_cat_kce_flm_flush
00000000000055ca T hw_mod_cat_kce_flm_get
0000000000005581 T hw_mod_cat_kce_flm_set
0000000000005208 T hw_mod_cat_kce_km_flush
0000000000005538 T hw_mod_cat_kce_km_get
00000000000054ef T hw_mod_cat_kce_km_set
0000000000005729 T hw_mod_cat_kcs_flm_flush
0000000000005ab2 T hw_mod_cat_kcs_flm_get
0000000000005a69 T hw_mod_cat_kcs_flm_set
00000000000056f3 T hw_mod_cat_kcs_km_flush
0000000000005a20 T hw_mod_cat_kcs_km_get
00000000000059d7 T hw_mod_cat_kcs_km_set
000000000000700a T hw_mod_cat_len_flush
0000000000000000 T hw_mod_cat_present
0000000000006f53 T hw_mod_cat_rck_flush
0000000000000e9b T hw_mod_cat_reset
0000000000000029 T hw_mod_flm_alloc
000000000000363d T hw_mod_flm_buf_ctrl_get
0000000000003416 T hw_mod_flm_buf_ctrl_update
0000000000000cda T hw_mod_flm_control_flush
0000000000001594 T hw_mod_flm_control_set
0000000000000be2 T hw_mod_flm_free
0000000000003d51 T hw_mod_flm_inf_sta_data_update_get
0000000000001c5d T hw_mod_flm_load_bin_flush
0000000000001dcf T hw_mod_flm_load_bin_set
0000000000003bf9 T hw_mod_flm_lrn_data_set_flush
0000000000000000 T hw_mod_flm_present
0000000000001dfb T hw_mod_flm_prio_flush
000000000000227c T hw_mod_flm_prio_set
00000000000022a8 T hw_mod_flm_pst_flush
0000000000002644 T hw_mod_flm_pst_set
0000000000002677 T hw_mod_flm_rcp_flush
00000000000033d3 T hw_mod_flm_rcp_set
000000000000338f T hw_mod_flm_rcp_set_mask
0000000000000c23 T hw_mod_flm_reset
0000000000001abc T hw_mod_flm_scan_flush
0000000000001c31 T hw_mod_flm_scan_set
0000000000002731 T hw_mod_flm_scrub_flush
000000000000418d T hw_mod_flm_scrub_set
0000000000003e9d T hw_mod_flm_scrub_timeout_decode
0000000000003f18 T hw_mod_flm_scrub_timeout_encode
000000000000369e T hw_mod_flm_stat_get
0000000000003667 T hw_mod_flm_stat_update
0000000000001a8f T hw_mod_flm_status_get
00000000000015c0 T hw_mod_flm_status_update
0000000000000029 T hw_mod_hsh_alloc
000000000000030c T hw_mod_hsh_free
0000000000000000 T hw_mod_hsh_present
00000000000003c2 T hw_mod_hsh_rcp_flush
0000000000001721 T hw_mod_hsh_rcp_set
000000000000034d T hw_mod_hsh_reset
0000000000000029 T hw_mod_km_alloc
000000000000250c T hw_mod_km_cam_flush
0000000000002edd T hw_mod_km_cam_set
00000000000006a5 T hw_mod_km_free
0000000000000000 T hw_mod_km_present
0000000000000916 T hw_mod_km_rcp_flush
00000000000024cf T hw_mod_km_rcp_get
0000000000002492 T hw_mod_km_rcp_set
00000000000006e6 T hw_mod_km_reset
0000000000002f1a T hw_mod_km_tcam_flush
000000000000347b T hw_mod_km_tcam_get
0000000000003430 T hw_mod_km_tcam_set
00000000000034c6 T hw_mod_km_tci_flush
00000000000037e3 T hw_mod_km_tci_set
0000000000003820 T hw_mod_km_tcq_flush
0000000000000029 T hw_mod_pdb_alloc
00000000000013c6 T hw_mod_pdb_config_flush
0000000000000269 T hw_mod_pdb_free
0000000000000000 T hw_mod_pdb_present
000000000000036c T hw_mod_pdb_rcp_flush
0000000000001393 T hw_mod_pdb_rcp_set
00000000000002aa T hw_mod_pdb_reset
0000000000000029 T hw_mod_qsl_alloc
0000000000000350 T hw_mod_qsl_free
0000000000000000 T hw_mod_qsl_present
00000000000014f1 T hw_mod_qsl_qen_flush
000000000000176a T hw_mod_qsl_qen_get
0000000000001737 T hw_mod_qsl_qen_set
0000000000000fa5 T hw_mod_qsl_qst_flush
00000000000014be T hw_mod_qsl_qst_set
0000000000000509 T hw_mod_qsl_rcp_flush
0000000000000f72 T hw_mod_qsl_rcp_set
0000000000000391 T hw_mod_qsl_reset
000000000000179e T hw_mod_qsl_unmq_flush
0000000000001a41 T hw_mod_qsl_unmq_set
0000000000000029 T hw_mod_slc_lr_alloc
000000000000019a T hw_mod_slc_lr_free
0000000000000000 T hw_mod_slc_lr_present
0000000000000250 T hw_mod_slc_lr_rcp_flush
0000000000000b39 T hw_mod_slc_lr_rcp_set
00000000000001db T hw_mod_slc_lr_reset
0000000000000029 T hw_mod_tpe_alloc
000000000000318a T hw_mod_tpe_cpy_rcp_flush
0000000000003878 T hw_mod_tpe_cpy_rcp_set
00000000000049f0 T hw_mod_tpe_csu_rcp_flush
00000000000050f4 T hw_mod_tpe_csu_rcp_set
00000000000006ac T hw_mod_tpe_free
00000000000038ab T hw_mod_tpe_hfu_rcp_flush
00000000000049bd T hw_mod_tpe_hfu_rcp_set
00000000000015ce T hw_mod_tpe_ifr_counters_get
000000000000159b T hw_mod_tpe_ifr_counters_set
000000000000148b T hw_mod_tpe_ifr_counters_update
0000000000001156 T hw_mod_tpe_ifr_rcp_flush
0000000000001458 T hw_mod_tpe_ifr_rcp_set
0000000000001602 T hw_mod_tpe_ins_rcp_flush
0000000000001c84 T hw_mod_tpe_ins_rcp_set
0000000000000000 T hw_mod_tpe_present
00000000000006ed T hw_mod_tpe_reset
0000000000002594 T hw_mod_tpe_rpl_ext_flush
0000000000002b81 T hw_mod_tpe_rpl_ext_set
0000000000001cb7 T hw_mod_tpe_rpl_rcp_flush
0000000000002561 T hw_mod_tpe_rpl_rcp_set
0000000000002bb4 T hw_mod_tpe_rpl_rpl_flush
0000000000003156 T hw_mod_tpe_rpl_rpl_set
0000000000000862 T hw_mod_tpe_rpp_ifr_rcp_flush
0000000000000b64 T hw_mod_tpe_rpp_ifr_rcp_set
0000000000000b97 T hw_mod_tpe_rpp_rcp_flush
0000000000001123 T hw_mod_tpe_rpp_rcp_set
00000000000024b1 T cat_nthw_cct_cnt
00000000000024db T cat_nthw_cct_color
000000000000252f T cat_nthw_cct_flush
0000000000002505 T cat_nthw_cct_km
0000000000002487 T cat_nthw_cct_select
00000000000015fc T cat_nthw_cfn_cnt
0000000000001623 T cat_nthw_cfn_enable
0000000000001acd T cat_nthw_cfn_err_cv
0000000000001af7 T cat_nthw_cfn_err_fcs
0000000000001aa3 T cat_nthw_cfn_err_inv
00000000000019a7 T cat_nthw_cfn_err_l3_cs
00000000000019d1 T cat_nthw_cfn_err_l4_cs
00000000000019fb T cat_nthw_cfn_err_tnl_l3_cs
0000000000001a25 T cat_nthw_cfn_err_tnl_l4_cs
0000000000001a79 T cat_nthw_cfn_err_tnl_ttl_exp
0000000000001b21 T cat_nthw_cfn_err_trunc
0000000000001a4f T cat_nthw_cfn_err_ttl_exp
0000000000001d54 T cat_nthw_cfn_flush
000000000000164a T cat_nthw_cfn_inv
0000000000001d00 T cat_nthw_cfn_km0_or
0000000000001d2a T cat_nthw_cfn_km1_or
0000000000001cac T cat_nthw_cfn_lc
0000000000001cd6 T cat_nthw_cfn_lc_inv
0000000000001b4b T cat_nthw_cfn_mac_port
0000000000001c2e T cat_nthw_cfn_pm_and_inv
0000000000001c04 T cat_nthw_cfn_pm_cmb
0000000000001b75 T cat_nthw_cfn_pm_cmp
0000000000001bb0 T cat_nthw_cfn_pm_dct
0000000000001bda T cat_nthw_cfn_pm_ext_inv
0000000000001c82 T cat_nthw_cfn_pm_inv
0000000000001c58 T cat_nthw_cfn_pm_or_inv
0000000000001980 T cat_nthw_cfn_ptc_cfp
00000000000017b2 T cat_nthw_cfn_ptc_frag
0000000000001671 T cat_nthw_cfn_ptc_inv
00000000000017dc T cat_nthw_cfn_ptc_ip_prot
0000000000001698 T cat_nthw_cfn_ptc_isl
00000000000016e6 T cat_nthw_cfn_ptc_l2
0000000000001788 T cat_nthw_cfn_ptc_l3
0000000000001806 T cat_nthw_cfn_ptc_l4
00000000000016bf T cat_nthw_cfn_ptc_mac
000000000000175e T cat_nthw_cfn_ptc_mpls
0000000000001902 T cat_nthw_cfn_ptc_tnl_frag
000000000000192c T cat_nthw_cfn_ptc_tnl_ip_prot
000000000000185a T cat_nthw_cfn_ptc_tnl_l2
00000000000018d8 T cat_nthw_cfn_ptc_tnl_l3
0000000000001956 T cat_nthw_cfn_ptc_tnl_l4
00000000000018ae T cat_nthw_cfn_ptc_tnl_mpls
0000000000001884 T cat_nthw_cfn_ptc_tnl_vlan
0000000000001830 T cat_nthw_cfn_ptc_tunnel
0000000000001734 T cat_nthw_cfn_ptc_vlan
000000000000170d T cat_nthw_cfn_ptc_vn_tag
00000000000015d5 T cat_nthw_cfn_select
00000000000023ca T cat_nthw_cot_cnt
00000000000023f4 T cat_nthw_cot_color
0000000000002448 T cat_nthw_cot_flush
000000000000241e T cat_nthw_cot_km
00000000000023a0 T cat_nthw_cot_select
0000000000002082 T cat_nthw_cte_cnt
00000000000020ac T cat_nthw_cte_enable_col
00000000000020d6 T cat_nthw_cte_enable_cor
0000000000002226 T cat_nthw_cte_enable_epp
0000000000002100 T cat_nthw_cte_enable_hsh
00000000000021fc T cat_nthw_cte_enable_hst
0000000000002154 T cat_nthw_cte_enable_ipf
00000000000021d2 T cat_nthw_cte_enable_msk
00000000000021a8 T cat_nthw_cte_enable_pdb
000000000000212a T cat_nthw_cte_enable_qsl
000000000000217e T cat_nthw_cte_enable_slc
0000000000002250 T cat_nthw_cte_enable_tpe
000000000000227a T cat_nthw_cte_flush
0000000000002058 T cat_nthw_cte_select
000000000000230d T cat_nthw_cts_cat_a
0000000000002337 T cat_nthw_cts_cat_b
00000000000022e3 T cat_nthw_cts_cnt
0000000000002361 T cat_nthw_cts_flush
00000000000022b9 T cat_nthw_cts_select
0000000000000039 T cat_nthw_delete
0000000000002598 T cat_nthw_exo_cnt
00000000000025c2 T cat_nthw_exo_dyn
0000000000002616 T cat_nthw_exo_flush
00000000000025ec T cat_nthw_exo_ofs
000000000000256e T cat_nthw_exo_select
0000000000001f9f T cat_nthw_fte_cnt
0000000000001fd3 T cat_nthw_fte_enable
0000000000002007 T cat_nthw_fte_flush
0000000000001f6a T cat_nthw_fte_select
0000000000000098 T cat_nthw_init
0000000000002917 T cat_nthw_kcc_category
00000000000028bb T cat_nthw_kcc_cnt
000000000000296b T cat_nthw_kcc_flush
0000000000002941 T cat_nthw_kcc_id
00000000000028e5 T cat_nthw_kcc_key
0000000000002891 T cat_nthw_kcc_select
0000000000001dc2 T cat_nthw_kce_cnt
0000000000001df6 T cat_nthw_kce_enable
0000000000001e2a T cat_nthw_kce_flush
0000000000001d8d T cat_nthw_kce_select
0000000000001ee4 T cat_nthw_kcs_category
0000000000001eaf T cat_nthw_kcs_cnt
0000000000001f19 T cat_nthw_kcs_flush
0000000000001e7b T cat_nthw_kcs_select
0000000000002756 T cat_nthw_len_cnt
00000000000027d4 T cat_nthw_len_dyn1
00000000000027fe T cat_nthw_len_dyn2
0000000000002852 T cat_nthw_len_flush
0000000000002828 T cat_nthw_len_inv
0000000000002780 T cat_nthw_len_lower
000000000000272c T cat_nthw_len_select
00000000000027aa T cat_nthw_len_upper
0000000000000000 T cat_nthw_new
000000000000267f T cat_nthw_rck_cnt
00000000000026a9 T cat_nthw_rck_data
00000000000026ed T cat_nthw_rck_flush
0000000000002655 T cat_nthw_rck_select
0000000000000071 T cat_nthw_set_debug_mode
0000000000000060 T csu_nthw_delete
0000000000000098 T csu_nthw_init
0000000000000027 T csu_nthw_new
0000000000000290 T csu_nthw_rcp_cnt
0000000000000353 T csu_nthw_rcp_flush
0000000000000305 T csu_nthw_rcp_inner_l3_cmd
000000000000032c T csu_nthw_rcp_inner_l4_cmd
00000000000002b7 T csu_nthw_rcp_outer_l3_cmd
00000000000002de T csu_nthw_rcp_outer_l4_cmd
0000000000000269 T csu_nthw_rcp_select
0000000000000000 T csu_nthw_set_debug_mode
000000000000211a T flm_nthw_buf_ctrl_update
00000000000015dd T flm_nthw_control_crcrd
00000000000015b3 T flm_nthw_control_crcwr
0000000000001631 T flm_nthw_control_eab
0000000000001406 T flm_nthw_control_enable
0000000000001685 T flm_nthw_control_flush
000000000000142d T flm_nthw_control_init
0000000000001454 T flm_nthw_control_lds
000000000000147b T flm_nthw_control_lfs
00000000000014a2 T flm_nthw_control_lis
0000000000001565 T flm_nthw_control_pds
000000000000158c T flm_nthw_control_pis
0000000000001607 T flm_nthw_control_rbl
0000000000001517 T flm_nthw_control_rds
000000000000153e T flm_nthw_control_ris
000000000000165b T flm_nthw_control_split_sdram_usage
00000000000014c9 T flm_nthw_control_uds
00000000000014f0 T flm_nthw_control_uis
0000000000000082 T flm_nthw_delete
000000000000268e T flm_nthw_inf_sta_data_update
00000000000000e1 T flm_nthw_init
0000000000001aa4 T flm_nthw_load_aps_cnt
0000000000001a82 T flm_nthw_load_aps_update
00000000000019da T flm_nthw_load_bin
0000000000001a04 T flm_nthw_load_bin_flush
0000000000001a4d T flm_nthw_load_lps_cnt
0000000000001a2b T flm_nthw_load_lps_update
00000000000022e9 T flm_nthw_lrn_data_flush
0000000000000049 T flm_nthw_new
0000000000001c29 T flm_nthw_prio_flush
0000000000001b03 T flm_nthw_prio_ft0
0000000000001b57 T flm_nthw_prio_ft1
0000000000001bab T flm_nthw_prio_ft2
0000000000001bff T flm_nthw_prio_ft3
0000000000001ad9 T flm_nthw_prio_limit0
0000000000001b2d T flm_nthw_prio_limit1
0000000000001b81 T flm_nthw_prio_limit2
0000000000001bd5 T flm_nthw_prio_limit3
0000000000001ca4 T flm_nthw_pst_bp
0000000000001c7a T flm_nthw_pst_cnt
0000000000001d22 T flm_nthw_pst_flush
0000000000001cce T flm_nthw_pst_pp
0000000000001c50 T flm_nthw_pst_select
0000000000001cf8 T flm_nthw_pst_tp
00000000000020b1 T flm_nthw_rcp_auto_ipv4_mask
0000000000002033 T flm_nthw_rcp_byt_dyn
000000000000205d T flm_nthw_rcp_byt_ofs
0000000000001d8b T flm_nthw_rcp_cnt
00000000000020db T flm_nthw_rcp_flush
0000000000002009 T flm_nthw_rcp_ipn
0000000000001fb5 T flm_nthw_rcp_kid
0000000000001db5 T flm_nthw_rcp_lookup
0000000000001f83 T flm_nthw_rcp_mask
0000000000001fdf T flm_nthw_rcp_opn
0000000000001ddf T flm_nthw_rcp_qw0_dyn
0000000000001e09 T flm_nthw_rcp_qw0_ofs
0000000000001e33 T flm_nthw_rcp_qw0_sel
0000000000001e5d T flm_nthw_rcp_qw4_dyn
0000000000001e87 T flm_nthw_rcp_qw4_ofs
0000000000001d61 T flm_nthw_rcp_select
0000000000001eb1 T flm_nthw_rcp_sw8_dyn
0000000000001edb T flm_nthw_rcp_sw8_ofs
0000000000001f05 T flm_nthw_rcp_sw8_sel
0000000000001f2f T flm_nthw_rcp_sw9_dyn
0000000000001f59 T flm_nthw_rcp_sw9_ofs
0000000000002087 T flm_nthw_rcp_txplm
00000000000019b3 T flm_nthw_scan_flush
0000000000001989 T flm_nthw_scan_i
00000000000032f4 T flm_nthw_scrub_cnt
0000000000003372 T flm_nthw_scrub_del
00000000000033c6 T flm_nthw_scrub_flush
000000000000339c T flm_nthw_scrub_inf
0000000000003348 T flm_nthw_scrub_r
00000000000032ca T flm_nthw_scrub_select
000000000000331e T flm_nthw_scrub_t
00000000000000ba T flm_nthw_set_debug_mode
0000000000002d03 T flm_nthw_stat_aul_done_cnt
0000000000002d38 T flm_nthw_stat_aul_done_update
0000000000002db1 T flm_nthw_stat_aul_fail_cnt
0000000000002de6 T flm_nthw_stat_aul_fail_update
0000000000002d5a T flm_nthw_stat_aul_ignore_cnt
0000000000002d8f T flm_nthw_stat_aul_ignore_update
0000000000003117 T flm_nthw_stat_csh_hit_cnt
000000000000314c T flm_nthw_stat_csh_hit_update
000000000000316e T flm_nthw_stat_csh_miss_cnt
00000000000031a3 T flm_nthw_stat_csh_miss_update
00000000000031c5 T flm_nthw_stat_csh_unh_cnt
00000000000031fa T flm_nthw_stat_csh_unh_update
0000000000003273 T flm_nthw_stat_cuc_move_cnt
00000000000032a8 T flm_nthw_stat_cuc_move_update
000000000000321c T flm_nthw_stat_cuc_start_cnt
0000000000003251 T flm_nthw_stat_cuc_start_update
0000000000002e5f T flm_nthw_stat_flows_cnt
0000000000002e94 T flm_nthw_stat_flows_update
0000000000002f0d T flm_nthw_stat_inf_done_cnt
0000000000002f42 T flm_nthw_stat_inf_done_update
0000000000002f64 T flm_nthw_stat_inf_skip_cnt
0000000000002f99 T flm_nthw_stat_inf_skip_update
00000000000029f4 T flm_nthw_stat_lrn_done_cnt
0000000000002a29 T flm_nthw_stat_lrn_done_update
0000000000002aa2 T flm_nthw_stat_lrn_fail_cnt
0000000000002ad7 T flm_nthw_stat_lrn_fail_update
0000000000002a4b T flm_nthw_stat_lrn_ignore_cnt
0000000000002a80 T flm_nthw_stat_lrn_ignore_update
00000000000030c0 T flm_nthw_stat_pck_dis_cnt
00000000000030f5 T flm_nthw_stat_pck_dis_update
0000000000002fbb T flm_nthw_stat_pck_hit_cnt
0000000000002ff0 T flm_nthw_stat_pck_hit_update
0000000000003012 T flm_nthw_stat_pck_miss_cnt
0000000000003047 T flm_nthw_stat_pck_miss_update
0000000000003069 T flm_nthw_stat_pck_unh_cnt
000000000000309e T flm_nthw_stat_pck_unh_update
0000000000002ba7 T flm_nthw_stat_prb_done_cnt
0000000000002bdc T flm_nthw_stat_prb_done_update
0000000000002bfe T flm_nthw_stat_prb_ignore_cnt
0000000000002c33 T flm_nthw_stat_prb_ignore_update
0000000000002c55 T flm_nthw_stat_rel_done_cnt
0000000000002c8a T flm_nthw_stat_rel_done_update
0000000000002cac T flm_nthw_stat_rel_ignore_cnt
0000000000002ce1 T flm_nthw_stat_rel_ignore_update
0000000000002eb6 T flm_nthw_stat_sta_done_cnt
0000000000002eeb T flm_nthw_stat_sta_done_update
0000000000002e08 T flm_nthw_stat_tul_done_cnt
0000000000002e3d T flm_nthw_stat_tul_done_update
0000000000002af9 T flm_nthw_stat_unl_done_cnt
0000000000002b2e T flm_nthw_stat_unl_done_update
0000000000002b50 T flm_nthw_stat_unl_ignore_cnt
0000000000002b85 T flm_nthw_stat_unl_ignore_update
00000000000018ee T flm_nthw_status_cache_buf_crit
0000000000001724 T flm_nthw_status_calib_fail
00000000000016a9 T flm_nthw_status_calib_success
0000000000001867 T flm_nthw_status_crcerr
00000000000017c3 T flm_nthw_status_critical
00000000000018b9 T flm_nthw_status_eft_bp
0000000000001940 T flm_nthw_status_flush
000000000000178e T flm_nthw_status_idle
0000000000001759 T flm_nthw_status_initdone
0000000000001815 T flm_nthw_status_panic
0000000000001967 T flm_nthw_status_update
0000000000000060 T hfu_nthw_delete
0000000000000098 T hfu_nthw_init
0000000000000027 T hfu_nthw_new
00000000000004d1 T hfu_nthw_rcp_cnt
0000000000000879 T hfu_nthw_rcp_flush
0000000000000594 T hfu_nthw_rcp_len_a_add_dyn
00000000000005bb T hfu_nthw_rcp_len_a_add_ofs
000000000000051f T hfu_nthw_rcp_len_a_ol4len
0000000000000546 T hfu_nthw_rcp_len_a_pos_dyn
000000000000056d T hfu_nthw_rcp_len_a_pos_ofs
00000000000005e2 T hfu_nthw_rcp_len_a_sub_dyn
00000000000004f8 T hfu_nthw_rcp_len_a_wr
0000000000000681 T hfu_nthw_rcp_len_b_add_dyn
00000000000006ab T hfu_nthw_rcp_len_b_add_ofs
0000000000000630 T hfu_nthw_rcp_len_b_pos_dyn
0000000000000657 T hfu_nthw_rcp_len_b_pos_ofs
00000000000006d5 T hfu_nthw_rcp_len_b_sub_dyn
0000000000000609 T hfu_nthw_rcp_len_b_wr
000000000000077d T hfu_nthw_rcp_len_c_add_dyn
00000000000007a7 T hfu_nthw_rcp_len_c_add_ofs
0000000000000729 T hfu_nthw_rcp_len_c_pos_dyn
0000000000000753 T hfu_nthw_rcp_len_c_pos_ofs
00000000000007d1 T hfu_nthw_rcp_len_c_sub_dyn
00000000000006ff T hfu_nthw_rcp_len_c_wr
00000000000004aa T hfu_nthw_rcp_select
0000000000000825 T hfu_nthw_rcp_ttl_pos_dyn
000000000000084f T hfu_nthw_rcp_ttl_pos_ofs
00000000000007fb T hfu_nthw_rcp_ttl_wr
0000000000000000 T hfu_nthw_set_debug_mode
0000000000000060 T hsh_nthw_delete
0000000000000098 T hsh_nthw_init
0000000000000027 T hsh_nthw_new
0000000000000b79 T hsh_nthw_rcp_auto_ipv4_mask
0000000000000793 T hsh_nthw_rcp_cnt
0000000000000bb3 T hsh_nthw_rcp_flush
0000000000000ad3 T hsh_nthw_rcp_hsh_type
0000000000000aa9 T hsh_nthw_rcp_hsh_valid
0000000000000b37 T hsh_nthw_rcp_k
00000000000007ba T hsh_nthw_rcp_load_dist_type
00000000000007e1 T hsh_nthw_rcp_mac_port_mask
00000000000009f9 T hsh_nthw_rcp_p_mask
0000000000000864 T hsh_nthw_rcp_qw0_ofs
000000000000083d T hsh_nthw_rcp_qw0_pe
00000000000008b2 T hsh_nthw_rcp_qw4_ofs
000000000000088b T hsh_nthw_rcp_qw4_pe
0000000000000a55 T hsh_nthw_rcp_seed
000000000000076c T hsh_nthw_rcp_select
0000000000000816 T hsh_nthw_rcp_sort
0000000000000a7f T hsh_nthw_rcp_tnl_p
0000000000000afd T hsh_nthw_rcp_toeplitz
0000000000000900 T hsh_nthw_rcp_w8_ofs
00000000000008d9 T hsh_nthw_rcp_w8_pe
0000000000000927 T hsh_nthw_rcp_w8_sort
000000000000097b T hsh_nthw_rcp_w9_ofs
00000000000009cf T hsh_nthw_rcp_w9_p
0000000000000951 T hsh_nthw_rcp_w9_pe
00000000000009a5 T hsh_nthw_rcp_w9_sort
0000000000000a23 T hsh_nthw_rcp_word_mask
0000000000000000 T hsh_nthw_set_debug_mode
0000000000000543 T ifr_nthw_counters_cnt
000000000000056d T ifr_nthw_counters_drop
0000000000000519 T ifr_nthw_counters_select
00000000000005a2 T ifr_nthw_counters_update
0000000000000060 T ifr_nthw_init
0000000000000027 T ifr_nthw_new
00000000000003c2 T ifr_nthw_rcp_cnt
00000000000004e0 T ifr_nthw_rcp_flush
000000000000041d T ifr_nthw_rcp_ipv4_df_drop
00000000000003e9 T ifr_nthw_rcp_ipv4_en
0000000000000485 T ifr_nthw_rcp_ipv6_drop
0000000000000451 T ifr_nthw_rcp_ipv6_en
00000000000004b9 T ifr_nthw_rcp_mtu
000000000000039b T ifr_nthw_rcp_select
0000000000000000 T ifr_nthw_set_debug_mode
0000000000000067 T info_nthw_delete
0000000000000879 T info_nthw_get_kcc_banks
0000000000000868 T info_nthw_get_kcc_size
0000000000000846 T info_nthw_get_ltx_avail
0000000000000857 T info_nthw_get_nb_categories
000000000000089b T info_nthw_get_nb_cat_funcs
0000000000000a17 T info_nthw_get_nb_cat_km_if_cnt
0000000000000a2b T info_nthw_get_nb_cat_km_if_m0
0000000000000a3f T info_nthw_get_nb_cat_km_if_m1
0000000000000945 T info_nthw_get_nb_flm_categories
0000000000000967 T info_nthw_get_nb_flm_entry_size
00000000000009bc T info_nthw_get_nb_flm_load_aps_max
0000000000000989 T info_nthw_get_nb_flm_prios
000000000000099a T info_nthw_get_nb_flm_pst_profiles
00000000000009ab T info_nthw_get_nb_flm_scrub_profiles
0000000000000956 T info_nthw_get_nb_flm_size_mb
0000000000000978 T info_nthw_get_nb_flm_variant
0000000000000adf T info_nthw_get_nb_hsh_categories
0000000000000af3 T info_nthw_get_nb_hsh_toeplitz
00000000000008f0 T info_nthw_get_nb_km_cam_banks
0000000000000912 T info_nthw_get_nb_km_cam_records
0000000000000901 T info_nthw_get_nb_km_cam_record_words
00000000000008df T info_nthw_get_nb_km_categories
00000000000008ac T info_nthw_get_nb_km_flow_types
0000000000000923 T info_nthw_get_nb_km_tcam_banks
0000000000000934 T info_nthw_get_nb_km_tcam_bank_width
00000000000008ce T info_nthw_get_nb_len
00000000000009ef T info_nthw_get_nb_pdb_categories
0000000000000824 T info_nthw_get_nb_phy_ports
00000000000008bd T info_nthw_get_nb_pm_ext
00000000000009cd T info_nthw_get_nb_qsl_categories
00000000000009de T info_nthw_get_nb_qsl_qst_entries
000000000000088a T info_nthw_get_nb_queues
0000000000000a03 T info_nthw_get_nb_roa_categories
0000000000000acb T info_nthw_get_nb_rpp_per_ps
0000000000000835 T info_nthw_get_nb_rx_ports
0000000000000a53 T info_nthw_get_nb_tpe_categories
0000000000000ab7 T info_nthw_get_nb_tpe_ifr_categories
0000000000000a7b T info_nthw_get_nb_tx_cpy_mask_mem
0000000000000a67 T info_nthw_get_nb_tx_cpy_writers
0000000000000a8f T info_nthw_get_nb_tx_rpl_depth
0000000000000aa3 T info_nthw_get_nb_tx_rpl_ext_categories
000000000000009f T info_nthw_init
000000000000002e T info_nthw_new
00000000000016db T km_nthw_cam_cnt
00000000000018fd T km_nthw_cam_flush
0000000000001801 T km_nthw_cam_ft0
000000000000182b T km_nthw_cam_ft1
0000000000001855 T km_nthw_cam_ft2
000000000000187f T km_nthw_cam_ft3
00000000000018a9 T km_nthw_cam_ft4
00000000000018d3 T km_nthw_cam_ft5
00000000000016b1 T km_nthw_cam_select
0000000000001705 T km_nthw_cam_w0
000000000000172f T km_nthw_cam_w1
0000000000001759 T km_nthw_cam_w2
0000000000001783 T km_nthw_cam_w3
00000000000017ad T km_nthw_cam_w4
00000000000017d7 T km_nthw_cam_w5
0000000000000060 T km_nthw_delete
0000000000000098 T km_nthw_init
0000000000000027 T km_nthw_new
00000000000013e4 T km_nthw_rcp_bank_a
000000000000140e T km_nthw_rcp_bank_b
0000000000000e6a T km_nthw_rcp_cnt
0000000000001294 T km_nthw_rcp_dual
0000000000001528 T km_nthw_rcp_dw0_b_dyn
0000000000001552 T km_nthw_rcp_dw0_b_ofs
00000000000010e6 T km_nthw_rcp_dw10_dyn
000000000000111f T km_nthw_rcp_dw10_ofs
0000000000001158 T km_nthw_rcp_dw10_sel_a
0000000000001191 T km_nthw_rcp_dw10_sel_b
000000000000157c T km_nthw_rcp_dw2_b_dyn
00000000000015a6 T km_nthw_rcp_dw2_b_ofs
0000000000000fc9 T km_nthw_rcp_dw8_dyn
000000000000103b T km_nthw_rcp_dw8_ofs
0000000000001074 T km_nthw_rcp_dw8_sel_a
00000000000010ad T km_nthw_rcp_dw8_sel_b
00000000000012e8 T km_nthw_rcp_el_a
0000000000001312 T km_nthw_rcp_el_b
0000000000001678 T km_nthw_rcp_flush
0000000000001390 T km_nthw_rcp_ftm_a
00000000000013ba T km_nthw_rcp_ftm_b
000000000000133c T km_nthw_rcp_info_a
0000000000001366 T km_nthw_rcp_info_b
000000000000148c T km_nthw_rcp_keyway_a
00000000000014c5 T km_nthw_rcp_keyway_b
0000000000001438 T km_nthw_rcp_kl_a
0000000000001462 T km_nthw_rcp_kl_b
000000000000121e T km_nthw_rcp_mask_b
0000000000001259 T km_nthw_rcp_mask_da
00000000000012be T km_nthw_rcp_paired
0000000000000e91 T km_nthw_rcp_qw0_dyn
0000000000000eb8 T km_nthw_rcp_qw0_ofs
0000000000000edf T km_nthw_rcp_qw0_sel_a
0000000000000f06 T km_nthw_rcp_qw0_sel_b
0000000000000f2d T km_nthw_rcp_qw4_dyn
0000000000000f54 T km_nthw_rcp_qw4_ofs
0000000000000f7b T km_nthw_rcp_qw4_sel_a
0000000000000fa2 T km_nthw_rcp_qw4_sel_b
0000000000000e43 T km_nthw_rcp_select
00000000000015d0 T km_nthw_rcp_sw4_b_dyn
00000000000015fa T km_nthw_rcp_sw4_b_ofs
0000000000001624 T km_nthw_rcp_sw5_b_dyn
000000000000164e T km_nthw_rcp_sw5_b_ofs
0000000000001002 T km_nthw_rcp_swx_cch
00000000000011ca T km_nthw_rcp_swx_sel_a
00000000000011f4 T km_nthw_rcp_swx_sel_b
00000000000014fe T km_nthw_rcp_synergy_mode
0000000000000000 T km_nthw_set_debug_mode
0000000000001966 T km_nthw_tcam_cnt
00000000000019c2 T km_nthw_tcam_flush
000000000000193c T km_nthw_tcam_select
0000000000001990 T km_nthw_tcam_t
0000000000001a2b T km_nthw_tci_cnt
0000000000001a55 T km_nthw_tci_color
0000000000001aa9 T km_nthw_tci_flush
0000000000001a7f T km_nthw_tci_ft
0000000000001a01 T km_nthw_tci_select
0000000000001b3c T km_nthw_tcq_bank_mask
0000000000001b12 T km_nthw_tcq_cnt
0000000000001b9f T km_nthw_tcq_flush
0000000000001b75 T km_nthw_tcq_qual
0000000000001ae8 T km_nthw_tcq_select
000000000000080a T pdb_nthw_config_flush
00000000000007e0 T pdb_nthw_config_port_ofs
00000000000007b6 T pdb_nthw_config_ts_format
0000000000000060 T pdb_nthw_delete
0000000000000098 T pdb_nthw_init
0000000000000027 T pdb_nthw_new
00000000000005b8 T pdb_nthw_rcp_align
00000000000004a7 T pdb_nthw_rcp_cnt
0000000000000591 T pdb_nthw_rcp_crc_overwrite
00000000000004f5 T pdb_nthw_rcp_desc_len
00000000000004ce T pdb_nthw_rcp_descriptor
0000000000000753 T pdb_nthw_rcp_duplicate_bit
0000000000000729 T pdb_nthw_rcp_duplicate_en
000000000000077d T pdb_nthw_rcp_flush
00000000000006d5 T pdb_nthw_rcp_ip_prot_tnl
00000000000005df T pdb_nthw_rcp_ofs0_dyn
0000000000000606 T pdb_nthw_rcp_ofs0_rel
000000000000062d T pdb_nthw_rcp_ofs1_dyn
0000000000000657 T pdb_nthw_rcp_ofs1_rel
0000000000000681 T pdb_nthw_rcp_ofs2_dyn
00000000000006ab T pdb_nthw_rcp_ofs2_rel
00000000000006ff T pdb_nthw_rcp_ppc_hsh
0000000000000480 T pdb_nthw_rcp_select
0000000000000543 T pdb_nthw_rcp_tx_ignore
000000000000056a T pdb_nthw_rcp_tx_now
000000000000051c T pdb_nthw_rcp_tx_port
0000000000000000 T pdb_nthw_set_debug_mode
0000000000000060 T qsl_nthw_delete
0000000000000098 T qsl_nthw_init
0000000000000027 T qsl_nthw_new
0000000000000b84 T qsl_nthw_qen_cnt
0000000000000bae T qsl_nthw_qen_en
0000000000000bd8 T qsl_nthw_qen_flush
0000000000000b5a T qsl_nthw_qen_select
00000000000009b5 T qsl_nthw_qst_cnt
0000000000000a09 T qsl_nthw_qst_en
0000000000000b1b T qsl_nthw_qst_flush
0000000000000a6d T qsl_nthw_qst_lre
00000000000009df T qsl_nthw_qst_queue
000000000000098b T qsl_nthw_qst_select
0000000000000aa7 T qsl_nthw_qst_tci
0000000000000a33 T qsl_nthw_qst_tx_port
0000000000000ae1 T qsl_nthw_qst_ven
000000000000079f T qsl_nthw_rcp_cnt
00000000000007c6 T qsl_nthw_rcp_discard
00000000000007ed T qsl_nthw_rcp_drop
0000000000000952 T qsl_nthw_rcp_flush
00000000000008b0 T qsl_nthw_rcp_lr
0000000000000778 T qsl_nthw_rcp_select
000000000000083b T qsl_nthw_rcp_tbl_hi
0000000000000862 T qsl_nthw_rcp_tbl_idx
0000000000000814 T qsl_nthw_rcp_tbl_lo
0000000000000889 T qsl_nthw_rcp_tbl_msk
00000000000008e4 T qsl_nthw_rcp_tsa
0000000000000918 T qsl_nthw_rcp_vli
0000000000000000 T qsl_nthw_set_debug_mode
0000000000000c41 T qsl_nthw_unmq_cnt
0000000000000c6b T qsl_nthw_unmq_dest_queue
0000000000000c95 T qsl_nthw_unmq_en
0000000000000cbf T qsl_nthw_unmq_flush
0000000000000c17 T qsl_nthw_unmq_select
0000000000000060 T rpp_lr_nthw_delete
0000000000000433 T rpp_lr_nthw_ifr_rcp_cnt
0000000000000557 T rpp_lr_nthw_ifr_rcp_flush
000000000000048e T rpp_lr_nthw_ifr_rcp_ipv4_df_drop
000000000000045a T rpp_lr_nthw_ifr_rcp_ipv4_en
00000000000004f6 T rpp_lr_nthw_ifr_rcp_ipv6_drop
00000000000004c2 T rpp_lr_nthw_ifr_rcp_ipv6_en
0000000000000530 T rpp_lr_nthw_ifr_rcp_mtu
000000000000040c T rpp_lr_nthw_ifr_rcp_select
0000000000000098 T rpp_lr_nthw_init
0000000000000027 T rpp_lr_nthw_new
0000000000000385 T rpp_lr_nthw_rcp_cnt
00000000000003ac T rpp_lr_nthw_rcp_exp
00000000000003d3 T rpp_lr_nthw_rcp_flush
000000000000035e T rpp_lr_nthw_rcp_select
0000000000000000 T rpp_lr_nthw_set_debug_mode
0000000000000060 T slc_lr_nthw_delete
0000000000000098 T slc_lr_nthw_init
0000000000000027 T slc_lr_nthw_new
00000000000002f7 T slc_lr_nthw_rcp_cnt
000000000000042f T slc_lr_nthw_rcp_flush
0000000000000345 T slc_lr_nthw_rcp_head_dyn
000000000000036c T slc_lr_nthw_rcp_head_ofs
000000000000031e T slc_lr_nthw_rcp_head_slc_en
0000000000000408 T slc_lr_nthw_rcp_pcap
00000000000002d0 T slc_lr_nthw_rcp_select
00000000000003ba T slc_lr_nthw_rcp_tail_dyn
00000000000003e1 T slc_lr_nthw_rcp_tail_ofs
0000000000000393 T slc_lr_nthw_rcp_tail_slc_en
0000000000000000 T slc_lr_nthw_set_debug_mode
0000000000000060 T tx_cpy_nthw_delete
00000000000000a8 T tx_cpy_nthw_init
0000000000000027 T tx_cpy_nthw_new
0000000000000000 T tx_cpy_nthw_set_debug_mode
000000000000118a T tx_cpy_nthw_writer_cnt
00000000000011fa T tx_cpy_nthw_writer_dyn
00000000000012a2 T tx_cpy_nthw_writer_flush
000000000000126a T tx_cpy_nthw_writer_len
0000000000001232 T tx_cpy_nthw_writer_ofs
00000000000011c2 T tx_cpy_nthw_writer_reader_select
0000000000001152 T tx_cpy_nthw_writer_select
0000000000000060 T tx_ins_nthw_delete
0000000000000098 T tx_ins_nthw_init
0000000000000027 T tx_ins_nthw_new
0000000000000283 T tx_ins_nthw_rcp_cnt
00000000000002aa T tx_ins_nthw_rcp_dyn
000000000000031f T tx_ins_nthw_rcp_flush
00000000000002f8 T tx_ins_nthw_rcp_len
00000000000002d1 T tx_ins_nthw_rcp_ofs
000000000000025c T tx_ins_nthw_rcp_select
0000000000000000 T tx_ins_nthw_set_debug_mode
0000000000000060 T tx_rpl_nthw_delete
000000000000058e T tx_rpl_nthw_ext_cnt
00000000000005df T tx_rpl_nthw_ext_flush
00000000000005b5 T tx_rpl_nthw_ext_rpl_ptr
0000000000000567 T tx_rpl_nthw_ext_select
0000000000000098 T tx_rpl_nthw_init
0000000000000027 T tx_rpl_nthw_new
000000000000041d T tx_rpl_nthw_rcp_cnt
0000000000000444 T tx_rpl_nthw_rcp_dyn
0000000000000507 T tx_rpl_nthw_rcp_eth_type_wr
00000000000004e0 T tx_rpl_nthw_rcp_ext_prio
000000000000052e T tx_rpl_nthw_rcp_flush
0000000000000492 T tx_rpl_nthw_rcp_len
000000000000046b T tx_rpl_nthw_rcp_ofs
00000000000004b9 T tx_rpl_nthw_rcp_rpl_ptr
00000000000003f6 T tx_rpl_nthw_rcp_select
0000000000000645 T tx_rpl_nthw_rpl_cnt
00000000000006a1 T tx_rpl_nthw_rpl_flush
000000000000061b T tx_rpl_nthw_rpl_select
000000000000066f T tx_rpl_nthw_rpl_value
0000000000000000 T tx_rpl_nthw_set_debug_mode
000000000000115f T nthw_meter_init
0000000000002351 T nthw_field_clr_all
0000000000002371 T nthw_field_clr_flush
00000000000022c6 T nthw_field_flush_register
0000000000001dfa T nthw_field_get_bit_pos_high
0000000000001de9 T nthw_field_get_bit_pos_low
0000000000001dd8 T nthw_field_get_bit_width
0000000000001daf T nthw_field_get_debug_mode
0000000000001e16 T nthw_field_get_mask
0000000000002210 T nthw_field_get_signed
0000000000002270 T nthw_field_get_updated
0000000000001e4b T nthw_field_get_val
00000000000021e7 T nthw_field_get_val32
0000000000001b38 T nthw_field_init
0000000000001b1c T nthw_field_new
0000000000001e27 T nthw_field_reset
00000000000023a0 T nthw_field_set_all
0000000000001dc0 T nthw_field_set_debug_mode
00000000000023c0 T nthw_field_set_flush
0000000000001fbe T nthw_field_set_val
00000000000022e9 T nthw_field_set_val32
00000000000021af T nthw_field_set_val_flush
0000000000002313 T nthw_field_set_val_flush32
00000000000022a8 T nthw_field_update_register
00000000000025fd T nthw_field_wait_clr_all32
00000000000025d2 T nthw_field_wait_set_all32
0000000000002628 T nthw_field_wait_set_any32
00000000000003a6 T nthw_fpga_extract_prod_id
00000000000003d3 T nthw_fpga_extract_rev_id
000000000000038e T nthw_fpga_extract_type_id
00000000000003bb T nthw_fpga_extract_ver_id
0000000000000aed T nthw_fpga_get_product_id
0000000000000a92 T nthw_fpga_get_product_param
0000000000000403 T nthw_fpga_mgr_delete
000000000000041e T nthw_fpga_mgr_init
0000000000000611 T nthw_fpga_mgr_log_dump
00000000000003e7 T nthw_fpga_mgr_new
0000000000000551 T nthw_fpga_mgr_query_fpga
0000000000000753 T nthw_fpga_model_init
000000000000071a T nthw_fpga_model_new
0000000000000a6a T nthw_fpga_query_module
0000000000000363 T nthw_fpga_read_buildtime
0000000000000308 T nthw_fpga_read_ident
000000000000099c T nthw_fpga_set_debug_mode
0000000000000f8a T nthw_module_get_bus
0000000000000f11 T nthw_module_get_debug_mode
0000000000000d1b T nthw_module_get_major_version
0000000000000d2c T nthw_module_get_minor_version
0000000000000e2a T nthw_module_get_register
0000000000000d3d T nthw_module_get_version_packed64
0000000000000b7b T nthw_module_init
0000000000000d63 T nthw_module_is_version_newer
0000000000000b5f T nthw_module_new
0000000000000e08 T nthw_module_query_register
0000000000000f22 T nthw_module_set_debug_mode
0000000000000b1a T nthw_param_init
0000000000000afe T nthw_param_new
0000000000001ace T nthw_register_clr
00000000000018de T nthw_register_flush
00000000000011d9 T nthw_register_get_address
00000000000013d2 T nthw_register_get_bit_width
00000000000013e3 T nthw_register_get_debug_mode
00000000000012e5 T nthw_register_get_field
00000000000015ef T nthw_register_get_val
000000000000165a T nthw_register_get_val32
000000000000180b T nthw_register_get_val_updated32
0000000000000fb7 T nthw_register_init
0000000000001847 T nthw_register_make_dirty
0000000000000f9b T nthw_register_new
00000000000012c3 T nthw_register_query_field
00000000000011ea T nthw_register_reset
00000000000013f4 T nthw_register_set_debug_mode
000000000000187c T nthw_register_set_val
000000000000168a T nthw_register_update
0000000000000000 T nthw_platform_get_nthw_adapter_id
0000000000000f95 T nthw_rac_bar0_read32
0000000000000ff9 T nthw_rac_bar0_write32
0000000000000097 T nthw_rac_init
000000000000005e T nthw_rac_new
000000000000105d T nthw_rac_rab_dma_begin
000000000000125e T nthw_rac_rab_dma_commit
000000000000246d T nthw_rac_rab_flush
0000000000001295 T nthw_rac_rab_get_free
0000000000000c61 T nthw_rac_rab_init
0000000000001d79 T nthw_rac_rab_read32
0000000000001477 T nthw_rac_rab_read32_dma
0000000000000cb5 T nthw_rac_rab_reset
0000000000000d8d T nthw_rac_rab_setup
000000000000160f T nthw_rac_rab_write32
00000000000012c2 T nthw_rac_rab_write32_dma
000000000000005f T ntlog_helper_str_add
0000000000000000 T ntlog_helper_str_alloc
0000000000000152 T ntlog_helper_str_free
0000000000000199 T nt_dma_alloc
000000000000039d T nt_dma_free
0000000000000613 T nthw_convert_link_speed
0000000000000715 T nthw_string_to_u32
00000000000006e3 T nt_link_duplex_to_eth_duplex
000000000000057f T nt_link_speed_capa_to_eth_speed_capa
00000000000004b8 T nt_link_speed_to_eth_speed_num
000000000000013e T nt_os_get_time_monotonic_counter
0000000000000107 T nt_os_wait_usec
000000000000011f T nt_os_wait_usec_poll
0000000000000149 T nt_util_align_size
0000000000000175 T nt_util_vfio_init
00000000000000b2 T get_100g_link_ops
0000000000000182 T get_adapter_ops
00000000000000e6 T get_agx_100g_link_ops
00000000000001b6 T get_clk9563_ops
000000000000038a T get_dev_flow_ops
0000000000000356 T get_dev_fp_flow_ops
00000000000002ba T get_flow_backend_ops
0000000000000322 T get_flow_filter_ops
000000000000004a T get_meter_ops
000000000000014e T get_nt4ga_stat_ops
000000000000007e T get_ntnic_filter_ops
00000000000003be T get_ntnic_xstats_ops
000000000000011a T get_port_ops
00000000000002ee T get_profile_inline_ops
000000000000021e T get_rst9563_ops
0000000000000268 T get_rst9574_ops
00000000000001ea T get_rst_nt200a0x_ops
000000000000029c T get_rst_nt400dxx_ops
0000000000000016 T get_sg_ops
000000000000009c T register_100g_link_ops
000000000000016c T register_adapter_ops
00000000000000d0 T register_agx_100g_link_ops
00000000000001a0 T register_clk9563_ops
0000000000000374 T register_dev_flow_ops
0000000000000340 T register_dev_fp_flow_ops
000000000000023c T register_flow_backend_ops
000000000000030c T register_flow_filter_ops
0000000000000034 T register_meter_ops
0000000000000138 T register_nt4ga_stat_ops
0000000000000068 T register_ntnic_filter_ops
00000000000003a8 T register_ntnic_xstats_ops
0000000000000104 T register_port_ops
00000000000002d8 T register_profile_inline_ops
0000000000000208 T register_rst9563_ops
0000000000000252 T register_rst9574_ops
00000000000001d4 T register_rst_nt200a0x_ops
0000000000000286 T register_rst_nt400dxx_ops
0000000000000000 T register_sg_ops
0000000000000449 T nt_vfio_dma_map
0000000000000652 T nt_vfio_dma_unmap
000000000000078d T nt_vfio_init
0000000000000396 T nt_vfio_remove
0000000000000067 T nt_vfio_setup
0000000000000000 T nt_vfio_vf_num

Symbols used in only one file should be declared static.

--_000_VE1P190MB0830A9B6C3BADBFC05E052A48041AVE1P190MB0830EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Verdana, Geneva, sans-s=
erif; font-size: 11pt; color: rgb(0, 0, 0);">
Thanks for noticing it. We will take it into account and address the issue.=
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Stephen Hemminger &lt=
;stephen@networkplumber.org&gt;<br>
<b>Sent:</b> 29 June 2025 01:20<br>
<b>To:</b> Oleksandr Kolomeiets &lt;okl-plv@napatech.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Mykola Kostenok &lt;mko-plv@n=
apatech.com&gt;; Serhii Iliushyk &lt;sil-plv@napatech.com&gt;; Christian Ko=
ue Muf &lt;ckm@napatech.com&gt;<br>
<b>Subject:</b> Re: [PATCH v1 0/4] net/ntnic: implement start, stop and def=
erred start for Rx/Tx queues</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, 20 Jun 2025 13:27:03 +0200<br>
Oleksandr Kolomeiets &lt;okl-plv@napatech.com&gt; wrote:<br>
<br>
&gt; This patchset includes:<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * feature start/stop queues =
on HW layer.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * feature deferred start for=
 queues.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Improvement for memory map=
pings when IOMMU is unoptimized.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Improvement for logging<br=
>
&gt; <br>
&gt; Oleksandr Kolomeiets (4):<br>
&gt;&nbsp;&nbsp; net/ntnic: implement start/stop for Rx/Tx queues<br>
&gt;&nbsp;&nbsp; net/ntnic: implement deferred start for Rx/Tx queues<br>
&gt;&nbsp;&nbsp; net/ntnic: unmap DMA during queue release<br>
&gt;&nbsp;&nbsp; net/ntnic: add warning when sending on a stopped queue<br>
&gt; <br>
&gt;&nbsp; drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |&nbsp; 58 +++++--=
-<br>
&gt;&nbsp; drivers/net/ntnic/include/ntnic_dbs.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&gt;&nbsp; drivers/net/ntnic/include/ntos_drv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&gt;&nbsp; drivers/net/ntnic/nthw/dbs/nthw_dbs.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +++<br>
&gt;&nbsp; drivers/net/ntnic/ntnic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 132 ++++++++++++++++--<br>
&gt;&nbsp; drivers/net/ntnic/ntnic_mod_reg.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +-<br>
&gt;&nbsp; drivers/net/ntnic/ntnic_vfio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 -<=
br>
&gt;&nbsp; 7 files changed, 193 insertions(+), 40 deletions(-)<br>
&gt; <br>
<br>
Unrelated to this patch, this driver does not follow the convention about<b=
r>
naming external symbols. Since DPDK can be linked statically, and C does no=
t<br>
have namespaces; the same symbol in two places can be a problem.<br>
<br>
The common practice is to use a common prefix for all globals in a driver.<=
br>
In this driver that would be ntnic_<br>
<br>
Doing a debug build (so symbols are visible) and running nm to display<br>
global symbols gives:<br>
<br>
$ nm librte_net_ntnic.a | grep ' [TD] '<br>
<br>
<br>
0000000000000cf8 T nthw_adapter_init<br>
00000000000038ca T nt4ga_stat_ops_init<br>
0000000000002a11 T nthw_sg_init<br>
0000000000002094 T nthw_link_100g_init<br>
0000000000000000 T link_agx_100g_init<br>
0000000000000432 T nthw_port_init<br>
0000000000001bb4 T nim_agx_read_id<br>
00000000000019f6 T nim_agx_setup<br>
0000000000001781 T nthw_construct_and_preinit_nim<br>
000000000000099b T nthw_nim_id_to_text<br>
00000000000009f4 T nthw_nim_qsfp_plus_nim_set_tx_laser_disable<br>
0000000000000976 T nthw_nim_state_build<br>
00000000000018c1 T nthw_qsfp28_set_fec_enable<br>
000000000000186c T nthw_qsfp28_set_high_power<br>
0000000000000d59 T nthw_create_action_elements_inline<br>
0000000000000a75 T nthw_create_attr<br>
0000000000000b16 T nthw_create_match_elements<br>
0000000000003455 T nthw_dev_flow_init<br>
000000000000346b T nthw_dev_fp_flow_init<br>
00000000000000a9 T nthw_interpret_raw_data<br>
000000000000343f T ntnic_filter_init<br>
0000000000000d7e T ntnic_xstats_ops_init<br>
0000000000000039 T dbs_init<br>
00000000000011a3 T dbs_reset<br>
0000000000000000 T nthw_dbs_new<br>
0000000000003470 T nthw_dbs_set_tx_qp_data<br>
00000000000017e5 T nthw_get_rx_idle<br>
00000000000015d9 T nthw_get_rx_init<br>
00000000000018cf T nthw_get_tx_idle<br>
0000000000001703 T nthw_get_tx_init<br>
00000000000013a8 T nthw_set_rx_control<br>
000000000000176d T nthw_set_rx_idle<br>
0000000000001519 T nthw_set_rx_init<br>
000000000000145f T nthw_set_tx_control<br>
0000000000001857 T nthw_set_tx_idle<br>
0000000000001c88 T set_rx_am_data<br>
0000000000001cfb T set_rx_am_data_enable<br>
0000000000002eb1 T set_rx_dr_data<br>
00000000000024e1 T set_rx_uw_data<br>
0000000000001fd8 T set_tx_am_data<br>
000000000000204b T set_tx_am_data_enable<br>
00000000000032f0 T set_tx_dr_data<br>
0000000000001643 T set_tx_init<br>
0000000000002a9a T set_tx_uw_data<br>
00000000000048e0 D nthw_fpga_9563_055_049_0000<br>
0000000000004820 D nthw_fpga_9574_055_049_0000<br>
0000000000000000 D nthw_fpga_instances<br>
0000000000000000 D sa_nthw_fpga_mod_str_map<br>
000000000000001a T clk9563_ops_init<br>
000000000000028a T nt200a0x_ops_init<br>
00000000000008f8 T nt400dxx_ops_init<br>
0000000000000acf T rst9563_ops_init<br>
0000000000000dc8 T rst9574_ops_init<br>
0000000000001b75 T rst_nt200a0x_ops_init<br>
0000000000000f30 T rst_nt400dxx_ops_init<br>
0000000000001433 T get_nt200a0x_ops<br>
0000000000001467 T get_nt400dxx_ops<br>
0000000000000431 T nthw_fpga_avr_probe<br>
0000000000000000 T nthw_fpga_get_param_info<br>
00000000000001fc T nthw_fpga_iic_scan<br>
00000000000009ce T nthw_fpga_init<br>
00000000000013e5 T nthw_fpga_shutdown<br>
0000000000000942 T nthw_fpga_si5340_clock_synth_init_fmt2<br>
00000000000002a4 T nthw_fpga_silabs_detect<br>
000000000000141d T register_nt200a0x_ops<br>
0000000000001451 T register_nt400dxx_ops<br>
0000000000000000 T nthw_gmf_init<br>
0000000000000551 T nthw_gmf_set_enable<br>
000000000000058d T nthw_gmf_set_enable_tsi<br>
0000000000000000 T nthw_gfg_init<br>
0000000000000eff T nthw_gfg_stop<br>
0000000000000373 T nthw_tsm_get_time<br>
0000000000000309 T nthw_tsm_get_ts<br>
0000000000000039 T nthw_tsm_init<br>
0000000000000000 T nthw_tsm_new<br>
00000000000004f3 T nthw_tsm_set_config_ts_format<br>
00000000000003dd T nthw_tsm_set_timer_t0_enable<br>
000000000000042d T nthw_tsm_set_timer_t0_max_count<br>
0000000000000468 T nthw_tsm_set_timer_t1_enable<br>
00000000000004b8 T nthw_tsm_set_timer_t1_max_count<br>
0000000000000000 T nthw_gpio_phy_init<br>
0000000000000408 T nthw_gpio_phy_is_module_present<br>
000000000000045a T nthw_gpio_phy_set_low_power<br>
0000000000000507 T nthw_gpio_phy_set_reset<br>
0000000000000039 T nthw_hif_delete<br>
0000000000000d57 T nthw_hif_end_point_counters_sample<br>
00000000000009f4 T nthw_hif_force_soft_reset<br>
0000000000000a5f T nthw_hif_get_stat<br>
0000000000000b84 T nthw_hif_get_stat_rate<br>
0000000000000054 T nthw_hif_init<br>
0000000000000000 T nthw_hif_new<br>
0000000000000db3 T nthw_hif_read_test_reg<br>
0000000000000d0b T nthw_hif_stat_req_disable<br>
0000000000000cbf T nthw_hif_stat_req_enable<br>
0000000000000a34 T nthw_hif_trigger_sample_time<br>
0000000000000ead T nthw_hif_write_test_reg<br>
000000000000004e T nthw_i2cm_init<br>
0000000000000015 T nthw_i2cm_new<br>
0000000000000bb4 T nthw_i2cm_read<br>
0000000000000c1f T nthw_i2cm_write<br>
0000000000000c85 T nthw_i2cm_write16<br>
0000000000000039 T nthw_igam_init<br>
0000000000000000 T nthw_igam_new<br>
0000000000000223 T nthw_igam_read<br>
0000000000000325 T nthw_igam_set_ctrl_forward_rst<br>
000000000000029f T nthw_igam_write<br>
000000000000129b T nthw_iic_bus_ready<br>
0000000000001323 T nthw_iic_data_ready<br>
0000000000000a86 T nthw_iic_delete<br>
00000000000003e7 T nthw_iic_init<br>
00000000000003ae T nthw_iic_new<br>
0000000000000d60 T nthw_iic_readbyte<br>
0000000000000b34 T nthw_iic_read_data<br>
0000000000001475 T nthw_iic_scan<br>
00000000000013ab T nthw_iic_scan_dev_addr<br>
0000000000000aa1 T nthw_iic_set_retry_params<br>
0000000000001083 T nthw_iic_writebyte<br>
0000000000000f36 T nthw_iic_write_data<br>
000000000000180c T nthw_mac_pcs_get_fec_bypass<br>
0000000000001858 T nthw_mac_pcs_get_fec_stat_all_am_locked<br>
0000000000001832 T nthw_mac_pcs_get_fec_valid<br>
0000000000002184 T nthw_mac_pcs_get_fld_block_lock_lock<br>
00000000000021a2 T nthw_mac_pcs_get_fld_block_lock_lock_mask<br>
00000000000021b3 T nthw_mac_pcs_get_fld_lane_lock_lock<br>
00000000000021d1 T nthw_mac_pcs_get_fld_lane_lock_lock_mask<br>
00000000000014ee T nthw_mac_pcs_get_hi_ber<br>
0000000000001514 T nthw_mac_pcs_get_link_summary<br>
0000000000000000 T nthw_mac_pcs_init<br>
0000000000001279 T nthw_mac_pcs_is_rx_path_rst<br>
00000000000014ad T nthw_mac_pcs_reset_bip_counters<br>
00000000000018e1 T nthw_mac_pcs_reset_fec_counters<br>
000000000000168a T nthw_mac_pcs_reset_required<br>
0000000000001224 T nthw_mac_pcs_rx_path_rst<br>
00000000000016ff T nthw_mac_pcs_set_fec<br>
0000000000001a12 T nthw_mac_pcs_set_gty_tx_tuning<br>
000000000000129f T nthw_mac_pcs_set_host_loopback<br>
00000000000020d9 T nthw_mac_pcs_set_led_mode<br>
00000000000013a6 T nthw_mac_pcs_set_line_loopback<br>
000000000000216a T nthw_mac_pcs_set_port_no<br>
0000000000001cda T nthw_mac_pcs_set_receiver_equalization_mode<br>
0000000000001016 T nthw_mac_pcs_set_rx_enable<br>
0000000000002119 T nthw_mac_pcs_set_timestamp_comp_rx<br>
000000000000116a T nthw_mac_pcs_set_ts_eop<br>
000000000000106b T nthw_mac_pcs_set_tx_enable<br>
00000000000010c0 T nthw_mac_pcs_set_tx_sel_host<br>
0000000000001115 T nthw_mac_pcs_set_tx_sel_tfg<br>
0000000000001fc1 T nthw_mac_pcs_swap_gty_rx_polarity<br>
0000000000001ea9 T nthw_mac_pcs_swap_gty_tx_polarity<br>
00000000000011cf T nthw_mac_pcs_tx_path_rst<br>
0000000000000039 T nthw_pcie3_delete<br>
0000000000000a77 T nthw_pcie3_end_point_counters_sample_post<br>
000000000000085b T nthw_pcie3_get_stat<br>
000000000000091d T nthw_pcie3_get_stat_rate<br>
0000000000000054 T nthw_pcie3_init<br>
0000000000000000 T nthw_pcie3_new<br>
0000000000000818 T nthw_pcie3_stat_req_disable<br>
00000000000007d5 T nthw_pcie3_stat_req_enable<br>
00000000000007aa T nthw_pcie3_trigger_sample_time<br>
0000000000000082 T nthw_pca9532_init<br>
0000000000000049 T nthw_pca9532_new<br>
00000000000000d3 T nthw_pca9532_set_led_on<br>
0000000000000092 T nthw_pcal6416a_init<br>
0000000000000049 T nthw_pcal6416a_new<br>
000000000000027e T nthw_pcal6416a_read<br>
00000000000000e3 T nthw_pcal6416a_write<br>
0000000000000262 T nthw_pcm_nt400dxx_get_ts_pll_locked_latch<br>
000000000000023f T nthw_pcm_nt400dxx_get_ts_pll_locked_stat<br>
0000000000000039 T nthw_pcm_nt400dxx_init<br>
0000000000000000 T nthw_pcm_nt400dxx_new<br>
0000000000000285 T nthw_pcm_nt400dxx_set_ts_pll_locked_latch<br>
00000000000001fb T nthw_pcm_nt400dxx_set_ts_pll_recal<br>
0000000000002868 T nthw_phy_tile_configure_fec<br>
000000000000241a T nthw_phy_tile_get_link_summary<br>
0000000000001a43 T nthw_phy_tile_get_no_intfs<br>
0000000000003130 T nthw_phy_tile_get_port_status_reset_ack<br>
0000000000003187 T nthw_phy_tile_get_port_status_tx_lanes_stable<br>
0000000000002616 T nthw_phy_tile_get_rx_am_lock<br>
00000000000025e2 T nthw_phy_tile_get_rx_hi_ber<br>
0000000000003221 T nthw_phy_tile_get_sys_pll_get_rdy<br>
00000000000032de T nthw_phy_tile_get_sys_pll_ref_clk_fgt_enabled<br>
0000000000003259 T nthw_phy_tile_get_sys_pll_system_pll_lock<br>
000000000000269d T nthw_phy_tile_get_timestamp_comp_rx<br>
0000000000000039 T nthw_phy_tile_init<br>
0000000000000000 T nthw_phy_tile_new<br>
00000000000026e8 T nthw_phy_tile_read_eth<br>
00000000000024fc T nthw_phy_tile_read_fec_enabled_by_scratch<br>
0000000000001d0c T nthw_phy_tile_read_xcvr<br>
00000000000022d7 T nthw_phy_tile_set_host_loopback<br>
00000000000033b0 T nthw_phy_tile_set_port_config_rst<br>
000000000000229c T nthw_phy_tile_set_rx_pol_inv<br>
0000000000001adc T nthw_phy_tile_set_rx_reset<br>
0000000000003291 T nthw_phy_tile_set_sys_pll_en_ref_clk_fgt<br>
0000000000003363 T nthw_phy_tile_set_sys_pll_force_rst<br>
0000000000003316 T nthw_phy_tile_set_sys_pll_forward_rst<br>
00000000000031d4 T nthw_phy_tile_set_sys_pll_set_rdy<br>
0000000000002649 T nthw_phy_tile_set_timestamp_comp_rx<br>
000000000000234e T nthw_phy_tile_set_tx_equalization<br>
0000000000002261 T nthw_phy_tile_set_tx_pol_inv<br>
0000000000001bf3 T nthw_phy_tile_set_tx_reset<br>
0000000000001a1b T nthw_phy_tile_use_phy_tile_pll_check<br>
00000000000027a3 T nthw_phy_tile_write_eth<br>
0000000000001e0f T nthw_phy_tile_write_xcvr<br>
0000000000000039 T nthw_prm_nt400dxx_init<br>
0000000000000000 T nthw_prm_nt400dxx_new<br>
0000000000000173 T nthw_prm_nt400dxx_periph_rst<br>
00000000000001aa T nthw_prm_nt400dxx_platform_rst<br>
0000000000000082 T nthw_pca9849_init<br>
0000000000000049 T nthw_pca9849_new<br>
00000000000000b8 T nthw_pca9849_set_channel<br>
00000000000003c8 T nthw_si5156_init<br>
000000000000038f T nthw_si5156_new<br>
0000000000000419 T nthw_si5156_write16<br>
00000000000001b8 T nthw_si5332_clock_active<br>
0000000000000167 T nthw_si5332_init<br>
000000000000012e T nthw_si5332_new<br>
000000000000030c T nthw_si5332_write<br>
0000000000000262 T nthw_rpf_administrative_block<br>
000000000000029e T nthw_rpf_block<br>
000000000000004e T nthw_rpf_delete<br>
000000000000037c T nthw_rpf_get_maturing_delay<br>
00000000000003e4 T nthw_rpf_get_ts_at_eof<br>
0000000000000069 T nthw_rpf_init<br>
0000000000000015 T nthw_rpf_new<br>
0000000000000345 T nthw_rpf_set_maturing_delay<br>
00000000000003aa T nthw_rpf_set_ts_at_eof<br>
00000000000002d2 T nthw_rpf_unblock<br>
00000000000003f6 T nthw_rmc_block<br>
0000000000000392 T nthw_rmc_get_dbg_merge<br>
00000000000003c4 T nthw_rmc_get_mac_if_err<br>
0000000000000360 T nthw_rmc_get_status_descr_fifo_of<br>
000000000000032e T nthw_rmc_get_status_sf_ram_of<br>
0000000000000039 T nthw_rmc_init<br>
0000000000000000 T nthw_rmc_new<br>
0000000000000444 T nthw_rmc_unblock<br>
0000000000000039 T nthw_sdc_delete<br>
000000000000034e T nthw_sdc_get_states<br>
0000000000000054 T nthw_sdc_init<br>
0000000000000000 T nthw_sdc_new<br>
0000000000000569 T nthw_sdc_wait_states<br>
00000000000003f7 T nthw_si5340_config<br>
00000000000005a8 T nthw_si5340_config_fmt2<br>
00000000000000b3 T nthw_si5340_delete<br>
0000000000000039 T nthw_si5340_init<br>
0000000000000000 T nthw_si5340_new<br>
0000000000000447 T nthw_spim_enable<br>
00000000000004d5 T nthw_spim_get_tx_fifo_empty<br>
0000000000000039 T nthw_spim_init<br>
0000000000000000 T nthw_spim_new<br>
00000000000003fa T nthw_spim_reset<br>
00000000000004a7 T nthw_spim_write_tx_fifo<br>
00000000000004ea T nthw_spis_enable<br>
000000000000054a T nthw_spis_get_rx_fifo_empty<br>
0000000000000039 T nthw_spis_init<br>
0000000000000000 T nthw_spis_new<br>
000000000000057c T nthw_spis_read_rx_fifo<br>
000000000000049d T nthw_spis_reset<br>
000000000000023b T nthw_spi_v3_init<br>
0000000000000000 T nthw_spi_v3_new<br>
000000000000044e T nthw_spi_v3_transfer<br>
0000000000000039 T nthw_stat_delete<br>
0000000000000ec2 T nthw_stat_get_load_bps_rx<br>
0000000000000f72 T nthw_stat_get_load_bps_tx<br>
0000000000001022 T nthw_stat_get_load_pps_rx<br>
00000000000010d2 T nthw_stat_get_load_pps_tx<br>
0000000000000054 T nthw_stat_init<br>
0000000000000000 T nthw_stat_new<br>
0000000000000ce5 T nthw_stat_set_dma_address<br>
0000000000000e3e T nthw_stat_trigger<br>
0000000000000000 D dbg_res_descr<br>
0000000000001aa1 T nthw_flow_api_create<br>
0000000000001f1c T nthw_flow_api_done<br>
0000000000001fc7 T nthw_flow_api_get_be_dev<br>
0000000000000f38 T nthw_flow_delete_eth_dev<br>
0000000000002950 T nthw_flow_get_flm_stats<br>
00000000000029af T nthw_flow_get_ifr_stats<br>
00000000000000a1 T nthw_flow_nic_alloc_resource<br>
000000000000024f T nthw_flow_nic_alloc_resource_config<br>
000000000000069a T nthw_flow_nic_deref_resource<br>
00000000000004a6 T nthw_flow_nic_free_resource<br>
0000000000000596 T nthw_flow_nic_ref_resource<br>
000000000000005e T nthw_flow_nic_set_error<br>
0000000000002a0e T nthw_init_flow_filter<br>
0000000000002032 T sprint_nt_rss_mask<br>
0000000000000000 T nthw_flow_group_handle_create<br>
00000000000000ef T nthw_flow_group_handle_destroy<br>
0000000000000153 T nthw_flow_group_translate_get<br>
0000000000000322 T nthw_flow_group_translate_get_orig_group<br>
000000000000014b T ntnic_id_table_create<br>
000000000000018c T ntnic_id_table_destroy<br>
0000000000000361 T ntnic_id_table_find<br>
0000000000000285 T ntnic_id_table_free_id<br>
00000000000001d7 T ntnic_id_table_get_id<br>
0000000000000000 T nthw_callocate_mod<br>
000000000000061b T nthw_flow_api_backend_done<br>
000000000000037a T nthw_flow_api_backend_init<br>
0000000000000346 T nthw_zero_module_cache<br>
0000000000000100 T flm_age_event_clear<br>
00000000000000b3 T flm_age_event_get<br>
00000000000000d8 T flm_age_event_set<br>
0000000000002680 T flm_age_queue_count<br>
000000000000021e T flm_age_queue_create<br>
0000000000000128 T flm_age_queue_free<br>
00000000000001d6 T flm_age_queue_free_all<br>
00000000000015a0 T flm_age_queue_get<br>
00000000000026e4 T flm_age_queue_get_size<br>
00000000000004c9 T flm_age_queue_put<br>
0000000000000036 T flm_lrn_queue_create<br>
000000000000006c T flm_lrn_queue_free<br>
00000000000008da T flm_lrn_queue_get_read_buffer<br>
0000000000000087 T flm_lrn_queue_get_write_buffer<br>
0000000000000fc2 T flm_lrn_queue_release_read_buffer<br>
0000000000000767 T flm_lrn_queue_release_write_buffer<br>
0000000000003c7c T nthw_flm_inf_queue_get<br>
00000000000018e4 T nthw_flm_inf_queue_put<br>
000000000000028f T nthw_flm_inf_sta_queue_free_all<br>
000000000000079a T nthw_flm_sta_queue_put<br>
000000000000e97b T done_flow_management_of_ndev_profile_inline<br>
0000000000010e5f T flow_actions_template_create_profile_inline<br>
000000000001106e T flow_actions_template_destroy_profile_inline<br>
000000000000f6e3 T flow_actions_update_profile_inline<br>
0000000000011448 T flow_async_create_profile_inline<br>
0000000000011c73 T flow_async_destroy_profile_inline<br>
00000000000109f4 T flow_configure_profile_inline<br>
000000000000ede6 T flow_create_profile_inline<br>
000000000000f286 T flow_destroy_locked_profile_inline<br>
000000000000f4f5 T flow_destroy_profile_inline<br>
00000000000100cf T flow_dev_dump_profile_inline<br>
000000000000f5be T flow_flush_profile_inline<br>
000000000000ffad T flow_get_aged_flows_profile_inline<br>
0000000000010424 T flow_get_flm_stats_profile_inline<br>
0000000000010640 T flow_get_ifr_stats_profile_inline<br>
0000000000010953 T flow_info_get_profile_inline<br>
0000000000010cd3 T flow_pattern_template_create_profile_inline<br>
0000000000010e18 T flow_pattern_template_destroy_profile_inline<br>
00000000000106fb T flow_set_mtu_inline<br>
00000000000110b5 T flow_template_table_create_profile_inline<br>
000000000001135b T flow_template_table_destroy_profile_inline<br>
000000000000d015 T initialize_flow_management_of_ndev_profile_inline<br>
0000000000011d4f T profile_inline_init<br>
0000000000005514 T hw_db_inline_action_set_add<br>
0000000000005704 T hw_db_inline_action_set_deref<br>
000000000000569a T hw_db_inline_action_set_ref<br>
0000000000008294 T hw_db_inline_cat_add<br>
0000000000008460 T hw_db_inline_cat_deref<br>
0000000000008401 T hw_db_inline_cat_ref<br>
000000000000583e T hw_db_inline_cot_add<br>
00000000000059f8 T hw_db_inline_cot_deref<br>
000000000000599b T hw_db_inline_cot_ref<br>
0000000000000000 T hw_db_inline_create<br>
000000000000080b T hw_db_inline_deref_idxs<br>
000000000000064b T hw_db_inline_destroy<br>
0000000000000c1c T hw_db_inline_dump<br>
00000000000022c3 T hw_db_inline_dump_cfn<br>
0000000000002385 T hw_db_inline_find_data<br>
0000000000000bb5 T hw_db_inline_find_idx<br>
0000000000008d4c T hw_db_inline_flm_add<br>
00000000000092a3 T hw_db_inline_flm_deref<br>
00000000000095bb T hw_db_inline_flm_ft_add<br>
000000000000940a T hw_db_inline_flm_ft_default<br>
00000000000098cd T hw_db_inline_flm_ft_deref<br>
0000000000009817 T hw_db_inline_flm_ft_ref<br>
0000000000009235 T hw_db_inline_flm_ref<br>
0000000000009a91 T hw_db_inline_hsh_add<br>
0000000000009e62 T hw_db_inline_hsh_deref<br>
0000000000009e03 T hw_db_inline_hsh_ref<br>
0000000000008556 T hw_db_inline_km_add<br>
00000000000086ee T hw_db_inline_km_deref<br>
0000000000008834 T hw_db_inline_km_ft_add<br>
0000000000008a83 T hw_db_inline_km_ft_deref<br>
00000000000089e4 T hw_db_inline_km_ft_ref<br>
0000000000008695 T hw_db_inline_km_ref<br>
0000000000004f7d T hw_db_inline_match_set_add<br>
0000000000005290 T hw_db_inline_match_set_deref<br>
0000000000005222 T hw_db_inline_match_set_ref<br>
0000000000005c5e T hw_db_inline_qsl_add<br>
0000000000006244 T hw_db_inline_qsl_deref<br>
00000000000061fc T hw_db_inline_qsl_ref<br>
000000000000a02a T hw_db_inline_scrub_add<br>
000000000000a3ea T hw_db_inline_scrub_deref<br>
000000000000a38b T hw_db_inline_scrub_ref<br>
000000000000290f T hw_db_inline_setup_mbr_filter<br>
00000000000064ad T hw_db_inline_slc_lr_add<br>
000000000000672c T hw_db_inline_slc_lr_deref<br>
00000000000066cd T hw_db_inline_slc_lr_ref<br>
0000000000006ca7 T hw_db_inline_tpe_add<br>
000000000000783b T hw_db_inline_tpe_deref<br>
0000000000007b4b T hw_db_inline_tpe_ext_add<br>
0000000000007ebc T hw_db_inline_tpe_ext_deref<br>
0000000000007e51 T hw_db_inline_tpe_ext_ref<br>
00000000000077dc T hw_db_inline_tpe_ref<br>
0000000000000000 D flow_be_iface<br>
0000000000008436 T nthw_bin_flow_backend_init<br>
0000000000008c88 T nthw_flow_backend_init<br>
0000000000000113 T nthw_flow_filter_done<br>
0000000000000000 T nthw_flow_filter_init<br>
00000000000005c1 T nthw_gethash<br>
000000000000065f T nthw_init_hasher<br>
0000000000000506 T hsh_set<br>
0000000000000000 T kcc_free_ndev_resource_management<br>
0000000000000270 T km_add_match_elem<br>
0000000000000000 T km_attach_ndev_resource_management<br>
00000000000032e0 T km_clear_data_match_entry<br>
0000000000000203 T km_free_ndev_resource_management<br>
0000000000000cc5 T km_key_compare<br>
0000000000000555 T km_key_create<br>
00000000000010c2 T km_rcp_set<br>
0000000000003242 T km_write_data_match_entry<br>
0000000000000029 T hw_mod_cat_alloc<br>
0000000000006d3a T hw_mod_cat_cct_flush<br>
00000000000015ce T hw_mod_cat_cfn_flush<br>
0000000000004fd8 T hw_mod_cat_cfn_set<br>
0000000000006667 T hw_mod_cat_cot_flush<br>
0000000000006d07 T hw_mod_cat_cot_set<br>
0000000000006054 T hw_mod_cat_cte_flush<br>
00000000000062d8 T hw_mod_cat_cte_get<br>
00000000000062a5 T hw_mod_cat_cte_set<br>
000000000000630c T hw_mod_cat_cts_flush<br>
0000000000006633 T hw_mod_cat_cts_get<br>
0000000000006600 T hw_mod_cat_cts_set<br>
0000000000006ea2 T hw_mod_cat_exo_flush<br>
0000000000000a3d T hw_mod_cat_free<br>
0000000000005c53 T hw_mod_cat_fte_flm_flush<br>
000000000000600b T hw_mod_cat_fte_flm_get<br>
0000000000005fc2 T hw_mod_cat_fte_flm_set<br>
0000000000005c1d T hw_mod_cat_fte_km_flush<br>
0000000000005f79 T hw_mod_cat_fte_km_get<br>
0000000000005f30 T hw_mod_cat_fte_km_set<br>
0000000000006df1 T hw_mod_cat_kcc_flush<br>
000000000000523e T hw_mod_cat_kce_flm_flush<br>
00000000000055ca T hw_mod_cat_kce_flm_get<br>
0000000000005581 T hw_mod_cat_kce_flm_set<br>
0000000000005208 T hw_mod_cat_kce_km_flush<br>
0000000000005538 T hw_mod_cat_kce_km_get<br>
00000000000054ef T hw_mod_cat_kce_km_set<br>
0000000000005729 T hw_mod_cat_kcs_flm_flush<br>
0000000000005ab2 T hw_mod_cat_kcs_flm_get<br>
0000000000005a69 T hw_mod_cat_kcs_flm_set<br>
00000000000056f3 T hw_mod_cat_kcs_km_flush<br>
0000000000005a20 T hw_mod_cat_kcs_km_get<br>
00000000000059d7 T hw_mod_cat_kcs_km_set<br>
000000000000700a T hw_mod_cat_len_flush<br>
0000000000000000 T hw_mod_cat_present<br>
0000000000006f53 T hw_mod_cat_rck_flush<br>
0000000000000e9b T hw_mod_cat_reset<br>
0000000000000029 T hw_mod_flm_alloc<br>
000000000000363d T hw_mod_flm_buf_ctrl_get<br>
0000000000003416 T hw_mod_flm_buf_ctrl_update<br>
0000000000000cda T hw_mod_flm_control_flush<br>
0000000000001594 T hw_mod_flm_control_set<br>
0000000000000be2 T hw_mod_flm_free<br>
0000000000003d51 T hw_mod_flm_inf_sta_data_update_get<br>
0000000000001c5d T hw_mod_flm_load_bin_flush<br>
0000000000001dcf T hw_mod_flm_load_bin_set<br>
0000000000003bf9 T hw_mod_flm_lrn_data_set_flush<br>
0000000000000000 T hw_mod_flm_present<br>
0000000000001dfb T hw_mod_flm_prio_flush<br>
000000000000227c T hw_mod_flm_prio_set<br>
00000000000022a8 T hw_mod_flm_pst_flush<br>
0000000000002644 T hw_mod_flm_pst_set<br>
0000000000002677 T hw_mod_flm_rcp_flush<br>
00000000000033d3 T hw_mod_flm_rcp_set<br>
000000000000338f T hw_mod_flm_rcp_set_mask<br>
0000000000000c23 T hw_mod_flm_reset<br>
0000000000001abc T hw_mod_flm_scan_flush<br>
0000000000001c31 T hw_mod_flm_scan_set<br>
0000000000002731 T hw_mod_flm_scrub_flush<br>
000000000000418d T hw_mod_flm_scrub_set<br>
0000000000003e9d T hw_mod_flm_scrub_timeout_decode<br>
0000000000003f18 T hw_mod_flm_scrub_timeout_encode<br>
000000000000369e T hw_mod_flm_stat_get<br>
0000000000003667 T hw_mod_flm_stat_update<br>
0000000000001a8f T hw_mod_flm_status_get<br>
00000000000015c0 T hw_mod_flm_status_update<br>
0000000000000029 T hw_mod_hsh_alloc<br>
000000000000030c T hw_mod_hsh_free<br>
0000000000000000 T hw_mod_hsh_present<br>
00000000000003c2 T hw_mod_hsh_rcp_flush<br>
0000000000001721 T hw_mod_hsh_rcp_set<br>
000000000000034d T hw_mod_hsh_reset<br>
0000000000000029 T hw_mod_km_alloc<br>
000000000000250c T hw_mod_km_cam_flush<br>
0000000000002edd T hw_mod_km_cam_set<br>
00000000000006a5 T hw_mod_km_free<br>
0000000000000000 T hw_mod_km_present<br>
0000000000000916 T hw_mod_km_rcp_flush<br>
00000000000024cf T hw_mod_km_rcp_get<br>
0000000000002492 T hw_mod_km_rcp_set<br>
00000000000006e6 T hw_mod_km_reset<br>
0000000000002f1a T hw_mod_km_tcam_flush<br>
000000000000347b T hw_mod_km_tcam_get<br>
0000000000003430 T hw_mod_km_tcam_set<br>
00000000000034c6 T hw_mod_km_tci_flush<br>
00000000000037e3 T hw_mod_km_tci_set<br>
0000000000003820 T hw_mod_km_tcq_flush<br>
0000000000000029 T hw_mod_pdb_alloc<br>
00000000000013c6 T hw_mod_pdb_config_flush<br>
0000000000000269 T hw_mod_pdb_free<br>
0000000000000000 T hw_mod_pdb_present<br>
000000000000036c T hw_mod_pdb_rcp_flush<br>
0000000000001393 T hw_mod_pdb_rcp_set<br>
00000000000002aa T hw_mod_pdb_reset<br>
0000000000000029 T hw_mod_qsl_alloc<br>
0000000000000350 T hw_mod_qsl_free<br>
0000000000000000 T hw_mod_qsl_present<br>
00000000000014f1 T hw_mod_qsl_qen_flush<br>
000000000000176a T hw_mod_qsl_qen_get<br>
0000000000001737 T hw_mod_qsl_qen_set<br>
0000000000000fa5 T hw_mod_qsl_qst_flush<br>
00000000000014be T hw_mod_qsl_qst_set<br>
0000000000000509 T hw_mod_qsl_rcp_flush<br>
0000000000000f72 T hw_mod_qsl_rcp_set<br>
0000000000000391 T hw_mod_qsl_reset<br>
000000000000179e T hw_mod_qsl_unmq_flush<br>
0000000000001a41 T hw_mod_qsl_unmq_set<br>
0000000000000029 T hw_mod_slc_lr_alloc<br>
000000000000019a T hw_mod_slc_lr_free<br>
0000000000000000 T hw_mod_slc_lr_present<br>
0000000000000250 T hw_mod_slc_lr_rcp_flush<br>
0000000000000b39 T hw_mod_slc_lr_rcp_set<br>
00000000000001db T hw_mod_slc_lr_reset<br>
0000000000000029 T hw_mod_tpe_alloc<br>
000000000000318a T hw_mod_tpe_cpy_rcp_flush<br>
0000000000003878 T hw_mod_tpe_cpy_rcp_set<br>
00000000000049f0 T hw_mod_tpe_csu_rcp_flush<br>
00000000000050f4 T hw_mod_tpe_csu_rcp_set<br>
00000000000006ac T hw_mod_tpe_free<br>
00000000000038ab T hw_mod_tpe_hfu_rcp_flush<br>
00000000000049bd T hw_mod_tpe_hfu_rcp_set<br>
00000000000015ce T hw_mod_tpe_ifr_counters_get<br>
000000000000159b T hw_mod_tpe_ifr_counters_set<br>
000000000000148b T hw_mod_tpe_ifr_counters_update<br>
0000000000001156 T hw_mod_tpe_ifr_rcp_flush<br>
0000000000001458 T hw_mod_tpe_ifr_rcp_set<br>
0000000000001602 T hw_mod_tpe_ins_rcp_flush<br>
0000000000001c84 T hw_mod_tpe_ins_rcp_set<br>
0000000000000000 T hw_mod_tpe_present<br>
00000000000006ed T hw_mod_tpe_reset<br>
0000000000002594 T hw_mod_tpe_rpl_ext_flush<br>
0000000000002b81 T hw_mod_tpe_rpl_ext_set<br>
0000000000001cb7 T hw_mod_tpe_rpl_rcp_flush<br>
0000000000002561 T hw_mod_tpe_rpl_rcp_set<br>
0000000000002bb4 T hw_mod_tpe_rpl_rpl_flush<br>
0000000000003156 T hw_mod_tpe_rpl_rpl_set<br>
0000000000000862 T hw_mod_tpe_rpp_ifr_rcp_flush<br>
0000000000000b64 T hw_mod_tpe_rpp_ifr_rcp_set<br>
0000000000000b97 T hw_mod_tpe_rpp_rcp_flush<br>
0000000000001123 T hw_mod_tpe_rpp_rcp_set<br>
00000000000024b1 T cat_nthw_cct_cnt<br>
00000000000024db T cat_nthw_cct_color<br>
000000000000252f T cat_nthw_cct_flush<br>
0000000000002505 T cat_nthw_cct_km<br>
0000000000002487 T cat_nthw_cct_select<br>
00000000000015fc T cat_nthw_cfn_cnt<br>
0000000000001623 T cat_nthw_cfn_enable<br>
0000000000001acd T cat_nthw_cfn_err_cv<br>
0000000000001af7 T cat_nthw_cfn_err_fcs<br>
0000000000001aa3 T cat_nthw_cfn_err_inv<br>
00000000000019a7 T cat_nthw_cfn_err_l3_cs<br>
00000000000019d1 T cat_nthw_cfn_err_l4_cs<br>
00000000000019fb T cat_nthw_cfn_err_tnl_l3_cs<br>
0000000000001a25 T cat_nthw_cfn_err_tnl_l4_cs<br>
0000000000001a79 T cat_nthw_cfn_err_tnl_ttl_exp<br>
0000000000001b21 T cat_nthw_cfn_err_trunc<br>
0000000000001a4f T cat_nthw_cfn_err_ttl_exp<br>
0000000000001d54 T cat_nthw_cfn_flush<br>
000000000000164a T cat_nthw_cfn_inv<br>
0000000000001d00 T cat_nthw_cfn_km0_or<br>
0000000000001d2a T cat_nthw_cfn_km1_or<br>
0000000000001cac T cat_nthw_cfn_lc<br>
0000000000001cd6 T cat_nthw_cfn_lc_inv<br>
0000000000001b4b T cat_nthw_cfn_mac_port<br>
0000000000001c2e T cat_nthw_cfn_pm_and_inv<br>
0000000000001c04 T cat_nthw_cfn_pm_cmb<br>
0000000000001b75 T cat_nthw_cfn_pm_cmp<br>
0000000000001bb0 T cat_nthw_cfn_pm_dct<br>
0000000000001bda T cat_nthw_cfn_pm_ext_inv<br>
0000000000001c82 T cat_nthw_cfn_pm_inv<br>
0000000000001c58 T cat_nthw_cfn_pm_or_inv<br>
0000000000001980 T cat_nthw_cfn_ptc_cfp<br>
00000000000017b2 T cat_nthw_cfn_ptc_frag<br>
0000000000001671 T cat_nthw_cfn_ptc_inv<br>
00000000000017dc T cat_nthw_cfn_ptc_ip_prot<br>
0000000000001698 T cat_nthw_cfn_ptc_isl<br>
00000000000016e6 T cat_nthw_cfn_ptc_l2<br>
0000000000001788 T cat_nthw_cfn_ptc_l3<br>
0000000000001806 T cat_nthw_cfn_ptc_l4<br>
00000000000016bf T cat_nthw_cfn_ptc_mac<br>
000000000000175e T cat_nthw_cfn_ptc_mpls<br>
0000000000001902 T cat_nthw_cfn_ptc_tnl_frag<br>
000000000000192c T cat_nthw_cfn_ptc_tnl_ip_prot<br>
000000000000185a T cat_nthw_cfn_ptc_tnl_l2<br>
00000000000018d8 T cat_nthw_cfn_ptc_tnl_l3<br>
0000000000001956 T cat_nthw_cfn_ptc_tnl_l4<br>
00000000000018ae T cat_nthw_cfn_ptc_tnl_mpls<br>
0000000000001884 T cat_nthw_cfn_ptc_tnl_vlan<br>
0000000000001830 T cat_nthw_cfn_ptc_tunnel<br>
0000000000001734 T cat_nthw_cfn_ptc_vlan<br>
000000000000170d T cat_nthw_cfn_ptc_vn_tag<br>
00000000000015d5 T cat_nthw_cfn_select<br>
00000000000023ca T cat_nthw_cot_cnt<br>
00000000000023f4 T cat_nthw_cot_color<br>
0000000000002448 T cat_nthw_cot_flush<br>
000000000000241e T cat_nthw_cot_km<br>
00000000000023a0 T cat_nthw_cot_select<br>
0000000000002082 T cat_nthw_cte_cnt<br>
00000000000020ac T cat_nthw_cte_enable_col<br>
00000000000020d6 T cat_nthw_cte_enable_cor<br>
0000000000002226 T cat_nthw_cte_enable_epp<br>
0000000000002100 T cat_nthw_cte_enable_hsh<br>
00000000000021fc T cat_nthw_cte_enable_hst<br>
0000000000002154 T cat_nthw_cte_enable_ipf<br>
00000000000021d2 T cat_nthw_cte_enable_msk<br>
00000000000021a8 T cat_nthw_cte_enable_pdb<br>
000000000000212a T cat_nthw_cte_enable_qsl<br>
000000000000217e T cat_nthw_cte_enable_slc<br>
0000000000002250 T cat_nthw_cte_enable_tpe<br>
000000000000227a T cat_nthw_cte_flush<br>
0000000000002058 T cat_nthw_cte_select<br>
000000000000230d T cat_nthw_cts_cat_a<br>
0000000000002337 T cat_nthw_cts_cat_b<br>
00000000000022e3 T cat_nthw_cts_cnt<br>
0000000000002361 T cat_nthw_cts_flush<br>
00000000000022b9 T cat_nthw_cts_select<br>
0000000000000039 T cat_nthw_delete<br>
0000000000002598 T cat_nthw_exo_cnt<br>
00000000000025c2 T cat_nthw_exo_dyn<br>
0000000000002616 T cat_nthw_exo_flush<br>
00000000000025ec T cat_nthw_exo_ofs<br>
000000000000256e T cat_nthw_exo_select<br>
0000000000001f9f T cat_nthw_fte_cnt<br>
0000000000001fd3 T cat_nthw_fte_enable<br>
0000000000002007 T cat_nthw_fte_flush<br>
0000000000001f6a T cat_nthw_fte_select<br>
0000000000000098 T cat_nthw_init<br>
0000000000002917 T cat_nthw_kcc_category<br>
00000000000028bb T cat_nthw_kcc_cnt<br>
000000000000296b T cat_nthw_kcc_flush<br>
0000000000002941 T cat_nthw_kcc_id<br>
00000000000028e5 T cat_nthw_kcc_key<br>
0000000000002891 T cat_nthw_kcc_select<br>
0000000000001dc2 T cat_nthw_kce_cnt<br>
0000000000001df6 T cat_nthw_kce_enable<br>
0000000000001e2a T cat_nthw_kce_flush<br>
0000000000001d8d T cat_nthw_kce_select<br>
0000000000001ee4 T cat_nthw_kcs_category<br>
0000000000001eaf T cat_nthw_kcs_cnt<br>
0000000000001f19 T cat_nthw_kcs_flush<br>
0000000000001e7b T cat_nthw_kcs_select<br>
0000000000002756 T cat_nthw_len_cnt<br>
00000000000027d4 T cat_nthw_len_dyn1<br>
00000000000027fe T cat_nthw_len_dyn2<br>
0000000000002852 T cat_nthw_len_flush<br>
0000000000002828 T cat_nthw_len_inv<br>
0000000000002780 T cat_nthw_len_lower<br>
000000000000272c T cat_nthw_len_select<br>
00000000000027aa T cat_nthw_len_upper<br>
0000000000000000 T cat_nthw_new<br>
000000000000267f T cat_nthw_rck_cnt<br>
00000000000026a9 T cat_nthw_rck_data<br>
00000000000026ed T cat_nthw_rck_flush<br>
0000000000002655 T cat_nthw_rck_select<br>
0000000000000071 T cat_nthw_set_debug_mode<br>
0000000000000060 T csu_nthw_delete<br>
0000000000000098 T csu_nthw_init<br>
0000000000000027 T csu_nthw_new<br>
0000000000000290 T csu_nthw_rcp_cnt<br>
0000000000000353 T csu_nthw_rcp_flush<br>
0000000000000305 T csu_nthw_rcp_inner_l3_cmd<br>
000000000000032c T csu_nthw_rcp_inner_l4_cmd<br>
00000000000002b7 T csu_nthw_rcp_outer_l3_cmd<br>
00000000000002de T csu_nthw_rcp_outer_l4_cmd<br>
0000000000000269 T csu_nthw_rcp_select<br>
0000000000000000 T csu_nthw_set_debug_mode<br>
000000000000211a T flm_nthw_buf_ctrl_update<br>
00000000000015dd T flm_nthw_control_crcrd<br>
00000000000015b3 T flm_nthw_control_crcwr<br>
0000000000001631 T flm_nthw_control_eab<br>
0000000000001406 T flm_nthw_control_enable<br>
0000000000001685 T flm_nthw_control_flush<br>
000000000000142d T flm_nthw_control_init<br>
0000000000001454 T flm_nthw_control_lds<br>
000000000000147b T flm_nthw_control_lfs<br>
00000000000014a2 T flm_nthw_control_lis<br>
0000000000001565 T flm_nthw_control_pds<br>
000000000000158c T flm_nthw_control_pis<br>
0000000000001607 T flm_nthw_control_rbl<br>
0000000000001517 T flm_nthw_control_rds<br>
000000000000153e T flm_nthw_control_ris<br>
000000000000165b T flm_nthw_control_split_sdram_usage<br>
00000000000014c9 T flm_nthw_control_uds<br>
00000000000014f0 T flm_nthw_control_uis<br>
0000000000000082 T flm_nthw_delete<br>
000000000000268e T flm_nthw_inf_sta_data_update<br>
00000000000000e1 T flm_nthw_init<br>
0000000000001aa4 T flm_nthw_load_aps_cnt<br>
0000000000001a82 T flm_nthw_load_aps_update<br>
00000000000019da T flm_nthw_load_bin<br>
0000000000001a04 T flm_nthw_load_bin_flush<br>
0000000000001a4d T flm_nthw_load_lps_cnt<br>
0000000000001a2b T flm_nthw_load_lps_update<br>
00000000000022e9 T flm_nthw_lrn_data_flush<br>
0000000000000049 T flm_nthw_new<br>
0000000000001c29 T flm_nthw_prio_flush<br>
0000000000001b03 T flm_nthw_prio_ft0<br>
0000000000001b57 T flm_nthw_prio_ft1<br>
0000000000001bab T flm_nthw_prio_ft2<br>
0000000000001bff T flm_nthw_prio_ft3<br>
0000000000001ad9 T flm_nthw_prio_limit0<br>
0000000000001b2d T flm_nthw_prio_limit1<br>
0000000000001b81 T flm_nthw_prio_limit2<br>
0000000000001bd5 T flm_nthw_prio_limit3<br>
0000000000001ca4 T flm_nthw_pst_bp<br>
0000000000001c7a T flm_nthw_pst_cnt<br>
0000000000001d22 T flm_nthw_pst_flush<br>
0000000000001cce T flm_nthw_pst_pp<br>
0000000000001c50 T flm_nthw_pst_select<br>
0000000000001cf8 T flm_nthw_pst_tp<br>
00000000000020b1 T flm_nthw_rcp_auto_ipv4_mask<br>
0000000000002033 T flm_nthw_rcp_byt_dyn<br>
000000000000205d T flm_nthw_rcp_byt_ofs<br>
0000000000001d8b T flm_nthw_rcp_cnt<br>
00000000000020db T flm_nthw_rcp_flush<br>
0000000000002009 T flm_nthw_rcp_ipn<br>
0000000000001fb5 T flm_nthw_rcp_kid<br>
0000000000001db5 T flm_nthw_rcp_lookup<br>
0000000000001f83 T flm_nthw_rcp_mask<br>
0000000000001fdf T flm_nthw_rcp_opn<br>
0000000000001ddf T flm_nthw_rcp_qw0_dyn<br>
0000000000001e09 T flm_nthw_rcp_qw0_ofs<br>
0000000000001e33 T flm_nthw_rcp_qw0_sel<br>
0000000000001e5d T flm_nthw_rcp_qw4_dyn<br>
0000000000001e87 T flm_nthw_rcp_qw4_ofs<br>
0000000000001d61 T flm_nthw_rcp_select<br>
0000000000001eb1 T flm_nthw_rcp_sw8_dyn<br>
0000000000001edb T flm_nthw_rcp_sw8_ofs<br>
0000000000001f05 T flm_nthw_rcp_sw8_sel<br>
0000000000001f2f T flm_nthw_rcp_sw9_dyn<br>
0000000000001f59 T flm_nthw_rcp_sw9_ofs<br>
0000000000002087 T flm_nthw_rcp_txplm<br>
00000000000019b3 T flm_nthw_scan_flush<br>
0000000000001989 T flm_nthw_scan_i<br>
00000000000032f4 T flm_nthw_scrub_cnt<br>
0000000000003372 T flm_nthw_scrub_del<br>
00000000000033c6 T flm_nthw_scrub_flush<br>
000000000000339c T flm_nthw_scrub_inf<br>
0000000000003348 T flm_nthw_scrub_r<br>
00000000000032ca T flm_nthw_scrub_select<br>
000000000000331e T flm_nthw_scrub_t<br>
00000000000000ba T flm_nthw_set_debug_mode<br>
0000000000002d03 T flm_nthw_stat_aul_done_cnt<br>
0000000000002d38 T flm_nthw_stat_aul_done_update<br>
0000000000002db1 T flm_nthw_stat_aul_fail_cnt<br>
0000000000002de6 T flm_nthw_stat_aul_fail_update<br>
0000000000002d5a T flm_nthw_stat_aul_ignore_cnt<br>
0000000000002d8f T flm_nthw_stat_aul_ignore_update<br>
0000000000003117 T flm_nthw_stat_csh_hit_cnt<br>
000000000000314c T flm_nthw_stat_csh_hit_update<br>
000000000000316e T flm_nthw_stat_csh_miss_cnt<br>
00000000000031a3 T flm_nthw_stat_csh_miss_update<br>
00000000000031c5 T flm_nthw_stat_csh_unh_cnt<br>
00000000000031fa T flm_nthw_stat_csh_unh_update<br>
0000000000003273 T flm_nthw_stat_cuc_move_cnt<br>
00000000000032a8 T flm_nthw_stat_cuc_move_update<br>
000000000000321c T flm_nthw_stat_cuc_start_cnt<br>
0000000000003251 T flm_nthw_stat_cuc_start_update<br>
0000000000002e5f T flm_nthw_stat_flows_cnt<br>
0000000000002e94 T flm_nthw_stat_flows_update<br>
0000000000002f0d T flm_nthw_stat_inf_done_cnt<br>
0000000000002f42 T flm_nthw_stat_inf_done_update<br>
0000000000002f64 T flm_nthw_stat_inf_skip_cnt<br>
0000000000002f99 T flm_nthw_stat_inf_skip_update<br>
00000000000029f4 T flm_nthw_stat_lrn_done_cnt<br>
0000000000002a29 T flm_nthw_stat_lrn_done_update<br>
0000000000002aa2 T flm_nthw_stat_lrn_fail_cnt<br>
0000000000002ad7 T flm_nthw_stat_lrn_fail_update<br>
0000000000002a4b T flm_nthw_stat_lrn_ignore_cnt<br>
0000000000002a80 T flm_nthw_stat_lrn_ignore_update<br>
00000000000030c0 T flm_nthw_stat_pck_dis_cnt<br>
00000000000030f5 T flm_nthw_stat_pck_dis_update<br>
0000000000002fbb T flm_nthw_stat_pck_hit_cnt<br>
0000000000002ff0 T flm_nthw_stat_pck_hit_update<br>
0000000000003012 T flm_nthw_stat_pck_miss_cnt<br>
0000000000003047 T flm_nthw_stat_pck_miss_update<br>
0000000000003069 T flm_nthw_stat_pck_unh_cnt<br>
000000000000309e T flm_nthw_stat_pck_unh_update<br>
0000000000002ba7 T flm_nthw_stat_prb_done_cnt<br>
0000000000002bdc T flm_nthw_stat_prb_done_update<br>
0000000000002bfe T flm_nthw_stat_prb_ignore_cnt<br>
0000000000002c33 T flm_nthw_stat_prb_ignore_update<br>
0000000000002c55 T flm_nthw_stat_rel_done_cnt<br>
0000000000002c8a T flm_nthw_stat_rel_done_update<br>
0000000000002cac T flm_nthw_stat_rel_ignore_cnt<br>
0000000000002ce1 T flm_nthw_stat_rel_ignore_update<br>
0000000000002eb6 T flm_nthw_stat_sta_done_cnt<br>
0000000000002eeb T flm_nthw_stat_sta_done_update<br>
0000000000002e08 T flm_nthw_stat_tul_done_cnt<br>
0000000000002e3d T flm_nthw_stat_tul_done_update<br>
0000000000002af9 T flm_nthw_stat_unl_done_cnt<br>
0000000000002b2e T flm_nthw_stat_unl_done_update<br>
0000000000002b50 T flm_nthw_stat_unl_ignore_cnt<br>
0000000000002b85 T flm_nthw_stat_unl_ignore_update<br>
00000000000018ee T flm_nthw_status_cache_buf_crit<br>
0000000000001724 T flm_nthw_status_calib_fail<br>
00000000000016a9 T flm_nthw_status_calib_success<br>
0000000000001867 T flm_nthw_status_crcerr<br>
00000000000017c3 T flm_nthw_status_critical<br>
00000000000018b9 T flm_nthw_status_eft_bp<br>
0000000000001940 T flm_nthw_status_flush<br>
000000000000178e T flm_nthw_status_idle<br>
0000000000001759 T flm_nthw_status_initdone<br>
0000000000001815 T flm_nthw_status_panic<br>
0000000000001967 T flm_nthw_status_update<br>
0000000000000060 T hfu_nthw_delete<br>
0000000000000098 T hfu_nthw_init<br>
0000000000000027 T hfu_nthw_new<br>
00000000000004d1 T hfu_nthw_rcp_cnt<br>
0000000000000879 T hfu_nthw_rcp_flush<br>
0000000000000594 T hfu_nthw_rcp_len_a_add_dyn<br>
00000000000005bb T hfu_nthw_rcp_len_a_add_ofs<br>
000000000000051f T hfu_nthw_rcp_len_a_ol4len<br>
0000000000000546 T hfu_nthw_rcp_len_a_pos_dyn<br>
000000000000056d T hfu_nthw_rcp_len_a_pos_ofs<br>
00000000000005e2 T hfu_nthw_rcp_len_a_sub_dyn<br>
00000000000004f8 T hfu_nthw_rcp_len_a_wr<br>
0000000000000681 T hfu_nthw_rcp_len_b_add_dyn<br>
00000000000006ab T hfu_nthw_rcp_len_b_add_ofs<br>
0000000000000630 T hfu_nthw_rcp_len_b_pos_dyn<br>
0000000000000657 T hfu_nthw_rcp_len_b_pos_ofs<br>
00000000000006d5 T hfu_nthw_rcp_len_b_sub_dyn<br>
0000000000000609 T hfu_nthw_rcp_len_b_wr<br>
000000000000077d T hfu_nthw_rcp_len_c_add_dyn<br>
00000000000007a7 T hfu_nthw_rcp_len_c_add_ofs<br>
0000000000000729 T hfu_nthw_rcp_len_c_pos_dyn<br>
0000000000000753 T hfu_nthw_rcp_len_c_pos_ofs<br>
00000000000007d1 T hfu_nthw_rcp_len_c_sub_dyn<br>
00000000000006ff T hfu_nthw_rcp_len_c_wr<br>
00000000000004aa T hfu_nthw_rcp_select<br>
0000000000000825 T hfu_nthw_rcp_ttl_pos_dyn<br>
000000000000084f T hfu_nthw_rcp_ttl_pos_ofs<br>
00000000000007fb T hfu_nthw_rcp_ttl_wr<br>
0000000000000000 T hfu_nthw_set_debug_mode<br>
0000000000000060 T hsh_nthw_delete<br>
0000000000000098 T hsh_nthw_init<br>
0000000000000027 T hsh_nthw_new<br>
0000000000000b79 T hsh_nthw_rcp_auto_ipv4_mask<br>
0000000000000793 T hsh_nthw_rcp_cnt<br>
0000000000000bb3 T hsh_nthw_rcp_flush<br>
0000000000000ad3 T hsh_nthw_rcp_hsh_type<br>
0000000000000aa9 T hsh_nthw_rcp_hsh_valid<br>
0000000000000b37 T hsh_nthw_rcp_k<br>
00000000000007ba T hsh_nthw_rcp_load_dist_type<br>
00000000000007e1 T hsh_nthw_rcp_mac_port_mask<br>
00000000000009f9 T hsh_nthw_rcp_p_mask<br>
0000000000000864 T hsh_nthw_rcp_qw0_ofs<br>
000000000000083d T hsh_nthw_rcp_qw0_pe<br>
00000000000008b2 T hsh_nthw_rcp_qw4_ofs<br>
000000000000088b T hsh_nthw_rcp_qw4_pe<br>
0000000000000a55 T hsh_nthw_rcp_seed<br>
000000000000076c T hsh_nthw_rcp_select<br>
0000000000000816 T hsh_nthw_rcp_sort<br>
0000000000000a7f T hsh_nthw_rcp_tnl_p<br>
0000000000000afd T hsh_nthw_rcp_toeplitz<br>
0000000000000900 T hsh_nthw_rcp_w8_ofs<br>
00000000000008d9 T hsh_nthw_rcp_w8_pe<br>
0000000000000927 T hsh_nthw_rcp_w8_sort<br>
000000000000097b T hsh_nthw_rcp_w9_ofs<br>
00000000000009cf T hsh_nthw_rcp_w9_p<br>
0000000000000951 T hsh_nthw_rcp_w9_pe<br>
00000000000009a5 T hsh_nthw_rcp_w9_sort<br>
0000000000000a23 T hsh_nthw_rcp_word_mask<br>
0000000000000000 T hsh_nthw_set_debug_mode<br>
0000000000000543 T ifr_nthw_counters_cnt<br>
000000000000056d T ifr_nthw_counters_drop<br>
0000000000000519 T ifr_nthw_counters_select<br>
00000000000005a2 T ifr_nthw_counters_update<br>
0000000000000060 T ifr_nthw_init<br>
0000000000000027 T ifr_nthw_new<br>
00000000000003c2 T ifr_nthw_rcp_cnt<br>
00000000000004e0 T ifr_nthw_rcp_flush<br>
000000000000041d T ifr_nthw_rcp_ipv4_df_drop<br>
00000000000003e9 T ifr_nthw_rcp_ipv4_en<br>
0000000000000485 T ifr_nthw_rcp_ipv6_drop<br>
0000000000000451 T ifr_nthw_rcp_ipv6_en<br>
00000000000004b9 T ifr_nthw_rcp_mtu<br>
000000000000039b T ifr_nthw_rcp_select<br>
0000000000000000 T ifr_nthw_set_debug_mode<br>
0000000000000067 T info_nthw_delete<br>
0000000000000879 T info_nthw_get_kcc_banks<br>
0000000000000868 T info_nthw_get_kcc_size<br>
0000000000000846 T info_nthw_get_ltx_avail<br>
0000000000000857 T info_nthw_get_nb_categories<br>
000000000000089b T info_nthw_get_nb_cat_funcs<br>
0000000000000a17 T info_nthw_get_nb_cat_km_if_cnt<br>
0000000000000a2b T info_nthw_get_nb_cat_km_if_m0<br>
0000000000000a3f T info_nthw_get_nb_cat_km_if_m1<br>
0000000000000945 T info_nthw_get_nb_flm_categories<br>
0000000000000967 T info_nthw_get_nb_flm_entry_size<br>
00000000000009bc T info_nthw_get_nb_flm_load_aps_max<br>
0000000000000989 T info_nthw_get_nb_flm_prios<br>
000000000000099a T info_nthw_get_nb_flm_pst_profiles<br>
00000000000009ab T info_nthw_get_nb_flm_scrub_profiles<br>
0000000000000956 T info_nthw_get_nb_flm_size_mb<br>
0000000000000978 T info_nthw_get_nb_flm_variant<br>
0000000000000adf T info_nthw_get_nb_hsh_categories<br>
0000000000000af3 T info_nthw_get_nb_hsh_toeplitz<br>
00000000000008f0 T info_nthw_get_nb_km_cam_banks<br>
0000000000000912 T info_nthw_get_nb_km_cam_records<br>
0000000000000901 T info_nthw_get_nb_km_cam_record_words<br>
00000000000008df T info_nthw_get_nb_km_categories<br>
00000000000008ac T info_nthw_get_nb_km_flow_types<br>
0000000000000923 T info_nthw_get_nb_km_tcam_banks<br>
0000000000000934 T info_nthw_get_nb_km_tcam_bank_width<br>
00000000000008ce T info_nthw_get_nb_len<br>
00000000000009ef T info_nthw_get_nb_pdb_categories<br>
0000000000000824 T info_nthw_get_nb_phy_ports<br>
00000000000008bd T info_nthw_get_nb_pm_ext<br>
00000000000009cd T info_nthw_get_nb_qsl_categories<br>
00000000000009de T info_nthw_get_nb_qsl_qst_entries<br>
000000000000088a T info_nthw_get_nb_queues<br>
0000000000000a03 T info_nthw_get_nb_roa_categories<br>
0000000000000acb T info_nthw_get_nb_rpp_per_ps<br>
0000000000000835 T info_nthw_get_nb_rx_ports<br>
0000000000000a53 T info_nthw_get_nb_tpe_categories<br>
0000000000000ab7 T info_nthw_get_nb_tpe_ifr_categories<br>
0000000000000a7b T info_nthw_get_nb_tx_cpy_mask_mem<br>
0000000000000a67 T info_nthw_get_nb_tx_cpy_writers<br>
0000000000000a8f T info_nthw_get_nb_tx_rpl_depth<br>
0000000000000aa3 T info_nthw_get_nb_tx_rpl_ext_categories<br>
000000000000009f T info_nthw_init<br>
000000000000002e T info_nthw_new<br>
00000000000016db T km_nthw_cam_cnt<br>
00000000000018fd T km_nthw_cam_flush<br>
0000000000001801 T km_nthw_cam_ft0<br>
000000000000182b T km_nthw_cam_ft1<br>
0000000000001855 T km_nthw_cam_ft2<br>
000000000000187f T km_nthw_cam_ft3<br>
00000000000018a9 T km_nthw_cam_ft4<br>
00000000000018d3 T km_nthw_cam_ft5<br>
00000000000016b1 T km_nthw_cam_select<br>
0000000000001705 T km_nthw_cam_w0<br>
000000000000172f T km_nthw_cam_w1<br>
0000000000001759 T km_nthw_cam_w2<br>
0000000000001783 T km_nthw_cam_w3<br>
00000000000017ad T km_nthw_cam_w4<br>
00000000000017d7 T km_nthw_cam_w5<br>
0000000000000060 T km_nthw_delete<br>
0000000000000098 T km_nthw_init<br>
0000000000000027 T km_nthw_new<br>
00000000000013e4 T km_nthw_rcp_bank_a<br>
000000000000140e T km_nthw_rcp_bank_b<br>
0000000000000e6a T km_nthw_rcp_cnt<br>
0000000000001294 T km_nthw_rcp_dual<br>
0000000000001528 T km_nthw_rcp_dw0_b_dyn<br>
0000000000001552 T km_nthw_rcp_dw0_b_ofs<br>
00000000000010e6 T km_nthw_rcp_dw10_dyn<br>
000000000000111f T km_nthw_rcp_dw10_ofs<br>
0000000000001158 T km_nthw_rcp_dw10_sel_a<br>
0000000000001191 T km_nthw_rcp_dw10_sel_b<br>
000000000000157c T km_nthw_rcp_dw2_b_dyn<br>
00000000000015a6 T km_nthw_rcp_dw2_b_ofs<br>
0000000000000fc9 T km_nthw_rcp_dw8_dyn<br>
000000000000103b T km_nthw_rcp_dw8_ofs<br>
0000000000001074 T km_nthw_rcp_dw8_sel_a<br>
00000000000010ad T km_nthw_rcp_dw8_sel_b<br>
00000000000012e8 T km_nthw_rcp_el_a<br>
0000000000001312 T km_nthw_rcp_el_b<br>
0000000000001678 T km_nthw_rcp_flush<br>
0000000000001390 T km_nthw_rcp_ftm_a<br>
00000000000013ba T km_nthw_rcp_ftm_b<br>
000000000000133c T km_nthw_rcp_info_a<br>
0000000000001366 T km_nthw_rcp_info_b<br>
000000000000148c T km_nthw_rcp_keyway_a<br>
00000000000014c5 T km_nthw_rcp_keyway_b<br>
0000000000001438 T km_nthw_rcp_kl_a<br>
0000000000001462 T km_nthw_rcp_kl_b<br>
000000000000121e T km_nthw_rcp_mask_b<br>
0000000000001259 T km_nthw_rcp_mask_da<br>
00000000000012be T km_nthw_rcp_paired<br>
0000000000000e91 T km_nthw_rcp_qw0_dyn<br>
0000000000000eb8 T km_nthw_rcp_qw0_ofs<br>
0000000000000edf T km_nthw_rcp_qw0_sel_a<br>
0000000000000f06 T km_nthw_rcp_qw0_sel_b<br>
0000000000000f2d T km_nthw_rcp_qw4_dyn<br>
0000000000000f54 T km_nthw_rcp_qw4_ofs<br>
0000000000000f7b T km_nthw_rcp_qw4_sel_a<br>
0000000000000fa2 T km_nthw_rcp_qw4_sel_b<br>
0000000000000e43 T km_nthw_rcp_select<br>
00000000000015d0 T km_nthw_rcp_sw4_b_dyn<br>
00000000000015fa T km_nthw_rcp_sw4_b_ofs<br>
0000000000001624 T km_nthw_rcp_sw5_b_dyn<br>
000000000000164e T km_nthw_rcp_sw5_b_ofs<br>
0000000000001002 T km_nthw_rcp_swx_cch<br>
00000000000011ca T km_nthw_rcp_swx_sel_a<br>
00000000000011f4 T km_nthw_rcp_swx_sel_b<br>
00000000000014fe T km_nthw_rcp_synergy_mode<br>
0000000000000000 T km_nthw_set_debug_mode<br>
0000000000001966 T km_nthw_tcam_cnt<br>
00000000000019c2 T km_nthw_tcam_flush<br>
000000000000193c T km_nthw_tcam_select<br>
0000000000001990 T km_nthw_tcam_t<br>
0000000000001a2b T km_nthw_tci_cnt<br>
0000000000001a55 T km_nthw_tci_color<br>
0000000000001aa9 T km_nthw_tci_flush<br>
0000000000001a7f T km_nthw_tci_ft<br>
0000000000001a01 T km_nthw_tci_select<br>
0000000000001b3c T km_nthw_tcq_bank_mask<br>
0000000000001b12 T km_nthw_tcq_cnt<br>
0000000000001b9f T km_nthw_tcq_flush<br>
0000000000001b75 T km_nthw_tcq_qual<br>
0000000000001ae8 T km_nthw_tcq_select<br>
000000000000080a T pdb_nthw_config_flush<br>
00000000000007e0 T pdb_nthw_config_port_ofs<br>
00000000000007b6 T pdb_nthw_config_ts_format<br>
0000000000000060 T pdb_nthw_delete<br>
0000000000000098 T pdb_nthw_init<br>
0000000000000027 T pdb_nthw_new<br>
00000000000005b8 T pdb_nthw_rcp_align<br>
00000000000004a7 T pdb_nthw_rcp_cnt<br>
0000000000000591 T pdb_nthw_rcp_crc_overwrite<br>
00000000000004f5 T pdb_nthw_rcp_desc_len<br>
00000000000004ce T pdb_nthw_rcp_descriptor<br>
0000000000000753 T pdb_nthw_rcp_duplicate_bit<br>
0000000000000729 T pdb_nthw_rcp_duplicate_en<br>
000000000000077d T pdb_nthw_rcp_flush<br>
00000000000006d5 T pdb_nthw_rcp_ip_prot_tnl<br>
00000000000005df T pdb_nthw_rcp_ofs0_dyn<br>
0000000000000606 T pdb_nthw_rcp_ofs0_rel<br>
000000000000062d T pdb_nthw_rcp_ofs1_dyn<br>
0000000000000657 T pdb_nthw_rcp_ofs1_rel<br>
0000000000000681 T pdb_nthw_rcp_ofs2_dyn<br>
00000000000006ab T pdb_nthw_rcp_ofs2_rel<br>
00000000000006ff T pdb_nthw_rcp_ppc_hsh<br>
0000000000000480 T pdb_nthw_rcp_select<br>
0000000000000543 T pdb_nthw_rcp_tx_ignore<br>
000000000000056a T pdb_nthw_rcp_tx_now<br>
000000000000051c T pdb_nthw_rcp_tx_port<br>
0000000000000000 T pdb_nthw_set_debug_mode<br>
0000000000000060 T qsl_nthw_delete<br>
0000000000000098 T qsl_nthw_init<br>
0000000000000027 T qsl_nthw_new<br>
0000000000000b84 T qsl_nthw_qen_cnt<br>
0000000000000bae T qsl_nthw_qen_en<br>
0000000000000bd8 T qsl_nthw_qen_flush<br>
0000000000000b5a T qsl_nthw_qen_select<br>
00000000000009b5 T qsl_nthw_qst_cnt<br>
0000000000000a09 T qsl_nthw_qst_en<br>
0000000000000b1b T qsl_nthw_qst_flush<br>
0000000000000a6d T qsl_nthw_qst_lre<br>
00000000000009df T qsl_nthw_qst_queue<br>
000000000000098b T qsl_nthw_qst_select<br>
0000000000000aa7 T qsl_nthw_qst_tci<br>
0000000000000a33 T qsl_nthw_qst_tx_port<br>
0000000000000ae1 T qsl_nthw_qst_ven<br>
000000000000079f T qsl_nthw_rcp_cnt<br>
00000000000007c6 T qsl_nthw_rcp_discard<br>
00000000000007ed T qsl_nthw_rcp_drop<br>
0000000000000952 T qsl_nthw_rcp_flush<br>
00000000000008b0 T qsl_nthw_rcp_lr<br>
0000000000000778 T qsl_nthw_rcp_select<br>
000000000000083b T qsl_nthw_rcp_tbl_hi<br>
0000000000000862 T qsl_nthw_rcp_tbl_idx<br>
0000000000000814 T qsl_nthw_rcp_tbl_lo<br>
0000000000000889 T qsl_nthw_rcp_tbl_msk<br>
00000000000008e4 T qsl_nthw_rcp_tsa<br>
0000000000000918 T qsl_nthw_rcp_vli<br>
0000000000000000 T qsl_nthw_set_debug_mode<br>
0000000000000c41 T qsl_nthw_unmq_cnt<br>
0000000000000c6b T qsl_nthw_unmq_dest_queue<br>
0000000000000c95 T qsl_nthw_unmq_en<br>
0000000000000cbf T qsl_nthw_unmq_flush<br>
0000000000000c17 T qsl_nthw_unmq_select<br>
0000000000000060 T rpp_lr_nthw_delete<br>
0000000000000433 T rpp_lr_nthw_ifr_rcp_cnt<br>
0000000000000557 T rpp_lr_nthw_ifr_rcp_flush<br>
000000000000048e T rpp_lr_nthw_ifr_rcp_ipv4_df_drop<br>
000000000000045a T rpp_lr_nthw_ifr_rcp_ipv4_en<br>
00000000000004f6 T rpp_lr_nthw_ifr_rcp_ipv6_drop<br>
00000000000004c2 T rpp_lr_nthw_ifr_rcp_ipv6_en<br>
0000000000000530 T rpp_lr_nthw_ifr_rcp_mtu<br>
000000000000040c T rpp_lr_nthw_ifr_rcp_select<br>
0000000000000098 T rpp_lr_nthw_init<br>
0000000000000027 T rpp_lr_nthw_new<br>
0000000000000385 T rpp_lr_nthw_rcp_cnt<br>
00000000000003ac T rpp_lr_nthw_rcp_exp<br>
00000000000003d3 T rpp_lr_nthw_rcp_flush<br>
000000000000035e T rpp_lr_nthw_rcp_select<br>
0000000000000000 T rpp_lr_nthw_set_debug_mode<br>
0000000000000060 T slc_lr_nthw_delete<br>
0000000000000098 T slc_lr_nthw_init<br>
0000000000000027 T slc_lr_nthw_new<br>
00000000000002f7 T slc_lr_nthw_rcp_cnt<br>
000000000000042f T slc_lr_nthw_rcp_flush<br>
0000000000000345 T slc_lr_nthw_rcp_head_dyn<br>
000000000000036c T slc_lr_nthw_rcp_head_ofs<br>
000000000000031e T slc_lr_nthw_rcp_head_slc_en<br>
0000000000000408 T slc_lr_nthw_rcp_pcap<br>
00000000000002d0 T slc_lr_nthw_rcp_select<br>
00000000000003ba T slc_lr_nthw_rcp_tail_dyn<br>
00000000000003e1 T slc_lr_nthw_rcp_tail_ofs<br>
0000000000000393 T slc_lr_nthw_rcp_tail_slc_en<br>
0000000000000000 T slc_lr_nthw_set_debug_mode<br>
0000000000000060 T tx_cpy_nthw_delete<br>
00000000000000a8 T tx_cpy_nthw_init<br>
0000000000000027 T tx_cpy_nthw_new<br>
0000000000000000 T tx_cpy_nthw_set_debug_mode<br>
000000000000118a T tx_cpy_nthw_writer_cnt<br>
00000000000011fa T tx_cpy_nthw_writer_dyn<br>
00000000000012a2 T tx_cpy_nthw_writer_flush<br>
000000000000126a T tx_cpy_nthw_writer_len<br>
0000000000001232 T tx_cpy_nthw_writer_ofs<br>
00000000000011c2 T tx_cpy_nthw_writer_reader_select<br>
0000000000001152 T tx_cpy_nthw_writer_select<br>
0000000000000060 T tx_ins_nthw_delete<br>
0000000000000098 T tx_ins_nthw_init<br>
0000000000000027 T tx_ins_nthw_new<br>
0000000000000283 T tx_ins_nthw_rcp_cnt<br>
00000000000002aa T tx_ins_nthw_rcp_dyn<br>
000000000000031f T tx_ins_nthw_rcp_flush<br>
00000000000002f8 T tx_ins_nthw_rcp_len<br>
00000000000002d1 T tx_ins_nthw_rcp_ofs<br>
000000000000025c T tx_ins_nthw_rcp_select<br>
0000000000000000 T tx_ins_nthw_set_debug_mode<br>
0000000000000060 T tx_rpl_nthw_delete<br>
000000000000058e T tx_rpl_nthw_ext_cnt<br>
00000000000005df T tx_rpl_nthw_ext_flush<br>
00000000000005b5 T tx_rpl_nthw_ext_rpl_ptr<br>
0000000000000567 T tx_rpl_nthw_ext_select<br>
0000000000000098 T tx_rpl_nthw_init<br>
0000000000000027 T tx_rpl_nthw_new<br>
000000000000041d T tx_rpl_nthw_rcp_cnt<br>
0000000000000444 T tx_rpl_nthw_rcp_dyn<br>
0000000000000507 T tx_rpl_nthw_rcp_eth_type_wr<br>
00000000000004e0 T tx_rpl_nthw_rcp_ext_prio<br>
000000000000052e T tx_rpl_nthw_rcp_flush<br>
0000000000000492 T tx_rpl_nthw_rcp_len<br>
000000000000046b T tx_rpl_nthw_rcp_ofs<br>
00000000000004b9 T tx_rpl_nthw_rcp_rpl_ptr<br>
00000000000003f6 T tx_rpl_nthw_rcp_select<br>
0000000000000645 T tx_rpl_nthw_rpl_cnt<br>
00000000000006a1 T tx_rpl_nthw_rpl_flush<br>
000000000000061b T tx_rpl_nthw_rpl_select<br>
000000000000066f T tx_rpl_nthw_rpl_value<br>
0000000000000000 T tx_rpl_nthw_set_debug_mode<br>
000000000000115f T nthw_meter_init<br>
0000000000002351 T nthw_field_clr_all<br>
0000000000002371 T nthw_field_clr_flush<br>
00000000000022c6 T nthw_field_flush_register<br>
0000000000001dfa T nthw_field_get_bit_pos_high<br>
0000000000001de9 T nthw_field_get_bit_pos_low<br>
0000000000001dd8 T nthw_field_get_bit_width<br>
0000000000001daf T nthw_field_get_debug_mode<br>
0000000000001e16 T nthw_field_get_mask<br>
0000000000002210 T nthw_field_get_signed<br>
0000000000002270 T nthw_field_get_updated<br>
0000000000001e4b T nthw_field_get_val<br>
00000000000021e7 T nthw_field_get_val32<br>
0000000000001b38 T nthw_field_init<br>
0000000000001b1c T nthw_field_new<br>
0000000000001e27 T nthw_field_reset<br>
00000000000023a0 T nthw_field_set_all<br>
0000000000001dc0 T nthw_field_set_debug_mode<br>
00000000000023c0 T nthw_field_set_flush<br>
0000000000001fbe T nthw_field_set_val<br>
00000000000022e9 T nthw_field_set_val32<br>
00000000000021af T nthw_field_set_val_flush<br>
0000000000002313 T nthw_field_set_val_flush32<br>
00000000000022a8 T nthw_field_update_register<br>
00000000000025fd T nthw_field_wait_clr_all32<br>
00000000000025d2 T nthw_field_wait_set_all32<br>
0000000000002628 T nthw_field_wait_set_any32<br>
00000000000003a6 T nthw_fpga_extract_prod_id<br>
00000000000003d3 T nthw_fpga_extract_rev_id<br>
000000000000038e T nthw_fpga_extract_type_id<br>
00000000000003bb T nthw_fpga_extract_ver_id<br>
0000000000000aed T nthw_fpga_get_product_id<br>
0000000000000a92 T nthw_fpga_get_product_param<br>
0000000000000403 T nthw_fpga_mgr_delete<br>
000000000000041e T nthw_fpga_mgr_init<br>
0000000000000611 T nthw_fpga_mgr_log_dump<br>
00000000000003e7 T nthw_fpga_mgr_new<br>
0000000000000551 T nthw_fpga_mgr_query_fpga<br>
0000000000000753 T nthw_fpga_model_init<br>
000000000000071a T nthw_fpga_model_new<br>
0000000000000a6a T nthw_fpga_query_module<br>
0000000000000363 T nthw_fpga_read_buildtime<br>
0000000000000308 T nthw_fpga_read_ident<br>
000000000000099c T nthw_fpga_set_debug_mode<br>
0000000000000f8a T nthw_module_get_bus<br>
0000000000000f11 T nthw_module_get_debug_mode<br>
0000000000000d1b T nthw_module_get_major_version<br>
0000000000000d2c T nthw_module_get_minor_version<br>
0000000000000e2a T nthw_module_get_register<br>
0000000000000d3d T nthw_module_get_version_packed64<br>
0000000000000b7b T nthw_module_init<br>
0000000000000d63 T nthw_module_is_version_newer<br>
0000000000000b5f T nthw_module_new<br>
0000000000000e08 T nthw_module_query_register<br>
0000000000000f22 T nthw_module_set_debug_mode<br>
0000000000000b1a T nthw_param_init<br>
0000000000000afe T nthw_param_new<br>
0000000000001ace T nthw_register_clr<br>
00000000000018de T nthw_register_flush<br>
00000000000011d9 T nthw_register_get_address<br>
00000000000013d2 T nthw_register_get_bit_width<br>
00000000000013e3 T nthw_register_get_debug_mode<br>
00000000000012e5 T nthw_register_get_field<br>
00000000000015ef T nthw_register_get_val<br>
000000000000165a T nthw_register_get_val32<br>
000000000000180b T nthw_register_get_val_updated32<br>
0000000000000fb7 T nthw_register_init<br>
0000000000001847 T nthw_register_make_dirty<br>
0000000000000f9b T nthw_register_new<br>
00000000000012c3 T nthw_register_query_field<br>
00000000000011ea T nthw_register_reset<br>
00000000000013f4 T nthw_register_set_debug_mode<br>
000000000000187c T nthw_register_set_val<br>
000000000000168a T nthw_register_update<br>
0000000000000000 T nthw_platform_get_nthw_adapter_id<br>
0000000000000f95 T nthw_rac_bar0_read32<br>
0000000000000ff9 T nthw_rac_bar0_write32<br>
0000000000000097 T nthw_rac_init<br>
000000000000005e T nthw_rac_new<br>
000000000000105d T nthw_rac_rab_dma_begin<br>
000000000000125e T nthw_rac_rab_dma_commit<br>
000000000000246d T nthw_rac_rab_flush<br>
0000000000001295 T nthw_rac_rab_get_free<br>
0000000000000c61 T nthw_rac_rab_init<br>
0000000000001d79 T nthw_rac_rab_read32<br>
0000000000001477 T nthw_rac_rab_read32_dma<br>
0000000000000cb5 T nthw_rac_rab_reset<br>
0000000000000d8d T nthw_rac_rab_setup<br>
000000000000160f T nthw_rac_rab_write32<br>
00000000000012c2 T nthw_rac_rab_write32_dma<br>
000000000000005f T ntlog_helper_str_add<br>
0000000000000000 T ntlog_helper_str_alloc<br>
0000000000000152 T ntlog_helper_str_free<br>
0000000000000199 T nt_dma_alloc<br>
000000000000039d T nt_dma_free<br>
0000000000000613 T nthw_convert_link_speed<br>
0000000000000715 T nthw_string_to_u32<br>
00000000000006e3 T nt_link_duplex_to_eth_duplex<br>
000000000000057f T nt_link_speed_capa_to_eth_speed_capa<br>
00000000000004b8 T nt_link_speed_to_eth_speed_num<br>
000000000000013e T nt_os_get_time_monotonic_counter<br>
0000000000000107 T nt_os_wait_usec<br>
000000000000011f T nt_os_wait_usec_poll<br>
0000000000000149 T nt_util_align_size<br>
0000000000000175 T nt_util_vfio_init<br>
00000000000000b2 T get_100g_link_ops<br>
0000000000000182 T get_adapter_ops<br>
00000000000000e6 T get_agx_100g_link_ops<br>
00000000000001b6 T get_clk9563_ops<br>
000000000000038a T get_dev_flow_ops<br>
0000000000000356 T get_dev_fp_flow_ops<br>
00000000000002ba T get_flow_backend_ops<br>
0000000000000322 T get_flow_filter_ops<br>
000000000000004a T get_meter_ops<br>
000000000000014e T get_nt4ga_stat_ops<br>
000000000000007e T get_ntnic_filter_ops<br>
00000000000003be T get_ntnic_xstats_ops<br>
000000000000011a T get_port_ops<br>
00000000000002ee T get_profile_inline_ops<br>
000000000000021e T get_rst9563_ops<br>
0000000000000268 T get_rst9574_ops<br>
00000000000001ea T get_rst_nt200a0x_ops<br>
000000000000029c T get_rst_nt400dxx_ops<br>
0000000000000016 T get_sg_ops<br>
000000000000009c T register_100g_link_ops<br>
000000000000016c T register_adapter_ops<br>
00000000000000d0 T register_agx_100g_link_ops<br>
00000000000001a0 T register_clk9563_ops<br>
0000000000000374 T register_dev_flow_ops<br>
0000000000000340 T register_dev_fp_flow_ops<br>
000000000000023c T register_flow_backend_ops<br>
000000000000030c T register_flow_filter_ops<br>
0000000000000034 T register_meter_ops<br>
0000000000000138 T register_nt4ga_stat_ops<br>
0000000000000068 T register_ntnic_filter_ops<br>
00000000000003a8 T register_ntnic_xstats_ops<br>
0000000000000104 T register_port_ops<br>
00000000000002d8 T register_profile_inline_ops<br>
0000000000000208 T register_rst9563_ops<br>
0000000000000252 T register_rst9574_ops<br>
00000000000001d4 T register_rst_nt200a0x_ops<br>
0000000000000286 T register_rst_nt400dxx_ops<br>
0000000000000000 T register_sg_ops<br>
0000000000000449 T nt_vfio_dma_map<br>
0000000000000652 T nt_vfio_dma_unmap<br>
000000000000078d T nt_vfio_init<br>
0000000000000396 T nt_vfio_remove<br>
0000000000000067 T nt_vfio_setup<br>
0000000000000000 T nt_vfio_vf_num<br>
<br>
Symbols used in only one file should be declared static.<br>
</div>
</span></font></div>
</body>
</html>

--_000_VE1P190MB0830A9B6C3BADBFC05E052A48041AVE1P190MB0830EURP_--
