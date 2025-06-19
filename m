Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ABC7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 13:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9588142E78;
	Thu, 19 Jun 2025 15:02:11 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id B556A4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 15:01:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022123.outbound.protection.outlook.com
 [52.101.66.123]) by mx-outbound43-37.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 19 Jun 2025 13:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1JlPaFTYO3B4jmmIt7oBIcK4bsWT+rOYdkccbH6N/22QtWD1rlXXjrwkv9UtPuWUov9NcNctvbBDimzu6uqbSFtWr1/EG2jwAxCVHHPY0ZWP3AkRF0tKaYEY7gfla+STVT/N/UglhIcujNPp2yPZD9KdNcOpcHghJifcY/kjkZBzrajGZa4PrJlsfIJE17oEszXpz8OEwYkpICw61qHcMlDsyZqACfztGYbb8K2TpzYHz1pof+O6Gmc9RrjYgPSsoS9XeCbf8uYONdu5LqRDjhFhCdlORoMPZUXj4DCsJOkpHgB+sunEp0i0EhiQ5aZREmrt62y8pO/5+ORSoyCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f23dxE3WDwsb+1PWzK0aoeDykAjzYAjLqeWLYOnoGQQ=;
 b=lhUGDrCaQsg1ccsKXosgpfKoYELG1u1X1/Nj6ZjdCVcgl+N0wmn2YyU4Bfv0kTqblHR+6RhUK+IBoRATEMugMjI+aWSq/p5gFCC68dn7q9759zy1vOrhpCJv5MGfYEOmsV2wM9eNawdzh8QI2cvOomvjFQPWaFdEq57wJ2CIQknq7Nz5qdHj0MFeKy+to30uoztWx8sFKdb7hnyx6VPaIKc3M61H/3C2ELd9dwPfLlMeFs/Eg99Huq2Wvt4369fDU602GJDwr1Q0duE0r8CCPGxONf4vP77voMDPXuVb4XT9gTz8pFsUqxsySeqKRM+DMc1usVFw2drzTB5jTGqzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f23dxE3WDwsb+1PWzK0aoeDykAjzYAjLqeWLYOnoGQQ=;
 b=j1737Ai9tstP2i3N7Qz4q04Q/gkIX5LdKYVwvisZSwK/ffcJbb3xUfDDzZ1or6EGYydZ7QF2l7N1YiDSu/B/+/8Fm9d7la6w70yl1WEXmoT/tarO9Ntk0GiIwz4aARlLN2sxop/nilEI73U8rKqYK/S1MO5ftDi6RBAqWEBbAQY=
Received: from PAWP190MB2160.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:471::8)
 by AM7P190MB0664.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 13:01:51 +0000
Received: from PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
 ([fe80::d3d4:c2b6:72cd:a034]) by PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
 ([fe80::d3d4:c2b6:72cd:a034%5]) with mapi id 15.20.8835.025; Thu, 19 Jun 2025
 13:01:51 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "aman.deep.singh@intel.com"
 <aman.deep.singh@intel.com>, "yuying.zhang@intel.com"
 <yuying.zhang@intel.com>, "orika@nvidia.com" <orika@nvidia.com>,
 "mcoqueli@redhat.com" <mcoqueli@redhat.com>, Christian Koue Muf
 <ckm@napatech.com>, "matan@mellanox.com" <matan@mellanox.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, Mykola Kostenok
 <mko-plv@napatech.com>, Serhii Iliushyk <sil-plv@napatech.com>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>
Subject: RE: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
Thread-Topic: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
Thread-Index: AQHb1INXbzAz0TMiZEy8qVH/AecSzrPyqBqrgAzMBICACwwaXQ==
Date: Thu, 19 Jun 2025 13:01:51 +0000
Message-ID: <PAWP190MB216097D1AF51B638F01595A98B7DA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
References: <20250602084025.1881768-2-dvo-plv@napatech.com>
 <20250602085005.1882499-1-dvo-plv@napatech.com>
 <20250602085005.1882499-2-dvo-plv@napatech.com>
 <6ee82aef-dbb1-4e5f-8a53-6a956161c1db@redhat.com>
 <PAWP190MB2160B45C3304F810ED0172918B6CA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
 <ecd5783c-8d16-42c5-9585-03035d5b78be@redhat.com>
In-Reply-To: <ecd5783c-8d16-42c5-9585-03035d5b78be@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWP190MB2160:EE_|AM7P190MB0664:EE_
x-ms-office365-filtering-correlation-id: 927b9f00-eb37-4aa6-4166-08ddaf317582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|13003099007|38070700018|921020;
x-microsoft-antispam-message-info: =?koi8-r?Q?NsLfPIPYQWSvgAs2BvMR3i9Sw+DIX8cjvOiTs09idVsN40sI4HqMKCdE0+Cd1e?=
 =?koi8-r?Q?yJMTLP20quR5Qe+wGurZ89PL87nrkDdz+OA6D1nx3xSEuwIVB4s86G6MiQKL5/?=
 =?koi8-r?Q?YIuDZapH8KwhbAPZ5NagG7PN8IAOMe7LW5A2ZA/CKl52mFZT3/fmtlLUP+u4hY?=
 =?koi8-r?Q?wi9xCel1+SjnG27f4YHX22UZcVTOsXU+Mmt5e10Wu8j3CBq/6QUNlug2cf2apJ?=
 =?koi8-r?Q?QTmLyaPgn+TifGQqHBEmoiJ6FQuC455uiw5CTblAg5U4GFfbgbhgQJ1VI1pAkj?=
 =?koi8-r?Q?v61MqpTJMjBVEH6Rbl0KgKxn5tRWNZS9f8Jae5M1TEy4oYq7Os21FGc/G9rNpM?=
 =?koi8-r?Q?AhaI6dREuM/rNeoSh2fUn9EJAD2+Q5h01XQMqrlpJDswuyRTaZ1Ldm6da41hgX?=
 =?koi8-r?Q?pZ1LFBDBJ2vIX/bTUXPUBfczOqG99LZY/1/hyDak1kjp4otz2ol1zadtNp4+zC?=
 =?koi8-r?Q?gLdWRsyfEizWNfCt4q7mjt86z72A+e87sYphosXhh7Z8CRI7p+T4VRDReNJnUW?=
 =?koi8-r?Q?mWbl/i6DmTYQzQHGUZuYsOMOBydKGOc4RchT7oD+wktoSaaULbN1JOoY7kBdEn?=
 =?koi8-r?Q?TgnfuKeBawkoqd01xxd7cZ2a9ZGGtMjKqKH3moM26XtEVlxKH4WEKW568UJ9Sc?=
 =?koi8-r?Q?I03M+wwWtAG91gghzjHRX7SRJ++7KXjw3P1rDGZE95C3CS1kM2Wr7KB2b0/1Cc?=
 =?koi8-r?Q?JOGH87hEQBjkoeZj4RtLfbbPfgg11hjohXvAe3vUcF6Bgy9PGbjAuht3bQnAOk?=
 =?koi8-r?Q?i/Qi4ToiqYfeB3jA2typ1LFObCsGpZYjQ+mRW4WNHESDoSB/fseUWdd1dxBhLC?=
 =?koi8-r?Q?5Zm/vSUcmdwT+NjSjBZsZ6RKeYshO+2L7rD+sbu7P2cj+yd12y8x6IkEiLsO1w?=
 =?koi8-r?Q?j2QapzIzJ+dkfYmHCvr2PlJGZI9f8XSPwB8x5jlP0R0QLEnB9Nw86lXFUAGIFQ?=
 =?koi8-r?Q?t23MzTtaYuRVyyWi9pddrEK/WyHGY6a/A1EYp2Gixh5gzHS2L7sRIv5abN/LuG?=
 =?koi8-r?Q?Z8rNVXMl6Og1z9+8EQ1p5Vw3Q5PLgK1C4FkNkmyvxLY5RxUpjGK8dKELA2jLZz?=
 =?koi8-r?Q?pE4DVQF5Ob/ZlvKhTWWrWiO0yWSy9FCC8c1j6pfInfOpexO3ozF1rajbvEXNH+?=
 =?koi8-r?Q?tOPMh3IhN8IE3jVlwqDcDCBoYCaVip+x15YMCqVfA/oeAL9JZK0WUJCrTGVDm/?=
 =?koi8-r?Q?Kr8WwMwav7tYF3/5apyY6/d0i5b9Lw61Lrug7wKV/q66dq02mqU2KOPEnDaxpk?=
 =?koi8-r?Q?49M8u8pdxECv6dFUuSCrYnzveHqytT32Ld8+UCvWl1+QS6NP379I2NBvl79Qam?=
 =?koi8-r?Q?BopKLFeeGFOsKMf1nkUqyyZZo919S3mjvx77d2Jk9yAUjhwn0MGdw/doRF6y4F?=
 =?koi8-r?Q?RlVmx5YPTbQhN4VCcWmqNj0J7eE9W0ufNBZkMjh/6/OzP9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWP190MB2160.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?ntBuT8UdG4AnAn+85MNs34R2zhdIH9cRvcEpPHsHhOVkNajZ8vaU6UcVlFb5Ps?=
 =?koi8-r?Q?MicjdgFULRUNwVwr34N19bM8CSbkWOIY2wZxedPb3PWpvNW+Nmq3E68tT29m8I?=
 =?koi8-r?Q?veyIaFBXAzPRq9oLcsntJnDFQsP7//8nfwXdS+TgXu03sUFKy9Gw+uH/uCi6vL?=
 =?koi8-r?Q?KSKOQZcwBl4GDbJuanghbaGgPbIF6bljYjE3O8H5Hr9QG1XA2AKIC2ECM9K0X5?=
 =?koi8-r?Q?Ma96Ecowmp3Khiv39sOB4qfAh1qXeLYgLeNkoH+wWWSJy/R2YmHuBnTO7zngn7?=
 =?koi8-r?Q?QAw0iaREvPEhTmQ4VLRoh9hRLjgJsIOFkuSNEaeBt+3Hw4U6zblr+jnsAUWYPl?=
 =?koi8-r?Q?oEgmoL1ysZ89ZBxU4Gm3bPZePTsPWR1QdwdUC2bNgDInmYlYAQRLMk59C/qMay?=
 =?koi8-r?Q?Adir/+iGOd4teWcEMcRhYlRhxEkXFY5yVgUxlw5dXpCIThrAInyjqS3sqYPg/L?=
 =?koi8-r?Q?ndIEm5tJLhekFZewnmcVCSDKO3cLud34I+bUNbOA4kLN/zbB/BEoqQEJYPCzE4?=
 =?koi8-r?Q?y2+BZhLI9X30KxfHEJPHG/F4HzEfIpc5ElSspSkfkzxDZ0DxWk1MEfn0SVxMgl?=
 =?koi8-r?Q?wuAKo3QOcbtpoDUul8sgJJT9rvhnr6hpBXiWTLEOteP5POUrFjptK/8XhLxyO3?=
 =?koi8-r?Q?O84hQRuSkgN5lFbnOGTF7UP0Eo40CRl8GOqw/ApYyjW+NBBtnjjifHIw+IjJWW?=
 =?koi8-r?Q?tMOmFkLWTgQ09Rh3doYoci2p6oUC6qLdgqAGg7znbP3+Cj6gxlJbwH/KtJ8//V?=
 =?koi8-r?Q?sm3C9nbsKTK6bkdxC7zAfBBfpjympHo823w8F4xx4kmHCZiNa1tQyebifljMBk?=
 =?koi8-r?Q?Fv/9Rnk8mcxPleaqLriEYdahHm0SvZCvCOctPc5/xt/bCEE+YiruEQqmOol2KJ?=
 =?koi8-r?Q?gX4h9H7k0mffDOtjXGowRrPPyx7sXis7W+4/Xp0a7lLYc8RNVKTsTPr9kNs7A/?=
 =?koi8-r?Q?JfBEyynhMU+k9oQnOINmMVs18DHudr9dYyXVeCSh1clqbZ1yTktMJR7GecO8Vx?=
 =?koi8-r?Q?TM9TWZEuGdZ3O5Mg9C+Vf9Zxm3Mr7Fjs6D+wVphcwnAxm9XgUM2HH4VZ0jOGMZ?=
 =?koi8-r?Q?mRY7LbD3RmXNP+65E7OH3jcJT4EMbxhCYBgZHaddlbEDPoDNX1SD6kUG6GM8OO?=
 =?koi8-r?Q?vDsvXAyPeP1K9b7oKLRnAYZBqUpbuL8T3vqXYK4sECgqgiFpEXcax1KwgADsXC?=
 =?koi8-r?Q?vyJRdtfRSsjtG1TBTiky01ZQ7xn5GvySerB7bjDRYhBkNNRqB2LnBPl/CzacTn?=
 =?koi8-r?Q?60vPxuUFfqbiJjEYmFn1bvrXoRxuu/+iwUTrtM0wLoc8yQa4Y/IWT2UymX9T8t?=
 =?koi8-r?Q?VDwn6aBYqVugCHlqWfFcKLtqwuyfwUFCvfQtPQ4JCk/4S7tvNL2KqC7OvgcI83?=
 =?koi8-r?Q?gefcFENwlIxxGVwpuX99vVrnG0pDoDjkilE4P2itpbObtrHLeiMHSIYBPAdT7a?=
 =?koi8-r?Q?XolebFvvSST+HAQEjANKYXzhZLKy0bNiuO7VCdnT7f2wnW2KetvR6nck+Vq35f?=
 =?koi8-r?Q?xuNgAI94tWeUpMa6RvbAHpsHZEOXQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PAWP190MB216097D1AF51B638F01595A98B7DAPAWP190MB2160EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: umQgwkEu0sewjtXOYHVM5PMYa06G4Ef+dgwYQXu2TZ+HogoIgqYbI7Gplw5G3x3XEuktXE8/EM8Pyw+dRgrye7/1YWLxqqFpEZAKvk0a83i99bLoRpq3b8W7/ZryrJd9XFVAJZrpa/btBUeBYmh2qaCXIUvq6oLwnAdImB0K4ZKROGObrbSM23Bl+KtlVrds+cxKgm6lQJ+e7UEPhO/dLPQzIFO59GkGqz3zhoKsD0f1XVvzWq8QRHMpQ8mqlv9y9Py0M5VY8Tzq/1IsxgkubNE0So48YkKF0pQFmPxT37y0ZbDS+Ku2kI43G0I2aYBJFiSyfEY9gw+0aiNImYsious3SayDViyuFzfI5cb22bOIM8SjS480b8ZdaZZ+TRqkf/CTwA+Dckrz/Sb66iqJ5ExzmPZnbDiQYh8Ss4KEZ3bscTiWGRtF418yrsTSDB2XMUidFY3MO0D9A5FhYd513SnlP2o0wqTB28LO9ClJfnozKDIr1vp2h97O1K6kCxC9ITkglGs53DRimO6WYACuSM0nBj4qQkFg5Nm0onThkupmOSAH7AN4t5yLRnwTmwNZlFWspQodd/zn+BE/zvaSbxLoCaKGhcvWF3bBxWhJjxfVQeaJG1pXZs3kO95JuaCup40rIlyAtfLmJ+kv243j+Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWP190MB2160.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b9f00-eb37-4aa6-4166-08ddaf317582
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 13:01:51.5824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0SHg5QDRBzfTTV9OEwbVCsyWeNXdYnDURFq5qA3d2LPVgncZOtJ8xx5E4M7WClJvfJFlDqCpNF1KRoz/zoA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0664
X-BESS-ID: 1750338113-311045-32607-3326-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 52.101.66.123
X-BESS-Parts: H4sIAAAAAAACAzWMMQrDMAxF76I5g2VZkpWrlA52IpGldKiHQsnd6yFZPo8H7z
 9+4N8BK4y5C7w/sBoRTTqmrGRMrmWLGmaN027UwncSoY5e4Fzu/hivq8/KLNeBlsJK5J
 a45uRbw4whqiFoHXuG8/kHzW4jioIAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265448 [from 
 cloudscan11-154.eu-central-1a.ess.aws.cudaops.com]
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

--_000_PAWP190MB216097D1AF51B638F01595A98B7DAPAWP190MB2160EURP_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi, Maxime


I understand your point. However we coould have a situation like this, coul=
d resize twice:
VHOST_CONFIG: (/usr/local/var/run/stdvio4) read message VHOST_USER_SET_MEM_=
TABLE
VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size: 0x4000=
0000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest physical addr: 0x14000000=
0
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest virtual  addr: 0x14000000=
0
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  host  virtual  addr: 0x7fde0000=
0000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap addr : 0x7fde00000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap size : 0x40000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap align: 0x40000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap off  : 0x0
VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size: 0x4000=
0000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest physical addr: 0x11c00000=
00
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest virtual  addr: 0x11c00000=
00
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  host  virtual  addr: 0x7fddc000=
0000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap addr : 0x7fddc0000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap size : 0x40000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap align: 0x40000000
VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap off  : 0x0

When we set memory region twice. After first iteration VIRTIO_DEV_VDPA_CONF=
IGURED flag will be unset here: https://github.com/DPDK/dpdk/blob/main/lib/=
vhost/vhost_user.c#L1425 On the second iteration, this leads to an rte_pani=
c, as queues are accessed without a lock.

So we should check vhost message id ( VHOST_USER_SET_MEM_TABLE ).

However, extend VHOST_USER_ASSERT_LOCK macros with additional check if we w=
ork with this message VHOST_USER_SET_MEM_TABLE not handle this case, theref=
ore translate_ring_addresses function calls q_assert_lock directly, without=
 macros wrapper. In this function is check access_lock vhost_virtqueue and =
this case should be handle.

To address the described issue, we need to make the following changes:

  1.  Extend VHOST_USER_ASSERT_LOCK macro:
     *   Add a check for the VHOST_USER_SET_MEM_TABLE message ID.
     *   Skip rte_panic if the message ID matches VHOST_USER_SET_MEM_TABLE.
  2.  Modify translate_ring_addresses function:
     *   Extend its signature to include the id parameter (message ID).
     *   Add logic to skip vq_assert_lock if the message ID matches VHOST_U=
SER_SET_MEM_TABLE.


  1.
Extend VHOST_USER_ASSERT_LOCK Macro:

#define VHOST_USER_ASSERT_LOCK(dev, vq, id) \
    do { \
        if ((id) =3D=3D VHOST_USER_SET_MEM_TABLE) \
            break; \
        if (!(vq)->access_ok) \
            rte_panic("Virtqueue access lock not held\n"); \
    } while (0


  1.
Modify translate_ring_addresses Function:

static int
translate_ring_addresses(struct virtio_net *dev, struct vhost_virtqueue *vq=
, uint32_t id)
{
    if (id !=3D VHOST_USER_SET_MEM_TABLE)
        vq_assert_lock(dev, vq);

    // Existing logic for translating ring addresses...
    // ...existing code...
    return 0;
}


This approach requires extending more functions with conditional checks to =
handle cases where queue locking should be ignored when the memory table is=
 impacted.

Do you have any thoughts about this? Or I should rework my patchset accordi=
ng to this described solution above ?


________________________________
=EF=D4: Maxime Coquelin <maxime.coquelin@redhat.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 12 =C9=C0=CE=D1 2025 =C7. 14:38
=EB=CF=CD=D5: Danylo Vodopianov <dvo-plv@napatech.com>; thomas@monjalon.net=
 <thomas@monjalon.net>; aman.deep.singh@intel.com <aman.deep.singh@intel.co=
m>; yuying.zhang@intel.com <yuying.zhang@intel.com>; orika@nvidia.com <orik=
a@nvidia.com>; mcoqueli@redhat.com <mcoqueli@redhat.com>; Christian Koue Mu=
f <ckm@napatech.com>; matan@mellanox.com <matan@mellanox.com>; david.marcha=
nd@redhat.com <david.marchand@redhat.com>; Mykola Kostenok <mko-plv@napatec=
h.com>; Serhii Iliushyk <sil-plv@napatech.com>
=EB=CF=D0=C9=D1: stephen@networkplumber.org <stephen@networkplumber.org>; d=
ev@dpdk.org <dev@dpdk.org>; Chenbo Xia <chenbox@nvidia.com>
=F4=C5=CD=C1: Re: [PATCH v4 1/1] vhost: handle virtqueue locking for memory=
 hotplug

Hi Danylo,

On 6/4/25 10:32 AM, Danylo Vodopianov wrote:
> Hello, Maxime
>
> Thank you for your review.
> If I understand correctly, you propose modifying the |
> VHOST_USER_ASSERT_LOCK()| macro so that a |VHOST_USER_SET_MEM_TABLE|
>   request does not trigger an assertion.
> However, I believe such modification would not be appropriate, as it
> would revert the logic introduced in commit |5e8fcc60b59d| ("vhost:
> enhance virtqueue access lock asserts"). With this approach, we would be
> performing memory hotplug without queue locking, which could lead to
> unintended consequences.
> Regarding VDPA device regression. We faced with this issue when we
> request the number of lcores that the default amount of memory on the
> socket cannot handle it.
> So, regression occurred during the startup part, during device
> configuration when it creates pkt mbuf pool.
>
> Let me know your thoughts regarding this.

No, my point was to modify VHOST_USER_ASSERT_LOCK() to no trigger an
assertion in case vDPA is configured, as we don't want to lock in this
case.

Regards,
Maxime

> ------------------------------------------------------------------------
> *=EF=D4:* Maxime Coquelin <maxime.coquelin@redhat.com>
> *=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:* 3 =C9=C0=CE=D1 2025 =C7. 15:30
> *=EB=CF=CD=D5:* Danylo Vodopianov <dvo-plv@napatech.com>; thomas@monjalon=
.net
> <thomas@monjalon.net>; aman.deep.singh@intel.com
> <aman.deep.singh@intel.com>; yuying.zhang@intel.com
> <yuying.zhang@intel.com>; orika@nvidia.com <orika@nvidia.com>;
> mcoqueli@redhat.com <mcoqueli@redhat.com>; Christian Koue Muf
> <ckm@napatech.com>; matan@mellanox.com <matan@mellanox.com>;
> david.marchand@redhat.com <david.marchand@redhat.com>; Mykola Kostenok
> <mko-plv@napatech.com>; Serhii Iliushyk <sil-plv@napatech.com>
> *=EB=CF=D0=C9=D1:* stephen@networkplumber.org <stephen@networkplumber.org=
>;
> dev@dpdk.org <dev@dpdk.org>; Chenbo Xia <chenbox@nvidia.com>
> *=F4=C5=CD=C1:* Re: [PATCH v4 1/1] vhost: handle virtqueue locking for me=
mory
> hotplug
> Hello Danylo,
>
> On 6/2/25 10:50 AM, Danylo Vodopianov wrote:
>> For vDPA devices, virtqueues are not locked once the device has been
>> configured. In the
>> commit 5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
>> the asserts were enhanced to trigger rte_panic functionality, preventing
>> access to virtqueues without locking. However, this change introduced
>> an issue where the memory hotplug mechanism, added in the
>> commit 127f9c6f7b78 ("vhost: handle memory hotplug with vDPA devices"),
>> no longer works. Since it expects for all queues are locked.
>>
>> During the initialization of a vDPA device, the driver sets the
>> VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the
>> vhost_user_lock_all_queue_pairs function from locking the
>> virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED
>> flag allows the use of the hotplug mechanism, but it fails
>> because the virtqueues are not locked, while it expects to be locked
>> for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.
>>
>> This patch addresses the issue by enhancing the conditional statement
>> to include a new condition. Specifically, when the device receives the
>> VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update
>> the basic configurations and hotplug the guest memory.
>>
>> This fix does not impact access lock when vDPA driver is configured
>> for other unnecessary message handlers.
>>
>> Manual memory configuring with "--socket-mem" option allows to avoid
>> hotplug mechanism using.
>
> s/using/use/
>
> It needs a fixes tag, and stable@dpdk.org should be cc'ed, so that it
> gets backported to LTS branches.
>
>>
>> Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
>> ---
>>   lib/vhost/vhost_user.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
>> index ec950acf97..16d03e1033 100644
>> --- a/lib/vhost/vhost_user.c
>> +++ b/lib/vhost/vhost_user.c
>> @@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)
>>         * would cause a dead lock.
>>         */
>>        if (msg_handler !=3D NULL && msg_handler->lock_all_qps) {
>> -             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
>> +             /* Lock all queue pairs if the device is not configured fo=
r vDPA,
>> +              * or if it is configured for vDPA but the request is VHOS=
T_USER_SET_MEM_TABLE.
>> +              * This ensures proper queue locking for memory table upda=
tes and guest
>> +              * memory hotplug.
>> +              */
>> +             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
>> +                     request =3D=3D VHOST_USER_SET_MEM_TABLE) {
>
> It looks like a workaround, and I'm afraid it could cause regression
> with some vDPA devices, or that it would not be enough and we would have
> to add other requests as exception.
>
>
> Wouldn't it better to modify VHOST_USER_ASSERT_LOCK() so that it takes
> into account the VIRTIO_DEV_VDPA_CONFIGURED flag?
>
> Thanks,
> Maxime
>
>>                        vhost_user_lock_all_queue_pairs(dev);
>>                        unlock_required =3D 1;
>>                }
>


--_000_PAWP190MB216097D1AF51B638F01595A98B7DAPAWP190MB2160EURP_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi, Maxime</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I understand your point. However we coould have a situation like this, coul=
d resize twice:</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left-wid=
th: 3px; border-left-style: solid; border-left-color: rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4) read message VHOST_USER_SET_MEM_=
TABLE</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size: 0x4000=
0000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; guest physical addr: 0x140=
000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; guest virtual&nbsp; addr: =
0x140000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; host&nbsp; virtual&nbsp; a=
ddr: 0x7fde00000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap addr : 0x7fde00000000=
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap size : 0x40000000</di=
v>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap align: 0x40000000</di=
v>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap off&nbsp; : 0x0</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size: 0x4000=
0000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; guest physical addr: 0x11c=
0000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; guest virtual&nbsp; addr: =
0x11c0000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; host&nbsp; virtual&nbsp; a=
ddr: 0x7fddc0000000</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap addr : 0x7fddc0000000=
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap size : 0x40000000</di=
v>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap align: 0x40000000</di=
v>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
VHOST_CONFIG: (/usr/local/var/run/stdvio4)&nbsp; mmap off&nbsp; : 0x0</div>
</blockquote>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
When we set memory region twice. After first iteration VIRTIO_DEV_VDPA_CONF=
IGURED flag will be unset here:
<a href=3D"https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L1=
425" id=3D"OWAb0b80a98-f14d-1e16-713d-4420f53834de" class=3D"OWAAutoLink">
https://github.com/DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L1425</a>&nbs=
p;On the second iteration, this leads to an rte_panic, as queues are access=
ed without a lock.</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
So we should check vhost message id ( VHOST_USER_SET_MEM_TABLE ).</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
However, extend VHOST_USER_ASSERT_LOCK&nbsp;macros with additional check if=
 we work with this message VHOST_USER_SET_MEM_TABLE&nbsp;not handle this ca=
se, therefore translate_ring_addresses&nbsp;function calls q_assert_lock&nb=
sp;directly, without macros wrapper. In this function
 is check access_lock vhost_virtqueue&nbsp;and this case should be handle.<=
/div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px 0px=
 16px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
To address the described issue, we need to make the following changes:</div=
>
<ol start=3D"1" style=3D"list-style-type: decimal;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-h=
eight: normal; margin: 0px;">
<b>Extend VHOST_USER_ASSERT_LOCK&nbsp;macro</b>:</li><ul style=3D"list-styl=
e-type: circle;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-h=
eight: normal; margin: 0px;">
Add a check for the VHOST_USER_SET_MEM_TABLE&nbsp;message ID.</li><li style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-height: no=
rmal; margin: 0px;">
Skip rte_panic&nbsp;if the message ID matches VHOST_USER_SET_MEM_TABLE.</li=
></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-h=
eight: normal; margin: 0px;">
<b>Modify translate_ring_addresses&nbsp;function</b>:</li><ul style=3D"list=
-style-type: circle;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-h=
eight: normal; margin: 0px;">
Extend its signature to include the id&nbsp;parameter (message ID).</li><li=
 style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cali=
bri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-heig=
ht: normal; margin: 0px;">
Add logic to skip vq_assert_lock&nbsp;if the message ID matches VHOST_USER_=
SET_MEM_TABLE.</li></ul>
</ol>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bott=
om: 0px; list-style-type: decimal;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-right: 0px; margin-left: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: n=
ormal; margin-top: 0px; margin-bottom: 8px;">
Extend <b>VHOST_USER_ASSERT_LOCK</b>&nbsp;Macro:</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 15px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left-wid=
th: 3px; border-left-style: solid; border-left-color: rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#define&nbsp;VHOST_USER_ASSERT_LOCK(dev, vq, id)&nbsp;\</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; do&nbsp;{&nbsp;\</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp;((id)&nbsp;=3D=3D&nbsp;V=
HOST_USER_SET_MEM_TABLE)&nbsp;\</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break; \=
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp;(!(vq)-&gt;access_ok)&nb=
sp;\</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_pani=
c(&quot;Virtqueue&nbsp;access&nbsp;lock&nbsp;not&nbsp;held\n&quot;); \</div=
>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; }&nbsp;while&nbsp;(0</div>
</blockquote>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 15px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"2" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bott=
om: 0px; list-style-type: decimal;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-right: 0px; margin-left: 0px;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: n=
ormal; margin-top: 0px; margin-bottom: 8px;">
Modify <b>translate_ring_addresses</b>&nbsp;Function:</div>
</li></ol>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left-wid=
th: 3px; border-left-style: solid; border-left-color: rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
static int</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
translate_ring_addresses(struct&nbsp;virtio_net *dev, struct&nbsp;vhost_vir=
tqueue *vq, uint32_t id)</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
{</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; if&nbsp;(id !=3D&nbsp;VHOST_USER_SET_MEM_TABLE)</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; vq_assert_lock(dev, vq);</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; // Existing logic for translating ring addresses...</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; // ...existing code...</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; return 0;</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
}</div>
</blockquote>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 14px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This approach requires extending more functions with conditional checks to =
handle cases where queue locking should be ignored when the memory table is=
 impacted.&nbsp;</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; mi=
n-height: 15px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: normal; margin: 0px; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Do you have any thoughts about this? Or I should rework my patchset accordi=
ng to this described solution above ?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=EF=D4:</b> Maxime Coquelin &lt=
;maxime.coquelin@redhat.com&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 12 =C9=C0=CE=D1 2025 =C7. 14:38<br>
<b>=EB=CF=CD=D5:</b> Danylo Vodopianov &lt;dvo-plv@napatech.com&gt;; thomas=
@monjalon.net &lt;thomas@monjalon.net&gt;; aman.deep.singh@intel.com &lt;am=
an.deep.singh@intel.com&gt;; yuying.zhang@intel.com &lt;yuying.zhang@intel.=
com&gt;; orika@nvidia.com &lt;orika@nvidia.com&gt;; mcoqueli@redhat.com
 &lt;mcoqueli@redhat.com&gt;; Christian Koue Muf &lt;ckm@napatech.com&gt;; =
matan@mellanox.com &lt;matan@mellanox.com&gt;; david.marchand@redhat.com &l=
t;david.marchand@redhat.com&gt;; Mykola Kostenok &lt;mko-plv@napatech.com&g=
t;; Serhii Iliushyk &lt;sil-plv@napatech.com&gt;<br>
<b>=EB=CF=D0=C9=D1:</b> stephen@networkplumber.org &lt;stephen@networkplumb=
er.org&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;; Chenbo Xia &lt;chenbox@nvidi=
a.com&gt;<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH v4 1/1] vhost: handle virtqueue locking for=
 memory hotplug</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Danylo,<br>
<br>
On 6/4/25 10:32 AM, Danylo Vodopianov wrote:<br>
&gt; Hello, Maxime<br>
&gt; <br>
&gt; Thank you for your review.<br>
&gt; If I understand correctly, you propose modifying the | <br>
&gt; VHOST_USER_ASSERT_LOCK()|&nbsp;macro so that a |VHOST_USER_SET_MEM_TAB=
LE| <br>
&gt;&nbsp; &nbsp;request does not trigger an assertion.<br>
&gt; However, I believe such modification would not be appropriate, as it <=
br>
&gt; would revert the logic introduced in commit |5e8fcc60b59d|&nbsp;(&quot=
;vhost: <br>
&gt; enhance virtqueue access lock asserts&quot;). With this approach, we w=
ould be <br>
&gt; performing memory hotplug without queue locking, which could lead to <=
br>
&gt; unintended consequences.<br>
&gt; Regarding VDPA device regression. We faced with this issue when we <br=
>
&gt; request the number of lcores that the default amount of memory on the =
<br>
&gt; socket cannot handle it.<br>
&gt; So, regression occurred during the startup part, during device <br>
&gt; configuration when it creates pkt mbuf pool.<br>
&gt; <br>
&gt; Let me know your thoughts regarding this.<br>
<br>
No, my point was to modify VHOST_USER_ASSERT_LOCK() to no trigger an<br>
assertion in case vDPA is configured, as we don't want to lock in this<br>
case.<br>
<br>
Regards,<br>
Maxime<br>
<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *=EF=D4:* Maxime Coquelin &lt;maxime.coquelin@redhat.com&gt;<br>
&gt; *=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:* 3 =C9=C0=CE=D1 2025 =C7. 15:30<br>
&gt; *=EB=CF=CD=D5:* Danylo Vodopianov &lt;dvo-plv@napatech.com&gt;; thomas=
@monjalon.net <br>
&gt; &lt;thomas@monjalon.net&gt;; aman.deep.singh@intel.com <br>
&gt; &lt;aman.deep.singh@intel.com&gt;; yuying.zhang@intel.com <br>
&gt; &lt;yuying.zhang@intel.com&gt;; orika@nvidia.com &lt;orika@nvidia.com&=
gt;; <br>
&gt; mcoqueli@redhat.com &lt;mcoqueli@redhat.com&gt;; Christian Koue Muf <b=
r>
&gt; &lt;ckm@napatech.com&gt;; matan@mellanox.com &lt;matan@mellanox.com&gt=
;; <br>
&gt; david.marchand@redhat.com &lt;david.marchand@redhat.com&gt;; Mykola Ko=
stenok <br>
&gt; &lt;mko-plv@napatech.com&gt;; Serhii Iliushyk &lt;sil-plv@napatech.com=
&gt;<br>
&gt; *=EB=CF=D0=C9=D1:* stephen@networkplumber.org &lt;stephen@networkplumb=
er.org&gt;; <br>
&gt; dev@dpdk.org &lt;dev@dpdk.org&gt;; Chenbo Xia &lt;chenbox@nvidia.com&g=
t;<br>
&gt; *=F4=C5=CD=C1:* Re: [PATCH v4 1/1] vhost: handle virtqueue locking for=
 memory <br>
&gt; hotplug<br>
&gt; Hello Danylo,<br>
&gt; <br>
&gt; On 6/2/25 10:50 AM, Danylo Vodopianov wrote:<br>
&gt;&gt; For vDPA devices, virtqueues are not locked once the device has be=
en<br>
&gt;&gt; configured. In the<br>
&gt;&gt; commit 5e8fcc60b59d (&quot;vhost: enhance virtqueue access lock as=
serts&quot;),<br>
&gt;&gt; the asserts were enhanced to trigger rte_panic functionality, prev=
enting<br>
&gt;&gt; access to virtqueues without locking. However, this change introdu=
ced<br>
&gt;&gt; an issue where the memory hotplug mechanism, added in the<br>
&gt;&gt; commit 127f9c6f7b78 (&quot;vhost: handle memory hotplug with vDPA =
devices&quot;),<br>
&gt;&gt; no longer works. Since it expects for all queues are locked.<br>
&gt;&gt; <br>
&gt;&gt; During the initialization of a vDPA device, the driver sets the<br=
>
&gt;&gt; VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the<br>
&gt;&gt; vhost_user_lock_all_queue_pairs function from locking the<br>
&gt;&gt; virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURE=
D<br>
&gt;&gt; flag allows the use of the hotplug mechanism, but it fails<br>
&gt;&gt; because the virtqueues are not locked, while it expects to be lock=
ed<br>
&gt;&gt; for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.<=
br>
&gt;&gt; <br>
&gt;&gt; This patch addresses the issue by enhancing the conditional statem=
ent<br>
&gt;&gt; to include a new condition. Specifically, when the device receives=
 the<br>
&gt;&gt; VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to upd=
ate<br>
&gt;&gt; the basic configurations and hotplug the guest memory.<br>
&gt;&gt; <br>
&gt;&gt; This fix does not impact access lock when vDPA driver is configure=
d<br>
&gt;&gt; for other unnecessary message handlers.<br>
&gt;&gt; <br>
&gt;&gt; Manual memory configuring with &quot;--socket-mem&quot; option all=
ows to avoid<br>
&gt;&gt; hotplug mechanism using.<br>
&gt; <br>
&gt; s/using/use/<br>
&gt; <br>
&gt; It needs a fixes tag, and stable@dpdk.org should be cc'ed, so that it<=
br>
&gt; gets backported to LTS branches.<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Danylo Vodopianov &lt;dvo-plv@napatech.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; lib/vhost/vhost_user.c | 8 +++++++-<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c<br>
&gt;&gt; index ec950acf97..16d03e1033 100644<br>
&gt;&gt; --- a/lib/vhost/vhost_user.c<br>
&gt;&gt; +++ b/lib/vhost/vhost_user.c<br>
&gt;&gt; @@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * would cause a de=
ad lock.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg_handler !=3D NUL=
L &amp;&amp; msg_handler-&gt;lock_all_qps) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!(dev-&gt;flags &amp; VIRTIO_DEV_VDPA_CONFIGURED)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Lock all queue pairs if the device is not configured for vDPA,<b=
r>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * or if it is configured for vDPA but the request is VHOST_US=
ER_SET_MEM_TABLE.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * This ensures proper queue locking for memory table updates =
and guest<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * memory hotplug.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!(dev-&gt;flags &amp; VIRTIO_DEV_VDPA_CONFIGURED) ||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request =3D=3D VHOS=
T_USER_SET_MEM_TABLE) {<br>
&gt; <br>
&gt; It looks like a workaround, and I'm afraid it could cause regression<b=
r>
&gt; with some vDPA devices, or that it would not be enough and we would ha=
ve<br>
&gt; to add other requests as exception.<br>
&gt; <br>
&gt; <br>
&gt; Wouldn't it better to modify VHOST_USER_ASSERT_LOCK() so that it takes=
<br>
&gt; into account the VIRTIO_DEV_VDPA_CONFIGURED flag?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Maxime<br>
&gt; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vho=
st_user_lock_all_queue_pairs(dev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unl=
ock_required =3D 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PAWP190MB216097D1AF51B638F01595A98B7DAPAWP190MB2160EURP_--
