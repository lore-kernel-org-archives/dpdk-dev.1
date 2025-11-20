Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD4CF9C4C
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98C104026F;
	Thu, 20 Nov 2025 17:57:18 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id A199140262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:16 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso1212035b3a.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657835;
 x=1764262635; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6umUv4XNnz9DJdzRQ1uw9JC3yJWKxAEmpWR3o7Cik0o=;
 b=jMlZb3tcK0cA7WxbcYhGGNBsELjoCKETay05jL1ZkV1qzmBBmWy2K3nhYu9R6f7V//
 Uz2yzK0KUvK7Lz5Ubx0DoWTQHcpOrsrnG98/TUB3eQJUcii64A36ie4nVgz7SA0aKhxp
 K/aCGBgxJJfIbLscs4YPiuV+SsTAJ3ySiO1iCNBpJp5fZ9AOJqD97xA3SLIKy0+cV+Uw
 ulcp29pRTZztm6ODW5IsqcxQKoYc8oPjvdkYpPOg3iJy5HSV20u8hWM8s7IHri5YGR9P
 IP/l5FhjbOeWx0ptBjQVDBNLLGD7of8XpQF3TyCwbXO4NuXSOMgaRU6wgmMfcpSMfSUk
 XcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657835; x=1764262635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6umUv4XNnz9DJdzRQ1uw9JC3yJWKxAEmpWR3o7Cik0o=;
 b=j8wkhN6nv4QJzwKJV6AqoRrGBPtVia+kIabwuqGpzAFDkENMrvJk8pH23cYaeAAkSE
 024ssnlI3OOyEogYJCun5tjLP7AY/qG9ruMKIVH110FMSecH4XA0coD7gmWr0TxGjd46
 5tghbo5srG14UqAORkSGbYbjnxbCEm9CJIwn7TxmONiSarYu9Uzr311Tl06SZyzfFx8t
 vcRJRLJ03RtFMi8sXBnezRSbPlPPX9Sqls8gI/R9PDfk2yxVfCY0aEziH6kL9g5gadtM
 GXdveh+t3d078zZPrpz1K/NcvcwSsYxoHoyAoa/4V3XTiWH7n5QA/NmdPIh0JaSdKGMK
 pKKQ==
X-Gm-Message-State: AOJu0Ywn7XJ/5HZnrjDan1qiA5aWcdLj6yym6tHV3RxHIGYzNIJu0qHE
 8yOu3cJawUI+vnFYymt3oZ4yel7xfhI1aYDNZMrbNovd7KfwU/Ndh6a6XX8mcCiJ0tA2aIqcJpY
 MVXHq
X-Gm-Gg: ASbGncufW9/zUYErMAeN+7AALPQNs+K5m1nOrx6kKojXAv2aD72bDuxARUBAGnfUwee
 F86MZ4Ta6UTYmPVwJH+4pUguPilGiZMdD5/+Tc+LX+7+TvhpDt9SPUqZUT7RYc9c6/yXUfLeNFv
 LvhhEXcLtKP5TNwE+0AiI5cFvtShYaOpzf8AYAEwAsukp7N4BrR35tD4jIiqnArMFT3bII20E92
 u4+fLZm4R66oE+SUOuKxKFsOQKNVyzn8hbXExGqhOTnVc+Uf5geB+NvyFAVlVvIjTYhO4SJ8UvF
 Bo2QSUbiLoDe309ge1bhhdYmwvjcdBIUduONmEEZ9YYGFBjyn39pHUETJRMsWUw9A2ZnCjJgNVa
 QnMGc8C692WS534lkAnaB58zl6/oDOPKkF+1yscKZp8NWve1Js/635nWnSkXjx3gNYaeTVndFgi
 v5hKdefMpiDcKRXP5rVEJAeVmAeW9Ch5a4jzrAQ2VYSzDa8RJ/mw==
X-Google-Smtp-Source: AGHT+IGkQFxdJcOkUHrA/4FcjQbdLmAtwkKlodIXPhy6XeIwVeTEDlaa/t7Ka9NvueWPe251gbkmgg==
X-Received: by 2002:a05:7022:327:b0:119:e569:fb9b with SMTP id
 a92af1059eb24-11c957351afmr1128827c88.10.1763657835335; 
 Thu, 20 Nov 2025 08:57:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/8] tests: enable format truncation checks
Date: Thu, 20 Nov 2025 08:55:28 -0800
Message-ID: <20251120165713.120238-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0251115193409.99740-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
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

Enable format truncation warnings on the tests and fix where
there was an issue.

v4 - resolve more warnings found by CI
   - simpler fix for cfgfile test

Stephen Hemminger (8):
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: use unit test runner for eal flags
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: re-enable format-truncation warnings

 app/test/meson.build      |   1 -
 app/test/test_cfgfile.c   |   8 +-
 app/test/test_cryptodev.c |  22 ++++-
 app/test/test_eal_flags.c | 172 ++++++++++++++++----------------------
 app/test/test_memzone.c   |   2 +-
 app/test/test_table_acl.c |   4 +-
 6 files changed, 95 insertions(+), 114 deletions(-)

-- 
2.51.0

