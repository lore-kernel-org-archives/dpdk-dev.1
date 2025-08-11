Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3356CA0EDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C0B540658;
	Mon, 11 Aug 2025 23:36:50 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 436CA4064F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:48 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so41647675e9.3
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948208;
 x=1755553008; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A6ESd4oIKS537mqh1ngXnjsBrYMhdr/4nuvg48/UOA=;
 b=k6lnJzofCXJbR0+/GvY/IH5LrpDDxCNa+jAbH79vjBCFInoogAgg7S+zgIkbt5Sp/K
 CB7VwLyvHyCGdg02rPEcmpCyk4plQEZB5kx+uDa3UCcQd8TOSZrnE3kCwC0WpxNQg/kV
 TLXX4/U4ueqLREVCVB0wFQJ0SLN4YAocWjFBlauDYRkJVEMPZPmWX/luQdSWj0CzJ6yJ
 vvJMwNYL9bj3zSBqssPdjMOjtY+em5Q5yJXnruC9AOUZN9i8UsRlTQSbi4vTKPaWB7FY
 ZRudUAfvPy0cQuhvTYvl966odn5wn+KP9/vKOTfMAOVdHI6WY+m+aau8rBd7gwMfipgn
 CXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948208; x=1755553008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A6ESd4oIKS537mqh1ngXnjsBrYMhdr/4nuvg48/UOA=;
 b=RzKShaddaMHb+GI9d2Byg4JYu3Rri3xI2mCfOnywEISHO6OegJtKySbjMma7wqa0hW
 iqtf+M+J89uYFjIzhs792IKUIXI6lHOHqq43zB8gm2VVCjXYSIS6FrYyP6Ts+yJAvABh
 6TYtyh2f+xm89kI5gBUd8vKrBz379e5QSGc5h+yFmNr3cABfQ0BGcWF5akms/wRIXZR7
 bHSG+kRmOfGfJjVSjPcSDQgs5qR16vvBey62Nyrwr4H+X1o/pVOoVQgBzRkrzvMQLykA
 75GmigKEi2ukX+tcvmpfUt2FL1gAKNCh9WF35D6f7qx52HhaCjY7xYtMUR8s+zkuhcco
 kJ7Q==
X-Gm-Message-State: AOJu0YzVEkchUiCq+jxd2Q8rB4W8aEOdJ+v3a9jq+DobhuYTRzqdGail
 5Xn31cp2LmkmBwlLf0Y8gpqm/gv6b0xHTAc1j+HCZH9dhqQ4mOzLsyiJmadD3WbhlEt7pODKRso
 KLY+p
X-Gm-Gg: ASbGncup5RbsGMwiuNe4zrmueyaZDQWqdoG++iqXVBnEdftHizKX4wIBDaXC7anrrcV
 hpNAHjXLPMyuJrLvrCsdjESzdbJMnP87yX60B17yo3oAe46CpSbfgLOVoGuyAQSI/dnj9DIydeY
 T9NAn4pXteHA3kcrYY5ffZEGASLraEJTpmBrtyB/4xvONmlWdzJ/rWvpPv+3LvF93iz5zUkwsjw
 r0aTEvRQYRFYWfg0HoZcS7YBLb175/gH42NSeOOtab6JoEH54AkfAkEdagvukXi3doyUqNQKNkJ
 ALlFph6SuQ71O89z3K9jU5nb4aKj4mpw35OieFz5fUGAja6+XLEzZ+NKjfZ30x/jPE0vU4b6uRu
 XE36l47ISwteuE3PBmfnt4HdQEZ5gqeNPfOQ3LnW5yl2qTbGlXDtBnBkw3lYT4Z7aaDucUQIL
X-Google-Smtp-Source: AGHT+IFH3v7JfElzQASgDbjDZBvn2Vqiq4AB9nn0Od1Gg5fdG45y9eQGaRlXWdLk1U0wjiQMgDm6Yg==
X-Received: by 2002:a05:600c:4f41:b0:458:a847:671e with SMTP id
 5b1f17b1804b1-459f4f141b2mr99330755e9.23.1754948207765; 
 Mon, 11 Aug 2025 14:36:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 6/6] pdump: forward callback enable to secondary
Date: Mon, 11 Aug 2025 14:35:04 -0700
Message-ID: <20250811213632.16023-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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

When packet capture is enabled, need to also notify
secondary processes to force them to do the callbacks.

Requires that all secondary processes also call rte_pdump_init()
or there will be warning about not responding secondary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 213 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 185 insertions(+), 28 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index bfd63fa8c2..b95f7f863d 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 
 #include <eal_export.h>
+#include <rte_alarm.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_lcore.h>
@@ -26,11 +27,28 @@ RTE_LOG_REGISTER_DEFAULT(pdump_logtype, NOTICE);
 /* Used for the multi-process communication */
 #define PDUMP_MP	"mp_pdump"
 
+/* Overly generous timeout for secondary to respond */
+#define MP_TIMEOUT_S 5
+
 enum pdump_operation {
 	DISABLE = 1,
 	ENABLE = 2
 };
 
+static inline const char *
+pdump_opname(enum pdump_operation op)
+{
+	static char buf[32];
+
+	if (op == DISABLE)
+		return "disable";
+	if (op == ENABLE)
+		return "enable";
+
+	snprintf(buf, sizeof(buf), "op%u", op);
+	return buf;
+}
+
 /* Internal version number in request */
 enum pdump_version {
 	V1 = 1,		    /* no filtering or snap */
@@ -56,6 +74,11 @@ struct pdump_response {
 	int32_t err_value;
 };
 
+struct pdump_bundle {
+	struct rte_mp_msg msg;
+	char peer[];
+};
+
 static struct pdump_rxtx_cbs {
 	struct rte_ring *ring;
 	struct rte_mempool *mp;
@@ -432,34 +455,150 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 	return ret;
 }
 
+static void
+pdump_request_to_secondary(const struct pdump_request *req)
+{
+	struct rte_mp_msg mp_req = { };
+	struct rte_mp_reply mp_reply;
+	struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
+
+	PDUMP_LOG_LINE(DEBUG, "forward req %s to secondary", pdump_opname(req->op));
+
+	memcpy(mp_req.param, req, sizeof(*req));
+	strlcpy(mp_req.name, PDUMP_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*req);
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0)
+		PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed");
+
+	else if (mp_reply.nb_sent != mp_reply.nb_received)
+		PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u recv %u)",
+			       mp_reply.nb_sent, mp_reply.nb_received);
+
+	free(mp_reply.msgs);
+}
+
+/* Allocate temporary storage for passing state to the alarm thread for deferred handling */
+static struct pdump_bundle *
+pdump_bundle_alloc(const struct rte_mp_msg *mp_msg, const char *peer)
+{
+	struct pdump_bundle *bundle;
+	size_t peer_len = strlen(peer) + 1;
+
+	/* peer is the unix domain socket path */
+	bundle = malloc(sizeof(*bundle) + peer_len);
+	if (bundle == NULL)
+		return NULL;
+
+	bundle->msg = *mp_msg;
+	memcpy(bundle->peer, peer, peer_len);
+	return bundle;
+}
+
+/* Send response to peer */
 static int
-pdump_server(const struct rte_mp_msg *mp_msg, const void *peer)
+pdump_send_response(const struct pdump_request *req, int result, const void *peer)
 {
-	struct rte_mp_msg mp_resp;
-	const struct pdump_request *cli_req;
-	struct pdump_response *resp = (struct pdump_response *)&mp_resp.param;
+	struct rte_mp_msg mp_resp = { };
+	struct pdump_response *resp = (struct pdump_response *)mp_resp.param;
+	int ret;
 
-	/* recv client requests */
-	if (mp_msg->len_param != sizeof(*cli_req)) {
-		PDUMP_LOG_LINE(ERR, "failed to recv from client");
-		resp->err_value = -EINVAL;
-	} else {
-		cli_req = (const struct pdump_request *)mp_msg->param;
-		resp->ver = cli_req->ver;
-		resp->res_op = cli_req->op;
-		resp->err_value = set_pdump_rxtx_cbs(cli_req);
+	if (req) {
+		resp->ver = req->ver;
+		resp->res_op = req->op;
 	}
+	resp->err_value = result;
 
 	rte_strscpy(mp_resp.name, PDUMP_MP, RTE_MP_MAX_NAME_LEN);
 	mp_resp.len_param = sizeof(*resp);
-	mp_resp.num_fds = 0;
-	if (rte_mp_reply(&mp_resp, peer) < 0) {
-		PDUMP_LOG_LINE(ERR, "failed to send to client:%s",
+
+	ret = rte_mp_reply(&mp_resp, peer);
+	if (ret != 0)
+		PDUMP_LOG_LINE(ERR, "failed to send response: %s",
 			  strerror(rte_errno));
-		return -1;
+	return ret;
+}
+
+/* Callback from MP request handler in secondary process */
+static int
+pdump_handle_primary_request(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	const struct pdump_request *req = NULL;
+	int ret;
+
+	if (mp_msg->len_param != sizeof(*req)) {
+		PDUMP_LOG_LINE(ERR, "invalid request from primary");
+		ret = -EINVAL;
+	} else {
+		req = (const struct pdump_request *)mp_msg->param;
+		PDUMP_LOG_LINE(DEBUG, "secondary pdump %s", pdump_opname(req->op));
+
+		/* Can just do it now, no need for interrupt thread */
+		ret = set_pdump_rxtx_cbs(req);
 	}
 
+	return pdump_send_response(req, ret, peer);
+
+}
+
+/* Callback from the alarm handler (in interrupt thread) which does actual change */
+static void
+__pdump_request(void *param)
+{
+	struct pdump_bundle *bundle = param;
+	struct rte_mp_msg *msg = &bundle->msg;
+	const struct pdump_request *req =
+		(const struct pdump_request *)msg->param;
+	int ret;
+
+	PDUMP_LOG_LINE(DEBUG, "primary pdump %s", pdump_opname(req->op));
+
+	ret = set_pdump_rxtx_cbs(req);
+	ret = pdump_send_response(req, ret, bundle->peer);
+
+	/* Primary process is responsible for broadcasting request to all secondaries */
+	if (ret == 0)
+		pdump_request_to_secondary(req);
+
+	free(bundle);
+}
+
+/* Callback from MP request handler in primary process */
+static int
+pdump_handle_secondary_request(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct pdump_bundle *bundle = NULL;
+	const struct pdump_request *req = NULL;
+	int ret;
+
+	if (mp_msg->len_param != sizeof(*req)) {
+		PDUMP_LOG_LINE(ERR, "invalid request from secondary");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	req = (const struct pdump_request *)mp_msg->param;
+
+	bundle = pdump_bundle_alloc(mp_msg, peer);
+	if (bundle == NULL) {
+		PDUMP_LOG_LINE(ERR, "not enough memory");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/*
+	 * We are in IPC callback thread, sync IPC is not possible
+	 * since sending to secondary would cause livelock.
+	 * Delegate the task to interrupt thread.
+	 */
+	ret = rte_eal_alarm_set(1, __pdump_request, bundle);
+	if (ret != 0)
+		goto error;
 	return 0;
+
+error:
+	free(bundle);
+	return pdump_send_response(req, ret, peer);
 }
 
 RTE_EXPORT_SYMBOL(rte_pdump_init)
@@ -469,19 +608,36 @@ rte_pdump_init(void)
 	const struct rte_memzone *mz;
 	int ret;
 
-	mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
-				 SOCKET_ID_ANY, 0);
-	if (mz == NULL) {
-		PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
-		rte_errno = ENOMEM;
-		return -1;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = rte_mp_action_register(PDUMP_MP, pdump_handle_secondary_request);
+		if (ret && rte_errno != ENOTSUP)
+			return -1;
+
+		mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
+					 SOCKET_ID_ANY, 0);
+		if (mz == NULL) {
+			PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
+			rte_mp_action_unregister(PDUMP_MP);
+			rte_errno = ENOMEM;
+			return -1;
+		}
+	} else {
+		ret = rte_mp_action_register(PDUMP_MP, pdump_handle_primary_request);
+		if (ret && rte_errno != ENOTSUP)
+			return -1;
+
+		mz = rte_memzone_lookup(MZ_RTE_PDUMP_STATS);
+		if (mz == NULL) {
+			PDUMP_LOG_LINE(ERR, "cannot find pdump statistics");
+			rte_mp_action_unregister(PDUMP_MP);
+			rte_errno = ENOENT;
+			return -1;
+		}
 	}
+
 	pdump_stats = mz->addr;
 	pdump_stats->mz = mz;
 
-	ret = rte_mp_action_register(PDUMP_MP, pdump_server);
-	if (ret && rte_errno != ENOTSUP)
-		return -1;
 	return 0;
 }
 
@@ -491,7 +647,7 @@ rte_pdump_uninit(void)
 {
 	rte_mp_action_unregister(PDUMP_MP);
 
-	if (pdump_stats != NULL) {
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY && pdump_stats != NULL) {
 		rte_memzone_free(pdump_stats->mz);
 		pdump_stats = NULL;
 	}
@@ -580,11 +736,12 @@ pdump_prepare_client_request(const char *device, uint16_t queue,
 	int ret = -1;
 	struct rte_mp_msg mp_req, *mp_rep;
 	struct rte_mp_reply mp_reply;
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
 	struct pdump_request *req = (struct pdump_request *)mp_req.param;
 	struct pdump_response *resp;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* FIXME */
 		PDUMP_LOG_LINE(ERR,
 			  "pdump enable/disable not allowed in primary process");
 		return -EINVAL;
-- 
2.47.2

