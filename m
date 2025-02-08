Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC5C02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6497140280;
	Sat,  8 Feb 2025 03:44:27 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 4ADF540270
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:44:25 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 2B4A0A4080; Sat,  8 Feb 2025 10:44:08 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v7 00/28] [v6]drivers/net Add Support mucse N10 Pmd Driver
Date: Sat,  8 Feb 2025 10:43:37 +0800
Message-Id: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
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

For This patchset just to support the basic chip init work
and user can just found the eth_dev, but can't control more.
For Now just support 2*10g nic,the chip can support
2*10g,4*10g,4*1g,8*1g,8*10g.
The Feature rx side can support rx-cksum-offload,rss,vlan-filter
flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
The Feature tx side can supprt tx-cksum-offload,tso,vxlan-tso 
flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
for sriov is also support.

Because of the chip desgin defect, for multiple-port mode
one pci-bdf will have multiple-port (max can have four ports)
so this code must be care of one bdf init multiple-port.

v7:
  * add suport nic basic feature such as rss vlan strip/filter,
  * mtu-change recv/send scater-recv/mutltiple-send.
  * fixed code rationality, adviced by Ferruh Yigit.
v6:
  * fixed the doc(rst) format problem advise by Thomas Monjalon

v5:
  * fixed the symbol name require by the style documentation

v4:
  * one patch has been forgot to upload :(

v3:
  * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
  * change iobar type to void suggest by Stephen Hemminger
  * add KMOD_DEP support for vfio-pci
  * change run-cmd argument parse check for invalid extra_args

v2:
  * fixed MAINTAIN maillist fullname format
  * fixed driver/net/meson the order issue of new driver to driver list
  * improve virtual point function usage suggest by Stephen Hemminger


Wenbo Cao (28):
  net/rnp: add skeleton
  net/rnp: add ethdev probe and remove
  net/rnp: add log
  net/rnp: support mailbox basic operate
  net/rnp: add device init and uninit
  net/rnp: add get device information operation
  net/rnp: add support mac promisc mode
  net/rnp: add queue setup and release operations
  net/rnp: add queue stop and start operations
  net/rnp: add support device start stop operations
  net/rnp: add RSS support operations
  net/rnp: add support link update operations.
  net/rnp: add support link setup operations
  net/rnp: add Rx burst simple support
  net/rnp: add Tx burst simple support
  net/rnp: add MTU set operation
  net/rnp: add Rx scatter segment version
  net/rnp: add Tx multiple segment version
  net/rnp: add support basic stats operation
  net/rnp: add support xstats operation
  net/rnp: add unicast MAC filter operation
  net/rnp: add supported packet types
  net/rnp: add support Rx checksum offload
  net/rnp: add support Tx TSO offload
  net/rnp: support VLAN offloads.
  net/rnp: add support VLAN filters operations.
  net/rnp: add queue info operation.
  net/rnp: support Rx/Tx burst mode info

 MAINTAINERS                         |    6 +
 doc/guides/nics/features/rnp.ini    |   33 +
 doc/guides/nics/index.rst           |    1 +
 doc/guides/nics/rnp.rst             |  100 ++
 drivers/net/meson.build             |    1 +
 drivers/net/rnp/base/meson.build    |   28 +
 drivers/net/rnp/base/rnp_bdq_if.c   |  397 ++++++++
 drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
 drivers/net/rnp/base/rnp_bitrev.h   |   64 ++
 drivers/net/rnp/base/rnp_common.c   |  103 ++
 drivers/net/rnp/base/rnp_common.h   |   17 +
 drivers/net/rnp/base/rnp_crc32.c    |   37 +
 drivers/net/rnp/base/rnp_crc32.h    |   10 +
 drivers/net/rnp/base/rnp_dma_regs.h |   68 ++
 drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
 drivers/net/rnp/base/rnp_fw_cmd.c   |  162 ++++
 drivers/net/rnp/base/rnp_fw_cmd.h   |  358 +++++++
 drivers/net/rnp/base/rnp_hw.h       |  136 +++
 drivers/net/rnp/base/rnp_mac.c      |  367 +++++++
 drivers/net/rnp/base/rnp_mac.h      |   34 +
 drivers/net/rnp/base/rnp_mac_regs.h |  207 ++++
 drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++++
 drivers/net/rnp/base/rnp_mbx.h      |   58 ++
 drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++++
 drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
 drivers/net/rnp/base/rnp_osdep.h    |  174 ++++
 drivers/net/rnp/meson.build         |   20 +
 drivers/net/rnp/rnp.h               |  258 +++++
 drivers/net/rnp/rnp_ethdev.c        | 1827 +++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_link.c          |  439 +++++++++
 drivers/net/rnp/rnp_link.h          |   38 +
 drivers/net/rnp/rnp_logs.h          |   37 +
 drivers/net/rnp/rnp_rss.c           |  367 +++++++
 drivers/net/rnp/rnp_rss.h           |   43 +
 drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h          |  162 ++++
 36 files changed, 8651 insertions(+)
 create mode 100644 doc/guides/nics/features/rnp.ini
 create mode 100644 doc/guides/nics/rnp.rst
 create mode 100644 drivers/net/rnp/base/meson.build
 create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
 create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
 create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
 create mode 100644 drivers/net/rnp/base/rnp_common.c
 create mode 100644 drivers/net/rnp/base/rnp_common.h
 create mode 100644 drivers/net/rnp/base/rnp_crc32.c
 create mode 100644 drivers/net/rnp/base/rnp_crc32.h
 create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
 create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
 create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
 create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
 create mode 100644 drivers/net/rnp/base/rnp_hw.h
 create mode 100644 drivers/net/rnp/base/rnp_mac.c
 create mode 100644 drivers/net/rnp/base/rnp_mac.h
 create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h
 create mode 100644 drivers/net/rnp/base/rnp_mbx.c
 create mode 100644 drivers/net/rnp/base/rnp_mbx.h
 create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
 create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h
 create mode 100644 drivers/net/rnp/base/rnp_osdep.h
 create mode 100644 drivers/net/rnp/meson.build
 create mode 100644 drivers/net/rnp/rnp.h
 create mode 100644 drivers/net/rnp/rnp_ethdev.c
 create mode 100644 drivers/net/rnp/rnp_link.c
 create mode 100644 drivers/net/rnp/rnp_link.h
 create mode 100644 drivers/net/rnp/rnp_logs.h
 create mode 100644 drivers/net/rnp/rnp_rss.c
 create mode 100644 drivers/net/rnp/rnp_rss.h
 create mode 100644 drivers/net/rnp/rnp_rxtx.c
 create mode 100644 drivers/net/rnp/rnp_rxtx.h

-- 
1.8.3.1

