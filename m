Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A81CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA92402E3;
	Mon, 18 Aug 2025 18:18:26 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id E1A8C402D0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:24 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-45a1b0b2d21so20695415e9.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533904;
 x=1756138704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxMf90lor+ibyGM6aaZug/8jG+4lAN4qyjPXhLBV6eE=;
 b=0XN8CaYfWHtC7dNCvK2ixPnMN5WaQ0XrDfR4Wk+TjKaRD29GEzV/QOzV1ZdXlWb9VJ
 P8Mmmw4d4MRxurUKWw3nNzQ1noAlxtlY6iUA3f8yRlWwkquFoLgUeRjoRplUSdtJeFmY
 kPqrKIHT6IrmW/S7JoKjiWJtPbuoJxc4sZfAidGvRLRd50jEgGU+KbFYrJJ+G6MB7d6F
 iL/7Rpi4W3/e/257n0mdhRjX31adyz2tlxO5EUeLkZ5opzRa94PEkjgOrwui9SGvmFcy
 JF6O2b0dwAKO6IFZWzU5zNXeaptDhLNmi0il0CEOFFFZDwMPnQRjhr9Az9Ku2sZu4lHB
 KIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533904; x=1756138704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxMf90lor+ibyGM6aaZug/8jG+4lAN4qyjPXhLBV6eE=;
 b=MguNPSeySJL0m4LgrLT1R/DmbC3rZrdsw1xcOTubi2NzNVUEwFp9J2jNgcMJkc5ew7
 BZW8Xayr810pjvDn18+y1idTKztopjRK1005KXG2B3EnFEe0ClG8wf4opvBKzHkDIHVM
 bWLwb6FYob5/CWLDq1vk+WZmEqj+q0NpVncS9o4fI+3RCGsF3xsTSMwEPYjAliE0Z3YA
 rtEC/+gha6JZpZpXPpBON5MUxBfWYoN/ZNZl8xjbbQkf+2dHcc564bI9BqneR1BoO9RW
 72vsUGzupAO64qYtljHC0MjPUmE/VypJX3czrn7lz9p1Bwg5Kg9Pocq96Sjm3w49hZGs
 h8EA==
X-Gm-Message-State: AOJu0Yzr5wMhPzWezUTJ8BY6QvDfxy+NI4cj+kOOxl0Taw9Sc7y0Uv91
 jERcpM3LFuKm3O3oRg0lI5vbvnAgvob7N0fpcnB5UCSZa7tYCF9khpUgo/ls09bAy9m/0o/XIBQ
 HRKJS
X-Gm-Gg: ASbGncvUts+lMBFKzSOs225+pEJ9o80demFNCy9j6tLXyI0dYOQmv3w6evTjgOLe8+a
 QnSN6bOLw08V3oia7nZCkCsO6xaanDXs7Wb0/9sUWrKYclN7/I5/4Qbb9pGsyAOINl3llFR4noi
 YPJeSzL4SGz0R+JR7S+crGTulwRGYj8W/tKODAdWWHr+LnM7SHyEMPMdNZvnYKk5s9pz3Deqzbe
 E+BOHmPbKbDZOUNhDMmKA36E3V6G4WXyUvIOnPeEYVXA3JGT8I2jA2OcjXBuqVtoBW3h793FIbU
 ai/VvkURsBlEYdGau74EscHNgHqVdc/Q15r7Wg667Ci+F03cvuqhBBntwU9m9xajYxpdfih6f1s
 G4h3m1aSF+0bpLzPUQ3DvXy7cuJAMyB9h8hXm9eovEuqlCHK26I37IInl29xuuXanfH/Z6AO4
X-Google-Smtp-Source: AGHT+IG2LjbSd5pF9lWqaPr/9qxqBpPn8AlV1AgURPrcjhdlxIN7RdG/0g7u6K4BXNtDJdNEmeJMww==
X-Received: by 2002:a05:600c:19d3:b0:458:c002:6888 with SMTP id
 5b1f17b1804b1-45a218637a8mr88057065e9.32.1755533904207; 
 Mon, 18 Aug 2025 09:18:24 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v4 1/9] eal: replace unnecessary comma operator
Date: Mon, 18 Aug 2025 09:18:06 -0700
Message-ID: <20250818161815.23611-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/rte_malloc.c | 4 ++--
 lib/eal/linux/eal_alarm.c   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3a86c19490..388e5a63b6 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -202,8 +202,8 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	}
 
 	user_size = size;
-
-	size = RTE_CACHE_LINE_ROUNDUP(size), align = RTE_CACHE_LINE_ROUNDUP(align);
+	size = RTE_CACHE_LINE_ROUNDUP(size);
+	align = RTE_CACHE_LINE_ROUNDUP(align);
 
 	/* check requested socket id and alignment matches first, and if ok,
 	 * see if we can resize block
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index eb6a21d4f0..a1433eb867 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -125,8 +125,10 @@ eal_alarm_callback(void *arg __rte_unused)
 		atime.it_value.tv_sec = ap->time.tv_sec;
 		atime.it_value.tv_nsec = ap->time.tv_usec * NS_PER_US;
 		/* perform borrow for subtraction if necessary */
-		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US))
-			atime.it_value.tv_sec--, atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US)) {
+			atime.it_value.tv_sec--;
+			atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		}
 
 		atime.it_value.tv_sec -= now.tv_sec;
 		atime.it_value.tv_nsec -= now.tv_nsec;
-- 
2.47.2

