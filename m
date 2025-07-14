Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF615C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 20:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E88A24021E;
	Mon, 14 Jul 2025 22:45:21 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 991BE4013F
 for <dev@dpdk.org>; Mon, 14 Jul 2025 22:45:20 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-6faf66905baso60810846d6.2
 for <dev@dpdk.org>; Mon, 14 Jul 2025 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752525920;
 x=1753130720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wghohv4LOiz7VJ60RUrEEHKGzWnournSNkWkBXBJZpM=;
 b=zmtme+i0aLBopTbaZu0HUUw6V37eofeVLBIGh5EZRb/u0sM2pts0jIgsLMJshI36LN
 PuFWkOXDNJTibBrFmevJ9BrqG1B7Tj4XOzaUjIFqLzLAptqi/HkLmlx/t51C3eIrKW1D
 UB63S2HPdiVxCDSeAFJMOJH+d3ABitXTxM4NtCeybkZOkd5hILOdZJNlQFaRvoL04Esv
 kNrGWjCxoC26UfM1HEDH83Dxpq82ahS4+fgg7dTiDXYV7FpmpEIOGzABiMxkazAM/OW7
 E/8vFLy85Dl1JEPlZRAnDbtxHLEskf4njCxw9jHqaIoiuXPiDcbVmvv1Kvll/RPpB4on
 YLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752525920; x=1753130720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wghohv4LOiz7VJ60RUrEEHKGzWnournSNkWkBXBJZpM=;
 b=XP2UdeVd/kPmItdycw22W9bLmASrVzD7oem0OsLucSD8NinaPXHPjLiwni9z9iHDOt
 VfUst5/LcvQYNUnhx3Dmy4N0kihvZsedzRTjLc8IOQ8ci3L4sdrnQWQkSg3NLoKBmdRg
 Avv4Y+9zb0rj6q2DDDqBg17f0aHRdH794JyRAeZKWvmIFH8LBDt0PaOcsXmlTDMRaL0Z
 MOiUh0cP+baxaSpMf8mFO6etjgwLeFV3Ju0ky9KEb0f8M6Ba61YPIyLkbKnLzK4HjDQR
 EiTnh2jkUFnmKLgcCekkubgbUL+6NdDITx3mV5SazLrgwmpwJ48EcUA/il2p6dU9ymXo
 5wAA==
X-Gm-Message-State: AOJu0YwSkopnY1jp1ACG31nbqJNKL2Qf8VMYk9xRwXoUyQqg6Rv9VgIS
 Dqtuv7YCDpDA80HqcjFaR1HNELYlL/bGxGivgMMeSlhcxLGvyJtlBcMNVUtWr1lp/44UYrgzGRv
 FwN+1
X-Gm-Gg: ASbGnctp/ln9mmNo97s05HSz3o7zUFWs+ZR7q0U75P2YVdy6/hNLfFQdWQ2833rCLxc
 JTawW96dfNju92DDFyj+pBWlVMnpccCfk/1yFIX7Qlz/Mtj78sI9SqlDOn//fFWn5LWr9VpQYdi
 bL9eq4NAGNl65tu/BrdYzCdy5bvQkeNRCyDzDhXG/3VpHLhWqqw40BROuaZMfsvFKJQV9+aeKCD
 XU7gK9FEeh5hPtqpw4vKEBle+aWqN98oKD4xjeEl/UVxWoGQM276cOWPwaZeL23gTHP/7vR7B9F
 g4V3e6wDloS85yu8/Rev8SJxLNenQpVf3QfrTW/i93gf8GkogYT2DJp/I4Zyd5lBJ+GD+JqB/Va
 /RVPEQmD3SZVaT0gULhuF02DQG3gSmBNtYdWYJaugcdoKNUDGKDxID4eXuQyZMn95qTd4nW2c3C
 QOPhFxzjI=
X-Google-Smtp-Source: AGHT+IEGXbbF6+x6sE0/W2Ckzw+z6LnfpCBcmjONuae76mng5C+0T/HXkpdpNRZXEjh9XGAyV9YVuQ==
X-Received: by 2002:a05:6214:3909:b0:6fc:ff18:87c1 with SMTP id
 6a1803df08f44-704a401ec46mr226724476d6.2.1752525919542; 
 Mon, 14 Jul 2025 13:45:19 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcdc2ee084sm547891685a.46.2025.07.14.13.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 13:45:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] mailmap: sort entries
Date: Mon, 14 Jul 2025 13:45:14 -0700
Message-ID: <20250714204516.255880-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
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

The lines in .mailmap are supposed to be sorted, they have
gotten out of order over time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .mailmap | 70 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..0be4d883c9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -48,7 +48,6 @@ Aleksey Baulin <aleksey.baulin@gmail.com>
 Aleksey Katargin <gureedo@gmail.com>
 Ales Musil <amusil@redhat.com>
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
-Alex Chapman <alex.chapman@arm.com>
 Alexander Bechikov <asb.tyum@gmail.com>
 Alexander Belyakov <abelyako@gmail.com>
 Alexander Chernavin <achernavin@netgate.com>
@@ -59,6 +58,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
 Alexander Solganik <solganik@gmail.com>
 Alexander V Gutkin <alexander.v.gutkin@intel.com>
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>
+Alex Chapman <alex.chapman@arm.com>
 Alexey Kardashevskiy <aik@ozlabs.ru>
 Alex Kiselev <alex@bisonrouter.com> <alex@therouter.net>
 Alex Marginean <alexandru.marginean@nxp.com>
@@ -83,8 +83,8 @@ Aman Singh <aman.deep.singh@intel.com>
 Amaranath Somalapuram <asomalap@amd.com>
 Amine Kherbouche <amine.kherbouche@6wind.com>
 Amin Tootoonchian <amint@icsi.berkeley.edu>
-Ami Sabo <amis@radware.com>
 Amir Avivi <amir.avivi@intel.com>
+Ami Sabo <amis@radware.com>
 Amit Bernstein <amitbern@amazon.com>
 Amit Gupta <agupta3@marvell.com>
 Amit Prakash Shukla <amitprakashs@marvell.com>
@@ -100,9 +100,9 @@ Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
 Anatoly Burakov <anatoly.burakov@intel.com>
 Anbarasan Murugesan <anbarasanx.murugesan@intel.com>
 Anders Roxell <anders.roxell@linaro.org>
-Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
+Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andre Richter <andre.o.richter@gmail.com>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
@@ -131,8 +131,8 @@ Antara Ganesh Kolar <antara.ganesh.kolar@intel.com>
 Anthony Fee <anthonyx.fee@intel.com>
 Anthony Harivel <aharivel@redhat.com>
 Antonio Fischetti <antonio.fischetti@intel.com>
-Anup Prabhu <aprabhu@marvell.com>
 Anupam Kapoor <anupam.kapoor@gmail.com>
+Anup Prabhu <aprabhu@marvell.com>
 Apeksha Gupta <apeksha.gupta@nxp.com>
 Archana Muniganti <marchana@marvell.com> <muniganti.archana@caviumnetworks.com>
 Archit Pandey <architpandeynitk@gmail.com>
@@ -143,8 +143,8 @@ Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
 Arnon Warshavsky <arnon@qwilt.com>
 Arshdeep Kaur <arshdeep.kaur@intel.com>
 Artemii Morozov <artemii.morozov@arknetworks.am>
-Artemy Kovalyov <artemyko@nvidia.com>
 Artem V. Andreev <artem.andreev@oktetlabs.ru>
+Artemy Kovalyov <artemyko@nvidia.com>
 Artur Rojek <ar@semihalf.com>
 Artur Trybula <arturx.trybula@intel.com>
 Artur Tyminski <arturx.tyminski@intel.com>
@@ -168,9 +168,9 @@ Balasubramanian Manoharan <balasubramanian.manoharan@caviumnetworks.com>
 Balazs Nemeth <bnemeth@redhat.com> <balazs.nemeth@intel.com>
 Bao-Long Tran <longtb5@viettel.com.vn>
 Baoyuan Li <updoing@sina.com>
-Bar Neuman <bneuman@nvidia.com>
 Barak Enat <barak@saguna.net>
 Barbara Skobiej <barbara.skobiej@intel.com>
+Bar Neuman <bneuman@nvidia.com>
 Barry Cao <barry.cao@nxp.com>
 Bartosz Jakub Rosadzinski <bartosz.jakub.rosadzinski@intel.com>
 Bartosz Staszewski <bartoszx.staszewski@intel.com>
@@ -195,10 +195,10 @@ Bill Hong <bhong@brocade.com>
 Bill Xiang <xiangwencheng@dayudpu.com>
 Billy McFall <bmcfall@redhat.com>
 Billy O'Mahony <billy.o.mahony@intel.com>
+Bingbin Chen <chen.bingbin@zte.com.cn>
 Bing Zhao <bingz@nvidia.com> <bingz@mellanox.com> <bing.zhao@hxt-semitech.com>
 Bin Huang <brian.huangbin@huawei.com> <bin.huang@hxt-semitech.com>
 Bin Zheng <zhengbin.89740@bytedance.com>
-Bingbin Chen <chen.bingbin@zte.com.cn>
 Björn Töpel <bjorn.topel@intel.com>
 Bo Chen <box.c.chen@intel.com>
 Boleslav Stankevich <boleslav.stankevich@oktetlabs.ru>
@@ -226,8 +226,8 @@ Carolyn Wyborny <carolyn.wyborny@intel.com>
 Chaeyong Chong <cychong@gmail.com>
 Chaitanya Babu Talluri <tallurix.chaitanya.babu@intel.com>
 Chandubabu Namburu <chandu@amd.com>
-Chang Miao <chang.miao@corigine.com>
 Changchun Ouyang <changchun.ouyang@intel.com>
+Chang Miao <chang.miao@corigine.com>
 Changpeng Liu <changpeng.liu@intel.com>
 Changqi Dingluo <dingluochangqi.ck@bytedance.com>
 Changqing Wu <changqingx.wu@intel.com>
@@ -246,8 +246,8 @@ Chenglian Sun <sunchenglian@loongson.cn>
 Cheng Liu <liucheng11@huawei.com>
 Cheng Peng <cheng.peng5@zte.com.cn>
 Chengwen Feng <fengchengwen@huawei.com>
-Chenmin Sun <chenmin.sun@intel.com>
 Chenming Chang <ccm@ccm.ink>
+Chenmin Sun <chenmin.sun@intel.com>
 Chenxingyu Wang <wangchenxingyu@huawei.com>
 Chenxu Di <chenxux.di@intel.com>
 Chenyu Huang <chenyux.huang@intel.com>
@@ -385,8 +385,8 @@ Dong Zhou <dongzhou@nvidia.com> <dongz@mellanox.com>
 Don Provan <dprovan@bivio.net>
 Don Wallwork <donw@xsightlabs.com>
 Doug Dziggel <douglas.a.dziggel@intel.com>
-Douglas Flint <douglas.flint@broadcom.com>
 Doug Foster <doug.foster@arm.com>
+Douglas Flint <douglas.flint@broadcom.com>
 Dr. David Alan Gilbert <dgilbert@redhat.com>
 Drocula Lambda <quzeyao@gmail.com>
 Dror Birkman <dror.birkman@lightcyber.com>
@@ -531,8 +531,8 @@ Hanoch Haim <hhaim@cisco.com>
 Hanumanth Pothula <hpothula@marvell.com>
 Hanxiao Li <li.hanxiao@zte.com.cn>
 Hao Chen <chenh@yusur.tech> <chenhao164@huawei.com>
-Hao Wu <hao.wu@intel.com>
 Haoqian He <haoqian.he@smartx.com>
+Hao Wu <hao.wu@intel.com>
 Hari Kumar Vemula <hari.kumarx.vemula@intel.com>
 Harini Ramakrishnan <harini.ramakrishnan@microsoft.com>
 Hariprasad Govindharajan <hariprasad.govindharajan@intel.com>
@@ -552,8 +552,8 @@ Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 Helin Zhang <helin.zhang@intel.com>
 Hemant Agrawal <hemant.agrawal@nxp.com> <hemant@freescale.com>
 Heng Ding <hengx.ding@intel.com>
-Hengjian Zhang <hengjianx.zhang@intel.com>
 Heng Jiang <jiangheng14@huawei.com>
+Hengjian Zhang <hengjianx.zhang@intel.com>
 Hengqi Chen <hengqi.chen@gmail.com>
 Heng Wang <heng.wang@ericsson.com>
 Henning Schild <henning.schild@siemens.com>
@@ -620,7 +620,6 @@ Ivan Dyukov <i.dyukov@samsung.com>
 Ivan Ilchenko <ivan.ilchenko@oktetlabs.ru>
 Ivan Malov <ivan.malov@arknetworks.am> <ivan.malov@oktetlabs.ru>
 Ivan Nardi <nardi.ivan@gmail.com>
-J.J. Martzki <mars14850@gmail.com>
 Jacek Bułatek <jacekx.bulatek@intel.com>
 Jacek Naczyk <jacek.naczyk@intel.com>
 Jacek Piasecki <jacekx.piasecki@intel.com>
@@ -641,6 +640,8 @@ James Grant <j.grant@qub.ac.uk>
 James Hershaw <james.hershaw@corigine.com>
 James Poole <james.g.poole@intel.com>
 Jamie Lavigne <lavignen@amazon.com>
+Jananee Parthasarathy <jananeex.m.parthasarathy@intel.com>
+Janardhanan Arumugam <janardhanan.arumugam@intel.com>
 Jan Beulich <jbeulich@suse.com>
 Jan Blunck <jblunck@infradead.org>
 Jan Medala <jan.medala@outlook.com> <jan@semihalf.com>
@@ -648,8 +649,6 @@ Jan Remes <remes@netcope.com>
 Jan Sokolowski <jan.sokolowski@intel.com>
 Jan Viktorin <viktorin@cesnet.cz> <viktorin@rehivetech.com>
 Jan Wickbom <jan.wickbom@ericsson.com>
-Jananee Parthasarathy <jananeex.m.parthasarathy@intel.com>
-Janardhanan Arumugam <janardhanan.arumugam@intel.com>
 Jaromír Smrček <4plague@gmail.com>
 Jaroslaw Gawin <jaroslawx.gawin@intel.com>
 Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
@@ -657,11 +656,11 @@ Jason He <jason.he@broadcom.com>
 Jason Wang <jasowang@redhat.com>
 Jasper Tran O'Leary <jtranoleary@google.com>
 Jasvinder Singh <jasvinder.singh@intel.com>
+Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
 Jay Ding <jay.ding@broadcom.com>
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
 Jay Rolette <rolette@infiniteio.com>
 Jay Zhou <jianjay.zhou@huawei.com>
-Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
 Jean Dao <jean.dao@6wind.com>
 Jean-Mickael Guerin <jean-mickael.guerin@6wind.com> <jmg@6wind.com>
 Jean Tourrilhes <jt@labs.hpe.com>
@@ -687,12 +686,12 @@ Jesper Wramberg <jesper.wramberg@gmail.com>
 Jesse Brandeburg <jesse.brandeburg@intel.com>
 Jesse Bruni <jesse.bruni@intel.com>
 Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>
-Jian Wang <jianwang@trustnetic.com>
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>
 Jianfeng Tan <jianfeng.tan@intel.com>
-Jiang Yu <yux.jiang@intel.com>
 Jiangu Zhao <zhaojg@arraynetworks.com.cn>
+Jiang Yu <yux.jiang@intel.com>
 Jianping Zhao <zhao305149619@gmail.com>
+Jian Wang <jianwang@trustnetic.com>
 Jianwei Ma <jianwei.ma@intel.com>
 Jianwei Mei <jianweix.mei@intel.com>
 Jiaqi Min <jiaqix.min@intel.com>
@@ -704,9 +703,9 @@ Jia Yu <jyu@vmware.com>
 Jie Hai <haijie1@huawei.com>
 Jie Liu <jie2.liu@hxt-semitech.com>
 Jie Pan <panjie5@jd.com>
+Jieqiang Wang <jieqiang.wang@arm.com>
 Jie Wang <jie1x.wang@intel.com>
 Jie Zhou <jizh@linux.microsoft.com> <jizh@microsoft.com>
-Jieqiang Wang <jieqiang.wang@arm.com>
 Jijiang Liu <jijiang.liu@intel.com>
 Jilei Chen <chenjilei@cmss.chinamobile.com>
 Jim Harris <james.r.harris@intel.com>
@@ -720,6 +719,7 @@ Jin Ling <jin.ling@intel.com>
 Jin Liu <jin.liu@corigine.com>
 Jin Yu <jin.yu@intel.com>
 Jiri Slaby <jslaby@suse.cz>
+J.J. Martzki <mars14850@gmail.com>
 Job Abraham <job.abraham@intel.com>
 Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
 Joel Kavanagh <joel.kavanagh@intel.com>
@@ -776,12 +776,12 @@ Junjie Chen <junjie.j.chen@intel.com>
 Junjie Wan <wanjunjie@bytedance.com>
 Junlong Wang <wang.junlong1@zte.com.cn>
 Jun Qiu <jun.qiu@jaguarmicro.com>
+Jun Wang <junwang01@cestc.cn>
 Jun W Zhou <junx.w.zhou@intel.com>
 Junxiao Shi <git@mail1.yoursunny.com> <sunnylandh@gmail.com>
-Jun Wang <junwang01@cestc.cn>
 Jun Yang <jun.yang@nxp.com>
-Jun Zhang <xuejun.zhang@intel.com>
 Junyu Jiang <junyux.jiang@intel.com>
+Jun Zhang <xuejun.zhang@intel.com>
 Juraj Linkeš <juraj.linkes@pantheon.tech>
 Kai Ji <kai.ji@intel.com>
 Kaijun Zeng <corezeng@gmail.com>
@@ -1004,10 +1004,10 @@ Maxime Gouin <maxime.gouin@6wind.com>
 Maxime Leroy <maxime.leroy@6wind.com>
 Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
 Megha Ajmera <megha.ajmera@intel.com>
-Menachem Fogel <menachem.fogel@intel.com>
 Meijuan Zhao <meijuanx.zhao@intel.com>
 Meir Levi <mlevi4@marvell.com>
 Meir Tseitlin <mirots@gmail.com>
+Menachem Fogel <menachem.fogel@intel.com>
 Mesut Ali Ergin <mesut.a.ergin@intel.com>
 Miao Li <miao.li@intel.com>
 Michael Barker <mikeb01@gmail.com>
@@ -1217,8 +1217,8 @@ Peter Nilsson <peter.j.nilsson@ericsson.com>
 Peter Spreadborough <peter.spreadborough@broadcom.com>
 Petr Houska <t-pehous@microsoft.com>
 Phanendra Vukkisala <pvukkisala@marvell.com>
-Phil Yang <phil.yang@arm.com>
 Philip Prindeville <philipp@redfish-solutions.com>
+Phil Yang <phil.yang@arm.com>
 Pier Damouny <pdamouny@nvidia.com>
 Pierre Pfister <ppfister@cisco.com>
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
@@ -1298,8 +1298,8 @@ Ray Kinsella <mdr@ashroe.eu> <ray.kinsella@intel.com>
 Raz Amir <razamir22@gmail.com>
 Real Valiquette <real.valiquette@intel.com>
 Rebecca Troy <rebecca.troy@intel.com>
-Remi Pommarel <repk@triplefau.lt>
 Remigiusz Konca <remigiuszx.konca@intel.com>
+Remi Pommarel <repk@triplefau.lt>
 Remy Horton <remy.horton@intel.com>
 Renata Saiakhova <renata.saiakhova@ekinops.com>
 Renyong Wan <wanry@yunsilicon.com>
@@ -1347,8 +1347,8 @@ Rosen Xu <rosen.xu@altera.com> <rosen.xu@intel.com>
 Roy Franz <roy.franz@cavium.com>
 Roy Pledge <roy.pledge@nxp.com>
 Roy Shterman <roy.shterman@vastdata.com>
-Rui Ferreira <rui.ferreira1@h-partners.com>
 Ruifeng Wang <ruifeng.wang@arm.com>
+Rui Ferreira <rui.ferreira1@h-partners.com>
 Rupesh Chiluka <rchiluka@marvell.com>
 Rushil Gupta <rushilg@google.com>
 Ryan E Hall <ryan.e.hall@intel.com>
@@ -1443,11 +1443,11 @@ Shreyansh Jain <shreyansh.jain@nxp.com>
 Shrikrishna Khare <skhare@vmware.com>
 Shuai Zhu <shuaix.zhu@intel.com>
 Shuanglin Wang <shuanglin.wang@broadcom.com>
+Shujing Dong <shujing.dong@corigine.com>
 Shuki Katzenelson <shuki@lightbitslabs.com>
 Shun Hao <shunh@nvidia.com>
-Shu Shen <shu.shen@radisys.com>
-Shujing Dong <shujing.dong@corigine.com>
 Shuo Li <lishuo02@baidu.com>
+Shu Shen <shu.shen@radisys.com>
 Shweta Choudaha <shweta.choudaha@att.com>
 Shyam Kumar Shrivastav <shrivastav.shyam@gmail.com>
 Shy Shyman <shys@nvidia.com> <shys@mellanox.com>
@@ -1572,15 +1572,15 @@ Tianhao Chai <cth451@gmail.com>
 Tianjiao Liu <tianjiao.liu@intel.com>
 Tianli Lai <laitianli@tom.com>
 Tianyu Li <tianyu.li@arm.com>
+Tim Martin <timothym@nvidia.com>
 Timmons C. Player <timmons.player@spirent.com>
 Timothy McDaniel <timothy.mcdaniel@intel.com>
 Timothy Miskell <timothy.miskell@intel.com>
 Timothy Redaelli <tredaelli@redhat.com>
-Tim Martin <timothym@nvidia.com>
 Tim Shearer <tim.shearer@overturenetworks.com>
 Ting-Kai Ku <ting-kai.ku@intel.com>
-Ting Xu <ting.xu@intel.com>
 Tingting Liao <tingtingx.liao@intel.com>
+Ting Xu <ting.xu@intel.com>
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
 Tiwei Bie <tiwei.bie@intel.com> <btw@mail.ustc.edu.cn>
 Todd Fujinaka <todd.fujinaka@intel.com>
@@ -1596,10 +1596,10 @@ Tomasz Wakula <tomaszx.wakula@intel.com>
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>
 Tom Barbette <barbette@kth.se> <tom.barbette@ulg.ac.be>
 Tom Crugnale <tcrugnale@sandvine.com>
+Tomer Shmilovich <tshmilovich@nvidia.com>
 Tom Jones <thj@freebsd.org>
 Tom Millington <tmillington@solarflare.com>
 Tom Rix <trix@redhat.com>
-Tomer Shmilovich <tshmilovich@nvidia.com>
 Tone Zhang <tone.zhang@arm.com>
 Tonghao Zhang <xiangxia.m.yue@gmail.com> <nic@opencloud.tech>
 Tony Nguyen <anthony.l.nguyen@intel.com>
@@ -1651,8 +1651,8 @@ Vincent Jardin <vincent.jardin@6wind.com>
 Vincent Li <vincent.mc.li@gmail.com>
 Vincent S. Cojot <vcojot@redhat.com>
 Vinh Tran <vinh.t.tran10@gmail.com>
-Vipin Padmam Ramesh <vipinp@vmware.com>
 Vinod Krishna <vinod.krishna@arm.com>
+Vipin Padmam Ramesh <vipinp@vmware.com>
 Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>
 Vipul Ashri <vipul.ashri@oracle.com>
 Visa Hankala <visa@hankala.org>
@@ -1692,8 +1692,8 @@ Wei Wang <lnykww@gmail.com>
 Wei Xie <weix.xie@intel.com>
 Weiyuan Li <weiyuanx.li@intel.com>
 Wei Zhao <wei.zhao1@intel.com>
-Wen Chiu <wchiu@brocade.com>
 Wenbo Cao <caowenbo@mucse.com>
+Wen Chiu <wchiu@brocade.com>
 Wen-Chi Yang <wolkayang@gmail.com>
 Wenfeng Liu <liuwf@arraynetworks.com.cn>
 Wenjie Li <wenjiex.a.li@intel.com>
@@ -1737,10 +1737,10 @@ Xiao Zhang <xiao.zhang@intel.com>
 Xieming Katty <katty.xieming@huawei.com>
 Xinfeng Zhao <xinfengx.zhao@intel.com>
 Xingguang He <xingguang.he@intel.com>
-Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
-Xinying Yu <xinying.yu@corigine.com>
+Xingyou Chen <niatlantice@gmail.com>
 Xin Long <longxin.xl@alibaba-inc.com>
+Xinying Yu <xinying.yu@corigine.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
 Xuan Li <lixuan47@hisilicon.com>
@@ -1790,8 +1790,8 @@ Yisen Zhuang <yisen.zhuang@huawei.com>
 Yixue Wang <yixue.wang@intel.com>
 Yi Yang <yangyi01@inspur.com> <yi.y.yang@intel.com>
 Yi Zhang <zhang.yi75@zte.com.cn>
-Yoan Picchi <yoan.picchi@arm.com>
 Yoann Desmouceaux <ydesmouc@cisco.com>
+Yoan Picchi <yoan.picchi@arm.com>
 Yochai Hagvi <yochai.hagvi@intel.com>
 Yogesh Bhosale <yogesh.bhosale@intel.com>
 Yogesh Jangra <yogesh.jangra@intel.com>
-- 
2.47.2

