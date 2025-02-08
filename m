Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8990CC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 916064069F;
	Sat,  8 Feb 2025 21:32:22 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id C1B7040697
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:18 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so4822091a91.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046738;
 x=1739651538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QKOIsIbBy5fZzwp3fIEtv5TDw6lojY01AbuNT+Qgk4=;
 b=y2XXY3BR1SMXAofF4lL+O0zn6IUpq7C3bGa579TkPtA4yPIfEVIPOHv9EPKCclmK22
 +8GDXkDhpI8BMaMkO1kwvxeFwlx665x7guRNDF1SyowwxqFQRmwmsdfTkcO6oiVQvuMS
 CZNLxkYRg/PQWIv0wklUn3odWG96SHjItGTGEfLbgddtdBVGALIki93CRNY2QJNFsNu4
 0Dj+No4DykWbrjijDSZZhTXwm76SvOeajEdfgOvFSK7c/RLnu6dM84rJYCsNArcoUvrO
 ZJDcoZEKdMeWUu0HvtZYNN13hxyIGO5fN1JmoyECkY/x8mxcHal/kQnKBNr6KV4PTpsM
 M7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046738; x=1739651538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QKOIsIbBy5fZzwp3fIEtv5TDw6lojY01AbuNT+Qgk4=;
 b=N++3pW7GQzp648YYoI7lGr91V9qIS8NeA1tExHtqOSguJgCoO3gaBPv+bNAZjqsgzX
 q6dYoi2eIKoFE5F+JgIGEa3zp/NgnFg5tpPK6EkZ5NiS/rQVsyT5RJvOmrgelFeVZK9N
 MN+6UniCmJGF0dPRSeEJ8H6ZXNz3OVaZQijWCO21K8lGTmOU8S5iqTdipuldmZi2NaIH
 wrNyRQAzGZUNP7RVZhivKrrxCPblb5wcpnfAFI9PJSa7A0JQoHnz8m31P1RZgOdUzWT3
 G4+BuAf2vv9okZo+04G6gn9LRRdZt30UCQLuE7ZlvmtuVD9UvxC9h5dvfop6KIsVeEOw
 TYqA==
X-Gm-Message-State: AOJu0YzrvYOjAYjrnTQYH2EumFLqLaf2/ay0I83S4PNR9m7LQUOAOhpY
 +WtJhMx9YPYiE3POYGRhRrzRatnDdYCBseABboy2zGPujacjxI/eadBbFoOV+3I6nD5/+hPtOcI
 TMpU=
X-Gm-Gg: ASbGncuRo0scndVciz+n5rFMReCPa2FpqnSZIWurUtbb3tQn/2Jla1iAig2SNFg3l2w
 Lp1lIDZFvElvBDxRyi5yUvbb8QT/WQoTWZ6ztlbiODs+eNM9qTUd6a+4W+aEl5xoDYxTAqb32H0
 yMZixwaldlHlj9o8drNLJMfKRXeeYIxwfHfR+nfQOniYNAikhfTpA51SlKdXl/kVF0anGkDH8h1
 Dq0Uh4RZChEL/e0G4XWePEmAxrTU0LF7Tm+8tWUDqWeYj434Ma6D3Y0knhaTwIJXsT7kvsqJb+K
 M5OQidJrZCG5Gcb/8+OAXb1cAuxvFDObchbSdj/EIV5Gtgzku/QdZaKB17rDcZdNLhUG
X-Google-Smtp-Source: AGHT+IFiihp5EMl4crO0YPcso17doh8fwJlnZfc7/vvrNuAlzWQO8NGHPm4tqZGQboti3PXfW1YYxg==
X-Received: by 2002:a05:6a00:340a:b0:72d:710d:611c with SMTP id
 d2e1a72fcca58-7305d525de6mr14940188b3a.20.1739046738039; 
 Sat, 08 Feb 2025 12:32:18 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH 20/32] net/enic: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:12 -0800
Message-ID: <20250208203142.242284-21-stephen@networkplumber.org>
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
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index b755b15d92..82abcde322 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -1238,7 +1238,7 @@ int enic_set_rss_reta(struct enic *enic, union vnic_rss_cpu *rss_cpu)
 	if (!rss_cpu_buf_va)
 		return -ENOMEM;
 
-	rte_memcpy(rss_cpu_buf_va, rss_cpu, sizeof(union vnic_rss_cpu));
+	*rss_cpu_buf_va = *rss_cpu;
 
 	err = enic_set_rss_cpu(enic,
 		rss_cpu_buf_pa,
-- 
2.47.2

