Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C752C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 21:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E5140E0C;
	Thu,  6 Mar 2025 22:47:56 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id DD72940DDA
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:47:54 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c081915cf3so155533285a.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741297674; x=1741902474; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVuimKwWounm1bnh2buf0zcuqyqMRAcUzCOg4qHOXYc=;
 b=EXa/WItyiNAYqRyBKGZWMC+0t9sryixW0fHrHqS1HBT0wWfJfVGMYK4AN8smT/6nlP
 +Uog1RA5QDKaqBcSVgpd5hNO910xUi74/qgke2iq7NqkOuPhctKrjRqFNPMohUxvZ0zM
 JPJfsmXJaT2ZPmjKA/to9plwwlbJvqf0MZlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297674; x=1741902474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVuimKwWounm1bnh2buf0zcuqyqMRAcUzCOg4qHOXYc=;
 b=dT3kjZUhaD8OyRkgxqTHrYf0aIhGirp8j2X+di6F2fWcRYASBHCBo0vaVTfYf/Qb+O
 Snak1Ssn9mYruMPNJ3lczY2LNUakeEUPE4JeSXWHvztmvHAft0ldiH4CoaagpqDLSHVs
 qUXg7XlGpKsyZiNGRixHh3D0Asn8t5iYRLmcMJU5CyGtJZZ8Vc36supKQTDbahrQO/of
 NitCdgIuQTNn4766THCo3SiTx0wb9o+8OddDbEhXKERGZybfZ0Brf+jZh1U/DCIRpNHQ
 pcg2rQnSszn3e9NNxTFVeBo9+XN1eDCXvB1bcGKsJCBeRPbjZqjzk/E4wsNqURwv9Vm2
 XUEg==
X-Gm-Message-State: AOJu0YzZDxfkrtmE4CmAjyBIbYLMkOOxEJZdgaHgYhb2sFSGulXD9hBd
 jYE0gq8n91OmAmOcz58De2MCRVoLrR42z0bZ6qzVdxammy56CDffksveXF1L06c=
X-Gm-Gg: ASbGncuKJ0eqYgsr2kpMEi7bll5BmtRNo5zDNFBb/Bx0x4OdZbuxt9HAJsy4RnCAE05
 E20sRpMvFizlrsBhVkML110XN8zbrJM0/GOyYVElOuHF31glodO7lPtp1w/Ira585IoGqmmS0gl
 yVuoygr97Kjdzn0gxDiG64WEYpxz2cqHmZKYxsbreBp1poPhMH7U/mQH+EmmK70D3qDUN76xaUf
 T6K9BuqaA1cFqOGNCWzWHZpsGu2P0irpS7bC55fds4/xksojqvX6cxFu1V7XMH7qvPPSjvFiuXU
 36y0Jl6Yh1JVNsS+s/AJ2SHXcKwd3Ez315k+NJxIBCpvGDdN5J1XkUPbz92aUxlbpwP+BrRBSq6
 eep3VqsOs
X-Google-Smtp-Source: AGHT+IF0ZaNZk4tcbw86cnBbODF4atJudE0rl59KQn7UYhp3B000fvR58p9n804iF+t2mKpDpdTDBw==
X-Received: by 2002:a05:620a:4801:b0:7c0:b0d4:e131 with SMTP id
 af79cd13be357-7c4e61ecd7cmr150682185a.49.1741297674230; 
 Thu, 06 Mar 2025 13:47:54 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db4ca3fsm11892341cf.70.2025.03.06.13.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 13:47:53 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 3/4] dts: remove unnecessary capability requirement
Date: Thu,  6 Mar 2025 16:47:46 -0500
Message-ID: <20250306214747.579340-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306214747.579340-1-dmarx@iol.unh.edu>
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
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

Remove capability requirement from checksum offload test suite
that was not required to run the test cases.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_checksum_offload.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 83879b0512..c9efdcaa1c 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -30,7 +30,6 @@
 
 
 @requires(topology_type=TopologyType.two_links)
-@requires(NicCapability.RX_OFFLOAD_CHECKSUM)
 @requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
-- 
2.48.1

