Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14198CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 285244067B;
	Tue,  4 Nov 2025 19:09:35 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8507D4065B
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:33 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso2539878b3a.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279773;
 x=1762884573; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCYjS8lCU4ey/Xq/QimMFCgJnsxEn9LlKb03adqG16o=;
 b=o7I7/YuTTfpotZNgQUQRMDU40iOuGRKyR5z1oNzU81L8I+ucaDYP+l62lIU9mglBpO
 tmSgU/jX95mFwDxRvoqoL2AJtGEPgtyf3qYayF4r2AsqXvfCjKUxUGYGBlbzkyYBjoU7
 MM+r0gO72uEnCjf7iTBFTxVu8hK0b/EmuK93q5h8arL1oEEkj1Ha5H/LbmJOxEcyDDCR
 5Tt4L3vuFpW8okFNFOZ16VBkvyGWv2D0fs/gvSREWKnN4DOJp63NcOH0HnLXxRHycD2h
 zEB0ge9IvgdhB+uhx4lco97yN8iI65VV1aHcwWZr3Y+hE5OWqGJ8jJNxMtHX68U5qxH1
 BGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279773; x=1762884573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCYjS8lCU4ey/Xq/QimMFCgJnsxEn9LlKb03adqG16o=;
 b=MxzTHK0YPw2OtGDDNPksIuF5OJAyAQFVdrNs9p1OvbNa0w+m1/dkl+2phSHt+KoJeu
 lJvEzpOUTH/j+OZD3/YguzxVDJEfu3F4jXqezN9HQuOA+3iv4f+nnhLljv9CQlPxC8kH
 nj5hEKM9jAbtnPS2y3XWKdbBK5AvfTH4Y8LiCTEX6o+JiEBE9YZpmXzdPXI0aeJ0ioL9
 0ThTw6oCVyE5VYguxUEgJOdi+fkxM6JgBaEa2Q5aMqXaZCUNK9ca05pUEDtVnvafMbTu
 Ou/xunLbOVj9vt9feWyp1NxaCq1z7XFB9c+v69iHcNBYAUtG83Zci2euwSZyaYMHWi/3
 t10w==
X-Gm-Message-State: AOJu0Yxqy+SJvBuUS8C72hdgX+wu8zcuh2ck2f47mpBcsSZHhEo3oESR
 fBiRCIde+xU1rTs8ZCwlcK6ISrfYqh+mTpwEAPBCJXbD417ohUDv9UgyZSh7pg8xL1IL2MD2qG6
 D3nX7j8E=
X-Gm-Gg: ASbGncthloOlHAhgDxbPZthceTHk937hbDd9KNJh00barFNJ8+5VrzcIj/MdMdXQWU6
 UEGoMZEc3EinBqT8B9u0Din9mpnpNGpYPG8Sw+x67ZfICjpTx3JOr96BHnWSwKRmaB491Zf/yx0
 6ZqCHZckR+hHIbUNUTEYwvw8kCnhFDHVyDdFdalOE3lga/SpCc5xl7akIKQUaXp1KYqQMqcTxSz
 9Fl52LcLSompRHIy7JvlI4cgu0VouCrgPp+bJn/OVzEr8YDUcge9MnYRgk9aBW441u0bOLgUcju
 onVu1DzizptpbH5+6kbUKqRwVtdAX7RF5e7Lo4UEFghC9ItPCOLxRyK/vT+EXSuUi2bU9YIan0Q
 nTrGFVSx7eLROZxGa2skcpHaAmtMjZ7LPC7xfpojmGd95wBaZJRLvtZBo7A/WhfhftaY2DDuu/X
 gqDUNY5SsF193SOau7vTXS66fKZ69H1S21EzJczwU=
X-Google-Smtp-Source: AGHT+IEYlTuDbKeh5HNkZQt+84UbVONdsd/IRueYhp1NbhC/XGdWShReIpDhBQPvg/4XqWwgzdAwWg==
X-Received: by 2002:a05:6a20:958f:b0:2d8:ce9e:87a2 with SMTP id
 adf61e73a8af0-34f869e8df5mr191272637.57.1762279772717; 
 Tue, 04 Nov 2025 10:09:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>
Subject: [PATCH v6 2/8] pdump: handle primary process exit
Date: Tue,  4 Nov 2025 10:07:06 -0800
Message-ID: <20251104180927.403355-3-stephen@networkplumber.org>
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: a99a311ba101 ("app/pdump: exit with primary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/pdump/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..1741d7e709 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -1028,13 +1028,15 @@ main(int argc, char **argv)
 	dump_packets();
 
 	disable_primary_monitor();
-	cleanup_pdump_resources();
+
 	/* dump debug stats */
 	print_pdump_stats();
 
-	ret = rte_eal_cleanup();
-	if (ret)
-		printf("Error from rte_eal_cleanup(), %d\n", ret);
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
 
-	return 0;
+	cleanup_pdump_resources();
+
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.51.0

