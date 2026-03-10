Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7AFCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B930D40678;
	Tue, 10 Mar 2026 03:49:32 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 846EA4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:30 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d73d6976adso1720666a34.2
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110970;
 x=1773715770; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7GlG/KJ1tj7qnEpgY/TO1m7JeU4M1J6zwlDzF+0VIY=;
 b=1HXp+KCDeMxjYuuD2dWkVteXTPXxuLOkRGMANC2VrLSuLIRT0bmLkhSynYKuDLx9fZ
 rUcdgG87Xerj0VfxgM0ZAjI1XUCFpt9arhFXN7fIb3ULIcribS9KMP4sWAsYGzhfvxgn
 gieQz/7bY39pd3ZtqyubjdRpC4vvhG9JfS1gJWikZ30U3JSxESSifDRWpgvLt2LctflG
 OtEXaJfWomxGjqUaGiqy/r3QaDmjVdnkogRD+L8yUX7SZdtBOSEmwqqPvy6tejLY6rlh
 vW3Xk0Dx8ucYzvlTG33v5UtpvwUWkT5iKrdGQulxTuYtiybtJThahmbiyNYCo2Ia4JfD
 S2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110970; x=1773715770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7GlG/KJ1tj7qnEpgY/TO1m7JeU4M1J6zwlDzF+0VIY=;
 b=YUsvad+doVEyZK7ZLWkJHp/0KpdKkF/XDINd2NJKSIGqvXRZnVte091ZN3+rsPzJSM
 HQd7aDj4ePskyS4P2SE3QaHhecPSH/JYovSSpr1j/7v/Q6v/7VC5KpW6s07lvrYM2i7S
 vH0g7PCsxlQ+hnk81DJbEFq7SeJZUyMzsluCfzGzJytlyZuuXy+1Yu/Y5/l50OqQ+hU9
 7wDQ+spd1NsRIVeTksoW8GKQoBddiiZZ6j+UJgy4extOW0M9Z4N8BItL+9B31ZGblYLR
 uX2HU/mOsTLbdU025WMRKpQ1WX4jKe2oebAblCdpfhupM6M1zvBkhq55mHFlpBQ5P/lD
 Fzvg==
X-Gm-Message-State: AOJu0Yy5+ZfATFe90eQa/12Q9XzMlpPVxH1GWUrnRGo6aL/tvo5KGzV7
 X9skb4EzZ10lYt7Y8Uo2xEB77qTF6lvnmAnt05765lg6GCgl181uYut+xTM+K1lUe6JnOlgGWUN
 1cZu/XAM=
X-Gm-Gg: ATEYQzzETl/ywj4dKfMwQKf1I5VxSnfTGvKE3q9msgD3GQM7LJ73B1dVGqrV2Bs3cci
 CslTS0O3itu2tptaB7U8X15KsFqUCsPqYp2Uxcvg8vouGqVKg/3iOfDx9E3mN6ip3j2TfPDkaOQ
 XU4eBml+LRBo/ArbL36nJi4FJG43hiRvWtWyXAXmVfMp9Q8/KBhTxj2YUubOIJDa7IDbsB4Dv3f
 TvzMAuPEXJKkxkVi88xmRe/7vxGDAyPXIej/4oqvt8YIbgNyKkucVBGM2+k6cPJJceqnC6WvN/k
 v5qgPYVCZkbeduBaiyKANNHm5SEMEWCgWOW7KHhPjBbM8MtaeTloyTmDd1P01sT+1fb0IUscBiz
 B9WQm+eopKMMjupj/gs01m/kqCVyLhUSrFYrorCt3h2D5T5N2qSJhX/F9HfIoEl8uclcuf8LuYB
 gJB3gBpmcs5KxcGk51XH/n9WEt1cxBpn62
X-Received: by 2002:a05:6830:3901:b0:7ca:c7b0:17eb with SMTP id
 46e09a7af769-7d726effea0mr8830934a34.10.1773110969772; 
 Mon, 09 Mar 2026 19:49:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v19 01/25] maintainers: update for pcap driver
Date: Mon,  9 Mar 2026 19:47:36 -0700
Message-ID: <20260310024925.476543-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eb8e9dc22..a8e375ddab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

