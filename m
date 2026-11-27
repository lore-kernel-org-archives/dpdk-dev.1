Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FD606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h3Zg54D8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5591A402C1;
	Fri, 27 Nov 2026 22:08:12 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 486F8402B9
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:11 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cdab938dc83so3350303a12.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813689;
 x=1796418489; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vvkLe2/jOfPIDUppQ4iU+1qAIRAKgGVTYtrfLdIaVwQ=;
 b=h3Zg54D83QxobIwuMzwxubbBfEkMYEzZrVfhDBpigKEqmGpwCEBeMeQf46C9UC9ifs
 lOLYZ/6Qocu9ljuoOGU28l1M8ufNLBLQAyo5P7Ye/zG3JsFWLbABbnT6LM5eQuaiSJOD
 DiLW82Cp7KFO3keSUvNb8vQjCN3/hztnDLvf2R8wT0F1/uu3hEH/MSoJPiCSXHiUfG+k
 PoOxcE7B0j2LxQ2mEgwnRbNvN4eJhoGoNaj0wjsM2ZEy3zGcuZc9xma9l6I8Kc5v8u/c
 Ddaz/aYrfT6S+OBdUSskXnTHb/lz4HQIA2IKWu9DyxlYIHg7vvLM4D7U6FxsJu+0gJmA
 mJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813689; x=1796418489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vvkLe2/jOfPIDUppQ4iU+1qAIRAKgGVTYtrfLdIaVwQ=;
 b=g23HC9HtYywbUNdXPQqJo4vN9+v9OoOWqm+yd9+tQL5cJZWO8WGhWcycobpf42vQa2
 4VmxKwJUIcBuTo3sKHblcYbWqK1gNp4TnOZAkcvJyBiIcUB5kbluqmXEYHEx4re1Gxrs
 5PTL0ZQmG+oKIsWF1Nyk78/d/6xv0oL8gLRWEC6/i/dh2JVX/5Svrq9Wo69nJNLO5Afd
 fgaMtAywqLVMZdUfdra4noHTQPT5MiU6O+XwKBuaUCvaRZBIkCKgwDfr2KWSKW3dqjRa
 D2RubwnMvD3xNEM7QIbJWDGXkYJpG1q1UuJhZvr5D84RVNLQKNC0dvJF66YEY+M1viKZ
 Rj9A==
X-Gm-Message-State: APuU4Z/nMNFOtOzrM9OQtv4JQIGXbTd5oKLGtd5OvdV9WENBKiIiLxL0
 PhMznFshz2i0q+q57moE3SU88N7fO4A4k6AqHiWw6SQa0Tj+hWup6hqqCVkyOmBTcYBDboT6cqq
 tDNeFr+Y=
X-Gm-Gg: AZFdTZdhOWjrjlhQvVtmEDoIViQAaiEjJveSqlkLR+DMsJyCz86GH3lyjWBAX3PAcey
 zpKmXv3BYIOuckBm25BFe7DNS0HwxGiC/lrp58jRwsnwDN1de71Q5fLzGVEzIvXsfI01DHcrEd6
 xrUt3IJjI5WtzqYrUfs8X19+XlEPTntaJ8rclHOfcoBxerVBxGlC2Jh+i32BZHGz4LFZK9R5AbT
 36Yait/tP9UJJKuZlVexyjZyNIaOyFf1AQ3Woqjy7DZd28jCH1TgjeXzcirUwk0PjWZdBrXjjso
 fZmh791H63xdfmVDtpuZBZR6DCMw9boF/wLKzg4TuNrmtvyjWSf1VEnkTwY9mZCPQnW46rp8n4/
 Vd3wJIPqeT6Mg8uosJ0M8+r2RgvXT8IAsRU2wBXD9bOnsUVGhm7FZNn2Acee/fHbtfjR30OKzkN
 jyu4EdK2ryl55nvCPvfeO8apWrclPU8PfMG73byin4kK+PhtO2IQPwoZMB99wldDQSXgGBLPNkj
 AfE6jAA0+zG4/IBUuafkrVKl4KJYM87vZE8nHa3V4AtHbnYtO8y5ZpSaNOJTz1hDBXhBPxH7Zkz
 TXvkwc1S7TCQYGQKB74CMr9QYFC7eM5s6lzm0EF1jGuMYVNggbspiULzXr/Tq+5T16ft
X-Received: by 2002:a17:90b:6c6:b0:3b5:32db:12a with SMTP id
 98e67ed59e1d1-3b532db0513mr4405561a91.19.1795813689551; 
 Fri, 27 Nov 2026 13:08:09 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] pdump: fix bugs related to hairpin queues
Date: Fri, 27 Nov 2026 13:07:02 -0800
Message-ID: <20261127210806.318387-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141750.310963-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This was reported on dpdk slack channel.

dpdk-dumpcap fails on a port with hairpin queues. The first attempt
reports "Unknown error -22" and every later attempt fails with EEXIST
until the application is restarted.

Several bugs combine: pdump tries to add callbacks to hairpin queues,
the error is returned with the wrong sign, and a partially enabled
capture is not undone. Also the first Rx callback API was missing the
hairpin check the other callback APIs have.


Stephen Hemminger (6):
  ethdev: reject hairpin queue in add first Rx callback
  pdump: fix error code when adding callback fails
  pdump: validate queues before installing callbacks
  pdump: release BPF filter on error
  pdump: report secondary process failures
  app/dumpcap: disable capture on the interface that failed

 app/dumpcap/main.c      |  10 +-
 lib/ethdev/rte_ethdev.c |   5 +
 lib/pdump/rte_pdump.c   | 242 ++++++++++++++++++++++++++++++----------
 3 files changed, 196 insertions(+), 61 deletions(-)

-- 
2.53.0

