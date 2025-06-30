Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1595C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 05:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95DF140264;
	Mon, 30 Jun 2025 07:58:07 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id D45354025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 07:58:04 +0200 (CEST)
X-QQ-mid: esmtpsz17t1751263077t82fe10ef
X-QQ-Originating-IP: 96K8hDt+wTa80n9j+X8Fw71iF/GzfsUCjMyQlPusxiU=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Jun 2025 13:57:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11947923578995635053
EX-QQ-RecipientCnt: 4
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v2 0/3] [v2]drivers/net/rnp fixed Coverity issue
Date: Mon, 30 Jun 2025 13:57:50 +0800
Message-Id: <20250630055753.35445-1-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M1zv3ViCPTTk9bGZEkO0ahnoMnf/qg3EBvoIJRZR0GbA5iqcQg1VgYWW
 mnaN63oUaNKnzZzRCHvDILneMNi1j0fezi4tDSlltzWp+yYVwf7bmzE/ykEugFKbHK6LwHc
 qjVbFpCbTjbgBZMdb+d1vZQPw2IO59kahz2wEZa84ILVTxcMvatGwMJ799QCnFGuFaGCOkB
 3wWwhYwaDyn9wKbSU7cK/1UJ9bGmkWuKTpQCywzhCvvx+XtkdmeBnkZz2EP6t9JkSRbOnKT
 BP1qkZNmBJWB67IfkiKLltXnphDkxeJJc3AmR/1WgJBSR58PlmcOUhnWou2CYHHBZQi0/Fp
 UEzyskme/xSAl/cqP7fJ7DlOUJGQJnfqY+56LzeFnqq2YBJSVy+9JRKYG7Ba9Y9F+8jJd27
 acWbp6oru5bRqE7ykqPONYVyMlEVULRLC+K64wbSzDOP/R0e0OKLuJ5WCYsUqctKbHbfA0Z
 zRXWkJ/MgN9o+UNB79ith3yYmTMPVxaJXEIQc0XW11hb6XjNIhpNjWuB6tanW04GP9kizVC
 3lm6j2yfIazzn0UK7i/VbNKNfCLJ5Hrev1Oqkwrwg/nzUE5h1wj4xviHSiq1IpzxXZN6ZNW
 BFsusaXazSd3PAX4nmASXa4PG5InF7JrPUFkRzZsaXxCnzrOa8nYOhL8LtfEOhi1kdJLCvx
 BXAJ/pHnlsDXGx58Q328ike8jNOEvmn2/4JowXc15ATEkcozsl7BKhf5QsegebpCyugcIjO
 p8E5aBPjbu1ohpw/tdNZXm3MueqVVpx4Xja4Xke7oLfmFR4uHYbxiXUhDZyIPN9nwYGfXON
 YlTp3ZRvkyodZmZh+QRG5nNhTFzXC2vxCLUSsUk9UTKb0laBvf5skq02pltsyc2LuOMaWEq
 H1XJIYo+IMh9iyzYdncf+FngjzNrCqbc0+kLXO8SYKFa2O8gGoRisRXXvDOznA6kAIv4fOt
 +cCW8ITLpPZPf/P2I5r2oylEie2+BwkQ2mjrAkTrPNWtGUw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

Wenbo Cao (3):
  net/rnp: add check firmware respond info
  net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
  net/rnp: fix TSO segmentation for packets of 64KB

 drivers/net/rnp/base/rnp_mbx_fw.c |  15 +++-
 drivers/net/rnp/rnp_ethdev.c      |  16 ++--
 drivers/net/rnp/rnp_rxtx.c        | 118 +++++++++++++++++++++++-------
 drivers/net/rnp/rnp_rxtx.h        |   1 +
 4 files changed, 116 insertions(+), 34 deletions(-)

-- 
2.34.1

