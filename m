Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEEDC531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1E7240A6C;
	Thu, 23 Jul 2026 22:29:45 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9552140678
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:42 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so1313712a12.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838581;
 x=1785443381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TTLVxKAxD2pR8hafcEFDSu0zi72jGG2GL6SbJqLgHYI=;
 b=OPLb/YrZN9OpfMWvmPfVsjlIAnTsTu7ZnJs7Zsh4v2BKnEvrtgTjK3ZjZtErGJRWYt
 8jmb1vCVIUyYOJDfr0tETUTq3b/w4TM2hhQ/y4MH2CCUdNOWDzwbBgoE/ivoAl9tEVyi
 vSb2tNg5M7SBeOhRAv1SGZYiWiG6UoDd5Ky5PLcZ6YdXg8zBF3FxONVsNiu2Z6l6j5WF
 JK9ybzPayP0idblQPKVINzwmgKmgkO5NlWRfqsRDoxDbJeawzxSIqVbRW6onvxmVEaOD
 Gf8pnG2Tx0P4GR/GE+LVxXNnELGUQOsiJoJxQfP81rA0Qz00IIOlVqLEajav0X6tufLW
 4TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838581; x=1785443381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TTLVxKAxD2pR8hafcEFDSu0zi72jGG2GL6SbJqLgHYI=;
 b=k+35O6lgvbon5DDY5frVNEpsIQE4wm7o4djqS47QKrp14IeE9qolpH0uhvgPSlXlsn
 ejEVELyCQTmIGxTycmjsRrX0Ekmgnx/pML+1X0IwAPJNpFbpzCUsNhkdNtofDEHCWrI7
 aV+4htOi2j/IPKAhmiLHP0NeyB3x/Oj2R2Pmxz/FnsgPaU6mEOIqt3DRjoFHV1fVZNMX
 RGl8LccGLDqxTQ+7o1oZ3kQN1Oy/2QpfdIZVsvx2scTSJIeRk1VCmGtjr0WKfcRSRKhM
 hSMPt4roA67zMa36Q9/nVGBsISHSkn+1ME411e1atoKFmbitpOI5Jveb3GTGB8LcDuaA
 E0ow==
X-Gm-Message-State: AOJu0YwY7DzZfkTQkxsVdZHKkCxqbzNYdTSRi8XhT09mNxoAra4sxStj
 rDa4rTrNjMXG/jDr+ZIMy8v2b9Jr0MbIFEkQdejbpVypyZAJfulBZW0BB268QGeIj1JAxRqRYlQ
 Sf1ms
X-Gm-Gg: AR+sD10UjX3rSe6xzYh8sIin/OHqCebebR2rFzPq1fVmq7RfAjaxFXUi6Pwaz3rvItW
 kXp2VQIwNNizQxfCu3yeBLr5PpVOjw0iFLZB0uqgVBGp+INLzyefnVMy0VkXnU/sa7bqYYHFyTS
 aJeK1Z305WBoShtDl2batbYi9e13sZnHw8AeW0/sAoK1TP5t3eoJCGrn6AL+ZCvPc3noArO2kky
 vU772mKqMAwbeCOhcAZWmGa11ZK5M97PCdR989j7gd+LfTasJiJZdxoh+X68+To8/OuhGoFWEPw
 bpyjoZqgDyKhmWSvcoz8faPXgF1XzYC5MNVjlM0ciTKwix5avtHYInAgAANAtQbCRQCAIx6aEhG
 nHsKlb8AoNFDtzpXjt/cLoIRgInQyjWrt1s6RCsDPsuX/ZT971VfyfNaiRJYEVDK9sWW8jZ6+zy
 om9hK1bRaNWR/5NfoC65rtkZN5BzFGrqgEkiZ/+/Zyq1B3y/1yZaM5WYMu4i5q0g==
X-Received: by 2002:a05:6a21:9d8a:b0:3c3:7bb9:c93 with SMTP id
 adf61e73a8af0-3c44b1e4bb0mr4884563637.53.1784838581563; 
 Thu, 23 Jul 2026 13:29:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/9] app/testpmd: remove unused function prototype
Date: Thu, 23 Jul 2026 13:28:07 -0700
Message-ID: <20260723202936.378793-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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

The function set_qmap was removed in 25.11 release but
the prototype was still there.

Also, remove leftover help text.

Fixes: 2863cbd9ee6d ("ethdev: deprecate queue stats mapping functions")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c | 6 ------
 app/test-pmd/testpmd.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..d299edb88e 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -581,12 +581,6 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"set port (port_id) rxq (queue_id) avail_thresh (0..99)>\n "
 			"    set available descriptors threshold for Rx queue\n\n"
 
-			"set stat_qmap (tx|rx) (port_id) (queue_id) (qmapping)\n"
-			"    Set statistics mapping (qmapping 0..15) for RX/TX"
-			" queue on port.\n"
-			"    e.g., 'set stat_qmap rx 0 2 5' sets rx queue 2"
-			" on port 0 to mapping 5.\n\n"
-
 			"set xstats-hide-zero on|off\n"
 			"    Set the option to hide the zero values"
 			" for xstats display.\n"
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 083171853c..b5643e74f5 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1158,8 +1158,6 @@ void tx_qinq_set(portid_t port_id, uint16_t vlan_tci, uint16_t vlan_tci_outer);
 void tx_vlan_reset(portid_t port_id);
 void tx_vlan_pvid_set(portid_t port_id, uint16_t vlan_id, int on);
 
-void set_qmap(portid_t port_id, uint8_t is_rx, uint16_t queue_id, uint8_t map_value);
-
 void set_xstats_hide_zero(uint8_t on_off);
 void set_xstats_show_state(uint8_t on_off);
 void set_xstats_hide_disabled(uint8_t on_off);
-- 
2.53.0

