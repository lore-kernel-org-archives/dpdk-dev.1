Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F272F3C991
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 102D64067D;
	Tue, 24 Feb 2026 16:27:39 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 35194402E9
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:34 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12776bebe9fso321631c88.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771946853;
 x=1772551653; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii5s6iRMZJ8RPuL5AGySsoSzaZBOkXa+9RkPAjnG+cU=;
 b=u+45bZqBnRHVwrjnEWCYXcH34xlLDjPQAGB38TbGHlcHMC6o4nQy/96q61np3dG+qa
 WYbDz1SXg7jaY64DH2RaGqAG2ZqEOOHFhit1cqABIwEJWkzsRiHiB1lVM9aNtlWwD+BB
 3WmOSodIOHsAmk/px12KLLdpyOLGVRsRpUpwKWSHDtrZ5J0euxmuPfQSVWWHcDwoK9KH
 uFYvd0KCdwqxApZ6zJ3/GRvn3mUg1uY4SH5jpdE/X7nkmR/a93TuiRQDyAmFyB1L6AgI
 Me369U5Uo1NXjtOQr3hvOVOgP5uOn1XfeLhwR0DJawVrjVO92FWsddWb5S5HyafvWtXI
 DaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946853; x=1772551653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ii5s6iRMZJ8RPuL5AGySsoSzaZBOkXa+9RkPAjnG+cU=;
 b=g4NhWgqYriEImeRHORVhyQDYXEj/7t1GxldxpFoKBme7zRr+wea5RUkAX5r0IfmR8/
 jahs0c86l+HE/NrBi9pinNDLa49wI6hZnV/xuiIttrY0vOr3Wj4WRDdnIa/B0urO+Spw
 tPBxTWPTNqJmDlnpgy228cbA3NdkuB9zRmBJgfGmFVmZo7z4qQDOrWT4vyuXTEp7QwcX
 4QESZsxGcgP2Mo04O9L/8dj/e4wuxCgQ/JVmxOeTicQBq02wa3z7hJR25L85kc/FL71P
 NWef+mgu42KrZZPpDN+z27FFsl1zXFf7ctkMh5C4U5egm1xiR/ESGW6dJVT3IbcKm/pw
 SEqw==
X-Gm-Message-State: AOJu0YyCHl3S1r+h9ihO9SZCOWnq44xannbjkLlp3uinz4t1aUCg/Jff
 lLzKzz+y5u3VTjdFQb+yxT0qyMdRVitYacbnygpHu0aP01uYdGBtj8m/OR/nxDGeqn+Os8Gr32W
 S8yXw
X-Gm-Gg: AZuq6aL3yCDYMHDQljDKgNdn16qQO3cIkXesxxxHRGFZKgQh2mUfu/IfIr5MyefXRfx
 cVhkPE12myG8+ehjsqXk2wk4cih967vOUxShhywB4HI8YWk+5XGfTewp2Wz7sUfecnoQRzl/sjA
 h3CwKmzN9v+xyIE+p2viUxkZvPkKj5OdIsw9Fi04cWtnG/qZn4+DN6oS9cB2nEeLKvTKAKkW9wZ
 SfEVpW5mQTt/CSqymiwAzowm1o/mbiclkI7r+4i/ihFOoET5pXPJ2R+HGKq2pwbKuit5tvW9p3i
 CT5/g5M8rYuJFopPH5Od//yG3MbIG1hB/K1fC+fSUj74evlOj8bCGMJw5MbxDrM+KltN2o5oYdz
 VfYlNQcCore9KX42iIf9cFNXuXmAWy5Lv+r3gF8DE+h+cKFBwk5vQbWIJV1DgcBZ+7epPRGXL1M
 CBvo+J1o/msA3TEeogtvVjoRmkDp0dp47Lpx64rfNVVAlA2oG1ndQLh0MFEAlAOA==
X-Received: by 2002:a05:7022:1602:b0:127:337e:3301 with SMTP id
 a92af1059eb24-1276acbc411mr5810878c88.12.1771946853195; 
 Tue, 24 Feb 2026 07:27:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm10728774c88.9.2026.02.24.07.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:27:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 4/4] test: use fixed time length for write packet test
Date: Tue, 24 Feb 2026 07:25:57 -0800
Message-ID: <20260224152726.567604-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152726.567604-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260224152726.567604-1-stephen@networkplumber.org>
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

This test would take excessively long if the TSC frequency
was very low. Instead of scaling test by frequency, just
use a fixed length for the test.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index deba08cc6f..ea62c949c0 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -262,13 +262,13 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 		 "generations of example code. The magic number 32 is not documented because "
 		 "nobody remembers why. Trust the process."),
 	};
-	/* How many microseconds does it take TSC to wrap around 32 bits */
-	const unsigned wrap_us
-		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
 
-	/* Want overall test to take to wraparound at least twice. */
-	const unsigned int avg_gap = (2 * wrap_us)
-		/ (TOTAL_PACKETS / (MAX_BURST / 2));
+	/*
+	 * Need this test to take long enough to try and exercise wrap around.
+	 * On fast CPU's this is 4 seconds.
+	 */
+	const unsigned int num_bursts = TOTAL_PACKETS / (MAX_BURST / 2);
+	const unsigned int max_gap = (5 * US_PER_S) / num_bursts;
 
 	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
@@ -309,7 +309,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 			return -1;
 		}
 
-		rte_delay_us_block(rte_rand_max(2 * avg_gap));
+		rte_delay_us_block(rte_rand_max(2 * max_gap));
 	}
 
 	return count;
-- 
2.51.0

