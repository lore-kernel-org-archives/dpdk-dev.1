Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9EEF43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5A8C40651;
	Wed, 15 Apr 2026 16:48:10 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id C659340611
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:09 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-464ba2bb3aeso3956678b6e.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264489;
 x=1776869289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=tpRlE7N4J1Mq2SYZnxnOU7gPXmxWAtEmxlpMoSOYeC4abrmkUWUuNZCBwBCGZmqdXb
 SEg4I75zO2/186ROvQQzKh6J0Nw5uclQFu2v+XH7Mw9AYXsyoPeXWOGD/RIRJMPi+k01
 zzI4k9z8YkrZoC+fSXP/vPF2gfcFFiluFfgME9gf6DBWhKjEZ3z2gtPYvN9Pr/SH2Now
 YOGnug01WXr7T1QUF26/B6whQD5LOt7j382nN7pQNw4mCjgKkRvpSEBSdVdCTUsQXEVN
 DKJElyAaaa1IwH9tV24ufkxRmrSpMyu/VaGKfIugvwKVhS/xDSZzrOPogD/kLN0TXCbb
 W5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264489; x=1776869289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=XBqaMqRT5TTNmGQeXygfJJm1Hi1StZes8F1zT9GoDb/z/zN94PKxvQNELf/FFWjauX
 9onRBfs2U219WIUMZETcfQjwdEOc1uouBACAt2HdW01SRLc35np+9F5RdEhWmAHcYa5+
 Ip/Aobhg4Nw7aff4fPMd4teDjg7bwNUFYYrciFtpvwd+ZG16rWNhSIpxwRASBXRVmuGg
 pG/urL5J7e4Q4HpT5QazK+e1GPS86HtTD1tPTBdocOBDULXlTdNEyrb+nurH6rI6obUg
 LksC+h+371P6RBlRPjsHzTV/wN6yWV8zlYuRddpGCJyHSNA86HCNMjvIj7SvzDLta4ei
 k7IA==
X-Gm-Message-State: AOJu0Yy1aFtUDO4IeDQU8uUlkuoyxzKl7JhwMjTHhbVFh3ul9++IbO/M
 pga3IOzODxo/O/My5O6MsUxzRehQ68Lo05Y/BJuZ8P2O+sGRiO6bFiQep0goX4xOvi1e373cjTA
 Y3oDZ
X-Gm-Gg: AeBDieuQ5WKPqYohCNRII2G+nV7KBhTMedf4aT+zTAdzV0T5Uvmu3sWFfhyFbokBEMj
 tyR3vW5IToJMfpe4bBdcKJXbbrWIb/NDGaCMOdkKg5NXlNaO+6OyKje/0LPnGnLZyyH6mJj9MJ6
 la3FFekGnk9POUYjHsqw2tvGVv7p2WiKv0vPXDvODz7+aYV4KJiGL31/tcMmrAZRuCvNELsAaFn
 xZHD//eX4izsr7Jy5k60bXJ4qbF7tjF6z9lr3ZsyZbuCnhJs/TGa1wRx+jdM/dnN6onJL6uAZSE
 h/bi/wQseKOmcFrbHPlwj58HD+5eg++sPlyy+al16Ik8buQQxJ8IEYhvGbRWaGxK2xe0j0ErWqu
 KViTcAKGXq2860OBaVPpDmd/SVgylVJOOoFKNmMBxn+CsaUfMuTdfIhvhECJsYqt7vnfPfnHcvd
 +RZJWr0G+ST0f1Em4r0z6V6JblbFEp3t8CvQs+5D5lsqE=
X-Received: by 2002:a05:6808:181f:b0:467:153a:2d9c with SMTP id
 5614622812f47-4772b07a821mr11322142b6e.15.1776264488954; 
 Wed, 15 Apr 2026 07:48:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v23 01/24] maintainers: update for pcap driver
Date: Wed, 15 Apr 2026 07:45:50 -0700
Message-ID: <20260415144717.226161-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..580113a658 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.53.0

