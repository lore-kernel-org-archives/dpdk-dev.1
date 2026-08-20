Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A630C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 856B340E4C;
	Thu, 20 Aug 2026 07:26:31 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 0B15B40E11
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:31 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1919346a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203590;
 x=1787808390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFRQbyNRWDFITaJcIYqpJT+wSPrz/v1KRwdJcK1POMg=;
 b=AGrGtBP8ymmszUNxfThjbPLwXBm7aMDYq7XxF4dtGh9gZXVXwURYqSXw3Mucqxi6FD
 JK0CEuykJtsWGFZRZjxUaiKLylStg5bZCzBrdyIHKOI8Uy+Zz0ATaFRd3To/m2uqvqLy
 RUTXXSzvTImxjSv0uKJ5GguaXb/bK6o50fw+i0qwgo4XsUXRZQYVXHjJxG3nncTwdLTh
 V9kILPmMjEDAcDSMIR/eHF1XU3CG59iyLRva2ajvLMYF1iAfZe+UqeLupORwP+HGmIoi
 ZaPaJfjzeFq3ZiEK1C638v93nQ52gc/yplMRh6a/VUJ26EhZAUaYcM5/nWUfJx1bs7qm
 840g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203590; x=1787808390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZFRQbyNRWDFITaJcIYqpJT+wSPrz/v1KRwdJcK1POMg=;
 b=ZZKa7Y9YoRM8LII2eu5hpo7Zud4fGuRO7hDWbdPKgSgbrAplWPKpBHN0Dra+35sQVz
 3a2YrCSTe1Pyx1SWUuGG6idAMpAjtOzTYGhrtspqFPobfzZ435qQGVgAAwTKlXQ/LXPX
 J9cOxPRjKMnfgHxCAYmjvt9W75N0I77bh+0ZNBR57rFzECUV/mv2GGeRHbsRzMIWbV7+
 Pviawaxxzl3nTsd3dVlpgsMdbh0eih1ZkSj3IoWvFx9XD53efk+QWDnSqDKS/i5zEgTP
 n4Runvy6uEsrAkB8KOaXZ8fIwwm1Im6NMo5UntYzy7cNgqv/UwW3g4P1itmbA0kTTh1Y
 a/9A==
X-Gm-Message-State: AFuF++nZtcWw8EPfbAF5M27f/jmGHzBis2TEg7aqV19WJAvBW0B/8cv9
 7XceesfeGTpL719c6HZLEuYL4LtOihqrLA0aEYjoGmWNghWE4nPMIeIQFVRJtd3isnPbV2yWPK3
 NjIHI
X-Gm-Gg: AR+sD12CL4OkM9/h1V8DLy9bwmkeGuhXRf3mF6FHjPUL7giWeAgXbUloLDT/xX7rgWK
 D/yZTSEINyvvhZ03fuOFMDvq+FoaYYmbI6KVy0kqHWDMM8sA754umCtJRlx3eoqhm0koSM4x5Y/
 I5tjnGtSfE33HMM86NLbMxEG5M6lEIURt37ZQ1ev01qL9FjY3hR0Kv4tCiG84Xgl0eesbQBuRbR
 r22E48zkmPGXNys3sj7MPpsheyPTxWmDYhqpMFPPfKmYpckGilk6TIdVEUw1WZC2Xp5Mj8mnEVq
 khGMc9tt+ikmDh93AjXROp/oS8n5QBEk4qENNKz0n5ddMGFwLTRE+5u2MpJopYxyMdvp6r8IqWs
 89haH8QNhXtOD4ushLCIdgVAqIkBwxOdo3cHoD9TMx5inq5kn5HY/tpyuSQ9y4lAOQrpeb0jmxx
 lM30rN5vokyl4ty/2ulAhKqGV9/5HSDwA8JTD0UrBsmrPWecTKmZE1ORCpQcctj0VrGAHd1XvDq
 wybJ+xU6sJJSB9wkq/U7ctST4oxZuacTh/DdTE=
X-Received: by 2002:a17:90a:ec88:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-3958128686dmr20019420a91.16.1787203590097; 
 Wed, 19 Aug 2026 22:26:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 57/61] pcapng: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:47 -0700
Message-ID: <20260820052251.1453273-58-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The rte_memcpy is only in the wrapper for Windows where
writev() is not present. Using memcpy is safer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..4c84e855cf 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -95,7 +95,7 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 
 	ptr = tmp_buf;
 	for (i = 0; i < iovcnt; i++) {
-		rte_memcpy(ptr, iov[i].iov_base, iov[i].iov_len);
+		memcpy(ptr, iov[i].iov_base, iov[i].iov_len);
 		ptr += iov[i].iov_len;
 	}
 
-- 
2.53.0

