Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43644CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:29:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D9BA40151;
	Sat, 25 Oct 2025 00:29:51 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 138FA4014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:29:50 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so2286020a12.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761344989;
 x=1761949789; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+BkZZwmGPbCpkcVTwa+c6EULQv5WhhX4vAgt88tJnIk=;
 b=zH4e75SM9bUMZbmJEgYMJ+9+FheShy8TMp0/LRTelA/dn3pImVY+JViwhilVPRWKxl
 6b+Qnfs+yfy7GPOtAg3hDeXO/58vrOemWBQvZXe7ugYei8eQZkfBbphV9qQj1eMPJEe/
 zjMwpUw+APSAAPb1HK4m5Z9wV6+ev09Ota5s3PxyHCw7txP0XudjWcGj3ALFHba1Ip6K
 wd9fr439HHCcwbZkn4YAjkt1mpCmWIOxHe259FMBxJBMZ6+uccVTdVq22PuLibeBAe39
 j7n06TKbOnRP0uvdRvMnwwmzXmSG+04BQ9Y0H3hUAZ+pNIXDJeEy3JVzPhMRan780xL5
 eQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761344989; x=1761949789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BkZZwmGPbCpkcVTwa+c6EULQv5WhhX4vAgt88tJnIk=;
 b=hp4qpoKLlimyxTKAo8ByqRSw6ErBVFcsTWIkS4PbQA1Ykkb+KzJB1RLcRxQOpnTTTn
 c2cjGR4a/Y8xKww67YfIEUT2HMlJVI8ZFmzeBQFFDeI/P5rxOKHlUCvLojBZDwYyQS3g
 S8KWXx8Tk4BwASMlFwbi4nZrh6/lr7Wy91aPfUKzt1pZMAfRN5KDzm6QdCbXL1XUfsGM
 eH8+Qz8gDbojB9K0JMMJFXVa5/un12xoLo699+g+6sgw6/TODr84F2SZrgJRNmCpGeLt
 GNAarr+szO0B3k6/IkVH4pgxn1sm9u0A91Z/Rf1C5zSvTvsTGE7FTcRshDIuX3/okThJ
 R6bg==
X-Gm-Message-State: AOJu0YxgWbUeHtoXdgnpvMhEv/FY4zvoP82KLTkTmsCiDb9WxgGGEOqz
 yvSj+ScRi0xEuZ6LQnmNljFLKgy2ktr/V+lNq0hRypJgMbJ+sPcHBUbtPyMI0+44E2q4fdhdsPc
 GQjQp
X-Gm-Gg: ASbGnctLeTkhpGJvWidHUMp2CDP3LCrv+YVUrtaytoWb82GN8pANE0QVQjlB3YWrY44
 qeUMzWCcDw2mOr6tOVx4agiTpGGIofJXGqyWC5dM5Y8gICd0Yo9JbNFmoF6lqs9zahQlDnVjiYG
 gCIZZn/yzXOiEfyqIrp5kHqDFDn9GiE2x0rctYFnIQi9uhfmnBM1dUIXR+hEnIJhv8eg/e0WAdn
 yEvMsGx8pKF8rnf5IhXF6Ir8HNr5Z9CKtFFUtadrgqjzHmsnkeHklY/NzS5fmjomM0w6ayqF6qy
 S0H3++uUUHK9l+MyKUhKrptslHtoggxW3W6oWncuLHJqnziQZ9RdKpFvg47THzwFrgsLmRtaUkE
 tq4nSFlfir5CASoeboM+lQHzafLb5Znsbgym1tmokMUbU+ZDTOl35o5qxCuhjhrKRlNd3sBKtL9
 m46wPem1OC0h8fGcORfbTsuphdCfS2oS5PUzZeBds=
X-Google-Smtp-Source: AGHT+IHnOTAfc/83wnvg8XUO+9rOHv3Zxt5ZNFfqyUC3RiQNa84tDSGKc/DTc0ZAC5iUmnvfMSuBMw==
X-Received: by 2002:a17:903:11c4:b0:28e:7567:3c4b with SMTP id
 d9443c01a7336-2948b97fcbamr45499265ad.16.1761344989100; 
 Fri, 24 Oct 2025 15:29:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d40de4sm2996445ad.77.2025.10.24.15.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:29:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shperetz@nvidia.com,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] mbuf: fix build failure if MBUF_HISTORY_DEBUG enabled
Date: Fri, 24 Oct 2025 15:29:46 -0700
Message-ID: <20251024222946.323662-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Message had extra newline which causes build failure.

../lib/mbuf/mbuf_history.c: In function ‘rte_mbuf_history_init’:
../lib/log/rte_log.h:364:9: error: static assertion failed: "This log format string contains a \\n"
  364 |         static_assert(!__builtin_strchr(fmt, '\n'), \
      |         ^~~~~~~~~~~~~
../lib/log/rte_log.h:387:9: note: in expansion of macro ‘RTE_LOG_CHECK_NO_NEWLINE’
  387 |         RTE_LOG_CHECK_NO_NEWLINE(RTE_FMT_HEAD(__VA_ARGS__ ,)); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/mbuf/mbuf_log.h:8:9: note: in expansion of macro ‘RTE_LOG_LINE’
    8 |         RTE_LOG_LINE(level, MBUF, "" __VA_ARGS__)
      |         ^~~~~~~~~~~~
../lib/mbuf/mbuf_history.c:219:17: note: in expansion of macro ‘MBUF_LOG’
  219 |                 MBUF_LOG(ERR, "Failed to register mbuf history dynamic field: %s\n",
      |

Fixes: d265a24a32a4 ("mbuf: record mbuf operations history")
Cc: shperetz@nvidia.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/mbuf_history.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mbuf/mbuf_history.c b/lib/mbuf/mbuf_history.c
index 3bc4b916b6..b025d12fc8 100644
--- a/lib/mbuf/mbuf_history.c
+++ b/lib/mbuf/mbuf_history.c
@@ -216,7 +216,7 @@ void rte_mbuf_history_init(void)
 
 	rte_mbuf_history_field_offset = rte_mbuf_dynfield_register(&mbuf_dynfield_history);
 	if (rte_mbuf_history_field_offset < 0) {
-		MBUF_LOG(ERR, "Failed to register mbuf history dynamic field: %s\n",
+		MBUF_LOG(ERR, "Failed to register mbuf history dynamic field: %s",
 			rte_strerror(rte_errno));
 	}
 #endif
-- 
2.51.0

