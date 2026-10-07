Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F549CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBB642D2B;
	Wed,  7 Oct 2026 23:41:30 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6D44D427DE
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:28 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e7006bbf77so3090845ad.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409287;
 x=1792014087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIE8w9TVbXZwUeENBy2WYbZbjL00zg4vcWZAr+zyDq4=;
 b=KqP26Fho/28Gck0ZpPqY4zj/D2xemhebKRxaN7sNnYgW+t58/aqTAhAC/HmYkS8HJx
 OzxKifBoXAugvojz7v8ZztNQ2mW3AjmfNYfx8C2QEcpTTpeG+c1NRn0XKpw4HTYFBDcW
 rkiGLk4ap3mxu0kiLnaAVAhvFUyncoJoz9Ad53L4PALc8EL6bha6XH9iqtt05IO4ii07
 B+mQgu4W9PdP2yl5dcblPeJTDFB344T+aUB/B6GpXKq0fv8LT4bKPJdUy9j0DjCcHkch
 jCOsn5pfJEOJm43InOuG4JJ7AfA3LqUBjnS0An4/Y+PQr67bAZ5iydaXn7n5YKsfNtsF
 Q6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409287; x=1792014087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GIE8w9TVbXZwUeENBy2WYbZbjL00zg4vcWZAr+zyDq4=;
 b=cG19QFdy3WjjJx8ZKy3cRV697WpkMFx5zgXYICrouRUP70LIYGg3DppXLa/Hal3SVn
 gaQwrdIrmGufZjhQiirYr2vmfRf8kSTNt06zrgcScy0QlpBAeagKNCNGOKASgJ8lBw6A
 5I9J2rJxQ/3BxFAE7+WEtn3nciMpwOUGVrmQhHUceHilNcfliqVOffC4lNUv0SwRKAS9
 DGyFRdnmjMC/m1Amjoin1ZzEMvGsPLNbOxglXg0+yuX4G1tBjhwSUR3DWXjOrtkWoFCJ
 k3EhGMABUpqmHHCsZwlNFWHiXTeoWt63LmTe/BRdVsyXiKIUMB6T8krnBKFF64zAOEiD
 R21g==
X-Gm-Message-State: AFq9FYLjGbkUS1ZZae7/6xTQt2BfNRX2y4HqlgLaWETSrPNBMrtFtqkT
 kBptRLEvagcphKp6oyYoFM19NcXAiETmA5YjcD19B0ntq4wMRNEb6vHoIha3beU+b9JGgGL9hY4
 gj0HrsxI=
X-Gm-Gg: AYBFou1h955LBdQ4csYFkncXtKNOlx8qvti0oMg8QcYDTYOwEMytmNd5jQ4iuwl6LV/
 d3fLx9zUFJbxLKP5IuozLvhaPHGuZFSn+Ut+NnFWLyTCx20lvr9NQ5kOFEs0hYg8AhR1jJkBAXE
 xkMpGg+PxZILhrkTtv3uPxtLBmapdJ175ketloR22XVfl1aCz+4i6CdDIO6y/juiodYTzkRDWWG
 Y+9+m4Ygg25Mz96rIefI+4VSb/BsyiRsaG7n8nonteEEIszOif5dncTKEvCdxG0Laj+C59sjzz4
 DG5jcMP6GqBhWGrTrx01dQoLhv/QiAooU0rnCZmUIYQLXIIcppciF23BXeGr0ak2+8ruNg4kNXq
 hZLDb9BFj3qPmaZ/Gj/4dvBVrHV3dnz5S9vtvwqCg21pYP0STIXtnp2SWJfYxnjGlgtv97HP/7E
 6GDlsAptNUThvFJDdTvnxbjVj/2wGhRUWhefXfpwymJ08oBNXacT9erNhzOwUv80JG/YrL86kFP
 0pRI3unVC5kETixwd6Y1n4nJxN8zzK8qtd+hg==
X-Received: by 2002:a17:903:286:b0:2e5:41dc:9ac7 with SMTP id
 d9443c01a7336-2e6004bc51fmr33493655ad.24.1791409287535; 
 Wed, 07 Oct 2026 14:41:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 08/20] port: promote SWX port API to stable
Date: Wed,  7 Oct 2026 14:39:38 -0700
Message-ID: <20261007214115.3092715-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The SWX port ops structures have been experimental since 20.11 (ethdev,
source/sink) and 21.05 (fd, ring). They have not changed since being
introduced and are the only port API remaining now that the legacy
rte_port_* API has been removed, so there is no reason to keep them
experimental.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/port/rte_swx_port_ethdev.c      | 4 ++--
 lib/port/rte_swx_port_fd.c          | 4 ++--
 lib/port/rte_swx_port_ring.c        | 4 ++--
 lib/port/rte_swx_port_source_sink.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/port/rte_swx_port_ethdev.c b/lib/port/rte_swx_port_ethdev.c
index de6d0e5bb3..509762901b 100644
--- a/lib/port/rte_swx_port_ethdev.c
+++ b/lib/port/rte_swx_port_ethdev.c
@@ -402,7 +402,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_reader_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_port_ethdev_reader_ops)
 struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -410,7 +410,7 @@ struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_writer_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_port_ethdev_writer_ops)
 struct rte_swx_port_out_ops rte_swx_port_ethdev_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_fd.c b/lib/port/rte_swx_port_fd.c
index 72783d2b0f..0851ee66e1 100644
--- a/lib/port/rte_swx_port_fd.c
+++ b/lib/port/rte_swx_port_fd.c
@@ -345,7 +345,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_reader_ops, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_port_fd_reader_ops)
 struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -353,7 +353,7 @@ struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_writer_ops, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_port_fd_writer_ops)
 struct rte_swx_port_out_ops rte_swx_port_fd_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_ring.c b/lib/port/rte_swx_port_ring.c
index 3ac652ac09..badd595481 100644
--- a/lib/port/rte_swx_port_ring.c
+++ b/lib/port/rte_swx_port_ring.c
@@ -407,7 +407,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_reader_ops, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_port_ring_reader_ops)
 struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -415,7 +415,7 @@ struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_writer_ops, 21.05)
+RTE_EXPORT_SYMBOL(rte_swx_port_ring_writer_ops)
 struct rte_swx_port_out_ops rte_swx_port_ring_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_source_sink.c b/lib/port/rte_swx_port_source_sink.c
index af8b9ec68d..96ad739982 100644
--- a/lib/port/rte_swx_port_source_sink.c
+++ b/lib/port/rte_swx_port_source_sink.c
@@ -202,7 +202,7 @@ source_stats_read(void *port, struct rte_swx_port_in_stats *stats)
 	memcpy(stats, &p->stats, sizeof(p->stats));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_port_source_ops)
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = source_create,
 	.free = source_free,
@@ -212,7 +212,7 @@ struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 
 #else
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_port_source_ops)
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = NULL,
 	.free = NULL,
@@ -383,7 +383,7 @@ sink_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_sink_ops, 20.11)
+RTE_EXPORT_SYMBOL(rte_swx_port_sink_ops)
 struct rte_swx_port_out_ops rte_swx_port_sink_ops = {
 	.create = sink_create,
 	.free = sink_free,
-- 
2.53.0

