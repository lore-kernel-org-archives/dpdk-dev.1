Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA1C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A58D410D0;
	Fri, 21 Aug 2026 21:31:26 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 846B6410E6
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:25 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848743155bcso530115b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340685;
 x=1787945485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zD9Ju5Gjj4ehztE6RosvdhQ22i/T7jSZWJPvYJd8mng=;
 b=KST9Hj973HHFJpa7cqvZgWtOOm307AEo5vckY+rQVYiTTfPv/nRtE1eCMygxRcAz2Q
 alCTWnpsKEAW1S8GqgOZOTt8/xR1W/TZXbwYuZG6esJ+/FKSPu1N92eQv9jc4ueJ3MTS
 UzRxD6rd42tzXXYyT+1TJrXZM3Ft4OYeUQLSCVUtnej14ZISGhNjlOmYflR9E6AzB+hg
 V0n/cL193D8aDKHwO4L0AwUgS4vyXvA7weNtRcfsqu+NeeeAdFY2EgeQYBQwb3OWMiyC
 61Httpg3eDxdggzLhAsTr/lFtdS2r4SoT1Tu0Y5MXguQhQGOKe/js33wamzb2oFouOTy
 GvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340685; x=1787945485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zD9Ju5Gjj4ehztE6RosvdhQ22i/T7jSZWJPvYJd8mng=;
 b=OkBXdO32y31AjRih2UOJRJ6eHO0D3Dr0ey/2XQofI8oYvZEl7+qUtkkZLJza57d19u
 cafpWbjTZeXsbUjPDBtPooXmtGeyDzndWyB6f0kMtTDF0/VRFW5TNYB4aIcVcJSnsEQD
 ysCXDWsxikDVgTKozbkOhmWS2GY2UWj7UlB0AsjzNvGpYqtC84UO3howjbgrwImAg0Qy
 UdkjOe/Xwy56piQe7FAqfM1Am5NQ2l38ReQmd4mPrmGbIFfKL76fK29PqA/O08Rrldyb
 FQ6M2ZpjrkavNKbwQVhxjmbua4/ZS8dXRjW20FP+FK2ryhXOiQ8LQvCFXCnjlm7NcMcj
 SPAQ==
X-Gm-Message-State: AFuF++mV21Tyibjrx6Id1/IFvvm/WOK3AiriL5ndQyO8OvxUQwyujhp9
 k7FVdu0uxuzoErL7DK4J/mmVknTu3pv9Me9zUEWVUrX7mMLy9f4oVdy/7/p0PDZcfPNZdtZCIbd
 G8qOpNnk=
X-Gm-Gg: AR+sD12bKWrD+ZTQGF57vM9H5bO/tmAXxKG+dnOWaUECpT1ExB0SmLXXQ50awlu7O9r
 fMdSKeDnUDpkRDz6OV4OcIzRLB/drllCvPnwSADWyD7Jnjxzf5/vhroJ3uhSE022E0le/DsP9/Z
 I91nCnaatF9Gw5+JNm4OZDoXm3ZTA9vTYCF04HHJJgQRV49oU0E/13GkJSInUn8D+ACvrtNYRDV
 AhfEVQeOi8tw05wWKWIZHSL84quAKJRtqQfn6HZLPyM5j8IaWYCyIbxgfA98rJKdOja/cCtSL/w
 +CPyGBbgJDuZJh57TmYzsgvQq27LkYmuD75oRC5Xc7cwVdcFeE0FL3kLqqNiG2HpG6c7Q0HKrVM
 0QBMb76Mbudz2k8FcktFkLVnf2guRporBWoFl0yXNZqMSGc6/pCZaKXx9U2KdstMdaGFFrIb0Jc
 hHqiZAsJungJexZD9smo3oqe/Pw1HBhAYzKcjcgFjOazXFgxDcX3CL/Mp7yc6VeBivs9OnollL3
 ysbLB13NVUBEvnnOenJkRFdwWU=
X-Received: by 2002:a05:6a20:12d3:b0:3c3:7cd0:fc27 with SMTP id
 adf61e73a8af0-3cd2fd4d795mr16592893637.3.1787340684717; 
 Fri, 21 Aug 2026 12:31:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 59/68] baseband/la12xx: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:54 -0700
Message-ID: <20260821192646.146382-60-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/la12xx/bbdev_la12xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 1116dacc4b..791ed5e5f6 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -599,8 +599,8 @@ dequeue_single_op(struct bbdev_la12xx_q_priv *q_priv, void *dst)
 
 	op = q_priv->bbdev_op[ci];
 
-	rte_memcpy(dst, q_priv->msg_ch_vaddr[ci],
-		sizeof(struct bbdev_ipc_enqueue_op));
+	memcpy(dst, q_priv->msg_ch_vaddr[ci],
+	       sizeof(struct bbdev_ipc_enqueue_op));
 
 	/* Move Consumer Index forward */
 	ci++;
-- 
2.53.0

