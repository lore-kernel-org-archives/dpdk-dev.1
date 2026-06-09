Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1CCD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 21:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D81194025E;
	Tue,  9 Jun 2026 23:05:45 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 8620A400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 23:05:44 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30759632453so9088091eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781039143;
 x=1781643943; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OIsxMeVUm+M56a7Lb6IBxxxRfPlPlLSqNRPzK1IYnf4=;
 b=pzWfkR/ORNq5eTmzr5/phvea52vH4uie2u31RW247hyR8nKL45YZbyqEw5BCBvTjU3
 2q1+ig+fh2BMQFRn8Q0Nt6uCQTf9YtLnq0AIY3U8UAE2ZmxW3tZujpSOmiOkZ8zod6FJ
 ZBlieyrSaUt0mAdKQW6qm3HeS+vfQAvBnI/Z21SXyc+7AfmOj99AopO1/oUHLSS5gE9G
 0ow0tN2Tbpeg6PsJs2yY4zp0qgVGQvT8lcXWFG7Z9JJ99NVyNkE6i/jh0lqkHvUWpeZx
 LXZTz/2WsWB9PTOnetLdEJdncfl+wqzvgh1GaiW+nBtDXUGPJEDrjb2RPpyFCZYxneS1
 0KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781039143; x=1781643943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIsxMeVUm+M56a7Lb6IBxxxRfPlPlLSqNRPzK1IYnf4=;
 b=bPPeqDjY8sUOVjRxci0f8+0P1vSFndtp0WqBEZ8aI6gBUU77uTJlDdkkLeauK9t2nr
 oVTg24l3Qco4rDbOTvXgSNrsHE4tkTNYs7yN6JlbEt9A39HOLhyFOOP7sr9tYi8KEUTu
 p1YKDVMoNxxbyjNWPSdHDmuUddx488QO4nUmX8uFnc0+cwocz5cVjfJVR3a1N1mO8cWD
 q4RVX/p6t/mTM7zwSLFAJOMK7SIljclVLHy/TWjl5pJW0thd8b15cV4HaD2qfpJkzsm0
 xhINNFQk6ZB9Sc6AxKeF2IH8ggITGV7zf2TsYVJ1qKpAzAEHkqu55BngVmAQ5CXNSXwO
 /3Fw==
X-Gm-Message-State: AOJu0YyCDHgh6pz70YMBzWsg+7iI+m9u7OZahdu/0y53GEXjZpT/oNuU
 XrCOQyspOxvldqP0sH7y/qG6yn/0EfpQtkf1bOEw5SeCXzRG8THst7fn5MwN9rxuZep6E6VBWrl
 oktGK
X-Gm-Gg: Acq92OGYipL7YCJL6cuG4VLpNLaAhl1Wx2C0w/jnrAM88oYuqV0JyCFLy4QglT3iXqv
 4K3goyn/YPMHO/g97oB2QiAf1hYeNG9k7UIQQbn2scyQk8oqhz9P7bi0ShTFwt0ikbLiugEVLG0
 UsbzXxT/gLqsSkqsDMw8PLL3s/llWHV/q27eoYuISnwvx4AHDCE7puoF1xuUg4v1wICd6L7/TJH
 B8ivn+0BPy52Oi9rJiDQ3jyklC7xcy80y4iqufs01rCmJOQC5Ta3s7bUUxE1yJsdyOMZ9mVkjoa
 NDc7i+rAvf2S2lDt9WzXak2W3Gi3tkv44nEcOYb/aUJADtLa4fl3j2kapvv8KXoLzsNfQkR6oJM
 8gnnS1GHluvjNVuW0N6bjZPB83LAm1Kaeak6+RIQaGqshl0vbazJ2EWna/Ug6ZA2vpymEwjN5xY
 eME9dKArX83OCWjN+0Xnpdk2Rk9Pu8qgnsIz4iokaoyyPmDisI3twMPO7J6t0INjZvqhtMJpSI
X-Received: by 2002:a05:7300:3b06:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-3077ae6f51cmr13025617eec.4.1781039143275; 
 Tue, 09 Jun 2026 14:05:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm32953589eec.11.2026.06.09.14.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:05:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/4] alternative capture mechanism
Date: Tue,  9 Jun 2026 14:02:01 -0700
Message-ID: <20260609210540.768074-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This is an RFC for an alternative way to capture packets from a DPDK
application. I did brief demo of similar mechanism at DPDK summit but
this is more complete. Capture runs in the primary process and is driven
entirely over telemetry; no secondary process is involved.

A client asks the application to start capturing and passes it a file
descriptor to write to. The application writes pcapng to that descriptor.
A Wireshark extcap script is the intended front end, but the control path
is just telemetry and the output is just a pipe, so other front ends are
possible.

  1/4  telemetry: let a command receive file descriptors from the client
  2/4  capture: the library
  3/4  test: functional test
  4/4  app: the Wireshark extcap script and its documentation

Setup and usage are in doc/guides/tools/wireshark_extcap.rst.

Primary process only for now; secondary-process capture is possible as
follow-on. Posting as RFC to get feedback on the approach.

The extcap script is dual licensed (BSD-3-Clause OR GPL-2.0-or-later) as
it may be more useful in the Wireshark tree.

Stephen Hemminger (4):
  telemetry: allow commands to receive file descriptors
  capture: infrastructure wireshark packet capture
  test: add test for capture hooks
  usertools/dpdk-wireshark-extcap.py: script for external capture

 MAINTAINERS                            |   4 +
 app/test/meson.build                   |   1 +
 app/test/test_capture.c                | 365 +++++++++++
 doc/guides/rel_notes/release_26_07.rst |  12 +
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/wireshark_extcap.rst  | 155 +++++
 lib/capture/capture.c                  | 821 +++++++++++++++++++++++++
 lib/capture/capture_impl.h             |  56 ++
 lib/capture/filter.c                   | 108 ++++
 lib/capture/meson.build                |  19 +
 lib/meson.build                        |   1 +
 lib/telemetry/rte_telemetry.h          |  66 ++
 lib/telemetry/telemetry.c              | 115 +++-
 usertools/dpdk-wireshark-extcap.py     | 274 +++++++++
 14 files changed, 1986 insertions(+), 12 deletions(-)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/capture_impl.h
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100755 usertools/dpdk-wireshark-extcap.py

-- 
2.53.0

