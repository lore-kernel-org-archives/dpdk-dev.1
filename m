Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF47CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8123740151;
	Fri, 24 Oct 2025 23:55:01 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 9690D4014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:00 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-339d53f4960so2791420a91.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342899;
 x=1761947699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnQyYhwEgGNJcNtpmlXjtc/oKU8tJwfhE0Nh9HvE4lE=;
 b=knE0r5JiMfH0SLZL9BzTaepnhPKpxKeSbZp/d9/yDOGSL/wAy952ISA+BglK02wZEU
 CF2+QTeOm4PNhXZ7A+hPPy09n3YzfZRsZnmK4CacSkWT0N1NlGndZfgosVzGB1drhlRL
 y4tD0BDCiuFcS6i0mXZCycupQDgsfaY9bdi41QhW4D9Bg6PjXG71M7pEPMttR9IFyQS6
 OZYSgwgSOZTYN8lE+ibPj1hAaL4VAVNqop8rd0ubqPVFZYGEwCTZpeUKPoGBsH54VmdS
 GgMiLJY74XXXbB9OlnD6SVAUmY5hFuzELIGfrOsE2hCpc5Ar7uURd/yqJd7yTJkP6pG3
 hDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342899; x=1761947699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnQyYhwEgGNJcNtpmlXjtc/oKU8tJwfhE0Nh9HvE4lE=;
 b=ZK8EawoO54nEcjBKBhw2c2xprDlgHc5z7eQx8wPQHyK6t7FGmK14GAov19KqMx28HK
 g0c1Y88wCdc/kwldyrz55PdaTxcX4dQKtt2juU2z4bPAbCT/8asdDrSy8KuX01JyAt6Q
 CnAmrs6F7wdnYgPq/logtPnUJNSAGh5GC64zwcY9DnnFUMHEa5DheJqPbo9qmAv8uZU4
 1FMi4icl+591yDmtU2PR8yX3LCxWaqBGioRqzPBD+SQ8VKQCfyQyfBBkJCmIJ++T9L72
 Ithq8XlsLzprWQGdPCpqFHgr+XTCwt2kkMunTi4ecfTsRQ5efk8DWU1+3eTgl4geo+h2
 yxaw==
X-Gm-Message-State: AOJu0YzdUXBOH4VlftSMBGfRDC5hywP/HxA3jMZC5jKzY23oGO7Euteq
 B/JMIPypq4LuZXP9v3e0tces+hS82D+13MrJwcUc+3mJDzJIfMLg17exgijCS+PWoP7fS8kiKbl
 XMFY1
X-Gm-Gg: ASbGncsQLvoueEJeIm09Ytok/dYqQzNRZc3uUOCytHs3zrzV9Oow3yGc+zIPhRXFDqu
 AICVfyXoMS0iOL8J7fF2zYS34b0J01gGe2HnKD3m3ej2Hk9T562CntpQybV14rHJk6ZRX/sbEz4
 hpk+hEWkvw+7mvO1Tst10kGxX1J64zjWdCe135XrY8/Un9lH6a8PDH4xjML6ql8Mr2p15wWBrij
 yxT0PruyY3ge2vRUfTvA7xKPxgDgs0TG0MSPnfB7GhvTh6ZTO4fZhZvAXYhDjv8I/crm1HzgEWK
 mxX9eaPaQoqAXITk0ejvmoELl5e5KoFZc/YOu8NjUuTJHq0Z8CWClV9PTJBGi82Y3sByYNLB3T4
 1y1lSZ+cXv+fqN5D/X59BfoQ3aZq8reLjzKWb1H++DXv7R6Z4pSU56eIvpoFdCoRoaw/R2wOcHh
 hZVEHvKvvuQTwdQMz6mNxXOynRWqgCigFTDE68TMUEzNKI2oXRDw==
X-Google-Smtp-Source: AGHT+IFbGpBpWASJmKGyoF//IkhLXCWrXygRGBqn5yL3tbe/Z6dH8dHQwYv2+Q4/Lor+fR6yPaWZ7w==
X-Received: by 2002:a17:90b:3f8d:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-33bcf861b1amr37444430a91.6.1761342899322; 
 Fri, 24 Oct 2025 14:54:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:54:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/8] packet capture bugfixes and secondary process
Date: Fri, 24 Oct 2025 14:53:55 -0700
Message-ID: <20251024215456.282171-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <250811213632.16023-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
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

This patch series addresses the problem of packet capture when
the secondary process is sending/receiving by using the same
mechanism as hot plug.  It also fixes some bugs on shutdown
of dumpcap (and pdump).

The documentation has been updated and improved as well.

v5 - fix signed/unsigned mismatch in RTE_MIN

Stephen Hemminger (8):
  dumpcap: handle primary process exit
  pdump: handle primary process exit
  pdump: fix races in callbacks
  dumpcap: handle pdump requests from primary
  pdump: handle pdump requests from primary
  pdump: forward callback enable to secondary
  pdump: remove use of VLA
  doc: update documentation on pdump library

 app/dumpcap/main.c                           |  14 +
 app/pdump/main.c                             |  16 +-
 doc/guides/prog_guide/img/pdump_overview.svg | 135 ++++++++
 doc/guides/prog_guide/pdump_lib.rst          | 183 +++++++----
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 lib/pdump/meson.build                        |   2 -
 lib/pdump/rte_pdump.c                        | 320 ++++++++++++++++---
 7 files changed, 550 insertions(+), 125 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

-- 
2.51.0

