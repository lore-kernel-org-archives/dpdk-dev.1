Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FF5CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66334402C3;
	Thu, 23 Oct 2025 17:47:54 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id DC1C440151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:51 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-33b9dc8d517so1087276a91.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234471;
 x=1761839271; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtKP8ewtordDXjE6jbl7Fh+Lo2Ck/eF/FAuVrDMlThs=;
 b=qjaI8651AP0bPQxp7ImAIb9YjMsBNDfvlHjLv0geig5JHCE43DLySMwIS9a6hkM0Ds
 RWb42eKudDjlnT43Kra4gf5GXI+tFT7j+8rg+xztKr+FfpQqMGk3EBBpbRZnF2I1Vs4Y
 /J3TkTsVUzBrmnOwRTR833v2dVvZffmjWIIW05ZmXumGSNcshs/Jql0CRpBwaw13EDN4
 BQ/VT/92tDxFe2tNbUPZOpujK8NIy1ZE3/Q8Y2zn2Wjx38nyZqXyJxX+TiklRp3gQsYK
 aCk25a0I1NumPBceeo27f07yDL7ifFlptMuEQ/qIwyxjaHq96pFtza7he8bAt6nunF7H
 8/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234471; x=1761839271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtKP8ewtordDXjE6jbl7Fh+Lo2Ck/eF/FAuVrDMlThs=;
 b=vk5FhmkrwzLSaruzOOjQR7yawyTns7lTKRNYBFq8EDJSZ/GrfVM0b+Jq9HRwY9OKOV
 ekhHgXD0lmdfdc4zizSNIG9cxY9cj5lamtGdc3HQtiqOtY0LYavZm9BxHZWjfYz5xzXY
 MYTPbfWKxMEOKPt1FkrZMoqCHXH6SElqdn+KukaT8qhILqmvmgKAyR32OWNdru2oR3lc
 rvhPGshHe+mHzsVM2IhEgk87YxKIVC795f8IMXYhVYCUf7hqs/lxKyQ1WLyuBGG6UaBT
 eps7L2G+GKlQgflC6Tjhus2vK9QB1U7mQ5F2EDvw7ehJwrPXhKAmOx44DeVOwW4Kz6yf
 vcvQ==
X-Gm-Message-State: AOJu0YxqIWjnC/SQCPPQEQARP9LMpu73lS31kxEVxhOabWLdy8yZhnOr
 KldQqCKgcnGt5Av3U5m2P3xuWtOpSkMXph8Gw3iwFulKsy9NxuFproyQ5qdTtdHvkP+fb6ItYIT
 t6nc/gyM=
X-Gm-Gg: ASbGncvjeGLG1KVBzMAYqmoh6Pqj1xUJgiIa/LAgMTWzDV3cw+08t2TsUlxekvaNxH5
 LaM4AFZIWAGujVHvIQr/cflRzSDFv1P0c3jyG3n7Soiqtnm3teiPacQT//AcmN4dpP/8j9gNjEm
 rHntCMrQYfUhYEfOIz76mrIaPP923Bulu6458dKXh+IIDI0WV+xl1QZNqFv7TTWBtJc5xUotMDK
 HjMfFTxwMkdwhm40DLv/ah37c45t7yogcTR2d8uMeMwVa031RX9vZmA2F3iPHkemf3YsymwaFb5
 Asy2AMf0jHKK/fyl0lcn2nM9nB1WBZZN7rJnh1sJYwYyxP4Gu6yFyQcgMcerRIH046sKeUX3Bxs
 w4TPcvAjsBmzgYE9vozWdHKEAzm1MKJWZnm6ph6s86ZsEV1SlAzcVkl/lhkzGTF4nB/Rahs1PLS
 YkPxxYj7PFZDi87YxPgTa0+B/vyI0qgRA9MtnlPg==
X-Google-Smtp-Source: AGHT+IEQP6A7c5w7+pwo0VMuNNscZ+7C7jswcWw6CePT00YGu0ZxcJBpF5Nw3xIkNzYdh5cU/9JMyw==
X-Received: by 2002:a17:902:db05:b0:24e:3cf2:2450 with SMTP id
 d9443c01a7336-290c9c8a5e6mr321642745ad.2.1761234470920; 
 Thu, 23 Oct 2025 08:47:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 1/8] dumpcap: handle primary process exit
Date: Thu, 23 Oct 2025 08:46:22 -0700
Message-ID: <20251023154748.38535-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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
index e5ba36350b..3621c0ebe3 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -1059,6 +1059,10 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
 	cleanup_pdump_resources();
 
 	rte_ring_free(r);
-- 
2.51.0

