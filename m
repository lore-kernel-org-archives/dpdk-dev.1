Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94922FF60D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 07:38:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1AE240685;
	Tue, 31 Mar 2026 09:38:02 +0200 (CEST)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by mails.dpdk.org (Postfix) with ESMTP id A75FC402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 10:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sr
 DeqqmahcGKRrAjqUgHZ4+4/BrErSnPweBFBKuSF3U=; b=iKYDqsKydvNMW7xF34
 SAQk6jWhQTvxK9Y3z9MXvcz/YfAaaOjBwuMWtAs4NKN148GBVIiQOAoikiljd0Ag
 9pQfEZbH90rS/UA3/xONRhIP7e42Hvhg8Zc+++HDmFsuHlsVZ93Jmi5sK0eNqJf/
 5S8fxVBrloCDNEbkDNixLfR+k=
Received: from test-spdk.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3f+VP_MRp6Vw6Ag--.46006S2; 
 Thu, 26 Mar 2026 17:28:47 +0800 (CST)
From: YuanXin <yuanxin123456@126.com>
To: dev@dpdk.org
Cc: yuanxin36 <yuanxin36@jd.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] vhost: fix rte_vhost_vring_call coredump caused by
 numa_realloc free virtio_net
Date: Thu, 26 Mar 2026 17:28:34 +0800
Message-ID: <20260326092835.20567-1-yuanxin123456@126.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f+VP_MRp6Vw6Ag--.46006S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr1kZr18WF4ftrWxCw17Jrb_yoW8JrWrpa
 ySyry7XFWSkry2k348Jr18J34rA3WvkrnrWr9Igr1FvrW5GwnxCFZrKa4FvF1UArW5AF1U
 tF1IqrWruw4Du37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USkskUUUUU=
X-Originating-IP: [116.196.86.234]
X-CM-SenderInfo: h1xd05tlqrjjquvwqiyswou0bp/xtbBsxDeZ2nE-FBqAwAA3y
X-Mailman-Approved-At: Tue, 31 Mar 2026 09:38:00 +0200
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

backend may start poller when the first vq kick(like spdk), and access virtio_net
in poller pthread(reactor thread). At the same time, another vq kick
coming, then call numa_realloc to realloc virtio_net in numa node of
this vq, although virtio_net is already consistent with the first vq.
numa_realloc will free old virtio_net and set its member to 0, this
causes the previous poller pthread to access NULL ptr(latest code is
vhost_vring_inject_irq).
Why dev->flags & VIRTIO_DEV_RUNNING doesn't prevent that happening?
Because there is no lock protecting dev(virtio_net), only vq is protected
by lock.
So, it's no necessary to do dev_realloc for each vq kick when call numa_realloc.

Signed-off-by: YuanXin <yuanxin123456@126.com>
Signed-off-by: yuanxin36 <yuanxin36@jd.com>
---
 lib/vhost/vhost_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..1312f95cbc 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -681,6 +681,9 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 
 out_dev_realloc:
 
+	if (vq->index > 0)
+		return;
+
 	if (dev->flags & VIRTIO_DEV_RUNNING)
 		return;
 
-- 
2.43.0

