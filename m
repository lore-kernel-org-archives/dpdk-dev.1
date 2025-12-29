Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E538E92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B90D3406BB;
	Mon, 29 Dec 2025 21:49:03 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 93C69406A2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:49:02 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so5314214f8f.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041342;
 x=1767646142; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=f1+r8gNy2EKukiDCk+hMGuZ8pSrs8hQzonryrL8drF7iM9gFIepMARCXUgX1p1xc8v
 wo4cKVF5smek2GDgZh44WVPuEtgbd8Eear1oxcd5YpnEHUKopAJu6r1wkyXuPfR2SoAG
 7cXTL3XAC7oqekKVeQsocHcZdTlGk/uJi4kT3qEyUkPwna554jVmwYVlMlHxYpn8P/a6
 hUeMCr216LJFv9Ws+Y15YIw/4RRkHcX1mjJlAM/lBYZUb0nzaxQFRUMaQ8ojiiMbeAGF
 FrfUZWB6yA+6lwbKNw/OGJjNnA4kdW777cXaFw5mfwWkZCNpdEvoF5bScdVTLTtm0Na0
 d13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041342; x=1767646142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=NEVCSO1ddOWw+z/UcyzfdbvJGRon25ZQE7k6pAmazK/Gp7H2mv3RZuDLYuPFOh3FB/
 SP4OFO2hJ6V6wlNdk2aHu+t/PB2n6Ovqjl8OZ9NATG73zOQdc66zTY6wRJojEMbpwLR3
 pF6V6Zb9lnSW7hP9JbHhBwpXxb2a+Fh/p/d8PtfHNzjBAM8qt6djD6U9/8C7ne0qGPNO
 9eWZNyeiIjCsxIz3FpEBj0qrNYhvaw/dVr9xBB7kjr6eDzMDVF4isPNxoM6GW/SBqcf2
 8SNbiAeXk4wncdtc0sO4qJeCdN/YrkFyDWm4+FuYkSyAqJnULq19t6EwjN3wq8HxBS09
 FPQg==
X-Gm-Message-State: AOJu0YxZRROso/DxDVIeBmmoFgdf9Mo0EHKuLYFeQ4gKK9tpx8f7By6C
 HNwSTa/jMPxFT9ATqZkHjnZpuD4CjZz8mnEthpIFgNHSjqv4WZ99LGy2vdrazo1RgMtnExkOMz9
 jAUFBOeo=
X-Gm-Gg: AY/fxX6YtPa32fVQs060C1ib/ewV04c8uvJcl7REQKg8QbHUWLrwVs2mrpsxvBpVsnd
 hv6quX+sOlr9hdkEpVrEWT0QqK6lPl2oSk4AkQFQEztYkG5mq85usOrT6EJ3D4rZ0GmFh8RSp2i
 VC7z5Tu3EyrLOAPKH+uHp4OdpYmz5wXkT+Zzoz6+vHe6eot7RfhyxK7BFu5bYj5VseQCi04prIB
 yxnJABec3A0Gj3JZVqeGW0waQs1dZTRch5UZ9X6ecznADAA2dyn678su2FyFSECp9pRArXuMkTe
 Sz6xcqSeFWVB1H3gmLzmWkUAVnOgWpxBZR6WMCXt0t61RLcBjHVNX0NO8medBDDCfJ8D2aSuN6o
 RVEjdA3tbEnHx9+oNvDvpEpAoyMzWIvWjo44HkM0qerhIqbzA072AkQUntFJgzeV8f4LOCqzQ92
 mA1tq9v/mdVFlT13ptU87k1KawQ9KnrXbH4illhv+jMmc6CkxgKw==
X-Google-Smtp-Source: AGHT+IFse643DZa0Pj/gNntfeav0YpY7rv7ZZwtzdEjS7lA5iyG1+FKwRjoK0c8hwWth38O2WE6qYA==
X-Received: by 2002:a05:6000:4014:b0:431:2ff:1289 with SMTP id
 ffacd0b85a97d-4324e4c9dfemr33371002f8f.16.1767041342197; 
 Mon, 29 Dec 2025 12:49:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:49:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 18/18] lib: enable format overflow warnings
Date: Mon, 29 Dec 2025 11:38:16 -0800
Message-ID: <20251229204818.61231-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

