Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F4CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F16402D7;
	Mon, 27 Oct 2025 04:15:58 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id F00E04003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 04:15:55 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534949tfae59dbd
X-QQ-Originating-IP: c/EQaZz71NewubktwSmP2q06exRaizZwsUn8CVn4ay0=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5853360276101735216
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 00/19] Wangxun Fixes
Date: Mon, 27 Oct 2025 11:15:23 +0800
Message-Id: <20251027031542.10512-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ONcd5u+FjiuQOKU4dpRYLTGr26S0SKTkSaG+7d1PwbnUe1UIKlzXto19
 siSkbLSTyvIFJpiZYNcHfZSUR8kAT6AiPWpw5VyrzTgcl98y/yvbNoy1iiakKQ0cIEj2+Fp
 MXxWFdmi8CguOEZrIouNR9/8Uf1oeq5eSnuG7IyCm+DTspmqRu8XXq+YNmniBIYUYigbdku
 PCe5nFnPQBNQfETLJaZg0nd04FySpFVa3ukaIAimACzGaDZ+PPP/O8EZZLcQ/vhhAn2CHHz
 lfMhM8T/1tcBeBYW9Yz07DXpi8Mltmxjw4GuXjuCLAwaS0DKemJeyOHNDHwUhCHwxZHJ1Ad
 lESJWfOx087xN4JZrc+/fvqdNPGNAH4wpVhqsNiSZ0eGS6gzEseKUMUBSxZvxceASRhwynk
 SFTzDAdlARA5ZFFu2vF8fD5lnOFXCWJmqegN0rdZUw3/45In+1mj6o4GyFdsMywOQjpdXB2
 5dg0S0ixeukLVMYJTDeo3NWbvCav5jR9Nc8y/1k5P2QsC+G8YAhUvy+1CYGHQg/Qz4S9jn6
 YD/bLqXYNM6iSFCfPu5cf3aaKRxugKLsi38/vMio39Z3cueX0FUN938a2LL64dygSY51LAA
 elsfJHhL8fUb6ou3MWswhAJSm0JF0GcTjJF1P4/IFa+iawkVBu2Om5lpFgyJ1uFbVhTDqU5
 rgzAdKFpsFz7PHeg+RkDg+65cONqRj4NTNtm1Za7s5oVLLeW3MNijFm088o6EhATg5THFT+
 UnajleXlQyh04zrKG+ppOg0gK0Qxccwvmy4q0BxxnXXAfhTN/n4N1sakZEDazQPZrCK+gSc
 IKp21K0BRtFFPB9rpnCuU+fsQu9P834T+mjiHCo44bLmwUW6pXwg4hSkC4wtcvrAU+4kVm6
 MUTYlNAO+VYtpOl8P1Xe143jUDdqKyyX7Lhzps4ae0PRbuhek4edsnTwx3bOZMtxL9nEWU2
 2/fyVsSGQbW0DIh6QC3RLkIUQXhR/r9ypSyMEnRS/y0TDxuhUwfzx0U/6Vl8GDf+0OChrBx
 /ayL5mJA==
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

Fix some usage issues.

Jiawen Wu (19):
  net/txgbe: fix hardware statistic rx_l3_l4_xsum_error
  net/ngbe: fix hardware statistic rx_l3_l4_xsum_error
  net/txgbe: reduce memory size of ring descriptors
  net/ngbe: reduce memory size of ring descriptors
  net/txgbe: fix VF Rx buffer size in config register
  net/ngbe: fix VF Rx buffer size in config register
  net/txgbe: remove duplicate txq assignment
  net/txgbe: add device arguments for FDIR
  net/txgbe: fix the maxinum number of FDIR filter
  net/txgbe: fix FDIR mode is not be cleared
  net/txgbe: fix FDIR drop action for L4 match packets
  net/txgbe: fix to create FDIR filter for tunnel SCTP packet
  net/txgbe: filter FDIR match flex bytes for tunnel packets
  net/txgbe: fix FDIR rule raw relative for L3 packets
  net/txgbe: fix FDIR input mask
  net/txgbe: switch to use FDIR when ntuple filter is full
  net/txgbe: fix VF-PF message for ntuple flow filter
  net/txgbe: switch to use FDIR on VF
  net/txgbe: remove unsupported flow action mark

 drivers/net/ngbe/ngbe_ethdev.c          |  17 ++
 drivers/net/ngbe/ngbe_rxtx.c            |  43 +++--
 drivers/net/ngbe/ngbe_rxtx.h            |   1 +
 drivers/net/ngbe/ngbe_rxtx_vec_neon.c   |   9 +-
 drivers/net/ngbe/ngbe_rxtx_vec_sse.c    |   9 +-
 drivers/net/txgbe/base/txgbe_mbx.h      |  21 ++
 drivers/net/txgbe/base/txgbe_type.h     |   4 +
 drivers/net/txgbe/base/txgbe_vf.c       |  52 ++++-
 drivers/net/txgbe/base/txgbe_vf.h       |   1 +
 drivers/net/txgbe/txgbe_ethdev.c        |  70 +++++--
 drivers/net/txgbe/txgbe_ethdev.h        |   7 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c     |  21 +-
 drivers/net/txgbe/txgbe_fdir.c          | 209 ++++++++++++++++++--
 drivers/net/txgbe/txgbe_flow.c          | 246 ++++++++++++++++++------
 drivers/net/txgbe/txgbe_rxtx.c          |  35 ++--
 drivers/net/txgbe/txgbe_rxtx.h          |   1 +
 drivers/net/txgbe/txgbe_rxtx_vec_neon.c |   9 +-
 drivers/net/txgbe/txgbe_rxtx_vec_sse.c  |   9 +-
 18 files changed, 634 insertions(+), 130 deletions(-)

-- 
2.48.1

