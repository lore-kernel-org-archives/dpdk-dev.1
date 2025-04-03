Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6CC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 17:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B536D40DD7;
	Thu,  3 Apr 2025 19:00:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B9B1402CB
 for <dev@dpdk.org>; Thu,  3 Apr 2025 19:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743699644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wov5/an19tD4i0wx5OHo/gpzBMHteZEgxnGofQdQ8VM=;
 b=bBBzRzpjd9PybS+bPZoqoIlzQJRlqZpb9JgU4Pu2Ds3yCXu1mzE+VEK/lp/A9VkwsdmVBL
 y9xifsQQP4v2FN0us8RkOt04sX7zhBti5ejlzxfaUFXo1z5Dg84gxqPudpXlTrDtx1hY+a
 30HLPz83kIKg4Y4vR91qSwwb3n0gcAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-eVZOmO88OVGc6mHlT0fLtw-1; Thu,
 03 Apr 2025 13:00:38 -0400
X-MC-Unique: eVZOmO88OVGc6mHlT0fLtw-1
X-Mimecast-MFC-AGG-ID: eVZOmO88OVGc6mHlT0fLtw_1743699631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EC10180025C; Thu,  3 Apr 2025 17:00:31 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46601195609D; Thu,  3 Apr 2025 17:00:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Gagandeep Singh <g.singh@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Jerin Jacob <jerinj@marvell.com>, Elena Agostini <eagostini@nvidia.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Gaetan Rivet <grive@u256.net>, Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v7 7/8] build: remove static version maps
Date: Thu,  3 Apr 2025 18:58:36 +0200
Message-ID: <20250403165845.1315380-8-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LfDs87DzkBFukhBBMq5jR7Ltg6DqOxCJIpg5lnfnzZ8_1743699631
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Now that all version map files get generated, we can delete all
committed files.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v3:
- fixed devtools/check-spdx-tag.sh,

---
 devtools/check-spdx-tag.sh                 |   2 +-
 drivers/baseband/acc/version.map           |  10 -
 drivers/baseband/fpga_5gnr_fec/version.map |  11 -
 drivers/baseband/fpga_lte_fec/version.map  |  10 -
 drivers/bus/auxiliary/version.map          |   8 -
 drivers/bus/cdx/version.map                |  14 -
 drivers/bus/dpaa/version.map               | 108 ----
 drivers/bus/fslmc/version.map              | 127 -----
 drivers/bus/ifpga/version.map              |   9 -
 drivers/bus/pci/version.map                |  43 --
 drivers/bus/platform/version.map           |  10 -
 drivers/bus/uacce/version.map              |  15 -
 drivers/bus/vdev/version.map               |  17 -
 drivers/bus/vmbus/version.map              |  33 --
 drivers/common/cnxk/version.map            | 576 ---------------------
 drivers/common/cpt/version.map             |  11 -
 drivers/common/dpaax/version.map           |  25 -
 drivers/common/ionic/version.map           |  10 -
 drivers/common/mlx5/version.map            | 175 -------
 drivers/common/mvep/version.map            |   8 -
 drivers/common/nfp/version.map             |  16 -
 drivers/common/nitrox/version.map          |  10 -
 drivers/common/octeontx/version.map        |  12 -
 drivers/common/sfc_efx/version.map         | 302 -----------
 drivers/crypto/cnxk/version.map            |  30 --
 drivers/crypto/dpaa2_sec/version.map       |   8 -
 drivers/crypto/dpaa_sec/version.map        |   8 -
 drivers/crypto/octeontx/version.map        |  12 -
 drivers/crypto/scheduler/version.map       |  16 -
 drivers/dma/cnxk/version.map               |  10 -
 drivers/event/cnxk/version.map             |  11 -
 drivers/event/dlb2/version.map             |  10 -
 drivers/mempool/cnxk/version.map           |  12 -
 drivers/mempool/dpaa/version.map           |   8 -
 drivers/mempool/dpaa2/version.map          |  16 -
 drivers/net/atlantic/version.map           |  15 -
 drivers/net/bnxt/version.map               |  22 -
 drivers/net/bonding/version.map            |  33 --
 drivers/net/cnxk/version.map               |  27 -
 drivers/net/dpaa/version.map               |  14 -
 drivers/net/dpaa2/version.map              |  35 --
 drivers/net/intel/i40e/version.map         |  55 --
 drivers/net/intel/iavf/version.map         |  33 --
 drivers/net/intel/ice/version.map          |  16 -
 drivers/net/intel/idpf/version.map         |  80 ---
 drivers/net/intel/ipn3ke/version.map       |   9 -
 drivers/net/intel/ixgbe/version.map        |  49 --
 drivers/net/mlx5/version.map               |  28 -
 drivers/net/octeontx/version.map           |   7 -
 drivers/net/ring/version.map               |   8 -
 drivers/net/softnic/version.map            |   8 -
 drivers/net/vhost/version.map              |   8 -
 drivers/power/kvm_vm/version.map           |   8 -
 drivers/raw/cnxk_rvu_lf/version.map        |  16 -
 drivers/raw/ifpga/version.map              |  17 -
 lib/acl/version.map                        |  19 -
 lib/argparse/version.map                   |   9 -
 lib/bbdev/version.map                      |  47 --
 lib/bitratestats/version.map               |  10 -
 lib/bpf/version.map                        |  18 -
 lib/cfgfile/version.map                    |  23 -
 lib/cmdline/version.map                    |  82 ---
 lib/compressdev/version.map                |  40 --
 lib/cryptodev/version.map                  | 114 ----
 lib/dispatcher/version.map                 |  20 -
 lib/distributor/version.map                |  15 -
 lib/dmadev/version.map                     |  47 --
 lib/eal/version.map                        | 451 ----------------
 lib/efd/version.map                        |  13 -
 lib/ethdev/version.map                     | 378 --------------
 lib/eventdev/version.map                   | 167 ------
 lib/fib/version.map                        |  31 --
 lib/gpudev/version.map                     |  44 --
 lib/graph/version.map                      |  44 --
 lib/gro/version.map                        |  12 -
 lib/gso/version.map                        |   7 -
 lib/hash/version.map                       |  66 ---
 lib/ip_frag/version.map                    |  16 -
 lib/ipsec/version.map                      |  19 -
 lib/jobstats/version.map                   |  20 -
 lib/kvargs/version.map                     |  14 -
 lib/latencystats/version.map               |  11 -
 lib/log/version.map                        |  36 --
 lib/lpm/version.map                        |  24 -
 lib/mbuf/version.map                       |  45 --
 lib/member/version.map                     |  19 -
 lib/mempool/version.map                    |  65 ---
 lib/meter/version.map                      |  12 -
 lib/metrics/version.map                    |  26 -
 lib/mldev/version.map                      |  74 ---
 lib/net/version.map                        |  23 -
 lib/node/version.map                       |  25 -
 lib/pcapng/version.map                     |  13 -
 lib/pci/version.map                        |   9 -
 lib/pdcp/version.map                       |  12 -
 lib/pdump/version.map                      |  15 -
 lib/pipeline/version.map                   | 172 ------
 lib/port/version.map                       |  50 --
 lib/power/version.map                      |  71 ---
 lib/rawdev/version.map                     |  36 --
 lib/rcu/version.map                        |  17 -
 lib/regexdev/version.map                   |  38 --
 lib/reorder/version.map                    |  27 -
 lib/rib/version.map                        |  34 --
 lib/ring/version.map                       |  42 --
 lib/sched/version.map                      |  30 --
 lib/security/version.map                   |  37 --
 lib/stack/version.map                      |   9 -
 lib/table/version.map                      |  53 --
 lib/telemetry/version.map                  |  40 --
 lib/timer/version.map                      |  24 -
 lib/vhost/version.map                      | 110 ----
 112 files changed, 1 insertion(+), 5115 deletions(-)
 delete mode 100644 drivers/baseband/acc/version.map
 delete mode 100644 drivers/baseband/fpga_5gnr_fec/version.map
 delete mode 100644 drivers/baseband/fpga_lte_fec/version.map
 delete mode 100644 drivers/bus/auxiliary/version.map
 delete mode 100644 drivers/bus/cdx/version.map
 delete mode 100644 drivers/bus/dpaa/version.map
 delete mode 100644 drivers/bus/fslmc/version.map
 delete mode 100644 drivers/bus/ifpga/version.map
 delete mode 100644 drivers/bus/pci/version.map
 delete mode 100644 drivers/bus/platform/version.map
 delete mode 100644 drivers/bus/uacce/version.map
 delete mode 100644 drivers/bus/vdev/version.map
 delete mode 100644 drivers/bus/vmbus/version.map
 delete mode 100644 drivers/common/cnxk/version.map
 delete mode 100644 drivers/common/cpt/version.map
 delete mode 100644 drivers/common/dpaax/version.map
 delete mode 100644 drivers/common/ionic/version.map
 delete mode 100644 drivers/common/mlx5/version.map
 delete mode 100644 drivers/common/mvep/version.map
 delete mode 100644 drivers/common/nfp/version.map
 delete mode 100644 drivers/common/nitrox/version.map
 delete mode 100644 drivers/common/octeontx/version.map
 delete mode 100644 drivers/common/sfc_efx/version.map
 delete mode 100644 drivers/crypto/cnxk/version.map
 delete mode 100644 drivers/crypto/dpaa2_sec/version.map
 delete mode 100644 drivers/crypto/dpaa_sec/version.map
 delete mode 100644 drivers/crypto/octeontx/version.map
 delete mode 100644 drivers/crypto/scheduler/version.map
 delete mode 100644 drivers/dma/cnxk/version.map
 delete mode 100644 drivers/event/cnxk/version.map
 delete mode 100644 drivers/event/dlb2/version.map
 delete mode 100644 drivers/mempool/cnxk/version.map
 delete mode 100644 drivers/mempool/dpaa/version.map
 delete mode 100644 drivers/mempool/dpaa2/version.map
 delete mode 100644 drivers/net/atlantic/version.map
 delete mode 100644 drivers/net/bnxt/version.map
 delete mode 100644 drivers/net/bonding/version.map
 delete mode 100644 drivers/net/cnxk/version.map
 delete mode 100644 drivers/net/dpaa/version.map
 delete mode 100644 drivers/net/dpaa2/version.map
 delete mode 100644 drivers/net/intel/i40e/version.map
 delete mode 100644 drivers/net/intel/iavf/version.map
 delete mode 100644 drivers/net/intel/ice/version.map
 delete mode 100644 drivers/net/intel/idpf/version.map
 delete mode 100644 drivers/net/intel/ipn3ke/version.map
 delete mode 100644 drivers/net/intel/ixgbe/version.map
 delete mode 100644 drivers/net/mlx5/version.map
 delete mode 100644 drivers/net/octeontx/version.map
 delete mode 100644 drivers/net/ring/version.map
 delete mode 100644 drivers/net/softnic/version.map
 delete mode 100644 drivers/net/vhost/version.map
 delete mode 100644 drivers/power/kvm_vm/version.map
 delete mode 100644 drivers/raw/cnxk_rvu_lf/version.map
 delete mode 100644 drivers/raw/ifpga/version.map
 delete mode 100644 lib/acl/version.map
 delete mode 100644 lib/argparse/version.map
 delete mode 100644 lib/bbdev/version.map
 delete mode 100644 lib/bitratestats/version.map
 delete mode 100644 lib/bpf/version.map
 delete mode 100644 lib/cfgfile/version.map
 delete mode 100644 lib/cmdline/version.map
 delete mode 100644 lib/compressdev/version.map
 delete mode 100644 lib/cryptodev/version.map
 delete mode 100644 lib/dispatcher/version.map
 delete mode 100644 lib/distributor/version.map
 delete mode 100644 lib/dmadev/version.map
 delete mode 100644 lib/eal/version.map
 delete mode 100644 lib/efd/version.map
 delete mode 100644 lib/ethdev/version.map
 delete mode 100644 lib/eventdev/version.map
 delete mode 100644 lib/fib/version.map
 delete mode 100644 lib/gpudev/version.map
 delete mode 100644 lib/graph/version.map
 delete mode 100644 lib/gro/version.map
 delete mode 100644 lib/gso/version.map
 delete mode 100644 lib/hash/version.map
 delete mode 100644 lib/ip_frag/version.map
 delete mode 100644 lib/ipsec/version.map
 delete mode 100644 lib/jobstats/version.map
 delete mode 100644 lib/kvargs/version.map
 delete mode 100644 lib/latencystats/version.map
 delete mode 100644 lib/log/version.map
 delete mode 100644 lib/lpm/version.map
 delete mode 100644 lib/mbuf/version.map
 delete mode 100644 lib/member/version.map
 delete mode 100644 lib/mempool/version.map
 delete mode 100644 lib/meter/version.map
 delete mode 100644 lib/metrics/version.map
 delete mode 100644 lib/mldev/version.map
 delete mode 100644 lib/net/version.map
 delete mode 100644 lib/node/version.map
 delete mode 100644 lib/pcapng/version.map
 delete mode 100644 lib/pci/version.map
 delete mode 100644 lib/pdcp/version.map
 delete mode 100644 lib/pdump/version.map
 delete mode 100644 lib/pipeline/version.map
 delete mode 100644 lib/port/version.map
 delete mode 100644 lib/power/version.map
 delete mode 100644 lib/rawdev/version.map
 delete mode 100644 lib/rcu/version.map
 delete mode 100644 lib/regexdev/version.map
 delete mode 100644 lib/reorder/version.map
 delete mode 100644 lib/rib/version.map
 delete mode 100644 lib/ring/version.map
 delete mode 100644 lib/sched/version.map
 delete mode 100644 lib/security/version.map
 delete mode 100644 lib/stack/version.map
 delete mode 100644 lib/table/version.map
 delete mode 100644 lib/telemetry/version.map
 delete mode 100644 lib/timer/version.map
 delete mode 100644 lib/vhost/version.map

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index a76c17bc3a..1fd0d579d3 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -19,7 +19,7 @@ no_license_list=\
 ':^.git* :^.mailmap :^.ci/* :^README :^*/README* :^MAINTAINERS :^VERSION :^ABI_VERSION '\
 ':^license/ :^config/ :^buildtools/ :^*.abignore :^*.cocci :^*/poetry.lock '\
 ':^*/Kbuild :^kernel/linux/uapi/version '\
-':^*.map :^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.svg :^*.png'
+':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.svg :^*.png'
 
 check_spdx() {
     if $verbose ; then
diff --git a/drivers/baseband/acc/version.map b/drivers/baseband/acc/version.map
deleted file mode 100644
index 3f427caf67..0000000000
--- a/drivers/baseband/acc/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 22.11
-	rte_acc_configure;
-};
diff --git a/drivers/baseband/fpga_5gnr_fec/version.map b/drivers/baseband/fpga_5gnr_fec/version.map
deleted file mode 100644
index fb32805028..0000000000
--- a/drivers/baseband/fpga_5gnr_fec/version.map
+++ /dev/null
@@ -1,11 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_fpga_5gnr_fec_configure;
-
-};
diff --git a/drivers/baseband/fpga_lte_fec/version.map b/drivers/baseband/fpga_lte_fec/version.map
deleted file mode 100644
index f6b2961ba2..0000000000
--- a/drivers/baseband/fpga_lte_fec/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_fpga_lte_fec_configure;
-};
diff --git a/drivers/bus/auxiliary/version.map b/drivers/bus/auxiliary/version.map
deleted file mode 100644
index e9322e0b11..0000000000
--- a/drivers/bus/auxiliary/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_auxiliary_register;
-	rte_auxiliary_unregister;
-
-	local: *;
-};
diff --git a/drivers/bus/cdx/version.map b/drivers/bus/cdx/version.map
deleted file mode 100644
index 7a22cf5b4b..0000000000
--- a/drivers/bus/cdx/version.map
+++ /dev/null
@@ -1,14 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_cdx_map_device;
-	rte_cdx_register;
-	rte_cdx_unmap_device;
-	rte_cdx_unregister;
-	rte_cdx_vfio_bm_disable;
-	rte_cdx_vfio_bm_enable;
-	rte_cdx_vfio_intr_disable;
-	rte_cdx_vfio_intr_enable;
-
-	local: *;
-};
diff --git a/drivers/bus/dpaa/version.map b/drivers/bus/dpaa/version.map
deleted file mode 100644
index 8f09b72757..0000000000
--- a/drivers/bus/dpaa/version.map
+++ /dev/null
@@ -1,108 +0,0 @@
-INTERNAL {
-	global:
-
-	bman_acquire;
-	bman_free_pool;
-	bman_get_params;
-	bman_new_pool;
-	bman_query_free_buffers;
-	bman_release;
-	bman_thread_irq;
-	dpaa_get_ioctl_version_number;
-	dpaa_get_eth_port_cfg;
-	dpaa_get_qm_channel_caam;
-	dpaa_get_qm_channel_pool;
-	dpaa_get_link_status;
-	dpaa_restart_link_autoneg;
-	dpaa_seqn_dynfield_offset;
-	dpaa_update_link_speed;
-	dpaa_intr_disable;
-	dpaa_intr_enable;
-	dpaa_svr_family;
-	dpaa_update_link_status;
-	fman_dealloc_bufs_mask_hi;
-	fman_dealloc_bufs_mask_lo;
-	fman_if_add_mac_addr;
-	fman_if_bmi_stats_enable;
-	fman_if_bmi_stats_disable;
-	fman_if_bmi_stats_get_all;
-	fman_if_bmi_stats_reset;
-	fman_if_clear_mac_addr;
-	fman_if_disable_rx;
-	fman_if_discard_rx_errors;
-	fman_if_enable_rx;
-	fman_if_get_fc_quanta;
-	fman_if_get_fc_threshold;
-	fman_if_get_fdoff;
-	fman_if_get_maxfrm;
-	fman_if_get_sg_enable;
-	fman_if_get_rx_status;
-	fman_if_loopback_disable;
-	fman_if_loopback_enable;
-	fman_if_promiscuous_disable;
-	fman_if_promiscuous_enable;
-	fman_if_reset_mcast_filter_table;
-	fman_if_set_bp;
-	fman_if_set_err_fqid;
-	fman_if_set_fc_quanta;
-	fman_if_set_fc_threshold;
-	fman_if_set_fdoff;
-	fman_if_set_ic_params;
-	fman_if_set_maxfrm;
-	fman_if_set_mcast_filter_table;
-	fman_if_set_sg;
-	fman_if_stats_get;
-	fman_if_stats_get_all;
-	fman_if_stats_reset;
-	fman_ip_rev;
-	fman_if_receive_rx_errors;
-	fsl_qman_fq_portal_create;
-	netcfg_acquire;
-	netcfg_release;
-	per_lcore_dpaa_io;
-	qman_alloc_cgrid_range;
-	qman_alloc_fqid_range;
-	qman_alloc_pool_range;
-	qman_clear_irq;
-	qman_create_cgr;
-	qman_create_fq;
-	qman_dca_index;
-	qman_delete_cgr;
-	qman_dequeue;
-	qman_dqrr_consume;
-	qman_enqueue;
-	qman_enqueue_multi;
-	qman_enqueue_multi_fq;
-	qman_ern_poll_free;
-	qman_ern_register_cb;
-	qman_fq_fqid;
-	qman_fq_portal_irqsource_add;
-	qman_fq_portal_irqsource_remove;
-	qman_fq_portal_thread_irq;
-	qman_fq_state;
-	qman_init_fq;
-	qman_irqsource_add;
-	qman_irqsource_remove;
-	qman_modify_cgr;
-	qman_oos_fq;
-	qman_portal_dequeue;
-	qman_portal_poll_rx;
-	qman_query_fq_frm_cnt;
-	qman_query_fq_np;
-	qman_release_cgrid_range;
-	qman_reserve_fqid_range;
-	qman_retire_fq;
-	qman_set_fq_lookup_table;
-	qman_set_vdq;
-	qman_static_dequeue_add;
-	qman_thread_fd;
-	qman_thread_irq;
-	qman_volatile_dequeue;
-	rte_dpaa_driver_register;
-	rte_dpaa_driver_unregister;
-	rte_dpaa_portal_fq_close;
-	rte_dpaa_portal_fq_init;
-	rte_dpaa_portal_init;
-
-	local: *;
-};
diff --git a/drivers/bus/fslmc/version.map b/drivers/bus/fslmc/version.map
deleted file mode 100644
index ba3c7f36e3..0000000000
--- a/drivers/bus/fslmc/version.map
+++ /dev/null
@@ -1,127 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_fslmc_vfio_mem_dmamap;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	dpaa2_affine_qbman_ethrx_swp;
-	dpaa2_affine_qbman_swp;
-	dpaa2_alloc_dpbp_dev;
-	dpaa2_alloc_dq_storage;
-	dpaa2_dpbp_supported;
-	dpaa2_dqrr_size;
-	dpaa2_eqcr_size;
-	dpaa2_free_dpbp_dev;
-	dpaa2_free_dq_storage;
-	dpaa2_free_eq_descriptors;
-	dpaa2_get_mcp_ptr;
-	dpaa2_io_portal;
-	dpaa2_seqn_dynfield_offset;
-	dpaa2_svr_family;
-	dpbp_disable;
-	dpbp_enable;
-	dpbp_get_attributes;
-	dpbp_get_num_free_bufs;
-	dpbp_open;
-	dpbp_reset;
-	dpci_get_opr;
-	dpci_set_opr;
-	dpci_set_rx_queue;
-	dpcon_get_attributes;
-	dpcon_open;
-	dpcon_close;
-	dpcon_reset;
-	dpcon_enable;
-	dpcon_disable;
-	dpdmai_close;
-	dpdmai_disable;
-	dpdmai_enable;
-	dpdmai_get_attributes;
-	dpdmai_get_rx_queue;
-	dpdmai_get_tx_queue;
-	dpdmai_open;
-	dpdmai_set_rx_queue;
-	dpio_add_static_dequeue_channel;
-	dpio_close;
-	dpio_disable;
-	dpio_enable;
-	dpio_get_attributes;
-	dpio_open;
-	dpio_remove_static_dequeue_channel;
-	dpio_reset;
-	dpio_get_stashing_destination;
-	dpio_get_stashing_destination_source;
-	dpio_set_stashing_destination;
-	dpio_set_stashing_destination_by_core_id;
-	dpio_set_stashing_destination_source;
-	mc_get_soc_version;
-	mc_get_version;
-	mc_send_command;
-	per_lcore__dpaa2_io;
-	qbman_check_command_complete;
-	qbman_check_new_result;
-	qbman_eq_desc_clear;
-	qbman_eq_desc_set_dca;
-	qbman_eq_desc_set_fq;
-	qbman_eq_desc_set_no_orp;
-	qbman_eq_desc_set_orp;
-	qbman_eq_desc_set_qd;
-	qbman_eq_desc_set_response;
-	qbman_eq_desc_set_token;
-	qbman_fq_query_state;
-	qbman_fq_state_frame_count;
-	qbman_get_dqrr_from_idx;
-	qbman_get_dqrr_idx;
-	qbman_pull_desc_clear;
-	qbman_pull_desc_set_fq;
-	qbman_pull_desc_set_numframes;
-	qbman_pull_desc_set_storage;
-	qbman_release_desc_clear;
-	qbman_release_desc_set_bpid;
-	qbman_result_DQ_fd;
-	qbman_result_DQ_flags;
-	qbman_result_DQ_fqd_ctx;
-	qbman_result_DQ_odpid;
-	qbman_result_DQ_seqnum;
-	qbman_result_SCN_state;
-	qbman_result_eqresp_fd;
-	qbman_result_eqresp_rc;
-	qbman_result_eqresp_rspid;
-	qbman_result_eqresp_set_rspid;
-	qbman_result_has_new_result;
-	qbman_swp_acquire;
-	qbman_swp_dqrr_consume;
-	qbman_swp_dqrr_idx_consume;
-	qbman_swp_dqrr_next;
-	qbman_swp_enqueue_multiple;
-	qbman_swp_enqueue_multiple_desc;
-	qbman_swp_enqueue_multiple_fd;
-	qbman_swp_interrupt_clear_status;
-	qbman_swp_prefetch_dqrr_next;
-	qbman_swp_pull;
-	qbman_swp_push_set;
-	qbman_swp_release;
-	rte_dpaa2_alloc_dpci_dev;
-	rte_dpaa2_free_dpci_dev;
-	rte_dpaa2_intr_disable;
-	rte_dpaa2_intr_enable;
-	rte_fslmc_driver_register;
-	rte_fslmc_driver_unregister;
-	rte_fslmc_get_device_count;
-	rte_fslmc_object_register;
-	rte_global_active_dqs_list;
-	rte_fslmc_vfio_mem_dmaunmap;
-	rte_fslmc_cold_mem_vaddr_to_iova;
-	rte_fslmc_cold_mem_iova_to_vaddr;
-	rte_fslmc_mem_vaddr_to_iova;
-	rte_fslmc_mem_iova_to_vaddr;
-	rte_fslmc_io_vaddr_to_iova;
-	rte_fslmc_io_iova_to_vaddr;
-
-	local: *;
-};
diff --git a/drivers/bus/ifpga/version.map b/drivers/bus/ifpga/version.map
deleted file mode 100644
index 3d1943afe4..0000000000
--- a/drivers/bus/ifpga/version.map
+++ /dev/null
@@ -1,9 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_ifpga_driver_register;
-	rte_ifpga_driver_unregister;
-	rte_ifpga_find_afu_by_name;
-
-	local: *;
-};
diff --git a/drivers/bus/pci/version.map b/drivers/bus/pci/version.map
deleted file mode 100644
index cd653de5ac..0000000000
--- a/drivers/bus/pci/version.map
+++ /dev/null
@@ -1,43 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pci_dump;
-	rte_pci_ioport_map;
-	rte_pci_ioport_read;
-	rte_pci_ioport_unmap;
-	rte_pci_ioport_write;
-	rte_pci_map_device;
-	rte_pci_read_config;
-	rte_pci_unmap_device;
-	rte_pci_write_config;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_pci_find_ext_capability;
-
-	# added in 21.08
-	rte_pci_set_bus_master;
-
-	# added in 23.07
-	rte_pci_mmio_read;
-	rte_pci_mmio_write;
-
-	# added in 23.11
-	rte_pci_find_capability;
-	rte_pci_find_next_capability;
-	rte_pci_has_capability_list;
-};
-
-INTERNAL {
-	global:
-
-	rte_pci_get_sysfs_path;
-	rte_pci_pasid_set_state;
-	rte_pci_register;
-	rte_pci_unregister;
-};
diff --git a/drivers/bus/platform/version.map b/drivers/bus/platform/version.map
deleted file mode 100644
index 37c4a74f82..0000000000
--- a/drivers/bus/platform/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_platform_register;
-	rte_platform_unregister;
-};
diff --git a/drivers/bus/uacce/version.map b/drivers/bus/uacce/version.map
deleted file mode 100644
index 533b2ea0d8..0000000000
--- a/drivers/bus/uacce/version.map
+++ /dev/null
@@ -1,15 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_uacce_avail_queues;
-	rte_uacce_queue_alloc;
-	rte_uacce_queue_free;
-	rte_uacce_queue_ioctl;
-	rte_uacce_queue_mmap;
-	rte_uacce_queue_start;
-	rte_uacce_queue_unmap;
-	rte_uacce_register;
-	rte_uacce_unregister;
-
-	local: *;
-};
diff --git a/drivers/bus/vdev/version.map b/drivers/bus/vdev/version.map
deleted file mode 100644
index 51a0f1d5e1..0000000000
--- a/drivers/bus/vdev/version.map
+++ /dev/null
@@ -1,17 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_vdev_add_custom_scan;
-	rte_vdev_init;
-	rte_vdev_remove_custom_scan;
-	rte_vdev_uninit;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_vdev_register;
-	rte_vdev_unregister;
-};
diff --git a/drivers/bus/vmbus/version.map b/drivers/bus/vmbus/version.map
deleted file mode 100644
index 365f71529f..0000000000
--- a/drivers/bus/vmbus/version.map
+++ /dev/null
@@ -1,33 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_vmbus_chan_close;
-	rte_vmbus_chan_open;
-	rte_vmbus_chan_recv;
-	rte_vmbus_chan_recv_raw;
-	rte_vmbus_chan_rx_empty;
-	rte_vmbus_chan_send;
-	rte_vmbus_chan_send_sglist;
-	rte_vmbus_chan_signal_read;
-	rte_vmbus_chan_signal_tx;
-	rte_vmbus_irq_mask;
-	rte_vmbus_irq_read;
-	rte_vmbus_irq_unmask;
-	rte_vmbus_map_device;
-	rte_vmbus_max_channels;
-	rte_vmbus_probe;
-	rte_vmbus_scan;
-	rte_vmbus_set_latency;
-	rte_vmbus_sub_channel_index;
-	rte_vmbus_subchan_open;
-	rte_vmbus_unmap_device;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_vmbus_register;
-	rte_vmbus_unregister;
-};
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
deleted file mode 100644
index 7f40dcced2..0000000000
--- a/drivers/common/cnxk/version.map
+++ /dev/null
@@ -1,576 +0,0 @@
-INTERNAL {
-	global:
-
-	cnxk_ipsec_icvlen_get;
-	cnxk_ipsec_ivlen_get;
-	cnxk_ipsec_outb_rlens_get;
-	cnxk_ipsec_outb_roundup_byte;
-	cnxk_logtype_base;
-	cnxk_logtype_cpt;
-	cnxk_logtype_dpi;
-	cnxk_logtype_esw;
-	cnxk_logtype_mbox;
-	cnxk_logtype_ml;
-	cnxk_logtype_nix;
-	cnxk_logtype_npa;
-	cnxk_logtype_npc;
-	cnxk_logtype_ree;
-	cnxk_logtype_rep;
-	cnxk_logtype_sso;
-	cnxk_logtype_tim;
-	cnxk_logtype_tm;
-	cnxk_ot_ipsec_inb_sa_fill;
-	cnxk_ot_ipsec_outb_sa_fill;
-	cnxk_ot_ipsec_inb_sa_valid;
-	cnxk_ot_ipsec_outb_sa_valid;
-	cnxk_ow_ipsec_inb_sa_fill;
-	cnxk_ow_ipsec_outb_sa_fill;
-	cnxk_on_ipsec_inb_sa_create;
-	cnxk_on_ipsec_outb_sa_create;
-	roc_ae_ec_grp_get;
-	roc_ae_ec_grp_put;
-	roc_ae_fpm_get;
-	roc_ae_fpm_put;
-	roc_aes_hash_key_derive;
-	roc_aes_xcbc_key_derive;
-	roc_bphy_cgx_cpri_mode_change;
-	roc_bphy_cgx_cpri_mode_misc;
-	roc_bphy_cgx_cpri_mode_tx_control;
-	roc_bphy_cgx_dev_fini;
-	roc_bphy_cgx_dev_init;
-	roc_bphy_cgx_fec_set;
-	roc_bphy_cgx_fec_supported_get;
-	roc_bphy_cgx_get_linkinfo;
-	roc_bphy_cgx_intlbk_disable;
-	roc_bphy_cgx_intlbk_enable;
-	roc_bphy_cgx_ptp_rx_disable;
-	roc_bphy_cgx_ptp_rx_enable;
-	roc_bphy_cgx_set_link_mode;
-	roc_bphy_cgx_set_link_state;
-	roc_bphy_cgx_start_rxtx;
-	roc_bphy_cgx_stop_rxtx;
-	roc_bphy_dev_fini;
-	roc_bphy_dev_init;
-	roc_bphy_intr_available;
-	roc_bphy_intr_clear;
-	roc_bphy_intr_fini;
-	roc_bphy_intr_handler;
-	roc_bphy_intr_init;
-	roc_bphy_intr_max_get;
-	roc_bphy_intr_register;
-	roc_bphy_npa_pf_func_get;
-	roc_bphy_sso_pf_func_get;
-	roc_clk_freq_get;
-	roc_cpt_afs_print;
-	roc_cpt_dev_clear;
-	roc_cpt_dev_configure;
-	roc_cpt_dev_fini;
-	roc_cpt_dev_init;
-	roc_cpt_eng_grp_add;
-	roc_cpt_inline_ipsec_cfg;
-	roc_cpt_inline_ipsec_inb_cfg_read;
-	roc_cpt_inline_ipsec_inb_cfg;
-	roc_cpt_iq_disable;
-	roc_cpt_iq_enable;
-	roc_cpt_lf_ctx_flush;
-	roc_cpt_lf_ctx_reload;
-	roc_cpt_lf_init;
-	roc_cpt_lf_fini;
-	roc_cpt_lf_reset;
-	roc_cpt_lfs_print;
-	roc_cpt_lmtline_init;
-	roc_cpt_parse_hdr_dump;
-	roc_cpt_rxc_time_cfg;
-	roc_cpt_ctx_write;
-	roc_cpt_int_misc_cb_register;
-	roc_cpt_int_misc_cb_unregister;
-	roc_dpi_configure;
-	roc_dpi_configure_v2;
-	roc_dpi_dev_fini;
-	roc_dpi_dev_init;
-	roc_dpi_disable;
-	roc_dpi_enable;
-	roc_dpi_wait_queue_idle;
-	roc_error_msg_get;
-	roc_eswitch_is_repte_pfs_vf;
-	roc_eswitch_nix_process_repte_notify_cb_register;
-	roc_eswitch_nix_process_repte_notify_cb_unregister;
-	roc_eswitch_nix_repte_stats;
-	roc_eswitch_nix_vlan_tpid_set;
-	roc_eswitch_npc_mcam_delete_rule;
-	roc_eswitch_npc_mcam_rx_rule;
-	roc_eswitch_npc_mcam_tx_rule;
-	roc_eswitch_npc_rss_action_configure;
-	roc_hash_md5_gen;
-	roc_hash_sha1_gen;
-	roc_hash_sha256_gen;
-	roc_hash_sha512_gen;
-	roc_idev_cpt_get;
-	roc_idev_cpt_set;
-	roc_idev_lmt_base_addr_get;
-	roc_idev_mcs_free;
-	roc_idev_mcs_get;
-	roc_idev_mcs_set;
-	roc_idev_npa_maxpools_get;
-	roc_idev_npa_maxpools_set;
-	roc_idev_npa_nix_get;
-	roc_idev_num_lmtlines_get;
-	roc_idev_nix_inl_meta_aura_get;
-	roc_idev_nix_inl_dev_pffunc_get;
-	roc_idev_nix_list_get;
-	roc_idev_nix_rx_chan_base_get;
-	roc_idev_nix_rx_chan_set;
-	roc_idev_nix_rx_inject_get;
-	roc_idev_nix_rx_inject_set;
-	roc_idev_rvu_lf_free;
-	roc_idev_rvu_lf_get;
-	roc_idev_rvu_lf_set;
-	roc_ml_reg_read64;
-	roc_ml_reg_write64;
-	roc_ml_reg_read32;
-	roc_ml_reg_write32;
-	roc_ml_reg_save;
-	roc_ml_addr_ap2mlip;
-	roc_ml_addr_mlip2ap;
-	roc_ml_addr_pa_to_offset;
-	roc_ml_addr_offset_to_pa;
-	roc_ml_scratch_write_job;
-	roc_ml_scratch_is_valid_bit_set;
-	roc_ml_scratch_is_done_bit_set;
-	roc_ml_scratch_enqueue;
-	roc_ml_scratch_dequeue;
-	roc_ml_scratch_queue_reset;
-	roc_ml_jcmdq_enqueue_lf;
-	roc_ml_jcmdq_enqueue_sl;
-	roc_ml_clk_force_on;
-	roc_ml_clk_force_off;
-	roc_ml_dma_stall_on;
-	roc_ml_dma_stall_off;
-	roc_ml_mlip_is_enabled;
-	roc_ml_mlip_reset;
-	roc_ml_dev_init;
-	roc_ml_dev_fini;
-	roc_ml_blk_init;
-	roc_ml_blk_fini;
-	roc_ml_sso_pf_func_get;
-	roc_model;
-	roc_se_auth_key_set;
-	roc_se_ciph_key_set;
-	roc_se_ctx_init;
-	roc_mcs_active_lmac_set;
-	roc_mcs_ctrl_pkt_rule_alloc;
-	roc_mcs_ctrl_pkt_rule_free;
-	roc_mcs_ctrl_pkt_rule_write;
-	roc_mcs_custom_tag_cfg_get;
-	roc_mcs_dev_init;
-	roc_mcs_dev_fini;
-	roc_mcs_event_cb_register;
-	roc_mcs_event_cb_unregister;
-	roc_mcs_flowid_entry_enable;
-	roc_mcs_flowid_entry_read;
-	roc_mcs_flowid_entry_write;
-	roc_mcs_flowid_stats_get;
-	roc_mcs_hw_info_get;
-	roc_mcs_intr_configure;
-	roc_mcs_is_supported;
-	roc_mcs_lmac_mode_set;
-	roc_mcs_pn_table_write;
-	roc_mcs_pn_table_read;
-	roc_mcs_pn_threshold_set;
-	roc_mcs_port_cfg_get;
-	roc_mcs_port_cfg_set;
-	roc_mcs_port_recovery;
-	roc_mcs_port_reset;
-	roc_mcs_port_stats_get;
-	roc_mcs_rsrc_alloc;
-	roc_mcs_rsrc_free;
-	roc_mcs_rx_sc_cam_enable;
-	roc_mcs_rx_sc_cam_read;
-	roc_mcs_rx_sc_cam_write;
-	roc_mcs_rx_sc_sa_map_read;
-	roc_mcs_rx_sc_sa_map_write;
-	roc_mcs_sa_policy_read;
-	roc_mcs_sa_policy_write;
-	roc_mcs_sa_port_map_update;
-	roc_mcs_sc_stats_get;
-	roc_mcs_secy_policy_read;
-	roc_mcs_secy_policy_write;
-	roc_mcs_secy_stats_get;
-	roc_mcs_stats_clear;
-	roc_mcs_tx_sc_sa_map_read;
-	roc_mcs_tx_sc_sa_map_write;
-	roc_nix_bpf_alloc;
-	roc_nix_bpf_config;
-	roc_nix_bpf_connect;
-	roc_nix_bpf_count_get;
-	roc_nix_bpf_dump;
-	roc_nix_bpf_ena_dis;
-	roc_nix_bpf_free;
-	roc_nix_bpf_free_all;
-	roc_nix_bpf_level_to_idx;
-	roc_nix_bpf_lf_stats_read;
-	roc_nix_bpf_lf_stats_reset;
-	roc_nix_bpf_pre_color_tbl_setup;
-	roc_nix_bpf_stats_read;
-	roc_nix_bpf_stats_reset;
-	roc_nix_bpf_stats_to_idx;
-	roc_nix_bpf_timeunit_get;
-	roc_nix_bpids_alloc;
-	roc_nix_bpids_free;
-	roc_nix_chan_bpid_set;
-	roc_nix_chan_count_get;
-	roc_nix_cq_dump;
-	roc_nix_cq_fini;
-	roc_nix_cq_head_tail_get;
-	roc_nix_cq_init;
-	roc_nix_cqe_dump;
-	roc_nix_dev_fini;
-	roc_nix_dev_init;
-	roc_nix_dump;
-	roc_nix_err_intr_ena_dis;
-	roc_nix_fc_config_get;
-	roc_nix_fc_config_set;
-	roc_nix_fc_mode_set;
-	roc_nix_fc_mode_get;
-	roc_nix_fc_npa_bp_cfg;
-	roc_nix_get_base_chan;
-	roc_nix_get_pf;
-	roc_nix_get_pf_func;
-	roc_nix_max_rep_count;
-	roc_nix_get_rx_chan_cnt;
-	roc_nix_get_vf;
-	roc_nix_get_vwqe_interval;
-	roc_nix_inl_cb_register;
-	roc_nix_inl_cb_unregister;
-	roc_nix_inl_ctx_write;
-	roc_nix_inl_dev_cpt_setup;
-	roc_nix_inl_dev_cpt_release;
-	roc_nix_inl_dev_dump;
-	roc_nix_inl_dev_fini;
-	roc_nix_inl_dev_init;
-	roc_nix_inl_dev_is_multi_channel;
-	roc_nix_inl_dev_is_probed;
-	roc_nix_inl_dev_stats_get;
-	roc_nix_inl_dev_stats_reset;
-	roc_nix_inl_dev_lock;
-	roc_nix_inl_dev_rq;
-	roc_nix_inl_dev_rq_get;
-	roc_nix_inl_dev_rq_put;
-	roc_nix_inl_dev_unlock;
-	roc_nix_inl_dev_xaq_realloc;
-	roc_nix_inl_eng_caps_get;
-	roc_nix_inl_inb_is_enabled;
-	roc_nix_inl_inb_init;
-	roc_nix_inl_inb_inj_lf_get;
-	roc_nix_inl_inb_rx_inject_enable;
-	roc_nix_inl_inb_sa_base_get;
-	roc_nix_inl_inb_sa_get;
-	roc_nix_inl_inb_spi_range;
-	roc_nix_inl_inb_sa_sz;
-	roc_nix_inl_inb_tag_update;
-	roc_nix_inl_inb_fini;
-	roc_nix_inl_inb_set;
-	roc_nix_inb_is_with_inl_dev;
-	roc_nix_inl_meta_aura_check;
-	roc_nix_inl_meta_pool_cb_register;
-	roc_nix_inl_custom_meta_pool_cb_register;
-	roc_nix_inb_mode_set;
-	roc_nix_inl_cpt_lf_stats_get;
-	roc_nix_inl_dev_qptr_get;
-	roc_nix_inl_outb_fini;
-	roc_nix_inl_outb_init;
-	roc_nix_inl_outb_lf_base_get;
-	roc_nix_inl_outb_sa_base_get;
-	roc_nix_inl_outb_sso_pffunc_get;
-	roc_nix_inl_outb_is_enabled;
-	roc_nix_inl_outb_ring_base_get;
-	roc_nix_inl_outb_soft_exp_poll_switch;
-	roc_nix_inl_rq_ena_dis;
-	roc_nix_inl_sa_sync;
-	roc_nix_inl_ts_pkind_set;
-	roc_nix_inl_outb_cpt_lfs_dump;
-	roc_nix_cpt_ctx_cache_sync;
-	roc_nix_is_lbk;
-	roc_nix_is_esw;
-	roc_nix_is_pf;
-	roc_nix_is_sdp;
-	roc_nix_is_vf_or_sdp;
-	roc_nix_lf_alloc;
-	roc_nix_lf_inl_ipsec_cfg;
-	roc_nix_lf_free;
-	roc_nix_lf_get_reg_count;
-	roc_nix_lf_reg_dump;
-	roc_nix_lso_custom_fmt_setup;
-	roc_nix_lso_fmt_get;
-	roc_nix_lso_fmt_setup;
-	roc_nix_mac_addr_add;
-	roc_nix_mac_addr_del;
-	roc_nix_mac_addr_set;
-	roc_nix_mac_link_cb_register;
-	roc_nix_mac_link_cb_unregister;
-	roc_nix_mac_link_info_get_cb_register;
-	roc_nix_mac_link_info_get_cb_unregister;
-	roc_nix_mac_link_event_start_stop;
-	roc_nix_mac_link_info_get;
-	roc_nix_mac_link_info_set;
-	roc_nix_mac_link_state_set;
-	roc_nix_mac_loopback_enable;
-	roc_nix_mac_max_entries_get;
-	roc_nix_mac_max_rx_len_set;
-	roc_nix_mac_mtu_set;
-	roc_nix_mac_promisc_mode_enable;
-	roc_nix_mac_rxtx_start_stop;
-	roc_nix_mac_stats_reset;
-	roc_nix_max_pkt_len;
-	roc_nix_mcast_list_free;
-	roc_nix_mcast_list_setup;
-	roc_nix_mcast_mcam_entry_alloc;
-	roc_nix_mcast_mcam_entry_ena_dis;
-	roc_nix_mcast_mcam_entry_free;
-	roc_nix_mcast_mcam_entry_write;
-	roc_nix_npc_mac_addr_get;
-	roc_nix_npc_mac_addr_set;
-	roc_nix_npc_promisc_ena_dis;
-	roc_nix_npc_rx_ena_dis;
-	roc_nix_npc_mcast_config;
-	roc_nix_pfc_mode_get;
-	roc_nix_pfc_mode_set;
-	roc_nix_ptp_clock_read;
-	roc_nix_ptp_info_cb_register;
-	roc_nix_ptp_info_cb_unregister;
-	roc_nix_ptp_is_enable;
-	roc_nix_ptp_rx_ena_dis;
-	roc_nix_ptp_sync_time_adjust;
-	roc_nix_ptp_tx_ena_dis;
-	roc_nix_q_err_cb_register;
-	roc_nix_q_err_cb_unregister;
-	roc_nix_queues_ctx_dump;
-	roc_nix_ras_intr_ena_dis;
-	roc_nix_reassembly_configure;
-	roc_nix_register_cq_irqs;
-	roc_nix_register_queue_irqs;
-	roc_nix_rq_cman_config;
-	roc_nix_rq_dump;
-	roc_nix_rq_ena_dis;
-	roc_nix_rq_fini;
-	roc_nix_rq_init;
-	roc_nix_rq_is_sso_enable;
-	roc_nix_rq_modify;
-	roc_nix_rss_default_setup;
-	roc_nix_rss_flowkey_set;
-	roc_nix_rss_key_default_fill;
-	roc_nix_rss_key_get;
-	roc_nix_rss_key_set;
-	roc_nix_rss_reta_get;
-	roc_nix_rss_reta_set;
-	roc_nix_rx_chan_cfg_get;
-	roc_nix_rx_chan_cfg_set;
-	roc_nix_rx_drop_re_set;
-	roc_nix_rx_queue_intr_disable;
-	roc_nix_rx_queue_intr_enable;
-	roc_nix_sq_desc_dump;
-	roc_nix_sq_dump;
-	roc_nix_sq_ena_dis;
-	roc_nix_sq_fini;
-	roc_nix_sq_head_tail_get;
-	roc_nix_sq_init;
-	roc_nix_stats_get;
-	roc_nix_stats_queue_get;
-	roc_nix_stats_queue_reset;
-	roc_nix_stats_reset;
-	roc_nix_num_xstats_get;
-	roc_nix_xstats_get;
-	roc_nix_xstats_names_get;
-	roc_nix_switch_hdr_set;
-	roc_nix_eeprom_info_get;
-	roc_nix_smq_flush;
-	roc_nix_tm_egress_link_cfg_set;
-	roc_nix_tm_dump;
-	roc_nix_tm_err_to_rte_err;
-	roc_nix_tm_fini;
-	roc_nix_tm_free_resources;
-	roc_nix_tm_lvl_cnt_get;
-	roc_nix_tm_tree_type_get;
-	roc_nix_tm_hierarchy_disable;
-	roc_nix_tm_hierarchy_enable;
-	roc_nix_tm_hierarchy_xmit_enable;
-	roc_nix_tm_init;
-	roc_nix_tm_is_user_hierarchy_enabled;
-	roc_nix_tm_leaf_cnt;
-	roc_nix_tm_lvl_have_link_access;
-	roc_nix_tm_lvl_is_leaf;
-	roc_nix_tm_mark_config;
-	roc_nix_tm_mark_format_get;
-	roc_nix_tm_max_prio;
-	roc_nix_tm_node_add;
-	roc_nix_tm_node_delete;
-	roc_nix_tm_node_get;
-	roc_nix_tm_node_lvl;
-	roc_nix_tm_node_name_get;
-	roc_nix_tm_node_next;
-	roc_nix_tm_node_parent_update;
-	roc_nix_tm_node_pkt_mode_update;
-	roc_nix_tm_node_shaper_update;
-	roc_nix_tm_node_stats_get;
-	roc_nix_tm_node_suspend_resume;
-	roc_nix_tm_prealloc_res;
-	roc_nix_tm_pfc_prepare_tree;
-	roc_nix_tm_pfc_rlimit_sq;
-	roc_nix_tm_prepare_rate_limited_tree;
-	roc_nix_tm_rlimit_sq;
-	roc_nix_tm_root_has_sp;
-	roc_nix_tm_rsrc_count;
-	roc_nix_tm_rsrc_max;
-	roc_nix_tm_shaper_default_red_algo;
-	roc_nix_tm_shaper_profile_add;
-	roc_nix_tm_shaper_profile_delete;
-	roc_nix_tm_shaper_profile_get;
-	roc_nix_tm_shaper_profile_next;
-	roc_nix_tm_shaper_profile_update;
-	roc_nix_tm_sq_aura_fc;
-	roc_nix_tm_sq_flush_spin;
-	roc_nix_unregister_cq_irqs;
-	roc_nix_unregister_queue_irqs;
-	roc_nix_vlan_insert_ena_dis;
-	roc_nix_vlan_mcam_entry_alloc_and_write;
-	roc_nix_vlan_mcam_entry_ena_dis;
-	roc_nix_vlan_mcam_entry_free;
-	roc_nix_vlan_mcam_entry_read;
-	roc_nix_vlan_mcam_entry_write;
-	roc_nix_vlan_strip_vtag_ena_dis;
-	roc_nix_vlan_tpid_set;
-	roc_npa_aura_create;
-	roc_npa_aura_destroy;
-	roc_npa_buf_type_mask;
-	roc_npa_buf_type_limit_get;
-	roc_npa_buf_type_update;
-	roc_npa_aura_drop_set;
-	roc_npa_aura_limit_modify;
-	roc_npa_aura_op_range_get;
-	roc_npa_aura_op_range_set;
-	roc_npa_aura_bp_configure;
-	roc_npa_ctx_dump;
-	roc_npa_dev_fini;
-	roc_npa_dev_init;
-	roc_npa_dev_lock;
-	roc_npa_dev_unlock;
-	roc_npa_dump;
-	roc_npa_lf_init_cb_register;
-	roc_npa_pf_func_get;
-	roc_npa_pool_create;
-	roc_npa_pool_destroy;
-	roc_npa_pool_op_pc_reset;
-	roc_npa_pool_op_range_set;
-	roc_npa_pool_range_update_check;
-	roc_npa_zero_aura_handle;
-	roc_npc_aged_flow_ctx_get;
-	roc_npc_fini;
-	roc_npc_flow_create;
-	roc_npc_flow_destroy;
-	roc_npc_flow_dump;
-	roc_npc_flow_mcam_dump;
-	roc_npc_flow_parse;
-	roc_npc_get_free_mcam_entry;
-	roc_npc_get_low_priority_mcam;
-	roc_npc_init;
-	roc_npc_kex_capa_get;
-	roc_npc_mark_actions_get;
-	roc_npc_mark_actions_sub_return;
-	roc_npc_vtag_actions_get;
-	roc_npc_vtag_actions_sub_return;
-	roc_npc_mcam_alloc_counter;
-	roc_npc_mcam_alloc_entries;
-	roc_npc_mcam_alloc_entry;
-	roc_npc_mcam_clear_counter;
-	roc_npc_inl_mcam_clear_counter;
-	roc_npc_mcam_enable_all_entries;
-	roc_npc_mcam_ena_dis_entry;
-	roc_npc_mcam_free_all_resources;
-	roc_npc_mcam_free_counter;
-	roc_npc_mcam_free;
-	roc_npc_mcam_free_entry;
-	roc_npc_mcam_get_stats;
-	roc_npc_mcam_init;
-	roc_npc_mcam_move;
-	roc_npc_mcam_merge_base_steering_rule;
-	roc_npc_mcam_write_entry;
-	roc_npc_mcam_read_counter;
-	roc_npc_inl_mcam_read_counter;
-	roc_npc_profile_name_get;
-	roc_npc_sdp_channel_get;
-	roc_npc_validate_portid_action;
-	roc_ot_ipsec_inb_sa_init;
-	roc_ot_ipsec_outb_sa_init;
-	roc_ow_ipsec_inb_sa_init;
-	roc_ow_ipsec_outb_sa_init;
-	roc_ow_reass_inb_sa_init;
-	roc_plt_control_lmt_id_get;
-	roc_plt_init;
-	roc_plt_init_cb_register;
-	roc_plt_lmt_validate;
-	roc_se_hmac_opad_ipad_gen;
-	roc_sso_dev_fini;
-	roc_sso_dev_init;
-	roc_sso_dump;
-	roc_sso_hwgrp_agq_alloc;
-	roc_sso_hwgrp_agq_free;
-	roc_sso_hwgrp_agq_from_tag;
-	roc_sso_hwgrp_agq_release;
-	roc_sso_hwgrp_alloc_xaq;
-	roc_sso_hwgrp_base_get;
-	roc_sso_hwgrp_free_xaq_aura;
-	roc_sso_hwgrp_hws_link_status;
-	roc_sso_hwgrp_init_xaq_aura;
-	roc_sso_hwgrp_qos_config;
-	roc_sso_hwgrp_release_xaq;
-	roc_sso_hwgrp_set_priority;
-	roc_sso_hwgrp_stash_config;
-	roc_sso_hwgrp_stats_get;
-	roc_sso_hws_base_get;
-	roc_sso_hws_link;
-	roc_sso_hws_stats_get;
-	roc_sso_hws_gwc_invalidate;
-	roc_sso_hws_unlink;
-	roc_sso_ns_to_gw;
-	roc_sso_pf_func_get;
-	roc_sso_rsrc_fini;
-	roc_sso_rsrc_init;
-	roc_tim_fini;
-	roc_tim_init;
-	roc_tim_lf_alloc;
-	roc_tim_lf_base_get;
-	roc_tim_lf_config;
-	roc_tim_lf_config_hwwqe;
-	roc_tim_lf_disable;
-	roc_tim_lf_enable;
-	roc_tim_lf_free;
-	roc_tim_lf_interval;
-	roc_ree_af_reg_read;
-	roc_ree_af_reg_write;
-	roc_ree_config_lf;
-	roc_ree_dev_fini;
-	roc_ree_dev_init;
-	roc_ree_err_intr_register;
-	roc_ree_err_intr_unregister;
-	roc_ree_iq_disable;
-	roc_ree_iq_enable;
-	roc_ree_msix_offsets_get;
-	roc_ree_qp_get_base;
-	roc_ree_queues_attach;
-	roc_ree_queues_detach;
-	roc_ree_rule_db_get;
-	roc_ree_rule_db_len_get;
-	roc_ree_rule_db_prog;
-	roc_rvu_lf_dev_fini;
-	roc_rvu_lf_dev_init;
-	roc_rvu_lf_irq_register;
-	roc_rvu_lf_irq_unregister;
-	roc_rvu_lf_msg_handler_register;
-	roc_rvu_lf_msg_handler_unregister;
-	roc_rvu_lf_msg_id_range_check;
-	roc_rvu_lf_msg_id_range_set;
-	roc_rvu_lf_msg_process;
-	roc_rvu_lf_pf_func_get;
-
-	local: *;
-};
diff --git a/drivers/common/cpt/version.map b/drivers/common/cpt/version.map
deleted file mode 100644
index b4080e0f8c..0000000000
--- a/drivers/common/cpt/version.map
+++ /dev/null
@@ -1,11 +0,0 @@
-INTERNAL {
-	global:
-
-	cpt_fpm_clear;
-	cpt_fpm_init;
-	cpt_pmd_ops_helper_asym_get_mlen;
-	cpt_pmd_ops_helper_get_mlen_direct_mode;
-	cpt_pmd_ops_helper_get_mlen_sg_mode;
-
-	local: *;
-};
diff --git a/drivers/common/dpaax/version.map b/drivers/common/dpaax/version.map
deleted file mode 100644
index d48a6b6f37..0000000000
--- a/drivers/common/dpaax/version.map
+++ /dev/null
@@ -1,25 +0,0 @@
-INTERNAL {
-	global:
-
-	dpaax_iova_table_depopulate;
-	dpaax_iova_table_dump;
-	dpaax_iova_table_p;
-	dpaax_iova_table_populate;
-	dpaax_iova_table_update;
-	dpaax_logger;
-	of_device_is_available;
-	of_device_is_compatible;
-	of_find_compatible_node;
-	of_find_node_by_phandle;
-	of_get_address;
-	of_get_mac_address;
-	of_get_next_child;
-	of_get_parent;
-	of_get_property;
-	of_init_path;
-	of_n_addr_cells;
-	of_translate_address;
-	rta_sec_era;
-
-	local: *;
-};
diff --git a/drivers/common/ionic/version.map b/drivers/common/ionic/version.map
deleted file mode 100644
index db532d4ffc..0000000000
--- a/drivers/common/ionic/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-INTERNAL {
-	global:
-
-	ionic_uio_scan_mnet_devices;
-	ionic_uio_scan_mcrypt_devices;
-	ionic_uio_get_rsrc;
-	ionic_uio_rel_rsrc;
-
-	local: *;
-};
diff --git a/drivers/common/mlx5/version.map b/drivers/common/mlx5/version.map
deleted file mode 100644
index 819e6b96cb..0000000000
--- a/drivers/common/mlx5/version.map
+++ /dev/null
@@ -1,175 +0,0 @@
-INTERNAL {
-	global:
-
-	haswell_broadwell_cpu;
-
-	mlx5_auxiliary_get_child_name; # WINDOWS_NO_EXPORT
-
-	mlx5_class_driver_register;
-
-	mlx5_common_init;
-
-	mlx5_common_verbs_reg_mr; # WINDOWS_NO_EXPORT
-	mlx5_common_verbs_dereg_mr; # WINDOWS_NO_EXPORT
-
-	mlx5_dev_is_pci;
-	mlx5_dev_is_vf_pci;
-	mlx5_dev_to_pci_str;
-	mlx5_dev_mempool_unregister;
-	mlx5_dev_mempool_subscribe;
-
-	mlx5_devx_cmd_alloc_pd;
-	mlx5_devx_cmd_create_conn_track_offload_obj;
-	mlx5_devx_cmd_create_cq;
-	mlx5_devx_cmd_create_credential_obj;
-	mlx5_devx_cmd_create_crypto_login_obj;
-	mlx5_devx_cmd_create_dek_obj;
-	mlx5_devx_cmd_create_flex_parser;
-	mlx5_devx_cmd_create_flow_hit_aso_obj;
-	mlx5_devx_cmd_create_flow_meter_aso_obj;
-	mlx5_devx_cmd_create_geneve_tlv_option;
-	mlx5_devx_cmd_create_import_kek_obj;
-	mlx5_devx_cmd_create_qp;
-	mlx5_devx_cmd_create_rmp;
-	mlx5_devx_cmd_create_rq;
-	mlx5_devx_cmd_create_rqt;
-	mlx5_devx_cmd_create_sq;
-	mlx5_devx_cmd_create_td;
-	mlx5_devx_cmd_create_tir;
-	mlx5_devx_cmd_create_tis;
-	mlx5_devx_cmd_create_virtio_q_counters; # WINDOWS_NO_EXPORT
-	mlx5_devx_cmd_create_virtq;
-	mlx5_devx_cmd_destroy;
-	mlx5_devx_cmd_flow_counter_alloc;
-	mlx5_devx_cmd_flow_counter_alloc_general;
-	mlx5_devx_cmd_flow_counter_query;
-	mlx5_devx_cmd_flow_dump;
-	mlx5_devx_cmd_flow_single_dump;
-	mlx5_devx_cmd_match_sample_info_query;
-	mlx5_devx_cmd_mkey_create;
-	mlx5_devx_cmd_modify_qp_state;
-	mlx5_devx_cmd_modify_rq;
-	mlx5_devx_cmd_modify_rqt;
-	mlx5_devx_cmd_modify_sq;
-	mlx5_devx_cmd_query_sq;
-	mlx5_devx_cmd_query_rq;
-	mlx5_devx_cmd_query_cq;
-	mlx5_devx_cmd_modify_tir;
-	mlx5_devx_cmd_modify_virtq;
-	mlx5_devx_cmd_qp_query_tis_td;
-	mlx5_devx_cmd_query_geneve_tlv_option;
-	mlx5_devx_cmd_query_hca_attr;
-	mlx5_devx_cmd_query_lag;
-	mlx5_devx_cmd_query_parse_samples;
-	mlx5_devx_cmd_query_virtio_q_counters; # WINDOWS_NO_EXPORT
-	mlx5_devx_cmd_query_virtq;
-	mlx5_devx_cmd_queue_counter_alloc;
-	mlx5_devx_cmd_queue_counter_query;
-	mlx5_devx_cmd_register_read;
-	mlx5_devx_cmd_register_write;
-	mlx5_devx_cmd_wq_query; # WINDOWS_NO_EXPORT
-
-	mlx5_devx_cq_create;
-	mlx5_devx_cq_destroy;
-
-	mlx5_devx_get_out_command_status;
-
-	mlx5_devx_qp2rts;
-	mlx5_devx_qp_create;
-	mlx5_devx_qp_destroy;
-	mlx5_devx_rq_create;
-	mlx5_devx_rq_destroy;
-	mlx5_devx_sq_create;
-	mlx5_devx_sq_destroy;
-
-	mlx5_devx_uar_prepare;
-	mlx5_devx_uar_release;
-
-	mlx5_free;
-
-	mlx5_get_device_guid; # WINDOWS_NO_EXPORT
-	mlx5_get_ifname_sysfs; # WINDOWS_NO_EXPORT
-	mlx5_get_pci_addr; # WINDOWS_NO_EXPORT
-
-	mlx5_glue;
-
-	mlx5_kvargs_process;
-
-	mlx5_list_create;
-	mlx5_list_register;
-	mlx5_list_unregister;
-	mlx5_list_lookup;
-	mlx5_list_get_entry_num;
-	mlx5_list_destroy;
-
-	mlx5_hlist_create;
-	mlx5_hlist_lookup;
-	mlx5_hlist_register;
-	mlx5_hlist_unregister;
-	mlx5_hlist_destroy;
-
-	mlx5_malloc;
-
-	mlx5_memory_stat_dump; # WINDOWS_NO_EXPORT
-
-	mlx5_mp_init_primary; # WINDOWS_NO_EXPORT
-	mlx5_mp_init_secondary; # WINDOWS_NO_EXPORT
-	mlx5_mp_req_mr_create; # WINDOWS_NO_EXPORT
-	mlx5_mp_req_queue_state_modify;
-	mlx5_mp_req_verbs_cmd_fd; # WINDOWS_NO_EXPORT
-	mlx5_mp_uninit_primary; # WINDOWS_NO_EXPORT
-	mlx5_mp_uninit_secondary; # WINDOWS_NO_EXPORT
-
-	mlx5_mprq_buf_free_cb;
-	mlx5_mr_btree_free;
-	mlx5_mr_create;
-	mlx5_mr_ctrl_init;
-	mlx5_mr_flush_local_cache;
-	mlx5_mr_mb2mr_bh;
-	mlx5_mr_addr2mr_bh;
-
-	mlx5_nl_allmulti; # WINDOWS_NO_EXPORT
-	mlx5_nl_devlink_esw_multiport_get; # WINDOWS_NO_EXPORT
-	mlx5_nl_devlink_family_id_get; # WINDOWS_NO_EXPORT
-	mlx5_nl_ifindex; # WINDOWS_NO_EXPORT
-	mlx5_nl_init; # WINDOWS_NO_EXPORT
-	mlx5_nl_mac_addr_add; # WINDOWS_NO_EXPORT
-	mlx5_nl_mac_addr_flush; # WINDOWS_NO_EXPORT
-	mlx5_nl_mac_addr_remove; # WINDOWS_NO_EXPORT
-	mlx5_nl_mac_addr_sync; # WINDOWS_NO_EXPORT
-	mlx5_nl_parse_link_status_update; # WINDOWS_NO_EXPORT
-	mlx5_nl_port_state; # WINDOWS_NO_EXPORT
-	mlx5_nl_portnum; # WINDOWS_NO_EXPORT
-	mlx5_nl_promisc; # WINDOWS_NO_EXPORT
-	mlx5_nl_read_events; # WINDOWS_NO_EXPORT
-	mlx5_nl_switch_info; # WINDOWS_NO_EXPORT
-	mlx5_nl_vf_mac_addr_modify; # WINDOWS_NO_EXPORT
-	mlx5_nl_vlan_vmwa_create; # WINDOWS_NO_EXPORT
-	mlx5_nl_vlan_vmwa_delete; # WINDOWS_NO_EXPORT
-	mlx5_nl_rdma_monitor_init; # WINDOWS_NO_EXPORT
-	mlx5_nl_rdma_monitor_info_get; # WINDOWS_NO_EXPORT
-	mlx5_nl_rdma_monitor_cap_get; # WINDOWS_NO_EXPORT
-
-	mlx5_os_get_physical_device_ctx;
-	mlx5_os_umem_dereg;
-	mlx5_os_umem_reg;
-
-	mlx5_os_wrapped_mkey_create;
-	mlx5_os_wrapped_mkey_destroy;
-
-	mlx5_realloc;
-
-	mlx5_translate_port_name; # WINDOWS_NO_EXPORT
-
-	mlx5_mr_mempool_register;
-	mlx5_mr_mempool_unregister;
-	mlx5_mp_req_mempool_reg;
-	mlx5_mr_mempool2mr_bh;
-	mlx5_mr_mempool_populate_cache;
-
-	mlx5_os_interrupt_handler_create; # WINDOWS_NO_EXPORT
-	mlx5_os_interrupt_handler_destroy; # WINDOWS_NO_EXPORT
-
-	mlx5_os_set_reg_mr_cb;
-	local: *;
-};
diff --git a/drivers/common/mvep/version.map b/drivers/common/mvep/version.map
deleted file mode 100644
index cbac7bfa8d..0000000000
--- a/drivers/common/mvep/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_mvep_deinit;
-	rte_mvep_init;
-
-	local: *;
-};
diff --git a/drivers/common/nfp/version.map b/drivers/common/nfp/version.map
deleted file mode 100644
index c8a04b1b95..0000000000
--- a/drivers/common/nfp/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-INTERNAL {
-	global:
-
-	nfp_class_driver_register;
-
-	nfp_reconfig;
-	nfp_ext_reconfig;
-	nfp_reconfig_real;
-	nfp_read_mac;
-	nfp_write_mac;
-	nfp_enable_queues;
-	nfp_disable_queues;
-	nfp_dev_info_get;
-
-	local: *;
-};
diff --git a/drivers/common/nitrox/version.map b/drivers/common/nitrox/version.map
deleted file mode 100644
index f58c044fc5..0000000000
--- a/drivers/common/nitrox/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-INTERNAL {
-	global:
-
-	nitrox_logtype;
-	nitrox_qp_release;
-	nitrox_qp_setup;
-	nitrox_register_driver;
-
-	local: *;
-};
diff --git a/drivers/common/octeontx/version.map b/drivers/common/octeontx/version.map
deleted file mode 100644
index 049f66b331..0000000000
--- a/drivers/common/octeontx/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-INTERNAL {
-	global:
-
-	octeontx_get_global_domain;
-	octeontx_logtype_mbox;
-	octeontx_mbox_init;
-	octeontx_mbox_send;
-	octeontx_mbox_set_ram_mbox_base;
-	octeontx_mbox_set_reg;
-
-	local: *;
-};
diff --git a/drivers/common/sfc_efx/version.map b/drivers/common/sfc_efx/version.map
deleted file mode 100644
index b2b90f5512..0000000000
--- a/drivers/common/sfc_efx/version.map
+++ /dev/null
@@ -1,302 +0,0 @@
-INTERNAL {
-	global:
-
-	efx_crc32_calculate;
-
-	efx_ev_fini;
-	efx_ev_init;
-	efx_ev_qcreate;
-	efx_ev_qcreate_check_init_done;
-	efx_ev_qcreate_irq;
-	efx_ev_qdestroy;
-	efx_ev_qmoderate;
-	efx_ev_qpending;
-	efx_ev_qpoll;
-	efx_ev_qpost;
-	efx_ev_qprime;
-	efx_ev_usecs_to_ticks;
-
-	efx_evb_fini;
-	efx_evb_init;
-	efx_evb_vport_mac_set;
-	efx_evb_vport_reset;
-	efx_evb_vport_stats;
-	efx_evb_vport_vlan_set;
-	efx_evb_vswitch_create;
-	efx_evb_vswitch_destroy;
-
-	efx_evq_nbufs;
-	efx_evq_size;
-
-	efx_family;
-	efx_family_probe_bar;
-
-	efx_filter_fini;
-	efx_filter_init;
-	efx_filter_insert;
-	efx_filter_remove;
-	efx_filter_restore;
-	efx_filter_spec_init_rx;
-	efx_filter_spec_init_tx;
-	efx_filter_spec_set_encap_type;
-	efx_filter_spec_set_eth_local;
-	efx_filter_spec_set_ether_type;
-	efx_filter_spec_set_geneve;
-	efx_filter_spec_set_ipv4_full;
-	efx_filter_spec_set_ipv4_local;
-	efx_filter_spec_set_mc_def;
-	efx_filter_spec_set_nvgre;
-	efx_filter_spec_set_rss_context;
-	efx_filter_spec_set_uc_def;
-	efx_filter_spec_set_vxlan;
-	efx_filter_supported_filters;
-
-	efx_hash_bytes;
-	efx_hash_dwords;
-
-	efx_intr_disable;
-	efx_intr_disable_unlocked;
-	efx_intr_enable;
-	efx_intr_fatal;
-	efx_intr_fini;
-	efx_intr_init;
-	efx_intr_status_line;
-	efx_intr_status_message;
-	efx_intr_trigger;
-
-	efx_loopback_mask;
-	efx_loopback_type_name;
-
-	efx_mac_addr_set;
-	efx_mac_drain;
-	efx_mac_fcntl_get;
-	efx_mac_fcntl_set;
-	efx_mac_include_fcs_set;
-	efx_mac_filter_default_rxq_clear;
-	efx_mac_filter_default_rxq_set;
-	efx_mac_filter_get_all_ucast_mcast;
-	efx_mac_filter_set;
-	efx_mac_multicast_list_set;
-	efx_mac_pdu_get;
-	efx_mac_pdu_set;
-	efx_mac_stat_name;
-	efx_mac_stats_clear;
-	efx_mac_stats_get_mask;
-	efx_mac_stats_periodic;
-	efx_mac_stats_update;
-	efx_mac_stats_upload;
-	efx_mac_up;
-
-	efx_mae_action_rule_insert;
-	efx_mae_action_rule_remove;
-	efx_mae_action_set_alloc;
-	efx_mae_action_set_clear_fw_rsrc_ids;
-	efx_mae_action_set_fill_in_counter_id;
-	efx_mae_action_set_fill_in_dst_mac_id;
-	efx_mae_action_set_fill_in_eh_id;
-	efx_mae_action_set_fill_in_src_mac_id;
-	efx_mae_action_set_free;
-	efx_mae_action_set_get_nb_count;
-	efx_mae_action_set_list_alloc;
-	efx_mae_action_set_list_free;
-	efx_mae_action_set_populate_count;
-	efx_mae_action_set_populate_decap;
-	efx_mae_action_set_populate_decr_ip_ttl;
-	efx_mae_action_set_populate_deliver;
-	efx_mae_action_set_populate_drop;
-	efx_mae_action_set_populate_encap;
-	efx_mae_action_set_populate_flag;
-	efx_mae_action_set_populate_mark;
-	efx_mae_action_set_populate_mark_reset;
-	efx_mae_action_set_populate_nat;
-	efx_mae_action_set_populate_set_dst_mac;
-	efx_mae_action_set_populate_set_src_mac;
-	efx_mae_action_set_populate_vlan_pop;
-	efx_mae_action_set_populate_vlan_push;
-	efx_mae_action_set_replay;
-	efx_mae_action_set_spec_fini;
-	efx_mae_action_set_spec_init;
-	efx_mae_action_set_specs_equal;
-	efx_mae_counters_alloc;
-	efx_mae_counters_alloc_type;
-	efx_mae_counters_free;
-	efx_mae_counters_free_type;
-	efx_mae_counters_stream_give_credits;
-	efx_mae_counters_stream_start;
-	efx_mae_counters_stream_stop;
-	efx_mae_encap_header_alloc;
-	efx_mae_encap_header_free;
-	efx_mae_encap_header_update;
-	efx_mae_fini;
-	efx_mae_get_limits;
-	efx_mae_init;
-	efx_mae_mac_addr_alloc;
-	efx_mae_mac_addr_free;
-	efx_mae_match_spec_bit_set;
-	efx_mae_match_spec_clone;
-	efx_mae_match_spec_ct_mark_set;
-	efx_mae_match_spec_field_get;
-	efx_mae_match_spec_field_set;
-	efx_mae_match_spec_fini;
-	efx_mae_match_spec_init;
-	efx_mae_match_spec_is_valid;
-	efx_mae_match_spec_mport_set;
-	efx_mae_match_spec_outer_rule_id_set;
-	efx_mae_match_spec_recirc_id_set;
-	efx_mae_match_specs_class_cmp;
-	efx_mae_match_specs_equal;
-	efx_mae_mport_by_pcie_function;
-	efx_mae_mport_by_pcie_mh_function;
-	efx_mae_mport_by_phy_port;
-	efx_mae_mport_by_id;
-	efx_mae_mport_free;
-	efx_mae_mport_id_by_selector;
-	efx_mae_mport_invalid;
-	efx_mae_outer_rule_do_ct_set;
-	efx_mae_outer_rule_insert;
-	efx_mae_outer_rule_recirc_id_set;
-	efx_mae_outer_rule_remove;
-	efx_mae_read_mport_journal;
-
-	efx_mcdi_client_mac_addr_get;
-	efx_mcdi_client_mac_addr_set;
-	efx_mcdi_fini;
-	efx_mcdi_get_client_handle;
-	efx_mcdi_get_own_client_handle;
-	efx_mcdi_get_proxy_handle;
-	efx_mcdi_get_timeout;
-	efx_mcdi_init;
-	efx_mcdi_mport_alloc_alias;
-	efx_mcdi_new_epoch;
-	efx_mcdi_reboot;
-	efx_mcdi_request_abort;
-	efx_mcdi_request_poll;
-	efx_mcdi_request_start;
-
-	efx_mon_fini;
-	efx_mon_init;
-	efx_mon_name;
-
-	efx_nic_calculate_pcie_link_bandwidth;
-	efx_nic_cfg_get;
-	efx_nic_check_pcie_link_speed;
-	efx_nic_create;
-	efx_nic_destroy;
-	efx_nic_dma_config_add;
-	efx_nic_dma_map;
-	efx_nic_dma_reconfigure;
-	efx_nic_fini;
-	efx_nic_get_bar_region;
-	efx_nic_get_board_info;
-	efx_nic_get_fw_subvariant;
-	efx_nic_get_fw_version;
-	efx_nic_get_vi_pool;
-	efx_nic_hw_unavailable;
-	efx_nic_init;
-	efx_nic_probe;
-	efx_nic_reset;
-	efx_nic_set_drv_limits;
-	efx_nic_set_drv_version;
-	efx_nic_set_fw_subvariant;
-	efx_nic_set_hw_unavailable;
-	efx_nic_unprobe;
-
-	efx_phy_adv_cap_get;
-	efx_phy_adv_cap_set;
-	efx_phy_fec_type_get;
-	efx_phy_link_state_get;
-	efx_phy_lp_cap_get;
-	efx_phy_media_type_get;
-	efx_phy_module_get_info;
-	efx_phy_oui_get;
-	efx_phy_verify;
-
-	efx_port_fini;
-	efx_port_init;
-	efx_port_loopback_set;
-	efx_port_poll;
-	efx_port_vlan_strip_set;
-
-	efx_pseudo_hdr_hash_get;
-	efx_pseudo_hdr_pkt_length_get;
-
-	efx_rx_fini;
-	efx_rx_hash_default_support_get;
-	efx_rx_init;
-	efx_rx_prefix_get_layout;
-	efx_rx_prefix_layout_check;
-	efx_rx_qcreate;
-	efx_rx_qcreate_es_super_buffer;
-	efx_rx_qdestroy;
-	efx_rx_qenable;
-	efx_rx_qflush;
-	efx_rx_qpost;
-	efx_rx_qpush;
-	efx_rx_scale_context_alloc;
-	efx_rx_scale_context_alloc_v2;
-	efx_rx_scale_context_free;
-	efx_rx_scale_default_support_get;
-	efx_rx_scale_hash_flags_get;
-	efx_rx_scale_key_set;
-	efx_rx_scale_mode_set;
-	efx_rx_scale_tbl_set;
-	efx_rxq_nbufs;
-	efx_rxq_size;
-
-	efx_sram_buf_tbl_clear;
-	efx_sram_buf_tbl_set;
-
-	efx_table_describe;
-	efx_table_entry_delete;
-	efx_table_entry_insert;
-	efx_table_is_supported;
-	efx_table_list;
-	efx_table_supported_num_get;
-
-	efx_tunnel_config_clear;
-	efx_tunnel_config_udp_add;
-	efx_tunnel_config_udp_remove;
-	efx_tunnel_fini;
-	efx_tunnel_init;
-	efx_tunnel_reconfigure;
-
-	efx_tx_fini;
-	efx_tx_init;
-	efx_tx_qcreate;
-	efx_tx_qdesc_checksum_create;
-	efx_tx_qdesc_dma_create;
-	efx_tx_qdesc_post;
-	efx_tx_qdesc_tso_create;
-	efx_tx_qdesc_tso2_create;
-	efx_tx_qdesc_vlantci_create;
-	efx_tx_qdestroy;
-	efx_tx_qenable;
-	efx_tx_qflush;
-	efx_tx_qpace;
-	efx_tx_qpio_disable;
-	efx_tx_qpio_enable;
-	efx_tx_qpio_post;
-	efx_tx_qpio_write;
-	efx_tx_qpost;
-	efx_tx_qpush;
-	efx_txq_nbufs;
-	efx_txq_size;
-
-	efx_virtio_fini;
-	efx_virtio_get_doorbell_offset;
-	efx_virtio_get_features;
-	efx_virtio_init;
-	efx_virtio_qcreate;
-	efx_virtio_qdestroy;
-	efx_virtio_qstart;
-	efx_virtio_qstop;
-	efx_virtio_verify_features;
-
-	sfc_efx_dev_class_get;
-	sfc_efx_family;
-
-	sfc_efx_mcdi_init;
-	sfc_efx_mcdi_fini;
-
-	local: *;
-};
diff --git a/drivers/crypto/cnxk/version.map b/drivers/crypto/cnxk/version.map
deleted file mode 100644
index 05724e69e4..0000000000
--- a/drivers/crypto/cnxk/version.map
+++ /dev/null
@@ -1,30 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 24.03
-	rte_pmd_cnxk_crypto_submit;
-	rte_pmd_cnxk_crypto_qptr_get;
-
-	# added in 24.07
-	rte_pmd_cnxk_crypto_cptr_flush;
-	rte_pmd_cnxk_crypto_cptr_get;
-	rte_pmd_cnxk_crypto_cptr_read;
-	rte_pmd_cnxk_crypto_cptr_write;
-	rte_pmd_cnxk_crypto_qp_stats_get;
-};
-
-INTERNAL {
-	global:
-
-	cn9k_cpt_crypto_adapter_enqueue;
-	cn9k_cpt_crypto_adapter_dequeue;
-	cn10k_cpt_sg_ver1_crypto_adapter_enqueue;
-	cn10k_cpt_sg_ver2_crypto_adapter_enqueue;
-	cn10k_cpt_crypto_adapter_dequeue;
-	cn10k_cpt_crypto_adapter_vector_dequeue;
-
-	cn10k_cryptodev_sec_inb_rx_inject;
-	cn10k_cryptodev_sec_rx_inject_configure;
-
-	local: *;
-};
diff --git a/drivers/crypto/dpaa2_sec/version.map b/drivers/crypto/dpaa2_sec/version.map
deleted file mode 100644
index 1352f576e5..0000000000
--- a/drivers/crypto/dpaa2_sec/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-INTERNAL {
-	global:
-
-	dpaa2_sec_eventq_attach;
-	dpaa2_sec_eventq_detach;
-
-	local: *;
-};
diff --git a/drivers/crypto/dpaa_sec/version.map b/drivers/crypto/dpaa_sec/version.map
deleted file mode 100644
index 731ea593ad..0000000000
--- a/drivers/crypto/dpaa_sec/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-INTERNAL {
-	global:
-
-	dpaa_sec_eventq_attach;
-	dpaa_sec_eventq_detach;
-
-	local: *;
-};
diff --git a/drivers/crypto/octeontx/version.map b/drivers/crypto/octeontx/version.map
deleted file mode 100644
index 8803f974b2..0000000000
--- a/drivers/crypto/octeontx/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	otx_crypto_adapter_enqueue;
-	otx_crypto_adapter_dequeue;
-
-	local: *;
-};
diff --git a/drivers/crypto/scheduler/version.map b/drivers/crypto/scheduler/version.map
deleted file mode 100644
index d7ba3874f2..0000000000
--- a/drivers/crypto/scheduler/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_cryptodev_scheduler_load_user_scheduler;
-	rte_cryptodev_scheduler_mode_get;
-	rte_cryptodev_scheduler_mode_set;
-	rte_cryptodev_scheduler_option_get;
-	rte_cryptodev_scheduler_option_set;
-	rte_cryptodev_scheduler_ordering_get;
-	rte_cryptodev_scheduler_ordering_set;
-	rte_cryptodev_scheduler_worker_attach;
-	rte_cryptodev_scheduler_worker_detach;
-	rte_cryptodev_scheduler_workers_get;
-
-	local: *;
-};
diff --git a/drivers/dma/cnxk/version.map b/drivers/dma/cnxk/version.map
deleted file mode 100644
index a1490abf97..0000000000
--- a/drivers/dma/cnxk/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-INTERNAL {
-	global:
-
-	cn10k_dma_adapter_enqueue;
-	cn9k_dma_adapter_enqueue;
-	cn9k_dma_adapter_dual_enqueue;
-	cnxk_dma_adapter_dequeue;
-
-	local: *;
-};
diff --git a/drivers/event/cnxk/version.map b/drivers/event/cnxk/version.map
deleted file mode 100644
index a275ec2977..0000000000
--- a/drivers/event/cnxk/version.map
+++ /dev/null
@@ -1,11 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.11
-	rte_pmd_cnxk_eventdev_is_head;
-	rte_pmd_cnxk_eventdev_wait_head;
-};
diff --git a/drivers/event/dlb2/version.map b/drivers/event/dlb2/version.map
deleted file mode 100644
index c37d2302cd..0000000000
--- a/drivers/event/dlb2/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_pmd_dlb2_set_token_pop_mode;
-};
diff --git a/drivers/mempool/cnxk/version.map b/drivers/mempool/cnxk/version.map
deleted file mode 100644
index c2905a610e..0000000000
--- a/drivers/mempool/cnxk/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.07
-	rte_pmd_cnxk_mempool_is_hwpool;
-	rte_pmd_cnxk_mempool_mbuf_exchange;
-	rte_pmd_cnxk_mempool_range_check_disable;
-};
diff --git a/drivers/mempool/dpaa/version.map b/drivers/mempool/dpaa/version.map
deleted file mode 100644
index 142547ee38..0000000000
--- a/drivers/mempool/dpaa/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_dpaa_bpid_info;
-	rte_dpaa_memsegs;
-
-	local: *;
-};
diff --git a/drivers/mempool/dpaa2/version.map b/drivers/mempool/dpaa2/version.map
deleted file mode 100644
index c1acfc0c64..0000000000
--- a/drivers/mempool/dpaa2/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_dpaa2_mbuf_from_buf_addr;
-	rte_dpaa2_mbuf_pool_bpid;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_dpaa2_bpid_info;
-	rte_dpaa2_bpid_info_init;
-	rte_dpaa2_mbuf_alloc_bulk;
-};
diff --git a/drivers/net/atlantic/version.map b/drivers/net/atlantic/version.map
deleted file mode 100644
index 5644e150ac..0000000000
--- a/drivers/net/atlantic/version.map
+++ /dev/null
@@ -1,15 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 19.05
-	rte_pmd_atl_macsec_enable;
-	rte_pmd_atl_macsec_disable;
-	rte_pmd_atl_macsec_config_txsc;
-	rte_pmd_atl_macsec_config_rxsc;
-	rte_pmd_atl_macsec_select_txsa;
-	rte_pmd_atl_macsec_select_rxsa;
-};
diff --git a/drivers/net/bnxt/version.map b/drivers/net/bnxt/version.map
deleted file mode 100644
index d29521f990..0000000000
--- a/drivers/net/bnxt/version.map
+++ /dev/null
@@ -1,22 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_bnxt_get_vf_rx_status;
-	rte_pmd_bnxt_get_vf_stats;
-	rte_pmd_bnxt_get_vf_tx_drop_count;
-	rte_pmd_bnxt_mac_addr_add;
-	rte_pmd_bnxt_reset_vf_stats;
-	rte_pmd_bnxt_set_all_queues_drop_en;
-	rte_pmd_bnxt_set_tx_loopback;
-	rte_pmd_bnxt_set_vf_mac_addr;
-	rte_pmd_bnxt_set_vf_mac_anti_spoof;
-	rte_pmd_bnxt_set_vf_persist_stats;
-	rte_pmd_bnxt_set_vf_rate_limit;
-	rte_pmd_bnxt_set_vf_rxmode;
-	rte_pmd_bnxt_set_vf_vlan_anti_spoof;
-	rte_pmd_bnxt_set_vf_vlan_filter;
-	rte_pmd_bnxt_set_vf_vlan_insert;
-	rte_pmd_bnxt_set_vf_vlan_stripq;
-
-	local: *;
-};
diff --git a/drivers/net/bonding/version.map b/drivers/net/bonding/version.map
deleted file mode 100644
index eb37dadf76..0000000000
--- a/drivers/net/bonding/version.map
+++ /dev/null
@@ -1,33 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_bond_8023ad_agg_selection_get;
-	rte_eth_bond_8023ad_agg_selection_set;
-	rte_eth_bond_8023ad_conf_get;
-	rte_eth_bond_8023ad_dedicated_queues_disable;
-	rte_eth_bond_8023ad_dedicated_queues_enable;
-	rte_eth_bond_8023ad_ext_collect;
-	rte_eth_bond_8023ad_ext_collect_get;
-	rte_eth_bond_8023ad_ext_distrib;
-	rte_eth_bond_8023ad_ext_distrib_get;
-	rte_eth_bond_8023ad_ext_slowtx;
-	rte_eth_bond_8023ad_member_info;
-	rte_eth_bond_8023ad_setup;
-	rte_eth_bond_active_members_get;
-	rte_eth_bond_create;
-	rte_eth_bond_free;
-	rte_eth_bond_link_monitoring_set;
-	rte_eth_bond_mac_address_reset;
-	rte_eth_bond_mac_address_set;
-	rte_eth_bond_member_add;
-	rte_eth_bond_member_remove;
-	rte_eth_bond_members_get;
-	rte_eth_bond_mode_get;
-	rte_eth_bond_mode_set;
-	rte_eth_bond_primary_get;
-	rte_eth_bond_primary_set;
-	rte_eth_bond_xmit_policy_get;
-	rte_eth_bond_xmit_policy_set;
-
-	local: *;
-};
diff --git a/drivers/net/cnxk/version.map b/drivers/net/cnxk/version.map
deleted file mode 100644
index edb0a1c059..0000000000
--- a/drivers/net/cnxk/version.map
+++ /dev/null
@@ -1,27 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 22.07
-	rte_pmd_cnxk_hw_sa_read;
-	rte_pmd_cnxk_hw_sa_write;
-
-	# added in 23.11
-	rte_pmd_cnxk_cpt_q_stats_get;
-	rte_pmd_cnxk_hw_inline_inb_cfg_set;
-	rte_pmd_cnxk_hw_session_base_get;
-	rte_pmd_cnxk_inl_dev_qptr_get;
-	rte_pmd_cnxk_inl_dev_submit;
-	rte_pmd_cnxk_inl_ipsec_res;
-	rte_pmd_cnxk_model_str_get;
-	rte_pmd_cnxk_sa_flush;
-};
-
-INTERNAL {
-	global:
-	cnxk_nix_inb_mode_set;
-	cnxk_ethdev_rx_offload_cb_register;
-};
diff --git a/drivers/net/dpaa/version.map b/drivers/net/dpaa/version.map
deleted file mode 100644
index 3fdb63caf3..0000000000
--- a/drivers/net/dpaa/version.map
+++ /dev/null
@@ -1,14 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_dpaa_set_tx_loopback;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	dpaa_eth_eventq_attach;
-	dpaa_eth_eventq_detach;
-};
diff --git a/drivers/net/dpaa2/version.map b/drivers/net/dpaa2/version.map
deleted file mode 100644
index 35815f7777..0000000000
--- a/drivers/net/dpaa2/version.map
+++ /dev/null
@@ -1,35 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_dpaa2_mux_flow_create;
-	rte_pmd_dpaa2_set_custom_hash;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 21.05
-	rte_pmd_dpaa2_mux_rx_frame_len;
-	# added in 21.08
-	rte_pmd_dpaa2_thread_init;
-	# added in 21.11
-	rte_pmd_dpaa2_get_tlu_hash;
-	# added in 24.11
-	rte_pmd_dpaa2_dev_is_dpaa2;
-	rte_pmd_dpaa2_ep_name;
-	rte_pmd_dpaa2_set_one_step_ts;
-	rte_pmd_dpaa2_get_one_step_ts;
-	rte_pmd_dpaa2_mux_dump_counter;
-};
-
-INTERNAL {
-	global:
-
-	dpaa2_dev_tx_multi_txq_ordered;
-	dpaa2_eth_eventq_attach;
-	dpaa2_eth_eventq_detach;
-
-	local: *;
-};
diff --git a/drivers/net/intel/i40e/version.map b/drivers/net/intel/i40e/version.map
deleted file mode 100644
index e5d20fee71..0000000000
--- a/drivers/net/intel/i40e/version.map
+++ /dev/null
@@ -1,55 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_i40e_add_vf_mac_addr;
-	rte_pmd_i40e_flow_add_del_packet_template;
-	rte_pmd_i40e_flow_type_mapping_get;
-	rte_pmd_i40e_flow_type_mapping_reset;
-	rte_pmd_i40e_flow_type_mapping_update;
-	rte_pmd_i40e_get_ddp_info;
-	rte_pmd_i40e_get_ddp_list;
-	rte_pmd_i40e_get_vf_stats;
-	rte_pmd_i40e_inset_get;
-	rte_pmd_i40e_inset_set;
-	rte_pmd_i40e_ping_vfs;
-	rte_pmd_i40e_process_ddp_package;
-	rte_pmd_i40e_ptype_mapping_get;
-	rte_pmd_i40e_ptype_mapping_replace;
-	rte_pmd_i40e_ptype_mapping_reset;
-	rte_pmd_i40e_ptype_mapping_update;
-	rte_pmd_i40e_query_vfid_by_mac;
-	rte_pmd_i40e_reset_vf_stats;
-	rte_pmd_i40e_rss_queue_region_conf;
-	rte_pmd_i40e_set_tc_strict_prio;
-	rte_pmd_i40e_set_tx_loopback;
-	rte_pmd_i40e_set_vf_broadcast;
-	rte_pmd_i40e_set_vf_mac_addr;
-	rte_pmd_i40e_set_vf_mac_anti_spoof;
-	rte_pmd_i40e_set_vf_max_bw;
-	rte_pmd_i40e_set_vf_multicast_promisc;
-	rte_pmd_i40e_set_vf_tc_bw_alloc;
-	rte_pmd_i40e_set_vf_tc_max_bw;
-	rte_pmd_i40e_set_vf_unicast_promisc;
-	rte_pmd_i40e_set_vf_vlan_anti_spoof;
-	rte_pmd_i40e_set_vf_vlan_filter;
-	rte_pmd_i40e_set_vf_vlan_insert;
-	rte_pmd_i40e_set_vf_vlan_stripq;
-	rte_pmd_i40e_set_vf_vlan_tag;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 19.11
-	rte_pmd_i40e_set_switch_dev;
-
-	# added in 20.08
-	rte_pmd_i40e_get_fdir_info;
-	rte_pmd_i40e_get_fdir_stats;
-	rte_pmd_i40e_set_gre_key_len;
-
-	# added in 23.07
-	rte_pmd_i40e_set_pf_src_prune;
-};
diff --git a/drivers/net/intel/iavf/version.map b/drivers/net/intel/iavf/version.map
deleted file mode 100644
index d18dea64dd..0000000000
--- a/drivers/net/intel/iavf/version.map
+++ /dev/null
@@ -1,33 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_pmd_ifd_dynfield_proto_xtr_metadata_offs;
-	rte_pmd_ifd_dynflag_proto_xtr_vlan_mask;
-	rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask;
-	rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask;
-	rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask;
-	rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
-	rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
-
-	# added in 21.11
-	rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
-};
-
-INTERNAL {
-	global:
-
-	iavf_aq_send_msg_to_pf;
-	iavf_clean_arq_element;
-	iavf_init_adminq;
-	iavf_set_mac_type;
-	iavf_shutdown_adminq;
-	iavf_vf_parse_hw_config;
-	iavf_vf_reset;
-
-	local: *;
-};
diff --git a/drivers/net/intel/ice/version.map b/drivers/net/intel/ice/version.map
deleted file mode 100644
index 0052043264..0000000000
--- a/drivers/net/intel/ice/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 19.11
-	rte_pmd_ice_dump_package;
-
-	# added in 22.11
-	rte_pmd_ice_dump_switch;
-
-	# added in 24.03
-	rte_pmd_ice_dump_txsched;
-};
diff --git a/drivers/net/intel/idpf/version.map b/drivers/net/intel/idpf/version.map
deleted file mode 100644
index 0557321963..0000000000
--- a/drivers/net/intel/idpf/version.map
+++ /dev/null
@@ -1,80 +0,0 @@
-INTERNAL {
-	global:
-
-	idpf_adapter_deinit;
-	idpf_adapter_init;
-
-	idpf_dp_prep_pkts;
-	idpf_dp_singleq_recv_pkts;
-	idpf_dp_singleq_recv_pkts_avx2;
-	idpf_dp_singleq_recv_pkts_avx512;
-	idpf_dp_singleq_recv_scatter_pkts;
-	idpf_dp_singleq_xmit_pkts;
-	idpf_dp_singleq_xmit_pkts_avx2;
-	idpf_dp_singleq_xmit_pkts_avx512;
-	idpf_dp_splitq_recv_pkts;
-	idpf_dp_splitq_recv_pkts_avx512;
-	idpf_dp_splitq_xmit_pkts;
-	idpf_dp_splitq_xmit_pkts_avx512;
-
-	idpf_qc_rx_thresh_check;
-	idpf_qc_rx_queue_release;
-	idpf_qc_rxq_mbufs_release;
-	idpf_qc_single_rx_queue_reset;
-	idpf_qc_single_rxq_mbufs_alloc;
-	idpf_qc_single_tx_queue_reset;
-	idpf_qc_singleq_rx_vec_setup;
-	idpf_qc_split_rx_bufq_reset;
-	idpf_qc_split_rx_descq_reset;
-	idpf_qc_split_rx_queue_reset;
-	idpf_qc_split_rxq_mbufs_alloc;
-	idpf_qc_split_tx_complq_reset;
-	idpf_qc_split_tx_descq_reset;
-	idpf_qc_splitq_rx_vec_setup;
-	idpf_qc_ts_mbuf_register;
-	idpf_qc_tx_queue_release;
-	idpf_qc_tx_thresh_check;
-	idpf_qc_tx_vec_avx512_setup;
-	idpf_qc_txq_mbufs_release;
-
-	idpf_vc_api_version_check;
-	idpf_vc_caps_get;
-	idpf_vc_cmd_execute;
-	idpf_vc_ctlq_post_rx_buffs;
-	idpf_vc_ctlq_recv;
-	idpf_vc_ena_dis_one_queue;
-	idpf_vc_irq_map_unmap_config;
-	idpf_vc_one_msg_read;
-	idpf_vc_ptype_info_query;
-	idpf_vc_queue_grps_add;
-	idpf_vc_queue_grps_del;
-	idpf_vc_queue_switch;
-	idpf_vc_queues_ena_dis;
-	idpf_vc_rss_hash_get;
-	idpf_vc_rss_hash_set;
-	idpf_vc_rss_key_get;
-	idpf_vc_rss_key_set;
-	idpf_vc_rss_lut_get;
-	idpf_vc_rss_lut_set;
-	idpf_vc_rxq_config;
-	idpf_vc_rxq_config_by_info;
-	idpf_vc_stats_query;
-	idpf_vc_txq_config;
-	idpf_vc_txq_config_by_info;
-	idpf_vc_vectors_alloc;
-	idpf_vc_vectors_dealloc;
-	idpf_vc_vport_create;
-	idpf_vc_vport_destroy;
-	idpf_vc_vport_ena_dis;
-
-	idpf_vport_deinit;
-	idpf_vport_info_init;
-	idpf_vport_init;
-	idpf_vport_irq_map_config;
-	idpf_vport_irq_map_config_by_qids;
-	idpf_vport_irq_unmap_config;
-	idpf_vport_rss_config;
-	idpf_vport_stats_update;
-
-	local: *;
-};
diff --git a/drivers/net/intel/ipn3ke/version.map b/drivers/net/intel/ipn3ke/version.map
deleted file mode 100644
index e10d44858f..0000000000
--- a/drivers/net/intel/ipn3ke/version.map
+++ /dev/null
@@ -1,9 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	ipn3ke_bridge_func;
-};
diff --git a/drivers/net/intel/ixgbe/version.map b/drivers/net/intel/ixgbe/version.map
deleted file mode 100644
index 8c4c0ca542..0000000000
--- a/drivers/net/intel/ixgbe/version.map
+++ /dev/null
@@ -1,49 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_ixgbe_bypass_event_show;
-	rte_pmd_ixgbe_bypass_event_store;
-	rte_pmd_ixgbe_bypass_init;
-	rte_pmd_ixgbe_bypass_state_set;
-	rte_pmd_ixgbe_bypass_state_show;
-	rte_pmd_ixgbe_bypass_ver_show;
-	rte_pmd_ixgbe_bypass_wd_reset;
-	rte_pmd_ixgbe_bypass_wd_timeout_show;
-	rte_pmd_ixgbe_bypass_wd_timeout_store;
-	rte_pmd_ixgbe_macsec_config_rxsc;
-	rte_pmd_ixgbe_macsec_config_txsc;
-	rte_pmd_ixgbe_macsec_disable;
-	rte_pmd_ixgbe_macsec_enable;
-	rte_pmd_ixgbe_macsec_select_rxsa;
-	rte_pmd_ixgbe_macsec_select_txsa;
-	rte_pmd_ixgbe_mdio_lock;
-	rte_pmd_ixgbe_mdio_unlock;
-	rte_pmd_ixgbe_mdio_unlocked_read;
-	rte_pmd_ixgbe_mdio_unlocked_write;
-	rte_pmd_ixgbe_ping_vf;
-	rte_pmd_ixgbe_set_all_queues_drop_en;
-	rte_pmd_ixgbe_set_tc_bw_alloc;
-	rte_pmd_ixgbe_set_tx_loopback;
-	rte_pmd_ixgbe_set_vf_mac_addr;
-	rte_pmd_ixgbe_set_vf_mac_anti_spoof;
-	rte_pmd_ixgbe_set_vf_rate_limit;
-	rte_pmd_ixgbe_set_vf_rx;
-	rte_pmd_ixgbe_set_vf_rxmode;
-	rte_pmd_ixgbe_set_vf_split_drop_en;
-	rte_pmd_ixgbe_set_vf_tx;
-	rte_pmd_ixgbe_set_vf_vlan_anti_spoof;
-	rte_pmd_ixgbe_set_vf_vlan_filter;
-	rte_pmd_ixgbe_set_vf_vlan_insert;
-	rte_pmd_ixgbe_set_vf_vlan_stripq;
-	rte_pmd_ixgbe_upd_fctrl_sbp;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.08
-	rte_pmd_ixgbe_get_fdir_info;
-	rte_pmd_ixgbe_get_fdir_stats;
-};
diff --git a/drivers/net/mlx5/version.map b/drivers/net/mlx5/version.map
deleted file mode 100644
index 560f7ef79b..0000000000
--- a/drivers/net/mlx5/version.map
+++ /dev/null
@@ -1,28 +0,0 @@
-DPDK_25 {
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.02
-	rte_pmd_mlx5_get_dyn_flag_names;
-	# added in 20.11
-	rte_pmd_mlx5_sync_flow;
-	# added in 22.03
-	rte_pmd_mlx5_external_rx_queue_id_map;
-	rte_pmd_mlx5_external_rx_queue_id_unmap;
-	# added in 22.07
-	rte_pmd_mlx5_host_shaper_config;
-	rte_pmd_mlx5_external_sq_enable;
-	# added in 23.03
-	rte_pmd_mlx5_flow_engine_set_mode;
-	# added in 24.03
-	rte_pmd_mlx5_create_geneve_tlv_parser;
-	rte_pmd_mlx5_destroy_geneve_tlv_parser;
-	# added in 24.07
-	rte_pmd_mlx5_external_tx_queue_id_map;
-	rte_pmd_mlx5_external_tx_queue_id_unmap;
-	rte_pmd_mlx5_txq_dump_contexts;
-	rte_pmd_mlx5_rxq_dump_contexts;
-};
diff --git a/drivers/net/octeontx/version.map b/drivers/net/octeontx/version.map
deleted file mode 100644
index 861dd3450e..0000000000
--- a/drivers/net/octeontx/version.map
+++ /dev/null
@@ -1,7 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_octeontx_pchan_map;
-
-	local: *;
-};
diff --git a/drivers/net/ring/version.map b/drivers/net/ring/version.map
deleted file mode 100644
index 3b408c8ba5..0000000000
--- a/drivers/net/ring/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_from_ring;
-	rte_eth_from_rings;
-
-	local: *;
-};
diff --git a/drivers/net/softnic/version.map b/drivers/net/softnic/version.map
deleted file mode 100644
index 15daeceb73..0000000000
--- a/drivers/net/softnic/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_softnic_manage;
-	rte_pmd_softnic_run;
-
-	local: *;
-};
diff --git a/drivers/net/vhost/version.map b/drivers/net/vhost/version.map
deleted file mode 100644
index 63890911d8..0000000000
--- a/drivers/net/vhost/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_vhost_get_queue_event;
-	rte_eth_vhost_get_vid_from_port_id;
-
-	local: *;
-};
diff --git a/drivers/power/kvm_vm/version.map b/drivers/power/kvm_vm/version.map
deleted file mode 100644
index ffa676624b..0000000000
--- a/drivers/power/kvm_vm/version.map
+++ /dev/null
@@ -1,8 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_power_guest_channel_receive_msg;
-	rte_power_guest_channel_send_msg;
-
-	local: *;
-};
diff --git a/drivers/raw/cnxk_rvu_lf/version.map b/drivers/raw/cnxk_rvu_lf/version.map
deleted file mode 100644
index 012f05d1e4..0000000000
--- a/drivers/raw/cnxk_rvu_lf/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-INTERNAL {
-	global:
-
-	rte_pmd_rvu_lf_bar_get;
-	rte_pmd_rvu_lf_irq_register;
-	rte_pmd_rvu_lf_irq_unregister;
-	rte_pmd_rvu_lf_msg_handler_register;
-	rte_pmd_rvu_lf_msg_handler_unregister;
-	rte_pmd_rvu_lf_msg_id_range_set;
-	rte_pmd_rvu_lf_msg_process;
-	rte_pmd_rvu_lf_npa_pf_func_get;
-	rte_pmd_rvu_lf_pf_func_get;
-	rte_pmd_rvu_lf_sso_pf_func_get;
-
-	local: *;
-};
diff --git a/drivers/raw/ifpga/version.map b/drivers/raw/ifpga/version.map
deleted file mode 100644
index ebe50925a8..0000000000
--- a/drivers/raw/ifpga/version.map
+++ /dev/null
@@ -1,17 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pmd_ifpga_cleanup;
-	rte_pmd_ifpga_get_dev_id;
-	rte_pmd_ifpga_get_phy_info;
-	rte_pmd_ifpga_get_property;
-	rte_pmd_ifpga_get_rsu_status;
-	rte_pmd_ifpga_partial_reconfigure;
-	rte_pmd_ifpga_reboot_try;
-	rte_pmd_ifpga_reload;
-	rte_pmd_ifpga_set_rsu_status;
-	rte_pmd_ifpga_stop_update;
-	rte_pmd_ifpga_update_flash;
-
-	local: *;
-};
diff --git a/lib/acl/version.map b/lib/acl/version.map
deleted file mode 100644
index 782b1fe464..0000000000
--- a/lib/acl/version.map
+++ /dev/null
@@ -1,19 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_acl_add_rules;
-	rte_acl_build;
-	rte_acl_classify;
-	rte_acl_classify_alg;
-	rte_acl_classify_scalar;
-	rte_acl_create;
-	rte_acl_dump;
-	rte_acl_find_existing;
-	rte_acl_free;
-	rte_acl_list_dump;
-	rte_acl_reset;
-	rte_acl_reset_rules;
-	rte_acl_set_ctx_classify;
-
-	local: *;
-};
diff --git a/lib/argparse/version.map b/lib/argparse/version.map
deleted file mode 100644
index 46da99a3e2..0000000000
--- a/lib/argparse/version.map
+++ /dev/null
@@ -1,9 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 24.03
-	rte_argparse_parse;
-	rte_argparse_parse_type;
-
-	local: *;
-};
diff --git a/lib/bbdev/version.map b/lib/bbdev/version.map
deleted file mode 100644
index b9b4f31e33..0000000000
--- a/lib/bbdev/version.map
+++ /dev/null
@@ -1,47 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_bbdev_allocate;
-	rte_bbdev_callback_register;
-	rte_bbdev_callback_unregister;
-	rte_bbdev_close;
-	rte_bbdev_count;
-	rte_bbdev_device_status_str;
-	rte_bbdev_devices;
-	rte_bbdev_enqueue_status_str;
-	rte_bbdev_find_next;
-	rte_bbdev_get_named_dev;
-	rte_bbdev_info_get;
-	rte_bbdev_intr_enable;
-	rte_bbdev_is_valid;
-	rte_bbdev_op_pool_create;
-	rte_bbdev_op_type_str;
-	rte_bbdev_pmd_callback_process;
-	rte_bbdev_queue_configure;
-	rte_bbdev_queue_info_get;
-	rte_bbdev_queue_intr_ctl;
-	rte_bbdev_queue_intr_disable;
-	rte_bbdev_queue_intr_enable;
-	rte_bbdev_queue_start;
-	rte_bbdev_queue_stop;
-	rte_bbdev_release;
-	rte_bbdev_setup_queues;
-	rte_bbdev_start;
-	rte_bbdev_stats_get;
-	rte_bbdev_stats_reset;
-	rte_bbdev_stop;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 24.11
-	rte_bbdev_queue_ops_dump;
-	rte_bbdev_ops_param_string;
-
-	# added in 25.03
-	__rte_bbdev_trace_dequeue;
-	__rte_bbdev_trace_enqueue;
-};
diff --git a/lib/bitratestats/version.map b/lib/bitratestats/version.map
deleted file mode 100644
index edda26d552..0000000000
--- a/lib/bitratestats/version.map
+++ /dev/null
@@ -1,10 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_stats_bitrate_calc;
-	rte_stats_bitrate_create;
-	rte_stats_bitrate_free;
-	rte_stats_bitrate_reg;
-
-	local: *;
-};
diff --git a/lib/bpf/version.map b/lib/bpf/version.map
deleted file mode 100644
index 239c62a96c..0000000000
--- a/lib/bpf/version.map
+++ /dev/null
@@ -1,18 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_bpf_convert;
-	rte_bpf_destroy;
-	rte_bpf_dump;
-	rte_bpf_elf_load;
-	rte_bpf_eth_rx_elf_load;
-	rte_bpf_eth_rx_unload;
-	rte_bpf_eth_tx_elf_load;
-	rte_bpf_eth_tx_unload;
-	rte_bpf_exec;
-	rte_bpf_exec_burst;
-	rte_bpf_get_jit;
-	rte_bpf_load;
-
-	local: *;
-};
diff --git a/lib/cfgfile/version.map b/lib/cfgfile/version.map
deleted file mode 100644
index 927b4822fe..0000000000
--- a/lib/cfgfile/version.map
+++ /dev/null
@@ -1,23 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_cfgfile_add_entry;
-	rte_cfgfile_add_section;
-	rte_cfgfile_close;
-	rte_cfgfile_create;
-	rte_cfgfile_get_entry;
-	rte_cfgfile_has_entry;
-	rte_cfgfile_has_section;
-	rte_cfgfile_load;
-	rte_cfgfile_load_with_params;
-	rte_cfgfile_num_sections;
-	rte_cfgfile_save;
-	rte_cfgfile_section_entries;
-	rte_cfgfile_section_entries_by_index;
-	rte_cfgfile_section_num_entries;
-	rte_cfgfile_section_num_entries_by_index;
-	rte_cfgfile_sections;
-	rte_cfgfile_set_entry;
-
-	local: *;
-};
diff --git a/lib/cmdline/version.map b/lib/cmdline/version.map
deleted file mode 100644
index 08050ea3f3..0000000000
--- a/lib/cmdline/version.map
+++ /dev/null
@@ -1,82 +0,0 @@
-DPDK_25 {
-	global:
-
-	cirbuf_add_buf_head;
-	cirbuf_add_buf_tail;
-	cirbuf_add_head;
-	cirbuf_add_head_safe;
-	cirbuf_add_tail;
-	cirbuf_add_tail_safe;
-	cirbuf_align_left;
-	cirbuf_align_right;
-	cirbuf_del_buf_head;
-	cirbuf_del_buf_tail;
-	cirbuf_del_head;
-	cirbuf_del_head_safe;
-	cirbuf_del_tail;
-	cirbuf_del_tail_safe;
-	cirbuf_get_buf_head;
-	cirbuf_get_buf_tail;
-	cirbuf_get_head;
-	cirbuf_get_tail;
-	cirbuf_init;
-	cmdline_complete;
-	cmdline_complete_get_elt_string;
-	cmdline_complete_get_nb_string;
-	cmdline_file_new;
-	cmdline_free;
-	cmdline_get_help_etheraddr;
-	cmdline_get_help_ipaddr;
-	cmdline_get_help_num;
-	cmdline_get_help_portlist;
-	cmdline_get_help_string;
-	cmdline_get_rdline;
-	cmdline_in;
-	cmdline_interact;
-	cmdline_isendoftoken;
-	cmdline_new;
-	cmdline_parse;
-	cmdline_parse_check;
-	cmdline_parse_etheraddr;
-	cmdline_parse_ipaddr;
-	cmdline_parse_num;
-	cmdline_parse_portlist;
-	cmdline_parse_string;
-	cmdline_printf;
-	cmdline_quit;
-	cmdline_set_prompt;
-	cmdline_stdin_exit;
-	cmdline_stdin_new;
-	cmdline_token_etheraddr_ops;
-	cmdline_token_ipaddr_ops;
-	cmdline_token_num_ops;
-	cmdline_token_portlist_ops;
-	cmdline_token_string_ops;
-	cmdline_write_char;
-	rdline_add_history;
-	rdline_char_in;
-	rdline_clear_history;
-	rdline_free;
-	rdline_get_buffer;
-	rdline_get_history_buffer_size;
-	rdline_get_history_item;
-	rdline_get_opaque;
-	rdline_new;
-	rdline_newline;
-	rdline_quit;
-	rdline_redisplay;
-	rdline_reset;
-	rdline_restart;
-	rdline_stop;
-	vt100_init;
-	vt100_parser;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 25.03
-	cmdline_token_bool_ops;
-};
\ No newline at end of file
diff --git a/lib/compressdev/version.map b/lib/compressdev/version.map
deleted file mode 100644
index 3849ae2740..0000000000
--- a/lib/compressdev/version.map
+++ /dev/null
@@ -1,40 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_comp_get_feature_name;
-	rte_comp_op_alloc;
-	rte_comp_op_bulk_alloc;
-	rte_comp_op_bulk_free;
-	rte_comp_op_free;
-	rte_comp_op_pool_create;
-	rte_compressdev_capability_get;
-	rte_compressdev_close;
-	rte_compressdev_configure;
-	rte_compressdev_count;
-	rte_compressdev_dequeue_burst;
-	rte_compressdev_devices_get;
-	rte_compressdev_enqueue_burst;
-	rte_compressdev_get_dev_id;
-	rte_compressdev_get_feature_name;
-	rte_compressdev_info_get;
-	rte_compressdev_name_get;
-	rte_compressdev_pmd_allocate;
-	rte_compressdev_pmd_create;
-	rte_compressdev_pmd_destroy;
-	rte_compressdev_pmd_get_named_dev;
-	rte_compressdev_pmd_parse_input_args;
-	rte_compressdev_pmd_release_device;
-	rte_compressdev_private_xform_create;
-	rte_compressdev_private_xform_free;
-	rte_compressdev_queue_pair_count;
-	rte_compressdev_queue_pair_setup;
-	rte_compressdev_socket_id;
-	rte_compressdev_start;
-	rte_compressdev_stats_get;
-	rte_compressdev_stats_reset;
-	rte_compressdev_stop;
-	rte_compressdev_stream_create;
-	rte_compressdev_stream_free;
-
-	local: *;
-};
diff --git a/lib/cryptodev/version.map b/lib/cryptodev/version.map
deleted file mode 100644
index ece27eb173..0000000000
--- a/lib/cryptodev/version.map
+++ /dev/null
@@ -1,114 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_cryptodev_trace_dequeue_burst;
-	__rte_cryptodev_trace_enqueue_burst;
-	rte_crypto_aead_operation_strings;
-	rte_crypto_asym_ke_strings;
-	rte_crypto_asym_op_strings;
-	rte_crypto_auth_operation_strings;
-	rte_crypto_cipher_operation_strings;
-	rte_crypto_fp_ops;
-	rte_crypto_op_pool_create;
-	rte_cryptodev_add_deq_callback;
-	rte_cryptodev_add_enq_callback;
-	rte_cryptodev_asym_capability_get;
-	rte_cryptodev_asym_get_header_session_size;
-	rte_cryptodev_asym_get_private_session_size;
-	rte_cryptodev_asym_get_xform_enum;
-	rte_cryptodev_asym_session_create;
-	rte_cryptodev_asym_session_free;
-	rte_cryptodev_asym_session_get_user_data;
-	rte_cryptodev_asym_session_pool_create;
-	rte_cryptodev_asym_session_set_user_data;
-	rte_cryptodev_asym_xform_capability_check_hash;
-	rte_cryptodev_asym_xform_capability_check_modlen;
-	rte_cryptodev_asym_xform_capability_check_optype;
-	rte_cryptodev_callback_register;
-	rte_cryptodev_callback_unregister;
-	rte_cryptodev_close;
-	rte_cryptodev_configure;
-	rte_cryptodev_configure_raw_dp_ctx;
-	rte_cryptodev_count;
-	rte_cryptodev_device_count_by_driver;
-	rte_cryptodev_devices_get;
-	rte_cryptodev_driver_id_get;
-	rte_cryptodev_driver_name_get;
-	rte_cryptodev_get_aead_algo_enum;
-	rte_cryptodev_get_auth_algo_enum;
-	rte_cryptodev_get_cipher_algo_enum;
-	rte_cryptodev_get_dev_id;
-	rte_cryptodev_get_feature_name;
-	rte_cryptodev_get_qp_status;
-	rte_cryptodev_get_raw_dp_ctx_size;
-	rte_cryptodev_get_sec_ctx;
-	rte_cryptodev_info_get;
-	rte_cryptodev_is_valid_dev;
-	rte_cryptodev_logtype;
-	rte_cryptodev_name_get;
-	rte_cryptodev_queue_pair_count;
-	rte_cryptodev_queue_pair_setup;
-	rte_cryptodev_raw_dequeue_burst;
-	rte_cryptodev_raw_dequeue_done;
-	rte_cryptodev_raw_enqueue_burst;
-	rte_cryptodev_raw_enqueue_done;
-	rte_cryptodev_remove_deq_callback;
-	rte_cryptodev_remove_enq_callback;
-	rte_cryptodev_session_event_mdata_set;
-	rte_cryptodev_socket_id;
-	rte_cryptodev_start;
-	rte_cryptodev_stats_get;
-	rte_cryptodev_stats_reset;
-	rte_cryptodev_stop;
-	rte_cryptodev_sym_capability_check_aead;
-	rte_cryptodev_sym_capability_check_auth;
-	rte_cryptodev_sym_capability_check_cipher;
-	rte_cryptodev_sym_capability_get;
-	rte_cryptodev_sym_cpu_crypto_process;
-	rte_cryptodev_sym_get_private_session_size;
-	rte_cryptodev_sym_session_create;
-	rte_cryptodev_sym_session_free;
-	rte_cryptodev_sym_session_get_user_data;
-	rte_cryptodev_sym_session_pool_create;
-	rte_cryptodev_sym_session_set_user_data;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.03
-	rte_cryptodev_asym_get_xform_string;
-	rte_cryptodev_get_aead_algo_string;
-	rte_cryptodev_get_auth_algo_string;
-	rte_cryptodev_get_cipher_algo_string;
-	rte_cryptodev_queue_pair_event_error_query;
-
-	# added in 24.03
-	__rte_cryptodev_trace_qp_depth_used;
-
-	# added in 24.11
-	rte_cryptodev_asym_xform_capability_check_opcap;
-	rte_cryptodev_queue_pair_reset;
-};
-
-INTERNAL {
-	global:
-
-	cryptodev_fp_ops_reset;
-	cryptodev_fp_ops_set;
-	rte_cryptodev_allocate_driver;
-	rte_cryptodev_pmd_allocate;
-	rte_cryptodev_pmd_callback_process;
-	rte_cryptodev_pmd_create;
-	rte_cryptodev_pmd_create_dev_name;
-	rte_cryptodev_pmd_destroy;
-	rte_cryptodev_pmd_get_dev;
-	rte_cryptodev_pmd_get_named_dev;
-	rte_cryptodev_pmd_parse_input_args;
-	rte_cryptodev_pmd_probing_finish;
-	rte_cryptodev_pmd_release_device;
-	rte_cryptodev_session_event_mdata_get;
-	rte_cryptodevs;
-};
diff --git a/lib/dispatcher/version.map b/lib/dispatcher/version.map
deleted file mode 100644
index 44585e4f15..0000000000
--- a/lib/dispatcher/version.map
+++ /dev/null
@@ -1,20 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 23.11
-	rte_dispatcher_bind_port_to_lcore;
-	rte_dispatcher_create;
-	rte_dispatcher_finalize_register;
-	rte_dispatcher_finalize_unregister;
-	rte_dispatcher_free;
-	rte_dispatcher_register;
-	rte_dispatcher_service_id_get;
-	rte_dispatcher_start;
-	rte_dispatcher_stats_get;
-	rte_dispatcher_stats_reset;
-	rte_dispatcher_stop;
-	rte_dispatcher_unbind_port_from_lcore;
-	rte_dispatcher_unregister;
-
-	local: *;
-};
diff --git a/lib/distributor/version.map b/lib/distributor/version.map
deleted file mode 100644
index b5ec7dfaca..0000000000
--- a/lib/distributor/version.map
+++ /dev/null
@@ -1,15 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_distributor_clear_returns;
-	rte_distributor_create;
-	rte_distributor_flush;
-	rte_distributor_get_pkt;
-	rte_distributor_poll_pkt;
-	rte_distributor_process;
-	rte_distributor_request_pkt;
-	rte_distributor_return_pkt;
-	rte_distributor_returned_pkts;
-
-	local: *;
-};
diff --git a/lib/dmadev/version.map b/lib/dmadev/version.map
deleted file mode 100644
index 822aaa2d3b..0000000000
--- a/lib/dmadev/version.map
+++ /dev/null
@@ -1,47 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_dma_close;
-	rte_dma_configure;
-	rte_dma_count_avail;
-	rte_dma_dev_max;
-	rte_dma_dump;
-	rte_dma_get_dev_id_by_name;
-	rte_dma_info_get;
-	rte_dma_is_valid;
-	rte_dma_next_dev;
-	rte_dma_start;
-	rte_dma_stats_get;
-	rte_dma_stats_reset;
-	rte_dma_stop;
-	rte_dma_vchan_setup;
-	rte_dma_vchan_status;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 24.03
-	__rte_dma_trace_burst_capacity;
-	__rte_dma_trace_completed;
-	__rte_dma_trace_completed_status;
-	__rte_dma_trace_copy;
-	__rte_dma_trace_copy_sg;
-	__rte_dma_trace_fill;
-	__rte_dma_trace_submit;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_dma_fp_objs;
-	rte_dma_pmd_allocate;
-	rte_dma_pmd_get_dev_by_id;
-	rte_dma_pmd_release;
-
-	local: *;
-};
diff --git a/lib/eal/version.map b/lib/eal/version.map
deleted file mode 100644
index a20c713eb1..0000000000
--- a/lib/eal/version.map
+++ /dev/null
@@ -1,451 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_panic;
-	eal_parse_sysfs_value; # WINDOWS_NO_EXPORT
-	eal_timer_source; # WINDOWS_NO_EXPORT
-	per_lcore__lcore_id;
-	per_lcore__rte_errno;
-	per_lcore__thread_id;
-	rte_bus_dump;
-	rte_bus_find;
-	rte_bus_find_by_device;
-	rte_bus_find_by_name;
-	rte_bus_get_iommu_class;
-	rte_bus_name;
-	rte_bus_probe;
-	rte_bus_scan;
-	rte_calloc;
-	rte_calloc_socket;
-	rte_class_find;
-	rte_class_find_by_name;
-	rte_class_register;
-	rte_class_unregister;
-	rte_cpu_get_flag_enabled;
-	rte_cpu_get_flag_name;
-	rte_cpu_get_intrinsics_support; # WINDOWS_NO_EXPORT
-	rte_cpu_is_supported; # WINDOWS_NO_EXPORT
-	rte_cycles_vmware_tsc_map; # WINDOWS_NO_EXPORT
-	rte_delay_us;
-	rte_delay_us_block;
-	rte_delay_us_callback_register;
-	rte_delay_us_sleep;
-	rte_dev_bus;
-	rte_dev_bus_info;
-	rte_dev_devargs;
-	rte_dev_dma_map;
-	rte_dev_dma_unmap;
-	rte_dev_driver;
-	rte_dev_event_callback_process;
-	rte_dev_event_callback_register;
-	rte_dev_event_callback_unregister;
-	rte_dev_event_monitor_start;
-	rte_dev_event_monitor_stop;
-	rte_dev_hotplug_handle_disable;
-	rte_dev_hotplug_handle_enable;
-	rte_dev_is_probed;
-	rte_dev_iterator_init;
-	rte_dev_iterator_next;
-	rte_dev_name;
-	rte_dev_numa_node;
-	rte_dev_probe;
-	rte_dev_remove;
-	rte_devargs_add;
-	rte_devargs_dump;
-	rte_devargs_insert;
-	rte_devargs_next;
-	rte_devargs_parse;
-	rte_devargs_parsef;
-	rte_devargs_remove;
-	rte_devargs_reset;
-	rte_devargs_type_count;
-	rte_drand;
-	rte_driver_name;
-	rte_dump_physmem_layout;
-	rte_dump_stack;
-	rte_dump_tailq;
-	rte_eal_alarm_cancel;
-	rte_eal_alarm_set;
-	rte_eal_cleanup;
-	rte_eal_create_uio_dev; # WINDOWS_NO_EXPORT
-	rte_eal_get_lcore_state;
-	rte_eal_get_physmem_size;
-	rte_eal_get_runtime_dir;
-	rte_eal_has_hugepages;
-	rte_eal_has_pci;
-	rte_eal_hotplug_add;
-	rte_eal_hotplug_remove;
-	rte_eal_hpet_init; # WINDOWS_NO_EXPORT
-	rte_eal_init;
-	rte_eal_iopl_init; # WINDOWS_NO_EXPORT
-	rte_eal_iova_mode;
-	rte_eal_lcore_role;
-	rte_eal_mbuf_user_pool_ops;
-	rte_eal_mp_remote_launch;
-	rte_eal_mp_wait_lcore;
-	rte_eal_primary_proc_alive; # WINDOWS_NO_EXPORT
-	rte_eal_process_type;
-	rte_eal_remote_launch;
-	rte_eal_tailq_lookup;
-	rte_eal_tailq_register;
-	rte_eal_using_phys_addrs;
-	rte_eal_vfio_get_vf_token; # WINDOWS_NO_EXPORT
-	rte_eal_vfio_intr_mode; # WINDOWS_NO_EXPORT
-	rte_eal_wait_lcore;
-	rte_epoll_ctl;
-	rte_epoll_wait;
-	rte_epoll_wait_interruptible;
-	rte_exit;
-	rte_extmem_attach;
-	rte_extmem_detach;
-	rte_extmem_register;
-	rte_extmem_unregister;
-	rte_fbarray_attach;
-	rte_fbarray_destroy;
-	rte_fbarray_detach;
-	rte_fbarray_dump_metadata;
-	rte_fbarray_find_biggest_free;
-	rte_fbarray_find_biggest_used;
-	rte_fbarray_find_contig_free;
-	rte_fbarray_find_contig_used;
-	rte_fbarray_find_idx;
-	rte_fbarray_find_next_free;
-	rte_fbarray_find_next_n_free;
-	rte_fbarray_find_next_n_used;
-	rte_fbarray_find_next_used;
-	rte_fbarray_find_prev_free;
-	rte_fbarray_find_prev_n_free;
-	rte_fbarray_find_prev_n_used;
-	rte_fbarray_find_prev_used;
-	rte_fbarray_find_rev_biggest_free;
-	rte_fbarray_find_rev_biggest_used;
-	rte_fbarray_find_rev_contig_free;
-	rte_fbarray_find_rev_contig_used;
-	rte_fbarray_get;
-	rte_fbarray_init;
-	rte_fbarray_is_used;
-	rte_fbarray_set_free;
-	rte_fbarray_set_used;
-	rte_free;
-	rte_get_hpet_cycles; # WINDOWS_NO_EXPORT
-	rte_get_hpet_hz; # WINDOWS_NO_EXPORT
-	rte_get_main_lcore;
-	rte_get_next_lcore;
-	rte_get_tsc_hz;
-	rte_hexdump;
-	rte_hypervisor_get;
-	rte_hypervisor_get_name; # WINDOWS_NO_EXPORT
-	rte_intr_ack;
-	rte_intr_callback_register;
-	rte_intr_callback_unregister;
-	rte_intr_callback_unregister_pending;
-	rte_intr_callback_unregister_sync;
-	rte_intr_disable;
-	rte_intr_enable;
-	rte_intr_fd_get;
-	rte_intr_fd_set;
-	rte_intr_instance_alloc;
-	rte_intr_instance_free;
-	rte_intr_type_get;
-	rte_intr_type_set;
-	rte_keepalive_create; # WINDOWS_NO_EXPORT
-	rte_keepalive_dispatch_pings; # WINDOWS_NO_EXPORT
-	rte_keepalive_mark_alive; # WINDOWS_NO_EXPORT
-	rte_keepalive_mark_sleep; # WINDOWS_NO_EXPORT
-	rte_keepalive_register_core; # WINDOWS_NO_EXPORT
-	rte_keepalive_register_relay_callback; # WINDOWS_NO_EXPORT
-	rte_lcore_callback_register;
-	rte_lcore_callback_unregister;
-	rte_lcore_count;
-	rte_lcore_cpuset;
-	rte_lcore_dump;
-	rte_lcore_has_role;
-	rte_lcore_index;
-	rte_lcore_is_enabled;
-	rte_lcore_iterate;
-	rte_lcore_to_cpu_id;
-	rte_lcore_to_socket_id;
-	rte_lcore_register_usage_cb;
-	rte_malloc;
-	rte_malloc_dump_heaps;
-	rte_malloc_dump_stats;
-	rte_malloc_get_socket_stats;
-	rte_malloc_heap_create;
-	rte_malloc_heap_destroy;
-	rte_malloc_heap_get_socket;
-	rte_malloc_heap_memory_add;
-	rte_malloc_heap_memory_attach;
-	rte_malloc_heap_memory_detach;
-	rte_malloc_heap_memory_remove;
-	rte_malloc_heap_socket_is_external;
-	rte_malloc_socket;
-	rte_malloc_validate;
-	rte_malloc_virt2iova;
-	rte_mcfg_get_single_file_segments;
-	rte_mcfg_mem_read_lock;
-	rte_mcfg_mem_read_unlock;
-	rte_mcfg_mem_write_lock;
-	rte_mcfg_mem_write_unlock;
-	rte_mcfg_mempool_read_lock;
-	rte_mcfg_mempool_read_unlock;
-	rte_mcfg_mempool_write_lock;
-	rte_mcfg_mempool_write_unlock;
-	rte_mcfg_tailq_read_lock;
-	rte_mcfg_tailq_read_unlock;
-	rte_mcfg_tailq_write_lock;
-	rte_mcfg_tailq_write_unlock;
-	rte_mcfg_timer_lock;
-	rte_mcfg_timer_unlock;
-	rte_mem_alloc_validator_register;
-	rte_mem_alloc_validator_unregister;
-	rte_mem_check_dma_mask;
-	rte_mem_check_dma_mask_thread_unsafe;
-	rte_mem_event_callback_register;
-	rte_mem_event_callback_unregister;
-	rte_mem_iova2virt;
-	rte_mem_lock_page;
-	rte_mem_set_dma_mask;
-	rte_mem_virt2iova;
-	rte_mem_virt2memseg;
-	rte_mem_virt2memseg_list;
-	rte_mem_virt2phy;
-	rte_memdump;
-	rte_memory_get_nchannel;
-	rte_memory_get_nrank;
-	rte_memseg_contig_walk;
-	rte_memseg_contig_walk_thread_unsafe;
-	rte_memseg_get_fd;
-	rte_memseg_get_fd_offset;
-	rte_memseg_get_fd_offset_thread_unsafe;
-	rte_memseg_get_fd_thread_unsafe;
-	rte_memseg_list_walk;
-	rte_memseg_list_walk_thread_unsafe;
-	rte_memseg_walk;
-	rte_memseg_walk_thread_unsafe;
-	rte_memzone_dump;
-	rte_memzone_free;
-	rte_memzone_lookup;
-	rte_memzone_max_get;
-	rte_memzone_max_set;
-	rte_memzone_reserve;
-	rte_memzone_reserve_aligned;
-	rte_memzone_reserve_bounded;
-	rte_memzone_walk;
-	rte_mp_action_register;
-	rte_mp_action_unregister;
-	rte_mp_disable;
-	rte_mp_reply;
-	rte_mp_request_async;
-	rte_mp_request_sync;
-	rte_mp_sendmsg;
-	rte_power_monitor; # WINDOWS_NO_EXPORT
-	rte_power_monitor_multi; # WINDOWS_NO_EXPORT
-	rte_power_monitor_wakeup; # WINDOWS_NO_EXPORT
-	rte_power_pause; # WINDOWS_NO_EXPORT
-	rte_rand;
-	rte_rand_max;
-	rte_realloc;
-	rte_realloc_socket;
-	rte_reciprocal_value;
-	rte_reciprocal_value_u64;
-	rte_rtm_supported;
-	rte_service_attr_get;
-	rte_service_attr_reset_all;
-	rte_service_component_register;
-	rte_service_component_runstate_set;
-	rte_service_component_unregister;
-	rte_service_dump;
-	rte_service_finalize;
-	rte_service_get_by_name;
-	rte_service_get_count;
-	rte_service_get_name;
-	rte_service_lcore_add;
-	rte_service_lcore_attr_get;
-	rte_service_lcore_attr_reset_all;
-	rte_service_lcore_count;
-	rte_service_lcore_count_services;
-	rte_service_lcore_del;
-	rte_service_lcore_list;
-	rte_service_lcore_may_be_active;
-	rte_service_lcore_reset_all;
-	rte_service_lcore_start;
-	rte_service_lcore_stop;
-	rte_service_map_lcore_get;
-	rte_service_map_lcore_set;
-	rte_service_may_be_active;
-	rte_service_probe_capability;
-	rte_service_run_iter_on_app_lcore;
-	rte_service_runstate_get;
-	rte_service_runstate_set;
-	rte_service_set_runstate_mapped_check;
-	rte_service_set_stats_enable;
-	rte_service_start_with_defaults;
-	rte_set_application_usage_hook;
-	rte_socket_count;
-	rte_socket_id;
-	rte_socket_id_by_idx;
-	rte_srand;
-	rte_str_to_size;
-	rte_strerror;
-	rte_strscpy;
-	rte_strsplit;
-	rte_sys_gettid;
-	rte_thread_attr_get_affinity;
-	rte_thread_attr_init;
-	rte_thread_attr_set_affinity;
-	rte_thread_attr_set_priority;
-	rte_thread_create;
-	rte_thread_create_control;
-	rte_thread_detach;
-	rte_thread_equal;
-	rte_thread_get_affinity;
-	rte_thread_get_affinity_by_id;
-	rte_thread_get_priority;
-	rte_thread_is_intr;
-	rte_thread_join;
-	rte_thread_key_create;
-	rte_thread_key_delete;
-	rte_thread_register;
-	rte_thread_self;
-	rte_thread_set_affinity;
-	rte_thread_set_affinity_by_id;
-	rte_thread_set_name;
-	rte_thread_set_priority;
-	rte_thread_unregister;
-	rte_thread_value_get;
-	rte_thread_value_set;
-	rte_uuid_compare;
-	rte_uuid_is_null;
-	rte_uuid_parse;
-	rte_uuid_unparse;
-	rte_vect_get_max_simd_bitwidth;
-	rte_vect_set_max_simd_bitwidth;
-	rte_version;
-	rte_version_minor;
-	rte_version_month;
-	rte_version_prefix;
-	rte_version_release;
-	rte_version_suffix;
-	rte_version_year;
-	rte_vfio_clear_group; # WINDOWS_NO_EXPORT
-	rte_vfio_container_create; # WINDOWS_NO_EXPORT
-	rte_vfio_container_destroy; # WINDOWS_NO_EXPORT
-	rte_vfio_container_dma_map;
-	rte_vfio_container_dma_unmap;
-	rte_vfio_container_group_bind; # WINDOWS_NO_EXPORT
-	rte_vfio_container_group_unbind; # WINDOWS_NO_EXPORT
-	rte_vfio_enable; # WINDOWS_NO_EXPORT
-	rte_vfio_get_container_fd; # WINDOWS_NO_EXPORT
-	rte_vfio_get_group_fd; # WINDOWS_NO_EXPORT
-	rte_vfio_get_group_num; # WINDOWS_NO_EXPORT
-	rte_vfio_is_enabled; # WINDOWS_NO_EXPORT
-	rte_vfio_noiommu_is_enabled; # WINDOWS_NO_EXPORT
-	rte_vfio_release_device; # WINDOWS_NO_EXPORT
-	rte_vfio_setup_device; # WINDOWS_NO_EXPORT
-	rte_zmalloc;
-	rte_zmalloc_socket;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.05
-	__rte_eal_trace_generic_double;
-	__rte_eal_trace_generic_float;
-	__rte_eal_trace_generic_func;
-	__rte_eal_trace_generic_i16;
-	__rte_eal_trace_generic_i32;
-	__rte_eal_trace_generic_i64;
-	__rte_eal_trace_generic_i8;
-	__rte_eal_trace_generic_int;
-	__rte_eal_trace_generic_long;
-	__rte_eal_trace_generic_ptr;
-	__rte_eal_trace_generic_str;
-	__rte_eal_trace_generic_u16;
-	__rte_eal_trace_generic_u32;
-	__rte_eal_trace_generic_u64;
-	__rte_eal_trace_generic_u8;
-	__rte_eal_trace_generic_void;
-	__rte_trace_mem_per_thread_alloc;
-	__rte_trace_point_emit_field;
-	__rte_trace_point_register;
-	per_lcore_trace_mem;
-	per_lcore_trace_point_sz;
-	rte_trace_dump; # WINDOWS_NO_EXPORT
-	rte_trace_is_enabled; # WINDOWS_NO_EXPORT
-	rte_trace_metadata_dump; # WINDOWS_NO_EXPORT
-	rte_trace_mode_get; # WINDOWS_NO_EXPORT
-	rte_trace_mode_set; # WINDOWS_NO_EXPORT
-	rte_trace_pattern; # WINDOWS_NO_EXPORT
-	rte_trace_point_disable; # WINDOWS_NO_EXPORT
-	rte_trace_point_enable; # WINDOWS_NO_EXPORT
-	rte_trace_point_is_enabled; # WINDOWS_NO_EXPORT
-	rte_trace_point_lookup; # WINDOWS_NO_EXPORT
-	rte_trace_regexp; # WINDOWS_NO_EXPORT
-	rte_trace_save; # WINDOWS_NO_EXPORT
-
-	# added in 20.11
-	__rte_eal_trace_generic_size_t; # WINDOWS_NO_EXPORT
-
-	# added in 23.03
-	__rte_eal_trace_generic_blob;
-
-	# added in 24.03
-	rte_vfio_get_device_info; # WINDOWS_NO_EXPORT
-
-	# added in 24.11
-	rte_bitset_to_str;
-	rte_lcore_var_alloc;
-};
-
-INTERNAL {
-	global:
-
-	rte_bus_register;
-	rte_bus_unregister;
-	rte_eal_get_baseaddr;
-	rte_eal_parse_coremask;
-	rte_firmware_read;
-	rte_intr_allow_others;
-	rte_intr_cap_multiple;
-	rte_intr_dev_fd_get;
-	rte_intr_dev_fd_set;
-	rte_intr_dp_is_en;
-	rte_intr_efd_counter_size_set;
-	rte_intr_efd_counter_size_get;
-	rte_intr_efd_disable;
-	rte_intr_efd_enable;
-	rte_intr_efds_index_get;
-	rte_intr_efds_index_set;
-	rte_intr_elist_index_get;
-	rte_intr_elist_index_set;
-	rte_intr_event_list_update;
-	rte_intr_free_epoll_fd;
-	rte_intr_instance_dup;
-	rte_intr_instance_windows_handle_get;
-	rte_intr_instance_windows_handle_set;
-	rte_intr_max_intr_get;
-	rte_intr_max_intr_set;
-	rte_intr_nb_efd_get;
-	rte_intr_nb_efd_set;
-	rte_intr_nb_intr_get;
-	rte_intr_rx_ctl;
-	rte_intr_tls_epfd;
-	rte_intr_vec_list_alloc;
-	rte_intr_vec_list_free;
-	rte_intr_vec_list_index_get;
-	rte_intr_vec_list_index_set;
-	rte_mcfg_ethdev_get_lock;
-	rte_mcfg_mem_get_lock;
-	rte_mcfg_mempool_get_lock;
-	rte_mcfg_tailq_get_lock;
-	rte_mcfg_timer_get_lock;
-	rte_mem_lock;
-	rte_mem_map;
-	rte_mem_page_size;
-	rte_mem_unmap;
-	rte_thread_create_internal_control;
-	rte_thread_set_prefixed_name;
-};
diff --git a/lib/efd/version.map b/lib/efd/version.map
deleted file mode 100644
index 354c7f88bd..0000000000
--- a/lib/efd/version.map
+++ /dev/null
@@ -1,13 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_efd_create;
-	rte_efd_delete;
-	rte_efd_find_existing;
-	rte_efd_free;
-	rte_efd_lookup;
-	rte_efd_lookup_bulk;
-	rte_efd_update;
-
-	local: *;
-};
diff --git a/lib/ethdev/version.map b/lib/ethdev/version.map
deleted file mode 100644
index 3aacba8614..0000000000
--- a/lib/ethdev/version.map
+++ /dev/null
@@ -1,378 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_add_first_rx_callback;
-	rte_eth_add_rx_callback;
-	rte_eth_add_tx_callback;
-	rte_eth_allmulticast_disable;
-	rte_eth_allmulticast_enable;
-	rte_eth_allmulticast_get;
-	rte_eth_call_rx_callbacks;
-	rte_eth_call_tx_callbacks;
-	rte_eth_dev_adjust_nb_rx_tx_desc;
-	rte_eth_dev_callback_register;
-	rte_eth_dev_callback_unregister;
-	rte_eth_dev_close;
-	rte_eth_dev_configure;
-	rte_eth_dev_count_avail;
-	rte_eth_dev_count_total;
-	rte_eth_dev_default_mac_addr_set;
-	rte_eth_dev_flow_ctrl_get;
-	rte_eth_dev_flow_ctrl_set;
-	rte_eth_dev_fw_version_get;
-	rte_eth_dev_get_dcb_info;
-	rte_eth_dev_get_eeprom;
-	rte_eth_dev_get_eeprom_length;
-	rte_eth_dev_get_mtu;
-	rte_eth_dev_get_name_by_port;
-	rte_eth_dev_get_port_by_name;
-	rte_eth_dev_get_reg_info;
-	rte_eth_dev_get_sec_ctx;
-	rte_eth_dev_get_supported_ptypes;
-	rte_eth_dev_get_vlan_offload;
-	rte_eth_dev_info_get;
-	rte_eth_dev_is_removed;
-	rte_eth_dev_is_valid_port;
-	rte_eth_dev_logtype;
-	rte_eth_dev_mac_addr_add;
-	rte_eth_dev_mac_addr_remove;
-	rte_eth_dev_owner_delete;
-	rte_eth_dev_owner_get;
-	rte_eth_dev_owner_new;
-	rte_eth_dev_owner_set;
-	rte_eth_dev_owner_unset;
-	rte_eth_dev_pool_ops_supported;
-	rte_eth_dev_priority_flow_ctrl_set;
-	rte_eth_dev_reset;
-	rte_eth_dev_rss_hash_conf_get;
-	rte_eth_dev_rss_hash_update;
-	rte_eth_dev_rss_reta_query;
-	rte_eth_dev_rss_reta_update;
-	rte_eth_dev_rx_intr_ctl;
-	rte_eth_dev_rx_intr_ctl_q;
-	rte_eth_dev_rx_intr_ctl_q_get_fd;
-	rte_eth_dev_rx_intr_disable;
-	rte_eth_dev_rx_intr_enable;
-	rte_eth_dev_rx_offload_name;
-	rte_eth_dev_rx_queue_start;
-	rte_eth_dev_rx_queue_stop;
-	rte_eth_dev_set_eeprom;
-	rte_eth_dev_set_link_down;
-	rte_eth_dev_set_link_up;
-	rte_eth_dev_set_mc_addr_list;
-	rte_eth_dev_set_mtu;
-	rte_eth_dev_set_ptypes;
-	rte_eth_dev_set_rx_queue_stats_mapping;
-	rte_eth_dev_set_tx_queue_stats_mapping;
-	rte_eth_dev_set_vlan_ether_type;
-	rte_eth_dev_set_vlan_offload;
-	rte_eth_dev_set_vlan_pvid;
-	rte_eth_dev_set_vlan_strip_on_queue;
-	rte_eth_dev_socket_id;
-	rte_eth_dev_start;
-	rte_eth_dev_stop;
-	rte_eth_dev_tx_offload_name;
-	rte_eth_dev_tx_queue_start;
-	rte_eth_dev_tx_queue_stop;
-	rte_eth_dev_uc_all_hash_table_set;
-	rte_eth_dev_uc_hash_table_set;
-	rte_eth_dev_udp_tunnel_port_add;
-	rte_eth_dev_udp_tunnel_port_delete;
-	rte_eth_dev_vlan_filter;
-	rte_eth_find_next;
-	rte_eth_find_next_of;
-	rte_eth_find_next_owned_by;
-	rte_eth_find_next_sibling;
-	rte_eth_fp_ops;
-	rte_eth_iterator_cleanup;
-	rte_eth_iterator_init;
-	rte_eth_iterator_next;
-	rte_eth_led_off;
-	rte_eth_led_on;
-	rte_eth_link_get;
-	rte_eth_link_get_nowait;
-	rte_eth_macaddr_get;
-	rte_eth_promiscuous_disable;
-	rte_eth_promiscuous_enable;
-	rte_eth_promiscuous_get;
-	rte_eth_remove_rx_callback;
-	rte_eth_remove_tx_callback;
-	rte_eth_rx_burst_mode_get;
-	rte_eth_rx_metadata_negotiate;
-	rte_eth_rx_queue_info_get;
-	rte_eth_rx_queue_setup;
-	rte_eth_set_queue_rate_limit;
-	rte_eth_speed_bitflag;
-	rte_eth_stats_get;
-	rte_eth_stats_reset;
-	rte_eth_timesync_adjust_time;
-	rte_eth_timesync_disable;
-	rte_eth_timesync_enable;
-	rte_eth_timesync_read_rx_timestamp;
-	rte_eth_timesync_read_time;
-	rte_eth_timesync_read_tx_timestamp;
-	rte_eth_timesync_write_time;
-	rte_eth_tx_buffer_count_callback;
-	rte_eth_tx_buffer_drop_callback;
-	rte_eth_tx_buffer_init;
-	rte_eth_tx_buffer_set_err_callback;
-	rte_eth_tx_burst_mode_get;
-	rte_eth_tx_done_cleanup;
-	rte_eth_tx_queue_info_get;
-	rte_eth_tx_queue_setup;
-	rte_eth_xstats_get;
-	rte_eth_xstats_get_by_id;
-	rte_eth_xstats_get_id_by_name;
-	rte_eth_xstats_get_names;
-	rte_eth_xstats_get_names_by_id;
-	rte_eth_xstats_reset;
-	rte_flow_copy;
-	rte_flow_create;
-	rte_flow_destroy;
-	rte_flow_error_set;
-	rte_flow_flush;
-	rte_flow_isolate;
-	rte_flow_pick_transfer_proxy;
-	rte_flow_query;
-	rte_flow_validate;
-	rte_tm_capabilities_get;
-	rte_tm_get_number_of_leaf_nodes;
-	rte_tm_hierarchy_commit;
-	rte_tm_level_capabilities_get;
-	rte_tm_mark_ip_dscp;
-	rte_tm_mark_ip_ecn;
-	rte_tm_mark_vlan_dei;
-	rte_tm_node_add;
-	rte_tm_node_capabilities_get;
-	rte_tm_node_cman_update;
-	rte_tm_node_delete;
-	rte_tm_node_parent_update;
-	rte_tm_node_resume;
-	rte_tm_node_shaper_update;
-	rte_tm_node_shared_shaper_update;
-	rte_tm_node_shared_wred_context_update;
-	rte_tm_node_stats_read;
-	rte_tm_node_stats_update;
-	rte_tm_node_suspend;
-	rte_tm_node_type_get;
-	rte_tm_node_wfq_weight_mode_update;
-	rte_tm_node_wred_context_update;
-	rte_tm_shaper_profile_add;
-	rte_tm_shaper_profile_delete;
-	rte_tm_shared_shaper_add_update;
-	rte_tm_shared_shaper_delete;
-	rte_tm_shared_wred_context_add_update;
-	rte_tm_shared_wred_context_delete;
-	rte_tm_wred_profile_add;
-	rte_tm_wred_profile_delete;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 17.11
-	rte_mtr_capabilities_get;
-	rte_mtr_create;
-	rte_mtr_destroy;
-	rte_mtr_meter_disable;
-	rte_mtr_meter_dscp_table_update;
-	rte_mtr_meter_enable;
-	rte_mtr_meter_profile_add;
-	rte_mtr_meter_profile_delete;
-	rte_mtr_meter_profile_update;
-	rte_mtr_stats_read;
-	rte_mtr_stats_update;
-
-	# added in 18.05
-	rte_eth_dev_get_module_eeprom;
-	rte_eth_dev_get_module_info;
-
-	# added in 18.11
-	rte_flow_conv;
-
-	# added in 19.08
-	rte_eth_read_clock;
-
-	# added in 19.11
-	rte_eth_dev_hairpin_capability_get;
-	rte_eth_rx_hairpin_queue_setup;
-	rte_eth_tx_hairpin_queue_setup;
-	rte_flow_dynf_metadata_offs;
-	rte_flow_dynf_metadata_mask;
-	rte_flow_dynf_metadata_register;
-
-	# added in 20.02
-	rte_flow_dev_dump;
-
-	# added in 20.05
-	__rte_ethdev_trace_tx_burst;
-	rte_flow_get_aged_flows;
-
-	# added in 20.11
-	rte_eth_hairpin_bind;
-	rte_eth_hairpin_get_peer_ports;
-	rte_eth_hairpin_unbind;
-	rte_eth_link_speed_to_str;
-	rte_eth_link_to_str;
-	rte_eth_fec_get_capability;
-	rte_eth_fec_get;
-	rte_eth_fec_set;
-	rte_flow_tunnel_decap_set;
-	rte_flow_tunnel_match;
-	rte_flow_get_restore_info;
-	rte_flow_tunnel_action_decap_release;
-	rte_flow_tunnel_item_release;
-
-	# added in 21.02
-	rte_eth_get_monitor_addr;
-
-	# added in 21.05
-	rte_eth_representor_info_get;
-	rte_flow_action_handle_create;
-	rte_flow_action_handle_destroy;
-	rte_flow_action_handle_update;
-	rte_flow_action_handle_query;
-	rte_mtr_meter_policy_add;
-	rte_mtr_meter_policy_delete;
-	rte_mtr_meter_policy_update;
-	rte_mtr_meter_policy_validate;
-
-	# added in 21.11
-	rte_eth_dev_capability_name;
-	rte_eth_dev_conf_get;
-	rte_eth_macaddrs_get;
-	rte_flow_flex_item_create;
-	rte_flow_flex_item_release;
-
-	# added in 22.03
-	rte_eth_dev_priority_flow_ctrl_queue_configure;
-	rte_eth_dev_priority_flow_ctrl_queue_info_get;
-	rte_eth_dev_priv_dump;
-	rte_eth_ip_reassembly_capability_get;
-	rte_eth_ip_reassembly_conf_get;
-	rte_eth_ip_reassembly_conf_set;
-	rte_flow_info_get;
-	rte_flow_configure;
-	rte_flow_pattern_template_create;
-	rte_flow_pattern_template_destroy;
-	rte_flow_actions_template_create;
-	rte_flow_actions_template_destroy;
-	rte_flow_template_table_create;
-	rte_flow_template_table_destroy;
-	rte_flow_async_create;
-	rte_flow_async_destroy;
-	rte_flow_push;
-	rte_flow_pull;
-	rte_flow_async_action_handle_create;
-	rte_flow_async_action_handle_destroy;
-	rte_flow_async_action_handle_update;
-
-	# added in 22.07
-	rte_eth_rx_avail_thresh_query;
-	rte_eth_rx_avail_thresh_set;
-	rte_mtr_color_in_protocol_get;
-	rte_mtr_color_in_protocol_priority_get;
-	rte_mtr_color_in_protocol_set;
-	rte_mtr_meter_vlan_table_update;
-
-	# added in 22.11
-	rte_eth_buffer_split_get_supported_hdr_ptypes;
-	rte_eth_cman_config_get;
-	rte_eth_cman_config_init;
-	rte_eth_cman_config_set;
-	rte_eth_cman_info_get;
-	rte_eth_rx_descriptor_dump;
-	rte_eth_tx_descriptor_dump;
-	rte_flow_async_action_handle_query;
-	rte_flow_get_q_aged_flows;
-	rte_mtr_meter_policy_get;
-	rte_mtr_meter_profile_get;
-
-	# added in 23.03
-	rte_eth_dev_count_aggr_ports;
-	rte_eth_dev_map_aggr_tx_affinity;
-	rte_flow_action_handle_query_update;
-	rte_flow_async_action_handle_query_update;
-	rte_flow_async_create_by_index;
-
-	# added in 23.07
-	rte_eth_rx_queue_is_valid;
-	rte_eth_tx_queue_is_valid;
-	rte_flow_action_list_handle_create;
-	rte_flow_action_list_handle_destroy;
-	rte_flow_action_list_handle_query_update;
-	rte_flow_actions_update;
-	rte_flow_async_action_list_handle_create;
-	rte_flow_async_action_list_handle_destroy;
-	rte_flow_async_action_list_handle_query_update;
-	rte_flow_async_actions_update;
-	rte_flow_restore_info_dynflag;
-
-	# added in 23.11
-	rte_eth_dev_rss_algo_name;
-	rte_eth_recycle_rx_queue_info_get;
-	rte_flow_group_set_miss_actions;
-	rte_flow_calc_table_hash;
-
-	# added in 24.03
-	__rte_eth_trace_tx_queue_count;
-	rte_eth_find_rss_algo;
-	rte_flow_async_update_resized;
-	rte_flow_calc_encap_hash;
-	rte_flow_template_table_resizable;
-	rte_flow_template_table_resize;
-	rte_flow_template_table_resize_complete;
-
-	# added in 24.11
-	__rte_ethdev_trace_rx_burst_empty;
-	__rte_ethdev_trace_rx_burst_nonempty;
-	__rte_eth_trace_call_rx_callbacks_empty;
-	__rte_eth_trace_call_rx_callbacks_nonempty;
-	rte_eth_dev_get_reg_info_ext;
-	rte_eth_speed_lanes_get;
-	rte_eth_speed_lanes_get_capability;
-	rte_eth_speed_lanes_set;
-	rte_eth_timesync_adjust_freq;
-	rte_flow_async_create_by_index_with_pattern;
-	rte_tm_node_query;
-
-	# added in 25.03
-	rte_eth_xstats_query_state;
-	rte_eth_xstats_set_counter;
-};
-
-INTERNAL {
-	global:
-
-	rte_eth_dev_allocate;
-	rte_eth_dev_allocated;
-	rte_eth_dev_attach_secondary;
-	rte_eth_dev_callback_process;
-	rte_eth_dev_create;
-	rte_eth_dev_destroy;
-	rte_eth_dev_get_by_name;
-	rte_eth_dev_is_rx_hairpin_queue;
-	rte_eth_dev_is_tx_hairpin_queue;
-	rte_eth_dev_probing_finish;
-	rte_eth_dev_release_port;
-	rte_eth_dev_internal_reset;
-	rte_eth_devargs_parse;
-	rte_eth_devices;
-	rte_eth_dma_zone_free;
-	rte_eth_dma_zone_reserve;
-	rte_eth_hairpin_queue_peer_bind;
-	rte_eth_hairpin_queue_peer_unbind;
-	rte_eth_hairpin_queue_peer_update;
-	rte_eth_ip_reassembly_dynfield_register;
-	rte_eth_link_speed_ethtool; # WINDOWS_NO_EXPORT
-	rte_eth_link_speed_glink; # WINDOWS_NO_EXPORT
-	rte_eth_link_speed_gset; # WINDOWS_NO_EXPORT
-	rte_eth_pkt_burst_dummy;
-	rte_eth_representor_id_get;
-	rte_eth_switch_domain_alloc;
-	rte_eth_switch_domain_free;
-	rte_flow_fp_default_ops;
-	rte_eth_get_restore_flags;
-};
diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map
deleted file mode 100644
index bff08d6a62..0000000000
--- a/lib/eventdev/version.map
+++ /dev/null
@@ -1,167 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_eventdev_trace_crypto_adapter_enqueue;
-	__rte_eventdev_trace_deq_burst;
-	__rte_eventdev_trace_enq_burst;
-	__rte_eventdev_trace_eth_tx_adapter_enqueue;
-	__rte_eventdev_trace_maintain;
-	__rte_eventdev_trace_timer_arm_burst;
-	__rte_eventdev_trace_timer_arm_tmo_tick_burst;
-	__rte_eventdev_trace_timer_cancel_burst;
-	rte_event_crypto_adapter_caps_get;
-	rte_event_crypto_adapter_create;
-	rte_event_crypto_adapter_create_ext;
-	rte_event_crypto_adapter_event_port_get;
-	rte_event_crypto_adapter_free;
-	rte_event_crypto_adapter_queue_pair_add;
-	rte_event_crypto_adapter_queue_pair_del;
-	rte_event_crypto_adapter_service_id_get;
-	rte_event_crypto_adapter_start;
-	rte_event_crypto_adapter_stats_get;
-	rte_event_crypto_adapter_stats_reset;
-	rte_event_crypto_adapter_stop;
-	rte_event_crypto_adapter_vector_limits_get;
-	rte_event_dequeue_timeout_ticks;
-	rte_event_dev_attr_get;
-	rte_event_dev_close;
-	rte_event_dev_configure;
-	rte_event_dev_count;
-	rte_event_dev_dump;
-	rte_event_dev_get_dev_id;
-	rte_event_dev_info_get;
-	rte_event_dev_selftest;
-	rte_event_dev_service_id_get;
-	rte_event_dev_socket_id;
-	rte_event_dev_start;
-	rte_event_dev_stop;
-	rte_event_dev_stop_flush_callback_register;
-	rte_event_dev_xstats_by_name_get;
-	rte_event_dev_xstats_get;
-	rte_event_dev_xstats_names_get;
-	rte_event_dev_xstats_reset;
-	rte_event_eth_rx_adapter_caps_get;
-	rte_event_eth_rx_adapter_cb_register;
-	rte_event_eth_rx_adapter_create;
-	rte_event_eth_rx_adapter_create_ext;
-	rte_event_eth_rx_adapter_create_with_params;
-	rte_event_eth_rx_adapter_event_port_get;
-	rte_event_eth_rx_adapter_free;
-	rte_event_eth_rx_adapter_instance_get;
-	rte_event_eth_rx_adapter_queue_add;
-	rte_event_eth_rx_adapter_queue_conf_get;
-	rte_event_eth_rx_adapter_queue_del;
-	rte_event_eth_rx_adapter_queue_stats_get;
-	rte_event_eth_rx_adapter_queue_stats_reset;
-	rte_event_eth_rx_adapter_service_id_get;
-	rte_event_eth_rx_adapter_start;
-	rte_event_eth_rx_adapter_stats_get;
-	rte_event_eth_rx_adapter_stats_reset;
-	rte_event_eth_rx_adapter_stop;
-	rte_event_eth_rx_adapter_vector_limits_get;
-	rte_event_eth_tx_adapter_caps_get;
-	rte_event_eth_tx_adapter_create;
-	rte_event_eth_tx_adapter_create_ext;
-	rte_event_eth_tx_adapter_event_port_get;
-	rte_event_eth_tx_adapter_free;
-	rte_event_eth_tx_adapter_instance_get;
-	rte_event_eth_tx_adapter_queue_add;
-	rte_event_eth_tx_adapter_queue_del;
-	rte_event_eth_tx_adapter_queue_start;
-	rte_event_eth_tx_adapter_queue_stop;
-	rte_event_eth_tx_adapter_service_id_get;
-	rte_event_eth_tx_adapter_start;
-	rte_event_eth_tx_adapter_stats_get;
-	rte_event_eth_tx_adapter_stats_reset;
-	rte_event_eth_tx_adapter_stop;
-	rte_event_fp_ops;
-	rte_event_port_attr_get;
-	rte_event_port_default_conf_get;
-	rte_event_port_link;
-	rte_event_port_links_get;
-	rte_event_port_quiesce;
-	rte_event_port_setup;
-	rte_event_port_unlink;
-	rte_event_port_unlinks_in_progress;
-	rte_event_queue_attr_get;
-	rte_event_queue_attr_set;
-	rte_event_queue_default_conf_get;
-	rte_event_queue_setup;
-	rte_event_ring_create;
-	rte_event_ring_free;
-	rte_event_ring_init;
-	rte_event_ring_lookup;
-	rte_event_timer_adapter_caps_get;
-	rte_event_timer_adapter_create;
-	rte_event_timer_adapter_create_ext;
-	rte_event_timer_adapter_free;
-	rte_event_timer_adapter_get_info;
-	rte_event_timer_adapter_lookup;
-	rte_event_timer_adapter_service_id_get;
-	rte_event_timer_adapter_start;
-	rte_event_timer_adapter_stats_get;
-	rte_event_timer_adapter_stats_reset;
-	rte_event_timer_adapter_stop;
-	rte_event_vector_pool_create;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.03
-	rte_event_crypto_adapter_runtime_params_get;
-	rte_event_crypto_adapter_runtime_params_init;
-	rte_event_crypto_adapter_runtime_params_set;
-	rte_event_eth_rx_adapter_runtime_params_get;
-	rte_event_eth_rx_adapter_runtime_params_init;
-	rte_event_eth_rx_adapter_runtime_params_set;
-	rte_event_eth_tx_adapter_runtime_params_get;
-	rte_event_eth_tx_adapter_runtime_params_init;
-	rte_event_eth_tx_adapter_runtime_params_set;
-	rte_event_timer_remaining_ticks_get;
-
-	# added in 23.11
-	rte_event_dma_adapter_caps_get;
-	rte_event_dma_adapter_create;
-	rte_event_dma_adapter_create_ext;
-	rte_event_dma_adapter_enqueue;
-	rte_event_dma_adapter_event_port_get;
-	rte_event_dma_adapter_free;
-	rte_event_dma_adapter_runtime_params_get;
-	rte_event_dma_adapter_runtime_params_init;
-	rte_event_dma_adapter_runtime_params_set;
-	rte_event_dma_adapter_service_id_get;
-	rte_event_dma_adapter_start;
-	rte_event_dma_adapter_stats_get;
-	rte_event_dma_adapter_stats_reset;
-	rte_event_dma_adapter_stop;
-	rte_event_dma_adapter_vchan_add;
-	rte_event_dma_adapter_vchan_del;
-	rte_event_eth_rx_adapter_create_ext_with_params;
-	rte_event_port_profile_links_set;
-	rte_event_port_profile_unlink;
-	rte_event_port_profile_links_get;
-	__rte_eventdev_trace_port_profile_switch;
-
-	# added in 24.11
-	__rte_eventdev_trace_port_preschedule_modify;
-	__rte_eventdev_trace_port_preschedule;
-
-	# added in 25.03
-	rte_event_eth_rx_adapter_queues_add;
-};
-
-INTERNAL {
-	global:
-
-	event_dev_fp_ops_reset;
-	event_dev_fp_ops_set;
-	event_dev_probing_finish;
-	rte_event_logtype;
-	rte_event_pmd_allocate;
-	rte_event_pmd_release;
-	rte_event_pmd_selftest_seqn_dynfield_offset;
-	rte_eventdevs;
-};
diff --git a/lib/fib/version.map b/lib/fib/version.map
deleted file mode 100644
index df8f113df3..0000000000
--- a/lib/fib/version.map
+++ /dev/null
@@ -1,31 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_fib6_add;
-	rte_fib6_create;
-	rte_fib6_delete;
-	rte_fib6_find_existing;
-	rte_fib6_free;
-	rte_fib6_get_dp;
-	rte_fib6_get_rib;
-	rte_fib6_lookup_bulk;
-	rte_fib6_select_lookup;
-	rte_fib_add;
-	rte_fib_create;
-	rte_fib_delete;
-	rte_fib_find_existing;
-	rte_fib_free;
-	rte_fib_get_dp;
-	rte_fib_get_rib;
-	rte_fib_lookup_bulk;
-	rte_fib_select_lookup;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 24.11
-	rte_fib_rcu_qsbr_add;
-};
diff --git a/lib/gpudev/version.map b/lib/gpudev/version.map
deleted file mode 100644
index a2c8ce5759..0000000000
--- a/lib/gpudev/version.map
+++ /dev/null
@@ -1,44 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 21.11
-	rte_gpu_add_child;
-	rte_gpu_callback_register;
-	rte_gpu_callback_unregister;
-	rte_gpu_close;
-	rte_gpu_comm_cleanup_list;
-	rte_gpu_comm_create_flag;
-	rte_gpu_comm_create_list;
-	rte_gpu_comm_destroy_flag;
-	rte_gpu_comm_destroy_list;
-	rte_gpu_comm_get_flag_value;
-	rte_gpu_comm_get_status;
-	rte_gpu_comm_populate_list_pkts;
-	rte_gpu_comm_set_flag;
-	rte_gpu_comm_set_status;
-	rte_gpu_count_avail;
-	rte_gpu_find_next;
-	rte_gpu_info_get;
-	rte_gpu_init;
-	rte_gpu_is_valid;
-	rte_gpu_mem_alloc;
-	rte_gpu_mem_cpu_map;
-	rte_gpu_mem_free;
-	rte_gpu_mem_register;
-	rte_gpu_mem_cpu_unmap;
-	rte_gpu_mem_unregister;
-	rte_gpu_wmb;
-};
-
-INTERNAL {
-	global:
-
-	rte_gpu_allocate;
-	rte_gpu_attach;
-	rte_gpu_complete_new;
-	rte_gpu_get_by_name;
-	rte_gpu_notify;
-	rte_gpu_release;
-
-	local: *;
-};
diff --git a/lib/graph/version.map b/lib/graph/version.map
deleted file mode 100644
index d03d44434d..0000000000
--- a/lib/graph/version.map
+++ /dev/null
@@ -1,44 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_graph_mcore_dispatch_sched_node_enqueue;
-	__rte_graph_mcore_dispatch_sched_wq_process;
-	__rte_node_register;
-	__rte_node_stream_alloc;
-	__rte_node_stream_alloc_size;
-	rte_graph_clone;
-	rte_graph_cluster_stats_create;
-	rte_graph_cluster_stats_destroy;
-	rte_graph_cluster_stats_get;
-	rte_graph_cluster_stats_reset;
-	rte_graph_create;
-	rte_graph_destroy;
-	rte_graph_dump;
-	rte_graph_export;
-	rte_graph_from_name;
-	rte_graph_id_to_name;
-	rte_graph_list_dump;
-	rte_graph_lookup;
-	rte_graph_max_count;
-	rte_graph_model_is_valid;
-	rte_graph_model_mcore_dispatch_core_bind;
-	rte_graph_model_mcore_dispatch_core_unbind;
-	rte_graph_model_mcore_dispatch_node_lcore_affinity_set;
-	rte_graph_node_get;
-	rte_graph_node_get_by_name;
-	rte_graph_obj_dump;
-	rte_graph_worker_model_get;
-	rte_graph_worker_model_set;
-	rte_node_clone;
-	rte_node_dump;
-	rte_node_edge_count;
-	rte_node_edge_get;
-	rte_node_edge_shrink;
-	rte_node_edge_update;
-	rte_node_from_name;
-	rte_node_id_to_name;
-	rte_node_list_dump;
-	rte_node_max_count;
-
-	local: *;
-};
diff --git a/lib/gro/version.map b/lib/gro/version.map
deleted file mode 100644
index c21c137fcd..0000000000
--- a/lib/gro/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_gro_ctx_create;
-	rte_gro_ctx_destroy;
-	rte_gro_get_pkt_count;
-	rte_gro_reassemble;
-	rte_gro_reassemble_burst;
-	rte_gro_timeout_flush;
-
-	local: *;
-};
diff --git a/lib/gso/version.map b/lib/gso/version.map
deleted file mode 100644
index 815baeb3e5..0000000000
--- a/lib/gso/version.map
+++ /dev/null
@@ -1,7 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_gso_segment;
-
-	local: *;
-};
diff --git a/lib/hash/version.map b/lib/hash/version.map
deleted file mode 100644
index 779eb1fe13..0000000000
--- a/lib/hash/version.map
+++ /dev/null
@@ -1,66 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_fbk_hash_create;
-	rte_fbk_hash_find_existing;
-	rte_fbk_hash_free;
-	rte_hash_add_key;
-	rte_hash_add_key_data;
-	rte_hash_add_key_with_hash;
-	rte_hash_add_key_with_hash_data;
-	rte_hash_count;
-	rte_hash_crc32_alg;
-	rte_hash_crc_set_alg;
-	rte_hash_create;
-	rte_hash_del_key;
-	rte_hash_del_key_with_hash;
-	rte_hash_find_existing;
-	rte_hash_free;
-	rte_hash_free_key_with_position;
-	rte_hash_get_key_with_position;
-	rte_hash_hash;
-	rte_hash_iterate;
-	rte_hash_lookup;
-	rte_hash_lookup_bulk;
-	rte_hash_lookup_bulk_data;
-	rte_hash_lookup_data;
-	rte_hash_lookup_with_hash;
-	rte_hash_lookup_with_hash_bulk;
-	rte_hash_lookup_with_hash_bulk_data;
-	rte_hash_lookup_with_hash_data;
-	rte_hash_max_key_id;
-	rte_hash_rcu_qsbr_add;
-	rte_hash_reset;
-	rte_hash_set_cmp_func;
-	rte_thash_add_helper;
-	rte_thash_adjust_tuple;
-	rte_thash_complete_matrix;
-	rte_thash_find_existing;
-	rte_thash_free_ctx;
-	rte_thash_get_complement;
-	rte_thash_get_gfni_matrices;
-	rte_thash_get_helper;
-	rte_thash_get_key;
-	rte_thash_gfni_supported;
-	rte_thash_init_ctx;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 24.07
-	rte_hash_rcu_qsbr_dq_reclaim;
-
-	# added in 24.11
-	rte_thash_gen_key;
-};
-
-INTERNAL {
-	global:
-
-	rte_thash_gfni_stub;
-	rte_thash_gfni_bulk_stub;
-	thash_get_rand_poly;
-};
diff --git a/lib/ip_frag/version.map b/lib/ip_frag/version.map
deleted file mode 100644
index 0c001c7bd5..0000000000
--- a/lib/ip_frag/version.map
+++ /dev/null
@@ -1,16 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_ip_frag_free_death_row;
-	rte_ip_frag_table_create;
-	rte_ip_frag_table_del_expired_entries;
-	rte_ip_frag_table_destroy;
-	rte_ip_frag_table_statistics_dump;
-	rte_ipv4_frag_reassemble_packet;
-	rte_ipv4_fragment_copy_nonseg_packet;
-	rte_ipv4_fragment_packet;
-	rte_ipv6_frag_reassemble_packet;
-	rte_ipv6_fragment_packet;
-
-	local: *;
-};
diff --git a/lib/ipsec/version.map b/lib/ipsec/version.map
deleted file mode 100644
index 47e3df5bb6..0000000000
--- a/lib/ipsec/version.map
+++ /dev/null
@@ -1,19 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_ipsec_sa_fini;
-	rte_ipsec_sa_init;
-	rte_ipsec_sa_size;
-	rte_ipsec_sa_type;
-	rte_ipsec_sad_add;
-	rte_ipsec_sad_create;
-	rte_ipsec_sad_del;
-	rte_ipsec_sad_destroy;
-	rte_ipsec_sad_find_existing;
-	rte_ipsec_sad_lookup;
-	rte_ipsec_session_prepare;
-	rte_ipsec_telemetry_sa_add;
-	rte_ipsec_telemetry_sa_del;
-
-	local: *;
-};
diff --git a/lib/jobstats/version.map b/lib/jobstats/version.map
deleted file mode 100644
index 55100e0699..0000000000
--- a/lib/jobstats/version.map
+++ /dev/null
@@ -1,20 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_jobstats_abort;
-	rte_jobstats_context_finish;
-	rte_jobstats_context_init;
-	rte_jobstats_context_reset;
-	rte_jobstats_context_start;
-	rte_jobstats_finish;
-	rte_jobstats_init;
-	rte_jobstats_reset;
-	rte_jobstats_set_max;
-	rte_jobstats_set_min;
-	rte_jobstats_set_period;
-	rte_jobstats_set_target;
-	rte_jobstats_set_update_period_function;
-	rte_jobstats_start;
-
-	local: *;
-};
diff --git a/lib/kvargs/version.map b/lib/kvargs/version.map
deleted file mode 100644
index 30995539fb..0000000000
--- a/lib/kvargs/version.map
+++ /dev/null
@@ -1,14 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_kvargs_count;
-	rte_kvargs_free;
-	rte_kvargs_get;
-	rte_kvargs_get_with_value;
-	rte_kvargs_parse;
-	rte_kvargs_parse_delim;
-	rte_kvargs_process;
-	rte_kvargs_process_opt;
-
-	local: *;
-};
diff --git a/lib/latencystats/version.map b/lib/latencystats/version.map
deleted file mode 100644
index e8806c0046..0000000000
--- a/lib/latencystats/version.map
+++ /dev/null
@@ -1,11 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_latencystats_get;
-	rte_latencystats_get_names;
-	rte_latencystats_init;
-	rte_latencystats_uninit;
-	rte_latencystats_update;
-
-	local: *;
-};
diff --git a/lib/log/version.map b/lib/log/version.map
deleted file mode 100644
index 603be493b3..0000000000
--- a/lib/log/version.map
+++ /dev/null
@@ -1,36 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_log;
-	rte_log_can_log;
-	rte_log_cur_msg_loglevel;
-	rte_log_cur_msg_logtype;
-	rte_log_dump;
-	rte_log_get_global_level;
-	rte_log_get_level;
-	rte_log_get_stream;
-	rte_log_list_types;
-	rte_log_register;
-	rte_log_register_type_and_pick_level;
-	rte_log_set_global_level;
-	rte_log_set_level;
-	rte_log_set_level_pattern;
-	rte_log_set_level_regexp;
-	rte_openlog_stream;
-	rte_vlog;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	eal_log_color;
-	eal_log_init;
-	eal_log_level2str;
-	eal_log_save_pattern;
-	eal_log_save_regexp;
-	eal_log_syslog; # WINDOWS_NO_EXPORT
-	eal_log_timestamp;
-	rte_eal_log_cleanup;
-};
diff --git a/lib/lpm/version.map b/lib/lpm/version.map
deleted file mode 100644
index 29d577c24b..0000000000
--- a/lib/lpm/version.map
+++ /dev/null
@@ -1,24 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_lpm6_add;
-	rte_lpm6_create;
-	rte_lpm6_delete;
-	rte_lpm6_delete_all;
-	rte_lpm6_delete_bulk_func;
-	rte_lpm6_find_existing;
-	rte_lpm6_free;
-	rte_lpm6_is_rule_present;
-	rte_lpm6_lookup;
-	rte_lpm6_lookup_bulk_func;
-	rte_lpm_add;
-	rte_lpm_create;
-	rte_lpm_delete;
-	rte_lpm_delete_all;
-	rte_lpm_find_existing;
-	rte_lpm_free;
-	rte_lpm_is_rule_present;
-	rte_lpm_rcu_qsbr_add;
-
-	local: *;
-};
diff --git a/lib/mbuf/version.map b/lib/mbuf/version.map
deleted file mode 100644
index 76f1832924..0000000000
--- a/lib/mbuf/version.map
+++ /dev/null
@@ -1,45 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_pktmbuf_linearize;
-	__rte_pktmbuf_read;
-	rte_get_ptype_inner_l2_name;
-	rte_get_ptype_inner_l3_name;
-	rte_get_ptype_inner_l4_name;
-	rte_get_ptype_l2_name;
-	rte_get_ptype_l3_name;
-	rte_get_ptype_l4_name;
-	rte_get_ptype_name;
-	rte_get_ptype_tunnel_name;
-	rte_get_rx_ol_flag_list;
-	rte_get_rx_ol_flag_name;
-	rte_get_tx_ol_flag_list;
-	rte_get_tx_ol_flag_name;
-	rte_mbuf_best_mempool_ops;
-	rte_mbuf_check;
-	rte_mbuf_dyn_dump;
-	rte_mbuf_dyn_rx_timestamp_register;
-	rte_mbuf_dyn_tx_timestamp_register;
-	rte_mbuf_dynfield_lookup;
-	rte_mbuf_dynfield_register;
-	rte_mbuf_dynfield_register_offset;
-	rte_mbuf_dynflag_lookup;
-	rte_mbuf_dynflag_register;
-	rte_mbuf_dynflag_register_bitnum;
-	rte_mbuf_platform_mempool_ops;
-	rte_mbuf_sanity_check;
-	rte_mbuf_set_platform_mempool_ops;
-	rte_mbuf_set_user_mempool_ops;
-	rte_mbuf_user_mempool_ops;
-	rte_pktmbuf_clone;
-	rte_pktmbuf_copy;
-	rte_pktmbuf_dump;
-	rte_pktmbuf_free_bulk;
-	rte_pktmbuf_init;
-	rte_pktmbuf_pool_create;
-	rte_pktmbuf_pool_create_by_ops;
-	rte_pktmbuf_pool_create_extbuf;
-	rte_pktmbuf_pool_init;
-
-	local: *;
-};
diff --git a/lib/member/version.map b/lib/member/version.map
deleted file mode 100644
index fdc7adacf9..0000000000
--- a/lib/member/version.map
+++ /dev/null
@@ -1,19 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_member_add;
-	rte_member_add_byte_count;
-	rte_member_create;
-	rte_member_delete;
-	rte_member_find_existing;
-	rte_member_free;
-	rte_member_lookup;
-	rte_member_lookup_bulk;
-	rte_member_lookup_multi;
-	rte_member_lookup_multi_bulk;
-	rte_member_query_count;
-	rte_member_report_heavyhitter;
-	rte_member_reset;
-
-	local: *;
-};
diff --git a/lib/mempool/version.map b/lib/mempool/version.map
deleted file mode 100644
index 6f16d417ae..0000000000
--- a/lib/mempool/version.map
+++ /dev/null
@@ -1,65 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_mempool_audit;
-	rte_mempool_avail_count;
-	rte_mempool_cache_create;
-	rte_mempool_cache_free;
-	rte_mempool_calc_obj_size;
-	rte_mempool_check_cookies;
-	rte_mempool_contig_blocks_check_cookies;
-	rte_mempool_create;
-	rte_mempool_create_empty;
-	rte_mempool_dump;
-	rte_mempool_free;
-	rte_mempool_get_page_size;
-	rte_mempool_in_use_count;
-	rte_mempool_list_dump;
-	rte_mempool_logtype;
-	rte_mempool_lookup;
-	rte_mempool_mem_iter;
-	rte_mempool_obj_iter;
-	rte_mempool_op_calc_mem_size_default;
-	rte_mempool_op_calc_mem_size_helper;
-	rte_mempool_op_populate_default;
-	rte_mempool_op_populate_helper;
-	rte_mempool_ops_get_info;
-	rte_mempool_ops_table;
-	rte_mempool_populate_anon;
-	rte_mempool_populate_default;
-	rte_mempool_populate_iova;
-	rte_mempool_populate_virt;
-	rte_mempool_register_ops;
-	rte_mempool_set_ops_byname;
-	rte_mempool_walk;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.05
-	__rte_mempool_trace_ops_dequeue_bulk;
-	__rte_mempool_trace_ops_dequeue_contig_blocks;
-	__rte_mempool_trace_ops_enqueue_bulk;
-	__rte_mempool_trace_generic_put;
-	__rte_mempool_trace_put_bulk;
-	__rte_mempool_trace_generic_get;
-	__rte_mempool_trace_get_bulk;
-	__rte_mempool_trace_get_contig_blocks;
-	__rte_mempool_trace_default_cache;
-	__rte_mempool_trace_cache_flush;
-
-	# added in 24.07
-	rte_mempool_get_mem_range;
-	rte_mempool_get_obj_alignment;
-};
-
-INTERNAL {
-	global:
-
-	# added in 21.11
-	rte_mempool_event_callback_register;
-	rte_mempool_event_callback_unregister;
-};
diff --git a/lib/meter/version.map b/lib/meter/version.map
deleted file mode 100644
index ae434f34b5..0000000000
--- a/lib/meter/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_meter_srtcm_config;
-	rte_meter_srtcm_profile_config;
-	rte_meter_trtcm_config;
-	rte_meter_trtcm_profile_config;
-	rte_meter_trtcm_rfc4115_config;
-	rte_meter_trtcm_rfc4115_profile_config;
-
-	local: *;
-};
diff --git a/lib/metrics/version.map b/lib/metrics/version.map
deleted file mode 100644
index f9c1996a7d..0000000000
--- a/lib/metrics/version.map
+++ /dev/null
@@ -1,26 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_metrics_deinit;
-	rte_metrics_get_names;
-	rte_metrics_get_values;
-	rte_metrics_init;
-	rte_metrics_reg_name;
-	rte_metrics_reg_names;
-	rte_metrics_update_value;
-	rte_metrics_update_values;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.05
-	rte_metrics_tel_encode_json_format;
-	rte_metrics_tel_reg_all_ethdev;
-	rte_metrics_tel_get_global_stats;
-	rte_metrics_tel_get_port_stats_ids;
-	rte_metrics_tel_get_ports_stats_json;
-	rte_metrics_tel_extract_data;
-};
diff --git a/lib/mldev/version.map b/lib/mldev/version.map
deleted file mode 100644
index d9aa831b3d..0000000000
--- a/lib/mldev/version.map
+++ /dev/null
@@ -1,74 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 22.11
-	rte_ml_dequeue_burst;
-	rte_ml_dev_close;
-	rte_ml_dev_configure;
-	rte_ml_dev_count;
-	rte_ml_dev_dump;
-	rte_ml_dev_info_get;
-	rte_ml_dev_init;
-	rte_ml_dev_is_valid_dev;
-	rte_ml_dev_logtype;
-	rte_ml_dev_queue_pair_count;
-	rte_ml_dev_queue_pair_setup;
-	rte_ml_dev_selftest;
-	rte_ml_dev_socket_id;
-	rte_ml_dev_start;
-	rte_ml_dev_stats_get;
-	rte_ml_dev_stats_reset;
-	rte_ml_dev_stop;
-	rte_ml_dev_xstats_by_name_get;
-	rte_ml_dev_xstats_get;
-	rte_ml_dev_xstats_names_get;
-	rte_ml_dev_xstats_reset;
-	rte_ml_enqueue_burst;
-	rte_ml_io_float32_to_int8;
-	rte_ml_io_int8_to_float32;
-	rte_ml_io_float32_to_uint8;
-	rte_ml_io_uint8_to_float32;
-	rte_ml_io_float32_to_int16;
-	rte_ml_io_int16_to_float32;
-	rte_ml_io_float32_to_uint16;
-	rte_ml_io_uint16_to_float32;
-	rte_ml_io_float32_to_int32;
-	rte_ml_io_int32_to_float32;
-	rte_ml_io_float32_to_uint32;
-	rte_ml_io_uint32_to_float32;
-	rte_ml_io_float32_to_int64;
-	rte_ml_io_int64_to_float32;
-	rte_ml_io_float32_to_uint64;
-	rte_ml_io_uint64_to_float32;
-	rte_ml_io_float32_to_float16;
-	rte_ml_io_float16_to_float32;
-	rte_ml_io_float32_to_bfloat16;
-	rte_ml_io_bfloat16_to_float32;
-	rte_ml_io_dequantize;
-	rte_ml_io_quantize;
-	rte_ml_model_info_get;
-	rte_ml_model_load;
-	rte_ml_model_params_update;
-	rte_ml_model_start;
-	rte_ml_model_stop;
-	rte_ml_model_unload;
-	rte_ml_op_error_get;
-	rte_ml_op_pool_create;
-	rte_ml_op_pool_free;
-
-	local: *;
-};
-
-INTERNAL {
-	global:
-
-	rte_ml_dev_pmd_allocate;
-	rte_ml_dev_pmd_create;
-	rte_ml_dev_pmd_destroy;
-	rte_ml_dev_pmd_get_dev;
-	rte_ml_dev_pmd_get_named_dev;
-	rte_ml_dev_pmd_release;
-
-	rte_ml_io_type_size_get;
-	rte_ml_io_type_to_str;
-};
diff --git a/lib/net/version.map b/lib/net/version.map
deleted file mode 100644
index f4dd673fa3..0000000000
--- a/lib/net/version.map
+++ /dev/null
@@ -1,23 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_random_addr;
-	rte_ether_format_addr;
-	rte_ether_unformat_addr;
-	rte_net_crc_calc;
-	rte_net_crc_free;
-	rte_net_crc_set_alg;
-	rte_net_get_ptype;
-	rte_net_make_rarp_packet;
-	rte_net_skip_ip6_ext;
-
-	local: *;
-};
-
-DPDK_26 {
-	global:
-
-	rte_net_crc_calc;
-	rte_net_crc_set_alg;
-
-} DPDK_25;
diff --git a/lib/node/version.map b/lib/node/version.map
deleted file mode 100644
index a402182fbe..0000000000
--- a/lib/node/version.map
+++ /dev/null
@@ -1,25 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_node_eth_config;
-	rte_node_ip4_rewrite_add;
-	rte_node_ip4_route_add;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.07
-	rte_node_ip6_rewrite_add;
-	rte_node_ip6_route_add;
-
-	# added in 23.11
-	rte_node_ip4_reassembly_configure;
-	rte_node_udp4_dst_port_add;
-	rte_node_udp4_usr_node_add;
-
-	# added in 24.03
-	rte_node_ethdev_rx_next_update;
-};
diff --git a/lib/pcapng/version.map b/lib/pcapng/version.map
deleted file mode 100644
index 9f634b653e..0000000000
--- a/lib/pcapng/version.map
+++ /dev/null
@@ -1,13 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pcapng_add_interface;
-	rte_pcapng_close;
-	rte_pcapng_copy;
-	rte_pcapng_fdopen;
-	rte_pcapng_mbuf_size;
-	rte_pcapng_write_packets;
-	rte_pcapng_write_stats;
-
-	local: *;
-};
diff --git a/lib/pci/version.map b/lib/pci/version.map
deleted file mode 100644
index f0f6ffef9f..0000000000
--- a/lib/pci/version.map
+++ /dev/null
@@ -1,9 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pci_addr_cmp;
-	rte_pci_addr_parse;
-	rte_pci_device_name;
-
-	local: *;
-};
diff --git a/lib/pdcp/version.map b/lib/pdcp/version.map
deleted file mode 100644
index 72b2d4729b..0000000000
--- a/lib/pdcp/version.map
+++ /dev/null
@@ -1,12 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 23.07
-	rte_pdcp_control_pdu_create;
-	rte_pdcp_entity_establish;
-	rte_pdcp_entity_release;
-	rte_pdcp_entity_suspend;
-	rte_pdcp_t_reordering_expiry_handle;
-
-	local: *;
-};
diff --git a/lib/pdump/version.map b/lib/pdump/version.map
deleted file mode 100644
index 6eea4c1530..0000000000
--- a/lib/pdump/version.map
+++ /dev/null
@@ -1,15 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pdump_disable;
-	rte_pdump_disable_by_deviceid;
-	rte_pdump_enable;
-	rte_pdump_enable_bpf;
-	rte_pdump_enable_bpf_by_deviceid;
-	rte_pdump_enable_by_deviceid;
-	rte_pdump_init;
-	rte_pdump_stats;
-	rte_pdump_uninit;
-
-	local: *;
-};
diff --git a/lib/pipeline/version.map b/lib/pipeline/version.map
deleted file mode 100644
index b56d022664..0000000000
--- a/lib/pipeline/version.map
+++ /dev/null
@@ -1,172 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_pipeline_ah_packet_drop;
-	rte_pipeline_ah_packet_hijack;
-	rte_pipeline_check;
-	rte_pipeline_create;
-	rte_pipeline_flush;
-	rte_pipeline_free;
-	rte_pipeline_port_in_connect_to_table;
-	rte_pipeline_port_in_create;
-	rte_pipeline_port_in_disable;
-	rte_pipeline_port_in_enable;
-	rte_pipeline_port_in_stats_read;
-	rte_pipeline_port_out_create;
-	rte_pipeline_port_out_packet_insert;
-	rte_pipeline_port_out_stats_read;
-	rte_pipeline_run;
-	rte_pipeline_table_create;
-	rte_pipeline_table_default_entry_add;
-	rte_pipeline_table_default_entry_delete;
-	rte_pipeline_table_entry_add;
-	rte_pipeline_table_entry_add_bulk;
-	rte_pipeline_table_entry_delete;
-	rte_pipeline_table_entry_delete_bulk;
-	rte_pipeline_table_stats_read;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 18.05
-	rte_port_in_action_apply;
-	rte_port_in_action_create;
-	rte_port_in_action_free;
-	rte_port_in_action_params_get;
-	rte_port_in_action_profile_action_register;
-	rte_port_in_action_profile_create;
-	rte_port_in_action_profile_free;
-	rte_port_in_action_profile_freeze;
-	rte_table_action_apply;
-	rte_table_action_create;
-	rte_table_action_dscp_table_update;
-	rte_table_action_free;
-	rte_table_action_meter_profile_add;
-	rte_table_action_meter_profile_delete;
-	rte_table_action_meter_read;
-	rte_table_action_profile_action_register;
-	rte_table_action_profile_create;
-	rte_table_action_profile_free;
-	rte_table_action_profile_freeze;
-	rte_table_action_stats_read;
-	rte_table_action_table_params_get;
-	rte_table_action_time_read;
-	rte_table_action_ttl_read;
-
-	# added in 18.11
-	rte_table_action_crypto_sym_session_get;
-
-	# added in 20.11
-	rte_swx_ctl_action_arg_info_get;
-	rte_swx_ctl_action_info_get;
-	rte_swx_ctl_pipeline_abort;
-	rte_swx_ctl_pipeline_commit;
-	rte_swx_ctl_pipeline_create;
-	rte_swx_ctl_pipeline_free;
-	rte_swx_ctl_pipeline_info_get;
-	rte_swx_ctl_pipeline_mirroring_session_set;
-	rte_swx_ctl_pipeline_numa_node_get;
-	rte_swx_ctl_pipeline_port_in_stats_read;
-	rte_swx_ctl_pipeline_port_out_stats_read;
-	rte_swx_ctl_pipeline_table_default_entry_add;
-	rte_swx_ctl_pipeline_table_entry_add;
-	rte_swx_ctl_pipeline_table_entry_delete;
-	rte_swx_ctl_pipeline_table_entry_read;
-	rte_swx_ctl_pipeline_table_fprintf;
-	rte_swx_ctl_table_action_info_get;
-	rte_swx_ctl_table_info_get;
-	rte_swx_ctl_table_match_field_info_get;
-	rte_swx_ctl_table_ops_get;
-	rte_swx_pipeline_action_config;
-	rte_swx_pipeline_build;
-	rte_swx_pipeline_config;
-	rte_swx_pipeline_extern_func_register;
-	rte_swx_pipeline_extern_object_config;
-	rte_swx_pipeline_extern_type_member_func_register;
-	rte_swx_pipeline_extern_type_register;
-	rte_swx_pipeline_flush;
-	rte_swx_pipeline_free;
-	rte_swx_pipeline_instructions_config;
-	rte_swx_pipeline_mirroring_config;
-	rte_swx_pipeline_packet_header_register;
-	rte_swx_pipeline_packet_metadata_register;
-	rte_swx_pipeline_port_in_config;
-	rte_swx_pipeline_port_in_type_register;
-	rte_swx_pipeline_port_out_config;
-	rte_swx_pipeline_port_out_type_register;
-	rte_swx_pipeline_run;
-	rte_swx_pipeline_struct_type_register;
-	rte_swx_pipeline_table_config;
-	rte_swx_pipeline_table_state_get;
-	rte_swx_pipeline_table_state_set;
-	rte_swx_pipeline_table_type_register;
-
-	# added in 21.05
-	rte_swx_ctl_metarray_info_get;
-	rte_swx_ctl_meter_profile_add;
-	rte_swx_ctl_meter_profile_delete;
-	rte_swx_ctl_meter_reset;
-	rte_swx_ctl_meter_set;
-	rte_swx_ctl_meter_stats_read;
-	rte_swx_ctl_pipeline_regarray_read;
-	rte_swx_ctl_pipeline_regarray_write;
-	rte_swx_ctl_pipeline_table_stats_read;
-	rte_swx_ctl_regarray_info_get;
-	rte_swx_pipeline_metarray_config;
-	rte_swx_pipeline_regarray_config;
-
-	# added in 21.08
-	rte_swx_pipeline_selector_config;
-	rte_swx_ctl_pipeline_selector_fprintf;
-	rte_swx_ctl_pipeline_selector_group_add;
-	rte_swx_ctl_pipeline_selector_group_delete;
-	rte_swx_ctl_pipeline_selector_group_member_add;
-	rte_swx_ctl_pipeline_selector_group_member_delete;
-	rte_swx_ctl_pipeline_selector_stats_read;
-	rte_swx_ctl_selector_info_get;
-	rte_swx_ctl_selector_field_info_get;
-	rte_swx_ctl_selector_group_id_field_info_get;
-	rte_swx_ctl_selector_member_id_field_info_get;
-
-	# added in 21.11
-	rte_swx_ctl_pipeline_learner_default_entry_add;
-	rte_swx_ctl_pipeline_learner_default_entry_read;
-	rte_swx_ctl_pipeline_learner_stats_read;
-	rte_swx_ctl_learner_action_info_get;
-	rte_swx_ctl_learner_info_get;
-	rte_swx_ctl_learner_match_field_info_get;
-	rte_swx_pipeline_learner_config;
-
-	# added in 22.07
-	rte_swx_ctl_pipeline_learner_timeout_get;
-	rte_swx_ctl_pipeline_learner_timeout_set;
-	rte_swx_pipeline_hash_func_register;
-
-	# added in 22.11
-	rte_swx_ctl_meter_reset_with_key;
-	rte_swx_ctl_meter_set_with_key;
-	rte_swx_ctl_meter_stats_read_with_key;
-	rte_swx_ctl_pipeline_find;
-	rte_swx_ctl_pipeline_regarray_read_with_key;
-	rte_swx_ctl_pipeline_regarray_write_with_key;
-	rte_swx_pipeline_build_from_lib;
-	rte_swx_pipeline_codegen;
-	rte_swx_pipeline_find;
-
-	# added in 23.03
-	rte_swx_ctl_pipeline_rss_key_read;
-	rte_swx_ctl_pipeline_rss_key_size_read;
-	rte_swx_ctl_pipeline_rss_key_write;
-	rte_swx_ctl_rss_info_get;
-	rte_swx_ipsec_create;
-	rte_swx_ipsec_find;
-	rte_swx_ipsec_free;
-	rte_swx_ipsec_run;
-	rte_swx_ipsec_sa_add;
-	rte_swx_ipsec_sa_delete;
-	rte_swx_ipsec_sa_read;
-	rte_swx_pipeline_rss_config;
-};
diff --git a/lib/port/version.map b/lib/port/version.map
deleted file mode 100644
index 98fe0b08ab..0000000000
--- a/lib/port/version.map
+++ /dev/null
@@ -1,50 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_port_ethdev_reader_ops;
-	rte_port_ethdev_writer_nodrop_ops;
-	rte_port_ethdev_writer_ops;
-	rte_port_fd_reader_ops;
-	rte_port_fd_writer_nodrop_ops;
-	rte_port_fd_writer_ops;
-	rte_port_ring_multi_reader_ops;
-	rte_port_ring_multi_writer_nodrop_ops;
-	rte_port_ring_multi_writer_ops;
-	rte_port_ring_reader_ipv4_frag_ops;
-	rte_port_ring_reader_ipv6_frag_ops;
-	rte_port_ring_reader_ops;
-	rte_port_ring_writer_ipv4_ras_ops;
-	rte_port_ring_writer_ipv6_ras_ops;
-	rte_port_ring_writer_nodrop_ops;
-	rte_port_ring_writer_ops;
-	rte_port_sched_reader_ops;
-	rte_port_sched_writer_ops;
-	rte_port_sink_ops;
-	rte_port_source_ops;
-	rte_port_sym_crypto_reader_ops;
-	rte_port_sym_crypto_writer_nodrop_ops;
-	rte_port_sym_crypto_writer_ops;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 19.11
-	rte_port_eventdev_reader_ops;
-	rte_port_eventdev_writer_nodrop_ops;
-	rte_port_eventdev_writer_ops;
-
-	# added in 20.11
-	rte_swx_port_ethdev_reader_ops;
-	rte_swx_port_ethdev_writer_ops;
-	rte_swx_port_sink_ops;
-	rte_swx_port_source_ops;
-
-	# added in 21.05
-	rte_swx_port_fd_reader_ops;
-	rte_swx_port_fd_writer_ops;
-	rte_swx_port_ring_reader_ops;
-	rte_swx_port_ring_writer_ops;
-};
diff --git a/lib/power/version.map b/lib/power/version.map
deleted file mode 100644
index 9a36046a64..0000000000
--- a/lib/power/version.map
+++ /dev/null
@@ -1,71 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_power_check_env_supported;
-	rte_power_ethdev_pmgmt_queue_disable;
-	rte_power_ethdev_pmgmt_queue_enable;
-	rte_power_exit;
-	rte_power_freq_disable_turbo;
-	rte_power_freq_down;
-	rte_power_freq_enable_turbo;
-	rte_power_freq_max;
-	rte_power_freq_min;
-	rte_power_freq_up;
-	rte_power_freqs;
-	rte_power_get_capabilities;
-	rte_power_get_env;
-	rte_power_get_freq;
-	rte_power_get_uncore_freq;
-	rte_power_init;
-	rte_power_pmd_mgmt_get_emptypoll_max;
-	rte_power_pmd_mgmt_get_pause_duration;
-	rte_power_pmd_mgmt_get_scaling_freq_max;
-	rte_power_pmd_mgmt_get_scaling_freq_min;
-	rte_power_pmd_mgmt_set_emptypoll_max;
-	rte_power_pmd_mgmt_set_pause_duration;
-	rte_power_pmd_mgmt_set_scaling_freq_max;
-	rte_power_pmd_mgmt_set_scaling_freq_min;
-	rte_power_set_env;
-	rte_power_set_freq;
-	rte_power_set_uncore_freq;
-	rte_power_turbo_status;
-	rte_power_uncore_exit;
-	rte_power_uncore_freq_max;
-	rte_power_uncore_freq_min;
-	rte_power_uncore_get_num_dies;
-	rte_power_uncore_get_num_freqs;
-	rte_power_uncore_get_num_pkgs;
-	rte_power_uncore_init;
-	rte_power_unset_env;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.11
-	rte_power_get_uncore_env;
-	rte_power_set_uncore_env;
-	rte_power_uncore_freqs;
-	rte_power_unset_uncore_env;
-
-	# added in 24.11
-	rte_power_qos_get_cpu_resume_latency;
-	rte_power_qos_set_cpu_resume_latency;
-};
-
-INTERNAL {
-	global:
-
-	rte_power_register_cpufreq_ops;
-	rte_power_register_uncore_ops;
-	rte_power_logtype;
-	cpufreq_check_scaling_driver;
-	power_get_lcore_mapped_cpu_id;
-	power_set_governor;
-	open_core_sysfs_file;
-	read_core_sysfs_u32;
-	read_core_sysfs_s;
-	write_core_sysfs_s;
-};
diff --git a/lib/rawdev/version.map b/lib/rawdev/version.map
deleted file mode 100644
index f95d5dabae..0000000000
--- a/lib/rawdev/version.map
+++ /dev/null
@@ -1,36 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_rawdev_close;
-	rte_rawdev_configure;
-	rte_rawdev_count;
-	rte_rawdev_dequeue_buffers;
-	rte_rawdev_dump;
-	rte_rawdev_enqueue_buffers;
-	rte_rawdev_firmware_load;
-	rte_rawdev_firmware_status_get;
-	rte_rawdev_firmware_unload;
-	rte_rawdev_firmware_version_get;
-	rte_rawdev_get_attr;
-	rte_rawdev_get_dev_id;
-	rte_rawdev_info_get;
-	rte_rawdev_pmd_allocate;
-	rte_rawdev_pmd_release;
-	rte_rawdev_queue_conf_get;
-	rte_rawdev_queue_count;
-	rte_rawdev_queue_release;
-	rte_rawdev_queue_setup;
-	rte_rawdev_reset;
-	rte_rawdev_selftest;
-	rte_rawdev_set_attr;
-	rte_rawdev_socket_id;
-	rte_rawdev_start;
-	rte_rawdev_stop;
-	rte_rawdev_xstats_by_name_get;
-	rte_rawdev_xstats_get;
-	rte_rawdev_xstats_names_get;
-	rte_rawdev_xstats_reset;
-	rte_rawdevs;
-
-	local: *;
-};
diff --git a/lib/rcu/version.map b/lib/rcu/version.map
deleted file mode 100644
index d96c4c4109..0000000000
--- a/lib/rcu/version.map
+++ /dev/null
@@ -1,17 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_rcu_log_type;
-	rte_rcu_qsbr_dq_create;
-	rte_rcu_qsbr_dq_delete;
-	rte_rcu_qsbr_dq_enqueue;
-	rte_rcu_qsbr_dq_reclaim;
-	rte_rcu_qsbr_dump;
-	rte_rcu_qsbr_get_memsize;
-	rte_rcu_qsbr_init;
-	rte_rcu_qsbr_synchronize;
-	rte_rcu_qsbr_thread_register;
-	rte_rcu_qsbr_thread_unregister;
-
-	local: *;
-};
diff --git a/lib/regexdev/version.map b/lib/regexdev/version.map
deleted file mode 100644
index 713a800ca4..0000000000
--- a/lib/regexdev/version.map
+++ /dev/null
@@ -1,38 +0,0 @@
-EXPERIMENTAL {
-	global:
-
-	# added in 20.08
-	rte_regexdev_attr_get;
-	rte_regexdev_attr_set;
-	rte_regexdev_close;
-	rte_regexdev_configure;
-	rte_regexdev_count;
-	rte_regexdev_dump;
-	rte_regexdev_get_dev_id;
-	rte_regexdev_info_get;
-	rte_regexdev_queue_pair_setup;
-	rte_regexdev_rule_db_compile_activate;
-	rte_regexdev_rule_db_export;
-	rte_regexdev_rule_db_import;
-	rte_regexdev_rule_db_update;
-	rte_regexdev_selftest;
-	rte_regexdev_start;
-	rte_regexdev_stop;
-	rte_regexdev_xstats_by_name_get;
-	rte_regexdev_xstats_get;
-	rte_regexdev_xstats_names_get;
-	rte_regexdev_xstats_reset;
-
-	# added in 22.03
-	rte_regex_devices;
-	rte_regexdev_is_valid_dev;
-	rte_regexdev_logtype;
-
-	local: *;
-};
-
-INTERNAL {
-	rte_regexdev_get_device_by_name;
-	rte_regexdev_register;
-	rte_regexdev_unregister;
-};
diff --git a/lib/reorder/version.map b/lib/reorder/version.map
deleted file mode 100644
index 18e97942e1..0000000000
--- a/lib/reorder/version.map
+++ /dev/null
@@ -1,27 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_reorder_create;
-	rte_reorder_drain;
-	rte_reorder_find_existing;
-	rte_reorder_free;
-	rte_reorder_init;
-	rte_reorder_insert;
-	rte_reorder_reset;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_reorder_seqn_dynfield_offset;
-
-	# added in 23.03
-	rte_reorder_drain_up_to_seqn;
-	rte_reorder_min_seqn_set;
-
-	# added in 23.07
-	rte_reorder_memory_footprint_get;
-};
diff --git a/lib/rib/version.map b/lib/rib/version.map
deleted file mode 100644
index 145d9c2602..0000000000
--- a/lib/rib/version.map
+++ /dev/null
@@ -1,34 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_rib6_create;
-	rte_rib6_find_existing;
-	rte_rib6_free;
-	rte_rib6_get_depth;
-	rte_rib6_get_ext;
-	rte_rib6_get_ip;
-	rte_rib6_get_nh;
-	rte_rib6_get_nxt;
-	rte_rib6_insert;
-	rte_rib6_lookup;
-	rte_rib6_lookup_exact;
-	rte_rib6_lookup_parent;
-	rte_rib6_remove;
-	rte_rib6_set_nh;
-	rte_rib_create;
-	rte_rib_find_existing;
-	rte_rib_free;
-	rte_rib_get_depth;
-	rte_rib_get_ext;
-	rte_rib_get_ip;
-	rte_rib_get_nh;
-	rte_rib_get_nxt;
-	rte_rib_insert;
-	rte_rib_lookup;
-	rte_rib_lookup_exact;
-	rte_rib_lookup_parent;
-	rte_rib_remove;
-	rte_rib_set_nh;
-
-	local: *;
-};
diff --git a/lib/ring/version.map b/lib/ring/version.map
deleted file mode 100644
index eeaa95b2e9..0000000000
--- a/lib/ring/version.map
+++ /dev/null
@@ -1,42 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_ring_create;
-	rte_ring_create_elem;
-	rte_ring_dump;
-	rte_ring_free;
-	rte_ring_get_memsize;
-	rte_ring_get_memsize_elem;
-	rte_ring_init;
-	rte_ring_list_dump;
-	rte_ring_lookup;
-	rte_ring_reset;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 25.03
-	rte_ring_headtail_dump;
-	rte_soring_acquire_bulk;
-	rte_soring_acquire_burst;
-	rte_soring_acquirx_bulk;
-	rte_soring_acquirx_burst;
-	rte_soring_count;
-	rte_soring_dequeue_bulk;
-	rte_soring_dequeue_burst;
-	rte_soring_dequeux_bulk;
-	rte_soring_dequeux_burst;
-	rte_soring_enqueue_bulk;
-	rte_soring_enqueue_burst;
-	rte_soring_enqueux_bulk;
-	rte_soring_enqueux_burst;
-	rte_soring_dump;
-	rte_soring_free_count;
-	rte_soring_get_memsize;
-	rte_soring_init;
-	rte_soring_release;
-	rte_soring_releasx;
-};
diff --git a/lib/sched/version.map b/lib/sched/version.map
deleted file mode 100644
index a6ca9ee1ad..0000000000
--- a/lib/sched/version.map
+++ /dev/null
@@ -1,30 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_approx;
-	rte_pie_config_init;
-	rte_pie_rt_data_init;
-	rte_red_config_init;
-	rte_red_log2_1_minus_Wq;
-	rte_red_pow2_frac_inv;
-	rte_red_rand_seed;
-	rte_red_rand_val;
-	rte_red_rt_data_init;
-	rte_sched_pipe_config;
-	rte_sched_port_config;
-	rte_sched_port_dequeue;
-	rte_sched_port_enqueue;
-	rte_sched_port_free;
-	rte_sched_port_get_memory_footprint;
-	rte_sched_port_pkt_read_color;
-	rte_sched_port_pkt_read_tree_path;
-	rte_sched_port_pkt_write;
-	rte_sched_port_subport_profile_add;
-	rte_sched_queue_read_stats;
-	rte_sched_subport_config;
-	rte_sched_subport_pipe_profile_add;
-	rte_sched_subport_read_stats;
-	rte_sched_subport_tc_ov_config;
-
-	local: *;
-};
diff --git a/lib/security/version.map b/lib/security/version.map
deleted file mode 100644
index 2a4795f31d..0000000000
--- a/lib/security/version.map
+++ /dev/null
@@ -1,37 +0,0 @@
-DPDK_25 {
-	global:
-
-	__rte_security_set_pkt_metadata;
-	rte_security_capabilities_get;
-	rte_security_capability_get;
-	rte_security_dynfield_offset;
-	rte_security_macsec_sa_create;
-	rte_security_macsec_sa_destroy;
-	rte_security_macsec_sa_stats_get;
-	rte_security_macsec_sc_create;
-	rte_security_macsec_sc_destroy;
-	rte_security_macsec_sc_stats_get;
-	rte_security_session_create;
-	rte_security_session_destroy;
-	rte_security_session_get_size;
-	rte_security_session_stats_get;
-	rte_security_session_update;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.11
-	rte_security_inb_pkt_rx_inject;
-	rte_security_oop_dynfield_offset;
-	rte_security_rx_inject_configure;
-};
-
-INTERNAL {
-	global:
-
-	rte_security_dynfield_register;
-	rte_security_oop_dynfield_register;
-};
diff --git a/lib/stack/version.map b/lib/stack/version.map
deleted file mode 100644
index 53c7d3d1c5..0000000000
--- a/lib/stack/version.map
+++ /dev/null
@@ -1,9 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_stack_create;
-	rte_stack_free;
-	rte_stack_lookup;
-
-	local: *;
-};
diff --git a/lib/table/version.map b/lib/table/version.map
deleted file mode 100644
index 718138554e..0000000000
--- a/lib/table/version.map
+++ /dev/null
@@ -1,53 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_table_acl_ops;
-	rte_table_array_ops;
-	rte_table_hash_cuckoo_ops;
-	rte_table_hash_ext_ops;
-	rte_table_hash_key16_ext_ops;
-	rte_table_hash_key16_lru_ops;
-	rte_table_hash_key32_ext_ops;
-	rte_table_hash_key32_lru_ops;
-	rte_table_hash_key8_ext_ops;
-	rte_table_hash_key8_lru_ops;
-	rte_table_hash_lru_ops;
-	rte_table_lpm_ipv6_ops;
-	rte_table_lpm_ops;
-	rte_table_stub_ops;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.11
-	rte_swx_table_exact_match_ops;
-	rte_swx_table_exact_match_unoptimized_ops;
-
-	# added in 21.05
-	rte_swx_table_wildcard_match_ops;
-
-	# added in 21.08
-	rte_swx_table_selector_create;
-	rte_swx_table_selector_footprint_get;
-	rte_swx_table_selector_free;
-	rte_swx_table_selector_group_set;
-	rte_swx_table_selector_mailbox_size_get;
-	rte_swx_table_selector_select;
-
-	# added in 21.11
-	rte_swx_table_learner_add;
-	rte_swx_table_learner_create;
-	rte_swx_table_learner_delete;
-	rte_swx_table_learner_footprint_get;
-	rte_swx_table_learner_free;
-	rte_swx_table_learner_lookup;
-	rte_swx_table_learner_mailbox_size_get;
-
-	# added in 22.07
-	rte_swx_table_learner_rearm;
-	rte_swx_table_learner_rearm_new;
-	rte_swx_table_learner_timeout_update;
-};
diff --git a/lib/telemetry/version.map b/lib/telemetry/version.map
deleted file mode 100644
index 8f032bf532..0000000000
--- a/lib/telemetry/version.map
+++ /dev/null
@@ -1,40 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_tel_data_add_array_container;
-	rte_tel_data_add_array_int;
-	rte_tel_data_add_array_string;
-	rte_tel_data_add_array_u64;
-	rte_tel_data_add_array_uint;
-	rte_tel_data_add_dict_container;
-	rte_tel_data_add_dict_int;
-	rte_tel_data_add_dict_string;
-	rte_tel_data_add_dict_u64;
-	rte_tel_data_add_dict_uint;
-	rte_tel_data_alloc;
-	rte_tel_data_free;
-	rte_tel_data_start_array;
-	rte_tel_data_start_dict;
-	rte_tel_data_string;
-	rte_telemetry_register_cmd;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 23.03
-	rte_tel_data_add_array_uint_hex;
-	rte_tel_data_add_dict_uint_hex;
-
-	# added in 24.11
-	rte_telemetry_register_cmd_arg;
-
-	local: *;
-};
-
-INTERNAL {
-	rte_telemetry_legacy_register;
-	rte_telemetry_init;
-};
diff --git a/lib/timer/version.map b/lib/timer/version.map
deleted file mode 100644
index 3f19be22d3..0000000000
--- a/lib/timer/version.map
+++ /dev/null
@@ -1,24 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_timer_alt_dump_stats;
-	rte_timer_alt_manage;
-	rte_timer_alt_reset;
-	rte_timer_alt_stop;
-	rte_timer_data_alloc;
-	rte_timer_data_dealloc;
-	rte_timer_dump_stats;
-	rte_timer_init;
-	rte_timer_manage;
-	rte_timer_next_ticks;
-	rte_timer_pending;
-	rte_timer_reset;
-	rte_timer_reset_sync;
-	rte_timer_stop;
-	rte_timer_stop_all;
-	rte_timer_stop_sync;
-	rte_timer_subsystem_finalize;
-	rte_timer_subsystem_init;
-
-	local: *;
-};
diff --git a/lib/vhost/version.map b/lib/vhost/version.map
deleted file mode 100644
index c044bb714e..0000000000
--- a/lib/vhost/version.map
+++ /dev/null
@@ -1,110 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_vdpa_find_device_by_name;
-	rte_vdpa_get_features;
-	rte_vdpa_get_protocol_features;
-	rte_vdpa_get_queue_num;
-	rte_vdpa_get_rte_device;
-	rte_vdpa_get_stats;
-	rte_vdpa_get_stats_names;
-	rte_vdpa_reset_stats;
-	rte_vhost_avail_entries;
-	rte_vhost_backend_config_change;
-	rte_vhost_clr_inflight_desc_packed;
-	rte_vhost_clr_inflight_desc_split;
-	rte_vhost_crypto_create;
-	rte_vhost_crypto_driver_start;
-	rte_vhost_crypto_fetch_requests;
-	rte_vhost_crypto_finalize_requests;
-	rte_vhost_crypto_free;
-	rte_vhost_crypto_set_zero_copy;
-	rte_vhost_dequeue_burst;
-	rte_vhost_driver_attach_vdpa_device;
-	rte_vhost_driver_callback_register;
-	rte_vhost_driver_detach_vdpa_device;
-	rte_vhost_driver_disable_features;
-	rte_vhost_driver_enable_features;
-	rte_vhost_driver_get_features;
-	rte_vhost_driver_get_protocol_features;
-	rte_vhost_driver_get_queue_num;
-	rte_vhost_driver_get_vdpa_dev_type;
-	rte_vhost_driver_get_vdpa_device;
-	rte_vhost_driver_register;
-	rte_vhost_driver_set_features;
-	rte_vhost_driver_set_max_queue_num;
-	rte_vhost_driver_set_protocol_features;
-	rte_vhost_driver_start;
-	rte_vhost_driver_unregister;
-	rte_vhost_enable_guest_notification;
-	rte_vhost_enqueue_burst;
-	rte_vhost_extern_callback_register;
-	rte_vhost_get_ifname;
-	rte_vhost_get_log_base;
-	rte_vhost_get_mem_table;
-	rte_vhost_get_monitor_addr;
-	rte_vhost_get_mtu;
-	rte_vhost_get_negotiated_features;
-	rte_vhost_get_negotiated_protocol_features;
-	rte_vhost_get_numa_node;
-	rte_vhost_get_vdpa_device;
-	rte_vhost_get_vhost_ring_inflight;
-	rte_vhost_get_vhost_vring;
-	rte_vhost_get_vring_base;
-	rte_vhost_get_vring_base_from_inflight;
-	rte_vhost_get_vring_num;
-	rte_vhost_log_used_vring;
-	rte_vhost_log_write;
-	rte_vhost_rx_queue_count;
-	rte_vhost_set_inflight_desc_packed;
-	rte_vhost_set_inflight_desc_split;
-	rte_vhost_set_last_inflight_io_packed;
-	rte_vhost_set_last_inflight_io_split;
-	rte_vhost_set_vring_base;
-	rte_vhost_vring_call;
-	rte_vhost_vring_call_nonblock;
-	rte_vhost_vring_stats_get;
-	rte_vhost_vring_stats_get_names;
-	rte_vhost_vring_stats_reset;
-
-	local: *;
-};
-
-EXPERIMENTAL {
-	global:
-
-	# added in 20.08
-	rte_vhost_async_channel_register;
-	rte_vhost_async_channel_unregister;
-	rte_vhost_submit_enqueue_burst;
-	rte_vhost_poll_enqueue_completed;
-
-	# added in 21.08
-	rte_vhost_async_get_inflight;
-	rte_vhost_async_channel_register_thread_unsafe;
-	rte_vhost_async_channel_unregister_thread_unsafe;
-	rte_vhost_clear_queue_thread_unsafe;
-
-	# added in 22.03
-	rte_vhost_async_dma_configure;
-
-	# added in 22.07
-	rte_vhost_async_get_inflight_thread_unsafe;
-	rte_vhost_async_try_dequeue_burst;
-	rte_vhost_clear_queue;
-
-	# added in 22.11
-	rte_vhost_async_dma_unconfigure;
-
-	# added in 23.07
-	rte_vhost_notify_guest;
-};
-
-INTERNAL {
-	global:
-
-	rte_vdpa_register_device;
-	rte_vdpa_relay_vring_used;
-	rte_vdpa_unregister_device;
-	rte_vhost_host_notifier_ctrl;
-};
-- 
2.49.0

