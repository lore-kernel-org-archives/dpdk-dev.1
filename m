Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ADE9D41E
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 18:03:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3DD4402F2;
	Wed,  4 Feb 2026 19:03:43 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by mails.dpdk.org (Postfix) with ESMTP id 923AB402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 19:03:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPhxhVhd+S0Gsm3sP+yeIuo+Bw/SH0CcIyrLAZNLis/B/bxujPWpnVs3SLM/e8qzgoiFaeq7kFBZEcD9bfrTZ02Eo46iJAfcAS+I8JZRsUB/AnhUZxrys6kNMdAlTJABZySkFx4IfRexNiESyctisyeov6KHixT3oOyMg/Mj4PCEulg7mhE8p+LqrUdWLyQ3aXON3GCFskjBpTvYw4GgGdkjnJbCQLZt8Jlx4cSWy6x9F5zNojmtZsc3zSQntqBSC+wbs1GPaaOAQ5BIsGFGAb8leY//CjIqj1pxNG2QQcsm39mLC0Pa459cp0bTjWRknkQiw+7fzcEGGpGKCO6Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W3PS6d91FQIlcMy1i1FqkMvzuTJZDLDismTXZ6P4Zg=;
 b=R4yVyYYFftku8lHoP+/88RxNcxwcoz16jIULj7tlKMiqR0Eae7M+QtD9KYt7mT6eAINik7htNIyvbH/gnANHAQXwJliownB/7l+qwKPtWuWM6FxrHbCVA2E01kxqy6FvSIhQ6sZ5Dvw2vnPL/0RNOAln3WT2+scciy6wxFbr0Rco0Okp+1l4LOFjPgNAS2OFfi5Q68Vx8giZ4fOwhPhzA5K3ILtk2ustvZerWgD75wuxajwr5ZNBw7E+qq0GNM2wGeRY6QAlmjQ5B3Ezur2iL6kDx/VNbNXM+D77mWV+ThYwoXQwWTXfbgtZs11GYceTtHrVbcsSFJAFJqQhUdHgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W3PS6d91FQIlcMy1i1FqkMvzuTJZDLDismTXZ6P4Zg=;
 b=mb5kVhsK5tJsYUdbt3wU7N5+ECaE+DHIGhGkYfIHwJ4vCYWHh7QrxzJ8Bq9bnGE3w8JQB973mpxUCNVcqsJrk5BU4FSNgX5xO+mo6PN9RO9XJL84RZsA2t4cnmHUCnH67mRUsD0lWdMvqjIkEW8j+IAM0speeXDDDHEhqWBX1onfbcnlbPTvgognzOl/xwOZMRAlsQ/arOPWrsRXp2kVE3x3mF4GmQGK5QevNJYtHV2Maou7+L8cq/Axx0+dBhiH3pI1HZ5TCOrs8ya0sv8NDMdJxLCw9pXkt+UPS9SSGQTQL150eWF0aCrbF+l34TGYUsp7eaf4SP3+ikFVst9nHg==
Received: from DM3PPF6AE862AC6.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c2d) by DM3PPFEC98198CD.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:03:31 +0000
Received: from DM3PPF6AE862AC6.namprd10.prod.outlook.com
 ([fe80::712a:23e7:b6f2:a7e4]) by DM3PPF6AE862AC6.namprd10.prod.outlook.com
 ([fe80::712a:23e7:b6f2:a7e4%3]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 18:03:30 +0000
From: Yehor Malikov <Yehor.Malikov@solidigm.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>
Subject: [PATCH] vhost: fix use-after-free in fdset during shutdown
Thread-Topic: [PATCH] vhost: fix use-after-free in fdset during shutdown
Thread-Index: AQHclgAacr3pqobJM0K9FTG+TxLPjQ==
Date: Wed, 4 Feb 2026 18:03:26 +0000
Message-ID: <DM3PPF6AE862AC6D49FBCC8B8702D368CD19798A@DM3PPF6AE862AC6.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Enabled=True;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SiteId=4bb44aac-867a-4be0-aa34-30794e8470dd;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SetDate=2026-02-04T18:00:11.0071497Z;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Name=P2
 Confidential; MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ContentBits=0;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF6AE862AC6:EE_|DM3PPFEC98198CD:EE_
x-ms-office365-filtering-correlation-id: 7f5d0d63-9658-4f3a-9e93-08de6417b471
x-etr-sdm: Outbound Disclaimer
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d5xcx0ofP1xSqgZ6lZrVoy58g7AiYd5wSXFlZHfMdkFe+0cpxH39uz5FaA3S?=
 =?us-ascii?Q?CiPGENmFFFLS6SRcGHPXkw/QD2YnAfsXLg+vVzpSmwkH897qa0crtU5xCEbR?=
 =?us-ascii?Q?mvNdyMcu+ywoXTELfvqSS4G8yqtug/Kl2mnO6s5hcmwDlD9kGyYqjijgFQo8?=
 =?us-ascii?Q?s4wCTB1EvFejyyb/2wVr+itT34KlYgDKQREUF32MqXPlvOD6RsgDuMTAb/Ec?=
 =?us-ascii?Q?sYVSi5ZN+tnL4n85zfFttCH+PECbDxFoMhcNbHpLSIyp57mHx6ET3Z0mJUTv?=
 =?us-ascii?Q?ZPsaPqlXoUcl2szsh2wZ0n3QD/uauRfEOlucUYx6tLXukNy8uuCHx71Q9VGC?=
 =?us-ascii?Q?gvNazBxy0Q5CuICIg62mawh3C2IomqQamnFncJjIxucR/xkWgfnB4CSHVZGj?=
 =?us-ascii?Q?0LWRbUDr6/ZwJjT0/Jdiq4PUmBI4z3bbm+k9eha7No4grN7Vl2mEA22NZKXP?=
 =?us-ascii?Q?UBdJP+LaL8EGtUZs/jQAWU0SyrtgXJmJKvMhBDS9z6Qqc0tlQtET4WGafzDo?=
 =?us-ascii?Q?LH+OYFgqARrx1NO2fdjUiv5OcsEjmziECAw4FFTk9R7rP7Kf/UthmdwTfewR?=
 =?us-ascii?Q?uvvCKQklcPpsu78HcOgIfyXum7I2cFVNa6E7eJqxaQJmDTpeLZmiW6WXbx6L?=
 =?us-ascii?Q?s3keQEradMdbGzt+anKYHqrrNX7b3bHecbgHnCXeeRo72fKkXHNkHexH+THy?=
 =?us-ascii?Q?jNOMWNf5aK9edspDGTHr30hP7Z4QTCx30cpUVcO4Cjb5Brqau0dcAixsfPc5?=
 =?us-ascii?Q?h6roC886jFv6R0CGf3IKoR3dT6yZfK8AtklC0plbFt4eM8T4zCVR7RTX8QQm?=
 =?us-ascii?Q?UEJefmt5DT88P7y6mFQ4alh9kvjvLQFpbIvuPLRCW2UmAjuTvoLNwwk2MZkU?=
 =?us-ascii?Q?c+KjfPtltfqBtMTU1FioeGjVRrk9y3FV925m4Sz+xDf17IKyPGGhYFE6+FYX?=
 =?us-ascii?Q?q4YX5ZZsTZ74n20vNQM/Rhhk9+Aw9UyKl/yEnxPvMxyhmzm8RcIbKy11ZKLw?=
 =?us-ascii?Q?bufdv0sckNv47dVtpD79JUfsqp5yR/GJIRN/E3AAkQVtc1MoaJ4abUl478dg?=
 =?us-ascii?Q?euCPsvxNfBFIvdrwTjcDv8UDmj8ivtMB1DtZ3U/9IbzXjNmigxbosvxbyv5R?=
 =?us-ascii?Q?qMsC3NLpgZkkc7atncbT0aTi5AoJioPtEdq2yHcF1cnLcfcGZDdqntGBUruv?=
 =?us-ascii?Q?ehidX/lpjOiZ93pXzRSvMWSp/0uWQGcshL5A5HxtEBi3PumTbFiKzMT8Zkd2?=
 =?us-ascii?Q?keh9GJUo4PRAK4rmMJBPZoDgsF3bzul42/lggMprFWYv2pdAmlm2todNeqYA?=
 =?us-ascii?Q?DmiTHGMOs9SuVSHaL1EWxUDTVfnNsi2z4JcfEksdnCL1YFwZrEbdrb+22hhi?=
 =?us-ascii?Q?seJ2cbuPSjnVEFFEkv3I51PKZv2o++vky7tELDJnFmipRjzPstAkRjdy53Z/?=
 =?us-ascii?Q?ol22xP4BmOXBSl0CEmayzSzl3Izkv6efWVm3OL/zXSdaQcvrC4EY1ykyHZ7X?=
 =?us-ascii?Q?gZFOSYP7TJaJ5HPHz6RaXqLUqdm349Vl3yEheb3hQNVam6ylrcj97zDUySex?=
 =?us-ascii?Q?X1vbQkjazUOEyHwMtGMtP3wIKf2FagCSP8d+rLULK4/12R0aW94OPPCVw1hN?=
 =?us-ascii?Q?MGLPs9ayYt71Cji2zrB3ZwY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF6AE862AC6.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xNp3LUweT4PhMicIxD3Bo2ipf5/axapThHsbli3R8biTrSyOcinTLQVjc7W?=
 =?us-ascii?Q?F0kV7+UzycatGhdv5Kwj4WNN6Tx/rDU8hoIM2ids2HyM7qpNaK0plRukJE9G?=
 =?us-ascii?Q?vyNeZkzHO8QGI6FcFwz7fyFxp14woSwLd376AwLONafWmsfLV8FlwyCN3oxg?=
 =?us-ascii?Q?M3wqzu1f8X6GZy/5wSA9sW7T2I74GqrYRUaIKSqUdE+ln0HZC9yNabpOFbn7?=
 =?us-ascii?Q?RhwZ0qvX1am/97GBA72jJmW5VMML+oez3hIn3/RCQwGMrekybs1MeR4rOGI/?=
 =?us-ascii?Q?l7RYMBrJ8fpMOyzEbuwxjKKyhpA2neWkpRjutbbvhBqJeo+n/jE/bhafSpHv?=
 =?us-ascii?Q?MEETx8Jfku4G9dqLnY3A6hweIUeXfkPzUYN1+/dGXxVB+cTHS1gGPaDs3uFC?=
 =?us-ascii?Q?DEFWwuDJwNS5D32JiUwiggZUrU/d8iaZexQm2M0oVeVVmiI7xPd3k4opsDkw?=
 =?us-ascii?Q?lVYdiH12K+dsgOG61LuzSGbVTyK6nflWt2ZfumgZdyvlh01v5dOZboXCB/qE?=
 =?us-ascii?Q?0hnALuIdGGKyeP/aNHj3xHYMsSryTOGWHGSz/p7huNFR47rGUU5J1dK41ugA?=
 =?us-ascii?Q?PyH+FxiFIrk0jEiEKJeUKoDskSiAGB0Pnl90g45DhtV8GDyQUuy2x0cGIM1r?=
 =?us-ascii?Q?QB8Xys3szyTMcn/xysQ7LB8mJs+a3Qm20bxpi/nz6pD1X9rfWPWp06zQXCfa?=
 =?us-ascii?Q?3Y0cDII1V8ejVLIMH+rvJBfjzfQZbOQkFfdv+QXKf4mxUDu2AGTUtCJEPxE9?=
 =?us-ascii?Q?EXkMY68aDG7AER4EpkwPas5krpsSwRzqMVgymeURiebVg9flOpetwLoo31nZ?=
 =?us-ascii?Q?90a1Azlr/xpVBC3/UaUcRvwKHCrgW6tUMGmWoOx1roqIGTyiYN/ZUnQXqRz6?=
 =?us-ascii?Q?Rs//3RbtxHYDHiSr5Vct5G793TMrhz0lOHHRRuUO89dK/uwWnioTUWk3ug1E?=
 =?us-ascii?Q?ciSoMg5NlrjmbG6yVY2yZ9TRmSrCsmpRH6v18vHAy0x0JsnFQ+EBmk6O60R2?=
 =?us-ascii?Q?HI3Cf8h80dOO97A7jndB5BsSMm6/k0K9/MbEKKgu/8yRcx4V60SuJmHp2CQ8?=
 =?us-ascii?Q?40mPwcD3bnYOdS36LmQFa0ixLpZan6gqAICQ/5THPHceQ1AmJ08LSebuBT+h?=
 =?us-ascii?Q?WDfu/5RoZeuEh2w9Eyd9+HB/x1s0GhCbjP8SRdMOwEDwLgfb4KaDVEaL4Utf?=
 =?us-ascii?Q?22sB8H+655tHV0D/ko2YtuhU6Z/fhxS4mrVGzltB87fdJBFGe0SJ7tYL9IFs?=
 =?us-ascii?Q?YTTUdDJjZ7jldE8cVlfTd+ZEs1z8DAeErUjnZL4DQbCp0aKW1j9jw2HBAeR8?=
 =?us-ascii?Q?FpLy9yWm6mzJiBIMtq78a3sW6aWJXgRyahpAgrBV3VCzXIXFJ+4w5oxgJvX2?=
 =?us-ascii?Q?C9e3F1JZmH1eURWdpnxnGeXOhy7hx5VX8+h11KcpYqzpj1XaRPKpwx+ALS69?=
 =?us-ascii?Q?GhGUrmG7RWeFAKaLA7YQ8ZoHiWb0llpDQLh74vKLzjCB02l0nFd29Bp3wqJO?=
 =?us-ascii?Q?bLMqRxB8933r8+mVUV8DrChly87uxy1tue6+cBmt8sl7WbCCsm5dLvU17JpV?=
 =?us-ascii?Q?Cu3J/BZcsi6pGTqSXcTIygcNvNouvWFplKvKGl6KDj11XsDnI1UIsT/kKwnv?=
 =?us-ascii?Q?w2RdJtkqxcbLeKdN/bu/qOc1mugyq8QmFzOGP2s//+fJQkOwKP5aZgVrpOAs?=
 =?us-ascii?Q?HJxPNd4r45lOtctxkm1dFlmV91XXi4g+10gaBuE/THZcfspJKbu0uwvU1+uD?=
 =?us-ascii?Q?a4ZSR3e+S56eaB/bVVt6EDK350uOx/ptdO6pIdLiV/lq7eDBOk8E?=
Content-Type: multipart/alternative;
 boundary="_000_DM3PPF6AE862AC6D49FBCC8B8702D368CD19798ADM3PPF6AE862AC6_"
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF6AE862AC6.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d0d63-9658-4f3a-9e93-08de6417b471
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 18:03:30.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ0CO6txQ5vwq5TAUkU7EoEUQW3z6C7qdxd136TFWC+ysU6uf1hyA5uc7XXKGC0ixw1ay7rzzrFqapsKqipnrt6qMuQTJYMYBeJmcnN36NfMeyn18eAYRPhhFx/emnZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEC98198CD
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

--_000_DM3PPF6AE862AC6D49FBCC8B8702D368CD19798ADM3PPF6AE862AC6_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From ecc4db77657e4a1388d3799883238adf6d693c73 Mon Sep 17 00:00:00 2001
From: Yehor Malikov <Yehor.Malikov@solidigm.com>
Date: Wed, 4 Feb 2026 11:58:15 +0100
Subject: [PATCH] vhost: fix use-after-free in fdset during shutdown

The fdset_event_dispatch thread runs in a loop checking the destroy
flag after each epoll_wait iteration. During process exit,
rte_eal_cleanup() frees hugepages memory while the fdset thread is
still running, causing use-after-free when accessing the fdset
structure.

Add fdset_deinit() function to properly stop the dispatch thread
before freeing resources:
- Set destroy flag to signal thread exit
- Wait for thread completion via rte_thread_join()
- Close epoll fd and free memory only after thread exits

Add RTE_FINI destructor to ensure fdset cleanup runs before EAL
cleanup frees hugepages.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap           |  1 +
 lib/vhost/fd_man.c | 33 +++++++++++++++++++++++++++++++++
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c |  8 ++++++++
 4 files changed, 43 insertions(+)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..6fb87ca810 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1800,6 +1800,7 @@ Yaron Illouz <yaroni@radcom.com>
 Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
+Yehor Malikov <Yehor.Malikov@solidigm.com>
 Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..4c759d44a4 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -149,6 +149,39 @@ fdset_init(const char *name)
        return NULL;
 }

+void
+fdset_deinit(struct fdset *pfdset)
+{
+       unsigned int val;
+       int i;
+
+       if (pfdset =3D=3D NULL)
+               return;
+
+       /* Signal the dispatch thread to stop */
+       pfdset->destroy =3D true;
+
+       /* Wait for the dispatch thread to exit */
+       if (rte_thread_join(pfdset->tid, &val) !=3D 0)
+               VHOST_FDMAN_LOG(ERR, "Failed to join %s event dispatch thre=
ad", pfdset->name);
+
+       /* Close epoll fd */
+       close(pfdset->epfd);
+
+       /* Remove from global fdsets list */
+       pthread_mutex_lock(&fdsets_mutex);
+       for (i =3D 0; i < MAX_FDSETS; i++) {
+               if (fdsets[i] =3D=3D pfdset) {
+                       fdsets[i] =3D NULL;
+                       break;
+               }
+       }
+       pthread_mutex_unlock(&fdsets_mutex);
+
+       /* Free the fdset */
+       rte_free(pfdset);
+}
+
 static int
 fdset_insert_entry(struct fdset *pfdset, int fd, fd_cb rcb, fd_cb wcb, voi=
d *dat)
 {
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index eadcc6fb42..c9e51badaa 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -15,6 +15,7 @@ struct fdset;
 typedef void (*fd_cb)(int fd, void *dat, int *close);

 struct fdset *fdset_init(const char *name);
+void fdset_deinit(struct fdset *pfdset);

 int fdset_add(struct fdset *pfdset, int fd,
        fd_cb rcb, fd_cb wcb, void *dat);
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..e953dd1849 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -1209,3 +1209,11 @@ rte_vhost_driver_start(const char *path)
        else
                return vhost_user_start_client(vsocket);
 }
+
+RTE_FINI(vhost_user_fdset_fini)
+{
+       if (vhost_user.fdset !=3D NULL) {
+               fdset_deinit(vhost_user.fdset);
+               vhost_user.fdset =3D NULL;
+       }
+}
--
2.51.1


CONFIDENTIALITY NOTICE: This email and any files attached may contain confi=
dential information and may be restricted from disclosure by corporate conf=
identiality guidelines, or applicable state and federal law. It is intended=
 solely for the use of the person or entity to whom the email was addressed=
. If you are not the intended recipient of this message, be advised that an=
y dissemination, distribution, or use of the contents of this message is st=
rictly prohibited. Please delete this email from your system if you are not=
 the intended recipient.

--_000_DM3PPF6AE862AC6D49FBCC8B8702D368CD19798ADM3PPF6AE862AC6_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
From ecc4db77657e4a1388d3799883238adf6d693c73 Mon Sep 17 00:00:00 2001</div=
>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
From: Yehor Malikov &lt;Yehor.Malikov@solidigm.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Date: Wed, 4 Feb 2026 11:58:15 +0100</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Subject: [PATCH] vhost: fix use-after-free in fdset during shutdown</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The fdset_event_dispatch thread runs in a loop checking the destroy</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
flag after each epoll_wait iteration. During process exit,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
rte_eal_cleanup() frees hugepages memory while the fdset thread is</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
still running, causing use-after-free when accessing the fdset</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
structure.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Add fdset_deinit() function to properly stop the dispatch thread</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
before freeing resources:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- Set destroy flag to signal thread exit</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- Wait for thread completion via rte_thread_join()</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- Close epoll fd and free memory only after thread exits</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Add RTE_FINI destructor to ensure fdset cleanup runs before EAL</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
cleanup frees hugepages.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Fixes: e68a6feaa3b3 (&quot;vhost: improve fdset initialization&quot;)</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Signed-off-by: Yehor Malikov &lt;Yehor.Malikov@solidigm.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
---</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;.mailmap &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;1 +</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;lib/vhost/fd_man.c | 33 +++++++++++++++++++++++++++++++++</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;lib/vhost/fd_man.h | &nbsp;1 +</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;lib/vhost/socket.c | &nbsp;8 ++++++++</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;4 files changed, 43 insertions(+)</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
diff --git a/.mailmap b/.mailmap</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
index 34a99f93a1..6fb87ca810 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--- a/.mailmap</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+++ b/.mailmap</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
@@ -1800,6 +1800,7 @@ Yaron Illouz &lt;yaroni@radcom.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yaroslav Brustinov &lt;ybrustin@cisco.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yash Sharma &lt;ysharma@marvell.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yasufumi Ogawa &lt;ogawa.yasufumi@lab.ntt.co.jp&gt; &lt;yasufum.o@gma=
il.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+Yehor Malikov &lt;Yehor.Malikov@solidigm.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yelena Krivosheev &lt;yelena@marvell.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yerden Zhumabekov &lt;e_zhumabekov@sts.kz&gt; &lt;yerden.zhumabekov@s=
ts.kz&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;Yevgeny Kliteynik &lt;kliteyn@nvidia.com&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
index f9147edee7..4c759d44a4 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--- a/lib/vhost/fd_man.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+++ b/lib/vhost/fd_man.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
@@ -149,6 +149,39 @@ fdset_init(const char *name)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; return NULL;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+void</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+fdset_deinit(struct fdset *pfdset)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+{</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; unsigned int val;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; int i;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; if (pfdset =3D=3D NULL)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; /* Signal the dispatch thread to stop */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; pfdset-&gt;destroy =3D true;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; /* Wait for the dispatch thread to exit */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; if (rte_thread_join(pfdset-&gt;tid, &amp;val) !=3D 0=
)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; VHOST_FDMAN_LOG(ERR, &qu=
ot;Failed to join %s event dispatch thread&quot;, pfdset-&gt;name);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; /* Close epoll fd */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; close(pfdset-&gt;epfd);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; /* Remove from global fdsets list */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; pthread_mutex_lock(&amp;fdsets_mutex);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; MAX_FDSETS; i++) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (fdsets[i] =3D=3D pfd=
set) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; fdsets[i] =3D NULL;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; break;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; pthread_mutex_unlock(&amp;fdsets_mutex);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; /* Free the fdset */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; rte_free(pfdset);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;static int</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;fdset_insert_entry(struct fdset *pfdset, int fd, fd_cb rcb, fd_cb wcb=
, void *dat)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
index eadcc6fb42..c9e51badaa 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--- a/lib/vhost/fd_man.h</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+++ b/lib/vhost/fd_man.h</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
@@ -15,6 +15,7 @@ struct fdset;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;typedef void (*fd_cb)(int fd, void *dat, int *close);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;struct fdset *fdset_init(const char *name);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+void fdset_deinit(struct fdset *pfdset);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;int fdset_add(struct fdset *pfdset, int fd,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; fd_cb rcb, fd_cb wcb, void *dat);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
index 9b4f332f94..e953dd1849 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--- a/lib/vhost/socket.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+++ b/lib/vhost/socket.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
@@ -1209,3 +1209,11 @@ rte_vhost_driver_start(const char *path)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; else</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return vhost_user_s=
tart_client(vsocket);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+RTE_FINI(vhost_user_fdset_fini)</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+{</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; if (vhost_user.fdset !=3D NULL) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fdset_deinit(vhost_user.=
fdset);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; vhost_user.fdset =3D NUL=
L;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
2.51.1</div>
<div dir=3D"ltr" id=3D"ms-outlook-mobile-signature" style=3D"color: inherit=
; background-color: inherit;">
<div style=3D"direction: ltr;"><br>
</div>
</div>
<p><span style=3D"font-size:12px;">CONFIDENTIALITY NOTICE: This email and a=
ny files attached may contain confidential information and may be restricte=
d from disclosure by corporate confidentiality guidelines, or applicable st=
ate and federal law. It is intended
 solely for the use of the person or entity to whom the email was addressed=
. If you are not the intended recipient of this message, be advised that an=
y dissemination, distribution, or use of the contents of this message is st=
rictly prohibited. Please delete
 this email from your system if you are not the intended recipient.</span><=
/p>
</body>
</html>

--_000_DM3PPF6AE862AC6D49FBCC8B8702D368CD19798ADM3PPF6AE862AC6_--
