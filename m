Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE58D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3ED74065C;
	Sun,  7 Dec 2025 20:13:03 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 1AC2E4065E
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:02 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so31005805e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134782;
 x=1765739582; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=aAuwKlwzWVN8xQ9suuDQe2RNnFAgHMplyUcW+Ae6eR9+PwmSikrE65eKiAEpsdtIrt
 RGhWoDGlWWa+lyl3yh9Oft/A+TkmMl5o83OvX6HFKCigzjm2+WVZtCk+2TWUiBamyaq7
 b6fKR8upaA81361dE6Kv6abXKp31L2gii7Ua8d+89Z29FrspXCRiOiFv2MZ5J85bfwPj
 7UXPMld9nY88974728vtjvj1PZcOhstKl+pFJNYN8kYp+x5/0Ia7lquqQzwtZs5/P7mR
 7E+Cz8SU2jihW1SW7HBe4WZFLL/LjQWUM1juKVABCFGaO+/4N+R1vldf5aBrdkypibzR
 AjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134782; x=1765739582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=fTTsxOU85g1eSk1o06/fMjiGPOBVXPvDQcZlXA+dSKvO04pSUiLpu8ffPcWiFb64HI
 EGmzvLaiKlkJQRJrhwd7ok68fLR4sMedjXOTNpO0+JpHC1s6hBkWb8YdksdAaay8d6RC
 0taMbiMzHkm5Cv8Ap4PpeXL9DDKvwDztppIO6GEFmGRKTsJZcDldl49aQurYpXR6aghP
 wwwMctIN7LpGknc0NOkG3SSoTaHSdQouWbAv1Hyb9z153kiqyRKKmILXneh/8Mp8FATP
 494uTAphnrmTg8M0a0GWG4dScJECtAX06ZXf1aSybdd82DWrNxW84GCU+2S03S5MP2nW
 4Nyw==
X-Gm-Message-State: AOJu0Yx+bctLthmuVPj6Q99Qfmfo8O8SwxQ2f/Ixda867O8WuUqId9zl
 yxofhcLeqhJrsJdEi9JXXuflTof9E14KlnxGt/ty3s8D921VWqAe1+NNQbPpqf2KV0V1bUtSRQ/
 SNzSm
X-Gm-Gg: ASbGnct3qPpCrZXIu+6kMo4T1qmYz7I+AM/DLjZ3AtNIm4IFTovog4dhvUFsu5tMDd2
 IecUXnTqHyiY5KCKgEGkuQwE5lImMVEQg5xaaPw0mWUR9oIp8W6ASG6EpxaQXeb6qyC5iEIXwKz
 OWO7yFJkOoXz5zuW6POgT0ga87vkZavgIjI0y8DcNb6WqhH/7L55xdApEXeJj2hCRl4xBvlvYhg
 bDXYxXIkICtk4o7QnbwWsEaXK8YKYzn9yT+lwIUbLjakLAw63SogHtkdxReGa26oTM+fbjQYh7w
 /cP4A1SmJlgIN/gDxW6NtKX9IMV3hIvDPNoi+7ssK8B6U4CdJmfE0ZgIo5jmFIUTsZyqJZMBhDu
 0vbJz2RTEfsQOsv0I0zdai8LFszPlg3FYPy9nntl+suGTZvdbjDnE+CL+iF5KUsLOBfVLAG/2eU
 jGRqCAkSUG42Rss5LfVyyVrlUXay5EUf1ypJ+CQO0gu5j4/erjtA==
X-Google-Smtp-Source: AGHT+IE95X/B4BbqKmJ53UDwmUOJhtYBlWFU3Dquj2/dpVKi0ueEXyIsK5GbwnOUU2q5iaMyHMmU1g==
X-Received: by 2002:a05:600c:8488:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47939e3d210mr53774625e9.32.1765134781625; 
 Sun, 07 Dec 2025 11:13:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v5 07/17] efd: handle possible name truncation
Date: Sun,  7 Dec 2025 11:11:58 -0800
Message-ID: <20251207191242.165619-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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
 lib/efd/rte_efd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..ed2c509938 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -698,12 +698,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
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

