Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297FC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A415D410EE;
	Fri, 21 Aug 2026 21:31:43 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id C39EF410F1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:40 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so1411523a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340700;
 x=1787945500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5ugwEKJwCsgPdKtnlofRRbf+C5Ww5IwMnkDYg0hEZo=;
 b=IpFjej8Zo6Kxedakzc/kkH3m3teoBUD/Ol6myI562fTbIOolA1Zu9x3Ib78f3Lh7Nr
 p/fEjhK3s+EYKLFYpWXYbUVBl6RhDqhNbAhpUMkdMsXHR/OmK9HbvICmIGHNcmFSic6i
 5J8qmVfMN0z54Rw+4Q3CDUQ/kpnuBExtOom365pHclxpPPEYuaCEfpshPbGIwguHdmUX
 dSiNma3frjpABGqbpT14CELb/oJotv/4zx8ikBskHR/dW2cZosqGwMdivGPiqVEZfDvy
 JI56p0asv+BIg84QTDxebT7mPkPnwvxlHO5sE/JnEJMEP0aTE80qFD4AttMBhzz3TSEb
 dTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340700; x=1787945500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5ugwEKJwCsgPdKtnlofRRbf+C5Ww5IwMnkDYg0hEZo=;
 b=Va1PhrtQ3b4xfypGgYR/VKJu4uLi8Gs6gNMkuR3RB7ZrqDUGpN5/1+AMHhjj2D4YXv
 MD16cmzRp13H91kLFAYwPVEzKtzFtHmQVTrQ+hhzVbMnZsBaM3Pf0xOy4K09Bzz8lXMO
 7G4uaFqabh0Z2E2Z1zgLhxlLCFRcQ+ntC6h3DxgwZd+W3PtTHx0aoXm6wKLfXn+VFfab
 xS9FbzWmQqXILcctOTgloG0hjN+tuCMka3gplwx9ZRpy/YzQ8eotKAahrvvTPPXc5kt8
 qZPQ/4Li+WNU/kvRSS1JYOR23rKWTNnQcabailG+IO9ZJAoNouxaNydDm91E+3zpQrgB
 GnpA==
X-Gm-Message-State: AFuF++mb4gYcsrrU+ZELJ0kKQqfDbgJJo264ZcAKNqJvpXCM67AVZS0z
 DcZUVvQYCQkzLknHNPbep+LLVTDq2/6LoA4Ec35alVfFJcZH5fZd5g3Y5NjsQj5XJriEv9STqDD
 yMD8en44=
X-Gm-Gg: AR+sD10IkzevZ2a62SOUI/A7jWmiPRU/Q507uqy0tS57W9f3hooxZY5SCJgMxJumKYS
 BknYVDVpdz/mug32UZDqvwH8/yJeKkbKfvJRzCoz3rg3yEwPWllUEMSXmsJWdJij6iCrYLAGA14
 VzhARiKgMJvzN9bnVmE8zfjbiuXTd/m1AWzZl1+06cipMOlPueDdbDQH6hDBuFN6m6QKSLbJ03X
 ZMYcaUA5n71/1pawNrD/7EIKjQLvPRw3STtWzXVkaFiiDSWyC9C5O++RMo1PmW/diBXgI0mzWk3
 tdUmJC3ab5j89iUGRUAE5gEmaEAZ2YTBVbOO2WptYc/eXy2E7b3niJrV2g5U4HDDZKNHXd6cryF
 JOdlYqN+V/0QE1fj5vKXtQLDkH26JRAhI3NbGaJ29LSZbDc0DpQdqpdKrS1G+WEuX0hCICpwIQk
 U2l/O/0knHSnaBGOa3FAyqXP8PrgEG/18VMyvJA7C2Egk9b4VkUji4qkKDlurBljw9YSOBZTt5w
 mYU7fx7YgOovQYuawEDmlFroHnTvpPcn89zJw==
X-Received: by 2002:a05:6a21:9188:b0:3c3:875d:c546 with SMTP id
 adf61e73a8af0-3cd4ba48366mr2082768637.7.1787340699955; 
 Fri, 21 Aug 2026 12:31:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 63/68] rib: remove rte_memcpy include
Date: Fri, 21 Aug 2026 12:24:58 -0700
Message-ID: <20260821192646.146382-64-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The rte_memcpy function is no longer used in this library.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/rib/rte_rib6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index e3fb464ae6..2e554579d1 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -14,7 +14,6 @@
  * Level compressed tree implementation for IPv6 Longest Prefix Match
  */
 
-#include <rte_memcpy.h>
 #include <rte_ip6.h>
 
 #ifdef __cplusplus
-- 
2.53.0

