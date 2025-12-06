Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22747D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74BEF4064C;
	Sat,  6 Dec 2025 19:44:29 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 41BEA4042C
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:28 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42e2ce8681eso2255843f8f.0
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046668;
 x=1765651468; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=hvg0KEg+76kmElKKgPnKI7QvNsL0qPf+1nHcKLvRYkRpP2c0CHVHd6OtdLNUEhAL3k
 plMUElp0m4SpzFQJLhoqXb8QRMkolpcwQ7NOBbx4zOsuJHlzmfWIUr3iVi5JvIp//0xC
 LraVKSZ79Y80RYKuZpTcW8vwl6lWuln4KwmHJP1cHy/sQu0IhKkiY7X7aSaFr9eTlfFX
 5m/6NuL/ZGIy14kUCNq+x1s58rZoKi6dhmLsuw8BKi6gwbQjMBdL/+JJXBlyXRlr4/TI
 aeEgeV85RLDAYIaI6G074i1hR3+QmWKo5HDQfaRLeS4f1WWKk+rVyFzBxO0UlVthwq2I
 08HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046668; x=1765651468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=lmszTnF5cemtGsl9MDOL1cOtpUMfewmT1TkwKOaN0T4ZBzjQJK6hSWszt6M5/CdaiA
 oEf04TVBAtp0jPUoDMKMRnNVOOM03F4LyWO1G81CTg8/lg0Nl+arMaHXnU7pNtLuJLAB
 tBGBVo8ntju6Hi+ZRJcblx+LhBogNE7EJm0iNQMTGybRhkqZbHRxTtSUHI6E29ZT+JJG
 R4XNMl7rNgUpzMZ1/sQ/R4rck42x5bAi2DyyUdQ7IvfqXKoI57Ae19sdXKwmmDrwKYWj
 j0VMyuCsfK+etViOb3Jzu+4WBwdF//zoGV8B09vPRJyL9c9Ho1gh5BRCPjfoETjy/Skl
 pv7w==
X-Gm-Message-State: AOJu0YztBMZAu+6wG531x5Va9FBPSizmzrfoVL7eulQoZp/qTZjJy0hS
 u2aM1+f/OPe20eWPnPD0oCEiJ5W/Mr+zdIhQby4Hmy/Mk1qYraonSQ87tl0PhOFmjXlUcUv2cmF
 jtDgw
X-Gm-Gg: ASbGncsDh6bOhiF3iCWLX/G/x4j4WdXIfL5a4fsJxvQLGiS58cOMMMDudU8y1v3r5OV
 pSrP97CuYAGDprkORXYeGWjRlLaQNWk+ftw2AMUP2nN013+tTMZYqH7Sg/jT5Z3Fa7gFpzs19el
 vvKeqhZj4fDF/zgO9kyab7Xwwn7F0wZPa9ji0TmmQKGTD0eLk3c7Py9qvubbhV/+lOvBrBSg7vL
 BZ/SPwFYMw6hXuKvnGSh49hHkX+zgMPs8R27p+pVh3M7lv5RW6QYPJ6SUQaaCwkl34aYQZevrkT
 yKvCN0F4imutlM/imP+NhxYSKUj06fgs4LyxCmRAr5ijJkgS3yDr4UoChBHlUziQ0SxHxaDlFsG
 ZYnUGSe9mJGMMg3PYmE2iDytLWvWAXXnxopYPf+hmnApNMdBE59VuGmASfV4ac4+cGWVJa/qPiF
 T8LhNJLz8aaxdl2h+VOo/6wmBv4UgRPFczMTgUvyoIPHFUjsptsQ==
X-Google-Smtp-Source: AGHT+IEpT7hNnnprhPB4kpGVZeaY8VQCkREdZatPYCR2adKhxbMXvAvPlOou++aBvg9zs2EW1Ivfwg==
X-Received: by 2002:a05:6000:25c6:b0:42b:40df:2336 with SMTP id
 ffacd0b85a97d-42f89f4846bmr3586953f8f.39.1765046667722; 
 Sat, 06 Dec 2025 10:44:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v4 06/16] efd: handle possible name truncation
Date: Sat,  6 Dec 2025 10:43:07 -0800
Message-ID: <20251206184410.542725-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

