Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE01C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 19:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE496402DE;
	Wed, 26 Feb 2025 20:55:36 +0100 (CET)
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com
 [209.85.208.225])
 by mails.dpdk.org (Postfix) with ESMTP id E3A6A4029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 20:55:35 +0100 (CET)
Received: by mail-lj1-f225.google.com with SMTP id
 38308e7fff4ca-3061513d353so2214891fa.2
 for <dev@dpdk.org>; Wed, 26 Feb 2025 11:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740599735; x=1741204535; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLDLEvOsh5CHtI5b99nNx3Rm/SDzrSSuGd/nbHR9J/w=;
 b=DAtM5ChDTSjocuH/YfoioFRLoCGgBjzps0V1yW2/V0QssFgVmc/J9cYTYFOkjjJq9U
 18BY+LOrFpH2aalMSKGpI7O5XpydKw9FC93Aj7TnuZNR/KyB20anxGCvO2KviqonQ80y
 pmnNG6e289/ehyVUt4b2/CX3e5gf1T69KSRfyfElNa0s5FCMZG3iMnFi5s+LUdvoErQA
 PXeNcZMqNpkJmk1I5hOsQeOGZmGWzyD3v+8WRnY6TAd8PvwonfdH/I2GdMmo3+YuvQ1y
 m1KzT6SVlSG3umjX65YblLvngxbUiuxLO6TpcjwiYgwQl/GpimmXPcka4v/vg5OQ+ikq
 K7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740599735; x=1741204535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLDLEvOsh5CHtI5b99nNx3Rm/SDzrSSuGd/nbHR9J/w=;
 b=qUi4ImR2U/Rfg/fCb5lMOIu5vZ2F9ffrcnzIpAI1RFKdDErfByzj9UzA1BXOfCcdKK
 +Risl7xX6wBSkL4YOXtDrt5Y+7Hm8QavvIwxePeC2oylUQtCgslyTzEirYnLoE/rXatM
 fuqbUpmX+1ZJ9p9zjBcas5sl35W5pGaDmWcR+G6/l5t2BVykMg8+aX5NhExRagUDol0A
 vvyJYW3VDwAJ3K2pAe7zWxUNjrejAqOfTneOzX6BfmbU+QjzNkAcSLaJAwHjHwr1X8iJ
 dOEU44qpKBwJSMhgYXje+xGlkEeO/aVZPlBUClBXQyWZ38WqIGa0szXtB9H9u06LhC5J
 ao9w==
X-Gm-Message-State: AOJu0YzCW0dCEnYfSv0+ov+O+19jQGbcpLRuoRpDDvY+n5lG0uPLp9hT
 +dNw/cLlH18TcXtDl8x3gvdUoukMJN6MXHlxObMZ2LrQcUvm/Lc97sRA3g7sMRNyH4v4IJX7NGV
 eXhCq+FVhx7H9k85cejbv4Y+0TPTfDGMEfn/kylK9
X-Gm-Gg: ASbGncv3WQf9iE+vmvb6YDI3tSRlSxEgSS38naKpSDYUStw5675ZbDs94XTSPIPKcV0
 JsiboI/bXdL3Y9JHy2aQpmvSGBJlYPzOZbgGJgsAecgQXpdGGPhOmyv1rG4ElEfRvepb6zrC3Vz
 goBo2j/kzBoL7iWV4qngMwd5R2sqgOhy4K40e7UlqMsP+ZEURFILu+z9JfLVVoScH9qw1ElaARu
 MdPAE+y0WcwLdytyo8pKFhdlcEyD9ZUXyt6IgX4KTExE4Iuzj8I/DWzCHuPPecnPEvyNbykZQQS
 vubp8wJGG8R1agg0Tzk4wiSLJUXkDS57sImf47jc4yFEt6hTcsJtFk9DzG8B
X-Google-Smtp-Source: AGHT+IGLyqtcYcDa2rskaqzvKOTNy1F7V1fmIp+N85X5VZPBLxIL4GGIWu3Y77LxylMY1yOEwXkOfXDpPzzi
X-Received: by 2002:a2e:9c4a:0:b0:308:e956:670 with SMTP id
 38308e7fff4ca-30a5b20dcb5mr90398441fa.23.1740599734991; 
 Wed, 26 Feb 2025 11:55:34 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 38308e7fff4ca-30a819f5024sm1427461fa.44.2025.02.26.11.55.34; 
 Wed, 26 Feb 2025 11:55:34 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 9A4CB175EF;
 Wed, 26 Feb 2025 20:55:34 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v11 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Wed, 26 Feb 2025 20:55:02 +0100
Message-Id: <20250226195504.2340737-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v11
* removed assignments in if statements (Stephen Hemminger)

v10 (https://inbox.dpdk.org/dev/20250223215259.448723-1-ariel.otilibili@6wind.com/)
* no change

v9 (https://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@6wind.com/)
* desc->len takes its value from mbuf (Maryam Tahhan)

v8 (https://inbox.dpdk.org/dev/20250206204645.1564535-1-ariel.otilibili@6wind.com/)
* fixed seg fault (https://inbox.dpdk.org/dev/CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com/)
* addressed feedback from Maryam Tahhan

v7 (https://inbox.dpdk.org/dev/20250201100300.2194018-1-ariel.otilibili@6wind.com/)
* no change
* resent because CI didn't take patch-2 into the series

v6 (https://inbox.dpdk.org/dev/20250131231018.2163893-1-ariel.otilibili@6wind.com/)
* added missing credits to Maryam Tahhan in v5 

v5 (https://inbox.dpdk.org/dev/20250131183439.909831-1-ariel.otilibili@6wind.com/)
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)

v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan

v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger

v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 77 ++++++++++++++++-------------
 2 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.30.2

