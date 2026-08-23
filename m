Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BCC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 18:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B565A40270;
	Sun, 23 Aug 2026 20:47:13 +0200 (CEST)
Received: from a27-114.smtp-out.us-west-2.amazonses.com
 (a27-114.smtp-out.us-west-2.amazonses.com [54.240.27.114])
 by mails.dpdk.org (Postfix) with ESMTP id 4BD3640269
 for <dev@dpdk.org>; Sun, 23 Aug 2026 20:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1787510830;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
 bh=Bt2YEUF8eLbWE2Ca79p7mBvQxHJDVDhEBUQ//Vyd1Vo=;
 b=V+9PSmC5/HIYqDuNdPzyBwYauYJGxCn/G14H8w7/ZYuPopJXGOUIrhIxpOB1XPiP
 xM/6VUt/6bR54qIi7TqrU0zhSCYT1unU4+D0pAf3jHVZ5Tn/canYx7N5VPwE2gkJsYR
 8/eusM+3n6JOJjUb6ilRZhA7TyjBmiFCMD/KX02o=
Subject: [PATCH 1/2] net/atlantic: fix Rx descriptor completion race
From: =?UTF-8?Q?mike?= <mike@sugarmillgang.com>
To: =?UTF-8?Q?irusskikh=40marvell=2Ecom?= <irusskikh@marvell.com>
Cc: =?UTF-8?Q?dev=40dpdk=2Eorg?= <dev@dpdk.org>, 
 =?UTF-8?Q?mike?= <mike@sugarmillgang.com>, 
 =?UTF-8?Q?igor=2Erusskikh=40aquantia=2Ecom?= <igor.russkikh@aquantia.com>
Date: Sun, 23 Aug 2026 18:47:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20260823184643.7105-1-mike@sugarmillgang.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHdMy/N3JyS9DHyT1yh7sBbwJMVnQ==
Thread-Topic: [PATCH 1/2] net/atlantic: fix Rx descriptor completion race
X-Original-Mailer: git-send-email 2.34.1
X-Wm-Sent-Timestamp: 1787510829
Message-ID: <010101a02ff2b5c6-82eeeb09-69ff-4e01-8931-1303ca172c6a-000000@us-west-2.amazonses.com>
Feedback-ID: ::1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
X-SES-Outgoing: 2026.08.23-54.240.27.114
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

atl_recv_pkts() read a write-back descriptor's dd/eop/pkt_len=0D=0Afields=
 via a plain struct copy from DMA-coherent memory, with no=0D=0Abarrier a=
gainst the NIC's concurrent DMA write. This allowed a=0D=0Atorn read: dd =
could pass its "done" check while the rest of the=0D=0Asame descriptor st=
ill held stale or partially-written data.=0D=0A=0D=0AThe multi-segment wa=
lk compounded this: once inside a scatter=0D=0Achain it advanced through =
ring descriptors checking only eop,=0D=0Anever rechecking dd on each new =
descriptor. A torn or genuinely=0D=0Anot-yet-posted continuation descript=
or was then consumed as if=0D=0Avalid, letting the loop run away through =
stale ring memory -=0D=0Aobserved consuming thousands of descriptors for =
what should have=0D=0Abeen a handful of packets, well past the ring's own=
 wraparound=0D=0Apoint, while receiving jumbo (scatter) frames.=0D=0A=0D=0A=
Add a read barrier once dd is observed set, and recheck dd on=0D=0Aeach d=
escriptor the scatter walk advances to, stopping cleanly=0D=0Ainstead of =
trusting an unfinished descriptor's contents.=0D=0A=0D=0AFixes: 3d38e3dcf=
197 ("net/atlantic: implement Rx path")=0D=0ACc: igor.russkikh@aquantia.c=
om=0D=0A=0D=0ASigned-off-by: Mike Murphy <mike@sugarmillgang.com>=0D=0A--=
-=0D=0A drivers/net/atlantic/atl_rxtx.c | 22 ++++++++++++++++++++++=0D=0A=
 1 file changed, 22 insertions(+)=0D=0A=0D=0Adiff --git a/drivers/net/atl=
antic/atl_rxtx.c b/drivers/net/atlantic/atl_rxtx.c=0D=0Aindex 7b7bf5abbc.=
=2E2d551a341f 100644=0D=0A--- a/drivers/net/atlantic/atl_rxtx.c=0D=0A+++ =
b/drivers/net/atlantic/atl_rxtx.c=0D=0A@@ -941,6 +941,12 @@ atl_recv_pkts=
(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)=0D=0A =09=09=
=09break;=0D=0A =09=09}=0D=0A=20=0D=0A+=09=09/*=0D=0A+=09=09 * Barrier be=
fore reading the rest of the write-back=0D=0A+=09=09 * descriptor, so it =
can't be torn against the NIC's DMA.=0D=0A+=09=09 */=0D=0A+=09=09rte_rmb(=
);=0D=0A+=0D=0A =09=09PMD_RX_LOG(DEBUG, "port_id=3D%u queue_id=3D%u tail=3D=
%u "=0D=0A =09=09=09   "eop=3D0x%x pkt_len=3D%u hash=3D0x%x hash_type=3D0=
x%x",=0D=0A =09=09=09   (unsigned int)rxq->port_id,=0D=0A@@ -1068,6 +1074=
,22 @@ atl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t =
nb_pkts)=0D=0A =09=09=09=09break;=0D=0A =09=09=09rxd =3D (struct hw_atl_r=
xd_s *)&rxq->hw_ring[tail];=0D=0A =09=09=09rxd_wb =3D *(struct hw_atl_rxd=
_wb_s *)rxd;=0D=0A+=0D=0A+=09=09=09/*=0D=0A+=09=09=09 * dd was only check=
ed on the eop descriptor found=0D=0A+=09=09=09 * by the search above, not=
 on this one - stop rather=0D=0A+=09=09=09 * than trust an unfinished des=
criptor's stale data.=0D=0A+=09=09=09 */=0D=0A+=09=09=09if (!rxd_wb.dd) {=
=0D=0A+=09=09=09=09PMD_RX_LOG(DEBUG,=0D=0A+=09=09=09=09   "port_id=3D%u q=
ueue_id=3D%u tail=3D%u: "=0D=0A+=09=09=09=09   "continuation desc not dd =
yet",=0D=0A+=09=09=09=09   (unsigned int)rxq->port_id,=0D=0A+=09=09=09=09=
   (unsigned int)rxq->queue_id,=0D=0A+=09=09=09=09   (unsigned int)tail);=
=0D=0A+=09=09=09=09goto err_stop;=0D=0A+=09=09=09}=0D=0A+=09=09=09rte_rmb=
();=0D=0A =09=09};=0D=0A=20=0D=0A =09=09/*=0D=0A--=20=0D=0A2.34.1=0D=0A=0D=
=0A
