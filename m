Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229BEC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5F5140695;
	Tue, 30 Jun 2026 17:37:32 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id BF75840695
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:29 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-137335bc3caso9808244c88.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833848;
 x=1783438648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4z37fT09ZccD8OfPv74uhVJXS+RADKXdtmxz7gjdExU=;
 b=ig8COv2eceYZ8cBva5V+ifPaAkv8053mYOunhnzE9yPcDW/xEb7Vvdg0imTb++jROu
 u6DpiL7BVNQR6scWp532OjmWsVkWC5rdtk6XicEmjAhRmd4BoxmOsQqJkQyYvzDjGEwb
 QH7zEFOeCkwfDVXdIw/6X2sHbCgJTWksHXPrIZX7iq9DiBTMR5L7sEIxCswgLf9/LG4q
 GbGkhfpBuNkW4jj9/biZWJ9hj/p+7mfX5rF3rPRTgx9DQ/Mwrbnl214qnhaN4bTS56CN
 E1KewuCzmsOn5zcV98QgvNwgpJ9rtzsjLyspIVrFVttlXq5GPwH6HrKPVt4VJb5sysW5
 r9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833848; x=1783438648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4z37fT09ZccD8OfPv74uhVJXS+RADKXdtmxz7gjdExU=;
 b=ChDSdzfyUmRkGiKp/iLLe10dQGjs3KHtXfotHkPDHh8jPHvG4BUnzJ5aM8wiXCIWcy
 YUKMKn9cfE67/jbTD5Laz68tk9MF2kLJhXzXKyfC45N+w6MwQznD0k74VSLK3kgMr+gv
 B2jHlguJLm9oK0L56rFGU6g/LZQ5HzvwIzgjWf9jf6AiVaau8qjTyMjieDe+X3+vOVb9
 xTGH8pLJKy/Rr96lBeM4je1gPxfXNQ4FH597wkjnam/RpBkQr5ASowhPa2vSdbI1suBC
 qhvQkQBj7Y5rX52uqJJrYqsAp6ks02ou4xiWLqE2RRc9KtXBKbRfS/lntKNK07jJMp3U
 qSvg==
X-Gm-Message-State: AOJu0YxxvUPkb+aLKcwKndn909JFuS0tsJZlzLkvgYpdQexXtb0x4mlS
 J4i3d3NSsZ2Ot7PkUj8V3m5Jg175nNE22oDyFfPwm8Sw5l3eH5v0prlcny5bHelQ32nW2/U2Bjc
 ZXc+A
X-Gm-Gg: AfdE7cmP/9L1pWIJCDwdGIPv/maBTrHgvYGn/aTfortH1qs5ZPwOwgoK6nOH450xz7t
 QXryst8UG4gaGfbk7yLvqc1cuEH7ea30I+8RBpk2EtP9V+cBlyPl5s2KjVAF46M9+/30+XZeQwg
 4hPvgsazkVuT+jMfcKbSaVDTvbnmr07+ApldNhKTDFe9qV/Y6jYtrn8mx4JS9Fy4CTQMJ1ESuIk
 xlZbmzIdyRhSD1wy4flBV/fE7RjxoZfbyPE2n4IwKHuJI/FA5VH+IoG7bd8xf3j4Kd8/6PcB/Jq
 pyQ7XDRk303HU0qftZGXvx/6ZpafjV7hnvw3SCLNzAAmUvxGjdfzJkR7zDUX/sgKZWO3p0VI/vM
 04lPdAZqVBgWSLesCcb7l3TWR8FdizTspSRm8gOwwu7yesaGC3nQ47MQkByJYtJHbOkxVVB3PbT
 X5oaecQ36wnd3TVSCS+i6DoN2Cet7I+3JaVpy1329g7oIAd3xgRxg=
X-Received: by 2002:a05:7301:19ad:b0:30c:5254:788b with SMTP id
 5a478bee46e88-30ee12c792amr3272473eec.10.1782833848422; 
 Tue, 30 Jun 2026 08:37:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 2/8] ip_frag: discard datagrams with overlapping fragments
Date: Tue, 30 Jun 2026 08:36:14 -0700
Message-ID: <20260630153723.525167-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153723.525167-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
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

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

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

