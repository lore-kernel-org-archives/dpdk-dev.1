Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB40E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7FF740664;
	Tue, 23 Dec 2025 19:14:36 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 40C5D402D8
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:33 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8052725de4so386906166b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513673;
 x=1767118473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=a0p7SCeCAYFB+e7Buls0zOPad0L7g2luxO9z0zghfpNFFtKjnSErbEN1hHm5aXFrN0
 ZtQRljLxDhvvFs/FAVXKMqGTjxxrlZwz8zcGOyHvXXE218r22T/hHF+zb8qbvPykYwxi
 qOlmwb0sq0JbZAX/ijzav/FIcrqWabAt5YhDML2ftcrcjTqEiN1ruaEPjIakJOYoezHc
 HKGaKU2LLTM+fCIdwV05tmah2CE0C+3rBdTshFWtqYSQPooBliJWoJJwODM2RO+xP9nc
 9hGrzPdVFnxFDYuPeLEM9AP2juFkVRutcx1oN9idwpXJ38MSb40/FYFjzJ6rjxJZb2uk
 5HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513673; x=1767118473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=E7lnNwYNWjzKK1SLRIWALSWXDtWKDD5oh8XtrKWRkB+ZmEkrJzZyKM+IbYNbPRq/sq
 dHLnsbh6bucPeki0+Vh34IuLmKvCZ5QfehJ2n2MnJuiic7IkOAYbcavzTGmbHsFpkWUy
 bxX/JKSiwGp9wdhdMvydQqqrLhpZvfuP9jpMOr5wuadyE5uMLsJDe0v7t2FVNuCRSKFi
 eZRwkSK4pyYLv4QKjpxe2p6dvL224NHdJ5HUwntWGpoX3HlZOCurSkladhb04qJlIt/A
 qIkCGGO/dUd5ynYgQl9hv9Wah2c3DBwxvnFURTYXSRef+XkJ1fsnb8gQz+82w4ilbciN
 /6CA==
X-Gm-Message-State: AOJu0YycuG2Fh9kp8ZU+kLjhXyV8aFidRFF/WqG8bWrMfMU2cBZqW8jr
 Svyow0A+xN7UCN1dPGomnQ7RhDk4HxCJtE3oi3ppw5Y6wxAxAzo98/gXNi/sTNcHOWJypHl9lfv
 Q8zdTEiY=
X-Gm-Gg: AY/fxX6kisq6PCLeH3eHH+r1ggkmaa1OyRegVDgzUZgciujfnva0SG9ER9pN4r3eCVL
 FcZPHYwNLdTARjoQYOapbim6xIh1O9nIFDXhghYoZ8PNgMFAT7Bg4cy6MB1dupBiU5s6I+i0c/Y
 6r9fVDIKBO8EwWZ1/4mfW2OyCLxqtBHCmWhbDgCTlZxGr9FoFaCtMCWMY8vjFuZ1cNSyN1KZ9B2
 R0TIFMAYjUBcr/aoWNro6qaYEWL7GYHPd2yT3hCry/C6dR8NOwg8JX3lPRTY85WSFLIEsmvxs5W
 nqjXKS/LTommrib37efXSBHPmLnE7p2d0+opSgXHoLHlkrh4mWo5tq1918siZFs97ZIzjuAEZzw
 62W5z0nujdeF8exGBPH5GGgYE5Nrs73GVSRxzTHg7jwqjIWYP0ctMuG71yqKuophnqRRGnmeMRY
 8iWgZ5zDVcbIju+Ik0HU4Yob123eJ9RtzkTCcvAD5ZfqvLl7dwFQ==
X-Google-Smtp-Source: AGHT+IHFNIeIya9/V+YH2JlXn7Hu9165lOKBmO3jkboX++6m2b8puyxGhgZ/j4oqW5nJts79cWrrEA==
X-Received: by 2002:a17:906:8461:b0:b7f:ea5d:322f with SMTP id
 a640c23a62f3a-b80371802fcmr1082849266b.47.1766513672700; 
 Tue, 23 Dec 2025 10:14:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 06/18] efd: handle possible name truncation
Date: Tue, 23 Dec 2025 10:13:04 -0800
Message-ID: <20251223181418.40834-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

