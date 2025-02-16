Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64289C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 16:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CED840A67;
	Sun, 16 Feb 2025 17:08:49 +0100 (CET)
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com
 [209.85.167.98]) by mails.dpdk.org (Postfix) with ESMTP id A0EBE40A67
 for <dev@dpdk.org>; Sun, 16 Feb 2025 17:08:47 +0100 (CET)
Received: by mail-lf1-f98.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so3771770e87.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739722127; x=1740326927; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFhtqmcqr1OkrzyWug/9cVU1zdzPSo7kuIbFQVP4ksc=;
 b=RuTRs0oyAeVXswzGn1Ikpx87ta8Q08R6imf1isHCNDY9ogsmIR/gtrAlbiqHcadKwk
 OK7eevjTgIgUhywZPqfpSkpk0nwaHo/VNzzgPv1b4Gby4ojF8QL3toiNJWDvql8VWB33
 nowsPplk3jXAux+syOHaIjqPd17haQcG74PfFRjARld1Qosa7PnHKPB9qYRV/UB3auCw
 pev1dYnwCa+L5c4UbTNFmgJKK0hHeXZ+QzoA5Ay7hmHIaAG94uoSFsxKgMSANYN4o2dv
 /t4xFF+4vW/FpTqaXnVZAgmdZ1rQg0mFjOpT+XzQKaChNHLXlSTwhh6iMujv8rDUHnB3
 Albw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739722127; x=1740326927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFhtqmcqr1OkrzyWug/9cVU1zdzPSo7kuIbFQVP4ksc=;
 b=ZOv7yKNbGN9XPHoDMmpbZK3e5MJznNehuhBG/AEkbISZXpwl/NfTnA5QMmB8JUMvMN
 d7sXvpmz0T5YACn6W6Ck7Hax8IX+Jrw3wpRgyhl3eUBerNy/HxxxBD0X69nQSKQWSYvs
 FoHQOabKLBRdg51zV3kbllRYbMWsXTIpDPTAXY8bIupBWSWLxfFGJ+CLamGo8OyyZ0dF
 aJGmYFtqiLzW4xtCEO3X+XUtYdlkbwy892/MrDmPcpJhJz4ccimM91DOAHGoFbE7nMRc
 t7dQigQYSyXorJn3bGNIylo9B1tMXpjGeeywOdQjxptxdQubriKk8+ymfPN4YegPt30w
 89Gg==
X-Gm-Message-State: AOJu0YxwVqUGZAOs4QEy53NYs+/Z6EVYSDJah7AeV+MsCSbYRSCoHP2d
 klu6lgAIXOD47wHd3Jk5grmnvHY+rJD72WobKrlxn2qlALO9shZBtmQNZLCsJ73ZnMVNPjCeURp
 l+QTLNVUtJfbfiMk0yGxgC3yPbsuS+HkI5BX2oQiW
X-Gm-Gg: ASbGncvbl3LbMFm6BVDpvpFe/ef8X8UDOHoTwwiHUNThFdXi8J4kIM3skgFhZx1XbF0
 ExGHhdk7qzfeZzGCfDbUATegWBnlbJHX+tCc6Ny3zbHkJkFgbI4rMayVwsp79pRocGRWXNHxm3a
 7jYAKZSUeyIaRmsK437OjgoPQP2tsuZ/MmncJP+hrrCR10LIbLE2AoLIjLlc+MTlpZCLa3TaHsF
 CdemE9Ua1K17kbvJvn6Bj2WFHZjFJko21rHZ64jEOc/nx/UF/OzKvUGg5/8CHOs+2NHKGXXJeke
 NukNX/B/1Z9yVaOd0m5kOL82bu6iRkHj5QV7YaERzeCAmuPMgg==
X-Google-Smtp-Source: AGHT+IHroqXXfjhLABxpnuPfTIGwcrKwwn3VuRGoL5sG4nbfOjN7e4ylsBvhmWEFYtOfy/SJGS0t9bQFM/7b
X-Received: by 2002:a05:6512:b12:b0:545:a70:74c5 with SMTP id
 2adb3069b0e04-54530327a4fmr1889556e87.13.1739722126819; 
 Sun, 16 Feb 2025 08:08:46 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-5451f0b2001sm393475e87.24.2025.02.16.08.08.46; 
 Sun, 16 Feb 2025 08:08:46 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 6E16D11327;
 Sun, 16 Feb 2025 17:08:46 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH 1/1] pcapng: fix null dereference in rte_pcapng_close
Date: Sun, 16 Feb 2025 17:08:33 +0100
Message-Id: <20250216160833.3216001-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
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
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
---
 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index 16485b27cb46..efd96a16ede7 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -716,6 +716,9 @@ rte_pcapng_fdopen(int fd,
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
+	if (!self)
+		return;
+
 	close(self->outfd);
 	free(self);
 }
-- 
2.30.2

