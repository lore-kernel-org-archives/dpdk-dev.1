Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DCCC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C49D340E25;
	Wed, 14 Oct 2026 00:35:31 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id CA5544068E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:28 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso19000045ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930928;
 x=1792535728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foHSEAK05ws0JY7Yq5L2TNaWHOsP27nNNQN0SP1GeVQ=;
 b=BxMffc0MklQFfTG67lAZt+hEJ5fWQbPQUcwe2UykDKh4OYOjY9Wt8+DVRJEDR5Z5zx
 jWgC68yGl9w8XOGgB+9IlBLUp6q/7q72D88y1AImQZBb/N5oFUh2NMG2XbMhees+zzP7
 PtyjkPDqZ+KH2O232NiMnP8QxSMKGEDeLiNK/ujlE+sMjHwhd0ErASwnMEBexB2xuSd6
 9vtnfOu7xL331gVmBSNXp4YkGyp1mu/iDzdcNyhqaX4xwqIk/8LTDJKCCrwbdNXnZOKg
 7M5yKd0lnAfvYHEs3qXpAT9XXcXahKw8KBVhy6Ekhv0haKHBpmftnmgwq/3Ii9UgqIcU
 SjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930928; x=1792535728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=foHSEAK05ws0JY7Yq5L2TNaWHOsP27nNNQN0SP1GeVQ=;
 b=SGoCo69lUB9Ite40U2AyDSbXhBInU+FpLliy4tB4nmjWGefPbHpIRjh6psqCKQgVGr
 VyODBU5j8QYj2VyfBPP9yX9Bjpjq6XmVUdH62+uI/xk2V8MqAiav6Tqjq78vVcz4Z88/
 k6ks128CX6Zp9Au8uq+xB/8+5IjfHLo6SB6jZYgHkMvjqEudoGoQslNun/1xkW3wZNUh
 Aht99LA6o3elG7r37za2Zpv7VEW9T40YTb6SupOr8p8Fhor/JY0f82V/bAMnF3BOy1d4
 Bzkfsjx49J5nIB4zI2CPtlTu3k2dxEi+h1Xe+qPuIeunVljgj8wtVCQ0IPi9qMixOpF0
 sacw==
X-Gm-Message-State: AFq9FYJjgu1nhMXESAchW1j13XbzuUpmr6LjxgCILJZgmAW1JPJTGOWK
 3OtQ3XS52ftOYzSdufNCyBEUsWe0IRLQaqG3A0M3dQBc3r3sLW4uGJK+VDG/yUi+VFHYYmJHYqq
 LHcdJ/FI=
X-Gm-Gg: AYBFou1qJzLs3sHbyeCK+IDynt47lYLEJykORvhK0j2Jj1X8SgkYxj9R58XoStMKlp5
 v8hJnfM+8izXxfOwj2gQAfgBCvKPzBu6W8+otRe/TL9fs1BI2cOhf8NYuwwJOy1l3RshfrT1i+Q
 mTRCIO4FerdCHbvEu4ka/2ev54ZlaI5vtLOtzaA7McnwQR4p7ZYUcN3blXSLlh8Xy/IWISsxeKv
 G+pkC4oPnLemKGOC86H/ulNevmj3beiLO/vpy2UDx/j7tMzIWeVxP9OSOHorIUqlp7ocdAiZIG5
 f+5iPkOqh7MxuoUInCoYinwQ0BRUHvMSN+ZO7BY+PKOyY0uWvXds1FQHB5sDbinGWJLP7WOcl9i
 uF30enaJ5QWLXFZ91fDc+rH9JCT1tYw78NwWgoF32F9oAH1Hwq264r5wHaW64hT+npx5+UxexCR
 Q6MIWu65/fNb5i7jh0NsSG1Mkyn3OtrUy35XzyHfL1GXGL5viFaxSM4f5W7NJ1X24SEkOoHXb6R
 RzMNAMalETmn+mngWw63GADLaBpLOaS3v+INQ==
X-Received: by 2002:a17:902:d4c1:b0:2dd:2b8:7198 with SMTP id
 d9443c01a7336-2e8427f0548mr119173955ad.6.1791930927960; 
 Tue, 13 Oct 2026 15:35:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v4 26/29] event/opdl: replace SMP barriers with C11 atomics
Date: Tue, 13 Oct 2026 15:22:39 -0700
Message-ID: <20261013222410.2257622-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Publishing the port becomes a release store of the configured
flag. Control path.

Drop the barrier after clearing started in opdl_stop(): no store
follows it, and the datapath tests data->dev_started, not
device->started.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/opdl/opdl_evdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..44a648a11a 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -200,8 +200,9 @@ opdl_port_setup(struct rte_eventdev *dev,
 	p->queue_id = OPDL_INVALID_QID;
 	p->external_qid = OPDL_INVALID_QID;
 	dev->data->ports[port_id] = p;
-	rte_smp_wmb();
-	p->configured = 1;
+	/* Release publishes port setup before the configured flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&p->configured, 1,
+				  rte_memory_order_release);
 	device->nb_ports++;
 	return 0;
 }
@@ -474,10 +475,7 @@ opdl_stop(struct rte_eventdev *dev)
 
 	destroy_queues_and_rings(dev);
 
-
 	device->started = 0;
-
-	rte_smp_wmb();
 }
 
 static int
-- 
2.53.0

