Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202EACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA9940395;
	Fri, 15 Aug 2025 18:26:39 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id DA4D6402E9
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:37 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so1100546f8f.3
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275197;
 x=1755879997; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUVmFPB5VRlpBeCm7VNiIoSMIFnXwSnR2zTznRUSIy8=;
 b=ALlOxCPoRrxvIVPhaJQ4n9xT60jYFujvRco6OkejuNxpvr4fWM51dRZLKFvPbwq9Tt
 bycka6Lu9cAfHolkLyd4axoQ7UzXG82f29kQljLkjKqZNOoYsAb7ZuOD8jjNOX4mkadC
 gVmZDoz5H9NqPFoXdX7XCrwd8Md6eNG8MBXq1W0lagKHv/gmpHryDDIm26PBz5fJ971H
 sTmM3m8feHdhIwjSCgWw7QQCnHTLyr45iaMSYvIQi1oZNtYaQzBb7/6BXFujkvJnEHyh
 JkJMSrzaZ2EaNBPlnXaECs2JBCz5D/MWGFHiHPN9THLxR0hBW42O/cqldeetSd+1y0vz
 O3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275197; x=1755879997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUVmFPB5VRlpBeCm7VNiIoSMIFnXwSnR2zTznRUSIy8=;
 b=kBzveddho0MbFYEYUly4+JZl6PPmwkNqCUkOcyPMqS0w0rr5sHhriQOn/GCcYH4/D5
 qaYw0CONgVG5ndCT8Km0QAljl3Y6hwsujobnQklkYOd43Y7UJXvC1eom523gKaJzWtk9
 Otrh8gLehkNPLXgZ21u4o4S2bnJTSEYr8iKvAxdfjQPL3qYZi6or604lj2E99fIeKzCZ
 6ovFgIhGMdyMwQmiTXC+/fkYMPduW5DkDl0oeHhF1CljnmTOC456h1m9VdF/r6mp1JLt
 H34fSf2Jd6EfzcvcaN/FfPkksmLSHQi8+5AVaXa+0qMDQOLVGbOtNzSM7Wa7BXj25HVM
 vmgA==
X-Gm-Message-State: AOJu0YzP6YvDgOItmKCAfafgzS0zN1Nxq3eydz2npZIrdAMa33czLs0e
 fWbUPtZRBRDbU2hIQkvtItElkrkuZnw1Fpkv89V04eTlNi2J7htdMRx5ngOdjhvBnuR5QwwxAb6
 o9NkK
X-Gm-Gg: ASbGnctbPNIAIuAHNrFhcxwSyBmudMhbl9bH+v8mrGVJUpVN+JVJ2nkr8XVwJig2Aj9
 yRsjP72L5UNHDmee7yWy+KohEvD+YQn88jW7jjFvRoZUk68rvWKip8NwBQXt0JmBCJASvYoTlbm
 m5PtGCNZUfkANoe+m3LmXCBwsa1nZMyUMcSupFEFqtmCFJ1ERJQTJlNp9k/TA8AQHrEWnEVspPu
 N98e8h7fLXjnkcLwQecYhQQvvdwJM9J1NxwjmPYowcMibIr00F48eaWqTu+M3FVj7wejdOqI5ht
 msjxV4FL/U1CzZQoH5g9Axb1dp8TAF15Baolr8Y+ntpsYL5sI+xvvFiGUrDsWciiz/vSwWo+G9D
 Vqcrg9knF4XTLczZ5VPqlXLnOpSvCj635yADUiyRWVqoaefc1t90gDWjkQHami0XR94S4046H
X-Google-Smtp-Source: AGHT+IFhVsGkm33R5YCMtvtMQ05RNgGNQB0h9J1Uh/sTe8TCQopCJmj206pM0Fy1XUIyWP7TFomG5g==
X-Received: by 2002:a05:6000:2012:b0:3b8:d16a:a4b1 with SMTP id
 ffacd0b85a97d-3bb6969a801mr1993072f8f.58.1755275197391; 
 Fri, 15 Aug 2025 09:26:37 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 1/7] eal: replace unnecessary comma operator
Date: Fri, 15 Aug 2025 09:26:17 -0700
Message-ID: <20250815162629.161782-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
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

