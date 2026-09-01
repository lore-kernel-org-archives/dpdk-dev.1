Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C4C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2B6340E15;
	Tue,  1 Sep 2026 22:32:42 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id C186A40E16
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:41 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso256804b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294761;
 x=1788899561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ONtG3eEw+V3FQdaORLMSBevWp5/o/uRpWdsxoCaSjk=;
 b=CrAqp+fdGRHq/zP1veDgU1WC0LWe0JAKytLGLUBunGW7JFHIf3WUJ5Kkr1IWxvAE17
 0jFFGWAgetpZMvFw2/63fNdvOY2Voc6ui7GsLTDlE+1TlSSX8vqpMSjApBVBxDnVrlVk
 pFt52+MoaCXrxivSpYiH+0c/kvS8UXztHXTz0pcZEur89fntV82PrIJmXKmvFMJiWM+4
 lz+BGIADdRAz8b9whW1a0XFS86O8+m4fZfAv9LC04rzu9IZ2jXgYphOje4ZfyMIjzH9A
 dUimXdfNdzFn7+zBPE8k0FFbKdL6wI8NHKut8IhM93ZuaMk2CiViSTJ2C3rTT5YsYuy0
 CBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294761; x=1788899561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ONtG3eEw+V3FQdaORLMSBevWp5/o/uRpWdsxoCaSjk=;
 b=gAK1+N6omV1hxwJKd0OK84qgRqy464r3e604Ap1mEzU4uedZlCe4kbEL4y15zq8Pxu
 CKXmI0QxXrQMFrBz4bLzl14GEc0OVeFldxP5CwhRxcjsKDeBUhkfa70tzVjlSBVVPWFS
 +iSinieMl+YrB780GmZaVJ9H9oGkZEkqpHBEsLEUya4PajEaollWYD5lLFSHqmbuF7EN
 b693vtToJe0UsgfFFdDHZ06FYZwkuM1hMOe4nMo/zLacCLbCWvZdu+uY1UudafrTR+dN
 YDnVGDiE0gsigeKqEesc2d+W+gKeErByWa7ABDmMFRT68djkVcV3etlotMYfcYI546ty
 0s0Q==
X-Gm-Message-State: AFuF++m3KYu2IKpYeU6Taz2DIdsZ3OXWf6YkMlmivaaeW6n1DwExbcit
 ZLC3fuWWA2HDC1PJ2q1y3rPOLQdDRlbJjmS0hruV/6oEO4f1KRjWFa1kyXpc53phHTmMUTMhWtw
 VF2xW
X-Gm-Gg: AR+sD13RBDnqeY1LlOnvWidRvfWJq8iezeNmmcba6Q/LVidhC40aJd+asLfXmvzK9qw
 djn/dJqUtpy8WUy5nhPAZ5FGc7BeLmN2h5rZZ318VPDfiU3OWc/TeuGZfB5lWELLhu37NyVKhTQ
 Xg9dVpFp80zZTK1N+IR+L8VOG+YH0jUcUsilUIBV7tjDIBIBVWrBybo5itBQgMZiuaXx5kuhHU5
 2e0ZfYIxkp725/7RQlYZ/pkONVSLGf9xx/M97q3hrWX5NyMqg1JeJODEnr7/1Ei8SsqS+IvO/u/
 9W46Jjz3Ax9VKGT/+VmE/lXYUBSyjAfSsjSB93khYgwUYzJNLI9rJ8MG0Y4L+pXYfRxkOZ0oJJ0
 GG7dw/okif7DcjP/9u69NlrVWl/DmiEGWrnIAX7lQe3fuPjTMD3DNTkPbhjHVIDENe5CnWr3/2l
 3q8xf6gGtboGPSCu8U6v8qsM4FgDMab2RmygvYUTozhx20OFQ5nH2fxK9iYG2+CvK4BTYL8OYIh
 bp4XG82G7CbCzeqDsbM/omYLI8=
X-Received: by 2002:a05:6a00:9296:b0:857:4ed5:98ee with SMTP id
 d2e1a72fcca58-85ed23def91mr473581b3a.9.1788294760887; 
 Tue, 01 Sep 2026 13:32:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 03/22] ethdev: promote rte_flow_conv to stable
Date: Tue,  1 Sep 2026 13:23:02 -0700
Message-ID: <20260901203217.1485915-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

rte_flow_conv() was added in v18.11 as the generic helper to copy
and convert flow API objects (items, actions, attributes, rules).
Its prototype and the rte_flow_conv_op enum have been unchanged
since, and it is used by drivers and applications alike.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/ethdev/rte_flow.c                  | 2 +-
 lib/ethdev/rte_flow.h                  | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8c533d87e8..77ee3380f9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -99,6 +99,7 @@ API Changes
 
   * meter (MTR) and policing: ``rte_mtr_*``
   * SFF: ``rte_eth_dev_get_module_info`` and ``rte_eth_dev_get_module_eeprom``
+  * flow conversion: ``rte_flow_conv``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 60c9a3d06f..db4eb515f3 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1119,7 +1119,7 @@ rte_flow_conv_name(int is_action,
 }
 
 /** Helper function to convert flow API objects. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_conv, 18.11)
+RTE_EXPORT_SYMBOL(rte_flow_conv)
 int
 rte_flow_conv(enum rte_flow_conv_op op,
 	      void *dst,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index b495409406..1b247a36c9 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4949,7 +4949,6 @@ rte_flow_copy(struct rte_flow_desc *fd, size_t len,
  *
  * @see rte_flow_conv_op
  */
-__rte_experimental
 int
 rte_flow_conv(enum rte_flow_conv_op op,
 	      void *dst,
-- 
2.53.0

