Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46772C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9252A42E0C;
	Fri,  4 Sep 2026 21:17:11 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1948A427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:10 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d9b60c652aso17100295ad.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549429;
 x=1789154229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nten1b0o4+zO7AEL3p93b13UVjhIp3uZ5mNFJux0bD8=;
 b=u+kTpciL0MNqEylz2VtVFsh8aOJAklFVOgE0MIt2rgYr6h9vQKqHuxSGrBuu26ASBt
 55kgHlrnUVNi0BpUXsF6JxGdAf9Z9loceWFcCYbRD4cqttzRRuN2xSsg+zV/xv+V7QPv
 qseeAamR4QHwf74VRkDqh5pYnVLrIuC4UNVhZLFQzreDEg3kuz+lfTAlYH8Q9+RbGWrO
 ja4sQA4p1foRWgXjDKC+qKwuDIt0hzuG/32srEiNlF3yum0i3DVFRN6r0FM+i+rJc3qR
 l79/BPbNbL+t6/keWT5EaMAxQbHccC1OvPHoNEqt1639+jrqvFi+RAiyzdcQRvzsHbT3
 jV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549429; x=1789154229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nten1b0o4+zO7AEL3p93b13UVjhIp3uZ5mNFJux0bD8=;
 b=FMy9a5pNdB2QumatQwNbBG3y65zRNFRfbZlUGXzyCjubKQPSlJqQIQ2mEBagYV0OqX
 GRqknatqppMaG9BXJPdhwnUFiW9sZA1Ajx3n94Suz4rDktMd4H8BbQYRs1rlYh5ZHVDQ
 y65jPq1Z2kYjnR10AMsfrDIr6UWC1jUHkRpkBx4LGuh+/GY5DBosxrLIpk647MrLDwhS
 pW2bSEHq+XnB5WBQq38Fww/z2O2eqS/hirfzIs7EOt2lOB4qmRI0EErtR4XJht1yYIy/
 ecUBv6f1a+V1l8gau/+miY55DcMhxKRvOVnElh+Gpct3QqvpnuEDJW2lL2/E4txOGw4W
 opuA==
X-Gm-Message-State: AFuF++kFin2hCgbWVtFzc5P1z+JrtZiTzvHqibOMk+HCF1W260Jcdqku
 eAEJyMlBaI0sCPhSQP3EADOQlWTUs52KsIdLxD4ivfXgrXDHMcgi6wy5aMdpsnOvzGB+faV3FBI
 WMiAW
X-Gm-Gg: AYBFou2krFE7lipe66OPL3Gy8+t/x2kYT6t2ZQOLkkz/auzNRpqqw5KVloHKR9X/7kb
 u4JcNjjg16VjEXu1O0MZFvdwPZ/0Fmv0SJn8s9OX3O1ZDU0j0VBB5hM5yapsf4DzXRxH5sO4nnT
 /UufXpIN0ymrlMVscOZ6x1z4Aw3fmgZRLr/fhZr3kGHPrqKEd0g1aqY+eIZWzkgz/cLR1+gwrTC
 5NZBDF0c7bleyuTtweJ4YEHCelJ3P+btPvy3+GLrAbGOfFgtxx06D71NwCKBmQaDYAhMCSNWP65
 is2ikdrK7McxKRZ2EdmRAOK5am0IyjgPPVcnoXM0J9NrtwUlYfuyiIaDXueRtsLR7lMw5enRI89
 G7xL0fy8FpFkObt1/CkDu3QGlhHiuRkLWNQx9UkGfikXZCGDP1wUiSr6MOUFd+ckze9BculBo5f
 jFJlZhfSyDKov9ddQ57sty43gIfEygcA066Tn/J83SMfFrjKjx/Cju8nsAq94z/NKgv9DdIFr3U
 HW+XDeAE87ZEgSpaP7Q5j8mQzE=
X-Received: by 2002:a17:902:bb88:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2db1261df71mr91911125ad.6.1788549429065; 
 Fri, 04 Sep 2026 12:17:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 2/7] bus/fslmc: fix signed comparison in buffer acquire
Date: Fri,  4 Sep 2026 12:12:37 -0700
Message-ID: <20260904191652.2399074-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

The acquired buffer count is masked with BMAN_VALID_RSLT_NUM_MASK so
it is always in the range 0..7, but it was held in an int and then
compared against the unsigned num_buffers parameter, giving a
-Wsign-compare warning in both acquire paths.

Make the count unsigned to match num_buffers.  The error paths return
negative errno values directly and are unaffected.

Fixes: a116979a03c6 ("bus/fslmc: improve BMAN buffer acquire")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/qbman/qbman_portal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index c93bec5dd3..7b666d4ef9 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -2680,7 +2680,7 @@ static int qbman_swp_acquire_direct(struct qbman_swp *s, uint16_t bpid,
 {
 	struct qbman_acquire_desc *p;
 	struct qbman_acquire_rslt *r;
-	int num;
+	unsigned int num;
 
 	if (!num_buffers || (num_buffers > BMAN_VALID_RSLT_NUM_MASK))
 		return -EINVAL;
@@ -2727,7 +2727,7 @@ static int qbman_swp_acquire_cinh_direct(struct qbman_swp *s, uint16_t bpid,
 {
 	struct qbman_acquire_desc *p;
 	struct qbman_acquire_rslt *r;
-	int num;
+	unsigned int num;
 
 	if (!num_buffers || (num_buffers > BMAN_VALID_RSLT_NUM_MASK))
 		return -EINVAL;
-- 
2.53.0

