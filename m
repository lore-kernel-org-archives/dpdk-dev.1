Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A13DC5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A301B4064F;
	Tue,  4 Aug 2026 10:13:37 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id ED8664064E
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831215;
 bh=EX/e/e8HB8DRiiQ7CAuoxJpt9Jo97QEcPmGiqrxqezc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ToV1OCaRtwc+OgQhg5Vs8jP0fIDNVORj1h55te33ijlZSumxbdAZ+TB0bQg8w7COd
 jZcg6LibGPl8sHCK6/7i8jt8T6vKwXth1YkdKxIq0kTn5G1J408oErAVevJiQEbznH
 EFWS5H1joFfFNEGkO7L9Yse9Ma7L1ruyuYkG1n5SOy1W1lgsN164vK1xb+bDITm6PN
 NOjjn2aALuQ0h+KUuh7wy/u6wfmENqGsJ3TEQKQaNgxoNG3ZukJCd+HzKN2WqUy+CI
 zBh0ESz1Fl1bGo4duxlWs23v1dHDRYGz6FkRA0IGKdNadJwfPfjx+9ogPybqvpbBIX
 eXXPE4SgVJqrw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id AB681F0D6
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831215;
 bh=EX/e/e8HB8DRiiQ7CAuoxJpt9Jo97QEcPmGiqrxqezc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ToV1OCaRtwc+OgQhg5Vs8jP0fIDNVORj1h55te33ijlZSumxbdAZ+TB0bQg8w7COd
 jZcg6LibGPl8sHCK6/7i8jt8T6vKwXth1YkdKxIq0kTn5G1J408oErAVevJiQEbznH
 EFWS5H1joFfFNEGkO7L9Yse9Ma7L1ruyuYkG1n5SOy1W1lgsN164vK1xb+bDITm6PN
 NOjjn2aALuQ0h+KUuh7wy/u6wfmENqGsJ3TEQKQaNgxoNG3ZukJCd+HzKN2WqUy+CI
 zBh0ESz1Fl1bGo4duxlWs23v1dHDRYGz6FkRA0IGKdNadJwfPfjx+9ogPybqvpbBIX
 eXXPE4SgVJqrw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 8F6BFF06C; Tue,  4 Aug 2026 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831207;
 bh=EX/e/e8HB8DRiiQ7CAuoxJpt9Jo97QEcPmGiqrxqezc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U6oShhVjPHhto0HoVOiIm6QM3jHpBs1ADTOiRM0D6CL9mzhCZRMHtnESoR2rvvGdW
 xO9e9/FBxSarS0Yz8BJgLvbGo4lUSA0GZIJhPuLfQ7IrdGJ/MPdBMQHqP9MtYHspC/
 jyM/yqq/f2dZFfxvehOaD+kp7XIXvm+C/PBLZWaFUvdwJJ4/ff4Hhb5VHRd9Sl8VUY
 wViSIv+WbuI0H3b4S0iZBwJyDkQqScvwzkhAaSuwkS9HZxZHeb3m5a3vOlLv73FDn7
 pL3CGkF9h4FducXhaGBvuEHLIupo2Wq29F/NxZQi5nJzGfhyrAyHSIpUNSK+a2yxoj
 V5yZyDB0mn9Pg==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 4592EF131;
 Tue,  4 Aug 2026 10:13:27 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 4/5] net: allow byte swapping eCPRI remote memory access
Date: Tue,  4 Aug 2026 10:13:18 +0200
Message-ID: <20260804081319.1869087-5-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804081319.1869087-1-hofors@lysator.liu.se>
References: <20260804081319.1869087-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

The first word of the Remote Memory Access message header (type #4) is
described with host byte order bit fields, but unlike the common header
it had no integer alias, leaving no clean way to convert it from network
byte order before accessing the fields.

Add a u32 alias, mirroring struct rte_ecpri_common_hdr. The new union
and struct are anonymous, so the layout, the size and the field access
are all unchanged.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/net/rte_ecpri.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/lib/net/rte_ecpri.h b/lib/net/rte_ecpri.h
index c147cb7b64..5fcc4e5853 100644
--- a/lib/net/rte_ecpri.h
+++ b/lib/net/rte_ecpri.h
@@ -168,17 +168,22 @@ struct rte_ecpri_msg_gen_data {
  * eCPRI Message Header of Type #4: Remote Memory Access
  */
 struct rte_ecpri_msg_rm_access {
+	union {
+		rte_be32_t u32;		/**< 4B first word in BE */
+		struct {
 #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
-	uint32_t ele_id:16;		/**< Element ID */
-	uint32_t rr:4;			/**< Req/Resp */
-	uint32_t rw:4;			/**< Read/Write */
-	uint32_t rma_id:8;		/**< Remote Memory Access ID */
+			uint32_t ele_id:16;	/**< Element ID */
+			uint32_t rr:4;		/**< Req/Resp */
+			uint32_t rw:4;		/**< Read/Write */
+			uint32_t rma_id:8;	/**< Remote Memory Access ID */
 #elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
-	uint32_t rma_id:8;		/**< Remote Memory Access ID */
-	uint32_t rw:4;			/**< Read/Write */
-	uint32_t rr:4;			/**< Req/Resp */
-	uint32_t ele_id:16;		/**< Element ID */
+			uint32_t rma_id:8;	/**< Remote Memory Access ID */
+			uint32_t rw:4;		/**< Read/Write */
+			uint32_t rr:4;		/**< Req/Resp */
+			uint32_t ele_id:16;	/**< Element ID */
 #endif
+		};
+	};
 	uint8_t addr[6];		/**< 48-bits address */
 	rte_be16_t length;		/**< number of bytes */
 };
-- 
2.43.0

