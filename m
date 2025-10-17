Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05322CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF12242DA1;
	Fri, 17 Oct 2025 15:38:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4F75A427D8
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760708301; x=1792244301;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IJYjuc/3dHg1458STSBmeLzD/KDhjJIeME7TpsS+8C4=;
 b=GhaUnkhU4ukYz2NnkPP3yoihuRCOM1YCGNA4BL6ugQKjqhSkbJ9nkLJc
 y1W5V1S7S8ClhnNDDrOJh9NsUNfH6xBhvy7EomJCz0+GvMWXqpzVrYZoe
 3JlregnWCtoGujjgjvGRC7bvcFYg2NqmQ4fc9sCw+BQbIO8EJQjX3JZsV
 rxgq5LKkHAD9qqsnn22c5IirVcaj8wnpD8ShU609M/OrkJvthGXz78Aeu
 Ak9csTZTm+49K0i2ka+QCSR5Of8xblkAUiyd3UbbTYEHAQe1QOU5/n+Pf
 T+NmcmSZklEPVlbarbWj/I2NyWFZBJtvv1dmLl9dZvy2pusu4Z0VU4c3A g==;
X-CSE-ConnectionGUID: rK8B1+LgSwuNCS9GcDkcaA==
X-CSE-MsgGUID: ISDcGpsJS6KwF0C2iPaYNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="74262100"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74262100"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 06:38:20 -0700
X-CSE-ConnectionGUID: j0J+uNNbTNi35b+lLxgrlw==
X-CSE-MsgGUID: eJGsmNOhTZW1G5ttDrCebw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2025 06:38:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/2] mailmap: sort mailmap
Date: Fri, 17 Oct 2025 14:38:08 +0100
Message-ID: <20251017133812.1109638-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017133812.1109638-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20251017133812.1109638-1-bruce.richardson@intel.com>
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

Sort mailmap in alphabetical order, such that shorter names come before
longer names i.e. "Dan Programmer" comes before "Daniel Coder", not
after.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .mailmap | 356 +++++++++++++++++++++++++++----------------------------
 1 file changed, 178 insertions(+), 178 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..f3f4f6557c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -49,6 +49,14 @@ Aleksey Katargin <gureedo@gmail.com>
 Ales Musil <amusil@redhat.com>
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
 Alex Chapman <alex.chapman@arm.com>
+Alex Kiselev <alex@bisonrouter.com> <alex@therouter.net>
+Alex Marginean <alexandru.marginean@nxp.com>
+Alex Markuze <alex@weka.io>
+Alex Porosanu <alexandru.porosanu@nxp.com>
+Alex Rosenbaum <alexr@nvidia.com> <alexr@mellanox.com>
+Alex Vesker <valex@nvidia.com>
+Alex Wang <alex@awakenetworks.com>
+Alex Zelezniak <alexz@att.com>
 Alexander Bechikov <asb.tyum@gmail.com>
 Alexander Belyakov <abelyako@gmail.com>
 Alexander Chernavin <achernavin@netgate.com>
@@ -60,19 +68,11 @@ Alexander Solganik <solganik@gmail.com>
 Alexander V Gutkin <alexander.v.gutkin@intel.com>
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>
 Alexey Kardashevskiy <aik@ozlabs.ru>
-Alex Kiselev <alex@bisonrouter.com> <alex@therouter.net>
-Alex Marginean <alexandru.marginean@nxp.com>
-Alex Markuze <alex@weka.io>
-Alex Porosanu <alexandru.porosanu@nxp.com>
-Alex Rosenbaum <alexr@nvidia.com> <alexr@mellanox.com>
-Alex Vesker <valex@nvidia.com>
-Alex Wang <alex@awakenetworks.com>
-Alex Zelezniak <alexz@att.com>
 Alfredo Cardigliano <cardigliano@ntop.org>
 Ali Alnubani <alialnu@nvidia.com> <alialnu@mellanox.com>
+Ali Volkan Atli <volkan.atli@argela.com.tr>
 Alice Michael <alice.michael@intel.com>
 Alin Rauta <alin.rauta@intel.com>
-Ali Volkan Atli <volkan.atli@argela.com.tr>
 Allain Legacy <allain.legacy@windriver.com>
 Allen Hubbe <allen.hubbe@amd.com>
 Alok Makhariya <alok.makhariya@nxp.com>
@@ -81,9 +81,9 @@ Alvaro Karsz <alvaro.karsz@solid-run.com>
 Alvin Zhang <alvinx.zhang@intel.com>
 Aman Singh <aman.deep.singh@intel.com>
 Amaranath Somalapuram <asomalap@amd.com>
-Amine Kherbouche <amine.kherbouche@6wind.com>
-Amin Tootoonchian <amint@icsi.berkeley.edu>
 Ami Sabo <amis@radware.com>
+Amin Tootoonchian <amint@icsi.berkeley.edu>
+Amine Kherbouche <amine.kherbouche@6wind.com>
 Amir Avivi <amir.avivi@intel.com>
 Amit Bernstein <amitbern@amazon.com>
 Amit Gupta <agupta3@marvell.com>
@@ -92,18 +92,18 @@ Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
 Amr Mokhtar <amr.mokhtar@intel.com>
 Amruta Zende <amruta.zende@intel.com>
 Amrutha Sampath <amrutha.sampath@intel.com>
-Ananda Sathyanarayana <ananda@versa-networks.com>
 Anand B Jyoti <anand.b.jyoti@intel.com>
 Anand Rawat <anand.rawat@intel.com>
 Anand Sunkad <anand.sunkad@benisontech.com>
+Ananda Sathyanarayana <ananda@versa-networks.com>
 Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
 Anatoly Burakov <anatoly.burakov@intel.com>
 Anbarasan Murugesan <anbarasanx.murugesan@intel.com>
 Anders Roxell <anders.roxell@linaro.org>
 Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
+Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
-Andre Richter <andre.o.richter@gmail.com>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
 Andrew Jackson <ajackson@solarflare.com>
@@ -145,9 +145,9 @@ Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
 Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
 Arnon Warshavsky <arnon@qwilt.com>
 Arshdeep Kaur <arshdeep.kaur@intel.com>
+Artem V. Andreev <artem.andreev@oktetlabs.ru>
 Artemii Morozov <artemii.morozov@arknetworks.am>
 Artemy Kovalyov <artemyko@nvidia.com>
-Artem V. Andreev <artem.andreev@oktetlabs.ru>
 Artur Rojek <ar@semihalf.com>
 Artur Trybula <arturx.trybula@intel.com>
 Artur Tyminski <arturx.tyminski@intel.com>
@@ -163,8 +163,8 @@ Ashish Shah <ashish.n.shah@intel.com>
 Ashok Kaladi <ashok.k.kaladi@intel.com>
 Ashwin Sekhar T K <asekhar@marvell.com> <ashwin.sekhar@caviumnetworks.com>
 Asim Jamshed <asim.jamshed@gmail.com>
-Aviad Yehezkel <aviadye@mellanox.com>
 Avi Kivity <avi@scylladb.com>
+Aviad Yehezkel <aviadye@mellanox.com>
 Aviraj CJ <aviraj.cj@intel.com>
 Aws Ismail <aismail@ciena.com>
 Ayuj Verma <ayverma@marvell.com> <ayuj.verma@caviumnetworks.com>
@@ -181,16 +181,16 @@ Bartosz Jakub Rosadzinski <bartosz.jakub.rosadzinski@intel.com>
 Bartosz Staszewski <bartoszx.staszewski@intel.com>
 Baruch Siach <baruch@tkos.co.il>
 Bassam Zaid AlKilani <bzalkilani@nvidia.com>
-Beilei Xing <beilei.xing@intel.com>
 Bei Sun <bei.sun@broadcom.com>
-Benjamin Le Berre <benjamin.le_berre@6wind.com>
-Benjamin Mikailenko <benjamin.mikailenko@intel.com>
+Beilei Xing <beilei.xing@intel.com>
 Ben Magistro <koncept1@gmail.com>
-Benoît Canet <benoit.canet@nodalink.com>
-Benoît Ganne <bganne@cisco.com>
 Ben Pfaff <blp@ovn.org>
 Ben Shelton <benjamin.h.shelton@intel.com>
 Ben Walker <benjamin.walker@intel.com>
+Benjamin Le Berre <benjamin.le_berre@6wind.com>
+Benjamin Mikailenko <benjamin.mikailenko@intel.com>
+Benoît Canet <benoit.canet@nodalink.com>
+Benoît Ganne <bganne@cisco.com>
 Bernard Iremonger <bernard.iremonger@intel.com>
 Bert van Leeuwen <bert.vanleeuwen@netronome.com>
 Bhagyada Modali <bhagyada.modali@amd.com>
@@ -200,10 +200,10 @@ Bill Hong <bhong@brocade.com>
 Bill Xiang <xiangwencheng@dayudpu.com>
 Billy McFall <bmcfall@redhat.com>
 Billy O'Mahony <billy.o.mahony@intel.com>
-Bing Zhao <bingz@nvidia.com> <bingz@mellanox.com>
-Bing Zhao <bingz@nvidia.com> <bing.zhao@hxt-semitech.com>
 Bin Huang <brian.huangbin@huawei.com> <bin.huang@hxt-semitech.com>
 Bin Zheng <zhengbin.89740@bytedance.com>
+Bing Zhao <bingz@nvidia.com> <bingz@mellanox.com>
+Bing Zhao <bingz@nvidia.com> <bing.zhao@hxt-semitech.com>
 Bingbin Chen <chen.bingbin@zte.com.cn>
 Björn Töpel <bjorn.topel@intel.com>
 Bo Chen <box.c.chen@intel.com>
@@ -239,21 +239,21 @@ Changchun Ouyang <changchun.ouyang@intel.com>
 Changpeng Liu <changpeng.liu@intel.com>
 Changqi Dingluo <dingluochangqi.ck@bytedance.com>
 Changqing Wu <changqingx.wu@intel.com>
-Chaoyong He <chaoyong.he@corigine.com>
 Chao Zhu <chaozhu@linux.vnet.ibm.com> <bjzhuc@cn.ibm.com>
+Chaoyong He <chaoyong.he@corigine.com>
 Charles Brett <cfb@hpe.com>
 Charles Myers <charles.myers@spirent.com>
 Charles Stoll <charles.stoll@intel.com>
 Chas Williams <3chas3@gmail.com> <chas3@att.com>
 Chas Williams <3chas3@gmail.com> <ciwillia@brocade.com>
 Chenbo Xia <chenbox@nvidia.com> <chenbo.xia@intel.com>
+Cheng Jiang <honest.jiang@foxmail.com> <cheng1.jiang@intel.com>
+Cheng Liu <liucheng11@huawei.com>
+Cheng Peng <cheng.peng5@zte.com.cn>
 Chengchang Tang <tangchengchang@huawei.com> <tangchengchang@hisilicon.com>
 Chengfeng Ye <cyeaa@connect.ust.hk>
 Chenghu Yao <yao.chenghu@zte.com.cn>
-Cheng Jiang <honest.jiang@foxmail.com> <cheng1.jiang@intel.com>
 Chenglian Sun <sunchenglian@loongson.cn>
-Cheng Liu <liucheng11@huawei.com>
-Cheng Peng <cheng.peng5@zte.com.cn>
 Chengwen Feng <fengchengwen@huawei.com>
 Chenmin Sun <chenmin.sun@intel.com>
 Chenming Chang <ccm@ccm.ink>
@@ -265,16 +265,16 @@ Chinh Cao <chinh.t.cao@intel.com>
 Chintu Hetam <rometoroam@gmail.com>
 Choonho Son <choonho.son@gmail.com>
 Chris Metcalf <cmetcalf@mellanox.com>
+Chris Wright <chrisw@redhat.com>
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
 Christian Koue Muf <ckm@napatech.com>
 Christian Maciocco <christian.maciocco@intel.com>
+Christoph Gysin <christoph.gysin@gmail.com>
 Christophe Fontaine <cfontain@redhat.com>
 Christophe Grosse <christophe.grosse@6wind.com>
 Christopher Pau <christopher.pau@intel.com>
 Christopher Reder <christopher.reder@broadcom.com>
-Christoph Gysin <christoph.gysin@gmail.com>
 Christos Ricudis <ricudis@niometrics.com>
-Chris Wright <chrisw@redhat.com>
 Chuanshe Zhang <zhangchuanshe@icloudshield.com>
 Chuanyu Xue <chuanyu.xue@uconn.edu>
 Chuhong Yao <ych@panath.cn>
@@ -303,9 +303,10 @@ Damien Millescamps <damien.millescamps@6wind.com>
 Damjan Marion <damarion@cisco.com>
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
 Dan Aloni <dan@kernelim.com>
-Dana Vardi <danat@marvell.com>
 Dan Gora <dg@adax.com>
-Daniele Di Proietto <ddiproietto@vmware.com>
+Dan Nowlin <dan.nowlin@intel.com>
+Dan Wei <dan.wei@intel.com>
+Dana Vardi <danat@marvell.com>
 Daniel Gregory <daniel.gregory@bytedance.com>
 Daniel Kaminsky <daniel.kaminsky@infinitelocality.com>
 Daniel Kan <dan@nyansa.com>
@@ -313,11 +314,10 @@ Daniel Martin Buckley <daniel.m.buckley@intel.com>
 Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>
 Daniel Shelepov <dashel@microsoft.com>
 Daniel Verkamp <daniel.verkamp@intel.com>
+Daniele Di Proietto <ddiproietto@vmware.com>
 Daniil Ushkov <daniil.ushkov@yandex.ru>
-Dan Nowlin <dan.nowlin@intel.com>
 Danny Patel <dannyp@marvell.com>
 Danny Zhou <danny.zhou@intel.com>
-Dan Wei <dan.wei@intel.com>
 Danylo Vodopianov <dvo-plv@napatech.com>
 Dapeng Yu <dapengx.yu@intel.com>
 Darek Stojaczyk <dariusz.stojaczyk@intel.com>
@@ -335,7 +335,6 @@ David Bouyeure <david.bouyeure@fraudbuster.mobi>
 David Christensen <drc@linux.ibm.com> <drc@linux.vnet.ibm.com>
 David Christensen <drc@linux.ibm.com> <david.christensen@broadcom.com>
 David Coyle <david.coyle@intel.com>
-Davide Caratti <dcaratti@redhat.com>
 David George <david.george@sophos.com>
 David Harton <dharton@cisco.com>
 David Hunt <david.hunt@intel.com>
@@ -347,10 +346,11 @@ David Su <david.w.su@intel.com>
 David Verbeiren <david.verbeiren@intel.com>
 David Wilder <dwilder@us.ibm.com>
 David Zeng <zengxhsh@cn.ibm.com>
+Davide Caratti <dcaratti@redhat.com>
 Dawid Gorecki <dgr@semihalf.com>
 Dawid Jurczak <dawid_jurek@vp.pl>
-Dawid Łukwiński <dawid.lukwinski@intel.com>
 Dawid Zielinski <dawid.zielinski@intel.com>
+Dawid Łukwiński <dawid.lukwinski@intel.com>
 Daxue Gao <daxuex.gao@intel.com>
 Dean Marx <dmarx@iol.unh.edu>
 Declan Doherty <declan.doherty@intel.com>
@@ -384,19 +384,19 @@ Dmitry Eremin-Solenikov <dmitry.ereminsolenikov@linaro.org>
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com> <dkozlyuk@nvidia.com>
 Dmitry Vyukov <dvyukov@gmail.com>
 Dodji Seketeli <dodji@redhat.com>
+Don Provan <dprovan@bivio.net>
+Don Wallwork <donw@xsightlabs.com>
 Donald Lee <donald_lee@trendmicro.com>
+Dong Wang <dong1.wang@intel.com>
+Dong Zhou <dongzhou@nvidia.com> <dongz@mellanox.com>
 Dongdong Liu <liudongdong3@huawei.com>
 Dongsheng Rong <rongdongsheng@baidu.com>
 Dongsu Han <dongsuh@cs.cmu.edu>
-Dong Wang <dong1.wang@intel.com>
 Dongwei Xu <xudw@yunsilicon.com>
 Dongyang Pan <197020236@qq.com>
-Dong Zhou <dongzhou@nvidia.com> <dongz@mellanox.com>
-Don Provan <dprovan@bivio.net>
-Don Wallwork <donw@xsightlabs.com>
 Doug Dziggel <douglas.a.dziggel@intel.com>
-Douglas Flint <douglas.flint@broadcom.com>
 Doug Foster <doug.foster@arm.com>
+Douglas Flint <douglas.flint@broadcom.com>
 Dr. David Alan Gilbert <dgilbert@redhat.com>
 Drocula Lambda <quzeyao@gmail.com>
 Dror Birkman <dror.birkman@lightcyber.com>
@@ -441,13 +441,13 @@ Evgeny Schemeilin <evgenys@amazon.com>
 Fabio Pricoco <fabio.pricoco@intel.com>
 Fady Bader <fady@mellanox.com>
 Faicker Mo <faicker.mo@ucloud.cn>
-Fangfang Wei <fangfangx.wei@intel.com>
-Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
+Fang TongHao <fangtonghao@sangfor.com.cn>
+Fangfang Wei <fangfangx.wei@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
 Fei Qin <fei.qin@corigine.com>
+Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
 Fengtian Guo <fengtian.guo@6wind.com>
@@ -480,9 +480,9 @@ Gage Eads <gage.eads@intel.com>
 Gal Cohen <galco@nvidia.com> <galco@mellanox.com>
 Gal Shalom <galshalom@nvidia.com>
 Ganapati Kundapura <ganapati.kundapura@intel.com>
-Ganghui Zeng <zengganghui@huawei.com>
 Gang Jiang <jiangg@mail.ustc.edu.cn>
 Gang Yang <gangx.yang@intel.com>
+Ganghui Zeng <zengganghui@huawei.com>
 Gao Feng <davidfgao@tencent.com>
 Gaoxiang Liu <liugaoxiang@huawei.com>
 Gargi Sau <gargi.sau@intel.com>
@@ -491,14 +491,14 @@ Gaurav Singh <gaurav1086@gmail.com>
 Gautam Dawar <gdawar@solarflare.com>
 Gavin Hu <gahu@nvidia.com> <gavin.hu@arm.com>
 Gavin Hu <gahu@nvidia.com> <gavin.hu@linaro.org>
+Geoff Thorpe <geoff.thorpe@nxp.com>
 Geoffrey Le Gourriérec <geoffrey.le_gourrierec@6wind.com>
 Geoffrey Lv <geoffrey.lv@gmail.com>
-Geoff Thorpe <geoff.thorpe@nxp.com>
+Georg Sauthoff <mail@gms.tf>
 George Prekas <prekageo@amazon.com>
 George Wilkie <george.wilkie@intl.att.com> <gwilkie@brocade.com>
 Georgios Katsikas <katsikas.gp@gmail.com>
 Georgiy Levashov <georgiy.levashov@oktetlabs.ru>
-Georg Sauthoff <mail@gms.tf>
 Gerald Rogers <gerald.rogers@intel.com>
 Gerry Gribbon <ggribbon@nvidia.com>
 Ghalem Boudour <ghalem.boudour@6wind.com>
@@ -509,9 +509,9 @@ Gordon Noonan <gordon.noonan@intel.com>
 Gosia Bakota <gosia.bakota@intel.com>
 Govindarajulu Varadarajan <gvaradar@cisco.com>
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com> <gowrishankar.m@linux.vnet.ibm.com>
+Greg Tucker <greg.b.tucker@intel.com>
 Gregory Etelson <getelson@nvidia.com> <getelson@mellanox.com>
 Gregory Etelson <getelson@nvidia.com> <gregory@weka.io>
-Greg Tucker <greg.b.tucker@intel.com>
 Grishma Kotecha <grishma.kotecha@intel.com>
 Grzegorz Galkowski <grzegorz.galkowski@intel.com>
 Grzegorz Nitka <grzegorz.nitka@intel.com>
@@ -520,13 +520,14 @@ Guduri Prathyusha <gprathyusha@caviumnetworks.com>
 Guido Barzini <gbarzini@solarflare.com>
 Guillaume Gaudonville <guillaume.gaudonville@6wind.com>
 Guinan Sun <guinanx.sun@intel.com>
-Guolin Yang <guolin.yang@broadcom.com> <gyang@vmware.com>
 Guo Xin <gxin@ezchip.com>
+Guolin Yang <guolin.yang@broadcom.com> <gyang@vmware.com>
 Guoyang Zhou <zhouguoyang@huawei.com>
 Gur Stavi <gur.stavi@huawei.com>
 Guruprasad Rao <guruprasadx.rao@intel.com>
 Guy Kaneti <guyk@marvell.com>
 Guy Tzalik <gtzalik@amazon.com>
+H. Peter Anvin <hpa@linux.intel.com>
 Haggai Eran <haggaie@nvidia.com>
 Haifei Luo <haifeil@nvidia.com>
 Haifeng Gao <gaohaifeng.gao@huawei.com>
@@ -566,10 +567,10 @@ Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 Helin Zhang <helin.zhang@intel.com>
 Hemant Agrawal <hemant.agrawal@nxp.com> <hemant@freescale.com>
 Heng Ding <hengx.ding@intel.com>
-Hengjian Zhang <hengjianx.zhang@intel.com>
 Heng Jiang <jiangheng14@huawei.com>
-Hengqi Chen <hengqi.chen@gmail.com>
 Heng Wang <heng.wang@ericsson.com>
+Hengjian Zhang <hengjianx.zhang@intel.com>
+Hengqi Chen <hengqi.chen@gmail.com>
 Henning Schild <henning.schild@siemens.com>
 Henry Cai <caihe@huawei.com>
 Henry Nadeau <hnadeau@iol.unh.edu>
@@ -592,16 +593,15 @@ Hongzhi Guo <guohongzhi1@huawei.com>
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
 Horia Geanta Neag <horia.geanta@nxp.com>
 Howard Wang <howard_wang@realsil.com.cn>
-H. Peter Anvin <hpa@linux.intel.com>
 Hrvoje Habjanic <hrvoje.habjanic@zg.ht.hr>
 Huaibin Wang <huaibin.wang@6wind.com>
 Huanle Han <hanxueluo@gmail.com>
 Huawei Xie <huawei.xhw@alibaba-inc.com> <huawei.xie@intel.com>
 Huaxing Zhu <huaxing.zhu@corigine.com>
+Hui Zhao <zhaohui8@huawei.com>
 Huichao Cai <chcchc88@163.com>
 Huilong Xu <huilongx.xu@intel.com>
 Huisong Li <lihuisong@huawei.com>
-Hui Zhao <zhaohui8@huawei.com>
 Huzaifa Rahman <huzaifa.rahman@emumba.com>
 Hyong Youb Kim <hyonkim@cisco.com>
 Hyun Yoo <easetheworld@gmail.com>
@@ -679,16 +679,16 @@ Jay Rolette <rolette@infiniteio.com>
 Jay Zhou <jianjay.zhou@huawei.com>
 Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
 Jean Dao <jean.dao@6wind.com>
-Jean-Mickael Guerin <jean-mickael.guerin@6wind.com> <jmg@6wind.com>
 Jean Tourrilhes <jt@labs.hpe.com>
+Jean-Mickael Guerin <jean-mickael.guerin@6wind.com> <jmg@6wind.com>
 Jeb Cramer <jeb.j.cramer@intel.com>
 Jecky Pei <jpei@sonicwall.com>
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
 Jeff Daly <jeffd@silicom-usa.com>
 Jeff Guo <jia.guo@intel.com>
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-Jeffrey Huang <jeffrey.huang@broadcom.com>
 Jeff Shaw <jeffrey.b.shaw@intel.com>
+Jeffrey Huang <jeffrey.huang@broadcom.com>
 Jens Freimann <jfreimann@redhat.com> <jfreiman@redhat.com>
 Jeremy Plsek <jplsek@iol.unh.edu>
 Jeremy Spewock <jspewock@iol.unh.edu>
@@ -704,6 +704,7 @@ Jesper Wramberg <jesper.wramberg@gmail.com>
 Jesse Brandeburg <jesse.brandeburg@intel.com>
 Jesse Bruni <jesse.bruni@intel.com>
 Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>
+Jia Yu <jyu@vmware.com>
 Jian Wang <jianwang@trustnetic.com>
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>
 Jianfeng Tan <jianfeng.tan@intel.com>
@@ -716,7 +717,6 @@ Jiawei Wang <jiaweiw@nvidia.com> <jiaweiw@mellanox.com>
 Jiawei Zhu <zhujiawei12@huawei.com>
 Jiawen Wu <jiawenwu@trustnetic.com>
 Jiayu Hu <hujiayu.hu@foxmail.com> <jiayu.hu@intel.com>
-Jia Yu <jyu@vmware.com>
 Jie Hai <haijie1@huawei.com>
 Jie Liu <jie2.liu@hxt-semitech.com>
 Jie Pan <panjie5@jd.com>
@@ -726,15 +726,15 @@ Jieqiang Wang <jieqiang.wang@arm.com>
 Jijiang Liu <jijiang.liu@intel.com>
 Jilei Chen <chenjilei@cmss.chinamobile.com>
 Jim Harris <james.r.harris@intel.com>
+Jin Heo <jin.heo@broadcom.com> <heoj@vmware.com>
+Jin Ling <jin.ling@intel.com>
+Jin Liu <jin.liu@corigine.com>
+Jin Yu <jin.yu@intel.com>
 Jincheng Miao <jincheng.miao@gmail.com> <jmiao@redhat.com>
 Jing Chen <jing.d.chen@intel.com>
 Jingguo Fu <jingguox.fu@intel.com>
 Jingjing Wu <jingjing.wu@intel.com>
 Jingzhao Ni <jingzhao.ni@arm.com>
-Jin Heo <jin.heo@broadcom.com> <heoj@vmware.com>
-Jin Ling <jin.ling@intel.com>
-Jin Liu <jin.liu@corigine.com>
-Jin Yu <jin.yu@intel.com>
 Jiri Slaby <jslaby@suse.cz>
 Job Abraham <job.abraham@intel.com>
 Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
@@ -750,8 +750,8 @@ John Daley <johndale@cisco.com>
 John Griffin <john.griffin@intel.com>
 John Guzik <john@shieldxnetworks.com>
 John Hurley <jhurley@nvidia.com>
-John Jacques <john.jacques@intel.com>
 John J Browne <john.j.browne@intel.com>
+John Jacques <john.jacques@intel.com>
 John Levon <john.levon@nutanix.com>
 John McNamara <john.mcnamara@intel.com>
 John Miller <john.miller@atomicrules.com>
@@ -759,14 +759,13 @@ John OLoughlin <john.oloughlin@intel.com>
 John Ousterhout <ouster@cs.stanford.edu>
 John Romein <romein@astron.nl>
 John W. Linville <linville@tuxdriver.com>
+Jon DeVree <nuxi@vault24.org>
+Jon Loeliger <jdl@netgate.com>
 Jonas Pfefferle <jpf@zurich.ibm.com> <pepperjo@japf.ch>
 Jonathan Erb <jonathan.erb@threater.com> <jonathan.erb@threatblockr.com>
 Jonathan Erb <jonathan.erb@threater.com> <jonathan.erb@banduracyber.com>
 Jonathan Tsai <jonathan1.tsai@intel.com>
-Jon DeVree <nuxi@vault24.org>
-Jon Loeliger <jdl@netgate.com>
 Joongi Kim <joongi@an.kaist.ac.kr>
-Jørgen Østergaard Sloth <jorgen.sloth@xci.dk>
 Jörg Thalheim <joerg@thalheim.io>
 Joseph Richard <joseph.richard@windriver.com>
 Josh Soref <jsoref@gmail.com>
@@ -787,18 +786,19 @@ Julien Hascoet <ju.hascoet@gmail.com>
 Julien Massonneau <julien.massonneau@6wind.com>
 Julien Meunier <julien.meunier@nokia.com> <julien.meunier@6wind.com>
 Július Milan <jmilan.dev@gmail.com>
-Junfeng Guo <junfengg@nvidia.com> <junfeng.guo@intel.com>
-Junjie Chen <junjie.j.chen@intel.com>
-Junjie Wan <wanjunjie@bytedance.com>
-Junlong Wang <wang.junlong1@zte.com.cn>
 Jun Qiu <jun.qiu@jaguarmicro.com>
 Jun W Zhou <junx.w.zhou@intel.com>
-Junxiao Shi <git@mail1.yoursunny.com> <sunnylandh@gmail.com>
 Jun Wang <junwang01@cestc.cn>
 Jun Yang <jun.yang@nxp.com>
 Jun Zhang <xuejun.zhang@intel.com>
+Junfeng Guo <junfengg@nvidia.com> <junfeng.guo@intel.com>
+Junjie Chen <junjie.j.chen@intel.com>
+Junjie Wan <wanjunjie@bytedance.com>
+Junlong Wang <wang.junlong1@zte.com.cn>
+Junxiao Shi <git@mail1.yoursunny.com> <sunnylandh@gmail.com>
 Junyu Jiang <junyux.jiang@intel.com>
 Juraj Linkeš <juraj.linkes@pantheon.tech>
+Jørgen Østergaard Sloth <jorgen.sloth@xci.dk>
 Kai Ji <kai.ji@intel.com>
 Kaijun Zeng <corezeng@gmail.com>
 Kaisen You <kaisenx.you@intel.com>
@@ -814,13 +814,15 @@ Kamil Vojanec <vojanec@cesnet.cz> <xvojan00@stud.fit.vutbr.cz>
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>
 Karen Kelly <karen.kelly@intel.com>
 Karen Sornek <karen.sornek@intel.com>
-Karla Saur <karla.saur@intel.com>
 Karl Bonde Torp <k.torp@samsung.com>
+Karla Saur <karla.saur@intel.com>
 Karmarkar Suyash <skarmarkar@sonusnet.com>
 Karol Kolacinski <karol.kolacinski@intel.com>
 Karra Satwik <kaara.satwik@chelsio.com>
 Kathleen Capella <kathleen.capella@arm.com>
 Kazatsker Kirill <kirill.kazatsker@intel.com>
+Ke Xu <ke1.xu@intel.com>
+Ke Zhang <ke1x.zhang@intel.com>
 Kefu Chai <tchaikov@gmail.com>
 Keiichi Watanabe <keiichiw@chromium.org>
 Keith Wiles <keith.wiles@intel.com> <keith.wiles@windriver.com>
@@ -832,8 +834,6 @@ Kevin Liu <kevinx.liu@intel.com>
 Kevin O'Sullivan <kevin.osullivan@intel.com>
 Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
-Ke Xu <ke1.xu@intel.com>
-Ke Zhang <ke1x.zhang@intel.com>
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
@@ -855,8 +855,8 @@ Krzysztof Witek <krzysztof.witek@6wind.com>
 Kuan Xu <kuanx.xu@intel.com>
 Kuba Kozak <kubax.kozak@intel.com>
 Kumar Amber <kumar.amber@intel.com>
-Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kumar Sanghvi <kumaras@chelsio.com>
+Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kyle Larose <klarose@sandvine.com>
 Lance Richardson <lance.richardson@broadcom.com>
 Laszlo Ersek <lersek@redhat.com>
@@ -871,51 +871,52 @@ Lei Cai <lei.cai@jaguarmicro.com>
 Lei Gong <arei.gonglei@huawei.com>
 Lei Ji <jilei8@huawei.com>
 Lei Yao <lei.a.yao@intel.com>
-Leonid Myravjev <myravjev@amicon.ru>
 Leo Xu <yongquanx@nvidia.com>
+Leonid Myravjev <myravjev@amicon.ru>
 Leszek Zygo <leszek.zygo@intel.com>
-Levend Sayar <levendsayar@gmail.com>
 Lev Faerman <lev.faerman@intel.com>
+Levend Sayar <levendsayar@gmail.com>
 Lewei Yang <leweix.yang@intel.com>
 Lewis Donzis <lew@perftech.com>
 Leyi Rong <leyi.rong@intel.com>
+Li Feng <fengli@smartx.com>
+Li Han <han.li1@zte.com.cn>
+Li Qiang <liq3ea@163.com>
+Li Wei <lw@cn.fujitsu.com>
+Li Zhang <lizh@nvidia.com>
 Liang Ma <liangma@bytedance.com> <liangma@liangbit.com>
 Liang Ma <liangma@bytedance.com> <liang.j.ma@intel.com>
-Liang-Min Larry Wang <liang-min.wang@intel.com>
-Liangxing Wang <liangxing.wang@arm.com>
 Liang Xu <liang.xu@cinfotech.cn>
 Liang Zhang <zhangliang@bigo.sg>
-Li Feng <fengli@smartx.com>
-Li Han <han.li1@zte.com.cn>
+Liang-Min Larry Wang <liang-min.wang@intel.com>
+Liangxing Wang <liangxing.wang@arm.com>
 Lihong Ma <lihongx.ma@intel.com>
 Lijian Zhang <lijian.zhang@arm.com>
 Lijie Shan <shan.lijie@zte.com.cn>
 Lijuan Tu <lijuan.tu@intel.com> <lijuanx.a.tu@intel.com>
 Lijun Ou <oulijun@huawei.com>
 Liming Sun <lsun@ezchip.com> <lsun@mellanox.com>
+Lin Li <lilintjpu@bytedance.com> <lilin24@baidu.com>
 Linfan Hu <zhongdahulinfan@163.com>
 Lingli Chen <linglix.chen@intel.com>
 Lingyu Liu <lingyu.liu@intel.com>
-Lin Li <lilintjpu@bytedance.com> <lilin24@baidu.com>
 Linsi Yuan <yuanlinsi01@baidu.com>
 Lior Margalit <lmargalit@nvidia.com>
-Li Qiang <liq3ea@163.com>
 Liron Himi <lironh@marvell.com>
-Li Wei <lw@cn.fujitsu.com>
-Li Zhang <lizh@nvidia.com>
-Longfeng Liang <longfengx.liang@intel.com>
 Long Li <longli@microsoft.com>
 Long Wu <long.wu@corigine.com>
+Longfeng Liang <longfengx.liang@intel.com>
 Lotem Leder <lotem.leder@intel.com>
-Louise Kilheeney <louise.kilheeney@intel.com>
 Louis Luo <llouis@vmware.com>
 Louis Peens <louis.peens@corigine.com> <louis.peens@netronome.com>
+Louise Kilheeney <louise.kilheeney@intel.com>
+Lu Qiuwen <luqiuwen@iie.ac.cn>
+Luc Pelletier <lucp.at.work@gmail.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <bluca@debian.org>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@gmail.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
-Luc Pelletier <lucp.at.work@gmail.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
 Lukas Sismis <sismis@cesnet.cz>
 Lukasz Bartosik <lbartosik@marvell.com>
@@ -930,7 +931,6 @@ Lukasz Wojciechowski <l.wojciechow@partner.samsung.com>
 Luke Gorrie <luke@snabb.co>
 Luke Seewald <luke.seewald@gmail.com>
 Lunyuan Cui <lunyuanx.cui@intel.com>
-Lu Qiuwen <luqiuwen@iie.ac.cn>
 Lyn M <netinal7@gmail.com>
 Maayan Kashani <mkashani@nvidia.com>
 Maciej Bielski <mba@semihalf.com>
@@ -944,14 +944,14 @@ Maciej Rabeda <maciej.rabeda@intel.com>
 Maciej Szwed <maciej.szwed@intel.com>
 Madhu Chittim <madhu.chittim@intel.com>
 Madhuker Mythri <madhuker.mythri@oracle.com>
+Mah Yock Gen <yock.gen.mah@intel.com>
 Mahesh Adulla <mahesh.adulla@amd.com>
 Mahipal Challa <mchalla@marvell.com>
 Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
-Mah Yock Gen <yock.gen.mah@intel.com>
 Mairtin o Loingsigh <mairtin.oloingsigh@intel.com>
 Malcolm Bumgardner <mbumgard@cisco.com>
-Mallesham Jatharakonda <mjatharakonda@oneconvergence.com>
 Mallesh Koujalagi <malleshx.koujalagi@intel.com>
+Mallesham Jatharakonda <mjatharakonda@oneconvergence.com>
 Malvika Gupta <malvika.gupta@arm.com>
 Mandal Purna Chandra <purna.chandra.mandal@intel.com>
 Mandeep Rohilla <mrohilla@brocade.com>
@@ -960,6 +960,7 @@ Manish Kurup <manish.kurup@broadcom.com>
 Manish Tomar <manish.tomar@nxp.com>
 Mao Jiang <maox.jiang@intel.com>
 Marat Khalili <marat.khalili@huawei.com>
+Marc Sune <marcdevel@gmail.com> <marc.sune@bisdn.de>
 Marcel Apfelbaum <marcel@redhat.com>
 Marcel Cornu <marcel.d.cornu@intel.com>
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
@@ -976,7 +977,6 @@ Marcin Wilk <marcin.wilk@caviumnetworks.com>
 Marcin Wojtas <mw@semihalf.com>
 Marcin Zapolski <marcinx.a.zapolski@intel.com>
 Marco Varlese <mvarlese@suse.de>
-Marc Sune <marcdevel@gmail.com> <marc.sune@bisdn.de>
 Marek Mical <marekx.mical@intel.com>
 Marek Zalfresso-jundzillo <marekx.zalfresso-jundzillo@intel.com>
 Maria Lingemark <maria.lingemark@ericsson.com>
@@ -987,10 +987,10 @@ Mark Asselstine <mark.asselstine@windriver.com>
 Mark Bloch <mbloch@nvidia.com> <markb@mellanox.com>
 Mark Gillott <mgillott@vyatta.att-mail.com>
 Mark Kavanagh <mark.b.kavanagh@intel.com>
-Marko Kovacevic <marko.kovacevic@intel.com>
-Markos Chandras <mchandras@suse.de>
 Mark Smith <marsmith@akamai.com>
 Mark Spender <mspender@xilinx.com> <mspender@solarflare.com>
+Marko Kovacevic <marko.kovacevic@intel.com>
+Markos Chandras <mchandras@suse.de>
 Markus Theil <markus.theil@tu-ilmenau.de> <markus.theil@secunet.com>
 Marta Plantykow <marta.a.plantykow@intel.com>
 Martijn Bakker <gladdyu@gmail.com>
@@ -1011,6 +1011,7 @@ Mateusz Polchlopek <mateusz.polchlopek@intel.com>
 Mateusz Rusinski <mateusz.rusinski@intel.com>
 Matias Elo <matias.elo@nokia.com>
 Mats Liljegren <mats.liljegren@enea.com>
+Matt Peters <matt.peters@windriver.com>
 Matteo Croce <mcroce@redhat.com>
 Matthew Dirba <matthew.dirba@arm.com>
 Matthew Hall <mhall@mhcomputing.net>
@@ -1019,7 +1020,6 @@ Matthew Vick <matthew.vick@intel.com>
 Matthias Gatto <matthias.gatto@outscale.com>
 Matthieu Ternisien d'Ouville <matthieu.tdo@6wind.com>
 Mattias Rönnblom <mattias.ronnblom@ericsson.com> <hofors@lysator.liu.se>
-Matt Peters <matt.peters@windriver.com>
 Mauricio Vasquez B <mauricio.vasquez@polito.it> <mauricio.vasquezbernal@studenti.polito.it>
 Mauro Annarumma <mauroannarumma@hotmail.it>
 Maxime Coquelin <maxime.coquelin@redhat.com>
@@ -1027,10 +1027,10 @@ Maxime Gouin <maxime.gouin@6wind.com>
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
@@ -1044,10 +1044,10 @@ Michael McConville <mmcco@mykolab.com>
 Michael Pfeiffer <michael.pfeiffer@tu-ilmenau.de>
 Michael Qiu <qiudayu@chinac.com> <michael.qiu@intel.com>
 Michael Rossberg <michael.rossberg@tu-ilmenau.de>
+Michael S. Tsirkin <mst@redhat.com>
 Michael Santana <maicolgabriel@hotmail.com> <msantana@redhat.com>
 Michael Savisko <michaelsav@nvidia.com>
 Michael Shamis <michaelsh@marvell.com>
-Michael S. Tsirkin <mst@redhat.com>
 Michael Theodore Stolarchuk <mike.stolarchuk@arista.com>
 Michael Wildt <michael.wildt@broadcom.com>
 Michal Berger <michallinuxstuff@gmail.com>
@@ -1058,11 +1058,11 @@ Michal Krawczyk <mk@semihalf.com>
 Michal Litwicki <michalx.litwicki@intel.com>
 Michal Mazurek <maz@semihalf.com>
 Michal Michalik <michal.michalik@intel.com>
-Michał Mirosław <michal.miroslaw@atendesoftware.pl> <mirq-linux@rere.qmqm.pl>
 Michal Nowak <michal2.nowak@intel.com>
 Michal Schmidt <mschmidt@redhat.com>
 Michal Swiatkowski <michal.swiatkowski@intel.com>
 Michal Wilczynski <michal.wilczynski@intel.com>
+Michał Mirosław <michal.miroslaw@atendesoftware.pl> <mirq-linux@rere.qmqm.pl>
 Michel Machado <michel@digirati.com.br>
 Midde Ajijur Rehaman <ajijurx.rehaman.midde@intel.com>
 Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
@@ -1076,18 +1076,18 @@ Mike Ximing Chen <mike.ximing.chen@intel.com>
 Mikolaj Filar <mikolajx.filar@intel.com>
 Milena Olech <milena.olech@intel.com>
 Min Cao <min.cao@intel.com>
+Min Hu (Connor) <humin29@huawei.com>
+Min Wang (Jushui) <wangmin3@huawei.com>
+Min Zhou <zhoumin@loongson.cn>
+Ming Zhao <mzhao@luminatewireless.com>
 Minggang Li (Gavin) <gavinl@nvidia.com>
 Minghuan Lian <minghuan.lian@nxp.com>
 Mingjin Ye <mingjinx.ye@intel.com>
 Mingshan Zhang <mingshan.zhang@intel.com>
 Mingxia Liu <mingxia.liu@intel.com>
-Ming Zhao <mzhao@luminatewireless.com>
-Min Hu (Connor) <humin29@huawei.com>
-Min Wang (Jushui) <wangmin3@huawei.com>
-Min Zhou <zhoumin@loongson.cn>
 Miroslaw Walukiewicz <miroslaw.walukiewicz@intel.com>
-Mitch Williams <mitch.a.williams@intel.com>
 Mit Matelske <mit@pt.net>
+Mitch Williams <mitch.a.williams@intel.com>
 Mohamad Noor Alim Hussin <mohamad.noor.alim.hussin@intel.com>
 Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
 Mohammad Abdul Awal <mohammad.abdul.awal@intel.com>
@@ -1106,16 +1106,16 @@ Murphy Yang <murphyx.yang@intel.com>
 Murthy NSSR <nidadavolu.murthy@caviumnetworks.com>
 Muthurajan Jayakumar <muthurajan.jayakumar@intel.com>
 Mykola Kostenok <mko-plv@napatech.com>
+Na Na <nana@yunsilicon.com> <nana.nn@alibaba-inc.com>
 Nachiketa Prachanda <nprachan@brocade.com> <nprachan@vyatta.att-mail.com>
-Nagadheeraj Rottela <rnagadheeraj@marvell.com>
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
 Naga Suresh Somarowthu <naga.sureshx.somarowthu@intel.com>
+Nagadheeraj Rottela <rnagadheeraj@marvell.com>
 Nalla Pradeep <pnalla@marvell.com>
-Na Na <nana@yunsilicon.com> <nana.nn@alibaba-inc.com>
 Nan Chen <whutchennan@gmail.com>
+Nan Zhou <zhounan14@huawei.com>
 Nandini Persad <nandinipersad361@gmail.com>
 Nannan Lu <nannan.lu@intel.com>
-Nan Zhou <zhounan14@huawei.com>
 Narcisa Vasile <navasile@linux.microsoft.com> <navasile@microsoft.com>
 Narcisa Vasile <navasile@linux.microsoft.com> <narcisa.vasile@microsoft.com>
 Narender Vangati <narender.vangati@intel.com>
@@ -1210,10 +1210,10 @@ Paul Atkins <paul.atkins@intl.att.com>
 Paul E. McKenney <paulmck@linux.ibm.com>
 Paul Fox <pfox@solarflare.com>
 Paul Greenwalt <paul.greenwalt@intel.com>
-Paulis Gributs <paulis.gributs@intel.com>
 Paul Luse <paul.e.luse@intel.com>
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
 Paul Szczepanek <paul.szczepanek@arm.com>
+Paulis Gributs <paulis.gributs@intel.com>
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>
 Pavan Nikhilesh <pbhagavatula@marvell.com> <pbhagavatula@caviumnetworks.com>
 Pavel Belous <pavel.belous@aquantia.com>
@@ -1230,12 +1230,12 @@ Pawel Wodkowski <pawelwod@gmail.com> <pawelx.wodkowski@intel.com>
 Pawel Wodkowski <pawelwod@gmail.com> <pawelx.wdkowski@intel.com>
 Pei Chao <peichao85@gmail.com>
 Pei Zhang <pezhang@redhat.com>
-Pengfei Sun <sunpengfei16@huawei.com>
 Peng He <hepeng.0320@bytedance.com> <xnhp0320@icloud.com>
 Peng Huang <peng.huang@intel.com>
 Peng Sun <peng.a.sun@intel.com>
 Peng Yu <penyu@amazon.com>
 Peng Zhang <peng.zhang@corigine.com> <peng1x.zhang@intel.com>
+Pengfei Sun <sunpengfei16@huawei.com>
 Pengzhen Liu <liupengzhen3@huawei.com>
 Peter Mccarthy <peter.mccarthy@intel.com>
 Peter Morrow <peter@graphiant.com>
@@ -1277,20 +1277,21 @@ Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
 Przemyslaw Zegan <przemyslawx.zegan@intel.com>
 Pu Xu <583493798@qq.com>
+Qi Fu <qi.fu@intel.com>
+Qi Zhang <qi.z.zhang@intel.com>
 Qian Hao <qi_an_hao@126.com>
 Qian Xu <qian.q.xu@intel.com>
 Qiao Liu <qiao.liu@intel.com>
-Qi Fu <qi.fu@intel.com>
 Qimai Xiao <qimaix.xiao@intel.com>
 Qiming Chen <chenqiming_huawei@163.com>
 Qiming Yang <qiming.yang@intel.com>
-Qinglai Xiao <jigsaw@gmail.com>
-Qingmin Liu <qingmin.liu@broadcom.com> <qingmin.liu@jaguarmicro.com>
 Qin Ke <qin.ke@corigine.com>
 Qin Sun <qinx.sun@intel.com>
-Qi Zhang <qi.z.zhang@intel.com>
+Qinglai Xiao <jigsaw@gmail.com>
+Qingmin Liu <qingmin.liu@broadcom.com> <qingmin.liu@jaguarmicro.com>
 Quentin Armitage <quentin@armitage.org.uk>
 Qun Wan <qun.wan@intel.com>
+R Mohamed Shah <mohamedshah.r@amd.com>
 Radha Mohan Chintakuntla <radhac@marvell.com>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Radoslaw Tyl <radoslawx.tyl@intel.com>
@@ -1335,15 +1336,16 @@ Renyong Wan <wanry@yunsilicon.com>
 Reshma Pattan <reshma.pattan@intel.com> <reshma.pattan@gmail.com>
 Ricardo Roldan <rroldan@bequant.com>
 Ricardo Salveti <ricardo.salveti@linaro.org>
+Rich Lane <rich.lane@bigswitch.com>
 Richael Zhuang <richael.zhuang@arm.com>
 Richard Donkin <richard.donkin@corigine.com>
 Richard Eklycke <richard.eklycke@ericsson.com>
 Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsw@xilinx.com>
 Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsworth@solarflare.com>
 Richard Walsh <richard.walsh@intel.com>
-Rich Lane <rich.lane@bigswitch.com>
 Ricky Li <ricky.li@intel.com>
-R Mohamed Shah <mohamedshah.r@amd.com>
+Rob Miller <rob.miller@broadcom.com>
+Rob Scheepens <rob.scheepens@nutanix.com>
 Robert Konklewski <robertx.konklewski@intel.com>
 Robert Malz <robertx.malz@intel.com>
 Robert Sanford <rsanford@akamai.com> <rsanford2@gmail.com>
@@ -1352,8 +1354,6 @@ Robert Shearman <rshearma@brocade.com>
 Robert Stonehouse <rstonehouse@solarflare.com>
 Robin Jarry <rjarry@redhat.com> <robin.jarry@6wind.com>
 Robin Zhang <robinx.zhang@intel.com>
-Rob Miller <rob.miller@broadcom.com>
-Rob Scheepens <rob.scheepens@nutanix.com>
 Rogelio Domínguez Hernández <rogelio.dominguez@gmail.com>
 Roger Melton <rmelton@cisco.com>
 Rohit Raj <rohit.raj@nxp.com>
@@ -1366,11 +1366,11 @@ Roman Kapl <rka@sysgo.com>
 Roman Korynkevych <romanx.korynkevych@intel.com>
 Roman Storozhenko <roman.storozhenko@intel.com>
 Roman Zhukov <roman.zhukov@arknetworks.am> <roman.zhukov@oktetlabs.ru>
-Ronak Doshi <ronak.doshi@broadcom.com> <doshir@vmware.com>
 Ron Beider <rbeider@amazon.com>
+Ronak Doshi <ronak.doshi@broadcom.com> <doshir@vmware.com>
+Rong Qian <qianr@yunsilicon.com>
 Ronghua Zhang <rzhang@vmware.com>
 RongQiang Xie <xie.rongqiang@zte.com.cn>
-Rong Qian <qianr@yunsilicon.com>
 RongQing Li <lirongqing@baidu.com>
 Rongwei Liu <rongweil@nvidia.com>
 Rory Sexton <rory.sexton@intel.com>
@@ -1391,8 +1391,8 @@ Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>
 Saleh Alsouqi <salehals@nvidia.com> <salehals@mellanox.com>
 Salem Sol <salems@nvidia.com>
 Sam Andrew <samandrew@microsoft.com>
-Sameh Gobriel <sameh.gobriel@intel.com>
 Sam Grove <sam.grove@sifive.com>
+Sameh Gobriel <sameh.gobriel@intel.com>
 Samik Gupta <samik.gupta@broadcom.com>
 Samina Arshad <samina.arshad@intel.com>
 Sampath Peechu <speechu@cisco.com>
@@ -1401,8 +1401,8 @@ Sandilya Bhagi <sbhagi@solarflare.com>
 Sangjin Han <sangjin@eecs.berkeley.edu>
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
 Sankar Chokkalingam <sankarx.chokkalingam@intel.com>
-Santoshkumar Karanappa Rastapur <santosh.rastapur@broadcom.com>
 Santosh Shukla <santosh.shukla@caviumnetworks.com> <sshukla@mvista.com>
+Santoshkumar Karanappa Rastapur <santosh.rastapur@broadcom.com>
 Saoirse O'Donovan <saoirse.odonovan@intel.com>
 Saori Usami <susami@igel.co.jp>
 Sarath Somasekharan <sarathx.somasekharan@intel.com>
@@ -1416,8 +1416,8 @@ Saurabh Singhal <saurabhs@arista.com>
 Savinay Dharmappa <savinay.dharmappa@intel.com>
 Scott Branden <scott.branden@broadcom.com>
 Scott Daniels <daniels@research.att.com>
-Scott Wasson <scott_wasson@affirmednetworks.com>
 Scott W Taylor <scott.w.taylor@intel.com>
+Scott Wasson <scott_wasson@affirmednetworks.com>
 Seán Harte <seanbh@gmail.com>
 Sean Harte <sean.harte@intel.com>
 Sean Morrissey <sean.morrissey@intel.com>
@@ -1433,6 +1433,7 @@ Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>
 Serhii Iliushyk <sil-plv@napatech.com>
 Seth Arnold <seth.arnold@canonical.com>
 Seth Howell <seth.howell@intel.com>
+Sha Zhang <zhangsha.zhang@huawei.com>
 Shachar Beiser <shacharbe@mellanox.com>
 Shagun Agrawal <shaguna@chelsio.com>
 Shahaf Shuler <shahafs@nvidia.com> <shahafs@mellanox.com>
@@ -1452,7 +1453,6 @@ Sharmila Podury <sharmila.podury@att.com>
 Sharon Haroni <sharon.haroni@intel.com>
 Shay Agroskin <shayagr@amazon.com>
 Shay Amir <shay.amir@intel.com>
-Sha Zhang <zhangsha.zhang@huawei.com>
 Shelton Chia <jiaxt@sinogrid.com>
 Shepard Siegel <shepard.siegel@atomicrules.com>
 Shesha Sreenivasamurthy <shesha@cisco.com>
@@ -1472,16 +1472,16 @@ Shraddha Joshi <jshraddha@vmware.com>
 Shreesh Adiga <16567adigashreesh@gmail.com>
 Shreyansh Jain <shreyansh.jain@nxp.com>
 Shrikrishna Khare <skhare@vmware.com>
+Shu Shen <shu.shen@radisys.com>
 Shuai Zhu <shuaix.zhu@intel.com>
 Shuanglin Wang <shuanglin.wang@broadcom.com>
+Shujing Dong <shujing.dong@corigine.com>
 Shuki Katzenelson <shuki@lightbitslabs.com>
 Shun Hao <shunh@nvidia.com>
-Shu Shen <shu.shen@radisys.com>
-Shujing Dong <shujing.dong@corigine.com>
 Shuo Li <lishuo02@baidu.com>
 Shweta Choudaha <shweta.choudaha@att.com>
-Shyam Kumar Shrivastav <shrivastav.shyam@gmail.com>
 Shy Shyman <shys@nvidia.com> <shys@mellanox.com>
+Shyam Kumar Shrivastav <shrivastav.shyam@gmail.com>
 Sibaranjan Pattnayak <spattnayak@marvell.com>
 Siddaraju DH <siddaraju.dh@intel.com>
 Simei Su <simei.su@intel.com>
@@ -1534,13 +1534,13 @@ Stephen Hemminger <stephen@networkplumber.org> <shemming@brocade.com>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@vyatta.com>
 Stephen Hurd <stephen.hurd@broadcom.com> <shurd@broadcom.com>
 Steve Capper <steve.capper@arm.com>
+Steve Rempe <steve.rempe@broadcom.com>
+Steve Shin <jonshin@cisco.com>
+Steve Yang <stevex.yang@intel.com>
 Steven Lariau <steven.lariau@arm.com>
 Steven Luong <sluong@cisco.com>
 Steven Webster <steven.webster@windriver.com>
 Steven Zou <steven.zou@intel.com>
-Steve Rempe <steve.rempe@broadcom.com>
-Steve Shin <jonshin@cisco.com>
-Steve Yang <stevex.yang@intel.com>
 Stewart Allen <allenste@amazon.com>
 Suanming Mou <suanmingm@nvidia.com> <suanmingm@mellanox.com>
 Suanming Mou <suanmingm@nvidia.com> <mousuanming@huawei.com>
@@ -1550,14 +1550,14 @@ Subrahmanyam Nilla <snilla@marvell.com> <snilla@caviumnetworks.com>
 Sucharitha Sarananaga <ssarananaga@marvell.com>
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
 Sujith Sankar <ssujith@cisco.com>
-Sunila Sahu <ssahu@marvell.com> <sunila.sahu@caviumnetworks.com>
+Sun Jiajia <sunx.jiajia@intel.com>
+Sun Yuechi <sunyuechi@iscas.ac.cn> <uk7b@foxmail.com>
 Sunil Kulkarni <sunil.kulkarni@caviumnetworks.com>
 Sunil Kumar Kori <skori@marvell.com> <skori@mavell.com>
 Sunil Kumar Kori <skori@marvell.com> <sunil.kori@nxp.com>
 Sunil Pai G <sunil.pai.g@intel.com>
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
-Sun Jiajia <sunx.jiajia@intel.com>
-Sun Yuechi <sunyuechi@iscas.ac.cn> <uk7b@foxmail.com>
+Sunila Sahu <ssahu@marvell.com> <sunila.sahu@caviumnetworks.com>
 Sunyang Wu <sunyang.wu@jaguarmicro.com>
 Surabhi Boob <surabhi.boob@intel.com>
 Suyang Ju <sju@paloaltonetworks.com>
@@ -1594,8 +1594,8 @@ Thierry Herbelot <thierry.herbelot@6wind.com>
 Thierry Martin <thierry.martin.public@gmail.com>
 Thinh Tran <thinhtr@linux.vnet.ibm.com>
 Thiyagarajan P <thiyagarajan.p@amd.com>
-Thomas Faivre <thomas.faivre@6wind.com>
 Thomas F Herbert <therbert@redhat.com>
+Thomas Faivre <thomas.faivre@6wind.com>
 Thomas Graf <tgraf@redhat.com>
 Thomas Long <thomas.long@intel.com>
 Thomas Monjalon <thomas@monjalon.net> <thomas.monjalon@6wind.com>
@@ -1608,18 +1608,23 @@ Tianhao Chai <cth451@gmail.com>
 Tianjiao Liu <tianjiao.liu@intel.com>
 Tianli Lai <laitianli@tom.com>
 Tianyu Li <tianyu.li@arm.com>
+Tim Martin <timothym@nvidia.com>
+Tim Shearer <tim.shearer@overturenetworks.com>
 Timmons C. Player <timmons.player@spirent.com>
 Timothy McDaniel <timothy.mcdaniel@intel.com>
 Timothy Miskell <timothy.miskell@intel.com>
 Timothy Redaelli <tredaelli@redhat.com>
-Tim Martin <timothym@nvidia.com>
-Tim Shearer <tim.shearer@overturenetworks.com>
-Ting-Kai Ku <ting-kai.ku@intel.com>
 Ting Xu <ting.xu@intel.com>
+Ting-Kai Ku <ting-kai.ku@intel.com>
 Tingting Liao <tingtingx.liao@intel.com>
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
 Tiwei Bie <tiwei.bie@intel.com> <btw@mail.ustc.edu.cn>
 Todd Fujinaka <todd.fujinaka@intel.com>
+Tom Barbette <barbette@kth.se> <tom.barbette@ulg.ac.be>
+Tom Crugnale <tcrugnale@sandvine.com>
+Tom Jones <thj@freebsd.org>
+Tom Millington <tmillington@solarflare.com>
+Tom Rix <trix@redhat.com>
 Tomáš Ďurovec <tomas.durovec@pantheon.tech>
 Tomasz Cel <tomaszx.cel@intel.com>
 Tomasz Duszynski <tduszynski@marvell.com> <tdu@semihalf.com>
@@ -1630,11 +1635,6 @@ Tomasz Konieczny <tomaszx.konieczny@intel.com>
 Tomasz Kulasek <tomaszx.kulasek@intel.com>
 Tomasz Wakula <tomaszx.wakula@intel.com>
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>
-Tom Barbette <barbette@kth.se> <tom.barbette@ulg.ac.be>
-Tom Crugnale <tcrugnale@sandvine.com>
-Tom Jones <thj@freebsd.org>
-Tom Millington <tmillington@solarflare.com>
-Tom Rix <trix@redhat.com>
 Tomer Shmilovich <tshmilovich@nvidia.com>
 Tone Zhang <tone.zhang@arm.com>
 Tonghao Zhang <xiangxia.m.yue@gmail.com> <nic@opencloud.tech>
@@ -1659,13 +1659,13 @@ Varun Sethi <v.sethi@nxp.com>
 Vasily Philipov <vasilyf@mellanox.com>
 Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>
 Veerasenareddy Burru <vburru@marvell.com>
-Venkata Suresh Kumar P <venkata.suresh.kumar.p@intel.com>
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
+Venkat Koppula <venkat.koppula@caviumnetworks.com>
+Venkat Kumar Ande <venkatkumar.ande@amd.com>
+Venkata Suresh Kumar P <venkata.suresh.kumar.p@intel.com>
 Venkatesh Nuthula <venki497@gmail.com>
 Venkatesh Srinivas <venkateshs@google.com>
 Venkateshwarlu Nalla <venkatn@marvell.com>
-Venkat Koppula <venkat.koppula@caviumnetworks.com>
-Venkat Kumar Ande <venkatkumar.ande@amd.com>
 Venky Venkatesan <venky.venkatesan@intel.com>
 Venky Venkatesh <vvenkatesh@paloaltonetworks.com>
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am> <viacheslav.galaktionov@oktetlabs.ru>
@@ -1674,10 +1674,10 @@ Victor Kaplansky <victork@redhat.com>
 Victor Raj <victor.raj@intel.com>
 Vidya Sagar Velumuri <vvelumuri@marvell.com>
 Vignesh Sridhar <vignesh.sridhar@intel.com>
-Vijayakumar Muthuvel Manickam <mmvijay@gmail.com>
-Vijaya Mohan Guvva <vijay1054@gmail.com>
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
 Vijay Srivastava <vijays@solarflare.com>
+Vijaya Mohan Guvva <vijay1054@gmail.com>
+Vijayakumar Muthuvel Manickam <mmvijay@gmail.com>
 Vikas Aggarwal <vikas.aggarwal@caviumnetworks.com>
 Vikas Gupta <vikas.gupta@broadcom.com>
 Vikash Poddar <vikash.chandrax.poddar@intel.com>
@@ -1687,8 +1687,8 @@ Vincent Jardin <vincent.jardin@6wind.com>
 Vincent Li <vincent.mc.li@gmail.com>
 Vincent S. Cojot <vcojot@redhat.com>
 Vinh Tran <vinh.t.tran10@gmail.com>
-Vipin Padmam Ramesh <vipinp@vmware.com>
 Vinod Krishna <vinod.krishna@arm.com>
+Vipin Padmam Ramesh <vipinp@vmware.com>
 Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>
 Vipul Ashri <vipul.ashri@oracle.com>
 Visa Hankala <visa@hankala.org>
@@ -1698,11 +1698,11 @@ Vitaliy Mysak <vitaliy.mysak@intel.com>
 Vitaly Lifshits <vitaly.lifshits@intel.com>
 Vivek Sharma <viveksharma@marvell.com> <vivek.sharma@caviumnetworks.com>
 Vivien Didelot <vivien.didelot@gmail.com>
+Vlad Zolotarov <vladz@cloudius-systems.com>
 Vladimir Kuramshin <v.kuramshin@samsung.com>
 Vladimir Medvedkin <vladimir.medvedkin@intel.com> <medvedkinv@gmail.com>
 Vladimir Ratnikov <vratnikov@netgate.com>
 Vladyslav Buslov <vladyslav.buslov@harmonicinc.com>
-Vlad Zolotarov <vladz@cloudius-systems.com>
 Vlastimil Kosar <kosar@rehivetech.com>
 Volodymyr Fialko <vfialko@marvell.com>
 Vu Pham <vuhuong@mellanox.com>
@@ -1713,24 +1713,24 @@ Wang Sheng-Hui <shhuiw@gmail.com>
 Wangyu (Eric) <seven.wangyu@huawei.com>
 Waterman Cao <waterman.cao@intel.com>
 Wathsala Vithanage <wathsala.vithanage@arm.com>
-Weichun Chen <weichunx.chen@intel.com>
 Wei Dai <wei.dai@intel.com>
-Weifeng Li <liweifeng96@126.com>
-Weiguo Li <liweiguo@xencore.cn> <liwg06@foxmail.com>
-Wei Huang <wei.huang@intel.com>
 Wei Hu <weh@microsoft.com>
 Wei Hu (Xavier) <xavier.huwei@huawei.com>
-WeiJie Zhuang <zhuangwj@gmail.com>
-Weiliang Luo <droidluo@gmail.com>
+Wei Huang <wei.huang@intel.com>
 Wei Ling <weix.ling@intel.com>
 Wei Shen <wei1.shen@intel.com>
 Wei Wang <lnykww@gmail.com>
 Wei Xie <weix.xie@intel.com>
-Weiyuan Li <weiyuanx.li@intel.com>
 Wei Zhao <wei.zhao1@intel.com>
+Weichun Chen <weichunx.chen@intel.com>
+Weifeng Li <liweifeng96@126.com>
+Weiguo Li <liweiguo@xencore.cn> <liwg06@foxmail.com>
+WeiJie Zhuang <zhuangwj@gmail.com>
+Weiliang Luo <droidluo@gmail.com>
+Weiyuan Li <weiyuanx.li@intel.com>
 Wen Chiu <wchiu@brocade.com>
-Wenbo Cao <caowenbo@mucse.com>
 Wen-Chi Yang <wolkayang@gmail.com>
+Wenbo Cao <caowenbo@mucse.com>
 Wenfeng Liu <liuwf@arraynetworks.com.cn>
 Wenjie Li <wenjiex.a.li@intel.com>
 Wenjie Sun <findtheonlyway@gmail.com>
@@ -1751,34 +1751,34 @@ Wojciech Liguzinski <wojciechx.liguzinski@intel.com>
 Wojciech Panfil <wojciech.panfil@intel.com>
 Wojciech Zmuda <woz@semihalf.com>
 Xavier Simonart <xavier.simonart@intel.com>
+Xi Zhang <xix.zhang@intel.com>
 Xiangjun Meng <mengxiangjun4@huawei.com>
+Xiao Liang <xiliang@redhat.com>
+Xiao Wang <xiao.w.wang@intel.com>
+Xiao Zhang <xiao.zhang@intel.com>
 Xiaoban Wu <xiaoban_wu@student.uml.edu>
 Xiaobing Zhang <xiaobing.zhang@broadcom.com>
 Xiaobo Chi <xiaobo.chi@nokia.com>
 Xiaofeng Deng <dengxiaofeng@huawei.com>
 Xiaofeng Liu <xiaofeng.liu@6wind.com>
 Xiaohua Zhang <xiaohua.zhang@windriver.com>
-Xiao Liang <xiliang@redhat.com>
 Xiaolong Ye <xiaolong.ye@intel.com>
 Xiaoming Jiang <jiangxiaoming@outlook.com>
 Xiaonan Zhang <xiaonanx.zhang@intel.com>
-Xiao Wang <xiao.w.wang@intel.com>
 Xiaoxiao Zeng <xiaoxiaox.zeng@intel.com>
 Xiaoxin Peng <xiaoxin.peng@broadcom.com>
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>
 Xiaoyu Min <jackmin@nvidia.com> <jackmin@mellanox.com>
 Xiaoyun Li <xiaoyun.li@intel.com>
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
-Xiao Zhang <xiao.zhang@intel.com>
 Xieming Katty <katty.xieming@huawei.com>
+Xin Long <longxin.xl@alibaba-inc.com>
 Xinfeng Zhao <xinfengx.zhao@intel.com>
+Xing Wang <xing_wang@realsil.com.cn>
 Xingguang He <xingguang.he@intel.com>
 Xingui Yang <yangxingui@huawei.com>
 Xingyou Chen <niatlantice@gmail.com>
-Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
-Xin Long <longxin.xl@alibaba-inc.com>
-Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
 Xuan Li <lixuan47@hisilicon.com>
 Xuekun Hu <xuekun.hu@intel.com>
@@ -1791,16 +1791,16 @@ Xutao Sun <xutao.sun@intel.com>
 Yaacov Hazan <yaacovh@mellanox.com>
 Yahui Cao <yahui.cao@intel.com>
 Yajun Wu <yajunw@nvidia.com>
-Yangchao Zhou <zhouyates@gmail.com>
-Yanglong Wu <yanglong.wu@intel.com>
+Yan Lu <luyan@cmss.chinamobile.com>
+Yan Xia <yanx.xia@intel.com>
 Yang Ming <mosesyyoung@gmail.com> <ming.1.yang@nokia-sbell.com>
 Yang Zhang <zy107165@alibaba-inc.com>
+Yangchao Zhou <zhouyates@gmail.com>
+Yanglong Wu <yanglong.wu@intel.com>
 Yaniv Rosner <yrosner@nvidia.com>
 Yanjie Xu <yanjie.xu@intel.com>
-Yan Lu <luyan@cmss.chinamobile.com>
-Yan Xia <yanx.xia@intel.com>
-Yao-Po Wang <blue119@gmail.com>
 Yao Zhao <yao.zhao@windriver.com>
+Yao-Po Wang <blue119@gmail.com>
 Yaqi Tang <yaqi.tang@intel.com>
 Yari Adan Petralanda <yari.adan.petralanda@ericsson.com>
 Yaron Illouz <yaroni@radcom.com>
@@ -1810,13 +1810,15 @@ Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
 Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
+Yi Li <liyi1@chinatelecom.cn>
+Yi Liu <yi.liu@nxp.com>
+Yi Lu <luyi68@live.com>
+Yi Yang <yangyi01@inspur.com> <yi.y.yang@intel.com>
+Yi Zhang <zhang.yi75@zte.com.cn>
 Yicai Lu <luyicai@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yijun Geng <1204565380@qq.com>
-Yi Li <liyi1@chinatelecom.cn>
-Yi Liu <yi.liu@nxp.com>
 Yilong Lv <lvyilong.lyl@alibaba-inc.com>
-Yi Lu <luyi68@live.com>
 Yilun Xu <yilun.xu@intel.com>
 Yinan Wang <yinan.wang@intel.com>
 Ying A Wang <ying.a.wang@intel.com>
@@ -1826,35 +1828,35 @@ Yinjun Zhang <yinjun.zhang@corigine.com>
 Yipeng Wang <yipeng1.wang@intel.com>
 Yisen Zhuang <yisen.zhuang@huawei.com>
 Yixue Wang <yixue.wang@intel.com>
-Yi Yang <yangyi01@inspur.com> <yi.y.yang@intel.com>
-Yi Zhang <zhang.yi75@zte.com.cn>
 Yoan Picchi <yoan.picchi@arm.com>
 Yoann Desmouceaux <ydesmouc@cisco.com>
 Yochai Hagvi <yochai.hagvi@intel.com>
 Yogesh Bhosale <yogesh.bhosale@intel.com>
 Yogesh Jangra <yogesh.jangra@intel.com>
 Yogev Chaimovich <yogev@cgstowernetworks.com>
-Yongjie Gu <yongjiex.gu@intel.com>
-Yongji Xie <xieyongji@baidu.com>
 Yong Liu <yong.liu@intel.com>
-Yongping Zhang <yongping.zhang@broadcom.com>
-Yongseok Koh <yskoh@mellanox.com>
 Yong Wang <wang.yong19@zte.com.cn> <yongwang@vmware.com>
-Yongxin Liu <yongxin.liu@windriver.com>
 Yong Xu <yong.xu@corigine.com>
 Yong Zhang <zhang.yong25@zte.com.cn>
+Yongji Xie <xieyongji@baidu.com>
+Yongjie Gu <yongjiex.gu@intel.com>
+Yongping Zhang <yongping.zhang@broadcom.com>
+Yongseok Koh <yskoh@mellanox.com>
+Yongxin Liu <yongxin.liu@windriver.com>
 Yoni Gilad <yonig@radcom.com>
 Yosef Raisman <yraisman@amazon.com>
 Youri Querry <youri.querry_1@nxp.com>
-Yuanhan Liu <yliu@fridaylinux.org> <yuanhan.liu@linux.intel.com>
+Yu Jiang <yux.jiang@intel.com>
+Yu Nemo Wenbin <yuwb_bjy@ctbri.com.cn>
+Yu Wenjun <yuwenjun@cmss.chinamobile.com> <yuwenjun0x@163.com>
+Yu Zhang <zhangyu31@baidu.com>
 Yuan Peng <yuan.peng@intel.com>
 Yuan Wang <yuanx.wang@intel.com>
 Yuan Zhiyuan <yuanzhiyuan0928@outlook.com>
+Yuanhan Liu <yliu@fridaylinux.org> <yuanhan.liu@linux.intel.com>
 Yufeng Mo <yufengx.mo@intel.com>
 Yuichi Nakai <xoxyuxu@gmail.com>
-Yu Jiang <yux.jiang@intel.com>
 Yulong Pei <yulong.pei@intel.com>
-Yu Nemo Wenbin <yuwb_bjy@ctbri.com.cn>
 Yunjian Wang <wangyunjian@huawei.com>
 Yuri Chipchev <yuric@marvell.com>
 Yury Kylulin <yury.kylulin@intel.com>
@@ -1862,9 +1864,7 @@ Yutang Jiang <jiangyutang@os.amperecomputing.com>
 Yuval Avnery <yuvalav@nvidia.com> <yuvalav@mellanox.com>
 Yuval Caduri <cyuval@marvell.com>
 Yuwei Zhang <yuwei1.zhang@intel.com>
-Yu Wenjun <yuwenjun@cmss.chinamobile.com> <yuwenjun0x@163.com>
 Yuying Zhang <yuying.zhang@intel.com>
-Yu Zhang <zhangyu31@baidu.com>
 Yvonne Yang <yvonnex.yang@intel.com>
 Zaiyu Wang <zaiyuwang@trustnetic.com>
 Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
@@ -1874,9 +1874,9 @@ Zhangfei Gao <zhangfei.gao@linaro.org>
 Zhangkun <zhangk.zhangkun@huawei.com>
 Zhaochen Zhan <zhaochen.zhan@intel.com>
 Zhaoyan Chen <zhaoyan.chen@intel.com>
+Zhe Tao <zhe.tao@intel.com>
 Zhenghua Zhou <zhenghuax.zhou@intel.com>
 Zhenning Xiao <zhenning.xiao@intel.com>
-Zhe Tao <zhe.tao@intel.com>
 Zhichao Zeng <zhichaox.zeng@intel.com>
 Zhigang Hu <zhigang.hu@intel.com>
 Zhigang Lu <zlu@ezchip.com>
-- 
2.48.1

