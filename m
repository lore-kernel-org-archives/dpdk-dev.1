Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E193FC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6703427B0;
	Mon, 24 Feb 2025 17:40:40 +0100 (CET)
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com
 [209.85.218.98]) by mails.dpdk.org (Postfix) with ESMTP id D5BE042792
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:40:37 +0100 (CET)
Received: by mail-ej1-f98.google.com with SMTP id
 a640c23a62f3a-abec925a135so57189766b.0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740415237; x=1741020037; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AtbEytKxo55iAjaV8ekKqqFZln+jcXYUmALl5RLNuI=;
 b=SsFJoz7iItEevQcX5B8/evHU1D9fGURy8w+3cz3wIWid/ghiYNJT6eVWpFt7pQgO0z
 wF7xF79lYnk/U8gAMvwRI/W/40EQ2BZBQGydQw7P8aMeXpXBUmia1e+YZKwPYyEqgMnG
 VSISdFBtZaJpJQ3I9hZhf52/0HM0PIQYgGM2jJ4x7ekUcauKPIeGG7H2fUGaiXYkNWuY
 cVYLYQ0sdaLF95F2dKXdGUOQg+v4yXc1oSzJoXzapq1uBRe7UEuBWUxKbFgBTDURN8sb
 O9+rtoXyUaWQsQzOfVy9kWcANnZ5VxT059rnBQTQnS/8DBuYn6VPLCdzPgd8HSxwtzbq
 l3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740415237; x=1741020037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AtbEytKxo55iAjaV8ekKqqFZln+jcXYUmALl5RLNuI=;
 b=oAdjluzxD4GO6LcKNC+jRhxs8bpiBMx7WbG7gypMkAXCre4FCVDLlq+QnSHxGqE2ZO
 CX44d04YSGIUUnsVhFG8JzAJMXwQG5Uy46imTPQLZfJFgLkBWq2/uUjMtgVR9bt0yzLY
 WTgKxH9lutk11D0q6PmgjDJM+B4ejA3xz7t9zMftt0aTgHuu8dpyEE8OPSuuEuPACHxS
 /Wv1S3N1QHn1wR8+eAvDNx2JZzQJBHG3tCvklTtqbrak3K9cPNFRfUrnkK4el0G6qgca
 nEGTdkXm3BA/5yUnFhcWNK0j6nW6g97w1zF3H4CbarBiH7SP0Shxv6SU0w3inCkvcuS0
 uI/A==
X-Gm-Message-State: AOJu0YyUDCnAYdPBXWx3n4V5pjOBNwC/KR8wgZihT8jJn/dA4/VynXv3
 3+ex8BGkhRnswdsVu/4yboquGBMlnl1GoVfn/4Y1sAhRss844ij18c3KqdF8gp/jIUGYvp9T9ml
 uXHXi/Cel+vZQpsuNSJyxHdjvQz2k4hgNjUr0liYF
X-Gm-Gg: ASbGncvtJ96SBOF66yLUvw04YI42Bvolr1ehLGlZNikBI23Va/o2mEQVsEaW2UWwlf8
 tcOy8vWWst2tGqfK9guxycxkJH1kuqO4XXgLSyCfGO6W983lUgEasQvswNBR1fqxqaKY5UBvxUu
 48r/3/cDphbxPEzUo+AwZGcy57naIXCruQ4l97mjd2dm7Knp7cGf9sEAazazNrYXPg53ajmebed
 wmutkCClk6lhy5Tn8dApaxCvlOTotGQ/CWk0TaE1PNgznDcbrSUv6PHwlxy1Nn7JRDOE5VC1aZ6
 foaX+Y+9jA73l5WyF9H2gyxj04Zeh+xO982sGpT5/s9gYI4ld1v2RWHK1MI1
X-Google-Smtp-Source: AGHT+IGvS7Zq583Ox/kY2Ho4bq0Y/iUW3Zj5rSiN1mseedJnWP7GFzVy65Tn5G1Fa/8KVTQgiTqU5LtTEf1d
X-Received: by 2002:a17:907:7fac:b0:ab7:eeae:b23e with SMTP id
 a640c23a62f3a-abc09e53506mr1266483866b.47.1740415237421; 
 Mon, 24 Feb 2025 08:40:37 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abeca18aefasm2811866b.222.2025.02.24.08.40.37; 
 Mon, 24 Feb 2025 08:40:37 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 47F3D15754;
 Mon, 24 Feb 2025 17:40:37 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v3 1/1] pcapng: fix null dereference in rte_pcapng_close
Date: Mon, 24 Feb 2025 17:40:31 +0100
Message-Id: <20250224164031.587829-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250224164031.587829-1-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250224164031.587829-1-ariel.otilibili@6wind.com>
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

rte_pcapng_close() might dereference a null pointer; as example,
PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
rte_pcapng_close() might receive a null pointer.

Link: https://pvs-studio.com/en/docs/warnings/v522/
Link: https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a9942/app/test/test_pcapng.c#L438
Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
---
 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb591b..ea68d6180ccc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -135,7 +135,7 @@ Anupam Kapoor <anupam.kapoor@gmail.com>
 Apeksha Gupta <apeksha.gupta@nxp.com>
 Archana Muniganti <marchana@marvell.com> <muniganti.archana@caviumnetworks.com>
 Archit Pandey <architpandeynitk@gmail.com>
-Ariel Otilibili <otilibil@eurecom.fr> <ariel.otilibili@6wind.com>
+Ariel Otilibili <ariel.otilibili@6wind.com> <otilibil@eurecom.fr>
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
 Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b27cb46..66c16ba2277d 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -716,6 +716,8 @@ rte_pcapng_fdopen(int fd,
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
-	close(self->outfd);
-	free(self);
+	if (self) {
+		close(self->outfd);
+		free(self);
+	}
 }
-- 
2.30.2

