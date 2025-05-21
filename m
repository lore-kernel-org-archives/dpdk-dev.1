Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF3C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 07:56:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99A8440EE2;
	Wed, 21 May 2025 09:56:38 +0200 (CEST)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6724040E2C
 for <dev@dpdk.org>; Wed, 21 May 2025 03:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747791344; bh=u2tiucjdFw0HXV6UgyuJR0T61kdOE6fbfv/oy+wlO54=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TXjfKAMyBemZoX4IqrIhP5MWZQCxSit/6pyFUuqaSZGbNzsR4uH6v9hnLYXkG1xDX
 +kBG4RzPUDlNVWp0U1T1RM9usH8zngApGA9I8Ssdi94HUYurvGN0wYSOA92S8FkIzq
 Ayghd2EWUICE9dx6VLVF5ieLRutfatKTKKH91pgc=
Received: from localhost.localdomain
 ([2408:8440:b418:9d3b:387d:4a44:28bf:cce7])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 85732CE0; Wed, 21 May 2025 09:33:23 +0800
X-QQ-mid: xmsmtpt1747791203tzl95czyb
Message-ID: <tencent_A3665C1C6ABD9B1869524D2269D4A39C4105@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7wp9c/S8PB9cdk5blf57nEViUtdKjEkwIv+pKMGP0SvbtfNOxNv
 0Jz5oex2ud53l/yV0jv5fT4VLOXvGHGbg52BFSQKQXzZNIglHNUM+bkpuBqz3NV56h8Mydu34xqi
 GC3fCDJ6OIBWn1MWjZUydRlHjtDtGI6vBSZA5VUvlFKrYWcd7htFdmdmZ2MZ5xi59MOZnNRhDiPD
 Zf1Au2zew33C6GzauU1eY2EnoZdNuldu/1tCzGdqIQvyQOFVswoT+QdFOr7cQWPr7Q1JUM0nIew5
 2jXzAWpkn+UOaIPl41IkesknR4XUJMoVv9XnstpedZp9szuE7zahZRxTCjmVl4ztdLS7Yax8hmyp
 q3s6a6hb0qEQggTX36MAUCKswgYtZHMtwBj2DPOl1khD0joGObcJzsR6I9hQku6UY97WXTrOLhfv
 +aWPGR/EAxm1wS1fmxrX5SMugbE+gH3ahKMCQG3aAfReJLcgTJlLjfqgDraf2zk/QIUdMXjNs4xR
 q0728g1WK90SN1LdNn0LCPcXlkbSYwxZqRxPagH9tSncJ+9pzxc7/LHWF+94HrzQAngi+uYJ+hvJ
 6RRDhmFtP2bk6Bo44BLzipBzyyXB90bZlkR/OWTLG5gwcSsfnUTMzEwNz6OEG8XWU8zD+8bqSoTF
 3dTqD8CUckss3OXyxyOmLsKMbtFwG+BIwyYzqfiTEcDqay+Wy2lWk1KsYXZh4f+xpVYRhul5EnmE
 tMtpza8joM32q+7zk4j1eTGkXtOYlYmJi9y3SlJ9mSb14azFOMQVH/xKRreDE2/vqUbNm3y3Ijk3
 NNgwuCbe/fM/n1YmVXNdl8+Ncv0gazI2RlWidvxM0NriDSkTOJEolR8mx+W6iw6V3beDT//w7BdL
 ePC7UPpZcDcTJrqQQ6amxFFexEzpwl97ZT9FEdTVkAGSerQ+tziH9YV+s8B7bj3LAgr17LFGYyO+
 WPP+T4FpeIMaA2paUtqw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yan Lu <973788536@qq.com>
To: maxime.coquelin@redhat.com,
	chenbox@nvidia.com
Cc: dev@dpdk.org,
	luyan <luyan@cmss.chinamobile.com>
Subject: [PATCH v2] net/tap: fix add qdisc failed when create tap
Date: Wed, 21 May 2025 09:33:13 +0800
X-OQ-MSGID: <20250521013313.1250-1-973788536@qq.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <tencent_C80031E4649A04EFE84C39ACCC8938FEBA06@qq.com>
References: <tencent_C80031E4649A04EFE84C39ACCC8938FEBA06@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 09:56:37 +0200
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

From: luyan <luyan@cmss.chinamobile.com>

The errno variable was assigned a positive value in the previous handling,
but here it is compared against -EEXIST,
When the tap already exists, this would falsely report an error.

Fixes: 6fc6de7e0eaf ("net/tap: update netlink error code management")

Signed-off-by: Yan Lu <luyan@cmss.chinamobile.com>
---
 .mailmap                     | 1 +
 drivers/net/tap/tap_tcmsgs.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index d8439b79ce..32fd2b8180 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1737,6 +1737,7 @@ Yanglong Wu <yanglong.wu@intel.com>
 Yang Ming <ming.1.yang@nokia-sbell.com>
 Yang Zhang <zy107165@alibaba-inc.com>
 Yanjie Xu <yanjie.xu@intel.com>
+Yan Lu <luyan@cmss.chinamobile.com>
 Yan Xia <yanx.xia@intel.com>
 Yao-Po Wang <blue119@gmail.com>
 Yao Zhao <yao.zhao@windriver.com>
diff --git a/drivers/net/tap/tap_tcmsgs.c b/drivers/net/tap/tap_tcmsgs.c
index 1755b57519..caca9445c8 100644
--- a/drivers/net/tap/tap_tcmsgs.c
+++ b/drivers/net/tap/tap_tcmsgs.c
@@ -261,7 +261,7 @@ qdisc_create_multiq(int nlsk_fd, unsigned int ifindex)
 	int err = 0;
 
 	err = qdisc_add_multiq(nlsk_fd, ifindex);
-	if (err < 0 && errno != -EEXIST) {
+	if (err < 0 && errno != EEXIST) {
 		TAP_LOG(ERR, "Could not add multiq qdisc (%d): %s",
 			errno, strerror(errno));
 		return -1;
@@ -287,7 +287,7 @@ qdisc_create_ingress(int nlsk_fd, unsigned int ifindex)
 	int err = 0;
 
 	err = qdisc_add_ingress(nlsk_fd, ifindex);
-	if (err < 0 && errno != -EEXIST) {
+	if (err < 0 && errno != EEXIST) {
 		TAP_LOG(ERR, "Could not add ingress qdisc (%d): %s",
 			errno, strerror(errno));
 		return -1;
-- 
2.45.2.windows.1

