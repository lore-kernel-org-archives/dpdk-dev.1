Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BECC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25EFB42E56;
	Mon, 14 Sep 2026 07:52:41 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 7516540ED8
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:40 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1166177a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365159;
 x=1789969959; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=kEuGX3qwi5Dxp3z2aM6ueuedg8nmzKvRJPZHnyaENQsVcEMHY9R3KvgTST5lfT0XPc
 yRCZoE45x4fgTRaEddFOVPle/7+8iANtEjRxiMAAm6vRpHrTxvbeN1ceeGwlqylQJpVD
 xudfaXoBFn31HaRu/ImCj/GNPDy86NiyqB3pG3DtCv7DcSFxzMxPedlW5EmZsMBvMN1T
 qY3zutxiEQK5ef9DFW/EU/4oPJmKXh/O79FpVMWAN0Y7j44UuSMEiFmhHXm/akAqHBCw
 CFexerns5zbuhf0ilwy+hu1TVFrqo0wbgk86MG0nb2GESjpUatieygyiLOkNsn5cIYFP
 buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365159; x=1789969959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=FC7FJVq8TNus/7siQRhBUPfcui8CnoQYu9nekZU8LUahQdUGipldZS5pGK02AAffAy
 Q+gCJrhJJKpL+WReTiewswqw2LQ233PwtxzZ1XY0dDwQcQcn6RQ3AOJ8u2rVkYLdYkdV
 tng9FzzKNT7/uJwZVdcuP8dyiWfQkdrWfP7oswflyQ6CsX/eJxUTYpH2H2icblfi6Qpk
 LVg12Vaked4RTPBsw/rlqNvYfF+KCrxd9ILXkCdV40RU9jsz0U5UKh1CDdGo6a4WhBq5
 I4/gBgbyC6JRBSDral6iB+GIH2wo4JlnLeJ+SiCuMqo4ssoJ0sNg1kVwZMqB9OeynerT
 CabA==
X-Gm-Message-State: AFuF++nKIJYrEjLX6YTqCJm/MSySm1hZPrDHeOC6MPWRoyFxbOiJRqyj
 kIbbR6VhPb/ZuTnt025uaHD8eUxjStCtlCeAQ1LUrsuR61JIi6jDhDoKt28PZiT1Eud05BDvgbR
 q4rDYz1M=
X-Gm-Gg: AYBFou2p4KbyHrkLd3oNJ6AtrtHkULWKtEnoQGWgObObqIkQXcqtwAO8CJk8+B+y+XY
 hutZtraFJMKDtcXe/Hjaw1FDwu4LgJTYWM9kus2Sa5eAjS2pJwqNd7hEbYekWLOfRoka2r6vXd+
 IaaBNyKJvJkCMNb1qHlbgrLVTtkSnZ3tY1RzO5/tleGGYXRruawdIK/n8hvolYcj5RuyWkse0T3
 o2hffEB08lODYO0ZpZEsrC1X2myiO04SO7TCXxRVWXPCttYzVGDf5z4MumCy+0FKou/ewpghGYI
 8Dsf0fiKQSorMMnyfrpVIf9HINqEqoUFKH5NcHd+Jf5lxt8ZF/uj5apw7k5giJ9SCH6vVs43DOB
 B+gEDzlkeVg+rBM2ej3xNQ/OCsDIXLdarqWziK96ssZGGtIq6cpe+EnLG68SXv06OGWm3S0JTD3
 tBZEIOIoz1tj8aQQtl2PMwpkCkTV/Rhq/pntcMkR3Pu+6AqB8ImnLPQn7gK/HgBa8zr2essySel
 IzjOo+ZUkY6cVqIEUfeKD0ZiakX0E95Z9KQ3A==
X-Received: by 2002:a17:90a:1189:b0:39d:f064:3a76 with SMTP id
 98e67ed59e1d1-39df06469efmr598404a91.15.1789365159554; 
 Sun, 13 Sep 2026 22:52:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH 58/62] crypto/virtio: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:29 -0700
Message-ID: <20260914054912.755403-59-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

get_integer_arg() never checks the end pointer and returns -errno, so a
malformed value such as "abc" leaves errno untouched, converts to zero
and is reported as success. It also used base 0, so a leading zero
silently selected octal.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/virtio/virtio_user_cryptodev.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_user_cryptodev.c b/drivers/crypto/virtio/virtio_user_cryptodev.c
index 4daa188e1d..9844debeaf 100644
--- a/drivers/crypto/virtio/virtio_user_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_user_cryptodev.c
@@ -345,23 +345,6 @@ get_string_arg(const char *key __rte_unused,
 	return 0;
 }
 
-static int
-get_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	uint64_t integer = 0;
-	if (!value || !extra_args)
-		return -EINVAL;
-	errno = 0;
-	integer = strtoull(value, NULL, 0);
-	/* extra_args keeps default value, it should be replaced
-	 * only in case of successful parsing of the 'value' arg
-	 */
-	if (errno == 0)
-		*(uint64_t *)extra_args = integer;
-	return -errno;
-}
-
 static struct rte_cryptodev *
 virtio_user_cryptodev_alloc(struct rte_vdev_device *vdev)
 {
@@ -432,7 +415,7 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUES_NUM) == 1) {
 		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUES_NUM,
-					&get_integer_arg, &queues) < 0) {
+					rte_kvargs_handle_u64, &queues) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 					VIRTIO_USER_ARG_QUEUES_NUM);
 			goto end;
@@ -441,7 +424,7 @@ virtio_user_pmd_probe(struct rte_vdev_device *vdev)
 
 	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE) == 1) {
 		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE,
-					&get_integer_arg, &queue_size) < 0) {
+					rte_kvargs_handle_u64, &queue_size) < 0) {
 			PMD_INIT_LOG(ERR, "error to parse %s",
 					VIRTIO_USER_ARG_QUEUE_SIZE);
 			goto end;
-- 
2.53.0

