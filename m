Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A4C5DF97
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4815B40A89;
	Fri, 21 Aug 2026 21:28:42 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8E2A1406B6
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:40 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso1313662b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340520;
 x=1787945320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uI8PmimZGxw2wNA/g1huhW0zP0b2UE5DalbWUB4CMGk=;
 b=iQW2isz5ijjZwXLMX9APkdu6rRaz4yBvbZ+WG3kOkrlsvZ/lGit61sFNFzDJ5WHtC4
 xgY5kXOVPMElei8KyB/rV3pu7jHUeRc97vShYvD/U7DV3tIF25HUEnU+ZVUe0gOUveSL
 XNpscTpgxF3ncw1wEUFpPbmdty+0wat8WWfkPWuoK4mMLgtarQAoKoZ8epRCzySxHy4x
 dRDNDWqaTEwaTzGHZJr9b0Jqroz2G/qhSNVPbaYAogJfh8LO0KYOOWULi6h7/qzxLmZZ
 4Fp/CKD3v08YXY1doQbEUWef3KXuhDh/O7QoDyg+85jVrcFU3vgqofZM91DNQAD41E9T
 YmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340520; x=1787945320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uI8PmimZGxw2wNA/g1huhW0zP0b2UE5DalbWUB4CMGk=;
 b=tH1TkxVNohUm61peW0wWyZUtuTE7Nty90Tr60bVEcmgbRam3yUyEvMN531yTIXfziY
 czKaU0lkMtDQzakLsMCEbmXc05789wohtf3ho7mOy/ecbKQUnbBLxx6fnCNxO44k26g6
 5oQ/v+5vUtHWJAVWkDmcc2M8Kf306tqp2vTJX7cozL5sgn97tUa/EVIqRdJKWJMfWYuS
 xH3Uy4KNESmjtz7NS3qV9Ab8kD4StouVXepEk2u8IkCgqnQmbTkOPayHpr/4O15vhXG1
 G9pXfKu+8B59pvDmM1+Gbfzlcykz48k07Lim7Nu4YAcXnor2wbih1yNgjo+21Bx+Jy/e
 WwlQ==
X-Gm-Message-State: AFuF++minHuxds42XL25CtlBj02tHC0exYtiXsgfuZnicKkKuY0agwZ8
 +n6E86tZWf6CRjreTfwxBj/P8Fx7qsZRuFiiyRz0MQtsDAoDFtuFAGqWeeAwZYt8WLOK3/YRuCo
 rwY6L
X-Gm-Gg: AR+sD111+CGp9G9Pdvtjli+ip9Jl7Pu6TfcTtlwUxDdU2lo1MkAbDbNccZXLFfmd6pe
 KZ4Z9pykp+ZKC4mNFMlBTqVM8V7CYP13YRyUXPp7g0KbPx5zCWFyegyljUMxpGjuEz70ZTGtc87
 x6bvAr+7+5MdBXYt4qKXC1b9bO3h+SGBLAlK42qKVFpZQfaQmpuUtwLVz249okViSbq02xUYg37
 p/WJhUh9yZN/bwZDEqZd+YM/Jt2kI5BNAIgwYBFqaKBi7kCO44BEPh+C1LFd8agkewWYaMJbYlp
 ZkWDvLc9D8bcwyCgYjTq0bcd7Z5M5ye47878JVLjfAu3zW7k0w7Ss8rO8eTm7RictgqyHdSeCJC
 aQmL0vAjtovdxgK4Qt1zNNs/8rRxl5Jqjf2TYN7MMiOLCrjjl0N6a6ht2qOJbpnk+RjkxztR/pW
 VZiGvWnLXRa8d7Mwh+YdmeWzxNJ5L2AFLmJrdoxQbevC3lTIzWFy+OFY6k0+4foaUuqbjKJIJ9G
 FIwuUbRnoitFMo8cCeZRrH+ndM=
X-Received: by 2002:a05:6a20:4320:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3cd4ba0a414mr1766687637.6.1787340519777; 
 Fri, 21 Aug 2026 12:28:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 12/68] lpm: remove unnecessary include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:07 -0700
Message-ID: <20260821192646.146382-13-stephen@networkplumber.org>
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

No longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..c3fb795c59 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -12,7 +12,6 @@
 #include <rte_log.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_eal_memconfig.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
-- 
2.53.0

