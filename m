Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634DCD4F24
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 12:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE75E4064F;
	Wed, 13 May 2026 14:35:22 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 39CDC4026A
 for <dev@dpdk.org>; Tue, 12 May 2026 21:28:38 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-366375c4076so2791250a91.3
 for <dev@dpdk.org>; Tue, 12 May 2026 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778614117; x=1779218917; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7i6L8HmwB92cCFLxlnFzk/JblWBceVxxkPIb3axLXpM=;
 b=J2YMNR6LCnF1bHk5DvOKWyhyx4Xx0Dof3y8gq41/7r2PgVkV15HIZtcc+NQ8KX17Uc
 Fcr8AaiENGcu/Om62tlHFFnvVcluv5Boh/4MlGaTieAXBRnOumlRDUHQZfVT7AKvBySl
 QHDDjleYTHWdQ91+ZCDmTWVMvIyEfDXwNMI1eCpzSUIYZainHAmlThjrX1d/gpQT22oB
 5h+Xmqhpl+GKZa5e+vqUkFkpWS3By6TpDVtosZ+Q2Qg9dDL7hqlbpc1ZHLNgCg7J26Hh
 6aVMLVBy2qLTYbfXexyfbpG8okVIJnSBx4C5rRKFhK9FiZxB2ZrD9MrTlbDV9MBxsTYC
 C1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614117; x=1779218917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i6L8HmwB92cCFLxlnFzk/JblWBceVxxkPIb3axLXpM=;
 b=s5t5XiY+kHLa8Q6vdu4K0sMlnI3z3O1QlWQZJNsNa9rAeIKZ3RO/9Klr1lbNSmLl80
 IM7xfVzxp85e16O4jcgvx486/esE0NEr+xpeFIAUex5zwpBsd14GOmwtKeIkHTRc5J1v
 AyFAYuIDi7h1n7VbgEqstnNCztjs2rxPUm5lF8ebrAPfDqfVEDuDIDmIWIjC9bgOumem
 LNdvqWwxJnAHxTEA/7rstw2J1ZUwYd/alNWLj40/IFmKQhWcizzkBHBPRnXRIt/ThJCp
 Mv28DLv1xQNk+Ue6DgQ0cXk6bNhv5VpDxkisEEOxoDdfQ21MWtFlguQ0OmDa0TDY3pLY
 Q4Kw==
X-Gm-Message-State: AOJu0Yz7wf2XtsanJ56/Q8eD3fglUPgxCKM5QmSlC70CQKrz6vRsZtGG
 LW+3Zy2XqkoXDgdhbTRORexrzh6syV10jq/9Oo0Ay9XARCZ/PsryQ69Io1Gqcw==
X-Gm-Gg: Acq92OFIG7dIpIaOrqukdFSAOg9skmzsGj6IVyc06k75G2vMR9rbdXdEQakaVdTXBZp
 YXe3mdF5BRHMm7+zc+GEN25gmgI/tiCHao2uB/q9qTvQ/jECU7IBtX6krlO7ZrymUjdY3cBaIBV
 KiuB1mJ803CiSDnsGQjNfpa4BZZXatxf30ddqMEkHRNpXefOn9IPC3izTAhN/Vf6oHwWZm7o4Eb
 65ddd4rv7OD7kmlpRkt0V+5silPLgA5KzromTrc3Fk5A0q1fUWmufFAotYcLFoMAmb+7bfC4GfE
 eqTEeCteZTi+R6l8TzPm3LW0Qw/SBd5yF2Gf5O2GATRO4ShZWYtwrFhjBcnifFyOMt96mzk1HbH
 9i2pot6l74m33VIXechkW34CM2WKLJI6NhZrve3ELOMUcYWkIUV1BI+/79tquq3wmWvrLDKkHqS
 3Kqaj+wuZ8viDMX+NKSJKI2lfdDifpg8wB8PhB+V4hh7SXWkLVYmTpHBZrO/PtsptFyAzXOQlLq
 OuOjuIAua1dNQ==
X-Received: by 2002:a17:90b:3a46:b0:367:b9ed:dec4 with SMTP id
 98e67ed59e1d1-368f3e7c1acmr400366a91.27.1778614116900; 
 Tue, 12 May 2026 12:28:36 -0700 (PDT)
Received: from arin-Desktop.dhcp4.washington.edu ([205.175.106.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368ede2074esm634798a91.1.2026.05.12.12.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:28:36 -0700 (PDT)
From: Arin Kharkar <arinkharkar@gmail.com>
To: dev@dpdk.org
Cc: Arin Kharkar <arinkharkar@gmail.com>
Subject: [PATCH] Updated skeleton example code to better emit error
Date: Tue, 12 May 2026 12:28:34 -0700
Message-ID: <20260512192834.130651-1-arinkharkar@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:20 +0200
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

Previously, the program would check if the number of ports is even and if not, would exit with an error stating "the number of ports must be even". To provide more information, the program now states how many ports were found. This is especially helpful if 0 ports were found, as it explicitly states DPDK wasn't able to find any ports, rather than making the user troubleshoot this.
---
 examples/skeleton/basicfwd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index 133293cf15..381e4d4273 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -188,11 +188,9 @@ main(int argc, char *argv[])
 	/* Check that there is an even number of ports to send/receive on. */
 	nb_ports = rte_eth_dev_count_avail();
 	if (nb_ports < 2 || (nb_ports & 1))
-		rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n");
+		rte_exit(EXIT_FAILURE, "Error: number of ports must be even, found %u ports\n", nb_ports);
 
-	/* Creates a new mempool in memory to hold the mbufs. */
-
-	/* Allocates mempool to hold the mbufs. 8< */
+	/* Creates and allocates a mempool to hold the mbufs. 8< */
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
 		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
 	/* >8 End of allocating mempool to hold mbuf. */
-- 
2.43.0

