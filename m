Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10998606A31F
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=E3Xi2Bt8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C81024025A;
	Sun, 15 Nov 2026 20:22:20 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 7F8CF400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 20:22:19 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso1228875a91.3
 for <dev@dpdk.org>; Sun, 15 Nov 2026 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794770538;
 x=1795375338; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTUdKrRMOLrbTTRrlK4AkIVkb/bEclRJgtV+oMN1pBQ=;
 b=E3Xi2Bt8uMHQw0sovLWTl1niNwOVq4RS+/P8fJRNdduO29pWJMPtKmv8SEne8bFqA+
 PzVcmEap48RwFIsvmSzBWZ+Djj8F/Xa4riuuigNPceikb/+6JU1aiGck3iQiiCU1jn7P
 FKhGLESr467S6R1mS2/dALhtr60fgq9AJLQWYGrhfyp4d1be04o3K7dbpjJ4Csmr2648
 x8OHeP3KU5r/qc4vf1/1CuDEGq9lHmXFoVx1s2V3wrgYnAbF9PERfJwh1cpk7TD8vKWO
 7XMoJlINzzwpmJxTAucqeFnSbccsSV2kPK0DdCtzDQEzRAtjZBwRIM287jM2JVdksMUP
 kkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794770538; x=1795375338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTUdKrRMOLrbTTRrlK4AkIVkb/bEclRJgtV+oMN1pBQ=;
 b=fCWRfVNGZjTAIaMOEomcvPZwkfBG/qz4oMjP9GfOPcK3njyf6Y1nKbuXjom8g+l/YU
 0XHpgbfmS6244jEMj4MLMkJOOA+eCvZuHBvfIFmC3PiAmATPJqLc2Kc1+GwxUGpiJihL
 3nHs4z29uEN7mL4Gtiff6KaW8CCzAfqWvAN1A/LJKheS+egYMx0nzWW2/032qSg16CIP
 XdePReXPJ92mD/DPe2eWgQaN+mxMoHooG2k2jv09xyWfMIHykfOojn9BZMocpZ5c8z4L
 sm+3w3rnVIiWsZ1VbPY9B7nzqsqCBYmkbWUvH9IVFBanVvoOxLS2yhrpck2VTPWtnAjm
 Vsog==
X-Gm-Message-State: APuU4Z9IFGZV7NwfIn2h9POJp2RLm9TMBSOm8eBshTbSrKvtcIbfxokg
 V3ZbsU6dfxXdNongxGBkfIN08BmcLGsrCJQoAVB4cVTEMEfVd/fuzcic/+TksmvnuAILLsQPfBc
 Z4Ecgzlk=
X-Gm-Gg: AYBFou2vhPAOAwUiQiPxC+APJAnjiMnE9zUmWO4cEjlp+xr3XsjyO4XJ2kXzIOYOscC
 wJeCrxu/QsUPFnbTM19t8xioYEoB3mxFy3cMcC/xgAErpmdFTnW2d4Hsc6iAFBVb93+0DC4zey9
 wLuTtQE8GCLnsg+wJfwCjci3dWNLy3RdPYFdXnRDw9YMcgbP2WppyOJ9MrtK0+qNe+SW8wGegIo
 HrA5OgjGVgpk7T3hisTlCsxK0omJ8Yx/Dn+E20td9Dk6UZ4SQyNdNS6DK8Fqot3ZKaF4QUqPrWB
 2WhxN6US8g3c4Ws9IDr11fmZhvGvCjM5bhKs5T3F/R0ys69Hjc3C4p5bAYYlrqH2HWtWzI9IKh+
 zahnP8vHnyeo67g/WYAN/T7XX0vOvgUEDrBJ0xUuv3pPqIggGCweAtTYxN8GU67KzWKClJYrqxM
 hQGY5PAkVzUANNQOrYjsAnN+czSdVfENovOKIdry9E+uLrzxAtgAHpWbtrF4O6pw54F2FSCDWc/
 Q3AalLonwJ6xo0c7rpIYkordMNFlYHNbHCRYlsdhGcsSqmj07DOMiaqRq1E7FLOwdY5j18nX3Kh
 LIGB4Kq/q04s7j17P2f/RWuBgq7Q+KoKbJUkIJQrq6dthdsfaBssxg9JQrbqCSzlRPsUde+Sa51
 LeDmM+J1B8W7ZP2Ib
X-Received: by 2002:a17:90b:39ab:b0:3ab:33b6:2c27 with SMTP id
 98e67ed59e1d1-3b1b0a0e894mr8312866a91.23.1794770537891; 
 Sun, 15 Nov 2026 11:22:17 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec63b9bsm13640874a91.12.2026.11.15.11.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 11:22:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 =?UTF-8?q?M=C3=A1rio=20Kuka?= <kuka@cesnet.cz>
Subject: [PATCH 1/4] pcapng: call writev as needed on highly segmented mbuf
Date: Sun, 15 Nov 2026 11:22:15 -0800
Message-ID: <20261115192215.504383-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It is possible to have an mbuf with more segments than the
max number of io vectors (1024 on Linux). This is an odd corner
case but it is allowed by DPDK since maximum number of segments
per mbuf is UINT16_MAX.

The old check assumed a single mbuf chain always fit in the
io vector, so a chain longer than IOV_MAX overran the stack
array. Consolidate the checks so now when io vector gets full
it is written. A packet may now be split across writev calls;
the previous flush at packet boundaries was incidental and not
a documented guarantee.

Bugzilla ID: 2133
Fixes: 0744f1c9f991 ("pcapng: fix write more packets than IOV_MAX limit")
Cc: stable@dpdk.org

Reported-by: Anthropic OSS scanner (ANT-2026-DC6DT4HP)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index df38e4819c..ce71b07d93 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -706,20 +706,6 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
-		/*
-		 * Handle case of highly fragmented and large burst size
-		 * Note: this assumes that max segments per mbuf < IOV_MAX
-		 */
-		if (unlikely(cnt + m->nb_segs >= IOV_MAX)) {
-			ret = writev(self->outfd, iov, cnt);
-			if (unlikely(ret < 0)) {
-				rte_errno = errno;
-				return -1;
-			}
-			total += ret;
-			cnt = 0;
-		}
-
 		/*
 		 * The DPDK port is recorded during pcapng_copy.
 		 * Map that to PCAPNG interface in file.
@@ -727,16 +713,29 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		do {
 			iov[cnt].iov_base = rte_pktmbuf_mtod(m, void *);
 			iov[cnt].iov_len = rte_pktmbuf_data_len(m);
-			++cnt;
+
+			/* If current iov is maxed out then send it */
+			if (++cnt == IOV_MAX) {
+				ret = writev(self->outfd, iov, cnt);
+				if (unlikely(ret < 0)) {
+					rte_errno = errno;
+					return -1;
+				}
+				cnt = 0;
+				total += ret;
+			}
 		} while ((m = m->next));
 	}
 
-	ret = writev(self->outfd, iov, cnt);
-	if (unlikely(ret < 0)) {
-		rte_errno = errno;
-		return -1;
+	if (likely(cnt > 0)) {
+		ret = writev(self->outfd, iov, cnt);
+		if (unlikely(ret < 0)) {
+			rte_errno = errno;
+			return -1;
+		}
+		total += ret;
 	}
-	return total + ret;
+	return total;
 }
 
 /* Create new pcapng writer handle */
-- 
2.53.0

