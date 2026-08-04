Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3155C5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92FAF4060F;
	Tue,  4 Aug 2026 10:13:33 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id A56C74042C
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831212;
 bh=is08lHuiwaqQDBO/r19+AQmOhw5az0yjzXt6CKG2plE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kLD1nTO8jPuMskNd0bUIQw+2ufwy1asHf4jvAxTlo48bdisXQdeOS2Vun+dj7ZYE9
 oRUeNUaVAzQXDnTZlJiak49WvUj9UozgCpxTzUTqTnBbmEUahgn5+nZ1ztx1xnxt+X
 FcQ8WQjCEjvnWGcjNkCtzLM9BEXSc001VSsCd8xYpC2crc/l0kDvM9Y1k/D2Hp/YzW
 EnxINAkmWMSB/rXqqrLD8sCd6fCDJHmogXZrUOwHtxuGpMbuqPP2viSt2mhU7AYKZL
 c8y+FkvftfoHWrSHpQ5jGZvxpdmpFbY6F2/p1KkE1E47OUZYPjmgrRSe9XFk9xUmzK
 FR164ll1ZQ+wA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 62AADF05E
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831212;
 bh=is08lHuiwaqQDBO/r19+AQmOhw5az0yjzXt6CKG2plE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kLD1nTO8jPuMskNd0bUIQw+2ufwy1asHf4jvAxTlo48bdisXQdeOS2Vun+dj7ZYE9
 oRUeNUaVAzQXDnTZlJiak49WvUj9UozgCpxTzUTqTnBbmEUahgn5+nZ1ztx1xnxt+X
 FcQ8WQjCEjvnWGcjNkCtzLM9BEXSc001VSsCd8xYpC2crc/l0kDvM9Y1k/D2Hp/YzW
 EnxINAkmWMSB/rXqqrLD8sCd6fCDJHmogXZrUOwHtxuGpMbuqPP2viSt2mhU7AYKZL
 c8y+FkvftfoHWrSHpQ5jGZvxpdmpFbY6F2/p1KkE1E47OUZYPjmgrRSe9XFk9xUmzK
 FR164ll1ZQ+wA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 53479F13E; Tue,  4 Aug 2026 10:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831207;
 bh=is08lHuiwaqQDBO/r19+AQmOhw5az0yjzXt6CKG2plE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D370Weixo/Nu8GWyUS5pSaWdc+7FeWYiwBMQ02eCwFOQ4RWhbdwFNeopvUQhG7aYd
 Eet/fB9max5DZOOrU/+Zp4H93ojUjCyQydcOo7f0YGah5LVpnLUBpZczz7I0vTKT9d
 hQDaTiwajL0GwflBC0i7h5NJyEDzdYZXJ271vV0SzV8TNFt09CN6TICq4pjtmJen+O
 KACYGg8fGPlesH6z219uRT2DwSCC0CQenTUiI8gaI11vrF431I9kJMZLOzeA3HVDV1
 WA6kx3nKEOZ9UWbt3FTM40KinB2ZW5nsu5k0ycw3JxFi0gODvNPbcaGwj8gL0p8Sfl
 kzuHHJLt+VZAA==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id D83B0F130;
 Tue,  4 Aug 2026 10:13:26 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 2/5] net: fix eCPRI remote reset message header size
Date: Tue,  4 Aug 2026 10:13:16 +0200
Message-ID: <20260804081319.1869087-3-hofors@lysator.liu.se>
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

The Remote Reset message header (type #6) is 3 bytes on the wire, but
padding made struct rte_ecpri_msg_remote_reset 4 bytes, so code using
sizeof() to step over the header skipped one byte too many.

Pack the struct, leaving the field offsets unchanged. Its size thus
goes from 4 to 3 bytes. struct rte_ecpri_combined_msg_hdr is
unaffected, since the One-Way Delay Measurement header is larger.

Fixes: d164c609e70b ("ethdev: add eCPRI key fields to flow API")

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/net/rte_ecpri.h                    | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dca75000b7..c52092b987 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -114,6 +114,9 @@ ABI Changes
   ``struct rte_ecpri_combined_msg_hdr``, and hence
   ``struct rte_flow_item_ecpri``, grew from 16 to 24 bytes.
 
+* net: Packed ``struct rte_ecpri_msg_remote_reset``, so that its size matches
+  the 3-byte message header on the wire. It shrank from 4 to 3 bytes.
+
 
 Known Issues
 ------------
diff --git a/lib/net/rte_ecpri.h b/lib/net/rte_ecpri.h
index 6f6762ffb2..6bacdbecc2 100644
--- a/lib/net/rte_ecpri.h
+++ b/lib/net/rte_ecpri.h
@@ -150,10 +150,10 @@ struct __rte_packed_begin rte_ecpri_msg_delay_measure {
 /**
  * eCPRI Message Header of Type #6: Remote Reset
  */
-struct rte_ecpri_msg_remote_reset {
+struct __rte_packed_begin rte_ecpri_msg_remote_reset {
 	rte_be16_t rst_id;		/**< Reset ID */
 	uint8_t rst_op;			/**< Reset Code Op */
-};
+} __rte_packed_end;
 
 /**
  * eCPRI Message Header of Type #7: Event Indication
-- 
2.43.0

