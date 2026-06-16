Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A5CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86033406BB;
	Tue, 16 Jun 2026 23:07:05 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id D36F540654
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:03 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13981833e13so2404441c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644023;
 x=1782248823; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRkm0EqGSZdjvppVElxHq8AHE7sLkmwonFYFq1QTs6E=;
 b=D9p2CCel9l5QJ7GivLIX/LvDTnPDDiCT/ehcStBB+mZx/cp+bjk/t7/6/kLxbS1er4
 RISvl6vvdcV2Y67xbdwkS/7QYDtcInYQj6aijt5BkQam7pqaxja2tPatVrViKKJqTNIR
 cF0LNZFZVocC3b/xwaNfZmSbPDUe68SLHweUCjiVKJSkEP+Lt9ownp2Y3KhuUjhaC6mU
 K1YP+wvy5jWz7ksm+NFl4hw6GdCPWGGHq9fm/pXqGhVn6yXZmBnhJXCrYZxN6PilXiNs
 VLkfjCdCsCEal7ycL1tQ4m2ami8wMhVAxWAZ39KOyuz+R6QO4mvApPEpCNLszLQm6REi
 Jrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644023; x=1782248823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRkm0EqGSZdjvppVElxHq8AHE7sLkmwonFYFq1QTs6E=;
 b=J1PlcdETSKLe7hm6lzvRrmAVFYeMfdnLblZefjnIy8SO5BnlWzWiW65h6G2comws/r
 lY/WLXFqXXk0AI5Sb761ikUksiUoB+AJ5ADqhUuuWWRexVNTBfibETF+wje8HVe90ViM
 w7Z6QnbtHn5OepFipQoiMwf+BACwO8te99nuaBzXjGEqmSri3YuafYtFMuBI2q4SMbF9
 42JiKIkNVNag2x4u9mKmmFruSI4Suy+9JSAVbUiwhemZieRQe821OUi6KUfGg8A6J/6v
 hkOfEe5i2qaE9NK9qXRKl57kVPz2tUFOVJ9eevgqZ00tpjaKuUCzA85568Cty1wMn7HR
 U5Bw==
X-Gm-Message-State: AOJu0YyNltRWOEFJ2O3I5OjIxQUw4oIDGSRpirjpnkqK3J6AngV6vJ87
 UQhBvCYXd5t/zZHRBe7Vwvo/wb+Xl0bMheuA+bS2GZ6aWDQz8Q/vlcrb35WIMgr5i9U3YbYH98f
 vWh4Q
X-Gm-Gg: Acq92OHD4WuAGC2YxAOS91ZpoTBtpYj4XN5mmWFHcC+d+AjQsG4uDe+8+vyUdYbVTca
 xSuSdAymQr7Ndds8gpKl04uoHodTdezutrCJEp3xGFMjPOG8/A7kKroJ9chEJZtXFbIUg2O7vNk
 aXF/xldGWctMvs7VvxosdSV6PPkDuauHp1yZLcey8eTmcvkWqb6MP6CPs4zg0uc8eZ/RAcTRmfi
 TAqs3qx9oa+aiO/zjVcXVQ8HZBARd6wEhCwWx3u8w6qMXzG9oCMYGlpC+1+fTepg1y1l36D+GA/
 jyqB7iiWu4oyalj1jPx3v3rPaR6xP+ihr6jBPyig3EjY7dX/8snncD6kn1wWJCrn8ClLKQMvyho
 gSx5KM7jJkk6cdpP2ViPamou5VJgKjgXV30PGHdtN9k/BunAD6u0WvFGi68cnBIA0zouZBEODz0
 EGLw8sgi2OUsxSWID+FFVoVklRPqsBov1lLmmBhYh/dwa94lyEBHIbpIvXmSyFeg==
X-Received: by 2002:a05:7022:43a2:b0:137:eac4:82ae with SMTP id
 a92af1059eb24-1398f6cb121mr321104c88.37.1781644022872; 
 Tue, 16 Jun 2026 14:07:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:07:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 2/6] ip_frag: discard datagrams with overlapping fragments
Date: Tue, 16 Jun 2026 14:05:34 -0700
Message-ID: <20260616210656.464062-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
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
andall received fragments are dropped. RFC 791 (IPv4) originally called
fortrimming and rewriting, but Linux discards for IPv4 as well, since
overlap has no legitimate use and is a known attack vector.

Depends on the duplicate-tolerance change so that an exact duplicate is
dropped on its own rather than discarding the whole datagram.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/ip_frag_internal.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 9a03ef995a..2505314a29 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -92,16 +92,34 @@ ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr,
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
+		if (ofs < fp->frags[i].ofs + fp->frags[i].len &&
+				fp->frags[i].ofs < ofs + len) {
+			ip_frag_free(fp, dr);
+			ip_frag_key_invalidate(&fp->key);
 			IP_FRAG_MBUF2DR(dr, mb);
 			return NULL;
 		}
-- 
2.53.0

