Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358F606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TrR0IxB3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D774F40270;
	Tue, 20 Oct 2026 08:59:44 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id BD57240144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:59:43 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-91befbcad6dso35034616d6.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479583; x=1793084383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eAMwCqetYmfjtW5fpefcG7ps24K3RWZnQ6JSNKYdHVA=;
 b=NLYKfUpQOG5ZMWMRukzs6Gyamd8po5mleUjZXmCYLyBuOSX5A2C1jFun/FzA/2c2D0
 HYyldYVJ7eXYEcHRkOkk8hEIzefGS8FC1KWZjUBK13dpxDmKFdR6A/onKqjzz2718zzc
 uZRIGEVszgOJ5c2nH5xPqoN7JzpqhxXvoXkr4Kyz0fXvd64YXrNU8jRj8zglF434ml/Z
 AlkFnJPEOxl0wNX/mZp7kfokEZuE0V4IASpGo6Tlf5vvI1SELmiMAguNCpdyTP0xZzFa
 6GGh6ka8ssjVp2k1xVPVbzGpDGbXUv21oDBA2HvW6qz3HI/Sv80iI4RGQptiapfUS+dj
 gHGA==
X-Gm-Message-State: AFq9FYLWBWgHaDuYZK9NivIiMhiZ5wLtUa5PHYeA0U6d5aAst7n5u5xe
 iCigz1BYVa6x8qpcOdOgogYmArNiA+dcntr7UEus4MFFbAp77VlKWsTzk1LFg6maeGXxzH3d5YG
 PJL9hjVdsBlYbjf0g4xiCLYc6ZBlGdydsgRL/SlD2blrI2pRd/J50U0um/1p4ZBViNrVsnqSbnE
 vaZqO+PZQnrTPlXTGZcexyaJLWSRAoANy7XhhLUJAzDnmw4LD8GnqGYQGbAZXuZaujJ2u4lQ==
X-Gm-Gg: AYBFou3koMM2JGxJpVkYanEkgxJaujB5SC6RJuAdFwM5P6NzTJ7RwQhoYuvWCMvHV27
 U1Ek2C8G++SBmbwnqCoICM+M3ayLQI5OAYGe0e9cbxYKV+k+lUJpdKUh5AMMR4nL0sgKwP9XmkQ
 MLN0YUB3I3OqrNGTLiJTYvSra0JMO5hJE7LFxStcCONKA3LCQz3wkdJIS3WQU74rW/KMEfAO8eJ
 RSSEjYDQw68G6lEFdpsGu+sdgcaqPDggUlctMvItqOR/I0UYURocNG7gMoq1neLozQVXo+er3ln
 UFyW0L7hlpNdlRH6VAgmuIjNW4vhkLGexK/++P2ZpwmWPFBiQxiOMMRrpD++vxlLaXY8NqH9/rY
 3bX6Y1Jyzh9TPKIuTldsN8OA7uR3iwaAJ5vRYdVIhkB0NNynEuQlAWcBDo4uT3OoSCOSXeoXYq+
 jOioqdowjY8CdE3wp1VN5UzuKsCM95/9kSMIXpRw==
X-Received: by 2002:a05:6214:4687:b0:91b:8afd:84d5 with SMTP id
 6a1803df08f44-91bdf0f2d62mr152220296d6.21.1792479582922; 
 Mon, 19 Oct 2026 23:59:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-91c040a2b3bsm243126d6.36.2026.10.19.23.59.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so5130964eec.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479582; x=1793084382; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eAMwCqetYmfjtW5fpefcG7ps24K3RWZnQ6JSNKYdHVA=;
 b=TrR0IxB3uRqGNpB7D2U28GueZHarO7Af5QTO7DHIBi0iVmLTl6JmbPwpzW/F/KQOMN
 Ej39dtwMiaECIreO1PJcOBtjV+xDtOpGxKgybPEKiTKsrfSeCR7TbF/qSWmeMPY06qq/
 e+3y9Q3tzvyCHinZRCvKHyoh46F2qjyZyp4tk=
X-Received: by 2002:a05:7022:1501:b0:16e:4723:5f86 with SMTP id
 a92af1059eb24-185131076e8mr16345829c88.29.1792479581734; 
 Mon, 19 Oct 2026 23:59:41 -0700 (PDT)
X-Received: by 2002:a05:7022:1501:b0:16e:4723:5f86 with SMTP id
 a92af1059eb24-185131076e8mr16345790c88.29.1792479580829; 
 Mon, 19 Oct 2026 23:59:40 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm34840768c88.9.2026.10.19.23.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:40 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Shuanglin Wang <shuanglin.wang@broadcom.com>, stable@dpdk.org
Subject: [PATCH v2] net/bnxt: fix completion metadata format type for Thor
Date: Tue, 20 Oct 2026 01:59:37 -0500
Message-Id: <20261020065937.1067845-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005235104.27284-1-manish.kurup@broadcom.com>
References: <20261005235104.27284-1-manish.kurup@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

For Thor, the default RX completion record metadata format
should be set to Type 1 instead of Type 3. Using the incorrect
type causes the driver to misinterpret the completion records.
Thor2 continues to use Type 3.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Fix the Fixes: tag to point to the commit that introduced the
  issue (dd0191d5e70d).
* Restore original indentation of the unrelated bnxt_hwrm_vnic_update()
  arguments.
* Mention that Thor2 keeps Type 3 in the commit message.

 drivers/net/bnxt/tf_ulp/bnxt_ulp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index a75da8aa19..99061f5c5e 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -480,7 +480,10 @@ bnxt_ulp_port_init(struct bnxt *bp)
 	/* Make sure that custom header data is selected */
 	if (dev_id > BNXT_ULP_DEVICE_ID_WH_PLUS) {
 		struct bnxt_vnic_info *vnic = bp->vnic_info;
-		vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_3;
+		if (dev_id == BNXT_ULP_DEVICE_ID_THOR2)
+			vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_3;
+		else
+			vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_1;
 		rc = bnxt_hwrm_vnic_update(bp,
 					vnic,
 					HWRM_VNIC_UPDATE_INPUT_ENABLES_METADATA_FORMAT_TYPE_VALID);
-- 
2.31.1

