Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E53C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E517640E41;
	Sun, 18 Jan 2026 20:13:59 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 7AAF940B8C
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:57 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so852425166b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763637;
 x=1769368437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ezf5jUEh+BDxKGz1t5vFHh8bXUsETf2TshnEHd+cNJk=;
 b=KhFkxGvuQ+rgJuYQvZOTyjCgBqO2ytg45/bdCBx5sAOsblP9hiafgbSdNCEPBx+HCQ
 bFTcsHm5I0VWJPIL6J0M6ch0LUwDGRf1BuzY6+2Bv578rLqFrM1x3DVvRbIq3r9DyqGB
 qsiU7ntX3BjwmmmAPMl7Bq8QHaKYgKJneqVwowBF3KMj7vi6HGpKf+YeTYAjHsbj2Ff6
 vamsFmJ757CaElClw5HkYXXAblS/VxvXp1/LBJ9ewjZajB1GRzwPXlksnxj+7Vh2F6iW
 cQsYtjXDF4FqDJGiksGCzZr3Tqm748vO0Hh6T7pqISYRUZiA9AtuEbktFaj3dsp2zLil
 3/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763637; x=1769368437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ezf5jUEh+BDxKGz1t5vFHh8bXUsETf2TshnEHd+cNJk=;
 b=fVxSDFfZyzmXxhm4dw5EZBRluLA+csRJtvwS3FaMpCQ76LayAoNhm3foTwSYxtrwr4
 0o/sBFfe4LtGvDiHNmoVEjVVgbodPBHbujIwuXhfrR1iKrB7ozSnDL6yVvQCG/TDqXHG
 GAOEqXX0jEY+MmsNjNdubRJr5OyNYzluaWoDKB7hV244GhvhCSyzVWWKd/ODLAAOQGHn
 vPeldr0q/XYVI0dftIe0xqx56hpYi+bRPeWw2hPzrdmW3FUo7SmIp6oWv475QOgFaG6u
 AhDtZirtYp9vUqFPKewjhnX/oC2n3AzGNXIlohs2zmo5Q/ytrwTnPj64hZuxzsEYjyY2
 T/Ew==
X-Gm-Message-State: AOJu0YzAUwoTOsMK3n04nNvOrKICMLCFhUT30n0qSAu1t5BHPMN7lews
 K2XoUYLPhDzrWIqXdbW5x5robiX0omeePK/OF20UR0QEVG2VTtuCk7ZSiVn5snfAoJuu72qgSCr
 zqalt
X-Gm-Gg: AY/fxX7aNPt2/HH+3+YwG8qS1bvWi+VaeTl20Lq3TXKCqYRiD65+V5+rVMg3AzXbk+l
 Qasw+X7YBoyT+AUxBFwfSz8ta1IVkL2FbbLTTNs4e+Y11ZMUlOQ2cD4FdeCpBWkgAqvNlU/03+l
 BuXIVlntBl9e6hbavO8cJIB56fp4lzFhMw91EJf9dmYk6ychzbG6KLP1w6bpTwU9fqhA6bP/yAU
 wZWMoDxOv16Sz8OcG4ekLECUX8dH1toYVDu1SO4gS/94GnPE3/2ZEjOUgOsNeWMYb/db/o79BOW
 b8hIzJx9qIOu9PlT9PsnhyV1cfu6RYb8Qc0j2GrLpV8nJ0nj43ldrZLoBHsFewyi4kL2A8nPfLy
 M+caSU+6vIq1RbMplmaCgwNpgmWPI3ageySc9Hg77lAmtwtQhRq2HKuk/7zknmpDI8JgaDJGcE5
 GkJ0FeOPHDjYY5tWW73AB/QQk5tZpp4fWu+97XIidx4Q/Ko9bd0A==
X-Received: by 2002:a17:907:e117:b0:b87:d722:ed47 with SMTP id
 a640c23a62f3a-b87d722f190mr65587166b.48.1768763637077; 
 Sun, 18 Jan 2026 11:13:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 18/54] doc: correct double space in FIB guide
Date: Sun, 18 Jan 2026 11:10:21 -0800
Message-ID: <20260118191323.241013-19-stephen@networkplumber.org>
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

Remove extra space before "the" in API applicability note.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/fib_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index a81da2d491..c357dbc4e5 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -12,7 +12,7 @@ the most typical of which is IPv4/IPv6 forwarding.
 
    The API and implementation are very similar for IPv4 ``rte_fib`` API and IPv6 ``rte_fib6``
    API, therefore only the ``rte_fib`` API will be discussed here.
-   Everything within this document except for the size of the prefixes is applicable to  the
+   Everything within this document except for the size of the prefixes is applicable to the
    ``rte_fib6`` API.
 
 
-- 
2.51.0

