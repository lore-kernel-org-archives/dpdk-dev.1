Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C820ACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 411464066E;
	Tue,  4 Nov 2025 19:09:39 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 2D9CB40668
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:37 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-340ba29d518so3031705a91.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279776;
 x=1762884576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0J06KJzDzXhPV3N4fCx7IN8y3PaQHpxuTDCF2EhH3Q=;
 b=KP1ftdfTyfrLSJvOaa6X7MkAZTv0da6syZv15q6T3zMJeT682nVVOXqBq6ZWrf7/ED
 3hX2RXpR3YsD2kZqrFzcHgp3Ku0ngkNynDm0tV7kWen/QNworo43F7x8Jd2hzWj3VM+F
 7bZ1ykb0tBxX77YLfk19Ozdc7pgssRO4jxdqXHzia04xOmMwK597/8fEekgE8TlbddKW
 8jHDgbzjfnG//tJ1ZOjXEIgjE7dJ7U2v4haQ+vxmmJ8OC02UfWOyqek7eSZYWp9vjpZQ
 2gAoZeCckubxkSqzEbNXMBZvcIZex93R2DIpv+ZlcrhLrjlYnJkR3WsKE2I0LWwS9dHd
 ZKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279776; x=1762884576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0J06KJzDzXhPV3N4fCx7IN8y3PaQHpxuTDCF2EhH3Q=;
 b=qCIkxPQU9KIWaUFo81/aEeA6BEFmLUccqXfGrdz/OobCLqwa0ljbO+nBobe/wu2C4r
 RNh/X8IRmIlyhk1EV0MC5Z/HLyTMHtlt5rqKXM0Cr5kMWRxFjoIcmX9MAAk4tzorjqm5
 5kVpGvg9U3tQbUJ1bk606r4AK1GNCCJ7o+OjKSStDzBsznosIfQuxA5XZgJFrxLthw+p
 Fa/Ja+L5kvnjVDCUo6BYCOnoKXZIUASRskE8Ct+EfPEy5mgRvWyX+5/Gph4xO5lkZrCO
 anKlw3lVttGQqgOYTpMIDZkn1E4ny8KafyUNZFjkhX0+ls0qxTJBsKSgJQ6Ufw+lLOP5
 Ta4Q==
X-Gm-Message-State: AOJu0YzUJ5vdWUq5aKDPGXqRndft7/aSi1pzK2WWL6APidqrs6+mXhCR
 SJiFWnoj0jTyXgkPHeXd2Wyh5KeEmQmwMGUy4cfOgZnqLubJCbF0GfANGzJS77cuUGgnt4yUdCY
 NVF3C
X-Gm-Gg: ASbGncu3WK76uoXxzO+W7KNdyBNUSAUBBLcO++f25yha2Cp5u/gjLgvQpmrgVZP6tsC
 gCRmsfXFuFwxnbOg+h4BLGJpFMhX9ouQcRwIIPFRJQKCgul/Sa1I9OZF/3+E4FyC+SzCxVXvfs/
 TqE0XvsUquTEg2DUQ6bT4ed2XE25vffO3dF2wH+yPhUBT3d7Gg9ww699BAGlxeq6iBV1vHNCPC4
 NVOuWBqNAFwC5NnMxIxbeRpWMIIJ2gfTWsKaCR17jvE9kehRE/bF2+X26S+pWBeHPiTZuUhleI8
 J116vj15/x5YOaPWtHlKP9dVjdlwYewbqNLQbX7wAGdVo3dVreEnxBHTcHF0A6FwtmbyUJhAul2
 PZ2Nj+4fccpic8murUivUBkAkf+YRwM4k/V48gtf+JAn2SKKbUExVERWMhZ2e5PNkqqVcpvhoPy
 zxOpV1On4gUq0zqt53wxTXKZXUSJAjykzOyDUgOIw=
X-Google-Smtp-Source: AGHT+IFmukkfKgxJlXvSqu9g+rNPP2G2LpkgAGnbOxnj2CBgLwiCzrcyFcnzE6RPJn09UKFeUhsFpw==
X-Received: by 2002:a17:90b:3e4f:b0:340:ec8f:82d8 with SMTP id
 98e67ed59e1d1-341a6c4891cmr125908a91.12.1762279776309; 
 Tue, 04 Nov 2025 10:09:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 5/8] pdump: handle pdump requests from primary
Date: Tue,  4 Nov 2025 10:07:09 -0800
Message-ID: <20251104180927.403355-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.51.0

