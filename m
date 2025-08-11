Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE554CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88E42402D6;
	Mon, 11 Aug 2025 23:36:42 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 4C6664013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:40 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso31067785e9.3
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948200;
 x=1755553000; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A/P2YTUPFxdQAJZxYrYBcFGHYJejpVPpmnnIWUBLeY=;
 b=uvxfNrZCb/HqqIyVlta56BatTG5qUSoCAZ2mhiwHElJkVWY0bMeMWv3CWVmNFKhccj
 U9hoUAhEBz5boJB7ANdkvfdACZROceenRComSGYEMNFRMplw0QX0lw/9Pj1ITKOWfMbd
 u2kI/5XJoGaswU8oeeUCyT8vh4Oda/60XiMTIlk0MO/mNb+sCnfj4bOQwYzoXOoZrw/f
 UK8Sk3qexxReaTMozP6681OgyCGUya5V+1FrQ8c64RKnTVlyJt/zI4tFgZb5lEZ4XQyH
 +LP7C5BBw/LK4d6ylZ3LTLxZxc0xrYi/z982SJ6/Uk5euWex5UUlGWKS6EwqxaL0Zdya
 Isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948200; x=1755553000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2A/P2YTUPFxdQAJZxYrYBcFGHYJejpVPpmnnIWUBLeY=;
 b=Hqgvzg3mzHfTOAyQgNwrRGreh5IU//hIBnsi+f9TLqwVDtjvTifY5Ansar+V0kL+kT
 hklRHmnC2oll7CniP2/J8lvQgV9u+zOOsdaxwWyflVzoC+TMpBF4eiV0/fqq2Pzb0d7Y
 nf/ut+rFYR0+GL8dWevMMmiHDmyPloFM7858QpgZB4lH/02d65goLvB6SB0rdZ6ee7KC
 ssHmsqaJ8n6Cj41VLzrUgUlffcR27AMwNYjooeRdOZpLWT3T9iXd+lqbegvIMVhFNBpi
 JRn5t1nlMwlCMBZ55PRarAs4krxTM00HcSpneBcBMaql85NsKlYSrOtU5exRuumhzAr7
 fKPw==
X-Gm-Message-State: AOJu0Yy4HD7qtoP1MshFt+A7aFha4CErIBRqJT60ed6PDTOHzGDo0/Fi
 eiS6iG1056xMeXyHJvj2a5IkggTKOEMHuJE2vBOeZV2dJamUP9O/Yi0QSkhzDY97OwtWffxWto1
 4Q4nt
X-Gm-Gg: ASbGncs68DFsL1l6c3MmZiUxEHcmM90hh04YvNVPK8hFagdJndCcpVGZJJYSuhmvnvA
 yKiho6tG3LmpiaB3Gma98it/tXtOVnUcxTdRK/TWoY+tvbgAeJu6K8iMTFoBTCanEu1lqXUSkQN
 3STo4RVUIeKszRVCNI7QgIocPXFEohkyIK55sdsJC175KuyxZ2qNCKxW9HDSmYv6zRbdvb6RuVR
 LatRxvPLbr0g1vyBycOc5NSEwxU/lw5BASV8GxSvGUuVMmsMLzczy1mk4Yx/QdtPpB7tAbreoSQ
 fUQ2/UNiHcfdaRuOxz2muuqxTAqCDFwXJVedgCYVNZPwM0D1WTQ2qVqGw5EuC1IjHqFVyi0pHVx
 F7Hz1+oDri+2Np5bsbKvpGwFA+XreVByXSUMpbMXq18DSiaaoY/eJRWKx7uF3ZUWahBdZ03Ik1J
 hyf9yPII0=
X-Google-Smtp-Source: AGHT+IGOA23mzAYi+kPIRiH6Rnhbn6zxAKkTaEEBOwmLDTW+h4uHTBZjV61vKpSDMAWBdTOw1YDNwQ==
X-Received: by 2002:a05:600c:8208:b0:459:db69:56bd with SMTP id
 5b1f17b1804b1-45a10c47b6fmr9213265e9.20.1754948199732; 
 Mon, 11 Aug 2025 14:36:39 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFC 1/6] dumpcap: handle primary process exit
Date: Mon, 11 Aug 2025 14:34:59 -0700
Message-ID: <20250811213632.16023-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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
index 3d3c0dbc66..7b19c830b5 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -1058,6 +1058,10 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
 	cleanup_pdump_resources();
 
 	rte_ring_free(r);
-- 
2.47.2

