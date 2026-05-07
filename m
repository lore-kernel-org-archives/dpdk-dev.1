Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CCFCD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 21:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4358F4065F;
	Thu,  7 May 2026 23:02:00 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id C60B7402E8
 for <dev@dpdk.org>; Thu,  7 May 2026 23:01:58 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12ddbe104ccso1374885c88.0
 for <dev@dpdk.org>; Thu, 07 May 2026 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778187718;
 x=1778792518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTC0jegFGVFfq4TQsKICbKpucgiD1XJ65Af0srEjwPo=;
 b=m4NRJn+voTqoVIBUIKMn1jy+vhW6scbhgjq5y/OuWMzDvPgZEWieNHARhsTKsXp48O
 uNd8Tz6fUJehtDLTTefFUbcXLfOmMIf+RFo5wexF5zYw6O1TWDC5YUN9j6mRorbDQ7Q7
 zslSGT6XSJg17cxSlFYlel2MVfVoydB9aInK4W+loIAuIOEXExsdTMq6ZvntrJ1owhe4
 fBWQ0p2KKzwZwEwZxF+OlOR9WPoW7rhr/sN8hpEUMP60dOES/TmGbjHuVXK29agxA12a
 0ZYX+RhEQ+OdUOLWD6caOw6/BM2xWKPyqFvhF1KRh5a820p4oFPTtXq9+gesLazjW2kX
 7ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778187718; x=1778792518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UTC0jegFGVFfq4TQsKICbKpucgiD1XJ65Af0srEjwPo=;
 b=ok0yMPKi4BgCmLJ5kKh8Sd4nX3rlZplXL1qI7Xm4Ooztz/D7J1ZTN62EqYmwxZauLB
 PgIgQCtt/lKrbA3h/Qgb6tuhywSnaxMrP0bUt4fJpKkDXzn37ozT+lYUADP6+x9CJlNl
 umr1zw5BgZt6JuJohsDNNCHk0BVMlxv0DegYu3YXUcq7EqP/aJrjG8Eh92iPqMmUmwkB
 X/wWyEvH35NR1QAzXohzEp66ENR8B2mRmvpZ+tek9o2i46dSAPl/RJ0XcXWFjOkkrvO2
 fhZbWj5HGrRdZYzrVY4RFbXkxFaCtz6feVygDrtndocpP+/aNZh72xXCrhpa8GcNkJGj
 E8ww==
X-Gm-Message-State: AOJu0Yyw2nD+hiz17RYS/mwin53rJu5DHinjpv+A1g2SrYLkEBBdWsP/
 JBdYYo7PDM2pzBTQmcIY5seA/HDMyKmbGIayVgNtpUZt/W4lnDKrHwk/j3AUWDzF7+OsjBVarCw
 RKVzC
X-Gm-Gg: AeBDieuyMWs5sTRXHE0gGa9FlvO/dfGcZITRod+xje/fmVyUWgb8HaW9ntjTkbZXT4Z
 bwxd1lQAKPwmthLU6antTRnpfHF3HxCVEVB8/q3cndAy4UC2aamlk7tR77ENvld/WNas3o3+Oa6
 94YpzjE1fHQkJmhkADhDsh0Y2zu4l7kLO8Ck+c/IUqDA/sPZ0KylI5jbkmAKTuJt7R/JBRCrl9I
 EoIAKzjC27ep8Mp72nWiVlmxn1L2gY9nbeCTM+BilJ3e4lV2OSt01duhJuMtWCCoypNXCseIbRp
 nwN6FR2696v59lmXdcTtkOoTqecjScxmDbgk5KIP1hhQCR0vdHJnBCJZcyZIQy1jZ0a3LFq+4KI
 sl/XFLFXVuajDONhyd7TgQ2wHj1V72BTNlXmc9bwRiZ50jLhVwZqd6EyZ2iGaIqqYtZBlOa56V2
 O1XHraThRXVMR9gcOKdQ45IqX1rbyP2++e
X-Received: by 2002:a05:7022:f311:b0:132:2486:b47 with SMTP id
 a92af1059eb24-13224860ce4mr2293364c88.3.1778187717720; 
 Thu, 07 May 2026 14:01:57 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13270901ba2sm227282c88.11.2026.05.07.14.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 14:01:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH 2/2] eal: notify secondary on primary exit
Date: Thu,  7 May 2026 13:58:37 -0700
Message-ID: <20260507210152.410419-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507210152.410419-1-stephen@networkplumber.org>
References: <20260507210152.410419-1-stephen@networkplumber.org>
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

When primary process exits, it should notify the secondary
processes. This allows for clean shutdown and eliminates need
for MP handling in applications (such as test-pmd).

Bugzilla ID: 1942
Fixes: 85d6815fa6d0 ("eal: close multi-process socket during cleanup")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_proc.c | 51 ++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 06f151818c..4369892e44 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -60,6 +60,15 @@ enum mp_type {
 	MP_IGN, /* Response telling requester to ignore this response */
 };
 
+/* Message sent from primary EAL to secondary EAL */
+#define EAL_MP "mp_eal"
+struct eal_mp_req {
+	enum {
+		MP_REQ_NOP = 0,
+		MP_REQ_QUIT,
+	} type;
+};
+
 struct mp_msg_internal {
 	int type;
 	struct rte_mp_msg msg;
@@ -614,6 +623,25 @@ close_socket_fd(int fd)
 		unlink(path);
 }
 
+/* callback in secondary when primary has exited */
+static int
+mp_primary_exited(const struct rte_mp_msg *msg, const void *peer __rte_unused)
+{
+	const struct eal_mp_req *req;
+
+	if (msg->len_param != sizeof(*req)) {
+		EAL_LOG(ERR, "invalid request from primary");
+		return -EINVAL;
+	}
+
+	req = (const struct eal_mp_req *)msg->param;
+	if (req->type == MP_REQ_QUIT)
+		rte_mp_channel_cleanup();
+
+	/* no reply needed */
+	return 0;
+}
+
 int
 rte_mp_channel_init(void)
 {
@@ -661,6 +689,10 @@ rte_mp_channel_init(void)
 		return -1;
 	}
 
+	/* listen for quit message from primary */
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		rte_mp_action_register(EAL_MP, mp_primary_exited);
+
 	if (rte_thread_create_internal_control(&mp_handle_tid, "mp-msg",
 			mp_handle, NULL) < 0) {
 		EAL_LOG(ERR, "failed to create mp thread: %s",
@@ -682,12 +714,27 @@ rte_mp_channel_cleanup(void)
 {
 	int fd;
 
+	/* Primary exiting, tell all secondary processes */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		struct rte_mp_msg msg = { .name = EAL_MP };
+		struct eal_mp_req req = { .type = MP_REQ_QUIT };
+
+		memcpy(&msg.param, &req, sizeof(req));
+		msg.len_param = sizeof(req);
+
+		rte_mp_sendmsg(&msg);
+	} else {
+		rte_mp_action_unregister(EAL_MP);
+	}
+
 	fd = rte_atomic_exchange_explicit(&mp_fd, -1, rte_memory_order_relaxed);
 	if (fd < 0)
 		return;
 
-	pthread_cancel((pthread_t)mp_handle_tid.opaque_id);
-	rte_thread_join(mp_handle_tid, NULL);
+	if (pthread_self() != (pthread_t)mp_handle_tid.opaque_id) {
+		pthread_cancel((pthread_t)mp_handle_tid.opaque_id);
+		rte_thread_join(mp_handle_tid, NULL);
+	}
 	close_socket_fd(fd);
 }
 
-- 
2.53.0

