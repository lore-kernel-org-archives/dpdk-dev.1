Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E9C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F1244068E;
	Wed,  1 Jul 2026 18:21:35 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 3C9F440278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:33 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-37e4098e920so550602a91.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922892;
 x=1783527692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exHYOzmCYGoqgbDXc/Z+kEYRYI01q9q7CCR3FkIzJGM=;
 b=cUFMyEVfiajboWpYR9xSO7NvhcIKhEtI5voBi+DirDzWX+rBngVkEG3VLpZ8h/lc+M
 Qs+N/dYL5TLZ6HPyB0QpLgb9wIj1da+DV7SCt7PU9IzV6ldwjyd4mSIcs1zns4rlw/Sy
 wjunx4PeqwFkITCJZK3buLMQaUe/RiZ2deKXBvMHveEI9TKtCkb2mSwTH7Otq0ibkkeS
 n/zo83nsMazA/KjIOGKFGTTQ7t4SqW8yWLd3WYLMzXZvwBITzUUahi/8rPbDoOGd05rX
 nypduPAOIQnOdSHRQcppyTXogj1Lda9kEQfcpcv9B2cGMDau2i1z7M+kzcxIT7X8/Ym7
 lGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922892; x=1783527692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exHYOzmCYGoqgbDXc/Z+kEYRYI01q9q7CCR3FkIzJGM=;
 b=rCAgzWRX1aanjog2Ec1AeGdVJUXFpccdF/qiC2TZjJj0QyUOLEhICOhD8ZI5a86tay
 kLKrsnPCXDgBKwliIpDWU2CAJM20SZDLAyWQwNPzZe35jAGJcFdrDSwcER8a7uZkim8d
 iRoK7VJ8j8IOOrh0kEFO9mgeB10QPFw/pSAY4L/GaFKwc5ryc1mTT8G3r9+6PKtA29gu
 v0tlLhIvdWBIVJcigEDiLQAAmnOq0/JltpIcVC5TUFYXcSMY0gdFZQYpX6luvCqwaL50
 67KnH9eSYC3qqX1gbK2mPOpTf4pYa1vEwMO52rldgtQ+Iu+KbQmftDlUHKF9cX4PkhKR
 UFtQ==
X-Gm-Message-State: AOJu0YxdE6Q0+TGVdtxbjNA6Em5nnfE+Nz7AhqNcYhEQNUG//qoh7QHS
 MQ9h2oxykrIho0V9xOa0c8iPEiQIjT+wMSJhi4k0xeSCUy8zk0nK7XA8ICjEB2WpXgkCZLuKyDK
 QUBvx
X-Gm-Gg: AfdE7cnvxZNyS6qPXPfe8MgdWy9RW+jCMgbOJkst4tgjz8ImmWACAR6y/LHgR+fu4w/
 Xt7VN7q4CD9btIzcCjTNVtxzdXZAUX2XCWb+bDJn6BWnd0c4yQ1FZKnjLvpKcR03yiGP9mA5m+1
 bEhhhKyAV8WbwHTo4ueCtS78+w3L/EwAfjQMb1pOMKji781Bwn4NlmNbQ4T//qXc/Z9U0iJ0zGF
 V9fDNnrKC+jxeRJhokdL0fJfeP6nXJ1Ocq1CvUcYLFL8T2z/QGFCVKAVqPPSYkDVLFQkzpWAhew
 TIK10raC0ewsk+J8zKwrRjAwpHu1TCU0m5+oyH57D9MYxgKgndktMmn9QlMbebVzxhpCf8iXSV1
 J0E7Bnu/lYLXbbWRNaW/2SVFit13lkwHmYYECVpD2xPLRXBiXWmU3lVO2RjSa2e700Py/1cWut0
 sfyYaZnm/jiXvgVLQ4RgRtJ8+QfmJreSYvna4dVEFM1sFVV+0w2Azho9J1XqZJ8Q==
X-Received: by 2002:a17:90b:3d8f:b0:380:540:d49a with SMTP id
 98e67ed59e1d1-380aa0abef6mr2471438a91.7.1782922892352; 
 Wed, 01 Jul 2026 09:21:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 2/8] ip_frag: discard datagrams with overlapping fragments
Date: Wed,  1 Jul 2026 09:20:27 -0700
Message-ID: <20260701162127.207318-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Existing code does not handle overlapping fragments.

RFC 8200 (IPv6) requires that on overlap all reassembly is abandoned
and all received fragments are dropped. RFC 791 (IPv4) originally called
for trimming and rewriting, but Linux discards for IPv4 as well, since
overlap has no legitimate use and is a known attack vector.

Depends on the duplicate-tolerance change so that an exact duplicate is
dropped on its own rather than discarding the whole datagram.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/ip_frag_internal.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 9a03ef995a..55fc4e9343 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -92,16 +92,38 @@ ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr,
 	uint32_t i, idx;
 
 	/*
-	 * Discard an exact duplicate fragment. If a previously stored fragment
-	 * already covers the same offset and length, this fragment carries no
-	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
-	 * only this mbuf and keep the reassembly entry intact rather than
-	 * treating it as an error. Fragments overlapping an existing one with
-	 * different bounds are not handled here.
+	 * Scan the fragments already collected for this datagram before
+	 * storing the new one. The stored set is kept free of duplicates and
+	 * overlaps, so a single pass is sufficient.
 	 */
 	for (i = 0; i != fp->last_idx; i++) {
-		if (fp->frags[i].mb != NULL && fp->frags[i].ofs == ofs &&
-				fp->frags[i].len == len) {
+		if (fp->frags[i].mb == NULL)
+			continue;
+
+		/*
+		 * Exact duplicate: carries no new data. Reassembly tolerates
+		 * duplicates (RFC 791), so drop only this mbuf and keep the
+		 * entry.
+		 */
+		if (fp->frags[i].ofs == ofs && fp->frags[i].len == len) {
+			IP_FRAG_MBUF2DR(dr, mb);
+			return NULL;
+		}
+
+		/*
+		 * Overlap with an existing fragment. Per RFC 8200 section 4.5
+		 * (and RFC 5722) the datagram must be discarded; the same is
+		 * applied to IPv4. Free all collected fragments, drop this one,
+		 * and invalidate the entry.
+		 */
+		if (ofs < fp->frags[i].ofs + fp->frags[i].len && fp->frags[i].ofs < ofs + len) {
+			IP_FRAG_LOG(DEBUG,
+				    "%s:%d overlap ofs: %u len: %u\n"
+				    "fragment: %p ofs: %u len %u\n\n",
+				    __func__, __LINE__, ofs, len,
+				    fp, fp->frags[i].ofs, fp->frags[i].len);
+			ip_frag_free(fp, dr);
+			ip_frag_key_invalidate(&fp->key);
 			IP_FRAG_MBUF2DR(dr, mb);
 			return NULL;
 		}
-- 
2.53.0

