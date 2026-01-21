Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D5EC44500
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22CC342E69;
	Wed, 21 Jan 2026 22:08:16 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 59E524027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:15 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo3150925e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029695;
 x=1769634495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GwaDlSs7qxaksYvmt/6/rUbKq2KqrY7Jos44BpcCLE=;
 b=WKCoziQKm6JYHGzNUIgng8JYtPiOvhcL+a1gD+HO7gVL3+sds5HXMikrdx6DjQV7SE
 y8PnlSJVfZNUTVTzxyvvwl4SxCIEhTNxRtLxOtXm8IZi5EoKVakxeJzGRLw5gHzuRJ7L
 vsvjonRXxhpFcLf6vfzaVaulSF4tcejhhdOZl1+S3BBQyt7C+tmYVLAMh5dANFFfeSCG
 eWrRan+1KOpVe4F7maSKsGL4yR58BICb9ND7OSzfArMzhVe2GP/nVTCRcWBOdxpLqblk
 en4vUE80TmEbg2PWTHPUbDnx2IABgdVWCTvmOMBvor9M8nPx1MK/Dn0HqCBSmWcF7mUj
 Kz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029695; x=1769634495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GwaDlSs7qxaksYvmt/6/rUbKq2KqrY7Jos44BpcCLE=;
 b=WlyW4mPqnfLdpm1agMDIkNFWqc9XiNsH28qFMDzL+gZWFFZCMcb4DZqyTUk6cCiK7y
 mCgpEzFS5PeJunaoAtkFsJ0kY/vx0eP1/1qdE9x6exAEF7n0h7Rd/jCHcOUZGrX2Ew3I
 3yNJRxMMTqZDNyJeY5MX5dIO5OSkf9pmEF6MsoH9OaMz8++6qXN0yx5blsvSFM+u9sCt
 Mf/GOh2AMjQyT9JkF6XndYZq7/o7mpAksOMNFAru+BHVrnVCTsBg0+NL5dJ7PLTZiQWt
 QX0LMeNOWNBgoj/W8Y4EjQ5WE7b0c+RI4JG1+itvQa068esbJEBSEju6NJMYnYI6lyz0
 0Heg==
X-Gm-Message-State: AOJu0YzHaGAetlZfxpB34iBDidpvsfhjDQ6goUIDAuYlCDLL7ysV3TS+
 IKT1yjkxBuzZM2KcjH/dNxZOmWGrghj4Z7u+Qa/a+wOs8Iuzae5jNHM3lGgq5kIFuzADP3alcqZ
 yQqNe
X-Gm-Gg: AZuq6aLdVm6PdjUNcTd5ajo4SPAjLKm7Et/QGMfuLW2ojrIQB4aB2KB4IxRMhu17rPI
 Wd3vSI3NJlxi9jXFARRZGzeYzS3CJviR6sDgTEG+SlCRs4HRwf+Z6A7wSHEXLQUDm2Qz6kecg+Q
 14D15L6eGvRvzL3Qq6jKf1K1wMWbL/F3Y4ZZPD5FB3S9awxn4RA/0L6JqooRmWzDN8KGWM/QOVS
 qft2xbU65ScWyfptHLB/kgWySHXZpfb5WD8Xmk6nqCiMupaTXBD46UEd2RjoF6RsKEw/qq+dNNi
 FJkUZzh5VXt1LGdmGTVFYqOFqB4QIUYI+KQTqEmXRMQWtOHFS8gngNlUX5oI1Q480icgeQ9OyXT
 rZeYmyRRmQWo64oT0UH9THxfE0jZtLQyGnJlUoRU2YMZlKRrIDvEGIOibJ6bmzgjERcfVXCBF7Z
 DoDtPEZzcQnzGusah0sj2vjPa/ssdfunomIC5NEnb3l5nvyQ7+epEGgW8q301X
X-Received: by 2002:a05:600c:3581:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-4801eb03348mr296190085e9.21.1769029694898; 
 Wed, 21 Jan 2026 13:08:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 0/8] test: fix format-truncation warnings
Date: Wed, 21 Jan 2026 13:06:20 -0800
Message-ID: <20260121210810.1044276-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

This patchset addresses the -Wformat-truncation warnings throughout
the DPDK test suite, allowing the warning to be re-enabled.

The changes include:
 - Properly sizing buffers using named constants (RTE_MEMZONE_NAMESIZE, NAME_MAX)
 - Adding a common file_prefix_arg() helper to reduce code duplication
 - Using standard library functions (getmntent) for mount parsing
 - Checking snprintf() return values for potential truncation
 - Converting problematic 2D arrays to pointer arrays

After these fixes, the final patch removes -Wno-format-truncation from
the test build flags, ensuring these issues are caught in the future.

Several patches are marked for stable backport where they fix real
potential bugs rather than just theoretical compiler warnings.

v12 - rebase to handle new eal_flags printf's

Stephen Hemminger (8):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in common code
  test: re-enable format-truncation warnings

 app/test/meson.build            |   1 -
 app/test/process.h              |  44 ++++--
 app/test/test_cfgfile.c         |   8 +-
 app/test/test_cryptodev.c       |  22 ++-
 app/test/test_eal_flags.c       | 269 +++++++++++---------------------
 app/test/test_memzone.c         |   2 +-
 app/test/test_mp_secondary.c    |  14 +-
 app/test/test_pdump.c           |  13 +-
 app/test/test_table_acl.c       |  30 ++--
 app/test/test_timer_secondary.c |  12 +-
 10 files changed, 174 insertions(+), 241 deletions(-)

-- 
2.51.0

