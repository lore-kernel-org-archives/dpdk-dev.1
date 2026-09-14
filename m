Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E9C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B8BA40E72;
	Mon, 14 Sep 2026 07:51:18 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6A70D40E8A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:17 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb5so1320636a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365076;
 x=1789969876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=LV+iATBAsU+WPOyr6uxuT/oRQtIPvo74WN1vStv93N4+BbNMezEObo2g1KQ9O3Rl6H
 pksPjk4MALNm6KFkqfQYC9RQEUfhY71CWgYETo1zG0S0t1kIuRBSxJLXTKFGhQuph1kN
 pJmp2rZC9/PWeUadSRBXlnQrYDmO9GGm2bmP+DBZWCacRnAhmmUA09464zKISq1s+Tt2
 tnNqkKjbo3qv7E9RbmiFxkseYYElRU1Mc08TRjDENObUHDo2eHLmJBu4r1HqPUcHW8At
 UKdqChAMyRK4zlUMrHrcbZdtHTaN5NVf32f4+Aabukf4/QfOA0/0umagF+flzOUQxAR8
 0RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365076; x=1789969876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cKZnu1rTr7c/Ijov9F9quRvUzuktu9AMTFQRsUw4NS4=;
 b=DmPTvYj05OYiVWfXWR3YkPz/7Oz423PZ4cxccvNIrucIejH1iqMgiiWJvc7lZ6aYd3
 iOBXLu5x1YeUaOt5JhfnknP6++vAyyY1B451Jhqmbuntd/NHWn7a18W8ep92nwUb24XV
 nG6jDtDzCIG1S3gQprxghISFLKhR6cFFD1nqxj4T7hpk2a59bHjI+irQ5QQ+cQ0JEi27
 1c4G1TafkXC7lSEcvzSw+8b7hqLYQd36R1qEx4jpy4+kcQQ0kpHPwcVXU6/0rS6hSv9e
 Grg0/JOxSFiwH2MiVu0Ls6bw8e9/Po8Ql0cdaLNvWt0bEcEaMed4RjnHE4lKkL8wm0VI
 SUCQ==
X-Gm-Message-State: AFuF++kNmbElxR4aXF1kRFsosFVjk6Vo3YnFSmyuAbefJx0It30jo++v
 agWwVSJgntx4EqRG0c3+PWrUrTJpR0kXYnwe8jAi6MGBWwV3JPTKdcwjI0X41DYAX86a62AIrwg
 5w9lL
X-Gm-Gg: AYBFou2KlTxXnCHH1bkBvLBODrYk+KlKF7B+IeflXgEo1+vxDEeSBscKi9VRTezLB+n
 H/jkhMnVe8NR/GgchWp4fwzM+KDezTE725+R/GKJUL8n/oZxo2Ewn5R2DldQQU36yyPeeq7yz7+
 8faMRhRAbzTP6+sy5GiPSyq6kvC2FbzVUEPQ6dgYloJskhqfzWc+l56BQd6FAqYgmmuKtUkV4zX
 YuUkibfim3Ru6RGRq/VMYfUOrG5L6eLbPOz1WFnX7uZ5pTw+lRy3Up4NoymK2Ljra64UeV1G9uz
 pgapNiEH6tmNOP7+hJdBFCT69HJey9xAb23TNa1dUTMsWiEgR0B0fuq/H5jDVKSBKYJ73hsu9Bl
 uY5uoymIBdepXfyhvttvJxFYYLk3zcRxO8izHaTibqJ+eww/Wi9up483fnwabHbC0R8LuyUN6D8
 6aEwNoR9nxfAInWTfmPVptP5KlZWUgB2vtMIln5nz+/mP1WsMoe085av4Hfx6C/7jLFM2SD/nh5
 BOX6Npv6qSRNltUNl+GDK8GhPLFTJ5gL394uw==
X-Received: by 2002:a17:90b:2809:b0:39d:f2b0:5afd with SMTP id
 98e67ed59e1d1-39df2b05b4emr22009a91.2.1789365076621; 
 Sun, 13 Sep 2026 22:51:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 34/62] net/nfb: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:05 -0700
Message-ID: <20260914054912.755403-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

Replace the open coded isdigit(), errno and end pointer checks in
nfb_eth_dev_create_for_ifc_by_port() with a range checked conversion.

The "port >= LONG_MAX" test was redundant with the interface count
check that follows it, since ifc_cnt is far below LONG_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfb/nfb_ethdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index ba7c849a4b..f2ad831c08 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -965,19 +965,14 @@ static int nfb_eth_dev_create_for_ifc_by_port(const char *key __rte_unused,
 		const char *value, void *opaque)
 {
 	int ret = -EINVAL;
-	char *end;
-	unsigned long port;
+	uint64_t port;
 	struct nfb_ifc_create_params *ifc_params = opaque;
 
-	if (value == NULL || strlen(value) == 0 || !isdigit(*value))
+	if (ifc_params->map_info.ifc_cnt == 0)
 		goto out;
 
-	errno = 0;
-	port = strtoul(value, &end, 10);
-	if (errno != 0 || *end != '\0')
-		goto out;
-
-	if (port >= LONG_MAX || port >= (unsigned long)ifc_params->map_info.ifc_cnt)
+	if (rte_kvargs_to_uint(value, 0, ifc_params->map_info.ifc_cnt - 1,
+			       &port) < 0)
 		goto out;
 
 	ifc_params->ifc_info = &ifc_params->map_info.ifc[port];
-- 
2.53.0

