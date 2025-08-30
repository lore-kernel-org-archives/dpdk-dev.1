Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D59CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E9EF40A70;
	Sat, 30 Aug 2025 14:41:15 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id C7711402DC
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=s2MDLIpJQ0ZrWfX81Gq9BoxljKTRcg2/DCZ6q806okk=;
 b=HMIxkx2bbV7kAuS+R7bN12n8BVPs9BQSwC7KJvz+Z16ydZWMqJUOfdC5kuAS6M
 7cQtjt1Hxx9ma9viBgJfnFGAn/px/1wzmZxSxCiXqLCnGvGrZr+JWAvyoiq0aF/F
 3tHpzPOYrAZ6U6CDbVIFoRAPSrMipOw0steaD5WzkzfNQ=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S22;
 Sat, 30 Aug 2025 20:41:07 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 18/18] drivers/net: add hinic3 PMD build and doc files
Date: Sat, 30 Aug 2025 20:39:30 +0800
Message-ID: <20250830123942.5037-19-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S22
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFy3AFWDXF4DCFykGr1Utrb_yoW7KryDpa
 1UCaySvr40qF4xt3Z3AFyxAFWFvw1kKFyjkw43Ca4rZryDAFy5ZayUKFWYkF9Fqr1IyFyf
 ZFn8C393KFnYqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_EfrUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiARG5CmiydD3F6gAAsf
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

From: Yi Chen <chenyi221@huawei.com>=0D

The meson.build file is added to this patch to enable=0D
the hinic3 compilation function.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 doc/guides/nics/features/hinic3.ini | 61 +++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/meson.build | 50 +++++++++++++++++++++++=0D
 drivers/net/hinic3/meson.build      | 33 ++++++++++++++++=0D
 drivers/net/hinic3/mml/meson.build  | 33 ++++------------=0D
 drivers/net/meson.build             |  1 +=0D
 5 files changed, 153 insertions(+), 25 deletions(-)=0D
 create mode 100644 doc/guides/nics/features/hinic3.ini=0D
 create mode 100644 drivers/net/hinic3/base/meson.build=0D
 create mode 100644 drivers/net/hinic3/meson.build=0D
=0D
diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features=
/hinic3.ini=0D
new file mode 100644=0D
index 0000000000..f098eb0103=0D
--- /dev/null=0D
+++ b/doc/guides/nics/features/hinic3.ini=0D
@@ -0,0 +1,61 @@=0D
+;=0D
+; Supported features of the 'hinic3' network poll mode driver.=0D
+;=0D
+; Refer to default.ini for the full list of available PMD features.=0D
+;=0D
+[Features]=0D
+Speed capabilities   =3D Y=0D
+Link speed configuration =3D Y=0D
+Link status          =3D Y=0D
+Link status event    =3D Y ?=0D
+Rx interrupt         =3D Y=0D
+Queue start/stop     =3D Y=0D
+Runtime Rx queue setup =3D Y=0D
+Runtime Tx queue setup =3D Y=0D
+Burst mode info      =3D Y=0D
+Fast mbuf free       =3D Y=0D
+Free Tx mbuf on demand =3D Y=0D
+MTU update           =3D Y=0D
+Scattered Rx         =3D Y=0D
+TSO                  =3D Y=0D
+LRO                  =3D Y=0D
+Promiscuous mode     =3D Y=0D
+Allmulticast mode    =3D Y=0D
+Unicast MAC filter   =3D Y=0D
+Multicast MAC filter =3D Y=0D
+RSS hash             =3D Y=0D
+RSS key update       =3D Y=0D
+RSS reta update      =3D Y=0D
+VLAN filter          =3D Y=0D
+Flow control         =3D Y=0D
+Traffic manager      =3D Y=0D
+CRC offload          =3D Y=0D
+FEC                  =3D Y=0D
+L3 checksum offload  =3D Y=0D
+L4 checksum offload  =3D Y=0D
+Inner L3 checksum    =3D Y=0D
+Inner L4 checksum    =3D Y=0D
+Packet type parsing  =3D Y=0D
+Basic stats          =3D Y=0D
+Extended stats       =3D Y=0D
+Stats per queue      =3D Y=0D
+FW version           =3D Y=0D
+Registers dump       =3D Y=0D
+Module EEPROM dump   =3D Y=0D
+Timesync             =3D Y=0D
+Multiprocess aware   =3D Y=0D
+Linux                =3D Y=0D
+x86-64               =3D Y=0D
+ARMv8                =3D Y=0D
+=0D
+[rte_flow items]=0D
+any                  =3D Y=0D
+eth                  =3D Y=0D
+icmp                 =3D Y=0D
+ipv4                 =3D Y=0D
+ipv6                 =3D Y=0D
+tcp                  =3D Y=0D
+udp                  =3D Y=0D
+vxlan                =3D Y=0D
+[rte_flow actions]=0D
+queue                =3D Y=0D
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/=
meson.build=0D
new file mode 100644=0D
index 0000000000..b6a3a6cfe7=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/meson.build=0D
@@ -0,0 +1,50 @@=0D
+# SPDX-License-Identifier: BSD-3-Clause=0D
+# Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+=0D
+sources =3D files(=0D
+        'hinic3_cmdq.c',=0D
+        'hinic3_eqs.c',=0D
+        'hinic3_hw_cfg.c',=0D
+        'hinic3_hw_comm.c',=0D
+        'hinic3_hwdev.c',=0D
+        'hinic3_hwif.c',=0D
+        'hinic3_mbox.c',=0D
+        'hinic3_mgmt.c',=0D
+        'hinic3_nic_cfg.c',=0D
+        'hinic3_nic_event.c',=0D
+        'hinic3_wq.c',=0D
+)=0D
+=0D
+extra_flags =3D []=0D
+=0D
+# The driver runs only on arch64 machine, remove 32bit warnings=0D
+if not dpdk_conf.get('RTE_ARCH_64')=0D
+    extra_flags +=3D [=0D
+            '-Wno-int-to-pointer-cast',=0D
+            '-Wno-pointer-to-int-cast',=0D
+    ]=0D
+endif=0D
+=0D
+foreach flag: extra_flags=0D
+    if cc.has_argument(flag)=0D
+        cflags +=3D flag=0D
+    endif=0D
+endforeach=0D
+=0D
+deps +=3D ['hash']=0D
+c_args =3D cflags=0D
+includes +=3D include_directories('../')=0D
+=0D
+base_lib =3D static_library(=0D
+    'spnic_base',=0D
+    sources,=0D
+    dependencies: [=0D
+        static_rte_eal,=0D
+        static_rte_ethdev,=0D
+        static_rte_bus_pci,=0D
+        static_rte_hash,=0D
+    ],=0D
+    include_directories: includes,=0D
+    c_args: c_args,=0D
+)=0D
+base_objs =3D base_lib.extract_all_objects()=0D
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.buil=
d=0D
new file mode 100644=0D
index 0000000000..42fb5bc194=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/meson.build=0D
@@ -0,0 +1,33 @@=0D
+# SPDX-License-Identifier: BSD-3-Clause=0D
+# Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+=0D
+if not is_linux=0D
+    build =3D false=0D
+    reason =3D 'only supported on Linux'=0D
+    subdir_done()=0D
+endif=0D
+=0D
+if (arch_subdir !=3D 'x86' and arch_subdir !=3D 'arm'=0D
+        or not dpdk_conf.get('RTE_ARCH_64'))=0D
+    build =3D false=0D
+    reason =3D 'only supported on x86_64 and aarch64'=0D
+    subdir_done()=0D
+endif=0D
+=0D
+cflags +=3D ['-DHW_CONVERT_ENDIAN']=0D
+=0D
+subdir('base')=0D
+subdir('mml')=0D
+objs =3D [base_objs] + [mml_objs]=0D
+=0D
+sources =3D files(=0D
+        'hinic3_ethdev.c',=0D
+        'hinic3_fdir.c',=0D
+        'hinic3_flow.c',=0D
+        'hinic3_nic_io.c',=0D
+        'hinic3_rx.c',=0D
+        'hinic3_tx.c',=0D
+)=0D
+=0D
+includes +=3D include_directories('base')=0D
+includes +=3D include_directories('mml')=0D
diff --git a/drivers/net/hinic3/mml/meson.build b/drivers/net/hinic3/mml/me=
son.build=0D
index f8d2650d8d..67bba4f067 100644=0D
--- a/drivers/net/hinic3/mml/meson.build=0D
+++ b/drivers/net/hinic3/mml/meson.build=0D
@@ -2,36 +2,19 @@=0D
 # Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
 =0D
 sources =3D files(=0D
-    'hinic3_dbg.c',=0D
-    'hinic3_mml_cmd.c',=0D
-    'hinic3_mml_ioctl.c',=0D
-    'hinic3_mml_lib.c',=0D
-    'hinic3_mml_main.c',=0D
-    'hinic3_mml_queue.c',=0D
+        'hinic3_dbg.c',=0D
+        'hinic3_mml_cmd.c',=0D
+        'hinic3_mml_ioctl.c',=0D
+        'hinic3_mml_lib.c',=0D
+        'hinic3_mml_main.c',=0D
+        'hinic3_mml_queue.c',=0D
 )=0D
 =0D
-extra_flags =3D [=0D
-    '-Wno-cast-qual',=0D
-    '-Wno-format',=0D
-    '-Wno-format-nonliteral',=0D
-    '-Wno-format-security',=0D
-    '-Wno-missing-braces',=0D
-    '-Wno-missing-field-initializers',=0D
-    '-Wno-missing-prototypes',=0D
-    '-Wno-pointer-sign',=0D
-    '-Wno-pointer-to-int-cast',=0D
-    '-Wno-sign-compare',=0D
-    '-Wno-strict-aliasing',=0D
-    '-Wno-unused-parameter',=0D
-    '-Wno-unused-value',=0D
-    '-Wno-unused-variable',=0D
-]=0D
-=0D
 # The driver runs only on arch64 machine, remove 32bit warnings=0D
 if not dpdk_conf.get('RTE_ARCH_64')=0D
     extra_flags +=3D [=0D
-        '-Wno-int-to-pointer-cast',=0D
-        '-Wno-pointer-to-int-cast',=0D
+            '-Wno-int-to-pointer-cast',=0D
+            '-Wno-pointer-to-int-cast',=0D
     ]=0D
 endif=0D
 =0D
diff --git a/drivers/net/meson.build b/drivers/net/meson.build=0D
index 61f8cddb30..2d32068ed2 100644=0D
--- a/drivers/net/meson.build=0D
+++ b/drivers/net/meson.build=0D
@@ -23,6 +23,7 @@ drivers =3D [=0D
         'failsafe',=0D
         'gve',=0D
         'hinic',=0D
+        'hinic3',=0D
         'hns3',=0D
         'intel/e1000',=0D
         'intel/fm10k',=0D
-- =0D
2.45.1.windows.1=0D
=0D

