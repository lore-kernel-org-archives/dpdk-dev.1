Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B5C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2FCB410DC;
	Tue, 29 Sep 2026 07:41:55 +0200 (CEST)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by mails.dpdk.org (Postfix) with ESMTP id CA19140275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 19:28:15 +0200 (CEST)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b8f5ae6fa8so1399299e87.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790616495; x=1791221295; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NCr9pGro3+MZVO8Qe4/dKdwv3eRztV9OQ6tJCEQcUJk=;
 b=gcngAZcuXiXjScKWwDvNy9TQ0SwyTnSeayrfZ8z2R0h8FJeNRHPsJPJMu6l7JajSTJ
 dPHlQvZNOhLku3Qj6w9bp0dK2tt5xa7JArhpHBnHjkwJSl68NenTCLzzC2MxJZnGJUKk
 kz3oB+f4cpXycIQIZVF5wvcFHAzlFPeHpF853H/uJqbGxijAi+Nz3VE4UaF1jhrC4iWs
 HZgBxXYIAt7zGbsfpjCKsT04pO/3LsfTOOvMbkfvJqVYXLEOZtNLezQzYAbjHeQeKmmA
 p3BWJax2B+FRMNlFW0dMfMrXki8CUVbimslaupdqU/IWLOR9UBS50zeQxpUzo2j/+Mq6
 1XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616495; x=1791221295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NCr9pGro3+MZVO8Qe4/dKdwv3eRztV9OQ6tJCEQcUJk=;
 b=zDof7LPYD67h4xjFXLoQSCr0mfn++ecD+g02OfYHxThAhYPtPsPaEFCCP15dgSqWvc
 qOvTnpjL0+8+0nRjEedJoMhNkz9xY6nOM2sAJXwBryOL5ZMeICDP7/uMHFWyx7WIQaCL
 f+56i0DP2UN4p4aYisQ7QROLZCQLNe0nTjMP0GBLR2kQS+kWjwLnMciE/ZGySNhpRf40
 hF6NeFacwnU5d9dbYySk2KfV8rensehr5CAxwKuAc6qfep4tLRw/BFUDOFyA2jjQpT1P
 rml4rLKJ2b1/HC7vobAPvpuswVoaXp15TPwNoUd68LlF4PZjAPOWVkEoqsqDaY6tsxwY
 epAA==
X-Gm-Message-State: AFq9FYKn8I2PCBKNymBQo3lCGX7E/uJvDQCICsbOGGvpi8ZojCZ0OpG4
 rsbhAL8yFTqbCYe7BDVrfyyahASbIkISev9Bcw6lDQS30L1YsvrheIpMN8vs4Q==
X-Gm-Gg: AYBFou0Fn4duRcl6lu9gCh+Vo+CPIt8N8spLIK6bOWFNPfq81nzQXSyqMWogSxu+yAJ
 d9wndXL6a97riWWkV8HPPhmr5fSRp0Oi60lgj7ROMqAqrT5onvPr3m1J1GtFxf6ox2lAsSI1vw8
 +NnYOi+MjEYWhVfiQ+O5jiPrJFsHelyZWES8fGTHdbhEM1H1ZCWZ5Q9pPMRcQyIEgmzrz+sW7ur
 Bg4DbQnAyZU5kXo8sMnUtRWkuvpAccTdvEXjCNhb69WtsdodOe5aQFKV+57ibU3kEARy73DO+O6
 sXEDvRAwC3dl0j3fnJdhLRlSDfVTLgMyzL9UKGLR1dknF88r3mXY0N3G8U4qA564+1qaT64SMdn
 2Qf2n2AhxPJTl4y6xW40EFiFpM3UjC1ktyIj+QYhHyUq8PlupVfOyJjVlLSnCmZS0t/aXpN97DU
 siMzxufSFRvzH12UH7p1BNnK9C8GU2yDf6Lmfb/wpZlh4sBdfprtz5mVONexpk2+s6Oxk=
X-Received: by 2002:a05:6512:2210:b0:5b8:eb98:9bf8 with SMTP id
 2adb3069b0e04-5b8eb989cadmr3361344e87.56.1790616495027; 
 Mon, 28 Sep 2026 10:28:15 -0700 (PDT)
Received: from fedora ([185.61.79.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debc0ec1sm706837e87.68.2026.09.28.10.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:28:14 -0700 (PDT)
From: Omar Munchaev <omarmunchaev@gmail.com>
X-Google-Original-From: Omar Munchaev <omar.munchaev@gmail.com>
To: dev@dpdk.org
Cc: Omar Munchaev <omar.munchaev@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: use macros to get field values
Date: Tue, 29 Sep 2026 00:27:59 +0700
Message-ID: <20260928172759.3369704-2-omar.munchaev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928172759.3369704-1-omar.munchaev@gmail.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 07:41:44 +0200
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

Currently, in ice_check_fdir_programming_status,
descriptor fields are accessed through direct
bit mask manipulation and shifts.
The ice driver has macros for this, so rewrite the function
to use FIELD_GET macros instead.

Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 37 ++++++++++++--------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 882af80833..f14e5e56b5 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4465,36 +4465,27 @@ static inline int
 ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
 	volatile union ci_rx_flex_desc *rxdp;
-	uint16_t qword1;
-	uint16_t rx_status;
-	uint16_t error;
-	uint16_t id;
+	uint32_t stat_err, error, id
 	int ret = -EAGAIN;
 
 	rxdp = &rxq->rx_flex_ring[rxq->rx_tail];
-	qword1 = rte_le_to_cpu_16(rxdp->wb.status_error0);
-	rx_status = (qword1 & ICE_RXD_QW1_STATUS_M)
-			>> ICE_RXD_QW1_STATUS_S;
-
-	if (rx_status & (1 << ICE_RX_DESC_STATUS_DD_S)) {
-		ret = 0;
-		error = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_S;
-		id = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_PROGID_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_PROGID_S;
-		if (error) {
-			if (id == ICE_RX_PROG_STATUS_DESC_WB_QW1_PROG_ADD)
-				PMD_DRV_LOG(ERR, "Failed to add FDIR rule.");
-			else if (id == ICE_RX_PROG_STATUS_DESC_WB_QW1_PROG_DEL)
-				PMD_DRV_LOG(ERR, "Failed to remove FDIR rule.");
+	stat_err = rte_le_to_cpu_16(rxdp->wb.status_error0);
+	if (FIELD_GET(ICE_FXD_FLTR_WB_QW1_DD_M, stat_err) == ICE_FXD_FLTR_WB_QW1_DD_YES) {
+		id = FIELD_GET(ICE_FXD_FLTR_WB_QW1_PROG_ID_M, stat_err);
+		error = FIELD_GET(ICE_FXD_FLTR_WB_QW1_FAIL_M, stat_err);
+		if (error == ICE_FXD_FLTR_WB_QW1_FAIL_YES) {
+			if (id == ICE_FXD_FLTR_WB_QW1_PROG_ADD)
+				PMD_DRV_LOG(ERR, "Failed to add FDIR rule due to no space in the table");
+			else
+				PMD_DRV_LOG(ERR, "Failed to remove FDIR rule, attempt to remove non-existent entry");
 			ret = -EINVAL;
 			goto err;
 		}
-		error = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_PROF_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_PROF_S;
-		if (error) {
-			PMD_DRV_LOG(ERR, "Failed to create FDIR profile.");
+		error = FIELD_GET(ICE_FXD_FLTR_WB_QW1_FAIL_PROF_M, stat_err);
+		if (error == ICE_FXD_FLTR_WB_QW1_FAIL_PROF_YES) {
+			PMD_DRV_LOG(ERR, "Profile matching error");
 			ret = -EINVAL;
+			goto err;
 		}
 err:
 		rxdp->wb.status_error0 = 0;
-- 
2.55.0

