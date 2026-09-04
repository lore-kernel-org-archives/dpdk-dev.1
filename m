Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C2C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE849427E6;
	Sat,  5 Sep 2026 00:10:05 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 479A6427D1
 for <dev@dpdk.org>; Sat,  5 Sep 2026 00:10:05 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso1447505b3a.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788559804;
 x=1789164604; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=045+8hQHNzcolxgZrhYUz6MuZM4IS5N2bXdl71zuZuw=;
 b=Phuiu0jxY8powIOrLQ40ngGsY54sCeH+oGaMJTX3gLQ7S6JuUC3vor67pjYnhdRFyb
 /TCG0LCTjyaBwy9d0B5sRMXF2pHlwF3G0orgr/sZxKy5ZrqsnNF5pz2F5WRQih+Xi8gt
 GLd3pZuyBgDB3gNpY06CB4JDCgaT0pBS3YX5Z1klDTspBLv2dGE0GAKI/lY0nMY2x2+z
 3xNz9QhH/fKAjYsEvHfTu9W8DuR8Na6jyqn/7hWcLWGHuxtvBd/bne6HQvQuwZDQQ/cW
 lgbESlJrALwUjDvHwYa9NBUfEF/RJL3bqHrUljf0W/8b3VoZgCOVV0QRNc/VnT6CKdPD
 rSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788559804; x=1789164604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=045+8hQHNzcolxgZrhYUz6MuZM4IS5N2bXdl71zuZuw=;
 b=o90ECbGfp2pYGrZAzQaoTB+eTHfU+z9F2/GXRvp3MtU943wAtnAO67gxGvkakoKfV2
 OqfCx0wA7sRJzkgI2vC6bDPWYrdsR9CjH7Or8HmPNsKJQxU6+2bIYzbsnSLuk8gWYd2l
 sjZHWQMRI4NlOoh1ugM1+tI02N4E49Sy7m8rF3oxZEeawDry9kVjuyXYTP3mw0Z1/IoX
 dhB1qCqcKFlqPeZuPPkYlFWcGpWCF9dJvlBXHUDqlzMykM4Vtbm6+DxEoX5aKqszdcN8
 G4VaIG5LPWpJTr3A0qZN5SdlaOc9shbySQSz8QFxCVEJpQm9PDlGtER2b2cGn9D9gzkS
 GfkQ==
X-Gm-Message-State: AFuF++m9f9kYz3fTeAI3IlG1q3pj8BwMp4G6V7daU8UGkePrfZxOTv7z
 J5b3UQq0DZ8Y5Aw+Cuo24gyNuNIkyxZqIL5BLjv4Xv5EzrSlKD25LVSMZbvbHf6hhIhcxZS6jhk
 TcJYB
X-Gm-Gg: AYBFou0wPZAVDTh+OX7TY2BmLV2IXEpKiiIvfD0RUPsoPoa4y4T2NfUNXEqi14liYav
 1RHyQ0tyYr2PcxWrQwuX/V4cTsNHTW1x0rwVpz3vhek3Isasj4BoR3z5SQTjQzIc/6khuahBRlk
 9fHrp7gFLogWGg+Ag/jaXApFFkqv8pjx4AiZ/u/Y1Q7lGed2nafL1Cs4DPzyzIYVzzEBs+Wfocc
 ZLnzMlJwCycWb8V0JH5h06CEyof18qM9Xd++vFw0ldM40MmJ6vcCH8+YqHERz7noLrgOYlttX/Y
 U55TA+14vuH7w70gw/86QGP6mOINI5iTZYxhMaItP5ZfE7evN4kVC3Z6zfNNN6i3H5Hc1P4doBJ
 N36Ft51XBqTq+GBisDpEsRP3Hei3hHMBjuC4nILRn5rG4jwGNT6FDlJ3I6m7YDHAXDbbXpLRumf
 gYLuuzXTtDNUvMKTaWxv4iC5XVW7Zo33BgKWuFdTxKUkQMBHnlTzYP+0lvvkIwgPcwBO3ZCoWTW
 jZE1nPlXDbeuaYfuIhwJ8YpdahUgM8gNNr/0A==
X-Received: by 2002:a05:6a00:2885:b0:857:72ba:ff0c with SMTP id
 d2e1a72fcca58-8616af5cfeamr12864005b3a.20.1788559804109; 
 Fri, 04 Sep 2026 15:10:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86153a1c1basm1614076b3a.52.2026.09.04.15.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:10:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 1/3] eal: make unaligned really unaligned
Date: Fri,  4 Sep 2026 15:09:06 -0700
Message-ID: <20260904220953.3105930-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904220953.3105930-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
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

The common tests that expected unaligned to really have no
guaranteed alignment would fail with UBSAN. The root cause
was the definition of unaligned still implied alignment on x86.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 6 ++++++
 lib/eal/include/rte_common.h           | 9 +++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..47de839458 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **eal: Unaligned integer types are now really unaligned.**
+
+  ``unaligned_uint16_t``, ``unaligned_uint32_t`` and ``unaligned_uint64_t``
+  are now declared with an alignment of 1 on all architectures.
+  The compiler may generate narrower loads and stores than before.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index f872d3eabb..d0faa9a268 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,15 +121,12 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
-#ifdef RTE_ARCH_STRICT_ALIGN
+/**
+ * Integer types with no alignment requirement.
+ */
 typedef uint64_t unaligned_uint64_t __rte_aligned(1);
 typedef uint32_t unaligned_uint32_t __rte_aligned(1);
 typedef uint16_t unaligned_uint16_t __rte_aligned(1);
-#else
-typedef uint64_t unaligned_uint64_t;
-typedef uint32_t unaligned_uint32_t;
-typedef uint16_t unaligned_uint16_t;
-#endif
 
 /**
  * Force a structure to be packed
-- 
2.53.0

