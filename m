Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE7C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5F1D402C3;
	Mon,  6 Jul 2026 12:47:33 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 1929E4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:47:31 +0200 (CEST)
X-QQ-mid: esmtpgz13t1783334847ta9e22eb9
X-QQ-Originating-IP: FUE2uuK8QfoX7tBxJDkQBEF56w8cIuHKVCjZJ8ZPX0E=
Received: from DSK-zaiyuwang.trustnetic.com ( [125.121.223.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 06 Jul 2026 18:47:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2941323596488110449
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/2] net/txgbe: fix coverity issues
Date: Mon,  6 Jul 2026 18:47:17 +0800
Message-Id: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDqtQ4jGWXAGdZhmMDvNU4WGYmByuPHw4Uab/TmCAEwa/4TpgY5zDN3c
 ok9V+0eMvt8s3KKYOteP5ZKuN5ZreB5L4fsYRypNr/XdroFXp4y+ZPGxZySfeI0YywLkrAG
 dzmUb9tx2ZNuRZN7zaho72qhx6PG7ffopXExdZTa9/I/1W/sKp2Q8thDt+D6uRGjiC3v2zq
 fnv90Qn031jMGiHiVenpH9paQbOZvC1sD/8m43ksogCiNxdnqdIkx20ei2wAwYcc5IN+phS
 EvrDeKj8p0ufYuE7/8KG9VurlBAXLy/jZKbTRT2arLJKFlnlIivcjY/0YPemvTQRMvnHdhy
 33hRpsz5rqaodBJT+BQABhNBMGvckDINd5K3JXFvISYGkAI8zNxMmiveEmCFFTBC/Wyfjs/
 TWAam6l7vwXc0w5zFLDX9Pu3HwauyembFLrzxUaJ67DJ/yybKeQI9pH627qG3ri9cSokQFC
 OYAlZTNbz6phmnc4bZWeRuxtbLuDNgMx21kAuJnpfAxL763DvZVG6GP9lR/etCsPJk01TEp
 ORGxulD6PPhlk5XYLO265Ha8mNMbz9rlSXq1rH+7edvFMyza80dhllzn4X0y7GpiR7+Lhwu
 YXyVUpop3fnZ/jmET6VaKTbxTtJ4qRGxFxjn0VkYldUTF0PE907W+UkTmJPyweFhPz2y0Hy
 M7U61bwelDIe1TCTGuo6dsJjVXD+ZNQ2Hxay/pzeIlxJuzq5RRBeTbP/WipiRA0L7MTVy/+
 X97Q+D0yT2jqEUMQSI4c6p7dl3WNW+bwQLp3a47QF47+2dXRRFw52Mo4D0B0nOXyyxTc4n7
 Ewqpk11y82VDg7TpWhcEai8Wu690qR2iIcjXhPxTtKNAP7n7BsxOV46rhCvitXt6NsPWwy5
 fahKglWKCEqUJ0EzXyo3EN46iPg2q1LY0UUVTtZZ48TKWgfmhbGNj6Y7yETPJGS816zH6xz
 LAIoojOSaDbh9VgrX3Ff6jUGHA3IUheDhwcXZCRe7ELh8hFuzPQ0zEcdSKWglqaE614mfXT
 Bo4JEB533iSw4bqzZynbFoek2QS0QbpPbY8Er8OA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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

This series fixes several Coverity issues reported against the txgbe
driver in the 26.07-rc2 release.

Patch 1 fixes a REVERSE_INULL issue (CID 504601) in
txgbe_dev_setup_link_alarm_handler_aml() by moving the null pointer
check before the pointer dereference.

Patch 2 fixes INTEGER_OVERFLOW (CID 504602) and BAD_SHIFT issues
(CIDs 504598, 504613) in the e56 backplane code by validating
lane_num at the source in txgbe_e56_cl72_training() before any
GENMASK operations are performed.

Zaiyu Wang (2):
  net/txgbe: fix null pointer check order
  net/txgbe: validate lane_num before GENMASK operations

 drivers/net/txgbe/base/txgbe_e56_bp.c | 6 +++++-
 drivers/net/txgbe/txgbe_ethdev.c      | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.21.0.windows.1

