Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A05CD4851
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 12:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE63402B6;
	Wed, 13 May 2026 14:35:22 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 248994026A
 for <dev@dpdk.org>; Tue, 12 May 2026 21:16:56 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c80167f5716so2600406a12.2
 for <dev@dpdk.org>; Tue, 12 May 2026 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778613415; x=1779218215; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEX9TgtqCJ1d4OSyYxQpFGD7UEEk57jFutagfzqgbmQ=;
 b=NBFYHGJ9NSztB2RUPsMhDBGkHXX00A0oRHR6ruTd5hptCNOc/bMKtov5nxRuzzBoag
 V9ZTMS0lzNs95NxXyHlnnhRCeOekF91FPKZkxC2vCXfvvV65W21xBrIPCdTOtGbr8ZCL
 L8XJMvzbVhUIAgjvqBWiLFOP4o7tgoL38SkzqfF4r9n2TCesV8Ts80jVyo4tL+ogyHom
 czG3wPTNjWIMRKOB6Op1mO81e6X908dczHDXjzGXJaJHu0HyU5GvCi/i36Bks5cB2bTv
 Ae9vgGHXYgErkWOsSDoFbYuckYq9xUp0jXMeTdmhKbDAp1fpfBxu1dTVORVljdZ31n3D
 XQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613415; x=1779218215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEX9TgtqCJ1d4OSyYxQpFGD7UEEk57jFutagfzqgbmQ=;
 b=pVrt6MG7b+PE/w19QivC3UYXtzkhECyY/5vekFV+rgiOhuF7XooND5d74EKO9Z+UnV
 OoIOm42UtEUmRMCouknPwgC47QLx5hfioCqhFYsQdrvwVUAFISXQQmHNV79apO2J65om
 /NatppE12NVbr3xjLk8TdzU7+ZJV2aw64u/1lyTDH7V/EpakpYVv5AUEg1332WaEcwC+
 0HwBhBRF9Zj9y+aVft75aGWs2OxyF9nUzqzmj3/S7o5SV+44VcNiQgTXhcZoKXEwnrCi
 0rRRk/w/Vmqd2IDg8Op45R9o4Bm48G4uc+AYYBT2D8cpB95LF4m+yNk9+v6B6DpFVt4u
 Fq8g==
X-Gm-Message-State: AOJu0YxUj0LHdzv2w9OcLBYETNRFqIiRuVKmhPhC4BNOcccnl8PLRNCp
 TaPA1a5VUuN+ktZkjany7+/doywq41px8r4YyQrtcnATcOlfTisf4/T47gqHPw==
X-Gm-Gg: Acq92OG1F/JwNkve2Jbjb6CV8qF9GXbaFDcYytJXa5QQdKuUElyh/N7KXNjIy5M0QcW
 oB3mwbPehwnfWnANk5NuCm75saOnVXO20hq4HOuhSd87xsm7CrnzXI1wn22+T6kLI9W4+F5mvUK
 6ulRODNdoXvJzJllvzny9R/koALBLOqnrHjBbe7C3Z9Rfn0/xMmiIHuIws/0qKipg5LEXe0KCZM
 T9J+PM5wIovSi4YWJkGkR3ww2ldxubCmgVQLDDPXqtaJazTMlVnLg/dBadNSRlUMz6/OTD1zOLP
 oaQ51ZPN1mFkzdNfv2dRxNawjenOq2tT1/HgOIJtA+uwYPywvVVW5/nfRn1KCRd5mpc4Ga8cMXy
 hizw01mE3TYM2FOCEE3C/91LcDo7X6aIrcuuSk5vq8OaBCOnezRNGHImaXLf/Ybz10HSBlEd1PT
 VfEAE78CayI6X41uoyuTiIe61w00l1IJEm9hJdvEi8nvibBRaBI1ATveg0G1PGNVYqrAg8yRxOi
 a+HTD10Zt2fYw==
X-Received: by 2002:a17:903:1b0b:b0:2ba:1756:aea7 with SMTP id
 d9443c01a7336-2bd27143a40mr3615185ad.2.1778613414512; 
 Tue, 12 May 2026 12:16:54 -0700 (PDT)
Received: from arin-Desktop.dhcp4.washington.edu ([205.175.106.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e83084sm142241915ad.61.2026.05.12.12.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:16:54 -0700 (PDT)
From: Arin Kharkar <arinkharkar@gmail.com>
To: dev@dpdk.org
Cc: Arin Kharkar <arinkharkar@gmail.com>
Subject: [PATCH] Remove redundant simpler equivalent section
Date: Tue, 12 May 2026 12:16:50 -0700
Message-ID: <20260512191651.126274-1-arinkharkar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJFAV8zBGUVp-Df3aqY_pUw-JZpVqJfXERXsw4oQ+k2_TJbu2Q@mail.gmail.com>
References: <CAJFAV8zBGUVp-Df3aqY_pUw-JZpVqJfXERXsw4oQ+k2_TJbu2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:20 +0200
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

Fixed outdated documentation on the hello world doc, which incorrectly stated an easier way to launch the lcore_hello function. The example program uses the simpler version and the documentation stating it as an "equivalent and simpler" alternative is moot. It is now the default.

Signed-off-by: Arin Kharkar <arinkharkar@gmail.com>
---
 doc/guides/sample_app_ug/hello_world.rst | 8 --------
 examples/helloworld/main.c               | 4 +---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index 5bfd4b3fda..b7167aa345 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -70,12 +70,4 @@ The code that launches the function on each lcore is as follows:
     :end-before: >8 End of launching the function on each lcore.
     :dedent: 1
 
-The following code is equivalent and simpler:
-
-.. literalinclude:: ../../../examples/helloworld/main.c
-    :language: c
-    :start-after: Simpler equivalent. 8<
-    :end-before: >8 End of simpler equivalent.
-    :dedent: 2
-
 Refer to the *DPDK API Reference* for detailed information on the rte_eal_mp_remote_launch() function.
diff --git a/examples/helloworld/main.c b/examples/helloworld/main.c
index af509138da..8d1a959c58 100644
--- a/examples/helloworld/main.c
+++ b/examples/helloworld/main.c
@@ -40,13 +40,11 @@ main(int argc, char **argv)
 
 	/* Launches the function on each lcore. 8< */
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		/* Simpler equivalent. 8< */
 		rte_eal_remote_launch(lcore_hello, NULL, lcore_id);
-		/* >8 End of simpler equivalent. */
 	}
 
 	/* call it on main lcore too */
-	lcore_hello(NULL);
+	 lcore_hello(NULL);
 	/* >8 End of launching the function on each lcore. */
 
 	rte_eal_mp_wait_lcore();
-- 
2.43.0

