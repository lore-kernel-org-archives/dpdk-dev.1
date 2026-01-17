Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651FFCA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A66E442F79;
	Sat, 17 Jan 2026 23:01:09 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 11EA642F7E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:01:07 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so1494240f8f.3
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687267;
 x=1769292067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ees6+GvULgZ4xSSaaCmfZI9hrdCK/qoeNeBjc00xqFg=;
 b=jOxTFd+0QIlDtBHmKEsxI9/on0klS3k9q7GvEE5dO9OxsrRp2UzeCYJHpB5PgpS1Fr
 dkc/MQanAyKz5J9RZlyI/ZgWH4Ku0B1R2x0oGSA8R9ob1zpl+znTcwqaGfuKNFBpxQ6a
 h4M9NVx1g1ZfL2lwzbIWRoI3Fc2Sx8eP5ipySNTn74Ugu4eQrSa0XtcjzwnXWpDRA8Zl
 VHekiMsCsZ/f4Llu9WUM8bCV3xrvimB4m4mZFW/Na6FIoZ5g6apJ4E6Zf0zT7ROLiZr7
 09/zHZCuNb/EvaVZsq59loGeuNoRofh5vXUzMPSmd2ro7RkXnGAsyUlf8Mp7F6NwI/ml
 N6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687267; x=1769292067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ees6+GvULgZ4xSSaaCmfZI9hrdCK/qoeNeBjc00xqFg=;
 b=aZ9axZk/Dmz/xL7rEAeOeYXRThqWexTbKDdGiFMEHrf0aouN0C1VTVzYMTbpDV6X/1
 fpzilDabXZOxQmlw9YgKRAznTB/MXr0b58IFTk7G29xqXr+JPjcQUqDpcS6jc9DxKpey
 wDst3I/XHP5Qhhla0fln0JpsGD/XrWMf6r5pKQx/kSmuMNa7m2suXVJ6wu9GofTtlbyr
 917fKh6MUYiCttw0l0ZjO7Ays5kR+PoDxBriOFsi/SAHwq5NvmNH6+kk5b/bqv6rb7JX
 w2bwQQYtwyPeYTdsrCSga3GowbhyRVgmNvcDUhYynJQig/2r0Zd2VZyLEnL66YmzBEvO
 iPKA==
X-Gm-Message-State: AOJu0YyNzhh3TPni6WF2C1qG+lvBtxlX2kfwp47jr4kbCFZZRBNRUpdd
 AbIRF6vqUhQhO8pkzECcljftHrKk3RBZcKEO0Cn2q1d8RNLdO0WKYJsNXDKuzG4DQeZNwV2uzGz
 en8bx
X-Gm-Gg: AY/fxX7pl/MJUgCg2UagbuF3N3uKBdy3d9ORkOP6ywO4nrRsCwii+JuBSu6Mc/dnn7s
 EX0+HXlCcUympkEREFT28obqBnBnXq56NOu+JJwpRaTqBYTqL8FD9WjrgOo5jKoCBnGnn0Cqn0A
 br0Rvkjo/+20uEpLi3BBu+FOY/6eyrMID0Ak3ye0E+C4p75prxbXRaU2LMCL9xg96O6DYkIbJEd
 OSNJo3Q80Cp4+YQijf953sOioy9CYGnchKMMFqdBPmcIdafVz0Mr2OXFBMWMIIlZYM7cOZfvhh1
 rGT9lX4aF4zVPTXSX73T1BAvd26hpWUBoAiuWT+MG8tUUh/UU6YPoxeMh00w/AQa6Ixte/2THv3
 Ik6dK6TDp7ur5xWi5SY93htQz5oTWtay0hPPLru/1INVIHflRjz5SR5yAe6E44W7u2Ldsy72/u0
 6J8DjbgeJL6rYRTmZX4/aIuEMtyzokq9mayYkOtfO1RNhg1VPSvw==
X-Received: by 2002:a05:6000:2203:b0:430:fb6d:1442 with SMTP id
 ffacd0b85a97d-43569bd4211mr8989742f8f.62.1768687266644; 
 Sat, 17 Jan 2026 14:01:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:01:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 11/11] net/pcap: add release note
Date: Sat, 17 Jan 2026 13:57:10 -0800
Message-ID: <20260117220030.273471-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

Add a release note describing the new feature
and offload changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..5550f17416 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated PCAP driver.**
+
+   * Added support for setting MTU in single interface mode.
+   * Made receive timestamp offload optional.
+   * Supports VLAN insertion and stripping.
+   * Added unit test suite.
+
 
 Removed Items
 -------------
-- 
2.51.0

