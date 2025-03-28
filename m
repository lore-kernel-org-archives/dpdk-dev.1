Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C34C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46DFD40261;
	Fri, 28 Mar 2025 06:15:00 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 122B34021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:14:56 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138889tzi8px
X-QQ-Originating-IP: LMi9qSMRPYtn0XQlehn8srZH6+irBonubJ3G/rDM4AA=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:14:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4705048113088406320
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 00/29] [v17]drivers/net Add Support mucse N10 Pmd Driver
Date: Fri, 28 Mar 2025 05:14:15 +0000
Message-Id: <20250328051444.1019208-1-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NRnIqN6C21qSzXQhvBM/aIUTXJn2Qmo4BfOnqbRSheU4gItjlzfik3fl
 bAG6fpWEFn5eatbtikZ4mgoS813Pq4x3qY2jCyeB8zsveTzQvPBVoZIp4q/0fkW/0fMkty8
 OD9GhfHkaVM87GgizqLzo44V+kiMGgb6X8H7cdCXorY6+OSYz2TcH2M08WEob/I093IZ/Qt
 V3/VJdkA7reV2Arwt7XhUGajdX2/wmRY7C3dszvUjEm9KUZhGfio7CyzeKZbJu++lh06cUf
 tK6nYgMQzxVK+G8bMdyGga5K3CLhLOjaGa3Z3evnDfQJt3U83kezEbmXlEYyec3YUL6i1Xp
 XI/Xyis1od6smI/G0eOa4snxp5xEdAHfrMc/C4W0L/F6+4t1iXpInpPNYbl7yaICPgelK0w
 ZV4AaK0D8c+ekf19wILpTqint2faRI1McgZfMBsobXhkMCsTNSbNLq5vvkNxgweaj0sW+D6
 O1qGbj57GK3kml/36thLnaQ0igYkNdCCDNU7Z9tVmnk2hSYluVVXuSiZMq4prX83Mf5ZJ9v
 abuvbgS2NwnRB+CYtYZLMIgvEOMPQhX1wLJai0S91ES4xqyQoJ1ZT+vml3fW9LggiRB17A9
 vZI4WcYctyfGFYj3JI3xffJ8aVSKg00mvSCWxfHAMeAjW2xT8yyNuon+1rBJnXG6adn/rf0
 xX4Nc+Hn51rDprHfP672Ip/04f6ws9CWVrfKa6tzmO1RMUpmp2grwmF/BJwBtI8ziV25Weh
 MscJTSQO7kMvD3lzovM16SIFIyyF+wKyYW+QE5neZtOk8CwDLaJz7LC1USvc2sFLroP8tJM
 N21uhMZf6jR0A6aj5EXWq+FdLlfOTMSmCdyLTNSOFk2giSMqQ1S0bgfm2LVgWkTwhsSCGFC
 2ad2oaSYjfT1OWaBF6fQ3Mom9h5aGYlfzLaobrSmwL1QDe7aQ+B7/mSKtStCwHPsla7qVst
 mDRrmhis9+xqv+bsrg22N2Lbnc3SwZOdW/okAnCnAOFdVGsBoN5Hz031Kd7Ro6RLtp8J06W
 x9kr+pnHIUY60mgkTsS0Ro03Lexj0nGSUzC9+3z9P3x5DlfB4z408VH/1EirOcXaMgoOoHE
 aZ/+AuHGnoiLjHk39O2D0U=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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
The Feature tx side can support tx-cksum-offload,tso,vxlan-tso 
flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
for sriov is also support.

Because of the chip design defect, for multiple-port mode
one pci-bdf will have multiple-port (max can have four ports)
so this code must be care of one bdf init multiple-port.

v17
  * base 25.07 porting
  * change rte_memcpy to memcpy
  * doc rnp.rst remove ocp support, change nic-card description

v16
  * fixed rxq/txq stop/start not add to eth_ops as rnp doc descript.

v15:
  * fixed scatter recv for jumbo frame test by dts mtu.

v14:
  * add multicast mac filter feature for basic nic feature.
  * fixed pvs studio low,media,high level warning as the below cmd
    pvs-studio-analyzer analyze -f build/compile_commands.json -j 8
    plog-converter -a GA:1,2,3 -t fullhtml PVS-Studio.log -o /root/report

v13:
  * Supplementary document about n10 network card characteristics.
  * update release_25_03.rst.
  * fixed the code style advisea Stephen Hemminger.
  * fixed the code issue check PVS-stdio for Static compilation error.

v12:
  * fixed __rte_packed __deprecated__ compile issue.

v11:
  * fixed array-bounds issue when used rte_memcpy src addr is
  * not enough to hold align dst.
  * improve efficient_code advised by Stephen

v10:
  * fixed mingw windows meson issue
  * rnp not support windows for now.

v9:
  * fixed commit log format check by devtools.
  * fixed code compile issue.

v8:
  * fixed codespell issue.
  * fixed MAINTAINERS file

v7:
  * add support nic basic feature such as rss vlan strip/filter,
  * mtu-change recv/send scater-recv/mutltiple-send.
  * fixed code rationality, advised by Ferruh Yigit.
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

Wenbo Cao (29):
  net/rnp: add skeleton
  net/rnp: add ethdev probe and remove
  net/rnp: add log
  net/rnp: support mailbox basic operate
  net/rnp: add device init and uninit
  net/rnp: add get device information operation
  net/rnp: add support MAC promisc mode
  net/rnp: add queue setup and release operations
  net/rnp: add queue stop and start operations
  net/rnp: add support device start stop operations
  net/rnp: add RSS support operations
  net/rnp: add support link update operations
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
  net/rnp: support VLAN offloads
  net/rnp: add support VLAN filters operations
  net/rnp: add queue info operation
  net/rnp: support Rx/Tx burst mode info
  net/rnp: add multicast MAC filter operation

 .mailmap                               |    1 +
 MAINTAINERS                            |    6 +
 doc/guides/nics/features/rnp.ini       |   34 +
 doc/guides/nics/img/mucse_nic_port.svg | 4023 ++++++++++++++++++++++++
 doc/guides/nics/index.rst              |    1 +
 doc/guides/nics/rnp.rst                |  123 +
 doc/guides/rel_notes/release_25_07.rst |    5 +
 drivers/net/meson.build                |    1 +
 drivers/net/rnp/base/meson.build       |   18 +
 drivers/net/rnp/base/rnp_bdq_if.c      |  398 +++
 drivers/net/rnp/base/rnp_bdq_if.h      |  154 +
 drivers/net/rnp/base/rnp_bitrev.h      |   64 +
 drivers/net/rnp/base/rnp_common.c      |  103 +
 drivers/net/rnp/base/rnp_common.h      |   17 +
 drivers/net/rnp/base/rnp_crc32.c       |   53 +
 drivers/net/rnp/base/rnp_crc32.h       |   11 +
 drivers/net/rnp/base/rnp_dma_regs.h    |   68 +
 drivers/net/rnp/base/rnp_eth_regs.h    |   94 +
 drivers/net/rnp/base/rnp_fw_cmd.c      |  162 +
 drivers/net/rnp/base/rnp_fw_cmd.h      |  357 +++
 drivers/net/rnp/base/rnp_hw.h          |  141 +
 drivers/net/rnp/base/rnp_mac.c         |  480 +++
 drivers/net/rnp/base/rnp_mac.h         |   36 +
 drivers/net/rnp/base/rnp_mac_regs.h    |  210 ++
 drivers/net/rnp/base/rnp_mbx.c         |  507 +++
 drivers/net/rnp/base/rnp_mbx.h         |   59 +
 drivers/net/rnp/base/rnp_mbx_fw.c      |  495 +++
 drivers/net/rnp/base/rnp_mbx_fw.h      |   24 +
 drivers/net/rnp/base/rnp_osdep.h       |  176 ++
 drivers/net/rnp/meson.build            |   27 +
 drivers/net/rnp/rnp.h                  |  262 ++
 drivers/net/rnp/rnp_ethdev.c           | 1868 +++++++++++
 drivers/net/rnp/rnp_link.c             |  436 +++
 drivers/net/rnp/rnp_link.h             |   52 +
 drivers/net/rnp/rnp_logs.h             |   36 +
 drivers/net/rnp/rnp_rss.c              |  367 +++
 drivers/net/rnp/rnp_rss.h              |   44 +
 drivers/net/rnp/rnp_rxtx.c             | 1822 +++++++++++
 drivers/net/rnp/rnp_rxtx.h             |  162 +
 39 files changed, 12897 insertions(+)
 create mode 100644 doc/guides/nics/features/rnp.ini
 create mode 100644 doc/guides/nics/img/mucse_nic_port.svg
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
2.25.1

