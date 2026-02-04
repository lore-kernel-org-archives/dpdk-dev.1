Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF76EC1EB9
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 13:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B17D340E5A;
	Thu,  5 Feb 2026 14:49:44 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by mails.dpdk.org (Postfix) with ESMTP id 1A931402EE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 12:27:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRFjoSCCn/B6BKoLlrKZ/OZwvqSIr+w6dLuLB0rgcBCEUy7V0i6OnLAs5vU9lyw9UjfCeNnzMActkHLelRixId7rbnaGYCHU/rcftXxEXbYc/uJHkWBbrQ7zX4XB9zaZxrNI4YODJdhasBZQVnfd1nTc20rCsgrQotkujHnFPTTlQCpNMEjI9iwBzjZ8u22mFb/IJIAjEwT43okvheUAdUiWMWn2fBtAoxG0B97b9R3DfZg1e7qWxP7tPtYC0NnSeavEchlCbbq+2ciCfmRW8B25ZZh7ir6xpn5mIR2X4ystIOIrISHRLWAmmpxQTIWNDuULaaR4UiGKx2dRSg8DPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsLcYaUrKqzgaDvkECe5rn8wgvf0UIfyw0go5erBQkA=;
 b=rwbEzAgr6+DgMWNPviIotbF5+/4FgJF9WBrMsWOivak45tYkQLmYAn+RTHqF/ZDI7dDAl0mC5sUABtXXeT4iOa/Cf9ynRUWD/w57Zq1mZUHJcV4U3PLIqRFgHFHZRzPDh6T3XRMfYyrrDseQFqtuOJtL/HiZz74M/ewPD13dqIdhDsYh4kfgwC68AGW+gaNTuJaIyv9FJLVtjk1Xtfm2OWt7/ZTYs2MYjpLAfzF+JIR9vlhXtLGn+n4M1WSde5yLFQnEJqSrK75E8yfAJe4gD1mKQ3K8+l9krF+Mbx5VfGv825c9BUUiij5THZhgPhzNCVY3sCkmBj7zzwCbG8whUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsLcYaUrKqzgaDvkECe5rn8wgvf0UIfyw0go5erBQkA=;
 b=pukOlyiEe5NDy30ZAnlOu3FJXqjnMOCJYcgQCUmj6RdRAxb5omRXmmNqWplPN43k3lEoqB0/JnX/StFDAQ2t81ThZ1PNV1zO6j+IglhJh5wQ8bnU1gc7vqW0qLP0K6kfIA4ns82CkiihA2Sxk6AYMmdS4YathnSMe53GB4m6UjX7MeoslYedQii1k3HGxX7e5uRqhaI3DeQKBiKMprUy2z5pPDXi1M76NUjGihQN+SCff3NBpZxE1Xovew0Ib479oiI7LnrU09H/EwUn9fkLprG3OQmE/t96rivO9ViXBUGyhrZojvphbNqNp8eL6piHUumqAGEpIgW3xb396I3qRw==
Received: from DM3PPF6AE862AC6.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c2d) by SA1PR10MB6613.namprd10.prod.outlook.com
 (2603:10b6:806:2be::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 11:27:30 +0000
Received: from DM3PPF6AE862AC6.namprd10.prod.outlook.com
 ([fe80::712a:23e7:b6f2:a7e4]) by DM3PPF6AE862AC6.namprd10.prod.outlook.com
 ([fe80::712a:23e7:b6f2:a7e4%3]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 11:27:30 +0000
From: Yehor Malikov <Yehor.Malikov@solidigm.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>
Subject: [PATCH] vhost: fix use-after-free in fdset during shutdown
Thread-Topic: [PATCH] vhost: fix use-after-free in fdset during shutdown
Thread-Index: AQHclcg2xicJqjYF5UC8CRxldhpX1A==
Date: Wed, 4 Feb 2026 11:27:12 +0000
Message-ID: <DM3PPF6AE862AC6A0206449E3210CDA74869798A@DM3PPF6AE862AC6.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Enabled=True;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SiteId=4bb44aac-867a-4be0-aa34-30794e8470dd;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SetDate=2026-02-04T11:20:05.6093820Z;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Name=P2
 Confidential; MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ContentBits=0;
 MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF6AE862AC6:EE_|SA1PR10MB6613:EE_
x-ms-office365-filtering-correlation-id: 058745d8-0ba8-47f6-f533-08de63e061fb
x-etr-sdm: Outbound Disclaimer
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WM1YU5APQ8grl4X3qJImg+2fgtj6DJ/Kww+gi1qHHerS/pDggk9NPOc2avKE?=
 =?us-ascii?Q?2YxjvpzIG+zr23XROwgT8XYyzSSgZ0/14kagYRhWGmfU2sSa4NEvdEmnqD8a?=
 =?us-ascii?Q?bLzIVI1Wsr671mnbz/3VS5dkyJEeKDRp4dgVcHGsvYQ4LhTcjZEVvxIpXQqU?=
 =?us-ascii?Q?8HaMaWanqlJ98ekADJrvehPQwkMHAUwiw9aWgQUMhCycHbj0GbgVVAvqsXbA?=
 =?us-ascii?Q?yAm4p+edMfKTGVD0eTfRz9mG0N2fv5eTLI06EcuDzA08Fr3s1eGBtMZPWidS?=
 =?us-ascii?Q?GDOuc0/Ub+av9alBir+4OMXx96RIpXXQVL6rWjwOjc+7oj1whIJazejoVivq?=
 =?us-ascii?Q?Retn4Qmb1jO3B5u5E8UsHgafxdwVv4K1qEEPNrMxgXgkMCgItpbZi6iHXdoi?=
 =?us-ascii?Q?bppUpuRxlstQsPpdF2vV31+ZSbmvvP4kQbJWwQnWz/PzaLovaQ4g4VNVwyW4?=
 =?us-ascii?Q?83eLVgkw/Amp2ftkW0QPwRGEnAg+idtLGT+p2fELT5IB4h93eOZ2QTnBTkF0?=
 =?us-ascii?Q?g2l1G6DGz/6ruBQKR7RmWLOXpsWbzWKJtPicOhuCreohFEvA36a2SS1jAfDC?=
 =?us-ascii?Q?nQexL34ig8LVqwHttxuIKEte8NKnj6JDjrjUsnLgGXso9tjlryKpdarcXxG7?=
 =?us-ascii?Q?v24bcVKbRKrNQUtv1YLZ80ESjKXMOS3FFGPI7R2jiiswWcqpLKvddUSCs11n?=
 =?us-ascii?Q?jmdvODnUhhHYqvMLxi5GpdCHlsFen9cScdxUfffv1QPpYYI4ymIK8Sen/Ayz?=
 =?us-ascii?Q?7DMJhFRY3h8xPeU0iA3nO5XfhMujSxmpGc8KpTbW33Y2Zp92A4vhMaP4iRBR?=
 =?us-ascii?Q?DygaAELlGO3bDuWvLga4N+2A6D8VLFU0l5AniXofz0M8/KHKV1JKJ+7gtFwk?=
 =?us-ascii?Q?RZUM8jZ4n/H1x51ViwMzCXc7xBj/s+HZgNvDcGQFggpgvVryY90OG4vYWrAp?=
 =?us-ascii?Q?jyZQtSCclyQYjS+EuS3wOUG/mXK/LoA6MooRJ2Zcp/ZF3DD6GmOX6hQKm9xd?=
 =?us-ascii?Q?Ghaw5pakfczSBVN3EM5vq+SuZ1sX8UoTbfDz8iXCrRX72YEs75Ys1rXixwOr?=
 =?us-ascii?Q?0ybp1jzw0ZzKhKbOKJpCKocxF2eCpPh056V3zxGM5WXGsIBnthcvs7xT37gr?=
 =?us-ascii?Q?mVzPT1BifBX8k6+n67qjxZbFlepV0HJXmLcn/jBZiusfUm6aamHiUBZK24d5?=
 =?us-ascii?Q?gWaIGQuhE+cQYZyzoO6UtTzac2TskpLN0q45u2lRqnoXBBhLCLmCJ4HM6Gl1?=
 =?us-ascii?Q?4/XMTKU1oy6DkCn83Rkp9eKysXLlkwHJMYh9b1a+9z07jEk7DyPJW7U7mBO5?=
 =?us-ascii?Q?PHqyX7XLe7r/4ETpVdJgBLoZwcdqhASDADIlY9KpoI1DAFBSgnuT1BfBvI7i?=
 =?us-ascii?Q?8+34s6rjqxTX5hq8LICbljqSoQGyhR1WJJZKZ0StyweAL58PRKvR+EEOuf8n?=
 =?us-ascii?Q?enblUw+ntVIW5iRjt+UqrNZn5glQsKXuK7C2NDvabI0y9Cth+QWWJN8KiqFJ?=
 =?us-ascii?Q?VYen44TURUX6qDPQCRvMmRR/aW1uBL/hWWwKx7xgIsuZGA0K6RZKTV8oMFI6?=
 =?us-ascii?Q?RqwO2lbTmuRbwh9ATqwPL4R6diAzCW80tziQ4niNc6Oj7NLYCStEz4tDAuYT?=
 =?us-ascii?Q?qa7psvsEw7+ZRdZj8vL7X14=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF6AE862AC6.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QADqolJnfw87xIdbCnMBGPddkYhvBdx8hAMwpPtUcUJ41Xzdk79no6QYcjta?=
 =?us-ascii?Q?xlzJDH0KbhM/Eha50LgiD97oUUJOX38p4cKFyKSSU32WmzMkkP5vEOUoWDV0?=
 =?us-ascii?Q?m0wvRLEB5RoYhXUh4uDY6mQcg+0/IlXYqe/4WqnIPOXQLQMbHD0T3gYR06BL?=
 =?us-ascii?Q?aTnlRtnG7yeq6xKBhlaqVhqN3H4EVWsyCIua3b089yIu/UQ/CD/O7X7Q6CA0?=
 =?us-ascii?Q?SJGcm4Wd/5yGUV7i34YJAzgc0vVpzIDjQMCQKFjQOuLAmRU2d3bMuqVzS/X/?=
 =?us-ascii?Q?roNKVYNwB/I/xwIbBmJ+9c6/F6yen+aIW0hVGOJauGQZqOMD4DVJslTK0xTu?=
 =?us-ascii?Q?mNwja1tIfl+SEsIjQWv4Gz/GWMHq421VwNfw1yaHUympFbdayo0FWUz2bFVW?=
 =?us-ascii?Q?GicEyTfNkoYzZGC36PqfN+R2dXmEPYLUKykfW0BQuBKWtNDDGitJTx71gXSO?=
 =?us-ascii?Q?qElhVaOO5nvFKMX6aFk2vfQPJp3xEi4BVAV1tWDYRQLgetMb+C1vebRtiufV?=
 =?us-ascii?Q?6L1Q5gTs2P5KuWbsmSeldI0lV8vU+icY5ILDfu1OnbvxnYOVwyI8DEsNBisI?=
 =?us-ascii?Q?K15zLoRoygyXINxg+iaqr50r+9NPQhYczoqo3nyUN+TqSaerx0kPYX6eYLaV?=
 =?us-ascii?Q?cqsRLcJQw/zoloeCG48Ig87IdjJNz698A+afjwxP7Pegd6cQwDvlb1UlW6eU?=
 =?us-ascii?Q?IkCwChmL1gGYPix3A3f8UlN+m1DbU0Ip+OJDFQmFqFMsSAorGtbEyYgaFB3f?=
 =?us-ascii?Q?SkvbFeRSUzQ2EXGgA0sHl+yarAlNtauUhHW5nYrDVGS2PcX9ra9vU6XKuKvJ?=
 =?us-ascii?Q?n6gO5ul42dUt+GKEfT4VtQVtXQ+DHJCH20DoPKjr7UR+RKG6wNPl9Mgnd5e5?=
 =?us-ascii?Q?tElWMwAokTm/VFBJcRMWHwzt480F0AfmPW+6sgwiyabVdaUWd0exvcg96jMU?=
 =?us-ascii?Q?Fpu4o2rrpUpcJOO9lJUoMh6oxGowzBAi1GH+zM+SLQVYFa8WGVDC/os9zNMp?=
 =?us-ascii?Q?0SdgylITfbKE83RTykY+J3pQk9Toshtc9pExeR5Cdj6FZEsJRVbuXAjk27Np?=
 =?us-ascii?Q?TFm+nnVknVCqhTn1AiCP7sDclnpiSwr0y058GNI/YU4WYR5jVw/uxSCiAP9n?=
 =?us-ascii?Q?bkHs/FTitIy5H9oOH6mo9qcBfYiUKCk8OyEAtUgCeFb0N9VS8tzF+XccyNUi?=
 =?us-ascii?Q?ve+i2NaSq5nHydNPoJQj4mvok2Z5BTsGQzv6NOFp5+o73FWkX4xnqrLfqPyI?=
 =?us-ascii?Q?RXtLm8npDWjPbZxLXn2Kw+U4WMTy/+sWsc1lVaZFZGjuIvrmlG3fMUjfUOJj?=
 =?us-ascii?Q?TJk9oIEedh5yGp4Rd7zOcJhi1YxBcLQEWZaBBMdZrHC6Nqph6DLWyKBaw/cQ?=
 =?us-ascii?Q?kj1sidyPLeuzNaUNjIppgajjqeqzM1LjI8wh8SLCcJiEDdqcVroq6PCdc2F3?=
 =?us-ascii?Q?bQTGB3Xr+e/8qmvxsRAgG4YQrUA/9agAcR1EweISPff+l0J8tP0eBJWyNemu?=
 =?us-ascii?Q?VKj5wsVq1whjylVOT6iDU4X4Z32mS/CRjCo2sIvv0hPCJ4R2yiBE+vBYx7Nd?=
 =?us-ascii?Q?Qql4NzxHiYLko/VGSr7XxEppC6yaoLIHpLwmrltwtX2HN4rN3hiBfQtNySjw?=
 =?us-ascii?Q?blDWG/eiPls8uNA6Yh8n1jOcMRGxIxocoQv3mH/FHOxOyO4qQcsetIBL6aHj?=
 =?us-ascii?Q?eulvu03Nfz3EcP/Lp9B70+gmapsT01vl7Gd8mPQf4q3yVQiuYirEbs5XH656?=
 =?us-ascii?Q?HrJopOKDga6/5C5djuGWowmtyiP86SDyINa+xr5dYHTY2GoZyae4?=
Content-Type: multipart/alternative;
 boundary="_000_DM3PPF6AE862AC6A0206449E3210CDA74869798ADM3PPF6AE862AC6_"
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF6AE862AC6.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058745d8-0ba8-47f6-f533-08de63e061fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 11:27:30.0621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsRPKkZm2MtYt4W7PBTpAWQodPGilqPbL29/ffVyxCW/Jr//qrIYtmnbtj17yvmHHmizgv06z19Opq2u+GpU1nTVP5gfHXaidt5zzXJz646mpl0H1x7v8pk+Zdun5vsL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:49:44 +0100
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

--_000_DM3PPF6AE862AC6A0206449E3210CDA74869798ADM3PPF6AE862AC6_
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

--_000_DM3PPF6AE862AC6A0206449E3210CDA74869798ADM3PPF6AE862AC6_
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

--_000_DM3PPF6AE862AC6A0206449E3210CDA74869798ADM3PPF6AE862AC6_--
