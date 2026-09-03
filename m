Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718A4C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 19:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12D024279D;
	Thu,  3 Sep 2026 21:16:19 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id CE1B240144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 21:16:16 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8485b358552so163128b3a.2
 for <dev@dpdk.org>; Thu, 03 Sep 2026 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788462976;
 x=1789067776; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NPoP+JLS47xN0940iIo2d598w5j06X4obqp3kXkfrSs=;
 b=xbYz3ySbLZGLk/POmuleA37nxP0AwRhalKuse4MXNHU7/zGjriAfje3f7WHClXyeGY
 fBz7IjDjWYbCGaqV/HBflXpkyrEEccJM52P2G4/T+ZtFe5FGMlrid9Rc+szhbXdzFmYT
 mjFuA5a4TDg2uP25W3pPQsFXMNvsTBHROK6Bg0hXrKNKtvjVJk0J3lq+IBnyJ3v9ooUd
 14BpgOUArxAxDC3pBmpK+1+u8ovdKSixG+E2PMqKpas/UBi7wKbMGfa6wWvb/aXCcXZu
 OPuTaZC+4FqMkPyfJXhrDBO87IW8vR1T/1LCLMD9/eXQj/9ZzvC/C1WzmY/pgfHQUhIr
 s04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788462976; x=1789067776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NPoP+JLS47xN0940iIo2d598w5j06X4obqp3kXkfrSs=;
 b=snHMSILdmEOw1gsRWfyKCRAKR5foF4IMVqSPerIla7UQMZ/v0nxpqlMB/e6KRNlbI+
 YZe2KdZ/JDYuOn7EBZUBIEuuuPduZDcEOm+2rfmHqpXFz70ktQlwLD+TbkirKesGlt3T
 oYkE8sbP/7qsYJIrgteKWD7bn/gyURFwp6s/e6pkdhMRukfa0/qwnuRgK48g1D3LJIiN
 cU2iaXGaZklVeXH+a3EeV0a30FvuIlSu3WFZwfYpmwtwD2SV8UUTCcWD7sTSelcbwcja
 gy0xHK25Kkrb3nDAxZHr7igxjz8/XrJR2/mME+m+LYWilgs7UGYqpIub3RzJ/VhkLwuc
 Fr2g==
X-Gm-Message-State: AFuF++ldXGm1t0VZVBfVFUfWujLAReanMIIJmYBBO8MMKt7Z4rA4qCk9
 HUQ8WfJqhYwvP4moG1JdAE2fFVIdno0leyY0sE0EGlycMjUxGPbLbEDqMth9spJpdJYdXnVfy2w
 jh6Fl
X-Gm-Gg: AYBFou0SXiOEPJEhreRbQcvIhp3C2V9JQDpAsrEBE7o+G5L9cjvl58InKAkdIWiO8if
 YAUkQrHJtLtiG9wnSekCSpS4QzHmgS+PNOTLzRK7jX3ZWtORcJhN4/OntmUlalBYJ6UTVDypqvx
 MOC0q6LcdCSLYAicND+jDSwWoH5TZ7l35kPVXkCsCmAZy+SXeF7SW2CBmE+XMJ26hLC+1F2Xt8N
 AZK/W5fO8lO306eDNqu9Uf8rQvthrgwfM3jMj9O2Dll4vIWS/8ls8MwKE1CB1ghVx2fdcbe+VRg
 DRDRccSC5mNQPTbyJh7LBcObCUgZcYUkCMIXmGIoD8YwlrH3gMLFhJlB4/3Nk+/eca/NYARNEK7
 6JYjXHSEkl4SVKP8mqHEczwE25VKpJVRCadd8CRVDS1Ojfmt+RJR2eh501R6M8QYvnC9l8fRxlX
 kE4wPH86kJ42wjNsNT+TjjBi0a4kUF8JVUC5/0+SqvkfIRAa0a62J+KAIRin0g3z50jcjuwVLGM
 6e84zoEKVX2iBi7792vj7xcFJw=
X-Received: by 2002:a05:6a00:2289:b0:857:726d:2e99 with SMTP id
 d2e1a72fcca58-8616af5b1aemr1537971b3a.22.1788462975783; 
 Thu, 03 Sep 2026 12:16:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614c699735sm375033b3a.0.2026.09.03.12.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:16:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Huawei Xie <huawei.xhw@alibaba-inc.com>,
 Changchun Ouyang <changchun.ouyang@intel.com>
Subject: [PATCH 2/2] examples/vhost: remove unused but set globals
Date: Thu,  3 Sep 2026 12:16:02 -0700
Message-ID: <20260903191602.924372-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903191602.924372-1-stephen@networkplumber.org>
References: <20260903191602.924372-1-stephen@networkplumber.org>
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

The vhost example tracks number of queues but never uses the
variables. Remove num_queues and the num_vmdq_queues intermediate
that only fed it.

clang 23 reports:
vhost/main.c:86:17: error: variable 'num_queues' set but not used
         [-Werror,-Wunused-but-set-global]

Fixes: d19533e86f1d ("examples/vhost: copy old vhost example")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vhost/main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 5978a50cfe..114e5f547c 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -82,8 +82,7 @@ static uint32_t enabled_port_mask = 0;
 /* Promiscuous mode */
 static uint32_t promiscuous;
 
-/* number of devices/queues to support*/
-static uint32_t num_queues = 0;
+/* number of devices to support */
 static uint32_t num_devices;
 
 static int mergeable;
@@ -162,7 +161,7 @@ static struct rte_eth_conf vmdq_conf_default = {
 static unsigned lcore_ids[RTE_MAX_LCORE];
 static uint16_t ports[RTE_MAX_ETHPORTS];
 static unsigned num_ports = 0; /**< The number of ports specified in command line */
-static uint16_t num_pf_queues, num_vmdq_queues;
+static uint16_t num_pf_queues;
 static uint16_t vmdq_pool_base, vmdq_queue_base;
 static uint16_t queues_per_pool;
 
@@ -465,8 +464,6 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	/* NIC queues are divided into pf queues and vmdq queues.  */
 	num_pf_queues = dev_info.max_rx_queues - dev_info.vmdq_queue_num;
 	queues_per_pool = dev_info.vmdq_queue_num / dev_info.max_vmdq_pools;
-	num_vmdq_queues = num_devices * queues_per_pool;
-	num_queues = num_pf_queues + num_vmdq_queues;
 	vmdq_queue_base = dev_info.vmdq_queue_base;
 	vmdq_pool_base  = dev_info.vmdq_pool_base;
 	printf("pf queue num: %u, configured vmdq pool num: %u, each vmdq pool has %u queues\n",
-- 
2.53.0

