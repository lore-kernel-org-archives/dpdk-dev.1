Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB359D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13ED640685;
	Thu, 29 Jan 2026 02:43:33 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 74F2740695
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:31 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so9649835e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651011;
 x=1770255811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=Os5CvokxL8+7N92rRToM58wvJSbvPob0yX/zqjzwTKATJjiQKZUNVu0C1p6WhEh3y1
 P8p3Ds9sCqzU9+jwAjJmOdSBRqs6J3bR2jOnYkQpenI6eNGStQ+W2wUtzVaAVBVnMuPH
 XJqDvjBSPJCxhN3FVxfb1JSS7lmzCI0zBJi4dpYUICF8g1stuML9A5xoQndTUFA6SLfO
 t+4/d+u5qs4QpGJluYizoREs+Xk7dTLSTkd1hTF2flOr1ttqQJ55LcYdFXVKHZSTdwVI
 VRfG+Tyq/aaDdTn80FEKe2KvLTOM3tg3Tg/du/SY60pwSPXJuPVE6eCZ6ZBwY3ufSfEZ
 mvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651011; x=1770255811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=ahUFwt2Tb2Q2vTJPMF9EzcL9VX4WPiedcDpkl0LHK5DndvLylgyVnH8u6WxOwzGcx5
 VssvnYpAKbLxbvNig7/jCSPPxUwH1E6EOCKMwc/3aIAbs5VRL+0a19A6uzhmkBG1FXPL
 w7F77dhvf9Xo0i6GmmERXRtAr1WxImLtGklZ8XyKjqfdGAN8cFLYfmo53znj7q9PbmBE
 uR2QnWFki9HoA39ER09VY47/rVlKlT8tvGIfbaSsp7lHUSq8v1lgVck5djOy9azLy1qg
 7fhSf8FRlrseo3zll/J3wT5DD0VxdFBqLBQAXNJ7VhtYZfCHro+Eo4p9Ag94750VSDXB
 3kRQ==
X-Gm-Message-State: AOJu0YzJ6GO7fUah8oqfNonFJubCoNP9RV8vxFmiFUK0Vx4dJVOz6U2l
 38CNIVBxn5qKTAmeZjzjPH8HytsNYSL+q2wO4rFx0iL3mOpTkXvVMnmC79dr75ZN/mmP3mCxRei
 e77gz
X-Gm-Gg: AZuq6aIKyVxL+pr3n7SiSyjv84948V+5GsllAkiXr2hVpDO+7lR/IGB4kuANPMcaefu
 eYNM87IJ47xZ+B34d01AA512ve8TZjafu/FgcspqCu3E/uIoPXy7wq0yC6BeMBQUslgvc56xvt0
 wLXsmd0ZmIUefBRCrf3+nQkUQKU4Tt2DIl5pNUEOeNK4Casn8diDLnfLPvlDqMOzqW3jkPBoDJq
 Jwx+vHPyr4RmKS5g9dMlWyxXf0x8mjzmI9uMnTERhIkaCbYLEXvjSAb9LMOHwlzR5K1DJKck+8u
 0BbpzZQQ3Zum+qhnR89sWEJEY2S7DgWBfa/OYZWgBnC0rhUoo6tmFJno3u4VrIWc3rOfG9T7mo+
 uVBsz2I4CHAu1nH2DvzyyhnarA4wiGsLX8pBnCyz/dPghjVd0AFFvtsyGR+mKNwtHHrYJAPnn+p
 kFqfZ56LDoTUmgThFvM6JLCTkcP3T9P1KS4NJPhQc9HpTuEvfP/A==
X-Received: by 2002:a05:600c:3505:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-4808289f9damr18771915e9.5.1769651011008; 
 Wed, 28 Jan 2026 17:43:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v14 06/17] efd: handle possible name truncation
Date: Wed, 28 Jan 2026 17:41:09 -0800
Message-ID: <20260129014313.939831-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

If the conversion of efd name to ring name gets truncated, then
log it. And if the ring name than causes collision, make sure
that log message includes error reason.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 lib/efd/rte_efd.c                      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b966ce7b49..91b1808455 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -92,7 +92,7 @@ API Changes
 
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
-
+  * efd: name must be less than RTE_EFD_NAMESIZE.
 
 
 ABI Changes
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..bbd565f404 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -517,13 +517,20 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 
 	if (online_cpu_socket_bitmask == 0) {
-		EFD_LOG(ERR, "At least one CPU socket must be enabled "
-				"in the bitmask");
+		EFD_LOG(ERR, "At least one CPU socket must be enabled in the bitmask");
+		rte_errno = EINVAL;
 		return NULL;
 	}
 
 	if (max_num_rules == 0) {
 		EFD_LOG(ERR, "Max num rules must be higher than 0");
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (strlen(name) >= RTE_EFD_NAMESIZE) {
+		EFD_LOG(ERR, "Name is too long");
+		rte_errno = ENAMETOOLONG;
 		return NULL;
 	}
 
@@ -698,12 +705,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name)
+	    >= (int)sizeof(ring_name))
+		EFD_LOG(NOTICE, "EFD ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
 	if (r == NULL) {
-		EFD_LOG(ERR, "memory allocation failed");
+		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
 		return NULL;
 	}
-- 
2.51.0

