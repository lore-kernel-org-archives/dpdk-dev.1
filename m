Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8ABCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 273D1427D3;
	Tue, 29 Sep 2026 21:34:39 +0200 (CEST)
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com
 [74.125.230.234])
 by mails.dpdk.org (Postfix) with ESMTP id 772F9402A2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 21:34:37 +0200 (CEST)
Received: by mail-qk2-f42.google.com with SMTP id
 d75a77b69052e-53320dc09f3so35227471cf.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790710477; x=1791315277; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JOjVGIrMvtXftRWruV/Rq4FNPTANl2Bvi22H3wcCpd8=;
 b=jOkDvUsMvo0qW0Fvo4L5gxtoTPnGWf/2zV0G5NiP+ez2ob3LkB3XjyYv+ie2WwZ/kq
 Pb3Nz8/x7flRCvDeZaaiPCoXsD8NDhLVW52MPzWMeMMwcpht+cveJkLkkxkGZuMD4l6q
 ma5XaByUIjzCBm4olkNsyeFxf1RJfweWtKnBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790710477; x=1791315277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JOjVGIrMvtXftRWruV/Rq4FNPTANl2Bvi22H3wcCpd8=;
 b=pQzVejfdBEC4lxpZehHqEveNyLeIy66M0rMzl+Bd/nLWoTyaCigrLkfdLuy/dM1VCa
 naJaZBvfDCuSL/3rDRpOYpZ5H3ntuFCmka6ksXjtrq+ryuvfb6cNzSoc1yhNVwMaQ477
 xWscCGFoUMc+Kn8nRWxGja+aFQUc+jJrW1v4Xs7nDE/37NO4Cwk1OkzD3cMbZKqJtBg0
 f/jqyACQfsXsPHbqAdOMuWT2tTMo1BQj+CfZISRgoDPN27/FM4sKMQG5Hb0GHqVrlSto
 CfU/70avn8fc81bt8XW80hkM9O2lzKeU2nfhD3riJwtGjyIkghBbiy0jxXTLp9cv/STk
 opog==
X-Gm-Message-State: AFuF++lmKw5u23i1C9/B3gWXn1veSskxZdqzH/Q0NkJMOcQN7KucO3qs
 EzMonmZsQjaTe/ifwR4vzzprRb+tRPpp3ZhqgE+yPUZD92rVb3Zrxyqn6SKJrq6Hi9MNa/az1rQ
 65p3H
X-Gm-Gg: AYBFou2ESjiYZ5xlsF/qv+MPWA1qGCjUVliXwBQLlQuidjB859VIRAnQ2KqqGjRAXDD
 lgDfyK8IPO1lWj1uAFmIgfNuazEPF5zekaf5arP9KB6/xc4YKr08KprC06KR0rGdIg4AJJlTQ7/
 /wvrj5zC3ovIvdxroPANMP4HtU5x/jOsnrcq0t2Kv5iqftmYRRnRGQV3r+euA8wQBxNmb3+rxbM
 B6q/9/Q6JaN3ZNuzWD+ThCJnrm2bwhpUCZmLaABUbXOF2Yz3VRf/wSyXYpSmXLq/49WVsMkx6WD
 3VoCwpfKj8xLXifpdNlRcaUHuJMmOOY/cD5zW90Hw9udbq4lYkJkAhMbe28CWf3G9cJXcRNs8VI
 vXFDkNGGhw8fg6qgNfaSOeZmBsGQwitcT/7V/jclVfqMLaHxpwUpjL6fVguHBCiGJMcvbSsrwRA
 SGK6bfAPOQ9jAqMGvGAolbHy50HdIT5aDWyS6rm/A/yWwkA0i8DxTDezSv5HjIZXxn2DKkJZnAO
 b/SIdUpXyYF+GduvGySbpq8psMnLOe1ErSEsT3USU+kvEoTwuBmxxfecINgiJOsAMl4TQpOh/Gc
 jRkEojvErJmQ3aROQhK7PmHmear4D8j0352JwucY9TXCzrLbDYKX+VZc+j1/aTKKEvFJ
X-Received: by 2002:a05:622a:1e0b:b0:530:d429:c70a with SMTP id
 d75a77b69052e-5336a5496eemr5728091cf.26.1790710476783; 
 Tue, 29 Sep 2026 12:34:36 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9179892e9a3sm2616366d6.40.2026.09.29.12.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:34:36 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add pvp multi paths virtio performance testsuite
Date: Tue, 29 Sep 2026 15:34:32 -0400
Message-ID: <20260929193432.513234-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929193432.513234-1-knimoji@iol.unh.edu>
References: <20260901185957.453730-1-knimoji@iol.unh.edu>
 <20260929193432.513234-1-knimoji@iol.unh.edu>
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

This patch adds the pvp multi paths virtio single core forward
performance testsuite, which launches testpmd using the vhost
and virtio virtual devices with two and one core respectively,
and tests the virtio single core throughputperformance.

Depends-on: series-39456 ("dts: add pvp multi paths vhost performance")
Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 ...Suite_pvp_multi_paths_virtio_single_core_perf.rst |  8 ++++++++
 dts/configurations/tests_config.example.yaml         | 12 ++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst

diff --git a/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst b/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst
new file mode 100644
index 0000000000..853d04ad40
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+pvp_multi_paths_virtio_single_core_perf Test Suite
+==================================================
+
+.. automodule:: tests.TestSuite_pvp_multi_paths_virtio_single_core_perf
+   :members:
+   :show-inheritance:
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index f765526442..14715014fb 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -30,6 +30,18 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# pvp_multi_paths_virtio_single_core_forward_perf:
+#   test_parameters: # Add frame size / descriptor count combinations as needed
+#     - frame_size: 64
+#       num_descriptors: 512
+#       expected_mpps: 1.0 # Set millions of packets per second according to your devices expected throughput for this given frame size / descriptor count
+#     - frame_size: 64
+#       num_descriptors: 1024
+#       expected_mpps: 1.0
+#     - frame_size: 512
+#       num_descriptors: 1024
+#       expected_mpps: 1.0
+#   delta_tolerance: 0.05
 # pmd_rss:
 #   NUM_QUEUES: 4
 #   ACTUAL_KEY_SIZE: 52
-- 
2.55.0

