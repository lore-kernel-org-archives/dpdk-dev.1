Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08010C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5C7B42D68;
	Sun, 18 Jan 2026 20:14:25 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 6A52340EAB
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:23 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so6113446a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763663;
 x=1769368463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0na/Y/P2BemP+gr/YLn9ymES6Nw3OA/GCwDa/ueRyM=;
 b=tNNA9rs4Ev/yVjh6tn6puouorBIBHv5W7EIc2lKsbzhk7hDWPnIUdjzVhUTIxoFehV
 fHAcpNlNn2uzjG0WayDpHQHMDP6guJnHVVHDPmm5xnLAdFFWOf/pKPpgIDVVgRi1SA98
 iIKUk+Nw+eaVBQJWJSuDzqApSHxVrRIX60dLWPQyZL8IavUU65ehMP86VHbxCHtCurqL
 hLyjVbSvj2KHTz+Cw9qTiw3fBT7r9EIRrbfga1DpCAYJxgIW7xXX7220tyrl1HLfPAiw
 mJ7NGnfBc2WySFjBX+TajZquIssByhrwcIFv6gCUKIvn8sP8HAuL+2kxC0fL96A/fYq/
 pvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763663; x=1769368463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m0na/Y/P2BemP+gr/YLn9ymES6Nw3OA/GCwDa/ueRyM=;
 b=eRAmrgoDT9Uwh8EEH8daomjtD2kJORnoimWMA0OLYcXRMNe6H9GYRBKDc5zMzY8GeZ
 w4d+vlHaTPfHIwheUl08ChYhcOs2ZS7k2xDqKuLTxQmHVG0Xsv7GhiJgWc310381lOxW
 p2HNNE2iOdMdziTyZuqbQCYAsSKtjhdbjbrslzGk70AZTONHn7q+jkDs0rnfu0a8zE7n
 J0Q+FxMWsmVYOuqr7+TIt8MiCPVPNWPoTrrxasSiEPFzFBuNkhEAh0lzS5FIX9kyf+1r
 fpyAJ2y9IJc+GfAxEPtZ+eVPCnlFVYAq4VEp7jlUULxzUiTxQPltsPpydykkHuwqzJkU
 VXSw==
X-Gm-Message-State: AOJu0YyxCy+EYc5qNAnGS+C1Pllpjs1wkZTtR6thuaJdKH6d8Tbf1Q3f
 8EmUVx3A5rBGa2YlCuOJfuc60hcm9KP9ZDpyPXYWP7LhuslZ7fURKSrCCWTLpqunbfsHgDIJu51
 /TWEm
X-Gm-Gg: AY/fxX74b/taKE7YfHLUBE9xovP+SPZb/nhvNeH+6v8vialFUl3J/CSgdR5xsfJkkf5
 a/aXnjkxgRuIRDxXgFChecg9kXsZWQMJseRNVWsMzfU0c+BM0slMfYVZZ2C6wB6JCzLxTVxpL9u
 n8xO5VwyNNZwmB10xhijUn8HMs4Ai+ybAGMLSZK+cEARnEPGvPnPZs+1aFx0GbTVHioYbZZcR6q
 n+PbBH4KXTqdsfyVoP7vkDm5Ew8MLEjWIpeOEWu9AMtJEJ6gADQV4V6X1X9Xq/eIj7o+q7iuhxa
 N5A799bLNtnLVL49+hsAlMUBdQdqv6TaENC3WSLLuMMWWnz1OzG/7qtsK5A/LbDyj9c3oEyEap2
 1BRkQPPrYBw8l805r5K76DJXhXLKq1/h+XwpDf7AkxsiGmhdIe5oSiD225POo5iahrDM6JsKqUV
 iWL3WqwQ2T2TbBJYbMaLfX68gmHx4mHH+xz+YdiX2C6Yip3ESdcwnV8SAUDd8a
X-Received: by 2002:a17:907:7256:b0:b87:2eb8:2b78 with SMTP id
 a640c23a62f3a-b8792d5a73bmr844151066b.18.1768763662964; 
 Sun, 18 Jan 2026 11:14:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 35/54] doc: correct errors in metrics library guide
Date: Sun, 18 Jan 2026 11:10:38 -0800
Message-ID: <20260118191323.241013-36-stephen@networkplumber.org>
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

Correct various issues in the metrics library documentation:

- capitalize sentence start
- fix subject-verb agreement for "function that returns"
- add missing variable declarations (ret, i) in code example
- remove extra space in malloc line
- use consistent American spelling "Deinitializing"
- invalid C syntax: rte_metrics_deinit(void) -> ()
- normalize spacing in metric name lists
- fix typo mac_latency_ns to max_latency_ns
- remove unused variable declaration from example

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/metrics_lib.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/guides/prog_guide/metrics_lib.rst b/doc/guides/prog_guide/metrics_lib.rst
index 98fc8947c6..6f534534c0 100644
--- a/doc/guides/prog_guide/metrics_lib.rst
+++ b/doc/guides/prog_guide/metrics_lib.rst
@@ -84,7 +84,7 @@ using ``rte_metrics_get_names()``.
     rte_metrics_update_value(port_id, id_3, values[2]);
     rte_metrics_update_value(port_id, id_4, values[3]);
 
-if metrics were registered as a single set, they can either be updated
+If metrics were registered as a single set, they can either be updated
 individually using ``rte_metrics_update_value()``, or updated together
 using the ``rte_metrics_update_values()`` function:
 
@@ -105,7 +105,7 @@ Querying metrics
 ----------------
 
 Consumers can obtain metric values by querying the metrics library using
-the ``rte_metrics_get_values()`` function that return an array of
+the ``rte_metrics_get_values()`` function that returns an array of
 ``struct rte_metric_value``. Each entry within this array contains a metric
 value and its associated key. A key-name mapping can be obtained using the
 ``rte_metrics_get_names()`` function that returns an array of
@@ -118,6 +118,8 @@ print out all metrics for a given port:
         struct rte_metric_value *metrics;
         struct rte_metric_name *names;
         int len;
+        int ret;
+        int i;
 
         len = rte_metrics_get_names(NULL, 0);
         if (len < 0) {
@@ -129,7 +131,7 @@ print out all metrics for a given port:
             return;
         }
         metrics = malloc(sizeof(struct rte_metric_value) * len);
-        names =  malloc(sizeof(struct rte_metric_name) * len);
+        names = malloc(sizeof(struct rte_metric_name) * len);
         if (metrics == NULL || names == NULL) {
             printf("Cannot allocate memory\n");
             free(metrics);
@@ -152,7 +154,7 @@ print out all metrics for a given port:
     }
 
 
-Deinitialising the library
+Deinitializing the library
 --------------------------
 
 Once the library usage is done, it must be deinitialized by calling
@@ -161,7 +163,7 @@ during initialization.
 
 .. code-block:: c
 
-    err = rte_metrics_deinit(void);
+    err = rte_metrics_deinit();
 
 If the return value is negative, it means deinitialization failed.
 This function **must** be called from a primary process.
@@ -175,11 +177,11 @@ These statistics are reported via the metrics library using the
 following names:
 
     - ``mean_bits_in``: Average inbound bit-rate
-    - ``mean_bits_out``:  Average outbound bit-rate
+    - ``mean_bits_out``: Average outbound bit-rate
     - ``ewma_bits_in``: Average inbound bit-rate (EWMA smoothed)
-    - ``ewma_bits_out``:  Average outbound bit-rate (EWMA smoothed)
-    - ``peak_bits_in``:  Peak inbound bit-rate
-    - ``peak_bits_out``:  Peak outbound bit-rate
+    - ``ewma_bits_out``: Average outbound bit-rate (EWMA smoothed)
+    - ``peak_bits_in``: Peak inbound bit-rate
+    - ``peak_bits_out``: Peak outbound bit-rate
 
 Once initialised and clocked at the appropriate frequency, these
 statistics can be obtained by querying the metrics library.
@@ -241,8 +243,8 @@ the jitter in processing delay. These statistics are then reported
 via the metrics library using the following names:
 
     - ``min_latency_ns``: Minimum processing latency (nano-seconds)
-    - ``avg_latency_ns``:  Average  processing latency (nano-seconds)
-    - ``mac_latency_ns``:  Maximum  processing latency (nano-seconds)
+    - ``avg_latency_ns``: Average processing latency (nano-seconds)
+    - ``max_latency_ns``: Maximum processing latency (nano-seconds)
     - ``jitter_ns``: Variance in processing latency (nano-seconds)
 
 Once initialised and clocked at the appropriate frequency, these
@@ -256,8 +258,6 @@ Before the library can be used, it has to be initialised by calling
 
 .. code-block:: c
 
-    lcoreid_t latencystats_lcore_id = -1;
-
     int ret = rte_latencystats_init(1, NULL);
     if (ret)
         rte_exit(EXIT_FAILURE, "Could not allocate latency data.\n");
-- 
2.51.0

