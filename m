Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32517CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06C724028C;
	Fri, 10 Oct 2025 09:01:35 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 41CDE40285
 for <dev@dpdk.org>; Fri, 10 Oct 2025 09:01:31 +0200 (CEST)
X-QQ-mid: zesmtpgz5t1760079686t6f9002fe
X-QQ-Originating-IP: 3a8ybQwGNWZKlxdq+3kW0n4hOSqh/AHnZE63kC77sGY=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 10 Oct 2025 15:01:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16597163795429758471
EX-QQ-RecipientCnt: 4
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v3 0/4] [v3]drivers/net/rnp fixed Coverity issue
Date: Fri, 10 Oct 2025 15:01:18 +0800
Message-Id: <20251010070122.161401-1-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M+okR60L6L4Zk2c/MNhpW7Z7I4JEFfdbMcwgL0hXvtG08uqTZ1dVlGeV
 sAQOk5Bg1+ooOsLGtCxFpx5ryvJnX2yGuCjwNVG7mIzJYEKSc+WE1Zk2nf9u/BH5MTqsLYC
 v/3l9pP96KqYEpjX8DUo6NhXJIojKmsWgiARF1tPo4hkddW1rzxklITmYyIVlY+DzRixLyt
 7/hJDhAGIRE9rW6xJ6h6/H60eDbKeT1XuyLSvZp2Oiqjvi4K159BhTTVyfOpljkT0T8ESdq
 toHEiu8U5ogFvAn5WuJ1dlYMSnzsX5n3K6VUA18dNDVxOQEYFYqy2WDZNguHsEXgDrCtNMD
 MKWAHF3p4iTtN/ufo3s2lwaUJ2NtKggsM+M2f7WismhE/9QJw8FaUl0Lyuh2H15hUbpKk0W
 y39bcxeslaqZhsbOjPYrU6BAh7EFx71UoVN9R3IETbiuJ5+Gv9C6pG09Kg8WAamz+ukuySE
 h5fi8vWJbdLhL7XUpGCBPL5k2OQa/XSxpSXHnOvVAI+6VrdD3+3rrcNB9baXB7YoNEupB9z
 0b4G/uTRBskUWnPI6XhcDWSqtibtXFI/u6GFSat4ksHYZaFMgXB7jDCwPlWzXLeOchQZ+wR
 zBTi3DV6jitxExsUM37Ui0mKQQm+JGiAFFaFVO6KZ5FgKWKieoKs0evautu1VN/daRvgrJu
 +CYN03w9eOV1ne5TfhAty991Ugu0qTPlqNdfildsaBWBXlgHcMvp8PCxsuIiOBc9iDonzho
 N65qYaaZwe2fPxLhDeILrRtpdpDHa3FRel8bw0HqYq1HIx9/y8nd5ufpfw6X5Z4tyZF8kYr
 DJN7twk5p8bVZobpSGqjwh264DLx3khkZBWzxr8DDeVaq50Jj4wqG1nBk8dWqPpjtrs3Rip
 HLRbt1d4Qcb3yQJYTO131quqj6Kzkg7kTQXR4tdsHZxoMx8H9ImuiMzPgHY2JvTrIqH2qr4
 LsU/BN2H8jV8MmKmfT2W0ttFCg3t3LdjBcq1infnMZ1LEh1mWJ1GoSfrRx/TVIZLMxBA6GR
 vupGCYa6Q2Hq2JJDwP+gbtOeR4r6gF92FuQDsDgazdnr46rOWh7PzqMo6FE+pYrAHUr6vhM
 c+hNn5KYdki
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

This patchset primarily optimizes the robustness of code logic and
resolves anomalies in TSO segmentation.

v3:
  * fixed no-lsc base api memory overflow.
v2:
  * Optimized logical portability per Stephen Hemminger's suggestions
v1:
  * fixed complie issue
v0:
  *:fixed the below issue:
  	Coverity issue: 468860,468866,468858
	Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
	Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
	Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
  *:fixed 64k tso

Wenbo Cao (4):
  net/rnp: add check firmware respond info
  net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
  net/rnp: fix TSO segmentation for packets of 64KB
  net/rnp: resolve coredump caused by memory overflow

 drivers/net/rnp/base/rnp_mbx_fw.c |  19 ++++-
 drivers/net/rnp/rnp_ethdev.c      |  16 ++--
 drivers/net/rnp/rnp_rxtx.c        | 118 +++++++++++++++++++++++-------
 drivers/net/rnp/rnp_rxtx.h        |   1 +
 4 files changed, 118 insertions(+), 36 deletions(-)

-- 
2.34.1

