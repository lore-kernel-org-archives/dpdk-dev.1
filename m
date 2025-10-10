Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C358CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7C440674;
	Fri, 10 Oct 2025 09:01:52 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 956F340647;
 Fri, 10 Oct 2025 09:01:48 +0200 (CEST)
X-QQ-mid: zesmtpgz5t1760079699t51a061f1
X-QQ-Originating-IP: /dU9by8AIi5KdcazhuMt3M+hdbnDpTh/HW0YXjEEPnY=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 10 Oct 2025 15:01:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12902602131518154599
EX-QQ-RecipientCnt: 6
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org, Wenbo Cao <caowenbo@mucse.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v3 4/4] net/rnp: resolve coredump caused by memory overflow
Date: Fri, 10 Oct 2025 15:01:22 +0800
Message-Id: <20251010070122.161401-5-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010070122.161401-1-caowenbo@mucse.com>
References: <20251010070122.161401-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: ML8hOghqQD+0ratSG4LSFzRPshZlvFP+IuRYKVY1cTsh8chiXSRgXmJ5
 yDJYipEzlZAd482c5k8VNCsiDbv59E/CZkUplOhPCCSVbm9CIEHh/lDmmppkA1C6BhGpJxN
 2Vsoo4IZ1jjYZWfnvH2M8y36jRhJIM/OnnOsvknQbZSdn+l12PHSo/j2Bv2xXMXKKXPF9W6
 CeX1ZZE6hXqp5oE9EW/B98uJnyidvpOOg5jCQAGZVSQYINou5yJhEen6ljMS7NMtQ47Ey4p
 KnapXOBNCC7dk+1UimqvDsPG/o0YapfcpENTpM0PcU6iS//SHKhYNxImf2Uq8U0FShQuwTF
 h6TtH17G3yuHanQrplLEdx1PRG4yB7uhsntAjzKbCD2m6vD8d6bpPKkKhQpDD/ZB1Nr90E/
 Ztbp4kiuqOSOPV635n2ZMPhXlNppqdKFgwQLpxFiGLh6cJf1XfZpk7ga6s/Rq6rXa2FTCyn
 c9rSQ/YIs8W9XVxRpRdRD5CXeoHlCa2bi8uHVJ0wIdZMOK5H/XCR0uFQY40Eu1edK9tyl5M
 3svrUf5xROm3kMVx5L8DwxNddGqgrUDkAEEEs8kwxohwhwl/1gXVTHhkgSos4yj7Xu6MD5/
 Ja08PBARfqa+9THwu2isP4BhSFQKS69LV55hyUofX3R0WaFyK0sNl9GHT1HlWjmhz+Hqo9Z
 GTqQFGIj7zPHEHzlTd5Y+4bmD10bVcmwmkeE0uUK1uolxz2w0ykVwdG5BLVuni3tfo7EfLP
 elDZCLOKKkRQkmbA7WSvOBacYNy25UbfxpqSN0FAuC5giDJ41gnKz2gRnEtXq33ypHjrroI
 3wz6RqpNb0hJWTb7RbTo5NO+oA/1Hly/MrA6QfXzX3i4sxtHtFqx5Hys652z+wDx0nISjtL
 XPpSkJmD6xLXrsDm7c77FxMZ1vuLI6BvQsJx0nq0QWiCAC0996ngHr292s1ybv16f1LTLrv
 xbVyNWvBbENb+G4J2CgigXoYuwX8V0zQvq6VV+jM/JT4WH2wqonZYegwMxDUsHzUxyHWisS
 OE8op7h+PFTuZBfEirfCT88ZMNHs1nmsHoehij7GWO+IC4soGeuKQ57zCb0aaV8RrTRtTvg
 Q==
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

Fix memory overflow issue running with --no-lsc-interrupt
when link update.

Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
Cc: stable@dpdk.org

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/base/rnp_mbx_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index 7ae8763a4a..307323b3d1 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -174,7 +174,7 @@ rnp_fw_send_cmd(struct rnp_eth_port *port,
 		if (err)
 			return err;
 		if (respond)
-			memcpy(respond, cookie->priv, sizeof(cookie->priv));
+			memcpy(respond, cookie->priv, RNP_FW_REP_DATA_NUM);
 	} else {
 		rnp_build_fwcmd_req(&req, arg, &req);
 		err = rnp_fw_send_cmd_wait(port, &req, &reply);
-- 
2.34.1

