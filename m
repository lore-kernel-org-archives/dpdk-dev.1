Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B16C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E58E42DD5;
	Fri,  4 Sep 2026 21:17:25 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3890E427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:24 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso12711445ad.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549443;
 x=1789154243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hi+KZkaWiXifyjtmuT91wxABxGa7BseSpduA/fFWas8=;
 b=Nzgm+WNRzYkyd8NaybotHw2iT1aK5HecGBduPN3mXd1nH86g01axkXLjGa2/MWQDFO
 XZ5LPQZP5Fy18l7tUumhBbMO9Zz0sFBvXDAdhLo9ABg76zCxZWLOUQpEFlsrBh7kp0M+
 onYQzf+l/rma1HS5042sh7gv+UFMS6XhbdSzNOnDSn1dyh+cJaFaWqe+OvYRiBHqutdY
 tcjWiGQAPQ7jZ7lvYyzJBiDHlMAbsxkatDlWH9xXu+DWfDZwh7frGWqf8+Zp/mmt6avm
 QvTsZkKd1GLrb3ApDycknEelVzajk3GKl3JkTwwFbl7+wpU56Bw2FoeBvhXE3xEUh3FH
 hQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549443; x=1789154243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hi+KZkaWiXifyjtmuT91wxABxGa7BseSpduA/fFWas8=;
 b=Eb0jGdAYM23umAP4hH5ZDVoNvGmezyWjA57zp0FuYq5Dix9GdLSUjgfJUUm8gRQyrW
 yn1VF/mYQp0SULQGuw143nyC/Bn6P6TxJTZk1UNtFPWACqwq+y240bMoCEH8uo6DlGSK
 fl9FZgyJL9FXEpb6nAWYR3y0bIkKLCLzkhwYXLHSsIbuZc7mA2Dy2sW41Dj09E6AGf/U
 LoLw/M4efnzFegGfrbVDQ4g9xo9rYgFdrl2AM9vP2Yzvr5fu/dHNv4eYqjG2cCDLC5Xe
 Rp/zsjzAAgHdeJNJUd+yIbK+jLhEqvwhR6yip8MlLXi8EKQlGtavBsaYF/5xdKX0EOV/
 7log==
X-Gm-Message-State: AFuF++k2W4oI1rp/+mnirzIa5i08Y325KxtBJESTj7l44rdPDl2AQF4x
 o+A+85jAaDaPz4/h06r5SVXqJ+vdQxNsYyE/7InLi/q7nSe3yereyE0UImCOIt2IRePYEEQbJT+
 9AMVN
X-Gm-Gg: AYBFou0J4J2PwQpWuK0h4KVgNnMzfLsd/xtRKtwkedYisWs3KTMDZRSQzV89MZZLnSO
 n3yu+Vx2zgDGupOTJuf38gz04bXDShPujqO6fUC227qN+LRBICRPwgcfnoWNbPwC+9L6fUQk0nq
 3xBRSP/IfevigRlkyUnth43yqOT49bTpDmsaPUiUEtpZFq2b3/I4+r3lrqcHoLaxVt7uXRSEXoz
 L+bDxM1Yo9wfa0bES/m6wwlQKVwKXwTvaxKBlqIP87U4ngA30sYZO4wLHiew+hah6BCzFwOJKx1
 9JcMcfurlIa/euNf6zuB2F9zqwMOjHDUvVwpmqjBAtvoMZ70Ts6ODQVXXx/fUflemAT0QelYeLZ
 SOzZ+ULyFrtFRswYVLtVOj64z7w78NjurqPMWW0+jZmG8eDOD0icfVRr2tjO1TXy0CYOCi7XRCj
 TcbO17pdC5AD3mVAsId8VqxQ9WrQ0bTK+q19h5yrOasXLfkGTaVEBOB85hNIw58QOLJqiQbblNk
 x5Ktgis75hwtVbJVVMMngNS81U=
X-Received: by 2002:a17:903:2c9:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2db12147668mr122612565ad.0.1788549443227; 
 Fri, 04 Sep 2026 12:17:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 5/7] power/amd_uncore: fix debug log build
Date: Fri,  4 Sep 2026 12:12:40 -0700
Message-ID: <20260904191652.2399074-6-stephen@networkplumber.org>
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

The debug log referenced ui->num_uncore_freqs, which is the field name
used by the intel_uncore driver.  The AMD uncore_power_info struct
calls it nb_freqs, so building with RTE_LIBRTE_POWER_DEBUG failed.

Fixes: da4d64d0e803 ("power/amd_uncore: add uncore for AMD EPYC processors")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/power/amd_uncore/amd_uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/amd_uncore/amd_uncore.c b/drivers/power/amd_uncore/amd_uncore.c
index c3e95cdc08..b341cfef75 100644
--- a/drivers/power/amd_uncore/amd_uncore.c
+++ b/drivers/power/amd_uncore/amd_uncore.c
@@ -100,7 +100,7 @@ power_get_available_uncore_freqs(struct uncore_power_info *ui)
 	}
 
 	POWER_DEBUG_LOG("%d frequency(s) of pkg %02u die %02u are available",
-			ui->num_uncore_freqs, ui->pkg, ui->die);
+			ui->nb_freqs, ui->pkg, ui->die);
 
 	return 0;
 }
-- 
2.53.0

