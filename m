Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9C606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=keU8ljwD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCE44402BC;
	Mon,  9 Nov 2026 12:27:02 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 2DCB94026E;
 Mon,  9 Nov 2026 12:27:02 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 839BC20329F2;
 Mon, 09 Nov 2026 16:27:01 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 804EB20326BE;
 Mon, 09 Nov 2026 16:26:58 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 804EB20326BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794223620; bh=B9SB49DKAhA8ZU2a6IiF+VLLsFcVkh/WCxJ+2Adc4kA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=keU8ljwDZyyPRRWe2DVE7gYCc+4/5AtdttAatDPKSiJLGMn6AqzjEJK2HcPvwytUi
 Dq8TBua/i9dYQpj3MYlFFYwoNWSVxARgRDINV0rGwbCYY1E+L9AAW48sGF99kAkqLV
 67KJqEjHFHbNjpfPEbhG3q38Al63a9EFhCY5lTmaBqng9eQX4b4NZz4+v9qNP8eq8t
 nqiCpuSBRlZgC2PvDDABGHDH/97BO1QXylx/G5vcBhn1Mt7js221hDjz2KXczfY02B
 KgNkU6nBz289n31is6XG2HBJRKV9RkW2ULIS8g0nf2ZSMtr+2PhkFR90FTiKAbBh0C
 /PtL08HmHwpdw==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jiayu Hu <hujiayu.hu@foxmail.com>, thomas@monjalon.net,
 stable@dpdk.org, Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: Re: [PATCH v2] gro: fix packet type comparisons
Date: Mon,  9 Nov 2026 16:26:57 +0500
Message-ID: <20261109112657.106114-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65AF0@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65AF0@smartserver.smartshare.dk>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Morten,

We hit the same issue while fuzzing lib/gro: with both
RTE_GRO_IPV4_VXLAN_TCP_IPV4 and RTE_GRO_IPV4_VXLAN_UDP_IPV4 enabled,
fragments of inner UDP in VXLAN match IS_IPV4_VXLAN_TCP4_PKT()
(RTE_PTYPE_INNER_L4_FRAG includes the RTE_PTYPE_INNER_L4_TCP bit),
are rejected by gro_vxlan_tcp4_reassemble(), and never reach the
VXLAN UDP path, so they are not merged.

With two fragments of one inner UDP datagram, packet_type taken from
rte_net_get_ptype(), rte_gro_reassemble_burst() returns:
- without the patch: 2 with both VXLAN types, 1 with VXLAN UDP only;
- with the patch: 1 in both cases.

Tested on 25.11.2 with a standalone program and our fuzzing corpus
for gro/gso, no regressions.

Tested-by: Andrey Mokrushin <a.mokrushin@ideco.ru>

