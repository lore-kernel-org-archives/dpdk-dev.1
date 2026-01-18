Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696AEC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF2A342E92;
	Sun, 18 Jan 2026 20:14:48 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 5B0EC42E81
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:47 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so600133266b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763687;
 x=1769368487; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYOEbMgQuQ3CwA5b4Jfv5WPGFYtvGFdft3XKq/vO5gc=;
 b=zOY51j8QSQehY2K3HiJtuKlj1335z0HNZ3nFYMYRwhOIuN1nFjc2lvnWyfWfSNJScG
 K3wVp39z0T7zSzsjmibbFv7/4K5W+WX4RBHaO9zv1PZBN6kp1UtejS+d5EZcGW7hwV3D
 3u1y8612baPsgm1usNuTRX2NAPy1c7Ytgtn7Qqlv5oW+qlfvXvKtcbXbDy1p1K9g3+i/
 Bhw3M8sfaMg1mZ0qrvYWwLzHrUX51DFduN0IJifsrCWNInWqw57p0a7aI1Q0EV5r+z1P
 Sws5cCQnCOMOO8L35SzfvJwNdSQ8YNQON3uzqYlkQ61+RWKSrKsQ4Rk39nxLjYK8RYxj
 UHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763687; x=1769368487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gYOEbMgQuQ3CwA5b4Jfv5WPGFYtvGFdft3XKq/vO5gc=;
 b=OVr/0v4iN4mVNTi8X/ec7Z77GhKQgts9GqTHEgYqcFMQjlnTmFKHNThHCohRobOmp2
 qqjDrYrgm9gWPGkQcYUJ88hhBhi8b4SFir6Lr0YxYIT4XJjhay6DtWn/RAla2hYcivg8
 jfIAMUoPfU1+SYMRq/TsxfBccZ7HWAKNIFq+r00GkhbJcYEDBnu8V13ol+Tw8828pFbb
 hEjXwIKj/L2y5pmooXGMDJ5kKcErkz10K5XkMF/wcBDbDQ7X0ZDAKuJbva3rs67uIOdy
 eTaHUfJhAQ8LkrflHQyXwGjG3OLYyigvMsyYyOgS4etp1vMW5pJaN0wUtepemx+5g+mZ
 7Dgg==
X-Gm-Message-State: AOJu0YwZrauEZb/QDxM6CRfJ91VTi/QNNXh4dpFioyTbn4CIYsaDu68X
 1WOmSRt7HvNKGOhG/RZbPPl6rxa9jc013YMujv4FQawbfIEFaefFUomabmL8C/c5/HaauNK3B0C
 YnlXD
X-Gm-Gg: AY/fxX5C92Zu2ms2y5h6Adsf2oFnIZQyqUm1LlAP9GTHGi1cyv1vo8MBV43hs2Rufm8
 g/SZX2vw6bsDGW237Tlz7sedVcgYUvKC/C+Vx2jmF9r8Mn6BE9MjbjA2q2VpYrRlF1rxjTvwC7M
 O1iZGUrzeTlj8iBFZxaSat0RdUD1efWtAAmdhXY7Ze2Ik5EAaiwbg0D11cpnzXdxx0YOxFA2FhG
 +p6enL3tuoIrM4ElP/jGVGCN8AFrCaYXDFP8gUXimADsvA2VR5qeZPdLcRMlYpgVIXR/2VWXA58
 yJ7NeQEs0FY9ok2+nYSFAM8YBvZDmrRXDpiqUkAdjQgWfNw5u6vs2I7nwO3lz2fAtmtyXo0tCml
 mAIcFmE+KmiU7PsHDeVsrLyPxQQUXwLBtw8QXHmqdeZZeHUCg3WZY2UeRWj7Fe4/GF3jIAmMBrV
 rKo3uXkreOJfnE+QSbLgx11MoUVddxNhbVuFRgf2Z5WQQRxkiWwA==
X-Received: by 2002:a17:907:60d5:b0:b84:40d3:43c6 with SMTP id
 a640c23a62f3a-b87968a9888mr692102566b.11.1768763686845; 
 Sun, 18 Jan 2026 11:14:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 51/54] doc: correct hyphenation in thread safety guide
Date: Sun, 18 Jan 2026 11:10:54 -0800
Message-ID: <20260118191323.241013-52-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct spurious space in "thread- safe" to "thread-safe".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/thread_safety.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/thread_safety.rst b/doc/guides/prog_guide/thread_safety.rst
index f7cda8bb32..e3e1a567e9 100644
--- a/doc/guides/prog_guide/thread_safety.rst
+++ b/doc/guides/prog_guide/thread_safety.rst
@@ -11,7 +11,7 @@ This section allows the developer to take these issues into account when buildin
 The run-time environment of the DPDK is typically a single thread per logical core.
 In some cases, it is not only multi-threaded, but multi-process.
 Typically, it is best to avoid sharing data structures between threads and/or processes where possible.
-Where this is not possible, then the execution blocks must access the data in a thread- safe manner.
+Where this is not possible, then the execution blocks must access the data in a thread-safe manner.
 Mechanisms such as atomics or locking can be used that will allow execution blocks to operate serially.
 However, this can have an effect on the performance of the application.
 
-- 
2.51.0

