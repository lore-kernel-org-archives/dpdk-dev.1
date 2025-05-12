Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC7CC3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 16:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D5714026C;
	Mon, 12 May 2025 18:06:51 +0200 (CEST)
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com
 [203.205.221.153])
 by mails.dpdk.org (Postfix) with UTF8SMTP id C5C704025D
 for <dev@dpdk.org>; Mon, 12 May 2025 10:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747038215; bh=WB++YET4CE7lMGixq4Cm9OIyK4JCoQSWaGRvcZmCY28=;
 h=From:To:Cc:Subject:Date;
 b=uF2R5E3tzrFWWnas51WMurw1FtO+5y8zTjWMHNmLi72i5kaBEb7OP9AzX46gYTOAj
 KgH0Yap9SMkW3mqM36zyMaFrTA8UZ8Ola2W0LB57pWPvACje1/2O+Oa56spptZn2pT
 UUmUMtReXsx4LyZVPA2Xpvf9q56SYzIKBJXwWc9Q=
Received: from localhost.localdomain ([183.156.209.61])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 58E9026B; Mon, 12 May 2025 16:22:14 +0800
X-QQ-mid: xmsmtpt1747038134ti78vkud3
Message-ID: <tencent_C80031E4649A04EFE84C39ACCC8938FEBA06@qq.com>
X-QQ-XMAILINFO: MlsYLnHA0UVjGBjBb2HEbj6kaQn/GkpA9wCzNL2WY0hE9qDyPE7QdjBb055Xgd
 MsuOuc1pIiO6eDO0ZJpskEsjFQlO6sFzhPuJUG7w0EF/qPos8dVUf/KrVaTiHODHaGHX8tpe0NYn
 yWlO+y3/0KPv4Z7kKAPzCFXmJvgBJaaArRPl0OrOZnfUsCGqvM79zV+ydwGMomzKKI9RqJFYiWoo
 0AC/OwFZSodie32InXToAflMCPCshU41gjUit7H1LOwxLbougEBowQuNVxNpI9h+FrSLKaZVh7TS
 2bNmW4/qVDvu9PyWePYhazUld6ur7e+oKNtX2Tq8Oyn8ObwkHLRC9dfPRdXs3DBPvn3aPMfSWU/J
 bMFmU6bO4DzHXgzeWeCGaRvnAPI+xDXIXpt7QjlTYpYMpk4zsFyom0Aaxt925IssiVoDiSq0gG0M
 6qOrehZLdmydh3C/DCnibYBgIKKmLmbrkZya8ZjNjyxn7f7gSa4QCo8T3hJqwPnlA5u0pj+fDSbg
 2O0COjW+Pz8gAz/3toIFc8zJDlqtHUMA1sUMSGVZxR30oTZQtbDUnFiavOaWRGNocXEx5WElq2wB
 q3KFyPVQAhDBiS+5VMhBKWedlfIIwRxflnOb4CpS27k0zonOVL48O/20CKBsFgOdL/MtgneITOtK
 vv/2tb6tVZOYCJxjhp7r/RywbjP6vSBhtoTBe1sIEciOxUiXGTCHdI0Vb4qAL4xJ0097hooW0DMa
 CkOZzDrJhDbZA0Ks1ke/f+gMk9Ks98P4dPJlxM+Q0/0dEKC6IIm5XpygD7fVWSv7JPtdGuLB2/z6
 yLdNyYeHg7NASO9qxbxEfNP1sGX6UdYgJJB5mFFwkvikh86UzLpSmU4m6kiTz+zruoYNuEB7RE4S
 +KFImpedyIrcaFVeYBfFmWPGlD6RET0kH2sHocUeLvmrk5ZGfu5Jbi5Zg5+VBniHolkxqPctVo
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: luyan <973788536@qq.com>
To: maxime.coquelin@redhat.com,
	chenbox@nvidia.com
Cc: dev@dpdk.org,
	luyan <luyan@cmss.chinamobile.com>
Subject: [PATCH] net/tap: fix add qdisc failed when create tap
Date: Mon, 12 May 2025 16:22:04 +0800
X-OQ-MSGID: <20250512082204.1962-1-973788536@qq.com>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 May 2025 18:06:49 +0200
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

Signed-off-by: luyan <luyan@cmss.chinamobile.com>
---
 drivers/net/tap/tap_tcmsgs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

