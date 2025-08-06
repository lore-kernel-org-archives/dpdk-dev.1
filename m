Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7DBC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 07:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B40840264;
	Wed,  6 Aug 2025 09:56:44 +0200 (CEST)
Received: from ns2.wilbury.net (wsk-files-n1.wilbury.net [95.216.42.37])
 by mails.dpdk.org (Postfix) with ESMTP id E4BC140263
 for <dev@dpdk.org>; Wed,  6 Aug 2025 09:56:42 +0200 (CEST)
Received: from webmail.wilbury.net (localhost [IPv6:::1])
 (Authenticated sender: priikone@silc.fi)
 by svc.wilbury.net (Postfix) with ESMTPA id 7C6CF4BD06;
 Wed, 06 Aug 2025 09:56:41 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 06 Aug 2025 10:56:41 +0300
From: Pekka Riikonen <priikone@iki.fi>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
Subject: virtio_user exception path with external memory
User-Agent: Roundcube Webmail/1.6.11
Message-ID: <0e15cd8e9def8c16b15c028206a6d308@silc.fi>
X-Sender: priikone@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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


It seems that currently it's not possible to use packet pools allocated 
with external memory with the virtio_user exception path use case, 
because it ignores extmem in virtio_user_mem_event_cb() (and also in the 
kernel backend in add_memseg_list()).  This is easy to test with testpmd 
with the --mp-alloc=xmemhuge or --mp-alloc=anon option 
(https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html).

The original commit that added the check (5282bb1c3 mem: allow memseg 
lists to be marked as external) talks about needing file descriptors in 
virtio that aren't available with extmem, but at least the kernel 
backend doesn't seem to need any.  The patch below fixes the issue for 
me with with the exception path.

So I'm wondering whether ignoring the extmem is actually needed, in this 
use case?

---
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c 
b/drivers/net/virtio/virtio_user/vhost_kernel.c
index e42bb35935..cd5b975675 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
@@ -189,9 +189,6 @@ add_memseg_list(const struct rte_memseg_list *msl, 
void *arg)
  	void *start_addr;
  	uint64_t len;

-	if (msl->external)
-		return 0;
-
  	if (vm->nregions >= max_regions)
  		return -1;

diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c 
b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index 187f81b066..d5204a64a7 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -539,20 +539,14 @@ virtio_user_fill_intr_handle(struct 
virtio_user_dev *dev)

  static void
  virtio_user_mem_event_cb(enum rte_mem_event type __rte_unused,
-			 const void *addr,
+			 const void *addr __rte_unused,
  			 size_t len __rte_unused,
  			 void *arg)
  {
  	struct virtio_user_dev *dev = arg;
-	struct rte_memseg_list *msl;
  	uint16_t i;
  	int ret = 0;

-	/* ignore externally allocated memory */
-	msl = rte_mem_virt2memseg_list(addr);
-	if (msl->external)
-		return;
-
  	pthread_mutex_lock(&dev->mutex);

  	if (dev->started == false)
---

Pekka
