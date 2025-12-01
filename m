Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC6D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0288B402E4;
	Mon,  1 Dec 2025 23:04:28 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9DA864013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:26 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8b1bfd4b3deso353332885a.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626666;
 x=1765231466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMMnldew4iKfXo9zQMpOUi+vH4h+lxxMGrJk3ltX3KE=;
 b=PmodscR28my8pHNhAcNZ1X13zEUzV5GrcqCPyQVzS3gJRp/ZVKNd9P5HVKFCjD0KZp
 t4LJ9utaX5kt0qxgl4pY5eaRz0MmuuwrhdJNKcvzYVmtdw8x/3Lg0gemUpEtyoS0YnOC
 cKuLa8aH8ImBwPZo7c7hhY+p/SVhCsxV8dMUemtfZVREmHpGOWKokXx9i+EufguxLMPz
 4yiDou38pdYaq+kW89zEPtsiqEBVj+rc4/zOhDtSKI09lQX/ABUv4iRbk/aCaVveJlmd
 4Qa8NDJBkCnY0HEt8x1Dn0KLqeLFNtCWE0qaeE6zF1f+/cqJxHYBsRb3k2WqYSIXiLpY
 Z/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626666; x=1765231466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TMMnldew4iKfXo9zQMpOUi+vH4h+lxxMGrJk3ltX3KE=;
 b=tE4bBIUFaOIpe+U1l11XJCMvXrlze6qC2K3vsSD7pkeiSs2KhglImZypYWMo9MGwXC
 wmFkfjLcvoLnGWkYECuC2BO2gFghCUjkmlLf9anHZY4cbIeqznhHMNvJIq4vOrKz8dIr
 0VckuROyw8gCEt5akBZsRhrj2/xiFm9naIHVLfvtrf74QWGrtOnULYJIzwk9SMh8VuOD
 eLLBHUjoSpa3EPR55cBcBft1ITHJTraqF1dCKdv9RO/HLdz2kRacdIiHgjEg67vpv+LF
 72/SPBkzp/hWiNy25Ika+XcNZ+OEB09dDDu63OQnQ+1ndRQWT01p4SvsorKh7o/2CBYW
 zZCw==
X-Gm-Message-State: AOJu0YxlAQtQFIdjkLWh7JhUw08SS5RI+oPY0Vbe73oJZmKH/BEx92O5
 4zC7TYbhxiw7WzvzOg3qZpK9QgPWpPge5hnkjMBI0UOC7+MMQMMWmKK2JwwtvJrU1PI/S+HtXE4
 CzkNc
X-Gm-Gg: ASbGncsBKZ+5Xa9QM5A7EeoFUaxEqAwjZpYSDvZc329JRpSNxZYEDuGSD+TimPsWYGj
 LhMzI7kfD5PSJtOSC1vN5erXBGIoE3NKTwdY0VQVXCNldBF3rtNfLfrE2273I0ACR87nw/zc4GO
 ysVMwgGTxqZWOdtTDJZ6cQcfwSY2zSeaPdoF1tCbO69ZZEpwg4LWfGCz8mi1Bipx80fBfJj+MI4
 NDDMQvfEdozSMlwJc1NMYflxiDSuyVBlmKis5NyaPY8oEiEeMn4eYc/rvIg2aquvOnGh9dHY/iE
 KYPMlX+vmNyOtCqqnogCEwjI8clVe4n7yGFtHDKh3Vp+4a4MXs2M19kpfVgZvfXpZAyPwQM1J0W
 Qcx599x8hptyww3TRe24TQ2xmbOgievREmaiQF77IPygkdBdD6A5IZGLfzu+SfRomgHqiaLmobl
 amY8Cr82poSjpNCeoXXAgxxGjk+qDGX54Zx8jC2zkELRfAAvdFrg==
X-Google-Smtp-Source: AGHT+IEWah5qUINQGmAs2gO6Cqq/5GU9++8+DZc5YS6YVQUMU6ErPX/pgBfFRFwdkRZLIxUkHQnkgQ==
X-Received: by 2002:a05:620a:f0e:b0:8b1:110a:e14 with SMTP id
 af79cd13be357-8b33d269d37mr4948280185a.55.1764626665462; 
 Mon, 01 Dec 2025 14:04:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 0/9] test: cleanup and format truncation fixes
Date: Mon,  1 Dec 2025 14:01:58 -0800
Message-ID: <20251201220421.207285-1-stephen@networkplumber.org>
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

This series fixes compiler warnings in unit tests about
format truncation. It also refactor some the related tests
to be cleaner and use standard API's.

v9 - drop using unit test runner 
     tests need the additional cleanup between tests

Stephen Hemminger (9):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in several places by using common code
  test: re-enable format-truncation warnings

 app/test/meson.build            |   1 -
 app/test/process.h              |  44 ++++--
 app/test/test_cfgfile.c         |   8 +-
 app/test/test_cryptodev.c       |  22 ++-
 app/test/test_eal_flags.c       | 243 +++++++++++---------------------
 app/test/test_memzone.c         |   2 +-
 app/test/test_mp_secondary.c    |  14 +-
 app/test/test_pdump.c           |  13 +-
 app/test/test_table_acl.c       |   4 +-
 app/test/test_timer_secondary.c |  12 +-
 10 files changed, 149 insertions(+), 214 deletions(-)

-- 
2.51.0

