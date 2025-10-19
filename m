Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469BACCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43BFC410DF;
	Sun, 19 Oct 2025 22:41:11 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id D6084400D5
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:41:09 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso2361045a12.0
 for <dev@dpdk.org>; Sun, 19 Oct 2025 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760906469;
 x=1761511269; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVUKW8QaGkX5ASWt0cQbVhRbJdzJ7Yyw7kbUFuDi8OE=;
 b=YwXsECJJzZbKKZB5NdkDI+XcooLLGMIZaaP4X3ESRsJBBx4bzzYPZUTPDfdwnuUXw5
 t6v6alG+3ZEcmd2FZw/fYizpUBhdfIWQsCRL6qL0iCKqDsXvE+yi/HucAyAgB7tW/WNd
 T2lNMJm0l4C6wSJeB2qCW1XHMY2U3av0Oiyhw20Qcdof74yerVlOxVU3Vy7BUarvMF5Z
 QYccwftg9VHfdeBEFMMQBzZyjNj3ZOUAAWoVMk0tJOLBQJ/1PVXSAuuB/TtCDZTGI09q
 +ztiS39NbdP8KZ8GBf4JU63IvF3bQs+mqS2LEL44WO+YQbumGcGyEB+SK22XRZx2uMED
 GAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760906469; x=1761511269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVUKW8QaGkX5ASWt0cQbVhRbJdzJ7Yyw7kbUFuDi8OE=;
 b=YmNIHMn6OFUiqMS1qL6iVfFt0POv9Q3UNuWgyK2qoTl785PpUyObKg92PdGLlq+P7P
 MEsDhTFCZ0pGvb5wQbuabdLlFJxCAbk6ySLz9iwsGwItiMfrB2Y3UwbYzj9M5ytP2EFv
 QcRTMkseco7HfeM7GBRTwCmEL+VEHPSplSfVIYIbA5rJAJWaEstQHmcm6PczlJS3h1rd
 Eu6kX9sIAgJTv0JGS6tN9gfi2ovhOhXrMK2Qc4Vz4r41HAcvLpgoY4rdOBWASktx6Xl5
 wS9VxUG48V3iCvphSO4DVG4uv+IbxzjYwmxVUFf5iVYzLqBbRSCWBjoshAthBAWYrqKQ
 69MQ==
X-Gm-Message-State: AOJu0Yw0AeuHoiwf/4kRVdVJBHMit4j1vwJN9Mwxr1Xq73On1NSJC2gy
 YEwCPE5fSXSxF9vV5FrqgCmW0T4K9thrlVCaAG6f3ym29dkz/COeF/4pZnF/dM6Ss87aQSt1HN0
 pZCk1Qic=
X-Gm-Gg: ASbGncsk9SVLqA5pO+A8x2Gaasv8O0T90RBR6KUJ4vdN6yPVkqcJSuHuj3nEYyqLhF8
 rEBEvWXiXvzymhETNE+vNhMF+bU8GVigNRYi0GQ6nw99IrtT/rnJCCAZBzdx1AsVuq/4WJkFxQK
 Ebv1Vej1+nWR5hd8VpderGN1AjhjNhcOsZ8gu8gIwh4Q+t+6jwPZoTpTeCR1BZTxRwXqXOmc0ha
 dawDaOoilj5UI/jAREhlCDLbMpErCb0QfUbWRLbo6icv0Bgh24nHkeMRqiQ5BqGWo0wHyynf+PH
 rBR0gUIF1VvFEycjTbHKta2Yd5minli/7BULb0cT4B0NCE8DTq0rFBczMm5jItxek53IRCYzPW3
 LIYNiLqfLQi3kNxu7PbffOgzcJFlFN8XbdMI1TYZpkzZiTmNuFTvWviH2JqmoblcVNNuQunKNUT
 KwwwX4QGiiokAyU6Wf49rR3lwBn+0T/KMUKQghnrdGzYwVtYhaDQ==
X-Google-Smtp-Source: AGHT+IFmYMxDmDPSs+brXFthMnArR38OSFealehruIL5YHO0hmmUoZVPkFTKwTFda8y2UUTy+5e0aQ==
X-Received: by 2002:a17:903:3806:b0:24c:bc02:788b with SMTP id
 d9443c01a7336-290cb27d765mr133039395ad.44.1760906468793; 
 Sun, 19 Oct 2025 13:41:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472194b2sm60571935ad.103.2025.10.19.13.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 13:41:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] minor bpf improvements
Date: Sun, 19 Oct 2025 13:39:57 -0700
Message-ID: <20251019204106.29043-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019170040.166372-1-stephen@networkplumber.org>
References: <20251019170040.166372-1-stephen@networkplumber.org>
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

Minor update to BPF. Add allocation annotation and remove VLA.

v2 - fix build on FreeBsd

Stephen Hemminger (2):
  bpf: add allocation annotations to functions
  bpf: remove dependency on vla

 lib/bpf/bpf_pkt.c   | 16 +++++++++-------
 lib/bpf/meson.build |  2 --
 lib/bpf/rte_bpf.h   | 11 ++++++++---
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.51.0

