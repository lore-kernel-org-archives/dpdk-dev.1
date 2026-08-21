Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D0C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC6D40E1C;
	Fri, 21 Aug 2026 21:29:58 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 752884067B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:56 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so1586354a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340596;
 x=1787945396; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVnB25GDRIque1CRinvpZDiMaxtY92hftKxWPAKLtkQ=;
 b=zZxwebHBu7Tt5Iq3H0SgSP9At5CAhncCWEFm2/mvmixxPJAm0f7osN/bsJQhb6Hp26
 FXgFLQK9GpGk/IuFkvyZOrQAHCVfG6Z8VdctyR9NTqPFK+hal7W/U0UHZHmTCc7fYeFk
 tazFkp1LXJDvGLjRD1AbQ+64UrztC1+OEmAVACC9zEHNTMDlRw35ljP9fbUGtoGoKrW+
 1ZH6NqUTQbtgd0kKRd2yJQfQeJXtdATdgzkqWX0ckJgBzvhGwOWJDvBS2eiNwSnAd0oi
 YXhlU7EV9aMiC8gFsw/pyH8pjxyGsq2nHXyryQt9+xzzzb1ycm9yJV+9iPh+QyyvSKvE
 uSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340596; x=1787945396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVnB25GDRIque1CRinvpZDiMaxtY92hftKxWPAKLtkQ=;
 b=qdl+ivg9cBAAb/yi7O1J3gEgkmSN6v4YqtoBLMwsYnq9C4e+rhCwduxnCwbgrd3fSt
 jRx+PpuAIQes1T1gaufpEY58i9lbYnTlM7Xc/MqOHhQvh2TBvFEkKQM90PKYymj/nbcv
 BHIFz8S8k1vGNr90Oo4JIV0nyvltYxq2h+aMJZyg5Hq+av8GGo34odlnodaBDRHDkRp5
 y8ipnkLbQgUZoapiAUQfCyqdeNxORQM7lL7Ld+oCeQuK/f3TcEHiM5KqYeB2aT6qQdgw
 uu+f8dFn406uPzSxGI7gSAn2Irw9twN/MkGIufDEFxMgnaiQMG4YIzQamkM5mvLyQOnU
 4N6g==
X-Gm-Message-State: AFuF++mkDC/vXptveGNiGlTsgtqjZnf9W9KD+u3K1FTWYjEV87azXEtk
 734JZ3xpZ1dCCLjmp+MgpWYRDAV1jdhwhtnoAueKVRfr4y52cT6zq3CegN2tK18eKBOjff1Yhx3
 QHvKby8M=
X-Gm-Gg: AR+sD131gRUsOWXj4N95/44wzeuzyXObotYKU6eK5ePhDSNpCu+e19k0hq6JKkox9jq
 vsLvDyk6uoEw+2JtYMxzDtd3YK+R9BdQnOx9x2TNBdUApsK6GUABgH6KInHgt3RziVvJI7wt11q
 e0ViEMDS0PMBCpyT9TjZhXND2yiLU7dc2uWf0hFwoRUeY/TWUPnp5kh/fblw4xM0JlL9uYVsALn
 GD6NSHNGk7TtRMXFxlGXAhteccBbLVErE6mSqSCCcEnVmmJkHZ26svDhJPZwY5h32QNg4HHtnoh
 O/tq0lO4rS0L3GEadG5DbP/TzWATgtwnD0nwY89FCbjKXIlFHfIkjLQdtcxgwYhp+vLxr3vR7lp
 MPryulyWTqrn9+eHSkhR2cJqF93SVRcpXdc+RENffAS9TsdqWKtsqAZ2zkeP44t7SvEPMUJPAH4
 aOTYrusCNDC4+mKWTL3ujAXL16Lx7QPaVxh2BYAnzIYJ24u92xk824uN2ig3kk0l6GT5438K9Wu
 nJWsn7agPJeAo8tZWUrIOYqOZ7eyPZJpXS30Z4=
X-Received: by 2002:a05:6a20:9c8c:b0:3c3:b57b:627d with SMTP id
 adf61e73a8af0-3cd30063b97mr17957232637.12.1787340595664; 
 Fri, 21 Aug 2026 12:29:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH v2 33/68] net/enic: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:28 -0700
Message-ID: <20260821192646.146382-34-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 2696fa77d4..59a557a38e 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -1215,8 +1215,8 @@ static int enic_set_rsskey(struct enic *enic, uint8_t *user_key)
 
 	/* Save for later queries */
 	if (!err) {
-		rte_memcpy(&enic->rss_key, rss_key_buf_va,
-			   sizeof(union vnic_rss_key));
+		memcpy(&enic->rss_key, rss_key_buf_va,
+		       sizeof(union vnic_rss_key));
 	}
 	enic_free_consistent(enic, sizeof(union vnic_rss_key),
 		rss_key_buf_va, rss_key_buf_pa);
@@ -1248,7 +1248,7 @@ int enic_set_rss_reta(struct enic *enic, union vnic_rss_cpu *rss_cpu)
 
 	/* Save for later queries */
 	if (!err)
-		rte_memcpy(&enic->rss_cpu, rss_cpu, sizeof(union vnic_rss_cpu));
+		memcpy(&enic->rss_cpu, rss_cpu, sizeof(union vnic_rss_cpu));
 	return err;
 }
 
-- 
2.53.0

