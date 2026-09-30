Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4EFCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FAA94326E;
	Thu,  1 Oct 2026 00:44:49 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 05A524324F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:45 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a498cb99b3so1324402a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808284;
 x=1791413084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=fLTFpYfljvPXVZ6JDP1JP32hWrVk3Ozk1xLm77wabylr8Xa0RXUmZRTafdiohQwrYS
 vgT9Mmt9zADuIxDJqqQJTWmjIGI7ilENO9Gx9eQZFmEfA43IzOncx73aKL/QinvkK/Z3
 NdXdlwXk9cDR/7jGWK4NGV90KOW2z8w5NQ5H1PFPXXk0X5Iqgw34ymLxbnkvAV9/iM4Y
 QVjoVYq7sh7TraIYtIlwdhD9La50YG1s/INACsb5mciMCDgj741XcMiKLf9Y1CjIMoOI
 vkz/8W9vJGHfoPOtdlEriZQNErgcOsF2CJdmUO1Hg+T46m6bbpKq6LhZY+hUp2gw/diG
 dhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808284; x=1791413084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=TEQiCjXIAiQpCpNfVzbFNg5i5oVU09o2BBiSj6DrumKYpX4A0CCs8zBN/30/ZlMwHZ
 thjRVSHO7SHyIe1P910qutb6w1G/zOwQ4rhV93J+q6bb3vG1mitmrFJSvihvy6R0Ejmy
 NyfmjtxPM1Ad9OQHc9wm8Yf5BgiqOMN/Wb6Mtc3DYCzO3SNNKRdn3Et3efBAtIJBYURV
 F4Glw0HNKHvIaWkyfhGkztcp3DMxRT07gjBKqah/7GySM+uhfN+/bHEpCNN1yRRy4kBN
 e4Qj4qMpQKSC1Nlamq15B10nCTfsKBUSGcOoYY93V6VsxM3Ux9OIXNpsYNhFx9cwTntv
 ilPQ==
X-Gm-Message-State: AFq9FYJI2S/VmqpiYlKr4ve7G/IkHq/d8ROyw+rJ/ADWH9FWqr2hT/st
 S8RBhf4+karyAVfvCCsU+51chcqLWRGpmIf7NtmQZv7wEHn5YgDoDo14YV/1jW36krgNlKHwX8W
 jAPeY548=
X-Gm-Gg: AYBFou1Rx9LW4S3yVyQ7bI3piATEeRHvikOQBY6F82yA8NmLeoiCOMYRpej25etkgIK
 yOgYwLiqZDzP/QhI5IerPnL20BLSg+ZBx4JgjhgMSEpd7sxh7txaCD5i2/boyUmDUN4NgXOtXKP
 DioHA3SQX1jg/K+PkzlgrlBE99RVrsUB07SWPt2Mm5jxEHknwf+7II33e/UX3IrvSTsOnmnBZ/7
 NFPFoUOvoMkxg/bwcPA936gK3JTcFfEF74Omc67jOSp7eGfcnh5+WSsSykdwP1PAE27n+CbocP4
 GJxTHn1H22LN1F3HbJA25fq4fYcu4ng+z8Oftp4+hq3ycwvlC1lKlLpDSCRwke1ELmF5BlXq5gi
 EOZ5j1EOWXsYa1W2URU8ZSdDeX1d50qTrhlPMIdpyRY/cwuDckDvcJvmGSgEbU3m1ugslyKrZer
 xGWtRuhhbAY17xJDl7M+6KP7ApHt5pz/WcqCjOEiskaaY7vNev2esWF2R0aBTiokZa3xMbpJ2ew
 h1ZX0taHXqb2g25PWwsUxzJamFVG3USgnIbeg==
X-Received: by 2002:a17:90b:3ec2:b0:3a0:b40d:827 with SMTP id
 98e67ed59e1d1-3a4d059c0b5mr1794805a91.0.1790808284157; 
 Wed, 30 Sep 2026 15:44:44 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v3 58/65] crypto/virtio: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:16 -0700
Message-ID: <20260930224340.58580-59-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

