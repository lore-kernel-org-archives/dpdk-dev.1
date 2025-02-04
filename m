Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DAC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 348F94066E;
	Tue,  4 Feb 2025 17:22:50 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 266984025D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 588A8205491D; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 588A8205491D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686167;
 bh=u1k0J9KHgyKMJJQ+jY2M9UbJp2qABMapCrIFCPl7Huo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V68v33oJd6/fqJ1BG1Z2osM0fuUWxJPMlNLE7tNAXd4eb7LyF36KzMNqzTuoUACpV
 MkTRFWD9txbO9kJEiPwLJ5tjKiYYFhYWUsUk8eoumc4Li3zLFL1KO6Fyf/p0JRnz0l
 Ia7ECddjqy/BtMN+4uA6j2LdPRgjkPycuhtEKkUw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v20 03/27] eal/common: remove use of VLAs
Date: Tue,  4 Feb 2025 08:21:40 -0800
Message-Id: <1738686124-16173-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ../lib/eal/common/eal_common_proc.c:695:15
    : warning: variable length array used

As msg->num_fds should not exceed RTE_MP_MAX_FD_NUM, replaced
it with fixed size array.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index d24093937c..201973c5db 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -692,7 +692,8 @@ send_msg(const char *dst_path, struct rte_mp_msg *msg, int type)
 	struct sockaddr_un dst;
 	struct mp_msg_internal m;
 	int fd_size = msg->num_fds * sizeof(int);
-	char control[CMSG_SPACE(fd_size)];
+	const int32_t control_sz = CMSG_SPACE(fd_size);
+	char control[CMSG_SPACE(sizeof(msg->fds))];
 
 	m.type = type;
 	memcpy(&m.msg, msg, sizeof(*msg));
@@ -712,7 +713,7 @@ send_msg(const char *dst_path, struct rte_mp_msg *msg, int type)
 	msgh.msg_iov = &iov;
 	msgh.msg_iovlen = 1;
 	msgh.msg_control = control;
-	msgh.msg_controllen = sizeof(control);
+	msgh.msg_controllen = control_sz;
 
 	cmsg = CMSG_FIRSTHDR(&msgh);
 	cmsg->cmsg_len = CMSG_LEN(fd_size);
-- 
2.47.2.vfs.0.1

