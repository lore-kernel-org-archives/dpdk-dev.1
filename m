Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0235FC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8E6140B90;
	Sat,  8 Feb 2025 21:32:27 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 374C340A71
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:23 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fa286ea7e8so2560777a91.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046742;
 x=1739651542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBZ/zHLIbHgctJ6u3DxdG/kA5QApjdDY0ZTnoZTw5wk=;
 b=cbh21FZu9OEypd8UVLmZv7zLaiEpdcNzgY6Ks+glcG+OBTlTjcfnW/zb+x9QgmfHsK
 QS+85um8VP3BxmrHCZR/AS4nVKGO/dBnGlmKI7x/3bkUYp34ivC/g4T9xjYMWmJR+ko9
 XoDCW3LOIONs8muayL6vQ6ow7ys64pyZhqP0uMtqOO9M1l+cLYqbHDb2Uc3DWsVUbNZD
 6EmnkPWFLEgYroyH/QW7pYGWerPN0LDOPIB7NYoFV9mfcf9/x/4dTbbedU6l7HOkDzET
 yC5obKvuyoz69Bz+elEKK1or/3BYuYNlH+tuxO5tWkfD9hlQsGeRK+kZ01XA3qrQLgxg
 dUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046742; x=1739651542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBZ/zHLIbHgctJ6u3DxdG/kA5QApjdDY0ZTnoZTw5wk=;
 b=I4K/XS4MV+ZVmYvyGT7Vd2eo/dP74wOtRuUUzqc5/iC7qgGGj1k4QP7+4rJ7MhoGhq
 RyIbgfcaRLGIZ8u0dRq/7cBlgICX59DFIOka/2+bZLtWol6q87pEFh4gSgOygxE+1nrE
 Z6ljgr1wPiCqsCKUsZpEEy3C0pJdFQ8MuA6v1y37vAxvBwRlH+n7fVzaImz0+pc5pJOv
 sS9HcHRv7Osga0N9Vs7UsqBNINZFOWqZfoYGR+bpgCqT7ObVPz6qsCfA3tqpBjUca/Y6
 Fn7Lp/nySwGlc+pwIcyvSUP9TIP3N9wVNtXAtdnvEXMqidnUwIs7cJmzRfdubxxm30Pp
 Zxng==
X-Gm-Message-State: AOJu0YzERhYhN7gIzhoP0h8T9PaTStar/kcrvlSYfd4+z7E/nLJrrQMv
 d3ZvuXGxy5skBEGE+FbO7Ek2Tljyz9e3HC/rUifLsM77SvT3+by8NKZeJ5Wo4GzQUMBP3au7G9/
 gWZ8=
X-Gm-Gg: ASbGncsSDpUsnTSx41j0gC5BmxsNGabBvav//W5ytGab45+hXKmWKvifjOjNOvxWm6p
 fRcXSp6jYNQCtTjyqmrh8HBG8Msqz1hriLOZMGsXWYU5MromyufVdnim2VK+Fs1C3TcBAlWOK01
 U+dmfG0Ap0/5ZWnCWA2Tr4zpbHZOdyFPC+J8qYs+VtNsMd2Y2cXg3KnZpr+hK0v0acE3ux7Az4b
 3fmTUNcpKTbq3uGE/Fawl2zAvw1gGfW+oHJ+NHyPmz36DuNzN/1PKO/GwNATmecV+v7ujqx+DPs
 JrIkMWz3N/OShLsSYQwS+2wGfBm4aqn+xw4XUquYXTsZNZBzUxaUiAZZ9+Lc6vPUZpeF
X-Google-Smtp-Source: AGHT+IEGIKKFGCcIdmaBhb3WOLh2wdtCkd5owUp9DAATt1CGGsetPbA7J7zpDDr1zdcjc2Vxb6F0QQ==
X-Received: by 2002:aa7:88cb:0:b0:72f:d7ce:500f with SMTP id
 d2e1a72fcca58-7305d525eb4mr13082696b3a.21.1739046742269; 
 Sat, 08 Feb 2025 12:32:22 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH 24/32] net/bnx2x: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:16 -0800
Message-ID: <20250208203142.242284-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnx2x/bnx2x_stats.c b/drivers/net/bnx2x/bnx2x_stats.c
index 8adbe7e381..b14139c052 100644
--- a/drivers/net/bnx2x/bnx2x_stats.c
+++ b/drivers/net/bnx2x/bnx2x_stats.c
@@ -805,7 +805,7 @@ bnx2x_hw_stats_update(struct bnx2x_softc *sc)
 				  etherstatspktsover1522octets);
 	}
 
-	memcpy(old, new, sizeof(struct nig_stats));
+	*old = *new;
 
 	memcpy(RTE_PTR_ADD(estats, offsetof(struct bnx2x_eth_stats, rx_stat_ifhcinbadoctets_hi)),
 	       &pstats->mac_stx[1], sizeof(struct mac_stx));
-- 
2.47.2

