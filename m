Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF1C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 14:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B7DC40144;
	Wed, 16 Jul 2025 16:42:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 36EF84013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 16:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752676935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q7zzF1kcDSb/XtfufzzJRNgBYI4KSkwJ/vgOLlvMP78=;
 b=fOdiQbN/tpm9IkSnDzxNhkGRVYdcIXiMQJgfHYPWkMPZyw+LPy+wQY4fJZsPg0hLUA+y+I
 03anUUN19glCGYP3lmppi4HbAcH90ejrnwdbVJSgBqHPcioIUcFT1bIPWWyC6pL8u/o7sW
 FYP8OIWn+zbKAQqTecvV+BC/hLD6kss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-2gAAcu5nN7GU1JZileKxlA-1; Wed,
 16 Jul 2025 10:42:14 -0400
X-MC-Unique: 2gAAcu5nN7GU1JZileKxlA-1
X-Mimecast-MFC-AGG-ID: 2gAAcu5nN7GU1JZileKxlA_1752676933
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F181800283
 for <dev@dpdk.org>; Wed, 16 Jul 2025 14:42:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89B99180045B
 for <dev@dpdk.org>; Wed, 16 Jul 2025 14:42:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH] mailmap: fix entries with many aliases
Date: Wed, 16 Jul 2025 16:41:59 +0200
Message-ID: <20250716144203.1994070-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8QVsapTkQKeQWvycZcZrSYgBH0UWnQcmyxDA9WRmfHo_1752676933
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

According to gitmailmap manual, a line is composed of a contact
information followed by commit information.

Which translates to the following formats:
Proper Name <commit@email.xx>
<proper@email.xx> <commit@email.xx>
Proper Name <proper@email.xx> <commit@email.xx>
Proper Name <proper@email.xx> Commit Name <commit@email.xx>

Some lines had multiple commit infos which were not parsed correctly by
tools. Fix this by duplicating lines as necessary.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .mailmap | 92 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..75e550e47a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -121,10 +121,12 @@ Andrzej Ostruszka <amo@semihalf.com> <aostruszka@marvell.com>
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
 Andy Gospodarek <andrew.gospodarek@broadcom.com> <gospo@broadcom.com>
 Andy Green <andy@warmcat.com>
-Andy Moreton <andy.moreton@amd.com> <amoreton@xilinx.com> <amoreton@solarflare.com>
+Andy Moreton <andy.moreton@amd.com> <amoreton@xilinx.com>
+Andy Moreton <andy.moreton@amd.com> <amoreton@solarflare.com>
 Andy Pei <andy.pei@intel.com>
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
-Ankur Dwivedi <adwivedi@marvell.com> <ankur.dwivedi@caviumnetworks.com> <ankur.dwivedi@cavium.com>
+Ankur Dwivedi <adwivedi@marvell.com> <ankur.dwivedi@caviumnetworks.com>
+Ankur Dwivedi <adwivedi@marvell.com> <ankur.dwivedi@cavium.com>
 Anna Lukin <annal@silicom.co.il>
 Anoob Joseph <anoobj@marvell.com> <anoob.joseph@caviumnetworks.com>
 Antara Ganesh Kolar <antara.ganesh.kolar@intel.com>
@@ -151,7 +153,8 @@ Artur Tyminski <arturx.tyminski@intel.com>
 Asaf Penso <asafp@nvidia.com> <asafp@mellanox.com>
 Asaf Ravid <aravid@marvell.com>
 Ashijeet Acharya <ashijeet.acharya@6wind.com>
-Ashish Gupta <ashishg@marvell.com> <ashish.gupta@marvell.com> <ashish.gupta@caviumnetworks.com>
+Ashish Gupta <ashishg@marvell.com> <ashish.gupta@marvell.com>
+Ashish Gupta <ashishg@marvell.com> <ashish.gupta@caviumnetworks.com>
 Ashish Jain <ashish.jain@nxp.com>
 Ashish Paul <apaul@juniper.net>
 Ashish Sadanandan <ashish.sadanandan@gmail.com>
@@ -195,7 +198,8 @@ Bill Hong <bhong@brocade.com>
 Bill Xiang <xiangwencheng@dayudpu.com>
 Billy McFall <bmcfall@redhat.com>
 Billy O'Mahony <billy.o.mahony@intel.com>
-Bing Zhao <bingz@nvidia.com> <bingz@mellanox.com> <bing.zhao@hxt-semitech.com>
+Bing Zhao <bingz@nvidia.com> <bingz@mellanox.com>
+Bing Zhao <bingz@nvidia.com> <bing.zhao@hxt-semitech.com>
 Bin Huang <brian.huangbin@huawei.com> <bin.huang@hxt-semitech.com>
 Bin Zheng <zhengbin.89740@bytedance.com>
 Bingbin Chen <chen.bingbin@zte.com.cn>
@@ -219,7 +223,9 @@ Brick Yang <brick.yang@nxp.com>
 Bruce Allan <bruce.w.allan@intel.com>
 Bruce Liu <2103458176@qq.com>
 Bruce Merry <bmerry@sarao.ac.za>
-Bruce Richardson <bruce.richardson@intel.com> <bruce.ricahrdson@intel.com> <bruce.richarsdon@intel.com> <bruce.ruchardson@intel.com>
+Bruce Richardson <bruce.richardson@intel.com> <bruce.ricahrdson@intel.com>
+Bruce Richardson <bruce.richardson@intel.com> <bruce.richarsdon@intel.com>
+Bruce Richardson <bruce.richardson@intel.com> <bruce.ruchardson@intel.com>
 Bryan Benson <bmbenson@amazon.com>
 Byron Marohn <byron.marohn@intel.com>
 Carolyn Wyborny <carolyn.wyborny@intel.com>
@@ -236,7 +242,8 @@ Chao Zhu <chaozhu@linux.vnet.ibm.com> <bjzhuc@cn.ibm.com>
 Charles Brett <cfb@hpe.com>
 Charles Myers <charles.myers@spirent.com>
 Charles Stoll <charles.stoll@intel.com>
-Chas Williams <3chas3@gmail.com> <chas3@att.com> <ciwillia@brocade.com>
+Chas Williams <3chas3@gmail.com> <chas3@att.com>
+Chas Williams <3chas3@gmail.com> <ciwillia@brocade.com>
 Chenbo Xia <chenbox@nvidia.com> <chenbo.xia@intel.com>
 Chengchang Tang <tangchengchang@huawei.com> <tangchengchang@hisilicon.com>
 Chengfeng Ye <cyeaa@connect.ust.hk>
@@ -323,7 +330,8 @@ Dave Ertman <david.m.ertman@intel.com>
 Dave Johnson <davejo@cisco.com>
 David Binderman <dcb314@hotmail.com>
 David Bouyeure <david.bouyeure@fraudbuster.mobi>
-David Christensen <drc@linux.ibm.com> <drc@linux.vnet.ibm.com> <david.christensen@broadcom.com>
+David Christensen <drc@linux.ibm.com> <drc@linux.vnet.ibm.com>
+David Christensen <drc@linux.ibm.com> <david.christensen@broadcom.com>
 David Coyle <david.coyle@intel.com>
 Davide Caratti <dcaratti@redhat.com>
 David George <david.george@sophos.com>
@@ -441,7 +449,9 @@ Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
 Fengtian Guo <fengtian.guo@6wind.com>
 Ferdinand Thiessen <rpm@fthiessen.de>
-Ferruh Yigit <ferruh.yigit@amd.com> <ferruh.yigit@intel.com> <ferruh.yigit@xilinx.com> <ferruhy@gmail.com>
+Ferruh Yigit <ferruh.yigit@amd.com> <ferruh.yigit@intel.com>
+Ferruh Yigit <ferruh.yigit@amd.com> <ferruh.yigit@xilinx.com>
+Ferruh Yigit <ferruh.yigit@amd.com> <ferruhy@gmail.com>
 Fidaullah Noonari <fidaullah.noonari@emumba.com>
 Fidel Castro <fidelcastro.s@hotmail.com>
 Fiona Trahe <fiona.trahe@intel.com>
@@ -476,7 +486,8 @@ Gargi Sau <gargi.sau@intel.com>
 Gary Mussar <gmussar@ciena.com>
 Gaurav Singh <gaurav1086@gmail.com>
 Gautam Dawar <gdawar@solarflare.com>
-Gavin Hu <gahu@nvidia.com> <gavin.hu@arm.com> <gavin.hu@linaro.org>
+Gavin Hu <gahu@nvidia.com> <gavin.hu@arm.com>
+Gavin Hu <gahu@nvidia.com> <gavin.hu@linaro.org>
 Gavin Li <gavinl@nvidia.com>
 Geoffrey Le Gourriérec <geoffrey.le_gourrierec@6wind.com>
 Geoffrey Lv <geoffrey.lv@gmail.com>
@@ -496,7 +507,8 @@ Gordon Noonan <gordon.noonan@intel.com>
 Gosia Bakota <gosia.bakota@intel.com>
 Govindarajulu Varadarajan <gvaradar@cisco.com>
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com> <gowrishankar.m@linux.vnet.ibm.com>
-Gregory Etelson <getelson@nvidia.com> <getelson@mellanox.com> <gregory@weka.io>
+Gregory Etelson <getelson@nvidia.com> <getelson@mellanox.com>
+Gregory Etelson <getelson@nvidia.com> <gregory@weka.io>
 Greg Tucker <greg.b.tucker@intel.com>
 Grishma Kotecha <grishma.kotecha@intel.com>
 Grzegorz Galkowski <grzegorz.galkowski@intel.com>
@@ -632,7 +644,8 @@ Jakub Buchocki <jakubx.buchocki@intel.com>
 Jakub Chylkowski <jakubx.chylkowski@intel.com>
 Jakub Grajciar <jgrajcia@cisco.com>
 Jakub Neruda <neruda@netcope.com>
-Jakub Palider <jpalider@marvell.com> <jpa@semihalf.com> <jpalider@gmail.com>
+Jakub Palider <jpalider@marvell.com> <jpa@semihalf.com>
+Jakub Palider <jpalider@marvell.com> <jpalider@gmail.com>
 Jakub Poczatek <jakub.poczatek@intel.com>
 Jakub Wysocki <jakubx.wysocki@intel.com>
 James Davidson <james.davidson@brocade.com>
@@ -676,7 +689,8 @@ Jeff Shaw <jeffrey.b.shaw@intel.com>
 Jens Freimann <jfreimann@redhat.com> <jfreiman@redhat.com>
 Jeremy Plsek <jplsek@iol.unh.edu>
 Jeremy Spewock <jspewock@iol.unh.edu>
-Jerin Jacob <jerinj@marvell.com> <jerin.jacob@caviumnetworks.com> <jerinjacobk@gmail.com>
+Jerin Jacob <jerinj@marvell.com> <jerin.jacob@caviumnetworks.com>
+Jerin Jacob <jerinj@marvell.com> <jerinjacobk@gmail.com>
 Jeroen de Borst <jeroendb@google.com>
 Jerome Jutteau <jerome.jutteau@outscale.com>
 Jerry Hao OS <jerryhao@os.amperecomputing.com>
@@ -744,7 +758,8 @@ John Ousterhout <ouster@cs.stanford.edu>
 John Romein <romein@astron.nl>
 John W. Linville <linville@tuxdriver.com>
 Jonas Pfefferle <jpf@zurich.ibm.com> <pepperjo@japf.ch>
-Jonathan Erb <jonathan.erb@threater.com> <jonathan.erb@threatblockr.com> <jonathan.erb@banduracyber.com>
+Jonathan Erb <jonathan.erb@threater.com> <jonathan.erb@threatblockr.com>
+Jonathan Erb <jonathan.erb@threater.com> <jonathan.erb@banduracyber.com>
 Jonathan Tsai <jonathan1.tsai@intel.com>
 Jon DeVree <nuxi@vault24.org>
 Jon Loeliger <jdl@netgate.com>
@@ -821,14 +836,16 @@ Ke Zhang <ke1x.zhang@intel.com>
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
-Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com> <kiran.kokkilagadda@caviumnetworks.com>
+Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com>
+Kiran Kumar K <kirankumark@marvell.com> <kiran.kokkilagadda@caviumnetworks.com>
 Kiran Patil <kiran.patil@intel.com>
 Kiran Vedere <kiranv@nvidia.com>
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
 Klaus Degner <kd@allegro-packets.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
-Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru> <konstantin.ananyev@intel.com>
+Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
+Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
 Krishna Murthy <krishna.j.murthy@intel.com>
 Krzysztof Galazka <krzysztof.galazka@intel.com>
 Krzysztof Kanas <kkanas@marvell.com> <krzysztof.kanas@caviumnetworks.com>
@@ -861,7 +878,8 @@ Lev Faerman <lev.faerman@intel.com>
 Lewei Yang <leweix.yang@intel.com>
 Lewis Donzis <lew@perftech.com>
 Leyi Rong <leyi.rong@intel.com>
-Liang Ma <liangma@bytedance.com> <liangma@liangbit.com> <liang.j.ma@intel.com>
+Liang Ma <liangma@bytedance.com> <liangma@liangbit.com>
+Liang Ma <liangma@bytedance.com> <liang.j.ma@intel.com>
 Liang-Min Larry Wang <liang-min.wang@intel.com>
 Liangxing Wang <liangxing.wang@arm.com>
 Liang Xu <liang.xu@cinfotech.cn>
@@ -891,7 +909,10 @@ Lotem Leder <lotem.leder@intel.com>
 Louise Kilheeney <louise.kilheeney@intel.com>
 Louis Luo <llouis@vmware.com>
 Louis Peens <louis.peens@corigine.com> <louis.peens@netronome.com>
-Luca Boccassi <luca.boccassi@microsoft.com> <bluca@debian.org> <luca.boccassi@gmail.com> <lboccass@brocade.com> <luca.boccassi@intl.att.com>
+Luca Boccassi <luca.boccassi@microsoft.com> <bluca@debian.org>
+Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@gmail.com>
+Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
+Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
 Luc Pelletier <lucp.at.work@gmail.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
@@ -1093,7 +1114,8 @@ Nan Chen <whutchennan@gmail.com>
 Nandini Persad <nandinipersad361@gmail.com>
 Nannan Lu <nannan.lu@intel.com>
 Nan Zhou <zhounan14@huawei.com>
-Narcisa Vasile <navasile@linux.microsoft.com> <navasile@microsoft.com> <narcisa.vasile@microsoft.com>
+Narcisa Vasile <navasile@linux.microsoft.com> <navasile@microsoft.com>
+Narcisa Vasile <navasile@linux.microsoft.com> <narcisa.vasile@microsoft.com>
 Narender Vangati <narender.vangati@intel.com>
 Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
 Natalie Samsonov <nsamsono@marvell.com>
@@ -1167,7 +1189,8 @@ Padraig Connolly <padraig.j.connolly@intel.com>
 Pallantla Poornima <pallantlax.poornima@intel.com>
 Pallavi Kadam <pallavi.kadam@intel.com>
 Pandi Kumar Maharajan <pandi.maharajan@intel.com>
-Pankaj Gupta <pankaj.gupta@broadcom.com> <pagupta@vmware.com> <pagupta@redhat.com>
+Pankaj Gupta <pankaj.gupta@broadcom.com> <pagupta@vmware.com>
+Pankaj Gupta <pankaj.gupta@broadcom.com> <pagupta@redhat.com>
 Panu Matilainen <pmatilai@redhat.com>
 Paolo Valerio <pvalerio@redhat.com>
 Parav Pandit <parav@nvidia.com> <parav@mellanox.com>
@@ -1201,7 +1224,8 @@ Pawel Malinowski <pawel.malinowski@intel.com>
 Pawel Modrak <pawelx.modrak@intel.com>
 Pawel Rutkowski <pawelx.rutkowski@intel.com>
 Pawel Sobczyk <pawel.sobczyk@intel.com>
-Pawel Wodkowski <pawelwod@gmail.com> <pawelx.wodkowski@intel.com> <pawelx.wdkowski@intel.com>
+Pawel Wodkowski <pawelwod@gmail.com> <pawelx.wodkowski@intel.com>
+Pawel Wodkowski <pawelwod@gmail.com> <pawelx.wdkowski@intel.com>
 Pei Chao <peichao85@gmail.com>
 Pei Zhang <pezhang@redhat.com>
 Pengfei Sun <sunpengfei16@huawei.com>
@@ -1282,13 +1306,16 @@ Rajesh Mudimadugula <rmudimadugul@marvell.com>
 Rajesh Ravi <rajesh.ravi@broadcom.com>
 Rakesh Kudurumalla <rkudurumalla@marvell.com> <rkudurumalla@caviumnetworks.com>
 Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
-Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com> <roszenrami@gmail.com>
+Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
+Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
 Randy Schacher <stuart.schacher@broadcom.com>
 Rani Sharoni <ranish@nvidia.com>
 Ranjit Menon <ranjit.menon@intel.com>
-Rasesh Mody <rmody@marvell.com> <rasesh.mody@cavium.com> <rasesh.mody@qlogic.com>
+Rasesh Mody <rmody@marvell.com> <rasesh.mody@cavium.com>
+Rasesh Mody <rmody@marvell.com> <rasesh.mody@qlogic.com>
 Rashmi Shetty <rashmi.shetty@intel.com>
-Raslan Darawsheh <rasland@nvidia.com> <rasland@mellanox.com> <rdarawsheh@asaltech.com>
+Raslan Darawsheh <rasland@nvidia.com> <rasland@mellanox.com>
+Raslan Darawsheh <rasland@nvidia.com> <rdarawsheh@asaltech.com>
 Rastislav Cernay <cernay@netcope.com>
 Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
 Ravi Kerur <rkerur@brocade.com> <rkerur@gmail.com>
@@ -1309,14 +1336,16 @@ Ricardo Salveti <ricardo.salveti@linaro.org>
 Richael Zhuang <richael.zhuang@arm.com>
 Richard Donkin <richard.donkin@corigine.com>
 Richard Eklycke <richard.eklycke@ericsson.com>
-Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsw@xilinx.com> <rhouldsworth@solarflare.com>
+Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsw@xilinx.com>
+Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsworth@solarflare.com>
 Richard Walsh <richard.walsh@intel.com>
 Rich Lane <rich.lane@bigswitch.com>
 Ricky Li <ricky.li@intel.com>
 R Mohamed Shah <mohamedshah.r@amd.com>
 Robert Konklewski <robertx.konklewski@intel.com>
 Robert Malz <robertx.malz@intel.com>
-Robert Sanford <rsanford@akamai.com> <rsanford2@gmail.com> <rsanford@prolexic.com>
+Robert Sanford <rsanford@akamai.com> <rsanford2@gmail.com>
+Robert Sanford <rsanford@akamai.com> <rsanford@prolexic.com>
 Robert Shearman <rshearma@brocade.com>
 Robert Stonehouse <rstonehouse@solarflare.com>
 Robin Jarry <rjarry@redhat.com> <robin.jarry@6wind.com>
@@ -1498,7 +1527,9 @@ Stefan Wegrzyn <stefan.wegrzyn@intel.com>
 Stepan Sojka <stepan.sojka@adaptivemobile.com>
 Stephen Coleman <omegacoleman@gmail.com>
 Stephen Douthit <stephend@silicom-usa.com>
-Stephen Hemminger <stephen@networkplumber.org> <sthemmin@microsoft.com> <shemming@brocade.com> <shemminger@vyatta.com>
+Stephen Hemminger <stephen@networkplumber.org> <sthemmin@microsoft.com>
+Stephen Hemminger <stephen@networkplumber.org> <shemming@brocade.com>
+Stephen Hemminger <stephen@networkplumber.org> <shemminger@vyatta.com>
 Stephen Hurd <stephen.hurd@broadcom.com> <shurd@broadcom.com>
 Steve Capper <steve.capper@arm.com>
 Steven Lariau <steven.lariau@arm.com>
@@ -1509,7 +1540,8 @@ Steve Rempe <steve.rempe@broadcom.com>
 Steve Shin <jonshin@cisco.com>
 Steve Yang <stevex.yang@intel.com>
 Stewart Allen <allenste@amazon.com>
-Suanming Mou <suanmingm@nvidia.com> <suanmingm@mellanox.com> <mousuanming@huawei.com>
+Suanming Mou <suanmingm@nvidia.com> <suanmingm@mellanox.com>
+Suanming Mou <suanmingm@nvidia.com> <mousuanming@huawei.com>
 Subendu Santra <subendu@arista.com>
 Subhi Masri <subhim@nvidia.com>
 Subrahmanyam Nilla <snilla@marvell.com> <snilla@caviumnetworks.com>
@@ -1518,7 +1550,8 @@ Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
 Sujith Sankar <ssujith@cisco.com>
 Sunila Sahu <ssahu@marvell.com> <sunila.sahu@caviumnetworks.com>
 Sunil Kulkarni <sunil.kulkarni@caviumnetworks.com>
-Sunil Kumar Kori <skori@marvell.com> <skori@mavell.com> <sunil.kori@nxp.com>
+Sunil Kumar Kori <skori@marvell.com> <skori@mavell.com>
+Sunil Kumar Kori <skori@marvell.com> <sunil.kori@nxp.com>
 Sunil Pai G <sunil.pai.g@intel.com>
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
 Sun Jiajia <sunx.jiajia@intel.com>
@@ -1860,4 +1893,5 @@ Ziyang Xuan <xuanziyang2@huawei.com>
 Ziye Yang <ziye.yang@intel.com>
 Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
-Zyta Szpak <zyta@marvell.com> <zr@semihalf.com> <zyta.szpak@semihalf.com>
+Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
+Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
-- 
2.50.0

