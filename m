Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF67CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D49142B71;
	Sun, 19 Oct 2025 18:57:35 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1A8794013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:33 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2907948c1d2so38634935ad.3
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893052;
 x=1761497852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtKP8ewtordDXjE6jbl7Fh+Lo2Ck/eF/FAuVrDMlThs=;
 b=RdKmcIUlRLZCN916yRY5ACjDgQws1UbIkgPnb6hc4cAGHZaGCeTNULO9bKk9etYZgY
 oiw/0wtXAiRDu8ezdtMa8/TMWDhhA56iISJ2pjUycgubo0G/f0RV+3x7nN8ravv6UG3D
 o7zi7YNdv2MGtNQk/clTE2+12YIwJxxdwye4c70pAAX5uccCGmlQzwHXP71qUmCrTH0l
 GTFWg4HPIcPVWos4s82Q4y6dWw2Wjk5m0b1di0ql7Rv4ACeyupGOFVbpr9w7N9Di99cG
 SyMVb/KzN3RYn+iq15swFI4OFQZM146aq2wXxP238td9+WWrdmayJLr4cHT57BQYTulY
 eMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893052; x=1761497852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtKP8ewtordDXjE6jbl7Fh+Lo2Ck/eF/FAuVrDMlThs=;
 b=S6mHpPIgpFYrMbvXsljVyAqXdRb4stl0lj1eEsG8mZG/lX+swNTMs5IvLZIEJpVKwX
 KUiueesrcnSKLgpvcfHvWcwPOsmLQJYdWt0p+nW1xvZqyxpaYh6KSsqd8lrJuXSFIl/p
 Ry1I9NgmJUGC1PMoHGxyqOJy7wJnB+JdJ/07U42ZIZJZW4DLPGatHMzmdcpCj7E7Hw2/
 PsHPoyvp/gkO65+wBw8IS5/gc8ob9Ps/TX5eMrX7cWGfKkDDIOU/EiOYs9QSOK58A7BX
 FScPIA7kztr/k2CvtyWAoG9lV/Ul8qPCilyAbBUm8NRM9H1CClqzVWBFwUwxbcdjXhkD
 mrZA==
X-Gm-Message-State: AOJu0Yz5ln4UdZoj3t0lqMXxnZOzHHPx/28wjl+UbnvU6sCcTbzZdSx8
 69Ntpc+nHSrhMDNLFKXMAx1uGl33VP5EqKfQpUqUYySMVUHESdlm/NKoAHGMt1jjdNYCGauoDGI
 P4fP8GCM=
X-Gm-Gg: ASbGncsUxj4XJMJkmiFsuAVibsA8+cCobIRnwFTLNC/TC+byeLmDzHGUzW7MKiwTUi9
 Y/Qm2+7F7P7xawdwGcQM0BFsrhLnzYgMbJAhLg/gZM5u3e1zIPRZkzcBo3BehpnFKV/jRooPAKb
 hxoFw3D4NZDaxOyFh3WlLsuX79jUlH6gxkm08v3jsRwK25gCzloenzWdFdVxVVvnIpoYRG37stR
 SuJIxBztCfkffkK41bPGhLdEM5SRVBx1hltZ4QraDjwwcXskOk4IBzvcWXrzBZ6StfrRRHXeUra
 zvdX4PKF81qqeM4BuikSQoiOK0zSwqpZnsBgAD5J0INg9ari2ZfmRXW19bAX8JaqoYBqz4wSrpv
 fcRXOEjIzg5bb3w++su3KLOvRg3xDR9Hm8uxkRrojPJpxxeoODYSTQSeHplF5C91qocvAFlpQpP
 DzMU/upIiQFb/bI6F6qn0ADLa0tYOC1QOnniKNpbWwYksLRSP1iw==
X-Google-Smtp-Source: AGHT+IGj9awIrrUm9iU6bBRx/x0U8e2yguOBk438oueGITSb3q94tbmkRlupfUGH6BDyoFn3LQVHyw==
X-Received: by 2002:a17:903:1746:b0:24e:e5c9:ecf7 with SMTP id
 d9443c01a7336-290caf846d4mr115559035ad.34.1760893052225; 
 Sun, 19 Oct 2025 09:57:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 1/8] dumpcap: handle primary process exit
Date: Sun, 19 Oct 2025 09:56:08 -0700
Message-ID: <20251019165728.164929-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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

