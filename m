Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D9CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF2214067B;
	Thu, 21 May 2026 20:07:19 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 371914066B
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:16 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so21648809eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386835;
 x=1779991635; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=WQF0G/2SyTKRri1+n/C1Dvrr5ZTEZFfbHuHfZIvgJ2naAu0yRq8Zwzve/tlmamV5bg
 mdyLggUqdO0smgEQ9y16rpX0jcUGgFcRryRKm9r1+SVbX2HLgeA87cYggreUrUfgnUsg
 OwJ2nWnizaPIntHkRqetjOfAPKFbkNgjAMXcsdRv3zWWxrk0akOsBXDSwkU84Td2hzQD
 0QyDsOFNwqpHfzHZi8rcOnTactsJmaZde30pPTaFbvgfMa6aEso76hULcWQhYzVJ1hFz
 N4svtf/txpDZqnXpct6lIEUkowzdaPY8eRmbyLvfgA8lyKNavjyEq/gmVSnC/XQ9Fmkm
 0/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386835; x=1779991635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=MahcGg4x/0F/mfffo3Br7+I+6Dye5JgLMhpWLAbKoHK3kUkt78UeaiHC6z2p5EopM1
 cBHIprI4RmYwSssFn3PEAUllQDvAC0OiZR4Y7hmWNbxQaBkyMDy6oJO+ACWcU6kzFlmS
 s1nMDOaUeJvxr/dMrlNi/p4lmS8p798txsS4fDLaKuiVavuQ2NkACZp+LZjPZnbW+328
 gN/AQgB48/AozZPZkDe/mjyT0BqbMpsMPs1EQWqOZqafE5PGxLO7IKfrzkav3QVeTSXo
 vi3taJfwKXRGxDezsWH6ERVxNEg5ZRH1iOzv5/xON96WJn/GqN6BrvYmKrDVzyfxhE2Q
 3OBQ==
X-Gm-Message-State: AOJu0YzaQ+fb4HLmqUNErCCQzfgAkloxFTUrXDUNFgFpk7jzu0+4Ee4X
 1dLBoWJ7aAHssKj+AAxxYab6sMdH9Tp/MHsSV2A7iPrlBM96D7h3i66TTvmhFbdKoD+jtxXIleu
 lpd4N
X-Gm-Gg: Acq92OGrXMxfcPy+EB5FEHlSahWq8T1KVAKv3zo5sv2dUnWi269ky8RkVXo51IWAtt6
 M6OTBgy3Ejek2OzzuuqnQKuyUJjHrQ3lPUmKPf4zjbG5eQtTA52qDxABYhP0v0AqPNvzyidtVOD
 VojqmC0PftiqJ5uQYrHrTUmB8J9TvnsOclZGXDhS0IXThHTqeaYk7dRrxUCm7n2BWerdOSBsKuI
 CxyRFI3lc+OkiveP7iNSmunChubHJS7atfVDCMjI11Veu2CZPDkQqK4oLvkuWTOvASBMlUoeG9I
 +ACpoKAZyYXj9Im2Xp/Op8F2GeGZQ08C/iN3JnNCGJ1BqqHCB9Qw6xJXtIVmAze1lTwnEERkWrV
 Bu46+HKvG4eA9Hpb/jIi1rTS7ATmRmvFsRK/J7uQ9vJk9hdyWrJt7f7BhDT8Spp/kHkuAMPxarg
 GoARfCrdD5KRztrKWmtavwYYkHRCcrCyF7apG2e+pBvMPFRjZAisifVANMyGQWtGn90nLQXjx0
X-Received: by 2002:a05:7301:7c0e:b0:2d2:ff9e:c07d with SMTP id
 5a478bee46e88-304491299c8mr122388eec.24.1779386835271; 
 Thu, 21 May 2026 11:07:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [RFC v2 05/11] net/nbl: remove unused rte_atomic16 field
Date: Thu, 21 May 2026 11:04:17 -0700
Message-ID: <20260521180706.678377-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

