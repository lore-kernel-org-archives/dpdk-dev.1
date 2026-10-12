Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32ECA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A21240279;
	Mon, 12 Oct 2026 22:38:38 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id E6CE440041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:36:33 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-35b647aac23so168267eec.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791790593; x=1792395393; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mnpf4GhoG38dIHHU/xNWb3NwOt+EzlL9XLcRzKCB/Bc=;
 b=TRkYiT10TxY3Jj1pagL9b8JOdH9ltjWQhQZP9wftsc8KM/anuLiiqa4P5ZLjNNVSua
 LDHmSLXNes5lRHzXRP7kk+llQjfGBsiWeUKl2BYVRlpgdwlywIHnmcIYXmZ7f6/wg3Mr
 a00CQRjMAfjYvsLgcY77dHZoHSSb2rY1GqK/wrtxggtm7hfAXSiwKw8ZOR+7PU+EUVgF
 dSie+JnodM5rGYyBHKKBIS5uLd41TxS6dcXP6sFjYQi79xE++5S79ub8MqJoKqRP4p0w
 WR+Kp18DF3nasCWVCiCIpFG7xufN8ciSzTX08xW4+qPFx71aDbjVyGLQmbVfG9FOEp7U
 AYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790593; x=1792395393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mnpf4GhoG38dIHHU/xNWb3NwOt+EzlL9XLcRzKCB/Bc=;
 b=wxzmeFazLJ1R8uJE4lSQdHqGDDfWVbxG7kcP3RveQcnP9eE3QfdQdSTVU1ALnZnGqd
 amZaXlsl0655SornWcLW767LVyfeyZ3cXoeiS525/npbo8OOC95hzfMcgw8NKyfW9jol
 NfQzN8xu6kW8GPBYSq/jp/aiPlgIuISG49/ZcR+Il9i5MbeeJs7K+5CFi48x3c9Fzc4L
 +dGpbBr1w6k6HSQj29p57VAtHJWSS5bXaQmTyLyEkudCkGbU77wlD5tbEMoj6XfE0TEc
 Rod4wQMTRPiijKrk48mmvqYMnF80XwPxejAQLRfD7CFz55eHo7ZOBjvq7E39n5YDAL88
 2xAA==
X-Gm-Message-State: AFq9FYIshW7Tb0MEOqC87zCX/lUXcXUAYEH96YIUf77MbNvz/P29MbnD
 p+2cNSMW79k5yPKpH8TtCiXR7GBK4ya7a/5rIS7IamgWGM0cFmyd8qViRJAwSw==
X-Gm-Gg: AYBFou3CKT3ANT7LMUBgOKTeMNWZ+WyyIJKKQ2QtdiMIg6Kke/c5DDTnpCcJZ9LbzNJ
 5/r5SU8iXX+P4wkOvaGA64udnVWJEH4cTcMndlUwN3IV3GL9ZZsp4/ACHRDZVzupfGHXLfVowQ0
 DlbM9mDhrYhe0y0RdX8ijGxBvQMCoPC4cVdtrtfbSR3wAVmzEzKLrBfJ294oxMzBUCGUHkQz4RN
 5g3mFkBZ9asTkUietboDtYLfoYnWDU3kRN1hVIExHgrdKYVtyru2fMMSM2Jd4URm4pkpYpLArCi
 Dhazx8CW9q0NLTBVCNljQTKk32FR295/qJ0w+nry0X7sm7GOs4a38HsvaUG1501ZCf4rSUQJLGK
 u9SI8jdElNHBJBNcsC+1pZtj2zIdAQfNkE0lRw6VX5MsdKGMdQ9Ocg+NGTLwvboF+yq34XI8W+E
 2mZgDNb9xQTSITpCad1SWGGliGA7FumnOWMQFX8M+5QPKsW5fh2vJKfzyWaU2Wew1SHHv+ptfJ
X-Received: by 2002:a05:7023:885:b0:152:97a1:dd36 with SMTP id
 a92af1059eb24-16a12539614mr11937844c88.10.1791790592485; 
 Mon, 12 Oct 2026 00:36:32 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm25558463c88.4.2026.10.12.00.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:36:31 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH 0/2] net/mana: fix transmit burst and add hardware TSO support
Date: Mon, 12 Oct 2026 07:36:24 +0000
Message-ID: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

This patch series addresses transmit burst error handling and introduces
hardware TCP Segmentation Offload (TSO) support for the Microsoft Azure
MANA PMD.

Patch 1 fixes the transmit burst loop in mana_tx_burst() to terminate
with break instead of continue upon packet errors. Under the DPDK
rte_eth_tx_burst() API contract, callers expect a contiguous prefix of
transmitted packets. Skipping a packet caused unsent packets to be treated
as unsent and freed by caller, followed by a second free upon hardware CQE
arrival.

Patch 2 adds support for hardware TCP Segmentation Offload (TSO),
formatting SGL entries with packet headers in SGE0, handling GDMA work
request flags, advertising RTE_ETH_TX_OFFLOAD_TCP_TSO, and updating
the mana driver feature table.

Tathagat Priyadarshi (2):
  net/mana: fix transmit burst error handling
  net/mana: add hardware TSO support

 doc/guides/nics/features/mana.ini |   1 +
 drivers/net/mana/gdma.c           |   5 +
 drivers/net/mana/mana.h           |   6 +-
 drivers/net/mana/tx.c             | 179 +++++++++++++++++++++++++-----
 4 files changed, 163 insertions(+), 28 deletions(-)

-- 
2.43.0

