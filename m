Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2472C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D540440B95;
	Sat,  8 Feb 2025 21:32:28 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id B7D6340A71
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:24 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fa51743d80so596960a91.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046744;
 x=1739651544; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJU00z5krNB8VFfDBOBUNZuyYjD5XdluTlMNoEB3Gwg=;
 b=2d1ucTDVROSWufHRwy44hIjqix96hce2+ZT4GZ/OwQypML3QpL2ADJjcpzB9Mo6H52
 RRaVjN835mkupjCRIErgyz832xYU+i9zATAHL4dXQz/SDXdKA+wypLPri9aCmMlZ15hA
 cPExufGmEMHeOmHP9gehxOXTp/HqwjZCmSYNsClRORPQgqVtn6jJ8K/X9/ehkMk5nMU7
 gxnyYWhFeWnLBHp6T/SCsk7hWBZz0sIVOOjoYbRs6Rmb371/cn6unJtswbfZgBA3fGbn
 0O/FbF7zE97hGQYu5fhajz8sCG2QLs6LJXo3Ni/qgP4EOlh7Ti2/zLhDUCP3aOaUqY/d
 icvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046744; x=1739651544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJU00z5krNB8VFfDBOBUNZuyYjD5XdluTlMNoEB3Gwg=;
 b=iiqQLiTSWPxelH7UwHb8BJdcKcth3RY19T11ppw+TW6xJ0nHjDTsztujdrhslHIwRA
 bw5Amhf098QZm7yzA9qLhw/4lXnaAgB47+sGWEiySnzvIovDs7aY0TO/j+51c8rZNZEl
 Nh225sbPMywb4hwnWXUwIIbD1EKnyBGrtuAV2+FmiE+eFRHoQppcK0/qLAYwRdYWC/PQ
 MaHYFiKeNBpgDUG8NXVDwsiB9ezhLvaXZRQWrVv4nc6KXg9ZUI6Wz2szMCZgSx0UX1Vx
 rwD7rKVYkQkwbiSk2mHq7t4pero3JjqfEl/Keiab0rQL2h0LsB22t4uIUpb7GIYlAImX
 FKcw==
X-Gm-Message-State: AOJu0YxKoDjfR+Qef6uAKVNbiwz2yV14UnaTXDE5ytZ3SKDROiWlfqNc
 na/Vp0tR9yijzknBDcRs4bwO8vI58Y+yEIxFHkThoarAsDKRjAFIR28a+T5MxV5ZuMBCWI/QW/I
 UlwM=
X-Gm-Gg: ASbGncuUXImJAEG4dps7bsswx7I+PeIP40R/f2Re0ABImLry1+KjaOTnA2Ox1FUZS6L
 ZMQuhe2PZAbkBSBo21YMKlq8MuKXDBmp8iQ1AZqjAHxz01zJu2d4ZdSKdmiFhAoaNaMpyWRgHfr
 LjuuTeryuyPNQrzW5Vn5SoLUbEAAC08ljgDRePanD/I4XuvtoZQMu7y/aXRtOkD7suGZJUpyqDH
 K1xxvoqWTYDtR4mr4ePeAWm3cx3EPzfzG1AlRh+rGFTDtHUug/FnldBtNn/ZedglZjahzNJkGXK
 RyCOk/rBKYq6PSG2bJBF2Kc5czm5OPWvnhzwRYSxOh4lFkD8jmFJkCB1cLSqh2q/awHQ
X-Google-Smtp-Source: AGHT+IF2lYHY2rvg+et+loSg9Nzz2AQeTsoB7lGNXj6FWY8eHEncYHQW28+IHU6veyWnuVR9ZgBzFw==
X-Received: by 2002:a05:6a00:a15:b0:727:d55e:4be3 with SMTP id
 d2e1a72fcca58-7305d463732mr12022558b3a.7.1739046743948; 
 Sat, 08 Feb 2025 12:32:23 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 25/32] net/dpaa2: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:17 -0800
Message-ID: <20250208203142.242284-26-stephen@networkplumber.org>
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
 drivers/net/dpaa2/dpaa2_ethdev.c | 5 ++---
 drivers/net/dpaa2/dpaa2_flow.c   | 9 +++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a9bce854c3..452d58ae28 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2539,8 +2539,7 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
 					      ret);
 				goto cleanup;
 			}
-			memcpy(&prime_mac, &phy_mac,
-				sizeof(struct rte_ether_addr));
+			prime_mac = phy_mac;
 		}
 	} else if (rte_is_zero_ether_addr(&prime_mac)) {
 		/* In case phys and prime, both are zero, create random MAC */
@@ -2555,7 +2554,7 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
 	}
 
 	/* prime_mac the final MAC address */
-	memcpy(mac_entry, &prime_mac, sizeof(struct rte_ether_addr));
+	*mac_entry = prime_mac;
 	return 0;
 
 cleanup:
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index c94eb51ba5..299c50dcdf 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -1008,8 +1008,7 @@ dpaa2_flow_faf_add_hdr(int faf_byte,
 	if (pos != dpkg->num_extracts) {
 		/* Not the last pos, must have IP address extract.*/
 		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			memcpy(&extracts[i + 1],
-				&extracts[i], sizeof(struct dpkg_extract));
+			extracts[i + 1] = extracts[i];
 		}
 	}
 
@@ -1063,8 +1062,7 @@ dpaa2_flow_pr_add_hdr(uint32_t pr_offset,
 	if (pos != dpkg->num_extracts) {
 		/* Not the last pos, must have IP address extract.*/
 		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			memcpy(&extracts[i + 1],
-				&extracts[i], sizeof(struct dpkg_extract));
+			extracts[i + 1] = extracts[i];
 		}
 	}
 
@@ -1118,8 +1116,7 @@ dpaa2_flow_extract_add_hdr(enum net_prot prot,
 	if (pos != dpkg->num_extracts) {
 		/* Not the last pos, must have IP address extract.*/
 		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			memcpy(&extracts[i + 1],
-				&extracts[i], sizeof(struct dpkg_extract));
+			extracts[i + 1] = extracts[i];
 		}
 	}
 
-- 
2.47.2

