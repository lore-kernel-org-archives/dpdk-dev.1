Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F76C5DF81
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 18:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC05D40289;
	Sun, 23 Aug 2026 20:47:19 +0200 (CEST)
Received: from a27-99.smtp-out.us-west-2.amazonses.com
 (a27-99.smtp-out.us-west-2.amazonses.com [54.240.27.99])
 by mails.dpdk.org (Postfix) with ESMTP id 4FEF940269
 for <dev@dpdk.org>; Sun, 23 Aug 2026 20:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1787510836;
 h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
 bh=kPNYjvaEOTmtUxhdIZOfTHZgNOrm8rxr1jVXNJSyt/w=;
 b=Tk5GN5VVQQetN2QtXh5TtwfcY+ndAZRdDtBTxixcoSJn0iMPQEumXLNqgAiv9WxN
 dfjuBut4RwErx+VS/7QfDiSCnTke5Nm6RI+Z73D44slEln+6AAe6ny+ioHdmPA4bjBT
 irC9GxhR5XyGrFfk53vslrSLXGF7/X8uLPpR3pFc=
Subject: [PATCH 2/2] net/atlantic: fix Tx cleanup descriptor read race
From: =?UTF-8?Q?mike?= <mike@sugarmillgang.com>
To: =?UTF-8?Q?irusskikh=40marvell=2Ecom?= <irusskikh@marvell.com>
Cc: =?UTF-8?Q?dev=40dpdk=2Eorg?= <dev@dpdk.org>, 
 =?UTF-8?Q?mike?= <mike@sugarmillgang.com>, 
 =?UTF-8?Q?pavel=2Ebelous=40aquantia=2Ecom?= <pavel.belous@aquantia.com>
Date: Sun, 23 Aug 2026 18:47:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260823184643.7105-1-mike@sugarmillgang.com>
References: <20260823184643.7105-1-mike@sugarmillgang.com> 
 <20260823184643.7105-2-mike@sugarmillgang.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHdMy/N3JyS9DHyT1yh7sBbwJMVnQAAAP//
Thread-Topic: [PATCH 2/2] net/atlantic: fix Tx cleanup descriptor read race
X-Original-Mailer: git-send-email 2.34.1
X-Wm-Sent-Timestamp: 1787510835
Message-ID: <010101a02ff2ce57-509d6017-e6b8-40e5-872e-a6f25380bb08-000000@us-west-2.amazonses.com>
Feedback-ID: ::1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
X-SES-Outgoing: 2026.08.23-54.240.27.99
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

atl_xmit_cleanup() scans hw_ring descriptors for a set dd bit to=0D=0Akno=
w how many are safe to reclaim, reading dd straight from=0D=0ADMA-coheren=
t memory the NIC concurrently writes, with no barrier.=0D=0A=0D=0AA torn =
or stale read here can make the scan believe nothing is=0D=0Adone when de=
scriptors have genuinely completed, so to_clean comes=0D=0Aback 0 and cle=
anup is skipped. Since atl_xmit_pkts() only refuses=0D=0Ato send when tx_=
free is too low, and only cleanup ever grows=0D=0Atx_free back, a missed =
cleanup pass can leave tx_free permanently=0D=0Ashort: every later send c=
all sees insufficient free descriptors=0D=0Aand transmits nothing, indefi=
nitely, with no way to recover.=0D=0A=0D=0AAdd a read barrier once the sc=
an's dd checks are complete and=0D=0Abefore acting on to_clean.=0D=0A=0D=0A=
Fixes: 2b1472d7150c ("net/atlantic: implement Tx path")=0D=0ACc: pavel.be=
lous@aquantia.com=0D=0A=0D=0ASigned-off-by: Mike Murphy <mike@sugarmillga=
ng.com>=0D=0A---=0D=0A drivers/net/atlantic/atl_rxtx.c | 6 ++++++=0D=0A 1=
 file changed, 6 insertions(+)=0D=0A=0D=0Adiff --git a/drivers/net/atlant=
ic/atl_rxtx.c b/drivers/net/atlantic/atl_rxtx.c=0D=0Aindex 2d551a341f..34=
f53cd6cc 100644=0D=0A--- a/drivers/net/atlantic/atl_rxtx.c=0D=0A+++ b/dri=
vers/net/atlantic/atl_rxtx.c=0D=0A@@ -1162,6 +1162,12 @@ atl_xmit_cleanup=
(struct atl_tx_queue *txq)=0D=0A =09=09=09=09break;=0D=0A =09=09}=0D=0A=20=
=0D=0A+=09=09/*=0D=0A+=09=09 * Same dd/DMA race as the Rx path; barrier b=
efore=0D=0A+=09=09 * acting on what was just read.=0D=0A+=09=09 */=0D=0A+=
=09=09rte_rmb();=0D=0A+=0D=0A =09=09if (to_clean =3D=3D 0)=0D=0A =09=09=09=
return;=0D=0A=20=0D=0A--=20=0D=0A2.34.1=0D=0A=0D=0A
