Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC6E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5E0F4066B;
	Wed, 24 Dec 2025 23:13:26 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 0378E40663
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:26 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477632d9326so38177505e9.1
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614405;
 x=1767219205; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=H99ZkriLaz6O4wFpXar85S9iNSmJxHVfto/hDWonebgIFlW+b2gXrJxhpzIoyv++aX
 1WB4DIUFqIGBp9g/PpWwfb8DEvng6IR0pdoxlNbI5GeEr1DbDonUGjCpe4FsCrhbbUvB
 eFjh6ZEx7OvoLMW7TrEjiYsAVDhMC2XqDy1QxZtiFn8D1OThUEAUVnhm071/QbPqZFWp
 7jFs57RAwrR/Q0aC2EqxN4nwbl89pWf+9tmNXZ9YohSi56OYL77PbxuuzJDvE/nk9X2p
 69T3jl5PwNvqKHDLIEAGbLmfZ4Y7PwTXr/5xPr/nC3Y68Jnz4Wvga+u6p6bIFB5gxwgi
 7TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614405; x=1767219205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=oiXLLYsF+RS2n0sNs+ND+IOqDji/PyIlpyPJYUMRMJczWEmSvTKZGDCOTr8N5ramGV
 11S5eZC3hIiJ/aixSSwOaxe0iWPRwQoHDOaMqAROap4bg8g4DzvE/yeIgktHO6sTm6uy
 mn3n6N/o0A370d2b8VcUsDBWKw9gsjtgyYn5gbKNgImd9BFsAqNplZcQr6v7FQcg0CzA
 g7Lt2sx65oe3wam/XVbsRfi7fTABIrslGX9WtI6Eb34ihzkXAXFPP+VNLbAM7rIV7vKa
 s1jtjfJYqECg0nGsi8a1ygZexF2G9x1oJkKH6kLRgdcBCue9UwO/uwWOB1E8ohUs3Z/q
 n3Ag==
X-Gm-Message-State: AOJu0YzMxxaWDmtIm6kkQCzJchKjtmY2ggQVqG9C0Xy/8HLqTPMSAnQF
 1GE5YL/MZXvx0I7gkbH8JkwcL8Ta1AZF2BC7PBUye3siE1adQs7CWPt4/kGJXuQqk8Czt6YLvLV
 RIjmHMdY=
X-Gm-Gg: AY/fxX7Zfmz1RNPuE+CdaStLVFxX6Iz7JbKYHbb/Crnej44FvIMfrp7J4dejQNOfl0A
 /6S7466k7G3y7rdtZ7BKdJQoMyweGM21A2hg6HWtTfOaliY4VgOP9P+pwsVYwLQSrGtNTd/OUZM
 OBY+DjD7ArqUpiq48yncVpG8dbKKHNk1E/B5MlFbUYjSe0vCAhJi3IrD+edGR94uIGXoLY6id5r
 AASr/befZLYnGYfeAOmSuXqMMrNFFrBOKxFzP5WoNwx9Vxgw5sOoB6w5EtZmv46OeXilcg8ceYQ
 jmO1yC2dXTXtlrLJQ9+vwHEabBG3fgVJZD3gWoB7UlpYLfZ2ic9r6dq9MRVbx9UXUiXq/rThT5l
 J86xQIC6uKEI99+UGj+6gHHwUlv65cwdjhyjPabf3to7L8OZHbSIxRJDCmSDAUUQ+ozecMZw7QA
 q5JJbAc0P86ofdRMDxX1OkfB2A7yDLhaAwFyX/hOX1GWIf1Z7tOg==
X-Google-Smtp-Source: AGHT+IE782mrBFzrv9o1c64tHIoRGHfJmqcEEpcmEMMM5tSqrRpk+Ohr54WLMs8cW+rV2DaMKgayHQ==
X-Received: by 2002:a05:600c:4711:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d1959fadbmr188855575e9.29.1766614405612; 
 Wed, 24 Dec 2025 14:13:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v7 06/18] efd: handle possible name truncation
Date: Wed, 24 Dec 2025 14:11:47 -0800
Message-ID: <20251224221301.52714-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

