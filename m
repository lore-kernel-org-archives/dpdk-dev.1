Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD6D0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB1E40DD2;
	Tue, 25 Nov 2025 16:22:54 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id B5D9140BA6
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:43 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-297d4a56f97so83901375ad.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084163;
 x=1764688963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=MsPD7oDnPXrYjfiVEcLHfyDFIs7i76dmxulM20WL/irdBBz3EsQwm76JDYo80wrU2M
 hYkxwEbcUn4UJBJSkRpY2Xq2bRlI7j1zcqBwiE1y8/q+psJAVU2AYf4pliz2zJs7MMVv
 4Xo11aze0gzFu2aPNPvPO7jiFOpIGGld237NSBUr9CQgI9d3kdaGiHjrvZPtLgvZSjid
 BBMTkEGi+PjhPU37RnRqpsrwUg+NTJV1rpME33/Bpn11Wz/JnXYl0inAzwd9aob3IY6N
 iaaRrq9dftd1eYNljRBwx4B/MEdy+po3JIsJpjPymyrDF1vX/dSZHH6QnuBxitDVJvQb
 h9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084163; x=1764688963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOI6bM27vEiVHSX6BhasBCTeQzit2WjXKfgoPCP+2QM=;
 b=ZiMAjT+Rz9gK/oluIhpSP6bJabGnMXCVymRMYWYLrOmMqAz2b+I9T9QeWRp63slvRz
 c/dfVyJExklbZeCpqHwcM3Qv4Tn6Fgvdq4KljOxbI26zRKO59b8jU2BNLyBLtno9XMI0
 WTZ/fHpwnuKFN5inKENvfqfWJ+J+VflxST8E+OLvHi16Qym2+ln3U5GCEBFzIEFM7fQm
 YYsPVqaL+N1kPddu+mNz1+WJT6zWTMOzhA6lPe6zz4qPmvLXnmQJnmiD89aAvQXxt7/m
 F4oQvon2n5SZtY7Sle07KsNeKYh7eCH/+IEfH6aF0MAoXj+5ELtO67zk133Pom3VqCiy
 C3dA==
X-Gm-Message-State: AOJu0YxB+3Yw0iZxvt4I8Kn3R9oRDX7q5i+UAnyKkPb4xKqWt/T+INuR
 jldQ5SDxR9D4s0R30uRsBP68NyqRkncP9/KbVJUyw1qv/903m5Da7nxpMli8s9Xx9J7u+w0NREP
 koDXD
X-Gm-Gg: ASbGncvuEP8Awhfi6z64AbVdpf8uUljpTswkh6KCqvm47iDdXSKM/ZdPFXD2VPVrTot
 /ZINEdqKPS5PL8JJR9LJWQjom84TMCHUbjKb2zIvZDlHyB/j8O1N8Mdn+QYmHVpw1kFZSko//pq
 xas5x1FhejEW51PI1LktTWc/giS387q8VMk4lEP66gDxoA7xY3dCZE06gZDKvC9e7v0zDdtpEFq
 8wZRvA3dQNDWdsxqie/rk0PJ4YWwCCFm01J+VfYOl4XHj+m9V/HKrTA77gE/i88Xc0lt3bCxd9v
 6Ia/PLLYjCcWCmDJQNQHk87hEx0baUGH+qwyO2Z3GsSp9ILrTzu8KMqWI4lxEDyun97fWTzLn9K
 oT3Os/oA/ZA5sj1wycRz7BjSPLVkXS/XszqwjsKu9nFXyasjMHkoGxBKlaHBgLf0OYbI1kuBjaa
 WvzG1lSZPYFuiu+pn+tNXZ3501YTzemViP58PRFYMs2MIAB4mxVg==
X-Google-Smtp-Source: AGHT+IFWgb7yXDxw8Eb/qr46zvzJGvs4SSJbnfNULG/G38AytRgDoWsWrmsZP3SD9Ozk/LOAJdjAsA==
X-Received: by 2002:a17:902:d588:b0:298:529b:8956 with SMTP id
 d9443c01a7336-29b6c6c3732mr187422735ad.56.1764084162664; 
 Tue, 25 Nov 2025 07:22:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Ciara Power <ciara.power@intel.com>
Subject: [PATCH v7 07/10] test: fix format overflow in cryptodev test
Date: Tue, 25 Nov 2025 07:20:57 -0800
Message-ID: <20251125152232.73528-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

The vdev args buffer could in theory get truncated if there were
lots of sockets or lcores. Handle that by checking return value
of snprintf.

Fixes: 8bfdd8a7f0f1 ("test/crypto: refactor to use sub test suites")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cryptodev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 9bdd357727..bd6a2d3fa6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -17713,8 +17713,16 @@ scheduler_testsuite_setup(void)
 		RTE_LCORE_FOREACH_WORKER(i) {
 			if (worker_core_count > 1)
 				break;
-			snprintf(vdev_args, sizeof(vdev_args),
-					"%s%d", temp_str, i);
+			ret = snprintf(vdev_args, sizeof(vdev_args),
+					   "%s%d", temp_str, i);
+
+			/* If too many args the result will have been truncated */
+			if (ret >= VDEV_ARGS_SIZE) {
+				RTE_LOG(ERR, USER1,
+					"Cryptodev scheduler test vdev arg size exceeded\n");
+				return TEST_FAILED;
+			}
+
 			strcpy(temp_str, vdev_args);
 			strlcat(temp_str, ";", sizeof(temp_str));
 			worker_core_count++;
@@ -17728,8 +17736,14 @@ scheduler_testsuite_setup(void)
 			return TEST_FAILED;
 		}
 		strcpy(temp_str, vdev_args);
-		snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
-				temp_str, socket_id);
+		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d",
+			       temp_str, socket_id);
+		if (ret >= VDEV_ARGS_SIZE) {
+			RTE_LOG(ERR, USER1,
+				"Cryptodev scheduler test vdev arg size exceeded\n");
+			return TEST_FAILED;
+		}
+
 		RTE_LOG(DEBUG, USER1, "vdev_args: %s\n", vdev_args);
 		nb_devs = rte_cryptodev_device_count_by_driver(
 				rte_cryptodev_driver_id_get(
-- 
2.51.0

