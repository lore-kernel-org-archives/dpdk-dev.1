Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F93CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F0842F91;
	Tue, 29 Sep 2026 18:40:36 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 3D40842E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:59 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86e6d007703so2064892b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699938;
 x=1791304738; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=iJ+e5ZGqSWgSnu2nXevTSUux1bsE/Vy5ZJ91Z7jYwRwNFblrP4BZHNY6NqpLonYjWa
 91ENe9YA2UQgUgB/uB39f/XzevDLIxbZw/nhcJ7Dg4rFfBaJmodWltmt7UK7y/BBSdIT
 jWBViUzJ8SZK3kgPVQbZ6YdeCHZbhcjdtxiWntHhTcJCz2is6p9CTPLaSwExraTJu+fv
 rpgPPDklKzzXbajGsGMvMZplMTMOPKBDdAMDJXzOo4sWhR+Z6RqLHerqnRmBtzxPXvOS
 qcfRIq6uH/hH98+G8TnF1IiaHzFlxVrOo14HWP3rb0CT6E1NP8TI+SD6YRJRo88Bl87h
 ph/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699938; x=1791304738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E7LdRaVIiOnMmTXoirBvKNaSBDsLcUf7FAS5HHnsk00=;
 b=QWMpv6/a/KBlpMDrTn00Pk1etuE3FymfFj3jiBCpLMpliffdVCx02aHpSal/AB4fyu
 7zSLTCT4mdBmtNST1o9GfKh/Pa48CAfWooC+GrUQHHux+PVaZKUKq2Le115hvwnJvTKQ
 bzE4TGerHP8VWA7lBxK98AzN4GHyu2paQYfEjqlysLh6HjLEBa1P9zirVcWlQbIqvS4m
 Zn5IJH1HhOYYlnh38Luif3VeE3b9YEnuVTK/b/u/9RLzL7TpfKVQ1dzIVn/rKYrJFXXX
 gfjKjZV7Kspe2QBEXXkJyj6ibNnrJlx1Wq0sTF+9Xaexm8sL1ks0A9SaUBwEmDcwXCSx
 Cnag==
X-Gm-Message-State: AFuF++kjkV195vKaCjWTqSP0mf3JduWM3nZwqNzZCkpuhlBWPc4yBdaW
 lM2uxSrNMqqCpeYmpU16zUEuedpJXIj6Q7MhjmjKoZSpKGUckHMQapQzPmTDPbk8uJq4Y2GGJho
 VIJmuf69dhg==
X-Gm-Gg: AYBFou03JDe+eKlmmFzM6spcsr0ojPm283gpBWFeGwTLZ+syO/9EkWPzZTP66dmwBcO
 rSPsiEtRki7Z/CQhvqp4A67cTe9yIVc0rnWRtXyXzv1JpFvWTJyUNqc4aPLNA3r8kxI+UJPIH5i
 GWl/HoiS2OAR8martkrbsnr/AH4eeMGJDXvAWXwIuwar+ykuveNMgs37+bb1kFJ2SeC/7tW3G8s
 JTjHfErTZ+m13aCuZQxbUEV4xVs+37xmnURVkOsbGSCfrcM189MSOaMJ3rrR9C0TTXLskuUjqBd
 WjiImxWRm/cro8+BhDsSvY0cTIVqlllr7wLS+1+OK7aHrbP5z8CbV6VeBjN/ybBeV5CRZaZlrEQ
 8mQjt8Z+vq3x3KiE5+96rAPcH6myf57aOrgyccdZ7R8YWI6SSsDGUiCgX+OqdW/uKlxB2YBTgzj
 0yooIV8PT87f2Gk2KQM11cuZsyjzIMdpSuQRHAdwFjfOLzLZf1JoEYbSEzkV1LZcN4KAFQKtAZ8
 yd3aWmY1GqlFJdYpN06NdwQykDkp3c2UOvVan49lQA+iFUL
X-Received: by 2002:a05:6a00:c4cd:b0:880:6b49:2051 with SMTP id
 d2e1a72fcca58-8806b49257emr6367984b3a.35.1790699938342; 
 Tue, 29 Sep 2026 09:38:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v2 57/61] crypto/virtio: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:37:00 -0700
Message-ID: <20260929163800.1108305-58-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

