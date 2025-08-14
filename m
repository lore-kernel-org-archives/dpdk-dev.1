Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BDCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61161427B6;
	Thu, 14 Aug 2025 18:53:17 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 4FA54410E4
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:15 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3b9edf36838so709373f8f.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190395;
 x=1755795195; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A/P2YTUPFxdQAJZxYrYBcFGHYJejpVPpmnnIWUBLeY=;
 b=VSmhcWUSiTwYz+nL/3F6n+7NNolG6p2fSe6+ebDx5HKikZM947eoSM0NntZUCnwyln
 jppN5V/bKKs+2ZNPxOGw5a4nb6YwDBh/XChaZEVxcIFISpqEkVDQNK6yWDvL7YWIIIto
 zca3DgdpdnWoWEzhUdipw+zh4e2rzZHXh+Mw/I216yT0apkSKfa0n4SH7SDr8Lnz16Hc
 vDJd3+AsvZpV3iUhV9ADjSoNU3LOMswgM0pp4/MrlRqwOfcAW4+h3WuAPVYfTMO/ldpW
 ljy8Bjyh8rAMaXMKyPSym+I/Qe/b6pSe/VOt73XCI4XlceFzac9Qda1rGpXb3k8yQBN8
 PKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190395; x=1755795195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2A/P2YTUPFxdQAJZxYrYBcFGHYJejpVPpmnnIWUBLeY=;
 b=TsibuSH7Vzc7oPrYm0N4xHfGm20xl4kttYpxeLCg6ulncmniNBmLqtHct1emJ54D4U
 /jiMMGurIBdCX+gmTuGqIlRO+zo9cPFxAZJ+owhtXV5GT6UJiaEsVMwVvD308b6zSH2k
 j8L7YaBw9UV2Xs8RVL6uZ0xGMw9QxcK9D4t2t7cUkfmXJdj9AyJIuDGlYI8S+t4D2WRA
 G8JR8W/m5IDHTHeedTPMrS1MjTgwUYOl2F8RIJDyGKf3QwOKaHzZrXVKFDMVbS4cOP+B
 9L0r6ka9Y0yF+VAns2Wx8vFBG8FGGtS18+GiRgMcz64xf6e5ZfXGiBELPcJtdWGQeZVg
 4NmA==
X-Gm-Message-State: AOJu0Ywhqh7g4mGS7CjxL1C1S43v3lmN4r8DkxcldPhsBPfji6zQVwiS
 Wv8x5CAnzzQz9Q/P9S77mSXC1OUVrdwq5YcvrCUWV1l0fxBu19aSCXUR1RYEIC/8Eyyfhid1QFH
 BnUMC
X-Gm-Gg: ASbGncsF/nPfgQxB+VMBrtDznvm8c3UVwxRD6nlwgoI3L54bCGIcjw3MR4V4oFYNqiK
 2OoL4NQPtMfLcAQ1FcHPid6WPfJGLmBG94U0uM97zhnXR20luqCNn59XwY0OpLvLLqxm/gvTREu
 Hj78cF+JtUk5jm4iSthL5yr5BJEZEGBOcp1Msc0X7OCDflCHKyQetNL8J2b38+YlbogsXcYkckT
 JuTPqFRAv6Km8oRJmWgqXPrTmCIx9dYNhYTpHWy9r9R+TzRRbsc2qbwnr1w7d7TFBOC8L/rngwg
 G/sFZwahcpRkrwBU3j6ugerFXG2YnaLAsfA/jLntgKTjZIMIndsd/+iczmYBUSA8VAJPLUh68Zj
 8Iu2X2GbmY5UtwfHaRjjhsP+HUpSRW3+/kebsMfH6tbAxUCUUrPydIc7/IY1rrtBl9rqJ5RV0SX
 HCQaqSQ5Y=
X-Google-Smtp-Source: AGHT+IH7MvgJI/RmVO/qHEKN9V1Q6rl8NRP9wXnETOYvvMsM9/dNfXyTBsekL4WbUBJbNQq11qCVKQ==
X-Received: by 2002:a05:6000:188e:b0:3a4:ee40:715c with SMTP id
 ffacd0b85a97d-3b9edfb59d6mr3561483f8f.14.1755190394840; 
 Thu, 14 Aug 2025 09:53:14 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 1/8] dumpcap: handle primary process exit
Date: Thu, 14 Aug 2025 09:52:57 -0700
Message-ID: <20250814165307.12786-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..7b19c830b5 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -1058,6 +1058,10 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
 	cleanup_pdump_resources();
 
 	rte_ring_free(r);
-- 
2.47.2

