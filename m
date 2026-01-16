Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD58EC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E838142E9B;
	Fri, 16 Jan 2026 22:17:03 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 0DF9342E65
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:02 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-655afbca977so1810629a12.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598221;
 x=1769203021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/L4b8C2nSmh7t3hmSW1gs/rW7DQL9Yn2kAIL+lkX4ek=;
 b=ZqcpVFAmIPO4/3GfrsH9iI/0oayOwe1zhuxnqL3UVvAILx1a0mev1CXgbGQ3C+FCy5
 NmcwZqyfynHVdDaOLf8mZgNipLSlowh3MFcVzroWUbqQgLrIbcS+f1awIsAXTf1aKtCb
 OM2hienBvNUsQ3MMhicLshK1fLBzMh3QFJ6MnVZ7zSJzTTi8GRPCXUZheD8d7kT0nm32
 AK9o8YlI87FWakId6lpsWWtbtRw4lmcQQo4qGUbXWTAFmN0aovoHRLnpKBDNEhpVw2yF
 1MOewTPBjN8zYZQogtom/18zhrHiNlaEX/rQVGY6R2uHc5iVl5jChqaUo1En21NhdE4G
 Fm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598221; x=1769203021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/L4b8C2nSmh7t3hmSW1gs/rW7DQL9Yn2kAIL+lkX4ek=;
 b=qPe1YBAKYW87Qa4FPBE4+DQTsGMdDLkengYu+/MoVpq8h2LkhNOhhLBOHTqSzf3WQh
 iGVHFP8CTSclJ/6gOK+mvYLt8HIHkFNRwz0+H+5Gvvq5OPkES5rgIajUAHghLNWPrycY
 l1Woq/TA8MYgaCilUGtkboVJeZzNiIbT1rHvU8nROpU4CynE/P4ylXzb6XNIBPbjMeXX
 owy29nclB9Y5m1in8XtbNK/judkqZKSP4NCXiUPBAP6OovZ8aa9mB8LBPI5WhX9vrei9
 M4+jCFu+Dk64CRZbWBx6jKD5a5QGtDKhSNXqlLXCXdqs8AMfIMBZVt9GIG15+v83DoqZ
 AkAw==
X-Gm-Message-State: AOJu0YySVgDMfkkRZNcDdUySiNOp8HHS0IGZbES5TfJ5eLoQ6ptrI2Ih
 lxzWGzG7Ipgq+GJaXa4IYOETnzfXj+aO7kPwGikFkRhoVcxuiy76RWeCKXU6oJ1ls7FLh3xsQeN
 m2aOh
X-Gm-Gg: AY/fxX4GhmoiutjsxMrAd5pUOz3K3PMVt/Yrt8Dwcm5kCeomHUrtTxLjZ9o8K5hlbUj
 LYBmzzUqv2+2lf0WWeQ9A/Kr+4OQMSfyElPKCK9xazOBBJiyBT9JF9isq/yvfPK9Ia3CqXRixl4
 oOUHpVa+wOQFidnUjGxDU7jo5LZacibQyS/AkZhr+JOtDb/Wi+CqYACE/gxU1tPjxRP+TTtGjD5
 4aeNZXVjNU6Vfr/cDeopdE3hoL9V4aYEF9S1AWoxUG+SJdvJWQ4e313d0Dwj9TyVh7/jNGu2JOI
 jjOxlkIHB4iP4hhLYzt0R3tV/0cgMShBefHJZxuu75p3nBevXA3SBRiM/9yga1tFp5jrWJm6sp7
 kcaFJ3WYb6KA62BmvmK2etHMWIP3eGS3urd1xRhVoaZay+QgZfj7e3BXE3mwxGEN6arE2fTWV3s
 qj2omO5Ib0HsGWrVvZeTw6b1jvwsoI/5SGJ5P0wxzmIu7LHEqsTA==
X-Received: by 2002:a17:907:a0b:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b87930289a1mr338626966b.61.1768598221568; 
 Fri, 16 Jan 2026 13:17:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vipin Varghese <vipin.varghese@amd.com>
Subject: [PATCH 02/11] doc: correct grammar in AMD platform guide
Date: Fri, 16 Jan 2026 13:06:18 -0800
Message-ID: <20260116211649.104776-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Add missing "to" in "refer to the tuning guides"
Add missing article "the" before "DPDK power management"
Add missing colons after introductory sentences

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/amd_platform.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/amd_platform.rst b/doc/guides/linux_gsg/amd_platform.rst
index 40b65d1c9e..40d8d93cad 100644
--- a/doc/guides/linux_gsg/amd_platform.rst
+++ b/doc/guides/linux_gsg/amd_platform.rst
@@ -101,13 +101,13 @@ Uncore
 
 AMD EPYC SoC support UNCORE power functions via ``rte_power_uncore`` from `25.03` onwards.
 These are tested and validated on GENOA, SIENA and TURIN.
-Please refer the tuning guides to enable ``HSMP`` and DPDK power management guide.
+Please refer to the tuning guides to enable ``HSMP`` and the DPDK power management guide.
 
 
 NIC
 ---
 
-To use Solarflare x4 on AMD EPYC TURIN, please ensure the following
+To use Solarflare x4 on AMD EPYC TURIN, please ensure the following:
 
 #. Upgrade Linux or distro version to 6.13 or higher.
 
@@ -118,7 +118,7 @@ To use Solarflare x4 on AMD EPYC TURIN, please ensure the following
 
 #. Please use PMD args ``fw_variant=ultra-low-latency,perf_profile=throughput``.
 
-To use Solarflare x2 on AMD EPYC TURIN, please ensure the following
+To use Solarflare x2 on AMD EPYC TURIN, please ensure the following:
 
 #. Upgrade Linux or distro version to 6.13 or higher.
 
-- 
2.51.0

