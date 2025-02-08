Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173CBC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17E5240DD0;
	Sat,  8 Feb 2025 21:32:34 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8B6E740A7A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:29 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f61b01630so20262015ad.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046749;
 x=1739651549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KQseYG6QECDUj8QEStbcHmCDX44V8vT5WT+KPdm/j4=;
 b=S6k/VKlYv8bRSvd3zSFlAlnIagRRC9iuOqw8B8RTuHJMtmi6KKJrXBUIb3fEFuiG6g
 tX678mGrgzyr2hnAnaD0esZeodG9epNtxzMMeyFdHirFKUwY0vsrnhKB/qtlK3tEdsyu
 wncYPcogB4XK9pzE2PfzREaI/NY/Uv+0W69280t/WxLFuPFEQbbC3vHza1ebwfSUNUld
 WrYyoo2kIPWZmPuiol/FDJYQ3oMbnytPv87w2bJHyMMsdxR+uoPYI9TbNOWShtVVHsD5
 HTvLDjEWWsg7B6sts4KQHdIpBxC1cSFAnyJEnW03WKO9s+fw1uPqIXQOCDZLuI/xpQ6R
 cNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046749; x=1739651549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KQseYG6QECDUj8QEStbcHmCDX44V8vT5WT+KPdm/j4=;
 b=EjWF7bxKAhfp+WsgZhP2vvbXi2UM0UGEemGupurcZqoSHGMMZznV5KzASMMfxvCMOI
 L6ym30TzB5fkVCeO/2hvdiNH2cM1nTn738BfXPhK2aXG30Jttb0baM6HuMMFeVNIBvJp
 vjdAlVzk9vy+8qtsxPSar+cDxzUG97iX6aR3KJp3qZaOpAPtHnwvkC/Mdp39bVGYMM9Q
 i20d2uMsX5HztYhknhZcqH/YATVv41ijPLtMwmjam3AbPVloDs+2GpFs+/OE2imEcTzw
 gut2IS5jEpLawGGclFSDXSnEhJAkg6RLnnSvmet6I6/4iCQtCZ2FHhgEk5SDHNqn6RB4
 +hpQ==
X-Gm-Message-State: AOJu0Yw1oZnHloYqMBDEsHYrFgv3PhaOwM4DbkwgPXR6XAMq19Ypz3AT
 I4awn7xZd/xXT87mxo/Uvuf4abMLWm8KfdIcHFbMp6gRoVORO0hHrxNSO10gqteVbA/jmS4GaDM
 S3zQ=
X-Gm-Gg: ASbGncvBkoL6Dct/3yBMRhwaGUQJAPsLc8ald7NbSjIgE/85coYXfw+0T6FjZJxlO4m
 0H/hAn2WCD+2sFrWI6JawrV+mR/CI0pv/yYVgqJ/wDFcQVg9e+BMVxPc1e017zoeCtGOeDl0SR0
 V+v3AnO/rcOSOY3wwNVq/110cuQGZyTEXJgTXoIbZRGACacCNYEWq07CXrnH/xEPOS8mRCb3b1X
 QQCpLFvHMAMbPjys2tZ8CmTjnWJQd0zzRuQgW3RAHrNz20ROyMuaA9sx+Dz9N+nWizkbkCErERx
 pZ9tx7cBt+gjnZVOVzUkfvlzZL8ipn7d19DnJ4Hw//zSLhgpeGtS0ATEcbf39tYbpFHc
X-Google-Smtp-Source: AGHT+IGTby3d6xsDNL4YwjJ8cjqaemaznLNWN3LkNCzcSQECOvR/+H/b1L8ltjImvfUVEibGALGUzQ==
X-Received: by 2002:a05:6a20:c709:b0:1e1:a789:1b4d with SMTP id
 adf61e73a8af0-1ee0539cdd0mr12059430637.15.1739046747272; 
 Sat, 08 Feb 2025 12:32:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH 28/32] net/enic: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:20 -0800
Message-ID: <20250208203142.242284-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_fm_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/enic/enic_fm_flow.c b/drivers/net/enic/enic_fm_flow.c
index 8988148454..c2c3e55206 100644
--- a/drivers/net/enic/enic_fm_flow.c
+++ b/drivers/net/enic/enic_fm_flow.c
@@ -2590,7 +2590,7 @@ enic_action_handle_get(struct enic_flowman *fm, struct fm_action *action_in,
 			return rte_flow_error_set(error, ENOMEM,
 					   RTE_FLOW_ERROR_TYPE_HANDLE,
 					   NULL, "enic: calloc(fm-action)");
-		memcpy(&ah->key, action_in, sizeof(struct fm_action));
+		ah->key = *action_in;
 		args[0] = FM_ACTION_ALLOC;
 		args[1] = fm->cmd.pa;
 		ret = flowman_cmd(fm, args, 2);
-- 
2.47.2

