Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5223C5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB3C402E3;
	Tue,  4 Aug 2026 10:13:32 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 3A66B402BB
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831210;
 bh=JijIV2lXrW0xPWu9jZX9qaUbRZZtLOdmCgnDkEXOZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N1a7M10T1ZaUERWLPpxyqGu3QqPEBYN46CNsRyI2WAOLxn9PoTj0i9C+02F4Z9Fhn
 xUjDkgE8UTCZF95E1moLUn8kqPEhb+IDnW/drhyOunotxhLHh5KTPIlnn8JbQEC5nF
 b2pgF9hZGSqbpr6ZICVa7GH5tG391iBD0plAjR4+SGYpkb2QOmTAUD9Zmsu0rgfsAK
 11msHlnVGeR/hHuhJciSlz+deep9S//wibOWOxBDe4dbTPXPb2NEkM2o9TiBkNvgVf
 QWh1CDvNdKgqFEUwrby3rDeyEeyrnfiobp07LSo6h0QHNs240C5PSd/735aNpNEfHm
 fYZsuDGANvUcw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C4EBFF0CE
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831210;
 bh=JijIV2lXrW0xPWu9jZX9qaUbRZZtLOdmCgnDkEXOZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N1a7M10T1ZaUERWLPpxyqGu3QqPEBYN46CNsRyI2WAOLxn9PoTj0i9C+02F4Z9Fhn
 xUjDkgE8UTCZF95E1moLUn8kqPEhb+IDnW/drhyOunotxhLHh5KTPIlnn8JbQEC5nF
 b2pgF9hZGSqbpr6ZICVa7GH5tG391iBD0plAjR4+SGYpkb2QOmTAUD9Zmsu0rgfsAK
 11msHlnVGeR/hHuhJciSlz+deep9S//wibOWOxBDe4dbTPXPb2NEkM2o9TiBkNvgVf
 QWh1CDvNdKgqFEUwrby3rDeyEeyrnfiobp07LSo6h0QHNs240C5PSd/735aNpNEfHm
 fYZsuDGANvUcw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id A86F5F0CB; Tue,  4 Aug 2026 10:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831206;
 bh=JijIV2lXrW0xPWu9jZX9qaUbRZZtLOdmCgnDkEXOZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o8ezTe4mhxuL4ehzy8ucp8XnSGBYA5iP6hyVeM9HsCtfvk6OzBDD31WumZWYPO6M7
 gzl+muuNMKIjvTs26O8iQUl8vee9C0jg+9WRT3Q8a2nrPXpBq84bDKm4JVRAK13Zbm
 maFRn7fd8o+M9I/yGMjQcjw7shEA6ArsNzXwEVz4r2KzY/EX1XF2u2bG37eToFLg4+
 j4Xq6QTueZZ3b0ROqHjQ30NITRLQNAidROqwtanVwVP8DNLI4Zx7JZ2p5fVk4j0aNE
 Y4dpZFLORoEHVTLvIU+d21XXoes+cYeG8cSEteflgocr2syg3UqU+1xUIKfZ8d9x/0
 klpV/XaYdKUKg==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id A5E43F18A;
 Tue,  4 Aug 2026 10:13:26 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 1/5] net: fix eCPRI delay measurement message header
Date: Tue,  4 Aug 2026 10:13:15 +0200
Message-ID: <20260804081319.1869087-2-hofors@lysator.liu.se>
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

struct rte_ecpri_msg_delay_measure covered only 2 of the 20 bytes of the
One-Way Delay Measurement message header (type #5), leaving out the
TimeStamp and the Compensation Value. Add them, per eCPRI V2.0 figure
23, and pack the struct, since the Compensation Value is not naturally
aligned on the wire.

The struct thus grows from 2 to 20 bytes, and struct
rte_ecpri_combined_msg_hdr, and with it struct rte_flow_item_ecpri, from
16 to 24 bytes. Extend the dummy array to five dwords, so that it again
bounds the message header union, and offers a dword view of all of it.

Fixes: d164c609e70b ("ethdev: add eCPRI key fields to flow API")

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/net/rte_ecpri.h                    | 11 ++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..dca75000b7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -109,6 +109,11 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* net: Added the missing ``TimeStamp`` and ``Compensation Value`` fields to
+  ``struct rte_ecpri_msg_delay_measure``, which grew from 2 to 20 bytes.
+  ``struct rte_ecpri_combined_msg_hdr``, and hence
+  ``struct rte_flow_item_ecpri``, grew from 16 to 24 bytes.
+
 
 Known Issues
 ------------
diff --git a/lib/net/rte_ecpri.h b/lib/net/rte_ecpri.h
index 19821336a6..6f6762ffb2 100644
--- a/lib/net/rte_ecpri.h
+++ b/lib/net/rte_ecpri.h
@@ -136,11 +136,16 @@ struct rte_ecpri_msg_rm_access {
 
 /**
  * eCPRI Message Header of Type #5: One-Way Delay Measurement
+ *
+ * The Compensation Value is a signed value, in units of 2^-16 ns.
  */
-struct rte_ecpri_msg_delay_measure {
+struct __rte_packed_begin rte_ecpri_msg_delay_measure {
 	uint8_t msr_id;			/**< Measurement ID */
 	uint8_t act_type;		/**< Action Type */
-};
+	uint8_t ts_sec[6];		/**< TimeStamp: seconds */
+	rte_be32_t ts_nsec;		/**< TimeStamp: nanoseconds */
+	rte_be64_t comp_val;		/**< Compensation Value */
+} __rte_packed_end;
 
 /**
  * eCPRI Message Header of Type #6: Remote Reset
@@ -174,7 +179,7 @@ struct rte_ecpri_combined_msg_hdr {
 		struct rte_ecpri_msg_delay_measure type5;
 		struct rte_ecpri_msg_remote_reset type6;
 		struct rte_ecpri_msg_event_ind type7;
-		rte_be32_t dummy[3];
+		rte_be32_t dummy[5];
 	};
 };
 
-- 
2.43.0

