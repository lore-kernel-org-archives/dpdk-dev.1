Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822FC982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 08:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39F89400EF;
	Sat, 19 Sep 2026 10:17:36 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3DD0F4021E;
 Fri, 18 Sep 2026 09:47:42 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789717659; h=from:subject:to:date:message-id;
 bh=PHbUXgGpCFMNKtHOa7V6d3KzgEH4Cw0fdNNIm7vaT8c=;
 b=Vvy/Zf22PJJ0y4+nyUtRVkMWqw4pUDuC+DKa3s9kzNMZsfykcp844cIf/k6XcjD5mkznirlJPF8
 wg4d+54wkv4fWHMKXToMGDHID+FqGJtnCX7BVM5VlUSc6XELVjcO18twY7Yy84CKb6sydARBHRjdh
 DCPCYl1qPwVFYxr1lIrJODdJIjhqwv8jn9FxngvlBVFmDwFwqVARMi3p1t8avM2vHbJfZyKmek14a
 wDhe+dIVBweQI8/kF12pIujHrTQC4JoLQr0YLG7J/M7b7bkYp/BsojPK7cyQkGLvB13H2kSMHsNQO
 n9WWy32XljRAbwU2rsrNTR+cr6iu56OXD8HA==
Received: from localhost.localdomain (192.168.0.250) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Fri, 18 Sep
 2026 10:47:36 +0300
From: Aleksandr Khromov <haa@amicon.ru>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <konstantin.ananyev@huawei.com>,
 <olivier.matz@6wind.com>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>,
 <haa@amicon.ru>, <stable@dpdk.org>
Subject: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Date: Fri, 18 Sep 2026 10:47:29 +0300
Message-ID: <20260918074729.79205-1-haa@amicon.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Originating-IP: [192.168.0.250]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:17:34 +0200
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

In rte_ipv6_phdr_cksum() the next header field, a uint8_t, is promoted to
a signed int before the left shift by 24. For protocol values >= 128
(for example IPPROTO_SCTP), proto << 24 does not fit in int, which is
undefined behaviour (signed left shift overflow) reported by UBSan:

  rte_ip6.h: runtime error: left shift of 132 by 24 places cannot be
  represented in type 'int'

Cast the operand to uint32_t before the shift so it is performed in
unsigned arithmetic. The resulting value is unchanged on two's
complement platforms. The same idiom is already used in RTE_IPV4().

Fixes: 6006818cfb26 ("net: new checksum functions")
Cc: stable@dpdk.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
---
 .mailmap          | 1 +
 lib/net/rte_ip6.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9e45cdce8f..2d55627dc5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -46,6 +46,7 @@ Alan Liu <zaoxingliu@gmail.com>
 Alan Winkowski <walan@marvell.com>
 Alejandro Lucero <alejandro.lucero@netronome.com>
 Aleksander Gajewski <aleksanderx.gajewski@intel.com>
+Aleksandr Khromov <haa@amicon.ru>
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
 Aleksandr Miloshenko <a.miloshenko@f5.com>
 Aleksey Baulin <aleksey.baulin@gmail.com>
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..14e0101c14 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -566,7 +566,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flags)
 		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero */
 	} psd_hdr;
 
-	psd_hdr.proto = (uint32_t)(ipv6_hdr->proto << 24);
+	psd_hdr.proto = (uint32_t)ipv6_hdr->proto << 24;
 	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 		psd_hdr.len = 0;
 	else
-- 
2.48.1

